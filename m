Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbTICGSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263501AbTICGSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:18:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262979AbTICGRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:17:41 -0400
Date: Tue, 2 Sep 2003 23:18:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test4-mm5
Message-Id: <20030902231812.03fae13f.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/

. Dropped out Con's CPU scheduler work, added Nick's.  This is to help us
  in evaluating the stability, efficacy and relative performance of Nick's
  work.

  We're looking for feedback on the subjective behaviour and on the usual
  server benchmarks please.


. Random other stuff.



Changes since 2.6.0-test4-mm4:


 linus.patch

 Latest from Linus

-handle-unreadable-dot-config.patch
-huge-net-update.patch
-disable-athlon-prefetch.patch
-sis900-atomicity-fix.patch
-x86_64-update-3.patch
-random-locking-fixes.patch
-random-accounting-and-sleeping-fixes.patch
-yenta-20030817-1-zv.patch
-yenta-20030817-2-override.patch
-yenta-20030817-3-sockinit.patch
-yenta-20030817-4-pm.patch
-yenta-20030817-5-pm2.patch
-yenta-20030817-6-init.patch
-yenta-20030817-7-quirks.patch
-proc-pid-setuid-ownership-fix.patch
-pid-revalidate-security-hook.patch
-dac960-GAM-IOCTLs-cleanup.patch
-kj-maintainers.patch
-ide-docs-update.patch
-v4l-use-after-free-fix.patch
-ikconfig-makefile-update.patch
-ftape-warning-fix.patch
-jffs-retval-fix.patch
-make-ACPI_SLEEP-select-SOFTWARE_SUSPEND.patch
-3GB-personality.patch
-zeromap_pmd_range-fix.patch
-no-async-write-errors-on-close.patch
-sis190-fix.patch
-remove-add_wait_queue_cond.patch
-spin_lock_irqrestore-fixes.patch
-pcmciamtd-fix.patch
-zoran-memleak-fixes.patch
-zoran-rename-debug.patch
-zoran-release-callback.patch
-zoran-pci_disable_device.patch
-zoran-cleanups.patch
-zoran-cleanups-2.patch
-zoran-naming-fix.patch
-airo-build-fix.patch
-m68k-vmlinux_lds-move.patch
-mac-ide-fix.patch
-m68k-asm-sections-fix.patch
-m68k-asm-local.patch
-amiga-z2ram-fix.patch
-amiga-floppy-fix.patch
-atari-floppy-fix.patch
-m68k-switch_to-fix.patch
-pcxx-warning-fix.patch
-pcnet32-unregister_pci-fix.patch
-hwifs-oops-unregister-fix.patch
-c99-conversions.patch
-cyc2x-fixes.patch
-noacpi-option-fix.patch
-h8300-interrupt-fix.patch
-proc-kallsyms-caching-fix.patch
-proc-kallsyms-permission-fix.patch
-cu3088-string-null-termination-fix.patch
-kobject-doc-addition.patch
-vm_enough_memory-speedup.patch
-abi-doc-update.patch
-remove-bio-boot-messages.patch
-ni5010-build-fix.patch
-sis190-build-fix.patch
-nopage-fix.patch
-parport_pc-rmmod-oops-fix.patch
-reiserfs-writepage-fix.patch
-visws-build-fix.patch
-cciss-queue-init-fix.patch
-htree-big-endian-fix.patch
-selinux-file-fcntl-fix.patch
-selinux-avtab-fix.patch
-selinux-format-specifiers-fix.patch
-selinux-binprm-hooks-rework.patch
-ext2-xattr-typo-fix.patch
-bad-inode-ops.patch
-kcore-aout-build-fix.patch
-nfs4proc-warnings-fix.patch
-bluetooth-warning-fixes.patch
-nopage-rss-accounting-fix.patch
-sonypi-update.patch
-meye-update.patch
-jbd-stfu.patch
-proc-pid-maps-32-bit-fix.patch
-acpi-pci-link-fix.patch
-rusage-context-switch-counters.patch
-rusage-context-switch-counters-fix.patch
-large-dev_t-01.patch
-large-dev_t-02.patch
-large-dev_t-03.patch
-large-dev_t-04.patch
-large-dev_t-05.patch
-large-dev_t-06.patch
-large-dev_t-07.patch
-large-dev_t-08.patch
-large-dev_t-09.patch
-large-dev_t-10.patch
-large-dev_t-11.patch
-large-dev_t-12.patch
-large-dev_t-12-fix.patch
-size_t-printk-warning-fixes.patch
-stallion-build-fix-2.patch
-evdev_ioctl-fix.patch
-as-no-initial-antic.patch
-hch-contacts-update.patch
-h8300-include-update.patch
-cyclades-isa-fix.patch
-old-module-tools-warning.patch
-old-module-tools-warning-fix.patch
-arcnet-printk-fix.patch
-floppy-cleanup.patch
-floppy-more-cleanup.patch
-v850-nommu-export-fixes.patch
-v850-RODATA-fix.patch
-dnotify-use-tgid.patch
-send_sigio-decl-fix.patch
-ipc-use-tgid.patch
-voyager-cpumask_t-fix.patch
-mtrr-attrib_to_str-consolidation.patch
-ioctl_end-fix.patch
-raw-driver-fixes.patch
-ipc_init-shuffle.patch
-zone-pressure-fixes.patch
-zone-pressure-simplification.patch
-remove-dead-sse-checks.patch
-hpet-01-late-time_init.patch
-hpet-02-boot-time-parsing.patch
-hpet-03-misc.patch
-hpet-03-misc-tweaks.patch
-hpet-04-core.patch
-hpet-05-timer-services.patch
-hpet-05-timer-services-tweaks.patch
-hpet-06-rtc-emulation.patch
-advansys-procfs-fix.patch
-usb-serial-oops-fix.patch
-handle-setup_swap_extents-error.patch
-aha1542-oops-fix.patch
-cosa-free_netdev-fix.patch
-tty_files-oops-fix.patch
-remove-kcore-aout.patch

 Merged

-deadline-requeue-workaround.patch

 Dropped: fixed properly.

-tdfx-build-fix.patch

 Folded into fbdev.patch

+misc34.patch

 Misc fixes

+cfq-3-fixes.patch

 CFQ IO scheduler fix

+ide-pm-oops-fix.patch

 IDE power management fix

+kobject-unlimited-name-lengths-use-after-free-fix.patch

 kobject oops fix

+convert-proc-stat-to-seq_file.patch

 Use seqfile for /proc/stat

+get_rtc_time-fix.patch

 RTC-vs-HPET fixes

+ricoh-mask-fix.patch

 PCMCIA fix

+visws-qla1280-needs-pio.patch

 SCSI fix

+dac960-devfs_name-fix.patch

 Fix devfs on DAC960

+ikconfig-gzipped.patch

 Move the ikconfig info to /proc/config.gz

+flush-invalidate-fixes.patch
+flush-invalidate-fixes-warning-fix.patch

 Lots of rework of the cache flushing API and code.  From DaveM

+elv-insertion-fix.patch

 IO scheduler fixes

+8250_acpi-taints-kernel.patch

 Add copyright to 8250_acpi.c

+proc_misc-build-fix.patch

 Compile fix

+slab-check-PG_slab.patch

 More slab debugging

+ide_floppy-maybe-fix.patch

 Try to mend ide_floppy

+might_sleep-improvements.patch

 Extra atomicity debug work.

+MODULE_ALIAS-in-block-devices.patch
+MODULE_ALIAS-in-char-devices.patch

 Module autoloading support

+unpercpuify-in_flight-counter.patch

 microoptimise disk stats accumulation

+enable-selinux-with-boot-parameter.patch

 SELinux requires "selinux" on the kernel boot command line

+pty-devfs-fix.patch

 sort-of fix old-style pty's

+i8042-free_irq-fix.patch

 i8042 IRQ management fixlet.

+reiserfs-direct-io.patch

 direct-IO support for reiserfs

+pdflush-diag.patch

 debug stuff

+netlink-warning-fixes.patch

 Warnig fixes

+really-use-english-date-in-version-string.patch

 Locale fixes for the kernel version string

+acpi-pci-routing-fixes.patch

 ACPI fixes

+psmouse_ipms2-option.patch

 Add psmouse_ipms2 module/boot parameter to force PS/2 IPMS2 protocol

+i8042-history.patch

 Extra i8042 debug support

-sched-CAN_MIGRATE_TASK-fix.patch
-sched-balance-fix-2.6.0-test3-mm3-A0.patch
-sched-2.6.0-test2-mm2-A3.patch
-ppc-sched_clock.patch
-ppc64-sched_clock.patch
-sparc64_sched_clock.patch
-x86_64-sched_clock.patch
-sched-warning-fix.patch
-sched-balance-tuning.patch
-sched-no-tsc-on-numa.patch
-o12.2int.patch
-o12.3.patch
-o13int.patch
-o13.1int.patch
-o14int.patch
-o14int-div-fix.patch
-o14.1int.patch
-o15int.patch
-o16int.patch
-o16.1int.patch
-o16.2int.patch
-o16.3int.patch
-o18int.patch
-o18.1int.patch
-sched-cpu-migration-fix.patch

 Dropped

+np-sched-01-sched-fork-cleanup.patch
+np-sched-02-sched-migrate-fix.patch
+np-sched-03-sched-balance-tuning.patch
+np-sched-04-sched-policy-10b.patch

 Added.

-4g4g-preempt-vstack-fix.patch
-4g4g-kmap-warning-comments.patch
-4g4g-slab-__get_user-fix.patch
-4g4g-vmlinux-update-got-lost.patch
-4g4g-do_page_fault-cleanup.patch
-4g4g-cleanups.patch
-kgdb-4g4g-fix-2.patch
-4g4g-config-fix.patch
-4g4g-pmd-fix.patch
-4g4g-wli-fixes.patch
-4g4g-fpu-fix.patch
-4g4g-show_registers-fix.patch
-4g4g-pin_page-atomicity-fix.patch
-4g4g-remove-touch_all_pages.patch
-4g4g-debug-flags-fix.patch
-4g4g-TI_task-fix.patch
-cyclone-fixmap-fix.patch

 Folded into 4g-2.6.0-test2-mm2-A5.patch





All 141 patches

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

sym-do-160.patch
  make the SYM driver do 160 MB/sec

rt-tasks-special-vm-treatment.patch
  real-time enhanced page allocator and throttling

rt-tasks-special-vm-treatment-2.patch

input-use-after-free-checks.patch
  input layer debug checks

fbdev.patch
  framebbuffer driver update

cursor-flashing-fix.patch
  fbdev: fix cursor letovers

misc34.patch
  misc fixes

slab-hexdump.patch
  slab: hexdump structures when things go wrong

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

thread-pgrp-fix-2.patch
  Fix setpgid and threads

ramdisk-cleanup.patch

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

intel8x0-cleanup.patch
  intel8x0 cleanups

claim-serio-early.patch
  Serio: claim serio early

fix-strange-code-in-bio_add_page.patch
  Fix odd code in bio_add_page

mark-devfs-obsolete.patch
  mark devfs obsolete

cfq-3.patch
  CFQ io scheduler

cfq-3-fixes.patch
  CFQ fixes

sysfs-memleak-fix.patch
  Fix sysfs memory leak

VT8231-router-detection.patch
  VT8231 IRQ router detection

block-devfs-conversions.patch
  Initialise devfs_name in various block drivers

test4-pm1.patch
  power management update

ide-pm-oops-fix.patch
  IDE power management oops fix

kobject-unlimited-name-lengths.patch
  kobject: Support unlimited name lengths.

kobject-unlimited-name-lengths-use-after-free-fix.patch
  kobject_cleanup() use-after-free-fix

convert-proc-stat-to-seq_file.patch
  convert /proc/stat to seq_file

get_rtc_time-fix.patch
  Fix rtc symbol clash and HPET config problems

ricoh-mask-fix.patch
  pcmcia: ricoh.h mask fix
  EDEC
  From: KOMURO <komujun@nifty.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
  
  RL5C4XX_16BIT_MEM_0 was wrong.

visws-qla1280-needs-pio.patch
  add config option for qla1280 SCSI MMIO/ioport selection

dac960-devfs_name-fix.patch
  dac960 devfs_name initialisation fix

ikconfig-gzipped.patch
  Move ikconfig to /proc/config.gz

flush-invalidate-fixes.patch
  memory writeback/invalidation fixes

flush-invalidate-fixes-warning-fix.patch

elv-insertion-fix.patch
  elevator insertion fixes

8250_acpi-taints-kernel.patch
  8250_acpi taints kernel

proc_misc-build-fix.patch
  proc_misc.c needs irq.h

slab-check-PG_slab.patch
  more slab page checking

ide_floppy-maybe-fix.patch
  might fix ide_floppy

might_sleep-improvements.patch
  might_sleep() improvements

MODULE_ALIAS-in-block-devices.patch
  MODULE_ALIAS() in block devices

MODULE_ALIAS-in-char-devices.patch
  MODULE_ALIAS() in char devices

unpercpuify-in_flight-counter.patch
  Remove percpufication of in_flight counter in diskstats

enable-selinux-with-boot-parameter.patch
  Enable SELinux via boot parameter

pty-devfs-fix.patch
  devfs pty fix

i8042-free_irq-fix.patch
  i8042 free_irq() aliasing fix

reiserfs-direct-io.patch
  resierfs direct-IO support

pdflush-diag.patch

netlink-warning-fixes.patch

really-use-english-date-in-version-string.patch
  really use english date in version string

acpi-pci-routing-fixes.patch
  Fixing USB interrupt problems with ACPI enabled

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

psmouse_ipms2-option.patch
  Force mouse detection as imps/2 (and fix my KVM switch)

i8042-history.patch
  debug: i8042 history dumping

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

np-sched-01-sched-fork-cleanup.patch
  move fork-related code to fork.c

np-sched-02-sched-migrate-fix.patch
  scheduler migration fix

np-sched-03-sched-balance-tuning.patch
  scheduler balancing tuning

np-sched-04-sched-policy-10b.patch
  scheduler policy changes

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
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
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



