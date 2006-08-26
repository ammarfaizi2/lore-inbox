Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWHZXJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWHZXJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 19:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWHZXJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 19:09:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3284 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751514AbWHZXJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 19:09:26 -0400
Date: Sat, 26 Aug 2006 16:09:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4-mm3
Message-Id: <20060826160922.3324a707.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/

- autofs mounting of nfs submounts remains broken.



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

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.



Changes since 2.6.18-rc4-mm2:

 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-agpgart.patch
 git-arm.patch
 git-block.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-input.patch
 git-intelfb.patch
 git-kbuild.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ocfs2.patch
 git-parisc.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-r8169.patch
 git-sas.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 git trees

-add-imacfb-documentation-and-detection.patch
-adfs-error-message-fix.patch
-initialize-parts-of-udf-inode-earlier-in-create.patch
-fix-hrtimer-percpu-usage-typo.patch
-fix-x86_64-mm-allow-users-to-force-a-panic-on-nmi.patch
-dm-bug-oops-fix.patch
-change-panic_on_oops-message-to-fatal-exception.patch
-sys_getppid-oopses-on-debug-kernel-v2.patch
-futex_handle_fault-always-fails.patch
-fbdev-include-backlighth-only-when-__kernel__-is-defined.patch
-workqueue-remove-lock_cpu_hotplug.patch
-fuse-fix-error-case-in-fuse_readpages.patch
-asus_acpi-w3000-support.patch
-acpi-change-gfp_atomic-to-gfp_kernel-for-non-atomic.patch
-sound-pci-fm801-use-array_size-macro.patch
-emu10k1x-simplify-around-pci_register_driver.patch
-gregkh-driver-add-stable-branch-to-maintainers-file.patch
-gregkh-driver-pr_debug-should-not-be-used-in-drivers.patch
-add-__must_check-to-device-management-code.patch
-add-config_enable_must_check.patch
-v4l-dev2-handle-__must_check.patch
-drivers-base-platform-notify-needs-to-occur.patch
-sysfs-add-proper-sysfs_init-prototype.patch
-drm-build-fix.patch
-git-drm-oops-fix.patch
-i2c-build-fixes-tps65010.patch
-config_pm=n-slim-drivers-scsi-sata_sil.patch
-mtd-nand-fix-ams-delta-after-core-conversion.patch
-e100-fix-mdio-mdio-x.patch
-e100-increment-version-to-3510-k4.patch
-e1000-same-cosmetic-fix-as-earlier-sent-out-for-ipv4.patch
-e1000-remove-0x1000-as-supported-device.patch
-e1000-explicitly-power-up-the-phy-during-loopback-testing.patch
-e1000-explicit-locking-for-two-ethtool-path-functions.patch
-e1000-allow-nvm-to-setup-lplu-for-igp2-and-igp3.patch
-e1000-force-full-dma-clocking-for-10-100-speed.patch
-e1000-disable-aggressive-clocking-on-esb2-with-serdes-port.patch
-e1000-increment-driver-version-to-719-k6.patch
-ixgb-add-cx4-phy-type-detection-and-subdevice-id.patch
-ixgb-fix-cache-miss-due-to-miscalculation.patch
-ixgb-increment-version-to-10109-k4.patch
-82596-section-fixes.patch
-ac3200-section-fixes.patch
-cops-section-fix.patch
-cs89x0-section-fix.patch
-at1700-section-fix.patch
-e2100-section-fix.patch
-eepro-section-fix.patch
-eexpress-section-fix.patch
-es3210-section-fix.patch
-eth16i-section-fix.patch
-lance-section-fix.patch
-lne390-section-fix.patch
-ni52-section-fix.patch
-ibmtr-section-fix.patch
-smctr-section-fix.patch
-wd-section-fix.patch
-ni65-section-fix.patch
-seeq8005-section-fix.patch
-winbond-840-section-fix.patch
-fealnx-section-fix.patch
-sundance-section-fix.patch
-freescale-qe-ucc-gigabit-ethernet-driver.patch
-s2io-build-fix.patch
-net-add-netconsole-support-to-dm9000-driver.patch
-smc911x-re-release-spinlock-on-spurious-interrupt.patch
-via-rhine-napi-support.patch
-via-rhine-napi-poll-enable.patch
-via-rhine-add-option-avoid_d3-work-around-broken-bioses-2.patch
-lockdep-fix-smc91x.patch
-build-fixes-smc91x.patch
-add-ethtool-g-support-to-spidernet-network-driver.patch
-skge-remember-to-run-netif_poll_disable.patch
-s390-fix-arp_tbl-lock-usage-in-qeth.patch
-xircom_cb-wire-up-errors-from-pci_register_driver.patch
-pal-support-of-the-fixed-phy.patch
-fs_enet-use-pal-for-mii-management.patch
-ppc32-board-specific-part-of-fs_enet-update.patch
-velocity-remove-an-unused-function-from-the-header.patch
-net-drivers-net-via-rhinec-pci_module_init-to-pci_register_driver-conversion.patch
-lockdep-fix-sk_dst_check-deadlock.patch
-ppp-handle-kmalloc-failures.patch
-xt_physdev-build-fix.patch
-fix-potential-stack-overflow-in-net-core-utilsc.patch
-net-atm-compile-error-on-arm.patch
-tg3-convert-the-pci_device_id-table-to-pci_device.patch
-gregkh-pci-pciehp-make-pciehp-build-for-powerpc.patch
-gregkh-pci-pci-remove-dead-hotplug_pci_shpc_phprm_legacy-option.patch
-gregkh-pci-pci-use-pci_bios-as-last-fallback.patch
-pci-use-pcbios-as-last-fallback.patch
-pci-i386-mmconfig-dont-forget-bus-number-when-setting-fallback_slots-bits.patch
-pci-fix-ich6-quirks.patch
-aic7-cleanup-module_parm_desc-strings.patch
-buslogic-gcc-41-warning-fixes.patch
-scsi-limit-recursion-when-flushing-shost-starved_list.patch
-sg-nopage-page-refcounting-fix.patch
-gregkh-usb-usb-unusual_devs-entry-for-a-vox-wsx-300er-mp3-player.patch
-gregkh-usb-usb-removed-a-unbalanced-endif-from-ohci-au1xxx.c.patch
-gregkh-usb-usb-appletouch-fix-atp_disconnect.patch
-gregkh-usb-usb-additional-pid-for-sharp-w-zero3.patch
-gregkh-usb-usb-ftdi_sio-driver-new-pids.patch
-gregkh-usb-usb-usbtest.c-unsigned-retval-makes-ctrl_out-return-0-in-case-of-error.patch
-x86_64-mm-i386-kprobes-error_code.patch
-x86_64-mm-re-positioning-the-bss-segment.patch
-x86_64-wire-up-oops_enter-oops_exit.patch
-kprobes-x86_64-add-kprobe_end-macro-for-popsection.patch
-git-cryptodev-padlock-generic-build-fix.patch
-git-crypto-alignment-build-fixes.patch
-fix-up-lockdep-trace-in-fs-execc.patch
-intelfbhwc-intelfbhw_get_p1p2-defined-but-not-used.patch

 Merged into mainline or a subsystem tree.

+char-moxac-fix-endianess-and-multiple-card-issues.patch
+char-moxac-fix-endianess-and-multiple-card-issues-tidy.patch
+matroxfb-fix-jittery-display-on-non-ppc-systems.patch
+vcsa-attribute-bits-ioctlvt_gethifontmask.patch
+futex_find_get_task-remove-an-obscure-exit_zombie-check.patch
+mtd-nand-fix-ams-delta-after-core-conversion.patch
+fix-for-minix-crash.patch
+ext2-prevent-div-by-zero-on-corrupted-fs.patch
+spectrum_cs-fix-firmware-uploading-errors.patch
+ext3-filesystem-bogus-enospc-with-reservation-fix.patch
+ufs-write-to-hole-in-big-file.patch
+ufs-truncate-correction.patch
+remove-redundent-up-in-stop_machine.patch
+documentation-update-for-relay-interface.patch
+eventpollc-compile-fix.patch
+md-avoid-backward-event-updates-in-md-superblock-when-degraded.patch
+md-fix-recent-breakage-of-md-raid1-array-checking.patch
+cpuset-top_cpuset-tracks-hotplug-changes-to-cpu_online_map.patch
+manage-jbd-allocations-from-its-own-slabs.patch
+manage-jbd-allocations-from-its-own-slabs-tidy.patch
+register_one_node-compile-fix.patch
+sun-disk-label-fix-signed-int-usage-for-sector-count.patch
+sun-disk-label-fix-signed-int-usage-for-sector-count-fix.patch
+config_acpi_srat-numa-build-fix.patch
+lockdep-annotate-idescsi_pc_intr.patch
+lockdep-annotate-reiserfs.patch
+fix-up-lockdep-trace-in-fs-execc.patch
+proc-meminfo-dont-put-spaces-in-names.patch
+x86-numaq-kconfig-fix.patch
+cdrom-gdsc-fix-printk-format-warning.patch

 2.6.18 queue.

+asus_acpi-fix-proc-files-parsing.patch
+asus_acpi-dont-printk-on-writing-garbage-to-proc-files.patch

 ACPI driver fixes

+agph-constify-struct-agp_bridge_dataversion.patch

 AGP cleanup

+gregkh-driver-add-__must_check-to-device-management-code.patch
+gregkh-driver-add-config_enable_must_check.patch
+gregkh-driver-v4l-dev2-handle-__must_check.patch
+gregkh-driver-drivers-base-platform-notify-needs-to-occur-before-drivers-attach-to-the-device.patch
+gregkh-driver-drivers-base-check-errors.patch
+gregkh-driver-sysfs-add-proper-sysfs_init-prototype.patch
+gregkh-driver-nozomi.patch

 driver tree updates

-drm-minor-fixes.patch

 Dropped.

+ks0127-wire-up-i2c_add_driver-return-value.patch
+drivers-media-video-bt866c-array-overflows.patch

 DVB updates

+gregkh-i2c-i2c-tps65010-build-fixes.patch
+gregkh-i2c-hwmon-abituguru-timeout-fixes.patch
+gregkh-i2c-i2c-__must_check-fixes.patch
+gregkh-i2c-i2c-__must_check-fixes-i2c-dev.patch
+gregkh-i2c-i2c-algo-sibyte-cleanups.patch
+gregkh-i2c-i2c-algo-sibyte-merge-in-i2c-sibyte.patch
+gregkh-i2c-i2c-sibyte-drop-kip-walker-address.patch
+gregkh-i2c-i2c-au1550-fix-timeout-problem.patch
+gregkh-i2c-i2c-au1550-add-smbus-functionality-flag.patch
+gregkh-i2c-i2c-au1550-add-au1200-support.patch
+gregkh-i2c-i2c-fix-copy-n-paste-in-subsystem-Kconfig.patch
+gregkh-i2c-i2c-matroxfb-c99-struct-init.patch
+gregkh-i2c-i2c-algo-bit-kill-mdelay.patch
+gregkh-i2c-i2c-bus-driver-for-TI-OMAP-boards.patch
+gregkh-i2c-i2c-isa-plan-for-removal.patch
+gregkh-i2c-i2c-stub-add-chip_addr-param.patch

 I2C tree updates

+input-i8042-get-rid-of-polling-timer.patch

 Yet another attempt at this input layer cleanup.

+git-intelfb-fixup.patch

 Fix rejects in git-intelfb.patch

+libata-add-40pin-short-cable-support-honour-drive.patch

 ATA fix

-1-of-2-jmicron-driver-hard_port_no-fix.patch

 Folded into 1-of-2-jmicron-driver.patch

+1-of-2-jmicron-driver-fix.patch

 Fix it.

+via-pata-controller-xfer-fixes-fix.patch

 Fix via-pata-controller-xfer-fixes.patch

+e1000-e1000_probe-resources-cleanup.patch

 net driver cleanup

+signedness-issue-in-drivers-net-phy-phy_devicec.patch
+b44-fix-eeprom-endianess-issue.patch
+forcedeth-decouple-vlan-and-rx-checksum-dependency.patch

 net driver fixes.

+git-net-fixup.patch

 Fix rejects in git-net.patch

+atm-he-fix-section-mismatch.patch

 ATM driver section fix.

+git-nfs-fixup.patch

 Fix rejects in git-nfs.patch

+drivers-net-pcmcia-xirc2ps_csc-remove-unused-label.patch

 PCMCIA driver cleanup.

+gregkh-pci-pci-use-pcbios-as-last-fallback.patch
+gregkh-pci-pci-i386-mmconfig-don-t-forget-bus-number-when-setting-fallback_slots-bits.patch
+gregkh-pci-pci-fix-ich6-quirks.patch
+gregkh-pci-cpci-hotplug-fix-resource-assignment.patch
+gregkh-pci-pci-kerneldoc-correction-in-pci-driver.patch

 PCI tree updates

-revert-gregkh-pci-pci-use-pci_bios-as-last-fallback.patch

 Unneeded (hopefully)

+pci-add-ich7-8-acpi-gpio-io-resource-quirks.patch

 More PCI quirks.

+signedness-issue-in-drivers-scsi-iprc.patch
+signedness-issue-in-drivers-scsi-osstc.patch

 SCSI driver fixlets.

-git-scsi-target-ibmvscsi-build-fix.patch

 Unneeded

+gregkh-usb-usb-pl2303-removed-support-for-oti-s-dku-5-clone-cable.patch
+gregkh-usb-unusual_devs-update-for-ucr-61s2b.patch
+gregkh-usb-uhci-increase-resume-detect-off-delay.patch
+gregkh-usb-usbcore-make-hcd_endpoint_disable-wait-for-queue-to-drain.patch
+gregkh-usb-usbcore-khubd-and-busy-port-handling.patch
+gregkh-usb-usb-skeleton-small-update.patch
+gregkh-usb-usb-storage-add-rio-karma-eject-support.patch

 USB tree updates.

+gregkh-usb-usb-storage-add-rio-karma-eject-support-fix.patch

 Fix it.

+turn-usb_resume_both-into-static-inline.patch
+signedness-issue-in-drivers-usb-gadget-etherc.patch
+adutux-fix-printk-format-warnings.patch
+aircable-fix-printk-format-warnings.patch

 USB fixes.

+x86_64-mm-disable-mmconfig-e820-heuristic.patch
+x86_64-mm-remove-safe_smp_processor_id.patch
+x86_64-mm-early_ioremap-warning.patch
+x86_64-mm-pte-exec.patch
+x86_64-mm-cpa-pse-cleanup.patch
+x86_64-mm-remove-apic-version-capability.patch
+x86_64-mm-cleanup-apic-id-checking.patch
+x86_64-mm-mpparse-style.patch
+x86_64-mm-nmi-irqtrace-check.patch
+x86_64-mm-fix-head.S-warning.patch
+x86_64-mm-recover-1mb.patch
+x86_64-mm-remove-e820-fallback.patch
+x86_64-mm-optimize-hweight64-for-x86_64.patch
+x86_64-mm-reload-cs-in-head.patch
+x86_64-mm-note-section.patch
+x86_64-mm-e820-comment.patch
+x86_64-mm-spin-irqs-enabled.patch
+x86_64-mm-remove-alternative-smp.patch
+x86_64-mm-i386-remove-alternative-smp.patch
+x86_64-mm-cleanup-spinlock.patch
+x86_64-mm-dmi-mmconfig-intel-sdv.patch

 x86_64 tree updates

+mm-x86_64-mm-generic-getcpu-syscall-tweaks.patch

 Cleanup

+git-cryptodev-fixup.patch
+git-cryptodev-fixup-2.patch

 Fix rejects in git-cryptodev.patch

+adix-tree-rcu-lockless-readside-fix-3.patch
+radix-tree-cleanup-radix_tree_deref_slot-and.patch
+cleanup-radix_tree_derefreplace_slot-calling-conventions.patch

 More radix-tree work.

+standardize-pxx_page-macros-fix.patch

 Fix standardize-pxx_page-macros.patch

+zvc-scale-thresholds-depending-on-the-size-of-the-system.patch
+zvc-scale-thresholds-depending-on-the-size-of-the-system-fix.patch
+extract-the-allocpercpu-functions-from-the-slab-allocator.patch
+introduce-mechanism-for-registering-active-regions-of-memory.patch
+have-power-use-add_active_range-and-free_area_init_nodes.patch
+have-x86-use-add_active_range-and-free_area_init_nodes.patch
+have-x86-use-add_active_range-and-free_area_init_nodes-fix.patch
+have-x86_64-use-add_active_range-and-free_area_init_nodes.patch
+have-ia64-use-add_active_range-and-free_area_init_nodes.patch
+account-for-memmap-and-optionally-the-kernel-image-as-holes.patch
+replace-min_unmapped_ratio-by-min_unmapped_pages-in-struct-zone.patch
+zvc-support-nr_slab_reclaimable--nr_slab_unreclaimable.patch
+zone_reclaim-dynamic-slab-reclaim.patch
+zone_reclaim-dynamic-slab-reclaim-tidy.patch

 Memory management updates

+selinux-1-3-eliminate-inode_security_set_security.patch
+selinux-2-3-change-isec-semaphore-to-a-mutex.patch
+selinux-2-3-change-isec-semaphore-to-a-mutex-vs-git-net.patch
+selinux-3-3-convert-sbsec-semaphore-to-a-mutex.patch
+selinux-fix-tty-locking.patch

 SELinux updates

+avr32-set-kbuild_defconfig.patch
+avr32-kprobes-compile-fix.patch
+avr32-asm-ioh-should-include-asm-byteorderh.patch
+avr32-fix-output-constraints-in-asm-bitopsh.patch
+avr32-standardize-pxx_page-macros-fix.patch

 Update avr32 architecture.

+x86-put-note-sections-into-a-pt_note-segment-in-vmlinux-fix.patch

 Fix x86-put-note-sections-into-a-pt_note-segment-in-vmlinux.patch

-add-force-of-use-mmconfig.patch
-add-efi-e820-memory-mapping-on-x86.patch
-fix-boot-on-efi-32-bit-machines.patch

 Dropped.

+mtrr-add-lock-annotations-for-prepare_set-and.patch
+x86-remove-default_ldt-and-simplify-ldt-setting.patch

 x86 updates.

-kill-default_ldt.patch

 Updated.

+alpha-fix-alpha_ev56-dependencies-typo.patch

 Alpha fixlet.

+xtensa-ptrace-exit_zombie-fix.patch

 xtensa fix.

+copy_process-cosmetic-ioprio-tweak.patch
+autofs4-autofs4_follow_link-false-negative-fix.patch
+autofs4-pending-flag-not-cleared-on-mount-fail.patch
+futex_find_get_task-dont-take-tasklist_lock.patch
+sys_get_robust_list-dont-take-tasklist_lock.patch
+docbook-fix-segfault-in-docprocc.patch
+solaris-emulation-incorrect-tty-locking.patch
+solaris-emulation-incorrect-tty-locking-fix.patch
+solaris-emulation-incorrect-tty-locking-fix-2.patch
+tty-fix-bits-and-note-more-bits-to-fix.patch
+windfarm_smu_satc-simplify-around-i2c_add_driver.patch
+make-spinlock-rwlock-annotations-more-accurate-by-using.patch
+replace-_spin_trylock-with-spin_trylock-in-the-irq.patch
+ext3-turn-on-reservation-dump-on-block-allocation-errors.patch
+ext3-add-more-comments-in-block-allocation-reservation-code.patch
+generic-boolean.patch
+fs-ntfs-conversion-to-generic-boolean.patch
+fs-jfs-conversion-to-generic-boolean.patch
+block_devc-mutex_lock_nested-fix.patch
+fix-mem_write-return-value.patch
+doc-fix-kernel-parameters-quiet.patch
+pass-a-lock-expression-to-__cond_lock-like-__acquire-and.patch
+cramfs-rewrite-init_cramfs_fs.patch
+freevxfs-fix-leak-on-error-path.patch
+cramfs-make-cramfs_uncompress_exit-return-void.patch
+9p-fix-leak-on-error-path.patch
+ban-register_filesystemnull.patch
+jbd-use-build_bug_on-in-journal-init.patch
+more-ext3-16t-overflow-fixes.patch
+ext3-inode-numbers-are-unsigned-long.patch
+lockdep-core-add-enable-disable_irq_irqsave-irqrestore-apis.patch
+really-ignore-kmem_cache_destroy-return-value.patch
+make-kmem_cache_destroy-return-void.patch
+set-exit_dead-state-in-do_exit-not-in-schedule.patch
+kill-pf_dead-flag.patch
+introduce-task_dead-state.patch
+fix-typo-in-rtc-kconfig.patch

 Misc.

+pass-sparse-the-lock-expression-given-to-lock-annotations.patch

 Update for new sparse features.

+ntp-add-ntp_update_frequency-fix.patch

 Fix ntp-add-ntp_update_frequency.patch

+kill-wall_jiffies.patch

 Time management cleanup.

+reiserfs-eliminate-minimum-window-size-for-bitmap-searching.patch

 reiserfs speedup/simplification.

+fs-cache-make-kafs-use-fs-cache-12-fix.patch

 Fix fs-cache-make-kafs-use-fs-cache-12.patch

+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-warning-fixes.patch

 Fix fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem.patch
 some more.

+hdaps-add-explicit-hardware-configuration-functions-fix-fix.patch

 Fix hdaps-add-explicit-hardware-configuration-functions.patch some more.

+generic-ioremap_page_range-x86_64-conversion-fix.patch

 Fix generic-ioremap_page_range-x86_64-conversion.patch

+support-piping-into-commands-in-proc-sys-kernel-core_pattern-fix-2.patch

 Fix support-piping-into-commands-in-proc-sys-kernel-core_pattern.patch some
 more.

+kprobes-make-kprobe-modules-more-portable.patch
+kprobes-make-kprobe-modules-more-portable-update.patch
+add-regs_return_value-helper.patch
+update-documentation-kprobestxt.patch
+update-documentation-kprobestxt-update.patch

 kprobes updates.

+knfsd-split-svc_serv-into-pools-fix.patch

 Fix knfsd-split-svc_serv-into-pools.patch

+nfsd-lockdep-annotation.patch
+knfsd-nfsd-lockdep-annotation-fix.patch
+knfsd-call-lockd_down-when-closing-a-socket-via-a-write-to-nfsd-portlist.patch
+knfsd-protect-update-to-sn_nrthreads-with-lock_kernel.patch
+knfsd-fixed-handling-of-lockd-fail-when-adding-nfsd-socket.patch
+knfsd-replace-two-page-lists-in-struct-svc_rqst-with-one.patch
+knfsd-avoid-excess-stack-usage-in-svc_tcp_recvfrom.patch
+knfsd-prepare-knfsd-for-support-of-rsize-wsize-of-up-to-1mb-over-tcp.patch
+knfsd-allow-max-size-of-nfsd-payload-to-be-configured.patch
+knfsd-make-nfsd-readahead-params-cache-smp-friendly.patch
+knfsd-knfsd-cache-ipmap-per-tcp-socket.patch

 NFSD updates.

+zvc-support-nr_slab_reclaimable--nr_slab_unreclaimable-swap_prefetch.patch

 Update swap prefetch for mm changes.

+ecryptfs-mntput-lower-mount-on-umount_begin.patch
+vfs-make-filldir_t-and-struct-kstat-deal-in-64-bit-inode-numbers-ecryptfs.patch
+make-kmem_cache_destroy-return-void-ecryptfs.patch

 ecryptfs updates

-namespaces-add-nsproxy-dont-include-compileh.patch
+namespaces-add-nsproxy-move-init_nsproxy-into-kernel-nsproxyc.patch
-namespaces-utsname-switch-to-using-uts-namespaces-uml-fix.patch
-namespaces-utsname-use-init_utsname-when-appropriate-gmidi.patch
-namespaces-utsname-use-init_utsname-when-appropriate-print_kernel_version.patch
-namespaces-utsname-sysctl-hack-fix.patch

 namespace patch consolidation.

+make-kmem_cache_destroy-return-void-reiser4.patch

 Fix reiser4 for other -mm patches.

+atyfb-possible-cleanups.patch
+mbxfb-fix-a-chip-bug-resulting-in-wrong-pixclock.patch
+mbxfb-fix-framebuffer-size-smaller-than-requested.patch
+fbcon-make-3-functions-static.patch
+vt-proper-prototypes-for-some-console-functions.patch
+sstfb-clean-ups.patch

 fbdev updates.

+md-fix-issues-with-referencing-rdev-in-md-raid1.patch
+md-new-sysfs-interface-for-setting-bits-in-the-write-intent-bitmap.patch
+md-remove-unnecessary-variable-x-in-stripe_to_pdidx.patch

 MD updates

+srcu-3-rcu-variant-permitting-read-side-blocking-srcu-add-lock-annotations.patch

 Add lock annotation to SRCU.

+rcu-add-fake-writers-to-rcutorture-tidy.patch

 Clean up rcu-add-fake-writers-to-rcutorture.patch

+acpi_format_exception-debug.patch

 ACPI debugging.



All 1658 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/patch-list

