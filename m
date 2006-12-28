Return-Path: <linux-kernel-owner+w=401wt.eu-S1754811AbWL1Kmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbWL1Kmr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754808AbWL1Kmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:42:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48285 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805AbWL1Kmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:42:45 -0500
Date: Thu, 28 Dec 2006 02:42:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc2-mm1
Message-Id: <20061228024237.375a482f.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/


- Various updates.  Things are pretty quiet at present.

  There are quite a few things here which are needed for 2.6.20 but which go
  through subsystem maintainers, when people wake up again.



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git-fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git tag v2.6.16-rc2-mm1
  git-checkout -b local-v2.6.16-rc2-mm1 v2.6.16-rc2-mm1

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



Changes since 2.6.20-rc1-mm1:


 git-acpi.patch
 git-alsa.patch
 git-agpgart.patch
 git-avr32.patch
 git-cifs.patch
 git-cpufreq.patch
 git-dvb.patch
 git-gfs2-nmw.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mmc.patch
 git-mtd.patch
 git-ubi.patch
 git-netdev-all.patch
 git-ioat.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-selinux.patch
 git-pciseg.patch
 git-s390.patch
 git-sh.patch
 git-sas.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-wireless.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees

-infiniband-work-around-gcc-bug-on-sparc64.patch
-kvm-add-valid_vcpu-helper.patch
-kvm-amd-svm-handle-msr_star-in-32-bit-mode.patch
-kvm-amd-svm-save-and-restore-the-floating-point-unit.patch
-config_vm_event_counter-comment-decrustify.patch
-conditionally-check-expected_preempt_count-in-__resched_legal.patch
-fix-for-shmem_truncate_range-bug_on.patch
-rtc-warning-fix.patch
-slab-fix-kmem_ptr_validate-prototype.patch
-fix-kernel-doc-warnings-in-2620-rc1.patch
-make-kernel-printkcignore_loglevel_setup-static.patch
-fs-sysv-proper-prototypes-for-2-functions.patch
-fix-swapped-parameters-in-mm-vmscanc.patch
-add-cscope-generated-files-to-gitignore.patch
-sched-remove-__cpuinitdata-anotation-to-cpu_isolated_map.patch
-fix-vm_events_fold_cpu-build-breakage.patch
-fix-vm_events_fold_cpu-build-breakage-fix.patch
-build-compileh-earlier.patch
-workstruct-add-assign_bits-to-give-an-atomic-bitops-safe-assignment.patch
-workstruct-use-bitops-safe-direct-assignment.patch
-git-acpi-cpufreq-fixup.patch
-acpi-clear-gpe-before-disabling-it.patch
-acpi-fix-single-linked-list-manipulation.patch
-acpi-processor-prevent-loading-module-on-failures.patch
-acpi-replace-kmallocmemset-with-kzalloc.patch
-make-drivers-acpi-eccec_ecdt-static.patch
-drivers-acpi-oslc-fix-a-null-check.patch
-acpi-dont-select-pm.patch
-implementation-of-acpi_video_get_next_level.patch
-video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
-fbdev-update-after-backlight-argument-change.patch
-add-display-output-class-support.patch
-add-output-class-document.patch
-add-support-for-asus-a6va-m6v-w5f-v6v-laptops-in-asus-acpi.patch
-add-support-for-acpi_load_table-acpi_unload_table_id.patch
-altix-acpi-ssdt-pci-device-support.patch
-altix-add-acpi-ssdt-pci-device-support-hotplug.patch
-acpi-make-code-static.patch
-acpi-dock-send-a-uevent-to-indicate-a-device-change.patch
-alsa-workqueue-fixes.patch
-agp-fix-detection-of-aperture-size-versus-gtt-size-on-g965.patch
-arm-systemh-build-fix.patch
-audit-fix-kstrdup-error-check.patch
-cpufreq-select-consistently-re-2619-rc5-mm1.patch
-cpufreq-set-policy-curfreq-on-initialization.patch
-bug-fix-for-acpi-cpufreq-and-cpufreq_stats-oops-on-frequency-change-notification.patch
-gregkh-driver-uio.patch
-gregkh-driver-uio-documentation.patch
-gregkh-driver-uio-dummy.patch
-gregkh-driver-uio-irq.patch
-tty-switch-to-ktermios-nozomi-fix.patch
-kobject-kobject_uevent-returns-manageable-value.patch
-proper-prototype-for-drivers-base-initcdriver_init.patch
-kref-refcnt-and-false-positives.patch
-saa7134-add-support-for-the-encore-enl-tv.patch
-drivers-media-video-cpia2-cpia2_usbc-free.patch
-fix-namespace-conflict-between-w9968cfc-on-mips.patch
-usbvision-possible-cleanups.patch
-jdelvare-hwmon-hwmon-unchecked-return-status-fixes-abituguru.patch
-make-lm70_remove-a-__devexit-function.patch
-gregkh-i2c-i2c-device-id-lm75.patch
-fs-dlm-lowcomms-tcpc-remove-2-functions.patch
-infiniband-fix-for-gregkh-depredations.patch
-pci-move-pci_vdevice-from-libata-to-core.patch
-pata_cs5530-suspend-resume-support-tweak.patch
-pata_sil680-suspend-resume-tidy.patch
-ata-fix-platform_device_register_simple-error-check.patch
-initializer-entry-defined-twice-in-pata_rz1000.patch
-pata_via-suspend-resume-support-fix.patch
-libata-simulate-report-luns-for-atapi-devices.patch
-user-of-the-jiffies-rounding-patch-ata-subsystem.patch
-libata-fix-oops-with-sparsemem.patch
-sata_nv-fix-kfree-ordering-in-remove.patch
-libata-dont-initialize-sg-in-ata_exec_internal-if-dma_none-take-2.patch
-git-mmc-fixup.patch
-git-mmc-tifm_sd-warning-fix.patch
-ubi-versus-add-include-linux-freezerh-and-move-definitions-from.patch
-driver-for-silan-sc92031-netdev.patch
-driver-for-silan-sc92031-netdev-fixes.patch
-driver-for-silan-sc92031-netdev-include-fix.patch
-driver-for-silan-sc92031-netdev-fix-more.patch
-remove-the-broken-skmc-driver.patch
-spidernet-dma-coalescing.patch
-spidernet-add-net_ratelimit-to-suppress-long-output.patch
-spidernet-remove-rxramfull-tasklet.patch
-spidernet-cleanup-un-needed-api.patch
-spidernet-rx-skb-mem-leak.patch
-spidernet-another-skb-mem-leak.patch
-spidernet-cleanup-return-codes.patch
-spidernet-rx-refill.patch
-spidernet-remove-unused-variable.patch
-spidernet-rx-chain-tail.patch
-spidernet-memory-barrier.patch
-spidernet-avoid-possible-rx-chain-corruption.patch
-spidernet-rx-debugging-printout.patch
-ep93xx-some-minor-cleanups-to-the-ep93xx-eth-driver.patch
-problem-phy-probe-not-working-properly-for-ibm_emac-ppc4xx.patch
-gss_spkm3-fix-error-handling-in-module-init.patch
-powerpc-iseries-link-error-in-allmodconfig.patch
-gregkh-pci-pci-use-sys-bus-pci-drivers-driver-new_id-first.patch
-gregkh-pci-pci-add-class-codes-for-wireless-rf-controllers.patch
-gregkh-pci-pci-quirks-remove-redundant-check.patch
-gregkh-pci-rpaphp-compiler-warning-cleanup.patch
-gregkh-pci-pci-pcieport-driver-remove-invalid-warning-message.patch
-gregkh-pci-pci-introduce-pci_find_present.patch
-gregkh-pci-pci-create-__pci_bus_find_cap_start-from-__pci_bus_find_cap.patch
-gregkh-pci-pci-add-pci_find_ht_capability-for-finding-hypertransport-capabilities.patch
-gregkh-pci-pci-use-pci_find_ht_capability-in-drivers-pci-htirq.c.patch
-gregkh-pci-pci-add-defines-for-hypertransport-msi-fields.patch
-gregkh-pci-pci-use-pci_find_ht_capability-in-drivers-pci-quirks.c.patch
-gregkh-pci-pci-only-check-the-ht-capability-bits-in-mpic.c.patch
-gregkh-pci-pci-fix-multiple-problems-with-via-hardware.patch
-gregkh-pci-pci-be-a-bit-defensive-in-quirk_nvidia_ck804-so-we-don-t-risk-dereferencing-a-null-pdev.patch
-dont-export-device-ids-to-userspace.patch
-via-sb600-sata-quirk.patch
-pci-legacy-resource-fix.patch
-pci-legacy-resource-fix-tidy.patch
-pci-disable-multithreaded-probing.patch
-scsi-fix-uaccess-handling.patch
-scsi-in2000-scsi_cmnd-convertion.patch
-fix-sense-key-medium-error-processing-and-retry.patch
-aic79xx-wrong-max-memory-at-driver-init.patch
-scsi-cover-up-bugs-fix-up-compiler-warnings-in-megaraid-driver-fix.patch
-gregkh-usb-usb-fix-oops-in-phidgetservo.patch
-gregkh-usb-usb-transvibrator-disconnect-race.patch
-gregkh-usb-usb-airprime-add-device-id-for-dell-wireless-5500-hsdpa-card.patch
-gregkh-usb-usb-ftdi_sio-machx-product-id-added.patch
-gregkh-usb-usb-removing-ifdefed-code-from-gl620a.patch
-gregkh-usb-usb-serial-eliminate-bogus-ioctl-code.patch
-gregkh-usb-usb-mutexification-of-usblp.patch
-gregkh-usb-add-baltech-reader-id-to-cp2101-driver.patch
-gregkh-usb-usb-prevent-the-funsoft-serial-device-from-entering-raw-mode.patch
-gregkh-usb-usb-fix-ohci.h-over-use-warnings.patch
-gregkh-usb-usb-rtl8150-new-device-id.patch
-gregkh-usb-usb-storage-ignore-the-virtual-cd-drive-of-the-huawei-e220-usb-modem.patch
-gregkh-usb-usb-gsm-driver-added-vendorid-and-productid-for-huawei-e220-usb-modem.patch
-gregkh-usb-usb-fix-wacom-intuos3-4x6-bugs.patch
-gregkh-usb-usb-auerswald-replace-kmalloc-memset-with-kzalloc.patch
-gregkh-usb-usb-nokia-e70-is-an-unusual-device.patch
-gregkh-usb-uhci-module-parameter-to-ignore-overcurrent-changes.patch
-gregkh-usb-usb-gadget-driver-unbind-is-optional-section-fixes-misc.patch
-gregkh-usb-usb-maintainers-update-ehci-and-ohci.patch
-gregkh-usb-usb-ohci-whitespace-comment-fixups.patch
-gregkh-usb-usb-ohci-at91-warning-fix.patch
-gregkh-usb-usb-ohci-handles-hardware-faults-during-root-port-resets.patch
-gregkh-usb-usb-ohci-support-for-pnx8550.patch
-gregkh-usb-usb-at91-udc-support-at91sam926x-addresses.patch
-gregkh-usb-usb-at91_udc-misc-fixes.patch
-gregkh-usb-usb-u132-hcd-ftdi-elan-add-support-for-option-gt-3g-quad-card.patch
-gregkh-usb-usb-at91_udc-allow-drivers-that-support-high-speed.patch
-gregkh-usb-usb-at91_udc-cleanup-variables-after-failure-in-usb_gadget_register_driver.patch
-gregkh-usb-usb-at91_udc-additional-checks.patch
-gregkh-usb-usb-ehci-hcd-make-ehci_iso_stream-instances-more-persistent.patch
-gregkh-usb-usb-ehci-hcd-periodic-startup-shutdown-centralization-and-hysteresis.patch
-gregkh-usb-usb-ehci-hcd-group-interrupt-endpoint-code-into-one-place.patch
-gregkh-usb-usb-ehci-hcd-group-ehci_iso_sched-functions-into-one-place.patch
-gregkh-usb-usb-ehci-hcd-group-ehci_iso_sched-and-ehci_itd-code.patch
-gregkh-usb-usb-ehci-hcd-group-ehci_sitd-code-in-one-place.patch
-gregkh-usb-usb-ehci-hcd-refactor-sitd-link-patch-code-for-easier-frame-spanning.patch
-gregkh-usb-usb-ehci-hcd-split-scan_periodic-to-reuse-code-for-spanned-completions.patch
-gregkh-usb-usb-ehci-hcd-unify-interval-granularity-and-limit-depth-of-interrupt-tree.patch
-gregkh-usb-usb-ehci-hcd-add-shadow-budget-code.patch
-gregkh-usb-usb-ehci-hcd-activate-shadow-budget-tracking.patch
-gregkh-usb-usb-ehci-hcd-activate-use-of-shadow-budget-for-scheduling-decisions.patch
-gregkh-usb-usb-ehci-hcd-add-fstn-support.patch
-gregkh-usb-usb-ehci-hcd-add-sitd-frame-spanning-support.patch
-gregkh-usb-ehci-hcd-fix-budget_pool-allocation-for-machines-with-multiple-ehci-controllers.patch
-gregkh-usb-usb-usbaudio-correct-bug-caused-by-harmless-underrun-during-playback-setup.patch
-gregkh-usb-usb-print_schedule_frame-defined-but-not-used-warning-fix.patch
-gregkh-usb-ehci-fix-memory-pool-name-allocation.patch
-gregkh-usb-ehci-eliminate-fstn-leaks-on-ehci-shutdown.patch
-gregkh-usb-ehci-correct-harmless-bracketing-and-whitespace-errors.patch
-gregkh-usb-usb-serial-dynamic-id.patch
-funsoft-is-bust-on-sparc.patch
-usb-serial-add-support-for-novatel-s720-u720-cdma-ev-do.patch
-bluetooth-add-support-for-another-kensington-dongle.patch
-fix-gregkh-usb-usb-ehci-hcd-add-shadow-budget-code.patch
-input-usb-supporting-more-keys-from-the-hut-consumer-page.patch
-usblp-add-serial-number-to-device-id.patch
-m68k-trivial-build-fixes.patch
-jbd-wait-for-already-submitted-t_sync_datalist-buffer.patch

 Merged into mainline or a subsystem tree

+fix-ipmi-watchdog-set_param_str-using-kstrdup.patch
+aio-fix-buggy-put_ioctx-call-in-aio_complete.patch
+fix-lock-inversion-aio_kick_handler.patch
+powerpc-iseries-link-error-in-allmodconfig.patch
+change-warn_on-back-to-bug-at.patch
+rcu-rcutorture-suspend-fix.patch
+fix-oom-killer-kills-current-every-time-if-there-is.patch
+add-gitignore-file-for-relocs-in-arch-i386.patch
+pci-probe-fix-macro-that-confuses-kernel-doc.patch
+char-mxser-fix-oops-when-removing-opened.patch
+ib-mthca-fix-fmr-breakage-caused-by-kmemdup-conversion.patch
+maintainers-email-addr-change-for-eric-moore.patch
+make-fn_keys-work-again-on-power-macbooks.patch
+char-isicom-eliminate-spinlock-recursion.patch
+update-to-documentation-ttytxt-on-line-disciplines.patch
+fix-mrproper-incompleteness.patch
+sched-fix-cond_resched_softirq-offset.patch
+fix-compilation-of-via-pmu-backlight.patch
+module-fix-mod_sysfs_setup-return-value.patch
+mm-ramfs-breaks-without-config_block.patch
+mm-slob-is-broken-by-recent-cleanup-of-slabh.patch
+cciss-build-with-proc_fs=n.patch
+page_mkclean_one-fix-call-to-set_pte_at.patch
+spi-define-null-tx_buf-to-mean-shift-out-zeroes.patch
+m25p80-build-fixes-with-mtd-debug.patch
+spi-mtd-mtd_dataflash-oops-prevention.patch
+arm-omap-fix-gpmc-compiler-errors.patch
+arm-omap-fix-missing-header-on-apollon-board.patch
+buglet-in-vmscanc.patch
+cpuset-procfs-warning-fix.patch
+respect-srctree-objtree-in-documentation-docbook-makefile.patch
+spi_s3c24xx_gpio-use-right-header.patch
+lockdep-printk-warning-fix.patch

 2.6.20 queue

+down_write-preserve-local-irqs.patch
+fix-garbage-instead-of-zeroes-in-ufs.patch
+shrink_all_memory-fix-lru_pages-handling.patch
+restore-pdeath_signal-behaviour.patch

 Maybe 2.6.20 queue

+cifs-sprintf-fix.patch

 cifs fixlet

+ppc-use-syslog-macro-for-the-printk-log-level.patch
+powerpc-use-is_init.patch
+fix-bogus-bug_on-in-in-hugetlb_get_unmapped_area.patch

 powerpc things

+gregkh-driver-driver-core-warn-users-that-the-sysfs-power-interface-really-is-broken.patch
+gregkh-driver-driver-core-prefix-driver-links-in-sys-module-by-bus-name.patch
+gregkh-driver-driver-core-fix-race-in-sysfs-between-sysfs_remove_file-and-read-write.patch
+gregkh-driver-uio.patch
+gregkh-driver-uio-documentation.patch
+gregkh-driver-uio-dummy.patch
+gregkh-driver-uio-irq.patch

 driver tree updates

+fix-gregkh-driver-driver-core-fix-race-in-sysfs-between-sysfs_remove_file-and-read-write.patch

 Fix it.

+jdelvare-i2c-i2c-pnx-fix-interrupt-handler.patch
+jdelvare-i2c-i2c-pnx-add-maintainer.patch
+jdelvare-i2c-i2c-ali1563-cleanup-messages.patch
+jdelvare-i2c-i2c-vt8231-remove-superfluous-initialization.patch
+jdelvare-i2c-i2c-nforce2-drop-unused-reference-to-pci_dev.patch
+jdelvare-i2c-i2c-piix4-add-ati-sb600-support.patch

 I2C tree updates

+jdelvare-hwmon-hwmon-it87-pwm-freq.patch
+jdelvare-hwmon-hwmon-drop-unused-mutexes.patch
+jdelvare-hwmon-hwmon-simplify-locking-1.patch
+jdelvare-hwmon-hwmon-legacy-comment-fix.patch
+jdelvare-hwmon-hwmon-lm70-make-lm70_remove-a-devexit-function.patch
+jdelvare-hwmon-hwmon-should-subsys-init.patch
+jdelvare-hwmon-hwmon-w83627ehf-add-w83627dhg-support.patch

 hwmon tree updates

+ia64-alignment-bug-in-ldscript.patch
+ia64-virt_to_page-can-be-called-with-null-arg.patch
+altix-acpi-ssdt-pci-device-support.patch
+altix-add-acpi-ssdt-pci-device-support-hotplug.patch
+altix-acpi-_prt-support.patch

 ia64 stuff

+git-iee1394-printk-warning-fix.patch
+git-ieee1394-build-fix.patch
+git-ieee1394-build-fix-2.patch
+git-ieee1394-build-fix-3.patch

 Fix git-ieee1394.patch

+infiniband-fix-for-gregkh-driver-network-device.patch
+infiniband-work-around-gcc-bug-on-sparc64.patch
+ehca-fix-do_mmap-error-check.patch
+ehca-avoid-crash-on-kthread_create-failure.patch
+ehca-fix-memleak-on-module-unloading.patch

 infiniband things

+search-a-little-harder-for-mkimage.patch
+make-mkcompile_h-use-lang=c-and-lc_all=c-for-cc-v.patch
+add-mailmap-for-proper-git-shortlog-output.patch
+qconf-immediately-update-integer-and-string-values-in-xconfig-display.patch

 kbuild updates

+git-libata-all-fixup.patch

 Fix rejects in git-libata-all.patch

+libata-scsi-ata_task_ioctl-should-return-ata-registers-from.patch

 libata fix

+mips-turbochannel-update-to-the-driver-model.patch
+mips-turbochannel-support-for-the-decstation.patch
+mips-eisa-registration-with-config_eisa.patch
+mips-declance-driver-model-for-the-pmad-a.patch
+mips-defxx-turbochannel-support.patch
+mips-pmag-ba-fb-convert-to-the-driver-model.patch
+mips-pmagb-b-fb-convert-to-the-driver-model.patch
+mips-dec_esp-driver-model-for-the-pmaz-a.patch

 MIPS turbochannel updates

+mmc-add-support-for-sdhc-cards.patch

 MMC update

+git-ubi-build-fix.patch
+git-ubi-mtd_read-arg-fix.patch
+ubi-missing-include.patch

 UBI tree fixes

+b44-fix-frequent-link-changes.patch

 b44 netdev fix

+cxgb3-main-header-files.patch
+cxgb3-main-source-file.patch
+cxgb3-hw-access-routines.patch
+cxgb3-scatter-gather-engine.patch
+cxgb3-on-board-memory-mac-and-phy.patch
+cxgb3-offload-header-files.patch
+cxgb3-offload-capabilities.patch
+cxgb3-register-definitions.patch
+cxgb3-build-files-and-versioning.patch
+cxgb3-vs-gregkh-driver-network-device.patch

 New net driver

+net-irda-proper-prototypes.patch
+ebtables-dont-compute-gap-before-checking-struct.patch

 net fixes

-nfs-kill-obsolete-nfs_paranoia.patch
+nfs-kill-the-obsolete-nfs_paranoia.patch

 updated

+pnx8550-uart-driver-fixes.patch

 fix pnx8550-uart-driver.patch

+8250-make-probing-for-txen-bug-a-config-option.patch

 serial fix

+gregkh-pci-pci-disable-pci_multithread_probe.patch
+gregkh-pci-pci-remove-too-specialized-__pci_enable_device-for-default-resume.patch
+gregkh-pci-pci-move-pci_fixup_device-and-is_enabled.patch
+gregkh-pci-pci-add-extremely-specialized-__pci_reenable_device.patch
+gregkh-pci-pci-add-selected_regions-funcs.patch
+gregkh-pci-pci-define-inline-for-test-of-channel-error-state.patch
+gregkh-pci-pci-use-newly-defined-pci-channel-offline-routine.patch
+gregkh-pci-pci-quirks.c-cleanup.patch

 PCI tree updates

+pci-quirk-1k-i-o-space-iobl_adr-fix-on-p64h2.patch
+pciehp-cleanup-init_slot.patch
+pciehp-cleanup-slot-list.patch
+pciehp-remove-unnecessary-php_ctlr.patch
+pciehp-remove-unused-pci_bus-from-struct-controller.patch
+pciehp-cleanup-register-access.patch
+pciehp-cleanup-pciehph.patch
+pciehp-remove-unused-pcie_cap_base.patch
+pciehp-cleanup-wait-command-completion.patch
+pciehp-fix-wait-command-completion.patch
+pciehp-add-emi-support.patch
+update-documentation-pcitxt.patch

 PCI updates

+gregkh-usb-uhci-make-test-for-asus-motherboard-more-specific.patch
+gregkh-usb-uhci-support-device_may_wakeup.patch
+gregkh-usb-usb-fix-interaction-between-different-interfaces-in-an-option-usb-device.patch
+gregkh-usb-usb-funsoft-is-borken-on-sparc.patch
+gregkh-usb-usb-omap_udc-build-fixes.patch
+gregkh-usb-usb-rework-the-ohci-quirk-mecanism-as-suggested-by-david.patch
+gregkh-usb-usb-implement-support-for-split-endian-ohci.patch
+gregkh-usb-usb-implement-support-for-ehci-with-big-endian-mmio.patch
+gregkh-usb-usb-linux-usb_ch9.h-becomes-linux-usb-ch9.h.patch
+gregkh-usb-usb-define-usb_class_misc-in-linux-usb-ch9.h.patch
+gregkh-usb-usb-remove-unneeded-void-casts-in-idmouse.c.patch
+gregkh-usb-usb-usbtouchscreen-make-itm-screens-report-btn_touch-as-zero-when-not-touched.patch
+gregkh-usb-usb-mutexification-of-rio500.patch
+gregkh-usb-usb-devio.c-add-missing-init_list_head.patch
+gregkh-usb-usb-indicate-active-altsetting-in-proc-bus-usb-devices-file.patch
+gregkh-usb-usbcore-remove-unneeded-error-check.patch
+gregkh-usb-usb-ethernet-gadget-interop-with-mcci-windows-driver.patch
+gregkh-usb-rndis_host-learns-activesync-basics.patch
+gregkh-usb-ohci-rework-bus-glue-integration-to-allow-several-at-once.patch
+gregkh-usb-ohci-add-support-for-ohci-controller-on-the-of_platform-bus.patch
+gregkh-usb-usb-serial-add-dynamic-id-support-to-usb-serial-core.patch
+gregkh-usb-usb-serial-add-driver-pointer-to-all-usb-serial-drivers.patch
+gregkh-usb-usb-bugfix-for-aircable-add-module-and-name-to-usb_serial_driver.patch

 USB tree updates

+revert-gregkh-usb-usb-implement-support-for-split-endian-ohci.patch
+revert-gregkh-usb-usb-implement-support-for-ehci-with-big-endian-mmio.patch
+revert-gregkh-usb-ohci-add-support-for-ohci-controller-on-the-of_platform-bus.patch

 Remove a few things from it.

+usb-interrupt-endpoint-support-for-keyspan-usb-to-serial.patch

 USB fix

-x86_64-mm-defconfig-update.patch
-x86_64-mm-i386-defconfig-update.patch

 Dropped due to rejects

-convert-i386-pda-code-to-use-%fs-fixes.patch

 Folded into convert-i386-pda-code-to-use-%fs.patch

+convert-i386-pda-code-to-use-%fs-ptrace-make-putgetreg-work-again-for-gs-and-fs.patch

 x86 fix

-add-memcpy_uncached_read-fix.patch
-add-memcpy_uncached_read-tidy.patch

 Folded into add-memcpy_uncached_read.patch

+paravirt-page-allocation-hooks-for-vmi-backend.patch
+paravirt-paravirt-cpu-hypercall-batching-mode.patch
+paravirt-iopl-handling-for-paravirt-guests.patch
+paravirt-smp-boot-hook-for-paravirt.patch
+paravirt-vmi-backend-for-paravirt-ops.patch
+paravirt-vmi-timer-patches.patch
+i386-cpu-hotplug-smpboot-misc-modpost-warning-fixes.patch
+convert-some-functions-to-__init-to-avoid-modpost-warnings.patch
+i386-move-startup_32-in-texthead-section.patch
+break-init-in-two-parts-to-avoid-modpost-warnings.patch
+i386-fix-memory-hotplug-related-modpost-generated-warning.patch
+arch-i386-kernel-cpu-mcheck-mcec-should-include-asm-mceh.patch
+add-i386-idle-notifier-take-3.patch
+add-i386-idle-notifier-take-3-fix.patch
+sched-improve-sched_clock-on-i686.patch
+sched-improve-sched_clock-on-i686-fix.patch
+x86-64-system-crashes-when-no-memory-populating-node-0.patch
+mmconfig-fix-x86_64-ioremap-base_address.patch
+romsignature-checksum-cleanup.patch
+mm-set-hashdist_default-to-1-for-x86_64-numa.patch
+i386-restore-config_physical_start-option.patch
+i386-make-apic-probe-function-non-init.patch
+modpost-add-more-symbols-to-whitelist-pattern2.patch
+modpost-whitelist-reference-to-more-symbols-pattern-3.patch

 x86/x86_64 updates

-virtual-memmap-on-sparsemem-v3-map-and-unmap.patch
-virtual-memmap-on-sparsemem-v3-map-and-unmap-fix.patch
-virtual-memmap-on-sparsemem-v3-map-and-unmap-fix-2.patch
-virtual-memmap-on-sparsemem-v3-map-and-unmap-fix-3.patch
-virtual-memmap-on-sparsemem-v3-generic-virtual.patch
-virtual-memmap-on-sparsemem-v3-generic-virtual-fix.patch
-virtual-memmap-on-sparsemem-v3-static-virtual.patch
-virtual-memmap-on-sparsemem-v3-static-virtual-update.patch
-virtual-memmap-on-sparsemem-v3-ia64-support.patch
-virtual-memmap-on-sparsemem-v3-ia64-support-update.patch

 Dropped

+lumpy-reclaim-cleanup.patch

 Clean up lumpy reclaim

-nfs-fix-nr_file_dirty-underflow.patch
-nfs-fix-nr_file_dirty-underflow-tidy.patch

 Dropped (old)

+avoid-excessive-sorting-of-early_node_map.patch
+avoid-excessive-sorting-of-early_node_map-tidy.patch
+proc-zoneinfo-fix-vm-stats-display.patch

 MM updates

+make-reading-proc-sys-kernel-cap-bould-not-require.patch

 /proc permissions fix

+bluetooth-blacklist-lenovo-r60e.patch

 bluetooth driver fix

-vmscanc-account-for-memory-already-freed-in-seeking-to.patch

 Dropped

+pm-change-code-ordering-in-mainc.patch
+swsusp-change-code-ordering-in-diskc.patch
+swsusp-change-code-ordering-in-userc.patch
+swsusp-change-code-ordering-in-userc-sanity.patch
+swsusp-change-pm_ops-handling-by-userland-interface.patch

 swsusp updates

+drivers-add-lcd-support-update-9.patch

 More work on the LCD driver

-parse-boot-parameter-error.patch

 Dropped

+toshiba-tc86c001-ide-driver-take-2-fix.patch
+toshiba-tc86c001-ide-driver-take-2-fix-2.patch

 Fix toshiba-tc86c001-ide-driver-take-2.patch

+disable-init-initramfsc-updated-fix.patch

 Fix disable-init-initramfsc-updated.patch

+schedule_on_each_cpu-use-preempt_disable.patch
+struct-vfsmount-keep-mnt_count-mnt_expiry_mark-away-from-mnt_flags.patch
+avoid-one-conditional-branch-in-touch_atime.patch
+mxser-remove-ambiguous-redefinition-of-init_work.patch
+make-drivers-char-mxser_newcmxser_hangup-static.patch
+char-isicom-fix-locking-in-isr.patch
+char-isicom-augment-card_reset.patch
+char-isicom-check-card-state-in-isr.patch
+char-isicom-support-higher-rates.patch
+char-isicom-correct-probing-removing.patch
+char-tty_wakeup-cleanup.patch
+kill_pid_info-kill-acquired_tasklist_lock.patch
+lockdep-also-check-for-freed-locks-in-kmem_cache_free.patch
+lockdep-more-unlock-on-error-fixes.patch
+lockdep-more-unlock-on-error-fixes-fix.patch
+lockdep-add-graph-depth-information-to-proc-lockdep.patch
+igrab-should-check-for-i_clear.patch
+consolidate-line-discipline-number-definitions-v2.patch
+consolidate-line-discipline-number-definitions-v2-sparc-fix.patch
+consolidate-line-discipline-number-definitions-v2-fix-2.patch
+scrub-non-__glibc__-checks-in-linux-socketh-and-linux-stath.patch
+rewrite-unnecessary-duplicated-code-to-use-field_sizeof.patch
+drivers-char-vc_screenc-proper-prototypes.patch
+transform-kmem_cache_allocmemset0-kmem_cache_zalloc.patch
+spi-kconfig-fix.patch
+spi-controller-driver-for-omap-microwire.patch
+spi-controller-driver-for-omap-microwire-tidy.patch
+serial-serial_txx9-driver-update.patch
+relay-add-cpu-hotplug-support.patch
+ext2-skip-pages-past-number-of-blocks-in-ext2_find_entry.patch
+char-mxser_new-mark-init-functions.patch
+char-mxser_new-remove-useless-spinlock.patch
+char-serial167-cleanup.patch
+char-n_r3964-cleanup.patch
+consolidate-default-sched_clock.patch
+pktcdvd-cleanup.patch
+pnp-export-pnp_bus_type.patch

 Misc updates

+vmi-versus-hrtimers.patch

 Fix VMI patches for hrtimer patches

+clockevents-i386-drivers-high-res-timers-fix-apic-event-broadcasting-code.patch

 Fix clockevents-i386-drivers.patch

+high-res-timers-core-do-itimer-rearming-in-process-context-fix2.patch
+high-res-timers-core-hrtimers-add-state-tracking-fix.patch
+high-res-timers-core-hrtimers-add-state-tracking-fix-fix.patch

 Fix high-res-timers-core.patch

+debugging-feature-proc-timer_list-warning-fix.patch

 Fix debugging-feature-proc-timer_list.patch

+debugging-feature-sysrq-q-to-print-timers.patch

 Enhance debugging-feature-proc-timer_list.patch

+generic-vsyscall-gtod-support-for-generic_time.patch
+generic-vsyscall-gtod-support-for-generic_time-tidy.patch
+time-x86_64-hpet_address-cleanup.patch
+time-x86_64-split-x86_64-kernel-timec-up.patch
+time-x86_64-split-x86_64-kernel-timec-up-tidy.patch
+time-x86_64-split-x86_64-kernel-timec-up-fix.patch
+time-x86_64-convert-x86_64-to-use-generic_time.patch
+time-x86_64-convert-x86_64-to-use-generic_time-fix.patch
+time-x86_64-convert-x86_64-to-use-generic_time-tidy.patch
+time-x86_64-re-enable-vsyscall-support-for-x86_64.patch
+time-x86_64-re-enable-vsyscall-support-for-x86_64-tidy.patch

 Use generic time on x86_64

-let-warn_on-output-the-condition.patch

 Dropped

+gpio-core.patch
+omap-gpio-wrappers.patch
+omap-gpio-wrappers-tidy.patch
+at91-gpio-wrappers.patch
+at91-gpio-wrappers-tidy.patch
+pxa-gpio-wrappers.patch
+sa1100-gpio-wrappers.patch
+s3c2410-gpio-wrappers.patch

 Generic GPIO driver core and clients

+drivers-isdn-hisax-proper-prototypes.patch

 ISDN cleanup

+reiser4-test_clear_page_dirty.patch

 reiser4 fix

+fbdev-driver-for-s3-trio-virge-cleanups.patch

 Fix fbdev-driver-for-s3-trio-virge.patch

+oss-replace-kmallocmemset-combos-with-kzalloc.patch

 Cleanup

-pidhash-temporary-debug-checks.patch

 Dropped

+shrink_slab-handle-bad-shrinkers.patch

 slab debug




All 755 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/patch-list


