Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264242AbUEEIdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbUEEIdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 04:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbUEEIdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 04:33:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:60557 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264272AbUEEIbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 04:31:55 -0400
Date: Wed, 5 May 2004 01:31:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc3-mm2
Message-Id: <20040505013135.7689e38d.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc3/2.6.6-rc3-mm2/

- Lots of little fixes and updates.  Nothing really major.

- The huge memory leak from 2.6.6-rc3-mm1 is fixed.




Changes since 2.6.6-rc3-mm2:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-i2c.patch
 bk-input.patch
 bk-libata.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch
 bk-usb.patch

 Latest versions of various development trees

-cifs-build-fix.patch
-nfs-printk-warning-fix.patch
-efivars-sysfs-fix.patch
-dvbfix-adapter-module-removal-bug.patch
-s390-oprofile-config-cleanup.patch
-make-ikconfig-quiet.patch
-ppc64-shmget-translation-bugfix.patch
-aic7xxx-deadlock-fix.patch
-aic7xxx-section-fix.patch
-string_h-needs-compiler_h.patch
-new-set-of-input-patches-synaptics-cleanup.patch
-new-set-of-input-patches-synaptics-middle-button-support.patch
-new-set-of-input-patches-dont-change-max-proto.patch
-new-set-of-input-patches-atkbd-soften-accusation.patch
-new-set-of-input-patches-atkbd-trailing-whitespace.patch
-new-set-of-input-patches-atkbd-use-bitfields.patch
-new-set-of-input-patches-atkbd-timeout-complaints.patch
-new-set-of-input-patches-psmouse-rescan-on-hotplug.patch
-new-set-of-input-patches-psmouse-reconnect-after-error.patch
-new-set-of-input-patches-psmouse-add-protocol_handler.patch
-new-set-of-input-patches-psmouse-sliced-commands.patch
-new-set-of-input-patches-atkbd-reconnect-probe.patch
-new-set-of-input-patches-allow-disabling-psaux.patch
-new-set-of-input-patches-serio-whitespace.patch
-new-set-of-input-patches-serio-open-close-optional.patch

 Merged

+page_mapping-race-fix.patch

 Avoid a possible BUG in the rmap code.

+fealnx-bogon-fix.patch

 Locking fix

+rmap-9-page_add_anon_rmap-bug-fix.patch

 Fix a BUG in the rmap code

+rmap-anonhd-locking-fix.patch

 Fix a race in the rmap code

+small-numa-api-fixups.patch

 Fixes against the NUMA API

+vm_area_struct-size-comment.patch
+rmapc-comment-style-fixups.patch
+rmap-20-i_mmap_shared-into-i_mmap.patch
+rmap-21-try_to_unmap_one-mapcount.patch
+rmap-22-flush_dcache_mmap_lock.patch
+rmap-23-empty-flush_dcache_mmap_lock.patch

 More VM/rmap work

+partial-prefetch-for-vma_prio_tree_next.patch

 Might speed up the prio-tree code.

+fix-deadlock-in-journalled-quota-fix.patch

 Fix fix-deadlock-in-journalled-quota.patch

+ppc-ppc64-cleanup-ppc970-cpu-initialization.patch
+benh-credits-update.patch
+ppc32-add-missing-dma_mapping_error.patch

 ppc things

-selinux-inode-race-trap.patch

 No longer needed

+sched-ppc64-sched-domain-support-fix.patch

 Fix sched-ppc64-sched-domain-support.patch

+sched-kthread_stop_race_fix.patch

 Fix a race in kthread_stop()

+fixes-in-32-bit-ioctl-emulation-code.patch

 fs/compat.c locking fixes

+binfmt_misc-credentials-fixes-2.patch

 Fixes against binfmt_misc-credentials.patch

-fix-acer-travelmate-360-interrupt-routing.patch

 I was asked to drop this.

+ext3-reservation-bad-inode-fix.patch

 ext3 reservation code fix

+autofs-locking-fix.patch
+autofs4-race-fix.patch

 Fixes against the autofs4 patches

+ext3-error-handling-fixes.patch

 Fix some error-path code in ext3/namei,c

+re-open-descriptors-closed-on-exec-by-selinux-to.patch

 SELinux fix

+cyclades-maintainers-update.patch

 MAINTAINERS update

+laptop-mode-mutt-noatime-doc-update.patch

 Documentation

-bssprot.patch
-bssprot-sparc-fix.patch
-bssprot-cleanup.patch
-bssprot-more-fixes.patch

 Dropped.  These were causing pain and Wine userspace can work around it.  We
 should fix this though.

+shrink_slab-handle-GFP_NOFS-fix.patch

 Fix ghastly VFS cache leak.

+reiserfs-remove-debugging-warning-from-block-allocator.patch

 reiserfs tidyup.

+tdfxfbc-warning-fix.patch

 Fix warnings in the tdfx driver

 ia64-cpuhotplug-core_kernel_init.patch
 ia64-cpuhotplug-init_removal.patch
 ia64-cpuhotplug-sysfs_ia64.patch
 ia64-cpuhotplug-irq_affinity_fix.patch
 ia64-cpuhotplug-palinfo.patch

 Updated

-ia64-cpuhotplug-hotcpu.patch
-ia64-cpuhotplug-cpu_present_map.patch

 Dropped.  ia64-cpuhotplug-cpu_present_map.patch interacts fatally with the
 sched-domains code.

+cmpci-update.patch

 Update the cmpci.c OSS driver

+i2o-subsystem-fixing-and-cleanup-for-26-i2o-config-cleanpatch.patch
+i2o-subsystem-fixing-and-cleanup-for-26-i2o-passthrupatch.patch
+i2o-subsystem-fixing-and-cleanup-for-26-i2o_block-cleanuppatch.patch
+i2o-subsystem-fixing-and-cleanup-for-26-i2o-64-bit-fixpatch.patch
+i2o-subsystem-fixing-and-cleanup-for-26-i2o-makefile-cleanuppatch.patch

 i2o fixes/cleanups

+dentry-and-inode-cache-hash-algorithm-performance-changes.patch

 Bettern hashing functions for the dentry and inode caches

+fix-mtd-suspend-resume.patch

 PM fix in MTD

+remove-blk_queue_bounce-messages.patch

 Kill some printks

+fix-deadlock-in-__create_workqueue-2.patch

 Fix a deadlock in the workqueue code

+throttle-p4-thermal-warnings.patch

 Less log output.

+i82365c-warning-fix.patch

 Fix a warning

+allow-i386-to-reenable-interrupts-on-lock-contention.patch

 re-enable interrupts while spinning in spin_lcok_irq() on ia32.

+make-4k-stacks-permanent.patch

 Fill my inbox.

+worker_thread-race-fix.patch

 Fix wakeup race in the workqueue code.

+force-config_regparm-to-y.patch

 Remove the CONFIG_REGPARM option.

+kernel-syscalls-retval-fix.patch
+remove-errno-refs.patch
+ia64-remove-errno-refs.patch

 Fiddle with kernel syscalls and remove the global `errno' variable.  I
 actually meant to drop this because we'll be doing it differently.

+warn-when-smp_call_function-is-called-with-interrupts-disabled.patch

 smp_call_function() is deadlocky if the caller has disabled interrupts

+initio-ini-9x00u-uw-error-handling-in-26.patch

 Fix a scsi driver

+fixup-68360-module-refcounting.patch

 Fix module refcounting in this driver.

+missing-closing-n-in-printk.patch

 Fix a printk.

+intermezzo-stack-reduction.patch

 Reduce stack usage in intermezzo

+lance-racal-interlan-fix.patch

 Fix the lance net driver for one type of NIC.

+gcc-340-fixes-for-266-rc3-x86_64-kernel.patch

 Fix the x86_64 port for gcc-3.4

+fix-warn_on-on-xfs-module-unload.patch

 prevent a warning when xfs.ko is unloaded.

+ppc64-use-generic-ipc-syscall-translation.patch

 PPC64 code consolidation

+proc-sys-kernel-vermagic.patch

 Add /proc/sys/kernel/vermagic so that package installers can work out how
 the kernel was built (soliciting feedback on this one).

+ramdisk-size-warning-fix.patch

 Fix an assembler warning

+cyclades-cleanups.patch
+cyclades-cleanups-cleanups.patch

 Clean up the cyclades driver

+nforce-disconnect-fix.patch

 Fix the nforce2 horrors.

+delete-posix-conformance-testing-by-unifix-message.patch

 Kill another boot-time printk.

+jiffies-to-clockt-fix_a1.patch

 Timekeeping accuracy fixes.

+readahead-private.patch

 Prevent concurrent reads against the same fd from screwing with the
 readahead state.

+static-define_per_cpu-vs-modules-2.patch

 Work around relative address displacement problems on s390.

+introduce-asm--8253pith.patch
+use-pit_tick_rate-in-spkrc.patch
+use-clock_tick_rate.patch

 Fiddle with the PIT code to make it more friendly to non-PC machines.

+netpoll-attributions.patch

 Update the attributions in netpoll.c

+265-es7000-subarch-update-for-generic-arch.patch

 Make es7000 a real subarch

+new-i2c-video-decoder-calls.patch
+new-i2c-video-decoder-calls-saa7111.patch

 i2c cleanups/fixes

+get_thread_area-macros.patch

 Fix the get_thread_area() macros

+update-documentation-mdtxt.patch

 MD documentation update

+invalid-notify_changesymlink-in-nfsd.patch

 Fix notofy_change() in knfsd.

+bfs-filesystem-read-past-the-end-of-dir.patch

 BFS fix

+simplify-mqueue_inode_info-messages-allocation.patch

 Fix a leak in the posix message queue code.

+filtered-wakeups-core.patch
+filtered-buffer_head-wakeups.patch
+filtered-buffer_head-wakeups-tweaks.patch
+wake-one-pg_locked-bh_lock-semantics.patch
+wake-one-pg_locked-bh_lock-semantics-tweaks.patch

 More efficient sleeps and and wakeups, use them in the VFS.




All 332 patches:

linus.patch

page_mapping-race-fix.patch
  page_mapping race fix

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-drm.patch

bk-i2c.patch

bk-input.patch

bk-libata.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

frame-pointer-based-stack-dumps.patch
  x86: stack dumps using frame pointers

frame-pointer-based-stack-dumps-tweaks.patch
  frame-pointer-based-stack-dumps-tweaks

fealnx-bogon-fix.patch
  fealnx.c spinlock fix

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

rmap-7-object-based-rmap.patch
  rmap 7 object-based rmap

ia64-rmap-build-fix.patch
  ia64 rmap build fix

rmap-8-unmap-nonlinear.patch
  rmap 8 unmap nonlinear

slab-panic.patch
  slab: consolidate panic code

rmap-9-remove-pte_chains.patch
  rmap 9 remove pte_chains

rmap-9-page_add_anon_rmap-bug-fix.patch
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

i_shared_lock.patch
  Convert i_shared_sem back to a spinlock
  i_shared_lock fix 1
  i_shared_lock fix 2
  i_shared_lock mremap fix

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

numa-api-statistics.patch
  numa api: Add statistics

numa-api-anon-memory-policy.patch
  numa api: Add policy support to anonymous  memory

rmap-15-vma_adjust.patch
  rmap 15: vma_adjust

rmap-16-pretend-prio_tree.patch
  rmap 16: pretend prio_tree

rmap-17-real-prio_tree.patch
  rmap 17: real prio_tree

rmap-18-i_mmap_nonlinear.patch
  rmap 18: i_mmap_nonlinear

rmap-19-arch-prio_tree.patch
  rmap 19: arch prio_tree

vm_area_struct-size-comment.patch
  vm_area_struct size comment

rmapc-comment-style-fixups.patch
  rmap.c comment/style fixups

rmap-20-i_mmap_shared-into-i_mmap.patch
  rmap 20 i_mmap_shared into i_mmap

rmap-21-try_to_unmap_one-mapcount.patch
  rmap 21 try_to_unmap_one mapcount

rmap-22-flush_dcache_mmap_lock.patch
  rmap 22 flush_dcache_mmap_lock

rmap-23-empty-flush_dcache_mmap_lock.patch
  rmap 23 empty flush_dcache_mmap_lock

partial-prefetch-for-vma_prio_tree_next.patch
  partial prefetch for vma_prio_tree_next

fix-deadlock-in-journalled-quota.patch
  Fix deadlock in journalled quota

fix-deadlock-in-journalled-quota-fix.patch
  fix-deadlock-in-journalled-quota fix

mips-update.patch
  MIPS update

mips-fix-mips-26-fb-setup.patch
  mips: fix 2.6 fb setup

mips-simplify-expression.patch
  mips: Simplify expression

mips-newport-driver-fixes.patch
  mips: newport driver fixes

mips-remove-video_type_sni_rm.patch
  mips: remove VIDEO_TYPE_SNI_RM

mips-gbe-video-driver.patch
  mips: GBE Video Driver

mips-add-missing-ip22-zilog-bit.patch
  mips: add missing IP22 Zilog bit

mips-64-bit-mips-needs-compat-stuff.patch
  mips: 64-bit MIPS needs compat stuff

mips-remove-dz-driver.patch
  mips: remove dz driver

mips-sgiwd93-26-fixes-and-crapectomy.patch
  mips: sgiwd93 2.6 fixes and crapectomy

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc-ppc64-cleanup-ppc970-cpu-initialization.patch
  ppc/ppc64: Cleanup PPC970 CPU initialization

benh-credits-update.patch
  Fix my address in CREDITS

ppc32-add-missing-dma_mapping_error.patch
  ppc32: Add missing [pci_]dma_mapping_error()

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

local_bh_enable-warning-fix.patch

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c

sched-run_list-cleanup.patch
  small scheduler cleanup

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support

sched-domain-debugging.patch
  sched_domain debugging

sched-domain-balancing-improvements.patch
  scheduler domain balancing improvements

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-group-power.patch
  sched-group-power

sched-domains-use-cpu_possible_map.patch
  sched_domains: use cpu_possible_map

sched-smt-nice-handling.patch
  sched: SMT niceness handling

sched-local-load.patch
  sched: add local load metrics

sched-process-migration-speedup.patch
  Reduce TLB flushing during process migration

sched-trivial.patch
  sched: trivial fixes, cleanups

sched-hotplug-cpu-sched_balance_exec-fix.patch
  Hotplug CPU sched_balance_exec Fix

sched-wakebalance-fixes.patch
  sched: wakeup balancing fixes

sched-imbalance-fix.patch
  sched: fix imbalance calculations

sched-altix-tune1.patch
  sched: altix tuning

sched-fix-activelb.patch
  sched: oops fix

sched-ppc64-sched-domain-support.patch
  ppc64: sched-domain support

sched-ppc64-sched-domain-support-fix.patch
  ARCH_HAS_SCHED_WAKE_BALANCE doesnt exist

sched-domain-setup-lock.patch
  sched: fix setup races

sched-minor-cleanups.patch
  sched: minor cleanups

sched-inline-removals.patch
  sched: uninlinings

sched-move-cold-task.patch
  sched: move cold task in mysteriouis ways

sched-migrate-shortcut.patch
  sched: add migration shortcut

sched-more-sync-wakeups.patch
  sched: extend sync wakeups

sched-boot-fix.patch
  sched: lock cpu_attach_domain for hotplug

sched-cleanups.patch
  sched: cleanups

sched-damp-passive-balance.patch
  sched: passive balancing damping

sched-cpu-load-cleanup.patch
  sched: cpu load management cleanup

sched-balance-context.patch
  sched: balance-on-clone

sched-less-idle.patch
  sched: reduce idle time

sched-wake_up-speedup.patch
  sched: micro-optimisation for wake_up

sched-smt-domain-race.patch
  sched: Look at another CPU's domain

sched-move-migrate_all_tasks-to-cpu_dead-handling.patch
  Move migrate_all_tasks to CPU_DEAD handling

sched-move-migrate_all_tasks-to-cpu_dead-handling-up-fix.patch
  sched-move-migrate_all_tasks-to-cpu_dead-handling-up-fix

sched-move-migrate_all_tasks-to-cpu_dead-handling-unlikely-cleanup.patch
  Move migrate_all_tasks to CPU_DEAD handling: unlikely() cleanup

sched-sys_sched_getaffinity_lock_cpu_hotplug.patch
  sched_getaffinity vs cpu hotplug race fix

sched-kthread_stop_race_fix.patch
  migration_thread() race fix

schedstats.patch
  sched: scheduler statistics

fixes-in-32-bit-ioctl-emulation-code.patch
  Fixes in 32 bit ioctl emulation code

cond_resched-might-sleep.patch
  cond_resched() might sleep

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

binfmt_misc-credentials-fixes.patch
  binfmt_misc-credentials cleanups and fixes

binfmt_misc-credentials-fixes-2.patch
  More binfmt_misc-credentials fixes

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

nmi_watchdog-local-apic-fix.patch
  Fix nmi_watchdog=2 and P4 HT

nmi-1-hz-2.patch
  reduce NMI watchdog call frequency with local APIC.

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

advansys-fix.patch
  advansys check_region() fix

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

nfs-O_DIRECT-fixes.patch
  NFS: O_DIRECT fixes

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

cciss-logical-device-queues.patch
  cciss: per logical device queues

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

ext3-discard-reservation-in-last-iput-fix-patch.patch
  ext3 discard reservation in last iput fix patch

ext3-discard-reservation-in-last-iput-fix-patch-fix.patch
  Fix lazy reservation discard

ext3-reservation-bad-inode-fix.patch
  ext3 reservations: bad_inode fix

ext3-bogus-enospc-fix.patch
  Fix ext3 bogus ENOSPC

sched-in_sched_functions.patch
  sched: in_sched_functions() cleanup

sysfs-d_fsdata-race-fix-2.patch
  kobject/sysfs race fix

0-autofs4-2.6.0-signal-20040405.patch
  autofs: dnotify + autofs may create signal/restart syscall loop

add-omitted-autofs4-super-block-field.patch
  add omitted autofs4 super block field

1-autofs4-2.6.4-cleanup-20040405.patch
  autofs: printk cleanups

2-autofs4-2.6.4-fill_super-20040405.patch

3-autofs4-2.6.0-bkl-20040405.patch
  autofs: locking rework

4-autofs4-2.6.0-expire-20040405.patch
  autofs: expiry refcount fixes

4-autofs4-260-expire-20040405-fix.patch
  4-autofs4-2.6.0-expire-20040405 locking fix

4-autofs4-260-expire-20040405-fix-fix.patch
  autofs expiry fix

4-autofs4-2.6.0-expire-20040405-may_umount_tree-cleanup.patch
  autofs4: may_umount_tree() cleanup

5-autofs4-2.6.0-readdir-20040405.patch
  autofs: readdir fixes

umount-after-bad-chdir.patch
  fix umount after bad chdir

autofs4-fix-handling-of-chdir-and-chroot.patch
  autofs4: fix handling of chdir and chroot

6-autofs4-2.6.0-may_umount-20040405.patch
  autofs: add ioctl to query unmountability

7-autofs4-2.6.0-extra-20040405.patch
  autofs: readdir futureproofing

autofs-locking-fix.patch
  autofs locking fix

autofs4-race-fix.patch
  autofs4 race fix

ext3-error-handling-fixes.patch
  ext3 error handling fixes

re-open-descriptors-closed-on-exec-by-selinux-to.patch
  selinux: reopen descriptors closed on exec to /dev/null

cyclades-maintainers-update.patch
  cyclades MAINTAINERS update

laptop-mode-mutt-noatime-doc-update.patch
  Laptop Mode doc update

as-increase-batch-expiry.patch
  AS: increase batch expiry intervals

consolidate-sys32_readv-and-sys32_writev.patch
  Consolidate sys32_readv and sys32_writev

consolidate-do_execve32.patch
  Consolidate do_execve32

consolidate-sys32_select.patch
  Consolidate sys32_select

consolidate-sys32_nfsservctl.patch
  Consolidate sys32_nfsservctl

clean-up-asm-pgalloch-include.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-2.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-3.patch
  Clean up asm/pgalloc.h include 3

ppc64-uninline-__pte_free_tlb.patch
  ppc64: uninline __pte_free_tlb()

es7000-subarch-update-2.patch
  es7000 subarch update

input-tsdev-fixes.patch
  tsdev.c fixes

fix-scancode-keycode-scancode-conversion-for-265.patch
  Fix scancode->keycode->scancode conversion

use-less-stack-in-ide_unregister.patch
  use less stack in ide_unregister

psmouse-fix-mouse-hotplugging.patch
  psmouse: fix mouse hotplugging

neomagic-driver-update.patch
  Neomagic driver update.

neomagic-driver-update-fix.patch
  neomagic-driver-update fix

kernel_ppc8xx_misc.patch
  ppc32: ppc8xx build fixes

remove-bootsect_helper-and-a-comment-fix-iii.patch
  Remove bootsect_helper and a comment fix

fealnx-mac-address-and-other-issues.patch
  Fealnx. Mac address and other issues

remove-some-unused-variables-in-s2io.patch
  remove some unused variables in s2io

new-version-of-early-cpu-detect.patch
  New version of early CPU detect

new-version-of-early-cpu-detect-fix.patch
  new-version-of-early-cpu-detect-fix

radeon-garbled-screen-fix.patch
  radeonfb: fix garbled screen

writepage-retval-warning.patch
  writepage-retval-warning

shrink_slab-handle-GFP_NOFS.patch
  shrink_slab: improved handling of GFP_NOFS allocations

shrink_slab-handle-GFP_NOFS-fix.patch
  shrink_slab-handle-GFP_NOFS-fix

fix-3c59xc-to-allow-3c905c-100bt-fd.patch
  fix 3c59x.c to allow 3c905c 100bT-FD

use-dos_extended_partition.patch
  partitioning cleanup: use DOS_EXTENDED_PARTITION

reiserfs-commit-default-fix.patch
  From: Bart Samwel <bart@samwel.tk>
  Subject: [PATCH] Reiserfs commit default fix

reiserfs-acl-mknod.patch
  reiserfs: acl device node initialization

reiserfs-xattrs-04.patch
  reiserfs: xattr support

reiserfs-acl-02.patch
  reiserfs: ACL support

reiserfs-trusted-02.patch
  reiserfs: support trusted xattrs

reiserfs-selinux-02.patch
  reiserfs: selinux support

reiserfs-xattr-locking-02.patch
  reiserfs: xattr locking fixes

reiserfs-quota.patch
  reiserfs: quota support

reiserfs-permission.patch
  reiserfs: xattr permission fix

reiserfs-warning.patch
  reiserfs: add device info to diagnostic messages

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

mptfusion-depends-on-scsi.patch
  mptfusion depends on scsi

mark-config_mac_serial-drivers-macintosh-macserialc-as-broken.patch
  Mark CONFIG_MAC_SERIAL (drivers/macintosh/macserial.c) as broken

radeon-fb-screen-corruption-fix.patch
  radeonfb display corruption fix

tridentfbc-warning-fix.patch
  video/tridentfb.c warning fix

hgafbc-warning-fix.patch
  video/hgafb.c warning fix

tdfxfbc-warning-fix.patch
  video/tdfxfb.c warning fix

imsttfbc-warning-fix.patch
  video/imsttfb.c. warning fix

fbdev-logo-handling-fix.patch
  fbdev: clean up logo handling

fbdev-redundant-prows-calculation-removal.patch
  fbdev: remove redundant p->vrows calculation

fbdev-remove-redundant-local.patch
  fbdev: remove redundant local

fbdev-access_align-default.patch
  fbdev: set a default access_align value

fix-null-ptr-dereference-in-pm2fb_probe-2.patch
  Fix NULL-ptr dereference in pm2fb_probe

virtual-fbdev-updates.patch
  Virtual fbdev updates

vesa-fbdev-update.patch
  Vesa Fbdev update

vesa-fbdev-update-fix.patch
  Vesa Fbdev update fix

sis-agp-updates.patch
  SIS AGP updates

new-asiliant-framebuffer-driver.patch
  New Asiliant framebuffer driver.

fbcon-and-unimap.patch
  Fix fbcon and unimap

videodev-handle-class_register-failure.patch
  videodev: handle class_register() failure

8139too-suspend-fix.patch
  8139too not running s3 suspend/resume pci fix

acpiphp_glue-oops-fix.patch
  acpiphp_glue.c oops fix

clear_backing_dev_congested.patch
  clear_baking_dev_congested

dpt_i2o.patch
  Fix dpt_i2o

find_user-locking.patch
  find_user-locking

improve-laptop-modes-block_dump-output.patch
  Improve laptop mode's block_dump output

com90xx_message.patch
  com90xx error message patch: check_region() gone

parport_doc_arg.patch
  Kill a warning while making pdfdocs.

kernel-api-docs.patch
  Kill some 'No description found...' warnings. (kernel-api.sgml)

allow-architectures-to-reenable-interrupts-on-contended-spinlocks.patch
  Allow architectures to reenable interrupts on contended spinlocks

allow-architectures-to-reenable-interrupts-on-contended-spinlocks-fix.patch
  allow-architectures-to-reenable-interrupts-on-contended-spinlocks-fix

only-print-tainted-message-once.patch
  Only Print Taint Message Once

ia64-cpuhotplug-core_kernel_init.patch
  oa64 cpu hotplug: core kernel initialisation

ia64-cpuhotplug-init_removal.patch
  ia64 cpu hotplug: init section fixes

ia64-cpuhotplug-sysfs_ia64.patch
  ia64 cpu hotplug: sysfs additions

ia64-cpuhotplug-irq_affinity_fix.patch
  ia64 cpu hotplug: IRQ affinity work

ia64-cpuhotplug-palinfo.patch
  ia64 cpu hotplug: /proc rework

blk_start_queue-use-kblockd.patch
  blk_start_queue() should use kblockd

module-ref-counting-for-vt-console-drivers.patch
  Module ref counting for vt console drivers

edd-follow-sysfs-convention-module_version-remove-dead-scsi-symlink.patch
  EDD: follow sysfs convention, MODULE_VERSION, remove dead SCSI symlink

cmpci-update.patch
  cmpci OSS driver update

i2o-subsystem-fixing-and-cleanup-for-26-i2o-config-cleanpatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-config-clean.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o-passthrupatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-passthru.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o_block-cleanuppatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o_block-cleanup.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o-64-bit-fixpatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-64-bit-fix.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o-makefile-cleanuppatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-makefile-cleanup.patch

dentry-and-inode-cache-hash-algorithm-performance-changes.patch
  dentry and inode cache hash algorithm performance changes.

fix-mtd-suspend-resume.patch
  From: Russell King <rmk@arm.linux.org.uk>
  Subject: [MTD] Fix MTD suspend/resume

remove-blk_queue_bounce-messages.patch
  remove blk_queue_bounce() printks

fix-deadlock-in-__create_workqueue-2.patch
  a

throttle-p4-thermal-warnings.patch
  throttle P4 thermal warnings

i82365c-warning-fix.patch
  pcmcia/i82365.c warning fix

allow-i386-to-reenable-interrupts-on-lock-contention.patch
  Allow i386 to reenable interrupts on lock contention

make-4k-stacks-permanent.patch
  make-4k-stacks-permanent

worker_thread-race-fix.patch
  worker_thread-race-fix

force-config_regparm-to-y.patch
  Force CONFIG_REGPARM to `y'

kernel-syscalls-retval-fix.patch
  a

remove-errno-refs.patch
  remove-errno-refs

ia64-remove-errno-refs.patch
  ia64-remove-errno-refs

warn-when-smp_call_function-is-called-with-interrupts-disabled.patch
  Warn when smp_call_function() is called with interrupts disabled

initio-ini-9x00u-uw-error-handling-in-26.patch
  Initio INI-9X00U/UW error handling

fixup-68360-module-refcounting.patch
  fixup 68360 module refcounting

missing-closing-n-in-printk.patch
  missing closing n in printk

intermezzo-stack-reduction.patch
  intermezzos stack usage reduction

lance-racal-interlan-fix.patch
  lance.c: fix for card with signature 0x52 0x49

gcc-340-fixes-for-266-rc3-x86_64-kernel.patch
  gcc-3.4.0 fixes for 2.6.6-rc3 x86_64 kernel

fix-warn_on-on-xfs-module-unload.patch
  fix WARN_ON on XFS module unload

ppc64-use-generic-ipc-syscall-translation.patch
  ppc64: use generic ipc syscall translation

proc-sys-kernel-vermagic.patch
  add /proc/sys/kernel/vermagic

ramdisk-size-warning-fix.patch
  fix ramdisk size assembler warning

cyclades-cleanups.patch
  cyclades cleanups

cyclades-cleanups-cleanups.patch
  cyclades cleanups cleanups

nforce-disconnect-fix.patch
  nforce2 C1 halt disconnect fix

delete-posix-conformance-testing-by-unifix-message.patch
  delete "POSIX conformance testing by UNIFIX" message

jiffies-to-clockt-fix_a1.patch
  jiffies-to-clockt fix

readahead-private.patch
  hack2

static-define_per_cpu-vs-modules-2.patch
  static DEFINE_PER_CPU vs. modules

introduce-asm--8253pith.patch
  CLOCK_TICK_RATE: introduce asm-*/8253pit.h, #define PIT_TICK_RATE constant.

use-pit_tick_rate-in-spkrc.patch
  CLOCK_TICK_RATE: use PIT_TICK_RATE in *spkr.c

use-clock_tick_rate.patch
  CLOCK_TICK_RATE: use CLOCK_TICK_RATE

netpoll-attributions.patch
  netpoll attributions

265-es7000-subarch-update-for-generic-arch.patch
  es7000 subarch update for generic arch

new-i2c-video-decoder-calls.patch
  new i2c video decoder calls

new-i2c-video-decoder-calls-saa7111.patch
  new i2c video decoder calls: saa7111 driver

get_thread_area-macros.patch
  get_thread_area macro fixes

update-documentation-mdtxt.patch
  update Documentation/md.txt

invalid-notify_changesymlink-in-nfsd.patch
  Invalid notify_change(symlink, [ATTR_MODE]) in nfsd

bfs-filesystem-read-past-the-end-of-dir.patch
  bfs filesystem read past the end of dir

simplify-mqueue_inode_info-messages-allocation.patch
  simplify mqueue_inode_info->messages allocation

filtered-wakeups-core.patch
  filtered wakeups: core

filtered-buffer_head-wakeups.patch
  filtered buffer_head wakeups

filtered-buffer_head-wakeups-tweaks.patch
  filtered-buffer_head-wakeups-tweaks

wake-one-pg_locked-bh_lock-semantics.patch
  wake-one PG_locked/BH_Lock semantics

wake-one-pg_locked-bh_lock-semantics-tweaks.patch
  wake-one-pg_locked-bh_lock-semantics-tweaks


