Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWFJEk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWFJEk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 00:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWFJEk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 00:40:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030256AbWFJEk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 00:40:27 -0400
Date: Fri, 9 Jun 2006 21:40:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc6-mm2
Message-Id: <20060609214024.2f7dd72c.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/


- Added the s390 git tree to the -mm lineup, as git-s390.patch (Martin
  Schwidefsky)

- ppc64 (on mac g5) fails to boot for me, due to changes in the powerpc tree.

- `make allnoconfig' builds will fail due to the IPC namespaces patches

- A reminder that I'm travelling for the next week and shall be more than
  usually useless.




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




Changes since 2.6.16-rc6-mm1:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-arm.patch
 git-audit-master.patch
 git-block.patch
 git-cifs.patch
 git-cpufreq.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-jfs.patch
 git-kbuild.patch
 git-klibc.patch
 git-hdrcleanup.patch
 git-hdrinstall.patch
 git-libata-all.patch
 git-mips.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-rbtree.patch
 git-sas.patch
 git-pcmcia.patch
 git-s390.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 git trees

-fix-hpet-operation-on-32-bit-nvidia-platforms.patch
-fix-hpet-operation-on-64-bit-nvidia-platforms.patch
-ep93xx-build-fix.patch
-fix-mempolicyh-build-error.patch
-fbcon-fix-limited-scroll-in-scroll_pan_redraw-mode.patch
-s390-cleanup-bitopsh.patch
-uninorth-agp-warning-fixes.patch
-alpha-agp-warning-fix.patch
-s390_hypfs-filesystem.patch
-opencores-i2c-bus-driver.patch
-add-dependency-on-kernelrelease-to-the-package-targets.patch
-kconfig-improve-config-load-save-output.patch
-kconfig-fix-config-dependencies.patch
-kconfig-remove-symbol_yesmodno.patch
-kconfig-allow-multiple-default-values-per-symbol.patch
-kconfig-allow-loading-multiple-configurations.patch
-kconfig-integrate-split-config-into-silentoldconfig.patch
-kconfig-integrate-split-config-into-silentoldconfig-fix.patch
-kconfig-move-kernelrelease.patch
-kconfig-add-symbol-option-config-syntax.patch
-kconfig-add-defconfig_list-module-option.patch
-kconfig-add-search-option-for-xconfig.patch
-kconfig-finer-customization-via-popup-menus.patch
-kconfig-create-links-in-info-window.patch
-kconfig-jump-to-linked-menu-prompt.patch
-kconfig-warn-about-leading-whitespace-for-menu-prompts.patch
-kconfig-remove-leading-whitespace-in-menu-prompts.patch
-config-exit-if-no-beginning-filename.patch
-make-kernelrelease-speedup.patch
-kconfig-kconfig_overwriteconfig.patch
-sane-menuconfig-colours.patch
-kbuild-export-type-enhancement-to-modpostc.patch
-kbuild-export-type-enhancement-to-modpostc-fix.patch
-kbuild-prevent-building-modules-that-wont-load.patch
-kbuild-obj-dirs-is-calculated-incorrectly-if-hostprogs-y-is-defined.patch
-fix-make-rpm-for-powerpc.patch
-kinit-convert--in-block-device-names-to-not.patch
-klibc-ia64-fix.patch
-myri10ge-alpha-build-fix.patch
-pci-error-recovery-e1000-network-device-driver.patch
-pci-error-recovery-e100-network-device-driver.patch
-drivers-char-hw_randomc-remove-asserts.patch
-selinux-add-security-class-for-appletalk-sockets.patch
-secmark-add-new-flask-definitions-to-selinux.patch
-secmark-add-selinux-exports.patch
-secmark-add-secmark-support-to-core-networking.patch
-secmark-add-xtables-secmark-target.patch
-secmark-add-secmark-support-to-conntrack.patch
-secmark-add-connsecmark-xtables-target.patch
-secmark-add-new-packet-controls-to-selinux.patch
-recent-match-fix-sleeping-function-called-from-invalid-context.patch
-recent-match-missing-refcnt-initialization.patch
-powerpc-kbuild-warning-fix.patch
-gregkh-pci-kconfigurable-resources-arch-dependent-changes-arm-fix.patch
-gregkh-pci-pci-64-bit-resources-core-changes-mips-fix.patch
-kconfigurable-resources-mtd-fixes.patch
-msi-k8t-neo2-fir-run-only-where-needed.patch
-pcmcia-fix-kernel-doc-function-name.patch
-drivers-scsi-fix-proc_scsi_write-to-return-length-on.patch
-gregkh-usb-usb-sisusbvga-possible-cleanups-fix.patch
-add-apple-macbook-product-ids-to-usbhid.patch
-fall-back-to-old-style-call-trace-if-no-unwinding.patch
-allow-unwinder-to-build-without-module-support.patch
-add-abilty-to-enable-disable-nmi-watchdog-from-procfs.patch
-lock-validator-lockdep-small-xfs-init_rwsem-cleanup.patch
-powerpc-vdso-updates.patch
-add-prctl-to-change-endian-of-a-task.patch
-powerpc-implement-support-for-setting.patch
-powerpc-implement-pr_et_unalign-prctls-for-powerpc.patch
-ip2-fix-sections.patch

 Merged into mainline or a subsystem tree

+ehci-works-again-on-nvidia-controllers-with-2gb-ram.patch
+further-alterations-for-memory-barrier-document.patch
+powernow-k8-crash-workaround.patch
+bugfixes-to-get-i2o-working-again.patch

 2.6.17 queue

+revert-powernow-k8-crash-workaround.patch

 Needed to make git-acpi apply

 git-acpi.patch

+reapply-powernow-k8-crash-workaround.patch

 Apply it again after git-acpi

-acpi-dock-driver-acpi_get_device-fix.patch

 Folded into acpi-dock-driver.patch

-acpi-atlas-acpi-driver-fix.patch

 Folded into acpi-atlas-acpi-driver.patch

-remove-acpi_os_create_lock-acpi_os_delete_lock.patch

 Dropped

-acpi-remove-__init-__exit-from-sony-add-remove-methods.patch

 Folded into 2.6-sony_acpi4.patch

+gregkh-i2c-i2c-Kconfig-suggest-N-for-rare-devices.patch
+gregkh-i2c-i2c-opencores-new-driver.patch
+gregkh-i2c-hwmon-sysfs-interface-update-1.patch
+gregkh-i2c-hwmon-sysfs-interface-update-2.patch
+gregkh-i2c-hwmon-hdaps-typo.patch
+gregkh-i2c-hwmon-maintenance-update.patch
+gregkh-i2c-hwmon-w83792d-pwm-set-fix.patch
+gregkh-i2c-hwmon-w83792d-add-data-lock.patch
+gregkh-i2c-hwmon-abituguru-new-driver.patch
+gregkh-i2c-hwmon-abituguru-fixes.patch
+gregkh-i2c-hwmon-abituguru-nofans-detect-fix.patch

 I2C tree updates

+git-kbuild-modpost-build-fix.patch

 Make git-kbuild build

+git-klibc-ia64-build-fix.patch

 klibc fix

-libata-add-missing-data_xfer-for-pata_pdc2027x-and-pdc_adma-fix.patch

 Folded into libata-add-missing-data_xfer-for-pata_pdc2027x-and-pdc_adma.patch

-lock-validator-fix-ns83820c-irq-flags-bug-part.patch
-lock-validator-fix-ns83820c-irq-flags-part-3.patch

 Folded into lock-validator-fix-ns83820c-irq-flags-bug.patch

+forcedeth-xmit_lock-went-away.patch

 Fix forcedeth patches in -mm for git-net changes

+gregkh-pci-pci-64-bit-resource-drivers-mips-changes.patch
-gregkh-pci-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms.patch
+gregkh-pci-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms.patch
+gregkh-pci-pci-msi-k8t-neo2-fir-run-only-where-needed.patch
+gregkh-pci-fix-pci_get_device-usage-in-mpc85xx.patch

 PCI tree updates

+mm-gregkh-pci-pci-ignore-pre-set-64-bit-bars-on-32-bit-platforms-fix.patch

 Fix it.

+git-pcmcia-fixup.patch
+git-pcmcia-fixup-2.patch

 Fix rejects in git-pcmcia (due to git-alsa)

-gdth-add-execute-firmware-command-abstraction.patch
-drivers-scsi-gdthc-make-__gdth_execute-static.patch

 Dropped, due to remove-the-scsi_request-interface-from-the-gdth-driver.patch

+remove-the-scsi_request-interface-from-the-gdth-driver.patch

 gdth scsi driver update

-gregkh-usb-usb-zd1201-cleanups.patch
+gregkh-usb-usb-free-allocated-memory-on-io_edgeport-startup-memory-failure.patch
+gregkh-usb-usb-ehci-on-non-au1200-build-fix.patch
+gregkh-usb-usb-add-apple-macbook-product-ids-to-usbhid.patch
+gregkh-usb-usb-storage-unusual_devs-entry-for-nikon-dsc-d70s.patch
+gregkh-usb-uhci-various-updates.patch
+gregkh-usb-uhci-remove-hc_inaccessible-flag.patch
+gregkh-usb-uhci-improve-fsbr-off-timing.patch

 USB tree updates

+x86_64-mm-x86_86-msi-miss-one-entry-handler.patch
+x86_64-mm-fall-back-to-old-style-call-trace-if-no-unwinding.patch
+x86_64-mm-allow-unwinder-to-build-without-module-support.patch
-x86_64-mm-spinlock-short.patch
+x86_64-mm-polling-thread-status.patch
-revert-x86_64-mm-spinlock-short.patch

 x86_64 updates

+mm-x86_64-mm-polling-thread-status-fix.patch

 Fix it.

+x86_64-setupc-print-cmp-related-boottime-information.patch

 x86_64 diagnostic info

+zoned-vm-counters-per-zone-counter-functionality.patch
+zoned-vm-counters-per-zone-counter-functionality-tidy.patch
+zoned-vm-counters-per-zone-counter-functionality-fix.patch
+zoned-vm-counters-per-zone-counter-functionality-fix-fix.patch
+zoned-vm-counters-include-per-zone-counters-in-proc-vmstat.patch
+zoned-vm-counters-conversion-of-nr_mapped-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_pagecache-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_pagecache-to-per-zone-counter-fix.patch
+zoned-vm-counters-use-per-zone-counters-to-remove-zone_reclaim_interval.patch
+zoned-vm-counters-add-per-zone-counters-to-zone-node-and-global-vm-statistics.patch
+zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_pagetable-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter.patch
+zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter.patch
+zoned-vm-counters-remove-unused-get_page_stat-functions.patch
+zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter.patch
+zoned-vm-counters-remove-useless-writeback-structure.patch
+zoned-vm-stats-remove-nr_mapped-from-zone-reclaim.patch
+zoned-vm-stats-add-nr_anon.patch
+light-weight-counters-framework.patch
+light-weight-counters-framework-warning-fixes.patch
+light-weight-counters-framework-fix.patch
+light-weight-counters-framework-s390-fix.patch
+light-weight-counters-framework-s390-fix-fix.patch
+light-weight-counters-framework-s390-fix-fix-fix.patch
+light-weight-counters-framework-arm-fix.patch
+light-weight-counters-framework-uml-fix.patch

 New way of accumulating VM metrics.

+vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386-2-revert-maxmem-change.patch

 Revert stray hunk from the vdso patches

+add-__iowrite64_copy-s390-fix.patch

 Fix add-__iowrite64_copy.patch

-allow-for-per-cpu-data-being-in-tdata-and-tbss-sections.patch
-allow-for-per-cpu-data-being-in-tdata-and-tbss-sections-fix.patch
-allow-for-per-cpu-data-being-in-tdata-and-tbss-sections-tidy.patch

 Dropped

+add-driver-for-arm-amba-pl031-rtc-fix.patch

 Fix rtc-subsystem-fix-capability-checks-in-kernel-interface.patch

+rtc-add-rtc_year_days-to-calculate-tm_yday.patch
+at91rm9200-rtc-driver.patch
+at91rm9200-rtc-driver-tidy.patch

 More RTC driver work

+fix-broken-dubious-driver-suspend-methods.patch
+checkstack-pirnt-module-names.patch
+get-rid-of-proc-sys-proc.patch
+sound-vxpocket-fix-printk-warning.patch
+9pfs-missing-result-check-in-v9fs_vfs_readlink-and-v9fs_vfs_link.patch
+ext3-cleanup-dead-code-in-ext3_add_entry.patch
+n32-sigset-and-__compat_endian_swap__.patch
+ftruncate-does-not-always-update-m-ctime.patch
+wan-sdla-section-fixes.patch
+trident-fb-section-fixes.patch
+cdrom-mcdx-section-fixes.patch
+char-ip2-more-section-fixes-replacement.patch
+advansys-section-fixes.patch
+r3964-fix-gfp_kernel-allocations-in-timer-function.patch

 Misc patches

+per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-fix-return-value-of-delayacct_add_tsk.patch

 per-task accounting fix

+sched-mc-smt-power-savings-sched-policy-sparc64-build-fix.patch

 CPU scheduler spacr64 build fix (might be wrong)

+swap_prefetch-conversion-of-nr_mapped-to-per-zone-counter.patch
+swap_prefetch-conversion-of-nr_slab-to-per-zone-counter.patch
+swap_prefetch-conversion-of-nr_dirty-to-per-zone-counter.patch
+swap_prefetch-conversion-of-nr_writeback-to-per-zone-counter.patch
+swap_prefetch-conversion-of-nr_unstable-to-per-zone-counter.patch
+swap_prefetch-remove-unused-get_page_stat-functions.patch
+zoned-vm-stats-nr_slab-is-accurate-fix-comment.patch
+swap_prefetch-zoned-vm-stats-add-nr_anon.patch

 Update the swap prefetch patch for the zoned accounting patches

+namespaces-utsname-implement-utsname-namespaces-remove-unused-exit_utsname.patch

 Clean up namespaces-utsname-implement-utsname-namespaces.patch

+ipc-namespace-core.patch
+ipc-namespace-core-fix.patch
+ipc-namespace-utils.patch
+ipc-namespace-msg.patch
+ipc-namespace-sem.patch
+ipc-namespace-shm.patch
+ipc-namespace-sysctls.patch

 Separable namespaces for SYSV IPC

+readahead-state-based-method-routines-no-ra_flag_eof-on-single-page-file.patch
+readahead-initial-method-guiding-sizes-aggressive-initial-sizes.patch
+readahead-call-scheme-no-fastcall-for-readahead_cache_hit.patch
+readahead-backoff-on-i-o-error.patch
+readahead-remove-size-limit-on-read_ahead_kb.patch

 Update the readahead patches in -mm.

+reiser4-conversion-of-nr_dirty-to-per-zone-counter.patch

 Update reiser4 for the zoned accounting patches

+vt-binding-add-binding-unbinding-support-for-the-vt.patch
+vt-binding-add-sysfs-support.patch
+vt-binding-update-fbcon-to-support-binding.patch
+vt-binding-fbcon-update-documentation.patch
+vt-binding-add-new-doc-file-describing-the-feature.patch

 fbcon feature work

+lock-validator-x86_64-irqflags-trace-entrys-fix-fix.patch

 Fix lock-validator-x86_64-irqflags-trace-entrys-fix.patch

+lock-validator-annotate-ieee1394-skb-head-locking.patch

 Prevent lockdep noise in 1394

+lock-validator-fix-sparc32-breakage.patch

 lockdep sparc32 build fix




All 1569 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/patch-list

