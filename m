Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVELKd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVELKd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 06:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVELKd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 06:33:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:57247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261404AbVELKbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 06:31:48 -0400
Date: Thu, 12 May 2005 03:31:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc4-mm1
Message-Id: <20050512033100.017958f6.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm1/

- Added Herbert Xu's ipsec tree to the -mm lineup, as git-ipsec.patch

- Lots of updates all over the place


Changes since 2.6.12-rc3-mm3:


-avoid-enomem-due-reclaimable-slab-caches.patch
-intel8x0-fix-for-intel-ac97-audio-driver.patch
-interwave-needs-isa-pnp.patch
-include-linux-soundcardh-endianness-fix.patch
-add-cxt48-to-modem-black-list-in-ac97.patch
-fix-make-mandocs-after-class_simplec-removal.patch
-kconfig-i18n-support.patch
-ppc32-platform-specific-functions-missing-from-kallsyms.patch
-ppc32-simplified-ppc-core-revision-report.patch
-ppc64-remove-hidden-fno-omit-frame-pointer-for-schedulec.patch
-ppc64-add-missing-kconfig-help-text.patch
-ppc64-pgtableh-and-other-header-cleanups.patch
-x86-stack-initialisation-fix.patch
-ia64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
-uml-obvious-compile-fixes-for-x86-64-subarch-and-x86-regression-fixes.patch
-uml-kludgy-compilation-fixes-for-x86-64-subarch-modules-support.patch
-x86_64-make-string-func-definition-work-as-intended.patch
-x86_64-make-string-func-definition-work-as-intended-fix.patch
-uml-kbuild-avoid-useless-rebuilds.patch
-uml-include-the-linker-script-rather-than-symlink-it.patch
-uml-use-variables-rather-than-symlinks-in-dependencies.patch
-uml-start-cross-build-support-mk_user_constants.patch
-uml-cross-build-support-mk_ptregs.patch
-uml-cross-build-support-mk_sc.patch
-uml-cross-build-support-kernel_offsets.patch
-uml-cross-build-support-mk_thread.patch
-uml-cross-build-support-mk_task-and-mk_constants.patch
-uml-fix-missing-subdir-in-x86_64.patch
-uml-finish-cross-build-support.patch
-uml-fix-a-ptrace-call.patch
-uml-s390-preparation-abstract-host-page-fault-data.patch
-uml-fix-sigwinch-relaying.patch
-uml-tidy-makefilerules.patch
-uml-inclusion-cleanup.patch
-uml-hostfs-failed-mount-handling.patch
-uml-s390-preparation-elfh.patch
-uml-s390-preparation-linkageh-inherited-from-host.patch
-uml-s390-preparation-checksumming-done-in-arch-code.patch
-uml-s390-preparation-delay-moved-to-arch.patch
-uml-s390-preparation-sighandler-interface-abstraction.patch
-uml-remove-a-dangling-symlink.patch
-uml-header-and-code-cleanup.patch
-kprobes-incorrect-handling-of-probes-on-ret-lret-instruction.patch
-kprobes-oops-in-unregister_kprobe.patch
-kprobes-allow-multiple-kprobes-at-the-same-address.patch
-patch-kernel-support-non-incremental-26xy-stable-patches.patch
-3c59x-only-put-the-device-into-d3-when-were-actually-using-wol.patch
-fix-race-in-__block_prepare_write.patch
-__block_write_full_page-race-fix.patch
-__block_write_full_page-speedup.patch
-__block_write_full_page-simplification.patch
-setitimer-timer-expires-too-early.patch
-drivers-ide-pci-sis5513c-section-fixes.patch
-uninline-tty_paranoia_check.patch
-remove-bk-documentation.patch
-update-dontdiff.patch
-saa6752hs-resolutions-handling.patch
-pcmcia-enable-32-bit-memory-windows-on-pd6729.patch
-pcmcia-yenta-ti-align-irq-of-func1-to-func0-if-intrtie-is-set.patch
-dac960-add-support-for-mylex-acceleraid-4-5-600.patch
-remove-outdated-comments-from-filemapc.patch
-remove-do_sync-parameter-from-__invalidate_device.patch
-remove-do_sync-parameter-from-__invalidate_device-fix.patch
-bttv-fix-dst-i2c-read-write-timeout-failure.patch
-orinoco-maintainers-update.patch
-revert-ext3-writepages-support-for-writeback-mode.patch
-device-mapper-store-bdev-while-frozen.patch
-device-mapper-__unlock_fs-void.patch
-device-mapper-let-freeze_bdev-return-error.patch
-device-mapper-handle-__lock_fs-error.patch
-device-mapper-tidy-dm_suspend.patch
-device-mapper-multipath-use-private-workqueue.patch
-device-mapper-dm-emc-fix-a-memset.patch
-device-mapper-some-missing-statics.patch
-fs-jffs2-make-some-functions-static.patch
-fs-nls-nls_basec-make-a-variable-static.patch
-fs-make-some-code-static.patch
-drivers-char-keyboardc-make-a-function-static.patch
-drivers-video-fbmemc-make-a-function-static.patch
-drivers-video-fbsysfsc-make-a-struct-static.patch
-drivers-video-sis-make-some-functions-static.patch
-drivers-md-make-some-code-static.patch
-drivers-net-appletalk-make-2-firmware-images-static-const.patch
-drivers-net-arcnet-capmodec-make-a-struct-static.patch
-drivers-cdrom-cdu31ac-make-some-code-static.patch
-floppy-driver-make-fd_routine-static.patch
-drivers-cdrom-mcdxc-make-code-static.patch
-drivers-block-rdc-make-a-variable-static.patch
-drivers-cdrom-sbpcdc-make-a-function-static.patch
-fs-nfs-make-some-functions-static.patch
-cyrix-eliminate-bad-section-references.patch
-drivers-media-video-tvaudioc-make-some-variables-static.patch
-reiserfs-use-null-instead-of-0.patch
-comments-on-locking-of-task-comm.patch
-fixup-a-comment-still-refering-to-verify_area.patch
-ixj-compile-warning-cleanup.patch
-spelling-cleanups-in-shrinker-code.patch
-codingstyle-trivial-whitespace-fixups.patch
-update-ross-biro-bouncing-email-address.patch
-x86-geode-support-fixes.patch
-fix-ncr53c9xc-compile-warning.patch
-fix-lib-sort-regression-test.patch
-correctly-name-the-shell-sort.patch
-lib-c-documentation-strncpy.patch
-fs-udf-udftimec-fix-off-by-one-error.patch
-drivers-scsi-sym53c416c-fix-a-wrong-check.patch

 Merged

+fix-for-bttv-driver-v0915-for-leadtek-winfast-vc100-xp-capture-cards.patch

 bttv fix

+fix-impossible-vmallocchunk.patch

 /proc/meminfo fix

+ide-proc-destroy-error.patch

 IDE fix

+6300esb-tco-timer-support.patch

 i8xx_tco device support

+uml-remove-elfh.patch
+uml-critical-change-memcpy-to-memmove.patch

 UML important updates

+md-fix-splitting-of-md-linear-request-that-cross-a-device-boundary.patch
+md-set-the-unplug_fn-and-issue_flush_fn-for-md-devices-after-committed-to-creation.patch

 md important updates

+mm-fix-rss-counter-being-incremented-when-unmapping.patch

 VM accounting fix

+cpufreq-CPUFREQ-11-recalibrate-cpu_khz.patch
+cpufreq-CPUFREQ-12-recalibrate-cpu_khz-2.patch
+cpufreq-CPUFREQ-13-static-cpufreq_gov_dbs.patch
+cpufreq-CPUFREQ-14-powernow-k8-dual-core-on2.6.12.patch
+cpufreq-CPUFREQ-15-transition-latency-thinko.patch
+cpufreq-CPUFREQ-16-conservative-governer.patch
+cpufreq-CPUFREQ-17-ondemand-ignore-nice.patch
+cpufreq-CPUFREQ-18-ondemand-check-rate-and-break-out.patch
+cpufreq-CPUFREQ-19-ondemand-sys_freq_step.patch
+cpufreq-CPUFREQ-20-powernow-k8-static-cpu_sharedcore_mask.patch
-powernow-k7recalibrate-cpu_khz.patch
-cpufreq-timers-recalibrate_cpu_khz.patch

 Additions to cpufreq tree

-gregkh-01-driver-gregkh-driver-001_driver-hotplug_check.patch
-gregkh-01-driver-gregkh-driver-002_debugfs_simple_newline.patch
-gregkh-01-driver-gregkh-driver-009_driver-name-const-01.patch
-gregkh-01-driver-gregkh-driver-010_driver-name-const-02.patch
-gregkh-01-driver-gregkh-driver-011_driver-name-const-03.patch
-gregkh-01-driver-gregkh-driver-012_driver-name-const-04.patch
-gregkh-01-driver-gregkh-driver-013_driver-name-const-05.patch
-gregkh-01-driver-gregkh-driver-014_driver-name-const-06.patch
-gregkh-01-driver-gregkh-driver-015_sysfs-show_store_eio-01.patch
-gregkh-01-driver-gregkh-driver-016_sysfs-show_store_eio-02.patch
-gregkh-01-driver-gregkh-driver-017_sysfs-show_store_eio-03.patch
-gregkh-01-driver-gregkh-driver-018_sysfs-show_store_eio-04.patch
-gregkh-01-driver-gregkh-driver-019_sysfs-show_store_eio-05.patch
-gregkh-01-driver-gregkh-driver-020_class-01-core.patch
-gregkh-01-driver-gregkh-driver-021_class-02-tty.patch
-gregkh-01-driver-gregkh-driver-022_class-03-input.patch
-gregkh-01-driver-gregkh-driver-023_class-04-usb.patch
-gregkh-01-driver-gregkh-driver-024_class-05-sound.patch
-gregkh-01-driver-gregkh-driver-025_class-06-block.patch
-gregkh-01-driver-gregkh-driver-026_class-07-char.patch
-gregkh-01-driver-gregkh-driver-027_class-08-ieee1394.patch
-gregkh-01-driver-gregkh-driver-028_class-09-scsi.patch
-gregkh-01-driver-gregkh-driver-029_class-10-arch.patch
-gregkh-01-driver-gregkh-driver-030_class-11-drivers.patch
-gregkh-01-driver-gregkh-driver-031_class-11-drivers-usb-fix.patch
-gregkh-01-driver-gregkh-driver-032_class-12-the_rest.patch
-gregkh-01-driver-gregkh-driver-033_class-13-kerneldoc.patch
-gregkh-01-driver-gregkh-driver-034_class-14-no_more_class_simple.patch
-gregkh-01-driver-gregkh-driver-035_class-15-typo-01.patch
-gregkh-01-driver-gregkh-driver-036_class-16-typo-02.patch
-gregkh-01-driver-gregkh-driver-037_class-17-attribute.patch
-gregkh-01-driver-gregkh-driver-038_klist-01.patch
-gregkh-01-driver-gregkh-driver-039_klist-02.patch
-gregkh-01-driver-gregkh-driver-040_klist-03.patch
-gregkh-01-driver-gregkh-driver-041_klist-04.patch
-gregkh-01-driver-gregkh-driver-042_klist-05.patch
-gregkh-01-driver-gregkh-driver-043_klist-06.patch
-gregkh-01-driver-gregkh-driver-044_klist-07.patch
-gregkh-01-driver-gregkh-driver-045_klist-08.patch
-gregkh-01-driver-gregkh-driver-046_klist-09.patch
-gregkh-01-driver-gregkh-driver-047_klist-10.patch
-gregkh-01-driver-gregkh-driver-048_klist-11.patch
-gregkh-01-driver-gregkh-driver-049_klist-12.patch
-gregkh-01-driver-gregkh-driver-050_klist-13.patch
-gregkh-01-driver-gregkh-driver-051_klist-14.patch
-gregkh-01-driver-gregkh-driver-052_klist-15.patch
-gregkh-01-driver-gregkh-driver-053_klist-16.patch
-gregkh-01-driver-gregkh-driver-054_klist-17.patch
-gregkh-01-driver-gregkh-driver-055_klist-18.patch
-gregkh-01-driver-gregkh-driver-056_klist-scsi-01.patch
-gregkh-01-driver-gregkh-driver-057_klist-scsi-02.patch
-gregkh-01-driver-gregkh-driver-058_klist-20.patch
-gregkh-01-driver-gregkh-driver-059_klist-21.patch
-gregkh-01-driver-gregkh-driver-060_klist-22.patch
-gregkh-01-driver-gregkh-driver-061_klist-23.patch
-gregkh-01-driver-gregkh-driver-062_klist-ieee1394.patch
-gregkh-01-driver-gregkh-driver-063_klist-pcie.patch
-gregkh-01-driver-gregkh-driver-064_klist-24.patch
-gregkh-01-driver-gregkh-driver-065_klist-25.patch
-gregkh-01-driver-gregkh-driver-066_klist-26.patch
-gregkh-01-driver-gregkh-driver-067_klist-usb_node_attached_fix.patch
-gregkh-01-driver-gregkh-driver-068_klist-sn_fix.patch
+gregkh-01-driver-gregkh-driver-001_driver-pm-diag-update.patch
+gregkh-01-driver-gregkh-driver-002_driver-name-const-01.patch
+gregkh-01-driver-gregkh-driver-003_driver-name-const-02.patch
+gregkh-01-driver-gregkh-driver-004_driver-name-const-03.patch
+gregkh-01-driver-gregkh-driver-005_driver-name-const-04.patch
+gregkh-01-driver-gregkh-driver-006_driver-name-const-05.patch
+gregkh-01-driver-gregkh-driver-007_driver-name-const-06.patch
+gregkh-01-driver-gregkh-driver-008_sysfs-show_store_eio-01.patch
+gregkh-01-driver-gregkh-driver-009_sysfs-show_store_eio-02.patch
+gregkh-01-driver-gregkh-driver-010_sysfs-show_store_eio-03.patch
+gregkh-01-driver-gregkh-driver-011_sysfs-show_store_eio-04.patch
+gregkh-01-driver-gregkh-driver-012_sysfs-show_store_eio-05.patch
+gregkh-01-driver-gregkh-driver-013_class-01-core.patch
+gregkh-01-driver-gregkh-driver-014_class-02-tty.patch
+gregkh-01-driver-gregkh-driver-015_class-03-input.patch
+gregkh-01-driver-gregkh-driver-016_class-04-usb.patch
+gregkh-01-driver-gregkh-driver-017_class-05-sound.patch
+gregkh-01-driver-gregkh-driver-018_class-06-block.patch
+gregkh-01-driver-gregkh-driver-019_class-07-char.patch
+gregkh-01-driver-gregkh-driver-020_class-08-ieee1394.patch
+gregkh-01-driver-gregkh-driver-021_class-09-scsi.patch
+gregkh-01-driver-gregkh-driver-022_class-10-arch.patch
+gregkh-01-driver-gregkh-driver-023_class-11-drivers.patch
+gregkh-01-driver-gregkh-driver-024_class-11-drivers-usb-fix.patch
+gregkh-01-driver-gregkh-driver-025_class-12-the_rest.patch
+gregkh-01-driver-gregkh-driver-026_class-13-kerneldoc.patch
+gregkh-01-driver-gregkh-driver-027_class-14-no_more_class_simple.patch
+gregkh-01-driver-gregkh-driver-028_fix-make-mandocs-after-class_simple-removal.patch
+gregkh-01-driver-gregkh-driver-029_klist-01.patch
+gregkh-01-driver-gregkh-driver-030_klist-02.patch
+gregkh-01-driver-gregkh-driver-031_klist-03.patch
+gregkh-01-driver-gregkh-driver-032_klist-04.patch
+gregkh-01-driver-gregkh-driver-033_klist-05.patch
+gregkh-01-driver-gregkh-driver-034_klist-06.patch
+gregkh-01-driver-gregkh-driver-035_klist-07.patch
+gregkh-01-driver-gregkh-driver-036_klist-08.patch
+gregkh-01-driver-gregkh-driver-037_klist-09.patch
+gregkh-01-driver-gregkh-driver-038_klist-10.patch
+gregkh-01-driver-gregkh-driver-039_klist-11.patch
+gregkh-01-driver-gregkh-driver-040_klist-12.patch
+gregkh-01-driver-gregkh-driver-041_klist-13.patch
+gregkh-01-driver-gregkh-driver-042_klist-14.patch
+gregkh-01-driver-gregkh-driver-043_klist-15.patch
+gregkh-01-driver-gregkh-driver-044_klist-16.patch
+gregkh-01-driver-gregkh-driver-045_klist-17.patch
+gregkh-01-driver-gregkh-driver-046_klist-18.patch
+gregkh-01-driver-gregkh-driver-047_klist-scsi-01.patch
+gregkh-01-driver-gregkh-driver-048_klist-scsi-02.patch
+gregkh-01-driver-gregkh-driver-049_klist-20.patch
+gregkh-01-driver-gregkh-driver-050_klist-21.patch
+gregkh-01-driver-gregkh-driver-051_klist-22.patch
+gregkh-01-driver-gregkh-driver-052_klist-23.patch
+gregkh-01-driver-gregkh-driver-053_klist-ieee1394.patch
+gregkh-01-driver-gregkh-driver-054_klist-pcie.patch
+gregkh-01-driver-gregkh-driver-055_klist-24.patch
+gregkh-01-driver-gregkh-driver-056_klist-25.patch
+gregkh-01-driver-gregkh-driver-057_klist-26.patch
+gregkh-01-driver-gregkh-driver-058_klist-usb_node_attached_fix.patch
+gregkh-01-driver-gregkh-driver-059_klist-sn_fix.patch
+gregkh-01-driver-gregkh-driver-060_klist-driver_detach_fixes.patch
+gregkh-01-driver-gregkh-driver-061_klist-usbcore-dont_call_device_release_driver_recursivly.patch
+gregkh-01-driver-gregkh-driver-062_driver-create-unregister_node.patch
+gregkh-01-driver-gregkh-driver-063_attr_void.patch

 Greg keeps renaming stuff.

-gregkh-02-i2c-gregkh-i2c-001_i2c-address_range_removal.patch
-gregkh-02-i2c-gregkh-i2c-002_i2c-address_merge_video.patch
-gregkh-02-i2c-gregkh-i2c-003_w1-ds18xx_sensors.patch
-gregkh-02-i2c-gregkh-i2c-004_w1-new_rom_family.patch
-gregkh-02-i2c-gregkh-i2c-005_i2c-rtc8564_duplicate_include.patch
-gregkh-02-i2c-gregkh-i2c-006_i2c-vid_h.patch
-gregkh-02-i2c-gregkh-i2c-007_i2c-atxp1.patch
-gregkh-02-i2c-gregkh-i2c-008_i2c-atxp1-cleanup.patch
-gregkh-02-i2c-gregkh-i2c-009_i2c-ds1337-01.patch
-gregkh-02-i2c-gregkh-i2c-010_i2c-ds1337-02.patch
-gregkh-02-i2c-gregkh-i2c-011_i2c-ds1337-03.patch
-gregkh-02-i2c-gregkh-i2c-012_i2c-config_cleanup-01.patch
-gregkh-02-i2c-gregkh-i2c-013_i2c-config_cleanup-02.patch
-gregkh-02-i2c-gregkh-i2c-014_i2c-ali1563.patch
-gregkh-02-i2c-gregkh-i2c-015_i2c-adm9240.patch
-gregkh-02-i2c-gregkh-i2c-016_i2c-w83627ehf.patch
-gregkh-02-i2c-gregkh-i2c-017_i2c-w83627ehf-cleanup.patch
-gregkh-02-i2c-gregkh-i2c-018_i2c-smsc47m1.patch
-gregkh-02-i2c-gregkh-i2c-019_i2c-spelling_fixes.patch
-gregkh-02-i2c-gregkh-i2c-020_i2c-mpc-share_interrupt.patch
+gregkh-02-i2c-gregkh-i2c-001_i2c-ali1563.patch
+gregkh-02-i2c-gregkh-i2c-002_i2c-address_range_removal.patch
+gregkh-02-i2c-gregkh-i2c-003_i2c-address_merge_video.patch
+gregkh-02-i2c-gregkh-i2c-004_w1-ds18xx_sensors.patch
+gregkh-02-i2c-gregkh-i2c-005_w1-new_rom_family.patch
+gregkh-02-i2c-gregkh-i2c-006_i2c-rtc8564_duplicate_include.patch
+gregkh-02-i2c-gregkh-i2c-007_i2c-vid_h.patch
+gregkh-02-i2c-gregkh-i2c-008_i2c-atxp1.patch
+gregkh-02-i2c-gregkh-i2c-009_i2c-atxp1-cleanup.patch
+gregkh-02-i2c-gregkh-i2c-010_i2c-ds1337-01.patch
+gregkh-02-i2c-gregkh-i2c-011_i2c-ds1337-02.patch
+gregkh-02-i2c-gregkh-i2c-012_i2c-ds1337-03.patch
+gregkh-02-i2c-gregkh-i2c-013_i2c-ds1337_make_time_format_consistent.patch
+gregkh-02-i2c-gregkh-i2c-014_i2c-ds1337_i2c_transfer_check.patch
+gregkh-02-i2c-gregkh-i2c-015_i2c-ds1337_search_by_bus_number.patch
+gregkh-02-i2c-gregkh-i2c-016_i2c-ds1337-config-update.patch
+gregkh-02-i2c-gregkh-i2c-017_i2c-config_cleanup-01.patch
+gregkh-02-i2c-gregkh-i2c-018_i2c-config_cleanup-02.patch
+gregkh-02-i2c-gregkh-i2c-019_i2c-adm9240.patch
+gregkh-02-i2c-gregkh-i2c-020_i2c-w83627ehf.patch
+gregkh-02-i2c-gregkh-i2c-021_i2c-w83627ehf-cleanup.patch
+gregkh-02-i2c-gregkh-i2c-022_i2c-smsc47m1.patch
+gregkh-02-i2c-gregkh-i2c-023_i2c-spelling_fixes.patch
+gregkh-02-i2c-gregkh-i2c-024_i2c-mpc-share_interrupt.patch
+gregkh-02-i2c-gregkh-i2c-025_i2c-remove_redundancy_from_i2c_core.patch
+gregkh-02-i2c-gregkh-i2c-026_i2c-remove_delay_h_from_via686a.patch
-remove-redundancy-from-i2c-corec.patch

 Ditto

+git-ia64-pre.patch
 git-ia64.patch
+git-ia64-post.patch

 Patches to make the ia64 tree merging easier.

-i8k-use-standard-dmi-interface-fix.patch

 Folded into i8k-use-standard-dmi-interface.patch

+git-ipsec.patch

 IPSec tree

+ipvs-add-and-reorder-bh-locks-after-moving-to-keventd.patch

 IPVS locking fix

+r8169-de-obfuscate-supported-pci-id.patch
+r8169-identify-the-napi-version.patch
+r8169-add-module-parameter-description-for-copybreak.patch
+r8169-add-module-parameter-description-for-the-media-option.patch
+r8169-ethtool-message-level-control-support.patch
+r8169-ethtool-support-for-dumping-the-chip-statistics.patch
+r8169-cleanup-function-args.patch
+tulip-natsemi-dp83840a-phy-fix.patch

 Net driver updates

-bk-ntfs.patch
+git-ntfs.patch

 Anton's NTFS tree has moved over to git.

-gregkh-03-pci-gregkh-pci-012_pci-pci-transparent-bridge-handling-improvements-pci-core.patch
-gregkh-03-pci-gregkh-pci-013_pci-pirq_table_addr-out-of-range.patch
-gregkh-03-pci-gregkh-pci-014_pci-get_device-01.patch
-gregkh-03-pci-gregkh-pci-015_pci-get_device-02.patch
-gregkh-03-pci-gregkh-pci-016_pci-acpiphp-02.patch
-gregkh-03-pci-gregkh-pci-017_pci-acpiphp-03.patch
-gregkh-03-pci-gregkh-pci-018_pci-acpiphp-04.patch
-gregkh-03-pci-gregkh-pci-019_pci-acpiphp-05.patch
-gregkh-03-pci-gregkh-pci-020_pci-acpiphp-06.patch
-gregkh-03-pci-gregkh-pci-021_pci-acpiphp-07.patch
-gregkh-03-pci-gregkh-pci-022_pci-acpiphp-08.patch
-gregkh-03-pci-gregkh-pci-023_pci-acpiphp-09.patch
-gregkh-03-pci-gregkh-pci-024_pci-acpiphp-10.patch
-gregkh-03-pci-gregkh-pci-025_pci-acpiphp-11.patch
-gregkh-03-pci-gregkh-pci-026_pci-acpiphp-12.patch
-gregkh-03-pci-gregkh-pci-027_pci-acpiphp-13.patch
-gregkh-03-pci-gregkh-pci-028_pci-acpiphp-14.patch
-gregkh-03-pci-gregkh-pci-029_pci-acpiphp-15.patch
-gregkh-03-pci-gregkh-pci-030_pci-acpiphp-16.patch
-gregkh-03-pci-gregkh-pci-031_pci-acpiphp-17.patch
-gregkh-03-pci-gregkh-pci-032_pci-acpiphp-18.patch
-gregkh-03-pci-gregkh-pci-033_pci-acpiphp-19.patch
-gregkh-03-pci-gregkh-pci-034_pci-acpiphp-20.patch
+gregkh-03-pci-gregkh-pci-001_pci-hotplug-shpc-power-fix.patch
+gregkh-03-pci-gregkh-pci-002_pci-pciehp-downstream-port-fix.patch
+gregkh-03-pci-gregkh-pci-003_pci-cpci-update.patch
+gregkh-03-pci-gregkh-pci-004_pci-remove-pci_visit_dev.patch
+gregkh-03-pci-gregkh-pci-005_pci-pci-transparent-bridge-handling-improvements-pci-core.patch
+gregkh-03-pci-gregkh-pci-006_pci-pirq_table_addr-out-of-range.patch
+gregkh-03-pci-gregkh-pci-007_pci-get_device-01.patch
+gregkh-03-pci-gregkh-pci-008_pci-get_device-02.patch
+gregkh-03-pci-gregkh-pci-009_pci-acpiphp-02.patch
+gregkh-03-pci-gregkh-pci-010_pci-acpiphp-03.patch
+gregkh-03-pci-gregkh-pci-011_pci-acpiphp-04.patch
+gregkh-03-pci-gregkh-pci-012_pci-acpiphp-05.patch
+gregkh-03-pci-gregkh-pci-013_pci-acpiphp-06.patch
+gregkh-03-pci-gregkh-pci-014_pci-acpiphp-07.patch
+gregkh-03-pci-gregkh-pci-015_pci-acpiphp-08.patch
+gregkh-03-pci-gregkh-pci-016_pci-acpiphp-09.patch
+gregkh-03-pci-gregkh-pci-017_pci-acpiphp-10.patch
+gregkh-03-pci-gregkh-pci-018_pci-acpiphp-11.patch
+gregkh-03-pci-gregkh-pci-019_pci-acpiphp-12.patch
+gregkh-03-pci-gregkh-pci-020_pci-acpiphp-13.patch
+gregkh-03-pci-gregkh-pci-021_pci-acpiphp-14.patch
+gregkh-03-pci-gregkh-pci-022_pci-acpiphp-15.patch
+gregkh-03-pci-gregkh-pci-023_pci-acpiphp-16.patch
+gregkh-03-pci-gregkh-pci-024_pci-acpiphp-17.patch
+gregkh-03-pci-gregkh-pci-025_pci-acpiphp-18.patch
+gregkh-03-pci-gregkh-pci-026_pci-acpiphp-19.patch
+gregkh-03-pci-gregkh-pci-027_pci-acpiphp-20.patch
+gregkh-03-pci-gregkh-pci-028_pci-serverworks-gc-quirk.patch

 Greg's PCI tree.  Hard to tell what changed.

-git-scsi-rc-fixes.patch

 This tree is now empty

-add-scsi-changer-driver.patch
-scsi-ch-build-fix.patch
-add-scsi-changer-driver-fix.patch

 The scsi changer patch has been updated, but the updated version uses sysfs
 APIs which Greg's tree deletes.  Things are being fixed up.

-gregkh-04-USB-gregkh-usb-011_usb-g_file_storage_min.patch
-gregkh-04-USB-gregkh-usb-012_usb-g_file_storage_stall.patch
-gregkh-04-USB-gregkh-usb-013_usb-omap_udc_update.patch
-gregkh-04-USB-gregkh-usb-014_usb-isp116x-hcd-add.patch
-gregkh-04-USB-gregkh-usb-015_usb-isp116x-hcd-fix.patch
-gregkh-04-USB-gregkh-usb-016_usb-turn-a-user-mode-driver-error-into-a-hard-error.patch
-gregkh-04-USB-gregkh-usb-017_usb-uhci-01.patch
-gregkh-04-USB-gregkh-usb-018_usb-uhci-02.patch
-gregkh-04-USB-gregkh-usb-019_usb-uhci-03.patch
-gregkh-04-USB-gregkh-usb-020_usb-uhci-04.patch
-gregkh-04-USB-gregkh-usb-021_usb-uhci-05.patch
-gregkh-04-USB-gregkh-usb-022_usb-uhci-06.patch
-gregkh-04-USB-gregkh-usb-023_usb-uhci-07.patch
-gregkh-04-USB-gregkh-usb-024_usb-uhci-08.patch
-gregkh-04-USB-gregkh-usb-025_usb-root_hub_irq.patch
-gregkh-04-USB-gregkh-usb-026_usb-cdc_acm.patch
-gregkh-04-USB-gregkh-usb-027_usb-usbtest.patch
-gregkh-04-USB-gregkh-usb-028_usb-ohci_reboot_notifier.patch
-gregkh-04-USB-gregkh-usb-029_usb_serial_status.patch
-gregkh-04-USB-gregkh-usb-030_usb-zd1201_pm.patch
-gregkh-04-USB-gregkh-usb-031_usb-zd1201_pm-02.patch
-gregkh-04-USB-gregkh-usb-032_usb-remove_hub_set_power_budget.patch
-gregkh-04-USB-gregkh-usb-033_usb-device_pointer.patch
-gregkh-04-USB-gregkh-usb-034_usb-hcd_fix_for_remove_hub_set_power_budget.patch
-gregkh-04-USB-gregkh-usb-035_usb-usbcore_usb_add_hcd.patch
-gregkh-04-USB-gregkh-usb-036_usb-hcds_no_more_register_root_hub.patch
-gregkh-04-USB-gregkh-usb-037_usb-ub_multi_lun.patch
-gregkh-04-USB-gregkh-usb-038_usb-rndis_cleanups.patch
-gregkh-04-USB-gregkh-usb-039_usb-ethernet_gadget_cleanups.patch
-gregkh-04-USB-gregkh-usb-040_usb-omap_udc_cleanups.patch
-gregkh-04-USB-gregkh-usb-041_usb-dummy_hcd-otg.patch
-gregkh-04-USB-gregkh-usb-042_usb-dummy_hcd-FEAT.patch
-gregkh-04-USB-gregkh-usb-043_usb-dummy_hcd-pdevs.patch
-gregkh-04-USB-gregkh-usb-044_usb-dummy_hcd-centralize-link.patch
-gregkh-04-USB-gregkh-usb-045_usb-dummy_hcd-root-hub_no-polling.patch
+gregkh-04-USB-gregkh-usb-001_usb-usbnet-fixes.patch
+gregkh-04-USB-gregkh-usb-002_usb-ehci-suspend-stop-timer.patch
+gregkh-04-USB-gregkh-usb-003_usb-g_file_storage_min.patch
+gregkh-04-USB-gregkh-usb-004_usb-g_file_storage_stall.patch
+gregkh-04-USB-gregkh-usb-005_usb-omap_udc_update.patch
+gregkh-04-USB-gregkh-usb-006_usb-isp116x-hcd-add.patch
+gregkh-04-USB-gregkh-usb-007_usb-isp116x-hcd-fix.patch
+gregkh-04-USB-gregkh-usb-008_usb-turn-a-user-mode-driver-error-into-a-hard-error.patch
+gregkh-04-USB-gregkh-usb-009_usb-uhci-01.patch
+gregkh-04-USB-gregkh-usb-010_usb-uhci-02.patch
+gregkh-04-USB-gregkh-usb-011_usb-uhci-03.patch
+gregkh-04-USB-gregkh-usb-012_usb-uhci-04.patch
+gregkh-04-USB-gregkh-usb-013_usb-uhci-05.patch
+gregkh-04-USB-gregkh-usb-014_usb-uhci-06.patch
+gregkh-04-USB-gregkh-usb-015_usb-uhci-07.patch
+gregkh-04-USB-gregkh-usb-016_usb-uhci-08.patch
+gregkh-04-USB-gregkh-usb-017_usb-root_hub_irq.patch
+gregkh-04-USB-gregkh-usb-018_usb-cdc_acm.patch
+gregkh-04-USB-gregkh-usb-019_usb-usbtest.patch
+gregkh-04-USB-gregkh-usb-020_usb-ohci_reboot_notifier.patch
+gregkh-04-USB-gregkh-usb-021_usb_serial_status.patch
+gregkh-04-USB-gregkh-usb-022_usb-zd1201_pm.patch
+gregkh-04-USB-gregkh-usb-023_usb-zd1201_pm-02.patch
+gregkh-04-USB-gregkh-usb-024_usb-remove_hub_set_power_budget.patch
+gregkh-04-USB-gregkh-usb-025_usb-device_pointer.patch
+gregkh-04-USB-gregkh-usb-026_usb-hcd_fix_for_remove_hub_set_power_budget.patch
+gregkh-04-USB-gregkh-usb-027_usb-usbcore_usb_add_hcd.patch
+gregkh-04-USB-gregkh-usb-028_usb-hcds_no_more_register_root_hub.patch
+gregkh-04-USB-gregkh-usb-029_usb-ub_multi_lun.patch
+gregkh-04-USB-gregkh-usb-030_usb-rndis_cleanups.patch
+gregkh-04-USB-gregkh-usb-031_usb-ethernet_gadget_cleanups.patch
+gregkh-04-USB-gregkh-usb-032_usb-omap_udc_cleanups.patch
+gregkh-04-USB-gregkh-usb-033_usb-dummy_hcd-otg.patch
+gregkh-04-USB-gregkh-usb-034_usb-dummy_hcd-FEAT.patch
+gregkh-04-USB-gregkh-usb-035_usb-dummy_hcd-pdevs.patch
+gregkh-04-USB-gregkh-usb-036_usb-dummy_hcd-centralize-link.patch
+gregkh-04-USB-gregkh-usb-037_usb-dummy_hcd-root-hub_no-polling.patch
+gregkh-04-USB-gregkh-usb-038_usb-remove_pwc_changelog.patch
+gregkh-04-USB-gregkh-usb-039_usb-add-new-wacom-device-to-usb-hid-core-list.patch
+gregkh-04-USB-gregkh-usb-040_usb-urb_documentation.patch
+gregkh-04-USB-gregkh-usb-041_usb-idmouse_update.patch
+gregkh-04-USB-gregkh-usb-042_usb-gadget-kconfig.patch
+gregkh-04-USB-gregkh-usb-043_usb-gadget-setup-api-change.patch
+gregkh-04-USB-gregkh-usb-044_usb-gadget-setup-api-change-net2280.patch
+gregkh-04-USB-gregkh-usb-045_usb-gadget-setup-api-change-goku_udc.patch
+gregkh-04-USB-gregkh-usb-046_usb-gadget-pxa2xx_udc-updates.patch
+gregkh-04-USB-gregkh-usb-047_usb-ehci-minor-updates.patch
+gregkh-04-USB-gregkh-usb-048_usb-earthmate-hid-blacklist.patch
-add-new-wacom-device-to-usb-hid-core-list.patch

 USB tree

+make-each-arch-use-mm-kconfig-fix.patch

 Folded into make-each-arch-use-mm-kconfig.patch

+generify-early_pfn_to_nid.patch
+generify-memory-present.patch
+sparsemem-memory-model.patch
+sparsemem-memory-model-for-i386.patch
+sparsemem-swiss-cheese-numa-layouts.patch
+sparsemem-hotplug-base.patch
+ppc64-add-early_pfn_to_nid.patch
+ppc64-add-memory-present.patch
+ppc64-sparsemem-memory-model.patch
+ppc64-sparsemem-memory-model-fix.patch

 More sparsemem stuff

+block_read_full_page-get_block-error-fix.patch
+avoiding-mmap-fragmentation.patch
+avoiding-mmap-fragmentation-tidy.patch
+do_swap_page-can-map-random-data-if-swap-read-fails.patch
+move_vma-comment.patch

 Various mm/vfs fixes

+3c509-device-support.patch
+fix-ieee80211_crypt_-selects.patch
+ipt_recent-fixes.patch
+atm-nicstar-remove-a-bunch-of-pointless-casts-of-null.patch
+iseries_veth-dont-send-packets-to-lpars-which-arent-up.patch
+iseries_veth-set-dev-trans_start-so-watchdog-timer-works-right.patch
+iseries_veth-dont-leak-skbs-in-rx-path.patch
+iseries_veth-cleanup-skbs-to-prevent-unregister_netdevice-hanging.patch

 Various networking things

+kbuild-display-compile-version.patch

 kbuild feature

+selinux-fix-avc_alloc_node-oom-with-no-policy-loaded.patch

 SELinux out-of-memory fix

+make-sure-therm_adt746x-only-handles-known-hardware.patch
+ppc32-small-cpufreq-update.patch
+ppc32-fix-uimage-make-target-to-report-success-correctly.patch
+ppc32-kill-embedded-systemmap-use-kallsyms.patch

 ppc32 updates

-added-no_ioapic_check-in-io_apic_get_unique_id-for-acpi-boot.patch

 Dropped

+allow-pcibus_to_node-to-return-undetermined.patch

 pcibus_to_node() fix

+i386-never-block-forced-sigsegv.patch

 SIgnal fix

+do-not-enforce-unique-io_apic_id-check-for-xapic-systems-i386.patch
+remove-unique-apic-io-apic-id-check.patch

 IO APIC fixes

+optimise-storage-of-read-mostly-variables-fix.patch
+optimise-storage-of-read-mostly-variables-x86_64-fix.patch

 Sort-of fix optimise-storage-of-read-mostly-variables.patch

+x86_64-never-block-forced-sigsegv.patch

 Signal fix

+sep-initializing-rework-cleanup.patch

 Fix sep-initializing-rework.patch even more

+physical-cpu-hot-add-fix.patch

 Fix physical-cpu-hot-add.patch

+swsusp-clean-assembly-parts.patch

 swsusp cleanup

+uml-add-modversions-support.patch
+uml-add-mod_license-to-random-driver.patch
+uml-split-config_frame_pointer-from-debug_info.patch
+uml-stack-dump-fix.patch

 UML fixes

-enable-sig_ign-on-blocked-signals.patch

 Dropped - was wrong.

+vfs-bugfix-two-read_inode-calles-without.patch
+__wait_on_freeing_inode-fix.patch

 VFS race fixes

+kbtab-tweaks-pen-tool-reporting.patch

 input driver fix

+remove-duplicate-get_dentry-functions-in-various-places.patch

 VFS cleanup

+avoid-recursive-oopses.patch

 Try to prevent oops-within-oops

+quota-consolidate-code-surrounding-vfs_quota_on_mount.patch
+quota-sanitize-dentry-handling-in-vfs_quota_on_mount.patch

 Quota cleanups

+kprobes-function-return-probes.patch
+kprobes-function-return-probes-fix.patch
+kprobes-function-return-probes-fix-2.patch
+kprobes-function-return-probes-fix-3.patch

 kprobes feature work

+setuid-core-dump.patch

 Enhanced core dumping options

+support-for-dx-directories-in-ext3_get_parent-nfsd.patch

 ext3 htree fix

+document-the-fact-that-linux-arm-kernel-is-subscribers-only.patch

 MAINTAINERS fix

+fix-pci-mmap-on-ppc-and-ppc64.patch
+fix-pci-mmap-on-ppc-and-ppc64-fix.patch

 Fix mmapping of PCI devices

+add-some-comments-to-lookup_create.patch

 Add a comment

+fix-of-bogus-file-max-limit-messages.patch

 Fix the file handle allocator

+software-suspend-and-recalc-sigpending-bug-fix.patch

 swsusp fix

+o1-sb-list-traversing-on-syncs.patch

 speed up sync()

+fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch
+fix-of-dcache-race-leading-to-busy-inodes-on-umount-fix.patch
+fix-of-dcache-race-leading-to-busy-inodes-on-umount-tidy.patch

 dcache race fix (bit ugly)

+26-altix-shut-off-xmit-intr-if-done-xmitting.patch

 Altix serial driver fix

+parport-netmos-nm9855-fix.patch

 parport driver fix

+char-tpm-use-msleep-clean-up-timers.patch
+fix-concerns-with-tpm-driver-use-enums.patch
+fix-tpm-driver-address-missing-const-defs.patch
+fix-tpm-driver-remove-unnecessary-module-stuff.patch
+fix-tpm-driver-read-return-code-issue.patch
+fix-tpm-driver-large-stack-objects.patch
+fix-tpm-driver-how-timer-is-initialized.patch
+fix-tpm-driver-use-to_pci_dev.patch
+fix-tpm-driver-remove-unnecessary-__force.patch
+fix-tpm-driver-sysfs-owernship-changes.patch
+fix-tpm-driver-add-cancel-function.patch
+fix-tpm-driver-locks.patch
+tpm-support-for-tpms-on-additional-lpc-bus.patch
+tpm-support-for-tpms-on-additional-lpc-bus-fix-2.patch

 tpm driver fixes

+ieee1394-feature-removal-notices.patch
+drivers-ieee1394-pcilynxc-remove-dead-options.patch
+drivers-ieee1394-ieee1394_transactionsc-possible-cleanups.patch
+ieee1394-remove-null-checks-prior-to-kfree-in-ieee1394-kfree-handles-null-pointers-fin.patch
+drivers-ieee1394-pcilynxc-use-the-dma_32bit_mask-constant.patch
+ieee1394-single-buffer-fixes-to-video1394.patch
+ieee1394-fix-cross_bound-check-for-null-iso-packets.patch
+ieee1394-fix-premature-expiry-of-async-packets.patch

 ieee1394 tree

+connector-warning-fixes.patch

 Fix connector.patch

+connector-add-a-fork-connector.patch
+connector-add-a-fork-connector-build-fix.patch

 Use the connector for fork notifications for system accounting

+inotify-44-warning-fix.patch

 inotify tweak

+dvb-support-for-tt-hauppauge-nexus-s-rev-23.patch
+dvb-saa7146-no-need-to-initialize-static-global-variables-to-0.patch
+dvb-dvb_frontend-fix-module-param.patch
+dvb-av7110-audio-out-fix.patch
+dvb-add-support-for-knc-1-cards.patch
+dvb-remove-unnecessary-casts-in-dvb-core.patch
+dvb-dvb_net-handle-ipv6-and-llc-snap.patch
+dvb-av7110-fix-video_set_display_format.patch
+dvb-av7110-fix-ntsc-pal-switching.patch
+dvb-av7110-fix-comment.patch
+dvb-av7110-fix-indentation.patch
+dvb-nxt6000-support-frontend-status-reads.patch
+dvb-tda1004x-formatting-cleanups.patch
+dvb-stv0299-fix-fe_dishnetwork_send_legacy_cmd.patch
+dvb-remove-unnecessary-casts-in-frontends.patch
+dvb-dib3000-add-null-pointer-check.patch
+dvb-ves1820-remove-unnecessary-msleep.patch
+dvb-mt352-embed-struct-mt352_config-in-mt352_state.patch
+dvb-tda1004x-dont-use-bitfields.patch
+dvb-tda1004x-allow-n_i2c-to-be-overridden-by-the-card-driver.patch
+dvb-tda10046-support-for-different-firmware-versions.patch
+dvb-dvb-pllh-prevent-multiple-inclusion.patch
+dvb-make-needlessly-global-code-static-or-drop-it.patch
+dvb-frontends-misc-minor-cleanups.patch
+dvb-modified-dvb_register_adapter-to-avoid-kmalloc-kfree.patch
+dvb-bt8xx-update-documentation.patch
+dvb-dst-reorganize-twinhan-dst-driver-to-support-ci.patch
+dvb-dst-add-support-for-twinhan-200103a.patch
+dvb-dst-fixed-tuning-problem.patch
+dvb-dst-fix-for-descrambling-failure.patch
+dvb-dst-misc-fixes.patch
+dvb-bt8xx-updated-documentation.patch
+dvb-dst-fix-a-bug-in-the-module-parameter.patch
+dvb-dst-fixed-ci-debug-output.patch
+dvb-bt8xx-whitespace-cleanup.patch
+dvb-budget-av-ci-fixes.patch

 DVB update

+nr_blockdev_pages-in_interrupt-warning.patch

 Warn if someone calls nr_blockdev_pages() from interrupt (si_meminfo() is
 not irq-safe).

+nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch

 Generate all-CPU backtraces with sysrq-P or NMI watchdog timeouts, so
 everything you want to see scrolls off the screen.

+v4l-saa7134-byteorder-fix.patch

 v4l fix

+kexec-kexec-generic-maintainers-fix.patch

 MAINTAINERS fix

+ppc64-kexec-native-hash-clear.patch
+ppc64-kexec-support-for-ppc64.patch

 ppc64 kexec fixes

+kdump-documentation-for-kdump-update-fix.patch

 kdump documentation fix

+reiser4-sb_sync_inodes-cleanup.patch

 VFS cleanup

+bring-back-tux-on-chips-65550-framebuffer.patch
+s1d13xxxfb-linkage-fix.patch
+some-vesafb-fixes.patch

 fbdev updates

+md-two-small-fixes-for-md-verion-1-superblocks.patch
+md-dont-skip-bitmap-pages-due-to-lack-of-bit-that-we-just-cleared-fix.patch

 Fixes for the md patches in -mm.

+docbook-only-use-tabular-style-for-long-synopsis.patch
+docbook-maintainer.patch

 docbook system updates

+fuse-read-write-operations-fix-lookup-forget-interface.patch

 FUSE fix

+alsa-3142.patch
+alsa-3143.patch
+alsa-3144.patch
+alsa-3145.patch
+alsa-3146.patch
+alsa-3147.patch
+alsa-3148.patch
+alsa-3149.patch
+alsa-3150.patch
+alsa-3151.patch
+alsa-3152.patch
+alsa-3153.patch
+alsa-3154.patch
+alsa-3155.patch
+alsa-3156.patch
+alsa-3157.patch
+alsa-3158.patch
+alsa-3159.patch
+alsa-3160.patch
+alsa-3161.patch
+alsa-3162.patch
+alsa-3163.patch
+alsa-3164.patch
+alsa-3165.patch
+alsa-3166.patch
+alsa-3167.patch

 ALSA updates

+drivers-media-video-tvaudioc-make-some-variables-static.patch
+update-computone-maintainers-entry.patch
+remove-pointless-null-check-before-kfree-in-sony535c.patch
+kfree-cleanups-in-ixjc.patch
+fusion-kfree-cleanup.patch
+kfree-cleanups-for-drivers-firmware.patch

 Little tweaks




number of patches in -mm: 1042
number of changesets in external trees: 388
number of patches in -mm only: 1033
total patches: 1421


All 1024 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm1/patch-list

