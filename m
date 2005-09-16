Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbVIPJXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbVIPJXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 05:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbVIPJXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 05:23:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161143AbVIPJXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 05:23:53 -0400
Date: Fri, 16 Sep 2005 02:23:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc1-mm1
Message-Id: <20050916022319.12bf53f3.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/
(temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc1-mm1.gz)


- Big reiser4 update which is said to address all review comments.

- Added version 1 of Dmitry's big sysfs/input revamp.

- Lots of tty drivers still don't compile.



Changes since 2.6.13-mm3:

 linus.patch
 git-arm.patch
 git-cifs.patch
 git-drm.patch
 git-ia64.patch
 git-jfs.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ocfs2.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-watchdog.patch

 Subsystem trees

-fbdev-kconfig-fix.patch
-pcmcia-warn-on-ioctl-usage.patch
-sound-support-for-vaio-ra826g-hda.patch
-gregkh-driver-securityfs.patch
-gregkh-driver-firmware_documenation.patch
-gregkh-driver-aoe-01.patch
-gregkh-driver-aoe-02.patch
-seclvl-use-securityfs.patch
-seclvl-use-securityfs-tidy.patch
-seclvl-use-securityfs-fix.patch
-gregkh-i2c-hdaps.patch
-gregkh-i2c-i2c-nforce-drop-define.patch
-gregkh-i2c-hwmon-w83627hf.patch
-gregkh-i2c-hwmon-smsc47m1.patch
-gregkh-i2c-hwmon-force_addr-fix.patch
-i2c-keywest-warning-fix.patch
-netlink-connector.patch
-gregkh-pci-pci-acpi-mcfg-04.patch
-apple-usb-touchpad-driver-2.patch
-usbdevice_fs-header-breakage.patch
-w83977f-watchdog-driver.patch
-x86_64-defconfig-update.patch
-x86_64-smpboot-write-around.patch
-x86_64-genapic-write-around.patch
-x86_64-remove-esr-disable.patch
-x86_64-remove-apic-errata.patch
-x86_64-huge-cpu-apicids.patch
-x86_64-calibrate-enable-irqs.patch
-x86_64-smp-call-single-cleanup.patch
-x86_64-srat-apicid.patch
-x86_64-apic-version.patch
-x86_64-pda-up-align.patch
-x86_64-numa-k8-nodeid.patch
-x86_64-intel-srat.patch
-x86_64-apic-bsp-id-up.patch
-x86_64-swiotlb-bounce.patch
-x86_64-pgdat-order.patch
-x86_64-aperture-swiotlb.patch
-x86_64-swiotlb-force.patch
-x86_64-mce-lockup.patch
-x86_64-mce-cmd-line.patch
-x86_64-up-apicid.patch
-x86_64-pci-gart-node-opt.patch
-x86_64-e820-off-by-one.patch
-x86_64-reserved-check.patch
-x86_64-flatmem-end-pfn.patch
-x86_64-mce-smp-resume.patch
-x86_64-pci-pxm.patch
-x86_64-print-uts-version.patch
-x86_64-sendfile-fix.patch
-x86_64-scalable-tlb-flush.patch
-x86_64-simnow-console.patch
-x86_64-pda-cleanup.patch
-x86_64-timex-config.patch
-x86_64-tlb-flush-array.patch
-x86_64-cpu-data-possible.patch
-x86_64-idle-poll-fix.patch
-x86_64-early-page-typo.patch
-x86_64-setup-merge.patch
-x86_64-drop-disable-tsc.patch
-x86_64-show_mem-printk.patch
-x86_64-syscall-clobber.patch
-x86_64-pfn-valid-off-by-one.patch
-x86_64-nodemap-extend.patch
-x86_64-irq-bug.patch
-x86_64-hotplug-typo.patch
-x86_64-trampoline-free.patch
-x86_64-extern-inline.patch
-x86_64-lowest-pri.patch
-x86_64-vsyscall-gcc4.patch
-x86_64-srat-overlap-error.patch
-x86_64-dma-sync-range.patch
-x86_64-physflat-intel.patch
-x86_64-gcc4-unzip-warnings.patch
-x86_64-cfi.patch
-x86_64-suspend-include.patch
-x86_64-msr-merge.patch
-x86_64-oops-irq.patch
-x86_64-init-rsp.patch
-x86_64-remove-vxtime-hz.patch
-x86_64-nmi-vector.patch
-x86_64-cmpxchg-constraints.patch
-x86_64-nmi-newline.patch
-x86_64-i387-sig.patch
-x86_64-include-irq.patch
-x86_64-allow-framepointer.patch
-x86_64-dmi-warning.patch
-x86_64-smaller-bug.patch
-x86_64-srat-early-cutoff.patch
-x86_64-srat-cleanup.patch
-x86_64-srat-conflict.patch
-x86_64-local-add-fix.patch
-x86_64-dma32-srat-fix.patch
-vm-kswapd-cleanup-use-pgdat.patch
-fix-mpol_f_verify.patch
-pcnet32-set_ringparam-implementation-tidy.patch
-skge-kconfig-help-text-typo-fix.patch
-s2io-warning-fixes.patch
-ppc32-discard-exittext-and-exitdata-sections.patch
-ppc32-remove-use-of-asm-segmenth.patch
-i386-dont-miss-pending-signals-returning-to-user-mode-after-signal-processing.patch
-x86_64-nmi-watchdog-frequency-calculation-adjustments.patch
-kbtab-tweaks-pen-tool-reporting.patch
-open-returns-enfile-but-creates-file-anyway.patch
-free-initrd-mem-adjustment.patch
-free-initrd-mem-adjustment-fix.patch
-make-build_bug_on-fail-at-compile-time.patch
-set_current_state-commentary.patch
-schedule_timeout_interruptible-speedup.patch
-remove-unnecessary-check_region-references-in-comments.patch
-use-add_taint-for-setting-tainted-bit-flags.patch
-reiserfs_file_write-should-mark-inodes-dirty.patch
-cciss-new-controller-pci-subsystem-ids.patch
-cciss-busy_initializing-flag.patch
-cciss-new-disk-register-deregister-routines.patch
-cciss-direct-lookup-for-command-completions.patch
-cciss-bug-fix-in-cciss_remove_one.patch
-cciss-fix-for-dma-brokeness.patch
-cciss-one-button-disaster-recovery-support.patch
-cciss-scsi-tape-info-for-proc.patch
-fix-bogus-bug_on-in-pktcdvd.patch
-pktcdvd-documentation-update.patch
-pktcdvd-more-accurate-i-o-accounting.patch
-use-kcalloc-and-kzalloc-in-pktcdvd.patch
-pktcdvd-bug_on-cleanups.patch
-pci-convert-kcalloc-to-kzalloc.patch
-sharpsl-abstract-c7x0-specifics-from-corgi-ssp.patch
-sharpsl-add-cxx00-support-to-the-corgi-lcd-driver.patch
-sharpsl-abstract-c7x0-specifics-from-corgi.patch
-sharpsl-abstract-model-specifics-from-corgi.patch
-sharpsl-add-new-arm-pxa-machines-spitz-and-borzoi.patch
-sharpsl-add-an-input-keyboard-driver-for-zaurus.patch
-rapidio-support-net-driver.patch
-nfsd4-printk-reduction.patch
-nfsd4-move-replay_owner.patch
-nfsd4-fix-open-seqid-incrementing-in-lock.patch
-nfsd4-fix-setclientid-unlock-of-unlocked-state-lock.patch
-code-cleanups-in-calbacks-in-svcsock.patch
-v4l-experimental-sliced-vbi-api-support.patch
-v4l-fixup-on-cx88_dvb-for-dvico-hdtv5-gold.patch
-ide-clean-up-the-garbage-in-eighty_ninty_three.patch
-fix-kernel-oops-with-cf-cards.patch
-minor-fbcon_scroll-adjustment.patch
-fbcon-constify-font-data.patch
-matroxfb-adjustments.patch
-doc-update-oops-tracingtxt-tainted-flags.patch
-tell-people-not-to-use-pm_register.patch
-drivers-net-arcnet-possible-cleanups.patch
-drivers-net-wan-possible-cleanups.patch
-drivers-net-wan-replace-custom-macro-with-isdigit-isxdigit.patch
-net-fix-up-schedule_timeout-usage.patch
-drivers-net-fix-up-schedule_timeout-usage.patch
-drivers-sbus-fix-up-schedule_timeout-usage.patch
-drivers-usb-fix-up-schedule_timeout-usage.patch
-arch-i386-replace-custom-macro-with-isdigit.patch
-drivers-video-replace-custom-macro-with-isdigit.patch
-jbd-remove-duplicated-debug-print.patch
-feature-removal-of-io_remap_page_range.patch

 Merged

+raid6-altivec-fix.patch

 raid6 fix

+sharpsl-add-missing-hunk-from-backlight-update.patch

 Zaurus fbdev driver fix

+mtd-update-sharpsl-partition-definitions.patch

 Zaurus mtd fix

+s390-default-configuration.patch
+s390-bl_dev-array-size.patch
+s390-crypto-driver-patch-take-2.patch
+s390-show_cpuinfo-fix.patch
+s390-diag-0x308-reipl.patch
+s390-kernel-stack-corruption.patch

 s390 update

+remove-arch-arm26-boot-compressed-hw-bsec.patch

 Dead file

+cpu-hotplug-breaks-wake_up_new_task.patch

 fork() fix

+uml-_switch_to-code-consolidation.patch
+uml-breakpoint-an-arbitrary-thread.patch
+uml-remove-a-useless-include.patch
+uml-remove-an-unused-file.patch
+uml-remove-some-build-warnings.patch
+uml-preserve-errno-in-error-paths.patch
+uml-move-libc-code-out-of-mem_userc-and-tempfilec.patch
+uml-merge-mem_userc-and-memc.patch
+uml-return-a-real-error-code.patch
+uml-remove-include-of-asm-elfh.patch

 UML update

+fix-up-some-pm_message_t-types.patch

 Build fixes

+fix-mm-kconfig-spelling.patch

 Kconfig fix

+x86_64-e820c-needs-module-h.patch
 x86_64-desch-needs-smph.patch

 x86_64 build fixes

+acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549.patch

 ACPI blacklist additions

+allow-multiple-ac97-quirks-for-one-piece-of-hardware.patch

 Sound driver fix

+hdaps-driver-update.patch

 HDAPS driver update

+drivers-base-use-kzalloc-instead-of-kmallocmemset-gregkh-bits.patch

 Use kzalloc()

+i2c-kill-an-unused-i2c_adapter-struct-member.patch

 i2c cleanup

+kbuild-permanently-fix-kernel-configuration-include-mess.patch

 Include config.h via gcc commandline

+ibmphp-use-dword-accessors-for-pci_rom_address.patch
+pciehp-use-dword-accessors-for-pci_rom_address.patch
+shpchp-use-dword-accessors-for-pci_rom_address.patch
+qla2xxx-use-dword-accessors-for-pci_rom_address.patch

 Always use doubleword accessors for PCI ROM registers

+arch-i386-pci-acpic-use-for_each_pci_dev.patch
+pci-convert-kcalloc-to-kzalloc.patch

 tweaks

+gregkh-usb-usb-endpoints-in-sysfs.patch

 USB update

+more-device-ids-for-option-card-driver.patch

 Device support

+x86_64-dma32-srat32.patch
+x86_64-pagealloc-cpu-up-cancel.patch

 x86_64 updates

+memory-hotplug-move-section_mem_map-alloc-to-sparsec-kzalloc.patch
+memory-hotplug-move-section_mem_map-alloc-to-sparsec-fix.patch

 Fix the memory hotplug patches in -mm.

+3c59x-bounds-checking-for-hw_checksums.patch
+3c59x-cleanup-init-of-module-parameter-arrays.patch
+3c59x-fix-some-grammar-in-module-parameter-descriptions.patch
+3c59x-support-ethtool_gpermaddr.patch
+3c59x-support-ethtool_gpermaddr-fix.patch
+3c59x-correct-rx_dropped-counting.patch
+3c59x-enable-use-of-memory-mapped-pci-i-o.patch

 3com NIC driver updates

+tg3-handle-mmio-reordering-for-all-devices.patch

 tg3 fix

+selinux-convert-to-kzalloc.patch

 SELinux cleanup

+selinux-canonicalize-getxattr.patch
+selinux-canonicalize-getxattr-fix.patch

 SELinux infrastructure work

+ppc-prevent-gcc-4-from-generating-altivec-instructions-in-kernel.patch
+ppc32-8xx-use-io-accessor-macros-instead-of-direct-memory-reference.patch
+mpc8xx-pcmcia-driver.patch

 ppc32 updates

+i386-and-x86_64-tsc-set_cyc2ns_scale-imprecision.patch

 x86 time accuracy improvements

+fpu-context-corrupted-after-resume.patch

 x86 PM fix

+swsusp-fix-comments.patch

 Fix some comments

+s390-3270-fullscreen-view.patch
+s390-ipl-device.patch

 More s390 updates

+convert-proc-devices-to-use-seq_file-interface.patch
+convert-proc-devices-to-use-seq_file-interface-tidy.patch

 Convert /proc/devices handling to seq_file.

+add-smp_mb__after_clear_bit-to-unlock_kiocb.patch

 AIO fix

+joystick-vs-xorg-fix.patch

 Fix xorg build

+smsc-ircc2-pm-cleanup-do-not-close-device-when-suspending.patch

 smsc (IRDA) update

+codingstyle-memory-allocation.patch

 CodingStyle additions

+fix-unmapped-buffers-in-transactions-lists.patch

 ext3 fix

+files-fix-preemption-issues.patch
+files-fix-preemption-issues-tidy.patch

 files_lock RCUification fix

+pc-speaker-add-snd_silent.patch

 pc speaker feature work

+oops-reporting-tool.patch

 oops reporting script.  Is this useful?

+new-omnikey-cardman-4040-driver.patch
+new-omnikey-cardman-4040-driver-fixes.patch
+cm4040-min-fix.patch
+cm4040-fixes.patch
+new-omnikey-cardman-4000-driver.patch
+new-omnikey-cardman-4000-driver-fixes.patch

 New pcmcia drivers

+reorder-struct-files_struct.patch

 Might make struct fiels more smp-friendly.

+clear_buffer_uptodate-in-discard_buffer.patch
+clear_buffer_uptodate-in-discard_buffer-check.patch

 Mark buffer_heads nt uptodate in discard_buffer()

+per-task-predictive-write-throttling-1.patch
+per-task-predictive-write-throttling-1-tweaks.patch

 Make heavy write()rs throttle themselves more.

+oss-dont-concatenate-__function__-with-strings.patch

 OSS driver cleanup

+fat-miss-sync-issues-on-sync-mount-miss-sync-on-write.patch

 Fix fatfs synchronous write()s

+fix-pf-request-handling.patch

 Partly fix the paride driver

+i2o-remove-class-interface.patch
+i2o-remove-i2o_device_class.patch
+driver-core-allow-nesting-classes.patch
+driver-core-make-parent-class-define-subsystem.patch
+driver-core-pass-interface-to-class-intreface-methods.patch
+driver-core-send-hotplug-event-before-adding-class-interfaces.patch
+input-kill-devfs-references.patch
+input-prepare-to-sysfs-integration.patch
+input-convert-net-bluetooth-to-dynamic-input_dev-allocation.patch
+input-convert-drivers-macintosh-to-dynamic-input_dev-allocation.patch
+input-convert-konicawc-to-dynamic-input_dev-allocation.patch
+input-convert-onetouch-to-dynamic-input_dev-allocation.patch
+drivers-input-mouse-convert-to-dynamic-input_dev-allocation.patch
+drivers-input-keyboard-convert-to-dynamic-input_dev-allocation.patch
+drivers-input-touchscreen-convert-to-dynamic-input_dev-allocation.patch
+drivers-usb-input-convert-to-dynamic-input_dev-allocation.patch
+input-convert-ucb1x00-ts-to-dynamic-input_dev-allocation.patch
+input-convert-sound-ppc-beep-to-dynamic-input_dev-allocation.patch
+input-convert-sonypi-to-dynamic-input_dev-allocation.patch
+input-convert-driver-input-misc-to-dynamic-input_dev-allocation.patch
+drivers-input-joystick-convert-to-dynamic-input_dev-allocation.patch
+drivers-media-convert-to-dynamic-input_dev-allocation.patch
+input-show-sysfs-path-in-proc-bus-input-devices.patch
+input-export-input_dev-data-via-sysfs-attributes.patch
+input-core-implement-class-hierachy.patch
+input-core-implement-class-hierachy-hdaps-fixes.patch
+input-core-remove-custom-made-hotplug-handler.patch
+input-convert-input-handlers-to-class-interfaces.patch
+input-convert-to-seq_file.patch

 Big input/sysfs changes

+pcmcia-fix-up-cm40x0-drivers.patch

 Fix the cardman drivers for the -mm pcmcia changes

-nfs-nfs3-page-null-fill-in-a-short-read-situation.patch

 Dropped - wrong.

+page-owner-tracking-leak-detector-oops-fix.patch
+page-owner-tracking-leak-detector-oops-fix-tidy.patch

 Fix page-owner-tracking-leak-detector.patch

+reiser4-big-update.patch
+reiser4-big-update-div64-fix.patch
+reiser4-remove-c99isms.patch

 reiser4 update

-remove-lock_section-from-x86_64-spin_lock-asm.patch

 Dropped - got bored of carrying it and Andi was sceptical

+md-better-handling-of-readerrors-with-raid5.patch

 Experimentalish raid5 changes

+tty-layer-buffering-revamp-pmac_zilog-warning-fix.patch
+tty-layer-buffering-revamp-further-tty-bits.patch

 Fix a few tty drivers for tty-layer-buffering-revamp.patch breakage.



All 440 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/patch-list


