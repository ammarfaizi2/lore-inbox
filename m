Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVIHMbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVIHMbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVIHMbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:31:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39905 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751319AbVIHMbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:31:10 -0400
Date: Thu, 8 Sep 2005 05:30:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-mm2
Message-Id: <20050908053042.6e05882f.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/

(kernel.org propagation is slow.  There's a temp copy at
http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)



- Added Andi's x86_64 tree, as separate patches

- Added a driver for TI acx1xx cardbus wireless NICs

- Large revamp of pcmcia suspend handling

- Largeish v4l and DVB updates

- Significant parport rework

- Many tty drivers still won't compile

- Lots of framebuffer driver updates

- There are still many patches here for 2.6.14.  We're doing pretty well
  with merging up the subsystem trees.  ia64 and CIFS are still pending. 
  x86_64 and several of Greg's trees (especially USB) aren't merged yet.




Changes since 2.6.13-mm1:


 linus.patch
 git-acpi.patch
 git-cifs.patch
 git-cpufreq.patch
 git-ia64.patch
 git-audit.patch
 git-input.patch
 git-jfs.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-nfs-oops-fix.patch
 git-ocfs2.patch
 git-scsi-iscsi.patch

 Subsystem trees

-non-booting-g5-fix.patch -dvb-saa7134-dvb-must-select-tda1004x.patch
-tpm_infineon-bugfix-in-pnpacpi-handling.patch
-move-truncate_inode_pages-into-delete_inode.patch
-update-filesystems-for-new-delete_inode-behavior.patch
-fix-possible-null-pointer-access-acpi_pci_irq_disable.patch
-gregkh-driver-driver-bind-fix.patch
-gregkh-driver-driver-link-device-and-class.patch
-gregkh-driver-floppy-cmos-attribute.patch
-gregkh-driver-floppy-cmos-attribute-tidy.patch
-gregkh-driver-driver-docs-whitespace.patch
-gregkh-driver-driver-docs-permissions.patch
-gregkh-driver-driver-handle-sysdev-suspend-failure.patch
-gregkh-driver-driver-kfree-check-cleanup.patch
-gregkh-driver-klist-fix-semantics.patch
-gregkh-i2c-i2c-max6875-simplify.patch
-gregkh-i2c-i2c-max6875-documentation-update.patch
-gregkh-i2c-i2c-max6875-fix-build-error.patch
-gregkh-i2c-i2c-nforce2-cleanup.patch
-gregkh-i2c-i2c-max6875-kobj_to_i2c_client.patch
-gregkh-i2c-i2c-max6875-documentation-cleanup.patch
-gregkh-i2c-i2c-max6875-cleanup.patch
-gregkh-i2c-i2c-hwmon-soften-lm75.patch
-gregkh-i2c-i2c-hwmon-lm78-j.patch
-gregkh-i2c-i2c-hwmon-document-w83627ehg.patch
-gregkh-i2c-i2c-hwmon-class-02.patch
-gregkh-i2c-i2c-hwmon-class-03.patch
-gregkh-i2c-i2c-hwmon-split-01.patch
-gregkh-i2c-i2c-hwmon-split-02.patch
-gregkh-i2c-i2c-hwmon-split-03.patch
-gregkh-i2c-i2c-hwmon-split-04.patch
-gregkh-i2c-i2c-hwmon-split-05.patch
-gregkh-i2c-i2c-hwmon-split-06.patch
-gregkh-i2c-i2c-hwmon-split-07.patch
-gregkh-i2c-i2c-hwmon-split-08.patch
-gregkh-i2c-i2c-hwmon-split-09.patch
-gregkh-i2c-i2c-w83792d-01.patch
-gregkh-i2c-i2c-w83792d-02.patch
-gregkh-i2c-i2c-w83792d-03.patch
-gregkh-i2c-i2c-refactor-message.patch
-gregkh-i2c-i2c-hwmon-tag-superio-functions-__init.patch
-gregkh-i2c-i2c-inline-i2c_adapter_id.patch
-gregkh-i2c-i2c-i2c-algo-pca-busy-bus-fix.patch
-gregkh-i2c-i2c-documentation-typo.patch
-gregkh-i2c-i2c-core-debug-cleanup.patch
-gregkh-i2c-hwmon-move-SENSORS_LIMIT.patch
-gregkh-i2c-hwmon-lm85-cleanups.patch
-gregkh-i2c-hwmon-split-round2-01.patch
-gregkh-i2c-hwmon-split-round2-02.patch
-gregkh-i2c-hwmon-split-round2-03.patch
-gregkh-i2c-hwmon-split-round2-04.patch
-gregkh-i2c-hwmon-split-round2-05.patch
-gregkh-i2c-hwmon-split-round2-06.patch
-gregkh-i2c-hwmon-split-round2-07.patch
-gregkh-i2c-hwmon-split-round2-08.patch
-gregkh-i2c-hwmon-split-round2-09.patch
-gregkh-i2c-hwmon-split-round2-10.patch
-gregkh-i2c-hwmon-split-round2-11.patch
-gregkh-i2c-hwmon-vid-table-update.patch
-gregkh-i2c-i2c-rewrite-i2c_probe.patch
-gregkh-i2c-i2c-centralize-24rf08-corruption-prevention.patch
-gregkh-i2c-i2c-kill-i2c_algorithm-stuff-01.patch
-gregkh-i2c-i2c-kill-i2c_algorithm-stuff-02.patch
-gregkh-i2c-i2c-kill-i2c_algorithm-stuff-03.patch
-gregkh-i2c-i2c-kill-i2c_algorithm-stuff-04.patch
-gregkh-i2c-i2c-kill-i2c_algorithm-stuff-05.patch
-gregkh-i2c-i2c-kill-i2c_algorithm-stuff-06.patch
-gregkh-i2c-i2c-kill-i2c_algorithm-stuff-07.patch
-gregkh-i2c-i2c-outdated-i2c_adapter-comment.patch
-gregkh-i2c-hwmon-maintainer.patch
-gregkh-i2c-i2c-drop-i2c_clientname.patch
-gregkh-i2c-w1-netlink-callbacks.patch
-ia64-cpuset-build_sched_domains-mangles-structures.patch
-git-audit-ppc64-fix.patch
-input-usb-ignore-logitech-vendor-usages.diff.patch
-input-usb-hid-simulation-usages.diff.patch
-input-i8042-fix-irq-printk.diff.patch
-input-hid-more-consumer-usages.diff.patch
-input-atkbd-allow-0x7f-scancode.diff.patch
-input-hid-variable-max-buffer-size.diff.patch
-input-hid-logitech-ultra-x-media-remote.diff.patch
-input-i8042-mux-blacklist-fsc-t3010.diff.patch
-input-iforce-wait-event.diff.patch
-hid-core-wireless-security-lock-blacklist-entry.patch
-hiddev-output-reports-are-dropped-when-hidiocsreport-is.patch
-apple-powerbook-usb-keyboard-hid-fix.patch
-kbuild-fix-make-clean-damaging-hg-repos.patch
-git-net-gregkh-i2c-w1-netlink-callbacks-fix.patch
-fix-minor-bug-in-sungemh.patch
-netlink-log-protocol-failures.patch
-mbio_bus-pm_message_t-fix.patch
-fix-klist-semantics-for-lists-which-have-elements-removed.patch
-git-scsi-misc-sr-fix.patch
-mpt-fusion-dv-fixes.patch
-watchdog-new-sbc8360-driver.patch
-sparsemem-extreme.patch
-ppc64-fix-sparsemem-extreme.patch
-sparsemem-extreme-implementation.patch
-sparsemem-extreme-hotplug-preparation.patch
-sparsemem-extreme-hotplug-preparation-fix.patch
-mm-consolidate-get_order.patch
-swap-update-swapfile-i_sem-comment.patch
-swap-correct-swapfile-nr_good_pages.patch
-swap-move-destroy_swap_extents-calls.patch
-swap-swap-extent-list-is-ordered.patch
-swap-show-span-of-swap-extents.patch
-swap-swap-unsigned-int-consistency.patch
-swap-swap-unsigned-int-consistency-warning-fix.patch
-swap-freeing-update-swap_listnext.patch
-swap-get_swap_page-drop-swap_list_lock.patch
-swap-scan_swap_map-restyled.patch
-swap-scan_swap_map-drop-swap_device_lock.patch
-swap-scan_swap_map-latency-breaks.patch
-swap-swap_lock-replace-listdevice.patch
-swap-update-swsusp-use-of-swap_info.patch
-swap-update-swsusp-use-of-swap_info-fix.patch
-delete-from_swap_cache-bug_ons.patch
-rmap-dont-test-rss.patch
-proc-pid-numa_maps-to-show-on-which-nodes-pages-reside.patch
-mm-comment-rmap.patch
-mm-micro-optimise-rmap.patch
-mm-cleanup-rmap.patch
-mm-remap-zero_page-mappings.patch
-mm-remove-atomic.patch
-vm-add-capabilites-check-to-set_zone_reclaim.patch
-vm-zone-reclaim-atomic-ops-cleanup.patch
-mm-fix-madvise-vma-merging.patch
-comment-typo-fix.patch
-vm-slabc-spelling-correction.patch
-shmem_populate-avoid-an-useless-check-and-some-comments.patch
-remove-implied-vm_ops-check.patch
-correct-_page_file-comment.patch
-arm-allow-for-arch-specific-ioremap_max_order.patch
-hugetlb-add-pte_huge-macro.patch
-hugetlb-move-stale-pte-check-into-huge_pte_alloc.patch
-hugetlb-check-pd_present-in-huge_pte_offset.patch
-remove-hugetlb_clean_stale_pgtable-and-fix-huge_pte_alloc.patch
-slab-consolidate-kmem_bufctl_t.patch
-x86-ptep-clear-optimization.patch
-x86-ptep-clear-optimization-fix.patch
-x86_64-ptep-clear-optimization.patch
-mm-slabc-prefetchw-the-start-of-new-allocated-objects.patch
-slab-removes-local_irq_save-local_irq_restore-pair.patch
-proc-pid-smaps.patch
-smaps-say-vma-not-map.patch
-smaps-use-new-ptwalks.patch
-smaps-say-kb-not-kb.patch
-smaps-print-more-fields.patch
-smaps-reading-fix.patch
-vm-add-page_state-info-to-per-node-meminfo.patch
-drivers-net-ne3210c-cleanups.patch
-net-add-driver-for-the-nic-on-cell-blades.patch
-ipw2200-build-fix.patch
-net-update-the-spider_net-driver.patch
-mdio_bus_exit-in-discarded-section-textexit.patch
-kconfig-kxgettext-message-fix.patch
-kconfig-kxgettext-eol-fix.patch
-kconfig-linuxpot-for-all-arch.patch
-selinux-reduce-memory-use-by-avtab.patch
-selinux-endian-notations.patch
-generic-vfs-fallback-for-security-xattrs.patch
-arch-ppc-kernel-ppc_ksymsc-remove-unused-define-export_symtab_strops.patch
-ppc32-remove-board-support-for-adir.patch
-ppc32-remove-board-support-for-ash.patch
-ppc32-remove-board-support-for-beech.patch
-ppc32-remove-defconfig-for-cedar.patch
-ppc32-remove-board-support-for-k2.patch
-ppc32-remove-board-support-for-mcpn765.patch
-ppc32-remove-board-support-for-menf1.patch
-ppc32-remove-board-support-for-oak.patch
-ppc32-remove-board-support-for-rainier.patch
-ppc32-remove-board-support-for-redwood.patch
-ppc32-remove-board-support-for-sm850.patch
-ppc32-remove-board-support-for-spd823ts.patch
-ppc32-remove-board-support-for-pcore.patch
-pcp32-fix-asm-ppc-dma-mappingh-sparse-warning.patch
-ppc32-add-usb-support-to-ibm-stb04xxx-platforms.patch
-ppc32-added-support-for-the-book-e-style-watchdog-timer.patch
-ppc32-add-ppc_sys-descriptions-for-powerquicc-ii-devices.patch
-ppc32-add-phy-excluded-features-to-ocp_func_emac_data.patch
-cpm_uart-fix-2nd-serial-port-on-mpc8560-ads.patch
-cpm_uart-use-schedule_timeout-instead-of-direct-call-to.patch
-cpm_uart-fix-baseaddress-for-smc-1-and-2.patch
-ppc32-cleaned-up-global-namespace-of-book-e-watchdog.patch
-ppc32-add-440gx-revf-cputable-entry.patch
-ppc32-removed-find_namec.patch
-ppc32-add-cputable-entry-for-440sp-rev-a.patch
-ppc32-dont-sleep-in-flush_dcache_icache_page.patch
-ppc32-fix-emac-tx-channel-assignments-for-npe405h.patch
-ppc32-fix-bamboo-and-luan-build-warnings.patch
-ppc32-disable-ibm405_err77-and-ibm405_err51-workarounds-for-405ep.patch
-ppc32-ppc_sys-system-on-chip-identification-additions.patch
-ppc32-add-config_hz.patch
-ppc32-add-support-for-marvell-ev64360bp-board.patch
-ppc32-defconfig-for-marvell-ev64360bp-board.patch
-ppc32-fix-wundef-warning-for-config_8xx.patch
-ppc32-added-pci-support-mpc83xx.patch
-ppc32-re-order-cputable-for-750cxe-dd24-entry.patch
-ppc32-add-cputable-entry-for-750cxe-dd24-gekko.patch
-ppc32-move-4xx-phy_mode_xxx-defines-to-ibm_ocph.patch
-ppc32-add-dcr_base-field-to-ocp_func_mal_data.patch
-ppc32-l2-cache-prefetch-fixes-on-745x.patch
-ppc32-export-cacheable_memcpy.patch
-ppc64-update-xmon-helptext.patch
-ppc64-add-vmx-save-flag-to-vpa.patch
-ppc64-replace-schedule_timeout-with-msleep_interruptible.patch
-frv-remove-export-of-strtok.patch
-mips-remove-obsolete-giu-function-call-for-vr41xx.patch
-mips-update-irq-handling-for-vr41xx.patch
-mips-change-system-type-name-in-proc-for-vr41xx.patch
-mips-remove-vr4181-support.patch
-mips-remove-vr4181-support-fix.patch
-more-vr4181-removal.patch
-mips-remove-hp-laserjet-remains.patch
-dec-pmag-aa-framebuffer-update.patch
-dec-pmag-ba-frame-buffer-update.patch
-dec-pmagb-b-framebuffer-update.patch
-mips-add-support-for-qemu-system-architecture.patch
-mips-technologies-pci-id-bits.patch
-mips-add-tanbac-vr4131-multichip-module.patch
-mips-add-default-select-configs-for-vr41xx.patch
-mips-add-default-select-configs-for-vr41xx-fix.patch
-mips-remove-vrc4171-config.patch
-mips-changed-from-vr41xx-to-vr4100-series-in-kconfig.patch
-mips-cleanup-32-64-bit-configuration.patch
-mips-nuke-trailing-whitespace.patch
-mips-fix-coherency-configuration.patch
-mips-add-pcibios_select_root.patch
-mips-add-pcibios_bus_to_resource.patch
-mips-add-more-sys_support__kernel-and.patch
-mips-fix-build-warnings.patch
-mips-remove-timexh-for-vr41xx.patch
-mips-kludge-envdev-to-build-for-64-bit-mips-with-32-bit-compat.patch
-arch-sh64-kconfig-doesnt-need-its-own-log_buf_shift.patch
-x86-compress-the-stack-layout-of-do_page_fault.patch
-x86-compress-the-stack-layout-of-do_page_fault-fix.patch
-hpet-use-read_timer_tsc-only-when-cpu-has-tsc.patch
-x86-fix-efi-memory-map-parsing.patch
-vm86-honor-tf-bit-when-emulating-an-instruction.patch
-kdump-save-parameter-segment-in-protected-mode-x86.patch
-x86-automatically-enable-bigsmp-when-we-have-more-than-8-cpus-2.patch
-x86-automatically-enable-bigsmp-when-we-have-more-than-8-cpus-2-tidy.patch
-x86-add-the-check-for-all-the-cores-in-a-package-in-cache-information.patch
-via-vt8237-apic-bypass-deassertion-quirk.patch
-es7000-platform-update-i386.patch
-i386-clean-up-vdso-alignment-padding.patch
-i386-inline-asm-cleanup.patch
-i386-inline-asm-cleanup-kexec-fix.patch
-i386-arch-cleanup-seralize-msr.patch
-i386-arch-cleanup-seralize-msr-fix.patch
-i386-inline-assembler-cleanup-encapsulate-descriptor-and-task-register-management.patch
-i386-inline-assembler-cleanup-encapsulate-descriptor-and-task-register-management-fix.patch
-i386-generate-better-code-around-descriptor-update-and-access-functions.patch
-i386-load_tls-fix.patch
-i386-use-set_pte-macros-in-a-couple-places-where-they-were-missing.patch
-i386-fix-incorrect-tss-entry-for-ldt.patch
-x86-more-asm-cleanups.patch
-x86-privilege-cleanup.patch
-x86-make-iopl-explicit.patch
-x86-remove-redundant-tss-clearing.patch
-x86-introduce-a-write-acessor-for-updating-the-current-ldt.patch
-x86-nmi-better-support-for-debuggers.patch
-x86-nmi-better-support-for-debuggers-fix.patch
-i386-encapsulate-copying-of-pgd-entries.patch
-i386-boottime-for_each_cpu-broken.patch
-i386-boottime-for_each_cpu-broken-fix.patch
-x86-x86_64-deferred-handling-of-writes-to-proc-irq-xx-smp_affinitypatch-added-to-mm-tree.patch
-x86_64-print-processor-number-in-show_regs.patch
-x86_64-fix-off-by-one-in-e820_mapped.patch
-x86_64-prefetchw-can-fall-back-to-prefetch-if-3dnow.patch
-x86_64-create-sysfs-entries-for-cpu-only-for-present-cpus.patch
-x86_64dont-call-enforce_max_cpus-when-hotplug-is-enabled.patch
-unify-x86-x86-64-semaphore-code.patch
-remove-busywait-in-refrigerator.patch
-isa-dma-suspend-for-i386-2.patch
-isa-dma-suspend-for-x86_64-2.patch
-suspend-update-documentation.patch
-swsusp-fix-remaining-u32-vs-pm_message_t-confusion.patch
-swsusp-fix-remaining-u32-vs-pm_message_t-confusion-2.patch
-swsusp-switch-pm_message_t-to-struct.patch
-swsusp-switch-pm_message_t-to-struct-pmac_zilog-fix.patch
-swsusp-switch-pm_message_t-to-struct-ppc32-fixes.patch
-swsusp-switch-pm_message_t-to-struct-chipsfb-fixes.patch
-swsusp-switch-pm_message_t-to-struct-mesh-fixes-2.patch
-fix-pm_message_t-stuff-in-mm-tree-netdev.patch
-encrypt-suspend-data-for-easy-wiping.patch
-swsusp-prevent-disks-from-spinning-down-and-up.patch
-swsusp-simpler-calculation-of-number-of-pages-in-pbe-list.patch
-swsusup-with-dm-crypt-mini-howto.patch
-swsusp-add-locking-to-software_resume.patch
-swsusp-fix-error-handling-and-cleanups.patch
-reconfigure-msi-registers-after-resume.patch
-pm-fix-process-freezing.patch
-pm-cleanup-sys-power-disk.patch
-3c59x-pm-fixes.patch
-add-suspend-resume-for-timer.patch
-arch-cris-kconfigdebug-use-lib-kconfigdebug.patch
-uml-remove-debugging-code-from-page-fault-path.patch
-uml-rename-kconfig-files-to-be-like-the-other-arches.patch
-ptrace-i386-fix-syscall-audit-interaction-with-singlestep.patch
-uml-support-ptrace-adds-the-host-sysemu-support-for-uml-and-general-usage.patch
-uml-support-reorganize-ptrace_sysemu-support.patch
-uml-support-add-ptrace_sysemu_singlestep-option-to-i386.patch
-sysemu-fix-sysaudit--singlestep-interaction.patch
-uml-support-sysemu-slight-cleanup-and-speedup.patch
-uml-workaround-gdb-problems-on-debugging.patch
-uml-fix-sigwinch-handler-race-while-waiting-for-signals.patch
-uml-fixes-performance-regression-in-activate_mm-and-thus-exec.patch
-uml-fault-handler-micro-cleanups.patch
-uml-fix-signal-frame-copy_user.patch
-uml-fix-a-macro-typo.patch
-uml-error-path-cleanup.patch
-uml-build-cleanup.patch
-uml-remove-libc-reference-in-build.patch
-uml-mark-smp-on-uml-x86_64-as-broken.patch
-uml-remove-duplicated-exports.patch
-uml-uml-i386-is-i386-when-running-on-x86_64.patch
-uml-tlb-operation-batching.patch
-uml-merge-duplicated-page-table-code.patch
-xtensa-replace-extern-inline-with-static-inline.patch
-xtensa-delete-accidental-file.patch
-s390-machine-check-handler-bugs.patch
-s390-debug-feature-changes.patch
-s390-deadlock-in-dasd_devmap.patch
-s390-64-bit-diag250-support.patch
-s390-reipl-fix-and-extern-static-inline.patch
-s390-pfault-interrupt-race.patch
-s390-crypto-driver-update.patch
-s390-compat-system-calls.patch
-s390-spinlock-corner-case.patch
-s390-disconnected-3270-console.patch
-futex_wake_op-pthread_cond_signal-speedup.patch
-detect-soft-lockups.patch
-detect-soft-lockups-export-touch_softlockup_watchdog.patch
-mtd-stop-the-nand-functions-triggering-false-softlockup-reports.patch
-relayfs.patch
-relayfs-relayfs_remove-fix.patch
-relayfs-api-cleanup.patch
-relayfs-add-read-support.patch
-relayfs-add-read-support-fix.patch
-relayfs-upgraded-read-implementation.patch
-relayfs-update-documentation.patch
-relayfs-update-documentation-fix.patch
-yenta-make-topic95-bridges-work-with-16bit-cards.patch
-kallsyms-change-compression-algorithm.patch
-more-__read_mostly-variables.patch
-provide-better-printk-support-for-smp-machines.patch
-provide-better-printk-support-for-smp-machines-tidy.patch
-nmi-update-nmi-users-of-rcu-to-use-new-api.patch
-nmi-update-nmi-users-of-rcu-to-use-new-api-documentation.patch
-inotify-speedup.patch
-use-select-in-sound-isa-kconfig.patch
-use-select-in-sound-isa-kconfig-fix.patch
-compat-be-more-consistent-about-id_t.patch
-fs-jbd-cleanups.patch
-strip-local-symbols-from-kallsyms.patch
-kill-bio-bi_set.patch
-s390-fix-invalid-kmalloc-flags.patch
-fix-invalid-kmalloc-flags-gfp_dma-alone.patch
-remove-register_ioctl32_conversion-and-unregister_ioctl32_conversion.patch
-clean-up-the-old-digi-support-and-rescue-it.patch
-support-powering-sharp-zaurus-sl-5500-lcd-up-and-down.patch
-radix-tree-remove-unnecessary-indirections-and-clean-up.patch
-radix_tag_get-differentiate-between-no-present-node-and-tag-unset-cases.patch
-radix_tag_get-differentiate-between-no-present-node-and-tag-unset-cases-fix.patch
-auxiliary-vector-cleanups.patch
-auxiliary-vector-cleanups-fix.patch
-pnp-consolidate-kmalloc-wrappers.patch
-fix-sound-arm-makefile-for-locality-of-reference.patch
-disk-quotas-fail-when-etc-mtab-is-symlinked-to-proc-mounts.patch
-disk-quotas-fail-when-etc-mtab-is-symlinked-to-proc-mounts-tidy.patch
-add-init=-warning-to-init-mainc.patch
-remove-a-dead-extern-in-memc.patch
-remove-misleading-comment-above-sys_brk.patch
-move-m68k-rtc-drivers-over-to-initcalls.patch
-move-68360serialc-over-use-initcalls.patch
-remove-pipe-definitions.patch
-sonypi-spic-initialisation-fix.patch
-sonypi-remove-obsolete-event.patch
-optimize-writer-path-in-time_interpolator_get_counter.patch
-pnp-make-pnp_dbg-conditional-directly-on-config_pnp_debug.patch
-readahead-reset-cahe_hit-earlier.patch
-meye-use-dma-mapping-constants.patch
-sunrpc-cache_register-can-use-wrong-module-reference.patch
-ipc-add-generic-struct-ipc_ids-seq_file-iteration.patch
-ipc-convert-proc-sysvipc-to-generic-seq_file-interface.patch
-flush-icache-early-when-loading-module.patch
-speedup-fat-filesystem-directory-reads-2.patch
-pnpacpi-fix-irq-and-64-bit-address-decoding.patch
-modified-firmware_classc-to-support-no-hotplug.patch
-dell_rbu-new-dell-bios-update-driver.patch
-dell_rbu-new-dell-bios-update-driver-fix.patch
-dcdbas-add-dell-systems-management-base-driver-with-sysfs-support.patch
-fsnotify-hook-on-removexattr-too.patch
-create_workqueue_thread-signedness-fix.patch
-proc-link-count-fix.patch
-add-rdinit-parameter-to-pick-early-userspace-init.patch
-cleanup-of-deadline_dispatch_requests.patch
-parport-add-netmos-9805-support.patch
-fs-kconfig-quota-help-text-updates.patch
-jffs-jffs2-remove-wrong-function-prototypes.patch
-i386-buildc-write-out-larger-system-size-to-bootsector.patch
-check_irq_per_cpu-to-avoid-dead-code-in-__do_irq.patch
-fix-function-macro-name-collision-on-i386-oprofile.patch
-remove-asm-hdregh.patch
-3c59x-read-current-link-status-from-phy.patch
-delete-unused-do_nanosleep-declaration.patch
-clean-up-missing-overflow-check-in-get_blkdev_list.patch
-console-blanking-locking-fix.patch
-do_notify_parent_cldstop-cleanup.patch
-arm26-one-g-is-enough-for-everyone.patch
-largefile-support-for-accounting.patch
-fs-remove-redundant-timespec_equal-test-in-update_atime.patch
-remove-a-redundant-variable-in-sys_prctl.patch
-remove-filef_maxcount.patch
-remove-the-second-arg-of-do_timer_interrupt.patch
-fix-cramfs-making-duplicate-entries-in-inode-cache.patch
-fix-cramfs-making-duplicate-entries-in-inode-cache-tidy.patch
-fix-send_sigqueue-vs-thread-exit-race.patch
-adapt-scripts-ver_linux-to-new-util-linux-version-strings.patch
-futex-remove-duplicate-code.patch
-additions-to-dataread_mostly-section.patch
-ntp-ntp-helper-functions.patch
-blk-use-blk_queue_xxx-functions-to-set-parameters.patch
-convert-proc-devices-to-use-seq_file-interface-fix.patch
-tty-layer-buffering-revamp.patch
-pipe-remove-redundant-fifo_poll-abstraction.patch
-remove-verify_area-remove-verify_area-from-various-uaccessh-headers.patch
-remove-verify_area-remove-or-edit-references-to-verify_area-in-documentation.patch
-remove-verify_area-remove-fs-umsdos-notes-as-it-only-contain-a-verify_area-related-note.patch
-optimise-64bit-unaligned-access-on-32bit-kernel.patch
-vt-fix-possible-memory-corruption-in-complement_pos.patch
-hpet-fix-drift-and-url.patch
-isdn_v110-warning-fix.patch
-tpm-fix-tpm_atmelc-on-ich6.patch
-create-asm-generic-fcntlh.patch
-consildate-asm-ppc-fcntlh.patch
-clean-up-the-open-flags.patch
-clean-up-the-fcntl-operations.patch
-clean-up-struct-flock-definitions.patch
-clean-up-struct-flock64-definitions.patch
-consolidate-the-asm-ppc-fcntlh-files-into-asm-powerpc.patch
-inotify-fix-event-loss-on-hardlinked-files.patch
-sunrpc-print-unsigned-integers-in-stats.patch
-block-cfq-refcounting-fix.patch
-remove-ia_attr_flags.patch
-namei-cleanup.patch
-use-get_fs_struct-in-proc.patch
-fix-enum-pid_directory_inos-in-proc-basec.patch
-remove-duplicated-code-from-proc-and-ptrace.patch
-remove-duplicated-sys_open32-code-from-64bit-archs.patch
-cifs_create-fix.patch
-dmi-remove-uneeded-function.patch
-dmi-remove-old-debugging-code.patch
-dmi-make-dmi_string-behave-like-strdup.patch
-dmi-add-onboard-devices-discovery.patch
-dmi-add-onboard-devices-discovery-fix.patch
-ipmi-use-dmi_find_device.patch
-fix-dmi_check_system.patch
-introduce-and-use-kzalloc.patch
-introduce-and-use-kzalloc-make-kcalloc-a-static-inline.patch
-ia64-convert-kcalloc-to-kzalloc.patch
-ppc64-convert-kcalloc-to-kzalloc.patch
-input-convert-kcalloc-to-kzalloc.patch
-usb-convert-kcalloc-to-kzalloc.patch
-drivers-convert-kcalloc-to-kzalloc.patch
-fs-convert-kcalloc-to-kzalloc.patch
-alsa-convert-kcalloc-to-kzalloc.patch
-ipmi-add-per-channel-ipmb-addresses.patch
-ipmi-high-res-timer-support-fixes.patch
-ipmi-watchdog-nmi-interaction-fixes.patch
-ipmi-allow-userland-to-include-ipmih.patch
-ipmi-oem-flag-handling-and-hacks-for-some-dell-machines.patch
-ipmi-clean-up-versioning-of-the-ipmi-driver.patch
-ipmi-fix-panic-ipmb-response.patch
-hfs-remove-debug-code.patch
-hfs-show_options-support.patch
-hfs-nls-support.patch
-sd-initialize-sd-cards.patch
-sd-read-only-switch.patch
-sd-read-only-switch-coding-style-fix.patch
-sd-read-only-switch-mmc-sd-init-order-fix.patch
-sd-read-only-switch-mmc-sd-ro-style-fix.patch
-sd-scr-register.patch
-sd-scr-register-fix-a-bit-byte-counting-error-in-the-mmc-sd-code.patch
-sd-scr-register-mmc-sd-scr-style-fixpatch.patch
-sd-scr-in-sysfs.patch
-sd-4-bit-bus.patch
-sd-copyright-notice.patch
-add-write-protection-switch-handling-to-the-pxa-mmc-driver.patch
-mmc-wbsd-secure-digital-support.patch
-mmc-conditional-scr-sysfs-entry.patch
-corgi-keyboard-fix-a-couple-of-compile-errors.patch
-corgi-keyboard-add-some-power-management-code.patch
-corgi-keyboard-code-tidying.patch
-corgi-touchscreen-allow-the-driver-to-share-the-pmu.patch
-corgi-touchscreen-code-cleanup--fixes.patch
-corgi-touchscreen-fix-a-pmu-bug.patch
-w100fb-rewrite-for-platform-independence.patch
-w100fb-rewrite-for-platform-independence-fix.patch
-w100fb-update-corgi-platform-code-to-match-new.patch
-input-add-a-new-switch-event-type.patch
-corgi-add-keyboard-and-touchscreen-device-definitions.patch
-corgi-add-mmc-sd-write-protection-switch-handling.patch
-kjournald-missing-jfs_unmount-check.patch
-fix-jbd-race-in-t_forget-list-handling.patch
-make-ll_rw_block-wait-for-buffer-lock.patch
-change-ll_rw_block-calls-in-jbd.patch
-change-ll_rw_block-calls-in-reiser.patch
-change-ll_rw_block-calls-in-ufs.patch
-change-hfs-to-not-use-ll_rw_block.patch
-fix-race-in-do_get_write_access.patch
-smsc-ircc2-whitespace-fixes.patch
-smsc-ircc2-formatting-fixes.patch
-smsc-ircc2-drop-dim-macro-in-favor-of-array_size.patch
-smsc-ircc2-remove-typedefs.patch
-smsc-ircc2-dont-pass-iobase-around.patch
-smsc-ircc2-add-to-sysfs-as-platform-device-new-pm.patch
-smsc-ircc2-pm-cleanup-do-not-close-device-when-suspending.patch
-smsc-ircc2-use-netdev_priv.patch
-smsc-ircc2-dont-use-void-where-specific-type-will-do.patch
-fix-smsc_ircc_init-return-value.patch
-kprobes-prevent-possible-race-conditions-generic.patch
-kprobes-prevent-possible-race-conditions-i386-changes.patch
-kprobes-prevent-possible-race-conditions-x86_64-changes.patch
-kprobes-prevent-possible-race-conditions-ppc64-changes.patch
-kprobes-prevent-possible-race-conditions-ia64-changes.patch
-kprobes-prevent-possible-race-conditions-sparc64-changes.patch
-kprobes-prevent-possible-race-conditions-sparc64-changes-fix.patch
-kprobes-ia64-fix-race-when-break-hits-and-kprobe-not-found.patch
-kprobes-fix-handling-of-simultaneous-probe-hit-unregister.patch
-pivot_root-circular-reference-fix-3.patch
-indycam--vino-drivers.patch
-dvb-clarify-description-text-for-dvb-bt8xx-in-kconfig.patch
-dvb-clarify-description-text-for-dvb-bt8xx-in-kconfig-fix.patch
-dvb-lgdt330x-check-callback-fix.patch
-yenta-auto-tune-ene-bridges-for-cb-cards.patch
-pcmcia-yenta-dont-mess-with-bridge-control-register.patch
-suspend-update-warnings-in-documentation.patch
-mm-filemapc-make-sync_page_range_nolock-static.patch
-mm-filemapc-make-generic_file_direct_io-static.patch

 Merged

+ip_conntrack_netbios_ns-build-fix.patch

 net build fix

+clear-task_struct-fs_excl-on-fork.patch

 CFQ fix

+i386-single-node-sparsemem-fix.patch

 sparsemem fix

+i386-config_acpi_srat-typo-fix.patch

 Kconfig fix

+ppc64-fix-oops-for-config_numa.patch

 pcp64 oops fix

+ppc32-fix-kconfig-mismerge.patch

 ppc32 fix

+acpi-should-depend-on-not-select-pci.patch

 ACPI fix

+sound-support-for-vaio-ra826g-hda.patch

 Vaio sound driver fix

+gregkh-driver-sysfs-strip_leading_trailing_whitespace-fix.patch

 Fix gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch

+input-keyboard_tasklet-dont-touch-leds-of-already-grabed-device.patch

 input driver fix

-git-jfs-fixup.patch

 Unneeded

+fix-split-include-dependency.patch

 build fix

-ipw2100-remove-by-hand-function-entry-exit-debugging.patch
-ieee80211_module-build-fixes.patch
-ieee80211_tx-build-fix.patch
-ieee80211_rx-build-fix.patch
-ieee80211_crypt-build-fix.patch
-ieee80211_crypt_ccmp-build-fix.patch
-ieee80211_crypt_wep-build-fix.patch
-ieee80211_crypt_tkip-build-fix.patch

 Unneeded

-ocfs2-prep.patch

 Dropped this - maintaining the
 move-truncate_inode_pages-into-delete_inode.patch patch separately was a
 pita.  Simply pull it in from git-ocfs2.patch

+txx9-serial-update.patch

 MIPS serial driver fix

+arch-pci_find_device-remove-alpha-kernel-sys_alcorc.patch
+arch-pci_find_device-remove-alpha-kernel-sys_sioc.patch
+arch-pci_find_device-remove-frv-mb93090-mb00-pci-frvc.patch
+arch-pci_find_device-remove-frv-mb93090-mb00-pci-irqc.patch
+arch-pci_find_device-remove-ppc-kernel-pcic.patch
+arch-pci_find_device-remove-ppc-platforms-85xx-mpc85xx_cds_commonc.patch
+arch-pci_find_device-remove-sparc64-kernel-ebusc.patch
+arch-pci_find_device-remove-sparc64-kernel-ebusc-fix.patch

 PCI cleanups

+pci-block-config-access-during-bist.patch
+pci-block-config-access-during-bist-update.patch
+pci-block-config-access-during-bist-update-2.patch
+pci-block-config-access-during-bist-fix-42.patch
+ipr-block-config-access-during-bist.patch
+pci-unhide-smbus-on-compaq-evo-n620c.patch

 Don't let userspace access PCI registers while we're issuing a BIST.

+usbdevice_fs-header-breakage.patch

 USB fix

+w83977f-watchdog-driver.patch

 New watchdog driver

+x86_64-defconfig-update.patch
+x86_64-smpboot-write-around.patch
+x86_64-genapic-write-around.patch
+x86_64-remove-esr-disable.patch
+x86_64-remove-apic-errata.patch
+x86_64-huge-cpu-apicids.patch
+x86_64-calibrate-enable-irqs.patch
+x86_64-smp-call-single-cleanup.patch
+x86_64-srat-apicid.patch
+x86_64-apic-version.patch
+x86_64-pda-up-align.patch
+x86_64-numa-k8-nodeid.patch
+x86_64-intel-srat.patch
+x86_64-apic-bsp-id-up.patch
+x86_64-swiotlb-bounce.patch
+x86_64-pgdat-order.patch
+x86_64-aperture-swiotlb.patch
+x86_64-swiotlb-force.patch
+x86_64-mce-lockup.patch
+x86_64-mce-cmd-line.patch
+x86_64-up-apicid.patch
+x86_64-pci-gart-node-opt.patch
+x86_64-e820-off-by-one.patch
+x86_64-reserved-check.patch
+x86_64-flatmem-end-pfn.patch
+x86_64-mce-smp-resume.patch
+x86_64-pci-pxm.patch
+x86_64-dma32.patch
+x86_64-dma32-iommu.patch
+x86_64-dma32-ia64-compat.patch
+x86_64-print-uts-version.patch
+x86_64-sendfile-fix.patch
+x86_64-scalable-tlb-flush.patch
+x86_64-simnow-console.patch
+x86_64-pda-cleanup.patch
+x86_64-timex-config.patch
+x86_64-tlb-flush-array.patch
+x86_64-cpu-data-possible.patch
+x86_64-vm-holes-reserved.patch
+x86_64-idle-poll-fix.patch
+x86_64-early-page-typo.patch
+x86_64-setup-merge.patch
+x86_64-drop-disable-tsc.patch
+x86_64-show_mem-printk.patch
+x86_64-syscall-clobber.patch
+x86_64-pfn-valid-off-by-one.patch
+x86_64-nodemap-extend.patch
+x86_64-irq-bug.patch
+x86_64-hotplug-typo.patch
+x86_64-trampoline-free.patch
+x86_64-extern-inline.patch
+x86_64-lowest-pri.patch
+x86_64-vsyscall-gcc4.patch
+x86_64-srat-overlap-error.patch
+x86_64-dma-sync-range.patch
+x86_64-physflat-intel.patch

 x86_64 tree

+add-sem_is_read-write_locked-fix.patch
+add-sem_is_read-write_locked-fix-2.patch
+add-sem_is_read-write_locked-fix-3.patch

 Fix add-sem_is_read-write_locked.patch

-use-mm_counter-macros-for-nr_pte-since-its-also-under-ptl.patch
-page-fault-patches-introduce-pte_xchg-and-pte_cmpxchg.patch
-page-fault-patches-optional-page_lock-acquisition-in.patch
-page-fault-patches-optional-page_lock-acquisition-in-vs-use-mm_counter-macros-for-nr_pte-since-its-also-under-ptl.patch
-page-fault-patches-optional-page_lock-acquisition-in-nicety.patch
-page-fault-patches-no-pagetable-lock-in-do_anon_page.patch

 Drop these - we'll test Hugh's approach to fixing page_table_lock contention.

+swaptoken-tuning-fix-2.patch

 Fix swaptoken-tuning.patch

+memory-hotplug-prep-kill-local_mapnr.patch
+memory-hotplug-prep-break-out-zone-initialization.patch
+memory-hotplug-prep-break-out-zone-initialization-fix.patch
+memory-hotplug-prep-__section_nr-helper.patch
+memory-hotplug-prep-__section_nr-helper-fix.patch
+memory-hotplug-prep-fixup-bad_range.patch
+memory-hotplug-locking-node_size_lock.patch
+memory-hotplug-locking-zone-span-seqlock.patch
+memory-hotplug-sysfs-and-add-remove-functions.patch
+memory-hotplug-move-section_mem_map-alloc-to-sparsec.patch
+memory-hotplug-call-setup_per_zone_pages_min-after-hotplug.patch
+memory-hotplug-i386-addition-functions.patch
+memory-hotplug-i386-addition-functions-warning-fix.patch
+memory-hotplug-ppc64-specific-hot-add-functions.patch

 Memory hot-unplug support

+3c59x-convert-to-use-of-pci-iomap-api.patch
+pcnet32-set_ringparam-implementation.patch
+pcnet32-set_ringparam-implementation-tidy.patch
+skge-kconfig-help-text-typo-fix.patch

 netdev fixes

+acx1xx-wireless-driver.patch
+acx1xx-wireless-driver-usb-is-bust.patch
+acx1xx-allow-modular-build.patch
+acx1xx-wireless-driver-spy_offset-went-away.patch

 Driver for TI acx1xx wireless cards (a bit rough.  I happen to have one of
 these cards.  I got it to ping something).

+ppc32-make-perfmono-config_e500-specific.patch

 ppc32 fix

+mips-add-tanbac-tb0287-support.patch

 MIPS device support

+i386-seccomp-fix-for-auditing-ptrace.patch
+x86-cache-pollution-aware-__copy_from_user_ll.patch
+x86-cache-pollution-aware-__copy_from_user_ll-tidy.patch
+x86-cache-pollution-aware-__copy_from_user_ll-build-fix.patch
+x86-cache-pollution-aware-__copy_from_user_ll-build-fix-2.patch

 x86 updates

+x86_64-nmi-watchdog-frequency-calculation-adjustments.patch

 x86_64 NMI watchdog fix

-x86_64fix-cluster-mode-send_ipi_allbutself-to-use-get_cpu-put_cpu.patch
-x86_64dont-use-lowest-priority-when-using-physical-mode.patch
-x86_64use-common-functions-in-cluster-and-physflat-mode.patch
-x86_64-choose-physflat-for-amd-systems-only-when-8-cpus.patch

 Dropped, or in Andi's tree.

+alpha-process_reloc_for_got-confuses-r_offset-and-r_addend.patch

 Alpha fix

-pselect-ppoll-system-calls-tidy.patch
-pselect-ppoll-system-calls-fix.patch
-pselect-ppoll-system-calls-sigset_t-fix-2.patch
-pselect-ppoll-system-calls-sigset_t-fix-3.patch
-pselect-ppoll-system-calls-compat-fix.patch
-pselect-ppoll-system-calls-copy_to_user-check.patch

 Folded into pselect-ppoll-system-calls.patch

+convert-proc-devices-to-use-seq_file-interface-tidy.patch

 cleanup

-open-returns-enfile-but-creates-file-anyway-tidy.patch

 Folded into open-returns-enfile-but-creates-file-anyway.patch

+vga-text-console-and-stty-cols-rows.patch
+vga-text-console-and-stty-cols-rows-tidy.patch

 VGA fix

+autofs-fix-busy-inodes-after-umount.patch

 autofs3 fix

+fix-disassociate_ctty-vs-fork-race.patch

 Fix a race

+ide-scsi-highmem-cleanup.patch

 Clean up ide-scsi a bit

+prefetch-kernel-stacks-to-speed-up-context-switch.patch

 ia64 speedup

+bfs-fix-endianness-signedness-add-trivial-bugfix.patch

 BFS fixes

+cs89x0-add-netpoll-support.patch

 cs80x0 feature

+change-io_cancel-return-code-for-no-cancel-case.patch
+kiocb-locking-to-serialise-retry-and-cancel-2.patch

 AIO fixes

+subcpusets-fix-for-cpusets-minor-problem.patch

 cpusets fix

+remove-unnecessary-handle_irq_event-prototypes.patch

 cleanup

+deadline-cleanup-question-mark-operator.patch

 deadline cleanup

+parport-buffer-overflow-fix.patch
+parport-phase-fixes.patch
+parport-daisy-chain-end-detection-fix.patch
+parport-daisy-chain-device-id-reading-fix.patch
+parport-use-complete-slab-buffer.patch
+parport-constification.patch
+parport-debug_parport-build-fix.patch
+parport-kconfig-dependency-fixes.patch
+parport-include-fixes.patch
+parport-export-parport_get_port.patch

 parport driver fixes

+synclinkc-compiler-optimisation-fix.patch
+synclinkc-add-clear-stats.patch
+synclinkc-add-loopback-to-async-mode.patch
+synclinkmpc-fix-double-mapping-of-signals.patch
+synclinkmpc-disable-burst-transfers.patch
+synclinkmpc-add-statistics-clear.patch
+synclinkmpc-fix-async-internal-loopback.patch

 synclink update

-coverity-usb-host-ehci-dbg-null-check.patch

 Folded into coverity-udf-balloc-null-deref-fix.patch

+sharpsl-abstract-c7x0-specifics-from-corgi-ssp.patch
+sharpsl-add-cxx00-support-to-the-corgi-lcd-driver.patch
+sharpsl-abstract-c7x0-specifics-from-corgi.patch
+sharpsl-abstract-model-specifics-from-corgi.patch
+sharpsl-add-new-arm-pxa-machines-spitz-and-borzoi.patch

 Zaurus updates

+rapidio-message-interface-updates.patch
+rapidio-support-net-driver-fixes.patch

 rapidio driver updates

+dvb-email-address-update.patch
+dvb-remove-versionh-dependencies.patch
+dvb-avoid-building-empty-built-ino.patch
+dvb-core-glue-code-for-dmx_get_caps-and-dmx_set_source.patch
+dvb-core-dvb_demux-fix-continuity-counter-error-handling.patch
+dvb-core-dvb_demux-remove-unused-cruft.patch
+dvb-core-dvb_demux-remove-unsused-descramble-callbacks.patch
+dvb-core-dvb_demux-remove-more-unused-cruft.patch
+dvb-core-dvb_demux-use-init_list_head.patch
+dvb-core-dvb_demux-formatting-fixes.patch
+dvb-core-ci-timeout-fix.patch
+dvb-frontend-mt352-fix-signal-strength-reading.patch
+dvb-frontend-stv0299-pass-i2c-bus-to-pll-callback.patch
+dvb-frontend-s5h1420-fixes.patch
+dvb-frontend-stv0299-support-reading-both-ber-and-ucblocks.patch
+dvb-frontend-tda1004x-fix-snr-reading.patch
+dvb-frontend-ves1820-improve-tuning.patch
+dvb-frontend-cx24110-diseqc-fix.patch
+dvb-frontend-cx24110-another-diseqc-fix.patch
+dvb-frontend-cx24110-clean-up-timeout-handling.patch
+dvb-frontend-stv0297-qam128-tuning-improvement.patch
+dvb-frontend-or51132-remove-bogus-optimization-attempt.patch
+dvb-usb-add-twinhandtv-starbox-support.patch
+dvb-usb-dibusb-kworld-xpert-dvb-t-usb20-support.patch
+dvb-usb-removed-empty-module_init-exit-calls.patch
+dvb-usb-dtt200u-copy-frontend_ops-before-modifying.patch
+dvb-usb-dtt200u-add-proper-device-names.patch
+dvb-usb-core-change-dvb_usb_device_init-api.patch
+dvb-usb-digitv-support-for-nxt6000-demod.patch
+dvb-usb-white-space-cleanup.patch
+dvb-usb-cxusb-fixes-for-new-firmware.patch
+dvb-remove-noisy-debug-print.patch
+dvb-bt8xx-endianness-fix.patch
+dvb-bt8xx-cleanup.patch
+dvb-bt8xx-nebula-digitv-mt352-support.patch
+dvb-nebula-digitv-nxt6000-fix.patch
+dvb-dst-fix-symbol-rate-setting.patch
+dvb-dst-remove-unnecessary-code.patch
+dvb-dst-dprrintk-cleanup.patch
+dvb-dst-dprrintk-cleanup-gcc-29x-fix.patch
+dvb-dst-dprrintk-cleanup-gcc-295-fix.patch
+dvb-dst-identify-boards.patch
+dvb-dst-fix-dvb-c-tuning.patch
+dvb-dst-ci-doc-update.patch
+dvb-dst-updated-documentation.patch
+dvb-cinergyt2-remote-control-fixes.patch
+dvb-av7110-siemens-dvb-c-analog-video-input-support.patch
+dvb-budget-ci-add-support-for-tt-dvb-c-ci-card.patch
+dvb-budget-av-fixes-for-ci-interface.patch
+dvb-budget-av-enable-frontend-on-knc1-plus-cards.patch
+dvb-av7110-disable-superflous-firmware-handshake.patch
+dvb-av7110-conditionally-disable-workaround-for-broken-firmware.patch
+dvb-ttpci-av7110-rc5-remote-control-support.patch
+dvb-ttpci-add-pci-ids-for-old-siemens-tt-dvb-c-card.patch
+dvb-saa7146-i2c-vs-sysfs-fix.patch
+dvb-ttusb-budget-use-time_after_eq.patch

 DVB updates

+pcmcia-avoid-macro-usage.patch
+pcmcia-tiny-yenta_socketc-cleanup.patch
+pcmcia-warn-on-ioctl-usage.patch
+pcmcia-new-suspend-core.patch
+pcmcia-new-suspend-core-dev_to_instance-fix.patch
+pcmcia-convert-drivers-to-use-new-suspend-mechanism.patch
+pcmcia-convert-drivers-to-use-new-suspend-mechanism-spectrum_cs.patch
+pcmcia-convert-serial_cs-to-use-new-suspend-mechanism.patch
+pcmcia-use-runtime-suspend-resume-support-to-unify-all-suspend-code-paths.patch
+pcmcia-unified-device-removal-code-path.patch
+pcmcia-convert-drivers-to-use-unified-removal-code-path.patch
+pcmcia-remove-old-two-step-removal-mechanism.patch
+pcmcia-remove-unused-dev_list-in-drivers.patch
+pcmcia-unified-probe-code-path.patch
+pcmcia-convert-drivers-to-use-new-probe-mechanism.patch
+pcmcia-yenta-dont-mess-with-bridge-control-register.patch
+yenta-auto-tune-ene-bridges-for-cb-cards.patch

 Largeish pcmcia update

+nfsacl-solaris-vxfs-compatibility-fix.patch

 NFS fix

+spinlock-consolidation-sparc64-fix.patch

 Fix spinlock-consolidation-ia64-fix.patch

+scheduler-cache-hot-autodetect.patch

 Bring this scheduler feature back (it does way too much printk()ing still)

+sched-use-cached-variable-in-sys_sched_yield.patch

 scheduler microoptimisation

+m68k-introduce-task_thread_info.patch
+m68k-introduce-setup_thread_stack-end_of_stack.patch
+m68k-thread_info-header-cleanup.patch
+m68k-m68k-specific-thread_info-changes.patch
+m68k-convert-thread-flags-to-use-bit-fields.patch
+add-stack-field-to-task_struct.patch
+add-stack-field-to-task_struct-ia64-fix.patch
+rename-allocfree_thread_info-to-allocfree_thread_stack.patch
+use-end_of_stack.patch
+change-thread_info-access-to-stack.patch
+use-task_thread_info.patch

 Replace task_struct.thread_info with task_struct.stack and do m68k fixes
 sort-of in the middle.

+v4l-common-part-updates-and-tuner-additions.patch
+v4l-common-part-updates-and-tuner-additions-gcc-29x-fix.patch
+v4l-bttv-updates-and-card-additions.patch
+v4l-bttv-updates-and-card-additions-fix.patch
+v4l-cx88-updates-and-card-additions.patch
+v4l-cx88-updates-and-card-additions-gcc-295-fix.patch
+v4l-saa7134-updates-and-board-additions.patch
+v4l-changes-the-prefix-of-msp34xx-and-error-while.patch
+v4l-syncs-tveeprom-tuners-list-with-the-list-from.patch
+v4l-correct-lg-ntsc-taln-mini-tuner-takeover.patch
+v4l-add-saa713x-card-65-kworld-v-stream-studio-tv-terminator.patch
+v4l-add-saa713x-card-66-yuan-tun-900-saa7135.patch
+v4l-cx88-dvb-incorrectly-reporting-fixed-and.patch
+v4l-normalize-whitespace-and-comments-in-tuner.patch
+v4l-change-lg-tdvs-h062f-from-ntsc-to-atsc.patch
+v4l-some-error-treatment-implemented-at-resume.patch
+v4l-the-microtune-4049fm5-uses-an-if-frequency-of.patch
+v4l-include-linux-configh-no-longer-needed.patch
+v4l-correct-the-amux-for-composite-and-s-video.patch
+v4l-print-warning-if-pal=-or-secam=-argument-is.patch
+v4l-added-some-missing-parameter-descriptions-at.patch
+v4l-makes-the-input-event-device-for-ir-matchable.patch
+v4l-include-saa6588-compiler-option-and-files.patch
+v4l-removed-kernel-version-dependency-from.patch
+v4l-tvaudio-cleanup-and-better-degug-messages.patch
+v4l-tvaudio-cleanup-and-better-degug-messages-gcc-29c-fix.patch
+v4l-tveeprom-improved-to-support-newer-hauppage-cards.patch
+v4l-tveeprom-improved-to-support-newer-hauppage-cards-gcc-29x-fix.patch

 v4l updates

+fix-kernel-oops-with-cf-cards.patch

 Fix compact-flash bug

+fbdev-geode-updates-fix.patch

 Fix fbdev-geode-updates.patch

+sisfb-update-resurrect-makefile.patch
+sisfb-update-makefile.patch

 Fix sisfb-update.patch

+fbdev-add-vesa-coordinated-video-timings-cvt-support.patch
+nvidiafb-use-cvt-to-get-mode-for-digital-displays.patch
+savagefb-make-mode_option-available-when-compiled-as.patch
+fbcon-stop-cursor-timer-if-console-is-inactive.patch
+nvidiafb-fixed-mirrored-characters-in-big-endian-machines.patch
+fbdev-initialize-var-structure-in-calc_mode_timings.patch
+pxafb-add-hsync-time-reporting-hook.patch
+fbcon-break-up-bit_putcs-into-its-component-functions.patch
+fbcon-break-up-bit_putcs-into-its-component-functions-fix.patch
+i810fb-add-i2c-ddc-support.patch
+i810fb-add-i2c-ddc-support-fix.patch
+i810fb-add-i2c-ddc-support-fix-fix.patch
+i810fb-add-i2c-ddc-support-Makefile-fix.patch
+i810fb-stop-lcd-displays-from-flickering.patch
+quiet-non-x86-option-rom-warnings.patch
+s3c2410fb-arm-s3c2410-framebuffer-driver.patch
+s3c2410fb-platform-support-for-arm-s3c2410-framebuffer.patch

 fbdev driver updates

+drivers-md-raid1c-make-a-function-static.patch
+md-choose-better-default-offset-for-bitmap.patch
+md-use-queue_hardsect_size-instead-of-block_size-for-md-superblock-size-calc.patch
+md-add-information-about-superblock-version-to-proc-mdstat.patch
+md-report-spare-drives-in-proc-mdstat.patch
+md-make-sure-the-new-sb_size-is-set-properly-device-added-without-pre-existing-superblock.patch
+md-really-get-sb_size-setting-right-in-all-cases.patch
+md-fix-raid10-assembly-when-too-many-devices-are-missing.patch
+md-fix-bug-when-raid10-rebuilds-without-enough-drives.patch

 RAID updates

+documentation-sparse-snapshot-url.patch

 Documentation fix

+fuse-more-flexible-caching.patch

 fuse update

+mm-filemapc-make-two-functions-static.patch
+mm-filemapc-make-sync_page_range_nolock-static.patch
+mm-filemapc-make-generic_file_direct_io-static.patch

 scoping fixes

+lib-sortc-small-cleanups.patch
+drivers-net-wan-possible-cleanups.patch
+remove-acpi-s4bios-support.patch
+fs-cramfs-uncompressc-should-include-linux-cramfs_fsh.patch
+i386-x86_64-make-get_cpu_vendor-static.patch

 cleanuplets



All 874 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/patch-list


