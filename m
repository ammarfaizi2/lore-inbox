Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWDRKPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWDRKPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 06:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWDRKPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 06:15:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750911AbWDRKPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 06:15:06 -0400
Date: Tue, 18 Apr 2006 03:14:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc1-mm3
Message-Id: <20060418031423.3cbef2f7.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm3/

- The netdev development tree has been temporarily dropped.  It contains
  little except for a large e1000 update, which crashes.

- The git-sas-jg (SCSI attached storage) tree was dropped as well, due to
  failure to compile and I'm not sure that it's coming from the correct place.

- There's quite a lot here needed for 2.6.17.


Changes since 2.6.17-rc1-mm2:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-libata-all.patch
 git-mtd.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-pcmcia.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-splice-fixup.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-frv.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees

-sched-fix-interactive-task-starvation.patch
-dont-awaken-rt-tasks-on-expired-array.patch
-select-warning-fixes.patch
-fix-null-pointer-dereference-in-node_read_numastat.patch
-md-make-sure-64bit-fields-in-version-1-metadata-are-64-bit-aligned.patch
-git-arm-build-fix.patch
-gregkh-driver-sysfs-allow-sysfs-attribute-files-to-be-pollable.patch
-gregkh-driver-driver-core-safely-unbind-drivers-for-devices-not-on-a-bus.patch
-gregkh-driver-block-delay-all-uevents-until-partition-table-is-scanned.patch
-gregkh-driver-driver-core-fix-unnecessary-null-check-in-drivers-base-class.c.patch
-gregkh-driver-driver-core-driver_bind-attribute-returns-incorrect-value.patch
-gregkh-driver-pm-print-name-of-failed-suspend-function.patch
-gregkh-driver-dmi-move-dmi_scan.c-from-arch-i386-to-drivers-firmware.patch
-gregkh-i2c-rtc-ds1374-convert-tasklet-to-workqueue.patch
-gregkh-i2c-rtc-m41t00-driver-should-use-workqueue-instead-of-tasklet.patch
-gregkh-i2c-hwmon-w83792d-quiet-on-misdetection.patch
-gregkh-i2c-i2c-sis96x-remove-init-log-message.patch
-gregkh-i2c-i2c-parport-require-type-parameter.patch
-ia64-always-map-vga-framebuffer-uc-even-if-it-supports-wb.patch
-inputh-should-always-include-asm-typesh.patch
-wistron_btns-add-support-for-amilo-7400m.patch
-sata_mv-properly-print-hc-registers.patch
-b44-fix-force-mac-address-before-ifconfig-up.patch
-net-drivers-fix-section-attributes-for-gcc.patch
-remove-drivers-net-hydrah.patch
-via-rhine-execute-bounce-buffers-code-on-rhine-i-only.patch
-for_each_possible_cpu-network-codes.patch
-ebtables-fix-allocation-in-net-bridge-netfilter-ebtablesc.patch
-remove-broken-and-unmaintained-sangoma-drivers.patch
-fs-locksc-make-posix_locks_deadlock-static.patch
-gregkh-pci-msi-save-restore-for-suspend-resume.patch
-gregkh-pci-pci_ids.h-correct-naming-of-1022-7450.patch
-gregkh-pci-pci-fix-sparse-warning-about-pci_bus_flags.patch
-gregkh-pci-pci-rpaphp-remove-init-error-condition.patch
-gregkh-pci-re-arch-i386-pci-irq.c-new-via-chipsets.patch
-gregkh-pci-pci-add-pci-quirk-for-smbus-on-the-asus-a6va-notebook.patch
-gregkh-pci-dma-doc-updates.patch
-gregkh-pci-remove-kernel-power-pm.c-pm_unregister.patch
-pcmcia-remove-unneeded-forward-declarations.patch
-for_each_possible_cpu-sparc.patch
-for_each_possible_cpu-sparc64.patch
-splice-warning-fix.patch
-gregkh-usb-usb-net2282-and-net2280-software-compatibility.patch
-gregkh-usb-usb-cleanups-for-ohci-s3c2410.c.patch
-gregkh-usb-usb-ftdi_sio-add-support-for-eclo-com-to-1-wire-usb-adapter.patch
-gregkh-usb-usb-g_file_storage-set-short_not_ok-for-bulk-out-transfers.patch
-gregkh-usb-usb-g_file_storage-add-comment-about-buffer-allocation.patch
-gregkh-usb-usb-serial-converts-port-semaphore-to-mutexes.patch
-gregkh-usb-usb-pci-quirks.c-proper-prototypes.patch
-gregkh-usb-usb-input-proper-prototypes.patch
-gregkh-usb-usb-add-support-for-papouch-tmu.patch
-gregkh-usb-usb-usbtouchscreen-unified-usb-touchscreen-driver.patch
-gregkh-usb-usb-input-remove-kconfig-entries-of-old-touchscreen-drivers-in-favour-of-usbtouchscreen.patch
-gregkh-usb-usb-g_file_storage-use-module_param_array_named-macro.patch
-gregkh-usb-usb-wacom-tablet-driver-update.patch
-gregkh-usb-usb-add-new-wacom-devices-to-usb-hid-core-list.patch
-gregkh-usb-usb-pegasus-driver-bugfix.patch
-gregkh-usb-usb-drivers-usb-core-remove-unused-exports.patch
-gregkh-usb-usb-ueagle-cosmetic.patch
-gregkh-usb-usb-ueagle-support-geode.patch
-gregkh-usb-usb-ueagle-null-pointer-dereference-fix.patch
-gregkh-usb-usb-ueagle-memory-leack-fix.patch
-gregkh-usb-usb-otg-hub-support-is-optional.patch
-gregkh-usb-usb-fix-gadget_is_musbhdrc.patch
-gregkh-usb-usb-net2280-short-rx-status-fix.patch
-gregkh-usb-usb-rndis_host-whitespace-comment-updates.patch
-gregkh-usb-usb-gadgetfs-highspeed-bugfix.patch
-gregkh-usb-usb-gadget-zero-poisons-out-buffers.patch
-gregkh-usb-usb-at91-usb-driver-supend-resume-fixes.patch
-gregkh-usb-usb-usbtest-scatterlist-out-data-pattern-testing.patch
-gregkh-usb-usb-g_ether-highspeed-conformance-fix.patch
-gregkh-usb-usb-linux-usb-net2280.h-common-definitions.patch
-gregkh-usb-usb-rename-ax8817x_func-to-asix_func-and-add-utility-functions-to-reduce-bloat.patch
-gregkh-usb-usb-keyspan-remote-bugfix.patch
-gregkh-usb-usb-uhci-don-t-track-suspended-ports.patch
-gregkh-usb-hid-core.c-fix-input-irq-status-32-received-for-silvercrest-usb-keyboard.patch
-gregkh-usb-usb-s3c2410-use-clk_enable-to-ensure-48mhz-to-ohci-core.patch
-pl2303-added-support-for-otis-dku-5-clone-cable.patch
-x86_64-mm-execve-cleanup.patch
-x86_64-mm-hotadd-reserve.patch
-x86_64-mm-srat-hotadd-reserve.patch
-x86_64-mm-empty-pxm.patch
-x86_64-mm-rename-e820-mapped.patch
-x86_64-mm-e820-all-mapped.patch
-x86_64-mm-mcfg-e820.patch
-x86_64-mm-pci-bus-ifdef.patch
-x86_64-mm-clustered-check.patch
-x86_64-mm-horus-bus-0.patch
-x86_64-mm-clear-lapic.patch
-x86_64-mm-i386-modern-apic.patch
-x86_64-mm-revert-powernow-fix.patch
-x86_64-mm-powernow-fix-3.patch
-x86_64-mm-nodes-shift-dummy.patch
-x86_64-mm-mce-nmi-watchdog.patch
-x86_64-mm-i386-bigsmp-fadt.patch
-x86_64-mm-force-iret.patch
-x86_64-mm-strlen-export.patch
-x86_64-mm-hpet-return.patch
-x86_64-mm-vsmp-cache-boundary.patch
-x86_64-mm-mcfg-check-more-busses.patch
-x86_64-mm-mmconfig-error-value.patch
-x86_64-mm-hpet-drift.patch
-x86_64-mm-gs-leak.patch
-x86_64-mm-fix-config_reorder.patch
-slab-allocate-node-local-memory-for-off-slab-slabmanagement.patch
-slab-add-statistics-for-alien-cache-overflows.patch
-nommu-use-compound-page-in-slab-allocator.patch
-mm-fix-bug-in-brk.patch
-some-page-migration-fixups.patch
-overcommit-add-calculate_totalreserve_pages.patch
-overcommit-use-totalreserve_pages.patch
-overcomit-use-totalreserve_pages-for-nommu.patch
-page-flags-add-commentry-regarding-field-reservation.patch
-mm-migratec-dont-export-a-static-function.patch
-frv-define-mmu-mode-specific-syscalls-as-cond_syscall-and-clean-up-unneeded-macros.patch
-swsusp-dont-require-bigsmp.patch
-i386-print-eip-esp-last.patch
-menu-relocate-doublefault-option.patch
-mpparse-prevent-table-index-out-of-bounds.patch
-mptspec-remove-duplicate-include.patch
-i386-move-smp-option-above-subarch-selection.patch
-alpha-smp-boot-fixes.patch
-m32r-fix-cpu_possible_map-and.patch
-m32r-security-fix-of-getput_user-macros.patch
-remove-unused-prepare_to_switch-macro.patch
-m32r-remove-symbols-exported-twice.patch
-uml-tls-fixlets.patch
-add-gfp_nowait.patch
-uml-memory-hotplug-cleanups.patch
-uml-make-64-bit-cow-files-compatible-with-32-bit-ones.patch
-uml-safe-migration-path-to-the-correct-v3-cow-format.patch
-uml-fix-2-harmless-cast-warnings-for-64-bit.patch
-uml-request-format-warnings-to-gcc-for-appropriate-functions.patch
-uml-fix-format-errors.patch
-uml-fix-some-double-export-warnings.patch
-uml-fix-extern-vs-static-proto-conflict-in-tls-code.patch
-uml-fix-critical-typo-for-tt-mode.patch
-uml-support-sparse-for-userspace-files.patch
-uml-move-outside-spinlock-call-not-needing-it.patch
-uml-fix-hang-on-run_helper-failure-on-uml_net.patch
-uml-fix-failure-path-after-conversion.patch
-uml-fix-big-stack-user.patch
-uml-local_irq_save-not-local_save_flags.patch
-uml-fix-parallel-make-early-failure-on-clean-tree.patch
-uml-avoid-warnings-for-diffent-names-for-an-unsigned-quadword.patch
-s390-update-default-configuration.patch
-s390-ebdic-to-ascii-conversion-tables.patch
-s390-invalid-check-after-kzalloc.patch
-s390-wrong-return-codes-in-cio_ignore_proc_init.patch
-s390-increase-cio_trace-debug-event-size.patch
-s390-dasd-device-offline-messages.patch
-s390-fail-fast-requests-on-quiesced-devices.patch
-s390-dasd-proc-entries.patch
-s390-minor-tape-fixes.patch
-arch-s390-makefile-remove-finline-limit=10000.patch
-s390-fix-implicit-declaration-of-unlikely.patch
-hdaps-add-support-for-thinkpad-r52.patch
-configurable-nodes_shift.patch
-ext3-block-allocation-reservation-fixes-to-support.patch
-ext3-ext3-in-kernel-block-number-type-fixes.patch
-ext3-ext3-in-kernel-block-number-type-fixes-fix.patch
-no-arch-specific-strpbrk-implementations.patch
-clean-up-arch-overrides-in-linux-stringh.patch
-sync_file_range-use-unsigned-for-flags.patch
-timer-initialisation-fix.patch
-timer-initialisation-fix-tidy.patch
-the-scheduled-unexport-of-panic_timeout.patch
-s3c24xx-gpio-led-support.patch
-s3c24xx-gpio-led-support-tidy.patch
-leds-fix-ide-disk-trigger-name.patch
-leds-reorganise-kconfig.patch
-leds-re-layout-include-linux-ledsh.patch
-vfs-propagate-mnt_flags-into-do_loopback-vfsmount.patch
-build-kernel-irq-migrationc-only-if-config_generic_pending_irq-is-set.patch
-remove-sys_-prefix-of-new-syscalls-from-__nr_sys_.patch
-make-tty_insert_flip_string_flags-a-non-gpl-export.patch
-9p-handle-sget-failure.patch
-remove-extraneous-n-in-doubletalk-init-printk.patch
-reinstate-const-in-next_thread.patch
-select-dont-overflow-if-select_stack_alloc-%-sizeoflong-=-0.patch
-silence-a-const-vs-non-const-warning.patch
-kdump-proc-vmcore-size-oveflow-fix.patch
-hdaps-support-new-lenovo-machines.patch
-uniform-pollrdhup-handling-between-epoll-and-poll-select.patch
-add-cpu_relax-to-hrtimer_cancel.patch
-sys_kexec_load-naming-fixups.patch
-process-accounting-take-original-leaders-start_time-in-non-leader-exec.patch
-remove-blkmtd.patch
-ptmx-fix-duplicate-idr_remove.patch
-tty-release_dev-remove-dead-code.patch
-mpbl0010-driver-sysfs-permissions-wide-open.patch
-last-dma_xbit_mask-cleanups.patch
-last-dma_xbit_mask-cleanups-fix.patch
-docs-laptop-modetxt-source-file-build.patch
-doc-fix-mtrr-userspace-programs-to-build-cleanly.patch
-fix-memory-barrier-docs-wrt-atomic-ops.patch
-fix-memory-barrier-docs-wrt-atomic-ops-update.patch
-improve-data-dependency-memory-barrier-example-in-documentation.patch
-update-contact-info-for-geert-uytterhoeven.patch
-keys-improve-usage-of-memory-barriers-and-remove-irq-disablement.patch
-kexec-update-maintainers.patch
-parport-remove-duplicate-entry-for-netmos_9835.patch
-module-support-record-in-vermagic-ability-to-unload-a-module.patch
-kdump-enable-config_proc_vmcore-by-default.patch
-inotify-check-for-null-inode-in-inotify_d_instantiate.patch
-ipmi-fix-event-queue-limit.patch
-rtc-subsystem-ds1672-oscillator-handling.patch
-rtc-subsystem-ds1672-cleanup.patch
-rtc-subsystem-x1205-sysfs-cleanup.patch
-rtc-subsystem-whitespaces-and-error-messages-cleanup.patch
-rtc-subsystem-fix-proc-output.patch
-rtc-subsystem-rs5c372-sysfs-fix.patch
-rtc-subsystem-compact-error-messages.patch
-rtc-subsystem-sa1100-cleanup.patch
-rtc-subsystem-vr41xx-driver.patch
-rtc-subsystem-vr41xx-cleanup.patch
-fuse-fix-oops-in-fuse_send_readpages.patch
-fuse-fix-fuse_dev_poll-return-value.patch
-fuse-add-o_async-support-to-fuse-device.patch
-fuse-add-o_nonblock-support-to-fuse-device.patch
-fuse-simplify-locking.patch
-fuse-use-a-per-mount-spinlock.patch
-fuse-consolidate-device-errors.patch
-fuse-clean-up-request-accounting.patch
-fuse-account-background-requests.patch
-enable-tsc-for-amd-geode-gx-lx.patch
-isdn4linux-siemens-gigaset-drivers-code-cleanup.patch
-isdn4linux-siemens-gigaset-drivers-kconfig-correction.patch
-isdn4linux-siemens-gigaset-drivers-timer-usage.patch
-isdn4linux-siemens-gigaset-drivers-logging-usage.patch
-isdn4linux-siemens-gigaset-drivers-sysfs-usage.patch
-isdn4linux-siemens-gigaset-drivers-remove-ifnull-macros.patch
-isdn4linux-siemens-gigaset-drivers-uninline.patch
-isdn4linux-siemens-gigaset-drivers-elliminate-from_user-argument.patch
-isdn4linux-siemens-gigaset-drivers-mutex-conversion.patch
-isdn4linux-siemens-gigaset-drivers-remove-private-version-of-__skb_put.patch
-isdn4linux-siemens-gigaset-drivers-remove-forward-references.patch
-isdn4linux-siemens-gigaset-drivers-add-readme.patch
-isdn4linux-siemens-gigaset-drivers-make-some-variables-non-atomic.patch
-drivers-isdn-gigaset-commonc-small-cleanups.patch
-isdn-gigaset-commonc-fix-a-memory-leak.patch
-isdn_drv_gigaset-should-select-not-depend-on-crc_ccitt.patch
-knfsd-correct-reserved-reply-space-for-read-requests.patch
-knfsd-locks-flag-nfsv4-owned-locks.patch
-knfsd-locks-flag-nfsv4-owned-locks-cleanup.patch
-knfsd-nfsd4-wrong-error-handling-in-nfs4acl.patch
-knfsd-nfsd4-better-nfs4acl-errors.patch
-knfsd-nfsd4-fix-acl-xattr-length-return.patch
-knfsd-nfsd-oops-exporting-nonexistent-directory.patch
-knfsd-nfsd-nfsd_setuser-doesnt-really-need-to-modify-rqstp-rq_cred.patch
-knfsd-nfsd4-remove-nfsd_setuser-from-putrootfh.patch
-knfsd-nfsd4-fix-corruption-of-returned-data-when-using-64k-pages.patch
-knfsd-nfsd4-fix-corruption-on-readdir-encoding-with-64k-pages.patch
-knfsd-svcrpc-gss-dont-call-svc_take_page-unnecessarily.patch
-knfsd-svcrpc-warn-instead-of-returning-an-error-from-svc_take_page.patch
-knfsd-nfsd4-fix-laundromat-shutdown-race.patch
-knfsd-nfsd4-nfsd4_probe_callback-cleanup.patch
-knfsd-nfsd4-add-missing-rpciod_down.patch
-knfsd-nfsd4-limit-number-of-delegations-handed-out.patch
-knfsd-nfsd4-limit-number-of-delegations-handed-out-fix.patch
-knfsd-nfsd4-grant-delegations-more-frequently.patch
-video-aty-atyfb_basec-fix-an-off-by-one-error.patch
-atyfb-is-bust-on-sparc32.patch
-sparc32-vga-support.patch

 Merged into mainline or a subsystem tree.

+uml-make-64-bit-cow-files-compatible-with-32-bit-ones.patch

 UML fix

-task-make-task-list-manipulations-rcu-safe-fix.patch
-task-make-task-list-manipulations-rcu-safe-fix-fix.patch

 Folded into task-make-task-list-manipulations-rcu-safe.patch

+uml-madv_remove-fixes.patch

 UML fix

+m41t00-fix-bitmasks-when-writing-to-chip.patch

 I2C fix

+swsusp-prevent-possible-image-corruption-on-resume.patch

 swsusp fix

-acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces-fix.patch

 Folded into acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces.patch

+memory-leak-in-acpi_evaluate_integer.patch
+acpi-memory-leakages-in-drivers-acpi-thermalc.patch
+ia64-acpi_memhotplug-fix.patch
+acpi-dock-driver.patch
+acpiphp-use-new-dock-driver.patch
+acpiphp-prevent-duplicate-slot-numbers-when-no-_sun.patch

 ACPI fixes and features

+sound-fix-hang-in-mpu401_uartc.patch
+sound-fix-hang-in-mpu401_uartc-tidy.patch

 ALSA fixes

-git-audit-master.patch
+audit-deal-with-deadlocks-in-audit_free.patch
+audit-sockaddr-patch.patch
+audit-move-call-of-audit_free-into-do_exit.patch
+audit-drop-gfp_mask-in-audit_log_exit.patch
+audit-drop-task-argument-of-audit_syscall_entryexit.patch
+audit-no-need-to-wank-with-task_lock-and-pinning-task-down-in-audit_syscall_exit.patch
+audit-support-for-context-based-audit-filtering.patch
+audit-support-for-context-based-audit-filtering-2.patch
+audit-audit-inode-patch.patch
+audit-change-lspp-ipc-auditing.patch
+audit-reworked-patch-for-labels-on-user-space-messages.patch
+audit-more-user-space-subject-labels.patch
+audit-rework-of-ipc-auditing.patch
+audit-audit-filter-performance.patch

 The audit tree was turned into broken-out patches

+spi-added-spi-master-driver-for.patch

 New SPI driver

+drivers-char-drm-drm_memoryc-possible-cleanups.patch
+drm-fix-further-issues-in-drivers-char-drm-via_irqc.patch

 DRM fixes

+sparc32-vivi-fix.patch
+git-dvb-compat-build-fix.patch

 git-dvb fixes

+gregkh-i2c-w1-cleanups-fix.patch

 Fix i2c tree

+i2c-add-support-for-virtual-i2c-adapters.patch
+i2c-add-support-for-virtual-i2c-adapters-tidy.patch
+i2c-add-support-for-virtual-i2c-adapters-fix.patch
+i2c-pca954x-i2c-mux-driver.patch

 I2C virtual adapter support

+sbp2-consolidate-workarounds.patch
+sbp2-add-read_capacity-workaround-for-ipod.patch
+sbp2-make-tsb42aa9-workaround-specific-to-momobay-cx-1.patch
+sbp2-add-ability-to-override-hardwired-blacklist.patch

 ieee1394 driver updates

+kconfig-improve-config-load-save-output.patch
+kconfig-fix-config-dependencies.patch
+kconfig-remove-symbol_yesmodno.patch
+kconfig-allow-multiple-default-values-per-symbol.patch
+kconfig-allow-loading-multiple-configurations.patch
+kconfig-integrate-split-config-into-silentoldconfig.patch
+kconfig-move-kernelrelease.patch
+kconfig-add-symbol-option-config-syntax.patch
+kconfig-add-defconfig_list-module-option.patch
+kconfig-add-search-option-for-xconfig.patch
+kconfig-finer-customization-via-popup-menus.patch
+kconfig-create-links-in-info-window.patch
+kconfig-jump-to-linked-menu-prompt.patch
+kconfig-warn-about-leading-whitespace-for-menu-prompts.patch
+kconfig-remove-leading-whitespace-in-menu-prompts.patch
+config-exit-if-no-beginning-filename.patch
+make-kernelrelease-speedup.patch
+kconfig-kconfig_overwriteconfig.patch
+sane-menuconfig-colours.patch

 Kconfig system updates

+mtd-improve-parameter-parsing-for-block2mtd.patch
+mtd-improve-parameter-parsing-for-block2mtd-fix.patch

 MTD fix

+forcedeth-suggested-cleanups.patch
+bcm43xx-sysfs-code-cleanup.patch
+bcm43xx-fix-pctl-slowclock-limit-calculation.patch
+e1000-fix-media_type-phy_type-thinko.patch

 netdev updates.

+unaligned-access-in-sk_run_filter.patch

 Net fixlet.

+nfssunrpc-fix-compiler-warnings-if-config_proc_fs-config_sysctl-are-unset.patch
+nfs_show_stats-for_each_possible_cpu-not-nr_cpus.patch

 NFS fixlets.

+fix-for-serial-uart-lockup.patch
+serial-locking-cleanup.patch

 Serial fix and cleanup

+gregkh-pci-pci-msi-abstractions-and-support-for-altix.patch
+gregkh-pci-pci-per-platform-ia64_-first-last-_device_vector-definitions.patch
+gregkh-pci-pci-altix-msi-support.patch

 PCI tree updates

+gregkh-pci-pci-64-bit-resources-drivers-others-changes-amba-fix.patch

 Fix PCI tree

+gregkh-pci-acpiphp-configure-_prt-v3-cleanup.patch
+pci-pci-64-bit-resources-arch-changes-update.patch
+improve-pci-config-space-writeback.patch
+improve-pci-config-space-writeback-tidy.patch

 Various PCI updates

+revert-pci-pci-cardbus-cards-hidden-needs-pci=assign-busses-to-fix.patch

 Revert a patch which broke things.

+git-scsi-misc-scsi_kmap_atomic_sg-warning-fix.patch

 SCSI warning fix

+overrun-in-drivers-scsi-sim710c.patch
+aic7xxx-ahc_pci_write_config-fix.patch
+qla2xxx-only-free_irq-after-request_irq-succeeds.patch
+aic7xxx-deinline-large-functions-save-80k-of-text.patch
+aic7xxx-s-__inline-inline.patch
+megaraid_mmmbox-fix-a-bug-in-reset-handler.patch

 Various scsi fixes

+ftdi_sio-adds-support-for-iplus-device.patch

 USB driver device support

+bcm43-wireless-fix-printk-format-warnings.patch
+bcm43-fix-config-menu-alignment.patch

 wireless driver updates

+x86_64-mm-phys-apicid.patch
+x86_64-mm-amd-core-cpuid.patch
+x86_64-mm-amd-cpuid4.patch
+x86_64-mm-kdump-trigger-points.patch
+x86_64-mm-alternatives.patch
+x86_64-mm-pci-dma-cleanup.patch
+x86_64-mm-increase-nodemap.patch
+x86_64-mm-new-syscalls.patch
+x86_64-mm-move-doublefault.patch

 x86_64 tree updates

+x86_64-mm-alternatives-fix.patch
+x86_64-mm-hotadd-reserve-fix-fix-fix.patch

 Fix it.

+slab-page-mapping-cleanup.patch
+migration-remove-unnecessary-pageswapcache-checks.patch
+migration-remove-unnecessary-pageswapcache-checks-fix.patch
+wait_table-and-zonelist-initializing-for-memory-hotadd-change-name-of-wait_table_size.patch
+wait_table-and-zonelist-initializing-for-memory-hotadd-change-to-meminit-for-build_zonelist.patch
+wait_table-and-zonelist-initializing-for-memory-hotaddadd-return-code-for-init_current_empty_zone.patch
+wait_table-and-zonelist-initializing-for-memory-hotadd-wait_table-initialization.patch
+wait_table-and-zonelist-initializing-for-memory-hotadd-wait_table-initialization-fixes.patch
+wait_table-and-zonelist-initializing-for-memory-hotadd-update-zonelists.patch
+squash-duplicate-page_to_pfn-and-pfn_to_page.patch
+sparsemem-interaction-with-memory-add-bug-fixes.patch
+support-for-panic-at-oom.patch
+mm-fix-typos-in-comments-in-mm-oom_killc.patch
+mm-slobc-for_each_possible_cpu-not-nr_cpus.patch
+swapless-v2-try_to_unmap-rename-ignrefs-to-migration.patch
+swapless-v2-add-migration-swap-entries.patch
+swapless-v2-make-try_to_unmap-create-migration-entries.patch
+swapless-v2-rip-out-swap-portion-of-old-migration-code.patch
+swapless-v2-revise-main-migration-logic.patch
+wait-for-migrating-page-after-incr-of-page-count-under-anon_vma-lock.patch
+preserve-write-permissions-in-migration-entries.patch
+preserve-write-permissions-in-migration-entries-fix.patch
+migration_entry_wait-use-the-pte-lock-instead-of-the-anon_vma-lock.patch
+oom-kill-mm-locking-fix.patch
+mm-fix-mm_struct-reference-counting-bugs-in-mm-oom_killc.patch
+page_allocc-buddy-handling-cleanup.patch
+tightening-hugetlb-strict-accounting.patch
+slab-cleanup-kmem_getpages.patch
+slab-cleanup-kmem_getpages-fix.patch
+slab-stop-using-list_for_each.patch
+slab-stop-using-list_for_each-fix.patch
+hugetlbfs-add-kconfig-help-text.patch

 Memory management updates

+selinux-fix-mls-compatibility-off-by-one-bug.patch

 SELinux fix

+asm-i386-atomich-local_irq_save-should-be-used-instead-of-local_irq_disable.patch

 x86 fix

+x86-cpuid-and-msr-notifier-callback-section-mismatches.patch
+i386-apmc-optimization.patch

 x86 updates

+x86_64-sparsemem-does-not-need-node_mem_map.patch

 x86_64 cleanup

+swsusp-add-architecture-special-saveable-pages-support.patch
+swsusp-i386-mark-special-saveable-unsaveable-pages.patch
+swsusp-x86_64-mark-special-saveable-unsaveable-pages.patch
+swsusp-take-lowmem-reserves-into-account.patch

 swsusp updates

+m32r-fix-pt_regs-for.patch
+m32r-update-include-asm-m32r-semaphoreh.patch
+m32r-mappi3-reboot-support.patch
+m32r-remove-a-warning-of-m32r_sioc.patch
+m32r-update-switch_to-macro-for-tuning.patch

 m32r fixes

+uml-change-sigjmp_buf-to-jmp_buf.patch
+uml-__user-annotations.patch
+uml-physical-memory-map-file-fixes.patch
+uml-add-missing-__volatile__.patch

 UML updates

+fix-file-lookup-without-ref.patch

 file table locking fixes

+zlib_inflate-upgrade-library-code-to-a-recent-version.patch
+zlib_inflate-upgrade-library-code-to-a-recent-version-fix.patch

 Update the in-kernel zlib code.

+read_mapping_page-for-address-space.patch
+locks-dont-unnecessarily-fail-posix-lock-operations.patch
+locks-dont-do-unnecessary-allocations.patch
+locks-clean-up-locks_remove_posix.patch
+vfs-add-lock-owner-argument-to-flush-operation.patch
+fs-locksc-make-posix_locks_deadlock-static.patch
+fs-fix-ocfs2-warning-when-debug_fs-is-not-enabled.patch
+moduleh-updated-comments-with-a-new.patch
+voyager-no-need-to-define-bits_per_byte-when-its-already-in-typesh.patch
+apm-fix-armada-laptops-again.patch
+remove-config_parport_arc-drivers-parport-parport_arcc.patch
+doc-vm-hugetlbpage-update-2.patch
+ipmi-fix-devinit-placement.patch
+config-update-usage-help-info.patch
+fix-potential-null-pointer-deref-in-gen_init_cpio.patch
+add-poisonh-and-patch-primary-users.patch
+update-2-drivers-for-poisonh.patch
+mmput-might-sleep.patch
+fs-fat-miscc-unexport-fat_sync_bhs.patch
+open-ipmi-bt-overflow.patch
+poll-cleanups-microoptimizations.patch
+parport_pc-fix-section-mismatch-warnings-v2.patch
+ptrace-document-the-locking-rules.patch
+pnp-fix-two-messages-in-managerc.patch
+cleanup-default-value-of-sched_smt.patch
+cleanup-default-value-of-syscall_debug.patch
+cleanup-default-value-of-mtd_pcmcia_anonymous.patch
+cleanup-default-value-of-usb_isp116x_hcd-usb_sl811_hcd-and-usb_sl811_cs.patch
+cleanup-default-value-of-ip_dccp_ackvec.patch
+fix-dependencies-of-hugetlb_page_size_64k.patch
+cleanup-default-value-of-dvb_cinergyt2_enable_rc_input_device.patch
+fix-dependencies-of-w1_slave_ds2433_crc.patch
+dup-fd-error.patch
+rtc-framework-driver-for-ds1307-and-similar-rtc-chips.patch

 Misc patches

-introduce-hlist_move_head.patch
-use-hlist_move_head.patch

 Buggy, dropped.

+tpm-spacing-cleanups.patch
+tpm-reorganize-sysfs-files.patch
+tpm-chip-struct-update.patch
+tpm-return-chip-from-tpm_register_hardware.patch
+tpm-command-duration-update.patch
+tpm-new-12-sysfs-files.patch
+tpm-new-12-sysfs-files-fix.patch
+tpm-new-12-sysfs-files-fix-fix.patch
+tpm-tpm-new-12-sysfs-files-fix-fix-fix.patch
+tpm-driver-for-next-generation-tpm-chips.patch
+tpm-driver-for-next-generation-tpm-chips-fix.patch
+tpm-driver-for-next-generation-tpm-chips-fix-fix.patch
+tpm-msecs_to_jiffies-cleanups.patch
+tpm-use-clear_bit.patch
+tpm-use-clear_bit-fix.patch
+tpm-use-clear_bit-fix-fix.patch
+tpm-use-clear_bit-fix-fix-fix.patch
+tpm-use-clear_bit-fix-fix-fix-fix.patch
+tpm-tpm_infineon-updated-to-latest-interface-changes.patch
+tpm-check-mem-start-and-len.patch
+tpm-update-bios-log-code-for-12.patch
+tpm_infineon-section-fixup.patch

 TPM driver updates

+switch-kprobes-inline-functions-to-__kprobes-for-i386.patch
+switch-kprobes-inline-functions-to-__kprobes-for-x86_64.patch
+switch-kprobes-inline-functions-to-__kprobes-for-ppc64.patch
+switch-kprobes-inline-functions-to-__kprobes-for-ia64.patch
+switch-kprobes-inline-functions-to-__kprobes-for-sparc64.patch

 kprobes fixes

+sched-modify-move_tasks-to-improve-load-balancing-outcomes.patch

 CPU scheduler fix

+coredump-some-code-relocations.patch
+coredump-shutdown-current-process-first.patch
+coredump-copy_process-dont-check-signal_group_exit.patch

 More core dumping fixes

-reiser4-reget-page-mapping.patch
+fs-reiser4-misc-cleanups.patch
+reiser4-releasepage-fix.patch

 Some reiser4 tweaks.

+remove-the-obsolete-idepci_flag_force_pdc.patch
+alim15x3-uli-m-1573-south-bridge-support.patch

 IDE updates

-hpt366-fix-segfault-during-init.patch

 Dropped, wrong.

+fb-fix-section-mismatch-in-savagefb.patch
+radeonfb-section-mismatches.patch
+savagefb-fix-section-mismatch-warnings.patch
+fbdev-fix-return-error-of-fb_write.patch
+radeonfb-powerdrain-issue-on-ibm-thinkpads-and-suspend-to-d2.patch

 fbdev updates

+x86_64-ipi-calltraces.patch

 make debugging tracebacks trace back all cpus on x86_64.

+remove-redundant-null-checks-before-free-in-fs.patch
+remove-redundant-null-checks-before-free-in-net.patch
+remove-redundant-null-checks-before-free-in-arch.patch
+remove-redundant-null-checks-before-free-in-kernel.patch
+remove-redundant-null-checks-before-free-in-drivers.patch

 Cleanups




All 650 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm3/patch-list

