Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVLOHkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVLOHkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 02:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVLOHkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 02:40:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965164AbVLOHkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 02:40:37 -0500
Date: Wed, 14 Dec 2005 23:40:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc5-mm3
Message-Id: <20051214234016.0112a86e.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/


- This kernel requires gcc-3.2.x or later for all architectures.

- I'll be non-functional from December 16 until January 2.  Will be on email
  a bit.  Have fun.

- When reporting any bugs please be extra careful to Cc the appropriate
  developer and mailing list.

- I'm not aware of any of the more serious bugs in rc5-mm1 and rc5-mm2
  being fixed.  If anyone finds that there's a previously-reported problem
  in here then please just re-report it and don't be afraid to spread the
  Cc's around.

  Probably-unfixed bugs from -mm1 and -mm2 include:

  - Frank Sorenson <frank@tuxrocks.com>: mousepad tapping stopped working.

  - Roman I Khimov <rik@osrc.info>: "Something went wrong with ACPI, my
    fan is blowing constantly."

  - "J.A. Magallon" <jamagallon@able.es>: usb_set_configuration() oops.

  - Rachita Kothiyal <rachita@in.ibm.com>: kexec fails during USB init

  - "Rafael J. Wysocki" <rjw@sisk.pl>: ehci_hcd crashes on load sometimes

  - Grant Coady <grant_lkml@dodo.com.au>: "Locked up on boot just after
    USB 2.0 initialised, EHCI 1.00 ..."

  - Martin Bligh <mbligh@google.com>: "Panics in pci_call_probe on both
    x440 and NUMA-Q"

  We need to get these things fixed up before maintainers merge into
  2.6.16, please.  I'll be checking!


Changes since 2.6.15-rc5-mm2:

 linus.patch
 git-acpi.patch
 git-alsa.patch
 git-arm.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-audit.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-rc-fixes.patch
 git-sas-jg.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 Latest versions of subsystem trees

-blkmtd-use-clear_page_dirty.patch
-kprobes-reference-count-the-modules-when-probed-on-it.patch
-x86-fix-nmi-with-cpu-hotplug.patch
-kbuild-fixes.patch
-ext3-fix-mount-options-documentation.patch
-i386-x86-64-implement-fallback-for-pci-mmconfig-to-type1.patch
-x86_64-i386-correct-for-broken-mcfg-tables-on-k8-systems.patch
-i386-x86-64-fix-iounmap-lock-ordering.patch
-reiser4-rcu-barrier.patch
-fix-bug-in-rcu-torture-test.patch
-fix-rcu-race-in-access-of-nohz_cpu_mask.patch
-fix-rcu-race-in-access-of-nohz_cpu_mask-comment.patch
-fix-listxattr-for-generic-security-attributes.patch
-add-getnstimestamp-function.patch
-add-timestamp-field-to-process-events.patch
-rcu-add-hlist_replace_rcu.patch
-kprobes-fix-race-in-aggregate-kprobe-registration.patch
-cciss-double-put_disk.patch
-add-two-inotify_add_watch-flags.patch
-um-fix-compile-error-for-tt.patch
-powerpc-fix-a-huge-page-bug.patch
-powerpc-remove-debug-code-in-hash-path.patch
-fix-windfarm-model-id-table.patch
-add-try_to_freeze-to-kauditd.patch
-mm-go-back-to-checking-pageanon-in-vm_normal_page.patch
-mips-setup_zero_pages-count-1.patch
-v4l-dvb-3086a-whitespaces-cleanups-part-1.patch
-v4l-dvb-3086b-whitespaces-cleanups-part-2.patch
-v4l-dvb-3086c-whitespaces-cleanups-part-3.patch
-v4l-dvb-3086c-whitespaces-cleanups-part-4.patch
-v4l-dvb-3135-fix-tuner-init-for-pinnacle-pctv-stereo.patch
-v4l-dvb-3113-convert-em28xx-to-use-vm_insert_page.patch
-v4l-dvb-3151-i2c-id-renamed-to-i2c_driverid_infrared.patch
-powerpc-set-cache-info-defaults.patch
-powerpc-fix-slb-flushing-path-in-hugepage.patch
-powerpc-add-missing-icache-flushes-for-hugepages.patch
-sparc-atomic_clear_mask-build-fix.patch
-sparc32-block-needed-in-final-image-link-build-fix.patch
-ipmi-fix-panic-generator-id.patch
-kprobes-no-probes-on-critical-path.patch
-kprobes-no-probes-on-critical-path-fix.patch
-kprobes-increment-kprobe-missed-count-for-multiprobes.patch
-broken-cast-in-parport_pc.patch
-input-fix-ucb1x00-ts-breakage-after-conversion-to-dynamic.patch
-fix-kconfig-of-dma32-for-ia64.patch
-ppc32-set-smp_tb_synchronized-on-up-with-smp-kernel.patch
-fix-in-__alloc_bootmem_core-when-there-is-no-free-page-in-first-nodes-memory.patch
-x86_64-numa-bug-correction-in-populate_memnodemap.patch
-acpi-fix-sleeping-whilst-atomic-warnings-on-resume.patch
-evdev-consolidate-compat-and-standard-code.patch
-drivers-input-misc-added-acer-travelmate-240-support-to-the-wistron-button-interface.patch
-git-net-revert-af_unix-changes.patch
-git-net-selinux-xfrm-build-fix.patch
-spufs-build-fix.patch
-usb-support-for-posiflex-pp-7000-retail-printer-for-ftdi_sio-driver.patch
-x86_64-hpet-fallback.patch
-x86_64-disable-LAPIC-completely-for-offline-CPU.patch
-x86_64-hpet-overflow-fix.patch
-x86_64-dmi-fix.patch
-ieee80211_crypt_tkip-depends-on-net_radio.patch
-pcnet32-use-mac-address-from-prom-also-on-powerpc.patch
-x86_64-fix-delay-resolution.patch
-fbdev-shift-pixel-value-before-entering-loop-in-cfbimageblit.patch
-fbdev-fix-incorrect-unaligned-access-in-little-endian-machines.patch
-fbcon-add-ability-to-save-restore-graphics-state.patch
-fbdev-pan-display-fixes.patch
-fbcon-avoid-illegal-display-panning.patch
-fbdev-fixing-switch-to-kd_text-enhanced-version.patch

 Merged

+ipmi-panic.patch

 IPMI fix

+reiserfs-close-open-transactions-on-error-path.patch
+reiserfs-skip-commit-on-io-error.patch

 reiserfs fixes

+input-alps-correctly-report-button-presses-on-fujitsu-siemens-s6010.patch

 ALPS fix

+git-acpi-warning-fix.patch

 Fix warning in git-acpi.patch

+2.6-sony_acpi4.patch

 ACPI driver for Sony laptops

+git-alsa-sparc64-fix.patch

 Fix git-alsa.patch on sparc64 (this is wrong)

+alsa-cs5536-id-for-cs5535audio.patch

 ALSA device update (so is this)

+gregkh-driver-input-add-modalias-support.patch
+gregkh-driver-input-fix-add-modalias-support-build-error.patch
+gregkh-driver-platform-device-del.patch
+gregkh-driver-platform-rearange-exports.patch
+gregkh-driver-bind_unbind_if_CONFIG_HOTPLUG.patch
+gregkh-driver-block-device-symlink-name-fix.patch

 Driver tree updates

+drivers-base-power-runtimec-if-0-dpm_set_power_state.patch

 Cleanup

+ia64-eliminate-softlockup-warning.patch

 Prevent false positive lockup report

+libata_suspend.patch
+libata_suspend-fix.patch
+libata_resume_fix.patch

 Various patches which might make suspend-to-disk work on ata_piix.

+powerpc-pci_address_to_pio-warning-fix.patch
+git-powerpc-reexport-handle_mm_fault.patch

 git-powerpc.patch fixes

+gregkh-pci-pci-express-must-be-initialized-before-pci-hotplug.patch
+gregkh-pci-pci-export-pci_cfg_space_size.patch
+gregkh-pci-pci-document-sysfs-rom-file-interface.patch
+gregkh-pci-reduce-nr-of-ptr-derefs-in-drivers-pci-hotplug-cpqphp_core.c.patch
+gregkh-pci-reduce-nr-of-ptr-derefs-in-drivers-pci-hotplug-rpaphp_pci.c.patch
+gregkh-pci-reduce-nr-of-ptr-derefs-in-drivers-pci-hotplug-pciehprm_acpi.c.patch
+gregkh-pci-reduce-nr-of-ptr-derefs-in-drivers-pci-hotplug-pciehp_core.c.patch
+gregkh-pci-cpqphp-sysfs-fixup.patch

 PCI tree updates

+revert-gregkh-pci-shot-accross-the-bow.patch

 Drop an unwelcome patch from the PCI tree

+drivers-scsi-small-cleanups.patch

 SCSI cleanups

+gregkh-usb-usbcore-fix-local-variable-clash.patch
+gregkh-usb-usb-use-array_size-macro.patch
+gregkh-usb-usb-add-driver-for-ati-philips-usb-rf-remotes.patch
+gregkh-usb-usb-support-for-posiflex-pp-7000-retail-printer-in-linux.patch
+gregkh-usb-ftdi_sio-new-ids-for-teratronik-devices.patch
+gregkh-usb-usb-remove-unneeded-kmalloc-return-value-casts.patch
+gregkh-usb-isp116x-hcd.c-removed-unused-variable.patch

 USB tree updates

+x86_64-acpi-map.patch
+x86_64-slit-validate.patch
+x86_64-alloc-pages-node-default.patch
+x86_64-bus-node-default.patch
+x86_64-delay-overflow.patch
+x86_64-biarch-compile.patch
+x86_64-pad-gdt.patch
+x86_64-module-fault.patch
+x86_64-compat-parport.patch
-x86_64-hpet-overflow.patch

 x86_64 updates

+inclusion-of-scalemp-vsmp-architecture-patches-vsmp_arch.patch
+inclusion-of-scalemp-vsmp-architecture-patches-vsmp_align.patch

 Support for the vSMP architecture (slight changes to x86_64)

+fix-zone-policy-determination.patch
+build_zonelists_node-rename-args.patch
+mm-cleanup-zone_pcp.patch

 mm/ updates and cleanups

+atomic_long_t-include-asm-generic-atomich-v2.patch
+atomic_long_t-include-asm-generic-atomich-v2-fix.patch
+atomic_long_t-include-asm-generic-atomich-v2-fix-2.patch
+atomic_long_t-include-asm-generic-atomich-v2-fix-3.patch
+atomic_long_t-include-asm-generic-atomich-v2-fix-4.patch

 Add atomic_long_t support

+mm-page_state-opt.patch
+mm-page_state-opt-docs.patch
+mm-free_pages-opt.patch

 mm/ microoptimisations

-mm-implement-swap-prefetching.patch
-mm-implement-swap-prefetching-default-y.patch
-mm-implement-swap-prefetching-tweaks.patch
-mm-implement-swap-prefetching-tweaks-2.patch
-mm-swap-prefetch-magnify.patch

 Dropped swap prefetching, sorry.  I wasn't able to notice much benefit from
 it in my testing, and the number of mm/ patches in getting crazy, so we don't
 have capacity for speculative things at present.

+drivers-net-arcnet-possible-cleanups.patch
+drivers-net-kconfig-indentation-fix.patch
+drivers-net-bonding-bondingh-extern-inline-static-inline.patch
+drivers-net-gianfarh-extern-inline-static-inline.patch

 net driver cleanups

+e1000-fix-invalid-memory-reference.patch

 e1000 oops fix

+ipw2200_txbusy.patch

 ipw2200 Tx handling fix

+acx-should-select-not-depend-on-fw_loader.patch

 ACX wireless driver Kconfig fixlet.

-x86-hotplug-cpu-disable-lapic-completely-for-offline-cpu.patch

 Dropped (I think).  There were a few patches in there all basically doing
 same-but-different things.

-i386-cs5535-chip-support-cpu.patch
-i386-cs5535-chip-support-gpio.patch
-i386-cs5535-chip-support-smbus.patch
+i386-gpio-driver-for-amd-cs5535-cs5536.patch
+i386-gpio-driver-for-amd-cs5535-cs5536-fix.patch

 Updated version of this driver

+x86_64-disable-tsc-with-seccomp.patch

 Disable the TSC on x86_64 when secure-computing is in operation (ongoing
 bunfight).

+swsusp-make-image-size-limit-tunable.patch

 swsusp tunable

+swsusp_resume_fix.patch

 swsusp hack which fixed someone's machine.

+cris-kgdb-remove-double_this.patch

 cris cleanup

+s390-fix-missing-release-function-and-cosmetic-changes.patch

 s390 fix

+debug_slab-depends-on-slab.patch

 Dependency fix

+slob-introduce-the-slob-allocator-64-bit-fixes.patch

 Fix the slob allocator for 64-bit

+cpuset-remove-test-for-null-cpuset-from-alloc-code-path.patch

 cpuset microoptimisation

+cpuset-use-rcu-directly-optimization.patch
+cpuset-mark-number_of_cpusets-read_mostly.patch
+cpuset-skip-rcu-check-if-task-is-in-root-cpuset.patch

 cpusets updates

+irq-type-flags-arm-fix.patch

 Fix irq-type-flags.patch

+irq-type-flags-use-new-flags.patch

 Use  irq-type-flags.patch

-untangle-smph-vs-thread_info.patch

 It broke ia64

+dont-attempt-to-power-off-if-power-off-is-not-implemented-alpha-fix.patch
+dont-attempt-to-power-off-if-power-off-is-not-implemented-m32r-fix.patch
+dont-attempt-to-power-off-if-power-off-is-not-implemented-uml-fix.patch

 Fix dont-attempt-to-power-off-if-power-off-is-not-implemented.patch

+setpgid-should-work-for-sub-threads.patch
+setsid-should-work-for-sub-threads.patch
+setpgid-should-not-accept-ptraced-childs.patch

 setsid/setpgid fixes

+remove-fs-jffs2-ioctlc.patch

 Dead code

+fix-ipmi-compile-errors-with-proc_fs=n.patch

 IPMI fix

+fs-udf-ballocc-extern-inline-static-inline.patch
+copy_process-error-path-cleanup.patch

 Cleanups

+abandon-gcc-295x.patch
+remove-gcc2-checks.patch
+remove-the-deprecated-check_gcc.patch

 Dump gcc-2.95.x

+dev-mem-__have_phys_mem_access_prot-tidy-up.patch
+dev-mem-validate-mmap-requests.patch

 /dev/mem cleanup and feature work

+fs-proc-function-prototypes-belong-into-header-files.patch
+make-i2o_iop_free-static-inline.patch

 Cleanups

+sonypi-convert-to-the-new-platform-device-interface.patch

 Modernise the sonypi driver

+kexec-change-config_physical_start-dependency.patch

 kexec fix

+simple-spi-framework-priority-inversion-tweak.patch

 Tune simple-spi-framework.patch

+add-vfs_-helpers-for-xattr-operations-fix.patch

 Fix add-vfs_-helpers-for-xattr-operations.patch

+move-rtc-compat-ioctl-handling-to-fs-compat_ioctlc.patch
+add-compat_ioctl-to-dasd.patch
+add-compat_ioctl-to-dasd-fix.patch
+sanitize-building-of-fs-compat_ioctlc.patch
+dont-include-ioctl32h-in-drivers.patch

 More ioctl cleanups

+ntfs-remove-superflous-ms_noatime-ms_nodiratime-assignments.patch
+9p-remove-superflous-ms_nodiratime-assignment.patch
+introduce-fs_noatime-and-fs_nodiratime-flags.patch
+fs_noatime-for-ocfs.patch
+remove-ms_noatime-mirroring-inside-xfs.patch
+per-mount-noatime-and-nodiratime.patch

 More atime updates

+unshare-system-call-system-call-handler-function.patch
+unshare-system-call-system-call-registration-for-i386.patch
+unshare-system-call-system-call-registration-for-powerpc.patch
+unshare-system-call-system-call-registration-for-ppc.patch
+unshare-system-call-system-call-registration-for-x86_64.patch
+unshare-system-call-allow-unsharing-of-filesystem.patch
+unshare-system-call-allow-unsharing-of-namespace.patch
+unshare-system-call-allow-unsharing-of-vm.patch
+unshare-system-call-allow-unsharing-of-files.patch

 Add the unshare() syscall: for getting a private copy of a thread's memory
 maps, files, signals, etc.

-edac-atomic-scrub-operations-fix.patch

 Folded into edac-atomic-scrub-operations.patch

-edac-core-edac-support-code-ifdef-warnings.patch
-edac-core-edac-support-code-fixes.patch
-edac-core-edac-support-code-fixes-2.patch
-edac-core-edac-support-code-fixes-3.patch
-edac-core-edac-support-code-edac_mc_scrub_block-kunmap_atomic-fix.patch
-edac-core-edac-support-code-edac_mc_scrub_block-kunmap_atomic-fix-2.patch
-edac-core-edac-support-code-remove-proc_ent.patch
-edac-core-edac-support-code-missing-pci-dependencies.patch
-edac-core-edac-support-edac-help-text.patch
-edac-core-edac-support-edac-kconfig-fixes.patch
-edac-needs-x86.patch
-edac-clean-up-atomic-stuff.patch

 Folded into edac-core-edac-support-code.patch

+hrtimer-convert-posix-timers-completely-fix-2.patch

 Fix hrtimer-convert-posix-timers-completely.patch again

+simplify-parport_pc_pcmcia-dependencies.patch
+include-linux-parport_pch-extern-inline-static-inline.patch

 parport tweaks

+kprobes-enable-funcions-only-for-required-arch.patch
+kprobes-cleanup-include_asm_kprobes_h.patch
+kprobes-changed-from-using-spinlock-to-mutex.patch
+kprobes-changed-from-using-spinlock-to-mutex-fix.patch
+kprobes-cleanup-arch_remove_kprobe.patch

 kprobes updates

+dvb-2401-usb-hot-unplug-oops-fix.patch
+v4l-dvb-3154-ttusb-dec-driver-patch-roundup.patch
+v4l-dvb-3159-replaces-max-min-by-kernelh.patch
+v4l-dvb-3160-updates-to-the-tveeprom-eeprom.patch
+v4l-dvb-3161-ir-kbd-gpio-is-now-part-of-bttv.patch
+v4l-dvb-3166-philips-1236d-atsc-ntsc-dual-in.patch

 v4l/dvb updates

+scheduler-cache-hot-autodetect-section-fixes-2.patch

 Fix scheduler-cache-hot-autodetect.patch some more

+fs-reiser4-possible-cleanups.patch

 reiser4 cleanups

+vesafb-trim-vesafb_pan_display-fix.patch

 Fix vesafb-trim-vesafb_pan_display.patch

+include-video-newporth-extern-inline-static-inline.patch
+fbcon-disable-ywrap-if-not-supported-by-fbcon-scrolling-code.patch
+fbdev-fixed-and-updated-cyblafb.patch

 fbdev updates

+drivers-md-kcopydc-if-0-kcopyd_cancel.patch

 devicemapper cleanup

+md-define-and-use-safe_put_page-for-md.patch
+md-helper-function-to-match-commands-written-to-sysfs-files.patch
+md-fix-typo-in-comment.patch
+md-make-a-couple-of-names-in-mdc-static.patch
+md-make-sure-bitmap-updates-are-visible-through-filesystem.patch
+md-fix-rdev-pending-counts-in-raid1.patch
+md-allow-chunk_size-to-be-settable-through-sysfs.patch
+md-allow-md-array-component-size-to-be-accessed-and-set-via-sysfs.patch
+md-expose-md-metadata-format-in-sysfs.patch
+md-allow-array-level-to-be-set-textually-via-sysfs.patch
+md-count-corrected-read-errors-per-drive.patch
+md-allow-md-raid_disks-to-be-settable.patch
+md-keep-better-track-of-dev-array-size-when-assembling-md-arrays.patch
+md-expose-device-slot-information-via-sysfs.patch
+md-export-rdev-data_offset-via-sysfs.patch
+md-export-rdev-data_offset-via-sysfs-fix.patch
+md-allow-available-size-of-component-devices-to-be-set-via-sysfs.patch
+md-allow-available-size-of-component-devices-to-be-set-via-sysfs-fix.patch
+md-support-adding-new-devices-to-md-arrays-via-sysfs.patch
+md-allow-sync-speed-to-be-controlled-per-device.patch

 RAID updates

+post-halloween-doc-update-1.patch
+post-halloween-doc-update-2.patch
+post-halloween-doc-update-3.patch

 Update post-halloween-doc.patch

+debug-warn-if-we-sleep-in-an-irq-for-a-long-time.patch

 Add runtime check for lengthy mdelay() in hard irq context (why not in
 softirq or in local_irq_disable()?)

+fs-binfmt_elf-remove-unneeded-kmalloc-return-value-casts.patch
+net-remove-unneeded-kmalloc-return-value-casts.patch
+drivers-atm-remove-unneeded-kmalloc-return-value-casts-tiny-whitespace-cleanup.patch
+selinux-remove-unneeded-kalloc-return-value-casts.patch
+sound-remove-unneeded-kmalloc-return-value-casts.patch
+include-asm-sh64-extern-inline-static-inline.patch
+include-asm-x86_64-pgtableh-extern-inline-static-inline.patch
+drivers-scsi-lpfc-lpfc_scsic-make-lpfc_sli_get_scsi_buf-static.patch
+drivers-scsi-qla2xxx-possible-cleanups.patch
+video-matrox-matroxfb_miscc-remove-dead-code.patch
+kill-drivers-net-irda-sir_corec.patch
+kernel-resourcec-__check_region-remove-pointless-__deprecated.patch
+drivers-base-memoryc-unexport-the-static-sic-memory_sysdev_class.patch
+include-linux-schedh-no-need-to-guard-the-normalize_rt_tasks-prototype.patch
+let-magic_sysrq-no-longer-depend-on-debug_kernel.patch
+drivers-w1-misc-cleanups.patch
+fs-hfsplus-remove-the-hfsplus_inode_check-debug-function.patch

 Cleanups



All 1247 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/patch-list


