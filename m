Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262081AbRE2VrK>; Tue, 29 May 2001 17:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262084AbRE2Vqv>; Tue, 29 May 2001 17:46:51 -0400
Received: from 213.237.80.42.adsl.he.worldonline.dk ([213.237.80.42]:9531 "EHLO
	udgaard.com") by vger.kernel.org with ESMTP id <S262081AbRE2Vqp>;
	Tue, 29 May 2001 17:46:45 -0400
Date: Tue, 29 May 2001 23:49:41 +0200
From: Peter Rasmussen <plr@udgaard.com>
Message-Id: <200105292149.XAA01229@udgaard.com>
To: linux-kernel@vger.kernel.org
Subject: Swap problems persisting?
Cc: plr@udgaard.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read in KT that virtual memory is a problem in recent 2.4 kernels.

I found myself in trouble with sudden shutdowns while playing DVDs (LiViD) and sometimes
running Mozilla 0.8.1 simultaneously, but running mozilla wasn't always necessary.

That was with all 2.4.5 and following ac kernels. I had performance troubles with 2.4.4
so I couldn't really push those, ie. the problems could be there as I well.

It seems though (from my perspective) that cutting out shmem and DRI stabilizes it a 
whole lot.

Right now I'm running 2.4.5-ac4 and have after a few hours not been able to crash it. I 
made it without DRI and support for shmem fs.

Are there still known problems with those, ie. /dev/shmem and DRI?

I have an ATI Rage Fury 128 with XFree86 4.0.2 in case it matters.

Please cc: me in case you reply, as I'm not on the list.

Thanks,

Peter

P.S. I always go back to 2.4.1 that was rock solid and the fastest kernel yet for my
     system :-)
