Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTH3XM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTH3XM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:12:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:32396 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262232AbTH3XL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:11:56 -0400
Date: Sat, 30 Aug 2003 16:15:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test4-mm4
Message-Id: <20030830161536.7e7be6d3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm4/

. Big power management update from Pat

. HPET timer suppor

. CFQ I/O scheduler

. Another CPU scheduler patch

. Various fixes




Changes since 2.6.0-test4-mm3:


+rusage-context-switch-counters-fix.patch

 Fix the rusage context switch counters.

+old-module-tools-warning-fix.patch

 Just warn when old modutils are detected.

+cfq-3.patch

 CFQ I/O scheduler

+sysfs-memleak-fix.patch

 Fix a memory leak

+remove-dead-sse-checks.patch

 Dead code.

+hpet-01-late-time_init.patch
+hpet-02-boot-time-parsing.patch
+hpet-03-misc.patch
+hpet-03-misc-tweaks.patch
+hpet-04-core.patch
+hpet-05-timer-services.patch
+hpet-05-timer-services-tweaks.patch
+hpet-06-rtc-emulation.patch

 ia32 HPET timer support.

+advansys-procfs-fix.patch

 Compile fix

+usb-serial-oops-fix.patch

 USB fix

+handle-setup_swap_extents-error.patch

 swapon error checking fix

+aha1542-oops-fix.patch

 scsi probing oops fix

+cosa-free_netdev-fix.patch

 Fix cosa.c

+tty_files-oops-fix.patch

 Fix tty oops

+remove-kcore-aout.patch

 Remove support for a.out-formatted /proc/kcore

+VT8231-router-detection.patch

 IRQ router support.

+block-devfs-conversions.patch

 Teach some block drivers about devfs

+test4-pm1.patch

 Power management update

+kobject-unlimited-name-lengths.patch

 Remove kobject name length restrictions

+o19int.patch

 CPU scheduler work.

+4g4g-preempt-vstack-fix.patch
+4g4g-kmap-warning-comments.patch

 4G/4G split fixes.






All 290 patches:

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

kgdb-x86_64-fixes.patch
  x86_64 fixes

handle-unreadable-dot-config.patch
  .config checks updated

huge-net-update.patch
  net update

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-build-fixes.patch
  Fix ppc64 breakage

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

x86_64-update-3.patch
  x86-64 update for test4

random-locking-fixes.patch
  random: SMP locking

random-accounting-and-sleeping-fixes.patch
  random: accounting and sleeping fixes

rt-tasks-special-vm-treatment.patch
  real-time enhanced page allocator and throttling

rt-tasks-special-vm-treatment-2.patch

input-use-after-free-checks.patch
  input layer debug checks

deadline-requeue-workaround.patch
  deadline requeue workaround

fbdev.patch

tdfx-build-fix.patch
  tdfx linkage fix

cursor-flashing-fix.patch
  fbdev: fix cursor letovers

disable-athlon-prefetch.patch

sis900-atomicity-fix.patch
  sis900 atomicity fix

slab-hexdump.patch
  slab: hexdump structures when things go wrong

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

yenta-20030817-1-zv.patch

yenta-20030817-2-override.patch

yenta-20030817-3-sockinit.patch

yenta-20030817-4-pm.patch

yenta-20030817-5-pm2.patch

yenta-20030817-6-init.patch

yenta-20030817-7-quirks.patch

proc-pid-setuid-ownership-fix.patch
  fix /proc/pid/fd ownership across setuid()

pid-revalidate-security-hook.patch
  Call security hook from pid*_revalidate

dac960-GAM-IOCTLs-cleanup.patch
  move DAC960 GAM IOCTLs into a new device

thread-pgrp-fix-2.patch
  Fix setpgid and threads

kj-maintainers.patch
  Add the kernel janitors to MAINTAINERS

ide-docs-update.patch
  Update ide.txt documentation to current ide.c

ramdisk-cleanup.patch

v4l-use-after-free-fix.patch
  Fix bug in v4l core for 2.6.0-test3-bk

ikconfig-makefile-update.patch
  ikconfig - Makefile update

ftape-warning-fix.patch
  Fix ftape warning

jffs-retval-fix.patch
  jffs aops return type fix

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

intel8x0-cleanup.patch
  intel8x0 cleanups

make-ACPI_SLEEP-select-SOFTWARE_SUSPEND.patch
  Make ACPI_SLEEP select SOFTWARE_SUSPEND

3GB-personality.patch
  Add 3GB personality

zeromap_pmd_range-fix.patch
  zeromap_pmd_range bugfix

no-async-write-errors-on-close.patch
  don't report async write errors on close() after all

sis190-fix.patch
  sis190 synchronize_irq fix

remove-add_wait_queue_cond.patch
  remove add_wait_queue_cond()

spin_lock_irqrestore-fixes.patch
  spin_lock_irqrestore() typo fixes

pcmciamtd-fix.patch
  pcmciamtd.c: remove release timer

zoran-memleak-fixes.patch
  zoran: memleak fixes

zoran-rename-debug.patch
  zoran: debug->zr_debug

zoran-release-callback.patch
  zoran: add release callback

zoran-pci_disable_device.patch
  zoranL: add pci_disable_device() call

zoran-cleanups.patch
  zoran: cleanups

zoran-cleanups-2.patch
  zoran: more cleanups

zoran-naming-fix.patch
  zoran: correct name field breakage

airo-build-fix.patch
  airo CONFIG_PCI=n build fix

m68k-vmlinux_lds-move.patch
  move m68k vmlinux.lds files

mac-ide-fix.patch
  Fix Mac IDE

m68k-asm-sections-fix.patch
  m68k asm/sections.h

m68k-asm-local.patch
  m68k asm/local.h

amiga-z2ram-fix.patch
  Amiga z2ram

amiga-floppy-fix.patch
  Amiga floppy

atari-floppy-fix.patch
  Atari floppy

m68k-switch_to-fix.patch
  M68k switch_to fix

pcxx-warning-fix.patch
  drivers/char/pcxx.c warning fix

pcnet32-unregister_pci-fix.patch
  pcnet32 needs unregister_pci

hwifs-oops-unregister-fix.patch
  Fix ide unregister vs. driver model

c99-conversions.patch
  c99 struct initialiser conversions

cyc2x-fixes.patch
  cyc2x: sanitize ioremap usage & more

noacpi-option-fix.patch
  Fix 'pci=noacpi' with buggy ACPI BIOSes

h8300-interrupt-fix.patch
  h8300 interrupt problem fix

proc-kallsyms-caching-fix.patch
  /proc/kallsym caching fix

proc-kallsyms-permission-fix.patch
  Fix permissions on /proc/kallsyms

cu3088-string-null-termination-fix.patch
  cu3088 null termination fix

kobject-doc-addition.patch
  Kobject doc addition

vm_enough_memory-speedup.patch
  vm_enough_memory microoptimisation

abi-doc-update.patch
  abi doc update

remove-bio-boot-messages.patch
  bio.c: reduce verbosity at boot

claim-serio-early.patch
  Serio: claim serio early

ni5010-build-fix.patch
  ni5010.c: remove cli/sti

sis190-build-fix.patch
  sis190 doesn't compile with gcc 2.95

nopage-fix.patch
  do_no_page() fix

fix-strange-code-in-bio_add_page.patch
  Fix odd code in bio_add_page

parport_pc-rmmod-oops-fix.patch
  parport_pc rmmod oops fix

reiserfs-writepage-fix.patch
  reiserfs writepage-versus-truncate fix

visws-build-fix.patch
  visws: fix 2.6.0-test4 breakage

cciss-queue-init-fix.patch
  cciss queue initialisation fix

htree-big-endian-fix.patch
  Fix ext3 htree corruption on big-endian platforms

selinux-file-fcntl-fix.patch
  Fix selinux_file_fcntl

selinux-avtab-fix.patch
  Fix SELinux avtab

selinux-format-specifiers-fix.patch
  Fix SELinux format specifiers

selinux-binprm-hooks-rework.patch
  Rework SELinux binprm hooks

ext2-xattr-typo-fix.patch
  Fix typo in #ifdef for ext2 xattr support

bad-inode-ops.patch
  Add more bad_inode operations

kcore-aout-build-fix.patch
  Fix build with CONFIG_KCORE_AOUT

nfs4proc-warnings-fix.patch
  knfsd nfs4 warning fixes

bluetooth-warning-fixes.patch
  Fix bluetooth compile warnings

nopage-rss-accounting-fix.patch
  do_no_page() rss accounting fix

sonypi-update.patch
  sonypi driver update

meye-update.patch
  meye driver update

jbd-stfu.patch
  jbd: remove uninformative printk

proc-pid-maps-32-bit-fix.patch
  Do 32bit addresses in /proc/self/maps if possible

acpi-pci-link-fix.patch
  acpi pci_link fix

rusage-context-switch-counters.patch
  add context switch counters

rusage-context-switch-counters-fix.patch

large-dev_t-01.patch
  large dev_t work - first series (1/12)

large-dev_t-02.patch
  large dev_t work - first series (2/12)

large-dev_t-03.patch
  large dev_t work - first series (3/12)

large-dev_t-04.patch
  large dev_t work - first series (4/12)

large-dev_t-05.patch
  large dev_t work - first series (5/12)

large-dev_t-06.patch
  large dev_t work - first series (6/12)

large-dev_t-07.patch
  large dev_t work - first series (7/12)

large-dev_t-08.patch
  large dev_t work - first series (8/12)

large-dev_t-09.patch
  large dev_t work - first series (9/12)

large-dev_t-10.patch
  large dev_t work - first series (10/12)

large-dev_t-11.patch
  large dev_t work - first series (11/12)

large-dev_t-12.patch
  large dev_t work - first series (12/12)

large-dev_t-12-fix.patch
  large dev_t 12/12 fix

size_t-printk-warning-fixes.patch
  remove size_t-based printk warnings

stallion-build-fix-2.patch
  stallion serial driver cleanup

evdev_ioctl-fix.patch
  evdev_ioctl does not report EV_MSC capabilities

as-no-initial-antic.patch
  AS: don't anticipate against a tasks' initial I/O

mark-devfs-obsolete.patch
  mark devfs obsolete

hch-contacts-update.patch
  hch has moved

h8300-include-update.patch
  h8300 include update

cyclades-isa-fix.patch
  Cyclades ISA serial driver fix

old-module-tools-warning.patch
  kbuild: warn if the user has old modutils

old-module-tools-warning-fix.patch

arcnet-printk-fix.patch
  fix arcnet printk parameter types

floppy-cleanup.patch
  floppy driver cleanup

floppy-more-cleanup.patch
  floppy driver: more cleanups

v850-nommu-export-fixes.patch
  v850: Guard some symbol exports with #ifdef CONFIG_MMU

v850-RODATA-fix.patch
  v850: Give v850 its own version of the vmlinux.lds.h RODATA macro

dnotify-use-tgid.patch
  Use tgid rather than pid in dnotify

send_sigio-decl-fix.patch
  Fix a few declarations

ipc-use-tgid.patch
  ipc/sem.c: ->pid to ->tgid changes

voyager-cpumask_t-fix.patch
  make voyager work again after the cpumask_t changes

mtrr-attrib_to_str-consolidation.patch
  mtrr cleanups

ioctl_end-fix.patch
  compat ioctl_table fix

raw-driver-fixes.patch
  raw driver oops fix

ipc_init-shuffle.patch
  ipc_init() uses vmalloc too early

zone-pressure-fixes.patch
  vmscan: zone pressure calculation fix

zone-pressure-simplification.patch
  vmscan: zone pressure simplification and fix

cfq-3.patch
  CFQ io scheduler

sysfs-memleak-fix.patch
  Fix sysfs memory leak

remove-dead-sse-checks.patch
  Remove SSE2 bugs.h check

hpet-01-late-time_init.patch
  HPET 1/6: Support for HPET based timer

hpet-02-boot-time-parsing.patch
  HPET 2/6: Support for HPET based timer

hpet-03-misc.patch
  HPET 3/6: Support for HPET based timer

hpet-03-misc-tweaks.patch

hpet-04-core.patch
  HPET 4/6: Support for HPET based timer

hpet-05-timer-services.patch
  HPET 5/6: Support for HPET based timer

hpet-05-timer-services-tweaks.patch

hpet-06-rtc-emulation.patch
  HPET 6/6: Support for HPET based timer

advansys-procfs-fix.patch
  fix advansys.c if !CONFIG_PROC_FS

usb-serial-oops-fix.patch
  Fix oopses with usb-serial devices

handle-setup_swap_extents-error.patch
  handle setup_swap_extents() error in swapon.

aha1542-oops-fix.patch
  scsi_unregister() oops fix

cosa-free_netdev-fix.patch
  cosa.c free_netdev typo

tty_files-oops-fix.patch
  tty oops fix

remove-kcore-aout.patch
  kill CONFIG_KCORE_AOUT

VT8231-router-detection.patch
  VT8231 IRQ router detection

block-devfs-conversions.patch
  Initialise devfs_name in various block drivers

test4-pm1.patch
  power management update

kobject-unlimited-name-lengths.patch
  kobject: Support unlimited name lengths.

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

sched-CAN_MIGRATE_TASK-fix.patch
  CAN_MIGRATE fix

sched-balance-fix-2.6.0-test3-mm3-A0.patch
  sched-balance-fix-2.6.0-test3-mm3-A0

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

o18int.patch
  O18int

o18.1int.patch
  O18.1int

sched-cpu-migration-fix.patch
  sched: task migration fix

o19int.patch
  O19int

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

4g4g-preempt-vstack-fix.patch
  4G/4G preempt on vstack

4g4g-kmap-warning-comments.patch
  4G/4G: even number of kmap types

4g4g-slab-__get_user-fix.patch
  4g4g: fix __get_user in slab

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

cyclone-fixmap-fix.patch
  cyclone time fixmap fix

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

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

aio-O_SYNC-fix-missing-bit.patch
  aio-O_SYNC-fix bits got lost

O_SYNC-speedup-nolock-fix.patch

aio-writev-nsegs-fix.patch
  aio: writev nr_segs fix

aio-remove-lseek-triggerable-BUG_ONs.patch

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup

aio-osync-fix-2.patch
  More AIO O_SYNC related fixes



