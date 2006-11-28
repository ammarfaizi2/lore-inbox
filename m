Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935790AbWK1KDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935790AbWK1KDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935793AbWK1KDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:03:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:5535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935790AbWK1KDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:03:21 -0500
Date: Tue, 28 Nov 2006 02:02:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc6-mm2
Message-Id: <20061128020246.47e481eb.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Temporarily at

http://userweb.kernel.org/~akpm/2.6.19-rc6-mm2/

Will appear eventually at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/



- Added Francois Romieu's Chelsio driver tree, as git-chelsio.patch



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



Changes since 2.6.19-rc6-mm1:

 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-agpgart.patch
 git-arm.patch
 git-cifs.patch
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
 git-lxdialog.patch
 git-mips.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-ioat.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-r8169.patch
 git-chelsio.patch
 git-selinux.patch
 git-pciseg.patch
 git-s390.patch
 git-sh.patch
 git-scsi-misc.patch
 git-block.patch
 git-sas.patch
 git-sas-fixup.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-wireless.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees

-pcmcia-fix-rmmod-pcmcia-with-unbound-devices.patch
-initramfs-handle-more-than-one-source-dir-or-file-list.patch
-fuse-fix-oops-in-lookup.patch
-mounstats-null-pointer-dereference.patch
-debugfs-add-header-file.patch
-documentation-rtctxt-updates-for-rtc-class.patch
-rtc-framework-handles-periodic-irqs.patch
-rtc-framework-handles-periodic-irqs-fix.patch
-rtc-class-locking-bugfixes.patch
-drivers-rtc-rtc-rs5c372c-fix-a-null-dereference.patch
-reiserfs-fmt-bugfix.patch
-fix-device_attribute-memory-leak-in-device_del.patch
-qconf-fix-uninitialised-member.patch
-fix-menuconfig-colours.patch
-sgiioc4-disable-module-unload.patch
-fix-copy_process-error-check.patch
-tlclk-fix-platform_device_register_simple-error-check.patch
-enforce-unsigned-long-flags-when-spinlocking.patch
-lockdep-spin_lock_irqsave_nested.patch
-lockdep-spin_lock_irqsave_nested-fix.patch
-lockdep-spin_lock_irqsave_nested-fix-2.patch
-correct-bound-checking-from-the-value-returned-from-_ppc-method.patch
-usb-ati-remote-memleak-fix.patch
-sound-initialize-rawmidi-substream-list.patch
-sound-fix-pcm-substream-list.patch
-tidy-gregkh-driver-udev-compatible-hack.patch
-driver-core-introduce-device_move-move-a-device.patch
-platform_driver_probe-can-save-codespace.patch
-documentation-driver-model-platformtxt-update-rewrite.patch
-driver-core-use-klist_remove-in-device_move.patch
-jdelvare-i2c-i2c-kill-icspll-driver-id.patch
-input-make-serio_register_driver-return-error.patch
-input-check-serio_register_driver-error.patch
-input-change-to-gfp_kernel-for-serio_register_driver-event-allocation.patch
-networking-re-fix-of-doc-comment-in-sockh.patch
-make-udp_encap_rcv-use-pskb_may_pull.patch
-parisc-use-unsigned-long-flags-in-semaphore-code.patch
-drivers-pci-hotplug-ibmphp_pcic-fix-null-dereference.patch
-usb-idmouse-cleanup.patch
-usb-writing_usb_driver-free-urb-cleanup.patch
-usb-pcwd_usb-free-urb-cleanup.patch
-usb-iforce-usb-free-urb-cleanup.patch
-usb-usb-gigaset-free-kill-urb-cleanup.patch
-usb-cinergyt2-free-kill-urb-cleanup.patch
-usb-ttusb_dec-free-urb-cleanup.patch
-usb-pvrusb2-hdw-free-unlink-urb-cleanup.patch
-usb-pvrusb2-io-free-urb-cleanup.patch
-usb-pwc-if-free-urb-cleanup.patch
-usb-quickcam_messenger-free-urb-cleanup.patch
-usb-irda-usb-free-urb-cleanup.patch
-usb-zd1201-free-urb-cleanup.patch
-usb-ati_remote-free-urb-cleanup.patch
-usb-ati_remote2-free-urb-cleanup.patch
-usb-hid-core-free-urb-cleanup.patch
-usb-usbkbd-free-urb-cleanup.patch
-usb-auerswald-free-kill-urb-cleanup-and-memleak-fix.patch
-usb-phidgetkit-free-urb-cleanup.patch
-usb-legousbtower-free-kill-urb-cleanup.patch
-usb-phidgetmotorcontrol-free-urb-cleanup.patch
-usb-catc-free-urb-cleanup.patch
-usb-ftdi_sio-kill-urb-cleanup.patch
-usb-io_edgeport-kill-urb-cleanup.patch
-usb-keyspan-free-urb-cleanup.patch
-usb-kobil_sct-kill-urb-cleanup.patch
-usb-mct_u232-free-urb-cleanup.patch
-usb-navman-kill-urb-cleanup.patch
-usb-usb-serial-free-urb-cleanup.patch
-usb-visor-kill-urb-cleanup.patch
-usb-usbmidi-kill-urb-cleanup.patch
-usb-usbmixer-free-kill-urb-cleanup.patch
-usb-pwc-if-loop-fix.patch
-usb-microtek-possible-memleak-fix.patch
-usb-cypress_m8-init-error-path-fix.patch
-usbtouchscreen-add-support-for-dmc-tsc-10-25-devices.patch
-make-drivers-usb-host-u132-hcdcu132_hcd_wait-static.patch
-make-drivers-usb-input-wacom_syscwacom_sys_irq-static.patch
-drivers-usb-misc-ftdi-elanc-fixes-and-cleanups.patch
-make-drivers-usb-core-drivercusb_device_match-static.patch
-usb-serial-replace-kmallocmemset-with-kzalloc.patch
-x86_64-mm-i386-pci-dma-iounmap.patch
-x86_64-smpboot-remove-unused-variable.patch
-uml-make-execvp-safe-for-our-usage.patch
-make-arch-i386-pci-commoncpci_bf_sort-static.patch
-scsi-initio-section-mismatches-with-hotplug=n.patch
-input-add-to-kernel-api-docbook.patch

 Merged into mainline or a subsystem tree

+fix-create_write_pipe-error-check.patch
+ecryptfs-fix-crypto_alloc_blkcipher-error-check.patch

 2.6.19 queue.

+implementation-of-acpi_video_get_next_level.patch
+implementation-of-acpi_video_get_next_level-tidy.patch

 ACPI fixes

+video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-fix.patch

 Fix video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch

+acpi-add-backlight-support-to-the-sony_acpi-v2.patch

 Update acpi-add-backlight-support-to-the-sony_acpi.patch

-git-alsa-fixup.patch

 Unneeded

+sound-soc-soc-dapmc-make-4-functions-static.patch

 Sound cleanup

+audit-fix-kstrdup-error-check.patch

 Audit cleanup

+gregkh-driver-driver-core-make-drivers-base-core.c-setup_parent-static.patch
+gregkh-driver-driver-core-introduce-device_move-move-a-device-to-a-new-parent.patch
+gregkh-driver-driver-core-use-klist_remove-in-device_move.patch
+gregkh-driver-driver-core-platform_driver_probe-can-save-codespace.patch
+gregkh-driver-documentation-driver-model-platform.txt-update-rewrite.patch
+gregkh-driver-modules-state.patch
+gregkh-driver-modules-drivers.patch
+gregkh-driver-driver-core-fixes-make_class_name-retval-checks.patch
+gregkh-driver-driver-core-fixes-sysfs_create_link-retval-checks-in-core.c.patch
+gregkh-driver-driver-core-fixes-device_register-retval-check-in-platform.c.patch
+gregkh-driver-driver-core-don-t-stop-probing-on-probe-errors.patch
+gregkh-driver-driver-core-change-function-call-order-in-device_bind_driver.patch

 Driver tree updates

+driver-core-per-subsystem-multithreaded-probing.patch
+driver-core-dont-fail-attaching-the-device-if-it.patch

 driver core fixes

+git-dvb-budget-ci-fix.patch

 Fix git-dvb.patch

+jdelvare-i2c-i2c-update-i2c-id-list.patch
+jdelvare-i2c-i2c-remove-extraneous-whitespace.patch
+jdelvare-i2c-i2c-core-use-__ATTR.patch

 I2C tree updates

+git-input-vs-git-alsa.patch

 Fix git-input.patch

+sata_nv-fix-atapi-in-adma-mode.patch
+pata_it821x-suspend-resume-support.patch
+pata_serverworks-suspend-resume.patch
+pata_via-suspend-resume-support.patch
+pata_via-suspend-resume-support-fix.patch
+pata_amd-suspend-resume.patch
+hpt36x-suspend-resume-support.patch
+pata_hpt3x3-suspend-resume-support.patch
+pata-more-drivers-that-need-only-standard-suspend-and.patch
+pata_marvell-merge-mandriva-patches.patch

 PATA things

+git-lxdialog-fixup.patch

 Fix rejects in git-lxdialog.patch

+make-drivers-mtd-cmdlinepartcmtdpart_setup-static.patch

 MTD cleanup

-chelsio-22-driver.patch

 Is now in a git tree.

+declance-fix-pmax-and-pmad-support.patch

 Net driver fix

+tulip-dmfe-carrier-detection-fix.patch

 Fix tulip-dmfe-carrier-detection.patch

-git-net-fixup.patch

 Unneeded

+net-possible-cleanups.patch
+net-possible-cleanups-fix.patch
+net-possible-cleanups-fix-2.patch

 Net cleanups, and fixes thereto

-gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g.patch
-tidy-gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g.patch
-fix-gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g.patch
-fix-2-gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g.patch

 Dropped by Greg.  Not sure why.

+gregkh-pci-pci-enable-disable-device-is-nestable.patch
+gregkh-pci-pci-enable-disable-nestable-ports.patch
+gregkh-pci-pci-irq-irq-and-pci_ids-patch-for-intel-ich9.patch
+gregkh-pci-i2c-i801-smbus-patch-for-intel-ich9.patch
+gregkh-pci-pci-change-memory-allocation-for-acpiphp-slots.patch
+gregkh-pci-pci-rpaphp-change-device-tree-examination.patch
+gregkh-pci-pciehp-remove-unnecessary-free_irq.patch
+gregkh-pci-pciehp-remove-unnecessary-pci_disable_msi.patch
+gregkh-pci-pci-ibmphp_pci.c-fix-null-dereference.patch
+gregkh-pci-pci-make-arch-i386-pci-common.c-pci_bf_sort-static.patch

 PCI tree updates

+fix-gregkh-pci-pci-enable-disable-device-is-nestable.patch

 Fix it.

-update-documentation-pcitxt.patch
-pci-move-pci_fixup_device-and-is_enabled.patch
-pci-add-selected_regions-funcs.patch
-e1000-make-intel-e1000-driver-legacy-i-o-port-free.patch
-lpfc-make-emulex-lpfc-driver-legacy-i-o-port-free.patch

 These got destroyed by changes in the PCI tree.

+scsi-in2000-scsi_cmnd-convertion.patch
+scsi-in2000-scsi_cmnd-convertion-tidy.patch
+make-qla2x00_reg_remote_port-static.patch
+iscsi-fix-crypto_alloc_hash-error-check.patch

 scsi updates

+add-missing-libsas-include-to-fix-s390-compilation.patch

 Fix SAS driver build

+gregkh-usb-usb-make-drivers-usb-input-wacom_sys.c-wacom_sys_irq-static.patch
+gregkh-usb-usb-airprime-new-device-id.patch
+gregkh-usb-usb-serial-ti_usb-ti-ez430-development-tool-id.patch
+gregkh-usb-usb-pwc-if-loop-fix.patch
+gregkh-usb-usb-writing_usb_driver-free-urb-cleanup.patch
+gregkh-usb-usb-pcwd_usb-free-urb-cleanup.patch
+gregkh-usb-usb-iforce-usb-free-urb-cleanup.patch
+gregkh-usb-usb-usb-gigaset-free-kill-urb-cleanup.patch
+gregkh-usb-usb-cinergyt2-free-kill-urb-cleanup.patch
+gregkh-usb-usb-ttusb_dec-free-urb-cleanup.patch
+gregkh-usb-usb-pvrusb2-hdw-free-unlink-urb-cleanup.patch
+gregkh-usb-usb-pvrusb2-io-free-urb-cleanup.patch
+gregkh-usb-usb-pwc-if-free-urb-cleanup.patch
+gregkh-usb-usb-sn9c102_core-free-urb-cleanup.patch
+gregkh-usb-usb-quickcam_messenger-free-urb-cleanup.patch
+gregkh-usb-usb-zc0301_core-free-urb-cleanup.patch
+gregkh-usb-usb-irda-usb-free-urb-cleanup.patch
+gregkh-usb-usb-zd1201-free-urb-cleanup.patch
+gregkh-usb-usb-ati_remote-free-urb-cleanup.patch
+gregkh-usb-usb-ati_remote2-free-urb-cleanup.patch
+gregkh-usb-usb-hid-core-free-urb-cleanup.patch
+gregkh-usb-usb-usbkbd-free-urb-cleanup.patch
+gregkh-usb-usb-auerswald-free-kill-urb-cleanup-and-memleak-fix.patch
+gregkh-usb-usb-legousbtower-free-kill-urb-cleanup.patch
+gregkh-usb-usb-phidgetkit-free-urb-cleanup.patch
+gregkh-usb-usb-phidgetmotorcontrol-free-urb-cleanup.patch
+gregkh-usb-usb-ftdi_sio-kill-urb-cleanup.patch
+gregkh-usb-usb-catc-free-urb-cleanup.patch
+gregkh-usb-usb-io_edgeport-kill-urb-cleanup.patch
+gregkh-usb-usb-keyspan-free-urb-cleanup.patch
+gregkh-usb-usb-kobil_sct-kill-urb-cleanup.patch
+gregkh-usb-usb-mct_u232-free-urb-cleanup.patch
+gregkh-usb-usb-navman-kill-urb-cleanup.patch
+gregkh-usb-usb-usb-serial-free-urb-cleanup.patch
+gregkh-usb-usb-visor-kill-urb-cleanup.patch
+gregkh-usb-usb-usbmidi-kill-urb-cleanup.patch
+gregkh-usb-usb-usbmixer-free-kill-urb-cleanup.patch
+gregkh-usb-ohci-change-priority-level-of-resume-log-message.patch
+gregkh-usb-usb-fix-aircable.c-inconsequent-null-checking.patch
+gregkh-usb-usb-core-fix-compiler-warning-about-usb_autosuspend_work.patch
+gregkh-usb-usb-add-digitech-usb-storage-to-unusual_devs.h.patch
+gregkh-usb-usb-microtek-possible-memleak-fix.patch
+gregkh-usb-usb-net2280-don-t-send-unwanted-zero-length-packets.patch
+gregkh-usb-usb-ehci-hooks-for-high-speed-electrical-tests.patch
+gregkh-usb-usb-add-ehci_hcd.ignore_oc-parameter.patch
+gregkh-usb-usb-cypress_m8-init-error-path-fix.patch
+gregkh-usb-usb-make-drivers-usb-host-u132-hcd.c-u132_hcd_wait-static.patch
+gregkh-usb-usb-ftdi-elan.c-fixes-and-cleanups.patch
+gregkh-usb-usb-usbtouchscreen-add-support-for-dmc-tsc-10-25-devices.patch
+gregkh-usb-usb-pxa2xx_udc-recognizes-ixp425-rev-b0-chip.patch
+gregkh-usb-usb-lh7a40x_udc-remove-double-declaration.patch
+gregkh-usb-usb-make-drivers-usb-core-driver.c-usb_device_match-static.patch
+gregkh-usb-usb-idmouse-cleanup.patch
+gregkh-usb-usb-hid-core-canonical-defines-for-apple-usb-device-ids.patch
+gregkh-usb-usb-serial-replace-kmalloc-memset-with-kzalloc.patch
+gregkh-usb-usb-build-the-appledisplay-driver.patch
+gregkh-usb-usb-endianness-fix-for-asix.c.patch
+gregkh-usb-usb-pegasus-error-path-not-resetting-task-s-state.patch
+gregkh-usb-usb-added-dynamic-major-number-for-usb-endpoints.patch
+gregkh-usb-usb-multithread.patch
+gregkh-usb-ohci-make-autostop-conditional-on-config_pm.patch
+gregkh-usb-usb-struct-usb_device-change-flag-to-bitflag.patch
+gregkh-usb-usb-hub-simplify-remote-wakeup-handling.patch
+gregkh-usb-usb-keep-count-of-unsuspended-children.patch
+gregkh-usb-usbcore-remove-unused-argument-in-autosuspend.patch

 USB tree updates

+x86_64-mm-remove-unused-apic-ver.patch
+x86_64-mm-msr-comment.patch
+x86_64-mm-add-sysctl-for-kstack_depth_to_print.patch
+x86_64-mm-clear-bss-early.patch
+x86_64-mm-remove-duplicate-arch_discontigmem_enable-option.patch
+x86_64-mm-172-kobject_init-on-resume-from-disk.patch
+x86_64-mm-i386-touch-watchdog-in-backtrace.patch
+x86_64-mm-remove-unused-acpi-madt.patch
+x86_64-mm-unify-rewrite-smp-tsc-sync-code.patch
+x86_64-mm-always-enable-regparm.patch
+x86_64-mm-rdtsc-sync-amd-single-core.patch

 x86_64 tree updates

+fix-x86_64-mm-i386-config-core2.patch

 Fix it.

+x86-64-change-the-size-for-interrupt-array-to-nr_vectors.patch

 x86_64 fix

+mm-cleanup-indentation-on-switch-for-cpu-operations.patch

 MM cleanup

+selinux-fix-dentry_open-error-check.patch

 SELinux fixlet.

+implement-file-posix-capabilities.patch

 Bring this back.

+s2ram-debugging-documentation.patch

 suspend-to-RAM docs

+fs-reorder-some-struct-inode-fields-to-speedup-i_size-manipulations.patch
+add-struct-dev-pointer-to-dma_is_consistent.patch
+handle-per-subsystem-mutexes-for-config_hotplug_cpu-not-set.patch
+handle-per-subsystem-mutexes-for-config_hotplug_cpu-not-set-tidy.patch
+dz-fixes-to-make-it-work.patch
+dz-fixes-to-make-it-work-fix.patch
+reiser-replace-kmallocmemset-with-kzalloc.patch
+futex-init-error-check.patch
+spi-check-platform_device_register_simple-error.patch
+synclink_gt-fix-init-error-handling.patch
+sysctl-string-length-calculated-is-wrong-if-it-contains-negative-numbers.patch
+sched-correct-output-of-show_state.patch
+reiserfs-do-not-add-save-links-for-o_direct-writes.patch

 Misc

-io-accounting-core-statistics-fix.patch

 Foxled into io-accounting-core-statistics.patch

-io-accounting-metadata-read-accounting.patch

 Dropped - unneeded.

+ext4-if-expression-format.patch
+ext4-kmalloc-to-kzalloc.patch
+ext4-eliminate-inline-functions.patch

 ext4 cleanups

+generic-bug-implementation-include-linux-bugh-must-always-include-linux-moduleh.patch

 Fix the generic BUG implementation

+fsstack-introduce-fsstack_copy_attrinode_-fs-stackc-should-include-linux-fs_stackh.patch

 Fix fsstack-introduce-fsstack_copy_attrinode_.patch

+i4l-remove-the-broken-hisax_amd7930-option.patch

 ISDN cleanup

+sched-improve-migration-accuracy-fix.patch

 Fix sched-improve-migration-accuracy.patch

+sysctl-simplify-sysctl_uts_string.patch
+sysctl-implement-sysctl_uts_string.patch
+sysctl-simplify-ipc-ns-specific-sysctls.patch
+sysctl-fix-sys_sysctl-interface-of-ipc-sysctls.patch
+sysctl-fix-sys_sysctl-interface-of-ipc-sysctls-fix.patch

 susctl fixes/cleanups

+readahead-events-accounting-make-readahead_debug_level-static.patch
+readahead-context-based-method-locking-fix.patch
+readahead-context-based-method-locking-fix-2.patch

 Fix readahead code in -mm.

+fs-reiser4-more-possible-cleanups.patch

 reiser4 cleanups

+kvm-userspace-interface-make-enum-values-in-userspace-interface-explicit.patch

 Fix kvm-userspace-interface.patch

+kvm-clarify-licensing.patch

 KVM updates

+kvm-create-kvm-intelko-module.patch
+kvm-make-dev-registration-happen-when-the-arch.patch
+kvm-make-hardware-detection-an-arch-operation.patch
+kvm-make-the-per-cpu-enable-disable-functions-arch.patch
+kvm-make-the-hardware-setup-operations-non-percpu.patch
+kvm-make-the-guest-debugger-an-arch-operation.patch
+kvm-make-msr-accessors-arch-operations.patch
+kvm-make-the-segment-accessors-arch-operations.patch
+kvm-cache-guest-cr4-in-vcpu-structure.patch
+kvm-cache-guest-cr0-in-vcpu-structure.patch
+kvm-add-get_segment_base-arch-accessor.patch
+kvm-add-idt-and-gdt-descriptor-accessors.patch
+kvm-make-syncing-the-register-file-to-the-vcpu.patch
+kvm-make-the-vcpu-execution-loop-an-arch-operation.patch
+kvm-move-the-vmx-exit-handlers-to-vmxc.patch
+kvm-make-vcpu_setup-an-arch-operation.patch
+kvm-make-__set_cr0-and-dependencies-arch-operations.patch
+kvm-make-__set_cr4-an-arch-operation.patch
+kvm-make-__set_efer-an-arch-operation.patch
+kvm-make-set_cr3-and-tlb-flushing-arch-operations.patch
+kvm-make-inject_page_fault-an-arch-operation.patch
+kvm-make-inject_gp-an-arch-operation.patch
+kvm-use-the-idt-and-gdt-accessors-in-realmode-emulation.patch
+kvm-use-the-general-purpose-register-accessors-rather.patch
+kvm-move-the-vmx-tsc-accessors-to-vmxc.patch
+kvm-access-rflags-through-an-arch-operation.patch
+kvm-move-the-vmx-segment-field-definitions-to-vmxc.patch
+kvm-add-an-arch-accessor-for-cs-d-b-and-l-bits.patch
+kvm-add-a-set_cr0_no_modeswitch-arch-accessor.patch
+kvm-make-vcpu_load-and-vcpu_put-arch-operations.patch
+kvm-make-vcpu-creation-and-destruction-arch-operations.patch
+kvm-move-vmcs-static-variables-to-vmxc.patch
+kvm-make-is_long_mode-an-arch-operation.patch
+kvm-use-the-tlb-flush-arch-operation-instead-of-an.patch
+kvm-remove-guest_cpl.patch
+kvm-move-vmcs-accessors-to-vmxc.patch
+kvm-move-vmx-helper-inlines-to-vmxc.patch
+kvm-remove-vmx-includes-from-arch-independent-code.patch

 More KVM work

+kvm-build-fix.patch
+kvm-build-fix-2.patch

 sort-of fix it.

+add-debugging-aid-for-memory-initialisation-problems.patch
+add-debugging-aid-for-memory-initialisation-problems-fix.patch

 MM debugging





All 1641 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/patch-list


