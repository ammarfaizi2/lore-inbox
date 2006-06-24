Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWFXNT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWFXNT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 09:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbWFXNT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 09:19:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752235AbWFXNT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 09:19:26 -0400
Date: Sat, 24 Jun 2006 06:19:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm2
Message-Id: <20060624061914.202fbfb5.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/


- The locking validator patches have all been dropped - Ingo is redoing the
  patch series.

- The arch-secific parts of the generic IRQ rework have been dropped, so
  it's a do-nothing patch series at present.  If we can verify that it indeed
  does nothing then we might be able to squeak it into 2.6.18 for powerpc to
  merge against.

- The kgdb patches have been tempdropped.  Partly to make merging of other
  things easier, partly because someone broke it.

- The various little -mm-only debugging patches have been temporarily
  dropped, to make followon patching easier.




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



Changes since 2.6.17-mm1:


 origin.patch
 git-agpgart.patch
 git-cifs.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-infiniband.patch
 git-input.patch
 git-jfs.patch
 git-kbuild.patch
 git-klibc.patch
 git-hdrinstall2.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-s390.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch 

 git trees


-ehci-works-again-on-nvidia-controllers-with-2gb-ram.patch
-uml-fix-wall_to_monotonic-initialization.patch
-sparc-build-breakage.patch
-ntfs-critical-bug-fix-affects-mips-and-possibly-others.patch
-selinux-add-hooks-for-key-subsystem.patch
-keys-fix-race-between-two-instantiators-of-a-key.patch
-suspend_console-warning-fix.patch
-myri10ge-build-fix.patch
-for_each_possible_cpu-xfs.patch
-revert-powernow-k8-crash-workaround.patch
-git-acpi-fixup.patch
-git-acpi-ia64-build-fix.patch
-reapply-powernow-k8-crash-workaround.patch
-ati-agp-build-fix.patch
-create-sys-hypervisor-when-needed.patch
-gregkh-driver-kobject_add-make-people-pay-attention-to-errors.patch
-gregkh-driver-stable-abi-docs.patch
-gregkh-driver-cciss-device-symlink.patch
-gregkh-driver-driver-core-bus-device-event-delay.patch
-gregkh-driver-tty-return-class-device-pointer-from-tty_register_device.patch
-gregkh-driver-i4l-gigaset-move-sysfs-entry-to-tty-class-device.patch
-gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
-gregkh-driver-driver-core-config_debug_pm-covers-drivers-base-power-too.patch
-gregkh-driver-platform_bus-learns-about-modalias.patch
-gregkh-driver-driver-core-remove-exports.patch
-gregkh-driver-driver-core-allow-sysdev_class-have-attributes.patch
-gregkh-driver-driver-core-fix-platform_device_add-to-use-device_add.patch
-gregkh-driver-remove-duplication-from-documentation-power-devices_txt.patch
-gregkh-driver-driver-core-pm_debug-device-suspend-messages-become-informative.patch
-gregkh-driver-firmware_class-s-semaphores-mutexes.patch
-gregkh-driver-make_class_name-kobj.patch
-gregkh-driver-device-class.patch
-gregkh-driver-driver-core-add-generic-subsystem-link-to-all-devices.patch
-gregkh-driver-device-symlinks-for-classes.patch
-gregkh-driver-driver-core-make-dev_info-and-friends-print-the-bus-name-if-there-is-no-driver.patch
-gregkh-driver-driver-model-add-isa-bus.patch
-saa7134-card-lifeview3000-ntsc.patch
-gregkh-i2c-hwmon-lm83-add-lm82-support.patch
-gregkh-i2c-hwmon-w83627ehf-add-voltages.patch
-gregkh-i2c-hwmon-w83627ehf-add-alarms.patch
-gregkh-i2c-hwmon-smsc47m192-new-driver.patch
-gregkh-i2c-hwmon-f71805f-no-global-resource.patch
-gregkh-i2c-hwmon-sysfs-interface-individual-alarm-files.patch
-gregkh-i2c-i2c-piix4-add-ati-smbus-support.patch
-gregkh-i2c-rtc-m41t00-driver-cleanup.patch
-gregkh-i2c-rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch
-gregkh-i2c-i2c-piix4-remove-fix_hstcfg-parameter.patch
-gregkh-i2c-i2c-piix4-fix-typo-in-documentation.patch
-gregkh-i2c-i2c-piix4-improve-ibm-error-message.patch
-gregkh-i2c-i2c-nforce2-add-mcp51-mcp55-support.patch
-gregkh-i2c-hwmon-hdaps-update-id-list.patch
-gregkh-i2c-hwmon-w83791d-new-driver.patch
-gregkh-i2c-hwmon-lm83-documentation-update.patch
-gregkh-i2c-hwmon-improve-Kconfig-help.patch
-gregkh-i2c-hwmon-vid-mask-per-vrm.patch
-gregkh-i2c-i2c-Kconfig-suggest-N-for-rare-devices.patch
-gregkh-i2c-i2c-opencores-new-driver.patch
-gregkh-i2c-hwmon-sysfs-interface-update-1.patch
-gregkh-i2c-hwmon-sysfs-interface-update-2.patch
-gregkh-i2c-hwmon-hdaps-typo.patch
-gregkh-i2c-hwmon-maintenance-update.patch
-gregkh-i2c-hwmon-w83792d-pwm-set-fix.patch
-gregkh-i2c-hwmon-w83792d-add-data-lock.patch
-gregkh-i2c-hwmon-abituguru-new-driver.patch
-gregkh-i2c-hwmon-abituguru-fixes.patch
-gregkh-i2c-hwmon-abituguru-nofans-detect-fix.patch
-gregkh-i2c-i2c-opencores-cleanup.patch
-gregkh-i2c-i2c-mark-data-const-for-write-block.patch
-gregkh-i2c-i2c-scx200_acb-use-PCI-IO-resource-when-appropriate.patch
-gregkh-i2c-i2c-scx200_acb-mark-scx200_acb_probe-init.patch
-gregkh-i2c-i2c-scx200_acb-documentation-update.patch
-gregkh-i2c-i2c-i801-01-fix-block-transaction-poll-loops.patch
-gregkh-i2c-i2c-i801-02-remove-force_addr-parameter.patch
-gregkh-i2c-i2c-i801-03-remove-pci-function-check.patch
-gregkh-i2c-i2c-i801-04-cleanups.patch
-gregkh-i2c-i2c-i801-05-better-pci-subsystem-integration.patch
-gregkh-i2c-i2c-i801-06-merge-setup-function.patch
-gregkh-i2c-hwmon-kconfig-header-fix.patch
-gregkh-i2c-hwmon-lm70-new-driver.patch
-gregkh-i2c-hwmon-vid-add-core-and-conroe-support.patch
-gregkh-i2c-i2c-i2c-controllers-go-into-right-place-on-sysfs.patch
-gregkh-i2c-w1-added-default-generic-read-write-operations.patch
-gregkh-i2c-w1-replace-dscore-and-ds_w1_bridge-with-ds2490-driver.patch
-gregkh-i2c-w1-userspace-communication-protocol-over-connector.patch
-gregkh-i2c-w1-move-w1-connector-definitions-into-linux-include-connector.h.patch
-gregkh-i2c-w1-netlink-mark-netlink-group-1-as-unused.patch
-gregkh-i2c-w1-make-w1-connector-notifications-depend-on-connector.patch
-gregkh-i2c-w1-use-mutexes-instead-of-semaphores.patch
-gregkh-i2c-w1-exports.patch
-gregkh-i2c-w1-cleanups.patch
-gregkh-i2c-w1-possible-cleanups.patch
-gregkh-i2c-w1-fix-dependencies-of-w1_slave_ds2433_crc.patch
-gregkh-i2c-drivers-w1-w1.c-fix-a-compile-error.patch
-gregkh-i2c-w1-clean-up-w1_con-dependency.patch
-gregkh-i2c-w1-warning-fix.patch
-git-infiniband-fixup.patch
-git-libata-all-fixup.patch
-git-libata-all-data_xfer-fixes.patch
-git-libata-all-data_xfer-fixes-fixes.patch
-git-libata-pata_cs5535-is-bust.patch
-gregkh-pci-pci-hotplug-tollhouse-hp-sgi-hotplug-driver-changes.patch
-gregkh-pci-acpiphp-configure-_prt-v3.patch
-gregkh-pci-acpiphp-hotplug-slot-hotplug.patch
-gregkh-pci-acpiphp-host-and-p2p-hotplug.patch
-gregkh-pci-acpiphp-turn-off-slot-power-at-error-case.patch
-gregkh-pci-pci-hotplug-don-t-use-acpi_os_free.patch
-gregkh-pci-pciehp-dont-call-pci_enable_dev.patch
-gregkh-pci-acpi_pcihp-fix-programming-_hpp-values.patch
-gregkh-pci-acpi_pcihp-remove-improper-error-message-about-oshp.patch
-gregkh-pci-acpi_pcihp-add-support-for-_hpx.patch
-gregkh-pci-pciehp-fix-programming-hotplug-parameters.patch
-gregkh-pci-shpc-cleanup-shpc-register-access.patch
-gregkh-pci-shpc-cleanup-shpc-logical-slot-register-access.patch
-gregkh-pci-shpc-cleanup-shpc-logical-slot-register-bits-access.patch
-gregkh-pci-shpc-fix-shpc-logical-slot-register-bits-access.patch
-gregkh-pci-shpc-fix-shpc-contoller-serr-int-register-bits-access.patch
-gregkh-pci-shpchp-mask-global-serr-and-intr-at-controller-release-time.patch
-gregkh-pci-shpchp-create-shpchpd-at-controller-probe-time.patch
-gregkh-pci-sgi-hotplug-incorrect-power-status.patch
-gregkh-pci-pciehp-replace-pci_find_slot-with-pci_get_slot.patch
-gregkh-pci-pciehp-add-missing-pci_dev_put.patch
-gregkh-pci-pciehp-implement-get_address-callback.patch
-gregkh-pci-shpchp-remove-unnecessary-hpc_ctlr_handle-check.patch
-gregkh-pci-shpchp-cleanup-interrupt-handler.patch
-gregkh-pci-shpchp-cleanup-shpc-commands.patch
-gregkh-pci-shpchp-cleanup-interrupt-polling-timer.patch
-gregkh-pci-shpchp-remove-unused-hpc_evelnt_lock.patch
-gregkh-pci-shpchp-cleanup-improper-info-messages.patch
-gregkh-pci-pci-hotplug-fake-null-pointer-dereferences-in-ibm-hot-plug-controller-driver.patch
-gregkh-pci-pci-hotplug-fix-recovery-path-from-errors-during-pcie_init.patch
-gregkh-pci-pci-add-pci_cap_id_vndr.patch
-gregkh-pci-pci-msi-abstractions-and-support-for-altix.patch
-gregkh-pci-pci-per-platform-ia64_-first-last-_device_vector-definitions.patch
-gregkh-pci-pci-altix-msi-support.patch
-gregkh-pci-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms.patch
-gregkh-pci-pci-fix-to-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms.patch
-gregkh-pci-pci-add-pci_assign_resource_fixed-allow-fixed-address-assignments.patch
-gregkh-pci-pci-add-a-enable-sysfs-attribute-to-the-pci-devices-to-allow-userspace-to-enable-devices-without-doing-foul-direct-access.patch
-gregkh-pci-pci-don-t-enable-device-if-already-enabled.patch
-gregkh-pci-pci-acpi-rename-the-functions-to-avoid-multiple-instances.patch
-gregkh-pci-pci-i386-x86_84-disable-pci-resource-decode-on-device-disable.patch
-gregkh-pci-pci-bus-parity-status-broken-hardware-attribute-edac-foundation.patch
-gregkh-pci-pci-move-various-pci-ids-to-header-file.patch
-gregkh-pci-pci-amd-8131-msi-quirk-called-too-late-bus_flags-not-inherited.patch
-gregkh-pci-pci-allow-msi-to-work-on-kexec-kernel.patch
-gregkh-pci-pci-disable-msi-mode-in-pci_disable_device.patch
-gregkh-pci-pci-cleanup-unused-variable-about-msi-driver.patch
-gregkh-pci-pci-don-t-move-ioapics-below-pci-bridge.patch
-gregkh-pci-pci-remove-unneeded-msi-code.patch
-gregkh-pci-pci-clean-up-pci-documentation-to-be-more-specific.patch
-gregkh-pci-pci-fix-race-with-pci_walk_bus-and-pci_destroy_dev.patch
-gregkh-pci-pci-msi-k8t-neo2-fir-run-only-where-needed.patch
-gregkh-pci-fix-pci_get_device-usage-in-mpc85xx.patch
-gregkh-pci-pci-fix-memory-leak-in-mmconfig-error-path.patch
-gregkh-pci-pci-bus-parity-status-sysfs-interface.patch
-gregkh-pci-pci-fix-issues-with-extended-conf-space-when-mmconfig-disabled-because-of-e820.patch
-gregkh-pci-pci-nvidia-quirk-to-make-aer-pci-e-extended-capability-visible.patch
-gregkh-usb-usb-add-yealink-phones-to-the-hid_quirk_ignore-blacklist.patch
-gregkh-usb-usb-cdc-acm-add-a-new-special-case-for-modems-with-buggy-firmware.patch
-gregkh-usb-usb-usbnet-zaurus-mtu-fixup.patch
-gregkh-usb-usb-added-support-for-asix-88178-chipset-usb-gigabit-ethernet-adaptor.patch
-gregkh-usb-usb-convert-the-semaphores-in-the-sisusb-driver-to-mutexes.patch
-gregkh-usb-usb-sisusbvga-possible-cleanups.patch
-gregkh-usb-usb-allow-multiple-types-of-ehci-controllers-to-be-built-as-modules.patch
-gregkh-usb-usb-console-fix-cr-lf-issues.patch
-gregkh-usb-usb-console-fix-oops.patch
-gregkh-usb-usb-console-prevent-enodev-on-node.patch
-gregkh-usb-usb-console-fix-disconnection-issues.patch
-gregkh-usb-usb-macbook-pro-touchpad-support.patch
-gregkh-usb-usb-usbcore-always-turn-on-hub-port-power.patch
-gregkh-usb-usb-clean-out-an-unnecessary-null-check-from-ub.patch
-gregkh-usb-usbatm-remove-pointless-inline.patch
-gregkh-usb-usbatm-remove-no-longer-needed-include.patch
-gregkh-usb-usb-phidget-interfacekit-make-inputs-pollable-and-new-device-support.patch
-gregkh-usb-usb-shuttle_usbat-fix-handling-of-scatter-gather-buffers.patch
-gregkh-usb-usb-shuttle_usbat-hardcode-detection-of-hp-cdrw-devices.patch
-gregkh-usb-usb-shuttle_usbat-hardcode-flash-detection-for-now.patch
-gregkh-usb-usb-usb-storage-alauda-fix-transport-info-mismerge.patch
-gregkh-usb-usb-net2280-add-a-shutdown-routine.patch
-gregkh-usb-usb-uhci-store-the-endpoint-type-in-the-qh-structure.patch
-gregkh-usb-usb-uhci-fix-obscure-bug-in-enqueue.patch
-gregkh-usb-usb-hid-hidbp-input-drivers-fix-various-usb-input-hid-input.c-bugs-that-make-apple-mighty-mouse-work-poorly.patch
-gregkh-usb-usbhid-automatically-set-hid_quirk_noget-for-keyboards-and-mice.patch
 gregkh-usb-usb-ohci-avoids-root-hub-timer-polling.patch
-gregkh-usb-uhci-common-result-routine-for-control-bulk-interrupt.patch
-gregkh-usb-uhci-remove-non-iso-tds-as-they-are-used.patch
-gregkh-usb-uhci-move-code-for-cleaning-up-unlinked-urbs.patch
-gregkh-usb-uhci-eliminate-the-td-removal-list.patch
-gregkh-usb-uhci-reimplement-fsbr.patch
-gregkh-usb-uhci-work-around-old-intel-bug.patch
-gregkh-usb-usb-correct-the-usb-info-in-documentation-power-swsusp_txt.patch
-gregkh-usb-usb-remove-4088-byte-limit-on-usbfs-control-urbs.patch
-gregkh-usb-usb-allow-high-bandwidth-isochronous-packets-via-usbfs.patch
-gregkh-usb-uhci-use-integer-sized-frame-numbers.patch
-gregkh-usb-uhci-fix-race-in-iso-dequeuing.patch
-gregkh-usb-uhci-store-the-period-in-the-queue-header.patch
-gregkh-usb-uhci-remove-iso-tds-as-they-are-used.patch
-gregkh-usb-fix-a-deadlock-in-usbtest.patch
-gregkh-usb-usb_interrupt_msg.patch
-gregkh-usb-usb-new-cp2101-device.patch
-gregkh-usb-gadgetfs-fix-aio-interface-bugs.patch
-gregkh-usb-gadgetfs-fix-memory-leaks.patch
-gregkh-usb-usbtest-report-errors-in-iso-tests.patch
-gregkh-usb-usb-io_edgeport-cleanup-to-unicode-handling.patch
-gregkh-usb-usb-serial-encapsulate-schedule_work-remove-double-calling.patch
-gregkh-usb-usb-improve-kconfig-comment-for-mct_u232.patch
-gregkh-usb-usb-syntax-cleanup-for-pl2303.patch
-gregkh-usb-usb-storage-get-rid-of-the-timer-during-urb-submission.patch
-gregkh-usb-improved-tt-scheduling-for-ehci.patch
-gregkh-usb-usb-rmmod-pl2303-after-28.patch
-gregkh-usb-ub-atomic-add_disk.patch
-gregkh-usb-ub-random-cleanups.patch
-gregkh-usb-usb-more-pegasus-log-spamming-removed.patch
-gregkh-usb-usb-print-message-when-device-is-rejected-due-to-insufficient-power.patch
-gregkh-usb-usbcore-fix-broken-rndis-config-selection.patch
-gregkh-usb-usbhid-remove-unneeded-blacklist-entries.patch
-gregkh-usb-usb-ftdi_sio-add-support-for-yost-engineering-servocenter3.1.patch
-gregkh-usb-driver-for-apple-cinema-display.patch
-gregkh-usb-usb-whiteheat-fix-firmware-spurious-errors.patch
-gregkh-usb-usb-add-sierra-wireless-mc5720-id-to-airprime.c.patch
-gregkh-usb-usb-negative-index-in-drivers-usb-host-isp116x-hcd.c.patch
-gregkh-usb-usb-cdc_ether-recognize-olympus-r1000.patch
-gregkh-usb-usbcore-port-reset-for-composite-devices.patch
-gregkh-usb-usb-hub-use-usb_reset_composite_device.patch
-gregkh-usb-usb-storage-use-usb_reset_composite_device.patch
-gregkh-usb-usbhid-use-usb_reset_composite_device.patch
-gregkh-usb-usbcore-recovery-from-set-configuration-failure.patch
-gregkh-usb-usb-drivers-usb-core-devio.c-dereferences-a-userspace-pointer.patch
-gregkh-usb-usb-new-devices-for-the-option-driver.patch
-gregkh-usb-usb-free-allocated-memory-on-io_edgeport-startup-memory-failure.patch
-gregkh-usb-usb-ehci-on-non-au1200-build-fix.patch
-gregkh-usb-usb-add-apple-macbook-product-ids-to-usbhid.patch
-gregkh-usb-usb-storage-unusual_devs-entry-for-nikon-dsc-d70s.patch
-gregkh-usb-uhci-various-updates.patch
-gregkh-usb-uhci-remove-hc_inaccessible-flag.patch
-gregkh-usb-uhci-improve-fsbr-off-timing.patch
-gregkh-usb-airprime.c-add-kyocera-wireless-kpc650-passport-support.patch
-gregkh-usb-usb-io_edgeport-touch-up.patch
-gregkh-usb-usb-update-usbmon-fix-glued-lines.patch
-gregkh-usb-usb-implement-error-event-in-usbmon.patch
-gregkh-usb-usb-update-usbmontxt.patch
-gregkh-usb-usb-new-driver-for-cypress-cy7c63xxx-mirco-controllers.patch
-gregkh-usb-usb-trivial-debug-message-correction-in-gadget-ether-driver.patch
-gregkh-usb-usb-serial-clean-tty-fields-on-failed-device-open.patch
-gregkh-usb-usb-gadget-serial-fix-a-deadlock-when-closing-the-serial-device.patch
-gregkh-usb-usb-gadget-serial-do-not-save-restore-irq-flags-in-gs_close.patch
-gregkh-usb-usb-gadget-allow-drivers-support-speeds-higher-than-full-speed.patch
-gregkh-usb-usb-gadget-fix-compile-errors.patch
-gregkh-usb-usb-gadget-update-pxa2xx_udc.c-driver-to-fully-support-ixp4xx-platform.patch
-gregkh-usb-usbserial-fixes-wrong-return-values.patch
-gregkh-usb-usb-unusual_devs-entry-for-nokia-n80.patch
-gregkh-usb-usb-whitespace-removal-from-usb-gadget-ether.patch
-gregkh-usb-usb-move-linux-usb_cdc.h-to-linux-usb-cdc.h.patch
-gregkh-usb-usb-move-hardware-specific-linux-usb_-.h-to-linux-usb-.h.patch
-gregkh-usb-usb-move-linux-usb_input.h-to-linux-usb-input.h.patch
-gregkh-usb-usb-endpoint.patch
-gregkh-usb-usb-endpoint-pass-struct-device.patch
-gregkh-usb-usb-endpoint-mess.patch
-gregkh-usb-usb-devio-class-to-device.patch
-gregkh-usb-usb-class-device-to-device.patch
-gregkh-usb-usb-dynamic-usb-class.patch
-x86_64-mm-agp-select.patch
-xfs-remove-dir-check-in-xfs_link.patch
-xfs-use-container_of-in-vn_from_inode.patch
-xfs-remove-unused-behaviour-lock.patch
-zone-handle-unaligned-zone-boundaries.patch
-page-migration-make-do_swap_page-redo-the-fault.patch
-slab-extract-cache_free_alien-from-__cache_free.patch
-pg_uncached-is-ia64-only.patch
-slab-page-mapping-cleanup.patch
-migration-remove-unnecessary-pageswapcache-checks.patch
-wait_table-and-zonelist-initializing-for-memory-hotadd-change-name-of-wait_table_size.patch
-wait_table-and-zonelist-initializing-for-memory-hotadd-change-to-meminit-for-build_zonelist.patch
-wait_table-and-zonelist-initializing-for-memory-hotaddadd-return-code-for-init_current_empty_zone.patch
-wait_table-and-zonelist-initializing-for-memory-hotadd-wait_table-initialization.patch
-wait_table-and-zonelist-initializing-for-memory-hotadd-update-zonelists.patch
-squash-duplicate-page_to_pfn-and-pfn_to_page.patch
-support-for-panic-at-oom.patch
-mm-fix-typos-in-comments-in-mm-oom_killc.patch
-reserve-space-for-swap-label.patch
-tightening-hugetlb-strict-accounting.patch
-slab-cleanup-kmem_getpages.patch
-slab-stop-using-list_for_each.patch
-swsusp-rework-memory-shrinker-rev-2.patch
-unify-pxm_to_node-and-node_to_pxm.patch
-mm-introduce-remap_vmalloc_range.patch
-change-gen_pool-allocator-to-not-touch-managed-memory.patch
-radix-tree-direct-data.patch
-radix-tree-small.patch
-likely-cleanup-remove-unlikely-in-sys_mprotect.patch
-slab-redzone-double-free-detection.patch
-buglet-in-radix_tree_tag_set.patch
-writeback-fix-range-handling.patch
-page-migration-cleanup-rename-ignrefs-to-migration.patch
-page-migration-cleanup-group-functions.patch
-page-migration-cleanup-remove-useless-definitions.patch
-page-migration-cleanup-drop-nr_refs-in-remove_references.patch
-page-migration-cleanup-extract-try_to_unmap-from-migration-functions.patch
-page-migration-cleanup-pass-mapping-to-migration-functions.patch
-page-migration-cleanup-move-fallback-handling-into-special-function.patch
-swapless-pm-add-r-w-migration-entries.patch
-swapless-pm-add-r-w-migration-entries-fix.patch
-swapless-page-migration-rip-out-swap-based-logic.patch
-swapless-page-migration-modify-core-logic.patch
-more-page-migration-do-not-inc-dec-rss-counters.patch
-more-page-migration-use-migration-entries-for-file-pages.patch
-page-migration-update-documentation.patch
-slab-verify-pointers-before-free.patch
-sparsemem-record-nid-during-memory-present.patch
-mm-cleanup-swap-unused-warning.patch
-add-page_mkwrite-vm_operations-method.patch
-add-page_mkwrite-vm_operations-method-fix.patch
-swapoff-atomic_inc_not_zero-on-mm_users.patch
-remove-unused-o_flags-from-do_shmat.patch
-fix-update_mmu_cache-in-fremapc.patch
-fix-update_mmu_cache-in-fremapc-fix.patch
-mm-slabc-fix-early-init-assumption.patch
-initialise-total_memory-earlier.patch
-update-vm_total_pages-at-memory-hotadd.patch
-slab-kmalloc-kzalloc-comments-cleanup-and-fix.patch
-kernel-doc-for-mm-filemapc.patch
-delete-unused-definitions-of-kvaddr_to_nid.patch
-printk-should-not-be-called-under-zone-lock.patch
-page-migration-simplify-migrate_pages.patch
-page-migration-handle-freeing-of-pages-in-migrate_pages.patch
-page-migration-use-allocator-function-for-migrate_pages.patch
-page-migration-support-moving-of-individual-pages.patch
-page-migration-support-moving-of-individual-pages-x86_64-support.patch
-page-migration-support-moving-of-individual-pages-x86-support.patch
-lsm-add-task_setioprio-hook.patch
-selinux-add-security-hooks-to-getsetaffinity.patch
-selinux-add-security-hook-call-to-mediate-attach_task.patch
-frv-__user-infrastructure.patch
-frv-basic-__iomem-annotations.patch
-frv-signal-annotations.patch
-frv-sysctl-__user-annotations.patch
-frv-binfmt_elf_fdpic-__user-annotations.patch
-frv-misc-__user-annotations.patch
-frv-misc-sparse-annotations.patch
-frv-wrong-syscall.patch
-ext2-xip-wont-build-without-mmu.patch
-frv-initrd-is-grossly-broken-on-frv-never-built.patch
-frv-null-noise-removal-in-frv-xchg.patch
-frv-ieee1394-is-borken-on-frv.patch
-frv-add-missing-qualifier-to-memcpy_fromio-prototype.patch
-frv-trivial-cleanups-in-frv_ksymsc.patch
-frv-clean-frv-unistdh.patch
-au1550-1200-add-missing-psc-defines-make-oss-driver-use.patch
-x86-cache-pollution-aware-__copy_from_user_ll.patch
-arch-i386-kernel-apicc-make-modern_apic-static.patch
-i386-apmc-optimization.patch
-x86-dont-trigger-full-rebuild-via-config_mtrr.patch
-fix-x86-microcode-driver-handling-of-multiple-matching.patch
-i386-break-out-of-recursion-in-stackframe-walk.patch
-dont-trigger-full-rebuild-via-config_x86_mce.patch
-x86-call-eisa_set_level_irq-in-pcibios_lookup_irq.patch
-x86-kernel-irq-balancer-fix.patch
-x86-kernel-irq-balancer-fix-tidy.patch
-i386-let-usermode-execute-the-enter.patch
-fix-broken-vm86-interrupt-signal-handling.patch
-x86-make-using_apic_timer-__read_mostly.patch
-x86-cyrix-code-config_pci-fix--add-__initdata.patch
-x86-make-i387-mxcsr_feature_mask-__read_mostly.patch
-x86-make-acpi-errata-__read_mostly.patch
-x86-constify-arch-i386-pci-irqc.patch
-x86-use-proper-defines-for-i8259a-i-o.patch
-i386-fix-get_segment_eip-with-vm86.patch
-i386-dont-try-kprobes-for-v8086-mode.patch
-i386-extra-checks-in-show_registers.patch
-via-c7-cpu-flags.patch
-x86-compile-fix-for-asm-i386-alternativesh.patch
-remove-duplicate-symbol-exports-on-alpha.patch
-remove-empty-node-at-boot-time.patch
-swsusp-add-architecture-special-saveable-pages-support.patch
-swsusp-i386-mark-special-saveable-unsaveable-pages.patch
-swsusp-x86_64-mark-special-saveable-unsaveable-pages.patch
-swsusp-take-lowmem-reserves-into-account.patch
-kernel-power-snapshotc-cleanups.patch
-swsusp-use-less-memory-during-resume.patch
-dont-use-flush_tlb_all-in-suspend-time.patch
-swsusp-documentation-updates.patch
-move-do_suspend_lowlevel-to-correct-segment.patch
-m68k-completely-initialize-hw_regs_t-in-ide_setup_ports.patch
-m68k-atyfb_base-compile-fix-for-config_pci=n.patch
-m68k-cleanup-unistdh.patch
-m68k-remove-some-unused-definitions-in-zorroh.patch
-m68k-use-c99-initializer.patch
-m68k-print-correct-stack-trace.patch
-m68k-restore-amikbd-compatibility-with-24.patch
-m68k-extra-delay.patch
-m68k-use-proper-defines-for-zone-initialization.patch
-m68k-adjust-to-changed-hardirq_mask.patch
-m68k-m68k-mac-via2-fixes-and-cleanups.patch
-m68k-clean-up-uaccessh.patch
-m68k-typo-fix.patch
-m68k-trapsc-constraints.patch
-m68k-windfarm-is-powerpc-only-dont-do-it-on-m68k-macs.patch
-xtensa-remove-verify_area-macros.patch
-xtensa-remove-verify_area-macros-fix.patch
-s390_hypfs-filesystem.patch
-fix-a-race-condition-between-i_mapping-and-iput.patch
-add-a-sysfs-file-to-determine-if-a-kexec-kernel-is-loaded.patch
-insert-identical-resources-above-existing-resources.patch
-remove-steal_locks.patch
-avoid-tasklist_lock-at-getrusage-for-multithreaded-case-too.patch
-#writeback-fix-range-handling.patch
-fix-dcache-race-during-umount.patch
-prune_one_dentry-tweaks.patch
-vgacon-make-vga_map_mem-take-size-remove-extra-use.patch
-zlib_inflate-upgrade-library-code-to-a-recent-version.patch
-zlib_inflate-upgrade-library-code-to-a-recent-version-fix.patch
-initramfs-cpio-unpacking-fix.patch
-fix-cdrom-being-confused-on-using-kdump.patch
-read_mapping_page-for-address-space.patch
-locks-dont-unnecessarily-fail-posix-lock-operations.patch
-locks-dont-do-unnecessary-allocations.patch
-locks-clean-up-locks_remove_posix.patch
-vfs-add-lock-owner-argument-to-flush-operation.patch
-fs-locksc-make-posix_locks_deadlock-static.patch
-moduleh-updated-comments-with-a-new.patch
-remove-config_parport_arc-drivers-parport-parport_arcc.patch
-mmput-might-sleep.patch
-fs-fat-miscc-unexport-fat_sync_bhs.patch
-poll-cleanups-microoptimizations.patch
-ptrace-document-the-locking-rules.patch
-cleanup-default-value-of-sched_smt.patch
-cleanup-default-value-of-syscall_debug.patch
-cleanup-default-value-of-usb_isp116x_hcd-usb_sl811_hcd-and-usb_sl811_cs.patch
-cleanup-default-value-of-ip_dccp_ackvec.patch
-cleanup-default-value-of-dvb_cinergyt2_enable_rc_input_device.patch
-dup-fd-error.patch
-cond-resched-might-sleep-fix.patch
-enhancing-accessibility-of-lxdialog.patch
-the-scheduled-unexport-of-insert_resource.patch
-jbd-fix-bug-in-journal_commit_transaction.patch
-jbd-fix-bug-in-journal_commit_transaction-fix.patch
-rename-swapper-to-idle.patch
-oss-cs46xx-cleanup-and-tiny-bugfix.patch
-i4l-memory-leak-fix-for-sc_ioctl.patch
-isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub.patch
-isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub-fix.patch
-invert-irq-migrationc-brach-prediction.patch
-x86-powerpc-make-hardirq_ctx-and-softirq_ctx-__read_mostly.patch
-jbd-avoid-kfree-null.patch
-ext3_clear_inode-avoid-kfree-null.patch
-make-noirqdebug-irqfixup-__read_mostly-add-unlikely.patch
-leds-amstrad-delta-led-support.patch
-leds-amstrad-delta-led-support-tidy.patch
-update-devicestxt.patch
-binfmt_elf-codingstyle-cleanup-and-remove-some-pointless-casts.patch
-binfnt_elf-remove-more-casts.patch
-fix-incorrect-sa_onstack-behaviour-for-64-bit-processes.patch
-percpu-counters-add-percpu_counter_exceeds.patch
-percpu-counter-data-type-changes-to-suppport.patch
-remove-unlikely-in-might_sleep_if.patch
-process-events-header-cleanup.patch
-process-events-license-change.patch
-strstrip-api.patch
-ipmi-strstrip-conversion.patch
-connector-exports.patch
-config_net=n-build-fix.patch
-remove-softlockup-from-invalidate_mapping_pages.patch
-add-doc-submitchecklist.patch
-kernel-sysc-doesnt-need-inith.patch
-make-rcu-api-inaccessible-to-non-gpl-linux-kernel-modules.patch
-doc-add-audit-acct-to-docbook.patch
-sgi-ioc4-detect-io-card-variant.patch
-two-additions-to-linux-documentation-ioctl-numbertxt.patch
-list-introduce-list_replace-helper.patch
-list-use-list_replace_init-instead-of-list_splice_init.patch
-when-config_base_samll=1-the-kernel-261611-cascade-in-kernel-timerc-may-enter-the-infinite-loop.patch
-when-config_base_samll=1-the-kernel-261611-cascade-in-kernel-timerc-may-enter-the-infinite-loop-use-list_replace_init.patch
-codingstyle-add-typedefs-chapter.patch
 fs-bufferc-possible-cleanups.patch
-drivers-md-raid6algosc-fix-a-null-dereference.patch
-adjust-handle_irr_event-return-type.patch
-sparse-fixes-for-synclink_cs.patch
-jbd-split-checkpoint-lists.patch
-more-bug_on-conversion.patch
-make-kernel-ignore-bogus-partitions.patch
-drivers-block-loopc-dont-return-garbage-if-loop_set_status-not-called.patch
-docs-update-sparsetxt-with-check_endian.patch
-random-remove-bogus-sa_sample_random-from-at91-compact-flash-driver.patch
-kthread-convert-s390machc-from-kernel_thread.patch

 Merged into mainline or a subsystem tree

+disable-debugging-version-of-write_lock.patch

 Disable the debug version of write_lock() - it's a box-killer.

+fix-typo-in-acpi-video-brightness-changes.patch

 Fix tpyo.

+initramfs-overwrite-fix.patch

 initramfs fix

-git-acpi-pre.patch
-git-acpi-post.patch

 Dropped.

+disable-acpi-on-some-phoenix-bios.patch
+drivers-acpi-scanc-make-acpi_bus_type-static.patch
+cpu_relax-use-in-acpi-lock.patch
+cpu_relax-use-in-acpi-lock-fix.patch
+acpi-asus-s3-resume-fix.patch
+acpi-asus-s3-resume-fix-fix.patch

 ACPI stuff

+more-for_each_cpu-removal.patch

 Keep trying to remove for_each_cpu().

+cifs-build-fix.patch

 Fix git-cifs.patch.

+remove-useless-checks-in-cifs-connectc.patch
+cifs-remove-f_ownerlock-use.patch

 CIFS tweaks.

+fix-use-after-free-bug-in-cpia2-driver.patch
+drivers-media-video-vivic-make-2-functions-static.patch
+drivers-media-video-pwc-make-code-static.patch
+fix-up-funky-logic-in-dvb.patch

 Fix git-dvb.patch

+ieee1394-nodemgr-do-not-peek-into-struct.patch

 Don't abuse semaphores in ieee1394

+input-allow-root-to-inject-unknown-scan-codes.patch

 Input feature.

+git-kbuild-revert-kbuild-ignore-makes-built-in-rules-variables.patch

 Fix git-kbuild.patch.

-kbuild-export-symbol-usage-report-generator.patch
+kbuild-export-symbol-usage-report-generator-2.patch

 Updated.

-via-pata-fails-on-some-atapi-drives-tidy.patch

 Folded into via-pata-fails-on-some-atapi-drives.patch

+ata-add-some-nvidia-chipset-ids.patch
+make-drivers-scsi-pata_pcmciacpcmcia_remove_one-static.patch
+libatah-needs-scatterlisth.patch
+sata-is-bust-on-s390.patch

 sata things.

+ni5010-netcard-cleanup-fix.patch
+s2io-driver-irq-fix.patch
+s2io-driver-irq-fix-tidy.patch
+qla3xxx-NIC-driver.patch
+qla3xxx-is-bust.patch

 Net driver updates.  Includes a new driver from qlogic which almost compiles.

-git-nfs.patch
-git-nfs-fixup.patch
-git-nfs-build-fixes.patch
-nfs-build-fix-99.patch
+#git-nfs.patch
+#git-nfs-fixup.patch
+#git-nfs-build-fixes.patch
+#nfs-build-fix-99.patch

 NFS tree dropped.

+add-lookup-hint-for-network-file-systems.patch

 Speed up NFS mkdirs

+git-pcmcia-fixup.patch

 Fix reject in git-pcmcia,patch.

+powerpc-adding-the-use-of-the-firmware-soft-reset-nmi-to-kdump.patch
+powerpc-kcofnig-warning-fix.patch

 powerpc things.

+64-bit-resources-kconfig-change.patch
+64bit-resource-fix-up-printks-for-resources-in-arch-and-core-code-fix.patch

 Fix Greg's tree a bit more.

+git-s390.patch

 s390 tree is back.

+drivers-scsi-qla2xxx-make-more-some-functions-static.patch
+drivers-scsi-advansysc-cleanups.patch

 scsi tweaks.

+usb-new-driver-for-cypress-cy7c63xxx-mirco-controllers-fix.patch
+if-0-drivers-usb-input-hid-corechid_find_field_by_usage.patch

 USB tweaks.

+x86_64-apic-fix-apic-error-on-bootup.patch
+x86_64-fix-bus-numbering-format-in-mmconfig-warning.patch

 x86_64 updates.

-radix-tree-rcu-lockless-readside-wraning-fix.patch
-radix-tree-rcu-lockless-readside-fix.patch

 Folded into radix-tree-rcu-lockless-readside.patch

+redo-radix-tree-fixes.patch
+adix-tree-rcu-lockless-readside-update.patch
+radix-tree-rcu-lockless-readside-semicolon.patch
+adix-tree-rcu-lockless-readside-update-tidy.patch

 More radix-tree work.

+zoned-vm-counters-create-vmstatc-h-from-page_allocc-h.patch
+zoned-vm-counters-create-vmstatc-h-from-page_allocc-h-s390-fix.patch
+zoned-vm-counters-create-vmstatc-h-from-page_allocc-h-fix.patch
+zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation.patch
+zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-tidy.patch
+zoned-vm-counters-convert-nr_mapped-to-per-zone-counter.patch
+zoned-vm-counters-convert-nr_mapped-to-per-zone-counter-fix.patch
+zoned-vm-counters-conversion-of-nr_pagecache-to-per-zone-counter.patch
+zoned-vm-counters-remove-nr_file_mapped-from-scan-control-structure.patch
+zoned-vm-counters-remove-nr_file_mapped-from-scan-control-structure-fix.patch
+zoned-vm-counters-split-nr_anon_pages-off-from-nr_file_mapped.patch
+zoned-vm-counters-zone_reclaim-remove-proc-sys-vm-zone_reclaim_interval.patch
+zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix.patch
+zoned-vm-counters-conversion-of-nr_pagetables-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_pagetables-to-per-zone-counter-fix.patch
+zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter-fix.patch
+zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter-nfs-fix.patch
+zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter-fix.patch
+zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter-nfs-fix.patch
+zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter-fix.patch
+zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter-fix.patch
+zoned-vm-counters-remove-useless-struct-wbs.patch
+zoned-vm-counters-remove-read_page_state.patch

 More efficient VM counters.  Buggier ones, too - piles of fixes were needed
 here :(

+cpu_relax-smpbootc.patch
+cpu_relax-smpbootc-fix.patch
+x86-apic-fix-apic-error-on-bootup.patch
+fix-broken-vm86-interrupt-signal-handling.patch
+i386-cpu_relax-in-crashc-and-doublefaultc.patch

 x86 updates

+m68k-fix-uaccessh-for-gcc-3x.patch
+m68k-fix-constraints-of-the-signal-functions-and-some-cleanup.patch
+m68k-fix-__iounmap-for-030.patch
+m68k-small-flush_icache-cleanup.patch
+m68k-add-the-generic-dma-api-functions.patch
+m68k-dma-api-addition.patch
+m68k-fix-show_registers.patch
+m68k-separate-handler-for-auto-and-user-vector-interrupt.patch
+m68k-cleanup-generic-irq-names.patch
+m68k-cleanup-amiga-irq-numbering.patch
+m68k-introduce-irq-controller.patch
+m68k-convert-generic-irq-code-to-irq-controller.patch
+m68k-convert-amiga-irq-code.patch
+m68k-convert-apollo-irq-code.patch
+m68k-convert-atari-irq-code.patch
+m68k-convert-hp300-irq-code.patch
+m68k-convert-mac-irq-code.patch
+m68k-convert-q40-irq-code.patch
+m68k-convert-sun3-irq-code.patch
+m68k-convert-vme-irq-code.patch

 m68k updates.

+fix-oddball-boolean-logic-in-s390-netiucv.patch
+s390-broken-null-test-in-claw-driver.patch

 s390 updates

+fs-ufs-inodec-make-2-functions-static.patch

 Cleanup

+rtc-add-rtc-ds1553-driver.patch
+rtc-add-rtc-ds1553-driver-tidy.patch
+rtc-add-rtc-ds1553-driver-fix.patch
+rtc-add-rtc-ds1742-driver.patch
+rtc-add-rtc-ds1742-driver-tidy.patch
+rtc-add-rtc-ds1742-driver-fix.patch
+rtc-add-rtc-rs5c348-driver.patch

 More RTC drivers.

+fuse-add-control-filesystem-get_sb_single-fix.patch
+fuse-add-control-filesystem-fuse-comment-control-filesystem.patch
+fuse-scramble-lock-owner-id.patch

 FUSE updates.

 kthread-update-loopc-to-use-kthread-fix.patch

 Folded into kthread-update-loopc-to-use-kthread.patch

-kthread-convert-lock-to-use-kthread.patch

 Droped, I think.

-stop-on-cpu-lost.patch
-stop-on-cpu-lost-tidy.patch

 Dropped.

+led-add-led-heartbeat-trigger-update.patch

 Fix led-add-led-heartbeat-trigger.patch

+autofs4-needs-to-force-fail-return-revalidate-update.patch

 Fix autofs4-needs-to-force-fail-return-revalidate.patch

+add-synclink_gt-custom-hdlc-idle.patch
+add-synclink_gt-crc-return-feature.patch
+fix-synclink_gt-diagnostics-error-reporting.patch
+synclink_gt-add-gt2-adapter-support.patch
+corrections-to-memory-barrier-doc.patch
+add-option-for-stripping-modules-while-installing-them.patch
+binfmt_elf-fix-checks-for-bad-address.patch
+binfmt_elf-fix-checks-for-bad-address-fix.patch
+pacct-two-phase-process-accounting.patch
+pacct-avoidance-to-refer-the-last-thread-as-a-representation-of-the-process.patch
+pacct-none-delayed-process-accounting-accumulation.patch
+ext2-cleanup-put_page-and-comment-fix.patch
+remove-gratuitous-inclusion-of-linux-configh-from.patch
+au1550_ac97-spin_unlock-in-error-path.patch
+generic_file_buffered_write-deadlock-on-vectored-write.patch
+parport-add-to-kernel-doc.patch
+drivers-char-agp-nvidia-agpc-remove-unused-variable.patch
+au1xxx-oss-sound-support-for-au1200.patch
+s390-setupc-cleanup-build-fix.patch
+remove-tty_dont_flip.patch
+fix-kdump-crash-kernel-boot-memory-reservation-for-numa.patch
+fix-biovec-256-in-proc-slabinfo.patch
+add-receive_room-flow-control-to-flush_to_ldisc.patch
+add-receive_room-flow-control-to-flush_to_ldisc-tidy.patch
+remove-unlikelysb-in-prune_dcache.patch

 Misc patches.

+introduce-crashboot-kernel-command-line-parameter.patch
+kdump-cciss-driver-initialization-issue-fix.patch

 Unpleasant kdump patches.

+reiserfs-reorganize-bitmap-loading-functions-fix.patch
+reiserfs-reorganize-bitmap-loading-functions-fix2.patch

 Fix reiserfs-reorganize-bitmap-loading-functions.patch

+cpu-hotplug-revert-init-patch-submitted-for-2617.patch
+cpu-hotplug-revert-initdata-patch-submitted-for-2617.patch
+cpu-hotplug-make-register_cpu_notifier-init-time-only.patch
+cpu-hotplug-make-register_cpu_notifier-init-time-only-fix.patch
+cpu-hotplug-make-cpu_notifier-related-notifier-blocks-__cpuinit-only.patch
+cpu-hotplug-make-cpu_notifier-related-notifier-blocks-__cpuinit-only-fix.patch
+cpu-hotplug-make-cpu_notifier-related-notifier-calls-__cpuinit-only.patch
+cpu-hotplug-make-cpu_notifier-related-notifier-calls-__cpuinit-only-fix.patch
+cpu-hotplug-add-hotplug-versions-of-cpu_notifier.patch
+cpu-hotplug-use-hotplug-version-of-cpu-notifier-in-appropriate-places.patch

 CPU hotplug kernel sectioning optimisation.

-per-task-delay-accounting-taskstats-interface-fix-exit-race-in-per-task-delay-accounting.patch
-per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-use-portable-cputime-api-in-__delayacct_add_tsk.patch
-per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-fix-return-value-of-delayacct_add_tsk.patch

 Folded into other patches.

+chardev-gpio-for-scx200-pc-8736x-add-platforn_device-static-numpins.patch
+chardev-gpio-for-scx200-pc-8736x-add-platforn_device-enomem-on-device_add-failure.patch
+chardev-gpio-for-scx200-pc-8736x-add-platforn_device-scx200-init-undo-malloc.patch
+chardev-gpio-for-scx200-pc-8736x-add-new-pc8736x_gpio-no-static-init.patch
+chardev-gpio-for-scx200-pc-8736x-add-new-pc8736x_gpio-no-weird-comment-placement.patch
+chardev-gpio-for-scx200-pc-8736x-add-new-pc8736x_gpio-fixups.patch
+chardev-gpio-for-scx200-pc-8736x-add-platform_device-request-region.patch
+chardev-gpio-for-scx200-pc-8736x-add-platform_device-request-region-series.patch
+chardev-gpio-for-scx200-pc-8736x-use-dev_dbg-extern-to-header.patch
+chardev-gpio-for-scx200-pc-8736x-fix-gpio_current-make-precedence-explicit.patch
+chardev-gpio-for-scx200-pc-8736x-replace-spinlocks-fix.patch
+chardev-gpio-for-scx200-pc-8736x-replace-spinlocks-include-linux-ioh.patch

 Update the GPIO patches in -mm.

+fix-and-optimize-clock-source-update.patch

 Update time management patches in -mm.

+sched-cpu-hotplug-race-vs-set_cpus_allowed.patch

 CPu scheduler fix.

+sched_exit-fix-parent-time_slice-calculation.patch
+sched_exit-move-the-callsite-to-do_exit.patch
+sched-uninline-task_rq_lock.patch
+bug-if-setscheduler-is-called-from-interrupt-context.patch

 CPu scheduler work.

+swap_prefetch-vs-zoned-counters.patch

 Fix up prefetch for the zoned-counters work.

+pi-futex-rt-mutex-tester-fix.patch

 Fix pi-futex-rt-mutex-tester.patch

+drop-tasklist-lock-in-do_sched_setscheduler.patch
+rtmutex-modify-rtmutex-tester-to-test-the-setscheduler.patch
+rtmutex-propagate-priority-settings-into-pi-lock-chains.patch
+rtmutex-propagate-priority-settings-into-pi-lock-chains-fix.patch

 pi-fuex updates.

+selinux-add-sockcreate-node-to-procattr-api.patch

 Add selinux hooks to /proc rework in -mm.

+ecryptfs-superblock-operations-ecryptfs-build-fix.patch
+ecryptfs-crypto-functions-fix-filesize-on-hard-link-creation.patch
+ecryptfs-remove-debugging-cruft.patch
+ecryptfs-get_sb_dev-fix.patch

 ecrtpyfs updates.

+make-kernel-sysctlc_proc_do_string-static.patch

 Cleanup.

+namespaces-utsname-implement-clone_newuts-flag-tidy.patch

 Clean up namespaces-utsname-implement-clone_newuts-flag.patch

+task-watchers-register-semundo-task-watcher-cleanup.patch

 Clean up task-watchers-register-semundo-task-watcher.patch

+fs-reiser4-possible-cleanups.patch
+reiser4-get_sb_dev-fix.patch
+reiser4-vs-zoned-allocator.patch

 reiser4 things.

-ide_dma_speed-fixes-warning-fix.patch
-ide_dma_speed-fixes-tidy.patch

 Folded into ide_dma_speed-fixes.patch

-hpt370-clean-up-dma-timeout-handling-cleanup.patch

 Folded into hpt370-clean-up-dma-timeout-handling.patch

+drivers-ide-legacy-ide-csc-make-2-functions-static.patch

 IDE cleanup.

+dm-mirror-log-sector-size-fix.patch
+dm-mirror-log-refactor-context.patch
+dm-mirror-log-bitset_size-fix.patch
+dm-mirror-log-sync_count-fix.patch
+dm-kcopyd-error-accumulation-fix.patch
+dm-table-split_args-handle-no-input.patch
+dm-consolidate-creation-functions.patch
+dm-add-exports-2.patch
+dm-create-error-table.patch
+dm-prevent-removal-if-open.patch
+dm-improve-error-message-consistency.patch
+dm-support-ioctls-on-mapped-devices.patch
+dm-linear-support-ioctls.patch
+dm-mpath-support-ioctls.patch
+dm-export-blkdev_driver_ioctl.patch

 Device mapper updates.

+drivers-md-mdc-make-code-static.patch

 MD cleanup.

-genirq-convert-the-x86_64-architecture-to-irq-chips.patch
-genirq-convert-the-i386-architecture-to-irq-chips.patch
-genirq-convert-the-i386-architecture-to-irq-chips-fix-2.patch
-genirq-add-chip-eoi-fastack-fasteoi.patch
-genirq-add-chip-eoi-fastack-fasteoi-fix.patch
-genirq-allow-usage-of-no_irq_chip.patch
+genirq-add-irq_type_sense_mask.patch
+genirq-add-irq-chip-support-fasteoi-handler-handle-interrupt-disabling.patch
+genirq-irq-document-what-an-irq-is.patch
+genirq-add-chip-eoi-fastack-fasteoi-core.patch
+genirq-add-chip-eoi-fastack-fasteoi-fix.patch

 Various genirq patches added, removed and moved around.

+acpi-reduce-code-size-clean-up-fix-validator-message.patch

 Remove some odd ACPI constructs to make lockdep happy.

-lock-validator-sparc64-sparc-m68k-alpha-cris-build-fix.patch
-lock-validator-floppyc-irq-release-fix.patch
-lock-validator-floppyc-irq-release-fix-fix.patch
-lock-validator-floppyc-irq-release-fix-fix-fix.patch
-lock-validator-forcedethc-fix.patch
-lock-validator-mutex-section-binutils-workaround.patch
-lock-validator-add-__module_address-method.patch
-lock-validator-better-lock-debugging.patch
-lock-validator-locking-api-self-tests.patch
-lock-validator-locking-api-self-tests-self-test-fix.patch
-lock-validator-locking-init-debugging-improvement.patch
-lock-validator-beautify-x86_64-stacktraces.patch
-lock-validator-beautify-x86_64-stacktraces-fix.patch
-lock-validator-beautify-x86_64-stacktraces-fix-2.patch
-lock-validator-beautify-x86_64-stacktraces-fix-3.patch
-lock-validator-beautify-x86_64-stacktraces-fix-4.patch
-lock-validator-x86_64-document-stack-frame-internals.patch
-lock-validator-stacktrace.patch
-lock-validator-stacktrace-build-fix.patch
-lock-validator-stacktrace-warning-fix.patch
-lock-validator-stacktrace-fix-on-x86_64.patch
-lock-validator-fown-locking-workaround.patch
-lock-validator-sk_callback_lock-workaround.patch
-lock-validator-irqtrace-core.patch
-lock-validator-irqtrace-core-powerpc-fix-1.patch
-lock-validator-irqtrace-core-non-x86-fix.patch
-lock-validator-irqtrace-core-non-x86-fix-2.patch
-lock-validator-irqtrace-core-non-x86-fix-3.patch
-lock-validator-irqtrace-entrys-fix.patch
-lock-validator-irqtrace-core-remove-softirqc-warn_on.patch
-lock-validator-irqtrace-cleanup-include-asm-i386-irqflagsh.patch
-lock-validator-irqtrace-cleanup-include-asm-x86_64-irqflagsh.patch
-lock-validator-x86_64-irqflags-trace-entrys-fix.patch
-lock-validator-x86_64-irqflags-trace-entrys-fix-fix.patch
-lock-validator-lockdep-add-local_irq_enable_in_hardirq-api.patch
-lock-validator-add-per_cpu_offset.patch
-lock-validator-add-per_cpu_offset-fix.patch
-lock-validator-core.patch
-lock-validator-core-early_boot_irqs_-build-fix.patch
-lock-validator-core-early_boot_irqs_-build-fix-sparc64-sparc-m68k-alpha-cris-irqtrace-build-fix.patch
-lock-validator-core-fix-compiler-warning.patch
-lock-validator-core-add-config_debug_non_nested_unlocks.patch
-lock-validator-core-provide-lockdep_off-lockdep_on-apis.patch
-lock-validator-procfs.patch
-lock-validator-core-multichar-fix.patch
-lock-validator-core-count_matching_names-fix.patch
-lock-validator-core-provide-lockdep_reinit_key-api.patch
-lock-validator-core-print-info-not-bug.patch
-lock-validator-design-docs.patch
-lock-validator-prove-rwsem-locking-correctness.patch
-lock-validator-prove-rwsem-locking-correctness-fix.patch
-lock-validator-prove-rwsem-locking-correctness-powerpc-fix.patch
-lock-validator-prove-spinlock-rwlock-locking-correctness.patch
-lock-validator-prove-mutex-locking-correctness.patch
-lock-validator-prove-mutex-locking-correctness-fix-null-type-name-bug.patch
-better-lock-debugging-remove-mutex-deadlock-checking-code.patch
-lock-validator-print-all-lock-types-on-sysrq-d.patch
-lock-validator-x86_64-early-init.patch
-lock-validator-smp-alternatives-workaround.patch
-lock-validator-do-not-recurse-in-printk.patch
-lock-validator-disable-nmi-watchdog-if-config_lockdep.patch
-lock-validator-disable-nmi-watchdog-if-config_lockdep-i386.patch
-lock-validator-disable-nmi-watchdog-if-config_lockdep-x86_64.patch
-lock-validator-special-locking-bdev.patch
-lock-validator-special-locking-bdev-fix.patch
-lock-validator-special-locking-direct-io.patch
-lock-validator-special-locking-serial.patch
-lock-validator-special-locking-serial-fix.patch
-lock-validator-special-locking-dcache.patch
-lock-validator-special-locking-i_mutex.patch
-lock-validator-special-locking-s_lock.patch
-lock-validator-special-locking-futex.patch
-lock-validator-special-locking-genirq.patch
-lock-validator-special-locking-genirq-lock-validator-early_init_irq_lock_type-build-fix.patch
-lock-validator-special-locking-completions.patch
-lock-validator-special-locking-waitqueues.patch
-lock-validator-special-locking-mm.patch
-lock-validator-special-locking-serio.patch
-lock-validator-special-locking-slab.patch
-lock-validator-special-locking-skb_queue_head_init.patch
-lock-validator-special-locking-net-ipv4-igmpcpatch.patch
-lock-validator-special-locking-net-ipv4-igmpc-2.patch
-lock-validator-special-locking-timerc.patch
-lock-validator-special-locking-schedc.patch
-lock-validator-special-locking-sctp.patch
-lock-validator-special-locking-hrtimerc.patch
-lock-validator-special-locking-sock_lock_init.patch
-lock-validator-special-locking-af_unix.patch
-lock-validator-special-locking-af_unix-undo-af_unix-_bh-locking-changes-and-split-lock-type.patch
-lock-validator-special-locking-af_unix-undo-af_unix-_bh-locking-changes-and-split-lock-type-fix.patch
-lock-validator-special-locking-bh_lock_sock.patch
-lock-validator-annotate-ieee1394-skb-head-locking.patch
-lock-validator-special-locking-mmap_sem.patch
-lock-validator-special-locking-sb-s_umount.patch
-lock-validator-special-locking-reiser4-false-positive.patch
-lock-validator-special-locking-sb-s_umount-fix.patch
-lock-validator-special-locking-sb-s_umount-2.patch
-lock-validator-special-locking-sb-s_umount-2-fix.patch
-lockdep-annotate-rpc_populate-for.patch
-lock-validator-special-locking-jbd.patch
-lock-validator-special-locking-posix-timers.patch
-lock-validator-annotate-ntfs-locking-rules.patch
-lock-validator-special-locking-sch_genericc.patch
-lock-validator-special-locking-xfrm.patch
-lockdep-annotate-the-quota-code.patch
-lockdep-add-i_mutex-ordering-annotations-to-the-sunrpc.patch
-lockdep-add-parent-child-annotations-to-usbfs.patch
-lock-validator-special-locking-sound-core-seq-seq_portsc.patch
-lock-validator-special-locking-sound-core-seq-seq_devicec.patch
-lock-validator-special-locking-sound-core-seq-seq_devicec-fix.patch
-lock-validator-fix-rt_hash_lock_sz.patch
-lock-validator-introduce-irq__lockdep.patch
-lock-validator-fix-sparc32-breakage.patch
-locking-validator-special-rule-8390c-disable_irq.patch
-locking-validator-special-rule-3c59xc-disable_irq.patch
-lock-validator-enable-lock-validator-in-kconfig.patch
-lock-validator-enable-lock-validator-in-kconfig-require-trace_irqflags_support.patch
-lock-validator-enable-lock-validator-in-kconfig-not-yet.patch
-lock-validator-enable-lock-validator-in-kconfig-add-config_debug_non_nested_unlocks-kconfig.patch
-lockdep-one-stacktrace-column-if-config_lockdep=y.patch
-i386-remove-multi-entry-backtraces.patch
-lockdep-further-improve-stacktrace-output.patch
-lock-validator-irqtrace-support-non-x86-architectures.patch
-lock-validator-disable-oprofile-if-lockdep=y.patch
-lock-validator-select-kallsyms_all.patch
-lock-validator-v3.patch
-lockdep-x86-only.patch
-lockdep-really-x86-only.patch
-lockdep-really-really-x86-only.patch
-lock-validator-s390-stacktrace-interface.patch
-lock-validator-s390-config_frame_pointer-support.patch
-lock-validator-s390-rwsem-semaphore-changes.patch
-lock-validator-early_init_irq_lock_type--console_init.patch
-lock-validator-s390-irqtrace-support.patch
-lock-validator-__local_bh_enable-_local_bh_enable.patch
-lock-validator-s390-use-raw_spinlock-in-mcck-handler.patch
-lock-validator-add-s390-to-supported-options.patch
-lockdep-avoid-false-positive-illegal-lock-usage-message-in-qeth-driver.patch
-lockdep-hack-around-build-errors.patch

 Droped.

-kgdb-core-lite.patch
-lock-validator-special-locking-kgdb.patch
-kgdb-core-lite-add-reboot-command.patch
-kgdb-8250.patch
-kgdb-8250-fix.patch
-kgdb-netpoll_pass_skb_to_rx_hook.patch
-kgdb-eth.patch
-kgdb-i386-lite.patch
-kgdb-cfi_annotations.patch
-kgdb-sysrq_bugfix.patch
-kgdb-module.patch
-kgdb-core.patch
-kgdb-i386.patch

 Shelved.

-journal_add_journal_head-debug.patch
-page-owner-tracking-leak-detector.patch
-unplug-can-sleep.patch
-firestream-warnings.patch
-#periodically-scan-redzone-entries-and-slab-control-structures.patch
-slab-leak-detector.patch
-releasing-resources-with-children.patch
-nr_blockdev_pages-in_interrupt-warning.patch
-detect-atomic-counter-underflows.patch
-device-suspend-debug.patch
-slab-cache-shrinker-statistics.patch
-mm-debug-dump-pageframes-on-bad_page.patch
-debug-warn-if-we-sleep-in-an-irq-for-a-long-time.patch
-debug-shared-irqs.patch
-make-frame_pointer-default=y.patch
-i386-enable-4k-stacks-by-default.patch
-pidhash-temporary-debug-checks.patch
-acpi-identify-which-device-is-not-power-manageable.patch
-revert-tty-buffering-comment-out-debug-code.patch
-mutex-subsystem-synchro-test-module.patch
-x86-e820-debugging.patch
-slab-leaks3-default-y.patch
-x86-kmap_atomic-debugging.patch
-profile-likely-unlikely-macros.patch
-vdso-print-fatal-signals.patch
-vdso-improve-print_fatal_signals-support-by-adding-memory-maps.patch

 Shelved.



All 1268 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/patch-list


