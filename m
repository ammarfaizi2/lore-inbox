Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbTIOGs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 02:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTIOGs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 02:48:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262443AbTIOGs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 02:48:28 -0400
Date: Sun, 14 Sep 2003 23:48:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test5-mm2
Message-Id: <20030914234843.20cea5b3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm2/




Changes since 2.6.0-test5-mm1:


+linus.patch

 Latest Linus tree

-calibrate_tsc-consolidation.patch
-ppc64-build-fixes.patch
-ppc64-local.patch
-block-devfs-conversions.patch
-timer_tsc-cyc2ns_scale-fix.patch
-ricoh-mask-fix.patch
-dac960-devfs_name-fix.patch
-dac960-warning-fixes.patch
-ikconfig-gzipped-2.patch
-reiserfs-direct-io.patch
-imm-fix-fix.patch
-selinux-option-config-option.patch
-sound-remove-duplicate-includes.patch
-kernel-remove-duplicate-includes.patch
-NR_CPUS-overflow-fix.patch
-ppp-oops-fix.patch
-d_delete-d_lookup-race-fix.patch
-idle-using-monitor-mwait.patch
-idle-using-monitor-mwait-tweaks.patch
-remap_file_pages-MAP_NONBLOCK-fix.patch
-install_page-use-after-unmap-fix.patch
-really-use-english-date-in-version-string.patch
-inflate-error-cleanup.patch
-mwave-locking-fixes.patch
-summit-includes-fix.patch
-random-lock-contention.patch
-ifdown-lockup-fix.patch
-fadvise-needs-asmlinkage.patch
-ufs-build-fix.patch
-sched-CAN_MIGRATE_TASK-fix.patch

 Merged

+separate-output-dir.patch

 kbuild support for separate src/ouytput directories

+acpi_off-fix.patch

 Fix `acpi=off' command line handling

+group_leader-rework-fix.patch

 Build fix

-VT8231-router-detection.patch

 Dropped: we need to forward-port the 2.4 IRQ router rework

+uml-update.patch

 Latest UML drop fro Jeff

+md-make_request-crash-fix.patch

 RAID fix

+reiserfs-large-file-fix.patch

 reiserfs fix for files larger than 4G

+irq-vector-overflow-check.patch

 debug check for huge ia32 machines

+mtrr-warning-fix.patch

 Warning fix.

+nls-alias-fixes.patch
+nls-elisp-removal.patch

 NLS fixes/cleanups

+sysfs-dput-fix.patch

 sysfs oops fix

-test4-pm1.patch
+test5-pm2.patch
+test5-pm2-fix.patch

 New power management code from Pat.

-swsusp-fpu-fix.patch

 Merged into the above

+slab-debug-additions-fix.patch

 Slab debug

+remove-smp-txt.patch

 Remove Documentation/smp.tex

+mwave-needs-8250.patch

 kconfig fix

+any_online_cpu-fix.patch

 cpumask_t fix

+numa-detection-fail-fix.patch

 NUMA cpu detection fix

+dgap.patch

 Digi Acceleport driver

+reiserfs-consistency-checks.patch

 reiserfs fixes

+remove-dupe-SOUND_RME96XX.patch

 kconfig cleanup

+istallion-build-fix.patch

 Compile fix

+pdc4030-update.patch
+ali14xx-update.patch
+dtc2278-update.patch
+ht6560b-update.patch
+qd65xx-update.patch
+umc8672-update.patch

 IDE updates

+file-locking-leak-fix.patch

 memleak fix

+init-argv-fix.patch

 Get argv[0] right for `init='

+ens1370-name-fix.patch

 Sounds driver oops fix

+summit-apic-numbering-rework.patch

 Summit fix

+smbfs-fixes.patch

 SMB filsystem fixes

+wanXL-driver.patch

 SBE Inc.  wanXL 4-port sync serial card driver

+as-documentation.patch

 Documentation for the anticipatory IO scheduler

+lsm-CREDITS.patch
+lsm-MAINTAINERS.patch
+lsm-comment-fix.patch
+lsm-rootplug-fix.patch

 LSM stuff

+floppy-pending-timer-fix.patch

 Floppy rmmod crashfix

+remove-config_build_info.patch

 Remove /proc/config_build_info

+access_ok-is-likely.patch

 mark access_ok() as unlikely

+kobject-oops-fixes.patch

 Various kobject layer fixes

-linux-isp-2.patch
-linux-isp-2-fix-again.patch
-feral-bounce-fix.patch
-feral-bounce-fix-2.patch

 Dropped the feral driver: it's broken and old.

-sched-balance-fix-2.6.0-test3-mm3-A0.patch
-sched-cpu-migration-fix.patch

 These duplicated other things: dropped

+o20.1int.patch

 Interactivity fix

+4g4g-might_sleep-warning-fix.patch

 4G/4G fix

-io_submit_one-EINVAL-fix.patch
-aio-05-fs_write-fix.patch
-aio-06-bread_wq-fix.patch
-aio-O_SYNC-fix-missing-bit.patch
-O_SYNC-speedup-nolock-fix.patch
-aio-writev-nsegs-fix.patch
-aio-remove-lseek-triggerable-BUG_ONs.patch

 Various AIO patches were folded into various other AIO patches.

+O_DIRECT-race-fixes.patch
+O_DIRECT-race-fixes-fixes.patch
+O_DIRECT-race-fixes-commentary.patch

 Forward-port from 2.4 of Stephen Tweedie's O_DIRECT information leak fixes.




All 176 patches


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

kgdb-over-ethernet.patch
  kgdb-over-ethernet patch

kgdb-over-ethernet-fixes.patch
  kgdb-over-ethernet fixlets

kgdb-CONFIG_NET_POLL_CONTROLLER.patch
  kgdb: replace CONFIG_KGDB with CONFIG_NET_RX_POLL in net drivers

kgdb-handle-stopped-NICs.patch
  kgdb: handle netif_stopped NICs

eepro100-poll-controller.patch

tlan-poll_controller.patch

tulip-poll_controller.patch

tg3-poll_controller.patch
  kgdb: tg3 poll_controller

kgdb-eth-smp-fix.patch
  kgdb-over-ethernet: fix SMP

kgdb-eth-reattach.patch

kgdb-skb_reserve-fix.patch
  kgdb-over-ethernet: skb_reserve() fix

separate-output-dir.patch
  kbuild: Separate output directory support

acpi-irq-fixes.patch
  Next round of ACPI IRQ fixes (VIA ACPI fixed)

acpi_off-fix.patch
  fix acpi=off

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

no-unit-at-a-time.patch
  Use -fno-unit-at-a-time if gcc supports it

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

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

slab-hexdump.patch
  slab: hexdump structures when things go wrong

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

group_leader-rework.patch
  Fix setpgid and threads
  use group_leader->pgrp (was Re: setpgid and threads)

group_leader-rework-fix.patch
  group_leader fix fix

ramdisk-cleanup.patch

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

intel8x0-cleanup.patch
  intel8x0 cleanups

claim-serio-early.patch
  Serio: claim serio early

mark-devfs-obsolete.patch
  mark devfs obsolete

uml-update.patch
  Update UML to 2.6.0-test5

md-make_request-crash-fix.patch
  md: crash fix

reiserfs-large-file-fix.patch
  reiserfs: large file 32/64-bit truncation fix

irq-vector-overflow-check.patch
  Overflow check for i386 assign_irq_vector

mtrr-warning-fix.patch
  mtrr warning fix w/o proc_fs

nls-alias-fixes.patch
  NLS: Remove the nls modules for only alias

nls-elisp-removal.patch
  NLS: remove emacs metadata

sysfs-dput-fix.patch
  sysfs dput fix

test5-pm2.patch

test5-pm2-fix.patch

ide-pm-oops-fix.patch
  IDE power management oops fix

flush-invalidate-fixes.patch
  memory writeback/invalidation fixes

flush-invalidate-fixes-warning-fix.patch

ide_floppy-maybe-fix.patch
  might fix ide_floppy

pdflush-diag.patch

joydev-exclusions.patch
  joydev is too eager claiming input devices

might_sleep-diags.patch

utime-on-immutable-file-fix.patch
  disallow utime{s}() on immutable or append-only files

add-daniele-to-credits.patch
  add Daniele to CREDITS

agp-build-fix.patch
  AGPGART_MINOR needs <linux/agpgart.h>

slab-debug-additions.patch
  Move slab objects to the end of the real allocation
  slab debug fix

slab-debug-additions-fix.patch
  From: Manfred Spraul <manfred@colorfullife.com>
  Subject: [PATCH] Bugfix for my last slab patch

remove-smp-txt.patch
  Remove Documentation/smp.tex

agp-warning-fix.patch
  AGP warning fix

mwave-needs-8250.patch
  mwave char/Kconfig fix

any_online_cpu-fix.patch
  any_online_cpu-fix

numa-detection-fail-fix.patch
  allow x86 NUMA architecture detection to fail

dgap.patch
  New DGAP driver

reiserfs-consistency-checks.patch
  reiserfs: add checks from 2.4 into 2.5

remove-dupe-SOUND_RME96XX.patch
  remove duplicate SOUND_RME96XX option

istallion-build-fix.patch
  istallion: use schedule_work

pdc4030-update.patch
  update pdc4030 driver

ali14xx-update.patch
  update ali14xx driver

dtc2278-update.patch
  update dtc2278 driver

ht6560b-update.patch
  update ht6560b driver

qd65xx-update.patch
  update qd65xx driver

umc8672-update.patch
  update umc8672 driver

file-locking-leak-fix.patch
  file locking memory leak

init-argv-fix.patch
  fix incorrect argv[0] for init

ens1370-name-fix.patch
  ens1370 PCI driver naming fix

summit-apic-numbering-rework.patch
  Summit sub-arch: Make logical IDs independent of BIOS numbering scheme

smbfs-fixes.patch
  smbfs: module unload and highuid

wanXL-driver.patch
  wanXL serial card driver

as-documentation.patch
  AS documentation

lsm-CREDITS.patch
  LSM: update credits

lsm-MAINTAINERS.patch
  LSM: add maintainer entry

lsm-comment-fix.patch
  LSM: comment fixup

lsm-rootplug-fix.patch
  LSM: root_plug fixup

floppy-pending-timer-fix.patch
  floppy cleanup timers/resources on unload

remove-config_build_info.patch
  remove /proc/config_build_info

access_ok-is-likely.patch
  access_ok is likely

kobject-oops-fixes.patch
  fix oopses is kobject parent is removed before child

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

psmouse_ipms2-option.patch
  Force mouse detection as imps/2 (and fix my KVM switch)

i8042-history.patch
  debug: i8042 history dumping

keyboard-resend-fix.patch
  keyboard resend fix

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch
  print a few config options on oops

show_task-free-stack-fix.patch
  show_task() fix and cleanup

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

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

sched-2.6.0-test2-mm2-A3.patch
  sched-2.6.0-test2-mm2-A3

ppc-sched_clock.patch

ppc64-sched_clock.patch
  ppc64: sched_clock()

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

o19int.patch
  O19int

o20int.patch
  O20int

o20.1int.patch
  O20.1int

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

4g4g-cyclone-timer-fix.patch

4g4g-copy_mount_options-fix.patch
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c

4g4g-might_sleep-warning-fix.patch
  4G/4G might_sleep warning fix

4g4g-pagetable-accounting-fix.patch
  4g/4g pagetable accounting fix

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

aio-01-retry.patch
  AIO: Core retry infrastructure
  Fix aio process hang on EINVAL

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-06-bread_wq.patch
  AIO: Async block read

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
  task task_lock in use_mm()

aio-O_SYNC-fix.patch
  Unify o_sync changes for aio and regular writes
  aio-O_SYNC-fix bits got lost
  aio: writev nr_segs fix

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup

aio-osync-fix-2.patch
  More AIO O_SYNC related fixes

O_DIRECT-race-fixes.patch
  DIO fixes forward port and AIO-DIO fix

O_DIRECT-race-fixes-fixes.patch

O_DIRECT-race-fixes-commentary.patch
  O_DIRECT race fixes comments



