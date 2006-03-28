Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWC1IfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWC1IfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWC1IfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:35:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751375AbWC1IfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:35:18 -0500
Date: Tue, 28 Mar 2006 00:35:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-mm2
Message-Id: <20060328003508.2b79c050.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm2/


- It seems to compile.



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it's not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.




Changes since 2.6.16-mm1:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-arm.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-libata-all.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-serial.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-target.patch
 git-sas-jg.patch
 git-watchdog.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-frv.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees.

-proc-fix-duplicate-line-in-proc-devices.patch
-sys_alarm-unsigned-signed-conversion-fixup.patch
-sys_alarm-unsigned-signed-conversion-fixup-fix.patch
-validate-and-sanitze-itimer-timeval-from-userspace.patch
-validate-and-sanitze-itimer-timeval-from-userspace-fix.patch
-fix-scheduler-deadlock.patch
-fix-bug-bio_rw_barrier-requests-to-md-raid1-hang.patch
-fix-use-after-free-in-cciss_init_one.patch
-serial-remove-8250_acpi-replaced-by-8250_pnp-and-pnpacpi.patch
-fix-sequencer-missing-negative-bound-check.patch
-pnp-adjust-pnp_register_card_driver-signature-ad1816a.patch
-pnp-adjust-pnp_register_card_driver-signature-als100.patch
-pnp-adjust-pnp_register_card_driver-signature-azt2320.patch
-pnp-adjust-pnp_register_card_driver-signature-cmi8330.patch
-pnp-adjust-pnp_register_card_driver-signature-dt019x.patch
-pnp-adjust-pnp_register_card_driver-signature-es18xx.patch
-pnp-adjust-pnp_register_card_driver-signature-es968.patch
-pnp-adjust-pnp_register_card_driver-signature-interwave.patch
-pnp-adjust-pnp_register_card_driver-signature-sb16.patch
-pnp-adjust-pnp_register_card_driver-signature-sb_card.patch
-pnp-adjust-pnp_register_card_driver-signature-sscape.patch
-pnp-adjust-pnp_register_card_driver-signature-wavefront.patch
-blk_execute_rq_nowait-speedup.patch
-block-layer-increase-size-of-disk-stat.patch
-cpufreq-_ppc-frequency-change-issues-freq-already-lowered-by-bios.patch
-powernow-remove-private-for_each_cpu_mask.patch
-cpufreq_conservative-aligning-of-codebase-with-ondemand.patch
-cpufreq_conservative-alter-default-responsiveness.patch
-cpufreq_conservative-make-for_each_cpu-safe.patch
-cpufreq_conservative-alternative-initialise-approach.patch
-gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch
-gregkh-driver-fix-up-the-sysfs-pollable-patch.patch
-gregkh-driver-aoe-zero-packet-data-after-skb-allocation.patch
-gregkh-driver-aoe-support-dynamic-resizing-of-aoe-devices.patch
-gregkh-driver-aoe-increase-allowed-outstanding-packets.patch
-gregkh-driver-aoe-use-less-confusing-driver-name.patch
-gregkh-driver-aoe-allow-network-interface-migration-on-packet-retransmit.patch
-gregkh-driver-aoe-update-device-information-on-last-close.patch
-gregkh-driver-aoe-update-driver-compatibility-string.patch
-gregkh-driver-aoe-update-driver-version-number.patch
-gregkh-driver-aoe-do-not-stop-retransmit-timer-when-device-goes-down.patch
-gregkh-driver-aoe-support-multiple-aoe-listeners.patch
-gregkh-driver-aoe-don-t-request-ata-device-id-on-ata-error.patch
-gregkh-driver-aoe-update-version-to-22.patch
-sysfs_h-cleanup.patch
-gregkh-driver-kobject-fix-build-error-if-config_sysfs-n-fix.patch
-v4l-printk-warning-fixes.patch
-saa7110-fix-array-overrun.patch
-saa7111-prevent-array-overrun.patch
-saa7114-fix-i2c-block-write.patch
-adv7175-drop-unused-encoder-dump-command.patch
-adv7175-drop-unused-register-cache.patch
-zoran-use-i2c_master_send-when-possible.patch
-bt856-spare-memory.patch
-zoran-init-cleanups.patch
-saa7111c-fix.patch
-sem2mutex-zoran.patch
-gregkh-i2c-hwmon-allow-sensor-attr-arrays.patch
-gregkh-i2c-hwmon-pc87360-use-attr-arrays.patch
-gregkh-i2c-hwmon-f71805f-use-attr-arrays.patch
-gregkh-i2c-i2c-convert-i2c-to-mutexes.patch
-gregkh-i2c-i2c-scx200_acb-01-whitespace.patch
-gregkh-i2c-i2c-scx200_acb-02-debug.patch
-gregkh-i2c-i2c-scx200_acb-03-refactor.patch
-gregkh-i2c-i2c-scx200_acb-04-lock_kernel.patch
-gregkh-i2c-i2c-scx200_acb-05-cs5535.patch
-gregkh-i2c-i2c-scx200_acb-06-poll.patch
-gregkh-i2c-i2c-scx200_acb-07-docs.patch
-gregkh-i2c-i2c-fix-sx200_acb-build-on-other-arches.patch
-gregkh-i2c-hwmon-sensor-attr-array-2.patch
-gregkh-i2c-hwmon-w83792d-use-attr-arrays.patch
-gregkh-i2c-hwmon-w83792d-drop-useless-macros.patch
-gregkh-i2c-i2c-speedup-block-transfers.patch
-gregkh-i2c-i2c-convert-semaphores-to-mutexes-2.patch
-gregkh-i2c-i2c-convert-semaphores-to-mutexes-3.patch
-gregkh-i2c-hwmon-convert-semaphores-to-mutexes.patch
-gregkh-i2c-hwmon-f71805f-convert-semaphore-to-mutex.patch
-gregkh-i2c-hwmon-w83627hf-add-w83687thf-support.patch
-gregkh-i2c-hwmon-vid-pentium-m.patch
-gregkh-i2c-hwmon-w83627ehf-use-attr-arrays.patch
-gregkh-i2c-hwmon-w83781d-document-alarm-bits.patch
-gregkh-i2c-hwmon-w83781d-no-reset-by-default.patch
-gregkh-i2c-i2c-core-optimize-mutex-use.patch
-gregkh-i2c-i2c-drop-frodo.patch
-gregkh-i2c-i2c-ite-name-init.patch
-gregkh-i2c-i2c-isp1301_omap-driver-cleanups.patch
-gregkh-i2c-i2c-ali1535-drop-redundant-mutex.patch
-gregkh-i2c-i2c-amd756-s4882-mutex-init.patch
-gregkh-i2c-i2c-piix4-add-ht1000-support.patch
-gregkh-i2c-i2c-ixp4xx-hwmon-class.patch
-gregkh-i2c-i2c-drop-unneeded-i2c-dev-h-includes.patch
-gregkh-i2c-hwmon-rename-register-parameters.patch
-gregkh-i2c-hwmon-add-required-idr-locking.patch
-gregkh-i2c-w1-change-the-type-unsigned-long-member-of-struct-w1_bus_master-to-void.patch
-gregkh-i2c-w1-move-w1-bus-master-code-into-w1-masters-and-move-w1-slave-code-into-w1-slaves.patch
-gregkh-i2c-w1-add-the-ds2482-i2c-to-w1-bridge-driver.patch
-gregkh-i2c-w1-misc-cleanups.patch
-gregkh-i2c-fix-w1_master_ds9490_bridge-dependencies.patch
-gregkh-i2c-w1-remove-incorrect-module_alias.patch
-gregkh-i2c-w1-u64-is-not-long-long.patch
-gregkh-i2c-w1-use-kthread-api.patch
-ia64-sn_check_intr-use-ia64_get_irr.patch
-fix-spidernet-build-issue.patch
-amd-au1xx0-fix-ethernet-tx-stats.patch
-optimise-d_find_alias.patch
-git-powerpc-hot_add_scn_to_nid-build-fix.patch
-powerpc-add_memory-warning-fix.patch
-make-powerbook_sleep_grackle-static.patch
-powerpc-dont-allow-old-rtc-to-be-selected.patch
-gregkh-pci-msi-vector-targeting-abstractions.patch
-gregkh-pci-per-platform-ia64_-first-last-_device_vector-definitions.patch
-gregkh-pci-altix-msi-support.patch
-gregkh-pci-pci-fix-msi-build-breakage-in-x86_64.patch
-gregkh-pci-pci-clean-up-msi.c-a-bit.patch
-gregkh-pci-pci-return-max-reserved-busnr.patch
-gregkh-pci-pci-really-fix-parent-s-subordinate-busnr.patch
-gregkh-pci-pci-quirk-for-ibm-dock-ii-cardbus-controllers.patch
-gregkh-pci-pci-hotplug-convert-semaphores-to-mutex.patch
-gregkh-pci-shpchp-cleanup-init_slots.patch
-gregkh-pci-shpchp-cleanup-shpchp_core.c.patch
-gregkh-pci-shpchp-cleanup-slot-list.patch
-gregkh-pci-shpchp-cleanup-controller-list.patch
-gregkh-pci-shpchp-cleanup-check-command-status.patch
-gregkh-pci-shpchp-bugfix-add-missing-serialization.patch
-gregkh-pci-pcihp_skeleton.c-cleanup.patch
-gregkh-pci-shpchp-replace-kmalloc-with-kzalloc-and-cleanup-arg-of-sizeof.patch
-gregkh-pci-shpchp-removed-unncessary-magic-member-from-slot.patch
-gregkh-pci-shpchp-move-slot-name-into-struct-slot.patch
-gregkh-pci-shpchp-fix-incorrect-return-value-of-interrupt-handler.patch
-gregkh-pci-pci-give-pci-config-access-initialization-a-defined-ordering.patch
-gregkh-pci-pci-i386-run-bios-pci-detection-before-direct.patch
-gregkh-pci-pci-avoid-leaving-master_abort-disabled-permanently-when-returning-from-pci_scan_bridge.patch
-gregkh-pci-shpchp-remove-unused-pci_bus-member-from-controller-structure.patch
-gregkh-pci-shpchp-remove-unused-wait_for_ctrl_irq.patch
-gregkh-pci-shpchp-event-handling-rework.patch
-gregkh-pci-shpchp-fix-slot-state-handling.patch
-gregkh-pci-shpchp-adapt-to-pci-driver-model.patch
-gregkh-pci-pci-add-pci_device_shutdown-to-pci_bus_type.patch
-gregkh-pci-pci-smbus-unhide-on-hp-compaq-nx6110.patch
-gregkh-pci-pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch
-gregkh-pci-pci-make-msi-quirk-inheritable-from-the-pci-bus.patch
-gregkh-pci-pci-msi-save-restore-for-suspend-resume.patch
-gregkh-pci-pci-remove-msi-save-restore-code-in-specific-driver.patch
-gregkh-pci-pci-resource-address-mismatch.patch
-gregkh-pci-pci-fix-problems-with-msi-x-on-ia64.patch
-gregkh-pci-pci-pci-cardbus-cards-hidden-needs-pci-assign-busses-to-fix.patch
-gregkh-pci-pci-move-pci_dev_put-outside-a-spinlock.patch
-gregkh-pci-acpiphp-add-new-bus-to-acpi.patch
-gregkh-pci-acpi-export-acpi_bus_trim.patch
-gregkh-pci-acpiphp-add-dock-event-handling.patch
-gregkh-pci-acpi-remove-dock-event-handling-from-ibm_acpi.patch
-gregkh-pci-acpiphp-slot-management-fix-v4.patch
-gregkh-pci-acpiphp-fix-bridge-handle.patch
-gregkh-pci-pci-cpqphp_ctrl.c-board_replaced-remove-dead-code.patch
-gregkh-pci-pci-the-scheduled-removal-of-pci_legacy_proc.patch
-gregkh-pci-pci-provide-a-boot-parameter-to-disable-msi.patch
-gregkh-pci-pci-fix-pci_request_region-arg.patch
-gregkh-pci-shpchp-cleanup-bus-speed-handling.patch
-gregkh-pci-pci-hotplug-sn-fix-cleanup-on-hotplug-removal-of-ppb.patch
-gregkh-pci-acpiphp-scan-slots-under-the-nested-p2p-bridge.patch
-gregkh-pci-pci-kzalloc-conversion-in-drivers-pci.patch
-gregkh-pci-pci-hotplug-add-common-acpi-functions-to-core.patch
-gregkh-pci-ibmphp-remove-true-and-false.patch
-gregkh-pci-acpiphp-fix-acpi_path_name.patch
-gregkh-pci-altix-msi-support-git-ia64-fix.patch
-mm-drivers-pci-msi-explicit-declaration-of-msi_register.patch
-mm-drivers-pci-msi-explicit-declaration-of-msi_register-fix.patch
-git-scsi-misc-min-warning-fix.patch
-link-scsi_debug-later.patch
-sparc64-fix-set_page_count-merge-clash.patch
-gregkh-usb-usb-storage-unusual_devs.h-entry-0420-0001.patch
-cirrus-ep93xx-watchdog-driver.patch
-cirrus-ep93xx-watchdog-driver-tidy.patch
-hostap_apchostap_add_sta-inconsequent-null-checking.patch
-fix-hostap_cs-double-kfree.patch
-x86_64-mm-hotadd-pud.patch
-x86_64-mm-tune-generic.patch
-x86_64-mm-stack-random-large.patch
-x86_64-mm-bitops-cleanups.patch
-x86_64-mm-rename-node.patch
-x86_64-mm-cpu_pda-array-to-macro-followup-correction.patch
-x86_64-mm-disallow-multi-byte-hardware-execution-breakpoints.patch
-x86_64-mm-eliminate-set_debug.patch
-x86_64-mm-save-fpu-context-slightly-later.patch
-x86_64-mm-cleanup-allocating-logical-cpu-numbers-in-x86_64.patch
-x86_64-mm-pmtimer-dont-touch-pit.patch
-x86_64-mm-boot-report-apicid.patch
-x86_64-mm-gart-relax.patch
-x86_64-mm-actively-synchronize-vmalloc-area-when-registering-certain-callbacks.patch
-x86_64-mm-remove-dead-do_softirq_thunk.patch
-x86_64-mm-argument-check.patch
-x86_64-mm-fix-string.patch
-x86_64-mm-agp-ali-m1695.patch
-x86_64-mm-traps-whitespace.patch
-x86_64-mm-early-num-physpages.patch
-x86_64-mm-miscellaneous-cleanup.patch
-x86_64-mm-to-use-lapic-ids-instead-of-initial-apic-ids.patch
-x86_64-mm-raw1394-compat.patch
-x86_64-mm-prefetch-the-mmap_sem-in-the-fault-path.patch
-x86_64-mm-kernel-at-2mb.patch
-x86_64-mm-s-overwrite-override--in-arch-x86-64.patch
-x86_64-mm-dmi-year.patch
-x86_64-mm-dmi-early.patch
-x86_64-mm-fixmap-init.patch
-x86_64-mm-head-first.patch
-x86_64-mm-year-check.patch
-x86_64-mm-time-style.patch
-x86_64-mm-reenable-cmos-warning.patch
-x86_64-mm-floppy-dma.patch
-x86_64-mm-iommu-noretry.patch
-x86_64-mm-disable-8254-timer-by-default.patch
-x86_64-mm-basic-reorder-infrastructure.patch
-x86_64-mm-microcode-quiet.patch
-x86_64-mm-fix-orphaned-bits-of-timer-init-messages.patch
-x86_64-mm-cpu-limit.patch
-x86_64-mm-reorder-one-field-of-the-pda-to-reduce-padding.patch
-x86_64-mm-noexec32-default.patch
-x86_64-mm-timer-broadcast-amd.patch
-x86_64-mm-memmap-alloc.patch
-x86_64-mm-use-cpumask-bitops-for-cpu_vm_mask.patch
-x86_64-mm-kexec-interrupt-ack.patch
-x86_64-mm-free_bootmem_node-needs-__pa-in-allocate_aperture.patch
-x86_64-mm-lagrange-feature.patch
-x86_64-mm-remove-unordered-io.patch
-x86_64-mm-make-gart_iommu-kconfig-help-text-more-specific-trivial.patch
-x86_64-mm-local-64bit.patch
-x86_64-mm-horus-pci.patch
-x86_64-mm-eliminate-register_die_notifier-symbol-exported.patch
-x86_64-mm-memnode-cache.patch
-x86_64-mm-amd-core-parsing.patch
-x86_64-mm-powernow-query.patch
-x86_64-mm-iret-error-code.patch
-x86_64-mm-via-agp.patch
-x86_64-mm-timer-broadcast-amd-fix.patch
-x86_64-mm-timer-broadcast-amd-fix-fix.patch
-x86-64-fix-double-definition-of-force_iommu.patch
-drivers-block-floppyc-dont-free_irq-from-irq-context.patch
-drivers-block-floppyc-dont-free_irq-from-irq-context-fix.patch
-warn-if-free_irq-is-called-from-irq-context.patch
-protect-remove_proc_entry.patch
-slab-leaks.patch
-slab-leaks3-locking-fix.patch
-slab-leaks3-default-y.patch
-slab-introduce-kmem_cache_zalloc-allocator.patch
-slab-optimize-constant-size-kzalloc-calls.patch
-mm-use-kmem_cache_zalloc.patch
-slab-add-transfer_objects-function.patch
-slab-add-transfer_objects-function-fix.patch
-slab-bypass-free-lists-for-__drain_alien_cache.patch
-alloc_kmemlist-some-cleanup-in-preparation-for-a-real-memory-leak-fix.patch
-slab-fix-memory-leak-in-alloc_kmemlist.patch
-slab-fix-memory-leak-in-alloc_kmemlist-fix.patch
-add-api-for-flushing-anon-pages.patch
-add-flush_kernel_dcache_page-api.patch
-mm-make-page-migration-dependent-on-swap-and-numa.patch
-bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm.patch
-bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm-update.patch
-bug-fixes-and-cleanup-for-the-bsd-secure-levels-lsm-update-tidy.patch
-macintosh-cleanup-the-use-of-i2c-headers.patch
-via-pmu-warning-fix.patch
-powerpc-tidy-up-of_register_driver-driver_register-return-values.patch
-macintosh-tidy-up-driver_register-return-values.patch
-i386-let-regparm-no-longer-depend-on-experimental.patch
-make-config_regparm-enabled-by-default.patch
-i386-multi-column-stack-backtraces.patch
-x86-smp-alternatives.patch
-i386-__devinit-should-be-__cpuinit.patch
-i386-allow-disabling-x86_feature_sep-at-boot.patch
-i386-add-a-temporary-to-make-put_user-more-type-safe.patch
-i386-fall-back-to-sensible-cpu-model-name.patch
-compilation-fix-for-es7000-when-no-acpi-is-specified-in-config-i386.patch
-i386-remove-duplicate-declaration-of-mp_bus_id_to_pci_bus.patch
-make-isoimage-support-fdinitrd=-support-minor-cleanups.patch
-i386-traps-merge-printk-calls.patch
-i386-dont-let-ptrace-set-the-nested-task-bit.patch
-i386-let-signal-handlers-set-the-resume-flag.patch
-x86-early-printk-handling-fixes.patch
-x86-start-early_printk-at-sensible-screen-row.patch
-x86-early-printk-remove-max_ypos-and-max_xpos-macros.patch
-register-the-boot-cpu-in-the-cpu-maps-earlier.patch
-register-the-boot-cpu-in-the-cpu-maps-earlier-fix.patch
-i386-pass-proper-trap-numbers-to-die-chain-handlers.patch
-i386-actively-synchronize-vmalloc-area-when-registering-certain-callbacks.patch
-i386-actively-synchronize-vmalloc-area-when-registering-certain-callbacks-tidy.patch
-i386-fix-uses-of-user_mode-vs-user_mode_vm.patch
-i386-fix-singlestep-through-an-int80-syscall.patch
-i386-more-vsyscall-documentation.patch
-fix-implicit-declaration-of-get_apic_id-in-arch-i386-kernel-apicc.patch
-fix-the-imlicit-declaration-of-mtrr_centaur_report_mcr-in-arch-i386-kernel-cpu-centaurc.patch
-fix-the-imlicit-declaration-of-mtrr_centaur_report_mcr-in-arch-i386-kernel-cpu-centaurc-fix.patch
-i386-cleanup-after-cpu_gdt_descr-conversion-to.patch
-i386-fix-dump_stack.patch
-x86-cpuid4-doesnt-need-cpu-level-5.patch
-x86-deterine-xapic-using-apic-version.patch
-i386-spinlocks-disable-interrupts-only-if-we-enabled.patch
-x86-some-fixups-for-the-x86_numaq-dependencies.patch
-x86-make-_syscallx-macros-compile-in-pic-mode.patch
-x86-topology-dont-create-a-control-file-for-bsp-that-cannot-be-removed.patch
-x86-make-config_hotplug_cpu-depend-on-x86_pc.patch
-pm-timer-dont-use-workaround-if-chipset-is-not-buggy.patch
-pm-timer-dont-use-workaround-if-chipset-is-not-buggy-tidy.patch
-ia64-use-i386-dmi_scanc.patch
-ia64-use-i386-dmi_scanc-fix.patch
-efi-dev-mem-simplify-efi_mem_attribute_range.patch
-ia64-ioremap-check-efi-for-valid-memory-attributes.patch
-dmi-only-ioremap-stuff-we-actually-need.patch
-efi-keep-physical-table-addresses-in-efi-structure.patch
-efi-fixes.patch
-acpi-clean-up-memory-attribute-checking-for-map-read-write.patch
-revert-swsusp-fix-breakage-with-swap-on-lvm.patch
-swsusp-low-level-interface-rev-2.patch
-swsusp-separate-swap-writing-reading-code-rev-2.patch
-swsusp-separate-swap-writing-reading-code-rev-2-fix-writing-progress-meter.patch
-mm-kernel-power-move-externs-to-header-files.patch
-swsusp-documentation-updates.patch
-swsusp-documentation-updates-update.patch
-swsusp-documentation-updates-warn-about-filesystems-mounted-from-usb-devices.patch
-swsusp-documentation-fix.patch
-add-s2ram-pointer-to-suspend-documentation.patch
-swsusp-userland-interface.patch
-swsusp-userland-interface-fixes.patch
-swsusp-userland-interface-fix-breakage-with-swap-on-lvm.patch
-swsusp-freeze-user-space-processes-first.patch
-suspend-make-progress-printing-prettier.patch
-swsusp-finally-solve-mysqld-problem.patch
-swsusp-drain-high-mem-pages.patch
-swsusp-add-check-for-suspension-of-x-controlled-devices.patch
-swsusp-let-userland-tools-switch-console-on-suspend.patch
-swsusp-add-s2ram-ioctl-to-userland-interface.patch
-m68k-rtc-driver-cleanup.patch
-s390-wrong-interrupt-delivered-for-hsch-or-csch.patch
-s390-cio-documentation-update.patch
-s390-channel-path-measurements.patch
-s390-early-parameter-parsing.patch
-s390-proc-sys-vm-cmm_-permission-bits.patch
-s390-bug-warnings.patch
-s390-cpu-up-retries.patch
-s390-connector-support.patch
-s390-use-normal-switch-statement-for-ioctls-in-dasd_ioctlc.patch
-s390-use-normal-switch-statement-for-ioctls-in-dasd_ioctlc-2.patch
-s390-merge-cmb-into-dasdc.patch
-s390-remove-dynamic-dasd-ioctls.patch
-s390-remove-old-history-whitespave-from-partition-code.patch
-s390-remove-experimental-flag-from-dasd-diag.patch
-s390-random-values-in-result-of-biodasdinfo2.patch
-s390-dasd-extended-error-reporting.patch
-s390-tape-retry-flooding-by-deferred-cc-in-interrupt.patch
-s390-tape-operation-abortion-leads-to-panic.patch
-s390-fix-endless-retry-loop-in-tape-driver.patch
-s390-3590-tape-driver.patch
-s390-remove-support-for-ttys-over-ctc-connections.patch
-s390-cex2a-crt-message-length.patch
-s390-kzalloc-conversion-in-arch-s390.patch
-s390-kzalloc-conversion-in-drivers-s390.patch
-dasd-cleanup-dasd_ioctl-fix.patch
-ext3_readdir-use-generic-readahead.patch
-reduce-size-of-bio-mempools.patch
-shrinks-sizeoffiles_struct-and-better-layout.patch
-avoid-taking-global-tasklist_lock-for-single-threadedprocess-at-getrusage.patch
-cleanup-cdrom_ioctl.patch
-kill-cdrom-dev_ioctl-method.patch
-move-read_mostly-definition-to-asm-cacheh.patch
-fix-oops-in-invalidate_dquots.patch
-kernel-cpusetc-mutex-conversion.patch
-convert-kernel-rcupdatecrcu_barrier_sema-to-mutex.patch
-convert-fs-9p-to-mutexes-fix-locking-bugs.patch
-sem2mutex-kcapic.patch
-sem2mutex-drivers-raw-connector-dcdbas-ppp_generic.patch
-sem2mutex-drivers-scsi-ide-scsic.patch
-sem2mutex-kernel.patch
-sem2mutex-fs.patch
-sem2mutex-drivers-block-pktcdvdc.patch
-sem2mutex-drivers-block-floppyc.patch
-sem2mutex-drivers-char.patch
-sem2mutex-misc-static-one-file-mutexes.patch
-sem2mutex-blockdev-2.patch
-sem2mutex-blockdev-2-git-blktrace-fix.patch
-sem2mutex-quota.patch
-sem2mutex-inotify.patch
-sem2mutex-tty.patch
-sem2mutex-eventpoll.patch
-sem2mutex-vfs_rename_mutex.patch
-sem2mutex-iprune.patch
-sem2mutex-jbd-j_checkpoint_mutex.patch
-sem2mutex-kprobes.patch
-sem2mutex-ipc-idsem.patch
-sem2mutex-ipc-idsem-fix.patch
-sem2mutex-fs-libfsc.patch
-sem2mutex-fs-seq_filec.patch
-sem2mutex-drivers-block-loopc.patch
-sem2mutex-drivers-block-nbdc.patch
-sem2mutex-sound-oss.patch
-sem2mutex-jffs.patch
-sem2mutex-ntfs.patch
-sem2mutex-netfilter-x_tablec.patch
-sem2mutex-autofs4-wq_sem.patch
-sem2mutex-hpfs.patch
-convert-ext3s-truncate_sem-to-a-mutex.patch
-sem2mutex-ncpfs.patch
-sem2mutex-udf.patch
-sem2mutex-serial-port_write_mutex.patch
-sem2mutex-drivers-ide.patch
-kernel-modulec-semaphore-to-mutex-conversion-for-module_mutex.patch
-oss-semaphore-to-mutex-conversion.patch
-fat_lock-is-used-as-a-mutex-convert-it-to-using-the-new-mutex.patch
-snsc-kmalloc2kzalloc.patch
-sigprocmask-kill-unneeded-temp-var.patch
-fs-ufs-filec-drop-insane-header-dependencies.patch
-extract-inode_inc_count-inode_dec_count.patch
-minix-switch-to-inode_inc_link_count-inode_dec_link_count.patch
-sysv-switch-to-inode_inc_link_count-inode_dec_link_count.patch
-ext2-switch-to-inode_inc_link_count-inode_dec_link_count.patch
-ufs-switch-to-inode_inc_link_count-inode_dec_link_count.patch
-make-bug-messages-more-consistent.patch
-notifier-profileh-forward-decl.patch
-kill-_inline_.patch
-pause_on_oops-command-line-option.patch
-pnpbios-missing-small_tag_enddep-tag.patch
-build_lock_ops-cleanup-preempt_disable-usage.patch
-devpts-use-lib-parserc-for-parsing-mount-options.patch
-kernel-rcupdatec-make-two-structs-static.patch
-fs-filec-drop-insane-header-dependencies.patch
-atomic-add_unless-cmpxchg-optimise.patch
-get_empty_filp-tweaks-inline-epoll_init_file.patch
-only-allocate-percpu-data-for-possible-cpus.patch
-more-for_each_cpu-conversions.patch
-i386-instead-of-poisoning-init-zone-change-protection.patch
-__generic_per_cpu-changes.patch
-fs-use-array_size-macro.patch
-remove-isa-legacy-functions-drivers-char-toshibac.patch
-remove-isa-legacy-functions-drivers-scsi-g_ncr5380c.patch
-remove-isa-legacy-functions-drivers-scsi-in2000c.patch
-remove-isa-legacy-functions-drivers-net-hp-plusc.patch
-remove-isa-legacy-functions-drivers-net-lancec.patch
-remove-isa-legacy-functions-remove-the-helpers.patch
-remove-isa-legacy-functions-remove-documentation.patch
-bitmap-region-cleanup.patch
-bitmap-region-multiword-spanning-support.patch
-bitmap-region-restructuring.patch
-free_uid-locking-improvement.patch
-represent-dirty__centisecs-as-jiffies-internally.patch
-represent-laptop_mode-as-jiffies-internally.patch
-range-checking-in-do_proc_dointvec_userhz_jiffies_conv.patch
-rcu_process_callbacks-dont-cli-while-testing-nxtlist.patch
-fs-9p-possible-cleanups.patch
-fs-ext2-proper-ext2_get_parent-prototype.patch
-fs-coda-proper-prototypes.patch
-tvec_bases-too-large-for-per-cpu-data.patch
-remove-drivers-mca-mca-procc.patch
-unify-pxm_to_node-id-ver2-generic-code.patch
-unify-pxm_to_node-id-ver2-for-ia64.patch
-unify-pxm_to_node-id-ver2-for-x86_64.patch
-unify-pxm_to_node-id-ver2-for-i386.patch
-extract-ikconfig-use-mktemp1.patch
-extract-ikconfig-be-sure-binoffset-exists-before-extracting.patch
-extract-ikconfig-dont-use-long-options.patch
-kill-include-linux-platformh-default_idle-cleanup.patch
-rcutorture-tag-success-failure-line-with-module-parameters.patch
-cpusets-only-wakeup-kswapd-for-zones-in-the-current-cpuset.patch
-cpuset-cleanup-not-not-operators.patch
-cpuset-use-combined-atomic_inc_return-calls.patch
-cpuset-memory-spread-basic-implementation.patch
-cpuset-memory-spread-page-cache-implementation-and-hooks.patch
-cpuset-memory-spread-slab-cache-filesys.patch
-cpuset-memory-spread-slab-cache-format.patch
-cpuset-memory-spread-slab-cache-implementation.patch
-cpuset-memory-spread-slab-cache-optimizations.patch
-cpuset-memory-spread-slab-cache-hooks.patch
-cpuset-remove-unnecessary-null-check.patch
-cpuset-remove-unnecessary-null-check-comment-fix.patch
-cpuset-dont-need-to-mark-cpuset_mems_generation-atomic.patch
-cpuset-memory_spread_slab-drop-useless-pf_spread_page-check.patch
-cpuset-remove-useless-local-variable-initialization.patch
-remove-double-semicolons.patch
-isofs-remove-unused-debugging-macros.patch
-remove-ipmi-pm_power_off-redefinition.patch
-fast-ext3_statfs.patch
-fw-abstract-type-size-specification-for-assembly.patch
-config_unwind_info.patch
-filemap_fdata_write-api-fix-end-parameter.patch
-fadvise-async-write-commands.patch
-early_printk-cleanup-trailiing-whitespace.patch
-sb_set_blocksize-cleanup.patch
-shmdt-check-address-aligment.patch
-block-floppy98-removal-really.patch
-sound-remove-pc98-specific-opl3_hw_opl3_pc98.patch
-net-remove-config_net_cbus-conditional-for-ns8390.patch
-hotplug_cpu-avoid-hitting-too-many-cachelines-in-recalc_bh_state.patch
-balance_dirty_pages_ratelimited-take-nr_pages-arg.patch
-set_page_dirty-return-value-fixes.patch
-msync-perform-dirty-page-levelling.patch
-msync-ms_sync-dont-hold-mmap_sem-while-syncing.patch
-msync-fix-return-value.patch
-fsync-extract-internal-code.patch
-msync-use-do_fsync.patch
-secure-digital-host-controller-id-and-regs.patch
-secure-digital-host-controller-id-and-regs-fix.patch
-mmc-secure-digital-host-controller-interface-driver.patch
-mmc-secure-digital-host-controller-interface-driver-fix.patch
-mmc-sdhci-build-fix.patch
-updated-documentation-nfsroottxt.patch
-console_setup-depends-wrongly-on-config_printk.patch
-conditionalize-compat_sys_newfstatat.patch
-show-mcp-menu-only-on-arch_sa1100.patch
-ide-allow-ide-interface-to-specify-its-not-capable-of-32-bit.patch
-deprecate-the-kernel_thread-export.patch
-fix-value-computed-not-used-warnings.patch
-update-obsolete_oss_driver-schedule-and-dependencies-update.patch
-rio-more-header-cleanup.patch
-rioboot-lindent.patch
-rioboot-post-lindent.patch
-rio-driver-rework-continued-1.patch
-rio-driver-rework-continued-2.patch
-rio-driver-rework-continued-3.patch
-rio-driver-rework-continued-4.patch
-rio-driver-rework-continued-5.patch
-yet-more-rio-cleaning-1-of-2.patch
-yet-more-rio-cleaning-2-of-2.patch
-deprecate-the-tasklist_lock-export.patch
-sys_setrlimit-cleanup.patch
-rlimit_cpu-fix-handling-of-a-zero-limit.patch
-rlimit_cpu-document-wrong-return-value.patch
-ext3-properly-report-backup-block-present-in-a-group.patch
-fix-module-refcount-leak-in-__set_personality.patch
-timer-irq-driven-soft-watchdog-cleanups.patch
-softlockup-detection-vs-cpu-hotplug.patch
-timer-irq-driven-soft-watchdog-cleanups-update.patch
-strndup_user.patch
-strndup_user-convert-module.patch
-strndup_user-convert-keyctl.patch
-keys-fix-key-quota-management-on-key-allocation.patch
-keys-replace-duplicate-non-updateable-keys-rather-than-failing.patch
-jbd-embed-j_commit_timer-in-journal-struct.patch
-jbd-convert-kjournald-to-kthread-api.patch
-missed-error-checking-for-intents-filp-in-open_namei.patch
-small-cleanup-in-quotah.patch
-fs-inodec-make-iprune_mutex-static.patch
-reiserfs-fix-transaction-overflowing.patch
-reiserfs-handle-trans_id-overflow.patch
-reiserfs-reiserfs_file_write-will-lose-error-code-when-a-0-length-write-occurs-w-o_sync.patch
-introduce-fmode_exec-file-flag.patch
-add-lookup_instantiate_filp-usage-warning.patch
-isdn-fix-copy_to_user-unused-result-warning-in-isdn_ppp.patch
-constify-tty-flip-buffer-handling.patch
-drivers-block-nbdc-dont-defer-compile-error-to-runtime.patch
-hysdn-remove-custom-types.patch
-remove-module_parm.patch
-remove-module_parm-fix.patch
-kernel-paramsc-make-param_array-static.patch
-fix-edd-to-properly-ignore-signature-of-non-existing-drives.patch
-fix-defined-but-not-used-warning-in-net-rxrpc-maincrxrpc_initialise.patch
-sysrq-cleanup.patch
-cache-align-futex-hash-buckets.patch
-inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch
-inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix-2.patch
-ide-fix-section-mismatch-warning.patch
-block-floppy-fix-section-mismatch-warnings.patch
-move-pp_major-from-ppdevh-to-majorh.patch
-reiserfs-cleanups.patch
-initcall-failure-reporting.patch
-reiserfs-use-balance_dirty_pages_ratelimited_nr-in-reiserfs_file_write.patch
-hp300-fix-driver_register-return-handling-remove-dio_module_init.patch
-eisa-tidy-up-driver_register-return-value.patch
-amiga-fix-driver_register-return-handling-remove-zorro_module_init.patch
-kconfig-clarify-memory-debug-options.patch
-v9fs-consolidate-trans_sock-into-trans_fd.patch
-v9fs-rename-tids-to-tags-to-be-consistent-with-plan-9-documentation.patch
-v9fs-print-9p-messages.patch
-v9fs-print-9p-messages-fix.patch
-v9fs-print-9p-messages-fix-2.patch
-fs-9p-make-2-functions-static.patch
-v9fs-print-9p-messages-fix-3.patch
-v9fs-print-9p-messages-fix-4.patch
-v9fs-add-extension-field-to-tcreate.patch
-v9fs-fix-vfs_inode-dereference-before-null-check.patch
-v9fs-update-license-boilerplate.patch
-9p-fix-name-consistency-problems.patch
-9p-update-documentation.patch
-smbfs-fix-debug-logging-only-compilation-error.patch
-adjust-dev-kmemmemport-write-handlers.patch
-remove-maintainers-entry-for-rtlinux.patch
-fix-hardcoded-values-in-collie-frontlight.patch
-collie-fix-missing-pcmcia-bits.patch
-tpm-sparc32-build-fix.patch
-ads7846-build-fix.patch
-irq-uninline-migration-functions.patch
-irq-prevent-enabling-of-previously-disabled-interrupt.patch
-pollrdhup-epollrdhup-handling-for-half-closed-devices.patch
-add-a-proper-prototype-for-setup_arch.patch
-refactor-capable-to-one-implementation-add-__capable-helper.patch
-make-cap_ptrace-enforce-ptrace_tracme-checks.patch
-fix-messages-in-fs-minix.patch
-freeze_bdev-cleanup.patch
-move-cond_resched-after-iput-in-sync_sb_inodes.patch
-reduce-sched-latency-in-shrink_dcache_sb.patch
-kallsyms-handle-malloc-failure.patch
-per-cpufy-net-proto-structures-add-percpu_counter_modbh-tidy.patch
-percpu-counters-add-percpu_counter_exceeds-tidy.patch
-per-cpufy-net-proto-structures-protomemory_allocated-use-percpu_counter_exceeds.patch
-per-cpufy-net-proto-structures-protoinuse-fix.patch
-ext3-fix-debug-logging-only-compilation-error.patch
-find_task_by_pid-needs-tasklist_lock.patch
-blk_dev_initrd-do-not-require-blk_dev_ram=y.patch
-reiserfs-xattr_aclcreiserfs_get_acl-make-size-an-int.patch
-md-bitmapcbitmap_mask_state-fix-inconsequent-null-checking.patch
-drivers-char-ipmi-ipmi_msghandlerc-fix-a-memory-leak.patch
-removal-of-long-incorrect-address-for-jamie-lokier.patch
-remove-dead-address-from-maintainers-list.patch
-indirect_print_item-warning-fix.patch
-update-some-vfs-documentation.patch
-update-some-vfs-documentation-fix.patch
-honour-aop_truncate_page-returns-in-page_symlink.patch
-make-address_space_operations-sync_page-return-void.patch
-make-address_space_operations-invalidatepage-return-void.patch
-make-address_space_operations-invalidatepage-return-void-jbd-fix.patch
-make-address_space_operations-invalidatepage-return-void-versus-git-nfs.patch
-make-address_space_operations-invalidatepage-return-void-fix.patch
-maintainers-remove-dead-url.patch
-ext2-flags-shouldnt-report-nogrpid.patch
-fix-backwards-meaning-of-ms_verbose.patch
-no-need-to-protect-current-group_info-in-sys_getgroups.patch
-roundup_pow_of_two-64-bit-fix.patch
-fix-alloc_large_system_hash-roundup.patch
-i2o_dump_hrt-output-cleanup.patch
-compat_sys_nfsservctl-handle-errors-correctly.patch
-radix-tree-documentation-cleanups.patch
-i4l-isdn_ttyc-fix-a-check-after-use.patch
-fix-sb_mixer-use-before-validation.patch
-altix-rs422-support-for-ioc4-serial-driver.patch
-altix-rs422-support-for-ioc4-serial-driver-fixes.patch
-cpumask-uninline-first_cpu.patch
-cpumask-uninline-next_cpu.patch
-cpumask-uninline-highest_possible_processor_id.patch
-cpumask-uninline-any_online_cpu.patch
-oss-fix-leak-in-awe_wave-also-remove-pointless-cast.patch
-fix-memory-leak-in-isapnp.patch
-use-kzalloc-and-kcalloc-in-core-fs-code.patch
-udf-fix-uid-gid-options-and-add-uid-gid=ignore-and-forget.patch
-direct-io-bug-fix-in-dio-handling-write-error.patch
-doc-more-serial-console-info.patch
-check-if-cpu-can-be-onlined-before-calling-smp_prepare_cpu.patch
-check-if-cpu-can-be-onlined-before-calling-smp_prepare_cpu-fix.patch
-cleanup-smp_call_function-up-build.patch
-use-unsigned-int-types-for-a-faster-bsearch.patch
-eisa-ignore-generated-file-drivers-eisa-devlisth.patch
-udf-remove-duplicate-definitions.patch
-ipmi-add-generic-pci-handling.patch
-ipmi-add-generic-pci-handling-tidy.patch
-ipmi-add-full-sysfs-support.patch
-ipmi-add-full-sysfs-support-fixes.patch
-ipmi-add-full-sysfs-support-tidy.patch
-ipmi-add-full-sysfs-support-tidy-2.patch
-hpet-header-sanitization.patch
-doc-fix-example-firmware-source-code.patch
-use-__read_mostly-on-some-hot-fs-variables.patch
-remove-needless-check-in-binfmt_elfc.patch
-remove-needless-check-in-fs-read_writec.patch
-add-sa_percpu_irq-flag-support.patch
-kernel-timec-remove-unused-pps_-variables.patch
-vfsfs-locksc-cleanup-locks_insert_block.patch
-vfsfs-lockscnfsd4-add-race_free-posix_lock_file_conf.patch
-vfsfs-lockscnfsd4-add-race_free-posix_lock_file_conf-tidy.patch
-nfsd4-return-conflict-lock-without-races.patch
-flat-binary-loader-doesnt-check-fd-table-full.patch
-3c59x-use-mii_check_media.patch
-3c59x-use-mii_check_media-tidy.patch
-3c59x-decrease-polling-intervall.patch
-3c59x-carriercheck-for-forced-media.patch
-3c59x-use-ethtool_op_get_link.patch
-3c59x-remove-per-driver-versioning.patch
-3c59x-minor-cleanups.patch
-3c59x-documentation-update.patch
-mempool-add-page-allocator.patch
-mempool-use-common-mempool-page-allocator.patch
-mempool-add-kmalloc-allocator.patch
-mempool-use-common-mempool-kmalloc-allocator.patch
-mempool-add-kzalloc-allocator.patch
-mempool-use-common-mempool-kzalloc-allocator.patch
-mempool-add-mempool_create_slab_pool.patch
-mempool-use-mempool_create_slab_pool.patch
-autofs4-lookup-white-space-cleanup.patch
-autofs4-use-libfs-routines-for-readdir.patch
-autofs4-cant-mount-due-to-mount-point-dir-not-empty.patch
-autofs4-expire-code-readability-cleanup.patch
-autofs4-simplify-expire-tree-traversal.patch
-autofs4-fix-false-negative-return-from-expire.patch
-autofs4-expire-mounts-that-hold-no-extra-references-only.patch
-autofs4-remove-update_atime-unused-function.patch
-autofs4-add-a-show-mount-options-for-proc-filesystem.patch
-autofs4-white-space-cleanup-for-waitqc.patch
-autofs4-rename-simple_empty_nolock-function.patch
-autofs4-change-may_umount-functions-to-boolean.patch
-autofs4-increase-module-version.patch
-autofs4-nameidata-needs-to-be-up-to-date-for-follow_link.patch
-autofs4-add-v5-follow_link-mount-trigger-method.patch
-autofs4-add-v5-expire-logic.patch
-autofs4-add-new-packet-type-for-v5-communications.patch
-autofs4-add-new-packet-type-for-v5-communications-fix.patch
-autofs4-change-autofs_typ_-autofs_type_.patch
-remove-redundant-check-from-autofs4_put_super.patch
-autofs4-follow_link-missing-funtionality.patch
-2tb-files-st_blocks-is-invalid-when-calling-stat64.patch
-2tb-files-add-blkcnt_t.patch
-2tb-files-add-blkcnt_t-fixes.patch
-2tb-files-change-type-of-kstatfs-entries.patch
-ext3-get-blocks-maping-multiple-blocks-at-a-once.patch
-ext3-get-blocks-maping-multiple-blocks-at-a-once-vs-ext3_readdir-use-generic-readahead.patch
-ext3-get-blocks-maping-multiple-blocks-at-a-once-get-block-chain-confliction-fix.patch
-ext3-get-blocks-maping-multiple-blocks-at-a-once-journal-reentry-fix.patch
-ext3-get-blocks-multiple-block-allocation.patch
-ext3-get-blocks-support-multiple-blocks-allocation-in.patch
-ext3-get-blocks-adjust-accounting-info-in.patch
-ext3-get-blocks-adjust-accounting-info-in-fix.patch
-ext3-get-blocks-adjust-reservation-window-size-for.patch
-change-buffer_headb_size-to-size_t.patch
-pass-b_size-to-get_block.patch
-pass-b_size-to-get_block-speedup.patch
-pass-b_size-to-get_block-remove-unneeded-assignments.patch
-map-multiple-blocks-for-mpage_readpages.patch
-map-multiple-blocks-for-mpage_readpages-tidy.patch
-map-multiple-blocks-for-mpage_readpages-use-buffer_mapped.patch
-remove-get_blocks-support.patch
-ext3-cleanups-and-warn_on.patch
-ext3-multi-block-get_block.patch
-hrtimer-optimize-softirq-runqueues.patch
-pass-current-time-to-hrtimer_forward.patch
-posix-timer-cleanup-common_timer_get.patch
-posix-timer-cleanup-common_timer_get-fix.patch
-hrtimer-simplify-nanosleep.patch
-hrtimer-remove-state-field.patch
-hrtimer-remove-state-field-fix.patch
-remove-it_real_value-calculation-from-proc-stat.patch
-remove-define_ktime-and-ktime_to_clock_t.patch
-remove-nsec_t-typedef.patch
-hrtimers-remove-data-field.patch
-kprobes-clean-up-resume_execute.patch
-x86-kprobes-booster.patch
-x86-kprobes-booster-fix.patch
-kretprobe-kretprobe-booster.patch
-kretprobe-kretprobe-booster-spinlock-recursive-remove.patch
-kretprobe-instance-recycled-by-parent-process.patch
-kretprobe-instance-recycled-by-parent-process-tidy.patch
-kretprobe-instance-recycled-by-parent-process-fix.patch
-kprobe-handler-discard-user-space-trap.patch
-kprobe-handler-discard-user-space-trap-fix.patch
-kprobe-handler-discard-user-space-trap-fix-2.patch
-kprobe-handler-discard-user-space-trap-fix-3.patch
-kprobes-fix-broken-fault-handling-for-i386.patch
-kprobes-fix-broken-fault-handling-for-x86_64.patch
-kprobes-fix-broken-fault-handling-for-powerpc64.patch
-kprobes-fix-broken-fault-handling-for-ia64.patch
-kprobes-fix-broken-fault-handling-for-sparc64.patch
-kprobes-fix-broken-fault-handling-for-sparc64-fix.patch
-isdn4linux-siemens-gigaset-drivers-kconfigs-and-makefiles.patch
-isdn4linux-siemens-gigaset-drivers-common-module.patch
-isdn4linux-siemens-gigaset-drivers-event-layer.patch
-isdn4linux-siemens-gigaset-drivers-isdn4linux-interface.patch
-isdn4linux-siemens-gigaset-drivers-tty-interface.patch
-isdn4linux-siemens-gigaset-drivers-procfs-interface.patch
-isdn4linux-siemens-gigaset-drivers-direct-usb-connection.patch
-isdn4linux-siemens-gigaset-drivers-isochronous-data-handler.patch
-isdn4linux-siemens-gigaset-drivers-m105-usb-dect-adapter.patch
-dead-code-in-drivers-isdn-avm-avmcardh.patch
-edac-switch-to-kthread_-api.patch
-edac-switch-to-kthread_-api-tidy.patch
-edac-printk-cleanup.patch
-edac-name-cleanup.patch
-edac-amd76x-pci_dev_get-pci_dev_put-fixes.patch
-edac-e752x-cleanup.patch
-edac-i82860-cleanup.patch
-edac-i82875p-cleanup.patch
-edac-e7xxx-fix-minor-logic-bug.patch
-edac-cleanup-code-for-clearing-initial-errors.patch
-edac-edac_mc_add_mc-fix-1.patch
-edac-edac_mc_add_mc-fix-2.patch
-edac-kobject_init-kobject_put-fixes.patch
-edac-kobject-sysfs-fixes.patch
-edac-protect-memory-controller-list.patch
-edac-kconfig-dependency-changes.patch
-edac-reorder-export_symbol-macros.patch
-edac-formatting-cleanup.patch
-edac-documentation-spelling-fixes.patch
-edac-use-sysbus_message-in-e752x-code.patch
-edac-use-sysbus_message-in-e752x-code-fix.patch
-edac-add-maintainers-for-chipset-drivers.patch
-edac-use-export_symbol_gpl.patch
-knfsd-change-the-store-of-auth_domains-to-not-be-a-cache.patch
-knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix.patch
-knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-2.patch
-knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-3.patch
-knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-3-fix.patch
-knfsd-break-the-hard-linkage-from-svc_expkey-to-svc_export.patch
-knfsd-get-rid-of-inplace-sunrpc-caches.patch
-knfsd-create-cache_lookup-function-instead-of-using-a-macro-to-declare-one.patch
-knfsd-convert-ip_map-cache-to-use-the-new-lookup-routine.patch
-knfsd-use-new-cache_lookup-for-svc_export.patch
-knfsd-use-new-cache_lookup-for-svc_expkey-cache.patch
-knfsd-use-new-sunrpc-cache-for-rsi-cache.patch
-knfsd-use-new-cache-code-for-rsc-cache.patch
-knfsd-use-new-cache-code-for-name-id-lookup-caches.patch
-knfsd-an-assortment-of-little-fixes-to-the-sunrpc-cache-code.patch
-knfsd-remove-definecachelookup.patch
-knfsd-unexport-cache_fresh-and-fix-a-small-race.patch
-knfsd-convert-sunrpc_cache-to-use-krefs.patch
-knfsd-convert-sunrpc_cache-to-use-krefs-fix.patch
-fs-nfsd-exportcnet-sunrpc-cachec-make-needlessly-global-code-static.patch
-sched-fix-task-interactivity-calculation.patch
-small-schedule-microoptimization.patch
-sched-new-sched-domain-for-representing-multi-core.patch
-sched-fix-group-power-for-allnodes_domains.patch
-x86-dont-use-cpuid2-to-determine-cache-info-if-cpuid4-is-supported.patch
-cmpci-dont-use-generig_hweight32.patch
-frv-remove-unnecessary-ampersand.patch
-function-typo-fixes.patch
-um-fix-undefined-reference-to-hweight32.patch
-arm-fix-undefined-reference-to-generic_fls.patch
-oss-sonicvibesc-defines-its-own-hweight32.patch
-bitops-alpha-use-config-options-instead-of-__alpha_fix__-and-__alpha_cix__.patch
-bitops-ia64-use-cpu_set-instead-of-__set_bit.patch
-bitops-parisc-add-pair-in-__ffz-macro.patch
-bitops-cris-remove-unnecessary-local_irq_restore.patch
-bitops-use-non-atomic-operations-for-minix__bit-and-ext2__bit.patch
-bitops-generic-test_and_setclearchange_bit.patch
-bitops-generic-test_and_setclearchange_bit-fix.patch
-bitops-generic-__test_and_setclearchange_bit-and-test_bit.patch
-bitops-generic-__ffs.patch
-bitops-generic-ffz.patch
-bitops-generic-fls.patch
-bitops-generic-fls64.patch
-bitops-generic-find_nextfirst_zero_bit.patch
-bitops-generic-sched_find_first_bit.patch
-bitops-generic-ffs.patch
-bitops-generic-hweight6432168.patch
-bitops-generic-hweight6432168-fix.patch
-bitops-generic-ext2_setcleartestfind_first_zerofind_next_zero_bit.patch
-bitops-generic-ext2_setclear_bit_atomic.patch
-bitops-generic-minix_testsettest_and_cleartestfind_first_zero_bit.patch
-bitops-alpha-use-generic-bitops.patch
-bitops-arm-use-generic-bitops.patch
-bitops-arm26-use-generic-bitops.patch
-bitops-cris-use-generic-bitops.patch
-bitops-frv-use-generic-bitops.patch
-bitops-h8300-use-generic-bitops.patch
-bitops-i386-use-generic-bitops.patch
-bitops-ia64-use-generic-bitops.patch
-bitops-m32r-use-generic-bitops.patch
-bitops-m68k-use-generic-bitops.patch
-bitops-m68k-use-generic-bitops-fix.patch
-bitops-ppc-use-generic-bitops.patch
-bitops-m68knommu-use-generic-bitops.patch
-bitops-mips-use-generic-bitops.patch
-bitops-parisc-use-generic-bitops.patch
-bitops-powerpc-use-generic-bitops.patch
-bitops-s390-use-generic-bitops.patch
-bitops-sh-use-generic-bitops.patch
-bitops-sh64-use-generic-bitops.patch
-bitops-sparc-use-generic-bitops.patch
-bitops-sparc64-use-generic-bitops.patch
-bitops-v850-use-generic-bitops.patch
-bitops-x86_64-use-generic-bitops.patch
-bitops-xtensa-use-generic-bitops.patch
-bitops-update-include-asm-generic-bitopsh.patch
-bitops-make-thread_infoflags-an-unsigned-long.patch
-bitops-ia64-make-partial_pagebitmap-an-unsigned-long.patch
-bitops-ntfs-remove-generic_ffs.patch
-bitops-remove-unused-generic-bitops-in-include-linux-bitopsh.patch
-bitops-hweight-related-cleanup.patch
-bitops-hweight-speedup.patch
-unify-pfn_to_page-generic-functions.patch
-unify-pfn_to_page-sparc64-pfn_to_page.patch
-unify-pfn_to_page-i386-pfn_to_page.patch
-unify-pfn_to_page-powerpc-pfn_to_page.patch
-unify-pfn_to_page-alpha-pfn_to_page.patch
-unify-pfn_to_page-arm-pfn_to_page.patch
-unify-pfn_to_page-arm26-pfn_to_page.patch
-unify-pfn_to_page-cris-pfn_to_page.patch
-unify-pfn_to_page-frv-pfn_to_page.patch
-unify-pfn_to_page-h8300-pfn_to_page.patch
-unify-pfn_to_page-m32r-pfn_to_page.patch
-unify-pfn_to_page-mips-pfn_to_page.patch
-unify-pfn_to_page-parisc-pfn_to_page.patch
-unify-pfn_to_page-ppc-pfn_to_page.patch
-unify-pfn_to_page-s390-pfn_to_page.patch
-unify-pfn_to_page-sh-pfn_to_page.patch
-unify-pfn_to_page-sh64-pfn_to_page.patch
-unify-pfn_to_page-sparc-pfn_to_page.patch
-unify-pfn_to_page-uml-pfn_to_page.patch
-unify-pfn_to_page-v850-pfn_to_page.patch
-unify-pfn_to_page-xtensa-pfn_to_page.patch
-unify-pfn_to_page-ia64-pfn_to_page.patch
-remove-zone_mem_map.patch
-for_each_online_pgdat-take2-define.patch
-for_each_online_pgdat-take2-for_each_bootmem.patch
-for_each_online_pgdat-take2-for_each_bootmem-fix.patch
-for_each_online_pgdat-take2-renaming.patch
-for_each_online_pgdat-take2-remove-sorting-pgdat.patch
-for_each_online_pgdat-take2-remove-pgdat_list.patch
-uninline-zone-helpers.patch
-uninline-zone-helpers-fix.patch
-ia64-add-ptr-to-compatpatch.patch
-s390-add-ptr-compatpatch.patch
-parisc-add-ptr-compatpatch.patch
-mips-add-ptr-compatpatch.patch
-lightweight-robust-futexes-arch-defaults.patch
-lightweight-robust-futexes-arch-defaults-fix.patch
-lightweight-robust-futexes-core.patch
-lightweight-robust-futexes-docs.patch
-lightweight-robust-futexes-docs-update.patch
-lightweight-robust-futexes-compat.patch
-lightweight-robust-futexes-i386.patch
-lightweight-robust-futexes-i386-fix.patch
-lightweight-robust-futexes-x86_64.patch
-lightweight-robust-futexes-x86_64-fix.patch
-notifier-chain-update-api-changes.patch
-notifier-chain-update-api-changes-register-atomic_notifiers-in-atomic-context.patch
-notifier-chain-update-api-changes-export-new-notifier-chain-routines-as-gpl.patch
-notifier-chain-update-api-changes-avoid-calling-down_read-and-down_write-during-startup.patch
-notifier-chain-update-simple-definition-changes.patch
-notifier-chain-update-remove-unneeded-protection.patch
-notifier-chain-update-remove-unneeded-protection-the-idle-notifier-chain-should-be-atomic.patch
-notifier-chain-update-die_chain-changes.patch
-notifier-chain-update-dont-unregister-yourself.patch
-notifier-chain-update-dont-unregister-yourself-fix.patch
-notifier-chain-update-changes-to-dcdbasc.patch
-notifier-chain-update-update-usb_notify.patch
-notifier-chain-update-remaining-changes-for-new-api.patch
-notifier-chain-initialization.patch
-mips-fixed-collision-of-rtc-function-name.patch
-rtc-subsystem-library-functions.patch
-rtc-subsystem-library-functions-fix.patch
-rtc-subsystem-arm-cleanup.patch
-rtc-subsystem-arm-integrator-cleanup.patch
-rtc-subsystem-class.patch
-rtc-subsystem-i2c-cleanup.patch
-rtc-subsystem-i2c-driver-ids.patch
-rtc-subsystem-sysfs-interface.patch
-rtc-subsystem-proc-interface.patch
-rtc-subsystem-dev-interface.patch
-rtc-subsystem-x1205-driver.patch
-rtc-subsystem-test-device-driver.patch
-rtc-subsystem-ds1672-driver.patch
-rtc-subsystem-pcf8563-driver.patch
-rtc-subsystem-rs5c372-driver.patch
-rtc-subsystem-ep93xx-driver.patch
-rtc-subsystem-sa1100-pxa2xx-driver.patch
-rtc-subsystem-m48t86-driver.patch
-pnp-parport-adjust-pnp_register_driver-signature.patch
-pnp-mpu401-adjust-pnp_register_driver-signature.patch
-pnp-cs4236-adjust-pnp_register_driver-signature.patch
-pnp-opl3sa2-adjust-pnp_register_driver-signature.patch
-pnp-irda-adjust-pnp_register_driver-signature.patch
-pnp-cs4232-adjust-pnp_register_driver-signature.patch
-pnp-pnp-adjust-pnp_register_driver-signature.patch
-vgacon-fix-ega-cursor-resize-function.patch
-vgacon-add-support-for-soft-scrollback.patch
-nvidiafb-add-suspend-and-resume-hooks.patch
-fbdev-framebuffer-driver-for-geode-gx.patch
-fbdev-framebuffer-driver-for-geode-gx-update.patch
-fbdev-framebuffer-driver-for-geode-gx-warning-fix.patch
-fbdev-framebuffer-driver-for-geode-gx-kconfig-fix-2.patch
-matroxfb-simply-return-what-i2c_add_driver-does.patch
-matrox-maven-memory-allocation-and-other-cleanups.patch
-au1200fb-alchemy-au1200-framebuffer-driver.patch
-fbdev-make-bios-edid-reading-configurable.patch
-framebuffer-cmap-setting-return-values.patch
-rivafb-remove-null-check.patch
-nvidiafb-remove-null-check.patch
-nvidiafb-remove-null-check-2.patch
-i810fb-remove-null-check.patch
-savagefb-remove-null-check.patch
-atyfb-remove-dead-code.patch
-imsttfb-remove-dead-code.patch
-nvidiafb-add-id-for-quadro-nvs280.patch
-newportcon-sparse-fix-warnings-in-newport-driver-about.patch
-fbdev-add-modeline-for-1680x1050-60.patch
-drivers-video-use-array_size-macro.patch
-device-mapper-snapshot-fix-origin_write-pending_exception-submission.patch
-device-mapper-snapshot-replace-sibling-list.patch
-device-mapper-snapshot-replace-sibling-list-fix.patch
-device-mapper-snapshot-fix-invalidation.patch
-drivers-md-dm-raid1c-fix-inconsistent-mirroring-after-interrupted.patch
-dm-remove-sector_format.patch
-dm-make-sure-queue_flag_cluster-is-set-properly.patch
-dm-snapshot-fix-kcopyd-destructor.patch
-dm-flush-queue-eintr.patch
-dm-store-md-name.patch
-dm-tidy-mdptr.patch
-dm-table-store-md.patch
-dm-store-geometry.patch
-dm-md-dependency-tree-in-sysfs-holders-slaves-subdirectory.patch
-dm-md-dependency-tree-in-sysfs-bd_claim_by_kobject.patch
-dm-md-dependency-tree-in-sysfs-md-to-use-bd_claim_by_disk.patch
-dm-md-dependency-tree-in-sysfs-dm-to-use-bd_claim_by_disk.patch
-dm-md-dependency-tree-in-sysfs-convert-bd_sem-to-bd_mutex.patch
-dm-remove-unnecessary-typecast.patch
-md-make-sure-queue_flag_cluster-is-set-properly-for-md.patch
-md-add-4-to-the-list-of-levels-for-which-bitmaps-are-supported.patch
-md-fix-the-failed-count-for-version-0-superblocks.patch
-md-update-status_resync-to-handle-large-devices.patch
-md-split-disks-array-out-of-raid5-conf-structure-so-it-is-easier-to-grow.patch
-md-allow-stripes-to-be-expanded-in-preparation-for-expanding-an-array.patch
-md-allow-stripes-to-be-expanded-in-preparation-for-expanding-an-array-init_list_head-to-list_head-conversions.patch
-md-allow-stripes-to-be-expanded-in-preparation-for-expanding-an-array-init_list_head-to-list_head-conversions-documentation-and-tidy-up-for-resize_stripes.patch
-md-infrastructure-to-allow-normal-io-to-continue-while-array-is-expanding.patch
-md-core-of-raid5-resize-process.patch
-md-core-of-raid5-resize-process-make-new-function-stripe_to_pdidx-static.patch
-md-final-stages-of-raid5-expand-code.patch
-md-final-stages-of-raid5-expand-code-fix.patch
-md-checkpoint-and-allow-restart-of-raid5-reshape.patch
-md-checkpoint-and-allow-restart-of-raid5-reshape-remove-an-unused-variable.patch
-md-only-checkpoint-expansion-progress-occasionally.patch
-md-split-reshape-handler-in-check_reshape-and-start_reshape.patch
-md-make-reshape-a-possible-sync_action-action.patch
-md-support-suspending-of-io-to-regions-of-an-md-array.patch
-md-improve-comments-about-locking-situation-in-raid5-make_request.patch
-md-remove-some-stray-semi-colons-after-functions-called-in-macro.patch
-sem2mutex-drivers-md.patch

 Merged.

+acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces-fix.patch
+remove-entries-in-sys-firmware-acpi-for-processor-also.patch
+remove-unnecessary-lapic-definition-from-acpidefh.patch
+catch-notification-of-memory-add-event-of-acpi-via-container-driver-register-start-func-for-memory-device.patch
+catch-notification-of-memory-add-event-of-acpi-via-container-driver-register-start-func-for-memory-device-tidy.patch
+catch-notification-of-memory-add-event-of-acpi-via-container-driveravoid-redundant-call-add_memory.patch
+catch-notification-of-memory-add-event-of-acpi-via-container-driveravoid-redundant-call-add_memory-tidy.patch

 ACPI updates (including ACPI interfaces for memory hot-add support)

+block-i-o-schedulers-document-runtime-selection.patch

 Block layer documentation.

+kernel-crash-in-powernow-k8-after-lost-ticks-detected.patch

 cpufreq fix.

+gregkh-driver-sysfs-allow-sysfs-attribute-files-to-be-pollable.patch

 Driver tree update.

-revert-gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch

 Dropped.

+driver-core-driver_bind-attribute-returns-incorrect-value.patch
+bus_add_device-losing-an-error-return-from-the-probe-method.patch

 Driver core fixes.

+remove-drm_allocfree_pages.patch

 DRM cleanup.

+ia64-sn_hwperf-eliminate-use-of-num_online_cpus.patch

 ia64 cleanup/speedup.

+input-adds-snes-mouse-support-to-gamecon.patch
+inputh-should-always-include-asm-typesh.patch

 Input updates.

+fix-sed-regexp-to-generate-asm-offseth.patch

 Kbuild fix.

+kill-ifdefs-in-mtdcorec-fix.patch

 Fix kill-ifdefs-in-mtdcorec.patch.

+mtd-redboot-handle-holes-in-fis-table.patch
+mtd-fix-broken-name_to_dev_t-declaration.patch
+drivers_mtd_maps_vmax301c-fix-off-by-one-vmax_mtd.patch

 MTD fixes.

+b44-fix-force-mac-address-before-ifconfig-up.patch
+net-remove-config_net_cbus-conditional-for-ns8390.patch
+pci-error-recovery-e1000-network-device-driver.patch
+pci-error-recovery-e1000-network-device-driver-tidy.patch

 Netdev updates.

+netfilter-rename-init-functions.patch

 Rename zillions of netfilter module_init and module_exit functions.

+fix-nfs-proc_fs=n-compile-error.patch

 NFS fix.

+net-fix-appletalk-compat_ioctl-oopses.patch

 Net fix.

+deinline-200-byte-inlines-in-sockh.patch
+deinline-some-larger-functions-from-netdeviceh.patch

 Net uninlinings.

+git-powerpc-warn-was-a-dumb-idea.patch

 powerpc build fix.

+64-bit-resources-core-changes.patch
+64-bit-resources-drivers-pci-changes.patch
+64-bit-resources-drivers-ide-changes.patch
+64-bit-resources-drivers-ide-changes-fix.patch
+64-bit-resources-drivers-media-changes.patch
+64-bit-resources-drivers-net-changes.patch
+64-bit-resources-drivers-pcmcia-changes.patch
+64-bit-resources-drivers-others-changes.patch
+64-bit-resources-sound-changes.patch
+64-bit-resources-arch-changes.patch

 Support 64-bio IO and IOMEM resources.

+pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch
+pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code-fix.patch
+pci-legacy-i-o-port-free-driver-update-documentation-pcitxt.patch
+pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free.patch
+pci-legacy-i-o-port-free-driver-make-emulex-lpfc-driver-legacy-i-o-port-free.patch

 PCI updates.

+x86_64-mm-defconfig-update.patch
+x86_64-mm-rename-e820-mapped.patch
+x86_64-mm-e820-all-mapped.patch
+x86_64-mm-mcfg-e820.patch
+x86_64-mm-pci-bus-ifdef.patch
+x86_64-mm-horus-bus-0.patch
+x86_64-mm-acpi-nolapic.patch
+x86_64-mm-clear-lapic.patch
+x86_64-mm-i386-modern-apic.patch
+x86_64-mm-revert-powernow-fix.patch
+x86_64-mm-powernow-fix-3.patch
+x86_64-mm-extra-nodes_shift-definition.patch

 x86_64 updates.

+x86_64-mm-hotadd-reserve-fix.patch

 Fix it.

-x86_64-mm-hotadd-reserve-vs-arm.patch

 Unneeded.

+x86-64-check-for-valid-dma-data-direction-in-the-dma-api.patch

 x86_64 debugging.

+git-xfs-vn_to_inode-fix.patch

 Fix XFS.

+mm-schedule-find_trylock_page-removal.patch
+mm-vm_bug_on.patch
+mm-thrash-detect-process-thrashing-against-itself.patch

 MM updates.

+remove-long-dead-i386-floppy-asm-code.patch
+i386-kdump-timer-vector-lockup-fix.patch

 x86 updates.

-support-physical-cpu-hotplug-for-x86_64-fix-2.patch

 Folded into support-physical-cpu-hotplug-for-x86_64.patch

-enable-sci_emulate-to-manually-simulate-physical-hotplug-testing-fix.patch

 Folded into enable-sci_emulate-to-manually-simulate-physical-hotplug-testing.patch

+x86_64-use-select-for-gart_iommu-to-enable-agp.patch

 x86_64 Kconfig fix

+uml-hotplug-memory-take-2.patch

 UML feature.

-oops-reporting-tool.patch

 Dropped.

-add-gfp-flag-__gfp_policy-to-control-policies-and-cpusets-redirection.patch

 Dropped.

+ia64-wire-up-compat_sys_adjtimex.patch
+remove-steal_locks.patch
+locks-dont-panic.patch
+document-linuxs-memory-barriers.patch
+synclink-remove-dead-code.patch
+synclink_gt-add-gpio-feature.patch
+synclink_gt-remove-uneeded-async-code.patch
+let-blk_dev_ram_count-depend-on-blk_dev_ram.patch
+kill-__init_timer_base-in-favor-of-boot_tvec_bases.patch
+__mod_timer-simplify-base-changing.patch
+paride-register_chrdev-fix.patch
+paride-pt-register_chrdev-fix.patch
+capi-register_chrdev-fix.patch
+symversion-warning-fix.patch
+simplify-proc-devices-and-fix-early-termination-regression.patch
+simplify-proc-devices-and-fix-early-termination-regression-tidy.patch
+simplify-proc-devices-and-fix-early-termination-regression-tidy-2.patch
+simplify-proc-devices-and-fix-early-termination-regression-tidy-3.patch
+dont-pass-boot-parameters-to-argv_init.patch
+add-oprofile_add_ext_sample.patch
+alpha-make-poll-flags-thesame-as-other-architectures.patch
+mqueue-comment-fix-fix.patch
+change-dash2underscore-return-value-to-char.patch
+drivers-block-paride-pdc-fix-an-off-by-one-error.patch
+fs-fat-proper-prototypes-for-two-functions.patch
+philip-gladstone-has-moved.patch
+edac_752x-needs-config_hotplug.patch
+make-tty_insert_flip_char-a-non-gpl-export.patch
+ipmi-fix-startup-race-condition.patch
+ipmi-fix-startup-race-condition-tidy.patch
+ipmi-tidy-up-various-things.patch
+ipmi-convert-from-semaphores-to-mutexes.patch
+mutex-some-cleanups.patch
+remove-relayfs_fsh.patch
+drivers-block-acsi_slmc-size_t-cant-be-0.patch
+autofs4-proper-prototype-for-autofs4_dentry_release.patch

 Misc patches.

-copy_process-cleanup-bad_fork_cleanup_signal-update.patch

 Folded into copy_process-cleanup-bad_fork_cleanup_signal.patch.

+cleanup-__exit_signal-cleanup_sighand-path.patch
+simplify-do_signal_stop.patch
+finish_stop-dont-check-stop_count-0.patch
+do_notify_parent_cldstop-remove-to_self-param.patch
+send_sigqueue-simplify-and-fix-the-race.patch

 More Oleg romping.

-ext3-add-o-bh-option-fix.patch
-ext3-nobh-writeback-support-for-filesystems-blocksize.patch

 Folded into ext3-add-o-bh-option.patch

-mutex-subsystem-add-include-asm-arm-mutexh-fix.patch

 This got renamed.

+hrtimer-create-generic-sleeper.patch
+hrtimer-use-generic-sleeper-for-nanosleep.patch

 hrtimer updates

+time-clocksource-infrastructure-dont-enable-irq-too-early.patch

 Folded into time-clocksource-infrastructure.patch

+time-use-clocksource-infrastructure-for-update_wall_time-mark-few-functions-as-__init.patch

 Folded into time-use-clocksource-infrastructure-for-update_wall_time.patch

+time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy.patch
+time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy-acpi_pm-cleanup.patch
+time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy-acpi_pm-cleanup-fix-missing-to-rename-pmtmr_good-to-acpi_pm_good.patch

 Fix time management patches in -mm.

-sched-smpnice-apply-review-suggestions.patch
-sched-smpnice-fix-average-load-per-run-queue-calculations.patch

 Folded into sched-implement-smpnice.patch

+sched-protect-calculation-of-max_pull-from-integer-wrap.patch

 sched update

-sched2-sched-domain-sysctl-tidy.patch

 Folded into sched2-sched-domain-sysctl.patch

-add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch

 Dropped.

-mm-implement-swap-prefetching-fix.patch
-mm-implement-swap-prefetching-tweaks.patch

 Folded into mm-implement-swap-prefetching.patch

-provide-a-filesystem-specific-syncable-page-bit.patch

 Dropped.

+futex-check-and-validate-timevals.patch

 timeval checking.

-unify-pfn_to_page-x86_64-pfn_to_page.patch

 Dropped.

+pi-futex-futex-code-cleanups.patch
+pi-futex-introduce-debug_check_no_locks_freed.patch
+pi-futex-add-plist-implementation.patch
+pi-futex-scheduler-support-for-pi.patch
+pi-futex-rt-mutex-core.patch
+pi-futex-rt-mutex-docs.patch
+pi-futex-rt-mutex-debug.patch
+pi-futex-rt-mutex-tester.patch
+pi-futex-rt-mutex-futex-api.patch
+pi-futex-futex_lock_pi-futex_unlock_pi-support.patch
+pi-futex-v2.patch
+pi-futex-v3.patch

 Priority-inheriting futex support.

+rtc-m41t00-driver-should-use-workqueue-instead-of-tasklet.patch
+rtc-m41t00-driver-cleanup.patch
+rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch

 RTC drivers.

-proc-refactor-reading-directories-of-tasks-dont-assume-pid_aliveinit_task-==-false.patch

 Folded into proc-refactor-reading-directories-of-tasks.patch.

-proc-remove-tasklist_lock-from-proc_pid_readdir-simply-fix-first_tgid-fix.patch

 Folded into proc-remove-tasklist_lock-from-proc_pid_readdir-simply-fix-first_tgid.patch.

-pidhash-refactor-the-pid-hash-table-fixes.patch

 Folded into pidhash-refactor-the-pid-hash-table.patch.

-proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
-proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
-proc-dont-lock-task_structs-indefinitely-mem_read-fix.patch
-proc-dont-lock-task_structs-indefinitely-task_mmu-bug-fix.patch
-proc-dont-lock-task_structs-indefinitely-kill-init_tref.patch
-proc-dont-lock-task_structs-indefinitely-kill-init_tref-inode.patch
-proc-dont-lock-task_structs-indefinitely-tref-ensure-the-references-is-always-on-the-first-task.patch
-proc-dont-lock-task_structs-indefinitely-always-drop-the-reference-count-in-tid_fd_revalidate.patch
-proc-dont-lock-task_structs-indefinitely-fix-the-locking-when-reading-the-number-of-threads-in.patch
-proc-dont-lock-task_structs-indefinitely-fix-the-locking-when-reading-the-number-of-threads-in-nitpick.patch
-proc-dont-lock-task_structs-indefinitely-fix-stat-on-proc-pid.patch

 Folded intoproc-dont-lock-task_structs-indefinitely.patch.

-proc-use-sane-permission-checks-on-the-proc-pid-fd-fix.patch
-proc-use-sane-permission-checks-on-the-proc-pid-fd-fix-2.patch

 Folded into proc-use-sane-permission-checks-on-the-proc-pid-fd.patch.

-simplify-fix-first_tid-fix.patch

 Folded into simplify-fix-first_tid.patch.

+fbcon-save-current-display-during-initialization.patch
+w100fb-add-acceleration-support-to-ati-imageon.patch
+backlight-backlight-class-improvements.patch
+backlight-hp-jornada-680-backlight-driver-updates-fixes.patch
+backlight-corgi_bl-generalise-to-support-other-sharp.patch
+pxafb-minor-driver-fixes.patch
+fbcon-fix-big-endian-bogosity-in-slow_imageblit.patch

 fbdev updates.

-for_each_possible_cpu-defines-for_each_possible_cpu-fix.patch

 Folded into for_each_possible_cpu-defines-for_each_possible_cpu.patch.

-for_each_possible_cpu-i386-fix.patch
-for_each_possible_cpu-i386-fix-2.patch

 Folded into for_each_possible_cpu-i386.patch.

-kgdb-ga-remove-stuff.patch
-kgdb-remove-NO_CPUS.patch
-kgdb-remove-KGDB_TS.patch
-kgdb-remove-STACK_OVERFLOW_TEST.patch
-kgdb-remove-TRAP_BAD_SYSCALL_EXITS.patch
-kgdb-always-KGDB_CONSOLE.patch
-kgdb-remove-CONFIG_KGDB_USER_CONSOLE.patch
-kgdb-serial-cleanup.patch
-kgdb-serial-cleanup-2.patch
-kgdb-serial-cleanup-3.patch
-kgdb-nmi-cleanup.patch
-kgdb-cleanup-version.patch
-kgdb-cleanup-includes.patch
-kgdb-remove-KGDB_SYSRQ.patch
-kgdb-rename-breakpoint.patch
-kgdb-convert-for-cpu-helpers.patch
-kgdb-select-debug_info.patch

 Folded into kgdb-ga.patch.

-nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus-fixes.patch

 Folded into nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch.

-slab-cache-shrinker-statistics-make-the-dummy-kmem_set_shrinker-a-static-inline.patch

 Folded into slab-cache-shrinker-statistics.patch.



All 591 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm2/patch-list


