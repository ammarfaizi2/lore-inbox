Return-Path: <linux-kernel-owner+w=401wt.eu-S1161009AbXALG0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbXALG0f (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 01:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbXALG0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 01:26:35 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36864 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161007AbXALG0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 01:26:33 -0500
Date: Thu, 11 Jan 2007 22:26:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc4-mm1
Message-Id: <20070111222627.66bb75ab.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Temporarily at

  http://userweb.kernel.org/~akpm/2.6.20-rc4-mm1/

Will appear later at

  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc4-mm1/


- Added the e1000 driver development tree, as git-e1000.patch (Auke Kok
  <auke-jan.h.kok@intel.com>)

- Added the HID development tree, as git-hid.patch (Jiri Kosina
  <jkosina@suse.cz>)

- Added the unionfs filesystem driver as git-unionfs.patch (Josef "Jeff"
  Sipek <jsipek@cs.sunysb.edu>)

- Merged the "filesystem AIO patches".



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




Changes since 2.6.20-rc3-mm1:


 origin.patch
 git-acpi.patch
 git-ibm-acpi.patch
 git-alsa.patch
 git-arm.patch
 git-avr32.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-gfs2-nmw.patch
 git-hid.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-jfs.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mips.patch
 git-mmc.patch
 git-mtd.patch
 git-ubi.patch
 git-netdev-all.patch
 git-e1000.patch
 git-net.patch
 git-ioat.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-pciseg.patch
 git-s390.patch
 git-sh.patch
 git-scsi-rc-fixes.patch
 git-block.patch
 git-sas.patch
 git-unionfs.patch
 git-watchdog.patch
 git-wireless.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees

-add-afs_super_magic-to-magich.patch
-fix-implicit-declarations-in-via-pmu.patch
-fix-leds-s3c24xx-hardwareh-reference.patch
-start_kernel-test-if-irqs-got-enabled-early-barf-and-disable-them-again.patch
-start_kernel-test-if-irqs-got-enabled-early-barf-and-disable-them-again-fix.patch
-kernelparams-detect-if-and-which-parameter-parsing-enabled-irqs.patch
-kernelparams-detect-if-and-which-parameter-parsing-enabled-irqs-fix.patch
-pci-prevent-down_read-when-pci_devices-is-empty.patch
-pci-prevent-down_read-when-pci_devices-is-empty-fix.patch
-via82cxxx-fix-cable-detection.patch
-kvm-fix-gfp_kernel-alloc-in-atomic-section-bug.patch
-kvm-use-raw_smp_processor_id-instead-of-smp_processor_id-where-applicable.patch
-kvm-recover-after-an-arch-module-load-failure.patch
-kvm-improve-interrupt-response.patch
-rtc-at91rm9200-build-fix.patch
-fix-bug-at-drivers-scsi-scsi_libc1118-caused-by-pktsetup-dvd-dev-sr0.patch
-atiixp-old-drivers-ide-layer-driver-for-the-atiixp-hang.patch
-atiixp-old-drivers-ide-layer-driver-for-the-atiixp-hang-tidy.patch
-adfs-fix-filename-handling.patch
-swsusp-do-not-fail-if-resume-device-is-not-set.patch
-profiling-fix-sched-profiling-typo.patch
-i386-restore-config_physical_start-option.patch
-sanely-size-hash-tables-when-using-large-base-pages-take-2.patch
-i386-fix-modpost-warning-in-smp-trampoline-code.patch
-i386-fix-another-modpost-warning.patch
-i386-modpost-smpboot-code-warning-fix.patch
-ip2-warning-fix.patch
-fix-memory-corruption-from-misinterpreted-bad_inode_ops.patch
-fix-memory-corruption-from-misinterpreted-bad_inode_ops-tidy.patch
-fix-bug_onpageslab-from-fallback_alloc.patch
-update-the-rtc-rs5c372-driver.patch
-kvm-prevent-stale-bits-in-cr0-and-cr4.patch
-kvm-mmu-implement-simple-reverse-mapping.patch
-kvm-mmu-teach-the-page-table-walker-to-track-guest-page-table-gfns.patch
-kvm-mmu-load-the-pae-pdptrs-on-cr3-change-like-the-processor-does.patch
-kvm-mmu-fold-fetch_guest-into-init_walker.patch
-kvm-mu-special-treatment-for-shadow-pae-root-pages.patch
-kvm-mmu-use-the-guest-pdptrs-instead-of-mapping-cr3-in-pae-mode.patch
-kvm-mmu-make-the-shadow-page-tables-also-special-case-pae.patch
-kvm-mmu-make-kvm_mmu_alloc_page-return-a-kvm_mmu_page-pointer.patch
-kvm-mmu-shadow-page-table-caching.patch
-kvm-mmu-write-protect-guest-pages-when-a-shadow-is-created-for-them.patch
-kvm-mmu-let-the-walker-extract-the-target-page-gfn-from-the-pte.patch
-kvm-mmu-support-emulated-writes-into-ram.patch
-kvm-mmu-zap-shadow-page-table-entries-on-writes-to-guest-page-tables.patch
-kvm-mmu-if-emulating-an-instruction-fails-try-unprotecting-the-page.patch
-kvm-mmu-implement-child-shadow-unlinking.patch
-kvm-mmu-kvm_mmu_put_page-only-removes-one-link-to-the-page.patch
-kvm-mmu-oom-handling.patch
-kvm-mmu-remove-invlpg-interception.patch
-kvm-mmu-remove-release_pt_page_64.patch
-kvm-mmu-handle-misaligned-accesses-to-write-protected-guest-page-tables.patch
-kvm-mmu-ove-is_empty_shadow_page-above-kvm_mmu_free_page.patch
-kvm-mmu-ensure-freed-shadow-pages-are-clean.patch
-kvm-mmu-if-an-empty-shadow-page-is-not-empty-report-more-info.patch
-kvm-mmu-page-table-write-flood-protection.patch
-kvm-mmu-never-free-a-shadow-page-actively-serving-as-a-root.patch
-kvm-mmu-fix-cmpxchg8b-emulation.patch
-kvm-mmu-treat-user-mode-faults-as-a-hint-that-a-page-is-no-longer-a-page-table.patch
-kvm-mmu-free-pages-on-kvm-destruction.patch
-kvm-mmu-replace-atomic-allocations-by-preallocated-objects.patch
-kvm-mmu-detect-oom-conditions-and-propagate-error-to-userspace.patch
-kvm-mmu-flush-guest-tlb-when-reducing-permissions-on-a-pte.patch
-kvm-mmu-destroy-mmu-while-we-still-have-a-vcpu-left.patch
-kvm-mmu-add-audit-code-to-check-mappings-etc-are-correct.patch
-pata_optidma-typo-in-kconfig.patch
-hpt37x-two-important-bug-fixes.patch
-check-for-populated-zone-in-__drain_pages.patch
-fix-the-toshiba_acpi-write_lcd-return-value.patch
-pci-avoid-taking-pci_bus_sem-early-in-boot.patch
-fix-garbage-instead-of-zeroes-in-ufs.patch
-shrink_all_memory-fix-lru_pages-handling.patch
-connector-some-fixes-for-ia64-unaligned-access-errors.patch
-sound-hda-detect-alc883-on-msi-k9a-platinum-motherboards.patch
-fix-bogus-bug_on-in-in-hugetlb_get_unmapped_area.patch
-error-handling-in-sysfs-fill_read_buffer.patch
-make-usbvision_rvfree-static.patch
-maintainers-tag-pvrusb2-list-as-subscribers-only.patch
-ks0127-status-flags.patch
-jdelvare-i2c-i2c-pnx-fix-interrupt-handler.patch
-jdelvare-i2c-i2c-pnx-add-maintainer.patch
-jdelvare-i2c-i2c-migration-aids-for-i2c_adapter.dev-removal.patch
-jdelvare-i2c-i2c-01-hwmon-drivers-stop-using-i2c_adapter.dev.patch
-jdelvare-i2c-i2c-02-i2c-bus-drivers-stop-using-i2c_adapter.dev.patch
-jdelvare-i2c-i2c-03-misc-i2c-drivers-stop-using-i2c_adapter.dev.patch
-jdelvare-i2c-i2c-04-other-drivers-stop-using-i2c_adapter.dev.patch
-jdelvare-i2c-i2c-05-remove-i2c_adapter.dev-from-all-i2c-adapters.patch
-i2c-m41t00-do-not-forget-to-write-year.patch
-qconf-immediately-update-integer-and-string-values-in-xconfig-display.patch
-sata_nv-add-suspend-resume-support.patch
-ubiioc-needs-schedh.patch
-qeth-fix-uaccess-handling-and-get-rid-of-unused-variable.patch
-forcedeth-sideband-management-fix.patch
-gregkh-pci-pci-disable-pci_multithread_probe.patch
-gregkh-pci-pci-quirks.c-cleanup.patch
-gregkh-pci-pciehp-cleanup-pciehp.h.patch
-iscsi-fix-crypto_alloc_hash-error-check.patch
-scsi-lpfc-error-path-fix.patch
-gregkh-usb-uhci-make-test-for-asus-motherboard-more-specific.patch
-gregkh-usb-uhci-support-device_may_wakeup.patch
-gregkh-usb-usb-fix-interaction-between-different-interfaces-in-an-option-usb-device.patch
-gregkh-usb-usb-funsoft-is-borken-on-sparc.patch
-gregkh-usb-usb-omap_udc-build-fixes.patch
-gregkh-usb-usb-storage-unusual_devs-add-supertop-drives.patch
-gregkh-usb-usb-storage-fix-ipod-ejecting-issue.patch
-gregkh-usb-usb-small-update-to-documentation-usb-acmtxt.patch
-gregkh-usb-usb-fixed-bug-in-endpoint-release-function.patch
-gregkh-usb-usb-linux-usb_ch9.h-becomes-linux-usb-ch9.h.patch
-gregkh-usb-usb-define-usb_class_misc-in-linux-usb-ch9.h.patch
-gregkh-usb-usb-remove-unneeded-void-casts-in-idmouse.c.patch
-gregkh-usb-usb-devio.c-add-missing-init_list_head.patch
-gregkh-usb-usb-gadget-file_storage.c-remove-unnecessary-casts.patch
-gregkh-usb-usb-add-usb_endpoint_xfer_control-to-usb.h.patch
-gregkh-usb-usb-serial-serqt_usb.patch
-usblpc-add-kyocera-mita-fs-820-to-list-of-quirky-printers.patch
-usb-usbmixer-error-path-fix.patch
-sisusb_con-warning-fixes.patch
-x86_64-mm-fix-aout-warning.patch
-revert-i386-fix-the-verify_quirk_intel_irqbalance.patch
-revert-x86_64-mm-add-genapic_force.patch
-revert-x86_64-mm-fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch
-revert-x86_64-mm-copy-user-nocache.patch
-convert-i386-pda-code-to-use-%fs.patch
-x86_64-i386-kernel-mode-faults-pollute-current-thead.patch
-genapic-optimize-fix-apic-mode-setup-2.patch
-genapic-always-use-physical-delivery-mode-on-8-cpus.patch
-genapic-remove-es7000-workaround.patch
-genapic-remove-clustered-apic-mode.patch
-genapic-default-to-physical-mode-on-hotplug-cpu-kernels.patch
-x86_64-make-the-numa-hash-function-nodemap-allocation-fix-2.patch
-i386-io_apic-fix-a-typo-in-an-irq-handler-name.patch
-pci-mmconfig-share-whats-shareable.patch
-pci-mmconfig-only-call-unreachable_devices-when-type-1-is-available.patch
-pci-mmconfig-only-map-whats-necessary.patch
-pci-mmconfig-detect-and-support-the-e7520-and-the-945g-gz-p-pl.patch
-pci-mmconfig-reserve-resources-but-only-when-were-sure-about-them.patch
-get-rid-of-arch_have_xtime_lock.patch
-add-memcpy_uncached_read.patch
-ib-ipath-use-memcpy_uncached_read-in-rdma-interrupt.patch
-x86_64-improved-iommu-documentation.patch
-x86_64-do-not-always-end-the-stack-trace-with-ulong_max.patch
-arch-i386-kernel-e820c-should-include-asm-setuph.patch
-paravirt-page-allocation-hooks-for-vmi-backend.patch
-paravirt-paravirt-cpu-hypercall-batching-mode.patch
-paravirt-iopl-handling-for-paravirt-guests.patch
-paravirt-smp-boot-hook-for-paravirt.patch
-paravirt-vmi-backend-for-paravirt-ops.patch
-paravirt-vmi-backend-for-paravirt-ops-compile-fix.patch
-paravirt-vmi-backend-for-paravirt-ops-initialize-fs-for-smp.patch
-paravirt-vmi-backend-for-paravirt-ops-native-fix.patch
-paravirt-vmi-timer-patches.patch
-i386-cpu-hotplug-smpboot-misc-modpost-warning-fixes.patch
-convert-some-functions-to-__init-to-avoid-modpost-warnings.patch
-i386-move-startup_32-in-texthead-section.patch
-break-init-in-two-parts-to-avoid-modpost-warnings.patch
-i386-fix-memory-hotplug-related-modpost-generated-warning.patch
-arch-i386-kernel-cpu-mcheck-mcec-should-include-asm-mceh.patch
-add-i386-idle-notifier-take-3.patch
-sched-improve-sched_clock-on-i686.patch
-romsignature-checksum-cleanup.patch
-i386-make-apic-probe-function-non-init.patch
-modpost-add-more-symbols-to-whitelist-pattern2.patch
-modpost-whitelist-reference-to-more-symbols-pattern-3.patch
-fix-fake-numa-for-x86_64-machines-with-big-io-hole.patch
-x86-64-calgary-tighten-up-printks.patch
-remove-fastcall-references-in-x86_64-code.patch
-use-constant-instead-of-raw-number-in-x86_64-iopermc.patch
-bluetooth-blacklist-lenovo-r60e.patch

 Merged into mainline or a subsystem tree.

+sched-tasks-cannot-run-on-cpus-onlined-after-boot.patch
+increment-pos-before-looking-for-the-next-cap-in-__pci_find_next_ht_cap.patch
+fix-sparsemem-on-cell.patch
+rtc-sh-correctly-report-rtc_wkalrmenabled.patch
+change-cpu_up-and-co-from-__devinit-to-__cpuinit.patch
+kdump-documentation-update-for-2620.patch
+i386-sched_clock-using-init-data-tsc_disable-fix.patch
+md-pass-down-bio_rw_sync-in-raid110.patch
+kvm-add-vm-exit-profiling.patch
+nfs-fix-race-in-nfs_release_page.patch
+really-fix-funsoft-driver.patch
+revert-bd_mount_mutex-back-to-a-semaphore.patch
+intel-rng-workarounds.patch
+fix-hwrng-built-in-initcalls-priority.patch
+fix-typo-in-geode_configre-cyrixc.patch
+fd_zero-build-fix.patch
+revert-nmi_known_cpu-check-during-boot-option-parsing.patch
+blockdev-direct_io-fix-signedness-bug.patch
+submitchecklist-update.patch
+paravirt-mark-the-paravirt_ops-export-internal.patch
+kvm-make-sure-there-is-a-vcpu-context-loaded-when.patch
+kvm-fix-race-between-mmio-reads-and-injected-interrupts.patch
+kvm-x86-emulator-fix-bit-string-instructions.patch
+kvm-fix-asm-constraints-with-config_frame_pointer=n.patch
+kvm-fix-bogus-pagefault-on-writable-pages.patch
+rtc-sh-act-on-rtc_wkalrmenabled-when-setting-an-alarm.patch
+fix-blk_direct_io-bio-preparation.patch
+tlclk-bug-fix-misc-fixes.patch
+tlclk-bug-fix-misc-fixes-tidy.patch
+reiserfs-avoid-tail-packing-if-an-inode-was-ever-mmapped.patch

 2.6.20 queue

-down_write-preserve-local-irqs.patch

 Dropped

+acpi-bay-remove-acpi-driver-struct.patch
+exit-acpi-processor-module-gracefully-if-acpi-is-disabled.patch
+exit-acpi-processor-module-gracefully-if-acpi-is-disabled-tidy.patch
+acpi-make-bay-depend-on-dock.patch

 ACPI things

+sony_acpi-addacpi_bus_generate-event-fix.patch

 Fix sony_acpi-addacpi_bus_generate-event.patch

-git-alsa-fixup.patch

 Unneeded

+agpgart-allow-drm-populated-agp-memory-types.patch
+agpgart-allow-drm-populated-agp-memory-types-tidy.patch

 AGP feature work.

+arm-imx-serial-fix-tx-buffer-overflows.patch
+arm-imx-serial-fix-irq-allocation.patch

 ARM serial driver fixes

+cifs-remove-2-unneeded-kzalloc-casts.patch

 CIFS cleanup

+rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues-fix-2.patch
+rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues-fix-3.patch

 Fix
 rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues.patch
 some more.

+cpu_freq_table-shouldnt-be-a-def_tristate.patch

 cpufreq Kconfig fix

+gregkh-driver-sysfs-error-handling-in-sysfs-fill_read_buffer.patch

 Driver tree update

+driver-core-remove-device_is_registered-in.patch
+driver-core-allow-device_movedev-null.patch

 More driver core work

+drivers-char-drm-drm_mmc-remove-unused-exports.patch

 DRM cleanup

+cpiac-buffer-overflow.patch
+fix-bttv-and-friends-on-64bit-machines-with-lots-of-memory.patch

 DVB things

+jdelvare-i2c-i2c-01-hwmon-drivers-stop-using-i2c_adapterdev.patch
+jdelvare-i2c-i2c-02-i2c-bus-drivers-stop-using-i2c_adapterdev.patch
+jdelvare-i2c-i2c-03-misc-i2c-drivers-stop-using-i2c_adapterdev.patch
+jdelvare-i2c-i2c-04-other-drivers-stop-using-i2c_adapterdev.patch
+jdelvare-i2c-i2c-05-remove-i2c_adapterdev-from-all-i2c-adapters.patch
+jdelvare-i2c-i2c-ali1563-fix-initialization.patch
+jdelvare-i2c-i2c-i801-document-unhiding-quirk.patch
+jdelvare-i2c-i2c-update-bus-id-list.patch
+jdelvare-i2c-i2c-add-ids-to-bus-drivers.patch

 I2C tree updates

+jdelvare-hwmon-hwmon-w83793-datasheet-refresh.patch
+jdelvare-hwmon-hwmon-vid-fix-vrm11.patch
+jdelvare-hwmon-hwmon-adm1029-new-driver.patch

 hwmon tree updates

+ia64-add-pci_get_legacy_ide_irq.patch

 ia64 IDE fix

+input-atlas-button-driver.patch

 New Input driver

+qconf-immediately-update-integer-and-string-values-in-xconfig-display-take-2.patch
+kbuild-dont-ignore-localversion-files-if-the-path-includes-a.patch
+qconf-relocate-search-command.patch

 Kconfig things

+add-suport-for-marvell-88se6121-in-pata_marvell.patch
+sata_promise-atapi-cleanup.patch
+libata-piix3-support.patch
+libata-piix3-support-warning-fix.patch

 ATA things.

+mips-turbochannel-update-to-the-driver-model-fix.patch

 Fix mips-turbochannel-update-to-the-driver-model.patch

+mips-remove-smp_tune_scheduling.patch

 MIPS cleanup

+ubi-printk-fix.patch

 UBI tree fix

+ucc-ether-driver-kmalloc-casting-cleanups.patch
+forcedeth-dma-access.patch
+forcedeth-ring-access.patch
+forcedeth-tx-locking.patch
+forcedeth-rx-skb-recycle.patch
+forcedeth-optimized-routines.patch
+forcedeth-tx-limiting.patch
+forcedeth-tx-data-path-optimization.patch
+forcedeth-rx-data-path-optimization.patch
+forcedeth-irq-data-path-optimization.patch
+forcedeth-tx-max-work.patch
+forcedeth-statistics-supported.patch
+forcedeth-statistics-optimization.patch
+broadcom-4400-resume-small-fix-v2.patch

 netdev updates

+z85230-spinlock-logic.patch
+x25-add-missing-sock_put-in-x25_receive_data.patch
+bonding-replace-kmalloc-memset-pairs-with-the-appropriate-kzalloc-calls.patch
+bonding-replace-kmalloc-memset-pairs-with-the-appropriate-kzalloc-calls-fix.patch
+net-wanrouter-wanmainc-cleanups.patch

 Net things

+remove-useless-find_first_bit-macro-from-cardbusc.patch

 PCMCIA cleanup

+gregkh-pci-pci-quirksc-cleanup.patch
+gregkh-pci-pciehp-cleanup-pciehph.patch

 PCI tree updates

+make-isa_bridge-alpha-only.patch

 OCI fix

+s390-kmalloc-kzalloc-casting-cleanups.patch

 s390 cleanup
 
+scsi-megaraid_mmmbox-init-fix-for-kdump.patch
+megaraid-fix-kernel-doc.patch
+dac960-kmalloc-kzalloc-casting-cleanups.patch
+scsi-scan-fix-logging-message-for-pq3-devices.patch
+fix-the-reproducible-oops-in-scsi.patch
+megaraid-more-kernel-doc-fixes.patch

 scsi fixes

+git-block-fixup.patch

 Fix rejects in git-block.patch

+gregkh-usb-usb-linux-usb_ch9h-becomes-linux-usb-ch9h.patch
+gregkh-usb-usb-define-usb_class_misc-in-linux-usb-ch9h.patch
+gregkh-usb-usb-remove-unneeded-void-casts-in-idmousec.patch
+gregkh-usb-usb-devioc-add-missing-init_list_head.patch
+gregkh-usb-usb-gadget-file_storagec-remove-unnecessary-casts.patch
+gregkh-usb-usb-add-usb_endpoint_xfer_control-to-usbh.patch
+gregkh-usb-usb-add-binary-api-to-usbmon.patch

 USB tree updates

+usb-mass-storage-us_fl_ignore_residue-needed-for-aiptek-mp3-player.patch

 USB fix

+x86_64-mm-convert-i386-pda-code-to-use-%fs.patch
+x86_64-mm-kernel-mode-faults-pollute-current-thead.patch
+x86_64-mm-revert-i386-fix-the-verify_quirk_intel_irqbalance.patch
+x86_64-mm-revert-x86_64-mm-add-genapic_force.patch
+x86_64-mm-revert-x86_64-mm-fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch
+x86_64-mm-optimize-fix-apic-mode-setup.patch
+x86_64-mm-always-use-physical-delivery-mode-on-8-cpus.patch
+x86_64-mm-remove-es7000-workaround.patch
+x86_64-mm-remove-clustered-apic-mode.patch
+x86_64-mm-default-to-physical-mode-on-hotplug-cpu-kernels.patch
+x86_64-mm-x86_64-make-the-numa-hash-function-nodemap-allocation-fix-fix.patch
+x86_64-mm-fix-a-typo-in-an-irq-handler-name.patch
+x86_64-mm-share-whats-shareable.patch
+x86_64-mm-only-call-unreachable_devices-when-type-1-is-available.patch
+x86_64-mm-only-map-whats-necessary.patch
+x86_64-mm-detect-and-support-the-e7520-and-the-945g-gz-p-pl.patch
+x86_64-mm-reserve-resources-but-only-when-were-sure-about-them.patch
+x86_64-mm-get-rid-of-arch_have_xtime_lock.patch
+x86_64-mm-a-memcpy-that-tries-to-reduce-cache-pressure.patch
+x86_64-mm-use-memcpy_uncached_read-in-rdma-interrupt-handler-to-reduce-packet-loss.patch
+x86_64-mm-improved-iommu-documentation.patch
+x86_64-mm-do-not-always-end-the-stack-trace-with-ulong_max.patch
+x86_64-mm-e820-include.patch
+x86_64-mm-page-allocation-hooks-for-vmi-backend.patch
+x86_64-mm-paravirt-cpu-hypercall-batching-mode.patch
+x86_64-mm-iopl-handling-for-paravirt-guests.patch
+x86_64-mm-smp-boot-hook-for-paravirt.patch
+x86_64-mm-vmi-backend-for-paravirt-ops.patch
+x86_64-mm-vmi-timer.patch
+x86_64-mm-move-startup_32-in-texthead-section.patch
+x86_64-mm-break-init-in-two-parts-to-avoid-modpost-warnings.patch
+x86_64-mm-mcheck-include.patch
+x86_64-mm-add-idle-notifier.patch
+x86_64-mm-improve-sched_clock-on-i686.patch
+x86_64-mm-fix-x86_64-ioremap-base_address.patch
+x86_64-mm-romsignature-checksum-cleanup.patch
+x86_64-mm-fix-fake-numa-for-x86_64-machines-with-big-io-hole.patch
+x86_64-mm-remove-fastcall-references-in-x86_64-code.patch
+x86_64-mm-use-constant-instead-of-raw-number-in-x86_64-iopermc.patch
+x86_64-mm-handle-32-bit-perfmon-counter-writes-cleanly-in-x86_64-nmi_watchdog.patch
+x86_64-mm-handle-32-bit-perfmon-counter-writes-cleanly-in-i386-nmi_watchdog.patch
+x86_64-mm-handle-32-bit-perfmon-counter-writes-cleanly-in-oprofile.patch
+x86_64-mm-config_physical_align-limited-to-4m.patch
+x86_64-mm-cleanup-doc-x86_64-files.patch
+x86_64-mm-list-x86_64-quilt-tree.patch
+x86_64-mm-simplify-notify_page_fault.patch
+x86_64-mm-mce_amd-issues.patch
+x86_64-mm-mce-trigger.patch

 x86_64 tree updates

+add-i386-idle-notifier-take-3-fix.patch

 x86 fix

+spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix.patch
+spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix-fix.patch
+x86-fix-dev_to_node-for-x86-and-x86_64.patch
+math-emu-setcc-avoid-gcc-extension.patch
+i386-adjustments-to-page-table-dump-during-oops.patch
+x86_64-re-add-a-newline-to-restore_context.patch
+mmconfig-cleanup.patch
+mmconfig-fix-unreachable_devices.patch
+pci-mmconfig-support-for-intel-915-bridges.patch
+seq_file-conversion-apm-on-i386.patch

 x86/x86_64 things

+slab-cache-alloc-cleanups.patch
+mbind-restrict-nodes-to-the-currently-allowed-cpuset.patch

 MM fixes

+uml-network-driver-locking-and-code-cleanup.patch
+uml-use-list_head-where-possible.patch
+uml-locking-commentary-in-the-random-driver.patch
+uml-mostly-const-a-structure.patch
+uml-chan_userh-formatting-fices.patch
+uml-console-locking-commentary-and-code-cleanup.patch
+uml-fix-previous-console-locking.patch
+uml-locking-comments-in-iomem-driver.patch
+uml-memc-and-physmemc-formatting-fixes.patch
+uml-initialize-a-list-head.patch
+uml-make-time-data-per-cpu.patch
+uml-delete-unused-file.patch
+uml-remove-unused-variable-and-function.patch
+uml-make-signal-handlers-static.patch
+uml-const-a-variable.patch
+uml-remove-code-controlled-by-non-existent-config-option.patch

 UML updates

+char-mxser_new-upgrade-to-1915.patch

 serial driver fix

+add-taint_user-and-ability-to-set-taint-flags-from-userspace-fix.patch
+add-taint_user-and-ability-to-set-taint-flags-from-userspace-fix-2.patch

 Fix add-taint_user-and-ability-to-set-taint-flags-from-userspace.patch

+char-moxa-macros-cleanup.patch
+char-moxa-use-del_timer_sync.patch
+char-moxa-remove-moxa_pci_devinfo.patch
+char-moxa-variables-cleanup.patch
+char-moxa-remove-useless-vairables.patch
+char-moxa-pci_probing-prepare.patch
+char-moxa-pci-probing.patch

 Moxa driver cleanups

+remove-unnecessary-memset0-calls-after-kzalloc-calls.patch
+kernel-doc-allow-a-little-whitespace.patch
+proc-remove-useless-and-buggy-nlink-settings.patch
+sysrq-showblockedtasks-is-sysrq-w.patch
+sysrq-alphabetize-command-keys-doc.patch
+kernel-doc-allow-more-whitespace.patch
+tty-improve-encode_baud_rate-logic.patch
+simplify-the-stacktrace-code.patch
+discuss-a-couple-common-errors-in-kernel-doc-usage.patch
+numerous-fixes-to-kernel-doc-info-in-source-files.patch
+common-compat_sys_sysinfo-v2.patch
+remove-a-couple-final-references-to-obsolete-verify_area.patch
+local_t-documentation.patch
+local_t-documentation-fix.patch
+ecryptfs-xattr-flags-and-mount-options.patch
+ecryptfs-generalize-metadata-read-write.patch
+ecryptfs-encrypted-passthrough.patch
+rtc-framework-driver-for-cmos-rtcs.patch
+make-bh_unwritten-a-first-class-bufferhead-flag-v2.patch
+make-xfs-use-bh_unwritten-and-bh_delay-correctly.patch
+docbook-add-edd-firmware-interfaces.patch
+kernel-doc-fix-some-odd-spacing-issues.patch
+spi-freescale-imx-spi-controller-driver.patch
+serial-support-for-new-board.patch
+make-hdlc_setup-static-again.patch
+more-ftape-removal.patch
+cleanup-linux-byteorder-swabbh.patch
+ext3-refuse-ro-to-rw-remount-of-fs-with-orphan.patch
+ext4-refuse-ro-to-rw-remount-of-fs-with-orphan.patch
+minix-v3-support.patch

 Misc

+revert-x86_64-mm-ignore-long-smi-interrupts-in-clock-calibration.patch
+reapply-x86_64-mm-ignore-long-smi-interrupts-in-clock-calibration.patch

 These are just for tree-maintenance convenience.

+flush_cpu_workqueue-dont-flush-an-empty-worklist.patch
+extend-notifier_call_chain-to-count-nr_calls-made-fixes-2.patch
+call-cpu_chain-with-cpu_down_failed-if-cpu_down_prepare-failed.patch
-fix-flush_workqueue-vs-cpu_dead-race.patch
+slab-use-cpu_lock_.patch
+workqueue-fix-freezeable-workqueues-implementation.patch
+workqueue-fix-flush_workqueue-vs-cpu_dead-race.patch
+workqueue-dont-clear-cwq-thread-until-it-exits.patch

 Work on the workqueue code.

+include-linux-nfsd-consth-remove-nfs_super_magic.patch

 nfsd cleanup

+fsaio-add-a-wait-queue-arg-to-the-wait_bit-action-routine.patch
+fsaio-rename-__lock_page-to-lock_page_blocking.patch
+fsaio-interfaces-to-initialize-and-to-test-a-wait-bit-key.patch
+fsaio-add-a-default-io-wait-bit-field-in-task-struct.patch
+fsaio-enable-wait-bit-based-filtered-wakeups-to-work-for-aio.patch
+fsaio-enable-wait-bit-based-filtered-wakeups-to-work-for-aio-fix.patch
+fsaio-enable-asynchronous-wait-page-and-lock-page.patch
+fsaio-filesystem-aio-read.patch
+fsaio-aio-o_sync-filesystem-write.patch

 async I/O for regularly-opened files.

+user-namespace-add-the-framework-fixes.patch
+user-ns-add-user_namespace-ptr-to-vfsmount-fixes.patch
+user-ns-implement-shared-mounts-fixes.patch

 Fix the user_ns patches in -mm.

+rename-attach_pid-to-find_attach_pid.patch
+attach_pid-with-struct-pid-parameter.patch

 Fiddle with function names and calling conventions.

+readahead-sysctl-parameters-set-readahead_hit_rate=1.patch
+readahead-min-max-sizes-remove-get_readahead_bounds.patch
+readahead-context-based-method-update-ra_min.patch
+readahead-context-based-method-remove-readahead_ratio.patch
+readahead-call-scheme-remove-get_readahead_bounds.patch
+readahead-nfsd-case-remove-ra_min.patch

 Update the adaptive readahead patches in -mm.

+reiser4-sb_sync_inodes-fix.patch

 Fix reiser4-sb_sync_inodes.patch

+atiixpc-remove-unused-code.patch
+atiixpc-sb600-ide-only-has-one-channel.patch
+atiixpc-add-cable-detection-support-for-ati-ide.patch
+ide-generic-jmicron-has-its-own-drivers-now.patch

 IDE fixes

+remove-bogus-con_is_present-prototypes.patch
+cyber2010-framebuffer-on-arm-netwinder-fix.patch
+cyber2010-framebuffer-on-arm-netwinder-fix-tidy.patch

 fbdev updates



All 1035 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc4-mm1/patch-list


