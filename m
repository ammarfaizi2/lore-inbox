Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264314AbUDUIr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbUDUIr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 04:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUDUIr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 04:47:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:50853 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264314AbUDUIqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 04:46:04 -0400
Date: Wed, 21 Apr 2004 01:45:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc2-mm1
Message-Id: <20040421014544.37942eb4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm1/

- Several framebuffer driver fixes.  Please test.

- Input driver fixes, cleanups, features.

- Dropped the signal race fixes.  See if we can find a better way to fix
  this.




Changes since 2.6.6-rc1-mm1:


 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-drm.patch
 bk-input.patch
 bk-netdev.patch

 External trees

-ppc64-rtas-build-fix.patch
-idr-extra-features.patch
-fix-load_elf_binary-error-path-on-unshare_files-error.patch
-cpufreq_userspace-warning.patch
-pc300_drv-warnings.patch
-increase-number-of-dynamic-inodes-in-procfs-265.patch
-increase-number-of-dynamic-inodes-in-procfs-265-idr-init.patch
-direct-IO-retval-fix.patch
-direct-io-retval-fix-2.patch
-fix-default-value-for-commit-interval-for-older-reiserfs-filesystems.patch
-kill-off-hugepage_vma.patch
-h8300-stack-bounds-checking.patch
-m68k-stack-bounds-checking.patch
-m68knommu-stack-bounds-checking.patch
-ppc32-stack-bounds-checking.patch
-sparc32-stack-bounds-checking.patch
-3c509-oops-fix.patch
-nfs-tokens-initdata.patch
-warn-if-module_param-and-module_parm-mixed.patch
-ide-cleanups-1.patch
-ide-cleanups-2.patch
-ide-cleanups-3.patch
-lec-warning-fix.patch

 Merged

+create_singlethread_workqueue-fix.patch

 Fix create_singlethread_workqueue.patch

+use-workqueue-for-call_usermodehelper-fix.patch

 Fix use-workqueue-for-call_usermodehelper.patch

+fix-nfsroot-option-parsing.patch

 Sync up the kernel's boot-time NFS option parser with mount(8)'s parser.

-kgdb-ga-recent-gcc-fix.patch
-kgdboe-configuration-logic-fix.patch
-kgdboe-configuration-logic-fix-fix.patch
-kgdboe-non-ia32-build-fix.patch
-kgdb-warning-fixes.patch
-kgdb-x86_64-warning-fixes.patch
-wchan-use-ELF-sections-kgdb-fix.patch
-kgdb-THREAD_SIZE-fixes.patch

 Folded into other kgdb patches

+i_shared_lock.patch

 Convert i_shared_sem back into a spinlock

-sched-fixes.patch

 This was wrong.

+ppc64-smt-sched-stuff.patch

 Implement SMT support within sched-domains for ppc64

-signal-race-fix.patch
-signal-race-fix-ia64.patch
-signal-race-fix-s390.patch
-signal-race-fix-x86_64.patch
-signal-race-fixes-ppc.patch

 Drop these, pending a better way of solving this race.

+numa-api-core-i_shared_sem.patch

 Update the NUMA API code for the i_shared_sem conversion (this is wrong - it
 causes sleeping-inside-spinlocks).

+ext3-reservation-regression-fix.patch

 Fix an ext3 block allocator regression which came in with the reservation
 patches.

+4-autofs4-260-expire-20040405-fix.patch

 Fix 4-autofs4-2.6.0-expire-20040405.patch

-scale-rwsem-take-2.patch

 Dropped - there's controversy over this.

+lockfs-reiserfs-fix.patch

 Fix up reiserfs for the lockfs fixes.

+radeon-fb-screen-corruption-fix.patch

 Radeon driver fix

+es7000-subarch-update-2.patch

 ES7000 fix

+tridentfbc-warning-fix.patch
+hgafbc-warning-fix.patch
+imsttfbc-warning-fix.patch

 fbdev fixes

+dquot-unneeded-test.patch

 Remove unneeded test for a null superblock pointer

+i4l-compat-ioctls.patch

 Add ISDN compat ioctls

+selinux-change-context_to_sid-handling-for-no-policy-case.patch
+selinux-add-runtime-disable.patch
+selinux-remove-hardcoded-policy-assumption-from-get_user_sids-logic.patch

 SELinux fixes

+fbdev-logo-handling-fix.patch
+fbdev-redundant-prows-calculation-removal.patch
+fbdev-remove-redundant-local.patch
+fbdev-access_align-default.patch

 More fbdev fixes

+kbuild-improved-external-module-support.patch

 Fix up the building of out-of-tree kernel modules

+input-tsdev-fixes.patch

 Input driver fixes

+fix-scancode-keycode-scancode-conversion-for-265.patch

 Keyboard scancode fixes

+i810_dma-range-check.patch

 rangecheck an incoming argument.

+fb_ioctl-usercopy-fix.patch

 usercopy fix

+use-less-stack-in-ide_unregister.patch

 Stack use reduction

+writeback-livelock-fix.patch

 Avoid possible pdflush livelock

+string_h-needs-compiler_h.patch

 Force inlining of string functions.

+new-set-of-input-patches-synaptics-cleanup.patch
+new-set-of-input-patches-synaptics-middle-button-support.patch
+new-set-of-input-patches-dont-change-max-proto.patch
+new-set-of-input-patches-lkkbd-whitespace.patch
+new-set-of-input-patches-lkkbd-simplify-checks.patch
+new-set-of-input-patches-atkbd-soften-accusation.patch
+new-set-of-input-patches-atkbd-trailing-whitespace.patch
+new-set-of-input-patches-atkbd-use-bitfields.patch
+new-set-of-input-patches-atkbd-timeout-complaints.patch
+new-set-of-input-patches-psmouse-rescan-on-hotplug.patch
+new-set-of-input-patches-psmouse-reconnect-after-error.patch
+new-set-of-input-patches-psmouse-add-protocol_handler.patch
+new-set-of-input-patches-psmouse-sliced-commands.patch
+new-set-of-input-patches-atkbd-reconnect-probe.patch
+new-set-of-input-patches-allow-disabling-psaux.patch

 More input driver fixes and enhancements

+i386-hugetlb-tlb-correction.patch

 Fix i386 hugepage pte handling

+loop_set_fd-sendfile-check-fix.patch

 Fix a sanity check in the loop driver




All 222 patches:


create_singlethread_workqueue.patch
  reate_singlethread_workqueue()

create_singlethread_workqueue-fix.patch
  create_singlethread_workqueue fix

use-workqueue-for-call_usermodehelper.patch
  Use workqueue for call_usermodehelper

use-workqueue-for-call_usermodehelper-fix.patch
  use-workqueue-for-call_usermodehelper fix

fix-nfsroot-option-parsing.patch
  Fix nfsroot option handling

mc.patch
  Add -mcN to EXTRAVERSION

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-arm.patch

bk-cifs.patch

bk-cpufreq.patch

bk-drm.patch

bk-input.patch

bk-netdev.patch

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

rmap-10-add-anonmm-rmap.patch
  rmap 10 add anonmm rmap

rmap-11-mremap-moves.patch
  rmap 11 mremap moves

rmap-12-pgtable-remove-rmap.patch
  rmap 12 pgtable remove rmap

rmap-13-include-asm-deletions.patch
  rmap 13 include/asm deletions

i_shared_lock.patch
  Convert i_shared_sem back to a spinlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

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

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

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
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

sched-find-busiest-fix.patch
  sched-find-busiest-fix

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask
  p4-clockmod sibling_map fix
  p4-clockmod: handle more than two siblings

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT
  sched: Fix CONFIG_SMT oops on UP
  sched: fix SMT + NUMA bug
  Change arch_init_sched_domains to use cpu_online_map
  Fix build with NR_CPUS > BITS_PER_LONG

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-domain-debugging.patch
  sched_domain debugging

sched-domain-balancing-improvements.patch
  scheduler domain balancing improvements

sched-group-power.patch
  sched-group-power
  sched-group-power warning fixes

sched-domains-use-cpu_possible_map.patch
  sched_domains: use cpu_possible_map

sched-smt-nice-handling.patch
  sched: SMT niceness handling

sched-local-load.patch
  sched: add local load metrics

process-migration-speedup.patch
  Reduce TLB flushing during process migration

sched-trivial.patch
  sched: trivial fixes, cleanups

sched-misc-fixes.patch
  sched: misc fixes

sched-wakebalance-fixes.patch
  sched: wakeup balancing fixes

sched-imbalance-fix.patch
  sched: fix imbalance calculations

sched-altix-tune1.patch
  sched: altix tuning

sched-fix-activelb.patch
  sched: oops fix

ppc64-sched-domain-support.patch
  ppc64: sched-domain support

sched-domain-setup-lock.patch
  sched: fix setup races

ppc64-sched_domains-fix.patch
  ppc64-sched_domains-fix

sched-domain-setup-lock-ppc64-fix.patch

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

ppc64-smt-sched-stuff.patch
  ppc64: SMT scheduler support

schedstats.patch
  sched: scheduler statistics

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

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

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

pcmcia-netdev-ordering-fixes.patch
  PCMCIA netdevice ordering issues

3ware-update.patch
  3ware driver update

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

jgarzik-warnings.patch

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

warn-on-mdelay-in-irq-handlers.patch
  Warn on mdelay() in irq handlers

stack-reductions-nfsread.patch
  stack reductions: nfs read

speed-up-sata.patch
  speed up SATA

advansys-fix.patch
  advansys check_region() fix

aic7xxx-unload-fix.patch
  aic7xxx: fix oops whe hardware is not present

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

nfs-O_DIRECT-fixes.patch
  NFS: O_DIRECT fixes

nfs-direct-warning-fix.patch
  nfs/direct.c warning fix

aic7xxx-swsusp-support.patch
  support swsusp for aic7xxx
  aic79xx_osm.c build fix

xfs-laptop-mode.patch
  Laptop mode support for XFS

xfs-laptop-mode-syncd-synchronization.patch
  Synchronize XFS sync daemon with laptop mode syncs.

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

cciss-logical-device-queues.patch
  cciss: per logical device queues

numa-api-x86_64.patch
  numa api: -64 support

numa-api-bitmap-fix.patch
  numa api: Bitmap bugfix

numa-api-i386.patch
  numa api: Add i386 support

numa-api-ia64.patch
  numa api: Add IA64 support

numa-api-core.patch
  numa api: Core NUMA API code

numa-api-core-i_shared_sem.patch
  numa-api-core-i_shared_sem

mpol-in-copy_vma.patch
  mpol in copy_vma

numa-api-core-slab-panic.patch
  numa-api-core-slab-panic

numa-api-core-tweaks.patch
  numa-api-core-tweaks

numa-api-fixes.patch
  Some fixes for NUMA API

numa-api-statistics-2.patch
  Re-add NUMA API statistics

numa-api-core-bitmap_clear-fixes.patch
  numa-api-core bitmap_clear fixes

numa-api-vma-policy-hooks.patch
  numa api: Add VMA hooks for policy

numa-api-vma-policy-hooks-fix.patch
  numa-api-vma-policy-hooks fix

numa-api-shared-memory-support.patch
  numa api: Add shared memory support

numa-api-shared-memory-support-tweaks.patch
  numa-api-shared-memory-support-tweaks

numa-api-statistics.patch
  numa api: Add statistics

numa-api-anon-memory-policy.patch
  numa api: Add policy support to anonymous  memory

sk98lin-buggy-vpd-workaround.patch
  net/sk98lin: correct buggy VPD in ASUS MB
  skvpd-build-fix

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

compute-creds-race-fix.patch
  compute_creds race

compute-creds-race-fix-fix.patch
  compute-creds-race-fix-fix

compute-creds-race-fix-fix-fix.patch
  fix must_not_trace_exec() even more

rndis-fix.patch
  usb/gadget/rndis.c fix

fix-acer-travelmate-360-interrupt-routing.patch
  fix Acer TravelMate 360 interrupt routing

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation

ext3-reservation-regression-fix.patch
  ext3 reservations: fix performance regression

ext3_rsv_mount.patch
  ext3 block reservation patch set -- mount and ioctl feature

ext3_rsv_dw.patch
  ext3 block reservation patch set -- dynamically increase reservation window

ext3-reservation-default-on.patch
  ext3 reservation: default to on

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

lindent-rwsem.patch
  cleanup lib/rwsem.c lib/rwsem-spinlock.c

de-racify-rwsem-take-2.patch
  de-racify rwsem take 2

ext3-data-leak-fix.patch
  ext3 avoid writing kernel memory to disk

as-increase-batch-expiry.patch
  AS: increase batch expiry intervals

populate-rootfs-later.patch
  Call populate_rootfs later in boot

remove-amd7saucy_tco.patch
  remove amd7xx_tco

consolidate-sys32_readv-and-sys32_writev.patch
  Consolidate sys32_readv and sys32_writev

consolidate-do_execve32.patch
  Consolidate do_execve32

consolidate-sys32_select.patch
  Consolidate sys32_select

consolidate-sys32_nfsservctl.patch
  Consolidate sys32_nfsservctl

ehci-oops-fix.patch
  oops when loading ehci_hcd

lockfs-vfs-bits.patch
  lockfs - vfs bits

lockfs-reiserfs-fix.patch
  lockfs: reiserfs fix

lockfs-xfs-bits.patch
  lockfs - xfs bits

lockfs-dm-bits.patch
  lockfs - dm bits

lockfs-dm-bits-2.patch
  lockfs - dm bits

intel8x0-resume-fix.patch
  intel8x0 suspend/resume fix

clean-up-asm-pgalloch-include.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-2.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-3.patch
  Clean up asm/pgalloc.h include 3

ppc64-uninline-__pte_free_tlb.patch
  ppc64: uninline __pte_free_tlb()

radeon-fb-screen-corruption-fix.patch
  radeonfb display corruption fix

es7000-subarch-update-2.patch
  es7000 subarch update

tridentfbc-warning-fix.patch
  video/tridentfb.c warning fix

hgafbc-warning-fix.patch
  video/hgafb.c warning fix

imsttfbc-warning-fix.patch
  video/imsttfb.c. warning fix

dquot-unneeded-test.patch
  dquot: remove unneeded test

i4l-compat-ioctls.patch
  i4l: add compat ioctl's for CAPI

selinux-change-context_to_sid-handling-for-no-policy-case.patch
  selinux: change context_to_sid handling for no-policy case

selinux-add-runtime-disable.patch
  selinux: add runtime disable

selinux-remove-hardcoded-policy-assumption-from-get_user_sids-logic.patch
  selinux: remove hardcoded policy assumption from get_user_sids() logic

fbdev-logo-handling-fix.patch
  fbdev: clean up logo handling

fbdev-redundant-prows-calculation-removal.patch
  fbdev: remove redundant p->vrows calculation

fbdev-remove-redundant-local.patch
  fbdev: remove redundant local

fbdev-access_align-default.patch
  fbdev: set a default access_align value

kbuild-improved-external-module-support.patch
  kbuild: Improved external module support

input-tsdev-fixes.patch
  tsdev.c fixes

fix-scancode-keycode-scancode-conversion-for-265.patch
  Fix scancode->keycode->scancode conversion

i810_dma-range-check.patch
  i810_dma range check

fb_ioctl-usercopy-fix.patch
  fb_ioctl() usercopy fix

use-less-stack-in-ide_unregister.patch
  use less stack in ide_unregister

writeback-livelock-fix.patch
  writeback livelock fix

string_h-needs-compiler_h.patch
  string.h needs compiler.h

new-set-of-input-patches-synaptics-cleanup.patch
  input: synaptics cleanup

new-set-of-input-patches-synaptics-middle-button-support.patch
  input: synaptics middle button support

new-set-of-input-patches-dont-change-max-proto.patch
  input: dont change max proto

new-set-of-input-patches-lkkbd-whitespace.patch
  input: lkkbd whitespace

new-set-of-input-patches-lkkbd-simplify-checks.patch
  input: lkkbd simplify checks

new-set-of-input-patches-atkbd-soften-accusation.patch
  input: atkbd soften accusation

new-set-of-input-patches-atkbd-trailing-whitespace.patch
  input: atkbd trailing whitespace

new-set-of-input-patches-atkbd-use-bitfields.patch
  input: atkbd - use bitfields

new-set-of-input-patches-atkbd-timeout-complaints.patch
  input: atkbd timeout complaints

new-set-of-input-patches-psmouse-rescan-on-hotplug.patch
  input: psmouse rescan on hotplug

new-set-of-input-patches-psmouse-reconnect-after-error.patch
  input: psmouse reconnect after error

new-set-of-input-patches-psmouse-add-protocol_handler.patch
  input: psmouse add protocol_handler

new-set-of-input-patches-psmouse-sliced-commands.patch
  input: psmouse sliced commands

new-set-of-input-patches-atkbd-reconnect-probe.patch
  input: atkbd reconnect probe

new-set-of-input-patches-allow-disabling-psaux.patch
  input: allow disabling psaux

i386-hugetlb-tlb-correction.patch
  i386 hugetlb tlb correction

loop_set_fd-sendfile-check-fix.patch
  loop_set_fd() sendfile check fix



