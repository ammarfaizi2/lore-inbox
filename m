Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbVIKWwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVIKWwX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVIKWwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:52:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33257 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750996AbVIKWwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:52:22 -0400
Date: Mon, 12 Sep 2005 00:51:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch] Add suspend/resume support to locomo.c
Message-ID: <20050911225140.GA27349@elf.ucw.cz>
References: <20050721052558.GD7849@elf.ucw.cz> <20050904113600.C30509@flint.arm.linux.org.uk> <20050906075853.GA3883@elf.ucw.cz> <41294.192.168.0.13.1126222148.squirrel@192.168.0.2> <20050910223805.GC1836@elf.ucw.cz> <20050911203445.GB3288@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911203445.GB3288@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Pavel, perhaps you could send me an email about what you (and others) have
> > > done the past few weeks?  The patches on my site and such are probably a
> > > ways out of date.  What/where is the latest code located?   What progress
> > > has been made...  Hopefully sometime next week I can start working on this
> > > stuff again.
> > 
> > [I have just came back from 3 days horse trip... you'll get replies to
> > other mails later.]
> > 
> > There's git tree at www.kernel.org/git ... its called linux-z. It
> > worked for before I got to 2.6.13, but it is now broken (IIRC, maybe
> > its okay). PCMCIA never worked for me. linux-z is probably good start
> > for new work. It should have all your patches IIRC.
> 
> Okay, it was really stupid problem, I #if-0ed collie-specific code. No
> wonder it did not boot. I'll start push to kernel.org but it will take
> a while. FYI, bigdiff against mainline is attached, split version will
> appear on kernel.org in few hours.

Okay, I played a bit with Richard's patches, and broke my tree
again. Last good one is 

commit 4c8a125f9906fda6a43224ad0bad99a8583eb488
tree 14796040835cd69c635dc4b15430b49e2721630b
parent fc0058795a7bd2a9b87e7368dc30ad6701888c7b
author <pavel@amd.(none)> Sun, 11 Sep 2005 23:30:36 +0200
committer <pavel@amd.(none)> Sun, 11 Sep 2005 23:30:36 +0200

    Remove include/asm-arm/arch-sa1100/ucb1x00.h and fix stuff that breaks.


								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
