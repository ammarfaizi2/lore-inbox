Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWBXLKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWBXLKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 06:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWBXLKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 06:10:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750953AbWBXLKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 06:10:42 -0500
Date: Fri, 24 Feb 2006 03:10:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc4-mm2
Message-Id: <20060224031002.0f7ff92a.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/

- Sam's new section-mismatch warning code detects 358 errors in my alpha
  build, and a quick sampling indicates that they're real.  Once this hits
  mainline things will get somewhat messy.

- The git-blktrace tree was dropped, due to a bad disagreement with the
  relayfs rework in Greg's tree.

- Various buggy patches which were in -mm1 were dropped.  Should be better. 
  (ie: some new, more interesting bugs).



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



Changes since 2.6.16-rc4-mm1:

 linus.patch
 git-acpi.patch
 git-alsa.patch
 git-audit-master.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-ia64.patch
 git-infiniband.patch
 git-input.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-ntfs.patch
 git-ocfs2.patch
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
 git-viro-bird-fixes.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-xfs.patch
 git-viro-bird-uml.patch
 git-viro-bird-frv.patch
 git-viro-bird-misc.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch
 git-viro-bird-endian.patch

 git trees.

-oom-kill-children-accounting.patch
-terminate-process-that-fails-on-a-constrained-allocation-v3.patch
-i386-need-to-pass-virtual-address-to-smp_read_mpc.patch
-cfi_cmdset_0001-fix-range-for-cache-invalidation.patch
-spi-fix-modular-master-driver-remove-and-device-suspend-remove.patch
-x86_64-dont-set-config_debug_info-in-defconfig.patch
-cpu-hotplug-documentation-fix.patch
-suspend-to-ram-allow-video-options-to-be-set-at-runtime.patch
-suspend-to-ram-allow-video-options-to-be-set-at-runtime-update.patch
-fix-units-in-mbind-check.patch
-fix-race-condition-in-hvc-console.patch
-daemonize-detach-from-current-namespace.patch
-fix-snd-usb-audio-in-32-bit-compat-environemt.patch
-pktcdvd-correctly-set-rq-cmd_len-in-pkt_generic_packet.patch
-pktcdvd-rename-functions-and-make-their-return-values-sane.patch
-pktcdvd-remove-useless-printk-statements.patch
-pktcdvd-fix-the-logic-in-the-pkt_writable_track-function.patch
-pktcdvd-only-return-erofs-when-appropriate.patch
-modules-with-old-style-parameters-wont-load.patch
-modules-with-old-style-parameters-wont-load-fix.patch
-v9fs-update-documentation-and-fix-debug-flag.patch
-powermac-fix-loss-of-ethernet-phy-on-sleep.patch
-fix-undefined-symbols-for-nommu-architecture-improved-version.patch
-fix-compile-for-config_sysvipc=n-or-config_sysctl=n.patch
-reset-pci-device-state-to-unknown-after-disabled.patch
-ipw2200-suppress-warning-message.patch
-drivers-fc4-fcc-memset-correct-length.patch
-firmware-fix-bug-in-fw_realloc_buffer.patch
-spi-per-transfer-overrides-for-wordsize-and-clocking.patch
-sem2mutex-drivers-media-2.patch
-sky2-fix-a-hang-on-yukon-ec-0xb6-rev-1.patch
-gregkh-pci-acpiphp-add-new-bus-to-acpi.patch
-pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch
-usb-zc0301-driver-updates.patch
-page-migration-fix-mpol_interleave-behavior-for-migration-via.patch
-page-migration-fix-mpol_interleave-behavior-for-migration-via-fix.patch
-pci-cardbus-cards-hidden-needs-pci=assign-busses-to-fix.patch
-pci-cardbus-cards-hidden-needs-pci=assign-busses-to-fix-tidy.patch
-pci-cardbus-cards-hidden-needs-pci=assign-busses-to-fix-tidy-fix.patch
-include-asm-m68k-irqh-remove-unused-define-enable_irq_nosync.patch
-radeonfb-resume-support-for-samsung-p35-laptops.patch

 Merged

+cache-align-futex-hash-buckets.patch

 futex speedup (not final)

+m32r-enable-asm-code-optimization.patch
+m32r-fix-and-update-for-gcc-40.patch
+remove-module_parm.patch
+remove-module_parm-fix.patch
+snd-cs4236-tpyo-fix.patch
+alsa-fix-bogus-snd_device_free-in-opl3-ossc.patch
+pnp-bus-type-fix.patch
+uml-correct-error-messages-in-cow-driver.patch
+uml-fix-usage-of-kernel_errno-in-place-of-errno.patch
+uml-fix-unused-attribute.patch
+uml-os_connect_socket-error-path-fixup.patch
+uml-better-error-reporting-for-read_output.patch
+uml-tidying-cow-code.patch
+vgacon-no-vertical-resizing-on-ega.patch
+kprobes-causes-nx-protection-fault-on-i686-smp.patch
+powerpc-fix-altivec_unavailable_exception-oopses.patch
+cfi-init-wait-queue-in-chip-struct.patch
+voyager-fix-boot-panic-by-adding-topology-export.patch
+voyager-fix-the-cpu_possible_map-to-make-voyager-boot-again.patch
+page-migration-fix-mpol_interleave-behavior-for-migration-via.patch
+x86-fix-smp-boot-sequence.patch
+x86-fix-smp-boot-sequence-fix.patch
+gbefb-ip32-gbefb-depth-change-fix.patch
+gbefb-set-default-of-fb_gbe_mem-to-4-mb.patch
+au1100fb-replaced-io_remap_page_range-with-io_remap_pfn_range.patch
+asiliantfb-fix-pseudo_palette-setup-in-asiliantfb_setcolreg.patch
+flags-parameter-for-linkat.patch
+flags-parameter-for-linkat-fix.patch
+vmscan-fix-zone_reclaim.patch

 Current 2.6.16 queue.  Some of these are a bit questionable at this stage.

+gregkh-driver-sysfs-relay-channel-buffers-as-sysfs-attributes.patch
+gregkh-driver-relay-consolidate-relayfs-core-into-kernel-relay.c.patch
+gregkh-driver-sysfs-update-relay-file-support-for-generic-relay-api.patch
+gregkh-driver-relayfs-remove-relayfs-in-favour-of-config_relay.patch
+gregkh-driver-relay-relay-header-cleanup.patch
+gregkh-driver-sysfs-add-__attr_relay-helper-for-relay-attributes.patch
+gregkh-driver-sysfs-kzalloc-conversion.patch
+gregkh-driver-firmware-fix-bug-in-fw_realloc_buffer.patch
+gregkh-driver-spi-per-transfer-overrides-for-wordsize-and-clocking.patch

 Driver tree updates

+add-cpia2-camera-support.patch

 CPIA camera driver

+gregkh-i2c-w1-use-kthread-api.patch

 i2c tree

+pc-speaker-add-snd_silent.patch

 Bring back yet again the pc-speaker SND_SILENT patch.  I can't get rid of
 the thing.

+remove-the-config_cc_align_-options.patch

 kbuild cleanup

+drivers-scsi-libata-scsic-make-some-functions-static.patch

 scsi cleanup

+tg3-netif_carrier_off-runs-too-early-could-still-be-queued-when-init-fails.patch

 tg3 fix (nacked by maintainer)

+config_forcedeth-updates.patch

 forcedeth driver fixes

+serial-serial_txx9-driver-update.patch

 This got lost.  Another patch I cannot get rid of.  Should I send them
 daily?

+serial-kernel-console-should-send-crlf-not-lfcr.patch

 serial driver \n\r -> \r\n fixes

+gregkh-pci-pci-avoid-leaving-master_abort-disabled-permanently-when-returning-from-pci_scan_bridge.patch
+gregkh-pci-shpchp-remove-unused-pci_bus-member-from-controller-structure.patch
+gregkh-pci-shpchp-remove-unused-wait_for_ctrl_irq.patch
+gregkh-pci-shpchp-event-handling-rework.patch
+gregkh-pci-shpchp-fix-slot-state-handling.patch
+gregkh-pci-shpchp-adapt-to-pci-driver-model.patch
+gregkh-pci-pci-add-pci_device_shutdown-to-pci_bus_type.patch
+gregkh-pci-pci-smbus-unhide-on-hp-compaq-nx6110.patch
+gregkh-pci-pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch
+gregkh-pci-pci-make-msi-quirk-inheritable-from-the-pci-bus.patch
+gregkh-pci-pci-msi-save-restore-for-suspend-resume.patch
+gregkh-pci-pci-remove-msi-save-restore-code-in-specific-driver.patch
+gregkh-pci-pci-resource-address-mismatch.patch
+gregkh-pci-pci-fix-problems-with-msi-x-on-ia64.patch
+gregkh-pci-pci-pci-cardbus-cards-hidden-needs-pci-assign-busses-to-fix.patch
+gregkh-pci-pci-move-pci_dev_put-outside-a-spinlock.patch
+gregkh-pci-acpiphp-add-new-bus-to-acpi.patch
+gregkh-pci-acpi-export-acpi_bus_trim.patch
+gregkh-pci-acpiphp-add-dock-event-handling.patch
+gregkh-pci-acpi-remove-dock-event-handling-from-ibm_acpi.patch
+gregkh-pci-acpiphp-slot-management-fix-v4.patch

 PCI tree updates

+revert-gregkh-pci-x86-pci-domain-support-the-meat.patch
+gregkh-pci-altix-msi-support-git-ia64-fix.patch

 Fix up things in the PCI tree

+axnet_cs-support-amb8110.patch

 New device support

+net-socket-timestamp-32-bit-handler-for-64-bit-kernel-fix.patch

 Fix net-socket-timestamp-32-bit-handler-for-64-bit-kernel.patch

+git-sparc64-build-fix.patch

 Fix git-sparc64.patch

+gregkh-usb-usb-unusual_devs-entry-for-lyra-rca-rd1080.patch
+gregkh-usb-usb-lh7a40x-gadget-driver-fixed-a-dead-lock.patch
+gregkh-usb-usb-gadget-rndis-fix-alloc-bug.patch
+gregkh-usb-ub-use-kzalloc.patch
+gregkh-usb-usb-gadget-driver-section-fixups.patch
+gregkh-usb-usb-ethernet-gadget-driver-section-fixups.patch
+gregkh-usb-usb-visor.c-id-for-gspda-smartphone.patch
+gregkh-usb-usb-fix-warning-in-drivers-usb-media-ov511.c.patch
+gregkh-usb-usb-zc0301-driver-updates.patch
+gregkh-usb-usb-credits-add-credits-about-the-zc0301-and-et61x51-usb-drivers.patch

 USB tree updates

+slab-remove-slab_no_reap-option.patch
+slab-remove-slab_no_reap-option-fix.patch
+on_each_cpu-disable-local-interupts.patch
+slab-use-on_each_cpu.patch
+slab-node-rotor-for-freeing-alien-caches-and-remote-per-cpu-pages.patch
+slab-node-rotor-for-freeing-alien-caches-and-remote-per-cpu-pages-fix.patch

 slab cleanups and NUMA tweak

+selinux-disable-automatic-labeling-of-new-inodes-when.patch
+selinuxfs-cleanups-fix-hard-link-count.patch
+selinuxfs-cleanups-use-sel_make_dir.patch
+selinuxfs-cleanups-sel_fill_super-exit-path.patch
+selinuxfs-cleanups-sel_make_bools.patch
+selinuxfs-cleanups-sel_make_avc_files.patch

 SELinux updates

+i386-dont-let-ptrace-set-the-nested-task-bit.patch
+i386-let-signal-handlers-set-the-resume-flag.patch
+x86-early-printk-handling-fixes.patch
+register-the-boot-cpu-in-the-cpu-maps-earlier.patch
+register-the-boot-cpu-in-the-cpu-maps-earlier-fix.patch
+i386-pass-proper-trap-numbers-to-die-chain-handlers.patch
+i386-actively-synchronize-vmalloc-area-when-registering-certain-callbacks.patch
+i386-actively-synchronize-vmalloc-area-when-registering-certain-callbacks-tidy.patch
+i386-fix-uses-of-user_mode-vs-user_mode_vm.patch
+fix-elf-entry-point-i386.patch
+i386-fix-singlestep-through-an-int80-syscall.patch

 x86 updates

+swsusp-documentation-fix.patch

 swsusp documentation

-pm-add-state-field-to-pm_message_t-to-hold-actual.patch
-pm-respect-the-actual-device-power-states-in-sysfs.patch
-pm-minor-updates-to-core-suspend-resume-functions.patch
-pm-make-pci_choose_state-use-the-real-device.patch

 Dropped due to bug.

+pm-print-name-of-failed-suspend-function.patch

 PM debugging aid.

+remove-kernel-power-pmcpm_unregister.patch

 Cleanup

-dasd-backout-dasd_eer-module.patch

 The eer module got deleted.

-register-sysfs-device-for-lp-devices.patch

 Buggy, dropped.

-timer-irq-driven-soft-watchdog-percpu-race-fix.patch
-timer-irq-driven-soft-watchdog-percpu-fix.patch
-timer-irq-driven-soft-watchdog-boot-fix.patch

 Folded into timer-irq-driven-soft-watchdog-cleanups.patch

+softlockup-detection-vs-cpu-hotplug.patch
+timer-irq-driven-soft-watchdog-cleanups-update.patch

 Update it some more.

+decrapify-asm-generic-localh.patch

 Use atomic64_t for default local_t implementation

+fs-inodec-make-iprune_mutex-static.patch

 Cleanup

+reiserfs-fix-transaction-overflowing.patch

 reiser3 fix

+introduce-fmode_exec-file-flag.patch

 A hint for distributed filesystems.

+add-lookup_instantiate_filp-usage-warning.patch

 Comment update

+isdn-fix-copy_to_user-unused-result-warning-in-isdn_ppp.patch

 Warning fix

+time_interpolator-use-readq_relaxed-instead-of-readq.patch

 Microoptimisation

+copy_process-cleanup-bad_fork_cleanup_sighand.patch
+copy_process-cleanup-bad_fork_cleanup_signal.patch
+cleanup-__exit_signal.patch
+rename-__exit_sighand-to-cleanup_sighand.patch
+move-__exit_signal-to-kernel-exitc.patch
+revert-optimize-sys_times-for-a-single-thread-process.patch
+do-__unhash_process-under-siglock.patch
+sys_times-dont-take-tasklist_lock.patch
+relax-sig_needs_tasklist.patch
+do_signal_stop-dont-take-tasklist_lock.patch
+do_group_exit-dont-take-tasklist_lock.patch
+do_sigaction-dont-take-tasklist_lock.patch

 More core process/pid/thread updates from Oleg.

+autofs4-add-new-packet-type-for-v5-communications-fix.patch

 Fix autofs4-add-new-packet-type-for-v5-communications.patch

-time-reduced-ntp-rework-part-1-update.patch
+time-reduced-ntp-rework-part-1-fix-adjtimeadj.patch
+time-reduced-ntp-rework-part-2-fix-adjtimeadj.patch
+time-clocksource-infrastructure-remove-nsec_t.patch
+time-generic-timekeeping-infrastructure-remove-nsec_t.patch
+time-generic-timekeeping-infrastructure-fix-ntp_synced.patch
+time-generic-timekeeping-infrastructure-wall_offset-helper-cleanup.patch
+time-i386-conversion-part-3-remove-nsec_t.patch
+time-i386-conversion-part-3-backout-pmtmr-changes.patch
-time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change.patch
-time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change-x86_64-fix.patch
+time-i386-conversion-part-4-del-timer_tscc.patch
+time-i386-clocksource-drivers-backout-pmtmr-changes.patch

 Various updates, fixes and cleanups for the time management patches in -mm.

+sched-smpnice-apply-review-suggestions.patch

 Tweaks for sched-implement-smpnice.patch

+frv-remove-unnecessary-ampersand.patch
+function-typo-fixes.patch
+um-fix-undefined-reference-to-hweight32.patch
+arm-fix-undefined-reference-to-generic_fls.patch
+bitops-generic-test_and_setclearchange_bit-fix.patch
+bitops-generic-hweight6432168-fix.patch
+bitops-m68k-use-generic-bitops-fix.patch
+bitops-ppc-use-generic-bitops.patch
+remove-zone_mem_map.patch

 Various updates related to the bitops consolidation code in -mm.

+ia64-add-ptr-to-compatpatch.patch
+s390-add-ptr-compatpatch.patch
+parisc-add-ptr-compatpatch.patch
+mips-add-ptr-compatpatch.patch

 Various archtectures need ptr_to_compat() for the lightweight futex patch.

+lightweight-robust-futexes-docs-update.patch
+lightweight-robust-futexes-i386-fix.patch
+lightweight-robust-futexes-x86_64-fix.patch

 Updates to the futex patches

+unify-pfn_to_page-sparc64-pfn_to_page-fix.patch

 Fix unify-pfn_to_page-sparc64-pfn_to_page.patch

+notifier-chain-update-api-changes.patch
+notifier-chain-update-api-changes-register-atomic_notifiers-in-atomic-context.patch
+notifier-chain-update-api-changes-export-new-notifier-chain-routines-as-gpl.patch
+notifier-chain-update-api-changes-avoid-calling-down_read-and-down_write-during-startup.patch
+notifier-chain-update-simple-definition-changes.patch
+notifier-chain-update-remove-unneeded-protection.patch
+notifier-chain-update-remove-unneeded-protection-the-idle-notifier-chain-should-be-atomic.patch
+notifier-chain-update-die_chain-changes.patch
+notifier-chain-update-dont-unregister-yourself.patch
+notifier-chain-update-dont-unregister-yourself-fix.patch
+notifier-chain-update-changes-to-dcdbasc.patch
+notifier-chain-update-update-usb_notify.patch
+notifier-chain-update-remaining-changes-for-new-api.patch

 Notifier chain rework.

+rtc-subsystem-class.patch
+rtc-subsystem-arm-cleanup.patch
+rtc-subsystem-i2c-cleanup.patch
+rtc-subsystem-sysfs-interface.patch
+rtc-subsystem-proc-interface.patch
+rtc-subsystem-dev-interface.patch
+rtc-subsystem-x1205-driver.patch
+rtc-subsystem-test-device-driver.patch
+rtc-subsystem-ds1672-driver.patch
+rtc-subsystem-pcf8563-driver.patch
+rtc-subsystem-rs5c372-driver.patch

 rtc subsystem rework.   These patches are being updated.

+fbdev-framebuffer-driver-for-geode-gx-warning-fix.patch

 Fix warning in fbdev-framebuffer-driver-for-geode-gx-update.patch

+au1200fb-alchemy-au1200-framebuffer-driver.patch

 New framebuffer driver

+fbdev-make-bios-edid-reading-configurable.patch

 Fix boot-time stall due to EDID probing.

+acpi-identify-which-device-is-not-power-manageable.patch

 More useful ACPI warning message


All 1149 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/patch-list


