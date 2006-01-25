Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWAYHY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWAYHY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAYHY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:24:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6349 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750753AbWAYHY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:24:26 -0500
Date: Tue, 24 Jan 2006 23:24:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc1-mm3
Message-Id: <20060124232406.50abccd1.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm3/

- Dropped the timekeeping patch series due to a complex timesource selection
  bug.

- Various fixes and updates.



Changes since 2.6.16-rc1-mm2:


 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-arm.patch
 git-audit.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-dvb.patch
 git-ia64.patch
 git-infiniband.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-parisc.patch
 git-powerpc.patch
 git-serial.patch
 git-sym2.patch
 git-pcmcia.patch
 git-sas-jg.patch
 git-watchdog.patch
 git-cryptodev.patch

 External git trees

-git-alsa-fixup.patch
-hdspm-printk-warning-fixes.patch
-pcxhr-printk-warning-fix.patch
-git-pcmcia-orinoco_cs-fix.patch
-gregkh-usb-usb-remove-misc-devfs-droppings.patch
-gregkh-usb-usb-net2280-warning-fix.patch
-gregkh-usb-add-might_sleep-to-usb_unlink_urb.patch
-gregkh-usb-usb-isp116x-hcd-replace-mdelay-by-msleep.patch
-gregkh-usb-usb-gadgetfs-set-zero-flag-for-short-control-in-response.patch
-gregkh-usb-usb-remove-linux_version_code-check-in-pwc-pwc-ctrl.c.patch
-gregkh-usb-usb-ehci-fix-gfp_t-sparse-warning.patch
-gregkh-usb-usb-drivers-usb-media-w9968cf.c-remove-hooks-for-the-vpp-module.patch
-gregkh-usb-usb-drivers-usb-media-ov511.c-remove-hooks-for-the-decomp-module.patch
-gregkh-usb-usb-remove-extra-newline-in-hid_init_reports.patch
-gregkh-usb-usb-optimise-devio.c-usbdev_read.patch
-gregkh-usb-usb-mdc800.c-to-kzalloc.patch
-gregkh-usb-usb-kzalloc-for-storage.patch
-gregkh-usb-usb-kzalloc-for-hid.patch
-gregkh-usb-usb-kzalloc-in-dabusb.patch
-gregkh-usb-usb-kzalloc-in-w9968cf.patch
-gregkh-usb-usb-kzalloc-in-usbvideo.patch
-gregkh-usb-usb-kzalloc-in-cytherm.patch
-gregkh-usb-usb-kzalloc-in-idmouse.patch
-gregkh-usb-usb-kzalloc-in-ldusb.patch
-gregkh-usb-usb-kzalloc-in-phidgetinterfacekit.patch
-gregkh-usb-usb-kzalloc-in-phidgetservo.patch
-gregkh-usb-usb-kzalloc-in-usbled.patch
-gregkh-usb-usb-kzalloc-in-sisusbvga.patch
-gregkh-usb-usb-au1xx0-replace-casual-readl-with-au_readl-in-the-drivers.patch
-gregkh-usb-usb-add-et61x51-video4linux2-driver.patch
-gregkh-usb-usb-remove-the-obsolete-usb_midi-driver.patch
-gregkh-usb-usb-drivers-usb-core-message.c-make-usb_get_string-static.patch
-gregkh-usb-usb-remove-linux_version_code-macro-usage.patch
-gregkh-usb-usb-arm26-fix-compilation-of-drivers-usb-core-message.c.patch
-gregkh-usb-usb-convert-a-bunch-of-usb-semaphores-to-mutexes.patch
-gregkh-usb-uhci-use-one-qh-per-endpoint-not-per-urb.patch
-gregkh-usb-uhci-use-dummy-tds.patch
-gregkh-usb-uhci-remove-main-list-of-urbs.patch
-gregkh-usb-uhci-improve-debugging-code.patch
-gregkh-usb-uhci-don-t-log-short-transfers.patch
-gregkh-usb-usb-uhci-no-fsbr-until-device-is-configured.patch
-gregkh-usb-usb-core-and-hcds-don-t-put_device-while-atomic.patch
-gregkh-usb-usb-serial-dynamic-id.patch
-gregkh-usb-usbip.patch
-gregkh-usb-usb-usbip-build-fix.patch
-gregkh-usb-usb-usbip-more-dead-code-fix.patch
-gregkh-usb-usb-gotemp.patch
-gregkh-usb-usb-convert-a-bunch-of-usb-semaphores-to-mutexes-fixes.patch
-usb-usbip-warning-fixes.patch
-fix-parisc-build-flush_tlb_all_local.patch
-dvb-fix-printk-format-warning.patch
-sysfs-crash-debugging.patch

 Merged

-prototypes-for-at-functions-typo-fix-fix.patch

 Folded into prototypes-for-at-functions-typo-fix.patch

+fuse-fix-async-read-for-legacy-filesystems.patch
+drivers-serial-sh-scic-add-forgotten.patch
+sound-ppc-pmacc-typo.patch
+__cpuinit-functions-wrongly-marked-__meminit.patch
+ide-scsi-fix-for-ide-probe-remove-ops-changes.patch
+powerpc-enable-irqs-for-platform-functions.patch
+tsunami_flash-fix-parse-error-before-token.patch
+lp486e-remove-slow_down_io.patch
+ipw2100-add-generic-geo-information-to-be-compliant-with-ieee80211-117-changes.patch
+move-timespec-validation-into-do_settimeofday.patch
+compat_sys_pselect7-fix.patch
+device-mapper-snapshot-load-metadata-on-creation.patch
+device-mapper-log-bitset-fix-endian.patch
+device-mapper-ioctl-reduce-pf_memalloc-usage.patch
+device-mapper-statistics-basic.patch
+device-mapper-disk-statistics-timing.patch
+device-mapper-snapshot-barriers-not-supported.patch
+dm-dm-table-warning-fix.patch
+seclvl_settime-fix.patch
+alpha-dma-mappingh-add-struct-scatterlist.patch
+ipw2200-fix-eeprom-check.patch

 Various fixes for 2.6.16-rc2.

+drivers-acpi-hotkeyc-check-kmalloc-return-value.patch

 Fixlet.

+sound-isa-cs423x-cs4236c-pnp-ids-for-netfinity-3000.patch

 New device support

+enable-xfs-write-barrier.patch

 Block barrier fix.

+gregkh-driver-drm-classdev-cleanup.patch
+gregkh-driver-ib-sysfs-cleanup.patch
+gregkh-driver-fix-userspace-interface-breakage-in-power-state.patch
+gregkh-driver-driver-core-platform_get_irq-return-enxio-on-error.patch
+gregkh-driver-handle-errors-returned-by-platform_get_irq.patch
+gregkh-driver-sysfs-crash-debugging.patch

 Driver tree updates

+drm-fix-sparse-warning-in-radeon-driver.patch
+drivers-char-drm-make-some-functions-static.patch

 DRM cleanups.

+media-video-stradis-memory-fix.patch

 Media driver fix.

+gregkh-i2c-i2c-scx200_acb-07-docs-Kconfig-fix.patch

 I2C tree update.

+mtd_nand_sharpsl-and-mtd_nand_nandsim-should-be-tristates.patch

 MTD Kconfig fix

+acenic-fix-checking-of-read_eeprom_byte-return-values.patch

 Acenic fixlet.

+bonding-fix-get_settings-error-checking.patch
+sungem-make-pm-of-phys-more-reliable-2.patch
+net-do-not-export-inet_bind_bucket_create-twice.patch
+suni-cast-arg-properly-in-sonet_setframing.patch
+dscc4-fix-dscc4_init_dummy_skb-check.patch

 Various net fixes

-backup-timer-for-uarts-that-lose-interrupts-take-3.patch

 Dropped due to rejects.

+serial-initialize-spinlock-for-port-failed-to-setup.patch
+serial-serial_txx9-driver-update.patch

 Serial driver updates

+gregkh-pci-msi-vector-targeting-abstractions-fix.patch

 PCI tree update

+fusion-update.patch
+fusion-unloading-the-driver-results-in-panic-fix.patch
+fusion-unloading-the-driver-only-set-asyn-narrow-for-configured-devices.patch
+fusion-sanity-check.patch
+drivers-message-fusion-mptfcc-make-2-functions-static.patch

 MPT-Fusion driver updates

+drivers-scsi-megaraidc-add-a-dummy-mega_create_proc_entry-for-proc_fs=y.patch

 Build fix

+gregkh-usb-usb-fix-ehci-early-handoff-issues.patch
+gregkh-usb-usb-add-et61x51-video4linux2-driver.patch
+gregkh-usb-usb-remove-misc-devfs-droppings.patch
+gregkh-usb-usb-net2280-warning-fix.patch
+gregkh-usb-add-might_sleep-to-usb_unlink_urb.patch
+gregkh-usb-usb-isp116x-hcd-replace-mdelay-by-msleep.patch
+gregkh-usb-usb-gadgetfs-set-zero-flag-for-short-control-in-response.patch
+gregkh-usb-usb-remove-linux_version_code-check-in-pwc-pwc-ctrl.c.patch
+gregkh-usb-usb-ehci-fix-gfp_t-sparse-warning.patch
+gregkh-usb-usb-drivers-usb-media-w9968cf.c-remove-hooks-for-the-vpp-module.patch
+gregkh-usb-usb-drivers-usb-media-ov511.c-remove-hooks-for-the-decomp-module.patch
+gregkh-usb-usb-remove-extra-newline-in-hid_init_reports.patch
+gregkh-usb-usb-au1xx0-replace-casual-readl-with-au_readl-in-the-drivers.patch
+gregkh-usb-usb-arm26-fix-compilation-of-drivers-usb-core-message.c.patch
+gregkh-usb-usb-optimise-devio.c-usbdev_read.patch

 USB tree updates

+gregkh-usb-usb-fix-ehci-early-handoff-issues-warning-fix.patch

 Fix it.

+x86_64-hotadd-pud.patch
+x86_64-tune-generic.patch
+x86_64-swiotlb-dma32.patch
+x86_64-copy-memset-revert.patch
+x86_64-fix-the-node-cpumask-of-a-cpu-going-down.patch
+x86_64-remove-config-init-debug.patch
+x86_64-edac-default.patch
+x86_64-mempolicy-hpage.patch
+x86_64-srat-clear-node.patch
+x86_64-clock-compat.patch

 x86_64 updates

+zone_reclaim-reclaim-on-memory-only-node-support-fix.patch
+zone_reclaim-reclaim-on-memory-only-node-support-fix-tidy.patch
+zone_reclaim-minor-fixes.patch
+use-32-bit-division-in-slab_put_obj.patch
+mm-hugepage-accounting-fix.patch
+zone_reclaim-do-not-unmap-file-backed-pages.patch
+direct-migration-v9-avoid-writeback--page_migrate-method-remove-unused-export-for-migrate_pages-and-isolate_lru_page.patch
+slab-fix-kzalloc-and-kstrdup-caller-report-for-config_debug_slab.patch
+mm-slab-add-kernel-doc-for-one-function.patch
+slab-fix-sparse-warning.patch
+mm-never-clearpagelru-released-pages.patch
+mm-never-clearpagelru-released-pages-tidy.patch
+mm-pagelru-no-testset.patch
+mm-pageactive-no-testset.patch
+mm-less-atomic-ops.patch
+mm-simplify-vmscan-vs-release-refcounting.patch
+mm-de-skew-page-refcounting.patch
+xtensa-pgtable-fixes.patch
+mm-split-highorder-pages.patch
+mm-page_state-comment-more.patch
+mm-cleanup-bootmem.patch

 mm updates

-produce-useful-info-for-kzalloc-with-debug_slab.patch

 Dropped

+selinux-remove-security-struct-magic-number-fields.patch

 SELinux fix

+bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm-fix.patch

 Fix bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm.patch

+powerpc-fix-for-kexec-ppc32.patch
+modalias=-for-macio.patch
+powerpc-fix-sigmask-handling-in-sys_sigsuspend.patch

 powerpc updates

+arch-sh64-kernel-timec-add-moduleh.patch

 sh64 build fix

+fix-value-computed-is-not-used-compile-warnings-with-gcc-41.patch

 Warning fix

+x86-smp-alternatives.patch
+x86-smp-alternatives-tidy.patch

 Runtime-patching of the kernel for UP-vs-SMP.

-allow-users-to-force-a-panic-on-nmi.patch

 Dropped.

+swsusp-use-bytes-as-image-size-units.patch
+swsusp-documentation-updates.patch
+suspend-to-ram-allow-video-options-to-be-set-at-runtime.patch
+suspend-to-ram-allow-video-options-to-be-set-at-runtime-fix.patch

 swsusp updates

+uml-add-a-build-dependency.patch
+uml-fix-some-typos.patch

 UML updates

+s390-new-default-configuration.patch
+s390-add-support-for-new-syscalls-tif_restore_sigmask.patch
+s390-fix-modalias-for-ccw-devices.patch
+s390-add-missing-memory-constraint-to-stcrw.patch

 s390 updates

+oss-semaphore-to-mutex-conversion.patch

 Mutex conversion

+tpm-tpm-bios-fix-module-license-issue.patch
+tpm-tpm_bios-fix-sparse-warnings.patch
+tpm-tpm_bios-remove-unused-variable.patch

 TPM fixes

+ufs-fix-oops-with-ufs1-type.patch
+ufs-fix-mount-time-hang.patch
+make-struct-d_cookie-dependable-on-config_profiling.patch
+rio-cleanups.patch
+fix-some-uclinux-breakage-from-the-tty-updates.patch
+oprofile-fixed-x86_64-incorrect-kernel-call-graphs.patch
+edac-config-cleanup.patch
+fix-char-vs-__s8-clash-in-ufs.patch
+fix-two-ext-uninitialized-warnings.patch
+umem-check-pci_set_dma_mask-return-value-correctly.patch
+drivers-isdn-sc-ioctlc-copy_from_user-size-fix.patch
+fs-jffs-intrepc-255-is-unsigned-char.patch
+parport-add-parallel-port-support-for-sgi-o2.patch
+v9fs-symlink-support-fixes.patch
+v9fs-v9fs_put_str-fix.patch
+v9fs-fix-corner-cases-when-flushing-request.patch
+normalize-timespec-for-negative-values-in-ns_to_timespec.patch
+devpts-use-lib-parserc-for-parsing-mount-options.patch
+parport-fix-documentation.patch
+parport-remove-dead-address-in-maintainers.patch
+kernel-rcupdatec-make-two-structs-static.patch
+fs-filec-drop-insane-header-dependencies.patch
+cpuset-fix-sparse-warning.patch
+edac-use-c99-initializers-sparse-warnings.patch
+disable-per-cpu-intr-in-proc-stat.patch
+x86-x86_64-ia64-unify-mapping-from-pxm-to-node-id.patch
+x86-x86_64-ia64-unify-mapping-from-pxm-to-node-id-fix.patch
+atomic-add_unless-cmpxchg-optimise.patch
+ext2-print-xip-mount-option-in-ext2_show_options.patch
+fix-o_direct-read-of-last-block-in-a-sparse-file.patch
+i2o-dont-disable-pci-device-if-it-is-enabled-before.patch
+i2o-fix-and-workaround-for-motorola-freescale-controller.patch
+fcntl-f_setfl-and-read-only-is_append-files.patch
+get_empty_filp-tweaks-inline-epoll_init_file.patch
+reduce-size-of-percpudata-and-make-sure-per_cpuobject.patch
+jsm-update-for-tty-buffering-revamp.patch
+quota-remove-unused-sync_dquots_dev.patch
+lib-fix-bug-in-int_sqrt-for-64-bit-longs.patch
+fs-use-array_size-macro.patch
+gusclassic-fix-adding-second-dma-channel.patch
+opl3sa2-fix-adding-second-dma-channel.patch
+ixj-fix-writing-silence-check.patch

 Misc.

-time-reduced-ntp-rework-part-1.patch
-time-reduced-ntp-rework-part-2.patch
-time-reduced-ntp-rework-part-2-fix.patch
-time-clocksource-infrastructure.patch
-time-generic-timekeeping-infrastructure.patch
-time-generic-timekeeping-infrastructure-use-generic-timeofday-interfaces-in-hrtimer--ktime.patch
-time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
-time-i386-conversion-part-2-rework-tsc-support.patch
-time-i386-conversion-part-3-enable-generic-timekeeping.patch
-time-i386-conversion-part-4-remove-old-timer_opts-code.patch
-time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change.patch
-time-i386-clocksource-drivers.patch
-time-fix-cpu-frequency-detection.patch
-time-fix-cpu-frequency-detection-fix.patch
-time-delay-clocksource-selection-until-later-in-boot.patch
-x86-blacklist-tsc-from-systems-where-it-is-known-to-be-bad.patch

 Dropped.

-fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch

 Dropped

+reiser4-big-update-bug-fix-for-readpage.patch

 reiser4 fix

-serial-add-support-for-non-standard-xtals-to-16c950-driver.patch

 Dropped

+ide-set-latency-when-resetting-it821x-out-of-firmware-mode.patch
+ide-amd756-no-host-side-cable-detection.patch

 IDE fixes

+fbcon-fix-screen-artifacts-when-moving-cursor.patch
+vgacon-add-support-for-soft-scrollback.patch

 fbdev fixes

+device-mapper-snapshot-fix-origin_write-pending_exception-submission.patch
+device-mapper-snapshot-replace-sibling-list.patch
+device-mapper-snapshot-fix-invalidation.patch

 Post-2.6.16 devicemapper updates

+md-fix-device-size-updates-in-md.patch
+md-make-sure-array-geometry-changes-persist-with-version-1-superblocks.patch
+md-dont-remove-bitmap-from-md-array-when-switching-to-read-only.patch
+md-add-sysfs-access-to-raid6-stripe-cache-size.patch
+md-make-sure-queue_flag_cluster-is-set-properly-for-md.patch

 RAID updates

-unshare-system-call-v5-system-call-registration-for-x86_64.patch

 Drop this for now - I keep on having to redo it when I drop problematic
 x86_64 patches.

+docbook-allow-even-longer-return-types.patch
+docbook-fix-some-comments-in-drivers-scsi.patch
+docbook-fix-some-kernel-doc-comments-in-net-sunrpc.patch
+docbook-fix-some-kernel-doc-comments-in-fs-and-block.patch
+doc-kernel-doc-add-more-usage-info.patch
+kernel-doc-clean-up-the-script-whitespace.patch

 docbook updates

+debug-shared-irqs-fix-2.patch

 Fix debug-shared-irqs.patch



All 874 patches:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm3/patch-list


