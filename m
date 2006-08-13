Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWHMIZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWHMIZF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 04:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWHMIZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 04:25:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWHMIZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 04:25:03 -0400
Date: Sun, 13 Aug 2006 01:24:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4-mm1
Message-Id: <20060813012454.f1d52189.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/

- Warning: all the Serial ATA Kconfig options have been renamed.  If you
  blindly run `make oldconfig' you won't have any disks.



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




Changes since 2.6.18-rc3-mm2:

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
 git-jfs.patch
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
 git-sas.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 git trees

-make-suspend-possible-with-a-traced-process-at-a-breakpoint.patch
-drivers-edac-edac_mch-must-include-linux-platform_deviceh.patch
-disable-debugging-version-of-write_lock.patch
-bug-in-futex-unqueue_me.patch
-ufs-ufs_get_locked_patch-race-fix.patch
-ufs-handle-truncated-pages.patch
-crash-in-aty128_set_lcd_enable-on-powerbook.patch
-i_mutex-does-not-need-to-be-locked-in-reiserfs_delete_inode.patch
-omap-rng-build-fix.patch
-md-fix-a-bug-that-recently-crept-into-md-linear.patch
-ptrace-make-pid-of-child-process-available-for.patch
-fix-vmstat-per-cpu-usage.patch
-vt-printk-fix-framebuffer-console-triggering-might_sleep.patch
-au1100fb-info-varrotate-fix.patch
-au1100fb-fix-startup-sequence.patch
-fadvise-make-posix_fadv_noreuse-a-no-op.patch
-debug_locksh-add-struct-task_struct.patch
-knfsd-fix-race-related-problem-when-adding-items-to-and-svcrpc-auth-cache.patch
-doc-update-panic_on_oops-documentation.patch
-x86_64-fix-more-per-cpu-typos.patch
-pseries-hvsi-char-driver-null-pointer-deref.patch
-pseries-hvsi-char-driver-janitorial-cleanup.patch
-eicon-fix-define-conflict-with-ptrace.patch
-sh-fix-proc-file-removal-for-superh-store-queue-module.patch
-ieee1394-sbp2-enable-auto-spin-up-for.patch
-fix-befs-slab-corruption.patch
-memory-hotadd-fixes-not-aligned-memory-hotadd.patch
-memory-hotadd-fixes-change-find_next_system_rams.patch
-memory-hotadd-fixes-find_next_system_ram-catch-range.patch
-memory-hotadd-fixes-avoid-check-in-acpi.patch
-memory-hotadd-fixes-avoid-registering-res-twice.patch
-memory-hotadd-fixes-enhance-collistion-check.patch
-fix-reiserfs-lock-inversion-of-bkl-vs-inode-semaphore.patch
-reiserfs_write_full_page-should-not-get_block-past-eof.patch
-pnpacpi-reject-acpi_producer-resources.patch
-futex-apply-recent-futex-fixes-to-futex_compat.patch
-udf-initialize-parts-of-inode-earlier-in-create.patch
-scx200_acbeliminate-spurious-timeout-errors.patch
-ia64-kprobe-invalidate-icache-of-jump-buffer-s390-fix.patch
-git-block-dasd-fix.patch
-git-block-dasd-fix-2.patch
-sysfs_remove_bin_file-no-return-value-dump_stack-on.patch
-kobject-must_check-fixes.patch
-drivers-base-check-errors-fix-2.patch
-remove-null-chars-from-dvb-names.patch
-logips2pp-fix-mx300-button-layout.patch
-remove-polling-timer-from-i8042-v2.patch
-remove-rpm_build_root-from-asm-offsetsh.patch
-rework-legacy-handling-to-remove-much-of-the-cruft.patch
-rework-legacy-handling-to-remove-much-of-the-cruft-fix.patch
-rework-legacy-handling-to-remove-much-of-the-cruft-powerpc-fix.patch
-rework-legacy-handling-to-remove-much-of-the-cruft-fix-2.patch
-add-full-compact-flash-support-to-libata.patch
-forcedeth-move-mac-address-setup-teardown.patch
-forcedeth-mac-address-corrected.patch
-forcdeth-revised-napi-support.patch
-git-net-fib_rules-linkage-fix.patch
-fix-memory-leak-in-net-ipv4-tcp_probectcpprobe_read.patch
-pktgen-oops-when-used-with-balance-tlb-bonding.patch
-gregkh-pci-msi-03-use_root_chipset_dev_no_msi_instead_of_pci_bus_flags.patch
-gregkh-pci-msi-04-rename_pci_cap_id_ht_irqconf.patch
-gregkh-pci-msi-05-check_hypertransport_msi_capabilities.patch
-gregkh-pci-msi-06-drop_pci_msi_quirk.patch
-gregkh-pci-msi-07-drop_pci_bus_flags.patch
-fix-gregkh-pci-pci-express-aer-implemetation-pcie_portdrv-error-handler.patch
-pcie-check-and-return-bus_register-errors.patch
-areca-sysfs-fix.patch
-add-all-wacom-device-to-hid-corec-blacklist.patch
-net1080-inherent-pad-length.patch
-properly-unregister-reboot-notifier-in-case-of-failure-in-ehci-hcd.patch
-quickcam_messenger-compilation-fix.patch
-x86_64-mm-early-param-fix.patch
-fix-x86_64-mm-via-force-dma-mask-config_pcin-fix.patch
-fix-x86_64-mm-allow-users-to-force-a-panic-on-nmi.patch
-x86_64-fix-bus-numbering-format-in-mmconfig-warning.patch
-support-physical-cpu-hotplug-for-x86_64.patch
-sleazy-fpu-feature-x86_64-support.patch
-add-force-of-use-mmconfig.patch
-add-force-of-use-mmconfig-fix.patch
-add-force-of-use-mmconfig-fix-2.patch
-add-efi-e820-memory-mapping-on-x86.patch
-add-efi-e820-memory-mapping-on-x86-tidy.patch
-add-efi-e820-memory-mapping-on-x86-fix.patch
-add-efi-e820-memory-mapping-on-x86-fix-2.patch
-kernel-doc-fixes-for-debugfs.patch
-usb-build-fixes-ohci-omap.patch
-add-imacfb-documentation-and-detection.patch

 Merged into mainline or a subsystem tree

+add-force-of-use-mmconfig.patch
+add-efi-e820-memory-mapping-on-x86.patch
+add-imacfb-documentation-and-detection.patch
+adfs-error-message-fix.patch
+initialize-parts-of-udf-inode-earlier-in-create.patch
+fix-hrtimer-percpu-usage-typo.patch
+fix-x86_64-mm-allow-users-to-force-a-panic-on-nmi.patch
+dm-bug-oops-fix.patch
+change-panic_on_oops-message-to-fatal-exception.patch
+fcntlf_setsig-fix.patch
+sys_getppid-oopses-on-debug-kernel-v2.patch
+sys_getppid-oopses-on-debug-kernel-v2-simplify.patch
+futex_handle_fault-always-fails.patch
+fbdev-include-backlighth-only-when-__kernel__-is-defined.patch
+workqueue-remove-lock_cpu_hotplug.patch
+fuse-fix-error-case-in-fuse_readpages.patch
+fuse-fix-error-case-in-fuse_readpages-kernel-doc-fix.patch
+dm-fix-deadlock-under-high-i-o-load-in-raid1-setup.patch

 2.6.18 queue.

+trigger-a-syntax-error-if-percpu-macros-are-incorrectly-used.patch

 Build-time check.

+acpi-change-gfp_atomic-to-gfp_kernel-for-non-atomic.patch
+acpi-clear-gpe-before-disabling-it.patch
+acpi-correctly-recover-from-a-failed-s3-attempt.patch
+acpi-memory-hotplug-remove-useless-message-at-boot-time.patch

 ACPi updates

+sound-pci-fm801-use-array_size-macro.patch

 ALSA driver cleanup

+kthread-switch-arch-arm-kernel-apmc.patch

 ARM kthread conversion

+gregkh-driver-class_device_create-make-fmt-argument-const-char.patch
+gregkh-driver-device_create-make-fmt-argument-const-char.patch
+gregkh-driver-sysfs-make-poll-behaviour-consistent.patch
+gregkh-driver-debugfs-kernel-doc-fixes-for-debugfs.patch
+gregkh-driver-make-suspend-quieter.patch
+gregkh-driver-device-virtual.patch
+gregkh-driver-kobject-must_check-fixes.patch
+gregkh-driver-sysfs_remove_bin_file-no-return-value-dump_stack-on-error.patch
+gregkh-driver-driver-core-fix-comments-in-drivers-base-power-resume.c.patch
+gregkh-driver-driver-core-fixed-add_bind_files-definition.patch
+gregkh-driver-sound-device.patch

 driver tree updates

+drm-build-fix.patch
+drm-build-fixes-2.patch
+git-drm-build-fix.patch

 Fix git-drm.patch

+config_pm=n-slim-drivers-media-video.patch

 Fix git-dvb.patch

+video1394-add-poll-file-operation-support.patch
+ieee1394-safer-definition-of-empty-macros.patch
+ieee1394-sbp2-workaround-for-write-protect-bit-of.patch
+ieee1394-sbp2-enable-auto-spin-up-for-all-sbp-2-devices.patch
+config_pm=n-slim-drivers-ieee1394-ohci1394c.patch

 1394 updates

+stowaway-keyboard-support.patch
+stowaway-keyboard-support-update.patch
+i8042-get-rid-of-polling-timer-v4.patch

 Input updates

+asus-mv-device-ids.patch

 SATA device IDs

+1-of-2-jmicron-driver-hard_port_no-fix.patch

 Fix 1-of-2-jmicron-driver.patch for libata changes

+piix_host_stop-leak-fix.patch

 Fix git-libata-all leak

-sata-is-bust-on-s390.patch

 Dropped

+config_pm=n-slim-drivers-scsi-sata_sil.patch

 SATA cleanup

+kthread-update-arch-mips-kernel-apmc.patch

 MIPS kthread conversion

+mtd-printk-format-warning.patch
+mtd-nand-fix-ams-delta-after-core-conversion.patch

 MTD fixes

+add-ethtool-g-support-to-spidernet-network-driver.patch
+ehea-interface-to-network-stack.patch
+ehea-phyp-interface.patch
+ehea-queue-management.patch
+ehea-header-files.patch
+ehea-makefile.patch
+ehea-kernel-build-kconfig--makefile.patch
+skge-remember-to-run-netif_poll_disable.patch
+pal-support-of-the-fixed-phy.patch
+pal-support-of-the-fixed-phy-fix.patch
+pal-support-of-the-fixed-phy-export.patch
+fs_enet-use-pal-for-mii-management.patch
+ppc32-board-specific-part-of-fs_enet-update.patch

 netdev updates

+netfilter-make-unused-signal-code-go-away-so-nobody-copies-its-broken-ness.patch
+net-add-the-udpsndbuferrors-and-udprcvbuferrors-mibs.patch
+fix-potential-stack-overflow-in-net-core-utilsc.patch
+constify-tigon3-ether-firmware-structs.patch

 net updates

+config_pm=n-slim-drivers-pcmcia.patch

 pcmcia tweak

+libsas-externs-not-needed.patch

 Cleanup for git-sas.patch

+config_pm=n-slim-drivers-serial-8250_pcic.patch
+omap1510-serial-fix-for-115200-baud.patch

 Serial updates

+gregkh-pci-pciehp-make-pciehp-build-for-powerpc.patch
+gregkh-pci-pci-remove-dead-hotplug_pci_shpc_phprm_legacy-option.patch
+gregkh-pci-msi-03-add_pci_device_exp_type.patch
+gregkh-pci-msi-04-use_root_chipset_dev_no_msi_instead_of_pci_bus_flags.patch
+gregkh-pci-msi-05-add_no_msi_to_sysfs.patch
+gregkh-pci-msi-06-rename_pci_cap_id_ht_irqconf.patch
+gregkh-pci-msi-07-check_hypertransport_msi_capabilities.patch
+gregkh-pci-msi-08-drop_pci_msi_quirk.patch
+gregkh-pci-msi-09-drop_pci_bus_flags.patch
+gregkh-pci-pcie-check-and-return-bus_register-errors.patch

 PCI tree updates

+revert-gregkh-pci-pci-use-pci_bios-as-last-fallback.patch
+fix-gregkh-pci-pci-express-aer-implemetation-aer-core-and-aerdriver-on-powerpc.patch

 Fix it.

+megaraid-use-the-proper-type-to-hold-the-irq-number.patch
+scsi-limit-recursion-when-flushing-shost-starved_list.patch
+scsi-target-printk-format-warnings.patch
+git-scsi-target-ibmvscsi-build-fix.patch

 scsi updates

+gregkh-usb-usb-unusual_devs-entry-for-a-vox-wsx-300er-mp3-player.patch
+gregkh-usb-usb-removed-a-unbalanced-endif-from-ohci-au1xxx.c.patch
+gregkh-usb-usb-appletouch-fix-atp_disconnect.patch
+gregkh-usb-usb-additional-pid-for-sharp-w-zero3.patch
+gregkh-usb-usb-ftdi_sio-driver-new-pids.patch
+gregkh-usb-usb-usbtest.c-unsigned-retval-makes-ctrl_out-return-0-in-case-of-error.patch
+gregkh-usb-usbnet-printk-format-warning.patch
+gregkh-usb-usb-ipaq-minor-ipaq_open-cleanup.patch
+gregkh-usb-usb-usbcore-get-rid-of-the-timer-in-usb_start_wait_urb.patch
+gregkh-usb-usb-wacom-tablet-driver-reorganization.patch
+gregkh-usb-usb-add-all-wacom-device-to-hid-core.c-blacklist.patch
+gregkh-usb-usb-garmin_gps-support-for-new-generation-of-gps-receivers.patch
+gregkh-usb-usb-build-fixes-ohci-omap.patch
+gregkh-usb-usb-onetouch-handle-errors-from-input_register_device.patch
+gregkh-usb-usb-correct-locking-in-gadgetfs_disconnect.patch
+gregkh-usb-usb-fix-ep_config-to-return-correct-value.patch
+gregkh-usb-usb-gadgetfs-protect-ep_release-with-lock.patch
+gregkh-usb-usb-gmidi-new-usb-midi-gadget-class-driver.patch
+gregkh-usb-usb-make-file-operations-structs-in-drivers-usb-const.patch
+gregkh-usb-usb-making-the-kernel-wshadow-clean-usb-completion.patch
+gregkh-usb-usb-new-functions-to-check-endpoints-info.patch
+gregkh-usb-usb-usblp-use-usb_endpoint_-functions.patch
+gregkh-usb-usb-hub-use-usb_endpoint_-functions.patch
+gregkh-usb-usb-appletouch-use-usb_endpoint_-functions.patch
+gregkh-usb-usb-acecad-use-usb_endpoint_-functions.patch
+gregkh-usb-usb-ati_remote-use-usb_endpoint_-functions.patch
+gregkh-usb-usb-keyspan_remote-use-usb_endpoint_-functions.patch
+gregkh-usb-usb-powermate-use-usb_endpoint_-functions.patch
+gregkh-usb-usb-usb-serial-use-usb_endpoint_-functions.patch
+gregkh-usb-usb-usblcd-use-usb_endpoint_-functions.patch
+gregkh-usb-usb-ldusb-use-usb_endpoint_-functions.patch
+gregkh-usb-usb-net1080-inherent-pad-length.patch
+gregkh-usb-usb-add-poll-to-gadgetfs-s-endpoint-zero.patch
+gregkh-usb-usb-gadget-gadgetfs-dont-try-to-lock-before-free.patch
+gregkh-usb-usb-properly-unregister-reboot-notifier-in-case-of-failure-in-ehci-hcd.patch
+gregkh-usb-add-aircable-usb-bluetooth-dongle-driver.patch
+gregkh-usb-usb-adutux-driver.patch
+gregkh-usb-usb-multithread.patch
+gregkh-usb-usb-serial-serqt_usb.patch

 USB tree updates

+stex-adjust-command-timeout-in-slave_config-routine.patch
+stex-use-more-efficient-method-for-unload-shutdown-flush.patch

 Update git-supertrak.patch

+x86_64-mm-remove-early-lockdep.patch
+x86_64-mm-stacktrace-cleanup.patch
+x86_64-mm-module-locks-raw-spinlock.patch
+x86_64-mm-early-safe-smp-processor-id.patch
+x86_64-mm-early-unwind-init.patch
+x86_64-mm-stacktrace-unwinder.patch
+x86_64-mm-i386-stacktrace-unwinder.patch
+x86_64-mm-lockdep-dont-force-framepointer.patch
+x86_64-mm-improve-crash-dump-description.patch
+x86_64-mm-boot-param-bss.patch
+x86_64-mm-i386-fix-mpparse-warning.patch
+x86_64-mm-fault-notifier-export.patch
+x86_64-mm-i386-fault-notifier-export.patch
+x86_64-mm-i386-acpi_force-static.patch
+x86_64-mm-i386-enable_local_apic-static.patch
+x86_64-mm-i386-kernel-thread.patch
+x86_64-mm-i386-desc-cleanup.patch
+x86_64-mm-per-cpu-area-size.patch
+x86_64-mm-i386-topology-cleanup.patch
+x86_64-mm-i386-more-init.patch
+x86_64-mm-fix-bus-numbering-format-in-mmconfig-warning.patch
+x86_64-mm-support-physical-cpu-hotplug-for-x86_64.patch
+x86_64-mm-less-lazy-fpu.patch
+x86_64-mm-wire-up-oops_enter-oops_exit.patch
+x86_64-mm-add-mem-fix.patch
+x86_64-mm-kprobe_entry-ends-up-putting-code-into-.fixup.patch
+x86_64-mm-remove-redundant-generic_identify-calls-when-identifying-cpus.patch
+x86_64-mm-mark-init_amd-as-__cpuinit.patch
+x86_64-mm-mark-cpu_dev-structures-as-__cpuinitdata.patch
+x86_64-mm-mark-cpu-init-functions-as-__cpuinit,-data-as-__cpuinitdata.patch
+x86_64-mm-mark-cpu-identify-functions-as-__cpuinit.patch
+x86_64-mm-mark-cpu-cache-functions-as-__cpuinit.patch
+x86_64-mm-i386-kprobes-mca.patch
+x86_64-mm-i386-kprobes-nmi.patch
+x86_64-mm-remove-config.h-includes-from-asm-i386-asm-x86_64.patch

 x86_64 tree updates

+revert-x86_64-mm-i386-semaphore-to-asm.patch
+revert-x86_64-mm-detect-cfi.patch
+x86_64-mm-module-locks-raw-spinlock-hack-hack-hack.patch
+fix-x86_64-mm-stacktrace-cleanup-for-s390.patch

 Fix it.

+x86_64-make-numa_emulation-__init.patch

 section tweaks

-hot-add-mem-x86_64-x86_64-kernel-mapping-fix.patch
+hot-add-mem-x86_64-memory_add_physaddr_to_nid-node-fixup-fix-2.patch
-hot-add-mem-x86_64-valid-add-range-check.patch
+hot-add-mem-x86_64-use-config_memory_hotplug_reserve-fix.patch

 Update memory hotadd patches

+git-cryptodev-s390-fixes.patch

 Fix git-cryptodev.patch

+page-migration-replace-radix_tree_lookup_slot-with-radix_tree_lockup.patch

 mm hack for an unknown bug.

+apply-type-enum-zone_type-fix.patch

 Fix apply-type-enum-zone_type.patch

+mm-remove_mapping-safeness-fix.patch

 Fix mm-remove_mapping-safeness.patch

+slab-extract-__kmem_cache_destroy-from-kmem_cache_destroy.patch
+slab-do-not-panic-when-alloc_kmemlist-fails-and-slab-is-up.patch
+slab-fix-lockdep-warnings.patch
+slab-fix-lockdep-warnings-fix.patch
+slab-fix-lockdep-warnings-fix-2.patch
+add-__gfp_thisnode-to-avoid-fallback-to-other-nodes-and-ignore.patch
+add-__gfp_thisnode-to-avoid-fallback-to-other-nodes-and-ignore-fix.patch
+sys_move_pages-do-not-fall-back-to-other-nodes.patch
+guarantee-that-the-uncached-allocator-gets-pages-on-the-correct.patch
+cleanup-add-zone-pointer-to-get_page_from_freelist.patch
+profiling-require-buffer-allocation-on-the-correct-node.patch
+define-easier-to-handle-gfp_thisnode.patch
+fix-potential-stack-overflow-in-mm-slabc.patch
+standardize-pxx_page-macros.patch

 Memory management updates

+tiacx-sparse-cleanups.patch

 wireless driver cleanups

+selinux-enable-configuration-of-max-policy-version.patch
+selinux-add-support-for-range-transitions-on-object.patch

 SELinux updates

+avr32-switch-to-generic-timekeeping-framework.patch

 avr32 update

+sh-fix-fpn_start-typo.patch

 SUperH fix

+split-i386-and-x86_64-ptraceh.patch
+uml-use-ptrace-abih-instead-of-ptraceh.patch
+x86-allow-a-kernel-to-not-be-in-ring-0-tidy.patch
+voyager-tty-locking.patch
+i386-kill-references-to-xtime.patch

 x86 updates

+clean-up-suspend-header.patch
+change-the-name-of-pagedir_nosave.patch
+swsusp-introduce-some-helpful-constants.patch
+swsusp-introduce-memory-bitmaps.patch
+swsusp-use-memory-bitmaps-during-resume.patch

 swsusp updates

+uml-move-signal-handlers-to-arch-code-fix.patch

 Fix uml-move-signal-handlers-to-arch-code.patch

+uml-clean-our-set_ether_mac.patch
+uml-stack-usage-reduction.patch
+uml-use-mcmodel=kernel-for-x86_64.patch
+uml-fix-proc-vs-interrupt-context-spinlock-deadlock.patch

 UML updates

+fix-kerneldoc-comments-in-kernel-timerc-fix.patch

 Fix fix-kerneldoc-comments-in-kernel-timerc.patch

+apple-motion-sensor-driver-kconfig-fix.patch

 Fix apple-motion-sensor-driver-2.patch some more

-fix-bounds-check-bug-in-__register_chrdev_region.patch

 Dropped

+unwind-fix-unused-variable-warning-when.patch
+reiserfs-ifdef-xattr_sem.patch
+reiserfs-ifdef-acl-stuff-from-inode.patch
+fsh-ifdef-security-fields.patch
+oprofile-ppro-need-to-enable-disable-all-the-counters.patch
+add-o-flush-for-fat.patch
+tty-locking-on-resize.patch
+kthread-convert-arch-i386-kernel-apmc.patch
+fix-unserialized-task-files-changing.patch
+fix-unserialized-task-files-changing-fix.patch
+pidspace-is_init.patch
+simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
+chardev-checking-of-overlapping-ranges.patch
+ahci-ati-sb600-sata-support-for-various-modes.patch
+atiixp-ati-sb600-ide-support-for-various-modes.patch
+lockdep-print-kernel-version.patch
+memory-ordering-in-__kfifo-primitives.patch
+small-update-to-credits.patch
+fix-wrong-error-code-on-interrupted-close-syscalls.patch
+remove-another-configh.patch
+fix-up-lockdep-trace-in-fs-execc.patch
+make-ledsh-include-relevant-headers.patch
+config_pm=n-slim-drivers-parport-parport_serialc.patch
+config_pm=n-slim-sound-oss-tridentc.patch
+config_pm=n-slim-sound-oss-cs46xxc.patch
+ext3-and-jbd-cleanup-remove-whitespace.patch
+posix-timers-fix-clock_nanosleep-doesnt-return-the-remaining-time-in-compatibility-mode.patch
+posix-timers-fix-the-flags-handling-in-posix_cpu_nsleep.patch

 Misc patches

+ntp-move-all-the-ntp-related-code-to-ntpc.patch
+ntp-move-all-the-ntp-related-code-to-ntpc-fix.patch
+ntp-add-ntp_update_frequency.patch
+ntp-add-time_adj-to-tick-length.patch
+ntp-add-time_freq-to-tick-length.patch
+ntp-prescale-time_offset.patch
+ntp-add-time_adjust-to-tick-length.patch
+ntp-remove-time_tolerance.patch
+ntp-convert-time_freq-to-nsec-value.patch
+ntp-convert-to-the-ntp4-reference-model.patch
+ntp-cleanup-defines-and-comments.patch

 NTP updates

+csa-basic-accounting-over-taskstats-fix.patch

 Fix csa-basic-accounting-over-taskstats.patch

+csa-accounting-taskstats-update.patch

 Update CSA patches

+reiserfs-make-sure-all-dentries-refs-are-released-before-calling-kill_block_super-try-2.patch

 Fix reiserfs for the fs-cache patches

+fs-cache-make-kafs-use-fs-cache-fix.patch

 Fix fs-cache-make-kafs-use-fs-cache.patch

+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-cachefiles-printk-format-warning.patch

 Fix fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem.patch

+r-o-bind-mount-prepare-for-write-access-checks-collapse-if.patch
+r-o-bind-mount-prepwork-move-open_nameis-vfs_create.patch
+r-o-bind-mount-unlink-monitor-i_nlink.patch
+r-o-bind-mount-prepwork-inc_nlink-helper.patch
+r-o-bind-mount-clean-up-ocfs2-nlink-handling.patch
+r-o-bind-mount-monitor-zeroing-of-i_nlink.patch

 read-only bind mounts

+thinkpad_ec-new-driver-for-thinkpad-embedded-controller-access.patch
+hdaps-use-thinkpad_ec-instead-of-direct-port-access.patch
+hdaps-unify-and-cache-hdaps-readouts.patch
+hdaps-correct-readout-and-remove-nonsensical-attributes.patch
+hdaps-remember-keyboard-and-mouse-activity.patch
+hdaps-limit-hardware-query-rate.patch
+hdaps-delay-calibration-to-first-hardware-query.patch
+hdaps-add-explicit-hardware-configuration-functions.patch
+hdaps-add-new-sysfs-attributes.patch
+hdaps-power-off-accelerometer-on-suspend-and-unload.patch
+hdaps-stop-polling-timer-when-suspended.patch
+hdaps-simplify-whitelist.patch

 HDAPS driver updates

+generic-ioremap_page_range-implementation.patch
+generic-ioremap_page_range-flush_cache_vmap.patch
+generic-ioremap_page_range-alpha-conversion.patch
+generic-ioremap_page_range-arm-conversion.patch
+generic-ioremap_page_range-avr32-conversion.patch
+generic-ioremap_page_range-cris-conversion.patch
+generic-ioremap_page_range-i386-conversion.patch
+generic-ioremap_page_range-m32r-conversion.patch
+generic-ioremap_page_range-mips-conversion.patch
+generic-ioremap_page_range-parisc-conversion.patch
+generic-ioremap_page_range-s390-conversion.patch
+generic-ioremap_page_range-sh-conversion.patch
+generic-ioremap_page_range-sh64-conversion.patch
+generic-ioremap_page_range-x86_64-conversion.patch

 Code consolidation

+paravirt-remove-read-hazard-from-cow.patch
+paravirt-pte-clear-not-present.patch
+paravirt-lazy-mmu-mode-hooks.patch
+paravirt-combine-flush-accessed-dirty.patch
+paravirt-kpte-flush.patch
+paravirt-optimize-ptep-establish-for-pae.patch
+paravirt-remove-set-pte-atomic.patch
+paravirt-pae-compile-fix.patch
+paravirt-update-pte-hook.patch

 Virtualisation preparatory stuff

+isdn-work-around-excessive-udelay.patch

 ISDN is doing gross things.

+knfsd-make-rpc-threads-pools-numa-aware-fix.patch

 Fix knfsd-make-rpc-threads-pools-numa-aware.patch

-revert-knfsd-make-rpc-threads-pools-numa-aware.patch

 Unneeded

+lower-migration-thread-stop-machine-prio.patch

 sched tweak

+ecryptfs-fs-makefile-and-fs-kconfig-kconfig-help-update.patch
+ecryptfs-graceful-handling-of-mount-error.patch
+ecryptfs-associate-vfsmount-with-dentry-rather-than-superblock.patch

 ecryptfs updates

+namespaces-utsname-use-init_utsname-when-appropriate-gmidi.patch
+namespaces-utsname-use-init_utsname-when-appropriate-print_kernel_version.patch

 People keep on using system_utsname.

+readahead-call-scheme-fix.patch

 Fix readahead-call-scheme.patch

+reiser4-rename-generic_sounding_globalspatch.patch
+reiser4-rename-generic_sounding_globalspatch-fix.patch

 reiser4 update

+add-full-compact-flash-support-to-libata.patch
+config_pm=n-slim-drivers-ide-pci-sc1200c.patch

 IDE things

 fbcon-use-persistent-allocation-for-cursor-blinking.patch
+fbcon-remove-cursor-timer-if-unused.patch
+vt-honor-the-return-value-of-device_create_file.patch
+fbdev-honor-the-return-value-of-device_create_file.patch
+fbcon-honor-the-return-value-of-device_create_file.patch
+atyfb-honor-the-return-value-of-pci_register_driver.patch
+matroxfb-honor-the-return-value-of-pci_register_driver.patch
+nvidiafb-honor-the-return-value-of-pci_enable_device.patch
+i810fb-honor-the-return-value-of-pci_enable_device.patch
+drivers-video-sis-init301h-removal-of-old.patch
+drivers-video-sis-initextlfbc-removal-of.patch
+drivers-video-sis-inith-removal-of-old-code.patch
+drivers-video-sis-osdefh-removal-of-old-code.patch
+drivers-video-sis-sis_accelc-removal-of-old.patch
+drivers-video-sis-sis_accelh-removal-of-old.patch
+drivers-video-sis-sis_mainc-removal-of-old.patch
+drivers-video-sis-sis_mainh-removal-of-old.patch
+drivers-video-sis-vgatypesh-removal-of-old.patch

 fbdev updates

+fs-jffs2-jffs2_fs_ih-removal-of-old-code.patch

 jffs2 cleanup

+add-srcu-based-notifier-chains-cleanup.patch

 Tidy add-srcu-based-notifier-chains.patch

+kill-include-linux-configh.patch

 Remove config.h inclusions

+input_register_device-debug.patch
+put_bh-debug.patch

 debugging patches.




All 1382 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/patch-list

