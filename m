Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbUEPJ4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUEPJ4i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 05:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUEPJ4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 05:56:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:15801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263415AbUEPJzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 05:55:43 -0400
Date: Sun, 16 May 2004 02:55:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-mm3
Message-Id: <20040516025514.3fe93f0c.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm3/

- A few VM changes, getting things synced up better with Andrea's work.

- A new kgdb stub, for ia64 (what happened to the grand unified kgdb
  project?)

- The backing-store-for-sysfs patches need redoing, and have been
  temporarily dropped




Changes since 2.6.6-mm2:


 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-input.patch
 bk-netdev.patch
 bk-pci.patch
 bk-scsi.patch

 External trees, latest versions.

-yield_irq.patch
-MSEC_TO_JIFFIES-fixups.patch
-msec_to_jiffies-fixups-speedup.patch
-revert-process-migration-speedup.patch
-vm-accounting-fix.patch
-kexec-reserve-syscall-slot.patch
-do_mounts_rd-malloc-fix.patch
-page_count-fixups.patch
-page-freeing-race-fix.patch
-arch-atomic_add_negative.patch
-arch-atomic_inc_and_test.patch
-frame-pointer-based-stack-dumps.patch
-bk-driver-core-module-fix.patch
-writeback_inodes-fix.patch
-wakefunc.patch
-wakeup.patch
-filtered_page.patch
-filtered_buffer.patch
-rename-rmap_lock.patch
-rmap-5-swap_unplug-page-revert.patch
-blk_run_page.patch
-blk_run_page-swap-fixup.patch
-blk_run_page-sync_buffer-revert.patch
-swap-speedups-and-fix.patch
-ppc64-uninline-__pte_free_tlb.patch
-export-clear_pages-on-ppc32.patch
-ppc32-fix-__flush_dcache_icache_phys-for-book-e.patch
-ppc32-fix-copy-prefetch-on-non-coherent-ppcs.patch
-ppc32-add-book-e--ppc44x-specific-exception-support.patch
-ppc32-add-book-e--ppc44x-specific-exception-support-2.patch
-ppc32-new-ocp-core-support-updated.patch
-ppc32-bubinga-405ep-for-new-ocp.patch
-ppc32-ppc44x-lib-support.patch
-ppc32-ibm-ppc4xx-specific-ocp-support.patch
-ppc32-4xx-core-fixes-and-440gx-pic-support.patch
-ppc32-update-4xx-defconfigs.patch
-ppc32-ppc40x-ports-for-new-ocp.patch
-ppc32-ppc44x-ports-for-new-ocp.patch
-sched-loadup-roundup.patch
-sched-activate-tslt.patch
-use-soft-float.patch
-0-autofs4-2.6.0-signal-20040405.patch
-add-omitted-autofs4-super-block-field.patch
-1-autofs4-2.6.4-cleanup-20040405.patch
-2-autofs4-2.6.4-fill_super-20040405.patch
-3-autofs4-2.6.0-bkl-20040405.patch
-4-autofs4-2.6.0-expire-20040405.patch
-4-autofs4-260-expire-20040405-fix.patch
-4-autofs4-260-expire-20040405-fix-fix.patch
-4-autofs4-2.6.0-expire-20040405-may_umount_tree-cleanup.patch
-5-autofs4-2.6.0-readdir-20040405.patch
-umount-after-bad-chdir.patch
-autofs4-fix-handling-of-chdir-and-chroot.patch
-6-autofs4-2.6.0-may_umount-20040405.patch
-7-autofs4-2.6.0-extra-20040405.patch
-autofs-locking-fix.patch
-autofs4-race-fix.patch
-autofs4-compat-ioctls.patch
-radeon-garbled-screen-fix.patch
-neomagic-driver-update.patch
-tridentfbc-warning-fix.patch
-hgafbc-warning-fix.patch
-tdfxfbc-warning-fix.patch
-imsttfbc-warning-fix.patch
-fbdev-logo-handling-fix.patch
-fbdev-redundant-prows-calculation-removal.patch
-fbdev-remove-redundant-local.patch
-fbdev-access_align-default.patch
-fix-null-ptr-dereference-in-pm2fb_probe-2.patch
-virtual-fbdev-updates.patch
-vesa-fbdev-update.patch
-vesa-fbdev-update-fix.patch
-new-asiliant-framebuffer-driver.patch
-fbcon-and-unimap.patch
-videodev-handle-class_register-failure.patch
-q40-fbdev-updates.patch
-acpiphp_glue-oops-fix.patch
-dpt_i2o.patch
-ia64-cpuhotplug-core_kernel_init.patch
-ia64-cpuhotplug-init_removal.patch
-ia64-cpuhotplug-sysfs_ia64.patch
-ia64-cpuhotplug-irq_affinity_fix.patch
-ia64-cpuhotplug-palinfo.patch
-ia64-cpu-hotplug-cpu_present-2.patch
-ia64-cpu-hotplug-cpu_present-2-fix.patch
-ia64-cpuhotplug-hotcpu.patch
-module-ref-counting-for-vt-console-drivers.patch
-i2o-subsystem-fixing-and-cleanup-for-26-i2o-config-cleanpatch.patch
-i2o-subsystem-fixing-and-cleanup-for-26-i2o-passthrupatch.patch
-i2o-64-bit-fixes.patch
-i2o-subsystem-fixing-and-cleanup-for-26-i2o_block-cleanuppatch.patch
-i2o-subsystem-fixing-and-cleanup-for-26-i2o-64-bit-fixpatch.patch
-i2o-subsystem-fixing-and-cleanup-for-26-i2o-makefile-cleanuppatch.patch
-ia64-remove-errno-refs.patch
-invalid-notify_changesymlink-in-nfsd-fix.patch
-fix-net-tulip-winbond-840c-warning.patch
-d_flags-locking-fix.patch
-d_vfs_flags-locking-fix.patch
-dentry-shrinkage.patch
-dentry-qstr-consolidation.patch
-dentry-qstr-consolidation-fix.patch
-dentry-d_bucket-fix.patch
-dentry-d_flags-consolidation.patch
-dentry-layout-tweaks.patch
-to-fix-i2o_proc-kernel-panic-on-access-of-proc-i2o-iop0-lct.patch
-i2o_proc-module-owner-fix.patch
-slabify-iocontext-request_queue.patch
-show-last-kernel-image-symbol-in-proc-kallsyms.patch
-include-aliases-in-kallsyms.patch
-make-buildcheck.patch
-make-buildcheck-license-fix.patch
-efivars-fix.patch
-expose-backing-dev-max-read-ahead.patch
-ib700wdt-fix.patch
-ib700wdt-fix-2.patch
-laptop-doc-bugfix.patch
-create_workqueue-locking-bogon.patch
-problem-with-aladdincard-entry-in-parport_pc.patch
-watchdog-timer-for-intel-ixp4xx-cpus.patch
-i810_audio-fixes-from-herbert-xu.patch
-ide-diskc-revert-to-previous-24-way-of-handling-flush-cache-commands.patch
-update-laptop-mode-control-script-with-xfs_hz=100.patch
-del_singleshot_timer_sync.patch
-del_singleshot_timer_sync-tweaks.patch
-dquot_release-oops-workaround.patch
-h8-300-update-1-9-bitopsh-add-find_next_bit.patch
-h8-300-update-2-9-ldscripts-fix.patch
-h8-300-update-3-9-pic-support.patch
-h8-300-update-4-9-preempt-support.patch
-h8-300-update-5-9-sci-driver-fix.patch
-h8-300-update-6-9-ne-driver.patch
-h8-300-update-7-9-kconfig.patch
-h8-300-update-8-9-delete-headers.patch
-h8-300-update-9-9-more-cleanup.patch
-calculate-ngroups_per_block-from-page_size.patch
-pci-debug-compile-fix-in-sis_router_probe.patch
-remove-empty-build-of-capabilityo.patch
-minor-cleanups-in-capabilityc.patch
-fix-linux-doc-errors.patch
-fix-block-layer-ioctl-bug.patch
-x86_64-has-buggy-ffs-implementation.patch
-make-reiserfs-not-to-crash-on-oom.patch
-implement-print_modules.patch
-m68k-print_modules.patch
-fix-endianess-in-modpost-when-cross-compiling-for-sparc-on-i386.patch
-fix-cyclades-compile-with-pci.patch
-fix-tlanc-for-pci.patch
-fix-aic7xxx_oldc-for-pci.patch
-powernow-k8-buggy-bios-override-for-266.patch
-x86_64-msr-warning-fix.patch

 Merged

-x86_64-doesnt-like-gcc-333.patch

 Dropped in favour of compile-time workaround

+idedisk_reboot.patch

 Don't spin down IDE disks on reboot

+revert-i8042-interrupt-handling.patch

 This was causing lockups when people hit caps-lock.

+kgdb-ia64-support.patch

 An ia64 KGDB stub.

+swapper_space-tree_lock-fix.patch
+__add_to_swap_cache-simplification.patch
+revert-swapcache-changes.patch
+sync_page-use-swapper-space.patch
+__set_page_dirty_nobuffers-race-fix.patch

 Various VM fixes, cleanups and changes to sync things up a bit more with
 2.6.5 and -aa trees.

-rmap-7-object-based-rmap-sync_page-fix.patch

 Folded into rmap-7-object-based-rmap.patch

-try_to_unmap_cluster-comment.patch

 Folded into rmap-8-unmap-nonlinear.patch

-rmap-9-page_add_anon_rmap-bug-fix.patch

 Folded into rmap-9-remove-pte_chains.patch

+numa-api-fix-end-of-memory-handling-in-mbind.patch

 NUMA API fixup

-rmap-19-arch-prio_tree-parisc.patch

 Folded into rmap-19-arch-prio_tree.patch

-rmap-20-i_mmap_shared-into-i_mmap-parisc.patch

 Folded into rmap-20-i_mmap_shared-into-i_mmap.patch

-rmap-22-flush_dcache_mmap_lock-parisc.patch

 Folded into rmap-22-flush_dcache_mmap_lock.patch

+ppc32-ibm-powerpc-750gx-support.patch
+ppc32-some-whitespace-fixes.patch
+ppc32-handle-altivec-assist-exception-properly.patch
+ppc32-update-defconfigs.patch
+ppc32-fix-mod_incdec_use_count-abuse-in-ppc-4xx-8xx-code.patch

 ppc32 updates

+sched-ifdef-active-balancing.patch

 scheduler space saving.  Still under discussion.

-advansys-fix.patch

 Dropped - the driver's broken so leave it generating warnings.

-cciss-logical-device-queues.patch

 Dropped - it doesn't address the starvation problem of having multiple
 devices share a single queue.

-ext3-discard-reservation-in-last-iput-fix-patch.patch
-ext3-discard-reservation-in-last-iput-fix-patch-fix.patch

 Folded into ext3-lazy-discard-reservation-window-patch.patch

+dpt_i2o-warning-fixes.patch

 Fix a couple of warnings

-fix-sysfs-symlinks.patch
-sysfs-backing-store-sysfs_rename_dir-fix.patch
-sysfs-leaves-mount.patch
-sysfs-leaves-dir.patch
-sysfs-leaves-file.patch
-sysfs-leaves-symlink.patch
-sysfs-leaves-bin.patch
-sysfs-leaves-misc.patch

 Other patches broke the sysfs-backing-store work.  It's being redone.

-die_386_graphic.patch

 Sorry, it can cause important pre-oops printks to scroll away.

+idr-fixups.patch

 Several fixes for the IDR library code.

+mqueue-rlimit-compile-fix-for-ppc-cris-m68k.patch

 rlimits build fix

+have-xfs-use-kernel-provided-qsort-fix.patch

 XFS makefile fix for the qsort rework

+hpet-driver.patch

 HPET clock driver (needs work)

+remove-hardcoded-offsets-from-i386-asm.patch

 i386 assembly cleanup

+madvise-len-check.patch

 Fix madvise() argument checking

+checkstack-target.patch

 Add `make checkstack'

+dentry-size-tuning.patch

 Fiddle with dentry sizing a bit.

+vm-shrink-zone.patch

 Fix bogon in page reclaim

+kill-off-pc9800.patch

 Remove the PC9800 subarch

+266-mm2-r8169-napi.patch
+266-mm2-r8169-janitoring.patch
+266-mm2-r8169-register-rename.patch
+266-mm2-r8169-ethtool-set_settings.patch
+266-mm2-r8169-ethtool-get_settings.patch
+266-mm2-r8169-link-handling-rework-1-2.patch
+266-mm2-r8169-link-handling-rework-2-2.patch

 r8169 net driver update

+enable-runtime-cache-line-size-for-slab-on-i386.patch

 Tune slab alignment at runtime for i386

+allow-arch-override-for-kmem_bufctl_t.patch

 Permit 16-bit metadata in slab caches, use it on i386

+add-kmem_cache_alloc_node.patch

 NUMA optimisations for slab.

+work-around-gcc-333-hammer-sched-miscompilation-on-x86-64.patch

 Work around the x86_64 gcc-3.3.3 miscompilation

+befs-maintainer-update.patch

 MAINTAINERS update

+quota-recursion-fix-fix.patch

 Clean up recent quota patch

+nfs-long-symlinks-fix.patch

 Fix for super-long symlinks on nfsv3

+fix-for-266-makefiles-to-get-kbuild_output-working.patch

 Build fix for build-in-a-separate-directory on some architectures.

+kexec-reserve-syscall-slot.patch

 Reserve the kexec syscall slot on supported architectures.

+fore200e-warning-fixes.patch
+qlogicfas408-warning-fix.patch

 Fix warnings.




All 202 patches


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

bk-input.patch

bk-netdev.patch

bk-pci.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

fealnx-bogon-fix.patch
  fealnx.c spinlock fix

acpi-procfs-fix.patch
  acpi procfs fix

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

swapper_space-tree_lock-fix.patch
  Make swapper_space tree_lock irq-safe

__add_to_swap_cache-simplification.patch
  __add_to_swap_cache and add_to_pagecache() simplification

revert-swapcache-changes.patch
  revert recent swapcache handling changes

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

partial-prefetch-for-vma_prio_tree_next.patch
  partial prefetch for vma_prio_tree_next

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc32-ibm-powerpc-750gx-support.patch
  ppc32: IBM PowerPC 750GX Support

ppc32-some-whitespace-fixes.patch
  ppc32: some whitespace fixes

ppc32-handle-altivec-assist-exception-properly.patch
  ppc32: Handle altivec assist exception properly

ppc32-update-defconfigs.patch
  ppc32: update defconfigs

ppc32-fix-mod_incdec_use_count-abuse-in-ppc-4xx-8xx-code.patch
  ppc32: fix MOD_{INC,DEC}_USE_COUNT abuse in 4xx/8xx code

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

missing-closing-n-in-printk.patch
  missing closing n in printk

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
  idr-overflow-fixes fix
  More fixes for idr code
  Fixes for POSIX timers
  timers-signals-rlimits-setuid-fix
  timers-signals-rlimits-fix
  timers-signals-rlimits-rename-stuff
  idr-overflow-fixes fix
  More fixes for idr code

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

serial-fifo-size-is-ignored.patch
  serial fifo size is ignored

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

hpet-driver.patch
  HPET driver

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

kill-off-pc9800.patch
  Remove PC9800 support

266-mm2-r8169-napi.patch
  r8169: napi

266-mm2-r8169-janitoring.patch
  r8169: janitoring

266-mm2-r8169-register-rename.patch
  r8169: register rename

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

quota-recursion-fix-fix.patch
  quota-recursion-fix-fix

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



