Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVEEFNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVEEFNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 01:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVEEFNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 01:13:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:41619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261888AbVEEFL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 01:11:28 -0400
Date: Wed, 4 May 2005 22:10:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc3-mm3
Message-Id: <20050504221057.1e02a402.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/

- device mapper updates

- more UML updates

- -mm seems unusually stable at present.



Changes since 2.6.12-rc3-mm2:


-ultrastor-build-fix.patch
-bk-driver-core-sn2-build-fix.patch
-jfs-reduce-number-of-synchronous-transactions.patch
-jfs-simplify-creation-of-new-iag.patch
-jfs-changes-for-larger-page-size.patch
-jfs-support-page-sizes-greater-than-4k.patch
-jfs-write-journal-sync-points-more-often.patch
-jfs-dont-allocate-extents-that-overlap-existing-extents.patch
-acpi-bridge-hotadd-acpi-based-root-bridge-hot-add.patch
-acpi-bridge-hotadd-fix-pci_enable_device-for-p2p-bridges.patch
-acpi-bridge-hotadd-make-pcibios_fixup_bus-hot-plug-safe.patch
-acpi-bridge-hotadd-prevent-duplicate-bus-numbers-when-scanning-pci-bridge.patch
-acpi-bridge-hotadd-take-the-pci-lock-when-modifying-pci-bus-or-device-lists.patch
-acpi-bridge-hotadd-link-newly-created-pci-child-bus-to-its-parent-on-creation.patch
-acpi-bridge-hotadd-make-the-pci-remove-routines-safe-for-failed-hot-plug.patch
-acpi-bridge-hotadd-remove-hot-plugged-devices-that-could-not-be-allocated-resources.patch
-acpi-bridge-hotadd-read-bridge-resources-when-fixing-up-the-bus.patch
-acpi-bridge-hotadd-allow-acpi-add-and-start-operations-to-be-done-independently.patch
-acpi-bridge-hotadd-export-the-interface-to-get-pci-id-for-an-acpi-handle.patch
-acpi-based-i-o-apic-hot-plug-add-interfaces.patch
-acpi-based-i-o-apic-hot-plug-ia64-support.patch
-acpi-based-i-o-apic-hot-plug-acpiphp-support.patch
-mptfusion-fix-panic-loading-driver-statically-com.patch
-generic_file_buffered_write-fixes.patch
-rlimit_as-checking-fix.patch
-mm-add-proc-zoneinfo-tidy.patch
-mm-rmapc-cleanup.patch
-mm-pcp-use-non-powers-of-2-for-batch-size.patch
-mempool-nomemalloc-and-noretry.patch
-mempool-simplify-alloc.patch
-mempool-simplify-alloc-fix.patch
-mm-use-__gfp_nomemalloc.patch
-doc-locking-update.patch
-count-bounce-buffer-pages-in-vmstat.patch
-rlimit_memlock-checking-fix.patch
-sync_page-smp_mb-comment.patch
-add-kmalloc_node-inline-cleanup.patch
-mpage_writepages-page-locking-fix.patch
-drop-buffers-oops-fix.patch
-selinux-cleanup-ipc_has_perm.patch
-selinux-add-finer-grained-permissions-to-netlink-audit.patch
-ppc32-fix-errata-for-some-g3-cpus.patch
-ppc32-refactor-fpu-exception-handling-2.patch
-ppc32-fix-for-misreported-sdram-size-on-radstone-ppc7d-platform.patch
-ppc32-add-rtc-hooks-in-ppc7d-platform-file.patch
-ppc32-fix-ide-related-crash-on-wakeup.patch
-macintosh-adbhidc-adb-buttons-support-for.patch
-ppc32-fix-a-sleep-issues-on-some-laptops.patch
-ppc32-fix-address-checking-on-lmw-stmw-align-exception.patch
-ppc32-workaround-for-spurious-irqs-on-pq2.patch
-ppc64-improve-g5-sound-headphone-mute.patch
-ppc32-add-sound-support-for-mac-mini.patch
-pmac-save-master-volume-on-sleep.patch
-ppc64-add-pt_note-section-to-vdso.patch
-ppc64-remove-unused-argument-to-create_slbe.patch
-ppc64-fix-irq-parsing-on-powermac.patch
-ppc64-nvram-cleanups.patch
-ppc64-update-to-use-the-new-4l-headers.patch
-ppc64-tell-firmware-about-kernel-capabilities.patch
-ppc64-remove-hot-busy-wait-loop-in-__hash_page.patch
-ppc64-noexec-fixes.patch
-ppc64-remove-unnecessary-include.patch
-ppc64-firmware-workaround.patch
-ppc64-enforce-medium-thread-priority-in-hypervisor-calls.patch
-ppc64-use-smp_mb-and-smp_wmb.patch
-use-smp_mb-wmb-rmb-where-possible.patch
-ppc64-reverse-prediction-on-spinlock-busy-loop-code.patch
-fix-i386-memcpy.patch
-i386-x86_64-segment-register-access-update.patch
-rfc-check-nmi-watchdog-is-broken.patch
-rfc-check-nmi-watchdog-is-broken-fix.patch
-x86-reboot-add-reboot-fixup-for-gx1-cs5530a.patch
-x86-entrys-trap-return-fixes.patch
-enable-write-combining-for-server-works-le-rev-6.patch
-cpuid-bug-and-inconsistency-fix.patch
-i386-fix-hpet-for-systems-that-dont-support.patch
-irq-and-pci_ids-for-intel-ich7dh-ich7-m-dh.patch
-hda_intel-intel-esb2-support.patch
-cpuid-x87-bit-on-amd-falsely-marked-as-pni.patch
-x86_64-interrupt-handling-fix.patch
-increase-number-of-e820-entries-hard-limit-from-32-to-128.patch
-broadcast-ipi-race-condition-on-cpu-hotplug.patch
-linux-26x-vm86-interrupt-emulation-fixes.patch
-x86-64-handle-empty-e820-regions-correctly.patch
-x86-cacheline-alignment-for-cpu-maps.patch
-x86_64-saved_command_line-overflow-fix.patch
-hp100-fix-card-names.patch
-uml-fix-oops-related-to-exception-table.patch
-uml-add-nfsd-syscall-when-nfsd-is-modular.patch
-uml-fix-handling-of-no-fpx_regs.patch
-uml-workaround-old-problematic-sed-behaviour.patch
-uml-support-aes-i586-crypto-driver.patch
-uml-inline-empty-proc.patch
-uml-move-va_copy-conditional-def.patch
-uml-fix-syscall-table-by-including-subarchs-one-for-i386.patch
-uml-quick-fix-syscall-table-for-x86_64.patch
-uml-fix-syscall-table-by-including-subarchs-one-for-x86-64.patch
-uml-redo-console-locking.patch
-uml-hostfs-avoid-buffers.patch
-uml-commentary-about-forking-flag.patch
-uml-ubd-handle-readonly-status.patch
-s390-regenerate-defconfig.patch
-s390-idle-timer-setup.patch
-s390-fix-memory-holes-and-cleanup-setup_arch.patch
-s390-default-storage-key.patch
-s390-cmm-guest-sender-id.patch
-s390-allow-longer-debug-feature-names.patch
-s390-dasd-readonly-attribute.patch
-s390-enable-write-barriers-in-the-dasd-driver.patch
-s390-dont-pad-cdl-blocks-for-write-requests.patch
-s390-remove-ioctl32-from-dasdcmb.patch
-s390-remove-ioctl32-from-crypto-driver.patch
-s390-cio-documentation.patch
-nice-and-rt-prio-rlimits.patch
-remove-all-kernel-bugs.patch
-exterminate-page_bug.patch
-clean-up-kernel-messages.patch
-move-sa_xxx-defines-to-linux-signalh.patch
-procfs-fix-hardlink-counts.patch
-procfs-fix-hardlink-counts-for-proc-pid-task.patch
-kernel-rcupdatec-make-the-exports-export_symbol_gpl.patch
-add-deprecated_for_modules.patch
-add-deprecated_for_modules-fix.patch
-deprecate-synchronize_kernel-gpl-replacement.patch
-deprecate-synchronize_kernel-gpl-replacement-fix.patch
-change-synchronize_kernel-to-_rcu-and-_sched.patch
-update-rcu-documentation.patch
-reiserfs-make-resize-option-auto-get-new-device-size.patch
-lifeview-flytv-platinum-fm-remote-control-support.patch
-lifeview-flytv-platinum-fm-remote-control-support-fix.patch
-kallsyms-c_symbol_prefix-support.patch
-noop-iosched-kill-on-merge-scan.patch
-add-eownerdead-and-enotrecoverable-version-2.patch
-nbd-dont-create-all-max_nbd-devices-by-default-all-the-time.patch
-nbd-dont-create-all-max_nbd-devices-by-default-all-the-time-fix.patch
-fix-rewriting-on-a-full-reiserfs-filesystem.patch
-vgacon-set-vc_hi_font_mask-correctly.patch
-hangcheck-timer-update-to-090.patch
-w1_therm-support-for-ds18b20-ds1822-thermal-sensors.patch
-consolidate-sigev_pad_size.patch
-misc-verify_area-cleanups.patch
-__attribute__-placement-fixes.patch
-leadtek-winfast-remote-controls.patch
-fix-race-in-block_write_full_page.patch
-reiserfs-journal_init-fix.patch
-dontdiff-file-sorted-in-alphabet-order.patch
-ipmi-fix-for-handling-bad-dmi-data.patch
-ipmi-fix-for-handling-bad-acpi-data.patch
-ipmi-fix-watchdog-so-the-device-can-be-reopened-on-an-unexpected-close.patch
-ipmi-enable-interrupts-on-the-bt-driver.patch
-ipmi-fix-a-deadlock.patch
-sn_console-make-sal_console_uart-static-again.patch
-consolidate-sys_shmat.patch
-fix-tpm-driver-maintainers-entry.patch
-new-valid_signal-function.patch
-convert-code-that-currently-tests-_nsig-directly-to-use-valid_signal.patch
-fix-include-order-in-mthca_memfreec.patch
-serial_cs-reduce-stack-usage-in-serial_event.patch
-makefile-fix-for-compatibility-with-emacs-ctags.patch
-aio-remove-superfluous.patch
-aio-ring-tail.patch
-aio-remove-debug.patch
-aio-run-iocb.patch
-hfs-hfsplus-dont-leak-s_fs_info-and-fix-an-oops.patch
-autofs4-wait-order-fix.patch
-autofs4-tree-race-fix.patch
-autofs4-tree-race-fix-fix.patch
-autofs4-tree-race-fix-fix-fix.patch
-autofs4-bump-version-number.patch
-reiserfs-endianness-clone-struct-reiserfs_key.patch
-reiserfs-endianness-annotate-little-endian-objects.patch
-reiserfs-endianness-fix-endianness-bugs.patch
-reiserfs-endianness-comp_short_keys-cleanup.patch
-reiserfs-endianness-sanitize-reiserfs_key-union.patch
-cx88-dvb-oops-fix.patch
-dvb-cx22702-frontend-driver-update.patch
-v4l-msp3400-update.patch
-ext3-remove-unnecessary-race-then-retry-in-ext3_get_block.patch
-ext3-remove-unnecessary-race-then-retry-in-ext3_get_block-leak-fix.patch
-saa7134-add-oem-version-of-already-supported-card.patch
-altix-ioc4-serial-set-hfc-from-ioctl.patch
-altix-ioc4-serial-set-a-better-timeout-threshold.patch
-altix-ioc4-serial-small-uart-setup-mods.patch
-altix-ioc4-serial-arm-the-read-timeout-timer-before-the-first-read.patch
-fbdev-batch-cmap-changes-at-driver-level.patch
-nvidiafb-ioremap-and-i2c-fixes.patch
-nvidiafb-ioremap-and-i2c-fixes-fix.patch
-fbdev-edidh-cleanups.patch
-fbcon-fix-check-after-use.patch
-intelfb-remove-intelfbdrvh.patch
-i810fb-fix-default-monitor-sync-timings.patch
-imxfb-add-freescale-imx-framebuffer-driver.patch
-better-pll-frequency-matching-for-tdfxfb-driver.patch
-clean-up-and-bug-fix-for-tdfxfb-framebuffer-size-detection.patch
-docbook-changes-and-extensions-to-the-kernel-documentation.patch
-docbook-fix-void-xml-tag.patch
-docbook-fix-some-descriptions.patch
-docbook-use-informalexample-for-examples.patch
-docbook-remove-obsolete-templates.patch
-docbook-use-xmlto-to-process-the-docbook-files.patch
-docbook-use-custom-stylesheet.patch
-docbook-fix-html-link.patch
-docbook-tell-users-to-install-xmlto-not-stylesheets.patch
-documentation-remove-super-nr-max-to-reflect-fs-superc.patch
-drivers-isdn-divert-isdn_divertc-make-5-functions-static.patch
-drivers-isdn-capi-make-some-code-static.patch
-drivers-scsi-pas16c-make-code-static.patch
-i386-x86_64-early_printkc-make-early_serial_base-static.patch
-kernel-exitc-make-exit_mm-static.patch
-drivers-serial-jsm-make-2-functions-static.patch
-arch-i386-kernel-cpu-mtrr-genericc-make-generic_get_mtrr-static.patch
-drivers-serial-8250c-make-a-variable-static.patch
-drivers-media-video-bttv-driverc-make-2-functions-static.patch
-drivers-media-video-cx88-possible-cleanups.patch
-drivers-media-video-saa7134-saa7134-dvbc-make-a-struct-static.patch
-drivers-char-agp-make-code-static.patch
-drivers-char-rio-rio_linuxc-make-a-variable-static.patch
-drivers-char-stallionc-make-a-function-static.patch
-drivers-pnp-pnpbios-rsparserc-fix-an-array-overflow.patch
-drivers-video-radeonfbc-fix-an-array-overflow.patch
-drivers-pnp-pnpacpi-rsparserc-fix-an-array-overflow.patch
-drivers-input-joystick-spaceorbc-fix-an-array-overflow.patch
-sound-oss-sonicvibesc-fix-an-array-overflow.patch

 Merged upstream

+avoid-enomem-due-reclaimable-slab-caches.patch

 VFS slab reclaim accounting fix

-gregkh-01-driver-gregkh-driver-001_driver-name-const-01.patch
-gregkh-01-driver-gregkh-driver-002_driver-name-const-02.patch
-gregkh-01-driver-gregkh-driver-003_driver-name-const-03.patch
-gregkh-01-driver-gregkh-driver-004_driver-name-const-04.patch
-gregkh-01-driver-gregkh-driver-005_driver-name-const-05.patch
-gregkh-01-driver-gregkh-driver-006_class-01-core.patch
-gregkh-01-driver-gregkh-driver-007_class-02-tty.patch
-gregkh-01-driver-gregkh-driver-008_class-03-input.patch
-gregkh-01-driver-gregkh-driver-009_class-04-usb.patch
-gregkh-01-driver-gregkh-driver-010_class-05-sound.patch
-gregkh-01-driver-gregkh-driver-011_class-06-block.patch
-gregkh-01-driver-gregkh-driver-012_class-07-char.patch
-gregkh-01-driver-gregkh-driver-013_class-08-ieee1394.patch
-gregkh-01-driver-gregkh-driver-014_class-09-scsi.patch
-gregkh-01-driver-gregkh-driver-015_class-10-arch.patch
-gregkh-01-driver-gregkh-driver-016_class-11-drivers.patch
-gregkh-01-driver-gregkh-driver-017_class-12-the_rest.patch
-gregkh-01-driver-gregkh-driver-018_class-13-kerneldoc.patch
-gregkh-01-driver-gregkh-driver-019_class-14-no_more_class_simple.patch
-gregkh-01-driver-gregkh-driver-020_class-15-typo-01.patch
-gregkh-01-driver-gregkh-driver-021_class-16-typo-02.patch
-gregkh-01-driver-gregkh-driver-022_class-17-attribute.patch
-gregkh-01-driver-gregkh-driver-023_klist-01.patch
-gregkh-01-driver-gregkh-driver-024_klist-02.patch
-gregkh-01-driver-gregkh-driver-025_klist-03.patch
-gregkh-01-driver-gregkh-driver-026_klist-04.patch
-gregkh-01-driver-gregkh-driver-027_klist-05.patch
-gregkh-01-driver-gregkh-driver-028_klist-06.patch
-gregkh-01-driver-gregkh-driver-029_klist-07.patch
-gregkh-01-driver-gregkh-driver-030_klist-08.patch
-gregkh-01-driver-gregkh-driver-031_klist-09.patch
-gregkh-01-driver-gregkh-driver-032_klist-10.patch
-gregkh-01-driver-gregkh-driver-033_klist-11.patch
-gregkh-01-driver-gregkh-driver-034_klist-12.patch
-gregkh-01-driver-gregkh-driver-035_klist-13.patch
-gregkh-01-driver-gregkh-driver-036_klist-14.patch
-gregkh-01-driver-gregkh-driver-037_klist-15.patch
-gregkh-01-driver-gregkh-driver-038_klist-16.patch
-gregkh-01-driver-gregkh-driver-039_klist-17.patch
-gregkh-01-driver-gregkh-driver-040_klist-18.patch
-gregkh-01-driver-gregkh-driver-041_klist-scsi-01.patch
-gregkh-01-driver-gregkh-driver-042_klist-scsi-02.patch
-gregkh-01-driver-gregkh-driver-043_klist-20.patch
-gregkh-01-driver-gregkh-driver-044_klist-21.patch
-gregkh-01-driver-gregkh-driver-045_klist-22.patch
-gregkh-01-driver-gregkh-driver-046_klist-23.patch
-gregkh-01-driver-gregkh-driver-047_klist-ieee1394.patch
-gregkh-01-driver-gregkh-driver-048_klist-pcie.patch
-gregkh-01-driver-gregkh-driver-049_klist-24.patch
-gregkh-01-driver-gregkh-driver-050_klist-25.patch
-gregkh-01-driver-gregkh-driver-051_klist-26.patch
-gregkh-01-driver-gregkh-driver-052_klist-usb_node_attached_fix.patch
+gregkh-01-driver-gregkh-driver-001_driver-hotplug_check.patch
+gregkh-01-driver-gregkh-driver-002_debugfs_simple_newline.patch
+gregkh-01-driver-gregkh-driver-009_driver-name-const-01.patch
+gregkh-01-driver-gregkh-driver-010_driver-name-const-02.patch
+gregkh-01-driver-gregkh-driver-011_driver-name-const-03.patch
+gregkh-01-driver-gregkh-driver-012_driver-name-const-04.patch
+gregkh-01-driver-gregkh-driver-013_driver-name-const-05.patch
+gregkh-01-driver-gregkh-driver-014_driver-name-const-06.patch
+gregkh-01-driver-gregkh-driver-015_sysfs-show_store_eio-01.patch
+gregkh-01-driver-gregkh-driver-016_sysfs-show_store_eio-02.patch
+gregkh-01-driver-gregkh-driver-017_sysfs-show_store_eio-03.patch
+gregkh-01-driver-gregkh-driver-018_sysfs-show_store_eio-04.patch
+gregkh-01-driver-gregkh-driver-019_sysfs-show_store_eio-05.patch
+gregkh-01-driver-gregkh-driver-020_class-01-core.patch
+gregkh-01-driver-gregkh-driver-021_class-02-tty.patch
+gregkh-01-driver-gregkh-driver-022_class-03-input.patch
+gregkh-01-driver-gregkh-driver-023_class-04-usb.patch
+gregkh-01-driver-gregkh-driver-024_class-05-sound.patch
+gregkh-01-driver-gregkh-driver-025_class-06-block.patch
+gregkh-01-driver-gregkh-driver-026_class-07-char.patch
+gregkh-01-driver-gregkh-driver-027_class-08-ieee1394.patch
+gregkh-01-driver-gregkh-driver-028_class-09-scsi.patch
+gregkh-01-driver-gregkh-driver-029_class-10-arch.patch
+gregkh-01-driver-gregkh-driver-030_class-11-drivers.patch
+gregkh-01-driver-gregkh-driver-031_class-11-drivers-usb-fix.patch
+gregkh-01-driver-gregkh-driver-032_class-12-the_rest.patch
+gregkh-01-driver-gregkh-driver-033_class-13-kerneldoc.patch
+gregkh-01-driver-gregkh-driver-034_class-14-no_more_class_simple.patch
+gregkh-01-driver-gregkh-driver-035_class-15-typo-01.patch
+gregkh-01-driver-gregkh-driver-036_class-16-typo-02.patch
+gregkh-01-driver-gregkh-driver-037_class-17-attribute.patch
+gregkh-01-driver-gregkh-driver-038_klist-01.patch
+gregkh-01-driver-gregkh-driver-039_klist-02.patch
+gregkh-01-driver-gregkh-driver-040_klist-03.patch
+gregkh-01-driver-gregkh-driver-041_klist-04.patch
+gregkh-01-driver-gregkh-driver-042_klist-05.patch
+gregkh-01-driver-gregkh-driver-043_klist-06.patch
+gregkh-01-driver-gregkh-driver-044_klist-07.patch
+gregkh-01-driver-gregkh-driver-045_klist-08.patch
+gregkh-01-driver-gregkh-driver-046_klist-09.patch
+gregkh-01-driver-gregkh-driver-047_klist-10.patch
+gregkh-01-driver-gregkh-driver-048_klist-11.patch
+gregkh-01-driver-gregkh-driver-049_klist-12.patch
+gregkh-01-driver-gregkh-driver-050_klist-13.patch
+gregkh-01-driver-gregkh-driver-051_klist-14.patch
+gregkh-01-driver-gregkh-driver-052_klist-15.patch
+gregkh-01-driver-gregkh-driver-053_klist-16.patch
+gregkh-01-driver-gregkh-driver-054_klist-17.patch
+gregkh-01-driver-gregkh-driver-055_klist-18.patch
+gregkh-01-driver-gregkh-driver-056_klist-scsi-01.patch
+gregkh-01-driver-gregkh-driver-057_klist-scsi-02.patch
+gregkh-01-driver-gregkh-driver-058_klist-20.patch
+gregkh-01-driver-gregkh-driver-059_klist-21.patch
+gregkh-01-driver-gregkh-driver-060_klist-22.patch
+gregkh-01-driver-gregkh-driver-061_klist-23.patch
+gregkh-01-driver-gregkh-driver-062_klist-ieee1394.patch
+gregkh-01-driver-gregkh-driver-063_klist-pcie.patch
+gregkh-01-driver-gregkh-driver-064_klist-24.patch
+gregkh-01-driver-gregkh-driver-065_klist-25.patch
+gregkh-01-driver-gregkh-driver-066_klist-26.patch
+gregkh-01-driver-gregkh-driver-067_klist-usb_node_attached_fix.patch
+gregkh-01-driver-gregkh-driver-068_klist-sn_fix.patch

 Some of this was merged and some of it was randomly renamed.

+fix-make-mandocs-after-class_simplec-removal.patch

 kerneldoc fix

+gregkh-02-i2c-gregkh-i2c-003_w1-ds18xx_sensors.patch
+gregkh-02-i2c-gregkh-i2c-004_w1-new_rom_family.patch
+gregkh-02-i2c-gregkh-i2c-005_i2c-rtc8564_duplicate_include.patch
+gregkh-02-i2c-gregkh-i2c-006_i2c-vid_h.patch
+gregkh-02-i2c-gregkh-i2c-007_i2c-atxp1.patch
+gregkh-02-i2c-gregkh-i2c-008_i2c-atxp1-cleanup.patch
+gregkh-02-i2c-gregkh-i2c-009_i2c-ds1337-01.patch
+gregkh-02-i2c-gregkh-i2c-010_i2c-ds1337-02.patch
+gregkh-02-i2c-gregkh-i2c-011_i2c-ds1337-03.patch
+gregkh-02-i2c-gregkh-i2c-012_i2c-config_cleanup-01.patch
+gregkh-02-i2c-gregkh-i2c-013_i2c-config_cleanup-02.patch
+gregkh-02-i2c-gregkh-i2c-014_i2c-ali1563.patch
+gregkh-02-i2c-gregkh-i2c-015_i2c-adm9240.patch
+gregkh-02-i2c-gregkh-i2c-016_i2c-w83627ehf.patch
+gregkh-02-i2c-gregkh-i2c-017_i2c-w83627ehf-cleanup.patch
+gregkh-02-i2c-gregkh-i2c-018_i2c-smsc47m1.patch
+gregkh-02-i2c-gregkh-i2c-019_i2c-spelling_fixes.patch
+gregkh-02-i2c-gregkh-i2c-020_i2c-mpc-share_interrupt.patch

 i2c updates

-bk-kbuild.patch
-bk-kbuild-cvs-fixes.patch

 Dropped

-gregkh-03-pci-gregkh-pci-001_pci-is_enabled_fix.patch
-gregkh-03-pci-gregkh-pci-002_pci-pci_get_slot-docs.patch
-gregkh-03-pci-gregkh-pci-003_pci-stale_pm_docs.patch
-gregkh-03-pci-gregkh-pci-004_pci-sparse_cleanup.patch
-gregkh-03-pci-gregkh-pci-005_pci-sysfs-pciconfig-readwrite.patch
-gregkh-03-pci-gregkh-pci-006_pci_shutdown.patch
-gregkh-03-pci-gregkh-pci-007_pci-ibmphp-bugfix.patch
-gregkh-03-pci-gregkh-pci-008_pci-hance_quirk.patch
-gregkh-03-pci-gregkh-pci-009_pci-pci-transparent-bridge-handling-improvements-pci-core.patch
-gregkh-03-pci-gregkh-pci-010_pci-pirq_table_addr-out-of-range.patch
-gregkh-03-pci-gregkh-pci-011_pci-get_device-01.patch
-gregkh-03-pci-gregkh-pci-012_pci-get_device-02.patch
-gregkh-03-pci-gregkh-pci-013_pci-acpiphp-01.patch
-gregkh-03-pci-gregkh-pci-014_pci-acpiphp-02.patch
-gregkh-03-pci-gregkh-pci-015_pci-acpiphp-03.patch
-gregkh-03-pci-gregkh-pci-016_pci-acpiphp-04.patch
-gregkh-03-pci-gregkh-pci-017_pci-acpiphp-05.patch
+gregkh-03-pci-gregkh-pci-012_pci-pci-transparent-bridge-handling-improvements-pci-core.patch
+gregkh-03-pci-gregkh-pci-013_pci-pirq_table_addr-out-of-range.patch
+gregkh-03-pci-gregkh-pci-014_pci-get_device-01.patch
+gregkh-03-pci-gregkh-pci-015_pci-get_device-02.patch
+gregkh-03-pci-gregkh-pci-016_pci-acpiphp-02.patch
+gregkh-03-pci-gregkh-pci-017_pci-acpiphp-03.patch
+gregkh-03-pci-gregkh-pci-018_pci-acpiphp-04.patch
+gregkh-03-pci-gregkh-pci-019_pci-acpiphp-05.patch
+gregkh-03-pci-gregkh-pci-020_pci-acpiphp-06.patch
+gregkh-03-pci-gregkh-pci-021_pci-acpiphp-07.patch
+gregkh-03-pci-gregkh-pci-022_pci-acpiphp-08.patch
+gregkh-03-pci-gregkh-pci-023_pci-acpiphp-09.patch
+gregkh-03-pci-gregkh-pci-024_pci-acpiphp-10.patch
+gregkh-03-pci-gregkh-pci-025_pci-acpiphp-11.patch
+gregkh-03-pci-gregkh-pci-026_pci-acpiphp-12.patch
+gregkh-03-pci-gregkh-pci-027_pci-acpiphp-13.patch
+gregkh-03-pci-gregkh-pci-028_pci-acpiphp-14.patch
+gregkh-03-pci-gregkh-pci-029_pci-acpiphp-15.patch
+gregkh-03-pci-gregkh-pci-030_pci-acpiphp-16.patch
+gregkh-03-pci-gregkh-pci-031_pci-acpiphp-17.patch
+gregkh-03-pci-gregkh-pci-032_pci-acpiphp-18.patch
+gregkh-03-pci-gregkh-pci-033_pci-acpiphp-19.patch
+gregkh-03-pci-gregkh-pci-034_pci-acpiphp-20.patch

 Some mergings, some renamings, some new stuff.

-gregkh-04-USB-gregkh-usb-015_usb-storage_build_fix.patch
-gregkh-04-USB-gregkh-usb-018_usb-airprime.patch
-gregkh-04-USB-gregkh-usb-019_usb-airprime-num_devices.patch
-gregkh-04-USB-gregkh-usb-020_usb-g_file_storage_min.patch
-gregkh-04-USB-gregkh-usb-021_usb-g_file_storage_stall.patch
-gregkh-04-USB-gregkh-usb-022_usb-ehci_power_fixes.patch
-gregkh-04-USB-gregkh-usb-023_usb-omap_udc_update.patch
-gregkh-04-USB-gregkh-usb-024_usb-isp116x-hcd-add.patch
-gregkh-04-USB-gregkh-usb-025_usb-isp116x-hcd-fix.patch
-gregkh-04-USB-gregkh-usb-026_usb-turn-a-user-mode-driver-error-into-a-hard-error.patch
-gregkh-04-USB-gregkh-usb-027_usb-uhci-01.patch
-gregkh-04-USB-gregkh-usb-028_usb-uhci-02.patch
-gregkh-04-USB-gregkh-usb-029_usb-uhci-03.patch
-gregkh-04-USB-gregkh-usb-030_usb-uhci-04.patch
-gregkh-04-USB-gregkh-usb-031_usb-uhci-05.patch
-gregkh-04-USB-gregkh-usb-032_usb-uhci-06.patch
-gregkh-04-USB-gregkh-usb-033_usb-uhci-07.patch
-gregkh-04-USB-gregkh-usb-034_usb-root_hub_irq.patch
-gregkh-04-USB-gregkh-usb-035_usb-cdc_acm.patch
-gregkh-04-USB-gregkh-usb-036_usb-usbtest.patch
-gregkh-04-USB-gregkh-usb-037_usb-ohci_reboot_notifier.patch
-gregkh-04-USB-gregkh-usb-038_usb_serial_status.patch
-gregkh-04-USB-gregkh-usb-039_usb-zd1201_pm.patch
-gregkh-04-USB-gregkh-usb-040_usb-remove_hub_set_power_budget.patch
-gregkh-04-USB-gregkh-usb-041_usb-device_pointer.patch
-gregkh-04-USB-gregkh-usb-042_usb-hcd_fix_for_remove_hub_set_power_budget.patch
-gregkh-04-USB-gregkh-usb-043_usb-usbcore_usb_add_hcd.patch
-gregkh-04-USB-gregkh-usb-044_usb-hcds_no_more_register_root_hub.patch
+gregkh-04-USB-gregkh-usb-011_usb-g_file_storage_min.patch
+gregkh-04-USB-gregkh-usb-012_usb-g_file_storage_stall.patch
+gregkh-04-USB-gregkh-usb-013_usb-omap_udc_update.patch
+gregkh-04-USB-gregkh-usb-014_usb-isp116x-hcd-add.patch
+gregkh-04-USB-gregkh-usb-015_usb-isp116x-hcd-fix.patch
+gregkh-04-USB-gregkh-usb-016_usb-turn-a-user-mode-driver-error-into-a-hard-error.patch
+gregkh-04-USB-gregkh-usb-017_usb-uhci-01.patch
+gregkh-04-USB-gregkh-usb-018_usb-uhci-02.patch
+gregkh-04-USB-gregkh-usb-019_usb-uhci-03.patch
+gregkh-04-USB-gregkh-usb-020_usb-uhci-04.patch
+gregkh-04-USB-gregkh-usb-021_usb-uhci-05.patch
+gregkh-04-USB-gregkh-usb-022_usb-uhci-06.patch
+gregkh-04-USB-gregkh-usb-023_usb-uhci-07.patch
+gregkh-04-USB-gregkh-usb-024_usb-uhci-08.patch
+gregkh-04-USB-gregkh-usb-025_usb-root_hub_irq.patch
+gregkh-04-USB-gregkh-usb-026_usb-cdc_acm.patch
+gregkh-04-USB-gregkh-usb-027_usb-usbtest.patch
+gregkh-04-USB-gregkh-usb-028_usb-ohci_reboot_notifier.patch
+gregkh-04-USB-gregkh-usb-029_usb_serial_status.patch
+gregkh-04-USB-gregkh-usb-030_usb-zd1201_pm.patch
+gregkh-04-USB-gregkh-usb-031_usb-zd1201_pm-02.patch
+gregkh-04-USB-gregkh-usb-032_usb-remove_hub_set_power_budget.patch
+gregkh-04-USB-gregkh-usb-033_usb-device_pointer.patch
+gregkh-04-USB-gregkh-usb-034_usb-hcd_fix_for_remove_hub_set_power_budget.patch
+gregkh-04-USB-gregkh-usb-035_usb-usbcore_usb_add_hcd.patch
+gregkh-04-USB-gregkh-usb-036_usb-hcds_no_more_register_root_hub.patch
+gregkh-04-USB-gregkh-usb-037_usb-ub_multi_lun.patch
+gregkh-04-USB-gregkh-usb-038_usb-rndis_cleanups.patch
+gregkh-04-USB-gregkh-usb-039_usb-ethernet_gadget_cleanups.patch
+gregkh-04-USB-gregkh-usb-040_usb-omap_udc_cleanups.patch
+gregkh-04-USB-gregkh-usb-041_usb-dummy_hcd-otg.patch
+gregkh-04-USB-gregkh-usb-042_usb-dummy_hcd-FEAT.patch
+gregkh-04-USB-gregkh-usb-043_usb-dummy_hcd-pdevs.patch
+gregkh-04-USB-gregkh-usb-044_usb-dummy_hcd-centralize-link.patch
+gregkh-04-USB-gregkh-usb-045_usb-dummy_hcd-root-hub_no-polling.patch

 Mergings, renamings, additions.

+hub-use-kthread.patch

 Use kthread API for khubd.

+proc-pid-smaps-fix-fix.patch

 Fix /proc/pid/smaps even more

+hugepage-consolidation.patch
+hugepage-consolidation-fix.patch
+hugepage-consolidation-fix-fix.patch
+hugepage-consolidation-ia64-fix.patch

 Hugepage code consolidation.  Needs testing on various architectures.

+node-local-per-cpu-pages.patch
+node-local-per-cpu-pages-tidy.patch
+node-local-per-cpu-pages-tidy-2.patch

 More the per-cpu-pages data structures into node-local storage on NUMA.

+remove-drivers-net-skfp-lnkstatc.patch

 Ded code

+fix-promisc-bridging-in-tlan-driver.patch

 tlan driver fix

+ppc32-platform-specific-functions-missing-from-kallsyms.patch
+ppc32-simplified-ppc-core-revision-report.patch
+ppc64-remove-hidden-fno-omit-frame-pointer-for-schedulec.patch
+ppc64-add-missing-kconfig-help-text.patch
+ppc64-pgtableh-and-other-header-cleanups.patch

 ppc32/ppc64 updates

+added-no_ioapic_check-in-io_apic_get_unique_id-for-acpi-boot.patch

 Allow xAPIC systems that don't have serial bus for interrupt delivery to
 by-pass the check on uniquness of IO-APIC IDs.

+x86-stack-initialisation-fix.patch

 x86 thread startup fix

+x86-x86_64-pcibus_to_node.patch

 Add pcibus_to_node().

+numa-aware-block-device-control-structure-allocation.patch
+numa-aware-block-device-control-structure-allocation-tidy.patch

 Use pcibus_to_node() in block drivers so that driver data structures are
 allocated from the memory of the node which owns the hardware.

+optimise-storage-of-read-mostly-variables.patch

 Create a new section for read-mostly storage, use it.

+x86-x86_64-deferred-handling-of-writes-to-proc-irq-xx-smp_affinitypatch-added-to-mm-tree-fix-4.patch
+x86-x86_64-deferred-handling-of-writes-to-proc-irq-xx-smp_affinitypatch-added-to-mm-tree-fix-5.patch

 Fix x86-x86_64-deferred-handling-of-writes-to-proc-irq-xx-smp_affinitypatch-added-to-mm-tree.patch

+uml-obvious-compile-fixes-for-x86-64-subarch-and-x86-regression-fixes.patch
+uml-kludgy-compilation-fixes-for-x86-64-subarch-modules-support.patch
+x86_64-make-string-func-definition-work-as-intended.patch
+x86_64-make-string-func-definition-work-as-intended-fix.patch
+uml-include-the-linker-script-rather-than-symlink-it.patch
+uml-use-variables-rather-than-symlinks-in-dependencies.patch
+uml-start-cross-build-support-mk_user_constants.patch
+uml-cross-build-support-mk_ptregs.patch
+uml-cross-build-support-mk_sc.patch
+uml-cross-build-support-kernel_offsets.patch
+uml-cross-build-support-mk_thread.patch
+uml-cross-build-support-mk_task-and-mk_constants.patch
+uml-fix-missing-subdir-in-x86_64.patch
+uml-finish-cross-build-support.patch
+uml-fix-a-ptrace-call.patch
+uml-s390-preparation-abstract-host-page-fault-data.patch
+uml-fix-sigwinch-relaying.patch
+uml-tidy-makefilerules.patch
+uml-inclusion-cleanup.patch
+uml-hostfs-failed-mount-handling.patch
+uml-s390-preparation-elfh.patch
+uml-s390-preparation-linkageh-inherited-from-host.patch
+uml-s390-preparation-checksumming-done-in-arch-code.patch
+uml-s390-preparation-delay-moved-to-arch.patch
+uml-s390-preparation-sighandler-interface-abstraction.patch
+uml-remove-a-dangling-symlink.patch
+uml-header-and-code-cleanup.patch

 UML updates

+blk-no-memory-barrier.patch
+blk-branch-hints.patch
+blk-unplug-later.patch
+blk-__make_request-efficiency.patch
+blk-reduce-locking.patch
+blk-reduce-locking-fixes.patch
+blk-light-iocontext-ops.patch
+blk-fastpath-get_request.patch

 BLock layer code tweaks

+timers-fix-__mod_timer-vs-__run_timers-deadlock.patch
+timers-fix-__mod_timer-vs-__run_timers-deadlock-tidy.patch
+timers-comments-update.patch

 Hopefully fixe the new timer code

+kprobes-allow-multiple-kprobes-at-the-same-address.patch

 kprobes feature/fix

+__block_write_full_page-race-fix.patch
+__block_write_full_page-speedup.patch
+__block_write_full_page-simplification.patch

 VFS fixes

+remove-bk-documentation.patch

 Remove BK documentation

+rpc-kick-off-socket-connect-operations-faster.patch

 NFS fix

+remove-register_ioctl32_conversion-and-unregister_ioctl32_conversion.patch

 Remove [un]register_ioctl32_conversion()

+update-dontdiff.patch

 dontdiff update

+page_uptodate_lock-hashing.patch

 Reduce VFS lock contention

+saa6752hs-resolutions-handling.patch

 v4l fix

+pcmcia-enable-32-bit-memory-windows-on-pd6729.patch
+pcmcia-yenta-ti-align-irq-of-func1-to-func0-if-intrtie-is-set.patch

 pcmcia fixes

+dac960-add-support-for-mylex-acceleraid-4-5-600.patch

 Additional dac960 device support

+remove-outdated-comments-from-filemapc.patch

 Comment fix

+remove-do_sync-parameter-from-__invalidate_device.patch
+remove-do_sync-parameter-from-__invalidate_device-fix.patch

 Code simplification

+bttv-fix-dst-i2c-read-write-timeout-failure.patch

 bttv fix

+orinoco-maintainers-update.patch

 MAINTAINERS update

+connector.patch

 Connector thingy - wrapper on top of netlink.

+inotify-44-update.patch

 inotify fixes

+revert-ext3-writepages-support-for-writeback-mode.patch

 Revert recent ext3 feature: it's deadlocky.

+pcmcia-mark-parent-bridge-windows-as-resources-available-for-pcmcia-devices-fix.patch

 Fix pcmcia-mark-parent-bridge-windows-as-resources-available-for-pcmcia-devices.patch

+pcmcia-documentation-fix.patch

 PCMCIA documentation

+make-page-becoming-writable-notification-a-vma-op-only-kafs-fix-fix.patch

 Fix make-page-becoming-writable-notification-a-vma-op-only-kafs-fix.patch

+device-mapper-store-bdev-while-frozen.patch
+device-mapper-__unlock_fs-void.patch
+device-mapper-let-freeze_bdev-return-error.patch
+device-mapper-handle-__lock_fs-error.patch
+device-mapper-tidy-dm_suspend.patch
+device-mapper-multipath-use-private-workqueue.patch
+device-mapper-dm-emc-fix-a-memset.patch
+device-mapper-some-missing-statics.patch

 devicemapper updates

+fs-jffs2-make-some-functions-static.patch
+fs-nls-nls_basec-make-a-variable-static.patch
+fs-make-some-code-static.patch
+drivers-char-keyboardc-make-a-function-static.patch
+drivers-video-fbmemc-make-a-function-static.patch
+drivers-video-fbsysfsc-make-a-struct-static.patch
+drivers-video-sis-make-some-functions-static.patch
+drivers-md-make-some-code-static.patch
+drivers-net-appletalk-make-2-firmware-images-static-const.patch
+drivers-net-arcnet-capmodec-make-a-struct-static.patch
+drivers-cdrom-cdu31ac-make-some-code-static.patch
+floppy-driver-make-fd_routine-static.patch
+drivers-cdrom-mcdxc-make-code-static.patch
+drivers-block-rdc-make-a-variable-static.patch
+drivers-cdrom-sbpcdc-make-a-function-static.patch
+fs-nfs-make-some-functions-static.patch

 Make more things static

+fs-jffs-cleanups.patch
+fs-ncpfs-remove-unused-ifdef-use_old_slow_directory_listing-code.patch
+drivers-net-seeq8005c-cleanups.patch
+drivers-net-hamradio-cleanups.patch
+drivers-net-irda-irportc-cleanups.patch
+drivers-net-tokenring-cleanups.patch
+drivers-net-sk98lin-possible-cleanups.patch
+drivers-net-skfp-fix-little_endian.patch
+drivers-net-ewrk3c-remove-dead-code.patch
+drivers-net-arcnet-possible-cleanups.patch
+drivers-block-sx8c-remove-unused-code.patch
+drivers-video-matrox-matroxfb_miscc-remove-dead-code.patch
+drivers-char-mwave-tp3780ic-remove-dead-code.patch
+drivers-scsi-sym53c416c-fix-a-wrong-check.patch
+drivers-block-ll_rw_blkc-cleanups.patch
+change-the-sound_prime-handling.patch
+i386-cleanup-boot_cpu_logical_apicid-variables.patch

 Little fixes

+__deprecated_for_modules-insert_resource.patch
+__deprecated_for_modules-panic_timeout.patch

Deprecate modular usage of a couple of symbols.


number of patches in -mm: 925
number of changesets in external trees: 429
number of patches in -mm only: 915
total patches: 1344


All 925 patches: ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/patch-list


