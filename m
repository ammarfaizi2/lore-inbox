Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVCaKfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVCaKfe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVCaKfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:35:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:37353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261235AbVCaK0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:26:17 -0500
Date: Thu, 31 Mar 2005 02:25:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc1-mm4
Message-Id: <20050331022554.735a1118.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm4/


- New reiserfs4 code drop

- Various new fixes and cleanups.  Am still interested in hearing how people
  are going with the DRI problems and the PM resume problems.



Changes since 2.6.12-rc1-mm3:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-audit.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ia64.patch
 bk-ide-dev.patch
 bk-input.patch
 bk-kbuild.patch
 bk-mtd.patch
 bk-net.patch
 bk-netdev.patch
 bk-nfs.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch
 bk-serial.patch
 bk-watchdog.patch

 Latest versions of subsystem trees

-pcmcia-properly-bail-out-on-mtd-related-ioctl-invocation.patch
-pcmcia-dont-lock-up-in-rsrc_nonstatic-pcmcia_validate_mem.patch
-pcmcia-dont-send-eject-request-events-to-userspace.patch
-ppc64-preliminary-changes-to-of-fixup-functions.patch
-ppc64-make-of-node-fixup-code-usable-at-runtime.patch
-ppc64-introduce-pseries_reconfig.patch
-ppc64-promc-use-pseries-reconfig-notifier.patch
-ppc64-fix-aio-panic-caused-by-is_hugepage_only_range.patch
-handle-multiple-video-cards-on-the-same-bus.patch
-tty-overrun-time-fix.patch
-bk-driver-core-hang-fix.patch
-3dfx-drm-depends-on-pci.patch
-sata_sil-corruption--lockup-fix.patch
-bk-nfs-gcc4-fix.patch
-nfs4-empty-array-fix.patch
-drivers-pci-hotplug-cpqphp_corec-fix-a-check-after-use.patch
-ub-atomicity-fix.patch
-drivers-usb-misc-usbtestc-fix-a-null-dereference.patch
-slab-kmalloc-cleanups.patch
-slab-64bit-fix.patch
-vmscan-move-code-to-isolate-lru-pages-into-separate-function.patch
-mm-counter-operations-through-macros.patch
-mm-counter-operations-through-macros-tidy.patch
-slab-shrinkers-use-vfs_cache_pressure.patch
-include-cleanup-in-pgalloch.patch
-fix-mmap-of-dev-kmem.patch
-unused-size-assignment-in-filemap_nopage.patch
-remove-last_rx-update-from-loopback-device.patch
-a-new-10gb-ethernet-driver-by-chelsio-communications-update.patch
-pcnet32-bug-79c975-fiber-fix.patch
-null-pointer-bug-in-netpollc.patch
-restore-ports-module-parameter-for-ip_nat_ftp-and-ip_nat_irc.patch
-ipt-leak-fix.patch
-ipv6-fix-address-interface-handling-according-to-the-scoping-architecture.patch
-drivers-net-wireless-airoc-correct-a-wrong-check.patch
-selinux-make-code-static-and-remove-unused-code.patch
-selinux-allow-mounting-of-filesystems-with-invalid-root-inode-context.patch
-selinux-audit-unrecognized-netlink-messages.patch
-selinux-add-name_connect-permission-check.patch
-ppc32-fix-mv64x60-internal-sram-size.patch
-ppc32-move-83xx-85xx-device-and-system-description-files.patch
-ppc32-fix-config_serial_text_debug-support-on-83xx.patch
-ppc32-typo-fix-in-load-store-string-emulation.patch
-ppc32-report-chipset-version-in-common-proc-cpuinfo-handling.patch
-ppc32-report-chipset-version-in-common-proc-cpuinfo-handling-fix.patch
-ppc32-dmasound-compilation-fix.patch
-ppc32-fix-sandpoint-soft-reboot.patch
-ppc32-64-map-prefetchable-pci-without-guarded-bit.patch
-ppc32-fix-broken-compile-on-sky-computers-hdpu-platform.patch
-ppc32-8xx-typo-fix.patch
-ppc64-pci_dnc-use-pseries-reconfig-notifier.patch
-ppc64-pseries_iommuc-use-pseries-reconfig-notifier.patch
-ppc64-fix-gcc4-compile-error-in-pacah.patch
-ppc64-fix-compile-error-in-promc.patch
-ppc64-fix-linkage-error-on-g5.patch
-ppc64-fix-semtimedop-compat-syscall.patch
-ppc64-fix-pseries-hcall-stubs.patch
-ppc64-make-numa=off-command-line-argument-work-again.patch
-ppc64-fix-ethernet-phy-reset-on-imac-g5.patch
-ppc64-fix-lpar-iommu-setup-code-for-p630.patch
-mips-linkage-fix.patch
-mips-update-vr41xx-rtc-support.patch
-x86-cmos-time-update-optimisation.patch
-x86-cmos-time-update-optimisation-tidy.patch
-x86-cmos-time-update-optimisation-locking-fix.patch
-x86-cmos-time-update-optimisation-locking-fix-check.patch
-apm-fix-interrupts-enabled-in-device_power_up.patch
-rtc_lock-is-irq-safe.patch
-fix-put_user-for-80386.patch
-es7000-legacy-mappings-update.patch
-x86-fix-esp-corruption-cpu-bug-take-2-fix.patch
-es7000-dmi-cleanup.patch
-i386-add-kstack=n-option-from-x86_64.patch
-rename-fpu_verify_area-to-fpu_access_ok.patch
-x86_64-update-defconfig.patch
-x86_64-add-new-amd-cpuid-flags-to-cpuinfo.patch
-x86_64-add-an-64bit-entry-path-for-exec.patch
-x86_64-busses-array-is-only-indexed-with-a-8bit-value.patch
-x86_64-fix-compilation-with-config_proc_fs=n.patch
-x86_64-move-hpet-selection-into-processor-specific.patch
-x86_64-remove-never-used-obsolete-file.patch
-x86_64-fix-indentation-in-vsyscallc-no-functional.patch
-x86_64-nop-out-system-call-instruction-in-vsyscall-page.patch
-x86_64-nop-out-system-call-instruction-in-vsyscall-page-fix.patch
-x86_64-remove-obsolete-comments-in-vsyscallc-and-fix.patch
-x86_64-remove-noisy-printk-in-k8-bus-detection-code.patch
-x86_64-remove-unused-and-broken-code-in-ioh.patch
-x86_64-remove-stale-unused-file.patch
-x86_64-move-put_user-out-of-line.patch
-x86_64-give-out-of-line-get_user-better-calling.patch
-x86_64-work-around-tyan-bios-mtrr-initialization-bug.patch
-x86_64-include-pci-express-configuration.patch
-x86_64-cleanups-in-new-backtrace-code-in-oprofile.patch
-x86_64-fix-special-isa-case-in-iounmap.patch
-x86_64-fix-formatting-and-white-space-in-signal-code.patch
-x86_64-mem=xxx-will-now-limit-kernel-memory-to-xxx.patch
-x86_64-resume-pit-for-x86_64.patch
-x86_64-fix-nmi-rtc-access-race.patch
-x86_64-minor-fix-to-tlb-flush-ipi.patch
-x86_64-always-reload-cr3-completely-when-a-lazy-mm.patch
-x86_64-fix-ldt-descriptor.patch
-x86_64-change-the-y2069-bug-in-the-rtc-timer-code-to-be.patch
-x86_64-only-free-pmds-and-puds-after-other-cpus-have.patch
-x86_64-dont-enable-interrupts-in-oopses.patch
-x86_64-fix-smp-fallback-to-up.patch
-x86_64-fix-config_preempt.patch
-x86_64-fix-exception-stack-detection-during-backtraces.patch
-x86_64-fix-gcc-34-warning-in-bitopsc.patch
-x86_64-fix-missing-delay-when-the-tsc-counter-just.patch
-x86_64-clean-up-the-iommu-initialisation-a-bit.patch
-x86-64-kconfig-typo-trivial.patch
-x86_64-remove-old-decl-trivial.patch
-x86_64-hugetlb-fix.patch
-x86-64-forgot-asmlinkage-on-sys_mmap.patch
-x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait-warning-fix.patch
-kernel-parameters-ia-32-x86-64-cleanups.patch
-x86_64-dump-stack-in-early-exception.patch
-alpha-spinlockh-update.patch
-ia64-reduce-cacheline-bouncing-in-cpu_idle_wait-fix.patch
-swsusp-add-missing-refrigerator-calls.patch
-suspend-to-ram-update-videotxt-with-more-systems.patch
-pm-remove-obsolete-pm_-from-vtc.patch
-swsusp-small-updates.patch
-swsusp-1-1-kill-swsusp_restore.patch
-m32r-update-mmu-less-support-1.patch
-m32r-update-mmu-less-support-2.patch
-m32r-update-mmu-less-support-3.patch
-m32r-fix-m32102-i-cache-invalidation.patch
-m32r_sio-driver-update.patch
-m68k-update-signal-delivery-handling.patch
-m68k-stdma-replace-sleep_on-with-wait_event.patch
-zorro-replace-printk-with-pr_info-in-drivers-zorro-zorroc.patch
-mac-ncr5380-scsi-fix-bus-error.patch
-m68k-ip-checksum-updates.patch
-sun-3-3x-enable-sun-partition-tables-support-by-default.patch
-m68k-add-missing-pieces-of-thread-info-tif_memdie-support.patch
-tpm-depends-on-pci.patch
-uml-cope-with-uml_net-security-fix-2.patch
-uml-fix-compile.patch
-uml-cpu_relax-fix.patch
-uml-extend-cmd-line-limits.patch
-uml-disable-more-hardware-kconfig-opt-and-rename-usermode-to-uml.patch
-uml-little-build-fixes.patch
-uml-factor-out-common-code-in-user-obj-handling.patch
-uml-kbuild-link-cmd.patch
-uml-add-kconfig-debug-deps.patch
-uml-real-fix-for-__gcov_init-symbols.patch
-uml-fix-cond-expr-as-lvalues-warning.patch
-s390-swapped-memset-arguments.patch
-s390-kernel-faults.patch
-s390-signal-stack-bug.patch
-s390-dasd-preferred-path-support.patch
-s390-qeth-layer2-fixes.patch
-s390-qeth-1920-device-support.patch
-s390-qeth-blkt-tuning.patch
-s390-qeth-tcp-segmentation-offload.patch
-s390-claw-network-device-driver.patch
-cant-unmount-bad-inode.patch
-stallion-driver-module-clean-up.patch
-use-__init-and-__exit-in-pktcdvd.patch
-dvd-ram-support-for-pktcdvd.patch
-break_lock-fix-2.patch
-cdrom-cdu31a-cleanups.patch
-cdrom-cdu31a-locking-fixes.patch
-cdrom-cdu31a-use-wait_event.patch
-revert-gconfig-changes.patch
-revert-gconfig-changes-build-fix.patch
-enable-gcc-warnings-for-vsprintf-vsnprintf-with-format-attribute.patch
-w6692-eliminate-bad-section-references.patch
-teles3-eliminate-bad-section-references.patch
-elsa-eliminate-bad-section-references.patch
-hfc_sx-eliminate-bad-section-references.patch
-sedlbauer-eliminate-bad-section-references.patch
-fix-mprotect-with-len=size_t-1-to-return-enomem.patch
-checkstack-fix-sort-misbehavior-for-long-function-names.patch
-fix-irq_affinity-write-from-proc-for-ia64.patch
-fix-mmap-return-value-to-conform-posix.patch
-fix-mmap-return-value-to-conform-to-posix.patch
-exports-to-enable-clock-driver-modules.patch
-per-cpu-irq-stat.patch
-kill-drivers-cdrom-mcdc.patch
-drivers-char-isicomc-gcc4-fix.patch
-infiniband-remove-unsafe-use-of-in_atomic.patch
-new-console-flag-con_boot.patch
-new-console-flag-con_boot-comment.patch
-pipe-save-one-pipe-page.patch
-kprobes-incorrect-spin_unlock_irqrestore-call-in-register_kprobe.patch
-ext2_make_empty-information-leak.patch
-missing-set_fs-calls-around-kernel-syscall.patch
-cpusets-mems-generation-deadlock-fix.patch
-cpusets-alloc-gfp_wait-sleep-fix.patch
-mtrr-uaccess-range-checking-fix.patch
-cciss-range-checking-fix.patch
-fix-posix-timers-expiring-before-their-scheduled-time.patch
-fix-oops-when-inserting-ipmi_si-module.patch
-posix-cpu-timers-and-cputime_t-divisons.patch
-ext2-3-file-limits-to-avoid-overflowing-i_blocks.patch
-load_elf_library-kfree-fix.patch
-futex-queue_me-get_user-ordering-fix.patch
-io_remap_pfn_range-add-for-all-arch-es.patch
-io_remap_pfn_range-add-for-all-arch-es-fix.patch
-io_remap_pfn_range-convert-sparc-callers.patch
-io_remap_pfn_range-fix-some-callers-for-xen.patch
-io_remap_pfn_range-convert-last-callers.patch
-alpha-build-fixes.patch
-fix-pcmcia-resume-with-card-inserted.patch
-pcmcia-clean-up-suspend.patch
-small-warning-fix-for-gcc4.patch
-alpha-elimitate-two-warnings-from-gcc4.patch
-fat-set-ms_noatime-to-msdos.patch
-fat-fix-msdos-datetime.patch
-fix-compile-warning-in-drivers-pnp-resourcec-with-config_pci.patch
-nlm-fix-f_count-leak.patch
-module-parameter-fixes.patch
-fs-hpfs-fix-hpfs-support-under-64-bit-kernel.patch
-arch-hook-for-notifying-changes-in-pte-protections-bits.patch
-serial-digi-neo-driver.patch
-netmos-parallel-serial-combo-support.patch
-bt819-array-indexing-fix.patch
-unified-spinlock-initialization.patch
-drivers-block-dac960c-fix-a-use-after-free.patch
-drivers-telephony-ixj-fix-a-use-after-free.patch
-fs-attrc-fix-check-after-use.patch
-fs-smbfs-requestc-fix-null-dereference.patch
-hfs-free-page-buffers-in-releasepage.patch
-hfs-fix-umask-behaviour.patch
-hfs-more-bnode-error-checks.patch
-hfs-fix-sign-problem-in-hfs_ext_keycmp.patch
-hfs-use-parse-library-for-mount-options.patch
-hfs-add-nls-support.patch
-hfs-unicode-decompose-support.patch
-dvb-clarify-firmware-upload-messages.patch
-dvb-dibcom-frontend-fixes.patch
-dvb-dibusb-misc-fixes.patch
-dvb-skystar2-remove-duplicate-pci_release_region.patch
-dvb-mt352-pinnacle-300i-comments.patch
-dvb-support-activy-budget-card.patch
-dvb-skystar2-update-email-address.patch
-dvb-ves1x93-invert_pwm-fix.patch
-dvb-dibusb-readme-update.patch
-dvb-dibusb-support-hauppauge-wintv-nova-t-usb2.patch
-dvb-nxt2002-qam64-256-support.patch
-dvb-get_dvb_firmware-new-unshield-version.patch
-dvb-dib3000-corrected-device-naming.patch
-dvb-dibusb-debug-changes.patch
-dvb-dibusb-increased-the-number-of-urbs-for-usb11-devices.patch
-dvb-ttusb_dec-use-alternative-interface-to-save-bandwidth.patch
-dvb-l64781-email-address-fix.patch
-dvb-skystar2-fix-mac-address-reading.patch
-dvb-support-kworld-adstech-instant-dvb-t-usb20.patch
-dvb-cleanups-make-stuff-static.patch
-dvb-refactor-sw-pid-filter-to-drop-redundant-code.patch
-dvb-nxt2002-fix-max-frequency.patch
-dvb-ttusb-budget-s-usb_unlink_urb-usb_kill_urb.patch
-dvb-av7110-fix-oops-when-av7110_ir_init-failed.patch
-dvb-saa7146-static-initialization.patch
-dvb-av7110-error-handling-during-attach.patch
-dvb-corrected-links-to-firmware-files.patch
-dvb-support-pchdtv-hd2000.patch
-dvb-dibusb-support-nova-t-usb-ir.patch
-dvb-oren-or51211-or51132_qam-and-or51132_vsb-firmware-download-info.patch
-dvb-ttusb_dec-ir-support.patch
-dvb-dibusb-pll-fix.patch
-dvb-tda10021-fix-continuity-errors.patch
-dvb-saa7146-remove-duplicate-setgpio.patch
-dvb-fix-cams-on-typhoon-dvb-s.patch
-dvb-frontends-kfree-cleanup.patch
-dvb-clear-up-confusion-between-ids-and-adapters.patch
-dvb-dibusb-remove-useless-ifdef.patch
-dvb-support-for-technotrend-pci-dvb-t.patch
-dvb-dibusb-hanftek-umt-010-fixes.patch
-dvb-vfree-checking-cleanups.patch
-dvb-convert-from-pci_module_init-to-pci_register_driver.patch
-dvb-dibusb-support-dtt200u-yakumo-typhoon-hama-usb20-device.patch
-dvb-sparse-warnings-on-one-bit-bitfields.patch
-dvb-support-nova-s-rev-22.patch
-dvb-ttusb_dec-cleanup.patch
-dvb-gcc-295-compile-fixes.patch
-dvb-mt352-cleanups.patch
-ext3-jbd-race-releasing-in-use-journal_heads.patch
-ext3-writepages-support-for-writeback-mode.patch
-ext3-writeback-nobh-option.patch
-ext3-fix-journal_unmap_buffer-race.patch
-generic-serial-cli-conversion.patch
-specialix-io8-cli-conversion.patch
-sx-cli-conversion.patch
-au1x00_uart-deadlock-fix.patch
-pm2fb-x-and-vt-switching-crash-fix.patch
-nvidiafb-process-boot-options-earlier.patch
-nvidiafb-delete-i2c-bus-on-driver-unload.patch
-fix-pm_message_t-in-generic-code.patch
-fix-u32-vs-pm_message_t-in-usb.patch
-more-pm_message_t-fixes.patch
-fix-u32-vs-pm_message_t-confusion-in-oss.patch
-fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
-fix-u32-vs-pm_message_t-confusion-in-framebuffers.patch
-fix-u32-vs-pm_message_t-confusion-in-mmc.patch
-fix-u32-vs-pm_message_t-confusion-in-serials.patch
-fix-u32-vs-pm_message_t-in-macintosh.patch
-fix-u32-vs-pm_message_t-confusion-in-agp.patch

 Merged

+nfs-fix-typo-in-access-caching-code.patch

 nfs client fix

+bk-driver-core-noisiness.patch

 Avoid bk-driver-core logspamming

+fix-typo-in-scdrv_init.patch

 Fix a typo

+fix-ver_linux-script-for-no-udev-utils.patch

 ver_linux fix

+use-cross_compileinstallkernel-in-arch-boot-installsh.patch

 kbuild update

+kconfig-i18n-support.patch

 Permit internationalisation of Kconfig text.

+libata-flush-comreset-set-and-clear.patch

 Sata fix

+pcnet32-79c975-fiber-fix.patch
+drivers-net-smc-mcac-cleanups.patch

 net driver updates

+drivers-scsi-dptih-remove-kernel-22-ifs.patch

 scsi cleanup

-open-iscsi-scsi.patch
-open-iscsi-headers.patch
-open-iscsi-kconfig.patch
-open-iscsi-makefile.patch
-open-iscsi-netlink.patch
-open-iscsi-doc.patch

 There seemed little point in retaining these in -mm.

-usb-wacom-driver-update.patch
+usb-wacom-tablet-driver.patch
+add-new-wacom-device-to-usb-hid-core-list.patch

 Wacom tablet driver updates

+pm-support-for-zd1201.patch
+bug-fix-in-usbdevfs.patch

 usb fixes

+remove-non-discontig-use-of-pgdat-node_mem_map.patch

 discontigmem cleanup

+resubmit-sparsemem-base-early_pfn_to_nid-works-before-sparse-is-initialized.patch
+resubmit-sparsemem-base-simple-numa-remap-space-allocator.patch
+resubmit-sparsemem-base-reorganize-page-flags-bit-operations.patch
+resubmit-sparsemem-base-teach-discontig-about-sparse-ranges.patch

 Preparatory support for `sparesemem' - a way of permitting gaps in the
 per-node mem_map[] pageframe array.

+read_kmem-fixes.patch

 /dev/kmem fix

+cpusets-special-case-gfp_atomic-allocs.patch
+cpusets-gfp_atomic-fix-tonedown-panic-comment.patch
+cpuset-make-function-decl-ansi.patch

 cpusets fixes

+filemap_getpage-can-block-when-map_nonblock-specified.patch

 Make filemap_getpage() honour MAP_NONBLOCK correctly.

+add-kmalloc_node-inline-cleanup.patch

 slab feature work for NUMA.

+orinoco-merge-updates-part-the-fourth-wireless-stats-updates.patch
+orinoco-merge-updates-part-the-fourth-ignore_disconnect-flag.patch
+orinoco-merge-updates-part-the-fourth-kill-dump_recs.patch
+orinoco-merge-updates-part-the-fourth-dont-set-channel-in-managed-mode.patch
+orinoco-merge-updates-part-the-fourth-consolidate-allocation-code.patch

 net driver update

+ppp-multilink-fragmentation-improvements.patch

 ppp multilink fixes and improvements.

+e100-use-eeprom-config-for-auto-mdi-mdi-x.patch

 e100 fix.

+ppc32-remove-unnecessary-test-in-mpc52xx-reset-code.patch
+ppc32-remove-the-ocp-system-from-the-freescale-mpc52xx.patch
+ppc32-change-constants-style-in-freescale-mpc52xx.patch
+ppc32-use-platform-bus--ppc_sys-model-for-freescale.patch
+serial-update-mpc52xx_uartc-to-use-platform-bus.patch
+ppc32-adds-necessary-cpu-init-to-use-usb-on-lite5200.patch
+ppc32-cleanup-of-book-e-exception-handling.patch
+ppc32-cpm2-pic-cleanup.patch
+ppc32-cpm2-pic-cleanup-irq_to_siubit-array-updated.patch
+ppc32-fix-mpc8555-mpc8555e-device-lists-updated.patch
+ppc32-mpc8555-cpm2-size-pointers-for-fccs-aka-all-ones-problem.patch

 ppc32 updates

+seccomp-for-ppc64.patch
+ppc64-fix-zilog-link-error.patch
+ppc64-add-mem=x-boot-command-line-option.patch

 ppc64 updates

-reduce-inlined-x86-memcpy-by-2-bytes.patch
+fix-i386-memcpy.patch

 More x86 memcpy() improvements.

+arch-i386-kernel-smpc-remove-a-pointless-inline.patch

 Little cleanup.

+i386-x86_64-segment-register-access-update.patch

 Make the kernel play better with current binutils (still being discussed)

+rfc-check-nmi-watchdog-is-broken.patch

 nmi watchdog fix

+x86_64-remove-duplicated-sys_time64.patch
+x86_64-remove-dup-syscall.patch

 x86_64 fixlets

+m32r-fix-spinlockh-for-config_debug_spinlock.patch
+m32r-build-fix-for-config_discontigmem.patch

 m32r fixes

+uml-fix-sigio-spinlock.patch
+uml-gprof-depends-on-tt.patch
+uml-quick-fix-syscall-table.patch
+uml-fixes-a-build-failure-with-config_mode_skas-disabled.patch
+uml-fix-hostfs-special-perm-handling.patch
+uml-correct-error-message.patch
+uml-fix-the-console-stuttering.patch

 UML updates

+async-io-using-rt-signals.patch

 signal fix

+make-documentation-oops-tracingtxt-relevant-to-26.patch

 documentation fix

+kernel-paramc-dont-use-max-when-num-is-null-in.patch

 kernel parameter handling fix

+fix-module_param_string-calls.patch

 module_param fix

+kill-stupid-warning-when-compiling-riocmdc.patch

 warning fix

+kernel-rcupdatec-make-the-exports-export_symbol_gpl.patch

 RCU is GPL-only.

+nommuc-build-error-fix.patch

 nommu build fix

+parport-oops-fix.patch

 parport fix

+use-cheaper-elv_queue_empty-when-unplug-a-device.patch

 elevator microoptimisation

+kprobe_handler-should-check-pre_handler-function.patch

 kprobe fix

+iput-can-sleep.patch

 Update a comment.

+zr36050-typo-fix.patch

 Fix this driver

+fixup-newly-added-jsm-driver.patch

 Tidy up this driver

+ext2-corruption-regression-between-269-and-2610.patch

 ext2 fix

-inotify-42.patch
+inotify-43.patch

 inotify update

+kfree-null-pointer-cleanups-no-need-to-check-fs-ext3.patch

 ext3 kfree tweaks

+rock-handle-directory-overflows-fix.patch

 Fix the isofs code in -mm.

-figure-out-who-is-inserting-bogus-modules-warning-fix.patch

 Folded into figure-out-who-is-inserting-bogus-modules.patch

+perfctr-mapped-state-cleanup-x86.patch
+perfctr-mapped-state-cleanup-ppc32.patch
+perfctr-mapped-state-cleanup-common.patch

 perfctr cleanups

-crashdump-documentation.patch
-crashdump-memory-preserving-reboot-using-kexec.patch
-crashdump-routines-for-copying-dump-pages.patch
-crashdump-routines-for-copying-dump-pages-fixes.patch
-crashdump-elf-format-dump-file-access.patch
-crashdump-linear-raw-format-dump-file-access.patch
-crashdump-linear-raw-format-dump-file-access-coding-style.patch
-kdump-export-crash-notes-section-address-through-build-fix.patch
+kdump-nmi-handler-segment-selector-stack.patch
+kdump-documentation-for-kdump.patch
+kdump-retrieve-saved-max-pfn.patch
+kdump-kconfig-for-kdump.patch
+kdump-routines-for-copying-dump-pages.patch
+kdump-retrieve-elfcorehdr-address-from-command.patch
+kdump-access-dump-file-in-elf-format.patch
+kdump-parse-elf32-headers-and-export-through.patch
+kdump-accessing-dump-file-in-linear-raw-format.patch
+kdump-cleanups-for-dump-file-access-in-linear.patch

 Updated crashdump code

-reiser4-export-inode_lock-unexport-__iget.patch
-reiser4-perthread-pages.patch
-reiser4-perthread_pages_alloc-cleanup.patch
-fs-reiser4-possible-cleanups.patch
-reiser4-cleanup-pg_arch_1.patch
-reiser4-build-fix.patch
-reiser4-update.patch
-reiser4-only-memory_backed-fix.patch

 New reiser4 code drop

+nvidiafb-fix-section-references.patch
+nvidiafb-process-boot-options-earlier.patch
+nvidiafb-delete-i2c-bus-on-driver-unload.patch
+pm2fb-x-and-vt-switching-crash-fix.patch
+fix-matroxfb-on-big-endian-hardware.patch
+radeonfb-fix-mode-setting-on-crt-monitors.patch
+radeonfb-preserve-tmds-setting.patch
+fix-atyfb-build-on-ppc.patch

 fbdev updates

+md-optimised-resync-using-bitmap-based-intent-logging-mempool-fix.patch

 Fix md-optimised-resync-using-bitmap-based-intent-logging.patch for some
 Linus changes.

+i386-x86_64-early_printkc-make-early_serial_base-static.patch
+kernel-exitc-make-exit_mm-static.patch

 Make some thing static

+net-atm-resourcesc-remove-__free_atm_dev.patch
+fix-ncr53c9xc-compile-warning.patch

 Little fixes

-net-atm-resourcesc-remove-__free_atm_dev.patch

 Dropped, for some reason.

+unexport-idle_cpu.patch

 unexport idle_cpu.




number of patches in -mm: 636
number of changesets in external trees: 746
number of patches in -mm only: 614
total patches: 1360



All 636 patches:


linus.patch

arm-atomic_sub_and_test.patch
  arm atomic_sub_and_test()

nfs-fix-typo-in-access-caching-code.patch
  NFS: Fix typo in access caching code

ia64-msi-warning-fixes.patch
  ia64 msi warning fixes

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

bk-acpi.patch

acpi-ec-warning-fix.patch
  acpi ec.c warning fix

acpi-toshiba-failure-handling.patch
  acpi: Toshiba failure handling

acpi-video-pointer-size-fix.patch
  acpi video pointer size fix

acpi-create_polling_proc-fix.patch
  acpi: create_polling_proc() fix

bk-agpgart.patch

agp-fix-for-xen-vmm.patch
  AGP fix for Xen VMM

include-linux-soundcardh-endianness-fix.patch
  include/linux/soundcard.h: endianness fix

bk-audit.patch

bk-cpufreq.patch

powernow-k7recalibrate-cpu_khz.patch
  powernowk7: recalibrate cpu_khz

cpufreq-timers-recalibrate_cpu_khz.patch
  cpufreq timers: recalibrate cpu_khz

bk-driver-core.patch

bk-driver-core-noisiness.patch
  bk-driver-core-noisiness

fix-typo-in-scdrv_init.patch
  Fix typo in scdrv_init()

export-platform_add_devices.patch
  export platform_add_devices

fix-ver_linux-script-for-no-udev-utils.patch
  Fix ver_linux script for no udev utils.

bk-drm.patch

bk-drm-via.patch

bk-i2c.patch

bk-ia64.patch

bk-ide-dev.patch

bk-input.patch

alps-printk-tidy.patch
  alps-printk-tidy

bk-kbuild.patch

uml-make-deb-pkg-build-target-build-a-debian-style-user-mode-linux-package.patch
  uml: make deb-pkg build target build a Debian-style user-mode-linux package

uml-restore-proper-descriptions-in-make-deb-pkg-target.patch
  UML - Restore proper descriptions in make deb-pkg target

doc-describe-kbuild-pitfall.patch
  doc: describe Kbuild pitfall

use-cross_compileinstallkernel-in-arch-boot-installsh.patch
  use ${CROSS_COMPILE}installkernel in arch/*/boot/install.sh

kconfig-i18n-support.patch
  Kconfig i18n support

complete-cpufreq-kconfig-cleanup.patch
  complete cpufreq Kconfig cleanup

libata-flush-comreset-set-and-clear.patch
  libata: flush COMRESET set and clear

bk-mtd.patch

bk-net.patch

bk-netdev.patch

pcnet32-79c975-fiber-fix.patch
  pcnet32: 79C975 fiber fix

drivers-net-smc-mcac-cleanups.patch
  drivers/net/smc-mca.c: cleanups

bk-nfs.patch

bk-ntfs.patch

bk-pci.patch

debug-for-pci-io-mem-allocation.patch
  DEBUG for PCI IO & MEM allocation

pci-pci-transparent-bridge-handling-improvements-pci-core.patch
  PCI-PCI transparent bridge handling improvements (pci core)

pci-pci-transparent-bridge-handling-improvements-yenta_socket.patch
  PCI-PCI transparent bridge handling improvements (yenta_socket)

acpi-bridge-hotadd-acpi-based-root-bridge-hot-add.patch
  acpi bridge hotadd: ACPI based root bridge hot-add

acpi-bridge-hotadd-fix-pci_enable_device-for-p2p-bridges.patch
  acpi bridge hotadd: Fix pci_enable_device() for p2p bridges

acpi-bridge-hotadd-make-pcibios_fixup_bus-hot-plug-safe.patch
  acpi bridge hotadd: Make pcibios_fixup_bus() hot-plug safe

acpi-bridge-hotadd-prevent-duplicate-bus-numbers-when-scanning-pci-bridge.patch
  acpi bridge hotadd: Prevent duplicate bus numbers when scanning PCI bridge

acpi-bridge-hotadd-take-the-pci-lock-when-modifying-pci-bus-or-device-lists.patch
  acpi bridge hotadd: Take the PCI lock when modifying pci bus or device lists

acpi-bridge-hotadd-link-newly-created-pci-child-bus-to-its-parent-on-creation.patch
  acpi bridge hotadd: Link newly created pci child bus to its parent on creation

acpi-bridge-hotadd-make-the-pci-remove-routines-safe-for-failed-hot-plug.patch
  acpi bridge hotadd: Make the PCI remove routines safe for failed hot-plug

acpi-bridge-hotadd-remove-hot-plugged-devices-that-could-not-be-allocated-resources.patch
  acpi bridge hotadd: Remove hot-plugged devices that could not be allocated resources

acpi-bridge-hotadd-read-bridge-resources-when-fixing-up-the-bus.patch
  acpi bridge hotadd: Read bridge resources when fixing up the bus

acpi-bridge-hotadd-allow-acpi-add-and-start-operations-to-be-done-independently.patch
  acpi bridge hotadd: Allow ACPI .add and .start operations to be done independently

acpi-bridge-hotadd-export-the-interface-to-get-pci-id-for-an-acpi-handle.patch
  acpi bridge hotadd: Export the interface to get PCI id for an ACPI handle

bk-scsi.patch

drivers-scsi-dptih-remove-kernel-22-ifs.patch
  drivers/scsi/dpti.h: remove kernel 2.2 #if's

megaraid_sas-announcing-new-module-for.patch
  megaraid_sas: new module for LSI Logic's SAS based MegaRAID controllers

add-scsi-changer-driver.patch
  add scsi changer driver

scsi-ch-build-fix.patch
  scsi ch.c build fix

bk-serial.patch

usb-wacom-tablet-driver.patch
  usb wacom tablet driver

add-new-wacom-device-to-usb-hid-core-list.patch
  add new wacom device to usb hid-core list

usb_cdc-build-fix.patch
  usb_cdc build fix

usb-resume-fixes.patch
  usb resume fixes

usb-suspend-updates-interface-suspend.patch
  usb suspend updates (interface suspend)

hcd-suspend-uses-pm_message_t.patch
  hcd suspend uses pm_message_t

zd1201-build-fix.patch
  zd1201 build fix

usb-support-for-new-ipod-mini-and-possibly-others.patch
  usb: support for new ipod mini (and possibly others)

pm-support-for-zd1201.patch
  PM support for zd1201

bug-fix-in-usbdevfs.patch
  bug fix in usbdevfs

bk-watchdog.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-help-for-acpi_container.patch
  Fix help for ACPI_CONTAINER

swapspace-layout-improvements.patch
  swapspace-layout-improvements
  /proc/swaps negative Used

bdi-provide-backing-device-capability-information.patch
  BDI: Provide backing device capability information [try #3]

cpusets-big-numa-cpu-and-memory-placement-backing_dev-fix.patch
  cpusets-big-numa-cpu-and-memory-placement-backing_dev-fix

add-a-clear_pages-function-to-clear-pages-of-higher.patch
  add a clear_pages function to clear pages of higher order

vmscan-notice-slab-shrinking.patch
  vmscan: notice slab shrinking

madvise-do-not-split-the-maps.patch
  madvise: do not split the maps

madvise-merge-the-maps.patch
  madvise: merge the maps

freepgt-free_pgtables-use-vma-list.patch
  freepgt: free_pgtables use vma list

freepgt-remove-mm_vm_sizemm.patch
  freepgt: remove MM_VM_SIZE(mm)

freepgt-hugetlb_free_pgd_range.patch
  freepgt: hugetlb_free_pgd_range

freepgt-hugetlb_free_pgd_range-fix-aio-panic-fix.patch
  ppc64-fix-aio-panic-caused-by-is_hugepage_only_range-ia64-fix

freepgt-remove-arch-pgd_addr_end.patch
  freepgt: remove arch pgd_addr_end

freepgt-mpnt-to-vma-cleanup.patch
  freepgt: mpnt to vma cleanup

freepgt-hugetlb-area-is-clean.patch
  freepgt: hugetlb area is clean

remove-non-discontig-use-of-pgdat-node_mem_map.patch
  remove non-DISCONTIG use of pgdat->node_mem_map

resubmit-sparsemem-base-early_pfn_to_nid-works-before-sparse-is-initialized.patch
  sparsemem base: early_pfn_to_nid() (works before sparse is initialized)

resubmit-sparsemem-base-simple-numa-remap-space-allocator.patch
  sparsemem base: simple NUMA remap space allocator

resubmit-sparsemem-base-reorganize-page-flags-bit-operations.patch
  sparsemem base: reorganize page->flags bit operations

resubmit-sparsemem-base-teach-discontig-about-sparse-ranges.patch
  sparsemem base: teach discontig about sparse ranges

read_kmem-fixes.patch
  read_kmem() fixes

cpusets-special-case-gfp_atomic-allocs.patch
  cpusets: special-case GFP_ATOMIC allocs

cpusets-gfp_atomic-fix-tonedown-panic-comment.patch
  cpusets GFP_ATOMIC fix: tonedown panic comment

cpuset-make-function-decl-ansi.patch
  cpuset: make function decl. ANSI

filemap_getpage-can-block-when-map_nonblock-specified.patch
  filemap_getpage can block when MAP_NONBLOCK specified

add-kmalloc_node-inline-cleanup.patch
  add kmalloc_node, inline cleanup

eni155p-error-handling-fix.patch
  ENI155P error handling fix

a-new-10gb-ethernet-driver-by-chelsio-communications.patch
  A new 10GB Ethernet Driver by Chelsio Communications

dm9000-network-driver.patch
  DM9000 network driver

e1000-flush-work-queues-on-remove.patch
  e1000: flush work queues on remove

drivers-net-amd8111ec-fix-napi-interrupt-in-poll.patch
  drivers/net/amd8111e.c: fix NAPI interrupt in poll

orinoco-merge-updates-part-the-fourth-wireless-stats-updates.patch
  Orinoco merge updates: wireless stats updates

orinoco-merge-updates-part-the-fourth-ignore_disconnect-flag.patch
  Orinoco merge updates: ignore_disconnect flag

orinoco-merge-updates-part-the-fourth-kill-dump_recs.patch
  Orinoco merge updates: kill dump_recs

orinoco-merge-updates-part-the-fourth-dont-set-channel-in-managed-mode.patch
  Orinoco merge updates: don't set channel in managed mode

orinoco-merge-updates-part-the-fourth-consolidate-allocation-code.patch
  Orinoco merge updates: consolidate allocation code

ppp-multilink-fragmentation-improvements.patch
  PPP multilink fragmentation improvements

e100-use-eeprom-config-for-auto-mdi-mdi-x.patch
  e100: Use EEPROM config for Auto MDI/MDI-X

ppc32-remove-unnecessary-test-in-mpc52xx-reset-code.patch
  ppc32: Remove unnecessary test in MPC52xx reset code

ppc32-remove-the-ocp-system-from-the-freescale-mpc52xx.patch
  ppc32: Remove the OCP system from the Freescale MPC52xx support

ppc32-change-constants-style-in-freescale-mpc52xx.patch
  ppc32: Change constants style in Freescale MPC52xx related code

ppc32-use-platform-bus--ppc_sys-model-for-freescale.patch
  ppc32: Use platform bus / ppc_sys model for Freescale MPC52xx

serial-update-mpc52xx_uartc-to-use-platform-bus.patch
  serial: Update mpc52xx_uart.c to use platform bus

ppc32-adds-necessary-cpu-init-to-use-usb-on-lite5200.patch
  ppc32: Adds necessary cpu init to use USB on LITE5200 Platform

ppc32-cleanup-of-book-e-exception-handling.patch
  ppc32: cleanup of Book-E exception handling

ppc32-cpm2-pic-cleanup.patch
  ppc32: CPM2 PIC cleanup

ppc32-cpm2-pic-cleanup-irq_to_siubit-array-updated.patch
  ppc32: CPM2 PIC cleanup irq_to_siubit array

ppc32-fix-mpc8555-mpc8555e-device-lists-updated.patch
  ppc32: Fix MPC8555 & MPC8555E device lists (updated)

ppc32-mpc8555-cpm2-size-pointers-for-fccs-aka-all-ones-problem.patch
  ppc32: MPC8555 CPM2 size/pointers for FCCs aka "All-ones problem"

seccomp-for-ppc64.patch
  seccomp for ppc64

ppc64-fix-zilog-link-error.patch
  ppc64: fix zilog link error

ppc64-add-mem=x-boot-command-line-option.patch
  ppc64: Add mem=X boot command line option

x86-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  x86: reduce cacheline bouncing in cpu_idle_wait

x86-via-workaround.patch
  x86: via workaround

x86-fix-esp-corruption-cpu-bug-take-2.patch
  x86: fix ESP corruption CPU bug (take 2)

fix-i386-memcpy.patch
  fix i386 memcpy

arch-i386-kernel-smpc-remove-a-pointless-inline.patch
  arch/i386/kernel/smp.c: remove a pointless "inline"

i386-x86_64-segment-register-access-update.patch
  i386/x86_64 segment register access update

rfc-check-nmi-watchdog-is-broken.patch
  check nmi watchdog is broken

x86_64-avoid-panic-lockup.patch
  x86_64: avoid panic lockup

x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  x86_64: reduce cacheline bouncing in cpu_idle_wait

x86-64-kprobes-handle-%rip-relative-addressing-mode.patch
  x86-64 kprobes: handle %RIP-relative addressing mode

x86-x86_64-reading-deterministic-cache-parameters-and-exporting-it-in-sysfs.patch
  x86, x86_64: reading deterministic cache parameters and exporting it in /sysfs

x86-x86_64-intel-dual-core-detection.patch
  x86, x86_64: Intel dual-core detection

x86-cacheline-alignment-for-cpu-maps.patch
  x86: cacheline alignment for cpu maps

x86_64-show_stack-touch_nmi_watchdog.patch
  x86_64 show_stack(): call touch_nmi_watchdog

x86_64-remove-duplicated-sys_time64.patch
  x86_64: remove duplicated sys_time64

x86_64-remove-dup-syscall.patch
  x86_64: remove dup syscall

ia64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  ia64: reduce cacheline bouncing in cpu_idle_wait

m32r-fix-spinlockh-for-config_debug_spinlock.patch
  m32r: Fix spinlock.h for CONFIG_DEBUG_SPINLOCK

m32r-build-fix-for-config_discontigmem.patch
  m32r: build fix for CONFIG_DISCONTIGMEM

uml-fix-sigio-spinlock.patch
  uml: fix sigio spinlock

uml-gprof-depends-on-tt.patch
  uml: gprof depends on !TT

uml-quick-fix-syscall-table.patch
  uml: quick fix syscall table

uml-fixes-a-build-failure-with-config_mode_skas-disabled.patch
  uml: fixes a build failure with CONFIG_MODE_SKAS disabled

uml-fix-hostfs-special-perm-handling.patch
  uml: fix hostfs special perm handling

uml-correct-error-message.patch
  uml: correct error message

uml-fix-the-console-stuttering.patch
  uml: Fix the console stuttering

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

mtrr-size-and-base-debug.patch
  mtrr size-and-base debugging

iounmap-debugging.patch
  iounmap debugging

detect-soft-lockups.patch
  detect soft lockups

detect-soft-lockups-from-touch_nmi_watchdog.patch
  detect-soft-lockups: call from touch_nmi_watchdog

areca-raid-linux-scsi-driver.patch
  ARECA RAID Linux scsi driver

rt-lsm.patch
  RT-LSM

tty-output-lossage-fix.patch
  tty output lossage fix

cx24110-conexant-frontend-update.patch
  cx24110 Conexant Frontend update

nice-and-rt-prio-rlimits.patch
  nice and rt-prio rlimits

relayfs.patch
  relayfs

relayfs-properly-handle-oversized-events.patch
  relayfs: properly handle oversized events

relayfs-backing_dev-fix.patch
  relayfs-backing_dev-fix

cfq-iosched-update-to-time-sliced-design.patch
  cfq-iosched: update to time sliced design

cfq-iosched-update-to-time-sliced-design-export-task_nice.patch
  cfq-iosched-update-to-time-sliced-design-export-task_nice

cfq-iosched-update-to-time-sliced-design-fix.patch
  cfq-iosched-update-to-time-sliced-design fix

cfq-iosched-update-to-time-sliced-design-fix-fix.patch
  cfq-iosched-update-to-time-sliced-design-fix-fix

cfq-iosched-update-to-time-sliced-design-use-bio_data_dir.patch
  cfq-iosched-update-to-time-sliced-design: use bio_data_dir()

cfq-ioschedc-fix-soft-hang-with-non-fs-requests.patch
  cfq-iosched.c: fix soft hang with non-fs requests

keys-discard-key-spinlock-and-use-rcu-for-key-payload.patch
  keys: Discard key spinlock and use RCU for key payload

keys-discard-key-spinlock-and-use-rcu-for-key-payload-try-4.patch
  keys: Discard key spinlock and use RCU for key payload - try #4

keys-pass-session-keyring-to-call_usermodehelper.patch
  Keys: Pass session keyring to call_usermodehelper()

keys-pass-session-keyring-to-call_usermodehelper-fix.patch
  keys-pass-session-keyring-to-call_usermodehelper fix

keys-use-rcu-to-manage-session-keyring-pointer.patch
  Keys: Use RCU to manage session keyring pointer

keys-make-request-key-create-an-authorisation-key.patch
  Keys: Make request-key create an authorisation key

binfmt_elf-bss-padding-fix.patch
  binfmt_elf bss padding fix

timers-prepare-for-del_timer_sync-changes.patch
  timers: prepare for del_timer_sync() changes

timers-rework-del_timer_sync.patch
  timers: rework del_timer_sync()

timers-serialize-timers.patch
  timers: serialize timers

timers-remove-memory-barriers.patch
  timers: remove memory barriers

timers-cleanup-kill-__get_base.patch
  timers: cleanup, kill __get_base()

timers-enable-irqs-in-__mod_timer.patch
  timers: enable irqs in __mod_timer()

timers-enable-irqs-in-__mod_timer-tidy.patch
  timers-enable-irqs-in-__mod_timer-tidy

enable-sig_ign-on-blocked-signals.patch
  Enable SIG_IGN on blocked signals

consolidate-asm-ipch.patch
  consolidate asm/ipc.h

sx-cli-conversion.patch
  SX cli() conversion

async-io-using-rt-signals.patch
  AYSNC IO using singals other than SIGIO

make-documentation-oops-tracingtxt-relevant-to-26.patch
  make Documentation/oops-tracing.txt relevant to 2.6

kernel-paramc-dont-use-max-when-num-is-null-in.patch
  kernel/param.c: don't use .max when .num is NULL in param_array_set()

fix-module_param_string-calls.patch
  fix module_param_string() calls

kill-stupid-warning-when-compiling-riocmdc.patch
  Kill stupid warning when compiling riocmd.c

kernel-rcupdatec-make-the-exports-export_symbol_gpl.patch
  kernel/rcupdate.c: make the exports EXPORT_SYMBOL_GPL

nommuc-build-error-fix.patch
  nommu.c build error fix

parport-oops-fix.patch
  paport oops fix

use-cheaper-elv_queue_empty-when-unplug-a-device.patch
  use cheaper elv_queue_empty when unplug a device

kprobe_handler-should-check-pre_handler-function.patch
  kprobe_handler should  check pre_handler function

iput-can-sleep.patch
  iput() can sleep

zr36050-typo-fix.patch
  zr36050 typo fix

fixup-newly-added-jsm-driver.patch
  fix up newly added jsm driver

ext2-corruption-regression-between-269-and-2610.patch
  ext2 corruption - regression between 2.6.9 and 2.6.10

inotify-43.patch
  inotify update.

ext3-dynamic-allocating-block-reservation-info.patch
  ext3: dynamic allocation of block reservation info

ext3-reservation-info-cleanup-remove-rsv_seqlock.patch
  ext3: reservation info cleanup: remove rsv_seqlock

ext3-reservation-info-cleanup-remove-rsv_seqlock-fix.patch
  ext3-reservation-info-cleanup-remove-rsv_seqlock fix

ext3-move-goal-logical-block-into-block-allocation-info.patch
  ext3: move goal logical block into block allocation info structure

kfree-null-pointer-cleanups-no-need-to-check-fs-ext3.patch
  kfree() NULL pointer cleanups - no need to check - fs/ext3/

pcmcia-hotplug-event-for-pcmcia-devices.patch
  pcmcia: hotplug event for PCMCIA devices

pcmcia-hotplug-event-for-pcmcia-socket-devices.patch
  pcmcia: hotplug event for PCMCIA socket devices

pcmcia-device-and-driver-matching.patch
  pcmcia: device and driver matching

pcmcia-check-for-invalid-crc32-hashes-in-id_tables.patch
  pcmcia: check for invalid crc32 hashes in id_tables

pcmcia-match-for-fake-cis.patch
  pcmcia: match for fake CIS

pcmcia-export-cis-in-sysfs.patch
  pcmcia: export CIS in sysfs

pcmcia-cis-overrid-via-sysfs.patch
  pcmcia: CIS overrid via sysfs

pcmcia-match-anonymous-cards.patch
  pcmcia: match "anonymous" cards

pcmcia-allow-function-id-based-match.patch
  pcmcia: allow function-ID based match

pcmcia-file2alias.patch
  pcmcia: file2alias

pcmcia-request-cis-via-firmware-interface.patch
  pcmcia: request CIS via firmware interface

pcmcia-cleanups.patch
  pcmcia: cleanups

pcmcia-rescan-bus-always-upon-echoing-into-setup_done.patch
  pcmcia: rescan bus always upon echoing into setup_done

pcmcia-id_table-for-serial_cs.patch
  pcmcia: id_table for serial_cs

pcmcia-id_table-for-3c574_cs.patch
  pcmcia: id_table for 3c574_cs

pcmcia-id_table-for-3c589_cs.patch
  pcmcia: id_table for 3c589_cs

pcmcia-id_table-for-aha152x.patch
  pcmcia: id_table for aha152x

pcmcia-id_table-for-airo_cs.patch
  pcmcia: id_table for airo_cs

pcmcia-id_table-for-axnet_cs.patch
  pcmcia: id_table for axnet_cs

pcmcia-id_table-for-fdomain_stub.patch
  pcmcia: id_table for fdomain_stub

pcmcia-id_table-for-fmvj18x_cs.patch
  pcmcia: id_table for fmvj18x_cs

pcmcia-id_table-for-ibmtr_cs.patch
  pcmcia: id_table for ibmtr_cs

pcmcia-id_table-for-netwave_cs.patch
  pcmcia: id_table for netwave_cs

pcmcia-id_table-for-nmclan_cs.patch
  pcmcia: id_table for nmclan_cs

pcmcia-id_table-for-teles_cs.patch
  pcmcia: id_table for teles_cs

pcmcia-id_table-for-ray_cs.patch
  pcmcia: id_table for ray_cs

pcmcia-id_table-for-wavelan_cs.patch
  pcmcia: id_table for wavelan_cs

pcmcia-id_table-for-sym53c500_csc.patch
  pcmcia: id_table for sym53c500_cs.c

pcmcia-id_table-for-qlogic_stubc.patch
  pcmcia: id_table for qlogic_stub.c

pcmcia-id_table-for-smc91c92_csc.patch
  pcmcia: id_table for smc91c92_cs.c

pcmcia-id_table-for-orinoco_cs.patch
  pcmcia: id_table for orinoco_cs

pcmcia-id_table-for-xirc2ps_csc.patch
  pcmcia: id_table for xirc2ps_cs.c

pcmcia-id_table-for-ide_csc.patch
  pcmcia: id_table for ide_cs.c

pcmcia-id_table-for-parport_csc.patch
  pcmcia: id_table for parport_cs.c

pcmcia-id_table-for-pcnet_csc.patch
  pcmcia: id_table for pcnet_cs.c

pcmcia-id_table-for-pcmciamtdc.patch
  pcmcia: id_table for pcmciamtd.c

pcmcia-id_table-for-vxpocketc.patch
  pcmcia: id_table for vxpocket.c

pcmcia-id_table-for-atmel_csc.patch
  pcmcia: id_table for atmel_cs.c

pcmcia-id_table-for-avma1_csc.patch
  pcmcia: id_table for avma1_cs.c

pcmcia-id_table-for-avm_csc.patch
  pcmcia: id_table for avm_cs.c

pcmcia-id_table-for-bluecard_csc.patch
  pcmcia: id_table for bluecard_cs.c

pcmcia-id_table-for-bt3c_csc.patch
  pcmcia: id_table for bt3c_cs.c

pcmcia-id_table-for-btuart_csc.patch
  pcmcia: id_table for btuart_cs.c

pcmcia-id_table-for-com20020_csc.patch
  pcmcia: id_table for com20020_cs.c

pcmcia-id_table-for-dtl1_csc.patch
  pcmcia: id_table for dtl1_cs.c

pcmcia-id_table-for-elsa_csc.patch
  pcmcia: id_table for elsa_cs.c

pcmcia-id_table-for-ixj_pcmciac.patch
  pcmcia: id_table for ixj_pcmcia.c

pcmcia-id_table-for-nsp_csc.patch
  pcmcia: id_table for nsp_cs.c

pcmcia-id_table-for-sedlbauer_csc.patch
  pcmcia: id_table for sedlbauer_cs.c

pcmcia-id_table-for-wl3501_csc.patch
  pcmcia: id_table for wl3501_cs.c

pcmcia-id_table-for-pdaudiocfc.patch
  pcmcia: id_table for pdaudiocf.c

pcmcia-id_table-for-synclink_csc.patch
  pcmcia: id_table for synclink_cs.c

pcmcia-add-some-documentation.patch
  pcmcia: add some Documentation

pcmcia-update-resource-database-adjust-routines-to-use-unsigned-long-values.patch
  pcmcia: update resource database adjust routines to use unsigned long values

pcmcia-mark-parent-bridge-windows-as-resources-available-for-pcmcia-devices.patch
  pcmcia: mark parent bridge windows as resources available for PCMCIA devices

pcmcia-add-a-config-option-for-the-pcmica-ioctl.patch
  pcmcia: add a config option for the PCMICA ioctl

pcmcia-move-pcmcia-ioctl-to-a-separate-file.patch
  pcmcia: move PCMCIA ioctl to a separate file

pcmcia-clean-up-cs-ds-callback.patch
  pcmcia: clean up cs ds callback

pcmcia-clean-up-cs-ds-callback-fix.patch
  pcmcia-clean-up-cs-ds-callback-fix

pcmcia-make-pcmcia-status-a-bitfield.patch
  pcmcia: make PCMCIA status a bitfield

pcmcia-merge-struct-pcmcia_bus_socket-into-struct-pcmcia_socket.patch
  pcmcia: merge struct pcmcia_bus_socket into struct pcmcia_socket

pcmcia-remove-unneeded-includes-in-dsc.patch
  pcmcia: remove unneeded includes in ds.c

pcmcia-rename-some-functions.patch
  pcmcia: rename some functions

pcmcia-move-pcmcia-resource-handling-out-of-csc.patch
  pcmcia: move pcmcia resource handling out of cs.c

pcmcia-csc-cleanup.patch
  pcmcia: cs.c cleanup

pcmcia-dsc-cleanup.patch
  pcmcia: ds.c cleanup

pcmcia-release_class.patch
  pcmcia: release_class

pcmcia-use-request_region-in-i82365.patch
  pcmcia: use request_region in i82365

pcmcia-synclink_cs-irq_info2_info-is-gone.patch
  pcmcia: synclink_cs IRQ_INFO2_INFO is gone

pcmcia-mod_devicetableh-fix-for-different-sizes-in-kernel-and-userspace.patch
  pcmcia: mod_devicetable.h fix for different sizes in kernel- and userspace

pcmcia-select-crc32-in-kconfig-for-pcmcia.patch
  pcmcia: select crc32 in Kconfig for PCMCIA

svcrpc-auth_domain-documentation.patch
  svcrpc: auth_domain documentation

nfsd4-fix-share-conflict-tests.patch
  nfsd4: fix share conflict tests

nfsd4-remove-unneeded-stateowner-arguments.patch
  nfsd4: remove unneeded stateowner arguments

nfsd4-fix-use-after-put-in-cb_recall.patch
  nfsd4: fix use after put() in cb_recall

nfsd4-allow-read-on-open-for-write.patch
  nfsd4: allow read on open for write

nfsd4-factor-out-common-open_truncate-code.patch
  nfsd4: factor out common open_truncate code

nfsd4-fix-failure-to-truncate-on-some-opens.patch
  nfsd4: fix failure to truncate on some opens

nfsd4_remove_unused_acl_function.patch
  nfsd4_remove_unused_acl_function

nfsd4-dont-set-write_owner-in-either-allow-or-deny-bits.patch
  nfsd4: don't set WRITE_OWNER in either allow or deny bits

nfsd4-acl-dont-set-named-attrs.patch
  nfsd4: acl don't set named attrs

nfsd4-acl-error-fix.patch
  nfsd4: acl error fix

nfsd4-rename-release_delegation.patch
  nfsd4: rename release_delegation

nfsd4-remove-trailing-whitespace-from-nfs4procc.patch
  nfsd4: remove trailing whitespace from nfs4proc.c

nfsd4-fix-open-returns-for-other-claim-types.patch
  nfsd4: fix open returns for other claim types

nfsd4-fix-indentation-in-nfsd4_open.patch
  nfsd4: fix indentation in nfsd4_open

nfsacl-solaris-nfsacl-workaround.patch
  nfsacl: Solaris nfsacl workaround

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
  kgdb: fix for recent gcc
  kgdb warning fixes
  THREAD_SIZE fixes for kgdb
  Fix stack overflow test for non-8k stacks
  kgdb-ga.patch fix for i386 single-step into sysenter
  fix TRAP_BAD_SYSCALL_EXITS on i386
  add TRAP_BAD_SYSCALL_EXITS config for i386
  kgdb-is-incompatible-with-kprobes
  kgdb-ga-build-fix
  kgdb-ga-fixes
  kgdb: kill off highmem_start_page
  kgdb documentation fix

kgdb-x86-config_debug_info-fix.patch
  kgdb CONFIG_DEBUG_INFO fix

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

kgdb-x86_64-config_debug_info-fix.patch
  kgdb CONFIG_DEBUG_INFO fix

rock-lindent.patch
  rock: lindent it

rock-manual-tidies.patch
  rock: manual tidies

rock-remove-CHECK_SP.patch
  rock: remove CHECK_SP

rock-remove-CONTINUE_DECLS.patch
  rock: remove CONTINUE_DECLS

rock-remove-CHECK_CE.patch
  rock: remove CHECK_CE

rock-remove-SETUP_ROCK_RIDGE.patch
  rock: remove SETUP_ROCK_RIDGE

rock-remove-MAYBE_CONTINUE.patch
  rock: remove MAYBE_CONTINUE

rock-comment-tidies.patch
  rock: comment tidies

rock-lindent-rock-h.patch
  rock: lindent rock.h

isofs-remove-debug-stuff.patch
  isofs: remove debug stuff

rock-handle-corrupted-directories.patch
  rock.c: handle corrupted directories

rock-rename-union-members.patch
  rock: rename union members

rock-handle-directory-overflows.patch
  rock: handle directory overflows

rock-handle-directory-overflows-fix.patch
  rock-handle-directory-overflows-fix

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

page-owner-tracking-leak-detector.patch
  Page owner tracking leak detector

make-page_owner-handle-non-contiguous-page-ranges.patch
  make page_owner handle non-contiguous page ranges

add-gfp_mask-to-page-owner.patch
  add gfp_mask to page owner

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

periodically-scan-redzone-entries-and-slab-control-structures.patch
  periodically scan redzone entries and slab control structures

slab-leak-detector.patch
  slab leak detector

slab-leak-detector-warning-fixes.patch
  slab leak detector warning fixes

irqpoll.patch
  irqpoll

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

releasing-resources-with-children.patch
  Releasing resources with children

perfctr-core.patch
  perfctr: core
  perfctr: remove bogus perfctr_sample_thread() calls

perfctr-i386.patch
  perfctr: i386

perfctr-x86-core-updates.patch
  perfctr x86 core updates

perfctr-x86-driver-updates.patch
  perfctr x86 driver updates

perfctr-x86-driver-cleanup.patch
  perfctr: x86 driver cleanup

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86-update-2.patch
  perfctr x86 update 2

perfctr-x86_64.patch
  perfctr: x86_64

perfctr-x86_64-core-updates.patch
  perfctr x86_64 core updates

perfctr-ppc.patch
  perfctr: PowerPC

perfctr-ppc32-driver-update.patch
  perfctr: ppc32 driver update

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

perfctr-ppc32-update.patch
  perfctr ppc32 update

perfctr-ppc32-update-2.patch
  perfctr ppc32 update

perfctr-virtualised-counters.patch
  perfctr: virtualised counters

perfctr-remap_page_range-fix.patch

virtual-perfctr-illegal-sleep.patch
  virtual perfctr illegal sleep

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr: Kconfig-related updates

perfctr-virtual-updates.patch
  perfctr virtual updates

perfctr-virtual-cleanup.patch
  perfctr: virtual cleanup

perfctr-ppc32-preliminary-interrupt-support.patch
  perfctr ppc32 preliminary interrupt support

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr: reduce stack usage

perfctr-interrupt-support-kconfig-fix.patch
  perfctr interrupt_support Kconfig fix

perfctr-low-level-documentation.patch
  perfctr low-level documentation

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance: driver updates

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

perfctr-api-changes-first-step.patch
  perfctr API changes: first step

perfctr-virtual-update.patch
  perfctr virtual update

perfctr-x86-64-ia32-emulation-fix.patch
  perfctr x86-64 ia32 emulation fix

perfctr-sysfs-update-1-4-core.patch
  perfctr sysfs update: core

perfctr-sysfs-update.patch
  Perfctr sysfs update

perfctr-sysfs-update-2-4-x86.patch
  perfctr sysfs update: x86

perfctr-sysfs-update-3-4-x86-64.patch
  perfctr sysfs update: x86-64
  perfctr: syscall numbers in x86-64 ia32-emulation
  perfctr x86_64 native syscall numbers fix

perfctr-sysfs-update-4-4-ppc32.patch
  perfctr sysfs update: ppc32

perfctr-2710-api-update-1-4-common.patch
  perfctr-2.7.10 API update 1/4: common

perfctr-2710-api-update-2-4-i386.patch
  perfctr-2.7.10 API update 2/4: i386

perfctr-2710-api-update-3-4-x86_64.patch
  perfctr-2.7.10 API update 3/4: x86_64

perfctr-2710-api-update-4-4-ppc32.patch
  perfctr-2.7.10 API update 4/4: ppc32

perfctr-api-update-1-9-physical-indexing-x86.patch
  perfctr API update 1/9: physical indexing, x86

perfctr-api-update-2-9-physical-indexing-ppc32.patch
  perfctr API update 2/9: physical indexing, ppc32

perfctr-api-update-3-9-cpu_control_header-x86.patch
  perfctr API update 3/9: cpu_control_header, x86

perfctr-api-update-4-9-cpu_control_header-ppc32.patch
  perfctr API update 4/9: cpu_control_header, ppc32

perfctr-api-update-5-9-cpu_control_header-common.patch
  perfctr API update 5/9: cpu_control_header, common

perfctr-api-update-6-9-cpu_control-access-common.patch
  perfctr API update 6/9: cpu_control access, common

perfctr-api-update-7-9-cpu_control-access-x86.patch
  perfctr API update 7/9: cpu_control access, x86

perfctr-api-update-8-9-cpu_control-access-ppc32.patch
  perfctr API update 8/9: cpu_control access, ppc32

perfctr-api-update-9-9-domain-based-read-write-syscalls.patch
  perfctr API update 9/9: domain-based read/write syscalls

perfctr-ia32-syscalls-on-x86-64-fix.patch
  perfctr ia32 syscalls on x86-64 fix

perfctr-cleanups-1-3-common.patch
  perfctr cleanups: common

perfctr-cleanups-2-3-ppc32.patch
  perfctr cleanups: ppc32

perfctr-cleanups-3-3-x86.patch
  perfctr cleanups: x86

perfctr-x86-fix-and-cleanups.patch
  perfctr: x86 fix and cleanups

perfctr-ppc32-fix-and-cleanups.patch
  perfctr: ppc32 fix and cleanups

perfctr-64-bit-values-in-register-descriptors.patch
  perfctr: 64-bit values in register descriptors

perfctr-64-bit-values-in-register-descriptors-fix.patch
  perfctr-64-bit-values-in-register-descriptors fix

perfctr-mapped-state-cleanup-x86.patch
  perfctr: mapped state cleanup: x86

perfctr-mapped-state-cleanup-ppc32.patch
  perfctr: mapped state cleanup: ppc32

perfctr-mapped-state-cleanup-common.patch
  perfctr: mapped state cleanup: common

sched2-fix-schedstats-warning.patch
  sched: fix schedstats warning

sched2-cleanup-wake_idle.patch
  sched: cleanup wake_idle

sched2-improve-load-balancing-pinned-tasks.patch
  sched: improve load balancing pinned tasks

sched2-reduce-active-load-balancing.patch
  sched: reduce active load balancing

sched2-fix-smt-scheduling-problems.patch
  sched: fix SMT scheduling problems

sched2-add-debugging.patch
  sched: add debugging

sched2-less-aggressive-idle-balancing.patch
  sched: less aggressive idle balancing

sched2-balance-timers.patch
  sched: balance timers

sched2-tweak-affine-wakeups.patch
  sched: tweak affine wakeups

sched2-no-aggressive-idle-balancing.patch
  sched: no aggressive idle balancing

sched2-balance-on-fork.patch
  sched: balance on fork

sched2-schedstats-update-for-balance-on-fork.patch
  sched: schedstats update for balance on fork

sched2-sched-tuning.patch
  sched: sched tuning

sched2-sched-tuning-fix.patch
  sched2-sched-tuning-fix

sched2-sched-domain-sysctl.patch
  sched: sched domain sysctl

sched-uninline-task_timeslice.patch
  sched: uninline task_timeslice

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm
  ppc64: fix hotplug cpu

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

numa-policies-for-file-mappings-mpol_mf_move-cachefs.patch
  numa-policies-for-file-mappings-mpol_mf_move for cachefs

cachefs-release-search-records-lest-they-return-to-haunt-us.patch
  CacheFS: release search records lest they return to haunt us

fix-64-bit-problems-in-cachefs.patch
  Fix 64-bit problems in cachefs

cachefs-fixed-typos-that-cause-wrong-pointer-to-be-kunmapped.patch
  cachefs: fixed typos that cause wrong pointer to be kunmapped

cachefs-return-the-right-error-upon-invalid-mount.patch
  CacheFS: return the right error upon invalid mount

fix-cachefs-barrier-handling-and-other-kernel-discrepancies.patch
  Fix CacheFS barrier handling and other kernel discrepancies

remove-error-from-linux-cachefsh.patch
  Remove #error from linux/cachefs.h

cachefs-warning-fix-2.patch
  cachefs warning fix 2

cachefs-linkage-fix-2.patch
  cachefs linkage fix

cachefs-build-fix.patch
  cachefs build fix

cachefs-documentation.patch
  CacheFS documentation

add-page-becoming-writable-notification.patch
  Add page becoming writable notification

add-page-becoming-writable-notification-fix.patch
  do_wp_page_mk_pte_writable() fix

add-page-becoming-writable-notification-build-fix.patch
  add-page-becoming-writable-notification build fix

provide-a-filesystem-specific-syncable-page-bit.patch
  Provide a filesystem-specific sync'able page bit

provide-a-filesystem-specific-syncable-page-bit-fix.patch
  provide-a-filesystem-specific-syncable-page-bit-fix

provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
  provide-a-filesystem-specific-syncable-page-bit-fix-2

make-afs-use-cachefs.patch
  Make AFS use CacheFS

afs-cachefs-dependency-fix.patch
  afs-cachefs-dependency-fix

split-general-cache-manager-from-cachefs.patch
  Split general cache manager from CacheFS

turn-cachefs-into-a-cache-backend.patch
  Turn CacheFS into a cache backend

rework-the-cachefs-documentation-to-reflect-fs-cache-split.patch
  Rework the CacheFS documentation to reflect FS-Cache split

update-afs-client-to-reflect-cachefs-split.patch
  Update AFS client to reflect CacheFS split

fscache-menuconfig-help-fix-documentation-path.patch
  fscache-menuconfig-help-fix-documentation-pathc

x86-rename-apic_mode_exint.patch
  kexec: x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  kexec: x86: local apic fix

x86_64-e820-64bit.patch
  kexec: x86_64: e820 64bit fix

x86-i8259-shutdown.patch
  kexec: x86: i8259 shutdown: disable interrupts

x86_64-i8259-shutdown.patch
  kexec: x86_64: add i8259 shutdown method

x86-apic-virtwire-on-shutdown.patch
  kexec: x86: resture apic virtual wire mode on shutdown

x86_64-apic-virtwire-on-shutdown.patch
  kexec: x86_64: restore apic virtual wire mode on shutdown

vmlinux-fix-physical-addrs.patch
  kexec: vmlinux: fix physical addresses

x86-vmlinux-fix-physical-addrs.patch
  kexec: x86: vmlinux: fix physical addresses

x86_64-vmlinux-fix-physical-addrs.patch
  kexec: x86_64: vmlinux: fix physical addresses

x86-config-kernel-start.patch
  kexec: x86: add CONFIG_PYSICAL_START

kexec-reserve-bootmem-fix-for-booting-nondefault-location-kernel.patch
  kexec: reserve Bootmem fix for booting nondefault location kernel

x86_64-config-kernel-start.patch
  kexec: x86_64: add CONFIG_PHYSICAL_START

kexec-kexec-generic.patch
  kexec: add kexec syscalls

kexec-kexec-generic-kexec-use-unsigned-bitfield.patch
  kexec: use unsigned bitfield

x86-machine_shutdown.patch
  kexec: x86: factor out apic shutdown code

x86-kexec.patch
  kexec: x86 kexec core

x86-crashkernel.patch
  crashdump: x86 crashkernel option

x86-crashkernel-fix.patch
  kexec: fix for broken kexec on panic

x86_64-machine_shutdown.patch
  kexec: x86_64: factor out apic shutdown code

x86_64-kexec.patch
  kexec: x86_64 kexec implementation

x86_64-crashkernel.patch
  crashdump: x86_64: crashkernel option

kexec-ppc-support.patch
  kexec: kexec ppc support

kexec-ppc-fix-noret_type.patch
  kexec: ppc: fix NORET_TYPE

x86-crash_shutdown-nmi-shootdown.patch
  crashdump: x86: add NMI handler to capture other CPUs

x86-crash_shutdown-snapshot-registers.patch
  kexec: x86: snapshot registers during crash shutdown

x86-crash_shutdown-apic-shutdown.patch
  kexec: x86 shutdown APICs during crash_shutdown

kdump-export-crash-notes-section-address-through.patch
  Kdump: Export crash notes section address through sysfs

kdump-export-crash-notes-section-address-through-x86_64-fix.patch
  kdump-export-crash-notes-section-address-through x86_64 fix

kdump-nmi-handler-segment-selector-stack.patch
  kdump: NMI handler segment selector, stack pointer fix

kdump-documentation-for-kdump.patch
  kdump: Documentation for Kdump

kdump-retrieve-saved-max-pfn.patch
  kdump: Retrieve saved max pfn

kdump-kconfig-for-kdump.patch
  kdump: Kconfig

kdump-routines-for-copying-dump-pages.patch
  kdump: Routines for copying dump pages

kdump-retrieve-elfcorehdr-address-from-command.patch
  Retrieve elfcorehdr address from command line

kdump-access-dump-file-in-elf-format.patch
  kdump: Access dump file in elf format (/proc/vmcore)

kdump-parse-elf32-headers-and-export-through.patch
  kdump: Parse elf32 headers and export through /proc/vmcore

kdump-accessing-dump-file-in-linear-raw-format.patch
  kdump: Accessing dump file in linear raw format (/dev/oldmem)

kdump-cleanups-for-dump-file-access-in-linear.patch
  kdump: cleanups for dump file access in linear raw format

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-rcu-barrier-license-fix.patch
  reiser4-rcu-barrier-license-fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

reiser4-kconfig-help-cleanup.patch
  reiser4 Kconfig help cleanup

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

vt-dont-call-unblank-at-irq-time.patch
  vt: don't call unblank at irq time

ppc32-move-powermac-backlight-stuff-to-a-workqueue.patch
  ppc32: move powermac backlight stuff to a workqueue

radeonfb-implement-proper-workarounds-for-pll-accesses.patch
  radeonfb: Implement proper workarounds for PLL accesses

radeonfb-ddc-i2c-fix.patch
  radeonfb: DDC i2c fix

fbdev-nvidia-licensing-clarification.patch
  fbdev: mvidia licensing clarification

fbcon-stop-framebuffer-operations-before-hardware-is-properly-initialized.patch
  fbcon: Stop framebuffer operations before hardware is properly initialized

nvidiafb-maximize-blit-buffer-capacity.patch
  nvidiafb: Maximize blit buffer capacity

nvidiafb-fix-section-references.patch
  nvidiafb: fix section references

nvidiafb-process-boot-options-earlier.patch
  nvidiafb: Process boot options earlier

nvidiafb-kconfig-help-text-update-for-config-fb_nvidia.patch
  nvidiafb: Kconfig help text update for config FB_NVIDIA

nvidiafb-delete-i2c-bus-on-driver-unload.patch
  nvidiafb: Delete i2c bus on driver unload

pm2fb-x-and-vt-switching-crash-fix.patch
  pm2fb: X and VT switching crash fix

fbdev-cleanups-in-drivers-video-part-2.patch
  fbdev: Cleanups in drivers/video part 2

fbdev-cleanups-in-drivers-video-part-2-fix.patch
  fbdev-cleanups-in-drivers-video-part-2 fix

excessive-atyfb-debug-messages.patch
  Excessive atyfb debug messages

atyfb-add-boot-module-option-to-override-composite-sync.patch
  atyfb: Add boot/module option to override composite sync

fbdev-kconfig-fix-for-macmodes-and-ppc.patch
  fbdev: Kconfig fix for macmodes and PPC

fbdev-convert-drivers-to-pci_register_driver.patch
  fbdev: Convert drivers to pci_register_driver

sisfb-trivial-cleanups.patch
  sisfb: Trivial cleanups

tridentfb-clean-up-printks.patch
  tridentfb: Clean up printk()'s

s1d13xxxfb-add-support-for-epson-s1d13806-fb.patch
  s1d13xxxfb: Add support for Epson S1D13806 FB

fbcon-save-var-rotate-field-in-struct-display.patch
  fbcon: Save var rotate field in struct display

fbcon-call-set_par-per-fb_info-once-during-init.patch
  fbcon: Call set_par per fb_info once during init

fbcon-do-not-set-palette-if-console-is-not-visible.patch
  fbcon: Do not set palette if console is not visible

neofb-mmio-fixes.patch
  neofb: mmio fixes

neofb-set-hwaccel-flags-properly.patch
  neofb: Set hwaccel flags properly

remove-redundant-null-checks-before-kfree-in-drivers-video.patch
  remove redundant NULL checks before kfree() in drivers/video/

remove-redundant-null-checks-before-kfree-in-drivers-video-fix.patch
  remove-redundant-null-checks-before-kfree-in-drivers-video fix

fix-matroxfb-on-big-endian-hardware.patch
  Fix matroxfb on big-endian hardware

radeonfb-fix-mode-setting-on-crt-monitors.patch
  radeonfb: Fix mode setting on CRT monitors

radeonfb-preserve-tmds-setting.patch
  radeonfb: Preserve TMDS setting

fix-atyfb-build-on-ppc.patch
  Fix atyfb build on ppc

md-merge-md_enter_safemode-into-md_check_recovery.patch
  md: merge md_enter_safemode into md_check_recovery

md-improve-locking-on-safemode-and-move-superblock-writes.patch
  md: improve locking on 'safemode' and move superblock writes

md-improve-the-interface-to-sync_request.patch
  md: improve the interface to sync_request

md-optimised-resync-using-bitmap-based-intent-logging.patch
  md: optimised resync using Bitmap based intent logging

md-optimised-resync-using-bitmap-based-intent-logging-mempool-fix.patch
  md-optimised-resync-using-bitmap-based-intent-logging-mempool-fix

md-a-couple-of-tidyups-relating-to-the-bitmap-file.patch
  md: a couple of tidyups relating to the bitmap file.

md-call-bitmap_daemon_work-regularly.patch
  md: call bitmap_daemon_work regularly

md-print-correct-pid-for-newly-created-bitmap-writeback-daemon.patch
  md: print correct pid for newly created bitmap-writeback-daemon.

md-minor-code-rearrangement-in-bitmap_init_from_disk.patch
  md: minor code rearrangement in bitmap_init_from_disk

md-make-sure-md-bitmap-is-cleared-on-a-clean-start.patch
  md: make sure md bitmap is cleared on a clean start.

md-printk-fix.patch
  md printk fix

md-improve-debug-printing-of-bitmap-superblock.patch
  md: improve debug-printing of bitmap superblock.

md-check-return-value-of-write_page-rather-than-ignore-it.patch
  md: check return value of write_page, rather than ignore it

md-enable-the-bitmap-write-back-daemon-and-wait-for-it.patch
  md: enable the bitmap write-back daemon and wait for it.

md-dont-skip-bitmap-pages-due-to-lack-of-bit-that-we-just-cleared.patch
  md: don't skip bitmap pages due to lack of bit that we just cleared.

md-optimised-resync-using-bitmap-based-intent-logging-fix.patch
  md-optimised-resync-using-bitmap-based-intent-logging fix

md-raid1-support-for-bitmap-intent-logging.patch
  md: raid1 support for bitmap intent logging

md-fix-bug-when-raid1-attempts-a-partial-reconstruct.patch
  md: fix bug when raid1 attempts a partial reconstruct.

md-raid1-support-for-bitmap-intent-logging-fix.patch
  md: initialise sync_blocks in raid1 resync

md-optimise-reconstruction-when-re-adding-a-recently-failed-drive.patch
  md: optimise reconstruction when re-adding a recently failed drive.

md-fix-deadlock-due-to-md-thread-processing-delayed-requests.patch
  md: fix deadlock due to md thread processing delayed requests.

md-allow-md-intent-bitmap-to-be-stored-near-the-superblock.patch
  md: allow md intent bitmap to be stored near the superblock.

md-allow-md-to-update-multiple-superblocks-in-parallel.patch
  md: allow md to update multiple superblocks in parallel.

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

doc-where-to-find-ldd3.patch
  doc: where to find LDD3

post-halloween-doc.patch
  post halloween doc

fuse-maintainers-kconfig-and-makefile-changes.patch
  FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  FUSE - core

fuse-device-functions.patch
  FUSE - device functions

fuse-device-functions-comments-and-documentation.patch
  FUSE: comments and documentation

fuse-device-functions-cleanup.patch
  FUSE: trivial cleanups

fuse-read-only-operations.patch
  FUSE - read-only operations

fuse-read-write-operations.patch
  FUSE - read-write operations

fuse-file-operations.patch
  FUSE - file operations

fuse-mount-options.patch
  FUSE - mount options

fuse-mount-options-fix.patch
  fuse: fix busy inodes after unmount

fuse-mount-options-comments-and-documentation.patch
  FUSE: comments and documentation

fuse-mount-options-fix-cleanup.patch
  FUSE: trivial cleanups

fuse-mount-options-fix-fix.patch
  FUSE: fix locking for background list

fuse-extended-attribute-operations.patch
  FUSE - extended attribute operations

fuse-readpages-operation.patch
  FUSE - readpages operation

fuse-nfs-export.patch
  FUSE - NFS export

fuse-direct-i-o.patch
  FUSE - direct I/O

fuse-transfer-readdir-data-through-device.patch
  fuse: transfer readdir data through device

drivers-isdn-divert-isdn_divertc-make-5-functions-static.patch
  drivers/isdn/divert/isdn_divert.c: make 5 functions static

drivers-isdn-capi-make-some-code-static.patch
  drivers/isdn/capi/: make some code static

drivers-scsi-pas16c-make-code-static.patch
  drivers/scsi/pas16.c: make code static

i386-x86_64-early_printkc-make-early_serial_base-static.patch
  i386/x86_64 early_printk.c: make early_serial_base static

kernel-exitc-make-exit_mm-static.patch
  kernel/exit.c: make exit_mm static

cyrix-eliminate-bad-section-references.patch
  cyrix: eliminate bad section references

drivers-media-video-tvaudioc-make-some-variables-static.patch
  drivers/media/video/tvaudio.c: make some variables static

drivers-isdn-sc-possible-cleanups.patch
  drivers/isdn/sc/: possible cleanups

drivers-isdn-pcbit-possible-cleanups.patch
  drivers/isdn/pcbit/: possible cleanups

drivers-isdn-i4l-possible-cleanups.patch
  drivers/isdn/i4l/: possible cleanups

unexport-mca_find_device_by_slot.patch
  unexport mca_find_device_by_slot

drivers-isdn-hardware-avm-misc-cleanups.patch
  drivers/isdn/hardware/avm/: misc cleanups

drivers-isdn-act2000-capic-if-0-an-unused-function.patch
  drivers/isdn/act2000/capi.c: #if 0 an unused function

tpm-fix-gcc-printk-warnings.patch
  tpm: fix gcc printk warnings

x86-64-add-memcpy-memset-prototypes.patch
  x86-64: add memcpy/memset prototypes

au1100fb-convert-to-c99-inits.patch
  au1100fb: convert to C99 inits.

reiserfs-use-null-instead-of-0.patch
  reiserfs: use NULL instead of 0

comments-on-locking-of-task-comm.patch
  comments on locking of task->comm

riottyc-cleanups-and-warning-fix.patch
  riotty.c cleanups and warning fix

fixup-a-comment-still-refering-to-verify_area.patch
  fix up a comment still refering to verify_area

char-ds1620-use-msleep-instead-of-schedule_timeout.patch
  char/ds1620: use msleep() instead of schedule_timeout()

char-tty_io-replace-schedule_timeout-with-msleep_interruptible.patch
  char/tty_io: replace schedule_timeout() with msleep_interruptible()

kernel-timer-fix-msleep_interruptible-comment.patch
  kernel/timer: fix msleep_interruptible() comment

ixj-compile-warning-cleanup.patch
  ixj* - compile warning cleanup

spelling-cleanups-in-shrinker-code.patch
  Spelling cleanups in shrinker code

init-do_mounts_initrdc-fix-sparse-warning.patch
  init/do_mounts_initrd.c: fix sparse warning

arch-i386-kernel-trapsc-fix-sparse-warnings.patch
  arch/i386/kernel/traps.c: fix sparse warnings

arch-i386-kernel-apmc-fix-sparse-warnings.patch
  arch/i386/kernel/apm.c: fix sparse warnings

arch-i386-mm-faultc-fix-sparse-warnings.patch
  arch/i386/mm/fault.c: fix sparse warnings

arch-i386-crypto-aesc-fix-sparse-warnings.patch
  arch/i386/crypto/aes.c: fix sparse warnings

codingstyle-trivial-whitespace-fixups.patch
  CodingStyle: trivial whitespace fixups

small-partitions-msdos-cleanups.patch
  small partitions/msdos cleanups

remove-redundant-null-check-before-before-kfree-in.patch
  remove redundant NULL check before before kfree() in  kernel/sysctl.c

update-ross-biro-bouncing-email-address.patch
  update Ross Biro bouncing email address

get-rid-of-redundant-null-checks-before-kfree-in-arch-i386.patch
  get rid of redundant NULL checks before kfree() in arch/i386/

remove-redundant-null-checks-before-kfree-in-sound-and.patch
  remove redundant NULL checks before kfree() in sound/ and avoid casting pointers about to be kfree()'ed

x86-geode-support-fixes.patch
  x86: geode support fixes

drivers-scsi-initioc-cleanups.patch
  drivers/scsi/initio.c: cleanups

dont-do-pointless-null-checks-and-casts-before-kfree.patch
  selinux: kfree cleanup

drivers-char-isicomc-section-fixes.patch
  drivers/char/isicom.c: section fixes

sound-oss-cleanups.patch
  sound/oss/: cleanups

sound-oss-rme96xxc-remove-kernel-22-ifs.patch
  sound/oss/rme96xx.c: remove kernel 2.2 #if's

drivers-char-mwave-tp3780ic-remove-kernel-22-ifs.patch
  drivers/char/mwave/tp3780i.c: remove kernel 2.2 #if's

drivers-net-skfp-cleanups.patch
  drivers/net/skfp/: cleanups

net-atm-resourcesc-remove-__free_atm_dev.patch
  Subject: [2.6 patch] net/atm/resources.c: remove __free_atm_dev

fix-ncr53c9xc-compile-warning.patch
  fix NCR53C9x.c compile warning

mm-mmapnommuc-several-unexports.patch
  mm/{mmap,nommu}.c: several unexports

unexport-hugetlb_total_pages.patch
  unexport hugetlb_total_pages

unexport-clear_page_dirty_for_io.patch
  unexport clear_page_dirty_for_io

mm-filemapc-make-sync_page_range_nolock-static.patch
  mm/filemap.c: make sync_page_range_nolock static

mm-filemapc-make-generic_file_direct_io-static.patch
  mm/filemap.c: make generic_file_direct_IO static

remove-exports-for-oem-modules.patch
  remove exports for oem modules

mm-page_allocc-unexport-nr_swap_pages.patch
  unexport nr_swap_pages

unexport-console_unblank.patch
  unexport console_unblank

mm-swapc-unexport-vm_acct_memory.patch
  mm/swap.c: unexport vm_acct_memory

mm-swapfilec-unexport-total_swap_pages.patch
  mm/swapfile.c: unexport total_swap_pages

mm-swap_statec-unexport-swapper_space.patch
  mm/swap_state.c: unexport swapper_space

unexport-slab_reclaim_pages.patch
  unexport slab_reclaim_pages

unexport-idle_cpu.patch
  unexport idle_cpu



