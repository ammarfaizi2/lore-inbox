Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUG2XCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUG2XCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUG2W71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:59:27 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39401 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S267517AbUG2W4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:56:00 -0400
Date: Thu, 29 Jul 2004 15:55:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: How to debug 2.6 PReP boot hang?
Message-ID: <20040729225559.GJ16468@smtp.west.cox.net>
References: <Pine.GSO.4.44.0407281213400.6874-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0407281213400.6874-100000@math.ut.ee>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 12:19:42PM +0300, Meelis Roos wrote:

> I have a Motorola Powerstack II Pro4000 that has PReP and OF and is not
> booting in 2.6. I hangs very early, the display stays in OF graphics
> mode and nothing is printed. So it does not reach vga_init in
> load_kernel, and I'm not sure it even reaches load_kernel.

My suggestion is to go back in releases until one does work, see where
the changes are that break it, and work from there.  It should be
possible to fix what broke. :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
