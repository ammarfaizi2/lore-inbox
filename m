Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVJPWlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVJPWlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 18:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVJPWlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 18:41:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932073AbVJPWlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 18:41:45 -0400
Date: Sun, 16 Oct 2005 15:41:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc4-mm1
Message-Id: <20051016154108.25735ee3.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/

- Lots of i2c, PCI and USB updates

- Large input layer update to convert it all to dynamic input_dev allocation

- Significant x86_64 updates

- MD updates

- Lots of core memory management scalability rework




Changes since 2.6.14-rc2-mm2:


 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-cifs.patch
 git-cpufreq.patch
 git-cryptodev.patch
 git-drm.patch
 git-ia64.patch
 git-audit.patch
 git-jfs.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-scsi-misc.patch
 git-sas.patch

 External trees

-fix-pgdat_list-connection-in-init_bootmem.patch
-x86_64-fix-the-bp-node_to_cpumask.patch
-x86_64-numa-node-topology-fix.patch
-make-if_etherh-compile-with-config_sysctl=n.patch
-x86-x86_64-cpuid-workaround-for-intel-cpu.patch
-aio-lock-around-kiocbtrykick.patch
-aio-remove-unlocked-task_list-test-and-resulting-race.patch
-aio-avoid-extra-aio_readwrite-call-when-ki_left-==-0.patch
-intelfb-fix-regression-blank-display-from-ioremap-patch.patch
-s3c2410fb-minor-warning-fix.patch
-ppc64-smu-driver-locking-mistake.patch
-x86-hw_irqh-warning-fix.patch
-v4l-dvico-fusionhdtv5-lite-gpio-fix.patch
-uml-fix-build-dependencies-with-kbuild-output.patch
-uml-fix-page-faults-in-skas3-mode.patch
-uml-clear-skas0-3-flags-when-running-in-tt-mode.patch
-uml-revert-run-mconsole-sysrq-in-process-context.patch
-uml-remove-empty-hostfs_truncate-method.patch
-fuse-check-o_direct.patch
-ioc4_serial-remove-bogus-error-message.patch
-remove-preempt_disable-from-powernow-k8.patch
-drivers-base-use-kzalloc-instead-of-kmallocmemset-gregkh-bits.patch
-net-reorder-some-hot-fields-of-struct-net_device.patch
-pci-block-config-access-during-bist.patch
-ipr-block-config-access-during-bist.patch
-sisusb-warning-fix.patch
-new-powerpc-4xx-on-chip-ethernet-controller-driver.patch
-binfmt_elf-bss-padding-fix.patch
-ehci-kexec-reboot-fix.patch
-dell_rbu-changes-in-packet-update-mechanism.patch
-maintainers-sbp2-driver-is-not-orphaned.patch
-sbp2-fix-deadlocks-and-delays-on-device-removal-rmmod.patch
-sbp2-default-to-serialize_io=1.patch
-ieee1394-reorder-activities-after-bus-reset-fixes-device-detection.patch
-ieee1394-skip-unnecessary-pause-when-scanning-config-roms.patch
-ieee1394-fix-for-debug-output.patch
-ieee1394-use-time_before.patch
-ieee1394-trivial-edits-of-a-few-comments.patch
-ieee1394-remove-superfluous-include-in-csr1212.patch
-eth1394-workaround-limitation-in-rawiso-routines.patch
-ieee1394-delete-legacy-module-aliases.patch
-ohci1394-less-noise-in-dmesg.patch
-nfsacl-solaris-vxfs-compatibility-fix.patch

 Merged

+timers-add-missing-compensation-for-hz-==-250.patch

 Timer accuracy fix

+list-add-missing-rcu_dereference-on-first-element.patch

 RCU safety in list operations

+ip6_tables-build-fix.patch

 net build fix

+svgatextmode-fix.patch

 VGA text mode fix

+fix-vpx3220-offset-issue-in-secam.patch
+fix-black-white-only-svideo-input-in-vpx3220.patch

 v4l driver fixes

+revert-orinoco-information-leakage-due-to-incorrect-padding.patch
+better-fixup-for-the-orinoco-driver.patch

  Fix orinoco more cleanly

+acpi-cleanup-u32-flags-in-spin_lock-calls.patch

 ACPI cleanup

+git-cifs-build-fix.patch

 Fix git-cifs.patch

+gregkh-driver-aoe-01.patch
+gregkh-driver-aoe-02.patch
+gregkh-driver-driver-kobject-typo.patch
+gregkh-driver-driver-porting-typo.patch
+gregkh-driver-kobject-fix-gfp-flags-type.patch
+gregkh-driver-driver-model-wakeup-01.patch
+gregkh-driver-driver-model-wakeup-02.patch
+gregkh-driver-i2o-remove-i2o_device_class.patch
+gregkh-driver-coldplug-emit-hotplug-events-from-sysfs.patch
+gregkh-driver-class_dev_child.patch
+gregkh-driver-class_device_create_api_fixup.patch
+gregkh-driver-input-remove-devfs.patch
+gregkh-driver-input-sysfs-intregration.patch
+gregkh-driver-input-convert-to-dynamic-mouse.patch
+gregkh-driver-input-convert-to-dynamic-keyboard.patch
+gregkh-driver-input-convert-to-dynamic-usb.patch
+gregkh-driver-input-convert-to-dynamic-ucb1x00-ts.patch
+gregkh-driver-input-convert-to-dynamic-touchscreen.patch
+gregkh-driver-input-convert-to-dynamic-sonypi.patch
+gregkh-driver-input-convert-to-dynamic-onetouch.patch
+gregkh-driver-input-convert-to-dynamic-misc.patch
+gregkh-driver-input-convert-to-dynamic-media.patch
+gregkh-driver-input-convert-to-dynamic-macintosh.patch
+gregkh-driver-input-convert-to-dynamic-konicawc.patch
+gregkh-driver-input-convert-to-dynamic-joystick.patch
+gregkh-driver-input-convert-to-dynamic-bluetooth.patch
+gregkh-driver-input-convert-to-dynamic-beep.patch
+gregkh-driver-input-show-sysfs-path-in-proc.patch
+gregkh-driver-input-export-input_dev-data-in-sysfs.patch

 driver tree updates

+gregkh-i2c-i2c-viapro-01.patch
+gregkh-i2c-i2c-viapro-02.patch
+gregkh-i2c-i2c-viapro-03.patch
+gregkh-i2c-i2c-viapro-04.patch
+gregkh-i2c-i2c-viapro-05.patch
+gregkh-i2c-i2c-viapro-06.patch
+gregkh-i2c-i2c-viapro-07.patch
+gregkh-i2c-i2c-viapro-08.patch
+gregkh-i2c-i2c-01.patch
+gregkh-i2c-i2c-02.patch
+gregkh-i2c-i2c-03.patch
+gregkh-i2c-i2c-04.patch
+gregkh-i2c-i2c-05.patch
+gregkh-i2c-i2c-06.patch
+gregkh-i2c-i2c-07.patch
+gregkh-i2c-i2c-08.patch
+gregkh-i2c-i2c-09.patch
+gregkh-i2c-i2c-10.patch
+gregkh-i2c-i2c-11.patch
+gregkh-i2c-i2c-12.patch
+gregkh-i2c-i2c-13.patch
+gregkh-i2c-i2c-14.patch
+gregkh-i2c-i2c-15.patch
+gregkh-i2c-i2c-16.patch
+gregkh-i2c-i2c-device-id.patch

 i2c tree updates

-use-incbin-for-config_datagz.patch

 Dropped - it broke the build

+libata-build-fix.patch

 Fix git-libata-all.patch

+e1000_intr-build-fix.patch
+git-netedv-all-s2io-build-fix.patch
+git-netdev-all-e1000-fix.patch

 Fix git-netdev-all.patch

+gregkh-pci-pci-ich6-acpi-quirk.patch
+gregkh-pci-pci-block-config-access-during-BIST-01.patch
+gregkh-pci-pci-block-config-access-during-BIST-02.patch
+gregkh-pci-pci-cleanup-need_restore-switch.patch
+gregkh-pci-pci-hotplug-enable_device-01.patch
+gregkh-pci-pci-hotplug-enable_device-02.patch
+gregkh-pci-pci-ich6-smbus-quirk.patch
+gregkh-pci-pci-ids-01.patch
+gregkh-pci-pci-ids-02.patch
+gregkh-pci-pci-ids-03.patch
+gregkh-pci-pci-rpaphp-api-fix.patch
+gregkh-pci-pci-quirk-hpd530.patch

 PCI tree updates

+areca-raid-linux-scsi-driver-update-3.patch

 Update areca-raid-linux-scsi-driver.patch

+gregkh-usb-usb-ehci-clean-shutdown.patch
+gregkh-usb-usb-ftdi-new-id.patch
+gregkh-usb-usb-rdl8150-oops-fix.patch
+gregkh-usb-usb-usb_bulk_message-handle-interrupt.patch
+gregkh-usb-usb-uhci-comment-cleanup.patch
+gregkh-usb-usb-sisusb-warning-fix.patch
+gregkh-usb-usb-gadget-file-storage-use-kthread.patch
+gregkh-usb-usb-wHubCharacteristics-fix.patch
+gregkh-usb-usb-ftdi_sio-id.patch
+gregkh-usb-usb-pegasus-id.patch
+gregkh-usb-usb-safe_serial-preprocessor-fix.patch
+gregkh-usb-usb-storage-Kconfig-note-cleanup.patch
+gregkh-usb-usb-storage-hp8200-device-detect-fix.patch
+gregkh-usb-usb-storage-shuttle_usbat-cleanups.patch
+gregkh-usb-usb-storage-unusual-01.patch
+gregkh-usb-usb-storage-unusual-02.patch
+gregkh-usb-usb-storage-unusual-03.patch
+gregkh-usb-usb-touchkit-id.patch
+gregkh-usb-usb-gadget-g_file_storage-race-fix.patch
+gregkh-usb-usb-uhci-unify-bios-handoff-code.patch

 USB tree updates

-x86_64-no-idle-tick.patch
-x86_64-nohpet.patch
-x86_64-pat-base.patch
+x86_64-vect-share.patch
+x86_64-pfn-valid-comment.patch
+x86_64-page-flags-cleanup.patch
+x86_64-dma32-iommu.patch
+x86_64-cpuinit-duplicate.patch
+x86_64-extend-model-for-family6.patch
+x86_64-aper-warn.patch
+x86_64-faster-numa-node-id.patch
+x86_64-zap-low.patch
+x86_64-physical-mask.patch
+x86_64-sections-include.patch
+x86_64-pda-extern.patch
+x86_64-swiotlb-extern.patch
+x86_64-mm-clarification.patch
+x86_64-largespinlock.patch
+x86_64-hotplug-cpus.patch
+x86_64-signal-code-segment.patch
+x86_64-acpi-return.patch
+x86_64-numa-hash-opt.patch
+x86_64-agp-new-bridges.patch
+x86_64-agp-amd64-unsupported.patch
+x86_64-agp-gart-iterator.patch
+x86_64-intel-cpuid-fixup.patch
+x86_64-aout-module.patch
+x86_64-process-indent.patch
+x86_64-reboot-irq.patch
+x86_64-numa-hash-debug.patch
-x86_64-no-idle-tick-fix.patch
-x86_64-no-idle-tick-fix-2.patch
-x86_64-mce-thresh-fix.patch
-x86_64-mce-thresh-fix-2.patch
+x86_64-vect-share-build-fix.patch

 x86_64 tree updates

+mm-tlb_finish_mmu-forget-rss-fix.patch

 Fix mm-tlb_finish_mmu-forget-rss.patch

+core-remove-pagereserved.patch

 Remove PageReserved()

+mm-copy_one_pte-inc-rss.patch
+mm-zap_pte_range-dec-rss.patch
+mm-do_swap_page-race-major.patch
+mm-do_mremap-current-mm.patch
+mm-zap_pte-out-of-line.patch
+mm-update_hiwaters-just-in-time.patch
+mm-mm_struct-hiwaters-moved.patch
+mm-ia64-use-expand_upwards.patch
+mm-init_mm-without-ptlock.patch
+mm-ptd_alloc-inline-and-out.patch
+mm-ptd_alloc-take-ptlock.patch
+mm-arches-skip-ptlock.patch
+mm-page-fault-handler-locking.patch
+mm-pte_offset_map_lock-loops.patch
+mm-flush_tlb_range-outside-ptlock.patch
+mm-unlink-vma-before-pagetables.patch
+mm-unmap_vmas-with-inner-ptlock.patch
+mm-unmap_vmas-with-inner-ptlock-fix.patch
+mm-xip_unmap-zero_page-fix.patch
+mm-rmap-with-inner-ptlock.patch
+mm-kill-check_user_page_readable.patch
+mm-follow_page-with-inner-ptlock.patch

 Mainly page_table_lock scalability improvements

+hugetlb-remove-repeated-code.patch

 hugetlb cleanup

+vmalloc_node.patch

 New version of vmalloc_node()

+mm-implement-swap-prefetching.patch
+mm-implement-swap-prefetching-default-y.patch
+mm-implement-swap-prefetching-tweaks.patch
+mm-implement-swap-prefetching-tweaks-2.patch

 Con's swap prefetching code

+implement-sys_-do_-layering-in-the-memory-policy-layer.patch
+implement-sys_-do_-layering-in-the-memory-policy-layer-tidy.patch
+remove-policy-contextualization-from-mbind.patch

 mempolicy updates

+sis900-add-wake-on-lan-support.patch

 sis900 feature work

+e1000-use-vmalloc_node.patch

 Use vmalloc_node() in e1000

+ppc32-nvram-driver-for-chrp.patch
+add-modalias-to-macio-sysfs-attributes.patch
+add-modalias-for-pmac-network-drivers.patch
+new-powerpc-4xx-on-chip-ethernet-controller-driver.patch
+add-maintainer-entry-for-the-new-powerpc-4xx-on-chip-ethernet-controller-driver.patch
+chrp_pegasos_eth-added-marvell-discovery.patch
+chrp_pegasos_eth-added-marvell-discovery-tidy.patch
+chrp_pegasos_eth-added-marvell-discovery-tidy-2.patch

 ppc32 updates

+ppc64-add-cpufreq-support-for-smu-based-g5.patch
+ppc64-support-retreiving-missing-smu-partitions.patch
+ppc64-thermal-control-for-smu-based-machines.patch
+ppc64-boot-remove-include-from-lib-zlib_inflate-inflatec.patch
+ppc64-boot-remove-include-from-include-linux-zutilh.patch
+ppc64-boot-missing-include-for-size_t.patch
+ppc64-boot-remove-zlib.patch
+ppc64-boot-remove-need-for-imagesizec.patch
+ppc64-boot-move-gunzip-function-before-use.patch
+ppc64-boot-bootfiles-depend-on-linker-script.patch
+ppc64-boot-cleanup-linker-script.patch
+ppc64-boot-use-memset-to-clear-bss.patch
+ppc64-boot-fix-typo-in-asm-comments.patch
+ppc64-boot-remove-global-initializers.patch
+ppc64-boot-make-the-zimage-relocateable.patch
+ppc64-boot-proof-that-reloc-works.patch
+ppc64-boot-print-firmware-provided-stackpointer.patch
+ppc64-ac-power-handling-broken-for-desktops.patch
+ppc64-make-dma_addr_t-64-bits.patch
+ppc64-compile-nls_cp437-and-nls_iso8859_1-into-the-kernel-in-defconfig.patch

 ppc64 updates

+es7000-platform-update-i386.patch
+i386-io_apicc-memorize-at-bootup-where-the-i8259-is-connected.patch
+i386-nmi_watchdog-merge-check_nmi_watchdog-fixes-from-x86_64.patch
+i386-move-apic-init-in-init_irqs.patch
+i386-move-apic-init-in-init_irqs-tidy.patch
+i386-kexec-on-panic-dont-shutdown-the-apics.patch
+x86-vmx-cpu-feature-detection.patch
+clean-up-mtrr-compat-ioctl-code.patch

 x86 updates

-x86_64-init-and-zap-low-address-mappings-on-demand-for-cpu-hotplug.patch
+x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is.patch
+x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is-fix.patch
+x86_64-move-apic-init-in-init_irqs-take-2.patch
+x86_64-move-apic-init-in-init_irqs-take-2-tidy.patch

 x86_64 updates

+arm-fix-bogus-cast-in-ixp2000-i-o-macro.patch
+arm-fix-ixp2x00-defconfig-nr_uarts-options.patch

 ARM fixes

+swsusp-rework-image-freeing.patch
+swsusp-move-snapshot-functionality-to-separate-file.patch
+swsusp-rework-memory-freeing-on-resume.patch

 swsusp updates

+get-rid-of-the-obsolete-tri-level-suspend-resume-callbacks.patch
+get-rid-of-the-obsolete-tri-level-suspend-resume-callbacks-sound-fix.patch

 Power management cleanups

+m32r-remove-unused-instructions.patch
+m32r-fix-if-warnings.patch
+m32r-noncache_offset-in-_port2addr.patch
+m32r-smc91x-driver-update.patch

 m32r updates

+s390-ccw-export-modalias.patch

 s390 fix

-e1000-numa-aware-allocation-of-descriptors-v2.patch

 Dropped

-pc-speaker-add-snd_silent.patch

 Dropped (compile errors due to input code changes)

+ntp-whitespace-cleanup.patch

 Clean up timer.c

+remove-timer-debug-fields-fix.patch

 Fix remove-timer-debug-fields.patch

-msi-interrupts-disallow-when-no-lapic-ioapic-support.patch

 Dropped

-hpet-disallow-zero-interrupt-frequency.patch

 Dropped

+fuse-clean-up-dead-code-related-to-nfs-exporting.patch

 FUSE cleanup

+proc-fix-of-error-path-in-proc_get_inode.patch

 procfs fix

+cpuset-cleanup.patch

 Clean up cpuset code

+ptrace-coredump-exit_group-deadlock.patch

 ptrace fix

+fs-error-case-fix-in-__generic_file_aio_read.patch

 AIO fix

+vm-remove-redundant-assignment-from-__pagevec_release_nonlru.patch
+vm-remove-unused-broken-page_pte-macros.patch

 VM cleanups

+keys-export-user-defined-keyring-operations.patch
+keys-export-user-defined-keyring-operations-update.patch
+keys-add-lsm-hooks-for-key-management.patch

 key management feature work

+ide-cd-mini-cleanup-of-casts.patch

 ide-cd.c cleanups

+cleanup-for-kernel-printkc.patch

 printk.c cleanups

+write_inode_now-write-inode-if-not-bdi_cap_no_writeback.patch

 write_inode_now() fix (I think this is wrong)

+pf_dead-cleanup.patch
+pf_dead-cleanup-fixes.patch

 PF_DEAD cleanup

+coredump_wait-cleanup.patch

 coredump_wait() cleanup

+locking-problems-while-ext3fs_debug-on.patch

 ext3 fixes

+ioc4-serial-support-mostly-cleanup.patch

 ioc4 driver cleanups

+sparse-cleanups-null-pointers-c99-struct-init.patch

 sparse fixes

+wait4-ptrace_attach-race-fix.patch

 wait4() race fix

+small-kconfig-help-text-correction-for-config_frame_pointer.patch

 Kconfig text fix

+fuse-spelling-fixes.patch
+fuse-remove-unused-define.patch

 FUSE fixlets

+added-a-receive_abort-to-the-marvell-serial-driver.patch

 Serial driver update

+fix-de_thread-vs-do_coredump-deadlock.patch

 Fix coredumping deadlock

+telecom-clock-driver-for-mpcbl0010-atca-computer-blade.patch

 New driver

+ext3-sparse-fixes.patch
+ext3-sparse-fixes-2.patch

 ext3 sparse fixes

+remove-orphaned-tiocgdev-compat-ioctl.patch

 Remove dead compat code

+jiffies_64-cleanup.patch

 time cleanup

+ext3_show_options-warning-fix.patch

 ext3 warning fix

+firmware-fix-all-kernel-doc-warnings.patch

 kenreldoc fixes

+edac-atomic-scrub-operations.patch
+edac-atomic-scrub-operations-fix.patch
+edac-drivers-for-amd-76x-and-intel-e750x-e752x.patch
+edac-drivers-for-intel-i82860-i82875.patch
+edac-drivers-for-radisys-82600.patch
+edac-drivers-for-radisys-82600-gregkh-borkage.patch
+edac-core-edac-support-code.patch
+edac-core-edac-support-code-ifdef-warnings.patch
+edac-core-edac-support-code-fixes.patch

 error detection and correction drivers

+shpchp-use-the-pci-core-for-hotplug-resource-management.patch
+shpchp-remove-redundant-display-of-pci-device-resources.patch
+shpchp-reduce-dependence-on-acpi.patch
+shpchp-detect-shpc-capability-before-doing-a-lot-of-work.patch
+shpchp-dont-save-pci-config-for-hotplug-slots-devices.patch
+shpchp-remove-redundant-data-structures.patch
+shpchp-miscellaneous-cleanups.patch
+shpchp-reduce-debug-message-verbosity.patch
+shpchp-fix-oops-at-driver-unload.patch

 hotplug driver updates

+hpet-disallow-zero-interrupt-frequency.patch
+hpet-make-frequency-calculations-32-bit-safe.patch
+hpet-fix-hpet_info-calls-from-kernel-space.patch
+hpet-fix-division-by-zero-in-hpet_info.patch
+hpet-fix-uninitialized-variable-in-hpet_register.patch
+hpet-fix-access-to-multiple-hpet-devices.patch
+hpet-remove-superfluous-indirections.patch
+hpet-simplify-initialization-message.patch

 HPET driver updates

+kprobes-rearrange-preempt_disable-enable-calls.patch
+kprobes-track-kprobe-on-a-per_cpu-basis-base-changes.patch
+kprobes-track-kprobe-on-a-per_cpu-basis-i386-changes.patch
+kprobes-track-kprobe-on-a-per_cpu-basis-ia64-changes.patch
+kprobes-track-kprobe-on-a-per_cpu-basis-ppc64-changes.patch
+kprobes-track-kprobe-on-a-per_cpu-basis-sparc64-changes.patch
+kprobes-track-kprobe-on-a-per_cpu-basis-x86_64-changes.patch
+kprobes-use-rcu-for-unregister-synchronization-base-changes.patch
+kprobes-use-rcu-for-unregister-synchronization-arch-changes.patch

 kprobes work

+knfsd-fix-setattr-on-symlink-error-return.patch
+knfsd-restore-functionality-to-read-from-file-in-proc-fs-nfsd.patch
+knfsd-allow-run-time-selection-of-nfs-versions-to-export.patch
+knfsd-allow-run-time-selection-of-nfs-versions-to-export-fix.patch
+knfsd-fix-some-minor-sign-problems-in-nfsd-xdr.patch

 knfsd updates

+sched-disable-preempt-in-idle-tasks-2-fix.patch
+sched-disable-preempt-in-idle-tasks-2-mips-fix.patch

 Fix sched-disable-preempt-in-idle-tasks-2.patch

+v4l-cleanup-cx88-fix-sparse-warnings.patch

 v4l sparse fixes

-reiser4-export-pagevec-funcs.patch

 CIFS patches export all these things now

+reiser4-big-update-spin_macros-fix.patch

 reiser4 fix

+siimage-enable-interrupts-on-adaptec-sa-1210-card.patch
+rocketpoint-1520-fails-clock-stabilization.patch

 IDE fixes

+au1100fb-use-preprocessor-instruction-for-error.patch
+nvidiafb-fix-mode-setting-ppc-support.patch
+nvidiafb-add-flat-panel-dither-support.patch
+intelfb-extend-partial-support-of-i915g-to-include-i915gm.patch
+radeonfb-prevent-spurious-recompilations.patch

 fbdev updates

+fix-dm-snapshot-tutorial-in-documentation.patch

 DM documentation

+md-initial-sysfs-support-for-md.patch
+md-extend-md-sysfs-support-to-component-devices.patch
+md-add-kobject-sysfs-support-to-raid5.patch
+md-allow-a-manual-resync-with-md.patch
+md-teach-raid5-the-difference-between-check-and-repair.patch
+md-provide-proper-rcu_dereference--rcu_assign_pointer-annotations-in-md.patch
+md-fix-ref-counting-problems-with-kobjects-in-md.patch
+md-minor-md-fixes.patch
+md-change-raid5-sysfs-attribute-to-not-create-a-new-directory.patch
+md-improvements-to-raid5-handling-of-read-errors.patch
+md-convert-faulty-and-in_sync-fields-to-bits-in-flags-field.patch
+md-make-md-on-disk-bitmaps-not-host-endian.patch
+md-support-bio_rw_barrier-for-md-raid1.patch

 RAID updates

+documentation-sparsetxt-mention-cf=-wbitwise.patch
+ksymoops-related-docs-update.patch
+doc-msi-howto-cleanups.patch
+jbd-doc-fix-some-kernel-doc-warnings.patch
+kernel-doc-fix-some-kernel-api-warnings.patch

 Documentation updates

+drivers-cdrom-kmalloc-memset-kzalloc-conversion.patch
+cpufreq-kmalloc-memset-kzalloc-conversion.patch
+drivers-dio-kmalloc-memset-kzalloc-conversion.patch
+drivers-eisa-kmalloc-memset-kzalloc-conversion.patch
+drivers-fc4-kmalloc-memset-kzalloc-conversion.patch
+drivers-firmware-kmalloc-memset-kzalloc-conversion.patch
+hwmon-kmalloc-memset-kzalloc-conversion.patch
+i2c-kmalloc-memset-kzalloc-conversion.patch
+ide-kmalloc-memset-kzalloc-conversion.patch
+ide-kmalloc-memset-kzalloc-conversion-fix.patch
+bluetooth-kmalloc-memset-kzalloc-conversion.patch

 use kzalloc()

+kfree-cleanup-drivers-scsi.patch
+kfree-cleanup-drivers-net.patch
+kfree-cleanup-net.patch
+kfree-cleanup-drivers-mtd.patch
+kfree-cleanup-drivers-char.patch
+kfree-cleanup-drivers-isdn.patch
+kfree-cleanup-drivers-s390.patch
+kfree-cleanup-drivers-media.patch
+kfree-cleanup-misc-remaining-drivers.patch
+kfree-cleanup-fs.patch
+kfree-cleanup-arch.patch
+kfree-cleanup-security.patch
+kfree-cleanup-sound.patch
+kfree-cleanup-documentation.patch

 kfree(NULL) is legal

+fs-superc-unexport-user_get_super.patch

 unexport user_get_super()

+isicom-whitespace-cleanup.patch
+isicom-type-conversion-and-variables-deletion.patch
+isicom-other-little-changes.patch
+isicom-pci-probing-added.patch
+isicom-firmware-loading.patch
+isicom-more-whitespaces-and-coding-style.patch

 isicom driver updates (needs updating)


All 862 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/patch-list


