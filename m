Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbVHSLe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbVHSLe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 07:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVHSLe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 07:34:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25547 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932592AbVHSLe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 07:34:56 -0400
Date: Fri, 19 Aug 2005 04:33:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6-mm1
Message-Id: <20050819043331.7bc1f9a9.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/

- Lots of fixes, updates and cleanups all over the place.

- If you have the right debugging options set, this kernel will generate
  a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
  It is being worked on.


Changes since 2.6.13-rc5-mm1:

 linus.patch
 git-acpi.patch
 git-acpi-ia64-fixes.patch
 git-alsa.patch
 git-cpufreq.patch
 git-cryptodev.patch
 git-drm.patch
 git-ia64.patch
 git-audit.patch
 git-input.patch
 git-kbuild.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-ocfs2.patch
 git-serial.patch
 git-scsi-block.patch
 git-scsi-iscsi.patch
 git-scsi-iscsi-vs-git-net.patch
 git-net-vs-iscsi-fix.patch
 git-scsi-misc.patch
 git-watchdog.patch

 Subsystem trees

-x86_64-ignore-machine-checks-from-boot-time.patch
-__bio_clone-dead-comment.patch
-make-visws-compile-again.patch
-visws-linkage-fix.patch
-remove-linux-pagemaph-from-linux-swaph.patch
-namespacec-fix-bind-mount-from-foreign-namespace.patch
-8xx-convert-fec-driver-to-use-work_struct.patch
-8xx-using-dma_alloc_coherent-instead-consistent_alloc.patch
-8xx-fec-fix-interrupt-handler-prototypes.patch
-ppc32-8xx-fix-cpm-ethernet-description.patch
-ppc32-8xx-restrict-enet_big_buffers-option.patch
-ppc32-8xx-kill-unused-variable-in-commproc.patch
-ppc32-8xx-commproc-avoid-direct-pte-manipulation-use-dma-coherent-api-instead.patch
-move-the-fix-to-align-node_end_pfns-to-a-proper-location.patch
-crc32c-typo-fix.patch
-acpi-videoc-properly-remove-notify-handlers.patch
-ns558-list-handling-fix.patch
-git-net-ddcp-fixes.patch
-git-net-svcsock-build-fix.patch
-time-conversion-error-in-net-sunrpc-svcsockc.patch
-aic79xx-needs-scsi_transport_spi.patch
-i6300esb-pci_match_device-fix.patch
-s2io-fix-a-compiler-warning-in-a-printk.patch
-s390-use-klist-in-qeth-driver.patch
-new-driver-for-yealink-usb-p1k-phone.patch
-new-driver-for-yealink-usb-p1k-phone-endianness-fix.patch
-kconfig-trivial-cleanup.patch
-xdr-input-validation.patch
-nfs-split-nfsi-flags-into-two-fields.patch
-nfs-use-atomic-bitops-to-manipulate-flags-in-nfsi-flags.patch
-nfs-introduce-the-use-of-inode-i_lock-to-protect-fields-in-nfsi.patch
-fbdev-dont-allow-softcursor-use-from-userland.patch
-fbdev-mach64-atari-patch.patch
-fbsysfs-remove-casts-from-void.patch
-drivers-char-ip2-i2libc-replace-direct-assignment-with-set_current_state.patch
-ide-add-support-for-netcell-revolution-to-pci-ide-generic-driver.patch

 Merged

+tpm_infineon-bugfix-in-pnpacpi-handling.patch

 TPM driver fix

+mobil-pentium-4-ht-and-the-nmi.patch

 Mobile P4 NMI fix

+move-truncate_inode_pages-into-delete_inode.patch
+update-filesystems-for-new-delete_inode-behavior.patch

 Broken out of the OCFS2 patch

+git-acpi-ia64-fixes.patch

 Fix ACPI-vs-ia64

+gregkh-driver-driver-docs-whitespace.patch
+gregkh-driver-driver-docs-permissions.patch
+gregkh-driver-driver-handle-sysdev-suspend-failure.patch
+gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch

 Additions to Greg's driver tree

+seclvl-use-securityfs.patch
+seclvl-use-securityfs-tidy.patch
+seclvl-use-securityfs-fix.patch

 Convert seclvl to use securityfs

+gregkh-i2c-i2c-inline-i2c_adapter_id.patch
+gregkh-i2c-i2c-i2c-algo-pca-busy-bus-fix.patch
+gregkh-i2c-i2c-documentation-typo.patch
+gregkh-i2c-i2c-core-debug-cleanup.patch
+gregkh-i2c-hwmon-move-SENSORS_LIMIT.patch
+gregkh-i2c-hwmon-lm85-cleanups.patch
+gregkh-i2c-hwmon-split-round2-01.patch
+gregkh-i2c-hwmon-split-round2-02.patch
+gregkh-i2c-hwmon-split-round2-03.patch
+gregkh-i2c-hwmon-split-round2-04.patch
+gregkh-i2c-hwmon-split-round2-05.patch
+gregkh-i2c-hwmon-split-round2-06.patch
+gregkh-i2c-hwmon-split-round2-07.patch
+gregkh-i2c-hwmon-split-round2-08.patch
+gregkh-i2c-hwmon-split-round2-09.patch
+gregkh-i2c-hwmon-split-round2-10.patch
+gregkh-i2c-hwmon-split-round2-11.patch
+gregkh-i2c-hwmon-vid-table-update.patch
+gregkh-i2c-i2c-rewrite-i2c_probe.patch
+gregkh-i2c-i2c-centralize-24rf08-corruption-prevention.patch
+gregkh-i2c-i2c-kill-i2c_algorithm-stuff-01.patch
+gregkh-i2c-i2c-kill-i2c_algorithm-stuff-02.patch
+gregkh-i2c-i2c-kill-i2c_algorithm-stuff-03.patch
+gregkh-i2c-i2c-kill-i2c_algorithm-stuff-04.patch
+gregkh-i2c-i2c-kill-i2c_algorithm-stuff-05.patch
+gregkh-i2c-i2c-kill-i2c_algorithm-stuff-06.patch
+gregkh-i2c-i2c-kill-i2c_algorithm-stuff-07.patch
+gregkh-i2c-i2c-outdated-i2c_adapter-comment.patch
+gregkh-i2c-hwmon-maintainer.patch
+gregkh-i2c-i2c-drop-i2c_clientname.patch
+gregkh-i2c-w1-changed_default_netlink_group.patch
+gregkh-i2c-w1-fs9490-sync.patch
+gregkh-i2c-w1-01-hotplug.patch
+gregkh-i2c-w1-02-64bit.patch
+gregkh-i2c-w1-03.patch
+gregkh-i2c-w1-04.patch
+gregkh-i2c-w1-05.patch
+gregkh-i2c-w1-06.patch
+gregkh-i2c-w1-07.patch
+gregkh-i2c-w1-08.patch
+gregkh-i2c-w1-09.patch

 i2c tree

+kbuild-fix-make-clean-damaging-hg-repos.patch

 kbuild fix for Mercurial

-git-libata-adma-mwi.patch
-git-libata-chs-support.patch
-git-libata-passthru.patch
-git-libata-promise-sata-pata.patch
+git-libata-all.patch

 Jeff has a consolidated libata tree now

-git-netdev-chelsio.patch
-git-netdev-e100.patch
-git-netdev-sis190.patch
-git-netdev-smc91x-eeprom.patch
-git-netdev-ieee80211-wifi.patch
-git-netdev-upstream.patch
+git-netdev-all.patch

 And a consolidated netdev tree

+git-net-fixups.patch

 Fix git-net.patch rejects

+sis190-must-select-mii.patch

 sis190 Kconfig fix

+gregkh-pci-pci-io_remap_pfn_range.patch
+gregkh-pci-pci-hotplug-use-bus_slot-number-for-name.patch
+gregkh-pci-pci-restore-bar-values.patch
+gregkh-pci-pci-make-sparc64-use-setup-res.patch
+gregkh-pci-pci-cleanup-return-values.patch
+gregkh-pci-pci-cleanup-return-values-fix.patch
+gregkh-pci-pci-remove-pci_find_device-from-parport_pc.patch
+gregkh-pci-pci-sgi-hotplug-fixes.patch
+gregkh-pci-pci-pci_intx.patch
+gregkh-pci-pci-must_check-attributes.patch

 PCI tre updates

+pci-pm-support-pm-cap-version-3.patch

 PCI power management fix

+git-net-vs-iscsi-fix.patch

 Fix iscsi for git-net changes

-gregkh-usb-usb-storage-rearrange-stuff.patch
-gregkh-usb-usb-storage-fix-something.patch
+gregkh-usb-usb-keyspan_remote-endian-fix.patch
+gregkh-usb-usb-pl2303hx-fix.patch
+gregkh-usb-usb-ftdi_sio-userspecified-vid.patch
+gregkh-usb-usb-ftdi_sio-new-ids.patch
+gregkh-usb-usb-hid-blacklist-apple-bluetooth.patch
+gregkh-usb-usb-real-nodes-instead-of-usbfs.patch
+gregkh-usb-usb-real-nodes-instead-of-usbfs-fix.patch
+gregkh-usb-usb-storage-unusual-devs-mitsumi.patch
+gregkh-usb-usb-ub-01.patch
+gregkh-usb-usb-ub-02.patch
+gregkh-usb-usb-ub-03.patch
+gregkh-usb-usb-ub-04.patch
+gregkh-usb-usb-usblp-rate-limit-error-messages.patch
+gregkh-usb-usb-usbnet-gfp_flags-fix.patch
+gregkh-usb-usb-isp116x-hcd-01.patch
+gregkh-usb-usb-isp116x-hcd-02.patch
+gregkh-usb-usb-isp116x-hcd-03.patch
+gregkh-usb-usb-isp116x-hcd-04.patch
+gregkh-usb-usb-isp116x-hcd-05.patch
+gregkh-usb-usb-isp116x-hcd-06.patch
+gregkh-usb-usb-storage-01.patch
+gregkh-usb-usb-storage-02.patch
+gregkh-usb-usb-storage-03.patch
+gregkh-usb-usb-storage-04.patch
+gregkh-usb-usb-storage-05.patch
+gregkh-usb-usb-remove-URB_ASYNC_UNLINK.patch
+gregkh-usb-usb-serial-async-fixup.patch
+gregkh-usb-usb-fix-hp8200.patch
+gregkh-usb-usb-hub-code-motion.patch
+gregkh-usb-usb-hub-disconnect-children.patch
+gregkh-usb-usb-s3c24xx-port-numbering-fix.patch
+gregkh-usb-usb-ohci-ppc-soc-fix.patch
+gregkh-usb-usb-usb_lock_device_for_reset-timeout.patch
+gregkh-usb-usb-unbind-usb_generic-driver.patch
+gregkh-usb-usb-tweak-highspeed-calculations.patch
+gregkh-usb-usb-remove-annoying-message.patch
+gregkh-usb-usb-ohci-ppc-soc-include.patch
+gregkh-usb-usb-schedule-oss-usb-drivers-removal.patch
+gregkh-usb-usb-ldusb-64-bit-warnings.patch
+gregkh-usb-usb-usbnet-01.patch
+gregkh-usb-usb-usbnet-02.patch
+gregkh-usb-usb-usbnet-03.patch
+gregkh-usb-usb-usbnet-04.patch
+gregkh-usb-usb-usbnet-05.patch
+gregkh-usb-usb-usbnet-06.patch
+gregkh-usb-usb-usbnet-07.patch
+gregkh-usb-usb-usbnet-08.patch
+gregkh-usb-usb-usbnet-09.patch
+gregkh-usb-usb-ehci-01.patch
+gregkh-usb-usb-ehci-02.patch
+gregkh-usb-usb-usbmon-dma-areas.patch
+gregkh-usb-usb-yealink.patch

 USB tree updates

-make-usb-handoff-the-default-usb-no-handoff-turns-it-off.patch

 This broke

+git-watchdog.patch
-bk-watchdog.patch

 Wim has a git tree for the watchdog drivers

+use-mm_counter-macros-for-nr_pte-since-its-also-under-ptl.patch

 mm accounting atomicity fix

 sparsemem-extreme.patch
+sparsemem-extreme-implementation.patch
+sparsemem-extreme-hotplug-preparation.patch

 Updates to sparsemem-extreme

+comment-typo-fix.patch
+vm-slabc-spelling-correction.patch
+shmem_populate-avoid-an-useless-check-and-some-comments.patch
+add-swap-cache-mapping-comment.patch
+remove-implied-vm_ops-check.patch
+remove-stale-comment-from-swapfilec.patch
+correct-_page_file-comment.patch

 MM fixlets

-page-fault-patches-introduce-pte_xchg-and-pte_cmpxchg-fix.patch

 Folded into page-fault-patches-introduce-pte_xchg-and-pte_cmpxchg.patch

-page-fault-patches-optional-page_lock-acquisition-in-tidy.patch
-page-fault-patches-optional-page_lock-acquisition-in-fix.patch
-page-fault-patches-optional-page_lock-acquisition-in-fix-2.patch

 Folded into page-fault-patches-optional-page_lock-acquisition-in.patch

+page-fault-patches-optional-page_lock-acquisition-in-vs-use-mm_counter-macros-for-nr_pte-since-its-also-under-ptl.patch

 Fix it for an earlier patch

-page-fault-patches-fix-highpte-in-do_anon_page.patch

 Folded into page-fault-patches-no-pagetable-lock-in-do_anon_page.patch

+x86_64-ptep-clear-optimization.patch

 mm speedup

+vm-add-page_state-info-to-per-node-meminfo.patch

 Add page_state info to the per-node meminfo file in sysfs.

+ppp_mppe-add-ppp-mppe-encryption-module-update.patch

 Fix ppp_mppe-add-ppp-mppe-encryption-module.patch

-ppp-handle-misaligned-accesses.patch
+ppp-handle-misaligned-accesses-2.patch

 Updated version

-tulip-fixes-for-uli5261.patch

 Dropped - not needed now.

+remove-warning-about-e1000_suspend.patch
+net-update-the-spider_net-driver.patch

 net driver updates

+selinux-reduce-memory-use-by-avtab.patch

 SELinux memory usage reduction

+selinux-endian-notations.patch

 SELinux endianness notations

+ppc32-add-usb-support-to-ibm-stb04xxx-platforms.patch
+ppc32-added-support-for-the-book-e-style-watchdog-timer.patch
+ppc32-add-ppc_sys-descriptions-for-powerquicc-ii-devices.patch
+ppc32-add-phy-excluded-features-to-ocp_func_emac_data.patch
+cpm_uart-fix-2nd-serial-port-on-mpc8560-ads.patch
+ppc32-cleaned-up-global-namespace-of-book-e-watchdog.patch
+ppc32-add-440gx-revf-cputable-entry.patch
+ppc32-removed-find_namec.patch
+ppc32-add-cputable-entry-for-440sp-rev-a.patch
+ppc32-dont-sleep-in-flush_dcache_icache_page.patch

 ppc32 updates

+ppc64-large-initrd-causes-kernel-not-to-boot.patch
+ppc64-replace-schedule_timeout-with-msleep_interruptible.patch

 ppc64 updates

+mips-remove-vr4181-support-fix.patch
+more-vr4181-removal.patch
+mips-add-support-for-qemu-system-architecture.patch
+mips-technologies-pci-id-bits.patch
+mips-add-tanbac-vr4131-multichip-module.patch
+mips-add-default-select-configs-for-vr41xx.patch
+mips-remove-vrc4171-config.patch
+mips-changed-from-vr41xx-to-vr4100-series-in-kconfig.patch
+mips-cleanup-32-64-bit-configuration.patch
+mips-nuke-trailing-whitespace.patch
+mips-fix-coherency-configuration.patch

 MIPS things

+arch-sh64-kconfig-doesnt-need-its-own-log_buf_shift.patch

 superh cleanup

+x86-add-the-check-for-all-the-cores-in-a-package-in-cache-information.patch
+via-vt8237-apic-bypass-deassertion-quirk.patch

 x86 updates

+i386--make-write-ldt-return-error-code.patch
+i386--remove-ugly-tls-code.patch
+i386--remove-unnecessary-tls-init.patch
+i386--clean-up-asm-and-volatile-keywords-in-desc.patch
+i386--use-early-clobber-to-eliminate-rotate-in-desc.patch
+i386--add-some-segment-convenience-functions.patch
+i386--add-some-descriptor-convenience-functions.patch
+i386--add-a-per-cpu-gdt-accessor.patch
+i386--typecheck-and-optimize-base-and-limit-accessors.patch
+i386--typecheck-and-optimize-base-and-limit-accessors-fix.patch
+i386--typecheck-and-optimize-base-and-limit-accessors-fix-tidy.patch
+i386--move-descriptor-accessors-into-desc-h.patch
+i386--eliminate-yet-another-redundant-accessor.patch
+i386--move-context-switch-inline.patch
+i386--introduce-hypervisor-ldt-hooks.patch
+i386--introduce-hypervisor-lazy-pinning-hooks.patch
+i386-virtualization-fix-uml-build.patch
+i386-virtualization-remove-some-dead-debugging-code.patch
+i386-virtualization-make-ldt-a-desc-struct.patch
+i386-virtualization-ldt-kprobes-bugfix.patch
+i386-virtualization-make-generic-set-wrprotect-a-macro.patch
+i386-virtualization-attempt-to-clean-up-pgtable-code-motion.patch
+i386-fix-desc-empty.patch

 A bunch more x86 cleanups and abstractions for virtualisation

+i386-boottime-for_each_cpu-broken.patch
+i386-boottime-for_each_cpu-broken-fix.patch

 Fix x86 early for_each_cpu() usage.

+reconfigure-msi-registers-after-resume.patch

 x86 PM fix

+arch-cris-kconfigdebug-use-lib-kconfigdebug.patch

 cris cleanup

+uml-fixes-performance-regression-in-activate_mm-and-thus-exec.patch
+uml-fault-handler-micro-cleanups.patch
+uml-fix-signal-frame-copy_user.patch
+uml-fix-a-macro-typo.patch

 UML updates

+dell_rbu-new-dell-bios-update-driver-fix.patch

 Fix dell_rbu-new-dell-bios-update-driver.patch

+parport-add-netmos-9805-support.patch

 parport device support

+fs-kconfig-quota-help-text-updates.patch

 Kconfig fixes

+jffs-jffs2-remove-wrong-function-prototypes.patch

 cleanup

+i386-buildc-write-out-larger-system-size-to-bootsector.patch

 Handle huge kernel images

+incorrect-permissions-on-parport-sysctls.patch

 parport permission fix

+check_irq_per_cpu-to-avoid-dead-code-in-__do_irq.patch

 cleanup

+fix-handling-in-parport_pc-init-code.patch

 parport fix

+fix-function-macro-name-collision-on-i386-oprofile.patch

 function naming fix

+remove-asm-hdregh.patch

 cleanup

+3c59x-read-current-link-status-from-phy.patch

 Might fix some 3com problems

+delete-unused-do_nanosleep-declaration.patch
+clean-up-missing-overflow-check-in-get_blkdev_list.patch

 cleanups

+console-blanking-locking-fix.patch

 console locking fix

+do_notify_parent_cldstop-cleanup.patch

 cleanup

+dmi-remove-uneeded-function.patch
+dmi-remove-old-debugging-code.patch
+dmi-make-dmi_string-behave-like-strdup.patch
+dmi-add-onboard-devices-discovery.patch
+ipmi-use-dmi_find_device.patch

 DMI updates

+driver-for-ibm-automatic-server-restart-watchdog.patch
+driver-for-ibm-automatic-server-restart-watchdog-fix.patch

 New watchdog driver

+introduce-and-use-kzalloc-make-kcalloc-a-static-inline.patch

 Make introduce-and-use-kzalloc.patch better

+ipmi-fix-panic-ipmb-response.patch

 IPMI fix

+sd-read-only-switch-coding-style-fix.patch
+sd-read-only-switch-mmc-sd-init-order-fix.patch
+sd-read-only-switch-mmc-sd-ro-style-fix.patch
+sd-scr-register-mmc-sd-scr-style-fixpatch.patch
+mmc-wbsd-secure-digital-support.patch
+mmc-multi-sector-writes.patch

 Updates to Secure Digital drivers

+corgi-touchscreen-fix-a-pmu-bug.patch
-w100fb-update-corgi-platform-code-to-match-new-driver.patch
+w100fb-rewrite-for-platform-independence-fix.patch
+w100fb-update-corgi-platform-code-to-match-new.patch

 Various Corgi updates

-pivot_root-circular-reference-fix-2.patch
+pivot_root-circular-reference-fix-3.patch

 New version

+dlm-build-fix.patch
+configfs-export-config_group_find_obj.patch
+dlm-use-configfs.patch
+dlm-use-configfs-fix.patch
+dlm-remove-file.patch
+dlm-use-jhash.patch
+dlm-maintainer.patch

 DLM updates

+indycam--vino-drivers.patch
+dvb-clarify-description-text-for-dvb-bt8xx-in-kconfig.patch
+dvb-lgdt330x-check-callback-fix.patch

 DVB updates

+pcmcia-cs-fix-possible-missed-wakeup.patch
+fix-pcmcia_request_irq-for-multifunction-card.patch
+pcmcia-yenta-avoid-pci-write-posting-problem.patch

 PCMCIA updates

+spinlock-consolidation-ia64-fix.patch

 Fix spinlock-consolidation.patch

-slab-leak-detector-give-longer-traces.patch

 Was buggy

-scheduler-cache-hot-autodetect.patch

 Mabe Martin's machine crash

+sched-correct_smp_nice_bias-fix.patch

 Fix sched-correct_smp_nice_bias.patch

+sched-dont-kick-alb-in-the-presence-of-pinned-task-fix.patch
+sched-allow-the-load-to-grow-upto-its-cpu_power.patch

 CPU scheduler updates

+files-fix-rcu-initializers.patch
+files-rcuref-apis.patch
+files-break-up-files-struct.patch
+files-sparc64-fix-2.patch
+files-files-struct-with-rcu.patch
+files-lock-free-fd-look-up.patch
+files-files-locking-doc.patch

 Bring these back - the reported failure was weird and may not have been real.

+fs-asfs-make-code-static.patch

 Clean up asfs-filesystem-driver.patch

+8250-serial-console-locking-bug-spelling-fix.patch

 Fix speling mistake

+fbdev-prevent-drivers-that-have-hardware-cursors-from-calling-software-cursor-code.patch
+fbdev-geode-updates.patch

 fbdev updates

+md-dont-allow-new-md-bitmap-file-to-be-set-if-one-already-exists.patch
+md-improve-handling-of-bitmap-initialisation.patch
+md-all-hot-add-and-hot-remove-of-md-intent-logging-bitmaps.patch
+md-support-write-mostly-device-in-raid1.patch
+md-add-write-behind-support-for-md-raid1.patch

 RAID updates

+isa-dma-api-documentation.patch

 Document the ISA DMA API

+janitor-ide-min-max-macros-in-ide-timingh.patch
+janitor-net-ppp-generic-list_for_each_entry.patch
+janitor-jffs-intrep-list_for_each_entry.patch
+janitor-fs-namespacec-list_for_each_entry.patch
+janitor-fs-dcachec-list_for_each.patch
+janitor-ide-tape-replace-schedule_timeout-with-msleep.patch
+janitor-block-umem-replace-printk-with-pr_debug.patch
+janitor-tulip-de4x5-list_for_each.patch
+janitor-sh-bigsur-io-minmax-removal.patch
+janitor-sh-hd64465-minmax-removal.patch
+janitor-block-xd-replace-schedule_timeout-with-msleep-msleep_interruptible.patch
+janitor-ide-ide-cs-replace-schedule_timeout-with-msleep.patch
+janitor-reiserfs-superc-vfree-checking-cleanups.patch

 Janitorial stuff

+drivers-net-sk98lin-possible-cleanups.patch

 cleanup

+schedule_timeout_uninterruptible.patch

 Add schedule_timeout_interruptible() and schedule_timeout_uninterruptible()

+include-update-jiffies-musecs-conversion-functions.patch
+timeh-remove-ifdefs.patch
+fs-fix-up-schedule_timeout-usage.patch
+kernel-fix-up-schedule_timeout-usage.patch
+mm-fix-up-schedule_timeout-usage.patch
+net-fix-up-schedule_timeout-usage.patch
+net-fix-up-schedule_timeout-usage-fix.patch
+net-fix-up-schedule_timeout-usage-fix-2.patch
+sound-fix-up-schedule_timeout-usage.patch
+alpha-fix-up-schedule_timeout-usage.patch
+i386-fix-up-schedule_timeout-usage.patch
+ia64-fix-up-schedule_timeout-usage.patch
+m68k-fix-up-schedule_timeout-usage.patch
+mips-fix-up-schedule_timeout-usage.patch
+ppc-fix-up-schedule_timeout-usage.patch
+um-fix-up-schedule_timeout-usage.patch
+drivers-acpi-fix-up-schedule_timeout-usage.patch
+drivers-block-fix-up-schedule_timeout-usage.patch
+drivers-cdrom-fix-up-schedule_timeout-usage.patch
+drivers-char-fix-up-schedule_timeout-usage.patch
+drivers-dlm-fix-up-schedule_timeout-usage.patch
+drivers-net-fix-up-schedule_timeout-usage.patch
+ieee1394-fix-up-schedule_timeout-usage.patch
+isdn-fix-up-schedule_timeout-usage.patch
+drivers-macintosh-fix-up-schedule_timeout-usage.patch
+drivers-md-fix-up-schedule_timeout-usage.patch
+drivers-media-fix-up-schedule_timeout-usage.patch
+message-fix-up-schedule_timeout-usage.patch
+parport-fix-up-schedule_timeout-usage.patch
+parport-fix-up-schedule_timeout-usage-fix.patch
+drivers-sbus-fix-up-schedule_timeout-usage.patch
+drivers-scsi-fix-up-schedule_timeout-usage.patch
+serial-fix-up-schedule_timeout-usage.patch
+telephony-fix-up-schedule_timeout-usage.patch
+drivers-usb-fix-up-schedule_timeout-usage.patch
+drivers-usb-fix-up-schedule_timeout-usage-fix.patch

 Use them.


All 940 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/patch-list


