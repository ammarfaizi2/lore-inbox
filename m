Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVFGLbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVFGLbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVFGLbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:31:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:55273 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261837AbVFGL3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:29:39 -0400
Date: Tue, 7 Jun 2005 04:29:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc6-mm1
Message-Id: <20050607042931.23f8f8e0.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc6/2.6.12-rc6-mm1/

- Added v9fs

- Various random fixes

- Probably a similar number of breakages



Changes since 2.6.12-rc5-mm2:


-fix-ide-scsi-eh-locking.patch
-ext3-fix-log_do_checkpoint-assertion-failure.patch
-ext3-fix-list-scanning-in-__cleanup_transaction.patch
-namei-fixes-01-19.patch
-namei-fixes-02-19.patch
-namei-fixes-03-19.patch
-namei-fixes-04-19.patch
-namei-fixes-05-19.patch
-namei-fixes-06-19.patch
-namei-fixes-07-19.patch
-namei-fixes-08-19.patch
-namei-fixes-09-19.patch
-namei-fixes-10-19.patch
-namei-fixes-11-19.patch
-namei-fixes-12-19.patch
-namei-fixes-13-19.patch
-namei-fixes-14-19.patch
-namei-fixes-15-19.patch
-namei-fixes-16-19.patch
-namei-fixes-17-19.patch
-namei-fixes-18-19.patch
-namei-fixes-19-19.patch
-ipmi-class_simple-fixes.patch
-gregkh-i2c-i2c-ali1563.patch
-git-ocfs-fix-for-shemminger-tcp-stuff.patch
-gregkh-pci-pci-hotplug-shpchp-_HPP-fix.patch
-gregkh-pci-pci-hotplug-shpchp-PERR-fix.patch
-gregkh-pci-pci-amd74xx-ids.patch
-gregkh-pci-pci-cpci-update.patch
-gregkh-usb-usb-sl811-hcd-fixes.patch
-gregkh-usb-usb-sl811_cs.patch
-gregkh-usb-usb-ftdi_sio-new-id.patch
-gregkh-usb-usb-serial-generic-init-fix.patch
-gregkh-usb-usb-ub_multi_lun.patch
-gregkh-usb-usb-remove_pwc_changelog.patch
-gregkh-usb-usb-add-new-wacom-device-to-usb-hid-core-list.patch
-gregkh-usb-usb-urb_documentation.patch
-gregkh-usb-usb-earthmate-hid-blacklist.patch
-gregkh-usb-usb-storage-trumpion.patch
-gregkh-usb-usb-modalias-shrink.patch
-gregkh-usb-usb-cp2101-flow-control.patch
-gregkh-usb-usb-usbatm-reduce-log-spam.patch
-gregkh-usb-usb-usbatm-avoid-oops-on-bind-failure.patch
-gregkh-usb-usb-usbatm-1-fix.patch
-usb-option-card-driver.patch
-usb-wacom-tablet-driver.patch
-atm-nicstar-remove-a-bunch-of-pointless-casts-of-null.patch
-fix-atm-build-with-o=.patch
-drivers-net-hamradio-baycom_eppc-cleanups.patch
-ppc32-apple-device-tree-bug-fix.patch
-ppc32-ppc64-cleanup-proc-device-tree.patch
-ppc64-cleanup-spr-definitions.patch
-ppc64-cleanup-iseries-runlight-support.patch
-ppc64-remove-decr_overclock.patch
-ppc64-fix-a-device-tree-bug-on-apples.patch
-i386-collect-host-bridge-resources.patch
-x86_64-collect-host-bridge-resources.patch
-allow-ev_abs-to-work-in-uinputc.patch
-serial-update-nec-vr4100-series-serial-support.patch

 Merged

+ppc32-add-linux-compilerh-to-asm-sigcontexth.patch
+include-linux-configh-before-testing-config_acpi.patch
+uml-make-the-emulated-iomem-driver-work-on-26.patch
+uml-compile-fixes-for-gcc-4.patch
+uml-fix-strace-f.patch
+uml-clean-up-error-path.patch
+uml-link-tt-mode-against-nptl.patch
+send_ipi_mask_sequence-warning-fix.patch
+ppc32-add-405ep-cpu_spec-entry.patch
+input-disable-scroll-feature-on-at-keyboards.patch

 Planned for 2.6.12

+x86_64-task_size-fixes-for-compatibility-mode-processes.patch

 x86_64 critical fixes (needs work)

+ia64-disable-preempt.patch

 Disable CONFIG_PREEMPT on ia64 (it has problem with floating-point
 save/restore)

+fix-up-macro-abuse-in-drivers-acpi-sleep-procc.patch

 ACPI cleanup

+git-arm.patch
+git-arm-smp.patch

 ARM git trees

-git-cpufreq.patch

 Empty

+fix-warning-in-powernow-k8c.patch

 Fix a cpufreq warning

+gregkh-driver-ipmi-class_simple-fixes.patch
+gregkh-driver-sysfs-permissions-01.patch
+gregkh-driver-sysfs-permissions-02.patch
+gregkh-driver-sysfs-permissions-03.patch
+gregkh-driver-dont-loose-devices-on-suspend-failure.patch

 New driver core patches

-bk-drm.patch
-bk-drm-via.patch

 DRM is moving to git

-update-drm-ioctl-compatibility-to-new-world-order.patch

 The code which this pathces isn't there any more (it will come back)

+git-drm-initmap.patch
+git-drm-via.patch

 Some DRM git trees

+gregkh-i2c-i2c-Kconfig-update.patch
+gregkh-i2c-i2c-pcf8574-cleanup.patch
+gregkh-i2c-i2c-adm9240-docs.patch
+gregkh-i2c-i2c-device-attr-lm90.patch
+gregkh-i2c-i2c-device-attr-lm83.patch
+gregkh-i2c-i2c-device-attr-lm63.patch
+gregkh-i2c-i2c-device-attr-it87.patch
+gregkh-i2c-hwmon-01.patch
+gregkh-i2c-hwmon-02.patch
+gregkh-i2c-hwmon-03.patch

 i2c tree updates

+i2c-chips-need-hwmon.patch
+gregkh-i2c-hwmon-02-sparc64-fix.patch

 Fix a few things in the i2c tree

+sonypi-make-sure-that-input_work-is-not-running-when-unloading.patch

 sonypi fix

-git-libata-adma.patch
-git-libata-ahci-msi.patch
-git-libata-bridge-detect.patch
-git-libata-chs-support.patch
-git-libata-docs.patch
-git-libata-svw.patch
-git-libata-promise-sata-pata.patch
-git-libata-pdc2027x.patch

 Dropped the libata tree - it changes all the time and I can't wqork out wtf
 is going on.

-git-netdev-r8169.patch

 Too many rejects from this one.

+fix-recursive-ipw2200-dependencies.patch
+drivers-net-chelsio-cxgb2-use-the-dma_3264bit_mask-constants.patch
+drivers-net-wireless-ipw2100-use-the-dma_32bit_mask-constant.patch
+drivers-net-wireless-ipw2200-use-the-dma_32bit_mask-constant.patch
+fix-tulip-suspend-resume.patch

 Net driver fixes

+scalable-tcp-cleaned.patch

 "scalable TCP"

+git-serial.patch

 Serial subsystem tree

+gregkh-pci-pci-fix-routing-in-parent-bridge.patch
+gregkh-pci-pci-dma-bursting-advice.patch
+gregkh-pci-pci-collect-host-bridge-resources-01.patch
+gregkh-pci-pci-collect-host-bridge-resources-02.patch

 PCI subsystem tree updates

+gregkh-pci-pci-dma-bursting-advice-fix.patch

 Fix it

-git-scsi-rc-fixes.patch

 This is empty

+gregkh-usb-usb-usbatm-reduce-log-spam.patch
+gregkh-usb-usb-usbatm-avoid-oops-on-bind-failure.patch
+gregkh-usb-usb-usbatm-fix-gcc-2.95.x.patch
+gregkh-usb-usb-usbatm-kcalloc.patch
+gregkh-usb-usb-uhci-detect-invalid-ports.patch
+gregkh-usb-usb-export-getput_intf.patch
+gregkh-usb-usb-cdc-acm-reference-count-fix.patch
+gregkh-usb-usb-ehci-fix-page-pointer-allocate.patch
+gregkh-usb-usb-wireless-definitions.patch
+gregkh-usb-usb-usblp-race-fix.patch
+gregkh-usb-usb-stv680-creative-mini.patch
+gregkh-usb-usb-atiremote-sysfs-links.patch
+gregkh-usb-usb-gotemp.patch

 USB tree updates

+sparsemem-memory-model-fix-4.patch
+sparsemem-memory-model-fix-5.patch

 Fix sparsemem-memory-model.patch even more

+sparsemem-hotplug-base-fix.patch

 Fix sparsemem-hotplug-base.patch

-vm-merge_lru_pages.patch
-vm-page-cache-reclaim-core.patch
-vm-page-cache-reclaim-core-tidy.patch
-vm-reclaim_page_cache_node-syscall.patch
-vm-reclaim_page_cache_node-syscall-x86.patch
-vm-automatic-reclaim-through-mempolicy.patch
+vm-add-may_swap-flag-to-scan_control.patch
+vm-early-zone-reclaim.patch
+vm-early-zone-reclaim-tidy.patch
+vm-add-__gfp_noreclaim.patch
+vm-rate-limit-early-reclaim.patch

 These patches were updated

+node-local-per-cpu-pages-tidy-2-fix.patch

 Fix node-local-per-cpu-pages.patch some more.

+avoiding-mmap-fragmentation-revert-unneeded-64-bit-changes-vs-x86_64-task_size-fixes-for-compatibility-mode-processes.patch

 Fix a patch clash

+__mod_page_state-pass-unsigned-long-instead-of-unsigned.patch
+__read_page_state-pass-unsigned-long-instead-of-unsigned.patch

 Warning fixes

+add-oom-debug.patch

 Additional debug output when the box goes oom.

+periodically-drain-non-local-pagesets.patch
+periodically-drain-non-local-pagesets-fix.patch

 Shrink the per-cpu-pages caches occasionally

+ia64-uncached-alloc.patch
+sn2-xpc-build-patches.patch

 Special allocator for uncached pages

+shmem-restore-superblock-info.patch
+mbind-fix-verify_pages-pte_page.patch
+mbind-check_range-use-standard-ptwalk.patch
+dup_mmap-update-comment-on-new-vma.patch
+bad_page-clear-reclaim-and-slab.patch
+rme96xx-fix-pagereserved-range.patch
+get_user_pages-kill-get_page_map.patch
+do_wp_page-cannot-share-file-page.patch
+can_share_swap_page-use-page_mapcount.patch
+msync-check-pte-dirty-earlier.patch

 Various mm fixes

+sunzilog-warning-fixes.patch
+ppp-handle-misaligned-accesses.patch

 Net fixes

+ppc32-removed-dependency-on-config_cpm2-for-building.patch
+ppc32-converted-mpc10x-bridge-to-use-platform.patch
+cpm_uart-route-scc2-pins-for-the-stx-gp3-board.patch

 ppc32 updates

+ppc64-iseries-remove-iseries_proch.patch
+ppc64-iseries-header-file-white-space-cleanups.patch
+ppc64-iseries-more-header-file-white-space-cleanups.patch
+ppc64-iseries-obvious-code-simplifications.patch
+ppc64-iseries-remove-lpardatah.patch
+ppc64-iseries-eliminate-some-unused-inline-functions.patch
+ppc64-iseries-remove-hvcallcfgh.patch
+ppc64-iseries-cleanup-itlpqueueh.patch
+ppc64-iseries-tidy-up-some-includes-and-hvcallh.patch
+ppc64-iseries-misc-header-cleanups.patch
+update-ppc64-defconfig.patch
+ppc64-iseries-remove-iseries_pci_resetc.patch
+ppc64-iseries-iommuh-cleanups.patch
+ppc64-iseries-iseries_vpdinfoc-cleanups.patch
+ppc64-iseries-iseries_pcih-cleanups.patch
+ppc64-iseries-remove-ioretry-from-iseries_device_node.patch
+ppc64-iseries-remove-some-more-members-of.patch

 ppc64 updates

+x86-x86_64-pcibus_to_node-fix.patch

 Fix x86-x86_64-pcibus_to_node.patch

+mempool-bounce-buffer-restriction.patch

 Limit the amount of memory which can be used for bounce buffers

+arm-irqs_disabled-type-fix.patch

 ARM warning fix

+variable-overflow-after-hundreds-round-of-hotplug-cpu.patch

 CPU hotplug fix

+x86_64-change-init-sections-for-cpu-hotplug-support.patch
+x86_64-change-init-sections-for-cpu-hotplug-support-fix.patch
+x86_64-cpu-hotplug-support.patch
+x86_64-cpu-hotplug-sibling-map-cleanup.patch
+x86_64-dont-use-broadcast-shortcut-to-make-it-cpu-hotplug-safe.patch
+x86_64-provide-ability-to-choose-using-shortcuts-for-ipi-in-flat-mode.patch

 CPU hotplug for x86_64

+m32r-support-m3a-2170mappi-iii-platform-fix.patch
+m32r-support-m3a-2170mappi-iii-platform-fix-2.patch
+m32r-update-setup_xxxxxc.patch
+m32r-update-m32r_cfc-to-support-mappi-iii-fix.patch
+m32r-cleanup-arch-m32r-mm-extablec.patch
+m32r-remove-include-asm-m32r-m32102perih.patch
+m32r-update-defconfig-files.patch
+m32r-use-asm-generic-div64h.patch

 m32r fixes and updates

+s390-cio-max-channels-checks.patch
+s390-cio-documentation.patch
+s390-ifdefs-in-compat_ioctls.patch
+s390-kernel-stack-overflow-panic.patch
+s390-cmm-sender-parameter-visibility.patch
+s390-memory-detection-32gb.patch
+s390-pending-interrupt-after-ipl-from-reader.patch

 s/390 updates

+ecryptfs-export-user-key-type.patch

 Export a symbol

+x86_64-specific-function-return-probes.patch
+kprobes-ia64-cleanup-2.patch
+kprobes-ia64-cmp-ctype-unc-support.patch
+kprobes-ia64-safe-register-kprobe.patch
+kprobes-temporary-disarming-of-reentrant-probe-for-x86_64-fix.patch
+allow-a-jprobe-to-coexist-with-muliple-kprobes.patch

 kprobes updates

+cs4236-irq-handling-fix.patch

 OSS driver fix

+block-add-unlocked_ioctl-support-for-block-devices.patch

 Support lock_kernel-less ioctls on blockdevs

+pcdp-handle-tables-that-dont-supply-baud-rate.patch

 serial driver update

+stop-arch-i386-kernel-vsyscall-noteo-being-rebuilt-every-time.patch

 kbuild fix

+remove-f_error-field-from-struct-file.patch

 cleanup

+autofs4-avoid-panic-on-bind-mount-of-autofs-owned-directory.patch
+autofs4-post-expire-race-fix.patch
+autofs4-bad-lookup-fix.patch
+autofs4-subversion-bump-to-identify-these-changes.patch

 autofs4 updates

+rapidio-support-core-base.patch
+rapidio-support-core-includes.patch
+rapidio-support-core-enum.patch
+rapidio-support-ppc32.patch
+rapidio-support-net-driver.patch

 RapidIO driver

+dlm-lockspaces-callbacks-directory-dlm-consistent-ifdefs.patch
+dlm-lockspaces-callbacks-directory-fix-2-dlm-dont-repeat-include.patch
+dlm-lockspaces-callbacks-directory-fix-3.patch
+dlm-lockspaces-callbacks-directory-dlm-dont-free-lvb-twice.patch
+dlm-communication-dlm-dont-add-duplicate-node-addresses.patch
+dlm-recovery-dlm-timer-cant-be-global.patch
+dlm-recovery-dlm-clear-recovery-flags.patch
+dlm-device-interface-dlm-uncomment-unregister_lockspace.patch
+dlm-device-interface-dlm-newline-in-printks.patch
+dlm-debug-fs-dlm-consistent-ifdefs.patch

 Various fixes and updates to the DLM driver

+tuner-corec-improvments-and-ymec-tvision-tvf8533mf.patch

 v4l udpate

+oprofile-report-anonymous-region-samples.patch

 oprofile feature

+lockd-flush-signals-on-shutdown.patch
+nfs4-hold-filp-while-reading-or-writing.patch
+nfsd4-fix-probe_callback.patch
+nfsd4-nfs4_check_open_reclaim-cleanup.patch
+nfsd4-create-separate-laundromat-workqueue.patch
+nfsd4-simplify-lease-changing.patch
+nfsd4-delegation-recovery.patch
+nfsd4-rename-nfs4_state_init.patch
+nfsd4-clean-up-state-initialization.patch
+nfsd4-remove-nfs4_reclaim_init.patch
+nfsd4-idmap-initialization.patch
+nfsd4-setclientid-simplification.patch
+nfsd4-reboot-hash.patch
+nfsd4-add-find_unconf_by_str-functions-to-simplify-setclientid.patch
+nfsd4-grace-period-end.patch
+nfsd4-make-needlessly-global-code-static.patch
+nfsd4-fix-uncomfirmed-list.patch
+nfsd4-fix-setclientid_confirm-cases.patch
+nfsd4-fix-setclientid_confirm-error-return.patch
+nfsd4-setclientid_confirm-gotoectomy.patch
+nfsd4-setclientid_confirm-comments.patch
+nfsd4-miscellaneous-setclientid_confirm-cleanup.patch
+nfsd4-rename-state-list-fields.patch
+nfsd4-allow-multiple-lockowners.patch
+nfsd4-remove-cb_parsed.patch
+nfsd4-initialize-recovery-directory.patch
+nfsd4-reboot-recovery.patch
+nfsd4-reboot-dirname.patch

 nfsd updates

+isofs-show-hidden-files-add-granularity-for-assoc-hidden-files-flags.patch
+isofs-show-hidden-files-add-granularity-for-assoc-hidden-files-flags-tidy.patch
+isofs-show-hidden-files-add-granularity-for-assoc-hidden-files-flags-fix.patch

 isofs feature work

+numa-aware-slab-allocator-v5.patch

 The NUMA-aware slab allocator is back.  Needs ifdef-reduction work.

-periodically-scan-redzone-entries-and-slab-control-structures.patch
-slab-leak-detector.patch
-slab-leak-detector-warning-fixes.patch

 It broke these.

+numa-aware-slab-allocator-v3-__bad_size-fix.patch

 Fix it.

+sched-run-sched_normal-tasks-with-real-time-tasks-on-smt-siblings.patch

 CPU scheduler fix

+v4l-add-support-for-pixelview-ultra-pro.patch
+dvico-fusionhdtv3-gold-t-documentation-fix.patch

 v4l updates

+kexec-code-cleanup.patch

 Make all the kexec patches resemble CodingStyle.

+v9fs-documentation-makefiles-configuration.patch
+v9fs-documentation-makefiles-configuration-fix.patch
+v9fs-vfs-file-dentry-and-directory-operations.patch
+v9fs-vfs-file-dentry-and-directory-operations-fix.patch
+v9fs-vfs-inode-operations.patch
+v9fs-vfs-superblock-operations-and-glue.patch
+v9fs-9p-protocol-implementation.patch
+v9fs-transport-modules.patch
+v9fs-debug-and-support-routines.patch
+v9fs-debug-and-support-routines-fix.patch

 The plan9 networked filesystem

+framebuffer-driver-for-arc-lcd-board.patch
+framebuffer-driver-for-arc-lcd-board-tidy.patch
+framebuffer-driver-for-arc-lcd-board-update.patch
+new-pci-id-for-chipsfb.patch

 fbdev updates

+modules-add-version-and-srcversion-to-sysfs-fix.patch
+modules-add-version-and-srcversion-to-sysfs-fix-2.patch

 Fix modules-add-version-and-srcversion-to-sysfs.patch

+fuse-device-functions-fuse-serious-information-leak-fix.patch

 FUSE fix

+remove-redundant-info-from-submittingpatches.patch

 Documentation update

-unexport-slab_reclaim_pages.patch

 Drop this due to some reject.



number of patches in -mm: 1397
number of changesets in external trees: 53
number of patches in -mm only: 1395
total patches: 1448


All 1397 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc6/2.6.12-rc6-mm1/patch-list


