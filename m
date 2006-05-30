Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWE3JZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWE3JZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWE3JZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:25:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932209AbWE3JZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:25:22 -0400
Date: Tue, 30 May 2006 02:29:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc5-mm1
Message-Id: <20060530022925.8a67b613.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/


- The git-cfq tree is causing oopses and has been dropped.

- New reiser4 code drop.

- Merged the generic-IRQ handling code.

- Merged the runtime locking validator.  If you enable this your machine
  will run slowly.

- The build is broken on ia64 and probably on everything apart from x86,
  x86_64 and powerpc.  Check out the hot-fixes directory, as it won't be
  broken for long.

- Dropped the git-viro-bid-* git trees - they're getting many rejects
  against other things in -mm.

- Merged the new readahead code.

- Merged the generic statistics infrastructure patches.




Changes since 2.6.17-rc4-mm3:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit-master.patch
 git-block.patch
 git-cifs.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-infiniband.patch
 git-intelfb.patch
 git-klibc.patch
 git-hdrcleanup.patch
 git-hdrinstall.patch
 git-libata-all.patch
 git-mips.patch
 git-mtd.patch
 git-mtd-fixup.patch
 git-mtd-cs553x_nand-build-fix.patch
 git-mtd-ya-build-fix.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-powerpc.patch
 git-rbtree.patch
 git-sas.patch
 git-pcmcia.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-cryptodev.patch

 git trees

-sys_sync_file_range-move-exported-flags-outside-kernel.patch
-knfsd-fix-two-problems-that-can-cause-rmmod-nfsd-to-die.patch
-md-fix-possible-oops-when-starting-a-raid0-array.patch
-md-make-sure-bi_max_vecs-is-set-properly-in-bio_split.patch
-git-audit-master-build-fix.patch
-audit-build-fix.patch
-git-klibc-build-hacks.patch
-git-klibc-stdint-build-fix.patch
-git-klibc-stdint-build-fix-2.patch
-e1000-endian-fixes.patch
-forcedeth-suggested-cleanups.patch
-forcedeth-add-support-for-flow-control.patch
-forcedeth-add-support-for-configuration.patch
-drivers-net-s2ioc-make-bus_speed-static.patch
-qla2xxx-lock-ordering-fix.patch
-qla2xxx-lock-ordering-fix-warning-fix.patch
-orinoco-possible-null-pointer-dereference-in-orinoco_rx_monitor.patch
-x86_64-mm-i386-numa-summit-check-fix.patch
-x86-64-calgary-iommu-introduce-iommu_detected.patch
-x86-64-calgary-iommu-calgary-specific-bits.patch
-x86-64-calgary-iommu-hook-it-in.patch
-x86-64-check-for-valid-dma-data-direction-in-the-dma-api.patch
-fix-unlikely-memory-leak-in-dac960-driver.patch
-sunsu-license-fix.patch
-intelfb-use-firmware-edid-for-mode-database.patch
-intelfb-use-firmware-edid-for-mode-database-fix.patch

 Merged into mainline or a subsystem tree

+ext3-resize-fix-double-unlock_super.patch
+fbcon-fix-scrollback-with-logo-issue-immediately-after-boot.patch
+spanned_pages-is-not-updated-at-a-case-of-memory-hot-add.patch
+tpm-bios-log-parsing-fixes.patch
+tpm-more-bios-log-parsing-fixes.patch
+tpm-more-bios-log-parsing-fixes-tidy.patch
+ipmi-reserve-i-o-ports-separately.patch
+revert-swsusp-add-check-for-suspension-of-x-controlled-devices.patch
+hrtimer-export-symbols.patch
+drivers-usb-core-devioc-dereference-userspace-pointer.patch
+scsi-properly-count-the-number-of-pages-in-scsi_req_map_sg.patch
+x86_64-fix-stack-mmap-randomization-for-compat.patch
+x86_64-fix-no-iommu-warning-in-pci-gart-driver.patch
+i386-apic=-command-line-option-should-always-be.patch
+x86_64-fix-last_tsc-calculation-of-pm-timer.patch
+x86_64-handle-empty-node-zero.patch
+x86_64-fix-off-by-one-in-bad_addr-checking-in.patch
+x86_64-dont-do-syscall-exit-tracing-twice.patch
+powerpc-fix-boot-on-emac.patch
+au1100fb-fix-compilation.patch
+maxinefb-fix-compilation-error.patch
+sgiioc4-use-mmio-ops-instead-of-port-io.patch
+md-fix-badness-in-sysfs_notify-caused-by-md_new_event.patch

 2.6.17 queue

+acpi-atlas-acpi-driver.patch
+acpi-atlas-acpi-driver-v2-tidy.patch
+remove-acpi_os_create_lock-acpi_os_delete_lock.patch

 ACPI updates

+firmware_class-s-semaphores-mutexes.patch

 mutex conversion.

+trivial-videodev2h-patch.patch

 cleanup

+fix-broken-suspend-resume-in-ohci1394-was-acpi-suspend.patch
+ieee1394_core-switch-to-kthread-api.patch
+ieee1394_core-switch-to-kthread-api-fix.patch

 ieee1394 updates

-input-move-fixp-arithh-to-drivers-input.patch
-input-fix-accuracy-of-fixp-arithh.patch
-input-new-force-feedback-interface.patch
-input-adapt-hid-force-feedback-drivers-for-the-new-interface.patch
-input-adapt-uinput-for-the-new-force-feedback-interface.patch
-input-adapt-iforce-driver-for-the-new-force-feedback-interface.patch
-input-force-feedback-driver-for-pid-devices.patch
-input-force-feedback-driver-for-zeroplus-devices.patch
-input-update-documentation-of-force-feedback.patch
-input-drop-the-remains-of-the-old-ff-interface.patch
-input-drop-the-old-pid-driver.patch

 Dropped - these are being redone.

+input-powermac-cleanup-of-mac_hid-and-support-for-ctrlclick-and-commandclick-update.patch

 Fix input-powermac-cleanup-of-mac_hid-and-support-for-ctrlclick-and-commandclick.patch

+mm-constify-drivers-char-keyboardc.patch
+input-logitech-trackman-trackball-support.patch

 Input driver updates

+git-mtd-cs553x_nand-build-fix.patch
+git-mtd-ya-build-fix.patch

 Fix git-mtd.patch

+git-netdev-all-fixup.patch

 Fix reject due to git-netdev-all.patch

+git-net-git-klibc-fixup.patch

 Fix reject.

+eliminate-unused-proc-sys-net-ethernet.patch

 Kill empty /proc directory.

+irda-missing-allocation-result-check-in-irlap_change_speed.patch

 IRDA fix

+nfs-really-return-status-from-decode_recall_args.patch

 NFS fixlet.

+64-bit-resources-arch-powerpc-changes-update.patch

 ppc build fix

+allow-msi-to-work-on-kexec-kernel.patch
+pci-disable-msi-mode-in-pci_disable_device.patch

 PCI fixes

+pcmcia-missing-pcmcia_get_socket-result-check.patch

 pcmcia fixlet.

+qla1280-fix-section-mismatch-warnings.patch
+bogus-disk-geometry-on-large-disks.patch
+bogus-disk-geometry-on-large-disks-warning-fix.patch
+megaraid_sas-switch-fw_outstanding-to-an-atomic_t.patch
+megaraid_sas-add-support-for-zcr-controller.patch
+megaraid_sas-add-support-for-zcr-controller-fix.patch

 SCSI driver updates

+usb-gadget-update-inodec-to-support-full-speed-only.patch
+usb-gadget-update-pxa2xx_udcc-and-arch-dependent-files.patch
+usb-gadget-update-pxa2xx_udcc-driver-to-fully-support.patch
+usb-gadget-clean-udch.patch
+usb-gadget-dont-build-small-version-if-usbgadgetfs.patch
+driver-for-apple-cinema-display.patch
+driver-for-apple-cinema-display-tweaks.patch
+usb-wifi-zd1201-cleanups.patch

 USB updates

-x86_64-mm-iommu-warning.patch
-x86_64-mm-i386-apic-overwrite.patch
-x86_64-mm-profile-pc-fp.patch
-x86_64-mm-fix-last_tsc-calculation-of-pm-timer.patch
-x86_64-mm-empty-node0.patch
-x86_64-mm-disable-apic-initdata.patch
+x86_64-mm-iommu-clarification.patch
+x86_64-mm-reliable-stack-trace-support.patch
+x86_64-mm-reliable-stack-trace-support-x86-64.patch
+x86_64-mm-reliable-stack-trace-support-x86-64-irq-stack.patch
+x86_64-mm-reliable-stack-trace-support-x86-64-syscall.patch
+x86_64-mm-reliable-stack-trace-support-i386.patch
+x86_64-mm-reliable-stack-trace-support-i386-entrys.patch
+x86_64-mm-consoldidate-boot-compressed.patch
+x86_64-mm-remove-pud_offset_k.patch
+x86_64-mm-use-halt-instead-of-raw-inline-assembly.patch
+x86_64-mm-change-assembly-to-use-regular-cpuid_count-macro.patch
+x86_64-mm-iommu-detected.patch
+x86_64-mm-valid-dma-direction.patch
+x86_64-mm-iommu-abstraction.patch
+x86_64-mm-calgary-iommu.patch
+x86_64-mm-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86.patch
+x86_64-mm-add-nmi-watchdog-support-for-new-intel-cpus.patch
+x86_64-mm-rdtscp-macros.patch
+x86_64-mm-time-constants.patch
+x86_64-mm-rename-force-hpet.patch
+x86_64-mm-rdtscp-feature.patch
+x86_64-mm-remove-hpet-hack.patch
+x86_64-mm-use-time-constants.patch
+x86_64-mm-init-rdtscp.patch
+x86_64-mm-explain-double-hpet-init.patch
+x86_64-mm-update-copyright.patch
+x86_64-mm-getcpu-vsyscall.patch
+x86_64-mm-time-init-gtod-prototype.patch
+x86_64-mm-x86-clean-up-nmi-panic-messages.patch

 x86_64 tree updates

-revert-x86_64-mm-profile-pc-fp.patch

 Dropped.

+fix-x86_64-mm-reliable-stack-trace-support-i386-entrys.patch
+x86_64-mm-reliable-stack-trace-support-non-x86-fix.patch
+x86_64-mm-reliable-stack-trace-support-non-x86-fix-fix.patch
+x86_64-mm-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86-warning-fix.patch

 Fix x86_64 tree.

+lock-validator-lockdep-small-xfs-init_rwsem-cleanup.patch

 XFS cleanup.

-zone-init-check-and-report-unaligned-zone-boundaries-fix-v2.patch

 Folded into zone-init-check-and-report-unaligned-zone-boundaries.patch

-zone-allow-unaligned-zone-boundaries-spelling-fix.patch

 Folded into zone-allow-unaligned-zone-boundaries.patch

+zone-allow-unaligned-zone-boundaries-x86-add-zone-alignment-qualifier.patch

 Implement it on x86.

-unify-pxm_to_node-and-node_to_pxm-update.patch

 Folded into unify-pxm_to_node-and-node_to_pxm.patch

-pgdat-allocation-for-new-node-add-specify-node-id-powerpc-fix.patch
-pgdat-allocation-for-new-node-add-specify-node-id-tidy.patch
-pgdat-allocation-for-new-node-add-specify-node-id-fix-3.patch
-pgdat-allocation-for-new-node-add-specify-node-id-build-fixes.patch
-pgdat-allocation-for-new-node-add-specify-node-id-tidy-cleanup.patch

 Folded into pgdat-allocation-for-new-node-add-specify-node-id.patch

-pgdat-allocation-for-new-node-add-get-node-id-by-acpi-tidy.patch

 Folded into pgdat-allocation-for-new-node-add-get-node-id-by-acpi.patch

-pgdat-allocation-for-new-node-add-generic-alloc-node_data-tidy.patch

 Folded into pgdat-allocation-for-new-node-add-generic-alloc-node_data.patch

-pgdat-allocation-for-new-node-add-refresh-node_data-fix.patch

 Folded into pgdat-allocation-for-new-node-add-refresh-node_data.patch

-pgdat-allocation-for-new-node-add-export-kswapd-start-func-tidy.patch

 Folded into pgdat-allocation-for-new-node-add-export-kswapd-start-func.patch

-catch-valid-mem-range-at-onlining-memory-tidy.patch
-catch-valid-mem-range-at-onlining-memory-fix.patch

 Folded into catch-valid-mem-range-at-onlining-memory.patch

-register-sysfs-file-for-hotpluged-new-node-fix.patch

 Folded into register-sysfs-file-for-hotpluged-new-node.patch

-mm-introduce-remap_vmalloc_range-tidy.patch
-mm-introduce-remap_vmalloc_range-fix.patch

 Folded into mm-introduce-remap_vmalloc_range.patch

-change-gen_pool-allocator-to-not-touch-managed-memory-update.patch
-change-gen_pool-allocator-to-not-touch-managed-memory-update-2.patch

 Folded into change-gen_pool-allocator-to-not-touch-managed-memory.patch

-page-migration-cleanup-extract-try_to_unmap-from-migration-functions-update-comments-7.patch

 Folded into page-migration-cleanup-extract-try_to_unmap-from-migration-functions.patch

-page-migration-cleanup-move-fallback-handling-into-special-function-update-comments-9.patch

 Folded into page-migration-cleanup-move-fallback-handling-into-special-function.patch

-swapless-pm-add-r-w-migration-entries-fix.patch
-swapless-pm-add-r-w-migration-entries-ifdefs.patch
-swapless-pm-add-r-w-migration-entries-update-comments.patch
-swapless-pm-add-r-w-migration-entries-update-comments-4.patch
-swapless-pm-add-r-w-migration-entries-update-comments-6.patch

 Folded into swapless-pm-add-r-w-migration-entries.patch

+swapless-pm-add-r-w-migration-entries-fix-2.patch

 Fix it again.

-swapless-page-migration-modify-core-logic-remove-useless-mapping-checks.patch

 Folded into swapless-page-migration-modify-core-logic.patch

-more-page-migration-use-migration-entries-for-file-pages-fix.patch
-more-page-migration-use-migration-entries-for-file-pages-update-comments-5.patch
-more-page-migration-use-migration-entries-for-file-pages-update-comments-8.patch
-more-page-migration-use-migration-entries-for-file-pages-remove_migration_ptes.patch
-more-page-migration-use-migration-entries-for-file-pages-replace-call-to-pageout-with-writepage-2.patch

 Folded into more-page-migration-use-migration-entries-for-file-pages.patch

-tracking-dirty-pages-in-shared-mappings-v4.patch
-tracking-dirty-pages-in-shared-mappings-v4-fix2.patch
-tracking-dirty-pages-in-shared-mappings-v4-fix3.patch
-throttle-writers-of-shared-mappings.patch
-throttle-writers-of-shared-mappings-tidy.patch
-optimize-follow_pages.patch

 Dropped, being redone.

+node-hotplug-register-cpu-remove-node-struct.patch
+node-hotplug-fixes-callres-of-register_cpu.patch
+node-hotplug-fixes-callres-of-register_cpu-powerpc-warning-fix.patch
+node-hotplug-register_node-fix.patch

 NUMA node hotplugging updates

+add-page_mkwrite-vm_operations-method.patch
+mm-remove-vm_locked-before-remap_pfn_range-and-drop-vm_shm.patch
+swapoff-atomic_inc_not_zero-on-mm_users.patch
+remove-unused-o_flags-from-do_shmat.patch
+fix-update_mmu_cache-in-fremapc.patch
+fix-update_mmu_cache-in-fremapc-fix.patch

 Memory management updates

+page-migration-support-moving-of-individual-pages-fixes.patch
+page-migration-support-moving-of-individual-pages-x86_64-support.patch
+page-migration-support-moving-of-individual-pages-x86-support.patch
+page-migration-support-moving-of-individual-pages-x86-support-fix.patch
+allow-migration-of-mlocked-pages.patch

 Page migration updates

+au1550-1200-add-missing-psc-defines-make-oss-driver-use.patch

 MIPS fix

+x86-re-enable-generic-numa.patch
+x86-make-using_apic_timer-__read_mostly.patch
+x86-cyrix-code-config_pci-fix--add-__initdata.patch
+x86-constify-some-parts-of-arch-i386-kernel-cpu.patch
+x86-make-i387-mxcsr_feature_mask-__read_mostly.patch
+x86-make-acpi-errata-__read_mostly.patch
+x86-constify-arch-i386-pci-irqc.patch
+x86-use-proper-defines-for-i8259a-i-o.patch
+i386-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86.patch
+i386-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86-warning-fix.patch
+i386-fix-get_segment_eip-with-vm86.patch

 x86 updates

-x86-move-vsyscall-page-out-of-fixmap-above-stack.patch
-x86-move-vsyscall-page-out-of-fixmap-above-stack-tidy.patch
+vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma.patch
+vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-tidy.patch
+vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-arch_vma_name-fix.patch
+vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386.patch
+vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386-2.patch

 Updated x86 VDSO randomisation patches

-swsusp-add-architecture-special-saveable-pages-fix.patch

 Folded into swsusp-add-architecture-special-saveable-pages-support.patch

-swsusp-i386-mark-special-saveable-unsaveable-pages-fix.patch

 Folded into swsusp-i386-mark-special-saveable-unsaveable-pages.patch

-swsusp-x86_64-mark-special-saveable-unsaveable-pages-fix.patch

 Folded into swsusp-x86_64-mark-special-saveable-unsaveable-pages.patch

-dont-use-flush_tlb_all-in-suspend-time-tidy.patch

 Folded into dont-use-flush_tlb_all-in-suspend-time.patch

-swsusp-fix-typo-in-cr0-handling.patch

 Folded into swsusp-documentation-updates.patch

+m68k-completely-initialize-hw_regs_t-in-ide_setup_ports.patch
+m68k-atyfb_base-compile-fix-for-config_pci=n.patch
+m68k-cleanup-unistdh.patch
+m68k-remove-some-unused-definitions-in-zorroh.patch
+m68k-use-c99-initializer.patch
+m68k-print-correct-stack-trace.patch
+m68k-restore-amikbd-compatibility-with-24.patch
+m68k-extra-delay.patch
+m68k-use-proper-defines-for-zone-initialization.patch
+m68k-adjust-to-changed-hardirq_mask.patch
+m68k-m68k-mac-via2-fixes-and-cleanups.patch

 m68k updates

+xtensa-remove-verify_area-macros.patch
+xtensa-remove-verify_area-macros-fix.patch

 Xtensa updates

-s390-statistics-infrastructure.patch

 Dropped.

-per-cpufy-net-proto-structures-add-percpu_counter_modbh.patch
-percpu-counters-add-percpu_counter_exceeds.patch
-per-cpufy-net-proto-structures-protomemory_allocated.patch
-per-cpufy-net-proto-structures-sockets_allocated.patch
-per-cpufy-net-proto-structures-protoinuse.patch

 Dropped.

-percpu-counter-data-type-changes-to-suppport-fix.patch
-percpu-counter-data-type-changes-to-suppport-fix-fix.patch
-percpu-counter-data-type-changes-to-suppport-fix-fix-fix.patch

 Folded into percpu-counter-data-type-changes-to-suppport.patch

-jbd-split-checkpoint-lists-tidy.patch

 Folded into jbd-split-checkpoint-lists.patch

-mark-address_space_operations-const-fix.patch
-mark-address_space_operations-const-fix-2.patch

 Folded into mark-address_space_operations-const.patch

-hptiop-highpoint-rocketraid-3xxx-controller-driver-list-locking.patch
-hptiop-highpoint-rocketraid-3xxx-controller-driver-list-locking-updates.patch
-hptiop-highpoint-rocketraid-3xxx-controller-driver-list-locking-updates-updates-2.patch
-hptiop-highpoint-rocketraid-3xxx-controller-driver-redone.patch

 Folded into hptiop-highpoint-rocketraid-3xxx-controller-driver.patch

-ufs-right-block-allocation-fixes.patch

 Folded into ufs-right-block-allocation.patch

-ufs-change-block-number-on-the-fly-tweaks.patch

 Folded into ufs-change-block-number-on-the-fly.patch

+ufs-wrong-type-cast.patch
+ufs-not-usual-amounts-of-fragments-per-block.patch
+ufs-unmark-config_ufs_fs_write-as-broken-mm-tree.patch

 More UFS fixes.

-add-driver-for-arm-amba-pl031-rtc-tidy.patch

 Folded into add-driver-for-arm-amba-pl031-rtc.patch

-add-a-sysfs-file-to-determine-if-a-kexec-kernel-is-loaded-tidy.patch

 Folded into add-a-sysfs-file-to-determine-if-a-kexec-kernel-is-loaded.patch

+avoid-disk-sector_t-overflow-for-2tb-ext3-filesystem.patch
+cleanup-dead-code-from-ext2-mount-code.patch
+fix-memory-leak-when-the-ext3s-journal-file-is-corrupted.patch
+remove-inconsistent-space-before-exclamation-point-in-ext3s-mount-code.patch
+moxa-remove-pointless-casts.patch
+moxa-remove-pointless-check-of-tty-argument-vs-null.patch
+moxa-partial-codingstyle-cleanup-spelling-fixes.patch
+updated-kdump-documentation.patch
+cpuset-remove-extra-cpuset_zone_allowed-check-in-__alloc_pages.patch
+spin-rwlock-init-cleanups.patch
+make-debug_mutex_on-__read_mostly.patch
+constify-parts-of-kernel-power.patch
+constify-libcrc32c-table.patch
+apple-motion-sensor-driver.patch
+prepare-for-__copy_from_user_inatomic-to-not-zero-missed-bytes.patch
+make-copy_from_user_inatomic-not-zero-the-tail-on-i386.patch
+remove-unecessary-null-check-in-kernel-acctc.patch
+ax88796-parallel-port-driver.patch
+ax88796-parallel-port-driver-build-fix.patch
+wd7000-fix-section-mismatch-warnings.patch
+megaraid_mbox-fix-section-mismatch-warnings.patch
+keys-fix-race-between-two-instantiators-of-a-key.patch
+keys-fix-race-between-two-instantiators-of-a-key-tidy.patch
+ext3_fsblk_t-filesystem-group-blocks-and-bug-fixes.patch
+ext3_fsblk_t-the-rest-of-in-kernel-filesystem-blocks.patch
+inotify-kernel-api.patch
+inotify-kernel-api-fix.patch
+kernel-doc-mm-readhead-fixup.patch
+make-procfs-obligatory-except-under-config_embedded.patch
+lock-validator-introduce-warn_on_oncecond.patch
+make-sysctl-obligatory-except-under-config_embedded.patch
+lock-validator-sound-oss-emu10k1-midic-cleanup.patch
+for_each_cpu_mask-warning-fix.patch

 Misc.

-use-list_add_tail-instead-of-list_add-fix.patch

 Folded into use-list_add_tail-instead-of-list_add.patch

+add-new-generic-hw-rng-core-hw_random-core-rewrite-chrdev-read-method-hw_random-core-block-read-if-o_nonblock.patch

 Hardware random number genarator update.

+time-fix-time-going-backward-w-clock=pit.patch

 x86 time handling fix

 pi-futex-futex-code-cleanups.patch
-pi-futex-futex-code-cleanups-fix.patch
+pi-futex-robust-futex-docs-fix.patch
 pi-futex-introduce-debug_check_no_locks_freed.patch
+pi-futex-introduce-warn_on_smp.patch
 pi-futex-add-plist-implementation.patch
 pi-futex-scheduler-support-for-pi.patch
 pi-futex-rt-mutex-core.patch
-pi-futex-rt-mutex-core-fix-timeout-race.patch
 pi-futex-rt-mutex-docs.patch
+pi-futex-rt-mutex-docs-update.patch
 pi-futex-rt-mutex-debug.patch
 pi-futex-rt-mutex-tester.patch
 pi-futex-rt-mutex-futex-api.patch
 pi-futex-futex_lock_pi-futex_unlock_pi-support.patch
-pi-futex-v2.patch
-pi-futex-v3.patch
-pi-futex-patchset-v4.patch
-pi-futex-patchset-v4-update.patch
-pi-futex-patchset-v4-fix.patch
-rtmutex-remove-buggy-bug_on-in-pi-boosting-code.patch
-futex-pi-enforce-waiter-bit-when-owner-died-is-detected.patch
-rtmutex-debug-printk-correct-task-information.patch
-futex-pi-make-use-of-restart_block-when-interrupted.patch
-document-futex-pi-design.patch
-document-futex-pi-design-fix.patch
-document-futex-pi-design-fix-fix.patch

 Updated pi-futex patch series

+ecryptfs-fs-makefile-and-fs-kconfig-remove-ecrypt_debug-from-fs-kconfig.patch
+ecryptfs-main-module-functions-uint16_t-u16.patch
+ecryptfs-header-declarations-update.patch
+ecryptfs-header-declarations-update-convert-signed-data-types-to-unsigned-data-types.patch
+ecryptfs-header-declarations-remove-unnecessary-ifndefs.patch
+ecryptfs-file-operations-remove-null-==-syntax.patch
+ecryptfs-file-operations-remove-extraneous-read-of-inode-size-from-header.patch
+ecryptfs-convert-assert-to-bug_on.patch
+ecryptfs-remove-unnecessary-null-checks.patch
+ecryptfs-rewrite-ecryptfs_fsync.patch
+ecryptfs-overhaul-file-locking.patch

 ecryptfs updates

+proc-sysctl-add-_proc_do_string-helper.patch

 /proc helper fucntion.

+namespaces-utsname-switch-to-using-uts-namespaces-cleanup.patch

 Folded into namespaces-utsname-switch-to-using-uts-namespaces-alpha-fix.patch

+namespaces-utsname-sysctl-hack-cleanup.patch
+namespaces-utsname-sysctl-hack-cleanup-2.patch

 Folded into namespaces-utsname-sysctl-hack.patch

+uts-copy-nsproxy-only-when-needed.patch

 utsname virtualisation update

+readahead-kconfig-options.patch
+radixtree-introduce-radix_tree_scan_hole.patch
+mm-introduce-probe_page.patch
+mm-introduce-pg_readahead.patch
+readahead-add-look-ahead-support-to-__do_page_cache_readahead.patch
+readahead-delay-page-release-in-do_generic_mapping_read.patch
+readahead-insert-cond_resched-calls.patch
+readahead-minmax_ra_pages.patch
+readahead-events-accounting.patch
+readahead-rescue_pages.patch
+readahead-sysctl-parameters.patch
+readahead-sysctl-parameters-fix.patch
+readahead-min-max-sizes.patch
+readahead-state-based-method-aging-accounting.patch
+readahead-state-based-method-routines.patch
+readahead-state-based-method.patch
+readahead-context-based-method.patch
+readahead-initial-method-guiding-sizes.patch
+readahead-initial-method-thrashing-guard-size.patch
+readahead-initial-method-expected-read-size.patch
+readahead-initial-method-user-recommended-size.patch
+readahead-initial-method.patch
+readahead-backward-prefetching-method.patch
+readahead-seeking-reads-method.patch
+readahead-thrashing-recovery-method.patch
+readahead-call-scheme.patch
+readahead-laptop-mode.patch
+readahead-loop-case.patch
+readahead-nfsd-case.patch
+readahead-turn-on-by-default.patch
+readahead-debug-radix-tree-new-functions.patch
+readahead-debug-traces-showing-accessed-file-names.patch
+readahead-debug-traces-showing-read-patterns.patch

 readahead rework

+make-copy_from_user_inatomic-not-zero-the-tail-on-i386-vs-reiser4.patch
-reiser4-fix-incorrect-assertions.patch
-reiser4-add-missing-txn_restart-before-get_nonexclusive_access-calls.patch
-reiser4-check-radix-tree-emptiness-properly.patch
-reiser4-check-radix-tree-emptiness-properly-2.patch
-fs-reiser4-misc-cleanups.patch
-reiser4-releasepage-fix.patch
-reiser4fs-use-list_move.patch
-make-address_space_operations-invalidatepage-return-void-reiser4.patch
-reiser4-have-get_exclusive_access-restart-transaction.patch
-reiser4-writeback-fix-range-handling.patch
-reiser4-gfp_t-annotations.patch
+reiser4-run-truncate_inode_pages-in-reiser4_delete_inode.patch

 Reiser4 updates

+hpt3xx-switch-to-using-pci_get_slot.patch
+hpt3xx-cache-channels-mcr-address.patch

 IDE updates

+fbdev-remove-unused-exports.patch
+s3c2410fb-fix-resume.patch
+backlight-fix-kconfig-dependency.patch
+au1100fb-add-power-management-support.patch
+au1100fb-add-power-management-support-tidy.patch

 fbdev updates

+dm-snapshot-unify-chunk_size.patch
+lib-add-idr_replace.patch
+lib-add-idr_replace-tidy.patch
+dm-fix-idr-minor-allocation.patch
+dm-move-idr_pre_get.patch
+dm-change-minor_lock-to-spinlock.patch
+dm-add-dmf_freeing.patch
+dm-fix-mapped-device-ref-counting.patch
+dm-add-module-ref-counting.patch
+dm-fix-block-device-initialisation.patch
+dm-mirror-sector-offset-fix.patch

 Device mapper updates

+statistics-infrastructure-prerequisite-list.patch
+statistics-infrastructure-prerequisite-parser.patch
+statistics-infrastructure-prerequisite-timestamp.patch
+statistics-infrastructure-documentation.patch
+statistics-infrastructure.patch
+statistics-infrastructure-update-1.patch
+statistics-infrastructure-exploitation-zfcp.patch

 Generic statistics infrastructure, use it on an s390 driver.

+genirq-rename-desc-handler-to-desc-chip-ia64-fix-2.patch

 Fix genirq-rename-desc-handler-to-desc-chip.patch some more.

+genirq-sem2mutex-probe_sem-probing_active.patch
+genirq-cleanup-merge-irq_affinity-into-irq_desc.patch
+genirq-cleanup-remove-irq_descp.patch
+genirq-cleanup-remove-fastcall.patch
+genirq-cleanup-misc-code-cleanups.patch
+genirq-cleanup-reduce-irq_desc_t-use-mark-it-obsolete.patch
+genirq-cleanup-include-linux-irqh.patch
+genirq-cleanup-merge-irq_dir-smp_affinity_entry-into-irq_desc.patch
+genirq-cleanup-merge-pending_irq_cpumask-into-irq_desc.patch
+genirq-cleanup-turn-arch_has_irq_per_cpu-into-config_irq_per_cpu.patch
+genirq-debug-better-debug-printout-in-enable_irq.patch
+genirq-add-retrigger-irq-op-to-consolidate-hw_irq_resend.patch
+genirq-doc-comment-include-linux-irqh-structures.patch
+genirq-doc-handle_irq_event-and-__do_irq-comments.patch
+genirq-cleanup-no_irq_type-cleanups.patch
+genirq-doc-add-design-documentation.patch
+genirq-add-genirq-sw-irq-retrigger.patch
+genirq-add-irq_noprobe-support.patch
+genirq-add-irq_norequest-support.patch
+genirq-add-irq_noautoen-support.patch
+genirq-update-copyrights.patch
+genirq-core.patch
+genirq-add-irq-chip-support.patch
+genirq-add-handle_bad_irq.patch
+genirq-add-irq-wake-power-management-support.patch
+genirq-add-sa_trigger-support.patch
+genirq-cleanup-no_irq_type-no_irq_chip-rename.patch
+genirq-convert-the-x86_64-architecture-to-irq-chips.patch
+genirq-convert-the-i386-architecture-to-irq-chips.patch
+genirq-convert-the-i386-architecture-to-irq-chips-fix-2.patch
+genirq-more-verbose-debugging-on-unexpected-irq-vectors.patch

 Generic IRQ habdling layer

+lock-validator-floppyc-irq-release-fix.patch
+lock-validator-forcedethc-fix.patch
+lock-validator-mutex-section-binutils-workaround.patch
+lock-validator-add-__module_address-method.patch
+lock-validator-better-lock-debugging.patch
+lock-validator-locking-api-self-tests.patch
+lock-validator-locking-init-debugging-improvement.patch
+lock-validator-beautify-x86_64-stacktraces.patch
+lock-validator-beautify-x86_64-stacktraces-fix.patch
+lock-validator-x86_64-document-stack-frame-internals.patch
+lock-validator-stacktrace.patch
+lock-validator-stacktrace-build-fix.patch
+lock-validator-stacktrace-warning-fix.patch
+lock-validator-fown-locking-workaround.patch
+lock-validator-sk_callback_lock-workaround.patch
+lock-validator-irqtrace-core.patch
+lock-validator-irqtrace-core-powerpc-fix-1.patch
+lock-validator-irqtrace-core-non-x86-fix.patch
+lock-validator-irqtrace-core-non-x86-fix-2.patch
+lock-validator-irqtrace-core-non-x86-fix-3.patch
+lock-validator-irqtrace-cleanup-include-asm-i386-irqflagsh.patch
+lock-validator-irqtrace-cleanup-include-asm-x86_64-irqflagsh.patch
+lock-validator-lockdep-add-local_irq_enable_in_hardirq-api.patch
+lock-validator-add-per_cpu_offset.patch
+lock-validator-add-per_cpu_offset-fix.patch
+lock-validator-core.patch
+lock-validator-procfs.patch
+lock-validator-core-multichar-fix.patch
+lock-validator-core-count_matching_names-fix.patch
+lock-validator-design-docs.patch
+lock-validator-prove-rwsem-locking-correctness.patch
+lock-validator-prove-rwsem-locking-correctness-fix.patch
+lock-validator-prove-rwsem-locking-correctness-powerpc-fix.patch
+lock-validator-prove-spinlock-rwlock-locking-correctness.patch
+lock-validator-prove-mutex-locking-correctness.patch
+lock-validator-print-all-lock-types-on-sysrq-d.patch
+lock-validator-x86_64-early-init.patch
+lock-validator-smp-alternatives-workaround.patch
+lock-validator-do-not-recurse-in-printk.patch
+lock-validator-disable-nmi-watchdog-if-config_lockdep.patch
+lock-validator-special-locking-bdev.patch
+lock-validator-special-locking-direct-io.patch
+lock-validator-special-locking-serial.patch
+lock-validator-special-locking-serial-fix.patch
+lock-validator-special-locking-dcache.patch
+lock-validator-special-locking-i_mutex.patch
+lock-validator-special-locking-s_lock.patch
+lock-validator-special-locking-futex.patch
+lock-validator-special-locking-genirq.patch
+lock-validator-special-locking-completions.patch
+lock-validator-special-locking-waitqueues.patch
+lock-validator-special-locking-mm.patch
+lock-validator-special-locking-slab.patch
+lock-validator-special-locking-skb_queue_head_init.patch
+lock-validator-special-locking-timerc.patch
+lock-validator-special-locking-schedc.patch
+lock-validator-special-locking-hrtimerc.patch
+lock-validator-special-locking-sock_lock_init.patch
+lock-validator-special-locking-af_unix.patch
+lock-validator-special-locking-bh_lock_sock.patch
+lock-validator-special-locking-mmap_sem.patch
+lock-validator-special-locking-sb-s_umount.patch
+lock-validator-special-locking-sb-s_umount-fix.patch
+lock-validator-special-locking-sb-s_umount-2.patch
+lock-validator-special-locking-jbd.patch
+lock-validator-special-locking-posix-timers.patch
+lock-validator-special-locking-sch_genericc.patch
+lock-validator-special-locking-xfrm.patch
+lock-validator-special-locking-sound-core-seq-seq_portsc.patch
+lock-validator-enable-lock-validator-in-kconfig.patch
+lock-validator-enable-lock-validator-in-kconfig-x86-only.patch
+lock-validator-enable-lock-validator-in-kconfig-not-yet.patch
+lockdep-one-stacktrace-column-if-config_lockdep=y.patch
+lockdep-further-improve-stacktrace-output.patch
+lock-validator-special-locking-kgdb.patch

 Runtime locking validation.

-add-print_fatal_signals-support.patch
+vdso-print-fatal-signals.patch
+vdso-improve-print_fatal_signals-support-by-adding-memory-maps.patch

 Updated



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/patch-list

