Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbTIJT0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbTIJTXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:23:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2065 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265659AbTIJTVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:21:35 -0400
Date: Wed, 10 Sep 2003 20:21:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Multiple configuration support
Message-ID: <20030910202132.I30046@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
References: <20030909192918.GA2933@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030909192918.GA2933@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Sep 09, 2003 at 09:29:18PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 09:29:18PM +0200, Sam Ravnborg wrote:
> boardconfig should be very simple, only including delta to the
> default configuration.

The delta is going to be fairly large for ARM - it doesn't make sense
to have a default core configuration and per-board deltas.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
