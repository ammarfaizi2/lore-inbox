Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265673AbSKFOtg>; Wed, 6 Nov 2002 09:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265674AbSKFOtg>; Wed, 6 Nov 2002 09:49:36 -0500
Received: from [195.223.140.107] ([195.223.140.107]:55940 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265673AbSKFOtf>;
	Wed, 6 Nov 2002 09:49:35 -0500
Date: Wed, 6 Nov 2002 15:56:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20rc1aa1
Message-ID: <20021106145604.GJ3823@x30.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20rc1aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20rc1aa1/

Diff between 2.4.20pre11aa1 and 2.4.20rc1aa1:

Only in 2.4.20rc1aa1: 00_elevator-backmerge-1

	Allow merging at the end when latency is zero.

Only in 2.4.20pre11aa1: 00_extraversion-11
Only in 2.4.20rc1aa1: 00_extraversion-12

	Rediffed.

Only in 2.4.20pre11aa1: 00_module-locking-fix-1
Only in 2.4.20rc1aa1: 00_module-locking-fix-2

	Readd the BKL too, to serialize against module callbacks
	(thanks to Andrew for noticing).

Only in 2.4.20pre11aa1: 00_reduce-module-races-1
Only in 2.4.20rc1aa1: 20_reduce-module-races-1

	Rename.

Only in 2.4.20pre11aa1: 08_qlogicfc-template-aa-4
Only in 2.4.20rc1aa1: 08_qlogicfc-template-aa-5

	Fix qlogic compilation.

Only in 2.4.20pre11aa1: 20_sched-o1-fixes-5
Only in 2.4.20rc1aa1: 20_sched-o1-fixes-8

	Further o1 sched fixes and improvements (on all the benchmarks).

Only in 2.4.20pre11aa1: 9900_aio-12.gz
Only in 2.4.20rc1aa1: 9900_aio-13.gz

	Further fixes, now fully functional with fs and rawio.
	More optimizations coming soon.

Only in 2.4.20pre11aa1: 9910_shm-largepage-5.gz
Only in 2.4.20rc1aa1: 9910_shm-largepage-6.gz

	Fixed, apparently ipc shm just couldn't use largepages at all in the
	original version (VM_BIGPAGE would never be set in the vma so it was
	only a fake that forbidden the vm to touch the SGA possibly showing
	improvements with bad VM algorithms, equivalent to mlock/SHM_LOCK), now
	ipcshm will use real large tlb entries too if the alignment/size
	suggested by userspace is correct (same as in shmfs).

Only in 2.4.20pre11aa1: 9920_kgdb-3.gz
Only in 2.4.20rc1aa1: 9920_kgdb-4.gz

	Allow only the admin to invoke kgdb (noticed by Andrew).

Only in 2.4.20rc1aa1: 9941_ocfs-20021012.gz
Only in 2.4.20rc1aa1: 9942_ocfs-compile-1

	Updated to a recent snapshot.

Andrea
