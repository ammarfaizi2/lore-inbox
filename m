Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWI1Iqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWI1Iqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 04:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWI1Iqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 04:46:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52875 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751789AbWI1Iqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 04:46:31 -0400
Date: Thu, 28 Sep 2006 01:46:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-mm2
Message-Id: <20060928014623.ccc9b885.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/


- Added the SuperH architecture git tree to the -mm lineup as git-sh.patch
  (Paul Mundt)

- Added the SuperH64 architecture git tree to the -mm lineup as git-sh64.patch
  (Paul Mundt)

- Added the PCI-Domain support tree to the -mm lineup as git-pciseg.patch
  (Jeff Garzik)

- The git-input tree has been temporarily dropped due to various USB mouse
  related failures.

- More updates to the MSI code.  If your machine has Message Signalled
  Interrupts, please enable it and give it a try.

- The reboot command doesn't work if you're using netconsole-over-e100.




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

- When reporting bugs in this kernel via email, please also rewrite the
  email Subject: in some manner to reflect the nature of the bug.  Some
  developers filter by Subject: when looking for messages to read.

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.




Changes since 2.6.18-mm1:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-arm.patch
 git-block.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-intelfb.patch
 git-jfs.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-ocfs2.patch
 git-parisc.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-serial.patch
 git-pciseg.patch
 git-s390.patch
 git-scsi-misc.patch
 git-block-vs-git-sas.patch
 git-scsi-target.patch
 git-watchdog.patch

 git trees

+__percpu_alloc_mask-has-to-be-__always_inline-in-up-case.patch
+sys_getcpu-prototype-annotated.patch
+remove-generic__raw_read_trylock.patch
+jbd-memory-leak-in-journal_init_dev.patch

 Queued for 2.6.19-rc1.

-autofs4-zero-timeout-prevents-shutdown.patch
-rtc-lockdep-fix-workaround.patch
-i386-bootioremap--kexec-fix.patch
-do-not-free-non-slab-allocated-per_cpu_pageset.patch
-vidioc_enumstd-bug.patch
-backlight-fix-oops-in-__mutex_lock_slowpath-during-head-sys-class-graphics-fb0.patch
-cpu-to-node-relationship-fixup-take2.patch
-cpu-to-node-relationship-fixup-map-cpu-to-node.patch
-i386-fix-flat-mode-numa-on-a-real-numa-system.patch
-load_module-no-bug-if-module_subsys-uninitialized.patch
-fix-longstanding-load-balancing-bug-in-the-scheduler.patch
-trigger-a-syntax-error-if-percpu-macros-are-incorrectly-used.patch
-allow-file-systems-to-manually-d_move-inside-of-rename.patch
-jbd-fix-commit-of-ordered-data-buffers.patch
-update-to-the-kernel-kmap-kunmap-api.patch
-acpi-mwait-c-state-fixes.patch
-kthread-switch-arch-arm-kernel-apmc.patch
-gregkh-driver-documentation-abi-devfs-is-not-obsolete-but-removed.patch
-gregkh-driver-deprecate-physdev-keys.patch
-gregkh-driver-class_device_create-make-fmt-argument-const-char.patch
-gregkh-driver-device_create-make-fmt-argument-const-char.patch
-gregkh-driver-driver-core-add-const-to-class_create.patch
-gregkh-driver-sysfs-make-poll-behaviour-consistent.patch
-gregkh-driver-debugfs-kernel-doc-fixes-for-debugfs.patch
-gregkh-driver-sysfs_symlink_in_root.patch
-gregkh-driver-suspend-infrastructure-cleanup-and-extension.patch
-gregkh-driver-suspend-pci.patch
-gregkh-driver-make-suspend-quieter.patch
-gregkh-driver-fix-broken-dubious-driver-suspend-methods.patch
-gregkh-driver-pm-define-pm_event_prethaw.patch
-gregkh-driver-pm-pci-and-ide-handle-pm_event_prethaw.patch
-gregkh-driver-pm-video-drivers-and-pm_event_prethaw.patch
-gregkh-driver-pm-usb-hcds-use-pm_event_prethaw.patch
-gregkh-driver-pm-issue-pm_event_prethaw.patch
-gregkh-driver-pm-update-docs-for-writing-...-power-state.patch
-gregkh-driver-pm-add-kconfig-option-for-deprecated-...-power-state-files.patch
-gregkh-driver-pm-schedule-sys-devices-...-power-state-for-removal.patch
-gregkh-driver-pm-no-suspend_prepare-phase.patch
-gregkh-driver-pm-add-sys-power-documentation-to-documentation-abi.patch
-gregkh-driver-pm-device_suspend-resume-may-sleep.patch
-gregkh-driver-pm-platform_bus-and-late_suspend-early_resume.patch
-gregkh-driver-device-groups.patch
-gregkh-driver-device-class-parent.patch
-gregkh-driver-device-class-attr.patch
-gregkh-driver-device_rename.patch
-gregkh-driver-device-virtual.patch
-gregkh-driver-class_device_interface.patch
-gregkh-driver-device_bin_file.patch
-gregkh-driver-kobject-must_check-fixes.patch
-gregkh-driver-sysfs_remove_bin_file-no-return-value-dump_stack-on-error.patch
-gregkh-driver-driver-core-fix-comments-in-drivers-base-power-resume.c.patch
-gregkh-driver-driver-core-fixed-add_bind_files-definition.patch
-gregkh-driver-add-__must_check-to-device-management-code.patch
-gregkh-driver-add-config_enable_must_check.patch
-gregkh-driver-v4l-dev2-handle-__must_check.patch
-gregkh-driver-drivers-base-platform-notify-needs-to-occur-before-drivers-attach-to-the-device.patch
-gregkh-driver-drivers-base-check-errors.patch
-gregkh-driver-sysfs-add-proper-sysfs_init-prototype.patch
-gregkh-driver-driver-multithread.patch
-gregkh-driver-pci-multithreaded-probe.patch
-gregkh-driver-driver-core-fix-potential-deadlock-in-driver-core.patch
-gregkh-driver-driver-core-remove-unneeded-routines-from-driver-core.patch
-gregkh-driver-driver-core-don-t-call-put-methods-while-holding-a-spinlock.patch
-scsi-device_reprobe-can-fail.patch
-gregkh-i2c-i2c-dev-cleanups.patch
-gregkh-i2c-i2c-dev-convert-array-to-list.patch
-gregkh-i2c-i2c-dev-drop-template-client.patch
-gregkh-i2c-i2c-dev-device.patch
-gregkh-i2c-i2c-__must_check-fixes.patch
-gregkh-i2c-i2c-__must_check-fixes-i2c-dev.patch
-gregkh-i2c-i2c-algo-sibyte-cleanups.patch
-gregkh-i2c-i2c-algo-sibyte-merge-in-i2c-sibyte.patch
-gregkh-i2c-i2c-sibyte-drop-kip-walker-address.patch
-gregkh-i2c-i2c-au1550-fix-timeout-problem.patch
-gregkh-i2c-i2c-au1550-add-smbus-functionality-flag.patch
-gregkh-i2c-i2c-au1550-add-au1200-support.patch
-gregkh-i2c-i2c-fix-copy-n-paste-in-subsystem-Kconfig.patch
-gregkh-i2c-i2c-matroxfb-c99-struct-init.patch
-gregkh-i2c-i2c-algo-bit-kill-mdelay.patch
-gregkh-i2c-i2c-bus-driver-for-TI-OMAP-boards.patch
-gregkh-i2c-i2c-isa-plan-for-removal.patch
-gregkh-i2c-i2c-stub-add-chip_addr-param.patch
-gregkh-i2c-i2c-dev-attach-detach-adapter-cleanups.patch
-gregkh-i2c-i2c-chips-__must_check-fixes.patch
-gregkh-i2c-i2c-isa-return-attach_adapter.patch
-gregkh-i2c-i2c-algo-bit-cleanups.patch
-gregkh-i2c-i2c-algo-pcf-kill-mdelay.patch
-gregkh-i2c-i2c-drop-useless-masking.patch
-gregkh-i2c-i2c-warn-on-failed-client-attach.patch
-gregkh-i2c-i2c-viapro-add-VT8251-VT8237A.patch
-gregkh-i2c-i2c-isa-restore-driver-owner.patch
-gregkh-i2c-i2c-constify-i2c_algorithm.patch
-gregkh-i2c-i2c-algos-constify-i2c_algorithm.patch
-gregkh-i2c-i2c-busses-constify-i2c_algorithm.patch
-gregkh-i2c-i2c-drop-slave-functions.patch
-i2c-mpc-fix-up-error-handling.patch
-ia64-kprobes-fixup-the-pagefault-exception-caused-by-probehandlers.patch
-stowaway-keyboard-support.patch
-stowaway-keyboard-support-update.patch
-wistron-fix-detection-of-special-buttons.patch
-fail-kernel-compilation-in-case-of-unresolved-symbols-v2.patch
-kerneldoc-error-on-ata_piixc.patch
-1-of-2-jmicron-driver.patch
-1-of-2-jmicron-driver-fix.patch
-2-of-2-jmicron-driver-plumbing-and-quirk.patch
-2-of-2-jmicron-driver-plumbing-and-quirk-cleanup.patch
-via-sata-oops-on-init.patch
-e1000-memory-leak-in-e1000_set_ringparam.patch
-drivers-net-acenicc-removal-of-old-code.patch
-drivers-net-tokenring-lanstreamerc-removal-of-old-code.patch
-drivers-net-tokenring-lanstreamerh-removal-of-old-code.patch
-drivers-net-typhoonc-removal-of-old-code.patch
-signedness-issue-in-drivers-net-phy-phy_devicec.patch
-fix-possible-null-ptr-deref-in-forcedeth.patch
-e1000-account-for-net_ip_align-when-calculating-bufsiz.patch
-net-ipv6-bh_lock_sock_nested-on-tcp_v6_rcv.patch
-via-ircc-fix-memory-leak.patch
-atm-he-fix-section-mismatch.patch
-add-netpoll-netconsole-support-to-vlan-devices.patch
-neighbourc-pneigh_get_next-skips-published-entry.patch
-nfs-replace-null-dentries-that-appear-in-readdirs-list-2.patch
-add-newline-to-nfs-dprintk.patch
-fs-nfs-make-code-static.patch
-gregkh-pci-resources-insert-identical-resources-above-existing-resources.patch
-gregkh-pci-msi-cleanup-existing-msi-quirks.patch
-gregkh-pci-msi-factorize-common-code-in-pci_msi_supported.patch
-gregkh-pci-msi-export-the-pci_bus_flags_no_msi-flag-in-sysfs.patch
-gregkh-pci-msi-rename-pci_cap_id_ht_irqconf-into-pci_cap_id_ht.patch
-gregkh-pci-msi-blacklist-pci-e-chipsets-depending-on-hypertransport-msi-capability.patch
-gregkh-pci-pcie-check-and-return-bus_register-errors.patch
-gregkh-pci-pci-express-aer-implemetation-aer-howto-document.patch
-gregkh-pci-pci-express-aer-implemetation-export-pcie_port_bus_type.patch
-gregkh-pci-pci-express-aer-implemetation-aer-core-and-aerdriver.patch
-gregkh-pci-pci-express-aer-implemetation-pcie_portdrv-error-handler.patch
-gregkh-pci-shpchp-must_check-fixes.patch
-gregkh-pci-pci-hotplug-must_check-fixes.patch
-gregkh-pci-pci-must_check-fixes.patch
-gregkh-pci-pci-multiprobe-sanitizer.patch
-gregkh-pci-pci-drivers-pci-hotplug-acpiphp_glue.c-make-a-function-static.patch
-gregkh-pci-pci-restore-pci-express-capability-registers-after-pm-event.patch
-gregkh-pci-pci-hotplug-cleanup-pcihp-skeleton-code.patch
-gregkh-pci-acpiphp-set-hpp-values-before-starting-devices.patch
-gregkh-pci-acpiphp-initialize-ioapics-before-starting-devices.patch
-gregkh-pci-acpiphp-do-not-initialize-existing-ioapics.patch
-gregkh-pci-pci-add-pci_stop_bus_device.patch
-gregkh-pci-acpiphp-stop-bus-device-before-acpi_bus_trim.patch
-gregkh-pci-acpiphp-disable-bridges.patch
-gregkh-pci-pci-assign-ioapic-resource-at-hotplug.patch
-gregkh-pci-acpiphp-add-support-for-ioapic-hot-remove.patch
-gregkh-pci-ia64-pci-dont-disable-irq-which-is-not-enabled.patch
-gregkh-pci-pciehp-fix-wrong-return-value.patch
-revert-scsi-improve-inquiry-printing.patch
-dc395x-fix-printk-format-warning.patch
-pci_module_init-conversion-in-scsi-subsys-2nd-try.patch
-megaraid-use-the-proper-type-to-hold-the-irq-number.patch
-drivers-scsi-dpt-dpti_i2oh-removal-of-old.patch
-drivers-scsi-gdthh-removal-of-old-scsi-code.patch
-drivers-scsi-nsp32h-removal-of-old-scsi-code.patch
-drivers-message-fusion-linux_compath-removal-of-old-code.patch
-signedness-issue-in-drivers-scsi-iprc.patch
-signedness-issue-in-drivers-scsi-osstc.patch
-bodge-scsi-misc-module-reference-count-checks-with-no-module_unload.patch
-scsi-remove-seagateh.patch
-scsi-seagate-scsi_cmnd-conversion.patch
-3w-xxxx-fix-ata-udma-upgrade-message-number.patch
-scsi-included-header-cleanup.patch
-gregkh-usb-usb-unusual_devs-entry-for-lacie-dvd-rw.patch
-gregkh-usb-usb-unusual_dev-entry-for-sony-p990i.patch
-gregkh-usb-usb-doc-patch-1.patch
-gregkh-usb-usb-doc-patch-2.patch
-gregkh-usb-usb-ohci-avoids-root-hub-timer-polling.patch
-gregkh-usb-usb-ohci-s3c2410.c-clock-now-usb-bus-host.patch
-gregkh-usb-usb-ohci-controller-support-for-pnx4008.patch
-gregkh-usb-usb-kill-usb-kconfig-warning.patch
-gregkh-usb-usb-move-linux-usb_otg.h-to-linux-usb-otg.h.patch
-gregkh-usb-usb-pxa2xx_udc-understands-gpio-based-vbus-sensing.patch
-gregkh-usb-usb-allow-compile-in-g_ether-fix-typo.patch
-gregkh-usb-usb-ark3116-add-tiocgserial-and-tiocsserial-ioctl-calls.patch
-gregkh-usb-usb-ark3116-formatting-cleanups.patch
-gregkh-usb-usb-make-usb_buffer_free-null-safe.patch
-gregkh-usb-usbcore-add-configuration_string-to-attribute-group.patch
-gregkh-usb-usb-add-driver-for-phidgetmotorcontrol.patch
-gregkh-usb-usb-put-phidgets-driver-in-a-sysfs-class.patch
-gregkh-usb-usb-phidgets-should-check-create_device_file-return-value.patch
-gregkh-usb-usbfs-private-mutex-for-open-release-and-remove.patch
-gregkh-usb-usbfs-detect-device-unregistration.patch
-gregkh-usb-usb-skeleton-don-t-submit-urbs-after-disconnection.patch
-gregkh-usb-usbcore-rename-usb_suspend_device-to-usb_port_suspend.patch
-gregkh-usb-usbcore-move-code-among-source-files.patch
-gregkh-usb-usbcore-add-usb_device_driver-definition.patch
-gregkh-usb-usbcore-make-usb_generic-a-usb_device_driver.patch
-gregkh-usb-usbcore-split-suspend-resume-for-device-and-interfaces.patch
-gregkh-usb-usbcore-resume-device-resume-recursion.patch
-gregkh-usb-usbcore-track-whether-interfaces-are-suspended.patch
-gregkh-usb-usbcore-set-device-and-power-states-properly.patch
-gregkh-usb-usbcore-fix-up-device-and-power-state-tests.patch
-gregkh-usb-usbcore-suspending-devices-with-no-driver.patch
-gregkh-usb-hub-driver-improve-use-of-ifdef.patch
-gregkh-usb-usb-usbtouchscreen-version-0.4.patch
-gregkh-usb-usb-pl2303-removes-unneeded-goto.patch
-gregkh-usb-usb-pl2303-remove-80-columns-limit-violations-in-pl2303-driver.patch
-gregkh-usb-usb-pl2303-cosmetic-changes-to-pl2303_buf_-clear-data_avail.patch
-gregkh-usb-usb-pl2303-reduce-number-of-prototypes.patch
-gregkh-usb-usb-pl2303-cosmetic-changes-to-quirk.patch
-gregkh-usb-usb-usbnet-add-unlink_rx_urbs-call-to-allow-for-jumbo-frames.patch
-gregkh-usb-usb-asix-add-ax88178-support-and-many-other-changes.patch
-gregkh-usb-usbnet-printk-format-warning.patch
-gregkh-usb-usb-ipaq-minor-ipaq_open-cleanup.patch
-gregkh-usb-usb-usbcore-get-rid-of-the-timer-in-usb_start_wait_urb.patch
-gregkh-usb-usb-wacom-tablet-driver-reorganization.patch
-gregkh-usb-usb-garmin_gps-support-for-new-generation-of-gps-receivers.patch
-gregkh-usb-usb-build-fixes-ohci-omap.patch
-gregkh-usb-usb-onetouch-handle-errors-from-input_register_device.patch
-gregkh-usb-usb-correct-locking-in-gadgetfs_disconnect.patch
-gregkh-usb-usb-fix-ep_config-to-return-correct-value.patch
-gregkh-usb-usb-gadgetfs-protect-ep_release-with-lock.patch
-gregkh-usb-usb-gmidi-new-usb-midi-gadget-class-driver.patch
-gregkh-usb-usb-make-file-operations-structs-in-drivers-usb-const.patch
-gregkh-usb-usb-making-the-kernel-wshadow-clean-usb-completion.patch
-gregkh-usb-usb-new-functions-to-check-endpoints-info.patch
-gregkh-usb-usb-usblp-use-usb_endpoint_-functions.patch
-gregkh-usb-usb-hub-use-usb_endpoint_-functions.patch
-gregkh-usb-usb-appletouch-use-usb_endpoint_-functions.patch
-gregkh-usb-usb-acecad-use-usb_endpoint_-functions.patch
-gregkh-usb-usb-ati_remote-use-usb_endpoint_-functions.patch
-gregkh-usb-usb-keyspan_remote-use-usb_endpoint_-functions.patch
-gregkh-usb-usb-powermate-use-usb_endpoint_-functions.patch
-gregkh-usb-usb-usb-serial-use-usb_endpoint_-functions.patch
-gregkh-usb-usb-usblcd-use-usb_endpoint_-functions.patch
-gregkh-usb-usb-ldusb-use-usb_endpoint_-functions.patch
-gregkh-usb-usb-net1080-inherent-pad-length.patch
-gregkh-usb-usb-add-poll-to-gadgetfs-s-endpoint-zero.patch
-gregkh-usb-usb-gadget-gadgetfs-dont-try-to-lock-before-free.patch
-gregkh-usb-usb-properly-unregister-reboot-notifier-in-case-of-failure-in-ehci-hcd.patch
-gregkh-usb-uhci-increase-resume-detect-off-delay.patch
-gregkh-usb-usbcore-make-hcd_endpoint_disable-wait-for-queue-to-drain.patch
-gregkh-usb-usbcore-khubd-and-busy-port-handling.patch
-gregkh-usb-usb-skeleton-small-update.patch
-gregkh-usb-usb-storage-add-rio-karma-eject-support.patch
-gregkh-usb-usb-deal-with-broken-config-descriptors.patch
-gregkh-usb-wusb-hub-recognizes-wusb-ports.patch
-gregkh-usb-wusb-handle-wusb-device-ep0-speed-settings.patch
-gregkh-usb-wusb-pretty-print-new-devices.patch
-gregkh-usb-usb-core-use-const-where-possible.patch
-gregkh-usb-usb-fix-signedness-issue-in-drivers-usb-gadget-ether.c.patch
-gregkh-usb-usb-fix-typo-in-drivers-usb-gadget-kconfig.patch
-gregkh-usb-usb-storage-fix-for-ufi-lun-detection.patch
-gregkh-usb-usbcore-help-drivers-to-change-device-configs.patch
-gregkh-usb-usb-turn-usb_resume_both-into-static-inline.patch
-gregkh-usb-usb-usb-hub-driver-improve-use-of-ifdef-fix.patch
-gregkh-usb-usb-remove-struct-usb_operations.patch
-gregkh-usb-usbcore-add-flag-for-whether-a-host-controller-uses-dma.patch
-gregkh-usb-usbcore-trim-down-usb_bus-structure.patch
-gregkh-usb-usbmon-don-t-call-mon_dmapeek-if-dma-isn-t-being-used.patch
-gregkh-usb-usb-ethernet-gadget-avoids-zlps-for-musb_hdrc.patch
-gregkh-usb-usb-ehci-whitespace-fixes.patch
-gregkh-usb-gadgetfs-patch-for-ep0out.patch
-gregkh-usb-usb-replace-kernel_thread-with-kthread_run-in-libusual.c.patch
-gregkh-usb-usb-usb-serial-gadget-smp-related-bug.patch
-gregkh-usb-usb-net2280-update-dma-buffer-allocation.patch
-gregkh-usb-usb-ohci-at91-two-one-liners.patch
-gregkh-usb-usb-usb-input-usbmouse.c-whitespace-cleanup.patch
-gregkh-usb-usb-ub-let-cdrecord-to-see-a-device-with-media-absent.patch
-gregkh-usb-usbcore-store-each-usb_device-s-level-in-the-tree.patch
-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
-gregkh-usb-usbcore-non-hub-specific-uses-of-autosuspend.patch
-gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch
-gregkh-usb-usb-fix-root-hub-resume-when-config_usb_suspend-is-not-set.patch
-gregkh-usb-usb-core-must_check.patch
-gregkh-usb-usb-misc-must_check.patch
-gregkh-usb-usb-atm-must_check.patch
-gregkh-usb-usb-class-must_check.patch
-gregkh-usb-usb-input-must_check.patch
-gregkh-usb-usb-host-must_check.patch
-gregkh-usb-usb-serial-must_check-fixes.patch
-gregkh-usb-cypress_m8-use-appropriate-urb-polling-interval.patch
-gregkh-usb-cypress_m8-use-usb_fill_int_urb-where-appropriate.patch
-gregkh-usb-cypress_m8-improve-control-endpoint-error-handling.patch
-gregkh-usb-cypress_m8-implement-graceful-failure-handling.patch
-gregkh-usb-add-aircable-usb-bluetooth-dongle-driver.patch
-gregkh-usb-aircable-fix-printk-format-warnings.patch
-gregkh-usb-usb-adutux-driver.patch
-gregkh-usb-usb-add-playstation-2-trance-vibrator-driver.patch
-gregkh-usb-usb-moschip-7840-usb-serial-driver.patch
-gregkh-usb-usb-serial-support-alcor-micro-corp.-usb-2.0-to-rs-232-through-pl2303-driver.patch
-gregkh-usb-usb-ftdi-elan-client-driver-for-elan-uxxx-adapters.patch
-gregkh-usb-usb-u132-hcd-host-controller-driver-for-elan-u132-adapter.patch
-gregkh-usb-usb-remove-unneeded-void-casts-in-core-files.patch
-gregkh-usb-usb-dealias-110-code.patch
-gregkh-usb-usb-ohci_usb-can-oops-on-shutdown.patch
-gregkh-usb-usb-force-root-hub-resume-after-power-loss.patch
-gregkh-usb-usb-ehci-update-via-workaround.patch
-gregkh-usb-usb-remove-otg-build-warning.patch
-gregkh-usb-airprime_major_update.patch
-gregkh-usb-usb-storage-add-rio-karma-eject-support-fix.patch
-fix-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
-x86_64-mm-i386-up-generic-arch.patch
-x86_64-mm-temp-revert-arch-perfmon.patch
-x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch
-x86_64-mm-utilize-performance-counter-reservation-framework-in-oprofile.patch
-x86_64-mm-add-smp-support-on-x86_64-to-reservation-framework.patch
-x86_64-mm-add-smp-support-on-i386-to-reservation-framework.patch
-x86_64-mm-cleanup-nmi-interrupt-path.patch
-x86_64-mm-tif-restore-sigmask.patch
-x86_64-mm-add-ppoll-pselect.patch
-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions.patch
-x86_64-mm-add-abilty-to-enable-disable-nmi-watchdog-from-sysfs.patch
-x86_64-mm-add-abilty-to-enable-disable-nmi-watchdog-from-procfs-update.patch
-x86_64-mm-allow-users-to-force-a-panic-on-nmi.patch
-x86_64-mm-x86-clean-up-nmi-panic-messages.patch
-x86_64-mm-x86-nmi-watchdog-suspend.patch
-x86_64-mm-unknown-nmi-panic.patch
-x86_64-mm-make-functions-static.patch
-x86_64-mm-kdump-x86_64-nmi-event-notification-fix.patch
-x86_64-mm-kdump-i386-nmi-event-notification-fix.patch
-x86_64-mm-i386-enable-nmi-wdog.patch
-x86_64-mm-add-nmi-watchdog-support-for-new-intel-cpus.patch
-x86_64-mm-rdtscp-macros.patch
-x86_64-mm-init-rdtscp.patch
-x86_64-mm-getcpu-vsyscall.patch
-x86_64-mm-generic-getcpu-syscall.patch
-x86_64-mm-no-asm-smp.patch
-x86_64-mm-tif-flags-for-debug-regs-and-io-bitmap-in-ctxsw.patch
-x86_64-mm-hpet-cosmetics.patch
-x86_64-mm-a-few-trivial-spelling-and-grammar-fixes.patch
-x86_64-mm-randomize-check.patch
-x86_64-mm-i386-profile-pc.patch
-x86_64-mm-simplify-profile-pc.patch
-x86_64-mm-backtracer-docs.patch
-x86_64-mm-asm-alternative.patch
-x86_64-mm-rwlock-to-asm.patch
-x86_64-mm-i386-remove-const-rwlock.patch
-x86_64-mm-fix-align.patch
-x86_64-mm-i386-asm-alternative.patch
-x86_64-mm-i386-semaphore-to-asm.patch
-x86_64-mm-remove-thunk-cvs-id.patch
-x86_64-mm-tce-comment.patch
-x86_64-mm-remove-apic-ifdefs.patch
-x86_64-mm-remove-apic-mismatch.patch
-x86_64-mm-remove-focus-disabled-workaround.patch
-x86_64-mm-tlb-flush-cleanup.patch
-x86_64-mm-i386-tlbflush-fixes.patch
-x86_64-mm-entry-comments.patch
-x86_64-mm-remove-pirq.patch
-x86_64-mm-remove-mca-eisa.patch
-x86_64-mm-remove-pic-mode.patch
-x86_64-mm-remove-mpparse-checks.patch
-x86_64-mm-io-apic-access.patch
-x86_64-mm-i386-io-apic-access.patch
-x86_64-mm-aux_device_info-is-one-byte-long,-use-movb.patch
-x86_64-mm-remove-apic-renumbering.patch
-x86_64-mm-quirks-own-file.patch
-x86_64-mm-mp-bus-type-bitmap.patch
-x86_64-mm-remove-mpparse-wrapper.patch
-x86_64-mm-remove-acpi-externs-in-mpparse.patch
-x86_64-mm-mpparse-acpi-style.patch
-x86_64-mm-i386-mpparse-acpi-style.patch
-x86_64-mm-apic-build-bug-on.patch
-x86_64-mm-detect-cfi.patch
-x86_64-mm-kernel-asm-remove-cvs-id.patch
-x86_64-mm-initialize-end-of-memory-variables-as-early-as.patch
-x86_64-mm-remove-int_delivery_dest.patch
-x86_64-mm-i386-end-of-memory.patch
-x86_64-mm-kernel-stack-doc.patch
-x86_64-mm-calgary-rearrange-struct-iommu_table.patch
-x86_64-mm-calgary-consolidate-per-bus-data.patch
-x86_64-mm-calgary-break-out-of.patch
-x86_64-mm-calgary-fix-error-path-memleak-in.patch
-x86_64-mm-calgary-fix-reference-counting-of.patch
-x86_64-mm-calgary-init-one.patch
-x86_64-mm-calgary-save-a-bit-of-space-in-bus_info.patch
-x86_64-mm-i386-remove-lock-section.patch
-x86_64-mm-remove-lock-section.patch
-x86_64-mm-fix-is_at_popf-for-compat-tasks.patch
-x86_64-mm-spinlock-cleanup.patch
-x86_64-mm-i386-spinlock-cleanup.patch
-x86_64-mm-annotate-lib.patch
-x86_64-mm-fix-gdt-table-size-in-trampoline.s.patch
-x86_64-mm-remove-superflous-bug_ons-in-nommu-and-gart.patch
-x86_64-mm-remove-lock-prefix-from-is_at_popf-tests.patch
-x86_64-mm-early-cpu-identify.patch
-x86_64-mm-allow-early_param-and-identical-__setup-to-exist.patch
-x86_64-mm-i386-early-param.patch
-x86_64-mm-early-param.patch
-x86_64-mm-remove-early-lockdep.patch
-x86_64-mm-move-acpi-disabled.patch
-x86_64-mm-move-acpi-numa.patch
-x86_64-mm-move-e820map.patch
-x86_64-mm-vsyscall-sparse.patch
-x86_64-mm-fault-sparse.patch
-x86_64-mm-sys_ia32-sparse.patch
-x86_64-mm-aout-sparse.patch
-x86_64-mm-replace-local_save_flags+local_irq_disable-with.patch
-x86_64-mm-acpi-remove-extern.patch
-x86_64-mm-tf-iret.patch
-x86_64-mm-print-whether-config_iommu_debug-is.patch
-x86_64-mm-only-verify-the-allocation-bitmap-if.patch
-x86_64-mm-remove-tce_cache_blast_stress.patch
-x86_64-mm-eradicate-sole-remaining-80-chars.patch
-x86_64-mm-stacktrace-cleanup.patch
-x86_64-mm-lockdep-stacktrace-no-recursion.patch
-x86_64-mm-early-safe-smp-processor-id.patch
-x86_64-mm-early-unwind-init.patch
-x86_64-mm-stacktrace-unwinder.patch
-x86_64-mm-stacktrace-terminate.patch
-x86_64-mm-i386-stacktrace-unwinder.patch
-x86_64-mm-i386-stacktrace-terminate.patch
-x86_64-mm-i386-backtrace-ebp-fallback.patch
-x86_64-mm-lockdep-dont-force-framepointer.patch
-x86_64-mm-fix-dubious-segment-register-clear-in-cpu_init.patch
-x86_64-mm-dont-taint-up-k7s-running-smp-kernels..patch
-x86_64-mm-kprobes-error_code.patch
-x86_64-mm-monotonic-clock.patch
-x86_64-mm-improve-crash-dump-description.patch
-x86_64-mm-boot-param-bss.patch
-x86_64-mm-i386-fix-mpparse-warning.patch
-x86_64-mm-fault-notifier-export.patch
-x86_64-mm-i386-fault-notifier-export.patch
-x86_64-mm-i386-acpi_force-static.patch
-x86_64-mm-i386-enable_local_apic-static.patch
-x86_64-mm-i386-kernel-thread.patch
-x86_64-mm-i386-desc-cleanup.patch
-x86_64-mm-per-cpu-area-size.patch
-x86_64-mm-i386-topology-cleanup.patch
-x86_64-mm-i386-more-init.patch
-x86_64-mm-fix-bus-numbering-format-in-mmconfig-warning.patch
-x86_64-mm-support-physical-cpu-hotplug-for-x86_64.patch
-x86_64-mm-less-lazy-fpu.patch
-x86_64-mm-wire-up-oops_enter-oops_exit.patch
-x86_64-mm-add-mem-fix.patch
-x86_64-mm-remove-redundant-generic_identify-calls-when-identifying-cpus.patch
-x86_64-mm-mark-init_amd-as-__cpuinit.patch
-x86_64-mm-mark-cpu_dev-structures-as-__cpuinitdata.patch
-x86_64-mm-mark-cpu-init-functions-as-__cpuinit,-data-as-__cpuinitdata.patch
-x86_64-mm-mark-cpu-identify-functions-as-__cpuinit.patch
-x86_64-mm-mark-cpu-cache-functions-as-__cpuinit.patch
-x86_64-mm-i386-kprobes-mca.patch
-x86_64-mm-i386-kprobes-nmi.patch
-x86_64-mm-remove-config.h-includes-from-asm-i386-asm-x86_64.patch
-x86_64-mm-drop-640k-reservation.patch
-x86_64-mm-move-compiler-check-to-ia64.patch
-x86_64-mm-make-numa_emulation-__init.patch
-x86_64-mm-i386-cfi-nmi.patch
-x86_64-mm-detect-clock-skew-during-suspend.patch
-x86_64-mm-remove-safe_smp_processor_id.patch
-x86_64-mm-early_ioremap-warning.patch
-x86_64-mm-pte-exec.patch
-x86_64-mm-cpa-pse-cleanup.patch
-x86_64-mm-remove-apic-version-capability.patch
-x86_64-mm-cleanup-apic-id-checking.patch
-x86_64-mm-mpparse-style.patch
-x86_64-mm-nmi-irqtrace-check.patch
-x86_64-mm-fix-head.S-warning.patch
-x86_64-mm-remove-e820-fallback.patch
-x86_64-mm-optimize-hweight64-for-x86_64.patch
-x86_64-mm-reload-cs-in-head.patch
-x86_64-mm-note-section.patch
-x86_64-mm-e820-comment.patch
-x86_64-mm-proxy-pda.patch
-x86_64-mm-fix-the-edd-code-misparsing-the-command-line.patch
-x86_64-mm-remove-most-of-the-special-cases-for-the-debug-ist-stack.patch
-x86_64-mm-kexec-dont-overwrite-pgd.patch
-x86_64-mm-i386-kexec-dont-overwrite-pgd.patch
-x86_64-mm-trace-kernel-text-address.patch
-x86_64-mm-document-tree.patch
-x86_64-mm-stack-protector-annotate-the-pda-offsets.patch
-x86_64-mm-stack-protector-add-the-kconfig-option.patch
-x86_64-mm-stack-protector-add-canary.patch
-x86_64-mm-stack-protector-add_stack_chk_fail.patch
-x86_64-mm-stack-protector-cflags.patch
-x86_64-mm-fix-irqcount-comment.patch
-x86_64-mm-pda-use-c-output-modifier.patch
-x86_64-mm-type-checking-for-write_pda.patch
-x86_64-mm-fix-pda-warning.patch
-x86_64-mm-i386-replace-sensitive-instructions.patch
-x86_64-mm-i386-allow-a-kernel-to-not-be-in-ring0.patch
-x86_64-mm-i386-pda-asm-offsets.patch
-x86_64-mm-i386-pda-basics.patch
-x86_64-mm-i386-pda-init-pda.patch
-x86_64-mm-i386-pda-use-gs.patch
-x86_64-mm-i386-pda-user-abi.patch
-x86_64-mm-i386-pda-vm86.patch
-x86_64-mm-i386-pda-smp-processorid.patch
-x86_64-mm-i386-pda-current.patch
-x86_64-mm-i386-early-fault.patch
-x86_64-mm-insert-ioapics-and-local-apic-into-resource-map.patch
-x86_64-mm-acpi-add-hpet-into-resource-map.patch
-x86_64-mm-copy-user-zeroing.patch
-x86_64-mm-copy-user-mustcheck.patch
-x86_64-mm-compat-pselect-must-check.patch
-x86_64-mm-compat-uname-must-check.patch
-x86_64-mm-copy-user-style.patch
-x86_64-mm-pda-style.patch
-x86_64-mm-pda-noreturn.patch
-x86_64-mm-remove-mmx.patch
-x86_64-mm-init-per-cpu-data-again.patch
-x86_64-mm-i386-kexec-not-experimental.patch
-x86_64-mm-kexec-not-experimental.patch
-x86_64-mm-fix-idle-notifiers.patch
-x86_64-mm-pci-probe-type1-first.patch
-x86_64-mm-mcfg-type1-heuristic.patch
-x86_64-mm-insert-gart-region-into-resource-map.patch
-x86_64-mm-mcfg-resource.patch
-x86_64-mm-i386-mcfg-resource.patch
-x86_64-mm-i386-pack-descriptor.patch
-x86_64-mm-i386-multiline-oops.patch
-x86_64-mm-restore-i8259a-eoi.patch
-x86_64-mm-core2-rep-good.patch
-x86_64-mm-mmconfig-fix-comment.patch
-x86_64-mm-amd-single-cpu-sync-rdtsc.patch
-x86_64-mm-remove-signal-map.patch
-x86_64-mm-ia32-signal-regparm.patch
-x86_64-mm-ia32-signal-style.patch
-x86_64-mm-unwind-signal-frame-detect.patch
-x86_64-mm-dont-leak-nt.patch
-x86_64-mm-early-scan-depends-on-pci.patch
-x86_64-mm-move-pci-direct-out-of-line.patch
-x86_64-mm-allow-disabling-early-pci-scans.patch
-x86_64-mm-fix-unw-pc-warning.patch
-x86_64-mm-i386-fix-unwind-disabled.patch
-x86_64-mm-add-64bit-jiffies-compares-for-use-with-get_jiffies_64.patch
-x86_64-mm-refactor-thermal-throttle-processing.patch
-x86_64-mm-make-the-jiffies-compares-use-the-64bit-safe-macros..patch
-x86_64-mm-add-a-cumulative-thermal-throttle-event-counter..patch
-fix-x86_64-mm-i386-pda-smp-processorid.patch
-fix-x86_64-mm-spinlock-cleanup.patch
-mm-vm_bug_on.patch
-mm-tracking-shared-dirty-pages.patch
-mm-tracking-shared-dirty-pages-nommu-fix-2.patch
-mm-balance-dirty-pages.patch
-mm-optimize-the-new-mprotect-code-a-bit.patch
-mm-small-cleanup-of-install_page.patch
-mm-fixup-do_wp_page.patch
-mm-msync-cleanup.patch
-mm-tracking-shared-dirty-pages-checks.patch
-mm-tracking-shared-dirty-pages-wimp.patch
-mm-make-functions-static.patch
-convert-i386-numa-kva-space-to-bootmem.patch
-convert-i386-numa-kva-space-to-bootmem-tidy.patch
-bootmem-remove-useless-__init-in-header-file.patch
-bootmem-mark-link_bootmem-as-part-of-the-__init-section.patch
-bootmem-remove-useless-parentheses-in-bootmem-header.patch
-bootmem-limit-to-80-columns-width.patch
-bootmem-remove-useless-headers-inclusions.patch
-bootmem-use-pfn-page-conversion-macros.patch
-bootmem-miscellaneous-coding-style-fixes.patch
-reduce-max_nr_zones-remove-two-strange-uses-of-max_nr_zones.patch
-reduce-max_nr_zones-fix-max_nr_zones-array-initializations.patch
-reduce-max_nr_zones-make-display-of-highmem-counters-conditional-on-config_highmem.patch
-reduce-max_nr_zones-make-display-of-highmem-counters-conditional-on-config_highmem-tidy.patch
-reduce-max_nr_zones-move-highmem-counters-into-highmemc-h.patch
-reduce-max_nr_zones-move-highmem-counters-into-highmemc-h-fix.patch
-reduce-max_nr_zones-page-allocator-zone_highmem-cleanup.patch
-reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment.patch
-reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-cleanup.patch
-reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-fix.patch
-reduce-max_nr_zones-make-zone_dma32-optional.patch
-reduce-max_nr_zones-make-zone_highmem-optional.patch
-reduce-max_nr_zones-make-zone_highmem-optional-fix.patch
-reduce-max_nr_zones-make-zone_highmem-optional-fix-fix.patch
-reduce-max_nr_zones-make-zone_highmem-optional-fix-fix-fix.patch
-reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones.patch
-reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones-s390-fix.patch
-reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones-s390-fix-fix.patch
-reduce-max_nr_zones-fix-i386-srat-check-for-max_nr_zones.patch
-mempolicies-fix-policy_zone-check.patch
-apply-type-enum-zone_type.patch
-apply-type-enum-zone_type-fix.patch
-linearly-index-zone-node_zonelists.patch
-out-of-memory-notifier.patch
-out-of-memory-notifier-tidy.patch
-cpu-hotplug-compatible-alloc_percpu.patch
-cpu-hotplug-compatible-alloc_percpu-fix.patch
-cpu-hotplug-compatible-alloc_percpu-fix-2.patch
-add-kerneldocs-for-some-functions-in-mm-memoryc.patch
-mm-remove_mapping-safeness.patch
-mm-remove_mapping-safeness-fix.patch
-mm-non-syncing-lock_page.patch
-slab-respect-architecture-and-caller-mandated-alignment.patch
-mm-swap-write-failure-fixup.patch
-mm-swap-write-failure-fixup-update.patch
-mm-swap-write-failure-fixup-fix.patch
-oom-use-unreclaimable-info.patch
-oom-reclaim_mapped-on-oom.patch
-oom-cpuset-hint.patch
-oom-handle-current-exiting.patch
-oom-handle-oom_disable-exiting.patch
-oom-swapoff-tasks-tweak.patch
-oom-kthread-infinite-loop-fix.patch
-oom-more-printk.patch
-bootmem-use-max_dma_address-instead-of-low32limit.patch
-add-some-comments-to-slabc.patch
-update-some-mm-comments.patch
-slab-optimize-kmalloc_node-the-same-way-as-kmalloc.patch
-slab-optimize-kmalloc_node-the-same-way-as-kmalloc-fix.patch
-slab-extract-__kmem_cache_destroy-from-kmem_cache_destroy.patch
-slab-do-not-panic-when-alloc_kmemlist-fails-and-slab-is-up.patch
-slab-fix-lockdep-warnings.patch
-slab-fix-lockdep-warnings-fix.patch
-slab-fix-lockdep-warnings-fix-2.patch
-add-__gfp_thisnode-to-avoid-fallback-to-other-nodes-and-ignore.patch
-add-__gfp_thisnode-to-avoid-fallback-to-other-nodes-and-ignore-fix.patch
-sys_move_pages-do-not-fall-back-to-other-nodes.patch
-guarantee-that-the-uncached-allocator-gets-pages-on-the-correct.patch
-cleanup-add-zone-pointer-to-get_page_from_freelist.patch
-profiling-require-buffer-allocation-on-the-correct-node.patch
-define-easier-to-handle-gfp_thisnode.patch
-standardize-pxx_page-macros.patch
-standardize-pxx_page-macros-fix.patch
-optimize-free_one_page.patch
-do-not-check-unpopulated-zones-for-draining-and-counter.patch
-extract-the-allocpercpu-functions-from-the-slab-allocator.patch
-introduce-mechanism-for-registering-active-regions-of-memory.patch
-have-power-use-add_active_range-and-free_area_init_nodes.patch
-have-power-use-add_active_range-and-free_area_init_nodes-ppc-fix.patch
-have-x86-use-add_active_range-and-free_area_init_nodes.patch
-have-x86-use-add_active_range-and-free_area_init_nodes-fix.patch
-have-x86_64-use-add_active_range-and-free_area_init_nodes.patch
-have-ia64-use-add_active_range-and-free_area_init_nodes.patch
-have-ia64-use-add_active_range-and-free_area_init_nodes-fix.patch
-account-for-memmap-and-optionally-the-kernel-image-as-holes.patch
-account-for-memmap-and-optionally-the-kernel-image-as-holes-fix.patch
-account-for-holes-that-are-outside-the-range-of-physical-memory.patch
-allow-an-arch-to-expand-node-boundaries.patch
-replace-min_unmapped_ratio-by-min_unmapped_pages-in-struct-zone.patch
-zvc-support-nr_slab_reclaimable--nr_slab_unreclaimable.patch
-zone_reclaim-dynamic-slab-reclaim.patch
-zone_reclaim-dynamic-slab-reclaim-tidy.patch
-zone-reclaim-with-slab-avoid-unecessary-off-node-allocations.patch
-oom-kill-update-comments-to-reflect-current-code.patch
-hugepages-use-page_to_nid-rather-than-traversing-zone-pointers.patch
-numa-add-zone_to_nid-function.patch
-numa-add-zone_to_nid-function-update.patch
-vm-add-per-zone-writeout-counter.patch
-own-header-file-for-struct-page.patch
-page-invalidation-cleanup.patch
-slab-fix-kmalloc_node-applying-memory-policies-if-nodeid-==-numa_node_id.patch
-slab-fix-kmalloc_node-applying-memory-policies-if-nodeid-==-numa_node_id-fix.patch
-condense-output-of-show_free_areas.patch
-add-numa_build-definition-in-kernelh-to-avoid-ifdef.patch
-disable-gfp_thisnode-in-the-non-numa-case.patch
-gfp_thisnode-for-the-slab-allocator-v2.patch
-gfp_thisnode-for-the-slab-allocator-v2-fix.patch
-gfp_thisnode-for-the-slab-allocator-v2-fix-3.patch
-add-node-to-zone-for-the-numa-case.patch
-add-node-to-zone-for-the-numa-case-fix.patch
-do-not-allocate-pagesets-for-unpopulated-zones.patch
-zone_statistics-use-hot-node-instead-of-cold-zone_pgdat.patch
-do_no_pfn.patch
-do_no_pfn-tweaks.patch
-mspec-driver.patch
-shared-page-table-for-hugetlb-page-v2.patch
-shared-page-table-for-hugetlb-page-v2-tidy.patch
-shared-page-table-for-hugetlb-page-v2-comments.patch
-selinux-eliminate-selinux_task_ctxid.patch
-selinux-rename-selinux_ctxid_to_string.patch
-selinux-replace-ctxid-with-sid-in.patch
-selinux-enable-configuration-of-max-policy-version.patch
-selinux-enable-configuration-of-max-policy-version-improve-security_selinux_policydb_version_max_value-help-texts.patch
-selinux-add-support-for-range-transitions-on-object.patch
-selinux-1-3-eliminate-inode_security_set_security.patch
-selinux-2-3-change-isec-semaphore-to-a-mutex.patch
-selinux-3-3-convert-sbsec-semaphore-to-a-mutex.patch
-selinux-fix-tty-locking.patch
-binfmt_elf-consistently-use-loff_t.patch
-frv-use-the-generic-irq-stuff.patch
-frv-improve-frvs-use-of-generic-irq-handling.patch
-frv-permit-__do_irq-to-be-dispensed-with.patch
-frv-fix-fls-to-handle-bit-31-being-set-correctly.patch
-frv-implement-fls64.patch
-frv-optimise-ffs.patch
-alchemy-delete-unused-pt_regs-argument-from-au1xxx_dbdma_chan_alloc.patch
-avr32-arch.patch
-avr32-config_debug_bugverbose-and-config_frame_pointer.patch
-avr32-fix-invalid-constraints-for-stcond.patch
-avr32-add-support-for-irq-flags-state-tracing.patch
-avr32-turn-off-support-for-discontigmem-and-sparsemem.patch
-avr32-always-enable-config_embedded.patch
-avr32-export-the-find__bit-functions.patch
-avr32-add-defconfig-for-at32stk1002.patch
-avr32-use-autoconf-instead-of-marker.patch
-avr32-dont-assume-anything-about-max_nr_zones.patch
-avr32-add-i-o-port-access-primitives.patch
-avr32-use-linux-pfnh.patch
-avr32-kill-config_discontigmem-support-completely.patch
-avr32-fix-bug-in-__avr32_asr64.patch
-avr32-switch-to-generic-timekeeping-framework.patch
-avr32-set-kbuild_defconfig.patch
-avr32-kprobes-compile-fix.patch
-avr32-asm-ioh-should-include-asm-byteorderh.patch
-avr32-fix-output-constraints-in-asm-bitopsh.patch
-avr32-standardize-pxx_page-macros-fix.patch
-avr32-rename-at32stk100x-atstk100x.patch
-avr32-dont-leave-dbe-set-when-resetting-cpu.patch
-avr32-make-prot_write-prot_exec-imply-prot_read.patch
-avr32-remove-set_wmb.patch
-avr32-use-parse_early_param.patch
-avr32-fix-exported-headers.patch
-avr32-fix-__const_udelay-overflow-bug.patch
-remove-zone_dma-remains-from-avr32.patch
-avr32-mtd-static-memory-controller-driver-try-2.patch
-avr32-mtd-at49bv6416-platform-device-for-atstk1000.patch
-nommu-check-that-access_process_vm-has-a-valid-target.patch
-nommu-set-bdi-capabilities-for-dev-mem-and-dev-kmem.patch
-nommu-set-bdi-capabilities-for-dev-mem-and-dev-kmem-tidy.patch
-nommu-use-find_vma-rather-than-reimplementing-a-vma-search.patch
-check-if-start-address-is-in-vma-region-in-nommu-function-get_user_pages.patch
-nommu-check-vma-protections.patch
-nommu-permit-ptrace-to-ignore-non-prot_write-vmas-in-nommu-mode.patch
-nommu-implement-proc-pid-maps-for-nommu.patch
-nommu-order-the-per-mm_struct-vma-list.patch
-nommu-make-mremap-partially-work-for-nommu-kernels.patch
-nommu-add-docs-about-shared-memory.patch
-nommu-make-futexes-work-under-nommu-conditions.patch
-nommu-make-futexes-work-under-nommu-conditions-doc.patch
-nommu-move-the-fallback-arch_vma_name-to-a-sensible-place.patch
-nommu-move-the-fallback-arch_vma_name-to-a-sensible-place-fix.patch
-hpet-rtc-emulation-add-watchdog-timer-2.patch
-i386-show_registers-try-harder-to-print-failing.patch
-use-bug_onfoo-instead-of-if-foo-bug-in-include-asm-i386-dma-mappingh.patch
-apm-clean-up-module-initalization.patch
-x86-remove-locally-defined-ldt-structure-in-favour-of-standard-type.patch
-x86-implement-always-locked-bit-ops-for-memory-shared-with-an-smp-hypervisor.patch
-x86-roll-all-the-cpuid-asm-into-one-__cpuid-call.patch
-x86-make-__fixaddr_top-variable-to-allow-it-to-make-space-for-a-hypervisor.patch
-x86-add-a-bootparameter-to-reserve-high-linear-address-space.patch
-x86-put-note-sections-into-a-pt_note-segment-in-vmlinux.patch
-x86-put-note-sections-into-a-pt_note-segment-in-vmlinux-fix.patch
-x86-enable-vmsplit-for-highmem-kernels.patch
-x86-trivial-pgtableh-__assembly__-move.patch
-x86-trivial-move-of-__have-macros-in-i386-pagetable-headers.patch
-x86-trivial-move-of-ptep_set_access_flags.patch
-x86-remove-unused-include-from-efi_stubs.patch
-i386-adds-smp_call_function_single.patch
-voyager-tty-locking.patch
-i386-kill-references-to-xtime.patch
-mtrr-add-lock-annotations-for-prepare_set-and.patch
-i386-adds-smp_call_function_single-fix.patch
-alpha-fix-alpha_ev56-dependencies-typo.patch
-swsusp-write-timer.patch
-swsusp-write-speedup.patch
-swsusp-read-timer.patch
-swsusp-read-speedup.patch
-swsusp-read-speedup-fix.patch
-swsusp-read-speedup-cleanup.patch
-swsusp-read-speedup-cleanup-2.patch
-swsusp-read-speedup-fix-fix-2.patch
-swsusp-clean-up-browsing-of-pfns.patch
-swsusp-struct-snapshot_handle-cleanup.patch
-make-swsusp-avoid-memory-holes-and-reserved-memory-regions-on-x86_64.patch
-disable-cpu-hotplug-during-suspend-2.patch
-swsusp-fix-mark_free_pages.patch
-swsusp-reorder-memory-allocating-functions.patch
-swsusp-fix-alloc_pagedir.patch
-clean-up-suspend-header.patch
-change-the-name-of-pagedir_nosave.patch
-swsusp-introduce-some-helpful-constants.patch
-swsusp-introduce-memory-bitmaps.patch
-swsusp-use-memory-bitmaps-during-resume.patch
-swsusp-use-memory-bitmaps-during-resume-fix.patch
-pm-make-it-possible-to-disable-console-suspending.patch
-pm-make-it-possible-to-disable-console-suspending-fix.patch
-pm-make-it-possible-to-disable-console-suspending-fix-2.patch
-make-it-possible-to-disable-serial-console-suspend.patch
-i386-detect-clock-skew-during-suspend.patch
-pm-add-pm_trace-switch.patch
-pm-add-pm_trace-switch-doc.patch
-m32r-fix-make-headers_check.patch
-uml-use-klibc-setjmp-longjmp.patch
-uml-use-array_size-more-assiduously.patch
-uml-fix-stack-alignment.patch
-uml-whitespace-fixes.patch
-uml-fix-handling-of-failed-execs-of-helpers.patch
-uml-improve-sigbus-diagnostics.patch
-uml-sigio-cleanups.patch
-uml-move-signal-handlers-to-arch-code.patch
-uml-move-signal-handlers-to-arch-code-fix.patch
-uml-timer-cleanups.patch
-uml-remove-unused-variable.patch
-uml-clean-our-set_ether_mac.patch
-uml-stack-usage-reduction.patch
-uml-tty-locking.patch
-split-i386-and-x86_64-ptraceh.patch
-split-i386-and-x86_64-ptraceh-fix.patch
-make-uml-use-ptrace-abih.patch
-uml-use-mcmodel=kernel-for-x86_64.patch
-uml-fix-proc-vs-interrupt-context-spinlock-deadlock.patch
-s390-fix-cmm-kernel-thread-handling.patch
-autofs4-needs-to-force-fail-return-revalidate.patch
-kdump-introduce-reset_devices-command-line-option.patch
-fat-cleanup-fat_get_blocks.patch
-inode_diet-replace-inodeugeneric_ip-with-inodei_private.patch
-inode_diet-replace-inodeugeneric_ip-with-inodei_private-gfs-fix.patch
-inode-diet-move-i_pipe-into-a-union.patch
-inode-diet-move-i_bdev-into-a-union.patch
-inode-diet-move-i_cdev-into-a-union.patch
-inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default.patch
-inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-fix.patch
-inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-fix-fix.patch
-inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-xfs-fix.patch
-reiserfs-warn-about-the-useless-nolargeio-option.patch
-x86-microcode-microcode-driver-cleanup.patch
-x86-microcode-microcode-driver-cleanup-tidy.patch
-x86-microcode-using-request_firmware-to-pull-microcode.patch
-x86-microcode-add-sysfs-and-hotplug-support.patch
-x86-microcode-add-sysfs-and-hotplug-support-fix.patch
-x86-microcode-add-sysfs-and-hotplug-support-fix-fix-2.patch
-x86-microcode-dont-check-the-size.patch
-consistently-use-max_errno-in-__syscall_return.patch
-consistently-use-max_errno-in-__syscall_return-fix.patch
-eisa-bus-modalias-attributes-support-1.patch
-eisa-bus-modalias-attributes-support-1-fix.patch
-eisa-bus-modalias-attributes-support-1-fix-git-kbuild-fix.patch
-alloc_fdtable-cleanup.patch
-include-__param-section-in-read-only-data-range.patch
-msi-use-kmem_cache_zalloc.patch
-sysctl-allow-proc-sys-without-sys_sysctl.patch
-sysctl-allow-proc-sys-without-sys_sysctl-fix.patch
-sysctl-document-that-sys_sysctl-will-be-removed.patch
-pid-implement-transfer_pid-and-use-it-to-simplify-de_thread.patch
-pid-remove-temporary-debug-code-in-attach_pid.patch
-de_thread-use-tsk-not-current.patch
-add-probe_kernel_address.patch
-x86-use-probe_kernel_address-in-handle_bug.patch
-fs-conversions-from-kmallocmemset-to-kzcalloc.patch
-fs-removing-useless-casts.patch
-jbd-add-lock-annotation-to-jbd_sync_bh.patch
-ext3-and-jbd-cleanup-remove-whitespace.patch
-ext3-turn-on-reservation-dump-on-block-allocation-errors.patch
-ext3-add-more-comments-in-block-allocation-reservation-code.patch
-jbd-use-build_bug_on-in-journal-init.patch
-fix-ext3-mounts-at-16t.patch
-fix-ext3-mounts-at-16t-fix.patch
-fix-ext2-mounts-at-16t.patch
-fix-ext2-mounts-at-16t-fix.patch
-more-ext3-16t-overflow-fixes.patch
-more-ext3-16t-overflow-fixes-fix.patch
-ext3-inode-numbers-are-unsigned-long.patch
-ext3-inode-numbers-are-unsigned-long-fix.patch
-really-ignore-kmem_cache_destroy-return-value.patch
-make-kmem_cache_destroy-return-void.patch
-ibm-acpi-documentation-delete-irrelevant-how-to-compile-external-module.patch
-ext3-wrong-error-behavior.patch
-ext3-more-whitespace-cleanups.patch
-ext3-fix-sparse-warnings.patch
-jbd-16t-fixes.patch
-dontdiff-add-utsreleaseh.patch

 Merged into mainline or a subsystem tree.

+acpi-preserve-correct-battery-state-through-suspend-resume-cycles.patch
+acpi-preserve-correct-battery-state-through-suspend-resume-cycles-tidy.patch

 ACPI fix.

+driver-core-fixes-check-for-return-value-of-sysfs_create_link.patch

 More __must_check fixes

+fix-gregkh-driver-nozomi.patch

 Fix nozomi driver a bit.

-git-dvb-fixup.patch

 Dropped.

+drivers-media-use-null-instead-of-0-for-ptrs.patch

 Cleanup

-git-gfs2-fixup.patch

 Dropped.

+inode_diet-replace-inodeugeneric_ip-with-inodei_private-gfs2.patch
+inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-gfs2.patch

 GFS2 fixes

+possible-dereference-in.patch

 Input possible-oops fix

+drivers-input-misc-added-acer-travelmate-2424nwxci-support-to-the-wistron-button-interface.patch

 Add new machine to Wistron driver.

-libata-add-40pin-short-cable-support-honour-drive-fix.patch

 Folded into libata-add-40pin-short-cable-support-honour-drive.patch

-via-pata-controller-xfer-fixes-fix.patch

 Folded into via-pata-controller-xfer-fixes.patch

-mmc-driver-for-ti-flashmedia-card-reader-source-tidy.patch
-mmc-driver-for-ti-flashmedia-card-reader-source-alpha-fix.patch
-mmc-driver-for-ti-flashmedia-card-reader-source-vs-git-mmc.patch

 Folded into mmc-driver-for-ti-flashmedia-card-reader-source.patch

+git-mtd-fixup.patch

 Fix rejects in git-mtd.patch

-git-netdev-all-fixup.patch

 Dropped.

+forcedeth-power-management-support.patch
+forcedeth-power-management-support-tidy.patch
+remove-unnecessary-check-in-drivers-net-depcac.patch

 netdev updates

+nfs-kill-obsolete-nfs_paranoia.patch

 NFS cleanup

-revert-allow-file-systems-to-manually-d_move-inside-of-rename.patch

 Dropped.

+off-by-one-in-arch-ppc-platforms-mpc8.patch
+ehea-firmware-interface-based-on-anton-blanchards-new-hvcall-interface.patch

 ppc fixes

-tickle-nmi-watchdog-on-serial-output-fix.patch

 Folded into tickle-nmi-watchdog-on-serial-output.patch

+remove-unnecessary-check-in.patch
+pci-turn-pci_fixup_video-into-generic-for-embedded.patch
+pcie_portdrv_restore_config-undefined-without-config_pm.patch

 PCI fixes

+remove-unnecessary-check-in-drivers-scsi-sgc.patch
+remove-extra-newline-from-info-message.patch
+fix-scsi-scsi_transporth-compile-error.patch
+overrun-in-drivers-scsi-scsic.patch
+megaraid-check-for-firmware-version.patch

 SCSI fixes

+scsi-target-needs-pci.patch

 Fix git-scsi-target.patch

+fix-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure-2.patch
+usb-hubc-build-fix.patch
+usb-serial-possible-irq-lock-inversion-ppp-vs.patch
+usb-allow-both-root-hub-interrupts-and-polling.patch
+ohci-remove-existing-autosuspend-code.patch
+ohci-add-auto-stop-support.patch
+ohci-add-auto-stop-support-hack-hack.patch
+pegasus-driver-failing-for-admtek-8515-network-device.patch

 USB fixes

+x86_64-mm-copy-user-inatomic.patch
+x86_64-mm-allow-disabling-dac.patch
+x86_64-mm-iommu-setup-style.patch
+x86_64-mm-document-iommu-panic.patch
+x86_64-mm-unify-ioapic-checking.patch
+x86_64-mm-nmi-sysctl-cleanup.patch
+x86_64-mm-i386-setup-array-size.patch
+x86_64-mm-setup-array-size.patch
+x86_64-mm-i386-mmconfig-flush.patch
+x86_64-mm-re-positioning-the-bss-segment.patch
+x86_64-mm-vsyscall-blob-header.patch
+x86_64-mm-sem-early-clobber.patch

 x86 tree updates

-revert-x86_64-mm-i386-remove-lock-section.patch

 Dropped

-revert-x86_64-mm-i386-pda-current.patch
-revert-x86_64-mm-i386-pda-smp-processorid.patch
-revert-x86_64-mm-i386-pda-vm86.patch
-revert-x86_64-mm-i386-pda-user-abi.patch
-revert-x86_64-mm-i386-pda-use-gs.patch
-revert-x86_64-mm-i386-pda-init-pda.patch

 Dropped.

-hot-add-mem-x86_64-memory_add_physaddr_to_nid-node-fixup-fix.patch
-hot-add-mem-x86_64-memory_add_physaddr_to_nid-node-fixup-fix-2.patch

 Folded into hot-add-mem-x86_64-memory_add_physaddr_to_nid-node-fixup.patch

-hot-add-mem-x86_64-use-config_memory_hotplug_reserve-fix.patch

 Folded into hot-add-mem-x86_64-use-config_memory_hotplug_reserve.patch

+arch-i386-pci-mmconfigc-tlb-flush-fix-tweaks.patch

 x86 fix

+deal-with-cases-of-zone_dma-meaning-the-first-zone-fix.patch

 Fix deal-with-cases-of-zone_dma-meaning-the-first-zone.patch

-redo-radix-tree-fixes.patch
-adix-tree-rcu-lockless-readside-update.patch
-radix-tree-rcu-lockless-readside-semicolon.patch
-adix-tree-rcu-lockless-readside-update-tidy.patch
-adix-tree-rcu-lockless-readside-fix-2.patch
-adix-tree-rcu-lockless-readside-fix-3.patch
-radix-tree-cleanup-radix_tree_deref_slot-and.patch
-cleanup-radix_tree_derefreplace_slot-calling-conventions.patch
-cleanup-radix_tree_derefreplace_slot-calling-conventions-warning-fixes.patch

 Folded into radix-tree-rcu-lockless-readside.patch

+mm-fix-a-race-condition-under-smc-cow.patch

 MM fix

+uswsusp-add-pmops-prepareenterfinish-support-aka-platform-mode.patch
+swsusp-use-partition-device-and-offset-to-identify-swap-areas.patch
+swsusp-rearrange-swap-handling-code.patch
+swsusp-use-block-device-offsets-to-identify-swap-locations-rev-2.patch
+swsusp-add-resume_offset-command-line-parameter-rev-2.patch
+swsusp-add-resume_offset-command-line-parameter-rev-2-fix.patch
+swsusp-document-support-for-swap-files-rev-2.patch
+swsusp-debugging.patch

 swsusp updates

+uml-assign-random-macs-to-interfaces-if-necessary.patch
+uml-mechanical-tidying-after-random-macs-change.patch
+uml-locking-documentation.patch
+uml-close-file-descriptor-leaks.patch
+uml-stack-consumption-reduction.patch

 UML updates

-apple-motion-sensor-driver-2.patch
-apple-motion-sensor-driver-2-fixes-update.patch
-apple-motion-sensor-driver-kconfig-fix.patch
-ams-check-return-values-from-device_create_file.patch

 Dropped - I couldn't keep up with all the changes.

-make-reiserfs-default-to-barrier=flush.patch
-make-ext3-mount-default-to-barrier=1.patch

 Dropped - these slow things down too much.

+remove-sysrq_key-and-related-defines-from-ppc-sh-h8300.patch
+mmc-mainly-add-or-later-clause-to-licence-statement.patch
+prevent-multiple-inclusion-of-linux-sysrqh.patch
+move-ncpfs-32bit-compat-ioctl-to-ncpfs.patch
+ipmi-per-channel-command-registration.patch
+update-legacy-io-handling-for-pmac.patch
+ip2-use-newer-pci_get-functions.patch
+i2o-switch-to-pci_get-api.patch
+cardbus-switch-to-ref-counting-hotplug-safe-api.patch
+epoll_pwait.patch
+sysrq-disable-lockdep-on-reboot.patch
+trident-fix-pci_dev-reference-counting-and-buglet.patch
+off-by-one-in-drivers-char-mwave-mwaveddc.patch
+hdaps-support-lenovo-thinkpad-t60.patch
+typo-fixes-for-rt-mutex-designtxt.patch
+remove-bug_onunlikely-in-include-linux-aioh.patch

 Misc fixes and updates

+csa-accounting-taskstats-update-update-comments-in-linux-taskstatsh.patch

 Fix CSA accouting patches in -mm.

+char-mxser_new-correct-include-file.patch
+char-mxser_new-upgrade-to-191.patch
+char-mxser_new-rework-to-allow-dynamic-structs.patch

 Update the new mxser driver

+kprobe-whitespace-cleanup.patch
+disallow-kprobes-on-notifier_call_chain.patch
+kretprobe-spinlock-deadlock-patch.patch

 kprobes updates

+cpumask-add-highest_possible_node_id-fix.patch

 Fix cpumask-add-highest_possible_node_id.patch

+ecryptfs-file-operations-readdir-fix-for-seeking-in-directory-streams.patch
+ecryptfs-grab-lock-on-lower_page-in-ecryptfs_sync_page.patch

 ecryptfs updates

+reiser4-reiser4_drop_page-dont-call-remove_from_page_cache.patch
+reiser4-get-rid-of-semaphores-wherever-it-is-possible.patch

 reiser4 fixes

+fbdev-correct-buffer-size-limit-in-fbmem_read_proc.patch

 fbdev fix

-genirq-msi-restore-__do_irq-compat-logic-temporarily.patch

 Dropped, unneeded.

+msi-simplify-msi-sanity-checks-by-adding-with-generic-irq-code.patch
+msi-only-use-a-single-irq_chip-for-msi-interrupts.patch
+msi-refactor-and-move-the-msi-irq_chip-into-the-arch-code.patch
+msi-move-the-ia64-code-into-arch-ia64.patch

 MSI updates

+htirq-tidy-up-the-htirq-code.patch

 Update hypertransport driver.



All 1259 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/patch-list 

