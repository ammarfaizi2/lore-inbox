Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVHGIn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVHGIn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 04:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVHGIn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 04:43:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751288AbVHGIn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 04:43:26 -0400
Date: Sun, 7 Aug 2005 01:42:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc5-mm1
Message-Id: <20050807014214.45968af3.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc5/2.6.13-rc5-mm1/

(Grab it from
http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc5-mm1.gz until the
kernel.org mirrors catch up)


- Added the git-scsi-iscsi.patch tree: iSCSI drivers (James Bottomley)

- This kernel is broken on ia64: the spinlock consolidation patch needs fixing.

- The acpi development tree is back in -mm.

- Dropped cachefs and the cachefs-for-AFS patches.  These get in the way of
  memory management testing a bit, and they're being redone anyway.



Changes since 2.6.13-rc4-mm1:


 linus.patch
 git-acpi.patch
 git-alsa.patch
 git-cryptodev.patch
 git-drm.patch
 git-ia64.patch
 git-audit.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-adma-mwi.patch
 git-libata-chs-support.patch
 git-libata-passthru.patch
 git-libata-promise-sata-pata.patch
 git-mtd.patch
 git-net.patch
 git-netdev-chelsio.patch
 git-netdev-e100.patch
 git-netdev-sis190.patch
 git-netdev-smc91x-eeprom.patch
 git-netdev-ieee80211-wifi.patch
 git-netdev-upstream.patch
 git-ocfs2.patch
 git-serial.patch
 git-scsi-block.patch
 git-scsi-iscsi.patch
 git-scsi-misc.patch
 git-sparc64.patch

 Subsystem trees

-i2c-mpc-revert-duplicate-patch.patch
-skge-build-fix.patch
-pci-and-yenta-pcibios_bus_to_resource.patch
-disable-address-space-randomization-on-transmeta-cpus.patch
-v4l-miscellaneous-fixes.patch
-v4l-cx88-card-support-and-documentation-finishing.patch
-maintainers-record-man-pages.patch
-maintainers-record-man-pages-fix.patch
-ppc64-fix-config_altivec-not-set.patch
-display-name-of-fbdev-device.patch
-acpi_register_gsi-change-acpi_register_gsi-interface.patch
-acpi_register_gsi-change-acpi-pci-code.patch
-acpi_register_gsi-change-hpet-driver.patch
-acpi_register_gsi-change-phpacpi-driver.patch
-acpi_register_gsi-change-acpi-based-8250-driver.patch
-acpi_register_gsi-change-ia64-iosapic-code.patch
-acpi-ext-build-fix.patch
-no-acpi-build-fix.patch
-pci_link-pm_message_t-fix.patch
-acpi-fix-table-discovery-from-efi-for-x86.patch
-enable-acpi_hotplug_cpu-automatically-if-hotplug_cpu=y.patch
-drivers-char-drm-drm_pcic-fix-warnings.patch
-input-quirk-for-the-fn-key-on-powerbooks-with-an-usb.patch
-scsi_sata-has-to-be-a-tristate.patch
-include-net-ieee80211h-must-include-linux-wirelessh.patch
-drivers-net-wireless-hostap-hostapc-export_symtab-does-nothing.patch
-fc4-warning-fix.patch
-scsi-ibmvscsi-srph-fix-a-wrong-type-code-used-for-srp_login_rej.patch
-usb-ehci-microframe-handling-fix.patch
-silence-cs89x0.patch
-orinoco-sparse-fixes.patch
-tms380tr-move-to-dma-api.patch
-forcedeth-write-back-the-misordered-mac-address.patch
-ppc32-mark-boards-that-dont-build-as-broken.patch
-ppc32-add-440ep-support.patch
-ppc32-add-bamboo-platform.patch
-ppc32-add-bamboo-defconfig.patch
-ppc32-add-missing-4xx-emac-sysfs-nodes.patch
-8xx-convert-fec-driver-to-use-work_struct.patch
-8xx-using-dma_alloc_coherent-instead-consistent_alloc.patch
-8xx-fec-fix-interrupt-handler-prototypes.patch
-ppc32-remove-board-support-for-ep405.patch
-fix-outstanding-gzip-zlib-security-issues.patch
-fix-outstanding-gzip-zlib-security-issues-ppc64.patch
-remove-special-hpet_emulate_rtc-config-option.patch
-use-pci_device-in-forcedethc.patch

 Merged

+x86_64-ignore-machine-checks-from-boot-time.patch

 Avoid scary x86_64 messages

+__bio_clone-dead-comment.patch

 Fix a bad comment

+make-visws-compile-again.patch
+visws-linkage-fix.patch

 visws build fixes

+remove-linux-pagemaph-from-linux-swaph.patch

 sparc32 build fix

+8xx-convert-fec-driver-to-use-work_struct.patch
+8xx-using-dma_alloc_coherent-instead-consistent_alloc.patch
+8xx-fec-fix-interrupt-handler-prototypes.patch
+ppc32-8xx-fix-cpm-ethernet-description.patch
+ppc32-8xx-restrict-enet_big_buffers-option.patch
+ppc32-8xx-kill-unused-variable-in-commproc.patch
+ppc32-8xx-commproc-avoid-direct-pte-manipulation-use-dma-coherent-api-instead.patch

 ppc32 stuff

+move-the-fix-to-align-node_end_pfns-to-a-proper-location.patch

 sparsemem setup fix

+crc32c-typo-fix.patch

 Fix a tpyo

+fix-possible-null-pointer-access-acpi_pci_irq_disable.patch

 ACPI fix

+gregkh-i2c-i2c-max6875-simplify.patch
+gregkh-i2c-i2c-max6875-fix-build-error.patch
+gregkh-i2c-i2c-max6875-kobj_to_i2c_client.patch
+gregkh-i2c-i2c-max6875-cleanup.patch
+gregkh-i2c-w1-netlink-callbacks.patch

 Additions to Greg's i2c tree

+hid-core-wireless-security-lock-blacklist-entry.patch

 USB fix

+apple-powerbook-usb-keyboard-hid-fix.patch
+ns558-list-handling-fix.patch

 Input driver fixes

+activate-sata300-tx4-in-sata_promise.patch

 New sata device

+git-net-ddcp-fixes.patch
+git-net-svcsock-build-fix.patch

 git-net build fixes

-tcp-hang.patch

 No longer needed

+time-conversion-error-in-net-sunrpc-svcsockc.patch

 timeval calculation fix

+mbio_bus-pm_message_t-fix.patch

 git-netdev fix

+git-scsi-iscsi-vs-git-net.patch

 Make the iscsi code play properly with netlink changes in git-net.patch

+aic79xx-needs-scsi_transport_spi.patch

 git-scsi-misc build fix

+areca-raid-linux-scsi-driver.patch

 Bring this driver back - apparently some people are using it, and the
 hardware is getting more popular.  But this driver is in poor shape and much
 work remains to be done.

+make-usb-handoff-the-default-usb-no-handoff-turns-it-off.patch

 Make usb-handoff the default mode.

+vm-zone-reclaim-atomic-ops-cleanup.patch
+mm-fix-madvise-vma-merging.patch

 MM fixes

+smaps-reading-fix.patch

 Fix /proc/pid/smaps

+pcp32-fix-asm-ppc-dma-mappingh-sparse-warning.patch
+ppc32-fix-gcc4-warning-in-asm-ppc-timeh.patch

 ppc32 updates

+ppc64-allow-xmon=off.patch
+ppc64-update-xmon-helptext.patch
+ppc64-add-vmx-save-flag-to-vpa.patch
+ppc64-four-level-pagetables.patch
+ppc64-four-level-pagetables-fix.patch

 ppc64 updates

+mips-remove-obsolete-giu-function-call-for-vr41xx.patch
+mips-update-irq-handling-for-vr41xx.patch
+mips-change-system-type-name-in-proc-for-vr41xx.patch
+mips-remove-vr4181-support.patch
+mips-remove-hp-laserjet-remains.patch
+dec-pmag-aa-framebuffer-update.patch
+dec-pmag-ba-frame-buffer-update.patch
+dec-pmagb-b-framebuffer-update.patch

 MIPS stuff

-x86-automatically-enable-bigsmp-when-we-have-more-than-8-cpus.patch
+x86-automatically-enable-bigsmp-when-we-have-more-than-8-cpus-2.patch
+x86-automatically-enable-bigsmp-when-we-have-more-than-8-cpus-2-tidy.patch

 New version of this patch

+i386-fix-incorrect-tss-entry-for-ldt.patch
+x86-more-asm-cleanups.patch
+x86-privilege-cleanup.patch
+x86-make-iopl-explicit.patch
+x86-remove-redundant-tss-clearing.patch
+x86-introduce-a-write-acessor-for-updating-the-current-ldt.patch
+x86-nmi-better-support-for-debuggers.patch
+x86-nmi-better-support-for-debuggers-fix.patch
+i386-encapsulate-copying-of-pgd-entries.patch

 x86 cleanups.

+i386-transparent-paravirtualization-sub-arch-move-msr-accessors-into-the-sub-arch-layer.patch
+i386-transparent-paravirtualization-sub-arch-move-privileged-processor-operations-to-the-subarch-layer.patch
+i386-transparent-paravirtualization-sub-arch-move-sensitive-system-definitions-into-the-sub-arch-layer.patch
+i386-transparent-paravirtualization-sub-arch-move-tlb-flush-definitions-to-the-sub-architecture-level.patch
+i386-transparent-paravirtualization-sub-arch-move-descriptor-table-management-into-the-sub-arch-layer.patch
+i386-transparent-paravirtualization-sub-arch-move-sensitive-i-o-instructions-into-the-sub-arch-layer.patch
+i386-transparent-paravirtualization-sub-arch-create-accessors-that-allow-the-i386-kernel-to-run-at.patch
+i386-transparent-paravirtualization-sub-arch-create-mmu-2-3-level-accessors-in-the-sub-arch-layer.patch

 Various x86 changes to better support paravirtualisation.  Needs some
 discussion.

+x86_64-create-sysfs-entries-for-cpu-only-for-present-cpus.patch
+x86_64dont-call-enforce_max_cpus-when-hotplug-is-enabled.patch
+x86_64fix-cluster-mode-send_ipi_allbutself-to-use-get_cpu-put_cpu.patch
+x86_64dont-do-broadcast-ipis-when-hotplug-is-enabled-in-flat-mode.patch
+x86_64dont-use-lowest-priority-when-using-physical-mode.patch
+x86_64use-common-functions-in-cluster-and-physflat-mode.patch
+x86_64-choose-physflat-for-amd-systems-only-when-8-cpus.patch

 x86_64 udpates

+swsusp-add-locking-to-software_resume.patch

 swsusp fix

+3c59x-pm-fixes.patch

 net driver power management fixes

+uml-remove-debugging-code-from-page-fault-path.patch
+uml-support-sysemu-slight-cleanup-and-speedup.patch

 uml updates

+relayfs-api-cleanup.patch
+relayfs-add-read-support.patch
+relayfs-add-read-support-fix.patch
+relayfs-update-documentation.patch

 Add read() support back to relayfs

+new-driver-for-yealink-usb-p1k-phone-endianness-fix.patch

 Fix new-driver-for-yealink-usb-p1k-phone.patch

+s390-fix-invalid-kmalloc-flags.patch
+fix-invalid-kmalloc-flags-gfp_dma-alone.patch

 Bare GFP_DMA isn't allowed now.

+sonypi-spic-initialisation-fix.patch
+sonypi-remove-obsolete-event.patch

 sonypi driver updates

+optimize-writer-path-in-time_interpolator_get_counter.patch

 Somewhat fix a sort-of livelock in the time interpolation code

+pnp-make-pnp_dbg-conditional-directly-on-config_pnp_debug.patch

 PNP fix

+readahead-reset-cahe_hit-earlier.patch

 readahead fixlet

+meye-use-dma-mapping-constants.patch

 driver cleanup

+sunrpc-cache_register-can-use-wrong-module-reference.patch

 sunrpc fix

+ipc-add-generic-struct-ipc_ids-seq_file-iteration.patch
+ipc-convert-proc-sysvipc-to-generic-seq_file-interface.patch

 ipc /proc cleanups

+flush-icache-early-when-loading-module.patch

 module loading fix

+speedup-fat-filesystem-directory-reads-2.patch

 fatfs speedup

+i810_audio-fix-release_region-misordering-in-error-exit-from-i810_probe.patch

 Fix i810_audio error path

+schedule_timeout_uninterruptible.patch

 Add schedule_timeout_interruptible() and schedule_timeout_uninterruptible()

+pnpacpi-fix-irq-and-64-bit-address-decoding.patch

 PNP fix

+modified-firmware_classc-to-support-no-hotplug.patch
+dell_rbu-new-dell-bios-update-driver.patch

 The Dell remote BIOS update driver (again)

+fsnotify-hook-on-removexattr-too.patch

 fsnotify API completeness

+create_workqueue_thread-signedness-fix.patch

 signedness fix

+proc-link-count-fix.patch

 Fix link counts in /proc

+add-rdinit-parameter-to-pick-early-userspace-init.patch

 Add separate `rdinit=' parameter

+aio-kiocb-locking-to-serialise-retry-and-cancel.patch

 AIO locking fix

+cleanup-of-deadline_dispatch_requests.patch

 deadline cleanup

+introduce-and-use-kzalloc.patch
+ia64-convert-kcalloc-to-kzalloc.patch
+ppc64-convert-kcalloc-to-kzalloc.patch
+input-convert-kcalloc-to-kzalloc.patch
+usb-convert-kcalloc-to-kzalloc.patch
+pci-convert-kcalloc-to-kzalloc.patch
+drivers-convert-kcalloc-to-kzalloc.patch
+fs-convert-kcalloc-to-kzalloc.patch
+alsa-convert-kcalloc-to-kzalloc.patch

 Add and use kzalloc()

+ipmi-add-per-channel-ipmb-addresses.patch
+ipmi-high-res-timer-support-fixes.patch
+ipmi-watchdog-nmi-interaction-fixes.patch
+ipmi-allow-userland-to-include-ipmih.patch
+ipmi-oem-flag-handling-and-hacks-for-some-dell-machines.patch
+ipmi-clean-up-versioning-of-the-ipmi-driver.patch

 IPMI driver updates

+hfs-remove-debug-code.patch
+hfs-show_options-support.patch
+hfs-nls-support.patch

 HFS filesystem updates

+sd-scr-register-fix-a-bit-byte-counting-error-in-the-mmc-sd-code.patch
+add-write-protection-switch-handling-to-the-pxa-mmc-driver.patch

 Secure digital driver updates and fixes

+corgi-add-keyboard-and-touchscreen-device-definitions.patch
+corgi-add-mmc-sd-write-protection-switch-handling.patch

 More Corgi additions

+fix-smsc_ircc_init-return-value.patch

 smsc driver fix

+debug-preempt-tracing.patch
+debug-preempt-tracing-fix.patch
+debug-preempt-tracing-fix-2.patch
+debug-preempt-tracing-fix-3.patch

 Add new debug code which can be used to hunt down locking errors.

+mips-build-fix-for-spinlock-consolidation.patch

 Fix spinlock-consolidation.patch

+slab-leak-detector-give-longer-traces.patch

 Add longer stack backtraces to the slab leak detector

+device-suspend-debug.patch

 Add a bit of debugging to device_suspend()

+sched-dont-kick-alb-in-the-presence-of-pinned-task.patch

 CPU scheduler fix

-cachefs-filesystem.patch
-cachefs-documentation.patch
-add-page-becoming-writable-notification.patch
-fix-page-becoming-writable-in-do_wp_page.patch
-fix-page-becoming-writable-vm_page_prot.patch
-fix-page-becoming-writable-in-do_file_page.patch
 provide-a-filesystem-specific-syncable-page-bit.patch
-make-afs-use-cachefs.patch
-split-general-cache-manager-from-cachefs.patch
-split-general-cache-manager-from-cachefs-fs-fscache-cleanups.patch
-turn-cachefs-into-a-cache-backend.patch
-rework-the-cachefs-documentation-to-reflect-fs-cache-split.patch
-update-afs-client-to-reflect-cachefs-split.patch
-make-page-becoming-writable-notification-a-vma-op-only-kafs-fix.patch
-fscache-menuconfig-help-fix-documentation-path.patch

 Dropped

+fbdev-dont-allow-softcursor-use-from-userland.patch
+fbdev-mach64-atari-patch.patch

 fbdev updates

+md-fix-minor-error-in-raid10-read-balancing-calculation.patch
+md-fail-io-request-to-md-that-require-a-barrier.patch

 MD updates

+update-documentation-docbook-kernel-hackingtmpl.patch
+documentation-how-to-apply-patches-for-various-trees.patch

 Documentation fixes

-drivers-scsi-aic7xxx-possible-cleanups.patch

 Dropped - too hard to maintain as the aic drivers are being worked on.

+include-asm-arm26-hardirqh-remove-define-irq_enter.patch
+remove-sound-oss-skeletonc.patch
+drivers-char-lpc-use-of-the-time_after-macro.patch
+spelling-and-whitespace-fixes-for-reporting-bugs.patch
+remove-invalid-comment-in-mm-page_allocc.patch
+include-asm-i386-extern-inline-static-inline.patch
+extern-inline-static-inline.patch
+include-linux-bioh-extern-inline-static-inline.patch

 Little fixes

-drivers-net-sk98lin-possible-cleanups.patch

 Dropped, I think.  Rejects.

-remove-linux-versionh-includes.patch
-remove-linux-versionh-from-drivers-net.patch
-remove-linux-versionh-from-drivers-scsi.patch
-move-kernel_version-from-linux-versionh-to-linux-utsnameh.patch
-move-kernel_version-from-linux-versionh-to-linux-utsnameh-fix.patch
-move-kernel_version-from-linux-versionh-to-linux-utsnameh-fix-2.patch
-move-kernel_version-from-linux-versionh-to-linux-utsnameh-fix-3.patch
-move-kernel_version-from-linux-versionh-to-linux-utsnameh-fix-4.patch
-move-kernel_version-from-linux-versionh-to-linux-utsnameh-fix-5.patch
-remove-linux-versionh-include-for-mm.patch
-remove-linux-versionh-from-net-ieee80211.patch
-remove-linux-versionh-from-drivers-scsi-for-mm.patch
-remove-linux-versionh-from-drivers-net-for-mm.patch

 Drop these - they're causing tons of patch maintenance grief as everything
 else changes.  Plus various little bits of the above keep on getting merged
 into the subsystem trees.


All 683 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc5/2.6.13-rc5-mm1/patch-list

