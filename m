Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbSLPOd1>; Mon, 16 Dec 2002 09:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSLPOd1>; Mon, 16 Dec 2002 09:33:27 -0500
Received: from ip67-93-141-186.z141-93-67.customer.algx.net ([67.93.141.186]:34452
	"EHLO datapower.ducksong.com") by vger.kernel.org with ESMTP
	id <S266736AbSLPOd0>; Mon, 16 Dec 2002 09:33:26 -0500
Date: Mon, 16 Dec 2002 09:42:43 -0500
From: "Patrick R. McManus" <mcmanus@ducksong.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Dual Xeon w/ HT: Kernel can't find second CPU
Message-ID: <20021216144243.GA9352@ducksong.com>
References: <233C89823A37714D95B1A891DE3BCE5202AB1AD5@xch-a.win.zambeel.com> <20021212162914.E28629@deltelco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021212162914.E28629@deltelco.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Sent: Friday, December 06, 2002 6:57 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: Re: Dual Xeon w/ HT: Kernel can't find second CPU


I have a similar (but different) problem that I was hoping for help
with.

I can't build a kernel for my dual xeon e7500 board, with
hyperthreading enabled, that sees 4 logical processors. I can boot the
redhat 8 kernel and that sees 4, but my build of  2.4.20-ac2 gets me
'warning sibling not found' messages and just 2 cpus. 

It is built for P4 and has SMP on. Is there anything else I should
have to do? acpismp=force doesn't help (not that it should on 2.4.20
from what I read.)


[..]
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
per-CPU timeslice cutoff: 1462.99 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4797.23 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
Total of 2 processors activated (9581.36 BogoMIPS).
WARNING: No sibling found for CPU 0.
WARNING: No sibling found for CPU 1.
[...]

-Patrick
