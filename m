Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281609AbRKVUcD>; Thu, 22 Nov 2001 15:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281719AbRKVUbx>; Thu, 22 Nov 2001 15:31:53 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6418 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281609AbRKVUbj>; Thu, 22 Nov 2001 15:31:39 -0500
Date: Thu, 22 Nov 2001 21:31:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15pre9aa1
Message-ID: <20011122213158.B1324@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This will fix the highmem machines (see the comments on the
block-highmem changes for more details). Thanks to Jens for finding the
main culprit.

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre9aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre9aa1/

Only in 2.4.15pre7aa1: 00_alpha-fp-disabled-2

	Better fix in mainline.

Only in 2.4.15pre9aa1: 00_blkdev-close-1

	Avoid synchronous fsync on close if it's not the last one. (fix from
	Miquel van Smoorenburg)

Only in 2.4.15pre7aa1: 00_block-highmem-all-18-1.bz2
Only in 2.4.15pre9aa1: 00_block-highmem-all-18b.bz2

	Latest update from Jens (fixed on critical bug).

Only in 2.4.15pre9aa1: 10_block-highmem-all-18b-1

	Try to be more conservative in the elevator/queuesize and better fix
	the -17 critical bug so that it works with discontigmem too, and fix an
	off-by one error that can lead to corruption in the compatibility
	drives as well.

Only in 2.4.15pre9aa1: 00_flush_icache_range-1

	Avoid cache flush on pageins on alpha (from Paul Mackerras).

Only in 2.4.15pre7aa1: 00_o_direct-5

	Merged in mainline.

Only in 2.4.15pre7aa1: 00_rcu-poll-2
Only in 2.4.15pre9aa1: 00_rcu-poll-3
Only in 2.4.15pre7aa1: 00_rwsem-fair-24-recursive-5
Only in 2.4.15pre9aa1: 00_rwsem-fair-24-recursive-6
Only in 2.4.15pre7aa1: 10_numa-sched-13
Only in 2.4.15pre9aa1: 10_numa-sched-14

	Rediffed due rejects.

Only in 2.4.15pre7aa1: 10_vm-15
Only in 2.4.15pre9aa1: 10_vm-16

	Some more minor tweak (in short: swap less).

Only in 2.4.15pre7aa1: 60_tux-2.4.13-ac5-B1.bz2
Only in 2.4.15pre9aa1: 60_tux-2.4.15-pre9-B1.bz2

	Latest update from Ingo at www.redhat.com/~mingo/.

Only in 2.4.15pre7aa1: 60_tux-vfs-2
Only in 2.4.15pre9aa1: 60_tux-vfs-3

	Update to the cleaner and generic d_extra_attributes needed by the new
	tux core.

Andrea
