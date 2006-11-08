Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754497AbWKHJzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbWKHJzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbWKHJy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:54:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49317 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754498AbWKHJy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:54:57 -0500
Date: Wed, 8 Nov 2006 01:54:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc5-mm1
Message-Id: <20061108015452.a2bb40d2.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Temporarily at

http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/

will turn up at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/

when kernel.org mirroring catches up.



- Merged the Kernel-based Virtual Machine patches.  See kvm.sf.net for
  userspace tools, instructions, etc.

  It needs a recent binutils to build.

- The hrtimer+dynticks code still doesn't work right for machines which halt
  their TSC in low-power states.




Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git-fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git tag v2.6.16-rc2-mm1
  git-checkout -b local-v2.6.16-rc2-mm1 v2.6.16-rc2-mm1

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

- When reporting bugs in this kernel via email, please also rewrite the
  email Subject: in some manner to reflect the nature of the bug.  Some
  developers filter by Subject: when looking for messages to read.

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.




Changes since 2.6.19-rc4-mm2:


 git-acpi.patch
 git-alsa.patch
 git-agpgart.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-gfs2-nmw.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-libata-all.patch
 git-mips.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-ioat.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-r8169.patch
 git-pciseg.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-sas.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-wireless.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees.

-ecryptfs-cipher-code-to-new-crypto-api-fix.patch
-md-check-bio-address-after-mapping-through-partitions-tidy.patch
-md-send-online-offline-uevents-when-an-md-array-starts-stops.patch
-sys_pselect7-vs-compat_sys_pselect7-uaccess-error-handling.patch
-update-some-docbook-comments.patch
-docbook-merge-journal-api-into-filesystemstmpl.patch
-fix-ipc-entries-removal.patch
-un-needed-add-store-operation-wastes-a-few-bytes.patch
-fix-ufs-superblock-alignment-issues.patch
-lkdtm-cleanup-headers-and-module_param-module_parm_desc.patch
-cleanup-read_pages.patch
-cifs-readpages-fixes.patch
-fuse-readpages-cleanup.patch
-gfs2-readpages-fixes.patch
-edac_mc-fix-error-handling.patch
-nfs4-fix-for-recursive-locking-problem.patch
-ipmi_si_intfc-sets-bad-class_mask-with-pci_device_class.patch
-init_reap_node-initialization-fix.patch
-printk-timed-ratelimit.patch
-schedule-removal-of-futex_fd.patch
-acpi_noirq-section-fix.patch
-swsusp-debugging.patch
-swsusp-debugging-doc.patch
-spi-section-fix.patch
-reiserfs-reset-errval-after-initializing-bitmap-cache.patch
-usb-hub-build-fix.patch
-remove-hotplug-cpu-crap-from-cpufreq.patch
-uml-fix-i-o-hang.patch
-uml-include-tidying.patch
-create-compat_sys_migrate_pages.patch
-wire-up-sys_migrate_pages.patch
-revert-iscsi-build-failure-use-depends-instead-of.patch
-let-pci_multithread_probe-depend-on-broken.patch
-hdspm-printk-warning-fix.patch
-nozomi-warning-fixes.patch
-nozomi-irq-flags-fixes.patch
-update-uio_interrupt.patch
-dvb-dibx000_common-fix.patch
-input-handle-sysfs-errors.patch
-input-drivers-handle-sysfs-errors.patch
-lightning-return-proper-return-code.patch
-ps-2-driver-update-for-fujitsu-4-wire-touchscreen-on-hitachi-tablets.patch
-lifebook-learn-about-tabs.patch
-git-net-configh-got-removed.patch
-sundance-remove-txstartthresh-and-rxearlythresh.patch
-sundance-fix-tx-pause-bug-reset_tx-intr_handler.patch
-sundance-correct-initial-and-close-hardware-step.patch
-defxx-big-endian-hosts-support.patch
-netxen-build-fix.patch
-netxen-more-build-fixes.patch
-forcedeth-add-mgmt-unit-support.patch
-forcedeth-add-recoverable-error-support.patch
-forcedeth-add-new-nvidia-pci-ids.patch
-forcedeth-add-support-for-new-mcp67-device.patch
-nfs-nfsaclsvc_encode_getaclres-fix-potential-null-deref-and-tiny-optimization.patch
-sunrpc-add-missing-spin_unlock.patch
-git-scsi-target-fixup.patch
-git-scsi-target-vs-git-block.patch
-scsi-target-needs-pci.patch
-gregkh-usb-sierra-new-device.patch
-gregkh-usb-hid-core-big-endian-fix-fix.patch
-xpad-additional-usb-ids-added.patch
-usb-print_schedule_frame-defined-but-not-used-warning-fix.patch
-x86_64-mm-i386-reloc-data-4k-aligned.patch
-x86_64-mm-paravirt-cpu-detect.patch
-x86_64-mm-clear-irq-vector.patch
-x86_64-mm-io-apic-reuse.patch
-prep-for-paravirt-desch-clearer-parameter-names.patch
-prep-for-paravirt-desch-clearer-parameter-names-fix.patch
-prep-for-paravirt-rearrange-processorh.patch
-paravirtualization-header-and-stubs-for.patch
-paravirtualization-patch-inline-replacements-for.patch
-paravirtualization-patch-inline-replacements-for-fix.patch
-paravirtualization-more-generic-paravirtualization.patch
-paravirtualization-allow-selected-bug-checks-to-be.patch
-paravirtualization-allow-disabling-legacy-power.patch
-paravirtualization-add-apic-accessors-to-paravirt-ops.patch
-paravirtualization-add-apic-accessors-to-paravirt-ops-tidy.patch
-paravirtualization-add-mmu-virtualization-to.patch
-swsusp-use-platform-mode-by-default.patch
-improve-the-remove-sysctl-warnings.patch
-sysctl-allow-a-zero-ctl_name-in-the-middle-of-a-sysctl-table.patch
-sysctl-implement-ctl_unnumbered.patch

 Merged into mainline or a subsystem tree.

+regression-in-2619-rc-microcode-driver.patch
+a-minor-fix-for-set_mb-in-documentation-memory-barrierstxt.patch
+nfsd4-reindent-do_open_lookup.patch
+nfsd4-fix-open-create-permissions.patch
+x86_64-mm-i386-reloc-data-4k-aligned.patch
+dm-fix-find_device-race.patch
+dm-suspend-fix-error-path.patch
+dm-multipath-fix-rr_add_path-order.patch
+dm-raid1-fix-waiting-for-io-on-suspend.patch
+dm-raid1-fix-waiting-for-io-on-suspend-fix.patch
+drivers-telephony-ixj-fix-an-array-overrun.patch
+tigran-has-moved.patch
+md-change-online-offline-events-to-a-single-change-event.patch
+md-fix-sizing-problem-with-raid5-reshape-and-config_lbd=n.patch
+md-do-not-freeze-md-threads-for-suspend.patch
+fix-kretprobe-booster-to-save-regs-and-set-status.patch

 2.6.19 queue (mostly)

+video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
+video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-msi-laptop-fix.patch
+add-display-output-class-support.patch
+backlight-and-output-sysfs-support-for-acpi-video-driver.patch
+add-output-class-document.patch
+fix-comments-style-in-acpi-videoc.patch

 ACPI things.

+video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-sony_acpi-fix.patch

 Fix sony acpi driver for acpi things.

+remove-hotplug-cpu-crap-from-cpufreq.patch

 cpufreq cleanup

+git-cpufreq-build-fix.patch

 cpufreq fix

+fix-gregkh-driver-network-device.patch

 Fix driver tree

+tda826x-use-correct-max-frequency.patch

 DVB fix

+ia64-select-acpi_numa-if-acpi.patch

 ia64 fix

+input-map-btn_forward-to-button-2-in-mousedev.patch

 input fix

+e1000-linkage-fix.patch

 netdev fix

+net-uninline-xfrm_selector_match.patch
+net-uninline-skb_put.patch

 uninline porky functions in net

+fix-sunrpc-wakeup-execute-race-condition.patch

 NFS fix

+powerpc-add-efika-platform-support.patch

 ppc board support.

+gregkh-pci-pci-multithread-not-broken.patch

 PCI tree update

+fix-pci-sysfs-file-deletion.patch

 PCI fix

+pci-check-szhi-when-sz-is-0-for-64-bit-pref-mem.patch

 PCI fix which is partial and which I don't fully understand :(

+drivers-scsi-mca_53c9xc-save_flags-cli-removal.patch
+drivers-scsi-mca_53c9xc-save_flags-cli-removal-fix.patch
+drivers-scsi-psi240ic-fix-an-array-overrun.patch

 scsi fixlets

+git-sas-kconfig-fix.patch

 SAS fix

+gregkh-usb-usb-storage-unusual_devs.h-entry-for-sony-ericsson-p990i.patch
+gregkh-usb-usb-ftdi_sio-adds-vendor-product-id-for-a-rfid-construction-kit.patch
+gregkh-usb-usb-ftdi-driver-pid-for-dmx-interfaces.patch
+gregkh-usb-usb-fix-ucr-61s2b-unusual_dev-entry.patch
+gregkh-usb-usb-ohci-fix-root-hub-resume-bug.patch
+gregkh-usb-usb-hid-handle-stall-on-interrupt-endpoint.patch
+gregkh-usb-usb-core-don-t-match-interface-descriptors-for-vendor-specific-devices.patch
+gregkh-usb-usb-ohci-hcd-fix-compiler-warning.patch
+gregkh-usb-usb-ohci-disable-rhsc-inside-interrupt-handler.patch
+gregkh-usb-usb-kmemdup-cleanup-in-drivers-usb.patch
+gregkh-usb-usb-ohci-remove-stale-testing-code-from-root-hub-resume.patch
+gregkh-usb-aircable-use-usb-endpoint-functions.patch
+gregkh-usb-appledisplay-use-usb-endpoint-functions.patch
+gregkh-usb-cdc_ether-use-usb-endpoint-functions.patch
+gregkh-usb-cdc-use-usb-endpoint-functions.patch
+gregkh-usb-devices-use-usb-endpoint-functions.patch
+gregkh-usb-ftdi-use-usb-endpoint-functions.patch
+gregkh-usb-hid-use-usb-endpoint-functions.patch
+gregkh-usb-idmouse-use-usb-endpoint-functions.patch
+gregkh-usb-kobil_sct-use-usb-endpoint-functions.patch
+gregkh-usb-legousbtower-use-usb-endpoint-functions.patch
+gregkh-usb-onetouch-use-usb-endpoint-functions.patch
+gregkh-usb-phidgetkit-use-usb-endpoint-functions.patch
+gregkh-usb-phidgetmotorcontrol-use-usb-endpoint-functions.patch
+gregkh-usb-speedtch-use-usb-endpoint-functions.patch
+gregkh-usb-usbkbd-use-usb-endpoint-functions.patch
+gregkh-usb-usbmouse-use-usb-endpoint-functions.patch
+gregkh-usb-usbnet-use-usb-endpoint-functions.patch
+gregkh-usb-usbtest-use-usb-endpoint-functions.patch
+gregkh-usb-usb-use-usb-endpoint-functions.patch
+gregkh-usb-yealink-use-usb-endpoint-functions.patch
+gregkh-usb-usb-makes-usb_endpoint_-functions-inline.patch
+gregkh-usb-usb-autosuspend-code-consolidation.patch
+gregkh-usb-usb-expand-autosuspend-autoresume-api.patch
+gregkh-usb-usb-print_schedule_frame-defined-but-not-used-warning-fix.patch

 USB tree updates

+fix-gregkh-usb-usb-expand-autosuspend-autoresume-api.patch

 Fix it.

+correct-keymapping-on-powerbook-built-in-usb-iso-keyboards.patch
+powerpc-add-of_platform-support-for-ohci-bigendian-hc.patch
+usb-urb-unlink-free-clenup.patch
+usb-idmouse-cleanup.patch

 USB updates

+x86_64-mm-i386-reloc-abssym.patch
+x86_64-mm-i386-reloc-cleanup-align.patch
+x86_64-mm-paravirt-cpu-detect.patch
+x86_64-mm-clear-irq-vector.patch
+x86_64-mm-io-apic-reuse.patch
+x86_64-mm-pka-cast.patch
+x86_64-mm-probe-kernel-address.patch
+x86_64-mm-i386-probe-kernel-address.patch
+x86_64-mm-fix-exit-idle-race.patch
+x86_64-mm-try-multiple-timer-pins.patch
+x86_64-mm-sa_siginfo-was-forgotten.patch
+x86_64-mm-reserve-bootmem-beyond-end-pfn.patch
+x86_64-mm-header-and-stubs-for.patch
+x86_64-mm-paravirt-patch.patch
+x86_64-mm-paravirt-entry.patch
+x86_64-mm-paravirt-bug-skip.patch
+x86_64-mm-paravirt-no-legacy.patch
+x86_64-mm-paravirt-apic.patch
+x86_64-mm-paravirt-tlb.patch
+x86_64-mm-paravirt-broken.patch
+x86_64-mm-paravirt-compile.patch
+x86_64-mm-calgary-shift.patch
+x86_64-mm-calgary-bios.patch
+x86_64-mm-calgary-bios-cleanup.patch
+x86_64-mm-calgary-not-default.patch
+x86_64-mm-make-x86_64-udelay-round-up-instead-of-down..patch
+x86_64-mm-comment-magic-constants-in-delay.h.patch
+x86_64-mm-setup-saved_max_pfn-correctly-kdump.patch
+x86_64-mm-io-apic-cleanup.patch
+x86_64-mm-i386-apic-irq-race.patch
+x86_64-mm-apic-irq-race.patch
+x86_64-mm-i386-iopl.patch
+x86_64-mm-csum-dont-inline.patch

 x86 tree updates

-revert-x86_64-mm-cpa-clflush.patch

 Dropped

+x86_64-mm-i386-reloc-abssym-hack.patch
+fix-x86_64-mm-i386-reloc-kallsyms.patch

 Fix x86 tree

+paravirtualization-header-and-stubs-for-fix.patch
+paravirtualization-header-and-stubs-for-headers_check-fix.patch
+paravirtualization-patch-inline-replacements-for-fix-2.patch
+paravirtualization-patch-inline-replacements-for-fix-3.patch
+paravirtualization-more-generic-paravirtualization-warning-fix.patch

 Fix paravirt patches in x86 tree

+htirq-refactor-so-we-only-have-one-function-that-writes-to-the-chip.patch
+htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers.patch
+htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers-update.patch

 Rework hypertransport code

+x86_64-update-mmconfig-resource-insertion-to-check-against-e820-map.patch
+i386-update-mmconfig-resource-insertion-to-check-against-e820-map.patch

 x86 updates

+mm-pagefault_disableenable-s390-fix.patch

 Fix mm-pagefault_disableenable.patch

+fix-kunmap_atomics-use-of-kpte_clear_flush.patch

 kunmap_atomic() fixlet.

+allowing-user-processes-to-rise-their-oom_adj-value.patch

 Allow processes to increase their oomkillability.

+gpio-framework-for-avr32.patch
+avr32-spi-ethernet-platform_device-update.patch
+avr32-move-spi-device-definitions-into-main-board.patch
+atmel-spi-driver.patch
+atmel-spi-driver-maintainers-entry.patch
+avr32-move-ethernet-tag-parsing-to-board-specific.patch
+atmel-macb-ethernet-driver.patch
+adapt-macb-driver-to-net_device-changes.patch

 avr32 things

+suspend-dont-change-cpus_allowed-for-task-initiating-the-suspend.patch
+swsusp-measure-memory-shrinking-time.patch

 swsusp updates

+cciss-version-change.patch
+cciss-reference-driver-support.patch
+cciss-increase-number-of-commands-on-controller.patch
+cciss-fix-pci-ssid-for-the-e500-controller.patch
+cciss-disable-dma-prefetch-on-p600.patch
+cciss-set-sector_size-to-2048-for-performance.patch
+cciss-set-sector_size-to-2048-for-performance-tidy.patch
+cciss-change-cciss_open-for-consistency.patch
+cciss-remove-unused-revalidate_allvol-function.patch
+cciss-add-support-for-1024-logical-volumes.patch
+cciss-cleanup-cciss_interrupt-mode.patch

 cciss updates (most of them)

+drivers-add-lcd-support-update-7.patch

 More LCD driver updates

-cciss-change-pci-id-for-bug-workaround.patch

 Dropped.

+taskstats-cleanup-reply-assembling.patch

 taskstats cleanup

-vfs-bkl-is-not-required-for-remount_fs.patch

 Dropped.

+get_options-to-allow-a-hypenated-range-for-isolcpus.patch
+vfs_getattr-remove-dead-code.patch
+ext3-uninline-large-functions.patch
+ext4-uninline-large-functions.patch
+uninline-module_put.patch
+i2lib-unused-variable-cleanup.patch
+make-initramfs-printk-a-warning-on-incorrect-cpio-type.patch
+corrupted-cramfs-filesystems-cause-kernel-oops.patch
+lockdep-print-current-locks-on-in_atomic-warnings.patch
+lockdep-name-some-old-style-locks.patch
+documentation-remount_fs-needs-lock_kernel.patch
+sleep-profiling.patch
+sleep-profiling-fixes.patch
+sleep-profiling-fix.patch
+ext4_ext_split-remove-dead-code.patch
+debug-workqueue-locking-sanity.patch
+debug-workqueue-locking-sanity-fix.patch
+initramfs-handle-more-than-one-source-dir-or-file-list.patch

 Misc

+bdev-fix-bd_part_count-leak.patch

 Fix blockdev lockdep patches in -mm.

-struct-path-convert-splice.patch

 Dropped, for some reason.  I think the fix got moved into a different patch
 during reject fixups.

+tty_ioctl-use-termios-for-the-old-structure-and-termios2.patch
+tty_ioctl-use-termios-for-the-old-structure-and-termios2-fix.patch

 More tty core updates

+char-stallion-functions-cleanup.patch
+char-stallion-fix-fail-paths.patch
+char-stallion-brd-struct-locking.patch
+char-stallion-remove-syntactic-sugar.patch
+char-stallion-variables-cleanup.patch
+char-stallion-use-dynamic-dev.patch
+char-istallion-convert-to-pci-probing.patch
+char-istallion-remove-the-mess.patch
+char-istallion-eliminate-typedefs.patch
+char-istallion-variables-cleanup.patch
+char-istallion-ifdef-eisa-code.patch
+char-istallion-brdnr-locking.patch
+char-istallion-free-only-isa.patch
+char-istallion-correct-fail-paths.patch
+char-istallion-correct-fail-paths-fix.patch

 More char driver clanups.

+kernel-schedc-whitespace-cleanups.patch
+kernel-schedc-whitespace-cleanups-more.patch

 Clean up sched.c

-radeonfb-support-24bpp-32bpp-minus-alpha.patch

 Dropped

+various-fbdev-files-mark-structs-fix.patch

 Fix various-fbdev-files-mark-structs.patch

+fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch

 fbdev fix

+md-tidy-up-device-change-notification-when-an-md-array-is-stopped.patch
+md-change-lifetime-rules-for-md-devices.patch
+md-define-raid5_mergeable_bvec.patch
+md-handle-bypassing-the-read-cache-assuming-nothing-fails.patch
+md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure.patch
+md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure-fix.patch
+md-enable-bypassing-cache-for-reads.patch

 RAID updates

+clockevents-add-broadcast-support-fix.patch
+acpi-include-apic-h-fix.patch
+acpi-verify-lapic-timer-fix.patch

 Try to fix the hrtimers patches in -mm some more (unsuccessfully)

+clocksource-add-usage-of-config_sysfs.patch
+clocksource-small-cleanup-2.patch
+clocksource-small-cleanup-2-fix.patch
+clocksource-small-acpi_pm-cleanup.patch

 clocksource cleanups

+kvm-userspace-interface.patch
+kvm-intel-virtual-mode-extensions-definitions.patch
+kvm-kvm-data-structures.patch
+kvm-random-accessors-and-constants.patch
+kvm-virtualization-infrastructure.patch
+kvm-virtualization-infrastructure-kvm-fix-guest-cr4-corruption.patch
+kvm-memory-slot-management.patch
+kvm-vcpu-creation-and-maintenance.patch
+kvm-workaround-cr0cd-cache-disable-bit-leak-from-guest-to.patch
+kvm-vcpu-execution-loop.patch
+kvm-define-exit-handlers.patch
+kvm-less-common-exit-handlers.patch
+kvm-mmu.patch
+kvm-x86-emulator.patch
+kvm-plumbing.patch
+kvm-dynamically-determine-which-msrs-to-load-and-save.patch
+kvm-fix-calculation-of-initial-value-of-rdx-register.patch

 In-kernel virtual machine

-kevent-core-files.patch
-kevent-core-files-fix.patch
-kevent-core-files-s390-hack.patch
-kevent-poll-select-notifications.patch
-kevent-socket-notifications.patch
-kevent-socket-notifications-fix-2.patch
-kevent-socket-notifications-fix-4.patch
-kevent-timer-notifications.patch
-kevent-timer-notifications-fix.patch
-kevent-fix-socket-notifications.patch
-kevent-remove-mmap-interface.patch
+kevent-v23-description.patch
+kevent-v23-core-files.patch
+kevent-v23-poll-select-notifications.patch
+kevent-v23-socket-notifications.patch
+kevent-v23-socket-notifications-fix-again.patch
+kevent-v23-timer-notifications.patch
+kevent-timer-notifications-fix.patch

 Updated kevent patches

+e1000-printk-warning-fixes.patch

 Fix warnings due to e1000_7033_dump_ring.patch


All 1245 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/patch-list


