Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271696AbTHMIbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 04:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271698AbTHMIbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 04:31:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:63649 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271696AbTHMIb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 04:31:27 -0400
Date: Wed, 13 Aug 2003 01:31:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test3-mm2
Message-Id: <20030813013156.49200358.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm2/


. Zillions of bugfixes

. Updated framebuffer drivers

. More CPU scheduler tweaking.




Changes since 2.6.0-test3-mm1:


+kgdb-fix-debug-info.patch

 kgdb config fix

+x86_64-merge-test3.patch

 Latest x86_64 drop

+x86_64-config_preempt-fix.patch

 x86_64 build fix

+si_band-type-fix.patch

 POSIX says si_band in siginfo_t must be long.

+compat-statfs64.patch
+compat_utimes.patch
+compat-posix-timers.patch
+compat-x86_64.patch

 64-bit compat layer additions

+sparc64_cpumask.patch
+x86_64-cpumask_t-fix.patch
+x86_64-cpumask_t-fix-2.patch

 coumask_t additions

-x440-fixes.patch

 Dropped (updated)

+arch-dev_t-stat-fixes.patch

 Fix lots of architecture's stat structure for dev_t changes

+sparc64-lockmeter-fix.patch
+sparc64-lockmeter-fix-2.patch

 Fix sparc64 lockmeter implementation

+sparc64_sched_clock.patch

 sched_clock() for sparc64

+x86_64-sched_clock.patch

 sched_clock() for x86_64

-export-video_proc_entry.patch

 broken

+loop-iv-fix.patch

 fix loop transfer handling

+as-no-trinary-states-3.patch

 anticipatory scheduler cleanups

+ppp-compression-fix.patch

 PPP fix

+devfs_mk_dir.patch

 devfs use-after-free fix

+devfs_walk_path.patch

 devfs use-of-uninitialised fix

+floppy_init.patch

 floppy devfs fix

+m68k-selinux-build-fix.patch

 fix m68k SELinux build

+mtrr-init-ordering-fixes.patch

 mtrr ordering cleanups

+hd_c-typo-fix.patch

 build fix

+hugetlbfs-use-after-free-fix.patch

 hugetlbfs bugfix

+minixfs-warning-fix.patch

 fix a warning

+loop-oops-fix.patch

 Fix loop-on-file unount crash

+sysfs-bin-unbreak-3.patch

 sysfs fix

+uinput-warning-fix.patch

 warning fix

+bd-claim-whole-disk.patch
+O_EXCL-claim-blockdevs.patch

 blockdev ownership rework

+jbd-revoke-warning-fix.patch

 warning fix

+as-requeue-fix.patch

 Properly implement as_requeue_request()

+keyboard-warning-fix.patch

 warning fix

+likely-unlikely-fix.patch

 make likely/unlikely do the right thing with pointers

+ipmi-update.patch

 IPMI driver update

+binfmt_misc-doc.patch

 documentation

+hugetlbfs-free_blocks-accounting-fix.patch

 hugetlbfs accounting fix

+reboot-disable-local-apic.patch

 APCI fix on reboot

+request_firmware-docs.patch
+firmware-loader-maintainer.patch

 Document the request_firmware() code

+paride-fix.patch

 Fix paride

+jffs-statfs-fix.patch

 JFFS build fix

+o15int.patch

 CPU scheduler work

+part_dev_read-fix.patch

 dev_t formatting change in sysfs

+fbdev.patch

 framebuffer update

+make-16-way-x440s-boot.patch

 x440 fix

+strncpy-off-by-one-fix.patch

 strncpy memory stomp fix

+missing-codepage-config-fix.patch

 NLS build fix

+dac960-oops-fix.patch

 DAC960 fix

+exec-arg-size-tracking.patch

 exec fix for parisc

+airo-schedule-fix.patch

 resurrect akpm scheduling-inside-spinlock frustration patch

+adm1021-scaling-fix.patch

 temperature scaling ix

+O_SYNC-speedup-nolock-fix.patch

 Some filesystems' O_SYNC operations weren't syncing anything.





All 206 patches:

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix

kgdb-warning-fix.patch
  kgdbL warning fix

kgdb-build-fix.patch

kgdb-spinlock-fix.patch

kgdb-fix-debug-info.patch
  kgdb: CONFIG_DEBUG_INFO fix

x86_64-merge-test3.patch
  x86-64 merge for 2.6.0test3

x86_64-config_preempt-fix.patch
  Fix x86-64 compilation with CONFIG_PREEMPT

si_band-type-fix.patch
  Fix si_band type in asm-generic/siginfo.h

compat-statfs64.patch
  Compat 1: statfs64

compat_utimes.patch
  Compat 2: compat_utimes

compat-posix-timers.patch
  Compat 3: add posix timer compat functions

compat-x86_64.patch
  Compat Final: x86-64 support code

vmlinux-generation-fix.patch
  Fix vmlinux.lds.s generation

cpumask_t-1.patch
  cpumask_t: allow more than BITS_PER_LONG CPUs
  cpumask_t fix for s390
  fix cpumask_t for s390
  Fix cpumask changes for x86_64
  fix cpumask_t for sparc64
  cpumask_t: more gcc workarounds
  cpumask_t gcc bug workarounds
  cpumask_t: build fix
  cpumask: IPS fixups
  cpumask: avoid using structs for NR_CPUS<BITS_PER_LONG
  cpumask: physid fixes
  cpumask_t uniproc build fix
  cpumask_t fixes
  cpumask: next_cpu fix
  flush_cpumask atomicity fix

sparc64_cpumask.patch

x86_64-cpumask_t-fix.patch
  x86_64 cpumask_t - ioapic set_ioapic_affinity

x86_64-cpumask_t-fix-2.patch
  x86_64 cpumask_t - flush_tlb_others warning

kgdb-cpumask_t.patch

fadvise-fix.patch
  fadvise(POSIX_FADV_DONTNEED) fix

fadvise64-64.patch
  sys_fadvise64_64

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

ppc64-local.patch
  ppc64: local.h implementation

ppc64-sched_clock.patch
  ppc64: sched_clock()

sym-do-160.patch
  make the SYM driver do 160 MB/sec

x86_64-fixes.patch
  x86_64 fixes

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

rcu-grace-period.patch
  Monitor RCU grace period

intel8x0-cleanup.patch
  intel8x0 cleanups

bio-too-big-fix.patch
  Fix raid "bio too big" failures

ppa-fix.patch
  ppc fix

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

mknod64-64-bit-fix.patch
  dev_t: fix mknod for 64-bit archs

ustat64.patch
  ustat64

ppc-64-bit-stat.patch
  fix ppc stat.h for 64-bit dev_t

64-bit-dev_t-init_rd-fixes.patch
  initrd fixes for 64-bit dev_t

arch-dev_t-stat-fixes.patch
  Fix all asm-*/stat.h dev_t instances

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

sparc64-lockmeter-fix.patch

sparc64-lockmeter-fix-2.patch
  Fix lockmeter on sparc64

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

sched-2.6.0-test2-mm2-A3.patch
  sched-2.6.0-test2-mm2-A3

ppc-sched_clock.patch

sparc64_sched_clock.patch

x86_64-sched_clock.patch
  Add sched_clock for x86-64

sched-warning-fix.patch

sched-balance-tuning.patch
  CPU scheduler balancing fix

sched-no-tsc-on-numa.patch
  Subject: Re: Fw: Re: 2.6.0-test2-mm3

o12.2int.patch
  O12.2int for interactivity

o12.3.patch
  O12.3 for interactivity

o13int.patch
  O13int for interactivity

o13.1int.patch
  O13.1int

o14int.patch
  O14int

o14int-div-fix.patch
  o14int 64-bit-divide fix

o14.1int.patch
  O14.1int

ext3-block-allocation-cleanup.patch

nfs-revert-backoff.patch
  nfs: revert backoff changes

1000HZ-time-accuracy-fix.patch
  missing #if for 1000 HZ

signal-race-fix.patch
  signal handling race condition causing reboot hangs

vmscan-defer-writepage.patch
  vmscan: give dirty referenced pages another pass around the LRU

blacklist-asus-L3800C-dmi.patch
  add ASUS l3800P to DMI black list

nforce2-acpi-fixes.patch
  ACPI patch which fixes all my IRQ problems on nforce2

timer-race-fixes.patch
  timer race fixes

local-apic-enable-fixes.patch
  Local APIC enable fixes

p00001_synaptics-restore-on-close.patch

p00002_psmouse-reset-timeout.patch

p00003_synaptics-multi-button.patch

p00004_synaptics-optional.patch

p00005_synaptics-pass-through.patch

p00006_psmouse-suspend-resume.patch

p00007_synaptics-old-proto.patch

synaptics-mode-set.patch
  Synaptics mode setting

keyboard-resend-fix.patch
  keyboard resend fix

kobject-paranoia-checks.patch
  Driver core and kobject paranoia checks

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix

4g4g-vmlinux-update-got-lost.patch

4g4g-do_page_fault-cleanup.patch
  4G/4G: remove debug code

4g4g-cleanups.patch

kgdb-4g4g-fix-2.patch

4g4g-config-fix.patch

4g4g-pmd-fix.patch
  4g4g: pmd fix

4g4g-wli-fixes.patch
  4g/4g: fixes from Bill

4g4g-fpu-fix.patch
  4g4g: fpu emulation fix

4g4g-show_registers-fix.patch
  4g4g: show_registers() fix

4g4g-pin_page-atomicity-fix.patch
  4g/4g usercopy atomicity fix

4g4g-remove-touch_all_pages.patch

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

awe-core.patch
  async write errors: report truncate and io errors on async writes
  async write errors core: fixes

awe-use-gfp_flags.patch
  async write errors: use flags in address space
  async write errors: mapping->flags fixes

awe-use-gfp_flags-braino.patch

awe-fix-truncate-errors.patch
  async write errors: fix spurious fs truncate errors
  async write errors: truncate handling fixes

as-remove-hash-valid-stuff.patch
  AS: remove hash valid stuff

random-locking-fixes.patch
  random: SMP locking

random-accounting-and-sleeping-fixes.patch
  random: accounting and sleeping fixes

rt-tasks-special-vm-treatment.patch
  real-time enhanced page allocator and throttling

rt-tasks-special-vm-treatment-2.patch

xfs-uptodate-page-fix.patch
  fix buffer layer error at fs/buffer.c:2800 when unlinking XFS files

standalone-elevator-noop.patch
  standalone elevator noop

pipe-rofs-fix.patch
  pipe.c: don't write to readonly filesystems

reiserfs-bogus-kunmap-removal.patch
  reiserfs: remove unneeded kunmap

reiserfs-xattr-fix.patch
  reiserfs: Fix handling of some extended inode attributes

p4-thermal-interrupt-fix.patch
  Setup P4 thermal interrupt vector on UP

nbd-race-fixes.patch
  nbd: fix send/receive/shutdown/disconnect races

disable-raid5-readahead.patch
  raid5: disable readahead

pnp_get_info-oops-fix.patch
  /proc/net/pnp oops fix

cciss-warning-fix.patch
  cciss warning fix

vt_ioctl-warning-fixes.patch
  vt_ioctl warning fixes

task-refcounting-fix.patch
  fix task struct refcount bug

zap_other_threads-fix.patch
  zap_other_threads() detaches thread group leader

probe-udf-after-reiserfs.patch
  probe UDF after reiserfs

nfsd-timestamp-fix.patch
  Fix protocol bugs with NFS and nanoseconds

input-use-after-free-checks.patch
  input layer debug checks

ide-scsi-queue-conversion-fix.patch
  fix ide-scsi for ide_drive_t->queue change

bluetooth-deref-fix.patch
  BUG fix for drivers/bluetooth/hci_usb.c

ikconfig-enable.patch
  enable the ikconfig stuff in config

trident-spin_unlock-fix.patch
  fix trident.c missing unlock

handle-old-dev_t-format.patch
  handle old-style "root=" arguments

firmware-loader-needs-hotplug.patch
  firmware loader requires hotplug

loop-iv-fix.patch
  loop: fix cryptoloop troubles.

as-no-trinary-states-3.patch
  AS: no trinary states

ppp-compression-fix.patch
  ppp_generic.c: fix PPP compression

devfs_mk_dir.patch
  devfs_mk_dir fix

devfs_walk_path.patch
  _devfs_walk_path fix

floppy_init.patch
  floppy_init fix

m68k-selinux-build-fix.patch
  m68k selinux build fix

mtrr-init-ordering-fixes.patch
  Make MTRR init conform with recommended procedure

hd_c-typo-fix.patch
  fix typo in hd.c

hugetlbfs-use-after-free-fix.patch
  fix hugetlbfs slab corruption on umount

minixfs-warning-fix.patch
  Kill warning in minix filesystem on 64-bit archs

loop-oops-fix.patch
  loop oops fix

sysfs-bin-unbreak-3.patch
  request_firmware fix

uinput-warning-fix.patch
  Kill warning in drivers/input/misc/uinput.c on IA64

bd-claim-whole-disk.patch
  When a partition is claimed, claim the whole device for partitioning.

O_EXCL-claim-blockdevs.patch
  Allow O_EXCL on a block device to claim exclusive use.

jbd-revoke-warning-fix.patch
  kill warning in jbd/revoke.c

as-requeue-fix.patch
  AS requeue implementation

keyboard-warning-fix.patch
  keyboard.c warning fix

likely-unlikely-fix.patch
  fix [un]likely(), add ptr support

ipmi-update.patch
  IPMI updates for 2.6.0-test3

binfmt_misc-doc.patch
  Document mounting of binfmt_misc

hugetlbfs-free_blocks-accounting-fix.patch
  hugetlbfs - 'recovering' too many blocks on failure

reboot-disable-local-apic.patch
  Disable APIC on reboot

request_firmware-docs.patch
  more documentation for request_firmware()

firmware-loader-maintainer.patch
  state request_firmware() maintainership.

paride-fix.patch
  pd.c queue initialisation fix

jffs-statfs-fix.patch
  jffs statfs fix

o15int.patch
  O15int for interactivity

part_dev_read-fix.patch
  Fix /sys/<dev>/<partition>/dev format

fbdev.patch

make-16-way-x440s-boot.patch
  Make 16-way x440's boot

strncpy-off-by-one-fix.patch
  Fix strncpy off-by-one error

missing-codepage-config-fix.patch
  small nls Makefile fix

dac960-oops-fix.patch
  Fix DAC960 oops

exec-arg-size-tracking.patch
  Better argument size tracking in fs/exec.c

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

adm1021-scaling-fix.patch
  bugfix for initialization bug in adm1021 driver

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

O_SYNC-speedup-nolock-fix.patch
  osync speedup doesn't work for filesystems using write_nolock

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup




