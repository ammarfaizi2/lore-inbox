Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265693AbUFIIv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUFIIv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 04:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbUFIIvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 04:51:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:49587 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265693AbUFIIup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 04:50:45 -0400
Date: Wed, 9 Jun 2004 01:50:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc3-mm1
Message-Id: <20040609015001.31d249ca.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/

- Included the dreaded cpumask rework.

- Lots of little fixes.

- Added support for the NX (no execute) pagetable flag on ia32.



Changes since 2.6.7-rc2-mm2:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-driver-core.patch
 bk-i2c.patch
 bk-input.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch
 bk-usb.patch

 Latest versions of various development trees.

-hiddev-warning-fixes.patch
-ramfs-o_sync-oops-fix.patch
-direct-io-invalidation-fix.patch
-shrink_all_memory-fix.patch
-mm-swapper_spacei_mmap_nonlinear.patch
-mm-follow_page-invalid-pte_page.patch
-mm-vma_adjust-adjust_next-wrap.patch
-mm-vma_adjust-insert-file-earlier.patch
-mm-kill-missed-pte-warning.patch
-ppc32-add-indirect-dcr-access-pass-2.patch
-ppc64-kernel-makefile-options-for-as.patch
-ppc64-update-info-about-available-iseries_veth-interfaces.patch
-ppc64-gives-up-too-quickly-on-hotplugged-cpu.patch
-ext3-htree-rename-fix.patch
-advansys-basic-highmem-dma-support.patch
-partition-table-validity-checking.patch
-tulip-driver-deadlocks-on-device-removal.patch
-3ware-9000-sata-raid-1.patch
-3ware-9000-sata-raid-2.patch
-3ware-9000-driver-update-for-267-rc2-mm2.patch
-knfsd-1-of-11-fix-nfs3-dentry-encoding.patch
-knfsd-2-of-11-nfsd_exp_remove_null_checkpatch.patch
-knfsd-3-of-11-nfsd_acceptable_typopatch.patch
-knfsd-4-of-11-nfsd_xdr_name_encodingpatch.patch
-knfsd-5-of-11-gss_svc_module_refpatch.patch
-knfsd-5-of-11-gss_svc_module_refpatch-fix.patch
-knfsd-5-of-11-gss_svc_module_refpatch-fix2.patch
-knfsd-6-of-11-nfsd_gss_rsc_lookup_freepatch.patch
-knfsd-7-of-11-nfsd-releaselkownerpatch.patch
-knfsd-8-of-11-nfsd-getattr-fixpatch.patch
-knfsd-9-of-11-nfsd-setclientid-fixpatch.patch
-knfsd-10-of-11-nfsd-create-fixpatch.patch
-knfsd-11-of-11-exporting_doc_typospatch.patch
-md-1-of-8-rationalise-device-selection-in-md-multipath.patch
-md-2-of-8-make-sure-md_check_recovery-will-remove-a-faulty-device-when-nr_pending-hits-0.patch
-md-3-of-8-allow-an-md-personality-to-refuse-a-hot-remove-request.patch
-md-4-of-8-make-sure-the-size-of-a-raid5-6-array-is-a-multiple-of-the-chunk-size.patch
-md-5-of-8-handle-hot-add-for-arrays-with-non-persistent-superblocks.patch
-md-6-of-8-abort-the-resync-of-raid1-there-is-only-one-device.patch
-md-7-of-8-allow-md-arrays-to-be-resized-if-devices-are-large-enough.patch
-md-8-of-8-support-reshaping-raid1-arrays-adding-or-removing-drives.patch
-md-8-of-8-support-reshaping-raid1-arrays-adding-or-removing-drives-fix.patch
-reference_init.patch
-selinux-check-processed-security-context-length.patch
-floppy-fix.patch
-balance-on-exec-fix.patch
-fix-loop-device-cache-handling.patch
-fix-possible-null-pointer-in-fs-ext3-superc.patch
-dm_remove_all32.patch
-ide-dont-put-disks-in-standby-mode-on-halt-on-alpha.patch
-ide-fix-for-generic-ide-pci-module.patch
-ide-ide_pci_device_t-sanitization.patch
-ide-merge-amd74xxh-into-amd74xxc.patch
-ide-add-new-nforce-ide-sata-device-ids-to-amd74xxc.patch
-ide-use-generic-ide_init_hwif_ports-on-m68k.patch
-ide-use-asm-i386-ideh-as-asm-x86_64-ideh.patch
-ide-add-ide_arch_obsolete_defaults.patch
-ide-remove-useless-proc-ide-siimage-from-siimagec.patch
-ide-simplify-config_idedma_onlydisk-logic-a-bit.patch
-mm-oom_killc-trivial-cleanup.patch
-use-const-in-timeh-unit-conversion-functions.patch
-fix-io_getevents-timer-expiry-setting.patch
-move-endif-to-correct-place.patch
-hugetlb-msync-fix.patch
-direct-io-hole-fix.patch
-nx-267-rc2-bk2-ae.patch
-nx-267-rc2-bk2-ae-warning-fix.patch
-hugetlb-dtor-reinit.patch
-mtd-jedec-probe-additions.patch
-use-kern_alert-more-for-oopses.patch
-s390-1-4-core-s390.patch
-s390-2-4-common-i-o-layer.patch
-s390-3-4-block-device-driver.patch
-s390-4-4-network-device-driver.patch
-quota-fix-writing-of-quota-info.patch
-fix-for-old-quota-format.patch
-kill-off-efi_dir-in-efih.patch
-update-elilo-loader-location-in-kconfig.patch
-ext3_orphan_del-may-double-decrement-bh-b_count.patch
-use-c99-struct-initializer-in-hotcpu_notifier.patch
-better-names-for-edd-legacy_-fields.patch
-use-decimal-instead-of-hex-for-edd-values.patch
-eep-lost-24-change-for-buslogic-info.patch
-rawdev-driver.patch
-sys_io_setup-fix.patch
-fix-sys-cpumap-for-352-nr_cpus.patch

 Merged

+wake_up_forked_thread-fix.patch

 CPU scheduler tweak.

+w83627hf-build-fix.patch
+arp_tables-build-fix.patch

 Compile fixes

-kgdb-in-sched_functions.patch

 Folded into kgdb-ga.patch

-kgdb-in-sched_functions-x86_64.patch

 Folded into kgdb-x86_64-support.patch

-kgdb-ia64-fixes.patch

 Folded into kgdb-ia64-support.patch

+jbd-descriptor-buffer-state-fix.patch

 JBD locking fix

+speedup-flush_workqueue-for-singlethread_workqueue.patch

 flush_workqueue() optimisation

+fix-missing-option-in-binutils-version-check.patch

 ppc32 build fix

+85xx+e500.l26-20040608.patch

 Additional ppc32 CPU variant support

+ppc64-iseries-vio_dev-cleanups.patch

 pcp64 driver update

+writeback_inodes-can-race-with-unmount.patch

 Fix race between unmount and dirty page writeout.

-input-tsdev-fixes.patch

 Fixed by other means.

-jbd-barrier-fallback-on-failure-fix.patch

 Folded into jbd-barrier-fallback-on-failure.patch

+ide-print-failed-opcode.patch

 IDE barrier debugging

-kernel-parameter-parsing-fix.patch
-kernel-parameter-parsing-fix-fix.patch

 Dropped

 Move-saved_command_line-to-init-mainc.patch

 Updated.  Again.

+unalign-page_state.patch

 Stack space savings

+perfctr-ifdef-cleanup.patch

 perfctr cleanup

+perfctr-cpus_complement-fix.patch

 perfctr build fix

+sisfb-update-1710-fixes.patch
+sisfb-build-fix.patch

 Updates and fixes for sisfb-update-1710.patch

+nx-2.6.7-rc2-bk2-AF.patch

 ia32 no-execute support

+fbcon-prefer-pan-when-available.patch

 fb console optimisation

+rawdev-driver-2.patch

 New version of the driver which prides access to the raw ps/2 stream

+cpumask-1-10-cpu_present_map-real-even-on-non-smp.patch
+cpumask-2-10-bitmap-cleanup-preparation-for-cpumask.patch
+cpumask-3-10-bitmap-inlining-and-optimizations.patch
+cpumask-5-10-rewrite-cpumaskh-single-bitmap-based.patch
+cpumask-6-10-remove-26-no-longer-used-cpumaskh-files.patch
+cpumask-7-10-remove-obsolete-cpumask-macro-uses-i386-arch.patch
+cpumask-8-10-remove-obsolete-cpumask-macro-uses-other.patch
+x86_64-cpu_online-fix.patch
+ppc64-cpu_online-fix.patch
+cpumask-9-10-remove-no-longer-used-obsolete-macro-emulation.patch
+cpumask-10-10-optimize-various-uses-of-new-cpumasks.patch
+cpumask-11-10-comment-spacing-tweaks.patch
+cleanup-cpumask_t-temporaries.patch

 cpumask_t cleanups, simplification, etc.

+fix-and-reenable-msi-support-on-x86_64.patch
+fix-and-reenable-msi-support-on-x86_64-fix.patch

 Message Signalled Interrupts for x86_64

+i386-uninline-bitops.patch

 Code size reductions

+ext3-journal_flush-needs-journal_lock_updates.patch

 ext3 locking fix

+apic-enumeration-fixes.patch

 Clean up and fix ia32 APIC enumeration

+use-numa-policy-api-for-boot-time-policy.patch

 NUMA simplification/speedup

+typo-in-documentation-fb-framebuffertxt.patch

 typo fix

+more-drivers-atm-horizonc-polishing.patch

 ATM driver updates

+disable-unnecessary-printk-in-es7000-code.patch
+disable-udf-debugging.patch

 Remvoe some boot-time printks

+__arch_want_sys_rt_sigaction-fix.patch

 Alpha build fix

+266-memory-allocation-checks-in-eth1394_update.patch
+266-memory-allocation-checks-in-mtdblock_open.patch
+memory-allocation-checks-in-cs46xx_dsp_proc_register_scb_desc.patch

 Check for kmalloc failures

+fix-bug-in-raid6-resync-code.patch

 RAID6 fix

+cdrom-hardware-defect-mgt-header-length.patch

 CDROM driver robustness

+export-dmi-check-functions.patch

 Provide an API so that DMI mathcing functions don't all have to be in one
 humongous table.

+hp-pavilion-use-dmi-api.patch

 Use the above API.

+s390-add-support-for-6-system-call-arguments.patch

 Teach s390 to support 6 siscall arguments

+flush_workqueue-locking-simplification.patch

 Simplify locking in flush_workqueue()

+fix-pci-hotplug-of-promise-ide-cards.patch

 Use the right sections in this IDE driver

+cyclone-pit-sanity-checking.patch

 Fix cyclone handling of the timer PIT.

+checkstack-fixes.patch

 Various fixups for checkstack.pl

+sys-getdents64-needs-compat-wrapper.patch

 32->64 bit emulation fix

+remap_file_pages-speedup.patch

 Improved concurrency in remap_file_pages()

+sysctl-uts-write-size.patch

 Fix buffer lengths in the UTS sysctls.

+wanxl-firmware-build-fix.patch

 Fix `allmodconfig'

+aio-sparse-warning-fix.patch

 Fix a `sparse' warning in aio.c

+cciss-ioctl32-update.patch

 CCISS driver ioctl emulation

+read_page_state.patch

 Infrastructure for stack reductions

+vmscan-use-read_page_state.patch
+page-writeback-use-read_page_state.patch

 Stack reductions

+vga16fb-fix-bogus-mem_start-value.patch

 Fix the vga16fb driver yet again

+pcmcia-enable-read-prefetch-on-o2micro-bridges-to-fix-hdsp.patch

 O2micro pcmcia workaround.





All 274 patches:


linus.patch

wake_up_forked_thread-fix.patch
  wake_up_forked_thread() fix

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-driver-core.patch

bk-i2c.patch

bk-input.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

bk-input-build-fix.patch
  bk-input-build-fix

w83627hf-build-fix.patch
  w83627hf.c build fix

arp_tables-build-fix.patch
  arp_tables.c build fix

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

jbd-descriptor-buffer-state-fix.patch
  jbd: descriptor buffer state fix

speedup-flush_workqueue-for-singlethread_workqueue.patch
  speedup flush_workqueue for singlethread_workqueue

mp_find_ioapic-oops-fix.patch
  mp_find_ioapic cannot be __init

mm-get_user_pages-vs-try_to_unmap.patch
  mm: get_user_pages vs. try_to_unmap

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

fix-missing-option-in-binutils-version-check.patch
  ppc32: fix missing option in binutils version check

85xx+e500.l26-20040608.patch
  ppc32: support for e500 and 85xx

ppc64-iseries-vio_dev-cleanups.patch
  ppc64: iSeries vio_dev cleanups

ppc64-reloc_hide.patch

writeback_inodes-can-race-with-unmount.patch
  writeback_inodes can race with unmount

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

fealnx-mac-address-and-other-issues.patch
  Fealnx. Mac address and other issues

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

add-i386-readq.patch
  add i386 readq()/writeq()

hpet-driver.patch
  HPET driver

hpet-driver-updates.patch
  HPET driver updates

hpet-driver-updates-move-readq.patch
  hpet-driver-updates-move-readq

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

sync_inodes_sb-debug.patch
  sync_inodes_sb-debug

vmscan-handle-synchronous-writepage.patch
  vmscan: handle synchronous writepage()

vmscan-handle-synchronous-writepage-fix.patch
  vmscan-handle-synchronous-writepage-fix

ramdisk-buffer-uptodate-fix.patch
  ramdisk: buffer_uptodate fix

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

vmscan-GFP_NOFS-try-harder.patch
  vmscan: try harder for GFP_NOFS allocators

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

unalign-page_state.patch
  unalign struct page_state

vmscanc-move-writepage-invocation-into-its-own-function.patch
  vmscan.c: move ->writepage invocation into its own function

vmscanc-struct-scan_control.patch
  vmscan.c: struct scan_control

first-cut-at-fixing-the-3c59x-power-mismanagment.patch
  First cut at fixing the 3c59x power mismanagment

kbuild-specify-default-target-during-configuration.patch
  kbuild: Specify default target during configuration

runtime-selection-of-config_paride_epatc8.patch
  runtime selection of CONFIG_PARIDE_EPATC8

bsd-accounting-format-rework.patch
  BSD accounting format rework

bsd-acct-warning-fix.patch
  bsd-acct-warning-fix

iso9660-inodes-beyond-4gb.patch
  iso9660: fix handling of inodes beyond 4GB

iso9660-inodes-beyond-4gb-fixes.patch
  iso9660-inodes-beyond-4gb-fixes

iso9660-comment-cleanup.patch
  iso9660: comment cleanup

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core

perfctr-disabled-build-fix.patch
  CONFIG_PERFCTR=n build fix

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386

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

2-5-device-mapper-kcopyd-docs.patch
  kcopyd commentary

3-5-device-mapper-snapshots.patch
  Device-mapper: snapshots

4-5-device-mapper-mirroring.patch
  Device-mapper: mirroring

5-5-device-mapper-dm-zero.patch
  Device-mapper: dm-zero

dm-zero-flushing-fix.patch
  Device-mapper: dm-zero flushing fix

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

cpumask-1-10-cpu_present_map-real-even-on-non-smp.patch
  cpumask 1/10 cpu_present_map real even on non-smp

cpumask-2-10-bitmap-cleanup-preparation-for-cpumask.patch
  cpumask 2/10 bitmap cleanup preparation for cpumask  overhaul

cpumask-3-10-bitmap-inlining-and-optimizations.patch
  cpumask 3/10 bitmap inlining and optimizations

cpumask-5-10-rewrite-cpumaskh-single-bitmap-based.patch
  cpumask 5/10 rewrite cpumask.h - single bitmap based  implementation

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

fix-and-reenable-msi-support-on-x86_64.patch
  Fix and Reenable MSI Support on x86_64

fix-and-reenable-msi-support-on-x86_64-fix.patch
  Fix and Reenable MSI Support on x86_64 fix

i386-uninline-bitops.patch
  i386 uninline some bitops

ext3-journal_flush-needs-journal_lock_updates.patch
  ext3: journal_flush() needs journal_lock_updates()

apic-enumeration-fixes.patch
  APIC enumeration fixes

use-numa-policy-api-for-boot-time-policy.patch
  Use numa policy API for boot time policy

typo-in-documentation-fb-framebuffertxt.patch
  Typo in Documentation/fb/framebuffer.txt

more-drivers-atm-horizonc-polishing.patch
  more drivers/atm/horizon.c polishing

disable-unnecessary-printk-in-es7000-code.patch
  Remove unnecessary printk in es7000 code

disable-udf-debugging.patch
  Disable UDF debugging

__arch_want_sys_rt_sigaction-fix.patch
  __ARCH_WANT_SYS_RT_SIGACTION fix

266-memory-allocation-checks-in-eth1394_update.patch
  memory allocation checks in eth1394_update()

266-memory-allocation-checks-in-mtdblock_open.patch
  memory allocation checks in mtdblock_open()

memory-allocation-checks-in-cs46xx_dsp_proc_register_scb_desc.patch
  memory allocation checks in cs46xx_dsp_proc_register_scb_desc()

fix-bug-in-raid6-resync-code.patch
  md: fix BUG in raid6 resync code.

cdrom-hardware-defect-mgt-header-length.patch
  cdrom hardware defect mgt header length

export-dmi-check-functions.patch
  export DMI check functions

hp-pavilion-use-dmi-api.patch
  use new DMI API for HP Pavilion

s390-add-support-for-6-system-call-arguments.patch
  s390: add support for 6 system call arguments (FUTEX_CMP_REQUEUE)

flush_workqueue-locking-simplification.patch
  flush_workqueue locking simplification

fix-pci-hotplug-of-promise-ide-cards.patch
  Fix PCI hotplug of promise IDE cards

cyclone-pit-sanity-checking.patch
  cyclone: PIT sanity checking

checkstack-fixes.patch
  checksatck.pl fixes

sys-getdents64-needs-compat-wrapper.patch
  sys_getdents64 needs compat wrapper

remap_file_pages-speedup.patch
  remap_file_pages() speedup

sysctl-uts-write-size.patch
  fix uts sysctl write size

wanxl-firmware-build-fix.patch
  wanxl firmware build fix

aio-sparse-warning-fix.patch
  aio.c sparse warning fix

cciss-ioctl32-update.patch
  cciss ioctl32 update

read_page_state.patch
  Implement read_page_state

vmscan-use-read_page_state.patch
  vmscan.c: use read_page_state()

page-writeback-use-read_page_state.patch
  page-writeback.c: use read_page_state()

vga16fb-fix-bogus-mem_start-value.patch
  vga16fb.c: fix bogus mem_start value

pcmcia-enable-read-prefetch-on-o2micro-bridges-to-fix-hdsp.patch
  pcmcia: enable read prefetch on o2micro bridges to fix HDSP



