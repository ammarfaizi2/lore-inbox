Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281787AbRLBVP5>; Sun, 2 Dec 2001 16:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRLBVPr>; Sun, 2 Dec 2001 16:15:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12548 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279305AbRLBVPj>; Sun, 2 Dec 2001 16:15:39 -0500
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
To: lm@bitmover.com (Larry McVoy)
Date: Sun, 2 Dec 2001 21:24:07 +0000 (GMT)
Cc: vonbrand@sleipnir.valparaiso.cl (Horst von Brand),
        lm@bitmover.com (Larry McVoy), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <20011202122940.B2622@work.bitmover.com> from "Larry McVoy" at Dec 02, 2001 12:29:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Ae5n-0004bW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Just as Linus said, the development is shaped by its environment.
> 
> Really?  So then people should be designing for 128 CPU machines, right?

Linux environment is a single athlon/pii type processor with 128-256Mb of
RAM, because quite simply thats what most developers have.

> So why is it that 100% of the SMP patches are incremental?  Linux is 
> following exactly the same path taken by every other OS, 1->2, then 2->4,
> then 4->8, etc.  By your logic, someone should be sitting down and saying
> here is how you get to 128.  Other than myself, noone is doing that and
> I'm not really a Linux kernel hack, so I don't count.  

The problem being that unless you happen to have a load of people with 128
processor boxes you can't verify your work is even useful or correct. 

You can look at Linux development and the areas which have been heavily
funded rather than written for fun/need by people and you'll see a heavy
slant to the enterprise end. J Random Hacker doesn't have an IA64, an 8 way
SMP box or 2Tb of disk so J Random Hacker is much more interested in making
sure his/her webcam works (which is why we pee all over Solaris X86 on device 
support).

Alan
