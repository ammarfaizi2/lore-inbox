Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWEVJ13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWEVJ13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 05:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWEVJ13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 05:27:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750736AbWEVJ12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 05:27:28 -0400
Date: Mon, 22 May 2006 02:27:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc4-mm3
Message-Id: <20060522022709.633a7a7f.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/

- A few patchsets were dropped.  They will come back.  People who had memory
  management initialisation problems will hopefully see improvements.

- swsusp resume on RH FC5 is still broken.  It appears to be a userspace
  bug.



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



Changes since 2.6.17-rc4-mm2:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit-master.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
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
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-cryptodev.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-frv.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees

-nfs-fix-error-handling-on-access_ok-in-compat_sys_nfsservctl.patch
-matroxfb-fix-dvi-setup-to-be-more-compatible.patch
-i386-remove-junk-from-stack-dump.patch
-powerpc-fix-ide-pmac-sysfs-entry.patch
-kdump-maintainer-info-update.patch
-nfs-server-subtree_check-returns-dubious-value.patch
-md-fix-inverted-test-for-repair-directive.patch
-nfsd-sign-conversion-obscuring-errors-in-nfsd_set_posix_acl.patch
-x86_64-dont-warn-for-overflow-in-nommu-case-when-dma_mask-is-32bit-fix.patch
-hid-read-busywait-fix.patch
-binfmt_flat-dont-check-for-emfile.patch
-selinux-endian-fix.patch
-x86_64-mm-hotadd-reserve-fix-fix-fix.patch
-sparsemem-incorrectly-calculates-section-number.patch
-fix-race-in-inotify_release.patch
-pci-correctly-allocate-return-buffers-for-osc-calls.patch
-cpuset-might-sleep-checking-zones-allowed-fix.patch
-cpuset-update-cpuset_zones_allowed-comment.patch
-cpuset-might_sleep_if-check-in-cpuset_zones_allowed.patch
-overrun-in-isdn_ttyc.patch
-clarify-maintainers-and-include-linux-security-info.patch
-update-ext2-ext3-jbd-maintainers-entries.patch
-minor-spi-doc-fix.patch
-spi-added-spi-master-driver-for.patch
-drivers-base-firmware_classc-cleanups.patch
-s3c24xx-gpio-based-spi-driver.patch
-s3c24xx-hardware-spi-driver.patch
-s3c24xx-hardware-spi-driver-tidy.patch
-pxa2xx-spi-update.patch
-i386-kdump-boot-cpu-physical-apicid-fix.patch
-kprobes-bad-manupilation-of-2-byte-opcode-on-x86_64.patch
-missing-newline-in-scsi-stc.patch
-fix-a-no_idle_hz-timer-bug.patch
-revert-forcedeth-fix-multi-irq-issues.patch
-s390-next_timer_interrupt-overflow-in-stop_hz_timer.patch
-kbuild-check-sht_rel-sections.patch
-kbuild-fix-modpost-segfault-for-64bit-mipsel-kernel.patch
-rtc-subsystem-use-enoioctlcmd-and-enotty-where-appropriate.patch
-via-rhine-revert-change-mdelay-to-msleep-and-remove-from-isr-path.patch
-fix-broken-vm86-interrupt-signal-handling.patch
-kobject-quiet-errors-in-kobject_add.patch
-align-the-node_mem_map-endpoints-to-a-max_order-boundary.patch
-pd6729-section-fix.patch
-i810-section-fix.patch
-mpu401-section-fix.patch
-es18xx-build-fix.patch
-nm256_audio-section-fix.patch
-ad1848-section-fix.patch
-gregkh-driver-platform_bus-learns-about-modalias-warning-fix.patch
-gregkh-driver-warn-when-statically-allocated-kobjects-are-used-fix.patch
-w1-warning-fix.patch
-git-mtd-symbol_get-fix.patch
-git-mtd-moddi-fix.patch
-ppa-no-highmem-pages.patch
-scsi-make-scsi_implement_eh-generic-api-for-scsi-transports.patch
-added-support-for-asix-88178-chipset-usb-gigabit-ethernet-adaptor.patch

 Merged into mainline or a subsystem tree

+sys_sync_file_range-move-exported-flags-outside-kernel.patch
+knfsd-fix-two-problems-that-can-cause-rmmod-nfsd-to-die.patch
+md-fix-possible-oops-when-starting-a-raid0-array.patch
+md-make-sure-bi_max_vecs-is-set-properly-in-bio_split.patch

 2.6.17 queue

+gregkh-driver-remove-duplication-from-documentation-power-devicestxt.patch
+gregkh-driver-driver-core-pm_debug-device-suspend-messages-become-informative.patch

 Driver tree updates

+gregkh-i2c-w1-warning-fix.patch

 i2c tree update

+input-powermac-cleanup-of-mac_hid-and-support-for-ctrlclick-and-commandclick.patch

 powermac input driver cleanup and feature work

+forcedeth-suggested-cleanups.patch
+forcedeth-add-support-for-flow-control.patch
+forcedeth-add-support-for-configuration.patch

 Bring back these forcedeth patches

+secmark-add-new-packet-controls-to-selinux-disable-new-controls-for-selinux-by-default.patch

 Make the secmark Kconfiguration more user-friendly.

+git-nfs-fixup.patch

 Fix reject in git-nfs.patch.

+git-scsi-target-warning-fix.patch

 Fix wanring in git-scsi-target.patch

+gregkh-usb-usb-added-support-for-asix-88178-chipset-usb-gigabit-ethernet-adaptor.patch
+gregkh-usb-usb-correct-the-usb-info-in-documentation-power-swsusptxt.patch
+gregkh-usb-usb-remove-4088-byte-limit-on-usbfs-control-urbs.patch
+gregkh-usb-usb-allow-high-bandwidth-isochronous-packets-via-usbfs.patch
+gregkh-usb-uhci-use-integer-sized-frame-numbers.patch
+gregkh-usb-uhci-fix-race-in-iso-dequeuing.patch
+gregkh-usb-uhci-store-the-period-in-the-queue-header.patch
+gregkh-usb-uhci-remove-iso-tds-as-they-are-used.patch
+gregkh-usb-fix-a-deadlock-in-usbtest.patch
+gregkh-usb-usb_interrupt_msg.patch

 USB tree updates

+revert-gregkh-usb-usb-ohci-avoids-root-hub-timer-polling.patch

 Revert a USB patch which caused swsusp resume hangs

+git-supertrak-fixup.patch

 Fix reject in git-supertrak.patch

+orinoco-possible-null-pointer-dereference-in-orinoco_rx_monitor.patch

 wireless driver fix

+x86_64-mm-i386-numa-summit-check-fix.patch
+x86_64-dont-warn-for-overflow-in-nommu-case-when-dma_mask-is-32bit-fix.patch

 x86_64 things

-introduce-mechanism-for-registering-active-regions-of-memory.patch
-have-power-use-add_active_range-and-free_area_init_nodes.patch
-have-x86-use-add_active_range-and-free_area_init_nodes.patch
-have-x86_64-use-add_active_range-and-free_area_init_nodes.patch
-have-ia64-use-add_active_range-and-free_area_init_nodes.patch

 Hopefully the source of recent memory-management initialisation problems.

+fix-broken-vm86-interrupt-signal-handling.patch

 x86 fix

+x86-move-vsyscall-page-out-of-fixmap-above-stack.patch
+x86-move-vsyscall-page-out-of-fixmap-above-stack-tidy.patch

 Move the x86 vsyscall page elsewhere (Xen preparation)

+rewritten-backlight-infrastructure-for-portable-apple-computers-fix.patch

 Fix rewritten-backlight-infrastructure-for-portable-apple-computers.patch

+pdflush-handle-resume-wakeups.patch

 Fix pdflush interaction with swsusp resume

+genirq-rename-desc-handler-to-desc-chip.patch
+genirq-rename-desc-handler-to-desc-chip-power-fix.patch
+genirq-rename-desc-handler-to-desc-chip-ia64-fix.patch

 Rename irq_desc.handler to irq_desc.chip (big stupid patch which is
 preparation for the genirq patches, which had merge problems).

+edd-isnt-experimental-anymore.patch

 EDD is ready for prime time.

+kernel-doc-drop-leading-space-in-sections.patch
+kernel-doc-script-cleanups.patch

 kernel-doc work.

+schedule_on_each_cpu-reduce-kmalloc-size.patch

 schedule_on_cpu() was kmallocing stupidly large amounts of memory.

-vectorize-aio_read-aio_write-methods.patch
-remove-readv-writev-methods-and-use-aio_read-aio_write.patch
-core-aio-changes-to-support-vectored-aio.patch
-core-aio-changes-to-support-vectored-aio-fix-2.patch
-streamline-generic_file_-interfaces-and-filemap.patch
-gfs2-vs-streamline-generic_file_-interfaces-and-filemap.patch

 These broke autofs4

-nfs-open-code-the-nfs-direct-write-rescheduler.patch
-nfs-open-code-the-nfs-direct-write-rescheduler-printk-fix.patch
-nfs-remove-user_addr-and-user_count-from-nfs_direct_req.patch
-nfs-eliminate-nfs_get_user_pages.patch
-nfs-alloc-nfs_read-write_data-as-direct-i-o-is-scheduled.patch
-nfs-check-all-iov-segments-for-correct-memory-access-rights.patch
-nfs-support-vector-i-o-throughout-the-nfs-direct-i-o-path.patch
-ecryptfs-vs-streamline-generic_file_-interfaces-and-filemap.patch
-ecryptfs-vs-streamline-generic_file_-interfaces-and-filemap-fix.patch

 These depended on the preceding patches.  Temporarily dropped.

+namespaces-add-nsproxy-dont-include-compileh.patch

 Fix namespaces-add-nsproxy.patch

+namespaces-utsname-implement-utsname-namespaces-dont-include-compileh.patch

 Fix namespaces-utsname-implement-utsname-namespaces.patch

+intelfb-use-firmware-edid-for-mode-database-fix.patch

 Fix intelfb-use-firmware-edid-for-mode-database.patch

+add-print_fatal_signals-support.patch

 Add `print-fatal-signals=1' boot option - causes the kernel to emit debug
 info when a task is killed in strange circumstances.



All 1085 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/patch-list


