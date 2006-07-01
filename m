Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbWGAKfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWGAKfn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 06:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWGAKfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 06:35:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932156AbWGAKfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 06:35:41 -0400
Date: Sat, 1 Jul 2006 03:35:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm5
Message-Id: <20060701033524.3c478698.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm5/


Nothing very exciting here - a few buggy patches were fixed or dropped.


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



Changes since 2.6.17-mm4:


 origin.patch
 git-acpi.patch
 git-cpufreq.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-infiniband.patch
 git-jfs.patch
 git-klibc.patch
 git-hdrinstall2.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-nfs.patch
 git-ocfs2.patch
 git-pcmcia-fixup.patch
 git-sas.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-wireless.patch
 git-cryptodev.patch

 git trees.

-fix-sgivwfb-compile.patch
-generic_file_buffered_write-handle-zero-length-iovec-segments-stable.patch
-solve-config-broken-undefined-reference-to-online_page.patch
-sparc-register_cpu-build-fix.patch
-acpi-add-ibm-r60e-laptop-to-proc-idle-blacklist.patch
-drivers-acpi-scanc-make-acpi_bus_type-static.patch
-acpi_srat-needs-acpi.patch
-acpi-identify-which-device-is-not-power-manageable.patch
-the-scheduled-unexport-of-insert_resource.patch
-videocodec-make-1-bit-fields-unsigned.patch
-i2c-801-64bit-resource-fix.patch
-fs-jffs2-make-2-functions-static.patch
-mtd-fix-all-kernel-doc-warnings.patch
-mtd-kernel-doc-fixes-additions.patch
-af_unix-datagram-getpeersec.patch
-drivers-net-irda-mcs7780c-make-struct-mcs_driver-static.patch
-irda-fix-rcu-lock-pairing-on-error-path.patch
-kill-open-coded-offsetof-in-cm4000_csc-zero_dev.patch
-com20020_cs-more-device-support.patch
-git-pcmcia-xirc2ps_cs-fix-ooops-not-a-creditcard.patch
-git-powerpc.patch
-powerpc-fix-idr-locking-in-init_new_context.patch
-gregkh-pci-64bit-resource-c99-changes-for-struct-resource-declarations.patch
-gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-sound-drivers.patch
-gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-networks-drivers.patch
-gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-pci-core-and-hotplug-drivers.patch
-gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-mtd-drivers.patch
-gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-ide-drivers.patch
-gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-video-drivers.patch
-gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-pcmcia-drivers.patch
-gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-arch-and-core-code.patch
-gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-misc-drivers.patch
-gregkh-pci-64bit-resource-introduce-resource_size_t-for-the-start-and-end-of-struct-resource.patch
-gregkh-pci-64bit-resource-change-resource-core-to-use-resource_size_t.patch
-gregkh-pci-64bit-resource-change-pci-core-and-arch-code-to-use-resource_size_t.patch
-gregkh-pci-64bit-resource-change-pnp-core-to-use-resource_size_t.patch
-gregkh-pci-64bit-resource-convert-a-few-remaining-drivers-to-use-resource_size_t-where-needed.patch
-gregkh-pci-64bit-resource-finally-enable-64bit-resource-sizes.patch
-gregkh-pci-i386-export-memory-more-than-4g-through-proc-iomem.patch
-gregkh-pci-pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch
-gregkh-pci-pci-legacy-i-o-port-free-driver-update-documentation-pci_txt.patch
-gregkh-pci-pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free.patch
-gregkh-pci-pci-legacy-i-o-port-free-driver-make-emulex-lpfc-driver-legacy-i-o-port-free.patch
-64bit-resource-convert-a-few-remaining-drivers-to-use-resource_size_t-where-needed-8139cp.patch
-bugfix-pci-legacy-i-o-port-free-driver.patch
-insert-identical-resources-above-existing-resources.patch
-clear-abnormal-poweroff-flag-on-via-southbridges-fix-resume.patch
-clear-abnormal-poweroff-flag-on-via-southbridges-fix-resume-fix.patch
-small-whitespace-cleanup-for-qlogic-driver.patch
-mpt_interrupt-should-return-irq_none-when.patch
-qla1280-fix-section-mismatch-warnings.patch
-ehci-fix-bogus-alteration-of-a-local-variable.patch
-ipaqc-bugfixes.patch
-ipaqc-timing-parameters.patch
-if-0-drivers-usb-input-hid-corechid_find_field_by_usage.patch
-usb-remove-empty-destructor-from-drivers-usb-mon-mon_textc.patch
-zoned-vm-counters-create-vmstatc-h-from-page_allocc-h.patch
-zoned-vm-counters-create-vmstatc-h-from-page_allocc-h-s390-fix.patch
-zoned-vm-counters-create-vmstatc-h-from-page_allocc-h-fix.patch
-zoned-vm-counters-create-vmstatc-h-from-page_allocc-h-fix-2.patch
-zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation.patch
-zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-tidy.patch
-zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-speedup.patch
-zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-speedup-fix.patch
-zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-export-vm_stat.patch
-zoned-vm-counters-convert-nr_mapped-to-per-zone-counter.patch
-zoned-vm-counters-convert-nr_mapped-to-per-zone-counter-fix.patch
-zoned-vm-counters-conversion-of-nr_pagecache-to-per-zone-counter.patch
-zoned-vm-counters-remove-nr_file_mapped-from-scan-control-structure.patch
-zoned-vm-counters-remove-nr_file_mapped-from-scan-control-structure-fix.patch
-zoned-vm-counters-split-nr_anon_pages-off-from-nr_file_mapped.patch
-zoned-vm-counters-zone_reclaim-remove-proc-sys-vm-zone_reclaim_interval.patch
-zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix.patch
-zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix-2.patch
-zoned-vm-counters-conversion-of-nr_pagetables-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_pagetables-to-per-zone-counter-fix.patch
-zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter-fix.patch
-zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter-fix.patch
-zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter-nfs-fix.patch
-zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter-fix.patch
-zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter.patch
-zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter-fix.patch
-zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter-fix-2.patch
-zoned-vm-counters-remove-useless-struct-wbs.patch
-zoned-vm-counters-remove-read_page_state.patch
-use-zoned-vm-counters-for-numa-statistics-v3.patch
-light-weight-event-counters-v5.patch
-slab-consolidate-code-to-free-slabs-from-freelist.patch
-slab-consolidate-code-to-free-slabs-from-freelist-fix.patch
-selinux-extend-task_kill-hook-to-handle-signals-sent.patch
-selinux-add-security-hook-call-to-kill_proc_info_as_uid.patch
-selinux-update-usb-code-with-new-kill_proc_info_as_uid.patch
-add-smp_setup_processor_id.patch
-x86-dont-print-out-smp-info-on-up-kernels.patch
-keys-allow-in-kernel-key-requestor-to-pass-auxiliary-data-to-upcaller.patch
-keys-allow-in-kernel-key-requestor-to-pass-auxiliary-data-to-upcaller-try-2.patch
-cond_resched-fix.patch
-ufs-printk-fix.patch
-arch-i386-mach-visws-setupc-remove-dummy-function-calls.patch
-re-add-config_sound_sscape.patch
-remove-devinit-from-ioc4-pci_driver.patch
-deref-in-drivers-block-paride-pfc.patch
-chardev-gpio-for-scx200-pc-8736x-add-proper-kconfig-makefile-entries.patch
-edac-pci-device-to-device-cleanup.patch
-edac-mc-numbers-refactor-1-of-2.patch
-edac-mc-numbers-refactor-2-of-2.patch
-edac-probe1-cleanup-1-of-2.patch
-edac-probe1-cleanup-2-of-2.patch
-edac-maintainers-update.patch
-i4l-remove-unneeded-include-linux-isdn-tpamh.patch
-skb-leak-in-drivers-isdn-i4l-isdn_x25ifacec.patch
-knfsd-improve-the-test-for-cross-device-rename-in-nfsd.patch
-knfsd-fixing-missing-expkey-support-for-fsid-type-3.patch
-knfsd-remove-noise-about-filehandle-being-uptodate.patch
-knfsd-ignore-ref_fh-when-crossing-a-mountpoint.patch
-knfsd-nfsd4-fix-open_confirm-locking.patch
-knfsd-nfsd-call-nfsd_setuser-on-fh_compose-fix-nfsd4-permissions-problem.patch
-knfsd-nfsd4-remove-superfluous-grace-period-checks.patch
-knfsd-nfsd-fix-misplaced-fh_unlock-in-nfsd_link.patch
-knfsd-svcrpc-gss-simplify-rsc_parse.patch
-knfsd-nfsd4-fix-some-open-argument-tests.patch
-knfsd-nfsd4-fix-open-flag-passing.patch
-knfsd-svcrpc-simplify-nfsd-rpcsec_gss-integrity-code.patch
-knfsd-nfsd-mark-rqstp-to-prevent-use-of-sendfile-in-privacy-case.patch
-knfsd-svcrpc-gss-server-side-implementation-of-rpcsec_gss-privacy.patch
-drivers-md-raid5c-remove-an-unused-variable.patch
-genirq-rename-desc-handler-to-desc-chip.patch
-genirq-rename-desc-handler-to-desc-chip-power-fix.patch
-genirq-rename-desc-handler-to-desc-chip-ia64-fix.patch
-genirq-rename-desc-handler-to-desc-chip-ia64-fix-2.patch
-genirq-rename-desc-handler-to-desc-chip-terminate_irqs-fix.patch
-genirq-rename-desc-handler-to-desc-chip-sparc64-fix.patch
-genirq-sem2mutex-probe_sem-probing_active.patch
-genirq-cleanup-merge-irq_affinity-into-irq_desc.patch
-genirq-cleanup-merge-irq_affinity-into-irq_desc-sparc64-fix.patch
-genirq-cleanup-remove-irq_descp.patch
-genirq-cleanup-remove-irq_descp-fix.patch
-genirq-cleanup-remove-fastcall.patch
-genirq-cleanup-misc-code-cleanups.patch
-genirq-cleanup-reduce-irq_desc_t-use-mark-it-obsolete.patch
-genirq-cleanup-include-linux-irqh.patch
-genirq-cleanup-merge-irq_dir-smp_affinity_entry-into-irq_desc.patch
-genirq-cleanup-merge-pending_irq_cpumask-into-irq_desc.patch
-genirq-cleanup-turn-arch_has_irq_per_cpu-into-config_irq_per_cpu.patch
-genirq-debug-better-debug-printout-in-enable_irq.patch
-genirq-add-retrigger-irq-op-to-consolidate-hw_irq_resend.patch
-genirq-doc-comment-include-linux-irqh-structures.patch
-genirq-doc-handle_irq_event-and-__do_irq-comments.patch
-genirq-cleanup-no_irq_type-cleanups.patch
-genirq-doc-add-design-documentation.patch
-genirq-add-genirq-sw-irq-retrigger.patch
-genirq-add-irq_noprobe-support.patch
-genirq-add-irq_norequest-support.patch
-genirq-add-irq_noautoen-support.patch
-genirq-update-copyrights.patch
-genirq-core.patch
-genirq-core-revert-noisiness-on-spurious-interrupts.patch
-genirq-msi-fixes-2.patch
-genirq-add-irq-chip-support.patch
-genirq-add-irq-chip-support-fix.patch
-genirq-add-irq-chip-support-misroute-irq-dont-call-desc-chip-end.patch
-genirq-add-handle_bad_irq.patch
-genirq-add-irq-wake-power-management-support.patch
-genirq-add-sa_trigger-support.patch
-genirq-cleanup-no_irq_type-no_irq_chip-rename.patch
-genirq-more-verbose-debugging-on-unexpected-irq-vectors.patch
-genirq-ia64-build-fix.patch
-genirq-add-irq_type_sense_mask.patch
-genirq-add-irq-chip-support-fasteoi-handler-handle-interrupt-disabling.patch
-genirq-irq-document-what-an-irq-is.patch
-genirq-add-chip-eoi-fastack-fasteoi-core.patch
-genirq-add-chip-eoi-fastack-fasteoi-fix.patch

 Merged into mainline or a subsystem tree.

+pi-futex-fix-mm_struct-memory-leak.patch
+irq-use-sa_percpu_irq-not-irq_per_cpu-for-irqactionflags.patch
+irq-warning-message-cleanup.patch
+edac-bug-fix-module-names-quoted-in-sysfs.patch
+pi-futex-futex_wake-lockup-fix.patch
+acpi-identify-which-device-is-not-power-manageable.patch

 2.6.17-rc1 queue

-git-acpi-fixup.patch

 Unneeded.

-cpu_relax-use-in-acpi-lock.patch
-cpu_relax-use-in-acpi-lock-fix.patch

 Dropped.

+pnpacpi-support-shareable-interrupts.patch
+serial-allow-shared-8250_pnp-interrupts.patch

 pnpacpi fixes

-git-agpgart-fixup.patch

 Unneeded.

+gregkh-driver-driver-core-bus.c-cleanups.patch
+gregkh-driver-remove-kernel-power-pm.c-pm_unregister_all.patch
+gregkh-driver-the-scheduled-unexport-of-insert_resource.patch
+gregkh-driver-suspend-infrastructure-cleanup-and-extension.patch
+gregkh-driver-suspend-pci.patch

 Driver tree updates.

+gregkh-i2c-w1-fix-idle-check-loop-in-ds2482.patch
+gregkh-i2c-w1-remove-drivers-w1-w1.h.patch

 I2C tree updates

+ib-ipath-name-zero-counter-offsets-so-its-clear.patch
+ib-ipath-update-copyrights-and-other-strings-to.patch
+ib-ipath-share-more-common-code-between-rc-and-uc.patch
+ib-ipath-fix-an-indenting-problem.patch
+ib-ipath-fix-shared-receive-queues-for-rc.patch
+ib-ipath-allow-diags-on-any-unit.patch
+ib-ipath-update-some-comments-and-fix-typos.patch
+ib-ipath-remove-some-duplicate-code.patch
+ib-ipath-dont-allow-resources-to-be-created-with.patch
+ib-ipath-fix-some-memory-leaks-on-failure-paths.patch
+ib-ipath-return-an-error-for-unknown-multicast-gid.patch
+ib-ipath-report-correct-device-identification.patch
+ib-ipath-enforce-device-resource-limits.patch
+ib-ipath-removed-unused-field-ipath_kregvirt-from.patch
+ib-ipath-print-better-debug-info-when-handling.patch
+ib-ipath-enable-freeze-mode-when-shutting-down.patch
+ib-ipath-use-more-appropriate-gfp-flags.patch
+ib-ipath-use-vmalloc-to-allocate-struct.patch
+ib-ipath-memory-management-cleanups.patch
+ib-ipath-reduce-overhead-on-receive-interrupts.patch
+ib-ipath-fixed-bug-9776.patch
+ib-ipath-fix-lost-interrupts-on-ht-400.patch
+ib-ipath-disallow-send-of-invalid-packet-sizes.patch
+ib-ipath-dont-confuse-the-max-message-size-with.patch
+ib-ipath-removed-redundant-statements.patch
+ib-ipath-check-for-valid-lid-and-multicast-lids.patch
+ib-ipath-fixes-to-performance-get-counters-for-ib.patch
+ib-ipath-rc-receive-interrupt-performance-changes.patch
+ib-ipath-purge-sps_lid-and-sps_mlid-arrays.patch
+ib-ipath-drop-the-stats-sysfs-attribute-group.patch
+ib-ipath-support-more-models-of-infinipath-hardware.patch
+ib-ipath-read-write-correct-sizes-through-diag.patch
+ib-ipath-fix-a-bug-that-results-in-addresses-near.patch
+ib-ipath-remove-some-if-0-code-related-to.patch
+ib-ipath-ignore-receive-queue-size-if-srq-is.patch
+ib-ipath-namespace-cleanup-replace-ips-with-ipath.patch

 Infiniband updates

+ib-ipath-fixes-a-bug-where-our-delay-for-eeprom-no.patch

 Unpopular infiniband update

-revert-input-atkbd-fix-hangeul-hanja-keys.patch

 Dropped.

+if-0-drivers-usb-input-hid-corechid_find_field_by_usage.patch

 USB cleanup.

+ia64-kbuild-fix.patch

 Fix kbuild for ia64

-revert-ignore-makes-built-in-rules-variables.patch

 Unneeded.

+git-netdev-all-fixup.patch

 Fix reject due to git-netdev-all.patch

+8139cp-printk-fix.patch

 Fix printk warning

-ni5010-netcard-cleanup-fix.patch

 Folded into ni5010-netcard-cleanup.patch

+ixgb-add-pci-error-recovery-callbacks.patch
+e100-disable-device-on-pci-error.patch
+e1000-disable-device-on-pci-error.patch

 netdev updates

+fix-a-warning-in-ioatdma.patch
+ioat-fix-header-file-kernel-doc.patch
+ioat-fix-kernel-doc-in-source-files.patch

 IOAT driver fixlets

+fs-nfs-make-2-functions-static.patch

 NFS cleanup

+fix-implicit-declaration-on-cell.patch

 powerpc fix

-git-sas-sas_discover-build-fix.patch

 Dropped.

-serial-add-tsi108-8250-serial-support-fix.patch

 Folded into serial-add-tsi108-8250-serial-support.patch

+gregkh-pci-pci-poper-prototype-for-arch-i386-pci-pcbios.c-pcibios_sort.patch
+gregkh-pci-pci-clear-abnormal-poweroff-flag-on-via-southbridges-fix-resume.patch
+gregkh-pci-msi-merge-existing-msi-disabling-quirks.patch
+gregkh-pci-msi-rename-pci_cap_id_ht_irqconf-into-pci_cap_id_ht.patch
+gregkh-pci-msi-blacklist-pci-e-chipsets-depending-on-hypertransport-msi-capabality.patch
+gregkh-pci-msi-factorize-common-msi-detection-code-from-pci_enable_msi-and-msix.patch
+gregkh-pci-msi-stop-inheriting-bus-flags-and-check-root-chipset-bus-flags-instead.patch
+gregkh-pci-msi-drop-pci_msi_quirk.patch
+gregkh-pci-resources-insert-identical-resources-above-existing-resources.patch

 PCI tree updates

-drivers-scsi-qla2xxx-make-more-some-functions-static.patch

 Folded into drivers-scsi-qla2xxx-make-some-functions-static.patch

+stc-improve-sense-output.patch
+my-name-is-ingo-molnar-you-killed-my-make-allyesconfig-prepare-to-die.patch

 scsi fixes.

+gregkh-usb-usb-unusual_devs-entry-for-samsung-mp3-player.patch
+gregkh-usb-usbcore-fixes-for-hub_port_resume.patch
+gregkh-usb-usb-storage-us_fl_max_sectors_64-flag.patch
+gregkh-usb-usb-storage-uname-in-pr-sc-unneeded-message.patch
+gregkh-usb-usb-serial-visor-fix-race-in-open-close.patch
+gregkh-usb-usb-serial-ftdi_sio-prevent-userspace-dos.patch
+gregkh-usb-usb-kill-compiler-warning-in-quirk_usb_handoff_ohci.patch
+gregkh-usb-usb-fix-pointer-dereference-in-drivers-usb-misc-usblcd.patch
+gregkh-usb-usb-add-driver-for-non-composite-sierra-wireless-devices.patch
+gregkh-usb-usb-ehci-fix-bogus-alteration-of-a-local-variable.patch
+gregkh-usb-usb-ipaq.c-bugfixes.patch
+gregkh-usb-usb-ipaq.c-timing-parameters.patch
+gregkh-usb-usb-remove-empty-destructor-from-drivers-usb-mon-mon_text.c.patch
+gregkh-usb-usb-ohci-s3c2410.c-clock-now-usb-bus-host.patch
+gregkh-usb-usb-at91-udc-updates-mostly-power-management.patch
+gregkh-usb-usb-at91-ohci-updates-mostly-power-management.patch
+gregkh-usb-usb-ohci-controller-support-for-pnx4008.patch
+gregkh-usb-usb-move-linux-usb_otg.h-to-linux-usb-otg.h.patch
+gregkh-usb-usb-pxa2xx_udc-understands-gpio-based-vbus-sensing.patch
+gregkh-usb-usb-allow-compile-in-g_ether-fix-typo.patch

 USB updates

+kill-usb-kconfig-warning.patch

 Fix it.

-bcm43xx-opencoded-locking-fix.patch

 Folded into bcm43xx-opencoded-locking.patch

+x86_64-mm-defconfig-update.patch
+x86_64-mm-i386-up-generic-arch.patch
+x86_64-mm-i386-numa-summit-check.patch
+x86_64-mm-temp-revert-arch-perfmon.patch
+x86_64-mm-add-performance-counter-reservation-framework-for-up-kernels.patch
+x86_64-mm-utilize-performance-counter-reservation-framework-in-oprofile.patch
+x86_64-mm-add-smp-support-on-x86_64-to-reservation-framework.patch
+x86_64-mm-add-smp-support-on-i386-to-reservation-framework.patch
+x86_64-mm-cleanup-nmi-interrupt-path.patch
+x86_64-mm-rdtscp-macros.patch
+x86_64-mm-init-rdtscp.patch
+x86_64-mm-mce-amd-fix.patch

 x86-64 tree updates (partial - I dropped all the NMI changes because they
 don't apply and look like they wouldn't build if I fixed them all).

+zvc-zone_reclaim-leave-1%-of-unmapped-pagecache-pages-for-file-i-o.patch
+zvc-zone_reclaim-leave-1%-of-unmapped-pagecache-pages-for-file-i-o-tunable.patch
+zvc-zone_reclaim-leave-1%-of-unmapped-pagecache-pages-for-file-i-o-tunable-rename.patch

 NUMA memory reclaim tweak.

+mm-fixup-do_wp_page.patch

 MM fix

+mm-msync-cleanup-fix.patch

 Fix mm-msync-cleanup.patch

+mm-make-functions-static.patch

 MM cleanup

-lockdep-add-disable-enable_irq_lockdep-api-fix.patch

 Folded into lockdep-add-disable-enable_irq_lockdep-api.patch

-lockdep-stacktrace-subsystem-s390-support-fix.patch

 Folded into lockdep-stacktrace-subsystem-s390-support.patch

-lockdep-irqtrace-subsystem-x86_64-support-fix.patch
-lockdep-irqtrace-subsystem-x86_64-support-fix-2.patch

 Folded into lockdep-irqtrace-subsystem-x86_64-support.patch

-lockdep-core-improve-non-static-key-warning-message.patch
-lockdep-core-cleanups.patch
-lockdep-core-cleanups-2.patch

 Folded into lockdep-core.patch

-lockdep-annotate-vlan-net-device-as-being-a-special-class-fix.patch

 Folded into lockdep-annotate-vlan-net-device-as-being-a-special-class.patch

+lockdep-core-improve-bug-messages.patch
+lockdep-core-add-set_class_and_name.patch
+lockdep-core-add-set_class_and_name-fix.patch
+lockdep-annotate-blkdev-nesting-fix.patch
+lockdep-annotate-sk_locks.patch
+lockdep-annotate-sk_locks-fix.patch

 lockdep updates

+smp-alternatives-skip-with-up-kernels.patch

 x86 alternatives cleanup

-hpet-rtc-emulation-add-watchdog-timer.patch
+hpet-rtc-emulation-add-watchdog-timer-2.patch

 Updated version of this ancient patch.

-destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch
-destroy-the-dentries-contributed-by-a-superblock-on-unmounting-fix.patch

 Dropped.

+fix-is_err-threshold-value.patch
+rtc-class-driver-for-samsung-s3c-series-soc.patch
+rtc-class-driver-for-samsung-s3c-series-soc-tidy.patch
+hotcpu_notifier-fixes.patch
+add-___rodata-sections-to-asm-generic-sectionsh.patch
+add-___rodata-sections-to-asm-generic-sectionsh-fix.patch
+s390-put-sys_call_table-into-rodata-section-and-write-protect-it.patch
+reiserfs-update-ctime-and-mtime-on-expanding-truncate.patch
+kernel-doc-consistent-text-man-mode-output.patch
+fix-problem-with-atapi-dma-on-it8212-in-linux.patch
+kernel-doc-make-man-text-mode-function-output-same.patch
+fix-and-enable-edac-sysfs-operation.patch
+edac-new-opteron-athlon64-memory-controller-driver.patch
+edac-new-opteron-athlon64-memory-controller-driver-tidy.patch
+drivers-block-nbdc-compile-fix.patch
+pnp-suppress-request_irq-warning.patch

 Misc patches.

+per-task-delay-accounting-taskstats-interface-tidy.patch

 Tweak per-task-delay-accounting-taskstats-interface.patch

+jmicron-pci-identifiers.patch

 PCI IDs for IDE drivers

+fbdev-add-framebuffer-and-display-update-module-support.patch
+vt-remove-vt-specific-declarations-and-definitions-from.patch
+tty-remove-include-of-screen_infoh-from-ttyh.patch

 fbdev updates

+statistics-infrastructure-update-6.patch
+statistics-infrastructure-update-7.patch
+statistics-infrastructure-update-8.patch

 statistics updates

+genirq-convert-the-x86_64-architecture-to-irq-chips.patch
+genirq-add-chip-eoi-fastack-fasteoi-x86_64.patch
+genirq-convert-the-i386-architecture-to-irq-chips.patch
+genirq-convert-the-i386-architecture-to-irq-chips-fix-2.patch
+genirq-add-chip-eoi-fastack-fasteoi-x86.patch
+genirq-irq-convert-the-move_irq-flag-from-a-32bit-word-to-a-single-bit.patch
+genirq-irq-add-moved_masked_irq.patch
+genirq-x86_64-irq-reenable-migrating-irqs-to-other-cpus.patch
+genirq-x86_64-irq-reenable-migrating-irqs-to-other-cpus-fix.patch
+genirq-msi-simplify-msi-enable-and-disable.patch
+genirq-msi-simplify-msi-enable-and-disable-fix.patch
+genirq-msi-make-the-msi-boolean-tests-return-either-0-or-1.patch
+genirq-msi-implement-helper-functions-read_msi_msg-and-write_msi_msg.patch
+genirq-msi-refactor-the-msi_ops.patch
+genirq-msi-simplify-the-msi-irq-limit-policy.patch
+genirq-irq-add-a-dynamic-irq-creation-api.patch
+genirq-ia64-irq-dynamic-irq-support.patch
+genirq-ia64-irq-dynamic-irq-support-fix.patch
+genirq-i386-irq-dynamic-irq-support.patch
+genirq-i386-irq-dynamic-irq-support-fix.patch
+genirq-x86_64-irq-dynamic-irq-support.patch
+genirq-msi-make-the-msi-code-irq-based-and-not-vector-based.patch
+genirq-x86_64-irq-move-msi-message-composition-into-io_apicc.patch
+genirq-i386-irq-move-msi-message-composition-into-io_apicc.patch
+genirq-msi-only-build-msi-apicc-on-ia64.patch
+genirq-x86_64-irq-remove-the-msi-assumption-that-irq-==-vector.patch
+genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector.patch
+genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector-fix.patch
+genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector-fix-tidies.patch
+genirq-irq-remove-msi-hacks.patch
+genirq-irq-generalize-the-check-for-hardirq_bits.patch
+genirq-x86_64-irq-make-the-external-irq-handlers-report-their-vector-not-the-irq-number.patch
+genirq-x86_64-irq-make-vector_irq-per-cpu.patch
+genirq-x86_64-irq-kill-gsi_irq_sharing.patch
+genirq-x86_64-irq-kill-irq-compression.patch

 Restore the genirq implementation for various architectures.

-ro-bind-mounts-prepare-for-write-access-checks-collapse-if.patch
-ro-bind-mounts-r-o-bind-mount-prepwork-move-open_nameis-vfs_create.patch
-ro-bind-mounts-add-vfsmount-writer-count.patch
-ro-bind-mounts-elevate-mnt-writers-for-callers-of-vfs_mkdir.patch
-ro-bind-mounts-elevate-write-count-during-entire-ncp_ioctl.patch
-ro-bind-mounts-elevate-write-count-during-entire-ncp_ioctl-tidy.patch
-ro-bind-mounts-sys_symlinkat-elevate-write-count-around-vfs_symlink.patch
-ro-bind-mounts-elevate-mount-count-for-extended-attributes.patch
-ro-bind-mounts-sys_linkat-elevate-write-count-around-vfs_link.patch
-ro-bind-mounts-mount_is_safe-add-comment.patch
-ro-bind-mounts-unix_find_other-elevate-write-count-for-touch_atime.patch
-ro-bind-mounts-elevate-write-count-over-calls-to-vfs_rename.patch
-ro-bind-mounts-tricky-elevate-write-count-files-are-opened.patch
-ro-bind-mounts-elevate-writer-count-for-do_sys_truncate.patch
-ro-bind-mounts-elevate-write-count-for-do_utimes.patch
-ro-bind-mounts-elevate-write-count-for-do_sys_utime-and-touch_atime.patch
-ro-bind-mounts-sys_mknodat-elevate-write-count-for-vfs_mknod-create.patch
-ro-bind-mounts-elevate-mnt-writers-for-vfs_unlink-callers.patch
-ro-bind-mounts-do_rmdir-elevate-write-count.patch
-ro-bind-mounts-elevate-writer-count-for-custom-struct-file.patch
-ro-bind-mounts-honor-r-w-changes-at-do_remount-time.patch

 Dropped.

+the-scheduled-removal-of-some-oss-drivers.patch

 Remove lots of OSS drivers

+make-more-file_operation-structs-static.patch
+make-more-file_operation-structs-static-fix.patch

 constify some file_operations structs.

-slab-leak-detector.patch

 Dropped.

+kernel-printkc-export_symbol_unused.patch
+mm-bootmemc-export_unused_symbol.patch
+mm-memoryc-export_unused_symbol.patch
+mm-mmzonec-export_unused_symbol.patch
+fs-read_writec-export_unused_symbol.patch
+export_unused_symbolgpl-unregister_die_notifier.patch
+kernel-softirqc-export_unused_symbol.patch

 Fiddle with exports.



All 791 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm5/patch-list



