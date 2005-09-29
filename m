Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVI2Vh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVI2Vh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVI2Vh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:37:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030251AbVI2Vh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:37:26 -0400
Date: Thu, 29 Sep 2005 14:37:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc2-mm2
Message-Id: <20050929143732.59d22569.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/

(temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)


- A bunch of memory management updates

- The big pcmcia changes have been temporarily dropped

- Multiple obscure tty drivers still won't compile

- Lots of post-2.6.14-rc2-mm1 patches have been cheerfully tossed out
  again due to various bugs, which felt nice.

- I am offline until October 9.  Please send critical 2.6.14 fixes direct to
  Linus.



Changes since 2.6.14-rc2-mm1:


 linus.patch
 git-acpi.patch
 git-cifs.patch
 git-cryptodev.patch
 git-drm.patch
 git-ia64.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ocfs2.patch
 git-serial.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-sas.patch
 git-sparc64.patch
 git-watchdog.patch

 Subsystem trees

-proc_task_root_link-c99-fix.patch
-lpfc-build-fix.patch
-reboot-comment-and-factor-the-main-reboot-functions.patch
-suspend-cleanup-calling-of-power-off-methods.patch
-pci_fixup_parent_subordinate_busnr-fixes.patch
-kdumpx86-add-note-type-nt_kdumpinfo-to-kernel-core-dumps.patch
-acpi-handle-fadt-20-xpmtmr-address-0-case.patch
-update-maintainers-list-with-the-kprobes-maintainers.patch
-v9fs-make-conv-functions-to-check-for-conv-buffer-overflow.patch
-v9fs-allocate-the-rwalk-qid-array-from-the-right-conv-buffer.patch
-v9fs-make-copy-of-the-transport-prototype-instead-of-using-it-directly.patch
-v9fs-replace-strlen-on-newly-allocated-by-__getname-buffers-to-path_max.patch
-v9fs-dont-free-root-dentry-inode-if-error-occurs-in-v9fs_get_sb.patch
-ppc64-smu-driver-update-i2c-support.patch
-atiixp_modem-printk-fixes.patch
-gregkh-driver-driver-fix-bus_rescan_devices.patch
-gregkh-driver-driver-device_is_registered.patch
-gregkh-driver-driver-fix-class-symlinks.patch
-gregkh-i2c-i2c-maintainer.patch
-fix-broken-nvidia-device-id-in-sata_nv.patch
-git-nfs-oops-fix.patch
-gregkh-pci-pci-remove-unused-scratch.patch
-gregkh-pci-pci-kzalloc.patch
-gregkh-pci-pci-fix-probe-warning.patch
-gregkh-pci-pci-buffer-overrun-rpaldpar.patch
-gregkh-usb-ub-burn-cd-fix.patch
-gregkh-usb-usb-option-new-ids.patch
-gregkh-usb-usb-ftdi_sio-baud-rate-change.patch
-gregkh-usb-usb-pxa2xx_udc-build-fix.patch
-gregkh-usb-usb-sl811-minor-fixes.patch
-gregkh-usb-usb-power-state-03-fix.patch
-gregkh-usb-usb-handoff-merge-usb-Makefile-fix.patch
-pegasus-ethernet-over-usb-driver-fixes.patch
-st5481_usb-build-fix.patch
-mm-move_pte-to-remap-zero_page.patch
-mm-move_pte-to-remap-zero_page-fix.patch
-r8169-call-proper-vlan-receive-function.patch
-swsusp-fix-comments.patch
-uml-dont-remove-umid-files-in-conflict-case.patch
-strlcat-use-for-uml-umidc.patch
-uml-dont-redundantly-mark-pte-as-newpage-in-pte_modify.patch
-uml-fix-hang-in-tt-mode-on-fault.patch
-uml-fix-condition-in-tlb-flush.patch
-uml-run-mconsole-sysrq-in-process-context.patch
-uml-avoid-fixing-faults-while-atomic.patch
-uml-fix-gfp_-flags-usage.patch
-uml-use-gfp_atomic-for-allocations-under-spinlocks.patch
-uml-replace-printk-with-stack-friendly-printf-to-report-console-failure.patch
-xtensa-remove-io_remap_page_range-and-minor-clean-ups.patch
-s390-ipl-device.patch
-fix-sys_poll-large-timeout-handling.patch
-oss-dont-concatenate-__function__-with-strings.patch
-ext3-ext_debug-build-fixes.patch
-fix-bd_claim-error-code.patch
-remove-hardcoded-send_sig_xxx-constants.patch
-cleanup-the-usage-of-send_sig_xxx-constants.patch
-keys-add-possessor-permissions-to-keys.patch
-nfs-fix-client-oops-when-debugging-is-on.patch
-add-dm-snapshot-tutorial-in-documentation.patch

 Merged

+fix-pgdat_list-connection-in-init_bootmem.patch
+x86_64-fix-the-bp-node_to_cpumask.patch
+x86_64-numa-node-topology-fix.patch
+x86-x86_64-cpuid-workaround-for-intel-cpu.patch

 x86_64 fixes

+make-if_etherh-compile-with-config_sysctl=n.patch

 !CONFIG_SYSCTL fix

+aio-avoid-extra-aio_readwrite-call-when-ki_left-==-0.patch

 AIO fixes

+intelfb-fix-regression-blank-display-from-ioremap-patch.patch
+s3c2410fb-minor-warning-fix.patch

 fbdev fixes

+ppc64-smu-driver-locking-mistake.patch

 Mac SMU driver fix

+x86-hw_irqh-warning-fix.patch

 Warning fix

+v4l-dvico-fusionhdtv5-lite-gpio-fix.patch

 v4l fix

+uml-fix-build-dependencies-with-kbuild-output.patch
+uml-fix-page-faults-in-skas3-mode.patch
+uml-clear-skas0-3-flags-when-running-in-tt-mode.patch
+uml-revert-run-mconsole-sysrq-in-process-context.patch
+uml-remove-empty-hostfs_truncate-method.patch

 UML updates

+fuse-check-o_direct.patch

 FUSE fix

+cpufreq-smp-fix-for-conservative-governor.patch

 cpufreq docs

+ioc4_serial-remove-bogus-error-message.patch

 ioc driver tweak

+posix-timers-smp-race-condition.patch
+posix-timers-smp-race-condition-tidy.patch

 posix timers race fix

+increase-maximum-kmalloc-size-to-256k.patch
+increase-maximum-kmalloc-size-to-256k-fix.patch

 Increase max kmalloc size (will drop this in favour of
 use-alloc_percpu-to-allocate-workqueues-locally.patch)

+git-acpi-pciehprm_acpi-fix.patch
+git-acpi-build-fix-2.patch
+acpi-handle-fadt-20-xpmtmr-address-0-case.patch

 acpi fixes

-acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549-update.patch

 Folded into acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549.patch

+pnpacpi-handle-address-descriptors-in-_prs.patch
+pnpacpi-handle-address-descriptors-in-_prs-fix-for-git-acpi-change.patch

 pnpacpi updates

+cs5535-audio-alsa-driver-kconfig-fix.patch
+sound-align-device-drivers-menus.patch

 Sound driver updates

+cpufreq_ondemand-documentation.patch

 More cpufreq documentation

+gregkh-driver-driver-send-hotplug-before-adding-class_interface.patch
+gregkh-driver-i2o-remove-class-interface.patch
+gregkh-driver-i2o-class-01.patch
+gregkh-driver-driver-interface-pass.patch

 Driver tree updates

-drm_addmap_ioctl-warning-fix.patch

 Was wrong

+gregkh-i2c-hwmon-01.patch
+gregkh-i2c-hwmon-02.patch
+gregkh-i2c-hwmon-03.patch
+gregkh-i2c-hwmon-04.patch
+gregkh-i2c-hwmon-05.patch
+gregkh-i2c-hwmon-06.patch
+gregkh-i2c-hwmon-07.patch
+gregkh-i2c-hwmon-08.patch
+gregkh-i2c-hwmon-09.patch
+gregkh-i2c-hwmon-10.patch
+gregkh-i2c-hwmon-11.patch
+gregkh-i2c-hwmon-12.patch
+gregkh-i2c-hwmon-13.patch

 i2c tree updates

+remove-redundant-configso.patch
+use-incbin-for-config_datagz.patch
+config_ia32.patch

 Kconfig tweaks

+net-reorder-some-hot-fields-of-struct-net_device.patch

 Optimise net_device layout

-git-ocfs2-prep.patch

 Unneeded

-pci-block-config-access-during-bist-update.patch
-pci-block-config-access-during-bist-update-2.patch
-pci-block-config-access-during-bist-fix-42.patch
-pci-block-config-access-during-bist-fix-43.patch
-pci-block-config-access-during-bist-resend.patch

 Folded ito pci-block-config-access-during-bist.patch

-megaraid-mode_sense-fix.patch

 Dropped - didn't work.

+areca-raid-linux-scsi-driver-update-2.patch

 Another update to this raid driver

+gregkh-usb-ub-fix-compiler-warnings.patch
+gregkh-usb-usb-fix-hub-build.patch

 USB fixes

+sisusb-warning-fix.patch

 USB warning fix

-topdir-mm.patch
+m.patch

 Renamed

-mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch
-mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk-fix.patch

 Dropped - causes page allocator fragmentation

+mm-msyncc-cleanup.patch
+shrink_list-skip-anon-pages-if-not-may_swap.patch
+guarantee-dma-area-for-alloc_bootmem_low.patch
+slab-add-additional-debugging-to-detect-slabs-from-the-wrong-node.patch

 mm updates

+mm-hugetlb-truncation-fixes.patch
+mm-copy_pte_range-progress-fix.patch
+mm-msync_pte_range-progress.patch
+mm-zap_pte_range-dont-dirty-anon.patch
+mm-anon-is-already-wrprotected.patch
+mm-vm_stat_account-unshackled.patch
+mm-remove_vma_list-consolidation.patch
+mm-unlink_file_vma-remove_vma.patch
+mm-exit_mmap-need-not-reset.patch
+mm-page-fault-handlers-tidyup.patch
+mm-page-fault-handlers-tidyup-fix.patch
+mm-move_page_tables-by-extents.patch
+mm-tlb_gather_mmu-get_cpu_var.patch
+mm-tlb_is_full_mm-was-obscure.patch
+mm-tlb_finish_mmu-forget-rss.patch
+mm-mm_init-set_mm_counters.patch
+mm-rss-=-file_rss-anon_rss.patch
+mm-batch-updating-mm_counters.patch
+mm-dup_mmap-use-oldmm-more.patch
+mm-dup_mmap-down-new-mmap_sem.patch
+mm-sh64-hugetlbpagec.patch
+mm-m68k-kill-stram-swap.patch

 mm updates from Hugh

+hugetlbfs-move-free_inodes-accounting.patch
+hugetlbfs-move-free_inodes-accounting-fix.patch
+hugetlbfs-clean-up-hugetlbfs_delete_inode.patch
+kill-hugelbfs_do_delete_inode.patch
+cleanup-hugelbfs_forget_inode.patch

 hugetlbfs cleanups

+new-powerpc-4xx-on-chip-ethernet-controller-driver.patch
+sis900-come-alive-after-temporary-memory-shortage.patch

 netdevice things

+ppc32-update-xmon-help-text.patch
+ppc-make-phys_mem_access_prot-work-with-pfns-instead-of.patch

 ppc32 updates

+x86-bogus-tls-from-gdt.patch
+x86-add-an-accessor-function-for-getting-the-per-cpu-gdt.patch
+x86-gdt-page-isolation.patch
+x86-gdt-page-isolation-fix.patch
+x86-bug-fix-in-p6-machine-check-initialization.patch
+asus-vt8235-router-buggy-bios-workaround.patch
+fixup-bogus-e820-entry-with-mem=.patch
+x86-when-l3-is-present-show-its-size-in-proc-cpuinfo.patch

 x86 fixes

-x86_64-dont-use-shortcut-when-using-send_ipi_all-in-flat-mode.patch

 Dropped.  Was wrong, iirc.

+x86_64-fix-tss-limit.patch

 x86_64 tss fix

+s390-export-ipl-device-parameters.patch
+s390-export-ipl-device-parameters-fix.patch

 s390 fix

-per-task-predictive-write-throttling-1.patch
-per-task-predictive-write-throttling-1-tweaks.patch

 Was causing problems

+remove-some-more-check_region-stuff.patch

 cleanups

+use-alloc_percpu-to-allocate-workqueues-locally.patch
+use-alloc_percpu-to-allocate-workqueues-locally-fix.patch

 Use per-cpu allocation in the workqueue code

+remove-timer-debug-fields.patch

 Remove timer_list.magic

+bioscalls-cleanup.patch

 Clean up this file

+dont-uselessly-export-task_struct-to-user-space-in-core-dumps.patch

 Remove a corefile record

+open-cleanup-in-lookup_flags.patch

 cleanup

+protect-ide_cdrom_capacity-by-ifdef.patch

 Dead code

+lib-stringc-cleanup-whitespace-and-codingstyle-cleanups.patch
+lib-stringc-cleanup-remove-pointless-register-keyword.patch
+lib-stringc-cleanup-remove-pointless-explicit-casts.patch
+whitespace-and-codingstyle-cleanup-for-lib-idrc.patch

 More cleanups

+clarify-menuconfig-search-help-text.patch

 Kconfig fixes

+reduce-sizeofstruct-file.patch
+reduce-sizeofstruct-file-fix.patch

 Shrink struct file

+fix-exit_itimers-vs-posix_timer_event-ab-ba-deadlock.patch
+fix-de_thread-vs-it_real_fn-deadlock.patch

 Fix obscure deadlocks.

+kill-sigqueue-lock.patch

 Optimise away a lock

+unify-sys_tkill-and-sys_tgkill-take-2.patch

 Cleanup

+block-cleanups-add-kconfig-default-iosched-submenu.patch

 Make the default IO scheduler Kconfigurable

+typo-fix-explictly-explicitly.patch

 Spel things correctly

+posix-timers-use-schedule_timeout-in-common_nsleep.patch

 cleanup

+ehci-kexec-reboot-fix.patch

 Maybe fix a kexec hang

+adjust-parisc-sys_ptrace-prototype.patch

 ptrace() fix

+unify-sys_ptrace-prototype.patch

 Conde consolidation

+dell_rbu-changes-in-packet-update-mechanism.patch

 Update dell_rbu driver

+typo-fix-dot-after-newline-in-printk-strings.patch

 Fix printk strings

+msi-interrupts-disallow-when-no-lapic-ioapic-support.patch

 MSI interrupt fix

+block-cleanups-fix-iosched-module-refcount-leak.patch

 io scheduler fix

+hpet-disallow-zero-interrupt-frequency.patch

 hpet bounds checking

+add_timer-of-pending-time-is-illegal.patch

 add_timer() BUGcheck

+hpet-remove-unused-variable.patch
+hpet-remove-superfluous-register-reads.patch
+hpet-allow-non-power-of-two-frequencies.patch
+hpet-allow-shared-interrupts.patch
+hpet-rtc-disable-interrupt-when-no-longer-needed.patch
+hpet-rtc-fix-timer-config-register-accesses.patch
+hpet-rtc-cache-the-comparator-register.patch

 hpet fixes

+remove-hardcoded-send_sig_xxx-constants.patch
+cleanup-the-usage-of-send_sig_xxx-constants.patch
+remove-unneeded-si_timer-checks.patch

 signal code cleanups

+fix-missing-includes.patch
+fix-more-missing-includes.patch
+fix-even-more-missing-includes.patch

 include file fixes

-pcmcia-avoid-macro-usage.patch
-pcmcia-tiny-yenta_socketc-cleanup.patch
-pcmcia-new-suspend-core.patch
-pcmcia-new-suspend-core-dev_to_instance-fix.patch
-pcmcia-convert-drivers-to-use-new-suspend-mechanism.patch
-pcmcia-convert-drivers-to-use-new-suspend-mechanism-spectrum_cs.patch
-pcmcia-convert-serial_cs-to-use-new-suspend-mechanism.patch
-pcmcia-use-runtime-suspend-resume-support-to-unify-all-suspend-code-paths.patch
-pcmcia-use-runtime-suspend-resume-support-to-unify-all-suspend-code-paths-fix.patch
-pcmcia-unified-device-removal-code-path.patch
-pcmcia-convert-drivers-to-use-unified-removal-code-path.patch
-pcmcia-fix-up-cm40x0-drivers.patch
-pcmcia-remove-old-two-step-removal-mechanism.patch
-pcmcia-remove-unused-dev_list-in-drivers.patch
-pcmcia-unified-probe-code-path.patch
-pcmcia-convert-drivers-to-use-new-probe-mechanism.patch
-pcmcia-yenta-add-support-for-more-ti-bridges.patch
-pcmcia-yenta-optimize-interrupt-handler.patch
-pcmcia-yenta-dont-mess-with-bridge-control-register.patch
-yenta-auto-tune-ene-bridges-for-cb-cards.patch

 Dropped - Dominik is setting up a git tree, but it has problems at present.

+maintainers-sbp2-driver-is-not-orphaned.patch
+sbp2-fix-deadlocks-and-delays-on-device-removal-rmmod.patch
+sbp2-default-to-serialize_io=1.patch
+ieee1394-reorder-activities-after-bus-reset-fixes-device-detection.patch
+ieee1394-skip-unnecessary-pause-when-scanning-config-roms.patch
+ieee1394-fix-for-debug-output.patch
+ieee1394-use-time_before.patch
+ieee1394-trivial-edits-of-a-few-comments.patch
+ieee1394-remove-superfluous-include-in-csr1212.patch
+eth1394-workaround-limitation-in-rawiso-routines.patch
+ieee1394-delete-legacy-module-aliases.patch
+ohci1394-less-noise-in-dmesg.patch

 firewire updates

+sched-disable-preempt-in-idle-tasks-2.patch

 CPU scheduler cleanup and maybe-fix

+reiser4-fix-endianess.patch
+reiser4-check-null.patch
+reiser4-fix-built_ptr.patch
+reiser4-key-init-cleanup.patch
+reiser4-fix-list_splice-usage.patch

 Reiser4 fixes

+ide-move-config_ide_max_hwifs-into-linux-ideh.patch
+add-via-vt6410-support.patch
+ide-kconfig-fixes.patch

 IDE tweaks

+framebuffer-add-some-help-text-in-kconfig.patch
+fb-straighten-up-fb-drivers-menu.patch

 fbdev fixes

+documentation-ioctl-messtxt-fill-more-holes-in-b-p-range.patch
+codingstyle-correction.patch

 Documentation

+m32r-buildfix-of-m32r_sioc.patch

 Fix tty-layer-buffering-revamp.patch some more



All 566 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/patch-list


