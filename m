Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbTFVF2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 01:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbTFVF2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 01:28:31 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:25846 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265526AbTFVF2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 01:28:18 -0400
Date: Sat, 21 Jun 2003 22:42:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.72-mm3
Message-Id: <20030621224242.37ff8a7e.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 05:42:22.0300 (UTC) FILETIME=[0D6279C0:01C33881]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.72/2.5.72-mm3/

Nothing very exciting.  Mainly a resync to pick up the latest Linus tree.





Changes since 2.5.72-mm2:

 linus.patch

 Latest from Linus

-show_stack-cleanup.patch
-ppc64-show_stack.patch
-ia32-copy_from_user-fix.patch
-rd-range-check.patch
-proc-kcore-notes-fix.patch
-proc-kcore-handle-unmapped-areas.patch
-statfs64-3.patch
-1-kmem-cache-destroy.patch
-2-slab-poison-fix.patch
-sysv-semundo-fixes.patch
-raw-devfs-support.patch
-hugetlbfs-size-inodes-mount-option.patch
-hugetblfs-statfs-update.patch
-misc5.patch
-scroll-distance-fix.patch
-remove-swapper_inode.patch
-sync-write-more-pages.patch
-workqueue-reorg-fix.patch
-task_struct-use-after-free-fix.patch
-keventd-thread-cleanup.patch
-mach-generic-build-fix.patch
-nfs-suspend-fix.patch
-elf_plat_init-fix.patch
-node-local-hugetlbpages.patch
-highmem-build-fix.patch
-restore-daniels-c.patch
-jbd-really-readonly.patch
-ext3-jbd-trailing-whitespace.patch

 Merged

+psmouse-build-fix.patch

 drivers/input/mouse/ compile fix

+mtrr-hang-fix.patch

 Fix(?) initcall ordering problem

+setscheduler-fix.patch

 Make sched_setscheduler() changes take effect immediately

+misc6.patch

 Misc fixes

+aio-take-task_lock.patch

 Doesn't fix the AIO mm usage bug.

-nfs-O_DIRECT-remove-async-cruft.patch
-nfs-O_DIRECT-nfs_read_data.patch
-nfs-O_DIRECT-nfs_write_proc.patch
-nfs-O_DIRECT-sync-commit-rpcs.patch
-nfs-O_DIRECT.patch
-nfs-O_DIRECT-config-option.patch
+20-odirect_enable.patch
+21-odirect_cruft.patch
+22-read_proc.patch
+23-write_proc.patch
+24-commit_proc.patch
+25-odirect.patch

 New NFS O_DIRECT series from Chuck.

+d_invalidate-fix.patch
+nfs_unlink-d_count-fix.patch
+hpfs-d_count-fix.patch

 dcache locking fixes

+seqcount-locking.patch
+i_size-atomic-access.patch

 i_size access integrity for 32-bit machines.

+smbfs-oops-workaround.patch

 Semi-fix a mount-time smbfs oops.

+aha152x-oops-fix.patch

 Fix oops in this driver.

+enable-cardbus-bursting.patch

 Enable burst transfers on TI cardbus controllers





All 113 patches

linus.patch
  cset-1.1327.4.1-to-1.1371.txt.gz

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-use-ggdb.patch

psmouse-build-fix.patch
  psmouse build fix

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

e100-use-after-free-fix.patch

3-unmap-page-debugging.patch
  page unmappng debug patch

VM_RESERVED-check.patch
  VM_RESERVED check

rcu-stats.patch
  RCU statistics reporting

mtrr-hang-fix.patch
  Fix mtrr-related hang

setscheduler-fix.patch
  setscheduler needs to force a reschedule

ide_setting_sem-fix.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

misc6.patch
  misc fixes

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

aio-take-task_lock.patch
  From: Suparna Bhattacharya <suparna@in.ibm.com>
  Subject: Re: 2.5.72-mm1 - Under heavy testing with AIO,.. vmstat seems to blow the kernel

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution

truncate-pagefault-race-fix.patch
  Fix vmtruncate race and distributed filesystem race

sleepometer.patch
  sleep instrumentation

time-goes-backwards.patch
  demonstrate do_gettimeofday() going backwards

skip-apic-ids-on-boot.patch
  skip apicids on boot

AT_SECURE-auxv-entry.patch
  AT_SECURE auxv entry

printk-oops-mangle-fix.patch
  disentangle printk's whilst oopsing on SMP

20-odirect_enable.patch

21-odirect_cruft.patch

22-read_proc.patch

23-write_proc.patch

24-commit_proc.patch

25-odirect.patch

nfs-O_DIRECT-always-enabled.patch
  Force CONFIG_NFS_DIRECTIO

common-kernel-DSO-name.patch
  common name for the kernel DSO

ehci_hcd-linkage-fix.patch
  ehci-hdd linkage fix

get_unmapped_area-speedup.patch
  get_unmapped_area() speedup

d_invalidate-fix.patch
  dentry->d_count fixes: d_invalidate

nfs_unlink-d_count-fix.patch
  dentry->d_count fixes: nfs_unlink

hpfs-d_count-fix.patch
  dentry->d_count fixes: hpfs

seqcount-locking.patch
  i_size atomic access: infrastructure

i_size-atomic-access.patch
  i_size atomic access

smbfs-oops-workaround.patch
  Ugly workaround for smb_proc_getattr oops

aha152x-oops-fix.patch
  aha152X oops fixes

enable-cardbus-bursting.patch
  Enable Cardbus bursting



