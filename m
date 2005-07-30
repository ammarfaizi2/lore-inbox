Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263170AbVG3Ubb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbVG3Ubb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbVG3U2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:28:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63244 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263161AbVG3U22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:28:28 -0400
Date: Sat, 30 Jul 2005 21:28:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mark Underwood <basicmark@yahoo.com>
Cc: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ucb1x00: touchscreen cleanups
Message-ID: <20050730212820.G26592@flint.arm.linux.org.uk>
Mail-Followup-To: Mark Underwood <basicmark@yahoo.com>,
	Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050730102236.B9652@flint.arm.linux.org.uk> <20050730113350.62722.qmail@web30304.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050730113350.62722.qmail@web30304.mail.mud.yahoo.com>; from basicmark@yahoo.com on Sat, Jul 30, 2005 at 12:33:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 12:33:50PM +0100, Mark Underwood wrote:
> > > Now I have my kernel up and running (well
> > > mainly falling :-() my next task is to get write
> > the
> > > frame buffer driver and then look at the UCB1x00
> > as I
> > > need it for sound and touch screen. So in a day or
> > two
> > > I will start to try to integrate your work into my
> > > kernel.
> > 
> > Note that I'm maintaining the code and will be
> > publishing a new set
> > of patches for it based upon Pavel's fixes.
> 
> Thanks. I'll check them out then.

Since there appears to be some interest in these, I'll set about
converting the audio bits to ALSA rather than Nico's SA11x0 audio
driver.  I thought no one was using these chips anymore, and the
driver was dead!

I've recently edited the mcp structure which may make things less
awkward for others, and I'll continue moving in that direction
with this driver.

You can get the updated patches at:

	http://zeniv.linux.org.uk/pub/people/rmk/ucb/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
