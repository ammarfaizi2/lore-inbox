Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWF2IhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWF2IhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 04:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWF2IhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 04:37:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34527 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751298AbWF2Ig7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 04:36:59 -0400
Date: Thu, 29 Jun 2006 01:36:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm4
Message-Id: <20060629013643.4b47e8bd.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm4/


- The RAID patches have been dropped due to testing failures in -mm3.

- The SCSI Attached Storage tree (git-sas.patch) has been restored.


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



Changes since 2.6.17-mm3:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-infiniband.patch
 git-jfs.patch
 git-klibc.patch
 git-hdrinstall2.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ocfs2.patch
 git-parisc.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-sas.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-supertrak-fixup.patch
 git-wireless.patch
 git-cryptodev.patch

 git trees.

-patch-kernel-acct-fix-function-definition.patch
-zlib-inflate-fix-function-definitions.patch
-pm_trace-is-bust.patch
-acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces.patch
-catch-notification-of-memory-add-event-of-acpi-via-container-driver-register-start-func-for-memory-device.patch
-catch-notification-of-memory-add-event-of-acpi-via-container-driveravoid-redundant-call-add_memory.patch
-acpi-update-asus_acpi-driver-registration-fix.patch
-kevent-add-new-uevent.patch
-acpi-dock-driver.patch
-acpiphp-use-new-dock-driver.patch
-acpiphp-prevent-duplicate-slot-numbers-when-no-_sun.patch
-acpi-c-states-accounting-of-sleep-states.patch
-acpi-c-states-bm_activity-improvements.patch
-acpi-c-states-only-demote-on-current-bus-mastering-activity.patch
-libata-reduce-timeouts.patch
-ata-add-some-nvidia-chipset-ids.patch
-make-drivers-scsi-pata_pcmciacpcmcia_remove_one-static.patch
-libatah-needs-scatterlisth.patch
-make-drivers-scsi-pata_it821xcit821x_passthru_dev_select-static.patch
-fix-phy-id-for-lxt971a-lxt972a.patch
-natsemi-add-quirks-for-aculab-e1-t1-pmxc-cpci-carrier-cards.patch
-powerpc-adding-the-use-of-the-firmware-soft-reset-nmi-to-kdump.patch
-powerpc-kcofnig-warning-fix.patch
-pgdat-allocation-for-new-node-add-specify-node-id.patch
-pgdat-allocation-for-new-node-add-get-node-id-by-acpi.patch
-pgdat-allocation-for-new-node-add-generic-alloc-node_data.patch
-pgdat-allocation-for-new-node-add-refresh-node_data.patch
-pgdat-allocation-for-new-node-add-export-kswapd-start-func.patch
-pgdat-allocation-for-new-node-add-export-kswapd-start-func-fix.patch
-pgdat-allocation-for-new-node-add-call-pgdat-allocation.patch
-register-hot-added-memory-to-iomem-resource.patch
-catch-valid-mem-range-at-onlining-memory.patch
-fix-compile-error-undefined-reference-for-sparc64.patch
-register-sysfs-file-for-hotpluged-new-node.patch
-pgdat-allocation-and-update-for-ia64-of-memory-hotplughold-pgdat-address-at-system-running.patch
-pgdat-allocation-and-update-for-ia64-of-memory-hotplug-update-pgdat-address-array.patch
-pgdat-allocation-and-update-for-ia64-of-memory-hotplugallocate-pgdat-and-per-node-data.patch
-node-hotplug-register-cpu-remove-node-struct.patch
-node-hotplug-register-cpu-remove-node-struct-alpha-fix.patch
-selinux-inherit-proc-self-attr-keycreate-across-fork.patch
-x86-cpu_init-avoid-gfp_kernel-allocation-while-atomic.patch
-x86-increase-interrupt-vector-range.patch
-x86-constify-some-parts-of-arch-i386-kernel-cpu.patch
-i386-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86.patch
-i386-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86-warning-fix.patch
-i386-use-c-code-for-current_thread_info.patch
-fix-broken-vm86-interrupt-signal-handling.patch
-fix-subarchitecture-breakage-with-config_sched_smt.patch
-voyager-fix-compile-after-setup-rework.patch
-vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma.patch
-vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-tidy.patch
-vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-arch_vma_name-fix.patch
-vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386.patch
-vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386-2.patch
-vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386-2-revert-maxmem-change.patch
-add-poisonh-and-patch-primary-users.patch
-update-2-drivers-for-poisonh.patch
-poison-add-use-more-constants.patch
-fs-bufferc-possible-cleanups.patch
-mark-address_space_operations-const.patch
-add-export_unused_symbol-and-export_unused_symbol_gpl.patch
-add-export_unused_symbol-and-export_unused_symbol_gpl-default.patch
-spin-rwlock-init-cleanups.patch
-load_module-cleanup.patch
-rtc-add-rtc-rs5c348-driver.patch
-remove-gratuitous-inclusion-of-linux-configh-from.patch
-generic_file_buffered_write-deadlock-on-vectored-write.patch
-remove-tty_dont_flip.patch
-add-receive_room-flow-control-to-flush_to_ldisc.patch
-add-receive_room-flow-control-to-flush_to_ldisc-tidy.patch
-rtc-add-a-comment-for-enoioctlcmd-in-ds1553_rtc_ioctl.patch
-ufs-ufs_read_inode-cleanup.patch
-tty-fix-tcsbrk-comment.patch
-fix-kernel-doc-in-kernel-dir.patch
-remove-active-field-from-tty-buffer-structure.patch
-rcutorture-catchup-doc-fixes-for-idle-hz-tests.patch
-rcutorture-add-ops-vector-and-classic-rcu-ops.patch
-rcutorture-add-call_rcu_bh-operations.patch
-ipmi-use-schedule-in-kthread.patch
-stallion-clean-up.patch
-rtc-fix-idr-locking.patch
-cpu-hotplug-revert-init-patch-submitted-for-2617.patch
-cpu-hotplug-revert-initdata-patch-submitted-for-2617.patch
-cpu-hotplug-make-register_cpu_notifier-init-time-only.patch
-cpu-hotplug-make-register_cpu_notifier-init-time-only-fix.patch
-cpu-hotplug-make-register_cpu_notifier-init-time-only-fix-fix.patch
-cpu-hotplug-make-cpu_notifier-related-notifier-blocks-__cpuinit-only.patch
-cpu-hotplug-make-cpu_notifier-related-notifier-blocks-__cpuinit-only-fix.patch
-cpu-hotplug-make-cpu_notifier-related-notifier-calls-__cpuinit-only.patch
-cpu-hotplug-make-cpu_notifier-related-notifier-calls-__cpuinit-only-fix.patch
-cpu-hotplug-make-cpu_notifier-related-notifier-calls-__cpuinit-only-fix-fix.patch
-cpu-hotplug-add-hotplug-versions-of-cpu_notifier.patch
-cpu-hotplug-use-hotplug-version-of-cpu-notifier-in-appropriate-places.patch
-chardev-gpio-for-scx200-pc-8736x-whitespace.patch
-chardev-gpio-for-scx200-pc-8736x-modernize.patch
-chardev-gpio-for-scx200-pc-8736x-add-platforn_device.patch
-chardev-gpio-for-scx200-pc-8736x-device-minor.patch
-chardev-gpio-for-scx200-pc-8736x-put-gpio_dump.patch
-chardev-gpio-for-scx200-pc-8736x-add-v-command.patch
-chardev-gpio-for-scx200-pc-8736x-refactor-scx200_probe.patch
-chardev-gpio-for-scx200-pc-8736x-add-gpio-ops.patch
-chardev-gpio-for-scx200-pc-8736x-dispatch.patch
-chardev-gpio-for-scx200-pc-8736x-add-empty.patch
-chardev-gpio-for-scx200-pc-8736x-migrate-file-ops.patch
-chardev-gpio-for-scx200-pc-8736x-migrate-gpio_dump.patch
-chardev-gpio-for-scx200-pc-8736x-add-new-pc8736x_gpio.patch
-chardev-gpio-for-scx200-pc-8736x-add-platform_device.patch
-chardev-gpio-for-scx200-pc-8736x-use-dev_dbg.patch
-chardev-gpio-for-scx200-pc-8736x-fix-gpio_current.patch
-chardev-gpio-for-scx200-pc-8736x-replace-spinlocks.patch
-chardev-gpio-for-scx200-pc-8736x-replace-spinlocks-include-linux-ioh.patch
-chardev-gpio-for-scx200-pc-8736x-display-pin.patch
-chardev-gpio-for-scx200-pc-8736x-add-proper.patch
-sched-fix-smt-nice-lock-contention-and-optimization.patch
-sched-fix-smt-nice-lock-contention-and-optimization-tidy.patch
-sched-comment-bitmap-size-accounting.patch
-sched-fix-interactive-ceiling-code.patch
-unnecessary-long-index-i-in-sched.patch
-sched-cpu-hotplug-race-vs-set_cpus_allowed.patch
-sched-implement-smpnice.patch
-sched-protect-calculation-of-max_pull-from-integer-wrap.patch
-sched-store-weighted-load-on-up.patch
-sched-add-discrete-weighted-cpu-load-function.patch
-sched-prevent-high-load-weight-tasks-suppressing-balancing.patch
-sched-improve-stability-of-smpnice-load-balancing.patch
-sched-improve-smpnice-load-balancing-when-load-per-task.patch
-smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing.patch
-smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing-fix.patch
-smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing-fix-2patch.patch
-sched-modify-move_tasks-to-improve-load-balancing-outcomes.patch
-sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
-sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks-fix-2.patch
-sched_domain-handle-kmalloc-failure.patch
-sched_domain-handle-kmalloc-failure-fix.patch
-sched_domain-dont-use-gfp_atomic.patch
-sched_domain-use-kmalloc_node.patch
-sched_domain-allocate-sched_group-structures-dynamically.patch
-sched-mc-smt-power-savings-sched-policy.patch
-sched-mc-smt-power-savings-sched-policy-sparc64-build-fix.patch
-sched-uninline-task_rq_lock.patch
-bug-if-setscheduler-is-called-from-interrupt-context.patch
-pi-futex-futex-code-cleanups.patch
-pi-futex-robust-futex-docs-fix.patch
-pi-futex-introduce-debug_check_no_locks_freed.patch
-pi-futex-introduce-warn_on_smp.patch
-pi-futex-add-plist-implementation.patch
-pi-futex-scheduler-support-for-pi.patch
-pi-futex-rt-mutex-core.patch
-pi-futex-rt-mutex-docs.patch
-pi-futex-rt-mutex-docs-update.patch
-pi-futex-rt-mutex-debug.patch
-pi-futex-rt-mutex-tester.patch
-pi-futex-rt-mutex-tester-fix.patch
-pi-futex-rt-mutex-futex-api.patch
-pi-futex-futex_lock_pi-futex_unlock_pi-support.patch
-pi-futex-futex_lock_pi-futex_unlock_pi-support-fix.patch
-fix-rt-mutex-defaults-and-dependencies.patch
-drop-tasklist-lock-in-do_sched_setscheduler.patch
-rtmutex-modify-rtmutex-tester-to-test-the-setscheduler.patch
-rtmutex-propagate-priority-settings-into-pi-lock-chains.patch
-rtmutex-propagate-priority-settings-into-pi-lock-chains-fix.patch
-futex_requeue-optimization.patch
-old-ide-fix-sata-detection-for-cabling.patch
-ide-clean-up-siimage.patch
-ide-sc1200-debug-printk.patch
-ide-fix-error-handling-for-drives-which-clear-the-fifo-on-error.patch
-ide-housekeeping-on-ide-drivers.patch
-ide-clean-up-pdc202xx_old-so-its-more-readable-done-so-i-could-work-on-libata-ports.patch
-ide-set-err_stops_fifo-for-newer-promise-as-well.patch
-remove-redundant-null-checks-before-free-in-fs.patch
-remove-redundant-null-checks-before-free-in-kernel.patch
-remove-redundant-null-checks-before-free-in-drivers.patch
-drivers-char-ipmi-ipmi_msghandlerc-make-proc_ipmi_root-static.patch
-drivers-message-i2o-iopc-unexport-i2o_msg_nop.patch

 Merged into mainline or a subsystem tree.

+fix-sgivwfb-compile.patch
+generic_file_buffered_write-handle-zero-length-iovec-segments-stable.patch
+solve-config-broken-undefined-reference-to-online_page.patch
+sparc-register_cpu-build-fix.patch

 Hotfixes for mainline.

+git-acpi-fixup.patch

 Fix reject due to git-acpi.patch

+cpu_relax-use-in-acpi-lock-fix.patch
+acpi_srat-needs-acpi.patch
+acpi-identify-which-device-is-not-power-manageable.patch

 ACPI things.

+git-agpgart-fixup.patch

 Fix reject due to git-agpgart.patch.

+gregkh-driver-device-groups.patch
+gregkh-driver-device-class-parent.patch
+gregkh-driver-device-class-attr.patch

 Driver tree updates.

+videocodec-make-1-bit-fields-unsigned.patch

 DVB fixlet.

-input-keyboard_tasklet-dont-touch-leds-of-already-grabed-device.patch

 Dropped.

+revert-input-atkbd-fix-hangeul-hanja-keys.patch

 Revert buggy patch which broek AT keyboardsw (this reversion was messy).

+mmc-check-sdhci-base-clock.patch
+mmc-print-device-id.patch
+mmc-support-for-multiple-voltages.patch
+mmc-fix-timeout-loops-in-sdhci.patch
+mmc-fix-sdhci-reset-timeout.patch
+mmc-proper-timeout-handling.patch
+mmc-correct-register-order.patch
+mmc-fix-interrupt-handling.patch
+mmc-fix-sdhci-pio-routines.patch
+mmc-avoid-sdhci-dma-boundaries.patch
+mmc-test-for-invalid-block-size.patch
+mmc-check-only-relevant-inhibit-bits.patch
+mmc-check-controller-version.patch
+mmc-reset-sdhci-controller-early.patch
+mmc-more-dma-capabilities-tests.patch
+mmc-support-controller-specific-quirks.patch
+mmc-version-bump-sdhci.patch
+mmc-add-sdhci-controller-ids.patch
+mmc-quirk-for-broken-reset.patch
+mmc-force-dma-on-some-controllers.patch
+mmc-remove-duplicate-error-message.patch

 Secure Digital MMC driver updates.

+fs-jffs2-make-2-functions-static.patch
+mtd-fix-all-kernel-doc-warnings.patch
+mtd-kernel-doc-fixes-additions.patch

 MTD/JFFS2 things.

+typo-in-drivers-net-e1000-e1000_hwc.patch

 e1000 fix.

+tulip-fix-shutdown-dma-irq-race.patch

 Tulip fix.

+af_unix-datagram-getpeersec.patch
+af_unix-datagram-getpeersec-fix.patch
+drivers-dma-iovlockc-make-num_pages_spanned-static.patch
+drivers-net-irda-mcs7780c-make-struct-mcs_driver-static.patch
+irda-fix-rcu-lock-pairing-on-error-path.patch

 Networking things.

+git-pcmcia-xirc2ps_cs-fix-ooops-not-a-creditcard.patch

 Revert buggy PCMCIA patch.

+powerpc-fix-idr-locking-in-init_new_context.patch

 IDR locking fix.

+git-sas-sas_discover-build-fix.patch

 Fix a build error which used to be in git-sas.patch.  Might not be needed
 now..

+64bit-resource-convert-a-few-remaining-drivers-to-use-resource_size_t-where-needed-8139cp.patch

 Fix warning due to PCI tree.

+revert-VIA-quirk-fixup-additional-PCI-IDs.patch
+revert-PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch

 Revert quirk patches which broke machines in 2.6.17.

-git-scsi-misc-fixup.patch

 Unneeded.

+make-drivers-scsi-aic7xxx-aic79xx_coreahd_set_tags-static.patch

 SCSI driver clenaup.

+fix-broken-dubious-driver-suspend-methods.patch
+pm-define-pm_event_prethaw.patch
+pm-pci-and-ide-handle-pm_event_prethaw.patch
+pm-video-drivers-and-pm_event_prethaw.patch
+pm-usb-hcds-use-pm_event_prethaw.patch
+pm-usb-hcds-use-pm_event_prethaw-fix.patch
+pm-issue-pm_event_prethaw.patch
+usb-remove-empty-destructor-from-drivers-usb-mon-mon_textc.patch

 Power Management enhancements.

+bcm43xx-opencoded-locking.patch
+bcm43xx-opencoded-locking-fix.patch

 Broadcom driver cleanups.

+zoned-vm-counters-create-vmstatc-h-from-page_allocc-h-fix-2.patch
+zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-speedup.patch
+zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-speedup-fix.patch
+zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-export-vm_stat.patch
+zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix-2.patch
+zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter-fix-2.patch

 Update the VM counters patches in -mm.

+mm-tracking-shared-dirty-pages.patch
+mm-tracking-shared-dirty-pages-update.patch
+mm-balance-dirty-pages.patch
+mm-msync-cleanup.patch
+mm-optimize-the-new-mprotect-code-a-bit.patch
+mm-small-cleanup-of-install_page.patch

 Attempt to limit the amount of dirty memory which can be created via
 mmap(MAP_SHARED).

+mm-tracking-shared-dirty-pages-checks.patch

 Add some debug checks to it.

+mm-tracking-shared-dirty-pages-wimp.patch

 Use WARN_ON, not BUG.

+slab-consolidate-code-to-free-slabs-from-freelist.patch
+slab-consolidate-code-to-free-slabs-from-freelist-fix.patch

 slab cleanup.

+selinux-extend-task_kill-hook-to-handle-signals-sent.patch
+selinux-add-security-hook-call-to-kill_proc_info_as_uid.patch
+selinux-update-usb-code-with-new-kill_proc_info_as_uid.patch

 SELinux updates.

+add-smp_setup_processor_id.patch

 Hopefully fix Voyager.

+x86-dont-print-out-smp-info-on-up-kernels.patch

 Remove unneeded x86 code.

-autofs4-needs-to-force-fail-return-revalidate-update.patch

 Folded into autofs4-needs-to-force-fail-return-revalidate.patch

+destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch
+# destroy-the-dentries-contributed-by-a-superblock-on-unmounting-fix.patch: debug
+destroy-the-dentries-contributed-by-a-superblock-on-unmounting-fix.patch
+keys-allow-in-kernel-key-requestor-to-pass-auxiliary-data-to-upcaller.patch
+keys-allow-in-kernel-key-requestor-to-pass-auxiliary-data-to-upcaller-try-2.patch
+cond_resched-fix.patch
+ufs-truncate-should-allocate-block-for-last-byte.patch
+ufs-printk-fix.patch
+arch-i386-mach-visws-setupc-remove-dummy-function-calls.patch
+re-add-config_sound_sscape.patch
+remove-devinit-from-ioc4-pci_driver.patch
+deref-in-drivers-block-paride-pfc.patch
+chardev-gpio-for-scx200-pc-8736x-add-proper-kconfig-makefile-entries.patch

 Misc patches.

+delay-accounting-taskstats-interface-send-tgid-once-locking.patch

 Fix delay-accounting-taskstats-interface-send-tgid-once.patch some more.

+edac-pci-device-to-device-cleanup.patch
+edac-mc-numbers-refactor-1-of-2.patch
+edac-mc-numbers-refactor-2-of-2.patch
+edac-probe1-cleanup-1-of-2.patch
+edac-probe1-cleanup-2-of-2.patch
+edac-maintainers-update.patch

 EDAC driver updates.

+i4l-remove-unneeded-include-linux-isdn-tpamh.patch
+skb-leak-in-drivers-isdn-i4l-isdn_x25ifacec.patch

 ISDN driver fixes.

+sched-clean-up-fallout-of-recent-changes.patch
+sched-clean-up-fallout-of-recent-changes-fix.patch
+sched-cleanup-remove-task_t-convert-to-struct-task_struct.patch
+sched-cleanup-convert-schedc-internal-typedefs-to-struct.patch
+sched-cleanup-remove-task_t-convert-to-struct-task_struct-prefetch.patch

 Massive CPU scheduler cleanups.

+sched-fix-bug-in-__migrate_task.patch

 Fix CPU scheduler bug.

+fs-ecryptfs-possible-cleanups.patch
+ecryptfs-remove-pointless-bug_ons.patch
+ecryptfs-validate-minimum-header-extent-size.patch
+ecryptfs-validate-body-size.patch
+ecryptfs-validate-packet-length-prior-to-parsing-add-comments.patch
+ecryptfs-validate-packet-length-prior-to-parsing-add-comments-fix.patch
+ecryptfs-use-the-passed-in-max-value-as-the-upper-bound.patch
+ecryptfs-change-the-maximum-size-check-when-writing-header.patch
+ecryptfs-print-the-actual-option-that-is-problematic.patch
+ecryptfs-add-a-maintainers-entry.patch

 ecryptfs updates.

+hpt3xx-init-code-rewrite.patch

 IDE update.

-md-possible-fix-for-unplug-problem.patch
-md-set-desc_nr-correctly-for-version-1-superblocks.patch
-md-delay-starting-md-threads-until-array-is-completely-setup.patch
-md-fix-resync-speed-calculation-for-restarted-resyncs.patch
-md-fix-a-plug-unplug-race-in-raid5.patch
-md-fix-some-small-races-in-bitmap-plugging-in-raid5.patch
-md-fix-usage-of-wrong-variable-in-raid1.patch
-md-unify-usage-of-symbolic-names-for-perms.patch
-md-require-cap_sys_admin-for-re-configuring-md-devices-via-sysfs.patch
-md-fix-will-configure-message-when-interpreting-md=-kernel-parameter.patch
-md-include-sector-number-in-messages-about-corrected-read-errors.patch

 Dropped.

+genirq-rename-desc-handler-to-desc-chip-sparc64-fix.patch
+genirq-cleanup-merge-irq_affinity-into-irq_desc-sparc64-fix.patch

 Generic IRQ fixes.

-lockdep-acpi-locking-fix.patch

 Dropped due to large rejects.  Possibly the ACPI guys have fixed this for
 real - I haven't looked.

+lockdep-add-disable-enable_irq_lockdep-api-fix.patch
+lockdep-stacktrace-subsystem-s390-support-fix.patch
+lockdep-core-improve-non-static-key-warning-message.patch
+lockdep-core-cleanups.patch
+lockdep-core-cleanups-2.patch
+lockdep-annotate-vlan-net-device-as-being-a-special-class-fix.patch

 Lockdep fixes (rather a lot).

+lockdep-annotate-on-stack-completions-mmc.patch
+lockdep-irqtrace-subsystem-move-account_system_vtime-calls-into-kernel-softirqc.patch

 Fix lockdep falseish-positives.

+lockdep-special-s390-print_symbol-version.patch

 Improved print_symbol() for s390.

+srcu-2-rcu-variant-permitting-read-side-blocking.patch
+srcu-add-srcu-operations-to-rcutorture-tidy-2.patch
+srcu-2-add-srcu-operations-to-rcutorture.patch
+srcu-2-add-srcu-operations-to-rcutorture-fix.patch

 Update the RCU patche sin -mm.

+ro-bind-mounts-prepare-for-write-access-checks-collapse-if.patch
+ro-bind-mounts-r-o-bind-mount-prepwork-move-open_nameis-vfs_create.patch
+ro-bind-mounts-add-vfsmount-writer-count.patch
+ro-bind-mounts-elevate-mnt-writers-for-callers-of-vfs_mkdir.patch
+ro-bind-mounts-elevate-write-count-during-entire-ncp_ioctl.patch
+ro-bind-mounts-elevate-write-count-during-entire-ncp_ioctl-tidy.patch
+ro-bind-mounts-sys_symlinkat-elevate-write-count-around-vfs_symlink.patch
+ro-bind-mounts-elevate-mount-count-for-extended-attributes.patch
+ro-bind-mounts-sys_linkat-elevate-write-count-around-vfs_link.patch
+ro-bind-mounts-mount_is_safe-add-comment.patch
+ro-bind-mounts-unix_find_other-elevate-write-count-for-touch_atime.patch
+ro-bind-mounts-elevate-write-count-over-calls-to-vfs_rename.patch
+ro-bind-mounts-tricky-elevate-write-count-files-are-opened.patch
+ro-bind-mounts-elevate-writer-count-for-do_sys_truncate.patch
+ro-bind-mounts-elevate-write-count-for-do_utimes.patch
+ro-bind-mounts-elevate-write-count-for-do_sys_utime-and-touch_atime.patch
+ro-bind-mounts-sys_mknodat-elevate-write-count-for-vfs_mknod-create.patch
+ro-bind-mounts-elevate-mnt-writers-for-vfs_unlink-callers.patch
+ro-bind-mounts-do_rmdir-elevate-write-count.patch
+ro-bind-mounts-elevate-writer-count-for-custom-struct-file.patch
+ro-bind-mounts-honor-r-w-changes-at-do_remount-time.patch

 Read-only bind mounts (to be dropped RSN).

+journal_add_journal_head-debug.patch
+page-owner-tracking-leak-detector.patch
+unplug-can-sleep.patch
+firestream-warnings.patch
+#periodically-scan-redzone-entries-and-slab-control-structures.patch
+slab-leak-detector.patch
+releasing-resources-with-children.patch
+nr_blockdev_pages-in_interrupt-warning.patch
+detect-atomic-counter-underflows.patch
+device-suspend-debug.patch
+slab-cache-shrinker-statistics.patch
+mm-debug-dump-pageframes-on-bad_page.patch
+debug-shared-irqs.patch
+make-frame_pointer-default=y.patch
+i386-enable-4k-stacks-by-default.patch
+pidhash-temporary-debug-checks.patch
+revert-tty-buffering-comment-out-debug-code.patch
+mutex-subsystem-synchro-test-module.patch
+x86-e820-debugging.patch
+slab-leaks3-default-y.patch
+x86-kmap_atomic-debugging.patch
+profile-likely-unlikely-macros.patch
+vdso-print-fatal-signals.patch
+vdso-improve-print_fatal_signals-support-by-adding-memory-maps.patch

 Restore all the little -mm debug patches.  (But still no kgdb).



All 819 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm4/patch-list


