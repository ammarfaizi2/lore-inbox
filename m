Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWEAItc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWEAItc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 04:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWEAItc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 04:49:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751193AbWEAItb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 04:49:31 -0400
Date: Mon, 1 May 2006 01:47:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc3-mm1
Message-Id: <20060501014737.54ee0dd5.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc3/2.6.17-rc3-mm1/


- Added git-rbtree.patch to the -mm lineup (David Woodhouse).  It shrinks
  the rb-tree nodes.

- Added git-sas.patch to the -mm lineup (James Bottomley).  aic94xx serial
  attached storage driver.

- Added git-supertrak.patch to the -mm lineup (Jeff Garzik).  A driver for
  Promise SuperTrak controllers, from Promise.



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



Changes since 2.6.17-rc2-mm1:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-dvb.patch
 git-gfs2.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-rbtree.patch
 git-sas.patch
 git-pcmcia.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-splice.patch
 git-supertrak.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-frv.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees

-config_net=n-build-fix.patch
-remove-softlockup-from-invalidate_mapping_pages.patch
-x25-fix-for-spinlock-recurse-and-spinlock-lockup-with.patch
-off-by-1-in-kernel-power-mainc.patch
-request_irq-remove-warnings-from-irq-probing.patch
-input-fix-oops-on-mk712-load.patch
-mv643xx_eth-provide-sysfs-class-device-symlink.patch
-tpar-oops-fix.patch
-fix-array-overrun-in-drivers-char-mwave-mwaveddc.patch
-readd-the-oss-sound_cs4232-option.patch
-avoid-printing-pointless-tsc-skew-msgs.patch
-enable-x86_pc-for-hotplug_cpu.patch
-mark-vmsplit-embedded.patch
-kprobe-cleanup-for-vm_mask-judgement.patch
-kprobe-fix-resume-execution-on-i386.patch
-alsa-pcmcia-sound-devices-shouldnt-depend-on-isa.patch
-alsa-rmmod-oops-fix.patch
-iosched-use-hlist-for-request-hashtable.patch
-gregkh-driver-frame-buffer-remove-cmap-sysfs-interface.patch
-gregkh-driver-kobject-fix-build-error.patch
-gregkh-driver-fix-ocfs2-warning-when-debug_fs-is-not-enabled.patch
-gregkh-driver-kobject-possible-cleanups.patch
-gregkh-driver-added-uri-of-linux-kernel-development-process.patch
-sparc32-vivi-fix.patch
-vivi-build-fix.patch
-git-dvb-compat-build-fix.patch
-avermedia-6-eyes-avs6eyes-support.patch
-drivers-media-video-bt866c-small-fixes.patch
-drivers-media-video-bt866c-small-fixes-2.patch
-drivers-media-video-ks0127c-code-cleanup.patch
-bt866-build-fix.patch
-git-dvb-Kconfig-fix.patch
-git-dvb-Kconfig-fix-2.patch
-gregkh-i2c-w1-cleanups-fix.patch
-net-use-hlist_unhashed.patch
-ipv4-inet_init-fs_initcall.patch
-pci-quirk-via-irq-fixup-should-only-run-for-via-southbridges.patch
-megaraid_mmmbox-fix-a-bug-in-reset-handler.patch
-enable-advansys-driver.patch
-advansys-warning-workaround.patch
-scsi-clean-up-warnings-in-advansys-driver.patch
-scsi-clean-up-warnings-in-advansys-driver-fix.patch
-gregkh-usb-usb-resource-leak-fix-for-whiteheat-driver.patch
-gregkh-usb-usb-add-new-itegno-usb-cdma-1x-card-support-for-pl2303.patch
-gregkh-usb-usb-storage-unusual-devs-update.patch
-gregkh-usb-usb-storage-atmel-unusual-dev-update.patch
-gregkh-usb-usb-net2280-handle-stalls-for-0-length-control-in-requests.patch
-gregkh-usb-usb-net2280-send-0-length-packets-for-ep0.patch
-gregkh-usb-usb-net2280-check-for-shared-irqs.patch
-gregkh-usb-usb-net2280-set-driver-data-before-it-is-used.patch
-gregkh-usb-usb-use-new-pci_class_serial_usb_-defines.patch
-gregkh-usb-usb-ftdi_sio-vendor-code-for-rr-cirkits-locobuffer-usb.patch
-gregkh-usb-usb-ftdi_sio-adds-support-for-iplus-device.patch
-gregkh-usb-usb-ftdi_sio-add-support-for-ask-rdr-400-series-card-reader.patch
-x86_64-mm-acpi-nolapic.patch
-x86_64-mm-i386-up-generic-arch.patch
-sparsemem-interaction-with-memory-add-bug-fixes.patch
-x86-x86_64-avoid-irq0-ioapic-pin-collision.patch
-x86-x86_64-avoid-irq0-ioapic-pin-collision-tidy.patch
-s390-fix-i-o-termination-race-in-cio.patch
-s390-enable-interrupts-on-error-path.patch
-s390-bug-in-setup_rt_frame.patch
-s390-alternate-signal-stack-handling-bug.patch
-s390-qdio-memory-allocations.patch
-s390-dasd-ioctl-never-returns.patch
-s390-fix-slab-debugging.patch
-s390-futex-atomic-operations.patch
-s390-futex-atomic-operations-part-2.patch
-s390-tape-3590-changes.patch
-s390-segment-operation-error-codes.patch
-s390-instruction-processing-damage-handling.patch
-s390-add-read_mostly-optimization.patch
-s390-dasd-device-identifiers.patch
-s390-dasd-device-identifiers-fix.patch
-s390-new-system-calls.patch
-ia64-wire-up-compat_sys_adjtimex.patch
-suspend-documentation-update-for-ibm-thinkpad-x30.patch
-asiliantfb-add-help-text-in-kconfig.patch
-remove-redundant-null-checks-before-free-in-arch.patch

 Merged into mainline or a subsystem tree

+md-avoid-oops-when-attempting-to-fix-read-errors-on-raid10.patch
+md-fixed-refcounting-locking-when-attempting-read-error-correction-in-raid10.patch
+md-change-enotsupp-to-eopnotsupp.patch
+md-improve-detection-of-lack-of-barrier-support-in-raid1.patch
+md-fix-rdev-nr_pending-count-when-retrying-barrier-requests.patch
+x86_64-add-compat_sys_vmsplice-and-use-it-in.patch
+i386-x86-64-fix-acpi-disabled-lapic-handling.patch
+i386-fix-overflow-in-e820_all_mapped.patch
+i386-remove-apic=-warning.patch
+silence-initcall-warnings.patch
+uml-fix-iomem-list-traversal.patch
+uml-skas0-support-for-2g-2g-hosts.patch
+uml-remove-null-checks-and-add-some-codingstyle.patch
+uml-clean-up-after-madvise_remove.patch
+uml-update-defconfig.patch
+uml-error-handling-fixes.patch
+page-migration-fix-fallback-behavior-for-dirty-pages.patch
+altix-correct-ioc3-port-order.patch
+sparsemem-interaction-with-memory-add-bug-fixes.patch
+spufs-fix-for-config_numa.patch
+powerpc-allow-devices-to-register-with-numa-topology.patch
+powerpc-cell-add-numa-id-to-struct-spu.patch
+s390-fix-ipd-handling.patch
+s390-bug-in-setup_rt_frame.patch
+rtc-rtc-dev-tweak-for-64-bit-kernel.patch
+genrtc-fix-read-on-64-bit-platforms.patch
+amd-alchemy-uart-claim-memory-range.patch
+make-pc-speaker-driver-work-on-x86-64.patch
+timer-tsc-check-suspend-notifier-change.patch

 2.6.17 queue

+acpi-dock-driver-v3.patch

 Update acpi-dock-driver.patch

+acpiphp-use-new-dock-driver-v2.patch

 Update acpiphp-use-new-dock-driver.patch

+gregkh-driver-stable-abi-docs.patch
+gregkh-driver-cciss-device-symlink.patch

 Driver tree updates

-dvb-core-ule-fixes-and-rfc4326-additions-kernel-2616-tidy.patch

 Folded into dvb-core-ule-fixes-and-rfc4326-additions-kernel-2616.patch

+pwc-dec23-oops-fix.patch

 git-dvb fix

+gregkh-i2c-drivers-w1-w1.c-fix-a-compile-error.patch
+gregkh-i2c-w1-clean-up-w1_con-dependency.patch

 I2C tree updates

-opencores-i2c-bus-driver-tidy.patch
-opencores-i2c-bus-driver-fix.patch

 Folded into opencores-i2c-bus-driver.patch

+input-fix-oops-on-mk712-load.patch

 Input fix (will be unneeded once Linus pulls Dmitry's tree)

+forcedeth-fix-multi-irq-issues.patch
+forcedeth-add-support-for-flow-control.patch
+forcedeth-add-support-for-configuration.patch
+mv643xx_eth-provide-sysfs-class-device-symlink.patch

 net driver updates

+client-side-nfsacl-caching-fix.patch

 NFS fix

-powerpc-pseries-avoid-crash-in-pci-code-if-mem-system-not-up-tidy.patch

 Folded into powerpc-pseries-avoid-crash-in-pci-code-if-mem-system-not-up.patch

+git-rbtree-uml-fix.patch

 Fix git-rbtree.patch

+pci-add-pci_assign_resource_fixed-allow-fixed-address.patch
+pci-add-pci_assign_resource_fixed-allow-fixed-address-fix.patch
+add-a-enable-sysfs-attribute-to-the-pci-devices-to-allow.patch

 PCI updates

+areca-raid-linux-scsi-driver-update6-for-2617-rc1-mm3.patch
+areca-raid-linux-scsi-driver-update6-for-2617-rc1-mm3-externs-go-in-headers.patch

 Areca RAID driver updates

+scsi-clean-up-warnings-in-advansys-driver.patch

 advansys part-fix

+gregkh-usb-usb-usbcore-always-turn-on-hub-port-power.patch

 USB tree update

-fix-sco-on-some-bluetooth-adapters-tidy.patch

 Folded into fix-sco-on-some-bluetooth-adapters.patch

+x86_64-mm-disable-agp-resource-check.patch
+x86_64-mm-avoid-irq0-ioapic-pin-collision.patch
+x86_64-mm-gart-direct-call.patch
+x86_64-mm-new-northbridge.patch
+x86_64-mm-iommu-warning.patch
+x86_64-mm-serialize-assign_irq_vector-use-of-static-variables.patch
+x86_64-mm-simplify-ioapic_register_intr.patch
+x86_64-mm-i386-apic-overwrite.patch
+x86_64-mm-i386-up-generic-arch.patch
+x86_64-mm-iommu-enodev.patch
+x86_64-mm-fix-die_lock-nesting.patch
+x86_64-mm-add-nmi_exit-to-die_nmi.patch
+x86_64-mm-compat-printk.patch

 x86_64 tree updates

+x86_64-mm-compat-printk-fix.patch
+x86_64-mm-new-northbridge-fix.patch

 Fix it

+xfs-sparc32-build-fix.patch

 XFS build fix

-gregkh-devfs-ndevfs.patch

 Dropped from the remove-devfs tree

-migration-remove-unnecessary-pageswapcache-checks-fix.patch

 Folded into migration-remove-unnecessary-pageswapcache-checks.patch

-wait_table-and-zonelist-initializing-for-memory-hotadd-wait_table-initialization-fixes.patch

 Folded into wait_table-and-zonelist-initializing-for-memory-hotadd-wait_table-initialization.patch

 reserve-space-for-swap-label.patch
-swapless-v2-try_to_unmap-rename-ignrefs-to-migration.patch
-swapless-v2-add-migration-swap-entries.patch
-swapless-v2-make-try_to_unmap-create-migration-entries.patch
-swapless-v2-rip-out-swap-portion-of-old-migration-code.patch
-swapless-v2-revise-main-migration-logic.patch
-wait-for-migrating-page-after-incr-of-page-count-under-anon_vma-lock.patch
-preserve-write-permissions-in-migration-entries.patch
-preserve-write-permissions-in-migration-entries-fix.patch
-migration_entry_wait-use-the-pte-lock-instead-of-the-anon_vma-lock.patch
-read-write-migration-entries-implement-correct-behavior-in-copy_one_pte.patch
-read-write-migration-entries-make-mprotect-convert-write-migration.patch
-read-write-migration-entries-make-mprotect-convert-write-migration-fix.patch
-read-write-migration-entries-make-mprotect-convert-write-migration-fix-fix.patch
-read-write-migration-entries-make-mprotect-convert-write-migration-fix-fix-fix.patch
+page-migration-cleanup-rename-ignrefs-to-migration.patch
+page-migration-cleanup-group-functions.patch
+page-migration-cleanup-remove-useless-definitions.patch
+page-migration-cleanup-drop-nr_refs-in-remove_references.patch
+page-migration-cleanup-extract-try_to_unmap-from-migration-functions.patch
+page-migration-cleanup-pass-mapping-to-migration-functions.patch
+page-migration-cleanup-move-fallback-handling-into-special-function.patch
+swapless-pm-add-r-w-migration-entries.patch
+swapless-page-migration-rip-out-swap-based-logic.patch
+swapless-page-migration-modify-core-logic.patch
+more-page-migration-do-not-inc-dec-rss-counters.patch
+more-page-migration-use-migration-entries-for-file-pages.patch

 The page-migration-without-using-swapcache patches were redone

-slab-cleanup-kmem_getpages-fix.patch

 Folded into slab-cleanup-kmem_getpages.patch

-slab-stop-using-list_for_each-fix.patch

 Folded into slab-stop-using-list_for_each.patch

+swsusp-rework-memory-shrinker-rev-2-fix.patch

 Folded into swsusp-rework-memory-shrinker-rev-2.patch

+pgdat-allocation-for-new-node-add-specify-node-id-build-fixes.patch

 Fix pgdat-allocation-for-new-node-add-specify-node-id.patch some more

+register-hot-added-memory-to-iomem-resource.patch
+catch-valid-mem-range-at-onlining-memory.patch
+catch-valid-mem-range-at-onlining-memory-tidy.patch
+catch-valid-mem-range-at-onlining-memory-fix.patch
+slab-redzone-double-free-detection.patch
+buglet-in-radix_tree_tag_set.patch

 Memory management updates

+x86-dont-trigger-full-rebuild-via-config_mtrr.patch

 x86 fix

+dont-use-flush_tlb_all-in-suspend-time.patch
+dont-use-flush_tlb_all-in-suspend-time-tidy.patch

 swsusp-related fixes

+uml-fix-patch-mismerge.patch
+uml-search-from-uml_net-in-a-more-reasonable-path.patch
+uml-use-kbuild-tracking-for-all-files-and-fix-compilation-output.patch
+uml-fix-compilation-and-execution-with-hardened-gcc.patch
+uml-cleanup-unprofile-expression-and-build-infrastructure.patch
+uml-export-symbols-added-by-gcc-hardened.patch

 UML updates for 2.6.17

+uml-make-copy__user-atomic.patch
+uml-fix-not_dead_yet-when-directory-is-in-bad-state.patch
+uml-rename-and-improve-actually_do_remove.patch

 UML updates for post-2.6.17

+s390-hypervisor-file-system.patch
+s390-hypervisor-file-system-fixes.patch

 s390 feature

+percpu-counter-data-type-changes-to-suppport-fix-fix.patch

 Fix percpu-counter-data-type-changes-to-suppport.patch some more (it's still
 a bit leaky).

+rcu-introduce-rcu_needs_cpu-interface-fix.patch

 Fix rcu-introduce-rcu_needs_cpu-interface.patch

+handle-config_lbd-and-config_lsf-in-one-place.patch
+config_net=n-build-fix.patch
+remove-softlockup-from-invalidate_mapping_pages.patch
+add-doc-submitchecklist.patch
+kernel-sysc-doesnt-need-inith.patch

 Misc updates

+smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing-fix-2patch.patch

 Fix
 smpnice-dont-consider-sched-groups-which-are-lightly-loaded-for-balancing.patch
 some more

+fbdev-more-accurate-sync-range-extrapolation.patch
+nvidiafb-revise-pci_device_id-table.patch
+atyfb-fix-hardware-cursor-handling.patch
+atyfb-remove-unneeded-calls-to-wait_for_idle.patch
+atyfb-set-correct-acceleration-flags.patch
+epson1355fb-update-platform-code.patch
+vesafb-update-platform-code.patch
+vfb-update-platform-code.patch
+vga16fb-update-platform-code.patch
+fbdev-static-pseudocolor-with-depth-less-than-4-does.patch
+savagefb-whitespace-cleanup.patch
+fbdev-firmware-edid-fixes.patch
+fbdev-firmware-edid-fixes-fix.patch

 fbdev updates

+md-reformat-code-in-raid1_end_write_request-to-avoid-goto.patch
+md-remove-arbitrary-limit-on-chunk-size.patch
+md-remove-useless-ioctl-warning.patch
+md-increase-the-delay-before-marking-metadata-clean-and-make-it-configurable.patch
+md-merge-raid5-and-raid6-code.patch
+md-remove-nuisance-message-at-shutdown.patch
+md-allow-checkpoint-of-recovery-with-version-1-superblock.patch
+md-allow-a-linear-array-to-have-drives-added-while-active.patch
+md-support-stripe-offset-mode-in-raid10.patch
+md-make-md_print_devices-static.patch
+md-split-reshape-portion-of-raid5-sync_request-into-a-separate-function.patch

 RAID updates

+profile-likely-unlikely-macros.patch
+profile-likely-unlikely-macros-tidy.patch
+profile-likely-unlikely-macros-fix.patch
+profile-likely-unlikely-macros-fix-2.patch
+fix-gcc-3x-w-likely-profiling.patch

 Add /proc/likely_prof: gives stats which can be used to confirm whether
 instances of likely() and unlikely() are correct.

+exit-dont-call-sleeping-things-when-oopsing.patch

 Attempt to reduce unpleasant recursions when the kernel is oopsing.




All 747 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc3/2.6.17-rc3-mm1/patch-list

