Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVFZLJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVFZLJS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 07:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFZLJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 07:09:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261410AbVFZLEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 07:04:04 -0400
Date: Sun, 26 Jun 2005 04:03:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-mm2
Message-Id: <20050626040329.3849cf68.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/


- A reminder that there is a vger mailing list for tracking patches which
  are added to -mm.  Do

    `echo subscribe mm-commits | mail majordomo@vger.kernel.org'

- Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
  the recent PCI breakage sorted out.

- Big arch/cris update.




Changes since 2.6.12-mm1:


-x86_64-task_size-fixes-for-compatibility-mode-processes.patch
-smp_processor_id-cleanup.patch
-smp_processor_id-cleanup-fix.patch
-git-alsa-fix.patch
-git-alsa-usbaudio-fix.patch
-gregkh-driver-driver-device_attr-08-fix.patch
-gregkh-i2c-i2c-ds1374-01-fix.patch
-toshiba-driver-cleanup.patch
-i8k-pass-through-lindent.patch
-i8k-use-standard-dmi-interface.patch
-i8k-convert-to-seqfile.patch
-i8k-initialization-code-cleanup-formatting.patch
-i8k-add-new-bios-signatures.patch
-biarch-compiler-support-for-i386.patch
-use-cross_compileinstallkernel-in-arch-boot-installsh.patch
-ipvs-add-and-reorder-bh-locks-after-moving-to-keventd.patch
-drivers-net-chelsio-cxgb2-use-the-dma_3264bit_mask-constants.patch
-tcp-fastroute-stats-remove.patch
-tcp-no-congestion.patch
-tcp-no-throttle.patch
-tcp-bigger-backlog.patch
-tcp-tcp_super_tso_v3.patch
-tcp-tcp_infra.patch
-tcp-tcp_bic.patch
-tcp-tcp_westwood.patch
-tcp-hstcp.patch
-tcp-hybla.patch
-tcp-vegas.patch
-tcp-h-tcp.patch
-tcp-scaleable_tcp.patch
-gregkh-pci-pci-driver-device_attr-fixup.patch
-vmscan-notice-slab-shrinking.patch
-madvise-do-not-split-the-maps.patch
-madvise-merge-the-maps.patch
-remove-non-discontig-use-of-pgdat-node_mem_map.patch
-resubmit-sparsemem-base-early_pfn_to_nid-works-before-sparse-is-initialized.patch
-resubmit-sparsemem-base-simple-numa-remap-space-allocator.patch
-resubmit-sparsemem-base-reorganize-page-flags-bit-operations.patch
-resubmit-sparsemem-base-teach-discontig-about-sparse-ranges.patch
-create-mm-kconfig-for-arch-independent-memory-options.patch
-make-each-arch-use-mm-kconfig.patch
-make-each-arch-use-mm-kconfig-fix.patch
-update-all-defconfigs-for-arch_discontigmem_enable.patch
-introduce-new-kconfig-option-for-numa-or-discontig.patch
-sparsemem-fix-minor-defaults-issue-in-mm-kconfig.patch
-mm-kconfig-kill-unused-arch_flatmem_disable.patch
-mm-kconfig-hide-memory-model-selection-menu.patch
-mm-kconfig-give-discontig-more-help-text.patch
-ppc64-kconfig-memory-models.patch
-generify-early_pfn_to_nid.patch
-generify-memory-present.patch
-sparsemem-memory-model.patch
-sparsemem-memory-model-fix.patch
-sparsemem-memory-model-fix-3.patch
-sparsemem-memory-model-fix-4.patch
-sparsemem-memory-model-fix-5.patch
-sparsemem-memory-model-fix-6.patch
-sparsemem-memory-model-section-numbers-unsigned-long.patch
-sparsemem-memory-model-for-i386.patch
-sparsemem-memory-model-for-i386-fix.patch
-sparsemem-swiss-cheese-numa-layouts.patch
-sparsemem-hotplug-base.patch
-sparsemem-hotplug-base-fix.patch
-sparsemem-hotplug-base-abstract-section-number-to-section-mapping.patch
-ppc64-add-early_pfn_to_nid.patch
-ppc64-add-memory-present.patch
-ppc64-sparsemem-memory-model.patch
-ppc64-sparsemem-memory-model-fix.patch
-ppc64-sparsemem-memory-model-fix-2.patch
-remove-direct-ref-to-contig_page_data-for-x86-64.patch
-add-x86-64-kconfig-options-for-sparsemem.patch
-reorganize-x86-64-numa-and-discontigmem-config-options.patch
-add-x86-64-specific-support-for-sparsemem.patch
-add-x86-64-specific-support-for-sparsemem-tidy.patch
-add-page_state-info-to-show_mem.patch
-add-page_state-info-to-show_mem-warning-fixes.patch
-mm-add-proc-zoneinfo.patch
-vm-add-may_swap-flag-to-scan_control.patch
-vm-early-zone-reclaim.patch
-vm-early-zone-reclaim-tidy.patch
-vm-add-__gfp_noreclaim.patch
-vm-rate-limit-early-reclaim.patch
-hugepage-consolidation.patch
-hugepage-consolidation-fix.patch
-hugepage-consolidation-fix-fix.patch
-hugepage-consolidation-ia64-fix.patch
-node-local-per-cpu-pages.patch
-node-local-per-cpu-pages-tidy.patch
-node-local-per-cpu-pages-tidy-2.patch
-node-local-per-cpu-pages-tidy-2-fix.patch
-avoiding-mmap-fragmentation.patch
-avoiding-mmap-fragmentation-tidy.patch
-avoiding-mmap-fragmentation-fix.patch
-avoiding-mmap-fragmentation-revert-unneeded-64-bit-changes.patch
-avoiding-mmap-fragmentation-revert-unneeded-64-bit-changes-vs-x86_64-task_size-fixes-for-compatibility-mode-processes.patch
-avoiding-mmap-fragmentation-revert-unneeded-64-bit-changes-vs-x86_64-task_size-fixes-for-compatibility-mode-processes-fix.patch
-avoiding-mmap-fragmentation-fix-2.patch
-avoiding-mmap-fragmentation-fix-3.patch
-mmap-topdown-fix-for-large-stack-limit-large-allocation.patch
-#avoiding-mmap-fragmentation-clean-rev.patch
-mm-remove-pg_highmem.patch
-mm-remove-pg_highmem-tidy.patch
-vm-try_to_free_pages-unused-argument.patch
-__mod_page_state-pass-unsigned-long-instead-of-unsigned.patch
-__read_page_state-pass-unsigned-long-instead-of-unsigned.patch
-add-oom-debug.patch
-periodically-drain-non-local-pagesets.patch
-periodically-drain-non-local-pagesets-fix.patch
-reduce-size-of-huge-boot-per_cpu_pageset.patch
-ia64-uncached-alloc.patch
-sn2-xpc-build-patches.patch
-shmem-restore-superblock-info.patch
-mbind-fix-verify_pages-pte_page.patch
-mbind-check_range-use-standard-ptwalk.patch
-dup_mmap-update-comment-on-new-vma.patch
-bad_page-clear-reclaim-and-slab.patch
-rme96xx-fix-pagereserved-range.patch
-get_user_pages-kill-get_page_map.patch
-do_wp_page-cannot-share-file-page.patch
-can_share_swap_page-use-page_mapcount.patch
-msync-check-pte-dirty-earlier.patch
-kill-stray-newline.patch
-netfilter-debug-locking-fix.patch
-tulip-fixes-for-uli5261.patch
-3c509-device-support.patch
-ppp_mppe-add-ppp-mppe-encryption-module-kconfig-fix.patch
-dm9000-network-driver-bugfix.patch
-x25-selective-sub-address-matching-with.patch
-x25-selective-sub-address-matching-with-fix.patch
-x25-fast-select-with-no-restriction-on.patch
-sunzilog-warning-fixes.patch
-ppp-handle-misaligned-accesses.patch
-3c59x-remove-superfluous-vortex_debug-test-from-boomerang_start_xmit.patch
-kbuild-display-compile-version.patch
-vfs-memory-leak-in-do_kern_mount.patch
-selinux-memory-leak-in-selinux_sb_copy_data.patch
-ppc32-added-support-for-new-mpc8548-family-of-powerquicc.patch
-ppc32-added-preliminary-support-for-the-mpc8548-cds-board.patch
-ppc32-removed-dependency-on-config_cpm2-for-building.patch
-ppc32-converted-mpc10x-bridge-to-use-platform.patch
-cpm_uart-route-scc2-pins-for-the-stx-gp3-board.patch
-ppc32-fix-config_task_size-handling-on-40x.patch
-ppc32-add-support-for-mpc8245-8250-serial-ports-on-sandpoint.patch
-ppc32-remove-orphaned-ppc4xx_kgdbc.patch
-ppc32-added-support-for-all-mpc8548-internal-interrupts.patch
-ppc32-clean-up-num_tlbcams-usage-for-freescale-book-e-ppcs.patch
-ppc32-factor-out-common-exception-code-into-macros-for.patch
-ppc32-remove-some-unnecessary-includes-of-promh.patch
-ppc32-dont-recursively-crash-in-die-on-chrp-prep-machines.patch
-ppc32-kill-embedded-systemmap-use-kallsyms.patch
-ppc64-abolish-ioremap_mm.patch
-ppc64-quieten-rtas-printks.patch
-ppc64-override-command-line-as-ld-cc-variables-when-adding-m64-and-co-for-biarch-compilers.patch
-ppc64-use-cpu_has_feature-macro.patch
-ppc64-iseries-remove-iseries_proch.patch
-ppc64-iseries-header-file-white-space-cleanups.patch
-ppc64-iseries-more-header-file-white-space-cleanups.patch
-ppc64-iseries-obvious-code-simplifications.patch
-ppc64-iseries-remove-lpardatah.patch
-ppc64-iseries-eliminate-some-unused-inline-functions.patch
-ppc64-iseries-remove-hvcallcfgh.patch
-ppc64-iseries-cleanup-itlpqueueh.patch
-ppc64-iseries-tidy-up-some-includes-and-hvcallh.patch
-ppc64-iseries-misc-header-cleanups.patch
-ppc64-iseries-remove-iseries_pci_resetc.patch
-ppc64-iseries-iommuh-cleanups.patch
-ppc64-iseries-iseries_vpdinfoc-cleanups.patch
-ppc64-iseries-iseries_pcih-cleanups.patch
-ppc64-iseries-remove-ioretry-from-iseries_device_node.patch
-ppc64-iseries-remove-some-more-members-of.patch
-ppc64-iseries-irq-simple-cleanups.patch
-ppc64-iseries-remove-xmpcilpeventc.patch
-ppc64-iseries-tidy-up-irq-code-after-merge.patch
-ppc64-iseries-allow-build-with-no-pci.patch
-ppc64-tidy-up-vio-devices-fake-parent.patch
-mips-add-vr41xx-gpio-support.patch
-mips-add-vr41xx-gpio-support-fix.patch
-#sched-x86-sched_clock-to-use-tsc-on-config_hpet-or-config_numa-systems.patch
-platform-smis-and-their-interferance-with-tsc-based-delay-calibration.patch
-platform-smis-and-their-interferance-with-tsc-based-delay-calibration-fix.patch
-m32r-build-fix-for-asm-m32r-topologyh.patch
-ppc64-pcibus_to_node-fix.patch
-x86-x86_64-pcibus_to_node.patch
-x86-x86_64-pcibus_to_node-fix.patch
-fix-pcibus_to_node-for-x86_64.patch
-allow-pcibus_to_node-to-return-undetermined.patch
-numa-aware-block-device-control-structure-allocation.patch
-numa-aware-block-device-control-structure-allocation-tidy.patch
-i386-never-block-forced-sigsegv.patch
-do-not-enforce-unique-io_apic_id-check-for-xapic-systems-i386.patch
-adjust-i386-watchdog-tick-calculation.patch
-allow-early-printk-to-use-more-than-25-lines.patch
-i386-selectable-frequency-of-the-timer-interrupt.patch
-i386-selectable-frequency-of-the-timer-interrupt-fix.patch
-ia64-selectable-timer-interrupt-frequency.patch
-x86-avoid-wasting-irqs-for-pci-devices.patch
-via-82c586b-irq-routing-fix.patch
-x86-include-asm-uaccessh-in-asm-checksumh.patch
-x86-remove-i386_ksymsc-almost.patch
-x86-cpu_khz-type-fix.patch
-x86_64-i8259c-iso99-structure-initialization.patch
-x86_64-fix-hpet-for-systems-that-dont-support-legacy.patch
-optimise-storage-of-read-mostly-variables.patch
-optimise-storage-of-read-mostly-variables-fix.patch
-optimise-storage-of-read-mostly-variables-x86_64-fix.patch
-optimise-storage-of-read-mostly-variables-x86_64-fix-fix.patch
-optimise-storage-of-read-mostly-variables-x86_64-fix-fix-fix.patch
-move-some-more-structures-into-mostly_readonly-and-readonly.patch
-x86_64-never-block-forced-sigsegv.patch
-x86_64-eliminate-duplicate-rdpmc-definition.patch
-x86_64-avoid-wasting-irqs.patch
-dmi-move-acpi-boot-quirk.patch
-dmi-move-acpi-sleep-quirk.patch
-dmi-move-acpi-sleep-quirk-fix.patch
-dmi-remove-central-blacklist.patch
-dmi-code-spring-cleanup.patch
-xen-x86-add-macro-for-debugreg.patch
-xen-x86-use-new-macro-for-debugreg.patch
-xen-x86-rename-usermode-macro.patch
-xen-x86-rename-usermode-macro-fix.patch
-xen-x86-use-more-usermode-macro.patch
-xen-x86_64-add-macro-for-debugreg.patch
-xen-x86_64-use-more-usermode-macro.patch
-ptrace_h8300-condition-bugfix.patch
-arm-irqs_disabled-type-fix.patch
-ioc4-core-driver-rewrite.patch
-ioc4-config-split.patch
-ioc4-pci-bus-speed-detection.patch
-variable-overflow-after-hundreds-round-of-hotplug-cpu.patch
-i386-cpu-hotplug-updated-for-mm.patch
-i386-cpu-hotplug-updated-for-mm-smp_processor_id-cleanup-fix.patch
-i386-dont-use-ipi-broadcast-when-using-cpu-hotplug.patch
-sep-initializing-rework.patch
-sep-initializing-rework-fix.patch
-sep-initializing-rework-cleanup.patch
-i386-hold-call_lock-when-updating-cpu_online_map.patch
-sibling-map-initializing-rework.patch
-sibling-map-initializing-rework-smp_processor_id-cleanup-fix.patch
-init-call-cleanup.patch
-cpu-state-clean-after-hot-remove.patch
-cpu-state-clean-after-hot-remove-smp_processor_id-cleanup-fix.patch
-cpu-state-clean-after-hot-remove-set-cpu_state-for-cpu-hotplug.patch
-cpu-state-clean-after-hot-remove-fix.patch
-cpu-state-clean-after-hot-remove-fix-2.patch
-physical-cpu-hot-add.patch
-physical-cpu-hot-add-fix.patch
-suspend-resume-smp-support.patch
-suspend-resume-smp-support-fix.patch
-suspend-resume-smp-support-fix-2.patch
-suspend-resume-smp-support-fix-3.patch
-swsusp-documentation-updates.patch
-swsusp-kill-config_pm_disk.patch
-s-t-ram-load-gdt-the-right-way.patch
-acpi-fix-video-docs.patch
-properly-stop-devices-before-poweroff.patch
-properly-stop-devices-before-poweroff-fix.patch
-swsusp-kill-unneccessary-does_collide_order.patch
-swsusp-cleanup-whitespace.patch
-swsusp-fix-nr_copy_pages.patch
-swsusp-clean-assembly-parts.patch
-cpu-hotplug-printk-fix.patch
-suspend-pci-power-managment-reference-implementation.patch
-swsusp-only-allow-it-when-it-makes-sense.patch
-update-video-after-suspend-documentation.patch
-x86_64-change-init-sections-for-cpu-hotplug-support.patch
-x86_64-change-init-sections-for-cpu-hotplug-support-fix.patch
-x86_64-cpu-hotplug-support.patch
-x86_64-cpu-hotplug-support-fix.patch
-x86_64-cpu-hotplug-sibling-map-cleanup.patch
-x86_64-dont-use-broadcast-shortcut-to-make-it-cpu-hotplug-safe.patch
-x86_64-dont-use-broadcast-shortcut-to-make-it-cpu-hotplug-safe-fix.patch
-x86_64-dont-use-broadcast-shortcut-to-make-it-cpu-hotplug-safe-fix-set-cpu_state-for-cpu-hotplug.patch
-x86_64-provide-ability-to-choose-using-shortcuts-for-ipi-in-flat-mode.patch
-set-cpu_state-for-cpu-hotplug-ia64.patch
-m32r-support-m3a-2170mappi-iii-platform.patch
-m32r-support-m3a-2170mappi-iii-platform-fix.patch
-m32r-support-m3a-2170mappi-iii-platform-fix-2.patch
-m32r-update-setup_xxxxxc.patch
-m32r-update-m32r_cfc-to-support-mappi-iii.patch
-m32r-update-m32r_cfc-to-support-mappi-iii-fix.patch
-m32r-cleanup-arch-m32r-mm-extablec.patch
-m32r-remove-include-asm-m32r-m32102perih.patch
-m32r-update-defconfig-files.patch
-m32r-use-asm-generic-div64h.patch
-uml-add-and-use-generic-hw_controller_type-release.patch
-uml-complete-hw_controller_type-release-conversion.patch
-uml-make-hw_controller_type-release-exist-only-for-archs-needing-it.patch
-uml-link-tt-mode-against-nptl.patch
-s390-cio-max-channels-checks.patch
-s390-cio-documentation.patch
-s390-ifdefs-in-compat_ioctls.patch
-s390-kernel-stack-overflow-panic.patch
-s390-cmm-sender-parameter-visibility.patch
-s390-memory-detection-32gb.patch
-s390-pending-interrupt-after-ipl-from-reader.patch
-mtrr-size-and-base-debug.patch
-blk-use-find_first_zero_bit-in-blk_queue_start_tag.patch
-blk-remove-blk_queue_tag-real_max_depth-optimization.patch
-blk-remove-blk_tags_per_longmask.patch
-blk-cleanup-generic-tag-support-error-messages.patch
-blk-no-memory-barrier.patch
-blk-branch-hints.patch
-blk-unplug-later.patch
-keys-discard-key-spinlock-and-use-rcu-for-key-payload.patch
-keys-discard-key-spinlock-and-use-rcu-for-key-payload-try-4.patch
-keys-pass-session-keyring-to-call_usermodehelper.patch
-keys-pass-session-keyring-to-call_usermodehelper-fix.patch
-keys-use-rcu-to-manage-session-keyring-pointer.patch
-keys-make-request-key-create-an-authorisation-key.patch
-keys-make-request-key-create-an-authorisation-key-fix.patch
-ecryptfs-export-user-key-type.patch
-timers-fixes-improvements.patch
-timers-fixes-improvements-smp_processor_id-fix.patch
-timers-fixes-improvements-fix.patch
-timers-fixes-improvements-smp_processor_id-cleanup-fix.patch
-timers-fix-__mod_timer-vs-__run_timers-deadlock.patch
-timers-fix-__mod_timer-vs-__run_timers-deadlock-tidy.patch
-timers-comments-update.patch
-kernel-timerc-remove-a-goto-construct.patch
-timers-introduce-try_to_del_timer_sync.patch
-posix-timers-use-try_to_del_timer_sync.patch
-fix-for-prune_icache-forced-final-iput-races.patch
-create-a-kstrdup-library-function.patch
-create-a-kstrdup-library-function-fixes.patch
-create-a-kstrdup-library-function-fix-include-slab.patch
-create-a-kstrdup-library-function-ppc-fix.patch
-kstrdup-convert-a-few-existing-implementations.patch
-con_consdev-bit-not-set-correctly-on-last-console.patch
-as-limit-queue-depth.patch
-as-limit-queue-depth-fix.patch
-generate-hotplug-events-for-cpu-online.patch
-optimise-loop-driver-a-bit.patch
-optimise-loop-driver-a-bit-tidy.patch
-streamline-preempt_count-type-across-archs.patch
-preempt_count-is-int-remove-cast-and-dont-assign-to.patch
-add-check-to-proc-devices-read-routines.patch
-rpc-kick-off-socket-connect-operations-faster.patch
-remove-register_ioctl32_conversion-and-unregister_ioctl32_conversion.patch
-remove-duplicate-get_dentry-functions-in-various-places.patch
-avoid-recursive-oopses.patch
-quota-consolidate-code-surrounding-vfs_quota_on_mount.patch
-quota-sanitize-dentry-handling-in-vfs_quota_on_mount.patch
-kprobes-function-return-probes.patch
-kprobes-function-return-probes-fix.patch
-kprobes-function-return-probes-fix-2.patch
-kprobes-function-return-probes-fix-3.patch
-kprobes-function-return-probes-fix-4.patch
-kprobes-move-aggregate-probe-handlers-and-few-return-probe-routines-to-static.patch
-kprobes-arch_supports_kretprobes-cleanup.patch
-kprobes-function-return-probes-fix-5.patch
-x86_64-specific-function-return-probes.patch
-move-kprobe-arming-into-arch-specific-code.patch
-kprobes-moves-lock-unlock-to-non-arch-kprobe_flush_task.patch
-kprobes-ia64-kdebug-die-notification.patch
-kprobes-ia64-kdebug-die-notification-fix.patch
-kprobes-ia64-arch-specific-handling-of-kprobes.patch
-kprobes-ia64-arch-specific-handling-of-kprobes-fix.patch
-kprobes-ia64-architecture-specific-support.patch
-kprobes-ia64-support-kprobe-on-branch-call-instructions.patch
-kprobes-ia64-cleanup.patch
-kprobes-ia64-qp-fix.patch
-kprobes-ia64-cleanup-2.patch
-kprobes-ia64-cmp-ctype-unc-support.patch # fold
-kprobes-ia64-safe-register-kprobe.patch
-kprobes-ia64-check-jprobe-break-before-handling.patch
-kprobes-temporary-disarming-of-reentrant-probe.patch
-kprobes-temporary-disarming-of-reentrant-probe-for-i386.patch
-kprobes-temporary-disarming-of-reentrant-probe-for-x86_64.patch
-kprobes-temporary-disarming-of-reentrant-probe-for-x86_64-fix.patch
-kprobes-temporary-disarming-of-reentrant-probe-for-ppc64.patch
-kprobes-temporary-disarming-of-reentrant-probe-for-sparc64.patch
-kprobes-temporary-disarming-of-reentrant-probe-for-ia64.patch
-allow-a-jprobe-to-coexist-with-muliple-kprobes.patch
-setuid-core-dump.patch
-support-for-dx-directories-in-ext3_get_parent-nfsd.patch
-document-the-fact-that-linux-arm-kernel-is-subscribers-only.patch
-add-some-comments-to-lookup_create.patch
-fix-of-bogus-file-max-limit-messages.patch
-software-suspend-and-recalc-sigpending-bug-fix.patch
-o1-sb-list-traversing-on-syncs.patch
-26-altix-shut-off-xmit-intr-if-done-xmitting.patch
-parport-netmos-nm9855-fix.patch
-dont-force-o_largefile-for-32-bit-processes-on-ia64-2612-rc3.patch
-ide-floppy-adjustments.patch
-adjust-per_cpu-definition-in-non-smp-case.patch
-apply-quotation-handling-to-makefilebuild.patch
-mempool-only-init-waitqueue-in-slow-path.patch
 #seccomp-disable-tsc-for-seccomp-enabled-tasks.patch
-factor-out-common-code-in-sys_fsync-sys_fdatasync.patch
-improve-cd-dvd-packet-driver-write-performance.patch
-remove-eventpoll-macro-obfuscation.patch
-optimize-sys_times-for-a-single-thread-process.patch
-optimize-sys_times-for-a-single-thread-process-update.patch
-optimize-sys_times-for-a-single-thread-process-update-2.patch
-turn-off-sibling-call-optimization-w-frame-pointers.patch
-ipcsem-remove-superflous-decrease-variable-from-sys_semtimedop.patch
-e1000-numa-aware-allocation-of-descriptors-v2.patch
-gconfig-only-show-scrollbars-if-needed.patch
-potential-null-pointer-dereference-in-amiga-serial-driver.patch
-add-offseth-to-dontdiff.patch
-yenta-ti-turn-off-interrupts-during-card-power-on-more-2.patch
-compat-introduce-compat_time_t.patch
-cs4236-irq-handling-fix.patch
-block-add-unlocked_ioctl-support-for-block-devices.patch
-pcdp-handle-tables-that-dont-supply-baud-rate.patch
-remove-f_error-field-from-struct-file.patch
-use-drivers-kconfig-for-sparc32.patch
-acl-endianess-annotations.patch
-remove-linux-xattr_aclh.patch
-bug-in-error-recovery-in-fs-bufferc__block_prepare_write.patch
-dpt_i2o-waitqueue-fix.patch
-aio-fix-do_sync_readwrite-to-properly-handle-aio-retries.patch
-aio-make-wait_queue-task-private.patch
-add-note-about-verify_area-removal-to.patch
-ide-cd-reports-current-speed.patch
-pwc-uncompress-warning-fix.patch
-introduce-tty_unregister_ldisc.patch
-convert-users-to-tty_unregister_ldisc.patch
-ibmasm-driver-fix-command-buffer-size.patch
-ibmasm-driver-correctly-wake-up-sleeping-threads.patch
-ibmasm-driver-redesign-handling-of-remote-control.patch
-ibmasm-driver-redesign-handling-of-remote-control-fix.patch
-ibmasm-driver-fix-race-in-command-refcount-logic.patch
-autofs4-avoid-panic-on-bind-mount-of-autofs-owned-directory.patch
-autofs4-post-expire-race-fix.patch
-autofs4-bad-lookup-fix.patch
-autofs4-subversion-bump-to-identify-these-changes.patch
-pass-iocb-to-dio_iodone_t.patch
-reiserfs-add-checking-of-journal_begin-return-value.patch
-quota-improve-credits-estimates.patch
-quota-ext3-improve-quota-credit-estimates.patch
-quota-reiserfs-improve-quota-credit-estimates.patch
-xtensa-tensilica-xtensa-cpu-arch-maintainer-record.patch
-xtensa-architecture-support-for-tensilica-xtensa-part-1.patch
-xtensa-architecture-support-for-tensilica-xtensa-part-2.patch
-xtensa-architecture-support-for-tensilica-xtensa-part-3.patch
-xtensa-architecture-support-for-tensilica-xtensa-part-4.patch
-xtensa-architecture-support-for-tensilica-xtensa-part-5.patch
-xtensa-architecture-support-for-tensilica-xtensa-part-6.patch
-xtensa-architecture-support-for-tensilica-xtensa-part-7.patch
-xtensa-architecture-support-for-tensilica-xtensa-part-8.patch
-make-reiserfs-bug-on-too-big-transaction.patch
-ipmi-doc-updates-for-ipmi.patch
-ipmi-ipmi-timer-shutdown-cleanup.patch
-ipmi-add-ipmi-power-cycle-capability.patch
-ipmi-use-completions-not-semaphores-in-the-ipmi-powerdown-code.patch
-ipmi-add-32-bit-ioctl-translations-for-64-bit-platforms.patch
-char-tpm-use-msleep-clean-up-timers.patch
-fix-concerns-with-tpm-driver-use-enums.patch
-fix-tpm-driver-address-missing-const-defs.patch
-fix-tpm-driver-remove-unnecessary-module-stuff.patch
-fix-tpm-driver-read-return-code-issue.patch
-fix-tpm-driver-large-stack-objects.patch
-fix-tpm-driver-how-timer-is-initialized.patch
-fix-tpm-driver-use-to_pci_dev.patch
-fix-tpm-driver-remove-unnecessary-__force.patch
-fix-tpm-driver-sysfs-owernship-changes.patch
-fix-tpm-driver-sysfs-owernship-changes-fix.patch
-fix-tpm-driver-sysfs-owernship-changes-fix-2.patch
-fix-tpm-driver-sysfs-owernship-changes-fix-3.patch
-fix-tpm-driver-add-cancel-function.patch
-fix-tpm-driver-locks.patch
-tpm-support-for-tpms-on-additional-lpc-bus.patch
-tpm-support-for-tpms-on-additional-lpc-bus-fix-2.patch
-tpm-replace-odd-LPC-init-function.patch
-tpm-add-debugging-output.patch
-tpm-improve-output-in-sysfs-files-when-the-tpm-fails.patch
-i2o-bugfixes-and-compability-enhancements.patch
-i2o-first-code-cleanup-of-spare-warnings-and-unused.patch
-i2o-new-sysfs-attributes-and-adaptec-specific-block.patch
-i2o-new-sysfs-attributes-and-adaptec-specific-block-fix.patch
-i2o-new-sysfs-attributes-and-adaptec-specific-block-fix-fix.patch
-i2o-adaptec-specific-sg_io-access-firmware-access-through.patch
-i2o-second-code-cleanup-of-sparse-warnings-and-unneeded.patch
-i2o-lindent-run-and-replacement-of-printk-through-osm.patch
-i2o-limit-max-sector-workaround-for-promise-controllers.patch
-i2o-build-fix.patch
-i2o-device-attribute-fixes.patch
-drop-obsolete-dibusb-driver.patch
-add-generalized-dvb-usb-driver.patch
-add-generalized-dvb-usb-driver-fix-2.patch
-add-generalized-dvb-usb-driver-fix-3.patch
-add-generalized-dvb-usb-driver-fix-4.patch
-dvb-usb-fix-init-error-checking.patch
-dvb_frontend-use-time_after.patch
-flexcop-add-bcm3510-atsc-frontend-support-for-air2pc-card.patch
-flexcop-add-bcm3510-atsc-frontend-support-for-air2pc-card-fix.patch
-tuner-corec-improvments-and-ymec-tvision-tvf8533mf.patch
-dvb-documentation-fixes.patch
-oprofile-report-anonymous-region-samples.patch
-nfsd4-find_delegation_file.patch
-nfsd4-nfs4_check_delegmode.patch
-nfsd4-dont-reopen-for-delegated-client.patch
-nfsd4-add-open-state-code-for-claim_delegate_cur.patch
-nfsd4-support-claim_delegate_cur.patch
-nfsd4-fix-fh_expire_type.patch
-nfsd4-block-metadata-ops-during-grace-period.patch
-nfsd4-slabify-nfs4_files.patch
-nfsd4-slabify-stateids.patch
-nfsd4-slabify-delegations.patch
-nfsd4-remove-debugging-counters.patch
-nfsd4-rename-nfs4_file-fields.patch
-nfsd4-reference-count-struct-nfs4_file.patch
-lockd-flush-signals-on-shutdown.patch
-nfs4-hold-filp-while-reading-or-writing.patch
-nfsd4-fix-probe_callback.patch
-nfsd4-nfs4_check_open_reclaim-cleanup.patch
-nfsd4-create-separate-laundromat-workqueue.patch
-nfsd4-simplify-lease-changing.patch
-nfsd4-delegation-recovery.patch
-nfsd4-rename-nfs4_state_init.patch
-nfsd4-clean-up-state-initialization.patch
-nfsd4-remove-nfs4_reclaim_init.patch
-nfsd4-idmap-initialization.patch
-nfsd4-setclientid-simplification.patch
-nfsd4-reboot-hash.patch
-nfsd4-add-find_unconf_by_str-functions-to-simplify-setclientid.patch
-nfsd4-grace-period-end.patch
-nfsd4-make-needlessly-global-code-static.patch
-nfsd4-fix-uncomfirmed-list.patch
-nfsd4-fix-setclientid_confirm-cases.patch
-nfsd4-fix-setclientid_confirm-error-return.patch
-nfsd4-setclientid_confirm-gotoectomy.patch
-nfsd4-setclientid_confirm-comments.patch
-nfsd4-miscellaneous-setclientid_confirm-cleanup.patch
-nfsd4-rename-state-list-fields.patch
-nfsd4-allow-multiple-lockowners.patch
-nfsd4-remove-cb_parsed.patch
-nfsd4-initialize-recovery-directory.patch
-nfsd4-reboot-recovery.patch
-nfsd4-reboot-dirname.patch
-nfsacl-solaris-nfsacl-workaround.patch
-nfs-client-latencies.patch
-rock-lindent.patch
-rock-manual-tidies.patch
-rock-remove-CHECK_SP.patch
-rock-remove-CONTINUE_DECLS.patch
-rock-remove-CHECK_CE.patch
-rock-remove-SETUP_ROCK_RIDGE.patch
-rock-remove-MAYBE_CONTINUE.patch
-rock-remove-MAYBE_CONTINUE-fix.patch
-rock-comment-tidies.patch
-rock-lindent-rock-h.patch
-isofs-remove-debug-stuff.patch
-rock-handle-corrupted-directories.patch
-rock-rename-union-members.patch
-rock-handle-directory-overflows.patch
-rock-handle-directory-overflows-fix.patch
-isofs-show-hidden-files-add-granularity-for-assoc-hidden-files-flags.patch
-isofs-show-hidden-files-add-granularity-for-assoc-hidden-files-flags-tidy.patch
-isofs-show-hidden-files-add-granularity-for-assoc-hidden-files-flags-fix.patch
-sched2-cleanup-wake_idle.patch
-sched2-improve-load-balancing-pinned-tasks.patch
-sched2-reduce-active-load-balancing.patch
-sched2-fix-smt-scheduling-problems.patch
-sched2-fix-smt-scheduling-problems-fix.patch
-sched2-add-debugging.patch
-sched2-less-aggressive-idle-balancing.patch
-sched2-balance-timers.patch
-sched2-tweak-affine-wakeups.patch
-sched2-no-aggressive-idle-balancing.patch
-sched2-balance-on-fork.patch
-sched2-schedstats-update-for-balance-on-fork.patch
-sched2-sched-tuning.patch
-sched2-sched-tuning-fix.patch
-sched2-sched-domain-sysctl.patch
-sched-uninline-task_timeslice.patch
-sched-cleanup-context-switch-locking.patch
-sched-null-domains.patch
-sched-remove-degenerate-domains.patch
-sched-remove-degenerate-domains-fix.patch
-sched-multilevel-sbe-sbf.patch
-sched-rcu-domains.patch
-sched-rcu-domains-fix.patch
-sched-consolidate-sbe-sbf.patch
-sched-consolidate-sbe-sbf-fix-2.patch
-sched-consolidate-sbe-sbf-fix-3.patch
-sched-relax-pinned-balancing.patch
-sched-micro-optimize-task-requeueing-in-schedule.patch
-sched-changing-rt-priority-without-cap_sys_nice.patch
-dynamic-sched-domains-sched-changes.patch
-dynamic-sched-domains-sched-changes-fix.patch
-dynamic-sched-domains-cpuset-changes.patch
-dynamic-sched-domains-ia64-changes.patch
-v4l-saa7134-byteorder-fix.patch
-v4l-saa7134-mark-little-endian-ptr.patch
-video_cx88_dvb-must-select-dvb_cx22702.patch
-fix-for-cx88-cardsc-for-dvico-fusionhdtv-3-gold-q.patch
-bttv-support-for-adlink-rtv24-capture-card.patch
-bttv-support-for-adlink-rtv24-capture-card-tidy.patch
-bttv-support-for-adlink-rtv24-capture-card-more-tidy.patch
-v4l-saa7134-ntsc-vbi-fix.patch
-v4l-pal-m-chroma-subcarrier-frequency-fix.patch
-video-for-linux-docummentation.patch
-v4l-add-support-for-pixelview-ultra-pro.patch
-dvico-fusionhdtv3-gold-t-documentation-fix.patch
-v4l-support-tuner-thomson-ddt-7611-atsc-ntsc.patch
-bttv-update.patch
-v4l-cx88-cards-update.patch
-v4l-update-for-tuner-cards-and-some-chips.patch
-v4l-update-for-tuner-cards-and-some-chips-fix.patch
-v4l-update-for-saa7134-cards.patch
-v4l-update-for-saa7134-cards-fix.patch
-v4l-update-for-saa7134-cards-fix-2.patch
-gregkh-i2c-i2c-address_range_removal-v4l-fix.patch
-gregkh-i2c-i2c-address_range_removal-v4l-fix-fix.patch
-nfs-patch-for-fscache.patch
-nfs-patch-for-fscache-fixes.patch
-nfs-patch-for-fscache-warning-fix.patch
-x86-rename-apic_mode_exint.patch
-x86-local-apic-fix.patch
-x86_64-e820-64bit.patch
-x86-i8259-shutdown.patch
-x86_64-i8259-shutdown.patch
-x86-apic-virtwire-on-shutdown.patch
-x86_64-apic-virtwire-on-shutdown.patch
-vmlinux-fix-physical-addrs.patch
-x86-vmlinux-fix-physical-addrs.patch
-x86_64-vmlinux-fix-physical-addrs.patch
-kexec-x86_64-optimise-storage-of-read-mostly-variables-x86_64-fix.patch
-x86-config-kernel-start.patch
-kexec-reserve-bootmem-fix-for-booting-nondefault-location-kernel.patch
-x86_64-config-kernel-start.patch
-kexec-kexec-generic.patch
-kexec-kexec-generic-maintainers-fix.patch
-kexec-disable-preempt-in-panic.patch
-kexec-kexec-generic-fix.patch
-kexec-kexec-generic-kexec-use-unsigned-bitfield.patch
-x86-machine_shutdown.patch
-x86-kexec.patch
-x86-crashkernel.patch
-x86-crashkernel-fix.patch
-x86_64-machine_shutdown.patch
-x86_64-kexec.patch
-x86_64-kexec-build-fix.patch
-x86_64-crashkernel.patch
-kexec-ppc-support.patch
-kexec-ppc-fix-noret_type.patch
-ppc64-kexec-native-hash-clear.patch
-ppc64-kexec-support-for-ppc64.patch
-x86-crash_shutdown-nmi-shootdown.patch
-x86-crash_shutdown-snapshot-registers.patch
-x86-crash_shutdown-apic-shutdown.patch
-kexec-s390-support.patch
-s390-kexec-fixes.patch
-kdump-export-crash-notes-section-address-through.patch
-kdump-export-crash-notes-section-address-through-x86_64-fix.patch
-kdump-nmi-handler-segment-selector-stack.patch
-kexec-kexec-on-panic-fix-with-nmi-watchdog-enabled.patch
-kdump-documentation-for-kdump.patch
-kdump-documentation-for-kdump-update.patch
-kdump-documentation-for-kdump-update-fix.patch
-kdump-documentation-update-to-add-gdb-macros.patch
-kdump-retrieve-saved-max-pfn.patch
-kdump-kconfig-for-kdump.patch
-kdump-routines-for-copying-dump-pages.patch
-kdump-retrieve-elfcorehdr-address-from-command.patch
-kdump-access-dump-file-in-elf-format.patch
-kdump-parse-elf32-headers-and-export-through.patch
-kdump-accessing-dump-file-in-linear-raw-format.patch
-kdump-cleanups-for-dump-file-access-in-linear.patch
-kdump-sysrq-trigger-mechanism-for-kexec-based-crashdumps.patch
-kdump-use-real-pt_regs-from-exception.patch
-kdump-use-real-pt_regs-from-exception-fix.patch
-kdump-use-real-pt_regs-from-exception-fix-fix.patch
-kdump-save-trap-information-for-later-analysis.patch
-kexec-code-cleanup.patch
-serial-eliminate-magic-numbers.patch
-bring-back-tux-on-chips-65550-framebuffer.patch
-s1d13xxxfb-linkage-fix.patch
-some-vesafb-fixes.patch
-intelfbdrv-naming-fix.patch
-fbdev-iomove-removal.patch
-pm3fb-typo-fix.patch
-vga-to-fbcon-fix.patch
-intelfb-add-voffset-option-to-avoid-conficts-with-xorg-i810-driver.patch
-intelfb-add-voffset-option-to-avoid-conficts-with-xorg-i810-driver-fix.patch
-intelfb-fix-accel-detection-when-changing-video-modes.patch
-intelfb-documentation.patch
-intelfb-documentation-fix.patch
-framebuffer-driver-for-arc-lcd-board.patch
-framebuffer-driver-for-arc-lcd-board-tidy.patch
-framebuffer-driver-for-arc-lcd-board-update.patch
-new-pci-id-for-chipsfb.patch
-new-framebuffer-fonts-updated-12x22-font-available.patch
-fbdev-stack-reduction.patch
-fbdev-fill-in-the-access_align-field.patch
-md-cause-md-raid1-to-repack-working-devices-when-number-of-drives-is-changed.patch
-md-make-sure-recovery-happens-when-add_new_disk-is-used-for-hot_add.patch
-md-merge-md_enter_safemode-into-md_check_recovery.patch
-md-improve-locking-on-safemode-and-move-superblock-writes.patch
-md-improve-the-interface-to-sync_request.patch
-md-optimised-resync-using-bitmap-based-intent-logging.patch
-md-optimised-resync-using-bitmap-based-intent-logging-mempool-fix.patch
-md-a-couple-of-tidyups-relating-to-the-bitmap-file.patch
-md-call-bitmap_daemon_work-regularly.patch
-md-print-correct-pid-for-newly-created-bitmap-writeback-daemon.patch
-md-minor-code-rearrangement-in-bitmap_init_from_disk.patch
-md-make-sure-md-bitmap-is-cleared-on-a-clean-start.patch
-md-printk-fix.patch
-md-improve-debug-printing-of-bitmap-superblock.patch
-md-check-return-value-of-write_page-rather-than-ignore-it.patch
-md-enable-the-bitmap-write-back-daemon-and-wait-for-it.patch
-md-dont-skip-bitmap-pages-due-to-lack-of-bit-that-we-just-cleared.patch
-md-optimised-resync-using-bitmap-based-intent-logging-fix.patch
-md-raid1-support-for-bitmap-intent-logging.patch
-md-fix-bug-when-raid1-attempts-a-partial-reconstruct.patch
-md-raid1-support-for-bitmap-intent-logging-fix.patch
-md-optimise-reconstruction-when-re-adding-a-recently-failed-drive.patch
-md-fix-deadlock-due-to-md-thread-processing-delayed-requests.patch
-md-allow-md-intent-bitmap-to-be-stored-near-the-superblock.patch
-md-allow-md-to-update-multiple-superblocks-in-parallel.patch
-md-allow-md-to-update-multiple-superblocks-in-parallel-fix.patch
-md-two-small-fixes-for-md-verion-1-superblocks.patch
-md-dont-skip-bitmap-pages-due-to-lack-of-bit-that-we-just-cleared-fix.patch
-md-remove-unneeded-null-checks-before-kfree.patch
-modules-add-version-and-srcversion-to-sysfs.patch
-modules-add-version-and-srcversion-to-sysfs-fix.patch
-modules-add-version-and-srcversion-to-sysfs-fix-2.patch
-modules-add-version-and-srcversion-to-sysfs-fix-3.patch
-detect-atomic-counter-underflows.patch
-docbook-build-fix.patch
-docbook-only-use-tabular-style-for-long-synopsis.patch
-docbook-update-comments.patch
-xip-bdev-execute-in-place-3rd-version.patch
-xip-fs-mm-execute-in-place-3rd-version.patch
-xip-fs-mm-execute-in-place-3rd-version-fix.patch
-xip-ext2-execute-in-place-3rd-version.patch
-xip-ext2-execute-in-place-3rd-version-fixes.patch
-xip-reduce-code-duplication.patch
-xip-madvice-fadvice-execute-in-place-3rd-version.patch
-xip-description.patch
-drivers-media-video-tvaudioc-make-some-variables-static.patch
-kernel-irq-spuriousc-make-a-function-static.patch
-kernel-power-swsuspc-make-a-variable-static.patch
-kernel-modulec-make-a-function-static.patch
-fs-reiserfs-streec-make-max_key-static.patch
-make-umount_tree-static.patch
-scsi-make-code-static.patch
-drivers-media-common-saa7146_fopsc-make-a-function-static.patch
-net-sctp-make-two-functions-static.patch
-drivers-isdn-sc-possible-cleanups.patch
-drivers-isdn-pcbit-possible-cleanups.patch
-drivers-isdn-i4l-possible-cleanups.patch
-unexport-mca_find_device_by_slot.patch
-drivers-isdn-hardware-avm-misc-cleanups.patch
-drivers-isdn-act2000-capic-if-0-an-unused-function.patch
-x86-64-add-memcpy-memset-prototypes.patch
-au1100fb-convert-to-c99-inits.patch
-riottyc-cleanups-and-warning-fix.patch
-char-ds1620-use-msleep-instead-of-schedule_timeout.patch
-char-tty_io-replace-schedule_timeout-with-msleep_interruptible.patch
-kernel-timer-fix-msleep_interruptible-comment.patch
-init-do_mounts_initrdc-fix-sparse-warning.patch
-arch-i386-kernel-trapsc-fix-sparse-warnings.patch
-arch-i386-kernel-apmc-fix-sparse-warnings.patch
-arch-i386-mm-faultc-fix-sparse-warnings.patch
-arch-i386-crypto-aesc-fix-sparse-warnings.patch
-small-partitions-msdos-cleanups.patch
-remove-redundant-null-check-before-before-kfree-in.patch
-get-rid-of-redundant-null-checks-before-kfree-in-arch-i386.patch
-remove-redundant-null-checks-before-kfree-in-sound-and.patch
-drivers-scsi-initioc-cleanups.patch
-dont-do-pointless-null-checks-and-casts-before-kfree.patch
-drivers-char-isicomc-section-fixes.patch
-sound-oss-cleanups.patch
-sound-oss-cleanups-fix.patch
-sound-oss-rme96xxc-remove-kernel-22-ifs.patch
-drivers-char-mwave-tp3780ic-remove-kernel-22-ifs.patch
-serial-icom-remove-custom-msescs_to_jiffies-macro.patch
-printk-drivers-char-applicomc.patch
-printk-drivers-char-ftape-compressor-zftape-compressc.patch
-lib-sha1c-fix-sparse-warning.patch
-x86_64-coding-style-and-whitespace-fixups.patch
-use-align-to-remove-duplicate-code.patch
-cosmetic-fixes-for-example-programs-in-documentation-cdrom-sbpcd.patch
-drivers-scsi-dpt-remove-versionh-dependencies.patch
-sound-oss-sscapec-remove-dead-code.patch
-drivers-char-istallionc-remove-an-unneeded-variable.patch
-drivers-char-mwave-3780ic-cleanups.patch
-drivers-char-nvramc-possible-cleanups.patch
-drivers-char-rocketc-cleanups.patch
-fs-jffs-cleanups.patch
-fs-ncpfs-remove-unused-ifdef-use_old_slow_directory_listing-code.patch
-drivers-block-sx8c-remove-unused-code.patch
-drivers-video-matrox-matroxfb_miscc-remove-dead-code.patch
-drivers-char-mwave-tp3780ic-remove-dead-code.patch
-drivers-block-ll_rw_blkc-cleanups.patch
-change-the-sound_prime-handling.patch
-i386-cleanup-boot_cpu_logical_apicid-variables.patch
-update-computone-maintainers-entry.patch
-remove-pointless-null-check-before-kfree-in-sony535c.patch
-kfree-cleanups-in-ixjc.patch
-kfree-cleanups-for-drivers-firmware.patch
-drivers-char-ip2-cleanups.patch
-drivers-cdrom-cm206c-cleanups.patch
-drivers-isdn-hisax-possible-cleanups.patch
-ll_merge_requests_fn-cleanup.patch
-update-comment-about-gzip-scratch-size.patch
-kill-signed-chars.patch
-printk-arch-i386-mm-pgtablec.patch
-printk-arch-i386-mm-ioremapc.patch
-sound-oss-esssolo1-use-the-dma_32bit_mask-constant.patch
-sound-oss-es1371-use-the-dma_32bit_mask-constant.patch
-sound-oss-es1370-use-the-dma_32bit_mask-constant.patch
-sound-oss-cmpci-use-the-dma_32bit_mask-constant.patch
-remove-duplicate-file-in-documentation-networking-drivers_net_wan_kconfig.patch
-remove-duplicate-file-in-documentation-networking-00-index.patch
-remove-duplicate-file-in-documentation-networking.patch
-remove-redundant-info-from-submittingpatches.patch

 Merged

-aic79xx-deadlock-fix.patch
-aic79xx-deadlock-fix-2.patch
-aic79xx-deadlock-fix-3.patch

 Dropped - it was fixed differently.

+jffs2-build-fix.patch
+arm-swsusp-build-fix.patch

 Fix damage from recent swsusp cleanups

-ia64-disable-preempt.patch

 Dropped: unneeded

+alsa-maestro3-div-by-zero-fix.patch

 Revert an alsa change which appears to cause a divide-by-zero.

-gregkh-driver-driver-name-const-01.patch
-gregkh-driver-driver-name-const-02.patch
-gregkh-driver-driver-name-const-03.patch
-gregkh-driver-driver-name-const-04.patch
-gregkh-driver-driver-name-const-05.patch
-gregkh-driver-driver-name-const-06.patch
-gregkh-driver-sysfs-show_store_eio-01.patch
-gregkh-driver-sysfs-show_store_eio-02.patch
-gregkh-driver-sysfs-show_store_eio-03.patch
-gregkh-driver-sysfs-show_store_eio-04.patch
-gregkh-driver-sysfs-show_store_eio-05.patch
-gregkh-driver-class-01-core.patch
-gregkh-driver-class-02-tty.patch
-gregkh-driver-class-03-input.patch
-gregkh-driver-class-04-usb.patch
-gregkh-driver-class-05-sound.patch
-gregkh-driver-class-06-block.patch
-gregkh-driver-class-07-char.patch
-gregkh-driver-class-08-ieee1394.patch
-gregkh-driver-class-09-scsi.patch
-gregkh-driver-class-10-arch.patch
-gregkh-driver-class-11-drivers.patch
-gregkh-driver-class-11-drivers-usb-fix.patch
-gregkh-driver-class-12-the_rest.patch
-gregkh-driver-class-13-kerneldoc.patch
-gregkh-driver-class-14-no_more_class_simple.patch
-gregkh-driver-fix-make-mandocs-after-class_simple-removal.patch
-gregkh-driver-ipmi-class_simple-fixes.patch
-gregkh-driver-klist-01.patch
-gregkh-driver-klist-02.patch
-gregkh-driver-klist-03.patch
-gregkh-driver-klist-04.patch
-gregkh-driver-klist-05.patch
-gregkh-driver-klist-06.patch
-gregkh-driver-klist-07.patch
-gregkh-driver-klist-08.patch
-gregkh-driver-klist-09.patch
-gregkh-driver-klist-10.patch
-gregkh-driver-klist-11.patch
-gregkh-driver-klist-12.patch
-gregkh-driver-klist-13.patch
-gregkh-driver-klist-14.patch
-gregkh-driver-klist-15.patch
-gregkh-driver-klist-16.patch
-gregkh-driver-klist-17.patch
-gregkh-driver-klist-18.patch
-gregkh-driver-klist-scsi-01.patch
-gregkh-driver-klist-scsi-02.patch
-gregkh-driver-klist-20.patch
-gregkh-driver-klist-21.patch
-gregkh-driver-klist-22.patch
-gregkh-driver-klist-23.patch
-gregkh-driver-klist-ieee1394.patch
-gregkh-driver-klist-pcie.patch
-gregkh-driver-klist-24.patch
-gregkh-driver-klist-25.patch
-gregkh-driver-klist-26.patch
-gregkh-driver-klist-usb_node_attached_fix.patch
-gregkh-driver-klist-sn_fix.patch
-gregkh-driver-klist-driver_detach_fixes.patch
-gregkh-driver-klist-usbcore-dont_call_device_release_driver_recursivly.patch
-gregkh-driver-driver-create-unregister_node.patch
-gregkh-driver-driver-model-documentation-update.patch
-gregkh-driver-libfs-add-simple-attribute-files.patch
-gregkh-driver-driver-fix-error-handling-in-bus_add_device.patch
-gregkh-driver-driver-device_attr-01.patch
-gregkh-driver-driver-device_attr-02.patch
-gregkh-driver-driver-device_attr-03.patch
-gregkh-driver-driver-device_attr-04.patch
-gregkh-driver-driver-device_attr-05.patch
-gregkh-driver-driver-device_attr-06.patch
-gregkh-driver-driver-device_attr-07.patch
-gregkh-driver-driver-device_attr-08.patch
-gregkh-driver-driver-device_attr-09.patch
-gregkh-driver-driver-device_attr-10.patch
-gregkh-driver-driver-device_attr-11.patch
-gregkh-driver-driver-device_attr-12.patch
-gregkh-driver-driver-device_attr-i2c-sysfs.h.patch
-gregkh-driver-driver-device_attr-i2c-adm1026.patch
-gregkh-driver-sysfs-permissions-01.patch
-gregkh-driver-sysfs-permissions-02.patch
-gregkh-driver-sysfs-permissions-03.patch
-gregkh-driver-dont-loose-devices-on-suspend-failure.patch
-gregkh-driver-sysfs-page_size-check.patch
+gregkh-driver-driver-bus_find_device.patch
+gregkh-driver-driver-unbind.patch
+gregkh-driver-driver-bind.patch
+gregkh-driver-driver-bus_rescan_devices-nocount.patch

 Greg's driver core tree

-gregkh-i2c-i2c-address_range_removal.patch
-gregkh-i2c-i2c-address_merge_video.patch
-gregkh-i2c-i2c-rtc8564_duplicate_include.patch
-gregkh-i2c-i2c-vid_h.patch
-gregkh-i2c-i2c-atxp1.patch
-gregkh-i2c-i2c-atxp1-cleanup.patch
-gregkh-i2c-i2c-ds1337-01.patch
-gregkh-i2c-i2c-ds1337-02.patch
-gregkh-i2c-i2c-ds1337-03.patch
-gregkh-i2c-i2c-ds1337_make_time_format_consistent.patch
-gregkh-i2c-i2c-ds1337_i2c_transfer_check.patch
-gregkh-i2c-i2c-ds1337_search_by_bus_number.patch
-gregkh-i2c-i2c-ds1337-config-update.patch
-gregkh-i2c-i2c-ds1337-export-ds1337_do_command.patch
-gregkh-i2c-i2c-config_cleanup-01.patch
-gregkh-i2c-i2c-config_cleanup-02.patch
-gregkh-i2c-i2c-adm9240.patch
-gregkh-i2c-i2c-w83627ehf.patch
-gregkh-i2c-i2c-w83627ehf-cleanup.patch
-gregkh-i2c-i2c-smsc47m1.patch
-gregkh-i2c-i2c-spelling_fixes.patch
-gregkh-i2c-i2c-mpc-share_interrupt.patch
-gregkh-i2c-i2c-remove_redundancy_from_i2c_core.patch
-gregkh-i2c-i2c-remove_delay_h_from_via686a.patch
-gregkh-i2c-i2c-w83627hf-fan-divisor-fix.patch
-gregkh-i2c-i2c-rename-cpu0_vid.patch
-gregkh-i2c-i2c-adm9240-cleanup.patch
-gregkh-i2c-i2c-jiffies.h.patch
-gregkh-i2c-i2c-macro-abuse-cleanup.patch
-gregkh-i2c-i2c-via686a-code-cleanup.patch
-gregkh-i2c-i2c-adm1021-remove_die_code.patch
-gregkh-i2c-i2c-Kconfig-corrections.patch
-gregkh-i2c-i2c-macro-abuse-cleanup-via686a.patch
-gregkh-i2c-i2c-driver-device_attr-fixup.patch
-gregkh-i2c-i2c-spelling-fixes-more-01.patch
-gregkh-i2c-i2c-spelling-fixes-more-02.patch
-gregkh-i2c-i2c-spelling-fixes-more-03.patch
-gregkh-i2c-i2c-spelling-fixes-more-04.patch
-gregkh-i2c-i2c-mpc-race-fix.patch
-gregkh-i2c-i2c-mailing-list-move.patch
-gregkh-i2c-i2c-tps6501x.patch
-gregkh-i2c-i2c-docs-update-1.patch
-gregkh-i2c-i2c-docs-update-2.patch
-gregkh-i2c-i2c-docs-update-3.patch
-gregkh-i2c-i2c-Kconfig-update.patch
-gregkh-i2c-i2c-pcf8574-cleanup.patch
-gregkh-i2c-i2c-adm9240-docs.patch
-gregkh-i2c-i2c-device-attr-lm90.patch
-gregkh-i2c-i2c-device-attr-lm83.patch
-gregkh-i2c-i2c-device-attr-lm63.patch
-gregkh-i2c-i2c-device-attr-it87.patch
-gregkh-i2c-i2c-max6875.patch
-gregkh-i2c-i2c-rename-i2c-sysfs.patch
-gregkh-i2c-i2c-pca9539.patch
-gregkh-i2c-i2c-ds1374-01.patch
-gregkh-i2c-i2c-ds1374-02.patch
-gregkh-i2c-i2c-ds1374-03.patch
-gregkh-i2c-i2c-w83781d-remove-non-i2c-chips.patch
-gregkh-i2c-w1-ds18xx_sensors.patch
-gregkh-i2c-w1-new_rom_family.patch
-gregkh-i2c-w1-cleanups.patch
-gregkh-i2c-w1-new-family-structure.patch
-gregkh-i2c-w1-build-fixups.patch
-gregkh-i2c-w1-remove-dup-family-id.patch
-gregkh-i2c-w1-01.patch
-gregkh-i2c-w1-02.patch
-gregkh-i2c-w1-03.patch
-gregkh-i2c-w1-04.patch
-gregkh-i2c-w1-05.patch
-gregkh-i2c-w1-06.patch
-gregkh-i2c-w1-07.patch

 Greg's i2c tree

+i2c-new-max6875-driver-may-corrupt-eeproms.patch

 i2c eeprom corruption fix

+git-libata-adma-mwi.patch
+git-libata-chs-support.patch
+git-libata-passthru.patch
+git-libata-promise-sata-pata.patch

 Bring these libata trees back

+samsung-sn-124-works-perfectly-well-with-dma-on-sata-too.patch

 SATA fix

+git-netdev-janitor-fixup.patch

 Fix rejects in git-netdev-janitor.patch

+ipw2100-remove-by-hand-function-entry-exit-debugging.patch
+ipw2100-remove-commented-out-code.patch
+pcnet_csc-irq-handler-optimization.patch
+is_multicast_ether_addr-hack.patch
+wireless-device-attr-fixes.patch
+wireless-device-attr-fixes-2.patch
+ipw2100-old-gcc-fix.patch

 Various netdev fixups

-git-ocfs.patch
+git-ocfs2.patch

 Renamed this patch

+gregkh-pci-pci-fix-drivers-setting-shutdown.patch

 Addition to Greg's PCI tree

+gregkh-pci-pci-assign-unassigned-resources-fix.patch

 Try to fix it

+revert-gregkh-pci-pci-assign-unassigned-resources.patch

 Revert a bad patch in it

+pci-yenta-cardbus-fix.patch

 Try to fix the `resource 0 busy, reconfiguring...' bug

+git-scsi-block.patch
+git-scsi-block-fix.patch

 New git tree (James Bottomley)

+scsi-ahc_target_state-check-starget-valid.patch

 adaptec driver fix

-gregkh-usb-usb-driver-device_attr-fixup.patch
+gregkh-usb-usb-storage-port-reset-on-transport-error.patch

 Changes in Greg's USB tree.

-swapspace-layout-improvements.patch

 Dropped again.  Reasonable idea, no net benefit observable, not anough time
 to work on it, gets in the way.

+mm-consolidate-get_order.patch

 clean up the get_order() implementations

-proc-pid-smaps-fix.patch
-proc-pid-smaps-tidy.patch
-proc-pid-smaps-fix-fix.patch

 Folded into proc-pid-smaps.patch

+ppp-handle-misaligned-accesses.patch
+ipvs-add-and-reorder-bh-locks-after-moving-to-keventd.patch
+ipvs-close-race-conditions-on-ip_vs_conn_tab-list-modification.patch
+ipvs-close-race-conditions-on-ip_vs_conn_tab-list-modification-fix.patch
+zatm-kfree-fix.patch

 Various net fixes

-cs89x0c-support-for-philips-pnx0105-network-adapter-tidy.patch

 Folded into cs89x0c-support-for-philips-pnx0105-network-adapter.patch

+silence-cs89x0.patch

 Kill a printk

+x86-i8253-i8259a-lock-cleanup.patch

 x86 code cleanup

+seccomp-tsc-disable.patch

 Disable tsc on processes which are running under seccomp

-mempool-bounce-buffer-restriction.patch

 Not sure that I'll merge this - the problem is real but this implementation
 is perhaps not the best wrt SMP scalability.

+add-suspend-resume-for-timer.patch

 Add suspend and resume support for x86 timers

+cris-update-1-17-arch-split.patch
+cris-update-2-17-configuration-and-build.patch
+cris-update-3-17-console.patch
+cris-update-4-17-debug.patch
+cris-update-5-17-drivers.patch
+cris-update-6-17-i-o-and-dma-allocator.patch
+cris-update-7-17-irq.patch
+cris-update-8-17-misc-patches.patch
+cris-update-9-17-mm.patch
+cris-update-10-17-pci.patch
+cris-update-11-17-profiler.patch
+cris-update-12-17-serial-port-driver.patch # rmk said no
+cris-update-13-17-smp.patch
+cris-update-14-17-synchronous-serial-port-driver.patch
+cris-update-15-17-updates-for-2612.patch
+cris-update-16-17-usb.patch
+cris-update-17-17-new-subarchitecture-v32.patch

 arch/cris updates

+uml-kill-some-useless-vmalloc-tlb-flushing.patch
+uml-remove-winch-sem.patch # "keep in -mm"

 uml updates

-detect-soft-lockups-smp_processor_id-cleanup-fix.patch
-detect-soft-lockups-from-touch_nmi_watchdog.patch
-kernel-softlockup-fix-usage-of-msleep_interruptible.patch
-turn-soft-lock-off-when-panicking.patch

 Folded into detect-soft-lockups.patch

-relayfs-properly-handle-oversized-events.patch
-relayfs-backing_dev-fix.patch

 Folded into relayfs.patch

+relayfs-cancel-work-on-close-reset.patch
+relayfs-add-private-data-to-channel-struct.patch
+relayfs-function-docfix.patch
+relayfs-add-relayfs-website-to-documentation.patch

 relayfs fixes

-fix-of-dcache-race-leading-to-busy-inodes-on-umount-fix.patch
-fix-of-dcache-race-leading-to-busy-inodes-on-umount-tidy.patch

 Folded into fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch

+using-msleep-instead-of-hz.patch
+using-msleep-instead-of-hz-fix.patch
+using-msleep-instead-of-hz-fix-2.patch

 cleanup

+new-driver-for-yealink-usb-p1k-phone.patch
+new-driver-for-yealink-usb-p1k-phone-tidy.patch
+new-driver-for-yealink-usb-p1k-phone-fixes.patch
+new-driver-for-yealink-usb-p1k-phone-warning-sysfs-fixes.patch
+yealink-maintainer.patch

 USB phone driver

+usb-makefile-update-for-sisusbvga.patch

 USB fix

+drivers-char-tiparc-off-by-one-array-access.patch

 tipar.c fix

+ixp4xx-ixp2000-watchdog-driver-typo.patch

 Fix typos in two watchdog drivers

+de_thread-eliminate-unneccessary-sighand-locking.patch

 Locking simplification

+pselect-ppoll-system-calls.patch
+pselect-ppoll-system-calls-tidy.patch
+pselect-ppoll-system-calls-fix.patch
+pselect-ppoll-system-calls-sigset_t-fix-2.patch

 pselect() and ppoll() (the case seems thin)

+itimer_real-fix-possible-deadlock-and-race.patch

 itimer deadlock fix

+pcie-acpi-tg3-ethernet-not-coming-back-properly-after-s3-suspendon-dellm70.patch

 pcie power management fix

+adapt-drivers-char-vt_ioctlc-to-non-x86.patch

 Don't use a hardwired number for clock speed

+request_firmware-avoid-race-conditions.patch

 request_firmware() fixes

+yenta-make-topic95-bridges-work-with-16bit-cards.patch

 cardbus fix

+smsc-ircc2-whitespace-fixes.patch
+smsc-ircc2-formatting-fixes.patch
+smsc-ircc2-drop-dim-macro-in-favor-of-array_size.patch
+smsc-ircc2-remove-typedefs.patch
+smsc-ircc2-dont-pass-iobase-around.patch
+smsc-ircc2-add-to-sysfs-as-platform-device-new-pm.patch
+smsc-ircc2-pm-cleanup-do-not-close-device-when-suspending.patch
+smsc-ircc2-pm-cleanup-do-not-close-device-when-suspending-fixes.patch
+smsc-ircc2-use-netdev_priv.patch
+smsc-ircc2-dont-use-void-where-specific-type-will-do.patch

 irda driver updates

+ib-mthca-add-sun-copyright-notice.patch
+ib-mthca-clean-up-error-messages.patch
+ib-mthca-clean-up-cq-debug.patch
+ib-mthca-use-dma_alloc_coherent-instead-of-pci_alloc_consistent.patch
+ib-mthca-set-qp-static-rate-correctly.patch
+ib-mthca-set-rdma-atomic-capabilities-correctly.patch
+ib-mthca-enable-unreliable-connected-transport.patch
+ib-mthca-fix-memset-size.patch
+ib-mthca-move-mthca_is_memfree-checks.patch
+ib-mthca-split-off-mtt-allocation.patch
+ib-mthca-fix-memory-leak-on-error-path.patch
+ib-mthca-encapsulate-command-interface-init.patch
+ib-mthca-align-fw-command-mailboxes-to-4k.patch
+ib-mthca-bump-version.patch
+ib-fix-race-in-sa_query.patch
+ib-fix-pack-unpack-when-size_bits-==-64.patch
+maintainers-update-roland-dreiers-email.patch

 Infiniband updates

+cciss-26-pci-id-fix.patch
+cciss-26-pci-domain-info-pass-2.patch
+cciss-26-remove-partition-info-from-cciss_getluninfo.patch
+cciss-26-remove-partition-info-from-cciss_getluninfo-fix.patch

 cciss fixes

+headers-enable-ppc64-___arch__swab16-and-___arch__swab32.patch
+headers-include-linux-compilerh-for-__user.patch
+headers-include-linux-typesh-for-usb_ch9h.patch

 Header file cleanups

+coverity-i386-build-negative-return-to-unsigned-fix.patch
+coverity-i386-scsi_lib-buffer-overrun-fix.patch
+coverity-fs-udf-namei-null-check.patch
+coverity-fs-ext3-super-match_int-return-check.patch
+coverity-desc-bitmap-overrun-fix.patch
+coverity-tty_ldisc_ref-return-null-check.patch

 Various fixes found by the Coverity checker.

+kprobes-fix-single-step-out-of-line-take2.patch
+return-probe-redesign-architecture-independant-changes.patch
+return-probe-redesign-i386-specific-changes.patch
+return-probe-redesign-x86_64-specific-changes.patch
+return-probe-redesign-ia64-specific-implementation.patch
+return-probe-redesign-ppc64-specific-implementation.patch
+kprobes-ia64-refuse-inserting-kprobe-on-slot-1.patch
+kprobes-ia64-refuse-kprobe-on-ivt-code.patch

 kprobes updates

-rapidio-support-core-base-rapidio-support-core-base.patch

 Folded into rapidio-support-core-base.patch

-rapidio-support-ppc32-fix.patch
-rapidio-support-ppc32-add-error-checking-to-mpc85xx.patch

 Folded into rapidio-support-ppc32.patch

-dlm-lockspaces-callbacks-directory-dlm-consistent-ifdefs.patch
-dlm-lockspaces-callbacks-directory-build-fix.patch
-dlm-lockspaces-callbacks-directory-fix.patch
-dlm-lockspaces-callbacks-directory-fix-2.patch
-dlm-lockspaces-callbacks-directory-fix-2-dlm-dont-repeat-include.patch
-dlm-lockspaces-callbacks-directory-fix-3.patch
-dlm-lockspaces-callbacks-directory-dlm-dont-free-lvb-twice.patch

 Folded into dlm-lockspaces-callbacks-directory.patch

-dlm-communication-dlm-dont-add-duplicate-node-addresses.patch

 Folded into dlm-communication.patch

-dlm-recovery-dlm-timer-cant-be-global.patch
-dlm-recovery-dlm-clear-recovery-flags.patch

 Folded into dlm-recovery.patch

-dlm-device-interface-fix.patch
-dlm-device-interface-dlm-uncomment-unregister_lockspace.patch
-dlm-device-interface-dlm-newline-in-printks.patch

 Folded into dlm-device-interface.patch

-dlm-debug-fs-no-debug-build-fix.patch
-dlm-debug-fs-dlm-consistent-ifdefs.patch

 Folded into dlm-debug-fs.patch

-connector-warning-fixes.patch
-connector-export-initialization-flag.patch
-connector-netlink-id-fix.patch
-connector-remove-socket-number-parameter.patch

 Folded into connector.patch

-connector-add-a-fork-connector-build-fix.patch
-fork-connector-send-status-to-userspace.patch
-fork-connector-send-status-to-userspace-fix.patch

 Folded into connector-add-a-fork-connector.patch

+connector-add-a-fork-connector-use-after-free-fix.patch

 Fix connector-add-a-fork-connector.patch

+inotify-faq-fds.patch

 Update the inotify FAQ

-ext3-reduce-allocate-with-reservation-lock-latencies-tidy.patch

 Folded into ext3-reduce-allocate-with-reservation-lock-latencies.patch

-pcmcia-allow-function-id-based-match-fix.patch

 Folded into pcmcia-allow-function-id-based-match.patch

+pcmcia-id_table-for-ide_csc-update.patch
+pcmcia-more-ids-for-tdk-multifunction-cards.patch

 More pcmcia ID tables

-pcmcia-mark-parent-bridge-windows-as-resources-available-for-pcmcia-devices-fix.patch

 Folded into pcmcia-mark-parent-bridge-windows-as-resources-available-for-pcmcia-devices.patch

-pcmcia-move-pcmcia-ioctl-to-a-separate-file-fix.patch

 Folded into pcmcia-move-pcmcia-ioctl-to-a-separate-file.patch

-pcmcia-clean-up-cs-ds-callback-fix.patch

 Folded into pcmcia-clean-up-cs-ds-callback.patch

+pcmcia-8-and-16-bit-access-for-static_map.patch
+pcmcia-export-modalias-in-sysfs.patch

 pcmcia fixes

+nfs-fix-client-oops-when-debugging-is-on.patch
+ingo-nfs-stuff.patch
+xdr-input-validation.patch

 nfs fixes

+spinlock-consolidation.patch
+spinlock-consolidation-parisc-build-fixes.patch
+spinlock-consolidation-sparc64-fix.patch

 Clean up the spinlock code

-kgdb-move-config-option-for-bad_syscall_exit.patch
-kgdb-fix-bad_syscall_exit-lockup.patch
-kgdb-x86-config_debug_info-fix.patch

 Folded into kgdb-ga.patch

-kgdb-x86_64-support-fix.patch
-kgdb-x86_64-config_debug_info-fix.patch

 Folded into kgdb-x86_64-support.patch

-numa-aware-slab-allocator-v3-__bad_size-fix.patch

 Folded into numa-aware-slab-allocator-v5.patch

+numa-aware-slab-allocator-unifdeffery.patch

 Reduce ifdefs in numa-aware-slab-allocator-v5.patch

+iteraid-fix-trivial-sparse-warnings.patch
+iteraid-misc-trivial-cleanups.patch
+iteraid-remove-home-grown-memmove.patch
+iteraid-memset-fix.patch

 Fixes against iteraid.patch

-silence-spinlock-rwlock-uninitialized-break_lock-member.patch

 Dropped - lots of rejects and might no longer be needed and I'm not very
 interested in `gcc -W' fixes.

-nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus-fix.patch

 Folded into nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch

-perfctr-ppc64-wraparound-fixes.patch
-perfctr-x86-update-with-k8-multicore-fixes-take-2.patch
-perfctr-seqlocks-for-mmaped-state-common.patch
-perfctr-seqlocks-for-mmaped-state-x86.patch
-perfctr-seqlocks-for-mmaped-state-ppc64.patch
-perfctr-seqlocks-for-mmaped-state-ppc32.patch

 Folded into perfctr.patch

+perfctr-handle-non-of-ppc32-platforms.patch

 perfctr update

+sched-tweak-idle-thread-setup-semantics.patch
+sched-run-sched_normal-tasks-with-real-time-tasks-on-smt-siblings.patch
+max_user_rt_prio-and-max_rt_prio-are-wrong.patch
+sched-idlest-cpus_allowed-aware.patch
+sched-cleanups.patch
+sched-task_noninteractive.patch
+scheduler-cache-hot-autodetect.patch # needs work
+scheduler-cache-hot-autodetect-section-fix.patch
+scheduler-cache-hot-autodetect-x86-cpu_khz-type-fix.patch
+scheduler-cache-hot-autodetect-x86-cpu_khz-type-fix-2.patch
+sched-add-cacheflush-asm.patch
+sched-add-cacheflush-asm-2.patch
+sched-add-cacheflush-asm-2-ia64-fix.patch
+scheduler-cache-hot-autodetect-build-fix.patch
+sched-fix-smt-scheduler-latency-bug.patch

 scheduler stuff

+v4l-maintainer-patch.patch
+v4l-tuner-improvements.patch
+v4l-bttv-new-insmod-parameters.patch
+v4l-api-new-webcam-formats-included.patch
+v4l-documentation-changes-mostly-new-cards-included.patch

 v4l updates

-allow-x86_64-to-reenable-interrupts-on-contention.patch

 Dropped - it had rejects and Andi didn't like it anyway.

-numa-policies-for-file-mappings-mpol_mf_move-cachefs.patch
-cachefs-release-search-records-lest-they-return-to-haunt-us.patch
-fix-64-bit-problems-in-cachefs.patch
-cachefs-fixed-typos-that-cause-wrong-pointer-to-be-kunmapped.patch
-cachefs-return-the-right-error-upon-invalid-mount.patch
-fix-cachefs-barrier-handling-and-other-kernel-discrepancies.patch
-remove-error-from-linux-cachefsh.patch
-cachefs-warning-fix-2.patch
-cachefs-linkage-fix-2.patch
-cachefs-build-fix.patch

 Folded into cachefs-filesystem.patch

-add-page-becoming-writable-notification-fix.patch
-add-page-becoming-writable-notification-build-fix.patch
-make-page-becoming-writable-notification-a-vma-op-only.patch

 Folded into add-page-becoming-writable-notification.patch

-provide-a-filesystem-specific-syncable-page-bit-fix.patch
-provide-a-filesystem-specific-syncable-page-bit-fix-2.patch

 Folded into provide-a-filesystem-specific-syncable-page-bit.patch

-afs-cachefs-dependency-fix.patch

 Folded into make-afs-use-cachefs.patch

-split-general-cache-manager-from-cachefs-fix.patch

 Folded into split-general-cache-manager-from-cachefs.patch

-make-page-becoming-writable-notification-a-vma-op-only-kafs-fix-fix.patch

 Folded into make-page-becoming-writable-notification-a-vma-op-only-kafs-fix.patch

+files-break-up-files-struct-fix-dupfd-by-fdt-reload.patch
+files-files-struct-with-rcu-change-fd_install-assertion.patch
+files-files-locking-doc-update.patch

 Fixes for the files_lock RCUification patches in -mm.

+asfs-filesystem-driver.patch
+asfs-filesystem-driver-fixes.patch

 Amiga smart filesystem driver.  Needs cleanups and I don't think we see a
 lot of demand for this one.

+reiser4-swsusp-build-fix.patch
+reiser4-printk-warning-fix.patch
+reiser4-fix-dependencies.patch

 reiser4 fixes

+v9fs-vfs-file-dentry-and-directory-operations-fix-fsf-postal-address-in-source-headers.patch
+v9fs-vfs-inode-operations-fix-fsf-postal-address-in-source-headers.patch
+v9fs-vfs-superblock-operations-and-glue-fix-fsf-postal-address-in-source-headers.patch
+v9fs-9p-protocol-implementation-fix-fsf-postal-address-in-source-headers.patch
+v9fs-transport-modules-fix-fsf-postal-address-in-source-headers.patch
+v9fs-transport-modules-fix-timeout-segfault-corner-case.patch
+v9fs-debug-and-support-routines-fix-fsf-postal-address-in-source-headers.patch
+v9fs-change-error-magic-numbers-to-defined-constants.patch
+v9fs-clean-up-vfs_inode-and-setattr-functions.patch
+v9fs-fix-support-for-special-files-devices-named-pipes-etc.patch

 v9fs updates

+clean-up-the-old-digi-support-and-rescue-it.patch

 Clean up the digi driver, make it work on SMP

-minimal-ide-disk-updates.patch
+ide-fix-ide-disk-inability-to-handle-lba-only-devices.patch
+ide-samsung-sn-124-works-perfectly-well-with-dma.patch
+ide-timing-violation-on-reset.patch
+ide-generic-allow-for-capture-of-other-unsupported-devices.patch
+ide-fix-the-hpt366-driver-layer.patch
+ide-fix-crashes-with-hotplug-serverworks.patch
+ide-it8212-backport-for-bartlomiej-ide.patch
+ide-sensible-probing-for-pci-systems.patch

 Various IDE fixes from Alan.  This includes Alan's driver for the ITE RAID
 cards.  Presumably you don't want to enable this at the same time as
 iteraid.patch.

+doc-submitting-corrections-additions.patch

 Documentation fixes

-fuse-device-functions-abi-version-change.patch
-fuse-device-functions-comments-and-documentation.patch
-fuse-device-functions-comments-and-documentation-document-security-measures.patch
-fuse-device-functions-cleanup.patch
-fuse-device-functions-fuse-serious-information-leak-fix.patch

 Folded into fuse-device-functions.patch

-fuse-read-only-operations-multiple-links-to-directory-fix.patch
-fuse-read-only-operations-add-offset-to-fuse_dirent.patch
-fuse-read-only-operations-readdir-fixes.patch

 Folded into fuse-read-only-operations.patch

-fuse-read-write-operations-fix-lookup-forget-interface.patch

 Folded into fuse-read-write-operations.patch

-fuse-file-operations-interrupted-open-fix.patch

 Folded into fuse-file-operations.patch

-fuse-mount-options-fix.patch
-fuse-mount-options-reference-counting-fix.patch
-fuse-mount-options-comments-and-documentation.patch
-fuse-mount-options-fix-cleanup.patch
-fuse-mount-options-fix-fix.patch
-fuse-mount-options-remove-allow_root-mount-option.patch

 Folded into fuse-mount-options.patch

-fuse-direct-i-o-disable-sendfile-with-direct_io.patch
-fuse-direct-i-o-nfsd-with-direct_io-fix.patch
-fuse-direct-i-o-fix-warning-on-x86_64.patch

 Folded into fuse-direct-i-o.patch

-fuse-add-fsync-operation-for-directories-fix.patch

 Folded into fuse-add-fsync-operation-for-directories.patch

+timer-initialization-cleanup-define_timer.patch

 Add DEFINE_TIMER, use it.

+more-spin_lock_unlocked-define_spinlock-conversions.patch

 A few spinlock initialisation cleanups




number of patches in -mm: 619
number of changesets in external trees: 9
number of patches in -mm only: 618
total patches: 627



All 627 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/patch-list


