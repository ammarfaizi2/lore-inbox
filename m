Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSFWWdX>; Sun, 23 Jun 2002 18:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSFWWdW>; Sun, 23 Jun 2002 18:33:22 -0400
Received: from jalon.able.es ([212.97.163.2]:31936 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317165AbSFWWdV>;
	Sun, 23 Jun 2002 18:33:21 -0400
Date: Mon, 24 Jun 2002 00:33:13 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.19-pre10-jam3
Message-ID: <20020623223313.GA1639@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all..

Now that vm and O1 both are on -aa tree, these are just marginal patches
(apart from the ide patch). Also, the mix of -aa, some patches (irqrate,
smptimers) and bproc was bombing (I had lockups removing modules or at
spurious times), so I have removed both (irqrate, scalable-timers).

URL:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre10-jam3.tar.gz

Extract from contents:

00-aa-pre10aa4.bz2
	-aa tree patch.

02-swap-fix.bz2
03-tmpfs-fix.bz2
	Fixes for swap (memleak, unsafe BUG()s, redundant checks)
	and tmpfs (symlinks,directory itimes, truncate, swapoff speedup)
	Author: Hugh Dickins <hugh@veritas.com>

04-tux-stats.bz2
	Remove empty tux stats if tux is not built.
	Author: Randy Hron <rwhron@earthlink.net>

10-config-nr_cpus.bz2
	Configure the max number of cpus at compile time (default was 32).
	Saves memory footprint for kernel (around 240Kb in 32->2).
	Author: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>

11-mem-barriers.bz2
	Use specific machine level instructions for mb() for new
	processors (P3,P4,Athlon).
	Author: Zwane Mwaikambo <zwane@linux.realnet.co.sz>

12-p2-split.bz2
3-gcc3-march.bz2
	Makefile games

20-sched-hints.bz2
	Hint-based scheduling on top of O1 scheduler.
	Authonr: Robert Love <rml@tech9.net>

30-shared-zlib.bz2
40-ide-10.bz2

41-severworks-ide.bz2
	Attempt to fix the ServerWorks problem with certain disks and DMA.
	Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>

42-ide-cd-dma-3.bz2
70-i2c-2.6.4-20020806.bz2
71-sensors-2.6.4-20020806.bz2
80-bproc-3.1.10.bz2
81-export-task_nice.bz2
90-make.bz2

Enjoy !!

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-pre10-jam3, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.6mdk)
