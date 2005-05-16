Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVEPJPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVEPJPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVEPJPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:15:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:56270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261470AbVEPJNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:13:44 -0400
Date: Mon, 16 May 2005 02:13:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc4-mm2
Message-Id: <20050516021302.13bd285a.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/


- davem has set up a mm-commits mailing list so people can review things
  which are added to or removed from the -mm tree.  Do

	echo subscribe mm-commits | mail majordomo@vger.kernel.org

- x86_64 architecture update from Andi.

- Everything up to and including `spurious-interrupt-fix.patch' is planned
  for 2.6.12 merging.  Plus a few other things in there.

- Another DVB subsystem update




Changes since 2.6.12-rc4-mm1:

-sis900-must-select-mii.patch
-move_vma-comment.patch
-remove-drivers-net-skfp-lnkstatc.patch

 Merged

+mm-acct-accounting-fix.patch

 VM beancounting fix

+x86_64-reduce-nmi-watchdog-stack-usage.patch
+x86_64-readd-missing-tests-in-entrys.patch
+x86_64-add-a-guard-page-at-the-end-of-the-47bit-address.patch
+x86_64-fix-defaults-for-physical-core-id-in.patch
+x86_64-increase-number-of-io-apics.patch
+x86_64-dont-look-up-struct-page-pointer-of-physical.patch
+x86_64-update-tsc-sync-algorithm.patch
+x86_64-remove-x86_apicid-field.patch
+x86_64-dont-print-the-internal-k8c-flag-in.patch
+x86_64-remove-unique-apic-io-apic-id-check.patch
+x86_64-add-pmtimer-support.patch
+x86_64-check-if-ptrace-rip-is-canonical.patch
+x86_64-fix-canonical-checking-for-segment-registers-in.patch
+x86_64-when-checking-vmalloc-mappings-dont-use.patch
+x86_64-fix-oem-hpet-check.patch
+x86_64-make-vsyscallc-compile-without-config_sysctl.patch
+x86_64-collected-nmi-watchdog-fixes.patch
+x86_64-collected-nmi-watchdog-fixes-warning-fix.patch
+x86_64-dont-assume-bsp-has-id-0-in-new-smp-bootup.patch
+x86_64-update-defconfig.patch

 x86_64 update

+mm-nommuc-try-to-fix-__vmalloc.patch

 nommu build fix

+drivers-input-keyboard-atkbdc-fix-off-by-one-errors.patch

 input driver bounds fixes

+s390-dasd-set-online-failure.patch

 s/390 driver fix

+swapout-oops-fix.patch

 swapout fix

+packet-driver-ioctl-fix.patch
+packet-driver-ioctl-fix-fix.patch

 packet driver fix

+crypto-fix-null-encryption-compression.patch

 crypto fix

+cdrw-dvd-packet-writing-data-corruption-fix.patch

 Fix rare data corruption in packet-writing driver

+spurious-interrupt-fix.patch

 Fix spurious interrupt on ia64

-gregkh-01-driver-gregkh-driver-001_driver-pm-diag-update.patch
-gregkh-01-driver-gregkh-driver-002_driver-name-const-01.patch
-gregkh-01-driver-gregkh-driver-003_driver-name-const-02.patch
-gregkh-01-driver-gregkh-driver-004_driver-name-const-03.patch
-gregkh-01-driver-gregkh-driver-005_driver-name-const-04.patch
-gregkh-01-driver-gregkh-driver-006_driver-name-const-05.patch
-gregkh-01-driver-gregkh-driver-007_driver-name-const-06.patch
-gregkh-01-driver-gregkh-driver-008_sysfs-show_store_eio-01.patch
-gregkh-01-driver-gregkh-driver-009_sysfs-show_store_eio-02.patch
-gregkh-01-driver-gregkh-driver-010_sysfs-show_store_eio-03.patch
-gregkh-01-driver-gregkh-driver-011_sysfs-show_store_eio-04.patch
-gregkh-01-driver-gregkh-driver-012_sysfs-show_store_eio-05.patch
-gregkh-01-driver-gregkh-driver-013_class-01-core.patch
-gregkh-01-driver-gregkh-driver-014_class-02-tty.patch
-gregkh-01-driver-gregkh-driver-015_class-03-input.patch
-gregkh-01-driver-gregkh-driver-016_class-04-usb.patch
-gregkh-01-driver-gregkh-driver-017_class-05-sound.patch
-gregkh-01-driver-gregkh-driver-018_class-06-block.patch
-gregkh-01-driver-gregkh-driver-019_class-07-char.patch
-gregkh-01-driver-gregkh-driver-020_class-08-ieee1394.patch
-gregkh-01-driver-gregkh-driver-021_class-09-scsi.patch
-gregkh-01-driver-gregkh-driver-022_class-10-arch.patch
-gregkh-01-driver-gregkh-driver-023_class-11-drivers.patch
-gregkh-01-driver-gregkh-driver-024_class-11-drivers-usb-fix.patch
-gregkh-01-driver-gregkh-driver-025_class-12-the_rest.patch
-gregkh-01-driver-gregkh-driver-026_class-13-kerneldoc.patch
-gregkh-01-driver-gregkh-driver-027_class-14-no_more_class_simple.patch
-gregkh-01-driver-gregkh-driver-028_fix-make-mandocs-after-class_simple-removal.patch
-gregkh-01-driver-gregkh-driver-029_klist-01.patch
-gregkh-01-driver-gregkh-driver-030_klist-02.patch
-gregkh-01-driver-gregkh-driver-031_klist-03.patch
-gregkh-01-driver-gregkh-driver-032_klist-04.patch
-gregkh-01-driver-gregkh-driver-033_klist-05.patch
-gregkh-01-driver-gregkh-driver-034_klist-06.patch
-gregkh-01-driver-gregkh-driver-035_klist-07.patch
-gregkh-01-driver-gregkh-driver-036_klist-08.patch
-gregkh-01-driver-gregkh-driver-037_klist-09.patch
-gregkh-01-driver-gregkh-driver-038_klist-10.patch
-gregkh-01-driver-gregkh-driver-039_klist-11.patch
-gregkh-01-driver-gregkh-driver-040_klist-12.patch
-gregkh-01-driver-gregkh-driver-041_klist-13.patch
-gregkh-01-driver-gregkh-driver-042_klist-14.patch
-gregkh-01-driver-gregkh-driver-043_klist-15.patch
-gregkh-01-driver-gregkh-driver-044_klist-16.patch
-gregkh-01-driver-gregkh-driver-045_klist-17.patch
-gregkh-01-driver-gregkh-driver-046_klist-18.patch
-gregkh-01-driver-gregkh-driver-047_klist-scsi-01.patch
-gregkh-01-driver-gregkh-driver-048_klist-scsi-02.patch
-gregkh-01-driver-gregkh-driver-049_klist-20.patch
-gregkh-01-driver-gregkh-driver-050_klist-21.patch
-gregkh-01-driver-gregkh-driver-051_klist-22.patch
-gregkh-01-driver-gregkh-driver-052_klist-23.patch
-gregkh-01-driver-gregkh-driver-053_klist-ieee1394.patch
-gregkh-01-driver-gregkh-driver-054_klist-pcie.patch
-gregkh-01-driver-gregkh-driver-055_klist-24.patch
-gregkh-01-driver-gregkh-driver-056_klist-25.patch
-gregkh-01-driver-gregkh-driver-057_klist-26.patch
-gregkh-01-driver-gregkh-driver-058_klist-usb_node_attached_fix.patch
-gregkh-01-driver-gregkh-driver-059_klist-sn_fix.patch
-gregkh-01-driver-gregkh-driver-060_klist-driver_detach_fixes.patch
-gregkh-01-driver-gregkh-driver-061_klist-usbcore-dont_call_device_release_driver_recursivly.patch
-gregkh-01-driver-gregkh-driver-062_driver-create-unregister_node.patch
-gregkh-01-driver-gregkh-driver-063_attr_void.patch
+gregkh-driver-driver-pm-diag-update.patch
+gregkh-driver-driver-remove-detach_state.patch
+gregkh-driver-driver-name-const-01.patch
+gregkh-driver-driver-name-const-02.patch
+gregkh-driver-driver-name-const-03.patch
+gregkh-driver-driver-name-const-04.patch
+gregkh-driver-driver-name-const-05.patch
+gregkh-driver-driver-name-const-06.patch
+gregkh-driver-sysfs-show_store_eio-01.patch
+gregkh-driver-sysfs-show_store_eio-02.patch
+gregkh-driver-sysfs-show_store_eio-03.patch
+gregkh-driver-sysfs-show_store_eio-04.patch
+gregkh-driver-sysfs-show_store_eio-05.patch
+gregkh-driver-class-01-core.patch
+gregkh-driver-class-02-tty.patch
+gregkh-driver-class-03-input.patch
+gregkh-driver-class-04-usb.patch
+gregkh-driver-class-05-sound.patch
+gregkh-driver-class-06-block.patch
+gregkh-driver-class-07-char.patch
+gregkh-driver-class-08-ieee1394.patch
+gregkh-driver-class-09-scsi.patch
+gregkh-driver-class-10-arch.patch
+gregkh-driver-class-11-drivers.patch
+gregkh-driver-class-11-drivers-usb-fix.patch
+gregkh-driver-class-12-the_rest.patch
+gregkh-driver-class-13-kerneldoc.patch
+gregkh-driver-class-14-no_more_class_simple.patch
+gregkh-driver-fix-make-mandocs-after-class_simple-removal.patch
+gregkh-driver-klist-01.patch
+gregkh-driver-klist-02.patch
+gregkh-driver-klist-03.patch
+gregkh-driver-klist-04.patch
+gregkh-driver-klist-05.patch
+gregkh-driver-klist-06.patch
+gregkh-driver-klist-07.patch
+gregkh-driver-klist-08.patch
+gregkh-driver-klist-09.patch
+gregkh-driver-klist-10.patch
+gregkh-driver-klist-11.patch
+gregkh-driver-klist-12.patch
+gregkh-driver-klist-13.patch
+gregkh-driver-klist-14.patch
+gregkh-driver-klist-15.patch
+gregkh-driver-klist-16.patch
+gregkh-driver-klist-17.patch
+gregkh-driver-klist-18.patch
+gregkh-driver-klist-scsi-01.patch
+gregkh-driver-klist-scsi-02.patch
+gregkh-driver-klist-20.patch
+gregkh-driver-klist-21.patch
+gregkh-driver-klist-22.patch
+gregkh-driver-klist-23.patch
+gregkh-driver-klist-ieee1394.patch
+gregkh-driver-klist-pcie.patch
+gregkh-driver-klist-24.patch
+gregkh-driver-klist-25.patch
+gregkh-driver-klist-26.patch
+gregkh-driver-klist-usb_node_attached_fix.patch
+gregkh-driver-klist-sn_fix.patch
+gregkh-driver-klist-driver_detach_fixes.patch
+gregkh-driver-klist-usbcore-dont_call_device_release_driver_recursivly.patch
+gregkh-driver-driver-create-unregister_node.patch
+gregkh-driver-attr_void.patch

 Greg's patches got renamed again.  We're now using stable naming.

-gregkh-02-i2c-gregkh-i2c-001_i2c-ali1563.patch
-gregkh-02-i2c-gregkh-i2c-002_i2c-address_range_removal.patch
-gregkh-02-i2c-gregkh-i2c-003_i2c-address_merge_video.patch
-gregkh-02-i2c-gregkh-i2c-004_w1-ds18xx_sensors.patch
-gregkh-02-i2c-gregkh-i2c-005_w1-new_rom_family.patch
-gregkh-02-i2c-gregkh-i2c-006_i2c-rtc8564_duplicate_include.patch
-gregkh-02-i2c-gregkh-i2c-007_i2c-vid_h.patch
-gregkh-02-i2c-gregkh-i2c-008_i2c-atxp1.patch
-gregkh-02-i2c-gregkh-i2c-009_i2c-atxp1-cleanup.patch
-gregkh-02-i2c-gregkh-i2c-010_i2c-ds1337-01.patch
-gregkh-02-i2c-gregkh-i2c-011_i2c-ds1337-02.patch
-gregkh-02-i2c-gregkh-i2c-012_i2c-ds1337-03.patch
-gregkh-02-i2c-gregkh-i2c-013_i2c-ds1337_make_time_format_consistent.patch
-gregkh-02-i2c-gregkh-i2c-014_i2c-ds1337_i2c_transfer_check.patch
-gregkh-02-i2c-gregkh-i2c-015_i2c-ds1337_search_by_bus_number.patch
-gregkh-02-i2c-gregkh-i2c-016_i2c-ds1337-config-update.patch
-gregkh-02-i2c-gregkh-i2c-017_i2c-config_cleanup-01.patch
-gregkh-02-i2c-gregkh-i2c-018_i2c-config_cleanup-02.patch
-gregkh-02-i2c-gregkh-i2c-019_i2c-adm9240.patch
-gregkh-02-i2c-gregkh-i2c-020_i2c-w83627ehf.patch
-gregkh-02-i2c-gregkh-i2c-021_i2c-w83627ehf-cleanup.patch
-gregkh-02-i2c-gregkh-i2c-022_i2c-smsc47m1.patch
-gregkh-02-i2c-gregkh-i2c-023_i2c-spelling_fixes.patch
-gregkh-02-i2c-gregkh-i2c-024_i2c-mpc-share_interrupt.patch
-gregkh-02-i2c-gregkh-i2c-025_i2c-remove_redundancy_from_i2c_core.patch
-gregkh-02-i2c-gregkh-i2c-026_i2c-remove_delay_h_from_via686a.patch
+gregkh-i2c-i2c-ali1563.patch
+gregkh-i2c-i2c-address_range_removal.patch
+gregkh-i2c-i2c-address_merge_video.patch
+gregkh-i2c-w1-ds18xx_sensors.patch
+gregkh-i2c-w1-new_rom_family.patch
+gregkh-i2c-i2c-rtc8564_duplicate_include.patch
+gregkh-i2c-i2c-vid_h.patch
+gregkh-i2c-i2c-atxp1.patch
+gregkh-i2c-i2c-atxp1-cleanup.patch
+gregkh-i2c-i2c-ds1337-01.patch
+gregkh-i2c-i2c-ds1337-02.patch
+gregkh-i2c-i2c-ds1337-03.patch
+gregkh-i2c-i2c-ds1337_make_time_format_consistent.patch
+gregkh-i2c-i2c-ds1337_i2c_transfer_check.patch
+gregkh-i2c-i2c-ds1337_search_by_bus_number.patch
+gregkh-i2c-i2c-ds1337-config-update.patch
+gregkh-i2c-i2c-ds1337-export-ds1337_do_command.patch
+gregkh-i2c-i2c-config_cleanup-01.patch
+gregkh-i2c-i2c-config_cleanup-02.patch
+gregkh-i2c-i2c-adm9240.patch
+gregkh-i2c-i2c-w83627ehf.patch
+gregkh-i2c-i2c-w83627ehf-cleanup.patch
+gregkh-i2c-i2c-smsc47m1.patch
+gregkh-i2c-i2c-spelling_fixes.patch
+gregkh-i2c-i2c-mpc-share_interrupt.patch
+gregkh-i2c-i2c-remove_redundancy_from_i2c_core.patch
+gregkh-i2c-i2c-remove_delay_h_from_via686a.patch
+gregkh-i2c-i2c-w83627hf-fan-divisor-fix.patch
+gregkh-i2c-i2c-rename-cpu0_vid.patch

 Ditto.

+print-kbd-and-aux-irqs-correctly.patch

 Fix IRQ repotring printks

+git-jfs.patch

 JFS development tree

+git-libata.patch

 libata (SATA) development tree

-bk-netdev.patch

 Dropped

+git-netdev-8139cp.patch
+git-netdev-8139too-iomap.patch
+git-netdev-amd8111.patch
+git-netdev-e100.patch
+git-netdev-e1000.patch
+git-netdev-forcedeth.patch
+git-netdev-iff-running.patch
+git-netdev-ixgb.patch
+git-netdev-janitor.patch
+git-netdev-orinoco.patch
+git-netdev-ppp.patch
+git-netdev-r8169.patch
+git-netdev-register-netdev.patch
+git-netdev-remove-drivers.patch
+git-netdev-sis900.patch
+git-netdev-skge.patch
+git-netdev-smc91x-eeprom.patch
+git-netdev-starfire.patch

 Jeff's netdev trees (mainly network device drivers)

+#git-netdev-wifi.patch

 This isn't included because it's busted.

-gregkh-03-pci-gregkh-pci-001_pci-hotplug-shpc-power-fix.patch
-gregkh-03-pci-gregkh-pci-002_pci-pciehp-downstream-port-fix.patch
-gregkh-03-pci-gregkh-pci-003_pci-cpci-update.patch
-gregkh-03-pci-gregkh-pci-004_pci-remove-pci_visit_dev.patch
-gregkh-03-pci-gregkh-pci-005_pci-pci-transparent-bridge-handling-improvements-pci-core.patch
-gregkh-03-pci-gregkh-pci-006_pci-pirq_table_addr-out-of-range.patch
-gregkh-03-pci-gregkh-pci-007_pci-get_device-01.patch
-gregkh-03-pci-gregkh-pci-008_pci-get_device-02.patch
-gregkh-03-pci-gregkh-pci-009_pci-acpiphp-02.patch
-gregkh-03-pci-gregkh-pci-010_pci-acpiphp-03.patch
-gregkh-03-pci-gregkh-pci-011_pci-acpiphp-04.patch
-gregkh-03-pci-gregkh-pci-012_pci-acpiphp-05.patch
-gregkh-03-pci-gregkh-pci-013_pci-acpiphp-06.patch
-gregkh-03-pci-gregkh-pci-014_pci-acpiphp-07.patch
-gregkh-03-pci-gregkh-pci-015_pci-acpiphp-08.patch
-gregkh-03-pci-gregkh-pci-016_pci-acpiphp-09.patch
-gregkh-03-pci-gregkh-pci-017_pci-acpiphp-10.patch
-gregkh-03-pci-gregkh-pci-018_pci-acpiphp-11.patch
-gregkh-03-pci-gregkh-pci-019_pci-acpiphp-12.patch
-gregkh-03-pci-gregkh-pci-020_pci-acpiphp-13.patch
-gregkh-03-pci-gregkh-pci-021_pci-acpiphp-14.patch
-gregkh-03-pci-gregkh-pci-022_pci-acpiphp-15.patch
-gregkh-03-pci-gregkh-pci-023_pci-acpiphp-16.patch
-gregkh-03-pci-gregkh-pci-024_pci-acpiphp-17.patch
-gregkh-03-pci-gregkh-pci-025_pci-acpiphp-18.patch
-gregkh-03-pci-gregkh-pci-026_pci-acpiphp-19.patch
-gregkh-03-pci-gregkh-pci-027_pci-acpiphp-20.patch
-gregkh-03-pci-gregkh-pci-028_pci-serverworks-gc-quirk.patch
+gregkh-pci-pci-hotplug-shpc-power-fix.patch
+gregkh-pci-pci-pciehp-downstream-port-fix.patch
+gregkh-pci-pci-cpci-update.patch
+gregkh-pci-pci-remove-pci_visit_dev.patch
+gregkh-pci-pci-modalias-sysfs.patch
+gregkh-pci-pci-modalias-hotplug.patch
+gregkh-pci-pci-pci-transparent-bridge-handling-improvements-pci-core.patch
+gregkh-pci-pci-pirq_table_addr-out-of-range.patch
+gregkh-pci-pci-get_device-01.patch
+gregkh-pci-pci-get_device-02.patch
+gregkh-pci-pci-acpiphp-02.patch
+gregkh-pci-pci-acpiphp-03.patch
+gregkh-pci-pci-acpiphp-04.patch
+gregkh-pci-pci-acpiphp-05.patch
+gregkh-pci-pci-acpiphp-06.patch
+gregkh-pci-pci-acpiphp-07.patch
+gregkh-pci-pci-acpiphp-08.patch
+gregkh-pci-pci-acpiphp-09.patch
+gregkh-pci-pci-acpiphp-10.patch
+gregkh-pci-pci-acpiphp-11.patch
+gregkh-pci-pci-acpiphp-12.patch
+gregkh-pci-pci-acpiphp-13.patch
+gregkh-pci-pci-acpiphp-14.patch
+gregkh-pci-pci-acpiphp-15.patch
+gregkh-pci-pci-acpiphp-16.patch
+gregkh-pci-pci-acpiphp-17.patch
+gregkh-pci-pci-acpiphp-18.patch
+gregkh-pci-pci-acpiphp-19.patch
+gregkh-pci-pci-acpiphp-20.patch
+gregkh-pci-pci-serverworks-gc-quirk.patch

 Greg's PCI devel tree

+add-scsi-changer-driver.patch
+add-scsi-changer-driver-gregkh-driver-fix.patch

 Bring back the SCSI changer driver

-gregkh-04-USB-gregkh-usb-001_usb-usbnet-fixes.patch
-gregkh-04-USB-gregkh-usb-002_usb-ehci-suspend-stop-timer.patch
-gregkh-04-USB-gregkh-usb-003_usb-g_file_storage_min.patch
-gregkh-04-USB-gregkh-usb-004_usb-g_file_storage_stall.patch
-gregkh-04-USB-gregkh-usb-005_usb-omap_udc_update.patch
-gregkh-04-USB-gregkh-usb-006_usb-isp116x-hcd-add.patch
-gregkh-04-USB-gregkh-usb-007_usb-isp116x-hcd-fix.patch
-gregkh-04-USB-gregkh-usb-008_usb-turn-a-user-mode-driver-error-into-a-hard-error.patch
-gregkh-04-USB-gregkh-usb-009_usb-uhci-01.patch
-gregkh-04-USB-gregkh-usb-010_usb-uhci-02.patch
-gregkh-04-USB-gregkh-usb-011_usb-uhci-03.patch
-gregkh-04-USB-gregkh-usb-012_usb-uhci-04.patch
-gregkh-04-USB-gregkh-usb-013_usb-uhci-05.patch
-gregkh-04-USB-gregkh-usb-014_usb-uhci-06.patch
-gregkh-04-USB-gregkh-usb-015_usb-uhci-07.patch
-gregkh-04-USB-gregkh-usb-016_usb-uhci-08.patch
-gregkh-04-USB-gregkh-usb-017_usb-root_hub_irq.patch
-gregkh-04-USB-gregkh-usb-018_usb-cdc_acm.patch
-gregkh-04-USB-gregkh-usb-019_usb-usbtest.patch
-gregkh-04-USB-gregkh-usb-020_usb-ohci_reboot_notifier.patch
-gregkh-04-USB-gregkh-usb-021_usb_serial_status.patch
-gregkh-04-USB-gregkh-usb-022_usb-zd1201_pm.patch
-gregkh-04-USB-gregkh-usb-023_usb-zd1201_pm-02.patch
-gregkh-04-USB-gregkh-usb-024_usb-remove_hub_set_power_budget.patch
-gregkh-04-USB-gregkh-usb-025_usb-device_pointer.patch
-gregkh-04-USB-gregkh-usb-026_usb-hcd_fix_for_remove_hub_set_power_budget.patch
-gregkh-04-USB-gregkh-usb-027_usb-usbcore_usb_add_hcd.patch
-gregkh-04-USB-gregkh-usb-028_usb-hcds_no_more_register_root_hub.patch
-gregkh-04-USB-gregkh-usb-029_usb-ub_multi_lun.patch
-gregkh-04-USB-gregkh-usb-030_usb-rndis_cleanups.patch
-gregkh-04-USB-gregkh-usb-031_usb-ethernet_gadget_cleanups.patch
-gregkh-04-USB-gregkh-usb-032_usb-omap_udc_cleanups.patch
-gregkh-04-USB-gregkh-usb-033_usb-dummy_hcd-otg.patch
-gregkh-04-USB-gregkh-usb-034_usb-dummy_hcd-FEAT.patch
-gregkh-04-USB-gregkh-usb-035_usb-dummy_hcd-pdevs.patch
-gregkh-04-USB-gregkh-usb-036_usb-dummy_hcd-centralize-link.patch
-gregkh-04-USB-gregkh-usb-037_usb-dummy_hcd-root-hub_no-polling.patch
-gregkh-04-USB-gregkh-usb-038_usb-remove_pwc_changelog.patch
-gregkh-04-USB-gregkh-usb-039_usb-add-new-wacom-device-to-usb-hid-core-list.patch
-gregkh-04-USB-gregkh-usb-040_usb-urb_documentation.patch
-gregkh-04-USB-gregkh-usb-041_usb-idmouse_update.patch
-gregkh-04-USB-gregkh-usb-042_usb-gadget-kconfig.patch
-gregkh-04-USB-gregkh-usb-043_usb-gadget-setup-api-change.patch
-gregkh-04-USB-gregkh-usb-044_usb-gadget-setup-api-change-net2280.patch
-gregkh-04-USB-gregkh-usb-045_usb-gadget-setup-api-change-goku_udc.patch
-gregkh-04-USB-gregkh-usb-046_usb-gadget-pxa2xx_udc-updates.patch
-gregkh-04-USB-gregkh-usb-047_usb-ehci-minor-updates.patch
-gregkh-04-USB-gregkh-usb-048_usb-earthmate-hid-blacklist.patch
+gregkh-usb-usb-usbnet-fixes.patch
+gregkh-usb-usb-ehci-suspend-stop-timer.patch
+gregkh-usb-usb-modalias-sysfs.patch
+gregkh-usb-usb-cypress_m8-add-lt-20-support.patch
+gregkh-usb-usb-g_file_storage_min.patch
+gregkh-usb-usb-g_file_storage_stall.patch
+gregkh-usb-usb-omap_udc_update.patch
+gregkh-usb-usb-isp116x-hcd-add.patch
+gregkh-usb-usb-isp116x-hcd-fix.patch
+gregkh-usb-usb-turn-a-user-mode-driver-error-into-a-hard-error.patch
+gregkh-usb-usb-uhci-01.patch
+gregkh-usb-usb-uhci-02.patch
+gregkh-usb-usb-uhci-03.patch
+gregkh-usb-usb-uhci-04.patch
+gregkh-usb-usb-uhci-05.patch
+gregkh-usb-usb-uhci-06.patch
+gregkh-usb-usb-uhci-07.patch
+gregkh-usb-usb-uhci-08.patch
+gregkh-usb-usb-root_hub_irq.patch
+gregkh-usb-usb-cdc_acm.patch
+gregkh-usb-usb-usbtest.patch
+gregkh-usb-usb-ohci_reboot_notifier.patch
+gregkh-usb-usb_serial_status.patch
+gregkh-usb-usb-zd1201_pm.patch
+gregkh-usb-usb-zd1201_pm-02.patch
+gregkh-usb-usb-remove_hub_set_power_budget.patch
+gregkh-usb-usb-device_pointer.patch
+gregkh-usb-usb-hcd_fix_for_remove_hub_set_power_budget.patch
+gregkh-usb-usb-usbcore_usb_add_hcd.patch
+gregkh-usb-usb-hcds_no_more_register_root_hub.patch
+gregkh-usb-usb-ub_multi_lun.patch
+gregkh-usb-usb-rndis_cleanups.patch
+gregkh-usb-usb-ethernet_gadget_cleanups.patch
+gregkh-usb-usb-omap_udc_cleanups.patch
+gregkh-usb-usb-dummy_hcd-otg.patch
+gregkh-usb-usb-dummy_hcd-FEAT.patch
+gregkh-usb-usb-dummy_hcd-pdevs.patch
+gregkh-usb-usb-dummy_hcd-centralize-link.patch
+gregkh-usb-usb-dummy_hcd-root-hub_no-polling.patch
+gregkh-usb-usb-remove_pwc_changelog.patch
+gregkh-usb-usb-add-new-wacom-device-to-usb-hid-core-list.patch
+gregkh-usb-usb-urb_documentation.patch
+gregkh-usb-usb-idmouse_update.patch
+gregkh-usb-usb-gadget-kconfig.patch
+gregkh-usb-usb-gadget-setup-api-change.patch
+gregkh-usb-usb-gadget-setup-api-change-net2280.patch
+gregkh-usb-usb-gadget-setup-api-change-goku_udc.patch
+gregkh-usb-usb-gadget-pxa2xx_udc-updates.patch
+gregkh-usb-usb-ehci-minor-updates.patch
+gregkh-usb-usb-earthmate-hid-blacklist.patch
+gregkh-usb-usb-usbatm-1.patch
+gregkh-usb-usb-usbatm-2.patch
+gregkh-usb-usb-usbatm-3.patch
+gregkh-usb-usb-usbatm-4.patch
+gregkh-usb-usb-usbatm-5.patch
+gregkh-usb-usb-dummy_hcd-sparse-cleanups.patch
+gregkh-usb-usb-dummy_hcd-suspend-and-resume.patch

 Greg's USB tree

-zd1201-build-fix.patch

 Seems that this reappeared in one of Jeff's trees, but I think it's wrong.

+mystery-ide-fix.patch

 Undocumented but apparently terribly important IDE fix.

+sparsemem-memory-model-fix.patch
+sparsemem-memory-model-for-i386-fix.patch

 Kick the sparsemem stuff into shape.

-fix-ieee80211_crypt_-selects.patch

 Merged, or fixed by other means, or simply broken.

+fix-atm-build-with-o=.patch
+drivers-net-hamradio-baycom_eppc-cleanups.patch
+ppp_mppe-add-ppp-mppe-encryption-module.patch
+dm9000-network-driver-bugfix.patch
+documentation-networking-dmfetxt-make-documentation-nicer.patch

 Networking fixes

+ppc64-abolish-ioremap_mm.patch

 ppc64 cleanup

+mips-add-resource-management-to-pmu.patch

 MIPS power management addition

+platform-smis-and-their-interferance-with-tsc-based-delay-calibration-fix.patch

 Fix platform-smis-and-their-interferance-with-tsc-based-delay-calibration.patch

+adjust-i386-watchdog-tick-calculation.patch
+allow-early-printk-to-use-more-than-25-lines.patch

 x86 fixes

-remove-unique-apic-io-apic-id-check.patch
-x86_64-dont-assume-bp-to-be-the-first-one-in-madt-mps.patch

 Drop a couple of x86_64 patches which are obsoleted by Andi's patches.

+optimise-storage-of-read-mostly-variables-x86_64-fix-fix.patch

 Yet another fix to optimise-storage-of-read-mostly-variables.patch

+x86_64-eliminate-duplicate-rdpmc-definition.patch

 x86_64 fixlet

+dmi-move-acpi-boot-quirk.patch
+dmi-move-acpi-sleep-quirk.patch
+dmi-remove-central-blacklist.patch
+dmi-code-spring-cleanup.patch

 DMI code cleanups and fixes

+alpha-osf_sys-use-helper-functions-to-convert-between-tv-and-jiffies.patch

 Alpha code cleanup

+kprobes-function-return-probes-fix-4.patch
+kprobes-arch_supports_kretprobes-cleanup.patch

 Fix kprobes-function-return-probes.patch even more

-fix-pci-mmap-on-ppc-and-ppc64-fix.patch

 Folded into fix-pci-mmap-on-ppc-and-ppc64.patch

+dont-force-o_largefile-for-32-bit-processes-on-ia64-2612-rc3.patch

 ia64 x86 emulation fix

+ide-floppy-adjustments.patch

 ide-floppy build fix

+adjust-per_cpu-definition-in-non-smp-case.patch

 per_cpu() build fix

+apply-quotation-handling-to-makefilebuild.patch

 makefile robustness

+pcmcia-ds-handle-any-error-code.patch

 pcmcia fix

+mempool-only-init-waitqueue-in-slow-path.patch

 mempool microoptimisation

+seccomp-disable-tsc-for-seccomp-enabled-tasks.patch

 Disable TSC when using secure computing.  Adds code to switch_to() :(

+kill-asm-ioctl32h.patch

 cleanup

+profilec-schedule-parsing-fix.patch

 Fix __setup parser

+factor-out-common-code-in-sys_fsync-sys_fdatasync.patch

 Code consolidation

+improve-cd-dvd-packet-driver-write-performance.patch

 Speed up the packet writing driver

+tpm-add-debugging-output.patch

 tpm driver work

+connector-export-initialization-flag.patch

 connector namespace fix

+dvb-b2c2-flexcop-driver-refactoring-part-1-drop-old-b2c2-usb-stuff.patch
+dvb-b2c2-flexcop-driver-refactoring-part-2-add-modular-flexcop-driver.patch
+dvb-flexcop-fix-usb-transfer-handling.patch
+dvb-flexcop-add-acknowledgements.patch
+dvb-flexcop-fix-mac-address-reading.patch
+dvb-flexcop-fixed-interrupt-sharing.patch
+dvb-flexcop-use-hw-pid-filter.patch
+dvb-flexcop-fix-module-refcount-handling.patch
+dvb-flexcop-readme-update.patch
+dvb-flexcop-i2c-read-fixes.patch
+dvb-flexcop-diseqc-fix.patch

 dvd subsystem updates

+numa-aware-slab-allocator-v3.patch
+numa-aware-slab-allocator-v2-tidy.patch
+numa-aware-slab-allocator-v3-cleanup.patch
+ppc64-numa-nodes-hack.patch

 NUMA-aware slab allocator (a bit busted on ppc64)

+v4l-saa7134-mark-little-endian-ptr.patch
+video_cx88_dvb-must-select-dvb_cx22702.patch
+fix-for-cx88-cardsc-for-dvico-fusionhdtv-3-gold-q.patch

 v4l subsystem updates

+kexec-x86_64-optimise-storage-of-read-mostly-variables-x86_64-fix.patch

 Fix kexec for the `optimise-storage-of-read-mostly-variables' patch

-reiser4-sb_sync_inodes-cleanup.patch

 This was broken.

+intelfbdrv-naming-fix.patch
+fbdev-iomove-removal.patch
+pm3fb-typo-fix.patch

 fbdev updates

+md-cause-md-raid1-to-repack-working-devices-when-number-of-drives-is-changed.patch
+md-make-sure-recovery-happens-when-add_new_disk-is-used-for-hot_add.patch

 RAID updates

+kernel-power-swsuspc-make-a-variable-static.patch
+kernel-modulec-make-a-function-static.patch
+fs-reiserfs-streec-make-max_key-static.patch
+make-umount_tree-static.patch
+scsi-make-code-static.patch

 Make some things static

+drivers-char-ip2-cleanups.patch
+drivers-cdrom-cm206c-cleanups.patch
+drivers-isdn-hisax-possible-cleanups.patch

 Little fixes

-remove-exports-for-oem-modules.patch

 Dropped: the code which needs these exports has been merged.


number of patches in -mm: 1166
number of changesets in external trees: 223
number of patches in -mm only: 1158
total patches: 1381


All 1166 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/patch-list


