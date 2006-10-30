Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbWJ3AAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbWJ3AAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 19:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWJ3AAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 19:00:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030461AbWJ3AAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 19:00:18 -0500
Date: Sun, 29 Oct 2006 16:00:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc3-mm1
Message-Id: <20061029160002.29bb2ea1.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc3/2.6.19-rc3-mm1/

- ia64 doesn't compile due to improvements in acpi.  I already fixed a huge
  string of build errors due to this and it's someone else's turn.

- For some reason Greg has resurrected the patches which detect whether
  you're using old versions of udev and if so, punish you for it.

  If weird stuff happens, try upgrading udev.




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



Changes since 2.6.19-rc2-mm2:


 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input-fixup.patch
 git-libata-all.patch
 git-mips.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-ioat.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-r8169.patch
 git-pciseg.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-sas.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees

-e100-fix-reboot-f-with-netconsole-enabled.patch
-direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write.patch
-ecryptfs-use-special_file.patch
-export-clear_queue_congested-and-set_queue_congested.patch
-separate-bdi-congestion-functions-from-queue-congestion-functions.patch
-make-linux-personalityh-userspace-proof.patch
-uml-mode_tt-is-bust.patch
-fix-typo-in-memory-barrier-docs.patch
-uml-remove-some-leftover-ppc-code.patch
-uml-split-memory-allocation-prototypes-out-of-userh.patch
-uml-code-convention-cleanup-of-a-file.patch
-uml-reenable-compilation-of-enable_timer-disabled-by-mistake.patch
-uml-use-defconfig_list-to-avoid-reading-hosts-config.patch
-uml-cleanup-run_helper-api-to-fix-a-leak.patch
-uml-kconfig-silence-warning.patch
-uml-mmapper-remove-just-added-but-wrong-const-attribute.patch
-kconfig-serial-typos.patch
-fix-acpi-processor-native-c-states-using-mwait.patch
-genirq-clean-up-irq-flow-type-naming-fix.patch
-readjust-comments-of-task_timeslice-for-kernel-doc.patch
-acpimemory-hotplug-change-log-level-of-a-message-of-acpi_memhotplug-to-kern_debug.patch
-acpimemory-hotplug-remove-strange-add_memory-fail-message.patch
-oom-killer-meets-userspace-headers.patch
-irq-updates-make-eata_pio-compile.patch
-fix-warnings-for-warn_on-if-config_bug-is-disabled.patch
-cad_pid-sysctl-with-proc_fs=n.patch
-fs-kconfig-move-generic_acl-fix-acl-call-errors.patch
-autofs3-make-sure-all-dentries-refs-are-released-before-calling-kill_anon_super.patch
-nfsv4-fix-thinko-in-fs-nfs-superc.patch
-nfs-fix-oops-in-nfs_cancel_commit_list.patch
-nfs-fix-error-handling-in-nfs_direct_write_result.patch
-nfs4-initialize-cl_ipaddr.patch
-nfs-fix-nfsv4-callback-regression.patch
-nfs-deal-with-failure-of-invalidate_inode_pages2.patch
-nfs-fix-minor-bug-in-new-nfs-symlink-code.patch
-nfs-__nfs_revalidate_inode-can-use-inode-before.patch
-nfs-remove-unused-check-in-nfs4_open_revalidate.patch
-sunrpc-fix-race-in-in-kernel-rpc-portmapper-client.patch
-sunrpc-fix-a-typo.patch
-bug-nfsd-nfs4xdrc-misuse-of-err_ptr.patch
-fix-svc_procfunc-declaration.patch
-lockd-endianness-annotations.patch
-xdr-annotations-nfsv2.patch
-xdr-annotations-nfsv3.patch
-xdr-annotations-nfsv4.patch
-xdr-annotations-nfs-readdir-entries.patch
-fs-nfs-callback-passes-error-values-big-endian.patch
-xdr-annotations-fs-nfs-callback.patch
-nfs-verifier-is-network-endian.patch
-xdr-annotations-mount_clnt.patch
-nfs_common-endianness-annotations.patch
-nfsd-nfserrno-endianness-annotations.patch
-nfsfh-simple-endianness-annotations.patch
-xdr-annotations-nfsd_dispatch.patch
-xdr-annotations-nfsv2-server.patch
-xdr-annotations-nfsv3-server.patch
-xdr-annotations-nfsv4-server.patch
-nfsd-vfsc-endianness-annotations.patch
-nfsd-nfs4-code-returns-error-values-in-net-endian.patch
-nfsd-nfsv23-trivial-endianness-annotations-for-error-values.patch
-nfsd-nfsv4-errno-endianness-annotations.patch
-xdr-annotations-nfsd-callback.patch
-nfsd-misc-endianness-annotations.patch
-nfsd-nfs_replay_me.patch
-fix-potential-interrupts-during-alternative-patching-was.patch
-highest_possible_node_id-linkage-fix.patch
-drivers-isdn-ioremap-balanced-with-iounmap.patch
-doc-fixing-cpu-hotplug-documentation.patch
-mmd-cache-aliasing-issue-in-cow_user_page.patch
-ipmi-fix-return-codes-in-failure-case.patch
-firmware-dcdbas-add-size-check-in-smi_data_write.patch
-mm-more-comment-lockorder.patch
-ext3-fix-j_asserttransaction-t_updates-0-in-journal_stop.patch
-kernel-nsproxyc-use-kmemdup.patch
-knfsd-fix-race-that-can-disable-nfs-server.patch
-one-more-arm-irq-fix.patch
-uml-fix-prototypes.patch
-uml-make-execvp-safe-for-our-usage.patch
-tty-signal-tty-locking.patch
-char-correct-pci_get_device-changes.patch
-drivers-ide-pci-genericc-re-add-the-__setupall-generic-ide.patch
-md-fix-calculation-of-degraded-for-multipath-and-raid10.patch
-md-add-another-compat_ioctl-for-md.patch
-md-endian-annotation-for-v1-superblock-access.patch
-md-endian-annotations-for-the-bitmap-superblock.patch
-clocksource-acpi_pm-add-another-greylist-chipset.patch
-pci-declare-pci_get_device_reverse.patch
-rpaphp-build-fix.patch
-vfs-make-d_materialise_unique-enforce-directory.patch
-nfs-cache-invalidation-fixup.patch
-mm-clean-up-pagecache-allocation.patch
-vmscan-fix-temp_priority-race.patch
-vmscan-fix-temp_priority-race-comments.patch
-vmscan-fix-temp_priority-in-__zone-reclaim.patch
-acpi-add-removable-drive-bay-support.patch
-fix-up-a-multitude-of-acpi-compiler-warnings-on-x86_64.patch
-i386-acpi-build-fix.patch
-add-support-for-the-generic-backlight-device-to-the-ibm-acpi-driver.patch
-add-support-for-the-generic-backlight-device-to-the-ibm-acpi-driver-fix.patch
-add-support-for-the-generic-backlight-device-to-the-ibm-acpi-driver-fix-2.patch
-add-support-for-the-generic-backlight-device-to-the-asus-acpi-driver.patch
-add-support-for-the-generic-backlight-device-to-the-asus-acpi-driver-fix.patch
-add-support-for-the-generic-backlight-device-to-the-toshiba-acpi-driver.patch
-add-support-for-the-generic-backlight-device-to-the-toshiba-acpi-driver-fix.patch
-acpi-cpufreq-remove-dead-code.patch
-cpufreq-handle-sysfs-errors.patch
-speedstep-centrino-remove-dead-code.patch
-driver-core-fixes-make_class_name-retval-check.patch
-driver-core-fixes-check-for-return-value-of-sysfs_create_link.patch
-driver-core-dont-ignore-bus_attach_device-retval.patch
-drm-fix-error-returns-sysfs-error-handling.patch
-drm-fix-return-code-in-error-case.patch
-gregkh-i2c-w1-ioremap-balanced-with-iounmap.patch
-remove-unnecessary-check-in-drivers-video-intelfb-intelfbhwc.patch
-intel-fb-switch-to-pci_get-api.patch
-ata-must-depend-on-block.patch
-ahci-readability-tweak.patch
-libata-sff-allow-for-wacky-systems.patch
-pata_marvell-marvell-6101-6145-pata-driver.patch
-pata_marvell-switch-to-pci_iomap-as-jeff-asked.patch
-pata_marvell-switch-to-pci_iomap-as-jeff-asked-fix.patch
-libata-use-correct-map_db-values-for-ich8.patch
-drivers-mmcmisc-handle-pci-errors-on-resume.patch
-mmc-when-rescanning-cards-check-existing-cards-after-mmc_setup.patch
-mtd-maps-add-parameter-to-amd76xrom-to-override-rom-window-size-if-set-incorrectly-by-bios.patch
-mtd-chips-support-for-sst-49lf040b-flash-chip.patch
-mtd-maps-support-for-bios-flash-chips-on-intel-esb2-southbridge.patch
-jffs2-use-rb_first-and-rb_last-cleanup.patch
-mtd-fix-comment-typo-devic.patch
-esb2rom-use-hotplug-safe-interfaces.patch
-ibmveth-fix-index-increment-calculation.patch
-e1000-reset-all-functions-after-a-pci-error.patch
-revert-mv643xx-add-pci-device-table-for-auto-module-loading.patch
-ipv6-dccp-fix-memory-leak-in-dccp_v6_do_rcv.patch
-drivers-atm-no-need-to-return-void.patch
-atm-firestream-handle-thrown-error.patch
-wan-pc300-handle-propagate-minor-errors.patch
-net-atm-handle-sysfs-errors.patch
-nicstar-fix-a-bogus-casting-warning.patch
-pcmcia-update-alloc_io_space-for-conflict-checking-for-multifunction-pc-card-for-linux-kernel-26154.patch
-pcmcia-ds-must_check-fixes.patch
-config_pm=n-slim-drivers-pcmcia.patch
-i82092-wire-up-errors-from-pci_register_driver.patch
-drivers-net-pcmcia-xirc2ps_csc-remove-unused-label.patch
-pcmcia-au1000_generic-fix.patch
-ioremap-balanced-with-iounmap-for-drivers-pcmcia.patch
-export-soc_common_drv_pcmcia_remove-to-allow-modular-pcmcia.patch
-perle-multimodem-card-pci-ras-detection.patch
-pcmcia-handle-sysfs-pci-errors.patch
-reset-pci-device-state-to-unknown-state-for-resume.patch
-x86-64-mmconfig-missing-printk-levels.patch
-remove-quirk_via_abnormal_poweroff.patch
-drivers-scsi-aic7xxx-possible-cleanups.patch
-make-drivers-scsi-aic7xxx-aic79xx_coreahd_set_tags-static.patch
-megaraid-check-for-firmware-version.patch
-ioremap-balanced-with-iounmap-drivers-scsi-zalonc.patch
-ioremap-balanced-with-iounmap-drivers-scsi-sun3_scsic.patch
-ioremap-balanced-with-iounmap-drivers-scsi-sun3_scsi_vmec.patch
-ioremap-balanced-with-iounmap-drivers-scsi-seagatec.patch
-ioremap-balanced-with-iounmap-drivers-scsi-qlogicptic.patch
-ioremap-balanced-with-iounmap-drivers-scsi-nsp32c.patch
-ioremap-balanced-with-iounmap-drivers-scsi-ncr53c8xxc.patch
-ioremap-balanced-with-iounmap-drivers-scsi-fdomainc.patch
-ioremap-balanced-with-iounmap-drivers-scsi-amiga7xxc.patch
-scsi-convert-ninja-driver-to-struct-scsi_cmnd.patch
-fc4-conversion-to-struct-scsi_cmnd-in-fc4.patch
-dereference-in-drivers-scsi-lpfc-lpfc_ctc.patch
-scsi-scsi_cmnd-convertion-in-sun3-driver.patch
-scsi-scsi_cmnd-conversion-in-qlogicfas408-driver.patch
-scsi-scsi_cmnd-convertion-in-psi240i-driver.patch
-aic94xx-sata-tag-mask-not-set-correctly.patch
-maintain-module-parameter-name-consistency-with-qla2xxx-qla4xxx.patch
-scsi_libc-use-build_bug_on.patch
-scsi-minor-bug-fixes-and-cleanups.patch
-scsi-qla2xxx-handle-sysfs-errors.patch
-switch-fdomain-to-the-pci_get-api.patch
-drivers-scsi-handcrafted-min-max-macro-removal.patch
-drivers-scsi-handcrafted-min-max-macro-removal-fix.patch
-fix-pxa2xx-udc-compilation-error.patch
-hid-core-big-endian-fix-fix.patch
-x86_64-mm-sparse-memory-srat.patch
-x86_64-mm-io-apic-vector-typo.patch
-x86_64-mm-overlapping-program-headers-in-physical-addr-space-fix.patch
-x86_64-mm-fix-.cfi_signal_frame-copy-n-paste-error.patch
-x86_64-mm-fix-for-arch-x86_64-pci-makefile-cflags.patch
-x86_64-mm-e820-page-align.patch
-x86_64-mm-accumulate-args.patch
-x86_64-mm-unwinder-speedup.patch
-x86_64-mm-x86_64-add-nx-mask-for-pte-entry.patch
-x86_64-mm-i386-fake-return-address.patch
-x86_64-dump_trace-atomicity-fix.patch
-x86_64-irq-use-irq_domain-in-ioapic_retrigger_irq.patch
-x86_64-put-more-than-one-cpu-in-target_cpus.patch
-x86-resend-remove-last-two-pci_find-offenders-in-the.patch
-i386-use-asm-offsets-for-the-offsets-of-registers-into-the-pt_regs-struct-rather-than-having-hard-coded-constants.patch
-i386-pda-basic-definitions-for-i386-pda.patch
-i386-pda-initialize-the-per-cpu-data-area.patch
-i386-pda-initialize-the-per-cpu-data-area-voyager-fix.patch
-i386-pda-use-%gs-as-the-pda-base-segment-in-the-kernel.patch
-i386-pda-fix-places-where-using-%gs-changes-the-usermode-abi.patch
-i386-pda-update-sys_vm86-to-cope-with-changed-pt_regs-and-%gs-usage.patch
-i386-pda-implement-smp_processor_id-with-the-pda.patch
-i386-pda-implement-current-with-the-pda.patch
-i386-pda-store-the-interrupt-regs-pointer-in-the-pda.patch
-unwinder-speedup-tweaks.patch
-paravirt-skip-timer-works.patch
-paravirt-skip-timer-works-tidy.patch
-paravirt-interrupts-subarch-cleanup.patch
-paravirt-fix-missing-pte-update.patch
-paravirt-fix-bad-mmu-names.patch
-paravirt-mmu-header-movement.patch
-pktcdvd-reusability-of-procfs-functions.patch
-pktcdvd-make-procfs-interface-optional.patch
-qla1280-bus-reset-typo.patch
-pktcdvd-bio-write-congestion-using-blk_congestion_wait.patch
-pktcdvd-bio-write-congestion-using-blk_congestion_wait-fix.patch
-sparc-clean-up-asm-sparc-elfh-pollution-in-userspace.patch

 Merged into mainline or a subsystem tree.

+ioc4_serial-irq-flags-fix.patch

 ioc4_serial fix

+ndiswrapper-dont-set-the-module-taints-flags.patch
+let-pci_multithread_probe-depend-on-broken.patch
+isdn-gigaset-avoid-cs-dev-null-pointer-dereference.patch
+m68k-consolidate-initcall-sections.patch
+taskstats-fix-sk_buff-leak.patch
+taskstats-fix-sk_buff-size-calculation.patch
+lockdep-annotate-declare_wait_queue_head.patch
+cryptocop-double-spin_lock_irqsave.patch
+mtd-fix-last-kernel-doc-warning.patch
+docbook-make-a-filesystems-book.patch
+fix-remove-the-use-of-_syscallx-macros-in-uml.patch
+uml-fix-compilation-options-for-user_objs.patch
+xacct_add_tsk-fix-pure-theoretical-mm-use-after-free.patch
+drivers-ide-pci-genericc-add-missing-newline-to-the-all-generic-ide-message.patch
+uml-ubd-driver-allow-using-up-to-16-ubd-devices.patch
+uml-ubd-driver-document-some-struct-fields.patch
+uml-ubd-driver-var-renames.patch
+uml-ubd-driver-give-better-names-to-some-functions.patch
+uml-ubd-driver-change-ubd_lock-to-be-a-mutex.patch
+uml-ubd-driver-ubd_io_lock-usage-fixup.patch
+uml-ubd-driver-reformat-ubd_config.patch
+uml-ubd-driver-convert-do_ubd-to-a-boolean-variable.patch
+uml-ubd-driver-use-bitfields-where-possible.patch
+uml-ubd-driver-do-not-store-error-codes-as-fd.patch
+uml-ubd-driver-various-little-changes.patch

 2.6.19 queue.

+fs-prepare_write-fixes-fat-fix.patch

 Hopefully mostly fix fatfs

+git-acpi-fixup.patch
+git-acpi-more-build-fixes.patch
+git-acpi-build-fix-99.patch
+git-acpi-mmconfig-warning-fix.patch
+git-acpi-cpufreq-fix.patch
+git-acpi-cpufreq-fix-2.patch
+git-acpi-printk-warning-fix.patch

 Attempt to repair acpi disaster

+acpi-fix-single-linked-list-manipulation.patch

 acpi fix

+gregkh-driver-w1-ioremap-balanced-with-iounmap.patch
+gregkh-driver-driver-core-add-notification-of-bus-events.patch
+gregkh-driver-cleanup-virtual_device_parent.patch
+gregkh-driver-config_sysfs_deprecated.patch
+gregkh-driver-udev-compatible-hack.patch
+gregkh-driver-config_sysfs_deprecated-bus.patch
+gregkh-driver-config_sysfs_deprecated-device.patch
+gregkh-driver-config_sysfs_deprecated-PHYSDEV.patch
+gregkh-driver-config_sysfs_deprecated-class.patch
+gregkh-driver-vt-device.patch
+gregkh-driver-vc-device.patch
+gregkh-driver-misc-devices.patch
+gregkh-driver-tty-device.patch
+gregkh-driver-raw-device.patch
+gregkh-driver-i2c-dev-device.patch
+gregkh-driver-msr-device.patch
+gregkh-driver-cpuid-device.patch
+gregkh-driver-ppp-device.patch
+gregkh-driver-ppdev-device.patch
+gregkh-driver-mmc-device.patch
+gregkh-driver-firmware-device.patch
+gregkh-driver-fb-device.patch
+gregkh-driver-mem-devices.patch
+gregkh-driver-sound-device.patch
+gregkh-driver-network-device.patch

 driver tree udpates.  Known to break old udev setups, but published
 nonetheless.

+revert-gregkh-driver-tty-device.patch

 Make my udev setup work.

+driver-core-fixes-make_class_name-retval-checks.patch
+driver-core-fixes-sysfs_create_link-retval-checks-in.patch
+driver-core-dont-stop-probing-on-probe-errors.patch
+driver-core-change-function-call-order-in.patch
+driver-core-per-subsystem-multithreaded-probing.patch
+driver-core-dont-fail-attaching-the-device-if-it.patch

 retrn-value checking

+nozomi-irq-flags-fixes.patch

 Fx nozomi driver some more.

+call-platform_notify_remove-later.patch

 benh stuff.

-git-dvb-fixup.patch

 Dropped.

+jdelvare-i2c-i2c-at91-new-bus-driver.patch

 I2C tree update

+ia64-cpu-hotplug-fix-conflict-between-cpu-hot-add-and-ipi.patch

 ia64 fix

+lightning-return-proper-return-code.patch

 input driver fix

+pa-risc-fix-bogus-warnings-from-modpost.patch
+kconfig-refactoring-for-better-menu-nesting.patch
+kbuild-fix-rr-is-now-default.patch

 kbuild/kconfig fixes

+sata_nv-adma-ncq-support-for-nforce4-v7.patch

 Updated sata driver

+sata_sis-fix-flags-handling-for-the-secondary-port.patch
+ata-generic-platform_device-libata-driver-take-2.patch

 sata things

+mtd-fix-printk-format-warning.patch

 MTD fix

+git-net-configh-got-removed.patch
+netxen-build-fix.patch
+netxen-more-build-fixes.patch

 git-netdev-all fixes

+defxx-big-endian-hosts-support.patch
+ehea-kzalloc-gfp_atomic-fix.patch

 netdev updates

+net-fix-uaccess-handling.patch
+n2-fix-confusing-error-code.patch
+tokenring-fix-module_init-error-handling.patch

 net fixes

+nfs-nfsaclsvc_encode_getaclres-fix-potential-null-deref-and-tiny-optimization.patch
+gss_spkm3-fix-error-handling-in-module-init.patch
+sunrpc-add-missing-spin_unlock.patch
+auth_gss-unregister-gss_domain-when-unloading-module.patch
+nfs-fix-nfs_readpages-error-path.patch

 NFS things

+gfs2-dont-panic-needlessly.patch

 gfs2 fixlet

+parisc-use-unsigned-long-flags-in-semaphore-code.patch
+parisc-fix-module_param-iommu-permission.patch

 parisc things

+ppc-booke-reg-mcsr-msg-misquoted.patch
+ppc4xx-compilation-fixes-for-pci-less-configs.patch

 ppc things

+perle-multimodem-card-pci-ras-detection.patch

 serial driver update

-gregkh-pci-pci-check-that-mwi-bit-really-did-get-set.patch

 PCI tree update

-revert-gregkh-pci-pci-check-that-mwi-bit-really-did-get-set.patch

 Dropped

+pci-fix-__pci_register_driver-error-handling.patch
+acpiphp-fix-missing-acpiphp_glue_exit.patch

 PCI updates

+scsi-minor-bug-fixes-and-cleanups.patch
+scsi-t128-scsi_cmnd-convertion.patch
+scsi-whitespace-cleanup-in-the-dpt-driver.patch
+scsi-fix-uaccess-handling.patch

 SCSI updates

+gregkh-usb-sierra-new-device.patch
+gregkh-usb-hid-core-big-endian-fix-fix.patch

 USB tree updates

+x86_64-mm-dump_trace-atomicity-fix.patch
+x86_64-mm-entry-cleanup.patch
+x86_64-mm-pda-asm-offset.patch
+x86_64-mm-pda-basics.patch
+x86_64-mm-pda-percpu-init.patch
+x86_64-mm-pda-gs-base.patch
+x86_64-mm-pda-interface.patch
+x86_64-mm-pda-vm86.patch
+x86_64-mm-pda-smp-processor-id.patch
+x86_64-mm-pda-current.patch
+x86_64-mm-pda-int-regs.patch
+x86_64-mm-paravirt-skip-timer.patch
+x86_64-mm-paravirt-subarch-cleanup.patch
+x86_64-mm-no-nested-idle-loops.patch
+x86_64-mm-paravirt-pte-update-common.patch
+x86_64-mm-paravirt-pte-update-prep.patch
+x86_64-mm-paravirt-header-cleanup.patch
+x86_64-mm-remove-pci_find.patch
+x86_64-mm-nmi-message.patch
+x86_64-mm-compat-siocsifhwbroadcast.patch
+x86_64-mm-i386-reloc-abssym.patch
+x86_64-mm-i386-reloc-cleanup-align.patch
+x86_64-mm-i386-reloc-data-4k-aligned.patch
+x86_64-mm-i386-reloc-pa-symbol.patch
+x86_64-mm-i386-reloc-cleanup-kernel-res.patch
+x86_64-mm-i386-reloc-physical-start.patch
+x86_64-mm-i386-reloc-kallsyms.patch
+x86_64-mm-i386-reloc-core.patch
+x86_64-mm-i386-reloc-warn.patch
+x86_64-mm-i386-reloc-bzimage.patch
+x86_64-mm-desc-defs.patch
+x86_64-mm-strange-work_notifysig-code-since-2.6.16.patch
+x86_64-mm-cpa-clflush.patch
+x86_64-mm-i386-clflush-size.patch
+x86_64-mm-i386-cpa-clflush.patch
+x86_64-mm-gh-sync-tsc.patch
+x86_64-mm-i386-create-e820.c-to-handle-standard-io-mem-resources.patch
+x86_64-mm-i386-create-e820.c-about-e820-map-sanitize-and-copy-function.patch
+x86_64-mm-i386-create-e820.c-to-handle-find_max_pfn-function.patch
+x86_64-mm-i386-create-e820.c-to-handle-memmap-table-walking.patch
+x86_64-mm-i386-create-e820.c-about-memap-boot-param-parse-and-print.patch

 x86 tree updates

+revert-x86_64-mm-cpa-clflush.patch

 It broke.

+x86_64-irq-reuse-vector-for-__assign_irq_vector.patch
+i386-mark-config_relocatable-experimental.patch
+prep-for-paravirt-be-careful-about-touching-bios.patch
+prep-for-paravirt-be-careful-about-touching-bios-warning-fix.patch
+prep-for-paravirt-cpu_detect-extraction.patch
+prep-for-paravirt-desch-clearer-parameter-names.patch
+prep-for-paravirt-desch-clearer-parameter-names-fix.patch
+prep-for-paravirt-rearrange-processorh.patch
+i386-mm-substitute-__va-lookup-with-pfn_to_kaddr.patch
+i386-extend-bzimage-protocol-for-relocatable-protected-mode-kernel.patch
+x86_64-irq-reset-more-to-default-when-clear-irq_vector-for-destroy_irq.patch
+make-x86_64-udelay-round-up-instead-of-down.patch
+i386-x86_64-comment-magic-constants-in-delayh.patch

 x86 updates

+vmalloc-optimization-cleanup-bugfixes.patch
+vmalloc-optimization-cleanup-bugfixes-tweak.patch
+mm-slab-eliminate-lock_cpu_hotplug-from-slab.patch

 MM updates

+add-include-linux-freezerh-and-move-definitions-from.patch
+add-include-linux-freezerh-and-move-definitions-from-ueagle-fix.patch
+quieten-freezer-if-config_pm_debug.patch
+swsusp-cleanup-whitespace-in-freezer-output.patch
+swsusp-thaw-userspace-and-kernel-space-separately.patch
+swsusp-support-i386-systems-with-pae-or-without-pse.patch

 swsusp updates

+uml-fix-prototypes.patch
+uml-make-execvp-safe-for-our-usage.patch

 UML

+edac_mc-fix-error-handling.patch
+kbuild-dont-put-temp-files-in-the-source-tree-fix.patch
+drivers-add-lcd-support-update-4.patch
+lockdep-internal-locking-fixes.patch
+lockdep-misc-fixes-in-lockdepc.patch
+cpuset-remove-sched-domain-hooks-from-cpusets.patch
+binfmt_elf-randomize-pie-binaries.patch
+handle-ext3-directory-corruption-better.patch
+handle-ext4-directory-corruption-better.patch
+sysctl-allow-a-zero-ctl_name-in-the-middle-of-a-sysctl-table.patch
+sysctl-implement-ctl_unnumbered.patch
+enforce-unsigned-long-flags-when-spinlocking.patch
+tifm-fix-null-ptr-and-style.patch
+function-v9fs_get_idpool-returns-int-not-u32-as-called-twice.patch
+disable-clone_child_cleartid-for-abnormal-exit.patch
+binfmt-fix-uaccess-handling.patch
+compat-fix-uaccess-handling.patch
+profile-fix-uaccess-handling.patch
+kconfig-printk_time-depends-on-printk.patch
+parport_pc-add-support-for-ox16pci952-parallel-port.patch
+probe_kernel_address-needs-to-do-set_fs.patch
+slab-use-probe_kernel_address.patch
+paride-return-proper-error-code.patch
+read_cache_pages-cleanup.patch

 Misc

+tty-signal-tty-locking.patch
+tty-signal-tty-locking-3270-fix.patch
+do_task_stat-dont-take-tty_mutex.patch
+do_acct_process-dont-take-tty_mutex.patch
+trivial-make-set_special_pids-static.patch
+sys_unshare-remove-a-broken-clone_sighand-code.patch

 TTY locking update

+pktcdvd-reusability-of-procfs-functions.patch
+pktcdvd-make-procfs-interface-optional.patch
+pktcdvd-bio-write-congestion-using-blk_congestion_wait.patch
+pktcdvd-bio-write-congestion-using-blk_congestion_wait-fix.patch
+pktcdvd-add-sysfs-and-debugfs-interface.patch

 packet driver updates

+isdn-gigaset-use-bitrev8.patch

 Cleanup

+vfs-change-struct-file-to-use-struct-path.patch
+sysfs-change-uses-of-f_dentry.patch
+proc-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
+ext2-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
+ext3-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
+ext4-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
+fat-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
+isofs-change-uses-of-f_dentry.patch
+nfs-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
+nfsd-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
+ntfs-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
+i386-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
+x86_64-change-uses-of-f_dentry.patch
+kernel-change-uses-of-f_dentry.patch
+mm-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
+9p-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
+affs-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
+autofs-change-uses-of-f_dentry.patch
+autofs4-change-uses-of-f_dentry.patch
+configfs-change-uses-of-f_dentry.patch
+cifs-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
+ecryptfs-change-uses-of-f_dentry.patch
+xfs-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
+struct-path-convert-adfs.patch
+struct-path-convert-afs.patch
+struct-path-convert-alpha.patch
+struct-path-convert-atm.patch
+struct-path-convert-befs.patch
+struct-path-convert-bfs.patch
+struct-path-convert-block.patch
+struct-path-convert-block_drivers.patch
+struct-path-convert-char-drivers.patch
+struct-path-convert-coda.patch
+struct-path-convert-cosa.patch
+struct-path-convert-cramfs.patch
+struct-path-convert-cris.patch
+struct-path-convert-drm.patch
+struct-path-convert-efs.patch
+struct-path-convert-freevxfs.patch
+struct-path-convert-frv.patch
+struct-path-convert-fuse.patch
+struct-path-convert-gfs2.patch
+struct-path-convert-hfs.patch
+struct-path-convert-hfsplus.patch
+struct-path-convert-hostfs.patch
+struct-path-convert-hpfs.patch
+struct-path-convert-hppfs.patch
+struct-path-convert-hugetlbfs.patch
+struct-path-convert-i2c-drivers.patch
+struct-path-convert-ia64.patch
+struct-path-convert-ieee1394.patch
+struct-path-convert-infiniband.patch
+struct-path-convert-ipc.patch
+struct-path-convert-ipmi.patch
+struct-path-convert-isapnp.patch
+struct-path-convert-isdn.patch
+struct-path-convert-ixj.patch
+struct-path-convert-jffs.patch
+struct-path-convert-jffs2.patch
+struct-path-convert-jfs.patch
+struct-path-convert-kernel.patch
+struct-path-convert-lockd.patch
+struct-path-convert-md.patch
+struct-path-convert-minix.patch
+struct-path-convert-mips.patch
+struct-path-convert-mm.patch
+struct-path-convert-nbd.patch
+struct-path-convert-ncpfs.patch
+struct-path-convert-net.patch
+struct-path-convert-netfilter.patch
+struct-path-convert-netlink.patch
+struct-path-convert-ocfs2.patch
+struct-path-convert-openpromfs.patch
+struct-path-convert-oprofile.patch
+struct-path-convert-parisc.patch
+struct-path-convert-pci.patch
+struct-path-convert-pcmcia.patch
+struct-path-convert-powerpc.patch
+struct-path-convert-ppc.patch
+struct-path-convert-qnx4.patch
+struct-path-convert-ramfs.patch
+struct-path-convert-reiserfs.patch
+struct-path-convert-romfs.patch
+struct-path-convert-s390-drivers.patch
+struct-path-convert-s390.patch
+struct-path-convert-sbus.patch
+struct-path-convert-scsi.patch
+struct-path-convert-selinux.patch
+struct-path-convert-sh.patch
+struct-path-convert-smbfs.patch
+struct-path-convert-sound.patch
+struct-path-convert-sparc.patch
+struct-path-convert-sparc64.patch
+struct-path-convert-splice.patch
+struct-path-convert-sunrpc.patch
+struct-path-convert-sysv.patch
+struct-path-convert-udf.patch
+struct-path-convert-ufs.patch
+struct-path-convert-unix.patch
+struct-path-convert-usb.patch
+struct-path-convert-v4l.patch
+struct-path-convert-video.patch
+struct-path-convert-zorro.patch

 102 patches to do something rather pointless.

+add-process_session-helper-routine-deprecate-old-field-fix-warnings-fix.patch

 Yet more fixes to add-process_session-helper-routine-deprecate-old-field-tidy.patch

+sys_setpgid-eliminate-unnecessary-do_each_task_pidpidtype_pgid.patch
+session_of_pgrp-kill-unnecessary-do_each_task_pidpidtype_pgid.patch

 Core kernel fixes

+mxser-session-warning-fix.patch

 Fix mxser for other patches in -mm.

+tty-switch-to-ktermios-sclp-fix.patch
+tty-switch-to-ktermios-3270-fix.patch
+tty-switch-to-ktermios-powerpc-fix.patch

 Fix the termios patches in -mm.

+char-isicom-use-completion.patch
+char-isicom-simplify-timer.patch
+char-isicom-remove-cvs-stuff.patch
+char-sx-convert-to-pci-probing.patch
+char-sx-use-kcalloc.patch
+char-sx-mark-functions-as-devinit.patch
+char-sx-use-eisa-probing.patch
+char-sx-ifdef-isa-code.patch
+char-stallion-convert-to-pci-probing.patch
+char-stallion-prints-cleanup.patch
+char-stallion-implement-fail-paths.patch
+char-stallion-correct-__init-macros.patch

 Various fixes and cleanups against various serial drivers.

+isdn-fix-missing-unregister_capi_driver.patch

 isdn fix

+add-include-linux-freezerh-and-move-definitions-from-prefetch.patch

 Update swap-prefetch for other patches in -mm.

+resier4-add-include-linux-freezerh-and-move-definitions-from.patch
+reiser4-fix-missed-unlock-and-exit_context.patch
+reiser4-use-list_empty-instead-of-list_empty_careful-for.patch

 reiser4 updates

+video-sis-remove-unnecessary-variables-in-sis_ddc2delay.patch

 fbdev driver cleanup

+statistics-infrastructure-fix-buffer-overflow-in-histogram-with-linear.patch
+statistics-infrastructure-fix-buffer-overflow-in-histogram-with-linear-tidy.patch
+statistics-infrastructure-adapt-output-format-of-utilisation-indicator.patch

 Fix statistics patches in -mm.

+dio-lock-refcount-operations.patch

 More direct-io work

-x86-e820-debugging.patch

 Dropped

-mm-only-i_size_write-debugging.patch
-mm-only-i_size_write-debugging-fix.patch

 Dropped



All 1028 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc3/2.6.19-rc3-mm1/patch-list


