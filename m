Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTHSIhc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 04:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTHSIhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 04:37:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:4230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264448AbTHSIg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 04:36:58 -0400
Date: Tue, 19 Aug 2003 01:38:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test3-mm3
Message-Id: <20030819013834.1fa487dc.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm3/


. More CPU scheduler changes

. The regression with reaim which was due to the CPU scheduler changes
  seems to have largely gone away, but it was never a large effect in my
  testing.  Needs retesting please.

. A series of Cardbus driver updates.





Changes since 2.6.0-test3-mm2:



-x86_64-merge-test3.patch
-x86_64-config_preempt-fix.patch
-compat-statfs64.patch
-compat_utimes.patch
-compat-posix-timers.patch
-compat-x86_64.patch
-cpumask_t-1.patch
-sparc64_cpumask.patch
-x86_64-cpumask_t-fix.patch
-x86_64-cpumask_t-fix-2.patch
-fadvise-fix.patch
-fadvise64-64.patch
-bio-too-big-fix.patch
-ppa-fix.patch
-1000HZ-time-accuracy-fix.patch
-nforce2-acpi-fixes.patch
-timer-race-fixes.patch
-as-remove-hash-valid-stuff.patch
-xfs-uptodate-page-fix.patch
-standalone-elevator-noop.patch
-pipe-rofs-fix.patch
-reiserfs-bogus-kunmap-removal.patch
-reiserfs-xattr-fix.patch
-p4-thermal-interrupt-fix.patch
-nbd-race-fixes.patch
-disable-raid5-readahead.patch
-pnp_get_info-oops-fix.patch
-cciss-warning-fix.patch
-vt_ioctl-warning-fixes.patch
-task-refcounting-fix.patch
-zap_other_threads-fix.patch
-probe-udf-after-reiserfs.patch
-nfsd-timestamp-fix.patch
-ide-scsi-queue-conversion-fix.patch
-bluetooth-deref-fix.patch
-trident-spin_unlock-fix.patch
-handle-old-dev_t-format.patch
-firmware-loader-needs-hotplug.patch
-loop-iv-fix.patch
-as-no-trinary-states-3.patch
-ppp-compression-fix.patch
-devfs_mk_dir.patch
-devfs_walk_path.patch
-floppy_init.patch
-m68k-selinux-build-fix.patch
-mtrr-init-ordering-fixes.patch
-hd_c-typo-fix.patch
-hugetlbfs-use-after-free-fix.patch
-minixfs-warning-fix.patch
-loop-oops-fix.patch
-sysfs-bin-unbreak-3.patch
-uinput-warning-fix.patch
-jbd-revoke-warning-fix.patch
-as-requeue-fix.patch
-keyboard-warning-fix.patch
-likely-unlikely-fix.patch
-ipmi-update.patch
-binfmt_misc-doc.patch
-hugetlbfs-free_blocks-accounting-fix.patch
-reboot-disable-local-apic.patch
-request_firmware-docs.patch
-firmware-loader-maintainer.patch
-paride-fix.patch
-jffs-statfs-fix.patch
-part_dev_read-fix.patch
-make-16-way-x440s-boot.patch
-strncpy-off-by-one-fix.patch
-missing-codepage-config-fix.patch
-dac960-oops-fix.patch
-exec-arg-size-tracking.patch
-airo-schedule-fix.patch
-adm1021-scaling-fix.patch

 Merged

+o15int.patch
+o16int.patch
+o16.1int.patch
+o16.2int.patch
+o16.3int.patch

 CPU scheduler interactivity work.

+syn-multi-btn-fix.patch

 Synaptics fix

-kobject-paranoia-checks.patch

 Other changes broke this.

+4g4g-debug-flags-fix.patch
+4g4g-TI_task-fix.patch

 4G/4G fixes

-awe-use-gfp_flags-braino.patch

 Folded into awe-use-gfp_flags.patch

+deadline-requeue-workaround.patch

 Work around a deadline IO scheduler bug

+cursor-flashing-fix.patch

 fbdev cursor fix

+disable-athlon-prefetch.patch

 Disable prefetch() on all AMD CPUs.  It seems to need significant work to
 get right and we're currently getting rare oopses with K7's.

+opl3sa2-lock-init-fix.patch

 Missing spin_unlock

+sis900-atomicity-fix.patch

 sleep-in-spinlock fix

+slab-hexdump.patch

 Additional slab debug

+aic7xxx-parallel-build-fix.patch

 Parallel make fix

+dscc4-1.patch
+dscc4-2.patch
+dscc4-3.patch
+dscc4-4.patch
+dscc4-5.patch
+dscc4-6.patch
+dscc4-7.patch
+dscc4-8.patch

 Updates to this WAN driver

+aio-mm-leak-fix.patch

 AIO refcounting fix

+selinux-avc_log_lock-fix.patch
+selinux-check-behaviour-fix.patch

 SELinux fixes

+ymfpci-oops-fix.patch
+ymf_devs-lock.patch

 Sound driver fixes

+slab-drain_array-fix.patch

 Slab fix

+cyclone-fixmap-fix.patch

 Fix cyclone fixmap logic

+loop-oops-fix.patch

 Fix oops in the loop driver

+yenta-20030817-1-zv.patch
+yenta-20030817-2-override.patch
+yenta-20030817-3-sockinit.patch
+yenta-20030817-4-pm.patch
+yenta-20030817-5-pm2.patch
+yenta-20030817-6-init.patch
+yenta-20030817-7-quirks.patch

 Cardbus driver update

+atp870u_detect-lockup-fix.patch

 Fix a probe-time lockup in the acard driver (it is still not working right
 though).

+copy_user-handle-kernel-fault.patch

 Teach the Intel copy_to_user ode to handle faults on the source address. 
 Fixes the `cat /dev/kmem' oops.

+proc-pid-setuid-ownership-fix.patch

 Fix permissions on /proc/pid/* when the app does setuid()

+Locking-update.patch

 Doccumentation update

+sysctl_h-needs-compiler_h.patch

 Build fix

+aio-remove-lseek-triggerable-BUG_ONs.patch

 AIO cleanup





All 174 patches


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

kgdb-cpumask_t.patch

si_band-type-fix.patch
  Fix si_band type in asm-generic/siginfo.h

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

o15int.patch
  O15int for interactivity

o16int.patch
  From: Con Kolivas <kernel@kolivas.org>
  Subject: [PATCH] O16int for interactivity

o16.1int.patch
  O16.1int for interactivity

o16.2int.patch
  O16.2int

o16.3int.patch
  O16.3int

ext3-block-allocation-cleanup.patch

nfs-revert-backoff.patch
  nfs: revert backoff changes

signal-race-fix.patch
  signal handling race condition causing reboot hangs

vmscan-defer-writepage.patch
  vmscan: give dirty referenced pages another pass around the LRU

blacklist-asus-L3800C-dmi.patch
  add ASUS l3800P to DMI black list

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

syn-multi-btn-fix.patch
  synaptics multibutton fix

keyboard-resend-fix.patch
  keyboard resend fix

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

4g4g-debug-flags-fix.patch
  4g4g: debug flags fix

4g4g-TI_task-fix.patch
  4g4g: Fix wrong asm-offsets entry

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

awe-core.patch
  async write errors: report truncate and io errors on async writes

awe-use-gfp_flags.patch
  async write errors: use flags in address space

awe-fix-truncate-errors.patch
  async write errors: fix spurious fs truncate errors

random-locking-fixes.patch
  random: SMP locking

random-accounting-and-sleeping-fixes.patch
  random: accounting and sleeping fixes

rt-tasks-special-vm-treatment.patch
  real-time enhanced page allocator and throttling

rt-tasks-special-vm-treatment-2.patch

input-use-after-free-checks.patch
  input layer debug checks

ikconfig-enable.patch
  enable the ikconfig stuff in config

bd-claim-whole-disk.patch
  When a partition is claimed, claim the whole device for partitioning.

O_EXCL-claim-blockdevs.patch
  Allow O_EXCL on a block device to claim exclusive use.

deadline-requeue-workaround.patch
  deadline requeue workaround

fbdev.patch

cursor-flashing-fix.patch
  fbdev: fix cursor letovers

disable-athlon-prefetch.patch

opl3sa2-lock-init-fix.patch
  opl3sa2 uninitialised spinlock

sis900-atomicity-fix.patch
  sis900 atomicity fix

slab-hexdump.patch
  slab: hexdump structures when things go wrong

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

dscc4-1.patch
  dscc4: commentary

dscc4-2.patch
  dscc4: clock mode commentary

dscc4-3.patch
  dscc4: debug messages

dscc4-4.patch
  dscc4: scc changes

dscc4-5.patch
  dscc4: reset changes

dscc4-6.patch
  dscc4: CCR1 register fixes

dscc4-7.patch
  dscc4: various

dscc4-8.patch
  dscc4: module refcounting

aio-mm-leak-fix.patch
  aio: fix error-path mm leak in ioctx_alloc

selinux-avc_log_lock-fix.patch
  Fix SELinux avc_log_lock

selinux-check-behaviour-fix.patch
  SELinux check behavior value

ymfpci-oops-fix.patch
  ymfpci oops fix

ymf_devs-lock.patch
  add locking to global list in ymfpci.c

slab-drain_array-fix.patch
  slab: drain_array fix

cyclone-fixmap-fix.patch
  cyclone time fixmap fix

loop-oops-fix.patch
  loop: fix module unload oops

yenta-20030817-1-zv.patch

yenta-20030817-2-override.patch

yenta-20030817-3-sockinit.patch

yenta-20030817-4-pm.patch

yenta-20030817-5-pm2.patch

yenta-20030817-6-init.patch

yenta-20030817-7-quirks.patch

atp870u_detect-lockup-fix.patch
  atp870u.c lockup fix

copy_user-handle-kernel-fault.patch
  fix intel copy_to_user()

proc-pid-setuid-ownership-fix.patch
  fix /proc/pid/fd ownership across setuid()

Locking-update.patch
  update Documentation/filesystems/Locking

sysctl_h-needs-compiler_h.patch
  sysctl.h needs compiler.h

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

aio-remove-lseek-triggerable-BUG_ONs.patch

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup



