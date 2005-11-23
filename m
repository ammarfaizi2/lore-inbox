Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbVKWLgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbVKWLgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 06:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbVKWLgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 06:36:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19683 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965201AbVKWLgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 06:36:01 -0500
Date: Wed, 23 Nov 2005 03:35:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc2-mm1
Message-Id: <20051123033550.00d6a6e8.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/

(temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.15-rc2-mm1.gz)

- Added git-sym2.patch to the -mm lineup: updates to the sym2 scsi driver
  (Matthew Wilcox).  

- The JSM tty driver still doesn't compile.

- The git-powerpc tree is included now.



Changes since 2.6.15-rc1-mm2:


 linus.patch
 git-acpi.patch
 git-blktrace.patch
 git-cfq.patch
 git-cpufreq.patch
 git-drm.patch
 git-ieee1394.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-sas.patch
 git-cryptodev.patch

 Subsystem trees

-fix-copy-paste-bug-in-ohci-ppc-socc.patch
-add-success-failure-indication-to-rcu-torture-test.patch
-export-clear_page_dirty_for_io.patch
-ipmi-missing-null-test-for-kthread.patch
-ppc32-added-missing-define-for-fs_enet-ethernet-driver.patch
-tpm-use-flush_scheduled_work.patch
-tpm-use-ioread8-and-iowrite8.patch
-tpm-remove-pci-kconfig-dependency.patch
-md-dont-pass-null-file-into-prepare_write.patch
-md-fix-is_mddev_idle-calculation-now-that-disk-sector-accounting-happens-when-request-completes.patch
-ppc64-need-hpage_shift-when-huge-pages-disabled.patch
-s390-fix-class_device_create-calls-in-3270-the-driver.patch
-uml-eliminate-use-of-local-in-clone-stub.patch
-uml-eliminate-anonymous-union-and-clean-up-symlink-lossage.patch
-uml-properly-invoke-x86_64-system-calls.patch
-uml-eliminate-use-of-libc-page_size.patch
-unpaged-get_user_pages-vm_reserved.patch
-unpaged-private-write-vm_reserved.patch
-unpaged-sound-nopage-get_page.patch
-unpaged-unifdefed-pagecompound.patch
-unpaged-vm_unpaged.patch
-unpaged-vm_nonlinear-vm_reserved.patch
-unpaged-cow-on-vm_unpaged.patch
-unpaged-anon-in-vm_unpaged.patch
-unpaged-zero_page-in-vm_unpaged.patch
-unpaged-pg_reserved-bad_page.patch
-unpaged-copy_page_range-vma.patch
-fix-error-handling-with-put_compat_statfs.patch
-fix-hugetlbfs_statfs-reporting-of-block-limits.patch
-cpufreq-silence-warning-for-up.patch
-atkbd-speed-up-setting-leds-repeat-state.patch
-git-libata-sata_mv-build-fix.patch
-git-netdev-all-ieee80211_get_payload-warning-fix.patch
-gregkh-pci-pci-pci-error-reporting-callbacks.patch
-gregkh-pci-pci-documentation-for-pci-error-recovery.patch
-git-pcmcia-validate_mem-fix.patch
 gregkh-usb-usbcore-central-handling-for-host-controllers-that-were-reset-during-suspend-resume.patch
-x86_64-register-disabled-processors.patch
-memhotplug-memory_hotplug_name-should-be-const.patch
-SIOCGIFCONF-data-corruption-in-ia32-emulation.patch
-fix-ifenslave-to-not-fail-on-lack-of-ip-information.patch
-r8169-printk_ratelimit-fix.patch
-wistron-laptop-button-driver.patch
-prefer-pkg-config-for-the-qt-check.patch
-compat-remove-leftovers-from-register_ioctl32_conversion.patch
-add-via-vt6410-support.patch
-drivers-ide-pci-alim15x3c-replace-pci_find_device-with-pci_dev_present.patch
-drivers-ide-pci-alim15x3c-use-kern_warning.patch
-cs5520-fix-return-value-of-cs5520_init_one.patch

 Merged

+smp_call_function-must-be-a-macro.patch

 Uniprocessor build fix

+revert-floppy-fix-read-only-handling.patch

 Undo a floppy.c change

+nbd-fix-tx-rx-race-condition.patch
+nbd-fix-tx-rx-race-condition-update.patch

 NBD driver fixes

+acpi-fix-passive-thermal-management.patch
+acpi-leave-thermal-passive-cooling-when-machine-cooled-down.patch
+acpi-fix-null-deref-in-video-lcd-brightness.patch

 ACPI fixes

+mm-update-split-ptlock-kconfig.patch
+mm-unbloat-get_futex_key.patch
+mm-powerpc-ptlock-comments.patch
+mm-powerpc-init_mm-without-ptlock.patch
+mm-fill-arch-atomic64-gaps.patch

 Memory management fixes

+kprobes-fix-return-probes-on-sys_execve.patch

 kprobes fix

+fix-do_wait-vs-exec-race.patch

 Fix a race.

+fix-crash-in-unregister_console.patch

 unregister_console() robustness

+powerpc-fix-for-hugepage-areas-straddling-4gb-boundary.patch

 powerpc hugepages fix

+jffs2-debug-gcc-29x-fix.patch

 Fix jffs2 for old gcc's.

+acpi-kernel-doc-fixes-for-scanc.patch

 ACPI update

+gregkh-driver-small-fixups-to-driver-core.patch
+gregkh-driver-kill-hotplug-word-from-driver-core.patch
+gregkh-driver-hotplug-always-enabled.patch
+gregkh-driver-hold-the-device-s-parent-s-lock-during-probe-and-remove.patch

 Updates to the driver core tree

+gregkh-driver-merge-hotplug-and-uevent-vio-fix.patch
+gregkh-driver-merge-hotplug-and-uevent-macio_asic-fix.patch
+gregkh-driver-merge-hotplug-and-uevent-w9968cf-fix.patch
+kobject_uevent-config_netn-fix.patch
+gregkh-driver-kill-hotplug-word-from-driver-core-memory-fix.patch

 Fix them.

+gregkh-i2c-hwmon-fix-missing-it87-fan-div-init.patch

 i2c tree update

+small-hp_sdc_rtc-cleanup-use-no_llseek.patch

 rtc driver cleanup

+git-netdev-all-s2io-warning-fix.patch

 Fix a warning

+git-net-selinux-xfrmc-build-fix.patch

 Fix git-net.patch

+gregkh-pci-pci-remove-bogus-resource-collision-error.patch
+gregkh-pci-pcie-make-bus_id-for-pci-express-devices-unique.patch
+gregkh-pci-pci-error-recovery-header-file-patch.patch
+gregkh-pci-shot-accross-the-bow.patch

 Updates to the PCI tree

+ibmphp_pci-copy-n-paste-fix.patch

 Fix hotplug PCI driver

+git-pcmcia-dev_to_instance-fix.patch

 Fix git-pcmcia.patch

+gregkh-usb-usb-sn9c10x-driver-bad-page-state-fix.patch
+gregkh-usb-usb-ftdi_sio-new-ids-for-kobil-devices.patch
+gregkh-usb-usb-dynamic-id-01.patch
+gregkh-usb-usb-dynamic-id-02.patch
+gregkh-usb-usb-dynamic-id-03.patch
+gregkh-usb-usb-driver-owner.patch
+gregkh-usb-usb-driver-owner-removal.patch
+gregkh-usb-remove-usb-private-semaphore.patch
+gregkh-usb-disconnect-children-during-hub-unbind.patch
+gregkh-usb-usb-fix-locking-for-usb-suspend-resume.patch

 USB tree updates

+usb-iomega-umini-is-unusual.patch
+fix-usb-suspend-resume-crasher.patch

 USB fixes

+mpcore_wdtc-bogus-fpos-check.patch

 Watchdog driver fixlet

+x86_64-compat-cfi.patch
+x86_64-defconfig-update.patch
+x86_64-dont-remove-nt.patch
+x86_64-bitops-constraints.patch

 x86_64 tree update

+shrinker-nr-=-long_max-means-deadlock-for-icache.patch

 Fix probably-not-a-bug in the vm scanning code

-mm-sparse-provide-pfn_to_nid.patch

 Wrong, dropped.

+shut-up-warnings-in-ipc-shmc.patch

 Fix some warnings

+swap-migration-v5-migrate_pages-function-do-not-free-the-page-in-swap_page.patch

 Fix swap-migration-v5-migrate_pages-function.patch

+swapmig-switch-error-handling-in-migrate_pages-to-use-exx.patch

 Swap migration update

+mempolicies-private-pointer-in-check_range-and-mpol_mf_invert.patch
+fold-numa_maps-into-memopoliciesc.patch
+mempolicies-unexport-get_vma_policy.patch
+move-page-migration-related-functions-near-do_migrate_pages.patch
+flatmem-split-out-memory-model.patch
+sparsemem-provide-pfn_to_nid.patch
+mm-free_pages_and_swap_cache-opt.patch
+mm-pagealloc-opt.patch
+mm-set_page_refs-opt.patch
+mm-microopt-conditions.patch
+mm-remove-bad_range.patch
+mm-remove-pcp-low.patch
+mm-page_state-fixes.patch
+mm-page_alloc-cleanups.patch
+mm-optimize-numa-policy-handling-in-slab-allocator.patch
+mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions.patch
+slab-rename-obj_reallen-to-obj_size.patch
+slab-remove-unused-align-parameter-from-alloc_percpu.patch
+slab-extract-slabinfo-header-printing-to-separate-function.patch
+slab-extract-slab-order-calculation-to-separate-function.patch
+slab-fix-code-formatting.patch
+mm-add-is_dma_zone-helper.patch
+mm-add-populated_zone-helper.patch

 Various memory management updates

+duplicate-ipw_debug-option-for-ipw2100-and-2200.patch

 IPW driver cleanup

+tiacx-usb_driver-build-fix.patch

 Update the ACX driver for changes in the driver core tree

+x86-convert-bigsmp-to-use-flat-physical-mode.patch
+x86-make-bigsmp-the-default-mode-if-config_hotplug_cpu.patch
+fix-rebooting-on-hp-nc6120-laptop.patch

 x86 updates

+uml-arch-um-scripts-makefilerules-remove-duplicated-code.patch
+uml-fix-dynamic-linking-on-some-64-bit-distros.patch

 UML updates

+s390-atomic-primitives.patch
+s390-cms-volume-label-definitions.patch
+s390-uaccess-warnings.patch
+s390-rt_sigreturn-fix.patch
+s390-update-default-configuration.patch

 s390 updates

+use-ptrace_get_task_struct-in-various-places-fix-3.patch

 Fix use-ptrace_get_task_struct-in-various-places-2.patch some more

+fix-overflow-tests-for-compat_sys_fcntl64-locking-re-fix.patch

 Fix fix-overflow-tests-for-compat_sys_fcntl64-locking.patch

-optionally-skip-initramfs-check.patch

 Dropped - we'll use a boot option instead

+add-block_device_operationsgetgeo-block-device-method.patch
+add-block_device_operationsgetgeo-block-device-method-fix.patch
+add-block_device_operationsgetgeo-block-device-method-fix-2.patch

 blockdev layer cleanup

+nbd-remove-duplicate-assignment.patch

 ndb fixlet

+unchecked-alloc_percpu-return-in-__create_workqueue.patch

 Check alloc_per_cpu() return

+kdump-export-crash-notes-sysfs-remove-get-cpu.patch
+kdump-save-registers-early-inline-functions-fix.patch
+kdump-save-registers-early-inline-functions-fix-2.patch
+kdump-x86_64-add-elfcorehdr-command-line-option-fix.patch
+kdump-x86_64-add-elfcorehdr-command-line-option-fix-2.patch

 kdump updates

+ktimers-rounding-fix.patch

 ktimers fix

+solve-false-positive-soft-lockup-messages-during-ide-init.patch

 IDE fix

+fbdev-shift-pixel-value-before-entering-loop-in-cfbimageblit.patch
+fbcon-sanitize-fbcon.patch
+fbdev-fix-incorrect-unaligned-access-in-little-endian-machines.patch
+nvidiafb-i2c-bus-name-beautification.patch
+fbcon-store-struct-display-when-setting-all-vcs.patch
+matroxfb-remove-fbconh-from-the-main-header-file.patch
+savagefb-one-more-i2c-enabled-device-in-savagefb.patch

 fbdev updates

+device-mapper-add-dm_find_md.patch
+device-mapper-add-dm_get_md.patch
+device-mapper-ioctl-event-on-rename.patch
+device-mapper-snapshot-metadata-reading-separation.patch
+device-mapper-remove-unused-definition.patch
+device-mapper-scanf-sector-format-change.patch
+device-mapper-raid1-add-default-mirror.patch
+device-mapper-rename-frozen_bdev.patch
+device-mapper-make-lock_fs-optional.patch
+device-mapper-ioctl-add-skip-lock_fs-flag.patch

 device mapper updates

+drivers-video-possible-cleanups.patch
+fs-ext2-bitmapc-ext2_count_free-is-only-required-ifdef-ext2fs_debug.patch
+fs-ext3-small-cleanups.patch
+build-kernel-intermodulec-only-when-required.patch

 Minor fixes and cleanups




All 693 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/patch-list


