Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVGaJH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVGaJH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 05:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVGaJHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 05:07:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261614AbVGaJG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 05:06:57 -0400
Date: Sun, 31 Jul 2005 02:05:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc4-mm1
Message-Id: <20050731020552.72623ad4.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/


- Dropped areca-raid-linux-scsi-driver.patch and iteraid.patch.  People who
  need these can get them from 2.6.13-rc3-mm3.

- Dropped the CKRM patches.  I don't think they were doing much in -mm and
  we didn't find many problems with them anyway.

- Dropped the connector patches: turns out that we no longer have a netlink
  slot available for them anyway.



Changes since 2.6.13-rc3-mm3:


 linus.patch
 git-cryptodev.patch
 git-drm.patch
 git-audit.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-adma-mwi.patch
 git-libata-chs-support.patch
 git-libata-passthru.patch
 git-libata-promise-sata-pata.patch
 git-net.patch
 git-net-gregkh-i2c-w1-netlink-callbacks-fix.patch
 git-netdev-chelsio.patch
 git-netdev-e100.patch
 git-netdev-smc91x-eeprom.patch
 git-netdev-ieee80211-wifi.patch
 git-ocfs2.patch
 git-serial.patch
 git-scsi-block.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch

 Subsystem trees

-bio_clone-fix.patch
-pcmcia-ide-cs-id_table-update.patch
-pcmcia-fix-comment.patch
-pcmcia-remove-duplicates-in-orinoco_cs.patch
-pcmcia-update-au1000-to-work-with-recent-changes.patch
-pcmcia-avoid-duble-iounmap-of-one-address.patch
-pcmcia-fix-many-device-ids.patch
-pcmcia-update-documentation.patch
-pcmcia-fix-sharing-irqs-and-request_irq-without-irq_handle_present.patch
-yenta-free_irq-on-suspend.patch
-pcmcia-disable-read-prefetch-write-burst-on-old-o2micro-bridges.patch
-cciss-per-disk-queue.patch
-fix-incorrect-asus-k7m-irq-router-detection.patch
-x86_64-always-ack-ipis-even-on-errors.patch
-x86_64-update-defconfig.patch
-x86_64-use-for_each_cpu_mask-for-clustered-ipi-flush.patch
-x86_64-i386-x86_64-remove-prototypes-for-not-existing.patch
-x86_64-move-cpu_present-possible_map-parsing-earlier.patch
-x86_64-minor-clean-up-to-cpu-setup-use-smp_processor_id-instead-of-custom-hack.patch
-x86_64-clarify-booting-processor-message.patch
-x86_64-some-cleanup-in-setup64c.patch
-x86_64-remove-unused-variable-in-delayc.patch
-x86_64-improve-config_gart_iommu-description-and-make-it-default-y.patch
-x86_64-some-updates-for-boot-optionstxt.patch
-x86_64-fix-some-comments-in-tlbflushh.patch
-x86_64-remove-obsolete-eat_key-prototype.patch
-x86_64-fix-some-typos-in-systemh-comments.patch
-x86_64-fix-incorrectly-defined-msr_k8_syscfg.patch
-x86_64-fix-overflow-in-numa-hash-function-setup.patch
-x86_64-print-a-boot-message-for-hotplug-memory-zones.patch
-x86_64-create-per-cpu-machine-check-sysfs-directories.patch
-x86_64-remove-ia32_-build-tools-in-makefile.patch
-x86_64-remove-the-broadcast-options-that-were-added-for.patch
-x86_64-support-more-than-8-cores-on-amd-systems.patch
-x86_64-icecream-has-no-way-of-detecting-assembler-level.patch
-x86_64-turn-bug-data-into-valid-instruction.patch
-x86_64-when-running-cpuid4-need-to-run-on-the-correct.patch
-x86_64-remove-unnecessary-include-in-faultc.patch
-x86_64-small-assembly-improvements.patch
-x86_64-switch-to-the-interrupt-stack-when-running-a.patch
-x86_64-fix-srat-handling-on-non-dual-core-systems.patch
-x86_64-fix-gcc-4-warning-in-sched_find_first_bit.patch
-x86_64-use-msleep-in-smpbootc.patch
-x86_64-remove-unused-variable-in-k8-busc.patch
-x86_64-fix-cpu_to_node-setup-for-sparse-apic_ids.patch
-cs89x0-collect-tx_bytes-statistics.patch
-ppc32-inotify-syscalls.patch
-ppc64-inotify-syscalls.patch
-selinux-default-labeling-of-mls-field.patch
-e1000-no-need-for-reboot-notifier.patch
-pcdp-if-pcdp-contains-parity-information-use-it.patch
-qla2xxx-mark-dependency-on-fw_loader.patch
-alpha-fix-statement-with-no-effect-warnings.patch
-mm-ensure-proper-alignment-for-node_remap_start_pfn.patch
-acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-bug-3549.patch
-acpi-re-enable-c2-c3-cpu-states-for-systems-without.patch
-agp-restore-apbase-after-setting-apsize.patch
-gregkh-driver-stable_api_nonsense.txt-fixes.patch
-gregkh-i2c-i2c-max6875-simplify.patch
-gregkh-i2c-i2c-max6875-fix-build-error.patch
-gregkh-i2c-i2c-ds1337-12-24-mode-fix.patch
-gregkh-i2c-i2c-missing-space.patch
-gregkh-i2c-w1-kconfig.patch
-gregkh-pci-pci-smbus-quirk.patch
-gregkh-pci-pci-adjust-pci-rom-code-to-handle-more-broken-roms.patch
-gregkh-pci-pci-remove-pci_bridge_ctl_vga-handling-from-setup-busc.patch
-gregkh-pci-pci-dma-build-fix.patch
-gregkh-pci-pci-remove-pretty-names-fix.patch
-git-scsi-misc-drivers-scsi-chc-remove-devfs-stuff.patch
-gregkh-usb-usb-ftdi_sio-new-devices.patch
-gregkh-usb-usb-ftdi_sio-rts-dtr.patch
-gregkh-usb-usb-ftdi_sio-timeout-fix.patch
-gregkh-usb-usb-usbfs-dont-leak-data.patch
-gregkh-usb-usb-usbnet-remove-unused-vars.patch
-gregkh-usb-usb-dont-delete-unregistered-interfaces.patch
-usb-hidinput_hid_event-oops-fix.patch
-option-card-driver-update-maintainer-entry-fixes.patch
-fix-something-in-scsi.patch
-usb-storage-rearrange-stuff.patch
-fix-something-in-usb.patch
-sk98lin-basic-suspend-resume-support.patch
-x86-avoid-wasting-irqs-patch-update.patch
-x86_64-avoid-wasting-irqs-patch-update.patch
-add-cmos-attribute-to-floppy-driver.patch
-add-cmos-attribute-to-floppy-driver-tidy.patch
-intel8x0-free-irq-in-suspend.patch
-serial-add-mmio-support-to-8250_pnp.patch
-device-mapper-fix-deadlocks-in-core-prep.patch
-device-mapper-fix-deadlocks-in-core.patch
-device-mapper-fix-md-lock-deadlocks-in-core.patch

 Merged

+i2c-mpc-revert-duplicate-patch.patch

 Fix doublly-applied patch

+skge-build-fix.patch

 Fix net driver build

+disable-address-space-randomization-on-transmeta-cpus.patch

 Make /proc/sys/kernel/randomize_va_space default to off on Transmeta CPUs,
because it can make them run slowly.

+v4l-miscellaneous-fixes.patch
+v4l-cx88-card-support-and-documentation-finishing.patch

 v4l fixes

+maintainers-record-man-pages.patch
+maintainers-record-man-pages-fix.patch

 Mention the manpage guy in MAINTAINERS

+ppc64-fix-config_altivec-not-set.patch

 ppc64 fix

+display-name-of-fbdev-device.patch

 fbdev featurette

-git-acpi.patch

 I dropped this - not sure why.

+acpi_register_gsi-change-acpi_register_gsi-interface.patch
+acpi_register_gsi-change-acpi-pci-code.patch
+acpi_register_gsi-change-hpet-driver.patch
+acpi_register_gsi-change-phpacpi-driver.patch
+acpi_register_gsi-change-acpi-based-8250-driver.patch
+acpi_register_gsi-change-ia64-iosapic-code.patch

 ACPI feature work

+enable-acpi_hotplug_cpu-automatically-if-hotplug_cpu=y.patch

 Kconfig fix

+gregkh-driver-floppy-cmos-attribute.patch
+gregkh-driver-floppy-cmos-attribute-tidy.patch

 Additions to Greg's driver tree

+gregkh-i2c-i2c-max6875-documentation-cleanup.patch
+gregkh-i2c-i2c-hwmon-soften-lm75.patch
+gregkh-i2c-i2c-hwmon-lm78-j.patch
+gregkh-i2c-i2c-hwmon-document-w83627ehg.patch
+gregkh-i2c-i2c-w83792d-01.patch
+gregkh-i2c-i2c-w83792d-02.patch
+gregkh-i2c-i2c-w83792d-03.patch
+gregkh-i2c-i2c-refactor-message.patch
+gregkh-i2c-i2c-hwmon-tag-superio-functions-__init.patch

 Additions to Greg's i2c tree

+input-quirk-for-the-fn-key-on-powerbooks-with-an-usb.patch

 Input driver fix

+git-net.patch

 Bring this back - it was innocent

+git-net-gregkh-i2c-w1-netlink-callbacks-fix.patch

 Fix it for changes in Greg's tree

+drivers-net-wireless-hostap-hostapc-export_symtab-does-nothing.patch

 Wireless driver cleanup

+gregkh-pci-pci-remove-pretty-names-02.patch
+gregkh-pci-pci-cleanup-pci.h.patch

 Additions to Greg's PCI tree

+gregkh-usb-usb-cypress_m8-whitespace-fixes.patch
+gregkh-usb-usb-option-card-driver-coding-style-tweaks.patch
+gregkh-usb-usb-gadget-centrialize-numbers.patch
+gregkh-usb-usb-storage-rearrange-stuff.patch
+gregkh-usb-usb-storage-fix-something.patch

 Additions to Greg's USB tree

+usb-ehci-microframe-handling-fix.patch

 USB fix

+page-fault-patches-optional-page_lock-acquisition-in-fix.patch
+page-fault-patches-optional-page_lock-acquisition-in-fix-2.patch
+page-fault-patches-fix-highpte-in-do_anon_page.patch

 Fix the pagefault scalability patches

+x86-ptep-clear-optimization.patch
+x86-ptep-clear-optimization-fix.patch

 x86 pte handling speedup

+mm-slabc-prefetchw-the-start-of-new-allocated-objects.patch

 slab microoptimisation

+forcedeth-write-back-the-misordered-mac-address.patch

 Fix forcedeth driver

+r8169-pci-id-for-the-linksys-eg1032.patch

 r8169 device support

+ppc32-add-missing-4xx-emac-sysfs-nodes.patch
+arch-ppc-kernel-ppc_ksymsc-remove-unused-define-export_symtab_strops.patch
+8xx-convert-fec-driver-to-use-work_struct.patch
+8xx-using-dma_alloc_coherent-instead-consistent_alloc.patch
+8xx-fec-fix-interrupt-handler-prototypes.patch

 ppc32 stuff

+vm86-honor-tf-bit-when-emulating-an-instruction.patch

 x86 vm86 fix

+kdump-save-parameter-segment-in-protected-mode-x86.patch

 kdump enhamcement

+i386-clean-up-vdso-alignment-padding.patch
+x86-automatically-enable-bigsmp-when-we-have-more-than-8-cpus.patch
+i386-inline-asm-cleanup.patch
+i386-inline-asm-cleanup-kexec-fix.patch
+i386-arch-cleanup-seralize-msr.patch
+i386-arch-cleanup-seralize-msr-fix.patch
+i386-inline-assembler-cleanup-encapsulate-descriptor-and-task-register-management.patch
+i386-inline-assembler-cleanup-encapsulate-descriptor-and-task-register-management-fix.patch
+i386-generate-better-code-around-descriptor-update-and-access-functions.patch
+i386-load_tls-fix.patch
+i386-use-set_pte-macros-in-a-couple-places-where-they-were-missing.patch

 Various x86 cleanups.  Mainly: move all the open-coded asm statements into
 nice wrapper functions.  Partly because it makes things easier for
 virtualisation patches, partly because it cleans things up and people
 occasionally get these things wrong.

+x86_64-remove-duplicated-sys_time64.patch
+x86_64-fix-off-by-one-in-e820_mapped.patch
+x86_64-prefetchw-can-fall-back-to-prefetch-if-3dnow.patch

 x86_64 fixes

-swsusp-process-freezing-remove-smp-races.patch
-swsusp-process-freezing-remove-smp-races-msp3400-fix.patch

 Dropped - it's planned to do this differently.

+remove-busywait-in-refrigerator.patch
+swsusp-fix-remaining-u32-vs-pm_message_t-confusion-2.patch

 swsusp fixes

+swsusp-simpler-calculation-of-number-of-pages-in-pbe-list.patch

 swsusp simplification

+swsusup-with-dm-crypt-mini-howto.patch

 swsusp documentation

+uml-rename-kconfig-files-to-be-like-the-other-arches.patch
+uml-workaround-gdb-problems-on-debugging.patch
+uml-fix-sigwinch-handler-race-while-waiting-for-signals.patch

 UML updates

+s390-use-klist-in-qeth-driver.patch

 s390 driver cleanup

-areca-raid-linux-scsi-driver.patch

 Dropped

-aio-fix-races-in-callback-path.patch

 Dropped - believed to be incorrect.

+kconfig-trivial-cleanup.patch

 Kconfig cleanup

+fix-sound-arm-makefile-for-locality-of-reference.patch

 Make ARM makefile more maintainable

+remove-special-hpet_emulate_rtc-config-option.patch

 make RTC emulation non-optional in the HPET driver

+schedule-obsolete-oss-drivers-for-removal-version-2.patch

 Add some OSS drivers to death row.

+disk-quotas-fail-when-etc-mtab-is-symlinked-to-proc-mounts.patch
+disk-quotas-fail-when-etc-mtab-is-symlinked-to-proc-mounts-tidy.patch

 Better support for /etc/mtab symlinked to /proc/mounts

+add-init=-warning-to-init-mainc.patch

 Print a warning when the target of `init=' cannot be executed.

+remove-a-dead-extern-in-memc.patch

 Cleanup

+remove-misleading-comment-above-sys_brk.patch

 Fix comment

+move-m68k-rtc-drivers-over-to-initcalls.patch
+move-68360serialc-over-use-initcalls.patch

 Cleanups

+remove-pipe-definitions.patch

 Remove dead macros

+sd-initialize-sd-cards.patch
+sd-read-only-switch.patch
+sd-scr-register.patch
+sd-scr-in-sysfs.patch
+sd-4-bit-bus.patch
+sd-copyright-notice.patch

 Secure digital card drivers

+corgi-keyboard-fix-a-couple-of-compile-errors.patch
+corgi-keyboard-add-some-power-management-code.patch
+corgi-keyboard-code-tidying.patch
+corgi-touchscreen-allow-the-driver-to-share-the-pmu.patch
+corgi-touchscreen-code-cleanup--fixes.patch
+w100fb-rewrite-for-platform-independence.patch
+w100fb-update-corgi-platform-code-to-match-new-driver.patch
+input-add-a-new-switch-event-type.patch

 Corgi driver updates

-ckrm-core-ckrm-event-callbacks.patch
-ckrm-processor-delay-accounting.patch
-ckrm-processor-delay-accounting-warning-fixes.patch
-ckrm-core-infrastructure.patch
-ckrm-resource-control-file-system-rcfs.patch
-ckrm-classtype-definitions-for-task-class.patch
-ckrm-classtype-definitions-for-socket-class.patch
-ckrm-numtasks-controller.patch
-ckrm-documentation.patch
-ckrm-add-missing-read_unlock.patch
-ckrm-move-callbacks-from-listenaq-to-socketclass.patch
-ckrm-change-ipaddr_port-syntax.patch
-ckrm-check-to-see-if-my-guarantee-is-set-to-dontcare.patch
-ckrm-minor-cosmetic-cleanups-in-numtasks-controller.patch
-ckrm-undo-removal-of-check-in-numtasks_put_ref_local.patch
-ckrm-rule-based-classification-engine-stub-rcfs-support.patch
-ckrm-rule-based-classification-engine-basic-rcfs-support.patch
-ckrm-rule-based-classification-engine-bitvector-support-for-classification-info.patch
-ckrm-rule-based-classification-engine-full-ce.patch
-ckrm-rule-based-classification-engine-full-ce-fix.patch
-ckrm-rule-based-classification-engine-more-advanced-classification-engine.patch
-#ckrm-rule-based-classification-engine-more-advanced-classification-engine-netlink-fix.patch
-ckrm-clean-up-typo-in-printk-message.patch
-ckrm-fix-for-compiler-warnings.patch
-ckrm-fix-share-calculation.patch
-ckrm-fix-edge-cases-with-empty-lists-and-rule-deletion.patch
-ckrm-add-numtasks-controller-config-file-write-support.patch
-ckrm-add-fork-rate-control-to-the-numtasks-controller.patch
-ckrm-classification-engines-rbce-and-crbce-are-mutually-exclusive.patch
-ckrm-make-get_class-global.patch
-ckrm-cleanups-to-ckrm-initialization.patch
-ckrm-replace-target-file-interface-with-a-writable-members-file.patch
-ckrm-use-sizeof-instead-of-define-for-the-array-size-in-taskclass.patch
-ckrm-fix-a-bug-in-the-use-of-classtype.patch
-ckrm-include-taskdelaysh-in-crbceh.patch
-ckrm-send-timestamps-to-userspace-in-msecs-instead-of-jiffies.patch
-ckrm-fix-compile-warnings-and-delete-dead-code.patch
-ckrm-fix-a-null-dereference-bug.patch
-ckrm-classification-engine-configuration-support-cleanup.patch
-ckrm-use-sizeof-instead-of-define-for-the-array-size-in-rbce.patch
-ckrm-delete-target-file-from-tc_magicc.patch

 Dropped

-connector.patch
-connector-exit-notifier.patch
-connector-add-a-fork-connector.patch

 Dropped

-iteraid.patch

 Dropped

+sched-better-wake-balancing-3.patch

 CPU scheduler tweak

+video_bt848-remove-not-required-part-of-the-help-text.patch

 v4l fixlet

-files-fix-rcu-initializers.patch
-files-rcuref-apis.patch
-files-break-up-files-struct.patch
-files-sparc64-fix-2.patch
-files-files-struct-with-rcu.patch
-files-lock-free-fd-look-up.patch
-files-files-locking-doc.patch

 Dropped these for now: we have one report that they break swsusp resume. 
 Whcih is odd.

-reiser4-swsusp-process-freezing-remove-smp-races-fix.patch
-reiser4-swsusp-process-freezing-remove-smp-races-fix-2.patch

 No longer needed

+reiser4-wundef-fix.patch
+reiser4-wundef-fix-2.patch

 reiser4 warning fixes

+v9fs-documentation-makefiles-configuration-add-fd-based-transport-to-makefile-docs.patch
+v9fs-vfs-superblock-operations-and-glue-add-fd-based-transport-to-mount-options.patch
+v9fs-transport-modules-add-fd-based-transport-module.patch

 v9fs updates

+fbsysfs-remove-casts-from-void.patch

 fbdev cleanup

+fuse-device-functions-document-mount-options-documentation-update.patch
+fuse-device-functions-request-counter-overflow-fix.patch
+fuse-device-functions-module-alias.patch
+fuse-stricter-mount-option-checking.patch
+fuse-dont-update-file-times.patch

 FUSE updates

+include-linux-blkdevh-extern-inline-static-inline.patch

 Cleanup


All 601 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/patch-list


