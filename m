Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265716AbTFXGOa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 02:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265717AbTFXGOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 02:14:30 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:64216 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265716AbTFXGOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 02:14:18 -0400
Date: Mon, 23 Jun 2003 23:29:08 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.73-mm1
Message-Id: <20030623232908.036a1bd2.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jun 2003 06:28:26.0072 (UTC) FILETIME=[D18C1D80:01C33A19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm1/


. PCI and PCMCIA updates

. Make sysrq-T print the right thing.

. Hopefully fix most of the time-goes-too-slowly problems.

. Various other fixes.




Changes since 2.5.72-mm3:


 linus.patch

 Latest from Linus

-psmouse-build-fix.patch
-ehci_hcd-linkage-fix.patch

 Merged

+show_stack-fix.patch

 Fix sysrq-T output.

+handle-no-readpage-2.patch

 Fix crash with prefaulting on tmpfs

+pci-1.patch
+pci-2.patch
+pci-3.patch
+pci-4.patch
+pci-5.patch

 PCI updates

+alsa-pnp-fix.patch

 PNP fix

+reiserfs-unmapped-buffer-fix.patch

 Fix reiserfs-related BUG()

+aio-mm-refcounting-fix.patch

 Should really fix the crashes related to AIO and /proc races accessing
 mm_structs.

+n_tty-column-counting-fix.patch

 tty fix

+security-vm_enough_memory.patch

 Security stuff (this is to be updated)

+nbd-cleanups.patch
+nbd-enhanced-diagnostics.patch

 NBD work

+numa-normalised-node-load.patch

 CPU scheduler fix for NUMA.

+pcmcia-event-20030623-1.patch
+pcmcia-event-20030623-2.patch
+pcmcia-event-20030623-3.patch
+pcmcia-event-20030623-4.patch
+pcmcia-event-20030623-5.patch
+pcmcia-event-20030623-6.patch

 PCMCIA update

+nr_running-speedup.patch

 Simpifly and speed up (we think) the nr_running accounting.

+enable-local-apic-on-p4.patch

 Remove a broken BIOS workaround

+sym2-bus_addr-fix.patch

 SCSI driver fix

+lost-tick-speedstep-fix.patch

 Fix speedstep versus the lost tick detector.

+sym2-remove-broken-bios-check.patch

 Remove a broken BIOS workaround

+knfsd-umount-fix.patch

 Fix the "I can't unmount the fs after the nfs server has been there" bug.

+rename-timer.patch

 Cleanups and sanity in the ia32 timer code.

+getrlimit-ifdef-fix.patch

 Play with ifdefs for ia64

+amd64-monotonic-clock.patch

 Implement monotonic_clock on x86_64






All 141 patches:


linus.patch
  cset-1.1348.1.28-to-1.1408.txt.gz

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-use-ggdb.patch

HZ-100.patch

show_stack-fix.patch
  show_stack fix

handle-no-readpage-2.patch
  check for presence of readpage() in the readahead code

pci-1.patch
  PCI fixes for 2.5.73

pci-2.patch
  PCI fixes for 2.5.73

pci-3.patch
  PCI fixes for 2.5.73

pci-4.patch
  PCI fixes for 2.5.73

pci-5.patch
  PCI fixes for 2.5.73

alsa-pnp-fix.patch
  Fix ALSA ISA pnp_init_resource_table compile errors

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

reiserfs-unmapped-buffer-fix.patch
  Fix reiserfs BUG

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

aio-mm-refcounting-fix.patch
  fix /proc mm_struct refcounting bug

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

n_tty-column-counting-fix.patch
  Column counting fix in n_tty.c

security-vm_enough_memory.patch
  Security hook for vm_enough_memory

nbd-cleanups.patch
  NBD: cosmetic cleanups

numa-normalised-node-load.patch
  normalise node load for NUMA

pcmcia-event-20030623-1.patch

pcmcia-event-20030623-2.patch

pcmcia-event-20030623-3.patch

pcmcia-event-20030623-4.patch

pcmcia-event-20030623-5.patch

pcmcia-event-20030623-6.patch

nr_running-speedup.patch
  make nr_running o(1) for non NUMA

enable-local-apic-on-p4.patch
  enable local APIC on P4

nbd-enhanced-diagnostics.patch
  nbd: enhanced diagnostics support

sym2-bus_addr-fix.patch
  sym53c8xx_2 bus_addr fix

lost-tick-speedstep-fix.patch
  Fix lost tick detection for speedstep

sym2-remove-broken-bios-check.patch
  remove a bogus check in sym2 driver

knfsd-umount-fix.patch
  Can't unmount volume which was once exported via NFS

rename-timer.patch
  timer cleanups

getrlimit-ifdef-fix.patch
  compat_sys_old_getrlimit() depends on sys_old_getrlimit()

amd64-monotonic-clock.patch
  monotonic_clock for amd64



