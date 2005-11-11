Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVKKEgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVKKEgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 23:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVKKEgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 23:36:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932334AbVKKEgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 23:36:01 -0500
Date: Thu, 10 Nov 2005 20:35:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-mm2
Message-Id: <20051110203544.027e992c.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/

- reiser4 seems to be broken when built as a module (due, I assume, to a
  reiser4-specific kbuild change).  CONFIG_REISER4_FS=y will be needed.

- New git tree git-cfq.patch - CFQ I/O scheduler updates from Jens

- The git-pcmcia tree has been reinstated

- git-audit and the several -mm fixups to it have been dropped for now - it's
  undergoing a bit of churn.

- Numerous subsystem updates.  Notably more v4l work.




Changes since 2.6.14-mm1:


 linus.patch
 git-acpi.patch
 git-blktrace.patch
 git-cfq.patch
 git-cifs.patch
 git-drm.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-kbuild.patch
 git-libata-all.patch
 git-mmc.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-scsi-misc.patch
 git-sas.patch
 git-cryptodev.patch

 Subsystem trees

-ppc64-64k-pages-support.patch
-ppc64-fix-bug-in-slb-miss-handler-for-hugepages.patch
-typo-correction-for-fix-build-on-nls-free-systems.patch
-#export-ia64_max_cacheline_size.patch
-ia64-re-implement-dma_get_cache_alignment-to-avoid-export_symbol.patch
-powerpc-ppc64-fix-config_smp=n-build-for-ppc64.patch
-cpu-hotplug-fix-locking-in-cpufreq-drivers.patch
-fec_8xx-build-fix.patch
-suppress-split-ptlock-on-arches-which-may-use-one-page-for-multiple-page-tables.patch
-posix-timers-smp-race-condition-tidy.patch
-agp-performance-fixes.patch
-i460-agp-warning-fixes.patch
-sound-align-device-drivers-menus.patch
-git-blktrace-fixup.patch
-pci-gart-fix.patch
-gregkh-i2c-i2c-viapro-some-adjustments.patch
-gregkh-i2c-i2c-doc-writing-clients-fix-2.patch
-activate-sata300-tx4-in-sata_promise.patch
-kbuild-permanently-fix-kernel-configuration-include-mess.patch
-sharpsl-mtd-nand-driver-support-for-akita-borzoi.patch
-git-netdev-all-fix-net_radio=n-ieee80211=y-compile.patch
-s2io-warning-fixes.patch
-gregkh-pci-pci-driver-owner-removal-agp-fixes.patch
-arch-pci_find_device-remove-alpha-kernel-sys_alcorc.patch
-arch-pci_find_device-remove-alpha-kernel-sys_sioc.patch
-arch-pci_find_device-remove-frv-mb93090-mb00-pci-frvc.patch
-arch-pci_find_device-remove-frv-mb93090-mb00-pci-irqc.patch
-arch-pci_find_device-remove-ppc-kernel-pcic.patch
-arch-pci_find_device-remove-ppc-platforms-85xx-mpc85xx_cds_commonc.patch
-arch-pci_find_device-remove-sparc64-kernel-ebusc.patch
-arch-i386-pci-acpic-use-for_each_pci_dev.patch
-gregkh-usb-usb-pm-09.patch
-eagle-and-adi-930-usb-adsl-modem-driver.patch
-eagle-and-adi-930-usb-adsl-modem-driver-tidies.patch
-x86_64-fix-find-bit.patch
-x86_64-enable_pagefaulttrace-warning-fix.patch
-x86_64-vect-share-build-fix.patch
-slab-dont-bug-on-duplicated-cache.patch
-mm-rename-kmem_cache_s-to-kmem_cache.patch
-slab-use-same-schedule-timeout-for-all-cpus-in-cache_reap.patch
-ppp-handle-misaligned-accesses-2.patch
-irda-donauboe-locking-fix.patch
-ppp_mppe-add-ppp-mppe-encryption-module.patch
-dgrs-fixes-warnings-when-config_isa-and-config_pci-are-not-enabled.patch
-3c59x-convert-to-use-of-pci-iomap-api.patch
-3c59xc-cleanup-mdio_read-routines.patch
-3c59x-avoid-blindly-reading-link-status-twice.patch
-3c59x-bounds-checking-for-hw_checksums.patch
-3c59x-cleanup-init-of-module-parameter-arrays.patch
-3c59x-fix-some-grammar-in-module-parameter-descriptions.patch
-3c59x-support-ethtool_gpermaddr.patch
-3c59x-correct-rx_dropped-counting.patch
-3c59x-enable-use-of-memory-mapped-pci-i-o.patch
-3c59x-dont-enable-scatter-gather-w-o-checksum.patch
-ppc32-add-watchdog-rtc-support-for-marvell-ev64360bp-board.patch
-ppc32-allow-erpn-for-early-serial-to-depend-on-cpu-type.patch
-ppc32-dump-error-status-for-both-plb-segments-on-440sp.patch
-ppc32-add-440spe-support.patch
-ppc32-add-yucca-440spe-eval-board-platform.patch
-ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot.patch
-ppc32-remove-internal-pci-arbiter-check-on-ppc40x.patch
-ppc32-add-missing-initrd-header-on-ppc440.patch
-ppc32-add-cpm1-config-option.patch
-sh-re-add-sh-to-drivers-makefile.patch
-sh-drop-deprecated-support-for-custom-ramdisk-embedding.patch
-superhyway-multiple-block-support-and-vcr-rework.patch
-sh-superhyway-support-for-sh4-202.patch
-sh-pte_mkhuge-compile-fix-for-config_hugetlb_page.patch
-sh-drop-hp690-discontig-support.patch
-sh-use-pfn_valid-for-lazy-dcache-write-back-on-sh7705.patch
-arch-i386-use-array_size-macro.patch
-i386-lvt-entries-remaining-unmasked-on-reboot.patch
-arch-i386-kernel-ldtc-should-include-asm-mmu_contexth.patch
-arch-i386-kernel-reboot_fixupsc-should-include-linux-reboot_fixupsh.patch
-arch-i386-kernel-scx200c-should-include-linux-scx200_gpioh.patch
-cpu-hoptlug-avoid-usage-of-smp_processor_id-in-preemptible-code.patch
-suspend-to-ram-update-docs.patch
-swsusp-cleanups.patch
-swsusp-remove-unused-variable.patch
-x86-add-mce-resume.patch
-cris-printk-duplicate-declaration.patch
-cris-extern-inline-static-inline.patch
-uml-improve-stub-debugging.patch
-uml-fix-syscall-stubs.patch
-uml-fix-uml-network-driver-endianness-bugs.patch
-uml-separate-libc-dependent-uaccess-code.patch
-uml-separate-libc-dependent-early-initialization.patch
-uml-separate-libc-dependent-early-initialization-fix.patch
-uml-separate-libc-dependent-helper-code.patch
-uml-switch_mm-fix.patch
-uml-maintain-own-ldt-entries.patch
-uml-big-memory-fixes.patch
-uml-make-tt-mode-dependent-options-depend-on-mode_tt.patch
-uml-fix-hardcoded-zone_-constants-in-zone-setup.patch
-uml-build-host-binaries-with-the-native-host-arch-again.patch
-include-asm-v850-extern-inline-static-inline.patch
-xtensa-struct-semaphoresleepers-initialization.patch
-s390-signal-delivery.patch
-s390-stop_hz_timer-vs-xtime-updates.patch
-s390-documentation-update.patch
-s390-memory-query-wait-psw.patch
-s390-ccwgroup-online-attribute.patch
-s390-remove-pagex-support.patch
-s390-test_bit-return-value.patch
-s390-dasd-diag-inline-assembly.patch
-s390-dasd-diag-with-block-sizes-512.patch
-s390-cleanup-of-include-asm-s390-vtoch.patch
-s390-duplicate-timeout-in-qdio.patch
-s390-const-pointer-uaccess.patch
-s390-fix-memory-leak-in-vmcp.patch
-s390-merge-common-parts-of-heads-and-head64s.patch
-serial-console-touch-nmi-watchdog.patch
-reorder-struct-files_struct.patch
-remove-drm-ioctl32-translations-from-sparc-and-parisc.patch
-moving-kprobes-and-oprofile-to-instrumentation-support-menu.patch
-write_inode_now-write-inode-if-not-bdi_cap_no_writeback.patch
-compat-fcntl-fixes.patch
-process-events-connector.patch
-process-events-connector-fixes.patch
-remove-hlist_for_each_rcu-api-convert-existing-use-to-hlist_for_each_entry_rcu.patch
-hfs-needs-nls.patch
-fix-floppyc-to-store-correct-ro-rw-status-in-underlying.patch
-schedule-obsolete-oss-drivers-for-removal.patch
-ide-scsi-fails-to-call-idescsi_check_condition-for-things.patch
-hpet-maintainers.patch
-serial-moxa-cleanup-mxser_init.patch
-serial-moxa-fix-leaks-of-struct-tty_driver.patch
-serial-moxa-fix-wrong-bug.patch
-fs-smbfs-requestc-turn-null-dereference-into-bug.patch
-tpm-fix-lack-of-driver_unregister-in-init-failcases.patch
-dell_rbu-adding-bios-memory-floor-support.patch
-fuse-remove-dead-code-from-fuse_permission.patch
-shm_noreserve-flags-for-shmget.patch
-readahead-commentary.patch
-reiser4-radix_tree_lookup_slot.patch
-add-be-le-types-without-underscores.patch
-small-kernel_stath-cleanup.patch
-keys-remove-incorrect-and-obsolete-operators.patch
-aio-remove-aio_max_nr-accounting-race.patch
-futex_wake_op-enhanced-error-handling.patch
-only-disallow-_setting_-of-function-key-string.patch
-quota-small-cleanups.patch
-v9fs-names_cache-memory-leak.patch
-v9fs-names_cache-memory-leak-fix.patch
-smbfs-names_cache-memory-leak.patch
-__find_get_block_slow-cleanup.patch
-kconfig-fix-kconfig-performance-bug.patch
-kconfig-preset-config-during-allconfig.patch
-kconfig-allow-variable-argumnts-for-range.patch
-kconfig-update-kconfig-makefile.patch
-kconfig-use-gperf-for-kconfig-keywords.patch
-kconfig-simplify-symbol-type-parsing.patch
-kconfig-improve-error-handling-in-the-parser.patch
-kconfig-stricter-error-checking-for-config.patch
-perform-maintenance-on-documentation-vm-hugetlbpagetxt.patch
-memory-leak-in-dentry_open.patch
-cpuset-rebind-numa-vma-mempolicy.patch
-cpuset-rebind-numa-vma-mempolicy-fix.patch
-fix-remaining-missing-includes.patch
-changing-config_localversion-rebuilds-too-much-for-no-good-reason.patch
-changing-config_localversion-rebuilds-too-much-for-no-good-reason-ipw2200-fix.patch
-max1619-build-fix.patch
-befs-use-generic_ro_fops.patch
-vxfs-use-generic_ro_fops.patch
-afs-use-generic_ro_fops.patch
-remove-superflous-ctime-mtime-updates-in-affs.patch
-add-a-vfs_permission-helper.patch
-consolidate-sys_ptrace.patch
-consolidate-sys_ptrace-x86_64-fix.patch
-add-a-file_permission-helper.patch
-sanitize-lookup_hash-prototype.patch
-re-add-tiocstart-and-tiocstop-compat_ioctl-handlers.patch
-remove-ioctl32_handler_t.patch
-move-some-compatible_ioctl-entries-from-x86_64-to-common-code.patch
-vfs-pass-file-pointer-to-filesystem-from-ftruncate.patch
-fuse-bump-interface-minor-version.patch
-fuse-add-access-call.patch
-fuse-atomic-createopen.patch
-fuse-pass-file-handle-in-setattr.patch
-implement-kmap_atomic_irqsave.patch
-as-cooperating-processes.patch
-ipmi-use-refcount-in-message-handler.patch
-ipmi-various-si-cleanup.patch
-ipmi-watchdog-parms-in-sysfs.patch
-ipmi-poweroff-cleanups.patch
-ipmi-more-dell-fixes.patch
-ipmi-si-start-transaction-hook.patch
-ipmi-bt-restart-reset-fixes.patch
-ipmi-kcs-error0-delay.patch
-ipmi-add-timer-thread.patch
-ipmi-add-timer-thread-use-kthread-api.patch
-ipmi-use-rcu-lock-for-using-command-receivers.patch
-ipmi-fix-watchdog-timeout-panic-handling.patch
-kprobes-rearrange-preempt_disable-enable-calls.patch
-kprobes-track-kprobe-on-a-per_cpu-basis-base-changes.patch
-kprobes-track-kprobe-on-a-per_cpu-basis-i386-changes.patch
-kprobes-track-kprobe-on-a-per_cpu-basis-ia64-changes.patch
-kprobes-track-kprobe-on-a-per_cpu-basis-ppc64-changes.patch
-kprobes-track-kprobe-on-a-per_cpu-basis-sparc64-changes.patch
-kprobes-track-kprobe-on-a-per_cpu-basis-x86_64-changes.patch
-kprobes-use-rcu-for-unregister-synchronization-base-changes.patch
-kprobes-use-rcu-for-unregister-synchronization-base-changes-vs-remove-hlist_for_each_rcu-api-convert-existing-use-to-hlist_for_each_entry_rcu.patch
-kprobes-use-rcu-for-unregister-synchronization-arch-changes.patch
-kprobes-preempt_disable-enable-simplification.patch
-rapidio-support-core-base.patch
-rapidio-support-core-includes.patch
-rapidio-support-core-enum.patch
-rapidio-support-core-enum-fix.patch
-rapidio-support-ppc32.patch
-rapidio-message-interface-updates.patch
-i4l-update-hfc_usb-driver.patch
-dvb-dst-correcty-identify-tuner-and-daughterboards.patch
-dvb-add-support-for-technotrend-budget-card-s1500.patch
-dvb-stv0299-revert-improper-method.patch
-dvb-add-atsc-support-for-dvico-fusionhdtv5-lite.patch
-dvb-tda1004x-pll-communication-fixes.patch
-dvb-pluto2-removed-unavoidable-error-message-and.patch
-dvb-remove-duplicate-key-definitions.patch
-dvb-microtune-mt7202dtf-fix-charge-pump-setting.patch
-dvb-dst-asn1-length-field-fix.patch
-dvb-fix-sparse-warnings.patch
-dvb-dst-fix-memory-leaks.patch
-dvb-dst-fix-broken-support-for-vp-3040-ts204.patch
-dvb-dst-fix-dst-dvb-s-get_frequency.patch
-dvb-dst-remove-redundant-checksum-calculation.patch
-dvb-dst-fix-possible-buffer-overflow.patch
-dvb-fix-integer-overflow-bug.patch
-dvb-let-other-frontends-support-fe_dishnetwork_send_legacy_cmd.patch
-dvb-remove-broken-stv0299-enhanced-tuning-code.patch
-dvb-remove-debug_lockloss-stuff.patch
-dvb-add-support-for-air2pc-airstar-2-atsc-3rd-generation.patch
-dvb-updated-documentation.patch
-dvb-updated-documentation-for-fusionhdtv-lite-cards.patch
-dvb-dst-protect-the-read-write-commands-with-a-mutex.patch
-dvb-dst-protect-dst_write_tuna-from-simultaneous.patch
-dvb-add-support-for-plls-used-by-nxt200x.patch
-dvb-nebula-nxt6000-requires-fe-reset.patch
-dvb-stv0299-reduce-i2c-xfer-and-set-register-0x12.patch
-dvb-fixed-inittab-register-0x12-for-bsru6-bsbe1.patch
-dvb-add-nxt200x-frontend-module.patch
-dvb-nxt200x-check-callback-fix.patch
-dvb-nxt200x-remove-null-check-before-kfree.patch
-dvb-determine-tuner-write-method-based-on-nxt-chip.patch
-dvb-fix-bug-in-demux-that-caused-lost-mpeg-sections.patch
-dvb-remove-status-check-from-nxt200x_readreg_multibyte.patch
-dvb-add-support-for-the-artec-t1-usb20-box.patch
-dvb-documentation-updates-for-hybrid-v4l-dvb-cards.patch
-dvb-usb-urb-printk-fix.patch
-dvb-lgdt330x-correct-qam-symbol_rate_min-for-lgdt3302.patch
-dvb-nxt200x-fix-typo-in-makefile-for-nxt200x.patch
-dvb-nxt200x-add-function-for-nxt200x-to-change-pll.patch
-v4l-627-added-support-for-oem-version-of-flytv.patch
-v4l-628-added-new-avermedia-card-550.patch
-v4l-629-added-behold-tv-409-fm.patch
-v4l-630-capitalized-hex-a-f-changed-to-lowercase.patch
-v4l-631-implemented-the-v4l2-mpeg-api-for.patch
-v4l-633-climov-s-previous-patch-missing-changelog.patch
-v4l-634-implemented-tuner-set-standby-on-cx88-init.patch
-v4l-635-add-bttv-card-137-conceptronic-ctvfmi-v2.patch
-v4l-636-don-t-enable-gpioirq-until-after-card.patch
-v4l-639-added-new-card-gotview-pci-7135.patch
-v4l-640-fixed-typos.patch
-v4l-643-use-key-media-instead-of-key.patch
-v4l-644-lower-switch-from-vhf-lo-to-vhf-hi-for.patch
-v4l-645-refine-input-handling-for-manli-beholder.patch
-v4l-646-enable-dvb-support-for-dvico-fusionhdtv5.patch
-v4l-647-included-cb3-structures-on-tda8290-that.patch
-v4l-648-some-clean-up-in-cx88-tvaudio-c.patch
-v4l-649-fixed-gcc-4-0-compile-warnings-by-moving.patch
-v4l-651-fix-a-number-of-sparse-warnings.patch
-v4l-653-ts-dma-buffer-synchronization-was-inverted.patch
-v4l-655-added-support-for-the-philips-td1316-tuner.patch
-v4l-656-added-support-for-the-following-cards.patch
-v4l-657-update-documentation.patch
-v4l-660-small-fixes.patch
-v4l-663-add-new-rtd-cards.patch
-v4l-664-improved-coding-style-for-timer-settings.patch
-v4l-665-fix-for-problem-with-audio-register-setup.patch
-v4l-667-remove-some-if-0-which-doesn-t-have-any.patch
-v4l-669-added-prolink-pixelview-pv-bt878p-rev-2e.patch
-v4l-670-cardlist-update.patch
-v4l-672-fix-build-for-2-6-14.patch
-v4l-673-initial-code-for-texas-instruments.patch
-v4l-674-move-some-if-kernel-version-into-compat-h.patch
-v4l-675-tvp5150-included-on-makefile.patch
-v4l-677-increased-eeprom-dump-to-128-bytes.patch
-v4l-678-fixed-input-selection.patch
-v4l-683-some-v4l2-api-calls-implemented-on-msp3400.patch
-v4l-685-update-the-tveeprom-tuner-list-with-the.patch
-v4l-686-change-the-number-of-lines-in-the-input.patch
-v4l-687-fix-source-charset-make-symbols-utf-8.patch
-v4l-688-add-remote-for-dvb-t300-remote.patch
-v4l-689-cx88-cardlist-updated-now-it-also-includes.patch
-v4l-690-added-support-for-lifeview-flytv-platinum.patch
-v4l-691-set-if-of-tda8275-according-to-tv-norm.patch
-v4l-692-bttv-coding-style-and-card-ids.patch
-v4l-693-bttv-board-renaming.patch
-v4l-694-updated-an-entry-to-reflect-changes-on.patch
-v4l-695-added-more-pci-id.patch
-v4l-700-added-ir-for-lifeview-flytv-platinum-mini2.patch
-v4l-702-included-audio-chips-enum.patch
-v4l-703-added-new-card-prolink-pixelview-playtv.patch
-v4l-704-enable-support-for-the-ir-remote-on-compro.patch
-v4l-705-added-kworld-vstream-expertdvd.patch
-v4l-706-reindent-cx88-tvaudio-c-to-keep-coding.patch
-v4l-707-remote-for-kworld-terminator.patch
-v4l-708-full-mute-of-saa7134-on-mute-command.patch
-v4l-709-added-osprey-440-card.patch
-v4l-711-changed-pll-1-to-pll-pll-28.patch
-v4l-712-added-analog-support-for-ati-hdtv-wonder.patch
-v4l-713-corrected-settings-for-secam-l.patch
-v4l-714-fix-typo.patch
-v4l-715-enable-s-video-input-on-dvico-fusionhdtv5.patch
-v4l-716-support-for-em28xx-board-family.patch
-v4l-717-added-scripts-and-cardlist-for-em2820.patch
-v4l-718-fixed-build.patch
-v4l-719-implement-some-differences-in-video-output.patch
-v4l-720-alsa-support-for-saa7134-that-should-work.patch
-v4l-721-check-kthread-correctly.patch
-v4l-723-fix-build-for-2-6-14.patch
-v4l-725-fixed-kernel-oops-when-hotswapping-pc.patch
-v4l-727-fixed-a-bug-that-caused-some-saa7133-code.patch
-v4l-728-vidiocsfreq-and-vidiocgfreq-expect-an.patch
-v4l-729-fixed-include-when-compiling-at-kernel.patch
-v4l-739-created-make-changelog-to-make-easier-to.patch
-v4l-754-add-the-adapter-address-prefix-to-the.patch
-v4l-758-some-improvements-at-msp3400-c-from-ivtv.patch
-v4l-759-more-improvements-at-msp3400-c-from-ivtv.patch
-v4l-761-fixed-registry-value-in-em2820-i2c-c-which.patch
-v4l-762-added-support-for-the-terratec-cinergy-250.patch
-v4l-763-include-newer-i2c-id-at-linux-include.patch
-v4l-766-add-dvb-card-winfast-dtv1000-t.patch
-v4l-767-included-support-for-em2800.patch
-v4l-768-don-t-bother-gerd-with-bttv-cards-patches.patch
-v4l-771-the-wm8775-is-a-wolfson-microelectronics.patch
-v4l-773-be-sure-to-enable-video-buf-dvb-in-kernel.patch
-v4l-775-fix-build-warnings.patch
-v4l-776-added-card-75-avermedia-avertvhd-mce-a180.patch
-v4l-777-updated-script-to-function-in-new-tree.patch
-v4l-780-fixed-typo-in-module-param-description.patch
-v4l-782-ir-kbd-i2cc-updates.patch
-v4l-783-fixed-bad-em2820-remote-layout-values-set.patch
-v4l-784-several-improvement-on-i2c-ir-handling-for.patch
-v4l-786-chip-id-removed-since-it-isn-t-required.patch
-v4l-788-log-message.patch
-v4l-789-added-support-for-saa7113.patch
-v4l-790-added-support-for-terratec-cinergy-250-usb.patch
-v4l-791-codingstyle-fixes.patch
-v4l-793-remotes-for-the-cinergy-200-usb-and.patch
-v4l-794-added-asound-skyeye-bttv-card.patch
-v4l-795-new-config-option-for-tda9887-to.patch
-v4l-796-add-sknet-monster-tv-mobile-card.patch
-v4l-797-more-intellect-on-clearing-in-bits-on-irq.patch
-v4l-798-this-patch-adds-the-vidioc-log-status-to.patch
-v4l-799-don-t-request-gpint-on-avermedia-tv.patch
-v4l-800-whitespace-cleanups.patch
-v4l-801-whitespaces-cleanups.patch
-v4l-802-replaced-kmalloc-kfree-with-usb-buffer.patch
-v4l-803-after-msp34xxg-reset-msp-wake-thread.patch
-v4l-806-add-support-for-tda8275a.patch
-v4l-809-some-changes-to-allow-compiling-cx88-and.patch
-v4l-810-vidioc-log-status-is-added-to-videodev2-h.patch
-v4l-811-strip-trailing-whitespaces.patch
-v4l-812-supports-the-pinnacle-pctv-110i-board.patch
-v4l-813-replaced-obsolete-video-get-drvdata-and.patch
-v4l-814-cleanup-dev-assignment.patch
-v4l-815-commented-obsoleted-stuff-at-videodev.patch
-v4l-816-added-driver-for-cirrus-logic-low-voltage.patch
-v4l-817-saa713x-keymaps-and-key-builders-were.patch
-v4l-818-cleanup-some-unnecessary-alsa-memory-de.patch
-v4l-819-added-autodetection-code-to-tda8290-to.patch
-v4l-820-fixed-log-for-tveeprom-on-em28xx-cards.patch
-v4l-821-set-tuner-type-in-vidioc-g-tuner.patch
-v4l-823-corrected-probing-code-for-tda8290.patch
-v4l-826-unify-whitespaces.patch
-v4l-829-fixed-user-mode-compiling.patch
-v4l-830-rearranged-print-order-to-present-a.patch
-v4l-833-analog-support-for-asus-p7131-dual.patch
-v4l-834-add-card-pctv-cardbus-tv-radio-ito25-rev.patch
-v4l-838-modified-settings-for-msi-vox-usb-2-0.patch
-v4l-840-fixed-settings-for-msi-vox-usb-2-0-saa7114.patch
-v4l-841-added-saa7114-initcode-for-msi-vox-usb-2-0.patch
-v4l-842-create-kconfig-files-for-cx88-and-saa7134.patch
-v4l-843-added-saa7114-support-on-i2c-address-0x42.patch
-v4l-847-fix-bug-5484-asus-digimatrix-card-doesnt.patch
-v4l-848-fixed-tda8290-autodetection.patch
-v4l-850-update-em2800-scaler-code-and-comments.patch
-v4l-851-fixed-broken-api-link-and-indentation.patch
-v4l-854-move-cx88-and-saa7134-configuration-out-of.patch
-v4l-855-improve-kconfig-user-friendliness-for.patch
-v4l-856-some-module-rename-and-small-fixes.patch
-v4l-859-fix-compilation-with-2-6-8.patch
-v4l-863-added-pinnacle-dazzle-dvc-90.patch
-v4l-864-improved-isoc-error-detection.patch
-v4l-865-fixed-bttv-to-accept-radio-devices-like.patch
-v4l-866-fix-bug-with-setting-mt2050-radio.patch
-v4l-867-correcting-fixes-to-accept-radio-devices.patch
-v4l-868-added-support-for-nxt200x-based-cards-ati.patch
-v4l-869-iso-c90-forbids-mixed-declarations-and.patch
-v4l-870-added-dvb-support-for-avermedia-avertvhd.patch
-v4l-871-fixed-bttv-to-accept-radio-devices-like.patch
-v4l-873-updated-comments-for-avertvhd-a180.patch
-v4l-874-quick-and-dirty-fix-for-audc-config.patch
-v4l-875-some-cleanups-at-i2c-stuff-and-fixing-when.patch
-v4l-876-moved-some-user-defines-to-be-out-of.patch
-v4l-877-module-em2820-renamed-to-em28xx-and-moved.patch
-v4l-881-video-cx88-need-not-depend-on-experimental.patch
-v4l-885-second-round-of-i2c-ids-redefinition.patch
-v4l-886-renamed-common-structures-to-em28xx.patch
-v4l-887-i2c-id-h-updated-to-reflect-the-newer.patch
-v4l-888-saa7113-renamed-to-saa711x.patch
-v4l-889-add-em28xx-to-kernel-build.patch
-v4l-890-fixed-typo.patch
-v4l-891-change-config-em28xx-to-config-video.patch
-v4l-892-correct-nicam-audio-settings-to-match.patch
-v4l-893-rollback-recent-i2c-change-to-solve-tuner.patch
-v4l-894-work-around-to-allow-hybrid-dvb-card-to.patch
-v4l-895-new-avermedia-303-card-without-radio.patch
-v4l-896-rename-bttv_foo-bttv_board_foo.patch
-v4l-897-saa7146-fix.patch
-v4l-898-em2820-i2c-fix.patch
-v4l-899-remove-media-id-h.patch
-prevent-dmesg-warning-in-zr36067-driver.patch
-knfsd-fix-setattr-on-symlink-error-return.patch
-knfsd-restore-functionality-to-read-from-file-in-proc-fs-nfsd.patch
-knfsd-allow-run-time-selection-of-nfs-versions-to-export.patch
-knfsd-fix-some-minor-sign-problems-in-nfsd-xdr.patch
-knfsd-make-sure-svc_process-call-the-correct-pg_authenticate-for-multi-service-port.patch
-optimize-activate_task.patch
-sched-implement-nice-support-across-physical-cpus-on-smp.patch
-sched-change_prio_bias_only_if_queued.patch
-sched-account_rt_tasks_in_prio_bias.patch
-sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch
-sched-correct_smp_nice_bias.patch
-sched-consider-migration-thread-with-smp-nice.patch
-sched-better-wake-balancing-3.patch
-sched-disable-preempt-in-idle-tasks-2.patch
-sched-disable-preempt-in-idle-tasks-2-powerpc-fixes.patch
-sched-resched-and-cpu_idle-rework.patch
-sched-resched-and-cpu_idle-rework-warning-fix.patch
-ide-move-config_ide_max_hwifs-into-linux-ideh.patch
-siimage-enable-interrupts-on-adaptec-sa-1210-card.patch
-ide-explain-the-pci-bus-test.patch
-drivers-ide-possible-cleanups.patch
-framebuffer-add-some-help-text-in-kconfig.patch
-fb-straighten-up-fb-drivers-menu.patch
-nvidiafb-fix-mode-setting-ppc-support.patch
-nvidiafb-fix-mode-setting-ppc-support-warning-fixes.patch
-nvidiafb-add-flat-panel-dither-support.patch
-intelfb-extend-partial-support-of-i915g-to-include-i915gm.patch
-radeonfb-prevent-spurious-recompilations.patch
-fbcon-fbdev-move-softcursor-out-of-fbdev-to-fbcon.patch
-fbcon-consolidate-redundant-code.patch
-fbcon-use-helper-function-when-filling-out-var-structure.patch
-fbcon-initialize-new-driver-when-old-driver-is-released.patch
-fbdev-remove-software-clipping-from-drawing.patch
-vesafb-fix-color-palette-handling.patch
-atyfb-get-initial-mode-timings-from-lcd-bios.patch
-savagefb-convert-from-vga-io-access-to-mmio-access.patch
-pm2fb-manual-configuration-of-timings-for-elsa-winner.patch
-fbdev-workaround-for-buggy-edid-blocks.patch
-nvidiafb-fix-empty-macro.patch
-fbdev-fix-the-fb_find_nearest_mode-function.patch
-s3c2410fb-initialise-device_driver-owner.patch
-vesafb-disable-mtrr-as-the-default.patch
-i810fb-cleanup-i2c-code.patch
-console-fix-compile-error.patch
-fbcon-add-rl-roman-large-font.patch
-fbdev-rearrange-mode-database-entries.patch
-fbdev-add-helper-to-get-an-appropriate-initial-mode.patch
-fbdev-convert-a-few-drivers-to-use-the-fb_find_best_display.patch
-fbdev-ati-rn50-pci-id.patch
-fix-dm-snapshot-tutorial-in-documentation.patch
-md-better-handling-of-readerrors-with-raid5.patch
-md-initial-sysfs-support-for-md.patch
-md-extend-md-sysfs-support-to-component-devices.patch
-md-add-kobject-sysfs-support-to-raid5.patch
-md-allow-a-manual-resync-with-md.patch
-md-teach-raid5-the-difference-between-check-and-repair.patch
-md-provide-proper-rcu_dereference--rcu_assign_pointer-annotations-in-md.patch
-md-fix-ref-counting-problems-with-kobjects-in-md.patch
-md-minor-md-fixes.patch
-md-change-raid5-sysfs-attribute-to-not-create-a-new-directory.patch
-md-improvements-to-raid5-handling-of-read-errors.patch
-md-convert-faulty-and-in_sync-fields-to-bits-in-flags-field.patch
-md-make-md-on-disk-bitmaps-not-host-endian.patch
-md-support-bio_rw_barrier-for-md-raid1.patch
-md-remove-attempt-to-use-dynamic-names-in-sysfs-for-component-devices-on-an-md-array.patch
-md-allow-md-arrays-to-be-started-read-only-module-parameter.patch
-md-make-sure-block-link-in-sys-md-goes-to-correct-devices.patch
-md-make-manual-repair-work-for-raid1.patch
-md-make-sure-a-user-request-sync-of-raid5-ignores-intent-bitmap.patch
-md-fix-some-locking-and-module-refcounting-issues-with-mds-use-of-sysfs.patch
-md-split-off-some-md-attributes-in-sysfs-to-a-separate-group.patch
-md-only-try-to-print-recovery-resync-status-for-personalities-that-support-recovery.patch
-md-ignore-auto-readonly-flag-for-arrays-where-it-isnt-meaningful.patch
-md-complete-conversion-of-md-to-use-kthreads.patch
-md-improve-scan_mode-and-rename-it-to-sync_action.patch
-md-document-sysfs-usage-of-md-and-make-a-couple-of-small-refinements.patch
-documentation-sparsetxt-mention-cf=-wbitwise.patch
-ksymoops-related-docs-update.patch
-doc-msi-howto-cleanups.patch
-jbd-doc-fix-some-kernel-doc-warnings.patch
-kernel-doc-fix-some-kernel-api-warnings.patch
-doc-hpettxt-change-to-80-columns.patch
-more-kernel-doc-cleanups-additions.patch
-kernel-docs-fix-kernel-doc-format-problems.patch
-vfs-update-overview-document.patch
-vfs-split-dentry-locking-documentation.patch
-ramfs-rootfs-and-initramfs-docs.patch
-kernel-doc-fix-warnings-in-vmallocc.patch
-fs-nameic-make-path_lookup_create-static.patch
-ia64-fix-up-schedule_timeout-usage.patch
-m68k-fix-up-schedule_timeout-usage.patch
-ppc-fix-up-schedule_timeout-usage.patch
-um-fix-up-schedule_timeout-usage.patch
-drivers-acpi-fix-up-schedule_timeout-usage.patch
-ieee1394-fix-up-schedule_timeout-usage.patch
-isdn-fix-up-schedule_timeout-usage.patch
-drivers-macintosh-fix-up-schedule_timeout-usage.patch
-drivers-md-fix-up-schedule_timeout-usage.patch
-drivers-media-fix-up-schedule_timeout-usage.patch
-message-fix-up-schedule_timeout-usage.patch
-drivers-scsi-fix-up-schedule_timeout-usage.patch
-serial-fix-up-schedule_timeout-usage.patch
-drivers-cdrom-kmalloc-memset-kzalloc-conversion.patch
-drivers-dio-kmalloc-memset-kzalloc-conversion.patch
-drivers-eisa-kmalloc-memset-kzalloc-conversion.patch
-drivers-fc4-kmalloc-memset-kzalloc-conversion.patch
-drivers-firmware-kmalloc-memset-kzalloc-conversion.patch
-ide-kmalloc-memset-kzalloc-conversion.patch
-ide-kmalloc-memset-kzalloc-conversion-fix.patch
-bluetooth-kmalloc-memset-kzalloc-conversion.patch
-kfree-cleanup-drivers-scsi.patch
-kfree-cleanup-net.patch
-kfree-cleanup-drivers-mtd.patch
-kfree-cleanup-drivers-char.patch
-kfree-cleanup-drivers-isdn.patch
-kfree-cleanup-drivers-s390.patch
-kfree-cleanup-drivers-media.patch
-kfree-cleanup-misc-remaining-drivers.patch
-kfree-cleanup-fs.patch
-kfree-cleanup-arch.patch
-kfree-cleanup-security.patch
-mm-mmapnommuc-several-unexports.patch
-unexport-hugetlb_total_pages.patch
-unexport-clear_page_dirty_for_io.patch
-mm-page_allocc-unexport-nr_swap_pages.patch
-unexport-console_unblank.patch
-mm-swapc-unexport-vm_acct_memory.patch
-mm-swapfilec-unexport-total_swap_pages.patch
-mm-swap_statec-unexport-swapper_space.patch
-unexport-idle_cpu.patch
-unexport-uts_sem.patch
-__deprecated_for_modules-insert_resource.patch
-__deprecated_for_modules-panic_timeout.patch
-sound-oss-sequencer_syms-unexport-reprogram_timer.patch
-fs-superc-unexport-user_get_super.patch
-unexport-phys_proc_id-and-cpu_core_id.patch
-drivers-pnp-cleanups.patch

 Merged

+work-around-gcc-32x-cpp-bug.patch

 kbuild fixup

-increase-maximum-kmalloc-size-to-256k.patch
-increase-maximum-kmalloc-size-to-256k-fix.patch

 Dropped

-mpt-fusion-free-irq-in-suspend.patch

 Dropped

+elevator-init-fixes.patch
+elevator-init-fixes-2.patch

 I/O scheduler fixes

+cpufreq-nforce2c-fix-u320-test.patch

 cpufreq fix

-gregkh-driver-driver-sample.sh.patch

 driver tree fixes

+speakup-is-busted-on-pc64.patch

 trying to get ppc64 allmodconfig to work.

-git-drm-prep.patch

 Unneeded now

+gregkh-i2c-i2c-i801-explicitly-set-smbauxctl.patch
+gregkh-i2c-i2c-ds1337-init.patch
+gregkh-i2c-hwmon-adm1025-adm1026-remove-deprecated-symbols.patch

 i2c tree updates

+libatah-needs-dma-mappingh.patch

 libata build fix

+drivers-mtd-possible-cleanups.patch

 MTD cleanups

+mtd-make-sharpc-compile.patch

 mtd build fix

+sky2-needs-dma_mappingh.patch

 netdev build fix

+gregkh-pci-pci_ids-cleanup-fix-two-additional-ids-in-bt87x.patch
+gregkh-pci-pci-drivers-pci-small-cleanups.patch
+gregkh-pci-pci-changing-msi-to-use-physical-delivery-mode-always.patch
+gregkh-pci-pci-fix-namespace-clashes.patch
+gregkh-pci-pci-fix-for-toshiba-ohci1394-quirk.patch
+gregkh-pci-pci-pci_find_device-remove-sys_sio.patch
+gregkh-pci-pci-pci_find_device-remove-sys_alcor.patch
+gregkh-pci-pci-pci_find_device-remove-pci-ppc.patch
+gregkh-pci-pci-pci_find_device-remove-pci-mpc85xx_cds_common.patch
+gregkh-pci-pci-pci_find_device-remove-pci-frv.patch
+gregkh-pci-pci-pci_find_device-remove-pci-ebus.patch
+gregkh-pci-pci-arch-pci_find_device-remove-frv.patch
+gregkh-pci-pci-arch-i386-pci-acpi.c-use-for_each_pci_dev.patch

 PCI tree updates

+gregkh-pci-pci-driver-owner-removal-fix-spider_net.patch
+pciehp_hpc-build-fix.patch
+shpchp_hpc-build-fix.patch

 Fixes thereto

+git-scsi-misc-fixup.patch

 Fix reject in git-scsi-misc

+kill-libata-scsi_wait_req-usage-make-libata-compile-in.patch
+kill-libata-scsi_wait_req-usage-make-libata-compile-in-fix.patch

 Fix libata for git-scsi-misc API change

-areca-raid-linux-scsi-driver-update.patch
-areca-raid-linux-scsi-driver-update-2.patch
-areca-raid-linux-scsi-driver-update-3.patch

 Folded into areca-raid-linux-scsi-driver.patch

+aic94xx_init-needs-dma-mappingh.patch
+sas_task-needs-timerh.patch
+sas_event-needs-schedh.patch

 git-sas.patch build fixes

+display7seg-build-fix.patch

 sparc driver build fix

+gregkh-usb-usb-eagle-and-adi-930-usb-adsl-modem-driver.patch
+gregkh-usb-usb-eagle-and-adi-930-usb-adsl-modem-driver-fix.patch
+gregkh-usb-usb-remove-usb_audio-and-usb_midi-drivers.patch
+gregkh-usb-usb-drivers-usb-core-message.c-make-usb_get_string-static.patch
+gregkh-usb-usb-ehci-updates.patch
+gregkh-usb-usb-ehci-updates-mostly-whitespace-cleanups.patch
+gregkh-usb-usb-ehci-updates-split-init-reinit-logic-for-resume.patch
+gregkh-usb-usb-ehci-updates-driver-model-wakeup-flags.patch
+gregkh-usb-usb-wakeup-flag-updates-sl811-hcd.patch
+gregkh-usb-usb-wakeup-flag-updates-uhci-hcd.patch
+gregkh-usb-usb-wakeup-flag-updates-isp116x-hcd.patch
+gregkh-usb-usb-ohci-move-ppc-asic-tweaks-nearer-pci.patch
+gregkh-usb-usb-hcd-uses-extra_cflags-for-ddebug.patch
+gregkh-usb-usb-onetouch-doesn-t-suspend-yet.patch
+gregkh-usb-usb-serial-anydata.patch

 USB tree updates

+x86_64-max-apics.patch
+x86_64-sparse-fix.patch

 x86_64 tree updates

-m.patch

 Folded into mm.patch

+mm-__gfp_nofail-fix.patch

 Fix __GFP_NOFAIL

+mm-__alloc_pages-cleanup.patch
+mm-__alloc_pages-cleanup-tidy.patch
+mm-highmem-watermarks.patch
+mm-dont-print-per-cpu-vm-stats-for-offline-cpus.patch

 page allocator fixes and tuneups

+hugetlb-remove-duplicate-i_size-check.patch
+hugetlb-rename-find_lock_page-to.patch
+hugetlb-reorganize-hugetlb_fault-to-prepare-for-cow.patch
+hugetlb-copy-on-write-support.patch

 copy on write support for hugetlb pages

+swap-migration-v5-lru-operations-fix.patch

 Fix swap-migration-v5-lru-operations.patch

+cpusets-swap-migration-interface.patch

 Access swap migration via cpusets API

+fix-sparse-warning-in-horizon-atm-driver.patch

 Fix a sparse warning

+8139cp-register-interrupt-handler-when-net-device-is-registered.patch
+ipw2200-kzalloc-conversion-and-kconfig-dependency-fix.patch

 netdev things

+security-possible-cleanups.patch

 Code cleanup

+ppc-add-support-for-new-powerbooks.patch
+ppc32-add-support-for-handling-pci-interrupts-on-mpc834x.patch

 ppc32 updates

+powerpc-check_for_initrd-fix.patch
+powerpc-xmon-build-fix.patch

 ppc64 updates

+arch-i386-mm-initc-small-cleanups.patch
+i386-nmi-pointer-comparison-fix.patch
+x86-gdt-alignment-fix.patch
+i386-dont-blindly-enable-interrupts-in-die.patch
+i386-move-simd-initialization.patch
+i386-move-simd-initialization-fix.patch
+i386-fix-bound-check-idt-gate.patch
+x86-cr4-is-valid-on-some-486s.patch
+x86-pnp-segments-in-segment-h.patch
+x86-always-relax-segments.patch
+x86-apm-seg-in-gdt.patch
+x86-deprecate-obsolete-ldt-accessors.patch
+x86-pnp-byte-granularity.patch
+x86-fixed-pnp-bios-limits.patch
+x86-stop-deleting-nt.patch
+x86-apm-is-on-cpu-zero-only.patch
+x86-deprecate-useless-bug.patch

 x86 fixes

+mark-rodata-section-read-only-generic-infrastructure.patch
+mark-rodata-section-read-only-x86-parts.patch
+mark-rodata-section-read-only-generic-x86-64-bugfix.patch
+mark-rodata-section-read-only-x86-64-support.patch
+mark-rodata-section-read-only-make-some-datastructures-const.patch
+debug-option-to-write-protect-rodata-x86-support-warning-fix.patch

 debugging feature: mark the kernel's read-only data section as read-only. 
 So modifying a const variable (for example) will oops.

+x86_64-fix-page-fault-from-show_trace.patch

 x86_64 fix

+suspend-support-for-pnp-bus.patch
+move-pm_register-etc-to-config_pm_legacy-pm_legacyh.patch

 power management updates

+m68k-introduce-task_thread_info.patch
+m68k-introduce-setup_thread_stack-end_of_stack.patch
+m68k-thread_info-header-cleanup.patch
+m68k-m68k-specific-thread_info-changes.patch
+m68k-convert-thread-flags-to-use-bit-fields.patch
+add-stack-field-to-task_struct.patch
+rename-allocfree_thread_info-to-allocfree_thread_stack.patch
+rename-allocfree_thread_info-to-allocfree_thread_stack-powerpc-fix.patch
+use-end_of_stack.patch
+change-thread_info-access-to-stack.patch
+use-task_thread_info.patch

 Bring back the m68k fixes and thread_info cleanup patches

+signal-handling-revert-sigkill-priority-fix.patch

 signal fix

+rcu-signal-handling-fix-in-attach_pid.patch

 Fix rcu-signal-handling.patch

+ext3_readdir-use-generic-readahead-fixes.patch

 Fix the new ext3 readahead so it still doesn't work right.

+fix-missing-includes-for-2614-git11.patch

 Continue to untangle header files

-new-driver-synclink_gt-header.patch
-new-driver-synclink_gt-kconfig.patch
-new-driver-synclink_gt-makefile.patch
+new-char-driver-synclink_gt-2.patch

 New version of this driver

+fat-move-fat_clusters_flush-to-write_super.patch
+fat-use-sb_find_get_block-instead-of-sb_getblk.patch
+fat-add-the-read-writepages.patch
+fat-s-export_symbol-export_symbol_gpl.patch
+fat-support-direct_io.patch
+export-change-sync_page_range-_nolock.patch
+fat-support-a-truncate-for-expanding-size-2.patch

 fatfs updates

+ext3-journal-handling-on-error-path-in-ext3_journalled_writepage.patch

 ext3 fix

+synclink-update-to-use-dma-mapping-api.patch

 Modernise the synclink driver

+fix-and-add-export_symbolfilemap_write_and_wait.patch

 pagecache writeout fix

+move-rtc_interrupt-prototype-to-rtch.patch

 Cleanup

+fix-sparse-warning-in-proc-task_mmuc.patch

 sparse fix

+drivers-isdn-extern-inline-static-inline.patch
+kernel-small-cleanups.patch

 cleanups

+shut-up-per_cpu_ptr-on-up.patch

 warning fix

+pktcdvd-remove-subscribers-only-list.patch
+pktcdvd-use-bd_claim-to-get-exclusive-access.patch

 packet driver update

+rcutorture-renice-to-low-priority.patch

 Make the RCU self-test more useable

+i386-generic-cmpxchg.patch
+i386-generic-cmpxchg-tidy.patch
+atomic-cmpxchg.patch
+atomic-cmpxchg-tidy.patch
+atomic-inc_not_zero.patch
+atomic-inc_not_zero-tidy.patch

 Make cmpxchg() available on all architectures

+atomic-dec_and_lock-use-atomic-primitives.patch
+rcu-file-use-atomic-primitives.patch
+rcu-file-use-atomic-primitives-tidy.patch

 Applications of cmpxchg

+elf-symbol-table-type-additions.patch

 Elf additions

+arch-mips-au1000-common-usbdevc-dont-concatenate-__function__-with-strings.patch

 cleanup

+pc-speaker-add-snd_silent.patch

 PC speaker driver feature: add ioctl to shut it up

+stop_machine-vs-synchronous-ipi-send-deadlock.patch

 Fix machine halting race

+ipc-expand-shm_flags.patch

 ipc.c cleanup

+aio-remove-kioctx-from-mm_struct.patch
+aio-replace-locking-comments-with-assert_spin_locked.patch
+aio-dont-ref-kioctx-after-decref-in-put_ioctx.patch

 AIO updates

+relayfs-add-support-for-non-relay-files.patch
+relayfs-documentation-for-non-relay-file-support.patch
+relayfs-make-exported-relay-fileops-useful.patch
+relayfs-documentation-for-exported-relay-fileops.patch

 relayfs feature work

+ext2-remove-duplicate-newlines-in-ext2_fill_super.patch

 fix a printk

+accth-needs-jiffies-h.patch

 build fix

+hdaps-convert-to-dynamic-input_dev-allocation.patch

 hdaps oops fix

+add-vfs_-helpers-for-xattr-operations-fix.patch

 Fix add-vfs_-helpers-for-xattr-operations.patch

+__deprecated_for_modules-the-lookup_hash-prototype.patch

 lookup_hash() is deprecated in modules

+compat-remove-leftovers-from-register_ioctl32_conversion.patch

 More compat cleanups

+edac-core-edac-support-edac-kconfig-fixes.patch
+edac-needs-x86.patch

 EDAC driver updates

+parport-daisy-chain-device-id-reading-fix-2.patch

 Fix parport-daisy-chain-device-id-reading-fix.patch

+dlm-device-interface-dlm-force-unlock.patch
+dlm-use-configfs-fix-2.patch
+dlm-cleanup-unused-functions.patch
+dlm-include-own-headers.patch

 DLM updates

+v4l-9261-added-compiling-options-for-wm8775-and.patch
+v4l-930-alsa-fixes-and-improvements.patch
+v4l-943-added-secam-l-video-standard.patch
+v4l-935-moved-common-ir-stuff-to-ir-commonc.patch
+v4l-936-support-for-sabrent-bt848-version.patch
+v4l-937-included-missing-interrupth-at.patch
+v4l-939-support-for-nebula-rc5-based-gpio-remote.patch
+v4l-944-added-driver-for-saa7127-video.patch
+v4l-944-added-driver-for-saa7127-video-tidy.patch
+v4l-945-adds-a-new-include-for-internal.patch
+v4l-946-adds-support-for-cx25840-video.patch
+v4l-949-added-support-for-secam-l.patch
+v4l-950-added-compiler-options-for-cx25840-saa7115.patch
+v4l-951-make-saa7134-oss-as-a-stand-alone-module.patch
+v4l-958-make-cx25840-use-firmware-image-named.patch
+v4l-962-added-new-saa7134-card-msi-tv-anywhere.patch
+v4l-963-em28xx-ir-fixup.patch
+v4l-9631-hybrid-v4l-dvb-remove-duplicated-code.patch
+v4l-948-adds-support-for-saa7115-video.patch
+v4l-966-authorship-fixes-for-new-modules.patch
+v4l-9661-removes-obsoleted-i2c-compath-from.patch
+v4l-prevent-saa7134-alsa-undefined-warnings.patch
+v4l-saa711x-driver-doesnt-need-segmenth.patch

 More v4l updates

+sched-add-cacheflush-asm.patch
+scheduler-cache-hot-autodetect.patch

 Bring back the CPU scheduler auto-tuning code.

+sched-filter-affine-wakeups.patch

 CPU scheduler tuning

+reiser4-spinlock-cleanup.patch
+reiser4-fix-kbuild.patch

 reiser4 updates

+ia64-drop-arch-specific-ide-max_hwifs-definition.patch
+drivers-ide-pci-alim15x3c-replace-pci_find_device-with-pci_dev_present.patch
+drivers-ide-pci-alim15x3c-use-kern_warning.patch
+stop-compactflash-devices-being-marked-as-removable.patch

 IDE updates

+fix-console-blanking.patch
 console driver fix

+make-vesafb-build-without-config_mtrr.patch

 framebuffer driver fix

+md-dm-reduce-stack-usage-with-stacked-block-devices.patch
+md-dm-reduce-stack-usage-with-stacked-block-devices-fixes.patch

 Fix CPU stack windup with deep device mapper stacking

+docbook-allow-to-mark-structure-members-private.patch
+docbook-include-printk-documentation.patch
+docbook-comment-about-paper-type.patch
+docbook-revert-xmlto-use-for-ps-and-pdf-documentation.patch

 kerneldoc updates

+synclink_gt-conversion-to-new-buffering.patch

 Convert new synclink_gt driver to the new TTY API


All 610 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/patch-list


