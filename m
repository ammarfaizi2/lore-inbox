Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUE0IyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUE0IyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 04:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUE0IyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 04:54:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:54453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261786AbUE0Ixe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 04:53:34 -0400
Date: Thu, 27 May 2004 01:52:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc1-mm1
Message-Id: <20040527015259.3525cbbc.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc1/2.6.7-rc1-mm1/

- Various net driver updates

- Significant rework of the RCU code core to fix serious scalability
  problems on huge SMP.

- Devicemapper update

- Various random other things




Changes since 2.6.6-mm5:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-i2c.patch
 bk-input.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-usb.patch

 External trees

-nosysfs-sysfs_rename_dir-fix.patch
-vga16fb-warning-fix.patch
-gss_api-build-fix.patch
-gss_api-build-fix-tweak.patch
-swapper_space-tree_lock-fix.patch
-__add_to_swap_cache-simplification.patch
-revert-swapcache-changes.patch
-vmscan-revert-may_enter_fs-changes.patch
-sync_page-use-swapper-space.patch
-__set_page_dirty_nobuffers-race-fix.patch
-rmap-7-object-based-rmap.patch
-ia64-rmap-build-fix.patch
-rmap-8-unmap-nonlinear.patch
-slab-panic.patch
-rmap-9-remove-pte_chains.patch
-rmap-10-add-anonmm-rmap.patch
-rmap-anonhd-locking-fix.patch
-rmap-11-mremap-moves.patch
-rmap-12-pgtable-remove-rmap.patch
-rmap-13-include-asm-deletions.patch
-i_mmap_lock.patch
-rmap-14-i_shared_lock-fixes.patch
-numa-api-x86_64.patch
-numa-api-i386.patch
-numa-api-ia64.patch
-numa-api-core.patch
-mpol-in-copy_vma.patch
-numa-api-core-slab-panic.patch
-numa-api-statistics-2.patch
-numa-api-vma-policy-hooks.patch
-numa-api-shared-memory-support.patch
-small-numa-api-fixups.patch
-small-numa-api-fixups-fix.patch
-numa-api-statistics.patch
-numa-api-anon-memory-policy.patch
-numa-api-fix-end-of-memory-handling-in-mbind.patch
-rmap-15-vma_adjust.patch
-rmap-16-pretend-prio_tree.patch
-rmap-17-real-prio_tree.patch
-rmap-18-i_mmap_nonlinear.patch
-unmap_mapping_range-comment.patch
-rmap-19-arch-prio_tree.patch
-vm_area_struct-size-comment.patch
-rmapc-comment-style-fixups.patch
-rmap-20-i_mmap_shared-into-i_mmap.patch
-rmap-21-try_to_unmap_one-mapcount.patch
-rmap-22-flush_dcache_mmap_lock.patch
-rmap-23-empty-flush_dcache_mmap_lock.patch
-rmap-24-no-rmap-fastcalls.patch
-rmap-27-memset-0-vma.patch
-rmap-28-remove_vm_struct.patch
-rmap-29-vm_reserved-safety.patch
-rmap-30-fix-bad-mapcount.patch
-rmap-31-unlikely-bad-memory.patch
-rmap-32-zap_pmd_range-wrap.patch
-rmap-33-install_arg_page-vma.patch
-rmap-34-vm_flags-page_table_lock.patch
-rmap-35-mmapc-cleanups.patch
-rmap-36-mprotect-use-vma_merge.patch
-rmap-37-page_add_anon_rmap-vma.patch
-rmap-38-remove-anonmm-rmap.patch
-rmap-39-add-anon_vma-rmap.patch
-rmap-40-better-anon_vma-sharing.patch
-partial-prefetch-for-vma_prio_tree_next.patch
-ppc64-console-autodetection-for-pmac.patch
-slabify-iocontext-request_queue-SLAB_PANIC.patch
-266-mm2-r8169-ethtool-set_settings.patch
-266-mm2-r8169-ethtool-get_settings.patch
-266-mm2-r8169-link-handling-rework-1-2.patch
-266-mm2-r8169-link-handling-rework-2-2.patch
-fix-userspace-include-of-linux-fsh.patch
-fixing-sendfile-on-64bit-architectures.patch
-out-of-bounds-access-in-hiddev_cleanup.patch
-fbdev-mode-switching-fix.patch
-ipr-gcc-attribute-fixes.patch
-trivial-use-page_to_phys-in-dma_map_page.patch
-trivial-fix-duplicated-includes.patch
-fix-knfsd-scary-message.patch
-mangled-printk-oops-output-fix.patch
-mangled-printk-oops-output-fix-tweaks.patch
-sanitise-unneeded-syscall-stubs.patch
-sanitise-unneeded-syscall-stubs-fixes.patch
-ep_send_events-simplification.patch
-blk-completion-clear-stack-pointer-on-return.patch
-swsusp-kill-unneccessary-debugging.patch
-race-condition-with-current-group_info.patch
-race-condition-with-current-group_info-tweaks.patch
-swsusp-fix-devfs-breakage-introduced-in-266.patch
-26-isdn-eicon-driver-fix-__devexit-in-prototype.patch
-cpuid-cache-info-update.patch
-3ware-9000-sata-raid-driver-for-266-mm5.patch
-autofs4-printk-cleanup.patch
-autofs4-maintainer.patch

 Merged

+ppc64-xics-irq-fix.patch
+ppc32-fix-make-o-equals.patch

 ppc[64] fixes

+checkstack-target-update-1.patch

 Fixups for checkstack-target.patch

-hfsplus-dir-rename-fix.patch

 Dropped - obsolete

+barrier-update.patch

 Fixes to the IDE barrier code

+reiserfs-v3-barrier-support-tweak.patch

 Fix against reiserfs-v3-barrier-support.patch

+jbd-barrier-fallback-on-failure-fix.patch

 Fix jbd-barrier-fallback-on-failure.patch

+invalidate_inodes2-mark-pages-notuptodate.patch

 Mark pages as not uptodate in invalidate_inode_pages2()

+reduce-tlb-flushing-during-process-migration.patch
+reduce-tlb-flushing-during-process-migration-oops-fix.patch

 ia64 context switch speedup (needs work for non-ia64 architectures)

+kernel-parameter-parsing-fix.patch

 Small fix for kernel parameter parsing

+Move-saved_command_line-to-init-mainc.patch

 Bring back Rusty's saved_command_line[] cleanup.  The x86_64 problem seems
 to be fixed now, due to kernel-parameter-parsing-fix.patch

+stop-megaraid-trashing-other-i960-based-devices.patch

 megaraid fix

+reiserfs-v3-logging-bug-for-blocksize-page-size.patch

 reiserfs data=journal fix

+partition-table-validity-checking.patch

 Additional sanity checking in partition parsing code

+via-rhine-fix-force-media.patch
+via-rhine-rename-some-symbols.patch
+via-rhine-whitespace-clean-up.patch
+via-rhine-use_mem-use_io-use_mmio.patch
+via-rhine-netdev_priv.patch

 net driver updates

+new-radeonfb-powerdown-doesnt-work.patch

 radeonfb power management fix

+kernel-bug-at-fs-locksc1723.patch

 fs/locks.c BUGfix

+set-d_bucket-correctly-for-anonymous-dentries.patch

 knfsd BUG maybefix

+r8169-ethtool-set_settings.patch
+r8169-ethtool-get_settings-link.patch
+r8169-link-handling-and-phy-reset-rework.patch
+r8169-initial-link-setup-rework.patch

 net driver update

+blockdev-readahead-fix.patch

 Fix readahead for /dev/hdXX

+wdt-warning-fix.patch

 watchdog warning fix

+read-vs-truncate-race.patch

 Fix races between read() and truncate.

+tulip-driver-deadlocks-on-device-removal.patch

 Fix tulip hotunplug behaviour

+add-support-for-isd-300-usb-controller.patch

 New USB CDROM controller

+cleanups-for-apic.patch

 x86 code consolidation

+nuke-has_ip_copysum-for-net-drivers.patch

 net driver cleanups

+put-irq-stacks-in-bsspage_aligned-section.patch

 x86 space savings

+make-proliant-8500-boot-with-26.patch

 Fix hpaq proliant 8500

+remove-message-posix-conformance-testing-by-unifix.patch

 Remove a printk

+restore-idle-tasks-priority-during-cpu_dead-notification.patch

 CPU hotplug scheduler fix

+swsusp-documentation-updates.patch

 swsusp docco

+print-backtrace-for-bad-vfree.patch

 Additional debug info

+ppc64-kernel-hackers-cant-spell.patch

 Speling fixes

+dm-ioctlc-fix-off-by-one-error.patch
+dmc-free-cloned-bio-on-error-path.patch
+dm-ioctl-replace-dm__wait_queue-with-dm_wait_event.patch
+dm-add-static-and-__init-qualifiers.patch
+dm-tablec-proper-usage-of-dm_vcalloc.patch

 Smallish devicemapper updates

+rcu-lock-update-add-per-cpu-batch-counter.patch
+rcu-lock-update-use-a-sequence-lock-for-starting-batches.patch
+rcu-lock-update-code-move-cleanup.patch

 Speed up RCU for big SMP.

+device-runtime-suspend-resume-fixes.patch

 Power management fix

+3ware-9000-sata-raid-1.patch
+3ware-9000-sata-raid-2.patch

 New 3ware SATA driver

+sr_ioctl-kmalloc-fix.patch

 Check a kmalloc return value

+nfsd-deleting-symlinks-over-nfs-causes-oops-on-unmount.patch

 nfsd oops fix

+prism54-add-new-private-ioctls.patch
+prism54-reset-card-on-tx_timeout.patch
+prism54-add-iwspy-support.patch
+prism54-add-support-for-avs-header-in.patch
+prism54-new-prism54-kernel-compatibility.patch
+prism54-fix-prism54org-bugs-74-75.patch
+prism54-fix-24-build.patch
+prism54-fix-prism54org-bugs-39-73.patch
+prism54-fix-prism54org-bug-77-strengthened-oid-transaction.patch
+prism54-dont-allow-mib-reads-while-unconfigured.patch
+prism54-touched-up-kernel-compatibility.patch
+prism54-start-using-likely-unlikely.patch
+prism54-fix-24-smp-build.patch
+prism54-fix-channel-stats-bump-to-12.patch

 wireless driver updates

+leave-runtime-suspended-devices-off-at-system-resume.patch

 Power management fix

+for-radeonfb-non-8bpp-clear-doesnt-use-palette.patch

 radeonfb fix





All 236 patches:



linus.patch

bk-acpi.patch

bk-agpgart.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-i2c.patch

bk-input.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

revert-i8042-interrupt-handling.patch
  revert i8042 input interrupt handling changes

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

kgdb-in-sched_functions.patch

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-in-sched_functions-x86_64.patch

kgdb-ia64-support.patch
  IA64 kgdb support

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

ppc64-xics-irq-fix.patch
  ppc64: xics.c IRQ fix

ppc32-fix-make-o-equals.patch
  ppc32: fix 'make O=...'

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

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

sk98lin-buggy-vpd-workaround.patch
  net/sk98lin: correct buggy VPD in ASUS MB

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

input-tsdev-fixes.patch
  tsdev.c fixes

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

problems-with-atkbd_command--atkbd_interrupt-interaction.patch
  Problems with atkbd_command & atkbd_interrupt interaction

sis-agp-updates.patch
  fbdev: SIS AGP updates

clear_backing_dev_congested.patch
  clear_baking_dev_congested

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

add-qsort-library-function.patch
  add qsort library function

have-xfs-use-kernel-provided-qsort.patch
  Have XFS use kernel-provided qsort

have-xfs-use-kernel-provided-qsort-fix.patch
  have-xfs-use-kernel-provided-qsort-fix

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

fix-crash-on-modprobe-ohci1394.patch
  fix crash on `modprobe ohci1394; modprobe -r ohci1394'

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

checkstack-target.patch
  Add `make checkstack' target

checkstack-target-update-1.patch
  `check stack' target update

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
  pty-allocation-first-fit-fix

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

ppc64-fault-deadlock-fix.patch
  ppc64: fix deadlocks due to fault-inside-mmap_sem

ia32-fault-deadlock-fix.patch
  ia32: fix deadlocks due to fault-inside-mmap_sem

ia32-fault-deadlock-fix-cleanup.patch
  ia32-fault-deadlock-fix cleanup

ext3-htree-rename-fix.patch
  ext3: htree rename fix

sis900-xcvr-fix.patch
  sis900 transceiver fix

advansys-basic-highmem-dma-support.patch
  advansys: add basic highmem/DMA support

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

scsi-qla1280c-warning-fix.patch
  scsi/qla1280.c warning fix.

crypto-scatterwalk-fixes.patch
  crypto scatterwalking fixes

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

jbd-barrier-fallback-on-failure-fix.patch

x86-stack-dump-fixes.patch
  x86 stack dump fixes

add-futex_cmp_requeue-futex-op.patch
  Add FUTEX_CMP_REQUEUE futex op

check-return-status-of-register-calls-in-i82365.patch
  Check return status of register calls in i82365

invalidate_inodes2-mark-pages-notuptodate.patch
  invalidate_inodes2-mark-pages-notuptodate

reduce-tlb-flushing-during-process-migration.patch
  Reduce TLB flushing during process migration

reduce-tlb-flushing-during-process-migration-oops-fix.patch
  reduce-tlb-flushing-during-process-migration oops fix

kernel-parameter-parsing-fix.patch
  Kernel parameter parsing fix

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c
  arch/i386/boot/compressed/misc.c warning fixes

stop-megaraid-trashing-other-i960-based-devices.patch
  Stop megaraid trashing other i960 based devices

reiserfs-v3-logging-bug-for-blocksize-page-size.patch
  reiserfs v3 logging bug for blocksize < page size

partition-table-validity-checking.patch
  partition table validity checking

via-rhine-fix-force-media.patch
  via-rhine: Fix force media

via-rhine-rename-some-symbols.patch
  via-rhine: Rename some symbols

via-rhine-whitespace-clean-up.patch
  via-rhine: Whitespace clean-up

via-rhine-use_mem-use_io-use_mmio.patch
  via-rhine: USE_MEM, USE_IO -> USE_MMIO

via-rhine-netdev_priv.patch
  via-rhine: netdev_priv()

new-radeonfb-powerdown-doesnt-work.patch
  radeonfb powerdown doesn't work

kernel-bug-at-fs-locksc1723.patch
  posix locks oops fix

set-d_bucket-correctly-for-anonymous-dentries.patch
  Set d_bucket correctly for anonymous dentries

r8169-ethtool-set_settings.patch
  r8169: ethtool .set_settings

r8169-ethtool-get_settings-link.patch
  r8169: ethtool .get_{settings/link}

r8169-link-handling-and-phy-reset-rework.patch
  r8169: link handling and phy reset rework

r8169-initial-link-setup-rework.patch
  r8169: initial link setup rework

blockdev-readahead-fix.patch
  Fix the setting of file->f_ra on block-special files

wdt-warning-fix.patch
  wdt.c warning fix

read-vs-truncate-race.patch
  Fix read() vs truncate race

tulip-driver-deadlocks-on-device-removal.patch
  Fix tulip deadlocks on device removal

add-support-for-isd-300-usb-controller.patch
  Add support for ISD-300 controller

cleanups-for-apic.patch
  io_apic.c code consolidation

nuke-has_ip_copysum-for-net-drivers.patch
  Nuke HAS_IP_COPYSUM for net drivers

put-irq-stacks-in-bsspage_aligned-section.patch
  i386: put irq stacks in .bss.page_aligned section

make-proliant-8500-boot-with-26.patch
  make proliant 8500 boot with 2.6

remove-message-posix-conformance-testing-by-unifix.patch
  remove message: POSIX conformance testing by UNIFIX

restore-idle-tasks-priority-during-cpu_dead-notification.patch
  CPU Hotplug: restore Idle task's priority during CPU_DEAD notification

swsusp-documentation-updates.patch
  swsusp documentation updates

print-backtrace-for-bad-vfree.patch
  Print backtrace for bad vfree()

ppc64-kernel-hackers-cant-spell.patch
  ppc64 kernel hackers can't spell

dm-ioctlc-fix-off-by-one-error.patch
  dm-ioctl.c: fix off-by-one error

dmc-free-cloned-bio-on-error-path.patch
  dm.c: free cloned bio on error path

dm-ioctl-replace-dm__wait_queue-with-dm_wait_event.patch
  dm-ioctl: replace dm_[add|remove]_wait_queue() with dm_wait_event()

dm-add-static-and-__init-qualifiers.patch
  dm: add static and __init qualifiers

dm-tablec-proper-usage-of-dm_vcalloc.patch
  dm-table.c: proper usage of dm_vcalloc

rcu-lock-update-add-per-cpu-batch-counter.patch
  rcu lock update: Add per-cpu batch counter

rcu-lock-update-use-a-sequence-lock-for-starting-batches.patch
  rcu lock update: Use a sequence lock for starting batches

rcu-lock-update-code-move-cleanup.patch
  rcu lock update: Code move & cleanup

device-runtime-suspend-resume-fixes.patch
  Device runtime suspend/resume fixes

3ware-9000-sata-raid-1.patch
  3ware 9000 SATA-RAID driver v2.26.00.009 (1)

3ware-9000-sata-raid-2.patch
  3ware 9000 SATA-RAID driver v2.26.00.009 (2)

sr_ioctl-kmalloc-fix.patch
  unchecked kmalloc in sr_audio_ioctl()

nfsd-deleting-symlinks-over-nfs-causes-oops-on-unmount.patch
  nfsd: deleting symlinks over nfs causes oops on unmount

prism54-add-new-private-ioctls.patch
  prism54: add new private ioctls

prism54-reset-card-on-tx_timeout.patch
  prism54: reset card on tx_timeout

prism54-add-iwspy-support.patch
  prism54: add iwspy support

prism54-add-support-for-avs-header-in.patch
  prism54: add support for avs header in

prism54-new-prism54-kernel-compatibility.patch
  prism54: new prism54 kernel compatibility

prism54-fix-prism54org-bugs-74-75.patch
  prism54: Fix prism54.org bugs 74, 75

prism54-fix-24-build.patch
  prism54: Fix 2.4 build

prism54-fix-prism54org-bugs-39-73.patch
  prism54: Fix prism54.org bugs 39, 73

prism54-fix-prism54org-bug-77-strengthened-oid-transaction.patch
  prism54: Fix prism54.org bug 77; strengthened oid transaction

prism54-dont-allow-mib-reads-while-unconfigured.patch
  prism54: Don't allow mib reads while unconfigured

prism54-touched-up-kernel-compatibility.patch
  prism54: Touched up kernel compatibility

prism54-start-using-likely-unlikely.patch
  prism54: Start using likely/unlikely

prism54-fix-24-smp-build.patch
  prism54: Fix 2.4 SMP build

prism54-fix-channel-stats-bump-to-12.patch
  prism54: Fix channel stats; bump to 1.2

leave-runtime-suspended-devices-off-at-system-resume.patch
  Leave runtime suspended devices off at system resume

for-radeonfb-non-8bpp-clear-doesnt-use-palette.patch
  radeonfb fix (non-8bpp clear doesn't use palette)



