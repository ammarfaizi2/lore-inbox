Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVCPMOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVCPMOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVCPMOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:14:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:12473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262551AbVCPMHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:07:17 -0500
Date: Wed, 16 Mar 2005 04:06:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-mm4
Message-Id: <20050316040654.62881834.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/

- fbdev update

- percfctr updates

- Lots of ppc32/ppc64 things

- Broken on some ia64 machines.  We're still working through fallout from
  the recent pagetable walking consolidation patches.



Changes since 2.6.11-mm3:


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
 bk-kbuild.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-scsi.patch
 bk-usb.patch
 bk-watchdog.patch
 bk-xfs.patch

 Latest versions of subsystem trees

-ia64-msi-build-fix.patch
-x86-fix-booting-non-numa-system-with-numa-config.patch
-ppc32-add-rtc-hooks-to-katana-fw-bug-workaround.patch
-ppc64-fix-linking-zimage-with-biarch-ld.patch
-ppc64-export-proper-version-from-vdso.patch
-ppc64-dont-use-in_atomic.patch
-ppc64-new-machine-definitions.patch
-ppc64-add-ide-pmac-support-for-new-shasta-chipset.patch
-ppc64-fix-some-pci-interrupt-routing-issues-on-imac-g5.patch
-ppc64-add-basic-support-for-the-smu-chip-in-imac-g5.patch
-pcmcia-update-vrc4171_card.patch
-pcmcia-yenta_socket-ti4150-support.patch
-pcmcia-pd6729-convert-to-pci_register_driver.patch
-pcmcia-rsrc_nonstatic-sysfs-output.patch
-pcmcia-rsrc_nonstatic-sysfs-input.patch
-pcmcia-mark-resource-setup-as-done.patch
-pcmcia-pcmcia_device_probe.patch
-pcmcia-pcmcia_device_remove.patch
-pcmcia-pcmcia_device_add.patch
-pcmcia-use-bus_rescan_devices.patch
-pcmcia-add-pcmcia-devices-autonomously.patch
-pcmcia-determine-some-useful-information-about-devices.patch
-pcmcia-per-device-sysfs-output.patch
-sched-timestamp-fixes.patch
-sched-rework-schedstats.patch
-sched-find_busiest_group-fixlets.patch
-sched-find_busiest_group-cleanup.patch
-sched-re-inline-sched-functions.patch
-v4l-ir-common-update.patch
-v4l-bttv-driver-update.patch
-v4l-video-buf-update.patch
-v4l-bttv-ir-driver-update.patch
-v4l-tuner-update.patch
-v4l-documentation-update.patch
-v4l-tveeprom-update.patch
-stradisc-vfree-checking-cleanups.patch
-miropcm20-radio-cleanup.patch
-media-zr36120-replace-interruptible_sleep_on-with-wait_event_interruptible.patch
-media-zoran_driver-replace-interruptible_sleep_on_timeout-with-wait_event_interruptible_timeout.patch
-media-zoran_device-replace-interruptible_sleep_on-with-wait_event_interruptible.patch
-media-zoran_card-remove-interruptible_sleep_on_timeout-usage.patch
-media-saa7110-remove-sleep_on-usage.patch
-media-radio-zoltrix-replace-sleep_delay-with-msleep.patch
-media-planb-replace-interruptible_sleep_on-with-wait_event.patch
-videotext-use-i2c_client_insmod-macro.patch
-dvb-add-pll-lib.patch
-dvb-mt352-frontend-driver-update.patch
-v4l2-api-mpeg-encoder-support.patch
-saa7134-update.patch
-v4l-cx88-driver-update.patch
-dvb-add-or51132-driver-atsc-demodulator.patch
-media-video-cx88-convert-pci_module_init-to-pci_register_driver.patch
-v4l-maintainers-file-update.patch
-md-erroneous-sizeof-use-in-raid1.patch
-md-fix-multipath-assembly-bug.patch
-md-raid-kconfig-cleanups-remove-experimental-tag-from-raid-6.patch
-md-remove-possible-oops-in-md-raid1.patch
-md-make-raid5-and-raid6-robust-against-failure-during-recovery.patch
-md-remove-kludgy-level-check-from-mdc.patch
-update-documentation-filesystems-locking.patch
-docbook-allow-preprocessor-directives-between-kernel-doc-and-function.patch
-docbook-update-function-parameter-description-in-network-code.patch
-docbook-update-function-parameter-description-in-block-fs-code.patch
-docbook-update-function-parameter-description-in-usb-code.patch
-docbook-fix-function-parameter-descriptin-in-fbmem.patch
-docbook-new-kernel-doc-comments-for-might_sleep-wait_event_.patch
-docbook-convert-template-files-to-xml.patch
-docbook-s-sgml-xml-in-scripts-kernel-doc.patch
-docbook-move-kernel-doc-comment-next-to-function.patch
-docbook-s-sgml-xml-in-documentation-docbook-makefile.patch
-docbook-fix-xml-in-templates.patch
-docbook-kernel-docify-comments.patch
-docbook-add-kfifo-to-kernel-api-docs.patch
-docbook-factor-out-escaping-of-xml-special-characters.patch
-docbook-escape-declaration_purpose.patch
-make-various-things-static.patch
-fix-i2c-messsage-flags-in-video-drivers.patch
-bk-input-hid-core-warning-fix.patch
-st-msleep-warning-fix.patch
-hw-watchdog-vs-softdog-fix.patch
-orphaned-pagecache-memleak-fix.patch
-reiserfs-make-sure-data=journal-buffers-are-cleaned-on-free.patch
-ia64-specific-dev-mem-handlers.patch
-allow-vma-merging-with-mlock-et-al.patch
-ptwalk-pd_none_or_clear_bad.patch
-ptwalk-pd_none_or_clear_bad-ia64-fix.patch
-ptwalk-change_protection.patch
-ptwalk-sync_page_range.patch
-ptwalk-unuse_mm.patch
-ptwalk-map-and-unmap_vm_area.patch
-ptwalk-ioremap_page_range.patch
-ptwalk-remap_pfn_range.patch
-ptwalk-zeromap_page_range.patch
-ptwalk-unmap_page_range.patch
-ptwalk-copy_page_range.patch
-ptwalk-copy_pte_range-hang.patch
-ptwalk-clear_page_range.patch
-ptwalk-move-pd_none_or_clear_bad.patch
-ptwalk-inline-pmd_range-and-pud_range.patch
-ptwalk-pud-and-pmd-folded.patch
-vmalloc-introduce-__vmalloc_area-function.patch
-vmalloc-use-__vmalloc_area-in-arch-arm.patch
-vmalloc-use-__vmalloc_area-in-arch-sparc64.patch
-vmalloc-use-__vmalloc_area-in-arch-x86_64.patch
-vmalloc-use-list-of-pages-instead-of-array-in-vm_struct.patch
-no-arch-specific-mem_map-init.patch
-unbacked-shared-memory-not-included-in-elf-core-dump.patch
-fix-driver-name-in-sk98lin.patch
-ppc-8260-fcc-ethernet-driver-cannot-read-lxt971-phy-id.patch
-netfilter-include-fix.patch
-netfilter-snafu-fix.patch
-ppc32-update-chestnut-platform-files.patch
-ppc32-emulate-load-store-string-instructions.patch
-ppc32-remove-spr-short-hand-defines.patch
-ppc64-numa-memory-fixup.patch
-swsusp-use-non-contiguous-memory-on-resume.patch
-swsusp-use-non-contiguous-memory-on-ppc.patch
-swsusp-enable-resume-from-initrd.patch
-swsusp-do-not-provoke-emergency-disk-shutdowns.patch
-allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
-consolidate-debug_info.patch
-fix-warning-in-gkc-make-gconfig.patch
-module_device_tables.patch
-rol-ror-type-cleanup.patch
-config_base_full-help-clarification.patch
-selinux-needs-inet.patch
-verify_area-cleanup-drivers-part-1.patch
-verify_area-cleanup-drivers-part-2.patch
-verify_area-cleanup-sound.patch
-verify_area-cleanup-sound-fix.patch
-verify_area-cleanup-i386-and-misc.patch
-verify_area-cleanup-mips.patch
-verify_area-cleanup-ppc-ppc64-m68k-m68knommu.patch
-verify_area-cleanup-sparc-and-sparc64.patch
-verify_area-cleanup-x86_64-and-ia64.patch
-verify_area-cleanup-misc-remaining-archs.patch
-verify_area-cleanup-deprecate.patch
-arch_alpha_kernel_osf_sys-tiny-cleanup-retvalpatch.patch
-arch_alpha_kernel_osf_sys-tiny-cleanup-retvalpatch-fix.patch
-fs_compat-tiny-cleanup-retvalpatch.patch
-arch_mips_kernel_irixsig-slight-rework-of-irix_sigsendsetpatch.patch
-arch_sparc_kernel_ptrace-pointless-assignment-and-shadowed-varpatch.patch
-oprofile-make-some-code-static.patch
-update-email-address-of-andrea-arcangeli.patch
-i386-cpu-commonc-some-cleanups.patch
-i386-x86_64-io_apicc-misc-cleanups.patch
-3w-abcdh-tw_device_extension-remove-an-unused-filed.patch
-kill-aux_device_present.patch
-mostly-i386-mm-cleanup.patch
-update-email-address-of-benjamin-lahaise.patch
-update-email-address-of-philip-blundell.patch
-saa7146_vv_ksymsc-remove-two-unused-export_symbol_gpls.patch
-fix-placement-of-static-inline-in-nfsdh.patch
-mm-page-writebackc-remove-an-unused-function.patch
-misc-isapnp-cleanups.patch
-some-pnp-cleanups.patch
-make-loglevels-in-init-mainc-a-little-more-sane.patch
-isicom-use-null-for-pointer.patch
-remove-bouncing-email-address-of-hennus-bergman.patch
-i386-apic-kconfig-cleanups.patch
-remove-bouncing-email-address-of-thomas-hood.patch
-fs-adfs-dir_fc-remove-an-unused-function.patch
-drivers-char-moxac-if-0-an-unused-function.patch
-oss-sb_cardc-no-need-to-include-mcah.patch
-ioschedc-use-proper-documentation-path.patch
-small-drivers-video-kyro-cleanups.patch
-drivers-block-cpqarrayc-small-cleanups.patch
-pcxx-remove-obsolete-driver.patch
-warning-fix-in-drivers-cdrom-mcdc.patch
-wavefront-reduce-stack-usage.patch
-mm-page-writebackc-remove-an-unused-function-2.patch
-generic_serialh-kill-incorrect-gs_debug-reference.patch
-remove-the-unused-oss-maestro_tablesh.patch
-fs-hfs-misc-cleanups.patch
-fs-hfsplus-misc-cleanups.patch
-i386-math-emu-misc-cleanups.patch
-non-pc-parport-config-change.patch
-prism54-misc-cleanups.patch
-scsi-qlogicfcc-some-cleanups.patch
-scsi-qlogicispc-some-cleanups.patch
-hpet-setup-comment-fix.patch
-kill-iphase5526.patch
-i386-x86_64-acpi-sleepc-kill-unused-acpi_save_state_disk.patch
-smpbootc-cleanups.patch
-i386-kernel-i387c-misc-cleanups.patch
-mxserc-remove-unused-variable.patch
-update-panic-comment.patch
-pm3fb-remove-kernel-22-code.patch
-drivers-block-paride-cleanups.patch
-remove-obsolete-linux-resourceh-inclusion-from-asm-generic-siginfoh.patch
-fs-jffs-misc-cleanups.patch
-fs-jffs2-misc-cleanups.patch
-drivers-block-cciss-misc-cleanups.patch
-remove-unused-get_resource_list-declaration.patch
-typo-in-include-linux-compilerh.patch
-mark-blk_dev_ps2-as-broken.patch
-vsprintfc-cleanups.patch
-i386-scx200c-misc-cleanups.patch
-unexport-mmu_cr4_features.patch
-drivers-char-mxserc-cleanups.patch
-drivers-char-mwave-smapic-small-cleanups.patch
-drivers-char-specialixc-misc-cleanups.patch
-drivers-char-sysrqc-remove-the-unused-sysrq_power_off.patch
-small-partitions-msdos-cleanups.patch
-drivers-char-vt-cleanups.patch
-removes-unused-label-from-drivers-isdn-hisax-hisax_fcpcipnpc.patch
-procfs-fix-printk-arg-type-warning.patch
-isdn-fix-gcc-data-type-size-warning.patch
-w1-fix-printk-format-warning.patch
-zoran-fix-printk-format-types.patch
-hweight-typecast-return-types.patch
-i386-unexport-dmi_get_system_info.patch
-unexport-pcibios_penalize_isa_irq.patch
-list_for_each_entry-arch-i386-mm-pageattrc.patch
-gus_wavec-vfree-checking-cleanups.patch
-i386-traps-replace-schedule_timeout-with-ssleep.patch
-radio-sf16fmi-cleanup.patch
-unified-spinlock-initialization-include-linux-waith.patch
-scripts-mod-sumversionc-replace-strtok-with-strsep.patch
-char-snsc-reorder-set_current_state-and-add_wait_queue.patch
-char-hvsi-use-wait_event_timeout.patch
-char-sx-replace-schedule_timeout-with-msleep_interruptible.patch
-serial-crisv10-replace-schedule_timeout-with-msleep.patch
-ftape-fdc-io-insert-set_current_state-before-schedule_timeout.patch
-tc-zs-replace-schedule_timeout-with-msleep_interruptible.patch
-delete-unused-file-drivers_char_hp600_keybc.patch
-drivers-isdn-hardware-avm-convert-to-pci_register_driver.patch
-message-mptbase-replace-schedule_timeout-with-ssleep.patch
-drivers-message-fusion-convert-to-pci_register_driver.patch
-drivers-eisa-convert-to-pci_register_driver.patch
-char-lp-remove-interruptible_sleep_on_timeout-usage.patch
-char-istallion-replace-interruptible_sleep_on-with-wait_event_interruptible.patch
-list_for_each_entry-arch-um-drivers-chan_kernc.patch
-mips-fix-section-type-conflict-about-mpc30x.patch
-macintosh-mediabay-replace-schedule_timeout-with-msleep_interruptible.patch
-drivers-macintoshisdn-convert-to-pci_register_driver.patch
-unexport-flush_tlb_all.patch
-unexport-kmap_pteport-on-ppc.patch
-i386-power-cpuc-remove-three-unused-variables.patch

 Merged

+revert-vmalloc-use-list-of-pages-instead-of-array-in-vm_struct.patch

 Revert recent vmalloc cleanup: it breaks XFS.

+parport_pc-revert-netmos-patch.patch

 Fix parport_pc/parport_serial interaction

+uml-restore-proper-descriptions-in-make-deb-pkg-target.patch

 uml Debian packaging fix

-whitelist-entry-forcelun-for-sgs-thomson-microelectronics-cytronix-6in1-card-reader-in-scsi_devinfoc.patch

 Dropped on advice from the scsi guys.

+usb-support-for-new-ipod-mini-and-possibly-others.patch

 usb device support

+slab-64bit-fix.patch

 slab fixlet

+sparsemem-base-teach-discontig-about-sparse-ranges.patch
+sparsemem-base-simple-numa-remap-space-allocator.patch
+sparsemem-base-reorganize-page-flags-bit-operations.patch
+sparsemem-base-early_pfn_to_nid-works-before-sparse-is-initialized.patch

 Preparatory work for the "sparse memory" feature: mainly for discontiguous
 memory within NUMA nodes.

+vmscan-move-code-to-isolate-lru-pages-into-separate-function.patch

 vmscan code consolidation

+mm-counter-operations-through-macros.patch
+mm-counter-operations-through-macros-tidy.patch

 Some preparatory work for improving scalability of mm_struct counters

-b44-bounce-buffer-fix.patch
+b44-allocate-tx-bounce-bufs-as-needed.patch

 New version of this (I think)

+drivers-net-sis900c-fix-a-warning.patch
+fix-suspend-resume-on-via-velocity.patch
+pcnet32-bug-79c975-fiber-fix.patch
+we-18-aka-wpa.patch

 Net stuff

+ppc32-fix-powermac-cpufreq-for-newer-machines.patch
+ppc32-fix-overflow-in-cpuinfo-freq-display.patch
+ppc32-update-powermac-models-table.patch
+ppc32-add-virtual-dma-support-to-legacy-floppy-driver-on.patch
+ppc32-fix-a-warning-in-planb-video-driver.patch
+ppc32-delete-arch-ppc-syslib-ppc4xx_serialc.patch
+ppc32-lindent-include-asm-ppc-dmah.patch
+ppc32-better-comment-arch-ppc-syslib-cpc700h.patch
+ppc32-serial-fix-for-pal4.patch
+ppc32-fix-a-typo-on-8260.patch
+ppc32-update-8260_io-fcc_enetc-to-function-again.patch
+ppc32-patch-for-changed-dev-bus_id-format.patch
+ppc32-update-radstone-ppc7d-platform.patch
+ppc32-clean-up-mv64x60-bootwrapper-support.patch
+ppc32-fix-fec-ethernet-intialization-on-mpc8540-ads-board.patch
+ppc32-sparse-clean-ups-for-the-freescale-mpc52xx-related-code.patch
+ppc32-add-pci-bus-support-for-freescale-mpc52xx.patch

 ppc32 updates

+ppc64-rtasd-shouldnt-hold-cpucontrol-while-sleeping.patch
+ppc64-fix-kprobes-calling-smp_processor_id-when-preemptible.patch
+ppc64-kill-might_sleep-warnings-in-__copy__user_inatomic.patch
+ppc64-make-rtas-code-usable-on-non-pseries-machines.patch
+ppc64-delete-unused-file-no_initrdc.patch
+ppc64-delete-unused-file-iseries_fixuph.patch
+ppc64-iseries-cleanup-viopath.patch
+ppc64-iseries-cleanup-iseries_setup.patch

 ppc64 udpates

+via-irq-fixup-fix.patch
+via-irq-fixup-fix-warning-fix.patch

 Fiddle with VIA IRQ routing

+apm-fix-interrupts-enabled-in-device_power_up.patch
+rtc_lock-is-irq-safe.patch

 x86 locking fixes

+fix-put_user-for-80386.patch

 put_user() 386 workarounds

+es7000-legacy-mappings-update.patch

 es7000 fix

+x86-fix-esp-corruption-cpu-bug-take-2.patch

 Work around x86 bug when using 16-bit stack segments

+es7000-dmi-cleanup.patch

 x86 cleanup

+x86-x86_64-reading-deterministic-cache-parameters-and-exporting-it-in-sysfs.patch

 Improved reporting for Intel x86/x86_64 CPU info

+x86-x86_64-intel-dual-core-detection.patch

 Improved Intel x86/x86_64 CPU type detection

+x86-cacheline-alignment-for-cpu-maps.patch

 Align a few cpumasks.

+x86-64-kprobes-handle-%rip-relative-addressing-mode.patch

 kprobes fix

+swsusp-add-missing-refrigerator-calls.patch

 swsusp fixes

+uml-cope-with-uml_net-security-fix.patch

 uml_net fix

+areca-raid-linux-scsi-driver.patch

 Updated version of this driver.

+cfq-iosched-update-to-time-sliced-design-use-bio_data_dir.patch

 cfq3 fix

+use-__init-and-__exit-in-pktcdvd.patch

 Linker section fix

+dvd-ram-support-for-pktcdvd.patch

 Packet driver update

+break_lock-fix-2.patch

 Fix spinlock breaking code

+cdrom-cdu31a-cleanups.patch
+cdrom-cdu31a-locking-fixes.patch
+cdrom-cdu31a-use-wait_event.patch

 cdrom driver updates

+revert-gconfig-changes.patch

 Back out a recent change which broke gconfig.

+enable-gcc-warnings-for-vsprintf-vsnprintf-with-format-attribute.patch

 Additional printf-style arg checking

+w6692-eliminate-bad-section-references.patch
+teles3-eliminate-bad-section-references.patch
+elsa-eliminate-bad-section-references.patch
+hfc_sx-eliminate-bad-section-references.patch
+sedlbauer-eliminate-bad-section-references.patch

 Various linkage section fixes

+fix-mprotect-with-len=size_t-1-to-return-enomem.patch

 Make mprotect() more posixly correct

+checkstack-fix-sort-misbehavior-for-long-function-names.patch

 checkstack.pl fix

+fix-irq_affinity-write-from-proc-for-ia64.patch

 ia64 IRQ affinity writing fix

+fix-mmap-return-value-to-conform-posix.patch

 Make mmap() more posixly correct

+exports-to-enable-clock-driver-modules.patch

 Allow mmtimer to be a module

+per-cpu-irq-stat.patch

 per-cpuify the x86 irq_stat structures

+kill-drivers-cdrom-mcdc.patch

 Remove a cdrom driver

+drivers-char-isicomc-gcc4-fix.patch
+drivers-net-arcnet-arcnetc-gcc4-fixes.patch
+drivers-net-depcac-gcc4-fix.patch

 gcc-4.0 fixes

+infiniband-remove-unsafe-use-of-in_atomic.patch

 in_atomic() doesn't do what you think it does.

+new-console-flag-con_boot.patch
+new-console-flag-con_boot-comment.patch

 Permit early console drivers to be auto-ejected when the real ones are
 registered.

+pipe-save-one-pipe-page.patch

 Use less memory in the pipe code.

+kprobes-incorrect-spin_unlock_irqrestore-call-in-register_kprobe.patch

 kprobes locking fix

+ext3-writeback-nobh-option.patch

 Add a `no buffer-head' option to ext3's data pages in witeback mode.

+add-gfp_mask-to-page-owner.patch

 Enhance the reporting in the page memory leak detector patch.

+slab-leak-detector.patch
+slab-leak-detector-warning-fixes.patch

 Re-add Manfred's slab leak detector.

+figure-out-who-is-inserting-bogus-modules-warning-fix.patch

 Fix a warning in figure-out-who-is-inserting-bogus-modules.patch

+releasing-resources-with-children.patch

 Debug check

+perfctr-api-update-1-9-physical-indexing-x86.patch
+perfctr-api-update-2-9-physical-indexing-ppc32.patch
+perfctr-api-update-3-9-cpu_control_header-x86.patch
+perfctr-api-update-4-9-cpu_control_header-ppc32.patch
+perfctr-api-update-5-9-cpu_control_header-common.patch
+perfctr-api-update-6-9-cpu_control-access-common.patch
+perfctr-api-update-7-9-cpu_control-access-x86.patch
+perfctr-api-update-8-9-cpu_control-access-ppc32.patch
+perfctr-api-update-9-9-domain-based-read-write-syscalls.patch
+perfctr-ia32-syscalls-on-x86-64-fix.patch

 perfctr API update and a fix

+reiser4-update.patch

 reiser4fs update

+fbcon-stop-framebuffer-operations-before-hardware-is-properly-initialized.patch
+nvidiafb-maximize-blit-buffer-capacity.patch
+pm2fb-x-and-vt-switching-crash-fix.patch
+nvidiafb-kconfig-help-text-update-for-config-fb_nvidia.patch
+fbdev-cleanups-in-drivers-video-part-2.patch
+excessive-atyfb-debug-messages.patch
+atyfb-add-boot-module-option-to-override-composite-sync.patch
+fbdev-kconfig-fix-for-macmodes-and-ppc.patch
+fbdev-convert-drivers-to-pci_register_driver.patch
+sisfb-trivial-cleanups.patch
+tridentfb-clean-up-printks.patch
+sisusb-fix-arg-types.patch
+s1d13xxxfb-add-support-for-epson-s1d13806-fb.patch
+matroxfb-compile-error.patch

 fbdev driver updates

+drivers-isdn-divert-isdn_divertc-make-5-functions-static.patch
+drivers-isdn-capi-make-some-code-static.patch

 Make a few things static

+drivers-media-video-tvaudioc-make-some-variables-static.patch
+drivers-isdn-sc-possible-cleanups.patch
+drivers-isdn-pcbit-possible-cleanups.patch
+drivers-isdn-i4l-possible-cleanups.patch
+unexport-mca_find_device_by_slot.patch
+drivers-isdn-hardware-avm-misc-cleanups.patch
+drivers-isdn-act2000-capic-if-0-an-unused-function.patch
+pwc-fix-printk-arg-types.patch
+tpm-fix-gcc-printk-warnings.patch
+x86-64-add-memcpy-memset-prototypes.patch
+au1100fb-convert-to-c99-inits.patch
+reiserfs-use-null-instead-of-0.patch
+comments-on-locking-of-task-comm.patch

 Little code tweaks.




number of patches in -mm: 501
number of changesets in external trees: 378
number of patches in -mm only: 481
total patches: 859




All 501 patches:


linus.patch

revert-vmalloc-use-list-of-pages-instead-of-array-in-vm_struct.patch
  revert vmalloc-use-list-of-pages-instead-of-array-in-vm_struct

tty-overrun-time-fix.patch
  tty overrun time fix

parport_pc-revert-netmos-patch.patch
  parport_pc: partially revert netmos patch

ia64-msi-warning-fixes.patch
  ia64 msi warning fixes

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

bk-acpi.patch

bk-acpi-acpi_pci_irq_disable-build-fix.patch
  bk-acpi-acpi_pci_irq_disable build fix

acpi-toshiba-failure-handling.patch
  acpi: Toshiba failure handling

acpi-video-pointer-size-fix.patch
  acpi video pointer size fix

acpi-poweroff-fix.patch
  ACPI poweroff fix

acpi-poweroff-fix-fix.patch
  acpi-poweroff-fix fix

agp-make-some-code-static.patch
  AGP: make some code static

include-linux-soundcardh-endianness-fix.patch
  include/linux/soundcard.h: endianness fix

bk-arm.patch

bk-audit.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-drm.patch

bk-drm-via.patch

bk-i2c.patch

bk-ia64.patch

ide-hdiotxt-update.patch
  ide: hdio.txt update

ide-serverworks-fix-section-references.patch
  ide/serverworks: fix section references

bk-ieee1394.patch

bk-input.patch

bk-kbuild.patch

uml-make-deb-pkg-build-target-build-a-debian-style-user-mode-linux-package.patch
  uml: make deb-pkg build target build a Debian-style user-mode-linux package

uml-restore-proper-descriptions-in-make-deb-pkg-target.patch
  UML - Restore proper descriptions in make deb-pkg target

bk-netdev.patch

bk-ntfs.patch

arch-i386-pci-i386c-use-new-for_each_pci_dev-macro.patch
  arch/i386/pci/i386.c: Use new for_each_pci_dev macro

pci-be-more-verbose-in-gen-devlist.patch
  pci: be more verbose in gen-devlist

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

add-scsi-changer-driver.patch
  add scsi changer driver

scsi-ch-build-fix.patch
  scsi ch.c build fix

bk-usb.patch

zd1201-build-fix.patch
  zd1201 build fix

usb-hcd-u64-warning-fix.patch
  usb hcd u64 warning fix

usb-support-for-new-ipod-mini-and-possibly-others.patch
  usb: support for new ipod mini (and possibly others)

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

sparsemem-base-teach-discontig-about-sparse-ranges.patch
  sparsemem base: teach discontig about sparse ranges

sparsemem-base-simple-numa-remap-space-allocator.patch
  sparsemem base: simple NUMA remap space allocator

sparsemem-base-reorganize-page-flags-bit-operations.patch
  sparsemem base: reorganize page->flags bit operations

sparsemem-base-early_pfn_to_nid-works-before-sparse-is-initialized.patch
  sparsemem base: early_pfn_to_nid() (works before sparse is initialized)

vmscan-move-code-to-isolate-lru-pages-into-separate-function.patch
  vmscan: move code to isolate LRU pages into separate function

mm-counter-operations-through-macros.patch
  mm counter operations through macros

mm-counter-operations-through-macros-tidy.patch
  mm-counter-operations-through-macros-tidt

b44-allocate-tx-bounce-bufs-as-needed.patch
  b44: allocate tx bounce bufs as needed

eni155p-error-handling-fix.patch
  ENI155P error handling fix

drivers-net-myri_codeh-cleanup.patch
  drivers/net/myri_code.h cleanup

e100-napi-fixes.patch
  e100: NAPI fixes

remove-last_rx-update-from-loopback-device.patch
  remove last_rx update from loopback device

fix-pci_disable_device-in-8139too.patch
  fix pci_disable_device in 8139too

log-full-of-ing_filter-fixed-ippp2-out-ippp2.patch
  Log full of "ing_filter:  fixed  ippp2 out ippp2"

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

ppc32-fix-powermac-cpufreq-for-newer-machines.patch
  ppc32: Fix PowerMac cpufreq for newer machines

ppc32-fix-overflow-in-cpuinfo-freq-display.patch
  ppc32: Fix overflow in cpuinfo freq. display

ppc32-update-powermac-models-table.patch
  ppc32: Update PowerMac models table

ppc32-add-virtual-dma-support-to-legacy-floppy-driver-on.patch
  ppc32: Add virtual DMA support to legacy floppy driver

ppc32-fix-a-warning-in-planb-video-driver.patch
  ppc32: Fix a warning in planb video driver

ppc32-delete-arch-ppc-syslib-ppc4xx_serialc.patch
  ppc32: Delete arch/ppc/syslib/ppc4xx_serial.c

ppc32-lindent-include-asm-ppc-dmah.patch
  ppc32: Lindent include/asm-ppc/dma.h

ppc32-better-comment-arch-ppc-syslib-cpc700h.patch
  ppc32: Better comment arch/ppc/syslib/cpc700.h

ppc32-serial-fix-for-pal4.patch
  ppc32: Serial fix for PAL4

ppc32-fix-a-typo-on-8260.patch
  ppc32: Fix a typo on 8260

ppc32-update-8260_io-fcc_enetc-to-function-again.patch
  ppc32: Update 8260_io/fcc_enet.c to function again

ppc32-patch-for-changed-dev-bus_id-format.patch
  ppc32: Patch for changed dev->bus_id format

ppc32-update-radstone-ppc7d-platform.patch
  ppc32: update Radstone ppc7d platform

ppc32-clean-up-mv64x60-bootwrapper-support.patch
  ppc32: Clean up mv64x60 bootwrapper support

ppc32-fix-fec-ethernet-intialization-on-mpc8540-ads-board.patch
  ppc32: Fix FEC ethernet intialization on MPC8540 ADS board

ppc32-sparse-clean-ups-for-the-freescale-mpc52xx-related-code.patch
  ppc32: sparse clean ups for the Freescale MPC52xx related code

ppc32-add-pci-bus-support-for-freescale-mpc52xx.patch
  ppc32: Add PCI bus support for Freescale MPC52xx

ppc64-rtasd-shouldnt-hold-cpucontrol-while-sleeping.patch
  ppc64: rtasd shouldn't hold cpucontrol while sleeping

ppc64-fix-kprobes-calling-smp_processor_id-when-preemptible.patch
  ppc64: fix kprobes calling smp_processor_id when preemptible

ppc64-kill-might_sleep-warnings-in-__copy__user_inatomic.patch
  ppc64: kill might_sleep() warnings in __copy_*_user_inatomic

ppc64-make-rtas-code-usable-on-non-pseries-machines.patch
  ppc64: make RTAS code usable on non-pSeries machines

ppc64-delete-unused-file-no_initrdc.patch
  ppc64: delete unused file no_initrd.c

ppc64-delete-unused-file-iseries_fixuph.patch
  ppc64: delete unused file iSeries_fixup.h

ppc64-iseries-cleanup-viopath.patch
  ppc64 iSeries: cleanup viopath

ppc64-iseries-cleanup-iseries_setup.patch
  ppc64 iSeries: cleanup iSeries_setup

x86-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  x86: reduce cacheline bouncing in cpu_idle_wait

x86-cmos-time-update-optimisation.patch
  x86: CMOS time update optimisation

x86-cmos-time-update-optimisation-tidy.patch
  x86-cmos-time-update-optimisation-tidy

x86-cmos-time-update-optimisation-locking-fix.patch
  x86-cmos-time-update-optimisation locking fix

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

uml-cope-with-uml_net-security-fix.patch
  uml: cope with uml_net security fix

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch
  Sort out PCI_ROM_ADDRESS_ENABLE vs IORESOURCE_ROM_ENABLE

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

rt-lsm.patch
  RT-LSM

tty-output-lossage-fix.patch
  tty output lossage fix

blockdev-fixes-race-between-mount-umount.patch
  blockdev: fixes race between mount/umount

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

inotify.patch
  inotify

inotify-fix.patch
  inotify-fix

ext3-jbd-race-releasing-in-use-journal_heads.patch
  ext3/jbd race: releasing in-use journal_heads

ext3-writepages-support-for-writeback-mode.patch
  ext3 writepages support for writeback mode

ext3-writeback-nobh-option.patch
  ext3 writeback "nobh" option

pcmcia-dont-send-eject-request-events-to-userspace.patch
  pcmcia: don't send eject request events to userspace

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

sched-improve-pinned-task-handling.patch
  sched: improve pinned task handling

sched-improve-pinned-task-handling-fix.patch
  sched-improve-pinned-task-handling fix

sched-no-aggressive-idle-balancing.patch
  sched: no aggressive idle balancing

sched-better-active-balancing-heuristic.patch
  sched: better active balancing heuristic

sched-generalised-cpu-load-averaging.patch
  sched: generalised CPU load averaging

sched-less-affine-wakups.patch
  sched: less affine wakups

sched-remove-aggressive-idle-balancing.patch
  sched: remove aggressive idle balancing

sched-sched-domains-aware-balance-on-fork.patch
  sched: sched-domains aware balance-on-fork

sched-schedstats-additions-for-sched-balance-fork.patch
  sched: schedstats additions for sched-balance-fork

sched-basic-tuning.patch
  sched: basic tuning

random-ia64-sched-domains-values.patch
  random ia64 sched-domains values

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

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

sealevel-8-port-rs-232-rs-422-rs-485-board.patch
  sealevel 8 port RS-232/RS-422/RS-485 board

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

sisusb-fix-arg-types.patch
  sisusb: fix arg types

s1d13xxxfb-add-support-for-epson-s1d13806-fb.patch
  s1d13xxxfb: Add support for Epson S1D13806 FB

matroxfb-compile-error.patch
  matroxfb compile error

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

fix-u32-vs-pm_message_t-in-usb-fix.patch
  fix-u32-vs-pm_message_t-in-usb fix

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

pwc-fix-printk-arg-types.patch
  pwc: fix printk arg types

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



