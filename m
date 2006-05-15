Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWEOH7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWEOH7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 03:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWEOH7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 03:59:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751441AbWEOH7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 03:59:51 -0400
Date: Mon, 15 May 2006 00:56:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc4-mm1
Message-Id: <20060515005637.00b54560.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/

- This tree contains a large number of new bugs^H^H^H^Hpatches.

  - klibc (Kernel libc), as git-klibc.patch (Peter Anvin)

  - Header cleanups for compatibility-with-userspace feasibility and for
    the addition of the `make hdrinstall' target, as git-hdrcleanup.patch and
    git-hdrinstall.patch (David Woodhouse)

  - The cachefs patches are back (local-disk-based caching of network
    filesystem files) (David Howells)

  - Added the ecryptfs filesystem

  - per-task delay accounting patches: more advanced process accounting,
    plus an extensible interface for extended accounting.  

  - Many memory-management updates

  - Plenty of other things

  So if problems are found, please put extra effort into Cc:ing the correct
  mailing list and/or developer on any reports, thanks.




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



Changes since 2.6.17-rc3-mm1:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-intelfb.patch
 git-klibc.patch
 git-hdrcleanup.patch
 git-hdrinstall.patch
 git-libata-all.patch
 git-mips.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-rbtree.patch
 git-sas.patch
 git-pcmcia.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-cryptodev.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-frv.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch
 git-klibc-build-hacks.patch

 git trees

-s390-make-qeth-buildable.patch
-md-avoid-oops-when-attempting-to-fix-read-errors-on-raid10.patch
-md-fixed-refcounting-locking-when-attempting-read-error-correction-in-raid10.patch
-md-change-enotsupp-to-eopnotsupp.patch
-md-improve-detection-of-lack-of-barrier-support-in-raid1.patch
-md-fix-rdev-nr_pending-count-when-retrying-barrier-requests.patch
-x86_64-add-compat_sys_vmsplice-and-use-it-in.patch
-i386-x86-64-fix-acpi-disabled-lapic-handling.patch
-i386-fix-overflow-in-e820_all_mapped.patch
-i386-remove-apic=-warning.patch
-silence-initcall-warnings.patch
-uml-fix-iomem-list-traversal.patch
-uml-skas0-support-for-2g-2g-hosts.patch
-uml-remove-null-checks-and-add-some-codingstyle.patch
-uml-clean-up-after-madvise_remove.patch
-uml-update-defconfig.patch
-uml-error-handling-fixes.patch
-page-migration-fix-fallback-behavior-for-dirty-pages.patch
-altix-correct-ioc3-port-order.patch
-sparsemem-interaction-with-memory-add-bug-fixes.patch
-spufs-fix-for-config_numa.patch
-powerpc-allow-devices-to-register-with-numa-topology.patch
-powerpc-cell-add-numa-id-to-struct-spu.patch
-s390-fix-ipd-handling.patch
-s390-bug-in-setup_rt_frame.patch
-rtc-rtc-dev-tweak-for-64-bit-kernel.patch
-genrtc-fix-read-on-64-bit-platforms.patch
-amd-alchemy-uart-claim-memory-range.patch
-make-pc-speaker-driver-work-on-x86-64.patch
-timer-tsc-check-suspend-notifier-change.patch
-acpi-memory-leakages-in-drivers-acpi-thermalc.patch
-audit-deal-with-deadlocks-in-audit_free.patch
-audit-sockaddr-patch.patch
-audit-move-call-of-audit_free-into-do_exit.patch
-audit-drop-gfp_mask-in-audit_log_exit.patch
-audit-drop-task-argument-of-audit_syscall_entryexit.patch
-audit-no-need-to-wank-with-task_lock-and-pinning-task-down-in-audit_syscall_exit.patch
-audit-support-for-context-based-audit-filtering.patch
-audit-support-for-context-based-audit-filtering-2.patch
-audit-audit-inode-patch.patch
-audit-change-lspp-ipc-auditing.patch
-audit-reworked-patch-for-labels-on-user-space-messages.patch
-audit-more-user-space-subject-labels.patch
-audit-rework-of-ipc-auditing.patch
-audit-audit-filter-performance.patch
-gregkh-driver-class-device-add-attribute_group-creation.patch
-gregkh-driver-netdev-create-attribute_groups-with-class_device_add.patch
-netdev-hotplug-napi-race-cleanup.patch
-dvb-core-ule-fixes-and-rfc4326-additions-kernel-2616.patch
-pwc-dec23-oops-fix.patch
-scx200_acb-fix-for-cs5535-eratta.patch
-sem2mutex-drivers-ieee1394.patch
-drivers-ieee1394-ohci1394c-function-calls-without-effect.patch
-forcedeth-fix-multi-irq-issues.patch
-via-rhine-zero-pad-short-packets-on-rhine-i-ethernet-cards.patch
-mv643xx_eth-provide-sysfs-class-device-symlink.patch
-powerpc-pseries-avoid-crash-in-pci-code-if-mem-system-not-up.patch
-git-rbtree-uml-fix.patch
-serial-locking-cleanup.patch
-ieee80211_wxc-remove-dead-code.patch
-x86_64-mm-avoid-irq0-ioapic-pin-collision.patch
-x86_64-mm-fix-die_lock-nesting.patch
-x86_64-mm-add-nmi_exit-to-die_nmi.patch
-x86_64-mm-compat-printk-fix.patch
-x86_64-mm-new-northbridge-fix.patch
-uml-fix-patch-mismerge.patch
-uml-search-from-uml_net-in-a-more-reasonable-path.patch
-uml-use-kbuild-tracking-for-all-files-and-fix-compilation-output.patch
-uml-fix-compilation-and-execution-with-hardened-gcc.patch
-uml-cleanup-unprofile-expression-and-build-infrastructure.patch
-uml-export-symbols-added-by-gcc-hardened.patch
-reduce-nr-of-ptr-derefs-in-fs-jffs2-summaryc.patch
-remove-fs-jffs2-histoh.patch
-cleanup-default-value-of-mtd_pcmcia_anonymous.patch
-rcu-introduce-rcu_needs_cpu-interface.patch
-rcu-introduce-rcu_needs_cpu-interface-fix.patch
-s390-exploit-rcu_needs_cpu-interface.patch
-handle-config_lbd-and-config_lsf-in-one-place.patch

 Merged into mainline or a subsystem tree

+selinux-check-for-failed-kmalloc-in-security_sid_to_context.patch
+fs-openc-unexport-sys_openat.patch
+autofs4-nfy_none-wait-race-fix.patch
+autofs4-nfy_none-wait-race-fix-tidy.patch
+fix-capi-reload-by-unregistering-the-correct-major.patch
+tpm-update-module-dependencies.patch
+pcmcia-oopses-fixes.patch
+via-quirk-fixup-additional-pci-ids.patch
+smbfs-chroot-issue-cve-2006-1864.patch
+rcu-introduce-rcu_needs_cpu-interface.patch
+rcu-introduce-rcu_needs_cpu-interface-fix.patch
+s390-exploit-rcu_needs_cpu-interface.patch
+setup_per_zone_pages_min-overflow-fix.patch
+s390-lcs-incorrect-test.patch
+initramfs-fix-cpio-hardlink-check.patch
+s390-add-vmsplice-system-call.patch
+symbol_put_addr-locks-kernel.patch
+contact-info-update.patch
+smbfs-fix-slab-corruption-in-samba-error-path.patch
+add-slab_is_available-routine-for-boot-code.patch
+led-improve-kconfig-information.patch
+backlight-lcd-class-fix-sysfs-_store-error-handling.patch
+led-add-maintainer-entry-for-the-led-subsystem.patch
+led-fix-sysfs-store-function-error-handling.patch
+v9fs-twalk-memory-leak.patch
+v9fs-signal-handling-fixes.patch
+fix-can_share_swap_page-when-config_swap.patch
+add-core-solo-and-core-duo-support-to-oprofile.patch
+tpm-fix-constant.patch
+final-rio-polish.patch
+final-rio-polish-fix.patch
+tpm_register_hardware-gcc-41-warning-fix.patch
+fs-compatc-fix-if-a-=-b-typo.patch
+root-mount-failure-emit-filesystems-attempted.patch
+revert-vfs-propagate-mnt_flags-into-do_loopback-vfsmount.patch
+smbus-unhiding-kills-thermal-management.patch
+fix-hotplug-kconfig-help.patch
+zone-init-check-and-report-unaligned-zone-boundaries.patch
+x86-align-highmem-zone-boundaries-with-numa.patch
+zone-allow-unaligned-zone-boundaries.patch
+gigaset-endian-fix.patch
+fix-typos-in-documentation-memory-barrierstxt.patch
+ide_cs-add-ibm-microdrive-to-known-ids.patch
+nfs-fix-error-handling-on-access_ok-in-compat_sys_nfsservctl.patch
+devices-txt-remove-pktcdvd-entry.patch
+jffs2-warning-fixes.patch
+dl2k-build-fix.patch

 2.6.17 queue

+acpi-dock-driver-v4.patch
+acpi-dock-driver-interface-fixups.patch

 Updates and fixes against acpi-dock-driver.patch

+asus_acpi-w3000-support.patch

 Asus ACPI driver update

+uninorth-agp-warning-fixes.patch
+alpha-agp-warning-fix.patch

 AGP fixes

+blk_start_queue-must-be-called-with-irq-disabled-add-warning.patch

 block layer debug check

+cifs-do-not-overwrite-aops-elements.patch

 CIFS was being bad.

+dprintk-adjustments-to-cpufreq-nforce2.patch
+dprintk-adjustments-to-cpufreq-speedstep-centrino.patch
+cpufreq-dprintk-adjustments.patch

 cpufreq driover cleanups and fixes

+gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
+gregkh-driver-driver-core-config_debug_pm-covers-drivers-base-power-too.patch
+gregkh-driver-platform_bus-learns-about-modalias.patch
+gregkh-driver-driver-core-remove-exports.patch
+gregkh-driver-kevent-add-new-uevent.patch
+gregkh-driver-driver-core-allow-sysdev_class-have-attributes.patch
+gregkh-driver-driver-core-fix-platform_device_add-to-use-device_add.patch
+gregkh-driver-driver-core-add-sys-hypervisor-when-needed.patch
+gregkh-driver-kobject-warn.patch
+gregkh-driver-warn-when-statically-allocated-kobjects-are-used.patch

 Driver tree updates

+gregkh-driver-platform_bus-learns-about-modalias-warning-fix.patch
+gregkh-driver-warn-when-statically-allocated-kobjects-are-used-fix.patch

 Fix them.

+drivers-base-firmware_classc-cleanups.patch
+s3c24xx-gpio-based-spi-driver.patch
+s3c24xx-hardware-spi-driver.patch
+s3c24xx-hardware-spi-driver-tidy.patch

 Other driver tree things.

+scx200_acb-use-pci-i-o-resource-when-appropriate-fix.patch

 Fix scx200_acb-use-pci-i-o-resource-when-appropriate.patch

+w1-warning-fix.patch

 Fix warning

-disable-atykb-warning.patch
+remove-silly-messages-from-input-layer.patch

 New version

+via-pmu-add-input-device.patch
+via-pmu-add-input-device-tidy.patch
+fix-mem-leak-in-sidewinder-driver.patch

 Input things.

+add-dependency-on-kernelrelease-to-the-package-targets.patch

 kbuild feature

+kbuild-export-type-enhancement-to-modpostc.patch
+kbuild-prevent-building-modules-that-wont-load.patch
+kbuild-export-symbol-usage-report-generator.patch

 More kbuild work

+git-klibc-alpha-fixes.patch
+git-klibc-ident-fix.patch
+git-klibc-build-hacks.patch

+git-hdrcleanup-fixup.patch
+git-hdrcleanup-vs-git-klibc-on-ia64.patch
+git-hdrcleanup-vs-git-klibc-on-ia64-2.patch

+git-hdrinstall-fixup.patch

 Various fixes against the new git trees

+sdhci-truncated-pointer-fix.patch

 MMC fix

+nand_base-modular-fix.patch
+git-mtd-non-arm-fix.patch
+git-mtd-isnt-arm-only.patch

 MTD fixes

+drivers-char-hw_randomc-remove-asserts.patch

 hw_random cleanup

+fix-phy-id-for-lxt971a-lxt972a.patch

 net driver fix

+clean-up-initcall-warning-for-netconsole.patch
+remove-dead-entry-in-net-wan-kconfig.patch
+ppp_async-hang-fix.patch
+selinux-add-security-class-for-appletalk-sockets.patch
+fix-mem-leak-in-netfilter.patch
+neighbourc-pneigh_get_next-skips-published-entry.patch

 networking

+nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
+nfs-permit-filesystem-to-perform-statfs-with-a-known-root-dentry.patch
+ipath-vs-nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
+git-gfs2-vs-nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
+nfs-abstract-out-namespace-initialisation.patch
+nfs-add-dentry-materialisation-op.patch
+nfs-split-fs-nfs-inodec-into-inode-superblock-and-namespace-bits.patch
+nfs-share-nfs-superblocks-per-protocol-per-server-per-fsid.patch
+nfs-share-nfs-superblocks-per-protocol-per-server-per-fsid-fix.patch
+nfs-share-nfs-superblocks-per-protocol-per-server-per-fsid-warning-fixes.patch
+fs-cache-provide-a-filesystem-specific-syncable-page-bit.patch
+fs-cache-add-notification-of-page-becoming-writable-to-vma-ops.patch
+fs-cache-avoid-enfile-checking-for-kernel-specific-open-files.patch
+fs-cache-generic-filesystem-caching-facility.patch
+fs-cache-make-kafs-use-fs-cache.patch
+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem.patch
+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-export-__audit_inode_child.patch
+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-warning-fixes.patch
+fs-cache-vs-vfs-add-lock-owner-argument-to-flush-operation.patch
+fs-cache-release-page-private-in-failed-readahead.patch
+fs-cache-release-page-private-in-failed-readahead-uninlining.patch
+fs-cache-release-page-private-in-failed-readahead-uninlining-2.patch
+nfs-use-local-caching.patch
+nfs-use-local-caching-fix.patch

 cachefs

+powerpc-pseries-increment-fail-counter-in-pci-recovery.patch
+powerpc-kbuild-warning-fix.patch

 powerpc fixes

+fix-pciehp-compile-issue-when-config_acpi-is-not.patch
+i386-export-memory-more-than-4g-through-proc-iomem.patch
+fix-recovery-path-from-errors-during-pcie_init.patch
+move-various-pci-ids-to-header-file.patch

 PCI fixes

-pci-add-pci_assign_resource_fixed-allow-fixed-address-fix.patch

 Folded into pci-add-pci_assign_resource_fixed-allow-fixed-address.patch

+kconfigurable-resources-core-changes.patch
+kconfigurable-resources-core-changes-i386-fix.patch
+kconfigurable-resources-core-changes-fix.patch
+kconfigurable-resources-driver-pci-changes.patch
+kconfigurable-resources-driver-others-changes.patch
+kconfigurable-resources-arch-dependent-changes-arch-a-i.patch
+kconfigurable-resources-arch-dependent-changes-arch-a-i-fix.patch
+kconfigurable-resources-arch-dependent-changes-arch-j-p.patch
+kconfigurable-resources-arch-dependent-changes-arch-q-z.patch
+typesh-sector_t-and-blkcnt_t-arent-for-userspace.patch

 Make the newly-64-bit resource.start and resource.end Kconfigurably 32-bit.

+ti-pcixx12-cardbus-controller-support.patch

 Cardbus controller device support

+drivers-scsi-use-array_size-macro.patch
+lpfc-sparse-null-warnings.patch
+mpt_interrupt-should-return-irq_none-when.patch
+aic7-cleanup-module_parm_desc-strings.patch
+qla2xxx-lock-ordering-fix.patch
+qla2xxx-lock-ordering-fix-warning-fix.patch
+random-remove-redundant-sa_sample_random-from-ninjascsi.patch
+megaraid-gcc-41-warning-fix.patch
+buslogic-gcc-41-warning-fixes.patch
+add-scsi_add_host-failure-handling-for-nsp32.patch

 scsi things

+gregkh-usb-usb-console-fix-disconnection-issues.patch
+gregkh-usb-usb-clean-out-an-unnecessary-null-check-from-ub.patch
+gregkh-usb-usbatm-remove-pointless-inline.patch
+gregkh-usb-usbatm-remove-no-longer-needed-include.patch
+gregkh-usb-usb-phidget-interfacekit-make-inputs-pollable-and-new-device-support.patch
+gregkh-usb-usb-shuttle_usbat-fix-handling-of-scatter-gather-buffers.patch
+gregkh-usb-usb-shuttle_usbat-hardcode-detection-of-hp-cdrw-devices.patch
+gregkh-usb-usb-shuttle_usbat-hardcode-flash-detection-for-now.patch
+gregkh-usb-usb-usb-storage-alauda-fix-transport-info-mismerge.patch
+gregkh-usb-usb-net2280-add-a-shutdown-routine.patch
+gregkh-usb-usb-uhci-store-the-endpoint-type-in-the-qh-structure.patch
+gregkh-usb-usb-uhci-fix-obscure-bug-in-enqueue.patch
+gregkh-usb-usb-hid-hidbp-input-drivers-fix-various-usb-input-hid-input.c-bugs-that-make-apple-mighty-mouse-work-poorly.patch

 USB tree updates

-fix-sco-on-some-bluetooth-adapters.patch
+fix-sco-on-some-bluetooth-adapters-2.patch

 New version

+x86_64-mm-add-end-endproc-annotations-to-entrys.patch
+x86_64-mm-i386-numa-summit-check.patch
+x86_64-mm-fix-unlikely-profiling--vsyscalls-on-x86_64.patch
+x86_64-mm-fix-b44-checks.patch
+x86_64-mm-nommu-warning.patch
+x86_64-mm-nmi-watchdog-header-cleanup.patch
+x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch
+x86_64-mm-utilize-performance-counter-reservation-framework-in-oprofile.patch
+x86_64-mm-add-smp-support-on-x86_64-to-reservation-framework.patch
+x86_64-mm-add-smp-support-on-i386-to-reservation-framework.patch
+x86_64-mm-cleanup-nmi-interrupt-path.patch
+x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions.patch
+x86_64-mm-add-abilty-to-enable-disable-nmi-watchdog-from-sysfs.patch

 x86_64 tree updates

+x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix.patch
+x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix-fix.patch
+x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86_64-fix.patch
+x86_64-mm-serialize-assign_irq_vector-use-of-static-variables-fix.patch
+add-abilty-to-enable-disable-nmi-watchdog-from-procfs.patch

 Fix them.

-gregkh-devfs-devfs-die-die-die.patch
-gregkh-devfs-devfs-remove-documentation.patch
-gregkh-devfs-devfs-scrub-partitions.patch
-gregkh-devfs-devfs-scrub-init.patch
-gregkh-devfs-devfs-remove-serial-subsystem.patch
-gregkh-devfs-devfs-remove-ide-subsystem.patch
-gregkh-devfs-devfs-remove-sound-subsystem.patch
-gregkh-devfs-devfs-remove-devfs-tape.patch
-gregkh-devfs-devfs-remove-devfs_mk_dir.patch
-gregkh-devfs-devfs-remove-devfs_mk_symlink.patch
-gregkh-devfs-devfs-remove-devfs_mk_bdev.patch
-gregkh-devfs-devfs-remove-devfs_mk_cdev.patch
-gregkh-devfs-devfs-remove-devfs_remove.patch
-gregkh-devfs-devfs-remove-devfs_fs_kernel.h.patch
-gregkh-devfs-devfs-remove-misc-devfs_name.patch
-gregkh-devfs-devfs-remove-genhd-devfs_name.patch
-gregkh-devfs-devfs-remove-videodev-devfs_name.patch
-gregkh-devfs-devfs-remove-line-devfs_name.patch
-gregkh-devfs-devfs-remove-tty-devfs_name.patch
-gregkh-devfs-devfs-tty_driver_no_devfs.patch
-gregkh-devfs-devfs-minor-cleanups.patch
-gregkh-devfs-devfs-feature-removal.patch

 Dropped - too much overlap with the klibc work

+pgdat-allocation-for-new-node-add-specify-node-id-tidy-cleanup.patch
+fix-compile-error-undefined-reference-for-sparc64.patch

 Fix pgdat-allocation-for-new-node-add-specify-node-id.patch some more

+pgdat-allocation-and-update-for-ia64-of-memory-hotplughold-pgdat-address-at-system-running.patch
+pgdat-allocation-and-update-for-ia64-of-memory-hotplug-update-pgdat-address-array.patch
+pgdat-allocation-and-update-for-ia64-of-memory-hotplugallocate-pgdat-and-per-node-data.patch
+page-migration-cleanup-extract-try_to_unmap-from-migration-functions-update-comments-7.patch
+page-migration-cleanup-move-fallback-handling-into-special-function-update-comments-9.patch
+swapless-pm-add-r-w-migration-entries-fix.patch
+swapless-pm-add-r-w-migration-entries-ifdefs.patch
+swapless-pm-add-r-w-migration-entries-update-comments.patch
+swapless-pm-add-r-w-migration-entries-update-comments-4.patch
+swapless-pm-add-r-w-migration-entries-update-comments-6.patch
+swapless-page-migration-modify-core-logic-remove-useless-mapping-checks.patch
+more-page-migration-use-migration-entries-for-file-pages-fix.patch
+more-page-migration-use-migration-entries-for-file-pages-update-comments-5.patch
+more-page-migration-use-migration-entries-for-file-pages-update-comments-8.patch
+more-page-migration-use-migration-entries-for-file-pages-remove_migration_ptes.patch
+more-page-migration-use-migration-entries-for-file-pages-replace-call-to-pageout-with-writepage-2.patch
+page-migration-update-documentation.patch
+aop_truncated_page-victims-in-read_pages-belong-in-the-lru.patch
+introduce-mechanism-for-registering-active-regions-of-memory.patch
+have-power-use-add_active_range-and-free_area_init_nodes.patch
+have-x86-use-add_active_range-and-free_area_init_nodes.patch
+have-x86_64-use-add_active_range-and-free_area_init_nodes.patch
+#have-ia64-use-add_active_range-and-free_area_init_nodes.patch
+tracking-dirty-pages-in-shared-mappings-v4.patch
+tracking-dirty-pages-in-shared-mappings-v4-fix2.patch
+tracking-dirty-pages-in-shared-mappings-v4-fix3.patch
+throttle-writers-of-shared-mappings.patch
+throttle-writers-of-shared-mappings-tidy.patch
+optimize-follow_pages.patch
+slab-verify-pointers-before-free.patch
+sparsemem-record-nid-during-memory-present.patch

 Memory management updates

+fix-x86-microcode-driver-handling-of-multiple-matching.patch
+i386-break-out-of-recursion-in-stackframe-walk.patch
+dont-trigger-full-rebuild-via-config_x86_mce.patch

 x86 updates

-x86_64-disable-tsc-with-seccomp.patch

 Dropped

+remove-duplicate-symbol-exports-on-alpha.patch

 Cleanup

+swsusp-documentation-updates.patch
+swsusp-fix-typo-in-cr0-handling.patch

 swsusp updates

-s390-hypervisor-file-system.patch
-s390-hypervisor-file-system-fixes.patch

 Dropped (what I had was out of date and it got all confusing.  Need a resend)

+add-raw-driver-kconfig-entry-for-s390.patch

 Enable raw driver on s390

+percpu-counter-data-type-changes-to-suppport-fix-fix-fix.patch

 Fix percpu-counter-data-type-changes-to-suppport.patch some more

+make-rcu-api-inaccessible-to-non-gpl-linux-kernel-modules.patch
+doc-add-audit-acct-to-docbook.patch
+ip2-fix-sections.patch
+sgi-ioc4-detect-io-card-variant.patch
+two-additions-to-linux-documentation-ioctl-numbertxt.patch
+when-config_base_samll=1-the-kernel-261611-cascade-in-kernel-timerc-may-enter-the-infinite-loop.patch
+codingstyle-add-typedefs-chapter.patch
+fs-bufferc-possible-cleanups.patch
+rtc-rtc-dev-uie-emulation.patch
+drivers-md-raid6algosc-fix-a-null-dereference.patch
+adjust-handle_irr_event-return-type.patch
+sparse-fixes-for-synclink_cs.patch
+jbd-split-checkpoint-lists.patch
+jbd-split-checkpoint-lists-tidy.patch
+add-__iowrite64_copy.patch
+add-pci_cap_id_vndr.patch
+mark-address_space_operations-const.patch
+mark-address_space_operations-const-fix.patch
+mark-address_space_operations-const-fix-2.patch
+more-bug_on-conversion.patch
+make-kernel-ignore-bogus-partitions.patch
+drivers-block-loopc-dont-return-garbage-if-loop_set_status-not-called.patch
+docs-update-sparsetxt-with-check_endian.patch
+drivers-acorn-char-pcf8583-vs-rtc-subsystem.patch
+rewritten-backlight-infrastructure-for-portable-apple-computers.patch
+ensure-null-deref-cant-possibly-happen-in-is_exported.patch
+bluetooth-fix-potential-null-ptr-deref-in-dtl1_cscdtl1_hci_send_frame.patch
+bloat-o-meter-gcc-4-fix.patch
+random-remove-sa_sample_random-from-floppy-driver.patch
+random-make-cciss-use-add_disk_randomness.patch
+random-change-cpqarray-to-use-add_disk_randomness.patch
+random-remove-bogus-sa_sample_random-from-at91-compact-flash-driver.patch
+random-remove-redundant-sa_sample_random-from-touchscreen-drivers.patch
+define-__raw_get_cpu_var-and-use-it.patch
+allow-for-per-cpu-data-being-in-tdata-and-tbss-sections.patch
+allow-for-per-cpu-data-being-in-tdata-and-tbss-sections-fix.patch
+allow-for-per-cpu-data-being-in-tdata-and-tbss-sections-tidy.patch
+deprecate-smbfs-in-favour-of-cifs.patch
+allow-raw_notifier-callouts-to-unregister-themselves.patch
+hptiop-highpoint-rocketraid-3xxx-controller-driver.patch
+hptiop-highpoint-rocketraid-3xxx-controller-driver-list-locking.patch
+hptiop-highpoint-rocketraid-3xxx-controller-driver-list-locking-updates.patch
+hptiop-highpoint-rocketraid-3xxx-controller-driver-list-locking-updates-updates-2.patch
+fix-kbuild-dependencies-for-synclink-drivers.patch
+fs-freevxfs-cleanup-of-spelling-errors.patch
+pnp-card_probe-fix-memory-leak.patch
+fix-unlikely-memory-leak-in-dac960-driver.patch
+ufs-ufs_trunc_indirect-infinite-cycle.patch
+ufs-right-block-allocation.patch
+ufs-right-block-allocation-fixes.patch
+sunsu-license-fix.patch

 Patches ;)

+per-task-delay-accounting-setup.patch
+per-task-delay-accounting-setup-fix-1.patch
+per-task-delay-accounting-setup-fix-2.patch
+per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection.patch
+per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection-fix-1.patch
+per-task-delay-accounting-cpu-delay-collection-via-schedstats.patch
+per-task-delay-accounting-cpu-delay-collection-via-schedstats-fix-1.patch
+per-task-delay-accounting-utilities-for-genetlink-usage.patch
+per-task-delay-accounting-taskstats-interface.patch
+per-task-delay-accounting-taskstats-interface-fix-1.patch
+per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface.patch
+per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-use-portable-cputime-api-in-__delayacct_add_tsk.patch
+per-task-delay-accounting-documentation.patch
+per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays.patch
+per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays-warning-fix.patch

 per-task delay accounting

+time-use-clocksource-abstraction-for-ntp-adjustments-optimize-out-some-mults-since-gcc-cant-avoid-them.patch
+time-i386-clocksource-drivers-fix-spelling-typos.patch
+generic-time-add-macro-to-simplify-hide-mask.patch

 Updates to the x86 time management patches

-mmc-multi-sector-writes.patch

 Dropped

+capi-crash--race-condition.patch

 i4l semifix

+kconfig-select-things-at-the-closest-tristate-instead-of-bool.patch

 nfsd Kconfig fix

+sched-comment-bitmap-size-accounting.patch
+unnecessary-long-index-i-in-sched.patch

 CPU scheduler work

+mm-implement-swap-prefetching-fix.patch
+mm-implement-swap-prefetching-sched-batch.patch

 swap-prefetch fixes

+pi-futex-patchset-v4-fix.patch
+document-futex-pi-design.patch
+document-futex-pi-design-fix.patch
+document-futex-pi-design-fix-fix.patch
+futex_requeue-optimization.patch

 pi-futex updates

+de_thread-fix-lockless-do_each_thread.patch

 task maangment fix

+coredump-kill-ptrace-related-stuff-fix.patch

 Fix coredump-kill-ptrace-related-stuff.patch

+ecryptfs-fs-makefile-and-fs-kconfig.patch
+ecryptfs-documentation.patch
+ecryptfs-makefile.patch
+ecryptfs-main-module-functions.patch
+ecryptfs-main-module-functions-vs-nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
+ecryptfs-header-declarations.patch
+ecryptfs-superblock-operations.patch
+ecryptfs-dentry-operations.patch
+ecryptfs-file-operations.patch
+ecryptfs-inode-operations.patch
+ecryptfs-mmap-operations.patch
+mark-address_space_operations-const-vs-ecryptfs-mmap-operations.patch
+ecryptfs-keystore.patch
+ecryptfs-crypto-functions.patch
+ecryptfs-debug-functions.patch
+ecryptfs-alpha-build-fix.patch

 ecryptfs

+reiser4-add-missing-txn_restart-before-get_nonexclusive_access-calls.patch
+reiser4-check-radix-tree-emptiness-properly.patch
+reiser4-check-radix-tree-emptiness-properly-2.patch

 reiser4 updates

+reiser4-vs-nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
+reiser4-vs-nfs-permit-filesystem-to-perform-statfs-with-a-known-root-dentry.patch

 Fix reiser4 damage due to other patches

+ide-fix-hpt37x-timing-tables.patch
+ide-optimize-hpt37x-timing-tables.patch
+ide-fix-hpt3xx-hotswap-support.patch
+ide-fix-the-case-of-multiple-hpt3xx-chips-present.patch
+ide-hpt3xx-fix-pci-clock-detection.patch
+ide-pdc202xx_old-remove-the-obsolete-busproc.patch
+piix-fix-82371mx-enablebits.patch
+piix-remove-check-for-broken-mw-dma-mode-0.patch
+piix-slc90e66-pio-mode-fallback-fix.patch
+make-number-of-ide-interfaces-configurable.patch

 IDE driver fixes

+nvidiafb-add-support-for-geforce-6100-and-related-chipsets.patch
+fbdev-add-1366x768-wxga-mode-to-mode-database.patch
+intelfb-use-firmware-edid-for-mode-database.patch
+vesafb-fix-return-code-of-vesafb_setcolreg.patch
+vesafb-prefer-vga-registers-over-pmi.patch
+vt-delay-the-update-of-the-visible-console.patch
+atyfb-fix-dead-code.patch
+fbdev-coverity-bug-85.patch
+fbdev-coverity-bug-90.patch

 fbdev driver updates

+md-bitmap-fix-online-removal-of-file-backed-bitmaps.patch
+md-bitmap-remove-bitmap-writeback-daemon.patch
+md-bitmap-cleaner-separation-of-page-attribute-handlers-in-md-bitmap.patch
+md-bitmap-use-set_bit-etc-for-bitmap-page-attributes.patch
+md-bitmap-remove-unnecessary-page-reference-manipulations-from-md-bitmap-code.patch
+md-bitmap-remove-dead-code-from-md-bitmap.patch
+md-bitmap-tidy-up-i_writecount-handling-in-md-bitmap.patch
+md-bitmap-change-md-bitmap-file-handling-to-use-bmap-to-file-blocks.patch

 RAID updates

-nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch
-x86_64-ipi-calltraces.patch

 Dropped due to rejects

-exit-dont-call-sleeping-things-when-oopsing.patch

 Dropped due to lack of interest



All 992 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/patch-list


