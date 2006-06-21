Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWFUKtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWFUKtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWFUKtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:49:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751365AbWFUKtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:49:05 -0400
Date: Wed, 21 Jun 2006 03:48:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm1
Message-Id: <20060621034857.35cfe36f.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/


- powerpc is bust (on g5, at least).  git-klibc is causing nash to fail on
  startup and some later patch is causing a big crash (I didn't bisect that
  one - later).

- ia64 doesn't compile for me, due to git-klibc problems (a truly ancient
  toolchain might be implicated).

- git-sas.patch has been dropped due to build failures.

- git-s390.patch has been dropped due to patching rejects





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




Changes since 2.6.17-rc6-mm2:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-block.patch
 git-cifs.patch
 git-cpufreq.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-infiniband.patch
 git-input.patch
 git-jfs.patch
 git-kbuild.patch
 git-klibc.patch
 git-hdrinstall2.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-pcmcia.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 git trees

-further-alterations-for-memory-barrier-document.patch
-powernow-k8-crash-workaround.patch
-bugfixes-to-get-i2o-working-again.patch
-fix-possible-oops-in-cs4281-irq-handler.patch
-trivial-videodev2h-patch.patch
-zoran-strncpy-cleanup.patch
-scx200_acb-use-pci-i-o-resource-when-appropriate.patch
-i2c-pca954x-i2c-mux-driver.patch
-i2c-pca954x-fix-initial-access-to-first-mux-switch-port.patch
-ieee1394-video1394-be-quiet.patch
-ieee1394-ohci1394c-function-calls-without.patch
-ieee1394-sbp2-make-tsb42aa9-workaround-specific.patch
-ieee1394-semaphore-to-mutex-conversion.patch
-ieee1394-raw1394-fix-whitespace-after-x86_64.patch
-ieee1394-ieee1394-ohci1394-cycletoolong.patch
-ieee1394-ieee1394-support-for-slow-links-or-slow.patch
-ieee1394-ieee1394-save-ram-by-using-a-single.patch
-ieee1394-sbp2-remove-manipulation-of-inquiry.patch
-ieee1394-sbp2-log-number-of-supported-concurrent.patch
-ieee1394-ieee1394-extend-lowlevel-api-for.patch
-ieee1394-ohci1394-set-address-range-properties.patch
-ieee1394-ohci1394-make-phys_dma-parameter.patch
-ieee1394-sbp2-sbp2-remove-ohci1394-specific.patch
-ieee1394-sbp2-fix-s800-transfers-if-phys_dma-is.patch
-ieee1394-update-feature-removal-of-obsolete.patch
-ieee1394-sbp2-provide-helptext-for.patch
-ieee1394-sbp2-kconfig-fix.patch
-ieee1394-sbp2-use-__attribute__packed-for.patch
-ieee1394-speed-up-of-dma_region_sync_for_cpu.patch
-ieee1394-sbp2-fix-deregistration-of-status-fifo-address-space.patch
-ieee1394-add-preprocessor-constant-for-invalid-csr.patch
-fix-broken-suspend-resume-in-ohci1394-was-acpi-suspend.patch
-ieee1394_core-switch-to-kthread-api.patch
-eth1394-endian-fixes.patch
-ieee1394-hl_irqs_lock-is-taken-in-hardware.patch
-ieee1394-adjust-code-formatting-in.patch
-git-kbuild-modpost-build-fix.patch
-git-klibc-ia64-build-fix.patch
-git-hdrcleanup.patch
-git-hdrcleanup-fixup.patch
-libata-add-missing-data_xfer-for-pata_pdc2027x-and-pdc_adma.patch
-sata_sil24-endian-anotations.patch
-sdhci-truncated-pointer-fix.patch
-git-netdev-all-fixup.patch
-smc911x-Kconfig-fix.patch
-e1000-prevent-statistics-from-getting-garbled-during-reset.patch
-forcedeth-config-ring-sizes.patch
-forcedeth-config-flow-control.patch
-forcedeth-config-phy.patch
-forcedeth-config-wol.patch
-forcedeth-config-csum.patch
-forcedeth-config-statistics.patch
-forcedeth-config-diagnostics.patch
-forcedeth-config-module-parameters.patch
-forcedeth-config-version.patch
-forcedeth-new-device-ids.patch
-ipw2200-locking-fix.patch
-forcedeth-xmit_lock-went-away.patch
-client-side-nfsacl-caching-fix.patch
-nfs-really-return-status-from-decode_recall_args.patch
-gregkh-pci-pci-add-pci_cap_id_vndr.patch
-gregkh-pci-pci-fix-pciehp-compile-issue-when-config_acpi-is-not-enabled.patch
-remove-drivers-scsi-constantscscsi_print_req_sense.patch
-scsi-remove-documentation-scsi-cpqfctxt.patch
-mpt-fusion-driver-initialization-failure-fix.patch
-drivers-scsi-use-array_size-macro.patch
-hptiop-highpoint-rocketraid-3xxx-controller-driver.patch
-remove-the-scsi_request-interface-from-the-gdth-driver.patch
-git-scsi-target-warning-fix.patch
-mm-x86_64-mm-polling-thread-status-fix.patch
-x86_64-setupc-print-cmp-related-boottime-information.patch
-alpha-generic-hweight-build-fix.patch
-add-__iowrite64_copy.patch
-add-__iowrite64_copy-s390-fix.patch
-inotify-split-kernel-api-from-userspace-support.patch
-inotify-add-names-inode-to-event-handler.patch
-inotify-add-interfaces-to-kernel-api.patch
-inotify-allow-watch-removal-from-event-handler.patch
-inotify-update-kernel-documentation.patch
-sound-vxpocket-fix-printk-warning.patch

 Merged into mainline or a subsystem tree

+uml-fix-wall_to_monotonic-initialization.patch
+sparc-build-breakage.patch
+ntfs-critical-bug-fix-affects-mips-and-possibly-others.patch
+selinux-add-hooks-for-key-subsystem.patch
+keys-fix-race-between-two-instantiators-of-a-key.patch
+suspend_console-warning-fix.patch
+myri10ge-build-fix.patch

 to-merge-asap queue.

+git-acpi-pre.patch
+git-acpi-post.patch

 Things to make git-acpi easier to apply.

+git-acpi-fixup.patch

 Fix reject due to git-apci.

+git-acpi-ia64-build-fix.patch

 Fix git-acpi build error
 
+pnpacpi-reject-acpi_producer-resources.patch
+acpi-add-ibm-r60e-laptop-to-proc-idle-blacklist.patch
+acpi-c-states-accounting-of-sleep-states.patch
+acpi-c-states-bm_activity-improvements.patch
+acpi-c-states-only-demote-on-current-bus-mastering-activity.patch

 ACPI patches.

+acpi-sony-add-fn-hotkey-support.patch

 2.6-sony_acpi4.patch feature

+ati-agp-build-fix.patch

 Fix git-agpgart.patch

-git-cpufreq-fixup.patch

 Unneeded

+gregkh-driver-make_class_name-kobj.patch
+gregkh-driver-device-class.patch
+gregkh-driver-driver-core-add-generic-subsystem-link-to-all-devices.patch
+gregkh-driver-device-symlinks-for-classes.patch
+gregkh-driver-driver-core-make-dev_info-and-friends-print-the-bus-name-if-there-is-no-driver.patch
+gregkh-driver-driver-model-add-isa-bus.patch

 driver tree updates

+saa7134-card-lifeview3000-ntsc.patch
+tea575x-tuner-build-fix.patch
+git-dvb-versus-matroxfb.patch
+git-dvb-printk-warning-fix.patch

 Fix git-dvb.patch

+gregkh-i2c-i2c-opencores-cleanup.patch
+gregkh-i2c-i2c-mark-data-const-for-write-block.patch
+gregkh-i2c-i2c-scx200_acb-use-PCI-IO-resource-when-appropriate.patch
+gregkh-i2c-i2c-scx200_acb-mark-scx200_acb_probe-init.patch
+gregkh-i2c-i2c-scx200_acb-documentation-update.patch
+gregkh-i2c-i2c-i801-01-fix-block-transaction-poll-loops.patch
+gregkh-i2c-i2c-i801-02-remove-force_addr-parameter.patch
+gregkh-i2c-i2c-i801-03-remove-pci-function-check.patch
+gregkh-i2c-i2c-i801-04-cleanups.patch
+gregkh-i2c-i2c-i801-05-better-pci-subsystem-integration.patch
+gregkh-i2c-i2c-i801-06-merge-setup-function.patch
+gregkh-i2c-hwmon-kconfig-header-fix.patch
+gregkh-i2c-hwmon-lm70-new-driver.patch
+gregkh-i2c-hwmon-vid-add-core-and-conroe-support.patch
+gregkh-i2c-i2c-i2c-controllers-go-into-right-place-on-sysfs.patch

 I2C tree updates

+i2c-801-64bit-resource-fix.patch

 Fix it.

+git-infiniband-fixup.patch

 Fix reject in git-infiniband.patch

+input-mouse-sermouse-fix-memleak-and-potential-buffer-overflow.patch

 input fix

+revert-sparc-build-breakage.patch

 Make git-klibc.patch easier to apply.

+git-klibc-fixup.patch

 Fix rejects in git-klibc.patch

-git-hdrinstall.patch
+git-hdrinstall2.patch

 Renamed

-revert-sata_sil24-sii3124-sata-driver-endian-problem.patch

 Dropped

+git-libata-all-fixup.patch
+git-libata-all-data_xfer-fixes.patch
+git-libata-all-data_xfer-fixes-fixes.patch
+git-libata-pata_cs5535-is-bust.patch

 Fix git-libata-all.patch

+via-pata-fails-on-some-atapi-drives.patch
+via-pata-fails-on-some-atapi-drives-tidy.patch

 ATA fix

-git-mtd-fixup.patch

 Unneeded

+ni5010-netcard-cleanup.patch

 netdev cleanup

-git-net-git-klibc-fixup.patch

 Unneeded

+netpoll-dont-spin-forever-sending-to-blocked-queues.patch
+netpoll-break-recursive-loop-in-netpoll-rx-path.patch
+irda-add-some-ibm-think-pads.patch
+atm-mpcc-warning-fix.patch

 net fixes

+git-nfs-build-fixes.patch
+nfs-build-fix-99.patch

 Fix git-nfs.patch wreckage

+nfs-remove-nfs_put_link.patch

 nfs cleanup

-git-sas.patch

 Dropped

+serial-add-tsi108-8250-serial-support.patch
+8250_pnp-add-support-for-other-wacom-tablets.patch
+serial-8250-sysrq-deadlock-fix.patch

 Serial things

+gregkh-pci-64bit-resource-c99-changes-for-struct-resource-declarations.patch
+gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-sound-drivers.patch
+gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-networks-drivers.patch
+gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-pci-core-and-hotplug-drivers.patch
+gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-mtd-drivers.patch
+gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-ide-drivers.patch
+gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-video-drivers.patch
+gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-pcmcia-drivers.patch
+gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-arch-and-core-code.patch
+gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-misc-drivers.patch
+gregkh-pci-64bit-resource-introduce-resource_size_t-for-the-start-and-end-of-struct-resource.patch
+gregkh-pci-64bit-resource-change-resource-core-to-use-resource_size_t.patch
+gregkh-pci-64bit-resource-change-pci-core-and-arch-code-to-use-resource_size_t.patch
+gregkh-pci-64bit-resource-change-pnp-core-to-use-resource_size_t.patch
+gregkh-pci-64bit-resource-convert-a-few-remaining-drivers-to-use-resource_size_t-where-needed.patch
+gregkh-pci-64bit-resource-finally-enable-64bit-resource-sizes.patch
+gregkh-pci-i386-export-memory-more-than-4g-through-proc-iomem.patch
-gregkh-pci-pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch
-gregkh-pci-pci-legacy-i-o-port-free-driver-update-documentation-pci_txt.patch
-gregkh-pci-pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free.patch
-gregkh-pci-pci-legacy-i-o-port-free-driver-make-emulex-lpfc-driver-legacy-i-o-port-free.patch
-gregkh-pci-pci-64-bit-resources-core-changes.patch
-gregkh-pci-pci-64-bit-resources-drivers-pci-changes.patch
-gregkh-pci-pci-64-bit-resources-drivers-ide-changes.patch
-gregkh-pci-pci-64-bit-resources-drivers-media-changes.patch
-gregkh-pci-pci-64-bit-resources-drivers-net-changes.patch
-gregkh-pci-pci-64-bit-resources-drivers-pcmcia-changes.patch
-gregkh-pci-pci-64-bit-resources-drivers-others-changes.patch
-gregkh-pci-pci-64-bit-resources-sound-changes.patch
-gregkh-pci-pci-64-bit-resources-arch-changes.patch
-gregkh-pci-pci-64-bit-resources-arch-powerpc-changes.patch
-gregkh-pci-pci-64-bit-resources-more-drivers-others-changes.patch
-gregkh-pci-pci-64-bit-resources-more-sound-changes.patch
-gregkh-pci-pci-64-bit-resources-drivers-pci-changes-sparc32-fix.patch
-gregkh-pci-pci-64-bit-resource-fixup-pci-resource-dbg-code-to-handle-size-change.patch
-gregkh-pci-pci-64-bit-resource-fix-amba-build-warning.patch
-gregkh-pci-pci-64-bit-resources-fix-pnp-sysfs-interface.patch
-gregkh-pci-pci-64-bit-resources-arch-powerpc-changes-update.patch
-gregkh-pci-pci-64-bit-resource-drivers-mips-changes.patch
-gregkh-pci-kconfigurable-resources-core-changes.patch
-gregkh-pci-kconfigurable-resources-driver-pci-changes.patch
-gregkh-pci-kconfigurable-resources-driver-others-changes.patch
-gregkh-pci-kconfigurable-resources-arch-dependent-changes.patch
-gregkh-pci-kconfigurable-resources-arch-dependent-changes-arch.patch
-gregkh-pci-kconfigurable-resources-arch-dependent-changes-arch-q-z.patch
-gregkh-pci-i386-export-memory-more-than-4g-through-proc-iomem.patch
-gregkh-pci-pci-msi-abstractions-and-support-for-altix.patch
-gregkh-pci-pci-per-platform-ia64_-first-last-_device_vector-definitions.patch
-gregkh-pci-pci-altix-msi-support.patch
-gregkh-pci-pci-error-handling-on-pci-device-resume.patch
+gregkh-pci-pci-hotplug-don-t-use-acpi_os_free.patch
-gregkh-pci-pci-improve-pci-config-space-writeback.patch
-gregkh-pci-pci-reverse-pci-config-space-restore-order.patch
-gregkh-pci-pci-add-pci_assign_resource_fixed-allow-fixed-address-assignments.patch
-gregkh-pci-pci-add-a-enable-sysfs-attribute-to-the-pci-devices-to-allow-userspace-to-enable-devices-without-doing-foul-direct-access.patch
-gregkh-pci-pci-don-t-enable-device-if-already-enabled.patch
-gregkh-pci-pci-acpi-rename-the-functions-to-avoid-multiple-instances.patch
-gregkh-pci-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms.patch
-gregkh-pci-pci-i386-x86_84-disable-pci-resource-decode-on-device-disable.patch
-gregkh-pci-pci-bus-parity-status-broken-hardware-attribute-edac-foundation.patch
-gregkh-pci-pci-hotplug-fix-recovery-path-from-errors-during-pcie_init.patch
+gregkh-pci-pci-hotplug-fake-null-pointer-dereferences-in-ibm-hot-plug-controller-driver.patch
+gregkh-pci-pci-hotplug-fix-recovery-path-from-errors-during-pcie_init.patch
+gregkh-pci-pci-add-pci_cap_id_vndr.patch
+gregkh-pci-pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch
+gregkh-pci-pci-legacy-i-o-port-free-driver-update-documentation-pci_txt.patch
+gregkh-pci-pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free.patch
+gregkh-pci-pci-legacy-i-o-port-free-driver-make-emulex-lpfc-driver-legacy-i-o-port-free.patch
+gregkh-pci-pci-msi-abstractions-and-support-for-altix.patch
+gregkh-pci-pci-per-platform-ia64_-first-last-_device_vector-definitions.patch
+gregkh-pci-pci-altix-msi-support.patch
+gregkh-pci-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms.patch
+gregkh-pci-pci-fix-to-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms.patch
+gregkh-pci-pci-add-pci_assign_resource_fixed-allow-fixed-address-assignments.patch
+gregkh-pci-pci-add-a-enable-sysfs-attribute-to-the-pci-devices-to-allow-userspace-to-enable-devices-without-doing-foul-direct-access.patch
+gregkh-pci-pci-don-t-enable-device-if-already-enabled.patch
+gregkh-pci-pci-acpi-rename-the-functions-to-avoid-multiple-instances.patch
+gregkh-pci-pci-i386-x86_84-disable-pci-resource-decode-on-device-disable.patch
+gregkh-pci-pci-bus-parity-status-broken-hardware-attribute-edac-foundation.patch
-gregkh-pci-pci-hotplug-fake-null-pointer-dereferences-in-ibm-hot-plug-controller-driver.patch
+gregkh-pci-pci-fix-memory-leak-in-mmconfig-error-path.patch
+gregkh-pci-pci-bus-parity-status-sysfs-interface.patch
+gregkh-pci-pci-fix-issues-with-extended-conf-space-when-mmconfig-disabled-because-of-e820.patch
+gregkh-pci-pci-nvidia-quirk-to-make-aer-pci-e-extended-capability-visible.patch

 PCI tree changes.  Some of it was merged, I think.
-mm-gregkh-pci-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms-fix.patch
+64-bit-resources-lose-some-ifdefs.patch

 Fix it.

+clear-abnormal-poweroff-flag-on-via-southbridges-fix-resume.patch
+clear-abnormal-poweroff-flag-on-via-southbridges-fix-resume-fix.patch

 VIA fix

-git-pcmcia-fixup.patch
-git-pcmcia-fixup-2.patch

 Unneeded

+com20020_cs-more-device-support.patch
+kill-open-coded-offsetof-in-cm4000_csc-zero_dev.patch

 PCMCIA work

-megaraid_sas-switch-fw_outstanding-to-an-atomic_t.patch
-megaraid_sas-add-support-for-zcr-controller.patch
-megaraid_sas-add-support-for-zcr-controller-fix.patch
+megaraid_sas-zcr-with-fix.patch

 Updated patch

+megaraid-dell-cerc-ata100-4ch-support.patch

 megaraid-old device support.

+gregkh-usb-airprime.c-add-kyocera-wireless-kpc650-passport-support.patch
+gregkh-usb-usb-io_edgeport-touch-up.patch
+gregkh-usb-usb-update-usbmon-fix-glued-lines.patch
+gregkh-usb-usb-implement-error-event-in-usbmon.patch
+gregkh-usb-usb-update-usbmontxt.patch
+gregkh-usb-usb-new-driver-for-cypress-cy7c63xxx-mirco-controllers.patch
+gregkh-usb-usb-trivial-debug-message-correction-in-gadget-ether-driver.patch
+gregkh-usb-usb-serial-clean-tty-fields-on-failed-device-open.patch
+gregkh-usb-usb-gadget-serial-fix-a-deadlock-when-closing-the-serial-device.patch
+gregkh-usb-usb-gadget-serial-do-not-save-restore-irq-flags-in-gs_close.patch
+gregkh-usb-usb-gadget-allow-drivers-support-speeds-higher-than-full-speed.patch
+gregkh-usb-usb-gadget-fix-compile-errors.patch
+gregkh-usb-usb-gadget-update-pxa2xx_udc.c-driver-to-fully-support-ixp4xx-platform.patch
+gregkh-usb-usbserial-fixes-wrong-return-values.patch
+gregkh-usb-usb-unusual_devs-entry-for-nokia-n80.patch
+gregkh-usb-usb-whitespace-removal-from-usb-gadget-ether.patch
+gregkh-usb-usb-move-linux-usb_cdc.h-to-linux-usb-cdc.h.patch
+gregkh-usb-usb-move-hardware-specific-linux-usb_-.h-to-linux-usb-.h.patch
+gregkh-usb-usb-move-linux-usb_input.h-to-linux-usb-input.h.patch
+gregkh-usb-usb-endpoint.patch
+gregkh-usb-usb-endpoint-pass-struct-device.patch
+gregkh-usb-usb-endpoint-mess.patch
+gregkh-usb-usb-devio-class-to-device.patch
+gregkh-usb-usb-class-device-to-device.patch
+gregkh-usb-usb-dynamic-usb-class.patch

 USB tree updates

+usb-move-linux-usb_input.h-to-linux-usb-input-fix.patch
+ehci-fix-bogus-alteration-of-a-local-variable.patch
+ipaqc-bugfixes.patch
+ipaqc-timing-parameters.patch
+ipaqc-timing-parameters-fix.patch

 USB things

+x86_64-mm-twofish-cipher---split-out-common-c-code.patch
+x86_64-mm-twofish-cipher---priority-fix.patch
+x86_64-mm-twofish-cipher---i586-assembler.patch
+x86_64-mm-twofish-cipher---x86_64-assembler.patch
+x86_64-mm-unify-cpu-boottime-output.patch

 x86_64 tree udpates

+revert-x86_64-mm-twofish-cipher---x86_64-assembler.patch
+revert-x86_64-mm-twofish-cipher---i586-assembler.patch
+revert-x86_64-mm-twofish-cipher---priority-fix.patch
+revert-x86_64-mm-twofish-cipher---split-out-common-c-code.patch

 Drop most of it again.

+xfs-remove-dir-check-in-xfs_link.patch
+xfs-use-container_of-in-vn_from_inode.patch
+xfs-pass-inode-to-xfs_ioc_space.patch
+xfs-remove-unused-behaviour-lock.patch

 XFS fixlets

-zone-init-check-and-report-unaligned-zone-boundaries.patch
-x86-align-highmem-zone-boundaries-with-numa.patch
-zone-allow-unaligned-zone-boundaries.patch
-zone-allow-unaligned-zone-boundaries-x86-add-zone-alignment-qualifier.patch
+zone-handle-unaligned-zone-boundaries.patch

 Updated patch

+pgdat-allocation-for-new-node-add-export-kswapd-start-func-fix.patch

 Fix pgdat-allocation-for-new-node-add-export-kswapd-start-func.patch

+add-page_mkwrite-vm_operations-method-fix.patch

 Fix add-page_mkwrite-vm_operations-method.patch

+slab-kmalloc-kzalloc-comments-cleanup-and-fix.patch
+kernel-doc-for-mm-filemapc.patch
+delete-unused-definitions-of-kvaddr_to_nid.patch
+printk-should-not-be-called-under-zone-lock.patch

 MM things

-page-migration-simplify-migrate_pages-tweaks.patch

 Foded into page-migration-simplify-migrate_pages.patch

-page-migration-detailed-status-for-moving-of-individual-pages.patch
-page-migration-support-moving-of-individual-pages-fixes.patch

 Folded into page-migration-support-moving-of-individual-pages.patch

-page-migration-support-moving-of-individual-pages-x86-support-fix.patch

 Folded into page-migration-support-moving-of-individual-pages-x86-support.patch

+radix-tree-rcu-lockless-readside.patch
+radix-tree-rcu-lockless-readside-wraning-fix.patch
+radix-tree-rcu-lockless-readside-fix.patch

 radix-tree work.

-zoned-vm-counters-per-zone-counter-functionality.patch
-zoned-vm-counters-per-zone-counter-functionality-tidy.patch
-zoned-vm-counters-per-zone-counter-functionality-fix.patch
-zoned-vm-counters-per-zone-counter-functionality-fix-fix.patch
-zoned-vm-counters-include-per-zone-counters-in-proc-vmstat.patch
-zoned-vm-counters-conversion-of-nr_mapped-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_pagecache-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_pagecache-to-per-zone-counter-fix.patch
-zoned-vm-counters-use-per-zone-counters-to-remove-zone_reclaim_interval.patch
-zoned-vm-counters-add-per-zone-counters-to-zone-node-and-global-vm-statistics.patch
-zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_pagetable-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter.patch
-zoned-vm-counters-remove-unused-get_page_stat-functions.patch
-zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter.patch
-zoned-vm-counters-remove-useless-writeback-structure.patch
-zoned-vm-stats-remove-nr_mapped-from-zone-reclaim.patch
-zoned-vm-stats-add-nr_anon.patch
-light-weight-counters-framework.patch
-light-weight-counters-framework-warning-fixes.patch
-light-weight-counters-framework-fix.patch
-light-weight-counters-framework-s390-fix.patch
-light-weight-counters-framework-s390-fix-fix.patch
-light-weight-counters-framework-s390-fix-fix-fix.patch
-light-weight-counters-framework-arm-fix.patch
-light-weight-counters-framework-uml-fix.patch

 Dropped.

+selinux-add-security-hooks-to-getsetaffinity.patch
+selinux-add-security-hook-call-to-mediate-attach_task.patch

 Wire up SELinux hooks.

+frv-__user-infrastructure.patch
+frv-basic-__iomem-annotations.patch
+frv-signal-annotations.patch
+frv-sysctl-__user-annotations.patch
+frv-binfmt_elf_fdpic-__user-annotations.patch
+frv-misc-__user-annotations.patch
+frv-misc-sparse-annotations.patch
+frv-wrong-syscall.patch
+ext2-xip-wont-build-without-mmu.patch
+frv-initrd-is-grossly-broken-on-frv-never-built.patch
+frv-null-noise-removal-in-frv-xchg.patch
+frv-ieee1394-is-borken-on-frv.patch
+frv-add-missing-qualifier-to-memcpy_fromio-prototype.patch
+frv-trivial-cleanups-in-frv_ksymsc.patch
+frv-clean-frv-unistdh.patch

 FRV updates

+i386-use-c-code-for-current_thread_info.patch
+i386-extra-checks-in-show_registers.patch
+via-c7-cpu-flags.patch
+x86-compile-fix-for-asm-i386-alternativesh.patch
+clean-up-and-refactor-i386-sub-architecture-setup.patch

 x86 updates

+move-do_suspend_lowlevel-to-correct-segment.patch

 suspend fix

+m68k-typo-fix.patch
+m68k-trapsc-constraints.patch
+m68k-windfarm-is-powerpc-only-dont-do-it-on-m68k-macs.patch

 m68k updates

+s390-move-var-declarations-behind-ifdef.patch

 s390 fix

+ufs-missed-brelse-and-wrong-baseblk.patch
+ufs-one-way-to-access-super-block.patch
+ufs-fsync-implementation.patch
+ufs-make-fsck-f-happy.patch
+ufs-ubh_ll_rw_block-cleanup.patch

 More ufs fixes

+readahead-backoff-on-i-o-error.patch
+readahead-backoff-on-i-o-error-tweaks.patch
+rcu-documentation-self-limiting-updates-and-call_rcu.patch
+link-error-when-futexes-are-disabled-on-64bit-architectures.patch
+cyclades-cleanup.patch
+cyclades-cleanup-cleanup.patch
+cleanup-char-espc.patch
+autofs4-need-to-invalidate-children-on-tree-mount-expire.patch
+update-contact-information-in-credits.patch
+more-tty-cleanups-in-drivers-char.patch
+another-couple-of-alterations-to-the-memory-barrier-doc.patch
+fuse-use-misc_major.patch
+fuse-no-backgrounding-on-interrupt.patch
+fuse-add-control-filesystem.patch
+fuse-add-control-filesystem-printk-fix.patch
+fuse-add-posix-file-locking-support.patch
+fuse-ensure-flush-reaches-userspace.patch
+fuse-rename-the-interrupted-flag.patch
+fuse-add-request-interruption.patch
+mark-profile-notifier-blocks-__read_mostly.patch
+kernel-doc-warn-on-malformed-function-docs.patch
+ide-floppy-fix-debug-only-syntax-error.patch
+remove-needless-checks-in-fs-9p-vfs_inodec.patch
+kernel-doc-for-lib-bitmapc.patch
+kernel-doc-for-lib-cmdlinec.patch
+kernel-doc-for-lib-crcc.patch
+kthread-update-loopc-to-use-kthread.patch
+kthread-update-loopc-to-use-kthread-fix.patch
+kthread-convert-lock-to-use-kthread.patch
+kthread-convert-smbiod.patch
+kthread-convert-smbiod-tidy.patch
+kthread-convert-s390machc-from-kernel_thread.patch
+initramfs-docs-update.patch
+cciss-disable-device-when-returning-failure.patch
+cciss-request-all-pci-resources.patch
+cciss-announce-cciss%d-devices-with-pci-address-irq-dac-info.patch
+cciss-use-array_size-without-intermediates.patch
+cciss-fix-a-few-spelling-errors.patch
+cciss-remove-parens-around-return-values.patch
+cciss-run-through-lindent.patch
+cciss-tidy-up-product-table-indentation.patch
+i-force-joystick-remove-some-pointless-casts.patch
+affs_fill_super-%s-abuses-2.patch
+kthread-convert-stop_machine-into-a-kthread.patch
+fs-sys_poll-with-timeout-1-bug-fix.patch
+cpu-hotplug-fix-cpu_up_cancel-handling.patch
+add-select-gpio_vr41xx-for-tanbac_tb0229.patch
+#let-even-non-dumpable-tasks-access-proc-self-fd.patch
+#enable-oprofile-on-pentium-d.patch: Andi had issues
+enable-oprofile-on-pentium-d.patch
+implement-at_symlink_follow-flag-for-linkat.patch
+fix-memory-leak-in-rocketport-rp_do_receive.patch
+kernel-doc-dont-use-xml-escapes-in-text-or-man-output.patch
+kernel-doc-use-members-for-struct-fields-consistently.patch
+reed-solomon-fix-kernel-doc-comments.patch
+ktime-hrtimer-fix-kernel-doc-comments.patch
+stop-on-cpu-lost.patch
+stop-on-cpu-lost-tidy.patch
+led-add-led-heartbeat-trigger.patch
+fix-bounds-check-in-vsnprintf-to-allow-for-a-0-size-and.patch
+fix-bounds-check-in-vsnprintf-to-allow-for-a-0-size-and-tidy.patch
+implement-kasprintf.patch
+dmi-cleanup-kernel-doc-add-to-docbook.patch
+kthread-move-kernel-doc-and-put-it-into-docbook.patch
+irda-usb-printk-fix.patch
+autofs4-needs-to-force-fail-return-revalidate.patch

 Misc patches.

+keys-sort-out-key-quota-system.patch
+keys-discard-the-contents-of-a-key-on-revocation.patch
+keys-let-keyctl_chown-change-a-keys-owner.patch
+keys-allocate-key-serial-numbers-randomly.patch
+keys-restrict-contents-of-proc-keys-to-viewable-keys.patch
+keys-add-a-way-to-store-the-appropriate-context-for-newly-created-keys.patch

 Key management API updates

+reiserfs-remove-reiserfs_aio_write.patch
+reiserfs-fix-is_reusable-bitmap-check-to-not-traverse-the-bitmap-info-array.patch
+reiserfs-clean-up-bitmap-block-buffer-head-references.patch
+reiserfs-reorganize-bitmap-loading-functions.patch
+reiserfs-on-demand-bitmap-loading.patch
+reiserfs-on-demand-bitmap-loading-fix.patch
+reiserfs-use-generic_file_open-for-open-checks.patch

 reiser3 updates

+per-task-delay-accounting-taskstats-interface-fix-exit-race-in-per-task-delay-accounting.patch

 per-task delay accounting fix

+add-bcm43xx-hw-rng-support-locking-update.patch

 Fix add-bcm43xx-hw-rng-support.patch

+chardev-gpio-for-scx200-pc-8736x-whitespace.patch
+chardev-gpio-for-scx200-pc-8736x-modernize.patch
+chardev-gpio-for-scx200-pc-8736x-add-platforn_device.patch
+chardev-gpio-for-scx200-pc-8736x-device-minor.patch
+chardev-gpio-for-scx200-pc-8736x-put-gpio_dump.patch
+chardev-gpio-for-scx200-pc-8736x-add-v-command.patch
+chardev-gpio-for-scx200-pc-8736x-refactor-scx200_probe.patch
+chardev-gpio-for-scx200-pc-8736x-add-gpio-ops.patch
+chardev-gpio-for-scx200-pc-8736x-dispatch.patch
+chardev-gpio-for-scx200-pc-8736x-add-empty.patch
+chardev-gpio-for-scx200-pc-8736x-migrate-file-ops.patch
+chardev-gpio-for-scx200-pc-8736x-migrate-gpio_dump.patch
+chardev-gpio-for-scx200-pc-8736x-add-new-pc8736x_gpio.patch
+chardev-gpio-for-scx200-pc-8736x-add-platform_device.patch
+chardev-gpio-for-scx200-pc-8736x-use-dev_dbg.patch
+chardev-gpio-for-scx200-pc-8736x-fix-gpio_current.patch
+chardev-gpio-for-scx200-pc-8736x-replace-spinlocks.patch
+chardev-gpio-for-scx200-pc-8736x-display-pin.patch
+chardev-gpio-for-scx200-pc-8736x-add-proper.patch

 GPIO driver framework.

+isdn4linux-gigaset-base-driver-improve-error-recovery.patch
+isdn4linux-gigaset-driver-cleanup.patch
+i4l-gigaset-drivers-add-ioctls-to-compat_ioctlh.patch

 i4l driver updates

-mm-implement-swap-prefetching-fix.patch
-mm-implement-swap-prefetching-sched-batch.patch
-swap-prefetch-fix-lru_cache_add_tail.patch
-swap-prefetch-fix-lru_cache_add_tail-tidy.patch
-mm-swap-prefetch-fix-lowmem-reserve-calc.patch

 Folded into mm-implement-swap-prefetching.patch

-swap_prefetch-conversion-of-nr_mapped-to-per-zone-counter.patch
-swap_prefetch-conversion-of-nr_slab-to-per-zone-counter.patch
-swap_prefetch-conversion-of-nr_dirty-to-per-zone-counter.patch
-swap_prefetch-conversion-of-nr_writeback-to-per-zone-counter.patch
-swap_prefetch-conversion-of-nr_unstable-to-per-zone-counter.patch
-swap_prefetch-remove-unused-get_page_stat-functions.patch
-zoned-vm-stats-nr_slab-is-accurate-fix-comment.patch
-swap_prefetch-zoned-vm-stats-add-nr_anon.patch

 Dropped.

+pi-futex-futex_lock_pi-futex_unlock_pi-support-fix.patch

 Fix pi-futex-futex_lock_pi-futex_unlock_pi-support.patch

+ecryptfs-dont-muck-with-the-existing-nameidata-structures.patch
+ecryptfs-asm-scatterlisth-linux-scatterlisth.patch
+ecryptfs-support-for-larger-maximum-key-size.patch
+ecryptfs-add-codes-for-additional-ciphers.patch
+ecryptfs-unencrypted-key-size-based-on-encrypted-key-size.patch
+ecryptfs-packet-and-key-management-update-for-variable-key-size.patch
+ecryptfs-add-ecryptfs_-prefix-to-mount-options-key-size-parameter.patch
+ecryptfs-set-the-key-size-from-the-default-for-the-mount.patch
+ecryptfs-check-for-weak-keys.patch
+ecryptfs-add-define-values-for-cipher-codes-from-rfc2440-openpgp.patch
+ecryptfs-convert-bits-to-bytes.patch
+ecryptfs-more-elegant-aes-key-size-manipulation.patch
+ecryptfs-more-elegant-aes-key-size-manipulation-tidy.patch
+ecryptfs-more-intelligent-use-of-tfm-objects.patch

 ecryptfs updates

+ipc-namespace-core-unshare-fix.patch
+ipc-namespace-utils-compilation-fix.patch

 Update IPC namespace patches in -mm.

+task-watchers-task-watchers.patch
+task-watchers-task-watchers-tidy.patch
+task-watchers-register-process-events-task-watcher.patch
+task-watchers-refactor-process-events.patch
+task-watchers-make-process-events-configurable-as.patch
+task-watchers-allow-task-watchers-to-block.patch
+task-watchers-register-audit-task-watcher.patch
+task-watchers-register-per-task-delay-accounting.patch
+task-watchers-register-profile-as-a-task-watcher.patch
+task-watchers-add-support-for-per-task-watchers.patch
+task-watchers-add-support-for-per-task-watchers-warning-fix.patch
+task-watchers-register-semundo-task-watcher.patch
+task-watchers-register-per-task-semundo-watcher.patch

 API for registering against task lifecycle events.

+ipc-replace-kmalloc-and-memset-in-get_undo_list-with-kzalloc.patch

 Cleanup

-readahead-backoff-on-i-o-error.patch

 Dropped.

-reiser4-conversion-of-nr_dirty-to-per-zone-counter.patch

 Dropped.

+hpt370-clean-up-dma-timeout-handling.patch
+hpt370-clean-up-dma-timeout-handling-cleanup.patch
+pdc202xx_old-depends-on-config_blk_dev_idedma.patch
+remove-code-that-has-long-been-commented-out-from-pdc20265_old.patch
+enable-cdrom-dma-access-with-pdc20265_old.patch
+ide-fix-revision-comparison-in-ide_in_drive_list.patch

 IDE updates

+fbdev-fix-logo-rotation-if-width-=-height.patch
+macmodes-fix-section-warning.patch
+atyfb-fix-section-warnings.patch

 fbdev updates

-vt-binding-add-sysfs-support.patch

 Dropped.

+vt-binding-add-sysfs-control-to-the-vt-layer.patch
+vt-binding-add-sysfs-control-to-the-vt-layer-fix.patch
+vt-binding-make-vt-binding-a-kconfig-option.patch
+vt-binding-do-not-create-a-device-file-for-class-device.patch
+vt-binding-update-documentation.patch
+vt-binding-make-mdacon-support-binding.patch
+vt-binding-make-newport_con-support-binding.patch
+vt-binding-make-promcon-support-binding.patch
+vt-binding-make-sticon-support-binding.patch

 VT binding updates

+statistics-infrastructure-update-4.patch
+statistics-infrastructure-update-5.patch

 Update statistics patches in -mm.

+genirq-rename-desc-handler-to-desc-chip-terminate_irqs-fix.patch
+genirq-allow-usage-of-no_irq_chip.patch
+genirq-ia64-build-fix.patch

 genirq fixes

+lock-validator-core-provide-lockdep_off-lockdep_on-apis.patch
+lock-validator-core-provide-lockdep_reinit_key-api.patch
+lock-validator-core-print-info-not-bug.patch
+lock-validator-special-locking-af_unix-undo-af_unix-_bh-locking-changes-and-split-lock-type.patch
+lock-validator-special-locking-af_unix-undo-af_unix-_bh-locking-changes-and-split-lock-type-fix.patch
+lock-validator-annotate-ntfs-locking-rules.patch
+lock-validator-s390-stacktrace-interface.patch
+lock-validator-s390-config_frame_pointer-support.patch
+lock-validator-s390-rwsem-semaphore-changes.patch
+lock-validator-early_init_irq_lock_type--console_init.patch
+lock-validator-s390-irqtrace-support.patch
+lock-validator-__local_bh_enable-_local_bh_enable.patch
+lock-validator-s390-use-raw_spinlock-in-mcck-handler.patch
+lock-validator-add-s390-to-supported-options.patch
+lockdep-avoid-false-positive-illegal-lock-usage-message-in-qeth-driver.patch
+lockdep-hack-around-build-errors.patch

 lockdep fixes

-acpi-identify-which-device-is-not-power-manageable-fix.patch

 Folded into acpi-identify-which-device-is-not-power-manageable.patch



All 1738 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/patch-list


