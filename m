Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbUJ0EkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbUJ0EkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUJ0EkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:40:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:20108 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261623AbUJ0Ed6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:33:58 -0400
Date: Tue, 26 Oct 2004 21:31:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm1
Message-Id: <20041026213156.682f35ca.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm1/


- Nothing really major here - just lots of minor things spread all over the
  place.

- I actually managed to get most of the "external BK trees" included.  A lot
  of them have been pretty flakey lately (hint).

- This kernel is probably pretty crappy - there is a _lot_ of stuff
  happening and the quality of the patches which I am receiving seems to be
  gradually dropping off.  



Changes since 2.6.9-mm1:

 linus.patch
 bk-acpi.patch
 bk-arm.patch
 bk-cifs.patch
 bk-driver-core.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ia64.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-jfs.patch
 bk-kbuild.patch
 bk-libata.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-pcmcia.patch
 bk-pnp.patch
 bk-scsi.patch
 bk-serial.patch

 External trees

-revert-sys_setaltroot.patch
-revert-ppc-fix-build-with-o=output_dir.patch
-mem-remap_page_range-fix.patch
-pa-risc-io_remap_page_range-fix.patch
-prevent-partial-acpi-setup-when-using-acpi=off.patch
-nm256-module_parm_array-fix.patch
-psmouse-build-fix.patch
-atkbd-warning-fix.patch
-e1000-module_param-fix.patch
-ne2k-pci-pci-build-fix.patch
-r8169-module_param-fix.patch
-mm-help-zone-padding.patch
-accept-should-return-enfile-if-it-runs-out-of-inodes.patch
-checkstack-add-x86_64-arch-support.patch
-fix-send_sigurg-mediation.patch
-lsm-remove-net-related-includes-from-securityh.patch
-lsm-rename-security_scaffolding_startup-to-security_init.patch
-lsm-rename-security_scaffolding_startup-to-security_init-fix.patch
-lsm-reduce-noise-during-security_register.patch
-lsm-lindent-security-securityc.patch
-ppc32-fix-building-for-motorola-sandpoint-with-o=.patch
-ppc-disable-irq-probe-on-ppc.patch
-ppc-fix-build-of-irqc-with-config_tau_int.patch
-ppc64-dont-build-virtual-io-drivers-for-powermac.patch
-ppc64-trivial-sparse-cleanups.patch
-ppc64-xmon-sparse-cleanups.patch
-ppc64-provide-notifier-list-for-eeh-slot-isolations.patch
-ppc64-remove-__ioremap_explicit-error-message.patch
-ppc64-fix-boot-on-some-non-lpar-pseries.patch
-ppc64-fix-typo-in-zimage-boot-wrapper.patch
-ppc64-update-g5-thermal-control-driver.patch
-acpi-thermal-fix-confusing-define.patch
-power-diskc-small-fixups.patch
-sched-small-load-balance-fix.patch
-sched-improved-load_balance-tolerance-for-pinned-tasks.patch
-schedstat-fix-schedule-statistics.patch
-md-add-interface-for-userspace-monitoring-of-events.patch
-md-remove-md_flush_all.patch
-md-make-retry_list-non-global-in-raid1-and-multipath.patch
-md-rationalise-issue_flush-function-in-md-personalities.patch
-md-rationalise-unplug-functions-in-md.patch
-md-make-sure-md-always-uses-rdev_dec_pending-properly.patch
-md-fix-two-little-bugs-in-raid10.patch
-md-modify-locking-when-accessing-subdevices-in-md.patch
-md-make-read-retry-use-a-new-bio-in-raid1-and-raid10.patch
-md-discard-calc_sb_csum_common-in-favour-of-csum_fold.patch
-md-dont-hold-lock-on-md-devices-while-waiting-for-them-to-finish-resync.patch
-md-fix-typos-in-md-and-raid10.patch
-md-fixes-to-make-version-1-superblocks-work-in-md-driver.patch
-avoid-warning-on-conntrack_stat_inc-in-death_by_timeout.patch
-neigh_stat-preempt-fix.patch
-avoid-problems-with-kobject_set_name-and-name-with-%.patch
-megaraid-random-loss-of-luns.patch
-acpi-better-encapsulate-eisa_set_level_irq.patch
-deinline-large-function-in-blowfishc.patch
-small-sha256-cleanup.patch
-small-sha512-cleanup.patch
-reduce-sha512_transform-stack-usage-speedup.patch
-aes-586-asm-formatting-changes.patch
-aes-586-asm-small-optimizations.patch
-add-new-sysfs-attribute-carrier-for-net-devices.patch
-drivers-atm-ambassador.c-do_pci_device-printk-warning-fix.patch
-kobject_uevent-warning-fix.patch
-kobject_hotplug-no-hotplug_ops.patch
-remove-cpu_run_sbin_hotplug.patch
-ds_ioctl-usercopy-check.patch
-figure-out-who-is-inserting-bogus-modules.patch
-vmscan-total_scanned-fix.patch
-revert-vm-no-wild-kswapd.patch
-balance_pgdat-cleanup.patch
-no-wild-kswapd-2.patch
-no-wild-kswapd-kswapd-continue.patch
-aic7xxx-remove-warnings.patch
-ext2-discard-preallocation-in-last-iput.patch
-add-simple_alloc_dentry-to-libfs.patch
-weak-symbols-in-modules-and-versioned-symbols.patch
-cpiac-rmmod-deadlock-fix.patch
-change-pagevec-counters-back-to-unsigned-long-and-cacheline-align.patch
-solaris-ufs-fix.patch
-1-1-device-mapper-dm-crypt-tidy-ups.patch
-1-2-device-mapper-dm-crypt-generator-extension.patch
-2-2-device-mapper-dm-crypt-new-iv-mode-essiv.patch
-1-2-device-mapper-trivial-stray-semi-colon.patch
-2-2-device-mapper-trivial-duplicate-kfree-in-error-path.patch
-add-appletalk-32bit-ioctl-emulation.patch
-update-credits-entry-of-werner-almesberger.patch
-fbdev-reduce-pixmap-memory-allocation-size.patch
-fbdev-remove-inter_module_get-put-from-i810fb.patch
-fbdev-various-mach64-changes.patch
-fbdev-various-mach64-changes-sparc64-fix.patch
-fbdev-clean-up-of-fbcon-fbdev-cursor-interface.patch
-fbdev-clean-up-softcursor-implementation.patch
-fbdev-clean-up-i810fb-cursor-implementation.patch
-fbdev-cleanup-rivafb-cursor-implementation.patch
-fbdev-clean-up-mach64-cursor-implementation.patch
-irda-fix-lmp_lsap_inuse.patch
-irda-fix-nsc-ircc-dongle_id-input.patch
-irda-irnet-char-dev-alias.patch
-irda-ias-safety-comments.patch
-irda-adaptive-discovery-query-timer.patch
-irda-ircomm-ias-object-fix.patch
-irda-via-ircc-driver-speed-fixes.patch
-irda-debug-module-param.patch
-irda-stir-driver-usb-reset-fix.patch
-irda-stir-driver-suspend-fix.patch
-irda-stir-netdev-and-messages-cleanups.patch
-acct-report-single-record-for-multithreaded-process.patch
-fix-preempt_active-definition.patch
-builtin-module-parameters-in-sysfs-too.patch
-module_parm-must-die-make-it-warn-first.patch
-fix-for-module_parm-obsolete.patch
-Remove-MODULE_PARM-from-i386-defconfig.patch
-remove-module_parm-from-arch-i386.patch
-fix-bad-segment-coalescing-in-blk_recalc_rq_segments.patch
-__init-dependencies-ignore-__param.patch
-add-dac-check-for-setxattrsecurityselinux.patch
-fix-compile-of-drivers-i2c-busses-i2c-s3c2410c.patch
-remove-inclusion-of-linux-irqh-from-pci-quirksc.patch
-move-quirk_intel_irqbalance.patch
-mmtimer-sparse-fixes.patch
-hfs-update-key-after-rename.patch
-hfs-relax-dirty-check.patch
-hfs-manage-correct-block-count.patch
-hfs-read-correct-dir-time.patch
-hfs-write-back-resource-info-directly.patch
-hfs-export-type-creator-via-xattr.patch
-posix-layer-clock-driver-api-fix.patch
-fix-pxa270-compile-errors-missing-include.patch
-vm-unreclaimable-debug.patch
-use-generic_file_open-in-udf.patch
-fix-suspend-resume-support-in-via-rhine2.patch
-idr_remove-safety.patch
-serial-send_break-duration-fix.patch
-make-__sigqueue_alloc-a-general-helper.patch
-i-o-space-write-barrier.patch
-boot-parameters-quoting-of-environment-variables-revisited.patch

 Merged

+make-sysrq-f-call-oom_kill.patch

 sysrq-f causes an oom-kill triggering

+netfilter_debug-is-buggy.patch

 Disable CONFIG_NETFILTER_DEBUG (this can probably be dropped now)

+move-key_init-to-security_initcall.patch

 key subsystem fix

+shmem-numa-policy-spinlock.patch

 Replace a semaphore with a spinlock

+statm-__vm_stat_accounting.patch
+statm-shared-=-rss-anon_rss.patch
+statm-fix-negative-data.patch

 Various process accounting fixes

+tmpfs-truncate-latency.patch

 Reduce scheduling latency when removing tmpfs files

+omit-commitavail.patch

 /proc/meminfo fix

+anon-cris-align-address_space.patch

 CRIS architecture pageframe alignment fix

+use-mmiowb-in-tg3_poll.patch
+x25-stop-x25_destroy_socket-timer-looping.patch
+ethertap-debug-no-newline.patch
+x25-stop-proc-net-x25-route-infinitely.patch
+x25-dont-log-unknown-frame-type-when.patch
+aes-allow-modular-build.patch
+avoid-warning-on-conntrack_stat_inc-in-destroy_conntrack.patch

 Various networking fixes

+selinux-fix-netif-bugs-and-simplify.patch
+selinux-fix-sidtab-locking-bug.patch

 SELinux updates

+ppc64-iseries-console-cleanup-after-tty_write-user-copies-removal.patch
+ppc64-cpu-hotplug-notifier-for-numa.patch
+add-pci_get_legacy_ide_irq.patch
+ppc32-disable-broken-l2-cache-on-all-440gx-revs.patch

 ppc32/64 updates

+sh-do_signal-update-for-generic-changes.patch
+sh-compile-fixes.patch
+sh-syscall-updates.patch

 SuperH update

+hpet-reenabling-after-suspend-resume.patch
+optimize-stack-pointer-access-reduce-register-usage.patch
+skip-sync_arb_ids-on-p4-xeon.patch

 x86 fixes

+kill-useless-pm_access-from-vtc.patch
+add-typechecking-to-suspend-types-and-powerdown-types.patch
+swsusp-print-error-message-when-swapping-is-disabled.patch

 power management fixes

-get_user_pages-handle-VM_IO.patch

 Dropped - a similar patch was merged.

+perfctr-api-changes-first-step.patch
+perfctr-x86-64-ia32-emulation-fix.patch
+perfctr-ppc32-update.patch

 perfctr work

+scheduler-remove-redundant-ifdef.patch

 cleanup

-enable-preempt_bkl-on-smp-too.patch
-sched-add-debug_smp_processor_id.patch
-preempt-debugging.patch
-clean-up-preempt-debugging.patch

 Folded into remove-the-bkl-by-turning-it-into-a-semaphore.patch

+kexec-ide-spindown-fix.patch

 Prevent spinning down IDE disks during kexec restart.

+vmscan-pages_scanned-fix.patch

 Fix possible kswapd busy loop.

-vmscan-total_scanned-fix.patch
-revert-vm-no-wild-kswapd.patch
-balance_pgdat-cleanup.patch
-no-wild-kswapd-2.patch
-no-wild-kswapd-kswapd-continue.patch

 Drop these for now, so other vmscan changes get fairly tested.

+dio-handle-eof-fix.patch

 direct-io fix

+savagefb-export-fixes.patch

 symbol export fix for this new fbdev driver

+radeonfb-screeninfo-initialization-cleanup.patch
+radeonfb-if-no-video-memory-exit-with-error.patch

 radeon fixes

+invalidate_inode_pages-mmap-coherency-fix.patch

 Fiddle with the coherency of mmaps versus disk direct-io operations.

+remove-unused-internal-exports-from-ide-core.patch
+unexport-raise_softirq.patch
+vmalloc_to_page-helper.patch
+make-filemap_fdatawrite_range-static.patch
+remove-unused-code-dump_extended_fpu.patch

 Various small tweaks

+v4l-bttv-ir-input-update.patch
+v4l-bttv-whitespace-cleanup.patch
+v4l-i2c-whitespace-cleanup.patch
+v4l-ir-whitespace-cleanup.patch
+v4l-msp3400-update.patch
+v4l-tuner-update.patch
+v4l-videobuf-whitespace-cleanup.patch
+v4l-videodev-whitespace-cleanup.patch

 v4l update

+remove-module_parm-from-allyesconfig-almost.patch

 Move lots of MODULE_PARMs to module_param()

+rcu-rcu_assign_pointer-removal-of-memory-barriers.patch
+rcu-use-rcu_assign_pointer.patch
+rcu-eliminating-explicit-memory-barriers-from-sysv-ipc.patch

 RCU updates

+yenta_socketc-fix-missing-pci_disable_dev.patch

 cardbus driver fix

+remove-dead-exports-in-sounds-oss.patch
+remove-dead-exports-in-sounds-oss-fix.patch
+unexport-getnstimeofday.patch
+unexport-kick_process.patch
+remove-page_follow_link.patch
+unexport-sys_lseek.patch
+remove-ext2-xatts-exports.patch
+parport-kill-dead-code-and-exports.patch
+parport-kill-dead-code-and-exports-2.patch
+unexport-vc_cons_allocated.patch
+mark-pi_unclaim-static.patch
+unexport-set_selection-and-paste_selection.patch
+unexport-firmware_class.patch

 More small tweaks

+unwind-information-fix-for-the-vsyscall-dso.patch

 x86 vsyscall fix

+ramdisktxt-update.patch

 Documentation update

+unexport-some-rxrpc-symbols.patch
+kill-excessive-cdrom-prints.patch
+unexport-add_timer_on.patch

 Even more small code tweaks

+fix-incorrect-mt-rainier-detection.patch

 cdrom detection fix

+add-a-bunch-of-missing-files-to-documentation-00-index.patch

 Documentation fixes

+make-dnotify-a-configure-time-option.patch
+make-dnotify-a-configure-time-option-embedded.patch

 Allow dnotify to be Kconfigured away

+make-buffer-head-argument-of-buffer_name-const.patch

 const correctness

+ftape-has-no-maintainer.patch
+ftape-documentation-fixes.patch

 ftape documentation tweaks

+convert-pipefs-to-fs_initcall.patch

 Initialise pipefs earlier

+signal-gcc34-fix.patch

 gcc-3.4 fix

+lock-initializer-unifying-core.patch
+lock-initializer-unifying-network-drivers.patch

 Harmonise spinlock initialisations

+fix-show_refcnt-return-value-type.patch
+remove-invoke_softirq.patch
+remove-mousedriverssgml.patch

 More code fixlets

+fix-via-pmuc-compilation-without-config_pmac_pbook.patch

 pmac vuild fix

+yenta-dont-enable-read-prefetch-on-older-o2-bridges.patch

 Another cardbus driver fix

+fatfs-name-termination-fix.patch

 fatfs fix

+remove-itimer_ticks-and-itimer_next.patch

 cleanup

+handle-posix-message-queues-with-proc-sys-disabled.patch

 POSIX message queue fix.



number of patches in -mm: 394
number of changesets in external trees: 359
number of patches in -mm only: 375
total patches: 734




All 394 patches:



linus.patch

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

netfilter_debug-is-buggy.patch
  netfilter_debug-is-buggy

move-key_init-to-security_initcall.patch
  move key_init to security_initcall

bk-acpi.patch

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

bk-arm.patch

bk-cifs.patch

bk-driver-core.patch

bk-drm-via.patch

bk-i2c.patch

bk-ia64.patch

bk-input.patch

bk-dtor-input.patch

bk-jfs.patch

bk-kbuild.patch

bk-libata.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-pcmcia.patch

bk-pnp.patch

bk-scsi.patch

bk-serial.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

sysfs-backing-store-prepare-file_operations.patch
  sysfs backing store - prepare sysfs_file_operations helpers

sysfs-backing-store-prepare-file_operations-fix.patch
  fix oops with firmware loading

sysfs-backing-store-add-sysfs_dirent.patch
  sysfs backing store - add sysfs_direct structure

sysfs-backing-store-use-sysfs_dirent-tree-in-removal.patch
  sysfs backing store: use sysfs_dirent based tree in file removal

sysfs-backing-store-use-sysfs_dirent-tree-in-dir-file_operations.patch
  sysfs backing store: use sysfs_dirent based tree in dir file operations

sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves.patch
  sysfs backing store: stop pinning dentries/inodes for leaf entries

shmem-numa-policy-spinlock.patch
  shmem NUMA policy spinlock

statm-__vm_stat_accounting.patch
  statm: __vm_stat_accounting

statm-shared-=-rss-anon_rss.patch
  statm: shared = rss - anon_rss

statm-fix-negative-data.patch
  statm: fix negative data

tmpfs-truncate-latency.patch
  tmpfs truncate latency

omit-commitavail.patch
  omit CommitAvail

anon-cris-align-address_space.patch
  anon cris align address_space

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

arcnet-fixes.patch
  arcnet fixes

use-mmiowb-in-tg3_poll.patch
  use mmiowb in tg3_poll

x25-stop-x25_destroy_socket-timer-looping.patch
  X.25: Stop x25_destroy_socket timer looping

ethertap-debug-no-newline.patch
  ethertap debug no newline

x25-stop-proc-net-x25-route-infinitely.patch
  X.25: Stop /proc/net/x25/route infinitely reading

x25-dont-log-unknown-frame-type-when.patch
  X.25: Dont log "unknown frame type" when receiving clear confirm

aes-allow-modular-build.patch
  AES: allow modular build

avoid-warning-on-conntrack_stat_inc-in-destroy_conntrack.patch
  Avoid warning on CONNTRACK_STAT_INC in destroy_conntrack()

selinux-fix-netif-bugs-and-simplify.patch
  SELinux: fix netif bugs and simplify.

selinux-fix-sidtab-locking-bug.patch
  SELinux: fix sidtab locking bug

ppc64-iseries-console-cleanup-after-tty_write-user-copies-removal.patch
  ppc64: iSeries console: cleanup after tty_write user copies  removal

ppc64-cpu-hotplug-notifier-for-numa.patch
  ppc64: cpu hotplug notifier for numa

add-pci_get_legacy_ide_irq.patch
  add pci_get_legacy_ide_irq()

ppc32-disable-broken-l2-cache-on-all-440gx-revs.patch
  ppc32: disable broken L2 cache on all 440GX revs

ppc64-reloc_hide.patch

sh-do_signal-update-for-generic-changes.patch
  sh: do_signal() update for generic changes

sh-compile-fixes.patch
  sh: compile fixes

sh-syscall-updates.patch
  sh: syscall updates

hpet-reenabling-after-suspend-resume.patch
  HPET reenabling after suspend-resume

optimize-stack-pointer-access-reduce-register-usage.patch
  x86: optimize stack pointer access (reduce register usage)

skip-sync_arb_ids-on-p4-xeon.patch
  skip sync_arb_IDs on P4/Xeon

x86-64-clustered-apic-support.patch
  x86-64 clustered APIC support
  x86-64-clustered-apic-support fix
  x86-64-clustered-apic-support-fix fix
  x86-64-clustered-apic-support fix

fix-deadlocks-on-dpm_sem.patch
  Fix deadlocks on dpm_sem

kill-useless-pm_access-from-vtc.patch
  Kill useless pm_access from vt.c

add-typechecking-to-suspend-types-and-powerdown-types.patch
  Add typechecking to suspend types and powerdown types

swsusp-print-error-message-when-swapping-is-disabled.patch
  swsusp: print error message when swapping is disabled

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
  Fix stack overflow test for non-8k stacks
  kgdb-ga.patch fix for i386 single-step into sysenter
  fix TRAP_BAD_SYSCALL_EXITS on i386
  add TRAP_BAD_SYSCALL_EXITS config for i386

kgdb-is-incompatible-with-kprobes.patch
  kgdb-is-incompatible-with-kprobes

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-x86_64-fix.patch
  kgdb-x86_64-fix

kprobes-exception-notifier-fix-kgdb-x86_64.patch
  kprobes exception notifier fix

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix

kgdb-ia64-fixes.patch
  kgdb: ia64 fixes

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

dev-mem-restriction-patch-allow-reads.patch
  dev-mem-restriction-patch: allow reads

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

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
  ext3 reservation ifdef cleanup patch
  ext3 reservation max window size check patch
  ext3 reservation file ioctl fix

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard
  ext3 reservations: bad_inode fix
  ext3 reservation discard race fix

ext3-reservations-spelling-fixes.patch
  ext3 reservations: Spelling fixes

ext3-reservations-renumber-the-ext3-reservations-ioctls.patch
  ext3 reservations: Renumber the ext3 reservations ioctls

ext3-reservations-remove-unneeded-declaration.patch
  ext3 reservations: Remove unneeded declaration.

ext3-reservations-turn-ext3-per-sb-reservations-list-into-an-rbtree.patch
  ext3 reservations: Turn ext3 per-sb reservations list into an rbtree.

ext3-reservations-split-the-reserve_window-struct-into-two.patch
  ext3 reservations: Split the "reserve_window" struct into two

ext3-reservations-smp-protect-the-reservation-during-allocation.patch
  ext3 reservations: SMP-protect the reservation during allocation

ext3-rsv-use-before-initialise-fix.patch
  ext3 reservations: use before initialised fix

ext3-reservations-window-allocation-fix.patch
  ext3 reservations window allocation fix

ext3-reservation-window-size-increase-incorrectly-fix.patch
  ext3 reservation window size increase incorrectly fix

ext3_reservation_window_fix_fix.patch
  ext3 reservation window fix fix

ext3-reservation-remove-stale-window-fix.patch
  ext3 reservation: remove stale window fix

ext3-reservation-allow-turn-off-for-specifed-file.patch
  ext3 reservation: allow turn off for specifed file

ext3-reservation-skip-allocation-in-a-full-group.patch
  ext3 reservation: skip allocation in a "full" group

perfctr-core.patch
  perfctr: core

perfctr-i386.patch
  perfctr: i386

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86_64.patch
  perfctr: x86_64

perfctr-ppc.patch
  perfctr: PowerPC

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

perfctr-virtualised-counters.patch
  perfctr: virtualised counters

perfctr-remap_page_range-fix.patch

virtual-perfctr-illegal-sleep.patch
  virtual perfctr illegal sleep

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr: Kconfig-related updates

perfctr-ppc32-preliminary-interrupt-support.patch
  perfctr ppc32 preliminary interrupt support

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr: reduce stack usage

perfctr-interrupt-support-kconfig-fix.patch
  perfctr interrupt_support Kconfig fix

perfctr-low-level-documentation.patch
  perfctr low-level documentation

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance: driver updates

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

perfctr-api-changes-first-step.patch
  perfctr API changes: first step

perfctr-x86-64-ia32-emulation-fix.patch
  perfctr x86-64 ia32 emulation fix

perfctr-ppc32-update.patch
  perfctr ppc32 update

ext3-online-resize-patch.patch
  ext3: online resizing

scheduler-remove-redundant-ifdef.patch
  scheduler: remove redundant #ifdef

preempt-smp.patch
  improve preemption on SMP

preempt-smp-_raw_read_trylock-bias-fix.patch
  preempt-smp _raw_read_trylock bias fix

preempt-cleanup.patch
  preempt cleanup

preempt-cleanup-fix.patch
  preempt-cleanup-fix

add-lock_need_resched.patch
  add lock_need_resched()

sched-add-cond_resched_softirq.patch
  sched: add cond_resched_softirq()

sched-ext3-fix-scheduling-latencies-in-ext3.patch
  sched: ext3: fix scheduling latencies in ext3

break-latency-in-invalidate_list.patch
  break latency in invalidate_list()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent.patch
  sched: vfs: fix scheduling latencies in prune_dcache() and select_parent()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent-fix.patch
  sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent fix

sched-net-fix-scheduling-latencies-in-netstat.patch
  sched: net: fix scheduling latencies in netstat

sched-net-fix-scheduling-latencies-in-__release_sock.patch
  sched: net: fix scheduling latencies in __release_sock

sched-mm-fix-scheduling-latencies-in-copy_page_range.patch
  sched: mm: fix scheduling latencies in copy_page_range()

fix-config_debug_highmem-assert-in-copy_page_range.patch
  fix CONFIG_DEBUG_HIGHMEM assert in copy_page_range()

sched-mm-fix-scheduling-latencies-in-unmap_vmas.patch
  sched: mm: fix scheduling latencies in unmap_vmas()

sched-mm-fix-scheduling-latencies-in-get_user_pages.patch
  sched: mm: fix scheduling latencies in get_user_pages()

sched-mm-fix-scheduling-latencies-in-filemap_sync.patch
  sched: mm: fix scheduling latencies in filemap_sync()

fix-keventd-execution-dependency.patch
  fix keventd execution dependency

sched-fix-scheduling-latencies-in-mttrc.patch
  sched: fix scheduling latencies in mttr.c

sched-fix-scheduling-latencies-in-vgaconc.patch
  sched: fix scheduling latencies in vgacon.c

sched-fix-scheduling-latencies-for-preempt-kernels.patch
  sched: fix scheduling latencies for !PREEMPT kernels

idle-thread-preemption-fix.patch
  idle thread preemption fix

oprofile-smp_processor_id-fixes.patch
  oprofile smp_processor_id() fixes

fix-smp_processor_id-warning-in-numa_node_id.patch
  Fix smp_processor_id() warning in numa_node_id()

remove-the-bkl-by-turning-it-into-a-semaphore.patch
  remove the BKL by turning it into a semaphore

cpu_down-warning-fix.patch
  cpu_down() warning fix

vmtrunc-truncate_count-not-atomic.patch
  vmtrunc: truncate_count not atomic

vmtrunc-restore-unmap_vmas-zap_bytes.patch
  vmtrunc: restore unmap_vmas zap_bytes

vmtrunc-unmap_mapping_range_tree.patch
  vmtrunc: unmap_mapping_range_tree

vmtrunc-unmap_mapping-dropping-i_mmap_lock.patch
  vmtrunc: unmap_mapping dropping i_mmap_lock

vmtrunc-vm_truncate_count-race-caution.patch
  vmtrunc: vm_truncate_count race caution

vmtrunc-bug-if-page_mapped.patch
  vmtrunc: bug if page_mapped

vmtrunc-restart_addr-in-truncate_count.patch
  vmtrunc: restart_addr in truncate_count

ext3_bread-cleanup.patch
  ext3_bread() cleanup

linux-2.6.8.1-49-rpc_workqueue.patch
  nfs: RPC: Convert rpciod into a work queue for greater flexibility

linux-2.6.8.1-50-rpc_queue_lock.patch
  nfs: RPC: Remove the rpc_queue_lock global spinlock

cpufreq-driver-for-nforce2-kernel-267.patch
  cpufreq driver for nForce2

allow-modular-ide-pnp.patch
  allow modular ide-pnp

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm

serialize-access-to-ide-devices.patch
  serialize access to ide devices

remove-unconditional-pci-acpi-irq-routing.patch
  remove unconditional PCI ACPI IRQ routing

propagate-pci_enable_device-errors.patch
  propagate pci_enable_device() errors

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

cachefs-release-search-records-lest-they-return-to-haunt-us.patch
  CacheFS: release search records lest they return to haunt us

fix-64-bit-problems-in-cachefs.patch
  Fix 64-bit problems in cachefs

cachefs-fixed-typos-that-cause-wrong-pointer-to-be-kunmapped.patch
  cachefs: fixed typos that cause wrong pointer to be kunmapped

cachefs-return-the-right-error-upon-invalid-mount.patch
  CacheFS: return the right error upon invalid mount

fix-cachefs-barrier-handling-and-other-kernel-discrepancies.patch
  Fix CacheFS barrier handling and other kernel discrepancies

remove-error-from-linux-cachefsh.patch
  Remove #error from linux/cachefs.h

cachefs-warning-fix-2.patch
  cachefs warning fix 2

cachefs-linkage-fix-2.patch
  cachefs linkage fix

cachefs-build-fix.patch
  cachefs build fix

cachefs-documentation.patch
  CacheFS documentation

add-page-becoming-writable-notification.patch
  Add page becoming writable notification

provide-a-filesystem-specific-syncable-page-bit.patch
  Provide a filesystem-specific sync'able page bit

provide-a-filesystem-specific-syncable-page-bit-fix.patch
  provide-a-filesystem-specific-syncable-page-bit-fix

provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
  provide-a-filesystem-specific-syncable-page-bit-fix-2

make-afs-use-cachefs.patch
  Make AFS use CacheFS

afs-cachefs-dependency-fix.patch
  afs-cachefs-dependency-fix

split-general-cache-manager-from-cachefs.patch
  Split general cache manager from CacheFS

turn-cachefs-into-a-cache-backend.patch
  Turn CacheFS into a cache backend

rework-the-cachefs-documentation-to-reflect-fs-cache-split.patch
  Rework the CacheFS documentation to reflect FS-Cache split

update-afs-client-to-reflect-cachefs-split.patch
  Update AFS client to reflect CacheFS split

assign_irq_vector-section-fix.patch
  assign_irq_vector __init section fix

kexec-i8259-shutdowni386.patch
  kexec: i8259-shutdown.i386

kexec-i8259-shutdown-x86_64.patch
  kexec: x86_64 i8259 shutdown

kexec-apic-virtwire-on-shutdowni386patch.patch
  kexec: apic-virtwire-on-shutdown.i386.patch

kexec-apic-virtwire-on-shutdownx86_64.patch
  kexec: apic-virtwire-on-shutdown.x86_64

kexec-ioapic-virtwire-on-shutdowni386.patch
  kexec: ioapic-virtwire-on-shutdown.i386

kexec-ioapic-virtwire-on-shutdownx86_64.patch
  kexec: ioapic-virtwire-on-shutdown.x86_64

kexec-e820-64bit.patch
  kexec: e820-64bit

kexec-kexec-generic.patch
  kexec: kexec-generic

kexec-ide-spindown-fix.patch
  kexec-ide-spindown-fix

kexec-ifdef-cleanup.patch
  kexec ifdef cleanup

kexec-machine_shutdownx86_64.patch
  kexec: machine_shutdown.x86_64

kexec-kexecx86_64.patch
  kexec: kexec.x86_64

kexec-machine_shutdowni386.patch
  kexec: machine_shutdown.i386

kexec-kexeci386.patch
  kexec: kexec.i386

kexec-use_mm.patch
  kexec: use_mm

kexec-loading-kernel-from-non-default-offset.patch
  kexec: loading kernel from non-default offset

kexec-enabling-co-existence-of-normal-kexec-kernel-and-panic-kernel.patch
  kexec: nabling co-existence of normal kexec kernel and  panic kernel

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-kmap-build-fix.patch
  crashdump kmap build fix

crashdump-register-snapshotting-before-kexec-boot.patch
  crashdump: register snapshotting before kexec boot

crashdump-elf-format-dump-file-access.patch
  crashdump: ELF format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear/raw format dump file access

crashdump-minor-bug-fixes-to-kexec-crashdump-code.patch
  crashdump: minor bug fixes to kexec crashdump code

crashdump-cleanups-to-the-kexec-based-crashdump-code.patch
  crashdump: cleanups to the kexec based crashdump code

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-fix-cpuset_get_dentry.patch
  cpusets : fix cpuset_get_dentry()

cpusets-fix-race-in-cpuset_add_file.patch
  cpusets: fix race in cpuset_add_file()

cpusets-remove-more-casts.patch
  cpusets: remove more casts

cpusets-make-config_cpusets-the-default-in-sn2_defconfig.patch
  cpusets: make CONFIG_CPUSETS the default in sn2_defconfig

cpusets-document-proc-status-allowed-fields.patch
  cpusets: document proc status allowed fields

cpusets-dont-export-proc_cpuset_operations.patch
  Cpusets - Dont export proc_cpuset_operations

cpusets-display-allowed-masks-in-proc-status.patch
  cpusets: display allowed masks in proc status

cpusets-simplify-cpus_allowed-setting-in-attach.patch
  cpusets: simplify cpus_allowed setting in attach

cpusets-remove-useless-validation-check.patch
  cpusets: remove useless validation check

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

cpusets-interoperate-with-hotplug-online-maps.patch
  cpusets: interoperate with hotplug online maps

cpusets-alternative-fix-for-possible-race-in.patch
  cpusets: alternative fix for possible race in  cpuset_tasks_read()

cpusets-remove-casts.patch
  cpusets: remove void* typecasts

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-sb_sync_inodes-cleanup.patch
  reiser4-sb_sync_inodes-cleanup

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-allow-drop_inode-implementation-cleanup.patch
  reiser4-allow-drop_inode-implementation-cleanup

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-truncate_inode_pages_range-cleanup.patch
  reiser4-truncate_inode_pages_range-cleanup

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-rcu-barrier-fix.patch
  reiser4-rcu-barrier fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-inode_lock-cleanup.patch
  reiser4-export-inode_lock-cleanup

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-pagevec-funcs-cleanup.patch
  reiser4-export-pagevec-funcs-cleanup

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-aliased-dir.patch
  reiser4: vfs: handle aliased directories

reiser4-kobject-umount-race.patch
  reiser4: introduce filesystem kobjects

reiser4-kobject-umount-race-cleanup.patch
  reiser4-kobject-umount-race-cleanup

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-unstatic-kswapd.patch
  reiser4: make kswapd() unstatic for debug

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-4kstacks-fix.patch
  resier4-4kstacks-fix

stop-reiser4-from-turning-itself-on-by-default.patch
  Stop reiser4 from turning itself on by default

reiser4-doc.patch
  reiser4: documentation

reiser4-doc-update.patch
  Update Documentation/Changes for reiser4

reiser4-only.patch
  reiser4: main fs

reiser4-delete_from_page_cache.patch
  reiser4 delete_from_page_cache

reiser4-cond_resched-build-fix.patch
  reiser4: cond_resched() build fix

reiser4-debug-build-fix.patch
  reiser4-debug-build-fix

reiser4-prefetch-warning-fix.patch
  reiser4: prefetch warning fix

reiser4-mode-fix.patch
  reiser4: mode type fix

reiser4-get_context_ok-warning-fixes.patch
  reiser4: get_context_ok() warning fixes

reiser4-remove-debug.patch
  resier4: remove debug stuff

reiser4-spinlock-debugging-build-fix-2.patch
  reiser4-spinlock-debugging-build-fix-2

reiser4-sparc64-build-fix.patch
  reiser4 sparc64 build fix

sys_reiser4-sparc64-build-fix.patch
  sys_reiser4 sparc64 build fix

reiser4-printk-warning-fixes.patch
  reiser4 printk warning fixes

reiser4-generic_acl-fix.patch
  reiser4: generic_acl fix

reiser4-plugin_set_done-memleak-fix.patch
  reiser4 plugin_set_done-memleak-fix.patch

reiser4-init-max_atom_flusers.patch
  reiser4 init-max_atom_flusers.patch

reiser4-parse-options-reduce-stack-usage.patch
  reiser4 parse-options-reduce-stack-usage.patch

reiser4-sparce64-warning-fix.patch
  reiser4 sparc64-warning-fix.patch

reiser4-hardirq-build-fix.patch
  resiser4: hardirq.h build fix

reiser4-x86_64-warning-fix.patch
  reiser4 x86_64-warning-fix.patch

reiser4-fix-mount-option-parsing.patch
  reiser4 fix-mount-option-parsing.patch

reiser4-parse-option-cleanup.patch
  reiser4 parse-option-cleanup.patch

reiser4-comment-fix.patch
  reiser4 comment-fix.patch

reiser4-fill_super-improve-warning.patch
  reiser4 fill_super-improve-warning.patch

reiser4-disable-pseudo.patch
  reiser4 disable-pseudo.patch

reiser4-disable-repacker.patch
  reiser4 disable-repacker.patch

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

add-acpi-based-floppy-controller-enumeration-fix.patch
  add-acpi-based-floppy-controller-enumeration fix

update-acpi-floppy-enumeration.patch
  update ACPI floppy enumeration

floppy-acpi-enumeration-update.patch
  floppy ACPI enumeration update

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

3c59x-pm-fix.patch
  3c59x: enable power management unconditionally

3c59x-missing-pci_disable_device.patch
  3c59x: missing pci_disable_device

3c59x-use-netdev_priv.patch
  3c59x: use netdev_priv

3c59x-make-use-of-generic_mii_ioctl.patch
  3c59x: Make use of generic_mii_ioctl

3c59x-vortex-select-mii.patch
  3c59x: VORTEX select MII

3c59x-reload-eeprom-values-at-rmmod-for-needy-cards.patch
  3c59x: reload EEPROM values at rmmod for needy cards

3c59x-remove-eeprom_reset-for-3c905b.patch
  3c59x: remove EEPROM_RESET for 3c905B

3c59x-support-more-ethtool_ops.patch
  3c59x: support more ethtool_ops

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

serial-8250-receive-lockup-fix.patch
  serial: 8250 receive lockup fix

new-serial-flow-control.patch
  new serial flow control

vm-pageout-throttling.patch
  vm: pageout throttling

fix-race-in-sysfs_read_file-and-sysfs_write_file.patch
  Fix race in sysfs_read_file() and sysfs_write_file()

possible-race-in-sysfs_read_file-and-sysfs_write_file-update.patch
  Possible race in sysfs_read_file() and sysfs_write_file()

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

fix-for-spurious-interrupts-on-e100-resume-2.patch
  Fix for spurious interrupts on e100 resume 2

thinkpad-fnfx-key-driver.patch
  thinkpad fn+fx key driver

enforce-a-gap-between-heap-and-stack.patch
  Enforce a gap between heap and stack

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

add-hook-for-pci-resource-deallocation-2.patch
  add hook for PCI resource deallocation

ia64-alignment-error-stack-dump.patch
  ia64-alignment-error-stack-dump

changed-pci_find_device-to-pci_get_device.patch
  Changed pci_find_device to pci_get_device

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

rmmod-ohci1394-hangs.patch
  rmmod ohci1394 hangs

for-mm-only-remove-remap_page_range-completely.patch
  vm: for -mm only: remove remap_page_range() completely

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()

ipvs-deadlock-fix.patch
  ipvs deadlock fix

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

vmscan-pages_scanned-fix.patch
  vmscan: pages_scanned fix

no-buddy-bitmap-patch-revist-intro-and-includes.patch
  no buddy bitmap patch revist: intro and includes

no-buddy-bitmap-patch-revisit-for-mm-page_allocc.patch
  no buddy bitmap patch revisit: for mm/page_alloc.c

no-buddy-bitmap-patch-revist-for-ia64.patch
  no buddy bitmap patch revist: for ia64

no-buddy-bitmap-patch-revist-for-ia64-fix.patch
  no-buddy-bitmap-patch-revist-for-ia64 fix

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

dio-handle-eof.patch
  direct-IO: handle EOF

dio-handle-eof-fix.patch
  dio-handle-eof fix

savagefb-export-fixes.patch
  savagefb export fixes

radeonfb-screeninfo-initialization-cleanup.patch
  radeonfb: screeninfo initialization cleanup

radeonfb-if-no-video-memory-exit-with-error.patch
  radeonfb: If no video memory, exit with error

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

use-mmiowb-in-qla1280c.patch
  use mmiowb in qla1280.c

use-mmiowb-in-tg3c.patch
  use mmiowb in tg3.c

ia64-get_fs-build-fix.patch
  ia64 get_fs build fix

invalidate_inode_pages-mmap-coherency-fix.patch
  invalidate_inode_pages2() mmap coherency fix

remove-unused-internal-exports-from-ide-core.patch
  remove unused internal exports from ide core

unexport-raise_softirq.patch
  unexport raise_softirq

vmalloc_to_page-helper.patch
  vmalloc_to_page helper

make-filemap_fdatawrite_range-static.patch
  make filemap_fdatawrite_range() static

remove-unused-code-dump_extended_fpu.patch
  remove unused code: dump_extended_fpu

v4l-bttv-ir-input-update.patch
  From: Gerd Knorr <kraxel@bytesex.org>
  Subject: [patch] v4l: bttv IR input update

v4l-bttv-whitespace-cleanup.patch
  From: Gerd Knorr <kraxel@bytesex.org>
  Subject: [patch] v4l: bttv whitespace cleanup

v4l-i2c-whitespace-cleanup.patch
  From: Gerd Knorr <kraxel@bytesex.org>
  Subject: [patch] v4l: i2c whitespace cleanup

v4l-ir-whitespace-cleanup.patch
  From: Gerd Knorr <kraxel@bytesex.org>
  Subject: [patch] v4l: IR whitespace cleanup

v4l-msp3400-update.patch
  From: Gerd Knorr <kraxel@bytesex.org>
  Subject: [patch] v4l: msp3400 update

v4l-tuner-update.patch
  From: Gerd Knorr <kraxel@bytesex.org>
  Subject: [patch] v4l: tuner update

v4l-videobuf-whitespace-cleanup.patch
  From: Gerd Knorr <kraxel@bytesex.org>
  Subject: [patch] v4l: videobuf whitespace cleanup

v4l-videodev-whitespace-cleanup.patch
  From: Gerd Knorr <kraxel@bytesex.org>
  Subject: [patch] v4l: videodev whitespace cleanup

remove-module_parm-from-allyesconfig-almost.patch
  Remove MODULE_PARM from allyesconfig (almost)

rcu-rcu_assign_pointer-removal-of-memory-barriers.patch
  RCU: rcu_assign_pointer() removal of memory barriers

rcu-use-rcu_assign_pointer.patch
  RCU: use rcu_assign_pointer()

rcu-eliminating-explicit-memory-barriers-from-sysv-ipc.patch
  RCU: eliminating explicit memory barriers from SysV IPC

yenta_socketc-fix-missing-pci_disable_dev.patch
  yenta_socket.c: Fix missing pci_disable_dev

remove-dead-exports-in-sounds-oss.patch
  remove dead exports in sounds/oss

remove-dead-exports-in-sounds-oss-fix.patch
  remove-dead-exports-in-sounds-oss-fix

unexport-getnstimeofday.patch
  unexport getnstimeofday

unexport-kick_process.patch
  unexport kick_process

remove-page_follow_link.patch
  remove page_follow_link

unexport-sys_lseek.patch
  unexport sys_lseek

remove-ext2-xatts-exports.patch
  remove ext2 xatts exports

parport-kill-dead-code-and-exports.patch
  parport: kill dead code and exports

parport-kill-dead-code-and-exports-2.patch
  parport: kill dead code and exports 2

unexport-vc_cons_allocated.patch
  unexport vc_cons_allocated

mark-pi_unclaim-static.patch
  mark pi_unclaim static

unexport-set_selection-and-paste_selection.patch
  unexport set_selection and paste_selection

unexport-firmware_class.patch
  unexport firmware_class

unwind-information-fix-for-the-vsyscall-dso.patch
  Unwind information fix for the vsyscall DSO

ramdisktxt-update.patch
  ramdisk.txt update

unexport-some-rxrpc-symbols.patch
  Unexport some RxRPC symbols

kill-excessive-cdrom-prints.patch
  kill excessive cdrom prints

unexport-add_timer_on.patch
  unexport add_timer_on()

fix-incorrect-mt-rainier-detection.patch
  Fix incorrect Mt Rainier detection

add-a-bunch-of-missing-files-to-documentation-00-index.patch
  add a bunch of missing files to Documentation/00-INDEX

make-dnotify-a-configure-time-option.patch
  make dnotify a configure-time option

make-dnotify-a-configure-time-option-embedded.patch
  make-dnotify-a-configure-time-option-embedded

make-buffer-head-argument-of-buffer_name-const.patch
  make buffer head argument of buffer_##name "const"

ftape-has-no-maintainer.patch
  ftape has no maintainer

ftape-documentation-fixes.patch
  ftape documentation fixes

convert-pipefs-to-fs_initcall.patch
  convert pipefs to fs_initcall()

signal-gcc34-fix.patch
  signal.c: gcc-3.4 fix

lock-initializer-unifying-core.patch
  Lock initializer unifying (Core)

lock-initializer-unifying-network-drivers.patch
  Lock initializer unifying (Network drivers)

fix-show_refcnt-return-value-type.patch
  fix show_refcnt return value type

remove-invoke_softirq.patch
  remove invoke_softirq

remove-mousedriverssgml.patch
  remove mousedrivers.sgml

fix-via-pmuc-compilation-without-config_pmac_pbook.patch
  fix via-pmu.c compilation without CONFIG_PMAC_PBOOK

yenta-dont-enable-read-prefetch-on-older-o2-bridges.patch
  yenta: don't enable read prefetch on older o2 bridges.

fatfs-name-termination-fix.patch
  fatfs: name termination fix

remove-itimer_ticks-and-itimer_next.patch
  remove itimer_ticks and itimer_next

handle-posix-message-queues-with-proc-sys-disabled.patch
  handle posix message queues with /proc/sys disabled



