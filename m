Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268073AbUHZJNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268073AbUHZJNw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUHZJME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:12:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:49565 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267971AbUHZItg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:49:36 -0400
Date: Thu, 26 Aug 2004 01:47:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm1
Message-Id: <20040826014745.225d7a2c.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/


- nicksched is still here.  There has been very little feedback, except that
  it seems to slow some workloads on NUMA.

- Added a __must_check to the x86 copy_*_user functions.  This means that
  with a sufficiently recent gcc, all unchecked copy_*_user() calls will
  generate a warning.

  I fixed a few things, but binfmt_elf.c is a mess.

  It's not clear how to apply the same debug check to put_user() and
  friends.




Changes since 2.6.8.1-mm4:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-dma-declare-coherent-memory.patch
 bk-drm.patch
 bk-ia64.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-jfs.patch
 bk-pnp.patch
 bk-power.patch
 bk-scsi.patch
 bk-usb.patch

 Latest versions of external trees

-add_pin_to_irq-section-fix.patch
-procfs-taskname-locking.patch
-fix-reading-string-module-parameters-in-sysfs.patch
-ppc32-remove-hardcoded-offsets-from-ppc-asm.patch
-ppc32-optimize-fix-timer_interrupt-loop.patch
-ppc32-make-ppc40x-large-tlb-mapping-optional.patch
-ppc32-handle-misaligned-string-multiple-insns.patch
-ppc32-emulate-obsolete-instructions.patch
-ppc32-emulate-obsolete-instructions-fix.patch
-ppc32-add-docs-for-ppc-noltlbs-and-nobats-parameters.patch
-ppc32-export-__dma_sync-__dma_sync_page.patch
-ppc32-fix-bug-in-altivec-emulation.patch
-ppc32-fix-booting-on-some-oldwolrd-macs.patch
-ppc32-fix-warnings-on-ebony-mtd-build.patch
-ppc64-reduce-stack-overflow-warning-threshold.patch
-ppc64-remove-old-asm-offsets.patch
-ppc64-set-time-related-systemcfg-fields.patch
-ppc64-include-profilec-in-kernel-irqc.patch
-ppc64-1-4-use-platform-numbering-of-cpus-for-hypervisor-calls.patch
-ppc64-2-4-use-cpu_present_map-in-ppc64.patch
-ppc64-3-4-rework-secondary-smt-thread-setup-at-boot.patch
-ppc64-4-4-remove-unnecessary-cpu-maps.patch
-ppc64-power4-oprofile-update.patch
-ppc64-disable-oprofile-debug-messages.patch
-ppc64-allow-oprofile-module-to-be-safely-unloaded.patch
-ppc64-add-missing-export_symbols-for-oprofile.patch
-ppc64-fix-oprofile-error-messages.patch
-ppc64-set-tbl-it_type-in-iommu-code.patch
-ppc64-dont-call-scheduler-on-offline-cpu.patch
-ppc64-fix-idle-loop-for-offline-cpu.patch
-ppc64-c99-initializers-in-init_thread.patch
-ppc64-log-firmware-errors-during-boot.patch
-ppc64-fix-unbalanced-pci_dev_put-in-eeh-code.patch
-ppc64-reduce-verbosity-of-rtas-error-logs.patch
-ppc64-fix-v_regs-pointer-setup.patch
-ppc64-hvsi-driver.patch
-ppc64-bolted-slb-entry-for-iseries.patch
-ppc64-switch-screen_info-init-to-c99.patch
-ppc64-cpu-death-sched-timeout.patch
-ppc64-memcpy_toio-function-signature.patch
-ppc64-rtas_call-was-calling-kmalloc-too-early.patch
-ppc64-better-little-endian-bitops.patch
-ppc64-iseries-virtual-dvd-ram.patch
-ppc64-extend-ioremap-iounmap-infrastructure.patch
-ppc64-use-correct-buffer-size-in-rtas-call.patch
-ppc64-mf_proc-file-position-fix.patch
-hvcs-fixes-suggested-by-jeff-garzik-on-july-29th.patch
-ibmveth-module-tag-fixes.patch
-ibmveth-race-fix.patch
-ibmveth-hypervisor-retval-fix.patch
-ibmveth-hypervisor-memory-barrier.patch
-i2c-keywestc-build-fix.patch
-alsa-build-fix.patch
-nmi-trigger-switch-support-for-debuggingupdated.patch
-make-i386-die-more-resilient-against-recursive-errors.patch
-fix-visws-kernel-build.patch
-oops-dump-preceding-code.patch
-really-ptrace-single-step-2.patch
-disk-barrier-core.patch
-disk-barrier-ide.patch
-disk-barrier-scsi.patch
-disk-barrier-dm.patch
-disk-barrier-md.patch
-sync_dirty_buffer-retval.patch
-add-bh_eopnotsupp-for-testing.patch
-reiserfs-v3-barrier-support.patch
-ext3-barrier-support.patch
-blk_queue_free_tags-fix.patch
-blk_resize_tags-fix.patch
-blk_queue_tags_resize_failure.patch
-multipath-readahead-fix-fix.patch
-sched-timeslice-fix.patch
-sched-clean-init-idle.patch
-sched-clean-fork.patch
-kernelthread-idle-fix-2.patch
-sched-misc-cleanups-2.patch
-sched-unlikely-rt_task.patch
-sched-misc.patch
-sched-no-balance-clone.patch
-sched-remove-balance-clone.patch
-sched-fork-hotplug-cleanuppatch.patch
-sched-consolidate-sched-domains.patch
-sched-domain-node-span-4.patch
-sched-domain-node-span-4-update.patch
-sched-domain-node-span-4-update-warning-fix.patch
-sched-domain-node-span-4-fix2.patch
-sched-isolated-sched-domains.patch
-create-cpu_sibling_map-for-ppc64.patch
-sched-adjust-p4-per-cpu-gain.patch
-schedstat-v10.patch
-move-config_schedstats-to-arch-ppc64-kconfigdebug.patch
-sched-init_idle-fork_by_hand-consolidation.patch
-sched-sparc32-fix.patch
-schedstat-up-fix.patch
-sched-whitespace-cleanups.patch
-sched-nonlinear-timeslicespatch.patch
-sched-new-task-fix.patch
-release_task-may-sleep.patch
-sched-self-reap-fix.patch
-sched-smt-fixes.patch
-sched-smt-fixes-fix.patch
-memory-backed-inodes-fix.patch
-flexible-mmap-2.6.7-mm3-A8.patch
-flexmmap-patchkit-fix-for-32-bit-emu-for-64-bit-arches.patch
-sysctl-tunable-for-flexmmap.patch
-flex-mmap-for-s390x.patch
-flex-mmap-for-ppc64.patch
-posix-locking-posix_same_owner-fixes.patch
-posix-locking-hook-functions.patch
-posix-locking-nfsv4-server.patch
-posix-locking-lockd-fixes.patch
-posix-locking-lifetime-fixes.patch
-posix-locking-move-file-lock-fields.patch
-posix-locking-filesystems-call-posix_lock_file.patch
-r8169_napi-help-text-2.patch
-no-sysgood-for-ptrace-singlestep.patch
-err2-6-hashbin_remove_this-locking-fix.patch
-dm-use-idr.patch
-ipc-1-3-add-refcount-to-ipc_rcu_alloc.patch
-ipc-2-3-remove-sem_revalidate.patch
-ipc-3-3-enforce-semvmx-limit-for-undo.patch
-cleanup-of-ipc-msgc.patch
-sk98lin-procfs-fix.patch
-uml-base-patch.patch
-uml-remove-cow-driver.patch
-uml-updates-2.patch
-uml-sched-update.patch
-rename-uml-console-device.patch
-uml-readds-just-for-now-ghashh-for-uml.patch
-uml-avoid-that-gcc-breaks-uml-with-unit-at-a-time-compilation-mode.patch
-uml-fixes-an-host-fd-leak-caused-by-hostfs.patch
-uml-adds-legacy_pty-config-option.patch
-uml-makes-make-help-arch=um-work.patch
-uml-fixes-fixdepc-to-support-arch-um-include-uml-configh.patch
-uml-kill-useless-warnings.patch
-uml-avoids-compile-failure-when-host-misses-tkill.patch
-uml-reduces-code-in-_user-files-by-moving-it-in-_kern-files-if-already-possible.patch
-uml-fixes-raw-and-uses-it-in-check_one_sigio-also-fixes-a-silly-panic-eintr-returned-by-call.patch
-uml-folds-hostaudio_userc-into-hostaudio_kernc.patch
-uml-use-ptrace_scemu-the-so-called-sysemu-to-reduce-syscall-cost.patch
-uml-adds-the-nosysemu-command-line-parameter-to-disable-sysemu.patch
-uml-adds-proc-sysemu-to-toggle-sysemu-usage.patch
-uml-fix-for-sysemu-patches.patch
-uml-handles-correctly-errno-==-eintr-in-lots-of-places.patch
-uml-adds-some-exports.patch
-uml-avoids-a-panic-for-a-legal-situation.patch
-uml-removes-dead-code-in-trap_kernc.patch
-uml-make-malloc-call-vmalloc-if-needed-needed-for-hostfs-on-26-host.patch
-uml-little-kmalloc.patch
-uml-fix-os_process_pc-and-os_process_parent-for-corner-cases.patch
-uml-remove-a-group-of-unused-bh-functions.patch
-uml-updates.patch
-uml-fixes.patch
-make-uml-build-and-run.patch
-i810_audio-fix-the-error-path-of-resource-management.patch
-fix-drivers-isdn-hisax-avm_pcic-build-warning-when.patch
-idr-stale-comment.patch
-schedule-profiling.patch
-crc16-renaming-in-via-velocity-ethernet-driver.patch
-per_cpu-per_cpu-cpu_gdt_table.patch
-per_cpu-per_cpu-cpu_gdt_table-fix.patch
-per_cpu-per_cpu-init_tss.patch
-per_cpu-per_cpu-cpu_tlbstate.patch
-gcc35-alps_tdlb7.c.patch
-gcc35-always-inline.patch
-gcc35-auerswald.c.patch
-gcc35-dabusb.c.patch
-gcc35-ds.c.patch
-gcc35-fixmap.h.patch
-gcc35-mtrr.h.patch
-gcc35-sonypi.patch
-gcc35-sp887x.c.patch
-gcc35-tda1004x.c.patch
-gcc35-transport.h.patch
-gcc35-ufs_fs.h.patch
-gcc35-videodev.c.patch
-gcc35-wavefront_fx.c.patch
-net-kconfig-crc16-fix.patch
-preset-loops_per_jiffy-for-faster-booting.patch
-define-inline-as-__attribute__always_inline-also-for-gcc-=-34.patch
-gcc-34-and-broken-inlining.patch
-split-generic_file_aio_write-into-buffered-and-direct-i-o-parts.patch
-making-i-dhash_entries-cmdline-work-as-it-use-to.patch
-making-i-dhash_entries-cmdline-work-as-it-use-to-fix.patch
-send_IPI_mask_bitmask-build-fix.patch
-e1000-build-fix.patch
-e1000-inlining-fix.patch
-enable-all-events-for-initramfs.patch
-arch-i386-kernel-smpc-gcc341-inlining-fix.patch
-268-rc2-mm2-warning-on-numa-q.patch
-was-removal-of-sync-in-panic.patch
-move-cache_reap-out-of-timer-context.patch
-gettimeofday-nanoseconds-patch-makes-it-possible-for-the-posix-timer.patch
-x86-64-singlestep-through-sigreturn-system-call-2.patch
-remove-dead-prototypes.patch
-s390-use-include-asm-generic-dma-mapping-brokenh.patch
-cdrom-get_last_written-fix.patch
-get_random_bytes-returns-the-same-on-every-boot.patch
-locking-optimization-for-cache_reap.patch
-signal-race-fix.patch
-signal-race-fix-ia64.patch
-signal-race-fix-s390.patch
-signal-race-fix-x86_64.patch
-ppc-signal-handling-fixes.patch
-signal-race-fixes-sparc-sparc64.patch
-signal-race-fixes-ppc64.patch
-signal-race-fix-alpha.patch
-move-pit-code-to-timer_pit.patch
-i2o-build_111.patch
-i2o-build_111-build-fix.patch
-i2o-add-functionality-to-scsi_add_device-to-preset-hostdata.patch
-i2o-remove-on-demand-allocation-of-scsi_hosts-in-i2o_scsi.patch
-i2o-run-linux-i2oh-and-linux-i2o-devh-through-lindent.patch
-i2o-fixes-compiler-warning-on-x86_64-in-i2o_config.patch
-i2o-removes-multiplexer-notification-and-use-type-safe.patch
-i2o-maintainer.patch
-apic-output-reduction.patch
-make-shrinker_sem-an-rwsem.patch
-break-out-zone-free-list-initialization.patch
-radeonfb-cleanup-and-little-fixes.patch
-rivafb-i2c-fixes.patch
-fbmon-edd-blacklist.patch
-fbcon-differentiate-bits_per_pixel-from-color-depth.patch
-fbdev-set-color-fields-correctly.patch
-fbdev-attn-maintainers-set-correct-hardware-capabilities.patch
-rivafb-do-not-tap-vga-ports-if-not-x86.patch
-i810fb-fixes.patch
-fbdev-find-correct-logo-for-directcolor-24bpp.patch
-rivafb-kill-riva_chip_info-and-riva_chips.patch
-include-compilerh-in-videodevh.patch
-fbdev-kconfig-dependency-fix.patch
-video-mode-handling-linked-list-of-video-modes.patch
-video-mode-handling-save-per-display-graphics-display-settings.patch
-video-mode-handling-delete-entries-from-mode-list.patch
-video-mode-handling-reduce-memory-footprint-of-fbdev.patch
-fbdev-do-the-deletion-of-mode-entries-at-fbdev-level.patch
-fbdev-support-for-bold-attribute-for-monochrome-framebuffers.patch
-fbdev-use-8-bit-dac-for-capable-hardware.patch
-rivafb-directcolor-mode-and-miscellaneous-fixes.patch
-epson1355fb-salvage-epson1355-code-from-james-tree.patch
-neofb-salvage-neofb-from-james-tree.patch
-neofb-build-fix.patch
-sgivwfb-salvage-sgivwfb-from-james-tree.patch
-tdfxfb-salvage-tdfxfb-from-james-tree.patch
-net-smc9194c-fix-inline-compile-errors-fwd.patch
-net-hamachic-remove-bogus-inline-at-function-prototype.patch
-net-rrunnerc-fix-inline-compile-error.patch
-istallion-remove-inlines.patch
-mxserc-fix-inlines-fwd.patch
-radio-maestroc-remove-an-inline-fwd.patch
-net-tulip-dmfec-fix-inline-compile-errors-fwd.patch
-fix-inlining-errors-in-drivers-scsi-aic7xxx-aic79xx_osmc.patch
-fix-inline-related-gcc-34-build-failures-in.patch
-igxb_main-gcc-34-build-fix.patch
-ext2_readdir-filp-f_pos-fix.patch
-do_general_protection-doesnt-disable-irq.patch
-proc_pid_cmdline-race-fix.patch
-support-for-exar-xr17c158-octal-uart.patch
-x86_64-merge-2.patch
-x86_64-merge-2-build-fix.patch
-fix-o=-compilation-on-x86-64.patch
-altix-system-controller-communication-driver.patch
-snsc-build-fix.patch
-more-altix-system-controller-changes.patch
-altix-system-controller-fixes.patch
-move-duplicate-bug-and-warn_on-bits-to-asm-generic.patch
-move-duplicate-bug-and-warn_on-bits-to-asm-generic-fix.patch
-fix-con_buf_size-usage.patch
-vprintk-support.patch
-vprintk-for-ext2-errors.patch
-vprintk-for-ext3-errors.patch
-prio_tree-kill-vma_prio_tree_init.patch
-prio_tree-iterator-vma_prio_tree_next-cleanup.patch
-rcu-cpu-offline-cleanup.patch
-rcu-rcu-cpu-offline-fix.patch
-rcu-low-latency-rcu.patch
-rcu-clean-up-code.patch
-rcu-fix-spaces-in-rcupdateh.patch
-rcu-introduce-call_rcu_bh.patch
-rcu-use-call_rcu_bh-in-route-cache.patch
-rcu-document-rcu-api.patch
-rcu-abstracted-rcu-dereferencing.patch
-alpha-print-the-symbol-of-pc-and-ra-during-oops.patch
-first-next_cpu-returns-values-nr_cpus.patch
-drivers-net-wan-cycx_x25c189-warning-conflicting-types.patch
-watchdog-fix-warning-defined-but-not-used.patch
-token-based-thrashing-control.patch
-writeback-page-range-hint.patch
-fix-writeback-page-range-to-use-exact-limits.patch
-mpage-writepages-range-limit-fix.patch
-filemap_fdatawrite-range-interface.patch
-concurrent-o_sync-write-support.patch
-nfsd-force-server-side-tcp-when-nfsv4-enabled.patch
-nfsd-nfsd-is-missing-a-put_group_info-in-the-auth_null.patch
-nfsd-make-cache_init-initialize-reference-count-to-1.patch
-nfsd-simplify-auth_domain_lookup.patch
-nfsd-fix-ip_map-cache-reference-count-leak.patch
-nfsd-basic-v4-acl-definitions.patch
-nfsd-posix-nfsv4-acl-translation-for-nfsd.patch
-nfsd-acl-support-for-the-nfsv4-server.patch
-knfsd-fix-brokenness-with-fsid=-export-option.patch
-knfsd-get-rid-of-open_private_file.patch
-knfsd-minor-memory-leak-fix.patch
-knfsd-fix-two-xdr-encode-bugs-for-readdirplus-reply.patch
-knfsd-fix-race-with-flushing-nfsd-cache.patch
-knfsd-server-permissions-fix.patch
-cdrom-event-notification-fixes.patch
-new-device-driver-to-enable-the-ibm-multiport-serial-adapter.patch
-iteraid.patch
-kill-udf-registration-unregistration-messages.patch
-sparc-remove-undefined-symbol.patch
-nbd-fix-struct-request-race-condition.patch
-profile-consolidate-prof_cpu_mask.patch
-profile-introduce-profile_pc.patch
-profile-consolidate-hit-count-increments-in-profile_tick.patch
-profile-move-profile_operations.patch
-profile-make-private-profile-state-static.patch
-profile-make-prof_buffer-atomic_t.patch
-remove-iseries-profiling.patch
-ipmi-watchdog-patch.patch
-ipmi-driver-updates.patch
-ipmi-driver-updates-build-fix.patch
-dio-bio-sizing-fix.patch
-dio-pages-in-io-accounting-fix.patch
-is_err-is-unlikely.patch
-is_err-unlikeliness-cleanup.patch
-fix-netpoll-cleanup-on-abort-without-dev.patch
-aioc-rename-struct-timeout-to-struct-aio_timeout.patch
-fix-compiling-oldconfig-with-gcc-35.patch
-dont-pass-mem_map-into-init-functions.patch
-might-sleep-in-atomic-while-dumping-elf.patch
-awe_wave-oss-too-much-__exit.patch
-mark-loop_change_fd-as-an-ulong-compat-ioctl.patch
-readahead-simplification.patch
-consolidated-readahead-fixes.patch
-mlock-as-user-for-268-rc2-mm2.patch
-increase-mlock-limit-to-32k.patch
-idt77252c-add-missing-pci_enable_device.patch
-ip2mainc-add-missing-pci_enable_device.patch
-tpam_mainc-add-missing-pci_enable_device.patch
-ibmasm-add-missing-pci_enable_device.patch
-hp100c-add-missing-pci_enable_device.patch
-ioc3-ethc-add-missing-pci_enable_device.patch
-de4x5c-add-missing-pci_enable_device.patch
-cpqfc-add-missing-pci_enable_device.patch
-fix-gcc-35-compile-issue-in-mm-mempolicyc.patch
-eata_pio-warning-fix.patch
-via-agpc-resume-suspend-support.patch
-collected-aio-retry-fixes-and-enhancements.patch
-aio-splice-runlist-for-fairness-across-io-contexts.patch
-aio-workqueue-context-switch-reduction.patch
-make-max_init_args-25.patch
-request_region-for-winbond-and-smsc-parport-drivers.patch
-make-md-no-device-warning-kern_warning.patch
-ia64-dma_mapping-fix.patch
-automatically-enable-bigsmp-on-big-hp-machines.patch
-fix-proc-pid-statm-documentation.patch
-cciss-update-fixes-to-32-64-bit-conversions.patch
-cciss-updates-zero-out-buffer-in-passthru-ioctls-for-hp.patch
-cciss-updates-proc-fixes-for-268-rc3.patch
-cciss-updates-cylinder-calculation-fix-for-268-rc3.patch
-cciss-updates-id-change-for-v100-controller-for-268-rc3.patch
-cciss-updates-id-change-for-v100-controller-for-268-rc3-fix.patch
-cciss-updates-pdev-intr-fix-for-268-rc3.patch
-cciss-update-7-read_ahead-bumped-to-1024.patch
-cciss-update-8-maintainers-update-for-hp.patch
-cciss-congig-dependency-fix.patch
-rmaplock-1-5-pageanon-in-mapping.patch
-rmaplock-2-5-kill-page_map_lock.patch
-rmaplock-3-5-slab_destroy_by_rcu.patch
-rmaplock-4-5-mm-lock-ordering.patch
-rmaplock-5-5-swapoff-use-anon_vma.patch
-x86-bitopsh-commentary-on-instruction-reordering.patch
-clarify-get_task_mm-mmgrab.patch
-simple-fs-stop-ve-dentries.patch
-8139too-rx-fifo-overflow-recovery.patch
-8139too-be-sure-to-progress-durin-rtl8139_rx.patch
-via-velocity-more-inetaddr_notifier-fix.patch
-vm-tune-writeback.patch
-alloc-pages-watermark-fixes.patch
-alloc-pages-priority-tuning.patch
-fix-d_path-errors.patch
-emu10k1-maintainer-update.patch
-ptr_ok-cleanup.patch
-mpage_readpage-unable-to-handle-bigger-requests.patch
-improve-speed-of-freeing-bootmem.patch
-consolidate-clone_idletask-masking.patch
-kill-clone_idletask.patch
-oprofile-xscale-fixes-for-pxa270-xscale2.patch
-remove-magic-1-from-shm-segment-count.patch
-via-rhine-suspend-resume-support.patch
-via-rhine-de-isolate-phy.patch
-via-rhine-small-fixes.patch
-fix-i386-x86_64-idle-routine-selection.patch
-fix-i386-x86_64-idle-routine-selection-comment-updates.patch
-#fix-some-signed-ints-that-should-be-unsigned.patch
-x86-pae-swapspace-expansion.patch
-executable-hugetlb-pages.patch
-md-fix-problems-with-checksum-handling-in-md-superblocks.patch
-sk98lin-no-procfs-build-fix.patch
-fix-net-hamradio-dmascc-with-gcc-34-fwd.patch
-fix-warnings-in-es7000.patch
-reduce-aacraid-namespace-pollution.patch
-reduce-bkl-usage-in-do_coredump.patch
-apm_infodisabled-fix.patch
-267-rc3-mm2-inlining-failures.patch
-high2lowuid-warning-fix.patch
-new-cpu_has_-flags.patch
-get_nodes-mask-miscalculation.patch
-use-posix-headers-in-sumversionc.patch
-x86-esr-print-quietness.patch
-intel8x0c-sound-use-pci_vendor_id-rather-than-bare-numbers.patch
-fix-rxrpc-compile-errors-with-sysctl=n.patch
-ix86x86_64-cpu-features.patch
-libfs-move-transaction-file-ops-into-libfs.patch
-dont-print-per-cpu-delay-loop-calibration.patch
-fix-sn_console-for-config_smp=n.patch
-via-velocity-wrong-module-name-in-kconfig-documentation.patch
-reduce-ptyc-ifdef-clutter.patch
-bug-on-inconsistant-dcache-tree-in-may_delete.patch
-remove-dead-config_kernel_elf-kconfig-entry.patch
-fix-some-comments-about-epoch-in-arch-alpha-kernel-timec.patch
-small-simplification-for-two-security-dependencies.patch
-configurable-selinux-bootparam-value.patch
-fix-typos-in-security-securityc.patch
-use-simple_read_from_buffer-in-selinuxfs.patch
-use-simple_read_from_buffer-in-proc_info_read-and-proc_pid_attr_read.patch
-fw-new-linux-268-rc4-mm1-ipv6-in-ipv6-undefined-references.patch
-ttys0-vs-ttys00-confusion.patch
-reduce-size-of-struct-buffer_head-on-64bit.patch
-reduce-size-of-struct-dentry-on-64bit.patch
-remove-cacheline-alignment-from-inode-slabs.patch
-read-cpumasks-every-time-when-exporting-through-sysfs.patch
-centralize-i386-constants.patch
-fix-permissions-on-module_param-usage.patch
-module-parameters-in-sysfs-for-built-in-modules.patch
-remove-module_parm-from-main-part-of-kernel.patch
-filemap_index_overflow.patch
-synclinkc-replace-syncppp-with-genhdlc.patch
-synclinkmpc-replace-syncppp-with-genhdlc.patch
-synclink_csc-replace-syncppp-with-genhdlc.patch
-reiserfs-xattr-acl-fixes.patch
-files-up-to-4-gb-support-for-iso9660-filesystems.patch
-selinux-add-null-device-node-to-selinuxfs-remove-open_devnull.patch
-selinux-revalidate-access-to-controlling-tty.patch
-selinux-defer-inode-security-initialization.patch
-selinux-fix-name_bind-audit.patch
-reduce-selinux-kernel-memory-use-on-64-bit-systems.patch
-remove-last-suser-call-drivers-char-rocketc.patch
-add-pci-dependencies-to-drivers-media-dvb-ttpci-kconfig.patch
-compat_do_execve-fix.patch
-fix-4k-ext2fs-support-in-26-initrds.patch
-coding-style-do_thisab-vs-do_thisa-b.patch
-typo-in-laptop_modetxt.patch
-tainted-sysctl-permissions-fix.patch
-s390-core-changes.patch
-s390-zfcp-host-adapter.patch
-s390-lcs-network-driver.patch
-bio_uncopy_user-mem-leak.patch
-bio_uncopy_user-mem-leak-fix.patch
-notify_parent-cleanup.patch
-remove-notify_parent.patch
-i386-unbusy-tss-cleanup.patch
-proc-pid-cmdline-truncates-arguments-early.patch
-update-aci-mixer-driver-webpage.patch
-remove-read-only-immutable-checks-from-fat_truncate.patch
-ext3-documentation.patch
-ad1816-sound-driver-web-page-and-email-address.patch
-firmware-loader-is-orphan.patch
-remove-struct-bus_type-add.patch
-file_ra_state_init-speedup.patch
-dev-random-fix-latency-in-rekeying-sequence-number.patch
-dev-random-add-pool-name-to-entropy-store.patch
-dev-random-use-separate-entropy-store-for-dev-urandom.patch
-dev-random-remove-rndgetpool-ioctl.patch
-fix-bad-url-in-bsd-acct-help-entry.patch
-dothan-speedstep-fix.patch
-shows-active-inactive-on-per-node-meminfo.patch
-shows-active-inactive-on-per-node-meminfo-speedup.patch
-minix-nblocks-retval-fix.patch
-usercopy-return-EFAULT.patch
-intel8x0-latency-fix.patch
-inode-time-update-funnies-in-ncpfs.patch
-fix-oprofile-events-with-zero-event-values.patch
-pci-driver-function-documentation-fix.patch
-vlan-missing-kconfig-help.patch
-remove-obsolete-htab-reclaim-in-documentation-sysctl-kerneltxt.patch
-remove-obsolete-zero-paged-in-documentation-sysctl-kerneltxt.patch
-legousbtower-module_param-fix.patch

 Merged

-context-switching-overhead-in-x-ioport.patch

 Dropped - still in progress.

+auth_unix_lookup-oops-fix.patch
+auth_unix_lookup-oops-fix-fix.patch

 NFS fixes

+fix-show_mem-on-discontig-machines.patch

 show_mem() fix

+fix-sysrq-support-in-sn_consolec.patch

 SN console sysrq fix

+request_region-for-winbond-and-smsc-parport-drivers.patch

 resource allocation fix

+md-fix-problems-with-checksum-handling-in-md-superblocks.patch

 MD checksumming fix (rejected by Linus.  Placeholder)

+scheduler-profiling.patch
+consolidate-prof_cpu_mask.patch
+introduce-profile_pc.patch
+consolidate-hit-count-increments-in-profile_tick.patch
+move-profile_operations.patch
+make-private-profile-state-static.patch
+make-prof_buffer-atomic_t.patch
+remove-iseries-profiling.patch

 Updated profiling patch series

+reduce-size-of-struct-inode-on-64bit.patch

 Pack inodes better.

+ppc32-refactor-common-book-e-exception-handling-macros.patch
+ppc64-clean-up-unused-macro.patch

 ppc fixes

+lockmeter-for-x86_64.patch

 Implement lockmeter on x86_64

+make-perfctr_virtual-default-in-kconfig-match-recommendation.patch

 perfctr Kconfig fix

+linux-2.6.8.1-49-rpc_workqueue.patch
+linux-2.6.8.1-50-rpc_queue_lock.patch

 NFS updates

+add-some-key-management-specific-error-codes.patch

 Add new errno codes for the key management stuff

+mostly-remove-module_parm.patch

 module_parm() removals

+assign_irq_vector-section-fix.patch
+find_isa_irq_pin-should-not-be-__init.patch

 Some functions can no longer be in __init with kexec

-kexec-i8259-sysfsx86_64.patch
-kexec-x86_64-i8259-fixes.patch

 These were unneeded

+kexec-i8259-shutdown-x86_64.patch

 Implement 8259 shutdown handlers on x86_64

+cpusets-config_cpusets-depends-on-smp.patch
+cpusets-tasks-file-simplify-format-fixes.patch
+cpusets-simplify-memory-generation.patch

 cpusets stuff

+reiser4-prefetch-warning-fix.patch
+reiser4-mode-fix.patch
+reiser4-get_context_ok-warning-fixes.patch

 reiser4 fixlets

+split-timer-resources.patch

 timer reosurce allocation fix

+reduce-casting-in-sysenterc.patch
+cast-page_offset-math-to-void-in-early-printk.patch
+call-virt_to_page-with-void-not-ul.patch
+vmalloc_fault-cleanup.patch
+dont-align-virt_to_page-args.patch

 cleanups

+include-asm-pageh-for-virt_to_page.patch

 build fix

+task_vsize-locking-cleanup.patch
+task_vsize-locking-cleanup-warning-fix.patch
+o1-proc_pid_statm.patch
+o1-proc_pid_statm-fix.patch
+task-statm-no-procfs-fix.patch
+task-statm-reserved-fix.patch
+task-statm-dontcopy-fix.patch

 Various speedups and fixups for /proc/pid/statm and related areas

+r8169-add-ethtool_opsget_regs_len-get_regs.patch
+r8169-per-device-receive-buffer-size.patch
+r8169-code-cleanup.patch
+r8169-enable-mwi.patch
+r8169-bump-version-number.patch
+r8169-sync-the-names-of-a-few-bits-with-the-8139cp-driver.patch
+r8169-comment-a-gcc-295x-bug.patch
+r8169-tx-checksum-offload.patch
+r8169-advertise-dma-to-high-memory.patch
+r8169-rx-checksum-support.patch
+r8169-vlan-support.patch

 net driver updates

+sane-mlock_limit.patch

 Make the default non-priv mlock limit sensible on larger PAGE_SIZE

+lanana-maintainer-devicestxt-patch-1-2.patch

 LANANA has a new owner

+lanana-maintainer-devicestxt-2.patch

 sync up devices.txt

+netmos-9805-parport-interface.patch

 parport driver device support

+s390-lcs-network-driver.patch
+s390-common-i-o-layer.patch
+s390-sclp-driver-changes.patch
+s390-qeth-network-driver.patch

 s390 udpates

+269-rc1-ifdef-fixes-for-drivers-isdn-hifax.patch
+269-rc1-ifdef-cleanup-for-sh64.patch
+269-rc1-ifdef-cleanup-for-cris-port.patch
+269-rc1-ifdef-cleanup-for-ppc.patch
+269-rc1-ifdef-cleanups-in-drivers-net.patch
+make-oom-killer-points-unsigned-long.patch

 cleanups

+dvb-pci_enable_device-fix.patch

 Fix a dvb driver's pci handling

+copying-unaligned-data-across-user-kernel-boundary.patch

 Fix compat-mode directory copying

+re-fix-pagecache-reading-off-by-one.patch
+re-fix-pagecache-reading-off-by-one-cleanup.patch

 Fix the off-by-one in the pagecache read() function again

+waitqueue_debug-crapectomy.patch

 cleanup

+ftape-support-for-x86_64.patch

 Add ftape support for x86_64

+keep-sparc32-config-consistent.patch

 sparc32 Kconfig fix

+fix-typo-in-bw2c.patch

 Fix some typo

+interrupt-is-enabled-before-it-should-be-when-kernel-is-booted.patch

 Avoid possible early-boot lockups

+hvcs-hotplug-fixes.patch

 Fix HVCS driver

+amiga-partition-reading-fix.patch

 Fix parsing of Amiga partition tables

+problem-with-sis900-unknown-phy.patch

 sis900 fix

+kallsyms-data-size-reduction--lookup-speedup.patch

 Use smarter searching and sorting to speed up /proc/kallsyms a lot

+prevent-memory-leak-in-devpts.patch

 dentry leak fix

+revert-ioc_eth3-pci_enable_device-changes.patch
+fix-hp100c-for-pci_enable_device-changes.patch

 Fix these drivers for recent ill-advised PCI API updates

+x86_64-vs-select-fix.patch

 Fix a symbol clash

+must_check-copy_to_user.patch

 Add __must_check to x86 copy_*_user() functions

+copy_to_user-checking.patch
+sym_requeue_awaiting_cmds-uninit-var-fix.patch
+de4x5-idiocy-fix.patch

 Fix some fallout from the above



number of patches in -mm: 310
number of changesets in external trees: 648
number of patches in -mm only: 296
total patches: 944




All patches:


linus.patch

auth_unix_lookup-oops-fix.patch
  auth_unix_lookup() oops fix

auth_unix_lookup-oops-fix-fix.patch
  auth_unix_lookup-oops-fix fix

fix-show_mem-on-discontig-machines.patch
  fix show_mem on discontig machines

fix-sysrq-support-in-sn_consolec.patch
  fix sysrq support in sn_console.c

request_region-for-winbond-and-smsc-parport-drivers.patch
  request_region for winbond and smsc parport drivers

md-fix-problems-with-checksum-handling-in-md-superblocks.patch
  md: fix problems with checksum handling in MD superblocks.

sysfs-backing-store-prepare-file_operations.patch
  sysfs backing store - prepare sysfs_file_operations helpers

sysfs-backing-store-prepare-file_operations-fix.patch
  fix oops with firmware loading

sysfs-backing-store-add-sysfs_dirent.patch
  sysfs backing store - add sysfs_direct structure

sysfs-backing-store-use-sysfs_dirent-tree-in-removal.patch
  sysfs backing store: use sysfs_dirent based tree in file removal

sysfs-backing-store-use-sysfs_dirent-tree-in-dir-file_operations.patch
  sysfs backing store: use sysfs_dirent based tree in dir file operations

sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves.patch
  sysfs backing store: stop pinning dentries/inodes for leaf entries

scheduler-profiling.patch
  schedule profileing

consolidate-prof_cpu_mask.patch
  consolidate prof_cpu_mask

introduce-profile_pc.patch
  introduce profile_pc()

consolidate-hit-count-increments-in-profile_tick.patch
  consolidate hit count increments in profile_tick()

move-profile_operations.patch
  move profile_operations

make-private-profile-state-static.patch
  make private profile state static

make-prof_buffer-atomic_t.patch
  make prof_buffer atomic_t

remove-iseries-profiling.patch
  ppc64: remove iseries profiling

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-dma-declare-coherent-memory.patch

bk-drm.patch

bk-ia64.patch

bk-ieee1394.patch

bk-input.patch

bk-jfs.patch

bk-pnp.patch

bk-power.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

mm-swsusp-make-sure-we-do-not-return-to-userspace-where-image-is-on-disk.patch
  -mm swsusp: make sure we do not return to userspace where image is on disk

mm-swsusp-copy_page-is-harmfull.patch
  -mm swsusp: copy_page is harmfull

swsusp-fix-highmem.patch
  swsusp: fix highmem

swsusp-do-not-disable-platform-swsusp-because-s4bios-is-available.patch
  swsusp: do not disable platform swsusp because S4bios is available

swsusp-fix-default-powerdown-mode.patch
  swsusp: fix default powerdown mode

mark-old-power-managment-as-deprecated-and-clean-it-up.patch
  Mark old power managment as deprecated and clean it up

use-global-system_state-to-avoid-system-state-confusion.patch
  Use global system_state to avoid system-state confusion

sound-control-build-fix.patch
  sound/core/control.c build fix

ipr-build-fix.patch
  ipr.c build fix

megaraid-build-fix.patch
  [un]register_ioctl32_conversion() stubs

i386_exception_notifiers.patch
  i386 exceptions notifier for kprobes

kprobes-base.patch
  kprobes base patch

kprobes-unset-fix.patch
  kprobes: fix things when CONFIG_KPROBES is unset

kprobes-func-args.patch
  Jumper Probes to provide function arguments

kprobes-build-fix.patch
  kprobes build fix

network-packet-tracer-module-using-kprobes-interface.patch
  Network packet tracer module using kprobes interface.

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

kgdb-is-incompatible-with-kprobes.patch
  kgdb-is-incompatible-with-kprobes

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix

kgdb-ia64-fixes.patch
  kgdb: ia64 fixes

reduce-size-of-struct-inode-on-64bit.patch
  reduce size of struct inode on 64bit

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

ppc32-refactor-common-book-e-exception-handling-macros.patch
  ppc32: refactor common Book-E exception handling macros

ppc64-clean-up-unused-macro.patch
  ppc64: clean up unused macro

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pid_max-fix.patch
  Bug when setting pid_max > 32k

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

lockmeter-build-fix.patch
  lockmeter-build-fix

lockmeter-for-x86_64.patch
  lockmeter for x86_64

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation
  ext3 reservations: fix performance regression
  ext3 block reservation patch set -- mount and ioctl feature
  ext3 block reservation patch set -- dynamically increase reservation window
  ext3 reservation ifdef cleanup patch
  ext3 reservation max window size check patch
  ext3 reservation file ioctl fix

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard
  ext3 reservations: bad_inode fix
  ext3 reservation discard race fix

ipr-ppc64-depends.patch
  Make ipr.c require ppc

tty_io-hangup-locking.patch
  tty_io.c hangup locking

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
  CONFIG_PERFCTR=n build fix
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
  perfctr #if/#ifdef cleanup
  perfctr Dothan support
  perfctr x86_tests build fix
  perfctr x86 init bug
  perfctr: K8 fix for internal benchmarking code
  perfctr x86 update

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
  perfctr ppc32 update
  perfctr update 4/6: PPC32 cleanups
  perfctr ppc32 buglet fix

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
  perfctr update 6/6: misc minor cleanups
  perfctr update 3/6: __user annotations
  perfctr-cpus_complement-fix
  perfctr cpumask cleanup
  perfctr SMP hang fix

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr update 2/6: Kconfig-related updates

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr update 5/6: reduce stack usage

perfctr-low-level-documentation.patch
  perfctr low-level documentation
  perfctr documentation update

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance 1/3: driver updates
  perfctr inheritance illegal sleep bug

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance 2/3: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance 3/3: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

ext3-online-resize-patch.patch
  ext3: online resizing
  ext3-online-resize-warning-fix

nicksched.patch
  nicksched

ext3_bread-cleanup.patch
  ext3_bread() cleanup

pcmcia-implement-driver-model-support.patch
  pcmcia: implement driver model support

pcmcia-update-network-drivers.patch
  pcmcia: update network drivers

pcmcia-update-wireless-drivers.patch
  pcmcia: update wireless drivers

pcmcia-fix-eject-lockup.patch
  pcmcia: fix eject lockup

pcmcia-add-hotplug-support.patch
  pcmcia: add *hotplug support

linux-2.6.8.1-49-rpc_workqueue.patch
  nfs: RPC: Convert rpciod into a work queue for greater flexibility

linux-2.6.8.1-50-rpc_queue_lock.patch
  nfs: RPC: Remove the rpc_queue_lock global spinlock

dvdrw-support-for-267-bk13.patch
  DVD+RW support for 2.6.7-bk13

cdrw-packet-writing-support-for-267-bk13.patch
  CDRW packet writing support
  packet: remove #warning
  packet writing: door unlocking fix
  pkt_lock_door() warning fix
  Fix race in pktcdvd kernel thread handling
  Fix open/close races in pktcdvd
  packet writing: review fixups
  Remove pkt_dev from struct pktcdvd_device
  packet writing: convert to seq_file

dvd-rw-packet-writing-update.patch
  Packet writing support for DVD-RW and DVD+RW discs.
  Get blockdev size right in pktcdvd after switching discs

packet-writing-docco.patch
  packet writing documentation
  Trivial CDRW packet writing doc update

control-pktcdvd-with-an-auxiliary-character-device.patch
  Control pktcdvd with an auxiliary character device
  Subject: Re: 2.6.8-rc2-mm2
  control-pktcdvd-with-an-auxiliary-character-device-fix

simplified-request-size-handling-in-cdrw-packet-writing.patch
  Simplified request size handling in CDRW packet writing

fix-setting-of-maximum-read-speed-in-cdrw-packet-writing.patch
  Fix setting of maximum read speed in CDRW packet writing

packet-writing-reporting-fix.patch
  Packet writing reporting fixes

speed-up-the-cdrw-packet-writing-driver.patch
  Speed up the cdrw packet writing driver

packet-writing-avoid-bio-hackery.patch
  packet writing: avoid BIO hackery

cdrom-buffer-size-fix.patch
  cdrom: buffer sizing fix

cpufreq-driver-for-nforce2-kernel-267.patch
  cpufreq driver for nForce2

allow-modular-ide-pnp.patch
  allow modular ide-pnp

fix-warnings-in-net-irda.patch
  sparse: fix warnings in net/irda/*

add-a-few-might_sleep-checks.patch
  Add a few might_sleep() checks

tmpfs-atomicity-fix.patch
  tmpfs atomicity fix

dev-zero-vs-hugetlb-mappings.patch
  /dev/zero vs hugetlb mappings.

hugetlbfs-private-mappings.patch
  hugetlbfs private mappings

jbd-recovery-latency-fix.patch
  jbd recovery latency fix

truncate_inode_pages-latency-fix.patch
  truncate_inode_pages-latency-fix

journal_clean_checkpoint_list-latency-fix.patch
  journal_clean_checkpoint_list latency fix

journal_clean_checkpoint_list-latency-fix-fix.patch
  journal_clean_checkpoint_list-latency-fix-fix

kjournald-smp-latency-fix.patch
  kjournald-smp-latency-fix

unmap_vmas-smp-latency-fix.patch
  unmap_vmas-smp-latency-fix

__cleanup_transaction-latency-fix.patch
  __cleanup_transaction-latency-fix

prune_dcache-latency-fix.patch
  prune_dcache-latency-fix

filemap_sync-latency-fix.patch
  filemap_sync-latency-fix

slab-latency-fix.patch
  slab-latency-fix

get_user_pages-latency-fix.patch
  get_user_pages-latency-fix

pty_write-latency-fix.patch
  pty_write-latency-fix

create-nodemask_t.patch
  Create nodemask_t
  nodemask fix
  nodemask build fix

add-ixdp2x01-board-support-to-cs89x0-driver.patch
  Add IXDP2x01 board support to CS89x0 driver

b44-add-47xx-support.patch
  b44: add 47xx support

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

fix-ide-probe-double-detection.patch
  Fix ide probe double detection

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

serial-cs-and-unusable-port-size-ranges.patch
  serial-cs and unusable port size ranges

vlan-support-for-3c59x-3c90x.patch
  VLAN support for 3c59x/3c90x

scsi-qla2xxx-fix-inline-compile-errors.patch
  qla2xxx gcc-3.5 fixes

add-support-for-it8212-ide-controllers.patch
  Add support for IT8212 IDE controllers

i386-hotplug-cpu.patch
  i386 Hotplug CPU

hotplug-cpu-fix-apic-queued-timer-vector-race.patch
  Hotplug cpu: Fix APIC queued timer vector race

iteraid.patch
  ITE RAID driver
  iteraid cleanup
  iteraid warning fix
  iteraid: pci_enable_device() for IRQ routing

igxb-speedup.patch
  igxb speedup

serialize-access-to-ide-devices.patch
  serialize access to ide devices

remove-unconditional-pci-acpi-irq-routing.patch
  remove unconditional PCI ACPI IRQ routing

add-pci_fixup_enable-pass.patch
  pci: add pci_fixup_enable pass

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

x86_64-numa-emulation.patch
  x86_64: emulate NUMA on non-NUMA hardware

wireless-extension-v17-for-linus.patch
  Wireless Extension v17 for Linus

wireless-drivers-update-for-we-17.patch
  Wireless drivers update for WE-17

rss-ulimit-enforcement.patch
  RSS ulimit enforcement

add-some-key-management-specific-error-codes.patch
  Add some key management specific error codes

implement-in-kernel-keys-keyring-management.patch
  implement in-kernel keys & keyring management

implement-in-kernel-keys-keyring-management-update.patch
  keys & keyring management update patch

implement-in-kernel-keys-keyring-management-update-build-fix.patch
  implement-in-kernel-keys-keyring-management-update-build-fix

implement-in-kernel-keys-keyring-management-update-build-fix-2.patch
  implement-in-kernel-keys-keyring-management-update-build-fix-2

key-management-patch-cleanup.patch
  key management patch cleanup

keys-keyring-management-keyfs-patch.patch
  keys & keyring management: keyfs patch

keyfs-build-fix.patch
  keyfs build fix

implement-in-kernel-keys-keyring-management-afs-workaround.patch
  implement-in-kernel-keys-keyring-management afs workaround

268-rc3-jffs2-unable-to-read-filesystems.patch
  jffs2 unable to read filesystems

ide-do-spin-up-for-all-platforms.patch
  IDE: do spin up for all platforms

qlogic-isp2x00-remove-needless-busyloop.patch
  QLogic ISP2x00: remove needless busyloop

dnotify-autofs-may-create-signal-restart-syscall-loop.patch
  dnotify + autofs may create signal/restart syscall loop

using-get_cycles-for-add_timer_randomness.patch
  Using get_cycles for add_timer_randomness

waitid-system-call.patch
  waitid system call

waitid-system-call-update.patch
  waitid system call update

waitid-ia64-build-fix.patch
  waitid-ia64-build-fix

waitid-system-call-cleanups.patch
  waitid-system-call cleanups

mostly-remove-module_parm.patch
  mostly remove module_parm()

serial-8250-optionally-skip-autodetection.patch
  Serial 8250 optionally skip autodetection

serial-8250-omap-support.patch
  Serial 8250 OMAP support

add-to-snd-intel8x0-ac97-quirk-list.patch
  add to snd-intel8x0 AC97 quirk list

defxx-trivial-updates.patch
  defxx trivial updates

defxx-device-name-fixes.patch
  defxx device name fixes

jffs2-mount-options-discarded.patch
  JFFS2 mount options discarded

assign_irq_vector-section-fix.patch
  assign_irq_vector __init section fix

find_isa_irq_pin-should-not-be-__init.patch
  find_isa_irq_pin should not be __init

kexec-i8259-shutdowni386.patch
  kexec: i8259-shutdown.i386

kexec-i8259-shutdown-x86_64.patch
  kexec: x86_64 i8259 shutdown

kexec-apic-virtwire-on-shutdowni386patch.patch
  kexec: apic-virtwire-on-shutdown.i386.patch

kexec-apic-virtwire-on-shutdownx86_64.patch
  kexec: apic-virtwire-on-shutdown.x86_64

kexec-ioapic-virtwire-on-shutdowni386.patch
  kexec: ioapic-virtwire-on-shutdown.i386

kexec-ioapic-virtwire-on-shutdownx86_64.patch
  kexec: ioapic-virtwire-on-shutdown.x86_64

kexec-e820-64bit.patch
  kexec: e820-64bit

kexec-kexec-generic.patch
  kexec: kexec-generic

kexec-machine_shutdownx86_64.patch
  kexec: machine_shutdown.x86_64

kexec-kexecx86_64.patch
  kexec: kexec.x86_64

kexec-machine_shutdowni386.patch
  kexec: machine_shutdown.i386

kexec-kexeci386.patch
  kexec: kexec.i386

kexec-use_mm.patch
  kexec: use_mm

kexec-kexecppc.patch
  kexec: kexec.ppc

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-sb_sync_inodes-cleanup.patch
  reiser4-sb_sync_inodes-cleanup

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-allow-drop_inode-implementation-cleanup.patch
  reiser4-allow-drop_inode-implementation-cleanup

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-truncate_inode_pages_range-cleanup.patch
  reiser4-truncate_inode_pages_range-cleanup

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-rcu-barrier-fix.patch
  reiser4-rcu-barrier fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-inode_lock-cleanup.patch
  reiser4-export-inode_lock-cleanup

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-pagevec-funcs-cleanup.patch
  reiser4-export-pagevec-funcs-cleanup

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-aliased-dir.patch
  reiser4: vfs: handle aliased directories

reiser4-kobject-umount-race.patch
  reiser4: introduce filesystem kobjects

reiser4-kobject-umount-race-cleanup.patch
  reiser4-kobject-umount-race-cleanup

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-unstatic-kswapd.patch
  reiser4: make kswapd() unstatic for debug

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-4kstacks-fix.patch
  resier4-4kstacks-fix

reiser4-doc.patch
  reiser4: documentation

reiser4-doc-update.patch
  Update Documentation/Changes for reiser4

reiser4-only.patch
  reiser4: main fs

reiser4-prefetch-warning-fix.patch
  reiser4: prefetch warning fix

reiser4-mode-fix.patch
  reiser4: mode type fix

reiser4-get_context_ok-warning-fixes.patch
  reiser4: get_context_ok() warning fixes

reiser4-remove-debug.patch
  resier4: remove debug stuff

reiser4-spinlock-debugging-build-fix-2.patch
  reiser4-spinlock-debugging-build-fix-2

reiser4-sparc64-build-fix.patch
  reiser4 sparc64 build fix

sys_reiser4-sparc64-build-fix.patch
  sys_reiser4 sparc64 build fix

reiser4-printk-warning-fixes.patch
  reiser4 printk warning fixes

fix-rusage-semantics.patch
  fix rusage semantics

fix-mt-reparenting-when-thread-group-leader-dies.patch
  fix MT reparenting when thread group leader dies

acpi-based-floppy-controller-enumeration.patch
  ACPI-based floppy controller enumeration

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

copy_mount_options-size-fix.patch
  copy_mount_options size fix

improve-oprofile-on-many-way-systems.patch
  improve OProfile on many-way systems

oprofile-ia64-performance-counter-support.patch
  OProfile ia64 performance counter support

fix-pid-hash-sizing.patch
  fix PID hash sizing

use-hlist-for-pid-hash.patch
  use hlist for pid hash

use-hlist-for-pid-hash-cache-friendliness.patch
  use hlist for pid hash: cache friendliness

split-timer-resources.patch
  Split timer resources

reduce-casting-in-sysenterc.patch
  reduce casting in sysenter.c

cast-page_offset-math-to-void-in-early-printk.patch
  cast PAGE_OFFSET math to void* in early printk

call-virt_to_page-with-void-not-ul.patch
  call virt_to_page() with void*, not UL

vmalloc_fault-cleanup.patch
  vmalloc_fault() cleanup

dont-align-virt_to_page-args.patch
  don't align virt_to_page() args

include-asm-pageh-for-virt_to_page.patch
  include asm/page.h for virt_to_page()

task_vsize-locking-cleanup.patch
  task_vsize() locking cleanup

task_vsize-locking-cleanup-warning-fix.patch
  task_vsize-locking-cleanup warning fix

o1-proc_pid_statm.patch
  O(1) proc_pid_statm()

o1-proc_pid_statm-fix.patch
  fix text reporting in O(1) proc_pid_statm()

task-statm-no-procfs-fix.patch
  speed up /proc/pid/statm for !CONFIG_PROC_FS

task-statm-reserved-fix.patch
  /proc/pid/statm accounting fixes

task-statm-dontcopy-fix.patch
  Unaccount VM_DONTCOPY vmas properly

r8169-add-ethtool_opsget_regs_len-get_regs.patch
  r8169: add ethtool_ops.{get_regs_len/get_regs}

r8169-per-device-receive-buffer-size.patch
  r8169: per device receive buffer size

r8169-code-cleanup.patch
  r8169: code cleanup

r8169-enable-mwi.patch
  r8169: enable MWI

r8169-bump-version-number.patch
  r8169: bump version number

r8169-sync-the-names-of-a-few-bits-with-the-8139cp-driver.patch
  r8169: sync the names of a few bits with the 8139cp driver

r8169-comment-a-gcc-295x-bug.patch
  r8169: comment a gcc 2.95.x bug

r8169-tx-checksum-offload.patch
  r8169: Tx checksum offload

r8169-advertise-dma-to-high-memory.patch
  r8169: advertise DMA to high memory

r8169-rx-checksum-support.patch
  r8169: Rx checksum support

r8169-vlan-support.patch
  r8169: vlan support

sane-mlock_limit.patch
  sane mlock_limit

lanana-maintainer-devicestxt-patch-1-2.patch
  LANANA: maintainer update

lanana-maintainer-devicestxt-2.patch
  LANANA: devices.txt update

netmos-9805-parport-interface.patch
  parport: NetMOS 9805 interface

s390-lcs-network-driver.patch
  s390: lcs network driver

s390-common-i-o-layer.patch
  s390: common i/o layer

s390-sclp-driver-changes.patch
  s390: sclp driver changes

s390-qeth-network-driver.patch
  s390: qeth network driver

269-rc1-ifdef-fixes-for-drivers-isdn-hifax.patch
  #ifdef fixes for drivers/isdn/hifax/*

269-rc1-ifdef-cleanup-for-sh64.patch
  #ifdef cleanup for sh64

269-rc1-ifdef-cleanup-for-cris-port.patch
  #ifdef cleanup for cris port

269-rc1-ifdef-cleanup-for-ppc.patch
  #ifdef cleanup for PPC

269-rc1-ifdef-cleanups-in-drivers-net.patch
  #ifdef cleanups in drivers/net

make-oom-killer-points-unsigned-long.patch
  make oom killer points unsigned long

dvb-pci_enable_device-fix.patch
  dvb pci_enable_device() fix

copying-unaligned-data-across-user-kernel-boundary.patch
  Copying unaligned data across user/kernel boundary

re-fix-pagecache-reading-off-by-one.patch
  fix pagecache reading off-by-one

re-fix-pagecache-reading-off-by-one-cleanup.patch
  re-fix-pagecache-reading-off-by-one-cleanup

waitqueue_debug-crapectomy.patch
  WAITQUEUE_DEBUG cleanup

ftape-support-for-x86_64.patch
  ftape support for x86_64

keep-sparc32-config-consistent.patch
  Keep sparc32 config consistent

fix-typo-in-bw2c.patch
  Fix typo in bw2.c

interrupt-is-enabled-before-it-should-be-when-kernel-is-booted.patch
  interrupt is enabled before it should be when kernel is booted

hvcs-hotplug-fixes.patch
  HVCS hotplug fixes

amiga-partition-reading-fix.patch
  Amiga partition reading fix

problem-with-sis900-unknown-phy.patch
  Problem with SiS900 - Unknown PHY

kallsyms-data-size-reduction--lookup-speedup.patch
  kallsyms data size reduction / lookup speedup

prevent-memory-leak-in-devpts.patch
  Prevent memory leak in devpts

revert-ioc_eth3-pci_enable_device-changes.patch
  revert ioc3-eth.c pci_enable_device() changes

fix-hp100c-for-pci_enable_device-changes.patch
  Fix hp100.c for pci_enable_device() changes

x86_64-vs-select-fix.patch
  Fix x86_64 vs select.c namespace clash

must_check-copy_to_user.patch
  must_check-copy_to_user

copy_to_user-checking.patch
  copy_to_user-checking

sym_requeue_awaiting_cmds-uninit-var-fix.patch
  sym_requeue_awaiting_cmds() warning fix

de4x5-idiocy-fix.patch
  de4x5 warning fix



