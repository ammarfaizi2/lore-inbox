Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWDDIqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWDDIqD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 04:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWDDIqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 04:46:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932310AbWDDIp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 04:45:59 -0400
Date: Tue, 4 Apr 2006 01:45:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc1-mm1
Message-Id: <20060404014504.564bf45a.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm1/


- VGA on ia64 is broken - the screen comes up blank.  But ia64 otherwise
  seems to work OK.  I didn't have time to investigate.

- Linus is out of town until the weekend - his net connectedness is
  uncertain.

- I dropped the old kgdb patch and picked up a new version for x86 only from
  kgdb.linsyssoft.com.  It works much better, but disagrees violently with
  gcc-4.2 for some reason.




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



Changes since 2.6.16-mm2:


 git-acpi.patch
 git-agpgart.patch
 git-cfq.patch
 git-cpufreq.patch
 git-dvb.patch
 git-infiniband.patch
 git-intelfb.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-sas-jg.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-frv.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees.

-rtc-remove-rtc-uip-synchronization-on-x86.patch
-rtc-remove-rtc-uip-synchronization-on-x86_64.patch
-rtc-remove-rtc-uip-synchronization-on-sparc64.patch
-rtc-remove-rtc-uip-synchronization-on-ppc-chrp-arch-ppc.patch
-rtc-remove-rtc-uip-synchronization-on-chrp-arch-powerpc.patch
-rtc-remove-rtc-uip-synchronization-on-ppc-maple.patch
-rtc-remove-rtc-uip-synchronization-on-arm.patch
-rtc-remove-rtc-uip-synchronization-on-mips-mc146818.patch
-rtc-remove-rtc-uip-synchronization-on-mips-based-dec.patch
-rtc-remove-rtc-uip-synchronization-on-sh03.patch
-rtc-remove-rtc-uip-synchronization-on-sh-mpc1211.patch
-rtc-remove-rtc-uip-synchronization-on-alpha.patch
-rtc-fix-up-some-rtc-whitespace-and-style.patch
-rtc-remove-some-duplicate-bcd-definitions.patch
-git-acpi-up-fix.patch
-pnpacpi-fix-non-memory-address-space-descriptor-handling.patch
-pnpacpi-remove-some-code-duplication.patch
-pnpacpi-whitespace-cleanup.patch
-acpi-request-correct-fixed-hardware-resource-type-mmio-vs-i-o-port.patch
-acpi-add-acpi-to-motherboard-resources-in-proc-iomemport.patch
-acpi-update-asus_acpi-driver-registration.patch
-acpi-fix-sonypi-acpi-driver-registration.patch
-acpi-make-acpi_bus_register_driver-return-success-failure-not-device-count.patch
-acpi-simplify-scanc-coding.patch
-acpi-print-wakeup-device-list-on-same-line-as-label.patch
-acpi-fix-memory-hotplug-range-length-handling.patch
-hpet-fix-acpi-memory-range-length-handling.patch
-acpi_os_acquire_object-gfp_kernel-called-with-irqs.patch
-acpi-remove-__init-__exit-from-asus-add-remove-methods.patch
-acpi-signedness-fix-2.patch
-acpi-should-depend-on-not-select-pci.patch
-acpi-ec-acpi-ecdt-uid-hack.patch
-remove-entries-in-sys-firmware-acpi-for-processor-also.patch
-remove-unnecessary-lapic-definition-from-acpidefh.patch
-catch-notification-of-memory-add-event-of-acpi-via-container-driver-register-start-func-for-memory-device-tidy.patch
-catch-notification-of-memory-add-event-of-acpi-via-container-driveravoid-redundant-call-add_memory-tidy.patch
-kernel-crash-in-powernow-k8-after-lost-ticks-detected.patch
-drm-sis-fix-compile-warning.patch
-remove-drm_allocfree_pages.patch
-ia64-sn_hwperf-eliminate-use-of-num_online_cpus.patch
-input-adds-snes-mouse-support-to-gamecon.patch
-m25p80-printk-warning-fix.patch
-sem2mutex-mtd-doc2000c.patch
-sem2mutex-drivers-mtd.patch
-drivers-mtd-small-cleanups.patch
-mtd_nand_sharpsl-and-mtd_nand_nandsim-should-be-tristates.patch
-drivers-mtd-use-array_size-macro.patch
-mtd-cmdlinepart-allow-zero-offset-value.patch
-fix-debug-statement-in-inftlcorec.patch
-kill-ifdefs-in-mtdcorec.patch
-kill-ifdefs-in-mtdcorec-fix.patch
-dead-code-in-mtd-maps-pcic.patch
-add-chip-used-in-collie-to-jedec_probe.patch
-mtd-redboot-handle-holes-in-fis-table.patch
-mtd-fix-broken-name_to_dev_t-declaration.patch
-drivers_mtd_maps_vmax301c-fix-off-by-one-vmax_mtd.patch
-natsemi-support-oversized-eeproms.patch
-net-remove-config_net_cbus-conditional-for-ns8390.patch
-com90xx-kmalloc-fix.patch
-netfilter-rename-init-functions.patch
-net-fix-appletalk-compat_ioctl-oopses.patch
-deinline-200-byte-inlines-in-sockh.patch
-deinline-some-larger-functions-from-netdeviceh.patch
-git-powerpc-warn-was-a-dumb-idea.patch
-git-serial.patch
-serial-mystery-kbuild-fix.patch
-git-sym2.patch
-fix-pcmcia_device_remove-oops.patch
-aacraid-fix-the-comparison-with-sizeof.patch
-x86_64-mm-hangcheck-remove-message.patch
-x86_64-mm-lost-cli-debug.patch
-x86_64-mm-sis-agp.patch
-x86_64-mm-acpi-nolapic.patch
-x86_64-mm-extra-nodes_shift-definition.patch
-x86_64-mm-hotadd-reserve-fix.patch
-git-xfs-vn_to_inode-fix.patch
-mm-schedule-find_trylock_page-removal.patch
-remove-long-dead-i386-floppy-asm-code.patch
-i386-kdump-timer-vector-lockup-fix.patch
-uml-hotplug-memory-take-2.patch
-decrapify-asm-generic-localh.patch
-mark-unwind-info-for-signal-trampolines-in-vdsos.patch
-locks-dont-panic.patch
-document-linuxs-memory-barriers.patch
-synclink-remove-dead-code.patch
-synclink_gt-add-gpio-feature.patch
-synclink_gt-remove-uneeded-async-code.patch
-let-blk_dev_ram_count-depend-on-blk_dev_ram.patch
-kill-__init_timer_base-in-favor-of-boot_tvec_bases.patch
-__mod_timer-simplify-base-changing.patch
-paride-register_chrdev-fix.patch
-paride-pt-register_chrdev-fix.patch
-capi-register_chrdev-fix.patch
-symversion-warning-fix.patch
-simplify-proc-devices-and-fix-early-termination-regression.patch
-simplify-proc-devices-and-fix-early-termination-regression-tidy.patch
-simplify-proc-devices-and-fix-early-termination-regression-tidy-2.patch
-simplify-proc-devices-and-fix-early-termination-regression-tidy-3.patch
-dont-pass-boot-parameters-to-argv_init.patch
-add-oprofile_add_ext_sample.patch
-alpha-make-poll-flags-thesame-as-other-architectures.patch
-mqueue-comment-fix-fix.patch
-change-dash2underscore-return-value-to-char.patch
-drivers-block-paride-pdc-fix-an-off-by-one-error.patch
-fs-fat-proper-prototypes-for-two-functions.patch
-philip-gladstone-has-moved.patch
-edac_752x-needs-config_hotplug.patch
-make-tty_insert_flip_char-a-non-gpl-export.patch
-ipmi-fix-startup-race-condition.patch
-ipmi-fix-startup-race-condition-tidy.patch
-ipmi-tidy-up-various-things.patch
-ipmi-convert-from-semaphores-to-mutexes.patch
-mutex-some-cleanups.patch
-remove-relayfs_fsh.patch
-drivers-block-acsi_slmc-size_t-cant-be-0.patch
-autofs4-proper-prototype-for-autofs4_dentry_release.patch
-exec-allow-init-to-exec-from-any-thread.patch
-simplify-exec-from-inits-subthread.patch
-remove-dead-kill_sl-prototype-from-schedh.patch
-do_tty_hangup-use-group_send_sig_info-not.patch
-do_sak-dont-depend-on-session-id-0.patch
-pidhash-kill-switch_exec_pids.patch
-choose_new_parent-remove-unused-arg-sanitize-exit_state-check.patch
-remove-add_parents-parent-argument.patch
-dont-use-remove_links-set_links-for-reparenting.patch
-kill-set_links-remove_links.patch
-pidhash-dont-count-idle-threads.patch
-pidhash-dont-use-zero-pids.patch
-reparent_thread-use-remove_parent-add_parent.patch
-wait_for_helper-trivial-style-cleanup.patch
-release_task-replace-open-coded-ptrace_unlink.patch
-convert-sighand_cache-to-use-slab_destroy_by_rcu.patch
-introduce-lock_task_sighand-helper.patch
-introduce-sig_needs_tasklist-helper.patch
-copy_process-cleanup-bad_fork_cleanup_sighand.patch
-copy_process-cleanup-bad_fork_cleanup_signal.patch
-cleanup-__exit_signal.patch
-rename-__exit_sighand-to-cleanup_sighand.patch
-move-__exit_signal-to-kernel-exitc.patch
-revert-optimize-sys_times-for-a-single-thread-process.patch
-do-__unhash_process-under-siglock.patch
-sys_times-dont-take-tasklist_lock.patch
-relax-sig_needs_tasklist.patch
-do_signal_stop-dont-take-tasklist_lock.patch
-do_group_exit-dont-take-tasklist_lock.patch
-do_sigaction-dont-take-tasklist_lock.patch
-pids-kill-pidtype_tgid.patch
-make-fork-atomic-wrt-pgrp-session-signals.patch
-cleanup-__exit_signal-cleanup_sighand-path.patch
-simplify-do_signal_stop.patch
-finish_stop-dont-check-stop_count-0.patch
-do_notify_parent_cldstop-remove-to_self-param.patch
-send_sigqueue-simplify-and-fix-the-race.patch
-permit-dual-mit-gpl-licenses.patch
-led-class-documentation.patch
-led-add-led-class.patch
-led-add-led-trigger-support.patch
-led-add-led-timer-trigger.patch
-led-add-sharp-charger-status-led-trigger.patch
-led-add-led-device-support-for-the-zaurus-corgi-and.patch
-led-add-led-device-support-for-locomo-devices.patch
-led-add-led-device-support-for-ixp4xx-devices.patch
-led-add-device-support-for-tosa.patch
-led-add-nand-mtd-activity-led-trigger.patch
-led-add-ide-disk-activity-led-trigger.patch
-ensure-ide-taskfile-calls-any-driver-specific.patch
-hrtimer-create-generic-sleeper.patch
-hrtimer-use-generic-sleeper-for-nanosleep.patch
-sched-cleanup_task_activated.patch
-sched-make_task_noninteractive_use_sleep_type.patch
-sched-dont_decrease_idle_sleep_avg.patch
-sched-include_noninteractive_sleep_in_idle_detect.patch
-sched-remove-on-runqueue-requeueing.patch
-sched-activate-sched-batch-expired.patch
-sched-reduce-overhead-of-calc_load.patch
-sched-fix-interactive-task-starvation.patch
-futex-check-and-validate-timevals.patch
-rtc-m41t00-driver-should-use-workqueue-instead-of-tasklet.patch
-rtc-m41t00-driver-cleanup.patch
-rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch
-trivial-cleanup-to-proc_check_chroot.patch
-resurrect-__put_task_struct.patch
-task-rcu-protect-task-usage.patch
-make-setsid-more-robust.patch
-dcache-add-helper-d_hash_and_lookup.patch
-pidhash-refactor-the-pid-hash-table.patch
-ide-amd756-no-host-side-cable-detection.patch
-small-fixes-backported-to-old-ide-sis-driver.patch
-ide_generic_all_on-warning-fix.patch
-fbcon-save-current-display-during-initialization.patch
-w100fb-add-acceleration-support-to-ati-imageon.patch
-backlight-backlight-class-improvements.patch
-backlight-hp-jornada-680-backlight-driver-updates-fixes.patch
-backlight-corgi_bl-generalise-to-support-other-sharp.patch
-pxafb-minor-driver-fixes.patch
-fbcon-fix-big-endian-bogosity-in-slow_imageblit.patch
-optimize-select-poll-by-putting-small-data-sets-on-the-stack.patch
-use-fget_light-in-select-poll.patch
-fold-select_bits_alloc-free-into-caller-code.patch
-ia64-const-f_ops-fix.patch
-mark-f_ops-const-in-the-inode.patch
-make-most-file-operations-structs-in-fs-const.patch
-docs-update-missing-files-and-descriptions-for-filesystems-00-index.patch
-arch-i386-kernel-microcodec-remove-the-obsolete-microcode_ioctl.patch
-drivers-block-use-time_after-and-friends.patch
-nvidia-agp-use-time_before_eq.patch
-ide-tape-use-time_after-time_after_eq.patch
-drivers-scsi-use-time_after-and-friends.patch
-replace-0xff-with-correct-dma_xbit_mask.patch
-vfree-null-check-fixup-for-sb_card.patch
-maestro3-vfree-null-check-fixup.patch
-no-need-to-check-vfree-arg-for-null-in-oss-sequencer.patch
-vfree-does-its-own-null-check-no-need-to-be-explicit-in-oss-msndc.patch
-fix-signed-vs-unsigned-in-nmi-watchdog.patch
-trivial-typos-in-documentation-cputopologytxt.patch
-typos-grab-bag-of-the-month.patch
-unexport-get_wchan.patch
-fs-nameic-make-lookup_hash-static.patch
-decrease-number-of-pointer-derefs-in-jsm_ttyc.patch
-sound-remove-unneeded-kmalloc-return-value-casts.patch

 Merged into mainline or a subsystem tree

+selinux-build-fix.patch
+sched-fix-interactive-task-starvation.patch
+dont-awaken-rt-tasks-on-expired-array.patch
+select-warning-fixes.patch
+fix-null-pointer-dereference-in-node_read_numastat.patch
+dmi-move-dmi_scanc-from-arch-i386-to-drivers-firmware.patch
+config_net=n-build-fix.patch
+drm_pci-needs-dma-mappingh.patch

 2.6.17-rc2 queue (part thereof, many more 2.6.17 patches below)

+acpi-update-asus_acpi-driver-registration-fix.patch

 ACPI fix

+for_each_possible_cpu-under-drivers-acpi.patch
+acpi_bus_unregister_driver-make-void.patch
+acpi_os_wait_semaphore-dont-complain-about-timeout.patch

 ACPI updates

+for_each_possible_cpu-for-arm.patch

 ARM for_each_cpu() conversion.

+powernow-k8-crash-workaround.patch

 cpufreq non-fix.

+gregkh-driver-driver-core-safely-unbind-drivers-for-devices-not-on-a-bus.patch
+gregkh-driver-block-delay-all-uevents-until-partition-table-is-scanned.patch

 Driver tree updates.

-revert-gregkh-driver-fix-up-the-sysfs-pollable-patch.patch

 Dropped.

+spi-whitespace-fixes.patch
+spi-bounce-buffer-has-a-minimum-length.patch
+spi-add-david-as-the-spi-subsystem-maintainer.patch
+spi-renamed-bitbang_transfer_setup-to-spi_bitbang_setup_transfer.patch
+spi-busnum-==-0-needs-to-work.patch
+spi-devices-can-require-lsb-first-encodings.patch

 SPI updates.

+driver-core-fix-unnecessary-null-check-in-drivers-base-classc.patch

 driver core cleanup.

+drm-fix-issue-reported-by-coverity-in-drivers-char-drm-via_irqc.patch

 DRM fix.

+avermedia-6-eyes-avs6eyes-support.patch
+bt866-build-fix.patch

 New v4l driver, and a fix.

+gregkh-i2c-rtc-ds1374-convert-tasklet-to-workqueue.patch
+gregkh-i2c-rtc-m41t00-driver-should-use-workqueue-instead-of-tasklet.patch
+gregkh-i2c-hwmon-w83792d-quiet-on-misdetection.patch
+gregkh-i2c-i2c-sis96x-remove-init-log-message.patch
+gregkh-i2c-i2c-parport-require-type-parameter.patch
+gregkh-i2c-hwmon-lm83-add-lm82-support.patch
+gregkh-i2c-hwmon-w83627ehf-add-voltages.patch
+gregkh-i2c-hwmon-w83627ehf-add-alarms.patch
+gregkh-i2c-hwmon-smsc47m192-new-driver.patch
+gregkh-i2c-hwmon-f71805f-no-global-resource.patch
+gregkh-i2c-hwmon-sysfs-interface-individual-alarm-files.patch
+gregkh-i2c-i2c-piix4-add-ati-smbus-support.patch
+gregkh-i2c-rtc-m41t00-driver-cleanup.patch
+gregkh-i2c-w1-added-default-generic-read-write-operations.patch
+gregkh-i2c-w1-replace-dscore-and-ds_w1_bridge-with-ds2490-driver.patch
+gregkh-i2c-w1-userspace-communication-protocol-over-connector.patch
+gregkh-i2c-w1-move-w1-connector-definitions-into-linux-include-connector.h.patch
+gregkh-i2c-w1-netlink-mark-netlink-group-1-as-unused.patch

 I2C tree.

+connector-exports.patch
+w1-exports.patch

 Fix things in Greg's trees.

+scx200_acb-fix-for-cs5535-eratta.patch
+scx200_acb-use-pci-i-o-resource-when-appropriate.patch

 i2c driver updates.

+for_each_possible_cpu-ia64.patch

 ia64 for_each_cpu() conversion.

+wistron_btns-add-support-for-amilo-7400m.patch

 Additional device support.

+sata_mv-properly-print-hc-registers.patch

 SATA fix.

+for_each_possible_cpu-mips.patch

 MIPS for_each_cpu() conversion.

-pci-error-recovery-e1000-network-device-driver-tidy.patch

 Folded into pci-error-recovery-e1000-network-device-driver.patch

+e1000-prevent-statistics-from-getting-garbled-during-reset.patch
+net-drivers-fix-section-attributes-for-gcc.patch

 netdev fixes.

+for_each_possible_cpu-network-codes.patch

 net for_each_cpu() conversion.

+netfilter-fix-fragmentation-issues-with-bridge-netfilter.patch
+ebtables-fix-allocation-in-net-bridge-netfilter-ebtablesc.patch

 net fixes.

+gregkh-pci-msi-save-restore-for-suspend-resume.patch
+gregkh-pci-pci_ids.h-correct-naming-of-1022-7450.patch
+gregkh-pci-pci-fix-sparse-warning-about-pci_bus_flags.patch
+gregkh-pci-pci-rpaphp-remove-init-error-condition.patch
+gregkh-pci-re-arch-i386-pci-irq.c-new-via-chipsets.patch
+gregkh-pci-pci-add-pci-quirk-for-smbus-on-the-asus-a6va-notebook.patch

 PCI tree updates.

+64-bit-resources-drivers-pci-changes-sparc32-fix.patch

 Fix 64-bit-resources-drivers-pci-changes.patch.

+64-bit-resources-arch-powerpc-changes.patch
+64-bit-resources-more-drivers-others-changes.patch
+64-bit-resources-more-sound-changes.patch

 Updates to the 64-bit resource patches.

+for_each_possible_cpu-sparc.patch
+for_each_possible_cpu-sparc64.patch

 for_each_cpu() conversions.

+gregkh-usb-usb-net2282-and-net2280-software-compatibility.patch
+gregkh-usb-usb-cleanups-for-ohci-s3c2410.c.patch
+gregkh-usb-usb-ftdi_sio-add-support-for-eclo-com-to-1-wire-usb-adapter.patch
+gregkh-usb-usb-g_file_storage-set-short_not_ok-for-bulk-out-transfers.patch
+gregkh-usb-usb-g_file_storage-add-comment-about-buffer-allocation.patch
+gregkh-usb-usb-serial-converts-port-semaphore-to-mutexes.patch
+gregkh-usb-usb-pci-quirks.c-proper-prototypes.patch
+gregkh-usb-usb-input-proper-prototypes.patch
+gregkh-usb-usb-add-support-for-papouch-tmu.patch
+gregkh-usb-usb-usbtouchscreen-unified-usb-touchscreen-driver.patch
+gregkh-usb-usb-g_file_storage-use-module_param_array_named-macro.patch
+gregkh-usb-usb-wacom-tablet-driver-update.patch
+gregkh-usb-usb-add-new-wacom-devices-to-usb-hid-core-list.patch
+gregkh-usb-usb-pegasus-driver-bugfix.patch

 USB tree updates.

+hid-corec-fix-input-irq-status-32-received-for-silvercrest-usb-keyboard.patch

 USB fix.

+softmac-uses-wiress-ext.patch

 Wireless fix.

+x86_64-mm-execve-cleanup.patch
+x86_64-mm-clustered-check.patch
+x86_64-mm-nodes-shift-dummy.patch
+x86_64-mm-mce-nmi-watchdog.patch
+x86_64-mm-i386-up-generic-arch.patch
+x86_64-mm-i386-bigsmp-fadt.patch
+x86_64-mm-force-iret.patch
+x86_64-mm-strlen-export.patch
+x86_64-mm-hpet-return.patch
+x86_64-mm-vsmp-cache-boundary.patch
+x86_64-mm-mcfg-check-more-busses.patch
+x86_64-mm-mmconfig-error-value.patch
+x86_64-mm-memset-always-inline.patch
+x86_64-mm-hpet-drift.patch
+x86_64-mm-gs-leak.patch
+x86_64-mm-fix-config_reorder.patch

 x86_64 updates.

+arm-add_memory-build-fix.patch

 They broke arm.

+for_each_possible_cpu-x86_64.patch

 x86_64 for_each_cpu() conversion.

+for_each_possible_cpu-xfs.patch

 XFS for_each_cpu() conversion.

+mm-posix-memory-lock.patch
+slab-allocate-node-local-memory-for-off-slab-slabmanagement.patch
+slab-add-statistics-for-alien-cache-overflows.patch
+nommu-use-compound-page-in-slab-allocator.patch
+mm-fix-bug-in-brk.patch

 MM updates.

+frv-define-mmu-mode-specific-syscalls-as-cond_syscall-and-clean-up-unneeded-macros.patch

 FRV fix.

+x86-clean-up-subarch-definitions.patch
+x86-clean-up-subarch-definitions-update.patch
+arch-i386-kernel-apicc-make-modern_apic-static.patch
+enable-tsc-for-amd-geode-gx-lx.patch
+swsusp-dont-require-bigsmp.patch
+i386-print-eip-esp-last.patch
+menu-relocate-doublefault-option.patch

 x86 updates.

-swsusp-resume-parsing-fix.patch

 Dropped.

+uml-tls-fixlets.patch

 UML fix.

+s390-update-default-configuration.patch
+s390-ebdic-to-ascii-conversion-tables.patch
+s390-invalid-check-after-kzalloc.patch
+s390-wrong-return-codes-in-cio_ignore_proc_init.patch
+s390-increase-cio_trace-debug-event-size.patch
+s390-dasd-device-offline-messages.patch
+s390-fail-fast-requests-on-quiesced-devices.patch
+s390-dasd-proc-entries.patch
+s390-minor-tape-fixes.patch
+s390-fix-implicit-declaration-of-unlikely.patch

 s390 updates.

+hdaps-add-support-for-thinkpad-r52.patch
+configurable-nodes_shift.patch
+ext3-block-allocation-reservation-fixes-to-support.patch
+ext3-ext3-in-kernel-block-number-type-fixes.patch
+ext3-ext3-in-kernel-block-number-type-fixes-fix.patch
+unify-pxm_to_node-and-node_to_pxm.patch
+no-arch-specific-strpbrk-implementations.patch
+clean-up-arch-overrides-in-linux-stringh.patch
+sync_file_range-use-unsigned-for-flags.patch
+timer-initialisation-fix.patch
+timer-initialisation-fix-tidy.patch
+avoid-tasklist_lock-at-getrusage-for-multithreaded-case-too.patch
+the-scheduled-unexport-of-panic_timeout.patch
+s3c24xx-gpio-led-support.patch
+s3c24xx-gpio-led-support-tidy.patch
+leds-fix-ide-disk-trigger-name.patch
+leds-reorganise-kconfig.patch
+leds-re-layout-include-linux-ledsh.patch
+vfs-propagate-mnt_flags-into-do_loopback-vfsmount.patch
+build-kernel-irq-migrationc-only-if-config_generic_pending_irq-is-set.patch
+remove-sys_-prefix-of-new-syscalls-from-__nr_sys_.patch
+add-prctl-to-change-endian-of-a-task.patch
+#writeback-fix-range-handling.patch
+make-tty_insert_flip_string_flags-a-non-gpl-export.patch
+memory_hotplugh-cleanup.patch
+9p-handle-sget-failure.patch
+remove-extraneous-n-in-doubletalk-init-printk.patch
+missing-n-in-sc1200wdt-driver.patch
+reinstate-const-in-next_thread.patch
+select-dont-overflow-if-select_stack_alloc-%-sizeoflong-=-0.patch
+silence-a-const-vs-non-const-warning.patch
+kdump-proc-vmcore-size-oveflow-fix.patch
+hdaps-support-new-lenovo-machines.patch
+fix-dcache-race-during-umount.patch
+prune_one_dentry-tweaks.patch
+uniform-pollrdhup-handling-between-epoll-and-poll-select.patch
+add-cpu_relax-to-hrtimer_cancel.patch

 Misc.

+introduce-hlist_move_head.patch
+use-hlist_move_head.patch
+use-list_add_tail-instead-of-list_add.patch
+use-list_add_tail-instead-of-list_add-fix.patch
+arch-use-list_move.patch
+core-use-list_move.patch
+net-rxrpc-use-list_move.patch
+drivers-use-list_move.patch
+fs-use-list_move.patch

 list.h cleanups.

+rtc-subsystem-ds1672-oscillator-handling.patch
+rtc-subsystem-ds1672-cleanup.patch
+rtc-subsystem-x1205-sysfs-cleanup.patch
+rtc-subsystem-whitespaces-and-error-messages-cleanup.patch
+rtc-subsystem-fix-proc-output.patch
+rtc-subsystem-rs5c372-sysfs-fix.patch
+rtc-subsystem-compact-error-messages.patch
+rtc-subsystem-sa1100-cleanup.patch
+rtc-subsystem-vr41xx-driver.patch
+rtc-subsystem-vr41xx-cleanup.patch

 RTC system updates.

+fuse-fix-oops-in-fuse_send_readpages.patch
+fuse-fix-fuse_dev_poll-return-value.patch
+fuse-add-o_async-support-to-fuse-device.patch
+fuse-add-o_nonblock-support-to-fuse-device.patch
+fuse-simplify-locking.patch
+fuse-use-a-per-mount-spinlock.patch
+fuse-consolidate-device-errors.patch
+fuse-clean-up-request-accounting.patch
+fuse-account-background-requests.patch

 FUSE updates.

+isdn4linux-siemens-gigaset-drivers-code-cleanup.patch
+isdn4linux-siemens-gigaset-drivers-kconfig-correction.patch
+isdn4linux-siemens-gigaset-drivers-timer-usage.patch
+isdn4linux-siemens-gigaset-drivers-logging-usage.patch
+isdn4linux-siemens-gigaset-drivers-sysfs-usage.patch
+isdn4linux-siemens-gigaset-drivers-remove-ifnull-macros.patch
+isdn4linux-siemens-gigaset-drivers-uninline.patch
+isdn4linux-siemens-gigaset-drivers-elliminate-from_user-argument.patch
+isdn4linux-siemens-gigaset-drivers-mutex-conversion.patch
+isdn4linux-siemens-gigaset-drivers-remove-private-version-of-__skb_put.patch
+isdn4linux-siemens-gigaset-drivers-remove-forward-references.patch
+isdn4linux-siemens-gigaset-drivers-add-readme.patch
+isdn4linux-siemens-gigaset-drivers-make-some-variables-non-atomic.patch

 ISDN driver updates.

+knfsd-correct-reserved-reply-space-for-read-requests.patch
+knfsd-locks-flag-nfsv4-owned-locks.patch
+knfsd-nfsd4-wrong-error-handling-in-nfs4acl.patch
+knfsd-nfsd4-better-nfs4acl-errors.patch
+knfsd-nfsd4-fix-acl-xattr-length-return.patch
+knfsd-nfsd-oops-exporting-nonexistent-directory.patch
+knfsd-nfsd-nfsd_setuser-doesnt-really-need-to-modify-rqstp-rq_cred.patch
+knfsd-nfsd4-remove-nfsd_setuser-from-putrootfh.patch
+knfsd-nfsd4-fix-corruption-of-returned-data-when-using-64k-pages.patch
+knfsd-nfsd4-fix-corruption-on-readdir-encoding-with-64k-pages.patch
+knfsd-svcrpc-gss-dont-call-svc_take_page-unnecessarily.patch
+knfsd-svcrpc-warn-instead-of-returning-an-error-from-svc_take_page.patch
+knfsd-nfsd4-fix-laundromat-shutdown-race.patch
+knfsd-nfsd4-nfsd4_probe_callback-cleanup.patch
+knfsd-nfsd4-add-missing-rpciod_down.patch
+knfsd-nfsd4-limit-number-of-delegations-handed-out.patch
+knfsd-nfsd4-limit-number-of-delegations-handed-out-fix.patch
+knfsd-nfsd4-grant-delegations-more-frequently.patch

 knfsd updates.

+sched-prevent-high-load-weight-tasks-suppressing-balancing.patch
+sched-improve-stability-of-smpnice-load-balancing.patch
+sched_domain-handle-kmalloc-failure.patch
+sched_domain-dont-use-gfp_atomic.patch
+sched_domain-use-kmalloc_node.patch
+sched_domain-allocate-sched_group-structures-dynamically.patch

 CPU scheduler updates.

+pi-futex-futex-code-cleanups-fix.patch

 Fix pi-futex-futex-code-cleanups.patch

+pi-futex-rt-mutex-core-fix-timeout-race.patch

 Fix pi-futex-rt-mutex-core.patch

+pi-futex-patchset-v4.patch
+pi-futex-patchset-v4-update.patch

 PI-futex updates.

-reiser4-sb_sync_inodes-cleanup.patch
-reiser4-include-reiser4.patch
-reiser4-doc.patch
-reiser4-doc-fix-reiser4-links-in-documentation.patch
-reiser4-only.patch
-reiser4-cleanup_init_fake_inode.patch
-reiser4-only-stop-using-__put_page.patch
-reiser4-ver_linux-dont-print-reiser4progs-version-if-none-found.patch
-reiser4-fix-wundef-warnings.patch
-reiser4-swsusp-build-fix.patch
-reiser4-reboot-fix.patch
-reiser4-update-filesystems-for-new-delete_inode-behavior.patch
-reiser4-xattr-build-fix.patch
-reiser4-printk-warning-fix.patch
-reiser4-mm-remove-pg_highmem-fix.patch
-reiser4-kconfig-help-cleanup.patch
-reiser4-update.patch
-reiser4-fix-dependencies.patch
-reiser4-wundef-fix.patch
-reiser4-wundef-fix-2.patch
-reiser4-big-update.patch
-reiser4-big-update-bug-fix-for-readpage.patch
-reiser4-big-update-bug-fix-for-readpage-fix.patch
-reiser4-big-update-rename-print_address.patch
-reiser4-page-private-fixes.patch
-reiser4-big-update-div64-fix.patch
-reiser4-remove-c99isms.patch
-reiser4-use-try_to_freeze.patch
-reiser4-fix-endianess.patch
-reiser4-check-null.patch
-reiser4-fix-built_ptr.patch
-reiser4-key-init-cleanup.patch
-reiser4-fix-list_splice-usage.patch
-reiser4-big-update-spin_macros-fix.patch
-reiser4-spinlock-cleanup.patch
-reiser4-warnings-cleanup.patch
-reiser4_releasepage-gfp_t-fixes.patch
-reiser4-fix-kbuild.patch
-reiser4-remove-rwx-perm-plugin.patch
-reiser4-fix-link_common.patch
-reiser4-fix-readlink.patch
-reiser4-add-crc-sendfile.patch
-reiser4-back-to-one-makefile.patch
-reiser4-rename-cluster-files.patch
-reiser4-crypt2cipher-rename.patch
-reiser4-lock-ordering-fix.patch
-reiser4-improved-comment.patch
-reiser4-try_capture_block-update.patch
-reiser4-fix-zeroing-in-crc-files.patch
-reiser4-atime-update-fix.patch
-reiser4-big-update-update_atime-fixes.patch
-fs-reiser4-possible-cleanups.patch
-reiser4-bugfix-patch.patch
-reiser4-i_sem-mutex-switch.patch
-reiser4-do-not-use-get_user_pages-and-do-not-check.patch
+reiser4.patch
+reiser4fs-use-list_move.patch

 The reiser4 patches were all consolidated together.

+ide-claim-extra-dma-ports-regardless-of-channel.patch
+ide-remove-dma_base2-field-form-ide_hwif_t.patch
+ide-always-release-dma-engine.patch
+ide-ati-sb600-ide-support.patch
+ide-error-handling-fixes.patch
+hpt366-fix-segfault-during-init.patch

 IDE updates.

+md-dm-reduce-stack-usage-with-stacked-block-devices.patch

 MD update.

-kgdb-ga.patch
+kgdb-core-lite.patch
+kgdb-core-lite-add-reboot-command.patch
+kgdb-8250.patch
+kgdb-8250-fix.patch
+kgdb-netpoll_pass_skb_to_rx_hook.patch
+kgdb-eth.patch
+kgdb-i386-lite.patch
+kgdb-cfi_annotations.patch
+kgdb-sysrq_bugfix.patch
+kgdb-module.patch
+kgdb-core.patch
+kgdb-i386.patch

 New kgdb patchset.




All 539 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm1/patch-list

