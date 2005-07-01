Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263306AbVGALpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263306AbVGALpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 07:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbVGALpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 07:45:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261418AbVGALkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 07:40:52 -0400
Date: Fri, 1 Jul 2005 04:40:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc1-mm1
Message-Id: <20050701044018.281b1ebd.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc1/2.6.13-rc1-mm1/

- The ACPI devel tree is back, and it's huge.  Please report ACPI bugs
  using kernel bugzilla at http://bugme.osdl.org.  If that's all too much
  hassle then please at least cc acpi-devel@lists.sourceforge.net.



Changes since 2.6.12-mm2:


-jffs2-build-fix.patch
-arm-swsusp-build-fix.patch
-remove-redundant-info-from-submittingpatches.patch
-fix-up-macro-abuse-in-drivers-acpi-sleep-procc.patch
-sonypi-make-sure-that-input_work-is-not-running-when-unloading.patch
-samsung-sn-124-works-perfectly-well-with-dma-on-sata-too.patch
-pcnet_csc-irq-handler-optimization.patch
-is_multicast_ether_addr-hack.patch
-pci-yenta-cardbus-fix.patch
-git-scsi-block-fix.patch
-scsi-ahc_target_state-check-starget-valid.patch
-hub-use-kthread.patch
-documentation-networking-dmfetxt-make-documentation-nicer.patch
-use-pci_set_dma_mask-instead-of-direct-assignment-of-dma-mask.patch
-ipvs-close-race-conditions-on-ip_vs_conn_tab-list-modification.patch
-ipvs-close-race-conditions-on-ip_vs_conn_tab-list-modification-fix.patch
-fix-tulip-suspend-resume-2.patch
-3c509-device-support.patch
-dm9000-network-driver-bugfix-2.patch
-cs89x0c-support-for-philips-pnx0105-network-adapter.patch
-dmfe-warning-fix.patch
-defxx-use-irqreturn_t-for-the-interrupt-handler.patch
-fix-int-vs-pm_message_t-confusion-in-airo.patch
-fealnxc-calls-dev_kfree_skb-from-atomic-context-fix-it.patch
-x86-i8253-i8259a-lock-cleanup.patch
-seccomp-tsc-disable.patch
-using-msleep-instead-of-hz.patch
-using-msleep-instead-of-hz-fix.patch
-using-msleep-instead-of-hz-fix-2.patch
-usb-makefile-update-for-sisusbvga.patch
-drivers-char-tiparc-off-by-one-array-access.patch
-ixp4xx-ixp2000-watchdog-driver-typo.patch
-itimer_real-fix-possible-deadlock-and-race.patch
-adapt-drivers-char-vt_ioctlc-to-non-x86.patch
-request_firmware-avoid-race-conditions.patch
-ib-mthca-add-sun-copyright-notice.patch
-ib-mthca-clean-up-error-messages.patch
-ib-mthca-clean-up-cq-debug.patch
-ib-mthca-use-dma_alloc_coherent-instead-of-pci_alloc_consistent.patch
-ib-mthca-set-qp-static-rate-correctly.patch
-ib-mthca-set-rdma-atomic-capabilities-correctly.patch
-ib-mthca-enable-unreliable-connected-transport.patch
-ib-mthca-fix-memset-size.patch
-ib-mthca-move-mthca_is_memfree-checks.patch
-ib-mthca-split-off-mtt-allocation.patch
-ib-mthca-fix-memory-leak-on-error-path.patch
-ib-mthca-encapsulate-command-interface-init.patch
-ib-mthca-align-fw-command-mailboxes-to-4k.patch
-ib-mthca-bump-version.patch
-ib-fix-race-in-sa_query.patch
-ib-fix-pack-unpack-when-size_bits-==-64.patch
-maintainers-update-roland-dreiers-email.patch
-cciss-26-pci-id-fix.patch
-cciss-26-pci-domain-info-pass-2.patch
-cciss-26-remove-partition-info-from-cciss_getluninfo.patch
-cciss-26-remove-partition-info-from-cciss_getluninfo-fix.patch
-headers-enable-ppc64-___arch__swab16-and-___arch__swab32.patch
-headers-include-linux-compilerh-for-__user.patch
-headers-include-linux-typesh-for-usb_ch9h.patch
-coverity-i386-build-negative-return-to-unsigned-fix.patch
-coverity-i386-scsi_lib-buffer-overrun-fix.patch
-coverity-ipmi_msghandler-channels-array-overrun-fix.patch
-coverity-fs-udf-namei-null-check.patch
-coverity-fs-ext3-super-match_int-return-check.patch
-coverity-desc-bitmap-overrun-fix.patch
-coverity-tty_ldisc_ref-return-null-check.patch
-kprobes-fix-single-step-out-of-line-take2.patch
-return-probe-redesign-architecture-independant-changes.patch
-return-probe-redesign-i386-specific-changes.patch
-return-probe-redesign-x86_64-specific-changes.patch
-return-probe-redesign-ia64-specific-implementation.patch
-return-probe-redesign-ppc64-specific-implementation.patch
-kprobes-ia64-refuse-inserting-kprobe-on-slot-1.patch
-kprobes-ia64-refuse-kprobe-on-ivt-code.patch
-cfq-iosched-update-to-time-sliced-design-prep.patch
-cfq-iosched-update-to-time-sliced-design.patch
-cfq-iosched-update-to-time-sliced-design-export-task_nice.patch
-cfq-iosched-update-to-time-sliced-design-fix.patch
-cfq-iosched-update-to-time-sliced-design-fix-fix.patch
-cfq-iosched-update-to-time-sliced-design-use-bio_data_dir.patch
-cfq-iosched-update-to-time-sliced-design-find_next_crq-fix.patch
-cfq-ioschedc-fix-soft-hang-with-non-fs-requests.patch
-cfq-cfq-elevator_insert_back-fix.patch
-cfq-cfq-elevator_insert_back-fix-fix.patch
-cfq-cfq_io_context-leak-fix.patch
-cfq-remove-serveral-unused-fields-from-cfq-data-structures.patch
-blk-__make_request-efficiency.patch
-blk-reduce-locking.patch
-blk-light-iocontext-ops.patch
-blk-fastpath-get_request.patch
-ext3-reduce-allocate-with-reservation-lock-latencies.patch
-pcmcia-hotplug-event-for-pcmcia-devices.patch
-pcmcia-hotplug-event-for-pcmcia-socket-devices.patch
-pcmcia-device-and-driver-matching.patch
-pcmcia-check-for-invalid-crc32-hashes-in-id_tables.patch
-pcmcia-match-for-fake-cis.patch
-pcmcia-export-cis-in-sysfs.patch
-pcmcia-cis-overrid-via-sysfs.patch
-pcmcia-match-anonymous-cards.patch
-pcmcia-allow-function-id-based-match.patch
-pcmcia-file2alias.patch
-pcmcia-request-cis-via-firmware-interface.patch
-pcmcia-cleanups.patch
-pcmcia-rescan-bus-always-upon-echoing-into-setup_done.patch
-pcmcia-id_table-for-serial_cs.patch
-pcmcia-id_table-for-3c574_cs.patch
-pcmcia-id_table-for-3c589_cs.patch
-pcmcia-id_table-for-aha152x.patch
-pcmcia-id_table-for-airo_cs.patch
-pcmcia-id_table-for-axnet_cs.patch
-pcmcia-id_table-for-fdomain_stub.patch
-pcmcia-id_table-for-fmvj18x_cs.patch
-pcmcia-id_table-for-ibmtr_cs.patch
-pcmcia-id_table-for-netwave_cs.patch
-pcmcia-id_table-for-nmclan_cs.patch
-pcmcia-id_table-for-teles_cs.patch
-pcmcia-id_table-for-ray_cs.patch
-pcmcia-id_table-for-wavelan_cs.patch
-pcmcia-id_table-for-sym53c500_csc.patch
-pcmcia-id_table-for-qlogic_stubc.patch
-pcmcia-id_table-for-smc91c92_csc.patch
-pcmcia-id_table-for-orinoco_cs.patch
-pcmcia-id_table-for-xirc2ps_csc.patch
-pcmcia-id_table-for-ide_csc.patch
-pcmcia-id_table-for-ide_csc-update.patch
-pcmcia-id_table-for-parport_csc.patch
-pcmcia-id_table-for-pcnet_csc.patch
-pcmcia-add-a-few-more-ids-for-pcnet_cs.patch
-pcmcia-id_table-for-pcmciamtdc.patch
-pcmcia-id_table-for-vxpocketc.patch
-pcmcia-id_table-for-atmel_csc.patch
-pcmcia-id_table-for-avma1_csc.patch
-pcmcia-id_table-for-avm_csc.patch
-pcmcia-id_table-for-bluecard_csc.patch
-pcmcia-id_table-for-bt3c_csc.patch
-pcmcia-id_table-for-btuart_csc.patch
-pcmcia-id_table-for-com20020_csc.patch
-pcmcia-id_table-for-dtl1_csc.patch
-pcmcia-id_table-for-elsa_csc.patch
-pcmcia-id_table-for-ixj_pcmciac.patch
-pcmcia-id_table-for-nsp_csc.patch
-pcmcia-id_table-for-sedlbauer_csc.patch
-pcmcia-id_table-for-wl3501_csc.patch
-pcmcia-id_table-for-pdaudiocfc.patch
-pcmcia-id_table-for-synclink_csc.patch
-pcmcia-id_table-for-sl811_cs.patch
-pcmcia-more-ids-for-tdk-multifunction-cards.patch
-pcmcia-add-some-documentation.patch
-pcmcia-update-resource-database-adjust-routines-to-use-unsigned-long-values.patch
-pcmcia-mark-parent-bridge-windows-as-resources-available-for-pcmcia-devices.patch
-pcmcia-add-a-config-option-for-the-pcmica-ioctl.patch
-pcmcia-move-pcmcia-ioctl-to-a-separate-file.patch
-pcmcia-clean-up-cs-ds-callback.patch
-pcmcia-make-pcmcia-status-a-bitfield.patch
-pcmcia-merge-struct-pcmcia_bus_socket-into-struct-pcmcia_socket.patch
-pcmcia-remove-unneeded-includes-in-dsc.patch
-pcmcia-rename-some-functions.patch
-pcmcia-move-pcmcia-resource-handling-out-of-csc.patch
-pcmcia-csc-cleanup.patch
-pcmcia-dsc-cleanup.patch
-pcmcia-release_class.patch
-pcmcia-use-request_region-in-i82365.patch
-pcmcia-synclink_cs-irq_info2_info-is-gone.patch
-pcmcia-mod_devicetableh-fix-for-different-sizes-in-kernel-and-userspace.patch
-pcmcia-select-crc32-in-kconfig-for-pcmcia.patch
-pcmcia-resource-handling-fixes.patch
-pcmcia-documentation-fix.patch
-pcmcia-properly-handle-all-errors-of-register_chrdev.patch
-pcmcia-8-and-16-bit-access-for-static_map.patch
-pcmcia-export-modalias-in-sysfs.patch
-irqpoll.patch
-sched-tweak-idle-thread-setup-semantics.patch
-v4l-maintainer-patch.patch
-v4l-tuner-improvements.patch
-v4l-bttv-new-insmod-parameters.patch
-v4l-api-new-webcam-formats-included.patch
-v4l-documentation-changes-mostly-new-cards-included.patch
-ide-fix-ide-disk-inability-to-handle-lba-only-devices.patch
-ide-samsung-sn-124-works-perfectly-well-with-dma.patch
-ide-timing-violation-on-reset.patch
-ide-generic-allow-for-capture-of-other-unsupported-devices.patch
-ide-fix-the-hpt366-driver-layer.patch
-ide-fix-crashes-with-hotplug-serverworks.patch
-ide-it8212-backport-for-bartlomiej-ide.patch
-ide-sensible-probing-for-pci-systems.patch
-doc-submitting-corrections-additions.patch
-drivers-net-skfp-cleanups.patch
-drivers-net-seeq8005c-cleanups.patch
-drivers-net-hamradio-cleanups.patch
-drivers-net-tokenring-cleanups.patch
-drivers-net-skfp-fix-little_endian.patch
-drivers-net-ewrk3c-remove-dead-code.patch

 Merged

+fat-fix-slab-cache-leak-section-fix.patch

 fatfs sectioning fix

+acpi-20050408-2.6.13-rc1.patch

 acpi devel tree

+acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-bug-3549.patch
+acpi-videoc-properly-remove-notify-handlers.patch

 bring back a few ACPI fixes

-alsa-maestro3-div-by-zero-fix.patch

 Unneeded

-gregkh-driver-driver-bus_find_device.patch
-gregkh-driver-driver-unbind.patch
-gregkh-driver-driver-bind.patch
-gregkh-driver-driver-bus_rescan_devices-nocount.patch

 Greg's driver tree is merged up

+git-drm-via-fixup.patch

 Fix a git-drm-via reject

+remove-register_ioctl32_conversion-and-unregister_ioctl32_conversion.patch

 Bring this back

+input-section-fix.patch

 Fix git-input.

+ieee80211_module-build-fixes.patch
+ieee80211_tx-build-fix.patch
+ieee80211_rx-build-fix.patch
+ieee80211_crypt-build-fix.patch
+ieee80211_crypt_ccmp-build-fix.patch
+ieee80211_crypt_wep-build-fix.patch
+ieee80211_crypt_tkip-build-fix.patch

 Make netdev stuff compile.

+ocfs2-avoid-lookup_hash-usage-in-configfs.patch

 ocfs2 API modernisation

-gregkh-pci-pci-pirq_table_addr-out-of-range.patch
-gregkh-pci-pci-get_device-01.patch
-gregkh-pci-pci-get_device-02.patch
-gregkh-pci-pci-acpiphp-02.patch
-gregkh-pci-pci-acpiphp-03.patch
-gregkh-pci-pci-acpiphp-04.patch
-gregkh-pci-pci-acpiphp-05.patch
-gregkh-pci-pci-acpiphp-06.patch
-gregkh-pci-pci-acpiphp-07.patch
-gregkh-pci-pci-acpiphp-08.patch
-gregkh-pci-pci-acpiphp-09.patch
-gregkh-pci-pci-acpiphp-10.patch
-gregkh-pci-pci-acpiphp-11.patch
-gregkh-pci-pci-acpiphp-12.patch
-gregkh-pci-pci-acpiphp-13.patch
-gregkh-pci-pci-acpiphp-14.patch
-gregkh-pci-pci-acpiphp-15.patch
-gregkh-pci-pci-acpiphp-16.patch
-gregkh-pci-pci-acpiphp-17.patch
-gregkh-pci-pci-acpiphp-18.patch
-gregkh-pci-pci-acpiphp-19.patch
-gregkh-pci-pci-acpiphp-20.patch
-gregkh-pci-pci-fix-pci-mmap-on-ppc-and-ppc64.patch
-gregkh-pci-pci-dma-bursting-advice.patch
-gregkh-pci-pci-pci-dma-bursting-advice-fix.patch
-gregkh-pci-pci-msi-cleanup.patch
-gregkh-pci-pci-cpqphp-fix-oops-on-unload.patch
-gregkh-pci-pci-fix-drivers-setting-shutdown.patch
-gregkh-pci-pci-acpi-mcfg-01.patch
-gregkh-pci-pci-acpi-mcfg-02.patch
-gregkh-pci-pci-acpi-mcfg-03.patch

 Greg's PCI tree is partly merged up

+revert-gregkh-pci-pci-collect-host-bridge-resources-02.patch

 Revert broken patch in Greg's PCI tree

+remove-newline-from-pci-modalias-variable.patch

 Fix broken modalias output in sysfs

+mptspi-build-fix.patch

 Make git-scsi-misc compile.

-megaraid_sas-announcing-new-module-for.patch

 Old, doesn't compile any more, dropped.

+dpt_i2o-warning-fix.patch

 Fix a scsi warning

-gregkh-usb-usb-g_file_storage_min.patch
-gregkh-usb-usb-g_file_storage_stall.patch
-gregkh-usb-usb-omap_udc_update.patch
-gregkh-usb-usb-isp116x-hcd-add.patch
-gregkh-usb-usb-isp116x-hcd-fix.patch
-gregkh-usb-usb-turn-a-user-mode-driver-error-into-a-hard-error.patch
-gregkh-usb-usb-uhci-01.patch
-gregkh-usb-usb-uhci-02.patch
-gregkh-usb-usb-uhci-03.patch
-gregkh-usb-usb-uhci-04.patch
-gregkh-usb-usb-uhci-05.patch
-gregkh-usb-usb-uhci-06.patch
-gregkh-usb-usb-uhci-07.patch
-gregkh-usb-usb-uhci-08.patch
-gregkh-usb-usb-root_hub_irq.patch
-gregkh-usb-usb-cdc_acm.patch
-gregkh-usb-usb-usbtest.patch
-gregkh-usb-usb-ohci_reboot_notifier.patch
-gregkh-usb-usb_serial_status.patch
-gregkh-usb-usb-zd1201_pm.patch
-gregkh-usb-usb-zd1201_pm-02.patch
-gregkh-usb-usb-remove_hub_set_power_budget.patch
-gregkh-usb-usb-device_pointer.patch
-gregkh-usb-usb-hcd_fix_for_remove_hub_set_power_budget.patch
-gregkh-usb-usb-usbcore_usb_add_hcd.patch
-gregkh-usb-usb-hcds_no_more_register_root_hub.patch
-gregkh-usb-usb-rndis_cleanups.patch
-gregkh-usb-usb-ethernet_gadget_cleanups.patch
-gregkh-usb-usb-omap_udc_cleanups.patch
-gregkh-usb-usb-dummy_hcd-otg.patch
-gregkh-usb-usb-dummy_hcd-FEAT.patch
-gregkh-usb-usb-dummy_hcd-pdevs.patch
-gregkh-usb-usb-dummy_hcd-centralize-link.patch
-gregkh-usb-usb-dummy_hcd-root-hub_no-polling.patch
-gregkh-usb-usb-idmouse_update.patch
-gregkh-usb-usb-gadget-kconfig.patch
-gregkh-usb-usb-gadget-setup-api-change.patch
-gregkh-usb-usb-gadget-setup-api-change-net2280.patch
-gregkh-usb-usb-gadget-setup-api-change-goku_udc.patch
-gregkh-usb-usb-gadget-pxa2xx_udc-updates.patch
-gregkh-usb-usb-ehci-minor-updates.patch
-gregkh-usb-usb-usbatm-1.patch
-gregkh-usb-usb-speedtch-prep.patch
-gregkh-usb-usb-usbatm-2.patch
-gregkh-usb-usb-usbatm-3.patch
-gregkh-usb-usb-usbatm-4.patch
-gregkh-usb-usb-usbatm-5.patch
-gregkh-usb-usb-usbatm-reduce-log-spam.patch
-gregkh-usb-usb-usbatm-avoid-oops-on-bind-failure.patch
-gregkh-usb-usb-usbatm-fix-gcc-2.95.x.patch
-gregkh-usb-usb-usbatm-kcalloc.patch
-gregkh-usb-usb-dummy_hcd-sparse-cleanups.patch
-gregkh-usb-usb-dummy_hcd-suspend-and-resume.patch
-gregkh-usb-usb-fix-gadget-build-error.patch
-gregkh-usb-usb-gadget-drain-rndis.patch
-gregkh-usb-usb-uhci-detect-invalid-ports.patch
+gregkh-usb-usb-bMaxPacketSize0-sysfs.patch
+gregkh-usb-usb-storage-unusual-ids-01.patch
+gregkh-usb-usb-khubd-use-kthread.patch
+gregkh-usb-usb-ftdi_sio-device_id-clutter-reduction.patch
+gregkh-usb-usb-ftdi_sio-remove-TIOCMBIS.patch
+gregkh-usb-usb-ftdi_sio-fix-compiler-warnings.patch
+gregkh-usb-usb-atm-01.patch
+gregkh-usb-usb-atm-02.patch
+gregkh-usb-usb-atm-03.patch
+gregkh-usb-usb-sis-makefile-fix.patch
+gregkh-usb-usb-usbmon-print-control-packets.patch
+gregkh-usb-usb-isp116x-hcd-cleanup.patch
+gregkh-usb-usb-kmalloc-flag-cleanup.patch
+gregkh-usb-usb-net2280-warning-fix.patch
+gregkh-usb-usb-keyspan-remote.patch
+gregkh-usb-usb-coverity-desc-bitmap-overrun-fix.patch
+gregkh-usb-usb-ld-hid-blacklist.patch
-gregkh-usb-usb-ehci-fix-page-pointer-allocate.patch
-gregkh-usb-usb-wireless-definitions.patch
-gregkh-usb-usb-usblp-race-fix.patch
-gregkh-usb-usb-stv680-creative-mini.patch
-gregkh-usb-usb-atiremote-sysfs-links.patch
-gregkh-usb-usb-usblp_read-up-fix.patch
-gregkh-usb-usb-storage-endpoint-toggle.patch
-gregkh-usb-usb-storage-port-reset-on-transport-error.patch
-gregkh-usb-usb-storage-retry-hard-errors.patch
-gregkh-usb-usb-usbnet-debug-fix.patch
-gregkh-usb-usb-gadget-pxa-build-fix.patch
-gregkh-usb-usb-fix-inverted-test-for-resuming-interfaces.patch
+gregkh-usb-usb-ldusb.patch

 USB tree merges and additions

+consolidate-config_watchdog_nowayout-handling.patch

 watchdog driver cleanup

+add-sem_is_read-write_locked.patch
+swaptoken-tuning.patch
+swaptoken-tuning-fix.patch

 Fix and reinstate the swapout token thrashing control code

+e1000-printk-warning-fix-2.patch
+net-add-driver-for-the-nic-on-cell-blades.patch
+net-add-driver-for-the-nic-on-cell-blades-kconfig-fix.patch

 Net driver fixes

+ppc32-add-the-freescale-mpc86xads-board-support.patch
+ppc32-stop-misusing-ntps-time_offset-value.patch
+openfirmware-generate-device-table-for-userspace.patch
+openfirmware-add-sysfs-nodes-for-open-firmware-devices.patch
+openfirmware-implement-hotplug-for-macio-devices.patch
+ppc64-add-new-phy-to-sungem.patch

 ppc32/ppc64 updates

+mtrr-suspend-resume-cleanup.patch

 x86 cleanup

+alpha-smp-fix.patch

 Alpha fix

+suspend-fix-isa-dma-controller-hangs.patch

 Fix handling of ISA DMA comtroller on PM resume

-cris-update-16-17-usb.patch

 This broke badly (all the cris patches need to be redone)

+cris-ide-driver.patch

 CRIS-specific IDE update

+xtensa-remove-old-syscalls.patch

 xtensa syscall cleanup.

+avoid-lookup_hash-usage-in-relayfs.patch

 relayfs update

-page_uptodate_lock-hashing.patch
+page_uptodate-locking-scalability.patch
+page_uptodate-locking-scalability-fix.patch

 Do this the other way.

-new-driver-for-yealink-usb-p1k-phone-tidy.patch
-new-driver-for-yealink-usb-p1k-phone-fixes.patch
-new-driver-for-yealink-usb-p1k-phone-warning-sysfs-fixes.patch
-yealink-maintainer.patch

 Folded into new-driver-for-yealink-usb-p1k-phone.patch

+yealink-updates.patch

 Fixes for the above

-de_thread-eliminate-unneccessary-sighand-locking.patch

 Dropped - Roland had problems with it.

+pselect-ppoll-system-calls-sigset_t-fix-3.patch
+pselect-ppoll-system-calls-compat-fix.patch
+pselect-ppoll-system-calls-syscall-numbering-fix.patch

 More fixes for the pselect/poll patch

+kallsyms-change-compression-algorithm.patch

 Rework kallsyms compression

+stale-posix-lock-handling.patch

 POSIX locks fix

+acl-kconfig-cleanup.patch

 Kconfig cleanups

+fix-few-remaining-u32-vs-pm_message_t-problems.patch

 More pm_message_t conversions

+propagate-__nocast-annotations.patch

 __nocast fixes

+mostly_read-data-section.patch

 Add a section for read-mostly variables

+dont-write-to-the-in-inode-xattr-space-of-reserved-inodes.patch

 ext3/xattr fix

+cciss-per-disk-queue.patch

 per-disk queues for CCISS (needs work)

+input-stop-reporting-input-ctrl-xfers-as-hiddev-events-v2.patch

 input/hiddev fix

+put_compat_shminfo-warning-fix.patch

 Fix a return value

+coverity-fbsysfs-fix-null-pointer-check.patch
+coverity-udf-balloc-null-deref-fix.patch
+coverity-usb-host-ehci-dbg-null-check.patch
+coverity-fs-locks-flp-null-check.patch
+coverity-sunrpc-xprt-task-null-check.patch

 Various problems from the Coverity checker

+ib-uverbs-core-api-extensions.patch
+ib-uverbs-update-kernel-midlayer-for-new-api.patch
+ib-uverbs-update-mthca-for-new-api.patch
+ib-uverbs-add-user-verbs-abi-header.patch
+ib-uverbs-core-implementation.patch
+ib-uverbs-core-implementation-fix.patch
+ib-uverbs-memory-pinning-implementation.patch
+ib-uverbs-hook-up-kconfig-makefile.patch
+ib-uverbs-add-mthca-abi-header.patch
+ib-uverbs-add-mthca-user-doorbell-record-support.patch
+ib-uverbs-add-mthca-user-context-support.patch
+ib-uverbs-add-mthca-mmap-support.patch
+ib-uverbs-add-mthca-user-pd-support.patch
+ib-uverbs-add-mthca-user-mr-support.patch
+ib-uverbs-add-mthca-user-cq-support.patch
+ib-uverbs-add-mthca-user-qp-support.patch
+ib-uverbs-add-documentation-file.patch

 Infiniband feature work

+fix-namespace-problem-and-sparc64-build.patch

 kprobes fix & cleanup

+fix-soft-lockup-due-to-ntfs-vfs-part-and-explanation.patch

 VFS infrastructure to fix an NTFS problem

+connector-exit-notifier.patch
+connector-exit-notifier-fix.patch

 Add connector-based notification of exit()s to userspace

-inotify-faq-fds.patch

 Folded into inotify-45.patch

+dvb-cinergyt2-endianness-fix-for-raw-remote-control-keys.patch
+dvb-remove-obsolete-skystar2-driver.patch
+dvb-core-fix-race-condition-in-fe_read_status-ioctl.patch
+dvb-core-add-workaround-for-tuning-problem.patch
+dvb-core-demux-error-handling-fix.patch
+dvb-core-dmxdev-cleanups.patch
+dvb-frontend-remove-unused-i2c-ids.patch
+dvb-frontend-tda1004x-update.patch
+dvb-frontend-bcm3510-fix-firmware-version-check.patch
+dvb-add-missing-release_firmware-calls.patch
+dvb-frontend-tda1004x-support-tda827x-tuners.patch
+dvb-frontend-cx22702-support-for-cxusb.patch
+dvb-frontend-l64781-improve-tuning.patch
+dvb-dvb-update.patch
+dvb-add-pluto2-driver.patch
+dvb-saa7146-kj-pci_module_init-cleanup.patch
+dvb-flexcop-add-big-endian-register-definitions.patch
+dvb-flexcop-woraround-irq-stop-problem.patch
+dvb-twinhan-dst-frontend-fixes.patch
+dvb-twinhan-dst-frontend-polarization-fix.patch
+dvb-ttusb-dec-kfree-cleanup.patch
+dvb-ttpci-add-support-for-technotrend-hauppauge-dvb-s-se.patch
+dvb-ttpci-support-for-new-tt-dvb-t-ci.patch
+dvb-ttpci-fix-error-handling-for-firmware-communication.patch
+dvb-ttpci-fix-bug-in-timeout-handling.patch
+dvb-ttpci-fix-auduio_continue-ioctl.patch
+dvb-ttpci-budget-av--tu1216-fix-for-qam128.patch
+dvb-ttpci-more-error-handling-for-firmware-communication.patch
+dvb-ttpci-error-handling-fix.patch
+dvb-ttpci-cleanup-indentation-whitespace.patch
+dvb-ttpci-make-av7110_fe_lock_fix-retryable.patch
+dvb-ttpci-kj-printk-fix.patch
+dvb-ttpci-add-support-for-hauppauge-tt-dvb-c-budget.patch
+dvb-dvb-usb-support-artect-t1-with-broken-usb-ids.patch
+dvb-usb-fix-adstech-instant-tv-dvb-t-usb20-support.patch
+dvb-usb-add-isochronous-streaming-method.patch
+dvb-frontend-add-fmd1216me-pll.patch
+dvb-usb-support-medion-hybrid-usb20-dvb-t-analogue-box.patch
+dvb-usb-add-module-parm-to-disable-remote-control-polling.patch
+dvb-frontend-add-alps-tded4-pll.patch
+dvb-usb-digitv-usb-fixes.patch
+dvb-usb-dvb_usb_properties-init-fix.patch
+dvb-usb-cxusb-dvb-t-fixes.patch
+dvb-usb-add-videowalker-dvb-t-usb-ids.patch
+dvb-usb-digitv-memcpy-fix.patch
+dvb-usb-doc-update.patch
+dvb-usb-kconfig-help-text-update.patch
+dvb-usb-add-vp7045-ir-keymap.patch
+dvb-usb-fix-wideview-usb-ids.patch
+dvb-usb-vp7045-ir-map-fix.patch
+dvb-usb-ir-input-fixes.patch

 DVB updates

+jbd-split-checkpoint-lists.patch
+jbd-split-checkpoint-lists-tweaks.patch

 Split the JBD checkpoint lists

+pcmcia-fix-i82365-request_region-double-usage.patch

 pcmcia fix

-spinlock-consolidation-parisc-build-fixes.patch
-spinlock-consolidation-sparc64-fix.patch

 Folded into spinlock-consolidation.patch

+spinlock-consolidation-m32r-fix.patch
+spinlock-consolidation-up-spinlocks-gcc-29x-fix.patch

 Fix it some more

-numa-aware-slab-allocator-unifdeffery.patch

 Folded into numa-aware-slab-allocator-v5.patch

-iteraid-fix-trivial-sparse-warnings.patch
-iteraid-misc-trivial-cleanups.patch
-iteraid-remove-home-grown-memmove.patch
-iteraid-memset-fix.patch

 Folded into iteraid.patch

-make-page_owner-handle-non-contiguous-page-ranges.patch
-add-gfp_mask-to-page-owner.patch

 Folded into page-owner-tracking-leak-detector.patch

+page-owner-tracking-leak-detector-tidy.patch

 Tidy it up for a merge

+perfctr-syscall-numbering-fixups.patch

 Fix my broken attempt to fix the syscall numbering

-scheduler-cache-hot-autodetect-section-fix.patch
-scheduler-cache-hot-autodetect-x86-cpu_khz-type-fix.patch
-scheduler-cache-hot-autodetect-x86-cpu_khz-type-fix-2.patch

 Folded into scheduler-cache-hot-autodetect.patch

-sched-add-cacheflush-asm-2.patch
-sched-add-cacheflush-asm-2-ia64-fix.patch
-scheduler-cache-hot-autodetect-build-fix.patch

 Folded into sched-add-cacheflush-asm.patch

+v4l-cx88-update.patch
+v4l-cx88-hue-offset-fix.patch

 v4l updates

-files-break-up-files-struct-ia64-fix.patch
-files-break-up-files-struct-fix-dupfd-by-fdt-reload.patch

 Folded into files-break-up-files-struct.patch

-files-files-struct-with-rcu-change-fd_install-assertion.patch

 Folded into files-files-struct-with-rcu.patch

-files-files-locking-doc-update.patch

 Folded into files-files-locking-doc.patch

+reiser4-xattr-build-fix.patch

 Fix reiser4 build

+m32r-framebuffer-device-support.patch

 m32r fbdev driver

+device-mapper-dm-raid1-limit-bios-to-size-of-mirror-region.patch
+device-mapper-dm-raid1-limit-bios-to-size-of-mirror-region-fix.patch

 DM fix

-fuse-nfs-export.patch

 Drop the FUSE nfs export feature.

+clean-up-inline-static-vs-static-inline.patch
+update-credits-entry-and-listings-in-source-files-for-jesper.patch
+applicom-fix-error-handling.patch
+drivers-char-lcdc-misc_register-can-fail.patch
+hdpu_cpustate-misc_register-can-fail.patch
+sb16_csp-remove-home-grown-le_to_cpu-macros.patch
+sb16_csp-untypedef.patch

 Minor bits and pieces



number of patches in -mm: 461
number of changesets in external trees: 9
number of patches in -mm only: 460
total patches: 469



All 461 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc1/2.6.13-rc1-mm1/patch-list


