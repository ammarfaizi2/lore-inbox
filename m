Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291522AbSBHKDb>; Fri, 8 Feb 2002 05:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291525AbSBHKDW>; Fri, 8 Feb 2002 05:03:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6966 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291522AbSBHKDO>; Fri, 8 Feb 2002 05:03:14 -0500
Date: Fri, 8 Feb 2002 11:04:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.21pre2aa1
Message-ID: <20020208110422.E10496@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.21pre2aa1.gz
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.21pre2aa1/

Only in 2.2.20aa1: 00_PIII-11.bz2
Only in 2.2.21pre2aa1: 00_PIII-12.gz

	Dediffed due rejects.

Only in 2.2.20aa1: 00_SIGIO-reason-2.bz2
Only in 2.2.21pre2aa1: 00_SIGIO-reason-2.gz
Only in 2.2.20aa1: 00_SMP-scheduler-2.2.18pre21-H.bz2
Only in 2.2.21pre2aa1: 00_SMP-scheduler-2.2.18pre21-H.gz
Only in 2.2.20aa1: 10_bigmem-2.2.20pre10aa1-22.bz2
Only in 2.2.21pre2aa1: 10_bigmem-2.2.20pre10aa1-22.gz
Only in 2.2.20aa1: 13_rawio-2.2.19aa2-9.bz2
Only in 2.2.21pre2aa1: 13_rawio-2.2.19aa2-9.gz
Only in 2.2.20aa1: 15_lvm-0.9.1_beta4-2.2.19pre13aa1-6.bz2
Only in 2.2.21pre2aa1: 15_lvm-0.9.1_beta4-2.2.19pre13aa1-6.gz
Only in 2.2.20aa1: 40_lfs-2.2.20pre10aa1-28.bz2
Only in 2.2.21pre2aa1: 40_lfs-2.2.20pre10aa1-28.gz
Only in 2.2.20aa1: 93_raid-2.2.18-A2_2.2.20pre2aa1-8.bz2
Only in 2.2.21pre2aa1: 93_raid-2.2.18-A2_2.2.20pre2aa1-8.gz
Only in 2.2.20aa1: 94_raidrebalance-2.2.18-A2_2.2.19pre3aa1-Mika-Kuoppala-1.bz2
Only in 2.2.21pre2aa1: 94_raidrebalance-2.2.18-A2_2.2.19pre3aa1-Mika-Kuoppala-1.gz
Only in 2.2.20aa1: 95_GFS-11_hard_panic.patch-1.bz2
Only in 2.2.21pre2aa1: 95_GFS-11_hard_panic.patch-1.gz
Only in 2.2.20aa1: 95_GFS-12_opaque-inode-2.bz2
Only in 2.2.21pre2aa1: 95_GFS-12_opaque-inode-2.gz

	s/bz2/gz/

Only in 2.2.20aa1: 00_alpha-pci-compile-1
Only in 2.2.21pre2aa1: 00_alpha-pci-compile-2

	Rediffed due rejects.

Only in 2.2.20aa1: 00_local-freelist-race-1

	Merged in mainline.

Only in 2.2.21pre2aa1: 00_st_blocks-1

	Fix for postfix on pipes from Andi.

Only in 2.2.21pre2aa1: 98_page-coloring-1

	Perfect static page coloring implementation. I extracted the O(1)
	engine implemented within the page allocator from a patch
	written by Jason Papadopoulos, that was a very nice piece of code.
	Such patch was implementing a per-process dynamic page coloring, this
	instead is static page coloring, it colors anonymous ram, shm (during
	page faults), pagecache in function of the virtual address in ->nopage,
	and pagecache in function of the file offset/index when the pagecache
	is allocated by read/write. It does static page coloring similarly to
	another patch from Sebastien Cabaniols. It's a configuration option (currently
	it must be used as a module, furthmore the module is mixed with the
	chardevices, I didn't claned up such module thing because it doesn't matter
	at runtime, it's all slow-path code, it's only needed to enable the
	page-coloring code linked into the kernel, but for a 2.[45] version
	such part needs to be cleaned up). Tested only on alpha so far but
	it should be completly arch indipendent (btw, the L2 cache size
	must be passed as paramter to the module, if no parameter is passed you
	can see the selected defaults in the sourcecode, there's no
	auto-detection of the size of the l2 cache).

Andrea
