Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270396AbTGMU6t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270395AbTGMU6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:58:49 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:31180 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S270405AbTGMU5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:57:43 -0400
Date: Sun, 13 Jul 2003 22:12:27 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Anthony Lichnewsky <lich@tuxfamily.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 doesn't boot at all on x86
Message-ID: <20030713211227.GA16127@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Anthony Lichnewsky <lich@tuxfamily.org>,
	linux-kernel@vger.kernel.org
References: <3F1163A7.6010004@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1163A7.6010004@tuxfamily.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 03:50:31PM +0200, Anthony Lichnewsky wrote:
 > After lilo, the kernel is uncompressed, then the screen goes black.
 > the traditional init message is not even displayed
 > ( INIT version 2.85 booting ).
 > It accepts Ctrl+Alt+Suppr for reboot. but that's it.
 > 
 > I checked that CONFIG_VT, CONFIG_VGA_CONSOLE are set in my .config.
 > I suspect the initrd image is not loaded correctly, but I don't have any
 > real clue. It was generated with mkinitrd version 3.4.43.
 > Any Idea of what it might be ?

Try CONFIG_VIDEO_SELECT=n. If that doesn't help, post your .config.
(That config option really needs to tighten up what it does in
 its EDID parser, see http://www.cs.helsinki.fi/linux/linux-kernel/2003-20/0572.html
 which still isn't fixed...)

		Dave
