Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbTIBCCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 22:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTIBCCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 22:02:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29315
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263413AbTIBCCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 22:02:09 -0400
Date: Tue, 2 Sep 2003 04:02:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22aa1
Message-ID: <20030902020218.GB1599@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This had some extra delay due travelling for KS/OLS/vacations and some
backlog of other work. But it was very good to hear lots of feedback
from -aa users this month, many asked for a new release and reported
their positive results, thank you.

If you sent me something and it's missing please resend ;)

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22aa1/

Diff between 2.4.22pre7aa1 and 2.4.22aa1:

Only in 2.4.22pre7aa1: 00_387-fix-1
Only in 2.4.22pre7aa1: 00_proc-cmdline-1
Only in 2.4.22pre7aa1: 00_profile-read-efault-1

	Merged in mainline.

Only in 2.4.22pre7aa1: 00_binfmt-elf-checks-2
Only in 2.4.22aa1: 00_binfmt-elf-checks-3
Only in 2.4.22pre7aa1: 00_extraversion-28
Only in 2.4.22aa1: 00_extraversion-29
Only in 2.4.22pre7aa1: 00_sched-O1-aa-2.4.19rc3-15.gz
Only in 2.4.22aa1: 00_sched-O1-aa-2.4.19rc3-17.gz
Only in 2.4.22pre7aa1: 20_pte-highmem-31.gz
Only in 2.4.22aa1: 20_pte-highmem-32.gz
Only in 2.4.22pre7aa1: 30_irq-balance-14
Only in 2.4.22aa1: 30_irq-balance-15
Only in 2.4.22pre7aa1: 51_uml-aa-13
Only in 2.4.22aa1: 51_uml-aa-14
Only in 2.4.22pre7aa1: 97_i_size-corruption-fixes-4
Only in 2.4.22aa1: 97_i_size-corruption-fixes-5
Only in 2.4.22pre7aa1: 9900_aio-22.gz
Only in 2.4.22aa1: 9900_aio-23.gz
Only in 2.4.22pre7aa1: 9920_kgdb-10.gz
Only in 2.4.22aa1: 9920_kgdb-11.gz
Only in 2.4.22pre7aa1: 9950_futex-4.gz
Only in 2.4.22aa1: 9950_futex-5.gz
Only in 2.4.22pre7aa1: 9999900_desktop-3
Only in 2.4.22aa1: 9999900_desktop-4
Only in 2.4.22pre7aa1: 9999_dm-2
Only in 2.4.22aa1: 9999_dm-3.gz

	Rediffed.

Only in 2.4.22aa1: 00_cdrom_root_table-procfs-1

	Merged my version (simpler and more readable with #ifdef)
	of Daniele Bellucci's janitorial patch.

Only in 2.4.22aa1: 00_global-irq-race-1

	Fixes for the races found by TeJun Huh.

Only in 2.4.22aa1: 00_jfs-locking-fix-1
Only in 2.4.22pre7aa1: 9985_blk-atomic-aa6-jfs-1

	Merged correct jfs fixes (and backed out the
	blk-atomic part, now blk-atomic is completely
	backwards compatible now that Jens added BH_Atomic).

Only in 2.4.22aa1: 00_log-buf-len-1

	Add the "log_buf_len=" kernel parameter so you can
	tweak at boot time the size of the log buffer.
	Untested at the moment.

Only in 2.4.22aa1: 00_sk98lin_2.4.22-20030902-1.gz

	Merged new sk98lin driver from:

		http://www.syskonnect.com/syskonnect/support/driver/htm/sk98lin.htm

Only in 2.4.22pre7aa1: 00_smp-timers-not-deadlocking-5
Only in 2.4.22aa1: 00_smp-timers-not-deadlocking-6

	Added cpu_relax() (aka cpulevel-sched-yield) in the
	spinlocks-by-hand, so it doesn't waste the cpu with
	hyperthreading (and it doesn't activate termal-throttling in the p4).

Only in 2.4.22pre7aa1: 10_sched-o1-bluetooth-1
Only in 2.4.22aa1: 10_sched-o1-bluetooth-2

	Added one further compile fix for o1 scheduler.

Only in 2.4.22aa1: 20_sched-o1-fixes-10
Only in 2.4.22pre7aa1: 20_sched-o1-fixes-9

	Changed the CHILD_PENALTY logic to be centered around
	50%. From Kurt Garloff.

Only in 2.4.22pre7aa1: 9902_aio-poll-1
Only in 2.4.22aa1: 9999901_aio-network-poll-pipe-1

	Added pipe and network aio support.

Only in 2.4.22pre7aa1: 9995_frlock-gettimeofday-6
Only in 2.4.22aa1: 9995_frlock-gettimeofday-7

	Backed out the mips part instead of porting it, mips needs much more
	changes anyways and it's worthless to support it in the meantime since
	it keeps breaking.

Only in 2.4.22aa1: 9999900_aio-rawio-varyio-2

	Added the varyio support when using aio on top of rawio. Original
	patch is from Intel (but it's unsafe, it passes b_size large as much
	as PAGE_SIZE and it had other bugs too), then I fixed some bugs and
	Chris completed it a few days ago.

Only in 2.4.22aa1: 9999900_blkdev-inode-times-pagecache-1

	Avoid updating the atime/mtime for blkdevs. This was part of
	some device mapper side-patch. But that one was very broken,
	it was doing the opposite. The idea was good, the implementation
	had one more '!'. It also checked for O_DIRECT and I also removed
	that check, O_DIRECT should still update atime and mtime, or backups
	could break too.

Only in 2.4.22aa1: 9999900_distributed-shared-memory-hook-1

	Merged sistina's do_no_page replacement hook. This is the cleanest
	approch seen todate. still, it's highly recommended that different
	cluster fs shares the same generic_dsm_do_no_page or similar.

Only in 2.4.22aa1: 9999900_epoll-common-2

	Merged epoll, original patch from Davide Libenzi.

Only in 2.4.22aa1: 9999900_ipc-rcu-1

	Merged IPC RCU from Mingming Cao. This also includes my fix
	that avoids vmalloc to bug out when called before smp_init,
	that as Kurt found would otherwise prevent smp boxes with less
	than 1G of ram to boot.

Only in 2.4.22aa1: 9999900_monitor-mwait-1

	This patch from Intel adds the monitor/mwait support in the idle loop.
	Monitor and mwait are an huge innovation in terms of smp, (this also
	has effect besides hyperthreading). rep_nop is sched_yield,
	monitor/mwait is the futex.
	This is only the start, the obvious next step is to use
	this in the spinlocks, not wasting any cpu at all in the slow path is
	fundamental to boost cpu utilization with hyperthreading.

Only in 2.4.22aa1: 9999900_q-full-1

	Added q->full support to avoid new tasks to steals requests in
	an unfair manner. now elvtune -b1 also enables a more lowlatency mode
	that puts a barrier at each unplug (decreases performance though).

Only in 2.4.22aa1: 9999900_rcu-helpers-1

	Some helper function needed for the ipc rcu code.

	Side note: the rcu-poll implementation in the tree since years, should
	be much better than the one in 2.6 for the usages of rcu in 2.4. The
	efficiency of the slow path here doesn't matter. And rcu-poll is very
	efficient even in the slow path, but it's so lowlatency that it doesn't
	also allow to colaesce all the callbacks in a single invocation.

	For the rcu usages in 2.4, all we care about is that the fastpath will
	not bounce back and forth the cachelines and rcu-poll generates the
	minimal overhead when only the fast path is running.

Only in 2.4.22aa1: 9999900_request-firmware-1

	Merged request firmware from Manuel Estrada Sainz.

Only in 2.4.22aa1: 9999900_scsi-error-handler-new-1
Only in 2.4.22aa1: 9999901_scsi-softirq-2

	Adds some error handling fix, and give scalability to scsi_done,
	so multiple requests can be completed in parallel (think the
	irq delivered to multiple cpus by different controllers in smp).

Only in 2.4.22aa1: 9999900_shmem_truncate-against-swapoff-1

	Fix from Hugh to try to avoid false statistic information and lost
	pages in pagecache, when swapoff puts pages back into pagecache
	after a truncate already passed over the inode and truncated it off.
	The new bitflag avoids the double truncate when there's no race.

Only in 2.4.22pre7aa1: 9999_mmap-cache-1
Only in 2.4.22aa1: 9999_mmap-cache-2

	Fix 32bit/64bit bugs (and generic bugs too) in mmap-cache. To go 100%
	safe I didn't remove the zeroing of the cache in fork but in fork it's
	totally useless to flush the cache. both the parent and the child will
	be the same and the cache is stil valid and we should keep it. The only
	place where we need to flush the cache isn't binfmt_elf or whatever
	lowlevel handler like in 2.6 but it's only this:

	--- 2.4.22pre7aa1/fs/exec.c.~1~	2003-07-19 02:34:05.000000000 +0200
	+++ 2.4.22pre7aa1/fs/exec.c	2003-08-18 18:14:35.000000000 +0200
	@@ -433,6 +433,7 @@ static int exec_mmap(void)
	 		mm_release();
	 		exit_aio(old_mm);
	 		exit_mmap(old_mm);
	+		old_mm->free_area_cache = 0;
	 		return 0;
	 	}

	This is the only place where we need to flush the cache, not fork as
	far as I can tell. I recommend to nuke the flush of the cache in fork
	and from all the binfmt lowlevel handlers from 2.6, and to only add
	it in the above place. If something we can leave it in fork, but having
	it in the lowlevel handlers makes no sense at all. There's absolutely
	nothing specific to the binary format in this logic, this is a core vm
	logic and as such it has to stay only in the common code, never in
	the lowlevel one.

	I've also very clear how to provide O(log(N)) malloc, so I hope soon
	it'll be available too (then maybe I can drop this unreliable heuristic).

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
