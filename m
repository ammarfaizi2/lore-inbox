Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVCLLwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVCLLwl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 06:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVCLLwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 06:52:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:40320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261354AbVCLLnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 06:43:06 -0500
Date: Sat, 12 Mar 2005 03:42:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-mm3
Message-Id: <20050312034222.12a264c4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm3/


- A new version of the "acpi poweroff fix".  People who were having trouble
  with ACPI poweroff, please test and report.

- A very large update to the CFQ I/O scheduler.  Treat with caution, run
  benchmarks.  Remember that the I/O scheduler can be selected on a per-disk
  basis with 

	echo as > /sys/block/sda/queue/scheduler
	echo deadline > /sys/block/sda/queue/scheduler
	echo cfq > /sys/block/sda/queue/scheduler

- video-for-linux update



Changes since 2.6.11-mm2:


 linus.patch
 bk-acpi.patch
 bk-audit.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-drm.patch
 bk-drm-via.patch
 bk-ia64.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-kbuild.patch
 bk-libata.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-scsi.patch
 bk-watchdog.patch
 bk-xfs.patch

 Latest versions os subsystem trees

-md-fix-typo-in-super_1_sync.patch
-ppc32-trivial-fix-for-e500-oprofile-build.patch
-ppc-raid6-build-fix.patch
-x86_64-pte-warning-fix.patch
-remove-drivers-char-tpqic02c.patch
-ppc64-revert-implement-a-vdso-and-use-it-for-signal-trampoline-gas-workaround.patch
-cramfs-small-stat2-fix.patch
-macserial-build-fix.patch
-ppc32-compilation-fixes-for-ebony-luan-and-ocotea.patch
-make-st-seekable-again.patch
-vm-pageout-throttling.patch
-simpler-topdown-mmap-layout-allocator.patch
-vmscan-reclaim-swap_cluster_max-pages-in-a-single-pass.patch
-stop-using-base-argument-in-__free_pages_bulk.patch
-mempool-protect-buffer-overflow-in-mempool_resize.patch
-fix-mincore-cornercases-overflow-caused-by-large-len.patch
-copy_pte_range-latency-fix.patch
-readahead-unneeded-prev_page-assignments.patch
-readahead-cleanup-get_next_ra_size.patch
-readahead-factor-out-duplicated-code.patch
-readahead-cleanup-blockable_page_cache_readahead.patch
-readahead-simplify-ra-size-testing.patch
-readahead-improve-sequential-read-detection.patch
-readahead-simplify-ra-size-testing-fix.patch
-use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
-bad-page-state-mapcount.patch
-put-newly-registered-shrinkers-at-the-tail-of-the-list.patch
-speed-freeing-memory-for-suspend.patch
-vfs-adds-the-s_private-flag-and-adds-use-to-security.patch
-selinux-internal-inode-loop-needs-is_private-test.patch
-reiserfs-private-inode-abstracted-to-static-inline.patch
-reiserfs-change-reiserfs-to-use-s_private.patch
-ppc32-add-radstone-ppc7d-platform-support.patch
-make-therm_adt746x-handle-latest-powerbooks.patch
-ppc64-mode-2-pci-x-config-space-size-fix.patch
-ppc64-addresses-from-of-getting-truncated-to-32-bits.patch
-ppc64-fix-init_boot_display-link-error.patch
-ppc64-c99-initializers-for-hw_interrupt_type.patch
-ppc64-kprobes-handle-trap-variants-while-processing-probes.patch
-ppc64-set-pci_io_base-dynamically-if-necessary.patch
-ppc64-allow-dynamic-enablement-of-eeh.patch
-mips-add-spare-timer-init.patch
-sh64-initial-checkstack-port.patch
-sh64-update-richard-curnows-maintainers-info.patch
-sh64-align-slab-caches-on-an-8-byte-boundary.patch
-sh64-defconfig-updates.patch
-sh64-iomap-interface.patch
-sh64-module-support.patch
-sh64-generic-hardirqs.patch
-sh64-ide-updates.patch
-sh64-tmu-init-bugfix.patch
-sh64-send-cli-sti-back-from-whence-it-came.patch
-sh64-beat-dcache-disabling-back-into-submission.patch
-sh64-merge-updates.patch
-sh-defconfig-updates.patch
-sh-generic-hardirqs.patch
-sh-hp620-updates.patch
-sh-framebuffer-updates.patch
-sh-update-cpufreq-driver-for-cpumask.patch
-sh-merge-updates.patch
-allow-hot-add-enabled-i386-numa-box-to-boot.patch
-refactor-i386-memory-setup.patch
-consolidate-set_max_mapnr_init-implementations.patch
-remove-free_all_bootmem-define.patch
-fix-iounmap-and-a-pageattr-memleak-x86-and-x86-64.patch
-determine-scx200-cb-address-at-run-time.patch
-iounmap-isa-special-case.patch
-support-for-geode-cpus.patch
-make-highmem_start-access-only-valid-addresses-i386.patch
-i386-c99-initializers-for-hw_interrupt_type-structures.patch
-cpuid-takes-unsigned-arguments.patch
-x86-clean-up-fixme-in-do_timer_interrupt.patch
-support-hpet-with-a-single-timer-for-system-time.patch
-remove-dead-cyrix-centaur-mtrr-init-code.patch
-altix-ignore-input-during-early-boot.patch
-altix-ioc4-serial-driver-support.patch
-swsusp-do-not-use-higher-order-memory-allocations-on-suspend.patch
-update-suspend-to-ram-vs-video-documentation.patch
-swsusp-fails-to-suspend-if-config_debug_pagealloc-is-also-enabled.patch
-kconfig-debug_pagealloc-and-software_suspend-are-incompatible-on-i386.patch
-m32r-use-generic-bugh.patch
-uml-trivial-removal-of-makefile-var.patch
-s390-soft-float-4gb-swap-bug-smp-clean-cpu-hotplug.patch
-s390-gcc4-compile-fixes.patch
-s390-key-management.patch
-s390-common-i-o-layer.patch
-s390-irb-faking.patch
-s390-z90crypt-reader-task-rescheduling.patch
-s390-iucv-driver-init-call.patch
-s390-qeth-layer-2-fake_ll-and-vlan-bugs.patch
-s390-ctc-online-offline-bug-fix.patch
-cleanup-vc-array-access.patch
-remove-console_macrosh.patch
-merge-vt_struct-into-vc_data.patch
-jbd-journal-overflow-fix-2.patch
-jbd-fix-against-journal-overflow.patch
-jbd-log-space-management-optimization.patch
-factor-out-phase-6-of-journal_commit_transaction.patch
-ext3-cleanup-1.patch
-ext3-free-block-accounting-fix.patch
-ext3_test_root-speedup.patch
-fix-race-between-the-nmi-code-and-the-cmos-clock.patch
-oss-support-for-ac97-low-power-codecs.patch
-fix-kallsyms-insmod-rmmod-race.patch
-d_drop-should-use-per-dentry-lock.patch
-add-struct-request-end_io-callback.patch
-rework-core-barrier-support.patch
-scsi_io_completion-sense-copy.patch
-blk_execute_rq-oops-on-fast-completion.patch
-annotate-proc-pid-maps-with--markers.patch
-serial-add-nec-vr4100-series-serial-support.patch
-serial-add-the-output-interface-control-to.patch
-sys_setpriority-euid-semantics-fix.patch
-add-tcsbrkp-to-compat_ioctlh.patch
-serial-update-vr41xx_siu.patch
-minor-conceptual-fix-for-proc-kcore-header-size.patch
-add-compiler-gcc4h.patch
-convert-proc-driver-rtc-to-seq_file.patch
-drivers-char-lpc-race-fix.patch
-clean-up-and-unify-asm-resourceh-files.patch
-add-local-bio-pool-support-and-modify-dm.patch
-fix-ufs-quota.patch
-run-softirqs-on-proper-processor-on-offline.patch
-aops-based-loop-io.patch
-add-timing-information-to-printk-messages.patch
-seccomp.patch
-minor-bttv-driver-update.patch
-tv-tuner-module-update.patch
-remove-mount-option-parsing-from-procfs.patch
-credits-update.patch
-bksend-example-script-fix.patch
-export-kallsyms_lookup_name.patch
-add-nobh_writepage-support.patch
-fix-1-wire-dallas-in-bigendian-machines.patch
-reiserfs-return-eio-instead-of-calling-bug-when-rename.patch
-keys-doc-update-on-locking.patch
-ext3_new_inode-failure-handling-missing-check.patch
-loglevel-boot-option.patch
-cross-compile-scripts-lxdialog-on-aix.patch
-sparc-fix-compile-failure-struct-resource-related.patch
-partitions-msdosc.patch
-explicitly-bind-idle-tasks.patch
-minor-cleanups-to-the-ipmi-driver.patch
-quotactl-changes-for-xfs.patch
-autofs4-patch-autofs4_wait-can-leak-memory.patch
-efi-fix-failure-handling.patch
-fix-register-access-typo-in-synclinkmp.patch
-atm-lanai-fix-section-references.patch
-atm-ambassador-fix-init-section-references.patch
-atm-zatm-fix-section-references.patch
-oss-cs4281-fix-initdata-section-references.patch
-oss-cmpci-fix-initdata-section-references.patch
-oss-es1370-fix-initdata-section-references.patch
-oss-esssolo1-fix-initdata-section-references.patch
-oss-nm256-fix-section-references.patch
-oss-pss-fix-section-references.patch
-oss-sscape-fix-section-references.patch
-base-small-introduce-the-config_base_small-flag.patch
-base-small-shrink-chrdevs-hash.patch
-base-small-shrink-pid-tables.patch
-base-small-shrink-uid-hash.patch
-base-small-shrink-futex-queues.patch
-base-small-shrink-timer-hashes.patch
-base-small-shrink-console-buffer.patch
-lib-sort-heapsort-implementation-of-sort.patch
-sort-link-it-in.patch
-lib-sort-replace-qsort-in-xfs.patch
-lib-sort-replace-insertion-sort-in-exception-tables.patch
-lib-sort-replace-insertion-sort-in-ia64-exception-tables.patch
-lib-sort-use-generic-sort-on-x86_64.patch
-random-pt2-cleanup-waitqueue-logic-fix-missed-wakeup.patch
-random-pt2-kill-pool-clearing.patch
-random-pt2-combine-legacy-ioctls.patch
-random-pt2-re-init-all-pools-on-zero.patch
-random-pt2-simplify-initialization.patch
-random-pt2-kill-memsets-of-static-data.patch
-random-pt2-kill-dead-extract_state-struct.patch
-random-pt2-kill-22-compat-waitqueue-defs.patch
-random-pt2-kill-redundant-rotate_left-definitions.patch
-random-pt2-kill-redundant-rotate_left-definitions-fix.patch
-random-pt2-kill-misnamed-log2.patch
-random-pt3-more-meaningful-pool-names.patch
-random-pt3-static-allocation-of-pools.patch
-random-pt3-static-sysctl-bits.patch
-random-pt3-catastrophic-reseed-checks.patch
-random-pt3-entropy-reservation-accounting.patch
-random-pt3-reservation-flag-in-pool-struct.patch
-random-pt3-reseed-pointer-in-pool-struct.patch
-random-pt3-break-up-extract_user.patch
-random-pt3-remove-dead-md5-copy.patch
-random-pt3-simplify-hash-folding.patch
-random-pt3-clean-up-hash-buffering.patch
-random-pt3-remove-entropy-batching.patch
-random-pt4-create-new-rol32-ror32-bitops.patch
-random-pt4-use-them-throughout-the-tree.patch
-random-pt4-kill-the-sha-variants.patch
-random-pt4-cleanup-sha-interface.patch
-random-pt4-move-sha-code-to-lib.patch
-random-pt4-replace-sha-with-faster-version.patch
-random-pt4-update-cryptolib-to-use-sha-fro-lib.patch
-random-pt4-move-halfmd4-to-lib.patch
-random-pt4-kill-duplicate-halfmd4-in-ext3-htree.patch
-random-pt4-simplify-and-shrink-syncookie-code.patch
-random-pt4-move-syncookies-to-net.patch
-lib-parser-linkage-fix.patch
-speedup-proc-pid-maps.patch
-posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic.patch
-posix-timers-high-resolution-cpu-clocks-for-posix-clock_-syscalls.patch
-posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic-cleanup.patch
-posix-timers-fix-posix-timers-signals-lock-order.patch
-posix-timers-cpu-clock-support-for-posix-timers.patch
-panic-in-check_process_timers.patch
-make-itimer_real-per-process.patch
-make-itimer_prof-itimer_virtual-per-process.patch
-make-rlimit_cpu-sigxcpu-per-process.patch
-override-rlimit_sigpending-for-non-rt-signals.patch
-show-rlimit_sigpending-usage-in-proc-pid-status.patch
-set-rlimit_sigpending-limit-based-on-rlimit_nproc.patch
-arm-rtc-build-fix.patch
-xscale-8250-patches-cause-malfunction-on-amd-8111.patch
-setup_per_zone_lowmem_reserve-oops-fix.patch
-ide-ide_dma_intr-oops-fix.patch
-implement-compat_ioctl-for-joydev.patch
-psmouse-warning-fix.patch
-sound-pci-cs4281c-fix-typos-in-the-support_joystick=n-case.patch
-sis900-oops-fix.patch
-mips-fixed-kernel-code-resource.patch
-selinux-enhanced-mls-support.patch
-selinux-pass-requested-protection-to-security_file_mmap-mprotect-hooks.patch
-ppc64-invert-dma-mapping-routines.patch
-x86-memset-the-i386-numa-pgdats-in-arch-code.patch
-x86-do-not-unnecessarily-memset-the-pgdats.patch
-x86-abstract-discontigmem-setup.patch
-x86-abstract-discontigmem-setup-fix.patch
-x86-allow-srat-to-parse-empty-nodes.patch
-x86-srat-cleanup-make-calculations-and-indenting-level-more-sane.patch
-x86-disable-msi-for-amd-8131.patch
-uml-2611-updates.patch
-uml-update-defconfig.patch
-uml-slirp-driver-tells-the-network-its-not-ethernet.patch
-uml-get-rid-of-uneccessary-hostfs-build-trick.patch
-uml-fix-some-usercopy-confusion.patch
-uml-make-the-ubd-driver-recognize-letters-in-device-names.patch
-uml-fix-a-shutdown-hang-caused-by-a-failed-ifconfig.patch
-uml-code-cleanup.patch
-uml-clean-up-the-syscall-path.patch
-uml-make-syscall-debugging-code-configurable.patch
-uml-add-a-comment-explaining-pread-availability.patch
-uml-remove-useless-sys_mount-wrapper.patch
-uml-remove-mm_indirect-reference-in-modify_ldt.patch
-uml-fix-a-compile-failure.patch
-uml-improve-error-reporting.patch
-uml-make-a-bunch-of-driver-functions-static.patch
-i4l-new-hfc_usb-driver-version.patch
-i4l-hfc-4s-and-hfc-8s-driver.patch
-invalidate_inode_pages2_range-livelock-fix.patch
-add-and-use-compat_sigev_pad_size.patch
-consolidate-the-last-compat-sigvals.patch
-consolidate-the-last-of-the-compat-sigevent-structs.patch
-properly-share-process-and-session-keyrings-with-clone_thread.patch
-nfsd4-remove-utf8-checking.patch
-nfsd4-create-a-slab-cache-for-stateowners.patch
-nfsd4-remove-stateowner-debug-counters.patch
-nfsd4-fix-oops-on-nfsd4-shutdown.patch
-nfsd4-cbnull-refcount-leak.patch
-nfsd4-reclaim-cleanup.patch
-nfsd4-move-special-stateid-processing.patch
-nfsd4-allow-some-reads-and-writes-during-the-grace-period.patch
-nfsd4-use-existing-open-instead-of-reopening-on-read-and-write.patch
-nfsd4-miscellaneous-open-cleanup.patch
-nfsd4-miscellaneous-open-cleanup-2.patch
-nfsd4-miscellaneous-open-cleanup-3.patch
-nfsd4-dont-release-nfs4_file-with-associated-delegations.patch
-nfsd4-do-callback-replays-by-hand.patch
-nfsd4-simplify-open_delegation.patch
-nfsd4-simplify-open_delegation-2.patch
-nfsd4-miscellaneous-delegation-fixes.patch
-nfsd4-remove-unnecessary-check-in-find_delegation_stateid.patch
-nfsd4-fix-nfs4_check_delegmode.patch
-nfsd4-simplify-clientid-hash-table-searches.patch
-nfsd4-simplify-verify_clientid.patch
-nfsd4-dont-allow-unconfirmed-renew.patch
-nfsd4-provide-no_cb_path-error-on-renew.patch
-nfsd4-simplify-find_openstateowner_str.patch
-nfsd4-simplify-find-functions.patch
-nfsd4-return-callback_ident-in-callbacks.patch
-nfsd4-remove-incorrect-kfree-from-callback.patch
-nfsd4-make-nfsd4_cb_recall-return-void.patch
-nfsd4-fix-callback-cred-refcnt-leak.patch
-nfsd4-use-sync-rpc-for-delegation-recall.patch
-nfsd4-trivial-callback-cleanup.patch
-nfsd4-nfs4_cb_recall-cleanup.patch
-nfsd4-remove-dl_recall_cnt.patch
-nfsd4-rename-release_stateid_lockowner.patch
-nfsd4-keep-lockowners-off-perclient-list.patch
-nfsd4-fix-laundromat-delegation-reaping.patch
-nfsd4-remove-st_vfs_set.patch
-nfsd4-remove-st_vfs_file-checks.patch
-nfsd4-fix-cb-race.patch
-nfsd4-fix-delegation-refcounting.patch
-nfsd4-reorganize-release_deleg.patch
-nfsd4-store-file-with-deleg.patch
-nfsd4-fix-delegation-filp-sharing.patch
-nfsd4-fix-sleep-under-spinlock.patch
-nfsd4-allow-io-to-use-deleg-stateid-file.patch
-nfsd4-remove-dl_state.patch
-nfsd4-fix-delegation-refcount-leak.patch
-nfsd4-fix_release_state_owner-prototype.patch
-locks-remove-unnecessary-bug.patch
-nfsd4-move-delegation-decisions-to-lock_manager-callbacks.patch
-nfsd4-eliminate-unnecessary-remove_lease.patch
-replace-schedule_timeout-with-msleep.patch
-nfs-fix_vfsflock.patch
-nfs-flock.patch
-fat-fix-writev-add-aio-support.patch
-fat-updated-fat-attributes-patch.patch
-fat-fat_readdirx-with-dotok=yes-fix.patch
-let-fat-handle-ms_synchronous-flag.patch
-fat-rewrite-the-fat-file-allocation-table-access.patch
-fat-add-debugging-code-to-fatentc.patch
-fat-use-unsigned-int-for-free_clusters-and.patch
-fat-struct-vfat_slot_info-cleanup.patch
-fat-use-struct-fat_slot_info-for-fat_search_long.patch
-fat-add-fat_remove_entries.patch
-fat-fat_build_inode-cleanup.patch
-fat-use-struct-fat_slot_info-for-fat_scan.patch
-fat-use-struct-fat_slot_info-for-msdos_find.patch
-fat-vfat_build_slots-cleanup.patch
-fat-use-a-same-timestamp-on-some-operations-path.patch
-fat-msdos_rename-cleanup.patch
-fat-msdos_add_entry-cleanup.patch
-fat-allocate-the-cluster-before-adding-the-directory.patch
-fat-rewrite-fat_add_entries.patch
-fat-use-fat_remove_entries-for-msdos.patch
-fat-make-the-fat_get_entry-fat__get_entry-the.patch
-fat-i_pos-cleanup.patch
-fat-remove-the-multiple-msdos_sb-call.patch
-fat-remove-unneed-mark_inode_dirty.patch
-fat-fix-fat_truncate.patch
-fat-fix-fat_write_inode.patch
-fat-use-synchronous-update-for.patch
-fat-update-rename-path.patch
-fat-fix-typo.patch
-new-bitmap-list-format-for-cpusets.patch
-cpusets-big-numa-cpu-and-memory-placement.patch
-cpusets-config_cpusets-depends-on-smp.patch
-cpusets-move-cpusets-above-embedded.patch
-cpusets-fix-cpuset_get_dentry.patch
-cpusets-fix-race-in-cpuset_add_file.patch
-cpusets-remove-more-casts.patch
-cpusets-make-config_cpusets-the-default-in-sn2_defconfig.patch
-cpusets-document-proc-status-allowed-fields.patch
-cpusets-dont-export-proc_cpuset_operations.patch
-cpusets-display-allowed-masks-in-proc-status.patch
-cpusets-simplify-cpus_allowed-setting-in-attach.patch
-cpusets-remove-useless-validation-check.patch
-cpusets-tasks-file-simplify-format-fixes.patch
-lib-sort-replace-open-coded-opids2-bubblesort-in-cpusets.patch
-cpusets-simplify-memory-generation.patch
-cpusets-interoperate-with-hotplug-online-maps.patch
-cpusets-alternative-fix-for-possible-race-in.patch
-cpusets-remove-casts.patch
-radeonfb-fix-spurious-error-return-in-fbio_radeon_set_mirror.patch
-w100fb-make-blanking-function-interrupt-safe.patch
-kyrofb-copy__user-return-value-checks-added-to-kyro-fb.patch
-skeletonfb-documentation-fixes.patch
-intelfb-add-partial-support-915g-chipset.patch
-intelfbdrv-resource-warning-fixes.patch
-sisfb_compat_ioctl-warning-fix.patch
-sis-warning-fix.patch
-tridentfbc-make-some-code-static.patch
-tridentfb-warning-fix.patch
-intelfb-vesa_modes-require-config_fb_modehelpers.patch
-fbdev-logo-code-fixes.patch
-fbdev-kbuild-cleanups.patch
-geodefb-add-geode-framebuffer-driver.patch
-geodefb-add-geode-framebuffer-driver-sparc-fix.patch
-nvidiafb-add-update-framebuffer-driver-for-nvidia-chipsets.patch
-fbdev-generic-drawing-function-cleanups.patch
-radeonfb-disable-agp-on-suspend.patch
-aty128fb-disable-agp-on-suspend.patch
-ppc32-uninorth-agp-suspend-support.patch
-fbdev-add-mode-changing-via-sysfs.patch
-fbdev-capture-modelist-change-event.patch
-fbcon-cursor-fixes.patch
-rivafb-fix-i2c-error-handling.patch
-nvidiafb-fix-i2c-error-handling.patch
-nvidiafb-some-chipsets-need-a-buffer-pitch-divisible-by-64.patch
-fbdev-generic-drawing-function-cleanups-2.patch
-fbdev-allow-core-fb-to-be-built-as-a-module.patch
-fbdev-allow-core-fb-to-be-built-as-a-module-fix.patch
-fbdev-allow-core-fb-to-be-built-as-a-module-fix-fix.patch
-savagefb-make-savagefb-one-module.patch
-fbdev-cleanups-in-driver-video.patch
-radeonfb-pll-access-workaround.patch
-md-erroneous-sizeof-use-in-raid1.patch
-md-fix-multipath-assembly-bug.patch
-md-raid-kconfig-cleanups-remove-experimental-tag-from-raid-6.patch
-md-remove-possible-oops-in-md-raid1.patch
-md-make-raid5-and-raid6-robust-against-failure-during-recovery.patch
-md-remove-kludgy-level-check-from-mdc.patch
-device-mapper-store-name-directly-against-device.patch
-device-mapper-record-restore-bio-state.patch
-device-mapper-export-map_info.patch
-device-mapper-multipath.patch
-device-mapper-multipath-fix.patch
-device-mapper-multipath-round-robin-path-selector.patch
-device-mapper-multipath-hardware-handler.patch
-device-mapper-multipath-hardware-handler-fix.patch
-device-mapper-multipath-hardware-handler-for-emc.patch
-device-mapper-tag-multipath-exports-gpl.patch
-device-mapper-some-code-formatting-cleanups.patch
-device-mapper-some-multipath-fn-renames.patch
-compile-error-blackbird_load_firmware.patch
-if-0-cx88_risc_disasm.patch
-drivers-isdn-tpam-convert-to-pci_register_driver.patch
-fix-error-reported-by-nfsd-which-it-gets-etxtbsy.patch

 Merged

+ia64-msi-build-fix.patch
+ia64-msi-warning-fixes.patch

 ia64 fixes

+x86-fix-booting-non-numa-system-with-numa-config.patch

 x86 memory management fix

+ppc32-add-rtc-hooks-to-katana-fw-bug-workaround.patch
+ppc32-update-chestnut-platform-files.patch
+ppc32-emulate-load-store-string-instructions.patch
+ppc32-remove-spr-short-hand-defines.patch

 ppc32 update

+ppc64-fix-linking-zimage-with-biarch-ld.patch
+ppc64-export-proper-version-from-vdso.patch
+ppc64-dont-use-in_atomic.patch
+ppc64-new-machine-definitions.patch
+ppc64-add-ide-pmac-support-for-new-shasta-chipset.patch
+ppc64-fix-some-pci-interrupt-routing-issues-on-imac-g5.patch
+ppc64-add-basic-support-for-the-smu-chip-in-imac-g5.patch
+ppc64-numa-memory-fixup.patch

 ppc64 updates

+v4l-ir-common-update.patch
+v4l-bttv-driver-update.patch
+v4l-video-buf-update.patch
+v4l-bttv-ir-driver-update.patch
+v4l-tuner-update.patch
+v4l-documentation-update.patch
+v4l-tveeprom-update.patch
+stradisc-vfree-checking-cleanups.patch
+miropcm20-radio-cleanup.patch
+media-zr36120-replace-interruptible_sleep_on-with-wait_event_interruptible.patch
+media-zoran_driver-replace-interruptible_sleep_on_timeout-with-wait_event_interruptible_timeout.patch
+media-zoran_device-replace-interruptible_sleep_on-with-wait_event_interruptible.patch
+media-zoran_card-remove-interruptible_sleep_on_timeout-usage.patch
+media-saa7110-remove-sleep_on-usage.patch
+media-radio-zoltrix-replace-sleep_delay-with-msleep.patch
+media-planb-replace-interruptible_sleep_on-with-wait_event.patch
+videotext-use-i2c_client_insmod-macro.patch
+dvb-add-pll-lib.patch
+dvb-mt352-frontend-driver-update.patch
+v4l2-api-mpeg-encoder-support.patch
+saa7134-update.patch
+v4l-cx88-driver-update.patch
+dvb-add-or51132-driver-atsc-demodulator.patch
+media-video-cx88-convert-pci_module_init-to-pci_register_driver.patch
+v4l-maintainers-file-update.patch

 v4l updates

+bk-acpi-acpi_pci_irq_disable-build-fix.patch

 bk-acpi build fix

-acpi-sleep-while-atomic-during-s3-resume-from-ram.patch

 Dropped - the ACPI guys are fixing this differently (I hope)

+acpi-poweroff-fix.patch
+acpi-poweroff-fix-fix.patch

 Re-fix the ACPI power off problem

+agp-make-some-code-static.patch

 agp code tweaks

+fix-i2c-messsage-flags-in-video-drivers.patch

 i2c fix

-sbp2-fix-hang-on-unload.patch

 Dropped - might not be needed

+bk-input-hid-core-warning-fix.patch

 bk-input warning fix

-fix-scripts-mkubootsh-to-return-status.patch

 Dropped - unneeded

+pci-be-more-verbose-in-gen-devlist.patch

 pc tweak

+st-msleep-warning-fix.patch

 Fix a scsi tape warning

+reiserfs-make-sure-data=journal-buffers-are-cleaned-on-free.patch

 reiserfs memleak fix

+ptwalk-pd_none_or_clear_bad.patch
+ptwalk-pd_none_or_clear_bad-ia64-fix.patch
+ptwalk-change_protection.patch
+ptwalk-sync_page_range.patch
+ptwalk-unuse_mm.patch
+ptwalk-map-and-unmap_vm_area.patch
+ptwalk-ioremap_page_range.patch
+ptwalk-remap_pfn_range.patch
+ptwalk-zeromap_page_range.patch
+ptwalk-unmap_page_range.patch
+ptwalk-copy_page_range.patch
+ptwalk-copy_pte_range-hang.patch
+ptwalk-clear_page_range.patch
+ptwalk-move-pd_none_or_clear_bad.patch
+ptwalk-inline-pmd_range-and-pud_range.patch
+ptwalk-pud-and-pmd-folded.patch

 pagetable walking code cleanups

+bdi-provide-backing-device-capability-information.patch

 Abstract and add to backing-dev flags

+cpusets-big-numa-cpu-and-memory-placement-backing_dev-fix.patch

 Update cpusets for the above

+unbacked-shared-memory-not-included-in-elf-core-dump.patch

 Fix core dumping of shmem segments

+add-a-clear_pages-function-to-clear-pages-of-higher.patch

 Permit multipage zeroing

+slab-kmalloc-cleanups.patch

 slab cleanups

+fix-driver-name-in-sk98lin.patch

 net driver fix

+ppc-8260-fcc-ethernet-driver-cannot-read-lxt971-phy-id.patch

 ppc net driver fixes

+fix-pci_disable_device-in-8139too.patch

 Maybe fix this net driver too

+log-full-of-ing_filter-fixed-ippp2-out-ippp2.patch

 Fix some net logspamming

+a-new-10gb-ethernet-driver-by-chelsio-communications.patch

 New 10gigE driver

+netfilter-include-fix.patch

 netfilter fix

+netfilter-snafu-fix.patch

 And another

+bonding-needs-inet.patch

 bonding driver Kconfig fix

+x86-reduce-cacheline-bouncing-in-cpu_idle_wait.patch

 x86 speedup

+x86-cmos-time-update-optimisation.patch
+x86-cmos-time-update-optimisation-tidy.patch
+x86-cmos-time-update-optimisation-locking-fix.patch

 Optimize x86 hardware clock handling

-x86_64-fix-pit-delay-accounting-in-timer_interrupt.patch

 Dropped - was rejected

+x86-64-forgot-asmlinkage-on-sys_mmap.patch

 x86_64 fix

+x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
+x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait-warning-fix.patch

 x86_64 speedup

+ia64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
+ia64-reduce-cacheline-bouncing-in-cpu_idle_wait-fix.patch

 ia64 speedup

+swsusp-use-non-contiguous-memory-on-resume.patch
+swsusp-use-non-contiguous-memory-on-ppc.patch
+swsusp-enable-resume-from-initrd.patch
+swsusp-do-not-provoke-emergency-disk-shutdowns.patch

 swsusp updates

-fix-partial-sysrq-setting.patch

 Folded into allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch

+detect-soft-lockups-from-touch_nmi_watchdog.patch

 Enhance detect-soft-lockups.patch

-areca-raid-linux-scsi-driver.patch
-areca-raid-linux-scsi-driver-fix.patch
-drivers-scsi-arcmsr-arcmsrc-cleanups.patch

 Dropped - maintainer sent a new update and it was busted

-blockdev-fixes-race-between-mount-umount-tidy.patch

 Folded into blockdev-fixes-race-between-mount-umount.patch

-cx24110-conexant-frontend-update-tidy.patch

 Folded into cx24110-conexant-frontend-update.patch

-direct-io-async-short-read-fix.patch
-direct-io-async-short-read-fix-fix.patch

 Dropped - was wrong

-del_timer_sync-scalability-patch.patch
-del_timer_sync-scalability-patch-tidy.patch

 Dropped - might have been wrong.

+relayfs.patch
+relayfs-backing_dev-fix.patch

 Re-add much shrunk relayfs

+consolidate-debug_info.patch

 Cleanup

+fix-warning-in-gkc-make-gconfig.patch

 Fix a gconfig warning

+module_device_tables.patch

 Add MODULE_DEVICE_TABLE to a number of drivers

+cfq-iosched-update-to-time-sliced-design.patch
+cfq-iosched-update-to-time-sliced-design-export-task_nice.patch
+cfq-iosched-update-to-time-sliced-design-fix.patch
+cfq-iosched-update-to-time-sliced-design-fix-fix.patch

 CFQ I/O scheduler updates

+keys-discard-key-spinlock-and-use-rcu-for-key-payload.patch
+keys-discard-key-spinlock-and-use-rcu-for-key-payload-try-4.patch

 key API tuneups

+rol-ror-type-cleanup.patch

 bitops fixlet

+config_base_full-help-clarification.patch

 Kconfig tweak

+stallion-driver-module-clean-up.patch

 Clean up this driver

+selinux-needs-inet.patch

 SELinux dependency

-nfsacl-acl-kconfig-cleanup.patch
-nfsacl-return-enosys-for-rpc-programs-that-are-unavailable.patch
-nfsacl-add-missing-eopnotsupp-=-nfs3err_notsupp-mapping-in-nfsd.patch
-nfsacl-allow-multiple-programs-to-listen-on-the-same-port.patch
-nfsacl-allow-multiple-programs-to-share-the-same-transport.patch
-nfsacl-lazy-rpc-receive-buffer-allocation.patch
-nfsacl-encode-and-decode-arbitrary-xdr-arrays.patch
-nfsacl-add-noacl-nfs-mount-option.patch
-nfsacl-infrastructure-and-server-side-of-nfsacl.patch
 nfsacl-solaris-nfsacl-workaround.patch
-nfsacl-nfs-mknod-cleanup.patch
-nfsacl-nfs-mkdir-cleanup.patch
-nfsacl-client-side-of-nfsacl.patch
-nfsacl-kconfig-hack.patch
-nfsacl-client-side-of-nfsacl-build-fix.patch
-nfsacl-acl-umask-handling-workaround-in-nfs-client.patch
-nfsacl-acl-umask-handling-workaround-in-nfs-client-fix.patch
-nfsacl-cache-acls-on-the-nfs-client-side.patch

 Dropped - Trond is starting to merge all this into bk-nfs

+kgdb-x86-config_debug_info-fix.patch

 kgdb-ga.patch fixlet

+kgdb-x86_64-config_debug_info-fix.patch

 kgdb-x86_64-support.patch fixlet

+fs-reiser4-possible-cleanups.patch

 reiser4 cleanups

+reiser4-only-memory_backed-fix.patch

 Fix reiser4 for bdi-provide-backing-device-capability-information.patch

+sealevel-8-port-rs-232-rs-422-rs-485-board.patch

 Serial driver fixes

-md-add-interface-for-userspace-monitoring-of-events.patch

 Dropped - it was getting in the way

+vt-dont-call-unblank-at-irq-time.patch
+ppc32-move-powermac-backlight-stuff-to-a-workqueue.patch
+radeonfb-implement-proper-workarounds-for-pll-accesses.patch
+radeonfb-ddc-i2c-fix.patch
+fbdev-nvidia-licensing-clarification.patch

 vt and fbdev updates

-verify_area-cleanup-drivers-part-1-fix.patch

 Folded into verify_area-cleanup-drivers-part-1.patch

-verify_area-cleanup-i386-and-misc-fix.patch

 Folded into verify_area-cleanup-i386-and-misc.patch

-verify_area-cleanup-deprecate-fix.patch

 Folded into verify_area-cleanup-deprecate.patch

-fuse-device-functions-use-after-free-fix.patch

 Folded into fuse-device-functions.patch

-fuse-file-operations-use-generic_file_llseek.patch

 Folded into fuse-file-operations.patch

-fuse-nfs-export-inode-leak-fix.patch

 Folded into fuse-nfs-export.patch

-fs-proc-kcorec-make-a-function-static.patch
-fs-qnx4-make-some-code-static.patch
-drivers-char-isicomc-make-a-struct-static.patch
-drivers-char-watchdog-make-some-code-static.patch
-drivers-char-synclinkmpc-make-3-functions-static.patch
-drivers-scsi-chc-make-a-struct-static.patch
-kernel-power-pmc-make-pm_send-static.patch

 Folded into another patch

+oprofile-make-some-code-static.patch

 tweak

+fix-u32-vs-pm_message_t-in-usb-fix.patch
+more-pm_message_t-fixes.patch

 Fix fix-u32-vs-pm_message_t-in-usb.patch

+unexport-flush_tlb_all.patch
+unexport-kmap_pteport-on-ppc.patch
+i386-power-cpuc-remove-three-unused-variables.patch
+cyrix-eliminate-bad-section-references.patch

 More tweaks



number of patches in -mm: 606
number of changesets in external trees: 346
number of patches in -mm only: 588
total patches: 934



All 606 patches:



linus.patch

ia64-msi-build-fix.patch
  ia64 msi build fix

ia64-msi-warning-fixes.patch
  ia64 msi warning fixes

x86-fix-booting-non-numa-system-with-numa-config.patch
  x86: fix booting non-NUMA system with NUMA config

ppc32-add-rtc-hooks-to-katana-fw-bug-workaround.patch
  ppc32: Add rtc hooks to katana + fw bug workaround

ppc64-fix-linking-zimage-with-biarch-ld.patch
  ppc64: fix linking zImage with biarch ld

ppc64-export-proper-version-from-vdso.patch
  ppc64: Export proper version from vDSO

ppc64-dont-use-in_atomic.patch
  ppc64: don't use in_atomic()

ppc64-new-machine-definitions.patch
  ppc64: new machine definitions

ppc64-add-ide-pmac-support-for-new-shasta-chipset.patch
  ppc64: Add IDE-pmac support for new "Shasta" chipset

ppc64-fix-some-pci-interrupt-routing-issues-on-imac-g5.patch
  ppc64: Fix some PCI interrupt routing issues on iMac G5

ppc64-add-basic-support-for-the-smu-chip-in-imac-g5.patch
  ppc64: Add basic support for the SMU chip in iMac G5

pcmcia-update-vrc4171_card.patch
  pcmcia: update vrc4171_card

pcmcia-yenta_socket-ti4150-support.patch
  pcmcia: yenta_socket - ti4150 support

pcmcia-pd6729-convert-to-pci_register_driver.patch
  pcmcia: pd6729 - convert to pci_register_driver()

pcmcia-rsrc_nonstatic-sysfs-output.patch
  pcmcia: rsrc_nonstatic: sysfs output

pcmcia-rsrc_nonstatic-sysfs-input.patch
  pcmcia: rsrc_nonstatic: sysfs input

pcmcia-mark-resource-setup-as-done.patch
  pcmcia: mark resource setup as done

pcmcia-pcmcia_device_probe.patch
  pcmcia: pcmcia_device_probe

pcmcia-pcmcia_device_remove.patch
  pcmcia: pcmcia_device_remove

pcmcia-pcmcia_device_add.patch
  pcmcia: pcmcia_device_add

pcmcia-use-bus_rescan_devices.patch
  pcmcia: use bus_rescan_devices

pcmcia-add-pcmcia-devices-autonomously.patch
  pcmcia: add pcmcia devices autonomously

pcmcia-determine-some-useful-information-about-devices.patch
  pcmcia: determine some useful information about devices

pcmcia-per-device-sysfs-output.patch
  pcmcia: per-device sysfs output

sched-timestamp-fixes.patch
  sched: timestamp fixes

sched-rework-schedstats.patch
  sched: rework schedstats

sched-find_busiest_group-fixlets.patch
  sched: find_busiest_group fixlets

sched-find_busiest_group-cleanup.patch
  sched: find_busiest_group cleanup

sched-re-inline-sched-functions.patch
  re-inline sched functions

v4l-ir-common-update.patch
  v4l: IR common update

v4l-bttv-driver-update.patch
  v4l: bttv driver update

v4l-video-buf-update.patch
  v4l: video-buf update

v4l-bttv-ir-driver-update.patch
  v4l: bttv IR driver update

v4l-tuner-update.patch
  v4l: tuner update

v4l-documentation-update.patch
  v4l: documentation update.

v4l-tveeprom-update.patch
  v4l: tveeprom update

stradisc-vfree-checking-cleanups.patch
  stradis.c - vfree() checking cleanups

miropcm20-radio-cleanup.patch
  miropcm20-radio cleanup

media-zr36120-replace-interruptible_sleep_on-with-wait_event_interruptible.patch
  media/zr36120: replace interruptible_sleep_on() with wait_event_interruptible()

media-zoran_driver-replace-interruptible_sleep_on_timeout-with-wait_event_interruptible_timeout.patch
  media/zoran_driver: replace interruptible_sleep_on_timeout() with wait_event_interruptible_timeout()

media-zoran_device-replace-interruptible_sleep_on-with-wait_event_interruptible.patch
  media/zoran_device: replace interruptible_sleep_on() with wait_event_interruptible()

media-zoran_card-remove-interruptible_sleep_on_timeout-usage.patch
  media/zoran_card: remove interruptible_sleep_on_timeout() usage

media-saa7110-remove-sleep_on-usage.patch
  media/saa7110: remove sleep_on*() usage

media-radio-zoltrix-replace-sleep_delay-with-msleep.patch
  media/radio-zoltrix: replace sleep_delay() with msleep()

media-planb-replace-interruptible_sleep_on-with-wait_event.patch
  media/planb: replace interruptible_sleep_on() with wait_event()

videotext-use-i2c_client_insmod-macro.patch
  Videotext: use I2C_CLIENT_INSMOD macro

dvb-add-pll-lib.patch
  dvb: add pll lib

dvb-mt352-frontend-driver-update.patch
  dvb: mt352 frontend driver update

v4l2-api-mpeg-encoder-support.patch
  v4l2 api: mpeg encoder support

saa7134-update.patch
  saa7134 update

v4l-cx88-driver-update.patch
  v4l: cx88 driver update

dvb-add-or51132-driver-atsc-demodulator.patch
  dvb: add or51132 driver (atsc demodulator)

media-video-cx88-convert-pci_module_init-to-pci_register_driver.patch
  media/video/cx88*: convert pci_module_init to pci_register_driver

v4l-maintainers-file-update.patch
  v4l: MAINTAINERS file update.

md-erroneous-sizeof-use-in-raid1.patch
  md: erroneous sizeof use in raid1

md-fix-multipath-assembly-bug.patch
  md: fix multipath assembly bug

md-raid-kconfig-cleanups-remove-experimental-tag-from-raid-6.patch
  md: RAID Kconfig cleanups, remove experimental tag from RAID-6

md-remove-possible-oops-in-md-raid1.patch
  md: remove possible oops in md/raid1

md-make-raid5-and-raid6-robust-against-failure-during-recovery.patch
  md: make raid5 and raid6 robust against failure during recovery.

md-remove-kludgy-level-check-from-mdc.patch
  md: remove kludgy level check from md.c

update-documentation-filesystems-locking.patch
  Update Documentation/filesystems/Locking

docbook-allow-preprocessor-directives-between-kernel-doc-and-function.patch
  docbook: allow preprocessor directives between kernel-doc and function

docbook-update-function-parameter-description-in-network-code.patch
  docbook: update function parameter description in network code

docbook-update-function-parameter-description-in-block-fs-code.patch
  docbook: update function parameter description in block/fs code

docbook-update-function-parameter-description-in-usb-code.patch
  docbook: update function parameter description in USB code

docbook-fix-function-parameter-descriptin-in-fbmem.patch
  docbook: fix function parameter descriptin in fbmem

docbook-new-kernel-doc-comments-for-might_sleep-wait_event_.patch
  docbook: new kernel-doc comments for might_sleep & wait_event_*

docbook-convert-template-files-to-xml.patch
  docbook: convert template files to XML

docbook-s-sgml-xml-in-scripts-kernel-doc.patch
  docbook: s/sgml/xml/ in scripts/kernel-doc

docbook-move-kernel-doc-comment-next-to-function.patch
  docbook: move kernel-doc comment next to function

docbook-s-sgml-xml-in-documentation-docbook-makefile.patch
  docbook: s/sgml/xml/ in Documentation/DocBook/Makefile

docbook-fix-xml-in-templates.patch
  docbook: fix XML in templates

docbook-kernel-docify-comments.patch
  docbook: kernel-docify comments

docbook-add-kfifo-to-kernel-api-docs.patch
  docbook: add kfifo to kernel-api docs

docbook-factor-out-escaping-of-xml-special-characters.patch
  docbook: factor out escaping of XML special characters

docbook-escape-declaration_purpose.patch
  docbook: escape declaration_purpose

make-various-things-static.patch
  Make lots of things static

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

bk-acpi.patch

bk-acpi-acpi_pci_irq_disable-build-fix.patch
  bk-acpi-acpi_pci_irq_disable build fix

acpi-toshiba-failure-handling.patch
  acpi: Toshiba failure handling

acpi-video-pointer-size-fix.patch
  acpi video pointer size fix

acpi-poweroff-fix.patch
  ACPI poweroff fix

acpi-poweroff-fix-fix.patch
  acpi-poweroff-fix fix

agp-make-some-code-static.patch
  AGP: make some code static

include-linux-soundcardh-endianness-fix.patch
  include/linux/soundcard.h: endianness fix

bk-audit.patch

bk-cifs.patch

bk-cpufreq.patch

bk-drm.patch

bk-drm-via.patch

fix-i2c-messsage-flags-in-video-drivers.patch
  Fix i2c messsage flags in video drivers

bk-ia64.patch

ide-hdiotxt-update.patch
  ide: hdio.txt update

ide-serverworks-fix-section-references.patch
  ide/serverworks: fix section references

bk-ieee1394.patch

bk-input.patch

bk-input-hid-core-warning-fix.patch
  bk-input-hid-core-warning-fix

bk-kbuild.patch

uml-make-deb-pkg-build-target-build-a-debian-style-user-mode-linux-package.patch
  uml: make deb-pkg build target build a Debian-style user-mode-linux package

bk-libata.patch

bk-netdev.patch

bk-ntfs.patch

arch-i386-pci-i386c-use-new-for_each_pci_dev-macro.patch
  arch/i386/pci/i386.c: Use new for_each_pci_dev macro

pci-be-more-verbose-in-gen-devlist.patch
  pci: be more verbose in gen-devlist

bk-scsi.patch

st-msleep-warning-fix.patch
  st msleep warning fix

megaraid_sas-announcing-new-module-for.patch
  megaraid_sas: Announcing new module for LSI Logic's SAS based MegaRAID controllers

open-iscsi-scsi.patch
  open-iscsi-scsi

open-iscsi-headers.patch
  open-iscsi-headers

open-iscsi-kconfig.patch
  open-iscsi-kconfig

open-iscsi-makefile.patch
  open-iscsi-makefile

open-iscsi-netlink.patch
  open-iscsi-netlink

open-iscsi-doc.patch
  open-iscsi-doc

add-scsi-changer-driver.patch
  add scsi changer driver

scsi-ch-build-fix.patch
  scsi ch.c build fix

whitelist-entry-forcelun-for-sgs-thomson-microelectronics-cytronix-6in1-card-reader-in-scsi_devinfoc.patch
  Whitelist-Entry (FORCELUN) for SGS Thomson Microelectronics Cytronix 6in1 card reader in scsi_devinfo.c

zd1201-build-fix.patch
  zd1201 build fix

usb-hcd-u64-warning-fix.patch
  usb hcd u64 warning fix

bk-watchdog.patch

hw-watchdog-vs-softdog-fix.patch
  hw watchdog vs softdog fix.

bk-xfs.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-help-for-acpi_container.patch
  Fix help for ACPI_CONTAINER

orphaned-pagecache-memleak-fix.patch
  orphaned pagecache memleak fix

reiserfs-make-sure-data=journal-buffers-are-cleaned-on-free.patch
  reiserfs: make sure data=journal buffers are cleaned on free

swapspace-layout-improvements.patch
  swapspace-layout-improvements
  /proc/swaps negative Used

ia64-specific-dev-mem-handlers.patch
  ia64 specific /dev/mem handlers

allow-vma-merging-with-mlock-et-al.patch
  allow vma merging with mlock et. al.

ptwalk-pd_none_or_clear_bad.patch
  ptwalk: p?d_none_or_clear_bad

ptwalk-pd_none_or_clear_bad-ia64-fix.patch
  ptwalk-pd_none_or_clear_bad ia64 fix

ptwalk-change_protection.patch
  ptwalk: change_protection

ptwalk-sync_page_range.patch
  ptwalk: sync_page_range

ptwalk-unuse_mm.patch
  ptwalk: unuse_mm

ptwalk-map-and-unmap_vm_area.patch
  ptwalk: map and unmap_vm_area

ptwalk-ioremap_page_range.patch
  ptwalk: ioremap_page_range

ptwalk-remap_pfn_range.patch
  ptwalk: remap_pfn_range

ptwalk-zeromap_page_range.patch
  ptwalk: zeromap_page_range

ptwalk-unmap_page_range.patch
  ptwalk: unmap_page_range

ptwalk-copy_page_range.patch
  ptwalk: copy_page_range

ptwalk-copy_pte_range-hang.patch
  ptwalk: copy_pte_range hang

ptwalk-clear_page_range.patch
  ptwalk: clear_page_range

ptwalk-move-pd_none_or_clear_bad.patch
  ptwalk: move p?d_none_or_clear_bad

ptwalk-inline-pmd_range-and-pud_range.patch
  ptwalk: inline pmd_range and pud_range

ptwalk-pud-and-pmd-folded.patch
  ptwalk: pud and pmd folded

vmalloc-introduce-__vmalloc_area-function.patch
  vmalloc: introduce __vmalloc_area() function

vmalloc-use-__vmalloc_area-in-arch-arm.patch
  vmalloc: use __vmalloc_area in arch/arm

vmalloc-use-__vmalloc_area-in-arch-sparc64.patch
  vmalloc: use __vmalloc_area in arch/sparc64/

vmalloc-use-__vmalloc_area-in-arch-x86_64.patch
  vmalloc: use __vmalloc_area in arch/x86_64/

vmalloc-use-list-of-pages-instead-of-array-in-vm_struct.patch
  vmalloc: use list of pages instead of array in vm_struct

no-arch-specific-mem_map-init.patch
  no arch-specific mem_map init

bdi-provide-backing-device-capability-information.patch
  BDI: Provide backing device capability information [try #3]

cpusets-big-numa-cpu-and-memory-placement-backing_dev-fix.patch
  cpusets-big-numa-cpu-and-memory-placement-backing_dev-fix

unbacked-shared-memory-not-included-in-elf-core-dump.patch
  Unbacked shared memory not included in ELF core dump

add-a-clear_pages-function-to-clear-pages-of-higher.patch
  add a clear_pages function to clear pages of higher order

slab-kmalloc-cleanups.patch
  slab.[ch]: kmalloc() cleanups

b44-bounce-buffer-fix.patch
  b44 bounce buffering fix

eni155p-error-handling-fix.patch
  ENI155P error handling fix

drivers-net-myri_codeh-cleanup.patch
  drivers/net/myri_code.h cleanup

e100-napi-fixes.patch
  e100: NAPI fixes

remove-last_rx-update-from-loopback-device.patch
  remove last_rx update from loopback device

fix-driver-name-in-sk98lin.patch
  fix driver name in sk98lin

ppc-8260-fcc-ethernet-driver-cannot-read-lxt971-phy-id.patch
  ppc 8260 fcc ethernet driver cannot read LXT971 PHY id

fix-pci_disable_device-in-8139too.patch
  fix pci_disable_device in 8139too

log-full-of-ing_filter-fixed-ippp2-out-ippp2.patch
  Log full of "ing_filter:  fixed  ippp2 out ippp2"

a-new-10gb-ethernet-driver-by-chelsio-communications.patch
  A new 10GB Ethernet Driver by Chelsio Communications

netfilter-include-fix.patch
  netfilter include fix

netfilter-snafu-fix.patch
  netfilter snafu fix

bonding-needs-inet.patch
  bonding needs inet

ppc32-update-chestnut-platform-files.patch
  ppc32: Update chestnut platform files

ppc32-emulate-load-store-string-instructions.patch
  ppc32: emulate load/store string instructions

ppc32-remove-spr-short-hand-defines.patch
  ppc32: Remove SPR short-hand defines

ppc64-numa-memory-fixup.patch
  ppc64: NUMA memory fixup

x86-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  x86: reduce cacheline bouncing in cpu_idle_wait

x86-cmos-time-update-optimisation.patch
  x86: CMOS time update optimisation

x86-cmos-time-update-optimisation-tidy.patch
  x86-cmos-time-update-optimisation-tidy

x86-cmos-time-update-optimisation-locking-fix.patch
  x86-cmos-time-update-optimisation locking fix

x86-64-kconfig-typo-trivial.patch
  x86-64: kconfig typo

x86_64-remove-old-decl-trivial.patch
  x86_64: remove old decl (trivial)

x86_64-avoid-panic-lockup.patch
  x86_64: avoid panic lockup

x86_64-hugetlb-fix.patch
  x86_64: hugetlb fix

x86-64-forgot-asmlinkage-on-sys_mmap.patch
  x86-64: forgot asmlinkage on sys_mmap

x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  x86_64: reduce cacheline bouncing in cpu_idle_wait

x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait-warning-fix.patch
  x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait-warning-fix

x86_64-dump-stack-in-early-exception.patch
  x86_64-dump-stack-in-early-exception

ia64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  ia64: reduce cacheline bouncing in cpu_idle_wait

ia64-reduce-cacheline-bouncing-in-cpu_idle_wait-fix.patch
  ia64-reduce-cacheline-bouncing-in-cpu_idle_wait fix

swsusp-use-non-contiguous-memory-on-resume.patch
  swsusp: use non-contiguous memory on resume

swsusp-use-non-contiguous-memory-on-ppc.patch
  swsusp: use non-contiguous memory on ppc

swsusp-enable-resume-from-initrd.patch
  swsusp: enable resume from initrd

swsusp-do-not-provoke-emergency-disk-shutdowns.patch
  Subject: swsusp: do not provoke emergency disk shutdowns

allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
  Allow admin to enable only some of the Magic-Sysrq functions

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch
  Sort out PCI_ROM_ADDRESS_ENABLE vs IORESOURCE_ROM_ENABLE

mtrr-size-and-base-debug.patch
  mtrr size-and-base debugging

cant-unmount-bad-inode.patch
  Can't unmount bad inode

iounmap-debugging.patch
  iounmap debugging

detect-soft-lockups.patch
  detect soft lockups

detect-soft-lockups-from-touch_nmi_watchdog.patch
  detect-soft-lockups: call from touch_nmi_watchdog

rt-lsm.patch
  RT-LSM

tty-output-lossage-fix.patch
  tty output lossage fix

blockdev-fixes-race-between-mount-umount.patch
  blockdev: fixes race between mount/umount

cx24110-conexant-frontend-update.patch
  cx24110 Conexant Frontend update

nice-and-rt-prio-rlimits.patch
  nice and rt-prio rlimits

relayfs.patch
  relayfs

relayfs-backing_dev-fix.patch
  relayfs-backing_dev-fix

consolidate-debug_info.patch
  consolidate CONFIG_DEBUG_INFO

fix-warning-in-gkc-make-gconfig.patch
  Fix warning in gkc (make gconfig)

module_device_tables.patch
  MODULE_DEVICE_TABLE fixes
  module_device_tables-fix
  module_device_tables-ne3210-fix
  module_device_tables-depca-fix
  module_device_tables pciehp fix
  module_device_tables-oss-sb-fix

cfq-iosched-update-to-time-sliced-design.patch
  cfq-iosched: update to time sliced design

cfq-iosched-update-to-time-sliced-design-export-task_nice.patch
  cfq-iosched-update-to-time-sliced-design-export-task_nice

cfq-iosched-update-to-time-sliced-design-fix.patch
  cfq-iosched-update-to-time-sliced-design fix

cfq-iosched-update-to-time-sliced-design-fix-fix.patch
  cfq-iosched-update-to-time-sliced-design-fix-fix

keys-discard-key-spinlock-and-use-rcu-for-key-payload.patch
  keys: Discard key spinlock and use RCU for key payload

keys-discard-key-spinlock-and-use-rcu-for-key-payload-try-4.patch
  keys: Discard key spinlock and use RCU for key payload - try #4

rol-ror-type-cleanup.patch
  rol/ror type cleanup

config_base_full-help-clarification.patch
  CONFIG_BASE_FULL help clarification

stallion-driver-module-clean-up.patch
  Stallion driver module clean up

selinux-needs-inet.patch
  selinux needs inet

inotify.patch
  inotify

inotify-fix.patch
  inotify-fix

ext3-jbd-race-releasing-in-use-journal_heads.patch
  ext3/jbd race: releasing in-use journal_heads

ext3-writepages-support-for-writeback-mode.patch
  ext3 writepages support for writeback mode

pcmcia-dont-send-eject-request-events-to-userspace.patch
  pcmcia: don't send eject request events to userspace

pcmcia-hotplug-event-for-pcmcia-devices.patch
  pcmcia: hotplug event for PCMCIA devices

pcmcia-hotplug-event-for-pcmcia-socket-devices.patch
  pcmcia: hotplug event for PCMCIA socket devices

pcmcia-device-and-driver-matching.patch
  pcmcia: device and driver matching

pcmcia-check-for-invalid-crc32-hashes-in-id_tables.patch
  pcmcia: check for invalid crc32 hashes in id_tables

pcmcia-match-for-fake-cis.patch
  pcmcia: match for fake CIS

pcmcia-export-cis-in-sysfs.patch
  pcmcia: export CIS in sysfs

pcmcia-cis-overrid-via-sysfs.patch
  pcmcia: CIS overrid via sysfs

pcmcia-match-anonymous-cards.patch
  pcmcia: match "anonymous" cards

pcmcia-allow-function-id-based-match.patch
  pcmcia: allow function-ID based match

pcmcia-file2alias.patch
  pcmcia: file2alias

pcmcia-request-cis-via-firmware-interface.patch
  pcmcia: request CIS via firmware interface

pcmcia-cleanups.patch
  pcmcia: cleanups

pcmcia-rescan-bus-always-upon-echoing-into-setup_done.patch
  pcmcia: rescan bus always upon echoing into setup_done

pcmcia-id_table-for-serial_cs.patch
  pcmcia: id_table for serial_cs

pcmcia-id_table-for-3c574_cs.patch
  pcmcia: id_table for 3c574_cs

pcmcia-id_table-for-3c589_cs.patch
  pcmcia: id_table for 3c589_cs

pcmcia-id_table-for-aha152x.patch
  pcmcia: id_table for aha152x

pcmcia-id_table-for-airo_cs.patch
  pcmcia: id_table for airo_cs

pcmcia-id_table-for-axnet_cs.patch
  pcmcia: id_table for axnet_cs

pcmcia-id_table-for-fdomain_stub.patch
  pcmcia: id_table for fdomain_stub

pcmcia-id_table-for-fmvj18x_cs.patch
  pcmcia: id_table for fmvj18x_cs

pcmcia-id_table-for-ibmtr_cs.patch
  pcmcia: id_table for ibmtr_cs

pcmcia-id_table-for-netwave_cs.patch
  pcmcia: id_table for netwave_cs

pcmcia-id_table-for-nmclan_cs.patch
  pcmcia: id_table for nmclan_cs

pcmcia-id_table-for-teles_cs.patch
  pcmcia: id_table for teles_cs

pcmcia-id_table-for-ray_cs.patch
  pcmcia: id_table for ray_cs

pcmcia-id_table-for-wavelan_cs.patch
  pcmcia: id_table for wavelan_cs

pcmcia-id_table-for-sym53c500_csc.patch
  pcmcia: id_table for sym53c500_cs.c

pcmcia-id_table-for-qlogic_stubc.patch
  pcmcia: id_table for qlogic_stub.c

pcmcia-id_table-for-smc91c92_csc.patch
  pcmcia: id_table for smc91c92_cs.c

pcmcia-id_table-for-orinoco_cs.patch
  pcmcia: id_table for orinoco_cs

pcmcia-id_table-for-xirc2ps_csc.patch
  pcmcia: id_table for xirc2ps_cs.c

pcmcia-id_table-for-ide_csc.patch
  pcmcia: id_table for ide_cs.c

pcmcia-id_table-for-parport_csc.patch
  pcmcia: id_table for parport_cs.c

pcmcia-id_table-for-pcnet_csc.patch
  pcmcia: id_table for pcnet_cs.c

pcmcia-id_table-for-pcmciamtdc.patch
  pcmcia: id_table for pcmciamtd.c

pcmcia-id_table-for-vxpocketc.patch
  pcmcia: id_table for vxpocket.c

pcmcia-id_table-for-atmel_csc.patch
  pcmcia: id_table for atmel_cs.c

pcmcia-id_table-for-avma1_csc.patch
  pcmcia: id_table for avma1_cs.c

pcmcia-id_table-for-avm_csc.patch
  pcmcia: id_table for avm_cs.c

pcmcia-id_table-for-bluecard_csc.patch
  pcmcia: id_table for bluecard_cs.c

pcmcia-id_table-for-bt3c_csc.patch
  pcmcia: id_table for bt3c_cs.c

pcmcia-id_table-for-btuart_csc.patch
  pcmcia: id_table for btuart_cs.c

pcmcia-id_table-for-com20020_csc.patch
  pcmcia: id_table for com20020_cs.c

pcmcia-id_table-for-dtl1_csc.patch
  pcmcia: id_table for dtl1_cs.c

pcmcia-id_table-for-elsa_csc.patch
  pcmcia: id_table for elsa_cs.c

pcmcia-id_table-for-ixj_pcmciac.patch
  pcmcia: id_table for ixj_pcmcia.c

pcmcia-id_table-for-nsp_csc.patch
  pcmcia: id_table for nsp_cs.c

pcmcia-id_table-for-sedlbauer_csc.patch
  pcmcia: id_table for sedlbauer_cs.c

pcmcia-id_table-for-wl3501_csc.patch
  pcmcia: id_table for wl3501_cs.c

pcmcia-id_table-for-pdaudiocfc.patch
  pcmcia: id_table for pdaudiocf.c

pcmcia-id_table-for-synclink_csc.patch
  pcmcia: id_table for synclink_cs.c

nfsacl-solaris-nfsacl-workaround.patch
  nfsacl: Solaris nfsacl workaround

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
  kgdb: fix for recent gcc
  kgdb warning fixes
  THREAD_SIZE fixes for kgdb
  Fix stack overflow test for non-8k stacks
  kgdb-ga.patch fix for i386 single-step into sysenter
  fix TRAP_BAD_SYSCALL_EXITS on i386
  add TRAP_BAD_SYSCALL_EXITS config for i386
  kgdb-is-incompatible-with-kprobes
  kgdb-ga-build-fix
  kgdb-ga-fixes
  kgdb: kill off highmem_start_page
  kgdb documentation fix

kgdb-x86-config_debug_info-fix.patch
  kgdb CONFIG_DEBUG_INFO fix

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

kgdb-x86_64-config_debug_info-fix.patch
  kgdb CONFIG_DEBUG_INFO fix

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

page-owner-tracking-leak-detector.patch
  Page owner tracking leak detector

make-page_owner-handle-non-contiguous-page-ranges.patch
  make page_owner handle non-contiguous page ranges

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

periodically-scan-redzone-entries-and-slab-control-structures.patch
  periodically scan redzone entries and slab control structures

irqpoll.patch
  irqpoll

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

perfctr-core.patch
  perfctr: core
  perfctr: remove bogus perfctr_sample_thread() calls

perfctr-i386.patch
  perfctr: i386

perfctr-x86-core-updates.patch
  perfctr x86 core updates

perfctr-x86-driver-updates.patch
  perfctr x86 driver updates

perfctr-x86-driver-cleanup.patch
  perfctr: x86 driver cleanup

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86-update-2.patch
  perfctr x86 update 2

perfctr-x86_64.patch
  perfctr: x86_64

perfctr-x86_64-core-updates.patch
  perfctr x86_64 core updates

perfctr-ppc.patch
  perfctr: PowerPC

perfctr-ppc32-driver-update.patch
  perfctr: ppc32 driver update

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

perfctr-ppc32-update.patch
  perfctr ppc32 update

perfctr-ppc32-update-2.patch
  perfctr ppc32 update

perfctr-virtualised-counters.patch
  perfctr: virtualised counters

perfctr-remap_page_range-fix.patch

virtual-perfctr-illegal-sleep.patch
  virtual perfctr illegal sleep

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr: Kconfig-related updates

perfctr-virtual-updates.patch
  perfctr virtual updates

perfctr-virtual-cleanup.patch
  perfctr: virtual cleanup

perfctr-ppc32-preliminary-interrupt-support.patch
  perfctr ppc32 preliminary interrupt support

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr: reduce stack usage

perfctr-interrupt-support-kconfig-fix.patch
  perfctr interrupt_support Kconfig fix

perfctr-low-level-documentation.patch
  perfctr low-level documentation

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance: driver updates

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

perfctr-api-changes-first-step.patch
  perfctr API changes: first step

perfctr-virtual-update.patch
  perfctr virtual update

perfctr-x86-64-ia32-emulation-fix.patch
  perfctr x86-64 ia32 emulation fix

perfctr-sysfs-update-1-4-core.patch
  perfctr sysfs update: core

perfctr-sysfs-update.patch
  Perfctr sysfs update

perfctr-sysfs-update-2-4-x86.patch
  perfctr sysfs update: x86

perfctr-sysfs-update-3-4-x86-64.patch
  perfctr sysfs update: x86-64
  perfctr: syscall numbers in x86-64 ia32-emulation
  perfctr x86_64 native syscall numbers fix

perfctr-sysfs-update-4-4-ppc32.patch
  perfctr sysfs update: ppc32

perfctr-2710-api-update-1-4-common.patch
  perfctr-2.7.10 API update 1/4: common

perfctr-2710-api-update-2-4-i386.patch
  perfctr-2.7.10 API update 2/4: i386

perfctr-2710-api-update-3-4-x86_64.patch
  perfctr-2.7.10 API update 3/4: x86_64

perfctr-2710-api-update-4-4-ppc32.patch
  perfctr-2.7.10 API update 4/4: ppc32

sched-improve-pinned-task-handling.patch
  sched: improve pinned task handling

sched-improve-pinned-task-handling-fix.patch
  sched-improve-pinned-task-handling fix

sched-no-aggressive-idle-balancing.patch
  sched: no aggressive idle balancing

sched-better-active-balancing-heuristic.patch
  sched: better active balancing heuristic

sched-generalised-cpu-load-averaging.patch
  sched: generalised CPU load averaging

sched-less-affine-wakups.patch
  sched: less affine wakups

sched-remove-aggressive-idle-balancing.patch
  sched: remove aggressive idle balancing

sched-sched-domains-aware-balance-on-fork.patch
  sched: sched-domains aware balance-on-fork

sched-schedstats-additions-for-sched-balance-fork.patch
  sched: schedstats additions for sched-balance-fork

sched-basic-tuning.patch
  sched: basic tuning

random-ia64-sched-domains-values.patch
  random ia64 sched-domains values

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm
  ppc64: fix hotplug cpu

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

numa-policies-for-file-mappings-mpol_mf_move-cachefs.patch
  numa-policies-for-file-mappings-mpol_mf_move for cachefs

cachefs-release-search-records-lest-they-return-to-haunt-us.patch
  CacheFS: release search records lest they return to haunt us

fix-64-bit-problems-in-cachefs.patch
  Fix 64-bit problems in cachefs

cachefs-fixed-typos-that-cause-wrong-pointer-to-be-kunmapped.patch
  cachefs: fixed typos that cause wrong pointer to be kunmapped

cachefs-return-the-right-error-upon-invalid-mount.patch
  CacheFS: return the right error upon invalid mount

fix-cachefs-barrier-handling-and-other-kernel-discrepancies.patch
  Fix CacheFS barrier handling and other kernel discrepancies

remove-error-from-linux-cachefsh.patch
  Remove #error from linux/cachefs.h

cachefs-warning-fix-2.patch
  cachefs warning fix 2

cachefs-linkage-fix-2.patch
  cachefs linkage fix

cachefs-build-fix.patch
  cachefs build fix

cachefs-documentation.patch
  CacheFS documentation

add-page-becoming-writable-notification.patch
  Add page becoming writable notification

add-page-becoming-writable-notification-fix.patch
  do_wp_page_mk_pte_writable() fix

add-page-becoming-writable-notification-build-fix.patch
  add-page-becoming-writable-notification build fix

provide-a-filesystem-specific-syncable-page-bit.patch
  Provide a filesystem-specific sync'able page bit

provide-a-filesystem-specific-syncable-page-bit-fix.patch
  provide-a-filesystem-specific-syncable-page-bit-fix

provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
  provide-a-filesystem-specific-syncable-page-bit-fix-2

make-afs-use-cachefs.patch
  Make AFS use CacheFS

afs-cachefs-dependency-fix.patch
  afs-cachefs-dependency-fix

split-general-cache-manager-from-cachefs.patch
  Split general cache manager from CacheFS

turn-cachefs-into-a-cache-backend.patch
  Turn CacheFS into a cache backend

rework-the-cachefs-documentation-to-reflect-fs-cache-split.patch
  Rework the CacheFS documentation to reflect FS-Cache split

update-afs-client-to-reflect-cachefs-split.patch
  Update AFS client to reflect CacheFS split

fscache-menuconfig-help-fix-documentation-path.patch
  fscache-menuconfig-help-fix-documentation-pathc

x86-rename-apic_mode_exint.patch
  kexec: x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  kexec: x86: local apic fix

x86_64-e820-64bit.patch
  kexec: x86_64: e820 64bit fix

x86-i8259-shutdown.patch
  kexec: x86: i8259 shutdown: disable interrupts

x86_64-i8259-shutdown.patch
  kexec: x86_64: add i8259 shutdown method

x86-apic-virtwire-on-shutdown.patch
  kexec: x86: resture apic virtual wire mode on shutdown

x86_64-apic-virtwire-on-shutdown.patch
  kexec: x86_64: restore apic virtual wire mode on shutdown

vmlinux-fix-physical-addrs.patch
  kexec: vmlinux: fix physical addresses

x86-vmlinux-fix-physical-addrs.patch
  kexec: x86: vmlinux: fix physical addresses

x86_64-vmlinux-fix-physical-addrs.patch
  kexec: x86_64: vmlinux: fix physical addresses

x86_64-entry64.patch
  kexec: x86_64: add 64-bit entry

x86-config-kernel-start.patch
  kexec: x86: add CONFIG_PYSICAL_START

x86_64-config-kernel-start.patch
  kexec: x86_64: add CONFIG_PHYSICAL_START

kexec-kexec-generic.patch
  kexec: add kexec syscalls

kexec-kexec-generic-kexec-use-unsigned-bitfield.patch
  kexec: use unsigned bitfield

x86-machine_shutdown.patch
  kexec: x86: factor out apic shutdown code

x86-kexec.patch
  kexec: x86 kexec core

x86-crashkernel.patch
  crashdump: x86 crashkernel option

x86-crashkernel-fix.patch
  kexec: fix for broken kexec on panic

x86_64-machine_shutdown.patch
  kexec: x86_64: factor out apic shutdown code

x86_64-kexec.patch
  kexec: x86_64 kexec implementation

x86_64-crashkernel.patch
  crashdump: x86_64: crashkernel option

kexec-ppc-support.patch
  kexec: kexec ppc support

kexec-ppc-fix-noret_type.patch
  kexec: ppc: fix NORET_TYPE

x86-crash_shutdown-nmi-shootdown.patch
  crashdump: x86: add NMI handler to capture other CPUs

x86-crash_shutdown-snapshot-registers.patch
  kexec: x86: snapshot registers during crash shutdown

x86-crash_shutdown-apic-shutdown.patch
  kexec: x86 shutdown APICs during crash_shutdown

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-routines-for-copying-dump-pages-fixes.patch
  crashdump-routines-for-copying-dump-pages-fixes

crashdump-elf-format-dump-file-access.patch
  crashdump: elf format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear raw format dump file access

crashdump-linear-raw-format-dump-file-access-coding-style.patch
  crashdump-linear-raw-format-dump-file-access-coding-style

kdump-export-crash-notes-section-address-through.patch
  Kdump: Export crash notes section address through sysfs

kdump-export-crash-notes-section-address-through-build-fix.patch
  kdump-export-crash-notes-section-address-through build fix

kdump-export-crash-notes-section-address-through-x86_64-fix.patch
  kdump-export-crash-notes-section-address-through x86_64 fix

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-rcu-barrier-license-fix.patch
  reiser4-rcu-barrier-license-fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-inode_lock-unexport-__iget.patch
  reiser4-export-inode_lock-unexport-__iget

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-perthread_pages_alloc-cleanup.patch
  perthread_pages_alloc cleanup

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

fs-reiser4-possible-cleanups.patch
  fs/reiser4/: possible cleanups

reiser4-kconfig-help-cleanup.patch
  reiser4 Kconfig help cleanup

reiser4-cleanup-pg_arch_1.patch
  reiser4 cleanup (PG_arch_1)

reiser4-build-fix.patch
  reiser4 build fix

reiser4-only-memory_backed-fix.patch
  reiser4-only-memory_backed-fix

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

generic-serial-cli-conversion.patch
  generic-serial cli() conversion

specialix-io8-cli-conversion.patch
  Specialix/IO8 cli() conversion

sx-cli-conversion.patch
  SX cli() conversion

au1x00_uart-deadlock-fix.patch
  au1x00_uart deadlock fix

sealevel-8-port-rs-232-rs-422-rs-485-board.patch
  sealevel 8 port RS-232/RS-422/RS-485 board

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

vt-dont-call-unblank-at-irq-time.patch
  vt: don't call unblank at irq time

ppc32-move-powermac-backlight-stuff-to-a-workqueue.patch
  ppc32: move powermac backlight stuff to a workqueue

radeonfb-implement-proper-workarounds-for-pll-accesses.patch
  radeonfb: Implement proper workarounds for PLL accesses

radeonfb-ddc-i2c-fix.patch
  radeonfb: DDC i2c fix

fbdev-nvidia-licensing-clarification.patch
  fbdev: mvidia licensing clarification

md-merge-md_enter_safemode-into-md_check_recovery.patch
  md: merge md_enter_safemode into md_check_recovery

md-improve-locking-on-safemode-and-move-superblock-writes.patch
  md: improve locking on 'safemode' and move superblock writes

md-improve-the-interface-to-sync_request.patch
  md: improve the interface to sync_request

md-optimised-resync-using-bitmap-based-intent-logging.patch
  md: optimised resync using Bitmap based intent logging

md-printk-fix.patch
  md printk fix

md-optimised-resync-using-bitmap-based-intent-logging-fix.patch
  md-optimised-resync-using-bitmap-based-intent-logging fix

md-raid1-support-for-bitmap-intent-logging.patch
  md: raid1 support for bitmap intent logging

md-raid1-support-for-bitmap-intent-logging-fix.patch
  md: initialise sync_blocks in raid1 resync

md-optimise-reconstruction-when-re-adding-a-recently-failed-drive.patch
  md: optimise reconstruction when re-adding a recently failed drive.

md-fix-deadlock-due-to-md-thread-processing-delayed-requests.patch
  md: fix deadlock due to md thread processing delayed requests.

verify_area-cleanup-drivers-part-1.patch
  verify_area cleanup : drivers part 1

verify_area-cleanup-drivers-part-2.patch
  verify_area cleanup : drivers part 2

verify_area-cleanup-sound.patch
  verify_area cleanup : sound

verify_area-cleanup-sound-fix.patch
  sound/oss/soundcard.c: remove an unused variable

verify_area-cleanup-i386-and-misc.patch
  verify_area cleanup : i386 and misc.

verify_area-cleanup-mips.patch
  verify_area cleanup: mips

verify_area-cleanup-ppc-ppc64-m68k-m68knommu.patch
  verify_area cleanup : ppc, ppc64, m68k, m68knommu

verify_area-cleanup-sparc-and-sparc64.patch
  verify_area cleanup : sparc and sparc64

verify_area-cleanup-x86_64-and-ia64.patch
  verify_area cleanup : x86_64 and ia64

verify_area-cleanup-misc-remaining-archs.patch
  verify_area cleanup : misc remaining archs

verify_area-cleanup-deprecate.patch
  verify_area cleanup : deprecate
  verify_area-cleanup-deprecate fix

arch_alpha_kernel_osf_sys-tiny-cleanup-retvalpatch.patch
  arch/alpha/kernel/osf_sys: tiny cleanup to retval

arch_alpha_kernel_osf_sys-tiny-cleanup-retvalpatch-fix.patch
  arch_alpha_kernel_osf_sys-tiny-cleanup-retvalpatch-fix

fs_compat-tiny-cleanup-retvalpatch.patch
  fs_compat: tiny cleanup t retval

arch_mips_kernel_irixsig-slight-rework-of-irix_sigsendsetpatch.patch
  arch/mips/kernel/irixsig: slight rework of irix_sigsendset

arch_sparc_kernel_ptrace-pointless-assignment-and-shadowed-varpatch.patch
  arch/sparc/kernel/ptrace: pointless assignment and shadowed var

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

post-halloween-doc.patch
  post halloween doc

fuse-maintainers-kconfig-and-makefile-changes.patch
  FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  FUSE - core

fuse-device-functions.patch
  FUSE - device functions

fuse-read-only-operations.patch
  FUSE - read-only operations

fuse-read-write-operations.patch
  FUSE - read-write operations

fuse-file-operations.patch
  FUSE - file operations

fuse-mount-options.patch
  FUSE - mount options

fuse-extended-attribute-operations.patch
  FUSE - extended attribute operations

fuse-readpages-operation.patch
  FUSE - readpages operation

fuse-nfs-export.patch
  FUSE - NFS export

fuse-direct-i-o.patch
  FUSE - direct I/O

fuse-transfer-readdir-data-through-device.patch
  fuse: transfer readdir data through device

cryptoapi-prepare-for-processing-multiple-buffers-at.patch
  CryptoAPI: prepare for processing multiple buffers at a time

cryptoapi-update-padlock-to-process-multiple-blocks-at.patch
  CryptoAPI: Update PadLock to process multiple blocks at  once

oprofile-make-some-code-static.patch
  oprofile: make some code static

update-email-address-of-andrea-arcangeli.patch
  update email address of Andrea Arcangeli

i386-cpu-commonc-some-cleanups.patch
  i386 cpu/common.c: some cleanups

i386-x86_64-io_apicc-misc-cleanups.patch
  i386/x86_64 io_apic.c: misc cleanups

3w-abcdh-tw_device_extension-remove-an-unused-filed.patch
  3w-abcd.h: TW_Device_Extension: remove an unused field

kill-aux_device_present.patch
  kill aux_device_present

mostly-i386-mm-cleanup.patch
  (mostly i386) mm cleanup

update-email-address-of-benjamin-lahaise.patch
  Update email address of Benjamin LaHaise

update-email-address-of-philip-blundell.patch
  Update email address of Philip Blundell

saa7146_vv_ksymsc-remove-two-unused-export_symbol_gpls.patch
  saa7146_vv_ksyms.c: remove two unused EXPORT_SYMBOL_GPL's

fix-placement-of-static-inline-in-nfsdh.patch
  fix placement of static inline in nfsd.h

mm-page-writebackc-remove-an-unused-function.patch
  mm/page-writeback.c: remove an unused function

misc-isapnp-cleanups.patch
  misc ISAPNP cleanups

some-pnp-cleanups.patch
  some PNP cleanups

make-loglevels-in-init-mainc-a-little-more-sane.patch
  Make loglevels in init/main.c a little more sane.

isicom-use-null-for-pointer.patch
  sparse: use NULL for pointer

remove-bouncing-email-address-of-hennus-bergman.patch
  remove bouncing email address of Hennus Bergman

i386-apic-kconfig-cleanups.patch
  i386 APIC Kconfig cleanups

remove-bouncing-email-address-of-thomas-hood.patch
  remove bouncing email address of Thomas Hood

fs-adfs-dir_fc-remove-an-unused-function.patch
  fs/adfs/dir_f.c: remove an unused function

drivers-char-moxac-if-0-an-unused-function.patch
  drivers/char/moxa.c: #if 0 an unused function

oss-sb_cardc-no-need-to-include-mcah.patch
  OSS sb_card.c: no need to include mca.h

ioschedc-use-proper-documentation-path.patch
  *-iosched.c: Use proper documentation path

small-drivers-video-kyro-cleanups.patch
  small drivers/video/kyro/ cleanups

drivers-block-cpqarrayc-small-cleanups.patch
  drivers/block/cpqarray.c: small cleanups

pcxx-remove-obsolete-driver.patch
  pcxx: Remove obsolete driver

warning-fix-in-drivers-cdrom-mcdc.patch
  warning fix in drivers/cdrom/mcd.c

wavefront-reduce-stack-usage.patch
  wavefront: reduce stack usage

mm-page-writebackc-remove-an-unused-function-2.patch
  mm/page-writeback.c: remove an unused function #2

generic_serialh-kill-incorrect-gs_debug-reference.patch
  generic_serial.h: kill incorrect gs_debug reference

remove-the-unused-oss-maestro_tablesh.patch
  remove the unused OSS maestro_tables.h

fs-hfs-misc-cleanups.patch
  fs/hfs/: misc cleanups

fs-hfsplus-misc-cleanups.patch
  fs/hfsplus/: misc cleanups

i386-math-emu-misc-cleanups.patch
  i386/math-emu/: misc cleanups

non-pc-parport-config-change.patch
  non-PC parport config change

prism54-misc-cleanups.patch
  prism54: misc cleanups

scsi-qlogicfcc-some-cleanups.patch
  SCSI qlogicfc.c: some cleanups

scsi-qlogicispc-some-cleanups.patch
  SCSI qlogicisp.c: some cleanups

hpet-setup-comment-fix.patch
  hpet setup comment fix

kill-iphase5526.patch
  kill IPHASE5526

i386-x86_64-acpi-sleepc-kill-unused-acpi_save_state_disk.patch
  i386/x86_64: acpi/sleep.c: kill unused acpi_save_state_disk

smpbootc-cleanups.patch
  smp{,boot}.c cleanups

i386-kernel-i387c-misc-cleanups.patch
  i386/kernel/i387.c: misc cleanups

mxserc-remove-unused-variable.patch
  mxser.c: remove unused variable

update-panic-comment.patch
  Update panic() comment

pm3fb-remove-kernel-22-code.patch
  pm3fb: remove kernel 2.2 code

drivers-block-paride-cleanups.patch
  drivers/block/paride/ cleanups (fwd)

remove-obsolete-linux-resourceh-inclusion-from-asm-generic-siginfoh.patch
  remove obsolete linux/resource.h inclusion from asm-generic/siginfo.h

fix-pm_message_t-in-generic-code.patch
  Fix pm_message_t in generic code

fix-u32-vs-pm_message_t-in-usb.patch
  Fix u32 vs. pm_message_t in USB

fix-u32-vs-pm_message_t-in-usb-fix.patch
  fix-u32-vs-pm_message_t-in-usb fix

more-pm_message_t-fixes.patch
  more pm_message_t fixes

fix-u32-vs-pm_message_t-confusion-in-oss.patch
  Fix u32 vs. pm_message_t confusion in OSS

fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
  Fix u32 vs. pm_message_t confusion in PCMCIA

fix-u32-vs-pm_message_t-confusion-in-framebuffers.patch
  Fix u32 vs. pm_message_t confusion in framebuffers

fix-u32-vs-pm_message_t-confusion-in-mmc.patch
  Fix u32 vs. pm_message_t confusion in MMC

fix-u32-vs-pm_message_t-confusion-in-serials.patch
  Fix u32 vs. pm_message_t confusion in serials

fix-u32-vs-pm_message_t-in-macintosh.patch
  Fix u32 vs. pm_message_t in macintosh

fix-u32-vs-pm_message_t-confusion-in-agp.patch
  Fix u32 vs. pm_message_t confusion in AGP

fs-jffs-misc-cleanups.patch
  fs/jffs/: misc cleanups

fs-jffs2-misc-cleanups.patch
  fs/jffs2/: misc cleanups

drivers-block-cciss-misc-cleanups.patch
  drivers/block/cciss*: misc cleanups

remove-unused-get_resource_list-declaration.patch
  Remove unused get_resource_list() declaration

typo-in-include-linux-compilerh.patch
  typo in include/linux/compiler.h

mark-blk_dev_ps2-as-broken.patch
  mark BLK_DEV_PS2 as BROKEN

vsprintfc-cleanups.patch
  vsprintf.c cleanups

i386-scx200c-misc-cleanups.patch
  i386 scx200.c: misc cleanups

unexport-mmu_cr4_features.patch
  unexport mmu_cr4_features

drivers-char-mxserc-cleanups.patch
  drivers/char/mxser.c cleanups

drivers-char-mwave-smapic-small-cleanups.patch
  drivers/char/mwave/smapi.c: small cleanups

drivers-char-specialixc-misc-cleanups.patch
  drivers/char/specialix.c: misc cleanups

drivers-char-sysrqc-remove-the-unused-sysrq_power_off.patch
  drivers/char/sysrq.c: remove the unused sysrq_power_off

small-partitions-msdos-cleanups.patch
  small partitions/msdos cleanups

drivers-char-vt-cleanups.patch
  drivers/char/vt*: cleanups

removes-unused-label-from-drivers-isdn-hisax-hisax_fcpcipnpc.patch
  Removes unused label from /drivers/isdn/hisax/hisax_fcpcipnp.c

procfs-fix-printk-arg-type-warning.patch
  procfs: fix printk arg type warning

isdn-fix-gcc-data-type-size-warning.patch
  isdn: fix gcc data type/size warning

w1-fix-printk-format-warning.patch
  W1: fix printk format warning

zoran-fix-printk-format-types.patch
  zoran: fix printk format types

hweight-typecast-return-types.patch
  hweight: typecast return types

i386-unexport-dmi_get_system_info.patch
  i386: unexport dmi_get_system_info

unexport-pcibios_penalize_isa_irq.patch
  unexport pcibios_penalize_isa_irq

list_for_each_entry-arch-i386-mm-pageattrc.patch
  list_for_each_entry: arch-i386-mm-pageattr.c

gus_wavec-vfree-checking-cleanups.patch
  gus_wave.c - vfree() checking cleanups

i386-traps-replace-schedule_timeout-with-ssleep.patch
  i386/traps: replace schedule_timeout() with ssleep()

radio-sf16fmi-cleanup.patch
  radio-sf16fmi boot parameter cleanup

unified-spinlock-initialization-include-linux-waith.patch
  Unified spinlock initialization include/linux/wait.h

scripts-mod-sumversionc-replace-strtok-with-strsep.patch
  scripts/mod/sumversion.c: replace strtok() with strsep()

char-snsc-reorder-set_current_state-and-add_wait_queue.patch
  char/snsc: reorder set_current_state() and add_wait_queue()

char-hvsi-use-wait_event_timeout.patch
  char/hvsi: use wait_event_timeout()

char-sx-replace-schedule_timeout-with-msleep_interruptible.patch
  char/sx: replace schedule_timeout() with msleep_interruptible()

serial-crisv10-replace-schedule_timeout-with-msleep.patch
  serial/crisv10: replace schedule_timeout() with msleep()

ftape-fdc-io-insert-set_current_state-before-schedule_timeout.patch
  ftape/fdc-io: insert set_current_state() before schedule_timeout()

tc-zs-replace-schedule_timeout-with-msleep_interruptible.patch
  tc/zs: replace schedule_timeout() with msleep_interruptible()

delete-unused-file-drivers_char_hp600_keybc.patch
  delete unused file drivers_char_hp600_keyb.c

drivers-isdn-hardware-avm-convert-to-pci_register_driver.patch
  drivers/isdn/hardware/avm/*: convert to pci_register_driver

message-mptbase-replace-schedule_timeout-with-ssleep.patch
  message/mptbase: replace schedule_timeout() with ssleep()

drivers-message-fusion-convert-to-pci_register_driver.patch
  drivers/message/fusion/*: convert to pci_register_driver

drivers-eisa-convert-to-pci_register_driver.patch
  drivers/eisa/*: convert to pci_register_driver

char-lp-remove-interruptible_sleep_on_timeout-usage.patch
  char/lp: remove interruptible_sleep_on_timeout() usage

char-istallion-replace-interruptible_sleep_on-with-wait_event_interruptible.patch
  char/istallion: replace interruptible_sleep_on() with wait_event_interruptible()

list_for_each_entry-arch-um-drivers-chan_kernc.patch
  list_for_each_entry: arch-um-drivers-chan_kern.c

mips-fix-section-type-conflict-about-mpc30x.patch
  mips: fix section type conflict about mpc30x

macintosh-mediabay-replace-schedule_timeout-with-msleep_interruptible.patch
  macintosh/mediabay: replace schedule_timeout() with msleep_interruptible()

drivers-macintoshisdn-convert-to-pci_register_driver.patch
  drivers/macintoshisdn/*: convert to pci_register_driver

unexport-flush_tlb_all.patch
  unexport *flush_tlb_all

unexport-kmap_pteport-on-ppc.patch
  unexport kmap_{pte,port} on !ppc

i386-power-cpuc-remove-three-unused-variables.patch
  i386/power/cpu.c: remove three unused variables

cyrix-eliminate-bad-section-references.patch
  cyrix: eliminate bad section references



