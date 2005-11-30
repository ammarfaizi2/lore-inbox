Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbVK3Ebs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVK3Ebs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVK3Ebs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:31:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17599 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750968AbVK3Ebq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:31:46 -0500
Date: Tue, 29 Nov 2005 20:31:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc3-mm1
Message-Id: <20051129203134.13b93f48.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc3/2.6.15-rc3-mm1/

- Several ISA sound drivers don't compile.  This is due to a collision
  between the ALSA and PCMCIA trees, and to breakage in the ALSA tree.

- drivers/serial/jsm/* still doesn't compile.

- Various raid and fbdev updates


Changes since 2.6.15-rc2-mm1:


 linus.patch
 git-acpi.patch
 git-alsa.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-rc-fixes.patch
 git-sas.patch
 git-cryptodev.patch

 Subsystem trees

-smp_call_function-must-be-a-macro.patch
-revert-floppy-fix-read-only-handling.patch
-mm-update-split-ptlock-kconfig.patch
-mm-unbloat-get_futex_key.patch
-mm-powerpc-ptlock-comments.patch
-mm-powerpc-init_mm-without-ptlock.patch
-mm-fill-arch-atomic64-gaps.patch
-kprobes-fix-return-probes-on-sys_execve.patch
-fix-do_wait-vs-exec-race.patch
-fix-crash-in-unregister_console.patch
-powerpc-fix-for-hugepage-areas-straddling-4gb-boundary.patch
-jffs2-debug-gcc-29x-fix.patch
-cs5535-audio-alsa-driver.patch
-sound-hda-rate-limit-timeout-message.patch
-gregkh-driver-small-fixups-to-driver-core.patch
-gregkh-i2c-hwmon-w83627hf-missing-in0-limit-check.patch
-gregkh-i2c-hwmon-lm78-fix-vid.patch
-gregkh-i2c-hwmon-fix-missing-it87-fan-div-init.patch
-drivers-mtd-possible-cleanups.patch
-mtd-make-sharpc-compile.patch
-gregkh-pci-pci-trivial-printk-updates-in-common.c.patch
-gregkh-pci-pci-express-hotplug-clear-sticky-power-fault-bit.patch
-gregkh-pci-pci-remove-bogus-resource-collision-error.patch
-gregkh-pci-pci-error-recovery-header-file-patch.patch
-ibmphp_pci-copy-n-paste-fix.patch
-gregkh-usb-usb-sn9c10x-driver-bad-page-state-fix.patch
-gregkh-usb-usb-ftdi_sio-new-ids-for-kobil-devices.patch
-gregkh-usb-usb-ehci-updates.patch
-gregkh-usb-usb-ehci-updates-mostly-whitespace-cleanups.patch
-gregkh-usb-usb-ehci-updates-split-init-reinit-logic-for-resume.patch
-gregkh-usb-usb-ohci-move-ppc-asic-tweaks-nearer-pci.patch
-fix-usb-suspend-resume-crasher.patch
-x86_64-acpi-return.patch
-shrinker-nr-=-long_max-means-deadlock-for-icache.patch
-mm-simplify-__alloc_pages-cpuset-alloc_-flags.patch
-mm-rationalize-__alloc_pages-alloc_-flag-names.patch
-mm-simplify-__alloc_pages-cpuset-hardwall-logic.patch
-mm-redo-alloc_-flag-names-again.patch

 Merged

+ehci-hang-fix.patch

 Fix USB hang

+acpi-scan-revert-acpi_bus_find_driver-return-value-check.patch

 ACPI fix

+process-events-connector-uid_t-gid_t-size-issues.patch

 connector 32/64-bit fix

+fix-crash-when-ptrace-poking-hugepage-areas.patch

 hugetlb-vs-ptrace fix

+fix-rebooting-on-hp-nc6120-laptop.patch

 HP laptop fix

+fix-swsusp-on-machines-not-supporting-s4.patch

 swsusp fix

+pfnmap-fix-2615-rc3-driver-breakage.patch

 Might fix some odd drivers for the recent MM changes

+ppc-fix-floating-point-register-corruption.patch

 ppc fix

+reiserfs-handle-cnode-allocation-failure-gracefully.patch

 reiserfs fix

+setting-irq-affinity-is-broken-in-ia32-with-msi-enabled.patch

 IRQ-affinity setting fix

+fbdev-cirrusfb-driver-cleanup-and-bug-fixes.patch
+fbdev-cg3fb-kconfig-fix.patch

 fbdev fixes

+acpi-fix-asus_acpi-on-samsung-p30-p35.patch

 Fix acpi driver

+sound-pci-au88x0-remove-unneeded-call-to-pci_dma_supported.patch

 Sound driver cleanup

+cpufreq_conservative-ondemand-invert-meaning-of-ignore-nice.patch

 Change meaning of cpufreq control

+gregkh-driver-driver-kill-hotplug-word-from-sn-and-others-fix.patch

 driver tree update

+broken-kref-counting-in-find-functions.patch

 kref fix

+use-kernelrelease.patch

 kbuild fix

+b44-missing-netif_wake_queue-in-b44_open.patch

 net driver fix

+serial-fix-matching-of-mmio-ports.patch

 serial driver fix

+gregkh-pci-pci-hotplug-ibmphp_pci.c-copy-n-paste-fix.patch
+gregkh-pci-pci-hotplug-cpqphp_ctrl.c-remove-dead-code.patch
+gregkh-pci-pci-error-recovery-symbios-scsi-device-driver.patch
+gregkh-pci-pci-error-recovery-ixgb-network-device-driver.patch
+gregkh-pci-pci-error-recovery-ipr-scsi-device-driver.patch
+gregkh-pci-pci-error-recovery-e1000-network-device-driver.patch
+gregkh-pci-pci-error-recovery-e100-network-device-driver.patch
+gregkh-pci-shpchp-replace-pci_find_slot-with-pci_get_slot.patch

 PCI tree updates

+pci-restore-2-missing-pci-ids.patch

 PCI device ID fix

+aic7xxx-crash-on-data-overrun.patch
+dpt_i2o-fix-for-deadlock-condition.patch
+mptfusion-performance-fix-for-u320.patch
+mptfusion-adding-=-this_module.patch
+mptfusion-cleaning-up-xxx_probe-error-handling.patch
+mptfusion-bus_type-change-scsi-to-spi.patch
+mptfusion-prep-for-removing-domain-validation.patch
+mptfusion-mapping-fixs-required-support-for-transport-layers.patch
+mptfusion-bump-version.patch
+mptfusion-bad-scsi-performance-fix.patch

 SCSI fixes and updates

+gregkh-usb-usb-documentation-update.patch
+gregkh-usb-additional-device-id-for-conexant-accessrunner-usb-driver.patch
+gregkh-usb-usb-fix-usb-suspend-resume-crasher.patch
+gregkh-usb-usb-small-cleanups.patch
+gregkh-usb-one-potential-problem-in-gadget-serial.c.patch
+gregkh-usb-usbcore-consider-power-budget-when-choosing-configuration.patch
+gregkh-usb-usb-store-port-number-in-usb_device.patch
+gregkh-usb-usb-cleanups-for-usb-gadget-mass-storage.patch
+gregkh-usb-isp116x-hcd-minor-cleanup.patch

 USB tree updates

-gregkh-usb-usb-pm-09-fix.patch

 Fixed differently

-add-notification-of-page-becoming-writable-to-vma-ops.patch

 Needs work.

-swap-migration-v5-mpol_mf_move-interface-unpaged-fix.patch
-swap-migration-v5-mpol_mf_move-interface-tweaks.patch

 Folded into swap-migration-v5-mpol_mf_move-interface.patch

+swapmig-switch-error-handling-in-migrate_pages-to-use-exx-fix.patch
+swapmig-switch-error-handling-in-migrate_pages-to-use-exx-cleanup.patch
+swapmig-switch-error-handling-in-migrate_pages-to-use-exx-cleanup-tidy.patch

 Fix swapmig-switch-error-handling-in-migrate_pages-to-use-exx.patch

+cleanup-bootmem-allocator-and-fix-alloc_bootmem_low.patch
+frv-clean-up-bootmem-allocators-page-freeing-algorithm.patch
+find_lock_page-call-__lock_page-directly.patch
+kill-last-zone_reclaim-bits.patch
+mm-dma32-zone-statistics.patch

 mm updates

-mm-add-is_dma_zone-helper.patch

 Duplicated in a new patch

+ppc32-fix-treeboot-image-entrypoint.patch
+apm_emuc-fix-a-missing-check-on-misc_register-return-code.patch

 ppc32 updates

+nommu-provide-shared-writable-mmap-support-on-ramfs.patch
+nommu-provide-shared-writable-mmap-support-on-ramfs-tidy.patch
+nommu-make-sysv-ipc-shm-use-ramfs-facilities-on-nommu.patch
+frv-implement-futex-operations-for-frv.patch
+frv-make-futex-code-compilable-on-nommu.patch
+frv-fix-frv-signal-handling.patch
+frv-improve-signal-handling.patch

 FRV/nommu updates

+reboot-through-the-bios-on-newer-hp-laptops.patch
+disable-apic-pin-1-on-dodgy-ati-chipsets.patch
+disable-apic-pin-1-on-dodgy-ati-chipsets-fix.patch
+add-new-quirk-for-devices-with-mute-leds-and-separate-headphone-volume.patch
+x86-hotplug-cpu-disable-lapic-completely-for-offline-cpu.patch
+i386-x86_64-remove-preempt-disable-calls-in-lowlevel-ipi.patch
+x86-change-page-attr-fix.patch
+x86-change-page-attr-fix-fix.patch
+x86-change-page-attr-fix-fix-fix.patch

 x86 updates

+x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is-fix.patch
+cpu-hotplug-x86_64-disable-interrupt-in-play_dead.patch

 x86_64 fixes

-suspend-support-for-pnp-bus.patch

 This is done differently in the ALSA tree

+oss-remove-deprecated-pm-interface-from-ad1848-driver.patch
+oss-remove-deprecated-pm-interface-from-cs4281-driver.patch
+oss-remove-deprecated-pm-interface-from-cs46xx-driver.patch
+oss-remove-deprecated-pm-interface-from-maestro-driver.patch
+oss-remove-deprecated-pm-interface-from-nm256-driver.patch
+oss-remove-deprecated-pm-interface-from-opl3sa2-driver.patch

 Remove the old PM API from some OSS drivers

+swsusp-drop-duplicate-prototypes.patch

 swsusp fix

+make-rcu-task_struct-safe-for-oprofile.patch

 Fix oprofile for the rcuification of task_struct patches.

+fix-possible-page_cache_shift-overflows.patch

 Fix various 32-bit overflows

+kill_proc_info_as_uid-dont-use-hardcoded-constants.patch

 Cleanup

+do_coredump-should-reset-group_stop_count-earlier.patch

 core dumping fix

+little-do_group_exit-cleanup.patch

 cleanup

+tpm-add-bios-measurement-log.patch
+tpm-add-bios-measurement-log-tidy.patch
+tpm-add-bios-measurement-log-fix.patch

 TPM feature

+updated-cpu-hotplug-documentation.patch

 CPU hotplug documentation

+move-swiotlb-header-file-into-common-code.patch
+move-swiotlb-header-file-into-common-code-fix.patch

 cleanup

+pivot_root-add-comment.patch

 Add a comment

+shared-mounts-cleanup.patch

 cleanup

+ext3-external-journal-device-as-a-mount-option.patch
+ext3-external-journal-device-as-a-mount-option-update.patch

 ext3 featurette.

+oprofile-use-vmalloc_node-in-alloc_cpu_buffers.patch

 oprofile optimisation

+ext3-remove-trailing-newlines-from-ext3_warning-calls.patch
+ext3-use-sbi-instead-of-ext3_sb-in-resize-code.patch
+maintainers-line-duplication.patch
+remove-unneeded-sig-curr_target-recalculation.patch

 cleanups

+sigio-cleanup-dont-take-tasklist-twice.patch

 micro-optimise signal code

+nfsroot-do-not-silently-stop-parsing-on-an-unknown-option.patch

 Warn about bak boot option

+shrink-dentry-struct.patch
+shrink-dentry-struct-fix.patch
+shrink-dentry-struct-spufs-fix.patch

 Make struct dentry smaller.

+kdump-read-previous-kernels-memory-fix.patch

 Fix kdump-read-previous-kernels-memory.patch

+simple-spi-framework.patch
+simple-spi-framework-gregkh-hotplug-fix.patch
+ads7846-driver-spi-framework.patch
+ads7846-driver-spi-framework-fix.patch
+mtd-dataflash-driver-spi-framework.patch

 SPI driver framework and applications

+fuse-clean-up-fuse_lookup.patch
+fuse-clean-up-page-offset-calculation.patch
+fuse-bump-interface-version.patch
+fuse-add-frsize-to-statfs-reply.patch
+fuse-support-caching-negative-dentries.patch

 FUSE updates

+ktimers-timespec-off-by-one.patch

 Fix ktimers-kt2.patch some more.

+knfsd-check-error-status-from-vfs_getattr-and-i_op-fsync.patch

 knfsd update

+ide-compat_semaphore-to-completion.patch

 IDE cleanup/fix

+add-sysfs-entry-to-disable-framebuffer-access.patch
+add-sysfs-entry-to-disable-framebuffer-access-tidy.patch
+fbdev-nvidiafb-driver-cleanup.patch
+fbdev-savagefb-driver-cleanup.patch
+fbdev-i810fb-driver-cleanups.patch
+fbdev-rivafb-driver-cleanups.patch
+fbdev-asiliantfb-driver-cleanups.patch
+fbdev-hgafb-convert-to-platform-device.patch
+fbdev-imsttfb-driver-cleanups.patch
+fbdev-kyrofb-driver-cleanups.patch
+fbdev-neofb-driver-cleanups.patch
+fbdev-pm2fb-driver-cleanups.patch
+fbdev-tdfxfb-driver-cleanups.patch
+fbdev-fbdev-cleanup.patch
+fbdev-atyfb-remove-bios-less-booting.patch

 fbdev updates

+md-improve-raid1-io-barrier-concept.patch
+md-improve-raid10-io-barrier-concept.patch
+md-small-cleanups-for-raid5.patch
+md-allow-dirty-raid-arrays-to-be-started-at-boot.patch
+md-move-bitmap_create-to-after-md-array-has-been-initialised.patch
+md-write-intent-bitmap-support-for-raid10.patch
+md-fix-raid6-resync-check-repair-code.patch
+md-improve-handing-of-read-errors-with-raid6.patch
+md-attempt-to-auto-correct-read-errors-in-raid1.patch
+md-tidyup-some-issues-with-raid1-resync-and-prepare-for-catching-read-errors.patch
+md-better-handling-for-read-error-in-raid1-during-resync.patch
+md-handle-errors-when-read-only.patch
+md-fix-up-some-rdev-rcu-locking-in-raid5-6.patch

 RAID updates

+arch-i386-kernel-microcodec-remove-the-obsolete-microcode_ioctl.patch
+remove-checkconfigpl.patch

 Cleanups


All 806 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc3/2.6.15-rc3-mm1/patch-list


