Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVCUK6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVCUK6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVCUK6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:58:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:2729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261746AbVCUKwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:52:33 -0500
Date: Mon, 21 Mar 2005 02:51:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc1-mm1
Message-Id: <20050321025159.1cabd62e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/


- We might have a fix here for the recent AGP/DRM problems.  If you were
  having problems with that, please test and report.

- An update to the hfs and hfsplus filesystems.

- Lots more pcmcia changes.

- Linus is away this week.  Not a lot more should be going into 2.6.12 now
  and I have a list of ~140 bugs, many of which are post-2.6.10 regressions. 
  We should fix these.




Changes since 2.6.11-mm4:


 linus.patch
 bk-acpi.patch
 bk-arm.patch
 bk-audit.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ia64.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-jfs.patch
 bk-kbuild.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch
 bk-scsi-rc-fixes.patch
 bk-serial.patch
 bk-usb.patch
 bk-watchdog.patch
 bk-xfs.patch

 Latest versions of various bk trees

-parport_pc-revert-netmos-patch.patch
-bk-acpi-acpi_pci_irq_disable-build-fix.patch
-acpi-poweroff-fix.patch
-acpi-poweroff-fix-fix.patch
-ide-hdiotxt-update.patch
-ide-serverworks-fix-section-references.patch
-arch-i386-pci-i386c-use-new-for_each_pci_dev-macro.patch
-pci-be-more-verbose-in-gen-devlist.patch
-usb-hcd-u64-warning-fix.patch
-log-full-of-ing_filter-fixed-ippp2-out-ippp2.patch
-ppc32-fix-powermac-cpufreq-for-newer-machines.patch
-ppc32-fix-overflow-in-cpuinfo-freq-display.patch
-ppc32-update-powermac-models-table.patch
-ppc32-add-virtual-dma-support-to-legacy-floppy-driver-on.patch
-ppc32-fix-a-warning-in-planb-video-driver.patch
-ppc32-delete-arch-ppc-syslib-ppc4xx_serialc.patch
-ppc32-lindent-include-asm-ppc-dmah.patch
-ppc32-better-comment-arch-ppc-syslib-cpc700h.patch
-ppc32-serial-fix-for-pal4.patch
-ppc32-fix-a-typo-on-8260.patch
-ppc32-update-8260_io-fcc_enetc-to-function-again.patch
-ppc32-patch-for-changed-dev-bus_id-format.patch
-ppc32-update-radstone-ppc7d-platform.patch
-ppc32-clean-up-mv64x60-bootwrapper-support.patch
-ppc32-fix-fec-ethernet-intialization-on-mpc8540-ads-board.patch
-ppc32-sparse-clean-ups-for-the-freescale-mpc52xx-related-code.patch
-ppc32-add-pci-bus-support-for-freescale-mpc52xx.patch
-ppc64-rtasd-shouldnt-hold-cpucontrol-while-sleeping.patch
-ppc64-fix-kprobes-calling-smp_processor_id-when-preemptible.patch
-ppc64-kill-might_sleep-warnings-in-__copy__user_inatomic.patch
-ppc64-make-rtas-code-usable-on-non-pseries-machines.patch
-ppc64-delete-unused-file-no_initrdc.patch
-ppc64-delete-unused-file-iseries_fixuph.patch
-ppc64-iseries-cleanup-viopath.patch
-ppc64-iseries-cleanup-iseries_setup.patch
-sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch
-blockdev-fixes-race-between-mount-umount.patch
-sealevel-8-port-rs-232-rs-422-rs-485-board.patch
-sisusb-fix-arg-types.patch
-matroxfb-compile-error.patch
-fix-u32-vs-pm_message_t-in-usb-fix.patch
-pwc-fix-printk-arg-types.patch

 Merged

+pcmcia-properly-bail-out-on-mtd-related-ioctl-invocation.patch
+pcmcia-dont-lock-up-in-rsrc_nonstatic-pcmcia_validate_mem.patch

 pcmcia fixes

+ppc64-preliminary-changes-to-of-fixup-functions.patch
+ppc64-make-of-node-fixup-code-usable-at-runtime.patch
+ppc64-introduce-pseries_reconfig.patch
+ppc64-promc-use-pseries-reconfig-notifier.patch

 ppc64 update

+handle-multiple-video-cards-on-the-same-bus.patch

 Video card detection fix

+acpi-create_polling_proc-fix.patch

 acpi fix

+fix-agp_backend-usage-in-drm_agp_init.patch

 Might fix the DRM problems

+arm-atomic_sub_and_test.patch

 ARM atomic_t API addition

+export-platform_add_devices.patch

 Export a symbol

+input-fix-fast-scrolling-scancodes-in-atkbdc.patch

 Input driver fix

+doc-describe-kbuild-pitfall.patch

 kbuild documentation tweak

+complete-cpufreq-kconfig-cleanup.patch

 cpufreq kconfig updates and fixes

+pci-pci-transparent-bridge-handling-improvements-pci-core.patch
+pci-pci-transparent-bridge-handling-improvements-yenta_socket.patch

 PCI bridge handling enhancements

+acpi-bridge-hotadd-acpi-based-root-bridge-hot-add.patch
+acpi-bridge-hotadd-fix-pci_enable_device-for-p2p-bridges.patch
+acpi-bridge-hotadd-make-pcibios_fixup_bus-hot-plug-safe.patch
+acpi-bridge-hotadd-prevent-duplicate-bus-numbers-when-scanning-pci-bridge.patch
+acpi-bridge-hotadd-take-the-pci-lock-when-modifying-pci-bus-or-device-lists.patch
+acpi-bridge-hotadd-link-newly-created-pci-child-bus-to-its-parent-on-creation.patch
+acpi-bridge-hotadd-make-the-pci-remove-routines-safe-for-failed-hot-plug.patch
+acpi-bridge-hotadd-remove-hot-plugged-devices-that-could-not-be-allocated-resources.patch
+acpi-bridge-hotadd-read-bridge-resources-when-fixing-up-the-bus.patch
+acpi-bridge-hotadd-allow-acpi-add-and-start-operations-to-be-done-independently.patch
+acpi-bridge-hotadd-export-the-interface-to-get-pci-id-for-an-acpi-handle.patch

 ACPI-based PCI bridge hotadd support

+zd1201-makefile-fix.patch

 Actually include this driver in the build.

+usb-wacom-driver-update.patch

 Tablet driver update

-sparsemem-base-teach-discontig-about-sparse-ranges.patch
-sparsemem-base-simple-numa-remap-space-allocator.patch
-sparsemem-base-reorganize-page-flags-bit-operations.patch
-sparsemem-base-early_pfn_to_nid-works-before-sparse-is-initialized.patch

 This was breaking compilation in various ways on various architectures. 
 Returned to manufacturer.

+vmscan-notice-slab-shrinking.patch

 vmscan slab reclaim fixes.  This isn't quite right.

+slab-shrinkers-use-vfs_cache_pressure.patch

 Allow /proc/sys/vm/vfs_cache_pressure to tune the mbcache and dquot caches
 as well.

+madvise-do-not-split-the-maps.patch
+madvise-merge-the-maps.patch

 Do vma merging in madvise().

+include-cleanup-in-pgalloch.patch

 Code cleanup

-e100-napi-fixes.patch
+e100-napi-state-machine-fix.patch

 New e100 napi fix

+smc91x-addr-config-check.patch
+smc91x-warning-fix.patch
+dm9000-network-driver.patch

 Net driver updates

+tcp-infrastructure-split-out.patch
+tcp-bic-11-support.patch
+tcp-westwood-support.patch
+tcp-westwood-support-kconfig-fix.patch
+tcp-vegas-support.patch
+tcp-high-speed-support.patch

 New tcp modes

+null-pointer-bug-in-netpollc.patch

 Fix a netpoll oops

+ppc32-fix-mv64x60-internal-sram-size.patch
+ppc32-move-83xx-85xx-device-and-system-description-files.patch
+ppc32-fix-config_serial_text_debug-support-on-83xx.patch

 ppc32 updates

+ppc64-pci_dnc-use-pseries-reconfig-notifier.patch
+ppc64-pseries_iommuc-use-pseries-reconfig-notifier.patch

 ppc64 updates

+mips-linkage-fix.patch

 MIPS build fix

+x86-cmos-time-update-optimisation-locking-fix-check.patch

 Check that George is telling the truth.

+i386-add-kstack=n-option-from-x86_64.patch
+kernel-parameters-ia-32-x86-64-cleanups.patch
+reduce-inlined-x86-memcpy-by-2-bytes.patch
+rename-fpu_verify_area-to-fpu_access_ok.patch

 x86 cleanups and little stuff.

+suspend-to-ram-update-videotxt-with-more-systems.patch
+pm-remove-obsolete-pm_-from-vtc.patch
+swsusp-small-updates.patch
+swsusp-1-1-kill-swsusp_restore.patch

 swsusp updates

+building-areca-arcmsr-driver-outside-kernel-source-tree.patch

 Fixes for areca-raid-linux-scsi-driver.patch

+cfq-ioschedc-fix-soft-hang-with-non-fs-requests.patch

 cfq3 fix

+revert-gconfig-changes-build-fix.patch

 gconfig build fix

+ext2_make_empty-information-leak.patch

 ext2 directory handling fix

+missing-set_fs-calls-around-kernel-syscall.patch

 Fix for in-kernel setscheduler() usage

+cpusets-mems-generation-deadlock-fix.patch
+cpusets-alloc-gfp_wait-sleep-fix.patch

 cpusets fixes

+mtrr-uaccess-range-checking-fix.patch
+cciss-range-checking-fix.patch

 Some range checking fixes

+fix-posix-timers-expiring-before-their-scheduled-time.patch

 POSIX timers accuracy

+fix-oops-when-inserting-ipmi_si-module.patch

 IPMI fix

+binfmt_elf-bss-padding-fix.patch

 Handle weird elf files better.

+posix-cpu-timers-and-cputime_t-divisons.patch

 Fix posix CPU timers for architectures which use cputime_t correctly.

+timers-prepare-for-del_timer_sync-changes.patch
+timers-rework-del_timer_sync.patch
+timers-serialize-timers.patch
+timers-remove-memory-barriers.patch
+timers-cleanup-kill-__get_base.patch

 del_timer_sync() speedups

+ext2-3-file-limits-to-avoid-overflowing-i_blocks.patch

 Fix ext2/ext3 large file corner case.

+load_elf_library-kfree-fix.patch

 Fix stupidity in load_elf_library()

+futex-queue_me-get_user-ordering-fix.patch

 Futex fix

+io_remap_pfn_range-add-for-all-arch-es.patch
+io_remap_pfn_range-add-for-all-arch-es-fix.patch
+io_remap_pfn_range-convert-sparc-callers.patch
+io_remap_pfn_range-fix-some-callers-for-xen.patch
+io_remap_pfn_range-convert-last-callers.patch

 Start to migrate from io_remap_page_range() to io_remap_pfn_range().

+alpha-build-fixes.patch

 Build fix

+fix-pcmcia-resume-with-card-inserted.patch

 pcmcia fix

+pcmcia-clean-up-suspend.patch

 pcmcia cleanup

+small-warning-fix-for-gcc4.patch

 gcc4 fix

+enable-sig_ign-on-blocked-signals.patch

 Permit setting of SIG_IGN from within signal handlers.

+alpha-elimitate-two-warnings-from-gcc4.patch

 Warning fixes

+hfs-free-page-buffers-in-releasepage.patch
+hfs-fix-umask-behaviour.patch
+hfs-more-bnode-error-checks.patch
+hfs-fix-sign-problem-in-hfs_ext_keycmp.patch
+hfs-use-parse-library-for-mount-options.patch
+hfs-add-nls-support.patch
+hfs-unicode-decompose-support.patch

 HFS filesystem update

-inotify.patch
-inotify-fix.patch
+inotify-42.patch

 y.a. inotify version.

+pcmcia-add-some-documentation.patch
+pcmcia-update-resource-database-adjust-routines-to-use-unsigned-long-values.patch
+pcmcia-mark-parent-bridge-windows-as-resources-available-for-pcmcia-devices.patch
+pcmcia-add-a-config-option-for-the-pcmica-ioctl.patch
+pcmcia-move-pcmcia-ioctl-to-a-separate-file.patch
+pcmcia-clean-up-cs-ds-callback.patch
+pcmcia-clean-up-cs-ds-callback-fix.patch
+pcmcia-make-pcmcia-status-a-bitfield.patch
+pcmcia-merge-struct-pcmcia_bus_socket-into-struct-pcmcia_socket.patch
+pcmcia-remove-unneeded-includes-in-dsc.patch
+pcmcia-rename-some-functions.patch
+pcmcia-move-pcmcia-resource-handling-out-of-csc.patch
+pcmcia-csc-cleanup.patch
+pcmcia-dsc-cleanup.patch
+pcmcia-release_class.patch
+pcmcia-use-request_region-in-i82365.patch
+pcmcia-synclink_cs-irq_info2_info-is-gone.patch
+pcmcia-mod_devicetableh-fix-for-different-sizes-in-kernel-and-userspace.patch

 PCMCIA update

+perfctr-cleanups-1-3-common.patch
+perfctr-cleanups-2-3-ppc32.patch
+perfctr-cleanups-3-3-x86.patch

 perfctr cleanups

-sched-improve-pinned-task-handling.patch
-sched-improve-pinned-task-handling-fix.patch
-sched-no-aggressive-idle-balancing.patch
-sched-better-active-balancing-heuristic.patch
-sched-generalised-cpu-load-averaging.patch
-sched-less-affine-wakups.patch
-sched-remove-aggressive-idle-balancing.patch
-sched-sched-domains-aware-balance-on-fork.patch
-sched-schedstats-additions-for-sched-balance-fork.patch
-sched-basic-tuning.patch
-random-ia64-sched-domains-values.patch
-add-sysctl-interface-to-sched_domain-parameters.patch
+sched2-fix-schedstats-warning.patch
+sched2-cleanup-wake_idle.patch
+sched2-improve-load-balancing-pinned-tasks.patch
+sched2-reduce-active-load-balancing.patch
+sched2-fix-smt-scheduling-problems.patch
+sched2-add-debugging.patch
+sched2-less-aggressive-idle-balancing.patch
+sched2-balance-timers.patch
+sched2-tweak-affine-wakeups.patch
+sched2-no-aggressive-idle-balancing.patch
+sched2-balance-on-fork.patch
+sched2-schedstats-update-for-balance-on-fork.patch
+sched2-sched-tuning.patch
+sched2-sched-tuning-fix.patch
+sched2-sched-domain-sysctl.patch

 The CPU scheduler patches were respun.

+kexec-reserve-bootmem-fix-for-booting-nondefault-location-kernel.patch

 kexec fix

+fbdev-cleanups-in-drivers-video-part-2-fix.patch

 Fix fbdev-cleanups-in-drivers-video-part-2.patch

+nvidiafb-process-boot-options-earlier.patch
+fbcon-save-var-rotate-field-in-struct-display.patch
+fbcon-call-set_par-per-fb_info-once-during-init.patch
+fbcon-do-not-set-palette-if-console-is-not-visible.patch
+nvidiafb-delete-i2c-bus-on-driver-unload.patch
+neofb-mmio-fixes.patch
+neofb-set-hwaccel-flags-properly.patch
+remove-redundant-null-checks-before-kfree-in-drivers-video.patch
+remove-redundant-null-checks-before-kfree-in-drivers-video-fix.patch

 fbdev driver updates

+fuse-mount-options-fix.patch

 FUSE fix

+riottyc-cleanups-and-warning-fix.patch
+fixup-a-comment-still-refering-to-verify_area.patch
+char-ds1620-use-msleep-instead-of-schedule_timeout.patch
+char-tty_io-replace-schedule_timeout-with-msleep_interruptible.patch
+kernel-timer-fix-msleep_interruptible-comment.patch
+ixj-compile-warning-cleanup.patch
+spelling-cleanups-in-shrinker-code.patch
+init-do_mounts_initrdc-fix-sparse-warning.patch
+arch-i386-kernel-trapsc-fix-sparse-warnings.patch
+arch-i386-kernel-apmc-fix-sparse-warnings.patch
+arch-i386-mm-faultc-fix-sparse-warnings.patch
+arch-i386-crypto-aesc-fix-sparse-warnings.patch
+codingstyle-trivial-whitespace-fixups.patch
+small-partitions-msdos-cleanups.patch
+remove-redundant-null-check-before-before-kfree-in.patch
+update-ross-biro-bouncing-email-address.patch
+get-rid-of-redundant-null-checks-before-kfree-in-arch-i386.patch
+remove-redundant-null-checks-before-kfree-in-sound-and.patch

 Little fixes and cleanups.



number of patches in -mm: 609
number of changesets in external trees: 553
number of patches in -mm only: 586
total patches: 1139




All 609 patches:


linus.patch

pcmcia-properly-bail-out-on-mtd-related-ioctl-invocation.patch
  pcmcia: properly bail out on MTD-related ioctl invocation

pcmcia-dont-lock-up-in-rsrc_nonstatic-pcmcia_validate_mem.patch
  pcmcia: don't lock up in rsrc_nonstatic pcmcia_validate_mem

pcmcia-dont-send-eject-request-events-to-userspace.patch
  pcmcia: don't send eject request events to userspace

ppc64-preliminary-changes-to-of-fixup-functions.patch
  ppc64: preliminary changes to OF fixup functions

ppc64-make-of-node-fixup-code-usable-at-runtime.patch
  ppc64: make OF node fixup code usable at runtime

ppc64-introduce-pseries_reconfig.patch
  ppc64: introduce pSeries_reconfig.[ch]

ppc64-promc-use-pseries-reconfig-notifier.patch
  ppc64: prom.c: use pSeries reconfig notifier

handle-multiple-video-cards-on-the-same-bus.patch
  handle multiple video cards on the same bus

tty-overrun-time-fix.patch
  tty overrun time fix

ia64-msi-warning-fixes.patch
  ia64 msi warning fixes

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

bk-acpi.patch

acpi-toshiba-failure-handling.patch
  acpi: Toshiba failure handling

acpi-video-pointer-size-fix.patch
  acpi video pointer size fix

acpi-create_polling_proc-fix.patch
  acpi: create_polling_proc() fix

agp-make-some-code-static.patch
  AGP: make some code static

fix-agp_backend-usage-in-drm_agp_init.patch
  Fix agp_backend usage in drm_agp_init

include-linux-soundcardh-endianness-fix.patch
  include/linux/soundcard.h: endianness fix

bk-arm.patch

arm-atomic_sub_and_test.patch
  arm atomic_sub_and_test()

bk-audit.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

export-platform_add_devices.patch
  export platform_add_devices

bk-drm.patch

bk-drm-via.patch

bk-i2c.patch

bk-ia64.patch

bk-ieee1394.patch

bk-input.patch

input-fix-fast-scrolling-scancodes-in-atkbdc.patch
  input: Fix fast scrolling scancodes in atkbd.c

bk-jfs.patch

bk-kbuild.patch

uml-make-deb-pkg-build-target-build-a-debian-style-user-mode-linux-package.patch
  uml: make deb-pkg build target build a Debian-style user-mode-linux package

uml-restore-proper-descriptions-in-make-deb-pkg-target.patch
  UML - Restore proper descriptions in make deb-pkg target

doc-describe-kbuild-pitfall.patch
  doc: describe Kbuild pitfall

complete-cpufreq-kconfig-cleanup.patch
  complete cpufreq Kconfig cleanup

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

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

megaraid_sas-announcing-new-module-for.patch
  megaraid_sas: Announcing new module for LSI Logic's SAS based MegaRAID controllers

open-iscsi-scsi.patch
  open-iscsi-scsi

open-iscsi-headers.patch
  open-iscsi-headers

open-iscsi-kconfig.patch
  open-iscsi-kconfig

open-iscsi-makefile.patch
  open-iscsi-makefile

open-iscsi-netlink.patch
  open-iscsi-netlink

open-iscsi-doc.patch
  open-iscsi-doc

bk-scsi-rc-fixes.patch

add-scsi-changer-driver.patch
  add scsi changer driver

scsi-ch-build-fix.patch
  scsi ch.c build fix

bk-serial.patch

bk-usb.patch

zd1201-makefile-fix.patch
  zd1201 makefile fix

zd1201-build-fix.patch
  zd1201 build fix

usb-support-for-new-ipod-mini-and-possibly-others.patch
  usb: support for new ipod mini (and possibly others)

usb-wacom-driver-update.patch
  usb: wacom driver update

bk-watchdog.patch

bk-xfs.patch

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

slab-kmalloc-cleanups.patch
  slab.[ch]: kmalloc() cleanups

slab-64bit-fix.patch
  slab: 64-bit fix

vmscan-move-code-to-isolate-lru-pages-into-separate-function.patch
  vmscan: move code to isolate LRU pages into separate function

mm-counter-operations-through-macros.patch
  mm counter operations through macros

mm-counter-operations-through-macros-tidy.patch
  mm-counter-operations-through-macros-tidt

vmscan-notice-slab-shrinking.patch
  vmscan: notice slab shrinking

slab-shrinkers-use-vfs_cache_pressure.patch
  slab shrinkers: use vfs_cache_pressure

madvise-do-not-split-the-maps.patch
  madvise: do not split the maps

madvise-merge-the-maps.patch
  madvise: merge the maps

include-cleanup-in-pgalloch.patch
  include cleanup in pgalloc.h

b44-allocate-tx-bounce-bufs-as-needed.patch
  b44: allocate tx bounce bufs as needed

eni155p-error-handling-fix.patch
  ENI155P error handling fix

drivers-net-myri_codeh-cleanup.patch
  drivers/net/myri_code.h cleanup

e100-napi-state-machine-fix.patch
  e100: NAPI state machine fix

remove-last_rx-update-from-loopback-device.patch
  remove last_rx update from loopback device

fix-pci_disable_device-in-8139too.patch
  fix pci_disable_device in 8139too

a-new-10gb-ethernet-driver-by-chelsio-communications.patch
  A new 10GB Ethernet Driver by Chelsio Communications

bonding-needs-inet.patch
  bonding needs inet

drivers-net-sis900c-fix-a-warning.patch
  drivers/net/sis900.c: fix a warning

fix-suspend-resume-on-via-velocity.patch
  Fix suspend/resume on via-velocity

pcnet32-bug-79c975-fiber-fix.patch
  pcnet32 79C975 fiber fix

we-18-aka-wpa.patch
  WE-18 (aka WPA)

smc91x-addr-config-check.patch
  smc91x: addr config check

smc91x-warning-fix.patch
  smc91x: warning fix

dm9000-network-driver.patch
  DM9000 network driver

tcp-infrastructure-split-out.patch
  TCP infrastructure split out

tcp-bic-11-support.patch
  TCP BIC 1.1 support

tcp-westwood-support.patch
  TCP Westwood+ support

tcp-westwood-support-kconfig-fix.patch
  tcp-westwood-support-kconfig-fix

tcp-vegas-support.patch
  TCP Vegas support

tcp-high-speed-support.patch
  TCP High speed support

null-pointer-bug-in-netpollc.patch
  NULL pointer bug in netpoll.c

ppc32-fix-mv64x60-internal-sram-size.patch
  ppc32: Fix mv64x60 internal SRAM size

ppc32-move-83xx-85xx-device-and-system-description-files.patch
  ppc32: Move 83xx & 85xx device and system description files

ppc32-fix-config_serial_text_debug-support-on-83xx.patch
  ppc32: Fix CONFIG_SERIAL_TEXT_DEBUG support on 83xx

ppc64-pci_dnc-use-pseries-reconfig-notifier.patch
  ppc64: pci_dn.c: use pSeries reconfig notifier

ppc64-pseries_iommuc-use-pseries-reconfig-notifier.patch
  ppc64: pSeries_iommu.c: use pSeries reconfig notifier

mips-linkage-fix.patch
  mips linkage fix

x86-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  x86: reduce cacheline bouncing in cpu_idle_wait

x86-cmos-time-update-optimisation.patch
  x86: CMOS time update optimisation

x86-cmos-time-update-optimisation-tidy.patch
  x86-cmos-time-update-optimisation-tidy

x86-cmos-time-update-optimisation-locking-fix.patch
  x86-cmos-time-update-optimisation locking fix

x86-cmos-time-update-optimisation-locking-fix-check.patch
  x86-cmos-time-update-optimisation-locking-fix-check

via-irq-fixup-fix.patch
  VIA irq fixup fix

via-irq-fixup-fix-warning-fix.patch
  via-irq-fixup-fix-warning-fix

apm-fix-interrupts-enabled-in-device_power_up.patch
  APM: fix interrupts enabled in device_power_up

rtc_lock-is-irq-safe.patch
  rtc_lock is irq-safe

fix-put_user-for-80386.patch
  fix put_user for 80386

es7000-legacy-mappings-update.patch
  ES7000 Legacy Mappings Update

x86-fix-esp-corruption-cpu-bug-take-2.patch
  x86: fix ESP corruption CPU bug (take 2)

es7000-dmi-cleanup.patch
  es7000 dmi cleanup

x86-x86_64-reading-deterministic-cache-parameters-and-exporting-it-in-sysfs.patch
  x86, x86_64: reading deterministic cache parameters and exporting it in /sysfs

x86-x86_64-intel-dual-core-detection.patch
  x86, x86_64: Intel dual-core detection

x86-cacheline-alignment-for-cpu-maps.patch
  x86: cacheline alignment for cpu maps

i386-add-kstack=n-option-from-x86_64.patch
  i386: add kstack=N option (from x86_64)

kernel-parameters-ia-32-x86-64-cleanups.patch
  kernel-parameters: IA-32/X86-64 cleanups

reduce-inlined-x86-memcpy-by-2-bytes.patch
  x86: reduce inlined memcpy by 2 bytes

rename-fpu_verify_area-to-fpu_access_ok.patch
  rename FPU_*verify_area to FPU_*access_ok

x86-64-kconfig-typo-trivial.patch
  x86-64: kconfig typo

x86_64-remove-old-decl-trivial.patch
  x86_64: remove old decl (trivial)

x86_64-avoid-panic-lockup.patch
  x86_64: avoid panic lockup

x86_64-hugetlb-fix.patch
  x86_64: hugetlb fix

x86-64-forgot-asmlinkage-on-sys_mmap.patch
  x86-64: forgot asmlinkage on sys_mmap

x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  x86_64: reduce cacheline bouncing in cpu_idle_wait

x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait-warning-fix.patch
  x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait-warning-fix

x86-64-kprobes-handle-%rip-relative-addressing-mode.patch
  x86-64 kprobes: handle %RIP-relative addressing mode

x86_64-dump-stack-in-early-exception.patch
  x86_64-dump-stack-in-early-exception

ia64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  ia64: reduce cacheline bouncing in cpu_idle_wait

ia64-reduce-cacheline-bouncing-in-cpu_idle_wait-fix.patch
  ia64-reduce-cacheline-bouncing-in-cpu_idle_wait fix

swsusp-add-missing-refrigerator-calls.patch
  swsusp: Add missing refrigerator calls

suspend-to-ram-update-videotxt-with-more-systems.patch
  suspend-to-ram: update video.txt with more systems

pm-remove-obsolete-pm_-from-vtc.patch
  pm: remove obsolete pm_* from vt.c

swsusp-small-updates.patch
  swsusp: small updates

swsusp-1-1-kill-swsusp_restore.patch
  swsusp: kill swsusp_restore

uml-cope-with-uml_net-security-fix.patch
  uml: cope with uml_net security fix

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

mtrr-size-and-base-debug.patch
  mtrr size-and-base debugging

cant-unmount-bad-inode.patch
  Can't unmount bad inode

iounmap-debugging.patch
  iounmap debugging

detect-soft-lockups.patch
  detect soft lockups

detect-soft-lockups-from-touch_nmi_watchdog.patch
  detect-soft-lockups: call from touch_nmi_watchdog

areca-raid-linux-scsi-driver.patch
  ARECA RAID Linux scsi driver

building-areca-arcmsr-driver-outside-kernel-source-tree.patch
  Building Areca arcmsr driver outside kernel source tree

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

stallion-driver-module-clean-up.patch
  Stallion driver module clean up

use-__init-and-__exit-in-pktcdvd.patch
  Use __init and __exit in pktcdvd

dvd-ram-support-for-pktcdvd.patch
  DVD-RAM support for pktcdvd

break_lock-fix-2.patch
  break_lock fix

cdrom-cdu31a-cleanups.patch
  cdrom/cdu31a: cleanups

cdrom-cdu31a-locking-fixes.patch
  cdrom/cdu31a: locking fixes

cdrom-cdu31a-use-wait_event.patch
  cdrom/cdu31a: use wait_event

revert-gconfig-changes.patch
  revert recent gconfig changes

revert-gconfig-changes-build-fix.patch
  revert-gconfig-changes build fix

enable-gcc-warnings-for-vsprintf-vsnprintf-with-format-attribute.patch
  Enable gcc warnings for vsprintf/vsnprintf with "format" attribute

w6692-eliminate-bad-section-references.patch
  w6692: eliminate bad section references

teles3-eliminate-bad-section-references.patch
  teles3: eliminate bad section references

elsa-eliminate-bad-section-references.patch
  elsa eliminate bad section references

hfc_sx-eliminate-bad-section-references.patch
  hfc_sx: eliminate bad section references

sedlbauer-eliminate-bad-section-references.patch
  sedlbauer: eliminate bad section references

fix-mprotect-with-len=size_t-1-to-return-enomem.patch
  fix mprotect() with len=(size_t)(-1) to return -ENOMEM

checkstack-fix-sort-misbehavior-for-long-function-names.patch
  checkstack: fix sort misbehavior for long function names

fix-irq_affinity-write-from-proc-for-ia64.patch
  Fix irq_affinity write from /proc for ia64

fix-mmap-return-value-to-conform-posix.patch
  fix mmap() return value to conform POSIX

exports-to-enable-clock-driver-modules.patch
  Exports to enable clock driver modules

per-cpu-irq-stat.patch
  Per cpu irq stat

kill-drivers-cdrom-mcdc.patch
  kill drivers/cdrom/mcd.c

drivers-char-isicomc-gcc4-fix.patch
  drivers/char/isicom.c gcc4 fix

drivers-net-arcnet-arcnetc-gcc4-fixes.patch
  drivers/net/arcnet/arcnet.c gcc4 fixes

drivers-net-depcac-gcc4-fix.patch
  drivers/net/depca.c gcc4 fix

infiniband-remove-unsafe-use-of-in_atomic.patch
  InfiniBand: remove unsafe use of in_atomic()

new-console-flag-con_boot.patch
  New console flag: CON_BOOT

new-console-flag-con_boot-comment.patch
  new-console-flag-con_boot-comment

pipe-save-one-pipe-page.patch
  pipe: save one pipe page

kprobes-incorrect-spin_unlock_irqrestore-call-in-register_kprobe.patch
  kprobes: incorrect spin_unlock_irqrestore() call in register_kprobe()

ext2_make_empty-information-leak.patch
  ext2_make_empty information leak fix

missing-set_fs-calls-around-kernel-syscall.patch
  Missing set_fs() calls around kernel syscall

cpusets-mems-generation-deadlock-fix.patch
  cpusets: mems generation deadlock fix

cpusets-alloc-gfp_wait-sleep-fix.patch
  cpusets: alloc GFP_WAIT sleep fix

mtrr-uaccess-range-checking-fix.patch
  mtrr: uaccess range checking fix

cciss-range-checking-fix.patch
  cciss: range chcking fix

fix-posix-timers-expiring-before-their-scheduled-time.patch
  Fix POSIX timers expiring before their scheduled time

fix-oops-when-inserting-ipmi_si-module.patch
  Fix oops when inserting ipmi_si module

binfmt_elf-bss-padding-fix.patch
  binfmt_elf bss padding fix

posix-cpu-timers-and-cputime_t-divisons.patch
  posix-cpu-timers and cputime_t divisons.

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

ext2-3-file-limits-to-avoid-overflowing-i_blocks.patch
  ext2/3 file limits to avoid overflowing i_blocks

load_elf_library-kfree-fix.patch
  load_elf_library kfree fix

futex-queue_me-get_user-ordering-fix.patch
  Futex: make futex_wait() atomic again

io_remap_pfn_range-add-for-all-arch-es.patch
  io_remap_pfn_range: add for all arch-es

io_remap_pfn_range-add-for-all-arch-es-fix.patch
  io_remap_pfn_range-add-for-all-arch-es-fix

io_remap_pfn_range-convert-sparc-callers.patch
  io_remap_pfn_range: convert sparc callers

io_remap_pfn_range-fix-some-callers-for-xen.patch
  io_remap_pfn_range: fix some callers for XEN

io_remap_pfn_range-convert-last-callers.patch
  io_remap_pfn_range: convert last callers

alpha-build-fixes.patch
  alpha build fixes

fix-pcmcia-resume-with-card-inserted.patch
  Fix PCMCIA resume with card inserted

pcmcia-clean-up-suspend.patch
  pcmcia: clean up suspend

small-warning-fix-for-gcc4.patch
  small warning fix for gcc4

enable-sig_ign-on-blocked-signals.patch
  Enable SIG_IGN on blocked signals

alpha-elimitate-two-warnings-from-gcc4.patch
  alpha: elimitate two warnings from gcc4

hfs-free-page-buffers-in-releasepage.patch
  hfs: free page buffers in releasepage

hfs-fix-umask-behaviour.patch
  hfs: fix umask behaviour

hfs-more-bnode-error-checks.patch
  hfs: more bnode error checks

hfs-fix-sign-problem-in-hfs_ext_keycmp.patch
  hfs: fix sign problem in hfs_ext_keycmp

hfs-use-parse-library-for-mount-options.patch
  hfs: use parse library for mount options

hfs-add-nls-support.patch
  hfs: add nls support

hfs-unicode-decompose-support.patch
  hfs: unicode decompose support

inotify-42.patch
  inotify #42

ext3-jbd-race-releasing-in-use-journal_heads.patch
  ext3/jbd race: releasing in-use journal_heads

ext3-writepages-support-for-writeback-mode.patch
  ext3 writepages support for writeback mode

ext3-writeback-nobh-option.patch
  ext3 writeback "nobh" option

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

figure-out-who-is-inserting-bogus-modules-warning-fix.patch
  Warning fix and be extra careful about array in kernel/module.c

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

x86_64-entry64.patch
  kexec: x86_64: add 64-bit entry

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

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-routines-for-copying-dump-pages-fixes.patch
  crashdump-routines-for-copying-dump-pages-fixes

crashdump-elf-format-dump-file-access.patch
  crashdump: elf format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear raw format dump file access

crashdump-linear-raw-format-dump-file-access-coding-style.patch
  crashdump-linear-raw-format-dump-file-access-coding-style

kdump-export-crash-notes-section-address-through.patch
  Kdump: Export crash notes section address through sysfs

kdump-export-crash-notes-section-address-through-build-fix.patch
  kdump-export-crash-notes-section-address-through build fix

kdump-export-crash-notes-section-address-through-x86_64-fix.patch
  kdump-export-crash-notes-section-address-through x86_64 fix

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

reiser4-export-inode_lock-unexport-__iget.patch
  reiser4-export-inode_lock-unexport-__iget

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-perthread_pages_alloc-cleanup.patch
  perthread_pages_alloc cleanup

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

fs-reiser4-possible-cleanups.patch
  fs/reiser4/: possible cleanups

reiser4-kconfig-help-cleanup.patch
  reiser4 Kconfig help cleanup

reiser4-cleanup-pg_arch_1.patch
  reiser4 cleanup (PG_arch_1)

reiser4-build-fix.patch
  reiser4 build fix

reiser4-update.patch
  reiser4 update

reiser4-only-memory_backed-fix.patch
  reiser4-only-memory_backed-fix

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

generic-serial-cli-conversion.patch
  generic-serial cli() conversion

specialix-io8-cli-conversion.patch
  Specialix/IO8 cli() conversion

sx-cli-conversion.patch
  SX cli() conversion

au1x00_uart-deadlock-fix.patch
  au1x00_uart deadlock fix

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

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

pm2fb-x-and-vt-switching-crash-fix.patch
  pm2fb: X and VT switching crash fix

nvidiafb-kconfig-help-text-update-for-config-fb_nvidia.patch
  nvidiafb: Kconfig help text update for config FB_NVIDIA

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

nvidiafb-process-boot-options-earlier.patch
  nvidiafb: Process boot options earlier

fbcon-save-var-rotate-field-in-struct-display.patch
  fbcon: Save var rotate field in struct display

fbcon-call-set_par-per-fb_info-once-during-init.patch
  fbcon: Call set_par per fb_info once during init

fbcon-do-not-set-palette-if-console-is-not-visible.patch
  fbcon: Do not set palette if console is not visible

nvidiafb-delete-i2c-bus-on-driver-unload.patch
  nvidiafb: Delete i2c bus on driver unload

neofb-mmio-fixes.patch
  neofb: mmio fixes

neofb-set-hwaccel-flags-properly.patch
  neofb: Set hwaccel flags properly

remove-redundant-null-checks-before-kfree-in-drivers-video.patch
  remove redundant NULL checks before kfree() in drivers/video/

remove-redundant-null-checks-before-kfree-in-drivers-video-fix.patch
  remove-redundant-null-checks-before-kfree-in-drivers-video fix

md-merge-md_enter_safemode-into-md_check_recovery.patch
  md: merge md_enter_safemode into md_check_recovery

md-improve-locking-on-safemode-and-move-superblock-writes.patch
  md: improve locking on 'safemode' and move superblock writes

md-improve-the-interface-to-sync_request.patch
  md: improve the interface to sync_request

md-optimised-resync-using-bitmap-based-intent-logging.patch
  md: optimised resync using Bitmap based intent logging

md-printk-fix.patch
  md printk fix

md-optimised-resync-using-bitmap-based-intent-logging-fix.patch
  md-optimised-resync-using-bitmap-based-intent-logging fix

md-raid1-support-for-bitmap-intent-logging.patch
  md: raid1 support for bitmap intent logging

md-raid1-support-for-bitmap-intent-logging-fix.patch
  md: initialise sync_blocks in raid1 resync

md-optimise-reconstruction-when-re-adding-a-recently-failed-drive.patch
  md: optimise reconstruction when re-adding a recently failed drive.

md-fix-deadlock-due-to-md-thread-processing-delayed-requests.patch
  md: fix deadlock due to md thread processing delayed requests.

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

post-halloween-doc.patch
  post halloween doc

fuse-maintainers-kconfig-and-makefile-changes.patch
  FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  FUSE - core

fuse-device-functions.patch
  FUSE - device functions

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

cryptoapi-prepare-for-processing-multiple-buffers-at.patch
  CryptoAPI: prepare for processing multiple buffers at a time

cryptoapi-update-padlock-to-process-multiple-blocks-at.patch
  CryptoAPI: Update PadLock to process multiple blocks at  once

drivers-isdn-divert-isdn_divertc-make-5-functions-static.patch
  drivers/isdn/divert/isdn_divert.c: make 5 functions static

drivers-isdn-capi-make-some-code-static.patch
  drivers/isdn/capi/: make some code static

fix-pm_message_t-in-generic-code.patch
  Fix pm_message_t in generic code

fix-u32-vs-pm_message_t-in-usb.patch
  Fix u32 vs. pm_message_t in USB

more-pm_message_t-fixes.patch
  more pm_message_t fixes

fix-u32-vs-pm_message_t-confusion-in-oss.patch
  Fix u32 vs. pm_message_t confusion in OSS

fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
  Fix u32 vs. pm_message_t confusion in PCMCIA

fix-u32-vs-pm_message_t-confusion-in-framebuffers.patch
  Fix u32 vs. pm_message_t confusion in framebuffers

fix-u32-vs-pm_message_t-confusion-in-mmc.patch
  Fix u32 vs. pm_message_t confusion in MMC

fix-u32-vs-pm_message_t-confusion-in-serials.patch
  Fix u32 vs. pm_message_t confusion in serials

fix-u32-vs-pm_message_t-in-macintosh.patch
  Fix u32 vs. pm_message_t in macintosh

fix-u32-vs-pm_message_t-confusion-in-agp.patch
  Fix u32 vs. pm_message_t confusion in AGP

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



