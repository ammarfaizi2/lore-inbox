Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTISG23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 02:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbTISG22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 02:28:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:17116 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261352AbTISG2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 02:28:03 -0400
Date: Thu, 18 Sep 2003 23:29:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test5-mm3
Message-Id: <20030918232908.2156e269.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm3/


Lots of random things.



 linus.patch

 Latest Linus tree

-smbfs-fixes.patch
-as-documentation.patch
-lsm-CREDITS.patch
-lsm-MAINTAINERS.patch
-lsm-comment-fix.patch
-lsm-rootplug-fix.patch

 Merged

+kgdb-buff-too-big.patch

 kgdb print buffer overrun fix

+acpi-20030916.patch

 Latest ACPI drop

+ecc-support.patch

 Add support for Intel ECC compiler, rationalise compiler support
 infrastructure.

-acpi-irq-fixes.patch

 ACPI patch broke this

+acpi_disabled-fix.patch

 acpi_disabled cannot be __initdata

-ide-pm-oops-fix.patch

 This was fixed by other means

+dgap-cleanups.patch

 Fiddle with dgap.patch

+misc35.patch

 Misc fixes

-file-locking-leak-fix.patch
+flock-memleak2.patch

 Updated file locks leak fix

+futex_lock-splitup.patch

 Futex scalability

+futex-uninlinings.patch

 futex debloating

+elv-doc.patch

 Update BIO documentation

+sysfs_remove_dir-leak-fix.patch

 Fix a leak

+modpost-typo-fix.patch

 Fix a tpyo

+sbni-compile-fix.patch

 Compile fix

+filesystem-option-parsing.patch
+befs-use-parser.patch

 Consolidated parser for filesystem mount options

+do_no_page-debug.patch

 Add some debug to do_no_page() to catch some bug which was in arch/ppc64
 anyway.

+node-enumeration-cleanup-01.patch
+node-enumeration-cleanup-02.patch
+node-enumeration-cleanup-03.patch
+node-enumeration-cleanup-04.patch
+node-enumeration-cleanup-05.patch

 Clean up the NUMA node enumeration dogpile, permit 1024 zones on ia64.

+export-new-cdev-functions.patch

 Missing EXPORT_SYMBOLs

+INPUT_KEYCODE-fix.patch

 Keyboard table tyop fix.

+reenable-athlon-prefetch.patch

 Athlon prefetch erratum handler

+hangcheck-compile-fix.patch

 Don't allow hangcheck to be built on architectures which don't support
 monotonic_clock().

+fix-make-rpm.patch

 Temp fix `make rpm'.

+NCR5380-timeout-fix.patch

 Fix the 5380 scsi driver.

+SIGRTMAX-fix.patch

 SIGRTMAX was off-by-one.

+hugetlbfs-accounting-fix.patch

 hugetlbfs page accouning was wrong.

+zap_page_range-debug.patch

 Check that some code which should be dead really is.

+x445-no-ioapic-check.patch

 32-way x445s have too many IO APICs

+deadline-insert_here-fix.patch

 deadline scheduler cleanup

+bio_dirty_fn-release-fix.patch
+direct-io-skip-compound-pages.patch

 Fix bugs in direct-io completion page dirtying code.

+e1000-build-fix.patch

 Make e1000 compile on old gccs

+right-ctrl-scancode-fix.patch

 keyboard fix

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
-o19int.patch
-o20int.patch
-o20.1int.patch
+sched-interactivity.patch

 Rolled all Con's patches up.

+gang_lookup_next.patch
+aio-gang_lookup-fix.patch
+aio-O_SYNC-short-write-fix.patch

 Various AIO+O_SYNC fixes

+O_DIRECT-race-fixes-fixes-2.patch

 Fix for the O_DIRECT-vs-buffered IO race fix





All 185 patches


linus.patch
  cset-20030917_2214.txt.gz

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix

kgdb-buff-too-big.patch
  kgdb buffer overflow fix

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

acpi-20030916.patch
  acpi-20030916

ecc-support.patch
  ECC support

separate-output-dir.patch
  kbuild: Separate output directory support

acpi_disabled-fix.patch
  acpi_disabled fix

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

sched-2.6.0-test2-mm2-A3.patch
  sched-2.6.0-test2-mm2-A3

ppc-sched_clock.patch
  sched_clock() for ppc, ppc64 and sparc64

sched-balance-tuning.patch
  CPU scheduler balancing fix

sched-interactivity.patch
  CPU scheduler interactivity changes

test5-pm2.patch

test5-pm2-fix.patch

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

dgap-cleanups.patch
  dgap driver cleanups

misc35.patch
  misc fixes

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

flock-memleak2.patch
  file locking memory leak

init-argv-fix.patch
  fix incorrect argv[0] for init

ens1370-name-fix.patch
  ens1370 PCI driver naming fix

summit-apic-numbering-rework.patch
  Summit sub-arch: Make logical IDs independent of BIOS numbering scheme

wanXL-driver.patch
  wanXL serial card driver

floppy-pending-timer-fix.patch
  floppy cleanup timers/resources on unload

remove-config_build_info.patch
  remove /proc/config_build_info

access_ok-is-likely.patch
  access_ok is likely

kobject-oops-fixes.patch
  fix oopses is kobject parent is removed before child

futex_lock-splitup.patch
  Split futex global spinlock futex_lock

futex-uninlinings.patch
  futex uninlining

elv-doc.patch
  Update Documentation/block/biodoc.txt

sysfs_remove_dir-leak-fix.patch
  sysfs_remove_dir leak fix

modpost-typo-fix.patch
  Fix typo in scripts/postmod.c

sbni-compile-fix.patch
  fix sbni.c compile with gcc 3.3

filesystem-option-parsing.patch
  table-driven filesystems option parsing

befs-use-parser.patch
  BEFS: Use table-driven option parsing

do_no_page-debug.patch

node-enumeration-cleanup-01.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [1/5]

node-enumeration-cleanup-02.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [2/5]

node-enumeration-cleanup-03.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [3/5]

node-enumeration-cleanup-04.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [4/5]

node-enumeration-cleanup-05.patch
  Clean up MAX_NR_NODES/NUMNODES/etc. [5/5]

export-new-cdev-functions.patch
  Export new char dev functions

INPUT_KEYCODE-fix.patch
  Fix INPUT_KEYCODE macro

reenable-athlon-prefetch.patch
  Athlon/Opteron Prefetch Fix

hangcheck-compile-fix.patch
  hangcheck compile fix

fix-make-rpm.patch
  Fix `make rpm'

NCR5380-timeout-fix.patch
  NCR5380 timeout fix

SIGRTMAX-fix.patch
  Incorrect value for SIGRTMAX in the kernel

hugetlbfs-accounting-fix.patch
  Hugetlb FS quota accounting problem

zap_page_range-debug.patch
  zap_page_range() debug

x445-no-ioapic-check.patch
  x445: setup_ioapic_ids_from_mpc fix

deadline-insert_here-fix.patch
  deadline insert_here fix

bio_dirty_fn-release-fix.patch
  bio_dirty_fn() page leak fix

direct-io-skip-compound-pages.patch
  Speed up direct-io hugetlbpage handling

e1000-build-fix.patch

right-ctrl-scancode-fix.patch
  fix keycode for rctrl in scancode set 3

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

gang_lookup_next.patch
  Change the page gang lookup API

aio-gang_lookup-fix.patch
  AIO gang lookup fixes

aio-O_SYNC-short-write-fix.patch
  Fix for O_SYNC short writes

O_DIRECT-race-fixes.patch
  DIO fixes forward port and AIO-DIO fix

O_DIRECT-race-fixes-fixes.patch

O_DIRECT-race-fixes-commentary.patch
  O_DIRECT race fixes comments

O_DIRECT-race-fixes-fixes-2.patch
  O_DRIECT race fixes fix fix fix



