Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277905AbRJISzJ>; Tue, 9 Oct 2001 14:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277907AbRJISzA>; Tue, 9 Oct 2001 14:55:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26720 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277905AbRJISyv>; Tue, 9 Oct 2001 14:54:51 -0400
Date: Tue, 9 Oct 2001 20:55:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Robert Macaulay <robert_macaulay@dell.com>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: 2.4.11pre6aa1
Message-ID: <20011009205516.F724@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation faliures with highmem seems cured (at least under heavy
emulation, didn't tested real hardware yet).  Robert, could you give it
a spin and see if you can still reproduce the faliures now?

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.11pre6aa1.bz2

Thanks,

--
Only in 2.4.11pre3aa1: 00_3.5G-address-space-1
Only in 2.4.11pre6aa1: 00_3.5G-address-space-2

	Rediffed.

Only in 2.4.11pre3aa1: 00_debug-gfp-1
Only in 2.4.11pre6aa1: 10_debug-gfp-1

	Renamed.

Only in 2.4.11pre6aa1: 00_rb-export-1

	Patch from Mark J Roberts to export the rb library function to modules
	(he's using rb trees in a module).

Only in 2.4.11pre3aa1: 00_rwsem-fair-20
Only in 2.4.11pre3aa1: 00_rwsem-fair-20-recursive-4
Only in 2.4.11pre6aa1: 00_rwsem-fair-22
Only in 2.4.11pre6aa1: 00_rwsem-fair-22-recursive-4

	Rediffed.

Only in 2.4.11pre3aa1: 00_unmap-dirty-pte-2

	Dropped, it generated a false positive on s390 that implements
	slightly different semantics for pte_dirty (using per-page
	physical dirty bitflag maintained by hardware).

Only in 2.4.11pre6aa1: 00_vm-1
Only in 2.4.11pre3aa1: 00_vm-tweaks-3

	Allocation faliures with highmem should be cured. Swap seems
	smooth and Andrew's workload also seems ok. Still untested
	on real highmem at the moment and I'd love feedback on it.
	I will be able to test very soon on real highmem too thanks
	to osdlab.org resources.

Only in 2.4.11pre3aa1: 10_highmem-debug-4
Only in 2.4.11pre6aa1: 10_highmem-debug-5

	Rediffed.

Only in 2.4.11pre3aa1: 10_numa-sched-10
Only in 2.4.11pre6aa1: 10_numa-sched-11

	Rediffed.

Only in 2.4.11pre3aa1: 50_uml-patch-2.4.10-5.bz2
Only in 2.4.11pre6aa1: 50_uml-patch-2.4.10-6.bz2
Only in 2.4.11pre6aa1: 52_uml-export-objs-1

	Picked last update from sourceforge.

Andrea
