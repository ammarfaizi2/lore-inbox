Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbULLUlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbULLUlu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbULLUlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:41:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12549 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262123AbULLUl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:41:28 -0500
Date: Sun, 12 Dec 2004 21:41:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Robert Picco <Robert.Picco@hp.com>
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ia64 smpboot.c: remove an unused function
Message-ID: <20041212204117.GV22324@stusta.de>
References: <20041212193921.GA22324@stusta.de> <41BCAE31.7030702@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BCAE31.7030702@hp.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 03:46:41PM -0500, Robert Picco wrote:
> Adrian Bunk wrote:
> 
> >The patch below removes an unused global functions.
> >
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> >--- linux-2.6.10-rc2-mm4-full/arch/ia64/kernel/smpboot.c.old	2004-12-12 
> >02:51:04.000000000 +0100
> >+++ linux-2.6.10-rc2-mm4-full/arch/ia64/kernel/smpboot.c	2004-12-12 
> >02:51:18.000000000 +0100
> >@@ -356,11 +356,6 @@
> >	return cpu_idle();
> >}
> >
> >-struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
> >-{
> >-	return NULL;
> >-}
> >-
> >struct create_idle {
> >	struct task_struct *idle;
> >	struct completion done;
> >
> > 
> >
> I don't believe this is unused.  At least not in 2.6.10-rc3.  fork_idle 
> requires this function.

Ups sorry, you are correct.

For some strange reason I missed.

> Bob

Thanks for the correction
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

