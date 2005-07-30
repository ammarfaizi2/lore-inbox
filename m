Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbVG3JXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbVG3JXI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 05:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVG3JXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 05:23:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49418 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263023AbVG3JWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 05:22:42 -0400
Date: Sat, 30 Jul 2005 10:22:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mark Underwood <basicmark@yahoo.com>
Cc: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ucb1x00: touchscreen cleanups
Message-ID: <20050730102236.B9652@flint.arm.linux.org.uk>
Mail-Followup-To: Mark Underwood <basicmark@yahoo.com>,
	Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050726074627.GA11975@elf.ucw.cz> <20050726080412.5504.qmail@web30313.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050726080412.5504.qmail@web30313.mail.mud.yahoo.com>; from basicmark@yahoo.com on Tue, Jul 26, 2005 at 09:04:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 09:04:12AM +0100, Mark Underwood wrote:
> I am in the process of porting Linux 2.6.11.5 to the
> Helio PDA (MIPS R3912 based) and if I remember
> correctly it is using a UCB1x00 (or Toshiba clone).
> Please could you make sure your patches will work
> across arch.

Which UCB1x00 version?  There's about three of them - 1200, 1300 and
1400.  The 1200 and 1300 are non-AC'97 devices, which are targetted
by this driver.

> Now I have my kernel up and running (well
> mainly falling :-() my next task is to get write the
> frame buffer driver and then look at the UCB1x00 as I
> need it for sound and touch screen. So in a day or two
> I will start to try to integrate your work into my
> kernel.

Note that I'm maintaining the code and will be publishing a new set
of patches for it based upon Pavel's fixes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
