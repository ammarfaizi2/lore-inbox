Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWIHINY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWIHINY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 04:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWIHINY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 04:13:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750975AbWIHINV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 04:13:21 -0400
Date: Fri, 8 Sep 2006 01:13:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc6-mm1
Message-Id: <20060908011317.6cb0495a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/

- autofs4 mounting of NFS is still sick.



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

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.


 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-agpgart.patch
 git-arm.patch
 git-block.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-kbuild.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ocfs2.patch
 git-parisc.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-r8169.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-watchdog.patch
 git-xfs.patch

 git trees

-zvc-overstep-counters.patch
-zvc-scale-thresholds-depending-on-the-size-of-the-system.patch
-md-fix-issues-with-referencing-rdev-in-md-raid1.patch
-synclink_gt-fix-receive-tty-error-handling.patch
-fix-faulty-hpet-clocksource-usage-fix-for-bug-7062.patch
-task-delay-accounting-fixes.patch
-xtensa-ptrace-exit_zombie-fix.patch
-x86-increase-max_mp_busses-on-default-arch.patch
-exit-early-in-floppy_init-when-no-floppy-exists.patch
-sbc8360-module_param-permission-fixes.patch
-kerneldoc-for-handle_bad_irq.patch
-ipmi-fix-occasional-oops-on-module-unload.patch
-schedule-obsolete-oss-drivers-for-removal-2nd-round.patch
-md-work-around-mempool_alloc-bio_alloc_bioset-deadlocks.patch
-powerpc-more-via-pmu-backlight-fixes.patch
-powerpc-fix-powermac-irq-handling-bug.patch
-alsa-ac97-correct-some-mic-mixer-elements.patch
-sgiioc4-fixup-use-of-mmio-ops.patch
-fix-numa-interleaving-for-huge-pages.patch
-manage-jbd-its-own-slab-fix.patch
-backlight-last-round-of-fixes.patch
-scsi-improve-endian-handling-in-lsi-fusion-firmware-mpt_downloadboot.patch
-agph-constify-struct-agp_bridge_dataversion.patch
-ks0127-wire-up-i2c_add_driver-return-value.patch
-amso1100-build-fix.patch
-forcedeth-decouple-vlan-and-rx-checksum-dependency.patch
-gregkh-usb-samsung-unusual-floppy.patch
-gregkh-usb-hid-core.c-adds-all-gtco-calcomp-digitizers-and-interwrite-school-products-to-blacklist.patch
-gregkh-usb-usb-gadget-g_ether-spinlock-recursion-fix.patch
-gregkh-usb-uhci-don-t-stop-at-an-iso-error.patch
-gregkh-usb-usb-storage-remove-the-finecam3-unusual_devs-entry.patch
-gregkh-usb-usb-storage-unusual_devs.h-for-sony-ericsson-m600i.patch
-gregkh-usb-usb-rtl8150_disconnect-needs-tasklet_kill.patch
-gregkh-usb-usb-support-for-elecom-ld-usb20-in-pegasus.patch
-gregkh-usb-uhci-hcd-fix-list-access-bug.patch
-gregkh-usb-usb-add-all-wacom-device-to-hid-core.c-blacklist.patch
-gregkh-usb-adutux-fix-printk-format-warnings.patch
-kthread-airoc.patch
-x86_64-mm-x86-nmi-fix.patch
-x86_64-mm-x86-nmi-fix-2.patch
-x86_64-mm-rwlock-cleanup.patch
-x86_64-mm-cleanup-spinlock.patch
-x86_64-mm-i386-early-exception.patch
-x86_64-mm-rwlock-cleanup-fix.patch
-x86_64-mm-remove-e820-fallback-fix.patch
-mm-x86_64-mm-generic-getcpu-syscall-tweaks.patch
-hot-add-mem-x86_64-acpi-motherboard-fix.patch
-x86-allow-a-kernel-to-not-be-in-ring-0.patch
-x86-allow-a-kernel-to-not-be-in-ring-0-tidy.patch
-x86-replace-sensitive-instructions-with-macros.patch
-x86-use-asm-offsets-for-offsets-into-struct-pt_regs.patch
-pm-add-sys-power-documentation-to-documentation-abi.patch
-device_suspend-resume-may-sleep.patch
-remove-open_max-check-from-poll-syscall.patch
-ide-hpa-resume-fix.patch

 Merged into mainline or a subsystem tree.

+use-the-correct-restart-option-for-futex_lock_pi.patch
+optical-proc-ide-media.patch
+sh-fix-fpn_start-typo.patch
+sis5513-add-sis-south-bridge-id-0x966.patch
+ext3_getblk-should-handle-hole-correctly.patch
+invalidate_complete_page-race-fix.patch
+nfs-large-non-page-aligned-direct-i-o-clobbers-memory.patch

 2.6.18 queue.

+acpi-check-if-parent-is-on-dock.patch
+acpi-add-removable-drive-bay-support.patch

 ACPI

+gregkh-driver-pm-update-docs-for-writing-...-power-state.patch
+gregkh-driver-pm-add-kconfig-option-for-deprecated-...-power-state-files.patch
+gregkh-driver-pm-schedule-sys-devices-...-power-state-for-removal.patch
+gregkh-driver-pm-no-suspend_prepare-phase.patch
+gregkh-driver-pm-add-sys-power-documentation-to-documentation-abi.patch
+gregkh-driver-pm-device_suspend-resume-may-sleep.patch
+gregkh-driver-pm-platform_bus-and-late_suspend-early_resume.patch
-gregkh-driver-iio.patch
+gregkh-driver-uio.patch

 Driver tree updates

+gregkh-i2c-i2c-dev-attach-detach-adapter-cleanups.patch
+gregkh-i2c-i2c-chips-__must_check-fixes.patch
+gregkh-i2c-i2c-isa-return-attach_adapter.patch
+gregkh-i2c-i2c-algo-bit-cleanups.patch
+gregkh-i2c-i2c-algo-pcf-kill-mdelay.patch
+gregkh-i2c-i2c-drop-useless-masking.patch
+gregkh-i2c-i2c-warn-on-failed-client-attach.patch
+gregkh-i2c-i2c-viapro-add-VT8251-VT8237A.patch
+gregkh-i2c-i2c-isa-restore-driver-owner.patch
+gregkh-i2c-i2c-constify-i2c_algorithm.patch
+gregkh-i2c-i2c-algos-constify-i2c_algorithm.patch
+gregkh-i2c-i2c-busses-constify-i2c_algorithm.patch
+gregkh-i2c-i2c-drop-slave-functions.patch

 I2C tree updates

-ieee1394-sbp2-workaround-for-write-protect-bit-of.patch
+ieee1394-nodemgr-fix-rwsem-recursion.patch
+ieee1394-nodemgr-grab-classsubsysrwsem-in.patch
+ieee1394-sbp2-dont-prefer-mode-sense-10.patch
+ieee1394-ohci1394-fix-endianess-bug-in-debug-message.patch
+ieee1394-ohci1394-more-obvious-endianess-handling.patch

 ieee1394 tree updates

-drivers-input-misc-wistron_btnsc-fix-section-mismatch.patch

 Dropped

+input-i8042-disable-keyboard-port-when-panicking-and-blinking.patch
+i8042-activate-panic-blink-only-in-x.patch

 input updates

+fail-kernel-compilation-in-case-of-unresolved-symbols-v2.patch

 kbuild update

+libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch
+kerneldoc-error-on-ata_piixc.patch
+libata-add-40pin-short-cable-support-honour-drive-fix.patch
+2-of-2-jmicron-driver-plumbing-and-quirk-cleanup.patch

 sata/pata updates

+fix-possible-null-ptr-deref-in-forcedeth.patch

 netdev fix

-gregkh-pci-msi-01-merge_msi_disabling_quirks.patch
-gregkh-pci-msi-02-factorize_pci_msi_supported.patch
-gregkh-pci-msi-03-add_pci_device_exp_type.patch
-gregkh-pci-msi-04-use_root_chipset_dev_no_msi_instead_of_pci_bus_flags.patch
-gregkh-pci-msi-05-add_no_msi_to_sysfs.patch
-gregkh-pci-msi-06-rename_pci_cap_id_ht_irqconf.patch
-gregkh-pci-msi-07-check_hypertransport_msi_capabilities.patch
-gregkh-pci-msi-08-drop_pci_msi_quirk.patch
-gregkh-pci-msi-09-drop_pci_bus_flags.patch
+gregkh-pci-msi-cleanup-existing-msi-quirks.patch
+gregkh-pci-msi-factorize-common-code-in-pci_msi_supported.patch
+gregkh-pci-msi-export-the-pci_bus_flags_no_msi-flag-in-sysfs.patch
+gregkh-pci-msi-blacklist-pci-e-chipsets-depending-on-hypertransport-msi-capability.patch
+gregkh-pci-pci-hotplug-cleanup-pcihp-skeleton-code.patch

 PCI tree updates

+fix-gregkh-pci-msi-blacklist-pci-e-chipsets-depending-on-hypertransport-msi-capability.patch

 Fix it

-pci-quirk_via_irq-behaviour-change.patch
+via-irq-quirk-behaviour-change.patch

 Updated

+git-scsi-misc-nlmsg_multicast-fix.patch

 SCSI fixes

+gregkh-usb-usb-hid-core.c-fix-duplicate-usb_device_id_gtco_404.patch
+gregkh-usb-usb-support-for-usb20svga-wh-usb20svga-dg.patch
+gregkh-usb-usb-new-device-id-for-ftdi_sio-usb-serial-driver.patch
+gregkh-usb-usb-usbtouchscreen-fix-itm-data-reading.patch
+gregkh-usb-usb-phidgets-should-check-create_device_file-return-value.patch
+gregkh-usb-usb-remove-struct-usb_operations.patch
+gregkh-usb-usbcore-add-flag-for-whether-a-host-controller-uses-dma.patch
+gregkh-usb-usbcore-trim-down-usb_bus-structure.patch
+gregkh-usb-usbmon-don-t-call-mon_dmapeek-if-dma-isn-t-being-used.patch
+gregkh-usb-usb-ethernet-gadget-avoids-zlps-for-musb_hdrc.patch
+gregkh-usb-usb-ehci-whitespace-fixes.patch
+gregkh-usb-gadgetfs-patch-for-ep0out.patch
+gregkh-usb-usb-replace-kernel_thread-with-kthread_run-in-libusual.c.patch
+gregkh-usb-usb-usb-serial-gadget-smp-related-bug.patch
+gregkh-usb-usb-net2280-update-dma-buffer-allocation.patch
+gregkh-usb-usb-ohci-at91-two-one-liners.patch
+gregkh-usb-usb-usb-input-usbmouse.c-whitespace-cleanup.patch
+gregkh-usb-usb-introduce-usb_reenumerate_device.patch
+gregkh-usb-usbcore-store-each-usb_device-s-level-in-the-tree.patch
+gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
+gregkh-usb-usbcore-non-hub-specific-uses-of-autosuspend.patch
+gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch
+gregkh-usb-usb-moschip-7840-usb-serial-driver.patch

 USB tree updates

+fix-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch

 Fix it.

+usb-storage-unusual_devsh-entry-for-sony.patch

 USB fix

-git-supertrak.patch
-git-supertrak-fixup.patch
-stex-adjust-command-timeout-in-slave_config-routine.patch
-stex-use-more-efficient-method-for-unload-shutdown-flush.patch

 git-supertrak was moved into the scsi tree

+x86_64-mm-defconfig-update.patch
+x86_64-mm-x86-nmi-watchdog-suspend.patch
+x86_64-mm-rwlock-to-asm.patch
+x86_64-mm-i386-remove-const-rwlock.patch
+x86_64-mm-spinlock-cleanup.patch
+x86_64-mm-i386-spinlock-cleanup.patch
+x86_64-mm-stacktrace-terminate.patch
+x86_64-mm-i386-stacktrace-terminate.patch
+x86_64-mm-i386-backtrace-ebp-fallback.patch
+x86_64-mm-stack-protector-annotate-the-pda-offsets.patch
+x86_64-mm-stack-protector-add-the-kconfig-option.patch
+x86_64-mm-stack-protector-add-canary.patch
+x86_64-mm-stack-protector-add_stack_chk_fail.patch
+x86_64-mm-stack-protector-cflags.patch
+x86_64-mm-fix-irqcount-comment.patch
+x86_64-mm-pda-use-c-output-modifier.patch
+x86_64-mm-type-checking-for-write_pda.patch
+x86_64-mm-fix-pda-warning.patch
+x86_64-mm-i386-replace-sensitive-instructions.patch
+x86_64-mm-i386-allow-a-kernel-to-not-be-in-ring0.patch
+x86_64-mm-i386-pda-asm-offsets.patch
+x86_64-mm-i386-pda-basics.patch
+x86_64-mm-i386-pda-init-pda.patch
+x86_64-mm-i386-pda-use-gs.patch
+x86_64-mm-i386-pda-user-abi.patch
+x86_64-mm-i386-pda-vm86.patch
+x86_64-mm-i386-pda-smp-processorid.patch
+x86_64-mm-i386-pda-current.patch
+x86_64-mm-i386-early-fault.patch
+x86_64-mm-insert-ioapics-and-local-apic-into-resource-map.patch
+x86_64-mm-acpi-add-hpet-into-resource-map.patch
+x86_64-mm-copy-user-nocache.patch
+x86_64-mm-copy-user-zeroing.patch
+x86_64-mm-copy-user-mustcheck.patch
+x86_64-mm-copy-user-style.patch
+x86_64-mm-pda-style.patch
+x86_64-mm-remove-mmx.patch
+x86_64-mm-init-per-cpu-data-again.patch
+x86_64-mm-core-2-oprofile-identification.patch
+x86_64-mm-i386-kexec-not-experimental.patch
+x86_64-mm-kexec-not-experimental.patch

 x86_64 tree updates

+fix-x86_64-mm-i386-backtrace-ebp-fallback.patch
+fix-x86_64-mm-i386-pda-smp-processorid.patch
+fix-x86_64-mm-spinlock-cleanup.patch

 fix bugs in it.

-git-cryptodev.patch
-git-cryptodev-fixup.patch
-git-cryptodev-fixup-2.patch
-git-cryptodev-broke-geode-aes.patch

 git-cryptodev is suffering a reject storm.

+mm-tracking-shared-dirty-pages-nommu-fix-2.patch

 Fix mm-tracking-shared-dirty-pages.patch

+account-for-memmap-and-optionally-the-kernel-image-as-holes-fix.patch
+account-for-holes-that-are-outside-the-range-of-physical-memory.patch
+allow-an-arch-to-expand-node-boundaries.patch

 Fix mm patches in -mm.

+hugepages-use-page_to_nid-rather-than-traversing-zone-pointers.patch
+numa-add-zone_to_nid-function.patch

 More MM updates

+nommu-check-vma-protections.patch
+nommu-make-futexes-work-under-nommu-conditions.patch
+nommu-make-futexes-work-under-nommu-conditions-doc.patch
+nommu-move-the-fallback-arch_vma_name-to-a-sensible-place.patch

 NOMMU updates

-split-i386-and-x86_64-ptraceh.patch
-uml-use-ptrace-abih-instead-of-ptraceh.patch

 These broke.

+pm-make-it-possible-to-disable-console-suspending-fix-2.patch

 Fix pm-make-it-possible-to-disable-console-suspending.patch

+x86-microcode-dont-check-the-size.patch

 Fix x86-microcode-add-sysfs-and-hotplug-support.patch some more.

+fix-conflict-with-the-is_init-identifier-on-parisc.patch

 Preparation for pidspace-is_init.patch

+lockdep-core-add-enable-disable_irq_irqsave-irqrestore-apis-frv-fix.patch

 Fix lockdep-core-add-enable-disable_irq_irqsave-irqrestore-apis.patch

+oom-dont-kill-current-when-another-oom-in-progress.patch

 Fix oom_kill_task-cleanup-mm-checks.patch

+cpuset-top_cpuset-tracks-hotplug-changes-to-node_online_map-fix-2.patch

 Fix cpuset-top_cpuset-tracks-hotplug-changes-to-node_online_map.patch some
 more.

+enforce-rlimit_nofile-in-poll.patch
+generic-infrastructure-for-acls.patch
+generic-infrastructure-for-acls-update.patch
+access-control-lists-for-tmpfs.patch
+access-control-lists-for-tmpfs-cleanup.patch
+ext3-wrong-error-behavior.patch
+stop_machinec-copyright.patch
+build-sound-sound_firmwarec-only-for-oss.patch
+build-sound-sound_firmwarec-only-for-oss-doc.patch
+rtc-more-xstp-vdet-support-for-rtc-rs5c348-driver.patch
+generic_serial-remove-private-decoding-of-baud-rate-bits.patch
+istallion-remove-private-baud-rate-decoding-which-is.patch
+specialix-remove-private-speed-decoding.patch
+fix-locking-for-tty-drivers-when-doing-urgent-characters.patch
+audit-accounting-tty-locking.patch
+documentation-submittingdrivers-minor-update.patch
+clean-up-expand_fdtable-and-expand_files-take-2.patch
+expand_fdtable-remove-pointless-unlocklock.patch
+kcore-elf-note-namesz-field-fix.patch
+lockdep-core-improve-the-lock-chain-hash.patch
+linux-kernel-dump-test-module.patch

 Misc.

-kill-wall_jiffies-fix.patch
-mips-moved-to-generic_time.patch

 Folded into kill-wall_jiffies.patch

+generic-ioremap_page_range-implementation-fix.patch
+generic-ioremap_page_range-implementation-nommu-fix.patch

 Fix generic-ioremap_page_range-implementation.patch

+proc-readdir-race-fix-take-3.patch
+proc-readdir-race-fix-take-3-race-fix.patch
+proc-readdir-race-fix-take-3-fix-1.patch
+proc-readdir-race-fix-take-3-fix-2.patch

 Fix /proc reading races.

+kprobes-handle-symbol-resolution-when-modulesymbol-is-specified.patch
+kprobes-handle-symbol-resolution-when-modulesymbol-is-specified-tidy.patch

 kprobes updates

+knfsd-lockd-introduce-nsm_handle-fix.patch

 Fix knfsd-lockd-introduce-nsm_handle.patch

+knfsd-lockd-introduce-nsm_handle-sem2mutex.patch
+knfsd-svcrpc-gss-factor-out-some-common-wrapping-code.patch
+knfsd-svcrpc-gss-fix-failure-on-svc_denied-in-integrity-case.patch
+knfsd-svcrpc-use-consistent-variable-name-for-the-reply-state.patch
+knfsd-nfsd4-refactor-exp_pseudoroot.patch
+knfsd-nfsd4-clean-up-exp_pseudoroot.patch
+knfsd-nfsd4-acls-relax-the-nfsv4-posix-mapping.patch
+knfsd-nfsd4-acls-fix-inheritance.patch
+knfsd-nfsd4-acls-simplify-nfs4_acl_nfsv4_to_posix-interface.patch
+knfsd-nfsd4-acls-fix-handling-of-zero-length-acls.patch

 nfsd updates

+sched-fixing-wrong-comment-for-find_idlest_cpu.patch

 sched comment fix

+numa-add-zone_to_nid-function-swap_prefetch.patch

 Fix swap-prefetch for other patches in -mm.

+ecryptfs-inode-numbering-fixes.patch

 ecryptfs update

+namespaces-incorporate-fs-namespace-into-nsproxy-whitespace.patch

 Clean up namespaces-incorporate-fs-namespace-into-nsproxy.patch

+rename-the-provided-execve-functions-to-kernel_execve-fixes.patch

 Fix rename-the-provided-execve-functions-to-kernel_execve.patch

+provide-kernel_execve-on-all-architectures-fix-2.patch
+provide-kernel_execve-on-all-architectures-fix-3.patch
+provide-kernel_execve-on-all-architectures-m68knommu-fix.patch
+avr32-implement-kernel_execve.patch

 Fix provide-kernel_execve-on-all-architectures.patch some more.


+proc-make-the-generation-of-the-self-symlink-table-driven.patch
+proc-factor-out-an-instantiate-method-from-every-lookup-method.patch
+proc-remove-the-hard-coded-inode-numbers.patch
+proc-merge-proc_tid_attr-and-proc_tgid_attr.patch
+proc-use-pid_task-instead-of-open-coding-it.patch

 /proc cleanups

+reiser4-possible-cleanups-2.patch

 reiser4 fix

+ide-fix-crash-on-repeated-reset.patch

 IDE fix

+pci_module_init-convertion-in-ata_genericc.patch
+pci_module_init-convertion-in-ata_genericc-fix.patch
+pci_module_init-convertion-in-amso1100-driver.patch
+pci_module_init-convertion-for-k8_edacc.patch
+pci_module_init-convertion-in-the-legacy-megaraid-driver.patch
+nozomi-pci_module_init-conversion.patch
+pci_module_init-convertion-in-olympicc.patch
+pci_module_init-conversion-for-pata_pdc2027x.patch
+pci_module_init-convertion-in-tmscsimc.patch
+mark-pci_module_init-deprecated.patch

 PCI cleanups




All 1835 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/patch-list


