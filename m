Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWAEOXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWAEOXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWAEOXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:23:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751325AbWAEOXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:23:05 -0500
Date: Thu, 5 Jan 2006 06:22:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-mm1
Message-Id: <20060105062249.4bc94697.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm1/


- ppc32 builds are broken

- Fun new debug option CONFIG_DEBUG_SHIRQ will simulate a shared interrupt
  arriving immediately after a driver does request_irq().  This broke one
  driver for me and will probably break others.

  Please try this option.  If it breaks anything, send the report and then
  turn the option off.



Changes since 2.6.15-rc5-mm3:

 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-arm.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-drm.patch
 git-audit.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-libata-all.patch
 git-mmc.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-serial.patch
 git-serial-build-fix.patch
 git-sym2.patch
 git-pcmcia.patch
 git-alsa-vs-git-pcmcia.patch
 git-scsi-misc-fixup.patch
 git-sas-jg.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 Subsystem trees

-ipmi-panic.patch
-reiserfs-close-open-transactions-on-error-path.patch
-reiserfs-skip-commit-on-io-error.patch
-input-alps-correctly-report-button-presses-on-fujitsu-siemens-s6010.patch
-git-alsa-sparc64-fix.patch
-gregkh-driver-move-pnpbios-usermod_helper.patch
-gregkh-driver-remove-KOBJECT_UEVENT.patch
-gregkh-driver-add-uevent_helper.patch
-gregkh-driver-remove-mount-events.patch
-gregkh-driver-merge-hotplug-and-uevent.patch
-gregkh-driver-kill-hotplug-word-from-driver-core.patch
-gregkh-driver-hotplug-always-enabled.patch
-gregkh-driver-driver-kill-hotplug-word-from-sn-and-others-fix.patch
-gregkh-driver-hold-the-device-s-parent-s-lock-during-probe-and-remove.patch
-gregkh-driver-klist-fix-broken-kref-counting-in-find-functions.patch
-gregkh-driver-allow-overlapping-resources-for-platform-devices.patch
-gregkh-driver-kobject_uevent-config_net-n-fix.patch
-gregkh-driver-ide-modalias-support-for-autoloading-of-ide-cd-ide-disk.patch
-gregkh-driver-input-add-modalias-support.patch
-gregkh-driver-input-fix-add-modalias-support-build-error.patch
-gregkh-driver-platform-device-del.patch
-gregkh-driver-platform-rearange-exports.patch
-gregkh-driver-bind_unbind_if_CONFIG_HOTPLUG.patch
-gregkh-driver-block-device-symlink-name-fix.patch
-gregkh-driver-speakup-docs.patch
-gregkh-driver-speakup-core.patch
-gregkh-driver-speakup-kconfig-fix.patch
-gregkh-driver-speakup-build-fix.patch
-gregkh-driver-merge-hotplug-and-uevent-w9968cf-fix.patch
-drivers-base-power-runtimec-if-0-dpm_set_power_state.patch
-gregkh-i2c-i2c-mv64xxx-compilation-error-fix.patch
-use-kernelrelease.patch
-mtd-onenand-genericc-needs-platform_deviceh-and-use-flash_platform_data.patch
-git-netdev-all-s2io-warning-fix.patch
-powerpc-pci_address_to_pio-warning-fix.patch
-serial-fix-matching-of-mmio-ports.patch
-gregkh-pci-pci-express-must-be-initialized-before-pci-hotplug.patch
-gregkh-pci-pci-export-pci_cfg_space_size.patch
-dpt_i2o-fix-for-deadlock-condition.patch
-mptfusion-adding-=-this_module.patch
-mptfusion-cleaning-up-xxx_probe-error-handling.patch
-mptfusion-bus_type-change-scsi-to-spi.patch
-mptfusion-prep-for-removing-domain-validation.patch
-mptfusion-mapping-fixs-required-support-for-transport-layers.patch
-mptfusion-bump-version.patch
-gregkh-usb-uhci-add-missing-memory-barriers.patch
-gregkh-usb-pxa27x-ohci-separate-platform-code-from-main-driver.patch
-gregkh-usb-add-pxa27x-ohci-pm-functions.patch
-gregkh-usb-usb-cdc-acm-ring-queue.patch
-gregkh-usb-isp116x-hcd-support-reiniting-hc-on-resume.patch
-gregkh-usb-isp116x-hcd-cleanup.patch
-gregkh-usb-ehci-fix-conflation-of-buf-0-with-len-0.patch
-gregkh-usb-usb-eagle-and-adi-930-usb-adsl-modem-driver.patch
-gregkh-usb-usb-eagle-and-adi-930-usb-adsl-modem-driver-fix.patch
-gregkh-usb-usb-remove-usb_audio-and-usb_midi-drivers.patch
-gregkh-usb-usb-drivers-usb-core-message.c-make-usb_get_string-static.patch
-gregkh-usb-usb-ehci-updates-driver-model-wakeup-flags.patch
-gregkh-usb-usb-wakeup-flag-updates-sl811-hcd.patch
-gregkh-usb-usb-wakeup-flag-updates-uhci-hcd.patch
-gregkh-usb-usb-wakeup-flag-updates-isp116x-hcd.patch
-gregkh-usb-usb-hcd-uses-extra_cflags-for-ddebug.patch
-gregkh-usb-usb-file-storage-gadget-add-reference-count-for-children.patch
-gregkh-usb-usb-net-removes-redundant-return.patch
-gregkh-usb-usb-net-new-device-id-passed-through-module-parameter.patch
-gregkh-usb-usb-dummy_hcd-rename-variables.patch
-gregkh-usb-usbcore-central-handling-for-host-controllers-that-were-reset-during-suspend-resume.patch
-gregkh-usb-usb-libusual.patch
-gregkh-usb-usb-dynamic-id-01.patch
-gregkh-usb-usb-dynamic-id-02.patch
-gregkh-usb-usb-dynamic-id-03.patch
-gregkh-usb-usb-driver-owner.patch
-gregkh-usb-usb-driver-owner-removal.patch
-gregkh-usb-remove-usb-private-semaphore.patch
-gregkh-usb-disconnect-children-during-hub-unbind.patch
-gregkh-usb-usb-fix-locking-for-usb-suspend-resume.patch
-gregkh-usb-usb-small-cleanups.patch
-gregkh-usb-one-potential-problem-in-gadget-serial.c.patch
-gregkh-usb-usbcore-consider-power-budget-when-choosing-configuration.patch
-gregkh-usb-usb-store-port-number-in-usb_device.patch
-gregkh-usb-usb-cleanups-for-usb-gadget-mass-storage.patch
-gregkh-usb-isp116x-hcd-minor-cleanup.patch
-gregkh-usb-usbserial-adds-missing-checks-and-bug-fix.patch
-gregkh-usb-usbserial-race-condition-fix.patch
-gregkh-usb-usb-input-touchkitusb-handle-multiple-packets.patch
-gregkh-usb-usb-don-t-allocate-dma-pools-for-pio-hcds.patch
-gregkh-usb-usb-gadget-file_storage-remove-volatile-declarations.patch
-gregkh-usb-usb-gadget-dummy_hcd-updates-to-hcd-state.patch
-gregkh-usb-usb-don-t-assume-root-hub-resume-succeeds.patch
-gregkh-usb-drivers-usb-misc-sisusbvga-sisusb.c-remove-dead-code.patch
-gregkh-usb-usb-mark-various-usb-tables-const.patch
-gregkh-usb-correct-ohci-pxa27x-suspend-resume-struct-confusion.patch
-gregkh-usb-usb-storage-add-unusual_devs-entry-for-nikon-coolpix-2000.patch
-gregkh-usb-usb-pl2303_update_line_status-data-length-fix.patch
-gregkh-usb-usb-ati_remote-use-time_before-and-friends.patch
-gregkh-usb-uhci-change-uhci_explen-macro.patch
-gregkh-usb-uhci-edit-some-comments.patch
-gregkh-usb-usb-let-usbmon-collect-less-garbage.patch
-gregkh-usb-usb-storage-make-onetouch-pm-aware.patch
-gregkh-usb-usb-storage-cleanups-of-sddr09.patch
-gregkh-usb-usb-storage-sddr09-cleanups.patch
-gregkh-usb-usb-storage-more-sddr09-cleanups.patch
-gregkh-usb-usb-storage-add-alauda-support.patch
-gregkh-usb-usb-storage-update-maintainers.patch
-gregkh-usb-usb-storage-add-debug-entry-for-report-luns.patch
-gregkh-usb-usbcore-fix-local-variable-clash.patch
-gregkh-usb-usb-use-array_size-macro.patch
-gregkh-usb-usb-add-driver-for-ati-philips-usb-rf-remotes.patch
-gregkh-usb-usb-support-for-posiflex-pp-7000-retail-printer-in-linux.patch
-gregkh-usb-ftdi_sio-new-ids-for-teratronik-devices.patch
-gregkh-usb-usb-remove-unneeded-kmalloc-return-value-casts.patch
-gregkh-usb-isp116x-hcd.c-removed-unused-variable.patch
-force-starget-scsi_level-in-usb-storage-scsigluec.patch
-x86_64-compat-cfi.patch
-uml-arch-um-scripts-makefilerules-remove-duplicated-code.patch
-uml-fix-dynamic-linking-on-some-64-bit-distros.patch
-fix-sysfs-access-to-module-parameters-with-config_modules=n.patch
-make-i2o_iop_free-static-inline.patch
-via82cxxx-ide-add-vt8251-isa-bridge.patch
-nvidiafb-fix-6xxx-7xxx-cards.patch
-md-change-case-of-raid-level-reported-in-sys-mdx-md-level.patch
-fix-sparse-using-plain-integer-as-null-pointer-warnings.patch
-include-asm-x86_64-pgtableh-extern-inline-static-inline.patch
-drivers-scsi-lpfc-lpfc_scsic-make-lpfc_sli_get_scsi_buf-static.patch
-drivers-base-memoryc-unexport-the-static-sic-memory_sysdev_class.patch
-drivers-w1-misc-cleanups.patch

 Merged

+lxdialog-sane-colours.patch

 Make menuconfig readable.

+hfsplus-oops-fix.patch

 hfs+ fix

+knfsd-fix-hash-function-for-ip-addresses-on-64bit-little-endian-machines.patch

 nfsd fix

+alpha-dma_map_page-fix.patch

 Alpha build fix

-acpi-fix-asus_acpi-on-samsung-p30-p35.patch

 Rejected

-pnpacpi-handle-address-descriptors-in-_prs.patch
-pnpacpi-handle-address-descriptors-in-_prs-fix-for-git-acpi-change.patch

 These broke

+acpi-remove-kconfig-acpi-laptop-default-settings.patch

 ACPI Kconfig fix

+asus_acpi-invert-read-of-wled-proc-file-to-show-correct.patch

 ACPI fix

+amd64-agp-suspend-support.patch
+ati-agp-suspend-resume-support.patch

 git-agpgart fixes

+git-alsa-duplicate-ac97_quirks-entry-in-intel8x0c.patch

 alsa fix

+p4-clockmod-workaround-for-cpus-with-n60-errata.patch
+powernow-k7-work-when-kernel-is-compiled-for-smp.patch

 cpufreq fixes

+gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch

 Driver tree update

+git-drm-radeon-warning-fixes.patch
+git-drm-build-fix.patch
+git-drm-via_dmablit-build-fix.patch

 Fix git-drm.patch

+gregkh-i2c-hwmon-w83792d-misc-cleanups.patch
+gregkh-i2c-hwmon-w83792d-simplify-in-low-bits.patch
+gregkh-i2c-hwmon-vrm-via.patch
+gregkh-i2c-hwmon-it87-vrm-fits-in-u8.patch
+gregkh-i2c-i2c-id-cleanups.patch
+gregkh-i2c-i2c-drop-useless-command-callbacks.patch
+gregkh-i2c-i2c-update-command-documentation.patch
+gregkh-i2c-i2c-drop-driver-flags-04-drop-outdated-comments.patch
+gregkh-i2c-i2c-ibm_iic-hwmon-class.patch
+gregkh-i2c-i2c-nforce2-support-nforce4-mcp04.patch
+gregkh-i2c-i2c-mv64xxx-abort-fix.patch
+gregkh-i2c-w1-misc-cleanups.patch

 i2c tree updates

+i8042-add-oqo-zepto-to-noloop-dmi-table.patch

 8042 driver fix

+remove-duplicated-pci-id.patch

 PCI fix

+sata_nv-spurious-interrupts-at-system-startup-with-maxtor.patch

 libata fix

+swsusp-resume_store-retval-fix.patch
+swsusp-resume-parsing-fix.patch

 swsusp fixes (the second may not be needed)

+netfilter-fix-handling-of-module-param-dcc_timeout-in-ip_conntrack_ircc.patch

 Netfilter fix

+git-serial-build-fix.patch

 git-serial fix

+gregkh-pci-acpiphp-only-size-new-bus.patch
+gregkh-pci-pci-drivers-pci-some-cleanups.patch
+gregkh-pci-pci-update-toshiba-ohci-quirk-dmi-table.patch

 PCI tree updates

+msix-save-restore-for-suspend-resume.patch
+msix-save-restore-for-suspend-resume-fix.patch
+remove-msi-save-restore-code-in-specific-driver.patch
-reconfigure-msi-registers-after-resume.patch

 MSIX power management fixes

+areca-raid-linux-scsi-driver-updates.patch

 Update the areca raid driver

+gregkh-usb-uhci-use-one-qh-per-endpoint-not-per-urb.patch
+gregkh-usb-uhci-use-dummy-tds.patch
+gregkh-usb-uhci-remove-main-list-of-urbs.patch
+gregkh-usb-uhci-improve-debugging-code.patch
+gregkh-usb-uhci-don-t-log-short-transfers.patch
+gregkh-usb-usb-serial-dynamic-id.patch

 USB tree updates

+gregkh-usb-usbip-build-fix.patch
+gregkh-usb-usbip-more-dead-code.patch

 USB tree fixes

+au1xx0-replace-casual-readl-with-au_readl-in-the-drivers.patch
+ftdi_sio-new-pid-for-pcdj-dac2.patch

 More USB fixes

+x86_64-compat-cfi.patch
+x86_64-compat-sg.patch
+x86_64-compat-flag.patch
+x86_64-pf-error-symbolic.patch
+x86_64-pgtable-static-inline.patch
+x86_64-kernel-debug-trap.patch
+x86_64-no-subjiffy-profile.patch
+x86_64-i386-timer-broadcast.patch
+x86_64-x86_64-timer-broadcast.patch
+x86_64-iommu-boundary.patch
+x86_64-cpu-pda-cleanup.patch
+x86_64-remove-kdb-vector.patch
+x86_64-numa-style.patch
+x86_64-numa-printk-level.patch
+x86_64-idle-notifier.patch
+x86_64-srat-zero-length-nodes.patch
+x86_64-cleanup-copy-user.patch
+x86_64-mce-printk.patch
+x86_64-nvidia-ck8-sound.patch
+x86_64-map-single-zero-warn.patch
+x86_64-cpumask-read-mostly.patch
+x86_64-apic_write_atomic.patch
+x86_64-unexport-pci_consistent.patch
+x86_64-remove-duplicate-exports.patch
+x86_64-write-apic-id.patch
+x86_64-cpumask-include.patch
+x86_64-intel-no-tsc-sync.patch
+x86_64-alternative-io.patch
+x86_64-alternative-vsyscall.patch
+x86_64-gtod-intel-no-sync.patch
+x86_64-fix-serialize-cpu.patch
+x86_64-vsyscall-force-inline.patch
+x86_64-time-style.patch
+x86_64-early_cpu_to_node.patch
+x86_64-nmi-warning.patch
+x86_64-vector-fixup.patch

 x86_64 tree updates

-madvise-remove-remove-pages-from-tmpfs-shm-backing-store-tidy.patch
-madvise-remove-remove-pages-from-tmpfs-shm-backing-store-fix.patch

 Folded into madvise-remove-remove-pages-from-tmpfs-shm-backing-store.patch

-slab-rename-obj_reallen-to-obj_size.patch

 Dropped - there's a new version coming.

+mm-page_state-opt-fix.patch

 Fix mm-page_state-opt.patch

+set_page_count-macro-safety.patch
+mm-clean-up-local-variables.patch
+rmap-additional-diagnostics-in-page_remove_rmap.patch

 mm tweaks

+x25-fix-for-broken-x25-module.patch

 x.25 fix

+ipw2200-stack-reduction.patch

 Fix ipw22000 stack bloatiness

+remove-bouncing-mail-address-of-mv643xx_eth-maintainer.patch

 MAINTAINERS update

+forcedeth-tso-fix-for-large-buffers.patch

 forcedeth fix

+cs89x0-make-readwriteword-take-base_addr.patch
+cs89x0-convert-inwoutw-calls-to-readwriteword.patch
+cs89x0-swap-readwritereg-and-readwriteword.patch
+cs89x0-make-readwritereg-use-readwriteword.patch
+cs89x0-cleanly-implement-ixdp2x01-and-pnx0501-support.patch
+cs89x0-switch-inoutsw-to-readwritewords.patch
+fix-kconfig-depends-for-cs89x0-pnx010x-support.patch
+cs89x0-fix-up-after-pnx0105-kconfig-symbol-renaming.patch

 cs89x0 updates

+fix-a-few-warning-cleanup_card-defined-but-not-used.patch

 Warning fixes

+ethtoolh-dont-leak-kernel-types.patch
+miih-dont-leak-kernel-types.patch

 Small inforation leak fixes

+irda-nsc-ircc-add-isapnp-support.patch

 IRDA feature

+macintosh-dont-store-i2c_add_driver-return-if-no-further-processing-done.patch
+ppc32-remove-useless-file-arch-ppc-platforms-mpc5200c.patch
+ppc32-serial-fix-compiler-errors-with-gcc-4x-in.patch
+ppc32-serial-change-mpc52xx_uartc-to-use-the-low.patch
+ppc32-fix-static-io-mapping-for-freescale-mpc52xx.patch
+ppc32-modify-freescale-mpc52xx-irq-mapping-to-_not_.patch
+ppc32-remove-__init-qualifier-from-mpc52xx-pci.patch
+ppc32-fix-mpc52xx-configuration-space-access.patch
+ppc32-fix-mpc52xx-pci-init-in-cas-the-bootloader.patch
+ppc32-allows-compilation-of-a-mpc52xx-kernel-without.patch
+ppc32-re-add-embed_configc-to-ml300-ep405.patch
+therm_adt746x-quiet-fan-speed-change-messages.patch

 ppc32 updates

-disable-apic-pin-1-on-dodgy-ati-chipsets.patch
-disable-apic-pin-1-on-dodgy-ati-chipsets-fix.patch

 Dropped - it got rejects

+base-support-for-amd-geode-gx-lx-processors.patch
+base-support-for-amd-geode-gx-lx-processors-tidy.patch
+geode-lx-hw-rng-support.patch
+geode-lx-hw-rng-support-fix.patch

 Geode support

+apm-screen-blanking-fix.patch
+apm-screen-blanking-fix-tidy.patch

 APM fix

+fix-cpu-frequency-detection-in-arch-i386-kernel-timers-timer_tsccrecalibrate_cpu_khz.patch

 CPU frequency detection fix

+mpspec-remove-unneeded-packed-attribute.patch

 Cleanup

+i386-ioapic-virtual-wire-mode-fix.patch

 IOAPIC fix

+i386-handle-hp-laptop-rebooting-properly.patch

 HP laptop workaround

-x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is.patch

 Dropped, due to rejects iirc.

+x86_64-ioapic-virtual-wire-mode-fix.patch

 IOAPIC fix

+arm-netwinder-ds1620-driver-needs-an-export-to-be-built.patch

 Build fix

+mm-add-a-new-function-needed-for-swap-suspend.patch
+swsusp-improve-handling-of-swap-partitions.patch
+swsusp-save-image-header-first.patch
+dont-freeze-firewire-on-suspend.patch
-swsusp_resume_fix.patch

 Power management updates

+uml-use-kstrdup.patch
+uml-non-void-functions-should-return-something.patch
+uml-formatting-changes.patch
+uml-use-array_size.patch
+uml-remove-unneeded-structure-field.patch
+uml-move-mconsole-support-out-of-generic-code.patch
+uml-add-static-initializations-and-declarations.patch
+uml-line_setup-interface-change.patch
+uml-move-console-configuration.patch
+uml-simplify-console-opening-closing-and-irq-registration.patch
+uml-fix-flip_buf-full-handling.patch
+uml-add-throttling-to-console-driver.patch
+uml-separate-libc-dependent-umid-code.patch
+uml-umid-cleanup.patch
+uml-sigwinch-handling-cleanup.patch
+uml-better-diagnostics-for-broken-configs.patch
+uml-add-mconsole_reply-variant-with-length-param.patch
+uml-capture-printk-output-for-mconsole-stack.patch
+uml-capture-printk-output-for-mconsole-sysrq.patch
+uml-fix-whitespace-in-mconsole-driver.patch
+uml-free-network-irq-correctly.patch

 UML updates

+s390-fix-invalid-return-code-in-sclp_cpi.patch
+s390-cleanup-kconfig.patch

 s390 updates

-clear_buffer_uptodate-in-discard_buffer.patch
-clear_buffer_uptodate-in-discard_buffer-check.patch

 This was incomplete and is apparently unneeded now.

-pc-speaker-add-snd_silent.patch

 Dropped due to rejects

-move-swiotlb-header-file-into-common-code.patch
-move-swiotlb-header-file-into-common-code-fix.patch
-move-swiotlb-header-file-into-common-code-fix-2.patch

 Dropped due to rejects

-remove-the-deprecated-check_gcc.patch
+more-updates-for-the-gcc-=-32-requirement.patch

 More droppage of gcc-2.95 support

+sonypi-enable-acpi-events-for-sony-laptop-hotkeys.patch

 sonypi fix

+modules-prevent-overriding-of-symbols.patch

 Modules fix

+modules-mark-taint_forced_rmmod-correctly.patch

 Modules feature

+reorder-kiocb-structure-elements-to-make-sync-iocb-setup-faster.patch

 AIO speedup

+jbd-fix-transaction-batching.patch

 ext3 maybe-speedup.   Needs benchmarking.

+shrink-struct-page.patch

 Make struct page smaller under some configs

+kernel-modulec-getting-rid-of-the-redundant-spinlock-in-resolve_symbol.patch

 Cleanup

+ptrace_sysemu-is-only-for-i386-and-clashes-with-other-ptrace-codes-of-other-archs.patch

 ptrace cleanup

+fs-smbfs-procc-fix-data-corruption-in-smb_proc_setattr_unix.patch

 smbfs fix

+ufs-inode-i_sem-is-not-released-in-error-path.patch

 UFS fix

+mmci-kunmap_atomic-unmaps-virtual-address-not-page.patch

 MMC fix

+submittingpatches-diffstat-options.patch

 Documentation

+credits-update-eugene-surovegin.patch

 Update CREDITS

+reduce-size-of-bio-mempools.patch

 Use less memory for BIOs

+split-out-screen_info-from-ttyh.patch

 Cleanup

+v9fs-fix-fd_close.patch
+v9fs-new-multiplexer-implementation.patch
+v9fs-new-multiplexer-implementation-tidy.patch
+v9fs-fix-fid-management-in-v9fs_create.patch
+v9fs-zero-copy-implementation.patch

 v8fs updates

+fix-gcc41-build-failure-on-xconfig.patch

 Build fix

+protect-remove_proc_entry.patch

 Locking fix

+hw_random-82801ab-pci-bridge-support.patch

 hw_random device support

+add-a-section-about-inlining-to-documentation-codingstyle.patch

 Documentation

+add-udev-support-to-parport_pc.patch
+add-udev-support-to-parport_pc-tidy.patch

 Teach parport_pc about sysfs and udev (needs work)

+eliminate-__attribute__-packed-warnings-for-gcc-41.patch
+afs-remove-unnecessary-__attribute__-packed.patch
+i4l-__attribute__packed-for-the-capi-message-structs.patch

 Fiddle with attribute(packed)

+make-apm-buildable-without-legacy-pm.patch

 APM build fix

+define-bits_per_byte.patch

 Less magic constants

+shrinks-sizeoffiles_struct-and-better-layout.patch
+shrinks-sizeoffiles_struct-and-better-layout-tidy.patch

 Shrink files_struct

+remove-semicolons-from-save_flags.patch

 Redundant semicolon

+drivers-block-use-array_size-macro.patch

 Cleanup

+optimize-select-poll-by-putting-small-data-sets-on-the-stack.patch
+use-fget_light-in-select-poll.patch

 select/poll speedups

+fix-workqueue-oops-during-cpu-offline.patch

 Fix workqueue vs CPU hotplug

+kconf-check-for-eof-from-input-stream.patch

 kconfig fix

+i810_audio-request_irq-fix.patch

 i810_audio race fix

+i2o-changed-i2o-api-to-create-i2o-messages-in-kernel.patch
+i2o-changed-i2o-api-to-create-i2o-messages-in-kernel-fix.patch
+i2o-sparc-fixes.patch
+i2o-remove-wrong-i2o-device-class.patch
+i2o-bugfixes.patch
+i2o-beautifying.patch
+i2o-optimizing.patch
+i2o-lindent-run.patch

 i2o driver updates

+mtd-dataflash-driver-spi-framework-2-mtd_dataflash-updates.patch

 Update mtd-dataflash-driver-spi-framework-2.patch

-spi-add-spi_bitbang-driver-fix.patch

 Fix spi-add-spi_bitbang-driver.patch

+spi-core-tweaks-bugfix.patch
+spi-add-spi_bitbang-driver-bitbanging-becomes-library-code.patch
+m25-series-spi-flash.patch
+m25-series-spi-flash-fix.patch

 SPI driver updates

+fuse-add-code-documentation.patch
+fuse-fail-file-operations-on-bad-inode.patch
+fuse-clean-up-request-size-limit-checking.patch
+fuse-make-maximum-write-data-configurable.patch
+fuse-ensure-progress-in-read-and-write.patch
+fuse-check-file-type-in-lookup.patch

 FUSE updates

+tiny-make-id16-support-optional-fix.patch

 Fix tiny-make-id16-support-optional.patch

+make-vm86-support-optional.patch

 More code shrinkage

-add-support-for-vectored-and-async-i-o-to-all-simple-filesystems.patch
-introduce-fs_noatime-and-fs_nodiratime-flags.patch
-fs_noatime-for-ocfs.patch
-per-mount-noatime-and-nodiratime.patch

 Dropped

+per-mount-noatime-and-nodiratime-2.patch

 Replace them with this

+generic-ioctlh.patch

 Consolidate ioctl.h's

-workaround-for-pnp-device-interrupt.patch

 Dropped - wrong.

+edac-core-edac-support-code-fix.patch
+edac-with-sysfs-interface-added.patch
+edac-with-sysfs-interface-added-tidy.patch

 syusfsification of the EDAC driver

+export-ktime_get_ts.patch
+switch-getnstimestamp-calls-to-ktime_get_ts.patch
+remove-getnstimestamp.patch

 Updates/fixes to the hrtimer code

+time-reduced-ntp-rework-part-1.patch
+time-reduced-ntp-rework-part-2.patch
+time-clocksource-infrastructure.patch
+time-generic-timekeeping-infrastructure.patch
+time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
+time-i386-conversion-part-2-move-timer_tscc-to-tscc.patch
+time-i386-conversion-part-3-rework-tsc-support.patch
+time-i386-conversion-part-4-acpi-pm-variable-renaming-and-config-change.patch
+time-i386-conversion-part-5-enable-generic-timekeeping.patch
+time-i386-conversion-part-6-remove-old-code.patch
+time-i386-clocksource-drivers.patch

 John Stultz's new time management code

+kprobes-fix-build-break-in-2615-rc5-mm3.patch

 Fix the kprobes patches in -mm.

+v4l-dont-ignore-return-from-i2c_add_driver-for-tuner-3036.patch

 v4l fix

+media-radio-pci-probing-for-maestro-radio.patch
+media-radio-pci-probing-for-maestro-radio-fix.patch
+media-radio-maestro-radio-lindent.patch
+media-radio-maestro-types-change.patch
+media-radio-maestro-avoid-accessing-private-structures-directly.patch
+media-radio-maestro-radio-delete-owner-line-from-video-device.patch

 Update Maestro driver to new(ish) PCI API

+media-video-pci-probing-for-stradis-driver.patch
+media-video-stradis-video-little-cleanup.patch
+media-video-stradis-lindent.patch
+media-video-stradis-kconfig-url-changed.patch

 Ditto for Stradis driver

+knfsd-reduce-stack-consumption.patch

 Use less stack in nfsd

+missing-helper-task_stack_page.patch
+alpha-task_thread_info.patch
+alpha-task_stack_page.patch
+alpha-task_pt_regs.patch
+amd64-task_thread_info.patch
+amd64-task_pt_regs.patch
+amd64-task_stack_page.patch
+i386-task_thread_info.patch
+i386-fix-task_pt_regs.patch
+i386-task_stack_page.patch
+sparc64-task_thread_info.patch
+sparc64-task_stack_page.patch
+sparc64-task_pt_regs.patch
+sh-task_pt_regs.patch
+sh-task_thread_info.patch
+sh-task_stack_page.patch
+sparc-task_thread_info.patch
+sparc-task_stack_page.patch
+uml-task_thread_info.patch
+uml-task_stack_page.patch
+s390-task_pt_regs.patch
+s390-task_stack_page.patch
+xtensa-task_pt_regs-task_stack_page.patch
+v850-task_stack_page-task_pt_regs.patch
+m32r-task_pt_regs-task_stack_page-task_thread_info.patch
+frv-task_thread_info-task_stack_page.patch
+m68k-task_stack_page.patch
+m68knommu-task_stack_page.patch
+parisc-task_stack_page-task_thread_info.patch
+h8300-task_stack_page.patch
+arm-task_thread_info.patch
+arm-task_pt_regs.patch
+arm-end_of_stack.patch
+arm-task_stack_page.patch
+arm26-task_thread_info.patch
+arm26-task_pt_regs.patch
+arm26-task_stack_page.patch
+sh64-task_stack_page.patch
+powerpc-task_thread_info.patch
+powerpc-task_stack_page.patch
+cris-task_pt_regs.patch
+cris-fix-kstk_eip.patch
+cris-task_thread_info.patch
+ia64-task_thread_info.patch
+ia64-task_pt_regs.patch
+mips-namespace-pollution-dump_regs-elf_dump_regs.patch
+mips-task_pt_regs.patch
+mips-task_thread_info.patch
+mips-task_stack_page.patch
+death-of-get_thread_info-put_thread_info.patch

 Various fixes and cleanups to task_struct/thread_struct access.

+m68k-compile-fix-hardirq-checks-were-in-wrong-place.patch
+m68k-compile-fix-updated-vmlinuxlds-to-include-lock_text.patch
+m68k-namespace-pollution-fix-custom-amiga_custom.patch
+m68k-switch-mac-miscc-to-direct-use-of-appropriate-cuda-pmu-maciisi-requests.patch
+m68k-dumb-typo-in-atyfb.patch
+m68k-oktagon-makefile-fix.patch
+m68k-isa_typesex-should-be-exported.patch
+m68k-static-vs-extern-in-scch.patch
+m68k-static-vs-extern-in-sun3intsh.patch
+m68k-static-vs-extern-in-amigaintsh.patch
+m68k-memory-input-should-be-an-lvalue-mac-miscc.patch
+m68k-broken-constraints-on-mulul.patch
+m68k-bogus-function-argument-types-sun3_pgtableh.patch
+m68k-lvalues-abuse-in-mac8390.patch
+m68k-dmasound_paulac-lvalues-abuse-from-m68k-cvs.patch
+m68k-lvalues-abuse-in-dmasound.patch
+m68k-compile-fixes-for-dmasound-static-vs-extern.patch
+m68k-basic-iomem-annotations.patch
+m68k-basic-__user-annotations.patch
+m68k-signal-__user-annotations.patch
+m68k-rtc-__user-annotations.patch
+m68k-syscalls-__user-annotation.patch
+m68k-checksum-__user-annotations.patch
+m68k-amiflop-__user-annotations.patch
+m68k-ataflop-__user-annotations-null-noise-removal.patch
+m68k-amiserial-__user-annotations.patch
+m68k-dsp56k-__user-annotations.patch
+m68k-amifb-__user-annotations.patch
+m68k-zorro-__user-annotations.patch
+m68k-dmasound-__user-annotations.patch
+m68k-null-noise-removal.patch
+m68k-cast-in-strnlen-switched-to-unsigned-long.patch
+m68k-moved-initialisation-of-conswitchp-from-subarches-to-global-arch-setup.patch
+m68k-kill-mach_floppy_setup-convert-to-proper-__setup-in-drivers.patch
+m68k-fix-use-of-void-foovoid-asmbar-in-trapsc.patch
+m68k-fix-reference-to-init_task-in-vmlinux-sun3lds.patch
+m68k-fix-macfb-init.patch
+m68k-fix-pio-case-in-esp.patch
+m68k-console-code-in-heads-needs-framebuffer-support-built-in.patch

 m68k fixes and updates

+reiser4-bugfix-patch.patch

 reiser4 update

+altix-ioc3-serial-support.patch

 Altix serial driver

+quiet-ide-resource-reservation-messages.patch
+small-fixes-backported-to-old-ide-sis-driver.patch

 IDE driver updates

-ide-promise-flushing-hang-fix.patch

 This broke stuff

+fbdev-fixed-and-updated-cyblafb-fix.patch
+cyblafb-remove-unneeded-code.patch
+fbdev-fix-return-code-of-fb_read-and-fb_write.patch
+fbdev-reduce-stack-usage.patch
+nvidiafb-add-boot-option-bpp.patch
+nvidiafb-reduce-stack-usage.patch
+s3c2410fb-cleanup-and-fix.patch
+i810fb-fix-suspend-and-resume-hooks.patch
+fbcon-code-cleanups.patch
+fbdev-replace-kmalloc-with-kzalloc.patch
+fb-typoes-in-kconfig.patch

 fbdev updates

+dm-crypt-zero-key-before-freeing-it.patch

 dm-crypt security

+make-dm-mirror-not-issue-invalid-resync-requests.patch

 dm fix

+md-make-a-couple-of-names-in-mdc-static-fix.patch

 RAID update

+documentation-ioctl-messtxt-document-85-more-ioctls.patch

 More ioctl documentation

+debug-shared-irqs.patch

 Debugging code to catch driver which request their IRQ too early

-tty-layer-buffering-revamp-speakup-fix.patch

 The speakup driver seemed to get dropped from Greg's tree



All 1455 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm1/patch-list


