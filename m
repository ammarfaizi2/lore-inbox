Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbUKEIQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUKEIQK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 03:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbUKEIQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 03:16:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:28131 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261357AbUKEINb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 03:13:31 -0500
Date: Fri, 5 Nov 2004 00:13:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm3
Message-Id: <20041105001328.3ba97e08.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/


- Added Andi's 4-level-pagetable patches.  It's tested on x86, x86_64, ia64
  and ppc64.  These are fairly intrusive patches and I'll probably push them
  upstream soon.

- UML updates, ppc64 updates.

- Should fix a few bugs which people reported in 2.6.10-rc1-mm2.



Changes since 2.6.10-rc1-mm2:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-i2c.patch
 bk-ia64.patch
 bk-ide-dev.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-jfs.patch
 bk-kbuild.patch
 bk-kbuild-utsname-fix.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch
 bk-watchdog.patch

 External BK trees

-direct-io-write-memory-leak-fix.patch
-add-typechecking-to-suspend-types-and-powerdown-types.patch
-key_init-ordering-fix.patch
-acpi_processor_start-fix.patch
-acpi_processor_add-warning-fix.patch
-swapper_space-warning-suppression.patch
-use-mmiowb-in-tg3_poll.patch
-x25-stop-x25_destroy_socket-timer-looping.patch
-ethertap-debug-no-newline.patch
-x25-stop-proc-net-x25-route-infinitely.patch
-x25-dont-log-unknown-frame-type-when.patch
-avoid-warning-on-conntrack_stat_inc-in-destroy_conntrack.patch
-ppc32-fix-ppc4xx_progress-warnings.patch
-ppc32-fix-boot-on-powermac.patch
-ppc64-iseries-fix-for-generic-irq-changes.patch
-ppc64-setup-cpu_sibling_map-on-iseries.patch
-ppc64-enable-maple-ide-fixup.patch
-x86_64-fix-safe_smp_processor_id-after-genapic.patch
-x86_64-fix-warning-in-genapic.patch
-m32r-fix-a-typo-of-delayc.patch
-uml-fix-mainline-lazyness-about-tty-layer-patch.patch
-ext3_rsv_cleanup.patch
-ext3_rsv_base.patch
-ext3-reservation-default-on.patch
-ext3-lazy-discard-reservation-window-patch.patch
-ext3-reservations-spelling-fixes.patch
-ext3-reservations-renumber-the-ext3-reservations-ioctls.patch
-ext3-reservations-remove-unneeded-declaration.patch
-ext3-reservations-turn-ext3-per-sb-reservations-list-into-an-rbtree.patch
-ext3-reservations-split-the-reserve_window-struct-into-two.patch
-ext3-reservations-smp-protect-the-reservation-during-allocation.patch
-ext3-rsv-use-before-initialise-fix.patch
-ext3-reservations-window-allocation-fix.patch
-ext3-reservation-window-size-increase-incorrectly-fix.patch
-ext3_reservation_window_fix_fix.patch
-ext3-reservation-remove-stale-window-fix.patch
-ext3-reservation-allow-turn-off-for-specifed-file.patch
-ext3-reservation-skip-allocation-in-a-full-group.patch
-ext3-online-resize-patch.patch
-ext3_bread-cleanup.patch
-fbdev-convert-module_parm-to-module_param-in-i810fb.patch
-fbdev-remove-module-parameter-disabled-from-savagefb.patch
-fbdev-convert-module_parm-to-module_param-in-intelfb.patch
-fbdev-convert-module_parm-to-module_param-in-neofb.patch
-fbdev-fix-io-access-in-neofb.patch
-fbdev-add-__iomem-annotations-to-sstfb.patch
-fbdev-add-__iomem-annotations-to-tdfxfb.patch
-fbdev-do-not-memset-the-framebuffer-memory-in-asiliantfb.patch
-fbdev-add-__iomem-annotations-to-cyber2000fb.patch
-fbdev-add-__iomem-annotations-to-pm2fb.patch
-fbdev-add-__iomem-annotations-to-hgafb.patch
-fbdev-add-__iomem-annotations-to-cirrusfb.patch
-fbdev-add-__iomem-annotations-to-vfb.patch
-fbdev-check-if-cursor-image-has-changed-in-intelfb.patch
-fbdev-maintainership.patch
-use-mmiowb-in-tg3c.patch
-export-power_status-parameter-through-sysfs.patch
-unwind-information-fix-for-the-vsyscall-dso.patch
-make-dnotify-a-configure-time-option.patch
-make-dnotify-a-configure-time-option-embedded.patch
-convert-pipefs-to-fs_initcall.patch
-fix-deprecated-module_parm-for-capi-subsystem.patch
-documentation-cpqarraytxt-update.patch
-documentation-mkdevida-removal.patch

 Merged

+fix-hpet-time_interpolator-registration.patch

 HPET fix

+4level-architecture-changes-for-alpha.patch
+4level-architecture-changes-for-arm.patch
+4level-core-patch.patch
+4level-architecture-changes-for-cris.patch
+4level-convert-drm-to-4levels.patch
+4level-add-asm-generic-support-for-emulating.patch
+4level-ia64-support.patch
+4level-architecture-changes-for-i386.patch
+4level-architecture-changes-for-m32r.patch
+4level-architecture-changes-for-ppc.patch
+4level-architecture-changes-for-ppc64.patch
+4level-architecture-changes-for-s390.patch
+4level-architecture-changes-for-sh.patch
+4level-architecture-changes-for-sh64.patch
+4level-architecture-changes-for-sparc.patch
+4level-architecture-changes-for-sparc64.patch
+4level-architecture-changes-for-x86_64.patch

 4-level pagetables

+compat-syscalls-naming-standardisation.patch
+compat-syscalls-naming-standardisation-fix.patch

 compat syscall fixes for parisc

+icom-makefile-fix.patch

 icom serial driver fix

+unexport-lock_page.patch

 Unneeded export

+fix-duplicate-config-for-ia64_mca_recovery.patch

 ia64 config fix

+mm-higher-order-watermarks-fix.patch

 page reclaim fix

+prio_tree-fix-prio_tree_expand-corner-c.patch
+prio_tree-add-documentation-prio_treetxt.patch

 priotree oops fixes

+fix-find_next_best_node.patch

 numa fix

+more-hardirqh-consolidation.patch

 irq cleanups

+arcnet-fixes-fix.patch

 fix the arcnet fixes

+e1000-stop-working-after-resume.patch
+fix-for-8023ad-shutdown-issue.patch

 net driver fixes

+ppc32-cpm2-bug.patch
+ppc32-add-support-for-sandpoint-x2.patch
+fix-pmac_zilog-as-console.patch

 ppc32 things

+ppc64-iseries-iommu-cleanups.patch
+ppc64-vio-iommu-table-property-parsing-wrong.patch
+ppc64-add-option-for-oprofile-to-backtrace-through-spinlocks.patch
+ppc64-iommu-fixes-round-3.patch
+ppc64-iseries_pcic-use-for_each_pci_dev.patch
+ppc64-pmac_pcic-replace-pci_find_device-with-pci_get_device.patch
+ppc64-pseries_pcic-use-for_each_pci_dev.patch
+ppc64-pseries_iommuc-use-for_each_pci_dev.patch
+ppc64-u3_iommuc-use-for_each_pci_dev.patch

 ppc64 things

-fix-iounmap-and-a-pageattr-memleak-x86-and-x86-64.patch

 This is sick

+up-local-apic-bootstrap-cleanup.patch
+x86-x86_64-only-handle-system-nmis-on-the-bsp.patch
+ptrace-pokeusr-add-comment-about-the-dr7-check.patch

 x86 fixes

+x86_64-add-p4-clockmod.patch

 x86_64 Kconfig fix

+m32r-fix-arch-m32r-lib-memsets.patch
+m32r-fix-for-use-of-mappi-pcc.patch

 m32r fixes

+uml-fix-ptrace-hang-on-269-host-due-to-host-changes.patch
+uml-some-comments-about-forcing-bin-bash.patch
+uml-add-startup-check-for-mmapprot_exec-from-tmp.patch
+uml-fix-syscall-auditing.patch
+uml-fix-symbol-conflict-in-linking.patch
+uml-cleanup-header-names.patch
+uml-remove-useless-inclusion.patch
+uml-no-duplicate-current_thread-definition.patch
+uml-mconsole_proc-simplify-and-partial-fix.patch
+uml-catch-eintr-in-generic_console_write.patch
+uml-remove-sigprof-from-change_signals.patch
+umluse-kallsyms-when-dumping-stack.patch
+uml-revert-compile-only-changes-for-other-ones.patch
+uml-fix-sysemu-test-at-startup.patch
+uml-more-careful-test-startup.patch
+uml-use-ptrace_sysemu-also-for-tt-mode.patch
+uml-lots-of-little-fixes-by-jeff-dike.patch
+uml-clear-errno-in-catch_eintr.patch
+uml-readd-linux-makefile-target-fixes-to-the-old-version.patch
+uml-add-missing-newline-in-help-string.patch
+uml-update-atomich-so-uml-builds-cleanly.patch
+uml-handle-signal-api.patch
+uml-sysenter-is-syscall.patch
+uml-generic-singlestep-syscall.patch
+uml-generic-singlestepping.patch
+uml-clear-singlestep.patch
+uml-dont-check-nr_syscalls.patch
+uml-set-dtrace-correctly.patch

 UML updates

+pcmcia-module_refcount-oops-fix.patch

 Fix the PCMCIA patches in -mm

+kgdb-x86_64-serial-fix.patch

 Update kgdb stub for serial changes

+fix-cpm2-uart-driver-device-number-brain-damage.patch

 serial driver fix

+sched-reset-cache_hot_time.patch

 Unbreak the sched-domains tuning

-sched-mm-fix-scheduling-latencies-in-copy_page_range.patch
-fix-config_debug_highmem-assert-in-copy_page_range.patch

 The 4level patches broke these

+v4l-mxb-driver-and-i2c-helper-cleanup.patch
+v4l-keep-tvaudio-driver-away-from-saa7146.patch
+meye-module-related-fixes.patch
+meye-replace-homebrew-queue-with-kfifo.patch
+meye-picture-depth-is-in-bits-not-in-bytes.patch
+meye-do-lock-properly-when-waiting-for-buffers.patch
+meye-implement-non-blocking-access-using-poll.patch
+meye-cleanup-init-exit-paths.patch
+meye-the-driver-is-no-longer-experimental-and-depends-on-pci.patch
+meye-module-parameters-documentation-fixes.patch
+meye-add-v4l2-support.patch
+meye-whitespace-and-coding-style-cleanups.patch
+meye-bump-up-the-version-number.patch
+meye-cache-the-camera-settings-in-the-driver.patch
+sonypi-documentation-fixes.patch
+pcmcia-network-drivers-cleanup.patch
+videodev2h-patchlet.patch

 Various video driver updates

+kexec-kexecx86_64-4level-fix.patch

 Fix kexec for the 4level patches

+kexec-loading-kernel-from-non-default-offset-fix.patch

 kexec fix

+reiser4-rename-key_init.patch

 reiser4 namespace clash fix

+mpsc-driver-patch.patch

 Fix this serial driver

+make-acpi_bus_register_driver-consistent-with-pci_register_driver-again.patch
+make-acpi_bus_register_driver-consistent-with-pci_register_driver-again-warning-fix.patch

 ACPI fixes

+make-cancel_rearming_delayed_workqueue-static.patch

 namespace cleanup

+remove-journal-callback-code-from-jbd.patch

 dead code

+no-buddy-bitmap-patch-revisit-for-mm-page_allocc-fix.patch

 Fix the page allocator rework

+o_direct-fix-again.patch

 Hopefully get the direct-io fix done right.  Should fix the LVM setup
 problems people have been reporting.

+fbcon-do-not-touch-hardware-if-vc_mode-=-kd_text.patch
+fbdev-fix-access-to-rom-in-aty128fb.patch
+fbdev-fix-io-access-in-rivafb.patch
+fbcon-add-box-drawing-glyphs-to-6x11-font.patch
+fbdev-fix-source-copy-bug-in-neofb.patch
+fbcon-fbdev-remove-fbcon-specific-fields-from-struct-fb_info.patch
+fbdev-atyfb_basec-requires-atyfb_cursor.patch
+fix-atyfb-cursor-problems.patch
+fbdev-set-correct-mclk-xclk-values-for-aty-in-ibook.patch
+fbdev-check-for-intialized-flag-before-registration-in-matroxfb.patch
+fbcon-do-not-touch-hardware-if-vc_mode-=-kd_text-fix.patch
+remove-two-leftover-asm-linux_logoh-files.patch
+fbdev-intelfb-code-cleanup.patch
+fbcon-another-fix-for-fbcon-generic-blanking-code.patch

 fbdev/fbcon updates

+md-fix-problem-with-md-linear-for-devices-larger-than-2-terabytes.patch
+md-fix-raid6-problem.patch
+md-delete-unplug-timer-before-shutting-down-md-array.patch
+md-delete-unplug-timer-before-shutting-down-md-array-cleanup.patch
+md-faulty-personality.patch

 MD update

+dont-ignore-try_stop_module-return.patch

 module fix

+proc-kcore-enable-disable.patch

 Add missing config for /proc/kcore

-invalidate_inode_pages-mmap-coherency-fix.patch

 This is causing I/O errors when it shouldn't.  Needs work.

+sysrq-n-changes-rt-tasks-to-normal.patch

 Make alt-sysrq-n turn all rt-policy tasks into SCHED_OTHER.  For when an
 rt-policy process goes crazy and locks the machine up.

+cputime-fix-do_setitimer.patch

 Fix the cputime patches.  Should fix the "konqueror doesn't work" problem
 which people noted.

+fix-bug-in-i2o_iop_systab_set-where-address-is-used-instead.patch

 i2o driver fix

-lock-initializer-unifying-batch-2-usb.patch

 Clashed with other things

+remove-duplicate-safe_for_readread_buffer-entry-in-scsi_ioctlc.patch
+remove-unused-lookup_mnt-export.patch

 Code cleanups

+kprobes-minor-i386-changes-required-for-porting-kprobes-to-x86_64.patch
+kprobes-kprobes-ported-to-x86_64.patch
+kprobes-minor-changes-for-sparc64.patch

 kprobes updates

+maintainer-vfs-email.patch

 email address update

+fix-ext3_dx_readdir.patch

 Fix htree's readdir function.

+remove-dead-kernel_map_pages-export.patch
+reove-dead-exports-from-randomc.patch
+unexport-do_settimeofday.patch

 cleanups

+documentation-remove-drivers-char-readmecomputone.patch
+documentation-remove-drivers-char-readmecyclomy.patch
+documentation-remove-drivers-char-readmeecpa.patch
+documentation-remove-drivers-char-readmescc.patch
+tipar-documentation-tipartxt-cleanup.patch
+ramdisk-correction-to-documentation-kernel-parameterstxt.patch

 Documentation fixes

+fix-building-of-samba-userland.patch
+add-__kernel__-to-linux-crc-ccitth.patch

 namespace fixes

+use-add_hotplug_env_var-in-firmware-loader.patch

 Code consolidation



number of patches in -mm: 465
number of changesets in external trees: 472
number of patches in -mm only: 446
total patches: 918




All 465 patches:



linus.patch

fix-hpet-time_interpolator-registration.patch
  fix HPET time_interpolator registration

4level-architecture-changes-for-alpha.patch
  4level: Architecture changes for alpha

4level-architecture-changes-for-arm.patch
  4level: Architecture changes for arm

4level-core-patch.patch
  4level core patch

4level-architecture-changes-for-cris.patch
  4level: Architecture changes for cris

4level-convert-drm-to-4levels.patch
  4level: convert DRM to 4levels.

4level-add-asm-generic-support-for-emulating.patch
  4level: Add asm-generic support for emulating 2/3level tables.

4level-ia64-support.patch
  4level: ia64 support

4level-architecture-changes-for-i386.patch
  4level: Architecture changes for i386

4level-architecture-changes-for-m32r.patch
  4level: Architecture changes for m32r

4level-architecture-changes-for-ppc.patch
  4level: Architecture changes for ppc

4level-architecture-changes-for-ppc64.patch
  4level: Architecture changes for ppc64

4level-architecture-changes-for-s390.patch
  4level: Architecture changes for s390

4level-architecture-changes-for-sh.patch
  4level: Architecture changes for sh

4level-architecture-changes-for-sh64.patch
  4level: Architecture changes for sh64

4level-architecture-changes-for-sparc.patch
  4level: Architecture changes for sparc

4level-architecture-changes-for-sparc64.patch
  4level: Architecture changes for sparc64

4level-architecture-changes-for-x86_64.patch
  4level: Architecture changes for x86_64

compat-syscalls-naming-standardisation.patch
  compat syscalls naming standardisation

compat-syscalls-naming-standardisation-fix.patch
  compat-syscalls-naming-standardisation-fix

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

icom-makefile-fix.patch
  icom makefile fix

unexport-lock_page.patch
  unexport lock_page()

bk-acpi.patch

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

bk-agpgart.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-drm.patch

bk-i2c.patch

bk-ia64.patch

fix-duplicate-config-for-ia64_mca_recovery.patch
  Fix duplicate config for IA64_MCA_RECOVERY

bk-ide-dev.patch

bk-input.patch

bk-dtor-input.patch

bk-jfs.patch

bk-kbuild.patch

bk-kbuild-utsname-fix.patch
  bk-kbuild utsname fix

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-scsi.patch

bk-watchdog.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

mm-keep-count-of-free-areas.patch
  mm: keep count of free areas

mm-higher-order-watermarks.patch
  mm: higher order watermarks

mm-higher-order-watermarks-fix.patch
  higher order watermarks fix

mm-teach-kswapd-about-higher-order-areas.patch
  mm: teach kswapd about higher order areas

bootmem-use-node_data.patch
  bootmem use NODE_DATA

prio_tree-fix-prio_tree_expand-corner-c.patch
  prio_tree: fix prio_tree_expand corner c

prio_tree-add-documentation-prio_treetxt.patch
  prio_tree: add Documentation/prio_tree.txt

fix-find_next_best_node.patch
  fix find_next_best_node()

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

more-hardirqh-consolidation.patch
  more hardirq.h consolidation

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

arcnet-fixes.patch
  arcnet fixes

arcnet-fixes-fix.patch
  arcnet fixes fix

netpoll-fix-null-ifa_list-pointer-dereference.patch
  netpoll: fix null ifa_list pointer dereference

e1000-stop-working-after-resume.patch
  E1000 stop working after resume

fix-for-8023ad-shutdown-issue.patch
  Fix for 802.3ad shutdown issue

ppc32-cpm2-bug.patch
  ppc32: CPM2 bug

ppc32-add-support-for-sandpoint-x2.patch
  ppc32: Add support for Sandpoint X2

fix-pmac_zilog-as-console.patch
  Fix pmac_zilog as console

ppc64-iseries-iommu-cleanups.patch
  ppc64: iSeries iommu cleanups

ppc64-vio-iommu-table-property-parsing-wrong.patch
  ppc64: VIO iommu table property parsing wrong

ppc64-add-option-for-oprofile-to-backtrace-through-spinlocks.patch
  ppc64: Add option for oprofile to backtrace through spinlocks

ppc64-iommu-fixes-round-3.patch
  ppc64: iommu fixes, round 3

ppc64-iseries_pcic-use-for_each_pci_dev.patch
  ppc64: iSeries_pci.c use for_each_pci_dev()

ppc64-pmac_pcic-replace-pci_find_device-with-pci_get_device.patch
  ppc64: pmac_pci.c replace pci_find_device with pci_get_device

ppc64-pseries_pcic-use-for_each_pci_dev.patch
  ppc64: pSeries_pci.c use for_each_pci_dev()

ppc64-pseries_iommuc-use-for_each_pci_dev.patch
  ppc64: pSeries_iommu.c use for_each_pci_dev

ppc64-u3_iommuc-use-for_each_pci_dev.patch
  ppc64: u3_iommu.c use for_each_pci_dev()

ppc64-reloc_hide.patch

superhyway-bus-support.patch
  SuperHyway bus support

optimize-stack-pointer-access-reduce-register-usage.patch
  x86: optimize stack pointer access (reduce register usage)

up-local-apic-bootstrap-cleanup.patch
  UP local APIC bootstrap cleanup

x86-x86_64-only-handle-system-nmis-on-the-bsp.patch
  x86, x86_64: Only handle system NMIs on the BSP

ptrace-pokeusr-add-comment-about-the-dr7-check.patch
  ptrace POKEUSR: add comment about the DR7 check.

x86_64-add-p4-clockmod.patch
  x86_64: Add p4 clockmod

m32r-fix-arch-m32r-lib-memsets.patch
  m32r: fix arch/m32r/lib/memset.S

m32r-fix-for-use-of-mappi-pcc.patch
  m32r: fix for use of Mappi PCC

uml-fix-ptrace-hang-on-269-host-due-to-host-changes.patch
  uml: fix ptrace() hang on 2.6.9 host due to host changes

uml-some-comments-about-forcing-bin-bash.patch
  uml - some comments about forcing /bin/bash

uml-add-startup-check-for-mmapprot_exec-from-tmp.patch
  uml: add startup check for mmap(...PROT_EXEC...) from /tmp.

uml-fix-syscall-auditing.patch
  uml: fix syscall auditing

uml-fix-symbol-conflict-in-linking.patch
  uml: fix symbol conflict in linking

uml-cleanup-header-names.patch
  uml: cleanup header names

uml-remove-useless-inclusion.patch
  uml: remove useless inclusion

uml-no-duplicate-current_thread-definition.patch
  uml: no duplicate current_thread definition

uml-mconsole_proc-simplify-and-partial-fix.patch
  uml: mconsole_proc simplify and partial fix

uml-catch-eintr-in-generic_console_write.patch
  uml: catch EINTR in generic_console_write

uml-remove-sigprof-from-change_signals.patch
  uml: remove SIGPROF from change_signals

umluse-kallsyms-when-dumping-stack.patch
  Subject: [patch 12/20] uml:use kallsyms when dumping stack

uml-revert-compile-only-changes-for-other-ones.patch
  Uml: revert compile-only changes for other ones

uml-fix-sysemu-test-at-startup.patch
  uml: fix sysemu test at startup

uml-more-careful-test-startup.patch
  uml-more-careful-test-startup

uml-use-ptrace_sysemu-also-for-tt-mode.patch
  uml: use PTRACE_SYSEMU also for TT mode

uml-lots-of-little-fixes-by-jeff-dike.patch
  uml: Lots of little fixes by Jeff Dike.

uml-clear-errno-in-catch_eintr.patch
  uml: clear errno in CATCH_EINTR

uml-readd-linux-makefile-target-fixes-to-the-old-version.patch
  uml: readd linux Makefile target - fixes to the old version.

uml-add-missing-newline-in-help-string.patch
  uml: add missing newline in help string

uml-update-atomich-so-uml-builds-cleanly.patch
  uml: update atomic.h so UML builds cleanly

uml-handle-signal-api.patch
  uml: handle signal api

uml-sysenter-is-syscall.patch
  uml: sysenter is syscall

uml-generic-singlestep-syscall.patch
  uml: generic singlestep syscall

uml-generic-singlestepping.patch
  uml: generic singlestepping

uml-clear-singlestep.patch
  uml: clear singlestep

uml-dont-check-nr_syscalls.patch
  uml: dont check NR_syscalls

uml-set-dtrace-correctly.patch
  uml: set DTRACE correctly

pcmcia-17-device-model-integration.patch
  pcmcia-17: device model integration

pcmcia-module_refcount-oops-fix.patch
  pcmcia: module_refcount oops fix

pcmcia-18a-client_t-and-pcmcia_device-integration.patch
  pcmcia-18a: client_t and pcmcia_device integration

pcmcia-18b-error-on-leftover-devices.patch
  pcmcia-18b: error on leftover devices

pcmcia-19-netdevice-integration.patch
  pcmcia-19: netdevice integration

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

kgdb-is-incompatible-with-kprobes.patch
  kgdb-is-incompatible-with-kprobes

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-x86_64-fix.patch
  kgdb-x86_64-fix

kgdb-x86_64-serial-fix.patch
  kgdb-x86_64-serial-fix

kprobes-exception-notifier-fix-kgdb-x86_64.patch
  kprobes exception notifier fix

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix

kgdb-ia64-fixes.patch
  kgdb: ia64 fixes

fix-cpm2-uart-driver-device-number-brain-damage.patch
  Fix CPM2 uart driver device number brain damage

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

dev-mem-restriction-patch-allow-reads.patch
  dev-mem-restriction-patch: allow reads

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

perfctr-core.patch
  perfctr: core

perfctr-i386.patch
  perfctr: i386

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86_64.patch
  perfctr: x86_64

perfctr-ppc.patch
  perfctr: PowerPC

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

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

perfctr-x86-64-ia32-emulation-fix.patch
  perfctr x86-64 ia32 emulation fix

perfctr-ppc32-update.patch
  perfctr ppc32 update

sched-more-agressive-wake_idle.patch
  sched: more agressive wake_idle()

sched-can_migrate-exception-for-idle-cpus.patch
  sched: can_migrate exception for idle cpus

sched-newidle-fix.patch
  sched: newidle fix

sched-active_load_balance-fixlet.patch
  sched: active_load_balance() fixlet

sched-reset-cache_hot_time.patch
  sched: reset cache_hot_time

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions

add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix.patch
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

preempt-smp.patch
  improve preemption on SMP

preempt-smp-_raw_read_trylock-bias-fix.patch
  preempt-smp _raw_read_trylock bias fix

preempt-cleanup.patch
  preempt cleanup

preempt-cleanup-fix.patch
  preempt-cleanup-fix

add-lock_need_resched.patch
  add lock_need_resched()

sched-add-cond_resched_softirq.patch
  sched: add cond_resched_softirq()

sched-ext3-fix-scheduling-latencies-in-ext3.patch
  sched: ext3: fix scheduling latencies in ext3

break-latency-in-invalidate_list.patch
  break latency in invalidate_list()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent.patch
  sched: vfs: fix scheduling latencies in prune_dcache() and select_parent()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent-fix.patch
  sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent fix

sched-net-fix-scheduling-latencies-in-netstat.patch
  sched: net: fix scheduling latencies in netstat

sched-net-fix-scheduling-latencies-in-__release_sock.patch
  sched: net: fix scheduling latencies in __release_sock

sched-mm-fix-scheduling-latencies-in-unmap_vmas.patch
  sched: mm: fix scheduling latencies in unmap_vmas()

sched-mm-fix-scheduling-latencies-in-get_user_pages.patch
  sched: mm: fix scheduling latencies in get_user_pages()

sched-mm-fix-scheduling-latencies-in-filemap_sync.patch
  sched: mm: fix scheduling latencies in filemap_sync()

fix-keventd-execution-dependency.patch
  fix keventd execution dependency

sched-fix-scheduling-latencies-in-mttrc.patch
  sched: fix scheduling latencies in mttr.c

sched-fix-scheduling-latencies-in-vgaconc.patch
  sched: fix scheduling latencies in vgacon.c

sched-fix-scheduling-latencies-for-preempt-kernels.patch
  sched: fix scheduling latencies for !PREEMPT kernels

idle-thread-preemption-fix.patch
  idle thread preemption fix

oprofile-smp_processor_id-fixes.patch
  oprofile smp_processor_id() fixes

fix-smp_processor_id-warning-in-numa_node_id.patch
  Fix smp_processor_id() warning in numa_node_id()

remove-the-bkl-by-turning-it-into-a-semaphore.patch
  remove the BKL by turning it into a semaphore

cpu_down-warning-fix.patch
  cpu_down() warning fix

vmtrunc-truncate_count-not-atomic.patch
  vmtrunc: truncate_count not atomic

vmtrunc-restore-unmap_vmas-zap_bytes.patch
  vmtrunc: restore unmap_vmas zap_bytes

vmtrunc-unmap_mapping_range_tree.patch
  vmtrunc: unmap_mapping_range_tree

vmtrunc-unmap_mapping-dropping-i_mmap_lock.patch
  vmtrunc: unmap_mapping dropping i_mmap_lock

vmtrunc-vm_truncate_count-race-caution.patch
  vmtrunc: vm_truncate_count race caution

vmtrunc-bug-if-page_mapped.patch
  vmtrunc: bug if page_mapped

vmtrunc-restart_addr-in-truncate_count.patch
  vmtrunc: restart_addr in truncate_count

v4l-mxb-driver-and-i2c-helper-cleanup.patch
  v4l: mxb driver and i2c helper cleanup

v4l-keep-tvaudio-driver-away-from-saa7146.patch
  v4l: keep tvaudio driver away from saa7146

meye-module-related-fixes.patch
  meye: module related fixes

meye-replace-homebrew-queue-with-kfifo.patch
  meye: replace homebrew queue with kfifo

meye-picture-depth-is-in-bits-not-in-bytes.patch
  meye: picture depth is in bits not in bytes

meye-do-lock-properly-when-waiting-for-buffers.patch
  meye: do lock properly when waiting for buffers

meye-implement-non-blocking-access-using-poll.patch
  meye: implement non blocking access using poll()

meye-cleanup-init-exit-paths.patch
  meye: cleanup init/exit paths

meye-the-driver-is-no-longer-experimental-and-depends-on-pci.patch
  meye: the driver is no longer experimental and depends on PCI

meye-module-parameters-documentation-fixes.patch
  meye: module parameters documentation fixes

meye-add-v4l2-support.patch
  meye: add v4l2 support

meye-whitespace-and-coding-style-cleanups.patch
  meye: whitespace and coding style cleanups

meye-bump-up-the-version-number.patch
  meye: bump up the version number

meye-cache-the-camera-settings-in-the-driver.patch
  meye: cache the camera settings in the driver

sonypi-documentation-fixes.patch
  From: Stelian Pop <stelian@popies.net>
  Subject: [PATCH] sonypi: documentation fixes

pcmcia-network-drivers-cleanup.patch
  From: Stelian Pop <stelian@popies.net>
  Subject: [PATCH RESEND] pcmcia network drivers cleanup

videodev2h-patchlet.patch
  From: Stelian Pop <stelian@popies.net>
  Subject: [PATCH RESEND] videodev2.h patchlet

linux-2.6.8.1-49-rpc_workqueue.patch
  nfs: RPC: Convert rpciod into a work queue for greater flexibility

linux-2.6.8.1-50-rpc_queue_lock.patch
  nfs: RPC: Remove the rpc_queue_lock global spinlock

allow-modular-ide-pnp.patch
  allow modular ide-pnp

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm

serialize-access-to-ide-devices.patch
  serialize access to ide devices

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

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

assign_irq_vector-section-fix.patch
  assign_irq_vector __init section fix

kexec-i8259-shutdowni386.patch
  kexec: i8259-shutdown.i386

kexec-i8259-shutdown-x86_64.patch
  kexec: x86_64 i8259 shutdown

kexec-apic-virtwire-on-shutdowni386patch.patch
  kexec: apic-virtwire-on-shutdown.i386.patch

kexec-apic-virtwire-on-shutdownx86_64.patch
  kexec: apic-virtwire-on-shutdown.x86_64

kexec-ioapic-virtwire-on-shutdowni386.patch
  kexec: ioapic-virtwire-on-shutdown.i386

kexec-ioapic-virtwire-on-shutdownx86_64.patch
  kexec: ioapic-virtwire-on-shutdown.x86_64

kexec-e820-64bit.patch
  kexec: e820-64bit

kexec-kexec-generic.patch
  kexec: kexec-generic

kexec-ide-spindown-fix.patch
  kexec-ide-spindown-fix

kexec-ifdef-cleanup.patch
  kexec ifdef cleanup

kexec-machine_shutdownx86_64.patch
  kexec: machine_shutdown.x86_64

kexec-kexecx86_64.patch
  kexec: kexec.x86_64

kexec-kexecx86_64-4level-fix.patch
  kexec-kexecx86_64-4level-fix

kexec-machine_shutdowni386.patch
  kexec: machine_shutdown.i386

kexec-kexeci386.patch
  kexec: kexec.i386

kexec-use_mm.patch
  kexec: use_mm

kexec-loading-kernel-from-non-default-offset.patch
  kexec: loading kernel from non-default offset

kexec-loading-kernel-from-non-default-offset-fix.patch
  kdump: fix bss compile error

kexec-enabling-co-existence-of-normal-kexec-kernel-and-panic-kernel.patch
  kexec: nabling co-existence of normal kexec kernel and  panic kernel

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-kmap-build-fix.patch
  crashdump kmap build fix

crashdump-register-snapshotting-before-kexec-boot.patch
  crashdump: register snapshotting before kexec boot

crashdump-elf-format-dump-file-access.patch
  crashdump: ELF format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear/raw format dump file access

crashdump-minor-bug-fixes-to-kexec-crashdump-code.patch
  crashdump: minor bug fixes to kexec crashdump code

crashdump-cleanups-to-the-kexec-based-crashdump-code.patch
  crashdump: cleanups to the kexec based crashdump code

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-fix-cpuset_get_dentry.patch
  cpusets : fix cpuset_get_dentry()

cpusets-fix-race-in-cpuset_add_file.patch
  cpusets: fix race in cpuset_add_file()

cpusets-remove-more-casts.patch
  cpusets: remove more casts

cpusets-make-config_cpusets-the-default-in-sn2_defconfig.patch
  cpusets: make CONFIG_CPUSETS the default in sn2_defconfig

cpusets-document-proc-status-allowed-fields.patch
  cpusets: document proc status allowed fields

cpusets-dont-export-proc_cpuset_operations.patch
  Cpusets - Dont export proc_cpuset_operations

cpusets-display-allowed-masks-in-proc-status.patch
  cpusets: display allowed masks in proc status

cpusets-simplify-cpus_allowed-setting-in-attach.patch
  cpusets: simplify cpus_allowed setting in attach

cpusets-remove-useless-validation-check.patch
  cpusets: remove useless validation check

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

cpusets-interoperate-with-hotplug-online-maps.patch
  cpusets: interoperate with hotplug online maps

cpusets-alternative-fix-for-possible-race-in.patch
  cpusets: alternative fix for possible race in  cpuset_tasks_read()

cpusets-remove-casts.patch
  cpusets: remove void* typecasts

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-sb_sync_inodes-cleanup.patch
  reiser4-sb_sync_inodes-cleanup

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-allow-drop_inode-implementation-cleanup.patch
  reiser4-allow-drop_inode-implementation-cleanup

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-truncate_inode_pages_range-cleanup.patch
  reiser4-truncate_inode_pages_range-cleanup

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-rcu-barrier-fix.patch
  reiser4-rcu-barrier fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-inode_lock-cleanup.patch
  reiser4-export-inode_lock-cleanup

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-pagevec-funcs-cleanup.patch
  reiser4-export-pagevec-funcs-cleanup

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-aliased-dir.patch
  reiser4: vfs: handle aliased directories

reiser4-kobject-umount-race.patch
  reiser4: introduce filesystem kobjects

reiser4-kobject-umount-race-cleanup.patch
  reiser4-kobject-umount-race-cleanup

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-unstatic-kswapd.patch
  reiser4: make kswapd() unstatic for debug

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-4kstacks-fix.patch
  resier4-4kstacks-fix

stop-reiser4-from-turning-itself-on-by-default.patch
  Stop reiser4 from turning itself on by default

reiser4-doc.patch
  reiser4: documentation

reiser4-doc-update.patch
  Update Documentation/Changes for reiser4

reiser4-only.patch
  reiser4: main fs

reiser4-rename-key_init.patch
  reiser4: rename key_init

reiser4-cond_resched-build-fix.patch
  reiser4: cond_resched() build fix

reiser4-debug-build-fix.patch
  reiser4-debug-build-fix

reiser4-prefetch-warning-fix.patch
  reiser4: prefetch warning fix

reiser4-mode-fix.patch
  reiser4: mode type fix

reiser4-get_context_ok-warning-fixes.patch
  reiser4: get_context_ok() warning fixes

reiser4-remove-debug.patch
  resier4: remove debug stuff

reiser4-spinlock-debugging-build-fix-2.patch
  reiser4-spinlock-debugging-build-fix-2

reiser4-sparc64-build-fix.patch
  reiser4 sparc64 build fix

sys_reiser4-sparc64-build-fix.patch
  sys_reiser4 sparc64 build fix

reiser4-printk-warning-fixes.patch
  reiser4 printk warning fixes

reiser4-generic_acl-fix.patch
  reiser4: generic_acl fix

reiser4-plugin_set_done-memleak-fix.patch
  reiser4 plugin_set_done-memleak-fix.patch

reiser4-init-max_atom_flusers.patch
  reiser4 init-max_atom_flusers.patch

reiser4-parse-options-reduce-stack-usage.patch
  reiser4 parse-options-reduce-stack-usage.patch

reiser4-sparce64-warning-fix.patch
  reiser4 sparc64-warning-fix.patch

reiser4-hardirq-build-fix.patch
  resiser4: hardirq.h build fix

reiser4-x86_64-warning-fix.patch
  reiser4 x86_64-warning-fix.patch

reiser4-fix-mount-option-parsing.patch
  reiser4 fix-mount-option-parsing.patch

reiser4-parse-option-cleanup.patch
  reiser4 parse-option-cleanup.patch

reiser4-comment-fix.patch
  reiser4 comment-fix.patch

reiser4-fill_super-improve-warning.patch
  reiser4 fill_super-improve-warning.patch

reiser4-disable-pseudo.patch
  reiser4 disable-pseudo.patch

reiser4-disable-repacker.patch
  reiser4 disable-repacker.patch

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

add-acpi-based-floppy-controller-enumeration-fix.patch
  add-acpi-based-floppy-controller-enumeration fix

update-acpi-floppy-enumeration.patch
  update ACPI floppy enumeration

floppy-acpi-enumeration-update.patch
  floppy ACPI enumeration update

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

3c59x-pm-fix.patch
  3c59x: enable power management unconditionally

3c59x-missing-pci_disable_device.patch
  3c59x: missing pci_disable_device

3c59x-use-netdev_priv.patch
  3c59x: use netdev_priv

3c59x-make-use-of-generic_mii_ioctl.patch
  3c59x: Make use of generic_mii_ioctl

3c59x-vortex-select-mii.patch
  3c59x: VORTEX select MII

3c59x-reload-eeprom-values-at-rmmod-for-needy-cards.patch
  3c59x: reload EEPROM values at rmmod for needy cards

3c59x-remove-eeprom_reset-for-3c905b.patch
  3c59x: remove EEPROM_RESET for 3c905B

3c59x-support-more-ethtool_ops.patch
  3c59x: support more ethtool_ops

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

serial-8250-receive-lockup-fix.patch
  serial: 8250 receive lockup fix

new-serial-flow-control.patch
  new serial flow control

early-uart-console-support.patch
  early uart console support

move-hcdp-pcdp-to-early-uart-console.patch
  move HCDP/PCDP to early uart console

mpsc-driver-patch.patch
  serial: MPSC driver

vm-pageout-throttling.patch
  vm: pageout throttling

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

fix-for-spurious-interrupts-on-e100-resume-2.patch
  Fix for spurious interrupts on e100 resume 2

thinkpad-fnfx-key-driver.patch
  thinkpad fn+fx key driver

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again.patch
  make acpi_bus_register_driver() consistent with pci_register_driver()

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again-warning-fix.patch
  make-acpi_bus_register_driver-consistent-with-pci_register_driver-again-warning-fix

enforce-a-gap-between-heap-and-stack.patch
  Enforce a gap between heap and stack

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

for-mm-only-remove-remap_page_range-completely.patch
  vm: for -mm only: remove remap_page_range() completely

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()

make-cancel_rearming_delayed_workqueue-static.patch
  make cancel_rearming_delayed_workqueue static

ipvs-deadlock-fix.patch
  ipvs deadlock fix

remove-journal-callback-code-from-jbd.patch
  remove journal callback code from jbd

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

no-buddy-bitmap-patch-revist-intro-and-includes.patch
  no buddy bitmap patch revist: intro and includes

no-buddy-bitmap-patch-revisit-for-mm-page_allocc.patch
  no buddy bitmap patch revisit: for mm/page_alloc.c

no-buddy-bitmap-patch-revisit-for-mm-page_allocc-fix.patch
  no-buddy-bitmap-patch-revisit-for-mm-page_allocc fix

no-buddy-bitmap-patch-revist-for-ia64.patch
  no buddy bitmap patch revist: for ia64

no-buddy-bitmap-patch-revist-for-ia64-fix.patch
  no-buddy-bitmap-patch-revist-for-ia64 fix

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

dio-handle-eof.patch
  direct-IO: handle EOF
  dio-handle-eof fix

o_direct-fix-again.patch
  O_DIRECT fix again

fbcon-do-not-touch-hardware-if-vc_mode-=-kd_text.patch
  fbcon: Do not touch hardware if vc_mode != KD_TEXT

fbdev-fix-access-to-rom-in-aty128fb.patch
  fbdev: Fix access to ROM in aty128fb

fbdev-fix-io-access-in-rivafb.patch
  fbdev: Fix IO access in rivafb

fbcon-add-box-drawing-glyphs-to-6x11-font.patch
  fbcon: Add box drawing glyphs to 6x11 font

fbdev-fix-source-copy-bug-in-neofb.patch
  fbdev: Fix source copy bug in neofb

fbcon-fbdev-remove-fbcon-specific-fields-from-struct-fb_info.patch
  fbcon/fbdev: Remove fbcon-specific fields from struct fb_info

fbdev-atyfb_basec-requires-atyfb_cursor.patch
  fbdev: atyfb_base.c requires atyfb_cursor()

fix-atyfb-cursor-problems.patch
  fbdev: Fix atyfb cursor problems

fbdev-set-correct-mclk-xclk-values-for-aty-in-ibook.patch
  fbdev: Set correct mclk/xclk values for aty in ibook

fbdev-check-for-intialized-flag-before-registration-in-matroxfb.patch
  fbdev: Check for intialized flag before registration in matroxfb

fbcon-do-not-touch-hardware-if-vc_mode-=-kd_text-fix.patch
  fbcon: "Do not touch hardware if vc_mode != KD_TEXT: fix

remove-two-leftover-asm-linux_logoh-files.patch
  remove two leftover <asm/linux_logo.h> files

fbdev-intelfb-code-cleanup.patch
  fbdev: intelfb code cleanup

fbcon-another-fix-for-fbcon-generic-blanking-code.patch
  fbcon: Another fix for fbcon generic blanking code

md-fix-problem-with-md-linear-for-devices-larger-than-2-terabytes.patch
  md: fix problem with md/linear for devices larger than 2 terabytes

md-fix-raid6-problem.patch
  md: fix raid6 problem

md-delete-unplug-timer-before-shutting-down-md-array.patch
  md: delete unplug timer before shutting down md array

md-delete-unplug-timer-before-shutting-down-md-array-cleanup.patch
  md-delete-unplug-timer-before-shutting-down-md-array-cleanup

md-faulty-personality.patch
  md: "Faulty" personality

dont-ignore-try_stop_module-return.patch
  Don't ignore try_stop_module return

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

proc-kcore-enable-disable.patch
  /proc/kcore - enable/disable.

use-mmiowb-in-qla1280c.patch
  use mmiowb in qla1280.c

yenta_socketc-fix-missing-pci_disable_dev.patch
  yenta_socket.c: Fix missing pci_disable_dev

yenta-dont-enable-read-prefetch-on-older-o2-bridges.patch
  yenta: don't enable read prefetch on older o2 bridges.

via8231-support-for-parallel-port-driver.patch
  VIA8231 support for parallel port driver

via8231-support-for-parallel-port-driver-warning-fix.patch
  via8231-support-for-parallel-port-driver warning fix

fix-altsysrq-deadlock.patch
  fix alt-sysrq deadlock

sysrq-n-changes-rt-tasks-to-normal.patch
  SysRq-n changes RT tasks to normal

cputime-introduce-cputime.patch
  cputime: introduce cputime

cputime-introduce-cputime-fix.patch
  cputime-introduce-cputime fix

cputime-fix-do_setitimer.patch
  cputime: fix do_setitimer.

cputime-missing-pieces.patch
  cputime: missing pieces.

fix-bug-in-i2o_iop_systab_set-where-address-is-used-instead.patch
  fix bug in i2o_iop_systab_set where address is used instead  of length

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

lock-initializer-unifying-batch-2-alpha.patch
  Lock initializer unifying: ALPHA

lock-initializer-unifying-batch-2-ia64.patch
  Lock initializer unifying: IA64

lock-initializer-unifying-batch-2-m32r.patch
  Lock initializer unifying: M32R

lock-initializer-unifying-batch-2-mips.patch
  Lock initializer unifying: MIPS

lock-initializer-unifying-batch-2-misc-drivers.patch
  Lock initializer unifying: Misc drivers

lock-initializer-unifying-batch-2-block-devices.patch
  Lock initializer unifying: Block devices

lock-initializer-unifying-batch-2-bluetooth.patch
  Lock initializer unifying: Bluetooth

lock-initializer-unifying-batch-2-drm.patch
  Lock initializer unifying: DRM

lock-initializer-unifying-batch-2-character-devices.patch
  Lock initializer unifying: character devices

lock-initializer-unifying-batch-2-rio.patch
  Lock initializer unifying: RIO

lock-initializer-unifying-batch-2-firewire.patch
  Lock initializer unifying: Firewire

lock-initializer-unifying-batch-2-isdn.patch
  Lock initializer unifying: ISDN

lock-initializer-unifying-batch-2-raid.patch
  Lock initializer unifying: Raid

lock-initializer-unifying-batch-2-media-drivers.patch
  Lock initializer unifying: media drivers

lock-initializer-unifying-batch-2-pci.patch
  Lock initializer unifying: PCI

lock-initializer-unifying-batch-2-scsi.patch
  Lock initializer unifying: SCSI

lock-initializer-unifying-batch-2-drivers-serial.patch
  Lock initializer unifying: drivers/serial

lock-initializer-unifying-batch-2-filesystems.patch
  Lock initializer unifying: Filesystems

lock-initializer-unifying-batch-2-video.patch
  Lock initializer unifying: Video

lock-initializer-unifying-batch-2-networking.patch
  Lock initializer unifying: Networking

lock-initializer-unifying-batch-2-sound.patch
  Lock initializer unifying: sound

remove-duplicate-safe_for_readread_buffer-entry-in-scsi_ioctlc.patch
  Subject: [PATCH] Remove duplicate safe_for_read(READ_BUFFER) entry in scsi_ioctl.c

remove-unused-lookup_mnt-export.patch
  remove unused lookup_mnt export

kprobes-minor-i386-changes-required-for-porting-kprobes-to-x86_64.patch
  kprobes: Minor i386 changes required for porting kprobes to x86_64

kprobes-kprobes-ported-to-x86_64.patch
  kprobes: kprobes ported to x86_64

kprobes-minor-changes-for-sparc64.patch
  kprobes: Minor changes for sparc64

maintainer-vfs-email.patch
  maintainer vfs email

fix-ext3_dx_readdir.patch
  Fix ext3_dx_readdir

remove-dead-kernel_map_pages-export.patch
  remove dead kernel_map_pages export

reove-dead-exports-from-randomc.patch
  remove dead exports from random.c

unexport-do_settimeofday.patch
  unexport do_settimeofday

minor-fix-of-rcu-documentation.patch
  Minor fix of RCU documentation

documentation-remove-drivers-char-readmecomputone.patch
  documentation: Remove drivers/char/README.computone

documentation-remove-drivers-char-readmecyclomy.patch
  documentation: Remove drivers/char/README.cyclomY

documentation-remove-drivers-char-readmeecpa.patch
  documentation: Remove drivers/char/README.ecpa

documentation-remove-drivers-char-readmescc.patch
  documentation: Remove drivers/char/README.scc

tipar-documentation-tipartxt-cleanup.patch
  tipar: Documentation/tipar.txt cleanup

ramdisk-correction-to-documentation-kernel-parameterstxt.patch
  ramdisk: Correction to Documentation/kernel-parameters.txt

fix-building-of-samba-userland.patch
  Fix building of samba userland

use-add_hotplug_env_var-in-firmware-loader.patch
  Use add_hotplug_env_var() in firmware loader

add-__kernel__-to-linux-crc-ccitth.patch
  Add __KERNEL__ to <linux/crc-ccitt.h>

remove-module_parm-from-allyesconfig-almost.patch
  Remove MODULE_PARM from allyesconfig (almost)

convert-module_parm-to-module_param-family.patch
  convert MODULE_PARM() to module_param() family

more-module_parm-conversions.patch
  more MODULE_PARM conversions



