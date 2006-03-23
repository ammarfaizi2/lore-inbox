Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWCWJoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWCWJoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWCWJoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:44:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751260AbWCWJoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:44:11 -0500
Date: Thu, 23 Mar 2006 01:40:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-mm1
Message-Id: <20060323014046.2ca1d9df.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/


- Added git-intelfb.patch: more fbdev drivers for Intel graphics hardware. 
  (David Airlie).

- Be aware that someone-who-doesn't-know-about-allmodconfig has screwed up
  AGP on x86_64: if your link fails with various missing AGP symbols you'll
  need to set the various CONFIG_AGP* symbols to `y' rather than `m'.  Then
  work out which other Kconfig rule keeps on flipping them back to `m' again,
  then fix that too.

  Once you've done all that, please let us know how you did it.

- John's x86 time rework patches are back again.



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




Changes since 2.6.16-rc6-mm2:


 origin.patch
 git-acpi.patch
 git-acpi-up-fix.patch
 git-agpgart.patch
 git-arm.patch
 git-audit-master.patch
 git-blktrace.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-serial.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-target.patch
 git-sas-jg.patch
 git-watchdog.patch
 git-xfs.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-uml.patch
 git-viro-bird-frv.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees.

-remove-sleep_avg-multiplier.patch
-dont-check_acpi_pci-on-x86-with-acpi-disabled.patch
-efi_call_phys_epilog-warning-fix.patch
-i810fb_cursor-use-gfp_atomic.patch
-v9fs-assign-dentry-ops-to-negative-dentries.patch
-mark-cyc2ns_scale-readmostly.patch
-multiple-exports-of-strpbrk.patch
-sound-core-fix-3-off-by-one-errors.patch
-sound-pci-rme9652-hdspmc-fix-off-by-one-errors.patch
-sound-pci-ice1712-deltac-make-2-functions-static.patch
-gregkh-driver-sysfs_remove_dir-needs-to-invalidate-the-dentry.patch
-gregkh-driver-kobject-fix-build-error-if-config_sysfs-n.patch
-gregkh-driver-empty_release_functions_are_broken.patch
-gregkh-driver-driver-core-platform_get_irq-return-enxio-on-error.patch
-gregkh-driver-handle-errors-returned-by-platform_get_irq.patch
-gregkh-driver-kref-avoid-an-atomic-operation-in-kref_put.patch
-gregkh-driver-kobj_map-semaphore-to-mutex-conversion.patch
-gregkh-driver-clean-up-module.c-symbol-searching-logic.patch
-gregkh-driver-export_symbol_gpl_future.patch
-gregkh-driver-export_symbol_gpl_future-rcu.patch
-gregkh-driver-export_symbol_gpl_future-usb.patch
-gregkh-driver-module_sysfs_refcount.patch
-gregkh-driver-sysfs-kzalloc-conversion.patch
-gregkh-driver-firmware-fix-bug-in-fw_realloc_buffer.patch
-gregkh-driver-driver-core-add-macros-notice-dev_notice.patch
-gregkh-driver-kobject-add-error-notify.patch
-gregkh-driver-kobject-kobject.h-fix-a-typo.patch
-gregkh-driver-sysfs-fix-problem-with-duplicate-sysfs-directories-and-files.patch
-gregkh-driver-debugfs-add-debugfs_create_blob-helper-for-exporting-binary-data.patch
-gregkh-driver-kobject_add_dir.patch
-gregkh-driver-get_cpu_sysdev-signedness-fix.patch
-gregkh-driver-unexport-sysfs-dir.patch
-gregkh-driver-sysfs_add_link-kobject-leak-fix.patch
-vr41xx-convert-to-the-new-platform-device-interface.patch
-mv64x600_wdt-convert-to-the-new-platform-device-interface.patch
-tb0219-convert-to-the-new-platform-device-interface.patch
-dcdbas-convert-to-the-new-platform-device-interface.patch
-git-dvb-build-fixes.patch
-ipw2200_txbusy.patch
-drivers-net-ns83820c-add-paramter-to-disable-auto.patch
-via-rhine-link-loss-autoneg-off-==-trouble.patch
-ipw2200-warning-fix.patch
-sky2-use-mutex.patch
-drivers-net-wireless-ipw2200c-make-ipw_qos_current_mode-static.patch
-drivers-net-wireless-ipw2200c-fix-an-array-overun.patch
-natsemi-add-support-for-using-mii-port-with-no-phy-fix.patch
-skfp-warning-fixes.patch
-git-netdev-all-tg3-warning-fix.patch
-net-allow-32-bit-socket-ioctl-in-64-bit-kernel.patch
-net-socket-timestamp-32-bit-handler-for-64-bit-kernel.patch
-x25-ioctl-conversion-32-bit-user-to-64-bit-kernel.patch
-x25-fix-kernel-error-message-64-bit-kernel.patch
-x25-allow-itu-t-dte-facilities-for-x25.patch
-x25-dte-facilities-32-64-ioctl-conversion.patch
-scm-fold-__scm_send-into-scm_send.patch
-scm_send-speedup.patch
-fix-irda-usb-use-after-use.patch
-net-bluetooth-return-negative-error-constant.patch
-sunrpc-fix-a-busy-inodes-error-in-rpc_pipefs.patch
-serial-serial_txx9-driver-update.patch
-serial-kernel-console-should-send-crlf-not-lfcr.patch
-sparc64-config_blk_dev_ram-fix.patch
-gregkh-usb-usb-add-zc0301-video4linux2-driver.patch
-gregkh-usb-usb-optimise-devio.c-usbdev_read.patch
-gregkh-usb-usb-optimise-devio.c-usbdev_read-fix.patch
-gregkh-usb-usb-mdc800.c-to-kzalloc.patch
-gregkh-usb-usb-kzalloc-for-storage.patch
-gregkh-usb-usb-kzalloc-for-hid.patch
-gregkh-usb-usb-kzalloc-in-dabusb.patch
-gregkh-usb-usb-kzalloc-in-w9968cf.patch
-gregkh-usb-usb-kzalloc-in-usbvideo.patch
-gregkh-usb-usb-kzalloc-in-cytherm.patch
-gregkh-usb-usb-kzalloc-in-idmouse.patch
-gregkh-usb-usb-kzalloc-in-ldusb.patch
-gregkh-usb-usb-kzalloc-in-phidgetinterfacekit.patch
-gregkh-usb-usb-kzalloc-in-phidgetservo.patch
-gregkh-usb-usb-kzalloc-in-usbled.patch
-gregkh-usb-usb-kzalloc-in-sisusbvga.patch
-gregkh-usb-ub-use-kzalloc.patch
-gregkh-usb-usb-remove-obsolete_oss_usb_driver-drivers.patch
-gregkh-usb-usb-drivers-usb-core-message.c-make-usb_get_string-static.patch
-gregkh-usb-usb-remove-linux_version_code-macro-usage.patch
-gregkh-usb-usb-convert-a-bunch-of-usb-semaphores-to-mutexes.patch
-gregkh-usb-usb-ehci-and-nf2-quirk.patch
-gregkh-usb-usb-ehci-full-speed-iso-bugfixes.patch
-gregkh-usb-usb-ehci-for-freescale-83xx.patch
-gregkh-usb-usb-ehci-and-freescale-83xx-quirk.patch
-gregkh-usb-usb-ehci-for-au1200.patch
-gregkh-usb-usb-ohci-for-au1200.patch
-gregkh-usb-usb-ehci-unlink-tweaks.patch
-gregkh-usb-usb-add-support-for-ochi-on-at91rm9200.patch
-gregkh-usb-usb-add-support-for-at91-gadget.patch
-gregkh-usb-usb-minor-gadget-rndis-tweak.patch
-gregkh-usb-recognize-three-more-usb-peripheral-controllers.patch
-gregkh-usb-usb-usbcore-sets-up-root-hubs-earlier.patch
-gregkh-usb-usb-ohci-uses-driver-model-wakeup-flags.patch
-gregkh-usb-usb-remove-usbcore-specific-wakeup-flags.patch
-gregkh-usb-usbhid-add-error-handling.patch
-gregkh-usb-usb-pegasus-linksys-usbvpn1-support-cleanup.patch
-gregkh-usb-usb-zero-driver-removed-duplicated-code.patch
-gregkh-usb-usb-fix-masking-bug-initialization-of-freescale-ehci-controller.patch
-gregkh-usb-uhci-use-one-qh-per-endpoint-not-per-urb.patch
-gregkh-usb-uhci-use-dummy-tds.patch
-gregkh-usb-uhci-remove-main-list-of-urbs.patch
-gregkh-usb-uhci-improve-debugging-code.patch
-gregkh-usb-uhci-don-t-log-short-transfers.patch
-gregkh-usb-uhci-hcd-fix-mistaken-usage-of-list_prepare_entry.patch
-gregkh-usb-usb-core-and-hcds-don-t-put_device-while-atomic.patch
-gregkh-usb-usbcore-fix-compile-error-with-config_usb_suspend-n.patch
-gregkh-usb-usb-gadget-driver-section-fixups.patch
-gregkh-usb-usb-ethernet-gadget-driver-section-fixups.patch
-gregkh-usb-usb-fix-warning-in-drivers-usb-media-ov511.c.patch
-gregkh-usb-usb-zc0301-driver-updates.patch
-gregkh-usb-usb-credits-add-credits-about-the-zc0301-and-et61x51-usb-drivers.patch
-gregkh-usb-usb-kzalloc-conversion-for-rest-of-drivers-usb.patch
-gregkh-usb-usb-kzalloc-conversion-in-drivers-usb-gadget.patch
-gregkh-usb-usb-sn9c10x-driver-updates.patch
-gregkh-usb-usb-et61x51-driver-updates.patch
-gregkh-usb-usb-zc0301-driver-updates-2.patch
-gregkh-usb-cypress_m8-add-support-for-the-nokia-ca42-version-2-cable.patch
-gregkh-usb-usb-pl2303-and-tiocmiwait.patch
-gregkh-usb-usb-support-for-usb-to-serial-cable-from-speed-dragon-multimedia.patch
-gregkh-usb-usb-uhci-increase-port-reset-completion-delay-for-hp-controllers.patch
-gregkh-usb-usb-ub-01-remove-first_open.patch
-gregkh-usb-usb-ub-02-remove-diag.patch
-gregkh-usb-usb-ub-03-drop-stall-clearing.patch
-gregkh-usb-usb-usbcore-don-t-assume-a-usb-configuration-includes-any-interfaces.patch
-gregkh-usb-usb-usbcore-usb_set_configuration-oops.patch
-gregkh-usb-usb-initdata-fixes.patch
-gregkh-usb-usb-storage-sandisk-unusual_devices-entry.patch
-gregkh-usb-usb-storage-another-unusual_devs.h-entry.patch
-gregkh-usb-usb-storage-new-unusual_devs.h-entry-mitsumi-7in1-card-reader.patch
-gregkh-usb-usb-add-support-for-creativelabs-silvercrest-usb-keyboard.patch
-gregkh-usb-usb-zc0301-driver-bugfix.patch
-gregkh-usb-usb-vicam.c-fix-a-null-pointer-dereference.patch
-gregkh-usb-usb-fix-check_ctrlrecip-to-allow-control-transfers-in-state-address.patch
-gregkh-usb-usb-cp2101-add-new-device-ids.patch
-gregkh-usb-usb-ftdi_sio-add-icom-id1-usb-product-and-vendor-ids.patch
-gregkh-usb-usb-rtl8150-small-fix.patch
-gregkh-usb-navman-usb-serial.patch
-gregkh-usb-omninet_debug.patch
-xfs_file_compat_invis_ioctl-fix.patch
-mm-remove-set_pgdir-leftovers.patch
-mm-never-clearpagelru-released-pages.patch
-mm-pagelru-no-testset.patch
-mm-pageactive-no-testset.patch
-mm-less-atomic-ops.patch
-mm-page_alloc-less-atomics.patch
-mm-slab-less-atomics.patch
-mm-simplify-vmscan-vs-release-refcounting.patch
-mm-de-skew-page-refcounting.patch
-xtensa-pgtable-fixes.patch
-mm-split-highorder-pages.patch
-mm-page_state-comment-more.patch
-mm-cleanup-bootmem.patch
-hugepage-allocator-cleanup.patch
-kcalloc-int_max-ulong_max.patch
-slab-object-to-index-mapping-cleanup.patch
-slab-extract-setup_cpu_cache.patch
-slab-cleanup.patch
-slab-remove-cachep-spinlock.patch
-mm-kill-kmem_cache_t-usage.patch
-slab-fix-kernel-doc-warnings.patch
-slab-remove-slab_no_reap-option.patch
-slab-remove-slab_no_reap-option-fix.patch
-on_each_cpu-disable-local-interupts.patch
-slab-use-on_each_cpu.patch
-thin-out-scan_control-remove-nr_to_scan-and-priority.patch
-vmscan-scan_control-cleanup.patch
-vmscan-scan_control-cleanup-speedup.patch
-vmscan-use-unsigned-longs.patch
-vmscan-use-unsigned-longs-shrink_all_memory-fix.patch
-vmscan-return-nr_reclaimed.patch
-vmscan-rename-functions.patch
-zone_reclaim-additional-comments-and-cleanup.patch
-mm-isolate_lru_pages-scan-count-fix.patch
-mm-shrink_inactive_lis-nr_scan-accounting-fix.patch
-remove-vm_dontcopy-bogosities.patch
-sg-use-compound-pages.patch
-i386-pageattr-remove-__put_page.patch
-i386-pageattr-remove-__put_page-fix.patch
-x86_64-pageattr-use-single-list.patch
-x86_64-pageattr-remove-__put_page.patch
-x86_64-pageattr-remove-__put_page-fix.patch
-mm-make-__put_page-internal.patch
-mm-nommu-use-compound-pages.patch
-remove-set_page_countpage-0-users-outside-mm.patch
-remove-set_page_count-outside-mm.patch
-mm-cleanup-prep_-stuff.patch
-mm-prep_zero_page-in-irq-is-a-bug.patch
-mm-more-config_debug_vm.patch
-mm-opt-page_count.patch
-uninline-sys_mmap-common-code-reduce-binary-size.patch
-vmscan-remove-obsolete-checks-from-shrink_list-and-fix-unlikely-in-refill_inactive-zone.patch
-shmem-inline-to-avoid-warning.patch
-readahead-prev_page-can-overrun-the-ahead-window.patch
-readahead-fix-initial-window-size-calculation.patch
-enable-mprotect-on-huge-pages.patch
-enable-mprotect-on-huge-pages-fix.patch
-fix-i386-x86-64-_page_pse-bit-when-changing-page-protection.patch
-hugepage-small-fixes-to-hugepage-clear-copy-path.patch
-hugepage-small-fixes-to-hugepage-clear-copy-path-tidy.patch
-hugepage-serialize-hugepage-allocation-and-instantiation.patch
-hugepage-serialize-hugepage-allocation-and-instantiation-tidy.patch
-hugepage-strict-page-reservation-for-hugepage-inodes.patch
-hugepage-strict-page-reservation-for-hugepage-inodes-fix.patch
-hugepage-make-allocfree_huge_page-local.patch
-hugepage-fix-hugepage-logic-in-free_pgtables.patch
-hugepage-fix-hugepage-logic-in-free_pgtables-harder.patch
-hugepage-move-hugetlb_free_pgd_range-prototype-to-hugetlbh.patch
-hugepage-is_aligned_hugepage_range-cleanup.patch
-convert-hugetlbfs_counter-to-atomic.patch
-optimize-follow_hugetlb_page.patch
-mm-make-shrink_all_memory-try-harder.patch
-slab-cache_reap-further-reduction-in-interrupt-holdoff.patch
-slab-cache_reap-further-reduction-in-interrupt-holdoff-fix.patch
-slab-make-drain_array-more-universal-by-adding-more-parameters.patch
-slab-remove-drain_array_locked.patch
-slab-fix-drain_array-so-that-it-works-correctly-with-the-shared_array.patch
-drain_node_pages-interrupt-latency-reduction--optimization.patch
-drain_node_pages-interrupt-latency-reduction-optimization-update.patch
-fix-swap-cluster-offset.patch
-page-migration-reorg.patch
-page-migration-reorg-fixes.patch
-page-migration-reorg-cleanup.patch
-page-migration-reorg-cleanup-fix.patch
-selinux-disable-automatic-labeling-of-new-inodes-when.patch
-sem2mutex-security.patch
-selinux-simplify-sel_read_bool.patch
-selinuxfs-cleanups-fix-hard-link-count.patch
-selinuxfs-cleanups-use-sel_make_dir.patch
-selinuxfs-cleanups-sel_fill_super-exit-path.patch
-selinuxfs-cleanups-sel_make_bools.patch
-selinuxfs-cleanups-sel_make_avc_files.patch
-selinux-fix-hard-link-count-for-selinuxfs-root-directory.patch
-selinux-cleanup-stray-variable-in-selinux_inode_init_security.patch

 Merged

+proc-fix-duplicate-line-in-proc-devices.patch
+sys_alarm-unsigned-signed-conversion-fixup.patch
+sys_alarm-unsigned-signed-conversion-fixup-fix.patch
+validate-and-sanitze-itimer-timeval-from-userspace.patch
+validate-and-sanitze-itimer-timeval-from-userspace-fix.patch
+fix-scheduler-deadlock.patch
+fix-bug-bio_rw_barrier-requests-to-md-raid1-hang.patch
+fix-use-after-free-in-cciss_init_one.patch

 2.6.16.1 queue.

+fix-sequencer-missing-negative-bound-check.patch
+pnp-adjust-pnp_register_card_driver-signature-ad1816a.patch
+pnp-adjust-pnp_register_card_driver-signature-als100.patch
+pnp-adjust-pnp_register_card_driver-signature-azt2320.patch
+pnp-adjust-pnp_register_card_driver-signature-cmi8330.patch
+pnp-adjust-pnp_register_card_driver-signature-dt019x.patch
+pnp-adjust-pnp_register_card_driver-signature-es18xx.patch
+pnp-adjust-pnp_register_card_driver-signature-es968.patch
+pnp-adjust-pnp_register_card_driver-signature-interwave.patch
+pnp-adjust-pnp_register_card_driver-signature-sb16.patch
+pnp-adjust-pnp_register_card_driver-signature-sb_card.patch
+pnp-adjust-pnp_register_card_driver-signature-sscape.patch
+pnp-adjust-pnp_register_card_driver-signature-wavefront.patch

 pnp API cleanups

+powernow-remove-private-for_each_cpu_mask.patch
+cpufreq_conservative-aligning-of-codebase-with-ondemand.patch
+cpufreq_conservative-alter-default-responsiveness.patch
+cpufreq_conservative-make-for_each_cpu-safe.patch
+cpufreq_conservative-alternative-initialise-approach.patch

 cpufreq updates

+saa7111c-fix.patch

 dvb fix

+ia64-sn_check_intr-use-ia64_get_irr.patch

 ia64 fix

-pc-speaker-add-snd_silent.patch

 Dropped.

-git-libata-all-build-hacks.patch

 Unneeded

-revert-ipw2200-Fix-WPA-network-selection-problem.patch

 Unneeded

 Folded into natsemi-add-support-for-using-mii-port-with-no-phy.patch

-amd-au1xx0-fix-ethernet-tx-stats-tidy.patch

 Folded into amd-au1xx0-fix-ethernet-tx-stats.patch

-drivers-net-ns83820c-add-paramter-to-disable-auto-tidy-2.patch
-drivers-net-ns83820c-add-paramter-to-disable-auto-tidy-fix.patch

 Folded into drivers-net-ns83820c-add-paramter-to-disable-auto.patch

+com90xx-kmalloc-fix.patch

 Fix new bug in com90xx WAN driver

+remove-needless-check-in-nfs_opendir.patch

 NFS cleanup

+git-powerpc-hot_add_scn_to_nid-build-fix.patch
+powerpc-add_memory-warning-fix.patch

 powerpc fixes

+serial-mystery-kbuild-fix.patch

 Serial fix

+mm-drivers-pci-msi-explicit-declaration-of-msi_register-fix.patch

 Fix mm-drivers-pci-msi-explicit-declaration-of-msi_register.patch

+git-scsi-misc-min-warning-fix.patch

 Fix warning in scsi tree

+drivers-scsi-aic7xxx-aic79xx_corec-make-ahd_match_scb-static.patch

 scsi driver cleanup

+sparc64-fix-set_page_count-merge-clash.patch

 sparc64 fix

+cirrus-ep93xx-watchdog-driver.patch
+cirrus-ep93xx-watchdog-driver-tidy.patch

 New watchdog driver

+ipw2200-config_ipw_qos-to-config_ipw2200_qos.patch

 ipw2200 cleanup

-x86_64-mm-empty-pxm.patch
-x86_64-mm-lost-ticks-dump-rip.patch
-x86_64-mm-amd-3core.patch
+x86_64-mm-amd-core-parsing.patch
+x86_64-mm-powernow-query.patch
+x86_64-mm-iret-error-code.patch
+x86_64-mm-lost-cli-debug.patch
+x86_64-mm-hotadd-reserve.patch
+x86_64-mm-srat-hotadd-reserve.patch
+x86_64-mm-empty-pxm.patch
+x86_64-mm-via-agp.patch
+x86_64-mm-sis-agp.patch

 x86_64 tree updates

-x86_64-mm-timer-broadcast-amd-fix-2.patch
+x86_64-mm-timer-broadcast-amd-fix-fix.patch
+x86-64-calgary-iommu-introduce-iommu_detected.patch
+x86-64-calgary-iommu-calgary-specific-bits.patch
+x86-64-calgary-iommu-hook-it-in.patch
+x86_64-mm-hotadd-reserve-vs-arm.patch

 more x86_64 things

+slab-introduce-kmem_cache_zalloc-allocator.patch
+slab-optimize-constant-size-kzalloc-calls.patch
+mm-use-kmem_cache_zalloc.patch
+slab-add-transfer_objects-function.patch
+slab-add-transfer_objects-function-fix.patch
+slab-bypass-free-lists-for-__drain_alien_cache.patch
+alloc_kmemlist-some-cleanup-in-preparation-for-a-real-memory-leak-fix.patch
+slab-fix-memory-leak-in-alloc_kmemlist.patch
+slab-fix-memory-leak-in-alloc_kmemlist-fix.patch
+add-api-for-flushing-anon-pages.patch
+add-flush_kernel_dcache_page-api.patch
+mm-make-page-migration-dependent-on-swap-and-numa.patch

 MM updates

+bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm-update.patch
+bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm-update-tidy.patch

 update this patch.

+x86-make-config_hotplug_cpu-depend-on-x86_pc.patch
+x86-cpu_init-avoid-gfp_kernel-allocation-while-atomic.patch
+pm-timer-dont-use-workaround-if-chipset-is-not-buggy.patch
+pm-timer-dont-use-workaround-if-chipset-is-not-buggy-tidy.patch

 x86 fixes

+swsusp-add-check-for-suspension-of-x-controlled-devices.patch
+swsusp-let-userland-tools-switch-console-on-suspend.patch
+swsusp-add-s2ram-ioctl-to-userland-interface.patch

 swsusp updates

+s390-wrong-interrupt-delivered-for-hsch-or-csch.patch
+s390-cio-documentation-update.patch
+s390-channel-path-measurements.patch
+s390-early-parameter-parsing.patch
+s390-proc-sys-vm-cmm_-permission-bits.patch
+s390-bug-warnings.patch
+s390-cpu-up-retries.patch
+s390-connector-support.patch
+s390-use-normal-switch-statement-for-ioctls-in-dasd_ioctlc.patch
+s390-use-normal-switch-statement-for-ioctls-in-dasd_ioctlc-2.patch
+s390-merge-cmb-into-dasdc.patch
+s390-remove-dynamic-dasd-ioctls.patch
+s390-remove-old-history-whitespave-from-partition-code.patch
+s390-remove-experimental-flag-from-dasd-diag.patch
+s390-random-values-in-result-of-biodasdinfo2.patch
+s390-dasd-extended-error-reporting.patch
+s390-tape-retry-flooding-by-deferred-cc-in-interrupt.patch
+s390-tape-operation-abortion-leads-to-panic.patch
+s390-fix-endless-retry-loop-in-tape-driver.patch
+s390-3590-tape-driver.patch
+s390-remove-support-for-ttys-over-ctc-connections.patch
+s390-cex2a-crt-message-length.patch
+s390-kzalloc-conversion-in-arch-s390.patch
+s390-kzalloc-conversion-in-drivers-s390.patch
-dasd-cleanup-dasd_ioctl.patch
-dasd-add-per-disciple-ioctl-method.patch
-dasd-merge-dasd_cmd-into-dasd_mod.patch
-dasd-kill-dynamic-ioctl-registration.patch

 s390 updates

-reiser4-export-page_cache_readahead.patch

 Renamed.

+cpuset-remove-unnecessary-null-check.patch
+cpuset-remove-unnecessary-null-check-comment-fix.patch
+cpuset-dont-need-to-mark-cpuset_mems_generation-atomic.patch
+cpuset-memory_spread_slab-drop-useless-pf_spread_page-check.patch
+cpuset-remove-useless-local-variable-initialization.patch
+add-gfp-flag-__gfp_policy-to-control-policies-and-cpusets-redirection.patch

 cupset things

+yet-more-rio-cleaning-1-of-2.patch
+yet-more-rio-cleaning-2-of-2.patch

 rio cleanups

+v9fs-update-license-boilerplate.patch
+9p-fix-name-consistency-problems.patch
+9p-update-documentation.patch

 More v8fs updates

+make-address_space_operations-invalidatepage-return-void-fix.patch

 Fix make-address_space_operations-invalidatepage-return-void.patch

+altix-rs422-support-for-ioc4-serial-driver-fixes.patch

 Fix altix-rs422-support-for-ioc4-serial-driver.patch

+cpumask-uninline-first_cpu.patch
+cpumask-uninline-next_cpu.patch
+cpumask-uninline-highest_possible_processor_id.patch
+cpumask-uninline-any_online_cpu.patch

 Code size reductions.

+oss-fix-leak-in-awe_wave-also-remove-pointless-cast.patch
+fix-memory-leak-in-isapnp.patch
+use-kzalloc-and-kcalloc-in-core-fs-code.patch
+udf-fix-uid-gid-options-and-add-uid-gid=ignore-and-forget.patch
+direct-io-bug-fix-in-dio-handling-write-error.patch
+doc-more-serial-console-info.patch
+check-if-cpu-can-be-onlined-before-calling-smp_prepare_cpu.patch
+check-if-cpu-can-be-onlined-before-calling-smp_prepare_cpu-fix.patch
+cleanup-smp_call_function-up-build.patch
+use-unsigned-int-types-for-a-faster-bsearch.patch
+eisa-ignore-generated-file-drivers-eisa-devlisth.patch
+insert-identical-resources-above-existing-resources.patch
+make-sure-nobodys-leaking-resources.patch
+udf-remove-duplicate-definitions.patch
+ipmi-add-generic-pci-handling.patch
+ipmi-add-generic-pci-handling-tidy.patch
+ipmi-add-full-sysfs-support.patch
+ipmi-add-full-sysfs-support-fixes.patch
+ipmi-add-full-sysfs-support-tidy.patch
+ipmi-add-full-sysfs-support-tidy-2.patch
+hpet-header-sanitization.patch
+doc-fix-example-firmware-source-code.patch
+use-__read_mostly-on-some-hot-fs-variables.patch
+remove-needless-check-in-binfmt_elfc.patch
+remove-needless-check-in-fs-read_writec.patch
+add-sa_percpu_irq-flag-support.patch
+kernel-timec-remove-unused-pps_-variables.patch
+vfsfs-locksc-cleanup-locks_insert_block.patch
+vfsfs-lockscnfsd4-add-race_free-posix_lock_file_conf.patch
+vfsfs-lockscnfsd4-add-race_free-posix_lock_file_conf-tidy.patch
+nfsd4-return-conflict-lock-without-races.patch
+flat-binary-loader-doesnt-check-fd-table-full.patch

 Random stuff.

+time-clocksource-infrastructure.patch
+time-use-clocksource-infrastructure-for-update_wall_time.patch
+time-let-user-request-precision-from-current_tick_length.patch
+time-use-clocksource-abstraction-for-ntp-adjustments.patch
+time-introduce-arch-generic-time-accessors.patch
+hangcheck-remove-monotomic_clock-on-x86.patch
+time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
+time-i386-conversion-part-2-rework-tsc-support.patch
+time-i386-conversion-part-3-enable-generic-timekeeping.patch
+time-i386-conversion-part-4-remove-old-timer_opts-code.patch
+time-i386-clocksource-drivers.patch

 x86 time management rework.

+kretprobe-kretprobe-booster-spinlock-recursive-remove.patch

 Fix kretprobe-kretprobe-booster.patch

+edac-use-sysbus_message-in-e752x-code-fix.patch

 Fix edac-use-sysbus_message-in-e752x-code.patch

+notifier-chain-initialization.patch

 Generalise notifier chain initialisers

-rtc-subsystem-library-functions-2.patch
-rtc-subsystem-arm-cleanup-2.patch
-rtc-subsystem-arm-integrator-cleanup-2.patch
-rtc-subsystem-class-2.patch
-rtc-subsystem-i2c-cleanup-2.patch
-rtc-subsystem-sysfs-interface-2.patch
-rtc-subsystem-proc-interface-2.patch
-rtc-subsystem-dev-interface-2.patch
-rtc-subsystem-x1205-driver-2.patch
-rtc-subsystem-test-device-driver-2.patch
-rtc-subsystem-ds1672-driver-2.patch
-rtc-subsystem-pcf8563-driver-2.patch
-rtc-subsystem-rs5c372-driver-2.patch
-rtc-subsystem-ep93xx-driver-2.patch
-rtc-subsystem-sa1100-pxa2xx-driver-2.patch
+rtc-subsystem-library-functions.patch
+rtc-subsystem-library-functions-fix.patch
+rtc-subsystem-arm-cleanup.patch
+rtc-subsystem-arm-integrator-cleanup.patch
+rtc-subsystem-class.patch
+rtc-subsystem-i2c-cleanup.patch
+rtc-subsystem-i2c-driver-ids.patch
+rtc-subsystem-sysfs-interface.patch
+rtc-subsystem-proc-interface.patch
+rtc-subsystem-dev-interface.patch
+rtc-subsystem-x1205-driver.patch
+rtc-subsystem-test-device-driver.patch
+rtc-subsystem-ds1672-driver.patch
+rtc-subsystem-pcf8563-driver.patch
+rtc-subsystem-rs5c372-driver.patch
+rtc-subsystem-ep93xx-driver.patch
+rtc-subsystem-sa1100-pxa2xx-driver.patch
+rtc-subsystem-m48t86-driver.patch

 Updated

+proc-remove-tasklist_lock-from-proc_pid_readdir-simply-fix-first_tgid.patch
+proc-remove-tasklist_lock-from-proc_pid_readdir-simply-fix-first_tgid-fix.patch

 Fix proc-remove-tasklist_lock-from-proc_pid_readdir.patch some more

+proc-dont-lock-task_structs-indefinitely-fix-stat-on-proc-pid.patch
+simplify-fix-first_tid.patch
+simplify-fix-first_tid-fix.patch
+cleanup-next_tid.patch

 More proc/task management updates.

+reiser4-export-handle_ra_miss.patch

 reiser4 export.

+reiser4-cleanup_init_fake_inode.patch

 reiser4 fix

+drivers-video-use-array_size-macro.patch

 fbdev cleanup.



All 1535 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/patch-list

