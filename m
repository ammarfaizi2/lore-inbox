Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757333AbWKWKRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333AbWKWKRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbWKWKRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:17:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757335AbWKWKRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:17:31 -0500
Date: Thu, 23 Nov 2006 02:17:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc6-mm1
Message-Id: <20061123021703.8550e37e.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Temporarily at

http://userweb.kernel.org/~akpm/2.6.19-rc6-mm1/

and will appear later at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm1/



- Added per-task I/O accounting via netlink, or via /proc/pid/io.  It
  attempts to show how much physical I/O a task has caused, or shall cause.



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



Changes since 2.6.19-rc5-mm2:

 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-agpgart.patch
 git-arm.patch
 git-cifs.patch
 git-cpufreq.patch
 git-powerpc.patch
 git-drm.patch
 git-dvb.patch
 git-gfs2-nmw.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-libata-all.patch
 git-mips.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-ioat.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-r8169.patch
 git-selinux.patch
 git-pciseg.patch
 git-s390.patch
 git-sh.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-sas.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-wireless.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees

-setup_irq-better-mismatch-debugging.patch
-fix-via586-irq-routing-for-pirq-5.patch
-revert-pci-quirk-for-ibm-dock-ii-cardbus-controllers.patch
-drivers-ide-stray-bracket.patch
-autofs4-panic-after-mount-fail.patch
-nvidiafb-fix-unreachable-code-in-nv10getconfig.patch
-usb-maintainers-updates.patch
-hugetlb-prepare_hugepage_range-check-offset-too.patch
-hugetlb-check-for-brk-entering-a-hugepage-region.patch
-ipmi-use-platform_device_add-instead-of-platform_device_register-to-register-device-allocated-dynamically.patch
-ia64-irqs-use-name-not-typename.patch
-gregkh-driver-w1-ioremap-balanced-with-iounmap.patch
-gregkh-driver-debugfs-check-return-value-correctly.patch
-drivers-media-handle-errors-from-input_register_device.patch
-jdelvare-i2c-i2c-scx200_acb-handle-pci-errors.patch
-input-map-btn_forward-to-button-2-in-mousedev.patch
-mac_emumousebtn-shouldnt-depend-on-input_adbhid.patch
-appletouch-improvements-for-macbook.patch
-libata-convert-from-module_init-to-subsys_initcall-resend.patch
-sata_vsc-build-fix.patch
-hpt37x-check-the-enablebits.patch
-pata_artop-fix-1-typo.patch
-libata-change-order-of-_sdd-_gtf-execution-resend-3.patch
-sundance-solve-host-error-problem-in-low-performance-embedded.patch
-add-tsi108-9-on-chip-ethernet-device-driver-support.patch
-e1000-linkage-fix.patch
-wan-dscc4-driver-requires-generic-hdlc.patch
-fix-compat-space-msg-size-limit-for-msgsnd-msgrcv.patch
-ppc-booke-reg-mcsr-msg-misquoted.patch
-ppc4xx-compilation-fixes-for-pci-less-configs.patch
-drivers-scsi-qla2xxx-make-some-functions-static.patch
-scsi-aha1740-handle-scsi-api-errors.patch
-scsi-minor-bug-fixes-and-cleanups.patch
-revert-scsi-ips-soft-lockup-during-reset-initialization.patch
-scsi-ips-soft-lockup-during-reset-initialization-2.patch
-scsi-t128-scsi_cmnd-convertion.patch
-gregkh-usb-usb-ftdi_sio-adds-vendor-product-id-for-a-rfid-construction-kit.patch
-gregkh-usb-usb-ftdi-driver-pid-for-dmx-interfaces.patch
-gregkh-usb-usb-fix-ucr-61s2b-unusual_dev-entry.patch
-gregkh-usb-usb-ohci-fix-root-hub-resume-bug.patch
-gregkh-usb-usb-correct-keymapping-on-powerbook-built-in-usb-iso-keyboards.patch
-gregkh-usb-usb-storage-unusual_devs.h-entry-for-sony-ericsson-p990i.patch
-gregkh-usb-usb-hid-core-add-quirk-for-new-apple-keyboard-trackpad.patch
-gregkh-usb-usb-storage-remove-duplicated-unusual_devs.h-entries-for-sony-ericsson-p990i.patch
-gregkh-usb-usb-fixed-outdated-usb_get_device_descriptor-documentation.patch
-gregkh-usb-usb-ipaq-add-htc-modem-support.patch
-gregkh-usb-usb-auerswald-possible-memleak-fix.patch
-usb-sn9c102_core-free-urb-cleanup.patch
-usb-zc0301_core-free-urb-cleanup.patch
-x86_64-mm-io-apic-reuse.patch
-x86_64-mm-fix-exit-idle-race.patch
-x86_64-mm-reserve-bootmem-beyond-end-pfn.patch
-x86_64-mm-setup-saved_max_pfn-correctly-kdump.patch
-x86_64-mm-ptrace-compat-threadarea.patch
-x86_64-mm-pci-mcfg-reserve-e820.patch
-x86_64-mm-fix-boot-gdt-limit.patch
-x86_64-mm-e820-small-entries.patch
-x86_64-mm-header-and-stubs-for-paravirtualisation.patch
-x86_64-mm-patch-inline-replacements-for.patch
-x86_64-mm-more-generic-paravirtualization.patch
-x86_64-mm-allow-selected-bug-checks-to-be.patch
-x86_64-mm-allow-disabling-legacy-power.patch
-x86_64-mm-add-apic-accessors-to-paravirt-ops..patch
-x86_64-mm-add-mmu-virtualization-to.patch
-x86_64-mm-be-careful-about-touching-bios-address-space.patch
-x86_64-mm-genapic-offbyone.patch
-pda-percpu-init-make-arch-i386-kernel-cpu-commoncalloc_gdt-static.patch
-paravirt-mmu-header-movement.patch
-paravirt-cpu-detect.patch
-paravirt-pte-update-prep.patch
-paravirt-pte-update-common.patch
-revert-x86_64-mm-try-multiple-timer-pins.patch
-revert-x86_64-mm-try-multiple-timer-pins-wanring-fix.patch
-fix-x86_64-mm-i386-reloc-cleanup-align.patch
-fix-x86_64-mm-i386-reloc-kallsyms.patch
-i386-convert-more-absolute-symbols-to-section-relative.patch
-i386-add-write_pci_config_byte-to-direct-pci-access-routines.patch
-i386-introduce-the-mechanism-of-disabling-cpu-hotplug-control.patch
-i386-introduce-the-mechanism-of-disabling-cpu-hotplug-control-cleanup.patch
-x86_64-add-genapic_force.patch
-fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch
-i386-fix-machine_check-entry-point-in-entrys-to-not-dereference-kernel-memory-from-user-space-context.patch
-efi-calling-efi_get_time-during-suspend.patch
-arch-i386-kernel-io_apicc-handle-a-negative-return-value.patch
-make-arch-i386-kernel-io_apiccirq_vector-static.patch
-crypto-remove-one-too-many-semicolon-in-cryptoh.patch
-ia64-fix-allmodconfig-build.patch
-afs-amend-the-afs-configuration-options.patch

 Merged into mainline or a subsystem tree

+pcmcia-fix-rmmod-pcmcia-with-unbound-devices.patch
+initramfs-handle-more-than-one-source-dir-or-file-list.patch
+fuse-fix-oops-in-lookup.patch
+mounstats-null-pointer-dereference.patch
+debugfs-add-header-file.patch
+documentation-rtctxt-updates-for-rtc-class.patch
+rtc-framework-handles-periodic-irqs.patch
+rtc-framework-handles-periodic-irqs-fix.patch
+rtc-class-locking-bugfixes.patch
+drivers-rtc-rtc-rs5c372c-fix-a-null-dereference.patch
+reiserfs-fmt-bugfix.patch
+fix-device_attribute-memory-leak-in-device_del.patch
+qconf-fix-uninitialised-member.patch
+fix-menuconfig-colours.patch
+sgiioc4-disable-module-unload.patch
+fix-copy_process-error-check.patch
+tlclk-fix-platform_device_register_simple-error-check.patch
+enforce-unsigned-long-flags-when-spinlocking.patch
+lockdep-spin_lock_irqsave_nested.patch
+lockdep-spin_lock_irqsave_nested-fix.patch
+lockdep-spin_lock_irqsave_nested-fix-2.patch
+correct-bound-checking-from-the-value-returned-from-_ppc-method.patch
+usb-ati-remote-memleak-fix.patch

 2.6.19 queue

+acpi-processor-prevent-loading-module-on-failures.patch
+make-drivers-acpi-baycdrive_bays-static.patch
+acpi-replace-kmallocmemset-with-kzalloc.patch
+make-drivers-acpi-eccec_ecdt-static.patch
+drivers-acpi-oslc-fix-a-null-check.patch
+acpi-dont-select-pm.patch

 ACPI things

+git-alsa-fixup.patch

 Fix rejects in git-alsa.patch

+sound-initialize-rawmidi-substream-list.patch
+sound-fix-pcm-substream-list.patch

 ALSA things

+cpufreq-set-policy-curfreq-on-initialization.patch
+bug-fix-for-acpi-cpufreq-and-cpufreq_stats-oops-on-frequency-change-notification.patch

 cpufreq fixes

+gregkh-driver-driver-core-introduce-device_find_child.patch

 Driver tree update

+fix-gregkh-driver-sound-device-2.patch
+tidy-gregkh-driver-udev-compatible-hack.patch
+driver-core-introduce-device_move-move-a-device.patch
+platform_driver_probe-can-save-codespace.patch
+platform_driver_probe-can-save-codespace-save-codespace.patch
+documentation-driver-model-platformtxt-update-rewrite.patch
+driver-core-use-klist_remove-in-device_move.patch

 driver-tree fixes

-git-dvb-fixup.patch

 Unneeded

+jdelvare-hwmon-hwmon-f71805f-fix-address-decoding.patch

 hwmon tree update

+fs-dlm-lowcomms-tcpc-remove-2-functions.patch

 GFS2 fixlet

+pata_hpt366-more-enable-bits.patch
+pci-move-pci_vdevice-from-libata-to-core.patch
+pata-libata-suspend-resume-simple-cases.patch
+pata-libata-suspend-resume-simple-cases-fix.patch
+pata_cmd64x-suspend-resume.patch
+pata_cs5520-resume-support.patch
+pata_jmicron-fix-jmb368-support-add-suspend-resume.patch
+pata_cs5530-suspend-resume-support.patch
+pata_cs5530-suspend-resume-support-tweak.patch
+pata_rz1000-force-readahead-off-on-resume.patch
+pata_ali-suspend-resume-support.patch
+pata_sil680-suspend-resume.patch
+pata_sil680-suspend-resume-tidy.patch
+ata-fix-platform_device_register_simple-error-check.patch
+sata_promise-updates.patch
+initializer-entry-defined-twice-in-pata_rz1000.patch
+ata_piix-ide-mode-sata-patch-for-intel-ich9.patch

 SATA and PATA updates

+mtd-replace-kmallocmemset-with-kzalloc.patch

 MTD cleanup

+git-netdev-all-fixup.patch

 Fix rejects in git-netdev-all.patch

+spidernet-poor-network-performance.patch
+chelsio-22-driver.patch
+bonding-incorrect-bonding-state-reported-via-ioctl.patch

 netdev updates

+git-net-fixup.patch

 Fix rejects in git-net.patch

+networking-re-fix-of-doc-comment-in-sockh.patch
+make-udp_encap_rcv-use-pskb_may_pull.patch

 Net fixes

+net-uninline-skb_put-fix.patch

 Fix net-uninline-skb_put.patch

+serial-replace-kmallocmemset-with-kzalloc.patch

 Serial cleanups

+pci-introduce-pci_find_present.patch
+pci-fix-multiple-problems-with-via-hardware.patch
+pci-fix-multiple-problems-with-via-hardware-warning-fix.patch
+drivers-pci-hotplug-ibmphp_pcic-fix-null-dereference.patch
+update-documentation-pcitxt.patch
+pci-move-pci_fixup_device-and-is_enabled.patch
+pci-add-selected_regions-funcs.patch
+e1000-make-intel-e1000-driver-legacy-i-o-port-free.patch
+lpfc-make-emulex-lpfc-driver-legacy-i-o-port-free.patch

 PCI updates

+s390-preparatory-cleanup-in-common-i-o-layer.patch
+s390-make-the-per-subchannel-lock-dynamic.patch
+s390-dynamic-subchannel-mapping-of-ccw-devices.patch

 s390 updates

+drivers-scsi-aic7xxx-make-functions-static.patch
+scsi-advansys-wrap-pci-table-inside-ifdef-config_pci.patch

 SCSI updates

+git-sas-fixup.patch

 Fix rejects in git-sas.patch

+usb-pwc-if-loop-fix.patch
+usb-microtek-possible-memleak-fix.patch
+usb-cypress_m8-init-error-path-fix.patch
+usbtouchscreen-add-support-for-dmc-tsc-10-25-devices.patch
+make-drivers-usb-host-u132-hcdcu132_hcd_wait-static.patch
+make-drivers-usb-input-wacom_syscwacom_sys_irq-static.patch
+drivers-usb-misc-ftdi-elanc-fixes-and-cleanups.patch
+make-drivers-usb-core-drivercusb_device_match-static.patch
+usb-serial-replace-kmallocmemset-with-kzalloc.patch
+usb-auerswald-replace-kmallocmemset-with-kzalloc.patch

 USB updates

+pre-x86_64-mm-i386-reloc-abssym.patch

 Needed so that an x86-tree patch applies

+x86_64-mm-i386-pci-dma-iounmap.patch
+x86_64-mm-paravirt-core.patch
+x86_64-mm-paravirt-inline.patch
+x86_64-mm-cpu_detect-extraction.patch
+x86_64-mm-paravirt-startup.patch
+x86_64-mm-paravirt-no-bugs.patch
+x86_64-mm-paravirt-no-vdso.patch
+x86_64-mm-paravirt-no-powermgmt.patch
+x86_64-mm-paravirt-apic.patch
+x86_64-mm-paravirt-mmu.patch
+x86_64-mm-paravirt-bios.patch
+x86_64-mm-mmu-header-movement.patch
+x86_64-mm-fix-bad-mmu-names.patch
+x86_64-mm-fix-missing-pte-update.patch
+x86_64-mm-skip-timer-works.patch
+x86_64-mm-i386-config-core2.patch
+x86_64-mm-vsyscall-perms.patch
+x86_64-mm-irq-rate-limit.patch
+x86_64-mm-clear_fixmap-should-not-use-set_pte.patch
+x86_64-mm-i386-nmi-watchdog-cpu-limit.patch
+x86_64-mm-earlyprintk-con-boot.patch
+x86_64-mm-remove-prototype-of-free_bootmem_generic.patch
+x86_64-mm-conditionalize-inclusion-of-some-mtrr-flavors.patch
+x86_64-mm-adjust-pmd_bad.patch
+x86_64-mm-fix-mtrr-code.patch
+x86_64-mm-alloc_gdt-static.patch
+x86_64-mm-fix-x86_64-mm-i386-reloc-kallsyms.patch
+x86_64-mm-convert-more-absolute-symbols-to-section-relative.patch
+x86_64-mm-add-write_pci_config_byte-to-direct-pci-access-routines.patch
+x86_64-mm-introduce-the-mechanism-of-disabling-cpu-hotplug-control.patch
+x86_64-mm-change-the-no_control-field-to-hotpluggable-in-the-struct-cpu.patch
+x86_64-mm-add-genapic_force.patch
+x86_64-mm-fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch
+x86_64-mm-calling-efi_get_time-during-suspend.patch
+x86_64-mm-handle-a-negative-return-value.patch
+x86_64-mm-i386-irq-vector-static.patch
+x86_64-mm-x86-64-add-intel-bts-cpufeature-bit-and-detection-take-2.patch
+x86_64-mm-i386-add-intel-bts-cpufeature-bit-and-detection-take-2.patch
+x86_64-mm-i386-apic-early-param.patch
+x86_64-mm-apic-suspend-msrs.patch
+x86_64-mm-genericarch-up-compilation.patch
+x86_64-mm-backtrace-strict-check.patch
+x86_64-mm-vdso.patch
+x86_64-mm-i386-efi-memmap.patch
+x86_64-mm-i386-remove-duplicate-printk.patch

 x86 tree updates

+revert-x86_64-mm-vdso.patch
+revert-x86_64-mm-earlyprintk-con-boot.patch
+fix-x86_64-mm-patch-inline-replacements-for-section-warnings.patch

 Fix it

+post-x86_64-mm-i386-reloc-abssym.patch

 Reapply this

+mtrr-replace-kmallocmemset-with-kzalloc.patch
+i386-correct-documentation-for-bzimage-protocol-v205.patch
+fix-asm-constraints-in-i386-atomic_add_return.patch
+i386-msr-remove-unused-variable.patch
+x86_64-smpboot-remove-unused-variable.patch
+arch-i386-kernel-remove-remaining-pc98-code.patch
+i386-replace-kmallocmemset-with-kzalloc.patch
+x86_64-fake-numa-provides-a-io-hole-size-in-a-given-address-range.patch
+x86_64-fake-numa-increase-the-node_shift.patch
+x86_64-fake-numa-fix-numa=fake.patch
+x86_64-fake-numa-extends-the-kernel-command-line-option-for-numa=fake.patch

 x86/x86_64 things

+altix-acpi-ssdt-pci-device-support.patch
+altix-add-acpi-ssdt-pci-device-support-hotplug.patch
+add-support-for-acpi_load_table-acpi_unload_table_id.patch

 Altix work

+always-print-out-the-header-line-in-proc-swaps.patch
+leak-tracking-for-kmalloc_node.patch
+leak-tracking-for-kmalloc_node-fix.patch
+add-numa-node-information-to-struct-device.patch
+add-numa-node-information-to-struct-device-tidy.patch
+node-aware-skb-allocation.patch
+node-aware-skb-allocation-fix-for-device-tree-changes.patch
+allow-null-pointers-in-percpu_free.patch
+enables-booting-a-numa-system-where-some-nodes-have-no.patch
+make-mm-thrashcglobal_faults-static.patch
+remove-bio_cachep-from-slabh.patch
+move-sighand_cachep-to-include-signalh.patch
+move-vm_area_cachep-to-include-mmh.patch
+move-files_cachep-to-include-fileh.patch
+move-filep_cachep-to-include-fileh.patch
+move-fs_cachep-to-linux-fs_structh.patch
+move-names_cachep-to-linux-fsh.patch
+remove-uses-of-kmem_cache_t-from-mm-and-include-linux-slabh.patch
+drain_node_page-drain-pages-in-batch-units.patch
+numa-node-ids-are-int-page_to_nid-and-zone_to_nid-should-return-int.patch
+silence-unused-pgdat-warning-from-alloc_bootmem_node-and-friends.patch
+reject-corrupt-swapfiles-earlier.patch
+mm-call-into-direct-reclaim-without-pf_memalloc-set.patch
+mm-cleanup-and-document-reclaim-recursion.patch

 Memory management updates

-security-introduce-file-caps.patch
-security-introduce-file-caps-tweaks.patch
-security-introduce-file-caps-warning-fix.patch

 Dropped - this has problems.

+add-include-linux-freezerh-and-move-definitions-from-ucb1400_ts-fix.patch

 Fix add-include-linux-freezerh-and-move-definitions-from.patch some more.

-swsusp-freeze-filesystems-during-suspend-rev-2.patch
-swsusp-freeze-filesystems-during-suspend-rev-2-comments.patch

 Dropped

+suspend-to-disk-fails-if-gdb-is-suspended-with-a-traced-child.patch
+convert-pm_sem-to-a-mutex.patch
+convert-pm_sem-to-a-mutex-fix.patch
+swsusp-untangle-thaw_processes.patch
+swsusp-untangle-freeze_processes.patch
+swsusp-fix-coding-style-in-suspendc.patch
+swsusp-fix-labels.patch
+support-for-freezeable-workqueues.patch
+use-freezeable-workqueues-in-xfs.patch

 swsusp updates

+deprecate-smbfs-in-favour-of-cifs-docs.patch

 Update deprecate-smbfs-in-favour-of-cifs.patch

+fix-serial-uartlite-after-global-pt_regs.patch
+serial-uartlite-support-multiple-devices.patch
+serial-uartlite-initialize-port-parameters-in-console_setup.patch

 Serial updates

+remove-drivers-pci-searchcpci_find_device_reverse.patch

 PCI cleanup

+fuse-fix-compile-without-config_block.patch

 FUSE fix

+hpfs-fix-printk-format-warnings.patch

 hpfs warning fixes

+initrd-remove-unused-false-condition-for.patch
+fix-the-size-limit-of-compat-space-msgsize.patch
+elf-always-define-elf_addr_t-in-linux-elfh.patch
+elf-include-terminating-zero-in-n_namesz.patch
+elf-fix-kcore-note-size-calculation.patch
+elf-fix-kcore-note-size-calculation-fix.patch
+reiserfs-add-missing-d-cache-flushing.patch
+reiserfs-add-missing-d-cache-flushing-tweak.patch
+the-scheduled-removal-of-some-oss-options.patch
+make-1-bit-bitfields-unsigned.patch
+hvcs-char-driver-janitoring-move-block-of-code.patch
+hvcs-char-driver-janitoring-rm-compiler-warnings.patch
+kprobes-enable-booster-on-the-preemptible-kernel.patch
+hotplug-cpu-clean-up-hotcpu_notifier-use.patch
+hotplug-cpu-clean-up-hotcpu_notifier-use-vs-gregkh-driver-cpu-topology-consider-sysfs_create_group-return-value.patch
+ext3-fix-reservation-extension.patch
+ext4-fix-reservation-extension.patch
+make-arch-i386-pci-commoncpci_bf_sort-static.patch
+allow-hwrandom-core-to-be-a-module.patch
+make-mm-shmemcshmem_xattr_security_handler-static.patch
+remove-kernel-lockdepclockdep_internal.patch
+make-kernel-signalckill_proc_info-static.patch
+i2o-handle-__copy_from_user.patch
+i2o-fix-i2o_config-without-adaptec-extension.patch
+make-ecryptfs_version_str_map-static.patch
+make-fs-jbd-transactionc__journal_temp_unlink_buffer-static.patch
+make-fs-jbd2-transactionc__jbd2_journal_temp_unlink_buffer-static.patch
+fs-lockd-hostc-make-2-functions-static.patch
+make-fs-proc-basecproc_pid_instantiate-static.patch
+parport-section-mismatches-with-hotplug=n.patch
+agp-amd64-section-mismatches-with-hotplug=n.patch
+scsi-initio-section-mismatches-with-hotplug=n.patch
+add-rtc-omap-driver.patch
+add-return-value-checking-of-get_user-in.patch
+add-return-value-checking-of-get_user-in-fix.patch
+ciss-require-same-scsi-module-support.patch
+export-toshiba-smm-support-for-neofb-module.patch
+kernel-doc-add-fusion-and-i2o-to-kernel-api-book.patch
+kernel-doc-fix-fusion-and-i2o-docs.patch
+kernel-api-book-remove-videodev-chapter.patch
+rcu-add-a-prefetch-in-rcu_do_batch.patch
+dont-insert-pipe-dentries-into-dentry_hashtable.patch
+dcache-avoid-rcu-for-never-hashed-dentries.patch
+net-dont-insert-socket-dentries-into-dentry_hashtable.patch
+kernel-core-replace-kmallocmemset-with-kzalloc.patch
+kernel-doc-stricter-function-pointer-recognition.patch
+input-add-to-kernel-api-docbook.patch

 Misc updates

+io-accounting-core-statistics.patch
+io-accounting-core-statistics-fix.patch
+clean-up-__set_page_dirty_nobuffers.patch
+io-accounting-write-accounting.patch
+io-accounting-write-cancel-accounting.patch
+io-accounting-read-accounting-2.patch
+io-accounting-read-accounting-nfs-fix.patch
+io-accounting-read-accounting-cifs-fix.patch
+io-accounting-metadata-read-accounting.patch
+io-accounting-direct-io.patch
+io-accounting-report-in-procfs.patch
+cleanup-taskstatsh.patch
+io-accounting-via-taskstats.patch
+getdelays-various-fixes.patch
+io-accounting-add-to-getdelays.patch

 per-task IO accounting

-ext2-reservations-fix.patch
-ext2-reservations-sequential-read-regression-fix.patch
-ext2-reservations-filesystem-bogus-ENOSPC-with-reservation-fix.patch
-ext2-reservations-ext3_clear_inode-avoid-kfree-null.patch
-ext2-reservations-multile-block-allocate-little-endian-fixes.patch
-ext2-reservations-mark-group-descriptors-dirty-during-allocation.patch
-ext2-reservations-nuke-noisy-printk.patch
-ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3.patch

 Folded into ext2-reservations.patch

+ext2-fix-reservation-extension.patch
+make-ext2_get_blocks-static.patch

 ext2-reservations updates

+generic-bug-implementation-handle-bug=n.patch

 Fix generic-bug-implementation.patch

+net-use-bitrev8-tidy.patch

 Clean up the bitrev cleanups

+drivers-mtd-nand-rtc_from4c-use-lib-bitrevc.patch
+drivers-mtd-nand-rtc_from4c-use-lib-bitrevc-tidy.patch

 Use the bitrev library

+ecryptfs-use-fsstacks-generic-copy-inode-attr-tidy-fix-fix.patch

 fix ecryptfs some more

-fs-cache-provide-a-filesystem-specific-syncable-page-bit.patch
-fs-cache-provide-a-filesystem-specific-syncable-page-bit-ext4.patch
-fs-cache-generic-filesystem-caching-facility.patch
-fs-cache-release-page-private-in-failed-readahead.patch
-fs-cache-release-page-private-after-failed-readahead-12.patch
-fs-cache-make-kafs-use-fs-cache.patch
-fs-cache-make-kafs-use-fs-cache-fix.patch
-fs-cache-make-kafs-use-fs-cache-12.patch
-fs-cache-make-kafs-use-fs-cache-12-fix.patch
-fs-cache-make-kafs-use-fs-cache-kconfig-fix.patch
-fs-cache-make-kafs-use-fs-cache-vs-streamline-generic_file_-interfaces-and-filemap.patch
-nfs-use-local-caching.patch
-nfs-use-local-caching-12.patch
-nfs-use-local-caching-12-fix.patch
-nfs-use-local-caching-kconfig-fix.patch
-nfs-use-local-caching-configh.patch
-add-missing-page_copy-export-for-ppc-and-powerpc.patch
-fs-cache-cachefiles-ia64-missing-copy_page-export.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-fscache-fix-gfp_t-sparse-annotations.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-printk-format-warning.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-warning-fixes.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-cachefiles_write_page-shouldnt-indicate-error-twice.patch
-fscache-kconfig-tidying.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-log2-fix.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-handle-enospc-on-create-mkdir-better.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-inode-count-maintenance.patch
-rename-struct-namespace-to-struct-mnt_namespace-cachefiles.patch

 Dropped - these were out of date

+tty-switch-to-ktermios-and-new-framework-irda-fix.patch

 Fix tty-switch-to-ktermios-and-new-framework.patch

+tty-switch-to-ktermios-uml-fix-2.patch

 Fix tty-switch-to-ktermios.patch some more

+isdn-replace-kmallocmemset-with-kzalloc.patch

 ISDN cleanup

+nfs2-calculate-w-a-bit-later-in-nfsaclsvc_encode_getaclres.patch
+nfs3-calculate-w-a-bit-later-in-nfs3svc_encode_getaclres.patch

 NFS microoptimisations

+fault-injection-capability-for-kmalloc-failslab-remove-__gfp_highmem-filtering.patch
+fault-injection-stacktrace-filtering-reject-failure-if-any-caller-lies-within-specified-range.patch
+fault-injection-Kconfig-cleanup-config_fault_injection-help-text.patch

 Fix the fault-injection patches

+sched-domain-move-sched-group-allocations-to-percpu-area.patch
+move_task_off_dead_cpu-should-be-called-with-disabled-ints.patch
+sched-domain-increase-the-smt-busy-rebalance-interval.patch
+sched-avoid-taking-rq-lock-in-wake_priority_sleeper.patch
+sched-remove-staggering-of-load-balancing.patch
+sched-disable-interrupts-for-locking-in-load_balance.patch
+sched-extract-load-calculation-from-rebalance_tick.patch
+sched-move-idle-status-calculation-into-rebalance_tick.patch
+sched-use-softirq-for-load-balancing.patch
+sched-call-tasklet-less-frequently.patch
+sched-add-option-to-serialize-load-balancing.patch
+sched-add-option-to-serialize-load-balancing-fix.patch
+sched-improve-migration-accuracy.patch
+sched-improve-migration-accuracy-tidy.patch
+sched-decrease-number-of-load-balances.patch
+mm-only-sched-add-a-few-scheduler-event-counters.patch
+sched-optimize-activate_task-for-rt-task.patch

 CPU scheduler updates

+remove-uses-of-kmem_cache_t-from-mm-and-include-linux-slabh-prefetch.patch

 MM cleanup

+readahead-kconfig-options-fix.patch
+radixtree-introduce-scan-hole-data-functions.patch
-readahead-delay-page-release-in-do_generic_mapping_read.patch
-readahead-initial-method-expected-read-size.patch
-readahead-seeking-reads-method.patch
+readahead-call-scheme-ifdef-fix.patch
+readahead-call-scheme-build-fix.patch
+readahead-nfsd-case-fix.patch
-readahead-debug-radix-tree-new-functions.patch
-readahead-debug-traces-showing-accessed-file-names.patch
-readahead-debug-traces-showing-read-patterns.patch
-readahead-backward-prefetching-method-fix.patch
-readahead-remove-the-size-limit-of-max_sectors_kb-on-read_ahead_kb.patch
+readahead-remove-size-limit-of-max_sectors_kb-on-read_ahead_kb.patch

 Updated readahead patch series

-reiser4-export-handle_ra_miss.patch

 Unneeded

+reiser4-export-remove_from_page_cache-fix.patch

 Fix reiser4-export-remove_from_page_cache.patch

+fs-reiser4-possible-cleanups-2.patch

 reiser4 cleanups

-fbmem-is-bootup-logo-broken-for-monochrome-lcd.patch

 Dropped, buggy.

+visws-sgivwfb-is-module-needs-exports.patch
+backlight-lcd-remove-dependenct-from-the-framebuffer-layer.patch
+backlight-lcd-remove-dependenct-from-the-framebuffer-layer-tidy.patch
+softcursorc-avoid-unaligned-accesses.patch

 fbdev updates

+dm-io-fix-bi_max_vecs.patch
+dm-tidy-core-formatting.patch
+dm-suspend-parameter-change.patch
+dm-map-and-endio-return-code-clarification.patch
+dm-map-and-endio-symbolic-return-codes.patch
+dm-ioctl-add-noflush-suspend.patch
+dm-suspend-add-noflush-pushback.patch
+dm-mpath-use-noflush-suspending.patch
+dm-snapshot-abstract-memory-release.patch
+dm-log-rename-complete_resync_work.patch
+dm-raid1-reset-sync_search-on-resume.patch
+make-drivers-md-dm-snapcksnapd-static.patch

 device-mapper updates

+extend-notifier_call_chain-to-count-nr_calls-made.patch
+extend-notifier_call_chain-to-count-nr_calls-made-fixes.patch
+extend-notifier_call_chain-to-count-nr_calls-made-fixes-2.patch
+define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release.patch
+define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release-fix.patch
+eliminate-lock_cpu_hotplug-in-kernel-schedc.patch
+eliminate-lock_cpu_hotplug-in-kernel-schedc-fix.patch
+handle-cpu_lock_acquire-and-cpu_lock_release-in-workqueue_cpu_callback.patch

 cpu-hotplug locking rework.

+gtod-persistent-clock-support-core-remove-kernel-timercwall_jiffies.patch
+dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie-make-kernel-timerc__next_timer_interrupt-static.patch
+updated-i386-convert-to-clock-event-devices-remove-arch-i386-kernel-time_hpetchpet_reenable.patch

 Fiddle with the dynticks and hrtimers patches.  These still have plenty of
 problems.

+kvm-virtualization-infrastructure-fix-mmu-reset-locking-when-setting-cr0.patch
+kvm-define-exit-handlers-pass-fs-gs-segment-bases-to-x86-emulator.patch
+kvm-less-common-exit-handlers-handle-rdmsrmsr_efer.patch
+kvm-x86-emulator-fix-emulator-mov-cr-decoding.patch
+kvm-expose-interrupt-bitmap.patch
+kvm-add-time-stamp-counter-msr-and-accessors.patch
+kvm-expose-msrs-to-userspace.patch
+kvm-expose-msrs-to-userspace-v2.patch

 KVM updates

+slim-main-patch-security-slim-slm_mainc-make-2-functions-static.patch

 SLIM cleanup

+profile_likely-export-do_check_likely.patch

 Fix profile-likely-unlikely-macros.patch

+lockdep-show-held-locks-when-showing-a-stackdump.patch
+lockdep-show-held-locks-when-showing-a-stackdump-fix.patch

 lockdep feature.


All 1524 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm1/patch-list

