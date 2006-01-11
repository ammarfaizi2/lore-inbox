Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWAKMV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWAKMV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWAKMV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:21:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751415AbWAKMVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:21:54 -0500
Date: Wed, 11 Jan 2006 04:21:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-mm3
Message-Id: <20060111042135.24faf878.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/

- New config options (VMSPLIT_*) to permit non-standard user/kernel
  splitting on x86.  Needs testing please.

- Lots of updates to the USB, PCI, driver and I2C trees.  This is usually a
  worry.

- Multiblock allocation speedup for ext3.  This is only used by direct-IO at
  present.

- Reminder: -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

  echo "subscribe mm-commits" | mail marordomo@vger.kernel.org

- If you hit a bug in -mm and it's not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

	http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.



Changes since 2.6.15-mm2:

 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-audit.patch
 git-blktrace.patch
 git-blkdev-fixup.patch
 git-cfq.patch
 git-cifs.patch
 git-drm.patch
 git-infiniband.patch
 git-netdev-all.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-misc-fixup.patch
 git-sas-jg.patch
 git-watchdog.patch
 git-xfs.patch

-revert-mm-page_state-fixes.patch
-asm-generic-atomich-needs-typesh.patch
-small-hp_sdc_rtc-cleanup-use-no_llseek.patch
-md-support-check-without-repair-of-raid10-arrays.patch
-git-acpi-memhotplug-build-fix.patch
-git-acpi-warning-fix.patch
-acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549.patch
-acpi-kernel-doc-fixes-for-scanc.patch
-pnpacpi-only-parse-device-that-have-crs-method.patch
-pnpacpi-clean-blacklist.patch
-acpi-remove-kconfig-acpi-laptop-default-settings.patch
-pnpacpi-handle-address-descriptors-in-_prs-2.patch
-fix-sys-class-net-if-wireless-without-dev-get_wireless_stats.patch
-fix-sys-class-net-if-wireless-without-dev-get_wireless_stats-fix.patch
-gregkh-pci-x86-pci-domain-support-the-meat.patch
-gregkh-pci-pci-store-pci_interrupt_pin-in-pci_dev.patch
-gregkh-pci-apci-use-pin-stored-in-pci_dev.patch
-gregkh-pci-pci-use-pin-stored-in-pci_dev.patch
-gregkh-pci-pci-call-pci_read_irq-for-bridges.patch
-gregkh-pci-pci-pci_find_device-remove-sys_sio.patch
-gregkh-pci-pci-pci_find_device-remove-sys_alcor.patch
-gregkh-pci-pci-pci_find_device-remove-pci-ppc.patch
-gregkh-pci-pci-pci_find_device-remove-pci-mpc85xx_cds_common.patch
-gregkh-pci-pci-pci_find_device-remove-pci-frv.patch
-gregkh-pci-pci-pci_find_device-remove-pci-ebus.patch
-gregkh-pci-pci-arch-pci_find_device-remove-frv.patch
-gregkh-pci-pci-arch-i386-pci-acpi.c-use-for_each_pci_dev.patch
-gregkh-pci-pcie-make-bus_id-for-pci-express-devices-unique.patch
-gregkh-pci-pci-hotplug-ibmphp_pci.c-copy-n-paste-fix.patch
-gregkh-pci-pci-hotplug-cpqphp_ctrl.c-remove-dead-code.patch
-gregkh-pci-shpchp-replace-pci_find_slot-with-pci_get_slot.patch
-gregkh-pci-shpchp-fix-improper-reference-to-slot-avail-regsister.patch
-gregkh-pci-shpchp-fix-improper-reference-to-mode-1-ecc-capability-bit.patch
-gregkh-pci-shpchp-fix-improper-mmio-mapping.patch
-gregkh-pci-shpchp-fix-improper-write-to-command-completion-detect-bit.patch
-gregkh-pci-shpchp-fix-improper-wait-for-command-completion.patch
-gregkh-pci-pci-irq.c-trivial-printk-and-dbg-updates.patch
-gregkh-pci-pci-error-recovery-documentation.patch
-gregkh-pci-pci-hotplug-powerpc-remove-duplicated-code.patch
-gregkh-pci-pci-hotplug-powerpc-more-removal-of-duplicated-code.patch
-gregkh-pci-arch-replace-pci_module_init-with-pci_register_driver.patch
-gregkh-pci-drivers-block-replace-pci_module_init-with-pci_register_driver.patch
-gregkh-pci-drivers-rest-replace-pci_module_init-with-pci_register_driver.patch
-gregkh-pci-drivers-sound-oss-replace-pci_module_init-with-pci_register_driver.patch
-gregkh-pci-shpchp-implement-get_address-callback.patch
-gregkh-pci-pci-quirk-1k-i-o-space-granularity-on-intel-p64h2.patch
-gregkh-pci-pciehp-handle-sticky-power-fault-status.patch
-gregkh-pci-pciehp-allow-bridged-card-hotplug.patch
-gregkh-pci-pci-use-bus-numbers-sparsely-if-necessary.patch
-gregkh-pci-pci-document-sysfs-rom-file-interface.patch
-gregkh-pci-reduce-nr-of-ptr-derefs-in-drivers-pci-hotplug-cpqphp_core.c.patch
-gregkh-pci-reduce-nr-of-ptr-derefs-in-drivers-pci-hotplug-rpaphp_pci.c.patch
-gregkh-pci-reduce-nr-of-ptr-derefs-in-drivers-pci-hotplug-pciehprm_acpi.c.patch
-gregkh-pci-reduce-nr-of-ptr-derefs-in-drivers-pci-hotplug-pciehp_core.c.patch
-gregkh-pci-cpqphp-sysfs-fixup.patch
-gregkh-pci-acpiphp-only-size-new-bus.patch
-gregkh-pci-pci-drivers-pci-some-cleanups.patch
-gregkh-pci-pci-update-toshiba-ohci-quirk-dmi-table.patch
-pci-restore-2-missing-pci-ids.patch
-au1xx0-replace-casual-readl-with-au_readl-in-the-drivers.patch
-arm-netwinder-watchdog-wdt977-update.patch
-i386-io_apic-use-correct-index-variable-when-computing-the.patch
-x86_64-cpufreq-constant-tsc-fix.patch
-inclusion-of-scalemp-vsmp-architecture-patches-vsmp_arch.patch
-inclusion-of-scalemp-vsmp-architecture-patches-vsmp_align.patch
-fix-compilation-with-config_memory_hotplug=y-and-gcc41.patch
-slab-remove-unused-align-parameter-from-alloc_percpu.patch
-slab-extract-slabinfo-header-printing-to-separate-function.patch
-slab-extract-slab-order-calculation-to-separate-function.patch
-slab-fix-code-formatting.patch
-slab-remove-nested-ifdef-config_numa.patch
-drop-pagecache.patch
-make-high-and-batch-sizes-of-per_cpu_pagelists-configurable.patch
-make-high-and-batch-sizes-of-per_cpu_pagelists-configurable-fix.patch
-make-high-and-batch-sizes-of-per_cpu_pagelists-configurable-fix-fix.patch
-mm-cleanup-zone_pcp.patch
-mm-free_pages-opt.patch
-add-schedule_on_each_cpu.patch
-swap-migration-v5-lru-operations.patch
-swap-migration-v5-pf_swapwrite-to-allow-writing-to-swap.patch
-swap-migration-v5-migrate_pages-function.patch
-swap-migration-add-config_migration-for-page-migration-support.patch
-swap-migration-v5-mpol_mf_move-interface.patch
-swap-migration-v5-sys_migrate_pages-interface.patch
-swap-migration-v5-sys_migrate_pages-interface-x86_64-fix.patch
-swapmig-config_migration-fixes.patch
-swapmig-add_to_swap-avoid-atomic-allocations.patch
-swapmig-drop-unused-pages-immediately.patch
-swapmig-extend-parameters-for-migrate_pages.patch
-swapmig-switch-error-handling-in-migrate_pages-to-use-exx.patch
-cpusets-swap-migration-interface.patch
-mm-make-hugepages-obey-cpusets.patch
-set_page_count-macro-safety.patch
-mm-clean-up-local-variables.patch
-rmap-additional-diagnostics-in-page_remove_rmap.patch
-mempolicies-private-pointer-in-check_range-and-mpol_mf_invert.patch
-fold-numa_maps-into-memopoliciesc.patch
-drop-page-table-lock-before-calling-migrate_page_add.patch
-mempolicies-unexport-get_vma_policy.patch
-move-page-migration-related-functions-near-do_migrate_pages.patch
-oom-kill-of-current-task.patch
-add-mips-dependency-for-dm9000-driver.patch
-drivers-net-arcnet-possible-cleanups.patch
-drivers-net-kconfig-indentation-fix.patch
-drivers-net-bonding-bondingh-extern-inline-static-inline.patch
-drivers-net-gianfarh-extern-inline-static-inline.patch
-e1000-fix-invalid-memory-reference.patch
-remove-bouncing-mail-address-of-mv643xx_eth-maintainer.patch
-forcedeth-tso-fix-for-large-buffers.patch
-cs89x0-make-readwriteword-take-base_addr.patch
-cs89x0-convert-inwoutw-calls-to-readwriteword.patch
-cs89x0-swap-readwritereg-and-readwriteword.patch
-cs89x0-make-readwritereg-use-readwriteword.patch
-cs89x0-cleanly-implement-ixdp2x01-and-pnx0501-support.patch
-cs89x0-switch-inoutsw-to-readwritewords.patch
-fix-kconfig-depends-for-cs89x0-pnx010x-support.patch
-cs89x0-fix-up-after-pnx0105-kconfig-symbol-renaming.patch
-fix-a-few-warning-cleanup_card-defined-but-not-used.patch
-xfrm-sparse-warning-fix.patch
-frv-suppress-configuration-of-certain-features-for-frv.patch
-frv-drop-8-16-bit-xchg-and-cmpxchg.patch
-frv-drop-unsupported-debugging-features.patch
-frv-implement-and-export-various-things-required-by-modules.patch
-frv-support-module-exception-tables.patch
-frv-supply-various-missing-i-o-access-primitives.patch
-frv-add-module-support-stubs.patch
-frv-add-pci_iomap.patch
-frv-fix-pcmcia-configuration.patch
-frv-force-serial-driver-inclusion.patch
-frv-make-get_user-macro-cast-pointers.patch
-frv-miscellaneous-changes.patch
-frv-fix-uninitialised-variable-in-atm-nicstar-driver.patch
-frv-fix-uninitialised-variable-in-serverworks-driver.patch
-i386-gpio-driver-for-amd-cs5535-cs5536.patch
-change-maxaligned_in_smp-alignemnt-macros-to-internodealigned_in_smp-macros.patch
-kill-l1_cache_shift_max.patch
-kill-l1_cache_shift_max-fix.patch
-kill-l1_cache_shift_max-fix-fix.patch
-x86_64-ioapic-virtual-wire-mode-fix.patch
-arm-netwinder-ds1620-driver-needs-an-export-to-be-built.patch
-uml-move-libc-dependent-code-from-signal_userc.patch
-uml-move-libc-dependent-code-from-trap_userc.patch
-uml-merge-trap_userc-and-trap_kernc.patch
-consolidate-asm-futexh.patch
-uml-whitespace-cleanup.patch
-uml-prevent-mode_skas=n-and-mode_tt=n.patch
-make-rcu-task_struct-safe-for-oprofile.patch
-rcu-signal-handling.patch
-rcu-signal-handling-tidies.patch
-rcu-signal-handling-fixes.patch
-rcu-signal-handling-fix-in-attach_pid.patch
-simpler-signal-exit-concurrency-handling.patch
-remove-get_task_struct_rcu.patch
-fix-sigstop-locking-issue.patch
-additional-catchup-rcu-signal-fixes-for-mm.patch
-additional-catchup-rcu-signal-fixes-for-mm-warning-fix.patch
-radix-tree-code-consolidation.patch
-radix_tree-early-termination-of-tag-clearing.patch
-radix-tree-reduce-tree-height-upon-partial-truncation.patch
-debug_slab-depends-on-slab.patch
-slob-introduce-mm-utilc-for-shared-functions.patch
-slob-introduce-the-slob-allocator.patch
-slob-introduce-the-slob-allocator-fixes.patch
-slob-introduce-the-slob-allocator-64-bit-fixes.patch
-cpuset-better-bitmap-remap-defaults.patch
-cpuset-mempolicy-one-more-nodemask-conversion.patch
-cpuset-memory-pressure-meter.patch
-cpuset-memory-pressure-meter-gcc-295-fix.patch
-cpuset-document-additional-features.patch
-cpuset-remove-marker_pid-documentation.patch
-cpuset-minor-spacing-initializer-fixes.patch
-cpuset-update_nodemask-code-reformat.patch
-cpuset-fork-hook-fix.patch
-cpuset-combine-refresh_mems-and-update_mems.patch
-cpuset-implement-cpuset_mems_allowed.patch
-cpuset-numa_policy_rebind-cleanup.patch
-cpuset-number_of_cpusets-optimization.patch
-cpuset-rebind-vma-mempolicies-fix.patch
-cpuset-rebind-vma-mempolicies-fix-fix.patch
-cpuset-rebind-vma-mempolicies-fix-tweaks.patch
-cpuset-migrate-all-tasks-in-cpuset-at-once.patch
-cpuset-remove-test-for-null-cpuset-from-alloc-code-path.patch
-cpuset-use-rcu-directly-optimization.patch
-cpuset-mark-number_of_cpusets-read_mostly.patch
-cpuset-skip-rcu-check-if-task-is-in-root-cpuset.patch
-fix-missing-includes-for-2614-git11.patch
-fix-missing-includes-for-2615-rc1.patch
-new-driver-synclink_gt.patch
-new-char-driver-synclink_gt-2.patch
-new-char-driver-synclink_gt-fix.patch
-irq-type-flags.patch
-irq-type-flags-arm-fix.patch
-irq-type-flags-use-new-flags.patch
-fat-move-fat_clusters_flush-to-write_super.patch
-fat-use-sb_find_get_block-instead-of-sb_getblk.patch
-fat-add-the-read-writepages.patch
-fat-s-export_symbol-export_symbol_gpl.patch
-fat-support-direct_io.patch
-export-change-sync_page_range-_nolock.patch
-fat-support-a-truncate-for-expanding-size-2.patch
-fix-and-add-export_symbolfilemap_write_and_wait.patch
-move-rtc_interrupt-prototype-to-rtch.patch
-drivers-isdn-extern-inline-static-inline.patch
-kernel-small-cleanups.patch
-pktcdvd-use-bd_claim-to-get-exclusive-access.patch
-atomic-dec_and_lock-use-atomic-primitives.patch
-rcu-file-use-atomic-primitives.patch
-rcu-file-use-atomic-primitives-fix.patch
-rcu-file-use-atomic-primitives-tidy.patch
-elf-symbol-table-type-additions.patch
-ipc-expand-shm_flags.patch
-relayfs-decouple-buffer-creation-from-inode-creation.patch
-relayfs-export-relayfs_create_file-with-fileops-param.patch
-relayfs-add-relayfs_remove_file.patch
-relayfs-use-generic_ip-for-private-data.patch
-relayfs-remove-unused-alloc-destroy_inode.patch
-relayfs-add-documention-for-non-relay-files.patch
-relayfs-add-support-for-relay-files-in-other-filesystems.patch
-relayfs-add-documentation-on-relay-files-in-other-filesystems.patch
-relayfs-add-support-for-global-relay-buffers.patch
-relayfs-add-documentation-on-global-relay-buffers.patch
-relayfs-cleanup-change-relayfs_file_-to-relay_file_.patch
-relayfs-documentation-cleanup-remove-obsolete-info.patch
-use-ptrace_get_task_struct-in-various-places-2.patch
-use-ptrace_get_task_struct-in-various-places-2-powerpc-fix.patch
-use-ptrace_get_task_struct-in-various-places-2-x86_64-fix.patch
-use-ptrace_get_task_struct-in-various-places-fix-3.patch
-udf-remove-bogus-inode-==-null-check-in-inode_bmap.patch
-vgacon-fix-doublescan-mode.patch
-vgacon-workaround-for-resize-bug-in-some-chipsets.patch
-permit-multiple-inclusion-of-linux-pagevech.patch
-add-list_for_each_entry_safe_reverse.patch
-fix-some-problems-with-truncate-and-mtime-semantics.patch
-fix-overflow-tests-for-compat_sys_fcntl64-locking.patch
-fix-overflow-tests-for-compat_sys_fcntl64-locking-re-fix.patch
-printk-return-value-fix-it.patch
-kmsg_write-dont-return-printk-return-value.patch
-keys-permit-key-expiry-time-to-be-set.patch
-keys-discard-duplicate-keys-from-a-keyring-on-link.patch
-keys-permit-running-process-to-instantiate-keys.patch
-keys-permit-running-process-to-instantiate-keys-warning-fix.patch
-sigaction-should-clear-all-signals-on-sig_ign-not-just.patch
-sigaction-should-clear-all-signals-on-sig_ign-not-just-fix.patch
-docs-updated-some-code-docs.patch
-add-block_device_operationsgetgeo-block-device-method.patch
-add-block_device_operationsgetgeo-block-device-method-fix.patch
-add-block_device_operationsgetgeo-block-device-method-fix-2.patch
-nbd-remove-duplicate-assignment.patch
-unchecked-alloc_percpu-return-in-__create_workqueue.patch
-fix-possible-page_cache_shift-overflows.patch
-kill_proc_info_as_uid-dont-use-hardcoded-constants.patch
-do_coredump-should-reset-group_stop_count-earlier.patch
-little-do_group_exit-cleanup.patch
-tpm-add-bios-measurement-log.patch
-tpm-add-bios-measurement-log-tidy.patch
-tpm-add-bios-measurement-log-fix.patch
-updated-cpu-hotplug-documentation.patch
-pivot_root-add-comment.patch
-shared-mounts-cleanup.patch
-ext3-external-journal-device-as-a-mount-option.patch
-ext3-external-journal-device-as-a-mount-option-update.patch
-oprofile-use-vmalloc_node-in-alloc_cpu_buffers.patch
-ext3-remove-trailing-newlines-from-ext3_warning-calls.patch
-ext3-use-sbi-instead-of-ext3_sb-in-resize-code.patch
-maintainers-line-duplication.patch
-remove-unneeded-sig-curr_target-recalculation.patch
-sigio-cleanup-dont-take-tasklist-twice.patch
-nfsroot-do-not-silently-stop-parsing-on-an-unknown-option.patch
-shrink-dentry-struct.patch
-shrink-dentry-struct-fix.patch
-shrink-dentry-struct-spufs-fix.patch
-printk-levels-for-spinlock-debug.patch
-printk-levels-for-i386-oops-code.patch
-drivers-connector-cn_procc-typos.patch
-fix-handling-of-elf-segments-with-zero-filesize.patch
-drivers-mfd-header-included-twice.patch
-documentation-small-applying-patchestxt-update.patch
-fs-remove-s_old_blocksize-from-struct-super_block.patch
-remove-unused-blkp-field-in-percpu_data.patch
-add-tainting-for-proprietary-helper-modules.patch
-extend-rcu-torture-module-to-test-tickless-idle-cpu.patch
-extend-rcu-torture-module-to-test-tickless-idle-cpu-fixes.patch
-update-to-the-initramfs-docs.patch
-fadvise-return-espipe-on-fifo-pipe.patch
-dont-attempt-to-power-off-if-power-off-is-not-implemented.patch
-dont-attempt-to-power-off-if-power-off-is-not-implemented-alpha-fix.patch
-dont-attempt-to-power-off-if-power-off-is-not-implemented-m32r-fix.patch
-dont-attempt-to-power-off-if-power-off-is-not-implemented-uml-fix.patch
-tpmdd-remove-global-event-log.patch
-tpmdd-remove-global-event-log-tidy.patch
-cciss-adds-msi-and-msi-x-support.patch
-cciss-adds-msi-and-msi-x-support-fix.patch
-fork-fix-race-in-setting-childs-pgrp-and-tty.patch
-setpgid-should-work-for-sub-threads.patch
-setsid-should-work-for-sub-threads.patch
-setpgid-should-not-accept-ptraced-childs.patch
-block-stattxt.patch
-fix-ipmi-compile-errors-with-proc_fs=n.patch
-fs-udf-ballocc-extern-inline-static-inline.patch
-copy_process-error-path-cleanup.patch
-abandon-gcc-295x.patch
-remove-gcc2-checks.patch
-more-updates-for-the-gcc-=-32-requirement.patch
-dev-mem-__have_phys_mem_access_prot-tidy-up.patch
-dev-mem-validate-mmap-requests.patch
-fs-proc-function-prototypes-belong-into-header-files.patch
-sonypi-convert-to-the-new-platform-device-interface.patch
-sonypi-enable-acpi-events-for-sony-laptop-hotkeys.patch
-modules-prevent-overriding-of-symbols.patch
-modules-mark-taint_forced_rmmod-correctly.patch
-reorder-kiocb-structure-elements-to-make-sync-iocb-setup-faster.patch
-shrink-struct-page.patch
-kernel-modulec-getting-rid-of-the-redundant-spinlock-in-resolve_symbol.patch
-ptrace_sysemu-is-only-for-i386-and-clashes-with-other-ptrace-codes-of-other-archs.patch
-fs-smbfs-procc-fix-data-corruption-in-smb_proc_setattr_unix.patch
-ufs-inode-i_sem-is-not-released-in-error-path.patch
-submittingpatches-diffstat-options.patch
-credits-update-eugene-surovegin.patch
 reduce-size-of-bio-mempools.patch
-split-out-screen_info-from-ttyh.patch
-v9fs-fix-fd_close.patch
-v9fs-new-multiplexer-implementation.patch
-v9fs-new-multiplexer-implementation-tidy.patch
-v9fs-fix-fid-management-in-v9fs_create.patch
-v9fs-zero-copy-implementation.patch
-fix-gcc41-build-failure-on-xconfig.patch
-hw_random-82801ab-pci-bridge-support.patch
-add-a-section-about-inlining-to-documentation-codingstyle.patch
-parport_pc-arm-build-fix.patch
-parport-bring-back-an-unused-phase-for-ppdev-ioctl.patch
-eliminate-__attribute__-packed-warnings-for-gcc-41.patch
-afs-remove-unnecessary-__attribute__-packed.patch
-i4l-__attribute__packed-for-the-capi-message-structs.patch
-make-apm-buildable-without-legacy-pm.patch
-remove-semicolons-from-save_flags.patch
-drivers-block-use-array_size-macro.patch
-fix-workqueue-oops-during-cpu-offline.patch
-kconf-check-for-eof-from-input-stream.patch
-i810_audio-request_irq-fix.patch
-simplify-k_getrusage.patch
-drivers-isdn-add-missing-includes.patch
-drivers-isdn-hardware-eicon-os_4bric-correct-the-xdiloadfile-signature.patch
-dump_thread-cleanup.patch
-cciss-avoid-defining-useless-major_nr-macro.patch
-remove-set_fs-in-stop_machine.patch
-kdump-i386-save-ss-esp-bug-fix.patch
-kdump-dynamic-per-cpu-allocation-of-memory-for-saving-cpu-registers.patch
-kdump-export-per-cpu-crash-notes-pointer-through-sysfs.patch
-kdump-export-crash-notes-sysfs-remove-get-cpu.patch
-kdump-save-registers-early-inline-functions.patch
-kdump-save-registers-early-inline-functions-fix.patch
-kdump-save-registers-early-inline-functions-fix-2.patch
-kdump-x86_64-add-memmmap-command-line-option.patch
-kdump-x86_64-add-elfcorehdr-command-line-option.patch
-kdump-x86_64-add-elfcorehdr-command-line-option-fix.patch
-kdump-x86_64-add-elfcorehdr-command-line-option-fix-2.patch
-kdump-x86_64-kexec-on-panic.patch
-kdump-x86_64-save-cpu-registers-upon-crash.patch
-kdump-read-previous-kernels-memory.patch
-kdump-read-previous-kernels-memory-fix.patch
-kexec-increase-max-segment-limit.patch
-kexec-change-config_physical_start-dependency.patch
-kdump-documentation-update.patch
-simple-spi-framework.patch
-simple-spi-framework-priority-inversion-tweak.patch
-simple-spi-framework-gregkh-hotplug-fix.patch
-ads7846-driver-spi-framework.patch
-ads7846-driver-spi-framework-fix.patch
-mtd-dataflash-driver-spi-framework-2.patch
-mtd-dataflash-driver-spi-framework-2-mtd_dataflash-updates.patch
-spi-add-spi_driver-to-spi-framework.patch
-spi-core-tweaks-bugfix.patch
-spi-ads7836-uses-spi_driver.patch
-spi-add-spi_bitbang-driver.patch
-spi-add-spi_bitbang-driver-bitbanging-becomes-library-code.patch
-m25-series-spi-flash.patch
-m25-series-spi-flash-fix.patch
-tiny-add-bloat-o-meter-to-scripts.patch
-tiny-uninline-some-openc-functions.patch
-tiny-uninline-some-inodec-functions.patch
-tiny-uninline-some-fslocksc-functions.patch
-tiny-trim-non-ipx-builds.patch
-tiny-make-x86-doublefault-handling-optional.patch
-tiny-make-id16-support-optional.patch
-tiny-make-id16-support-optional-fix.patch
-tiny-configure-elf-core-dump-support.patch
-make-vm86-support-optional.patch
-add-vfs_-helpers-for-xattr-operations.patch
-add-vfs_-helpers-for-xattr-operations-fix.patch
-add-vfs_-helpers-for-xattr-operations-fix-2.patch
-move-xattr-permission-checks-into-the-vfs.patch
-remove-jfs-xattr-permission-checks.patch
-remove-ext2-xattr-permission-checks.patch
-remove-ext2-xattr-permission-checks-warning-fixes.patch
-remove-ext3-xattr-permission-checks.patch
-remove-reiserfs-xattr-permission-checks.patch
-remove-xfs-xattr-permission-checks.patch
-remove-xfs-xattr-permission-checks-warning-fixes.patch
-replace-inode_update_time-with-file_update_time.patch
-replace-inode_update_time-with-file_update_time-comments.patch
-replace-inode_update_time-with-file_update_time-switch-ntfs-to-touch_atime.patch
-switch-autofs4-to-touch_atime.patch
-ocfs-update-atime-borkage.patch
-remove-update_atime.patch
-__deprecated_for_modules-the-lookup_hash-prototype.patch
-switch-fs3270-to-compat_ioctl.patch
-remove-tiocgserial-tiocsserial-compat_ioctl-entries-for-390.patch
-compat_ioctl-for-390-tape_char.patch
-common-compat_sys_timer_create.patch
-move-rtc-compat-ioctl-handling-to-fs-compat_ioctlc.patch
-add-compat_ioctl-to-dasd.patch
-add-compat_ioctl-to-dasd-fix.patch
-sanitize-building-of-fs-compat_ioctlc.patch
-ntfs-remove-superflous-ms_noatime-ms_nodiratime-assignments.patch
-9p-remove-superflous-ms_nodiratime-assignment.patch
-per-mount-noatime-and-nodiratime-2.patch
-dont-include-ioctl32h-in-drivers.patch
-generic-ioctlh.patch
-mutex-subsystem-add-atomic_xchg-to-all-arches.patch
-mutex-subsystem-add-typecheck_fntype-function.patch
-mutex-subsystem-add-asm-generic-mutex-h-implementations.patch
-mutex-subsystem-memory-ordering-fixes.patch
-mutex-subsystem-add-include-asm-i386-mutexh.patch
-mutex-subsystem-add-include-asm-x86_64-mutexh.patch
-mutex-subsystem-add-include-asm-arm-mutexh.patch
-mutex-subsystem-add-default-include-asm-mutexh-files.patch
-mutex-subsystem-core.patch
-mutex-subsystem-documentation.patch
-mutex-subsystem-debugging-code.patch
-mutex-subsystem-more-debugging-code.patch
-mutex-subsystem-semaphore-to-mutex-xfs.patch
-mutex-subsystem-semaphore-to-mutex-vfs-i_sem.patch
-mutex-subsystem-semaphore-to-mutex-vfs-i_sem-more.patch
-mutex-subsystem-semaphore-to-mutex-vfs-i_sem-fixes.patch
-mutex-subsystem-semaphore-to-mutex-vfs-i_sem-fixes-2.patch
-mutex-subsystem-semaphore-to-mutex-vfs-i_sem-fixes-3.patch
-mutex-subsystem-semaphore-to-mutex-vfs-sb-s_lock.patch
-mutex-subsystem-semaphore-to-completion-sx8.patch
-mutex-subsystem-semaphore-to-completion-cpu3wdt.patch
-mutex-subsystem-semaphore-to-completion-ide-gendev_rel_sem.patch
-mutex-subsystem-semaphore-to-completion-drivers-block-loopc.patch
-hrtimer-move-div_long_long_rem-out-of-jiffiesh.patch
-hrtimer-move-div_long_long_rem-out-of-jiffiesh-sparc64-fix.patch
-hrtimer-remove-duplicate-div_long_long_rem-implementation.patch
-hrtimer-deinline-mktime-and-set_normalized_timespec.patch
-hrtimer-clean-up-mktime-and-make-arguments-const.patch
-hrtimer-export-deinlined-mktime.patch
-hrtimer-remove-unused-clock-constants.patch
-hrtimer-coding-style-clean-up-of-clock-constants.patch
-hrtimer-coding-style-and-white-space-cleanup.patch
-hrtimer-make-clockid_t-arguments-const.patch
-hrtimer-coding-style-and-white-space-cleanup-2.patch
-hrtimer-create-and-use-timespec_valid-macro.patch
-hrtimer-validate-timespec-of-do_sys_settimeofday.patch
-hrtimer-introduce-nsec_t-type-and-conversion-functions.patch
-hrtimer-introduce-ktime_t-time-format.patch
-hrtimer-hrtimer-core-code.patch
-hrtimer-hrtimer-documentation.patch
-hrtimer-switch-itimers-to-hrtimer.patch
-hrtimer-create-hrtimer-nanosleep-api.patch
-hrtimer-switch-sys_nanosleep-to-hrtimer.patch
-hrtimer-switch-clock_nanosleep-to-hrtimer-nanosleep-api.patch
-hrtimer-convert-posix-timers-completely.patch
-hrtimer-convert-posix-timers-completely-fix.patch
-hrtimer-convert-posix-timers-completely-fix-2.patch
-export-ktime_get_ts.patch
-switch-getnstimestamp-calls-to-ktime_get_ts.patch
-remove-getnstimestamp.patch
-kprobes-enable-funcions-only-for-required-arch.patch
-kprobes-cleanup-include_asm_kprobes_h.patch
-kprobes-changed-from-using-spinlock-to-mutex.patch
-kprobes-changed-from-using-spinlock-to-mutex-fix.patch
-kprobes-cleanup-arch_remove_kprobe.patch
-kprobes-fix-build-break-in-2615-rc5-mm3.patch
-kprobes-conversion-from-kcalloc-to-kzalloc.patch
-v4l-926_2-moves-compat32-functions-from-fs-to-v4l.patch
-v4l-963-explicit-compat_ioctl32-handler-to-em28xx.patch
-v4l-dvb-3120-adds-32-bit-compatibility-for-v4l2.patch
-v4l-0987-added-secam-l-std-on-tda9887-and-common.patch
-v4l-1019-added-basic-support-tv-radio-for.patch
-v4l-1023-added-hauppauge-impactvcb-board.patch
-v4l-0979-added-v4l-support-for-the-nova-s-plus-and.patch
-v4l-0990-enable-ir-support-for-the-nova-s-plus.patch
-v4l-1007-add-support-for-kworld-dvb-s-100.patch
-v4l-0988-tuner-cleanups-by-removing-video-if-from.patch
-v4l-1021-tuner-description-now-follows-the-same.patch
-dvb-2420-makes-integration-of-future-devices-easier.patch
-dvb-2421-fixed-oddities-at-firmware-download.patch
-dvb-2428-fixes-for-the-topuptv-scm-mediaguard-cam.patch
-dvb-2431-fixed-dishnetwork-support-for-nexus-s-rev.patch
-dvb-2432-lnb-power-can-now-be-switched-off-for.patch
-dvb-2440-fixed-mpeg-audio-on-spdif-from-nexus-ca.patch
-dvb-2441-driver-support-for-live-ac3-firmware-=.patch
-dvb-2444-implement-frontend-specific-tuning-and.patch
-dvb-2445-added-demodulator-driver-for-nova-s-plus.patch
-dvb-2446-minor-cleanups.patch
-dvb-2451-add-support-for-kworld-dvb-s-100-based.patch
-dvb-2454-port-code-for-su1278-sh2-tua6100-from.patch
-dvb-2390-adds-a-time-delay-to-ir-remote-button.patch
-v4l-dvb-3062-fix-wrong-tunerh-define-for-tuner-46.patch
-v4l-dvb-3064-some-cleanups-on-msp3400.patch
-v4l-dvb-3065-fix-gcc-402-compile-error-in.patch
-v4l-dvb-3081-added-offset-parameter-for-adjusting.patch
-v4l-dvb-3084-added-a-new-debug-msg-to-help.patch
-v4l-dvb-3086-vfreenull-is-legal.patch
-v4l-dvb-3089-adding-support-for-the-hauppauge.patch
-v4l-dvb-3090-cleanup-check-for-dvb.patch
-v4l-dvb-3092-add-support-for-another-nova-t-pci.patch
-v4l-dvb-3099-fixed-device-controls-for-em28xx-on.patch
-v4l-dvb-3100-fix-compile-error-remove-dead-code.patch
-v4l-dvb-3103-add-vidioc_log_status-to-tuner-corec.patch
-v4l-dvb-3104-msp3400-miscelaneous-fixes.patch
-v4l-dvb-3105-remove-audc_config_pinnacle-horror.patch
-v4l-dvb-3108-tveeprom-cleanup-of-hardcoded-tuner.patch
-v4l-dvb-3112-several-fixes-for-hauppauge-roselyn.patch
-v4l-dvb-3115-add-missing-video_adv_debug-config.patch
-v4l-dvb-3116-tda9887-improvements-better.patch
-v4l-dvb-3117-fix-broken-tv-standard-check.patch
-v4l-dvb-3118-enable-remote-control-on-avertv.patch
-v4l-dvb-3123-include-reorder-to-be-in-sync-with.patch
-v4l-dvb-3123a-remove-uneeded-if-from-v4l-subsystem.patch
-v4l-dvb-3123b-syncs-v4l-subsystem-tree-with-kernel.patch
-v4l-dvb-3129-correct-fe_read_uncorrected_blocks.patch
-v4l-dvb-3130-cx24123-cleanup-timout-handling.patch
-v4l-dvb-3145-syncronizes-some-changes-between-v4l.patch
-dvb-2401-usb-hot-unplug-oops-fix.patch
-v4l-dvb-3154-ttusb-dec-driver-patch-roundup.patch
-v4l-dvb-3159-replaces-max-min-by-kernelh.patch
-v4l-dvb-3160-updates-to-the-tveeprom-eeprom.patch
-v4l-dvb-3161-ir-kbd-gpio-is-now-part-of-bttv.patch
-v4l-dvb-3166-philips-1236d-atsc-ntsc-dual-in.patch
-media-radio-pci-probing-for-maestro-radio.patch
-media-radio-pci-probing-for-maestro-radio-fix.patch
-media-radio-maestro-radio-lindent.patch
-media-radio-maestro-types-change.patch
-media-radio-maestro-avoid-accessing-private-structures-directly.patch
-media-radio-maestro-radio-delete-owner-line-from-video-device.patch
-ingo-nfs-stuff.patch
-mips-namespace-pollution-dump_regs-elf_dump_regs.patch
-vesafb-drop-blank-hook.patch
-aty-remove-unnecessary-config_pci.patch
-fbcon-sanitize-fbcon.patch
-nvidiafb-i2c-bus-name-beautification.patch
-fbcon-store-struct-display-when-setting-all-vcs.patch
-matroxfb-remove-fbconh-from-the-main-header-file.patch
-savagefb-one-more-i2c-enabled-device-in-savagefb.patch
-add-sysfs-entry-to-disable-framebuffer-access.patch
-add-sysfs-entry-to-disable-framebuffer-access-tidy.patch
-fbdev-nvidiafb-driver-cleanup.patch
-fbdev-savagefb-driver-cleanup.patch
-fbdev-i810fb-driver-cleanups.patch
-fbdev-rivafb-driver-cleanups.patch
-fbdev-asiliantfb-driver-cleanups.patch
-fbdev-hgafb-convert-to-platform-device.patch
-fbdev-imsttfb-driver-cleanups.patch
-fbdev-kyrofb-driver-cleanups.patch
-fbdev-neofb-driver-cleanups.patch
-fbdev-pm2fb-driver-cleanups.patch
-fbdev-tdfxfb-driver-cleanups.patch
-fbdev-fbdev-cleanup.patch
-fbdev-atyfb-remove-bios-less-booting.patch
-fbdev-sstfb-driver-cleanups.patch
-rivafb-trim-rivafb_pan_display.patch
-savagefb-trim-savagefb_pan_display.patch
-vesafb-trim-vesafb_pan_display.patch
-vesafb-trim-vesafb_pan_display-fix.patch
-vga16fb-trim-vga16fb_pan_display.patch
-atyfb-fix-spelling.patch
-atyfb-reduce-verbosity.patch
-atyfb-fix-crtc_fifo_lwm-mask.patch
-atyfb-fix-interlaced-modes.patch
-atyfb-dont-stretch-with-crt.patch
-atyfb-set-ecp-divider.patch
-atyfb-improve-blanking.patch
-atyfb-rage-xl-xc-cleanup.patch
-atyfb-vt-gt-cleanup.patch
-atyfb-lt-lg-cleanup.patch
-nvidiafb-add-support-for-some-pci-e-chipsets.patch
-nvidiafb-add-support-for-some-pci-e-chipsets-fix.patch
-skeletonfb-documentation-update.patch
-include-video-newporth-extern-inline-static-inline.patch
-fbcon-disable-ywrap-if-not-supported-by-fbcon-scrolling-code.patch
-fbdev-fixed-and-updated-cyblafb.patch
-fbdev-fixed-and-updated-cyblafb-fix.patch
-cyblafb-remove-unneeded-code.patch
-fbdev-fix-return-code-of-fb_read-and-fb_write.patch
-fbdev-reduce-stack-usage.patch
-nvidiafb-add-boot-option-bpp.patch
-nvidiafb-reduce-stack-usage.patch
-s3c2410fb-cleanup-and-fix.patch
-i810fb-fix-suspend-and-resume-hooks.patch
-fbcon-code-cleanups.patch
-fbdev-replace-kmalloc-with-kzalloc.patch
-fb-typoes-in-kconfig.patch
-fbcon-dont-call-set_par-in-fbcon_init-if-vc_mode==kd_graphics.patch
-fix-console-blanking.patch
-kbuild-call-gcc_version-earlier.patch
-fix-some-f_ops-abuse-in-acpi.patch
-fix-input-layer-f_ops-abuse.patch
-fix-cifs-bugs-wrt-writing-to-f_ops.patch
-codingstyle-correction.patch
-docbook-add-gitignore-file.patch
-add-git-tree-for-docbook.patch
-docbook-fix-kernel-doc-comments.patch
-docbook-warn-for-missing-macro-parameters.patch
-docs-update-typos-corrections-and-additions-to-applying-patchestxt.patch
-docs-update-small-spelling-formating-etc-fixes-for-filesystems-ext3txt.patch
-docs-update-remove-obsolete-patch-from-lockstxt.patch
-docs-update-small-fixes-to-stable_kernel_rulestxt.patch
-drivers-net-irda-irportc-cleanups.patch
-turn-const-static-into-static-const.patch
-drivers-char-use-array_size-macro.patch
-drivers-video-possible-cleanups.patch
-fs-ext2-bitmapc-ext2_count_free-is-only-required-ifdef-ext2fs_debug.patch
-fs-ext3-small-cleanups.patch
-lib-zlib-possible-cleanups.patch
-tty-layer-buffering-revamp-jsm-is-broken.patch
-tty-layer-buffering-revamp.patch
-synclink_gt-conversion-to-new-buffering.patch
-m32r-buildfix-of-m32r_sioc.patch
-tty-layer-buffering-revamp-pmac_zilog-warning-fix.patch
-tty-layer-buffering-revamp-further-tty-bits.patch
-tty-layer-buffering-revamp-uml-fix.patch
-tty-layer-buffering-revamp-ia64-fix.patch
-tty-layer-buffering-revamp-usb-white-heat-fix.patch
-tty-layer-buffering-revamp-s390-fixes.patch
-tty-layer-buffering-revamp-sunsab-build-fix.patch
-moxa-intellio.patch
-tty-layer-buffering-revamp-mkiss-update-re-introduced-defunct-receive_room-function.patch
-clean-up-computone-remaining-cli-use.patch
-tty-layer-buffering-revamp-icom-fixes.patch
-tty-layer-buffering-revamp-isdn-layer.patch
-driver-char-n_hdlcc-remove-unused-declaration.patch
-serial-disable-jsm-in-ppc64-defconfig.patch
-tty-layer-buffering-revamp-stallion-rio-fixes.patch
-tty-layer-buffering-revamp-stallion-rio-fixes-fix.patch
-isicom-whitespace-cleanup.patch
-isicom-type-conversion-and-variables-deletion.patch
-isicom-other-little-changes.patch
-isicom-pci-probing-added.patch
-isicom-pci-probing-added-fix.patch
-isicom-pci-probing-added-fix-vs-gregkh-pci-pci-driver-owner-removal.patch
-isicom-firmware-loading.patch
-isicom-more-whitespaces-and-coding-style.patch
-drivers-replace-pci_module_init-with-pci_register_driver-in-mm.patch
-sound-replace-pci_module_init-with-pci_register_driver-in-mm.patch
-decrease-number-of-pointer-derefs-in-exitc.patch
-decrease-number-of-pointer-derefs-in-flexcop-fe-tunerc.patch
-decrease-number-of-pointer-derefs-in-multipathc.patch
-decrease-number-of-pointer-derefs-in-connectionc.patch
-fs-binfmt_elf-remove-unneeded-kmalloc-return-value-casts.patch
-net-remove-unneeded-kmalloc-return-value-casts.patch
-drivers-atm-remove-unneeded-kmalloc-return-value-casts-tiny-whitespace-cleanup.patch
-selinux-remove-unneeded-kalloc-return-value-casts.patch
-include-asm-sh64-extern-inline-static-inline.patch
-video-matrox-matroxfb_miscc-remove-dead-code.patch
-kill-drivers-net-irda-sir_corec.patch
-kernel-resourcec-__check_region-remove-pointless-__deprecated.patch
-include-linux-schedh-no-need-to-guard-the-normalize_rt_tasks-prototype.patch
-let-magic_sysrq-no-longer-depend-on-debug_kernel.patch
-fs-hfsplus-remove-the-hfsplus_inode_check-debug-function.patch

 Merged

+kdump-emove-remaining-crash_notes-variable-from-arch-powerpc-kernel-machine_kexecc.patch

 powerpc build fix

+sound-remove-bkl-from-sound-core-infoc.patch

 Remove some lock_kernel()s

+git-blktrace-build-fix.patch

 Fix rejects in git-blktrace.patch

+gregkh-driver-input-MODALIAS-02.patch
+gregkh-driver-add-bus_type-probe-remove-shutdown-methods..patch
+gregkh-driver-add-pci_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-ecard_bus_type-probe-remove-shutdown-methods.patch
+gregkh-driver-add-sa1111-bus_type-probe-remove-methods.patch
+gregkh-driver-add-locomo-bus_type-probe-remove-methods.patch
+gregkh-driver-add-logic-module-bus_type-probe-remove-methods.patch
+gregkh-driver-add-tiocx-bus_type-probe-remove-methods.patch
+gregkh-driver-add-parisc_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-ocp_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-sh_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-of_platform_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-vio_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-dio_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-i2c_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-gameport-bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-serio-bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-macio_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-mcp-bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-mmc_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-pcmcia_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-pnp_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-ccwgroup_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-superhyway_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-usb_serial_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-zorro_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-rio_bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-pseudo-lld-bus_type-probe-and-remove-methods.patch
+gregkh-driver-add-ide_bus_type-probe-and-remove-methods.patch
+gregkh-driver-remove-usb-gadget-generic-driver-methods.patch
+gregkh-driver-add-bttv-sub-bus_type-probe-and-remove-methods.patch
+gregkh-driver-platform-device-del-typo-fix.patch
+gregkh-driver-spi-simple-spi-framework.patch
+gregkh-driver-spi-ads7846-driver.patch
+gregkh-driver-spi-mtd-dataflash-driver.patch
+gregkh-driver-spi-add-spi_driver-to-spi-framework.patch
+gregkh-driver-spi-core-tweaks-bugfix.patch
+gregkh-driver-spi-ads7836-uses-spi_driver.patch
+gregkh-driver-spi-add-spi_bitbang-driver.patch
+gregkh-driver-spi-m25-series-spi-flash.patch
+gregkh-driver-spi-use-linked-lists-rather-than-an-array.patch
+gregkh-driver-spi-misc-fixes.patch
+gregkh-driver-aoe-zero-packet-data-after-skb-allocation.patch
+gregkh-driver-aoe-support-dynamic-resizing-of-aoe-devices.patch
+gregkh-driver-aoe-increase-allowed-outstanding-packets.patch
+gregkh-driver-aoe-use-less-confusing-driver-name.patch
+gregkh-driver-aoe-allow-network-interface-migration-on-packet-retransmit.patch
+gregkh-driver-aoe-update-device-information-on-last-close.patch
+gregkh-driver-aoe-update-driver-version-number.patch

 driver tree updates

+gregkh-driver-spi-simple-spi-framework-kconfig-simplification.patch
+spi-add-spi_butterfly-driver.patch
+spi-remove-fastcall-crap.patch
+spi-add-bus-methods-instead-of-drivers-ones.patch
+spi-add-bus-methods-instead-of-drivers-ones-fixes.patch

 Fix it.

+hdaps-convert-to-the-new-platform-device-interface.patch
+vr41xx-convert-to-the-new-platform-device-interface.patch
+mv64x600_wdt-convert-to-the-new-platform-device-interface.patch
+tb0219-convert-to-the-new-platform-device-interface.patch
+serial8250-convert-to-the-new-platform-device-interface.patch
+dcdbas-convert-to-the-new-platform-device-interface.patch

 Driver API updates.

+add-drm-support-for-radeon-x600.patch

 DRM feature work

+gregkh-i2c-i2c-i801-i2c-patch-for-intel-ich8.patch
+gregkh-i2c-i2c-resurrect-i2c_smbus_write_i2c_block_data..patch
+gregkh-i2c-hwmon-lm77-negative-temp-fix.patch
+gregkh-i2c-i2c-sis96x-rename-documentation.patch
+gregkh-i2c-hwmon-w83792d-inline-register-access-functions.patch
+gregkh-i2c-i2c-algo-sibyte-module-param.patch
+gregkh-i2c-i2c-busses-use-array-size-macro.patch
+gregkh-i2c-hwmon-allow-sensor-attr-arrays.patch
+gregkh-i2c-hwmon-pc87360-use-attr-arrays.patch
+gregkh-i2c-hwmon-f71805f-new-driver.patch
+gregkh-i2c-hwmon-f71805f-use-attr-arrays.patch
+gregkh-i2c-hwmon-f71805f-add-documentation.patch
+gregkh-i2c-fix-w1_master_ds9490_bridge-dependencies.patch
+gregkh-i2c-w1-remove-incorrect-module_alias.patch

 i2c tree updates

+pre-udma-eide-pio-mode-selection.patch

 libata fix

+no-longer-mark-mtd_obsolete_chips-as-broken.patch

 MTD

+via-rhine-link-loss-autoneg-off-==-trouble.patch
+corruption-during-e100-mdi-register-access.patch
+corruption-during-e100-mdi-register-access-tidy.patch
+config_airo-needs-config_crypto.patch
+gfar-fix-compile-error.patch
+gianfar-mii-use-proper-resource-for-mii-memory-region.patch
+phy-added-a-macro-to-represent-the-string-format-used-to.patch
+gianfar-use-new-phy_id_fmt-macro.patch

 net driver fixes

+hash-table-corruption-in-bond_albc.patch
+happtmeal-add-pci-probing.patch
+net-fix-prio-qdisc-bands-init.patch
+net-fix-1.patch
+net-fix-2.patch
+net-fix-3.patch
+net-fix-4.patch

 net fixes

+git-pcmcia-ssh-needs-mutexh.patch

 Fix git-pcmcia.patch

-git-powerpc-reexport-handle_mm_fault.patch

 Droped.

+gregkh-pci-pci-schedule-pci_legacy_proc-for-removal.patch
+gregkh-pci-pci-irq-and-pci_ids-patch-for-intel-ich8.patch
+gregkh-pci-pci-drivers-pci-pci.c-if-0-pci_find_ext_capability.patch
+gregkh-pci-pci-make-it-easier-to-see-that-set_msi_affinity-is-used.patch
+gregkh-pci-pci-hotplug-fix-up-coding-style-issues.patch
+gregkh-pci-pci-hotplug-fix-up-kconfig-help-text.patch
+gregkh-pci-pci-restore-2-missing-pci-ids.patch
+gregkh-pci-x86-pci-domain-support-struct-pci_sysdata-fix-fix.patch

 PCI tree updates

+gregkh-pci-x86-pci-domain-support-struct-pci_sysdata-fix.patch

 Fix it.

+aic7xxx-fix-timer-handling.patch
-aic7xxx-crash-on-data-overrun.patch

 New fix for adaptec driver timer handling

+scsi-aha1740c-handle-scsi_add_host-failure.patch
+scsi-arm-ecoscsic-handle-scsi_add_host-failure.patch
+scsi-pcmcia-fdomain_stubc-handle-scsi_add_host-failure.patch
+add-scsi_add_host-failure-handling-for-nsp32.patch

 scsi updates

+gregkh-usb-usb-ub-03-oops-with-cfq.patch
+gregkh-usb-usb-ub-04-loss-of-timer-and-a-hang.patch
+gregkh-usb-usb-ub-05-bulk-reset.patch
+gregkh-usb-usb-new-id-for-ftdi_sio.c-and-ftdi_sio.h.patch
+gregkh-usb-usb-ftdi_sio-new-ids-for-westrex-devices.patch
+gregkh-usb-usb-isp116x-hcd-replace-mdelay-by-msleep.patch
+gregkh-usb-usb-yealink.c-cleanup-device-matching-code.patch
+gregkh-usb-usb-usb-storage-add-support-for-rio-karma.patch
+gregkh-usb-usb-gadgetfs-set-zero-flag-for-short-control-in-response.patch
+gregkh-usb-usb-remove-linux_version_code-check-in-pwc-pwc-ctrl.c.patch
+gregkh-usb-usb-cleanup-of-usblp.patch
+gregkh-usb-usb-fix-oops-in-acm-disconnect.patch
+gregkh-usb-usb-ehci-fix-gfp_t-sparse-warning.patch
+gregkh-usb-usb-usb-storage-support-for-sony-dsc-t5-still-camera.patch
+gregkh-usb-usb-sn9c10x-driver-updates-and-bugfixes.patch
+gregkh-usb-usb-asix-add-device-ids-for-0g0-cable-ethernet.patch
+gregkh-usb-usb-drivers-usb-media-w9968cf.c-remove-hooks-for-the-vpp-module.patch
+gregkh-usb-usb-drivers-usb-media-ov511.c-remove-hooks-for-the-decomp-module.patch
+gregkh-usb-usb-remove-extra-newline-in-hid_init_reports.patch
+gregkh-usb-usb-optimise-devio.c-usbdev_read.patch
+gregkh-usb-usb-mdc800.c-to-kzalloc.patch
+gregkh-usb-usb-kzalloc-for-storage.patch
+gregkh-usb-usb-kzalloc-for-hid.patch
+gregkh-usb-usb-kzalloc-in-dabusb.patch
+gregkh-usb-usb-kzalloc-in-w9968cf.patch
+gregkh-usb-usb-kzalloc-in-usbvideo.patch
+gregkh-usb-usb-kzalloc-in-cytherm.patch
+gregkh-usb-usb-kzalloc-in-idmouse.patch
+gregkh-usb-usb-kzalloc-in-ldusb.patch
+gregkh-usb-usb-kzalloc-in-phidgetinterfacekit.patch
+gregkh-usb-usb-kzalloc-in-phidgetservo.patch
+gregkh-usb-usb-kzalloc-in-usbled.patch
+gregkh-usb-usb-kzalloc-in-sisusbvga.patch
+gregkh-usb-usb-touchkitusb.c-fix.patch
+gregkh-usb-usb-pl2303-added-support-for-ca-42-clone-cable.patch
+gregkh-usb-usb-iomega-umini-is-unusual.patch
+gregkh-usb-usb-au1xx0-replace-casual-readl-with-au_readl-in-the-drivers.patch
+gregkh-usb-usb-uhci-no-fsbr-until-device-is-configured.patch

 USB tree updates

+gregkh-usb-usb-optimise-devio.c-usbdev_read-fix.patch

 Fix it

+x86_64-dma-ops.patch
+x86_64-cpu_pda_local_simple.patch
+x86_64-noiommu-printk.patch
+x86_64-atomic-include.patch
+x86_64-inclusion-of-scalemp-vsmp-architecture-patches---vsmp_align.patch
+x86_64-inclusion-of-scalemp-vsmp-architecture-patches---vsmp_arch.patch
+x86_64-ioapic-virtual-wire-mode-fix.patch
+x86_64-remove-obsolete-segments.patch
+x86_64-out-of-line-numa-funcs.patch
+x86_64-sparse-warning-cleanups-x86_64-code.patch

 x86_64 tree updates

+git-xfs-remove-is_noatime.patch

 Revert temp thing from XFS.

+xfs_iomap-warning-fixes.patch

 xfs warning fixes

+restore-kern_emerg-to-each-line-printed-by-bad_page.patch

 printk facility level fix

+zone-reclaim-resurrect-may_swap.patch
+zone-reclaim-reclaim-logic.patch
+zone-reclaim-reclaim-logic-tidy.patch
+zone-reclaim-reclaim-logic-tweaks.patch
+zone-reclaim-proc-override.patch

 Resurrect and fix zone reclaim logic for NUMA

+mm-gfp_atomic-comments.patch

 Fix some comments

+direct-migration-v9-pageswapcache-checks.patch
+direct-migration-v9-migrate_pages-extension.patch
+direct-migration-v9-migrate_pages-extension-fixes.patch
+direct-migration-v9-remove_from_swap-to-remove-swap-ptes.patch
+direct-migration-v9-remove_from_swap-to-remove-swap-ptes-fixes.patch
+direct-migration-v9-upgrade-mpol_mf_move-and-sys_migrate_pages.patch
+direct-migration-v9-upgrade-mpol_mf_move-and-sys_migrate_pages-fixes.patch
+direct-migration-v9-avoid-writeback--page_migrate-method.patch
+direct-migration-v9-avoid-writeback--page_migrate-method-fixes.patch
+direct-migration-v9-avoid-writeback-page_migrate-method-locking-fix.patch

 Internode page migration without going through swap.

-ethtoolh-dont-leak-kernel-types.patch
-miih-dont-leak-kernel-types.patch

 Dropped.

+i386-let-regparm-no-longer-depend-on-experimental.patch
+i386-put-hotplug_cpu-under-processor-type-not-bus-options.patch
+vmsplit-config-options.patch
+hpet-rtc-emulation-add-watchdog-timer.patch

 x86 updates

+include-asm-h8300-pageh-remove-unused-kthread_size-define.patch

 cleanup

+swsusp-low-level-interface-rev-2.patch
+swsusp-separate-swap-writing-reading-code-rev-2.patch

 swsusp updates

+uml-fix-missing-kbuild_basename.patch
+uml-update-kconfig-help.patch
+uml-revert-compile-time-option-checking.patch
+uml-eliminate-doubled-boot-output.patch
+uml-fix-debug-output-on-x86_64.patch
+uml-kill-an-unused-variable.patch

 UML updates

+device_shutdown-can-loop-if-the-driver-frees-itself.patch

 device management fix

+tell-kallsyms_lookup_name-to-ignore-type-u-entries.patch

 kallsyms fix

+kdump-add-dmesg-gdbmacro-into-document.patch
+doc-refer-to-kdump-in-oops-tracingtxt.patch

 kdump documentation

+ext3-fix-documentation-of-online-resizing.patch

 ext3 documentation

+allow-reading-cmos-day-of-week-register.patch

 RTC feature

+tclk-fix-typos-exclamation-mark-frenzy-and-missing-device-id-on.patch

 telco clock driver fixes

+cs89x0-fix-setting-of-allow_dma.patch
+cs89x0-fix-the-kconfig-help-text.patch

 cs89x0 fixes

+kdump-vmcore-compilation-warning-fix.patch

 Compile fix

+protect-remove_proc_entry.patch

 /proc locking fix

+maintainers-remove-dead-project.patch

 MAINTAINERS cleanup

+piix-ide-pata-patch-for-intel-ich8m.patch
+hda_intel-patch-for-intel-ich8.patch
+ata_piix-ide-mode-sata-patch-for-intel-ich8.patch
+ahci-ahci-mode-sata-patch-for-intel-ich8.patch

 Intel ich8 device support

+random-get-rid-of-sparse-warning.patch

 sparse fix

+synclink_gt-remove-unnecessary-page-alignment.patch

 serial driver cleanup

+fix-assertion-failure-in-reiserfsjournaled-quotas.patch

 reiserfs fix

+kprobes-fix-unloading-of-self-probed-module.patch
+kprobes-fix-race-in-recovery-of-reentrant-probe.patch

 kprobes updates

+remove-unused-out_pio-label-in-i810_audio.patch

 fix warning

+ipmi-use-config_dmi-instead-of-config_x86.patch

 IPMI cleanup

+fix-processing-of-obsolete-style-setup-options.patch

 boot option parsing fix

+ext3-get-blocks-maping-multiple-blocks-at-a-once.patch
+ext3-get-blocks-multiple-block-allocation.patch
+ext3-get-blocks-support-multiple-blocks-allocation-in.patch
+ext3-get-blocks-adjust-accounting-info-in.patch
+ext3-get-blocks-adjust-accounting-info-in-build-fix.patch
+ext3-get-blocks-adjust-reservation-window-size-for.patch
+ext3-get-blocks-maping-multiple-blocks-at-a-once-vs-ext3_readdir-use-generic-readahead.patch

 Multiblock allocation for ext3

+mutex-subsystem-add-include-asm-arm-mutexh-fix-2.patch
+powerpc-fastpaths-for-mutex-subsystem.patch

 Warm up mutexes on arm and powerpc

+mutex-subsystem-synchro-test-module-fix.patch
+mutex-subsystem-synchro-test-module-fix-2.patch

 Mutex test module

+edac-swsusp-fixes.patch
+edac-change-default-also-handle-pulled-hardware.patch

 EDAC driver updates

+v4l-dvb-3120-adds-32-bit-compatibility-for-v4l2-fix.patch

 v4l fix

-scheduler-cache-hot-autodetect-fix.patch
-scheduler-cache-hot-autodetect-less-verbose.patch
-scheduler-cache-hot-autodetect-docs.patch
-scheduler-cache-hot-autodetect-section-fixes.patch
-scheduler-cache-hot-autodetect-section-fixes-2.patch
-scheduler-cache-hot-autodetect-limit-to-affected-cpu-map.patch
-scheduler-cache-hot-autodetect-be-less-verbose.patch

 Folded into scheduler-cache-hot-autodetect.patch

+sched-fix-wrong-priority-calculation.patch

 CPU scheduler fix

+fix-arm26-thread_size.patch

 arm26 fix

-sis5513-support-sis-965l.patch

 Dropped

+ide-disk-restore-missing-space-in-log-message.patch

 IDE fixlet

-md-dm-reduce-stack-usage-with-stacked-block-devices-fixes.patch

 Folded into md-dm-reduce-stack-usage-with-stacked-block-devices.patch

+drivers-md-dm-raid1c-fix-inconsistent-mirroring-after-interrupted.patch

 devicemapper fix

+mark-several-functions-__always_inline-fix.patch

 Fix mark-several-functions-__always_inline.patch

+drivers-acpi-make-two-functions-static.patch

 ACPI cleanup

+make-most-file-operations-structs-in-fs-const.patch

 Move file_operations tables into .rodata

+move-capable-to-capabilityh.patch
+capable-capabilityh-fs.patch
+capable-capabilityh-net.patch
+capable-capabilityh-arch.patch

 capable() cleanup

+make-frame_pointer-default=y.patch

 Default to enabling framepointers - we get better stack traces (-mm only)

+lindent-rio-drivers.patch

 Re-indent the rio drivers



All 737 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/patch-list


