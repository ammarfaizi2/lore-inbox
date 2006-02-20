Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWBTM14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWBTM14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWBTM14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:27:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030183AbWBTM1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:27:55 -0500
Date: Mon, 20 Feb 2006 04:26:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc4-mm1
Message-Id: <20060220042615.5af1bddc.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/

- git-jfs.patch has been dropped due to its ongoing git problems.

- Added Al Viro's `bird' tree (what does that mean, anyway?) as
  git-viro-bird.patch.

  This tree had a lot of things dropped when it is merged into -mm, partly
  because some of it appears to have been merged into other git trees.

- This kernel won't compile on ia64 (and possibly other architectures)
  because the kbuild tree is using Elf_Rela in scripts/mod/modpost.c.  Is OK
  on x86, x86_64 and powerpc.  Sam might send a hotfix?

- Many warnings are emitted at the link stage due to section mismatches and
  duplicated symbol exports.  Please don't report these.  Patches are welcome,
  but do them carefully - it's easy to make mistakes with these things.



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it's not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.



 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit.patch
 git-blktrace.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-ntfs.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-sas-jg.patch
 git-sparc64.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch
 git-viro-bird.patch

 git trees.

-pktcdvd-dont-spam-the-kernel-log-when-nothing-is-wrong.patch
-pktcdvd-allow-non-writable-media-to-be-mounted.patch
-pktcdvd-dont-unlock-the-door-if-the-disc-is-in-use.patch
-pktcdvd-reduce-stack-usage.patch
-compound-page-use-pagelru.patch
-compound-page-default-destructor.patch
-compound-page-no-access_process_vm-check.patch
-tty-reference-count-fix.patch
-hpet-handle-multiple-acpi-extended_irq-resources.patch
-jbd-revert-checkpoint-list-changes.patch
-nlm-fix-the-nlm_granted-callback-checks.patch
-fix-x86-topology-export-in-sysfs-for-subarchitectures.patch
-fix-null-pointer-dereference-in-isdn_tty_at_cout.patch
-kprobes-update-documentation-kprobestxt.patch
-madvise-madv_dontfork-madv_dofork.patch
-sched-revert-filter-affine-wakeups.patch
-fix-a-typo-in-the-cpu_h8300h-dependencies.patch
-gregkh-i2c-hwmon-vt8231-temp-hyst.patch
-gregkh-i2c-hwmon-w83781d-real-time-alarms.patch
-gregkh-i2c-hwmon-w83627hf-document-reset-param.patch
-gregkh-i2c-it87-fix-oops-on-removal.patch
-sem2mutex-drivers-input-serio-gameport-joystick.patch
-sem2mutex-drivers-input-inputc.patch
-sem2mutex-input-layer-3.patch
-add-logitech-mouse-type-99.patch
-irda-nsc-ircc-add-isapnp-support.patch
-sky2-speed-setting-fix.patch
-netfilter-fix-cid-offset-bug-in-pptp-nat-helper.patch
-smctr-warning-fix.patch
-gregkh-pci-acpiphp-handle-dock-stations.patch
-gregkh-pci-x86-pci-domain-support-struct-pci_sysdata-fix-fix.patch
-gregkh-pci-x86-pci-domain-support-struct-pci_sysdata-fix.patch
-gregkh-usb-usb-fix-up-the-usb-early-handoff-logic-for-ehci.patch
-gregkh-usb-usb-add-new-device-ids-to-ldusb.patch
-gregkh-usb-usb-change-ldusb-s-experimental-state.patch
-gregkh-usb-usb-pl2303-leadtek-9531-gps-mouse.patch
-gregkh-usb-usb-sl811_cs-needs-platform_device-conversion-too.patch
-gregkh-usb-usb-storage-new-unusual_devs-entry.patch
-gregkh-usb-usb-storage-unusual_devs-entry.patch
-terminate-process-that-fails-on-a-constrained-allocation-v3.patch
-x86-document-sysenter-path.patch
-x86-gitignore-some-autogenerated-files-for-i386.patch
-input-98kbd-io-and-98spkr-removal-really.patch
-neofb-avoid-resetting-display-config-on-unblank.patch

 Merged

+oom-kill-children-accounting.patch
+terminate-process-that-fails-on-a-constrained-allocation-v3.patch
+i386-need-to-pass-virtual-address-to-smp_read_mpc.patch
+cfi_cmdset_0001-fix-range-for-cache-invalidation.patch
+spi-fix-modular-master-driver-remove-and-device-suspend-remove.patch
+x86_64-dont-set-config_debug_info-in-defconfig.patch
+cpu-hotplug-documentation-fix.patch
+suspend-to-ram-allow-video-options-to-be-set-at-runtime.patch
+suspend-to-ram-allow-video-options-to-be-set-at-runtime-update.patch
+scsi-aha152x-fixes.patch
+fix-units-in-mbind-check.patch
+fix-race-condition-in-hvc-console.patch
+daemonize-detach-from-current-namespace.patch
+fix-snd-usb-audio-in-32-bit-compat-environemt.patch
+pktcdvd-correctly-set-rq-cmd_len-in-pkt_generic_packet.patch
+pktcdvd-rename-functions-and-make-their-return-values-sane.patch
+pktcdvd-remove-useless-printk-statements.patch
+pktcdvd-fix-the-logic-in-the-pkt_writable_track-function.patch
+pktcdvd-only-return-erofs-when-appropriate.patch
+modules-with-old-style-parameters-wont-load.patch
+modules-with-old-style-parameters-wont-load-fix.patch
+v9fs-update-documentation-and-fix-debug-flag.patch
+powermac-fix-loss-of-ethernet-phy-on-sleep.patch
+fix-undefined-symbols-for-nommu-architecture-improved-version.patch
+fix-compile-for-config_sysvipc=n-or-config_sysctl=n.patch
+reset-pci-device-state-to-unknown-after-disabled.patch
+ipw2200-suppress-warning-message.patch
+drivers-fc4-fcc-memset-correct-length.patch

 Queue for 2.6.16.

+fix-ide-locking-error.patch
+fix-ide-locking-error-tidy.patch

 IDE mystery fix.  Don't know what this fixes or if it's needed yet.

+git-acpi-up-fix-2.patch

 Fix git-acpi.patch on UP.

-git-audit-fixup.patch

 Dropped.

+git-audit-inotify_inode_queue_event-fix.patch

 Fix git-audit.patch

-git-blktrace-fixup.patch

 Dropped

+gregkh-driver-module_sysfs_refcount.patch

 driver tree update

+spi-per-transfer-overrides-for-wordsize-and-clocking.patch

 SPI driver fix

+3c509-bus-registration-fix.patch
+3c509-use-proper-suspend-resume-api.patch
+3c509-use-proper-suspend-resume-api-fix.patch

 3c509 power management API modernisation.  (I couldn't find a way to get
 this driver's suspend and resume functions called anwyay).

+pm-suspend-eisa-and-mca-devices.patch
+pm-suspend-eisa-and-mca-devices-fix.patch

 Attempt to get them called.  Doesn't work.

+net-allow-32-bit-socket-ioctl-in-64-bit-kernel.patch
+net-allow-32-bit-socket-ioctl-in-64-bit-kernel-tidy.patch
+net-socket-timestamp-32-bit-handler-for-64-bit-kernel.patch
+net-socket-timestamp-32-bit-handler-for-64-bit-kernel-tidy.patch

 Net compat fixes

+x25-ioctl-conversion-32-bit-user-to-64-bit-kernel.patch
+x25-ioctl-conversion-32-bit-user-to-64-bit-kernel-tidy.patch
+x25-ioctl-conversion-32-bit-user-to-64-bit-kernel-tidy-fix.patch
+x25-fix-kernel-error-message-64-bit-kernel.patch
+x25-allow-itu-t-dte-facilities-for-x25.patch
+x25-allow-itu-t-dte-facilities-for-x25-tidy.patch
+x25-dte-facilities-32-64-ioctl-conversion.patch

 x25 feature work.

+gregkh-pci-pci-fix-the-x86-pci-domain-support-fix.patch
+gregkh-pci-pci-device-ensure-sysdata-initialised.patch
+gregkh-pci-acpiphp-add-new-bus-to-acpi.patch
+gregkh-pci-pci-give-pci-config-access-initialization-a-defined-ordering.patch

 PCI tree updates

-revert-gregkh-pci-x86-pci-domain-support-the-meat.patch

 No longer needed.

+git-pcmcia-fixup.patch

 Fix reject in git-pcmcia.patch

+git-scsi-misc-restore-zeroing-of-packet_command-struct-in-sr_ioctlc.patch

 scsi bugfix

+drivers-scsi-aic7xxx-aic79xx_corec-make-ahd_done_with_status-static.patch
+aacraid-fix-the-comparison-with-sizeof.patch

 scsi fixlets.

+gregkh-usb-usb-initdata-fixes.patch
+gregkh-usb-usbfs2.patch

 USB tree updates

-x86_64-defconfig-update.patch
-x86_64-hangcheck-remove-message.patch
-x86_64-hotadd-pud.patch
-x86_64-tune-generic.patch
-x86_64-stack-random-large.patch
-x86_64-bitops-cleanups.patch
-x86_64-rename-node.patch
-x86_64-cpu_pda-array-to-macro-followup-correction.patch
-x86_64-disallow-multi-byte-hardware-execution-breakpoints.patch
-x86_64-eliminate-set_debug.patch
-x86_64-save-fpu-context-slightly-later.patch
-x86_64-cleanup-allocating-logical-cpu-numbers-in-x86_64.patch
-x86_64-pmtimer-dont-touch-pit.patch
-x86_64-boot-report-apicid.patch
-x86_64-no_iommu-removal-in-pci-gartc.patch
-x86_64-i386-pci-ordering.patch
-x86_64-gart-relax.patch
-x86_64-actively-synchronize-vmalloc-area-when-registering-certain-callbacks.patch
-x86_64-remove-dead-do_softirq_thunk.patch
-x86_64-make-touch_nmi_watchdog-not-touch-impossible-cpus-private-data.patch
-x86_64-fix-user_ptrs_per_pgd.patch
-x86_64-argument-check.patch
-x86_64-fix-string.patch
-x86_64-agp-ali-m1695.patch
-x86_64-disable-randmaps.patch
-x86_64-traps-whitespace.patch
-x86_64-bad-iret-sti.patch
+x86_64-mm-hangcheck-remove-message.patch
+x86_64-mm-hotadd-pud.patch
+x86_64-mm-tune-generic.patch
+x86_64-mm-stack-random-large.patch
+x86_64-mm-bitops-cleanups.patch
+x86_64-mm-rename-node.patch
+x86_64-mm-cpu_pda-array-to-macro-followup-correction.patch
+x86_64-mm-disallow-multi-byte-hardware-execution-breakpoints.patch
+x86_64-mm-eliminate-set_debug.patch
+x86_64-mm-save-fpu-context-slightly-later.patch
+x86_64-mm-cleanup-allocating-logical-cpu-numbers-in-x86_64.patch
+x86_64-mm-pmtimer-dont-touch-pit.patch
+x86_64-mm-boot-report-apicid.patch
+x86_64-mm-no_iommu-removal-in-pci-gartc.patch
+x86_64-mm-gart-relax.patch
+x86_64-mm-actively-synchronize-vmalloc-area-when-registering-certain-callbacks.patch
+x86_64-mm-remove-dead-do_softirq_thunk.patch
+x86_64-mm-fix-user_ptrs_per_pgd.patch
+x86_64-mm-argument-check.patch
+x86_64-mm-fix-string.patch
+x86_64-mm-agp-ali-m1695.patch
+x86_64-mm-traps-whitespace.patch
+x86_64-mm-early-num-physpages.patch
+x86_64-mm-miscellaneous-cleanup.patch
+x86_64-mm-to-use-lapic-ids-instead-of-initial-apic-ids.patch

 x86_64 tree updates (I renamed all these to avoid naming clashes when
 patches are moved from -mm into Andi's tree)

+x86_64-fix-string-fix.patch

 x86_64 fix

+mm-remove-set_pgdir-leftovers.patch

 mm cleanup

+remove-vm_dontcopy-bogosities.patch
+page-migration-fix-mpol_interleave-behavior-for-migration-via.patch
+page-migration-fix-mpol_interleave-behavior-for-migration-via-fix.patch
+sg-use-compound-pages.patch
+i386-pageattr-remove-__put_page.patch
+i386-pageattr-remove-__put_page-fix.patch
+x86_64-pageattr-use-single-list.patch
+x86_64-pageattr-remove-__put_page.patch
+x86_64-pageattr-remove-__put_page-fix.patch
+mm-make-__put_page-internal.patch
+mm-nommu-use-compound-pages.patch
+remove-set_page_countpage-0-users-outside-mm.patch
+remove-set_page_count-outside-mm.patch
+mm-cleanup-prep_-stuff.patch
+mm-prep_zero_page-in-irq-is-a-bug.patch
+mm-more-config_debug_vm.patch
+mm-opt-page_count.patch

 Memory management updates

+via-pmu-warning-fix.patch
+powerpc-newline-for-isync_on_smp.patch
+powerpc-native-atomic_add_unless.patch

 ppc/ppc64 updates

+i386-remove-duplicate-declaration-of-mp_bus_id_to_pci_bus.patch
+make-isoimage-support-fdinitrd=-support-minor-cleanups.patch
+pci-cardbus-cards-hidden-needs-pci=assign-busses-to-fix.patch
+pci-cardbus-cards-hidden-needs-pci=assign-busses-to-fix-tidy.patch
+pci-cardbus-cards-hidden-needs-pci=assign-busses-to-fix-tidy-fix.patch
+i386-traps-merge-printk-calls.patch

 x86 updates

+revert-swsusp-fix-breakage-with-swap-on-lvm.patch
+swsusp-separate-swap-writing-reading-code-rev-2-fix-writing-progress-meter.patch
+swsusp-documentation-updates-warn-about-filesystems-mounted-from-usb-devices.patch
+swsusp-userland-interface-fixes.patch
+swsusp-userland-interface-fix-breakage-with-swap-on-lvm.patch
+swsusp-pm-refuse-to-suspend-devices-if-wrong-console-is-active.patch
+pm-add-state-field-to-pm_message_t-to-hold-actual.patch
+pm-respect-the-actual-device-power-states-in-sysfs.patch
+pm-minor-updates-to-core-suspend-resume-functions.patch
+pm-make-pci_choose_state-use-the-real-device.patch

 Power management updates

+include-asm-m68k-irqh-remove-unused-define-enable_irq_nosync.patch
+m68k-rtc-driver-cleanup.patch

 m68k updates

+fix-oops-in-invalidate_dquots.patch

 quota fix

+secure-digital-host-controller-id-and-regs-fix.patch

 Fix secure-digital-host-controller-id-and-regs.patch

+mmc-secure-digital-host-controller-interface-driver-fix.patch

 Fix mmc-secure-digital-host-controller-interface-driver.patch

+conditionalize-compat_sys_newfstatat.patch
+show-mcp-menu-only-on-arch_sa1100.patch
+ide-allow-ide-interface-to-specify-its-not-capable-of-32-bit.patch
+deprecate-the-kernel_thread-export.patch
+fix-value-computed-not-used-warnings.patch
+jffs2-fix-size_t-on-64bit-architectures.patch
+update-obsolete_oss_driver-schedule-and-dependencies.patch
+rio-more-header-cleanup.patch
+rioboot-lindent.patch
+rioboot-post-lindent.patch
+deprecate-the-tasklist_lock-export.patch
+sys_setrlimit-cleanup.patch
+rlimit_cpu-fix-handling-of-a-zero-limit.patch
+rlimit_cpu-document-wrong-return-value.patch
+ext3-properly-report-backup-block-present-in-a-group.patch
+fix-module-refcount-leak-in-__set_personality.patch
+# greg might have issues
+register-sysfs-device-for-lp-devices.patch
+rcu-batch-tuning.patch
+fix-file-counting.patch
+fix-file-counting-fixes.patch
+timer-irq-driven-soft-watchdog-cleanups.patch
+timer-irq-driven-soft-watchdog-percpu-race-fix.patch
+timer-irq-driven-soft-watchdog-percpu-fix.patch
+timer-irq-driven-soft-watchdog-boot-fix.patch
+keys-fix-key-quota-management-on-key-allocation.patch
+keys-replace-duplicate-non-updateable-keys-rather-than-failing.patch
+keys-deal-properly-with-strnlen_user.patch
+jbd-embed-j_commit_timer-in-journal-struct.patch
+jbd-convert-kjournald-to-kthread-api.patch
+missed-error-checking-for-intents-filp-in-open_namei.patch
+small-cleanup-in-quotah.patch

 Misc fixes and updates

+release_task-replace-open-coded-ptrace_unlink.patch
+convert-sighand_cache-to-use-slab_destroy_by_rcu.patch
+introduce-lock_task_sighand-helper.patch
+introduce-sig_needs_tasklist-helper.patch

 Even more core task management fixes and updates

+autofs4-nameidata-needs-to-be-up-to-date-for-follow_link.patch
+autofs4-add-v5-follow_link-mount-trigger-method.patch
+autofs4-add-v5-expire-logic.patch
+autofs4-add-new-packet-type-for-v5-communications.patch
+autofs4-change-autofs_typ_-autofs_type_.patch

 autofs4 feature work

+ext3-get-blocks-adjust-accounting-info-in-fix.patch

 Fix the ext3 i_blocks accounting bug.

+time-reduced-ntp-rework-part-1-update.patch

 Fix time-reduced-ntp-rework-part-1.patch

+kretprobe-instance-recycled-by-parent-process.patch
+kretprobe-instance-recycled-by-parent-process-tidy.patch
+kretprobe-instance-recycled-by-parent-process-fix.patch

 kprobes update

-sched-restore-smpnice.patch
-sched-modified-nice-support-for-smp-load-balancing.patch
+sched-implement-smpnice.patch

 New rolled-up smpnice patch

+sched-remove-on-runqueue-requeueing.patch

 scheduler fixlet.

+x86-dont-use-cpuid2-to-determine-cache-info-if-cpuid4-is-supported.patch

 x86 update for new CPUs

+cmpci-dont-use-generig_hweight32.patch
+bitops-alpha-use-config-options-instead-of-__alpha_fix__-and-__alpha_cix__.patch
+bitops-ia64-use-cpu_set-instead-of-__set_bit.patch
+bitops-parisc-add-pair-in-__ffz-macro.patch
+bitops-cris-remove-unnecessary-local_irq_restore.patch
+bitops-use-non-atomic-operations-for-minix__bit-and-ext2__bit.patch
+bitops-generic-test_and_setclearchange_bit.patch
+bitops-generic-__test_and_setclearchange_bit-and-test_bit.patch
+bitops-generic-__ffs.patch
+bitops-generic-ffz.patch
+bitops-generic-fls.patch
+bitops-generic-fls64.patch
+bitops-generic-find_nextfirst_zero_bit.patch
+bitops-generic-sched_find_first_bit.patch
+bitops-generic-ffs.patch
+bitops-generic-hweight6432168.patch
+bitops-generic-ext2_setcleartestfind_first_zerofind_next_zero_bit.patch
+bitops-generic-ext2_setclear_bit_atomic.patch
+bitops-generic-minix_testsettest_and_cleartestfind_first_zero_bit.patch
+bitops-alpha-use-generic-bitops.patch
+bitops-arm-use-generic-bitops.patch
+bitops-arm26-use-generic-bitops.patch
+bitops-cris-use-generic-bitops.patch
+bitops-frv-use-generic-bitops.patch
+bitops-h8300-use-generic-bitops.patch
+bitops-i386-use-generic-bitops.patch
+bitops-ia64-use-generic-bitops.patch
+bitops-m32r-use-generic-bitops.patch
+bitops-m68k-use-generic-bitops.patch
+bitops-m68knommu-use-generic-bitops.patch
+bitops-mips-use-generic-bitops.patch
+bitops-parisc-use-generic-bitops.patch
+bitops-powerpc-use-generic-bitops.patch
+bitops-s390-use-generic-bitops.patch
+bitops-sh-use-generic-bitops.patch
+bitops-sh64-use-generic-bitops.patch
+bitops-sparc-use-generic-bitops.patch
+bitops-sparc64-use-generic-bitops.patch
+bitops-v850-use-generic-bitops.patch
+bitops-x86_64-use-generic-bitops.patch
+bitops-xtensa-use-generic-bitops.patch
+bitops-update-include-asm-generic-bitopsh.patch
+bitops-make-thread_infoflags-an-unsigned-long.patch
+bitops-ia64-make-partial_pagebitmap-an-unsigned-long.patch
+bitops-ntfs-remove-generic_ffs.patch
+bitops-remove-unused-generic-bitops-in-include-linux-bitopsh.patch
+bitops-hweight-related-cleanup.patch
+bitops-hweight-speedup.patch

 bitops code consolidation

+unify-pfn_to_page-generic-functions.patch
+unify-pfn_to_page-i386-pfn_to_page.patch
+unify-pfn_to_page-x86_64-pfn_to_page.patch
+unify-pfn_to_page-powerpc-pfn_to_page.patch
+unify-pfn_to_page-alpha-pfn_to_page.patch
+unify-pfn_to_page-arm-pfn_to_page.patch
+unify-pfn_to_page-arm26-pfn_to_page.patch
+unify-pfn_to_page-cris-pfn_to_page.patch
+unify-pfn_to_page-frv-pfn_to_page.patch
+unify-pfn_to_page-h8300-pfn_to_page.patch
+unify-pfn_to_page-m32r-pfn_to_page.patch
+unify-pfn_to_page-mips-pfn_to_page.patch
+unify-pfn_to_page-parisc-pfn_to_page.patch
+unify-pfn_to_page-ppc-pfn_to_page.patch
+unify-pfn_to_page-s390-pfn_to_page.patch
+unify-pfn_to_page-sh-pfn_to_page.patch
+unify-pfn_to_page-sh64-pfn_to_page.patch
+unify-pfn_to_page-sparc-pfn_to_page.patch
+unify-pfn_to_page-sparc64-pfn_to_page.patch
+unify-pfn_to_page-uml-pfn_to_page.patch
+unify-pfn_to_page-v850-pfn_to_page.patch
+unify-pfn_to_page-xtensa-pfn_to_page.patch
+unify-pfn_to_page-ia64-pfn_to_page.patch

 pfn_to_page code consolidation

+lightweight-robust-futexes-arch-defaults.patch
+lightweight-robust-futexes-core.patch
+lightweight-robust-futexes-docs.patch
+lightweight-robust-futexes-compat.patch
+lightweight-robust-futexes-i386.patch
+lightweight-robust-futexes-x86_64.patch

 Robust futexes

+reiser4-doc-fix-reiser4-links-in-documentation.patch
+reiser4-only-stop-using-__put_page.patch

 reiser4 updates

+dm-remove-sector_format.patch

 devicemapper cleanup

-epoll_pwait.patch

 Dropped.

+git-viro-bird-8390-build-fix.patch
+git-viro-bird-reenable-stuff.patch

 Fix git-viro-bird.patch


All 1012 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc4-mm1/patch-list


