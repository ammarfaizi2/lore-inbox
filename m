Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTAAQk5>; Wed, 1 Jan 2003 11:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbTAAQk5>; Wed, 1 Jan 2003 11:40:57 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1408 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S267277AbTAAQk4>;
	Wed, 1 Jan 2003 11:40:56 -0500
Date: Wed, 1 Jan 2003 11:49:19 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] ctxbench and SYSENTER discussion
Message-ID: <Pine.LNX.4.44.0301011128250.1193-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I changed the report generator for ctxbench slightly after the recent 
discussions of system call methods. I added a column of context loop rate 
divided by MHz of the processor, and ran on the same or similar 2.4 
kernels (this is a hardware thing, version matters only a little).

What it showed was a piss-poor value for the P4, best for my old P-II 
Celeron, and Athlon vs. P-III closely swapping third place. In fact the P4 
had a value about 3x slower than the P-II.

If someone wants to run the benchmark with the old and new system call 
setup it might be useful to quantify the gain.

Benchmark is at www.unyuug.org/benchmarks, and if someone tests this I'd 
like a copy of the raw results for my collection as well as the extract 
posted to lkml.

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


