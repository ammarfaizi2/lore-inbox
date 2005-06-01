Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVFAJbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVFAJbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFAJbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:31:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:24535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261346AbVFAJ3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:29:24 -0400
Date: Wed, 1 Jun 2005 02:28:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-mm2
Message-Id: <20050601022824.33c8206e.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm2/


- Dropped bk-acpi.patch.  Too old, too much breakage.

- A few more subsystem trees have moved to using git

- There are a large number of patches here which fix patches which people
  have already sent.  A very large number.  Are we getting a bit careless?



Changes since 2.6.12-rc5-mm1:


-v4l-bttv-i2c-oops-fix.patch
-ipmi-build-fix.patch
-x86_64-config_bug=n-fixes.patch
-ib-allow-null-sa_query-callbacks.patch
-ib-fix-potential-ib_umad-leak.patch
-ib-fix-endianness-of-path-record-mtu-field.patch
-make-sure-therm_adt746x-only-handles-known-hardware.patch
-therm_adt746x-show-correct-sensor-locations.patch
-drivers-firmware-pcdpc-build-fix.patch
-natsemi-multicast-initialisation-fix.patch
-r8169-new-pci-id.patch
-r8169-de-obfuscate-supported-pci-id.patch
-r8169-identify-the-napi-version.patch
-r8169-add-module-parameter-description-for-copybreak.patch
-r8169-add-module-parameter-description-for-the-media-option.patch
-r8169-ethtool-message-level-control-support.patch
-r8169-ethtool-support-for-dumping-the-chip-statistics.patch
-r8169-cleanup-function-args.patch
-git-scsi-misc-build-fix.patch
-git-scsi-misc-sbp2-warning-fix.patch
-mystery-ide-fix.patch
-dm9000-network-driver.patch
-fix-promisc-bridging-in-tlan-driver.patch
-iseries_veth-dont-send-packets-to-lpars-which-arent-up.patch
-iseries_veth-set-dev-trans_start-so-watchdog-timer-works-right.patch
-iseries_veth-dont-leak-skbs-in-rx-path.patch
-iseries_veth-cleanup-skbs-to-prevent-unregister_netdevice-hanging.patch
-ppc32-small-cpufreq-update.patch
-ppc32-fix-uimage-make-target-to-report-success-correctly.patch
-ppc32-fix-some-minor-issues-related-to-fsl-book-e-kgdb.patch
-ppc32-fix-alsa-powermac-driver-on-old-machines.patch
-ppc32-add-via-ide-support-to-mpc8555-cds-platform.patch
-ppc32-support-for-82xx-pqii-on-chip-pci-bridge.patch
-uml-add-modversions-support.patch
-uml-add-mod_license-to-random-driver.patch
-uml-split-config_frame_pointer-from-debug_info.patch
-uml-stack-dump-fix.patch
-timeout-at-boottime-with-nec3500a-and-others-when-inserted-a-cd-in-it.patch

 Merged

+fix-ide-scsi-eh-locking.patch

 ide-scsi locking fix

+ext3-fix-log_do_checkpoint-assertion-failure.patch
+ext3-fix-list-scanning-in-__cleanup_transaction.patch

 ext3 fixes

+smp_processor_id-cleanup.patch
+smp_processor_id-cleanup-fix.patch

 Clean up the _smp_processor_id() implementation

+i386-cpu-hotplug-updated-for-mm-smp_processor_id-cleanup-fix.patch
+sibling-map-initializing-rework-smp_processor_id-cleanup-fix.patch
+cpu-state-clean-after-hot-remove-smp_processor_id-cleanup-fix.patch
+detect-soft-lockups-smp_processor_id-cleanup-fix.patch
+timers-fixes-improvements-smp_processor_id-cleanup-fix.patch

 Fix various patches in -mm for the above.

-bk-acpi.patch

 Dropped

-ipmi-and-acpi=offht-acpi-get-firmware-failurepatch.patch
-ipmi-and-acpi=offht-ipmi_si_intf-acpi-disabled.patch

 Dropped due to bk-acpi droppage
 
-alsa-3073.patch
-alsa-3074.patch
-alsa-3075.patch
-alsa-3076.patch
-alsa-3077.patch
-alsa-3078.patch
-alsa-3079.patch
-alsa-3080.patch
-alsa-3081.patch
-alsa-3082.patch
-alsa-3083.patch
-alsa-3084.patch
-alsa-3085.patch
-alsa-3086.patch
-alsa-3087.patch
-alsa-3088.patch
-alsa-3091.patch
-alsa-3092.patch
-alsa-3093.patch
-alsa-3094.patch
-alsa-3095.patch
-alsa-3096.patch
-alsa-3097.patch
-alsa-3098.patch
-alsa-3099.patch
-alsa-3100.patch
-alsa-3101.patch
-alsa-3102.patch
-alsa-3103.patch
-alsa-3104.patch
-alsa-3105.patch
-alsa-3106.patch
-alsa-3107.patch
-alsa-3108.patch
-alsa-3111.patch
-alsa-3112.patch
-alsa-3113.patch
-alsa-3114.patch
-alsa-3115.patch
-alsa-3116.patch
-alsa-3117.patch
-alsa-3118.patch
-alsa-3119.patch
-alsa-3120.patch
-alsa-3121.patch
-alsa-3122.patch
-alsa-3123.patch
-alsa-3126.patch
-alsa-3128.patch
-alsa-3129.patch
-alsa-3130.patch
-alsa-3131.patch
-alsa-3132.patch
-alsa-3133.patch
-alsa-3134.patch
-alsa-3135.patch
-alsa-3136.patch
-alsa-3137.patch
-alsa-3138.patch
-alsa-3139.patch
-alsa-3140.patch
-alsa-3141.patch
-alsa-3142.patch
-alsa-3143.patch
-alsa-3144.patch
-alsa-3145.patch
-alsa-3146.patch
-alsa-3147.patch
-alsa-3148.patch
-alsa-3149.patch
-alsa-3150.patch
-alsa-3151.patch
-alsa-3152.patch
-alsa-3153.patch
-alsa-3154.patch
-alsa-3155.patch
-alsa-3156.patch
-alsa-3157.patch
-alsa-3158.patch
-alsa-3159.patch
-alsa-3160.patch
-alsa-3161.patch
-alsa-3162.patch
-alsa-3163.patch
-alsa-3164.patch
-alsa-3165.patch
-alsa-3166.patch
-alsa-3167.patch
+git-alsa.patch

 ALSA development now has a git tree

-cpufreq-CPUFREQ-01-powernow-k7-No-FSB-KHz.patch
-cpufreq-CPUFREQ-02-core-reduce-warning-msgs.patch
-cpufreq-CPUFREQ-03-speedstep-centrino-P4M-HT-support.patch
-cpufreq-CPUFREQ-04-ondemand-cleanups.patch
-cpufreq-CPUFREQ-05-speedstep-smi-p4m.patch
-cpufreq-CPUFREQ-06-default-governor-warning.patch
-cpufreq-CPUFREQ-07-AMD-Elan-driver.patch
-cpufreq-CPUFREQ-11-recalibrate-cpu_khz.patch
-cpufreq-CPUFREQ-12-recalibrate-cpu_khz-2.patch
-cpufreq-CPUFREQ-13-static-cpufreq_gov_dbs.patch
-cpufreq-CPUFREQ-14-powernow-k8-dualcore.patch
-cpufreq-CPUFREQ-15-transition-latency-thinko.patch
-cpufreq-CPUFREQ-16-conservative-governer.patch
-cpufreq-CPUFREQ-17-ondemand-ignore-nice.patch
-cpufreq-CPUFREQ-18-ondemand-check-rate-and-break-out.patch
-cpufreq-CPUFREQ-19-ondemand-sys_freq_step.patch
-cpufreq-CPUFREQ-21-ondemand-cleanups.patch
-cpufreq-CPUFREQ-22-ondemand-store-idle-ticks-for-all-cpus.patch
-cpufreq-CPUFREQ-23-ondemand-idle_tick-cleanup.patch
-cpufreq-CPUFREQ-24-ondemand-automatic-downscaling.patch
-cpufreq-CPUFREQ-25-ondemand-default-sampling-downfactor.patch
-cpufreq-CPUFREQ-26-longhaul-disable-mastering.patch
-cpufreq-CPUFREQ-27-longhaul-magic-port-frobbing.patch
-cpufreq-CPUFREQ-28-longhaul-transition-latency.patch
-cpufreq-CPUFREQ-29-longhaul-icky-evil-nasty-ide-dma-wait.patch
-cpufreq-CPUFREQ-30-speedstep-lib-typos.patch
+git-cpufreq.patch

 As does cpufreq

+gregkh-i2c-i2c-tps6501x.patch
+gregkh-i2c-i2c-docs-update-1.patch
+gregkh-i2c-i2c-docs-update-2.patch
+gregkh-i2c-i2c-docs-update-3.patch

 i2c tree updated

-bk-input.patch
+git-input.patch

 The input tree is now in git

-git-ipsec.patch

 The ipsec code is in git-net.patch

+git-libata-adma.patch
+git-libata-ahci-msi.patch
+git-libata-bridge-detect.patch
+git-libata-chs-support.patch
+git-libata-docs.patch
+git-libata-svw.patch
+git-libata-promise-sata-pata.patch
+git-libata-pdc2027x.patch

 libata development trees

+git-net.patch

 This is davem's post-2.6.12 tree

-git-netdev-8139cp.patch
-git-netdev-amd8111.patch
-git-netdev-e100.patch
-git-netdev-e1000.patch
-git-netdev-forcedeth.patch
-git-netdev-ieee80211.patch
+git-netdev-dm9000.patch
+git-netdev-hdlc.patch
-git-netdev-ixgb.patch
-git-netdev-orinoco.patch
+git-netdev-orinoco-hch.patch
-git-netdev-sis900.patch
-git-netdev-wifi.patch
+git-netdev-viro.patch
+git-netdev-we18-ieee80211-wifi.patch

 Various things added and merged in netdev land.

+is_multicast_ether_addr-hack.patch
+wireless-device-attr-fixes.patch
+wireless-device-attr-fixes-2.patch
+ipw2100-old-gcc-fix.patch

 Fix 'em up.

+tcp-fastroute-stats-remove.patch
+tcp-no-congestion.patch
+tcp-no-throttle.patch
+tcp-bigger-backlog.patch
+tcp-fix-weightp.patch
+tcp-tcp_super_tso_v3.patch
+tcp-tcp_infra.patch
+tcp-tcp_bic.patch
+tcp-tcp_westwood.patch
+tcp-hstcp.patch
+tcp-hybla.patch
+tcp-vegas.patch
+tcp-h-tcp.patch

 Steve Hemminger's TCP enhancements.

+tcp-tcp_westwood-kconfig-fix.patch

 Fix it.

+git-ocfs-fix-for-shemminger-tcp-stuff.patch

 Fix OCFS for it, too.

+gregkh-pci-pci-hotplug-shpchp-_HPP-fix.patch
+gregkh-pci-pci-hotplug-shpchp-PERR-fix.patch
+gregkh-pci-pci-amd74xx-ids.patch
+gregkh-pci-pci-cpci-update.patch

 PCI devel tree updates

+pci-do-via-irq-fixup-always-not-just-in-pic-mode.patch

 VIA PCI fix

+git-scsi-misc-mptfusion-fix.patch
+git-scsi-misc-qla-build-fix.patch

 Fix things in git-scsi-misc

+git-scsi-rc-fixes.patch

 Pending 2.6.12 scsi fixes

+gregkh-usb-usb-sl811-hcd-fixes.patch
+gregkh-usb-usb-sl811_cs.patch
+gregkh-usb-usb-cp2101-flow-control.patch
+gregkh-usb-usb-usbatm-reduce-log-spam.patch
+gregkh-usb-usb-usbatm-avoid-oops-on-bind-failure.patch
+gregkh-usb-usb-gadget-drain-rndis.patch

 USB devel tree updated

+gregkh-usb-usb-usbatm-1-fix.patch

 Fix it.

-zd1201-build-fix.patch

 Drop this workaround again.

+sparsemem-memory-model-fix-3.patch

 Fix sparsemem-memory-model.patch even more

+add-page_state-info-to-show_mem.patch
+add-page_state-info-to-show_mem-warning-fixes.patch

 Extra info in the sysrq-M output.

+avoiding-mmap-fragmentation-fix-3.patch

 Fix avoiding-mmap-fragmentation-fix.patch again.

 mmap-topdown-fix-for-large-stack-limit-large-allocation.patch

+x25-selective-sub-address-matching-with.patch
+x25-selective-sub-address-matching-with-fix.patch

 x25 feature work

+x25-fast-select-with-no-restriction-on.patch

 Fix it.

+dmfe-warning-fix.patch

 Fix a net driver warning.

+ppc32-added-support-for-new-mpc8548-family-of-powerquicc.patch
+ppc32-added-preliminary-support-for-the-mpc8548-cds-board.patch
+ppc32-apple-device-tree-bug-fix.patch
+ppc32-ppc64-cleanup-proc-device-tree.patch

 ppc32 updates

+ppc64-override-command-line-as-ld-cc-variables-when-adding-m64-and-co-for-biarch-compilers.patch
+ppc64-use-cpu_has_feature-macro.patch
+ppc64-cleanup-spr-definitions.patch
+ppc64-cleanup-iseries-runlight-support.patch
+ppc64-remove-decr_overclock.patch
+ppc64-fix-a-device-tree-bug-on-apples.patch

 ppc64 updates

+i386-selectable-frequency-of-the-timer-interrupt-fix.patch

 Fix i386-selectable-frequency-of-the-timer-interrupt.patch

+optimise-storage-of-read-mostly-variables-x86_64-fix-fix-fix.patch

 Fix optimise-storage-of-read-mostly-variables-fix.patch some more

+ptrace_h8300-condition-bugfix.patch

 h8/300 ptrace fix

+suspend-resume-smp-support-fix.patch
+suspend-resume-smp-support-fix-3.patch

 More fixes for suspend-resume-smp-support.patch

+cpu-hotplug-printk-fix.patch
+suspend-pci-power-managment-reference-implementation.patch
+swsusp-only-allow-it-when-it-makes-sense.patch
+update-video-after-suspend-documentation.patch

 Various PM/hotplug fixes

+m32r-support-m3a-2170mappi-iii-platform.patch
+m32r-update-m32r_cfc-to-support-mappi-iii.patch

 m32r additional platform support

+uml-add-and-use-generic-hw_controller_type-release.patch

 UML fix

+cfq-cfq-elevator_insert_back-fix-fix.patch

 Fix cfq-cfq-elevator_insert_back-fix.patch

+kprobes-ia64-cleanup.patch
+kprobes-ia64-qp-fix.patch
+kprobes-ia64-check-jprobe-break-before-handling.patch
+kprobes-temporary-disarming-of-reentrant-probe-for-ia64.patch

 Various fixes and updates for kprobes-on-ia64

-seccomp-disable-tsc-for-seccomp-enabled-tasks.patch

 This was racy

+allow-ev_abs-to-work-in-uinputc.patch

 Some input fix

+e1000-numa-aware-allocation-of-descriptors-v2.patch

 Use node-local allocation in e1000.c

+gconfig-only-show-scrollbars-if-needed.patch

 gconfig niceness

+potential-null-pointer-dereference-in-amiga-serial-driver.patch

 Fix an oops which doesn't happen.

+add-offseth-to-dontdiff.patch

 Don't generate diffs for offset.h.  (Why is anyone using the dontdiff file
 anyway?)

+yenta-ti-turn-off-interrupts-during-card-power-on-more-2.patch

 Fix obscure problems with TI cardbus controllers

+compat-introduce-compat_time_t.patch

 Add compat_time_t

+namespacec-fix-mnt_namespace-zeroing-for-expired-mounts.patch
+set-mnt_namespace-in-the-correct-place.patch
+dcookiesc-use-proper-refcounting-functions.patch
+namespace-rename-mnt_fslink-to-mnt_expire.patch
+namespace-rename-_mntput-to-mntput_no_expire.patch

 Continue fiddling with fs/namespace.c

+fix-tpm-driver-sysfs-owernship-changes-fix.patch
+fix-tpm-driver-sysfs-owernship-changes-fix-2.patch
+fix-tpm-driver-sysfs-owernship-changes-fix-3.patch

 Fix the tpm driver fixes in -mm.

+dlm-lockspaces-callbacks-directory-build-fix.patch
+dlm-lockspaces-callbacks-directory-fix.patch
+dlm-lockspaces-callbacks-directory-fix-2.patch
+dlm-debug-fs-no-debug-build-fix.patch

 Fix various things in the DLM patches.

+fork-connector-send-status-to-userspace-fix.patch

 Fix fork-connector-send-status-to-userspace.patch

+i2o-new-sysfs-attributes-and-adaptec-specific-block-fix-fix.patch

 Fix i2o-new-sysfs-attributes-and-adaptec-specific-block-fix.patch

+i2o-build-fix.patch
+i2o-device-attribute-fixes.patch

 More fixes for the i2o patches in -mm.

+add-generalized-dvb-usb-driver-fix-2.patch
+add-generalized-dvb-usb-driver-fix-3.patch

 Fix add-generalized-dvb-usb-driver.patch

+pcmcia-allow-function-id-based-match-fix.patch

 Fix pcmcia-allow-function-id-based-match.patch

+perfctr-seqlocks-for-mmaped-state-common.patch
+perfctr-seqlocks-for-mmaped-state-x86.patch
+perfctr-seqlocks-for-mmaped-state-ppc64.patch
+perfctr-seqlocks-for-mmaped-state-ppc32.patch

 perfctr speedup

-sched-remove-set_tsk_need_resched-from-init_idle-v2.patch
-sched-remove-set_tsk_need_resched-from-init_idle-v2-ia64-fix.patch
+enable-preempt_bkl-on-preemptsmp-too.patch
+sched-tweak-idle-thread-setup-semantics.patch
+sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch
+sched-task_noninteractive.patch

 Fiddle with the CPU scheduler

+video-for-linux-docummentation.patch

 v4l documentation udpate

+intelfb-add-voffset-option-to-avoid-conficts-with-xorg-i810-driver.patch
+intelfb-add-voffset-option-to-avoid-conficts-with-xorg-i810-driver-fix.patch
+intelfb-fix-accel-detection-when-changing-video-modes.patch
+intelfb-documentation.patch
+intelfb-documentation-fix.patch

 fbdev driver updates

+md-remove-unneeded-null-checks-before-kfree.patch

 raid cleanup

+modules-add-version-and-srcversion-to-sysfs.patch

 Add module version info to sysfs

+drivers-media-common-saa7146_fopsc-make-a-function-static.patch
+net-sctp-make-two-functions-static.patch
+ll_merge_requests_fn-cleanup.patch
+update-comment-about-gzip-scratch-size.patch
+kill-signed-chars.patch
+printk-arch-i386-mm-pgtablec.patch
+printk-arch-i386-mm-ioremapc.patch
+sound-oss-esssolo1-use-the-dma_32bit_mask-constant.patch
+sound-oss-es1371-use-the-dma_32bit_mask-constant.patch
+sound-oss-es1370-use-the-dma_32bit_mask-constant.patch
+sound-oss-cmpci-use-the-dma_32bit_mask-constant.patch
+remove-duplicate-file-in-documentation-networking-drivers_net_wan_kconfig.patch
+remove-duplicate-file-in-documentation-networking-00-index.patch
+remove-duplicate-file-in-documentation-networking.patch

 Little fixes

+sound-oss-sequencer_syms-unexport-reprogram_timer.patch

 Kill an EXPORT_SYMBOL




number of patches in -mm: 1256
number of changesets in external trees: 73
number of patches in -mm only: 1252
total patches: 1325



All 1256 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm2/patch-list


