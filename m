Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVFTGbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVFTGbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 02:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVFTGbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 02:31:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261476AbVFTGat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 02:30:49 -0400
Date: Sun, 19 Jun 2005 23:30:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-mm1
Message-Id: <20050619233029.45dd66b8.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/


- Someone broke /proc/device-tree on ppc64.  It's being looked into.

- Nothing particularly special here - various fixes and updates.



Changes since 2.6.12-rc6-mm1:


-ppc32-add-linux-compilerh-to-asm-sigcontexth.patch
-include-linux-configh-before-testing-config_acpi.patch
-uml-make-the-emulated-iomem-driver-work-on-26.patch
-uml-compile-fixes-for-gcc-4.patch
-uml-fix-strace-f.patch
-uml-clean-up-error-path.patch
-uml-link-tt-mode-against-nptl.patch
-send_ipi_mask_sequence-warning-fix.patch
-ppc32-add-405ep-cpu_spec-entry.patch
-input-disable-scroll-feature-on-at-keyboards.patch
-agp-fix-for-xen-vmm.patch
-fix-agp-code-to-work-again-with-non-pci-agp-bridges.patch
-i2c-chips-need-hwmon.patch
-gregkh-i2c-hwmon-02-sparc64-fix.patch
-fix-tulip-suspend-resume.patch
-tcp-fix-weightp.patch
-tcp-tcp_westwood-kconfig-fix.patch
-gregkh-pci-pci-pci-transparent-bridge-handling-improvements-pci-core.patch
-gregkh-pci-pci-serverworks-gc-quirk.patch
-gregkh-pci-pci-dma-bursting-advice-fix.patch
-pci-do-via-irq-fixup-always-not-just-in-pic-mode.patch
-gregkh-usb-speedtch-prep.patch
-ipt_recent-fixes.patch
-update-ppc64-defconfig.patch
-fix-ide-scsi-eh-locking.patch
-stop-arch-i386-kernel-vsyscall-noteo-being-rebuilt-every-time.patch
-v9fs-documentation-makefiles-configuration-fix.patch
-v9fs-vfs-file-dentry-and-directory-operations-fix.patch
-docbook-maintainer.patch

 Merged

+aic79xx-deadlock-fix.patch
+aic79xx-ahd_linux_dev_reset-cleanup.patch
+aic79xx-deadlock-fix-2.patch
+aic79xx-deadlock-fix-3.patch

 Fix aic79xx instadeadlock

+md-__rh_alloc-rh_update_states-race-in-dm-raid1c.patch
+md-fix-rh_dec-rh_inc-race-in-dm-raid1c.patch

 raid1 fixes

+nfs-nfs3-page-null-fill-in-a-short-read-situation.patch

 nfs fix

+coverity-ipmi-avoid-overrun-of-ipmi_interfaces.patch
+coverity-cpufreq-check-cpufreq_cpu_get-return.patch
+coverity-idr_get_new_above_int-overrun-fix.patch

 Fix things found by the Coverity checker.

+gregkh-driver-sysfs-page_size-check.patch
+gregkh-driver-driver-device_attr-08-fix.patch
-gregkh-i2c-hwmon-01.patch
-gregkh-i2c-hwmon-02.patch
-gregkh-i2c-hwmon-03.patch
+gregkh-i2c-i2c-max6875.patch
+gregkh-i2c-i2c-rename-i2c-sysfs.patch
+gregkh-i2c-i2c-pca9539.patch
+gregkh-i2c-i2c-ds1374-01.patch
+gregkh-i2c-i2c-ds1374-02.patch
+gregkh-i2c-i2c-ds1374-03.patch
+gregkh-i2c-i2c-w83781d-remove-non-i2c-chips.patch
+gregkh-i2c-w1-01.patch
+gregkh-i2c-w1-02.patch
+gregkh-i2c-w1-03.patch
+gregkh-i2c-w1-04.patch
+gregkh-i2c-w1-05.patch
+gregkh-i2c-w1-06.patch
+gregkh-i2c-w1-07.patch

 Updates to the driver core tree

+gregkh-i2c-i2c-ds1374-01-fix.patch

 fix i2c tree

+fix-tulip-suspend-resume-2.patch
+ipw2100-assume-recent-kernel.patch
+ipw2100-kill-dead-macros.patch
+ipw2100-small-cleanups.patch
+ipw2100-cleanup-debug-prints.patch

 Various fixes against git netdev trees

-scalable-tcp-cleaned.patch
+tcp-scaleable_tcp.patch

 Updated Scalable TCP congestion control algorithm

+gregkh-pci-pci-pci-dma-bursting-advice-fix.patch
+gregkh-pci-pci-handle-subtractive-decode.patch
+gregkh-pci-pci-msi-cleanup.patch
+gregkh-pci-pci-cpqphp-fix-oops-on-unload.patch
+gregkh-pci-pci-assign-unassigned-resources.patch
+gregkh-pci-pci-acpi-mcfg-01.patch
+gregkh-pci-pci-acpi-mcfg-02.patch
+gregkh-pci-pci-acpi-mcfg-03.patch
+gregkh-pci-pci-acpi-mcfg-04.patch

 PCI tree updates

+git-scsi-misc-drivers-scsi-chc-remove-devfs-stuff.patch

 Remove devfs stuff added in the scsi changer driver

+gregkh-usb-usb-speedtch-prep.patch
+gregkh-usb-usb-usblp_read-up-fix.patch
+gregkh-usb-usb-storage-endpoint-toggle.patch
+gregkh-usb-usb-storage-retry-hard-errors.patch
+gregkh-usb-usb-usbnet-debug-fix.patch
+gregkh-usb-usb-gadget-pxa-build-fix.patch
+gregkh-usb-usb-fix-inverted-test-for-resuming-interfaces.patch

 USB updates

+sparsemem-memory-model-fix-6.patch
+sparsemem-memory-model-section-numbers-unsigned-long.patch
+sparsemem-hotplug-base-abstract-section-number-to-section-mapping.patch
+sparsemem-extreme.patch

 sparsemem fixes and enhancements

+reduce-size-of-huge-boot-per_cpu_pageset.patch

 Reduce footprint of the per-cpu pageset patch

+kill-stray-newline.patch

 Small cleanup

+3c59x-remove-superfluous-vortex_debug-test-from-boomerang_start_xmit.patch
+defxx-use-irqreturn_t-for-the-interrupt-handler.patch
+fix-int-vs-pm_message_t-confusion-in-airo.patch
+fealnxc-calls-dev_kfree_skb-from-atomic-context-fix-it.patch

 net driver fixes

+vfs-memory-leak-in-do_kern_mount.patch
+selinux-memory-leak-in-selinux_sb_copy_data.patch

 Fix memory leaks

+ppc32-fix-config_task_size-handling-on-40x.patch
+ppc32-add-support-for-mpc8245-8250-serial-ports-on-sandpoint.patch
+ppc32-remove-orphaned-ppc4xx_kgdbc.patch
+ppc32-added-support-for-all-mpc8548-internal-interrupts.patch
+ppc32-clean-up-num_tlbcams-usage-for-freescale-book-e-ppcs.patch
+ppc32-factor-out-common-exception-code-into-macros-for.patch
+ppc32-remove-some-unnecessary-includes-of-promh.patch
+ppc32-dont-recursively-crash-in-die-on-chrp-prep-machines.patch

 ppc32 updates

+ppc64-iseries-irq-simple-cleanups.patch
+ppc64-iseries-remove-xmpcilpeventc.patch
+ppc64-iseries-tidy-up-irq-code-after-merge.patch
+ppc64-iseries-allow-build-with-no-pci.patch
+ppc64-tidy-up-vio-devices-fake-parent.patch

 ppc64 updates

+mips-add-vr41xx-gpio-support.patch
+mips-add-vr41xx-gpio-support-fix.patch

 MIPS feature work

+x86-cpu_khz-type-fix.patch

 Make x86's cpu_khz have the same type as x86_64's

+move-some-more-structures-into-mostly_readonly-and-readonly.patch

 Use the mostly_readonly section a bit more (all this will either change a
 lot or get dropped)

+x86_64-div-by-zero-fix.patch

 Kludge around a divide-by-zero which happens when x86_64 falls back to the
 HPET driver.

+dmi-move-acpi-sleep-quirk-fix.patch

 Fix dmi-move-acpi-sleep-quirk.patch

+i386-dont-use-ipi-broadcast-when-using-cpu-hotplug.patch
+i386-hold-call_lock-when-updating-cpu_online_map.patch
+cpu-state-clean-after-hot-remove-set-cpu_state-for-cpu-hotplug.patch
+cpu-state-clean-after-hot-remove-fix-2.patch

 x86 cpu hotplug fixes

+x86_64-cpu-hotplug-support-fix.patch
+x86_64-dont-use-broadcast-shortcut-to-make-it-cpu-hotplug-safe-fix.patch
+x86_64-dont-use-broadcast-shortcut-to-make-it-cpu-hotplug-safe-fix-set-cpu_state-for-cpu-hotplug.patch
+set-cpu_state-for-cpu-hotplug-ia64.patch

 x86_64 cpu hotplug fixes

+uml-complete-hw_controller_type-release-conversion.patch
+uml-make-hw_controller_type-release-exist-only-for-archs-needing-it.patch
+uml-link-tt-mode-against-nptl.patch

 UML updates

+areca-raid-linux-scsi-driver-fix.patch

 Fix areca-raid-linux-scsi-driver.patch

+cfq-iosched-update-to-time-sliced-design-find_next_crq-fix.patch

 CFQ3 fix

-set-ms_active-bit-before-calling-fill_super.patch

 Dropped

+fix-for-prune_icache-forced-final-iput-races.patch

 Different fix from Al Viro

+as-limit-queue-depth-fix.patch

 Fix as-limit-queue-depth.patch (which should be dropped anyway)

+kprobes-move-aggregate-probe-handlers-and-few-return-probe-routines-to-static.patch
-kprobes-ia64-cmp-ctype-unc-support.patch
+kprobes-ia64-cmp-ctype-unc-support.patch

 More kprobes work

+use-drivers-kconfig-for-sparc32.patch

 sparc32 Kconfig cleanup

+acl-endianess-annotations.patch

 Add endianness notations to the ACL code

+remove-linux-xattr_aclh.patch

 Kill unused file

+bug-in-error-recovery-in-fs-bufferc__block_prepare_write.patch

 VFS error handling fix

+dpt_i2o-waitqueue-fix.patch

 Make dpt_i2o use the proper waitqueue functions

+aio-fix-do_sync_readwrite-to-properly-handle-aio-retries.patch
+aio-make-wait_queue-task-private.patch

 Some waitqueue infrastructure work for forthcoming AIO enhancements.

+add-note-about-verify_area-removal-to.patch

 feature-removal.txt update

+ide-cd-reports-current-speed.patch

 ide-cd message fix

+pwc-uncompress-warning-fix.patch

 Fix a warning

+introduce-tty_unregister_ldisc.patch
+convert-users-to-tty_unregister_ldisc.patch

 API sanity in the tty code

+ibmasm-driver-fix-command-buffer-size.patch
+ibmasm-driver-correctly-wake-up-sleeping-threads.patch
+ibmasm-driver-redesign-handling-of-remote-control.patch
+ibmasm-driver-redesign-handling-of-remote-control-fix.patch
+ibmasm-driver-fix-race-in-command-refcount-logic.patch

 IBMASM driver updates

+rapidio-support-core-base-rapidio-support-core-base.patch
+rapidio-support-core-enum-fix.patch
+rapidio-support-ppc32-fix.patch
+rapidio-support-ppc32-add-error-checking-to-mpc85xx.patch

 RapidIO driver updates

+pass-iocb-to-dio_iodone_t.patch

 Infrastructure work for future XFS changes

+tpm-improve-output-in-sysfs-files-when-the-tpm-fails.patch

 More TPM driver work

-inotify-44.patch
-inotify-44-update.patch
-inotify-44-warning-fix.patch
-inotify-44-update-2.patch
+inotify-45.patch

 Updated inotofy patch

+add-generalized-dvb-usb-driver-fix-4.patch

 Fix add-generalized-dvb-usb-driver.patch some more

+dvb-documentation-fixes.patch

 DVB documentation update

+pcmcia-id_table-for-sl811_cs.patch

 Additional pcmcia ID table

+iteraid.patch

 Bring back the ITE RAID vendor driver.  Someone might find it useful.

+nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus-fix.patch

 Fix nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch

+sched-consolidate-sbe-sbf-fix-3.patch

 Fix sched-consolidate-sbe-sbf.patch even more

+max_user_rt_prio-and-max_rt_prio-are-wrong.patch
+scheduler-cache-hot-autodetect.patch
+scheduler-cache-hot-autodetect-cacheflush-fix.patch
+scheduler-cache-hot-autodetect-cacheflush-fix-2.patch
+sched-idlest-cpus_allowed-aware.patch

 CPU scheduler updates

+v4l-support-tuner-thomson-ddt-7611-atsc-ntsc.patch
+bttv-update.patch
+v4l-cx88-cards-update.patch
+v4l-update-for-tuner-cards-and-some-chips.patch
+v4l-update-for-tuner-cards-and-some-chips-fix.patch
+v4l-update-for-saa7134-cards.patch
+v4l-update-for-saa7134-cards-fix.patch
+v4l-update-for-saa7134-cards-fix-2.patch

 v4l updates

+gregkh-i2c-i2c-address_range_removal-v4l-fix.patch
+gregkh-i2c-i2c-address_range_removal-v4l-fix-fix.patch

 Fix v4l updates for changes in Greg's i2c tree

+nfs-patch-for-fscache.patch
+nfs-patch-for-fscache-fixes.patch
+nfs-patch-for-fscache-warning-fix.patch

 Add support for local blockdev caching of NFS files

+files-fix-rcu-initializers.patch
+files-rcuref-apis.patch
+files-break-up-files-struct.patch
+files-break-up-files-struct-ia64-fix.patch
+files-files-struct-with-rcu.patch
+files-lock-free-fd-look-up.patch
+files-files-locking-doc.patch

 RCUify the files_lock

-reiser4-allow-drop_inode-implementation.patch
+reiser4-sb_sync_inodes-cleanup.patch
-reiser4-export-inode_lock.patch
+reiser4-update.patch

 New reiser4 code drop

+serial-eliminate-magic-numbers.patch

 small cleanup

+new-framebuffer-fonts-updated-12x22-font-available.patch
+fbdev-stack-reduction.patch
+fbdev-fill-in-the-access_align-field.patch

 fbdev updates

+modules-add-version-and-srcversion-to-sysfs-fix-3.patch

 Fix modules-add-version-and-srcversion-to-sysfs.patch yet again.

+docbook-build-fix.patch

 Fix docbook build

+xip-reduce-code-duplication.patch

 Reduce code duplication in the execute-in-place patches.



number of patches in -mm: 1506
number of changesets in external trees: 53
number of patches in -mm only: 1504
total patches: 1557



All 1506 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/patch-list


