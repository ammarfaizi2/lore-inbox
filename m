Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVCHLpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVCHLpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVCHLpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:45:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:30917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261975AbVCHLjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:39:22 -0500
Date: Tue, 8 Mar 2005 03:38:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-mm2
Message-Id: <20050308033846.0c4f8245.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm2/


- UML updates

- fbdev updates

- nfs4 server updates

- new megaraid driver, new iscsi driver, fatfs update, fbdev updates,
  kitchen sink.

- The below description of what has been added and what has been merged is
  probably a bit more inaccurate than usual due to my having shuffled things
  around and confusing myself.

- I dropped the list-of-all-patches from this email due to it being rather
  long.  The unexpurgated version is at
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm2/announce.txt



Changes since 2.6.11-mm1:


 linus.patch
 bk-acpi.patch
 bk-alsa.patch
 bk-audit.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-drm-via.patch
 bk-ide-dev.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-kbuild.patch
 bk-kconfig.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-scsi.patch
 bk-usb.patch
 bk-watchdog.patch
 
 Latest versions of subsystem trees

-dv1394-ioctl-retval-fix.patch
-nfsd--sgi-921857-find-broken-with-nohide-on-nfsv3.patch
-nfsd--exportfs-reduce-stack-usage.patch
-nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
-nfsd--svcrpc-rename-pg_authenticate.patch
-nfsd--svcrpc-move-export-table-checks-to-a-per-program-pg_add_client-method.patch
-nfsd--nfs4-use-new-pg_set_client-method-to-simplify-nfs4-callback-authentication.patch
-nfsd--lockd-dont-try-to-match-callback-requests-against-export-table.patch
-aoe-fix-printk-warning-sparc64.patch
-audit-mips-fix.patch
-ib-simplify-mad-code.patch
-ib-fix-vendor-mad-deregistration.patch
-ib-sparse-fixes.patch
-ib-mthca-add-missing-break.patch
-ib-mthca-fix-reset-value-endianness.patch
-ib-ipoib-fix-rx-memory-leak.patch
-ib-ipoib-use-list_for_each_entry_safe-when-required.patch
-ib-ipoib-rename-global-symbols.patch
-ib-ipoib-small-fixes.patch
-ib-ipoib-dont-call-ipoib_put_ah-with-lock-held.patch
-ib-ipoib-fix-locking-on-path-deletion.patch
-ib-fix-ib_find_cached_gid-port-numbering.patch
-ib-mthca-cq-minor-tweaks.patch
-ib-mthca-improve-cq-locking-part-1.patch
-ib-mthca-improve-cq-locking-part-2.patch
-ib-mthca-cq-cleanups.patch
-ib-remove-unsignaled-receives.patch
-ib-mthca-map-registers-for-mem-free-mode.patch
-ib-mthca-add-uar-allocation.patch
-ib-mthca-dynamic-context-memory-mapping-for-mem-free-mode.patch
-ib-mthca-mem-free-memory-region-support.patch
-ib-mthca-mem-free-eq-initialization.patch
-ib-mthca-mem-free-interrupt-handling.patch
-ib-mthca-tweak-firmware-command-debug-messages.patch
-ib-mthca-tweak-map_icm_page-firmware-command.patch
-ib-mthca-mem-free-doorbell-record-allocation.patch
-ib-mthca-mem-free-doorbell-record-writing.patch
-ib-mthca-refactor-cq-buffer-allocate-free.patch
-ib-mthca-mem-free-cq-initialization.patch
-ib-mthca-mem-free-cq-operations.patch
-ib-mthca-mem-free-qp-initialization.patch
-ib-mthca-mem-free-address-vectors.patch
-ib-mthca-mem-free-work-request-posting.patch
-ib-mthca-mem-free-multicast-table.patch
-ib-mthca-qp-locking-optimization.patch
-ib-mthca-implement-query-of-device-caps.patch
-ib-mad-cancel-callbacks-from-thread.patch
-initialize-spin-locks.patch
-nfsd--nfsd-remove-pg_authenticate-field.patch
-nfsd--global-static-cleanups-for-nfsd.patch
-nfsd--change-nfsd-reply-cache-to-use-listh-lists.patch
-nfsd-discard-cache_hashed-flag-keeping-information-in-refcount-instead.patch
-preliminary-w83627ehf-hardware-monitoring-driver.patch
-i2c-chips-add-adt7461-support-to-lm90-driver.patch
-i2c-chips-ds1337-rtc-driver.patch
-snd_trident_gameport_trigger-warning-fix.patch
-6300esb-watchdog-driver.patch
-randomisation-global-sysctl.patch
-randomisation-global-sysctl-fix.patch
-randomisation-infrastructure.patch
-fix-compilation-of-uml-after-the-stack-randomization-patches.patch
-randomisation-add-pf_randomize.patch
-randomisation-stack-randomisation.patch
-randomisation-mmap-randomisation.patch
-randomisation-enable-by-default.patch
-randomisation-addr_no_randomize-personality.patch
-randomisation-top-of-stack-randomization.patch
-move-accounting-function-calls-out-of-critical-vm-code-pathspatch.patch
-invalidate-range-of-pages-after-direct-io-write.patch
-write-and-wait-on-range-before-direct-io-read.patch
-only-unmap-what-intersects-a-direct_io-op.patch
-make-tree_lock-an-rwlock.patch
-ppc-ppc64-abstract-cpu_feature-checks.patch
-ppc32-dont-create-tmp_gas_check.patch
-ppc32-fix-mv64x60-register-relocation-bug-in-bootwrapper.patch
-ppc32-update-arch-ppc-configs-pmac_defconfig.patch
-ppc32-artesyn-katana-platform-update.patch
-ppc32-artesyn-katana-enet-update.patch
-ppc32-move-irq_descstatus-irq_level-bit-setup-to-xilinx_picc.patch
-ppc32-lindentify-ppc4xx-pic-driver.patch
-ppc32-ppc4xx-pic-ack-parent-uic-in-disable_irq.patch
-ppc32-incorrect-define-in-include-asm-ppc-cpm2h.patch
-ppc32-bogus-definition-of-__cmpxchg_u32.patch
-ppc32-fix-whitespace-for-85xx-cds-common-platform.patch
-ppc32-move-from-using-define-svr_-to-cur_ppc_sys_spec-name.patch
-ppc32-mv64360_pic-non-zero-irq-base.patch
-ppc32-add-gpio-irq-definitions-for-mv64x60-parts.patch
-ppc32-support-openbios-u-boot-for-ebony.patch
-ppc32-add-support-for-the-dallas-1553-rtc-nvram.patch
-ppc32-add-support-to-use-the-ds1553-rtc-nvram-on-mpc8555.patch
-ppc32-trivial-bug-fix-in-critical_exception-macro.patch
-ppc64-remove-unneeded-includes-from-pseries_nvramc.patch
-ppc64-collect-and-export-low-level-cpu-usage-statistics.patch
-ppc64-move-systemcfg-out-of-heads.patch
-ppc64-defconfig-updates.patch
-ppc64-distribute-export_symbols.patch
-ppc64-implement-a-vdso-and-use-it-for-signal-trampoline.patch
-ppc64-implement-a-vdso-and-use-it-for-signal-trampoline-gas-workaround.patch
-ppc64-generic-hotplug-cpu-support.patch
-ppc64-generic-hotplug-cpu-support-fix.patch
-ppc64-disable-hmt-for-rs64-cpus.patch
-use-vmlinux-during-make-install-on-ppc64.patch
-ppc64-functions-to-reserve-performance-monitor-hardware.patch
-ppc64-fix-thinko-in-prom_initc.patch
-ppc64-fix-zimage-wrapper-incorrect-size-to-flush_cache.patch
-ppc64-offb-remapped-address.patch
-mips-add-tanbac-tb0219-base-board-driver.patch
-mips-calculate-clock-at-any-time.patch
-mips-update-cmu.patch
-remove-dead-cyrix-centaur-mtrr-init-code.patch
-uml-trivial-removal-of-makefile-var.patch
-cancel_rearming_delayed_work.patch
-ipvs-deadlock-fix.patch

 Merged

+md-fix-typo-in-super_1_sync.patch

 RAID fix

+ppc32-trivial-fix-for-e500-oprofile-build.patch

 ppc32 build fix

+ppc-raid6-build-fix.patch

 ppc32 RAID build fix

+x86_64-pte-warning-fix.patch

 x86_64 warning fix

+remove-drivers-char-tpqic02c.patch

 Kill dead code

+ppc64-revert-implement-a-vdso-and-use-it-for-signal-trampoline-gas-workaround.patch

 Fix ppc64 VDSO code

+sh64-initial-checkstack-port.patch
+sh64-update-richard-curnows-maintainers-info.patch
+sh64-align-slab-caches-on-an-8-byte-boundary.patch
+sh64-defconfig-updates.patch
+sh64-iomap-interface.patch
+sh64-module-support.patch
+sh64-generic-hardirqs.patch
+sh64-ide-updates.patch
+sh64-tmu-init-bugfix.patch
+sh64-send-cli-sti-back-from-whence-it-came.patch
+sh64-beat-dcache-disabling-back-into-submission.patch
+sh64-merge-updates.patch
+sh-defconfig-updates.patch
+sh-generic-hardirqs.patch
+sh-hp620-updates.patch
+sh-framebuffer-updates.patch
+sh-update-cpufreq-driver-for-cpumask.patch
+sh-merge-updates.patch

 sh/sh64 updates

+support-hpet-with-a-single-timer-for-system-time.patch

 HPET fix

+remove-dead-cyrix-centaur-mtrr-init-code.patch

 Cleanup

+swsusp-do-not-use-higher-order-memory-allocations-on-suspend.patch

 swsusp memory management fix

+update-suspend-to-ram-vs-video-documentation.patch

 swsusp docs

+swsusp-fails-to-suspend-if-config_debug_pagealloc-is-also-enabled.patch

 swsusp runtime warning

+kconfig-debug_pagealloc-and-software_suspend-are-incompatible-on-i386.patch

 swsusp Kconfig fix

+arm-rtc-build-fix.patch

 ARM build fix

+xscale-8250-patches-cause-malfunction-on-amd-8111.patch

 8250 fix

+acpi-toshiba-failure-handling.patch

 ACPI fix

+include-linux-soundcardh-endianness-fix.patch

 Fix oss drivers on big-endian hardware

+ide-serverworks-fix-section-references.patch

 IDE sectioning fix

+implement-compat_ioctl-for-joydev.patch

 input driver compat support

+psmouse-warning-fix.patch
+sound-pci-cs4281c-fix-typos-in-the-support_joystick=n-case.patch

 input driver fixlets

+uml-make-deb-pkg-build-target-build-a-debian-style-user-mode-linux-package.patch

 UML deb packaging fix

+arch-i386-pci-i386c-use-new-for_each_pci_dev-macro.patch

 cleanup

+megaraid_sas-announcing-new-module-for.patch

 New megaraid SAS driver

+open-iscsi-scsi.patch
+open-iscsi-headers.patch
+open-iscsi-kconfig.patch
+open-iscsi-makefile.patch
+open-iscsi-netlink.patch
+open-iscsi-doc.patch

 iSCSI driver

+hw-watchdog-vs-softdog-fix.patch

 Don't allow the software watchdog driver to override hardware ones.

+vmalloc-introduce-__vmalloc_area-function.patch
+vmalloc-use-__vmalloc_area-in-arch-arm.patch
+vmalloc-use-__vmalloc_area-in-arch-sparc64.patch
+vmalloc-use-__vmalloc_area-in-arch-x86_64.patch
+vmalloc-use-list-of-pages-instead-of-array-in-vm_struct.patch

 vmalloc cleanups

+no-arch-specific-mem_map-init.patch

 mem_map initialisation consolidation

-must-fix.patch

 Dropped.

-fix-buggy-ieee80211_crypt_-selects.patch

 Was wrong.

-x25_create-initializing-socket-data-twice.patch

 Was also wrong

+drivers-net-myri_codeh-cleanup.patch

 Kill huge all-nulls array

+e100-napi-fixes.patch

 Fix e100 NAPI handling

+remove-last_rx-update-from-loopback-device.patch

 Speed up the net loop device

+selinux-enhanced-mls-support.patch
+selinux-pass-requested-protection-to-security_file_mmap-mprotect-hooks.patch

 SELinux feature work

+ppc64-invert-dma-mapping-routines.patch

 ppc64 update

+x86-abstract-discontigmem-setup-fix.patch

 Fix x86-abstract-discontigmem-setup.patch

+x86-disable-msi-for-amd-8131.patch

 MSI quirk

+x86-64-kconfig-typo-trivial.patch
+x86_64-remove-old-decl-trivial.patch
+x86_64-avoid-panic-lockup.patch

 x86_64 updates

-xen-vmm-4-add-ptep_establish_new-to-make-va-available.patch
-xen-vmm-4-return-code-for-arch_free_page.patch
-xen-vmm-4-return-code-for-arch_free_page-fix.patch
-xen-vmm-4-runtime-disable-of-vt-console.patch
-xen-vmm-4-has_arch_dev_mem.patch
-xen-vmm-4-split-free_irq-into-teardown_irq.patch

 These hit a lot of rejects, so drop them for now.

+uml-2611-updates.patch
+uml-update-defconfig.patch
+uml-slirp-driver-tells-the-network-its-not-ethernet.patch
+uml-get-rid-of-uneccessary-hostfs-build-trick.patch
+uml-fix-some-usercopy-confusion.patch
+uml-make-the-ubd-driver-recognize-letters-in-device-names.patch
+uml-fix-a-shutdown-hang-caused-by-a-failed-ifconfig.patch
+uml-code-cleanup.patch
+uml-clean-up-the-syscall-path.patch
+uml-make-syscall-debugging-code-configurable.patch
+uml-add-a-comment-explaining-pread-availability.patch
+uml-remove-useless-sys_mount-wrapper.patch
+uml-remove-mm_indirect-reference-in-modify_ldt.patch
+uml-fix-a-compile-failure.patch
+uml-improve-error-reporting.patch
+uml-make-a-bunch-of-driver-functions-static.patch

 UML update

-poll-mini-optimisations.patch

 Dropped - the poll code is tricky and this optimisation is small and the
 patch made subtle user-visible changes.

+blockdev-fixes-race-between-mount-umount.patch
+blockdev-fixes-race-between-mount-umount-tidy.patch

 umount race fix

+invalidate_inode_pages2_range-livelock-fix.patch

 Avoid a livelock in direct-io pagecache invalidation

+add-and-use-compat_sigev_pad_size.patch
+consolidate-the-last-compat-sigvals.patch
+consolidate-the-last-of-the-compat-sigevent-structs.patch

 compat layer updates

+cx24110-conexant-frontend-update.patch
+cx24110-conexant-frontend-update-tidy.patch

 linuxtv driver fixes

+direct-io-async-short-read-fix.patch
+direct-io-async-short-read-fix-fix.patch

 Fix strange AIO-DIO read() behaviour

+nice-and-rt-prio-rlimits.patch

 rlimits for niceness and rt-policy.

+del_timer_sync-scalability-patch.patch
+del_timer_sync-scalability-patch-tidy.patch

 Speed up del_timer_sync()

 inotify.patch
+inotify-fix.patch

 New inotify code drop

+ext3-jbd-race-releasing-in-use-journal_heads.patch

 JBD race fix

+ext3-writepages-support-for-writeback-mode.patch

 Use writepages() for ext3 data=writeback mode

+nfsd4-remove-utf8-checking.patch
+nfsd4-create-a-slab-cache-for-stateowners.patch
+nfsd4-remove-stateowner-debug-counters.patch
+nfsd4-fix-oops-on-nfsd4-shutdown.patch
+nfsd4-cbnull-refcount-leak.patch
+nfsd4-reclaim-cleanup.patch
+nfsd4-move-special-stateid-processing.patch
+nfsd4-allow-some-reads-and-writes-during-the-grace-period.patch
+nfsd4-use-existing-open-instead-of-reopening-on-read-and-write.patch
+nfsd4-miscellaneous-open-cleanup.patch
+nfsd4-miscellaneous-open-cleanup-2.patch
+nfsd4-miscellaneous-open-cleanup-3.patch
+nfsd4-dont-release-nfs4_file-with-associated-delegations.patch
+nfsd4-do-callback-replays-by-hand.patch
+nfsd4-simplify-open_delegation.patch
+nfsd4-simplify-open_delegation-2.patch
+nfsd4-miscellaneous-delegation-fixes.patch
+nfsd4-remove-unnecessary-check-in-find_delegation_stateid.patch
+nfsd4-fix-nfs4_check_delegmode.patch
+nfsd4-simplify-clientid-hash-table-searches.patch
+nfsd4-simplify-verify_clientid.patch
+nfsd4-dont-allow-unconfirmed-renew.patch
+nfsd4-provide-no_cb_path-error-on-renew.patch
+nfsd4-simplify-find_openstateowner_str.patch
+nfsd4-simplify-find-functions.patch
+nfsd4-return-callback_ident-in-callbacks.patch
+nfsd4-remove-incorrect-kfree-from-callback.patch
+nfsd4-make-nfsd4_cb_recall-return-void.patch
+nfsd4-fix-callback-cred-refcnt-leak.patch
+nfsd4-use-sync-rpc-for-delegation-recall.patch
+nfsd4-trivial-callback-cleanup.patch
+nfsd4-nfs4_cb_recall-cleanup.patch
+nfsd4-remove-dl_recall_cnt.patch
+nfsd4-rename-release_stateid_lockowner.patch
+nfsd4-keep-lockowners-off-perclient-list.patch
+nfsd4-fix-laundromat-delegation-reaping.patch
+nfsd4-remove-st_vfs_set.patch
+nfsd4-remove-st_vfs_file-checks.patch
+nfsd4-fix-cb-race.patch
+nfsd4-fix-delegation-refcounting.patch
+nfsd4-reorganize-release_deleg.patch
+nfsd4-store-file-with-deleg.patch
+nfsd4-fix-delegation-filp-sharing.patch
+nfsd4-fix-sleep-under-spinlock.patch
+nfsd4-allow-io-to-use-deleg-stateid-file.patch
+nfsd4-remove-dl_state.patch
+nfsd4-fix-delegation-refcount-leak.patch
+nfsd4-fix_release_state_owner-prototype.patch
+locks-remove-unnecessary-bug.patch
+nfsd4-move-delegation-decisions-to-lock_manager-callbacks.patch
+nfsd4-eliminate-unnecessary-remove_lease.patch
+replace-schedule_timeout-with-msleep.patch

 kernel nfs4 server update

+fat-fix-writev-add-aio-support.patch
+fat-updated-fat-attributes-patch.patch
+fat-fat_readdirx-with-dotok=yes-fix.patch
+let-fat-handle-ms_synchronous-flag.patch
+fat-rewrite-the-fat-file-allocation-table-access.patch
+fat-add-debugging-code-to-fatentc.patch
+fat-use-unsigned-int-for-free_clusters-and.patch
+fat-struct-vfat_slot_info-cleanup.patch
+fat-use-struct-fat_slot_info-for-fat_search_long.patch
+fat-add-fat_remove_entries.patch
+fat-fat_build_inode-cleanup.patch
+fat-use-struct-fat_slot_info-for-fat_scan.patch
+fat-use-struct-fat_slot_info-for-msdos_find.patch
+fat-vfat_build_slots-cleanup.patch
+fat-use-a-same-timestamp-on-some-operations-path.patch
+fat-msdos_rename-cleanup.patch
+fat-msdos_add_entry-cleanup.patch
+fat-allocate-the-cluster-before-adding-the-directory.patch
+fat-rewrite-fat_add_entries.patch
+fat-use-fat_remove_entries-for-msdos.patch
+fat-make-the-fat_get_entry-fat__get_entry-the.patch
+fat-i_pos-cleanup.patch
+fat-remove-the-multiple-msdos_sb-call.patch
+fat-remove-unneed-mark_inode_dirty.patch
+fat-fix-fat_truncate.patch
+fat-fix-fat_write_inode.patch
+fat-use-synchronous-update-for.patch
+fat-update-rename-path.patch
+fat-fix-typo.patch

 fatfs update: `mount -o sync' support.

+fscache-menuconfig-help-fix-documentation-path.patch

 Kconfig hlpe fix

+geodefb-add-geode-framebuffer-driver-sparc-fix.patch

 Fix geodefb-add-geode-framebuffer-driver.patch on sparc

+fbdev-add-mode-changing-via-sysfs.patch
+fbdev-capture-modelist-change-event.patch
+fbcon-cursor-fixes.patch
+rivafb-fix-i2c-error-handling.patch
+nvidiafb-fix-i2c-error-handling.patch
+nvidiafb-some-chipsets-need-a-buffer-pitch-divisible-by-64.patch
+fbdev-generic-drawing-function-cleanups-2.patch
+fbdev-allow-core-fb-to-be-built-as-a-module.patch
+fbdev-allow-core-fb-to-be-built-as-a-module-fix.patch
+fbdev-allow-core-fb-to-be-built-as-a-module-fix-fix.patch
+savagefb-make-savagefb-one-module.patch
+fbdev-cleanups-in-driver-video.patch
+radeonfb-pll-access-workaround.patch

 framebuffer driver updates

+md-erroneous-sizeof-use-in-raid1.patch
+md-raid1-support-for-bitmap-intent-logging-fix.patch
+md-fix-deadlock-due-to-md-thread-processing-delayed-requests.patch

 Fixes to md patches in -mm.

+verify_area-cleanup-sound-fix.patch

 Fix verify_area-cleanup-sound.patch

+verify_area-cleanup-deprecate-fix.patch

 Fix verify_area-cleanup-deprecate.patch

+arch_alpha_kernel_osf_sys-tiny-cleanup-retvalpatch.patch
+arch_alpha_kernel_osf_sys-tiny-cleanup-retvalpatch-fix.patch
+fs_compat-tiny-cleanup-retvalpatch.patch
+arch_mips_kernel_irixsig-slight-rework-of-irix_sigsendsetpatch.patch
+arch_sparc_kernel_ptrace-pointless-assignment-and-shadowed-varpatch.patch
+verify_area-cleanup-feature-removal-schedulepatch.patch

 Various little cleanups

+fuse-device-functions-use-after-free-fix.patch
+fuse-file-operations-use-generic_file_llseek.patch
+fuse-nfs-export-inode-leak-fix.patch

 FUSE fixes

+list_for_each_entry-arch-i386-mm-pageattrc.patch
+gus_wavec-vfree-checking-cleanups.patch
+i386-traps-replace-schedule_timeout-with-ssleep.patch
+radio-sf16fmi-cleanup.patch
+unified-spinlock-initialization-include-linux-waith.patch
+scripts-mod-sumversionc-replace-strtok-with-strsep.patch
+char-snsc-reorder-set_current_state-and-add_wait_queue.patch
+char-hvsi-use-wait_event_timeout.patch
+char-sx-replace-schedule_timeout-with-msleep_interruptible.patch
+serial-crisv10-replace-schedule_timeout-with-msleep.patch
+ftape-fdc-io-insert-set_current_state-before-schedule_timeout.patch
+tc-zs-replace-schedule_timeout-with-msleep_interruptible.patch
+delete-unused-file-drivers_char_hp600_keybc.patch
+drivers-isdn-tpam-convert-to-pci_register_driver.patch
+drivers-isdn-hardware-avm-convert-to-pci_register_driver.patch
+message-mptbase-replace-schedule_timeout-with-ssleep.patch
+drivers-message-fusion-convert-to-pci_register_driver.patch
+drivers-eisa-convert-to-pci_register_driver.patch
+char-lp-remove-interruptible_sleep_on_timeout-usage.patch
+char-istallion-replace-interruptible_sleep_on-with-wait_event_interruptible.patch
+list_for_each_entry-arch-um-drivers-chan_kernc.patch
+mips-fix-section-type-conflict-about-mpc30x.patch
+macintosh-mediabay-replace-schedule_timeout-with-msleep_interruptible.patch
+drivers-macintoshisdn-convert-to-pci_register_driver.patch
+fix-error-reported-by-nfsd-which-it-gets-etxtbsy.patch

 Little code tweaks.



number of patches in -mm: 943
number of changesets in external trees: 738
number of patches in -mm only: 925
total patches: 1663



All 943 patches:

See ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm2/announce.txt


