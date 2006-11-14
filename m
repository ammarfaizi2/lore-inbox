Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933344AbWKNJlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344AbWKNJlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 04:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933352AbWKNJlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 04:41:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933344AbWKNJla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 04:41:30 -0500
Date: Tue, 14 Nov 2006 01:41:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc5-mm2
Message-Id: <20061114014125.dd315fff.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Presently at

http://userweb.kernel.org/~akpm/2.6.19-rc5-mm2/

and will appear later at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/



- Included the fault-injection patchset.  This is cool stuff and means that
  someone might actually be able to demonstrate a bug in the kernel.  Please
  play with it.

- A nasty Kconfig warning comes out during the build.  It's due to
  git-gfs2-nmw.patch.

- A few broken patches were dropped as a result of rc5-mm1 testing.   Thanks.




Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git-fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git tag v2.6.16-rc2-mm1
  git-checkout -b local-v2.6.16-rc2-mm1 v2.6.16-rc2-mm1

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




Changes since 2.6.19-rc5-mm2:


 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-agpgart.patch
 git-arm.patch
 git-cpufreq.patch
 git-powerpc.patch
 git-drm.patch
 git-dvb.patch
 git-gfs2-nmw.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-libata-all.patch
 git-mips.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-ioat.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-r8169.patch
 git-selinux.patch
 git-pciseg.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-sas.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-wireless.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees

-regression-in-2619-rc-microcode-driver.patch
-a-minor-fix-for-set_mb-in-documentation-memory-barrierstxt.patch
-nfsd4-reindent-do_open_lookup.patch
-nfsd4-fix-open-create-permissions.patch
-x86_64-mm-i386-reloc-data-4k-aligned.patch
-dm-fix-find_device-race.patch
-dm-suspend-fix-error-path.patch
-dm-multipath-fix-rr_add_path-order.patch
-dm-raid1-fix-waiting-for-io-on-suspend.patch
-dm-raid1-fix-waiting-for-io-on-suspend-fix.patch
-drivers-telephony-ixj-fix-an-array-overrun.patch
-tigran-has-moved.patch
-md-change-online-offline-events-to-a-single-change-event.patch
-md-fix-sizing-problem-with-raid5-reshape-and-config_lbd=n.patch
-md-do-not-freeze-md-threads-for-suspend.patch
-fix-kretprobe-booster-to-save-regs-and-set-status.patch
-backlight-and-output-sysfs-support-for-acpi-video-driver.patch
-fix-comments-style-in-acpi-videoc.patch
-fix-gregkh-driver-network-device.patch
-cpu-topology-consider-sysfs_create_group-return-value.patch
-debugfs-check-return-value-correctly.patch
-call-platform_notify_remove-later.patch
-tda826x-use-correct-max-frequency.patch
-ia64-select-acpi_numa-if-acpi.patch
-i8042-activate-panic-blink-only-in-x.patch
-drivers-cris-return-on-null-dev_alloc_skb.patch
-bonding-lockdep-annotation.patch
-com20020-build-fix.patch
-resend-iphase-64bit-cleanup.patch
-lockdep-annotate-sk_lock-nesting-in-af_bluetooth-v2.patch
-bnep-endianness-bug-filtering-by-packet-type.patch
-bnep-endianness-annotations.patch
-rfcomm-endianness-annotations.patch
-rfcomm-endianness-bug-param_mask-is-little-endian-on-the-wire.patch
-net-uninline-xfrm_selector_match.patch
-r8169-driver-corega-support-patch.patch
-pci-fix-__pci_register_driver-error-handling.patch
-acpiphp-fix-missing-acpiphp_glue_exit.patch
-acpiphp-fix-use-of-list_for_each-macro.patch
-fix-pci-sysfs-file-deletion.patch
-pci-check-szhi-when-sz-is-0-for-64-bit-pref-mem.patch
-drivers-scsi-mca_53c9xc-save_flags-cli-removal-fix.patch
-drivers-scsi-psi240ic-fix-an-array-overrun.patch
-fix-gregkh-usb-usb-expand-autosuspend-autoresume-api.patch
-correct-keymapping-on-powerbook-built-in-usb-iso-keyboards.patch
-usb-urb-unlink-free-clenup.patch
-i386-fix-recursive-faults-during-oops-when-current.patch
-x86-tif_notsc-and-seccomp-prctl.patch
-i386-mark-config_relocatable-experimental.patch
-prep-for-paravirt-be-careful-about-touching-bios.patch
-prep-for-paravirt-be-careful-about-touching-bios-warning-fix.patch
-paravirtualization-header-and-stubs-for-fix.patch
-paravirtualization-header-and-stubs-for-headers_check-fix.patch
-paravirtualization-patch-inline-replacements-for-fix-2.patch
-paravirtualization-patch-inline-replacements-for-fix-3.patch
-paravirtualization-more-generic-paravirtualization-warning-fix.patch
-i386-mm-substitute-__va-lookup-with-pfn_to_kaddr.patch
-i386-extend-bzimage-protocol-for-relocatable-protected-mode-kernel.patch
-htirq-refactor-so-we-only-have-one-function-that-writes-to-the-chip.patch
-htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers.patch
-htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers-update.patch
-x86_64-update-mmconfig-resource-insertion-to-check-against-e820-map.patch
-i386-update-mmconfig-resource-insertion-to-check-against-e820-map.patch
-fs-xfs-xfs_dmapih-removal-of-old-code.patch
-xfs-rename-uio_read.patch
-vmalloc-optimization-cleanup-bugfixes.patch
-vmalloc-optimization-cleanup-bugfixes-tweak.patch
-pci-i386-style-cleanups.patch
-setup_irq-better-mismatch-debugging.patch
-fix-ide-cs-hang-after-device-removal.patch
-patch-for-nvidia-divide-by-zero-error-for-7600.patch
-md-change-lifetime-rules-for-md-devices.patch

 Merged into mainline or a subsystem tree.

+setup_irq-better-mismatch-debugging.patch
+fix-via586-irq-routing-for-pirq-5.patch
+drivers-ide-stray-bracket.patch
+autofs4-panic-after-mount-fail.patch
+nvidiafb-fix-unreachable-code-in-nv10getconfig.patch
+usb-maintainers-updates.patch
+hugetlb-prepare_hugepage_range-check-offset-too.patch
+hugetlb-check-for-brk-entering-a-hugepage-region.patch
+ipmi-use-platform_device_add-instead-of-platform_device_register-to-register-device-allocated-dynamically.patch
+ia64-irqs-use-name-not-typename.patch

 2.6.19 queue (mostly)

-revert-generic_file_buffered_write-handle-zero-length-iovec-segments.patch
-revert-generic_file_buffered_write-deadlock-on-vectored-write.patch
-generic_file_buffered_write-cleanup.patch
-mm-only-mm-debug-write-deadlocks.patch
-mm-fix-pagecache-write-deadlocks.patch
-mm-fix-pagecache-write-deadlocks-comment.patch
-mm-fix-pagecache-write-deadlocks-xip.patch
-mm-fix-pagecache-write-deadlocks-mm-pagecache-write-deadlocks-efault-fix.patch
-fs-prepare_write-fixes.patch
-fs-prepare_write-fixes-fuse-fix.patch
-fs-prepare_write-fixes-jffs-fix.patch
-fs-prepare_write-fixes-fat-fix.patch

 These need more work.

-video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-msi-laptop-fix.patch

 Folded into video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch

+cpufreq-fix-bug-in-duplicate-freq-elimination-code-in-acpi-cpufreq.patch

 fix git-cpufreq

-git-cpufreq-build-fix.patch

 Unneeded

+cpufreq-select-consistently-re-2619-rc5-mm1.patch

 cpufreq Kconfig fix

-gregkh-driver-driver-core-add-notification-of-bus-events.patch
+gregkh-driver-debugfs-check-return-value-correctly.patch
+gregkh-driver-acpi-change-acpi-to-use-dev_archdata-instead-of-firmware_data.patch
+gregkh-driver-cpu-topology-consider-sysfs_create_group-return-value.patch
+gregkh-driver-sysfs-sysfs_write_file-writes-zero-terminated-data.patch
-gregkh-driver-uio.patch

 driver tree updates

+fix-gregkh-driver-sound-device.patch

 Fix it.

+aoe-add-forgotten-null-at-end-of-attribute-list-in-aoeblkc.patch

 AOE fix

+drm-fix-return-value-check.patch

 DRM fixlet.

+git-dvb-fixup.patch

 Fix rejects in dvt-dvb.

+drivers-media-handle-errors-from-input_register_device.patch

 DVB fixlet.
 
+jdelvare-i2c-i2c-dev-make-I2C_FUNCS-ioctl-faster.patch

 I2C tree update

+crash-on-evdev-disconnect.patch
+input-make-serio_register_driver-return-error.patch
+input-check-serio_register_driver-error.patch
+input-check-whether-serio-dirver-registration-is-completed.patch
+input-change-to-gfp_kernel-for-serio_register_driver-event-allocation.patch
+mac_emumousebtn-shouldnt-depend-on-input_adbhid.patch
+appletouch-improvements-for-macbook.patch

 input updates

+libata-convert-from-module_init-to-subsys_initcall-resend.patch
+sata_vsc-build-fix.patch
+hpt37x-check-the-enablebits.patch
+pata_artop-fix-1-typo.patch
+libata-change-order-of-_sdd-_gtf-execution-resend-3.patch

 sata/pata fixes and updates

+spidernet-remove-eth_zlen-check-in-earlier-patch.patch
+wan-dscc4-driver-requires-generic-hdlc.patch

 netdev updates

+tulip-dmfe-carrier-detection.patch

 Tulip fix

+fix-compat-space-msg-size-limit-for-msgsnd-msgrcv.patch

 compat cleanup/speedup/fix

+resend-iphase-64bit-cleanup.patch

 iphase driver 64-bit cleanup (might need more work)

-powerpc-add-efika-platform-support.patch

 Dropped

+powerpc-iseries-link-error-in-allmodconfig.patch

 powerpc build fix

+gregkh-pci-pci-make-some-msi-x-defines-generic.patch
+gregkh-pci-pci-save-restore-pci-x-state.patch
+gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g.patch
+gregkh-pci-acpiphp-fix-use-of-list_for_each-macro.patch
+gregkh-pci-acpiphp-fix-missing-acpiphp_glue_exit.patch
+gregkh-pci-pci-clear-osc-support-flags-if-no-_osc-method.patch
+gregkh-pci-pci-fix-__pci_register_driver-error-handling.patch
+gregkh-pci-pci-block-on-access-to-temporarily-unavailable-pci-device.patch
+gregkh-pci-pci-i386-style-cleanups.patch
+gregkh-pci-pci-arch-i386-kernel-pci-dma.c-ioremap-balanced-with-iounmap.patch

 PCI tree updates

+tidy-gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g.patch
+fix-gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g.patch
+fix-2-gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g.patch
+pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks-ide-fix.patch

 Fix it.

+aic94xx-dont-call-pci_map_sg-for-already-mapped-scatterlists.patch

 SAS fix

-gregkh-usb-usb-storage-unusual_devs.h-entry-for-sony-ericsson-p990i.patch
+gregkh-usb-usb-correct-keymapping-on-powerbook-built-in-usb-iso-keyboards.patch
+gregkh-usb-usb-storage-unusual_devs.h-entry-for-sony-ericsson-p990i.patch
+gregkh-usb-usb-hid-core-add-quirk-for-new-apple-keyboard-trackpad.patch
+gregkh-usb-usb-storage-remove-duplicated-unusual_devs.h-entries-for-sony-ericsson-p990i.patch
+gregkh-usb-usb-fixed-outdated-usb_get_device_descriptor-documentation.patch
+gregkh-usb-usb-ipaq-add-htc-modem-support.patch
+gregkh-usb-usb-auerswald-possible-memleak-fix.patch
+gregkh-usb-usb-net1080-fix-typos.patch
+gregkh-usb-usb-move-private-hub-declarations-out-of-public-header-file.patch
+gregkh-usb-usb-gadget-ether.c-minor-manycast-tweaks.patch
+gregkh-usb-usb-resume_device-symbol-conflict.patch
+gregkh-usb-ehci-fix-memory-pool-name-allocation.patch
+gregkh-usb-ehci-fix-root-hub-and-port-suspend-resume-problems.patch
+gregkh-usb-usb-add-autosuspend-support-to-the-hub-driver.patch

 USB tree updates

-powerpc-add-of_platform-support-for-ohci-bigendian-hc.patch

 This broke.

+usb-writing_usb_driver-free-urb-cleanup.patch
+usb-pcwd_usb-free-urb-cleanup.patch
+usb-iforce-usb-free-urb-cleanup.patch
+usb-usb-gigaset-free-kill-urb-cleanup.patch
+usb-cinergyt2-free-kill-urb-cleanup.patch
+usb-ttusb_dec-free-urb-cleanup.patch
+usb-pvrusb2-hdw-free-unlink-urb-cleanup.patch
+usb-pvrusb2-io-free-urb-cleanup.patch
+usb-pwc-if-free-urb-cleanup.patch
+usb-sn9c102_core-free-urb-cleanup.patch
+usb-quickcam_messenger-free-urb-cleanup.patch
+usb-zc0301_core-free-urb-cleanup.patch
+usb-irda-usb-free-urb-cleanup.patch
+usb-zd1201-free-urb-cleanup.patch
+usb-ati_remote-free-urb-cleanup.patch
+usb-ati_remote2-free-urb-cleanup.patch
+usb-hid-core-free-urb-cleanup.patch
+usb-usbkbd-free-urb-cleanup.patch
+usb-auerswald-free-kill-urb-cleanup-and-memleak-fix.patch
+usb-phidgetkit-free-urb-cleanup.patch
+usb-legousbtower-free-kill-urb-cleanup.patch
+usb-phidgetmotorcontrol-free-urb-cleanup.patch
+usb-catc-free-urb-cleanup.patch
+usb-ftdi_sio-kill-urb-cleanup.patch
+usb-io_edgeport-kill-urb-cleanup.patch
+usb-keyspan-free-urb-cleanup.patch
+usb-kobil_sct-kill-urb-cleanup.patch
+usb-mct_u232-free-urb-cleanup.patch
+usb-navman-kill-urb-cleanup.patch
+usb-usb-serial-free-urb-cleanup.patch
+usb-visor-kill-urb-cleanup.patch
+usb-usbmidi-kill-urb-cleanup.patch
+usb-usbmixer-free-kill-urb-cleanup.patch
+nokia-e70-is-an-unusual-device.patch

 USB updates

-x86_64-mm-i386-pci-dma-iounmap.patch
-x86_64-mm-paravirt-skip-timer.patch
-x86_64-mm-paravirt-subarch-cleanup.patch
-x86_64-mm-paravirt-pte-update-common.patch
-x86_64-mm-paravirt-pte-update-prep.patch
-x86_64-mm-paravirt-header-cleanup.patch
+x86_64-mm-extend-bzimage-protocol-for-relocatable-protected-mode-kernel.patch
+x86_64-mm-mark-config_relocatable-experimental.patch
-x86_64-mm-gh-sync-tsc.patch
-x86_64-mm-paravirt-cpu-detect.patch
+x86_64-mm-amd-tsc-sync.patch
-x86_64-mm-header-and-stubs-for.patch
-x86_64-mm-paravirt-patch.patch
-x86_64-mm-paravirt-entry.patch
-x86_64-mm-paravirt-bug-skip.patch
-x86_64-mm-paravirt-no-legacy.patch
-x86_64-mm-paravirt-apic.patch
-x86_64-mm-paravirt-tlb.patch
-x86_64-mm-paravirt-broken.patch
-x86_64-mm-paravirt-compile.patch
-x86_64-mm-io-apic-cleanup.patch
+x86_64-mm-ptrace-compat-threadarea.patch
+x86_64-mm-pci-mcfg-reserve-e820.patch
+x86_64-mm-fix-boot-gdt-limit.patch
+x86_64-mm-substitute-__va-lookup-with-pfn_to_kaddr.patch
+x86_64-mm-e820-small-entries.patch
+x86_64-mm-i386-double-includes.patch
+x86_64-mm-header-and-stubs-for-paravirtualisation.patch
+x86_64-mm-patch-inline-replacements-for.patch
+x86_64-mm-more-generic-paravirtualization.patch
+x86_64-mm-allow-selected-bug-checks-to-be.patch
+x86_64-mm-allow-disabling-legacy-power.patch
+x86_64-mm-add-apic-accessors-to-paravirt-ops..patch
+x86_64-mm-add-mmu-virtualization-to.patch
+x86_64-mm-be-careful-about-touching-bios-address-space.patch
+x86_64-mm-genapic-offbyone.patch
+x86_64-mm-config-core2.patch

 x86 tree updates

-x86_64-mm-i386-reloc-abssym-hack.patch

 Dropped

+pda-percpu-init-make-arch-i386-kernel-cpu-commoncalloc_gdt-static.patch
+paravirt-mmu-header-movement.patch
+paravirt-cpu-detect.patch
+paravirt-pte-update-prep.patch
+paravirt-pte-update-common.patch
+revert-x86_64-mm-try-multiple-timer-pins.patch
+revert-x86_64-mm-try-multiple-timer-pins-wanring-fix.patch
+fix-x86_64-mm-i386-reloc-cleanup-align.patch
+i386-convert-more-absolute-symbols-to-section-relative.patch
+i386-add-write_pci_config_byte-to-direct-pci-access-routines.patch
+i386-introduce-the-mechanism-of-disabling-cpu-hotplug-control.patch
+i386-introduce-the-mechanism-of-disabling-cpu-hotplug-control-cleanup.patch
+x86_64-add-genapic_force.patch
+fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch
+i386-fix-machine_check-entry-point-in-entrys-to-not-dereference-kernel-memory-from-user-space-context.patch
+efi-calling-efi_get_time-during-suspend.patch
+arch-i386-kernel-io_apicc-handle-a-negative-return-value.patch
+genapic-optimize-fix-apic-mode-setup.patch
+make-arch-i386-kernel-io_apiccirq_vector-static.patch

 Various fixes against the x86 tree, and additional x86 and x86_64 fixes and
 updates.

+crypto-remove-one-too-many-semicolon-in-cryptoh.patch

 crypto cleanup/fix.

+mlock-cleanup.patch
+oom-can-panic-due-to-processes-stuck-in-__alloc_pages.patch

 MM udpates

+security-introduce-file-caps.patch
+security-introduce-file-caps-tweaks.patch
+security-introduce-file-caps-warning-fix.patch

 file-based capabilities

-gpio-framework-for-avr32.patch
-avr32-spi-ethernet-platform_device-update.patch
-avr32-move-spi-device-definitions-into-main-board.patch
-atmel-spi-driver.patch
-atmel-spi-driver-maintainers-entry.patch
-avr32-move-ethernet-tag-parsing-to-board-specific.patch
-atmel-macb-ethernet-driver.patch
-adapt-macb-driver-to-net_device-changes.patch

 Dropped.  These will come back via various other trees.

+drivers-add-lcd-support-update-8.patch

 More LCD driver updates

-add-shared-version-of-apm-emulation.patch
-arm-convert-to-use-shared-apm-emulation.patch
-mips-convert-to-use-shared-apm-emulation.patch

 These are being redone.

+hz-300hz-support.patch
+pcengines-wrap-led-support.patch
+pcengines-wrap-led-support-fix.patch
+driver-base-memoryc-remove-warnings-of.patch
+remove-kernel-syscalls.patch
+remove-kernel-syscalls-x86_64-fix.patch
+protect-ext2-ioctl-modifying-append_only-immutable-etc-with-i_mutex.patch
+remove-hash_highmem.patch
+retries-in-ext3_prepare_write-violate-ordering-requirements.patch
+ktime-fix-signed--unsigned-mismatch-in-ktime_to_ns.patch
+qconf-support-old-qt.patch
+remove-the-syslog-interface-when-printk-is-disabled.patch
+ver_linux-additions.patch

 Misc updates

+ext2-reservations.patch
+ext2-reservations-fix.patch
+ext2-reservations-sequential-read-regression-fix.patch
+ext2-reservations-filesystem-bogus-ENOSPC-with-reservation-fix.patch
+ext2-reservations-ext3_clear_inode-avoid-kfree-null.patch
+ext2-reservations-multile-block-allocate-little-endian-fixes.patch
+ext2-reservations-mark-group-descriptors-dirty-during-allocation.patch
+ext2-reservations-nuke-noisy-printk.patch
+ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3.patch

 Port the ext3 reservations code into ext2.

+tty_ioctl-use-termios-for-the-old-structure-and-termios2-update.patch
+termios-enable-new-style-termios-ioctls-on-x86-64.patch

 Update termios patches in -mm.

+char-istallion-fix-enabling.patch
+char-istallion-move-init-and-exit-code.patch
+char-istallion-change-init-sequence.patch
+char-istallion-dynamic-tty-device.patch
+char-istallion-use-mod_timer.patch
+char-cyclades-save-indent-levels.patch
+char-cyclades-lindent-the-code.patch
+char-cyclades-cleanup.patch
+char-cyclades-fix-warnings.patch

 More character driver cleanups.

+fault-injection-documentation-and-scripts.patch
+fault-injection-capabilities-infrastructure.patch
+fault-injection-capabilities-infrastructure-tidy.patch
+fault-injection-capabilities-infrastructure-tweaks.patch
+fault-injection-capability-for-kmalloc.patch
+fault-injection-capability-for-alloc_pages.patch
+fault-injection-capability-for-disk-io.patch
+fault-injection-process-filtering-for-fault-injection-capabilities.patch
+fault-injection-stacktrace-filtering.patch
+fault-injection-Kconfig-cleanup.patch
+fault-injection-stacktrace-filtering-kconfig-fix.patch

 Fault-injection framework and applications thereof.

+sched-fix-migration-cost-estimator.patch

 CPU scheduler fix.

+reiser4-update-comments-fix-write-and-truncate-cryptcompress.patch

 reiser4 update

+reiser4-temp-fix.patch

 Fix reiser4 for the dropping of the generic_file_write() patches.

-fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch

 Dropped, didnb't work right.

+fbmem-is-bootup-logo-broken-for-monochrome-lcd.patch

 Fix boot logo for 1bpp displays (needs work)

+md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure-misc-fixes-for-aligned-read-handling-including-raid6-read-corruption.patch
+md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure-misc-fixes-for-error-handling-of-aligned-reads.patch
+md-fix-innocuous-bug-in-raid6-stripe_to_pdidx.patch
+md-change-lifetime-rules-for-md-devices.patch

 RAID updates

+gtod-persistent-clock-support-i386-i386-unexport-read_persistent_clock.patch
 hrtimers-namespace-and-enum-cleanup.patch
-hrtimers-state-tracking.patch
-hrtimers-clean-up-callback-tracking.patch
-hrtimers-move-and-add-documentation.patch
-clockevents-core.patch
-clockevents-drivers-for-i386.patch
-high-res-timers-core.patch
-gtod-mark-tsc-unusable-for-highres-timers.patch
-dynticks-core.patch
-dynticks-add-nohz-stats-to-proc-stat.patch
-dynticks-i386-arch-code.patch
-high-res-timers-dynticks-enable-i386-support.patch
-debugging-feature-timer-stats.patch
-highres-timer-core-fix-status-check.patch
-highres-timer-core-fix-commandline-setup.patch
-clockevents-smp-on-up-features.patch
-highres-depend-on-clockevents.patch
-i386-apic-cleanup.patch
-pm-timer-allow-early-access.patch
-i386-lapic-timer-calibration.patch
-clockevents-add-broadcast-support.patch
-clockevents-add-broadcast-support-fix.patch
-acpi-include-apic-h.patch
-acpi-include-apic-h-fix.patch
-acpi-keep-track-of-timer-broadcast.patch
-i386-apic-timer-use-clockevents-broadcast.patch
-acpi-verify-lapic-timer.patch
-acpi-verify-lapic-timer-exports.patch
-acpi-verify-lapic-timer-fix.patch
+updated-hrtimers-state-tracking.patch
+updated-hrtimers-clean-up-callback-tracking.patch
+updated-hrtimers-move-and-add-documentation.patch
+updated-add-a-framework-to-manage-clock-event-devices.patch
+updated-acpi-include-apich.patch
+updated-acpi-keep-track-of-timer-broadcast.patch
+updated-acpi-add-state-propagation-for-dynamic-broadcasting.patch
+updated-i386-cleanup-apic-code.patch
+updated-i386-convert-to-clock-event-devices.patch
+updated-i386-convert-to-clock-event-devices-fix.patch
+updated-i386-convert-to-clock-event-devices-arch-i386-kernel-apicc-make-a-function-static.patch
+updated-pm_timer-allow-early-access-and-move-externs-to-a-header-file.patch
+updated-i386-rework-local-apic-calibration.patch
+updated-high-res-timers-core.patch
+updated-gtod-mark-tsc-unusable-for-highres-timers.patch
+updated-dynticks-core-code.patch
+updated-dyntick-add-nohz-stats-to-proc-stat.patch
+updated-dynticks-i386-arch-code.patch
+updated-dynticks-fix-nmi-watchdog.patch
+updated-high-res-timers-dynticks-enable-i386-support.patch
+updated-debugging-feature-timer-stats.patch
+clockevents-core-check-for-clock-event-device-handler-being-non-null-before-calling-it.patch

 Updated/fixed/reworked/redone hrtimer and dynticks patches.

+kvm-virtualization-infrastructure-include-desch.patch
+kvm-virtualization-infrastructure-fix-segment-state-changes-across-processor-mode-switches.patch
+kvm-virtualization-infrastructure-fix-asm-constraints-for-segment-loads.patch
+kvm-vcpu-creation-and-maintenance-segment-access-cleanup.patch
+kvm-avoid-using-vmx-instruction-directly.patch
+kvm-avoid-using-vmx-instruction-directly-fix-asm-constraints.patch

 Update KVM patches in -mm.



All 1327 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/patch-list

