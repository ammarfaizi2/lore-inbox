Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263641AbUESLOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUESLOD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUESLOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:14:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:49822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263641AbUESLEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:04:52 -0400
Date: Wed, 19 May 2004 04:04:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-mm4
Message-Id: <20040519040421.61263a43.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm4/
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm4/

(kernel.org is being extremely slow - this may take a while to turn up)


- A series of patches from Hugh to take the VM from `anonmm' to `anon_vma'.

- Various knfsd updates

- The ramdisk driver was phenomenally broken.  Seems to work OK now.

- Re-added the backing-store-for-sysfs patches

- Various other random stuff.




Changes since 2.6.6-mm3:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-input.patch
 bk-libata.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-net-drivers.patch
 bk-pci.patch
 bk-pcmcia.patch
 bk-scsi.patch

 Latest versions of external trees

-acpi-procfs-fix.patch
-ppc32-ibm-powerpc-750gx-support.patch
-ppc32-some-whitespace-fixes.patch
-ppc32-handle-altivec-assist-exception-properly.patch
-ppc32-update-defconfigs.patch
-ppc32-fix-mod_incdec_use_count-abuse-in-ppc-4xx-8xx-code.patch
-missing-closing-n-in-printk.patch
-266-mm2-r8169-napi.patch
-266-mm2-r8169-janitoring.patch
-266-mm2-r8169-register-rename.patch
-quota-recursion-fix-fix.patch

 Merged

+blk_run_page-race-fix.patch

 Fix oopsable VM race

+vmscan-revert-may_enter_fs-changes.patch

 Put the vmscan code back to the old way of handling swapcache.

+rmap-34-vm_flags-page_table_lock.patch
+rmap-35-mmapc-cleanups.patch
+rmap-36-mprotect-use-vma_merge.patch
+rmap-37-page_add_anon_rmap-vma.patch
+rmap-38-remove-anonmm-rmap.patch
+rmap-39-add-anon_vma-rmap.patch
+rmap-40-better-anon_vma-sharing.patch

 anon_vma work.

+put-module-license-in-swim3c.patch

 Missing MODULE_LICENSE

+ppc32-get-full-register-set-on-bad-kernel-accesses.patch

 PPC32 fix

-serial-fifo-size-is-ignored.patch

 Dropped, rmk didn't like.

+add-i386-readq.patch

 Add readq() and writeq() implementations on ia32.

+hpet-driver-updates.patch
+hpet-driver-updates-move-readq.patch
+hpet-kconfig-loop-fix.patch

 Fixes and updates for hpet-driver.patch

+vm-shrink-zone-fix.patch

 Fix vm-shrink-zone.patch

+more-pc9800-removal.patch
+pc9800-merge-std_resourcesc-back-into-setupc.patch

 PC98 removal

+blk_run_queues-remnants.patch

 Remove dead code

+hfsplus-dir-rename-fix.patch

 Fix HFS+ directory renaming

+ftruncate-vs-block_write_full_page.patch

 Part-fix a werid block_write_full_page() race

+use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec.patch
+use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api.patch

 Use first-fit allocation for i2c adapter enumeration

+replace-mod_inc_use_count-in-cyber2000fb.patch
+dont-mention-mod_inc_use_count-mod_dec_use_count-in-docs.patch

 Module refcounting fixes

+mark-plan-video-driver-broken.patch

 Concede defeat on this driver

+kbuild-subdirs=more-than-one.patch

 kbuild fix

+fix-userspace-include-of-linux-fsh.patch

 Move includes inside __KERNEL__

+ext3-retry-allocation-after-transaction-commit-v2.patch

 Avoid bogus ENOSPC's in ext3

+correct-ps2esdi-module-parm-name.patch

 Fix a module parameter

+sysfs-leaves-mount.patch
+sysfs-leaves-dir.patch
+sysfs-leaves-file.patch
+sysfs-leaves-bin.patch
+sysfs-leaves-symlink.patch
+sysfs-leaves-misc.patch

 backing store for sysfs

+fix-error-handling-in-selinuxfs.patch

 SELinux fix

+quota-fix-3-quota-file-corruption.patch

 quota fix

+submittingdrivers-completeness.patch

 Documentation additions

+edd-remove-unused-scsi-header-files.patch

 EDD cleanup

+efivars-add-module_version-remove-unnecessary-check-in-exit.patch

 Smal efivars changes

+do_generic_mapping_read-cleanup.patch

 Remove unneeded code

+drivers-cdrom-aztcdc-warning-fix.patch

 Fix a warning in this driver

+init-mca_bus_type-even-if-mca_bus.patch

 MCA fix

+pty-allocation-first-fit.patch

 First-fit allocation of pty indicies

+sync_inodes_sb-debug.patch
+split-backing_dev-memory-backed.patch
+ramdisk-fixes.patch
+ramdisk-memory-allocation-fixes.patch
+vmscan-handle-synchronous-writepage.patch
+ramdisk-lock-io-pages.patch
+ramdisk-use-kmap_atomic.patch
+ramdisk-page-uptodate-fix.patch
+ramdisk-writepages.patch
+blockdev-split-backing_dev_info.patch
+ramdisk-split-backing_dev_info.patch

 Ramdisk fixes

+2-3-small-tweaks-to-standard-resource-stuff.patch
+3-3-same-small-tweaks-x86_64-version.patch

 IO resource management changes

+knfsd-1-of-10-use-correct-_bh-locking-on-sv_lock.patch
+knfsd-2-of-10-make-sure-cache_negative-is-cleared-when-a-cache-entry-is-updates.patch
+knfsd-3-of-10-allow-larger-writes-to-sunrpc-svc-caches.patch
+knfsd-4-of-10-change-fh_compose-to-not-consume-a-reference-to-the-dentry.patch
+knfsd-5-of-10-protect-reference-to-exp-across-calls-to-nfsd_cross_mnt.patch
+knfsd-6-of-10-fix-race-conditions-in-idmapper.patch
+knfsd-7-of-10-improve-idmapper-behaviour-on-failure.patch
+knfsd-8-of-10-reduce-timeout-when-waiting-for-idmapper-userspace-daemon.patch
+knfsd-9-of-10-remove-check-on-number-of-threads-waiting-on-user-space.patch
+knfsd-10-of-10-add-a-warning-when-upcalls-fail.patch
+svc_recv-fix.patch

 Kernel NFS server updates

+debugging-option-to-put-data-symbols-in-kallsyms.patch

 Optionally add data symbols to kallsyms

+sis900-maintainer.patch
+sis900-add-new-isa-bridge-pci-id.patch
+sis900-fix-phy-transceiver-detection.patch
+sis900-small-cleanup-and-spelling-fixes.patch

 sis900 updates

+cache-sizing-fix.patch

 Fix corner case in calculation of storage for dentry and inode caches

+vga16fb-fix.patch

 Might fix this driver - awaiting confirmation

+getgroups16-fix.patch

 Do correct grops conversions

+fix-overzealous-use-of-online-cpu-iterators.patch

 Fix choice of CPU iterator in a couple of places.

+fixing-sendfile-on-64bit-architectures.patch

 Use sendfile64() by default on 64-bit platforms






All 274 patches:


linus.patch

system-state-splitup.patch
  system_state splitup

idedisk_reboot.patch
  ide-disk.c: don't put disks in STANDBY mode on reboot

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-input.patch

bk-libata.patch

bk-netdev.patch

bk-ntfs.patch

bk-net-drivers.patch

bk-pci.patch

bk-pcmcia.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

fealnx-bogon-fix.patch
  fealnx.c spinlock fix

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

blk_run_page-race-fix.patch
  blk_run_page() race fix

swapper_space-tree_lock-fix.patch
  Make swapper_space tree_lock irq-safe

__add_to_swap_cache-simplification.patch
  __add_to_swap_cache and add_to_pagecache() simplification

revert-swapcache-changes.patch
  revert recent swapcache handling changes

vmscan-revert-may_enter_fs-changes.patch
  vmscan-revert-may_enter_fs-changes

sync_page-use-swapper-space.patch
  Make sync_page use swapper_space again

__set_page_dirty_nobuffers-race-fix.patch
  __set_page_dirty_nobuffers race fix

rmap-7-object-based-rmap.patch
  rmap 7 object-based rmap
  rmap-7-object-based-rmap-sync_page-fix

ia64-rmap-build-fix.patch
  ia64 rmap build fix

rmap-8-unmap-nonlinear.patch
  rmap 8 unmap nonlinear
  try_to_unmap_cluster-comment

slab-panic.patch
  slab: consolidate panic code

rmap-9-remove-pte_chains.patch
  rmap 9 remove pte_chains
  page_add_anon_rmap BUG fix

rmap-10-add-anonmm-rmap.patch
  rmap 10 add anonmm rmap

rmap-anonhd-locking-fix.patch
  rmap anonhd locking fix

rmap-11-mremap-moves.patch
  rmap 11 mremap moves

rmap-12-pgtable-remove-rmap.patch
  rmap 12 pgtable remove rmap

rmap-13-include-asm-deletions.patch
  rmap 13 include/asm deletions

i_mmap_lock.patch
  Convert i_shared_sem back to a spinlock
  i_mmap_lock fix 1
  i_mmap_lock fix 2
  i_mmap_lock mremap fix

rmap-14-i_shared_lock-fixes.patch
  rmap 14: i_shared_lock fixes

numa-api-x86_64.patch
  numa api: -64 support
  numa api: Bitmap bugfix

numa-api-i386.patch
  numa api: Add i386 support

numa-api-ia64.patch
  numa api: Add IA64 support

numa-api-core.patch
  numa api: Core NUMA API code
  numa api: docs and policy_vma() locking fix
  numa-api-core-tweaks
  Some fixes for NUMA API
  From: Matthew Dobson <colpatch@us.ibm.com>
  Subject: [PATCH] include/linux/gfp.h cleanup for NUMA API
  numa-api-core bitmap_clear fixes

mpol-in-copy_vma.patch
  mpol in copy_vma

numa-api-core-slab-panic.patch
  numa-api-core-slab-panic

numa-api-statistics-2.patch
  Re-add NUMA API statistics

numa-api-vma-policy-hooks.patch
  numa api: Add VMA hooks for policy
  numa-api-vma-policy-hooks fix

numa-api-shared-memory-support.patch
  numa api: Add shared memory support
  numa-api-shared-memory-support-tweaks

small-numa-api-fixups.patch
  small numa api fixups
  small-numa-api-fixups-fix

small-numa-api-fixups-fix.patch
  small-numa-api-fixups-fix

numa-api-statistics.patch
  numa api: Add statistics

numa-api-anon-memory-policy.patch
  numa api: Add policy support to anonymous  memory

numa-api-fix-end-of-memory-handling-in-mbind.patch
  numa api: fix end of memory handling in mbind

rmap-15-vma_adjust.patch
  rmap 15: vma_adjust

rmap-16-pretend-prio_tree.patch
  rmap 16: pretend prio_tree

rmap-17-real-prio_tree.patch
  rmap 17: real prio_tree

rmap-18-i_mmap_nonlinear.patch
  rmap 18: i_mmap_nonlinear

unmap_mapping_range-comment.patch
  unmap_mapping_range-comment

rmap-19-arch-prio_tree.patch
  rmap 19: arch prio_tree
  rmap-19-arch-prio_tree-parisc

vm_area_struct-size-comment.patch
  vm_area_struct size comment

rmapc-comment-style-fixups.patch
  rmap.c comment/style fixups

rmap-20-i_mmap_shared-into-i_mmap.patch
  rmap 20 i_mmap_shared into i_mmap
  rmap-20-i_mmap_shared-into-i_mmap-parisc

rmap-21-try_to_unmap_one-mapcount.patch
  rmap 21 try_to_unmap_one mapcount

rmap-22-flush_dcache_mmap_lock.patch
  rmap 22 flush_dcache_mmap_lock
  rmap-22-flush_dcache_mmap_lock-parisc

rmap-23-empty-flush_dcache_mmap_lock.patch
  rmap 23 empty flush_dcache_mmap_lock

rmap-24-no-rmap-fastcalls.patch
  rmap 24 no rmap fastcalls

rmap-27-memset-0-vma.patch
  rmap 27 memset 0 vma

rmap-28-remove_vm_struct.patch
  rmap 28 remove_vm_struct

rmap-29-vm_reserved-safety.patch
  rmap 29 VM_RESERVED safety

rmap-30-fix-bad-mapcount.patch
  rmap 30 fix bad mapcount

rmap-31-unlikely-bad-memory.patch
  rmap 31 unlikely bad memory

rmap-32-zap_pmd_range-wrap.patch
  rmap 32 zap_pmd_range wrap

rmap-33-install_arg_page-vma.patch
  rmap 33 install_arg_page vma

rmap-34-vm_flags-page_table_lock.patch
  rmap 34 vm_flags page_table_lock

rmap-35-mmapc-cleanups.patch
  rmap 35 mmap.c cleanups

rmap-36-mprotect-use-vma_merge.patch
  rmap 36 mprotect use vma_merge

rmap-37-page_add_anon_rmap-vma.patch
  rmap 37 page_add_anon_rmap vma

rmap-38-remove-anonmm-rmap.patch
  rmap 38 remove anonmm rmap

rmap-39-add-anon_vma-rmap.patch
  rmap 39 add anon_vma rmap

rmap-40-better-anon_vma-sharing.patch
  rmap 40 better anon_vma sharing

partial-prefetch-for-vma_prio_tree_next.patch
  partial prefetch for vma_prio_tree_next

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

put-module-license-in-swim3c.patch
  put module license in swim3.c

ppc32-get-full-register-set-on-bad-kernel-accesses.patch
  PPC32: Get full register set on bad kernel accesses

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

sched-ifdef-active-balancing.patch
  sched: ifdef active balancing

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

stack-reductions-nfsread.patch
  stack reductions: nfs read

speed-up-sata.patch
  speed up SATA

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

use-less-stack-in-ide_unregister.patch
  use less stack in ide_unregister

fealnx-mac-address-and-other-issues.patch
  Fealnx. Mac address and other issues

reiserfs-group-alloc-9.patch
  reiserfs: block allocator optimizations

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

mark-config_mac_serial-drivers-macintosh-macserialc-as-broken.patch
  Mark CONFIG_MAC_SERIAL (drivers/macintosh/macserial.c) as broken

sis-agp-updates.patch
  fbdev: SIS AGP updates

clear_backing_dev_congested.patch
  clear_baking_dev_congested

dpt_i2o-warning-fixes.patch
  dpt_i2o warning fixes

make-4k-stacks-permanent.patch
  make 4k stacks permanent

force-config_regparm-to-y.patch
  Force CONFIG_REGPARM to `y'

invalid-notify_changesymlink-in-nfsd.patch
  Invalid notify_change(symlink, [ATTR_MODE]) in nfsd
  Fix "Invalid notify_change(symlink, [ATTR_MODE]) in nfsd"

hugetlb_shm_group-sysctl-gid-0-fix.patch
  hugetlb_shm_group sysctl-gid-0-fix

mlock_group-sysctl.patch
  mlock_group sysctl

nfs_writepage_sync-stack-reduction.patch
  nfs_writepage_sync stack reduction

nfs4-stack-reduction.patch
  nfs4 stack reduction

idr-overflow-fixes.patch
  Fixes for idr code

idr-remove-counter.patch
  idr: remove counter bits from id's

idr-fixups.patch
  IDR fixups

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

mqueue-rlimit-compile-fix-for-ppc-cris-m68k.patch
  mqueue rlimit compile fix for ppc/cris/m68k

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

slabify-iocontext-request_queue-SLAB_PANIC.patch
  slabify-iocontext-request_queue: use SLAB_PANIC

raid-locking-fix.patch
  raid locking fix.

seeky-readahead-speedups.patch
  speed up readahead for seeky loads

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

add-disable-param-to-capabilities-module.patch
  security: add disable param to capabilities module

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

remove-hardcoded-offsets-from-i386-asm.patch
  Remove hardcoded offsets from i386 asm

madvise-len-check.patch
  Fix madvise length checking

checkstack-target.patch
  Add `make checkstack' target

dentry-size-tuning.patch
  dentry size tuning

vm-shrink-zone.patch
  Fix arithmetic in shrink_zone()

vm-shrink-zone-fix.patch
  another shrink_caches arithmetic fix

kill-off-pc9800.patch
  Remove PC9800 support

more-pc9800-removal.patch
  more PC9800 removal

pc9800-merge-std_resourcesc-back-into-setupc.patch
  pc9800: merge std_resources.c back into setup.c

266-mm2-r8169-ethtool-set_settings.patch
  r8169: ethtool .set_settings

266-mm2-r8169-ethtool-get_settings.patch
  r8169: ethtool .get_settings

266-mm2-r8169-link-handling-rework-1-2.patch
  r8169: link handling rework (1/2)

266-mm2-r8169-link-handling-rework-2-2.patch
  r8169: link handling rework (2/2)

enable-runtime-cache-line-size-for-slab-on-i386.patch
  slab: enable runtime cache line size on i386

allow-arch-override-for-kmem_bufctl_t.patch
  slab: allow arch override for kmem_bufctl_t

add-kmem_cache_alloc_node.patch
  slab: add kmem_cache_alloc_node

work-around-gcc-333-hammer-sched-miscompilation-on-x86-64.patch
  Work around gcc 3.3.3-hammer sched miscompilation on x86-64

befs-maintainer-update.patch
  BeFS MAINTAINERS update

nfs-long-symlinks-fix.patch
  NFS: fix stack overflow with long symlinks

fix-for-266-makefiles-to-get-kbuild_output-working.patch
  Fix for Makefiles to get KBUILD_OUTPUT working

kexec-reserve-syscall-slot.patch
  reserve syscall slots for kexec

fore200e-warning-fixes.patch
  fore200e.c warning fix

qlogicfas408-warning-fix.patch
  qlogicfas408.c warning fix

blk_run_queues-remnants.patch
  Remove blk_run_queues() remnants

hfsplus-dir-rename-fix.patch
  hfsplus directory renaming fix

ftruncate-vs-block_write_full_page.patch
  ftruncate-vs-block_write_full_page

use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec.patch
  use idr_get_new to allocate a bus id in drivers/i2c/i2c-core.c

use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api.patch
  use-idr_get_new-to-allocate-a-bus-id-in-drivers-i2c-i2c-corec-update-to-new-api

replace-mod_inc_use_count-in-cyber2000fb.patch
  replace MOD_INC_USE_COUNT in cyber2000fb

dont-mention-mod_inc_use_count-mod_dec_use_count-in-docs.patch
  don't mention MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT in docs

mark-plan-video-driver-broken.patch
  mark the `planb' video driver broken

kbuild-subdirs=more-than-one.patch
  Subject: [PATCH] kbuild SUBDIRS="more/ than/ one/"

fix-userspace-include-of-linux-fsh.patch
  Fix userspace include of linux/fs.h

ext3-retry-allocation-after-transaction-commit-v2.patch
  Ext3: Retry allocation after transaction commit (v2)

correct-ps2esdi-module-parm-name.patch
  correct ps2esdi module parm name

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

fix-error-handling-in-selinuxfs.patch
  SELinux: fix error handling in selinuxfs

quota-fix-3-quota-file-corruption.patch
  Quota fix 3 - quota file corruption

submittingdrivers-completeness.patch
  SubmittingDrivers completeness

edd-remove-unused-scsi-header-files.patch
  EDD: remove unused SCSI header files

efivars-add-module_version-remove-unnecessary-check-in-exit.patch
  efivars: add MODULE_VERSION, remove unnecessary check in exit

do_generic_mapping_read-cleanup.patch
  do_generic_mapping_read() cleanup

drivers-cdrom-aztcdc-warning-fix.patch
  drivers/cdrom/aztcd.c warning fix.

init-mca_bus_type-even-if-mca_bus.patch
  initialise mca_bus_type even if !MCA_bus

pty-allocation-first-fit.patch
  pty-allocation-first-fit-fix

sync_inodes_sb-debug.patch
  sync_inodes_sb-debug

split-backing_dev-memory-backed.patch
  split apart backing_dev_info.memory-backed

ramdisk-fixes.patch
  ramdisk fixes

ramdisk-memory-allocation-fixes.patch
  ramdisk memory allocation fixes

vmscan-handle-synchronous-writepage.patch
  vmscan: handle synchronous writepage()

ramdisk-lock-io-pages.patch
  ramdisk: lock blockdev pages during "IO".

ramdisk-use-kmap_atomic.patch
  ramdisk: use kmap_atomic() in rd_blkdev_pagecache_IO()

ramdisk-page-uptodate-fix.patch
  ramdisk: fix PageUptodate() handling

ramdisk-writepages.patch
  ramdisk-writepages

blockdev-split-backing_dev_info.patch
  split blockdev backing_dev_info's from their client inodes

ramdisk-split-backing_dev_info.patch
  ramdisk: separate the blockdev backing_dev_info from the hosted inodes'

2-3-small-tweaks-to-standard-resource-stuff.patch
  small tweaks to standard resource stuff

3-3-same-small-tweaks-x86_64-version.patch
  same small resource tweaks, x86_64 version

knfsd-1-of-10-use-correct-_bh-locking-on-sv_lock.patch
  kNFSd: Use correct _bh locking on sv_lock.

knfsd-2-of-10-make-sure-cache_negative-is-cleared-when-a-cache-entry-is-updates.patch
  kNFSd: Make sure CACHE_NEGATIVE is cleared when a cache entry is updates.

knfsd-3-of-10-allow-larger-writes-to-sunrpc-svc-caches.patch
  kNFSd: Allow larger writes to sunrpc/svc caches.

knfsd-4-of-10-change-fh_compose-to-not-consume-a-reference-to-the-dentry.patch
  kNFSd: Change fh_compose to NOT consume a reference to the dentry.

knfsd-5-of-10-protect-reference-to-exp-across-calls-to-nfsd_cross_mnt.patch
  kNFSd: Protect reference to exp across calls to nfsd_cross_mnt

knfsd-6-of-10-fix-race-conditions-in-idmapper.patch
  kNFSd: Fix race conditions in idmapper

knfsd-7-of-10-improve-idmapper-behaviour-on-failure.patch
  kNFSd: Improve idmapper behaviour on failure.

knfsd-8-of-10-reduce-timeout-when-waiting-for-idmapper-userspace-daemon.patch
  kNFSd: Reduce timeout when waiting for idmapper userspace daemon.

knfsd-9-of-10-remove-check-on-number-of-threads-waiting-on-user-space.patch
  kNFSd: Remove check on number of threads waiting on user-space.

knfsd-10-of-10-add-a-warning-when-upcalls-fail.patch
  kNFSd: Add a warning when upcalls fail,

svc_recv-fix.patch
  svc_recv() fix

debugging-option-to-put-data-symbols-in-kallsyms.patch
  Debugging option to put data symbols in kallsyms

sis900-maintainer.patch
  Sis900: maintainer update

sis900-add-new-isa-bridge-pci-id.patch
  sis900: Add new ISA bridge PCI ID

sis900-fix-phy-transceiver-detection.patch
  sis900: Fix PHY transceiver detection

sis900-small-cleanup-and-spelling-fixes.patch
  sis900: Small cleanup and spelling fixes

cache-sizing-fix.patch
  VFS cache sizing fix for small machines

vga16fb-fix.patch
  vga16fb-fix

getgroups16-fix.patch
  getgroups16() fix

fix-overzealous-use-of-online-cpu-iterators.patch
  Fix overzealous use of online cpu iterators

fixing-sendfile-on-64bit-architectures.patch
  fix sendfile on 64bit architectures



