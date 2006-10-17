Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423128AbWJQGGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423128AbWJQGGy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423133AbWJQGGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:06:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3514 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423128AbWJQGGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:06:52 -0400
Date: Mon, 16 Oct 2006 23:06:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc2-mm1
Message-Id: <20061016230645.fed53c5b.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/


- Added the hwmon and i2c trees to the -mm lineup.  These are quilt-style
  trees, maintained by Jean Delvare.



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


Changes since 2.6.19-rc1-mm1:


 origin.patch
 git-alsa.patch
 git-agpgart.patch
 git-cpufreq.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-jfs.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-pciseg.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees

-revert-nvidiafb-use-generic-ddc-reading.patch
-null-dereference-in-fs-jbd-journalc.patch
-irq-fix-avr32-breakage.patch
-mm-use-symbolic-names-instead-of-indices-for-zone-initialisation.patch
-mm-remove-memmap_zone_idx.patch
-fix-menuconfig-build-failure-due-to-missing-stdboolh.patch
-user-struct-irq_chip-instead-of-struct-hw_interrupt_type.patch
-disable-detect_softlockup-for-s390.patch
-ext4-copy.patch
-ext4-rename.patch
-ext4-enable.patch
-jbd2-copy.patch
-jbd2-rename.patch
-jbd2-rename-slab.patch
-jbd2-enable.patch
-jbd2-cleanup.patch
-ext4-extents.patch
-ext4_fsblk_sector_t.patch
-ext4-extents-48bit.patch
-ext4-unitialized-extent-handling.patch
-extents_comment_fix.patch
-64bit_jbd2_core.patch
-sector_t-jbd2.patch
-ext4_48bit_i_file_acl.patch
-64bit-metadata.patch
-ext4_blk_type_from_sector_t_to_ulonglong.patch
-ext4_blk_type_from_sector_t_to_ulonglong-fix.patch
-ext4_remove_sector_t_bits_check.patch
-jbd2_blks_type_from_sector_t_to_ull.patch
-ext4_allow_larger_descriptor_size.patch
-ext4_move_block_number_hi_bits.patch
-ext4-uninline-ext4_get_group_no_and_offset.patch
-ext4-64-bit-divide-fix.patch
-ext4-64-bit-divide-fix-fix.patch
-ext4-rename-logic_sb_block.patch
-ext4-errors-behaviour-fix.patch
-ext4-whitespace-cleanups.patch
-acpi-fix-section-for-cpu-init-functions.patch
-acpi-fix-printk-format-warnings.patch
-acpi-sci-interrupt-source-override.patch
-asus_acpi-fix-proc-files-parsing.patch
-asus_acpi-dont-printk-on-writing-garbage-to-proc-files.patch
-acpi-check-if-parent-is-on-dock.patch
-fix-incorrect-handling-of-pci-express-root-bridge-_hid.patch
-acpi-preserve-correct-battery-state-through-suspend-resume-cycles.patch
-acpi-preserve-correct-battery-state-through-suspend-resume-cycles-tidy.patch
-fs-bioc-tweaks.patch
-git-cifs.patch
-git-cifs-fixup.patch
-cifs-kconfig-dont-select-connector.patch
-fix-gregkh-driver-nozomi.patch
-w1-kconfig-fix.patch
-fs-partitions-check-add-sysfs-error-handling.patch
-char-nozomi-use-tty_wakeup.patch
-pci_module_init-convertion-in-amso1100-driver.patch
-drivers-infiniband-hw-amso1100-c2_rnicc-fix-a-null-dereference.patch
-remove-silly-messages-from-input-layer.patch
-input-i8042-disable-keyboard-port-when-panicking-and-blinking.patch
-libata-add-40pin-short-cable-support-honour-drive.patch
-pci_module_init-convertion-in-ata_genericc.patch
-pci_module_init-convertion-in-ata_genericc-fix.patch
-pci_module_init-conversion-for-pata_pdc2027x.patch
-libata-return-sense-data-in-hdio_drive_cmd-ioctl.patch
-libata-return-sense-data-in-hdio_drive_cmd-ioctl-tidy.patch
-b44-fix-eeprom-endianess-issue.patch
-forcedeth-power-management-support.patch
-forcedeth-power-management-support-tidy.patch
-remove-unnecessary-check-in-drivers-net-depcac.patch
-pci_module_init-convertion-in-olympicc.patch
-ibmveth-irq-fix.patch
-off-by-one-in-arch-ppc-platforms-mpc8.patch
-ehea-firmware-interface-based-on-anton-blanchards-new-hvcall-interface.patch
-pci-optionally-sort-device-lists-breadth-first-tweaks.patch
-pci-optionally-sort-device-lists-breadth-first-force-on.patch
-gregkh-usb-usb-serial-mos7720.patch
-sound-usb-usbaudio-handle-return-value-of-usb_register.patch
-drivers-usb-net-use-build_bug_on.patch
-mm-kevent-threads-use-mpol_default.patch
-move-rmap-bug_on-outside-debug_vm.patch
-fix-do_mbind-warning-with-config_migration=n.patch
-mm-arch_free_page-fix.patch
-mm-locks_freed-fix.patch
-swsusp-use-suspend_console.patch
-uml-revert-wrong-patch.patch
-uml-correct-removal-of-pte_mkexec.patch
-uml-readd-forgot-prototype.patch
-uml-make-tt-mode-compile-after-setjmp-related-changes.patch
-uml-make-uml_setjmp-always-safe.patch
-uml-fix-processor-selection-to-exclude-unsupported-processors-and-features.patch
-uml-fix-uname-under-setarch-i386.patch
-uml-declare-in-kconfig-our-partial-lockdep-support.patch
-uml-allow-using-again-x86-x86_64-crypto-code.patch
-uml-asm-offsets-duplication-removal.patch
-uml-remove-duplicate-export.patch
-uml-deprecate-config_mode_tt.patch
-uml-allow-finer-tuning-for-host-vmsplit-setting.patch
-add-address_space_operationsbatch_write.patch
-pass-io-size-to-batch_write-address-space-operation.patch
-bluetooth-guard-bt_proto-with-rwlock.patch
-bluetooth-use-gfp_atomic-in-_sock_creates-sk_alloc.patch
-remove-the-old-bd_mutex-lockdep-annotation.patch
-new-bd_mutex-lockdep-annotation.patch
-add-config_headers_check-option-to-automatically-run-make-headers_check.patch
-add-config_headers_check-option-to-automatically-run-make-headers_check-nobble.patch
-epoll_pwait.patch
-adds-carta_random32-library-routine.patch
-grow_buffers-infinite-loop-fix.patch
-ide-generic-jmicron-fix.patch
-fix-module-taint-flags-listing-in-oops-panic.patch
-ext3-errors-behaviour-fix.patch
-ext2-errors-behaviour-fix.patch
-tpm-fix-error-handling.patch
-sched-likely-profiling.patch
-invalidate_inode_pages2_range-debug.patch
-x86-microcode-handle-sysfs-error.patch
-32-bit-compatibility-hdio-ioctls.patch
-bitmap-parse-input-from-kernel-and-user-buffers-2.patch
-document-the-core-dump-to-a-pipe-patch.patch
-vm-fix-the-gfp_mask-in-invalidate_complete_page2.patch
-posix-cpu-timers-prevent-signal-delivery-starvation.patch
-remove-unnecessary-check-in-fs-fat-inodec.patch
-d-cache-aliasing-issue-in-__block_prepare_write.patch
-use-linux-ioh-instead-of-asm-ioh.patch
-consolidate-check_signature.patch
-fix-typos-in-mm-shmem_aclc.patch
-ht_irq-must-depend-on-pci.patch
-fs-use-build_bug_on.patch
-dac960-use-memmove-for-overlapping-areas.patch
-lockdep-use-build_bug_on.patch
-fix-lockdep-designtxt.patch
-lockdep-fix-printk-recursion-logic.patch
-kernel-doc-fix-function-name-in-usercopyc.patch
-uaccessh-match-kernel-doc-and-function-names.patch
-kernel-doc-drop-various-inline-qualifiers.patch
-include-linux-typesh-in-linux-nbdh.patch
-kernel-doc-make-parameter-description-indentation-uniform.patch
-dell_rbu-printk-warning-fix.patch
-reiserfs-make-sure-all-dentries-refs-are-released-before-calling-kill_block_super-try-2.patch
-autofs-make-sure-all-dentries-refs-are-released-before-calling-kill_anon_super.patch
-vfs-destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch
-knfsd-add-nfs-export-support-to-tmpfs.patch
-md-use-build_bug_on.patch
-squash-transmeta-warnings.patch

 Merged into mainline or a subsystem tree.

+e100-fix-reboot-f-with-netconsole-enabled.patch
+ioc4-remove-sn2-feature-and-config-dependencies.patch
+ioc4-enable-build-on-non-sn2.patch
+ioc4-enable-build-on-non-sn2-fix-2.patch
+ioc4-fixes.patch
+ioc4-kconfig-fix.patch
+synclink-remove-page_size-reference.patch
+lockdep-increase-max-allowed-recursion-depth.patch
+new-mmc-maintainer.patch
+i386-time-avoid-pit-smp-lockups.patch
+null-dereference-in-fs-jbd2-journalc.patch
+remove_mapping-fix.patch
+md-fix-proc-mdstat-refcounting.patch
+posix-cpu-timers-prevent-signal-delivery-starvation.patch
+proc_numbuf-is-wrong.patch
+direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write.patch
+rename-net_random-to-random32.patch
+rename-net_random-to-random32-fixes.patch
+rename-net_random-to-random32-fix-2.patch
+remove-carta_random32.patch
+knfsd-add-nfs-export-support-to-tmpfs.patch
+w1-kconfig-fix.patch
+rtc-max6902-month-conversion-fix.patch
+vmalloc-dont-pass-__gfp_zero-to-slab.patch
+acpi_processor_latency_notifier-up-warning-fix.patch
+swsusp-fix-memory-leaks.patch
+drivers-char-specialixc-fix-the-baud-conversion.patch
+fix-make-headers_install.patch
+genirq-clean-up-irq-flow-type-naming.patch
+sx-fix-user-visible-typo-devic.patch
+fuse-fix-hang-on-smp.patch
+document-i_size_write-locking-rules.patch
+fuse-locking-fix-for-nlookup.patch
+fuse-fix-spurious-bug.patch
+fuse-fix-handling-of-moved-directory.patch
+fuse-fix-dereferencing-dentry-parent.patch
+knfsd-nfsd4-fix-owner-override-on-open.patch
+knfsd-nfsd4-fix-open-permission-checking.patch
+knfsd-nfsd4-fix-error-handling-in-nfsds-callback-client.patch
+knfsd-fix-bug-in-recent-lockd-patches-that-can-cause-reclaim-to-fail.patch
+knfsd-allow-lockd-to-drop-replys-as-appropriate.patch
+knfsd-allow-lockd-to-drop-replys-as-appropriate-fixes.patch
+revert-generic_file_buffered_write-handle-zero-length-iovec-segments.patch
+revert-generic_file_buffered_write-deadlock-on-vectored-write.patch
+generic_file_buffered_write-cleanup.patch
+mm-comment-mmap_sem--lock_page-lockorder.patch
+mm-only-mm-debug-write-deadlocks.patch
+mm-fix-pagecache-write-deadlocks.patch
+mm-fix-pagecache-write-deadlocks-comment.patch

 2.6.19 queue (mostly)

+add-support-for-the-generic-backlight-device-to-the-ibm-acpi-driver.patch
+add-support-for-the-generic-backlight-device-to-the-ibm-acpi-driver-fix.patch
+add-support-for-the-generic-backlight-device-to-the-asus-acpi-driver.patch
+add-support-for-the-generic-backlight-device-to-the-toshiba-acpi-driver.patch
+acpi-cpufreq-remove-dead-code.patch

 ACPI things.

+cpufreq-handle-sysfs-errors.patch
+speedstep-centrino-remove-dead-code.patch

 cpufreq fixes.

+gregkh-driver-driver-core-kmalloc-failure-check-in-driver_probe_device.patch
+gregkh-driver-driver-link-sysfs-timing.patch
-gregkh-driver-driver-link-sysfs-timing.patch

 Driver tree updates.

+revert-gregkh-driver-driver-core-fixes-sysfs_create_group-retval-in-topology.c.patch

 Drop a bad patch.

+driver-core-dont-ignore-bus_attach_device-retval.patch
+cpu-topology-consider-sysfs_create_group-return-value.patch

 Driver core fixes.

+git-dvb-fixup.patch

 Fix rejects in git-dvb.patch

+jdelvare-i2c-i2c-scx200_acb-handle-pci-errors.patch
+jdelvare-i2c-i2c-documentation-typos.patch
+jdelvare-i2c-i2c-kill-icspll-driver-id.patch
+jdelvare-i2c-i2c-delete-ite-bus-driver.patch
+jdelvare-i2c-i2c-pnx-new-driver.patch
+jdelvare-i2c-i2c-ibm_iic-add_request_release_mem_region.patch
+jdelvare-i2c-i2c-nforce2-cleanup.patch

 i2c tree

+jdelvare-hwmon-hwmon-unchecked-return-status-fixes-w83791d.patch
+jdelvare-hwmon-hwmon-update-Grant-Coady-email-address.patch
+jdelvare-hwmon-hwmon-documentation-typos.patch
+jdelvare-hwmon-hwmon-smsc47m112-documentation.patch
+jdelvare-hwmon-hwmon-k8temp-documentation-update.patch
+jdelvare-hwmon-hwmon-w83627ehf-fix-fan5-detection.patch
+jdelvare-hwmon-hwmon-w83781d-lm78-fix-load-failure.patch
+jdelvare-hwmon-hwmon-w83781d-fix-debug-messages.patch
+jdelvare-hwmon-hwmon-unchecked-return-status-fixes-abituguru.patch
+jdelvare-hwmon-hwmon-f71805f-add-fanctl-1-prepare.patch
+jdelvare-hwmon-hwmon-f71805f-add-fanctl-2-manual-mode.patch
+jdelvare-hwmon-hwmon-f71805f-add-fanctl-3-pwm-freq.patch
+jdelvare-hwmon-hwmon-f71805f-add-fanctl-4-pwm-mode.patch
+jdelvare-hwmon-hwmon-f71805f-add-fanctl-5-speed-mode.patch
+jdelvare-hwmon-hwmon-f71805f-add-fanctl-6-documentation.patch
+jdelvare-hwmon-hwmon-pc87360-set-vrm-using-hwmon-vid-routine.patch
+jdelvare-hwmon-hwmon-hdaps-dmi-detection-data-to-data-section.patch
+jdelvare-hwmon-hwmon-hdaps-BIOS-note.patch
+jdelvare-hwmon-hwmon-it87-drop-smbus-interface-support.patch
+jdelvare-hwmon-hwmon-pc87427-new-driver.patch

 hwmon tree

-hdapsc-inversion-of-each-axis.patch
-hdaps-remove-duplicate-whitelist-entry-and-add-thinkpad.patch

 Dropped (I think)

+ia64-remove-unused-pal_call_ic_off.patch
+ia64-reformat-pals-to-fit-in-80-columns-fix-typos.patch

 ia64 fixes.

+input-handle-sysfs-errors.patch
+input-drivers-handle-sysfs-errors.patch

 input updates.

+intel-fb-switch-to-pci_get-api.patch

 intelfb fixlet.

+ahci-readability-tweak.patch
+libata-sff-allow-for-wacky-systems.patch
+libata-revamp-blacklist-support-to-allow-multiple-kinds.patch
+pata_marvell-marvell-6101-6145-pata-driver.patch

 ata/pata things.

+drivers-mmcmisc-handle-pci-errors-on-resume.patch

 MMC fixlets.

-mtd-maps-add-parameter-to-amd76xrom-to-override-rom-window-size-if-set-incorrectly-by-bios-tweak.patch

 Folded into mtd-maps-add-parameter-to-amd76xrom-to-override-rom-window-size-if-set-incorrectly-by-bios.patch

-mtd-maps-support-for-bios-flash-chips-on-intel-esb2-southbridge-tidy.patch
-mtd-maps-support-for-bios-flash-chips-on-intel-esb2-southbridge-fix.patch

 Folded into mtd-maps-support-for-bios-flash-chips-on-intel-esb2-southbridge.patch

+jffs2-use-rb_first-and-rb_last-cleanup.patch
+mtd-fix-comment-typo-devic.patch
+esb2rom-use-hotplug-safe-interfaces.patch

 MTD/JFFS2 updates

+ibmveth-fix-index-increment-calculation.patch

 net driver fix.

+drivers-dma-handle-sysfs-errors.patch
+atm-firestream-handle-thrown-error.patch
+wan-pc300-handle-propagate-minor-errors.patch
+net-atm-handle-sysfs-errors.patch
+com20020-build-fix.patch
+nicstar-fix-a-bogus-casting-warning.patch
+resend-iphase-64bit-cleanup.patch

 net-related things.

-nfs-add-return-code-checks-for-page-invalidation.patch

 Dropped.

+bug-nfsd-nfs4xdrc-misuse-of-err_ptr.patch
+fix-svc_procfunc-declaration.patch
+lockd-endianness-annotations.patch
+xdr-annotations-nfsv2.patch
+xdr-annotations-nfsv3.patch
+xdr-annotations-nfsv4.patch
+xdr-annotations-nfs-readdir-entries.patch
+fs-nfs-callback-passes-error-values-big-endian.patch
+xdr-annotations-fs-nfs-callback.patch
+nfs-verifier-is-network-endian.patch
+xdr-annotations-mount_clnt.patch
+nfs_common-endianness-annotations.patch
+nfsd-nfserrno-endianness-annotations.patch
+nfsfh-simple-endianness-annotations.patch
+xdr-annotations-nfsd_dispatch.patch
+xdr-annotations-nfsv2-server.patch
+xdr-annotations-nfsv3-server.patch
+xdr-annotations-nfsv4-server.patch
+nfsd-vfsc-endianness-annotations.patch
+nfsd-nfs4-code-returns-error-values-in-net-endian.patch
+nfsd-nfsv23-trivial-endianness-annotations-for-error-values.patch
+nfsd-nfsv4-errno-endianness-annotations.patch
+xdr-annotations-nfsd-callback.patch
+nfsd-misc-endianness-annotations.patch
+nfsd-nfs_replay_me.patch

 NFS/NFSD updates

+perle-multimodem-card-pci-ras-detection.patch
+pcmcia-handle-sysfs-pci-errors.patch

 PCMCIA things.

+make-sure-uart-is-powered-up-when-dumping-mctrl-status.patch
+serial-handle-pci_enable_device-failure-upon-resume.patch

 Serial stuff (nacked, actually)

+gregkh-pci-pci-check-that-mwi-bit-really-did-get-set.patch
+gregkh-pci-pci-use-pci_generic_prep_mwi-on-ia64.patch
+gregkh-pci-pci-use-pci_generic_prep_mwi-on-sparc64.patch
+gregkh-pci-pci-replace-have_arch_pci_mwi-with-pci_disable_mwi.patch
+gregkh-pci-pci-delete-unused-extern-in-powermac-pci.c.patch

 PCI tree updates.

+revert-gregkh-pci-pci-check-that-mwi-bit-really-did-get-set.patch

 Weed badness out of the PCI tree

+reset-pci-device-state-to-unknown-state-for-resume.patch
+pci-additional-functions.patch

 PCI stuff.

+scsi-minor-bug-fixes-and-cleanups.patch
+mpt-fusion-handle-pci-layer-error-on-resume.patch
+scsi-aha1740-handle-scsi-api-errors.patch
+scsi-qla2xxx-handle-sysfs-errors.patch
+drivers-scsi-ncr5380c-replacing-yield-with-a.patch
+drivers-scsi-megaraidc-replacing-yield-with-a.patch
+switch-fdomain-to-the-pci_get-api.patch

 SCSI updates.

+gregkh-usb-uhci-workaround-for-asus-motherboard.patch
+gregkh-usb-usbcore-fix-refcount-bug-in-endpoint-removal.patch
+gregkh-usb-usbcore-fix-endpoint-device-creation.patch
+gregkh-usb-usb-drivers-usb-net-use-build_bug_on.patch
+gregkh-usb-usb-devio-handle-class_device_create-error.patch
+gregkh-usb-mcs7830-driver-3.diff.patch
+gregkh-usb-usbnet-ethtool-mii.diff.patch
+gregkh-usb-usbnet-phy-mutex.diff.patch
+gregkh-usb-usb-move-vibrator.patch
+gregkh-usb-usb-serial-mos7720.patch
+gregkh-usb-usb-takes-31-devices-per-hub.patch
+gregkh-usb-usb-hub-root-hub-code-takes-more-than-15-devices.patch

 USB tree updates.

-xpad-dance-pad-support-tidy.patch

 Folded into xpad-dance-pad-support.patch

+ueagle-fix-ueagle-atm-oops.patch
+usb-gadget-net2280-handle-sysfs-errors.patch

 USB things.

+airoc-check-returned-values.patch

 wireless driver fixlets.

-spinlock-debug-all-cpu-backtrace-fix.patch
-spinlock-debug-all-cpu-backtrace-fix-2.patch
-spinlock-debug-all-cpu-backtrace-fix-3.patch

 Folded into spinlock-debug-all-cpu-backtrace.patch

+i386-espfix-cleanup-tweak.patch

 Fix i386-espfix-cleanup.patch

+x86-64-mmconfig-missing-printk-levels.patch
+i386-fix-cfi_signal_frame-copy-n-paste-error.patch
+x86_64-fix-obscure-oops-in-xfrm_register_mode.patch

 x86 things.

+i386-use-asm-offsets-for-the-offsets-of-registers-into-the-pt_regs-struct-rather-than-having-hard-coded-constants.patch
+i386-pda-basic-definitions-for-i386-pda.patch
+i386-pda-initialize-the-per-cpu-data-area.patch
+i386-pda-initialize-the-per-cpu-data-area-voyager-fix.patch
+i386-pda-use-%gs-as-the-pda-base-segment-in-the-kernel.patch
+i386-pda-fix-places-where-using-%gs-changes-the-usermode-abi.patch
+i386-pda-update-sys_vm86-to-cope-with-changed-pt_regs-and-%gs-usage.patch
+i386-pda-implement-smp_processor_id-with-the-pda.patch
+i386-pda-implement-current-with-the-pda.patch
+i386-pda-store-the-interrupt-regs-pointer-in-the-pda.patch

 Use the i386 gs register for the accessing per-cpu data.

-touchkit-ps-2-touchscreen-driver-configh.patch
-touchkit-ps-2-touchscreen-driver-regs-fix.patch

 Folded into touchkit-ps-2-touchscreen-driver.patch

+memory-page-alloc-minor-cleanups-fix.patch

 Folded into memory-page-alloc-minor-cleanups.patch

+__unmap_hugepage_range-add-comment.patch

 MM comment.

+optional-zone_dma-in-the-vm-no-gfp_dma-check-in-the-slab-if-no-config_zone_dma-is-set.patch

 Fix optional-zone_dma-in-the-vm.patch

+memory-page_alloc-zonelist-caching-speedup.patch
+oom-dont-kill-unkillable-children-or-siblings.patch
+oom-cleanup-messages.patch
+oom-less-memdie.patch
+mm-incorrect-vm_fault_oom-returns-from-drivers.patch

 MM updates.

-shared-page-table-for-hugetlb-page-v4.patch
-htlb-forget-rss-with-pt-sharing.patch

 Dropped.

+fix-bug-in-try_to_free_pages-and-balance_pgdat-when-they.patch
+balance_pdgat-cleanup.patch
+use-min-of-two-prio-settings-in-calculating-distress-for.patch

 More MM updates.

+alpha-switch-to-pci_get-api.patch

 Alpha fixlet.

+swsusp-improve-handling-of-highmem.patch
+swsusp-use-__gfp_wait.patch

 swsusp updates.

+s390-qdio-build-fix.patch

 s390 fix

-block-layer-early-detection-of-medium-not-present.patch
-scsi-core-and-sd-early-detection-of-medium-not-present.patch
-sd-early-detection-of-medium-not-present.patch
-scsi-early-detection-of-medium-not-present-updated.patch

 Dropped.

-drivers-add-lcd-support.patch
-drivers-add-lcd-support-update.patch
+drivers-add-lcd-support-3.patch
+drivers-add-lcd-support-3-Kconfig-fix.patch

 Updated

+ext2-fsid-for-statvfs.patch
+ext3-fsid-for-statvfs.patch
+ext4-fsid-for-statvfs.patch
+fix-io-error-reporting-on-fsync.patch
+drivers-led-handle-sysfs-errors.patch
+i2o-handle-a-few-sysfs-errors.patch
+fs-partitions-check-add-sysfs-error-handling.patch
+kernel-proc-kallsyms-reports-lower-case.patch
+rtc-fix-printk-of-64-bit-res-on-32-bit-platform.patch
+lockdep-annotate-i386-apm.patch
+i2o-more-error-checking.patch
+pnp-handle-sysfs-errors.patch
+rd-memory-leak-on-rd_init-failure.patch
+epca-prevent-panic-on-tty_register_driver-failure.patch
+rtc-handle-sysfs-errors.patch
+sound-oss-emu10k1-handle-userspace-copy-errors.patch
+spi-improve-sysfs-compiler-complaint-handling.patch
+kbuild-allow-multi-word-m-in-makefilemodpost.patch
+add-entrys-labels-to-tag-file.patch
+rt-mutex-fixup-rt-mutex-debug-code.patch
+ia64-fix-allmodconfig-build.patch
+convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch
+constify-inode-accessors.patch
+ide-complete-switch-to-pci_get.patch
+fuse-update-userspace-interface-to-version-78.patch
+fuse-minor-cleanup-in-fuse_dentry_revalidate.patch
+fuse-add-support-for-block-device-based-filesystems.patch
+fuse-add-blksize-option.patch
+fuse-add-bmap-support.patch
+fuse-add-destroy-operation.patch
+config_telclock-depends-on-x86.patch
+sysrq-x-show-blocked-tasks.patch
+remove-the-old-bd_mutex-lockdep-annotation.patch
+new-bd_mutex-lockdep-annotation.patch
+remove-lock_key-approach-to-managing-nested-bd_mutex-locks.patch
+simplify-some-aspects-of-bd_mutex-nesting.patch
+use-mutex_lock_nested-for-bd_mutex-to-avoid-lockdep-warning.patch
+avoid-lockdep-warning-in-md.patch

 Misc patches.

-generic-implementatation-of-bug.patch
-generic-implementatation-of-bug-fix.patch
+generic-bug-implementation.patch
 generic-bug-for-i386.patch
 generic-bug-for-x86-64.patch
 uml-add-generic-bug-support.patch
 use-generic-bug-for-ppc.patch
 bug-test-1.patch

 Updated generic-BUG-handling patches.

+log2-implement-a-general-integer-log2-facility-in-the-kernel-vs-git-cryptodev.patch

 Fix log2 patches in -mm.

+char-mxser_new-correct-intr-handler-proto.patch
+char-mxser_new-delete-ttys-and-termios.patch
+char-mxser_new-pci-probing.patch
+char-mxser_new-clean-macros.patch
+maintainers-add-me-to-isicom-mxser.patch

 More updates to the new nxser driver.

+char-stallion-use-pr_debug-macro.patch
+char-stallion-remove-unneeded-casts.patch
+char-stallion-kill-typedefs.patch
+char-stallion-move-init-deinit.patch
+char-stallion-uninline-functions.patch
+char-stallion-mark-functions-as-init.patch
+char-stallion-remove-many-prototypes.patch

 Stallion driver cleanups.

+drivers-isdn-hysdn-save_flags-cli-restore_flags-replaced-appropriately.patch
+drivers-isdn-isdnloop-save_flags-cli-restore_flags-replaced-appropriately.patch
+isdn-fix-drivers-by-handling-errors-thrown-by-readstat.patch
+isdn-check-for-userspace-copy-faults.patch
+drivers-isdn-ioremap-balanced-with-iounmap.patch

 ISDN updates.

+ecryptfs-superblock-cleanups.patch
+ecryptfs-use-special_file.patch

 ecryptfs updates.

-reiser4-write-via-do_sync_write.patch
-reiser4-rename-generic_sounding_globalspatch-fix.patch
+reiser4-get-rid-of-deprecated-crypto-api.patch
+reiser4-use-list_head-instead-of-struct-blocknr.patch

 The reiser4 patches were redone.

+atyfb-rivafb-minor-fixes.patch
+igafb-switch-to-pci_get-api.patch

 fbdev fixlets.

+md-conditionalize-some-code.patch

 MD cleanup

+fdtable-implement-new-pagesize-based-fdtable-allocator-fix.patch
+fdtable-implement-new-pagesize-based-fdtable-allocator-bound-minimum-allocation-size.patch
+fdtable-implement-new-pagesize-based-fdtable-allocator-avoid-fdset-cacheline-ping-pong.patch

 Fix and improve the fdtable patches in -mm.

+time-uninline-jiffiesh-fix.patch

 Fix time-uninline-jiffiesh.patch

+round_jiffies-infrastructure.patch
+round_jiffies-infrastructure-fix.patch
+user-of-the-jiffies-rounding-patch-ata-subsystem.patch
+user-of-the-jiffies-rounding-code-jbd.patch
+user-of-the-jiffies-rounding-code-networking.patch
+user-of-the-jiffies-rounding-patch-slab.patch

 Infrastructure to reduce the number of timer interrupts, and some
 applications thereof.

+mutex-subsystem-synchro-test-module-fix.patch

 Fix mutex-subsystem-synchro-test-module.patch

+mm-only-i_size_write-debugging.patch

 Check for buggy i_size_write() callers.



All 875 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/patch-list

