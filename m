Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVHWEbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVHWEbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 00:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVHWEbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 00:31:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751265AbVHWEbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 00:31:49 -0400
Date: Mon, 22 Aug 2005 21:30:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6-mm2
Message-Id: <20050822213021.1beda4d5.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm2/

- Various updates.  Nothing terribly noteworthy.

- This kernel still spits a bunch of scheduling-while-atomic warnings from
  the scsi code.  Please ignore.


Changes since 2.6.13-rc6-mm1:


 linus.patch
 git-acpi.patch
 git-alsa.patch
 git-arm.patch
 git-cpufreq.patch
 git-cryptodev.patch
 git-drm.patch
 git-ia64.patch
 git-audit.patch
 git-input.patch
 git-kbuild.patch
 git-libata-all.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-ocfs2.patch
 git-serial.patch
 git-scsi-block.patch
 git-scsi-iscsi.patch
 git-scsi-iscsi-vs-git-net.patch
 git-scsi-misc.patch
 git-ucb.patch
 git-watchdog.patch

 Subsystem trees

-mobil-pentium-4-ht-and-the-nmi.patch
-sis190-must-select-mii.patch
-pci-pm-support-pm-cap-version-3.patch
-e1000-printk-warning-fix-2.patch
-r8169-pci-id-for-the-linksys-eg1032.patch
-driver-for-ibm-automatic-server-restart-watchdog.patch
-driver-for-ibm-automatic-server-restart-watchdog-fix.patch

 Merged

+preempt-race-in-getppid.patch

 getppid() fix

+md-make-sure-resync-gets-started-when-array-starts.patch
+gregkh-usb-usb-zd1201-kmalloc-size-fix.patch
+export-machine_power_off-on-ppc64.patch
+usbnet-oops-fix.patch
+x86_64-dont-oops-at-boot-when-empty-opteron-node-has-io.patch

 Fixes for 2.6.13.

+git-acpi-ia64-fix-2.patch

 Make git-acpi.patch compile (but not necessarily work) on ia64

+gregkh-driver-driver-kfree-check-cleanup.patch
+gregkh-driver-sysfs-write-ENOBUFS.patch
+gregkh-driver-klist-fix-semantics.patch

 driver tree additions

+driver-core-fix-bus_rescan_devices-race.patch

 Fix race in bus_rescan_devices()

+git-drm-drm_agpsupport-warning-fix.patch

 Fix warning in git-drm.patch

+gregkh-i2c-w1-10-crc16.patch
+gregkh-i2c-w1-11.patch
+gregkh-i2c-w1-12.patch

 i2c tree updates

+ia64-cpuset-build_sched_domains-mangles-structures.patch

 Fix sched domains on ia64 only.

+sata_sisc-introducing-device-id-0x182.patch

 New stat device ID (not for merging - just for keeping track of the
 shortcoming (but it probably works OK)).

-git-net-fixups.patch

 No longer needed

+negative-timer-loop-with-lots-of-ipv4-peers.patch

 Fix an ipv4 problem with tons of connections.

+ocfs2-prep.patch

 Revert earlier patches so that the ocfs2 patch applies without fuss.  Don't
 ask.

+gregkh-pci-pci-pm-support-pm-cap-version-3.patch
+gregkh-pci-pci-pci_walk_bus.patch
+gregkh-pci-pci-fix-hotplug-vars.patch

 PCI tree updates

+git-scsi-misc-ibmvscsi-fix.patch
+git-scsi-misc-ibmvscsi-fix-fix.patch

 Fix stuff in git-scsi-misc.patch

+gregkh-usb-usb-yealink-update.patch
+gregkh-usb-usb-storage-onetouch-cleanups.patch

 USB tree updates

+git-ucb.patch

 New arm-related tree from rmk.

+sparsemem-extreme-hotplug-preparation-fix.patch

 Fix sparsemem-extreme-hotplug-preparation.patch

+slab-removes-local_irq_save-local_irq_restore-pair.patch

 slab cleanup/speedup

+ppc32-fix-emac-tx-channel-assignments-for-npe405h.patch
+ppc32-fix-bamboo-and-luan-build-warnings.patch

 ppc32 updates

+mips-add-default-select-configs-for-vr41xx-fix.patch

 Fix mips-add-default-select-configs-for-vr41xx.patch

+mips-add-pcibios_select_root.patch
+mips-add-pcibios_bus_to_resource.patch
+mips-add-more-sys_support__kernel-and.patch

 MIPS updates

+i386-fix-incorrect-fp-signal-delivery.patch

 Fix x86 FP problem

+x86_64-fix-numa-node-sizing-in-nr_free_zone_pages.patch

 Might fix the x86_64 failure to calcluate the correct amount of system
 memory.

+swsusp-fix-error-handling-and-cleanups.patch

 swsusp fix

-fix-handling-in-parport_pc-init-code.patch

 Was wrong.

+arm26-one-g-is-enough-for-everyone.patch

 ARM build cleanup

+largefile-support-for-accounting.patch

 BSD accounting files can be big.

+fs-remove-redundant-timespec_equal-test-in-update_atime.patch

 Clean up update_atime()

+remove-a-redundant-variable-in-sys_prctl.patch
+remove-filef_maxcount.patch
+remove-the-second-arg-of-do_timer_interrupt.patch

 Cleanups

+fix-cramfs-making-duplicate-entries-in-inode-cache.patch
+fix-cramfs-making-duplicate-entries-in-inode-cache-tidy.patch

 cramfs fix

+race-condition-with-drivers-char-vtc-bug-in-vt_ioctlc.patch

 Fix vt race

+fix-send_sigqueue-vs-thread-exit-race.patch

 Fix signal handling race.

+adapt-scripts-ver_linux-to-new-util-linux-version-strings.patch

 ver_linux fix

+dmi-add-onboard-devices-discovery-fix.patch

 Fix dmi-add-onboard-devices-discovery.patch

+dvb-clarify-description-text-for-dvb-bt8xx-in-kconfig-fix.patch

 Update dvb-clarify-description-text-for-dvb-bt8xx-in-kconfig.patch

+yenta-auto-tune-ene-bridges-for-cb-cards.patch

 Yenta fix for weird bridge types

+ingo-nfs-stuff-fix.patch

 Fix ingo-nfs-stuff.patch

+nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus-warning-fix.patch

 Fix nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch

+sysfs-crash-debugging-fix.patch

 Fix sysfs-crash-debugging.patch

+fbdev-resurrect-hooks-to-get-edid-from-firmware.patch
+fbdev-resurrect-hooks-to-get-edid-from-firmware-fix.patch
+savagefb-driver-updates.patch
+nvidiafb-fallback-to-firmware-edid.patch
+fbdev-fix-greater-than-1-bit-monochrome-color-handling.patch
+fbcon-saner-16-color-to-4-color-conversion.patch
+console-fix-buffer-copy-on-vc-resize.patch
+atyfb-remove-code-that-sets-sync-polarity-unconditionally.patch
+radeonfb_old-fix-broken-link.patch

 fbdev updates

+md-support-md-linear-array-with-components-greater-than-2-terabytes.patch
+md-raid1_quiesce-is-back-to-front-fix-it.patch
+md-make-sure-bitmap_daemon_work-actually-does-work.patch
+md-do-not-set-mddev-bitmap-until-bitmap-is-fully-initialised.patch
+md-allow-hot-adding-devices-to-arrays-with-non-persistant-superblocks.patch
+md-allow-md-to-load-a-superblock-with-feature-bit-1-set.patch
+md-fix-bitmap-read_sb_page-so-that-it-handles-errors-properly.patch

 RAID updates

+documentation-how-to-apply-patches-for-various-tree-fix.patch

 Update documentation-how-to-apply-patches-for-various-trees.patch

+docs-fix-misinformation-about.patch
+update-kfree-vfree-and-vunmap-kerneldoc.patch
+suspend-update-warnings-in-documentation.patch

 More documentation updates

+fbdev-update-framebuffer-feature-list.patch

 Update post-halloween-doc.patch for fbdev

+drivers-cdrom-fix-up-schedule_timeout-usage-fix.patch

 Fix drivers-cdrom-fix-up-schedule_timeout-usage.patch



All 1009 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm2/patch-list

