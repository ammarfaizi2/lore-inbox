Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbRE2PUW>; Tue, 29 May 2001 11:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbRE2PUN>; Tue, 29 May 2001 11:20:13 -0400
Received: from zeus.kernel.org ([209.10.41.242]:23691 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261639AbRE2PTy>;
	Tue, 29 May 2001 11:19:54 -0400
Date: Tue, 29 May 2001 11:19:20 -0400 (EDT)
From: aaron <aaron@stasis.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: VIA Samuel problem? 2.2.19,2.4.4
Message-ID: <Pine.LNX.4.33.0105291119040.2793-100000@mk2.stasis.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am experiencing an interesting problem with a VIA Samuel (Cyrix III) 667
processor, on an M755LMR motherboard (GFXcel sis630e chipset) 64M ram.
Unfortunately I don't have access to another socket370 mobo to test right
now.  Anyways, when left running over a 24 hour period, performance
seriously degrades. This happens on both stock 2.2.19 (M586TSC) and 2.4.4
(MCYRIXIII) kernels. We have tested AMD's, PIII's and Celeron's all on
the same board, same setup without a problem.

using the byte nbench benchmark for example, when freshly booted the
machine gets an integer index of 5.238, and a floating-point index of
2.307.  After 24 hours, that integer index drops to 1.96, the floating
point to 0.863.  We first noticed the problem when testing network
throughput, which drops similarly.  A simple reboot (warm or cold) fixes
the problem.  No kernel error messages are appearing in the logs.

I can't find any mention of this in the lkml archives. The cyrix howto
seems horribly out of date.  Is this a known problem?  Something
non-linux related?  Any suggestions as to how I can start
to debug this or narrow down the problem would be much appreciated.

---
Aaron Barnes




