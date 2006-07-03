Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWGCKEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWGCKEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWGCKEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:04:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15841 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751065AbWGCKEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:04:02 -0400
Date: Mon, 3 Jul 2006 03:03:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm6
Message-Id: <20060703030355.420c7155.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/


- A major update to the e1000 driver.

- 1394 updates



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

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




Changes since 2.6.17-mm5:


 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-cpufreq.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ia64-fixup.patch
 git-infiniband.patch
 git-jfs.patch
 git-kbuild.patch
 git-klibc.patch
 git-hdrinstall2.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-e1000.patch
 git-nfs.patch
 git-ocfs2.patch
 git-pcmcia-fixup.patch
 git-powerpc.patch
 git-sas.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-wireless.patch
 git-xfs.patch
 git-cryptodev.patch

 git trees.

-pi-futex-fix-mm_struct-memory-leak.patch
-irq-use-sa_percpu_irq-not-irq_per_cpu-for-irqactionflags.patch
-irq-warning-message-cleanup.patch
-edac-bug-fix-module-names-quoted-in-sysfs.patch
-pi-futex-futex_wake-lockup-fix.patch
-acpi-identify-which-device-is-not-power-manageable.patch
-pnpacpi-support-shareable-interrupts.patch
-serial-allow-shared-8250_pnp-interrupts.patch
-ib-ipath-name-zero-counter-offsets-so-its-clear.patch
-ib-ipath-update-copyrights-and-other-strings-to.patch
-ib-ipath-share-more-common-code-between-rc-and-uc.patch
-ib-ipath-fix-an-indenting-problem.patch
-ib-ipath-fix-shared-receive-queues-for-rc.patch
-ib-ipath-allow-diags-on-any-unit.patch
-ib-ipath-update-some-comments-and-fix-typos.patch
-ib-ipath-remove-some-duplicate-code.patch
-ib-ipath-dont-allow-resources-to-be-created-with.patch
-ib-ipath-fix-some-memory-leaks-on-failure-paths.patch
-ib-ipath-return-an-error-for-unknown-multicast-gid.patch
-ib-ipath-report-correct-device-identification.patch
-ib-ipath-enforce-device-resource-limits.patch
-ib-ipath-removed-unused-field-ipath_kregvirt-from.patch
-ib-ipath-print-better-debug-info-when-handling.patch
-ib-ipath-enable-freeze-mode-when-shutting-down.patch
-ib-ipath-use-more-appropriate-gfp-flags.patch
-ib-ipath-use-vmalloc-to-allocate-struct.patch
-ib-ipath-memory-management-cleanups.patch
-ib-ipath-reduce-overhead-on-receive-interrupts.patch
-ib-ipath-fixed-bug-9776.patch
-ib-ipath-fix-lost-interrupts-on-ht-400.patch
-ib-ipath-disallow-send-of-invalid-packet-sizes.patch
-ib-ipath-dont-confuse-the-max-message-size-with.patch
-ib-ipath-removed-redundant-statements.patch
-ib-ipath-check-for-valid-lid-and-multicast-lids.patch
-ib-ipath-fixes-to-performance-get-counters-for-ib.patch
-ib-ipath-rc-receive-interrupt-performance-changes.patch
-ib-ipath-purge-sps_lid-and-sps_mlid-arrays.patch
-ib-ipath-drop-the-stats-sysfs-attribute-group.patch
-ib-ipath-support-more-models-of-infinipath-hardware.patch
-ib-ipath-read-write-correct-sizes-through-diag.patch
-ib-ipath-fix-a-bug-that-results-in-addresses-near.patch
-ib-ipath-remove-some-if-0-code-related-to.patch
-ib-ipath-ignore-receive-queue-size-if-srq-is.patch
-ib-ipath-namespace-cleanup-replace-ips-with-ipath.patch
-enhancing-accessibility-of-lxdialog.patch
-mmc-check-sdhci-base-clock.patch
-mmc-print-device-id.patch
-mmc-support-for-multiple-voltages.patch
-mmc-fix-timeout-loops-in-sdhci.patch
-mmc-fix-sdhci-reset-timeout.patch
-mmc-proper-timeout-handling.patch
-mmc-correct-register-order.patch
-mmc-fix-interrupt-handling.patch
-mmc-fix-sdhci-pio-routines.patch
-mmc-avoid-sdhci-dma-boundaries.patch
-mmc-test-for-invalid-block-size.patch
-mmc-check-only-relevant-inhibit-bits.patch
-mmc-check-controller-version.patch
-mmc-reset-sdhci-controller-early.patch
-mmc-more-dma-capabilities-tests.patch
-mmc-support-controller-specific-quirks.patch
-mmc-version-bump-sdhci.patch
-mmc-add-sdhci-controller-ids.patch
-mmc-quirk-for-broken-reset.patch
-mmc-force-dma-on-some-controllers.patch
-mmc-remove-duplicate-error-message.patch
-typo-in-drivers-net-e1000-e1000_hwc.patch
-fix-implicit-declaration-on-cell.patch
-xfs-pass-inode-to-xfs_ioc_space.patch
-smp-alternatives-skip-with-up-kernels.patch
-uml-make-copy__user-atomic.patch
-uml-fix-not_dead_yet-when-directory-is-in-bad-state.patch
-uml-rename-and-improve-actually_do_remove.patch
-binfmt_elf-fix-checks-for-bad-address.patch
-binfmt_elf-fix-checks-for-bad-address-fix.patch
-ufs-truncate-should-allocate-block-for-last-byte.patch
-fix-is_err-threshold-value.patch
-rtc-class-driver-for-samsung-s3c-series-soc.patch
-rtc-class-driver-for-samsung-s3c-series-soc-tidy.patch
-hotcpu_notifier-fixes.patch
-add-___rodata-sections-to-asm-generic-sectionsh.patch
-add-___rodata-sections-to-asm-generic-sectionsh-fix.patch
-s390-put-sys_call_table-into-rodata-section-and-write-protect-it.patch
-reiserfs-update-ctime-and-mtime-on-expanding-truncate.patch
-kernel-doc-consistent-text-man-mode-output.patch
-fix-problem-with-atapi-dma-on-it8212-in-linux.patch
-kernel-doc-make-man-text-mode-function-output-same.patch
-drivers-block-nbdc-compile-fix.patch
-pnp-suppress-request_irq-warning.patch

 Merged into mainline or a subsystem tree.

+time-initialisation-fix.patch
+genirq-ia64-cleanup.patch
+lockdep-special-s390-print_symbol-version.patch
+bcm43xx-netlink-deadlock-fix.patch
+uml-build-fix.patch
+pnpacpi-support-shareable-interrupts.patch
+serial-allow-shared-8250_pnp-interrupts.patch
+zvc-zone_reclaim-leave-1%-of-unmapped-pagecache-pages-for-file-i-o.patch
+binfmt_elf-fix-checks-for-bad-address.patch
+kernel-doc-maintainers.patch
+add-mike-isely-as-pvrusb2-maintainer.patch
+fbdev-add-framebuffer-and-display-update-module-support.patch
+vt-decrement-ref-count-of-the-vt-backend-on-deallocation.patch
+make-more-file_operation-structs-static.patch
+sparc-i8042-build-fix.patch

 2.6.18-rc1 queue

-lockdep-core-improve-bug-messages.patch
-lockdep-core-add-set_class_and_name.patch
-lockdep-core-add-set_class_and_name-fix.patch

 Folded into lockdep-core.patch

+lockdep-allow-read_lock-recursion-of-same-class.patch

 Lockdep feature.

-lockdep-annotate-blkdev-nesting-fix.patch

 Folded into lockdep-annotate-blkdev-nesting.patch

-lockdep-annotate-sk_locks-fix.patch

 Folded into lockdep-annotate-sk_locks.patch

+lockdep-annotate-hostap-netdev-xmit_lock.patch

 Lockdep false-positive avoidance.

+sparc-resource-warning-fixes.patch

 sparc warning fix

+git-ia64-fixup.patch

 Fix rejects in git-ia64.patch

+ieee1394-sbp2-enable-auto-spin-up-for-maxtor-disks.patch
+ieee1394-fix-calculation-of-csr-expire.patch
+ieee1394-fix-cosmetic-problem-in-speed-probe.patch
+ieee1394-skip-dummy-loop-in-build_speed_map.patch
+ieee1394-replace-__inline__-by-inline.patch
+ieee1394-coding-style-and-comment-fixes-in-midlayer.patch
+ieee1394-update-include-directives-in-midlayer-header.patch
+ieee1394-remove-redundant-code-from-ieee1394_hotplugh.patch
+ieee1394-remove-unused-macros-hpsb_panic-and.patch
+ieee1394-clean-up-declarations-of-hpsb__config_rom.patch
+ieee1394-dv1394-sem2mutex-conversion.patch
+ieee1394-raw1394-remove-redundant-counting-semaphore.patch
+ieee1394-nodemgr-remove-unnecessary-includes.patch
+ieee1394-nodemgr-do-not-spawn-kernel_thread-for-sysfs.patch
+ieee1394-nodemgr-make-module-parameter-ignore_drivers.patch
+ieee1394-nodemgr-switch-to-kthread-api-replace-reset.patch
+ieee1394-nodemgr-convert-nodemgr_serialize-semaphore.patch
+ieee1394-fix-kerneldoc-of-hpsb_alloc_host.patch
+ieee1394-shrink-tlabel-pools-remove-tpool-semaphores.patch

 1394 updates

-revert-sparc-build-breakage.patch

 Unneeded.

+git-e1000-fixup.patch

 Fix reject in git-e1000.patch

+e1000-irq-naming-update.patch

 Update e1000 to the new IRQ naming scheme.

+net-adduse-poison-defines.patch
+atm-adduse-poison-defines.patch

 net cleanups

+revert-gregkh-pci-msi-drop-pci_msi_quirk.patch
+revert-gregkh-pci-msi-stop-inheriting-bus-flags-and-check-root-chipset-bus-flags-instead.patch
+revert-gregkh-pci-msi-factorize-common-msi-detection-code-from-pci_enable_msi-and-msix.patch
+revert-gregkh-pci-msi-blacklist-pci-e-chipsets-depending-on-hypertransport-msi-capabality.patch
+revert-gregkh-pci-msi-rename-pci_cap_id_ht_irqconf-into-pci_cap_id_ht.patch
+revert-gregkh-pci-msi-merge-existing-msi-disabling-quirks.patch

 Revert some bad patches from the PCI tree.

+git-scsi-misc-fixup.patch

 Fix reject due to git-scsi-misc.patch

-make-drivers-scsi-aic7xxx-aic79xx_coreahd_set_tags-static.patch

 Dropped (accidentally, I think).

-my-name-is-ingo-molnar-you-killed-my-make-allyesconfig-prepare-to-die.patch

 Ditto.

+x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions.patch
+x86_64-mm-add-abilty-to-enable-disable-nmi-watchdog-from-sysfs.patch
+x86_64-mm-add-abilty-to-enable-disable-nmi-watchdog-from-procfs-update.patch
+x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix.patch
+x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix-fix.patch
+x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86_64-fix.patch
+x86_64-mm-allow-users-to-force-a-panic-on-nmi.patch
+x86_64-mm-x86-clean-up-nmi-panic-messages.patch
+x86_64-mm-x86-nmi-fix.patch
+x86_64-mm-x86-nmi-fix-2.patch
+x86_64-mm-make-functions-static.patch
+x86_64-mm-kdump-x86_64-nmi-event-notification-fix.patch
+x86_64-mm-kdump-i386-nmi-event-notification-fix.patch
+x86_64-mm-i386-enable-nmi-wdog.patch
+x86_64-mm-add-nmi-watchdog-support-for-new-intel-cpus.patch

 x86_64 tree updates

+mm-x86_64-mm-init-rdtscp-warning-fix.patch

 Fix it.

+sleazy-fpu-feature-x86_64-support.patch
+sleazy-fpu-feature-x86_64-support-fix.patch
+sleazy-fpu-feature-i386-support.patch

 Speed up floating point handling a bit.

+x86_64-fix-calgary-copyright-statements-per-ibm-guidelines.patch
+x86_64-add-a-maintainers-entry-for-calgary.patch

 x86_64 updates.

-mm-tracking-shared-dirty-pages-update.patch

 Folded into mm-tracking-shared-dirty-pages.patch

-mm-msync-cleanup-fix.patch

 Folded into mm-msync-cleanup.patch

+x86-re-enable-generic-numa.patch

 Permit x86-on-NUMA

 fix-boot-on-efi-32-bit-machines.patch

+ia64-kprobe-invalidate-icache-of-jump-buffer.patch

 ia64 kprobes fix

-apple-motion-sensor-driver-update.patch
-apple-motion-sensor-driver-update-2.patch

 Folded into apple-motion-sensor-driver.patch

+fat-cleanup-fat_get_blocks.patch
+make-valid_mmap_phys_addr_range-take-a-pfn.patch
+valid_mmap_phys_addr_range-cleanup.patch
+char-rtc-handle-memory-mapped-chips-properly.patch
+char-rtc-handle-memory-mapped-chips-properly-cleanup.patch
+inode_diet-replace-inodeugeneric_ip-with-inodei_private.patch
+inode-diet-move-i_pipe-into-a-union.patch
+inode-diet-move-i_bdev-into-a-union.patch
+inode-diet-move-i_cdev-into-a-union.patch
+inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default.patch
+inode-diet-fix-size-of-i_blkbits-i_version-and-i_dnotify_mask.patch
+reiserfsfix-journaling-issue-regarding-fsync.patch
+x86-microcode-microcode-driver-cleanup.patch
+x86-microcode-microcode-driver-cleanup-tidy.patch
+x86-microcode-using-request_firmware-to-pull-microcode.patch
+x86-microcode-add-sysfs-and-hotplug-support.patch
+x86-microcode-add-sysfs-and-hotplug-support-fix.patch

 Misc updates.

-reiserfs-reorganize-bitmap-loading-functions-fix.patch
-reiserfs-reorganize-bitmap-loading-functions-fix2.patch

 Folded into reiserfs-reorganize-bitmap-loading-functions.patch

-reiserfs-on-demand-bitmap-loading-fix.patch

 Folded into reiserfs-on-demand-bitmap-loading.patch

-per-task-delay-accounting-setup-fix-1.patch
-per-task-delay-accounting-setup-fix-2.patch

 Folded into per-task-delay-accounting-setup.patch

-per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection-fix-1.patch

 Folded into per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection.patch

-per-task-delay-accounting-cpu-delay-collection-via-schedstats-fix-1.patch

 Folded into per-task-delay-accounting-cpu-delay-collection-via-schedstats.patch

-per-task-delay-accounting-taskstats-interface-fix-1.patch
-per-task-delay-accounting-taskstats-interface-fix-2.patch
-per-task-delay-accounting-taskstats-interface-tidy.patch

 Folded into per-task-delay-accounting-taskstats-interface.patch

-per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays-warning-fix.patch

 Folded into per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays.patch

-delay-accounting-taskstats-interface-send-tgid-once-fixes.patch
-delay-accounting-taskstats-interface-send-tgid-once-locking.patch

 Folded into delay-accounting-taskstats-interface-send-tgid-once.patch

-ecryptfs-fs-makefile-and-fs-kconfig-remove-ecrypt_debug-from-fs-kconfig.patch

 Folded into ecryptfs-fs-makefile-and-fs-kconfig.patch

-ecryptfs-main-module-functions-uint16_t-u16.patch

 Folded into ecryptfs-main-module-functions.patch

-ecryptfs-header-declarations-update.patch
-ecryptfs-header-declarations-update-convert-signed-data-types-to-unsigned-data-types.patch
-ecryptfs-header-declarations-remove-unnecessary-ifndefs.patch

 Folded into ecryptfs-header-declarations.patch

-ecryptfs-superblock-operations-ecryptfs_statfs-api-change.patch

 Folded into ecryptfs-superblock-operations.patch

-ecryptfs-file-operations-remove-null-==-syntax.patch
-ecryptfs-file-operations-remove-extraneous-read-of-inode-size-from-header.patch
-ecryptfs-file-operations-fix.patch
-ecryptfs-file-operations-fix-premature-release-of-file_info-memory.patch

 Folded into ecryptfs-file-operations.patch

-mark-address_space_operations-const-vs-ecryptfs-mmap-operations.patch

 Folded into ecryptfs-mmap-operations.patch

-ecryptfs-crypto-functions-fix-filesize-on-hard-link-creation.patch

 Folded into ecryptfs-crypto-functions.patch

-ecryptfs-more-elegant-aes-key-size-manipulation-tidy.patch

 Folded into ecryptfs-more-elegant-aes-key-size-manipulation.patch

-ecryptfs-validate-packet-length-prior-to-parsing-add-comments-fix.patch

 Folded into ecryptfs-validate-packet-length-prior-to-parsing-add-comments.patch

+inode-diet-move-i_pipe-into-a-union-ecryptfs.patch
+inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-ecryptfs.patch

 Fix ecryptfs for the inode-shrinkage patches.

-namespaces-utsname-switch-to-using-uts-namespaces-alpha-fix.patch
-namespaces-utsname-switch-to-using-uts-namespaces-cleanup.patch

 Folded into namespaces-utsname-switch-to-using-uts-namespaces.patch

-namespaces-utsname-use-init_utsname-when-appropriate-cifs-update.patch

 Folded into namespaces-utsname-use-init_utsname-when-appropriate.patch

-namespaces-utsname-implement-utsname-namespaces-export.patch
-namespaces-utsname-implement-utsname-namespaces-dont-include-compileh.patch
-namespaces-utsname-implement-utsname-namespaces-remove-unused-exit_utsname.patch

 Folded into namespaces-utsname-implement-utsname-namespaces.patch

-namespaces-utsname-sysctl-hack-cleanup.patch
-namespaces-utsname-sysctl-hack-cleanup-2.patch
-namespaces-utsname-sysctl-hack-cleanup-2-fix.patch

 Folded into namespaces-utsname-sysctl-hack.patch

-namespaces-utsname-implement-clone_newuts-flag-tidy.patch

 Folded into namespaces-utsname-implement-clone_newuts-flag.patch

-ipc-namespace-core-fix.patch
-ipc-namespace-core-unshare-fix.patch

 Folded into ipc-namespace-core.patch

-ipc-namespace-utils-compilation-fix.patch

 Folded into ipc-namespace-utils.patch

-task-watchers-task-watchers-tidy.patch

 Folded into task-watchers-task-watchers.patch

-task-watchers-add-support-for-per-task-watchers-warning-fix.patch

 Folded into task-watchers-add-support-for-per-task-watchers.patch

-task-watchers-register-semundo-task-watcher-cleanup.patch

 Folded into task-watchers-register-semundo-task-watcher.patch

-readahead-kconfig-option-readahead_allow_overheads.patch

 Folded into readahead-kconfig-options.patch

-readahead-state-based-method-routines-no-ra_flag_eof-on-single-page-file.patch

 Folded into readahead-state-based-method-routines.patch

-readahead-state-based-method-readahead-state-based-method-stand-alone-size-limit-code.patch
-readahead-state-based-method-aging-accounting-readahead-kconfig-option-readahead_smooth_aging.patch

 Folded into readahead-state-based-method.patch

-readahead-context-based-method-apply-stream_shift-size-limits-to-contexta-method.patch
-readahead-context-based-method-fix-remain-counting.patch
-readahead-context-based-method-slow-start.patch

 Folded into readahead-context-based-method.patch

-readahead-initial-method-guiding-sizes-aggressive-initial-sizes.patch

 Folded into readahead-initial-method-guiding-sizes.patch

-readahead-backward-prefetching-method-add-use-case-comment.patch

 Folded into readahead-backward-prefetching-method.patch

-readahead-call-scheme-fix-fastcall.patch
-readahead-call-scheme-no-fastcall-for-readahead_cache_hit.patch
-readahead-call-scheme-no-fastcall-for-readahead_cache_hit-kconfig-option-readahead_hit_feedback.patch

 Folded into readahead-call-scheme.patch

+inode_diet-replace-inodeugeneric_ip-with-inodei_private-reiser4.patch
+inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-reiser4.patch

 Fix reiser4 for the inode-diet patches

+vt-remove-vt-specific-declarations-and-definitions-from-fix.patch

 Fix vt-remove-vt-specific-declarations-and-definitions-from.patch

+tty-remove-include-of-screen_infoh-from-ttyh-fix.patch
+tty-remove-include-of-screen_infoh-from-ttyh-fix-fix.patch

 Fix tty-remove-include-of-screen_infoh-from-ttyh.patch

+md-oops-workaround.patch

 Work around an oops in MD. (triggered by the now-hopefully-fixed barrier bug).

-statistics-infrastructure-update-1.patch

-statistics-infrastructure-update-2.patch
-statistics-infrastructure-update-3.patch
-statistics-infrastructure-update-4.patch
-statistics-infrastructure-update-5.patch
-statistics-infrastructure-update-6.patch
-statistics-infrastructure-update-7.patch
-statistics-infrastructure-update-8.patch

 Folded into Folded into statistics-infrastructure.patch

-genirq-add-chip-eoi-fastack-fasteoi-x86_64.patch

 Folded into genirq-convert-the-x86_64-architecture-to-irq-chips.patch

-genirq-convert-the-i386-architecture-to-irq-chips-fix-2.patch
-genirq-add-chip-eoi-fastack-fasteoi-x86.patch

 Folded into genirq-convert-the-i386-architecture-to-irq-chips.patch

-genirq-x86_64-irq-reenable-migrating-irqs-to-other-cpus-fix.patch

 Folded into genirq-x86_64-irq-reenable-migrating-irqs-to-other-cpus.patch

-genirq-msi-simplify-msi-enable-and-disable-fix.patch

 Folded into genirq-msi-simplify-msi-enable-and-disable.patch

-genirq-ia64-irq-dynamic-irq-support-fix.patch

 Folded into genirq-ia64-irq-dynamic-irq-support.patch

-genirq-i386-irq-dynamic-irq-support-fix.patch

 Folded into genirq-i386-irq-dynamic-irq-support.patch

+genirq-msi-only-build-msi-apicc-on-ia64-fix.patch

 Folded into genirq-msi-only-build-msi-apicc-on-ia64.patch

-genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector-fix.patch
-genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector-fix-tidies.patch

 Folded into genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector.patch

-srcu-rcu-variant-permitting-read-side-blocking-fixes.patch

 Folded into srcu-rcu-variant-permitting-read-side-blocking.patch

-srcu-add-srcu-operations-to-rcutorture-fix.patch
-srcu-add-srcu-operations-to-rcutorture-tidy-2.patch

 Folded into srcu-add-srcu-operations-to-rcutorture.patch

-srcu-2-add-srcu-operations-to-rcutorture-fix.patch

 Folded into srcu-2-add-srcu-operations-to-rcutorture.patch

-export_unused_symbolgpl-unregister_die_notifier.patch

 Dropped.



All 704 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/patch-list


