Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262815AbSJLGd5>; Sat, 12 Oct 2002 02:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262817AbSJLGd5>; Sat, 12 Oct 2002 02:33:57 -0400
Received: from packet.digeo.com ([12.110.80.53]:20208 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262815AbSJLGdw>;
	Sat, 12 Oct 2002 02:33:52 -0400
Message-ID: <3DA7C3A5.98FCC13E@digeo.com>
Date: Fri, 11 Oct 2002 23:39:33 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.42-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2002 06:39:34.0152 (UTC) FILETIME=[206AC880:01C271BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.42/2.5.42-mm2/

mm1 had a little problem in the compilation department - missing chunk
from fs/fcntl.c.

+fix-pgpgout.patch

 Fix /proc/vmstat:pgpgin/pgpgout accounting for 512-byte IOs

+dio-fine-alignment.patch

 Bring back the 512-byte alignment patch

+sard.patch

 Keep sard ticking over

+remove-kiobufs.patch

 Remove the kiobuf infrastructure.






kgdb.patch

oprofile-25.patch

misc.patch
  misc

hugetlb-meminfo.patch
  change hugetlbpage info in /proc/meminfo

dio-bio-add-fix-1.patch
  Fix direct-io for bio_add_page()

net-loopback.patch
  Disable second copy in the network loopback driver

swsusp-feature.patch
  add shrink_all_memory() for swsusp

large-queue-throttle.patch
  Improve writer throttling for small machines

exit-page-referenced.patch
  Propagate pte referenced bit into pagecache during unmap

swappiness.patch
  swappiness control

mapped-start-active.patch
  start anonymous pages on the active list

rename-dirty_async_ratio.patch
  rename dirty_async_ratio to dirty_ratio

auto-dirty-memory.patch
  adaptive dirty-memory thresholding

batched-slab-asap.patch
  batched slab shrinking and shrinker callback API

blkdev-o_direct-short-read.patch
  Fix O_DIRECT blockdev reads at end-of-device

fix-pgpgout.patch
  Fix block IO accounting for 512-byte requests

orlov-allocator.patch

blk-queue-bounce.patch
  inline blk_queue_bounce

lseek-ext2_readdir.patch
  remove lock_kernel() from ext2_readdir()

msync-correctness.patch
  msync correctness fix

dio-fine-alignment.patch
  Allow O_DIRECT to use 512-byte alignment

sard.patch
  SARD disk accounting

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

hugetlb-prefault.patch
  hugetlbpages: factor out some code for hugetlbfs

ramfs-aops.patch
  Move ramfs address_space ops into libfs

hugetlb-header-split.patch
  Move hugetlb declarations into their own header

hugetlbfs.patch
  hugetlbfs file system

hugetlb-shm.patch
  hugetlbfs backing for SYSV shared memory

page_reserved-accounting.patch
  Global PageReserved accounting

use-page_reserved_accounting.patch
  Use PG_reserved accounting in the VM

ramfs-prepare-write-speedup.patch
  correctness fixes in libfs address_space ops

akpm-deadline.patch
  deadline scheduler tweaks

intel-user-copy.patch
  Faster copt_*_user for Intel ia32 CPUs

raid0-fix.patch
  RAID0 fix

rmqueue_bulk.patch
  bulk page allocator

free_pages_bulk.patch
  Bulk page freeing function

hot_cold_pages.patch
  Hot/Cold pages and zone->lock amortisation

readahead-cold-pages.patch
  Use cache-cold pages for pagecache reads.

pagevec-hot-cold-hint.patch
  hot/cold hints for truncate and page reclaim

page-reservation.patch
  Page reservation API

o_streaming.patch
  O_STREAMING support

remove-kiobufs.patch
  Remove kiobufs and kiovecs

slab-split-01-rename.patch
  slab cleanup: rename static functions

slab-split-02-SMP.patch
  slab: enable the cpu arrays on uniprocessor

slab-split-03-tail.patch
  slab: reduced internal fragmentation

slab-split-04-drain.patch
  slab: take the spinlock in the drain function.

slab-split-05-name.patch
  slab: remove spaces from /proc identifiers

slab-split-06-mand-cpuarray.patch
  slab: cleanups and speedups

slab-split-07-inline.patch
  slab: uninline poisoning checks

slab-split-08-reap.patch
  slab: reap timers

cpucache_init-fix.patch
  cpucache_init fix

slab-split-10-list_for_each_fix.patch
  slab: for a list walking bug

shpte.patch

shpte-ifdef.patch
  reduced ifdeffery in the shared pagetable code

shpte-mprotect-fix.patch
  fix shared pagetable handling of mprotect

shpte-unmap-fix.patch
  shared pagetable unmap fix

shmmap.patch
  Proactively share page tables for shared memory

read_barrier_depends.patch
  extended barrier primitives

rcu_ltimer.patch
  RCU core

dcache_rcu.patch
  Use RCU for dcache
