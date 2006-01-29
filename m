Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWA2Wpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWA2Wpx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 17:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWA2Wpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 17:45:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751201AbWA2Wpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 17:45:52 -0500
Date: Sun, 29 Jan 2006 14:45:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc1-mm4
Message-Id: <20060129144533.128af741.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/

- New git tree `git-davej-x86.patch': misc x86 things, maintained by David
  Jones.

- Lots of USB updates.  Please be sure to Cc:
  linux-usb-devel@lists.sourceforge.net if something broke.

- Various other random bits and pieces.  Things have been pretty quiet
  lately - most activity seems to be concentrated about putting bugs into the
  various subsystem trees.

- If you have a patch in -mm which you think should go into 2.6.16, it
  doesn't hurt to remind me.  There's quite a lot here which will go into
  2.6.16.



Changes since 2.6.16-rc1-mm3:

 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-arm.patch
 git-audit.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-davej-x86.patch
 git-drm.patch
 git-dvb.patch
 git-ia64.patch
 git-infiniband.patch
 git-input.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-parisc.patch
 git-powerpc.patch
 git-serial.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-rc-fixes.patch
 git-sas-jg.patch
 git-watchdog.patch
 git-cryptodev.patch

 git trees.

-drivers-serial-sh-scic-add-forgotten.patch
-sound-isa-cs423x-cs4236c-pnp-ids-for-netfinity-3000.patch
-enable-xfs-write-barrier.patch
-p4-clockmod-workaround-for-cpus-with-n60-errata.patch
-add-drm-support-for-radeon-x600.patch -drm-ati-use-null-instead-of-0.patch
-ati_pcigart-simplify-page_count-manipulations.patch
-drm-fix-sparse-warning-in-radeon-driver.patch
-media-video-stradis-memory-fix.patch
-gregkh-i2c-i2c-scx200_acb-07-docs-Kconfig-fix.patch
-pate_opti-build-fix.patch
-acenic-fix-checking-of-read_eeprom_byte-return-values.patch
-bonding-fix-get_settings-error-checking.patch
-gregkh-usb-usb-fix-ehci-early-handoff-issues-warning-fix.patch
-usb-yealink-printk-warning-fixes.patch
-gregkh-pci-msi-vector-targeting-abstractions-fix.patch
-sem2mutex-ioc4c.patch
-gusclassic-fix-adding-second-dma-channel.patch
-opl3sa2-fix-adding-second-dma-channel.patch
-drivers-acpi-make-two-functions-static.patch
-docbook-fix-some-comments-in-drivers-scsi.patch

 Merged

+wrongly-marked-__init-__initdata-for-cpu-hotplug.patch

 Sectioning fix

+ipmi-remove-invalid-acpi-register-spacing-check.patch

 IPMI fix

+mips-gdb-stubc-fix-parse-error-before-token.patch

 MIPS fix

+uml-compilation-fix-when-mode_skas-disabled.patch

 UML fix

+git-acpi-fixup.patch

 Fix rejects in git-acpi.patch

+git-blktrace-sparc64-fix.patch

 Make git-blktrace compile on sparc64

+git-block-revert-stuff.patch

 Revert buggy patch from git-block.patch

+gregkh-driver-spi-spi_butterfly-restore-lost-deltas.patch
+gregkh-driver-fix-uevent-buffer-overflow-in-input-layer.patch
+gregkh-driver-debugfs-trivial-comment-fix.patch
+gregkh-driver-aoe-do-not-stop-retransmit-timer-when-device-goes-down.patch

 Driver tree updates

+at76c651-dont-do-generic-__ilog2-on-mips.patch

 MIPS cleanup

-gregkh-i2c-i2c-i801-i2c-patch-for-intel-ich8.patch

 Accidentally dropped.

+gregkh-i2c-i2c-fix-sx200_acb-build-on-other-arches.patch

 I2C tree update

+drivers-mtd-use-array_size-macro.patch
+mtd-cmdlinepart-allow-zero-offset-value.patch

 MTD fixes

+git-netdev-all-s2io-fixes.patch

 Fix s2io changes in git-netdev-all.patch

+revert-NET-Do-not-lose-accepted-socket-when-ENFILE-EMFILE.patch

 Revert buggy patch from git-net.patch.

+remove-arch-ppc-syslib-ppc4xx_pmc.patch

 powerpc cleanup

+gregkh-pci-pci-handle-bogus-mcfg-entries.patch
+gregkh-pci-pci-fix-msi-build-breakage-in-x86_64.patch
+gregkh-pci-shpchp-cleanup-init_slots.patch
+gregkh-pci-shpchp-cleanup-shpchp_core.c.patch
+gregkh-pci-shpchp-cleanup-slot-list.patch
+gregkh-pci-shpchp-cleanup-controller-list.patch
+gregkh-pci-shpchp-cleanup-check-command-status.patch
+gregkh-pci-shpchp-bugfix-add-missing-serialization.patch
+gregkh-pci-pcihp_skeleton.c-cleanup.patch
+gregkh-pci-shpchp-replace-kmalloc-with-kzalloc-and-cleanup-arg-of-sizeof.patch
+gregkh-pci-shpchp-removed-unncessary-magic-member-from-slot.patch
+gregkh-pci-shpchp-move-slot-name-into-struct-slot.patch
+gregkh-pci-shpchp-fix-incorrect-return-value-of-interrupt-handler.patch

 PCI tree updates

+fusion-add-support-for-raid-hot-add-del-support.patch
+fusion-target-reset-when-drive-is-being-removed.patch
+fusion-move-sas-persistent-event-handling-over-to-the-mptsas-module.patch
+fusion-fc-rport-code-fixes.patch
+fusion-bump-version.patch

 mpt-fusion driver updates

+gregkh-usb-usb-fix-ehci-early-handoff-issues-warning.patch
+gregkh-usb-usb-hid-add-blacklist-entry-for-hp-keyboard.patch
+gregkh-usb-usb-ehci-another-full-speed-iso-fix.patch
+gregkh-usb-usb-uhci-no-fsbr-until-device-is-configured.patch
+gregkh-usb-usb-yealink-printk-warning-fix.patch
+gregkh-usb-usb-usb-authentication-states.patch
+gregkh-usb-usb-gadget-zero-and-dma-coherent-buffers.patch
+gregkh-usb-usb-mdc800.c-to-kzalloc.patch
+gregkh-usb-usb-kzalloc-for-storage.patch
+gregkh-usb-usb-kzalloc-for-hid.patch
+gregkh-usb-usb-kzalloc-in-dabusb.patch
+gregkh-usb-usb-kzalloc-in-w9968cf.patch
+gregkh-usb-usb-kzalloc-in-usbvideo.patch
+gregkh-usb-usb-kzalloc-in-cytherm.patch
+gregkh-usb-usb-kzalloc-in-idmouse.patch
+gregkh-usb-usb-kzalloc-in-ldusb.patch
+gregkh-usb-usb-kzalloc-in-phidgetinterfacekit.patch
+gregkh-usb-usb-kzalloc-in-phidgetservo.patch
+gregkh-usb-usb-kzalloc-in-usbled.patch
+gregkh-usb-usb-kzalloc-in-sisusbvga.patch
+gregkh-usb-usb-remove-the-obsolete-usb_midi-driver.patch
+gregkh-usb-usb-drivers-usb-core-message.c-make-usb_get_string-static.patch
+gregkh-usb-usb-remove-linux_version_code-macro-usage.patch
+gregkh-usb-usb-convert-a-bunch-of-usb-semaphores-to-mutexes.patch
+gregkh-usb-usb-ehci-and-nf2-quirk.patch
+gregkh-usb-usb-ehci-full-speed-iso-bugfixes.patch
+gregkh-usb-usb-ehci-for-freescale-83xx.patch
+gregkh-usb-usb-ehci-and-freescale-83xx-quirk.patch
+gregkh-usb-usb-ehci-for-au1200.patch
+gregkh-usb-usb-ohci-for-au1200.patch
+gregkh-usb-usb-ehci-unlink-tweaks.patch
+gregkh-usb-usb-add-support-for-ochi-on-at91rm9200.patch
+gregkh-usb-usb-add-support-for-at91-gadget.patch
+gregkh-usb-usb-minor-gadget-rndis-tweak.patch
+gregkh-usb-usb-fix-masking-bug-initialization-of-freescale-ehci-controller.patch
+gregkh-usb-recognize-three-more-usb-peripheral-controllers.patch
+gregkh-usb-usb-usbcore-sets-up-root-hubs-earlier.patch
+gregkh-usb-usb-ohci-uses-driver-model-wakeup-flags.patch
+gregkh-usb-uhci-use-one-qh-per-endpoint-not-per-urb.patch
+gregkh-usb-uhci-use-dummy-tds.patch
+gregkh-usb-uhci-remove-main-list-of-urbs.patch
+gregkh-usb-uhci-improve-debugging-code.patch
+gregkh-usb-uhci-don-t-log-short-transfers.patch
+gregkh-usb-usb-core-and-hcds-don-t-put_device-while-atomic.patch
+gregkh-usb-usb-serial-dynamic-id.patch
+gregkh-usb-usbip.patch
+gregkh-usb-usb-usbip-build-fix.patch
+gregkh-usb-usb-usbip-more-dead-code-fix.patch
+gregkh-usb-usb-usbip-warning-fixes.patch
+gregkh-usb-usb-gotemp.patch
+gregkh-usb-always-announce-new-usb-devices.patch

 USB tree updates (gregkh-usb-usb-remove-usbcore-specific-wakeup-flags.patch
 was buggy, dropped.)

+gregkh-usb-usb-convert-a-bunch-of-usb-semaphores-to-mutexes-fix.patch

 Fix USB tree

-x86_64-apic-main-timer-default.patch
+x86_64-apic-main-timer-ati.patch
+x86_64-hangcheck-remove-message.patch
+x86_64-stack-random-large.patch
+x86_64-garbage-values-in-file--proc-net-sockstat.patch
+x86_64-bitops-cleanups.patch
+x86_64-mark-two-routines-as-__cpuinit.patch
+x86_64-impossible-per-cpu-data-workaround.patch
+x86_64-srat-check-size.patch
+x86_64-rename-node.patch

 x86_64 tree updates

+kernel-posix-timersc-remove-do_posix_clock_notimer_create.patch

 cleanup

+fix-deadlock-in-drivers-pci-msic.patch
+drivers-block-floppyc-dont-free_irq-from-irq-context.patch
+drivers-block-floppyc-dont-free_irq-from-irq-context-fix.patch
+fix-uidhash_lock-rcu-deadlock.patch
+fix-uidhash_lock-rcu-deadlock-fix.patch
+rcu_torture_lock-deadlock-fix.patch
+warn-if-free_irq-is-called-from-irq-context.patch

 Various things from Ingo's lock validator.

+zone_reclaim-partial-scans-instead-of-full-scan.patch

 Zone reclaim fix

+mm-page_alloc-less-atomics.patch
+mm-slab-less-atomics.patch

 MM microoptimisations

+mm-split-highorder-pages-fix.patch

 Fix mm-split-highorder-pages.patch

+hugepage-allocator-cleanup.patch
+kcalloc-int_max-ulong_max.patch

 MM tweaks

+sh-sh4-202-microdev-updates.patch
+sh-make-peripheral-clock-frequency-setting-mandatory.patch
+sh-move-tra-expevt-intevt-definitions-for-reuse.patch
+sh-cleanup-struct-sh_cpuinfo-for-clock-framework-changes.patch
+sh-unknown-mach-type-updates.patch
+sh-drop-maskpos-from-make_ipr_irq-remove-duplicate-irq-definitions.patch
+sh-convert-voyagergx-to-platform-device-drop-sh-bus.patch
+sh-sh-sci-clock-framework-updates.patch
+sh-add-missing-timers-directory-rule-to-build.patch
+sh-machine_halt-machine_power_off-cleanups.patch
+sh-sh64-fix-bogus-tiocgicount-definitions.patch

 SuperH update

+i386-__devinit-should-be-__cpuinit.patch
+i386-allow-disabling-x86_feature_sep-at-boot.patch
+i386-add-a-temporary-to-make-put_user-more-type-safe.patch

 x86 fixes/features

+alpha-fix-getxpid-on-alpha-so-it-works-for-threads.patch

 Alpha fix

+swsusp-userland-interface-update.patch

 Update swsusp-userland-interface.patch

+xtensa-add-asm-futexh.patch

 xtensa update

+s390-dasd-remove-dynamic-ioctl-registration-fix.patch

 Fix s390-dasd-remove-dynamic-ioctl-registration.patch

-x86-x86_64-ia64-unify-mapping-from-pxm-to-node-id.patch
-x86-x86_64-ia64-unify-mapping-from-pxm-to-node-id-fix.patch

 Dropped - am awaiting version 2.

+reduce-size-of-percpudata-and-make-sure-per_cpuobject-fix.patch
+txt-reduce-size-of-percpudata-and-make-sure-per_cpuobject-fix-2.patch
+reduce-size-of-percpudata-and-make-sure-per_cpuobject-fix-3.patch

 Fix reduce-size-of-percpudata-and-make-sure-per_cpuobject.patch

+drivers-serial-jsm-cleanups.patch

 JSM driver cleanup

+export-cpu-topology-by-sysfs.patch
+export-cpu-topology-by-sysfs-tidy.patch
+export-cpu-topology-by-sysfs-tidy-2.patch

 Display CPU topology in sysfs,

+quota-fix-error-code-for-ext2_new_inode.patch
+fix-comment-to-synchronize_sched.patch
+compilation-of-kexec-kdump-broken-in-linux-2616-rc1.patch
+avoid-use-of-spinlock-for-percpu_counter.patch
+ipmi-mem_inout-=-intf_mem_inout.patch
+remove-fs-jffs2-histoh.patch
+new-tty-buffering-locking-fix.patch
+remove-isa-legacy-functions-drivers-char-toshibac.patch
+remove-isa-legacy-functions-drivers-net-arcnet.patch
+remove-isa-legacy-functions-drivers-scsi-g_ncr5380c.patch
+remove-isa-legacy-functions-drivers-scsi-in2000c.patch
+remove-isa-legacy-functions-drivers-net-hp-plusc.patch
+remove-isa-legacy-functions-drivers-net-hp100c.patch
+remove-isa-legacy-functions-drivers-net-lancec.patch
+remove-isa-legacy-functions-remove-the-helpers.patch
+remove-isa-legacy-functions-remove-documentation.patch
+bitmap-region-cleanup.patch
+bitmap-region-multiword-spanning-support.patch
+bitmap-region-restructuring.patch
+uninline-__sigqueue_free.patch
+free_uid-locking-improvement.patch
+represent-dirty__centisecs-as-jiffies-internally.patch
+represent-laptop_mode-as-jiffies-internally.patch
+range-checking-in-do_proc_dointvec_userhz_jiffies_conv.patch
+rcu_process_callbacks-dont-cli-while-testing-nxtlist.patch
+fs-9p-possible-cleanups.patch
+fs-ext2-proper-ext2_get_parent-prototype.patch
+fs-coda-proper-prototypes.patch
+#exec-only-allow-a-threaded-init-to-exec-from-the.patch
+exec-cleanup-exec-from-a-non-thread-group-leader.patch
+remove-dead-kill_sl-prototype-from-schedh.patch
+do_tty_hangup-use-group_send_sig_info-not.patch
+do_sak-dont-depend-on-session-id-0.patch
+pid-dont-hash-pid-0.patch

 Random fies and cleanups

+reiser4-big-update-bug-fix-for-readpage-fix.patch
+reiser4-warnings-cleanup.patch
+reiser4-do-not-use-get_user_pages-and-do-not-check.patch

 reiser4 fixes and cleanups

+always-enable-config_pdc202xx_force.patch

 IDE Kconfig cleanup

+i810fb-do-not-probe-the-third-i2c-bus-by-default.patch
+fbdev-fix-usage-of-blank-value-passed-to-fb_blank.patch

 fbdev updates

+mark-f_ops-const-in-the-inode-ppc-htab-fix.patch

 Fix mark-f_ops-const-in-the-inode.patch



All 1029 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/patch-list


