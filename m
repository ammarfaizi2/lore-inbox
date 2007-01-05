Return-Path: <linux-kernel-owner+w=401wt.eu-S1030351AbXAEGCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbXAEGCH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 01:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbXAEGCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 01:02:07 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56142 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030351AbXAEGCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 01:02:05 -0500
Date: Thu, 4 Jan 2007 22:02:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc3-mm1
Message-Id: <20070104220200.ae4e9a46.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Temporarily at

	http://userweb.kernel.org/~akpm/2.6.20-rc3-mm1/

will appear later at

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/



- Added the IBM ACPi driver tree to the -mm lineup, as git-ibm-acpi.patch
  (Henrique de Moraes Holschuh <hmh@hmh.eng.br>)

- Lots of block-layer changes rewriting the plug/unplug code.  Seems to work.



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



Changes since 2.6.20-rc2-mm1:


 origin.patch
 git-acpi.patch
 git-ibm-acpi.patch
 git-alsa.patch
 git-arm.patch
 git-avr32.patch
 git-cifs.patch
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
 git-sh.patch
 git-scsi-rc-fixes.patch
 git-block.patch
 git-sas.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-wireless.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees

-fix-ipmi-watchdog-set_param_str-using-kstrdup.patch
-aio-fix-buggy-put_ioctx-call-in-aio_complete.patch
-fix-lock-inversion-aio_kick_handler.patch
-powerpc-iseries-link-error-in-allmodconfig.patch
-change-warn_on-back-to-bug-at.patch
-rcu-rcutorture-suspend-fix.patch
-fix-oom-killer-kills-current-every-time-if-there-is.patch
-add-gitignore-file-for-relocs-in-arch-i386.patch
-pci-probe-fix-macro-that-confuses-kernel-doc.patch
-char-mxser-fix-oops-when-removing-opened.patch
-ib-mthca-fix-fmr-breakage-caused-by-kmemdup-conversion.patch
-maintainers-email-addr-change-for-eric-moore.patch
-make-fn_keys-work-again-on-power-macbooks.patch
-char-isicom-eliminate-spinlock-recursion.patch
-update-to-documentation-ttytxt-on-line-disciplines.patch
-fix-mrproper-incompleteness.patch
-sched-fix-cond_resched_softirq-offset.patch
-fix-compilation-of-via-pmu-backlight.patch
-module-fix-mod_sysfs_setup-return-value.patch
-mm-ramfs-breaks-without-config_block.patch
-mm-slob-is-broken-by-recent-cleanup-of-slabh.patch
-cciss-build-with-proc_fs=n.patch
-page_mkclean_one-fix-call-to-set_pte_at.patch
-spi-define-null-tx_buf-to-mean-shift-out-zeroes.patch
-m25p80-build-fixes-with-mtd-debug.patch
-spi-mtd-mtd_dataflash-oops-prevention.patch
-arm-omap-fix-gpmc-compiler-errors.patch
-arm-omap-fix-missing-header-on-apollon-board.patch
-buglet-in-vmscanc.patch
-cpuset-procfs-warning-fix.patch
-respect-srctree-objtree-in-documentation-docbook-makefile.patch
-spi_s3c24xx_gpio-use-right-header.patch
-lockdep-printk-warning-fix.patch
-restore-pdeath_signal-behaviour.patch
-gregkh-driver-driver-core-warn-users-that-the-sysfs-power-interface-really-is-broken.patch
-gregkh-driver-driver-core-prefix-driver-links-in-sys-module-by-bus-name.patch
-altix-acpi-_prt-support.patch
-git-iee1394-printk-warning-fix.patch
-git-ieee1394-build-fix.patch
-git-ieee1394-build-fix-2.patch
-git-ieee1394-build-fix-3.patch
-pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks-ide-fix.patch
-git-ubi-build-fix.patch
-git-ubi-mtd_read-arg-fix.patch
-ebtables-dont-compute-gap-before-checking-struct.patch
-pci-quirk-1k-i-o-space-iobl_adr-fix-on-p64h2.patch
-pciehp-cleanup-init_slot.patch
-pciehp-cleanup-slot-list.patch
-pciehp-remove-unnecessary-php_ctlr.patch
-pciehp-remove-unused-pci_bus-from-struct-controller.patch
-pciehp-cleanup-register-access.patch
-pciehp-cleanup-pciehph.patch
-pciehp-remove-unused-pcie_cap_base.patch
-pciehp-cleanup-wait-command-completion.patch
-pciehp-fix-wait-command-completion.patch
-pciehp-add-emi-support.patch
-scsi-advansys-wrap-pci-table-inside-ifdef-config_pci.patch
-make-qla2x00_reg_remote_port-static.patch
-git-qla3xxx-fixup.patch
-i386-restore-config_physical_start-option.patch
-remove-drivers-pci-searchcpci_find_device_reverse.patch
-piix-remove-check-for-broken-mw-dma-mode-0.patch
-piix-slc90e66-pio-mode-fallback-fix.patch

 Merged into mainline or a subsystem tree

+origin.patch
+add-afs_super_magic-to-magich.patch
+fix-implicit-declarations-in-via-pmu.patch
+fix-leds-s3c24xx-hardwareh-reference.patch
+start_kernel-test-if-irqs-got-enabled-early-barf-and-disable-them-again.patch
+start_kernel-test-if-irqs-got-enabled-early-barf-and-disable-them-again-fix.patch
+kernelparams-detect-if-and-which-parameter-parsing-enabled-irqs.patch
+kernelparams-detect-if-and-which-parameter-parsing-enabled-irqs-fix.patch
+pci-prevent-down_read-when-pci_devices-is-empty.patch
+pci-prevent-down_read-when-pci_devices-is-empty-fix.patch
+via82cxxx-fix-cable-detection.patch
+kvm-fix-gfp_kernel-alloc-in-atomic-section-bug.patch
+kvm-use-raw_smp_processor_id-instead-of-smp_processor_id-where-applicable.patch
+kvm-recover-after-an-arch-module-load-failure.patch
+kvm-improve-interrupt-response.patch
+rtc-at91rm9200-build-fix.patch
+fix-bug-at-drivers-scsi-scsi_libc1118-caused-by-pktsetup-dvd-dev-sr0.patch
+atiixp-old-drivers-ide-layer-driver-for-the-atiixp-hang.patch
+atiixp-old-drivers-ide-layer-driver-for-the-atiixp-hang-tidy.patch
+adfs-fix-filename-handling.patch
+swsusp-do-not-fail-if-resume-device-is-not-set.patch
+profiling-fix-sched-profiling-typo.patch
+i386-restore-config_physical_start-option.patch
+sanely-size-hash-tables-when-using-large-base-pages-take-2.patch
+i386-fix-modpost-warning-in-smp-trampoline-code.patch
+i386-fix-another-modpost-warning.patch
+i386-modpost-smpboot-code-warning-fix.patch
+ip2-warning-fix.patch
+fix-memory-corruption-from-misinterpreted-bad_inode_ops.patch
+fix-memory-corruption-from-misinterpreted-bad_inode_ops-tidy.patch
+fix-bug_onpageslab-from-fallback_alloc.patch
+update-the-rtc-rs5c372-driver.patch
+kvm-prevent-stale-bits-in-cr0-and-cr4.patch
+kvm-mmu-implement-simple-reverse-mapping.patch
+kvm-mmu-teach-the-page-table-walker-to-track-guest-page-table-gfns.patch
+kvm-mmu-load-the-pae-pdptrs-on-cr3-change-like-the-processor-does.patch
+kvm-mmu-fold-fetch_guest-into-init_walker.patch
+kvm-mu-special-treatment-for-shadow-pae-root-pages.patch
+kvm-mmu-use-the-guest-pdptrs-instead-of-mapping-cr3-in-pae-mode.patch
+kvm-mmu-make-the-shadow-page-tables-also-special-case-pae.patch
+kvm-mmu-make-kvm_mmu_alloc_page-return-a-kvm_mmu_page-pointer.patch
+kvm-mmu-shadow-page-table-caching.patch
+kvm-mmu-write-protect-guest-pages-when-a-shadow-is-created-for-them.patch
+kvm-mmu-let-the-walker-extract-the-target-page-gfn-from-the-pte.patch
+kvm-mmu-support-emulated-writes-into-ram.patch
+kvm-mmu-zap-shadow-page-table-entries-on-writes-to-guest-page-tables.patch
+kvm-mmu-if-emulating-an-instruction-fails-try-unprotecting-the-page.patch
+kvm-mmu-implement-child-shadow-unlinking.patch
+kvm-mmu-kvm_mmu_put_page-only-removes-one-link-to-the-page.patch
+kvm-mmu-oom-handling.patch
+kvm-mmu-remove-invlpg-interception.patch
+kvm-mmu-remove-release_pt_page_64.patch
+kvm-mmu-handle-misaligned-accesses-to-write-protected-guest-page-tables.patch
+kvm-mmu-ove-is_empty_shadow_page-above-kvm_mmu_free_page.patch
+kvm-mmu-ensure-freed-shadow-pages-are-clean.patch
+kvm-mmu-if-an-empty-shadow-page-is-not-empty-report-more-info.patch
+kvm-mmu-page-table-write-flood-protection.patch
+kvm-mmu-never-free-a-shadow-page-actively-serving-as-a-root.patch
+kvm-mmu-fix-cmpxchg8b-emulation.patch
+kvm-mmu-treat-user-mode-faults-as-a-hint-that-a-page-is-no-longer-a-page-table.patch
+kvm-mmu-free-pages-on-kvm-destruction.patch
+kvm-mmu-replace-atomic-allocations-by-preallocated-objects.patch
+kvm-mmu-detect-oom-conditions-and-propagate-error-to-userspace.patch
+kvm-mmu-flush-guest-tlb-when-reducing-permissions-on-a-pte.patch
+kvm-mmu-destroy-mmu-while-we-still-have-a-vcpu-left.patch
+kvm-mmu-add-audit-code-to-check-mappings-etc-are-correct.patch
+pata_optidma-typo-in-kconfig.patch
+hpt37x-two-important-bug-fixes.patch
+check-for-populated-zone-in-__drain_pages.patch
+qconf-fix-sigsegv-on-empty-menu-items.patch
+fix-the-toshiba_acpi-write_lcd-return-value.patch

 2.6.20 queue

+use-correct-macros-in-raid-code-not-raw-asm.patch
+use-correct-macros-in-raid-code-not-raw-asm-include.patch

 Fiddle with the RAID code's x86 assembly (needs work)

+pci-avoid-taking-pci_bus_sem-early-in-boot.patch

 Fix early-boot lockups on some machines

+git-alsa-fixup.patch

 Fix rejects in git-alsa

+sound-hda-detect-alc883-on-msi-k9a-platinum-motherboards.patch

 SOund fix

+rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues.patch
+rewrite-lock-in-cpufreq-to-eliminate-cpufreq-hotplug-related-issues-fix.patch
+ondemand-governor-restructure-the-work-callback.patch
+ondemand-governor-use-new-cpufreq-rwsem-locking-in-work-callback.patch

 cpufreq locking rewrite

+gregkh-driver-sysfs-kobject_put-cleanup.patch
+gregkh-driver-kobject-kobject_put-cleanup.patch

 Driver tree updates

+kobject-kobj-k_name-verification-fix.patch
+error-handling-in-sysfs-fill_read_buffer.patch

 Driver tree things

+make-usbvision_rvfree-static.patch
+maintainers-tag-pvrusb2-list-as-subscribers-only.patch
+ks0127-status-flags.patch

 DVB updates

+jdelvare-i2c-i2c-migration-aids-for-i2c_adapter.dev-removal.patch
+jdelvare-i2c-i2c-smbus-doc-typo.patch
+jdelvare-i2c-i2c-i801-spelling-fix.patch
+jdelvare-i2c-i2c-completion-header-cleanups.patch
+jdelvare-i2c-i2c-01-hwmon-drivers-stop-using-i2c_adapter.dev.patch
+jdelvare-i2c-i2c-02-i2c-bus-drivers-stop-using-i2c_adapter.dev.patch
+jdelvare-i2c-i2c-03-misc-i2c-drivers-stop-using-i2c_adapter.dev.patch
+jdelvare-i2c-i2c-04-other-drivers-stop-using-i2c_adapter.dev.patch
+jdelvare-i2c-i2c-05-remove-i2c_adapter.dev-from-all-i2c-adapters.patch
+jdelvare-i2c-i2c-06-missing-i2c_adapter-parent-devices.patch

 I2C tree updates

+i2c-m41t00-do-not-forget-to-write-year.patch

 i2c driver fix

+ia64-swiotlb-bug-fixes.patch
+ia64-make-swiotlb-use-bus_to_virt-virt_to_bus.patch
+ia64-swiotlb-cleanup.patch
+ia64-swiotlb-abstraction-eg-for-xen.patch
+ia64-missing-exports-hwsw_sync_.patch
+ia64-enable-swiotlb-only-when-needed.patch
+show_mem-for-ia64-sparsemem-numa.patch

 ia64 stuff

-git-libata-all-fixup.patch

 Unneeded

-mmc-add-support-for-sdhc-cards.patch
+mmc-add-a-quirk-to-allow-ene-pci-sd-card-readers-to-work-again.patch

 Updated

+ubiioc-needs-schedh.patch
+drivers-mtd-ubi-vtblc-make-2-functions-static.patch

 Fix git-ubi

+sis190-mac-address-setting-fix.patch
+qeth-fix-uaccess-handling-and-get-rid-of-unused-variable.patch
+net-ifb-error-path-loop-fix.patch
+forcedeth-sideband-management-fix.patch

 netdev updates

+fix-for-crash-in-adummy_init.patch

 net fix

+r8169-warning-fixes.patch

 netdev warning fix

+gregkh-pci-pci-remove-pci_find_device_reverse.patch
+gregkh-pci-pci-mark-pci_find_device-as-__deprecated.patch
+gregkh-pci-pciehp-cleanup-init_slot.patch
+gregkh-pci-pciehp-cleanup-slot-list.patch
+gregkh-pci-pciehp-remove-unnecessary-php_ctlr.patch
+gregkh-pci-pciehp-remove-unused-pci_bus-from-struct-controller.patch
+gregkh-pci-pciehp-cleanup-register-access.patch
+gregkh-pci-pciehp-cleanup-pciehp.h.patch
+gregkh-pci-pciehp-remove-unused-pcie_cap_base.patch
+gregkh-pci-pciehp-cleanup-wait-command-completion.patch
+gregkh-pci-pciehp-fix-wait-command-completion.patch
+gregkh-pci-add-emi-support-to-pciehp.patch
+gregkh-pci-pci-quirk-1k-i-o-space-iobl_adr-fix-on-p64h2.patch

 PCI tree updates

+x86-fix-dev_to_node-for-x86-and-x86_64.patch

 Fix dev_to_node()

+scsi-lpfc-error-path-fix.patch

 scsi driver fix

+git-block-atomicity-fix.patch

 Fix git-block

+gregkh-usb-usb-storage-unusual_devs-add-supertop-drives.patch
+gregkh-usb-usb-storage-fix-ipod-ejecting-issue.patch
+gregkh-usb-usb-small-update-to-documentation-usb-acmtxt.patch
+gregkh-usb-usb-fixed-bug-in-endpoint-release-function.patch
+gregkh-usb-usb-fix-ohci-warning.patch
+gregkh-usb-usb-fix-ehci-warning.patch
+gregkh-usb-usb-gadget-file_storage.c-remove-unnecessary-casts.patch
+gregkh-usb-usb-add-usb_endpoint_xfer_control-to-usb.h.patch

 USB tree updates

-revert-gregkh-usb-usb-implement-support-for-split-endian-ohci.patch
-revert-gregkh-usb-usb-implement-support-for-ehci-with-big-endian-mmio.patch
-revert-gregkh-usb-ohci-add-support-for-ohci-controller-on-the-of_platform-bus.patch

 Dropped

-usb-interrupt-endpoint-support-for-keyspan-usb-to-serial.patch

 Dropped (I think)

+usblpc-add-kyocera-mita-fs-820-to-list-of-quirky-printers.patch
+input-hid-add-cidc-usb-device-to-hid-blacklist.patch
+usb-usbmixer-error-path-fix.patch
+fix-for-bugzilla-7544-keyspan-usb-to-serial-converter.patch
+sisusb_con-warning-fixes.patch

 USB updates

-convert-i386-pda-code-to-use-%fs-ptrace-make-putgetreg-work-again-for-gs-and-fs.patch

 Filded into convert-i386-pda-code-to-use-%fs.patch

+paravirt-vmi-backend-for-paravirt-ops-compile-fix.patch
+paravirt-vmi-backend-for-paravirt-ops-initialize-fs-for-smp.patch
+paravirt-vmi-backend-for-paravirt-ops-native-fix.patch

 Fix paravirt-vmi-backend-for-paravirt-ops.patch

-add-i386-idle-notifier-take-3-fix.patch

 Folded into add-i386-idle-notifier-take-3.patch

-sched-improve-sched_clock-on-i686-fix.patch

 Folded into sched-improve-sched_clock-on-i686.patch

-mmconfig-fix-x86_64-ioremap-base_address.patch

 Dropped

+fix-fake-numa-for-x86_64-machines-with-big-io-hole.patch
+x86-64-calgary-tighten-up-printks.patch
+remove-fastcall-references-in-x86_64-code.patch
+spin_lock_irq-enable-interrupts-while-spinning-preparatory-patch.patch
+spin_lock_irq-enable-interrupts-while-spinning-x86_64-implementation.patch
+spin_lock_irq-enable-interrupts-while-spinning-i386-implementation.patch
+use-constant-instead-of-raw-number-in-x86_64-iopermc.patch
+all-transmeta-cpus-have-constant-tscs.patch

 x86/x86_64 updates

+slab-remove-broken-pageslab-check-from-kfree_debugcheck.patch

 slab fix

+uml-console-locking-fixes.patch
+uml-return-hotplug-errors-to-host.patch
+uml-console-whitespace-and-comment-tidying.patch
+uml-lock-the-irqs_to_free-list.patch
+uml-add-locking-to-network-transport-registration.patch
+uml-network-driver-whitespace-and-style-fixes.patch
+uml-watchdog-driver-locking.patch
+uml-watchdog-driver-formatting.patch
+uml-audio-driver-locking.patch
+uml-audio-driver-formatting.patch
+uml-mconsole-locking.patch
+uml-make-two-variables-static.patch
+uml-port-driver-formatting.patch
+uml-kill-a-compilation-warning.patch

 UML updates

+spi-controller-driver-for-omap-microwire-update.patch
+spi-controller-driver-for-omap-microwire-update-fix.patch

 Fix spi-controller-driver-for-omap-microwire.patch some more

+char-mxser_new-remove-unused-stuff.patch
+char-mxser-obsolete-old-nonexperimental-new.patch
+char-mxser_new-remove-tty_wakeup-bottomhalf.patch
+char-mxser_new-clean-request_irq-call.patch
+doc-isicom-remove-reserved-ioctl-number.patch
+char-mxser_new-alter-locking-in-isr.patch
+char-mxser_new-header-file-cleanup.patch
+char-mxser_new-less-loops-in-isr.patch
+char-mxser_new-fix-twice-resource-releasing.patch
+char-mxser_new-do-not-put-pdev.patch
+aio-fix-buggy-put_ioctx-call-in-aio_complete-v2.patch
+add-taint_user-and-ability-to-set-taint-flags-from-userspace.patch
+char-moxa-remove-unused-allocated-page.patch
+char-moxa-do-not-initialize-global-static.patch
+char-moxa-timers-cleanup.patch
+char-moxa-remove-hangup-bottomhalf.patch
+char-moxa-remove-unused-functions.patch
+char-moxa-devids-cleanup.patch
+char-moxa-use-pci_device.patch
+char-moxa-eliminate-typedefs.patch
+docbook-html-generate-chapter-section-level-tocs-for-functions.patch
+export-invalidate_mapping_pages-to-modules.patch
+remove-invalidate_inode_pages.patch
+use-cycle_t-instead-of-u64-in-struct-time_interpolator.patch
+fix-sparse-warnings-from-asmnet-checksumh.patch
+add-an-rcu-version-of-list-splicing.patch
+add-an-rcu-version-of-list-splicing-fix.patch
+ipmi-fix-some-rcu-problems.patch
+ipmi-fix-some-rcu-problems-update.patch
+clone-flag-clone_parent_tidptr-leaves-invalid-results-in-memory.patch
+factor-outstanding-i-o-error-handling.patch
+factor-outstanding-i-o-error-handling-tidy.patch
+sync_sb_inodes-propagate-errors.patch
+block_write_full_page-handle-enospc.patch
+get-rid-of-double-zeroing-of-allocated-pages.patch
+relax-check-for-aix-in-msdos-partition-table.patch
+msdos-partitions-fix-logic-error-in-aix-detection.patch
+add-const-for-timespecval_compare-arguments.patch
+schedule-obsolete-oss-drivers-for-removal-3rd-round.patch
+sysctl-warning-fix.patch
+proc_misc-warning-fix.patch

 Misc fixes and updates

+hrtimers-namespace-and-enum-cleanup-vs-git-input.patch

 Fix hrtimers-namespace-and-enum-cleanup.patch

+reimplement-flush_workqueue.patch
+implement-flush_work.patch
+implement-flush_work-sanity.patch
+implement-flush_work_keventd.patch
+flush_workqueue-use-preempt_disable-to-hold-off-cpu-hotplug.patch
+aio-use-flush_work.patch
+kblockd-use-flush_work.patch
+relayfs-use-flush_keventd_work.patch
+tg3-use-flush_keventd_work.patch
+e1000-use-flush_keventd_work.patch
+libata-use-flush_work.patch
+phy-use-flush_work.patch

 workqueue API changes and users thereof.

+edac-e752x-bit-mask-fix.patch
+edac-e752x-byte-access-fix.patch
+edac-fix-in-e752x-mc-driver.patch
+edac-add-memory-scrubbing-controls-api-to-core.patch
+edac-add-fully-buffered-dimm-apis-to-core.patch

 EDAC driver updates

+aio-is-unlikely.patch

 AIO tweak.

+nsproxy-externalizes-exit_task_namespaces.patch
+user-namespace-add-the-framework.patch
+user-namespace-add-the-framework-fix.patch
+user-ns-add-user_namespace-ptr-to-vfsmount.patch
+user-ns-hook-permission.patch
+user-ns-prepare-copy_tree-copy_mnt-and-their-callers-to-handle-errs.patch
+user-ns-prepare-copy_tree-copy_mnt-and-their-callers-to-handle-errs-fix.patch
+user-ns-implement-shared-mounts.patch
+user_ns-handle-file-sigio.patch
+user-ns-implement-user-ns-unshare.patch
+user-ns-implement-user-ns-unshare-tidy.patch

 virtualise struct user.

+user-ns-always-on.patch

 Temporarily force CONFIG_USER_NS=y, because to kerenl doesn't work with it
 disabled.

+reiser4-vs-git-block.patch
+reiser4-vs-git-block-2.patch

 Update resier4 for git-block API changes.

+piix-tuneproc-fixes-cleanups.patch
+slc90e66-carry-over-fixes-from-piix-driver.patch
+hpt36x-pci-clock-detection-fix.patch

 IDE driver updates

+remove-555-unneeded-includes-of-schedh.patch

 Untangle some headers

+fix-flush_workqueue-vs-cpu_dead-race.patch

 More workqueue changes

+integrity-service-api-and-dummy-provider-fix.patch

 Fixegrity-service-api-and-dummy-provider.patch some more

+panic-on-slim-selinux.patch

 Fix SLIM patches in -mm.

-unplug-can-sleep.patch

 Dropped due to git-block changes

+profile-likely-unlikely-macros-x86_64-fix.patch

 Fix profile-likely-unlikely-macros.patch




All 933 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/patch-list


