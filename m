Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVLKMN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVLKMN0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 07:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVLKMN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 07:13:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751347AbVLKMNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 07:13:25 -0500
Date: Sun, 11 Dec 2005 04:13:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc5-mm2
Message-Id: <20051211041308.7bb19454.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/

- Many new driver updates and architecture updates

- New CPU scheduler policy: SCHED_BATCH.

- New version of the hrtimers code.




Changes since 2.6.15-rc5-mm1:

 linus.patch
 git-acpi.patch
 git-alsa.patch
 git-arm.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-audit.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-kbuild.patch
 git-libata-all.patch
 git-mmc.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-rc-fixes.patch
 git-sas-jg.patch
 git-sparc64.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 Subsystem trees

-sound-pci-au88x0-remove-unneeded-call-to-pci_dma_supported.patch
-ieee1394-write-broadcast_channel-only-to-select-nodes.patch
-git-libata-all-stat_sil-build-fix.patch
-arch-replace-pci_module_init-with-pci_register_driver.patch
-drivers-block-replace-pci_module_init-with-pci_register_driver.patch
-drivers-net-replace-pci_module_init-with-pci_register_driver.patch
-drivers-scsi-replace-pci_module_init-with-pci_register_driver.patch
-drivers-rest-replace-pci_module_init-with-pci_register_driver.patch
-git-pcmcia-dev_to_instance-fix.patch
-usb-storage-add-debug-entry-for-report-luns.patch
-mpcore_wdtc-bogus-fpos-check.patch
-ppc32-remove-unused-variables.patch
-add-new-quirk-for-devices-with-mute-leds-and-separate-headphone-volume.patch
-aoe-type-cleanups.patch
-aoe-skb_check-cleanup.patch
-ide-modalias-support-for-autoloading-of-ide-cd-ide-disk.patch
-net-make-function-pointer-argument-parseable-by-kernel-doc.patch
-pci-schedule-removal-of-pci_module_init-was-re-patch.patch

 Merged

-pfnmap-fix-2615-rc3-driver-breakage.patch

 Dropped

+fix-bug-in-rcu-torture-test.patch
+fix-rcu-race-in-access-of-nohz_cpu_mask.patch
+fix-rcu-race-in-access-of-nohz_cpu_mask-comment.patch

 RCU fixes

+fix-listxattr-for-generic-security-attributes.patch

 xattr fix

+add-getnstimestamp-function.patch
+add-timestamp-field-to-process-events.patch

 Process connector feature

+rcu-add-hlist_replace_rcu.patch
+kprobes-fix-race-in-aggregate-kprobe-registration.patch

 kprobes fix

+cciss-double-put_disk.patch

 cciss driver fix

+add-two-inotify_add_watch-flags.patch

 inotify feature

+um-fix-compile-error-for-tt.patch

 UML fix

+powerpc-fix-a-huge-page-bug.patch
+powerpc-remove-debug-code-in-hash-path.patch
+fix-windfarm-model-id-table.patch

 powerpc fixes

+mm-go-back-to-checking-pageanon-in-vm_normal_page.patch

 Fix recent MM changes for oddball drivers

+mips-setup_zero_pages-count-1.patch

 MIPS fix

+v4l-dvb-3086a-whitespaces-cleanups-part-1.patch
+v4l-dvb-3086b-whitespaces-cleanups-part-2.patch
+v4l-dvb-3086c-whitespaces-cleanups-part-3.patch
+v4l-dvb-3086c-whitespaces-cleanups-part-4.patch
+v4l-dvb-3135-fix-tuner-init-for-pinnacle-pctv-stereo.patch
+v4l-dvb-3113-convert-em28xx-to-use-vm_insert_page.patch
+v4l-dvb-3151-i2c-id-renamed-to-i2c_driverid_infrared.patch

 v4l/dvb fixes

+powerpc-set-cache-info-defaults.patch
+powerpc-fix-slb-flushing-path-in-hugepage.patch
+powerpc-add-missing-icache-flushes-for-hugepages.patch

 powerpc fixes

+sparc-atomic_clear_mask-build-fix.patch
+sparc32-block-needed-in-final-image-link-build-fix.patch

 sparc32 build fixes

+ipmi-fix-panic-generator-id.patch

 IPMI driver fix

+kprobes-no-probes-on-critical-path.patch
+kprobes-no-probes-on-critical-path-fix.patch
+kprobes-increment-kprobe-missed-count-for-multiprobes.patch

 kprobes fixes

+broken-cast-in-parport_pc.patch

 Build fix

+input-fix-ucb1x00-ts-breakage-after-conversion-to-dynamic.patch

 Input driver fix

+fix-kconfig-of-dma32-for-ia64.patch

 ia64 Kconfig fix

+ppc32-set-smp_tb_synchronized-on-up-with-smp-kernel.patch

 ppc32 fix

+fix-in-__alloc_bootmem_core-when-there-is-no-free-page-in-first-nodes-memory.patch

 bootmem initialisation fix

+x86_64-numa-bug-correction-in-populate_memnodemap.patch

 x86_64 numa init fix

+acpi-fix-sleeping-whilst-atomic-warnings-on-resume.patch

 ACPI fix

+2.6-sony_acpi4.patch

 ACPI driver for Sony laptops

+git-alsa-sparc64-fix.patch

 Fix git-alsa.patch

+gregkh-driver-ide-modalias-support-for-autoloading-of-ide-cd-ide-disk.patch
+gregkh-driver-aoe-type-cleanups.patch-added-to-mm-tree.patch
+gregkh-driver-aoe-skb_check-cleanup.patch

 driver tree updates

+gregkh-i2c-i2c-mv64xxx-compilation-error-fix.patch
-gregkh-i2c-i2c-parport-barco-ltp-dvi.patch
+gregkh-i2c-i2c-parport-barco-lpt-dvi.patch
-gregkh-i2c-i2c-device-id-lm75.patch
+gregkh-i2c-i2c-driver-owner-cleanup-01.patch
+gregkh-i2c-i2c-driver-owner-cleanup-02.patch
+gregkh-i2c-i2c-driver-owner-cleanup-03.patch
+gregkh-i2c-w1-change-the-type-unsigned-long-member-of-struct-w1_bus_master-to-void.patch
+gregkh-i2c-w1-move-w1-bus-master-code-into-w1-masters-and-move-w1-slave-code-into-w1-slaves.patch
+gregkh-i2c-w1-add-the-ds2482-i2c-to-w1-bridge-driver.patch
+gregkh-i2c-i2c-device-id-lm75.patch

 I2C tree fixes

+drivers-input-misc-added-acer-travelmate-240-support-to-the-wistron-button-interface.patch

 Input driver update

+git-net-revert-af_unix-changes.patch
+git-net-selinux-xfrm-build-fix.patch

 Fix things in git-net.patch

+spufs-build-fix.patch

 Fix git-powerpc.patch

+gregkh-pci-x86-pci-domain-support-a-humble-fix.patch
+gregkh-pci-x86-pci-domain-support-struct-pci_sysdata.patch
+gregkh-pci-x86-pci-domain-support-the-meat.patch
+gregkh-pci-pci-error-recovery-documentation.patch
+gregkh-pci-pci-hotplug-powerpc-remove-duplicated-code.patch
+gregkh-pci-pci-hotplug-powerpc-more-removal-of-duplicated-code.patch
+gregkh-pci-arch-replace-pci_module_init-with-pci_register_driver.patch
+gregkh-pci-drivers-block-replace-pci_module_init-with-pci_register_driver.patch
+gregkh-pci-drivers-net-replace-pci_module_init-with-pci_register_driver.patch
+gregkh-pci-drivers-scsi-replace-pci_module_init-with-pci_register_driver.patch
+gregkh-pci-drivers-rest-replace-pci_module_init-with-pci_register_driver.patch
+gregkh-pci-drivers-sound-oss-replace-pci_module_init-with-pci_register_driver.patch
+gregkh-pci-pci-schedule-removal-of-pci_module_init.patch
+gregkh-pci-shpchp-implement-get_address-callback.patch
+gregkh-pci-pci-quirk-1k-i-o-space-granularity-on-intel-p64h2.patch
+gregkh-pci-pciehp-handle-sticky-power-fault-status.patch
+gregkh-pci-pciehp-allow-bridged-card-hotplug.patch
+gregkh-pci-pci-use-bus-numbers-sparsely-if-necessary.patch

 PCI tree updates

+gregkh-usb-uhci-add-missing-memory-barriers.patch
-gregkh-usb-usb-gotemp.patch
+gregkh-usb-uhci-edit-some-comments.patch
+gregkh-usb-usb-let-usbmon-collect-less-garbage.patch
+gregkh-usb-usb-storage-make-onetouch-pm-aware.patch
+gregkh-usb-usb-storage-cleanups-of-sddr09.patch
+gregkh-usb-usb-storage-sddr09-cleanups.patch
+gregkh-usb-usb-storage-more-sddr09-cleanups.patch
+gregkh-usb-usb-storage-add-alauda-support.patch
+gregkh-usb-usb-storage-update-maintainers.patch
+gregkh-usb-usb-storage-add-debug-entry-for-report-luns.patch
+gregkh-usb-usb-gotemp.patch

 USB tree updates

+usb-support-for-posiflex-pp-7000-retail-printer-for-ftdi_sio-driver.patch

 USB device support

+x86_64-dont-save-eflags-in-x86-64-switch_to.patch
+x86_64-iommu-newline.patch
+x86_64-remove-pci-bus.patch
+x86_64-dmi.patch
+x86_64-fxsave-prefix.patch

 x86_64 tree updates

+x86_64-dmi-fix.patch

 Fix it.

-preserve-irq-status-in-release_pages-__pagevec_lru_add.patch

 Unneeded

+add-schedule_on_each_cpu.patch

 Used in updated swap migration patches

+swap-migration-v5-mpol_mf_move-interface-update-vma_migratable.patch

 Fix swap-migration-v5-mpol_mf_move-interface.patch

+kill-last-zone_reclaim-bits-fix.patch

 Fix kill-last-zone_reclaim-bits.patch

+make-high-and-batch-sizes-of-per_cpu_pagelists-configurable.patch
+make-high-and-batch-sizes-of-per_cpu_pagelists-configurable-fix.patch
+make-high-and-batch-sizes-of-per_cpu_pagelists-configurable-fix-fix.patch

 Make the per-cpu-pagews batchsize tunable

+consolidate-lru_add_drain-and-lru_drain_cache.patch
+simplify-build_zonelists_node-by-removing-the-case.patch
+move-determination-of-policy_zone-into-page-allocator.patch

 mm cleanups

+pcnet32-use-mac-address-from-prom-also-on-powerpc.patch

 Net driver fix

+selinux-array_size-cleanups.patch
+selinux-more-array_size-cleanups.patch

 SELinux cleanups

+macintosh-mangle-caps-lock-events-on-adb-keyboards.patch

 Dink with the ADB driver.  Probably not mergeable.

-i386-support-for-the-geode-cs5535-companion-chip.patch
-i386-support-for-the-geode-cs5535-companion-chip-tidy.patch
+i386-cs5535-chip-support-cpu.patch
+i386-cs5535-chip-support-gpio.patch
+i386-cs5535-chip-support-smbus.patch

 Updated.   Still need work.

-cpu-frequency-display-in-proc-cpuinfo.patch

 Dropped.

+arch-i386-kernel-cpuidc-unused-variable.patch

 Warning fix

+change-maxaligned_in_smp-alignemnt-macros-to-internodealigned_in_smp-macros.patch
+kill-l1_cache_shift_max.patch
+kill-l1_cache_shift_max-fix.patch
+kill-l1_cache_shift_max-fix-fix.patch

 Fiddle with the max cache alignment

+x86_64-fix-delay-resolution.patch

 Fix x86_64 delay accuracy

+alpha-convert-to-generic-irq-framework-generic-part.patch
+alpha-convert-to-generic-irq-framework-alpha-part.patch

 Use generic IRQ code on alpha

+reconfigure-msi-registers-after-resume.patch
+swsusp-limit-image-size.patch

 PM updates

+m32r-trivial-fix-to-remove-unused-instructions.patch
+m32r-support-m32104ut-target-platform.patch
+m32r-update-syscall-macros-for-mmu-less.patch
+m32r-update-_port2addr-to-use.patch
+m32r-fix-m32104-cache-flushing-routines.patch
+m32r-remove-unnecessary-icu_data_t.patch

 m32r updates

+s390-cputime_t-fixes.patch
+s390-re-activated-path-detection.patch
+s390-move-s390_root_dev_-out-of-the-cio-layer.patch
+s390-biodasdprrd-ioctl-return-code.patch
+s390-dasd-failfast-support.patch
+s390-add-oprofile-callgraph-support.patch
+s390-in-kernel-crypto-rename.patch
+s390-sha256-support.patch
+s390-aes-support.patch
+s390-in-kernel-crypto-test-vectors.patch
+s390-qdio-v=v-pass-through.patch
+s390-introduce-struct-subchannel_id.patch
+s390-introduce-for_each_subchannel.patch
+s390-introduce-struct-channel_subsystem.patch
+s390-convert-proc-cio_ignore.patch
+s390-multiple-subchannel-sets-support.patch
+s390-add-support-for-cex2a-crypto-cards.patch

 s390 updates

+cpuset-remove-marker_pid-documentation.patch
+cpuset-minor-spacing-initializer-fixes.patch
+cpuset-update_nodemask-code-reformat.patch
+cpuset-fork-hook-fix.patch
+cpuset-combine-refresh_mems-and-update_mems.patch
+cpuset-implement-cpuset_mems_allowed.patch
+cpuset-numa_policy_rebind-cleanup.patch
+cpuset-number_of_cpusets-optimization.patch
+cpuset-rebind-vma-mempolicies-fix.patch
+cpuset-rebind-vma-mempolicies-fix-fix.patch
+cpuset-rebind-vma-mempolicies-fix-tweaks.patch
+cpuset-migrate-all-tasks-in-cpuset-at-once.patch

 cpuset updates

+extend-rcu-torture-module-to-test-tickless-idle-cpu.patch
+extend-rcu-torture-module-to-test-tickless-idle-cpu-fixes.patch

 RCU updates

+update-to-the-initramfs-docs.patch

 Documentation

+fadvise-return-espipe-on-fifo-pipe.patch

 fadvise fix

+untangle-smph-vs-thread_info.patch

 Header cleanup

+dont-attempt-to-power-off-if-power-off-is-not-implemented.patch

 poweroff fix

+tpmdd-remove-global-event-log.patch
+tpmdd-remove-global-event-log-tidy.patch

 TPM driver update

+cciss-adds-msi-and-msi-x-support.patch
+cciss-adds-msi-and-msi-x-support-fix.patch

 CCISS update

+support-for-preadv-pwritev.patch
+support-for-preadv-pwritev-fix.patch

 preadv() and pwritev() syscalls.

+fork-fix-race-in-setting-childs-pgrp-and-tty.patch

 race fix

+block-stattxt.patch

 Documentation

+reduce-nr-of-ptr-derefs-in-fs-jffs2-summaryc.patch

 Microoptimisation

-ktimers-move-div_long_long_rem-out-of-jiffiesh.patch
-ktimers-remove-duplicate-div_long_long_rem-implementation.patch
-ktimers-deinline-mktime-and-set_normalized_timespec.patch
-ktimers-clean-up-mktime-and-add-const-modifiers.patch
-ktimers-export-deinlined-mktime.patch
-ktimers-remove-unused-clock-constants.patch
-ktimers-cleanup-clock-constants-coding-style.patch
-ktimers-coding-style-and-whitespace-cleanup-timeh.patch
-ktimers-make-clock-selectors-in-posix-timers-const.patch
-ktimers-coding-style-and-white-space-cleanup-posix-timerh.patch
-ktimers-create-timespec_valid-macro.patch
-ktimers-check-user-space-timespec-in-do_sys_settimeofday.patch
-ktimers-introduce-nsec_t-type-and-conversion-functions.patch
-ktimers-introduce-ktime_t-time-format.patch
-ktimers-ktimer-core-code.patch
-ktimers-ktimer-documentation.patch
-ktimers-switch-itimers-to-ktimer.patch
-ktimers-remove-now-unnecessary-includes.patch
-ktimers-introduce-ktimer_nanosleep-apis.patch
-ktimers-convert-sys_nanosleep-to-ktimer_nanosleep.patch
-ktimers-switch-clock_nanosleep-to-ktimer-nanosleep-api.patch
-ktimers-convert-posix-interval-timers-to-use-ktimers.patch
-ktimers-simplify-ktimers-rearm-code.patch
-ktimers-split-timeout-code-into-kernel-ktimeoutc.patch
-ktimers-create-ktimeouth-and-move-timerh-code-into-it.patch
-ktimers-rename-struct-timer_list-to-struct-ktimeout.patch
-ktimers-convert-timer_list-users-to-ktimeout.patch
-ktimers-convert-ktimeouth-and-create-wrappers.patch
-ktimers-convert-ktimeoutc-to-ktimeout-struct-and-apis.patch
-ktimers-ktimeout-documentation.patch
-ktimers-rename-init_ktimeout-to-ktimeout_init.patch
-ktimers-rename-setup_ktimeout-to-ktimeout_setup.patch
-ktimers-rename-add_ktimeout_on-to-ktimeout_add_on.patch
-ktimers-rename-del_ktimeout-to-ktimeout_del.patch
-ktimers-rename-__mod_ktimeout-to-__mod_ktimeout.patch
-ktimers-rename-mod_ktimeout-to-ktimeout_mod.patch
-ktimers-rename-next_ktimeout_interrupt-to.patch
-ktimers-rename-add_ktimeout-to-ktimeout_add.patch
-ktimers-rename-try_to_del_ktimeout_sync-to.patch
-ktimers-rename-del_ktimeout_sync-to-del_ktimeout_sync.patch
-ktimers-rename-del_singleshot_ktimeout_sync-to.patch
-ktimers-rename-timer_softirq-to-timeout_softirq.patch
-ktimers-ktimeout-code-style-cleanups.patch
-ktimers-ktimeout-code-style-cleanups-fix.patch
+hrtimer-move-div_long_long_rem-out-of-jiffiesh.patch
+hrtimer-move-div_long_long_rem-out-of-jiffiesh-sparc64-fix.patch
+hrtimer-remove-duplicate-div_long_long_rem-implementation.patch
+hrtimer-deinline-mktime-and-set_normalized_timespec.patch
+hrtimer-clean-up-mktime-and-make-arguments-const.patch
+hrtimer-export-deinlined-mktime.patch
+hrtimer-remove-unused-clock-constants.patch
+hrtimer-coding-style-clean-up-of-clock-constants.patch
+hrtimer-coding-style-and-white-space-cleanup.patch
+hrtimer-make-clockid_t-arguments-const.patch
+hrtimer-coding-style-and-white-space-cleanup-2.patch
+hrtimer-create-and-use-timespec_valid-macro.patch
+hrtimer-validate-timespec-of-do_sys_settimeofday.patch
+hrtimer-introduce-nsec_t-type-and-conversion-functions.patch
+hrtimer-introduce-ktime_t-time-format.patch
+hrtimer-hrtimer-core-code.patch
+hrtimer-hrtimer-documentation.patch
+hrtimer-switch-itimers-to-hrtimer.patch
+hrtimer-create-hrtimer-nanosleep-api.patch
+hrtimer-switch-sys_nanosleep-to-hrtimer.patch
+hrtimer-switch-clock_nanosleep-to-hrtimer-nanosleep-api.patch
+hrtimer-convert-posix-timers-completely.patch
+hrtimer-convert-posix-timers-completely-fix.patch

 New hrtimer implementation

+v4l-926_2-moves-compat32-functions-from-fs-to-v4l.patch
+v4l-963-explicit-compat_ioctl32-handler-to-em28xx.patch
+v4l-dvb-3120-adds-32-bit-compatibility-for-v4l2.patch
+v4l-0987-added-secam-l-std-on-tda9887-and-common.patch
+v4l-1019-added-basic-support-tv-radio-for.patch
+v4l-1023-added-hauppauge-impactvcb-board.patch
+v4l-0979-added-v4l-support-for-the-nova-s-plus-and.patch
+v4l-0990-enable-ir-support-for-the-nova-s-plus.patch
+v4l-1007-add-support-for-kworld-dvb-s-100.patch
+v4l-0988-tuner-cleanups-by-removing-video-if-from.patch
+v4l-1021-tuner-description-now-follows-the-same.patch
+dvb-2420-makes-integration-of-future-devices-easier.patch
+dvb-2421-fixed-oddities-at-firmware-download.patch
+dvb-2428-fixes-for-the-topuptv-scm-mediaguard-cam.patch
+dvb-2431-fixed-dishnetwork-support-for-nexus-s-rev.patch
+dvb-2432-lnb-power-can-now-be-switched-off-for.patch
+dvb-2440-fixed-mpeg-audio-on-spdif-from-nexus-ca.patch
+dvb-2441-driver-support-for-live-ac3-firmware-=.patch
+dvb-2444-implement-frontend-specific-tuning-and.patch
+dvb-2445-added-demodulator-driver-for-nova-s-plus.patch
+dvb-2446-minor-cleanups.patch
+dvb-2451-add-support-for-kworld-dvb-s-100-based.patch
+dvb-2454-port-code-for-su1278-sh2-tua6100-from.patch
+dvb-2390-adds-a-time-delay-to-ir-remote-button.patch
+v4l-dvb-3062-fix-wrong-tunerh-define-for-tuner-46.patch
+v4l-dvb-3064-some-cleanups-on-msp3400.patch
+v4l-dvb-3065-fix-gcc-402-compile-error-in.patch
+v4l-dvb-3081-added-offset-parameter-for-adjusting.patch
+v4l-dvb-3084-added-a-new-debug-msg-to-help.patch
+v4l-dvb-3086-vfreenull-is-legal.patch
+v4l-dvb-3089-adding-support-for-the-hauppauge.patch
+v4l-dvb-3090-cleanup-check-for-dvb.patch
+v4l-dvb-3092-add-support-for-another-nova-t-pci.patch
+v4l-dvb-3099-fixed-device-controls-for-em28xx-on.patch
+v4l-dvb-3100-fix-compile-error-remove-dead-code.patch
+v4l-dvb-3103-add-vidioc_log_status-to-tuner-corec.patch
+v4l-dvb-3104-msp3400-miscelaneous-fixes.patch
+v4l-dvb-3105-remove-audc_config_pinnacle-horror.patch
+v4l-dvb-3108-tveeprom-cleanup-of-hardcoded-tuner.patch
+v4l-dvb-3112-several-fixes-for-hauppauge-roselyn.patch
+v4l-dvb-3115-add-missing-video_adv_debug-config.patch
+v4l-dvb-3116-tda9887-improvements-better.patch
+v4l-dvb-3117-fix-broken-tv-standard-check.patch
+v4l-dvb-3118-enable-remote-control-on-avertv.patch
+v4l-dvb-3123-include-reorder-to-be-in-sync-with.patch
+v4l-dvb-3123a-remove-uneeded-if-from-v4l-subsystem.patch
+v4l-dvb-3123b-syncs-v4l-subsystem-tree-with-kernel.patch
+v4l-dvb-3129-correct-fe_read_uncorrected_blocks.patch
+v4l-dvb-3130-cx24123-cleanup-timout-handling.patch
+v4l-dvb-3145-syncronizes-some-changes-between-v4l.patch

 v4l/dvb updates

+scheduler-cache-hot-autodetect-section-fixes.patch
+scheduler-cache-hot-autodetect-limit-to-affected-cpu-map.patch
+scheduler-cache-hot-autodetect-be-less-verbose.patch

 Update scheduler-cache-hot-autodetect.patch

+sched-add-sched_batch-policy.patch

 New CPU scheduler policy

+ide-restore-support-for-aec6280m-cards-in-aec62xxc.patch
+via82cxxx-ide-add-vt8251-isa-bridge.patch

 IDE updates

+nvidiafb-fix-6xxx-7xxx-cards.patch
+fbcon-add-ability-to-save-restore-graphics-state.patch
+fbdev-pan-display-fixes.patch
+rivafb-trim-rivafb_pan_display.patch
+savagefb-trim-savagefb_pan_display.patch
+vesafb-trim-vesafb_pan_display.patch
+vga16fb-trim-vga16fb_pan_display.patch
+fbcon-avoid-illegal-display-panning.patch
+atyfb-fix-spelling.patch
+atyfb-reduce-verbosity.patch
+atyfb-fix-crtc_fifo_lwm-mask.patch
+atyfb-fix-interlaced-modes.patch
+atyfb-dont-stretch-with-crt.patch
+atyfb-set-ecp-divider.patch
+atyfb-improve-blanking.patch
+atyfb-rage-xl-xc-cleanup.patch
+atyfb-vt-gt-cleanup.patch
+atyfb-lt-lg-cleanup.patch
+nvidiafb-add-support-for-some-pci-e-chipsets.patch
+nvidiafb-add-support-for-some-pci-e-chipsets-fix.patch
+fbdev-fixing-switch-to-kd_text-enhanced-version.patch
+skeletonfb-documentation-update.patch

 fbdev updates

+page-owner-tracking-leak-detector-fix.patch

 Fix page-owner-tracking-leak-detector.patch

+decrease-number-of-pointer-derefs-in-exitc.patch
+decrease-number-of-pointer-derefs-in-flexcop-fe-tunerc.patch
+decrease-number-of-pointer-derefs-in-nfnetlink_queuec.patch
+decrease-number-of-pointer-derefs-in-nf_conntrack_corec.patch
+decrease-number-of-pointer-derefs-in-multipathc.patch
+decrease-number-of-pointer-derefs-in-connectionc.patch
+decrease-number-of-pointer-derefs-in-jsm_ttyc.patch

 Microoptimisations



All 1164 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/patch-list


