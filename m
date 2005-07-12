Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVGLJV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVGLJV2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVGLJTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:19:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57304 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261275AbVGLJSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:18:08 -0400
Date: Tue, 12 Jul 2005 02:17:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc2-mm2
Message-Id: <20050712021724.13b2297a.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc2/2.6.13-rc2-mm2/

(And at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc2-mm2.gz -
kenrel.org mirroring is being slow again)


- MM updates

- More video4linux updates

- Infiniband feature work


Changes since 2.6.13-rc2-mm1:


-uml-kill-some-useless-vmalloc-tlb-flushing.patch
-iounmap-debugging.patch
-i2o-config-osm-build-fix.patch
-print-kbd-and-aux-irqs-correctly.patch
-i8042-x86ia64-printk-fixes.patch
-ocfs2-avoid-lookup_hash-usage-in-configfs.patch
-dpt_i2o-warning-fix.patch
-aic79xx-ahd_linux_dev_reset-cleanup.patch
-print-order-information-when-oom-killing.patch
-print-order-information-when-oom-killing-fix.patch
-remove-completly-bogus-comment-inside-__alloc_pages-try_to_free_pages-handling.patch
-quieten-oom-killer-noise.patch
-build-tags-problem-with-o=.patch
-kbuild-build-a-single-module-using-make-dir-moduleko.patch
-ppc64-add-new-phy-to-sungem.patch
-ppc64-vdso32-fix-link-errors-after-recent-toolchain-changes.patch
-ppc64-use-c99-initialisers-in-cputable-code.patch
-ppc64-fix-runlatch-code-to-work-on-pseries-machines.patch
-ppc64-turn-runlatch-on-in-exception-entry.patch
-move-ioprio-syscalls-into-syscallsh.patch
-ppc64-sys_ppc32c-cleanups.patch
-ppc64-add-ioprio-syscalls.patch
-ppc64-remove-duplicate-syscall-reservation.patch
-hvc_console-rearrange-code.patch
-hvc_console-match-vio-and-console-devices-using-vterm-numbers.patch
-hvc_console-dont-always-kick-the-poll-thread-in-interrupt.patch
-hvc_console-magic_sysrq-should-only-be-on-console-channel.patch
-hvc_console-unregister-the-console-in-the-exit-routine.patch
-hvc_console-add-missing-include.patch
-hvc_console-remove-num_vterms-and-some-dead-code.patch
-hvc_console-statically-initialize-the-vtermnos-array.patch
-hvc_console-add-some-sanity-checks.patch
-hvc_console-separate-hvc_console-and-vio-code.patch
-hvc_console-separate-hvc_console-and-vio-code-2.patch
-hvc_console-register-ops-when-setting-up-hvc_console.patch
-hvc_console-separate-the-nul-character-filtering-from-get_hvc_chars.patch
-hvc_console-use-hvc_get_chars-in-hvsi-code.patch
-ppc64-make-idle_loop-a-ppc_md-function.patch
-ppc64-move-iseries_idle-into-iseries_setupc.patch
-ppc64-move-pseries-idle-functions-into-pseries_setupc.patch
-ppc64-fixup-platforms-for-new-ppc_mdidle.patch
-ppc64-remove-obsolete-idle_setup.patch
-ppc64-iseries-idle-fixups.patch
-ppc64-pseries-idle-fixups.patch
-ppc64-idle-fixups.patch
-ppc64-fix-compile-warning.patch
-ppc64-be-consistent-about-printing-which-idle-loop-were-using.patch
-ppc64-silence-perfmon-exception-warnings.patch
-frv-add-defconfig.patch
-mtrr-suspend-resume-cleanup.patch
-clean-up-numa-defines-in-mmzoneh.patch
-fix-up-non-numa-breakage-in-mmzoneh.patch
-pm-more-u32-vs-pm_message_t-fixes.patch
-pm-fix-u32-vs-pm_message_t-confusion-in-cpufreq.patch
-fix-resume-from-initrd.patch
-swsusp-fix-error-handling.patch
-clean-up-processc.patch
-uml-skas0-separate-kernel-address-space-on-stock-hosts.patch
-uml-proper-clone-support-for-skas0.patch
-uml-restore-hppfs-support.patch
-uml-remove-winch-sem.patch
-xtensa-remove-old-syscalls.patch
-tty-output-lossage-fix.patch
-page_uptodate-locking-scalability.patch
-page_uptodate-locking-scalability-fix.patch
-acl-kconfig-cleanup.patch
-propagate-__nocast-annotations.patch
-mostly_read-data-section.patch
-dont-write-to-the-in-inode-xattr-space-of-reserved-inodes.patch
-put_compat_shminfo-warning-fix.patch
-autofs4-mistake-in-debug-print.patch
-keys-base-keyring-size-on-key-pointer-not-key-struct.patch
-cond_resched-fix-bogus-might_sleep-warning.patch
-coverity-fbsysfs-fix-null-pointer-check.patch
-coverity-fs-locks-flp-null-check.patch
-coverity-sunrpc-xprt-task-null-check.patch
-alpha-pgprot_noncached.patch
-ib-uverbs-core-api-extensions.patch
-ib-uverbs-update-kernel-midlayer-for-new-api.patch
-ib-uverbs-update-mthca-for-new-api.patch
-ib-uverbs-add-user-verbs-abi-header.patch
-ib-uverbs-core-implementation.patch
-ib-uverbs-core-implementation-fix.patch
-ib-uverbs-memory-pinning-implementation.patch
-ib-uverbs-hook-up-kconfig-makefile.patch
-ib-uverbs-add-mthca-abi-header.patch
-ib-uverbs-add-mthca-user-doorbell-record-support.patch
-ib-uverbs-add-mthca-user-context-support.patch
-ib-uverbs-add-mthca-mmap-support.patch
-ib-uverbs-add-mthca-mmap-support-fix.patch
-ib-uverbs-add-mthca-mmap-support-fix-2.patch
-ib-uverbs-add-mthca-user-pd-support.patch
-ib-uverbs-add-mthca-user-mr-support.patch
-ib-uverbs-add-mthca-user-cq-support.patch
-ib-uverbs-add-mthca-user-qp-support.patch
-ib-uverbs-add-documentation-file.patch
-namespacec-fix-mnt_namespace-clearing.patch
-namespacec-fix-race-in-mark_mounts_for_expiry.patch
-namespacec-cleanup-in-mark_mounts_for_expiry.patch
-namespacec-split-mark_mounts_for_expiry.patch
-namespacec-fix-expiring-of-detached-mount.patch
-namespacec-fix-mnt_namespace-zeroing-for-expired-mounts.patch
-set-mnt_namespace-in-the-correct-place.patch
-dcookiesc-use-proper-refcounting-functions.patch
-namespace-rename-mnt_fslink-to-mnt_expire.patch
-namespace-rename-_mntput-to-mntput_no_expire.patch
-dvb-cinergyt2-endianness-fix-for-raw-remote-control-keys.patch
-dvb-remove-obsolete-skystar2-driver.patch
-dvb-core-fix-race-condition-in-fe_read_status-ioctl.patch
-dvb-core-add-workaround-for-tuning-problem.patch
-dvb-core-demux-error-handling-fix.patch
-dvb-core-dmxdev-cleanups.patch
-dvb-frontend-remove-unused-i2c-ids.patch
-dvb-frontend-tda1004x-update.patch
-dvb-frontend-bcm3510-fix-firmware-version-check.patch
-dvb-add-missing-release_firmware-calls.patch
-dvb-frontend-tda1004x-support-tda827x-tuners.patch
-dvb-frontend-cx22702-support-for-cxusb.patch
-dvb-frontend-l64781-improve-tuning.patch
-dvb-dvb-update.patch
-dvb-add-pluto2-driver.patch
-dvb-add-pluto2-driver-fix.patch
-dvb-saa7146-kj-pci_module_init-cleanup.patch
-dvb-flexcop-add-big-endian-register-definitions.patch
-dvb-flexcop-woraround-irq-stop-problem.patch
-dvb-twinhan-dst-frontend-fixes.patch
-dvb-twinhan-dst-frontend-polarization-fix.patch
-dvb-ttusb-dec-kfree-cleanup.patch
-dvb-ttpci-add-support-for-technotrend-hauppauge-dvb-s-se.patch
-dvb-ttpci-support-for-new-tt-dvb-t-ci.patch
-dvb-ttpci-fix-error-handling-for-firmware-communication.patch
-dvb-ttpci-fix-bug-in-timeout-handling.patch
-dvb-ttpci-fix-auduio_continue-ioctl.patch
-dvb-ttpci-budget-av--tu1216-fix-for-qam128.patch
-dvb-ttpci-more-error-handling-for-firmware-communication.patch
-dvb-ttpci-error-handling-fix.patch
-dvb-ttpci-cleanup-indentation-whitespace.patch
-dvb-ttpci-make-av7110_fe_lock_fix-retryable.patch
-dvb-ttpci-kj-printk-fix.patch
-dvb-ttpci-add-support-for-hauppauge-tt-dvb-c-budget.patch
-dvb-dvb-usb-support-artect-t1-with-broken-usb-ids.patch
-dvb-usb-fix-adstech-instant-tv-dvb-t-usb20-support.patch
-dvb-usb-add-isochronous-streaming-method.patch
-dvb-frontend-add-fmd1216me-pll.patch
-dvb-usb-support-medion-hybrid-usb20-dvb-t-analogue-box.patch
-dvb-usb-add-module-parm-to-disable-remote-control-polling.patch
-dvb-frontend-add-alps-tded4-pll.patch
-dvb-usb-digitv-usb-fixes.patch
-dvb-usb-dvb_usb_properties-init-fix.patch
-dvb-usb-cxusb-dvb-t-fixes.patch
-dvb-usb-add-videowalker-dvb-t-usb-ids.patch
-dvb-usb-digitv-memcpy-fix.patch
-dvb-usb-doc-update.patch
-dvb-usb-kconfig-help-text-update.patch
-dvb-usb-add-vp7045-ir-keymap.patch
-dvb-usb-fix-wideview-usb-ids.patch
-dvb-usb-vp7045-ir-map-fix.patch
-dvb-usb-ir-input-fixes.patch
-dvb-usb-a800-rc-and-timeout-fixes.patch
-dvb-usb-dont-use-hz-for-timeouts.patch
-dvb-ttpci-fix-timeout-handling-to-be-save-with-preempt.patch
-dvb-frontend-add-driver-for-lgdt3302.patch
-dvb-usb-pci-correct-syntax-of-driver-name-fields.patch
-dvb-dst-fix-tuning-problem.patch
-dvb-usb-add-supprt-for-wideview-wt-220u.patch
-dvb-usb-readme-update.patch
-fix-for-documentation-dvb-bt8xxtxt.patch
-pcmcia-fix-i82365-request_region-double-usage.patch
-pcmcia-deprecate-ioctl.patch
-pcmcia-move-event-handler.patch
-pcmcia-remove-client_t-usage.patch
-pcmcia-reduce-client_handle_t-usage.patch
-pcmcia-remove-client-services-version.patch
-pcmcia-remove-client-services-version-fix.patch
-pcmcia-remove-references-to-pcmcia-versionh.patch
-pcmcia-update-maintainers-entry.patch
-yenta-no-cardbus-if-irq-fails.patch
-yenta-dont-depend-on-cardbus.patch
-nfsd4-reboot-recovery-fix.patch
-nfsd4-fix-syncing-of-recovery-directory.patch
-nfsd4-lookup_one_len-takes-i_sem.patch
-nfsd4-prevent-multiple-unlinks-of-recovery-directories.patch
-nfsd4-fix-release_lockowner.patch
-nfsd4-err_grace-should-bump-seqid-on-open.patch
-nfsd4-err_grace-should-bump-seqid-on-lock.patch
-nfsd4-stop-overusing-reclaim_bad.patch
-nfsd4-comment-indentation.patch
-nfsd4-fix-open_reclaim-seqid.patch
-nfsd4-seqid-comments.patch
-nfsd4-relax-new-lock-seqid-check.patch
-nfsd4-always-update-stateid-on-open.patch
-nfsd4-return-better-error-on-io-incompatible-with-open-mode.patch
-nfsd4-renew-lease-on-seqid-modifying-operations.patch
-nfsd4-clarify-close_lru-handling.patch
-nfsd4-clean-up-nfs4_preprocess_seqid_op.patch
-nfsd4-check-lock-type-against-openmode.patch
-nfsd4-fix-fh_expire_type.patch
-v4l-cx88-hue-offset-fix.patch
-v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-q.patch
-v4l-add-terratec-cinergy-1400-dvb-t.patch
-v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-t.patch
-v4l-lgdt3302-read-status-fix.patch
-m32r-framebuffer-device-support.patch
-video-documentation-update.patch
-device-mapper-dm-raid1-limit-bios-to-size-of-mirror-region.patch
-device-mapper-dm-raid1-limit-bios-to-size-of-mirror-region-fix.patch

 Merged

+name_to_dev_t-warning-fix.patch

 Fix a warning

+aacraid-swapped-kmalloc-args.patch

 kmalloc() fix

+device-mapper-multipath-barriers-not-supported.patch
+device-mapper-multipath-flush-workqueue-when-destroying.patch
+device-mapper-multipath-avoid-possible-suspension-deadlock.patch
+device-mapper-multipath-fix-pg-initialisation-races.patch
+device-mapper-fix-dm_swap_table-error-cases.patch
+device-mapper-snapshots-handle-origin-extension.patch

 device mapper updates

+lower-vm_dontcopy-total_vm.patch

 VM fix

+sparc64-read_mostly-build-fix.patch

 sparc64 build fix

+x86_64-section-linkage-fix.patch

 x86_64 section laypout fix

+pcmcia-fix-pcmcia-cs-compilation.patch
+yenta-fix-parent-resource-determination.patch
+pcmcia-documentation-update.patch
+yenta-same-resources-in-same-structs.patch
+yenta-allocate-resource-fixes.patch

 pcmcia/cardbus updates

+move-truncate_inode_pages-into-delete_inode.patch
+update-filesystems-for-new-delete_inode-behavior.patch

 API adjustments for OCFS2

+pci_link-pm_message_t-fix.patch

 pm_message_t fix

+remove-preempt_disable-from-powernow-k8.patch

 cpufreq cleanup

+speakup-build-fix.patch

 Fix a patch in Greg's tree

+git-drm.patch

 New DRM tree from David Airlie.

+drm-via-fix-sparse-warnings.patch

 Fix some DRM sparse warnings

-input-usb-ignore-logitech-vendor-usages.patch
-input-usb-hid-simulation-usages.patch
-input-i8042-no-cmd-negate.patch
-input-synaptics-dynabook.patch
-input-input-check-keycodesize.patch
-input-joydev-msecs.patch
-input-alps-suspend-typo.patch
-input-alps-fix-tap-logic.patch
-input-hid-badpad-trust-sight.patch
-input-hid-more-consumer-usages.patch
-input-hiddev-no-ctrl-in-read.patch
-input-atkbd-allow-0x7f-scancode.patch
-input-psmouse-wheel-mice-have-middle-button.patch
-input-hid-variable-max-buffer-size.patch
-input-hid-remove-mcc-blacklist.patch
+input-usb-ignore-logitech-vendor-usages.diff.patch
+input-usb-hid-simulation-usages.diff.patch
+input-i8042-no-cmd-negate.diff.patch
+input-input-check-keycodesize.diff.patch
+input-i8042-fix-irq-printk.diff.patch
+input-hid-more-consumer-usages.diff.patch
+input-atkbd-allow-0x7f-scancode.diff.patch
+input-psmouse-wheel-mice-have-middle-button.diff.patch
+input-hid-variable-max-buffer-size.diff.patch
+input-hid-remove-mcc-blacklist.diff.patch
+input-hid-logitech-ultra-x-media-remote.diff.patch
+input-i8042-mux-blacklist-fsc-t3010.diff.patch
+input-iforce-wait-event.diff.patch

 Vojtech has naming problems

-pci-pci-transparent-bridge-handling-improvements-yenta_socket.patch

 Dropped, deemed bad.

+gregkh-usb-usbsnoop.patch

 USB tree

+fix-something-in-scsi.patch
+usb-storage-rearrange-stuff.patch
+fix-something-in-usb.patch

 Fix something in USB.  No description was included and I can't be bothered
 working out what it does.

+remove-bogus-warning-in-page_allocc.patch
+swap-update-swapfile-i_sem-comment.patch
+swap-correct-swapfile-nr_good_pages.patch
+swap-move-destroy_swap_extents-calls.patch
+swap-swap-extent-list-is-ordered.patch
+swap-show-span-of-swap-extents.patch
+swap-swap-unsigned-int-consistency.patch
+swap-freeing-update-swap_listnext.patch
+swap-get_swap_page-drop-swap_list_lock.patch
+swap-scan_swap_map-restyled.patch
+swap-scan_swap_map-drop-swap_device_lock.patch
+swap-scan_swap_map-latency-breaks.patch
+swap-swap_lock-replace-listdevice.patch
+swap-update-swsusp-use-of-swap_info.patch
+swap-update-swsusp-use-of-swap_info-fix.patch
+delete-from_swap_cache-bug_ons.patch
+rmap-dont-test-rss.patch

 VM/MM fixes and updates from Hugh.

+smaps-say-vma-not-map.patch
+smaps-use-new-ptwalks.patch
+smaps-say-kb-not-kb.patch

 Fiddle with proc-pid-smaps.patch

+drivers-net-wireless-ipw2200c-remove-division-by-zero.patch

 Fix compile-time div-by-zero

+kconfig-kxgettext-message-fix.patch
+kconfig-kxgettext-eol-fix.patch
+kconfig-linuxpot-for-all-arch.patch

 Kconfig internationalisation fixes

+security-enable-atomic-inode-security-labeling.patch
+security-enable-atomic-inode-security-labeling-use-kstrdup.patch
+ext2-enable-atomic-inode-security-labeling.patch
+ext2-enable-atomic-inode-security-labeling-fix.patch
+ext3-enable-atomic-inode-security-labeling.patch
+ext3-enable-atomic-inode-security-labeling-fix.patch

 LSM/xattr feature work.  Apparently these causes oopses when running
 quotaoff or unmount, when quotas are in use.

+ppc64-kill-bitfields-in-ppc64-hash-code.patch

 ppc64 cleanup

+x86-compress-the-stack-layout-of-do_page_fault.patch
+x86-compress-the-stack-layout-of-do_page_fault-fix.patch

 x86 stack space reduction

+x86-avoid-wasting-irqs-patch-update.patch

 compress x86 IRQ space layout

+x86_64-avoid-wasting-irqs-patch-update.patch

 ditto for x86_64

+alpha-pgprot_uncached-comment.patch

 Add a comment to alpha's pgprot_uncached() implementation

-isa-dma-suspend-for-i386.patch
-isa-dma-suspend-for-x86_64.patch
+isa-dma-suspend-for-i386-2.patch
+isa-dma-suspend-for-x86_64-2.patch

 New version.

+cris-update-17-17-new-subarchitecture-v32-swapped-kmalloc-args.patch

 Fix cris-update-17-17-new-subarchitecture-v32.patch

+uml-remove-user_constantsh-on-clean.patch
+uml-tlb-flushing-fix.patch

 UML fixes

+xtensa-remove-old-syscalls-2-2.patch
+xtensa-use-ssleep-instead-of-schedule_timeout.patch

 xtensa updates

+s390-spin-lock-retry.patch
+s390-find_next_zero_bit-fixes.patch
+s390-atomic64-inline-functions.patch
+s390-external-call-performance.patch
+s390-debug-data-for-ifcc-ccc.patch
+s390-resource-accessibility-event-handling.patch
+s390-fba-dasd-i-o-errors.patch
+s390-free-dasd-slab-cache.patch
+s390-channel-tape-fixes.patch
+s390-31-bit-memory-size-limit.patch
+s390-cpu-timer-reset-in-machine-check-handler.patch
+s390-use-__cpcmd-in-vmcp_write.patch

 s/390 update

+reset-real_timer-target-on-exec-leader-change.patch
+reset-real_timer-target-on-exec-leader-change-coding-style-fixes.patch

 itimer fix

+fix-ext3-options-parsing.patch
+fix-ext2-mount-options-parting.patch

 fix ext2/3 mount error path code

+cdev-cdev_put-oops.patch

 Fix a cdev_put() use-after-free

+more-__read_mostly-variables.patch

 Use __read_mostly a bit more

+provide-better-printk-support-for-smp-machines.patch
+provide-better-printk-support-for-smp-machines-tidy.patch

 Try to fix the mangled-oops-output-on-smp thing again

+tlb-warning-fix.patch

 Fix a warning

+nfs-procfs-sysctl-interfaces-for-lockd-do-not-work-on-x86_64.patch

 Fix nfs /proc interface

+ibm_asm-kconfig-corrections.patch

 IBMASM driver fixes

+tb0219-add-pci-irq-initialization.patch

 Fix a mips driver

+documentation-kernel-parameterstxt-fix-a-typo.patch

 documentation fix

+kexec-ppc-fix-for-ksysfs-crash_notes.patch

 kexec/ppc build fix

+irda-users-listssourceforgenet-is-subscribers-only.patch

 MAINTAINERS tweak

+hardirq-uses-preempt.patch
+kernel-capabilityc-add-kerneldoc.patch
+kernel-cpusetc-add-kerneldoc-fix-typos.patch
+kernel-crash_dumpc-add-kerneldoc.patch

 Various minor things

+nmi-update-nmi-users-of-rcu-to-use-new-api.patch
+nmi-update-nmi-users-of-rcu-to-use-new-api-documentation.patch

 Update the NMI-uses-RCU code

+pty_chars_in_buffer-oops-fix.patch

 Fix an unknown oops by unknown means

+kjournald-missing-jfs_unmount-check.patch
+fix-jbd-race-in-t_forget-list-handling.patch
+make-ll_rw_block-wait-for-buffer-lock.patch
+change-ll_rw_block-calls-in-jbd.patch
+change-ll_rw_block-calls-in-reiser.patch
+change-ll_rw_block-calls-in-ufs.patch
+change-hfs-to-not-use-ll_rw_block.patch
+fix-race-in-do_get_write_access.patch
+fix-race-in-do_get_write_access-warning-fix.patch

 Various filesystem fixes, mainly ext3

+ib-update-fmr-functions.patch
+ib-update-mad-client-api.patch
+ib-add-mad-helper-functions.patch
+ib-combine-some-mad-routines.patch
+ib-change-saving-of-users-send-wr_id-in-mad.patch
+ib-change-ib_mad_send_wr_private-struct.patch
+ib-fix-timeout-cancelled-mad-handling.patch
+ib-minor-cleanup-during-mad-startup-and-shutdown.patch
+ib-add-ib_coalesce_recv_mad-to-mad.patch
+ib-add-automatic-retries-to-mad-layer.patch
+ib-simplify-calling-of-list_del-in-mad.patch
+ib-eliminate-mad-cache-leak-associated-with-local.patch
+ib-add-ib_modify_mad-api-to-mad.patch
+ib-optimize-canceling-a-mad.patch
+ib-fix-a-couple-of-mad-code-paths.patch
+ib-add-ib_create_ah_from_wc-to-ib-verbs.patch
+ib-a-couple-of-ib-core-bug-fixes.patch
+ib-introduce-rmpp-apis.patch
+ib-add-rmpp-implementation.patch
+ib-add-service-record-support-to-sa-client.patch
+ib-add-the-header-file-for-kernel-cm-communications.patch
+ib-add-the-kernel-cm-implementation.patch
+ib-user-mad-abi-changes-to-support-rmpp.patch
+ib-implementation-for-rmpp-support-in-user-mad.patch
+ib-add-the-header-file-for-user-space-cm.patch
+ib-add-kernel-portion-of-user-cm-implementation.patch
+ib-add-kernel-portion-of-user-cm-implementation-fix.patch
+ib-hook-up-userspace-cm-to-the-make-system.patch
+ib-eliminate-sparse-warnings-in-sa-client.patch
+ib-add-core-locking-documentation-to-infiniband.patch

 Infiniband feature work

+pivot_root-circular-reference-fix.patch

 Fix a problem in pivot_root().  (I think this was the wrong patch)

+dvb-lgdt3302-qam256-initialization-fix.patch
+dvb-lgdt3302-qam256-initialization-fix-fix.patch

 DVB fix

+pcmcia-reduce-dsc-stack-footprint.patch
+yenta-share-code-with-pci-core.patch
+pci-and-yenta-pcibios_bus_to_resource.patch
+pci-and-yenta-pcibios_bus_to_resource-fix.patch
+pci-and-yenta-pcibios_bus_to_resource-ppc-fix.patch

 pcmcia/cardbus fixes

+nfs-fix-xprt_bindresvport.patch

 Fix NFS port range allocation

+page_uptodate-locking-scalability-fix.patch

 Fix spinlock-consolidation.patch

+slab-leak-detector.patch

 Bring back the slab leak detector debugging feature (cleaned up)

+sysfs-crash-debugging.patch

 Try to print the name of the most-recently-opened sysfs file when we oops
 (x86).  Because we often get close()-time sysfs oopses and the stack trace
 won't tell us which subsystem's sysfs file it was.

+v4l-bttv-input.patch
+v4l-bttv-update.patch
+v4l-documentation.patch
+v4l-saa7134-hybrid-dvb.patch
+v4l-i2c-bt832.patch
+v4l-i2c-infrared-remote-control.patch
+v4l-i2c-miscelaneous.patch
+v4l-i2c-tuner.patch
+v4l-drivers-media-video-kconfig.patch
+v4l-mxb-fix-to-correct-tuner-ioctl.patch
+v4l-saa7134-update.patch
+v4l-tuner-3026-replace-obsolete-ioctl.patch
+v4l-tv-eeprom.patch

 v4l updates

+reiser4-update-filesystems-for-new-delete_inode-behavior.patch

 Fix reiser4-only.patch for move-truncate_inode_pages-into-delete_inode.patch

-possible-dcache-bug-debugging-patch.patch

 Dropped, not needed

+device-mapper-fix-deadlocks-in-core-prep.patch
+device-mapper-fix-deadlocks-in-core.patch
+device-mapper-fix-md-lock-deadlocks-in-core.patch

 device mapper updates

+mm-slab-fix-sparse-warnings.patch
+drivers-char-ip2-i2libc-replace-direct-assignment-with-set_current_state.patch
+kernel-auditc-fix-sparse-warnings-__nocast-type.patch
+char-n_tty-fix-sparse-warnings-__nocast-type.patch
+kernel-acct-add-kerneldoc.patch
+scripts-kernel-doc-dont-use-uninitialized-srctree.patch
+net-kconfig-two-atm-related-spelling-fixes.patch
+use-pci_device-in-forcedethc.patch
+ppc-c99-initializers-for-hw_interrupt_type-structures.patch
+sh-c99-initializers-for-hw_interrupt_type-structures.patch
+v850-c99-initializers-for-hw_interrupt_type-structures.patch
+sh64-c99-initializers-for-hw_interrupt_type-structures.patch
+add-kerneldoc-reference-to-codingstyle.patch

 Various minor things.




number of patches in -mm: 571
number of changesets in external trees: 9
number of patches in -mm only: 570
total patches: 579




All 571 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc2/2.6.13-rc2-mm2/patch-list
