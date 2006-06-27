Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbWF0IwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWF0IwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWF0IwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:52:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932655AbWF0IwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:52:21 -0400
Date: Tue, 27 Jun 2006 01:52:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm3
Message-Id: <20060627015211.ce480da6.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm3/


- Added the x86 Geode development tree to the -mm lineup, as git-geode.patch
  (Jordan Crouse).

- The locking validator patches are back, in a reworked series.



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



Changes since 2.6.17-mm2:


 origin.patch
 git-agpgart.patch
 git-cifs.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-infiniband.patch
 git-jfs.patch
 git-klibc.patch
 git-klibc-fixup.patch
 git-hdrinstall2.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-parisc.patch
 git-pcmcia.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-wireless.patch
 git-xfs.patch

 git trees.

-fix-typo-in-acpi-video-brightness-changes.patch
-initramfs-overwrite-fix.patch
-remove-for_each_cpu.patch
-more-for_each_cpu-removal.patch
-fix-drivers-mfd-ucb1x00-corec-irq-probing-bug.patch
-cifs-build-fix.patch
-remove-useless-checks-in-cifs-connectc.patch
-cifs-remove-f_ownerlock-use.patch
-tea575x-tuner-build-fix.patch
-git-dvb-versus-matroxfb.patch
-git-dvb-printk-warning-fix.patch
-fix-use-after-free-bug-in-cpia2-driver.patch
-drivers-media-video-vivic-make-2-functions-static.patch
-drivers-media-video-pwc-make-code-static.patch
-fix-up-funky-logic-in-dvb.patch
-ieee1394-nodemgr-do-not-peek-into-struct.patch
-via-pmu-add-input-device.patch
-input-mouse-sermouse-fix-memleak-and-potential-buffer-overflow.patch
-kbuild-export-symbol-usage-report-generator-2.patch
-add-a-pci-vendor-id-definition-for-aculab.patch
-ppp_async-hang-fix.patch
-netpoll-dont-spin-forever-sending-to-blocked-queues.patch
-netpoll-break-recursive-loop-in-netpoll-rx-path.patch
-irda-add-some-ibm-think-pads.patch
-atm-mpcc-warning-fix.patch
-nfs-remove-nfs_put_link.patch
-8250_pnp-add-support-for-other-wacom-tablets.patch
-64-bit-resources-kconfig-change.patch
-64-bit-resources-lose-some-ifdefs.patch
-64bit-resource-fix-up-printks-for-resources-in-arch-and-core-code-fix.patch
-fix-pciehp-driver-on-non-acpi-systems.patch
-drivers-scsi-sdc-fix-uninitialized-variable-in-handling-medium-errors.patch
-lpfc-sparse-null-warnings.patch
-random-remove-redundant-sa_sample_random-from-ninjascsi.patch
-add-scsi_add_host-failure-handling-for-nsp32.patch
-bogus-disk-geometry-on-large-disks.patch
-megaraid_sas-zcr-with-fix.patch
-usb-move-linux-usb_input.h-to-linux-usb-input-fix.patch
-usb-new-driver-for-cypress-cy7c63xxx-mirco-controllers-fix.patch
-x86_64-mm-defconfig-update.patch
-x86_64-mm-phys-apicid.patch
-x86_64-mm-memset-always-inline.patch
-x86_64-mm-amd-core-cpuid.patch
-x86_64-mm-amd-cpuid4.patch
-x86_64-mm-alternatives.patch
-x86_64-mm-pci-dma-cleanup.patch
-x86_64-mm-ia32-unistd-cleanup.patch
-x86_64-mm-large-bzimage.patch
-x86_64-mm-topology-comment.patch
-x86_64-mm-iommu_gart_bitmap-search-to-cross-next_bit.patch
-x86_64-mm-new-compat-ptrace.patch
-x86_64-mm-disable-agp-resource-check.patch
-x86_64-mm-gart-direct-call.patch
-x86_64-mm-new-northbridge.patch
-x86_64-mm-serialize-assign_irq_vector-use-of-static-variables.patch
-x86_64-mm-simplify-ioapic_register_intr.patch
-x86_64-mm-i386-up-generic-arch.patch
-x86_64-mm-iommu-enodev.patch
-x86_64-mm-compat-printk.patch
-x86_64-mm-add-end-endproc-annotations-to-entrys.patch
-x86_64-mm-i386-numa-summit-check.patch
-x86_64-mm-fix-unlikely-profiling--vsyscalls-on-x86_64.patch
-x86_64-mm-nmi-watchdog-header-cleanup.patch
-x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch
-x86_64-mm-utilize-performance-counter-reservation-framework-in-oprofile.patch
-x86_64-mm-add-smp-support-on-x86_64-to-reservation-framework.patch
-x86_64-mm-add-smp-support-on-i386-to-reservation-framework.patch
-x86_64-mm-cleanup-nmi-interrupt-path.patch
-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions.patch
-x86_64-mm-add-abilty-to-enable-disable-nmi-watchdog-from-sysfs.patch
-x86_64-mm-acpi-blacklist-xw9300.patch
-x86_64-mm-remove-ids.patch
-x86_64-mm-remove-ia32-export.patch
-x86_64-mm-optimize-bitmap-weight.patch
-x86_64-mm-allow-users-to-force-a-panic-on-nmi.patch
-x86_64-mm-make-functions-static.patch
-x86_64-mm-remove-unused-gart-header-file.patch
-x86_64-mm-fix-vector_lock-deadlock-in-io_apicc.patch
-x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix.patch
-x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix-fix.patch
-x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86_64-fix.patch
-x86_64-mm-kdump-x86_64-nmi-event-notification-fix.patch
-x86_64-mm-kdump-i386-nmi-event-notification-fix.patch
-x86_64-mm-set-compat-early.patch
-x86_64-mm-i386-enable-nmi-wdog.patch
-x86_64-mm-iommu-clarification.patch
-x86_64-mm-reliable-stack-trace-support.patch
-x86_64-mm-reliable-stack-trace-support-x86-64.patch-x86_64-mm-reliable-stack-trace-support-x86-64-irq-stack.patch
-x86_64-mm-reliable-stack-trace-support-x86-64-syscall.patch
-x86_64-mm-reliable-stack-trace-support-i386.patch
-x86_64-mm-x86_86-msi-miss-one-entry-handler.patch
-x86_64-mm-reliable-stack-trace-support-i386-entrys.patch
-x86_64-mm-fall-back-to-old-style-call-trace-if-no-unwinding.patch
-x86_64-mm-allow-unwinder-to-build-without-module-support.patch
-x86_64-mm-consoldidate-boot-compressed.patch
-x86_64-mm-remove-pud_offset_k.patch
-x86_64-mm-use-halt-instead-of-raw-inline-assembly.patch
-x86_64-mm-change-assembly-to-use-regular-cpuid_count-macro.patch
-x86_64-mm-iommu-detected.patch
-x86_64-mm-valid-dma-direction.patch
-x86_64-mm-iommu-abstraction.patch
-x86_64-mm-calgary-iommu.patch
-x86_64-mm-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86.patch
-x86_64-mm-add-nmi-watchdog-support-for-new-intel-cpus.patch
-x86_64-mm-rdtscp-macros.patch
-x86_64-mm-time-constants.patch
-x86_64-mm-rename-force-hpet.patch
-x86_64-mm-rdtscp-feature.patch
-x86_64-mm-remove-hpet-hack.patch
-x86_64-mm-use-time-constants.patch
-x86_64-mm-init-rdtscp.patch
-x86_64-mm-explain-double-hpet-init.patch
-x86_64-mm-update-copyright.patch
-x86_64-mm-getcpu-vsyscall.patch
-x86_64-mm-time-init-gtod-prototype.patch
-x86_64-mm-x86-clean-up-nmi-panic-messages.patch
-x86_64-mm-i386-move-vm86-config.patch
-x86_64-mm-apic-support-for-extended-apic-interrupt.patch
-x86_64-mm-mce_amd-relocate-sysfs-files.patch
-x86_64-mm-mce_amd-support-for-family-0x10-processors.patch
-x86_64-mm-mce_amd-cleanup.patch
-x86_64-mm-miscellaneous-mm-initc-fixes.patch
-x86_64-mm-check_addr-cleanups.patch
-x86_64-mm-remove-redzone-comment.patch
-x86_64-mm-polling-thread-status.patch
-x86_64-mm-twofish-cipher---split-out-common-c-code.patch
-x86_64-mm-twofish-cipher---priority-fix.patch
-x86_64-mm-twofish-cipher---i586-assembler.patch
-x86_64-mm-twofish-cipher---x86_64-assembler.patch
-x86_64-mm-unify-cpu-boottime-output.patch
-aop_truncated_page-victims-in-read_pages-belong-in-the-lru.patch
-mm-remove-vm_locked-before-remap_pfn_range-and-drop-vm_shm.patch
-page-migration-support-a-vma-migration-function.patch
-allow-migration-of-mlocked-pages.patch
-clean-up-and-refactor-i386-sub-architecture-setup.patch
-cpu_relax-smpbootc.patch
-cpu_relax-smpbootc-fix.patch
-x86-apic-fix-apic-error-on-bootup.patch
-i386-cpu_relax-in-crashc-and-doublefaultc.patch
-m68k-fix-uaccessh-for-gcc-3x.patch
-m68k-fix-constraints-of-the-signal-functions-and-some-cleanup.patch
-m68k-fix-__iounmap-for-030.patch
-m68k-small-flush_icache-cleanup.patch
-m68k-add-the-generic-dma-api-functions.patch
-m68k-dma-api-addition.patch
-m68k-fix-show_registers.patch
-m68k-separate-handler-for-auto-and-user-vector-interrupt.patch
-m68k-cleanup-generic-irq-names.patch
-m68k-cleanup-amiga-irq-numbering.patch
-m68k-introduce-irq-controller.patch
-m68k-convert-generic-irq-code-to-irq-controller.patch
-m68k-convert-amiga-irq-code.patch
-m68k-convert-apollo-irq-code.patch
-m68k-convert-atari-irq-code.patch
-m68k-convert-hp300-irq-code.patch
-m68k-convert-mac-irq-code.patch
-m68k-convert-q40-irq-code.patch
-m68k-convert-sun3-irq-code.patch
-m68k-convert-vme-irq-code.patch
-x86_64-unexport-ia32_sys_call_table.patch
-work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
-kernel-kernel-cpuc-to-mutexes.patch
-make-sure-nobodys-leaking-resources.patch
-rewritten-backlight-infrastructure-for-portable-apple-computers.patch
-rewritten-backlight-infrastructure-for-portable-apple-computers-fix.patch
-ensure-null-deref-cant-possibly-happen-in-is_exported.patch
-bluetooth-fix-potential-null-ptr-deref-in-dtl1_cscdtl1_hci_send_frame.patch
-bloat-o-meter-gcc-4-fix.patch
-random-remove-sa_sample_random-from-floppy-driver.patch
-random-make-cciss-use-add_disk_randomness.patch
-random-change-cpqarray-to-use-add_disk_randomness.patch
-random-remove-redundant-sa_sample_random-from-touchscreen-drivers.patch
-define-__raw_get_cpu_var-and-use-it.patch
 deprecate-smbfs-in-favour-of-cifs.patch
-allow-raw_notifier-callouts-to-unregister-themselves.patch
-fs-freevxfs-cleanup-of-spelling-errors.patch
-pnp-card_probe-fix-memory-leak.patch
-ufs-ufs_trunc_indirect-infinite-cycle.patch
-ufs-right-block-allocation.patch
-ufs-change-block-number-on-the-fly.patch
-ufs-directory-and-page-cache-install-aops.patch
-ufs-directory-and-page-cache-from-blocks-to-pages.patch
-ufs-wrong-type-cast.patch
-ufs-not-usual-amounts-of-fragments-per-block.patch
-ufs-unmark-config_ufs_fs_write-as-broken-mm-tree.patch
-ufs-easy-debug.patch
-ufs-little-directory-lookup-optimization.patch
-ufs-i_blocks-wrong-count.patch
-ufs-unlock_super-without-lock.patch
-ufs-zero-metadata.patch
-ufs-printk-warning-fixes.patch
-ufs-missed-brelse-and-wrong-baseblk.patch
-ufs-one-way-to-access-super-block.patch
-ufs-fsync-implementation.patch
-ufs-make-fsck-f-happy.patch
-ufs-ubh_ll_rw_block-cleanup.patch
-fs-ufs-inodec-make-2-functions-static.patch
-oprofile-fix-unnecessary-cleverness.patch
-msnd-section-fix.patch
-oprofile-convert-from-semaphores-to-mutexes.patch
-drivers-char-applicomc-proper-module_initexit.patch
-remove-dead-entry-in-net-wan-kconfig.patch
-openpromfs-fix-missing-nul.patch
-openpromfs-remove-unnecessary-casts.patch
-openpromfs-factorize-out.patch
-openpromfs-factorize-out-tidy.patch
-idetape-gcc-41-warning-fix.patch
-add-driver-for-arm-amba-pl031-rtc.patch
-add-driver-for-arm-amba-pl031-rtc-fix.patch
-make-printk-work-for-really-early-debugging.patch
-kernel-sysc-cleanups.patch
-kernel-sysc-cleanups-fix.patch
-nbd-kill-obsolete-changelog-add-gpl.patch
-fix-listh-kernel-doc.patch
-listh-doc-change-counter-to-control.patch
-fix-magic-sysrq-on-strange-keyboards.patch
-ide-cd-end-of-media-error-fix.patch
-cpqarray-section-fix.patch
-pdflush-handle-resume-wakeups.patch
-edd-isnt-experimental-anymore.patch
-kernel-doc-drop-leading-space-in-sections.patch
-kernel-doc-script-cleanups.patch
-schedule_on_each_cpu-reduce-kmalloc-size.patch
-avoid-disk-sector_t-overflow-for-2tb-ext3-filesystem.patch
-cleanup-dead-code-from-ext2-mount-code.patch
-fix-memory-leak-when-the-ext3s-journal-file-is-corrupted.patch
-remove-inconsistent-space-before-exclamation-point-in-ext3s-mount-code.patch
-moxa-remove-pointless-casts.patch
-moxa-remove-pointless-check-of-tty-argument-vs-null.patch
-moxa-partial-codingstyle-cleanup-spelling-fixes.patch
-updated-kdump-documentation.patch
-cpuset-remove-extra-cpuset_zone_allowed-check-in-__alloc_pages.patch
 spin-rwlock-init-cleanups.patch
-make-debug_mutex_on-__read_mostly.patch
-constify-parts-of-kernel-power.patch
-constify-libcrc32c-table.patch
-prepare-for-__copy_from_user_inatomic-to-not-zero-missed-bytes.patch
-make-copy_from_user_inatomic-not-zero-the-tail-on-i386.patch
-remove-unecessary-null-check-in-kernel-acctc.patch
-ax88796-parallel-port-driver.patch
-ax88796-parallel-port-driver-build-fix.patch
-wd7000-fix-section-mismatch-warnings.patch
-megaraid_mbox-fix-section-mismatch-warnings.patch
-ext3_fsblk_t-filesystem-group-blocks-and-bug-fixes.patch
-ext3_fsblk_t-the-rest-of-in-kernel-filesystem-blocks.patch
-list_del-debug.patch
-kernel-doc-mm-readhead-fixup.patch
-make-procfs-obligatory-except-under-config_embedded.patch
-lock-validator-introduce-warn_on_oncecond.patch
-lock-validator-introduce-warn_on_oncecond-speedup.patch
-make-sysctl-obligatory-except-under-config_embedded.patch
-for_each_cpu_mask-warning-fix.patch
-emu10k1-mark-midi_spinlock-as-used.patch
-make-ext2_debug-work-again.patch
-nbd-endian-annotations.patch
-epoll-use-unlocked-wqueue-operations.patch
-radixtree-normalize-radix_tree_tag_get-return-value.patch
-printk-time-parameter.patch
-correct-sak-description-in-sysrqtxt.patch
-rtc-framework-driver-for-ds1307-and-similar-rtc-chips.patch
-rtc-rtc-dev-uie-emulation.patch
-drivers-acorn-char-pcf8583-vs-rtc-subsystem.patch
-rtc-subsystem-fix-capability-checks-in-kernel-interface.patch
-rtc-subsystem-add-capability-checks.patch
-add-max6902-rtc-support.patch
-add-max6902-rtc-support-update.patch
-add-max6902-rtc-support-tidy.patch
-rtc-small-documentation-update.patch
-add-v3020-rtc-support.patch
-add-v3020-rtc-support-tidy.patch
-rtc-add-rtc_year_days-to-calculate-tm_yday.patch
-at91rm9200-rtc-driver.patch
-at91rm9200-rtc-driver-tidy.patch
-rtc-add-rtc-ds1553-driver.patch
-rtc-add-rtc-ds1553-driver-tidy.patch
-rtc-add-rtc-ds1553-driver-fix.patch
-rtc-add-rtc-ds1742-driver.patch
-rtc-add-rtc-ds1742-driver-tidy.patch
-rtc-add-rtc-ds1742-driver-fix.patch
-correct-tty-doc.patch
-checkstack-pirnt-module-names.patch
-get-rid-of-proc-sys-proc.patch
-9pfs-missing-result-check-in-v9fs_vfs_readlink-and-v9fs_vfs_link.patch
-ext3-cleanup-dead-code-in-ext3_add_entry.patch
-n32-sigset-and-__compat_endian_swap__.patch
-ftruncate-does-not-always-update-m-ctime.patch
-wan-sdla-section-fixes.patch
-trident-fb-section-fixes.patch
-cdrom-mcdx-section-fixes.patch
-char-ip2-more-section-fixes-replacement.patch
-advansys-section-fixes.patch
-r3964-fix-gfp_kernel-allocations-in-timer-function.patch
-readahead-backoff-on-i-o-error.patch
-readahead-backoff-on-i-o-error-tweaks.patch
-rcu-documentation-self-limiting-updates-and-call_rcu.patch
-link-error-when-futexes-are-disabled-on-64bit-architectures.patch
-cyclades-cleanup.patch
-cyclades-cleanup-cleanup.patch
-cleanup-char-espc.patch
-autofs4-need-to-invalidate-children-on-tree-mount-expire.patch
-update-contact-information-in-credits.patch
-more-tty-cleanups-in-drivers-char.patch
-another-couple-of-alterations-to-the-memory-barrier-doc.patch
-fuse-use-misc_major.patch
-fuse-no-backgrounding-on-interrupt.patch
-fuse-add-control-filesystem.patch
-fuse-add-control-filesystem-get_sb_single-fix.patch
-fuse-add-control-filesystem-printk-fix.patch
-fuse-add-control-filesystem-fuse-comment-control-filesystem.patch
-fuse-add-posix-file-locking-support.patch
-fuse-ensure-flush-reaches-userspace.patch
-fuse-rename-the-interrupted-flag.patch
-fuse-add-request-interruption.patch
-fuse-scramble-lock-owner-id.patch
-mark-profile-notifier-blocks-__read_mostly.patch
-kernel-doc-warn-on-malformed-function-docs.patch
-ide-floppy-fix-debug-only-syntax-error.patch
-remove-needless-checks-in-fs-9p-vfs_inodec.patch
-kernel-doc-for-lib-bitmapc.patch
-kernel-doc-for-lib-cmdlinec.patch
-kernel-doc-for-lib-crcc.patch
-kthread-update-loopc-to-use-kthread.patch
-kthread-update-loopc-to-use-kthread-fix.patch
-kthread-convert-smbiod.patch
-kthread-convert-smbiod-tidy.patch
-initramfs-docs-update.patch
-cciss-disable-device-when-returning-failure.patch
-cciss-request-all-pci-resources.patch
-cciss-announce-cciss%d-devices-with-pci-address-irq-dac-info.patch
-cciss-use-array_size-without-intermediates.patch
-cciss-fix-a-few-spelling-errors.patch
-cciss-remove-parens-around-return-values.patch
-cciss-run-through-lindent.patch
-cciss-tidy-up-product-table-indentation.patch
-i-force-joystick-remove-some-pointless-casts.patch
-affs_fill_super-%s-abuses-2.patch
-kthread-convert-stop_machine-into-a-kthread.patch
-fs-sys_poll-with-timeout-1-bug-fix.patch
-cpu-hotplug-fix-cpu_up_cancel-handling.patch
-add-select-gpio_vr41xx-for-tanbac_tb0229.patch
-implement-at_symlink_follow-flag-for-linkat.patch
-fix-memory-leak-in-rocketport-rp_do_receive.patch
-kernel-doc-dont-use-xml-escapes-in-text-or-man-output.patch
-kernel-doc-use-members-for-struct-fields-consistently.patch
-reed-solomon-fix-kernel-doc-comments.patch
-ktime-hrtimer-fix-kernel-doc-comments.patch
-led-add-led-heartbeat-trigger.patch
-led-add-led-heartbeat-trigger-update.patch
-fix-bounds-check-in-vsnprintf-to-allow-for-a-0-size-and.patch
-fix-bounds-check-in-vsnprintf-to-allow-for-a-0-size-and-tidy.patch
-implement-kasprintf.patch
-dmi-cleanup-kernel-doc-add-to-docbook.patch
-kthread-move-kernel-doc-and-put-it-into-docbook.patch
-irda-usb-printk-fix.patch
-add-synclink_gt-custom-hdlc-idle.patch
-add-synclink_gt-crc-return-feature.patch
-fix-synclink_gt-diagnostics-error-reporting.patch
-synclink_gt-add-gt2-adapter-support.patch
-corrections-to-memory-barrier-doc.patch
-add-option-for-stripping-modules-while-installing-them.patch
-pacct-two-phase-process-accounting.patch
-pacct-avoidance-to-refer-the-last-thread-as-a-representation-of-the-process.patch
-pacct-none-delayed-process-accounting-accumulation.patch
-ext2-cleanup-put_page-and-comment-fix.patch
-au1550_ac97-spin_unlock-in-error-path.patch
-parport-add-to-kernel-doc.patch
-drivers-char-agp-nvidia-agpc-remove-unused-variable.patch
-au1xxx-oss-sound-support-for-au1200.patch
-s390-setupc-cleanup-build-fix.patch
-fix-kdump-crash-kernel-boot-memory-reservation-for-numa.patch
-fix-biovec-256-in-proc-slabinfo.patch
-remove-unlikelysb-in-prune_dcache.patch
-use-list_add_tail-instead-of-list_add.patch
-arch-use-list_move.patch
-core-use-list_move.patch
-net-rxrpc-use-list_move.patch
-drivers-use-list_move.patch
-fs-use-list_move.patch
-keys-sort-out-key-quota-system.patch
-keys-discard-the-contents-of-a-key-on-revocation.patch
-keys-let-keyctl_chown-change-a-keys-owner.patch
-keys-allocate-key-serial-numbers-randomly.patch
-keys-restrict-contents-of-proc-keys-to-viewable-keys.patch
-keys-add-a-way-to-store-the-appropriate-context-for-newly-created-keys.patch
-reiserfs-remove-reiserfs_aio_write.patch
-remove-old-hw-rng-support.patch
-add-new-generic-hw-rng-core.patch
-add-new-generic-hw-rng-core-cleanups.patch
-add-new-generic-hw-rng-core-hw_random-core-rewrite-chrdev-read-method.patch
-add-new-generic-hw-rng-core-maintainers.patch
-add-new-generic-hw-rng-core-hw_random-core-rewrite-chrdev-read-method-hw_random-core-block-read-if-o_nonblock.patch
-add-intel-hw-rng-driver.patch
-add-intel-hw-rng-driver-cleanups.patch
-add-amd-hw-rng-driver.patch
-add-geode-hw-rng-driver.patch
-add-geode-hw-rng-driver-cleanups.patch
-add-via-hw-rng-driver.patch
-add-via-hw-rng-driver-fix.patch
-add-via-hw-rng-driver-cleanups.patch
-add-ixp4xx-hw-rng-driver.patch
-add-ti-omap-cpu-family-hw-rng-driver.patch
-add-bcm43xx-hw-rng-support.patch
-add-bcm43xx-hw-rng-support-locking-update.patch
-ext3-add-o-bh-option.patch
-time-clocksource-infrastructure.patch
-time-clocksource-infrastructure-dont-enable-irq-too-early.patch
-time-use-clocksource-infrastructure-for-update_wall_time.patch
-time-use-clocksource-infrastructure-for-update_wall_time-mark-few-functions-as-__init.patch
-time-let-user-request-precision-from-current_tick_length.patch
-time-use-clocksource-abstraction-for-ntp-adjustments.patch
-time-use-clocksource-abstraction-for-ntp-adjustments-optimize-out-some-mults-since-gcc-cant-avoid-them.patch
-time-introduce-arch-generic-time-accessors.patch
-hangcheck-remove-monotomic_clock-on-x86.patch
-time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
-time-i386-conversion-part-2-rework-tsc-support.patch
-time-i386-conversion-part-3-enable-generic-timekeeping.patch
-time-i386-conversion-part-4-remove-old-timer_opts-code.patch
-time-i386-clocksource-drivers.patch
-time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy.patch
-time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy-acpi_pm-cleanup.patch
-time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy-acpi_pm-cleanup-fix-missing-to-rename-pmtmr_good-to-acpi_pm_good.patch
-time-i386-clocksource-drivers-fix-spelling-typos.patch
-time-rename-clocksource-functions.patch
-make-pmtmr_ioport-__read_mostly.patch
-generic-time-add-macro-to-simplify-hide-mask.patch
-time-fix-time-going-backward-w-clock=pit.patch
-fix-and-optimize-clock-source-update.patch
-kprobe-boost-2byte-opcodes-on-i386.patch
-kprobemulti-kprobe-posthandler-for-booster.patch
-kprobemulti-kprobe-posthandler-for-booster-kprobes-bugfix-of-kprobe-booster-reenable-kprobe-booster.patch
-notify-page-fault-call-chain-for-x86_64.patch
-notify-page-fault-call-chain-for-i386.patch
-notify-page-fault-call-chain-for-ia64.patch
-notify-page-fault-call-chain-for-powerpc.patch
-notify-page-fault-call-chain-for-sparc64.patch
-kprobes-registers-for-notify-page-fault.patch
-notify-page-fault-call-chain.patch
-capi-crash--race-condition.patch
-fix-typo-in-drivers-isdn-hisax-q931c.patch
-isdn4linux-gigaset-base-driver-improve-error-recovery.patch
-isdn4linux-gigaset-driver-cleanup.patch
-i4l-gigaset-drivers-add-ioctls-to-compat_ioctlh.patch
-kconfig-select-things-at-the-closest-tristate-instead-of-bool.patch
-proc-fix-the-inode-number-on-proc-pid-fd.patch
-proc-remove-useless-bkl-in-proc_pid_readlink.patch
-proc-remove-unnecessary-and-misleading-assignments.patch
-proc-simplify-the-ownership-rules-for-proc.patch
-proc-replace-proc_inodetype-with-proc_inodefd.patch
-proc-remove-bogus-proc_task_permission.patch
-proc-kill-proc_mem_inode_operations.patch
-proc-properly-filter-out-files-that-are-not-visible.patch
-proc-fix-the-link-count-for-proc-pid-task.patch
-proc-move-proc_maps_operations-into-task_mmuc.patch
-proc-rewrite-the-proc-dentry-flush-on-exit.patch
-proc-close-the-race-of-a-process-dying-durning.patch
-proc-refactor-reading-directories-of-tasks.patch
-proc-remove-tasklist_lock-from-proc_pid_readdir.patch
-proc-remove-tasklist_lock-from-proc_pid_lookup-and.patch
-proc-remove-tasklist_lock-from-proc_pid_readdir-simply-fix-first_tgid.patch
-proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
-proc-dont-lock-task_structs-indefinitely.patch
-proc-dont-lock-task_structs-indefinitely-task_mmu-small-fixes.patch
-proc-use-struct-pid-not-struct-task_ref.patch
-proc-optimize-proc_check_dentry_visible.patch
-proc-use-sane-permission-checks-on-the-proc-pid-fd.patch
-proc-cleanup-proc_fd_access_allowed.patch
-proc-remove-tasklist_lock-from-proc_task_readdir.patch
-simplify-fix-first_tid.patch
-cleanup-next_tid.patch
-selinux-add-sockcreate-node-to-procattr-api.patch
-de_thread-fix-lockless-do_each_thread.patch
-coredump-optimize-mm-users-traversal.patch
-coredump-speedup-sigkill-sending.patch
-coredump-kill-ptrace-related-stuff.patch
-coredump-kill-ptrace-related-stuff-fix.patch
-coredump-dont-take-tasklist_lock.patch
-coredump-some-code-relocations.patch
-coredump-shutdown-current-process-first.patch
-coredump-copy_process-dont-check-signal_group_exit.patch
-ide-pdc202xx_oldc-remove-unneeded-tuneproc-call.patch
-ide-remove-dma_base2-field-form-ide_hwif_t.patch
-fix-ide-locking-error.patch
-ide-io-increase-timeout-value-to-allow-for-slave-wakeup.patch
-ide-actually-honor-drives-minimum-pio-dma-cycle-times.patch
-ide-pdc202xx_old-remove-the-obsolete-busproc.patch
-fix-ide-deadlock-in-error-reporting-code.patch
-pdc202xx_old-depends-on-config_blk_dev_idedma.patch
-remove-code-that-has-long-been-commented-out-from-pdc20265_old.patch
-radeonfb-powerdrain-issue-on-ibm-thinkpads-and-suspend-to-d2.patch
-savagefb-allocate-space-for-current-and-saved-register.patch
-savagefb-add-state-save-and_restore-hooks.patch
-savagefb-add-state-save-and_restore-hooks-tidy.patch
-savagefb-add-state-save-and_restore-hooks-fix.patch
-backlight-locomo-backlight-driver-updates.patch
-fbdev-cleanup-the-config_video_select-mess.patch
-fbdev-remove-duplicate-includes.patch
-fbdev-more-accurate-sync-range-extrapolation.patch
-nvidiafb-revise-pci_device_id-table.patch
-atyfb-fix-hardware-cursor-handling.patch
-atyfb-remove-unneeded-calls-to-wait_for_idle.patch
-atyfb-set-correct-acceleration-flags.patch
-epson1355fb-update-platform-code.patch
-vesafb-update-platform-code.patch
-vfb-update-platform-code.patch
-vga16fb-update-platform-code.patch
-fbdev-static-pseudocolor-with-depth-less-than-4-does.patch
-savagefb-whitespace-cleanup.patch
-fbdev-firmware-edid-fixes.patch
-fbdev-firmware-edid-fixes-fix.patch
-nvidiafb-add-support-for-geforce-6100-and-related-chipsets.patch
-fbdev-add-1366x768-wxga-mode-to-mode-database.patch
-vesafb-fix-return-code-of-vesafb_setcolreg.patch
-vesafb-prefer-vga-registers-over-pmi.patch
-vt-delay-the-update-of-the-visible-console.patch
-atyfb-fix-dead-code.patch
-fbdev-coverity-bug-85.patch
-fbdev-coverity-bug-90.patch
-fbdev-remove-unused-exports.patch
-s3c2410fb-fix-resume.patch
-backlight-fix-kconfig-dependency.patch
-au1100fb-add-power-management-support.patch
-au1100fb-add-power-management-support-tidy.patch
-skeletonfb-remove-duplicate-module-init-exit-license-lines.patch
-neofb-fix-unblank-logic-interfering-with-lid-toggled-backlight.patch
-gxfb-get-the-frambuffer-size-from-the-bios.patch
-fbdev-fix-logo-rotation-if-width-=-height.patch
-macmodes-fix-section-warning.patch
-atyfb-fix-section-warnings.patch
-detaching-fbcon-fix-vgacon-to-allow-retaking-of-the.patch
-detaching-fbcon-fix-give_up_console.patch
-detaching-fbcon-remove-calls-to-pci_disable_device.patch
-detaching-fbcon-add-sysfs-class-device-entry-for-fbcon.patch
-detaching-fbcon-clean-up-exit-code.patch
-detaching-fbcon-add-capability-to-attach-detach-fbcon.patch
-detaching-fbcon-update-documentation.patch
-vt-binding-add-binding-unbinding-support-for-the-vt.patch
-vt-binding-update-fbcon-to-support-binding.patch
-vt-binding-fbcon-update-documentation.patch
-vt-binding-add-new-doc-file-describing-the-feature.patch
-vt-binding-add-sysfs-control-to-the-vt-layer.patch
-vt-binding-add-sysfs-control-to-the-vt-layer-fix.patch
-vt-binding-make-vt-binding-a-kconfig-option.patch
-vt-binding-do-not-create-a-device-file-for-class-device.patch
-vt-binding-update-documentation.patch
-vt-binding-make-mdacon-support-binding.patch
-vt-binding-make-newport_con-support-binding.patch
-vt-binding-make-promcon-support-binding.patch
-vt-binding-make-sticon-support-binding.patch
-dm-snapshot-unify-chunk_size.patch
-lib-add-idr_replace.patch
-lib-add-idr_replace-tidy.patch
-dm-fix-idr-minor-allocation.patch
-dm-move-idr_pre_get.patch
-dm-change-minor_lock-to-spinlock.patch
-dm-add-dmf_freeing.patch
-dm-fix-mapped-device-ref-counting.patch
-dm-add-module-ref-counting.patch
-dm-fix-block-device-initialisation.patch
-dm-mirror-sector-offset-fix.patch
-dm-table-get_target-fix-last-index.patch
-dm-mirror-log-sector-size-fix.patch
-dm-mirror-log-refactor-context.patch
-dm-mirror-log-bitset_size-fix.patch
-dm-mirror-log-sync_count-fix.patch
-dm-kcopyd-error-accumulation-fix.patch
-dm-table-split_args-handle-no-input.patch
-dm-consolidate-creation-functions.patch
-dm-add-exports-2.patch
-dm-create-error-table.patch
-dm-prevent-removal-if-open.patch
-dm-improve-error-message-consistency.patch
-md-reformat-code-in-raid1_end_write_request-to-avoid-goto.patch
-md-remove-arbitrary-limit-on-chunk-size.patch
-md-remove-useless-ioctl-warning.patch
-md-increase-the-delay-before-marking-metadata-clean-and-make-it-configurable.patch
-md-merge-raid5-and-raid6-code.patch
-md-remove-nuisance-message-at-shutdown.patch
-md-allow-checkpoint-of-recovery-with-version-1-superblock.patch
-md-allow-checkpoint-of-recovery-with-version-1-superblock-fix.patch
-md-allow-a-linear-array-to-have-drives-added-while-active.patch
-md-support-stripe-offset-mode-in-raid10.patch
-md-make-md_print_devices-static.patch
-md-split-reshape-portion-of-raid5-sync_request-into-a-separate-function.patch
-md-bitmap-fix-online-removal-of-file-backed-bitmaps.patch
-md-bitmap-remove-bitmap-writeback-daemon.patch
-md-bitmap-cleaner-separation-of-page-attribute-handlers-in-md-bitmap.patch
-md-bitmap-use-set_bit-etc-for-bitmap-page-attributes.patch
-md-bitmap-remove-unnecessary-page-reference-manipulations-from-md-bitmap-code.patch
-md-bitmap-remove-dead-code-from-md-bitmap.patch
-md-bitmap-tidy-up-i_writecount-handling-in-md-bitmap.patch
-md-bitmap-change-md-bitmap-file-handling-to-use-bmap-to-file-blocks.patch
-md-change-md-bitmap-file-handling-to-use-bmap-to-file-blocks-fix.patch
-md-calculate-correct-array-size-for-raid10-in-new-offset-mode.patch
-md-md-kconfig-speeling-feex.patch
-md-fix-kconfig-error.patch
-md-fix-bug-that-stops-raid5-resync-from-happening.patch
-md-allow-re-add-to-work-on-array-without-bitmaps.patch
-md-dont-write-dirty-clean-update-to-spares-leave-them-alone.patch
-md-set-get-state-of-array-via-sysfs.patch
-md-allow-rdev-state-to-be-set-via-sysfs.patch
-md-allow-raid-layout-to-be-read-and-set-via-sysfs.patch
-md-allow-resync_start-to-be-set-and-queried-via-sysfs.patch
-md-allow-the-write_mostly-flag-to-be-set-via-sysfs.patch
-drivers-md-mdc-make-code-static.patch

 Merged into mainline or a subsystem tree.
 
+patch-kernel-acct-fix-function-definition.patch
+zlib-inflate-fix-function-definitions.patch
+pm_trace-is-bust.patch

 misc 2.6.17 stuff.

-disable-acpi-on-some-phoenix-bios.patch

 Dropped.

-cpu_relax-use-in-acpi-lock-fix.patch

 Folded into cpu_relax-use-in-acpi-lock.patch

+gregkh-driver-driver-core-fix-driver-core-kernel-doc.patch

 driver trees update

+gregkh-i2c-w1-remove-w1-mail-list-from-lm_sensors.patch

 i2c tree update

+git-geode-fixup.patch

 Fix reject due to git-geode.patch.

+git-gfs2-fixup.patch

 Fix reject due to git-gfs2.patch

-git-kbuild-revert-kbuild-ignore-makes-built-in-rules-variables.patch

 Dropped.

+revert-ignore-makes-built-in-rules-variables.patch

 Then restored.

+make-variables-static-after-klibc-merge.patch

 klibc cleanup

-git-hdrinstall-fixup.patch

 Dropped.

-via-pata-fails-on-some-atapi-drives.patch

 Dropped (I think)

+via-pata-controller-xfer-fixes.patch
+make-drivers-scsi-pata_it821xcit821x_passthru_dev_select-static.patch

 ata fixes

-s2io-driver-irq-fix-tidy.patch

 Folded into s2io-driver-irq-fix.patch

-qla3xxx-is-bust.patch

 Dropped.

+qla3xxx-nic-driver-updates.patch

 Update qla3xxx-NIC-driver.patch

+ioat-fix-sparse-ulong-warning.patch

 IOAT driver fix

+serial-add-tsi108-8250-serial-support-fix.patch

 serial device support

+git-scsi-misc-fixup.patch

 Fix reject due to git-scsi-misc.patch

+drivers-scsi-arcmsr-cleanups.patch

 Tidy areca-raid-linux-scsi-driver.patch

+dc395x-fix-printk-format-warning.patch

 scsi driver fixlet.

+gregkh-usb-usb-au1xxx-compile-fixes-for-ohci-for-au1200.patch
+gregkh-usb-usb-au1200-ehci-and-ohci-fixes.patch
+gregkh-usb-usb-ohci-bits-for-the-cirrus-ep93xx.patch
+gregkh-usb-usb-fix-usb-kernel-doc.patch
+gregkh-usb-usb-addition-of-vendor-product-id-pair-for-pl2303-driver.patch
+gregkh-usb-usb-new-device-id-for-thorlabs-motor-driver.patch
+gregkh-usb-usb-new-device-ids-for-ftdi_sio-driver.patch
+gregkh-usb-usb-ohci-hub-code-unaligned-access.patch
+gregkh-usb-usb-fix-usb-serial-leaks-oopses-on-disconnect.patch
+gregkh-usb-usb-fix-visor-leaks.patch
+gregkh-usb-usb-add-some-basic-wusb-definitions.patch
+gregkh-usb-usb-support-for-susteen-datapilot-universal-2-cable-in-pl2303.patch
+gregkh-usb-usbfs-use-the-correct-signal-number-for-disconnection.patch
+gregkh-usb-usb-rename-cypress-cy7c63xxx-driver-to-proper-name-and-fix-up-some-tiny-things.patch
+gregkh-usb-usb-update-for-acm-in-quirks-and-debug.patch
+gregkh-usb-usb-storage-fix-race-between-reset-and-disconnect.patch
+gregkh-usb-usb-hub-don-t-return-status-0-from-resume.patch
+gregkh-usb-usb-storage-unusual_devs-entry-for-motorola-razr-v3x.patch

 USB tree updates (be afraid)

-ipaqc-timing-parameters-fix.patch

 Folded into ipaqc-timing-parameters.patch

+x86_64-mm-ieee1394-early.patch

 x86_64 tree update

-revert-x86_64-mm-twofish-cipher---x86_64-assembler.patch
-revert-x86_64-mm-twofish-cipher---i586-assembler.patch
-revert-x86_64-mm-twofish-cipher---priority-fix.patch
-revert-x86_64-mm-twofish-cipher---split-out-common-c-code.patch

 Unneeded.

-x86_64-mm-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86-warning-fix.patch
-x86_64-msi-apic-build-fix.patch
-x86-nmi-fix.patch
-x86-nmi-fix-2.patch
-x86_64-apic-fix-apic-error-on-bootup.patch

 Mostly dropped.

-flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch

 Dropped.

+adix-tree-rcu-lockless-readside-fix-2.patch

 fix radix-tree patches in -mm.

-zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter-nfs-fix.patch

 Dropped, I think.

+use-zoned-vm-counters-for-numa-statistics-v3.patch
+light-weight-event-counters-v5.patch

 More VM counters work.

+selinux-inherit-proc-self-attr-keycreate-across-fork.patch

 SELinux update

-x86-re-enable-generic-numa.patch

 Dropped, it broke.

+fix-subarchitecture-breakage-with-config_sched_smt.patch
+voyager-fix-compile-after-setup-rework.patch
+fix-boot-on-efi-32-bit-machines.patch

 x86 stuff.

+apple-motion-sensor-driver-update.patch
+apple-motion-sensor-driver-update-2.patch

 Fix apple-motion-sensor-driver.patch

+rtc-add-a-comment-for-enoioctlcmd-in-ds1553_rtc_ioctl.patch
+ufs-ufs_read_inode-cleanup.patch
+tty-fix-tcsbrk-comment.patch
+fix-kernel-doc-in-kernel-dir.patch
+remove-active-field-from-tty-buffer-structure.patch
+rcutorture-catchup-doc-fixes-for-idle-hz-tests.patch
+rcutorture-add-ops-vector-and-classic-rcu-ops.patch
+rcutorture-add-call_rcu_bh-operations.patch
+ipmi-use-schedule-in-kthread.patch
+kdump-introduce-reset_devices-command-line-option.patch
+stallion-clean-up.patch
+rtc-fix-idr-locking.patch

 Misc patches.

-introduce-crashboot-kernel-command-line-parameter.patch
-kdump-cciss-driver-initialization-issue-fix.patch

 Dropped.

+cpu-hotplug-make-register_cpu_notifier-init-time-only-fix-fix.patch

 Fix cpu-hotplug-make-register_cpu_notifier-init-time-only.patch some more.

+cpu-hotplug-make-cpu_notifier-related-notifier-calls-__cpuinit-only-fix-fix.patch

 Fix
 cpu-hotplug-make-cpu_notifier-related-notifier-calls-__cpuinit-only.patch
 some more.

+delay-accounting-taskstats-interface-send-tgid-once.patch
+delay-accounting-taskstats-interface-send-tgid-once-fixes.patch
+per-task-delay-accounting-avoid-send-without-listeners.patch

 Update the task accounting patches.

-chardev-gpio-for-scx200-pc-8736x-add-platforn_device-static-numpins.patch
-chardev-gpio-for-scx200-pc-8736x-add-platforn_device-enomem-on-device_add-failure.patch
-chardev-gpio-for-scx200-pc-8736x-add-platforn_device-scx200-init-undo-malloc.patch

 Folded into chardev-gpio-for-scx200-pc-8736x-add-platforn_device.patch

-chardev-gpio-for-scx200-pc-8736x-add-new-pc8736x_gpio-no-static-init.patch
-chardev-gpio-for-scx200-pc-8736x-add-new-pc8736x_gpio-no-weird-comment-placement.patch
-chardev-gpio-for-scx200-pc-8736x-add-new-pc8736x_gpio-fixups.patch

 Folded into chardev-gpio-for-scx200-pc-8736x-add-new-pc8736x_gpio.patch

-chardev-gpio-for-scx200-pc-8736x-add-platform_device-request-region.patch
-chardev-gpio-for-scx200-pc-8736x-add-platform_device-request-region-series.patch

 Folded into chardev-gpio-for-scx200-pc-8736x-add-platform_device.patch

-chardev-gpio-for-scx200-pc-8736x-use-dev_dbg-extern-to-header.patch

 Folded into chardev-gpio-for-scx200-pc-8736x-use-dev_dbg.patch

-chardev-gpio-for-scx200-pc-8736x-fix-gpio_current-make-precedence-explicit.patch

 Folded into chardev-gpio-for-scx200-pc-8736x-fix-gpio_current.patch

-chardev-gpio-for-scx200-pc-8736x-replace-spinlocks-fix.patch

 Folded into chardev-gpio-for-scx200-pc-8736x-replace-spinlocks.patch

+knfsd-improve-the-test-for-cross-device-rename-in-nfsd.patch
+knfsd-fixing-missing-expkey-support-for-fsid-type-3.patch
+knfsd-remove-noise-about-filehandle-being-uptodate.patch
+knfsd-ignore-ref_fh-when-crossing-a-mountpoint.patch
+knfsd-nfsd4-fix-open_confirm-locking.patch
+knfsd-nfsd-call-nfsd_setuser-on-fh_compose-fix-nfsd4-permissions-problem.patch
+knfsd-nfsd4-remove-superfluous-grace-period-checks.patch
+knfsd-nfsd-fix-misplaced-fh_unlock-in-nfsd_link.patch
+knfsd-svcrpc-gss-simplify-rsc_parse.patch
+knfsd-nfsd4-fix-some-open-argument-tests.patch
+knfsd-nfsd4-fix-open-flag-passing.patch
+knfsd-svcrpc-simplify-nfsd-rpcsec_gss-integrity-code.patch
+knfsd-nfsd-mark-rqstp-to-prevent-use-of-sendfile-in-privacy-case.patch
+knfsd-svcrpc-gss-server-side-implementation-of-rpcsec_gss-privacy.patch

 nfsd updates

-sched_exit-fix-parent-time_slice-calculation.patch
-sched_exit-move-the-callsite-to-do_exit.patch

 Dropped.

-ecryptfs-superblock-operations-ecryptfs-build-fix.patch

 Dropped.

+ecryptfs-superblock-operations-ecryptfs_statfs-api-change.patch

 ecryptfs update

+readahead-kconfig-option-readahead_allow_overheads.patch
+readahead-state-based-method-aging-accounting-readahead-kconfig-option-readahead_smooth_aging.patch
+readahead-context-based-method-slow-start.patch
+readahead-call-scheme-no-fastcall-for-readahead_cache_hit-kconfig-option-readahead_hit_feedback.patch
+readahead-backward-prefetching-method-fix.patch
+readahead-remove-the-size-limit-of-max_sectors_kb-on-read_ahead_kb.patch

 readahead updates

+old-ide-fix-sata-detection-for-cabling.patch
+ide-clean-up-siimage.patch
+ide-sc1200-debug-printk.patch
+ide-fix-error-handling-for-drives-which-clear-the-fifo-on-error.patch
+ide-housekeeping-on-ide-drivers.patch
+ide-clean-up-pdc202xx_old-so-its-more-readable-done-so-i-could-work-on-libata-ports.patch
+ide-set-err_stops_fifo-for-newer-promise-as-well.patch

 IDE updates

+drivers-md-raid5c-remove-an-unused-variable.patch
+md-possible-fix-for-unplug-problem.patch
+md-set-desc_nr-correctly-for-version-1-superblocks.patch
+md-delay-starting-md-threads-until-array-is-completely-setup.patch
+md-fix-resync-speed-calculation-for-restarted-resyncs.patch
+md-fix-a-plug-unplug-race-in-raid5.patch
+md-fix-some-small-races-in-bitmap-plugging-in-raid5.patch
+md-fix-usage-of-wrong-variable-in-raid1.patch
+md-unify-usage-of-symbolic-names-for-perms.patch
+md-require-cap_sys_admin-for-re-configuring-md-devices-via-sysfs.patch
+md-fix-will-configure-message-when-interpreting-md=-kernel-parameter.patch
+md-include-sector-number-in-messages-about-corrected-read-errors.patch

 RAID updates

+genirq-core-revert-noisiness-on-spurious-interrupts.patch

 Fixlet for genirq-core.patch

+lockdep-floppyc-irq-release-fix.patch
+lockdep-acpi-locking-fix.patch
+lockdep-console_init-after-local_irq_enable.patch
+lockdep-add-is_module_address.patch
+lockdep-add-print_ip_sym.patch
+lockdep-add-per_cpu_offset.patch
+lockdep-add-disable-enable_irq_lockdep-api.patch
+lockdep-add-local_irq_enable_in_hardirq-api.patch
+lockdep-add-declare_completion_onstack-api.patch
+lockdep-clean-up-rwsems.patch
+lockdep-remove-rwsem_debug-remnants.patch
+lockdep-rename-debug_warn_on.patch
+lockdep-remove-debug_bug_on.patch
+lockdep-remove-mutex-deadlock-checking-code.patch
+lockdep-better-lock-debugging.patch
+lockdep-mutex-section-binutils-workaround.patch
+lockdep-locking-init-debugging-improvement.patch
+lockdep-beautify-x86_64-stacktraces.patch
+lockdep-x86_64-document-stack-frame-internals.patch
+lockdep-i386-remove-multi-entry-backtraces.patch
+lockdep-stacktrace-subsystem-core.patch
+lockdep-s390-config_frame_pointer-support.patch
+lockdep-stacktrace-subsystem-i386-support.patch
+lockdep-stacktrace-subsystem-x86_64-support.patch
+lockdep-stacktrace-subsystem-s390-support.patch
+lockdep-irqtrace-subsystem-core.patch
+lockdep-irqtrace-subsystem-docs.patch
+lockdep-irqtrace-subsystem-i386-support.patch
+lockdep-irqtrace-cleanup-of-include-asm-i386-irqflagsh.patch
+lockdep-irqtrace-subsystem-x86_64-support.patch
+lockdep-irqtrace-subsystem-x86_64-support-fix.patch
+lockdep-irqtrace-subsystem-x86_64-support-fix-2.patch
+lockdep-irqtrace-cleanup-of-include-asm-x86_64-irqflagsh.patch
+lockdep-irqtrace-subsystem-s390-support.patch
+lockdep-locking-api-self-tests.patch
+lockdep-core.patch
+lockdep-design-docs.patch
+lockdep-procfs.patch
+lockdep-prove-rwsem-locking-correctness.patch
+lockdep-prove-spinlock-rwlock-locking-correctness.patch
+lockdep-prove-mutex-locking-correctness.patch
+lockdep-kconfig.patch
+lockdep-print-all-lock-classes-on-sysrq-d.patch
+lockdep-x86_64-early-init.patch
+lockdep-x86-smp-alternatives-workaround.patch
+lockdep-do-not-recurse-in-printk.patch
+lockdep-fix-rt_hash_lock_sz.patch
+lockdep-s390-turn-validator-off-in-machine-check-handler.patch
+lockdep-enable-on-i386.patch
+lockdep-enable-on-x86_64.patch
+lockdep-enable-on-s390.patch
+lockdep-annotate-direct-io.patch
+lockdep-annotate-serial.patch
+lockdep-annotate-dcache.patch
+lockdep-annotate-i_mutex.patch
+lockdep-annotate-futex.patch
+lockdep-annotate-genirq.patch
+lockdep-annotate-waitqueues.patch
+lockdep-annotate-mm.patch
+lockdep-annotate-serio.patch
+lockdep-annotate-skb_queue_head_init.patch
+lockdep-annotate-timer-base-locks.patch
+lockdep-annotate-scheduler-runqueue-locks.patch
+lockdep-annotate-hrtimer-base-locks.patch
+lockdep-annotate-sock_lock_init.patch
+lockdep-annotate-af_unix-locking.patch
+lockdep-annotate-bh_lock_sock.patch
+lockdep-annotate-ieee1394-skb-queue-head-locking.patch
+lockdep-annotate-mmap_sem.patch
+lockdep-annotate-sunrpc-code.patch
+lockdep-annotate-ntfs-locking-rules.patch
+lockdep-annotate-the-quota-code.patch
+lockdep-annotate-usbfs.patch
+lockdep-annotate-sound-core-seq-seq_portsc.patch
+lockdep-annotate-sound-core-seq-seq_devicec.patch
+lockdep-annotate-8390c-disable_irq.patch
+lockdep-annotate-3c59xc-disable_irq.patch
+lockdep-annotate-forcedethc-disable_irq.patch
+lockdep-annotate-enable_in_hardirq.patch
+lockdep-annotate-on-stack-completions.patch
+lockdep-annotate-qeth-driver.patch
+lockdep-annotate-s_lock.patch
+lockdep-annotate-sb-s_umount.patch
+lockdep-annotate-slab-code.patch
+lockdep-annotate-blkdev-nesting.patch
+lockdep-annotate-vlan-net-device-as-being-a-special-class.patch

 Locking validator

-acpi-reduce-code-size-clean-up-fix-validator-message.patch

 Dropped.

+srcu-rcu-variant-permitting-read-side-blocking.patch
+srcu-rcu-variant-permitting-read-side-blocking-fixes.patch
+srcu-add-srcu-operations-to-rcutorture.patch
+srcu-add-srcu-operations-to-rcutorture-fix.patch

 New RCU features

+ioctl-messtxt-xfs-typos.patch

 Update documentation-ioctl-messtxt-start-tree-wide-ioctl-registry.patch


All 825 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm3/patch-list


