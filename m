Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSLZA5v>; Wed, 25 Dec 2002 19:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSLZA5u>; Wed, 25 Dec 2002 19:57:50 -0500
Received: from [195.223.140.107] ([195.223.140.107]:1152 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261594AbSLZA5s>;
	Wed, 25 Dec 2002 19:57:48 -0500
Date: Thu, 26 Dec 2002 02:06:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre2aa1
Message-ID: <20021226010605.GA4223@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre2aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre2aa1/

diff between 2.4.20aa1 and 2.4.21pre2aa1:

Only in 2.4.20aa1: 00_extraversion-14
Only in 2.4.21pre2aa1: 00_extraversion-15
Only in 2.4.20aa1: 00_poll-nfds-2
Only in 2.4.21pre2aa1: 00_poll-nfds-3
Only in 2.4.20aa1: 00_readahead-got-broken-somewhere-2
Only in 2.4.21pre2aa1: 00_readahead-got-broken-somewhere-3
Only in 2.4.20aa1: 00_rwsem-fair-33
Only in 2.4.20aa1: 00_rwsem-fair-33-recursive-8
Only in 2.4.21pre2aa1: 00_rwsem-fair-34
Only in 2.4.21pre2aa1: 00_rwsem-fair-34-recursive-8
Only in 2.4.20aa1: 00_sched-O1-aa-2.4.19rc3-5.gz
Only in 2.4.21pre2aa1: 00_sched-O1-aa-2.4.19rc3-7.gz
Only in 2.4.20aa1: 00_sd_softerr-1
Only in 2.4.20aa1: 70_alloc_inode-1
Only in 2.4.21pre2aa1: 70_alloc_inode-2
Only in 2.4.20aa1: 70_delalloc-1
Only in 2.4.21pre2aa1: 70_delalloc-2
Only in 2.4.20aa1: 70_dmapi-stuff-1
Only in 2.4.21pre2aa1: 70_dmapi-stuff-2
Only in 2.4.20aa1: 70_quota-backport-2
Only in 2.4.21pre2aa1: 70_quota-backport-3
Only in 2.4.20aa1: 90_s390-aa-3
Only in 2.4.21pre2aa1: 90_s390-aa-4
Only in 2.4.20aa1: 90_s390x-aa-2
Only in 2.4.21pre2aa1: 90_s390x-aa-3
Only in 2.4.20aa1: 93_NUMAQ-6
Only in 2.4.21pre2aa1: 93_NUMAQ-8
Only in 2.4.20aa1: 9930_io_request_scale-4
Only in 2.4.21pre2aa1: 9930_io_request_scale-5
Only in 2.4.20aa1: 9931_io_request_scale-drivers-1
Only in 2.4.21pre2aa1: 9931_io_request_scale-drivers-2
Only in 2.4.20aa1: 9970_corename-1.gz
Only in 2.4.21pre2aa1: 9970_corename-2.gz

	Rediffed.

Only in 2.4.20aa1: 00_flock-posix-2001-1
Only in 2.4.20aa1: 00_loop-fixes-2.4.19pre7ac2-1
Only in 2.4.20aa1: 00_loop-handling-pages-in-cache-1
Only in 2.4.20aa1: 00_scsi-largelun-2
Only in 2.4.20aa1: 30_01_nfs-call-start-1
Only in 2.4.20aa1: 9960_cyclone-3

	Merged in mainline.

Only in 2.4.21pre2aa1: 00_free_pages-lru-no_irq-1

	Allow aio to release pages queued in the plage replacement lru.

Only in 2.4.21pre2aa1: 00_irda-compile-1

	Fix compilation trouble.

Only in 2.4.21pre2aa1: 00_rbtree-cleanups-1

	Merged rbtree cleanups/microoptimizations from Érsek László after
	verifying their math correctness also with the help of Paolo Carlini
	and of some gentle reminder from Rusty, they are obviously right,
	thanks.

Only in 2.4.20aa1: 00_sd-cleanup-2
Only in 2.4.21pre2aa1: 00_sd-cleanup-3

	Pert of it merged in mainline.

Only in 2.4.21pre2aa1: 00_semop-timeout-1

	Added semop timeout to allow some app to skip a syscall in some fast
	path, same as in 2.5.53.

Only in 2.4.21pre2aa1: 00_small-vma-1

	Reduce the size of a vma to 68bytes, the last private field isn't
	interesting and in turn there shouldn't be that much false sharing on
	this big struct.

Only in 2.4.21pre2aa1: 00_vma-file-merge-1

	Implement (finish) the vma merging for file backed vmas too (all of them).
	This implements total back and forward merging too, not only forward
	merging with a quick hack. this is a showstopper need for some app that
	wouldn't run at all otherwise in some configuration. Only mmap() does
	the total merging at the moment, it could be extended to all other
	vma-related syscalls but this app doesn't care about those other syscalls,
	so I did the minimalistic thing so far for 2.4 (but done right and in the
	most powerful manner, so that it can be extended to other syscalls too
	over time if needed).

Only in 2.4.21pre2aa1: 00_writeoute_one_page-b_flushtime-1

	There's no point to set bflushtime there.

Only in 2.4.20aa1: 10_rawio-vary-io-13
Only in 2.4.21pre2aa1: 10_rawio-vary-io-15

	Fix several (though very minor) varyio bugs.

Only in 2.4.21pre2aa1: 21_sched-o1-yield-rt-1

	Fix RT handling in the o1 scheduler, so keventd will run rt as it
	pretends to according to the code, and fix sched_yield for RT tasks
	so that it stops deadlocking hard the box with some important app,
	when some lower prio RT task can't run despite the higher prio runs
	sched_yield in a loop etc... This also has the chance to make staroffice
	under kernel compile more interactive: we didn't recalculated the effective
	prio always after a sched_yield, so it could be queued again with
	lesser priority at the next timeslice expire. They're all o1 bugs.

Only in 2.4.20aa1: 9900_aio-13.gz
Only in 2.4.21pre2aa1: 9900_aio-14.gz
Only in 2.4.20aa1: 9910_shm-largepage-6.gz
Only in 2.4.21pre2aa1: 9910_shm-largepage-9.gz

	More fixes (i.e. try to boot with bigpages > 4G, now you can, and try
	to swap with plenty of bigpages, now it's solid).

Only in 2.4.20aa1: 9920_kgdb-4.gz
Only in 2.4.21pre2aa1: 9920_kgdb-5.gz

	Dropped the superflous PAGE_OFFSET check in mainline and rely only
	on the code segment value.

Only in 2.4.21pre2aa1: 9985_blk-atomic-aa4

	New design to avoid fractured blocks for the rawio, this works on all
	device drivers and through whatever blkdev mapper (lvm/md/..) as far as
	it's possible to merge the I/O in the biggest possible atomic dma
	operations provided by the hardware (this of course also requires that
	the device remapper has extents aligned with the database blocksize and that
	the hardware supports SG dma operations as large as the blocksize of the
	db, so some care must be necessary in userspace while choosing the hardware,
	i.e. if you stripe in raid0 we can't merge the I/O in a single operation
	if the stripe size is lower than the blocksize etc..).  You can imagine
	this feature for rawio, similar to journaling for a filesystem. this is
	a requirement for some database.

	This obsolete the superbh patch, that was meant to achieve the same thing
	but it was working only for direct scsi devices (no lvm/md), and only
	for a few of them (no mylex,cpqarray etc..). This is also much simpler and
	much safer, since all the merging code is unchanged and the lowlevel device
	drivers doesn't need any change to make this work. This also doesn't invalidate
	the elevator (my first version did that, and I planned to add it later but Jens
	beated me sending after a few minutes a 10 liner incremental that
	refiles stuff in order rather than putting at the end of the queue like
	my first lazy version did ;). btw, Jens implemented the sequence number
	management part too.

Only in 2.4.20aa1: 9981_elevator-lowlatency-2
Only in 2.4.21pre2aa1: 9981_elevator-lowlatency-3

	Rediffed. If you get any sign of low I/O performance (on both read or
	writes) please try to backout this patch (called
	9981_elevator-lowlatency-3) as first thing. I think we should limit
	the number of requests too, but I hadn't time to implement it yet, and
	the current patch is stable and it should work better on lowmem machines
	(and my 50mbyte scsi works as fast as always even with this patch but
	slower cpus than 2.5Ghz xeon might notice the I/O [not cpu :) ]
	pipeline is shorter than in mainline).

Only in 2.4.21pre2aa1: 9990_hack-drop-x86-fast-pte-2

	I can reproduce the mm corruption problem without the above workaround
	applied and dri in the X server enabled, playing gltron for a few seconds and
	restarting the X server a few times in between is enough to get an
	oops, so I applied this band-aid that just reverse the x86-fast-pte,
	that is only a theorical microoptimization (since we allocate the quick
	pgd we could as well use it), the frequency of pgd allocations is small
	enough that it shouldn't matter, so it's not urgent to fix it right,
	but still I didn't delete the x86-fast-pte because I would like to
	debug and understand it completely first. It might be related to the
	vmalloc part of the pgd but I'm not sure yet. It may even be that the
	band-aid is making harder to reproduce a bug that is still there.

	I never noticed this problem before because I rarely use 3d (and usually
	I had mesasoft setup anyways). It's not specific to a certain graphics card,
	so it looks more like an agp generic problem or something, I can
	reproduce myself on my laptop i830 graphics card and i830 agp, on my
	desktop g450 with amd agp, and on my test box on a ati radeon 7500 and
	intel agp, so it doesn't look like a lowlevel driver problem, and it
	only hurts while using the agp and/or drm somehow. Many thanks to
	Srihari Vijayaraghavan who found the offending patch in the whole kit
	originally some time ago.

Andrea
