Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUFNJMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUFNJMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 05:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUFNJMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 05:12:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:20960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262138AbUFNJLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 05:11:08 -0400
Date: Mon, 14 Jun 2004 02:10:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc3-mm2
Message-Id: <20040614021018.789265c4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm2/

- Mainly lots of little fixes.

- Added the ext3 online-resize patch.  See
  http://sourceforge.net/projects/ext2resize/ for some details.  Needs a bit
  of work, and documentation.



Changes since 2.7.6-rc3-mm1:

 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-input.patch
 bk-netdev.patch
 bk-pci.patch
 bk-scsi.patch
 bk-usb.patch

 latest versions of external trees

-wake_up_forked_thread-fix.patch
-w83627hf-build-fix.patch
-arp_tables-build-fix.patch
-jbd-descriptor-buffer-state-fix.patch
-speedup-flush_workqueue-for-singlethread_workqueue.patch
-mm-get_user_pages-vs-try_to_unmap.patch
-fix-missing-option-in-binutils-version-check.patch
-ppc64-iseries-vio_dev-cleanups.patch
-writeback_inodes-can-race-with-unmount.patch
-fealnx-mac-address-and-other-issues.patch
-vmscan-handle-synchronous-writepage.patch
-vmscan-handle-synchronous-writepage-fix.patch
-ramdisk-buffer-uptodate-fix.patch
-vmscan-GFP_NOFS-try-harder.patch
-unalign-page_state.patch
-vmscanc-move-writepage-invocation-into-its-own-function.patch
-vmscanc-struct-scan_control.patch
-runtime-selection-of-config_paride_epatc8.patch
-ext3-journal_flush-needs-journal_lock_updates.patch
-typo-in-documentation-fb-framebuffertxt.patch
-more-drivers-atm-horizonc-polishing.patch
-disable-unnecessary-printk-in-es7000-code.patch
-disable-udf-debugging.patch
-__arch_want_sys_rt_sigaction-fix.patch
-fix-bug-in-raid6-resync-code.patch
-cdrom-hardware-defect-mgt-header-length.patch
-s390-add-support-for-6-system-call-arguments.patch
-#dont-create-cpu-online-sysfs-file.patch
-flush_workqueue-locking-simplification.patch
-fix-pci-hotplug-of-promise-ide-cards.patch
-cyclone-pit-sanity-checking.patch
-sysctl-uts-write-size.patch
-aio-sparse-warning-fix.patch
-read_page_state.patch
-vmscan-use-read_page_state.patch
-page-writeback-use-read_page_state.patch
-vga16fb-fix-bogus-mem_start-value.patch

 Merged

+opti92x-ad1848-locking-fix.patch

 Fix locking in this sound driver

+mp_find_ioapic-must-not-be-__init.patch

 Linkage fix

+prism94-build-fix.patch

 prism94 compile fix

+ppc32-irqc-cpumask-fix.patch
+ppc64-fix-out_be64.patch

 ppc fixes

-add-i386-readq.patch
-hpet-driver-updates-move-readq.patch

 Dropped - go back to a provate implemenentation in the HPET driver.

+fix-hpet-for-acpi-changes.patch

 HPET driver fix

-sync_inodes_sb-debug.patch

 Dropped

+add-bh_eopnotsupp-for-testing.patch
+handle-async-barrier-failures.patch

 Disk barrier updates

-bsd-acct-warning-fix.patch

 Folded into bsd-accounting-format-rework.patch

+bsd-accounting-format-rework-update.patch

 BSD accounting update

+iso9660-inodes-anywhere-and-nfs.patch

 Fix the iso9660 patch for NFS's expectations.

+perfctr-if-ifdef-cleanup.patch
+perfctr-dothan-support.patch
+perfctr-cpumask-cleanup.patch

 perfctr tweaks.

+dm-1-5-kcopyd-remove-superfluous-init_list_heads.patch
+dm-2-5-kcopyd-no-need-to-lock-pages.patch
+dm-3-5-fix-error-cleanup-in-dm_create_persistent.patch
+dm-4-5-dm-zero-version.patch
+dm-5-5-documentation.patch

 Device mapper updates

+msi-target-cpus-fix.patch

 MSI driver build fix

+x86_64-numa-build-fix.patch

 x86_64 build fix

+cpumask-5-10-rewrite-cpumaskh-single-bitmap-based-cpu_mask_none-fix.patch
+s390-fix-cpu_online-redefined-warnings.patch
+alpha-cpumask-fix.patch

 cpumask fixes

+irqaction-use-cpumask.patch
+irqaction-use-cpumask-voyager-fix.patch

 use cpumasks in the IRQ code (all architectures)

+apic-fix-kicking-of-non-present-cpus.patch
+apic-remove-marking-of-non-present-physids-in-phys_cpu_present_map.patch
+apic-make-mach_default-compile-again.patch

 Fix various things in apic-enumeration-fixes.patch

+dont-create-cpu-online-sysfs-file.patch

 Some sysfs flexibility for cpu hotplug

+fix-cdrom-mt-rainier-probe.patch

 CDROM driver fix

+blk-move-threshold-unplugging.patch

 Disk unplugging fix

+fix-memory-leak-in-swsusp.patch
+pmdisk-memleak-fix.patch
+swsusp-remove-memsets.patch
+swsusp-remove-copy_pagedir.patch

 Various swsusp fixes

+decrease-stack-usage-in-ncpfss-ioctl.patch

 ncpfs stack reduction

+staticalise-update_one_process.patch

 Small cleanup

+267-rc3-drivers-char-ipmi-ipmi_devintfc-user-kernel.patch
+267-rc3-drivers-scsi-megaraidc-user-kernel-pointer-bugs.patch

 Fix dereferencing of user pointers.

+ext3-online-resize-patch.patch
+ext3-online-resize-warning-fix.patch

 ext3 online resize (expand) support.

+ia64-discontic-fix.patch

 ia64 build fix

+epoll-uses-rbtrees.patch

 Replace the epoll hash with rbtrees

+larger-io-bitmap.patch

 Expand the iopl() port range.

+permit-inode-dentry-hash-tables-to-be-allocated-max_order-size.patch
+permit-inode-dentry-hash-tables-to-be-allocated-max_order-size-warning-fix.patch

 Allocate VFS hash tables from bootmem.

+respect-edge-level-triggering-requested-in-acpi_register_gsi.patch

 Fix a lockup with IOAPIC disabled.

+ide-pci-hotplugging-fixes.patch
+ide-kill-some-useless-headers-for-pci-drivers.patch
+ide-ide-proc-fix-for-m68k.patch
+ide-kill-hw_regs_t-dma.patch
+ide-ide-pnp-update.patch
+ide-remove-alternate_state_diagram_multi_out-from-ide-taskfilec.patch
+ide-fix-ide-cd-to-not-retry-req_drive_taskfile-requests.patch
+ide-fix-req_drive_-requests-error-handling-in-ide-scsi.patch
+ide-cleanup-taskfile-pio-handlers-config_ide_taskfile_io=n.patch
+ide-tiny-task_mulout_intr-config_ide_taskfile_io=n-cleanup.patch
+ide-kill-task_map_rq.patch
+ide-check-no-of-sectors-for-in-out-commands-in-ide_diag_taskfile.patch

 IDE updates

+improved-psx-support-in-input-joystick-gameconc.patch

 Joystick driver fix

+revert-sched-improve-wakeup-affinity.patch

 Revert a CPU scheduler optimisation which didn't.

+o_noatime-support.patch

 Add O_NOATIME

+shiftpgup-if-nr-of-scrolled-lines-is-4.patch

 Console driver fix

+istallion-printk-fix.patch

 Fix a printk.

+pcwdc-patches.patch

 Watchdog driver updates

+usb-tt-oops-fix.patch

 USB oops fix

+fix-x86-64-via-systems-with-iommu-debug.patch

 x86_64 lockup fix

+lower-priority-of-too-many-keys-msg-in-atkbdc.patch

 Fix a printk facility level.

+remove-irda-usage-of-isa_virt_to_bus.patch

 IRDA cleanup

+unregister-driver-if-probing-fails-in-sb_cardc.patch

 SB driver fix

+ignore-errors-from-tw_setfeature-in-3w-xxxxc.patch

 3ware driver fix

+fake-inquiry-for-sony-clie-peg-tj25-in-unusual_devsh.patch

 Sony Clie USB driver fix

+fix-duplicate-environment-variables-passed-to-init.patch

 Fix passing of environment strings to init.

+fix-handling-of--embedded-in-filenames-in-isofs.patch

 Handle '/' chars in isofs filenames.

+fix-isofs-ignoring-noexec-and-mode-mount-options.patch

 isofs permission handling fix

+fix-thread_infoh-ignoring-__have_thread_functions.patch

 m68k build fix

+sparse-fix-to-mm-vmscanc.patch

 Fix a sparse warning.




All 310 patches:


linus.patch

opti92x-ad1848-locking-fix.patch
  opti92x-ad1848.c locking fix

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-input.patch

bk-netdev.patch

bk-pci.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

bk-input-build-fix.patch
  bk-input-build-fix

mp_find_ioapic-must-not-be-__init.patch
  mp_find_ioapic() must not be __init

prism94-build-fix.patch
  prism94 build fix

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
  kgdb: fix for recent gcc
  kgdb warning fixes
  THREAD_SIZE fixes for kgdb

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup

mp_find_ioapic-oops-fix.patch
  mp_find_ioapic cannot be __init

mm-flush-tlb-when-clearing-young.patch
  mm: flush TLB when clearing young

mm-pretest-pte_young-and-pte_dirty.patch
  mm: pretest pte_young and pte_dirty

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

radix_tree_tag_set-atomic.patch
  Make radix_tree_tag_set/clear atomic wrt the tag

radix_tree_tag_set-only-needs-read_lock.patch
  radix_tree_tag_set only needs read_lock()

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

mustfix-lists.patch
  mustfix lists

85xx+e500.l26-20040608.patch
  ppc32: support for e500 and 85xx

ppc32-irqc-cpumask-fix.patch
  ppc32 irq.c cpumask fix

ppc64-fix-out_be64.patch
  ppc64: fix out_be64

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

allow-i386-to-reenable-interrupts-on-lock-contention.patch
  Allow i386 to reenable interrupts on lock contention

pdflush-diag.patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

local_bh_enable-warning-fix.patch

schedstats.patch
  sched: scheduler statistics

cond_resched-might-sleep.patch
  cond_resched() might sleep

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

siimage-update.patch
  ide: update for siimage driver

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation
  ext3 reservations: fix performance regression
  ext3 block reservation patch set -- mount and ioctl feature
  ext3 block reservation patch set -- dynamically increase reservation window

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-reservation-ifdef-cleanup-patch.patch
  ext3 reservation ifdef cleanup patch

ext3-reservation-max-window-size-check-patch.patch
  ext3 reservation max window size check patch

ext3-reservation-file-ioctl-fix.patch
  ext3 reservation file ioctl fix

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard

ext3-reservation-bad-inode-fix.patch
  ext3 reservations: bad_inode fix

ext3_reservation_discard_race_fix.patch
  ext3 reservation discard race fix

clean-up-asm-pgalloch-include.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-2.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-3.patch
  Clean up asm/pgalloc.h include 3

ppc64-uninline-__pte_free_tlb.patch
  ppc64: uninline __pte_free_tlb()

fix-scancode-keycode-scancode-conversion-for-265.patch
  Fix scancode->keycode->scancode conversion

reiserfs-group-alloc-9.patch
  reiserfs: block allocator optimizations

reiserfs-block-allocator-should-not-inherit-packing-locality.patch
  reiserfs: block allocator should not inherit "packing locality 1"

reiserfs-remove-debugging-warning-from-block-allocator.patch
  reiserfs: remove debugging warning from block allocator

reiserfs-group-alloc-9-build-fix.patch
  reiserfs-group-alloc-9 build fix

reiserfs-search_reada-5.patch
  reiserfs: btree readahead

reiserfs-data-logging-support.patch
  reiserfs data logging support

force-config_regparm-to-y.patch
  Force CONFIG_REGPARM to `y'

hugetlb_shm_group-sysctl-gid-0-fix.patch
  hugetlb_shm_group sysctl-gid-0-fix

idr-overflow-fixes.patch
  Fixes for idr code

idr-remove-counter.patch
  idr: remove counter bits from id's

idr-fixups.patch
  IDR fixups

use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api.patch
  use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api

rlim-add-rlimit-entry-for-controlling-queued-signals.patch
  RLIM: add rlimit entry for controlling queued signals

rlim-add-sigpending-field-to-user_struct.patch
  RLIM: add sigpending field to user_struct

rlim-pass-task_struct-in-send_signal.patch
  RLIM: pass task_struct in send_signal()

rlim-add-simple-get_uid-helper.patch
  RLIM: add simple get_uid() helper

rlim-enforce-rlimits-on-queued-signals.patch
  RLIM: enforce rlimits on queued signals

rlim-remove-unused-queued_signals-global-accounting.patch
  RLIM: remove unused queued_signals global accounting

rlim-add-rlimit-entry-for-posix-mqueue-allocation.patch
  RLIM: add rlimit entry for POSIX mqueue allocation

rlim-add-mq_bytes-to-user_struct.patch
  RLIM: add mq_bytes to user_struct

rlim-add-mq_attr_ok-helper.patch
  RLIM: add mq_attr_ok() helper

rlim-enforce-rlimits-for-posix-mqueue-allocation.patch
  RLIM: enforce rlimits for POSIX mqueue allocation

rlim-adjust-default-mqueue-sizes.patch
  RLIM: adjust default mqueue sizes

call-might_sleep-in-tasklet_kill.patch
  Call might_sleep() in tasklet_kill

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

abs-cleanup.patch
  abs() cleanup

hpet-driver.patch
  HPET driver

hpet-driver-updates.patch
  HPET driver updates

fix-hpet-for-acpi-changes.patch
  fix the hpet driver for ACPI API changes

hpet-kconfig-loop-fix.patch
  HPET: Fix Kconfig dependency loop

hpet-rtc-dependency-fix.patch
  HPET RTC dependency fix

hpet-free_irq-deadlock-fix.patch
  hpet-free_irq-deadlock-fix

hpet-dont-use-new-major.patch
  hpet: don't require a new major

kill-off-pc9800.patch
  Remove PC9800 support

more-pc9800-removal.patch
  more PC9800 removal

pc9800-merge-std_resourcesc-back-into-setupc.patch
  pc9800: merge std_resources.c back into setup.c

ftruncate-vs-block_write_full_page.patch
  ftruncate-vs-block_write_full_page

ext3-retry-allocation-after-transaction-commit-v2.patch
  Ext3: Retry allocation after transaction commit (v2)

ext3-retry-allocation-after-transaction-commit-v2-jbd-api.patch
  ext3-retry-allocation-after-transaction-commit-v2: implement JBD API

sysfs-leaves-mount.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-dir.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-file.patch
  sysfs backing store: sysfs_create() changes

sysfs-leaves-bin.patch
  sysfs backing store: bin attribute changes

sysfs-leaves-symlink.patch
  sysfs backing store: sysfs_create_link changes

sysfs-leaves-misc.patch
  sysfs backing store: attribute groups and misc routines

pty-allocation-first-fit.patch
  Use first-fit for pty allocation

dynpty-fix.patch
  dynamic pty allocation fixes

2-3-small-tweaks-to-standard-resource-stuff.patch
  small tweaks to standard resource stuff

3-3-same-small-tweaks-x86_64-version.patch
  same small resource tweaks, x86_64 version

sis900-fix-phy-transceiver-detection.patch
  sis900: Fix PHY transceiver detection

getgroups16-fix.patch
  getgroups16() fix

ia32-fault-deadlock-fix-2.patch
  ia32: fix deadlocks when oopsing while mmap_sem is held

ppc64-fault-deadlock-fix-2.patch
  ppc64: fix deadlocks when oopsing while mmap_sem is held

SL0-core-RC6-bk5.patch
  symlinks: infrastructure

SL1-ext2-RC6-bk5.patch
  symlinks: ext2 conversion

SL2-trivial-RC6-bk5.patch
  symlinks: trivial cases

SL3-page-RC6-bk5.patch
  symlinks: reuse new helpers

SL4-smb-RC6-bk5.patch
  symlinks: smbfs

SL5-xfs-RC6-bk5.patch
  symlinks: XFS

SL6-shm-RC6-bk5.patch
  symlinks: tmpfs

SL7-befs-RC6-bk5.patch
  symlinks: befs

SL8-jffs2-RC6-bk5.patch
  symlinks: jffs2

ipr-ppc64-depends.patch
  Make ipr.c require ppc

disk-barrier-core.patch
  disk barriers: core

disk-barrier-core-tweaks.patch
  disk-barrier-core-tweaks

disk-barrier-ide.patch
  disk barriers: IDE

disk-barrier-ide-symbol-expoprt.patch
  disk-barrier-ide-symbol-expoprt

disk-barrier-ide-warning-fix.patch
  disk-barrier ide warning fix

barrier-update.patch
  barrier update

disk-barrier-scsi.patch
  disk barriers: scsi

disk-barrier-dm.patch
  disk barriers: devicemapper

disk-barrier-md.patch
  disk barriers: MD

reiserfs-v3-barrier-support.patch
  reiserfs v3 barrier support

reiserfs-v3-barrier-support-tweak.patch
  reiserfs-v3-barrier-support-tweak

ext3-barrier-support.patch
  ext3 barrier support

sync_dirty_buffer-retval.patch
  make sync_dirty_buffer() return something useful

jbd-barrier-fallback-on-failure.patch
  jbd: barrier fallback on failure

ide-print-failed-opcode.patch
  ide: print failed opcode on IO errors

add-bh_eopnotsupp-for-testing.patch
  add BH_Eopnotsupp for testing async barrier failures

handle-async-barrier-failures.patch
  Handle async barrier failures

x86-stack-dump-fixes.patch
  x86 stack dump fixes

check-return-status-of-register-calls-in-i82365.patch
  Check return status of register calls in i82365

invalidate_inodes2-mark-pages-notuptodate.patch
  invalidate_inodes2(): mark pages not uptodate

reduce-tlb-flushing-during-process-migration.patch
  Reduce TLB flushing during process migration

reduce-tlb-flushing-during-process-migration-oops-fix.patch
  reduce-tlb-flushing-during-process-migration oops fix

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c
  arch/i386/boot/compressed/misc.c warning fixes

reiserfs-v3-logging-bug-for-blocksize-page-size.patch
  reiserfs v3 logging bug for blocksize < page size

read-vs-truncate-race.patch
  Fix read() vs truncate race

rcu-lock-update-add-per-cpu-batch-counter.patch
  rcu lock update: Add per-cpu batch counter

rcu-lock-update-use-a-sequence-lock-for-starting-batches.patch
  rcu lock update: Use a sequence lock for starting batches

rcu-lock-update-code-move-cleanup.patch
  rcu lock update: Code move & cleanup

pcm_native-stack-reduction.patch
  pcm_native.c stack reduction

cleanups-for-apic.patch
  io_apic.c code consolidation

remove-apic_lockup_debug.patch
  x86: remove APIC_LOCKUP_DEBUG

remove-io_apic_sync.patch
  x86: remove io_apic_sync

ach1542-mca-build-fix.patch
  ahc1542 !CONFIG_MCA build fix

validate-pm-timer-rate-at-boot-time.patch
  Validate PM-Timer rate at boot time

enable-suspend-resuming-of-e1000.patch
  Enable suspend/resuming of e1000

fix-3c59xc-to-allow-3c905c-100bt-fd.patch
  fix 3c59x.c to allow 3c905c 100bT-FD

tty_io-hangup-locking.patch
  tty_io.c hangup locking

first-cut-at-fixing-the-3c59x-power-mismanagment.patch
  First cut at fixing the 3c59x power mismanagment

kbuild-specify-default-target-during-configuration.patch
  kbuild: Specify default target during configuration

bsd-accounting-format-rework.patch
  BSD accounting format rework
  bsd-acct-warning-fix

bsd-accounting-format-rework-update.patch
  BSD accounting format rework update

iso9660-inodes-beyond-4gb.patch
  iso9660: fix handling of inodes beyond 4GB

iso9660-inodes-beyond-4gb-fixes.patch
  iso9660-inodes-beyond-4gb-fixes

iso9660-comment-cleanup.patch
  iso9660: comment cleanup

iso9660-inodes-anywhere-and-nfs.patch
  iso9660: NFS fix

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core

perfctr-disabled-build-fix.patch
  CONFIG_PERFCTR=n build fix

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386

perfctr-if-ifdef-cleanup.patch
  perfctr #if/#ifdef cleanup

perfctr-dothan-support.patch
  perfctr Dothan support

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-cpus_complement-fix.patch
  perfctr-cpus_complement-fix

perfctr-cpumask-cleanup.patch
  perfctr cpumask cleanup

perfctr-misc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

sisfb-update-1710.patch
  sisfb update 1.7.10

sisfb-update-1710-fixes.patch
  sisfb-update-1710-fixes

sisfb-build-fix.patch
  sisfb-build-fix

nfs-writepage-fix.patch
  Fix nfs writepage behaviour

3c59x-support-for-ati-radeon-9100-igp.patch
  3c59x: support for ATI Radeon 9100 IGP

nx-2.6.7-rc2-bk2-AF.patch
  NX (No eXecute) support for x86

1-5-device-mapper-dm-ioc.patch
  dm-io: device-mapper i/o library for kcopyd

dm-cache-flushing-fix.patch
  dm: cache flushing fix

2-5-device-mapper-kcopyd.patch
  Device-mapper: kcopyd

dm-1-5-kcopyd-remove-superfluous-init_list_heads.patch
  dm: kcopyd: remove superfluous INIT_LIST_HEADs

dm-2-5-kcopyd-no-need-to-lock-pages.patch
  dm: kcopyd: No need to lock pages

2-5-device-mapper-kcopyd-docs.patch
  kcopyd commentary

3-5-device-mapper-snapshots.patch
  Device-mapper: snapshots

dm-3-5-fix-error-cleanup-in-dm_create_persistent.patch
  dm: Fix error cleanup in dm_create_persistent()

4-5-device-mapper-mirroring.patch
  Device-mapper: mirroring

5-5-device-mapper-dm-zero.patch
  Device-mapper: dm-zero

dm-4-5-dm-zero-version.patch
  dm: dm-zero version

dm-zero-flushing-fix.patch
  Device-mapper: dm-zero flushing fix

dm-5-5-documentation.patch
  dm: Documentation

let-serial_8250_acpi-depend-on-acpi_pci-2.patch
  let SERIAL_8250_ACPI depend on ACPI_PCI

export-acpi_register_gsi.patch
  export acpi_register_gsi()

submission-of-via-velocitytm-series-adapter-driver.patch
  Via "velocity(tm)" series adapter driver

via-velocity-oops-fix.patch
  via-velocity oops fix

fb-accel-capabilities.patch
  fb accel capabilities

fbcon-prefer-pan-when-available.patch
  fbcon: prefer pan when available

rawdev-driver-2.patch
  Raw access to serio ports

msi-target-cpus-fix.patch
  msi TARGET_CPUS fix

x86_64-numa-build-fix.patch
  x86_64 numa cpumask build fix

cpumask-1-10-cpu_present_map-real-even-on-non-smp.patch
  cpumask 1/10 cpu_present_map real even on non-smp

cpumask-2-10-bitmap-cleanup-preparation-for-cpumask.patch
  cpumask 2/10 bitmap cleanup preparation for cpumask  overhaul

cpumask-3-10-bitmap-inlining-and-optimizations.patch
  cpumask 3/10 bitmap inlining and optimizations

cpumask-5-10-rewrite-cpumaskh-single-bitmap-based.patch
  cpumask 5/10 rewrite cpumask.h - single bitmap based  implementation

cpumask-5-10-rewrite-cpumaskh-single-bitmap-based-cpu_mask_none-fix.patch
  CPU_MASK_NONE fix

s390-fix-cpu_online-redefined-warnings.patch
  s390: fix "cpu_online" redefined warnings

cpumask-6-10-remove-26-no-longer-used-cpumaskh-files.patch
  cpumask 6/10 remove 26 no longer used cpumask*.h files

cpumask-7-10-remove-obsolete-cpumask-macro-uses-i386-arch.patch
  cpumask 7/10 remove obsolete cpumask macro uses - i386 arch

cpumask-8-10-remove-obsolete-cpumask-macro-uses-other.patch
  cpumask 8/10 remove obsolete cpumask macro uses - other  archs

x86_64-cpu_online-fix.patch
  x86_64-cpu_online-fix

ppc64-cpu_online-fix.patch
  ppc64: cpu_online fix

cpumask-9-10-remove-no-longer-used-obsolete-macro-emulation.patch
  cpumask 9/10 Remove no longer used obsolete macro emulation

cpumask-10-10-optimize-various-uses-of-new-cpumasks.patch
  cpumask 10/10 optimize various uses of new cpumasks

cpumask-11-10-comment-spacing-tweaks.patch
  cpumask: comment, spacing tweaks

cleanup-cpumask_t-temporaries.patch
  clean up cpumask_t temporaries

alpha-cpumask-fix.patch
  alpha: cpumask fixups

irqaction-use-cpumask.patch
  make irqaction use a cpu mask

irqaction-use-cpumask-voyager-fix.patch
  Fix irqaction-use-cpumask.patch for voyager

fix-and-reenable-msi-support-on-x86_64.patch
  Fix and Reenable MSI Support on x86_64

fix-and-reenable-msi-support-on-x86_64-fix.patch
  Fix and Reenable MSI Support on x86_64 fix

i386-uninline-bitops.patch
  i386 uninline some bitops

apic-enumeration-fixes.patch
  APIC enumeration fixes

apic-fix-kicking-of-non-present-cpus.patch
  apic: fix kicking of non-present cpus

apic-remove-marking-of-non-present-physids-in-phys_cpu_present_map.patch
  apic: remove marking of non-present physids in phys_cpu_present_map

apic-make-mach_default-compile-again.patch
  apic: make mach_default compile again

use-numa-policy-api-for-boot-time-policy.patch
  Use numa policy API for boot time policy

266-memory-allocation-checks-in-eth1394_update.patch
  memory allocation checks in eth1394_update()

266-memory-allocation-checks-in-mtdblock_open.patch
  memory allocation checks in mtdblock_open()

memory-allocation-checks-in-cs46xx_dsp_proc_register_scb_desc.patch
  memory allocation checks in cs46xx_dsp_proc_register_scb_desc()

export-dmi-check-functions.patch
  export DMI check functions

hp-pavilion-use-dmi-api.patch
  use new DMI API for HP Pavilion

dont-create-cpu-online-sysfs-file.patch
  don't create cpu/online sysfs file

checkstack-fixes.patch
  checksatck.pl fixes

sys-getdents64-needs-compat-wrapper.patch
  sys_getdents64 needs compat wrapper

remap_file_pages-speedup.patch
  remap_file_pages() speedup

wanxl-firmware-build-fix.patch
  wanxl firmware build fix

cciss-ioctl32-update.patch
  cciss ioctl32 update

pcmcia-enable-read-prefetch-on-o2micro-bridges-to-fix-hdsp.patch
  pcmcia: enable read prefetch on o2micro bridges to fix HDSP

fix-cdrom-mt-rainier-probe.patch
  fix cdrom mt rainier probe

blk-move-threshold-unplugging.patch
  blk: move threshold unplugging

fix-memory-leak-in-swsusp.patch
  Fix memory leak in swsusp

pmdisk-memleak-fix.patch
  omdisk memory leak fix

swsusp-remove-memsets.patch
  remove unnecessary memsets from swsusp and pmdisk

swsusp-remove-copy_pagedir.patch
  swsusp: remove copy_pagedir

decrease-stack-usage-in-ncpfss-ioctl.patch
  Decrease stack usage in ncpfs's ioctl

staticalise-update_one_process.patch
  Make update_one_process() static

267-rc3-drivers-char-ipmi-ipmi_devintfc-user-kernel.patch
  drivers/char/ipmi/ipmi_devintf.c: user/kernel pointer typo

267-rc3-drivers-scsi-megaraidc-user-kernel-pointer-bugs.patch
  drivers/scsi/megaraid.c: user/kernel pointer bugs

ext3-online-resize-patch.patch
  ext3: online resizing

ext3-online-resize-warning-fix.patch
  ext3-online-resize-warning-fix

ia64-discontic-fix.patch
  ia64 discontig.c fix

epoll-uses-rbtrees.patch
  epoll: replace the file lookup hash with rbtrees

larger-io-bitmap.patch
  larger IO bitmaps

permit-inode-dentry-hash-tables-to-be-allocated-max_order-size.patch
  Permit inode & dentry hash tables to be allocated > MAX_ORDER size

permit-inode-dentry-hash-tables-to-be-allocated-max_order-size-warning-fix.patch
  permit-inode-dentry-hash-tables-to-be-allocated-max_order-size-warning-fix

respect-edge-level-triggering-requested-in-acpi_register_gsi.patch
  Respect edge/level triggering requested in acpi_register_gsi().

ide-pci-hotplugging-fixes.patch
  ide: PCI hotplugging fixes

ide-kill-some-useless-headers-for-pci-drivers.patch
  ide: kill some useless headers for PCI drivers

ide-ide-proc-fix-for-m68k.patch
  ide: ide-proc fix for m68k

ide-kill-hw_regs_t-dma.patch
  ide: kill hw_regs_t->dma

ide-ide-pnp-update.patch
  ide: ide-pnp update

ide-remove-alternate_state_diagram_multi_out-from-ide-taskfilec.patch
  ide: remove ALTERNATE_STATE_DIAGRAM_MULTI_OUT from ide-taskfile.c

ide-fix-ide-cd-to-not-retry-req_drive_taskfile-requests.patch
  ide: fix ide-cd to not retry REQ_DRIVE_TASKFILE requests

ide-fix-req_drive_-requests-error-handling-in-ide-scsi.patch
  ide: fix REQ_DRIVE_* requests error handling in ide-scsi

ide-cleanup-taskfile-pio-handlers-config_ide_taskfile_io=n.patch
  ide: cleanup taskfile PIO handlers (CONFIG_IDE_TASKFILE_IO=n)

ide-tiny-task_mulout_intr-config_ide_taskfile_io=n-cleanup.patch
  ide: tiny task_mulout_intr() (CONFIG_IDE_TASKFILE_IO=n) cleanup

ide-kill-task_map_rq.patch
  ide: kill task_[un]map_rq()

ide-check-no-of-sectors-for-in-out-commands-in-ide_diag_taskfile.patch
  ide: check no. of sectors for in/out commands in ide_diag_taskfile()

improved-psx-support-in-input-joystick-gameconc.patch
  improved PSX support in input/joystick/gamecon.c

revert-sched-improve-wakeup-affinity.patch
  sched: revert the `improve wakeup-affinity' patch

o_noatime-support.patch
  O_NOATIME support

shiftpgup-if-nr-of-scrolled-lines-is-4.patch
  Shift+PgUp if nr of scrolled lines is < 4

istallion-printk-fix.patch
  istallion printk fix

pcwdc-patches.patch
  watchdog: pcwd*.c patches

usb-tt-oops-fix.patch
  USB TT oops fix

fix-x86-64-via-systems-with-iommu-debug.patch
  Fix x86-64 VIA systems with IOMMU debug

lower-priority-of-too-many-keys-msg-in-atkbdc.patch
  lower priority of "too many keys" msg in atkbd.c

remove-irda-usage-of-isa_virt_to_bus.patch
  remove irda usage of isa_virt_to_bus()

unregister-driver-if-probing-fails-in-sb_cardc.patch
  unregister driver if probing fails in sb_card.c

ignore-errors-from-tw_setfeature-in-3w-xxxxc.patch
  Ignore errors from tw_setfeature in 3w-xxxx.c

fake-inquiry-for-sony-clie-peg-tj25-in-unusual_devsh.patch
  fake inquiry for Sony Clie PEG-TJ25 in unusual_devs.h

fix-duplicate-environment-variables-passed-to-init.patch
  fix duplicate environment variables passed to init

fix-handling-of--embedded-in-filenames-in-isofs.patch
  fix handling of '/' embedded in filenames in isofs

fix-isofs-ignoring-noexec-and-mode-mount-options.patch
  fix isofs ignoring noexec and mode mount options

fix-thread_infoh-ignoring-__have_thread_functions.patch
  fix thread_info.h ignoring __HAVE_THREAD_FUNCTIONS

sparse-fix-to-mm-vmscanc.patch
  Sparse fix to mm/vmscan.c



