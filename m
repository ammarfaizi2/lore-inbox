Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVACJP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVACJP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 04:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVACJP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 04:15:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:62391 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261408AbVACJLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 04:11:22 -0500
Date: Mon, 3 Jan 2005 01:11:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-mm1
Message-Id: <20050103011113.6f6c8f44.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm1


- Added new bk-kconfig tree from Sam

- The bk-usb tree has been dropped due to a tendency to oops.

- Lots of stuff.


Changes since 2.6.10-rc3-mm1:


 linus.patch
 bk-acpi.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-i2c.patch
 bk-ide-dev.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-jfs.patch
 bk-kbuild.patch
 bk-kconfig.patch
 bk-mtd.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch

 External bk trees

-ppc64-make-up-kernel-run-on-power4-logical-partition.patch
-direct-io-set-PF_SYNCWRITE.patch
-msync-set-PF_SYNCWRITE.patch
-reduce-ext3-log-spamming-blank-lines.patch
-do_task_stat-use-pid_alive.patch
-fix-ext2-ext3-memory-leak.patch
-uml-ramdisk-config-fix.patch
-shmctl-shm_lock-perms.patch
-vmlib-wrapped-executable-brk.patch
-vmlib-wrapped-mprotect-flags.patch
-ppc64-workaround-pci-issue-on-g5.patch
-ppc64-pseries-shared-processor-fixes.patch
-highmemc-fix-bio-error-propagation.patch
-documentation-for-ia64-serial-device-name-changes.patch
-add-missing-__kernel__-or-other-protections.patch
-scsi-imm-fix.patch
-gcc4-fixes.patch
-include-asm-x86_64-pgtableh-pgd_offset_gate.patch
-swsusp-bugfixes-do-not-oops-when-not-enough-memory-during-resume.patch
-swsusp-bugfixes-fix-memory-leak.patch
-swsusp-fixes-fix-confusing-printk.patch
-swsusp-fix-header-typo.patch
-swsusp-fix-types.patch
-ppc64-make-sure-lppaca-doesnt-cross-page-boundary.patch
-arcnet-fixes.patch
-x25-when-receiving-a-call-check-listening-sockets-for-matching-call-user-data.patch
-x25-remove-unused-header-files.patch
-net-socketc__sock_create-cleanup.patch
-remove-netfilter-warnings-on-copy_to_user.patch
-small-drivers-atm-cleanups.patch
-ppc64-fix-signal-mask-on-delivery-error.patch
-ppc64-sigmasking-fix.patch
-xen-vmm-4-alloc_skb_from_cache.patch
-sis-drm-bool-bitfields.patch
-allocate-sysfs_dirent-structures-from-their-own-slab.patch
-parenthesize-init_wait.patch
-fix-concurrent-access-to-dev-urandom.patch
-ide-cd-unable-to-read-multisession-dvds.patch
-fix-bogus-echild-return-from-wait-with-zombie-group-leader.patch
-code-to-register-amba-serial-console-is-missing.patch
-selinux-adds-a-private-inode-operation.patch
-reiserfs-private-inode-abstracted-to-static-inline.patch
-reiserfs-fixes-to-allow-reiserfs-to-use-selinux-attributes.patch
-reiserfs-cleaning-up-const-checks.patch
-selinux-hooks-cleanup.patch
-dvb-saa7146-driver-misc-updates.patch
-dvb-b2c2-driver-splitup.patch
-dvb-update-dib-usb-driver.patch
-dvb-dvb-core-update.patch
-dvb-frontend-update.patch
-dvb-av7110-driver-update.patch
-documentation-mem=.patch
-rocket-documentation-changes.patch
-remove-speedstep_coppermine-docs.patch
-final-polish-on-disk-ioctl-documentation.patch
-scsi-qla2xxx-qla_rscnc-remove-unused-functions-fwd.patch

 Merged

+vmscan-total_scanned-fix.patch

 Fix kswapd CPU utilisation problem

-iounmap-fix.patch
-pageattr-fix.patch
-pageattr-flush-tlb-fix.patch
-pageattr-guard-page.patch

 These were conflicting with other patches

-4level-core-patch.patch
-4level-bogus-bug_on.patch
-4level-fix-vmalloc-overflow.patch
-4level-core-tweaks.patch
-4level-highpte-fix.patch
-4level-architecture-changes-for-alpha.patch
-4level-architecture-changes-for-arm.patch
-4level-fixes-arm.patch
-4level-architecture-changes-for-cris.patch
-4level-convert-drm-to-4levels.patch
-4level-add-asm-generic-support-for-emulating.patch
-4level-make-3level-fallback-more-type-safe.patch
-4level-ia64-support.patch
-4level-ia64-support-fix.patch
-pml4-ia64-build-fix.patch
-4level-architecture-changes-for-i386.patch
-4level-architecture-changes-for-i386-fix.patch
-4level-architecture-changes-for-m32r.patch
-4level-architecture-changes-for-ppc.patch
-4level-architecture-changes-for-ppc64.patch
-4level-architecture-changes-for-s390.patch
-4level-architecture-changes-for-s390-fix.patch
-4level-architecture-changes-for-sh.patch
-4level-architecture-changes-for-sh64.patch
-4level-architecture-changes-for-sparc.patch
-4level-architecture-changes-for-sparc64.patch
-4level-architecture-changes-for-x86_64.patch
-4level-architecture-changes-for-x86_64-pml4_offset_gate-fix.patch
-uml-pml4-support.patch
-uml-config_highmem-atomicity-fix.patch

 Andi and Nick's 4-level-pagetable implementation was merged.

+ide-dev-build-fix.patch

 Fix build error in bk-ide-dev.patch

+bk-kbuild-in_gate_area_no_task-warning-fix.patch

 Fix build error in bk-kbuild.patch

-numa-policies-for-file-mappings-mpol_mf_move.patch

 Dropped due to patch clashes.  Is being redone.

+slab-add-more-arch-overrides-to-control-object-alignment.patch

 Allow architecture to override slab minimum alignment.

+collect-page_states-only-from-online-cpus.patch
+collect-page_states-only-from-online-cpus-tidy.patch

 get_page_state() SMP speedup.

+alloc_large_system_hash-numa-interleaving.patch
+filesystem-hashes-numa-interleaving.patch
+tcp-hashes-numa-interleaving.patch

 Spread the large hashtables across NUMA nodes

-page-fault-scalability-patch-v11-ia64-atomic-pte-operations.patch
-page-fault-scalability-patch-v11-universal-cmpxchg-for-i386.patch
-page-fault-scalability-patch-v11-i386-atomic-pte-operations.patch
-page-fault-scalability-patch-v11-x86_64-atomic-pte-operations.patch
-page-fault-scalability-patch-v11-s390-atomic-pte-operations.patch

 These were causing patch clashes and aren't a lot of use on their own.

+xircom_tulip_cb-build-fix-warning-fix.patch

 Fix xircom_cb warning

+netfilter-fix-return-values-of-ipt_recent-checkentry.patch
+netfilter-fix-ip_conntrack_proto_sctp-exit-on-sysctl.patch
+netfilter-fix-ip_ct_selective_cleanup-and-rename.patch
+netfilter-add-comment-above-remove_expectations-in.patch
+netfilter-remove-ipchains-and-ipfwadm-compatibility.patch
+netfilter-remove-copy_to_user-warnings-in-netfilter.patch
+netfilter-fix-cleanup-in-ipt_recent-should-ipt_registrater_match-error.patch
+fix-broken-rst-handling-in-ip_conntrack.patch

 netfilter fixes

+ppc32-add-uimage-to-default-targets.patch
+ppc32-fix-io_remap_page_range-for-36-bit-phys-platforms.patch
+ppc32-resurrect-documentation-powerpc-cpu_featurestxt.patch

 ppc32 udpates

-remove-unnecessary-inclusions-of-asm-aouth.patch

 This broke the build.

+gp-rel-data-support-vs-bk-kbuild-fix.patch

 Fix gp-rel-data-support.patch versus bk-kbuild.

+frv-debugging-fixes.patch
+frv-minix-ext2-bitops-fixes.patch
+frv-perfctr_info-syscall.patch
+frv-update-the-trap-tables-comment.patch
+frv-accidental-tlb-entry-write-protect-fix.patch
+frv-pagetable-handling-fixes.patch
+frv-fr55x-cpu-support-fixes.patch

 FRV arch updates

+implement-nommu-find_vma.patch
+fix-nommu-map_shared-handling.patch
+permit-nommu-map_shared-of-memory-backed-files.patch
+cross-reference-nommu-vmas-with-mappings.patch

 nommu fixes

+trivial-cleanup-in-arch-i386-kernel-heads.patch
+remove-pfn_to_pgdat-on-x86.patch
+boot_ap_for_nondefault_kernel.patch
+i386-boot-loader-ids.patch
+proc-sys-kernel-bootloader_type.patch

 x86 updates

-x86_64-cleanups-preparing-for-memory-hotplug.patch

 THis broke and is being redone

+xen-vmm-4-return-code-for-arch_free_page-fix.patch

 Fix xen-vmm-4-return-code-for-arch_free_page.patch

+arm26-remove-arm32-cruft.patch
+arm26-update-the-atomic-ops.patch
+arm26-build-system-updates.patch
+arm26-update-comments-headers-notes.patch
+arm26-necessary-compilation-fixes-for-2610.patch
+arm26cleanup-trap-handling-assembly.patch
+arm26-new-execve-code.patch
+arm26-move-some-files-to-better-locations.patch
+arm26-remove-shark-arm32-from-arm26.patch
+arm26-softirq-update.patch
+arm26-update-systemh-to-some-semblance-of-recentness.patch
+arm26-replace-arm32-time-handling-code-with-smaller-version.patch
+arm26-tlb-update.patch
+arm26-better-put_user-macros.patch
+arm26-better-unistdh-reimplemented-based-on-arm32.patch

 arm26 architecture update

+fix-naming-in-swsusp.patch
+swsusp-kill-unused-variable.patch
+swsusp-kill-one-line-helpers-handle-read-errors.patch
+swsusp-small-cleanups.patch
+swsusp-kill-on2-algorithm-in-swsusp.patch
+swsusp-try_to_freeze-to-make-freezing-hooks-nicer.patch
+swsusp-try_to_freeze-to-make-freezing-hooks-nicer-fix.patch

 swsusp update

+m32r-add-new-relocation-types-to-elfh.patch
+m32r-support-pgprot_noncached.patch
+m32r-update-ptracec-for-multithread.patch
+m32r-fix-not-to-execute-noexec-pages-0-3.patch
+m32r-cause-sigsegv-for-nonexec-page.patch
+m32r-dont-encode-ace_instruction-in.patch
+m32r-clean-up-arch-m32r-mm-faultc-3-3.patch
+m32r-clean-up-include-asm-m32r-pgtableh.patch
+m32r-support-page_none-1-3.patch
+m32r-remove-page_user-2-3.patch
+m32r-clean-up.patch
+m32r-include-asm-m32r-thread_infoh-minor.patch
+m32r-use-kmalloc-for-m32r-stacks-2-2.patch
+m32r-make-kernel-headers-for-mutual.patch
+m32r-use-generic-hardirq-framework.patch
+m32r-update-include-asm-m32r-systemh.patch
+m32r-update-include-asm-m32r-mmu_contexth.patch

 m32r update

-uml-fix-__pgd_alloc-declaration.patch

 Not needed any more

+s390-core-patches.patch
+s390-common-i-o-layer.patch
+s390-network-device-driver-patches.patch
+s390-dasd-driver.patch
+s390-character-device-drivers.patch
+s390-dcss-driver-cleanup-fix.patch
+s390-sclp-device-driver-cleanup.patch

 S/390 update

-rcu-eliminate-rcu_datalast_qsctr.patch
+rcu-make-two-internal-structs-static.patch
+rcu-simplify-quiescent-state-detection.patch

 rcu cleanups

-ioctl-cleanup.patch
-unlocked_ioctl.patch
+ioctl-rework.patch

 New version of the dont-hold-BKL-across-ioctl patch.

+remove-rcu-abuse-in-cpu_idle-warning-fix.patch

 RCU cleanup

+udf-simplify-udf_iget-fix-race.patch
+udf-fix-reservation-discarding.patch

 UDF fixes

+remove-dead-ext3_put_inode-prototype.patch

 ext3 cleanup

+compat-sigtimedwait.patch
+compat-sigtimedwait-sparc64-fix.patch
+compat-sigtimedwait-ppc64-fix.patch

 compat signal fixes

+prio_tree-roll-call-to-prio_tree_first-into-prio_tree_next.patch
+prio_tree-generalization.patch
+prio_tree-move-general-code-from-mm-to-lib.patch

 priority tree generalisation

+lcd-fix-memory-leak-code-cleanup.patch

 Fix this char driver

+initramfs-unprivileged-image-creation.patch

 initramfs permissions fix

+fix-conflicting-cpu_idle-declarations.patch

 cleanup and fix up cpu_idle() declarations

+removes-redundant-sys_delete_module.patch

 Remove unneeded function.

+task_structexit_state-usage.patch

 Fix the handling of task_struct.state bits.

+trivial-uninline-kill-__exit_mm.patch

 Code cleanup

+pcmcia-rename-pcmcia-devices.patch
+pcmcia-pd6729-e-mail-update.patch
+pcmcia-pd6729-cleanups.patch
+pcmcia-pd6729-isa_irq-handling.patch
+pcmcia-remove-obsolete-code.patch
+pcmcia-remove-pending_events.patch
+pcmcia-remove-client_attributes.patch
+pcmcia-remove-unneeded-parameter-from-rsrc_mgr.patch
+pcmcia-remove-dev_info-from-client.patch
+pcmcia-remove-mtd-and-bulkmem-replaced-by-pcmciamtd.patch
+pcmcia-per-socket-resource-database.patch
+pcmcia-validate_mem-only-for-non-statically-mapped-sockets.patch
+pcmcia-adjust_io_region-only-for-non-statically-mapped-sockets.patch
+pcmcia-find_io_region-only-for-non-statically-mapped-sockets.patch
+pcmcia-find_mem_region-only-for-non-statically-mapped-sockets.patch
+pcmcia-adjust_-and-release_resources-only-for-non-statically-mapped-sockets.patch
+pcmcia-move-resource-handling-code-only-for-non-statically-mapped-sockets-to-other-file.patch
+pcmcia-make-rsrc_nonstatic-an-independend-module.patch
+pcmcia-allocate-resource-database-per-socket.patch
+pcmcia-remove-typedef.patch
+pcmcia-grab-lock-in-resource_release.patch

 pcmcia update

+knfsd-move-nfserr_openmode-checking-from-nfsd_read-write-into-nfs4_preprocess_stateid_op-in-preperation-for-delegation-state.patch
+knfsd-check-the-callback-netid-in-gen_callback.patch
+knfsd-count-the-nfs4_client-structure-usage.patch
+knfsd-preparation-for-delegation-client-callback-probe.patch
+knfsd-preparation-for-delegation-client-callback-probe-warning-fixes.patch
+knfsd-probe-the-callback-path-upon-a-successful-setclientid_confirm.patch
+knfsd-check-for-existence-of-file_lock-parameter-inside-of-the-kernel-lock.patch
+knfsd-get-rid-of-the-special-delegation_stateid_t-use-the-existing-stateid_t.patch
+knfsd-add-structures-for-delegation-support.patch
+knfsd-allocate-and-initialize-the-delegation-structure.patch
+knfsd-find-a-delegation-for-a-file-given-a-stateid.patch
+knfsd-add-the-delegation-release-and-free-functions.patch
+knfsd-changes-to-expire_client.patch
+knfsd-delay-nfsd_colse-for-delegations-until-reaping.patch
+knfsd-delegation-recall-callback-rpc.patch
+knfsd-kernel-thread-for-delegation-callback.patch
+knfsd-helper-functions-for-deciding-to-grant-a-delegation.patch
+knfsd-attempt-to-hand-out-a-delegation.patch
+knfsd-remove-unnecessary-stateowner-existence-check.patch
+knfsd-check-for-openmode-violations-given-a-delegation-stateid.patch
+knfsd-add-checking-of-delegation-stateids-to-nfs4_preprocess_stateid_op.patch
+knfsd-add-the-delegreturn-operation.patch
+knfsd-add-to-the-laundromat-service-for-delegations.patch
+knfsd-clear-the-recall_lru-of-delegations-at-shutdown.patch

 knfsd update

+export-sched_setscheduler-for-kernel-module-use.patch

 Allow modules to set kernel thread scheduling policy

+sched-fix-scheduling-latencies-in-mttrc-reenables-interrupts.patch

 Fix sched-fix-scheduling-latencies-in-mttrc.patch

+replace-numnodes-with-node_online_map-alpha.patch
+replace-numnodes-with-node_online_map-arm.patch
+replace-numnodes-with-node_online_map-i386.patch
+replace-numnodes-with-node_online_map-ia64.patch
+replace-numnodes-with-node_online_map-m32r.patch
+replace-numnodes-with-node_online_map-mips.patch
+replace-numnodes-with-node_online_map-parisc.patch
+replace-numnodes-with-node_online_map-ppc64.patch
+replace-numnodes-with-node_online_map-x86_64.patch
+replace-numnodes-with-node_online_map.patch

 Clean up and fix numa node ID handling

-remove-rcu-abuse-in-cpu_idle-warning-fix.patch

 Not needed

+ppc64-fix-cpu-hotplug.patch

 Fix i386-cpu-hotplug-updated-for-mm.patch for ppc64

 reiser4-export-inode_lock.patch
 reiser4-export-pagevec-funcs.patch
 reiser4-export-radix_tree_preload.patch
+reiser4-export-find_get_pages.patch
 reiser4-radix-tree-tag.patch
 reiser4-radix_tree_lookup_slot.patch
-reiser4-aliased-dir.patch
-reiser4-kobject-umount-race.patch
-reiser4-kobject-umount-race-cleanup.patch
+#reiser4-aliased-dir.patch
+#reiser4-kobject-umount-race.patch
+#reiser4-kobject-umount-race-cleanup.patch
 reiser4-perthread-pages.patch
 reiser4-unstatic-kswapd.patch
 reiser4-include-reiser4.patch
 reiser4-doc.patch
 reiser4-only.patch
-reiser4-page_cache_readahead-fix.patch
-reiser4-fix-a-use-after-free-bug-in-reiser4_parse_options.patch
-reiser4-missing-context-creation-is-added.patch
-reiser4-crypto-update.patch
-reiser4-max_cbk_iteration-fix.patch
-reiser4-reduce-stack-usage.patch
-reiser4-fix-deadlock.patch
-reiser4-dont-use-shrink_dcache_anon.patch
-reiser4-kmap-atomic-fixes.patch
+reiser4-recover-read-performance.patch
+reiser4-export-find_get_pages_tag.patch
+reiser4-add-missing-context.patch

 New reiser4 code drop

+fix-rom-enable-disable-in-r128-and-radeon-fb-drivers.patch
+fbdev-cleanup-i2c-code-of-rivafb.patch
+fbdev-revive-bios-less-booting-for-rage-xl-cards.patch
+fbdev-revive-global_mode_option.patch
+fbcon-fbdev-add-blanking-notification.patch
+fbcon-fbdev-add-blanking-notification-fix.patch
+fbdev-check-return-value-of-fb_add_videomode.patch
+fbdev-do-a-symbol_put-for-each-symbol_get-in-savagefb.patch
+fbdev-add-viewsonic-pf775a-to-broken-display-database.patch
+fbdev-fix-default-timings-in-vga16fb.patch
+fbdev-reduce-stack-usage-of-intelfb.patch
+zr36067-driver-correct-jpeg-app-com-markers.patch
+zr36067-driver-ppc-be-port.patch
+zr36067-driver-reduce-stack-size-usage.patch

 fbdev updates

+moxa-update-status-of-moxa-smartio-driver.patch
+moxa-remove-ancient-changelog-readmemoxa.patch
+moxa-remove-readmemoxa-from-documentation-00-index.patch
+specialix-remove-bouncing-e-mail-address.patch
+stallion-update-to-documentation-stalliontxt.patch
+riscom8-update-staus-and-documentation-of-driver.patch
+pm-remove-outdated-docs.patch
+docs-add-sparse-howto.patch
+cciss-documentation-update.patch
+cciss-correct-mailing-list-address-in-source-code.patch
+cpqarray-correct-mailing-list-address-in-source-code.patch
+sh-remove-x86-specific-help-in-kconfig.patch
+cyclades-put-readmecycladez-in-documentation-serial.patch
+tipar-document-driver-options.patch
+tipar-code-cleanup.patch

 Various documentaiton updates and char driver cleanups

+binfmt_scriptc-make-em86_format-static.patch
+remove-unused-include-asm-m68k-adb_mouseh.patch
+scsi-aic7xxx-remove-two-useless-variables.patch
+remove-in_string_c.patch
+remove-ct_to_secs-ct_to_usecs.patch
+bttv-driverc-make-some-variables-static.patch
+arch-alpha-kconfig-kill-stale-reference-to-documentation-smptex.patch
+init-initramfsc-make-unpack_to_rootfs-static.patch
+oss-misc-cleanups.patch
+inux-269-fs-proc-basec-array-size.patch
+linux-269-fs-proc-proc_ttyc-avoid-array.patch
+signalc-convert-assertion-to-bug_on.patch
+right-severity-level-for-fatal-message.patch
+remove-unused-drivers-char-rio-cdprotoh.patch
+remove-unused-drivers-char-rsf16fmih.patch
+mtd-added-nec-upd29f064115-support.patch

 Various code cleanups

+optimize-prefetch-usage-in-list_for_each_xxx.patch

 speed up list_for_each()

+waiting-10s-before-mounting-root-filesystem.patch

 Retry the mount of the root filesytem during bootup.


number of patches in -mm: 896
number of changesets in external trees: 453
number of patches in -mm only: 879
total patches: 1332



All 896 patches:


linus.patch

expose-reiserfs_sync_fs.patch
  Expose reiserfs_sync_fs()

fix-reiserfs-quota-debug-messages.patch
  Fix reiserfs quota debug messages

fix-of-quota-deadlock-on-pagelock-quota-core.patch
  Fix of quota deadlock on pagelock: quota core

vfs_quota_off-oops-fix.patch
  vfs_quota_off-oops-fix

quota-umount-race-fix.patch
  quota umount race fix

fix-of-quota-deadlock-on-pagelock-ext2.patch
  Fix of quota deadlock on pagelock: ext2

fix-of-quota-deadlock-on-pagelock-ext2-tweaks.patch
  fix-of-quota-deadlock-on-pagelock-ext2-tweaks

fix-of-quota-deadlock-on-pagelock-ext3.patch
  Fix of quota deadlock on pagelock: ext3

fix-of-quota-deadlock-on-pagelock-ext3-tweaks.patch
  fix-of-quota-deadlock-on-pagelock-ext3-tweaks

fix-of-quota-deadlock-on-pagelock-reiserfs.patch
  Fix of quota deadlock on pagelock: reiserfs

fix-of-quota-deadlock-on-pagelock-reiserfs-fix.patch
  fix-of-quota-deadlock-on-pagelock-reiserfs-fix

reiserfs-bug-fix-do-not-clear-ms_active-mount-flag.patch
  reiserfs bug fix: do not clear MS_ACTIVE mount flag

allow-disabling-quota-messages-to-console.patch
  Allow disabling quota messages to console

vmscan-total_scanned-fix.patch
  vmscan: total_scanned fix

cs461x-gameport-code-isnt-being-included-in-build.patch
  CS461x gameport code isn't being included in build

bk-acpi.patch

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

acpi-flush-tlb-when-pagetable-changed.patch
  acpi: flush TLB when pagetable changed

bk-alsa.patch

bk-cifs.patch

bk-cpufreq.patch

bk-i2c.patch

bk-ide-dev.patch

ide-dev-build-fix.patch
  ide-dev-build-fix

bk-input.patch

bk-dtor-input.patch

bk-jfs.patch

bk-kbuild.patch

bk-kbuild-in_gate_area_no_task-warning-fix.patch
  bk-kbuild-in_gate_area_no_task-warning-fix

bk-kconfig.patch

bk-mtd.patch

bk-netdev.patch

via-rhine-warning-fix.patch
  via-rhine warning fix

hostap-fix-kconfig-typos-and-missing-select-crypto.patch
  hostap: fix Kconfig typos and missing select CRYPTO

ixgb-lr-card-support.patch
  ixgb LR card support

bk-ntfs.patch

bk-pci.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

mm-keep-count-of-free-areas.patch
  mm: keep count of free areas

mm-higher-order-watermarks.patch
  mm: higher order watermarks

mm-higher-order-watermarks-fix.patch
  higher order watermarks fix

mm-teach-kswapd-about-higher-order-areas.patch
  mm: teach kswapd about higher order areas

simplified-readahead.patch
  Simplified readahead

simplified-readahead-fix.patch
  Simplified readahead fix

simplified-readahead-cleanups.patch
  simplified-readahead-cleanups

readahead-congestion-control.patch
  Simplified readahead

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

mempolicy-optimization.patch
  mempolicy optimisation

mm-overcommit-updates.patch
  mm: overcommit updates

kill-off-highmem_start_page.patch
  kill off highmem_start_page

make-sure-ioremap-only-tests-valid-addresses.patch
  make sure ioremap only tests valid addresses

mark_page_accessed-for-reads-on-non-page-boundaries.patch
  mark_page_accessed() for read()s on non-page boundaries

do_anonymous_page-use-setpagereferenced.patch
  do_anonymous_page() use SetPageReferenced

slab-add-more-arch-overrides-to-control-object-alignment.patch
  slab: Add more arch overrides to control object alignment

collect-page_states-only-from-online-cpus.patch
  collect page_states only from online cpus

collect-page_states-only-from-online-cpus-tidy.patch
  collect-page_states-only-from-online-cpus-tidy

alloc_large_system_hash-numa-interleaving.patch
  alloc_large_system_hash: NUMA interleaving

filesystem-hashes-numa-interleaving.patch
  filesystem hashes: NUMA interleaving

tcp-hashes-numa-interleaving.patch
  TCP hashes: NUMA interleaving

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

xircom_tulip_cb-build-fix.patch
  xircom_tulip_cb.c build fix

xircom_tulip_cb-build-fix-warning-fix.patch
  xircom_tulip_cb-build-fix warning fix

net-netconsole-poll-support-for-3c509.patch
  net: Netconsole poll support for 3c509

pcnet32-79c976-with-fiber-optic.patch
  pcnet32: 79c976 with fiber optic fix

multicast-filtering-for-tunc.patch
  Multicast filtering for tun.c

r8169-missing-netif_poll_enable-and-irq-ack.patch
  r8169: missing netif_poll_enable and irq ack

r8169-c-101.patch
  r8169: C 101

r8169-large-send-enablement.patch
  r8169: Large Send enablement

r8169-reduce-max-mtu-for-large-frames.patch
  r8169: reduce max MTU for large frames

r8169-oversized-driver-field-for-ethtool.patch
  r8169: oversized driver field for ethtool

fix-ibm_emac-autonegotiation-result-parsing.patch
  EMAC: fix ibm_emac autonegotiation result parsing

netfilter-fix-return-values-of-ipt_recent-checkentry.patch
  netfilter: fix return values of ipt_recent checkentry

netfilter-fix-ip_conntrack_proto_sctp-exit-on-sysctl.patch
  netfilter: Fix ip_conntrack_proto_sctp exit on sysctl fail

netfilter-fix-ip_ct_selective_cleanup-and-rename.patch
  netfilter: Fix ip_ct_selective_cleanup(), and rename ip_ct_iterate_cleanup()

netfilter-add-comment-above-remove_expectations-in.patch
  netfilter: Add comment above remove_expectations in destroy_conntrack()

netfilter-remove-ipchains-and-ipfwadm-compatibility.patch
  netfilter: Remove IPCHAINS and IPFWADM compatibility

netfilter-remove-copy_to_user-warnings-in-netfilter.patch
  netfilter: Remove copy_to_user Warnings in Netfilter

netfilter-fix-cleanup-in-ipt_recent-should-ipt_registrater_match-error.patch
  netfilter: Fix cleanup in ipt_recent should ipt_registrater_match error

fix-broken-rst-handling-in-ip_conntrack.patch
  Fix broken RST handling in ip_conntrack

ppc32-freescale-book-e-mmu-cleanup.patch
  ppc32: freescale Book-E MMU cleanup

ppc32-refactor-common-book-e-exception-code.patch
  ppc32: refactor common book-e exception code

ppc32-switch-to-kbuild_defconfig.patch
  ppc32: Switch to KBUILD_DEFCONFIG

ppc32-marvell-host-bridge-support-mv64x60.patch
  ppc32: Marvell host bridge support (mv64x60)

ppc32-marvell-host-bridge-support-mv64x60-review-fixes.patch
  ppc32-marvell-host-bridge-support-mv64x60 review fixes

ppc32-support-for-marvell-ev-64260-bp-eval-platform.patch
  ppc32: support for Marvell EV-64260[ab]-BP eval platform

ppc32-support-for-force-cpci-690-board.patch
  ppc32: support for Force CPCI-690 board

ppc32-support-for-artesyn-katana-cpci-boards.patch
  ppc32: support for Artesyn Katana cPCI boards

ppc32-add-support-for-ibm-750fx-and-750gx-eval-boards.patch
  ppc32: add Support for IBM 750FX and 750GX Eval Boards

ppc32-ppc4xx-pic-rewrite-cleanup.patch
  ppc32: PPC4xx PIC rewrite/cleanup

ppc32-performance-monitor-oprofile-support-for-e500.patch
  ppc32: performance Monitor/Oprofile support for e500

ppc32-performance-monitor-oprofile-support-for-e500-review-fixes.patch
  Fix prototypes & externs in e500 oprofile support

ppc32-fix-ebonyc-warnings.patch
  ppc32: fix ebony.c warnings

ppc32-remove-bogus-sprn_cpc0_gpio-define.patch
  ppc32: remove bogus SPRN_CPC0_GPIO define

ppc32-debug-setcontext-syscall-implementation.patch
  PPC debug setcontext syscall implementation.

ppc32-add-uimage-to-default-targets.patch
  ppc32: add uImage to default targets

ppc32-fix-io_remap_page_range-for-36-bit-phys-platforms.patch
  ppc32: fix io_remap_page_range for 36-bit phys platforms

ppc32-resurrect-documentation-powerpc-cpu_featurestxt.patch
  ppc32: Resurrect Documentation/powerpc/cpu_features.txt

ppc64-kprobes-implementation.patch
  ppc64: kprobes implementation

ppc64-tweaks-to-cpu-sysfs-information.patch
  ppc64: tweaks to ppc64 cpu sysfs information

ppc64-reloc_hide.patch

kprobes-wrapper-to-define-jprobeentry.patch
  Kprobes: wrapper to define jprobe.entry

termio-userspace-access-error-handling.patch
  Termio userspace access error handling

ide_arch_obsolete_init-fix.patch
  IDE_ARCH_OBSOLETE_INIT fix

out-of-line-implementation-of-find_next_bit.patch
  out-of-line implementation of find_next_bit()

gp-rel-data-support.patch
  GP-REL data support

gp-rel-data-support-vs-bk-kbuild-fix.patch
  gp-rel-data-support-vs-bk-kbuild-fix

vm-routine-fixes.patch
  VM routine fixes

vm-routine-fixes-CONFIG_SHMEM-fix.patch
  vm-routine-fixes CONFIG_SHMEM fix

frv-fujitsu-fr-v-cpu-arch-maintainer-record.patch
  FRV: Fujitsu FR-V CPU arch maintainer record

frv-fujitsu-fr-v-arch-documentation.patch
  FRV: Fujitsu FR-V arch documentation

frv-fujitsu-fr-v-cpu-arch-implementation-part-1.patch
  FRV: Fujitsu FR-V CPU arch implementation part 1

frv-fujitsu-fr-v-cpu-arch-implementation-part-2.patch
  FRV: Fujitsu FR-V CPU arch implementation part 2

frv-fujitsu-fr-v-cpu-arch-implementation-part-3.patch
  FRV: Fujitsu FR-V CPU arch implementation part 3

frv-fujitsu-fr-v-cpu-arch-implementation-part-4.patch
  FRV: Fujitsu FR-V CPU arch implementation part 4

frv-fujitsu-fr-v-cpu-arch-implementation-part-5.patch
  FRV: Fujitsu FR-V CPU arch implementation part 5

frv-fujitsu-fr-v-cpu-arch-implementation-part-6.patch
  FRV: Fujitsu FR-V CPU arch implementation part 6

frv-fujitsu-fr-v-cpu-arch-implementation-part-7.patch
  FRV: Fujitsu FR-V CPU arch implementation part 7

frv-fujitsu-fr-v-cpu-arch-implementation-part-8.patch
  FRV: Fujitsu FR-V CPU arch implementation part 8

frv-fujitsu-fr-v-cpu-arch-implementation-part-9.patch
  FRV: Fujitsu FR-V CPU arch implementation part 9

put-memory-in-dma-zone-not-normal-zone-in-frv-arch.patch
  Put memory in DMA zone not Normal zone in FRV arch

frv-kill-off-highmem_start_page.patch
  kill off highmem_start_page

frv-first-batch-of-fujitsu-fr-v-arch-include-files.patch
  FRV: First batch of Fujitsu FR-V arch include files

frv-remove-obsolete-hardirq-stuff-from-includes.patch
  frv: emove obsolete hardirq stuff from includes

frv-pci-dma-fixes.patch
  frv: PCI DMA fixes

fix-frv-pci-config-space-write.patch
  frv: Fix PCI config space write

frv-more-fujitsu-fr-v-arch-include-files.patch
  FRV: More Fujitsu FR-V arch include files

convert-frv-to-use-remap_pfn_range.patch
  convert FRV to use remap_pfn_range

frv-yet-more-fujitsu-fr-v-arch-include-files.patch
  FRV: Yet more Fujitsu FR-V arch include files

frv-remaining-fujitsu-fr-v-arch-include-files.patch
  FRV: Remaining Fujitsu FR-V arch include files

frv-make-calibrate_delay-optional.patch
  FRV: Make calibrate_delay() optional

frv-better-mmap-support-in-uclinux.patch
  FRV: Better mmap support in uClinux

frv-procfs-changes-for-nommu-changes.patch
  FRV: procfs changes for nommu changes

frv-change-setup_arg_pages-to-take-stack-pointer.patch
  FRV: change setup_arg_pages() to take stack pointer

frv-change-setup_arg_pages-to-take-stack-pointer-fixes.patch
  Fix usage of setup_arg_pages() in IA64, MIPS, S390 and Sparc64

frv-add-fdpic-elf-binary-format-driver.patch
  FRV: Add FDPIC ELF binary format driver

fix-some-elf-fdpic-binfmt-problems.patch
  Fix some ELF-FDPIC binfmt problems

further-nommu-changes.patch
  Further nommu changes

further-nommu-proc-changes.patch
  Further nommu /proc changes

frv-arch-nommu-changes.patch
  frv: nommu changes

make-more-syscalls-available-for-the-fr-v-arch.patch
  Make more syscalls available for the FR-V arch

frv-debugging-fixes.patch
  FRV: debugging fixes

frv-minix-ext2-bitops-fixes.patch
  frv: Minix & ext2 bitops fixes

frv-perfctr_info-syscall.patch
  frv: perfctr_info syscall

frv-update-the-trap-tables-comment.patch
  frv: update the trap tables comment

frv-accidental-tlb-entry-write-protect-fix.patch
  frv: accidental TLB entry write-protect fix

frv-pagetable-handling-fixes.patch
  FRV: pagetable handling fixes

frv-fr55x-cpu-support-fixes.patch
  FRV: FR55x CPU support fixes

implement-nommu-find_vma.patch
  Implement nommu find_vma()

fix-nommu-map_shared-handling.patch
  Fix nommu MAP_SHARED handling

permit-nommu-map_shared-of-memory-backed-files.patch
  Permit nommu MAP_SHARED of memory backed files

cross-reference-nommu-vmas-with-mappings.patch
  Cross-reference nommu VMAs with mappings

superhyway-bus-support.patch
  SuperHyway bus support

assign-pkmap_base-dynamically.patch
  Assign PKMAP_BASE dynamically

x86-remove-data-header-and-code-overlap-in-boot-setups.patch
  x86: remove data-header and code overlap in boot/setup.S

cyrix-mii-cpuid-returns-stale-%ecx.patch
  Cyrix MII cpuid returns stale %ecx

nx-fix-noexec-kernel-parameter.patch
  NX: Fix noexec kernel parameter

nx-triple-fault-with-4k-kernel-mappings-and-pae.patch
  NX: Triple fault with 4k kernel mappings and PAE

trivial-cleanup-in-arch-i386-kernel-heads.patch
  Trivial cleanup in arch/i386/kernel/head.S

remove-pfn_to_pgdat-on-x86.patch
  remove pfn_to_pgdat() on x86

boot_ap_for_nondefault_kernel.patch
  Secondary cpus boot-up for non defalut location built kernels

i386-boot-loader-ids.patch
  i386 boot loader IDs

proc-sys-kernel-bootloader_type.patch
  /proc/sys/kernel/bootloader_type

intel-thermal-monitor-for-x86_64.patch
  Intel thermal monitor for x86_64

x86_64-do_general_protection-retval-check.patch
  x86_64: do_general_protection() retval check

x86_64-add-a-real-pfn_valid.patch
  x86_64: Add a real pfn_valid

x86_64-fix-bugs-in-the-amd-k8-cmp-support-code.patch
  x86_64: Fix bugs in the AMD K8 CMP support code.

x86_64-fix-bugs-in-the-amd-k8-cmp-support-code-fix.patch
  x86_64: numa_add_cpu() fix

x86_64-reenable-mga-dri-on-x86-64.patch
  x86_64: Reenable MGA DRI on x86-64

x86_64-remove-duplicated-fake_stack_frame-macro.patch
  x86_64: Remove duplicated FAKE_STACK_FRAME macro.

x86_64-remove-bios-reboot-code.patch
  x86_64: Remove BIOS reboot code

x86_64-add-reboot=force.patch
  x86_64: Add reboot=force

x86_64-collected-ioremap-fixes.patch
  x86_64: Collected ioremap fixes

x86_64-handle-nx-correctly-in-pageattr.patch
  x86_64: Handle NX correctly in pageattr

x86_64-split-acpi-boot-table-parsing.patch
  x86_64: Split ACPI boot table parsing

x86_64-split-acpi-boot-table-parsing-fix.patch
  x86_64-split-acpi-boot-table-parsing-fix

x86_64-add-srat-numa-discovery-to-x86-64.patch
  x86_64: Add SRAT NUMA discovery to x86-64.

x86_64-update-uptime-after-suspend.patch
  x86_64: Update uptime after suspend

x86_64-allow-a-kernel-debugger-to-hide-single-steps-in.patch
  x86_64: Allow a kernel debugger to hide single steps in more cases.

x86_64-remove-debug-information-for-vsyscalls.patch
  x86_64: Remove debug information for vsyscalls

x86_64-rename-htvalid-to-cmp_legacy.patch
  x86_64: Rename HTVALID to CMP_LEGACY

x86_64-scheduler-support-for-amd-cmp.patch
  x86_64: Scheduler support for AMD CMP

x86_64-add-a-missing-__iomem-pointed-out-by-linus.patch
  x86_64: Add a missing __iomem pointed out by Linus.

x86_64-add-a-missing-newline-in-proc-cpuinfo.patch
  x86_64: Add a missing newline in /proc/cpuinfo

x86_64-always-print-segfaults-for-init.patch
  x86_64: Always print segfaults for init.

x86_64-export-phys_proc_id.patch
  x86_64: Export phys_proc_id

x86_64-allow-to-configure-more-cpus-and-nodes.patch
  x86_64: Allow to configure more CPUs and nodes.

x86_64-allow-to-configure-more-cpus-and-nodes-fix.patch
  x86_64-allow-to-configure-more-cpus-and-nodes fix

x86_64-fix-a-warning-in-the-cmp-support-code-for.patch
  x86_64: Fix a warning in the CMP support code for !CONFIG_NUMA

x86_64-fix-some-outdated-assumptions-that-cpu-numbers.patch
  x86_64: Fix some outdated assumptions that CPU numbers are equal numbers.

x86_64-fix-em64t-config-description.patch
  x86_64: Fix EM64T config description

x86_64-remove-unneeded-ifdef-in-hardirqh.patch
  x86_64: Remove unneeded ifdef in hardirq.h

x86_64-add-slit-inter-node-distance-information-to.patch
  x86_64: Add SLIT (inter node distance) information to sysfs.

x86_64-add-x86_64-support-for-jack-steiners-slit-sysfs.patch
  x86_64: Add x86_64 support for Jack Steiner's SLIT sysfs patch

x86_64-eliminate-some-useless-printks-in-acpi-numac.patch
  x86_64: Eliminate some useless printks in ACPI numa.c

xen-vmm-4-add-ptep_establish_new-to-make-va-available.patch
  Xen VMM #4: add ptep_establish_new to make va available

xen-vmm-4-return-code-for-arch_free_page.patch
  Xen VMM #4: return code for arch_free_page

xen-vmm-4-return-code-for-arch_free_page-fix.patch
  Get rid of arch_free_page() warning

xen-vmm-4-runtime-disable-of-vt-console.patch
  Xen VMM #4: runtime disable of VT console

xen-vmm-4-has_arch_dev_mem.patch
  Xen VMM #4: HAS_ARCH_DEV_MEM

xen-vmm-4-split-free_irq-into-teardown_irq.patch
  Xen VMM #4: split free_irq into teardown_irq

h8-300-new-systemcall-support.patch
  H8/300 new systemcall support

arm26-remove-arm32-cruft.patch
  arm26: remove arm32 cruft

arm26-update-the-atomic-ops.patch
  arm26: update the atomic ops

arm26-build-system-updates.patch
  arm26 build system updates

arm26-update-comments-headers-notes.patch
  arm26: update comments, headers, notes

arm26-necessary-compilation-fixes-for-2610.patch
  arm26: necessary compilation fixes for 2.6.10

arm26cleanup-trap-handling-assembly.patch
  arm26:cleanup trap handling assembly

arm26-new-execve-code.patch
  arm26: new execve code

arm26-move-some-files-to-better-locations.patch
  arm26: move some files to better locations

arm26-remove-shark-arm32-from-arm26.patch
  arm26: remove shark (arm32) from arm26

arm26-softirq-update.patch
  arm26: softirq update

arm26-update-systemh-to-some-semblance-of-recentness.patch
  arm26: update system.h to some semblance of recentness.

arm26-replace-arm32-time-handling-code-with-smaller-version.patch
  arm26: replace arm32 time handling code with smaller version

arm26-tlb-update.patch
  arm26: TLB update

arm26-better-put_user-macros.patch
  arm26: better put_user macros.

arm26-better-unistdh-reimplemented-based-on-arm32.patch
  arm26: better unistd.h (reimplemented based on arm32)

ia64-remove-hcdp-support-for-early-printk.patch
  ia64: remove HCDP support for early printk

typeofdev-powersaved_state.patch
  typeof(dev->power.saved_state)

fix-naming-in-swsusp.patch
  fix naming in swsusp

swsusp-kill-unused-variable.patch
  swsusp: kill unused variable

swsusp-kill-one-line-helpers-handle-read-errors.patch
  swsusp: kill one-line helpers, handle read errors

swsusp-small-cleanups.patch
  From: Pavel Machek <pavel@ucw.cz>
  Subject: swsusp: Small cleanups

swsusp-kill-on2-algorithm-in-swsusp.patch
  swsusp: Kill O(n^2) algorithm in swsusp

swsusp-try_to_freeze-to-make-freezing-hooks-nicer.patch
  swsusp: try_to_freeze to make freezing hooks nicer

swsusp-try_to_freeze-to-make-freezing-hooks-nicer-fix.patch
  swsusp-try_to_freeze-to-make-freezing-hooks-nicer fix

m32r-add-new-relocation-types-to-elfh.patch
  m32r: Add new relocation types to elf.h

m32r-support-pgprot_noncached.patch
  m32r: Support pgprot_noncached()

m32r-update-ptracec-for-multithread.patch
  m32r: Update ptrace.c for multithread  debugging

m32r-fix-not-to-execute-noexec-pages-0-3.patch
  Subject: [PATCH 2.6.10-rc3-mm1] m32r: Fix not to execute noexec pages (0/3)

m32r-cause-sigsegv-for-nonexec-page.patch
  Subject: [PATCH 2.6.10-rc3-mm1] m32r: Cause SIGSEGV for nonexec page  execution (1/3)

m32r-dont-encode-ace_instruction-in.patch
  Subject: [PATCH 2.6.10-rc3-mm1] m32r: Don't encode ACE_INSTRUCTION in  address (2/3)

m32r-clean-up-arch-m32r-mm-faultc-3-3.patch
  Subject: [PATCH 2.6.10-rc3-mm1] m32r: Clean up arch/m32r/mm/fault.c (3/3)

m32r-clean-up-include-asm-m32r-pgtableh.patch
  Subject: [PATCH 2.6.10-rc3-mm1] m32r: Clean up include/asm-m32r/pgtable.h

m32r-support-page_none-1-3.patch
  m32r: Support PAGE_NONE

m32r-remove-page_user-2-3.patch
  m32r: Remove PAGE_USER

m32r-clean-up.patch
  m32r: Clean up include/asm-m32r/pgtable-2level.h

m32r-include-asm-m32r-thread_infoh-minor.patch
  m32r: include/asm-m32r/thread_info.h minor  updates

m32r-use-kmalloc-for-m32r-stacks-2-2.patch
  m32r: Use kmalloc for m32r stacks

m32r-make-kernel-headers-for-mutual.patch
  m32r: Make kernel headers for mutual  exclusion

m32r-use-generic-hardirq-framework.patch
  m32r: Use generic hardirq framework

m32r-update-include-asm-m32r-systemh.patch
  m32r: Update include/asm-m32r/system.h

m32r-update-include-asm-m32r-mmu_contexth.patch
  m32r: Update include/asm-m32r/mmu_context.h

uml-remove-most-devfs_mk_symlink-calls.patch
  uml: remove most devfs_mk_symlink calls

uml-fix-__wrap_free-comment.patch
  uml: fix __wrap_free comment

uml-fix-some-ptrace-functions-returns-values.patch
  uml: fix some ptrace functions returns values

uml-redo-the-signal-delivery-mechanism.patch
  uml: redo the signal delivery mechanism

uml-make-restorer-match-i386.patch
  uml: make restorer match i386

uml-unistdh-cleanup.patch
  uml: unistd.h cleanup

uml-remove-a-quilt-induced-duplicity.patch
  uml: remove a quilt-induced duplicity

uml-fix-sigreturn-to-not-copy_user-under-a-spinlock.patch
  uml: fix sigreturn to not copy_user under a spinlock

uml-close-host-file-descriptors-properly.patch
  uml: close host file descriptors properly

uml-free-host-resources-associated-with-freed-irqs.patch
  uml: free host resources associated with freed IRQs

uml-unregister-signal-handlers-at-reboot.patch
  uml: unregister signal handlers at reboot

hostfs-uml-set-sendfile-to-generic_file_sendfile.patch
  hostfs: uml: set .sendfile to generic_file_sendfile

hostfs-uml-add-some-other-pagecache-methods.patch
  hostfs: uml: add some other pagecache methods

uml-terminal-cleanup.patch
  uml: terminal cleanup

uml-first-part-rework-of-run_helper-and-users.patch
  Uml: first part rework of run_helper() and users.

uml-finish-fixing-run_helper-failure-path.patch
  uml: finish fixing run_helper failure path

uml-add-elf-vsyscall-support.patch
  uml: add elf vsyscall support

uml-make-vsyscall-page-into-process-page-tables.patch
  uml: make vsyscall page into process page tables

uml-include-vsyscall-page-in-core-dumps.patch
  uml: include vsyscall page in core dumps

uml-add-tracesysgood-support.patch
  uml: Add TRACESYSGOOD support

uml-kill-host-processes-properly.patch
  uml: kill host processes properly

uml-defconfig-update.patch
  uml: defconfig update

uml-small-vsyscall-fixes.patch
  uml: small vsyscall fixes

uml-export-end_iomem.patch
  uml: export end_iomem

uml-system-call-restart-fixes.patch
  uml: system call restart fixes

uml-fix-setting-of-tif_sigpending.patch
  uml: Fix setting of TIF_SIGPENDING

uml-allow-vsyscall-code-to-build-on-24.patch
  uml: Allow vsyscall code to build on 2.4

uml-sysemu-fixes.patch
  uml: SYSEMU fixes

uml-correctly-restore-extramask-in-sigreturn.patch
  uml: correctly restore extramask in sigreturn

uml-fix-update_process_times-call.patch
  uml: fix update_process_times call

uml-detect-sysemu_singlestep.patch
  uml: detect SYSEMU_SINGLESTEP

uml-use-sysemu_singlestep.patch
  uml: use SYSEMU_SINGLESTEP

uml-declare-ptrace_setfpregs.patch
  uml: declare ptrace_setfpregs

uml-remove-bogus-__nr_sigreturn-check.patch
  uml: Remove bogus __NR_sigreturn check

uml-fix-highmem-compilation.patch
  uml: Fix highmem compilation

uml-symbol-export.patch
  uml: symbol export

uml-fix-umldir-init-order.patch
  uml: fix umldir init order

uml-raise-tty-limit.patch
  uml: raise tty limit

uml-sysfs-support-for-uml-network-driver.patch
  uml: sysfs support for uml network driver.

uml-sysfs-support-for-the-uml-block-devices.patch
  uml: sysfs support for the uml block devices.

s390-remove-compat-setup_arg_pages32.patch
  s390: remove compat setup_arg_pages32

s390-core-patches.patch
  s390: core patches

s390-common-i-o-layer.patch
  s390: Common I/O layer

s390-network-device-driver-patches.patch
  s390: Network device driver patches

s390-dasd-driver.patch
  s390: DASD driver

s390-character-device-drivers.patch
  s390: Character device drivers

s390-dcss-driver-cleanup-fix.patch
  s390: DCSS driver cleanup fix

s390-sclp-device-driver-cleanup.patch
  From: Heiko Carstens <heiko.carstens@de.ibm.com>
  Subject: [PATCH 8/8] s390: SCLP device driver cleanup

enhanced-i-o-accounting-data-patch.patch
  enhanced I/O accounting data patch

enhanced-memory-accounting-data-collection.patch
  enhanced Memory accounting data collection

enhanced-memory-accounting-data-collection-tidy.patch
  enhanced-memory-accounting-data-collection-tidy

wacom-tablet-driver.patch
  wacom tablet driver

force-feedback-support-for-uinput.patch
  Force feedback support for uinput

kmap_atomic-takes-char.patch
  kmap_atomic takes char*

kmap_atomic-takes-char-fix.patch
  kmap_atomic-takes-char-fix

kmap_atomic-fallout.patch
  kmap_atomic fallout

kunmap-fallout-more-fixes.patch
  kunmap-fallout-more-fixes

4-4gb-incorrect-bound-check-in-do_getname.patch
  4/4GB: Incorrect bound check in do_getname()

handle-quoted-module-parameters.patch
  handle quoted module parameters

CONFIG_SOUND_VIA82CXXX_PROCFS.patch
  Add CONFIG_SOUND_VIA82CXXX_PROCFS

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
  Allow admin to enable only some of the Magic-Sysrq functions

gen_init_cpio-symlink-pipe-socket-support.patch
  gen_init_cpio symlink, pipe and socket support

gen_init_cpio-slink_pipe_sock_2.patch
  gen_init_cpio-slink_pipe_sock_2

initramfs-allow-no-trailer.patch
  INITRAMFS: allow no trailer

move-irq_enter-and-irq_exit-to-common-code.patch
  move irq_enter and irq_exit to common code

remove-unused-irq_cpustat-fields.patch
  remove unused irq_cpustat fields

hold-bkl-for-shorter-period-in-generic_shutdown_super.patch
  Hold BKL for shorter period in generic_shutdown_super().

cleanups-for-the-ipmi-driver.patch
  Cleanups for the IPMI driver

htree-telldir-fix.patch
  ext3 htree telldir() fix

kill-blkh.patch
  kill blk.h

ext3-cleanup-handling-of-aborted-transactions.patch
  ext3: cleanup handling of aborted transactions.

ext3-handle-attempted-delete-of-bitmap-blocks.patch
  ext3: handle attempted delete of bitmap blocks.

ext3-handle-attempted-double-delete-of-metadata.patch
  ext3: handle attempted double-delete of metadata.

cpumask_t-initializers.patch
  cpumask_t initializers

time-run-too-fast-after-s3.patch
  time runx too fast after S3

fork-total_forks-not-counted-under-tasklist_lock.patch
  fork: total_forks not counted under tasklist_lock

suppress-might_sleep-if-oopsing.patch
  suppress might_sleep() if oopsing

file-sync-no-i_sem.patch
  Reduce i_sem usage during file sync operations

ext3-support-for-ea-in-inode.patch
  ext3: support for EA in inode

ext3-support-for-ea-in-inode-warning-fix.patch
  ext3-xattr-warning-fix

off-by-one-in-drivers-parport-probec.patch
  Off by one in drivers/parport/probe.c

compile-with-ffreestanding.patch
  compile with -ffreestanding

sys_stime-needs-a-compat-function.patch
  sys_stime needs a compat function

sys_stime-needs-a-compat-function-update.patch

sync-in-core-time-granuality-with-filesystems.patch
  Sync in core time granuality with filesystems

sync-in-core-time-granuality-with-filesystems-sonypi-fix.patch
  sync-in-core-time-granuality-with-filesystems-sonypi-fix

remove-ip2-programs.patch
  remove ip2 programs

rcu-eliminate-rcu_ctrlblklock.patch
  rcu: eliminate rcu_ctrlblk.lock

rcu-make-two-internal-structs-static.patch
  rcu: make two internal structs static

rcu-simplify-quiescent-state-detection.patch
  rcu: simplify quiescent state detection

smb_file_open-retval-fix.patch
  smb_file_open() retval fix

sys_sched_setaffinity-on-up-should-fail-for-non-zero.patch
  sys_sched_setaffinity() on UP should fail for non-zero CPUs.

make-gconfig-work-with-gtk-24.patch
  make gconfig work with gtk-2.4

edd-add-edd=off-and-edd=skipmbr-options.patch
  EDD: add edd=off and edd=skipmbr options

panic_timeout-move-to-kernelh.patch
  panic_timeout: move to kernel.h

add-pr_get_name.patch
  Add PR_GET_NAME

fix-alt-sysrq-deadlock.patch
  fix alt-sysrq deadlock

cpumask-range-check-before-using-value.patch
  cpumask: range check before using value

noop-iosched-make-code-static.patch
  noop iosched: make code static

noop-iosched-remove-unused-includes.patch
  noop iosched: remove unused includes

loop-device-recursion-avoidance.patch
  loop device resursion avoidance

noone-uses-have_arch_si_codes-or-have_arch_sigevent_t.patch
  noone uses HAVE_ARCH_SI_CODES or HAVE_ARCH_SIGEVENT_T

get_blkdev_list-cleanup.patch
  get_blkdev_list() cleanup

ext-apply-umask-to-symlinks-with-acls-configured-out.patch
  Ext[23]: apply umask to symlinks with ACLs configured out

fix-missing-wakeup-in-ipc-sem.patch
  fix missing wakeup in ipc/sem

irq-resource-deallocation-acpi.patch
  IRQ resource deallocation: ACPI

irq-resource-deallocation-ia64.patch
  IRQ resource deallocation: ia64

ioctl-rework.patch
  ioctl rework

__getblk_slow-can-loop-forever-when-pages-are-partially.patch
  __getblk_slow can loop forever when pages are partially mapped

remove-rcu-abuse-in-cpu_idle.patch
  Remove RCU abuse in cpu_idle()

remove-rcu-abuse-in-cpu_idle-warning-fix.patch
  remove-rcu-abuse-in-cpu_idle-warning-fix

udf-simplify-udf_iget-fix-race.patch
  udf: simplify udf_iget, fix race

udf-fix-reservation-discarding.patch
  udf: fix reservation discarding

remove-dead-ext3_put_inode-prototype.patch
  remove dead ext3_put_inode prototype

compat-sigtimedwait.patch
  compat: sigtimedwait

compat-sigtimedwait-sparc64-fix.patch
  compat-sigtimedwait-sparc64-fix

compat-sigtimedwait-ppc64-fix.patch
  compat-sigtimedwait ppc64 fix

msync-set-PF_SYNCWRITE.patch
  msync(): set PF_SYNCWRITE

prio_tree-roll-call-to-prio_tree_first-into-prio_tree_next.patch
  prio_tree: roll call to prio_tree_first into prio_tree_next

prio_tree-generalization.patch
  prio_tree: generalization

prio_tree-move-general-code-from-mm-to-lib.patch
  prio_tree: move general code from mm/ to lib/

lcd-fix-memory-leak-code-cleanup.patch
  lcd: fix memory leak, code cleanup

initramfs-unprivileged-image-creation.patch
  initramfs: unprivileged image creation

fix-conflicting-cpu_idle-declarations.patch
  fix conflicting cpu_idle() declarations

removes-redundant-sys_delete_module.patch
  remove redundant sys_delete_module()

fix-stop-signal-race.patch
  fix stop signal race

move-group_exit-flag-into-signal_structflags-word.patch
  move group_exit flag into signal_struct.flags word

fix-ptracer-death-race-yielding-bogus-bug_on.patch
  fix ptracer death race yielding bogus BUG_ON

move-waitchld_exit-from-task_struct-to-signal_struct.patch
  move waitchld_exit from task_struct to signal_struct

task_structexit_state-usage.patch
  task_struct.exit_state usage

trivial-uninline-kill-__exit_mm.patch
  uninline/kill __exit_mm()

selinux-scalability-add-spin_trylock_irq-and.patch
  SELinux scalability: add spin_trylock_irq and  spin_trylock_irqsave

selinux-scalability-convert-avc-to-rcu.patch
  SELinux scalability: convert AVC to RCU

selinux-scalability-convert-avc-to-rcu-fix.patch
  SELinux: fix bug in avc_update_node()

selinux-atomic_dec_and_test-bug.patch
  SELinux: atomic_dec_and_test() bug

selinux-scalability-avc-statistics-and-tuning.patch
  SELinux scalability: AVC statistics and tuning

selinux-regenerate-selinux-module-headers.patch
  SELinux: regenerate SELinux module headers

selinux-update-selinux_task_setscheduler.patch
  SELinux: update selinux_task_setscheduler

selinux-audit-task-comm-if-exe-cannot-be-determined.patch
  SELinux: audit task comm if exe cannot be determined

selinux-add-dynamic-context-transition-support-to-selinux.patch
  SELinux: add dynamic context transition support to SELinux

selinux-enhance-selinux-control-of-executable-mappings.patch
  SELinux: enhance SELinux control of executable mappings

selinux-add-member-node-to-selinuxfs.patch
  SELinux: add member node to selinuxfs

selinux-eliminate-unaligned-accesses-by-policy-loading-code.patch
  SELinux: eliminate unaligned accesses by policy loading code

oprofile-add-check_user_page_readable.patch
  oprofile: add check_user_page_readable()

oprofile-arch-independent-code-for-stack-trace.patch
  oprofile: arch-independent code for stack trace sampling

oprofile-arch-independent-code-for-stack-trace-rename-timer_init.patch
  oprofile-arch-independent-code-for-stack-trace: rename timer_init

oprofile-timer-backtrace-fix-2.patch
  oprofile: backtrace operation does not initialized

oprofile-i386-support-for-stack-trace-sampling.patch
  oprofile: i386 support for stack trace sampling

oprofile-i386-support-for-stack-trace-sampling-cleanup.patch
  oprofile-i386-support-for-stack-trace-sampling-cleanup

oprofile-i386-support-for-stack-trace-sampling-fix.patch
  oprofile-i386-support-for-stack-trace-sampling x86_64 fix

oprofile-ia64-support-for-oprofile-stack-trace.patch
  oprofile: ia64 support for oprofile stack trace sampling

oprofile-update-alpha-for-api-changes.patch
  oprofile: update alpha for api changes

oprofile-update-arm-for-api-changes.patch
  oprofile: update arm for api changes

oprofile-update-ppc-for-api-changes.patch
  oprofile: update ppc for api changes

oprofile-update-parisc-for-api-changes.patch
  oprofile: update parisc for api changes

oprofile-update-s390-for-api-changes.patch
  oprofile: update s390 for api changes

oprofile-update-sh-for-api-changes.patch
  oprofile: update sh for api changes

oprofile-update-sparc64-for-api-changes.patch
  oprofile: update sparc64 for api changes

oprofile-minor-cleanups.patch
  oprofile: minor cleanups

pcmcia-new-ds-cs-interface.patch
  pcmcia: new ds - cs interface

pcmcia-call-device-drivers-from-ds-not-from-cs.patch
  pcmcia: call device drivers from ds, not from cs

pcmcia-unify-bind_mtd-and-pcmcia_bind_mtd.patch
  pcmcia: unify bind_mtd and pcmcia_bind_mtd

pcmcia-unfiy-bind_device-and-pcmcia_bind_device.patch
  pcmcia: unfiy bind_device and pcmcia_bind_device

pcmcia-device-model-integration-can-only-be-submitted-under-gpl.patch
  pcmcia: device model integration can only be submitted under GPL

pcmcia-add-pcmcia_devices.patch
  pcmcia: add pcmcia_device(s)

pcmcia-remove-socket_bind_t-use-pcmcia_devices-instead.patch
  pcmcia: remove socket_bind_t, use pcmcia_devices instead

pcmcia-remove-internal-module-use-count-use-module_refcount-instead.patch
  pcmcia: remove internal module use count, use module_refcount instead

pcmcia-set-drivers-owner-field.patch
  pcmcia: set driver's .owner field

pcmcia-move-pcmcia_unregister_client-to-ds.patch
  pcmcia: move pcmcia_(un,)register_client to ds

pcmcia-device-model-integration-can-only-be-submitted-under-gpl-part-2.patch
  pcmcia: device model integration can only be submitted under GPL, part 2

pcmcia-use-kref-instead-of-native-atomic-counter.patch
  pcmcia: use kref instead of native atomic counter

pcmcia-add-pcmcia_putget_socket.patch
  pcmcia: add pcmcia_(put,get)_socket

pcmcia-grab-a-reference-to-the-cs-socket-in-ds.patch
  pcmcia: grab a reference to the cs-socket in ds

pcmcia-get-a-reference-to-ds-socket-for-each-pcmcia_device.patch
  pcmcia: get a reference to ds-socket for each pcmcia_device

pcmcia-add-a-pointer-to-client-in-struct-pcmcia_device.patch
  pcmcia: add a pointer to client in struct pcmcia_device

pcmcia-use-pcmcia_device-in-send_event.patch
  pcmcia: use pcmcia_device in send_event

pcmcia-use-pcmcia_device-to-mark-clients-as-stale.patch
  pcmcia: use pcmcia_device to mark clients as stale

pcmcia-code-moving-in-ds.patch
  pcmcia: code moving in ds

pcmcia-use-pcmcia_device-in-register_client.patch
  pcmcia: use pcmcia_device in register_client

pcmcia-direct-ordered-unbind-of-devices.patch
  pcmcia: direct-ordered unbind of devices

pcmcia-bug-on-dev_list-=-null.patch
  pcmcia: BUG on dev_list != NULL

pcmcia-bug-if-clients-are-kept-too-long.patch
  pcmcia: BUG() if clients are kept too long

pcmcia-move-struct-client_t-inside-struct-pcmcia_device.patch
  pcmcia: move struct client_t inside struct pcmcia_device

pcmcia-use-driver_find-in-ds.patch
  pcmcia: use driver_find in ds

pcmcia-set_netdev-for-network-devices.patch
  pcmcia: SET_NETDEV for network devices

pcmcia-set_netdev-for-wireless-network-devices.patch
  pcmcia: SET_NETDEV for wireless network devices

pcmcia-reduce-stack-usage-in-ds_ioctl-randy-dunlap.patch
  pcmcia: reduce stack usage in ds_ioctl (Randy Dunlap)

pcmcia-add-disable_clkrun-option.patch
  pcmcia: Add disable_clkrun option

pcmcia-rename-pcmcia-devices.patch
  pcmcia: rename PCMCIA devices

pcmcia-pd6729-e-mail-update.patch
  pcmcia: pd6729: e-mail update

pcmcia-pd6729-cleanups.patch
  pcmcia: pd6729: cleanups

pcmcia-pd6729-isa_irq-handling.patch
  pcmcia: pd6729: isa_irq handling

pcmcia-remove-obsolete-code.patch
  pcmcia: remove obsolete code

pcmcia-remove-pending_events.patch
  pcmcia: remove pending_events

pcmcia-remove-client_attributes.patch
  pcmcia: remove client_attributes

pcmcia-remove-unneeded-parameter-from-rsrc_mgr.patch
  pcmcia: remove unneeded parameter from rsrc_mgr

pcmcia-remove-dev_info-from-client.patch
  pcmcia: remove dev_info from client

pcmcia-remove-mtd-and-bulkmem-replaced-by-pcmciamtd.patch
  pcmcia: remove mtd and bulkmem (replaced by pcmciamtd)

pcmcia-per-socket-resource-database.patch
  pcmcia: per-socket resource database

pcmcia-validate_mem-only-for-non-statically-mapped-sockets.patch
  pcmcia: validate_mem only for non-statically mapped sockets

pcmcia-adjust_io_region-only-for-non-statically-mapped-sockets.patch
  pcmcia: adjust_io_region only for non-statically mapped sockets

pcmcia-find_io_region-only-for-non-statically-mapped-sockets.patch
  pcmcia: find_io_region only for non-statically mapped sockets

pcmcia-find_mem_region-only-for-non-statically-mapped-sockets.patch
  pcmcia: find_mem_region only for non-statically mapped sockets

pcmcia-adjust_-and-release_resources-only-for-non-statically-mapped-sockets.patch
  pcmcia: adjust_ and release_resources only for non-statically mapped sockets

pcmcia-move-resource-handling-code-only-for-non-statically-mapped-sockets-to-other-file.patch
  pcmcia: move resource handling code only for non-statically mapped sockets to other file

pcmcia-make-rsrc_nonstatic-an-independend-module.patch
  pcmcia: make rsrc_nonstatic an independend module

pcmcia-allocate-resource-database-per-socket.patch
  pcmcia: allocate resource database per-socket

pcmcia-remove-typedef.patch
  pcmcia: remove typedef

pcmcia-grab-lock-in-resource_release.patch
  pcmcia: grab lock in resource_release

knfsd-nfsd_translate_wouldblocks.patch
  knfsd: nfsd_translate_wouldblocks

knfsd-svcrpc-auth_null-fixes.patch
  knfsd: svcrpc: auth_null fixes

knfsd-svcrpc-share-code-duplicated-between-auth_unix-and-auth_null.patch
  knfsd: svcrpc: share code duplicated between auth_unix and auth_null

knfsd-nfsd4-fix-open_downgrade-decode-error.patch
  knfsd: nfsd4: fix open_downgrade decode error.

knfsd-rpcsec_gss-comparing-pointer-to-0-instead-of-null.patch
  knfsd: rpcsec_gss: comparing pointer to 0 instead of NULL

knfsd-nfsd4-fix-fileid-in-readdir-responses.patch
  knfsd: nfsd4: fix fileid in readdir responses

knfsd-nfsd4-use-the-fsid-export-option-when-returning-the-fsid-attribute.patch
  knfsd: nfsd4: use the fsid export option when returning the fsid attribute

knfsd-nfsd4-encode_dirent-cleanup.patch
  knfsd: nfsd4 encode_dirent cleanup

knfsd-nfsd4-encode_dirent-superfluous-assignment.patch
  knfsd: nfsd4: encode_dirent: superfluous assignment

knfsd-nfsd4-encode_dirent-superfluous-local-variables.patch
  knfsd: nfsd4: encode_dirent: superfluous local variables

knfsd-nfsd4-encode_dirent-more-readdir-attribute-encoding-to-new-function.patch
  knfsd: nfsd4: encode_dirent: more readdir attribute encoding to new function

knfsd-nfsd4-encode_dirent-simplify-nfs4_encode_dirent_fattr.patch
  knfsd: nfsd4: encode_dirent: simplify nfs4_encode_dirent_fattr

knfsd-nfsd4-encode_dirent-move-rdattr_error-code-to-new-function.patch
  knfsd: nfsd4: encode_dirent: move rdattr_error code to new function

knfsd-nfsd4-encode_dirent-simplify-error-handling.patch
  knfsd: nfsd4: encode_dirent: simplify error handling

knfsd-nfsd4-encode_dirent-simplify-control-flow.patch
  knfsd: nfsd4: encode_dirent: simplify control flow

knfsd-nfsd4-encode_dirent-fix-dropit-return.patch
  knfsd: nfsd4: encode_dirent: fix dropit return

knfsd-nfsd4-encode_dirent-trivial-cleanup.patch
  knfsd: nfsd4: encode_dirent: trivial cleanup

knfsd-move-nfserr_openmode-checking-from-nfsd_read-write-into-nfs4_preprocess_stateid_op-in-preperation-for-delegation-state.patch
  knfsd: move nfserr_openmode checking from nfsd_read/write into nfs4_preprocess_stateid_op() in preperation for delegation state.

knfsd-check-the-callback-netid-in-gen_callback.patch
  knfsd: check the callback netid in gen_callback.

knfsd-count-the-nfs4_client-structure-usage.patch
  knfsd: count the nfs4_client structure usage

knfsd-preparation-for-delegation-client-callback-probe.patch
  knfsd: preparation for delegation: client callback probe

knfsd-preparation-for-delegation-client-callback-probe-warning-fixes.patch
  knfsd-preparation-for-delegation-client-callback-probe-warning-fixes

knfsd-probe-the-callback-path-upon-a-successful-setclientid_confirm.patch
  knfsd: probe the callback path upon a successful setclientid_confirm

knfsd-check-for-existence-of-file_lock-parameter-inside-of-the-kernel-lock.patch
  knfsd: check for existence of file_lock parameter inside of the kernel lock.

knfsd-get-rid-of-the-special-delegation_stateid_t-use-the-existing-stateid_t.patch
  knfsd: get rid of the special delegation_stateid_t, use the existing stateid_t.

knfsd-add-structures-for-delegation-support.patch
  knfsd: add structures for delegation support

knfsd-allocate-and-initialize-the-delegation-structure.patch
  knfsd: allocate and initialize the delegation structure.

knfsd-find-a-delegation-for-a-file-given-a-stateid.patch
  knfsd: find a delegation for a file given a stateid.

knfsd-add-the-delegation-release-and-free-functions.patch
  knfsd: add the delegation release and free functions

knfsd-changes-to-expire_client.patch
  knfsd: changes to expire_client

knfsd-delay-nfsd_colse-for-delegations-until-reaping.patch
  knfsd: delay nfsd_colse for delegations until reaping

knfsd-delegation-recall-callback-rpc.patch
  knfsd: delegation recall callback rpc.

knfsd-kernel-thread-for-delegation-callback.patch
  knfsd: kernel thread for delegation callback

knfsd-helper-functions-for-deciding-to-grant-a-delegation.patch
  knfsd: helper functions for deciding to grant a delegation.

knfsd-attempt-to-hand-out-a-delegation.patch
  knfsd: attempt to hand out a delegation

knfsd-remove-unnecessary-stateowner-existence-check.patch
  knfsd: remove unnecessary stateowner existence check.

knfsd-check-for-openmode-violations-given-a-delegation-stateid.patch
  knfsd: check for openmode violations given a delegation stateid.

knfsd-add-checking-of-delegation-stateids-to-nfs4_preprocess_stateid_op.patch
  knfsd: add checking of delegation stateids to nfs4_preprocess_stateid_op.

knfsd-add-the-delegreturn-operation.patch
  knfsd: add the DELEGRETURN operation.

knfsd-add-to-the-laundromat-service-for-delegations.patch
  knfsd: add to the laundromat service for delegations.

knfsd-clear-the-recall_lru-of-delegations-at-shutdown.patch
  knfsd: clear the recall_lru of delegations at shutdown

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

kgdb-kill-off-highmem_start_page.patch
  kgdb: kill off highmem_start_page

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

dev-mem-restriction-patch-allow-reads.patch
  dev-mem-restriction-patch: allow reads

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

perfctr-core.patch
  perfctr: core

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

perfctr-sysfs-update-4-4-ppc32.patch
  perfctr sysfs update: ppc32

sched-more-agressive-wake_idle.patch
  sched: more agressive wake_idle()

sched-can_migrate-exception-for-idle-cpus.patch
  sched: can_migrate exception for idle cpus

sched-newidle-fix.patch
  sched: newidle fix

sched-active_load_balance-fixlet.patch
  sched: active_load_balance() fixlet

sched-reset-cache_hot_time.patch
  sched: reset cache_hot_time

schedc-whitespace-mangler.patch
  sched.c whitespace mangler

sched-alter_kthread_prio.patch
  sched: alter_kthread_prio

sched-adjust_timeslice_granularity.patch
  sched: adjust_timeslice_granularity

sched-add_requeue_task.patch
  sched: add_requeue_task

requeue_granularity.patch
  sched: requeue_granularity

sched-remove_interactive_credit.patch
  sched: remove_interactive_credit

sched-use-cached-current-value.patch
  sched: use cached current value

dont-hide-thread_group_leader-from-grep.patch
  don't hide thread_group_leader() from grep

sched-no-need-to-recalculate-rq.patch
  sched: no need to recalculate rq

export-sched_setscheduler-for-kernel-module-use.patch
  export sched_setscheduler() for kernel module use

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

preempt-smp.patch
  improve preemption on SMP

preempt-smp-_raw_read_trylock-bias-fix.patch
  preempt-smp _raw_read_trylock bias fix

preempt-cleanup.patch
  preempt cleanup

preempt-cleanup-fix.patch
  preempt-cleanup-fix

add-lock_need_resched.patch
  add lock_need_resched()

sched-add-cond_resched_softirq.patch
  sched: add cond_resched_softirq()

sched-ext3-fix-scheduling-latencies-in-ext3.patch
  sched: ext3: fix scheduling latencies in ext3

break-latency-in-invalidate_list.patch
  break latency in invalidate_list()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent.patch
  sched: vfs: fix scheduling latencies in prune_dcache() and select_parent()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent-fix.patch
  sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent fix

sched-net-fix-scheduling-latencies-in-netstat.patch
  sched: net: fix scheduling latencies in netstat

sched-net-fix-scheduling-latencies-in-__release_sock.patch
  sched: net: fix scheduling latencies in __release_sock

sched-mm-fix-scheduling-latencies-in-unmap_vmas.patch
  sched: mm: fix scheduling latencies in unmap_vmas()

sched-mm-fix-scheduling-latencies-in-get_user_pages.patch
  sched: mm: fix scheduling latencies in get_user_pages()

sched-mm-fix-scheduling-latencies-in-filemap_sync.patch
  sched: mm: fix scheduling latencies in filemap_sync()

fix-keventd-execution-dependency.patch
  fix keventd execution dependency

sched-fix-scheduling-latencies-in-mttrc.patch
  sched: fix scheduling latencies in mttr.c

sched-fix-scheduling-latencies-in-mttrc-reenables-interrupts.patch
  sched-fix-scheduling-latencies-in-mttrc reenables interrupts

sched-fix-scheduling-latencies-in-vgaconc.patch
  sched: fix scheduling latencies in vgacon.c

sched-fix-scheduling-latencies-for-preempt-kernels.patch
  sched: fix scheduling latencies for !PREEMPT kernels

idle-thread-preemption-fix.patch
  idle thread preemption fix

oprofile-smp_processor_id-fixes.patch
  oprofile smp_processor_id() fixes

fix-smp_processor_id-warning-in-numa_node_id.patch
  Fix smp_processor_id() warning in numa_node_id()

replace-numnodes-with-node_online_map-alpha.patch
  Subject: [RFC PATCH 1/10] Replace 'numnodes' with 'node_online_map' - alpha

replace-numnodes-with-node_online_map-arm.patch
  Subject: [RFC PATCH 2/10] Replace 'numnodes' with 'node_online_map' - arm

replace-numnodes-with-node_online_map-i386.patch
  Subject: [RFC PATCH 3/10] Replace 'numnodes' with 'node_online_map' - i386

replace-numnodes-with-node_online_map-ia64.patch
  Subject: [RFC PATCH 4/10] Replace 'numnodes' with 'node_online_map' - ia64

replace-numnodes-with-node_online_map-m32r.patch
  Subject: [RFC PATCH 5/10] Replace 'numnodes' with 'node_online_map' - m32r

replace-numnodes-with-node_online_map-mips.patch
  Subject: [RFC PATCH 6/10] Replace 'numnodes' with 'node_online_map' - mips

replace-numnodes-with-node_online_map-parisc.patch
  Subject: [RFC PATCH 7/10] Replace 'numnodes' with 'node_online_map' - parisc

replace-numnodes-with-node_online_map-ppc64.patch
  Subject: [RFC PATCH 8/10] Replace 'numnodes' with 'node_online_map' - ppc64

replace-numnodes-with-node_online_map-x86_64.patch
  Subject: [RFC PATCH 9/10] Replace 'numnodes' with 'node_online_map' - x86_64

replace-numnodes-with-node_online_map.patch
  Subject: [RFC PATCH 10/10] Replace 'numnodes' with 'node_online_map' - 	arch-independent

vmtrunc-truncate_count-not-atomic.patch
  vmtrunc: truncate_count not atomic

vmtrunc-restore-unmap_vmas-zap_bytes.patch
  vmtrunc: restore unmap_vmas zap_bytes

vmtrunc-unmap_mapping_range_tree.patch
  vmtrunc: unmap_mapping_range_tree

vmtrunc-unmap_mapping-dropping-i_mmap_lock.patch
  vmtrunc: unmap_mapping dropping i_mmap_lock

vmtrunc-vm_truncate_count-race-caution.patch
  vmtrunc: vm_truncate_count race caution

vmtrunc-bug-if-page_mapped.patch
  vmtrunc: bug if page_mapped

vmtrunc-restart_addr-in-truncate_count.patch
  vmtrunc: restart_addr in truncate_count

remove-the-bkl-by-turning-it-into-a-semaphore.patch
  remove the BKL by turning it into a semaphore

oprofile-preempt-warning-fixes.patch
  oprofile preempt warning fixes

smp_processor_id-commentary.patch
  smp_processor_id() commentary

cpu_down-warning-fix.patch
  cpu_down() warning fix

linux-2.6.8.1-49-rpc_workqueue.patch
  nfs: RPC: Convert rpciod into a work queue for greater flexibility

linux-2.6.8.1-50-rpc_queue_lock.patch
  nfs: RPC: Remove the rpc_queue_lock global spinlock

allow-modular-ide-pnp.patch
  allow modular ide-pnp

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm

ppc64-fix-cpu-hotplug.patch
  ppc64: fix hotplug cpu

serialize-access-to-ide-devices.patch
  serialize access to ide devices

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

assign_irq_vector-section-fix.patch
  assign_irq_vector __init section fix

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

kexec-apic-virt-wire-fix.patch
  kexec: apic-virt-wire fix

kexec-ioapic-virtwire-on-shutdownx86_64.patch
  kexec: ioapic-virtwire-on-shutdown.x86_64

kexec-e820-64bit.patch
  kexec: e820-64bit

kexec-kexec-generic.patch
  kexec: kexec-generic

kexec-ide-spindown-fix.patch
  kexec-ide-spindown-fix

kexec-ifdef-cleanup.patch
  kexec ifdef cleanup

kexec-machine_shutdownx86_64.patch
  kexec: machine_shutdown.x86_64

kexec-kexecx86_64.patch
  kexec: kexec.x86_64

kexec-kexecx86_64-4level-fix.patch
  kexec-kexecx86_64-4level-fix

kexec-machine_shutdowni386.patch
  kexec: machine_shutdown.i386

kexec-kexeci386.patch
  kexec: kexec.i386

kexec-use_mm.patch
  kexec: use_mm

kexec-loading-kernel-from-non-default-offset.patch
  kexec: loading kernel from non-default offset

kexec-loading-kernel-from-non-default-offset-fix.patch
  kdump: fix bss compile error

kexec-enabling-co-existence-of-normal-kexec-kernel-and-panic-kernel.patch
  kexec: nabling co-existence of normal kexec kernel and  panic kernel

kexec-ppc-support.patch
  kexec: ppc support

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-memory-preserving-reboot-using-kexec-fix.patch
  kdump: Fix for boot problems on SMP

kdump-config_discontigmem-fix.patch
  kdump: CONFIG_DISCONTIGMEM fix

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-routines-for-copying-dump-pages-kmap-fiddle.patch
  crashdump-routines-for-copying-dump-pages-kmap-fiddle

crashdump-kmap-build-fix.patch
  crashdump kmap build fix

crashdump-register-snapshotting-before-kexec-boot.patch
  crashdump: register snapshotting before kexec boot

crashdump-elf-format-dump-file-access.patch
  crashdump: ELF format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear/raw format dump file access

crashdump-minor-bug-fixes-to-kexec-crashdump-code.patch
  crashdump: minor bug fixes to kexec crashdump code

crashdump-cleanups-to-the-kexec-based-crashdump-code.patch
  crashdump: cleanups to the kexec based crashdump code

x86-rename-apic_mode_exint.patch
  x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  x86: local apic fix

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-fix-cpuset_get_dentry.patch
  cpusets : fix cpuset_get_dentry()

cpusets-fix-race-in-cpuset_add_file.patch
  cpusets: fix race in cpuset_add_file()

cpusets-remove-more-casts.patch
  cpusets: remove more casts

cpusets-make-config_cpusets-the-default-in-sn2_defconfig.patch
  cpusets: make CONFIG_CPUSETS the default in sn2_defconfig

cpusets-document-proc-status-allowed-fields.patch
  cpusets: document proc status allowed fields

cpusets-dont-export-proc_cpuset_operations.patch
  Cpusets - Dont export proc_cpuset_operations

cpusets-display-allowed-masks-in-proc-status.patch
  cpusets: display allowed masks in proc status

cpusets-simplify-cpus_allowed-setting-in-attach.patch
  cpusets: simplify cpus_allowed setting in attach

cpusets-remove-useless-validation-check.patch
  cpusets: remove useless validation check

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

cpusets-interoperate-with-hotplug-online-maps.patch
  cpusets: interoperate with hotplug online maps

cpusets-alternative-fix-for-possible-race-in.patch
  cpusets: alternative fix for possible race in  cpuset_tasks_read()

cpusets-remove-casts.patch
  cpusets: remove void* typecasts

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

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-unstatic-kswapd.patch
  reiser4: make kswapd() unstatic for debug

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

reiser4-recover-read-performance.patch
  reiser4: recover read performance

reiser4-export-find_get_pages_tag.patch
  reiser4-export-find_get_pages_tag

reiser4-add-missing-context.patch

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

3c59x-reload-eeprom-values-at-rmmod-for-needy-cards.patch
  3c59x: reload EEPROM values at rmmod for needy cards

3c59x-remove-eeprom_reset-for-3c905b.patch
  3c59x: remove EEPROM_RESET for 3c905B

3c59x-add-eeprom_reset-for-3c900-boomerang.patch
  3c59x: Add EEPROM_RESET for 3c900 Boomerang

3c59x-pm-fix.patch
  3c59x: enable power management unconditionally

3c59x-missing-pci_disable_device.patch
  3c59x: missing pci_disable_device

3c59x-use-netdev_priv.patch
  3c59x: use netdev_priv

3c59x-make-use-of-generic_mii_ioctl.patch
  3c59x: Make use of generic_mii_ioctl

3c59x-vortex-select-mii.patch
  3c59x: VORTEX select MII

3c59x-support-more-ethtool_ops.patch
  3c59x: support more ethtool_ops

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

new-serial-flow-control.patch
  new serial flow control

mpsc-driver-patch.patch
  serial: MPSC driver

vm-pageout-throttling.patch
  vm: pageout throttling

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-improve-hash-code-in-linearc.patch
  md: improve 'hash' code in linear.c

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again.patch
  make acpi_bus_register_driver() consistent with pci_register_driver()

enforce-a-gap-between-heap-and-stack.patch
  Enforce a gap between heap and stack

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

for-mm-only-remove-remap_page_range-completely.patch
  vm: for -mm only: remove remap_page_range() completely

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()
  make cancel_rearming_delayed_workqueue static

ipvs-deadlock-fix.patch
  ipvs deadlock fix

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

no-buddy-bitmap-patch-revist-intro-and-includes.patch
  no buddy bitmap patch revist: intro and includes

no-buddy-bitmap-patch-revisit-for-mm-page_allocc.patch
  no buddy bitmap patch revisit: for mm/page_alloc.c

no-buddy-bitmap-patch-revisit-for-mm-page_allocc-fix.patch
  no-buddy-bitmap-patch-revisit-for-mm-page_allocc fix

no-buddy-bitmap-patch-revist-for-ia64.patch
  no buddy bitmap patch revist: for ia64

no-buddy-bitmap-patch-revist-for-ia64-fix.patch
  no-buddy-bitmap-patch-revist-for-ia64 fix

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

fbdev-sis-framebuffer-driver-update-1717.patch
  fbdev: SiS framebuffer driver update 1.7.17

fbdev-sysfs-fix.patch
  fbdev: sysfs fix

pm2fb-module-parameters-and-module-conditional-code.patch
  pm2fb: module parameters and module-conditional code

pm2fb-save-restore-memory-config.patch
  pm2fb: save/restore memory config

pm2fb-use-modedb-in-modules.patch
  pm2fb: use modedb in modules

pm2fb-fix-big-endian-sparc-support.patch
  pm2fb: fix big-endian (Sparc) support

pm2fb-fix-fbi-image-display-on-24-bit-depth-big-endian.patch
  pm2fb: fix fbi image display on 24 bit depth big endian

fix-rom-enable-disable-in-r128-and-radeon-fb-drivers.patch
  fix ROM enable/disable in r128 and radeon fb drivers

fbdev-cleanup-i2c-code-of-rivafb.patch
  fbdev: Cleanup i2c code of rivafb

fbdev-revive-bios-less-booting-for-rage-xl-cards.patch
  fbdev: Revive BIOS-less booting for Rage XL cards

fbdev-revive-global_mode_option.patch
  fbdev: Revive global_mode_option

fbcon-fbdev-add-blanking-notification.patch
  fbcon/fbdev: Add blanking notification

fbcon-fbdev-add-blanking-notification-fix.patch
  fbcon-fbdev-add-blanking-notification-fix

fbdev-check-return-value-of-fb_add_videomode.patch
  fbdev: Check return value of fb_add_videomode

fbdev-do-a-symbol_put-for-each-symbol_get-in-savagefb.patch
  fbdev: Do a symbol_put for each symbol_get in savagefb

fbdev-add-viewsonic-pf775a-to-broken-display-database.patch
  fbdev: Add Viewsonic PF775a to broken display database

fbdev-fix-default-timings-in-vga16fb.patch
  fbdev: Fix default timings in vga16fb

fbdev-reduce-stack-usage-of-intelfb.patch
  fbdev: Reduce stack usage of intelfb

zr36067-driver-correct-jpeg-app-com-markers.patch
  zr36067 driver - correct jpeg app/com markers

zr36067-driver-ppc-be-port.patch
  zr36067 driver - ppc/be port

zr36067-driver-reduce-stack-size-usage.patch
  zr36067 driver - reduce stack size usage

raid6-altivec-support.patch
  raid6: altivec support

remove-export_symbol_novers.patch
  Remove EXPORT_SYMBOL_NOVERS

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

use-mmiowb-in-qla1280c.patch
  use mmiowb in qla1280.c

readpage-vs-invalidate-fix.patch
  readpage-vs-invalidate fix

invalidate_inode_pages-mmap-coherency-fix.patch
  invalidate_inode_pages2() mmap coherency fix

cputime-introduce-cputime.patch
  cputime: introduce cputime

cputime-fix-do_setitimer.patch
  cputime: fix do_setitimer.

cputime-missing-pieces.patch
  cputime: missing pieces.

mm-check_rlimit-oops-on-p-signal.patch
  check_rlimit oops on p->signal

cputime-microsecond-based-cputime-for-s390.patch
  cputime: microsecond based cputime for s390

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

lock-initializer-unifying-batch-2-alpha.patch
  Lock initializer unifying: ALPHA

lock-initializer-unifying-batch-2-ia64.patch
  Lock initializer unifying: IA64

lock-initializer-unifying-batch-2-m32r.patch
  Lock initializer unifying: M32R

lock-initializer-unifying-batch-2-mips.patch
  Lock initializer unifying: MIPS

lock-initializer-unifying-batch-2-misc-drivers.patch
  Lock initializer unifying: Misc drivers

lock-initializer-unifying-batch-2-block-devices.patch
  Lock initializer unifying: Block devices

lock-initializer-unifying-batch-2-drm.patch
  Lock initializer unifying: DRM

lock-initializer-unifying-batch-2-character-devices.patch
  Lock initializer unifying: character devices

lock-initializer-unifying-batch-2-rio.patch
  Lock initializer unifying: RIO

lock-initializer-unifying-batch-2-firewire.patch
  Lock initializer unifying: Firewire

lock-initializer-unifying-batch-2-isdn.patch
  Lock initializer unifying: ISDN

lock-initializer-unifying-batch-2-raid.patch
  Lock initializer unifying: Raid

lock-initializer-unifying-batch-2-media-drivers.patch
  Lock initializer unifying: media drivers

lock-initializer-unifying-batch-2-drivers-serial.patch
  Lock initializer unifying: drivers/serial

lock-initializer-unifying-batch-2-filesystems.patch
  Lock initializer unifying: Filesystems

lock-initializer-unifying-batch-2-video.patch
  Lock initializer unifying: Video

lock-initializer-unifying-batch-2-sound.patch
  Lock initializer unifying: sound

lock-initializer-cleanup-common-headers.patch
  Lock initializer cleanup (common headers)

lock-initializer-cleanup-character-devices.patch
  Lock initializer cleanup (character devices)

lock-initializer-cleanup-core.patch
  Lock initializer cleanup (Core)

moxa-update-status-of-moxa-smartio-driver.patch
  moxa: Update status of Moxa Smartio driver

moxa-remove-ancient-changelog-readmemoxa.patch
  moxa: Remove ancient changelog README.moxa

moxa-remove-readmemoxa-from-documentation-00-index.patch
  moxa: Remove README.moxa from Documentation/00-INDEX

specialix-remove-bouncing-e-mail-address.patch
  specialix: remove bouncing e-mail address

stallion-update-to-documentation-stalliontxt.patch
  stallion: Update to Documentation/stallion.txt

riscom8-update-staus-and-documentation-of-driver.patch
  riscom8: Update staus and documentation of driver

pm-remove-outdated-docs.patch
  From: Pavel Machek <pavel@ucw.cz>
  Subject: pm: remove outdated docs

docs-add-sparse-howto.patch
  From: Pavel Machek <pavel@ucw.cz>
  Subject: docs: add sparse howto

cciss-documentation-update.patch
  cciss: Documentation update

cciss-correct-mailing-list-address-in-source-code.patch
  cciss: Correct mailing list address in source code

cpqarray-correct-mailing-list-address-in-source-code.patch
  cpqarray: Correct mailing list address in source code

sh-remove-x86-specific-help-in-kconfig.patch
  sh: Remove x86-specific help in Kconfig

cyclades-put-readmecycladez-in-documentation-serial.patch
  cyclades: Put README.cycladeZ in Documentation/serial

tipar-document-driver-options.patch
  tipar: Document driver options

tipar-code-cleanup.patch
  tipar: Code cleanup

eth1394-module_parm-conversion.patch
  eth1394 MODULE_PARM conversion

isapnp-module_param-conversion.patch
  isapnp module_param conversion

sr-module_param-conversion.patch
  sr module_param conversion

media-video-module_param-conversion.patch
  media/video module_param conversion

btaudio-module_param-conversion.patch
  btaudio module_param conversion

small-drivers-char-rio-cleanups-fwd.patch
  small drivers/char/rio/ cleanups

small-char-generic_serialc-cleanup-fwd.patch
  small char/generic_serial.c cleanup

debug_bugverbose-for-i386-fwd.patch
  DEBUG_BUGVERBOSE for i386

telephony-ixjc-cleanup-fwd.patch
  telephony/ixj.c cleanup

char-cycladesc-remove-unused-code-fwd.patch
  char/cyclades.c: remove unused code

oss-ac97-quirk-facility.patch
  oss: AC97 quirk facility

oss-ac97-quirk-facility-fix.patch
  oss-ac97-quirk-facility fix

ext3-use-generic_open_file-to-fix-possible-preemption-bugs.patch
  ext3: use generic_open_file to fix possible preemption bugs

bttv-i2cc-make-two-functions-static.patch
  bttv-i2c.c: make two functions static

bttv-riscc-make-some-functions-static.patch
  bttv-risc.c: make some functions static

bttv-help-fix.patch
  bttv help fix

zoran_driverc-make-zoran_num_formats-static.patch
  zoran_driver.c: make zoran_num_formats static

media-video-msp3400c-remove-unused-struct-d1.patch
  media/video/msp3400.c: remove unused struct d1

zoran_devicec-make-zr36057_init_vfe-static.patch
  zoran_device.c: make zr36057_init_vfe static

drivers-media-video-the-easy-cleanups.patch
  drivers/media/video: the easy cleanups

small-ftape-cleanups-fwd.patch
  small ftape cleanups

reiser3-cleanups.patch
  reiser3 cleanups

cdromc-make-several-functions-static.patch
  cdrom.c: make several functions static (fwd)

fs-coda-psdevc-shouldnt-include-lph.patch
  fs/coda/psdev.c shouldn't include lp.h

remove-early_param-tests.patch
  remove early_param test code

MODULE_PARM-allmod.patch
  MODULE_PARM conversions

MODULE_PARM-allyes.patch
  MODULE_PARM conversions

lockd-fix-two-struct-definitions.patch
  lockd: fix two struct definitions

small-mca-cleanups-fwd.patch
  small MCA cleanups

small-drivers-media-radio-cleanups-fwd.patch
  small drivers/media/radio/ cleanups

ifdef-typos-arch_ppc_platforms_prep_setupc.patch
  ifdef typos: arch_ppc_platforms_prep_setup.c

ifdef-typos-arch_ppc_platforms_prep_setupc-another-one.patch
  ifdef typos: arch_ppc_platforms_prep_setup.c -another one

ifdef-typos-arch_ppc_syslib_ppc4xx_dmac.patch
  ifdef typos: arch_ppc_syslib_ppc4xx_dma.c

ifdef-typos-arch_sh_boards_renesas_hs7751rvoip_ioc.patch
  ifdef typos: arch_sh_boards_renesas_hs7751rvoip_io.c

ifdef-typos-drivers_char_ipmi_ipmi_si_intfc.patch
  ifdef typos: drivers_char_ipmi_ipmi_si_intf.c

ifdef-typos-drivers_net_wireless_wavelan_csc.patch
  ifdef typos: drivers_net_wireless_wavelan_cs.c

ifdef-typos-drivers_usb_net_usbnetc.patch
  ifdef typos: drivers_usb_net_usbnet.c

ifdef-typos-mips-au100_usb_device.patch
  ifdef typos mips: AU1[0X]00_USB_DEVICE

ipmi-use-c99-struct-inits.patch
  IPMI: use C99 struct inits.

drm-remove-unused-functions-fwd.patch
  DRM: remove unused functions

floppyc-remove-an-unused-function-fwd.patch
  floppy.c: remove an unused function

media-video-ir-kbd-i2cc-remove-an-unused-function-fwd.patch
  media/video/ir-kbd-i2c.c: remove an unused function

nfs-remove-an-unused-function-fwd.patch
  NFS: remove an unused function

watchdog-machzwdc-remove-unused-functions-fwd.patch
  watchdog/machzwd.c: remove unused functions

video-drivers-remove-unused-functions-fwd.patch
  video drivers: remove unused functions

isdn-b1pcmciac-remove-an-unused-variable-fwd.patch
  ISDN b1pcmcia.c: remove an unused variable

binfmt_scriptc-make-struct-script_format-static-fwd.patch
  binfmt_script.c: make struct script_format static

bioc-make-bio_destructor-static-fwd.patch
  bio.c: make bio_destructor static

devpts-inodec-make-one-struct-static-fwd.patch
  devpts/inode.c: make one struct static

small-proc_fs-cleanups-fwd.patch
  small proc_fs cleanups

kernel-timerc-comment-typo.patch
  Fix kernel/timer.c comment typo

mark-qnx4fs_rw-as-broken-fwd.patch
  mark QNX4FS_RW as BROKEN

oss-remove-unused-functions-fwd.patch
  OSS: remove unused functions

dvb-av7110_hwc-remove-unused-functions-fwd.patch
  DVB av7110_hw.c: remove unused functions

schedc-remove-an-unused-macro-fwd.patch
  sched.c: remove an unused macro

scsi-ahcic-remove-an-unused-function-fwd.patch
  scsi/ahci.c: remove an unused function

scsi-aic7xxx-aic79xx_osmc-remove-an-unused-function-fwd.patch
  scsi/aic7xxx/aic79xx_osm.c: remove an unused function

schedc-remove-an-unused-function-fwd.patch
  sched.c: remove an unused function

prism54-small-prismcompat-cleanup-fwd.patch
  prism54: small prismcompat cleanup

some-parport_pcc-cleanups-fwd.patch
  some parport_pc.c cleanups

fix-typo-and-email-in-saktxt.patch
  fix typo and email in SAK.txt

cris-remove-kernel-20-ifdefs-fwd.patch
  cris: remove kernel 2.0 #ifdef's

afs-afs_voltypes-isnt-always-required-fwd.patch
  AFS: afs_voltypes isn't always required

befs-if-0-two-unused-global-functions-fwd.patch
  befs: #if 0 two unused global functions

binfmt_scriptc-make-em86_format-static.patch
  binfmt_script.c: make em86_format static

remove-unused-include-asm-m68k-adb_mouseh.patch
  remove unused include/asm-m68k/adb_mouse.h

scsi-aic7xxx-remove-two-useless-variables.patch
  scsi/aic7xxx/: remove two useless variables

remove-in_string_c.patch
  remove IN_STRING_C

remove-ct_to_secs-ct_to_usecs.patch
  remove CT_TO_SECS()/CT_TO_USECS()

bttv-driverc-make-some-variables-static.patch
  bttv-driver.c: make some variables static

arch-alpha-kconfig-kill-stale-reference-to-documentation-smptex.patch
  arch/alpha/Kconfig: Kill stale reference to Documentation/smp.tex

init-initramfsc-make-unpack_to_rootfs-static.patch
  init/initramfs.c: make unpack_to_rootfs static

oss-misc-cleanups.patch
  OSS: misc cleanups

inux-269-fs-proc-basec-array-size.patch
  fs/proc/base.c: array size

linux-269-fs-proc-proc_ttyc-avoid-array.patch
  fs/proc/proc_tty.c: avoid array

optimize-prefetch-usage-in-list_for_each_xxx.patch
  optimize prefetch() usage in list_for_each_xxx

signalc-convert-assertion-to-bug_on.patch
  signal.c: convert assertion to BUG_ON()

right-severity-level-for-fatal-message.patch
  Right severity level for fatal message

remove-unused-drivers-char-rio-cdprotoh.patch
  remove unused drivers/char/rio/cdproto.h

remove-unused-drivers-char-rsf16fmih.patch
  remove unused drivers/char/rsf16fmi.h

mtd-added-nec-upd29f064115-support.patch
  mtd: added NEC uPD29F064115 support

waiting-10s-before-mounting-root-filesystem.patch
  retry mounting the root filesystem at boot time



