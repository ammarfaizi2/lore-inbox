Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVIAK5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVIAK5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 06:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVIAK5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 06:57:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964882AbVIAK5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 06:57:24 -0400
Date: Thu, 1 Sep 2005 03:55:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-mm1
Message-Id: <20050901035542.1c621af6.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/

- Included Alan's big tty layer buffering rewrite.  This breaks the build on
  lots of more obscure character device drivers.  Patches welcome (please cc
  Alan).



Changes since 2.6.13-rc6-mm2:


 linus.patch
 git-acpi.patch
 git-arm.patch
 git-cpufreq.patch
 git-cryptodev.patch
 git-ia64.patch
 git-audit.patch
 git-audit-ppc64-fix.patch
 git-input.patch
 git-jfs-fixup.patch
 git-kbuild.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ocfs2.patch
 git-serial.patch
 git-scsi-block.patch
 git-scsi-iscsi.patch
 git-scsi-misc.patch
 git-watchdog.patch

 Subsystem trees
 
-preempt-race-in-getppid.patch
-tpm_infineon-bugfix-in-pnpacpi-handling.patch
-md-make-sure-resync-gets-started-when-array-starts.patch
-gregkh-usb-usb-zd1201-kmalloc-size-fix.patch
-export-machine_power_off-on-ppc64.patch
-usbnet-oops-fix.patch
-x86_64-dont-oops-at-boot-when-empty-opteron-node-has-io.patch
-git-acpi-ia64-fixes.patch
-git-acpi-ia64-fix-2.patch
-git-drm-drm_agpsupport-warning-fix.patch
-gregkh-i2c-i2c-hwmon-class-01.patch
-gregkh-i2c-w1-changed_default_netlink_group.patch
-apple-usb-touchpad-driver.patch
-negative-timer-loop-with-lots-of-ipv4-peers.patch
-ipw2100-cleanup-debug-prints.patch
-gregkh-pci-pci-must_check-attributes.patch
-git-scsi-misc-ibmvscsi-fix.patch
-git-scsi-misc-ibmvscsi-fix-fix.patch
-ppc32-fix-gcc4-warning-in-asm-ppc-timeh.patch
-ppc64-remove-nested-feature-sections.patch
-ppc64-allow-xmon=off.patch
-ppc64-four-level-pagetables.patch
-ppc64-four-level-pagetables-fix.patch
-ppc64-large-initrd-causes-kernel-not-to-boot.patch
-i386-fix-incorrect-fp-signal-delivery.patch
-x86_64-fix-numa-node-sizing-in-nr_free_zone_pages.patch
-i810_audio-fix-release_region-misordering-in-error-exit-from-i810_probe.patch
-race-condition-with-drivers-char-vtc-bug-in-vt_ioctlc.patch
-nfs-nfs3-page-null-fill-in-a-short-read-situation.patch # wait
-nfs-fix-xprt_bindresvport.patch
-8250-serial-console-locking-bug-spelling-fix.patch

 Merged

+non-booting-g5-fix.patch

 ppc64 G5 fix

+dvb-saa7134-dvb-must-select-tda1004x.patch

 DVB Kconfig fix

+tpm_infineon-bugfix-in-pnpacpi-handling.patch

 TPM fix

+gregkh-driver-driver-bind-fix.patch
+gregkh-driver-driver-link-device-and-class.patch

 Driver tree updates

-driver-core-fix-bus_rescan_devices-race.patch
+driver-core-fix-bus_rescan_devices-race-2.patch

 Updated

+git-audit-ppc64-fix.patch

 Fix git-audit.patch

+hiddev-output-reports-are-dropped-when-hidiocsreport-is.patch

 Some USB fix

+git-jfs-fixup.patch

 Fix rejects in git-jfs.patch

+ignore-all-debugging-info-sections-in-scripts-reference_discardedpl.patch

 reference_discarded.pl tweak

+fix-minor-bug-in-sungemh.patch

 Sungem fix

+netlink-log-protocol-failures.patch

 Netlink debugging

+git-nfs-oops-fix.patch

 Revert dud patch from git-nfs.patch

+gregkh-pci-pci-must_check-attributes.patch

 PCI tree update

+fix-klist-semantics-for-lists-which-have-elements-removed.patch

 klist fix for scsi usage

+git-scsi-misc-sr-fix.patch

 Fix git-scsi-misc.patch

+gregkh-usb-usb-add-apple-touchpad-driver.patch

 USB tree update

+watchdog-new-sbc8360-driver.patch

 Watchdog driver

+ppc64-fix-sparsemem-extreme.patch

 Fix sparsemem-extreme.patch

+swap-swap-unsigned-int-consistency-warning-fix.patch

 cleanup

-add-swap-cache-mapping-comment.patch
-remove-stale-comment-from-swapfilec.patch

 Were wrong

+arm-allow-for-arch-specific-ioremap_max_order.patch

 ARM fix (controversial)

+hugetlb-add-pte_huge-macro.patch
+hugetlb-move-stale-pte-check-into-huge_pte_alloc.patch
+hugetlb-check-pd_present-in-huge_pte_offset.patch
+remove-hugetlb_clean_stale_pgtable-and-fix-huge_pte_alloc.patch

 hugetlb updates

+slab-consolidate-kmem_bufctl_t.patch

 slab cleanup

+page-fault-patches-optional-page_lock-acquisition-in-nicety.patch

 Clean up pagefault scalability patches

+ppp_mppe-add-ppp-mppe-encryption-module-author-address-change.patch

 New email address

+mdio_bus_exit-in-discarded-section-textexit.patch

 mdio section fix

+generic-vfs-fallback-for-security-xattrs.patch

 SELinux stuff

+cpm_uart-use-schedule_timeout-instead-of-direct-call-to.patch
+cpm_uart-fix-baseaddress-for-smc-1-and-2.patch

 cpm_uart updates

+ppc32-disable-ibm405_err77-and-ibm405_err51-workarounds-for-405ep.patch
+ppc32-ppc_sys-system-on-chip-identification-additions.patch
+ppc32-add-config_hz.patch
+ppc32-add-support-for-marvell-ev64360bp-board.patch
+ppc32-defconfig-for-marvell-ev64360bp-board.patch
+ppc32-fix-wundef-warning-for-config_8xx.patch
+ppc32-added-pci-support-mpc83xx.patch
+ppc32-re-order-cputable-for-750cxe-dd24-entry.patch
+ppc32-add-cputable-entry-for-750cxe-dd24-gekko.patch
+ppc32-move-4xx-phy_mode_xxx-defines-to-ibm_ocph.patch
+ppc32-add-dcr_base-field-to-ocp_func_mal_data.patch
+ppc32-l2-cache-prefetch-fixes-on-745x.patch
+ppc32-export-cacheable_memcpy.patch

 ppc32 updates

+frv-remove-export-of-strtok.patch

 cleanup

+mips-fix-build-warnings.patch
+mips-remove-timexh-for-vr41xx.patch
+mips-kludge-envdev-to-build-for-64-bit-mips-with-32-bit-compat.patch

 MIPS updates

+es7000-platform-update-i386.patch

 es7k updates

+x86-add-mce-resume.patch
+pm-fix-process-freezing.patch
+pm-cleanup-sys-power-disk.patch

 PM updates

+uml-error-path-cleanup.patch
+uml-build-cleanup.patch
+uml-remove-libc-reference-in-build.patch
+uml-mark-smp-on-uml-x86_64-as-broken.patch
+uml-remove-duplicated-exports.patch
+uml-uml-i386-is-i386-when-running-on-x86_64.patch
+uml-tlb-operation-batching.patch
+uml-merge-duplicated-page-table-code.patch

 UML

+xtensa-replace-extern-inline-with-static-inline.patch
+xtensa-delete-accidental-file.patch

 xtensa arch

+s390-machine-check-handler-bugs.patch
+s390-debug-feature-changes.patch
+s390-deadlock-in-dasd_devmap.patch
+s390-64-bit-diag250-support.patch
+s390-reipl-fix-and-extern-static-inline.patch
+s390-pfault-interrupt-race.patch
+s390-crypto-driver-update.patch
+s390-compat-system-calls.patch
+s390-spinlock-corner-case.patch
+s390-disconnected-3270-console.patch

 s390 updates

+futex_wake_op-pthread_cond_signal-speedup.patch

 Futex feature work

+relayfs-relayfs_remove-fix.patch
+relayfs-upgraded-read-implementation.patch
+relayfs-update-documentation-fix.patch

 relayfs updates

-aio-add-enosys-into-sys_io_cancel.patch
-aio-kiocb-locking-to-serialise-retry-and-cancel.patch

 Dropped (I have it in a new AIO patch series but I took yet another look at
 all the AIO stuff and felt queasy)

+radix-tree-remove-unnecessary-indirections-and-clean-up.patch

 radix-tree simplifications

+auxiliary-vector-cleanups-fix.patch

 Fix auxiliary-vector-cleanups.patch

+dcdbas-add-dell-systems-management-base-driver-with-sysfs-support.patch

 Dell Systems Management Base Driver

+futex-remove-duplicate-code.patch

 Futex celanup

+additions-to-dataread_mostly-section.patch

 More read-mostly variables

+ntp-ntp-helper-functions.patch

 ntp cleanup

+blk-use-blk_queue_xxx-functions-to-set-parameters.patch

 block layer cleanup

+convert-proc-devices-to-use-seq_file-interface.patch
+convert-proc-devices-to-use-seq_file-interface-fix.patch

 seq_file conversion

+tty-layer-buffering-revamp.patch

 TTY buffering rewrite

+pipe-remove-redundant-fifo_poll-abstraction.patch

 pipe cleanup

+ibm-hdaps-accelerometer-driver-with-probing.patch

 HDAPS driver

+remove-verify_area-remove-verify_area-from-various-uaccessh-headers.patch
+remove-verify_area-remove-or-edit-references-to-verify_area-in-documentation.patch
+remove-verify_area-remove-fs-umsdos-notes-as-it-only-contain-a-verify_area-related-note.patch

 cleanups

+serial-console-touch-nmi-watchdog.patch

 Poke the NMI watchdog when spewing to the serial console.

+optimise-64bit-unaligned-access-on-32bit-kernel.patch

 Speedup

+vt-fix-possible-memory-corruption-in-complement_pos.patch

 vt driver fix

+hpet-fix-drift-and-url.patch

 hpet fix

+isdn_v110-warning-fix.patch

 Fix a warning

+tpm-fix-tpm_atmelc-on-ich6.patch

 TPM fix

+create-asm-generic-fcntlh.patch
+consildate-asm-ppc-fcntlh.patch

 fcntl.h consolidation

+clean-up-the-open-flags.patch
+clean-up-the-fcntl-operations.patch
+clean-up-struct-flock-definitions.patch
+clean-up-struct-flock64-definitions.patch
+consolidate-the-asm-ppc-fcntlh-files-into-asm-powerpc.patch

 More code was dirty

+inotify-fix-event-loss-on-hardlinked-files.patch

 inotify fix

+sunrpc-print-unsigned-integers-in-stats.patch

 sunrpc fixlet

+open-returns-enfile-but-creates-file-anyway.patch
+open-returns-enfile-but-creates-file-anyway-tidy.patch

 Fix open() behaviour

+block-cfq-refcounting-fix.patch

 CFQ fix

+remove-ia_attr_flags.patch
+namei-cleanup.patch
+use-get_fs_struct-in-proc.patch

 Cleanups

+fix-enum-pid_directory_inos-in-proc-basec.patch

 procfs fix

+remove-duplicated-code-from-proc-and-ptrace.patch
+remove-duplicated-sys_open32-code-from-64bit-archs.patch

 cleanups

+cifs_create-fix.patch

 CIFS fix

+deprecate-openfoo-3.patch

 Deprecate open("foo", 3) (old lilo's trigger this)

+fix-reboot-via-keyboard-controller-reset.patch

 Make reboots work better with some keyboard controllers

+fix-dmi_check_system.patch

 DMI fix

+mmc-conditional-scr-sysfs-entry.patch

 MMC fix

-smsc-ircc2-pm-cleanup-do-not-close-device-when-suspending-fixes.patch

 Folded into smsc-ircc2-pm-cleanup-do-not-close-device-when-suspending.patch

+kprobes-fix-handling-of-simultaneous-probe-hit-unregister.patch

 kprobes fix

+pcmcia-yenta-dont-mess-with-bridge-control-register.patch
+pcmcia-remove-unused-client_t.patch
+pcmcia-remove-unused-vpp1-vpp2-and-vcc.patch
+pcmcia-omap-cf-controller.patch
+pcmcia-more-ids-for-ide_cs.patch
+pcmcia-add-pcmcia-to-irq-information.patch

 pcmcia/cardbus updates

+nfs-nfs3-page-null-fill-in-a-short-read-situation.patch

 NFS fix

+sched-less-newidle-locking.patch
+sched-less-locking.patch
+sched-ht-optimisation.patch

 CPU scheduler updates

-sched-dont-kick-alb-in-the-presence-of-pinned-task-fix.patch

 Folded into sched-dont-kick-alb-in-the-presence-of-pinned-task.patch

+reiser4-fix-wundef-warnings.patch

 reiser4 wranings

+v9fs-documentation-makefiles-configuration-fix-plan9port-example-in-v9fs.patch
+v9fs-vfs-inode-operations-adjust-follow_link-and-put_link-to.patch
+v9fs-9p-protocol-implementation-use-standard-kernel-byteswapping.patch
+v9fs-9p-protocol-implementation-remove-sparse-bitwise-warnings.patch
+v9fs-transport-modules-fix-a-problem-with-named-pipe-transport.patch
+v9fs-transport-modules-cleanup-fd-transport.patch
+v9fs-support-to-force-umount.patch
+v9fs-readlink-extended-mode-check.patch
+v9fs-fix-handling-of-malformed-9p-messages.patch

 v9fs updates

+ide-clean-up-the-garbage-in-eighty_ninty_three.patch

 IDE cleanup

+matroxfb-read-mga-pins-data-on-powerpc.patch
+sisfb-update.patch
+better-error-handing-in-savagefb_probe.patch
+framebuffer-new-driver-for-cyberblade-i1-graphics.patch
+framebuffer-bit_putcs-optimization-for-8x.patch
+radeonfb-only-request-resources-we-need.patch

 fbdev updates

+md-remove-old-cruft-from-md_kh-header-file.patch
+md-limit-size-of-sb-read-written-to-appropriate-amount.patch
+md-add-write-intent-bitmap-support-to-raid5.patch
+md-write-intent-bitmap-support-for-raid6.patch
+md-use-kthread-infrastructure-in-md.patch
+md-ensure-bitmap_writeback_daemon-handles-shutdown-properly.patch
+md-tidy-up-daemon-stop-start-code-in-md-bitmapc.patch

 RAID updates

+docbook-fix-kernel-api-documentation-generation.patch
+kdump-documentation-update.patch
+vfs-update-documentation.patch

 Documentation updates

+fuse-read-only-operations-follow_link-fix.patch

 FUSE fix



All 1126 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/patch-list


