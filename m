Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423047AbWJaJv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423047AbWJaJv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423053AbWJaJv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:51:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423047AbWJaJvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:51:25 -0500
Date: Tue, 31 Oct 2006 01:51:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc4-mm1
Message-Id: <20061031015121.dfc7e02a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It should be here:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc4/2.6.19-rc4-mm1/

but mirroring has broken, so I've temporarily put a copy here:

http://userweb.kernel.org/~akpm/2.6.19-rc4-mm1/

Please check ftp.kernel.org (or www.kernel.org) first.




- 2.6.19-rc3-mm1 was rather a mess.  This is mainly an attempt to repair it.

- The ACPI tree has been dropped due to Rafael's testing failures.

- The driver tree has been dropped due to various problems.  Consequently a
  string of patches which are destined for the driver tree have also been
  temporarily removed.  Various other patches have been set aside, rejects
  have been fixed up, etc.  Dropping trees is a pain.

- None of the other quilt trees (gregkh-*, jdelvare-*, x86_64-mm-*) have
  been repulled since 2.6.19-rc3-mm1.  But the git trees were repulled a few
  hours ago.



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



Changes since 2.6.19-rc3-mm1:


 git-alsa.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-jfs.patch
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
 git-sh.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-sas.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees

-ioc4_serial-irq-flags-fix.patch
-revert-pci-quirk-for-ibm-dock-ii-cardbus-controllers.patch
-ndiswrapper-dont-set-the-module-taints-flags.patch
-let-pci_multithread_probe-depend-on-broken.patch
-isdn-gigaset-avoid-cs-dev-null-pointer-dereference.patch
-m68k-consolidate-initcall-sections.patch
-taskstats-fix-sk_buff-leak.patch
-taskstats-fix-sk_buff-size-calculation.patch
-lockdep-annotate-declare_wait_queue_head.patch
-cryptocop-double-spin_lock_irqsave.patch
-mtd-fix-last-kernel-doc-warning.patch
-docbook-make-a-filesystems-book.patch
-fix-remove-the-use-of-_syscallx-macros-in-uml.patch
-uml-fix-compilation-options-for-user_objs.patch
-xacct_add_tsk-fix-pure-theoretical-mm-use-after-free.patch
-drivers-ide-pci-genericc-add-missing-newline-to-the-all-generic-ide-message.patch
-net-fix-uaccess-handling.patch
-gfs2-dont-panic-needlessly.patch

 Merged into mainline or a subsystem tree.

+find_bd_holder-fix.patch
+uml-add-_text-definition-to-linker-scripts.patch
+uml-add-initcalls.patch
+taskstats-fix-sub-threads-accounting.patch
+ecryptfs-clean-up-crypto-initialization.patch
+ecryptfs-hash-code-to-new-crypto-api.patch
+ecryptfs-cipher-code-to-new-crypto-api.patch
+ecryptfs-consolidate-lower-dentry_opens.patch
+ecryptfs-remove-ecryptfs_umount_begin.patch
+ecryptfs-fix-handling-of-lower-d_count.patch
+md-check-bio-address-after-mapping-through-partitions.patch
+md-check-bio-address-after-mapping-through-partitions-tidy.patch
+md-send-online-offline-uevents-when-an-md-array-starts-stops.patch
+sys_pselect7-vs-compat_sys_pselect7-uaccess-error-handling.patch
+update-some-docbook-comments.patch
+docbook-merge-journal-api-into-filesystemstmpl.patch
+create-compat_sys_migrate_pages.patch
+wire-up-sys_migrate_pages.patch
+fix-ipc-entries-removal.patch
+un-needed-add-store-operation-wastes-a-few-bytes.patch
+fix-ufs-superblock-alignment-issues.patch
+lkdtm-module_param-fixes.patch

 2.6.19 queue

-git-acpi.patch
-git-acpi-fixup.patch
-git-acpi-more-build-fixes.patch
-git-acpi-build-fix-99.patch
-git-acpi-mmconfig-warning-fix.patch
-git-acpi-cpufreq-fix.patch
-git-acpi-cpufreq-fix-2.patch
-git-acpi-printk-warning-fix.patch
-acpi-clear-gpe-before-disabling-it.patch

 Dropped.

-git-cpufreq-prep.patch

 Temporarily dropped due to ACPI tree droppage.

-gregkh-driver-w1-ioremap-balanced-with-iounmap.patch
-gregkh-driver-driver-core-add-notification-of-bus-events.patch
-gregkh-driver-driver-link-sysfs-timing.patch
-gregkh-driver-cleanup-virtual_device_parent.patch
-gregkh-driver-config_sysfs_deprecated.patch
-gregkh-driver-udev-compatible-hack.patch
-gregkh-driver-config_sysfs_deprecated-bus.patch
-gregkh-driver-config_sysfs_deprecated-device.patch
-gregkh-driver-config_sysfs_deprecated-PHYSDEV.patch
-gregkh-driver-config_sysfs_deprecated-class.patch
-gregkh-driver-vt-device.patch
-gregkh-driver-vc-device.patch
-gregkh-driver-misc-devices.patch
-gregkh-driver-tty-device.patch
-gregkh-driver-raw-device.patch
-gregkh-driver-i2c-dev-device.patch
-gregkh-driver-msr-device.patch
-gregkh-driver-cpuid-device.patch
-gregkh-driver-ppp-device.patch
-gregkh-driver-ppdev-device.patch
-gregkh-driver-mmc-device.patch
-gregkh-driver-firmware-device.patch
-gregkh-driver-fb-device.patch
-gregkh-driver-mem-devices.patch
-gregkh-driver-sound-device.patch
-gregkh-driver-network-device.patch
-gregkh-driver-put_device-might_sleep.patch
-gregkh-driver-sysfs-crash-debugging.patch
-gregkh-driver-kobject-warn.patch
-gregkh-driver-warn-when-statically-allocated-kobjects-are-used.patch
-gregkh-driver-uio.patch
-gregkh-driver-nozomi.patch

 Dropped.

-revert-gregkh-driver-tty-device.patch
-driver-core-fixes-make_class_name-retval-checks.patch
-driver-core-fixes-sysfs_create_link-retval-checks-in.patch
-driver-core-fixes-device_register-retval-check-in.patch
-driver-core-dont-stop-probing-on-probe-errors.patch
-driver-core-change-function-call-order-in.patch
-driver-core-per-subsystem-multithreaded-probing.patch
-driver-core-dont-fail-attaching-the-device-if-it.patch
-nozomi-warning-fixes.patch
-nozomi-irq-flags-fixes.patch
-call-platform_notify_remove-later.patch

 Temporarily dropped due to driver tree droppage.

+ohci1394-shortcut-irq-printing.patch

 firewire cleanup

+add-tsi108-9-on-chip-ethernet-device-driver-support.patch
+net-s2io-return-on-null-dev_alloc_skb.patch
+drivers-cris-return-on-null-dev_alloc_skb.patch
+forcedeth-add-mgmt-unit-support.patch
+forcedeth-add-recoverable-error-support.patch
+forcedeth-add-new-nvidia-pci-ids.patch
+forcedeth-add-support-for-new-mcp67-device.patch

 netdev updates

+lockdep-annotate-sk_lock-nesting-in-af_bluetooth-v2.patch
+bnep-endianness-bug-filtering-by-packet-type.patch
+bnep-endianness-annotations.patch
+rfcomm-endianness-annotations.patch
+rfcomm-endianness-bug-param_mask-is-little-endian-on-the-wire.patch

 net updates

+add-weida-microdrive-into-ide-csc.patch

 pcmcia device IDS

+acpiphp-fix-use-of-list_for_each-macro.patch

 acpi pci hotplug driver fix

+scsi-iscsi-build-failure.patch

 build fix.

+usb-print_schedule_frame-defined-but-not-used-warning-fix.patch

 usb cleanup

+add-noaliencache-boot-option-to-disable-numa-alien-caches.patch

 mm tweak.

+security-keys-user-kmemdup.patch

 cleanup

+taskstats_exit_alloc-optimize-simplify.patch
+cpuset-allow-a-larger-buffer-for-writes-to-cpuset-files.patch
+compile-time-check-re-world-writeable-module-params.patch
+lockdep-spin_lock_irqsave_nested.patch
+lockdep-spin_lock_irqsave_nested-fix.patch
+lockdep-spin_lock_irqsave_nested-fix-2.patch
+lockdep-annotate-bcsp-driver.patch
+vfs-bkl-is-not-required-for-remount_fs.patch
+cleanup-read_pages.patch
+cifs-readpages-fixes.patch
+fuse-readpages-cleanup.patch
+gfs2-readpages-fixes.patch

 Misc.

-tty-switch-to-ktermios-nozomi-fix.patch

 Temporarily dropped due to driver tree droppage.

+tty-switch-to-ktermios-uml-fix.patch

 Fix termio patches in -mm.

+char-isicom-fix-tty-index-check.patch

 isicom fix

+char-sx-lock-boards-struct.patch
+char-sx-remove-duplicite-code.patch
+char-sx-whitespace-cleanup.patch
+char-sx-simplify-timer-logic.patch
+char-sx-fix-return-in-module-init.patch
+char-sx-use-pci_iomap.patch
+char-sx-request-regions.patch

 More tty driver work.

+isdn-avoid-a-potential-null-ptr-deref-in-ippp.patch

 ISDN fix

+schedc-correct-comment-for-this_rq_lock-routine.patch

 Fix a comment

+drivers-video-use-kmemdup.patch

 Cleanup


All 1026 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc4/2.6.19-rc4-mm1/patch-list


