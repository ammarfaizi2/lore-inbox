Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264959AbUFAJRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbUFAJRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbUFAJRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:17:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:688 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264961AbUFAJQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:16:16 -0400
Date: Tue, 1 Jun 2004 02:15:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2-mm1
Message-Id: <20040601021539.413a7ad7.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6.7-rc2-mm1/


- NFS server udpates

- md updates

- big x86 dmi_scan.c cleanup

- merged perfctr.  No documentation though :(

- cris architecture update




Changes since 2.6.7-rc1-mm1:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cpufreq.patch
 bk-drm.patch
 bk-input.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pcmcia.patch
 bk-scsi.patch

 External trees

-revert-i8042-interrupt-handling.patch
-ppc64-xics-irq-fix.patch
-ppc32-fix-make-o-equals.patch
-sk98lin-buggy-vpd-workaround.patch
-problems-with-atkbd_command--atkbd_interrupt-interaction.patch
-sis-agp-updates.patch
-fix-crash-on-modprobe-ohci1394.patch
-checkstack-target.patch
-checkstack-target-update-1.patch
-sis900-xcvr-fix.patch
-scsi-qla1280c-warning-fix.patch
-crypto-scatterwalk-fixes.patch
-stop-megaraid-trashing-other-i960-based-devices.patch
-via-rhine-fix-force-media.patch
-via-rhine-rename-some-symbols.patch
-via-rhine-whitespace-clean-up.patch
-via-rhine-use_mem-use_io-use_mmio.patch
-via-rhine-netdev_priv.patch
 new-radeonfb-powerdown-doesnt-work.patch
-kernel-bug-at-fs-locksc1723.patch
-set-d_bucket-correctly-for-anonymous-dentries.patch
-blockdev-readahead-fix.patch
-wdt-warning-fix.patch
-cleanups-for-apic.patch
-put-irq-stacks-in-bsspage_aligned-section.patch
-remove-message-posix-conformance-testing-by-unifix.patch
-restore-idle-tasks-priority-during-cpu_dead-notification.patch
-swsusp-documentation-updates.patch
-print-backtrace-for-bad-vfree.patch
-ppc64-kernel-hackers-cant-spell.patch
-dm-ioctlc-fix-off-by-one-error.patch
-dmc-free-cloned-bio-on-error-path.patch
-dm-ioctl-replace-dm__wait_queue-with-dm_wait_event.patch
-dm-add-static-and-__init-qualifiers.patch
-dm-tablec-proper-usage-of-dm_vcalloc.patch
-device-runtime-suspend-resume-fixes.patch
-sr_ioctl-kmalloc-fix.patch
-nfsd-deleting-symlinks-over-nfs-causes-oops-on-unmount.patch
-leave-runtime-suspended-devices-off-at-system-resume.patch
-for-radeonfb-non-8bpp-clear-doesnt-use-palette.patch

 Merged

+for-radeonfb-non-8bpp-clear-doesnt-use-palette.patch

 Radeon fb driver fix

+nmi-trigger-switch-support-for-debugging.patch

 Support NMI-generating front-panel switches on x86

+s2io-section-fix.patch

 net driver linkage fix

+mp_find_ioapic-oops-fix.patch

 linker section fix

+shrink_all_memory-fix.patch

 fix swsusp with swappiness=0

+mustfix-lists.patch

 update the must-fix and should-fix lists

+ppc32-reorg-dma-api-add-coherent-alloc-in-irq.patch
+ppc64-iseries-default-config-update.patch
+ppc64-iseries-virtual-ethernet-minor-optimisation.patch
+ppc64-iseries-fix-virtual-ethernet-transmit-block.patch
+ppc64-add-eeh_add_device_early-late.patch
+ppc64-reset-iseries-progress-indicator-on-boot.patch
+ppc64-bolt-first-vmalloc-segment-into-slb.patch
+ppc64-slb-accounting-fix.patch
+ppc64-iseries-bolted-slb-fix.patch
+ppc64-fix-missing-relocs-add-linuxphandle-property.patch

 ppc updates

-clear_backing_dev_congested.patch

 Dropped, not needed.

-have-xfs-use-kernel-provided-qsort.patch
-have-xfs-use-kernel-provided-qsort-fix.patch

 These broke

+dynpty-fix.patch

 Fix pty allocation

+pcm_native-stack-reduction.patch

 sound driver stack savings

+cleanups-for-apic.patch

 Code consolidation

+remove-apic_lockup_debug.patch
+remove-io_apic_sync.patch

 Remvoe old unneeded code
 
+vmscan-GFP_NOFS-try-harder.patch

 Do more scanning for GFP_NOFS allocators

+mark-cache_names-__initdata.patch

 kernel text reduction

+support-for-sc1100-in-linux-kernel.patch

 Geode SC1100-based Microtik Routerboard 230 support

+ach1542-mca-build-fix.patch

 compile fix

+validate-pm-timer-rate-at-boot-time.patch

 Check the pm timer's sanity

+knfsd-1-of-11-fix-nfs3-dentry-encoding.patch
+knfsd-2-of-11-nfsd_exp_remove_null_checkpatch.patch
+knfsd-3-of-11-nfsd_acceptable_typopatch.patch
+knfsd-4-of-11-nfsd_xdr_name_encodingpatch.patch
+knfsd-5-of-11-gss_svc_module_refpatch.patch
+knfsd-5-of-11-gss_svc_module_refpatch-fix.patch
+knfsd-5-of-11-gss_svc_module_refpatch-fix2.patch
+knfsd-6-of-11-nfsd_gss_rsc_lookup_freepatch.patch
+knfsd-7-of-11-nfsd-releaselkownerpatch.patch
+knfsd-8-of-11-nfsd-getattr-fixpatch.patch
+knfsd-9-of-11-nfsd-setclientid-fixpatch.patch
+knfsd-10-of-11-nfsd-create-fixpatch.patch
+knfsd-11-of-11-exporting_doc_typospatch.patch

 NFS server update

+md-1-of-8-rationalise-device-selection-in-md-multipath.patch
+md-2-of-8-make-sure-md_check_recovery-will-remove-a-faulty-device-when-nr_pending-hits-0.patch
+md-3-of-8-allow-an-md-personality-to-refuse-a-hot-remove-request.patch
+md-4-of-8-make-sure-the-size-of-a-raid5-6-array-is-a-multiple-of-the-chunk-size.patch
+md-5-of-8-handle-hot-add-for-arrays-with-non-persistent-superblocks.patch
+md-6-of-8-abort-the-resync-of-raid1-there-is-only-one-device.patch
+md-7-of-8-allow-md-arrays-to-be-resized-if-devices-are-large-enough.patch
+md-8-of-8-support-reshaping-raid1-arrays-adding-or-removing-drives.patch
+md-8-of-8-support-reshaping-raid1-arrays-adding-or-removing-drives-fix.patch

 MD update

+dmi-simplify-dmi-matching-data.patch
+dmi-export-dmi-probe-function.patch
+dmi-codingstyle-and-whitespace-cleanups.patch
+dmi-port-sonypi-driver-to-new-dmi-probing.patch
+dmi-port-apm-bios-driver-to-new-dmi-probing.patch
+dmi-port-hp-pavilion-irq-routing-quirk-to-new-dmi-probing.patch
+dmi-port-piix4-i2c-driver-to-new-dmi-probing.patch
+dmi-port-pnp-bios-driver-to-new-dmi-probing.patch
+dmi-port-acpi-boot-code-to-new-dmi-probing.patch
+dmi-port-reboot-related-quirks-to-new-dmi-probing.patch
+dmi-port-powernow-k7-driver-to-new-dmi-probing.patch
+dmi-port-local-apic-quirks-to-new-dmi-probing.patch
+dmi-port-acpi-sleep-quirk-to-new-dmi-probing.patch
+dmi-port-i8042-quirk-to-new-dmi-probing.patch

 x86 dma_scan.c cleanups

+enable-suspend-resuming-of-e1000.patch

 e1000 power management fixes

+direct-io-hole-fix.patch

 Maybe fix a direct-io problem

+fix-3c59xc-to-allow-3c905c-100bt-fd.patch

 Bring back this 3c905 fix which Linus dropped.  I found the bug report to be
 fishy.

+tty_io-hangup-locking.patch

 Prevent the tty_io.c locking warning

+missing-pop-off-in-arch-i386-kernel-acpi-wakeups.patch

 stack adjustment fix

+mdc-message-during-quiet-boot.patch

 Quieten a noisy md.c printk

+posix_mqueue-depends-on-net.patch
+security_selinux-depends-on-net.patch
+pnpbios-only-makes-sense-for-x86.patch

 Dependency fixes

+vmscanc-move-writepage-invocation-into-its-own-function.patch
+vmscanc-struct-scan_control.patch

 vwscan.c sort-of cleanups

+first-cut-at-fixing-the-3c59x-power-mismanagment.patch

 3c59x power management fixes

+agp-resume-fixups.patch

 AGP power management fixes

+document-checkstacks.patch

 Add help for `make checkstack'

+kbuild-specify-default-target-during-configuration.patch

 Fix for kernel RMP and .deb generation

+add-watchdog-timer-to-iseries_veth-driver.patch

 ppc64 iseries net driver fix

+runtime-selection-of-config_paride_epatc8.patch

 paride feature work

+vram-boot-option.patch

 Make the `vram:' boot option consistent with 2.4

+s-tkill-tgkill-in--documentation.patch

 Comment fix

+bsd-accounting-format-rework.patch

 Revamp BSD accounting formats

+linux-timerh-needs-linux-stddefh.patch

 include fix

+fix-mca-procfs-stub.patch

 build fix

+fix-net-ixgb-ixgb_mainc-warning.patch

 warning fix

+fix-readahead-handling-in-knfsd.patch

 nfs server readahead fixes

+i386-bitops-memory-clobbers.patch

 Add missing memory clobbers to some i386 bitop functions.

+sched-remove-noinline-workaround.patch

 Remove now-unneeded workaround

+iso9660-inodes-beyond-4gb.patch

 iso9660 fixes

+perfctr-core.patch
+perfctr-i386.patch
+perfctr-x86_64.patch
+perfctr-ppc.patch
+perfctr-virtualised-counters.patch
+perfctr-misc.patch

 perfctr

+checkstack-fixes.patch

 Fixes to the `make checkstack' target

+reference_init.patch

 Teach `make buildcheck' to also check for refrerences to .init sections from
 non-.init.  (Seems to generate huge amounts of warnings).

+cpqarray-sa_sample_random.patch

 Make the cpqarray driver seed the random number generator

+add-const-to-some-scheduling-functions.patch

 constify a few function arguments

+use-aio-workqueue-in-fs-aioc.patch
+correct-use_mm-unuse_mm-to-use-task_lock-to-protect-mm.patch

 AIO fixes

+cris-architecture-update.patch

 arch/cris update.




All 296 patches:


linus.patch

for-radeonfb-non-8bpp-clear-doesnt-use-palette.patch
  radeonfb fix (non-8bpp clear doesn't use palette)

nmi-trigger-switch-support-for-debugging.patch
  NMI trigger switch support for debugging

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-arm.patch

bk-cpufreq.patch

bk-drm.patch

bk-input.patch

bk-netdev.patch

bk-ntfs.patch

bk-pcmcia.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

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

s2io-section-fix.patch
  s2io section fix

mp_find_ioapic-oops-fix.patch
  mp_find_ioapic cannot be __init

shrink_all_memory-fix.patch
  shrink_all_memory() fixes

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

ppc32-reorg-dma-api-add-coherent-alloc-in-irq.patch
  ppc32: reorg DMA API, add coherent alloc in irq

ppc64-iseries-default-config-update.patch
  ppc64: iSeries default config update

ppc64-iseries-virtual-ethernet-minor-optimisation.patch
  ppc64: iSeries virtual ethernet minor optimisation

ppc64-iseries-fix-virtual-ethernet-transmit-block.patch
  ppc64: iSeries fix virtual ethernet transmit block

ppc64-add-eeh_add_device_early-late.patch
  ppc64: add eeh_add_device_early/late

ppc64-reset-iseries-progress-indicator-on-boot.patch
  ppc64: reset iseries progress indicator on boot

ppc64-bolt-first-vmalloc-segment-into-slb.patch
  ppc64: bolt first vmalloc segment into SLB

ppc64-slb-accounting-fix.patch
  ppc64: SLB accounting fix

ppc64-iseries-bolted-slb-fix.patch
  ppc64: iseries bolted SLB fix

ppc64-fix-missing-relocs-add-linuxphandle-property.patch
  ppc64: fix missing RELOCs, add linux,phandle property

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

ppc64-fault-deadlock-fix.patch
  ppc64: fix deadlocks due to fault-inside-mmap_sem

ia32-fault-deadlock-fix.patch
  ia32: fix deadlocks due to fault-inside-mmap_sem

ia32-fault-deadlock-fix-cleanup.patch
  ia32-fault-deadlock-fix cleanup

ext3-htree-rename-fix.patch
  ext3: htree rename fix

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
  invalidate_inodes2(): mark pages not uptodate

reduce-tlb-flushing-during-process-migration.patch
  Reduce TLB flushing during process migration

reduce-tlb-flushing-during-process-migration-oops-fix.patch
  reduce-tlb-flushing-during-process-migration oops fix

kernel-parameter-parsing-fix.patch
  Kernel parameter parsing fix

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c
  arch/i386/boot/compressed/misc.c warning fixes

reiserfs-v3-logging-bug-for-blocksize-page-size.patch
  reiserfs v3 logging bug for blocksize < page size

partition-table-validity-checking.patch
  partition table validity checking

new-radeonfb-powerdown-doesnt-work.patch
  radeonfb powerdown doesn't work

r8169-ethtool-set_settings.patch
  r8169: ethtool .set_settings

r8169-ethtool-get_settings-link.patch
  r8169: ethtool .get_{settings/link}

r8169-link-handling-and-phy-reset-rework.patch
  r8169: link handling and phy reset rework

r8169-initial-link-setup-rework.patch
  r8169: initial link setup rework

read-vs-truncate-race.patch
  Fix read() vs truncate race

tulip-driver-deadlocks-on-device-removal.patch
  Fix tulip deadlocks on device removal

add-support-for-isd-300-usb-controller.patch
  Add support for ISD-300 controller

nuke-has_ip_copysum-for-net-drivers.patch
  Nuke HAS_IP_COPYSUM for net drivers

make-proliant-8500-boot-with-26.patch
  make proliant 8500 boot with 2.6

rcu-lock-update-add-per-cpu-batch-counter.patch
  rcu lock update: Add per-cpu batch counter

rcu-lock-update-use-a-sequence-lock-for-starting-batches.patch
  rcu lock update: Use a sequence lock for starting batches

rcu-lock-update-code-move-cleanup.patch
  rcu lock update: Code move & cleanup

3ware-9000-sata-raid-1.patch
  3ware 9000 SATA-RAID driver v2.26.00.009 (1)

3ware-9000-sata-raid-2.patch
  3ware 9000 SATA-RAID driver v2.26.00.009 (2)

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

pcm_native-stack-reduction.patch
  pcm_native.c stack reduction

cleanups-for-apic.patch
  io_apic.c code consolidation

remove-apic_lockup_debug.patch
  x86: remove APIC_LOCKUP_DEBUG

remove-io_apic_sync.patch
  x86: remove io_apic_sync

vmscan-GFP_NOFS-try-harder.patch
  vmscan-GFP_NOFS-try-harder

mark-cache_names-__initdata.patch
  Mark cache_names __initdata

support-for-sc1100-in-linux-kernel.patch
  Support for SC1100

ach1542-mca-build-fix.patch
  ahc1542 !CONFIG_MCA build fix

validate-pm-timer-rate-at-boot-time.patch
  Validate PM-Timer rate at boot time

knfsd-1-of-11-fix-nfs3-dentry-encoding.patch
  kNFSd: Fix nfs3 dentry encoding

knfsd-2-of-11-nfsd_exp_remove_null_checkpatch.patch
  kNFSd: exp_find(): remove null pointer check

knfsd-3-of-11-nfsd_acceptable_typopatch.patch
  kNFSd: nfsd_acceptable() typo fix

knfsd-4-of-11-nfsd_xdr_name_encodingpatch.patch
  kNFSd: nfsd4 xdr name encoding improvements

knfsd-5-of-11-gss_svc_module_refpatch.patch
  kNFSd: gss_svc locking and refcounting fixes

knfsd-5-of-11-gss_svc_module_refpatch-fix.patch
  knfsd-5-of-11-gss_svc_module_refpatch-fix

knfsd-5-of-11-gss_svc_module_refpatch-fix2.patch
  gss_svc_module_ref typo fix

knfsd-6-of-11-nfsd_gss_rsc_lookup_freepatch.patch
  kNFSd: rsc_lookup simplification

knfsd-7-of-11-nfsd-releaselkownerpatch.patch
  kNFSd: nfsd4_release_lockowner() oops fix

knfsd-8-of-11-nfsd-getattr-fixpatch.patch
  kNFSd: nfsd getattr fix

knfsd-9-of-11-nfsd-setclientid-fixpatch.patch
  kNFSd: nfsd4 setclientid fix

knfsd-10-of-11-nfsd-create-fixpatch.patch
  kNFSd: nfsd4 file creation fix

knfsd-11-of-11-exporting_doc_typospatch.patch
  kNFSd: documentation typo fixes

md-1-of-8-rationalise-device-selection-in-md-multipath.patch
  md: rationalise device selection in md/multipath.

md-2-of-8-make-sure-md_check_recovery-will-remove-a-faulty-device-when-nr_pending-hits-0.patch
  md: make sure md_check_recovery will remove a faulty device when ->nr_pending hits 0

md-3-of-8-allow-an-md-personality-to-refuse-a-hot-remove-request.patch
  md: allow an md personality to refuse a hot-remove request.

md-4-of-8-make-sure-the-size-of-a-raid5-6-array-is-a-multiple-of-the-chunk-size.patch
  md: make sure the size of a raid5/6 array is a multiple of the chunk size.

md-5-of-8-handle-hot-add-for-arrays-with-non-persistent-superblocks.patch
  md: handle hot-add for arrays with non-persistent superblocks

md-6-of-8-abort-the-resync-of-raid1-there-is-only-one-device.patch
  md: abort the resync of raid1 there is only one device.

md-7-of-8-allow-md-arrays-to-be-resized-if-devices-are-large-enough.patch
  md: allow md arrays to be resized if devices are large enough.

md-8-of-8-support-reshaping-raid1-arrays-adding-or-removing-drives.patch
  md: support reshaping raid1 arrays - adding or removing drives.

md-8-of-8-support-reshaping-raid1-arrays-adding-or-removing-drives-fix.patch
  md 8-of-8 fix

dmi-simplify-dmi-matching-data.patch
  dmi: simplify DMI matching data

dmi-export-dmi-probe-function.patch
  dmi: export DMI probe function

dmi-codingstyle-and-whitespace-cleanups.patch
  dmi: codingstyle and whitespace cleanups

dmi-port-sonypi-driver-to-new-dmi-probing.patch
  dmi: port sonypi driver to new DMI probing

dmi-port-apm-bios-driver-to-new-dmi-probing.patch
  dmi: port APM BIOS driver to new DMI probing

dmi-port-hp-pavilion-irq-routing-quirk-to-new-dmi-probing.patch
  dmi: port HP Pavilion irq routing quirk to new DMI probing

dmi-port-piix4-i2c-driver-to-new-dmi-probing.patch
  dmi: port PIIX4 I2C driver to new DMI probing

dmi-port-pnp-bios-driver-to-new-dmi-probing.patch
  dmi: port PnP BIOS driver to new DMI probing

dmi-port-acpi-boot-code-to-new-dmi-probing.patch
  dmi: port ACPI boot code to new DMI probing

dmi-port-reboot-related-quirks-to-new-dmi-probing.patch
  dmi: port reboot related quirks to new DMI probing

dmi-port-powernow-k7-driver-to-new-dmi-probing.patch
  dmi: port powernow-k7 driver to new DMI probing

dmi-port-local-apic-quirks-to-new-dmi-probing.patch
  dmi: port local APIC quirks to new DMI probing

dmi-port-acpi-sleep-quirk-to-new-dmi-probing.patch
  dmi: port ACPI sleep quirk to new DMI probing

dmi-port-i8042-quirk-to-new-dmi-probing.patch
  dmi: port i8042 quirk to new DMI probing

enable-suspend-resuming-of-e1000.patch
  Enable suspend/resuming of e1000

direct-io-hole-fix.patch
  direct-io-hole-fix

fix-3c59xc-to-allow-3c905c-100bt-fd.patch
  fix 3c59x.c to allow 3c905c 100bT-FD

tty_io-hangup-locking.patch
  tty_io.c hangup locking

missing-pop-off-in-arch-i386-kernel-acpi-wakeups.patch
  Missing pop-off in arch/i386/kernel/acpi/wakeup.S

mdc-message-during-quiet-boot.patch
  md.c message during quiet boot

posix_mqueue-depends-on-net.patch
  POSIX_MQUEUE depends on NET

security_selinux-depends-on-net.patch
  SECURITY_SELINUX depends on NET

pnpbios-only-makes-sense-for-x86.patch
  pnpbios only makes sense for X86

vmscanc-move-writepage-invocation-into-its-own-function.patch
  vmscan.c: move ->writepage invocation into its own function

vmscanc-struct-scan_control.patch
  vmscan.c: struct scan_control

first-cut-at-fixing-the-3c59x-power-mismanagment.patch
  First cut at fixing the 3c59x power mismanagment

agp-resume-fixups.patch
  AGP resume fixups

document-checkstacks.patch
  Document checkstacks

kbuild-specify-default-target-during-configuration.patch
  kbuild: Specify default target during configuration

add-watchdog-timer-to-iseries_veth-driver.patch
  Add watchdog timer to iseries_veth driver

runtime-selection-of-config_paride_epatc8.patch
  runtime selection of CONFIG_PARIDE_EPATC8

vram-boot-option.patch
  vesafb: vram boot option the same as 2.4.x

s-tkill-tgkill-in--documentation.patch
  s/tkill/tgkill/ in /** documentation */

bsd-accounting-format-rework.patch
  BSD accounting format rework

linux-timerh-needs-linux-stddefh.patch
  linux/timer.h needs linux/stddef.h

fix-mca-procfs-stub.patch
  fix mca procfs stub

fix-net-ixgb-ixgb_mainc-warning.patch
  fix net/ixgb/ixgb_main.c warning

fix-readahead-handling-in-knfsd.patch
  Fix readahead handling in knfsd

i386-bitops-memory-clobbers.patch
  i386: add missing bitop.h memory clobbers

sched-remove-noinline-workaround.patch
  sched: remove noinline workaround

iso9660-inodes-beyond-4gb.patch
  iso9660: fix handling of inodes beyond 4GB

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core

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

perfctr-misc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

checkstack-fixes.patch
  checkstack fixes

reference_init.patch
  Add reference_init.pl to `make buildcheck' target

cpqarray-sa_sample_random.patch
  cpqarray.c: seed the random number pool

add-const-to-some-scheduling-functions.patch
  Add const to some scheduling functions

use-aio-workqueue-in-fs-aioc.patch
  use aio workqueue in fs/aio.c

correct-use_mm-unuse_mm-to-use-task_lock-to-protect-mm.patch
  correct use_mm()/unuse_mm() to use task_lock() to protect ->mm

cris-architecture-update.patch
  CRIS architecture update



