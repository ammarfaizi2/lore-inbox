Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbUKKJ2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbUKKJ2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 04:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUKKJ2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 04:28:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:11438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262083AbUKKJXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 04:23:42 -0500
Date: Thu, 11 Nov 2004 01:23:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm5
Message-Id: <20041111012333.1b529478.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/


- Various updates to various things.  Nothing really stands out.

- Let me be the first to report this:

	*** Warning: "kgdb_irq" [drivers/serial/serial_core.ko] undefined!
	*** Warning: "hotplug_path" [drivers/acpi/container.ko] undefined!




Changes since 2.6.10-rc1-mm4:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-ia64.patch
 bk-ide-dev.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-netdev.patch
 bk-pci.patch
 bk-scsi.patch
 bk-watchdog.patch

 External bk rtees

-ppc64-fix-g5-low-level-i2c-code.patch
-ppc64-add-hw-cpu-timebase-sync.patch
-lock-initializer-unifying-batch-2-bluetooth.patch
-lock-initializer-unifying-batch-2-networking.patch
-ext2-docs-update.patch
-ufs-docs-update.patch
-dont-divide-by-0-when-trying-to-mount-ext3.patch

 Merged

+4level-highpte-fix.patch

 4-level-pagetable fix for x86 highpte

+mm-restore-atomic-buffer.patch

 Tweak the page allocator thresholds

-arcnet-fixes-fix.patch

 Folded into arcnet-fixes.patch

+xircom_tulip_cb-build-fix.patch

 Fix this net driver

+ppc32-remove-config_serial_console_baud.patch
+update-ppc-list-addresses-in-maintainers.patch
+ppc32-remove-__setup_cpu_8xx.patch
+ppc32-remove-zero-initializations-in-cpu_specs.patch

 ppc32 things

+ppc64-bump-max_hwifs-in-ide-code.patch
+ppc64-fix-for-cpu-hotplug-numa.patch
+ppc64-small-of-fixes.patch

 ppc64 things

-frv-fujitsu-fr-v-arch-include-files.patch
+frv-first-batch-of-fujitsu-fr-v-arch-include-files.patch
+frv-more-fujitsu-fr-v-arch-include-files.patch
+frv-yet-more-fujitsu-fr-v-arch-include-files.patch
+frv-remaining-fujitsu-fr-v-arch-include-files.patch

 Missing FRV include files

+frv-change-setup_arg_pages-to-take-stack-pointer-fixes.patch

 Fix up some breakage from the FRV patches

+add-cpu_relax-in-spin-loops-clean-up-barrier-for-269.patch

 Missing cpu_relax()es in x86 and x86_64

+uml-use-sys_getpid-bypassing-glibc-fixes-uml-on-gentoo.patch

 UML fix

+enhanced-i-o-accounting-data-patch.patch
+enhanced-memory-accounting-data-collection.patch
+enhanced-memory-accounting-data-collection-tidy.patch

 Additional system accounting (I/O and memory usage)

+ext3-umount-hang.patch

 Fix kjournald shutdown bug

+wacom-tablet-driver.patch

 Input driver

+sparc32-fix-for-hypersparc-dma-errors.patch

 sparc32 fix

+bad-naming-of-structures-and-functions-in-ext3-reservation-code.patch

 Namespace cleanliness

+statfs-compat-functions-can-return-eoverflow-on-nfs.patch

 Missing compat wrappers

+sysfs-fix-dropping-existing-dir.patch

 sysfs fix

+force-feedback-support-for-uinput.patch
+force-feedback-support-for-uinput-cleanup.patch

 Input drivers

+kmap_atomic-takes-char.patch

 Make kmap_atomic() take a char* rather than a void*.  So we get warnings if
 someone passes a page* to kunmap_atomic().

+kmap_atomic-fallout.patch

 Fix up various spurious warnings from the above.  cachefs is a disaster.

+drm_memory-warning-fix.patch

 drm sparc64 warning fix

+radix_tree_delete-fix.patch

 Fix bug in radix_tree_delete()

+oprofile-add-check_user_page_readable.patch
+oprofile-arch-independent-code-for-stack-trace.patch
+oprofile-i386-support-for-stack-trace-sampling.patch
+oprofile-i386-support-for-stack-trace-sampling-fix.patch
+oprofile-ia64-support-for-oprofile-stack-trace.patch
+oprofile-update-alpha-for-api-changes.patch
+oprofile-update-arm-for-api-changes.patch
+oprofile-update-ppc-for-api-changes.patch
+oprofile-update-parisc-for-api-changes.patch
+oprofile-update-s390-for-api-changes.patch
+oprofile-update-sh-for-api-changes.patch
+oprofile-update-sparc64-for-api-changes.patch

 oprofile support for callgraph generation

-kgdb-is-incompatible-with-kprobes.patch

 Folded into kgdb-ga.patch

+kgdb-ga-fixes.patch

 Fix kgdb for recent serial layer changes

-kgdb-x86_64-fix.patch
-kgdb-x86_64-serial-fix.patch
-kprobes-exception-notifier-fix-kgdb-x86_64.patch
-kgdb-ia64-fixes.patch

 Folded into other kgdb patches

+sched-use-cached-current-value.patch

 CPU scheduler microoptimisation

+dont-hide-thread_group_leader-from-grep.patch

 code cleanup

+add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix-fix.patch

 Fix CONFIG_PROCFS=n build

+v4l-bttv-update-fix.patch
+v4l-bttv-update-fix2.patch

 bttv driver fixes

+crashdump-routines-for-copying-dump-pages-kmap-fiddle.patch

 Teach crashdump about the kmap_atomic() change

-reiser4-sb_sync_inodes-cleanup.patch
-reiser4-allow-drop_inode-implementation-cleanup.patch
-reiser4-truncate_inode_pages_range-cleanup.patch
-reiser4-rcu-barrier-fix.patch
-reiser4-export-inode_lock-cleanup.patch
-reiser4-export-pagevec-funcs-cleanup.patch
-reiser4-4kstacks-fix.patch
-stop-reiser4-from-turning-itself-on-by-default.patch
-reiser4-doc-update.patch
-reiser4-rename-key_init.patch
-reiser4-cond_resched-build-fix.patch
-reiser4-debug-build-fix.patch
-reiser4-prefetch-warning-fix.patch
-reiser4-mode-fix.patch
-reiser4-get_context_ok-warning-fixes.patch
-reiser4-remove-debug.patch
-reiser4-spinlock-debugging-build-fix-2.patch
-reiser4-sparc64-build-fix.patch
-sys_reiser4-sparc64-build-fix.patch
-reiser4-printk-warning-fixes.patch
-reiser4-generic_acl-fix.patch
-reiser4-plugin_set_done-memleak-fix.patch
-reiser4-init-max_atom_flusers.patch
-reiser4-parse-options-reduce-stack-usage.patch
-reiser4-sparce64-warning-fix.patch
-reiser4-hardirq-build-fix.patch
-reiser4-x86_64-warning-fix.patch
-reiser4-fix-mount-option-parsing.patch
-reiser4-parse-option-cleanup.patch
-reiser4-comment-fix.patch
-reiser4-fill_super-improve-warning.patch
-reiser4-disable-pseudo.patch

 I got a new reiser4 code drop.  These patches disappeared.

+reiser4-kmap-atomic-fixes.patch

 Fix kmap_atomic() usage in reiser4

+resier4-export-shrink_dcache_anon.patch

 Missing symbol export

+mpsc-driver-patch-fix.patch

 Fix mpsc-driver-patch.patch

+fbdev-add-vram-option-to-intelfb.patch
+fbdev-fix-for-using-16-pixel-wide-font-in-fb-console.patch
+fbdev-support-for-bigger-than-16x32-fonts-in-softcursor.patch
+fbdev-support-for-bigger-than-16x32-fonts-in-rivafb-cursor.patch
+fbcon-disable-fbcon-cursor-if-vt-softcursor-is-enabled.patch
+fbdev-allow-mode-change-even-if-edid-block-is-not-found.patch
+fbdev-fix-cursor-in-doublescan-mode-in-atyfb.patch
+fbdev-fix-typo-in-atyfb.patch
+fbdev-change-the-find_mode-behavior.patch

 fbdev updates

+blk_sync_queue-updates-update.patch

 update the update to the update to the MD update

+readpage-vs-invalidate-fix.patch

 New way of handling the invalidate-vs-readpage-causes-EIO problem.  This way
 works.

+invalidate_inode_pages-mmap-coherency-fix.patch

 Bring back the O_DIRECT-vs-buffered-vs-mmapped coherency fixes.  It seems to
 work OK now.

+md-documentation-mdtxt-update.patch

 MD docs

-evdev-return-einval-if-read-size-is-not-multiple-of-struct-size.patch

 Maintainers didn't like this.



number of patches in -mm: 464
number of changesets in external trees: 496
number of patches in -mm only: 450
total patches: 946



All 464 patches:



linus.patch

4level-core-patch.patch
  4level core patch

4level-bogus-bug_on.patch
  4level: remove bogus BUG_ON()

4level-fix-vmalloc-overflow.patch
  4level: fix vmalloc overflow

4level-core-tweaks.patch
  4level core tweaks

4level-highpte-fix.patch
  4level highpte fix

4level-architecture-changes-for-alpha.patch
  4level: Architecture changes for alpha

4level-architecture-changes-for-arm.patch
  4level: Architecture changes for arm

4level-fixes-arm.patch
  4level fixes (ARM)

4level-architecture-changes-for-cris.patch
  4level: Architecture changes for cris

4level-convert-drm-to-4levels.patch
  4level: convert DRM to 4levels.

4level-add-asm-generic-support-for-emulating.patch
  4level: Add asm-generic support for emulating 2/3level tables.

4level-make-3level-fallback-more-type-safe.patch
  4level: make 3level fallback more type safe

4level-ia64-support.patch
  4level: ia64 support

4level-architecture-changes-for-i386.patch
  4level: Architecture changes for i386

4level-architecture-changes-for-i386-fix.patch
  4level build fix

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

remove-contention-on-profile_lock.patch
  remove contention on profile_lock

bk-acpi.patch

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

bk-agpgart.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-drm.patch

bk-ia64.patch

fix-duplicate-config-for-ia64_mca_recovery.patch
  Fix duplicate config for IA64_MCA_RECOVERY

bk-ide-dev.patch

bk-input.patch

bk-dtor-input.patch

bk-netdev.patch

bk-pci.patch

bk-scsi.patch

megaraid-22041-driver.patch
  megaraid 2.20.4.1 Driver

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

fix-o_sync-speedup-for-generic_file_write_nolock.patch
  Fix O_SYNC speedup for generic_file_write_nolock

mm-restore-atomic-buffer.patch
  mm: tune the page allocator thresholds

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

arcnet-fixes.patch
  arcnet fixes

netpoll-fix-null-ifa_list-pointer-dereference.patch
  netpoll: fix null ifa_list pointer dereference

e1000-stop-working-after-resume.patch
  E1000 stop working after resume

fix-for-8023ad-shutdown-issue.patch
  Fix for 802.3ad shutdown issue

x25-when-receiving-a-call-check-listening-sockets-for-matching-call-user-data.patch
  X.25: When receiving a call, check listening sockets for matching call user data.

x25-remove-unused-header-files.patch
  X.25: Remove unused header files

ixgb-fix-ixgb_intr-looping-checks.patch
  ixgb: fix ixgb_intr looping checks

xircom_tulip_cb-build-fix.patch
  xircom_tulip_cb.c build fix

ppc32-add-setup_indirect_pci_nomap-routine.patch
  ppc32: add setup_indirect_pci_nomap() routine

added-mpc8555-8541-security-block-infrastructure.patch
  ppc32: dded MPC8555/8541 security block infrastructure

ppc32-fix-rheap-warning.patch
  ppc32: fix rheap warning

ppc32-updated-reporting-of-cpu-rev-freq-for-e500-cpus.patch
  ppc32: updated reporting of CPU rev & freq for e500 CPUs

ppc32-add-performance-counters-to-cpu_spec.patch
  ppc32: add performance counters to cpu_spec

ppc32-remove-config_serial_console_baud.patch
  ppc32: remove CONFIG_SERIAL_CONSOLE_BAUD

update-ppc-list-addresses-in-maintainers.patch
  Update ppc list addresses in MAINTAINERS

ppc32-remove-__setup_cpu_8xx.patch
  ppc32: remove __setup_cpu_8xx

ppc32-remove-zero-initializations-in-cpu_specs.patch
  ppc32: remove zero initializations in cpu_specs

ppc64-iseries-combine-some-mf-code.patch
  ppc64: iSeries combine some MF code

ppc64-iseries-remove-trailing-white-space.patch
  ppc64: iSeries remove trailing white space

ppc64-iseries-remove-some-studly-caps.patch
  ppc64: iSeries remove some Studly Caps

ppc64-iseries-more-mf-cleanup.patch
  ppc64: iSeries more MF cleanup

ppc64-iseries-remove-more-studly-caps-from-mf-code.patch
  ppc64: iSeries remove more Studly Caps from MF code

ppc64-iseries-last-of-the-cleanups-fo-the-mf-code.patch
  ppc64: iSeries last of the cleanups fo the MF code

ppc64-bump-max_hwifs-in-ide-code.patch
  ppc64: Bump MAX_HWIFS in IDE code

ppc64-fix-for-cpu-hotplug-numa.patch
  ppc64: Fix for cpu hotplug + NUMA

ppc64-small-of-fixes.patch
  ppc64: Small OF fixes

remove-unnecessary-inclusions-of-asm-aouth.patch
  Remove unnecessary inclusions of asm/a.out.h

fix-page-size-assumption-in-fork.patch
  fix page size assumption in fork()

ext3-compiler-warning-fix.patch
  EXT3 compiler warning fix

termio-userspace-access-error-handling.patch
  Termio userspace access error handling

make-proc-kcore-conditional-on-config_mmu.patch
  Make /proc/kcore conditional on CONFIG_MMU

ide_arch_obsolete_init-fix.patch
  IDE_ARCH_OBSOLETE_INIT fix

out-of-line-implementation-of-find_next_bit.patch
  out-of-line implementation of find_next_bit()

gp-rel-data-support.patch
  GP-REL data support

vm-routine-fixes.patch
  VM routine fixes

frv-fujitsu-fr-v-cpu-arch-maintainer-record.patch
  FRV: Fujitsu FR-V CPU arch maintainer record

frv-fujitsu-fr-v-arch-documentation.patch
  FRV: Fujitsu FR-V arch documentation

frv-fujitsu-fr-v-cpu-arch-implementation-part-1.patch
  FRV: Fujitsu FR-V CPU arch implementation part 1

frv-fujitsu-fr-v-cpu-arch-implementation-part-2.patch
  FRV: Fujitsu FR-V CPU arch implementation part 2

frv-fujitsu-fr-v-cpu-arch-implementation-part-3.patch
  FRV: Fujitsu FR-V CPU arch implementation part 3

frv-fujitsu-fr-v-cpu-arch-implementation-part-4.patch
  FRV: Fujitsu FR-V CPU arch implementation part 4

frv-fujitsu-fr-v-cpu-arch-implementation-part-5.patch
  FRV: Fujitsu FR-V CPU arch implementation part 5

frv-fujitsu-fr-v-cpu-arch-implementation-part-6.patch
  FRV: Fujitsu FR-V CPU arch implementation part 6

frv-fujitsu-fr-v-cpu-arch-implementation-part-7.patch
  FRV: Fujitsu FR-V CPU arch implementation part 7

frv-fujitsu-fr-v-cpu-arch-implementation-part-8.patch
  FRV: Fujitsu FR-V CPU arch implementation part 8

frv-fujitsu-fr-v-cpu-arch-implementation-part-9.patch
  FRV: Fujitsu FR-V CPU arch implementation part 9

frv-first-batch-of-fujitsu-fr-v-arch-include-files.patch
  FRV: First batch of Fujitsu FR-V arch include files

frv-more-fujitsu-fr-v-arch-include-files.patch
  FRV: More Fujitsu FR-V arch include files

frv-yet-more-fujitsu-fr-v-arch-include-files.patch
  FRV: Yet more Fujitsu FR-V arch include files

frv-remaining-fujitsu-fr-v-arch-include-files.patch
  FRV: Remaining Fujitsu FR-V arch include files

frv-make-calibrate_delay-optional.patch
  FRV: Make calibrate_delay() optional

frv-better-mmap-support-in-uclinux.patch
  FRV: Better mmap support in uClinux

frv-procfs-changes-for-nommu-changes.patch
  FRV: procfs changes for nommu changes

frv-change-setup_arg_pages-to-take-stack-pointer.patch
  FRV: change setup_arg_pages() to take stack pointer

frv-change-setup_arg_pages-to-take-stack-pointer-fixes.patch
  Fix usage of setup_arg_pages() in IA64, MIPS, S390 and Sparc64

frv-add-fdpic-elf-binary-format-driver.patch
  FRV: Add FDPIC ELF binary format driver

ppc64-reloc_hide.patch

superhyway-bus-support.patch
  SuperHyway bus support

add-cpu_relax-in-spin-loops-clean-up-barrier-for-269.patch
  add cpu_relax() in spin loops & clean up barrier()

optimize-stack-pointer-access-reduce-register-usage.patch
  x86: optimize stack pointer access (reduce register usage)

x86_64-ia32_aout-build-fix.patch
  x86_64: ia32_aout-build-fix

cris-architecture-update-configuration-and-build.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 1/10] CRIS architecture update - Configuration and Build

cris-architecture-update-update-simple-drivers.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 2/10] CRIS architecture update - Update simple drivers

cris-architecture-update-ethernet-driver.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 3/10] CRIS architecture update - Ethernet driver

cris-architecture-update-ide-driver.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 4/10] CRIS architecture update - IDE driver

cris-architecture-update-add-usb-host-driver.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 5/10] CRIS architecture update - Add USB host driver

cris-architecture-update-core-kernel-updates.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 6/10] CRIS architecture update - Core kernel updates.

cris-architecture-update-console-setup-handling.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 7/10] CRIS architecture update - Console setup handling.

cris-architecture-update-move-drivers.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 8/10] CRIS architecture update - Move drivers.

cris-architecture-update-update-makefiles.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 9/10] CRIS architecture update - Update Makefiles.

cris-architecture-update-update-maintainers.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 10/10] CRIS architecture update - Update MAINTAINERS.

uml-use-sys_getpid-bypassing-glibc-fixes-uml-on-gentoo.patch
  uml: use sys_getpid bypassing glibc (fixes UML on Gentoo)

futex_wait-fix.patch
  futex_wait hang fix

enhanced-i-o-accounting-data-patch.patch
  enhanced I/O accounting data patch

enhanced-memory-accounting-data-collection.patch
  enhanced Memory accounting data collection

enhanced-memory-accounting-data-collection-tidy.patch
  enhanced-memory-accounting-data-collection-tidy

ext3-umount-hang.patch
  ext3 umount hang

wacom-tablet-driver.patch
  wacom tablet driver

sparc32-fix-for-hypersparc-dma-errors.patch
  sparc32: fix for HyperSPARC DMA errors

bad-naming-of-structures-and-functions-in-ext3-reservation-code.patch
  "Bad" naming of structures and functions in ext3 reservation code

statfs-compat-functions-can-return-eoverflow-on-nfs.patch
  statfs compat functions can return EOVERFLOW on NFS

sysfs-fix-dropping-existing-dir.patch
  sysfs: fix dropping existing dir

force-feedback-support-for-uinput.patch
  Force feedback support for uinput

force-feedback-support-for-uinput-cleanup.patch
  force-feedback-support-for-uinput cleanup

kmap_atomic-takes-char.patch
  kmap_atomic takes char*

kmap_atomic-fallout.patch
  kmap_atomic fallout

drm_memory-warning-fix.patch
  drm_memory.h warning fix

radix_tree_delete-fix.patch
  radix_tree_delete() fix

oprofile-add-check_user_page_readable.patch
  oprofile: add check_user_page_readable()

oprofile-arch-independent-code-for-stack-trace.patch
  oprofile: arch-independent code for stack trace sampling

oprofile-i386-support-for-stack-trace-sampling.patch
  oprofile: i386 support for stack trace sampling

oprofile-i386-support-for-stack-trace-sampling-fix.patch
  oprofile-i386-support-for-stack-trace-sampling x86_64 fix

oprofile-ia64-support-for-oprofile-stack-trace.patch
  oprofile: ia64 support for oprofile stack trace sampling

oprofile-update-alpha-for-api-changes.patch
  oprofile: update alpha for api changes

oprofile-update-arm-for-api-changes.patch
  oprofile: update arm for api changes

oprofile-update-ppc-for-api-changes.patch
  oprofile: update ppc for api changes

oprofile-update-parisc-for-api-changes.patch
  oprofile: update parisc for api changes

oprofile-update-s390-for-api-changes.patch
  oprofile: update s390 for api changes

oprofile-update-sh-for-api-changes.patch
  oprofile: update sh for api changes

oprofile-update-sparc64-for-api-changes.patch
  oprofile: update sparc64 for api changes

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
  kgdb-is-incompatible-with-kprobes
  kgdb-ga-build-fix

kgdb-ga-fixes.patch
  kgdb-ga-fixes

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix
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

schedc-whitespace-mangler.patch
  sched.c whitespace mangler

sched-alter_kthread_prio.patch
  sched: alter_kthread_prio

sched-adjust_timeslice_granularity.patch
  sched: adjust_timeslice_granularity

sched-add_requeue_task.patch
  sched: add_requeue_task

requeue_granularity.patch
  sched: requeue_granularity

sched-remove_interactive_credit.patch
  sched: remove_interactive_credit

sched-use-cached-current-value.patch
  sched: use cached current value

dont-hide-thread_group_leader-from-grep.patch
  don't hide thread_group_leader() from grep

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions

add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix.patch
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix

add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix-fix.patch
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

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

v4l-yet-another-video-buf-interface-update.patch
  v4l: yet another video-buf interface update

v4l-add-video-buf-dvbc.patch
  v4l: add video-buf-dvb.c

v4l-bttv-update.patch
  v4l: bttv update

v4l-bttv-update-fix.patch
  bttv static build fix

v4l-bttv-update-fix2.patch
  remove stale bttv_parse prototype

v4l-saa7134-update.patch
  v4l: saa7134 update

v4l-cx88-update.patch
  v4l: cx88 update

v4l-saa7146-update.patch
  v4l: saa7146 update

v4l-tuner-modparam.patch
  v4l: tuner modparam

v4l-ir-common-modparam.patch
  v4l: ir-common modparam

v4l-v4l1-compat-modparam.patch
  v4l: v4l1-compat modparam

v4l-msp3400-fix.patch
  v4l: msp3400 fix

media-video-bw-qcamc-remove-an-unused-function.patch
  media/video/bw-qcam.c: remove an unused function

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

crashdump-routines-for-copying-dump-pages-kmap-fiddle.patch
  crashdump-routines-for-copying-dump-pages-kmap-fiddle

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

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

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

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

reiser4-kmap-atomic-fixes.patch
  reiser4 kmap_atomic fixes

resier4-export-shrink_dcache_anon.patch
  resier4: export shrink_dcache_anon

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

mpsc-driver-patch.patch
  serial: MPSC driver

mpsc-driver-patch-fix.patch
  serial: add PORT_MPSC to <linux/serial_core.h>

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

fbdev-fix-io-access-in-rivafb-part-2.patch
  fbdev: Fix IO access in rivafb (part 2)

fbdev-fix-mode-handling-in-rivafb-if-with-no-edid.patch
  fbdev: Fix mode handling in rivafb if with no EDID

fbdev-use-soft_cursor-in-i810fb.patch
  fbdev: Use soft_cursor in i810fb

fbdev-set-color-depth-to-8-if-in-pseudocolor-in-vesafb.patch
  fbdev: Set color depth to 8 if in pseudocolor in vesafb.

fbcon-split-set_con2fb_map.patch
  fbcon: Split set_con2fb_map()

fbdev-introduce-fb_blank_-constants.patch
  fbdev: Introduce FB_BLANK_* constants

fbdev-convert-drivers-to-use-the-new-fb_blank_-constants.patch
  fbdev: Convert drivers to use the new FB_BLANK_* constants

fbdev-fix-broken-fb_blank-implementation.patch
  fbdev: Fix broken fb_blank() implementation.

fbdev-add-vram-option-to-intelfb.patch
  fbdev: Add vram option to intelfb

fbdev-fix-for-using-16-pixel-wide-font-in-fb-console.patch
  fbdev: Fix for using >16 pixel wide font in fb console

fbdev-support-for-bigger-than-16x32-fonts-in-softcursor.patch
  fbdev: Support for bigger than 16x32 fonts in softcursor

fbdev-support-for-bigger-than-16x32-fonts-in-rivafb-cursor.patch
  fbdev: Support for bigger than 16x32 fonts in rivafb cursor

fbcon-disable-fbcon-cursor-if-vt-softcursor-is-enabled.patch
  fbcon: Disable fbcon cursor if vt softcursor is enabled

fbdev-allow-mode-change-even-if-edid-block-is-not-found.patch
  fbdev: Allow mode change even if EDID block is not found

fbdev-fix-cursor-in-doublescan-mode-in-atyfb.patch
  fbdev: Fix cursor in doublescan mode in atyfb

fbdev-fix-typo-in-atyfb.patch
  fbdev: Fix typo in atyfb

fbdev-change-the-find_mode-behavior.patch
  fbdev: Change the find_mode behavior

md-fix-problem-with-md-linear-for-devices-larger-than-2-terabytes.patch
  md: fix problem with md/linear for devices larger than 2 terabytes

md-fix-raid6-problem.patch
  md: fix raid6 problem

md-delete-unplug-timer-before-shutting-down-md-array.patch
  md: delete unplug timer before shutting down md array

md-delete-unplug-timer-before-shutting-down-md-array-cleanup.patch
  md-delete-unplug-timer-before-shutting-down-md-array-cleanup

blk_sync_queue-updates.patch
  blk_sync_queue() updates

blk_sync_queue-updates-update.patch
  blk_sync_queue-updates update

md-faulty-personality.patch
  md: "Faulty" personality

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

use-mmiowb-in-qla1280c.patch
  use mmiowb in qla1280.c

readpage-vs-invalidate-fix.patch
  readpage-vs-invalidate fix

invalidate_inode_pages-mmap-coherency-fix.patch
  invalidate_inode_pages2() mmap coherency fix

yenta_socketc-fix-missing-pci_disable_dev.patch
  yenta_socket.c: Fix missing pci_disable_dev

yenta-dont-enable-read-prefetch-on-older-o2-bridges.patch
  yenta: don't enable read prefetch on older o2 bridges.

cputime-introduce-cputime.patch
  cputime: introduce cputime

cputime-introduce-cputime-fix.patch
  cputime-introduce-cputime fix

cputime-fix-do_setitimer.patch
  cputime: fix do_setitimer.

cputime-missing-pieces.patch
  cputime: missing pieces.

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

lock-initializer-unifying-batch-2-scsi.patch
  Lock initializer unifying: SCSI

lock-initializer-unifying-batch-2-drivers-serial.patch
  Lock initializer unifying: drivers/serial

lock-initializer-unifying-batch-2-filesystems.patch
  Lock initializer unifying: Filesystems

lock-initializer-unifying-batch-2-video.patch
  Lock initializer unifying: Video

lock-initializer-unifying-batch-2-sound.patch
  Lock initializer unifying: sound

remove-duplicate-safe_for_readread_buffer-entry-in-scsi_ioctlc.patch
  Remove duplicate safe_for_read(READ_BUFFER) entry in scsi_ioctl.c

md-documentation-mdtxt-update.patch
  md: Documentation/md.txt update

convert-module_parm-to-module_param-family.patch
  convert MODULE_PARM() to module_param() family

more-module_parm-conversions.patch
  more MODULE_PARM conversions

kill-lockd_symsc.patch
  kill lockd_syms.c

aic-warning-fix.patch
  aic warning fix

lib-parser-fix-%%-parsing.patch
  lib/parser: fix %% parsing

make-cdev_get-static-unexport.patch
  make cdev_get static, unexport

unexport-task_nice.patch
  unexport task_nice

limit-CONFIG_LEGACY_PTY_COUNT.patch
  limit CONFIG_LEGACY_PTY_COUNT



