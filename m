Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSH0WJl>; Tue, 27 Aug 2002 18:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSH0WJl>; Tue, 27 Aug 2002 18:09:41 -0400
Received: from 24-148-63-229.na.21stcentury.net ([24.148.63.229]:41320 "HELO
	wotke.danapple.com") by vger.kernel.org with SMTP
	id <S317302AbSH0WJk>; Tue, 27 Aug 2002 18:09:40 -0400
To: linux-kernel@vger.kernel.org
Cc: robert@schwebel.de
Subject: Boot & VM problems 2.4.14-2.5.31
From: "Daniel I. Applebaum" <kernel@danapple.com>
Date: Tue, 27 Aug 2002 17:13:50 -0500
Message-Id: <20020827221355.18FFE111F0@wotke.danapple.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, let me start over.  I have three different problems with running
Linux on my system.  The first is that I can't rip audio CDs.
Mounting data CDs works just fine, but when ripping audio, I get all
sorts of interrupt time outs.  I decided I'd try to track that down on
my own, but figured I should start with a recent kernel.

But, when updating to 2.4.14, I get an Oops, as soon as the system
starts to page.  This was discussed last November, but never resolved.
Not being a VM hacker (fixing the CD would be a big step for me), I
gave up.

When using a kernel 2.4.15-pre3 or later, the system won't even boot.
LILO reports "Loading", but the kernel never reports "Uncompressing".
I've tried multiple kernels, including RedHat's 2.4.18, to no avail.
My 2.4.19 boots fine in VMware.

In summary:
2.2.16 through 2.4.13 (and maybe through 2.4.14-pre2): 
       boot and run, audio ripping fails
2.4.14 through 2.4.15-pre2: boot but will not page properly
2.4.15-pre3 through 2.5.31: will not boot

The system is an IBM xSeries 200 server with a 667 MHz Celeron, 3ware
6400 controller (latest firmware) with 2 15GB drives and 2 100GB
drives; 1.5GB of Crucial memory; TR5 tape, floppy, Samsung CD, Teac
CD-RW.

I'm willing to do some experiments, but need some direction.

Dan.
