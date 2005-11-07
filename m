Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVKGCZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVKGCZH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 21:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVKGCZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 21:25:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65222 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932408AbVKGCZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 21:25:03 -0500
Date: Sun, 6 Nov 2005 18:24:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-mm1
Message-Id: <20051106182447.5f571a46.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/

- Added the 1394 development tree to the -mm lineup, as git-ieee1394.patch

- Re-added rmk's driver-model tree git-drvmodel.patch

- Added davem's sparc64 tree, as git-sparc64.patch

- v4l updates

- dvb updates



Changes since 2.6.14-rc5-mm1:


 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-arm.patch
 git-blktrace.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drvmodel.patch
 git-audit.patch
 git-ia64.patch
 git-ieee1394.patch
 git-input.patch
 git-jfs.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-sas.patch
 git-sparc64.patch
 git-cryptodev.patch

 subsystem trees

-timers-add-missing-compensation-for-hz-==-250.patch
-alpha-atomic-dependency-fix.patch
-cpufreq-smp-fix-for-conservative-governor.patch
-posix-timers-smp-race-condition.patch
-hostap-fix-kbuild-warning.patch
-git-acpi-build-fix-2.patch
-dont-set-dcdbas-driver-to-default-m.patch
-agp-updates-owner-field-of-struct-pci_driver.patch
-cleanup-for-cs5535-audio-driver.patch
-cs5535-audio-alsa-driver-kconfig-fix.patch
-nm256-reset-workaround-for-latitude-csx.patch
-git-cifs-build-fix.patch
-gregkh-driver-aoe-01.patch
-gregkh-driver-aoe-02.patch
-gregkh-driver-driver-ide-tape-sysfs.patch
-gregkh-driver-driver-kobject-typo.patch
-gregkh-driver-driver-porting-typo.patch
-gregkh-driver-kobject-fix-gfp-flags-type.patch
-gregkh-driver-driver-model-wakeup-01.patch
-gregkh-driver-driver-model-wakeup-02.patch
-gregkh-driver-driver-send-hotplug-before-adding-class_interface.patch
-gregkh-driver-i2o-remove-class-interface.patch
-gregkh-driver-i2o-class-01.patch
-gregkh-driver-i2o-remove-i2o_device_class.patch
-gregkh-driver-driver-interface-pass.patch
-gregkh-driver-coldplug-emit-hotplug-events-from-sysfs.patch
-gregkh-driver-class_dev_child.patch
-gregkh-driver-class_device_create_api_fixup.patch
-gregkh-driver-class-device.h-documentation.patch
-gregkh-driver-input-remove-devfs.patch
-gregkh-driver-input-sysfs-intregration.patch
-gregkh-driver-input-convert-to-dynamic-mouse.patch
-gregkh-driver-input-convert-to-dynamic-keyboard.patch
-gregkh-driver-input-convert-to-dynamic-usb.patch
-gregkh-driver-input-convert-to-dynamic-ucb1x00-ts.patch
-gregkh-driver-input-convert-to-dynamic-touchscreen.patch
-gregkh-driver-input-convert-to-dynamic-sonypi.patch
-gregkh-driver-input-convert-to-dynamic-onetouch.patch
-gregkh-driver-input-convert-to-dynamic-misc.patch
-gregkh-driver-input-convert-to-dynamic-media.patch
-gregkh-driver-input-convert-to-dynamic-macintosh.patch
-gregkh-driver-input-convert-to-dynamic-konicawc.patch
-gregkh-driver-input-convert-to-dynamic-joystick.patch
-gregkh-driver-input-convert-to-dynamic-bluetooth.patch
-gregkh-driver-input-convert-to-dynamic-beep.patch
-gregkh-driver-input-show-sysfs-path-in-proc.patch
-gregkh-driver-input-export-input_dev-data-in-sysfs.patch
-gregkh-driver-input-register-class_device-sooner.patch
-gregkh-driver-input-input_dev_class-export.patch
-gregkh-driver-input-class_device-move.patch
-gregkh-driver-input_oops_fix.patch
-gregkh-driver-input-remove-input_class.patch
-gregkh-driver-input-rename-input_dev_class.patch
-gregkh-driver-input_backward_compatible_symlink.patch
-gregkh-driver-input-remove-custom-hotplug.patch
-gregkh-driver-drivers-base-fix-sparse-warnings.patch
-gregkh-driver-driver-core-big-kfree-null-check-cleanup-documentation.patch
-gregkh-driver-speakup-kconfig-fix-2.patch
-gregkh-i2c-hwmon-adm9240-update-01.patch
-gregkh-i2c-hwmon-adm9240-update-02.patch
-gregkh-i2c-hwmon-via686a-save-memory.patch
-gregkh-i2c-hwmon-01.patch
-gregkh-i2c-hwmon-02.patch
-gregkh-i2c-hwmon-03.patch
-gregkh-i2c-hwmon-04.patch
-gregkh-i2c-hwmon-05.patch
-gregkh-i2c-hwmon-06.patch
-gregkh-i2c-hwmon-07.patch
-gregkh-i2c-hwmon-08.patch
-gregkh-i2c-hwmon-09.patch
-gregkh-i2c-hwmon-10.patch
-gregkh-i2c-hwmon-11.patch
-gregkh-i2c-hwmon-12.patch
-gregkh-i2c-hwmon-13.patch
-gregkh-i2c-i2c-viapro-01.patch
-gregkh-i2c-i2c-viapro-02.patch
-gregkh-i2c-i2c-viapro-03.patch
-gregkh-i2c-i2c-viapro-04.patch
-gregkh-i2c-i2c-viapro-05.patch
-gregkh-i2c-i2c-viapro-06.patch
-gregkh-i2c-i2c-viapro-07.patch
-gregkh-i2c-i2c-viapro-08.patch
-gregkh-i2c-i2c-01.patch
-gregkh-i2c-i2c-02.patch
-gregkh-i2c-i2c-03.patch
-gregkh-i2c-i2c-04.patch
-gregkh-i2c-i2c-05.patch
-gregkh-i2c-i2c-06.patch
-gregkh-i2c-i2c-07.patch
-gregkh-i2c-i2c-08.patch
-gregkh-i2c-i2c-09.patch
-gregkh-i2c-i2c-10.patch
-gregkh-i2c-i2c-11.patch
-gregkh-i2c-i2c-12.patch
-gregkh-i2c-i2c-13.patch
-gregkh-i2c-i2c-14.patch
-gregkh-i2c-i2c-15.patch
-gregkh-i2c-i2c-16.patch
-gregkh-i2c-i2c-owner-field-01-struct-pci-driver.patch
-gregkh-i2c-i2c-owner-field-02-struct-device-driver.patch
-gregkh-i2c-i2c-owner-field-03-i2c-keywest.patch
-gregkh-i2c-i2c-owner-field-04-i2c-core.patch
-gregkh-i2c-i2c-owner-field-05-i2c-isa.patch
-gregkh-i2c-hwmon-smsc47b397-new-id.patch
-gregkh-i2c-hwmon-missing-driver-class.patch
-gregkh-i2c-i2c-x1205.patch
-gregkh-i2c-kzalloc-01-i2c-ixp.patch
-gregkh-i2c-kzalloc-02-hwmon.patch
-gregkh-i2c-kzalloc-03-i2c-other.patch
-gregkh-i2c-kzalloc-04-drop-useless-casts.patch
-gregkh-i2c-kzalloc-05-i2c-amd756-s4882.patch
-gregkh-i2c-kzalloc-06-i2c-documentation-update.patch
-gregkh-i2c-i2c-device-id.patch
-input-evdev-allow-querying-ev_sw-from-compat_ioctl.patch
-input-add-logitech-mx3100-to-logips2ppc.patch
-remove-redundant-configso.patch
-config_ia32.patch
-git-netdev-all-ieee80211_tx-fix.patch
-git-netdev-all-b44-build-fix.patch
-ntfs-printk-warning-fixes.patch
-serial-remove-unneeded-code-from-serial_corec.patch
-gregkh-pci-pci-ich6-acpi-quirk.patch
-gregkh-pci-pci-block-config-access-during-BIST-01.patch
-gregkh-pci-pci-block-config-access-during-BIST-02.patch
-gregkh-pci-pci-cleanup-need_restore-switch.patch
-gregkh-pci-pci-hotplug-enable_device-01.patch
-gregkh-pci-pci-hotplug-enable_device-02.patch
-gregkh-pci-pci-ich6-smbus-quirk.patch
-gregkh-pci-pci-ids-01.patch
-gregkh-pci-pci-ids-02.patch
-gregkh-pci-pci-ids-03.patch
-gregkh-pci-pci-rpaphp-api-fix.patch
-gregkh-pci-pci-quirk-hpd530.patch
-gregkh-pci-shpc-01-shpc-use-pci-core.patch
-gregkh-pci-shpc-02-remove-redundant-res-display.patch
-gregkh-pci-shpc-03-reduce-acpi-dependence.patch
-gregkh-pci-shpc-04-probe-bail-early.patch
-gregkh-pci-shpc-05-dont-save-pci-configs.patch
-gregkh-pci-shpc-06-remove-redundant-data-structures.patch
-gregkh-pci-shpc-07--misc-cleanup.patch
-gregkh-pci-shpc-08-reduce-dbg-verbosity.patch
-gregkh-pci-shpc-09-remove-sysfs-files-on-unload.patch
-gregkh-pci-pci-fix-edac-drivers-for-radisys-82600-borkage.patch
-gregkh-pci-pci-fixup-pci-driver-shutdown.patch
-gregkh-pci-pci-convert-megaraid-to-use-pci_driver-shutdown-method.patch
-gregkh-pci-acpiphp-allocate-resources-for-adapters-with-bridges.patch
-scsi-remove-dead-code-from-src.patch
-scsi_error-thread-exits-in-task_interruptible-state.patch
-scsi-disk-report-size-without-overflow.patch
-gregkh-usb-usb-ehci-clean-shutdown.patch
-gregkh-usb-usb-ftdi-new-id.patch
-gregkh-usb-usb-rdl8150-oops-fix.patch
-gregkh-usb-usb-endpoints-in-sysfs.patch
-gregkh-usb-devfs-remove-usb-mode.patch
-gregkh-usb-usbsnoop.patch
-gregkh-usb-ub-fix-compiler-warnings.patch
-gregkh-usb-usb-handoff-merge.patch
-gregkh-usb-usb-power-state-01.patch
-gregkh-usb-usb-power-state-02.patch
-gregkh-usb-usb-power-state-03.patch
-gregkh-usb-usb-power-state-04.patch
-gregkh-usb-usb-power-state-05.patch
-gregkh-usb-usb-fix-hub-build.patch
-gregkh-usb-usb-uhci-01.patch
-gregkh-usb-usb-uhci-02.patch
-gregkh-usb-usb-pm-01.patch
-gregkh-usb-usb-pm-02.patch
-gregkh-usb-usb-pm-03.patch
-gregkh-usb-usb-pm-04.patch
-gregkh-usb-usb-pm-05.patch
-gregkh-usb-usb-pm-06.patch
-gregkh-usb-usb-pm-07.patch
-gregkh-usb-usb-pm-08.patch
-gregkh-usb-usb-pm-10.patch
-gregkh-usb-usb-pm-11.patch
-gregkh-usb-usb-pm-12.patch
-gregkh-usb-usb-pm-13.patch
-gregkh-usb-usb-usb_bulk_message-handle-interrupt.patch
-gregkh-usb-usb-uhci-comment-cleanup.patch
-gregkh-usb-usb-sisusb-warning-fix.patch
-gregkh-usb-usb-gadget-file-storage-use-kthread.patch
-gregkh-usb-usb-wHubCharacteristics-fix.patch
-gregkh-usb-usb-ftdi_sio-id.patch
-gregkh-usb-usb-pegasus-id.patch
-gregkh-usb-usb-safe_serial-preprocessor-fix.patch
-gregkh-usb-usb-storage-Kconfig-note-cleanup.patch
-gregkh-usb-usb-storage-hp8200-device-detect-fix.patch
-gregkh-usb-usb-storage-shuttle_usbat-cleanups.patch
-gregkh-usb-usb-storage-unusual-01.patch
-gregkh-usb-usb-storage-unusual-02.patch
-gregkh-usb-usb-storage-unusual-03.patch
-gregkh-usb-usb-touchkit-id.patch
-gregkh-usb-usb-gadget-g_file_storage-race-fix.patch
-gregkh-usb-usb-uhci-unify-bios-handoff-code.patch
-gregkh-usb-usb-rename-hcd-hub_suspend-to-hcd-bus_suspend.patch
-gregkh-usb-uhci-improve-handling-of-iso-tds.patch
-gregkh-usb-usb-storage-another-unusual_devs-entry.patch
-gregkh-usb-usb-buffer-overflow-patch-for-yealink-driver.patch
-gregkh-usb-usb-doc-fix-kernel-doc-warning.patch
-gregkh-usb-omap_udc-dma-off-by-one-fix.patch
-gregkh-usb-fix-hcd-state-assignments-in-uhci-hcd.patch
-gregkh-usb-add-usb-transceiver-set_suspend-method.patch
-gregkh-usb-usb-s3c2410-ohci-add-driver-owner-field.patch
-gregkh-usb-usb-gadget-drivers-add-.owner-initialisation.patch
-gregkh-usb-usb-add-owner-initialisation-to-host-drivers.patch
-gregkh-usb-missing-transfer_flags-setting-in-usbtest.patch
-gregkh-usb-usb-remove-devio-global.patch
-gregkh-usb-usb-notify-devices-and-busses.patch
-gregkh-usb-usb-use-notifier-devio.patch
-gregkh-usb-usb-use-notifier-inode.patch
-gregkh-usb-usb-use-notifier-usbmon.patch
-gregkh-usb-usb-patch-for-usbdevfs_ioctl-from-32-bit-programs.patch
-gregkh-usb-usb-remove-bluetty.patch
-gregkh-usb-usb-serial-driver-cleanup-01.patch
-gregkh-usb-usb-serial-driver-cleanup-02.patch
-gregkh-usb-usb-serial-driver-cleanup-03.patch
-gregkh-usb-usb-serial-driver-cleanup-04.patch
-gregkh-usb-usb-serial-driver-cleanup-05.patch
-gregkh-usb-usb-rename-hcd-hub_suspend-to-hcd-bus_suspend-fix.patch
-gregkh-usb-usb-rename-hcd-hub_suspend-to-hcd-bus_suspend-config_pm-fix.patch
-gregkh-usb-usb-serial-driver-cleanup-01-fixes.patch
-gregkh-usb-usb-serial-driver-cleanup-04-fixes.patch
-gregkh-usb-usb-serial-driver-cleanup-04-keyspan-fixes.patch
-gregkh-usb-usb-patch-for-usbdevfs_ioctl-from-32-bit-programs-fix.patch
-gregkh-usb-usb-pm-04-fix.patch
-gregkh-usb-usb-pm-03-fix.patch
-export-usb_suspend_device.patch
-clean-crypto-sha1c-up-a-bit.patch
-add-sem_is_read-write_locked.patch
-add-sem_is_read-write_locked-fix.patch
-add-sem_is_read-write_locked-fix-2.patch
-add-sem_is_read-write_locked-fix-3.patch
-swaptoken-tuning.patch
-swaptoken-tuning-fix.patch
-swaptoken-tuning-fix-2.patch
-mm-page_alloc-increase-size-of-per-cpu-pages.patch
-mm-set-per-cpu-pages-lower-threshold-to-zero.patch
-convert-mempolicies-to-nodemask_t.patch
-remove-near-all-bugs-in-mm-mempolicyc.patch
-mm-msyncc-cleanup.patch
-shrink_list-skip-anon-pages-if-not-may_swap.patch
-slab-add-additional-debugging-to-detect-slabs-from-the-wrong-node.patch
-mm-copy_pte_range-progress-fix.patch
-mm-msync_pte_range-progress.patch
-mm-zap_pte_range-dont-dirty-anon.patch
-mm-anon-is-already-wrprotected.patch
-mm-vm_stat_account-unshackled.patch
-mm-remove_vma_list-consolidation.patch
-mm-unlink_file_vma-remove_vma.patch
-mm-exit_mmap-need-not-reset.patch
-mm-page-fault-handlers-tidyup.patch
-mm-page-fault-handlers-tidyup-fix.patch
-mm-move_page_tables-by-extents.patch
-mm-tlb_gather_mmu-get_cpu_var.patch
-mm-tlb_is_full_mm-was-obscure.patch
-mm-tlb_finish_mmu-forget-rss.patch
-mm-tlb_finish_mmu-forget-rss-fix.patch
-mm-mm_init-set_mm_counters.patch
-mm-rss-=-file_rss-anon_rss.patch
-mm-rss-=-file_rss-anon_rss-warning-fix.patch
-mm-batch-updating-mm_counters.patch
-mm-dup_mmap-use-oldmm-more.patch
-mm-dup_mmap-down-new-mmap_sem.patch
-mm-sh64-hugetlbpagec.patch
-mm-m68k-kill-stram-swap.patch
-core-remove-pagereserved.patch
-core-remove-pagereserved-fix.patch
-mm-copy_one_pte-inc-rss.patch
-mm-zap_pte_range-dec-rss.patch
-mm-do_swap_page-race-major.patch
-mm-do_mremap-current-mm.patch
-mm-zap_pte-out-of-line.patch
-mm-update_hiwaters-just-in-time.patch
-mm-mm_struct-hiwaters-moved.patch
-mm-ia64-use-expand_upwards.patch
-mm-init_mm-without-ptlock.patch
-mm-ptd_alloc-inline-and-out.patch
-mm-ptd_alloc-take-ptlock.patch
-mm-arches-skip-ptlock.patch
-mm-page-fault-handler-locking.patch
-mm-pte_offset_map_lock-loops.patch
-mm-flush_tlb_range-outside-ptlock.patch
-mm-unlink-vma-before-pagetables.patch
-mm-unmap_vmas-with-inner-ptlock.patch
-mm-unmap_vmas-with-inner-ptlock-fix.patch
-mm-xip_unmap-zero_page-fix.patch
-mm-rmap-with-inner-ptlock.patch
-mm-kill-check_user_page_readable.patch
-mm-follow_page-with-inner-ptlock.patch
-mm-i386-sh-sh64-ready-for-split-ptlock.patch
-mm-arm-ready-for-split-ptlock.patch
-mm-parisc-pte-atomicity.patch
-mm-cris-v32-mmu_context_lock.patch
-mm-uml-pte-atomicity.patch
-mm-uml-kill-unused.patch
-mm-split-page-table-lock.patch
-mm-split-page-table-lock-fixes.patch
-mm-split-page-table-lock-fixes-2.patch
-mm-split-page-table-lock-fixes-3.patch
-mm-fix-rss-and-mmlist-locking.patch
-mm-update-comments-to-pte-lock.patch
-hugetlbfs-move-free_inodes-accounting.patch
-hugetlbfs-move-free_inodes-accounting-fix.patch
-hugetlbfs-clean-up-hugetlbfs_delete_inode.patch
-kill-hugelbfs_do_delete_inode.patch
-cleanup-hugelbfs_forget_inode.patch
-hugetlb-remove-repeated-code.patch
-hugetlb-demand-fault-handler.patch
-hugetlb-overcommit-accounting-check.patch
-hugetlb-overcommit-accounting-check-fix.patch
-memory-hotplug-prep-kill-local_mapnr.patch
-memory-hotplug-prep-break-out-zone-initialization.patch
-memory-hotplug-prep-break-out-zone-initialization-fix.patch
-memory-hotplug-prep-__section_nr-helper.patch
-memory-hotplug-prep-__section_nr-helper-fix.patch
-memory-hotplug-prep-fixup-bad_range.patch
-memory-hotplug-locking-node_size_lock.patch
-memory-hotplug-locking-zone-span-seqlock.patch
-memory-hotplug-sysfs-and-add-remove-functions.patch
-memory-hotplug-move-section_mem_map-alloc-to-sparsec.patch
-memory-hotplug-move-section_mem_map-alloc-to-sparsec-kzalloc.patch
-memory-hotplug-move-section_mem_map-alloc-to-sparsec-fix.patch
-memory-hotplug-call-setup_per_zone_pages_min-after-hotplug.patch
-memory-hotplug-i386-addition-functions.patch
-memory-hotplug-i386-addition-functions-warning-fix.patch
-memory-hotplug-i386-addition-functions-highmem-fix.patch
-memory-hotplug-ppc64-specific-hot-add-functions.patch
-vmalloc_node.patch
-implement-sys_-do_-layering-in-the-memory-policy-layer.patch
-implement-sys_-do_-layering-in-the-memory-policy-layer-tidy.patch
-remove-policy-contextualization-from-mbind.patch
-mm-wider-use-of-for_each_cpu.patch
-mm-filemapcfilemap_populate-move-export.patch
-net-wider-use-of-for_each_cpu.patch
-netlink-remove-dead-code-in-af_netlinkc.patch
-ipv4-remove-dead-code-from-ip_outputc.patch
-fix-behavior-of-ip6_route_input-for-link-local-address.patch
-remove-warning-about-e1000_suspend.patch
-tg3-handle-mmio-reordering-for-all-devices.patch
-eeproc-module_param_array-cleanup.patch
-b44-fix-suspend-resume.patch
-sis900-come-alive-after-temporary-memory-shortage.patch
-sis900-add-wake-on-lan-support.patch
-e1000-use-vmalloc_node.patch
-revert-orinoco-information-leakage-due-to-incorrect-padding.patch
-better-fixup-for-the-orinoco-driver.patch
-e1000-fixes-e1000_suspend-warning-when-config_pm-is-not.patch
-selinux-convert-to-kzalloc.patch
-selinux-canonicalize-getxattr.patch
-selinux-canonicalize-getxattr-fix.patch
-selinux-remove-unecessary-size_t-checks-in-selinuxfs.patch
-ppc-prevent-gcc-4-from-generating-altivec-instructions-in-kernel.patch
-ppc32-8xx-use-io-accessor-macros-instead-of-direct-memory-reference.patch
-mpc8xx-pcmcia-driver.patch
-ppc32-cleanup-amcc-ppc44x-eval-board-u-boot-support.patch
-ppc32-ifdef-out-altivec-specific-code-in-__switch_to.patch
-ppc32-handle-access-to-non-present-io-ports-on-8xx.patch
-ppc32-update-xmon-help-text.patch
-ppc-make-phys_mem_access_prot-work-with-pfns-instead-of.patch
-ppc32-nvram-driver-for-chrp.patch
-add-modalias-to-macio-sysfs-attributes.patch
-add-modalias-for-pmac-network-drivers.patch
-new-powerpc-4xx-on-chip-ethernet-controller-driver.patch
-add-maintainer-entry-for-the-new-powerpc-4xx-on-chip-ethernet-controller-driver.patch
-chrp_pegasos_eth-added-marvell-discovery.patch
-chrp_pegasos_eth-added-marvell-discovery-tidy.patch
-chrp_pegasos_eth-added-marvell-discovery-tidy-2.patch
-ppc32-85xx-phy-platform-update.patch
-ppc32-ppc_sys-fixes-for-8xx-and-82xx.patch
-ppc64-add-cpufreq-support-for-smu-based-g5.patch
-ppc64-support-retreiving-missing-smu-partitions.patch
-ppc64-thermal-control-for-smu-based-machines.patch
-ppc64-boot-remove-include-from-lib-zlib_inflate-inflatec.patch
-ppc64-boot-remove-include-from-include-linux-zutilh.patch
-ppc64-boot-missing-include-for-size_t.patch
-ppc64-boot-remove-zlib.patch
-ppc64-boot-remove-need-for-imagesizec.patch
-ppc64-boot-move-gunzip-function-before-use.patch
-ppc64-boot-bootfiles-depend-on-linker-script.patch
-ppc64-boot-cleanup-linker-script.patch
-ppc64-boot-use-memset-to-clear-bss.patch
-ppc64-boot-fix-typo-in-asm-comments.patch
-ppc64-boot-remove-global-initializers.patch
-ppc64-boot-make-the-zimage-relocateable.patch
-ppc64-boot-proof-that-reloc-works.patch
-ppc64-boot-print-firmware-provided-stackpointer.patch
-ppc64-ac-power-handling-broken-for-desktops.patch
-ppc64-make-dma_addr_t-64-bits.patch
-various-powerpc-32bit-ppc64-build-fixes.patch
-ppc64-compile-nls_cp437-and-nls_iso8859_1-into-the-kernel-in-defconfig.patch
-ppc64-reenable-make-install-with-defconfig.patch
-ppc64-change-name-of-target-file-during-make-install.patch
-ppc64-remove-duplicate-local-variable-in-set_preferred_console.patch
-i386-and-x86_64-tsc-set_cyc2ns_scale-imprecision.patch
-i386-kill-off-config_pc.patch
-x86-cmpxchg-improvements.patch
-fpu-context-corrupted-after-resume.patch
-x86-initialise-tss-io_bitmap_owner-to-something.patch
-intel_cacheinfo-remove-max_cache_leaves-limit.patch
-i386-little-pgtableh-consolidation-vs-2-3level.patch
-x86-hot-plug-cpu-to-support-physical-add-of-new-processors.patch
-x86-bogus-tls-from-gdt.patch
-x86-add-an-accessor-function-for-getting-the-per-cpu-gdt.patch
-x86-gdt-page-isolation.patch
-x86-gdt-page-isolation-fix.patch
-x86-bug-fix-in-p6-machine-check-initialization.patch
-asus-vt8235-router-buggy-bios-workaround.patch
-fixup-bogus-e820-entry-with-mem=.patch
-x86-when-l3-is-present-show-its-size-in-proc-cpuinfo.patch
-es7000-platform-update-i386.patch
-i386-io_apicc-memorize-at-bootup-where-the-i8259-is-connected.patch
-i386-nmi_watchdog-merge-check_nmi_watchdog-fixes-from-x86_64.patch
-i386-move-apic-init-in-init_irqs.patch
-i386-move-apic-init-in-init_irqs-tidy.patch
-i386-move-apic-init-in-init_irqs-fix.patch
-i386-kexec-on-panic-dont-shutdown-the-apics.patch
-x86-vmx-cpu-feature-detection.patch
-clean-up-mtrr-compat-ioctl-code.patch
-x86-inline-spin_unlock-if-not-config_debug_spinlock-and-not-config_preempt.patch
-x86-inline-spin_unlock_irq-if-not-config_debug_spinlock-and-not-config_preempt.patch
-x86_64-move-apic-init-in-init_irqs-take-2.patch
-x86_64-move-apic-init-in-init_irqs-take-2-tidy.patch
-x86_64-remove-duplicated-sys_time64.patch
-arm-fix-bogus-cast-in-ixp2000-i-o-macro.patch
-arm-fix-ixp2x00-defconfig-nr_uarts-options.patch
-sharp-sl-5500-touchscreen-support.patch
-support-pcmcia-slot-on-sharp-sl-5500.patch
-swsusp-rework-image-freeing.patch
-swsusp-move-snapshot-functionality-to-separate-file.patch
-swsusp-reduce-the-use-of-global-variables.patch
-swsusp-rework-memory-freeing-on-resume.patch
-swsusp-remove-unneccessary-includes.patch
-swsusp-get-rid-of-unnecessary-wrapper-function.patch
-swsusp-two-simplifications.patch
-get-rid-of-the-obsolete-tri-level-suspend-resume-callbacks.patch
-get-rid-of-the-obsolete-tri-level-suspend-resume-callbacks-sound-fix.patch
-get-rid-of-the-obsolete-tri-level-suspend-resume-callbacks-tda9887-fix.patch
-introduce-valid-callback-for-pm_ops.patch
-m32r-remove-unused-instructions.patch
-m32r-fix-if-warnings.patch
-m32r-noncache_offset-in-_port2addr.patch
-m32r-smc91x-driver-update.patch
-s390-3270-fullscreen-view.patch
-s390-export-ipl-device-parameters.patch
-s390-export-ipl-device-parameters-fix.patch
-s390-ccw-export-modalias.patch
-smsc-ircc2-pm-cleanup-do-not-close-device-when-suspending.patch
-fix-unmapped-buffers-in-transactions-lists.patch
-reiserfs-free-checking-cleanup.patch
-little-de_thread-cleanup.patch
-introduce-setup_timer-helper.patch
-introduce-setup_timer-helper-x86_64-fix.patch
-move-tasklist-walk-from-cfq-iosched-to-elevatorc.patch
-add-kthread_stop_sem.patch
-tioc-compat-ioctl-handling.patch
-ntp-shift_right-cleanup.patch
-ntp-whitespace-cleanup.patch
-delete-2-unreachable-statements-in-drivers-block-paride-pfc.patch
-clarify-help-text-for-init_env_arg_limit.patch
-remove-some-more-check_region-stuff.patch
-use-alloc_percpu-to-allocate-workqueues-locally.patch
-use-alloc_percpu-to-allocate-workqueues-locally-fix.patch
-remove-timer-debug-fields.patch
-remove-timer-debug-fields-fix.patch
-bioscalls-cleanup.patch
-dont-uselessly-export-task_struct-to-user-space-in-core-dumps.patch
-open-cleanup-in-lookup_flags.patch
-protect-ide_cdrom_capacity-by-ifdef.patch
-lib-stringc-cleanup-whitespace-and-codingstyle-cleanups.patch
-lib-stringc-cleanup-remove-pointless-register-keyword.patch
-lib-stringc-cleanup-remove-pointless-explicit-casts.patch
-whitespace-and-codingstyle-cleanup-for-lib-idrc.patch
-clarify-menuconfig-search-help-text.patch
-reduce-sizeofstruct-file.patch
-reduce-sizeofstruct-file-fix.patch
-fix-de_thread-vs-it_real_fn-deadlock.patch
-kill-sigqueue-lock.patch
-unify-sys_tkill-and-sys_tgkill-take-2.patch
-block-cleanups-add-kconfig-default-iosched-submenu.patch
-typo-fix-explictly-explicitly.patch
-posix-timers-use-schedule_timeout-in-common_nsleep.patch
-adjust-parisc-sys_ptrace-prototype.patch
-unify-sys_ptrace-prototype.patch
-typo-fix-dot-after-newline-in-printk-strings.patch
-block-cleanups-fix-iosched-module-refcount-leak.patch
-add_timer-of-pending-time-is-illegal.patch
-fuse-clean-up-dead-code-related-to-nfs-exporting.patch
-proc-fix-of-error-path-in-proc_get_inode.patch
-cpuset-cleanup.patch
-cpuset-remove-depth-counted-locking-hack.patch
-cpuset-dual-semaphore-locking-overhaul.patch
-cpuset-simple-rename.patch
-cpuset-confine-pdflush-to-its-cpuset.patch
-ptrace-coredump-exit_group-deadlock.patch
-fs-error-case-fix-in-__generic_file_aio_read.patch
-vm-remove-redundant-assignment-from-__pagevec_release_nonlru.patch
-vm-remove-unused-broken-page_pte-macros.patch
-keys-export-user-defined-keyring-operations.patch
-keys-export-user-defined-keyring-operations-update.patch
-keys-add-lsm-hooks-for-key-management.patch
-keys-get-rid-of-warning-in-kmodc-if-keys-disabled.patch
-ide-cd-mini-cleanup-of-casts.patch
-cleanup-for-kernel-printkc.patch
-pf_dead-cleanup.patch
-pf_dead-cleanup-fixes.patch
-coredump_wait-cleanup.patch
-locking-problems-while-ext3fs_debug-on.patch
-ioc4-serial-support-mostly-cleanup.patch
-sparse-cleanups-null-pointers-c99-struct-init.patch
-wait4-ptrace_attach-race-fix.patch
-small-kconfig-help-text-correction-for-config_frame_pointer.patch
-fuse-spelling-fixes.patch
-fuse-remove-unused-define.patch
-added-a-receive_abort-to-the-marvell-serial-driver.patch
-fix-de_thread-vs-do_coredump-deadlock.patch
-telecom-clock-driver-for-mpcbl0010-atca-computer-blade.patch
-ext3-sparse-fixes.patch
-ext3-sparse-fixes-2.patch
-remove-orphaned-tiocgdev-compat-ioctl.patch
-jiffies_64-cleanup.patch
-ext3_show_options-warning-fix.patch
-firmware-fix-all-kernel-doc-warnings.patch
-setkeys-needs-root.patch
-extable-remove-needless-declaration.patch
-modules-fix-sparse-warning-for-every-module_parm.patch
-fix-nr_unused-accounting-and-avoid-recursing-in-iput-with-i_will_free-set.patch
-test-for-sb_getblk-return-value.patch
-test-for-sb_getblk-return-value-fixes.patch
-fix-vgacon-blanking.patch
-ktimers-kt2.patch
-ktimers-kt2-gcc-295-fix.patch
-ktimers-kt2-sparc64-fix.patch
-epca-updates-owner-field-of-struct-pci_driver.patch
-synclink-adapters-updates-owner-field-of-struct-pci_driver.patch
-watchdog-update-owner-field-of-struct-pci_driver.patch
-include-linux-kernelhbuild_bug_on-fix-a-comment.patch
-fs-attrc-remove-bug.patch
-rcu-torture-testing-kernel-module.patch
-propogate-gfp_t-changes-further.patch
-ib-add-idr_destroy-calls-on-module-unload.patch
-posix-cpu-timers-fix-overrun-reporting.patch
-hpet-disallow-zero-interrupt-frequency.patch
-hpet-make-frequency-calculations-32-bit-safe.patch
-hpet-remove-unused-variable.patch
-hpet-remove-superfluous-register-reads.patch
-hpet-allow-non-power-of-two-frequencies.patch
-hpet-allow-shared-interrupts.patch
-hpet-rtc-disable-interrupt-when-no-longer-needed.patch
-hpet-rtc-fix-timer-config-register-accesses.patch
-hpet-rtc-cache-the-comparator-register.patch
-hpet-fix-hpet_info-calls-from-kernel-space.patch
-hpet-fix-division-by-zero-in-hpet_info.patch
-hpet-fix-uninitialized-variable-in-hpet_register.patch
-hpet-fix-access-to-multiple-hpet-devices.patch
-hpet-remove-superfluous-indirections.patch
-hpet-simplify-initialization-message.patch
-hpet-allow-hpet-fixed_mem32-resource-type.patch
-hpet-use-hpet-physical-addresses-for-dup.patch
-hpet-hpet-driver-cleanups.patch
-remove-hardcoded-send_sig_xxx-constants.patch
-cleanup-the-usage-of-send_sig_xxx-constants.patch
-remove-unneeded-si_timer-checks.patch
-remove-duplicate-code-in-signalc.patch
-fix-missing-includes.patch
-fix-more-missing-includes.patch
-fix-even-more-missing-includes.patch
-fat-cleanup-and-optimization-of-checksum.patch
-fat-remove-the-unneeded-vfat_find-in-vfat_rename.patch
-fat-remove-duplicate-directory-scanning-code.patch
-v4l-cleanup-cx88-fix-sparse-warnings.patch
-serial-new-hp-diva-console-port.patch
-sound-fix-up-schedule_timeout-usage.patch
-kfree-cleanup-drivers-net.patch
-kfree-cleanup-sound.patch

 Merged

+ppc64-64k-pages-support.patch

 power4 64k page support

+ppc64-fix-bug-in-slb-miss-handler-for-hugepages.patch

 Fix it for hugepages

+typo-correction-for-fix-build-on-nls-free-systems.patch

 kbuild typo

+ia64-re-implement-dma_get_cache_alignment-to-avoid-export_symbol.patch

 ia64 modular build fix

+powerpc-ppc64-fix-config_smp=n-build-for-ppc64.patch

 ppc64 kbuild fix

+cpu-hotplug-fix-locking-in-cpufreq-drivers.patch

 cpu hotplug scheduling-in-atomic-code sort-of-fix

+fec_8xx-build-fix.patch

 fec_8xx drivers don't compile on most architectures

+suppress-split-ptlock-on-arches-which-may-use-one-page-for-multiple-page-tables.patch

 split pagetable locking might not work on some architectures

+git-acpi-update-8250_acpi.patch

 git-acpi fix

-allow-multiple-ac97-quirks-for-one-piece-of-hardware.patch

 Dropped - was fixed by oter means

+i460-agp-warning-fixes.patch

 agp fix

+sound-hda-rate-limit-timeout-message.patch

 quieten a noisy printk

+git-blktrace-fixup.patch

 Fix a reject

-cpufreq_ondemand-documentation.patch

 Incomplete, dropped.

+git-drm-prep.patch

 Prevent git-drm.patch from getting rejects

+pci-gart-fix.patch

 git-agpgart fix

+git-drvmodel.patch

 driver model tree

+git-audit-audit_inode_context-warning-fix.patch
+git-audit-selinux_inode_xattr_getsuffix-warning-fix.patch
+git-audit-audit_ipc_perms-fix.patch

 Fix git-audit.patch

+gregkh-i2c-i2c-viapro-some-adjustments.patch
+gregkh-i2c-i2c-doc-writing-clients-fix-2.patch
+gregkh-i2c-i2c-device-id-lm75.patch

 i2c tree updates

+evdev-consolidate-compat-and-standard-code.patch
+atkbd-speed-up-setting-leds-repeat-state.patch

 input driver updates

+drives-mtd-redbootc-recognise-a-foreign-byte-sex-partition-table.patch
+sharpsl-mtd-nand-driver-support-for-akita-borzoi.patch

 MTD updates

+git-netdev-all-fix-net_radio=n-ieee80211=y-compile.patch
+s2io-warning-fixes.patch

 netdev fixes

+serial-dont-disable-xscale-serial-ports-after-autoconfig.patch

 serial driver fix

+gregkh-pci-pci_find_next_capability.patch
+gregkh-pci-pci-pciehp-01.patch
+gregkh-pci-pci-pciehp-02.patch
+gregkh-pci-pci-pciehp-03.patch
+gregkh-pci-pci-pciehp-04.patch
+gregkh-pci-pci-pciehp-05.patch
+gregkh-pci-pci-pciehp-06.patch
+gregkh-pci-pci-pciehp-07.patch
+gregkh-pci-pci-pciehp-08.patch
+gregkh-pci-pci-via-686-quirk-name-fix.patch
+gregkh-pci-pci-ncr-53c810-quirk.patch
+gregkh-pci-pci-driver-store_new_id-not-inline.patch
+gregkh-pci-pci_driver_auto_set_owner.patch
+gregkh-pci-pci-driver-owner-removal.patch
+gregkh-pci-dlpar-regression-for-ppc64-probe-change.patch
+gregkh-pci-pci-store-pci_interrupt_pin-in-pci_dev.patch
+gregkh-pci-apci-use-pin-stored-in-pci_dev.patch
+gregkh-pci-pci-use-pin-stored-in-pci_dev.patch
+gregkh-pci-pci-call-pci_read_irq-for-bridges.patch
+gregkh-pci-pci-pci-error-reporting-callbacks.patch
+gregkh-pci-pci-documentation-for-pci-error-recovery.patch

 PCI tree updates

+gregkh-pci-pci-driver-owner-removal-agp-fixes.patch
+gregkh-pci-pci-driver-owner-removal-fix-lpfc.patch
+gregkh-pci-pci-driver-owner-removal-fix-aic94xx_init.patch

 Fixes thereto

+gregkh-usb-usb-fix-unused-variable-warning.patch
+gregkh-usb-usb-delete-bluetty-leftovers.patch
+gregkh-usb-usbfs_dir_inode_operations-cleanup.patch
+gregkh-usb-usb-usbdevfs_ioctl-from-32bit-fix.patch
+gregkh-usb-usb-storage-blacklist-entry-removal.patch
+gregkh-usb-usb-pxa27x-update-01.patch
+gregkh-usb-usb-pxa27x-update-02.patch
+gregkh-usb-usb-cp2101-new-id.patch
+gregkh-usb-usb-cdc-acm-ring-queue.patch
+gregkh-usb-add-new-wacom-devices-to-usb-hid-core-list.patch
+gregkh-usb-isp116x-hcd-support-reiniting-hc-on-resume.patch
+gregkh-usb-isp116x-hcd-cleanup.patch
+gregkh-usb-usb-wacom-tablet-driver-update.patch
+gregkh-usb-ehci-fix-conflation-of-buf-0-with-len-0.patch
+gregkh-usb-usb-pm-09.patch
+gregkh-usb-usb-libusual.patch

 USB tree updates

+gregkh-usb-usb-pm-09-fix.patch

 Fix it

+eagle-and-adi-930-usb-adsl-modem-driver.patch
+eagle-and-adi-930-usb-adsl-modem-driver-tidies.patch

 USB modem driver

+x86_64-reboot-loop.patch
+x86_64-remove-stepping-b-opts.patch
+x86_64-remove-rwsem.patch
+x86_64-fix-find-bit.patch
+x86_64-max-alignment.patch
+x86_64-time64.patch
+x86_64-numa-kconfig.patch
+x86_64-mce-intel.patch
+x86_64-node-range.patch
+x86_64-remove-checking.patch

 x86_64 tree updates

+dma32-change-zones_shift-back-to-2.patch
+dma32-change-zones_shift-back-to-2-gfp_zonemask-too.patch

 Fix it

+x86_64-register-disabled-processors.patch
+x86_64-enable_pagefaulttrace-warning-fix.patch

 x86_64 fixes

-touchkit-ps-2-touchscreen-driver-fixes.patch

 Folded into touchkit-ps-2-touchscreen-driver.patch

+mm-zap_block-causes-redundant-work.patch
+mm-zap_block-causes-redundant-work-warning-fix.patch
+slab-dont-bug-on-duplicated-cache.patch
+mm-rename-kmem_cache_s-to-kmem_cache.patch
+slab-use-same-schedule-timeout-for-all-cpus-in-cache_reap.patch

 Memory management updates

+add-notification-of-page-becoming-writable-to-vma-ops.patch

 Might be needed for ntfs as well as cachefs

+swap-migration-v5-lru-operations.patch
+swap-migration-v5-lru-operations-tweaks.patch
+swap-migration-v5-pf_swapwrite-to-allow-writing-to-swap.patch
+swap-migration-v5-migrate_pages-function.patch
+swap-migration-add-config_migration-for-page-migration-support.patch
+swap-migration-v5-mpol_mf_move-interface.patch
+swap-migration-v5-sys_migrate_pages-interface.patch
+swap-migration-v5-sys_migrate_pages-interface-update.patch

 page migration via swap

-ppp_mppe-add-ppp-mppe-encryption-module.patch
-ppp_mppe-add-ppp-mppe-encryption-module-update.patch
-ppp_mppe-add-ppp-mppe-encryption-module-author-address-change.patch

 Folded into ppp-handle-misaligned-accesses-2.patch

+the-second-param-of-addrconf_ifdown-in-function-addrconf_notify.patch
+irda-donauboe-locking-fix.patch
+SIOCGIFCONF-data-corruption-in-ia32-emulation.patch
+ppp_mppe-add-ppp-mppe-encryption-module.patch

 net fixes

+dgrs-fixes-warnings-when-config_isa-and-config_pci-are-not-enabled.patch

-3c59x-support-ethtool_gpermaddr-fix.patch

 Folded into 3c59x-support-ethtool_gpermaddr.patch

+ppc32-add-watchdog-rtc-support-for-marvell-ev64360bp-board.patch
+ppc32-allow-erpn-for-early-serial-to-depend-on-cpu-type.patch
+ppc32-dump-error-status-for-both-plb-segments-on-440sp.patch
+ppc32-add-440spe-support.patch
+ppc32-add-yucca-440spe-eval-board-platform.patch
+ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot.patch
+ppc32-remove-internal-pci-arbiter-check-on-ppc40x.patch
+ppc32-add-missing-initrd-header-on-ppc440.patch
+ppc32-add-cpm1-config-option.patch

 ppc32 updates

+sh-re-add-sh-to-drivers-makefile.patch
+sh-drop-deprecated-support-for-custom-ramdisk-embedding.patch
+superhyway-multiple-block-support-and-vcr-rework.patch
+sh-superhyway-support-for-sh4-202.patch
+sh-pte_mkhuge-compile-fix-for-config_hugetlb_page.patch
+sh-drop-hp690-discontig-support.patch
+sh-use-pfn_valid-for-lazy-dcache-write-back-on-sh7705.patch

 SuperH updates

+arch-i386-use-array_size-macro.patch

 cleanup

-x86-cache-pollution-aware-__copy_from_user_ll-tidy.patch
-x86-cache-pollution-aware-__copy_from_user_ll-build-fix.patch
-x86-cache-pollution-aware-__copy_from_user_ll-build-fix-2.patch

 Folded into x86-cache-pollution-aware-__copy_from_user_ll.patch

+i386-lvt-entries-remaining-unmasked-on-reboot.patch
+arch-i386-kernel-ldtc-should-include-asm-mmu_contexth.patch
+arch-i386-kernel-reboot_fixupsc-should-include-linux-reboot_fixupsh.patch
+arch-i386-kernel-scx200c-should-include-linux-scx200_gpioh.patch

 i386 updates

-wistron-laptop-button-driver-x86_64-fix.patch

 Folded into wistron-laptop-button-driver.patch

-x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is-fix.patch

 Folded into x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is.patch

+x86_64-fix-single-step-handling-for-32bit-processes.patch

 x86_64 single-step fix

+arm-sema_count-removal.patch

 arm cleanup

+cpu-hoptlug-avoid-usage-of-smp_processor_id-in-preemptible-code.patch

 More cpu hotplug locking fixing

+suspend-to-ram-update-docs.patch

 s2r docs

+swsusp-remove-unused-variable.patch

 cleanup

+cris-printk-duplicate-declaration.patch
+cris-extern-inline-static-inline.patch

 cris architecture

+uml-improve-stub-debugging.patch
+uml-fix-syscall-stubs.patch
+uml-fix-uml-network-driver-endianness-bugs.patch
+uml-separate-libc-dependent-uaccess-code.patch
+uml-separate-libc-dependent-early-initialization.patch
+uml-separate-libc-dependent-early-initialization-fix.patch
+uml-separate-libc-dependent-helper-code.patch
+uml-switch_mm-fix.patch
+uml-maintain-own-ldt-entries.patch
+uml-big-memory-fixes.patch
+uml-make-tt-mode-dependent-options-depend-on-mode_tt.patch
+uml-fix-hardcoded-zone_-constants-in-zone-setup.patch
+uml-build-host-binaries-with-the-native-host-arch-again.patch

 UML updates

+include-asm-v850-extern-inline-static-inline.patch

 cleanup

+xtensa-struct-semaphoresleepers-initialization.patch

 xtense fix

+s390-signal-delivery.patch
+s390-stop_hz_timer-vs-xtime-updates.patch
+s390-documentation-update.patch
+s390-memory-query-wait-psw.patch
+s390-ccwgroup-online-attribute.patch
+s390-remove-pagex-support.patch
+s390-test_bit-return-value.patch
+s390-dasd-diag-inline-assembly.patch
+s390-dasd-diag-with-block-sizes-512.patch
+s390-cleanup-of-include-asm-s390-vtoch.patch
+s390-duplicate-timeout-in-qdio.patch
+s390-const-pointer-uaccess.patch
+s390-fix-memory-leak-in-vmcp.patch
+s390-merge-common-parts-of-heads-and-head64s.patch

 s/390 updates

+s390-statistics-infrastructure.patch

 This is being redone

-convert-proc-devices-to-use-seq_file-interface-tidy.patch

 Folded into convert-proc-devices-to-use-seq_file-interface.patch

-new-omnikey-cardman-4040-driver-fixes.patch
-cm4040-min-fix.patch
-cm4040-fixes.patch
-cm4040-cardman-4040-driver-update.patch

 Folded into new-omnikey-cardman-4000-driver.patch

+smbfs-readdir-vs-signal-fix.patch

 Might fix an smbfs race

+process-events-connector.patch
+process-events-connector-fixes.patch

 use connector to notify of fork/exec/exit

+remove-hlist_for_each_rcu-api-convert-existing-use-to-hlist_for_each_entry_rcu.patch

 RCU API cleanup

+hfs-needs-nls.patch

 Kconfig fix

+fix-floppyc-to-store-correct-ro-rw-status-in-underlying.patch

 Don't permit `remount,rw' for readonly floppies

+schedule-obsolete-oss-drivers-for-removal.patch

 Put some OSS drivers onto death row

+ide-scsi-fails-to-call-idescsi_check_condition-for-things.patch

 ide-scsi fix

+hpet-maintainers.patch

 MAINTAINERS update

+serial-moxa-cleanup-mxser_init.patch
+serial-moxa-fix-leaks-of-struct-tty_driver.patch
+serial-moxa-fix-wrong-bug.patch

 serial driver cleanups

+fs-smbfs-requestc-turn-null-dereference-into-bug.patch

 smbfs error determinancy

+rcu-signal-handling.patch
+rcu-signal-handling-tidies.patch
+rcu-signal-handling-fixes.patch
+simpler-signal-exit-concurrency-handling.patch
+remove-get_task_struct_rcu.patch
+fix-sigstop-locking-issue.patch
+additional-catchup-rcu-signal-fixes-for-mm.patch
+additional-catchup-rcu-signal-fixes-for-mm-warning-fix.patch

 THings to do with the RCUification of signals

+tpm-fix-lack-of-driver_unregister-in-init-failcases.patch

 tpm driver cleanup/fix.  Needs more work.

+dell_rbu-adding-bios-memory-floor-support.patch

 RCU driver fix

+fuse-remove-dead-code-from-fuse_permission.patch

 cleanup

+shm_noreserve-flags-for-shmget.patch

 shm consistency

+readahead-commentary.patch

 Add comments

+ext3_readdir-use-generic-readahead.patch

 Fix ext3_readdir() (in theory - needs perfromance testing)

+add-be-le-types-without-underscores.patch

 cleanup

+small-kernel_stath-cleanup.patch

 cleanup

+keys-remove-incorrect-and-obsolete-operators.patch

 key management fixes

+aio-remove-aio_max_nr-accounting-race.patch

 AIO race fix

+futex_wake_op-enhanced-error-handling.patch

 FUTEX error return generalisation

+only-disallow-_setting_-of-function-key-string.patch

 Fix the recent security fix

+quota-small-cleanups.patch

 Cleanups

+v9fs-names_cache-memory-leak.patch
+v9fs-names_cache-memory-leak-fix.patch

 Fix a leak

+smbfs-names_cache-memory-leak.patch

 And another

+radix-tree-code-consolidation.patch
+radix_tree-early-termination-of-tag-clearing.patch
+radix-tree-reduce-tree-height-upon-partial-truncation.patch

 Radix tree tweaking

+__find_get_block_slow-cleanup.patch

 Cleanup

+kconfig-fix-kconfig-performance-bug.patch
+kconfig-preset-config-during-allconfig.patch
+kconfig-allow-variable-argumnts-for-range.patch
+kconfig-update-kconfig-makefile.patch
+kconfig-use-gperf-for-kconfig-keywords.patch
+kconfig-simplify-symbol-type-parsing.patch
+kconfig-improve-error-handling-in-the-parser.patch
+kconfig-stricter-error-checking-for-config.patch

 Kconfig core updates

+hfsplus-dont-modify-journaled-volume.patch

 hfsplus paranoia (lots of people seem to hate this)

+perform-maintenance-on-documentation-vm-hugetlbpagetxt.patch

 Documentation updates

+memory-leak-in-dentry_open.patch

 Memory leak

+slob-introduce-mm-utilc-for-shared-functions.patch
+slob-introduce-the-slob-allocator.patch
+slob-introduce-the-slob-allocator-fixes.patch

 Simple replacement for the slab allocator

+cpuset-better-bitmap-remap-defaults.patch
+cpuset-rebind-numa-vma-mempolicy.patch
+cpuset-rebind-numa-vma-mempolicy-fix.patch
+cpuset-change-marker-for-relative-numbering.patch
+cpuset-mempolicy-one-more-nodemask-conversion.patch
+cpuset-memory-pressure-meter.patch
+cpuset-memory-pressure-meter-gcc-295-fix.patch

 cpuset updates

+fix-remaining-missing-includes.patch
+dont-include-schedh-from-moduleh.patch

 include file decoupling

+new-driver-synclink_gt.patch
+new-driver-synclink_gt-header.patch
+new-driver-synclink_gt-kconfig.patch
+new-driver-synclink_gt-makefile.patch

 synclink_gt serial/hdlc driver (needs more review, and an update)

+gregkh-pci-pci-driver-owner-removal-synclink_gt-fix.patch

 Fix it for pci tree API changes

+changing-config_localversion-rebuilds-too-much-for-no-good-reason.patch
+changing-config_localversion-rebuilds-too-much-for-no-good-reason-ipw2200-fix.patch

 Nuke lots of version.h includes

+irq-type-flags.patch

 irq core update

+max1619-build-fix.patch

 Maybe fix broken hwmon driver

+befs-use-generic_ro_fops.patch
+vxfs-use-generic_ro_fops.patch
+afs-use-generic_ro_fops.patch
+cifs-read-write-operation-fixes-and-cleanups.patch
+remove-superflous-ctime-mtime-updates-in-affs.patch
+add-a-vfs_permission-helper.patch
+add-support-for-vectored-and-async-i-o-to-all-simple-filesystems.patch
+add-a-file_permission-helper.patch
+add-vfs_-helpers-for-xattr-operations.patch
+move-xattr-permission-checks-into-the-vfs.patch
+remove-jfs-xattr-permission-checks.patch
+remove-ext2-xattr-permission-checks.patch
+remove-ext2-xattr-permission-checks-warning-fixes.patch
+remove-ext3-xattr-permission-checks.patch
+remove-reiserfs-xattr-permission-checks.patch
+remove-xfs-xattr-permission-checks.patch
+remove-xfs-xattr-permission-checks-warning-fixes.patch
+replace-inode_update_time-with-file_update_time.patch
+replace-inode_update_time-with-file_update_time-switch-ntfs-to-touch_atime.patch
+switch-autofs4-to-touch_atime.patch
+ocfs-update-atime-borkage.patch
+remove-update_atime.patch
+sanitize-lookup_hash-prototype.patch

 Various fixes, cleanups and infrastructure work in filesystems.

+consolidate-sys_ptrace.patch
+consolidate-sys_ptrace-x86_64-fix.patch

 Cleanup

+re-add-tiocstart-and-tiocstop-compat_ioctl-handlers.patch
+remove-ioctl32_handler_t.patch
+move-some-compatible_ioctl-entries-from-x86_64-to-common-code.patch
+add-compat_ioctl-methods-to-dasd.patch
+switch-fs3270-to-compat_ioctl.patch
+remove-tiocgserial-tiocsserial-compat_ioctl-entries-for-390.patch
+compat_ioctl-for-390-tape_char.patch

 ioctl cleanups

+workaround-for-pnp-device-interrupt.patch

 PNP fix

+vfs-pass-file-pointer-to-filesystem-from-ftruncate.patch
+fuse-bump-interface-minor-version.patch
+fuse-add-access-call.patch
+fuse-atomic-createopen.patch
+fuse-pass-file-handle-in-setattr.patch

 FUSE updates

+ktimers-kt2-export-mktime.patch

 Fix ktimers-kt2.patch

+implement-kmap_atomic_irqsave.patch
+edac-core-edac-support-code-edac_mc_scrub_block-kunmap_atomic-fix.patch
+edac-core-edac-support-code-edac_mc_scrub_block-kunmap_atomic-fix-2.patch
+edac-core-edac-support-code-remove-proc_ent.patch
+edac-core-edac-support-code-missing-pci-dependencies.patch
+edac-core-edac-support-edac-help-text.patch

 EDAC driver fixes

-as-cooperating-processes-cant-spel.patch
-as-tidy.patch

 Folded into as-cooperating-processes.patch

+ipmi-use-refcount-in-message-handler-avoid-list_for_each_safe_rcu.patch

Fix ipmi-use-refcount-in-message-handler.patch

+ipmi-add-timer-thread-use-kthread-api.patch

 Cleanup ipmi-add-timer-thread.patch

+ipmi-use-rcu-lock-for-using-command-receivers.patch
+ipmi-fix-watchdog-timeout-panic-handling.patch

 More IPMI updates

+kprobes-use-rcu-for-unregister-synchronization-base-changes-vs-remove-hlist_for_each_rcu-api-convert-existing-use-to-hlist_for_each_entry_rcu.patch

 Fix kprobes-use-rcu-for-unregister-synchronization-base-changes.patch

+kprobes-preempt_disable-enable-simplification.patch

 Cleanup

+dlm-build-fix-2.patch

 Fix dlm-build.patch come more

+dvb-dst-correcty-identify-tuner-and-daughterboards.patch
+dvb-add-support-for-technotrend-budget-card-s1500.patch
+dvb-stv0299-revert-improper-method.patch
+dvb-add-atsc-support-for-dvico-fusionhdtv5-lite.patch
+dvb-tda1004x-pll-communication-fixes.patch
+dvb-pluto2-removed-unavoidable-error-message-and.patch
+dvb-remove-duplicate-key-definitions.patch
+dvb-microtune-mt7202dtf-fix-charge-pump-setting.patch
+dvb-dst-asn1-length-field-fix.patch
+dvb-fix-sparse-warnings.patch
+dvb-dst-fix-memory-leaks.patch
+dvb-dst-fix-broken-support-for-vp-3040-ts204.patch
+dvb-dst-fix-dst-dvb-s-get_frequency.patch
+dvb-dst-remove-redundant-checksum-calculation.patch
+dvb-dst-fix-possible-buffer-overflow.patch
+dvb-fix-integer-overflow-bug.patch
+dvb-let-other-frontends-support-fe_dishnetwork_send_legacy_cmd.patch
+dvb-remove-broken-stv0299-enhanced-tuning-code.patch
+dvb-remove-debug_lockloss-stuff.patch
+dvb-add-support-for-air2pc-airstar-2-atsc-3rd-generation.patch
+dvb-updated-documentation.patch
+dvb-updated-documentation-for-fusionhdtv-lite-cards.patch
+dvb-dst-protect-the-read-write-commands-with-a-mutex.patch
+dvb-dst-protect-dst_write_tuna-from-simultaneous.patch
+dvb-add-support-for-plls-used-by-nxt200x.patch
+dvb-nebula-nxt6000-requires-fe-reset.patch
+dvb-stv0299-reduce-i2c-xfer-and-set-register-0x12.patch
+dvb-fixed-inittab-register-0x12-for-bsru6-bsbe1.patch
+dvb-add-nxt200x-frontend-module.patch
+dvb-nxt200x-check-callback-fix.patch
+dvb-nxt200x-remove-null-check-before-kfree.patch
+dvb-determine-tuner-write-method-based-on-nxt-chip.patch
+dvb-fix-bug-in-demux-that-caused-lost-mpeg-sections.patch
+dvb-remove-status-check-from-nxt200x_readreg_multibyte.patch
+dvb-add-support-for-the-artec-t1-usb20-box.patch
+dvb-documentation-updates-for-hybrid-v4l-dvb-cards.patch
+dvb-lgdt330x-correct-qam-symbol_rate_min-for-lgdt3302.patch
+dvb-nxt200x-fix-typo-in-makefile-for-nxt200x.patch
+dvb-nxt200x-add-function-for-nxt200x-to-change-pll.patch

 DVB updates

+v4l-627-added-support-for-oem-version-of-flytv.patch
+v4l-628-added-new-avermedia-card-550.patch
+v4l-629-added-behold-tv-409-fm.patch
+v4l-630-capitalized-hex-a-f-changed-to-lowercase.patch
+v4l-631-implemented-the-v4l2-mpeg-api-for.patch
+v4l-633-climov-s-previous-patch-missing-changelog.patch
+v4l-634-implemented-tuner-set-standby-on-cx88-init.patch
+v4l-635-add-bttv-card-137-conceptronic-ctvfmi-v2.patch
+v4l-636-don-t-enable-gpioirq-until-after-card.patch
+v4l-639-added-new-card-gotview-pci-7135.patch
+v4l-640-fixed-typos.patch
+v4l-643-use-key-media-instead-of-key.patch
+v4l-644-lower-switch-from-vhf-lo-to-vhf-hi-for.patch
+v4l-645-refine-input-handling-for-manli-beholder.patch
+v4l-646-enable-dvb-support-for-dvico-fusionhdtv5.patch
+v4l-647-included-cb3-structures-on-tda8290-that.patch
+v4l-648-some-clean-up-in-cx88-tvaudio-c.patch
+v4l-649-fixed-gcc-4-0-compile-warnings-by-moving.patch
+v4l-651-fix-a-number-of-sparse-warnings.patch
+v4l-653-ts-dma-buffer-synchronization-was-inverted.patch
+v4l-655-added-support-for-the-philips-td1316-tuner.patch
+v4l-656-added-support-for-the-following-cards.patch
+v4l-657-update-documentation.patch
+v4l-660-small-fixes.patch
+v4l-663-add-new-rtd-cards.patch
+v4l-664-improved-coding-style-for-timer-settings.patch
+v4l-665-fix-for-problem-with-audio-register-setup.patch
+v4l-667-remove-some-if-0-which-doesn-t-have-any.patch
+v4l-669-added-prolink-pixelview-pv-bt878p-rev-2e.patch
+v4l-670-cardlist-update.patch
+v4l-672-fix-build-for-2-6-14.patch
+v4l-673-initial-code-for-texas-instruments.patch
+v4l-674-move-some-if-kernel-version-into-compat-h.patch
+v4l-675-tvp5150-included-on-makefile.patch
+v4l-677-increased-eeprom-dump-to-128-bytes.patch
+v4l-678-fixed-input-selection.patch
+v4l-683-some-v4l2-api-calls-implemented-on-msp3400.patch
+v4l-685-update-the-tveeprom-tuner-list-with-the.patch
+v4l-686-change-the-number-of-lines-in-the-input.patch
+v4l-687-fix-source-charset-make-symbols-utf-8.patch
+v4l-688-add-remote-for-dvb-t300-remote.patch
+v4l-689-cx88-cardlist-updated-now-it-also-includes.patch
+v4l-690-added-support-for-lifeview-flytv-platinum.patch
+v4l-691-set-if-of-tda8275-according-to-tv-norm.patch
+v4l-692-bttv-coding-style-and-card-ids.patch
+v4l-693-bttv-board-renaming.patch
+v4l-694-updated-an-entry-to-reflect-changes-on.patch
+v4l-695-added-more-pci-id.patch
+v4l-700-added-ir-for-lifeview-flytv-platinum-mini2.patch
+v4l-702-included-audio-chips-enum.patch
+v4l-703-added-new-card-prolink-pixelview-playtv.patch
+v4l-704-enable-support-for-the-ir-remote-on-compro.patch
+v4l-705-added-kworld-vstream-expertdvd.patch
+v4l-706-reindent-cx88-tvaudio-c-to-keep-coding.patch
+v4l-707-remote-for-kworld-terminator.patch
+v4l-708-full-mute-of-saa7134-on-mute-command.patch
+v4l-709-added-osprey-440-card.patch
+v4l-711-changed-pll-1-to-pll-pll-28.patch
+v4l-712-added-analog-support-for-ati-hdtv-wonder.patch
+v4l-713-corrected-settings-for-secam-l.patch
+v4l-714-fix-typo.patch
+v4l-715-enable-s-video-input-on-dvico-fusionhdtv5.patch
+v4l-716-support-for-em28xx-board-family.patch
+v4l-717-added-scripts-and-cardlist-for-em2820.patch
+v4l-718-fixed-build.patch
+v4l-719-implement-some-differences-in-video-output.patch
+v4l-720-alsa-support-for-saa7134-that-should-work.patch
+v4l-721-check-kthread-correctly.patch
+v4l-723-fix-build-for-2-6-14.patch
+v4l-725-fixed-kernel-oops-when-hotswapping-pc.patch
+v4l-727-fixed-a-bug-that-caused-some-saa7133-code.patch
+v4l-728-vidiocsfreq-and-vidiocgfreq-expect-an.patch
+v4l-729-fixed-include-when-compiling-at-kernel.patch
+v4l-739-created-make-changelog-to-make-easier-to.patch
+v4l-754-add-the-adapter-address-prefix-to-the.patch
+v4l-758-some-improvements-at-msp3400-c-from-ivtv.patch
+v4l-759-more-improvements-at-msp3400-c-from-ivtv.patch
+v4l-761-fixed-registry-value-in-em2820-i2c-c-which.patch
+v4l-762-added-support-for-the-terratec-cinergy-250.patch
+v4l-763-include-newer-i2c-id-at-linux-include.patch
+v4l-766-add-dvb-card-winfast-dtv1000-t.patch
+v4l-767-included-support-for-em2800.patch
+v4l-768-don-t-bother-gerd-with-bttv-cards-patches.patch
+v4l-771-the-wm8775-is-a-wolfson-microelectronics.patch
+v4l-773-be-sure-to-enable-video-buf-dvb-in-kernel.patch
+v4l-775-fix-build-warnings.patch
+v4l-776-added-card-75-avermedia-avertvhd-mce-a180.patch
+v4l-777-updated-script-to-function-in-new-tree.patch
+v4l-780-fixed-typo-in-module-param-description.patch
+v4l-782-ir-kbd-i2cc-updates.patch
+v4l-783-fixed-bad-em2820-remote-layout-values-set.patch
+v4l-784-several-improvement-on-i2c-ir-handling-for.patch
+v4l-786-chip-id-removed-since-it-isn-t-required.patch
+v4l-788-log-message.patch
+v4l-789-added-support-for-saa7113.patch
+v4l-790-added-support-for-terratec-cinergy-250-usb.patch
+v4l-791-codingstyle-fixes.patch
+v4l-793-remotes-for-the-cinergy-200-usb-and.patch
+v4l-794-added-asound-skyeye-bttv-card.patch
+v4l-795-new-config-option-for-tda9887-to.patch
+v4l-796-add-sknet-monster-tv-mobile-card.patch
+v4l-797-more-intellect-on-clearing-in-bits-on-irq.patch
+v4l-798-this-patch-adds-the-vidioc-log-status-to.patch
+v4l-799-don-t-request-gpint-on-avermedia-tv.patch
+v4l-800-whitespace-cleanups.patch
+v4l-801-whitespaces-cleanups.patch
+v4l-802-replaced-kmalloc-kfree-with-usb-buffer.patch
+v4l-803-after-msp34xxg-reset-msp-wake-thread.patch
+v4l-806-add-support-for-tda8275a.patch
+v4l-809-some-changes-to-allow-compiling-cx88-and.patch
+v4l-810-vidioc-log-status-is-added-to-videodev2-h.patch
+v4l-811-strip-trailing-whitespaces.patch
+v4l-812-supports-the-pinnacle-pctv-110i-board.patch
+v4l-813-replaced-obsolete-video-get-drvdata-and.patch
+v4l-814-cleanup-dev-assignment.patch
+v4l-815-commented-obsoleted-stuff-at-videodev.patch
+v4l-816-added-driver-for-cirrus-logic-low-voltage.patch
+v4l-817-saa713x-keymaps-and-key-builders-were.patch
+v4l-818-cleanup-some-unnecessary-alsa-memory-de.patch
+v4l-819-added-autodetection-code-to-tda8290-to.patch
+v4l-820-fixed-log-for-tveeprom-on-em28xx-cards.patch
+v4l-821-set-tuner-type-in-vidioc-g-tuner.patch
+v4l-823-corrected-probing-code-for-tda8290.patch
+v4l-826-unify-whitespaces.patch
+v4l-829-fixed-user-mode-compiling.patch
+v4l-830-rearranged-print-order-to-present-a.patch
+v4l-833-analog-support-for-asus-p7131-dual.patch
+v4l-834-add-card-pctv-cardbus-tv-radio-ito25-rev.patch
+v4l-838-modified-settings-for-msi-vox-usb-2-0.patch
+v4l-840-fixed-settings-for-msi-vox-usb-2-0-saa7114.patch
+v4l-841-added-saa7114-initcode-for-msi-vox-usb-2-0.patch
+v4l-842-create-kconfig-files-for-cx88-and-saa7134.patch
+v4l-843-added-saa7114-support-on-i2c-address-0x42.patch
+v4l-847-fix-bug-5484-asus-digimatrix-card-doesnt.patch
+v4l-848-fixed-tda8290-autodetection.patch
+v4l-850-update-em2800-scaler-code-and-comments.patch
+v4l-851-fixed-broken-api-link-and-indentation.patch
+v4l-854-move-cx88-and-saa7134-configuration-out-of.patch
+v4l-855-improve-kconfig-user-friendliness-for.patch
+v4l-856-some-module-rename-and-small-fixes.patch
+v4l-859-fix-compilation-with-2-6-8.patch
+v4l-863-added-pinnacle-dazzle-dvc-90.patch
+v4l-864-improved-isoc-error-detection.patch
+v4l-865-fixed-bttv-to-accept-radio-devices-like.patch
+v4l-866-fix-bug-with-setting-mt2050-radio.patch
+v4l-867-correcting-fixes-to-accept-radio-devices.patch
+v4l-868-added-support-for-nxt200x-based-cards-ati.patch
+v4l-869-iso-c90-forbids-mixed-declarations-and.patch
+v4l-870-added-dvb-support-for-avermedia-avertvhd.patch
+v4l-871-fixed-bttv-to-accept-radio-devices-like.patch
+v4l-873-updated-comments-for-avertvhd-a180.patch
+v4l-874-quick-and-dirty-fix-for-audc-config.patch
+v4l-875-some-cleanups-at-i2c-stuff-and-fixing-when.patch
+v4l-876-moved-some-user-defines-to-be-out-of.patch
+v4l-877-module-em2820-renamed-to-em28xx-and-moved.patch
+v4l-881-video-cx88-need-not-depend-on-experimental.patch
+v4l-885-second-round-of-i2c-ids-redefinition.patch
+v4l-886-renamed-common-structures-to-em28xx.patch
+v4l-887-i2c-id-h-updated-to-reflect-the-newer.patch
+v4l-888-saa7113-renamed-to-saa711x.patch
+v4l-889-add-em28xx-to-kernel-build.patch
+v4l-890-fixed-typo.patch
+v4l-891-change-config-em28xx-to-config-video.patch
+v4l-892-correct-nicam-audio-settings-to-match.patch
+v4l-893-rollback-recent-i2c-change-to-solve-tuner.patch
+v4l-894-work-around-to-allow-hybrid-dvb-card-to.patch
+v4l-895-new-avermedia-303-card-without-radio.patch
+v4l-896-rename-bttv_foo-bttv_board_foo.patch
+v4l-897-saa7146-fix.patch
+v4l-898-em2820-i2c-fix.patch
+v4l-899-remove-media-id-h.patch

 v4l updates

+prevent-dmesg-warning-in-zr36067-driver.patch

 Kill noisy printk

-knfsd-allow-run-time-selection-of-nfs-versions-to-export-fix.patch

 Folded into knfsd-allow-run-time-selection-of-nfs-versions-to-export.patch

+knfsd-make-sure-svc_process-call-the-correct-pg_authenticate-for-multi-service-port.patch

 knfsd fix

+optimize-activate_task.patch

 CPU scheduler tweak

-sched-correct_smp_nice_bias-fix.patch

 Folded into sched-correct_smp_nice_bias.patch

-sched-disable-preempt-in-idle-tasks-2-fix.patch
-sched-disable-preempt-in-idle-tasks-2-mips-fix.patch

 Folded into sched-disable-preempt-in-idle-tasks-2.patch

+sched-disable-preempt-in-idle-tasks-2-powerpc-fixes.patch

 And fix it

+sched-resched-and-cpu_idle-rework.patch
+sched-resched-and-cpu_idle-rework-warning-fix.patch

 Fix/simplify idle task handling

-m68k-introduce-task_thread_info.patch
-m68k-introduce-setup_thread_stack-end_of_stack.patch
-m68k-thread_info-header-cleanup.patch
-m68k-m68k-specific-thread_info-changes.patch
-m68k-convert-thread-flags-to-use-bit-fields.patch
-add-stack-field-to-task_struct.patch
-add-stack-field-to-task_struct-ia64-fix.patch
-rename-allocfree_thread_info-to-allocfree_thread_stack.patch
-use-end_of_stack.patch
-change-thread_info-access-to-stack.patch
-use-task_thread_info.patch

 Dropped - the powerpc changes broke these and they probably need some
 separating out anyway.

+reiser4-big-update-update_atime-fixes.patch
+reiser4_releasepage-gfp_t-fixes.patch

 Fix reiser4 for other patches in -mm.

-rocketpoint-1520-fails-clock-stabilization-fix.patch

 Folded inro rocketpoint-1520-fails-clock-stabilization.patch

+drivers-ide-possible-cleanups.patch

 Cleanups

+ide-promise-flushing-hang-fix.patch

 Fix an IDE hang.  Needs more work.

-nvidiafb-fix-mode-setting-ppc-support-fix.patch

 Folded into nvidiafb-fix-mode-setting-ppc-support.patch

+nvidiafb-fix-mode-setting-ppc-support-warning-fixes.patch

 Fix it.

+fbdev-rearrange-mode-database-entries.patch
+fbdev-add-helper-to-get-an-appropriate-initial-mode.patch
+fbdev-convert-a-few-drivers-to-use-the-fb_find_best_display.patch
+fbdev-ati-rn50-pci-id.patch

 fbdev updates

+md-remove-attempt-to-use-dynamic-names-in-sysfs-for-component-devices-on-an-md-array.patch
+md-allow-md-arrays-to-be-started-read-only-module-parameter.patch
+md-make-sure-block-link-in-sys-md-goes-to-correct-devices.patch
+md-make-manual-repair-work-for-raid1.patch
+md-make-sure-a-user-request-sync-of-raid5-ignores-intent-bitmap.patch
+md-fix-some-locking-and-module-refcounting-issues-with-mds-use-of-sysfs.patch
+md-split-off-some-md-attributes-in-sysfs-to-a-separate-group.patch
+md-only-try-to-print-recovery-resync-status-for-personalities-that-support-recovery.patch
+md-ignore-auto-readonly-flag-for-arrays-where-it-isnt-meaningful.patch
+md-complete-conversion-of-md-to-use-kthreads.patch
+md-improve-scan_mode-and-rename-it-to-sync_action.patch
+md-document-sysfs-usage-of-md-and-make-a-couple-of-small-refinements.patch

 RAID updates

+kernel-docs-fix-kernel-doc-format-problems.patch
+vfs-update-overview-document.patch
+vfs-split-dentry-locking-documentation.patch
+ramfs-rootfs-and-initramfs-docs.patch
+kernel-doc-fix-warnings-in-vmallocc.patch

 Documentation updates

+fs-nameic-make-path_lookup_create-static.patch

 Cleanup

+unexport-phys_proc_id-and-cpu_core_id.patch
+drivers-pnp-cleanups.patch
+lib-zlib-possible-cleanups.patch

 unexport a few things

+tty-layer-buffering-revamp-sunsab-build-fix.patch
+tty-layer-buffering-revamp-stallion-rio-fixes.patch
+tty-layer-buffering-revamp-stallion-rio-fixes-fix.patch

 Fixes for the tty driver patches in -mm.

+isicom-pci-probing-added-fix-vs-gregkh-pci-pci-driver-owner-removal.patch

 Fix isicom for pci tree API change



All 908 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/patch-list

