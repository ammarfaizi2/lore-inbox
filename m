Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267708AbSLGC2l>; Fri, 6 Dec 2002 21:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267707AbSLGC2l>; Fri, 6 Dec 2002 21:28:41 -0500
Received: from gen3-newburypark5-192.vnnyca.adelphia.net ([207.175.226.192]:11767
	"EHLO dave.home") by vger.kernel.org with ESMTP id <S267708AbSLGC2k>;
	Fri, 6 Dec 2002 21:28:40 -0500
Date: Fri, 6 Dec 2002 18:36:16 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200212070236.gB72aG513528@dave.home>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.18 beats 2.5.50 in hard drive access????
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ok that would explain why DMA is off on it. The disk puzzles me - for an
>OSB4 the code should be selecting MWDMA2

In the BIOS I tried AUTO on all the drives. I have to explicitly enable
32 bit IO in the bios for each drive, it came up default off. I just enabled
it because 32 bit IO sounded better, but maybe it's not. I didn't try it
with it off. I also tried USER on all the drives where I can then set
the IO mode. There were 5 PIO settings possible plus 2 DMA things, which
I think were UDMA but I can't recall exactly. On all of those I chose the
UDMA2. Otherwise all the settings were identical to what AUTO set them.

Whether AUTO or USER made no difference in performance or in the kernel
messages.

I also have multi device support/raid 0/raid 5 enabled. The drives are
not partitioned, I use the drive itself in the /dev/md0 array. That's
why I get the kernel partition error messages.

I can try some stuff (except a reboot, until Monday). I'm off site now and
can't bring the machine down, but harmless experiments are ok, if there is
anything you want me to try.

-Dave
