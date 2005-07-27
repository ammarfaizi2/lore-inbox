Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVG0Jod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVG0Jod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 05:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVG0Jod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 05:44:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262085AbVG0Jo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 05:44:29 -0400
Date: Wed, 27 Jul 2005 02:43:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc3-mm2
Message-Id: <20050727024330.78ee32c2.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm2/


- Lots of fixes and updates all over the place.  There are probably over 100
  patches here which need to go into 2.6.13.

- A reminder that -mm commit activity may be monitored by subscribing to
  the mm-commits list.  Do

	echo subscribe mm-commits | mail majordomo@vger.kernel.org




Changes since 2.6.13-rc3-mm1:


 linus.patch
 git-acpi.patch
 git-drm.patch
 git-audit.patch
 git-input.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-adma-mwi.patch
 git-libata-chs-support.patch
 git-libata-passthru.patch
 git-libata-promise-sata-pata.patch
 git-net.patch
 git-netdev-chelsio.patch
 git-netdev-e100.patch
 git-netdev-smc91x-eeprom.patch
 git-netdev-ieee80211-wifi.patch
 git-ocfs2.patch
 git-scsi-block.patch

 Subsystem trees

-vtc-build-fix.patch
-fix-raid0s-attempt-to-divide-by-64bit-numbers.patch
-v4l-bug-fixes-for-tuner-cx88-and-tea5767.patch
-xip-empty_zero_page-build-fix.patch
-mm-fix-execute-in-place.patch
-visws-reexport-pm_power_off.patch
-inotify-documentation-update.patch
-deprecate-register_serial-and-unregister_serial.patch
-rocketc-fix-ldisc-ref-count-handling.patch
-md-raid1-clear-bitmap-when-fullsync-completes.patch
-uart_handle_sysrq_char-warning-fix.patch
-update-filesystems-for-new-delete_inode-behavior-fix.patch
-remove-pci_bridge_ctl_vga-handling-from-setup-busc.patch
-qla-remove-anonymous-union.patch
-qla2xxx-Kconfig-dependency-fix.patch
-zatm-kfree-fix.patch
-max_user_rt_prio-and-max_rt_prio-are-wrong.patch
-serial-add-siig-quartet-support.patch

 Merged

+i2c-mpc-restore-code-removed.patch

 i2c fix

+really-__nocast-annotate-kmalloc_node.patch

 kmalloc_node() annotation fix

+mips-fbdev-kconfig-fix.patch

 MIPS fbdev fix

+md-when-resizing-an-array-we-need-to-update-resync_max_sectors-as-well-as-size.patch

 md fix

+uml-readd-missing-define-to-arch-um-makefile-i386.patch
+uml-add-dependency-to-arch-um-makefile-for-parallel-builds.patch
+uml-add-skas0-command-line-option.patch
+uml-update-module-interface.patch
+uml-fix-misdeclared-function.patch

 UML updates

+x86_64-fix-smp-boot-lockup-on-some-machines.patch

 x86_64 boot-time lockup fix

+try_to_freeze-call-fixes.patch
+add-missing-tvaudio-try_to_freeze.patch
+fix-missing-refrigerator-invocation-in-jffs2.patch

 swsusp fixes

+as-ioched-tunable-encoding-fix.patch

 as-iosched sysfs fixes

+reiserfs-fix-deadlock-in-inode-creation-failure-path-w-default-acl.patch

 resierfs deadlock fix

+ext2-drop-quota-reference-before-releasing-inode.patch
+ext3-drop-quota-references-before-releasing-inode.patch

 ext2/ext3 quota fixes

+pnp-build-fix.patch

 pnp compile fix

+address-bug-using-smp_processor_id-in-preemptible.patch

 Fix a bogus BUG

+watchdog-add-missing-0x-in-alim1535_wdtc.patch

 watchdog driver fix

+itimer-fixes.patch

 Fix the recent itimer fix

+add-pcibios_bus_to_resource-for-parisc.patch

 parisc build fix

+autofs4-fix-infamous-busy-inodes-after-umount-message.patch

 Fix longstanding autofs bug.

+scsi_scan-check-return-code-from-scsi_sysfs_add_sdev.patch

 scsi_scan fix

+i4l-add-olitec-isdn-pci-card-in-hisax-gazel-driver.patch

 Add ISDN device support

+jsm-use-dynamic-major-number-allocation.patch
+jsm-warning-fixes.patch

 JSM driver updates

+undo-mempolicy-shared-policy-rbtree-microoptimization.patch

 Fix crash in mempolicy code

+ub-fix-for-blank-cds.patch

 Improve the ub driver's handling of blank CDs

+fix-xip-sparse-file-handling-in-ext2.patch

 Fix ext2 xip support

+check_user_page_readable-deadlock-fix.patch

 Fix a deadlock in oprofile's use of get_user_pages()

+e1000-no-need-for-reboot-notifier.patch
+mpt-fusion-free-irq-in-suspend.patch

 A couple of power-management fixes to try to get ia64 reboot working again.

+eurotechwdt-build-fix.patch
+softdog-build-fix.patch
+x86_64-fsnotify-build-fix.patch

 Misc fixes against Linus's tree

+agp-restore-apbase-after-setting-apsize.patch

 AGP fix

+gregkh-driver-driver-sample.sh.patch

 Addition to Greg's driver-core tree

+gregkh-i2c-i2c-max6875-simplify.patch
+gregkh-i2c-i2c-max6875-documentation-update.patch
+gregkh-i2c-i2c-max6875-fix-build-error.patch
+gregkh-i2c-i2c-nforce2-cleanup.patch
+gregkh-i2c-i2c-ds1337-12-24-mode-fix.patch
+gregkh-i2c-i2c-missing-space.patch
+gregkh-i2c-w1-kconfig.patch
+gregkh-i2c-i2c-hwmon-class-01.patch
+gregkh-i2c-i2c-hwmon-class-02.patch
+gregkh-i2c-i2c-hwmon-class-03.patch
+gregkh-i2c-i2c-hwmon-split-01.patch
+gregkh-i2c-i2c-hwmon-split-02.patch
+gregkh-i2c-i2c-hwmon-split-03.patch
+gregkh-i2c-i2c-hwmon-split-04.patch
+gregkh-i2c-i2c-hwmon-split-05.patch
+gregkh-i2c-i2c-hwmon-split-06.patch
+gregkh-i2c-i2c-hwmon-split-07.patch
+gregkh-i2c-i2c-hwmon-split-08.patch
+gregkh-i2c-i2c-hwmon-split-09.patch

 Greg's i2c tree

-input-i8042-no-cmd-negate.diff.patch
-input-synaptics-dynabook.diff.patch
-input-input-check-keycodesize.diff.patch
-input-psmouse-wheel-mice-have-middle-button.diff.patch
-input-hid-remove-mcc-blacklist.diff.patch

 Changes in the input tree

+scsi_sata-has-to-be-a-tristate.patch

 SATA Kconfig fix

+netfilter-build-fix.patch
+ipv6_netfilter_init-warning-fix.patch

 Fix git-net.patch

+gregkh-pci-pci-rpaphp-01.patch
+gregkh-pci-pci-rpaphp-02.patch
+gregkh-pci-pci-rpaphp-03.patch
+gregkh-pci-pci-rpaphp-04.patch
+gregkh-pci-pci-rpaphp-05.patch
+gregkh-pci-pci-rpaphp-06.patch
+gregkh-pci-pci-driver-init-on-node.patch
+gregkh-pci-pci-smbus-quirk.patch
+gregkh-pci-pci-adjust-pci-rom-code-to-handle-more-broken-roms.patch
+gregkh-pci-pci-remove-pci_bridge_ctl_vga-handling-from-setup-busc.patch
+gregkh-pci-pci-move-pci-fixup-data-into-r-o-section.patch
+gregkh-pci-pci-dma-build-fix.patch
+gregkh-pci-pci-remove-pretty-names.patch

 Additions to Greg's PCI tree

+gregkh-pci-pci-remove-pretty-names-fix.patch

 Fix it.

+scsi-ibmvscsi-srph-fix-a-wrong-type-code-used-for-srp_login_rej.patch

 ibmvscsi fix

+usb-hidinput_hid_event-oops-fix.patch

 USB oops fix

+topdir-mm.patch

 Add $TOPDIR/.mm to make the v4l team's life easier.

+mm-comment-rmap.patch
+mm-micro-optimise-rmap.patch
+mm-cleanup-rmap.patch
+mm-remove-atomic.patch
+mm-remap-zero_page-mappings.patch

 Various mm tweaks

+tms380tr-move-to-dma-api.patch
+sk98lin-basic-suspend-resume-support.patch
+sk98lin-basic-suspend-resume-support-fix.patch

 Net driver updates

+tmpfs-enable-atomic-inode-security-fix.patch

 Fix tmpfs-enable-atomic-inode-security.patch

+ppc32-8xx-update-datatlbmiss-exception-comment.patch
+ppc-fix-compilation-error-with-config_pq2fads.patch
+ppc32-fix-typo-in-setup-of-2nd-pci-bus-on-85xx.patch
+ppc32-fix-building-of-prpmc750.patch
+ppc32-fix-building-of-radstone_ppc7d.patch
+ppc32-fix-dma_map_page-to-use-page_to_bus.patch
+ppc32-fix-440sp-mal-channels-count.patch
+ppc32-fix-building-of-tqm8260-board.patch

 ppc32 updates

+make-a-few-functions-static-in-pmac_setupc.patch
+ppc64-dynamically-allocate-segment-tables.patch
+ppc64-remove-another-fixed-address-constraint.patch

 ppc64 updates

+mips-remove-obsolete-giu-driver-for-vr41xx.patch

 Remove dead driver

+x86-fix-efi-memory-map-parsing.patch
+i386-add-missing-kconfig-help-text.patch

 x86 fixes

+x86_64-print-processor-number-in-show_regs.patch

 x86_64 tweak

+unify-x86-x86-64-semaphore-code.patch

 Consolidate x86/x86_64 semaphore implementations

+swsusp-process-freezing-remove-smp-races.patch
+swsusp-process-freezing-remove-smp-races-msp3400-fix.patch

 Fix races accessing task->flags

-call-device_shutdown-with-interrupts-enabled.patch
-swsusp-fix-printks-and-cleanups.patch

 Dropped - they get int he way or Eric's reboot rework

+swsusp-switch-pm_message_t-to-struct-chipsfb-fixes.patch
+swsusp-switch-pm_message_t-to-struct-mesh-fixes-2.patch

 Fix swsusp patches in -mm.

+encrypt-suspend-data-for-easy-wiping.patch

 swsusp encryption (will probably drop this)

+swsusp-prevent-disks-from-spinning-down-and-up.patch

 Fix the swsusp disk yoyoing

+m32r-add-missing-kconfig-help-text.patch

 m32r Kconfig fixes

+v850-define-pfn_valid.patch
+v850-const-qualify-first-parameter-of-find_next_zero_bit.patch
+v850-add-defconfigs.patch
+v850-update-ioremap-return-type-and-add-ioread-iowrite-functions.patch
+v850-add-pte_file.patch
+v850-update-pci-support.patch
+v850-define-l1_cache_shift-and-l1_cache_shift_max.patch

 v850 updates

+detect-soft-lockups-export-touch_softlockup_watchdog.patch
+mtd-stop-the-nand-functions-triggering-false-softlockup-reports.patch

 Fixes for detect-soft-lockups.patch

+pselect-ppoll-system-calls-copy_to_user-check.patch

 Fix a warning

-mb_cache_shrink-frees-unexpected-caches.patch

 Dropped, wrong.

+add-cmos-attribute-to-floppy-driver.patch
+add-cmos-attribute-to-floppy-driver-tidy.patch

 floppy driver enhancement

+mbcache-remove-unused-mb_cache_shrink-parameter.patch

 mbcache cleanup

+documentation-changes-document-the-required-udev-version.patch

 Documentation update

+reiserfs-doesnt-use-mbcache.patch

 resierfs cleanup

+ia64-halt-hangup-fix.patch

 Try to fix the ia64 halt hangup.  Doesn't work.

+use-select-in-sound-isa-kconfig.patch
+use-select-in-sound-isa-kconfig-fix.patch

 Kconfig fixes

+compat-be-more-consistent-about-id_t.patch

 compat cleanup

+fs-jbd-cleanups.patch

 JBD cleanups

+turn-many-if-undefined_string-into-ifdef-undefined_string.patch
+riva-wundef-fix.patch

 Fix lots of `-Wundef' warnings

+sys_get_thread_area-does-not-clear-the-returned-argument.patch

 Fix micro-info leak

+strip-local-symbols-from-kallsyms.patch

 Remove uninteresting symbols from kallsyms

+serial_core-whitespace-fix.patch

 Serial fixlet

+fix-outstanding-gzip-zlib-security-issues.patch
+fix-outstanding-gzip-zlib-security-issues-ppc64.patch

 Plug zlib holes

+kill-bio-bi_set.patch

 BIO cleanup

+make-kmalloc-fail-for-swapped-size--gfp-flags.patch
+make-kmalloc-fail-for-swapped-size--gfp-flags-fix.patch
+make-kmalloc-fail-for-swapped-size--gfp-flags-aic-fix.patch

 Force compilke-time and runtime failures when someone gets the kmalloc()
 args backwards.

+intel8x0-free-irq-in-suspend.patch

 intel8x0 PM fix

+add-text-for-dealing-with-dot-releases-to-readme.patch

 ./README update

+kprobes-prevent-possible-race-conditions-sparc64-changes-fix.patch

 Fix kprobes-prevent-possible-race-conditions-sparc64-changes.patch

+dlm-core-locking-resend-lookups.patch
+dlm-communication-fix-lowcomms-race.patch
+dlm-recovery-make-code-static.patch
+dlm-recovery-clear-new_master-flag.patch
+dlm-device-interface-fix-device-refcount.patch
+dlm-node-weights.patch
+dlm-rsb-flag-ops-with-inlined-functions.patch
+dlm-rework-recovery-control.patch
+dlm-better-handling-of-first-lock.patch
+dlm-no-directory-option.patch
+dlm-release-list-of-root-rsbs.patch
+dlm-return-error-in-status-reply.patch

 DLM updates

+ckrm-rule-based-classification-engine-full-ce-fix.patch
+ckrm-rule-based-classification-engine-more-advanced-classification-engine-netlink-fix.patch

 CKRM fixes

+connector-exit-notifier-fix-missing-dependencies-in.patch
+connector-fork-notifier-fix-missing-dependencies-in.patch

 connector client fixes

+dvico-fusion-dvb-t1-tuner-lg-z201-fix.patch

 DVB fix

+pcmcia-ide-cs-id_table-update.patch
+pcmcia-fix-comment.patch
+pcmcia-remove-duplicates-in-orinoco_cs.patch
+pcmcia-update-au1000-to-work-with-recent-changes.patch
+pcmcia-avoid-duble-iounmap-of-one-address.patch
+pcmcia-fix-many-device-ids.patch
+pcmcia-update-documentation.patch
+pcmcia-fix-sharing-irqs-and-request_irq-without-irq_handle_present.patch
+yenta-free_irq-on-suspend.patch
+pcmcia-disable-read-prefetch-write-burst-on-old-o2micro-bridges.patch
+pcmcia-disable-read-prefetch-write-burst-on-old-o2micro-bridges-fix.patch

 PCMCIA/Cardbus fixes

+numa-slab-allocator-cleanups.patch

 Tidy numa-aware-slab-allocator-v5.patch

+drivers-media-video-tveepromc-possible-cleanups.patch
+video_saa7134-must-depend-on-sound.patch
+v4l-fix-regression-modprobe-bttv-freezes-the-computer.patch
+dvb-v4l-lgdt3302-isolate-tuner.patch
+dvb-v4l-rf-input-selection-fix.patch
+lgdt3302-warning-fix.patch
+dvb-v4l-cx88-cleanup.patch
+v4l-hybrid-dvb-fix-warnings-with-wundef.patch
+v4l-hybrid-dvb-move-defines-to-makefile.patch
+v4l-hybrid-dvb-rename-cflags-from-config_dvb_xxxx-back.patch
+v4l-fix-tuning-with-mxb-driver.patch
+dvb-rename-lgdt3302-frontend-module-to-lgdt330x.patch

 dvb/v4l updates

+reiser4-swsusp-process-freezing-remove-smp-races-fix.patch
+reiser4-swsusp-build-fix.patch
+reiser4-swsusp-process-freezing-remove-smp-races-fix-2.patch
+reiser4-reboot-fix.patch
-reiser4-swsusp-build-fix.patch

 Fix reiser4 for various upstream changes

+v9fs-vfs-superblock-operations-and-glue-replace-v9fs_block_bits-with-fls.patch

 v9fs cleanup

+cpm_uart-use-dpram-for-early-console.patch

 cpm_uart fix

+ide-add-support-for-netcell-revolution-to-pci-ide-generic-driver.patch

 IDE device support

+dont-repaint-the-cursor-when-it-is-disabled.patch
+fbdev-update-info-cmap-when-setting-cmap-from-user-kernelspace.patch
+fbdev-add-fbset-a-support.patch
+vesafb-add-blanking-support.patch

 fbdev updates

+update-fsf-address-in-copying.patch
+fix-unusual-placement-of-inline-keyword-in-hpet.patch
+vfree-and-kfree-cleanup-in-drivers.patch
+merge-some-from-rustys-trivial-patches.patch

 Little fixes



number of patches in -mm: 764
number of changesets in external trees: 9
number of patches in -mm only: 763
total patches: 772


All 764 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm2/patch_list


