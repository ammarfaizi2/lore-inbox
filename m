Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269133AbTGaFhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 01:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272365AbTGaFhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 01:37:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:35285 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269133AbTGaFhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 01:37:34 -0400
Date: Wed, 30 Jul 2003 22:38:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test2-mm2
Message-Id: <20030730223810.613755b4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm2/

. CPU scheduler changes

. Several changes to the synaptics and PS/2 drivers.  People who have had
  problems with keyboards and mice, please test and report.

. Lots of other things, mainly bugfixes.





Change since 2.6.0-test2-mm1:



-timer-spin-fix.patch
-ak4xxx-fix.patch

 merged into the ALSA update

+alsa-bk-2003-07-28.patch

 ALSA update

+x86_64-merge.patch

 x86_64 update

+buffer_io_error-readahead-fix.patch

 Prevent that bubffer I/O error warning

+force_page_cache_readahead.patch

 Avoid even attempting readahead if the underlying queue is read-congested

+no_page-memory-barriers.patch

 SMP fix for the filemap_nopage-vs-pagefault fix

+o11int.patch
+o11int.1.patch
+o11.2int.patch

 CPU scheduler work

-synaptics-reset-fix.patch

 Dropped

+xfs-dio-unwritten-extents.patch

 XFS extensions to the direct-io code.

-sb16-ioports-fix.patch

 Dropped (it's in the ALSA update)

+read_dir-fix.patch

 devfs boot-time mounting fix

+blk_start_queue-fix.patch

 Fix blk_start_queue() bug

+special_file-move.patch

 Code consolidation

+remove-queue_wait.patch

 Remove unused request field

+uidhash-locking.patch

 Locking microfix

+remove-const-initdata.patch

 Linkage fixes

+osf-partition-handling.patch

 OSF partition handler fix

+com20020_cs-build-fix.patch

 Driver compile fix

+hdlc-build-fix.patch

 Driver compile fix

+add-mandocs-target.patch

 Add build targets to turn kernel docs into manpages

+binfmt_script-argv0-fix.patch

 Make binfmt_script handling more consistent

+bttv-driver-update.patch

 BTTV update

+ppp-xon-xoff-handling.patch

 Teach the ppp driver to do XON/XOFF

+dac960-devfs-fix.patch

 Fix devfs directories for the DAC960 driver

+dquot-typo-fix.patch

 v1 quota build fix

+i810-fix.patch

 oops fix

+intel-agp-oops-fix.patch

 another oops fix

+export-agp_memory_reserved.patch

 add an EXPORT_SYMBOL

+pci_device_id-devinitdata.patch

 Move lots of PCI device_id tables out of __initdata

+airo-fixes.patch

 airo driver rework

+ppc32-cpu-registration-fix.patch

 Some ppc32 fix

+timer-race-fixes.patch

 Fix an SMP race in core timer code.

+local-apic-enable-fixes.patch

 Local APIC fixes for P4 CPUs

+impi-build-fix.patch

 Compile fix

+document-nfs-utils.patch

 NFS documentation update

+untested-quota-fix.patch

 Another quota fix

+generic-hdlc-updates.patch

 HDLC driver update

+p00001_synaptics-restore-on-close.patch
+p00002_psmouse-reset-timeout.patch
+p00003_synaptics-multi-button.patch
+p00004_synaptics-optional.patch
+p00005_synaptics-pass-through.patch
+p00006_psmouse-suspend-resume.patch
+p00007_synaptics-old-proto.patch

 Synaptics driver rework

+bridge-notification-fix.patch

 Might fix the birdge driver's timer problems

+keyboard-resend-fix.patch

 PS/2 driver fix

+stallion-devfs-fix.patch

 serial driver fix

+dm-rename-resume.patch

 devicemapper build fix

+serial-is-not-experimental.patch

 Move serial drivers out fro CONFIG_EXPERIMENTAL

+ftl-warning-fix.patch

 Warning fix

+watchdog-module-param-fixes.patch

 Watchdog driver module parameter update

+kobject-paranoia-checks.patch

 Additional kobject debug checks



All 174 patches


mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-remove-cpu_callout_map.patch
  kgdb: remove cpu_callout_map decls

kgdb-use-ggdb.patch

kgdb-ga-docco-fixes.patch
  kgdb doc. edits/corrections

alsa-bk-2003-07-28.patch

cpumask_t-1.patch
  cpumask_t: allow more than BITS_PER_LONG CPUs
  cpumask_t fix for s390
  fix cpumask_t for s390
  Fix cpumask changes for x86_64
  fix cpumask_t for sparc64

cpumask_t-gcc-workaround-46.patch
  cpumask_t: more gcc workarounds

cpumask_t-gcc-workaround-47.patch
  cpumask_t gcc bug workarounds

cpumask-acpi-fix.patch
  cpumask_t: build fix

kgdb-cpumask_t.patch

x86_64-merge.patch
  x86-64 merge for 2.6.0test2

misc31.patch
  misc fixes

selinux.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

ia64-percpu-revert.patch
  revert percpu changes

x86_64-fixes.patch
  x86_64 fixes

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

ds-09-vicam-usercopy-fix.patch
  vicam usercopy fix

buffer-debug.patch
  buffer.c debugging

rcu-stats.patch
  RCU statistics reporting

mtrr-hang-fix.patch
  Fix mtrr-related hang

intel8x0-cleanup.patch
  intel8x0 cleanups

bio-too-big-fix.patch
  Fix raid "bio too big" failures

centrino-update.patch
  update to speedstep-centrino.c

ppa-fix.patch
  ppc fix

3c59x-pm-fix.patch
  3c59x suspend/resume fix

dev_t-printing.patch
  dev_t printing

rootdisk-parsing-fix.patch
  fix "unable to mount root fs"

3c59x-eisa-fix.patch
  non-MII 3c59x fix

slab-reclaim-accounting-fix.patch
  kwsapd can free too much memory

stack-leak-fix.patch
  info leak -- padded struct copied to user

unlock_buffer-barrier.patch
  unlock_buffer() needs a barrier

linux-isp-2.patch

linux-isp-2-fix-again.patch
  lost feral fix

feral-bounce-fix.patch
  Feral driver - highmem issues

feral-bounce-fix-2.patch
  Feral driver bouncing fix

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch
  print a few config options on oops

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

64-bit-dev_t-other-archs.patch
  enable 64-bit dev_t for other archs

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

buffer_io_error-readahead-fix.patch
  fix bogus IO error messages

force_page_cache_readahead.patch
  rework readahead for congested queues

truncate-pagefault-race-fix.patch
  Fix vmtruncate race and distributed filesystem race

truncate-pagefault-race-fix-fix.patch
  Make sure truncate fix has no race

no_page-memory-barriers.patch
  memory barriers for the no_page race fix

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

kjournald-PF_SYNCWRITE.patch

o1-interactivity.patch
  CPU scheduler interactivity patch

o2int.patch
  O2int 0307041440 for 2.5.74-mm1

o3int.patch
  O3int interactivity for 2.5.74-mm2

o4int.patch
  O4int interactivity

o5int-2.patch
  O5int for interactivity

o6int.patch
  O6int for interactivity

o6.1int.patch
  O6.1int

o7int.patch
  O7int for interactivity

o8int.patch
  O8int for interactivity

o9int.patch
  O9int for interactivity

o10int.patch
  O10int for interactivity

o11int.patch
  O11int for interactivity

o11int.1.patch
  O11.1int for interactivity

o11.2int.patch
  O11.2int for interactivity

sched-balance-tuning.patch
  CPU scheduler balancing fix

ext3-block-allocation-cleanup.patch

nfs-revert-backoff.patch
  nfs: revert backoff changes

ext3-elide-inode-block-reading.patch
  ext3: avoid reading empty inode blocks

ext3_getblk-race-fix.patch
  Fix race in ext3_getblk

ext3_write_super-speedup.patch
  ext3: don't start a commit in write_super()

alloc_bootmem_low_pages-ordering-fix.patch
  fix alloc_bootmem_low_pages

floppy-smp-fixes.patch
  floppy smp fixes

1000HZ-time-accuracy-fix.patch
  missing #if for 1000 HZ

sis-drm-fix.patch
  SiS RM fix

signal-race-fix.patch
  signal handling race condition causing reboot hangs

soundcard-devfs-fix.patch
  soundcard.c devfs fix

6pack-hz-fix.patch
  6PACK asumes HZ=100

devfs_lookup-revert-and-refix.patch
  devfs_lookup stack corruption fix rework

write-mark_page_accessed.patch
  use mark_page_accessed() in the write() path

less-kswapd-throttling.patch

zone-pressure.patch
  vmscan: decaying average of zone pressure

reclaim-mapped-pressure.patch
  vmscan: use zone_pressure for page unmapping decisions

vmscan-defer-writepage.patch
  vmscan: give dirty referenced pages another pass around the LRU

xfs-dio-unwritten-extents.patch
  direct-io support for XFS unwritten extents

blacklist-asus-L3800C-dmi.patch
  add ASUS l3800P to DMI black list

force-CONFIG_INPUT.patch
  Force CONFIG_INPUT if CONFIG_VT set

ipt_helper-build-fix.patch
  Fix ipt_helper compilation

nforce2-acpi-fixes.patch
  ACPI patch which fixes all my IRQ problems on nforce2

select-xoffed-tty-fix.patch
  fix select() with an xoffed tty

conntrack-build-fix.patch
  fix ip_conntrack_core.h compile error

arcnet-typo-fix.patch
  typo in drivers/net/arcnet/com20020-isa.c

ext3-commit-assertion-fix.patch
  ext3: fix commit assertion failure

read_dir-fix.patch

blk_start_queue-fix.patch
  fix broken blk_start_queue behavior

special_file-move.patch
  Move the special_file() definition

remove-queue_wait.patch
  remove unused request_queue.queue_wait

uidhash-locking.patch
  uidhash init-time locking

remove-const-initdata.patch
  __initdata cant be marked const

osf-partition-handling.patch
  osf partition numbering

com20020_cs-build-fix.patch
  com20020_cs.c doesn't compile

hdlc-build-fix.patch
  pc300_drv build fix

add-mandocs-target.patch
  Add mandocs and mandocs_install targets

binfmt_script-argv0-fix.patch
  binfmt_script argv[0] fix

bttv-driver-update.patch
  BTTV driver update

ppp-xon-xoff-handling.patch
  ppp_async xon/xoff handling

dac960-devfs-fix.patch
  Fix dac960 for devfs

dquot-typo-fix.patch
  quota typo fix

i810-fix.patch
  i810fb oops fix

intel-agp-oops-fix.patch

export-agp_memory_reserved.patch
  export agp_memory_reserved

pci_device_id-devinitdata.patch
  pci_device_id tables must not be __initdata

airo-fixes.patch
  airo driver fixes

ppc32-cpu-registration-fix.patch
  ppc32: cpu registration fix

timer-race-fixes.patch
  timer race fixes

local-apic-enable-fixes.patch
  Local APIC enable fixes

impi-build-fix.patch
  IPMI build fix

document-nfs-utils.patch
  Require nfs-utils 1.0.5; document where to get it

untested-quota-fix.patch
  old-style quota maybe-fix

generic-hdlc-updates.patch
  generic HDLC updates

p00001_synaptics-restore-on-close.patch

p00002_psmouse-reset-timeout.patch

p00003_synaptics-multi-button.patch

p00004_synaptics-optional.patch

p00005_synaptics-pass-through.patch

p00006_psmouse-suspend-resume.patch

p00007_synaptics-old-proto.patch

bridge-notification-fix.patch
  Fix bridge notification processing

keyboard-resend-fix.patch
  keyboard resend fix

stallion-devfs-fix.patch
  drivers/char/stallion.c: devfs_mk_cdev fix

dm-rename-resume.patch
  dm: reame the `resume()' function

serial-is-not-experimental.patch
  serial drivers are not experimental

ftl-warning-fix.patch
  ftl.c warning fix

watchdog-module-param-fixes.patch
  Watchdog patches - new module_param (patch 1 + 2)

kobject-paranoia-checks.patch
  Driver core and kobject paranoia checks

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

aio-dio-no-readahead.patch
  aio O_DIRECT no readahead

lock_buffer_wq-fix.patch
  lock_buffer_wq fix

unuse_mm-locked.patch
  AIO: hold the context lock across unuse_mm

aio-take-task_lock.patch
  From: Suparna Bhattacharya <suparna@in.ibm.com>
  Subject: Re: 2.5.72-mm1 - Under heavy testing with AIO,.. vmstat seems to blow the kernel

aio-O_SYNC-fix.patch
  Unify o_sync changes for aio and regular writes

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads



