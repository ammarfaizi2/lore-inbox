Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbTFSISb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 04:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTFSISb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 04:18:31 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:56748 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265410AbTFSISR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 04:18:17 -0400
Date: Thu, 19 Jun 2003 01:33:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.72-mm2
Message-Id: <20030619013311.5deb37c0.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2003 08:32:15.0279 (UTC) FILETIME=[49A263F0:01C3363D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.72/2.5.72-mm2/

. Experimental O_DIRECT support for the NFS client.

. Various new fixes and minor feature work.




Changes since 2.5.72-mm1:


+linus.patch

 Latest from Linus

-pcmcia-detect-fix.patch
-ext3-no-bkl.patch
-journal_get_write_access-speedup.patch
-ext3-concurrent-block-inode-allocation.patch
-ext3-concurrent-block-allocation-hashed.patch
-jbd-010-b_committed_data-race-fix.patch
-jbd-020-locking-schema.patch
-jbd-030-remove-splice_lock.patch
-jbd-040-journal_add_journal_head-locking.patch
-jbd-045-rename-journal_unlock_journal_head.patch
-jbd-050-b_frozen_data-locking.patch
-jbd-060-b_committed_data-locking.patch
-jbd-070-b_transaction-locking.patch
-jbd-080-b_next_transaction-locking.patch
-jbd-090-b_tnext-locking.patch
-jbd-100-remove-journal_datalist_lock.patch
-jbd-110-t_nr_buffers-locking.patch
-jbd-120-t_updates-locking.patch
-jbd-130-t_outstanding_credits-locking.patch
-jbd-140-t_jcb-locking.patch
-jbd-150-j_barrier_count-locking.patch
-jbd-160-j_running_transaction-locking.patch
-jbd-170-j_committing_transaction-locking.patch
-jbd-180-j_checkpoint_transactions.patch
-jbd-190-j_head-locking.patch
-jbd-200-j_tail-locking.patch
-jbd-210-j_free-locking.patch
-jbd-220-j_commit_sequence-locking.patch
-jbd-230-j_commit_request-locking.patch
-jbd-240-dual-revoke-tables.patch
-jbd-250-remove-sleep_on.patch
-jbd-300-remove-lock_kernel.patch
-jbd-400-remove-lock_journal.patch
-jbd-510-h_credits-fix.patch
-jbd-520-journal_unmap_buffer-race.patch
-jbd-530-walk_page_buffers-race-fix.patch
-jbd-540-journal_try_to_free_buffers-race-fix.patch
-jbd-550-locking-checks.patch
-jbd-570-transaction-state-locking.patch
-jbd-580-log_start_commit-race-fix.patch
-jbd-590-do_get_write_access-speedup.patch
-ext3-010-fix-journalled-data.patch
-ext3-035-journal_try_to_free_buffers-race-fix.patch
-ext3-040-recursive-ext3_write_inode-check.patch
-ext3-050-ioctl-transaction-leak.patch
-ext3-070-xattr-clone-leak-fix.patch
-ext3-080-remove-block-inode-count-message.patch
-jbd-600-journal_dirty_metadata-speedup.patch
-jbd-610-journal_dirty_metadata-diags.patch
-jbd-620-commit-vs-start-race-fix.patch
-ext3-090-journalled-writepage-vs-truncate-fix.patch
-jbd-630-remove-j_commit_timer_active.patch
-jbd-650-truncate-ordered-pages.patch
-jbd-660-log_do_checkpoint-fix.patch
-jbd-670-log_start_commit-locking-fix.patch
-jbd-680-log_wait_for_space-fix.patch

 Merged

+ia32-copy_from_user-fix.patch

 Zero out the userspace buffer if access_ok() fails.

+rd-range-check.patch

 Check for valid minor in the ramdisk driver

+proc-kcore-notes-fix.patch
+proc-kcore-handle-unmapped-areas.patch

 /proc/kcore fixes

-statfs64-3-fixes-1.patch

 Folded into statfs64-3.patch

+hugetblfs-statfs-update.patch

 Fix hugetlbfs statfs() for the statfs64 changes.

-as-proc-read-write.patch
-as-discrete-read-fifo-batches.patch
-as-sync-async.patch
-as-hash-removal-fix.patch
-as-jumbo-patch-for-scsi.patch
-as-stupid.patch
-as-no-batch-antic-limit.patch
-as-autotune-write-batches.patch
-as-div-by-zero-fix.patch
-as-more-HZ.patch
-as-even-more-write-batch-tuning.patch
-as-locking.patch
-as-HZ.patch

 Folded into as-iosched.patch

-cfq-hash-removal-fix.patch
-cfq-list_del-fix.patch

 Folded into cfq-2.patch

-syncppp-locking-fix.patch

 Was fixed by Paul.

+printk-oops-mangle-fix.patch

 Prevent mangled oops output on SMP+serial console

+nfs-O_DIRECT-remove-async-cruft.patch
+nfs-O_DIRECT-nfs_read_data.patch
+nfs-O_DIRECT-nfs_write_proc.patch
+nfs-O_DIRECT-sync-commit-rpcs.patch
+nfs-O_DIRECT.patch
+nfs-O_DIRECT-config-option.patch
+nfs-O_DIRECT-always-enabled.patch

 O_DIRECT support for NFS

+mach-generic-build-fix.patch

 Fix the build for generic x86 arch

+nfs-suspend-fix.patch

 Fix NFS versus swsusp

+elf_plat_init-fix.patch

 PPC64 elf fix

+node-local-hugetlbpages.patch

 Allocate hugetlb pages from the local NUMA node.

+highmem-build-fix.patch

 Compile fix

+common-kernel-DSO-name.patch

 Make the ia32 vsyscall DSO have the same name as the ia64 DSO.

+restore-daniels-c.patch

 Restore lost copyright

+ehci_hcd-linkage-fix.patch

 USB linkage section fix.

+get_unmapped_area-speedup.patch

 Fix the mmap() speedup heuristic.

+jbd-really-readonly.patch

 Prevent accidental writes on readonlymounts of ext3 filesystems.

+ext3-jbd-trailing-whitespace.patch

 Fix up zillions of lines which end in tabs.





All 128 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-use-ggdb.patch

HZ-100.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-fixes-2.patch
  Maek ppc64 compile

ppc64-bat-initialisation-fix.patch
  ppc64: BAT initialisation fix

ppc64-pci-update.patch

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

x86_64-fixes.patch
  x86_64 fixes

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

lru_cache_add-check.patch
  lru_cache_add debug check

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

fb-image-depth-fix.patch
  fbdev image depth fix

ds-09-vicam-usercopy-fix.patch
  vicam usercopy fix

buffer-debug.patch
  buffer.c debugging

show_stack-cleanup.patch
  show_stack() portability and cleanup patch

ppc64-show_stack.patch

ia32-copy_from_user-fix.patch
  ia32 copy_from_user() fix

e100-use-after-free-fix.patch

rd-range-check.patch
  range checking in rd_open()

proc-kcore-notes-fix.patch
  Fix /proc/kcore for i386

proc-kcore-handle-unmapped-areas.patch
  /proc/kcore: handle unmapped areas

statfs64-3.patch
  Add system calls statfs64 and fstatfs64

1-kmem-cache-destroy.patch
  kmem_cache_destroy(): use slab_error()

2-slab-poison-fix.patch
  slab poisoning fix

3-unmap-page-debugging.patch
  page unmappng debug patch

VM_RESERVED-check.patch
  VM_RESERVED check

rcu-stats.patch
  RCU statistics reporting

sysv-semundo-fixes.patch
  sysv semundo

raw-devfs-support.patch
  raw.c devfs support

ide_setting_sem-fix.patch

hugetlbfs-size-inodes-mount-option.patch
  hugetlbfs: specify size & inodes at mount

hugetblfs-statfs-update.patch
  hugetlbfs:update statfs

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

misc5.patch
  misc fixes

scroll-distance-fix.patch
  Premit big console scrolls

linux-isp.patch

isp-update-1.patch

isp-remove-pci_detect.patch

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

resurrect-batch_requests.patch
  bring back the batch_requests function

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler
  AS: pgbench improvement
  AS: discrete read fifo batches
  AS sync/async batches
  AS: hash removal fix
  AS jumbo patch (for SCSI and TCQ)
  AS: fix stupid thinko
  AS: no batch-antic-limit
  AS: autotune write batches
  AS: divide by zero fix
  AS: more HZ != 1000 fixes
  AS: update_write_batch tuning
  AS locking
  AS HZ fixes

as-double-free-and-debug.patch
  AS: fix a leak + more debugging

as-fix-seek-estimation.patch
  AS: maybe repair performance drop of random read O_DIRECT

as-fix-seeky-loads.patch
  AS: fix IBM's seek load

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2
  CFQ: update to rq-dyn API
  CFQ: hash removal fix
  CFQ: empty the queuelist

per-queue-nr_requests.patch
  per queue nr_requests

blk-invert-watermarks.patch
  blk_congestion_wait threshold cleanup

blk-as-hint.patch
  blk-as-hint

get_request_wait-oom-fix.patch
  handle OOM in get_request_wait().

blk-fair-batches.patch
  blk-fair-batches

blk-fair-batches-2.patch
  blk fair batches #2

generic-io-contexts.patch
  generic io contexts

blk-request-batching.patch
  block request batching

get_io_context-fix.patch
  get_io_context fixes

blk-allocation-commentary.patch
  block allocation comments

blk-batching-throttle-fix.patch
  blk batch requests fix

print-build-options-on-oops.patch
  print a few config options on oops

mmap-prefault.patch
  prefault of executable mmaps

bio-debug-trap.patch
  BIO debugging patch

sound-irq-hack.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

put_task_struct-debug.patch

ia32-mknod64.patch
  mknod64 for ia32

ext2-64-bit-special-inodes.patch
  ext2: support for 64-bit device nodes

ext3-64-bit-special-inodes.patch
  ext3: support for 64-bit device nodes

64-bit-dev_t-kdev_t.patch
  64-bit dev_t and kdev_t

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

aio-01-retry.patch
  AIO: Core retry infrastructure

io_submit_one-EINVAL-fix.patch
  Fix aio process hang on EINVAL

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-05-fs_write-fix.patch

aio-06-bread_wq.patch
  AIO: Async block read

aio-06-bread_wq-fix.patch

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

O_SYNC-speedup-2.patch
  speed up O_SYNC writes

aio-09-o_sync.patch
  aio O_SYNC

aio-10-BUG-fix.patch
  AIO: fix a BUG

aio-11-workqueue-flush.patch
  AIO: flush workqueues before destroying ioctx'es

aio-12-readahead.patch
  AIO: readahead fixes

lock_buffer_wq-fix.patch
  lock_buffer_wq fix

unuse_mm-locked.patch
  AIO: hold the context lock across unuse_mm

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution

truncate-pagefault-race-fix.patch
  Fix vmtruncate race and distributed filesystem race

remove-swapper_inode.patch
  remove swapper_inode

sync-write-more-pages.patch
  dirty inode writeback fix

workqueue-reorg-fix.patch
  workqueue.c subtle fix and core extraction

task_struct-use-after-free-fix.patch
  proc_pid_lookup use-after-free fix

sleepometer.patch
  sleep instrumentation

time-goes-backwards.patch
  demonstrate do_gettimeofday() going backwards

keventd-thread-cleanup.patch
  Fix kmod return value

skip-apic-ids-on-boot.patch
  skip apicids on boot

AT_SECURE-auxv-entry.patch
  AT_SECURE auxv entry

printk-oops-mangle-fix.patch
  disentangle printk's whilst oopsing on SMP

nfs-O_DIRECT-remove-async-cruft.patch
  remove async cruft from NFS O_DIRECT

nfs-O_DIRECT-nfs_read_data.patch
  expose read offset in the nfs_read_proc routine

nfs-O_DIRECT-nfs_write_proc.patch
  expose write offset in the nfs_write_proc routine

nfs-O_DIRECT-sync-commit-rpcs.patch
  add a proc to issue synchronous commit RPCs

nfs-O_DIRECT.patch
  direct I/O support for 2.5

nfs-O_DIRECT-config-option.patch
  provide an option to enable NFS O_DIRECT

nfs-O_DIRECT-always-enabled.patch
  Force CONFIG_NFS_DIRECTIO

mach-generic-build-fix.patch
  mach-generic build fix

nfs-suspend-fix.patch
  Fix suspend with NFS mounts active

elf_plat_init-fix.patch
  Fix binfmt_elf.c bug on ppc64

node-local-hugetlbpages.patch
  node-local allocation for hugetlbpages

highmem-build-fix.patch
  highmem.h needs mm.h

common-kernel-DSO-name.patch
  common name for the kernel DSO

restore-daniels-c.patch
  Restore Daniel Phillips' copyright

ehci_hcd-linkage-fix.patch
  ehci-hdd linkage fix

get_unmapped_area-speedup.patch
  get_unmapped_area() speedup

jbd-really-readonly.patch
  JBD: honour read-only mounts more carefully

ext3-jbd-trailing-whitespace.patch
  ext3/JBD: remove trailing whitespace




