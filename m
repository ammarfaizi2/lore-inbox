Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751995AbWIXLCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbWIXLCW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 07:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWIXLCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 07:02:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751965AbWIXLCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 07:02:20 -0400
Date: Sun, 24 Sep 2006 04:02:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-mm1
Message-Id: <20060924040215.8e6e7f1a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/

- 2.6.18-rc7-mm1 had quite a lot of problems due to changes in the driver
  tree.  All of those have been dropped from this patchset.




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




Changes since 2.6.18-rc7-mm1:


 origin.patch
 git-acpi.patch
 git-arm.patch
 git-block.patch
 git-cifs.patch
 git-drm.patch
 git-dvb.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-intelfb.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-magic.patch
 git-mmc.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-parisc.patch
 git-pcmcia.patch
 git-serial.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-watchdog.patch
 git-xfs.patch

 git trees

-add-headers_check-target-to-output-of-make-help.patch
-fix-make-headers_check-on-m68k.patch
-headers_check-clean-up-asm-parisc-pageh-for-user-headers.patch
-ext2-remove-superblock-lock-contention-in-ext2_statfs-2.patch
-sound-core-use-seek_set-cur.patch
-opl4-use-seek_set-cur.patch
-gus-use-seek_set-cur.patch
-mixart-use-seek_set-cur.patch
-cifs-use-seek_end-instead-of-hardcoded-value.patch
-git-cpufreq-sw_any_bug_dmi_table-can-be-used-on-resume.patch
-git-magic-fixup.patch
-git-magic-fixup-2.patch
-mtd-maps-ixp4xx-partition-parsing.patch
-fix-the-unlock-addr-lookup-bug-in-mtd-jedec-probe.patch
-fs-jffs2-jffs2_fs_ih-removal-of-old-code.patch
-drivers-mtd-nand-au1550ndc-removal-of-old-code.patch
-e1000-disable-device-on-pci-error.patch
-drivers-returning-proper-error-from-serial-driver.patch
-omap1510-serial-fix-for-115200-baud.patch
-git-scsi-misc-nlmsg_multicast-fix.patch
-megaraid-gcc-41-warning-fix.patch
-aha152x-fix.patch
-x86-remaining-pda-patches.patch
-x86-restore-i8259a-eoi-status-on-resume.patch
-pci-mtd-switch-to-pci_get_device-and-do-ref-counting.patch

 Merged into mainline or a subsystem tree.

+rtc-lockdep-fix-workaround.patch
+i386-bootioremap--kexec-fix.patch
+do-not-free-non-slab-allocated-per_cpu_pageset.patch
+vidioc_enumstd-bug.patch
+backlight-fix-oops-in-__mutex_lock_slowpath-during-head-sys-class-graphics-fb0.patch
+cpu-to-node-relationship-fixup-take2.patch
+cpu-to-node-relationship-fixup-map-cpu-to-node.patch
+i386-fix-flat-mode-numa-on-a-real-numa-system.patch
+load_module-no-bug-if-module_subsys-uninitialized.patch

 Various fixes, many takked for 2.6.18.x

+git-block-fixup.patch

 Fix rejects in git-block.patch

+gregkh-driver-documentation-abi-devfs-is-not-obsolete-but-removed.patch
+gregkh-driver-device_bin_file.patch
-gregkh-driver-config_sysfs_deprecated.patch
-gregkh-driver-udev-devices.patch
-gregkh-driver-mem-devices.patch
-gregkh-driver-misc-devices.patch
-gregkh-driver-tty-device.patch
-gregkh-driver-vt-device.patch
-gregkh-driver-vc-device.patch
-gregkh-driver-raw-device.patch
-gregkh-driver-msr-device.patch
-gregkh-driver-cpuid-device.patch
-gregkh-driver-sound-device.patch
-gregkh-driver-ppp-device.patch
-gregkh-driver-ppdev-device.patch
-gregkh-driver-mmc-device.patch
-gregkh-driver-pcmcia-device.patch
-gregkh-driver-input-device.patch
-gregkh-driver-firmware-device.patch
-gregkh-driver-fb-device.patch
-gregkh-driver-usb-move-usb_device_class-class-devices-to-be-real-devices.patch
-gregkh-driver-usb-convert-usb-class-devices-to-real-devices.patch
-gregkh-driver-network-class_device-to-device.patch
-gregkh-driver-class_device_rename-remove.patch
+gregkh-driver-driver-core-fix-potential-deadlock-in-driver-core.patch
+gregkh-driver-driver-core-remove-unneeded-routines-from-driver-core.patch
+gregkh-driver-driver-core-don-t-call-put-methods-while-holding-a-spinlock.patch
-gregkh-driver-input-device-a3d-fix.patch
-gregkh-driver-input-device-more-fixes.patch
-gregkh-driver-input-device-even-more-fixes.patch
-gregkh-driver-input-device-even-more-fixes-2.patch
-gregkh-driver-fb-device-fixes.patch
-more-driver-tree-fixes.patch

 Driver tree updates

+driver-core-fixes-make_class_name-retval-check.patch
+driver-core-fixes-device_register-retval-check-in.patch
+driver-core-fixes-sysfs_create_link-retval-check-in.patch
+driver-core-fixes-bus_add_attrs-retval-check.patch
+driver-core-fixes-bus_add_device-cleanup-on-error.patch
+driver-core-fixes-device_add-cleanup-on-error.patch
+driver-core-fixes-device_create_file-retval-check-in.patch
+driver-core-fixes-sysfs_create_group-retval-in-topologyc.patch
+sysfs-remove-duplicated-dput-in-sysfs_update_file.patch
+sysfs-update-obsolete-comment-in-sysfs_update_file.patch

 Fix various things in driver core.

-dvb-usb-vs-driver-tree.patch

 Dropped

+allow-rc5-codes-64-127-in-ir-kbd-i2cc.patch
+v4l-support-for-saa7134-based-avertv-hybrid-a16ar.patch

 DVB things.

+gregkh-i2c-i2c-isa-plan-for-removal.patch

 i2v tree update

+git-geode-fixup.patch

 Fix rejects in git-geode.patch

+git-gfs2-fixup.patch

 Fix rejects in git-gfs2.patch

+ia64-kprobes-fixup-the-pagefault-exception-caused-by-probehandlers.patch

 ia64 fix

-stowaway-vs-driver-tree.patch

 Dropped

+wistron-fix-detection-of-special-buttons.patch

 input driver fix

+mmc-driver-for-ti-flashmedia-card-reader-source.patch
+mmc-driver-for-ti-flashmedia-card-reader-source-tidy.patch
+mmc-driver-for-ti-flashmedia-card-reader-source-alpha-fix.patch
+mmc-driver-for-ti-flashmedia-card-reader-source-vs-git-mmc.patch
+mmc-driver-for-ti-flashmedia-card-reader-kconfig-makefile.patch

 mmc driver

+git-netdev-all-fixup.patch

 Fix rejects in git-netdev-all.patch

-ip100a-fix-tx-pause-bug-reset_tx-intr_handler.patch
-ip100a-change-phy-address-search-from-phy=1-to-phy=0.patch
-ip100a-correct-initial-and-close-hardware-step.patch
-ip100a-solve-host-error-problem-in-low-performance.patch

 Dropped, needs redoing.

+forcedeth-hardirq-lockdep-warning.patch
+e1000-account-for-net_ip_align-when-calculating-bufsiz.patch

 netdev updates

-git-net-fixup.patch

 Dropped.

-dev_change_name-debug.patch

 Dropped, unneeded.

-bluetooth-small-cleanups.patch

 Nacked.

-git-nfs-fixup.patch

 Dropped.

+revert-genirq-core-fix-handle_level_irq.patch

 Needed to make the parisc tree apply.

+git-parisc-fixup.patch

 Fix rejects in git-parisc.patch

+pcmcia-au1000_generic-fix.patch

 pcmcia fix

+ppc-fix-typo-in-cpm2h.patch

 ppc fix

+git-serial-fixup.patch

 Fix rejects in git-serial.patch

-gregkh-pci-pci-sort-device-lists-breadth-first.patch
-gregkh-pci-pci_bridge-device.patch
+gregkh-pci-acpiphp-set-hpp-values-before-starting-devices.patch
+gregkh-pci-acpiphp-initialize-ioapics-before-starting-devices.patch
+gregkh-pci-acpiphp-do-not-initialize-existing-ioapics.patch
+gregkh-pci-pci-add-pci_stop_bus_device.patch
+gregkh-pci-acpiphp-stop-bus-device-before-acpi_bus_trim.patch
+gregkh-pci-acpiphp-disable-bridges.patch
+gregkh-pci-pci-assign-ioapic-resource-at-hotplug.patch
+gregkh-pci-acpiphp-add-support-for-ioapic-hot-remove.patch
+gregkh-pci-ia64-pci-dont-disable-irq-which-is-not-enabled.patch
+gregkh-pci-pciehp-fix-wrong-return-value.patch

 PCI tree updates

-git-scsi-misc-fixup.patch

 Dropped.

+3w-xxxx-fix-ata-udma-upgrade-message-number.patch
+scsi-included-header-cleanup.patch
+pci-error-recovery-symbios-scsi-device-driver.patch

 SCSI updates

+gregkh-usb-usb-unusual_devs-entry-for-lacie-dvd-rw.patch
+gregkh-usb-usb-unusual_dev-entry-for-sony-p990i.patch
-gregkh-usb-usb-introduce-usb_reenumerate_device.patch
+gregkh-usb-usb-fix-root-hub-resume-when-config_usb_suspend-is-not-set.patch
+gregkh-usb-usb-serial-support-alcor-micro-corp.-usb-2.0-to-rs-232-through-pl2303-driver.patch
+gregkh-usb-usb-ftdi-elan-client-driver-for-elan-uxxx-adapters.patch
+gregkh-usb-usb-u132-hcd-host-controller-driver-for-elan-u132-adapter.patch
+gregkh-usb-usb-remove-unneeded-void-casts-in-core-files.patch
+gregkh-usb-usb-dealias-110-code.patch
+gregkh-usb-usb-ohci_usb-can-oops-on-shutdown.patch
+gregkh-usb-usb-force-root-hub-resume-after-power-loss.patch
+gregkh-usb-usb-ehci-update-via-workaround.patch
+gregkh-usb-usb-remove-otg-build-warning.patch

 USB tree updates

-revert-gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch

 Dropped.

+xpad-dance-pad-support.patch
+xpad-dance-pad-support-tidy.patch

 USB updates

-x86_64-mm-via-force-dma-mask.patch
-x86_64-mm-iommu-setup-style.patch
-x86_64-mm-i386-acpi-mcfg-check.patch
-x86_64-mm-acpi-mcfg-check.patch
-x86_64-mm-remove-mcfg-dmi.patch
+x86_64-mm-mcfg-type1-heuristic.patch
+x86_64-mm-restore-i8259a-eoi.patch
+x86_64-mm-core2-rep-good.patch
+x86_64-mm-mmconfig-fix-comment.patch
+x86_64-mm-amd-single-cpu-sync-rdtsc.patch
+x86_64-mm-remove-signal-map.patch
+x86_64-mm-ia32-signal-regparm.patch
+x86_64-mm-ia32-signal-style.patch
+x86_64-mm-unwind-signal-frame-detect.patch
+x86_64-mm-dont-leak-nt.patch
+x86_64-mm-early-scan-depends-on-pci.patch
+x86_64-mm-move-pci-direct-out-of-line.patch
+x86_64-mm-allow-disabling-early-pci-scans.patch
+x86_64-mm-fix-unw-pc-warning.patch
+x86_64-mm-i386-fix-unwind-disabled.patch
+x86_64-mm-add-64bit-jiffies-compares-for-use-with-get_jiffies_64.patch
+x86_64-mm-refactor-thermal-throttle-processing.patch
+x86_64-mm-make-the-jiffies-compares-use-the-64bit-safe-macros..patch
+x86_64-mm-add-a-cumulative-thermal-throttle-event-counter..patch

 x86_64 tree updates

-revert-x86_64-mm-detect-cfi.patch
-unwinder-warning-fixes.patch
-fix-x86_64-mm-i386-backtrace-ebp-fallback.patch

 Dropped.

+revert-x86_64-mm-i386-pda-current.patch
+revert-x86_64-mm-i386-pda-smp-processorid.patch
+revert-x86_64-mm-i386-pda-vm86.patch
+revert-x86_64-mm-i386-pda-user-abi.patch
+revert-x86_64-mm-i386-pda-use-gs.patch
+revert-x86_64-mm-i386-pda-init-pda.patch

 Revert busted PDA patches.

+gfp_thisnode-for-the-slab-allocator-v2-fix-3.patch

 Fix gfp_thisnode-for-the-slab-allocator-v2.patch some more

+optional-zone_dma-in-the-vm-tidy.patch

 Clean up optional-zone_dma-in-the-vm.patch

+mm-micro-optimise-zone_watermark_ok.patch
+do_no_pfn.patch
+do_no_pfn-tweaks.patch
+mspec-driver.patch
+shared-page-table-for-hugetlb-page-v2.patch
+shared-page-table-for-hugetlb-page-v2-tidy.patch
+shared-page-table-for-hugetlb-page-v2-comments.patch

 Memory management updates

+remove-zone_dma-remains-from-avr32.patch
-avr32-mtd-unlock-flash-if-necessary.patch

 AVR32 updates

+m32r-fix-make-headers_check.patch

 m32r fix

-inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-vs-gfs2.patch
+inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-fix-fix.patch
+inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-xfs-fix.patch

 More work on
 inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default.patch

+ams-check-return-values-from-device_create_file.patch

 Update apple-motion-sensor-driver-2.patch (wrongly, apparently)

-mxser-upgrade-to-191.patch

 Dropped.

+ext3-inode-numbers-are-unsigned-long-fix.patch

 Fix ext3-inode-numbers-are-unsigned-long.patch

+submit-checklist-mention-headers_check.patch
+doc-lockdep-design-explain-display-of-state-bits.patch
+leds-turn-led-off-when-changing-triggers.patch
+directed-yield-cpu_relax-variants-for-spinlocks-and-rw-locks.patch
+directed-yield-direct-yield-of-spinlocks-for-powerpc.patch
+directed-yield-direct-yield-of-spinlocks-for-s390.patch
+synclink_gt-add-bisync-and-monosync-modes.patch
+synclink_gt-increase-max-devices.patch
+cciss-remove-unneeded-spaces-in-output-for-attached-volumes-resend.patch
+remove-superfluous-call-to-call-to-cdev_del.patch
+howto-mention-bughunting.patch
+isicom-correct-firmware-loading.patch
+jbd-16t-fixes.patch
+dontdiff-add-utsreleaseh.patch

 Misc updates and fixes

+clean-up-unused-kiocb-variables.patch

 AIO cleanup

+fs-cache-make-kafs-use-fs-cache-kconfig-fix.patch

 Fix fs-cache-make-kafs-use-fs-cache.patch some more

+nfs-use-local-caching-kconfig-fix.patch

 Fix nfs-use-local-caching.patch some more.

+afs-amend-the-afs-configuration-options.patch

 AFS config fix

+pci-mxser-pci-refcounts.patch
+mxser-make-an-experimental-clone.patch

 Prepare to generate a new mxser driver

+hisax-niccy-cleanup.patch

 ISDN driver cleanups

-sched-generic-sched_group-cpu-power-setup.patch
+sched-introduce-child-field-in-sched_domain.patch
+sched-cleanup-sched_group-cpu_power-setup.patch

 This patch was split up

+namespaces-exit_task_namespaces-invalidates-nsproxy.patch

 namespace fix

+provide-kernel_execve-on-all-architectures-fix-4.patch

 Fix provide-kernel_execve-on-all-architectures.patch even more

+replace-cad_pid-by-a-struct-pid.patch
+replace-cad_pid-by-a-struct-pid-fixes.patch

 Use `struct pid'

+documentation-fixes-in-intel810txt.patch
+radeonfb-supend-resume-support-for-acer-aspire-2010.patch

 fbdev updates

+integrity-service-api-and-dummy-provider-cleanup-use-of-configh.patch
+slim-main-patch-misc-cleanups-requested-at-inclusion-time.patch
+slim-main-patch-handle-failure-to-register.patch
+slim-main-patch-fix-bug-with-mm_users-usage.patch
+slim-secfs-patch-slim-correct-use-of-snprintf.patch
+slim-secfs-patch-cleanup-use-of-configh.patch
+slim-make-and-config-stuff-makefile-fix.patch

 Update the SLIM security module

-documentation-ioctl-messtxt-start-tree-wide-ioctl-registry.patch
-ioctl-messtxt-xfs-typos.patch
-post-halloween-doc.patch

 Dropped


All 2,040 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/patch-list

