Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUDOGE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 02:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUDOGE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 02:04:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:8326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263824AbUDOGEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 02:04:30 -0400
Date: Wed, 14 Apr 2004 23:04:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mm6
Message-Id: <20040414230413.4f5aa917.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm6/

- Added the first cut of the ext3 "reservation" code - it improves layout of
  ext3 files, especially on SMP hardware.

- Various small fixes and cleanups




Changes since 2.6.5-mm5:


 bk-alsa.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-netdev.patch
 bk-pci.patch

 External trees

-r8169-warning-fix.patch
-netpoll-early-arp-handling.patch
-netpoll-transmit-busy-bugfix.patch
-stack-reductions-nfsroot.patch
-x86_64-probe_roms-c89.patch
-yenta-TI-irq-routing-fix.patch
-pnp-updates.patch
-reslabify-pgds-and-pmds-2.patch
-sk_mca-multicast-fix.patch
-get_files_struct.patch
-shrink-hash-sizes-on-small-machines-take-2.patch
-binfmt_misc-remove-attribute_unused.patch
-jbd-copyout-fix.patch
-ext3-add_nondir-d_instantiate-fix.patch
-vga16fb-mapping-fix.patch
-rwsem-scale.patch
-uninline-put_page.patch
-uninline-seqfns.patch
-uninline-copy_user.patch
-slab-panic.patch
-tmscsim-ulong-io_port.patch
-change-addr-type-to-reduce-casting-in-coldfire-serial-driver.patch
-fixes-to-the-coldfire-serial-driver.patch
-fixes-to-the-68328-dragonball-serial-driver.patch
-wrong-return-value-in-hfs_fill_super.patch
-mips-build-fix.patch
-mips-statfs-fix.patch
-trivial-pcmcia-rsrc_mgrc-warning-fix.patch
-compile-fix-for-macserial.patch

 Merged

+fix-mq_notify-with-sigev_none-notification.patch
+mq_open-and-close_on_exec.patch
+posix-messages-queues-for-s390.patch
+fix-mq-32-bit-compatibility.patch
+add-mqueue-support-to-x86-64.patch

 POSIX message queue work

+radix-tree-comment-fix.patch

 Fix some comments

+rmap-7-object-based-rmap.patch
+rmap-8-unmap-nonlinear.patch

 "object-based rmap" for file-backed mappings

+kill-submit_bhbio-return-value.patch

 Cleanup

+pci-msi-kconfig-consolidation.patch

 Kconfig consolidation

+remove-buffer_error.patch
-extra-buffer-diags.patch

 Remove buffer_error()

+light-weight-auditing-framework-for-s390.patch

 s390 fixes for syscall auditing

+ppc64-fix-possible-duplicate-mmu-hash-entries.patch

 ppc64 MM fix

-ext3-journalled-quotas-export.patch

 Folded into ext3-journalled-quotas.patch

+sched-wake_up-speedup.patch

 schedstats.patch

-ipmi-socket-interface.patch

 We're not proceeding with this.

-devinet-ctl_table-fix.patch

 This didn't fix anything.

-vmscan-less-sleepiness.patch

 This wasn't obviously beneficial

+mpol-in-copy_vma.patch

 NUMA API fix

+numa-api-core-slab-panic.patch

 Use SLAB_PANIC in the NUMA API code

-pty-allocation-first-fit.patch

 Broken

+ext3_rsv_cleanup.patch
+ext3_rsv_base.patch
+ext3_rsv_mount.patch
+ext3_rsv_dw.patch
+ext3-reservation-default-on.patch

 Improved ext3 block allocation

+sched-in_sched_functions.patch

 Clean up the scheduler section code

+sysfs-d_fsdata-race-fix-2.patch

 sysfs race fix

+umount-after-bad-chdir.patch

 Fix umount problem introduced in the autofs patches

+print-warning-for-common-symbols-in-modules.patch

 module sanity check.

+lindent-rwsem.patch

 Feed the rwsem code through Lindent

+de-racify-rwsem-take-2.patch

 Fix rare race in the rwsem code

+scale-rwsem-take-2.patch

 Improved rwsem scalability.

+increase-number-of-dynamic-inodes-in-procfs-265.patch
+increase-number-of-dynamic-inodes-in-procfs-265-idr-init.patch

 Permit more inodes in /proc

+set_anon_super-locking-fix.patch

 Locking fix

+ext3-data-leak-fix.patch

 Avoid writing uninitialised kernel memory to the ext3 journal






All 207 patches


linus.patch

fix-mq_notify-with-sigev_none-notification.patch
  Fix mq_notify with SIGEV_NONE notification

radix-tree-comment-fix.patch
  radix-tree comment fix

mq_open-and-close_on_exec.patch
  mq_open() and close_on_exec

rmap-4-flush_dcache-revisited.patch
  rmap 4 flush_dcache revisited

rmap-5-swap_unplug-page.patch
  rmap 6 swap_unplug page

rmap-6-nonlinear-truncation.patch
  rmap 6 nonlinear truncation

rmap-7-object-based-rmap.patch
  rmap 7 object-based rmap

rmap-8-unmap-nonlinear.patch
  rmap 8 unmap nonlinear

ext3-journalled-quotas.patch
  ext3: journalled quotas

kstrdup-and-friends.patch
  add string replication functions

call_usermodehelper_async.patch
  Add call_usermodehelper_async

call_usermodehelper_async-always.patch
  always use call_usermodehelper_async

slab-panic.patch
  slab: consolidate panic code

dm-fix-64-32-bit-ioctl-problems.patch
  dm: Fix 64/32 bit ioctl problems.

dm-check-the-uptodate-flag-in-sub-bios.patch
  dm: Check the uptodate flag in sub-bios to see if there was an error.

dm-handle-interrupts-within-suspend.patch
  dm: Handle interrupts within suspend.

dm-use-wake_up-rather-than-wake_up_interruptible.patch
  dm: Use wake_up() rather than wake_up_interruptible()

dm-log-an-error-if-the-target-has-unknown-target-type.patch
  dm: Log an error if the target has unknown target type, or zero length.

dm-correctly-align-the-dm_target_spec-structures.patch
  dm: Correctly align the dm_target_spec structures during retrieve_status().

dm-clarify-a-comment.patch
  dm: fix a comment

dm-retrieve_status-prevent-overrunning-the-ioctl-buffer.patch
  dm: avoid ioctl buffer overrun

dm-use-an-emit-macro.patch
  dm: Use an EMIT macro in the status function.

kNFSdv4-4-of-10-nfsd4_readdir-fixes.patch
  kNFSdv4: nfsd4_readdir fixes
  nfsd4_readdir build fix

kNFSdv4-5-of-10-Fix-bad-error-returm-from-svcauth_gss_accept.patch
  kNFSdv4: Fix bad error returm from svcauth_gss_accept

kNFSdv4-6-of-10-Keep-state-to-allow-replays-for-close-to-work.patch
  kNFSdv4: Keep state to allow replays for 'close' to work.
  Subject: Re: [PATCH] kNFSdv4 - 6 of 10 - Keep state to allow replays for 'close' to work.

kNFSdv4-7-of-10-Allow-locku-replays-aswell.patch
  kNFSdv4: Allow locku replays aswell

kNFSdv4-8-of-10-Improve-how-locking-copes-with-replays.patch
  kNFSdv4: Improve how locking copes with replays

kNFSdv4-9-of-10-Set-credentials-properly-when-puutrootfh-is-used.patch
  kNFSdv4: Set credentials properly when puutrootfh is used

kNFSdv4-10-of-10-Implement-server-side-reboot-recovery-mostly.patch
  kNFSdv4: Implement server-side reboot recovery (mostly)

kill-submit_bhbio-return-value.patch
  kill submit_{bh,bio} return value

pci-msi-kconfig-consolidation.patch
  PCI MSI Kconfig consolidation

remove-buffer_error.patch
  remove buffer_error()

add-mqueue-support-to-x86-64.patch
  Add mqueue support to x86-64

light-weight-auditing-framework-for-s390.patch
  light-weight auditing framework for s390.

posix-messages-queues-for-s390.patch
  posix messages queues for s390.

ppc64-fix-possible-duplicate-mmu-hash-entries.patch
  ppc64: Fix possible duplicate MMU hash entries

fix-mq-32-bit-compatibility.patch
  Fix mq 32-bit compatibility

mc.patch
  Add -mcN to EXTRAVERSION

bk-alsa.patch

bk-driver-core.patch

bk-drm.patch

bk-ieee1394.patch

bk-input.patch

bk-netdev.patch

bk-pci.patch

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

kgdb-ga-recent-gcc-fix.patch
  kgdb: fix for recent gcc

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-configuration-logic-fix.patch
  kgdboe: fix configuration of MAC address

kgdboe-configuration-logic-fix-fix.patch

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

kgdb-x86_64-warning-fixes.patch
  kgdb-x86_64-warning-fixes

wchan-use-ELF-sections-kgdb-fix.patch
  wchan-use-ELF-sections-kgdb-fix

kgdb-THREAD_SIZE-fixes.patch
  THREAD_SIZE fixes for kgdb

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

idr-extra-features.patch
  idr.c: extra features enhancements

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

jgarzik-warnings.patch

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

signal-race-fix.patch
  signal handling race fix

signal-race-fix-ia64.patch
  signal-race-fix: ia64

signal-race-fix-s390.patch
  signal-race fixes for s390

signal-race-fix-x86_64.patch
  signal-race-fixes: x86-64 support

signal-race-fixes-ppc.patch
  signal-race fixes for ppc32 and ppc64

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

aic7xxx-swsusp-support.patch
  support swsusp for aic7xxx

reiserfs-commit-default.patch
  Add "commit=0" to reiserfs

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

jbd-journal_dirty_metadata-locking-speedup.patch
  jbd: journal_dirty_metadata locking speedup

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

mpol-in-copy_vma.patch
  mpol in copy_vma

numa-api-core-slab-panic.patch
  numa-api-core-slab-panic

numa-api-core-tweaks.patch
  numa-api-core-tweaks

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

fix-load_elf_binary-error-path-on-unshare_files-error.patch
  fix load_elf_binary error path on unshare_files error

sctp-printk-warnings.patch
  sctp printk warnings

atm-warning-fixes.patch
  atm warning fixes

firestream-warnings.patch
  firestream warnings

cpufreq_userspace-warning.patch
  cpufreq_userspace warning

compute-creds-race-fix.patch
  compute_creds race

compute-creds-race-fix-fix.patch
  compute-creds-race-fix-fix

compute-creds-race-fix-fix-fix.patch
  fix must_not_trace_exec() even more

rndis-fix.patch
  usb/gadget/rndis.c fix

sir_dev-warnings.patch
  sir_dev.c warnings

donauboe-ptr-fix.patch
  donauboe.c 32-bit pointer fix

strip-warnings.patch
  drivers/net/wireless/strip.c warnings

pc300_drv-warnings.patch
  pc300_drv-warnings

strip-warnings-2.patch
  strip.c warnings

fix-acer-travelmate-360-interrupt-routing.patch
  fix Acer TravelMate 360 interrupt routing

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation

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

1-autofs4-2.6.4-cleanup-20040405.patch
  autofs: printk cleanups

2-autofs4-2.6.4-fill_super-20040405.patch

3-autofs4-2.6.0-bkl-20040405.patch
  autofs: locking rework

4-autofs4-2.6.0-expire-20040405.patch
  autofs: expiry refcount fixes

5-autofs4-2.6.0-readdir-20040405.patch
  autofs: readdir fixes

umount-after-bad-chdir.patch
  fix umount after bad chdir

6-autofs4-2.6.0-may_umount-20040405.patch
  autofs: add ioctl to query unmountability

7-autofs4-2.6.0-extra-20040405.patch
  autofs: readdir futureproofing

print-warning-for-common-symbols-in-modules.patch
  Print warning for common symbols in modules

lindent-rwsem.patch
  cleanup lib/rwsem.c lib/rwsem-spinlock.c

de-racify-rwsem-take-2.patch
  de-racify rwsem take 2

scale-rwsem-take-2.patch
  scale rwsem take 2

increase-number-of-dynamic-inodes-in-procfs-265.patch
  Increase number of dynamic inodes in procfs

increase-number-of-dynamic-inodes-in-procfs-265-idr-init.patch
  increase-number-of-dynamic-inodes-in-procfs-265-idr-init

set_anon_super-locking-fix.patch
  set_anon_super locking fix

ext3-data-leak-fix.patch
  ext3 avoid writing kernel memory to disk



