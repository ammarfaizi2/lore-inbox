Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965355AbWJCHLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965355AbWJCHLY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 03:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965350AbWJCHLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 03:11:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965158AbWJCHLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 03:11:22 -0400
Date: Tue, 3 Oct 2006 00:11:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-mm3
Message-Id: <20061003001115.e898b8cb.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm3/

- Added Jeff's make-bogus-warnings-go-away tree to the -mm lineup, as
  git-gccbug.patch

- Francois Romieu is doing some qlogic driver maintenance - added his
  git-qla3xxx.patch to the -mm lineup.

- Some wireless-related crashes are hopefully fixed.  But if there are still
  wireless problems, be sure that you have the latest userspace tools.

- The recent spate of IRQ-allocation-related crashes on x86_64 is hopefully
  fixed.

- As far as we know, the MSI handling in -mm is now rock-solid.




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

- When reporting bugs in this kernel via email, please also rewrite the
  email Subject: in some manner to reflect the nature of the bug.  Some
  developers filter by Subject: when looking for messages to read.

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.





Changes since 2.6.18-mm2:


 origin.patch
 git-acpi.patch
 git-arm.patch
 git-cifs.patch
 git-dvb.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-input.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-parisc.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-serial.patch
 git-pciseg.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-gccbug.patch

 git trees

-__percpu_alloc_mask-has-to-be-__always_inline-in-up-case.patch
-sys_getcpu-prototype-annotated.patch
-remove-generic__raw_read_trylock.patch
-jbd-memory-leak-in-journal_init_dev.patch
-driver-core-fixes-sysfs_create_link-retval-check-in.patch
-driver-core-fixes-bus_add_attrs-retval-check.patch
-driver-core-fixes-bus_add_device-cleanup-on-error.patch
-driver-core-fixes-device_add-cleanup-on-error.patch
-driver-core-fixes-device_create_file-retval-check-in.patch
-driver-core-fixes-sysfs_create_group-retval-in-topologyc.patch
-sysfs-remove-duplicated-dput-in-sysfs_update_file.patch
-sysfs-update-obsolete-comment-in-sysfs_update_file.patch
-allow-rc5-codes-64-127-in-ir-kbd-i2cc.patch
-v4l-support-for-saa7134-based-avertv-hybrid-a16ar.patch
-drivers-media-use-null-instead-of-0-for-ptrs.patch
-gregkh-i2c-hwmon-w83627ehf-add-pwm-support.patch
-gregkh-i2c-hwmon-w83627ehf-documentation.patch
-gregkh-i2c-hwmon-atxp1-signed-unsigned-char-bug.patch
-gregkh-i2c-hwmon-hdaps-handle-errors-from-input-register-device.patch
-gregkh-i2c-hwmon-smsc47m1-fix-dev-message.patch
-gregkh-i2c-hwmon-it87-it8716f-support.patch
-gregkh-i2c-hwmon-it87-disabled-fans.patch
-gregkh-i2c-hwmon-it87-div-to-reg-overflow.patch
-gregkh-i2c-hwmon-it87-in8-no-limits.patch
-gregkh-i2c-hwmon-it87-set-fan-div.patch
-gregkh-i2c-hwmon-it87-it8718f-support.patch
-gregkh-i2c-hwmon-it87-sane-limit-defaults.patch
-gregkh-i2c-hwmon-it87-copyright-update.patch
-gregkh-i2c-hwmon-k8temp-new-driver.patch
-gregkh-i2c-hwmon-k8temp-autoload.patch
-gregkh-i2c-hwmon-abituguru-suspend-resume.patch
-inode_diet-replace-inodeugeneric_ip-with-inodei_private-gfs2.patch
-inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-gfs2.patch
-possible-dereference-in.patch
-drivers-input-misc-added-acer-travelmate-2424nwxci-support-to-the-wistron-button-interface.patch
-mtd-printk-format-warning.patch
-ppc-fix-typo-in-cpm2h.patch
-tickle-nmi-watchdog-on-serial-output.patch
-config_pm=n-slim-drivers-serial-8250_pcic.patch
-magic-sysrq-sak-does-nothing-on-serial-consoles.patch
-via-irq-quirk-behaviour-change.patch
-pcie-check-and-return-bus_register-errors-fix.patch
-pci-add-ich7-8-acpi-gpio-io-resource-quirks.patch
-pci-quirks-update.patch
-remove-unnecessary-check-in.patch
-pci-turn-pci_fixup_video-into-generic-for-embedded.patch
-overrun-in-drivers-scsi-scsic.patch
-fix-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure-2.patch
-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure-2.patch
-microtek-usb-scanner-scsi_cmnd-conversion.patch
-usb-serial-possible-irq-lock-inversion-ppp-vs.patch
-usb-allow-both-root-hub-interrupts-and-polling.patch
-ohci-remove-existing-autosuspend-code.patch
-ohci-add-auto-stop-support.patch
-ohci-add-auto-stop-support-hack-hack.patch
-pegasus-driver-failing-for-admtek-8515-network-device.patch
-x86_64-mm-copy-user-inatomic.patch
-x86_64-mm-allow-disabling-dac.patch
-x86_64-mm-iommu-setup-style.patch
-x86_64-mm-document-iommu-panic.patch
-x86_64-mm-unify-ioapic-checking.patch
-x86_64-mm-nmi-sysctl-cleanup.patch
-x86_64-mm-i386-setup-array-size.patch
-x86_64-mm-setup-array-size.patch
-x86_64-mm-i386-mmconfig-flush.patch
-x86_64-mm-re-positioning-the-bss-segment.patch
-x86_64-mm-vsyscall-blob-header.patch
-x86_64-mm-sem-early-clobber.patch
-hot-add-mem-x86_64-fixup-externs.patch
-hot-add-mem-x86_64-kconfig-changes.patch
-hot-add-mem-x86_64-enable-sparsemem-in-sratc.patch
-hot-add-mem-x86_64-memory_add_physaddr_to_nid-enable.patch
-hot-add-mem-x86_64-memory_add_physaddr_to_nid-node-fixup.patch
-hot-add-mem-x86_64-use-config_memory_hotplug_sparse.patch
-hot-add-mem-x86_64-use-config_memory_hotplug_reserve.patch
-arch-i386-pci-mmconfigc-tlb-flush-fix-tweaks.patch
-xfs-add-lock-annotations-to-xfs_trans_update_ail-and-xfs_trans_delete_ail.patch
-convert-s390-page-handling-macros-to-functions.patch
-convert-s390-page-handling-macros-to-functions-fix.patch
-mm-fix-a-race-condition-under-smc-cow.patch
-convert-i386-summit-subarch-to-use-srat-info-for-apicid_to_node-calls.patch
-convert-i386-summit-subarch-to-use-srat-info-for-apicid_to_node-calls-tidy.patch
-uml-assign-random-macs-to-interfaces-if-necessary.patch
-uml-mechanical-tidying-after-random-macs-change.patch
-uml-locking-documentation.patch
-uml-close-file-descriptor-leaks.patch
-uml-stack-consumption-reduction.patch
-uml-remove-pte_mkexec.patch
-kernel-params-must_check-fixes.patch
-blockdevc-check-errors.patch
-blockdevc-check-errors-fix.patch
-block-handle-subsystem_register-init-errors.patch
-fs-namespace-handle-init-registration-errors.patch
-make-prot_write-imply-prot_read.patch
-debug-variants-of-linked-list-macros.patch
-list_del-debug.patch
-make-touch_nmi_watchdog-imply-touch_softlockup_watchdog-on.patch
-make-touch_nmi_watchdog-imply-touch_softlockup_watchdog-on-fix.patch
-remove-unnecessary-barrier-in-rtc_get_rtc_time.patch
-drivers-char-scx200_gpioc-make-code-static.patch
-drivers-char-pc8736x_gpioc-remove-unused-static-functions.patch
-let-warn_on-warn_on_once-return-the-condition.patch
-let-warn_on-warn_on_once-return-the-condition-fix.patch
-let-warn_on-warn_on_once-return-the-condition-fix-2.patch
-scx200_gpio-export-cleanups.patch
-make-net48xx-led-use-scx200_gpio_ops.patch
-libfs-remove-page-up-to-date-check-from-simple_readpage.patch
-kernel-doc-for-relay-interface.patch
-kernel-doc-move-filesystems-together.patch
-kthread-convert-loopc-to-kthread.patch
-include-documentation-for-functions-in-drivers-base-classc.patch
-fix-parameter-names-in-drivers-base-classc.patch
-spinlock_debug-dont-recompute-jiffies_per_loop.patch
-omap-add-smc91x-support-for-ti-omap2420-h4-board.patch
-omap-add-watchdog-driver-support.patch
-omap-add-watchdog-driver-support-tweaks.patch
-omap-add-keypad-driver-4.patch
-omap-update-omap1-2-boards-to-give-keymapsize-and-other.patch
-use-gcc-o1-in-fs-reiserfs-only-for-ancient-gcc-versions.patch
-irq-fixed-coding-style.patch
-irq-removed-a-extra-line.patch
-efi-add-lock-annotations-for-efi_call_phys_prelog-and-efi_call_phys_epilog.patch
-mbcache-add-lock-annotation-for-__mb_cache_entry_release_unlock.patch
-afs-add-lock-annotations-to-afs_proc_cell_servers_startstop.patch
-fuse-add-lock-annotations-to-request_end-and-fuse_read_interrupt.patch
-hugetlbfs-add-lock-annotation-to-hugetlbfs_forget_inode.patch
-lockdep-dont-pull-in-includes-when-lockdep-disabled.patch
-fs-add-lock-annotation-to-grab_super.patch
-rcu-add-lock-annotations-to-rcu_bh_torture_read_lockunlock.patch
-kthread-drivers-base-firmware_classc.patch
-require-mmap-handler-for-aout-executables.patch
-module_subsys-initialize-earlier.patch
-fuse-use-dentry-in-statfs.patch
-vfs-define-new-lookup-flag-for-chdir.patch
-timer-add-lock-annotation-to-lock_timer_base.patch
-dmi-decode-and-save-oem-string-information.patch
-remove-unused-tty_struct-variable.patch
-ignore-partition-table-on-disks-with-aix-label.patch
-task_struct-ifdef-missedem-v-ipc.patch
-ifdef-blktrace-debugging-fields.patch
-mount-udf-udf_part_flag_read_only-partitions-with-ms_rdonly.patch
-fix-intel-rng-detection.patch
-rtmutex-clean-up-and-remove-some-extra-spinlocks.patch
-rtmutex-clean-up-and-remove-some-extra-spinlocks-more.patch
-oom_adj-oom_score-documentation.patch
-fix-kerneldoc-comments-in-kernel-timerc.patch
-fix-kerneldoc-comments-in-kernel-timerc-fix.patch
-there-is-no-devfs-there-has-never-been-a-devfs-we-have.patch
-move-valid_dma_direction-from-x86_64-to-generic-code.patch
-move-valid_dma_direction-from-x86_64-to-generic-code-fix.patch
-use-valid_dma_direction-in-include-asm-i386-dma-mappingh.patch
-lsm-remove-bsd-secure-level-security-module.patch
-tty_ioc-keep-davej-sane.patch
-single-bit-flip-detector.patch
-single-bit-flip-detector-tidy.patch
-ucb1x00-ts-handle-errors-from-input_register_device.patch
-console-utf-8-mode-fixes.patch
-reiserfs_fsync-should-only-use-barriers-when-they-are-enabled.patch
-fix-reiserfs-latencies-caused-by-data=ordered.patch
-ifdef-quota_read-quota_write.patch
-unwind-fix-unused-variable-warning-when.patch
-reiserfs-ifdef-xattr_sem.patch
-reiserfs-ifdef-acl-stuff-from-inode.patch
-fsh-ifdef-security-fields.patch
-oprofile-ppro-need-to-enable-disable-all-the-counters.patch
-add-o-flush-for-fat.patch
-tty-locking-on-resize.patch
-kthread-convert-arch-i386-kernel-apmc.patch
-fix-unserialized-task-files-changing.patch
-fix-unserialized-task-files-changing-fix.patch
-fix-conflict-with-the-is_init-identifier-on-parisc.patch
-pidspace-is_init.patch
-chardev-checking-of-overlapping-ranges.patch
-ahci-ati-sb600-sata-support-for-various-modes.patch
-atiixp-ati-sb600-ide-support-for-various-modes.patch
-lockdep-print-kernel-version.patch
-memory-ordering-in-__kfifo-primitives.patch
-small-update-to-credits.patch
-fix-wrong-error-code-on-interrupted-close-syscalls.patch
-fix-wrong-error-code-on-interrupted-close-syscalls-fix.patch
-remove-another-configh.patch
-make-ledsh-include-relevant-headers.patch
-config_pm=n-slim-drivers-parport-parport_serialc.patch
-config_pm=n-slim-sound-oss-tridentc.patch
-config_pm=n-slim-sound-oss-cs46xxc.patch
-remove-old-drivers-char-s3c2410_rtcc.patch
-sound-mips-au1x00-use-array_size-macro.patch
-sound-sparc-dbri-use-array_size-macro.patch
-check-return-value-of-cpu_callback.patch
-fix-serial-amba-pl011c-console-kconfig.patch
-elf_core_dump-dont-take-tasklist_lock.patch
-elf_fdpic_core_dump-dont-take-tasklist_lock.patch
-fix-memory-leak-in-vc_resize-vc_allocate.patch
-dquot-add-proper-locking-when-using-current-signal-tty.patch
-update-documentation-kernel-parameterstxt.patch
-posix-timers-fix-clock_nanosleep-doesnt-return-the-remaining-time-in-compatibility-mode-2.patch
-posix-timers-fix-the-flags-handling-in-posix_cpu_nsleep-2.patch
-i-o-error-attempting-to-read-last-partial-block-of-a-file-in-an-iso9660-file-system.patch
-has_stopped_jobs-cleanup.patch
-__dequeue_signal-cleanup.patch
-simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem-2.patch
-kexec-warning-fix.patch
-tty-trivial-kzalloc-opportunity.patch
-tty-lock-ticogwinsz.patch
-tty-stop-the-tty-vanishing-under-procfs-access.patch
-exit-fix-crash-case.patch
-tty-make-termios_sem-a-mutex.patch
-tty-make-termios_sem-a-mutex-fix.patch
-cdev-documentation-was-drop-second-arg-of-unregister_chrdev.patch
-use-decimal-for-ptrace_attach-and-ptrace_detach.patch
-return-better-error-codes-if-drivers-char-rawc-module-init-fails.patch
-fix-____call_usermodehelper-errors-being-silently-ignored.patch
-kill-extraneous-printk-in-kernel_restart.patch
-do_sched_setscheduler-dont-take-tasklist_lock.patch
-introduce-is_rt_policy-helper.patch
-sched_setscheduler-fix-policy-checks.patch
-reparent_to_init-use-has_rt_policy.patch
-copy_process-cosmetic-ioprio-tweak.patch
-autofs4-autofs4_follow_link-false-negative-fix.patch
-autofs4-pending-flag-not-cleared-on-mount-fail.patch
-futex_find_get_task-dont-take-tasklist_lock.patch
-sys_get_robust_list-dont-take-tasklist_lock.patch
-docbook-fix-segfault-in-docprocc.patch
-solaris-emulation-incorrect-tty-locking.patch
-solaris-emulation-incorrect-tty-locking-fix.patch
-solaris-emulation-incorrect-tty-locking-fix-2.patch
-tty-fix-bits-and-note-more-bits-to-fix.patch
-windfarm_smu_satc-simplify-around-i2c_add_driver.patch
-make-spinlock-rwlock-annotations-more-accurate-by-using.patch
-replace-_spin_trylock-with-spin_trylock-in-the-irq.patch
-generic-boolean.patch
-fs-ntfs-conversion-to-generic-boolean.patch
-fs-jfs-conversion-to-generic-boolean.patch
-block_devc-mutex_lock_nested-fix.patch
-fix-mem_write-return-value.patch
-doc-fix-kernel-parameters-quiet.patch
-pass-a-lock-expression-to-__cond_lock-like-__acquire-and.patch
-cramfs-rewrite-init_cramfs_fs.patch
-freevxfs-fix-leak-on-error-path.patch
-cramfs-make-cramfs_uncompress_exit-return-void.patch
-9p-fix-leak-on-error-path.patch
-ban-register_filesystemnull.patch
-lockdep-core-add-enable-disable_irq_irqsave-irqrestore-apis.patch
-set-exit_dead-state-in-do_exit-not-in-schedule.patch
-kill-pf_dead-flag.patch
-introduce-task_dead-state.patch
-select_bad_process-kill-a-bogus-pf_dead-task_dead-check.patch
-select_bad_process-cleanup-releasing-check.patch
-oom_kill_task-cleanup-mm-checks.patch
-oom-dont-kill-current-when-another-oom-in-progress.patch
-fix-typo-in-rtc-kconfig.patch
-cpuset-top_cpuset-tracks-hotplug-changes-to-node_online_map.patch
-cpuset-top_cpuset-tracks-hotplug-changes-to-node_online_map-fix.patch
-cpuset-top_cpuset-tracks-hotplug-changes-to-node_online_map-fix-2.patch
-cpuset-hotunplug-cpus-and-mems-in-all-cpusets.patch
-remove-sound-oss-copying.patch
-fs-partitions-conversion-to-generic-boolean.patch
-loop-forward-port-resource-leak-checks-from-solar.patch
-maximum-latency-tracking-infrastructure.patch
-maximum-latency-tracking-infrastructure-tidy.patch
-maximum-latency-tracking-alsa-support.patch
-add-to-maintainers-file.patch
-lib-rwsemc-un-inline-rwsem_down_failed_common.patch
-add-section-on-function-return-values-to-codingstyle.patch
-fs-nameic-replace-multiple-current-fs-by-shortcut-variable.patch
-fs-nameic-replace-multiple-current-fs-by-shortcut-variable-tidy.patch
-superh-maintainership-change.patch
-mem-driver-fix-conditional-on-isa-i-o-support.patch
-remove-static-variable-mm-page-writebackctotal_pages.patch
-call-mm-page-writebackcset_ratelimit-when-new-pages.patch
-call-mm-page-writebackcset_ratelimit-when-new-pages-tidy.patch
-valid_swaphandles-fix.patch
-mention-documenation-abi-requirements-in-documentation-submitchecklist.patch
-rate-limiting-for-the-ldisc-open-failure-messages.patch
-lib-ts_fsmc-constify-structs.patch
-submittingpatches-cleanups.patch
-network-block-device-is-mostly-known-as-nbd.patch
-superh-list-is-moderated.patch
-sys-modules-patch-allow-full-length-section-names.patch
-uninitialized-variable-in-drivers-net-wan-syncpppc.patch
-enforce-rlimit_nofile-in-poll.patch
-generic-infrastructure-for-acls.patch
-generic-infrastructure-for-acls-update.patch
-access-control-lists-for-tmpfs.patch
-access-control-lists-for-tmpfs-cleanup.patch
-stop_machinec-copyright.patch
-build-sound-sound_firmwarec-only-for-oss.patch
-build-sound-sound_firmwarec-only-for-oss-doc.patch
-rtc-more-xstp-vdet-support-for-rtc-rs5c348-driver.patch
-generic_serial-remove-private-decoding-of-baud-rate-bits.patch
-istallion-remove-private-baud-rate-decoding-which-is.patch
-specialix-remove-private-speed-decoding.patch
-fix-locking-for-tty-drivers-when-doing-urgent-characters.patch
-audit-accounting-tty-locking.patch
-documentation-submittingdrivers-minor-update.patch
-clean-up-expand_fdtable-and-expand_files-take-2.patch
-expand_fdtable-remove-pointless-unlocklock.patch
-kcore-elf-note-namesz-field-fix.patch
-lockdep-core-improve-the-lock-chain-hash.patch
-linux-kernel-dump-test-module.patch
-linux-kernel-dump-test-module-fixes.patch
-submittingpatches-add-a-note-about-format=flowed-when-sending-patches.patch
-kmemdup-introduce.patch
-kmemdup-some-users.patch
-cpuset-fix-obscure-attach_task-vs-exiting-race.patch
-create-fs-utimesc.patch
-cciss-support-for-2tb-logical-volumes.patch
-serial-fix-up-offenders-peering-at-baud-bits-directly.patch
-codingstyle-cleanup-for-kernel-sysc.patch
-allow-proc-configgz-to-be-built-as-a-module.patch
-pci-via82cxxx_audio-use-pci_get_device.patch
-pci-cs46xx-oss-switch-to-pci_get_device.patch
-pci-piix-use-refcounted-interface-when-searching-for-a-450nx.patch
-pci-serverworks-switch-to-pci-refcounted-interfaces.patch
-pci-sis5513-switch-to-pci-refcounting.patch
-pci-via-switch-to-pci_get_device-refcounted-pci-api.patch
-mbcs-use-seek_set-cur.patch
-eicon-isdn-removed-unused-definitions-for-os_seek_.patch
-vfs-use-seek_set-cur.patch
-proper-flags-type-of-spin_lock_irqsave.patch
-submit-checklist-mention-headers_check.patch
-doc-lockdep-design-explain-display-of-state-bits.patch
-leds-turn-led-off-when-changing-triggers.patch
-directed-yield-cpu_relax-variants-for-spinlocks-and-rw-locks.patch
-directed-yield-direct-yield-of-spinlocks-for-powerpc.patch
-directed-yield-direct-yield-of-spinlocks-for-s390.patch
-synclink_gt-add-bisync-and-monosync-modes.patch
-synclink_gt-increase-max-devices.patch
-cciss-remove-unneeded-spaces-in-output-for-attached-volumes-resend.patch
-remove-superfluous-call-to-call-to-cdev_del.patch
-howto-mention-bughunting.patch
-isicom-correct-firmware-loading.patch
-remove-sysrq_key-and-related-defines-from-ppc-sh-h8300.patch
-mmc-mainly-add-or-later-clause-to-licence-statement.patch
-prevent-multiple-inclusion-of-linux-sysrqh.patch
-move-ncpfs-32bit-compat-ioctl-to-ncpfs.patch
-ipmi-per-channel-command-registration.patch
-update-legacy-io-handling-for-pmac.patch
-ip2-use-newer-pci_get-functions.patch
-i2o-switch-to-pci_get-api.patch
-cardbus-switch-to-ref-counting-hotplug-safe-api.patch
-sysrq-disable-lockdep-on-reboot.patch
-trident-fix-pci_dev-reference-counting-and-buglet.patch
-off-by-one-in-drivers-char-mwave-mwaveddc.patch
-hdaps-support-lenovo-thinkpad-t60.patch
-typo-fixes-for-rt-mutex-designtxt.patch
-remove-bug_onunlikely-in-include-linux-aioh.patch
-pass-sparse-the-lock-expression-given-to-lock-annotations.patch
-ntp-move-all-the-ntp-related-code-to-ntpc.patch
-ntp-move-all-the-ntp-related-code-to-ntpc-fix.patch
-ntp-add-ntp_update_frequency.patch
-ntp-add-ntp_update_frequency-fix.patch
-ntp-add-time_adj-to-tick-length.patch
-ntp-add-time_freq-to-tick-length.patch
-ntp-prescale-time_offset.patch
-ntp-add-time_adjust-to-tick-length.patch
-ntp-remove-time_tolerance.patch
-ntp-convert-time_freq-to-nsec-value.patch
-ntp-convert-to-the-ntp4-reference-model.patch
-ntp-cleanup-defines-and-comments.patch
-kernel-time-ntpc-possible-cleanups.patch
-kill-wall_jiffies.patch
-reiserfs-fix-is_reusable-bitmap-check-to-not-traverse-the-bitmap-info-array.patch
-reiserfs-clean-up-bitmap-block-buffer-head-references.patch
-reiserfs-reorganize-bitmap-loading-functions.patch
-reiserfs-on-demand-bitmap-loading.patch
-reiserfs-use-generic_file_open-for-open-checks.patch
-reiserfs-eliminate-minimum-window-size-for-bitmap-searching.patch
-vectorize-aio_read-aio_write-fileop-methods.patch
-vectorize-aio_read-aio_write-fileop-methods-xfs-fix.patch
-vectorize-aio_read-aio_write-fileop-methods-hypfs-fix.patch
-remove-readv-writev-methods-and-use-aio_read-aio_write.patch
-streamline-generic_file_-interfaces-and-filemap.patch
-streamline-generic_file_-interfaces-and-filemap-gfs-fix.patch
-add-vector-aio-support.patch
-add-vector-aio-support-fix.patch
-clean-up-unused-kiocb-variables.patch
-add-genetlink-utilities-for-payload-length-calculation.patch
-fix-taskstats-size-calculation-use-the-new-genetlink-utility-functions.patch
-fix-getdelaysc-cpumask-length-and-error-reporting.patch
-csa-basic-accounting-over-taskstats.patch
-csa-basic-accounting-over-taskstats-fix.patch
-csa-extended-system-accounting-over-taskstats.patch
-csa-convert-config-tag-for-extended-accounting-routines.patch
-csa-accounting-taskstats-update.patch
-csa-accounting-taskstats-update-update-comments-in-linux-taskstatsh.patch
-r-o-bind-mount-prepare-for-write-access-checks-collapse-if.patch
-r-o-bind-mount-prepwork-move-open_nameis-vfs_create.patch
-r-o-bind-mount-unlink-monitor-i_nlink.patch
-r-o-bind-mount-prepwork-inc_nlink-helper.patch
-r-o-bind-mount-clean-up-ocfs2-nlink-handling-2.patch
-r-o-bind-mount-monitor-zeroing-of-i_nlink.patch
-stack-overflow-safe-kdump-safe_smp_processor_id.patch
-stack-overflow-safe-kdump-safe_smp_processor_id_voyager.patch
-stack-overflow-safe-kdump-crash_use_safe_smp_processor_id.patch
-stack-overflow-safe-kdump-crash_use_safe_smp_processor_id-fix.patch
-stack-overflow-safe-kdump-safe_smp_send_nmi_allbutself.patch
-generic-ioremap_page_range-implementation.patch
-generic-ioremap_page_range-implementation-fix.patch
-generic-ioremap_page_range-implementation-nommu-fix.patch
-generic-ioremap_page_range-flush_cache_vmap.patch
-generic-ioremap_page_range-alpha-conversion.patch
-generic-ioremap_page_range-avr32-conversion.patch
-generic-ioremap_page_range-cris-conversion.patch
-generic-ioremap_page_range-i386-conversion.patch
-generic-ioremap_page_range-i386-conversion-fix.patch
-generic-ioremap_page_range-m32r-conversion.patch
-generic-ioremap_page_range-mips-conversion-fix.patch
-generic-ioremap_page_range-x86_64-conversion.patch
-generic-ioremap_page_range-x86_64-conversion-fix.patch
-paravirt-remove-read-hazard-from-cow.patch
-paravirt-pte-clear-not-present.patch
-paravirt-lazy-mmu-mode-hooks.patch
-paravirt-combine-flush-accessed-dirty.patch
-paravirt-kpte-flush.patch
-paravirt-optimize-ptep-establish-for-pae.patch
-paravirt-remove-set-pte-atomic.patch
-paravirt-pae-compile-fix.patch
-paravirt-update-pte-hook.patch
-some-cleanup-in-the-pipe-code.patch
-some-cleanup-in-the-pipe-code-tidy.patch
-create-call_usermodehelper_pipe.patch
-support-piping-into-commands-in-proc-sys-kernel-core_pattern.patch
-support-piping-into-commands-in-proc-sys-kernel-core_pattern-fix.patch
-support-piping-into-commands-in-proc-sys-kernel-core_pattern-fix-2.patch
-proc-readdir-race-fix-take-3.patch
-proc-readdir-race-fix-take-3-race-fix.patch
-proc-reorder-the-functions-in-basec.patch
-proc-modify-proc_pident_lookup-to-be-completely-table-driven.patch
-proc-give-the-root-directory-a-task.patch
-pid-implement-access-helpers-for-a-tacks-various-process-groups.patch
-pid-add-do_each_pid_task.patch
-pid-implement-signal-functions-that-take-a-struct-pid.patch
-pid-export-the-symbols-needed-to-use-struct-pid.patch
-pid-implement-pid_nr.patch
-vt-rework-the-console-spawning-variables.patch
-vt-make-vt_pid-a-struct-pid-making-it-pid-wrap-around-safe.patch
-file-modify-struct-fown_struct-to-use-a-struct-pid.patch
-file-modify-struct-fown_struct-to-use-a-struct-pid-fix.patch
-remove-null-check-in-register_nls.patch
-fs-inodec-tweaks.patch
-const-struct-tty_operations.patch
-pids-coding-style-use-struct-pidmap.patch
-proc-readdir-race-fix-take-3-fix-1.patch
-simplify-pid-iterators.patch
-move-pidmap-to-pspaceh.patch
-move-pidmap-to-pspaceh-fix.patch
-define-struct-pspace.patch
-proc-readdir-race-fix-take-3-fix-2.patch
-update-mq_notify-to-use-a-struct-pid.patch
-file-add-locking-to-f_getown.patch
-usb-fixup-usb-so-it-uses-struct-pid.patch
-s390-update-fs3270-to-use-a-struct-pid.patch
-kprobes-make-kprobe-modules-more-portable.patch
-kprobes-make-kprobe-modules-more-portable-update.patch
-kprobes-handle-symbol-resolution-when-modulesymbol-is-specified.patch
-kprobes-handle-symbol-resolution-when-modulesymbol-is-specified-tidy.patch
-add-regs_return_value-helper.patch
-update-documentation-kprobestxt.patch
-update-documentation-kprobestxt-update.patch
-kprobe-whitespace-cleanup.patch
-disallow-kprobes-on-notifier_call_chain.patch
-kretprobe-spinlock-deadlock-patch.patch
-isdn4linux-gigaset-driver-fix-__must_check-warning.patch
-isdn-work-around-excessive-udelay.patch
-cpumask-add-highest_possible_node_id.patch
-cpumask-add-highest_possible_node_id-fix.patch
-cpumask-export-cpu_online_map-and-cpu_possible_map.patch
-cpumask-export-node_to_cpu_mask-consistently.patch
-knfsd-knfsd-add-some-missing-newlines-in-printks.patch
-knfsd-knfsd-remove-an-unused-variable-from-e_show.patch
-knfsd-knfsd-remove-an-unused-variable-from-auth_unix_lookup.patch
-knfsd-add-a-callback-for-when-last-rpc-thread-finishes.patch
-knfsd-add-a-callback-for-when-last-rpc-thread-finishes-tidy.patch
-knfsd-add-a-callback-for-when-last-rpc-thread-finishes-fix.patch
-knfsd-be-more-selective-in-which-sockets-lockd-listens-on.patch
-knfsd-remove-nfsd_versbits-as-intermediate-storage-for-desired-versions.patch
-knfsd-separate-out-some-parts-of-nfsd_svc-which-start-nfs-servers.patch
-knfsd-separate-out-some-parts-of-nfsd_svc-which-start-nfs-servers-tweaks.patch
-knfsd-define-new-nfsdfs-file-portlist-contains-list-of-ports.patch
-knfsd-define-new-nfsdfs-file-portlist-contains-list-of-ports-tidy.patch
-knfsd-define-new-nfsdfs-file-portlist-contains-list-of-ports-fix.patch
-knfsd-allow-sockets-to-be-passed-to-nfsd-via-portlist.patch
-knfsd-use-seq_start_token-instead-of-hardcoded-magic-void1.patch
-nfsd-add-lock-annotations-to-e_start-and-e_stop.patch
-knfsd-drop-serv-option-to-svc_recv-and-svc_process.patch
-knfsd-drop-serv-option-to-svc_recv-and-svc_process-nfs-callback-fix-nfs-callback-fix.patch
-knfsd-check-return-value-of-lockd_up-in-write_ports.patch
-knfsd-move-makesock-failed-warning-into-make_socks.patch
-knfsd-correctly-handle-error-condition-from-lockd_up.patch
-knfsd-move-tempsock-aging-to-a-timer.patch
-knfsd-move-tempsock-aging-to-a-timer-tidy.patch
-knfsd-convert-sk_inuse-to-atomic_t.patch
-knfsd-use-new-lock-for-svc_sock-deferred-list.patch
-knfsd-convert-sk_reserved-to-atomic_t.patch
-knfsd-test-and-set-sk_busy-atomically.patch
-knfsd-split-svc_serv-into-pools.patch
-knfsd-split-svc_serv-into-pools-fix.patch
-knfsd-add-svc_get.patch
-knfsd-add-svc_set_num_threads.patch
-knfsd-use-svc_set_num_threads-to-manage-threads-in-knfsd.patch
-knfsd-make-rpc-threads-pools-numa-aware.patch
-knfsd-make-rpc-threads-pools-numa-aware-fix.patch
-knfsd-allow-admin-to-set-nthreads-per-node.patch
-nfsd-lockdep-annotation.patch
-proc-sysctl-add-_proc_do_string-helper.patch
-make-kernel-sysctlc_proc_do_string-static.patch
-namespaces-add-nsproxy.patch
-namespaces-add-nsproxy-move-init_nsproxy-into-kernel-nsproxyc.patch
-namespaces-incorporate-fs-namespace-into-nsproxy.patch
-namespaces-incorporate-fs-namespace-into-nsproxy-whitespace.patch
-namespaces-exit_task_namespaces-invalidates-nsproxy.patch
-namespaces-utsname-introduce-temporary-helpers.patch
-namespaces-utsname-switch-to-using-uts-namespaces.patch
-namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit.patch
-namespaces-utsname-use-init_utsname-when-appropriate-klibc-bit.patch
-namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit-2.patch
-namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit-sparc.patch
-namespaces-utsname-use-init_utsname-when-appropriate.patch
-namespaces-utsname-implement-utsname-namespaces.patch
-namespaces-utsname-sysctl-hack.patch
-namespaces-utsname-remove-system_utsname.patch
-namespaces-utsname-implement-clone_newuts-flag.patch
-namespaces-utsname-implement-clone_newuts-flag-fix.patch
-uts-copy-nsproxy-only-when-needed.patch
-ipc-namespace-core.patch
-ipc-namespace-utils.patch
-ipc-namespace-msg.patch
-ipc-namespace-sem.patch
-ipc-namespace-shm.patch
-ipc-namespace-sysctls.patch
-ipc-namespace-fix.patch
-ipc-replace-kmalloc-and-memset-in-get_undo_list-with-kzalloc.patch
-introduce-kernel_execve.patch
-rename-the-provided-execve-functions-to-kernel_execve.patch
-rename-the-provided-execve-functions-to-kernel_execve-fixes.patch
-rename-the-provided-execve-functions-to-kernel_execve-headers-fix.patch
-provide-kernel_execve-on-all-architectures.patch
-provide-kernel_execve-on-all-architectures-fix.patch
-provide-kernel_execve-on-all-architectures-mips-fix.patch
-provide-kernel_execve-on-all-architectures-fix-2.patch
-provide-kernel_execve-on-all-architectures-fix-3.patch
-provide-kernel_execve-on-all-architectures-fix-4.patch
-provide-kernel_execve-on-all-architectures-m68knommu-fix.patch
-remove-the-use-of-_syscallx-macros-in-uml.patch
-sh64-remove-the-use-of-kernel-syscalls.patch
-remove-remaining-errno-and-__kernel_syscalls__-references.patch
-avr32-implement-kernel_execve.patch
-proc-make-the-generation-of-the-self-symlink-table-driven.patch
-proc-factor-out-an-instantiate-method-from-every-lookup-method.patch
-proc-remove-the-hard-coded-inode-numbers.patch
-proc-merge-proc_tid_attr-and-proc_tgid_attr.patch
-proc-use-pid_task-instead-of-open-coding-it.patch
-proc-convert-task_sig-to-use-lock_task_sighand.patch
-proc-convert-do_task_stat-to-use-lock_task_sighand.patch
-proc-drop-tasklist-lock-in-task_state.patch
-proc-properly-compute-tgid_offset.patch
-proc-remove-trailing-blank-entry-from-pid_entry-arrays.patch
-proc-remove-the-useless-smp-safe-comments-from-proc.patch
-proc-comment-what-proc_fill_cache-does.patch
-introduce-get_task_pid-to-fix-unsafe-get_pid.patch
-replace-cad_pid-by-a-struct-pid.patch
-replace-cad_pid-by-a-struct-pid-fixes.patch

 Merged into mainline or a subsystem tree.

+pidh-cleanup.patch
+vfs-make-filldir_t-and-struct-kstat-deal-in-64-bit-inode-numbers.patch
+revert-insert-ioapics-and-local-apic-into-resource-map.patch

 2.6.19-rc1 queue.

+fix-up-a-multitude-of-acpi-compiler-warnings-on-x86_64.patch
+acpi-cast-removal.patch

 ACPI fixes

+acpi-add-backlight-support-to-the-sony_acpi.patch

 Make sony_apci.patch use the backlight layer.

+dereference-after-free-in-snd_hwdep_release.patch

 Sound driver fix.

-git-block-fixup.patch

 Unneeded.

-git-block-hack.patch

 Merged (accidentally)

+gregkh-driver-driver-core-plug-device-probe-memory-leak.patch
+gregkh-driver-fix-dev_printk-is-now-gpl-only.patch
+gregkh-driver-howto-bug-report-addition.patch
+gregkh-driver-sysfs-remove-duplicated-dput-in-sysfs_update_file.patch
+gregkh-driver-sysfs-update-obsolete-comment-in-sysfs_update_file.patch
+gregkh-driver-driver-core-fixes-sysfs_create_link-retval-check-in-class.c.patch
+gregkh-driver-driver-core-fixes-bus_add_attrs-retval-check.patch
+gregkh-driver-driver-core-fixes-bus_add_device-cleanup-on-error.patch
+gregkh-driver-driver-core-fixes-device_add-cleanup-on-error.patch
+gregkh-driver-driver-core-fixes-device_create_file-retval-check-in-dmapool.c.patch
+gregkh-driver-driver-core-fixes-sysfs_create_group-retval-in-topology.c.patch
+gregkh-driver-driver-core-don-t-leak-old_class_name-in-drivers-base-core.c-device_rename.patch

 driver tree updates

+hdaps-remove-duplicate-whitelist-entry-and-add-thinkpad.patch

 hdaps device support.

+revert-input-make-input_openclose_device-more-robust.patch

 Revert buggy patch from git-input.patch.

-git-intelfb-fixup.patch

 Unneeded.

+remove-unnecessary-check-in-drivers-video-intelfb-intelfbhwc.patch

 intelfb cleanup

+docs-small-kbuild-cleanup.patch

 kbuild documentation fix.

+ata_piix-clean-up-port-flags.patch
+libata-unexport-ata_dev_revalidate.patch
+libata-convert-post_reset-to-flags-in-ata_dev_read_id.patch
+libata-implement-presence-detection-via-polling-identify.patch
+ata_piix-apply-device-detection-via-polling-identify.patch
+ata_piix-strip-now-unneded-map-related-stuff.patch
+libata-return-sense-data-in-hdio_drive_cmd-ioctl.patch
+libata-return-sense-data-in-hdio_drive_cmd-ioctl-tidy.patch

 sata updates

-git-mtd-fixup.patch

 Unneeded.

+powerpc-cell-spidernet-burst-alignment-patch.patch
+powerpc-cell-spidernet-low-watermark-patch.patch
+powerpc-cell-spidernet-stop-error-printing-patch.patch
+powerpc-cell-spidernet-ethtool-i-version-number-info.patch
+powerpc-cell-spidernet-ethtool-i-version-number.patch
+powerpc-cell-spidernet-refine-locking.patch
+8139too-force-media-setting-fix.patch
+sundance-remove-txstartthresh-and-rxearlythresh.patch
+sundance-fix-tx-pause-bug-reset_tx-intr_handler.patch
+sundance-change-phy-address-search-from-phy=1-to-phy=0.patch
+sundance-correct-initial-and-close-hardware-step.patch
+sundance-solve-host-error-problem-in-low-performance-embedded.patch
+hp100-fix-conditional-compilation-mess.patch

 netdev updates.  (The sprdernet patches are old and I meant to drop them)

+bonding-lockdep-annotation.patch
+ipv6-dccp-fix-memory-leak-in-dccp_v6_do_rcv.patch
+zatm-always-clear-pcr-in-alloc_shaper.patch
+atm-ambassador-fix-return-code-bug.patch
+tipc-fix-printk-warning.patch

 net updates.

+nfs-add-return-code-checks-for-page-invalidation.patch

 NFS debugging check.

-revert-genirq-core-fix-handle_level_irq.patch
-git-parisc-fixup.patch

 Unneeded

+git-powerpc-wrapper-dont-require-execute-permissions.patch

 Fix git-powerpc.patch scripting.

+powerpc-xmon-fix.patch

 xmon fix.

+r8169-driver-corega-support-patch.patch

 net driver device support.

+serial-trivial-code-flow-simplification.patch

 serial driver cleanup.

+gregkh-pci-shpchp-fix-shpchp_wait_cmd-in-poll.patch
+gregkh-pci-pciehp-fix-improper-info-messages.patch
+gregkh-pci-pciehp-add-missing-locking.patch
+gregkh-pci-pciehp-remove-unnecessary-check-in-pciehp_ctrl.c.patch
+gregkh-pci-pci-via-irq-quirk-behaviour-change.patch
+gregkh-pci-pci-pcie-check-and-return-bus_register-errors-fix.patch
+gregkh-pci-pci-add-ich7-8-acpi-gpio-io-resource-quirks.patch
+gregkh-pci-pci-turn-pci_fixup_video-into-generic-for-embedded-vga.patch
+gregkh-pci-altix-add-initial-acpi-io-support.patch
+gregkh-pci-altix-sn-acpi-hotplug-support.patch
+gregkh-pci-altix-rom-shadowing.patch

 PCI tree updates.

+revert-gregkh-pci-altix-rom-shadowing.patch
+revert-gregkh-pci-altix-sn-acpi-hotplug-support.patch
+revert-gregkh-pci-altix-add-initial-acpi-io-support.patch

 Revert some build-breakers from the PCI tree.

+pci-optionally-sort-device-lists-breadth-first.patch
+pci-optionally-sort-device-lists-breadth-first-tweaks.patch
+pci-optionally-sort-device-lists-breadth-first-force-on.patch

 Fiddle with PCI device discovery ordering.

+revert-pci-assign-ioapic-resource-at-hotplug.patch

 Revert bad PCI patch which went into mainline.

-git-block-vs-git-sas.patch

 Unneeded.

-aic7xxx-deinline-large-functions-save-80k-of-text.patch
-aic7xxx-s-__inline-inline.patch
-aic7xxx-fix-byte-i-o-order-in-ahd_inw.patch
-drivers-scsi-aic7xxx-possible-cleanups-2.patch

 Dropped due to randomness in scsi land.

+ioremap-balanced-with-iounmap-drivers-scsi-zalonc.patch
+ioremap-balanced-with-iounmap-drivers-scsi-sun3_scsic.patch
+ioremap-balanced-with-iounmap-drivers-scsi-sun3_scsi_vmec.patch
+ioremap-balanced-with-iounmap-drivers-scsi-seagatec.patch
+ioremap-balanced-with-iounmap-drivers-scsi-qlogicptic.patch
+ioremap-balanced-with-iounmap-drivers-scsi-nsp32c.patch
+ioremap-balanced-with-iounmap-drivers-scsi-ncr53c8xxc.patch
+ioremap-balanced-with-iounmap-drivers-scsi-fdomainc.patch
+ioremap-balanced-with-iounmap-drivers-scsi-amiga7xxc.patch
+ioremap-balanced-with-iounmap-drivers-scsi-3w-9xxxc.patch
+scsi-convert-ninja-driver-to-struct-scsi_cmnd.patch
+scsi-convertion-to-struct-scsi_cmnd-in-ips-driver.patch
+fc4-conversion-to-struct-scsi_cmnd-in-fc4.patch
+dereference-in-drivers-scsi-lpfc-lpfc_ctc.patch
+scsi-scsi_cmnd-convertion-in-arm-subtree.patch

 scsi driver fixlets.

+gregkh-usb-usb-storage-unusual_devs.h-entry-for-sony-ericsson-p990i.patch
+gregkh-usb-usb-wacom-driver-updates.patch
+gregkh-usb-usb-bug_on-conversion-for-wacom.c.patch
+gregkh-usb-usb-remove-private-debug-macros-from-kaweth.patch

 USB tree updates.

+usb-serial-mos7840-fix-cast.patch
+sound-usb-usbaudio-handle-return-value-of-usb_register.patch

 USB fixes.

+git-watchdog-fixup.patch

 Fix rejects in git-watchdog.patch

+atmel-wireless-output-signal-strength-information.patch
+orinoco-fix.patch
+possible-dereference-in-drivers-net-wireless-zd1201c.patch
+more-we-21-potential-overflows.patch

 Various wireless fixes.

+x86_64-mm-calgary-init.patch
+x86_64-mm-calgary-off-by-one.patch
+x86_64-mm-calgary-jon-contact.patch
+x86_64-mm-calgary-hex-bus.patch
+x86_64-mm-pci-bios-fix.patch
+x86_64-mm-kernel-stack-termination.patch

 x86 tree updates.

+fix-x86_64-mm-kernel-stack-termination.patch
+insert-local-and-io-apics-into-resource-map.patch
+x86_64-dump_trace-atomicity-fix.patch
+spinlock-debug-all-cpu-backtrace.patch
+spinlock-debug-all-cpu-backtrace-fix.patch
+spinlock-debug-all-cpu-backtrace-fix-2.patch
+spinlock-debug-all-cpu-backtrace-fix-3.patch

 x86 things.

-mm-thrash-detect-process-thrashing-against-itself.patch

 Dropped.

+mm-fix-in-kerneldoc.patch

 kerneldoc fix.

+get-rid-of-zone_table-fix-2.patch
+get-rid-of-zone_table-fix-4.patch
+get-rid-of-zone_table-fix-3.patch

 Fix get-rid-of-zone_table.patch some more.

-optional-zone_dma-for-i386.patch
-optional-zone_dma-for-x86_64.patch

 Dropped.

+set-config_zone_dma-for-arches-with-generic_isa_dma.patch

 Fix the ZONE_DMA-removal patches some more.

+slab-clean-up-leak-tracking-ifdefs-a-little-bit.patch
+kmemdup-introduce-vs-slab-clean-up-leak-tracking-ifdefs-a-little-bit.patch
+slab-reduce-numa-text-size.patch
+slab-reduce-numa-text-size-tidy.patch

 slab updates.

+swap-token-try-to-grab-swap-token-before-the-vm-selects-pages-for-eviction.patch
+swap-token-new-scheme-to-preempt-token.patch
+swap-token-new-scheme-to-preempt-token-tidy.patch

 Play with the swap-token code.

+tiacx-fix-attribute-packed-warnings-fix.patch

 Fix acx1xx-wireless-driver.patch

+frv-permit-large-kmalloc-allocations.patch

 FRV update.

+swsusp-debugging-doc.patch
+swsusp-add-ioctl-for-swap-files-support.patch
+swsusp-add-ioctl-for-swap-files-support-fix.patch
+swsusp-update-userland-interface-documentation.patch

 swsusp udpates: it allegedly supports swapfiles now.

+create-kallsyms_lookup_size_offset.patch
+low-performance-of-lib-sortc.patch
+generic-bug-handling.patch
+use-generic-bug-for-i386.patch
+use-generic-bug-for-x86-64.patch
+use-generic-bug-for-powerpc.patch
+use-generic-bug-for-powerpc-fix-2.patch
+bug-test-1.patch
+adds-carta_random32-library-routine.patch
+char-kill-unneeded-memsets.patch
+char-serial167-remove-useless-tty-check.patch
+kernel-doc-for-kernel-dmac.patch
+kernel-doc-for-kernel-resourcec.patch
+fs-eventpoll-error-handling-micro-cleanup.patch
+ipmi-fix-uninitd-data-bug.patch
+drivers-char-ip2-kill-unused-code-label.patch
+schedule-ftape-removal.patch
+isdn-warning-fixes.patch
+restore-parport_pc-probing-on-powermac.patch
+add-pekka-to-credits.patch
+ipmi-allow-user-to-override-the-kernel-ipmi-daemon-enable.patch
+ipmi-allow-user-to-override-the-kernel-ipmi-daemon-enable-tidy.patch
+ia64-note-requirement-for-8250_pnp-now-that-8250_acpi-is-gone.patch
+maintainers-removes-duplicated-entry.patch
+pktcdvd-replace-pktcdvd-strings-with-macro-driver_name.patch
+pktcdvd-rename-a-variable-for-better-readability.patch
+remove-unnecessary-check-in-fs-reiserfs-inodec.patch
+add-unifdef-to-gitignore.patch
+fix-spurious-error-on-tags-target-when-missing-defconfig.patch

 Misc.

+pata_hpt366-fix-typo.patch

 PATA fix.

+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-fscache-fix-gfp_t-sparse-annotations.patch

 cachefiles sparse annotations.

+fscache-kconfig-tidying.patch

 Kconfig cleanup.

+char-mxser_new-use-__devinit-macros.patch
+char-mxser_new-pci_request_region-for-pci-regions.patch
+char-mxser_new-check-request_region-retvals.patch
+char-mxser_new-kill-unneeded-memsets.patch

 More updates for the new mxser driver.

+knfsd-add-nfs-export-support-to-tmpfs.patch
+knfsd-lockd-fix-refount-on-nsm.patch
+knfsd-fix-auto-sizing-of-nfsd-request-reply-buffers.patch
+knfsd-close-a-race-opportunity-in-d_splice_alias.patch
+knfsd-nfsd-store-export-path-in-export.patch
+knfsd-nfsd4-fslocations-data-structures.patch
+knfsd-nfsd4-fslocations-data-structures-nfsd4-fix-fs-locations-bounds-checking.patch
+knfsd-nfsd4-fslocations-data-structures-nfsd4-fslocs-fix-compile-in-non-config_nfsd_v4-case.patch
+knfsd-nfsd4-xdr-encoding-for-fs_locations.patch
+knfsd-nfsd4-actually-use-all-the-pieces-to-implement-referrals.patch

 knfsd updates

-sched-remove-unnecessary-sched-group-allocations-fix.patch

 Folded into sched-remove-unnecessary-sched-group-allocations.patch

-lower-migration-thread-stop-machine-prio.patch

 Nacked.

+ecryptfs-enable-plaintext-passthrough.patch

 ecryptfs update.

+ide-more-pci_find-cleanup.patch
+ide-cs-compactflash-driver-rm-irq-warning.patch

 IDE updates.

+md-fix-duplicity-of-levels-in-mdtxt.patch
+md-remove-max_md_devs-which-is-an-arbitrary-limit.patch
+md-remove-experimental-classification-from-raid5-reshape.patch
+md-use-ffz-instead-of-find_first_set-to-convert-multiplier-to-shift.patch
+md-allow-set_bitmap_file-to-work-on-64bit-kernel-with-32bit-userspace.patch
+md-add-error-reporting-to-superblock-write-failure.patch

 RAID updates.

+genirq-clean-up-irq-flow-type-naming.patch

 genirq cleanup.

+kevent-core-files.patch
+kevent-core-files-fix.patch
+kevent-core-files-s390-hack.patch
+kevent-poll-select-notifications.patch
+kevent-socket-notifications.patch
+kevent-socket-notifications-fix-2.patch
+kevent-socket-notifications-fix-4.patch
+kevent-timer-notifications.patch

 Evgeniy's kevent feature.

+fdtable-make-fdarray-and-fdsets-equal-in-size-slim.patch

 SLIM driver update.

+squash-ipc-warnings.patch
+squash-transmeta-warnings.patch
+squash-tcp-warnings.patch
+squash-udf-warnings.patch

 Shut up a few warnings.



All 871 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm3/patch-list


