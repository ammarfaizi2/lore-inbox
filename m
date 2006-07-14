Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbWGNFsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWGNFsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 01:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWGNFsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 01:48:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161035AbWGNFsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 01:48:06 -0400
Date: Thu, 13 Jul 2006 22:48:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc1-mm2
Message-Id: <20060713224800.6cbdbf5d.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/

- Patches were merged, added, dropped and fixed.  Nothing particularly exciting.

- Added the avr32 architecture.  Review is sought, please.



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





Changes since 2.6.18-rc1-mm1:


 origin.patch
 git-arm.patch
 git-cifs.patch
 git-cpufreq.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-jfs.patch
 git-klibc.patch
 git-libata-all.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-sas.patch
 git-serial.patch
 git-s390.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-wireless.patch
 git-xfs.patch
 git-cryptodev.patch 

 git trees.

-dont-select-config_hotplug.patch
-x86_64-e820c-needs-pgtableh.patch
-acpi-bus-add-missing-newline.patch
-count_vm_events-fix.patch
-sched-fix-bug-in-__migrate_task.patch
-small-kernel-schedc-cleanup.patch
-selinux-decouple-fscontext-context-mount-options.patch
-selinux-add-rootcontext=-option-to-label-root-inode.patch
-reiserfsfix-journaling-issue-regarding-fsync.patch
-nfs-update-documentation-nfsroottxt-to-include-dhcp-syslinux-and-isolinux.patch
-add-computone-intelliport-plus-serial-hotplug-support.patch
-add-specialix-io8-card-support-hotplug-support.patch
-partitions-let-partitions-inherit-policy-from-disk.patch
-fadvise-remove-dead-comments.patch
-minor-cleanup-to-lockdepc.patch
-lockdep-add-more-rwsemh-documentation.patch
-improve-lockdep-debug-output.patch
-lockdep-core-reduce-per-lock-class-cache-size.patch
-lockdep-clean-up-completion-initializer-in-smpbootc.patch
-put-a-comment-at-register_die_notifier-that-the-export-is-used.patch
-rcu-documentation-fix.patch
-vfs-documentation-tweak.patch
-cdrom-fix-bad-cgcbuflen-assignment.patch
-release_firmware-fixes.patch
-updates-credits-file.patch
-hisax-fix-usage-of-__init.patch
-vt-remove-vt-specific-declarations-and-definitions-from.patch
-tty-remove-include-of-screen_infoh-from-ttyh.patch
-md-possible-fix-for-unplug-problem.patch
-md-set-desc_nr-correctly-for-version-1-superblocks.patch
-md-delay-starting-md-threads-until-array-is-completely-setup.patch
-md-fix-resync-speed-calculation-for-restarted-resyncs.patch
-md-fix-a-plug-unplug-race-in-raid5.patch
-md-fix-some-small-races-in-bitmap-plugging-in-raid5.patch
-md-fix-usage-of-wrong-variable-in-raid1.patch
-md-unify-usage-of-symbolic-names-for-perms.patch
-md-require-cap_sys_admin-for-re-configuring-md-devices-via-sysfs.patch
-md-include-sector-number-in-messages-about-corrected-read-errors.patch
-md-oops-workaround.patch
-kernel-printkc-export_symbol_unused.patch
-mm-bootmemc-export_unused_symbol.patch
-mm-memoryc-export_unused_symbol.patch
-mm-mmzonec-export_unused_symbol.patch
-fs-read_writec-export_unused_symbol.patch
-kernel-softirqc-export_unused_symbol.patch
-h8300-remove-duplicate-define.patch
-acpi-fix-fan-thermal-resume.patch
-pi-futex-validate-futex-type-instead-of-oopsing.patch
-zvc-add-__inc_zone_state-for-smp-configuration.patch
-vmstat-export-all_vm_events.patch
-acpi-init-dock-notifier-list.patch
-acpi-fix-boot-with-acpi=off.patch
-adjust-clock-for-lost-ticks.patch
-acpi-do-not-abort-method-execution-if-asked-to-release.patch
-acpi-disable-sbs-by-default.patch
-acpi-initialise-cm_sbs_sem.patch
-acpi-resume-allocation-mode-fix.patch
-gregkh-driver-driver-core-fix-driver-core-kernel-doc.patch
-gregkh-driver-driver-core-bus.c-cleanups.patch
-gregkh-driver-remove-kernel-power-pm.c-pm_unregister_all.patch
-gregkh-driver-the-scheduled-unexport-of-insert_resource.patch
-gregkh-i2c-i2c-fix-ignore-module-parameter-handling-in-i2c-core.patch
-gregkh-i2c-i2c-iop3xx-avoid-addressing-self.patch
-gregkh-i2c-scx200_acb-fix-the-state-machine.patch
-gregkh-i2c-scx200_acb-fix-the-block-transactions.patch
-gregkh-i2c-i2c-powermac-fix-master-xfer-return.patch
-gregkh-i2c-i2c-plan-ite-bus-driver-for-removal.patch
-gregkh-i2c-i2c-new-mailing-list.patch
-gregkh-i2c-i2c-algo-error-handling-fix.patch
-gregkh-i2c-i2c-algo-bit-wipe-out-dead-code.patch
-gregkh-i2c-i2c-pca9539-force.patch
-gregkh-i2c-w1-remove-w1-mail-list-from-lm_sensors.patch
-gregkh-i2c-w1-fix-idle-check-loop-in-ds2482.patch
-gregkh-i2c-w1-remove-drivers-w1-w1.h.patch
-pata-jmicron-add-quirks-to-force-the-device-into-a-sane-mode.patch
-pata-jmicron-configuration.patch
 pata-ata_generic-generic-bios-setup-sff-ata-driver.patch
-pata-jmicron-ide-old-type-driver.patch
-e1000-irq-naming-update.patch
-s2io-driver-irq-fix.patch
-lockdep-fix-atm-ipcommonc-deadlock.patch
-8139cp-printk-fix.patch
-smsc-ircc2-fix-section-reference-mismatches.patch
-forcedeth-deferral-fixup.patch
-forcedeth-watermark-fixup.patch
-powermac-combined-fixes-for-backlight-code.patch
-serial-add-tsi108-8250-serial-support.patch
-serial-8250-sysrq-deadlock-fix.patch
-gregkh-pci-pci-poper-prototype-for-arch-i386-pci-pcbios.c-pcibios_sort.patch
-gregkh-pci-pci-clear-abnormal-poweroff-flag-on-via-southbridges-fix-resume.patch
-pci-initialize-struct-pci_dev-error_state.patch
-drivers-scsi-aic7xxx-aic79xx_corec-make-ahd_done_with_status-static.patch
-stc-improve-sense-output.patch
-sparc64-of_device_register-error-checking-fix.patch
-gregkh-usb-usb-au1xxx-compile-fixes-for-ohci-for-au1200.patch
-gregkh-usb-usb-au1200-ehci-and-ohci-fixes.patch
-gregkh-usb-usb-ohci-bits-for-the-cirrus-ep93xx.patch
-gregkh-usb-usb-fix-usb-kernel-doc.patch
-gregkh-usb-usb-addition-of-vendor-product-id-pair-for-pl2303-driver.patch
-gregkh-usb-usb-new-device-id-for-thorlabs-motor-driver.patch
-gregkh-usb-usb-new-device-ids-for-ftdi_sio-driver.patch
-gregkh-usb-usb-ohci-hub-code-unaligned-access.patch
-gregkh-usb-usb-fix-usb-serial-leaks-oopses-on-disconnect.patch
-gregkh-usb-usb-fix-visor-leaks.patch
-gregkh-usb-usb-add-some-basic-wusb-definitions.patch
-gregkh-usb-usb-support-for-susteen-datapilot-universal-2-cable-in-pl2303.patch
-gregkh-usb-usbfs-use-the-correct-signal-number-for-disconnection.patch
-gregkh-usb-usb-rename-cypress-cy7c63xxx-driver-to-proper-name-and-fix-up-some-tiny-things.patch
-gregkh-usb-usb-update-for-acm-in-quirks-and-debug.patch
-gregkh-usb-usb-storage-fix-race-between-reset-and-disconnect.patch
-gregkh-usb-usb-hub-don-t-return-status-0-from-resume.patch
-gregkh-usb-usb-storage-unusual_devs-entry-for-motorola-razr-v3x.patch
-gregkh-usb-usb-unusual_devs-entry-for-samsung-mp3-player.patch
-gregkh-usb-usbcore-fixes-for-hub_port_resume.patch
-gregkh-usb-usb-storage-us_fl_max_sectors_64-flag.patch
-gregkh-usb-usb-storage-uname-in-pr-sc-unneeded-message.patch
-gregkh-usb-usb-serial-visor-fix-race-in-open-close.patch
-gregkh-usb-usb-serial-ftdi_sio-prevent-userspace-dos.patch
-gregkh-usb-usb-kill-compiler-warning-in-quirk_usb_handoff_ohci.patch
-gregkh-usb-usb-fix-pointer-dereference-in-drivers-usb-misc-usblcd.patch
-gregkh-usb-usb-add-driver-for-non-composite-sierra-wireless-devices.patch
-gregkh-usb-usb-ehci-fix-bogus-alteration-of-a-local-variable.patch
-gregkh-usb-usb-ipaq.c-bugfixes.patch
-gregkh-usb-usb-ipaq.c-timing-parameters.patch
-gregkh-usb-usb-remove-empty-destructor-from-drivers-usb-mon-mon_text.c.patch
-gregkh-usb-usb-remove-devfs-information-from-kconfig.patch
-gregkh-usb-usb-ipw.c-driver-fix.patch
-gregkh-usb-usb-add-support-for-wisegroup.-ltd-smartjoy-dual-plus-adapter.patch
-gregkh-usb-usb-ohci-avoids-root-hub-timer-polling.patch
-gregkh-usb-usb-ohci-s3c2410.c-clock-now-usb-bus-host.patch
-usb-storage-wait-for-urb-to-complete.patch
-bcm43xx-opencoded-locking.patch
-x86_64-mm-defconfig-update.patch
-x86_64-mm-bring-x86-64-ia32-emul-in-sync-with-i386-on-read_implies_exec-enabling.patch
-x86_64-mm-mce-amd-fix.patch
-x86_64-mm-add-a-maintainers-entry-for-calgary.patch
-x86_64-mm-fix-calgary-copyright-statements-per-ibm-guidelines.patch
-x86_64-mm-fix-acpi-defaults.patch
-x86_64-mm-oprofile-p4-model.patch
-xfs-move-xfs_ioc_getversion-to-main-multiplexer.patch
-mmap-zero-length-hugetlb-file-with-prot_none-to-protect-a.patch
-fdpic-fix-fdpic-compile-errors-2.patch
-frv-fix-frv-arch-compile-errors.patch
-nommu-fix-execution-off-of-ramfs-with-mmap.patch
-fdpic-adjust-the-elf-fdpic-driver-to-conform-more-to-the-codingstyle.patch
-fdpic-define-seek_-constants-in-the-linux-kernel-headers.patch
-fdpic-move-roundup-into-linux-kernelh.patch
-fdpic-move-roundup-into-linux-kernelh-fix.patch
-fdpic-add-coredump-capability-for-the-elf-fdpic-binfmt.patch
-frv-introduce-asm-offsets-for-frv-arch.patch
-i386-defconfig-set-config_pm_std_partition=.patch
-get_cmos_time-locking-fix.patch
-swsusp-do-not-use-memcpy-for-snapshotting-memory.patch
-swsusp-warning-fix.patch
-fix-panic-when-swsusp-signature-cant-be-read.patch
-cris-switch-to-iminor-imajor.patch
-pcf8563-remove-mod_inc_use_count-mod_dec_use_count.patch
-uml-clean-up-address-space-limits-code.patch
-uml-timer-initialization-cleanup.patch
-uml-timer-initialization-cleanup-fix.patch
-uml-remove-some-useless-exports.patch
-uml-fix-static-binary-segfault.patch
-uml-remove-useless-declaration.patch
-uml-signal-initialization-cleanup.patch
-uml-timer-handler-tidying.patch
-uml-ifdef-a-mode-specific-function.patch
-uml-mark-forward_interrupts-as-being-mode-specific.patch
-uml-remove-spinlock-wrapper-functions.patch
-uml-remove-os_isatty.patch
-uml-fix-exitcall-ordering-bug.patch
-uml-make-some-symbols-static.patch
-uml-remove-syscall-debugging.patch
-uml-move-_kernc-files.patch
-uml-move-_kernc-files-fix.patch
-uml-formatting-fixes.patch
-uml-add-some-eintr-protection.patch
-uml-remove-unused-variable.patch
-uml-make-mconsole-version-requests-happen-in-a-process.patch
-s390-move-var-declarations-behind-ifdef.patch
-fix-oddball-boolean-logic-in-s390-netiucv.patch
-s390-broken-null-test-in-claw-driver.patch
-fix-and-enable-edac-sysfs-operation.patch
-make-valid_mmap_phys_addr_range-take-a-pfn.patch
-char-rtc-handle-memory-mapped-chips-properly.patch
-char-rtc-handle-memory-mapped-chips-properly-cleanup.patch
-fix-weird-logic-in-alloc_fdtable.patch
-uninline-init_waitqueue_head.patch
-aoe-cleanup-i_rdev-usage.patch
-remove-leftover-ext3-acl-declarations.patch
-reiserfs-warn-about-the-useless-nolargeio-option.patch
-pata-pata_qdi-fix-return-code.patch
-pata-ide-jmicron-finish-writing.patch
-pata-jmicron-it-works-better-if-you-get-the-file-name-right.patch
-pata-jmicron-further-clean-up.patch
-pata-ata_jmicro-fix-an-escapee.patch
-pata-jmicron-jmicron-multifunction-setup.patch
-pata-jmicron-missed-one.patch
-pata-libata-enable-per-device-speed-setting.patch
-led-class-support-for-soekris-net48xx.patch
-led-class-support-for-soekris-net48xx-fix.patch
-pc8736x_gpio-fix-re-modprobe-errors.patch
-pc8736x_gpio-fix-re-modprobe-errors-undo-region-reservation.patch
-pc8736x_gpio-fix-re-modprobe-errors-fix-finish-cdev-init.patch
-pc8736x_gpio-fix-re-modprobe-errors-fix-finish-cdev-init-tidy.patch
-snsc-switch-from-force_sig-to-kill_proc.patch
-disallow-modular-binfmt_elf32.patch
-remove-the-tasklist_lock-export.patch
-revert-pcmcia-make-ide_cs-work-with-the-memory-space-of-cf-cards-if-io-space-is-not-available.patch
-isdn-cleanup-i_rdev-udage.patch
-knfsd-nfsd4-add-per-operation-server-stats.patch

 Merged into mainline or a subsystem tree.

+struct-file-leakage.patch
+struct-file-leakage-tweak.patch

 2.6.18-rc2 queue (actually a small part thereof)

+acpi-atlas-acpi-driver-cleanup.patch

 Tweak acpi-atlas-acpi-driver.patch (needs more work)

+acpi-fix-boot-with-acpi=off.patch
+acpi-bus-add-missing-newline.patch
+acpi-handle-firmware_register-init-errors.patch
+acpi-scan-handle-kset-kobject-errors.patch
+acpi-fix-section-for-cpu-init-functions.patch

 ACPI things.

-acpi-asus-s3-resume-fix-fix.patch

 Folded into acpi-asus-s3-resume-fix.patch

+revert-gregkh-driver-class_device_rename-remove.patch
+revert-gregkh-driver-network-class_device-to-device.patch

 Drop driver tree changes which broke netdevice naming.

+sysfs_remove_bin_file-no-return-value-dump_stack-on.patch
+drivers-base-platform-notify-needs-to-occur.patch
+kobject-must_check-fixes.patch
+drivers-base-check-errors.patch
+sysfs-add-proper-sysfs_init-prototype.patch
+scsi-device_reprobe-can-fail.patch

 Various driver-core-related fixes

+bttv-must_check-fixes.patch

 Another.

-git-gfs2-fixup.patch

 Dropped.

-remove-empty-node-at-boot-time.patch

 Dropped - had problems.

-ib-ipath-fixes-a-bug-where-our-delay-for-eeprom-no.patch

 Dropped.

+ib-mthca-fix-static-rate-returned-by-mthca_ah_query.patch
+ib-mthca-comment-fix.patch
+ib-cm-drop-req-when-out-of-memory.patch
+ib-addr-gid-structure-alignment-fix.patch
+srp-fix-fmr-error-handling.patch
+ib-cm-set-private-data-length-for-reject-messages.patch
+fmr-pool-remove-unnecessary-pointer-dereference.patch
+ib-core-use-correct-gfp_mask-in-sa_query.patch

 Infiniband updates.

+git-input-list_for_each_entry-fix-fix.patch

 Fix git-input-list_for_each_entry-fix.patch

+input-must_check-fixes.patch

 More return-value checking.

-sata-add-pci-id.patch
-2.6.17-rc4-mm1-ich8-fix.patch
-libata-debug.patch

 Dropped, or merged, or something.  I've generally lost the ATA plot.

+fixes-for-piix-driver.patch
+1-of-2-jmicron-driver.patch
+2-of-2-jmicron-driver-plumbing-and-quirk.patch
+non-libata-driver-for-jmicron-devices.patch

 ATA things.

+mtd-maps-ixp4xx-partition-parsing.patch

 MTD fix

+e1000_7033_dump_ring-fix.patch

 e1000 debug patch.

+update-smc91x-driver-with-arm-versatile-board-info.patch
+s2io-build-fix.patch

 netdev updates.

+lockdep-split-the-skb_queue_head_init-lock-class.patch

 lockdep-versus-net fix.

+include-scsi-libsash-should-include-linux-scatterlisth.patch

 Fix git-sas.patch

+drivers-returning-proper-error-from-serial-driver.patch

 Serial fixlet.

-revert-gregkh-pci-pci-test-that-drivers-properly-call-pci_set_master.patch

 Unneeded.

+pcie-check-and-return-bus_register-errors-fix.patch

 Fix pcie-check-and-return-bus_register-errors.patch

+fix-panic-when-reinserting-adaptec-pcmcia-scsi-card.patch
+fix-panic-when-reinserting-adaptec-pcmcia-scsi-card-tidy.patch
+scsi_debug-must_check-fixes.patch

 SCSI fixes.

-drivers-scsi-arcmsr-cleanups.patch
-areca-raid-linux-scsi-driver-update7.patch
-areca-raid-linux-scsi-driver-update7-fix.patch

 Folded into areca-raid-linux-scsi-driver.patch

+areca-sysfs-fix.patch

 Fix breakage due to sysfs API changes.

+gregkh-usb-usb-ohci-avoids-root-hub-timer-polling.patch
+gregkh-usb-usb-ohci-s3c2410.c-clock-now-usb-bus-host.patch
+gregkh-usb-usbcore-rename-usb_suspend_device-to-usb_port_suspend.patch
+gregkh-usb-usbcore-move-code-among-source-files.patch
+gregkh-usb-usbcore-add-usb_device_driver-definition.patch
+gregkh-usb-usbcore-make-usb_generic-a-usb_device_driver.patch
+gregkh-usb-usbcore-split-suspend-resume-for-device-and-interfaces.patch
+gregkh-usb-usbcore-resume-device-resume-recursion.patch
+gregkh-usb-usbcore-track-whether-interfaces-are-suspended.patch
+gregkh-usb-usbcore-set-device-and-power-states-properly.patch
+gregkh-usb-usbcore-fix-up-device-and-power-state-tests.patch
+gregkh-usb-usbcore-suspending-devices-with-no-driver.patch
+gregkh-usb-hub-driver-improve-use-of-ifdef.patch
+gregkh-usb-airprime_major_update.patch
+gregkh-usb-usb-serial-dynamic-id.patch

 USB updates.

+usb-hub-driver-improve-use-of-ifdef-fix.patch

 Fix it.


+git-wireless-bcm43xx-fix.patch

 Fix git-wireless.patch

+x86_64-mm-no-asm-smp.patch
+x86_64-mm-hpet-cosmetics.patch
+x86_64-mm-a-few-trivial-spelling-and-grammar-fixes.patch

 x86_64 tree updates

+mm-fix-oom-roll-back-of-__vmalloc_area_node.patch
+ia64-race-flushing-icache-in-cow-path.patch

 MM updates

+reduce-max_nr_zones-make-zone_highmem-optional-fix.patch
+reduce-max_nr_zones-make-zone_highmem-optional-fix-fix.patch
+reduce-max_nr_zones-make-zone_highmem-optional-fix-fix-fix.patch

 Fix reduce-max_nr_zones-make-zone_highmem-optional.patch a lot.

+out-of-memory-notifier.patch
+out-of-memory-notifier-tidy.patch

 OOM callout for s390.

+avr32-arch.patch
+avr32-config_debug_bugverbose-and-config_frame_pointer.patch
+avr32-fix-invalid-constraints-for-stcond.patch
+avr32-add-support-for-irq-flags-state-tracing.patch
+avr32-turn-off-support-for-discontigmem-and-sparsemem.patch
+avr32-always-enable-config_embedded.patch
+avr32-export-the-find__bit-functions.patch
+avr32-add-defconfig-for-at32stk1002.patch

 New CPU architecture (Atmel).

+i386-handle_bug-dont-print-garbage-if-debug-info.patch
+fix-a-memory-leak-in-the-i386-setup-code.patch
+i386-kexec-allow-the-kexec-on-panic-support-to-compile-on-voyager.patch
+i386-remove-redundant-might_sleep-in-user-accessors.patch
+x86-dont-randomize-stack-unless-current-personality-permits-it.patch
+i386-adds-smp_call_function_single.patch
+i386-adds-smp_call_function_single-fix.patch

 x86 updates

+swsusp-clean-up-browsing-of-pfns.patch
+swsusp-struct-snapshot_handle-cleanup.patch
+swsusp-try-to-handle-holes-better.patch

 swsusp cleanups and fix.

+uml-tidy-longjmp-macro.patch
+uml-tidy-biarch-gcc-support.patch
+uml-header-formatting-cleanups.patch

 UML updates.

+reiserfs-warn-about-the-useless-nolargeio-option.patch

 reiserfs fix.

-x86-microcode-add-sysfs-and-hotplug-support-fix-fix.patch
+x86-microcode-add-sysfs-and-hotplug-support-fix-fix-2.patch

 Updated.

+eisa-bus-modalias-attributes-support-1-fix.patch
+eisa-bus-modalias-attributes-support-1-fix-git-kbuild-fix.patch
+eisa-bus-modalias-attributes-support-1-fix-git-kbuild-fix-2.patch

 Fix eisa-bus-modalias-attributes-support-1.patch

-add-address_space_operationsbatch_write-tidy.patch

 Folded into add-address_space_operationsbatch_write.patch

+add-address_space_operationsbatch_write-fix.patch

 Fix add-address_space_operationsbatch_write.patch

+null-terminate-over-long-proc-kallsyms-symbols-fix.patch

 Fix null-terminate-over-long-proc-kallsyms-symbols.patch

+del_timer_sync-add-cpu_relax.patch
+msi-use-kmem_cache_zalloc.patch
+sysctl-allow-proc-sys-without-sys_sysctl.patch
+sysctl-scream-if-someone-uses-sys_sysctl.patch
+sysctl-document-that-sys_sysctl-will-be-removed.patch
+pid-implement-transfer_pid-and-use-it-to-simplify-de_thread.patch
+pid-remove-temporary-debug-code-in-attach_pid.patch
+hdrinstall-remove-asm-irqh-from-user-visibility.patch
+hdrinstall-remove-asm-atomich-from-user-visibility.patch
+hdrinstall-remove-asm-ioh-from-user-visibility.patch
+nommu-export-two-symbols-for-drivers-to-use.patch
+de_thread-use-tsk-not-current.patch
+update-ramdisk-documentation.patch
+ramdisk-blocksize-kconfig-entry.patch
+rtc-subsystem-add-isl1208-support.patch
+rtc-subsystem-add-isl1208-support-tweaks.patch
+lockdep-annotate-the-blkpg_del_partition-ioctl.patch
+add-try_to_freeze-to-rt-test-kthreads.patch
+drivers-block-cpqarrayc-remove-an-unused-variable.patch
+unexport-open_softirq.patch
+scx200_gpio-1-cdev-for-n-minors-cleanup.patch
+scx200_gpio-use-1-cdev-for-n-minors-not-n.patch
+improve-timekeeping-resume-robustness.patch
+add-probe_kernel_address.patch
+x86-use-probe_kernel_address-in-handle_bug.patch
+fix-sighand-siglock-usage-in-kernel-acctc.patch
+net48xx-led-cleanups.patch
+kernel-params-must_check-fixes.patch
+blockdevc-check-errors.patch
+block-handle-subsystem_register-init-errors.patch
+fs-namespace-handle-init-registration-errors.patch
+reiserfs-fix-handling-of-device-names-with-s-in-them.patch
+reiserfs-fix-handling-of-device-names-with-s-in-them-tidy.patch
+convert-idrs-internal-locking-to-_irqsave-variant.patch
+add-function-documentation-for-register_chrdev.patch
+add-function-documentation-for-register_chrdev-fix.patch
+remove-pci_dac_set_dma_mask-from-documentation-dma-mappingtxt.patch
+gpio-drop-vtable-members-gpio_set_high-gpio_set_low.patch
+gpio-cosmetics-remove-needless-newlines.patch
+gpio-rename-exported-vtables-to-better-match.patch
+vfs-fix-accessfile-x_ok-in-the-presence-of-acls.patch
+vfs-remove-redundant-open-coded-mode-bit-check-in-prepare_binfmt.patch
+vfs-remove-redundant-open-coded-mode-bit-checks-in-open_exec.patch
+lockdep-core-fix-rq-lock-handling-on-__arch_want_unlocked_ctxsw.patch
+tpm-fix-failure-path-leak.patch
+actual-mailing-list-in-maintainers.patch
+symlink-nesting-level-change.patch
+tpm-interrupt-clear-fix.patch
+tpm-add-force-device-probe-option.patch
+tpm_tis-use-resource_size_t.patch
+let-the-the-lockdep-options-depend-on-debug_kernel.patch
+fix-security-check-for-joint-context=-and-fscontext=-mount.patch
+make-prot_write-imply-prot_read.patch
+debug-variants-of-linked-list-macros.patch

 Misc fixes and updates and cleanups.

+vectorize-aio_read-aio_write-fileop-methods-xfs-fix.patch
+vectorize-aio_read-aio_write-fileop-methods-hypfs-fix.patch

 Fix vectorize-aio_read-aio_write-fileop-methods.patch

+list_islast-utility.patch

 Add list_islast().  (eh?  Will change this to list_is_last()).

+per-task-delay-accounting-taskstats-interface-fix.patch
+per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-fix.patch
+per-task-delay-accounting-taskstats-interface-documentation-fix.patch
+per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix-2.patch
+per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix-3.patch
+per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix-cleanup.patch
+per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix-cleanup-fix.patch
+remove-down_write-from-taskstats-code-invoked-on-the-exit-path.patch

 Various fixes and improvements to the per-task-delay-accounting patches in
 -mm.

+stack-overflow-safe-kdump-safe_smp_processor_id.patch
+stack-overflow-safe-kdump-safe_smp_processor_id_voyager.patch
+stack-overflow-safe-kdump-crash_use_safe_smp_processor_id.patch
+stack-overflow-safe-kdump-crash_use_safe_smp_processor_id-fix.patch
+stack-overflow-safe-kdump-safe_smp_send_nmi_allbutself.patch

 Make kdump more robust.

+isdn4linux-gigaset-driver-fix-__must_check-warning.patch

 i4l fixlet.

+namespaces-utsname-sysctl-hack-fix.patch

 Fix namespaces-utsname-sysctl-hack.patch

+reiser4-vs-streamline-generic_file_-interfaces-and-filemap.patch
+reiser4-vs-streamline-generic_file_-interfaces-and-filemap-fix.patch

 Update reiser4 for other patches in -mm.

+drivers-ide-cleanups.patch
+ide-core-must_check-fixes.patch

 IDE updates.

-cirrus-logic-framebuffer-i2c-support.patch
-cirrus-logic-framebuffer-i2c-support-fix.patch

 Dropped.

+mbxfb-add-framebuffer-driver-for-the-intel-2700g.patch
+fbdev-statically-link-the-framebuffer-notification-functions.patch

 fbdev updates.

+add-hypertransport-capability-defines.patch
+add-hypertransport-capability-defines-fix.patch
+initial-generic-hypertransport-interrupt-support.patch
+initial-generic-hypertransport-interrupt-support-Kconfig-fix.patch

 Hypertransport feature work.

+srcu-3-add-srcu-operations-to-rcutorture-fix.patch

 Update srcu.

+add-srcu-based-notifier-chains.patch

 Use it for something.

+the-scheduled-removal-of-some-oss-drivers-fix-fix.patch
+kill-sound-oss-_symsc.patch

 Fiddle with OSS drivers some more.

+debug-shared-irqs-kconfig-fix.patch

 Fix debug-shared-irqs.patch

+jmicron-warning-fix.patch

 Fix some warning.



All 772 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/patch-list


