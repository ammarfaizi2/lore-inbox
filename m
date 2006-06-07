Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWFGRr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWFGRr2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWFGRr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:47:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750899AbWFGRr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:47:26 -0400
Date: Wed, 7 Jun 2006 10:47:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc6-mm1
Message-Id: <20060607104724.c5d3d730.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/

- Many more lockdep updates



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




Changes since 2.6.17-rc5-mm3:


 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit-master.patch
 git-block.patch
 git-cifs.patch
 git-cpufreq.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-jfs.patch
 git-klibc.patch
 git-hdrcleanup.patch
 git-hdrinstall.patch
 git-libata-all.patch
 git-mips.patch
 git-mtd.patch
 git-mtd-fixup.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-powerpc.patch
 git-rbtree.patch
 git-sas.patch
 git-pcmcia.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-cryptodev.patch

 git trees

-nmclan_cs-dereferencing-skb-after-netif_rx.patch
-s390-irb-memcpy-argument-swap.patch
-s390-cio-non-unique-path-group-ids.patch
-sparsemem-build-fix.patch
-selinux-fix-sb_lock-sb_security_lock-nesting-was.patch
-alpha-smp-irq-routing-fix.patch
-fs-nameic-call-to-file_permission-under-a-spinlock-in-do_lookup_path.patch
-fs-nameic-call-to-file_permission-under-a-spinlock-in-do_lookup_path-fix.patch
-pmf_register_irq_client-gives-sleep-with-locks-held-warning.patch
-implement-get--set-tso-for-forcedeth-driver.patch
-maintainers-add-entries-for-bnx2-and-tg3.patch
-sbp2-fix-check-of-return-value-of.patch
-sata_sil24-sii3124-sata-driver-endian-problem.patch
-m48t86-ia64-build-fix.patch
-m68k-get_user-build-fix.patch
-uml-add-asm-irqflagsh.patch
-uml-fix-wall_to_monotonic-initialization.patch
-uml-fix-a-typo-in-do_uml_initcalls.patch
-uml-__user-annotation-in-arch_prctl.patch
-uml-more-__user-annotations.patch
-uml-add-ffreestanding-to-cflags.patch
-blk_start_queue-must-be-called-with-irq-disabled-add-warning.patch
-blktrace_apih-endian-annotations.patch
-dprintk-adjustments-to-cpufreq-nforce2.patch
-dprintk-adjustments-to-cpufreq-speedstep-centrino.patch
-cpufreq-dprintk-adjustments.patch
-mm-constify-drivers-char-keyboardc.patch
-input-fix-accuracy-of-fixp-arithh.patch
-input-use-enospc-instead-of-enomem-in-iforce-when-device-full.patch
-for_each_possible_cpu-mips.patch
-prevent-au1xmmcc-breakage-on-non-au1200-alchemy.patch
-clean-up-initcall-warning-for-netconsole.patch
-remove-dead-entry-in-net-wan-kconfig.patch
-eliminate-unused-proc-sys-net-ethernet.patch
-irda-missing-allocation-result-check-in-irlap_change_speed.patch
-pppoe-missing-result-check-in-__pppoe_xmit.patch
-lock-validator-netlinkc-netlink_table_grab-fix.patch
-x86_64-unexport-ia32_sys_call_table.patch
-x86_64-dont-warn-for-overflow-in-nommu-case-when-dma_mask-is-32bit-fix.patch

 Merged into mainline or a subsystem tree.

-fix-hpet-operation-on-32-bit-nvidia-platforms-build-fix.patch

 Folded into fix-hpet-operation-on-32-bit-nvidia-platforms.patch

+ep93xx-build-fix.patch
+fix-mempolicyh-build-error.patch
+fbcon-fix-limited-scroll-in-scroll_pan_redraw-mode.patch

 2.6.17 queue

+acpi-dock-driver-acpi_get_device-fix.patch

 Fix acpi-dock-driver.patch

+fix-possible-oops-in-cs4281-irq-handler.patch

 ALSA might-fix.

+zoran-strncpy-cleanup.patch

 zoran fix

+ieee1394-hl_irqs_lock-is-taken-in-hardware.patch
+ieee1394-adjust-code-formatting-in.patch

 More 1394 updates

-input-powermac-cleanup-of-mac_hid-and-support-for-ctrlclick-and-commandclick.patch

 Dropped.

+input-fix-comments-and-blank-lines-in-new-ff-code.patch

 input force-feedback cleanup

+kinit-convert--in-block-device-names-to-not.patch
+klibc-ia64-fix.patch

 Fix git-klibc.patch

+sata_sil24-endian-anotations.patch

 libata tweak

+lock-validator-fix-ns83820c-irq-flags-bug.patch
+lock-validator-fix-ns83820c-irq-flags-bug-part.patch
+lock-validator-fix-ns83820c-irq-flags-part-3.patch
+ipw2200-locking-fix.patch

 net driver fixes

+bugfix-pci-legacy-i-o-port-free-driver.patch
+msi-k8t-neo2-fir-run-only-where-needed.patch

 PCI fixes

+pcmcia-fix-kernel-doc-function-name.patch

 pcmcia kerneldoc fix

+gregkh-usb-usb-sisusbvga-possible-cleanups-fix.patch

 USB fix

+add-apple-macbook-product-ids-to-usbhid.patch

 new device IDs

+x86_64-mm-optimize-bitmap-weight.patch
+x86_64-mm-check_addr-cleanups.patch
+x86_64-mm-remove-redzone-comment.patch
+x86_64-mm-spinlock-short.patch

 x86_64 udpates

+revert-x86_64-mm-spinlock-short.patch

 Fix it

+x86-nmi-fix.patch
+x86-nmi-fix-2.patch

 Fix it some more, maybe

-swapless-pm-add-r-w-migration-entries-fix-2.patch
+swapless-pm-add-r-w-migration-entries-fix.patch

 Better mm fix

+initialise-total_memory-earlier.patch
+update-vm_total_pages-at-memory-hotadd.patch

 Avoid early oops in kswapd.

+i386-print-stack-size-in-oops-messages.patch

 Enhance x86 oops output.

+m68k-clean-up-uaccessh.patch

 m68k build fix

+powerpc-implement-support-for-setting.patch
+powerpc-implement-pr_et_unalign-prctls-for-powerpc.patch

 powerpc set-endianness prctl

+poison-add-use-more-constants.patch

 use poison.h some more.

-fix-kbuild-dependencies-for-synclink-drivers.patch

 Dropped.

-remove-dead-entry-in-net-wan-makefile.patch
+remove-dead-entry-in-net-wan-kconfig.patch

 Updated

+load_module-cleanup.patch

 cleanup

+radixtree-normalize-radix_tree_tag_get-return-value.patch
+#fix-irqpoll-to-honor-disable_irq.patch
+printk-time-parameter.patch
+correct-sak-description-in-sysrqtxt.patch
+add-v3020-rtc-support.patch
+add-v3020-rtc-support-tidy.patch
+correct-tty-doc.patch
+block-layer-early-detection-of-medium-not-present.patch
+scsi-core-and-sd-early-detection-of-medium-not-present.patch
+sd-early-detection-of-medium-not-present.patch

 Misc

+fix-typo-in-drivers-isdn-hisax-q931c.patch

 ISDN fix

+sched-mc-smt-power-savings-sched-policy.patch

 multicore/SMT scheduler features

+fix-rt-mutex-defaults-and-dependencies.patch

 rt-mutex Kconfig fixes

+readahead-call-scheme-fix-fastcall.patch

 readahead fix

+hpt3x7-merge-speedproc-handlers.patch
+fix-ide-deadlock-in-error-reporting-code.patch

 IDE updates

+gxfb-get-the-frambuffer-size-from-the-bios.patch
+detaching-fbcon-fix-vgacon-to-allow-retaking-of-the.patch
+detaching-fbcon-fix-give_up_console.patch
+detaching-fbcon-remove-calls-to-pci_disable_device.patch
+detaching-fbcon-add-sysfs-class-device-entry-for-fbcon.patch
+detaching-fbcon-clean-up-exit-code.patch
+detaching-fbcon-add-capability-to-attach-detach-fbcon.patch
+detaching-fbcon-update-documentation.patch

 fbdev/fbcon updates

+genirq-add-irq-chip-support-misroute-irq-dont-call-desc-chip-end.patch

 IRQ oops fix

+lock-validator-sparc64-sparc-m68k-alpha-cris-build-fix.patch
+lock-validator-floppyc-irq-release-fix-fix-fix.patch
+lock-validator-core-early_boot_irqs_-build-fix-sparc64-sparc-m68k-alpha-cris-irqtrace-build-fix.patch
+lock-validator-core-add-config_debug_non_nested_unlocks.patch
+better-lock-debugging-remove-mutex-deadlock-checking-code.patch
+lock-validator-special-locking-bdev-fix.patch
+lock-validator-special-locking-genirq-lock-validator-early_init_irq_lock_type-build-fix.patch
+lock-validator-special-locking-sctp.patch
+lock-validator-special-locking-reiser4-false-positive.patch
+lockdep-annotate-the-quota-code.patch
+lock-validator-enable-lock-validator-in-kconfig-add-config_debug_non_nested_unlocks-kconfig.patch
+lock-validator-v3.patch
+lockdep-x86-only.patch
+lockdep-really-x86-only.patch
+lockdep-really-really-x86-only.patch

 Locking validator updates

+acpi-identify-which-device-is-not-power-manageable-fix.patch

 Fix acpi-identify-which-device-is-not-power-manageable.patch



All 1526 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/patch-list


