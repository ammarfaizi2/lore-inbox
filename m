Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWCRMnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWCRMnw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 07:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWCRMnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 07:43:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751076AbWCRMnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 07:43:50 -0500
Date: Sat, 18 Mar 2006 04:40:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc6-mm2
Message-Id: <20060318044056.350a2931.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/


- John's time rework patches were dropped - they're being reworked.

- Lots of MD and DM updates




Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it's not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.




Changes since 2.6.16-rc6-mm1:

 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit-master.patch
 git-blktrace.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-sas-jg.patch
 git-sparc64.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-uml.patch
 git-viro-bird-frv.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees.

-mtd_dataflash-fix-block-vs-page-erase.patch
-acpi-thermal-driver-leaks-in-failure-path.patch
-drivers-acpi-videoc-fix-a-null-pointer-dereference.patch
-move-pci_dev_put-outside-a-spinlock.patch
-pxa2xx-ssp-spi-driver.patch
-get_cpu_sysdev-signedness-fix.patch
-input-pcspkr-device-and-driver-separation.patch
-drivers-input-serio-serioc-fix-a-memory-leak.patch
-drivers-input-gameport-gameportc-fix-a-memory-leak.patch
-kbuild-add-fverbose-asm-to-i386-makefile.patch
-remove-the-config_cc_align_-options.patch
-ahci-fix-null-pointer-dereference-detected-by-coverity.patch
-git-netdev-all-ipw2200-warning-fix.patch
-drivers-net-e1000-proper-prototypes.patch
-3c509-use-proper-suspend-resume-api.patch
-tg3-netif_carrier_off-runs-too-early-could-still-be-queued-when-init-fails.patch
-config_forcedeth-updates.patch
-git-net-arm-build-fix.patch
-git-net-export-security_sid_to_context.patch
-git-net-ebtables-fix.patch
-git-net-br_netfilter-warning-fixes.patch
-net-decnet-dn_routec-fix-inconsequent-null-checking.patch
-gregkh-pci-x86-pci-domain-support-a-humble-fix.patch
-gregkh-pci-x86-pci-domain-support-struct-pci_sysdata.patch
-gregkh-pci-pci-fix-the-x86-pci-domain-support-fix.patch
-gregkh-pci-pci-device-ensure-sysdata-initialised.patch
-module_alias_blockchardev_major-for-drivers-scsi.patch
-drivers-scsi-flashpointc-remove-unused-things.patch
-drivers-scsi-flashpointc-remove-trivial-wrappers.patch
-drivers-scsi-flashpointc-remove-uchar.patch
-drivers-scsi-flashpointc-remove-ushort.patch
-drivers-scsi-flashpointc-remove-uint.patch
-drivers-scsi-flashpointc-remove-ulong.patch
-drivers-scsi-flashpointc-remove-ushort_ptr.patch
-drivers-scsi-flashpointc-use-standard-fixed-size-types.patch
-drivers-scsi-flashpointc-untypedef-struct-_sccb.patch
-drivers-scsi-flashpointc-untypedef-struct-sccbmgr_info.patch
-drivers-scsi-flashpointc-untypedef-struct-sccbmgr_tar_info.patch
-drivers-scsi-flashpointc-untypedef-struct-nvraminfo.patch
-drivers-scsi-flashpointc-untypedef-struct-sccbcard.patch
-drivers-scsi-flashpointc-lindent.patch
-drivers-scsi-flashpointc-dont-use-parenthesis-with-return.patch
-drivers-message-fusion-mptbasec-make-mpt_read_ioc_pg_3-static.patch
-drivers-message-fusion-mptctlc-make-struct-async_queue-static.patch
-drivers-scsi-ncr_d700c-fix-a-null-dereference.patch
-scsi-dmx3191dc-fix-a-null-pointer-dereference.patch
-drivers-scsi-ibmmcac-fix-a-null-pointer-dereference.patch
-drivers-scsi-sim710c-fix-a-null-pointer-dereference.patch
-drivers-usb-media-vicamc-fix-a-null-pointer-dereference.patch
-usbcore-fix-check_ctrlrecip-to-allow-control-transfers-in-state-address.patch
-x86_64-mm-drop-iommu-bus-check.patch
-page-migration-fail-if-page-is-in-a-vma-flagged-vm_locked.patch
-page-migration-documentation-update.patch
-powerpc-make-pmd_bad-and-pud_bad-checks-non-trivial.patch
-pnp-modalias-sysfs-export.patch
-i2o-memory-leak-in-i2o_exec_lct_modified.patch
-drivers-char-watchdog-pcwd_usbc-fix-a-null-pointer-dereference.patch
-net-sunrpc-clntc-fix-a-null-pointer-dereference.patch
-rename-setuid-dumpable-sysctl.patch
-pnp-ns558-adjust-pnp_register_driver-signature.patch
-pnp-i8042-adjust-pnp_register_driver-signature.patch

 Merged

+remove-sleep_avg-multiplier.patch
+efi_call_phys_epilog-warning-fix.patch
+i810fb_cursor-use-gfp_atomic.patch
+v9fs-assign-dentry-ops-to-negative-dentries.patch
+mark-cyc2ns_scale-readmostly.patch

 2.6.16 queue
 
+dont-check_acpi_pci-on-x86-with-acpi-disabled.patch

 Warning fix

+sound-pci-ice1712-deltac-make-2-functions-static.patch

 Sound driver cleanup

+gregkh-driver-sysfs_remove_dir-needs-to-invalidate-the-dentry.patch
+gregkh-driver-kobject-fix-build-error-if-config_sysfs-n.patch
+gregkh-driver-debugfs-add-debugfs_create_blob-helper-for-exporting-binary-data.patch
+gregkh-driver-kobject_add_dir.patch
+gregkh-driver-get_cpu_sysdev-signedness-fix.patch
+gregkh-driver-unexport-sysfs-dir.patch
+gregkh-driver-sysfs_add_link-kobject-leak-fix.patch
+gregkh-driver-spi-add-pxa2xx-ssp-spi-driver.patch

 Driver tree updates

-revert-gregkh-driver-put_device-might_sleep.patch

 Dropped.

+gregkh-driver-kobject-fix-build-error-if-config_sysfs-n-fix.patch

 Fix a driver-tree patch

+drm-sis-fix-compile-warning.patch

 DRM tree fix

+git-dvb-build-fixes.patch

 The DVB tree was rather broken.

+v4l-printk-warning-fixes.patch
+saa7110-fix-array-overrun.patch
+saa7111-prevent-array-overrun.patch
+saa7114-fix-i2c-block-write.patch
+adv7175-drop-unused-encoder-dump-command.patch
+adv7175-drop-unused-register-cache.patch
+zoran-use-i2c_master_send-when-possible.patch
+bt856-spare-memory.patch
+zoran-init-cleanups.patch

 DVB fixes

+gregkh-i2c-i2c-ali1535-drop-redundant-mutex.patch
+gregkh-i2c-i2c-amd756-s4882-mutex-init.patch
+gregkh-i2c-i2c-piix4-add-ht1000-support.patch
+gregkh-i2c-i2c-ixp4xx-hwmon-class.patch
+gregkh-i2c-i2c-drop-unneeded-i2c-dev-h-includes.patch
+gregkh-i2c-hwmon-rename-register-parameters.patch
+gregkh-i2c-hwmon-add-required-idr-locking.patch

 I2C tree updates

+git-libata-all-build-hacks.patch

 Fix clash between git-scsi-misc and git-libata-all.

+natsemi-add-support-for-using-mii-port-with-no-phy.patch
+natsemi-add-support-for-using-mii-port-with-no-phy-fix.patch
+natsemi-support-oversized-eeproms.patch
+add-a-pci-vendor-id-definition-for-aculab.patch
+natsemi-add-quirks-for-aculab-e1-t1-pmxc-cpci-carrier-cards.patch
+amd-au1xx0-fix-ethernet-tx-stats.patch
+amd-au1xx0-fix-ethernet-tx-stats-tidy.patch
+skfp-warning-fixes.patch
+git-netdev-all-tg3-warning-fix.patch

 netdev updates

+scm-fold-__scm_send-into-scm_send.patch
+scm_send-speedup.patch

 Fiddle with the scm code.

+fix-irda-usb-use-after-use.patch
+net-bluetooth-return-negative-error-constant.patch

 Net fixes

-nfs-fix-a-busy-inodes-issue.patch
-git-nfs-oops-workaround.patch

 Dropped - git-nfs got fixed.

+sunrpc-fix-a-busy-inodes-error-in-rpc_pipefs.patch

 git-nfs fix

-nfs-permit-filesystem-to-override-root-dentry-on-mount-6.patch
-9p-fix-error-handling-on-superblock-alloc-failure.patch
-nfs-abstract-out-namespace-initialisation-6.patch
-nfs-add-dentry-materialisation-op-6.patch
-nfs-unify-nfs-superblocks-per-protocol-per-server-6.patch

 Dropped.

-optimise-d_find_alias-fix.patch

 Folded into optimise-d_find_alias.patch

-gregkh-pci-x86-pci-domain-support-the-meat.patch
-revert-gregkh-pci-x86-pci-domain-support-the-meat.patch

 Dropped

+gregkh-pci-pci-i386-run-bios-pci-detection-before-direct.patch
+gregkh-pci-shpchp-cleanup-bus-speed-handling.patch
+gregkh-pci-pci-hotplug-sn-fix-cleanup-on-hotplug-removal-of-ppb.patch
+gregkh-pci-acpiphp-scan-slots-under-the-nested-p2p-bridge.patch
+gregkh-pci-pci-kzalloc-conversion-in-drivers-pci.patch
+gregkh-pci-pci-hotplug-add-common-acpi-functions-to-core.patch
+gregkh-pci-ibmphp-remove-true-and-false.patch
+gregkh-pci-acpiphp-fix-acpi_path_name.patch

 PCI tree updates

+mm-drivers-pci-msi-explicit-declaration-of-msi_register.patch

 Fix it.

+remove-drivers-scsi-constantscscsi_print_req_sense.patch
+link-scsi_debug-later.patch

 SCSI fixes

+areca-raid-linux-scsi-driver-update4.patch

 Update areca-raid-linux-scsi-driver.patch

+git-sas-jg-build-hack.patch

 Fix git-sas-jg.patch for git-scsi-misc changes

+sparc64-config_blk_dev_ram-fix.patch

 Fix sparc64 build

+gregkh-usb-usb-storage-sandisk-unusual_devices-entry.patch
+gregkh-usb-usb-storage-another-unusual_devs.h-entry.patch
+gregkh-usb-usb-storage-unusual_devs.h-entry-0420-0001.patch
+gregkh-usb-usb-storage-new-unusual_devs.h-entry-mitsumi-7in1-card-reader.patch
+gregkh-usb-usb-add-support-for-creativelabs-silvercrest-usb-keyboard.patch
+gregkh-usb-usb-zc0301-driver-bugfix.patch
+gregkh-usb-usb-vicam.c-fix-a-null-pointer-dereference.patch
+gregkh-usb-usb-fix-check_ctrlrecip-to-allow-control-transfers-in-state-address.patch
+gregkh-usb-usb-cp2101-add-new-device-ids.patch
+gregkh-usb-usb-ftdi_sio-add-icom-id1-usb-product-and-vendor-ids.patch
+gregkh-usb-usb-rtl8150-small-fix.patch
+gregkh-usb-navman-usb-serial.patch

 USB tree updates

+fix-hostap_cs-double-kfree.patch
+ieee80211_wxc-remove-dead-code.patch

 Wireless updates

+x86_64-mm-remove-unordered-io.patch
+x86_64-mm-make-gart_iommu-kconfig-help-text-more-specific-trivial.patch
+x86_64-mm-local-64bit.patch
+x86_64-mm-horus-pci.patch
+x86_64-mm-eliminate-register_die_notifier-symbol-exported.patch
+x86_64-mm-memnode-cache.patch
+x86_64-mm-amd-3core.patch
+x86-64-fix-double-definition-of-force_iommu.patch

 x86_64 updates

-revert-x86_64-mm-dmi-early.patch

 Dropped

+xfs_file_compat_invis_ioctl-fix.patch

 Fix git-xfs.patch

+fix-i386-x86-64-_page_pse-bit-when-changing-page-protection.patch

 Fix enable-mprotect-on-huge-pages.patch

+fix-swap-cluster-offset.patch

 swap allocator fix

+page-migration-reorg.patch
+page-migration-reorg-fixes.patch
+page-migration-reorg-cleanup.patch
+page-migration-reorg-cleanup-fix.patch

 Reorganise the page migration code

+selinux-cleanup-stray-variable-in-selinux_inode_init_security.patch

 SELinux fixlet

+x86-topology-dont-create-a-control-file-for-bsp-that-cannot-be-removed.patch

 topology-in-sysfs fix

+ia64-use-i386-dmi_scanc-fix.patch

 Fix ia64-use-i386-dmi_scanc.patch

-swsusp-pm-refuse-to-suspend-devices-if-wrong-console-is-active.patch

 Dropped

+swsusp-drain-high-mem-pages.patch

 swsusp fix

+rio-driver-rework-continued-1.patch
+rio-driver-rework-continued-2.patch
+rio-driver-rework-continued-3.patch
+rio-driver-rework-continued-4.patch
+rio-driver-rework-continued-5.patch

 RIO driver cleanups

+v9fs-print-9p-messages-fix-4.patch
+v9fs-add-extension-field-to-tcreate.patch

 Fix v9fs-print-9p-messages.patch some more

+indirect_print_item-warning-fix.patch
+update-some-vfs-documentation.patch
+update-some-vfs-documentation-fix.patch
+honour-aop_truncate_page-returns-in-page_symlink.patch
+make-address_space_operations-sync_page-return-void.patch
+make-address_space_operations-invalidatepage-return-void.patch
+make-address_space_operations-invalidatepage-return-void-jbd-fix.patch
+make-address_space_operations-invalidatepage-return-void-versus-git-nfs.patch
+maintainers-remove-dead-url.patch
+ext2-flags-shouldnt-report-nogrpid.patch
+fix-backwards-meaning-of-ms_verbose.patch
+no-need-to-protect-current-group_info-in-sys_getgroups.patch
+roundup_pow_of_two-64-bit-fix.patch
+fix-alloc_large_system_hash-roundup.patch
+fix-a-race-condition-between-i_mapping-and-iput.patch
+i2o_dump_hrt-output-cleanup.patch
+compat_sys_nfsservctl-handle-errors-correctly.patch
+radix-tree-documentation-cleanups.patch
+i4l-isdn_ttyc-fix-a-check-after-use.patch
+fix-sb_mixer-use-before-validation.patch
+v9fs-fix-vfs_inode-dereference-before-null-check.patch
+altix-rs422-support-for-ioc4-serial-driver.patch

 Misc updates

+make-fork-atomic-wrt-pgrp-session-signals.patch

 fork() fix

+ext3-get-blocks-maping-multiple-blocks-at-a-once-journal-reentry-fix.patch

 Fix ext3-get-blocks-maping-multiple-blocks-at-a-once.patch

+ext3-add-o-bh-option-fix.patch

 Fix ext3-add-o-bh-option.patch

-time-reduced-ntp-rework-part-1.patch
-time-reduced-ntp-rework-part-1-fix-adjtimeadj.patch
-time-reduced-ntp-rework-part-2.patch
-time-reduced-ntp-rework-part-2-fix-adjtimeadj.patch
-time-reduced-ntp-rework-part-2-remove-duplicate.patch
-time-clocksource-infrastructure.patch
-time-clocksource-infrastructure-remove-nsec_t.patch
-time-generic-timekeeping-infrastructure.patch
-time-generic-timekeeping-infrastructure-remove-nsec_t.patch
-time-generic-timekeeping-infrastructure-fix-ntp_synced.patch
-time-generic-timekeeping-infrastructure-wall_offset-helper-cleanup.patch
-time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
-time-i386-conversion-part-2-rework-tsc-support.patch
-time-i386-conversion-part-2-rework-tsc-support-section-fix.patch
-time-i386-conversion-part-3-enable-generic-timekeeping.patch
-time-i386-conversion-part-3-remove-nsec_t.patch
-time-i386-conversion-part-3-backout-pmtmr-changes.patch
-time-i386-conversion-part-3-lock-jiffies_64.patch
-time-i386-conversion-part-4-remove-old-timer_opts-code.patch
-time-i386-conversion-part-4-del-timer_tscc.patch
-time-i386-clocksource-drivers.patch
-time-i386-clocksource-drivers-backout-pmtmr-changes.patch
-time-i386-clocksource-drivers-drop-acpi_pm_buggy.patch
-time-fix-cpu-frequency-detection.patch
-time-delay-clocksource-selection-until-later-in-boot.patch
-x86-blacklist-tsc-from-systems-where-it-is-known-to-be-bad.patch
-i386-dont-disable-the-tsc-on-single-node-numaqs.patch
-kernel-timec-remove-unused-pps_-variables.patch

 Dropped - being redone.

+hrtimer-optimize-softirq-runqueues.patch
+pass-current-time-to-hrtimer_forward.patch
+posix-timer-cleanup-common_timer_get.patch
+posix-timer-cleanup-common_timer_get-fix.patch
+hrtimer-simplify-nanosleep.patch
+hrtimer-remove-state-field.patch
+hrtimer-remove-state-field-fix.patch
+remove-it_real_value-calculation-from-proc-stat.patch
+remove-define_ktime-and-ktime_to_clock_t.patch
+remove-nsec_t-typedef.patch
+hrtimers-remove-data-field.patch

 hrtimers updates

+kprobes-fix-broken-fault-handling-for-i386.patch
+kprobes-fix-broken-fault-handling-for-x86_64.patch
+kprobes-fix-broken-fault-handling-for-powerpc64.patch
+kprobes-fix-broken-fault-handling-for-ia64.patch
+kprobes-fix-broken-fault-handling-for-sparc64.patch
+kprobes-fix-broken-fault-handling-for-sparc64-fix.patch

 kprobes fixes

-edac-name-cleanup-remove-old-bluesmoke-stuff.patch
+edac-name-cleanup.patch
-edac-fix-minor-logic-bug-in-e7xxx_remove_one.patch
+edac-e7xxx-fix-minor-logic-bug.patch
-edac-fix-usage-of-kobject_init-kobject_put.patch
+edac-kobject_init-kobject_put-fixes.patch
+edac-reorder-export_symbol-macros.patch
+edac-formatting-cleanup.patch
+edac-documentation-spelling-fixes.patch
+edac-use-sysbus_message-in-e752x-code.patch
+edac-add-maintainers-for-chipset-drivers.patch
+edac-use-export_symbol_gpl.patch

 EDAC updates

+fs-nfsd-exportcnet-sunrpc-cachec-make-needlessly-global-code-static.patch

 nfsd cleanup

-small-schedule-optimization.patch
+small-schedule-microoptimization.patch

 Updates

+sched-store-weighted-load-on-up.patch
+sched-add-discrete-weighted-cpu-load-function.patch
+sched-add-above-background-load-function.patch

 CPU scheduler tweaks

-sched-alter_uninterruptible_sleep_interactivity.patch

 Dropped

+sched-activate-sched-batch-expired.patch
+sched-reduce-overhead-of-calc_load.patch
+sched-fix-interactive-task-starvation.patch

 More CPU scheduler tweaks

+mm-implement-swap-prefetching-tweaks.patch

 Update swap prefetch code to use new CPu scheduler features

+unify-pfn_to_page-sparc64-pfn_to_page.patch

 Fix unify-pfn_to_page-generic-functions.patch

-uninline-zone-helpers-prefetch-fix.patch

 Dropped, I think.

-notifier-chain-update-die_chain-changes-fix.patch

 Folded into notifier-chain-update-die_chain-changes.patch

+rtc-remove-rtc-uip-synchronization-on-x86.patch
+rtc-remove-rtc-uip-synchronization-on-x86_64.patch
+rtc-remove-rtc-uip-synchronization-on-x86_64-fix.patch
+rtc-remove-rtc-uip-synchronization-on-sparc64.patch
+rtc-remove-rtc-uip-synchronization-on-ppc-chrp-arch-ppc.patch
+rtc-remove-rtc-uip-synchronization-on-chrp-arch-powerpc.patch
+rtc-remove-rtc-uip-synchronization-on-ppc-maple.patch
+rtc-remove-rtc-uip-synchronization-on-arm.patch
+rtc-remove-rtc-uip-synchronization-on-mips-mc146818.patch
+rtc-remove-rtc-uip-synchronization-on-mips-based-dec.patch
+rtc-remove-rtc-uip-synchronization-on-sh03.patch
+rtc-remove-rtc-uip-synchronization-on-sh-mpc1211.patch
+rtc-remove-rtc-uip-synchronization-on-alpha.patch
+rtc-fix-up-some-rtc-whitespace-and-style.patch
+rtc-remove-some-duplicate-bcd-definitions.patch

 Save one second during bootup.

+proc-dont-lock-task_structs-indefinitely-fix-the-locking-when-reading-the-number-of-threads-in.patch
+proc-dont-lock-task_structs-indefinitely-fix-the-locking-when-reading-the-number-of-threads-in-nitpick.patch

 Updates to the /proc patches

-reiser4-vs-nfs-apply-mount-root-dentry-override-to-filesystems.patch

 Unneeded

+make-address_space_operations-invalidatepage-return-void-reiser4.patch

 Update reiser4 for other -mm patches

+fbdev-add-modeline-for-1680x1050-60.patch

 fbdev fix

+device-mapper-snapshot-replace-sibling-list-fix.patch

 Fix device-mapper-snapshot-replace-sibling-list.patch

+dm-snapshot-fix-kcopyd-destructor.patch
+dm-flush-queue-eintr.patch
+dm-store-md-name.patch
+dm-tidy-mdptr.patch
+dm-table-store-md.patch
+dm-store-geometry.patch
+dm-md-dependency-tree-in-sysfs-holders-slaves-subdirectory.patch
+dm-md-dependency-tree-in-sysfs-bd_claim_by_kobject.patch
+dm-md-dependency-tree-in-sysfs-md-to-use-bd_claim_by_disk.patch
+dm-md-dependency-tree-in-sysfs-dm-to-use-bd_claim_by_disk.patch
+dm-md-dependency-tree-in-sysfs-convert-bd_sem-to-bd_mutex.patch
+dm-remove-unnecessary-typecast.patch

 Device Mapper updates

+md-add-4-to-the-list-of-levels-for-which-bitmaps-are-supported.patch
+md-fix-the-failed-count-for-version-0-superblocks.patch
+md-update-status_resync-to-handle-large-devices.patch
+md-split-disks-array-out-of-raid5-conf-structure-so-it-is-easier-to-grow.patch
+md-allow-stripes-to-be-expanded-in-preparation-for-expanding-an-array.patch
+md-allow-stripes-to-be-expanded-in-preparation-for-expanding-an-array-init_list_head-to-list_head-conversions.patch
+md-allow-stripes-to-be-expanded-in-preparation-for-expanding-an-array-init_list_head-to-list_head-conversions-documentation-and-tidy-up-for-resize_stripes.patch
+md-infrastructure-to-allow-normal-io-to-continue-while-array-is-expanding.patch
+md-core-of-raid5-resize-process.patch
+md-core-of-raid5-resize-process-make-new-function-stripe_to_pdidx-static.patch
+md-final-stages-of-raid5-expand-code.patch
+md-final-stages-of-raid5-expand-code-fix.patch
+md-checkpoint-and-allow-restart-of-raid5-reshape.patch
+md-checkpoint-and-allow-restart-of-raid5-reshape-remove-an-unused-variable.patch
+md-only-checkpoint-expansion-progress-occasionally.patch
+md-split-reshape-handler-in-check_reshape-and-start_reshape.patch
+md-make-reshape-a-possible-sync_action-action.patch
+md-support-suspending-of-io-to-regions-of-an-md-array.patch
+md-improve-comments-about-locking-situation-in-raid5-make_request.patch
+md-remove-some-stray-semi-colons-after-functions-called-in-macro.patch

 RAID updates

+for_each_possible_cpu-defines-for_each_possible_cpu.patch
+for_each_possible_cpu-defines-for_each_possible_cpu-fix.patch
+for_each_possible_cpu-fixes-for-generic-part.patch
+for_each_possible_cpu-network-codes.patch
+for_each_possible_cpu-under-drivers-acpi.patch
+for_each_possible_cpu-loopback-device.patch
+for_each_possible_cpu-oprofile.patch
+for_each_possible_cpu-scsi.patch
+for_each_possible_cpu-for-arm.patch
+for_each_possible_cpu-i386.patch
+for_each_possible_cpu-i386-fix.patch
+for_each_possible_cpu-i386-fix-2.patch
+for_each_possible_cpu-ia64.patch
+for_each_possible_cpu-mips.patch
+for_each_possible_cpu-powerpc.patch
+for_each_possible_cpu-ppc.patch
+for_each_possible_cpu-s390.patch
+for_each_possible_cpu-sh.patch
+for_each_possible_cpu-sparc.patch
+for_each_possible_cpu-sparc64.patch
+for_each_possible_cpu-x86_64.patch
+for_each_possible_cpu-xfs.patch
+for_each_possible_cpu-documentaion.patch

 Rename for_each_cpu() to for_each_possible_cpu()

+nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus-fixes.patch

 Fix nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch

+slab-cache-shrinker-statistics-make-the-dummy-kmem_set_shrinker-a-static-inline.patch

 Fix slab-cache-shrinker-statistics.patch

+git-viro-bird-xfs-fixup.patch

 Fix XFS




All 1617 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/patch-list


