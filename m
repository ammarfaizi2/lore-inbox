Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267323AbTBKIpO>; Tue, 11 Feb 2003 03:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267327AbTBKIpO>; Tue, 11 Feb 2003 03:45:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:36500 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267323AbTBKIpL>;
	Tue, 11 Feb 2003 03:45:11 -0500
Date: Tue, 11 Feb 2003 00:55:16 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.60-mm1
Message-Id: <20030211005516.03add509.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2003 08:54:51.0633 (UTC) FILETIME=[3D359610:01C2D1AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.60/2.5.60-mm1/
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.60/2.5.60-mm1/

Mainly a resync.  Maneesh fixed up the sunrpc code to work with dcache_rcu,
so that is back in.




Changes since 2.5.59-mm10:


+linus.patch

 Latest from Linus

-seqlock-fixes.patch
-profiler-per-cpu.patch
-user-process-count-leak.patch
-numaq-ioapic-fix2.patch
-ll_rw_block-fix.patch
-remove-journal_try_start.patch
-dac960-range-fix.patch
-DAC960-maintainer.patch
-nforce2-support.patch
-hugepage-address-validation.patch
-radix-tree-rnode-test.patch
-ext3-comment-cleanup.patch
-ext3_fill_super-no-unlock_super.patch
-remove-buffer_head_mempool.patch

 Merged

+adaptec-compile-fix.patch

 Make the adaptec driver compile.

+ppc64-reloc_hide.patch
+ppc64-time-warning.patch
+genhd-warnings.patch
+vmscan-warning.patch
+nfsd-warnings.patch
+partitions-warnings.patch
+nfs-warning-fix.patch
+reiserfs-hashes-warning-fix.patch
+xfs-warning-fixes.patch
+st-warning-fix.patch
+xfs-cli-fix.patch
+ppc64-smp_prepare_cpus-warning.patch
+adaptec-debug-fix.patch

 Fallout from building the kernel with a ppc64 cross-compiler (yetch)

-epoll-update.patch
+epoll-update-2.5.60.patch

 Davide's latest

-sched-2.5.59-F3-update.patch
-rml-scheduler-update2.patch

 The scheduler update threw a bunch of rejects and I haven't fixed them yet.

+dcache_rcu-fast_walk-revert.patch
+dcache_rcu-main.patch
+dcache_rcu-nfs-server-fix.patch

 Maneesh fixed the knfsd problem.

+nfs-oom-fix.patch
+sk-allocation.patch
+rpciod-atomic-allocations.patch

 Attempt to fix an NFS client OOM lockup with heavy MAP_SHARED loads. 
 Doesn't work yet.




All 50 patches:

linus.patch

ppc64-reloc_hide.patch

ppc64-time-warning.patch
  kill ppc64 unused var warning

genhd-warnings.patch
  genhd warning fix

vmscan-warning.patch
  kill warning in vmscan.c

nfsd-warnings.patch
  kill some ppc64 warnings in knfsd

partitions-warnings.patch
  fix ppc64 wanings in fs/partitions/check.c

nfs-warning-fix.patch
  fixppc64 nfs warning

reiserfs-hashes-warning-fix.patch
  fs/reiserfs/hashes.c warning fix

xfs-warning-fixes.patch

st-warning-fix.patch
  fix drivers/scsi/st.c warning

xfs-cli-fix.patch
  xfs interrupt flags fix

ppc64-smp_prepare_cpus-warning.patch
  ppc64: fix warning

adaptec-compile-fix.patch
  make the adaptec driver compile

adaptec-debug-fix.patch
  fix adaptec diagnostics for ppc64

kgdb.patch

report-lost-ticks.patch
  make lost-tick detection more informative

devfs-fix.patch

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

oprofile-p4.patch

oprofile_cpu-as-string.patch
  oprofile cpu-as-string

oprofile-braino.patch

disassociate_tty-fix.patch
  Subject: [PATCH][RESEND 3] disassociate_ctty SMP fix

epoll-update-2.5.60.patch
  Subject: [patch] epoll timeout and syscall return types ...

mandlock-oops-fix.patch
  ftruncate/truncate oopses with mandatory locking

reiserfs_file_write.patch
  Subject: reiserfs file_write patch

misc.patch
  misc fixes

deadline-np-42.patch
  (undescribed patch)

deadline-np-43.patch
  (undescribed patch)

batch-tuning.patch
  I/O scheduler tuning

starvation-by-read-fix.patch
  fix starvation-by-readers in the IO scheduler

crc32-speedup.patch
  crc32 improvements for 2.5

scheduler-tunables.patch
  scheduler tunables

lockd-lockup-fix.patch
  Subject: Re: Fw: Re: 2.4.20 NFS server lock-up (SMP)

rcu-stats.patch
  RCU statistics reporting

dcache_rcu-fast_walk-revert.patch
  dcache_rcu: revert fast_walk code

dcache_rcu-main.patch
  dcache_rcu

dcache_rcu-nfs-server-fix.patch
  Subject: Fw: Re: [resend] dcache_rcu-3-2.5.59.patch

cyclone-fixes.patch
  Cyclonetimer fixes

enable-timer_cyclone.patch
  Enable timer_cyclone code

smalldevfs.patch
  smalldevfs

hugetlbfs-i_size-fix.patch
  hugetlbfs i_size fix

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

deadline-hash-fix.patch

nfs-oom-fix.patch
  nfs oom fix

sk-allocation.patch
  Subject: Re: nfs oom

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations



