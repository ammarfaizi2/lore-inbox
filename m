Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWD0InR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWD0InR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWD0InR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:43:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964984AbWD0InP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:43:15 -0400
Date: Thu, 27 Apr 2006 01:41:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc2-mm1
Message-Id: <20060427014141.06b88072.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc2/2.6.17-rc2-mm1/


- It took six hours work to get this release building and linking in just a
  basic fashion on eight-odd architectures.  It's getting out of control.

  The acphphp driver is still broken and v4l and memory hotplug are, I
  suspect, only hanging in there by the skin of their teeth.

  Could patch submitters _please_ be a lot more careful about getting the
  Kconfig correct, testing various Kconfig combinations (yes sometimes
  people will want to disable your lovely new feature) and just generally
  think about these things a bit harder?  It isn't rocket science.

- Added the GFS tree to the -mm lineup as git-gfs2.patch .  The DLM patches
  were consequently dropped.



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it is not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.


Changes since 2.6.17-rc1-mm3:



 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-arm.patch
 git-cfq.patch
 git-dvb.patch
 git-gfs2.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-libata-all.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-pcmcia.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-frv.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch 

 git trees

-uml-make-64-bit-cow-files-compatible-with-32-bit-ones.patch
-task-make-task-list-manipulations-rcu-safe.patch
-for_each_possible_cpu-x86_64.patch
-uml-madv_remove-fixes.patch
-m41t00-fix-bitmasks-when-writing-to-chip.patch
-swsusp-prevent-possible-image-corruption-on-resume.patch
-msi-k8t-neo2-fir-onboardsound-and-additional-soundcard.patch
-sound-fix-hang-in-mpu401_uartc.patch
-sound-fix-hang-in-mpu401_uartc-tidy.patch
-for_each_possible_cpu-for-arm.patch
-block-i-o-schedulers-document-runtime-selection.patch
-drivers-char-drm-drm_memoryc-possible-cleanups.patch
-drm-fix-further-issues-in-drivers-char-drm-via_irqc.patch
-sbp2-consolidate-workarounds.patch
-sbp2-add-read_capacity-workaround-for-ipod.patch
-sbp2-make-tsb42aa9-workaround-specific-to-momobay-cx-1.patch
-sbp2-add-ability-to-override-hardwired-blacklist.patch
-mtd-improve-parameter-parsing-for-block2mtd.patch
-mtd-improve-parameter-parsing-for-block2mtd-fix.patch
-bcm43xx-sysfs-code-cleanup.patch
-bcm43xx-fix-pctl-slowclock-limit-calculation.patch
-e1000-fix-media_type-phy_type-thinko.patch
-unaligned-access-in-sk_run_filter.patch
-nfs-make-2-functions-static.patch
-remove-needless-check-in-nfs_opendir.patch
-fix-nfs-proc_fs=n-compile-error.patch
-nfssunrpc-fix-compiler-warnings-if-config_proc_fs-config_sysctl-are-unset.patch
-nfs_show_stats-for_each_possible_cpu-not-nr_cpus.patch
-powerpc-pseries-bugfix-balance-calls-to-pci_device_put.patch
-powerpc-pseries-clear-pci-failure-counter-if-no-new-failures.patch
-serial-fix-uart_bug_txen-test.patch
-git-scsi-misc-scsi_kmap_atomic_sg-warning-fix.patch
-megaraid-unused-variable.patch
-scsi-megaraid-megaraid_mmc-fix-a-null-pointer-dereference.patch
-overrun-in-drivers-scsi-sim710c.patch
-aic7xxx-ahc_pci_write_config-fix.patch
-qla2xxx-only-free_irq-after-request_irq-succeeds.patch
-git-splice-fixup.patch
-ftdi_sio-adds-support-for-iplus-device.patch
-ipw2200-config_ipw_qos-to-config_ipw2200_qos.patch
-softmac-uses-wiress-ext.patch
-bcm43xx_phyc-fix-a-memory-leak.patch
-orinoco-remove-useless-cis-validation.patch
-orinoco-remove-pcmcia-audio-support-its-useless-for-wireless-cards.patch
-orinoco-remove-underscores-from-little-endian-field-names.patch
-orinoco-fix-truncating-commsquality-rid-with-the-latest-symbol-firmware.patch
-orinoco-remove-tracing-code-its-unused.patch
-orinoco-remove-debug-buffer-code-and-userspace-include-support.patch
-orinoco-symbol-card-supported-by-spectrum_cs-is-la4137-not-la4100.patch
-orinoco-optimize-tx-exception-handling-in-orinoco.patch
-orinoco-orinoco_xmit-should-only-return-valid-symbolic-constants.patch
-orinoco-replace-hermes_write_words-with-hermes_write_bytes.patch
-orinoco-dont-use-any-padding-for-tx-frames.patch
-orinoco-refactor-and-clean-up-tx-error-handling.patch
-orinoco-simplify-8023-encapsulation-code.patch
-orinoco-fix-bap0-offset-error-after-several-days-of-operation.patch
-orinoco-delay-fid-allocation-after-firmware-initialization.patch
-orinoco_pci-disable-device-and-free-irq-when-suspending.patch
-orinoco_pci-use-pci_iomap-for-resources.patch
-orinoco-support-pci-suspend-resume-for-nortel-plx-and-tmd-adaptors.patch
-orinoco-reduce-differences-between-pci-drivers-create-orinoco_pcih.patch
-orinoco-further-comment-cleanup-in-the-pci-drivers.patch
-orinoco-bump-version-to-015.patch
-bcm43-wireless-fix-printk-format-warnings.patch
-bcm43-fix-config-menu-alignment.patch
-x86_64-mm-kdump-trigger-points.patch
-x86_64-mm-increase-nodemap.patch
-x86_64-mm-new-syscalls.patch
-x86_64-mm-move-doublefault.patch
-x86_64-mm-alternatives-fix.patch
-arm-add_memory-build-fix.patch
-memory_hotplugh-cleanup.patch
-mm-slobc-for_each_possible_cpu-not-nr_cpus.patch
-oom-kill-mm-locking-fix.patch
-mm-fix-mm_struct-reference-counting-bugs-in-mm-oom_killc.patch
-page_allocc-buddy-handling-cleanup.patch
-hugetlbfs-add-kconfig-help-text.patch
-selinux-fix-mls-compatibility-off-by-one-bug.patch
-asm-i386-atomich-local_irq_save-should-be-used-instead-of-local_irq_disable.patch
-x86-cpuid-and-msr-notifier-callback-section-mismatches.patch
-patch-to-limit-present-cpus-to-fake-cpu-hot-add-testing.patch
-enable-sci_emulate-to-manually-simulate-physical-hotplug-testing.patch
-drivers-acpi-busc-make-struct-acpi_sci_dir-static.patch
-x86_64-use-select-for-gart_iommu-to-enable-agp.patch
-x86_64-sparsemem-does-not-need-node_mem_map.patch
-m32r-fix-pt_regs-for.patch
-m32r-update-include-asm-m32r-semaphoreh.patch
-m32r-mappi3-reboot-support.patch
-m32r-remove-a-warning-of-m32r_sioc.patch
-m32r-update-switch_to-macro-for-tuning.patch
-uml-change-sigjmp_buf-to-jmp_buf.patch
-uml-__user-annotations.patch
-uml-physical-memory-map-file-fixes.patch
-uml-add-missing-__volatile__.patch
-fix-file-lookup-without-ref.patch
-update-obsolete_oss_driver-schedule-and-dependencies.patch
-make-the-oss-sound_via82cxxx-option-available-again.patch
-kconfigdebug-set-debug_mutex-to-off-by-default.patch
-fs-fix-ocfs2-warning-when-debug_fs-is-not-enabled.patch
-voyager-no-need-to-define-bits_per_byte-when-its-already-in-typesh.patch
-apm-fix-armada-laptops-again.patch
-doc-vm-hugetlbpage-update-2.patch
-ipmi-fix-devinit-placement.patch
-config-update-usage-help-info.patch
-fix-potential-null-pointer-deref-in-gen_init_cpio.patch
-open-ipmi-bt-overflow.patch
-parport_pc-fix-section-mismatch-warnings-v2.patch
-pnp-fix-two-messages-in-managerc.patch
-fix-dependencies-of-hugetlb_page_size_64k.patch
-fix-dependencies-of-w1_slave_ds2433_crc.patch
-tpm-spacing-cleanups.patch
-tpm-reorganize-sysfs-files.patch
-tpm-chip-struct-update.patch
-tpm-return-chip-from-tpm_register_hardware.patch
-tpm-command-duration-update.patch
-tpm-new-12-sysfs-files.patch
-tpm-new-12-sysfs-files-fix.patch
-tpm-new-12-sysfs-files-fix-fix.patch
-tpm-tpm-new-12-sysfs-files-fix-fix-fix.patch
-tpm-driver-for-next-generation-tpm-chips.patch
-tpm-driver-for-next-generation-tpm-chips-fix.patch
-tpm-driver-for-next-generation-tpm-chips-fix-fix.patch
-tpm-msecs_to_jiffies-cleanups.patch
-tpm-use-clear_bit.patch
-tpm-use-clear_bit-fix.patch
-tpm-use-clear_bit-fix-fix.patch
-tpm-use-clear_bit-fix-fix-fix.patch
-tpm-use-clear_bit-fix-fix-fix-fix.patch
-tpm-tpm_infineon-updated-to-latest-interface-changes.patch
-tpm-check-mem-start-and-len.patch
-tpm-update-bios-log-code-for-12.patch
-tpm_infineon-section-fixup.patch
-bluetooth-fix-problem-with-sco.patch
-switch-kprobes-inline-functions-to-__kprobes-for-i386.patch
-switch-kprobes-inline-functions-to-__kprobes-for-x86_64.patch
-switch-kprobes-inline-functions-to-__kprobes-for-ppc64.patch
-switch-kprobes-inline-functions-to-__kprobes-for-ia64.patch
-switch-kprobes-inline-functions-to-__kprobes-for-sparc64.patch
-ide-ati-sb600-ide-support.patch
-remove-the-obsolete-idepci_flag_force_pdc.patch
-alim15x3-uli-m-1573-south-bridge-support.patch
-fb-fix-section-mismatch-in-savagefb.patch
-radeonfb-section-mismatches.patch
-savagefb-fix-section-mismatch-warnings.patch
-fbdev-fix-return-error-of-fb_write.patch
-remove-redundant-null-checks-before-free-in-net.patch

 Merged

+remove-softlockup-from-invalidate_mapping_pages.patch
+x25-fix-for-spinlock-recurse-and-spinlock-lockup-with.patch
+off-by-1-in-kernel-power-mainc.patch
+request_irq-remove-warnings-from-irq-probing.patch
+input-fix-oops-on-mk712-load.patch
+mv643xx_eth-provide-sysfs-class-device-symlink.patch
+s390-make-qeth-buildable.patch
+tpar-oops-fix.patch
+fix-array-overrun-in-drivers-char-mwave-mwaveddc.patch
+readd-the-oss-sound_cs4232-option.patch
+avoid-printing-pointless-tsc-skew-msgs.patch
+enable-x86_pc-for-hotplug_cpu.patch
+mark-vmsplit-embedded.patch
+kprobe-cleanup-for-vm_mask-judgement.patch
+kprobe-fix-resume-execution-on-i386.patch

 2.6.17 queue (mostly)

+acpiphp-use-new-dock-driver-fix.patch

 Fix acpiphp-use-new-dock-driver.patch

+fw-memory-leakages-in-driver-acpi-videoc.patch
+acpi-idle-__read_mostly-and-de-init-static-var.patch
+acpi-suppress-power-button-event-on-s3-resume.patch

 ACPI udpates

+remove-for_each_cpu.patch

 Remove for_each_cpu().

+alsa-pcmcia-sound-devices-shouldnt-depend-on-isa.patch
+alsa-rmmod-oops-fix.patch

 ALSA fixes

+iosched-use-hlist-for-request-hashtable.patch

 iosched cleanup

+gregkh-driver-frame-buffer-remove-cmap-sysfs-interface.patch
+gregkh-driver-kobject-fix-build-error.patch
+gregkh-driver-fix-ocfs2-warning-when-debug_fs-is-not-enabled.patch
+gregkh-driver-kobject-possible-cleanups.patch
+gregkh-driver-added-uri-of-linux-kernel-development-process.patch
+gregkh-driver-class-device-add-attribute_group-creation.patch
+gregkh-driver-netdev-create-attribute_groups-with-class_device_add.patch
+gregkh-driver-tty-return-class-device-pointer-from-tty_register_device.patch
+gregkh-driver-i4l-gigaset-move-sysfs-entry-to-tty-class-device.patch

 Driver tree updates

+gregkh-driver-spi-spi_bitbang-clocking-fixes.patch

 SPI fix

+netdev-hotplug-napi-race-cleanup.patch

 net cleanup

+dvb-core-ule-fixes-and-rfc4326-additions-kernel-2616.patch
+dvb-core-ule-fixes-and-rfc4326-additions-kernel-2616-tidy.patch

 DVB feature

+vivi-build-fix.patch
+git-dvb-Kconfig-fix.patch
+git-dvb-Kconfig-fix-2.patch

 git-dvb.patch is a bit sick.

+gregkh-i2c-rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch
+gregkh-i2c-i2c-piix4-remove-fix_hstcfg-parameter.patch
+gregkh-i2c-i2c-piix4-fix-typo-in-documentation.patch
+gregkh-i2c-i2c-piix4-improve-ibm-error-message.patch
+gregkh-i2c-i2c-nforce2-add-mcp51-mcp55-support.patch
+gregkh-i2c-hwmon-hdaps-update-id-list.patch
+gregkh-i2c-hwmon-w83791d-new-driver.patch
+gregkh-i2c-hwmon-lm83-documentation-update.patch
+gregkh-i2c-hwmon-improve-Kconfig-help.patch
+gregkh-i2c-hwmon-vid-mask-per-vrm.patch

 I2C tree updates.

+gregkh-i2c-w1-possible-cleanups.patch
+gregkh-i2c-w1-fix-dependencies-of-w1_slave_ds2433_crc.patch

 i2c cleanup and fix

-i2c-add-support-for-virtual-i2c-adapters-tidy.patch
-i2c-add-support-for-virtual-i2c-adapters-fix.patch

 Folded into i2c-add-support-for-virtual-i2c-adapters.patch

+i2c-mpc-fix-up-error-handling.patch
+opencores-i2c-bus-driver.patch
+opencores-i2c-bus-driver-tidy.patch
+opencores-i2c-bus-driver-fix.patch
+i2c-pca954x-fix-initial-access-to-first-mux-switch-port.patch

 I2C updates.

+smc911x-Kconfig-fix.patch
+via-rhine-zero-pad-short-packets-on-rhine-i-ethernet-cards.patch

 netdev updates

+net-use-hlist_unhashed.patch
+ipv4-inet_init-fs_initcall.patch

 net updates

+powerpc-pseries-avoid-crash-in-pci-code-if-mem-system-not-up.patch
+powerpc-pseries-avoid-crash-in-pci-code-if-mem-system-not-up-tidy.patch

 powerpc fix

+serial-fix-uart_bug_txen-test.patch

 serial fix (needs work)

-improve-pci-config-space-writeback-tidy.patch

 Folded into improve-pci-config-space-writeback.patch

+pci-quirk-via-irq-fixup-should-only-run-for-via-southbridges.patch
+reverse-pci-config-space-restore-order.patch

 PCI fixes

-revert-pci-pci-cardbus-cards-hidden-needs-pci=assign-busses-to-fix.patch

 Dropped

+drivers-scsi-fix-proc_scsi_write-to-return-length-on.patch
+drivers-scsi-sdc-fix-uninitialized-variable-in-handling-medium-errors.patch
+drivers-scsi-aic7xxx-possible-cleanups-2.patch
+scsi-remove-documentation-scsi-cpqfctxt.patch
+enable-advansys-driver.patch
+advansys-warning-workaround.patch
+scsi-clean-up-warnings-in-advansys-driver.patch
+scsi-clean-up-warnings-in-advansys-driver-fix.patch
+mpt-fusion-driver-initialization-failure-fix.patch

 SCSI fixes

-areca-raid-linux-scsi-driver-update4.patch
-areca-raid-linux-scsi-driver-update5.patch

 Foxled into areca-raid-linux-scsi-driver.patch.

+gregkh-usb-usb-resource-leak-fix-for-whiteheat-driver.patch
+gregkh-usb-usb-add-new-itegno-usb-cdma-1x-card-support-for-pl2303.patch
+gregkh-usb-usb-storage-unusual-devs-update.patch
+gregkh-usb-usb-storage-atmel-unusual-dev-update.patch
+gregkh-usb-usb-net2280-handle-stalls-for-0-length-control-in-requests.patch
+gregkh-usb-usb-net2280-send-0-length-packets-for-ep0.patch
+gregkh-usb-usb-net2280-check-for-shared-irqs.patch
+gregkh-usb-usb-net2280-set-driver-data-before-it-is-used.patch
+gregkh-usb-usb-use-new-pci_class_serial_usb_-defines.patch
+gregkh-usb-usb-ftdi_sio-vendor-code-for-rr-cirkits-locobuffer-usb.patch
+gregkh-usb-usb-ftdi_sio-adds-support-for-iplus-device.patch
+gregkh-usb-usb-ftdi_sio-add-support-for-ask-rdr-400-series-card-reader.patch
+gregkh-usb-usb-sisusbvga-possible-cleanups.patch
+gregkh-usb-usb-allow-multiple-types-of-ehci-controllers-to-be-built-as-modules.patch
+gregkh-usb-usb-console-fix-cr-lf-issues.patch
+gregkh-usb-usb-console-fix-oops.patch
+gregkh-usb-usb-console-prevent-enodev-on-node.patch
+gregkh-usb-usb-macbook-pro-touchpad-support.patch

 USB tree updates

+fix-sco-on-some-bluetooth-adapters.patch
+fix-sco-on-some-bluetooth-adapters-tidy.patch

 USB fix

+x86_64-mm-acpi-nolapic.patch
+x86_64-mm-ia32-unistd-cleanup.patch
+x86_64-mm-large-bzimage.patch
+x86_64-mm-topology-comment.patch
+x86_64-mm-agp-select.patch
+x86_64-mm-iommu_gart_bitmap-search-to-cross-next_bit.patch
+x86_64-mm-new-compat-ptrace.patch

 x86_64 tree updates

+gregkh-devfs-devfs-die-die-die.patch
+gregkh-devfs-devfs-remove-documentation.patch
+gregkh-devfs-devfs-scrub-partitions.patch
+gregkh-devfs-devfs-scrub-init.patch
+gregkh-devfs-devfs-remove-serial-subsystem.patch
+gregkh-devfs-devfs-remove-ide-subsystem.patch
+gregkh-devfs-devfs-remove-sound-subsystem.patch
+gregkh-devfs-devfs-remove-devfs-tape.patch
+gregkh-devfs-devfs-remove-devfs_mk_dir.patch
+gregkh-devfs-devfs-remove-devfs_mk_symlink.patch
+gregkh-devfs-devfs-remove-devfs_mk_bdev.patch
+gregkh-devfs-devfs-remove-devfs_mk_cdev.patch
+gregkh-devfs-devfs-remove-devfs_remove.patch
+gregkh-devfs-devfs-remove-devfs_fs_kernel.h.patch
+gregkh-devfs-devfs-remove-misc-devfs_name.patch
+gregkh-devfs-devfs-remove-genhd-devfs_name.patch
+gregkh-devfs-devfs-remove-videodev-devfs_name.patch
+gregkh-devfs-devfs-remove-line-devfs_name.patch
+gregkh-devfs-devfs-remove-tty-devfs_name.patch
+gregkh-devfs-devfs-tty_driver_no_devfs.patch
+gregkh-devfs-devfs-minor-cleanups.patch
+gregkh-devfs-devfs-feature-removal.patch
+gregkh-devfs-ndevfs.patch

 Remove devfs

+reserve-space-for-swap-label.patch
+read-write-migration-entries-implement-correct-behavior-in-copy_one_pte.patch
+read-write-migration-entries-make-mprotect-convert-write-migration.patch
+read-write-migration-entries-make-mprotect-convert-write-migration-fix.patch
+read-write-migration-entries-make-mprotect-convert-write-migration-fix-fix.patch
+read-write-migration-entries-make-mprotect-convert-write-migration-fix-fix-fix.patch
+swsusp-rework-memory-shrinker-rev-2.patch

 Memory management updates

+pgdat-allocation-for-new-node-add-specify-node-id.patch
+pgdat-allocation-for-new-node-add-specify-node-id-powerpc-fix.patch
+pgdat-allocation-for-new-node-add-specify-node-id-tidy.patch
+pgdat-allocation-for-new-node-add-specify-node-id-fix-3.patch
+pgdat-allocation-for-new-node-add-get-node-id-by-acpi.patch
+pgdat-allocation-for-new-node-add-get-node-id-by-acpi-tidy.patch
+pgdat-allocation-for-new-node-add-generic-alloc-node_data.patch
+pgdat-allocation-for-new-node-add-generic-alloc-node_data-tidy.patch
+pgdat-allocation-for-new-node-add-refresh-node_data.patch
+pgdat-allocation-for-new-node-add-refresh-node_data-fix.patch
+pgdat-allocation-for-new-node-add-export-kswapd-start-func.patch
+pgdat-allocation-for-new-node-add-export-kswapd-start-func-tidy.patch
+pgdat-allocation-for-new-node-add-call-pgdat-allocation.patch

 Memory hotplug (node add)

+mm-introduce-remap_vmalloc_range.patch
+mm-introduce-remap_vmalloc_range-tidy.patch
+mm-introduce-remap_vmalloc_range-fix.patch
+change-gen_pool-allocator-to-not-touch-managed-memory.patch
+change-gen_pool-allocator-to-not-touch-managed-memory-update.patch
+change-gen_pool-allocator-to-not-touch-managed-memory-update-2.patch
+radix-tree-direct-data.patch
+radix-tree-small.patch
+likely-cleanup-remove-unlikely-in-sys_mprotect.patch

 More memory management updates

+x86-x86_64-avoid-irq0-ioapic-pin-collision.patch
+x86-x86_64-avoid-irq0-ioapic-pin-collision-tidy.patch

 x86_64 fix

+swsusp-add-architecture-special-saveable-pages-fix.patch

 Fix swsusp-add-architecture-special-saveable-pages-support.patch

+swsusp-i386-mark-special-saveable-unsaveable-pages-fix.patch

 Fix swsusp-i386-mark-special-saveable-unsaveable-pages.patch

+swsusp-x86_64-mark-special-saveable-unsaveable-pages-fix.patch

 Fix swsusp-x86_64-mark-special-saveable-unsaveable-pages.patch

+kernel-power-snapshotc-cleanups.patch
+swsusp-use-less-memory-during-resume.patch

 swsusp updates

-uml-prepare-fixing-compilation-output.patch

 Dropped.

+s390-fix-i-o-termination-race-in-cio.patch
+s390-enable-interrupts-on-error-path.patch
+s390-bug-in-setup_rt_frame.patch
+s390-alternate-signal-stack-handling-bug.patch
+s390-qdio-memory-allocations.patch
+s390-dasd-ioctl-never-returns.patch
+s390-fix-slab-debugging.patch
+s390-futex-atomic-operations.patch
+s390-futex-atomic-operations-part-2.patch
+s390-tape-3590-changes.patch
+s390-segment-operation-error-codes.patch
+s390-instruction-processing-damage-handling.patch
+s390-add-read_mostly-optimization.patch
+s390-dasd-device-identifiers.patch
+s390-dasd-device-identifiers-fix.patch
+s390-new-system-calls.patch

 s390 updates

-fix-cdrom-being-confused-on-using-kdump-tweaks.patch

 Folded into fix-cdrom-being-confused-on-using-kdump.patch

+cond-resched-might-sleep-fix.patch
+enhancing-accessibility-of-lxdialog.patch
+the-scheduled-unexport-of-insert_resource.patch
+jbd-fix-bug-in-journal_commit_transaction.patch
+rename-swapper-to-idle.patch
+oss-cs46xx-cleanup-and-tiny-bugfix.patch
+i4l-memory-leak-fix-for-sc_ioctl.patch
+isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub.patch
+invert-irq-migrationc-brach-prediction.patch
+x86-powerpc-make-hardirq_ctx-and-softirq_ctx-__read_mostly.patch
+jbd-avoid-kfree-null.patch
+ext3_clear_inode-avoid-kfree-null.patch
+make-noirqdebug-irqfixup-__read_mostly-add-unlikely.patch
+leds-amstrad-delta-led-support.patch
+leds-amstrad-delta-led-support-tidy.patch
+update-devicestxt.patch
+binfmt_elf-codingstyle-cleanup-and-remove-some-pointless-casts.patch
+binfnt_elf-remove-more-casts.patch
+fix-incorrect-sa_onstack-behaviour-for-64-bit-processes.patch
+percpu-counter-data-type-changes-to-suppport.patch
+percpu-counter-data-type-changes-to-suppport-fix.patch
+remove-unlikely-in-might_sleep_if.patch
+process-events-header-cleanup.patch
+process-events-license-change.patch
+strstrip-api.patch
+ipmi-strstrip-conversion.patch
+rcu-introduce-rcu_needs_cpu-interface.patch
+s390-exploit-rcu_needs_cpu-interface.patch

 Misc updates

+time-rename-clocksource-functions.patch
+make-pmtmr_ioport-__read_mostly.patch

 Update time management patches in -mm.

+kprobe-boost-2byte-opcodes-on-i386.patch
+kprobemulti-kprobe-posthandler-for-booster.patch
+notify-page-fault-call-chain-for-x86_64.patch
+notify-page-fault-call-chain-for-i386.patch
+notify-page-fault-call-chain-for-ia64.patch
+notify-page-fault-call-chain-for-powerpc.patch
+notify-page-fault-call-chain-for-sparc64.patch
+kprobes-registers-for-notify-page-fault.patch
+notify-page-fault-call-chain.patch

 kprobes updates

-dlm-core-locking.patch
-dlm-core-locking-resend-lookups.patch
-dlm-lockspaces-callbacks-directory.patch
-dlm-communication.patch
-dlm-recovery.patch
-dlm-recovery-clear-new_master-flag.patch
-dlm-recovery-remove-true-false-defines.patch
-dlm-configuration.patch
-dlm-device-interface.patch
-dlm-device-interface-fix-device-refcount.patch
-dlm-device-interface-dlm-force-unlock.patch
-dlm-device-interface-missing-variable.patch
-dlm-device-interface-check-allocation.patch
-dlm-device-interface-fix-unlock-race.patch
-dlm-device-interface-use-kzalloc.patch
-dlm-debug-fs.patch
-dlm-build.patch
-dlm-node-weights.patch
-dlm-rsb-flag-ops-with-inlined-functions.patch
-dlm-rework-recovery-control.patch
-dlm-better-handling-of-first-lock.patch
-dlm-no-directory-option.patch
-dlm-release-list-of-root-rsbs.patch
-dlm-return-error-in-status-reply.patch
-configfs-export-config_group_find_obj.patch
-dlm-use-configfs.patch
-dlm-remove-file.patch
-dlm-use-jhash.patch
-dlm-maintainer.patch
-drivers-dlm-fix-up-schedule_timeout-usage.patch
-dlm-cleanup-unused-functions.patch
-dlm-include-own-headers.patch
-dlm-sem2mutex.patch

 Dropped.

+smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing.patch
+smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing-fix.patch
+sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
+sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks-fix-2.patch

 CPU scheduler updates

+rtmutex-remove-buggy-bug_on-in-pi-boosting-code.patch
+futex-pi-enforce-waiter-bit-when-owner-died-is-detected.patch
+rtmutex-debug-printk-correct-task-information.patch
+futex-pi-make-use-of-restart_block-when-interrupted.patch

 pi-futex updates

+proc-dont-lock-task_structs-indefinitely-task_mmu-small-fixes.patch

 Fix proc-dont-lock-task_structs-indefinitely.patch

+ide-pdc202xx_oldc-remove-unneeded-tuneproc-call.patch
+ide-hpt3xxn-clocking-fixes.patch
+ide-io-increase-timeout-value-to-allow-for-slave-wakeup.patch
+ide-actually-honor-drives-minimum-pio-dma-cycle-times.patch

 IDE updates

+savagefb-allocate-space-for-current-and-saved-register.patch
+savagefb-add-state-save-and_restore-hooks.patch
+savagefb-add-state-save-and_restore-hooks-tidy.patch
+savagefb-add-state-save-and_restore-hooks-fix.patch
+suspend-documentation-update-for-ibm-thinkpad-x30.patch
+asiliantfb-add-help-text-in-kconfig.patch
+backlight-locomo-backlight-driver-updates.patch
+fbdev-cleanup-the-config_video_select-mess.patch
+fbdev-remove-duplicate-includes.patch
+matroxfb-fix-dvi-setup-to-be-more-compatible.patch

 fbdev updates

+drivers-char-ipmi-ipmi_msghandlerc-make-proc_ipmi_root-static.patch
+drivers-message-i2o-iopc-unexport-i2o_msg_nop.patch

 Little fixes




All 707 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc2/2.6.17-rc2-mm1/patch-list


