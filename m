Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbVIVF3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbVIVF3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 01:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVIVF3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 01:29:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15801 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750842AbVIVF3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 01:29:19 -0400
Date: Wed, 21 Sep 2005 22:28:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc2-mm1
Message-Id: <20050921222839.76c53ba1.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm1/

- Added git tree `git-sas.patch': Luben Tuikov's SAS driver and its support.

- Various random other things - nothing major.




Changes since 2.6.14-rc1-mm1:

 linus.patch
 git-cifs.patch
 git-cryptodev.patch
 git-drm.patch
 git-ia64.patch
 git-jfs.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-nfs-oops-fix.patch
 git-ocfs2-prep.patch
 git-ocfs2.patch
 git-scsi-misc.patch
 git-sas.patch
 git-watchdog.patch

 Subsystem trees

-raid6-altivec-fix.patch
-sharpsl-add-missing-hunk-from-backlight-update.patch
-mtd-update-sharpsl-partition-definitions.patch
-s390-default-configuration.patch
-s390-bl_dev-array-size.patch
-s390-crypto-driver-patch-take-2.patch
-s390-show_cpuinfo-fix.patch
-s390-diag-0x308-reipl.patch
-remove-arch-arm26-boot-compressed-hw-bsec.patch
-cpu-hotplug-breaks-wake_up_new_task.patch
-s390-kernel-stack-corruption.patch
-uml-_switch_to-code-consolidation.patch
-uml-breakpoint-an-arbitrary-thread.patch
-uml-remove-a-useless-include.patch
-uml-remove-an-unused-file.patch
-uml-remove-some-build-warnings.patch
-uml-preserve-errno-in-error-paths.patch
-uml-move-libc-code-out-of-mem_userc-and-tempfilec.patch
-uml-merge-mem_userc-and-memc.patch
-uml-return-a-real-error-code.patch
-uml-remove-include-of-asm-elfh.patch
-fix-up-some-pm_message_t-types.patch
-fix-mm-kconfig-spelling.patch
-x86_64-e820c-needs-module-h.patch
-seclvl-use-securityfs-tidy.patch
-seclvl-use-securityfs-fix.patch
-hdaps-driver-update.patch
-driver-core-fix-bus_rescan_devices-race-2.patch
-i2c-kill-an-unused-i2c_adapter-struct-member.patch
-fix-buffer-overrun-in-rpadlpar_sysfsc.patch
-ibmphp-use-dword-accessors-for-pci_rom_address.patch
-pciehp-use-dword-accessors-for-pci_rom_address.patch
-shpchp-use-dword-accessors-for-pci_rom_address.patch
-qla2xxx-use-dword-accessors-for-pci_rom_address.patch
-pci-convert-kcalloc-to-kzalloc.patch
-gregkh-usb-usb-gotemp.patch
-more-device-ids-for-option-card-driver.patch
-pcnet32-set_ringparam-implementation.patch
-pcnet32-set-min-ring-size-to-4.patch
-add-smp_mb__after_clear_bit-to-unlock_kiocb.patch
-joystick-vs-xorg-fix.patch
-codingstyle-memory-allocation.patch
-files-fix-preemption-issues.patch
-files-fix-preemption-issues-tidy.patch
-fat-miss-sync-issues-on-sync-mount-miss-sync-on-write.patch
-fix-pf-request-handling.patch
-i2o-remove-class-interface.patch
-i2o-remove-i2o_device_class.patch
-driver-core-allow-nesting-classes.patch
-driver-core-make-parent-class-define-subsystem.patch
-driver-core-pass-interface-to-class-intreface-methods.patch
-driver-core-send-hotplug-event-before-adding-class-interfaces.patch
-input-kill-devfs-references.patch
-input-prepare-to-sysfs-integration.patch
-input-convert-net-bluetooth-to-dynamic-input_dev-allocation.patch
-input-convert-drivers-macintosh-to-dynamic-input_dev-allocation.patch
-input-convert-konicawc-to-dynamic-input_dev-allocation.patch
-input-convert-onetouch-to-dynamic-input_dev-allocation.patch
-drivers-input-mouse-convert-to-dynamic-input_dev-allocation.patch
-drivers-input-keyboard-convert-to-dynamic-input_dev-allocation.patch
-drivers-input-touchscreen-convert-to-dynamic-input_dev-allocation.patch
-drivers-usb-input-convert-to-dynamic-input_dev-allocation.patch
-input-convert-ucb1x00-ts-to-dynamic-input_dev-allocation.patch
-input-convert-sound-ppc-beep-to-dynamic-input_dev-allocation.patch
-input-convert-sonypi-to-dynamic-input_dev-allocation.patch
-input-convert-driver-input-misc-to-dynamic-input_dev-allocation.patch
-drivers-input-joystick-convert-to-dynamic-input_dev-allocation.patch
-drivers-media-convert-to-dynamic-input_dev-allocation.patch
-input-show-sysfs-path-in-proc-bus-input-devices.patch
-input-export-input_dev-data-via-sysfs-attributes.patch
-input-core-implement-class-hierachy.patch
-input-core-implement-class-hierachy-hdaps-fixes.patch
-input-core-remove-custom-made-hotplug-handler.patch
-input-convert-input-handlers-to-class-interfaces.patch
-input-convert-to-seq_file.patch
-ide-fix-null-request-pointer-for-taskfile-ioctl.patch

 Merged

+proc_task_root_link-c99-fix.patch
+lpfc-build-fix.patch

 old gcc fixes
 
+hostap-fix-kbuild-warning.patch

 Wrongly fix Kconfig screwup

+reboot-comment-and-factor-the-main-reboot-functions.patch
+suspend-cleanup-calling-of-power-off-methods.patch

 Power management fixes

+pci_fixup_parent_subordinate_busnr-fixes.patch

 PCI enumeration fix

+kdumpx86-add-note-type-nt_kdumpinfo-to-kernel-core-dumps.patch

 kdump feature

+acpi-handle-fadt-20-xpmtmr-address-0-case.patch

 ACPI pm_timer fix

+update-maintainers-list-with-the-kprobes-maintainers.patch

 MAINAINERS update

+v9fs-make-conv-functions-to-check-for-conv-buffer-overflow.patch
+v9fs-allocate-the-rwalk-qid-array-from-the-right-conv-buffer.patch
+v9fs-make-copy-of-the-transport-prototype-instead-of-using-it-directly.patch
+v9fs-replace-strlen-on-newly-allocated-by-__getname-buffers-to-path_max.patch
+v9fs-dont-free-root-dentry-inode-if-error-occurs-in-v9fs_get_sb.patch

 v9fs updates

+ppc64-smu-driver-update-i2c-support.patch
+ppc64-smu-driver-update-i2c-support-fix.patch

 Big update tp pmac platform driver

+acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549-update.patch

 Fix acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549.patch

+cs5535-audio-alsa-driver.patch
+cleanup-for-cs5535-audio-driver.patch

 New audio driver

+gregkh-driver-driver-ide-tape-sysfs.patch
+gregkh-driver-driver-fix-bus_rescan_devices.patch
+gregkh-driver-driver-device_is_registered.patch
+gregkh-driver-driver-fix-class-symlinks.patch

 Driver tree updates

+drm_addmap_ioctl-warning-fix.patch

 drm warning fix

+gregkh-i2c-i2c-maintainer.patch
+gregkh-i2c-hwmon-adm9240-update-01.patch
+gregkh-i2c-hwmon-adm9240-update-02.patch
+gregkh-i2c-hwmon-via686a-save-memory.patch

 i2c tree updates

+fix-broken-nvidia-device-id-in-sata_nv.patch

 SATA driver fix

+gregkh-pci-pci-remove-unused-scratch.patch
+gregkh-pci-pci-kzalloc.patch
+gregkh-pci-pci-fix-probe-warning.patch
+gregkh-pci-pci-buffer-overrun-rpaldpar.patch

 PCI tree updates

+areca-raid-linux-scsi-driver-update.patch

 Update areca-raid-linux-scsi-driver.patch

-scsi-sas-makefile-and-kconfig.patch
-sas_class-include-files-in-include-scsi-sas.patch
-sas-class-core-files.patch
-aic94xx-the-aic94xx-sas-lldd.patch
+git-sas.patch

 Adaptec Serial Attached Storage tree

+gregkh-usb-ub-burn-cd-fix.patch
+gregkh-usb-usb-option-new-ids.patch
+gregkh-usb-usb-ftdi_sio-baud-rate-change.patch
+gregkh-usb-usb-pxa2xx_udc-build-fix.patch
+gregkh-usb-usb-sl811-minor-fixes.patch
+gregkh-usb-devfs-remove-usb-mode.patch
+gregkh-usb-usb-handoff-merge.patch
+gregkh-usb-usb-power-state-01.patch
+gregkh-usb-usb-power-state-02.patch
+gregkh-usb-usb-power-state-03.patch
+gregkh-usb-usb-power-state-04.patch
+gregkh-usb-usb-power-state-05.patch
+gregkh-usb-usb-uhci-01.patch
+gregkh-usb-usb-uhci-02.patch
+gregkh-usb-usb-gotemp.patch

 USB tree updates

+gregkh-usb-usb-power-state-03-fix.patch
+gregkh-usb-usb-handoff-merge-usb-Makefile-fix.patch
+pegasus-ethernet-over-usb-driver-fixes.patch
+st5481_usb-build-fix.patch

 Various USB fixes and enhancements

+x86_64-defconfig-update.patch
-x86_64-dma32-iommu.patch
-x86_64-dma32-srat32.patch
-x86_64-vm-holes-reserved.patch
+x86_64-dma32-srat32.patch
+x86_64-vm-holes-reserved.patch
+x86_64-hpet-regs.patch
+x86_64-no-idle-tick.patch
+x86_64-nohpet.patch
+x86_64-mce-thresh.patch
+x86_64-pat-base.patch

 Various x86_64 tree updates

+x86_64-no-idle-tick-fix.patch
+x86_64-no-idle-tick-fix-2.patch
+x86_64-mce-thresh-fix.patch
+x86_64-mce-thresh-fix-2.patch

 Fix them up.

+mm-move_pte-to-remap-zero_page-fix.patch

 Fix mm-move_pte-to-remap-zero_page.patch

+eeproc-module_param_array-cleanup.patch
+b44-fix-suspend-resume.patch
+r8169-call-proper-vlan-receive-function.patch

 net driver updates

+ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support.patch
+ppc32-ifdef-out-altivec-specific-code-in-__switch_to.patch
+ppc32-handle-access-to-non-present-io-ports-on-8xx.patch

 ppc32 updates

+x86-initialise-tss-io_bitmap_owner-to-something.patch
+intel_cacheinfo-remove-max_cache_leaves-limit.patch
+i386-little-pgtableh-consolidation-vs-2-3level.patch
+x86-hot-plug-cpu-to-support-physical-add-of-new-processors.patch

 x86 updates

+x86_64-dont-use-shortcut-when-using-send_ipi_all-in-flat-mode.patch
+x86_64-init-and-zap-low-address-mappings-on-demand-for-cpu-hotplug.patch

 More x86_64 updates

+introduce-valid-callback-for-pm_ops.patch

 Power management fixlet

+uml-dont-remove-umid-files-in-conflict-case.patch
+strlcat-use-for-uml-umidc.patch
+uml-dont-redundantly-mark-pte-as-newpage-in-pte_modify.patch
+uml-fix-hang-in-tt-mode-on-fault.patch
+uml-fix-condition-in-tlb-flush.patch
+uml-run-mconsole-sysrq-in-process-context.patch
+uml-avoid-fixing-faults-while-atomic.patch
+uml-fix-gfp_-flags-usage.patch
+uml-use-gfp_atomic-for-allocations-under-spinlocks.patch
+uml-replace-printk-with-stack-friendly-printf-to-report-console-failure.patch

 UML updates

+xtensa-remove-io_remap_page_range-and-minor-clean-ups.patch

 xtensa fix

+cm4040-cardman-4040-driver-update.patch
+cm4000-cardman-4000-driver-update.patch

 Update the cardman pcmcia drivers in -mm.

-invalidate_inode_pages2_range-clean-pages-fix.patch

 Wrong, dropped.

+ext3-ext_debug-build-fixes.patch

 ext3 fixlet

+fix-bd_claim-error-code.patch

 swapon() return code fix

+reiserfs-free-checking-cleanup.patch

 reiserfs cleanup

+remove-hardcoded-send_sig_xxx-constants.patch
+cleanup-the-usage-of-send_sig_xxx-constants.patch

 Use the #defines

+little-de_thread-cleanup.patch
+introduce-setup_timer-helper.patch
+introduce-setup_timer-helper-x86_64-fix.patch
+move-tasklist-walk-from-cfq-iosched-to-elevatorc.patch

 Various code cleanups

+add-kthread_stop_sem.patch

 New workqueue featurette

+switch-sibyte-profiling-driver-to-compat_ioctl.patch
+switch-sibyte-profiling-driver-to-compat_ioctl-fix.patch
+remove-drm-ioctl32-translations-from-sparc-and-parisc.patch
+tioc-compat-ioctl-handling.patch

 ioctl() cleanups

+ntp-shift_right-cleanup.patch

 NTP cleanup

+delete-2-unreachable-statements-in-drivers-block-paride-pfc.patch
+clarify-help-text-for-init_env_arg_limit.patch
+moving-kprobes-and-oprofile-to-instrumentation-support-menu.patch

 Little fixes

+keys-add-possessor-permissions-to-keys.patch

 Key management enhancement

+fat-cleanup-and-optimization-of-checksum.patch
+fat-remove-the-unneeded-vfat_find-in-vfat_rename.patch
+fat-remove-duplicate-directory-scanning-code.patch

 fatfs updates

+i4l-update-hfc_usb-driver.patch

 ISDN driver update

+pcmcia-use-runtime-suspend-resume-support-to-unify-all-suspend-code-paths-fix.patch

 Fix pcmcia-use-runtime-suspend-resume-support-to-unify-all-suspend-code-paths.patch

+pcmcia-yenta-add-support-for-more-ti-bridges.patch
+pcmcia-yenta-optimize-interrupt-handler.patch

 Cardbus driver updates

+sched-modified-nice-support-for-smp-load-balancing.patch

 CPU scheduler improvement

+reiser4-ver_linux-dont-print-reiser4progs-version-if-none-found.patch
+reiser4-atime-update-fix.patch
+reiser4-use-try_to_freeze.patch

 reiser4 fixes

+ide-move-config_ide_max_hwifs-into-linux-ideh.patch

 IDE cleanup

+add-dm-snapshot-tutorial-in-documentation.patch

 Devicemapper documentation

+documentation-ioctl-messtxt-start-annotating-i-o.patch

 Updates to ioctl documentation

+tty-layer-buffering-revamp-icom-fixes.patch
+tty-layer-buffering-revamp-isdn-layer.patch
+driver-char-n_hdlcc-remove-unused-declaration.patch

 More tty layer fallout fixes




All 484 patches:



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm1/patch-list


