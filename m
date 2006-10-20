Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWJTI4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWJTI4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 04:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWJTI4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 04:56:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932216AbWJTI4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 04:56:46 -0400
Date: Fri, 20 Oct 2006 01:56:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc2-mm2
Message-Id: <20061020015641.b4ed72e5.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/

- Added the IOAT tree as git-ioat.patch (Chris Leech)

- I worked out the git magic to make the wireless tree work
  (git-wireless.patch).  Hopefully it will be in -mm more often now.



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




Changes since 2.6.19-rc2-mm1:


 origin.patch
 git-alsa.patch
 git-agpgart.patch
 git-cpufreq.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-jfs.patch
 git-libata-all.patch
 git-mips.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-ioat.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-pciseg.patch
 git-sh.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-wireless.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees.

-revert-pci-quirk-for-ibm-dock-ii-cardbus-controllers.patch
-ioc4-remove-sn2-feature-and-config-dependencies.patch
-ioc4-enable-build-on-non-sn2.patch
-ioc4-enable-build-on-non-sn2-fix-2.patch
-ioc4-fixes.patch
-ioc4-kconfig-fix.patch
-synclink-remove-page_size-reference.patch
-lockdep-increase-max-allowed-recursion-depth.patch
-new-mmc-maintainer.patch
-i386-time-avoid-pit-smp-lockups.patch
-null-dereference-in-fs-jbd2-journalc.patch
-remove_mapping-fix.patch
-md-fix-proc-mdstat-refcounting.patch
-posix-cpu-timers-prevent-signal-delivery-starvation.patch
-proc_numbuf-is-wrong.patch
-rename-net_random-to-random32.patch
-rename-net_random-to-random32-fixes.patch
-rename-net_random-to-random32-fix-2.patch
-remove-carta_random32.patch
-knfsd-add-nfs-export-support-to-tmpfs.patch
-w1-kconfig-fix.patch
-rtc-max6902-month-conversion-fix.patch
-vmalloc-dont-pass-__gfp_zero-to-slab.patch
-acpi_processor_latency_notifier-up-warning-fix.patch
-swsusp-fix-memory-leaks.patch
-drivers-char-specialixc-fix-the-baud-conversion.patch
-fix-make-headers_install.patch
-genirq-clean-up-irq-flow-type-naming.patch
-sx-fix-user-visible-typo-devic.patch
-fuse-fix-hang-on-smp.patch
-document-i_size_write-locking-rules.patch
-fuse-locking-fix-for-nlookup.patch
-fuse-fix-spurious-bug.patch
-fuse-fix-handling-of-moved-directory.patch
-fuse-fix-dereferencing-dentry-parent.patch
-knfsd-nfsd4-fix-owner-override-on-open.patch
-knfsd-nfsd4-fix-open-permission-checking.patch
-knfsd-nfsd4-fix-error-handling-in-nfsds-callback-client.patch
-knfsd-fix-bug-in-recent-lockd-patches-that-can-cause-reclaim-to-fail.patch
-knfsd-allow-lockd-to-drop-replys-as-appropriate.patch
-knfsd-allow-lockd-to-drop-replys-as-appropriate-fixes.patch
-mm-comment-mmap_sem--lock_page-lockorder.patch
-arm-switch-to-new-pci_get_bus_and_slot-api.patch
-gregkh-driver-documentation-feature-removal-schedule-typo.patch
-gregkh-driver-driver-core-plug-device-probe-memory-leak.patch
-gregkh-driver-fix-dev_printk-is-now-gpl-only.patch
-gregkh-driver-howto-bug-report-addition.patch
-gregkh-driver-sysfs-remove-duplicated-dput-in-sysfs_update_file.patch
-gregkh-driver-sysfs-update-obsolete-comment-in-sysfs_update_file.patch
-gregkh-driver-driver-core-fixes-sysfs_create_link-retval-check-in-class.c.patch
-gregkh-driver-driver-core-fixes-bus_add_attrs-retval-check.patch
-gregkh-driver-driver-core-fixes-bus_add_device-cleanup-on-error.patch
-gregkh-driver-driver-core-fixes-device_add-cleanup-on-error.patch
-gregkh-driver-driver-core-fixes-device_create_file-retval-check-in-dmapool.c.patch
-gregkh-driver-driver-core-fixes-sysfs_create_group-retval-in-topology.c.patch
-gregkh-driver-driver-core-don-t-leak-old_class_name-in-drivers-base-core.c-device_rename.patch
-gregkh-driver-driver-core-don-t-ignore-error-returns-from-probing.patch
-gregkh-driver-driver-core-bus-remove-indentation-level.patch
-gregkh-driver-driver-core-kmalloc-failure-check-in-driver_probe_device.patch
-gregkh-driver-aoe-eliminate-isbusy-message.patch
-gregkh-driver-aoe-update-copyright-date.patch
-gregkh-driver-aoe-remove-unused-nargs-enum.patch
-gregkh-driver-aoe-zero-copy-write-1-of-2.patch
-gregkh-driver-aoe-jumbo-frame-support-1-of-2.patch
-gregkh-driver-aoe-clean-up-printks-via-macros.patch
-gregkh-driver-aoe-jumbo-frame-support-2-of-2.patch
-gregkh-driver-aoe-improve-retransmission-heuristics.patch
-gregkh-driver-aoe-zero-copy-write-2-of-2.patch
-gregkh-driver-aoe-module-parameter-for-device-timeout.patch
-gregkh-driver-aoe-use-bio-bi_idx.patch
-gregkh-driver-aoe-remove-sysfs-comment.patch
-gregkh-driver-aoe-update-driver-version.patch
-gregkh-driver-aoe-revert-printk-macros.patch
-gregkh-driver-aoe-fix-sysfs-warnings.patch
-jdelvare-hwmon-hwmon-unchecked-return-status-fixes-w83791d.patch
-jdelvare-hwmon-hwmon-update-Grant-Coady-email-address.patch
-jdelvare-hwmon-hwmon-documentation-typos.patch
-jdelvare-hwmon-hwmon-smsc47m112-documentation.patch
-jdelvare-hwmon-hwmon-k8temp-documentation-update.patch
-jdelvare-hwmon-hwmon-w83627ehf-fix-fan5-detection.patch
-jdelvare-hwmon-hwmon-w83781d-lm78-fix-load-failure.patch
-jdelvare-hwmon-hwmon-w83781d-fix-debug-messages.patch
-kill-include-linux-configh-ia64.patch
-ia64-remove-unused-pal_call_ic_off.patch
-ia64-reformat-pals-to-fit-in-80-columns-fix-typos.patch
-drivers-dma-handle-sysfs-errors.patch
-gregkh-pci-shpchp-fix-shpchp_wait_cmd-in-poll.patch
-gregkh-pci-pciehp-fix-improper-info-messages.patch
-gregkh-pci-pciehp-add-missing-locking.patch
-gregkh-pci-pciehp-remove-unnecessary-check-in-pciehp_ctrl.c.patch
-gregkh-pci-pci-via-irq-quirk-behaviour-change.patch
-gregkh-pci-pci-pcie-check-and-return-bus_register-errors-fix.patch
-gregkh-pci-pci-add-ich7-8-acpi-gpio-io-resource-quirks.patch
-gregkh-pci-pci-turn-pci_fixup_video-into-generic-for-embedded-vga.patch
-gregkh-pci-acpipnp-dma-resource-setup-fix.patch
-gregkh-pci-pci-fix-pcie_portdrv_restore_config-undefined-without-config_pm-error.patch
-gregkh-pci-pci-stamp-out-pci_find_-usage-in-fakephp.patch
-gregkh-pci-shpchp-fix-command-completion-check.patch
-gregkh-pci-shpchp-remove-unnecessary-cmd_busy-member-from-struct.patch
-gregkh-pci-pci-hotplug-ioremap-balanced-with-iounmap.patch
-gregkh-pci-pci-improve-pci_msi_supported-comments.patch
-gregkh-pci-pci-update-msi-howto.txt-according-to-pci_msi_supported.patch
-gregkh-pci-change-pci-hotplug-subsystem-maintainer-to-kristen.patch
-gregkh-pci-pci-optionally-sort-device-lists-breadth-first.patch
-quirks-switch-quirks-code-offender-to-use-pci_get-api.patch
-pci-additional-functions.patch
-gregkh-usb-usb-wacom-driver-updates.patch
-gregkh-usb-usb-bug_on-conversion-for-wacom.c.patch
-gregkh-usb-usb-fix-use-after-free-in-wacom_sys.c.patch
-gregkh-usb-airprime-new-device-id.patch
-gregkh-usb-usb-support-for-bt-on-air-usb-modem-in-cdc-acm.c.patch
-gregkh-usb-usb-remove-private-debug-macros-from-kaweth.patch
-gregkh-usb-usb-suspend-resume-support-for-kaweth.patch
-gregkh-usb-usb-ohci-pnx4008-build-fixes.patch
-gregkh-usb-ueagle-be-suspend-friendly.patch
-gregkh-usb-ueagle-use-interruptible-sleep.patch
-gregkh-usb-ueagle-comestic-changes.patch
-gregkh-usb-usb-fix-cdc-acm-problems-with-hard-irq.patch
-gregkh-usb-usb-unusual_devs-entry-for-nokia-6131.patch
-gregkh-usb-usbatm-fix-tiny-race.patch
-gregkh-usb-speedtch-extended-reach.patch
-gregkh-usb-cxacru-add-the-zte-zxdsl-852.patch
-gregkh-usb-usb-fix-suspend-support-for-usblp.patch
-gregkh-usb-usb-ftdi-elan-fix-sparse-warnings.patch
-gregkh-usb-uhci-workaround-for-asus-motherboard.patch
-gregkh-usb-usbcore-fix-refcount-bug-in-endpoint-removal.patch
-gregkh-usb-usbcore-fix-endpoint-device-creation.patch
-gregkh-usb-usb-drivers-usb-net-use-build_bug_on.patch
-gregkh-usb-usb-devio-handle-class_device_create-error.patch
-gregkh-usb-mcs7830-driver-3.diff.patch
-gregkh-usb-usbnet-ethtool-mii.diff.patch
-gregkh-usb-usbnet-phy-mutex.diff.patch
-gregkh-usb-usb-move-vibrator.patch
-gregkh-usb-usb-serial-mos7720.patch
-fix-gregkh-usb-usbatm-fix-tiny-race.patch
-xpad-dance-pad-support.patch
-memory-leak-in-drivers-usb-serial-airprimec.patch
-extract-and-implement-are-bit-field-manipulation-routines.patch
-drivers-usb-misc-ftdi-elanc-remove-dead-code.patch
-drivers-usb-serial-mos7840c-fix-a-check-after-dereference.patch
-ueagle-fix-ueagle-atm-oops.patch
-usb-gadget-net2280-handle-sysfs-errors.patch
-atmel-wireless-output-signal-strength-information.patch
-orinoco-fix.patch
-possible-dereference-in-drivers-net-wireless-zd1201c.patch
-more-we-21-potential-overflows.patch
-airo-suspend-fix.patch
-prism54-use-build_bug_on.patch
-airoc-check-returned-values.patch
-x86_64-overlapping-program-headers-in-physical-addr-space-fix.patch
-insert-local-and-io-apics-into-resource-map.patch
-spinlock-debug-all-cpu-backtrace.patch
-sleazy-fpu-feature-i386-support.patch
-add-seccomp_disable_tsc-config-option.patch
-x86-remove-default_ldt-and-simplify-ldt-setting.patch
-fix-buggy-mtrr-address-checks.patch
-i386-espfix-cleanup.patch
-i386-espfix-cleanup-tweak.patch
-x86_64-hot-add-memroy-sratc-fix.patch
-x86_64-add-missing-enter_idle-calls.patch
-x86_64-rename-x86_feature_dtes-to-x86_feature_ds.patch
-add-x86_feature_pebs-and-detection.patch
-i386-rename-x86_feature_dtes-to-x86_feature_ds.patch
-i386-add-x86_feature_pebs-and-detection.patch
-remove-pointless-printk-from-i386-oops-output.patch
-compress-stack-unwinder-output.patch
-x86_64-use-build_bug_on-in-fpu-code.patch
-fix-for-arch-x86_64-pci-makefile-cflags.patch
-i386-math-emu-fix-must_checks.patch
-x86-64-mmconfig-missing-printk-levels.patch
-i386-fix-cfi_signal_frame-copy-n-paste-error.patch
-x86_64-fix-obscure-oops-in-xfrm_register_mode.patch
-s390-qdio-build-fix.patch
-fix-io-error-reporting-on-fsync.patch
-drivers-led-handle-sysfs-errors.patch
-i2o-handle-a-few-sysfs-errors.patch
-fs-partitions-check-add-sysfs-error-handling.patch
-rtc-fix-printk-of-64-bit-res-on-32-bit-platform.patch
-lockdep-annotate-i386-apm.patch
-rd-memory-leak-on-rd_init-failure.patch
-epca-prevent-panic-on-tty_register_driver-failure.patch
-kbuild-allow-multi-word-m-in-makefilemodpost.patch
-add-entrys-labels-to-tag-file.patch
-rt-mutex-fixup-rt-mutex-debug-code.patch
-convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch
-config_telclock-depends-on-x86.patch
-drivers-isdn-hysdn-save_flags-cli-restore_flags-replaced-appropriately.patch
-drivers-isdn-isdnloop-save_flags-cli-restore_flags-replaced-appropriately.patch
-isdn-fix-drivers-by-handling-errors-thrown-by-readstat.patch
-isdn-check-for-userspace-copy-faults.patch
-drivers-isdn-ioremap-balanced-with-iounmap.patch
-ecryptfs-superblock-cleanups.patch

 Merged into mainline or a subsystem tree.

+ecryptfs-use-special_file.patch
+export-clear_queue_congested-and-set_queue_congested.patch
+separate-bdi-congestion-functions-from-queue-congestion-functions.patch
+make-linux-personalityh-userspace-proof.patch
+uml-mode_tt-is-bust.patch
+fix-typo-in-memory-barrier-docs.patch
+uml-remove-some-leftover-ppc-code.patch
+uml-split-memory-allocation-prototypes-out-of-userh.patch
+uml-code-convention-cleanup-of-a-file.patch
+uml-reenable-compilation-of-enable_timer-disabled-by-mistake.patch
+uml-use-defconfig_list-to-avoid-reading-hosts-config.patch
+uml-cleanup-run_helper-api-to-fix-a-leak.patch
+uml-kconfig-silence-warning.patch
+uml-mmapper-remove-just-added-but-wrong-const-attribute.patch
+kconfig-serial-typos.patch
+fix-acpi-processor-native-c-states-using-mwait.patch
+genirq-clean-up-irq-flow-type-naming-fix.patch
+readjust-comments-of-task_timeslice-for-kernel-doc.patch
+acpimemory-hotplug-change-log-level-of-a-message-of-acpi_memhotplug-to-kern_debug.patch
+acpimemory-hotplug-remove-strange-add_memory-fail-message.patch
+oom-killer-meets-userspace-headers.patch
+irq-updates-make-eata_pio-compile.patch
+fix-warnings-for-warn_on-if-config_bug-is-disabled.patch
+cad_pid-sysctl-with-proc_fs=n.patch
+fs-kconfig-move-generic_acl-fix-acl-call-errors.patch
+autofs3-make-sure-all-dentries-refs-are-released-before-calling-kill_anon_super.patch
+nfsv4-fix-thinko-in-fs-nfs-superc.patch
+nfs-fix-oops-in-nfs_cancel_commit_list.patch
+nfs-fix-error-handling-in-nfs_direct_write_result.patch
+nfs4-initialize-cl_ipaddr.patch
+nfs-fix-nfsv4-callback-regression.patch
+nfs-deal-with-failure-of-invalidate_inode_pages2.patch
+nfs-fix-minor-bug-in-new-nfs-symlink-code.patch
+nfs-__nfs_revalidate_inode-can-use-inode-before.patch
+nfs-remove-unused-check-in-nfs4_open_revalidate.patch
+sunrpc-fix-race-in-in-kernel-rpc-portmapper-client.patch
+sunrpc-fix-a-typo.patch
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
+fix-potential-interrupts-during-alternative-patching-was.patch
+highest_possible_node_id-linkage-fix.patch
+drivers-isdn-ioremap-balanced-with-iounmap.patch
+doc-fixing-cpu-hotplug-documentation.patch
+mmd-cache-aliasing-issue-in-cow_user_page.patch
+ipmi-fix-return-codes-in-failure-case.patch
+firmware-dcdbas-add-size-check-in-smi_data_write.patch
+mm-more-comment-lockorder.patch
+ext3-fix-j_asserttransaction-t_updates-0-in-journal_stop.patch
+kernel-nsproxyc-use-kmemdup.patch
+knfsd-fix-race-that-can-disable-nfs-server.patch
+one-more-arm-irq-fix.patch
+revert-pci-quirk-for-ibm-dock-ii-cardbus-controllers.patch
+tty-signal-tty-locking.patch
+char-correct-pci_get_device-changes.patch
+drivers-ide-pci-genericc-re-add-the-__setupall-generic-ide.patch
+md-fix-calculation-of-degraded-for-multipath-and-raid10.patch
+md-add-another-compat_ioctl-for-md.patch
+md-endian-annotation-for-v1-superblock-access.patch
+md-endian-annotations-for-the-bitmap-superblock.patch
+clocksource-acpi_pm-add-another-greylist-chipset.patch
+pci-declare-pci_get_device_reverse.patch
+rpaphp-build-fix.patch

 2.6.19 queue (mostly)

+vfs-make-d_materialise_unique-enforce-directory.patch
+nfs-cache-invalidation-fixup.patch
+mm-clean-up-pagecache-allocation.patch
+vmscan-fix-temp_priority-race.patch
+vmscan-fix-temp_priority-race-comments.patch
+vmscan-fix-temp_priority-in-__zone-reclaim.patch

 2.6.19 queue (probably)

+mm-fix-pagecache-write-deadlocks-xip.patch
+mm-fix-pagecache-write-deadlocks-mm-pagecache-write-deadlocks-efault-fix.patch
+fs-prepare_write-fixes.patch
+fs-prepare_write-fixes-fuse-fix.patch
+fs-prepare_write-fixes-jffs-fix.patch

 Fiddle with the write() deadlock some more.

+add-support-for-the-generic-backlight-device-to-the-ibm-acpi-driver-fix-2.patch
+add-support-for-the-generic-backlight-device-to-the-asus-acpi-driver-fix.patch
+add-support-for-the-generic-backlight-device-to-the-toshiba-acpi-driver-fix.patch

 backlight fixes.

+debugfs-check-return-value-correctly.patch
+nozomi-warning-fixes.patch

 driver tree fixes.

+drm-fix-return-code-in-error-case.patch

 DRM fix.

+jdelvare-i2c-i2c-lockdep-handle-recursive-locking.patch

 I2C tree update

+jdelvare-hwmon-hwmon-f71805f-add-f71872f-support.patch
+jdelvare-hwmon-hwmon-f71805f-always-create-all-fans.patch

 hwmon tree updates

+kconfig-new-function-bool-conf_get_changedvoid.patch
+kconfig-make-sym_change_count-static-let-it-be-altered-by-2-functions-only.patch
+kconfig-add-void-conf_set_changed_callbackvoid-fnvoid-use-it-in-qconfcc.patch
+kconfig-set-gconfs-save-widgets-sensitivity-according-to-configs-changed-state.patch

 config GUI updates

+pata_marvell-switch-to-pci_iomap-as-jeff-asked.patch
+pata_marvell-switch-to-pci_iomap-as-jeff-asked-fix.patch
+libata-use-correct-map_db-values-for-ich8.patch

 sata/pata stuff.

+mmc-when-rescanning-cards-check-existing-cards-after-mmc_setup.patch

 MMC fix.

+e1000-reset-all-functions-after-a-pci-error.patch
+revert-mv643xx-add-pci-device-table-for-auto-module-loading.patch

 netdev updates.

+ioat-warning-fix.patch

 Fix warning in git-ioat.patch

+x86-64-mmconfig-missing-printk-levels.patch
+remove-quirk_via_abnormal_poweroff.patch

 x86/x86_64 updates.

-ioremap-balanced-with-iounmap-drivers-scsi-3w-9xxxc.patch

 Dropped.

+revert-scsi-ips-soft-lockup-during-reset-initialization.patch
+scsi-ips-soft-lockup-during-reset-initialization-2.patch
+drivers-scsi-handcrafted-min-max-macro-removal.patch
+drivers-scsi-handcrafted-min-max-macro-removal-fix.patch

 SCSI updates.

+fix-pxa2xx-udc-compilation-error.patch
+xpad-additional-usb-ids-added.patch
+hid-core-big-endian-fix-fix.patch

 USB udpates.

+x86_64-mm-defconfig-update.patch
+x86_64-mm-i386-defconfig-update.patch
+x86_64-mm-fix-buggy-mtrr-address-checks.patch
+x86_64-mm-dump-80cols.patch
+x86_64-mm-dump-remove-newlines.patch
+x86_64-mm-i386-mathemu-must-check.patch
+x86_64-mm-sparse-memory-srat.patch
+x86_64-mm-i386-remove-pointless-printk.patch
+x86_64-mm-spin-irqs-disabled.patch
+x86_64-mm-x86_64-rename-x86_feature_dtes-to-x86_feature_ds.patch
+x86_64-mm-add-x86_feature_pebs-and-detection.patch
+x86_64-mm-remove-duplicated-cpu_mask_to_apicid-in-x86_64-smp.h.patch
+x86_64-mm-io-apic-vector-typo.patch
+x86_64-mm-i386-rename-x86_feature_dtes-to-x86_feature_ds.patch
+x86_64-mm-i386-add-x86_feature_pebs-and-detection.patch
+x86_64-mm-i386-math-emu-build-bug-on.patch
+x86_64-mm-i386-default-ldt.patch
+x86_64-mm-overlapping-program-headers-in-physical-addr-space-fix.patch
+x86_64-mm-all-cpu-backtrace.patch
+x86_64-mm-espfix-cleanup.patch
+x86_64-mm-fix-.cfi_signal_frame-copy-n-paste-error.patch
+x86_64-mm-fix-for-arch-x86_64-pci-makefile-cflags.patch
+x86_64-mm-e820-page-align.patch
+x86_64-mm-i386-sleazy-fpu.patch
+x86_64-mm-insert-local-and-io-apics-into-resource-map.patch
+x86_64-mm-accumulate-args.patch
+x86_64-mm-i386-hpet-ioremap.patch
+x86_64-mm-i386-hpet-cs-iounmap.patch
+x86_64-mm-i386-pci-dma-iounmap.patch
+x86_64-mm-x86-64-add-intel-core-related-pmu-msrs.patch
+x86_64-mm-unwinder-speedup.patch
+x86_64-mm-x86_64-add-nx-mask-for-pte-entry.patch
+x86_64-mm-i386-add-intel-core-related-pmu-msrs.patch
+x86_64-mm-i386-fake-return-address.patch

 x86 tree updates

+x86_64-irq-use-irq_domain-in-ioapic_retrigger_irq.patch
+x86_64-put-more-than-one-cpu-in-target_cpus.patch
+x86-tif_notsc-and-seccomp-prctl.patch
+x86-resend-remove-last-two-pci_find-offenders-in-the.patch
+unwinder-speedup-tweaks.patch
+paravirt-skip-timer-works.patch
+paravirt-skip-timer-works-tidy.patch
+paravirt-interrupts-subarch-cleanup.patch
+paravirt-fix-missing-pte-update.patch
+paravirt-fix-bad-mmu-names.patch
+paravirt-mmu-header-movement.patch

 x86/x86_64 updates

+memory-page_alloc-zonelist-caching-reorder-structure.patch

 Improve memory-page_alloc-zonelist-caching-speedup.patch

-fix-bug-in-try_to_free_pages-and-balance_pgdat-when-they.patch

 Updated.

-use-min-of-two-prio-settings-in-calculating-distress-for.patch

 Dropped (needs to be undropped though)

+shared-page-table-for-hugetlb-page-v4.patch
+htlb-forget-rss-with-pt-sharing.patch

 pte sharing for hugetlb pages.

+slab-debug-and-arch_slab_minalign-dont-get-along.patch

 slab fix.

+swsusp-improve-handling-of-highmem-fix.patch
+swsusp-fix-platform-mode.patch

 swsusp updates.

-apm-share-apm-emulator-between-architectures.patch

 Dropped, wrong.

+qla1280-bus-reset-typo.patch
+pktcdvd-bio-write-congestion-using-blk_congestion_wait.patch
+pktcdvd-bio-write-congestion-using-blk_congestion_wait-fix.patch
+file-kill-unnecessary-timer-in-fdtable_defer.patch
+pci-i386-style-cleanups.patch
+remove-double-cast-to-same-type.patch
+io-storage-documentation-update-to-as-ioschedtxt.patch
+cciss-change-pci-id-for-bug-workaround.patch
+add-shared-version-of-apm-emulation.patch
+arm-convert-to-use-shared-apm-emulation.patch
+mips-convert-to-use-shared-apm-emulation.patch
+export-pm_suspend-for-the-shared-apm-emulation.patch
+patch-to-fix-reiserfs-bad-path-release-panic-on-2619-rc1.patch
+via82cxxx-handle-error-condition-properly.patch
+lockdep-fix-ide-proc-interaction.patch
+pull-in-necessary-header-files-for-cdevh.patch
+setup_irq-better-mismatch-debugging.patch
+fix-ide-cs-hang-after-device-removal.patch
+improve-the-remove-sysctl-warnings.patch
+sparc-clean-up-asm-sparc-elfh-pollution-in-userspace.patch
+cpuset-minor-code-refinements.patch
+remove-superfluous-lock_super-in-ext2-and-ext3-xattr-code.patch
+correct-bus_num-and-buffer-bug-in-spi-core.patch
+spi-set-kset-of-master-class-dev-explicitly.patch
+paride-rename-pi_register-and-pi_unregister.patch
+paride_register-shuffle-return-values.patch

 Misc.

+fix-generic-warn_on-message.patch

 Change the WARN_ON message to say WARNING and not BUG.  Upsets Ingo.

+bit-revese-library.patch
+crc32-replace-bitreverse-by-bitrev32.patch
+video-use-bitrev8.patch
+net-use-bitrev8.patch
+isdn-hisax-use-bitrev8.patch
+atm-ambassador-use-bitrev8.patch

 Develop and use a library for bit-reversing scalars.

+fsstack-introduce-fsstack_copy_attrinode_.patch
+fsstack-introduce-fsstack_copy_attrinode_-tidy.patch
+ecryptfs-use-fsstacks-generic-copy-inode-attr.patch
+ecryptfs-use-fsstacks-generic-copy-inode-attr-tidy-fix.patch
+struct-path-rename-reiserfss-struct-path.patch
+struct-path-rename-dms-struct-path.patch
+struct-path-move-struct-path-from-fs-nameic-into.patch
+struct-path-make-ecryptfs-a-user-of-struct-path.patch

 cleanups, some prep for unionfs.

+add-process_session-helper-routine.patch
+add-process_session-helper-routine-deprecate-old-field.patch
+add-process_session-helper-routine-deprecate-old-field-tidy.patch
+add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch
+add-process_session-helper-routine-deprecate-old-field-fix-warnings-2.patch
+rename-struct-namespace-to-struct-mnt_namespace.patch
+add-an-identifier-to-nsproxy.patch
+rename-struct-pspace-to-struct-pid_namespace.patch
+add-pid_namespace-to-nsproxy.patch
+use-current-nsproxy-pid_ns.patch
+add-child-reaper-to-pid_namespace.patch

 Start work on virtualising process sessions.

+rename-struct-namespace-to-struct-mnt_namespace-cachefiles.patch

 Fix cachefs for other patches in -mm.

+mxser-correct-tty-driver-name.patch
+mxser_new-correct-tty-driver-name.patch

 mxser updates.

+tty-preparatory-structures-for-termios-revamp.patch
+tty-preparatory-structures-for-termios-revamp-strip-fix.patch
+tty-switch-to-ktermios-and-new-framework.patch
+tty-switch-to-ktermios-and-new-framework-warning-fix.patch
+tty-switch-to-ktermios.patch
+tty-switch-to-ktermios-nozomi-fix.patch
+tty-switch-to-ktermios-bluetooth-fix.patch

 tty reworks.

+char-isicom-expand-function.patch
+char-isicom-rename-init-function.patch
+char-isicom-remove-isa-code.patch
+char-isicom-remove-unneeded-memset.patch
+char-isicom-move-to-tty_register_device.patch
+char-isicom-use-pci_request_region.patch
+char-isicom-check-kmalloc-retval.patch

 isicom updates.

+drivers-isdn-handcrafted-min-max-macro-removal.patch
+drivers-isdn-handcrafted-min-max-macro-removal-fix.patch

 ISDN cleanups.

+lockdep-annotate-nfsd4-recover-code.patch

 lockdep fixes.

-ecryptfs-use-special_file.patch

 Dropped.

+reiser4-get-rid-of-deprecated-crypto-api-build-fix.patch

 reiser4 fix.

+dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie-remove-incorrect-warning-in-kernel-timerc.patch

 Fix dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie.patch

+mm-only-i_size_write-debugging-fix.patch

 Make mm-only-i_size_write-debugging.patch work better.




All 909 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/patch-list


