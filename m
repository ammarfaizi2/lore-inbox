Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269433AbRHGU5U>; Tue, 7 Aug 2001 16:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269435AbRHGU5L>; Tue, 7 Aug 2001 16:57:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31319 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269433AbRHGU47>; Tue, 7 Aug 2001 16:56:59 -0400
Date: Tue, 7 Aug 2001 22:58:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8pre5aa1
Message-ID: <20010807225810.A688@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.4.8pre3aa1 and 2.4.8pre5aa1:

Moved on top of 2.4.8pre5.

Only in 2.4.8pre5aa1: 00_alloc_skb-gfp_dma-1

	Allow skb metadata to be always allocated in the normal classzone.

Only in 2.4.8pre5aa1: 00_alloc_skb-gfp_dma-bugcheck-1

	Trap anybody calling kmem_cache_alloc with __GFP_DMA on a non DMA slab,
	plus the other way around.

Only in 2.4.8pre5aa1: 00_alpha-fp-disabled-1

	local DoS fix (if fpu disabled via palcode) from Daniel Potts.

Only in 2.4.8pre5aa1: 00_alpha-illop-1

	kill task with illegal opcode from Rick Gorton.

Only in 2.4.8pre5aa1: 00_alpha-mips-rtc-1

	Alpha epoch guess updates from Christopher C. Chimelis.

Only in 2.4.8pre5aa1: 00_alpha-smp_tune_scheduling-1

	Christopher C. Chimelis reported some machine has trouble with the
	tune_scheduling function, so updated to take care of the cpuid of the
	boot cpu.

Only in 2.4.8pre3aa1: 00_backout-local_bh_enable-debug-1
Only in 2.4.8pre3aa1: 00_gcc-30-aironet-1
Only in 2.4.8pre3aa1: 00_via-quirks-1

	Merged in mainline.

Only in 2.4.8pre3aa1: 00_gcc-30-extern-static-2
Only in 2.4.8pre5aa1: 00_gcc-30-extern-static-3

	Part of it merged in mainline so rediffed the rest.

Only in 2.4.8pre3aa1: 00_ksoftirqd-7_ia64-2

	ia64 is in sync in mainline.

Only in 2.4.8pre3aa1: 00_lvm-0.9.1_beta7-5.bz2
Only in 2.4.8pre3aa1: 00_lvm-0.9.1_beta7-5_rwsem-fast-path-2
Only in 2.4.8pre5aa1: 00_lvm-0.9.1_beta7-6.bz2
Only in 2.4.8pre5aa1: 00_lvm-0.9.1_beta7-6_rwsem-fast-path-2

	Fix 64bit archs IOP (again).

Only in 2.4.8pre3aa1: 00_o_direct-11
Only in 2.4.8pre5aa1: 00_o_direct-12

	Microoptimization, more a code-beauty cleanup (noticed by Anton
	Altaparmakov).

Only in 2.4.8pre3aa1: 00_rwsem-16
Only in 2.4.8pre5aa1: 00_rwsem-17

	Rediffed (didn't had time to check the asm version yet, after all it is
	going to make a so small global performance difference in any real
	benchmark).

Only in 2.4.8pre5aa1: 40_blkdev-pagecache-10
Only in 2.4.8pre3aa1: 40_blkdev-pagecache-8

	Reduced granularity to 1k and be pedantic about the last bytes of the
	blkdev, plus added further compatibility cruft so it can be used
	without surprises in 2.4 (to make an example O_APPEND was ignored by
	the buffer cache backed code and there are just application that get
	confused by O_APPEND being honoured by the pagecache common code in
	generic_file_write...).

Only in 2.4.8pre3aa1: 50_uml-2.4.7-1.bz2
Only in 2.4.8pre5aa1: 50_uml-2.4.7-3.bz2

	Upgraded to -3 revision from Jeff.

Only in 2.4.8pre3aa1: 60_pagecache-atomic-1
Only in 2.4.8pre5aa1: 60_pagecache-atomic-2

	Rediffed due rejects.

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.8pre5aa1/
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.8pre5aa1.bz2

Andrea
