Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbRFTNpA>; Wed, 20 Jun 2001 09:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbRFTNou>; Wed, 20 Jun 2001 09:44:50 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:37648 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264877AbRFTNoi>; Wed, 20 Jun 2001 09:44:38 -0400
Date: Wed, 20 Jun 2001 15:44:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6pre3aa2
Message-ID: <20010620154430.D22569@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.4.6pre3aa1 and 2.4.6pre3aa2:

Only in 2.4.6pre3aa2: 00_alpha-numa-initrd-1

	Release initrd memory from right numa node.

	(recommended)

Only in 2.4.6pre3aa2: 00_alpha-srm-2.4.6-pre1-1

	Access the srm variables via /proc/srm_environment.
	Patch posted to l-k by Jan-Benedict Glaw <jbglaw@lug-owl.de>.

	(nice to have)

Only in 2.4.6pre3aa2: 00_initrd-release-blkdev-1

	Remeber to release the opened blkdev after initrd load.

	(recommended)

Only in 2.4.6pre3aa2: 00_ksoftirqd-6_ia64-1
Only in 2.4.6pre3aa2: 00_ksoftirqd-6_ppc-1

	softirq updates for ppc and ia64.

	(recommended)

Only in 2.4.6pre3aa2: 00_locks-1

	Fix from ac16 (avoid corrupting the lock_depth).

	(recommended)

Only in 2.4.6pre3aa2: 00_max-threads-1

	Each task is going to take more than 2 pages. There's
	also the pid limit and the per-user limit but turning
	the default down is good idea. Fix from Rik from ac16.

	(recommended)

Only in 2.4.6pre3aa2: 00_swapinfo-1

	Only show deviecs when then swap_map is been allocated
	to avoid oops during swapon. Fix from
	Paul Menage <pmenage@ensim.com>.

	(nice to have)

Only in 2.4.6pre3aa1/30_tux: 30_atomic-lookup-3
Only in 2.4.6pre3aa2/30_tux: 30_atomic-lookup-4

	Introduce O_ATOMICLOOKUP for ppc equal to 01000000.

Only in 2.4.6pre3aa2: 40_experimental/40_blkdev-pagecache-3

	Optional patch to apply to move the blkdev from buffercache to
	pagecache. At the moment this breaks the ramdisk and in turn initrd.
	Read the 40_experimental/README for more details. Like the tux patches
	this one is not included into the global diff (2.4.6pre3aa2.{gz,bz2}).

Andrea
