Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWHFHYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWHFHYM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHFHYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:24:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932065AbWHFHYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:24:06 -0400
Date: Sun, 6 Aug 2006 00:24:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc3-mm1
Message-Id: <20060806002400.694948a1.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm1/

- Added the r8169 net driver tree to the -mm lineup, as git-r8169.patch
  (Francois Romieu).

- A largeish nfsd update to improve NUMA scalability.

- Re-added David Howells's cachefs and fs-cache drivers to support local
  caching of AFS and NFS files.

- fwiw, I recently took a position with Google. 
  http://www.linuxtoday.com/developer/2006080303126NWCYKN has details.



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

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.



Changes since 2.6.18-rc2-mm1:


 origin.patch
 git-alsa.patch
 git-agpgart.patch
 git-block.patch
 git-cifs.patch
 git-cpufreq.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-jfs.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ocfs2.patch
 git-parisc.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-r8169.patch
 git-sas.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 git trees.


-sched-build_sched_domains-fix.patch
-ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle.patch
-ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle-fix.patch
-process-events-fix-biarch-compatibility-issue-use-__u64-timestamp.patch
-gpio-rename-exported-vtables-to-better-match-tidy.patch
-genirq-endisable_irq_wake-need-refcounting-too.patch
-make-taskstats-sending-completely-independent-of-delay.patch
-taskstats-free-skb-avoid-returns-in.patch
-delay-accounting-temporarily-enable-by-default.patch
-fix-ppc32-zimage-inflate.patch
-mce-section-fix.patch
-dvb-core-needs-i2c.patch
-git-dvb-radio-sf16fmi-build-fix.patch
-if-0-drivers-usb-input-hid-corechid_find_field_by_usage.patch
-drivers-usb-input-ati_remotec-autorepeat-fix.patch
-qla3xxx-NIC-driver.patch
-uli526x-driver-cleanups.patch
-stop-calling-phy_stop_interrupts-twice.patch
-git-net-selinux_xfrm_decode_session-build-fix.patch
-netlink-improve-string-attribute-validation.patch
-lockdep-split-the-skb_queue_head_init-lock-class.patch
-lockdep-split-the-skb_queue_head_init-lock-class-tidy.patch
-git-powerpc-briq_panel-Kconfig-fix.patch
-powerpc-use-check_irq_per_cpu.patch
-pcie-cleanup-on-probe-error.patch
-git-kbuild-build-fix.patch
-scsi-megaraid_mmmbox-64-bit-dma-capability-checker.patch
-scsi-megaraid_mmmbox-a-fix-on-inquiry-with-evpd.patch
-scsi-megaraid_mmmbox-a-fix-on-kernel-unaligned-access-address-issue.patch
-areca-raid-linux-scsi-driver.patch
-gregkh-usb-usb-at91-udc-updates-mostly-power-management.patch
-gregkh-usb-usb-at91-ohci-updates-mostly-power-management.patch
-kill-usb-kconfig-warning.patch
-git-wireless-bcm43xx-fix.patch
-ieee80211-tkip-requires-crc32.patch
-x86_64-mm-ieee1394-early.patch
-x86_64-mm-add-user-mode.patch
-x86_64-mm-int80-save-args.patch
-x86_64-mm-enlarge-debug-stack.patch
-x86_64-mm-backtrace-fallback.patch
-x86_64-mm-i386-backtrace-fallback.patch
-x86_64-mm-intel-no-tsc-in-c3.patch
-x86_64-mm-calgary-iommu-fix-off-by-one-error.patch
-x86_64-mm-calgary-iommu-multi-node-null-pointer-dereference-fix.patch
-x86_64-mm-remove-timer-fallback.patch
-x86_64-mm-revert-k8-bus-change.patch
-x86_64-mm-fix-swiotlb-force.patch
-fix-x86_64-mm-i386-backtrace-fallback.patch
-calgary-iommu-rearrange-struct-iommu_table.patch
-calgary-iommu-consolidate-per-bus-data.patch
-calgary-iommu-break-out-of.patch
-calgary-iommu-fix-error-path-memleak-in.patch
-calgary-iommu-fix-reference-counting-of.patch
-calgary-iommu.patch
-calgary-iommu-save-a-bit-of-space-in-bus_info.patch
-selinux-fix-memory-leak.patch
-selinux-fix-bug-in-security_compute_sid.patch
-synchronize_tsc-fixes.patch
-machine_kexecc-fix-the-description-of-segment-handling.patch
-kprobe-booster-disable-in-preemptible-kernel.patch
-i386-make-config_efi-depend-on-experimental.patch
-i386-switch_to-misplaced-parentheses.patch
-arch-alpha-use-array_size-macro.patch
-ia64-kprobe-invalidate-icache-of-jump-buffer.patch
-v850-remove-symbol-exports-which-duplicate-global-ones.patch
-v850-call-init_page_count-instead-of-set_page_count.patch
-invalidate_bdev-speedup.patch
-ide-touch-nmi-watchdog-during-resume-from-str.patch
-ide-touch-nmi-watchdog-during-resume-from-str-fix.patch
-lockdep-annotate-pktcdvd-natural-device-hierarchy.patch
-nbd-check-magic-before-doing-anything-else.patch
-nbd-abort-request-on-data-reception-failure.patch
-always-define-irq_per_cpu.patch
-panic_on_oops-remove-ssleep.patch
-replace-__devinit-with-__cpuinit-for-cpu-notifications.patch
-fix-hotplug-cpu-documentation-for-proper-usage.patch
-use-hotplug-version-of-registration-in-late-inits.patch
-fix-bad-macro-param-in-timerc.patch
-fix-cond_resched-fix.patch
-fix-kernel-api-doc-for-kernel-resourcec.patch
-kernel-doc-ignore-__devinit.patch
-pci-search-cleanups-add-to-kernel-apitmpl.patch
-add-docbook-documentation-for-workqueue-functions.patch
-doc-submittingpatches-cleanups.patch
-sgiioc4-always-share-irq.patch
-omap-fix-rng-driver-build.patch
-mdacon-fix-__init-section-warnings.patch
-pcmcia-fix-ioctl-for-get_status-and-get_configuration_info.patch
-pcmcia-fix-ioctl-get_configuration_info-for-pcmcia_cards.patch
-enable-mac-partition-label-per-default-on-pmac.patch
-hide-onboard-graphics-drivers-on-g5.patch
-hptiop-wrong-register-used-in-hptiop_reset_hba.patch
-pi-futex-robust-futex-exit.patch
-pi-futex-missing-pi_waiters-plist-initialization.patch
-add-linux-mm-mailing-list-for-memory-management-in.patch
-inotify-fix-deadlock-found-by-lockdep.patch
-fix-swsusp-with-pnp-bios.patch
-remove-incorrect-unlock_kernel-from-allocation.patch
-remove-incorrect-unlock_kernel-from-failure-path-in.patch
-add-entry-for-efs-filesystem-to-maintainers-as-orphan.patch
-ufs-remove-incorrect-unlock_kernel-from-failure-path-in-ufs_symlink.patch
-fix-typo-in-maintainers-s-devics-devices.patch
-typo-in-ub-clause-of-devicestxt.patch
-reducing-local_bh_enable-disable-overhead-in-irqtrace.patch
-add-parenthesis-around-arguments-in-the-sh_div-macro.patch
-reference-rt-mutex-design-in-rtmutexc.patch
-fix-kmem_cache_alloc-been-documented-twice.patch
-hwrng-fix-intel-probe-error-unwind.patch
-hwrng-fix-geode-probe-error-unwind.patch
-vdso-hash-style-fix.patch
-fbdev-statically-link-the-framebuffer-notification-functions.patch
-radeonfb-sleep-fixes.patch
-powermac-more-powermac-backlight-fixes.patch
-powermac-more-powermac-backlight-fixes-fix.patch
-nvidiafb-remove-redundant-config_pci-check.patch
-rivafb-nvidiafb-race-between-register_framebuffer-and-_bl_init.patch

 Merged into mainline or a subsystem tree.

+make-suspend-possible-with-a-traced-process-at-a-breakpoint.patch
+drivers-edac-edac_mch-must-include-linux-platform_deviceh.patch
+bug-in-futex-unqueue_me.patch
+ufs-ufs_get_locked_patch-race-fix.patch
+ufs-handle-truncated-pages.patch
+crash-in-aty128_set_lcd_enable-on-powerbook.patch
+i_mutex-does-not-need-to-be-locked-in-reiserfs_delete_inode.patch
+omap-rng-build-fix.patch
+md-fix-a-bug-that-recently-crept-into-md-linear.patch
+ptrace-make-pid-of-child-process-available-for.patch
+fix-vmstat-per-cpu-usage.patch
+vt-printk-fix-framebuffer-console-triggering-might_sleep.patch
+au1100fb-info-varrotate-fix.patch
+au1100fb-fix-startup-sequence.patch
+fadvise-make-posix_fadv_noreuse-a-no-op.patch
+debug_locksh-add-struct-task_struct.patch
+knfsd-fix-race-related-problem-when-adding-items-to-and-svcrpc-auth-cache.patch
+doc-update-panic_on_oops-documentation.patch
+x86_64-fix-more-per-cpu-typos.patch
+pseries-hvsi-char-driver-null-pointer-deref.patch
+pseries-hvsi-char-driver-janitorial-cleanup.patch
+eicon-fix-define-conflict-with-ptrace.patch
+sh-fix-proc-file-removal-for-superh-store-queue-module.patch
+ieee1394-sbp2-enable-auto-spin-up-for.patch
+fix-befs-slab-corruption.patch
+memory-hotadd-fixes-not-aligned-memory-hotadd.patch
+memory-hotadd-fixes-change-find_next_system_rams.patch
+memory-hotadd-fixes-find_next_system_ram-catch-range.patch
+memory-hotadd-fixes-avoid-check-in-acpi.patch
+memory-hotadd-fixes-avoid-registering-res-twice.patch
+memory-hotadd-fixes-enhance-collistion-check.patch
+fix-reiserfs-lock-inversion-of-bkl-vs-inode-semaphore.patch
+reiserfs_write_full_page-should-not-get_block-past-eof.patch
+futex-apply-recent-futex-fixes-to-futex_compat.patch
+udf-initialize-parts-of-inode-earlier-in-create.patch
+scx200_acbeliminate-spurious-timeout-errors.patch

 2.6.18 queue.

+tty-layer-comment-the-locking-assumptions-and-functions.patch
+fix-tty-layer-dos-and-comment-relevant-code.patch

 Probably-2.6.18 queue.

+acpi-fix-printk-format-warnings.patch
+cleanup-fix-for-potential-crash-of-hotkeyc.patch
+kernel-bug-fixing-for-kernel-kmodc.patch
+acpi-sci-interrupt-source-override.patch

 ACPi fixes

+git-block-dasd-fix.patch
+git-block-dasd-fix-2.patch

 Fix git-block.patch

+gregkh-driver-add-stable-branch-to-maintainers-file.patch
+gregkh-driver-udev-devices.patch
+gregkh-driver-misc-devices.patch
+gregkh-driver-tty-device.patch
+gregkh-driver-vt-device.patch
+gregkh-driver-vc-device.patch
+gregkh-driver-raw-device.patch
+gregkh-driver-msr-device.patch
+gregkh-driver-cpuid-device.patch
+gregkh-driver-usb-move-usb_device_class-class-devices-to-be-real-devices.patch
+gregkh-driver-usb-convert-usb-class-devices-to-real-devices.patch
+gregkh-driver-pci-multithreaded-probe.patch

 driver tree updates

+revert-gregkh-driver-tty-device.patch
+revert-gregkh-driver-mem-devices.patch

 Fix it.

+return-code-checking-for-make_class_name.patch

 More return-code error checking

-git-dvb.patch
-git-dvb-fixup.patch

 I'm presently unable to get a clean pull from the DVB tree.

+remove-null-chars-from-dvb-names.patch

 DVB cleanup

+gregkh-i2c-hwmon-w83627ehf-add-pwm-support.patch
+gregkh-i2c-hwmon-w83627ehf-documentation.patch

 I2C tree updates

+i2c-build-fixes-tps65010.patch

 I2C fix.

-git-geode-fixup.patch

 Unneeded

+ia64-panic-if-topology_init-kzalloc-fails.patch

 ia64 fixlet.

-logips2pp-fix-mx300-button-layout-fix.patch

 Folded into logips2pp-fix-mx300-button-layout.patch

+remove-polling-timer-from-i8042-v2.patch

 input cleanup

+rework-legacy-handling-to-remove-much-of-the-cruft-fix-2.patch
+add-full-compact-flash-support-to-libata.patch
+via-sata-oops-on-init.patch
+asus-mv-device-ids.patch

 PATA/ATA things.

+forcedeth-move-mac-address-setup-teardown.patch
+forcedeth-mac-address-corrected.patch
+forcdeth-revised-napi-support.patch
+lockdep-fix-smc91x.patch
+via-rhine-add-option-avoid_d3-work-around-broken-bioses.patch
+build-fixes-smc91x.patch

 netdev updates

+git-net-fib_rules-linkage-fix.patch

 Fix git-net.patch

+ppp-handle-kmalloc-failures-leak-tweaks.patch

 Fix ppp-handle-kmalloc-failures.patch some more.

+xt_physdev-build-fix.patch
+security-selinux-hooksc-make-4-functions-static.patch
+fix-memory-leak-in-net-ipv4-tcp_probectcpprobe_read.patch
+pktgen-oops-when-used-with-balance-tlb-bonding.patch

 Net things.

+add-newline-to-nfs-dprintk.patch

 bfs fixlet.

+git-r8169.patch

+git-block-vs-git-sas.patch

 Make git-sas.patch and git-block.patch play nicely together.

+tickle-nmi-watchdog-on-serial-output.patch

 Avoid NMI watchdog expiries.

+gregkh-pci-pci-use-pci_bios-as-last-fallback.patch
+gregkh-pci-pci-express-aer-implemetation-aer-howto-document.patch
+gregkh-pci-pci-express-aer-implemetation-export-pcie_port_bus_type.patch
+gregkh-pci-pci-express-aer-implemetation-aer-core-and-aerdriver.patch
+gregkh-pci-pci-express-aer-implemetation-pcie_portdrv-error-handler.patch

 PCI tree updates.

+fix-gregkh-pci-pci-express-aer-implemetation-pcie_portdrv-error-handler.patch

 Fix it.

+git-scsi-target-vs-git-block.patch

 Make git-scsi-target.patch play nicely with git-block.patch.

+gregkh-usb-usb-kill-usb-kconfig-warning.patch
+gregkh-usb-usb-make-usb_buffer_free-null-safe.patch
+gregkh-usb-usbcore-add-configuration_string-to-attribute-group.patch
+gregkh-usb-usb-add-driver-for-phidgetmotorcontrol.patch
+gregkh-usb-usb-put-phidgets-driver-in-a-sysfs-class.patch
+gregkh-usb-usb-usbtouchscreen-version-0.4.patch
+gregkh-usb-usb-pl2303-removes-unneeded-goto.patch
+gregkh-usb-usb-pl2303-remove-80-columns-limit-violations-in-pl2303-driver.patch
+gregkh-usb-usb-pl2303-cosmetic-changes-to-pl2303_buf_-clear-data_avail.patch
+gregkh-usb-usb-pl2303-reduce-number-of-prototypes.patch
+gregkh-usb-usb-pl2303-cosmetic-changes-to-quirk.patch
+gregkh-usb-usb-usbnet-add-unlink_rx_urbs-call-to-allow-for-jumbo-frames.patch
+gregkh-usb-usb-asix-add-ax88178-support-and-many-other-changes.patch

 USB tree updates.

+properly-unregister-reboot-notifier-in-case-of-failure-in-ehci-hcd.patch
+quickcam_messenger-compilation-fix.patch

 USB fixes.

+x86_64-mm-i386-defconfig-update.patch
+x86_64-mm-i386-remove-const-rwlock.patch
+x86_64-mm-fix-align.patch
+x86_64-mm-aux_device_info-is-one-byte-long,-use-movb.patch
+x86_64-mm-initialize-end-of-memory-variables-as-early-as.patch
+x86_64-mm-remove-int_delivery_dest.patch
+x86_64-mm-i386-end-of-memory.patch
+x86_64-mm-kernel-stack-doc.patch
+x86_64-mm-calgary-rearrange-struct-iommu_table.patch
+x86_64-mm-calgary-consolidate-per-bus-data.patch
+x86_64-mm-calgary-break-out-of.patch
+x86_64-mm-calgary-fix-error-path-memleak-in.patch
+x86_64-mm-calgary-fix-reference-counting-of.patch
+x86_64-mm-calgary-init-one.patch
+x86_64-mm-calgary-save-a-bit-of-space-in-bus_info.patch
+x86_64-mm-i386-remove-lock-section.patch
+x86_64-mm-remove-lock-section.patch
+x86_64-mm-fix-is_at_popf-for-compat-tasks.patch
+x86_64-mm-annotate-lib.patch
+x86_64-mm-fix-gdt-table-size-in-trampoline.s.patch
+x86_64-mm-remove-superflous-bug_ons-in-nommu-and-gart.patch
+x86_64-mm-remove-lock-prefix-from-is_at_popf-tests.patch
+x86_64-mm-early-cpu-identify.patch
+x86_64-mm-allow-early_param-and-identical-__setup-to-exist.patch
+x86_64-mm-i386-early-param.patch
+x86_64-mm-early-param.patch
+x86_64-mm-move-acpi-disabled.patch
+x86_64-mm-move-acpi-numa.patch
+x86_64-mm-move-e820map.patch
+x86_64-mm-vsyscall-sparse.patch
+x86_64-mm-fault-sparse.patch
+x86_64-mm-sys_ia32-sparse.patch
+x86_64-mm-aout-sparse.patch
+x86_64-mm-iommu-setup-style.patch
+x86_64-mm-replace-local_save_flags+local_irq_disable-with.patch
+x86_64-mm-acpi-remove-extern.patch
+x86_64-mm-tf-iret.patch
+x86_64-mm-print-whether-config_iommu_debug-is.patch
+x86_64-mm-only-verify-the-allocation-bitmap-if.patch
+x86_64-mm-remove-tce_cache_blast_stress.patch
+x86_64-mm-eradicate-sole-remaining-80-chars.patch
+x86_64-mm-fix-dubious-segment-register-clear-in-cpu_init.patch
+x86_64-mm-dont-taint-up-k7s-running-smp-kernels..patch
+x86_64-mm-i386-kprobes-error_code.patch
+x86_64-mm-kprobes-error_code.patch
+x86_64-mm-monotonic-clock.patch

 x86_64 tree updates (includes increasing amounts of i386 work)

+x86_64-mm-early-param-fix.patch
+fix-x86_64-mm-i386-semaphore-to-asm-uml-fix.patch

 Fix it.

+initialize-ieee1394-early-when-built-in.patch

 1394 debuggability enhancement.

+hot-add-mem-x86_64-acpi-motherboard-fix.patch
+hot-add-mem-x86_64-fixup-externs.patch
+hot-add-mem-x86_64-kconfig-changes.patch
+hot-add-mem-x86_64-enable-sparsemem-in-sratc.patch
+hot-add-mem-x86_64-memory_add_physaddr_to_nid-enable.patch
+hot-add-mem-x86_64-memory_add_physaddr_to_nid-node-fixup.patch
+hot-add-mem-x86_64-memory_add_physaddr_to_nid-node-fixup-fix.patch
+hot-add-mem-x86_64-x86_64-kernel-mapping-fix.patch
+hot-add-mem-x86_64-use-config_memory_hotplug_sparse.patch
+hot-add-mem-x86_64-use-config_memory_hotplug_reserve.patch
+hot-add-mem-x86_64-valid-add-range-check.patch

 x86_64 mmeory hotadd.

+git-geode-vs-git-cryptodev.patch

 Make git-geode.patch and git-cryptodev.patch play nicely together.

+reduce-max_nr_zones-move-highmem-counters-into-highmemc-h-fix.patch

 Fix reduce-max_nr_zones-move-highmem-counters-into-highmemc-h.patch

+reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-fix.patch

 Fix reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment.patch
 some more.

+mempolicies-fix-policy_zone-check.patch
+apply-type-enum-zone_type.patch
+linearly-index-zone-node_zonelists.patch

 NUMA memory policy fixes.

+cpu-hotplug-compatible-alloc_percpu-fix.patch
+cpu-hotplug-compatible-alloc_percpu-fix-2.patch

 Fix cpu-hotplug-compatible-alloc_percpu.patch

+mm-remove_mapping-safeness.patch
+mm-non-syncing-lock_page.patch
+slab-respect-architecture-and-caller-mandated-alignment.patch
+mm-swap-write-failure-fixup.patch
+mm-swap-write-failure-fixup-update.patch
+mm-swap-write-failure-fixup-fix.patch
+oom-use-unreclaimable-info.patch
+oom-reclaim_mapped-on-oom.patch
+cpuset-oom-panic-fix.patch
+oom-cpuset-hint.patch
+oom-handle-current-exiting.patch
+oom-handle-oom_disable-exiting.patch
+oom-swapoff-tasks-tweak.patch
+oom-kthread-infinite-loop-fix.patch
+oom-more-printk.patch
+bootmem-use-max_dma_address-instead-of-low32limit.patch
+add-some-comments-to-slabc.patch
+update-some-mm-comments.patch
+slab-optimize-kmalloc_node-the-same-way-as-kmalloc.patch
+slab-optimize-kmalloc_node-the-same-way-as-kmalloc-fix.patch

 Memory management updates.

+selinux-eliminate-selinux_task_ctxid.patch
+selinux-rename-selinux_ctxid_to_string.patch
+selinux-replace-ctxid-with-sid-in.patch

 SELinux updates.

+avr32-use-autoconf-instead-of-marker.patch
+avr32-dont-assume-anything-about-max_nr_zones.patch
+avr32-add-i-o-port-access-primitives.patch
+avr32-use-linux-pfnh.patch
+avr32-kill-config_discontigmem-support-completely.patch
+avr32-fix-bug-in-__avr32_asr64.patch

 avr32 arch updates.

+add-force-of-use-mmconfig-fix-2.patch

 x86/mac fixes.

+add-efi-e820-memory-mapping-on-x86-fix-2.patch
+use-bug_onfoo-instead-of-if-foo-bug-in-include-asm-i386-dma-mappingh.patch
+x86-increase-max_mp_busses-on-default-arch.patch
+apm-clean-up-module-initalization.patch
+x86-remove-locally-defined-ldt-structure-in-favour-of-standard-type.patch
+x86-implement-always-locked-bit-ops-for-memory-shared-with-an-smp-hypervisor.patch
+x86-allow-a-kernel-to-not-be-in-ring-0.patch
+x86-replace-sensitive-instructions-with-macros.patch
+x86-roll-all-the-cpuid-asm-into-one-__cpuid-call.patch
+x86-make-__fixaddr_top-variable-to-allow-it-to-make-space-for-a-hypervisor.patch
+x86-add-a-bootparameter-to-reserve-high-linear-address-space.patch
+x86-put-note-sections-into-a-pt_note-segment-in-vmlinux.patch
+x86-enable-vmsplit-for-highmem-kernels.patch
+x86-trivial-pgtableh-__assembly__-move.patch
+x86-trivial-move-of-__have-macros-in-i386-pagetable-headers.patch
+x86-trivial-move-of-ptep_set_access_flags.patch
+x86-remove-unused-include-from-efi_stubs.patch

 x86 updates.

+disable-cpu-hotplug-during-suspend-2.patch
+swsusp-fix-mark_free_pages.patch
+swsusp-reorder-memory-allocating-functions.patch
+swsusp-fix-alloc_pagedir.patch

 swsusp updates.

+uml-use-klibc-setjmp-longjmp.patch
+uml-use-array_size-more-assiduously.patch
+uml-fix-stack-alignment.patch
+uml-whitespace-fixes.patch
+uml-fix-handling-of-failed-execs-of-helpers.patch
+uml-improve-sigbus-diagnostics.patch
+uml-sigio-cleanups.patch
+uml-move-signal-handlers-to-arch-code.patch
+uml-timer-cleanups.patch
+uml-remove-unused-variable.patch

 UML updates.

+s390-fix-cmm-kernel-thread-handling.patch

 s390 fix.

-apple-motion-sensor-driver.patch

 Dropped, updated.

+scsi-early-detection-of-medium-not-present-updated.patch

 Fix scsi patches in -mm,

+make-touch_nmi_watchdog-imply-touch_softlockup_watchdog-on-fix.patch

 Fix make-touch_nmi_watchdog-imply-touch_softlockup_watchdog-on.patch

-net-use-warn_on_once-for-checksum-checks.patch

 Unneeded.

+omap-add-keypad-driver-4.patch
+omap-update-omap1-2-boards-to-give-keymapsize-and-other.patch
+usb-build-fixes-ohci-omap.patch

 OMAP fixes.

+bluetooth-use-gfp_atomic-in-_sock_creates-sk_alloc.patch
+require-mmap-handler-for-aout-executables.patch
+module_subsys-initialize-earlier.patch
+fuse-use-dentry-in-statfs.patch
+vfs-define-new-lookup-flag-for-chdir.patch
+timer-add-lock-annotation-to-lock_timer_base.patch
+headers_check-improve-include-regexp.patch
+headers_check-clarify-error-message.patch
+dmi-decode-and-save-oem-string-information.patch
+remove-unused-tty_struct-variable.patch
+ignore-partition-table-on-disks-with-aix-label.patch
+#aio-remove-unused-aio_run_iocbs.patch
+task_struct-ifdef-missedem-v-ipc.patch
+ifdef-blktrace-debugging-fields.patch
+mount-udf-udf_part_flag_read_only-partitions-with-ms_rdonly.patch
+fix-intel-rng-detection.patch
+rtmutex-clean-up-and-remove-some-extra-spinlocks.patch
+oom_adj-oom_score-documentation.patch
+fix-kerneldoc-comments-in-kernel-timerc.patch
+there-is-no-devfs-there-has-never-been-a-devfs-we-have.patch
+hdaps-handle-errors-from-input_register_device.patch
+move-valid_dma_direction-from-x86_64-to-generic-code.patch
+move-valid_dma_direction-from-x86_64-to-generic-code-fix.patch
+use-valid_dma_direction-in-include-asm-i386-dma-mappingh.patch
+lsm-remove-bsd-secure-level-security-module.patch
+tty_ioc-keep-davej-sane.patch
+apple-motion-sensor-driver-2.patch
+apple-motion-sensor-driver-2-fixes-update.patch
+# might be unneeded: rtc-add-rtc-class-interface-to-m41t00-driver.patch
+fix-bounds-check-bug-in-__register_chrdev_region.patch
+single-bit-flip-detector.patch
+single-bit-flip-detector-tidy.patch
+ucb1x00-ts-handle-errors-from-input_register_device.patch
+console-utf-8-mode-fixes.patch
+make-reiserfs-default-to-barrier=flush.patch
+make-ext3-mount-default-to-barrier=1.patch
+reiserfs_fsync-should-only-use-barriers-when-they-are-enabled.patch
+fix-reiserfs-latencies-caused-by-data=ordered.patch
+ifdef-quota_read-quota_write.patch
+workqueue-remove-lock_cpu_hotplug.patch

 Misc patches queue.

+add-vector-aio-support.patch
+add-vector-aio-support-fix.patch

 AIO vectored IO support.

-task-watchers-task-watchers.patch
-task-watchers-register-process-events-task-watcher.patch
-task-watchers-refactor-process-events.patch
-task-watchers-make-process-events-configurable-as.patch
-task-watchers-allow-task-watchers-to-block.patch
-task-watchers-register-audit-task-watcher.patch
-task-watchers-register-per-task-delay-accounting.patch
-task-watchers-register-profile-as-a-task-watcher.patch
-task-watchers-add-support-for-per-task-watchers.patch
-task-watchers-register-semundo-task-watcher.patch
-task-watchers-register-per-task-semundo-watcher.patch

 Dropped - a nice change, but I don't think we can justify the runtime cost.

+csa-basic-accounting-over-taskstats.patch
+csa-extended-system-accounting-over-taskstats.patch
+csa-convert-config-tag-for-extended-accounting-routines.patch

 Comprehensive System Accounting.

+fs-cache-provide-a-filesystem-specific-syncable-page-bit.patch
+fs-cache-generic-filesystem-caching-facility.patch
+fs-cache-release-page-private-in-failed-readahead.patch
+fs-cache-make-kafs-use-fs-cache.patch
+fs-cache-make-kafs-use-fs-cache-vs-streamline-generic_file_-interfaces-and-filemap.patch
+nfs-use-local-caching.patch
+fs-cache-cachefiles-ia64-missing-copy_page-export.patch
+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem.patch
+autofs-make-sure-all-dentries-refs-are-released-before-calling-kill_anon_super.patch
+vfs-destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch

 cachefs and cachefiles, yet again.

+cpumask-add-highest_possible_node_id.patch
+cpumask-export-cpu_online_map-and-cpu_possible_map.patch
+cpumask-export-node_to_cpu_mask-consistently.patch

 cpumask layer enhancements to support the knfsd NUMA enhancements.

+knfsd-have-ext2-reject-file-handles-with-bad-inode-numbers-early.patch
+knfsd-have-ext2-reject-file-handles-with-bad-inode-numbers-early-tidy.patch
+knfsd-make-ext3-reject-filehandles-referring-to-invalid-inode-numbers.patch
+knfsd-make-ext3-reject-filehandles-referring-to-invalid-inode-numbers-tidy.patch
+knfsd-drop-serv-option-to-svc_recv-and-svc_process.patch
+knfsd-drop-serv-option-to-svc_recv-and-svc_process-nfs-callback-fix-nfs-callback-fix.patch
+knfsd-check-return-value-of-lockd_up-in-write_ports.patch
+knfsd-move-makesock-failed-warning-into-make_socks.patch
+knfsd-correctly-handle-error-condition-from-lockd_up.patch
+knfsd-move-tempsock-aging-to-a-timer.patch
+knfsd-move-tempsock-aging-to-a-timer-tidy.patch
+knfsd-convert-sk_inuse-to-atomic_t.patch
+knfsd-use-new-lock-for-svc_sock-deferred-list.patch
+knfsd-convert-sk_reserved-to-atomic_t.patch
+knfsd-test-and-set-sk_busy-atomically.patch
+knfsd-split-svc_serv-into-pools.patch
+knfsd-add-svc_get.patch
+knfsd-add-svc_set_num_threads.patch
+knfsd-use-svc_set_num_threads-to-manage-threads-in-knfsd.patch
+knfsd-make-rpc-threads-pools-numa-aware.patch
+knfsd-make-rpc-threads-pools-numa-aware-fix.patch
+knfsd-allow-admin-to-set-nthreads-per-node.patch

 nfsd updates.

+sched-force-sbin-init-off-isolated-cpus.patch
+sched-remove-unnecessary-sched-group-allocations.patch
+sched-remove-unnecessary-sched-group-allocations-fix.patch
+sched-dont-print-migration-cost-when-only-1-cpu.patch

 CPU scheduler changes.

+ecryptfs-fix-printk-format-warnings.patch

 ecryptfs fixlet.

+namespaces-add-nsproxy-avr32-fix.patch

 Fix avr32 for namespaces-add-nsproxy.patch

+readahead-state-based-method-aging-accounting-apply-type-enum-zone_type-readahead.patch

 Fix readahead-state-based-method-aging-accounting.patch for MM cleanup
 patches in -mm

+reiser4-write-via-do_sync_write.patch
+reiser4-fix-gcc-ws-compains.patch

 reiser4 updates.

+ide-reprogram-disk-pio-timings-on-resume.patch
+asus-mv-ide-device-ids.patch
+ide-support-for-via-8237a-southbridge.patch
+pcmcia-add-few-ids-into-ide-cs.patch

 IDE upates

+au1100fb-add-option-to-enable-disable-the-cursor.patch
+intelfb-documentation-update.patch
+rivafb-use-constants-instead-of-magic-values.patch
+vfb-document-option-to-enable-the-driver.patch
+fbdev-add-generic-ddc-read-functionality.patch
+nvidiafb-use-generic-ddc-reading.patch
+rivafb-use-generic-ddc-reading.patch
+i810fb-use-generic-ddc-reading.patch
+savagefb-use-generic-ddc-reading.patch
+radeonfb-use-generic-ddc-reading.patch
+intelfbhwc-intelfbhw_get_p1p2-defined-but-not-used.patch
+add-imacfb-documentation-and-detection.patch
+fbcon-use-persistent-allocation-for-cursor-blinking.patch

 fbdev updates

+md-the-scheduled-removal-of-the-start_array-ioctl-for-md.patch
+md-fix-a-comment-that-is-wrong-in-raid5h.patch
+md-factor-out-part-of-raid1d-into-a-separate-function.patch
+md-factor-out-part-of-raid10d-into-a-separate-function.patch
+md-replace-magic-numbers-in-sb_dirty-with-well-defined-bit-flags.patch
+md-remove-the-working_disks-and-failed_disks-from-raid5-state-data.patch
+md-remove-working_disks-from-raid10-state.patch
+md-remove-working_disks-from-raid1-state-data.patch
+md-improve-locking-around-error-handling.patch

 RAID updates.

+genirq-x86_64-irq-make-vector_irq-per-cpu-warning-fix.patch

 Fix genirq-x86_64-irq-make-vector_irq-per-cpu.patch some more.

+srcu-report-out-of-memory-errors.patch
+srcu-report-out-of-memory-errors-fixlet.patch
+cpufreq-make-the-transition_notifier-chain-use-srcu.patch

 Use the SRCU infrastructure to fix a cpufreq notifier chain.

-revert-tty-buffering-comment-out-debug-code.patch

 Dropped due to rejects.

-serial-core-adds-atomic-context-debug-code.patch

 Dropped this debug patch: no longer needed.

+restore-rogue-readahead-printk.patch

 Put a useful debug patch back.




All 1136 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm1/patch-list


