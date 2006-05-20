Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWETMlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWETMlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 08:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWETMlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 08:41:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964824AbWETMlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 08:41:14 -0400
Date: Sat, 20 May 2006 05:41:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc4-mm2
Message-Id: <20060520054103.46a6edb5.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm2/


- Major rework in the libata (SATA) drivers.  If anyone has had any problem
  with the SATA drivers, please test this tree and report the results.  We
  expect it to fix quite a few things.

- reiser4 doesn't compile, due to changes to core pagecache APIs.  The fix
  wasn't obvious.

- resume-from-disk doesn't locate the resume partition, apparently due to an
  interaction between the klibc patch and RH FC5 userspace.  It might be OK on
  other distros.




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




Changes since 2.6.17-rc4-mm1:


origin.patch
git-acpi.patch
git-agpgart.patch
git-alsa.patch
git-arm.patch
git-audit-master.patch
git-block.patch
git-cfq.patch
git-cifs.patch
git-dvb.patch
git-gfs2.patch
git-ia64.patch
git-infiniband.patch
git-intelfb.patch
git-klibc.patch
git-hdrcleanup.patch
git-hdrinstall.patch
git-libata-all.patch
git-mips.patch
git-mmc.patch
git-mtd.patch
git-netdev-all.patch
git-nfs.patch
git-ocfs2.patch
git-powerpc.patch
git-rbtree.patch
git-sas.patch
git-pcmcia.patch
git-scsi-target.patch
git-supertrak.patch
git-watchdog.patch
git-cryptodev.patch
git-viro-bird-m32r.patch
git-viro-bird-m68k.patch
git-viro-bird-frv.patch
git-viro-bird-upf.patch
git-viro-bird-volatile.patch

 git trees

-selinux-check-for-failed-kmalloc-in-security_sid_to_context.patch
-fs-openc-unexport-sys_openat.patch
-autofs4-nfy_none-wait-race-fix.patch
-autofs4-nfy_none-wait-race-fix-tidy.patch
-fix-capi-reload-by-unregistering-the-correct-major.patch
-tpm-update-module-dependencies.patch
-pcmcia-oopses-fixes.patch
-via-quirk-fixup-additional-pci-ids.patch
-smbfs-chroot-issue-cve-2006-1864.patch
-rcu-introduce-rcu_needs_cpu-interface.patch
-rcu-introduce-rcu_needs_cpu-interface-fix.patch
-s390-exploit-rcu_needs_cpu-interface.patch
-setup_per_zone_pages_min-overflow-fix.patch
-s390-lcs-incorrect-test.patch
-initramfs-fix-cpio-hardlink-check.patch
-s390-add-vmsplice-system-call.patch
-symbol_put_addr-locks-kernel.patch
-contact-info-update.patch
-smbfs-fix-slab-corruption-in-samba-error-path.patch
-add-slab_is_available-routine-for-boot-code.patch
-led-improve-kconfig-information.patch
-backlight-lcd-class-fix-sysfs-_store-error-handling.patch
-led-add-maintainer-entry-for-the-led-subsystem.patch
-led-fix-sysfs-store-function-error-handling.patch
-v9fs-twalk-memory-leak.patch
-v9fs-signal-handling-fixes.patch
-fix-can_share_swap_page-when-config_swap.patch
-add-core-solo-and-core-duo-support-to-oprofile.patch
-tpm-fix-constant.patch
-final-rio-polish.patch
-final-rio-polish-fix.patch
-tpm_register_hardware-gcc-41-warning-fix.patch
-fs-compatc-fix-if-a-=-b-typo.patch
-root-mount-failure-emit-filesystems-attempted.patch
-revert-vfs-propagate-mnt_flags-into-do_loopback-vfsmount.patch
-smbus-unhiding-kills-thermal-management.patch
-fix-hotplug-kconfig-help.patch
-gigaset-endian-fix.patch
-fix-typos-in-documentation-memory-barrierstxt.patch
-ide_cs-add-ibm-microdrive-to-known-ids.patch
 nfs-fix-error-handling-on-access_ok-in-compat_sys_nfsservctl.patch
-devices-txt-remove-pktcdvd-entry.patch
-jffs2-warning-fixes.patch
-dl2k-build-fix.patch
-sem2mutex-drivers-acpi.patch
-sem2mutex-acpi-acpi_link_lock.patch
-acpi-ia64-wake-on-lan-fix.patch
-for_each_possible_cpu-under-drivers-acpi.patch
-acpi_bus_unregister_driver-make-void.patch
-acpi_os_wait_semaphore-dont-complain-about-timeout.patch
-memory-leak-in-acpi_evaluate_integer.patch
-ia64-acpi_memhotplug-fix.patch
-fw-memory-leakages-in-driver-acpi-videoc.patch
-acpi-idle-__read_mostly-and-de-init-static-var.patch
-acpi-suppress-power-button-event-on-s3-resume.patch
-gregkh-driver-driver-core-add-sys-hypervisor-when-needed.patch
-gregkh-driver-spi-per-transfer-overrides-for-wordsize-and-clocking.patch
-gregkh-driver-spi-add-pxa2xx-ssp-spi-driver.patch
-gregkh-driver-spi-spi-whitespace-fixes.patch
-gregkh-driver-spi-spi-bounce-buffer-has-a-minimum-length.patch
-gregkh-driver-spi-add-david-as-the-spi-subsystem-maintainer.patch
-gregkh-driver-spi-renamed-bitbang_transfer_setup-to-spi_bitbang_setup_transfer-and-export-it.patch
-gregkh-driver-spi-devices-can-require-lsb-first-encodings.patch
-gregkh-driver-spi-busnum-0-needs-to-work.patch
-gregkh-driver-spi-update-to-pxa2xx-spi-driver.patch
-gregkh-driver-spi-spi_bitbang-clocking-fixes.patch
-spi-added-spi-master-driver-for.patch
-drivers-base-firmware_classc-cleanups.patch
-s3c24xx-gpio-based-spi-driver.patch
-s3c24xx-hardware-spi-driver.patch
-s3c24xx-hardware-spi-driver-tidy.patch
-i2c-add-support-for-virtual-i2c-adapters.patch
-git-klibc-alpha-fixes.patch
-git-klibc-ident-fix.patch
-nand_base-modular-fix.patch
-git-mtd-non-arm-fix.patch
-git-mtd-isnt-arm-only.patch
-fix-mem-leak-in-netfilter.patch
-powerpc-pseries-increment-fail-counter-in-pci-recovery.patch
-x86_64-mm-fix-b44-checks.patch
-x86_64-mm-nommu-warning.patch
-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix.patch
-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix-fix.patch
-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86_64-fix.patch
-x86_64-mm-hotadd-reserve-fix-fix-fix.patch
-x86_64-mm-serialize-assign_irq_vector-use-of-static-variables-fix.patch
-git-klibc-build-hacks.patch
-matroxfb-fix-dvi-setup-to-be-more-compatible.patch

 Merged into mainlin or a subsystem tree

+matroxfb-fix-dvi-setup-to-be-more-compatible.patch
+i386-remove-junk-from-stack-dump.patch
+powerpc-fix-ide-pmac-sysfs-entry.patch
+kdump-maintainer-info-update.patch
+nfs-server-subtree_check-returns-dubious-value.patch
+md-fix-inverted-test-for-repair-directive.patch
+nfsd-sign-conversion-obscuring-errors-in-nfsd_set_posix_acl.patch
+x86_64-dont-warn-for-overflow-in-nommu-case-when-dma_mask-is-32bit-fix.patch
+hid-read-busywait-fix.patch
+binfmt_flat-dont-check-for-emfile.patch
+selinux-endian-fix.patch
+x86_64-mm-hotadd-reserve-fix-fix-fix.patch
+sparsemem-incorrectly-calculates-section-number.patch
+fix-race-in-inotify_release.patch
+pci-correctly-allocate-return-buffers-for-osc-calls.patch
+cpuset-might-sleep-checking-zones-allowed-fix.patch
+cpuset-update-cpuset_zones_allowed-comment.patch
+cpuset-might_sleep_if-check-in-cpuset_zones_allowed.patch
+overrun-in-isdn_ttyc.patch
+clarify-maintainers-and-include-linux-security-info.patch
+update-ext2-ext3-jbd-maintainers-entries.patch
+minor-spi-doc-fix.patch
+spi-added-spi-master-driver-for.patch
+drivers-base-firmware_classc-cleanups.patch
+s3c24xx-gpio-based-spi-driver.patch
+s3c24xx-hardware-spi-driver.patch
+s3c24xx-hardware-spi-driver-tidy.patch
+pxa2xx-spi-update.patch
+i386-kdump-boot-cpu-physical-apicid-fix.patch
+kprobes-bad-manupilation-of-2-byte-opcode-on-x86_64.patch
+missing-newline-in-scsi-stc.patch
+fix-a-no_idle_hz-timer-bug.patch
+revert-forcedeth-fix-multi-irq-issues.patch
+s390-next_timer_interrupt-overflow-in-stop_hz_timer.patch
+kbuild-check-sht_rel-sections.patch
+kbuild-fix-modpost-segfault-for-64bit-mipsel-kernel.patch
+rtc-subsystem-use-enoioctlcmd-and-enotty-where-appropriate.patch
+via-rhine-revert-change-mdelay-to-msleep-and-remove-from-isr-path.patch
+fix-broken-vm86-interrupt-signal-handling.patch
+kobject-quiet-errors-in-kobject_add.patch
+align-the-node_mem_map-endpoints-to-a-max_order-boundary.patch
+pd6729-section-fix.patch
+i810-section-fix.patch
+mpu401-section-fix.patch
+es18xx-build-fix.patch
+nm256_audio-section-fix.patch
+ad1848-section-fix.patch

 2.6.17 patch queue (mostly)

+fix-drivers-mfd-ucb1x00-corec-irq-probing-bug.patch

 ARM driver fix

+git-audit-master-build-fix.patch
+kauditd_thread-warning-fix.patch
+audit-build-fix.patch

 audit tree fixups

+create-sys-hypervisor-when-needed.patch
+s390_hypfs-filesystem.patch

 s/390 hypervisor filesystem

+gregkh-driver-kobject_add-make-people-pay-attention-to-errors.patch

 driver treeupdate

+input-move-fixp-arithh-to-drivers-input.patch
+input-fix-accuracy-of-fixp-arithh.patch
+input-new-force-feedback-interface.patch
+input-adapt-hid-force-feedback-drivers-for-the-new-interface.patch
+input-adapt-uinput-for-the-new-force-feedback-interface.patch
+input-adapt-iforce-driver-for-the-new-force-feedback-interface.patch
+input-force-feedback-driver-for-pid-devices.patch
+input-force-feedback-driver-for-zeroplus-devices.patch
+input-update-documentation-of-force-feedback.patch
+input-drop-the-remains-of-the-old-ff-interface.patch
+input-drop-the-old-pid-driver.patch

 input force-feedback driver update

+kbuild-export-type-enhancement-to-modpostc-fix.patch

 Fix kbuild-export-type-enhancement-to-modpostc.patch

+git-klibc-build-hacks.patch
+git-klibc-stdint-build-fix.patch
+git-klibc-stdint-build-fix-2.patch

 git-klibc fixes

+libata-reduce-timeouts.patch

 Add `libata.ata_qc_timeout' kernel/module parameter to avoid insane timeouts
 when probing not-present SATA disks.

+libata-debug.patch

 Try to work out what's happening with a SATA discovery problem.

+2.6.17-rc4-mm1-ich8-fix.patch

 Work aroud the SATA discovery problem.

+git-mtd-fixup.patch

 Fix rejects in git-myd.patch

+git-mtd-symbol_get-fix.patch
+git-mtd-moddi-fix.patch

 Fix git-mtd.patch

-git-netdev-all-e1000-fixup.patch

 Dropped

+e1000-endian-fixes.patch

 e1000 fix

-forcedeth-suggested-cleanups.patch
-forcedeth-add-support-for-flow-control.patch
-forcedeth-add-support-for-configuration.patch

 Dropped due to patch rejects

+drivers-net-s2ioc-make-bus_speed-static.patch

 net driver cleanup

+secmark-add-new-flask-definitions-to-selinux.patch
+secmark-add-selinux-exports.patch
+secmark-add-secmark-support-to-core-networking.patch
+secmark-add-xtables-secmark-target.patch
+secmark-add-secmark-support-to-conntrack.patch
+secmark-add-connsecmark-xtables-target.patch
+secmark-add-new-packet-controls-to-selinux.patch

 Security feature work

-nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
-nfs-permit-filesystem-to-perform-statfs-with-a-known-root-dentry.patch
-ipath-vs-nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
-git-gfs2-vs-nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
-nfs-abstract-out-namespace-initialisation.patch
-nfs-add-dentry-materialisation-op.patch
-nfs-split-fs-nfs-inodec-into-inode-superblock-and-namespace-bits.patch
-nfs-share-nfs-superblocks-per-protocol-per-server-per-fsid.patch
-nfs-share-nfs-superblocks-per-protocol-per-server-per-fsid-fix.patch
-nfs-share-nfs-superblocks-per-protocol-per-server-per-fsid-warning-fixes.patch
-fs-cache-provide-a-filesystem-specific-syncable-page-bit.patch
-fs-cache-add-notification-of-page-becoming-writable-to-vma-ops.patch
-fs-cache-avoid-enfile-checking-for-kernel-specific-open-files.patch
-fs-cache-generic-filesystem-caching-facility.patch
-fs-cache-make-kafs-use-fs-cache.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-export-__audit_inode_child.patch
-fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-warning-fixes.patch
-fs-cache-vs-vfs-add-lock-owner-argument-to-flush-operation.patch
-fs-cache-release-page-private-in-failed-readahead.patch
-fs-cache-release-page-private-in-failed-readahead-uninlining.patch
-fs-cache-release-page-private-in-failed-readahead-uninlining-2.patch
-nfs-use-local-caching.patch
-nfs-use-local-caching-fix.patch

 Dropped due to general overload - will restore it soon.

+kconfigurable-resources-mtd-fixes.patch

 Fix MTD for the variable resource.start, .end patches.

+pcmcia-irq-debugging.patch

 PCMCIA IRQ debugging.

+ppa-no-highmem-pages.patch
+imm-no-need-for-unchecked_isa_dma.patch
+scsi-make-scsi_implement_eh-generic-api-for-scsi-transports.patch

 SCSI driver updates

+git-scsi-target-fixup.patch

 Fix reject in git-scsi-target.patch

+gregkh-usb-usb-add-yealink-phones-to-the-hid_quirk_ignore-blacklist.patch
+gregkh-usb-usb-cdc-acm-add-a-new-special-case-for-modems-with-buggy-firmware.patch
+gregkh-usb-usb-usbnet-zaurus-mtu-fixup.patch
+gregkh-usb-usbhid-automatically-set-hid_quirk_noget-for-keyboards-and-mice.patch
+gregkh-usb-usb-ohci-avoids-root-hub-timer-polling.patch
+gregkh-usb-uhci-common-result-routine-for-control-bulk-interrupt.patch
+gregkh-usb-uhci-remove-non-iso-tds-as-they-are-used.patch
+gregkh-usb-uhci-move-code-for-cleaning-up-unlinked-urbs.patch
+gregkh-usb-uhci-eliminate-the-td-removal-list.patch
+gregkh-usb-uhci-reimplement-fsbr.patch
+gregkh-usb-uhci-work-around-old-intel-bug.patch
+gregkh-usb-usb-serial-mos7720.patch

 USB tree updates

+gregkh-usb-usb-serial-mos7720-powerpc-wrokaround.patch

 Broke powerpc.

+added-support-for-asix-88178-chipset-usb-gigabit-ethernet-adaptor.patch

 USB device support

+x86_64-mm-acpi-blacklist-xw9300.patch
+x86_64-mm-profile-pc-fp.patch
+x86_64-mm-fix-last_tsc-calculation-of-pm-timer.patch
+x86_64-mm-remove-ids.patch
+x86_64-mm-remove-ia32-export.patch
+x86_64-mm-allow-users-to-force-a-panic-on-nmi.patch
+x86_64-mm-empty-node0.patch
+x86_64-mm-make-functions-static.patch
+x86_64-mm-disable-apic-initdata.patch
+x86_64-mm-remove-unused-gart-header-file.patch
+x86_64-mm-fix-vector_lock-deadlock-in-io_apicc.patch
+x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix.patch
+x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix-fix.patch
+x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86_64-fix.patch
+x86_64-mm-kdump-x86_64-nmi-event-notification-fix.patch
+x86_64-mm-kdump-i386-nmi-event-notification-fix.patch
+x86_64-mm-set-compat-early.patch
+x86_64-mm-i386-enable-nmi-wdog.patch

 x86_64 tree updates

+revert-x86_64-mm-profile-pc-fp.patch
+x86_64-msi-apic-build-fix.patch

 Fix it.

+zone-init-check-and-report-unaligned-zone-boundaries-fix-v2.patch

 Fix zone-init-check-and-report-unaligned-zone-boundaries.patch

+zone-allow-unaligned-zone-boundaries-spelling-fix.patch

 Fix zone-allow-unaligned-zone-boundaries.patch

+register-sysfs-file-for-hotpluged-new-node.patch
+register-sysfs-file-for-hotpluged-new-node-fix.patch

 Memory hotadd work.

+flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch

 Small fix, needed for
 introduce-mechanism-for-registering-active-regions-of-memory.patch

+have-ia64-use-add_active_range-and-free_area_init_nodes.patch

 Use introduce-mechanism-for-registering-active-regions-of-memory.patch on
 ia64.

+mm-cleanup-swap-unused-warning.patch

 Kill a warning

+page-migration-simplify-migrate_pages.patch
+page-migration-simplify-migrate_pages-tweaks.patch
+page-migration-handle-freeing-of-pages-in-migrate_pages.patch
+page-migration-use-allocator-function-for-migrate_pages.patch
+page-migration-support-moving-of-individual-pages.patch
+page-migration-detailed-status-for-moving-of-individual-pages.patch
+page-migration-support-a-vma-migration-function.patch

 New page migration feature work.

+fix-tiacx-on-alpha.patch
+tiacx-fix-attribute-packed-warnings.patch
+tiacx-pci-build-fix.patch

 Updates to acx1xx-wireless-driver.patch

+x86-increase-interrupt-vector-range.patch
+x86-call-eisa_set_level_irq-in-pcibios_lookup_irq.patch
+x86-kernel-irq-balancer-fix.patch
+x86-kernel-irq-balancer-fix-tidy.patch
+i386-let-usermode-execute-the-enter.patch

 x86 updates

-add-raw-driver-kconfig-entry-for-s390.patch

 Dropped.

-fix-dcache-race-during-umount-fix.patch

 Folded into fix-dcache-race-during-umount.patch

+isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub-fix.patch

 Folded into
 isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub.patch

+list-introduce-list_replace-helper.patch
+list-use-list_replace_init-instead-of-list_splice_init.patch

 list.h cleanups

+when-config_base_samll=1-the-kernel-261611-cascade-in-kernel-timerc-may-enter-the-infinite-loop-use-list_replace_init.patch

 Fix
 when-config_base_samll=1-the-kernel-261611-cascade-in-kernel-timerc-may-enter-the-infinite-loop.patch

+hptiop-highpoint-rocketraid-3xxx-controller-driver-redone.patch

 Update the Highpoint RocketRaid driver

+ufs-change-block-number-on-the-fly.patch
+ufs-change-block-number-on-the-fly-tweaks.patch
+ufs-directory-and-page-cache-install-aops.patch
+ufs-directory-and-page-cache-from-blocks-to-pages.patch

 More UFS fixes

+oprofile-fix-unnecessary-cleverness.patch
+msnd-section-fix.patch
+oprofile-convert-from-semaphores-to-mutexes.patch
+drivers-char-applicomc-proper-module_initexit.patch
+remove-dead-entry-in-net-wan-makefile.patch
+openpromfs-fix-missing-nul.patch
+openpromfs-remove-unnecessary-casts.patch
+openpromfs-factorize-out.patch
+openpromfs-factorize-out-tidy.patch
+idetape-gcc-41-warning-fix.patch
+add-driver-for-arm-amba-pl031-rtc.patch
+add-driver-for-arm-amba-pl031-rtc-tidy.patch
+rtc-subsystem-fix-capability-checks-in-kernel-interface.patch
+rtc-subsystem-add-capability-checks.patch
+add-export_unused_symbol-and-export_unused_symbol_gpl.patch
+add-export_unused_symbol-and-export_unused_symbol_gpl-default.patch
+make-printk-work-for-really-early-debugging.patch
+kernel-sysc-cleanups.patch
+kernel-sysc-cleanups-fix.patch
+nbd-kill-obsolete-changelog-add-gpl.patch
+fix-listh-kernel-doc.patch
+listh-doc-change-counter-to-control.patch
+fix-magic-sysrq-on-strange-keyboards.patch
+ide-cd-end-of-media-error-fix.patch
+add-a-sysfs-file-to-determine-if-a-kexec-kernel-is-loaded.patch
+add-a-sysfs-file-to-determine-if-a-kexec-kernel-is-loaded-tidy.patch
+cpqarray-section-fix.patch

 Misc

+remove-old-hw-rng-support.patch
+add-new-generic-hw-rng-core.patch
+add-new-generic-hw-rng-core-cleanups.patch
+add-new-generic-hw-rng-core-hw_random-core-rewrite-chrdev-read-method.patch
+add-new-generic-hw-rng-core-maintainers.patch
+add-intel-hw-rng-driver.patch
+add-intel-hw-rng-driver-cleanups.patch
+add-amd-hw-rng-driver.patch
+add-geode-hw-rng-driver.patch
+add-geode-hw-rng-driver-cleanups.patch
+add-via-hw-rng-driver.patch
+add-via-hw-rng-driver-fix.patch
+add-via-hw-rng-driver-cleanups.patch
+add-ixp4xx-hw-rng-driver.patch
+add-ti-omap-cpu-family-hw-rng-driver.patch
+add-bcm43xx-hw-rng-support.patch

 Introduce hardware random number generator framework, use it.

+vectorize-aio_read-aio_write-methods.patch
+remove-readv-writev-methods-and-use-aio_read-aio_write.patch
+core-aio-changes-to-support-vectored-aio.patch
+core-aio-changes-to-support-vectored-aio-fix-2.patch
+streamline-generic_file_-interfaces-and-filemap.patch
+gfs2-vs-streamline-generic_file_-interfaces-and-filemap.patch

 Cleanup, simplify core pagecache read/write APIs

+nfs-open-code-the-nfs-direct-write-rescheduler.patch
+nfs-open-code-the-nfs-direct-write-rescheduler-printk-fix.patch
+nfs-remove-user_addr-and-user_count-from-nfs_direct_req.patch
+nfs-eliminate-nfs_get_user_pages.patch
+nfs-alloc-nfs_read-write_data-as-direct-i-o-is-scheduled.patch
+nfs-check-all-iov-segments-for-correct-memory-access-rights.patch
+nfs-support-vector-i-o-throughout-the-nfs-direct-i-o-path.patch

 Make NFS direct-IO utilise those cleanups

+kprobemulti-kprobe-posthandler-for-booster-kprobes-bugfix-of-kprobe-booster-reenable-kprobe-booster.patch

 Fix kprobemulti-kprobe-posthandler-for-booster.patch

+sched-fix-interactive-ceiling-code.patch

 CPU scheduler fix

+swap-prefetch-fix-lru_cache_add_tail.patch
+swap-prefetch-fix-lru_cache_add_tail-tidy.patch
+mm-swap-prefetch-fix-lowmem-reserve-calc.patch

 swap prefetching fixes

-ecryptfs-main-module-functions-vs-nfs-permit-filesystem-to-override-root-dentry-on-mount.patch

 Folded into other ecryptfs patches

+ecryptfs-vs-streamline-generic_file_-interfaces-and-filemap.patch
+ecryptfs-vs-streamline-generic_file_-interfaces-and-filemap-fix.patch
+ecryptfs-file-operations-fix.patch

 ecryptfs fixes (for underlying API changes)

+namespaces-add-nsproxy.patch
+namespaces-incorporate-fs-namespace-into-nsproxy.patch
+namespaces-utsname-introduce-temporary-helpers.patch
+namespaces-utsname-switch-to-using-uts-namespaces.patch
+namespaces-utsname-switch-to-using-uts-namespaces-alpha-fix.patch
+namespaces-utsname-use-init_utsname-when-appropriate.patch
+namespaces-utsname-implement-utsname-namespaces.patch
+namespaces-utsname-implement-utsname-namespaces-export.patch
+namespaces-utsname-sysctl-hack.patch
+namespaces-utsname-remove-system_utsname.patch
+namespaces-utsname-implement-clone_newuts-flag.patch

 Permit virtualisation of the system utsname

+reiser4-fix-incorrect-assertions.patch

 reiser4 fix

-reiser4-vs-nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
-reiser4-vs-nfs-permit-filesystem-to-perform-statfs-with-a-known-root-dentry.patch

 Dropped, not needed

+reiser4-gfp_t-annotations.patch

 reiser4 sparse friendliness

+ide-hpt3xx-fix-pci-clock-detection-fix-2.patch

 Fix ide-hpt3xx-fix-pci-clock-detection.patch

+ide_dma_speed-fixes.patch
+ide_dma_speed-fixes-warning-fix.patch
+ide_dma_speed-fixes-tidy.patch
+hpt3xx-rework-rate-filtering.patch
+hpt3xx-rework-rate-filtering-tidy.patch
+hpt3xx-print-the-real-chip-name-at-startup.patch

 IDE fixes

+md-allow-checkpoint-of-recovery-with-version-1-superblock-fix.patch

 Fix md-allow-checkpoint-of-recovery-with-version-1-superblock.patch

+md-change-md-bitmap-file-handling-to-use-bmap-to-file-blocks-fix.patch
+md-calculate-correct-array-size-for-raid10-in-new-offset-mode.patch

 MD updates

+git-viro-bird-volatile-fixup.patch

 Fix reject in git-viro-bird-volatile.patch



All 1117 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm2/patch-list


