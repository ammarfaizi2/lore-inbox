Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbUK3R71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbUK3R71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbUK3R70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:59:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:52704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262225AbUK3RvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:51:07 -0500
Date: Tue, 30 Nov 2004 09:50:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc2-mm4
Message-Id: <20041130095045.090de5ea.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/

- Various fixes and cleanups

- A decent-sized x86_64 update.

- x86_64 supports a fourth VM zone: ZONE_DMA32.  This may affect memory
  reclaim, but shouldn't.



Changes since 2.6.10-rc2-mm3:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-i2c.patch
 bk-ide-dev.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-jfs.patch
 bk-libata.patch
 bk-mtd.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch
 bk-serial.patch
 bk-usb.patch
 bk-watchdog.patch

 Latest versions of external trees.

-map-unix-seqpacket-sockets-to-appropriate.patch
-serial-add-support-for-dell-remote-access-card-4.patch
-proc-cmdline-missing-mmput.patch
-smc91c92_cs-silly.patch
-fix-typo-in-init-kconfig.patch
-mtd_xip-dependencies-fix.patch
-m68k-hp300-dio-bus-fix-typo-in-dio_resource_len.patch
-m68k-hp-lance-ethernet-fix-leaks-on-probe-removal.patch
-m68k-update-hp300-defconfig-enable-dio-and-hp-lance-ethernet.patch
-m68k-update-atari-defconfig-enable-ethernet-and-mii.patch
-make-ibmveth-link-always-up.patch
-tulip-make-tulip_stop_rxtx-wait-for-dma-to-fully-stop.patch
-ppc32-have-the-8260-board-hook-happen-a-bit-later.patch
-ppc32-fix-__iomem-warnings-in-todc-code.patch
-ppc32-fix-an-irq-issue-with-cpufreq.patch
-ppc64-fix-compilation-with-recent-toolchains.patch
-ppc64-linuxrtas-fixes.patch
-ppc64-reserve-kernel-memory-in-kernel-instead-of-wrapper.patch
-ppc64-linuxtce-changes.patch
-ppc64-make-early-processor-spinup-based-on-physical-ids.patch
-ppc64-remove-the-volatile-from-cpus_in_xmon.patch
-ptrace-locked-accesss-to-ptrace-last_siginfo.patch
-mc146818rtch-include-fix.patch
-video-buf-oops-crash-fixes.patch
-v4l-disable-unused-function.patch
-v4l-more-modparam.patch
-tuner-update.patch
-mm-only-fixed-pmd_order-for-mips.patch

 Merged

+raid10-overwrites-partition-tables.patch

 RAID10 fix

+3c59x-add-eeprom_reset-for-3c900-boomerang.patch

 3com net driver fix

+mips-updates.patch

 Huge mips arch update

+cfq-iosched-kill-show_status-sysfs-entry.patch

 Kill a buggy debugging function in cfq-iosched.

+buffer-overrun-in-arch-x86_64-sys_ia32csys32_ni_syscall.patch

 x86_64's not-implemented syscall is incorrectly implemented.

+register_disk-hack.patch
+register_disk-hack-warnings.patch

 Might prevent some crash related to usb-storage.

+x86-fix-reboot-hang--apic-errors.patch

 Fix dodgy APIC shutdown sequencing in bk-acpi.patch

+ixgb-lr-card-support.patch

 Additional device support.

+vmlib-wrapped-executable-brk.patch
+vmlib-wrapped-mprotect-flags.patch

 Fix /proc/meminfo:VmLib

-net-socketcsys_bind-cleanup.patch

 Dropped - it made slight functional changes (looked OK to me though).

+net-netconsole-poll-support-for-3c509.patch

 netconsole-via-3c509.

+avoid-deadlock-in-smc91x-driver.patch

 Fix a deadlock in this net driver

+ppc32-marvell-host-bridge-support-mv64x60-review-fixes.patch

 Fix things in ppc32-marvell-host-bridge-support-mv64x60.patch

+ppc32-ppc4xx-pic-rewrite-cleanup.patch

 ppc32 fixups

+ppc64-tweaks-to-cpu-sysfs-information.patch

 ppc64 susfs updates

+frv-pci-dma-fixes.patch
+fix-frv-pci-config-space-write.patch

 FRV architecture fixes

+assign-pkmap_base-dynamically.patch

 x86 pkmap layout fix

+x86_64-do_general_protection-retval-check.patch
+x86_64-add-a-real-pfn_valid.patch
+x86_64-make-irda-devices-are-not-really-isa-devices-not.patch
+x86_64-fix-bugs-in-the-amd-k8-cmp-support-code.patch
+x86_64-reenable-mga-dri-on-x86-64.patch
+x86_64-remove-duplicated-fake_stack_frame-macro.patch
+x86_64-remove-bios-reboot-code.patch
+x86_64-add-reboot=force.patch
+x86_64-collected-ioremap-fixes.patch
+x86_64-handle-nx-correctly-in-pageattr.patch
+x86_64-split-acpi-boot-table-parsing.patch
+x86_64-add-srat-numa-discovery-to-x86-64.patch
+x86_64-update-uptime-after-suspend.patch
+x86_64-cleanups-preparing-for-memory-hotplug.patch
+x86_64-allow-a-kernel-debugger-to-hide-single-steps-in.patch
+x86_64-remove-debug-information-for-vsyscalls.patch
+x86_64-rename-htvalid-to-cmp_legacy.patch
+x86_64-scheduler-support-for-amd-cmp.patch
+x86_64-add-a-missing-__iomem-pointed-out-by-linus.patch
+x86_64-add-a-missing-newline-in-proc-cpuinfo.patch
+x86_64-add-sysfs-file-to-map-pci-busses-to-cpus-warning-fix.patch
+x86_64-always-print-segfaults-for-init.patch
+x86_64-export-phys_proc_id.patch
+x86_64-allow-to-configure-more-cpus-and-nodes.patch
+x86_64-allow-to-configure-more-cpus-and-nodes-fix.patch
+x86_64-fix-a-warning-in-the-cmp-support-code-for.patch
+x86_64-fix-some-outdated-assumptions-that-cpu-numbers.patch
+x86_64-fix-em64t-config-description.patch
+x86_64-remove-unneeded-ifdef-in-hardirqh.patch
+x86_64-add-slit-inter-node-distance-information-to.patch
+x86_64-add-x86_64-support-for-jack-steiners-slit-sysfs.patch
+x86_64-eliminate-some-useless-printks-in-acpi-numac.patch

 x86_64 updates

+x86_64-experimental-4gb-dma-zone.patch

 Add a fourth memory zone on x86_64: ZONE_DMA32
 
+swsusp-kconfig-change-in-wording-fwd.patch
+typeofdev-powersaved_state.patch

 power management tweaks

+uml-fix-some-ptrace-functions-returns-values.patch
+uml-redo-the-signal-delivery-mechanism.patch
+uml-make-restorer-match-i386.patch
+uml-unistdh-cleanup.patch
+uml-remove-a-quilt-induced-duplicity.patch
+uml-fix-sigreturn-to-not-copy_user-under-a-spinlock.patch
+uml-close-host-file-descriptors-properly.patch
+uml-free-host-resources-associated-with-freed-irqs.patch
+uml-unregister-signal-handlers-at-reboot.patch
+uml-terminal-cleanup.patch

 UML udpates

+s390-remove-compat-setup_arg_pages32.patch

 Remove unneeded function

+time-run-too-fast-after-s3.patch

 Fix timekeeping after resume

+fork-total_forks-not-counted-under-tasklist_lock.patch

 Small locking fix

+suppress-might_sleep-if-oopsing.patch

 Don't emit might_sleep warnings after the kernel has oopsed

+i4l-fix-deadlock-in-capi-code-reenable-smp.patch

 ISDN deadlock fix

+cont_prepare_write-fix.patch

 Fix data loss via cont_prepare_write()

+fix-an-xfs-direct-i-o-deadlock.patch

 XFS direct-io deadlock fix

+file-sync-no-i_sem.patch

 Reduce i_sem coverage during sync operations

+generic_make_request-stack-savings.patch

 Save some stack space in the disk I/O submission path

+sys_stime-needs-a-compat-function.patch
+sys_stime-needs-a-compat-function-fix.patch
+sys_stime-needs-a-compat-function-fix-fix.patch

 Add compat wrapper for sys_stime().  Clean up (and break) several other
 things.

+sync-in-core-time-granuality-with-filesystems.patch
+sync-in-core-time-granuality-with-filesystems-sonypi-fix.patch

 Fix up the mtime-went-backwards-because-the-inode-was-reclaimed problem.

+use-pid_alive-in-proc_pid_status.patch

 Might fix a /proc oops

+fix-parameter-handling-in-ibm_acpic.patch

 Fix this driver

+remove-ip2-programs.patch

 Remove not-working userspace code from the kernel

+rcu-eliminate-rcu_ctrlblklock.patch
+rcu-eliminate-rcu_datalast_qsctr.patch

 RCU cleanups

+smb_file_open-retval-fix.patch

 Fix smb_file_open() return value.

+shmctl-shm_lock-perms.patch

 Fix locking permissions in shared memory.

+sys_sched_setaffinity-on-up-should-fail-for-non-zero.patch

 setaffinity() bounds checking fix

+fix-occasional-stop_machine-lockup-with-2-cpus.patch

 Fix rare CPU hotplug lockup

+Add-PCI-quirks-for-ASUS-M6Ne-notebook.patch

 Add a quirk for this notebook's smbus

+vfs_quota_off-oops-fix.patch
+quota-umount-race-fix.patch

 Fixes to the quota code in -mm

-oprofile-i386-support-for-stack-trace-sampling-tidy.patch

 Drop this - it could cause weird false positives with spinlock debugging
 enabled.

+oprofile-minor-cleanups.patch

 oprofile cleanup

+pcmcia-add-disable_clkrun-option.patch

 Add a disable_clkrun option to the yenta driver to work around some hardware
 bugs.

+dvb-follow-changes-in-dvb-ttpci-and-budget-drivers-linkage-fix.patch

 Fix a -mm-only DVB patch.

+perfctr-x86-update-2.patch
+perfctr-ppc32-update-2.patch
+perfctr-virtual-update.patch

 perfctr updates

+oprofile-preempt-warning-fixes.patch

 Fix false positives in the preempt debugging code

+add-page-becoming-writable-notification-fix.patch

 Fix add-page-becoming-writable-notification.patch for other changes in -mm.

+kexec-apic-virt-wire-fix.patch

 Fix kexec APIC handling

+kexec-ppc-support.patch

 Restore kexec-for-ppc32

+reiser4-fix-a-use-after-free-bug-in-reiser4_parse_options.patch

 Reiser4 fix

+fbdev-sis-framebuffer-driver-update-1717.patch

 Update the SiS framebuffer driver

+remove-export_symbol_novers.patch

 Remove EXPORT_SYMBOL_NOVERS

+documentation-for-ide-and-cdrom-ioctls.patch

 Documentation

-bad-ipc-shared-memory-defaults.patch

 This wasn't obviously the right thing to do.

+remove-early_param-tests.patch
+MODULE_PARM-allmod.patch
+MODULE_PARM-allyes.patch

 Lots of MODULE_PARM conversions

+fix-typo-in-cdromc.patch

 Small fix for the cdrom driver.

+lockd-fix-two-struct-definitions.patch
+small-mca-cleanups-fwd.patch
+small-drivers-media-radio-cleanups-fwd.patch

 Small cleanups

+make-number-of-ramdisks-kconfigurable.patch
+make-number-of-ramdisks-kconfigurable-tidy.patch

 Allow build-time configuration of the maximum number of ramdisks.



number of patches in -mm: 618
number of changesets in external trees: 745
number of patches in -mm only: 598
total patches: 1343



All 618 patches:


linus.patch

raid10-overwrites-partition-tables.patch
  RAID10 overwrites partition tables

3c59x-reload-eeprom-values-at-rmmod-for-needy-cards.patch
  3c59x: reload EEPROM values at rmmod for needy cards

3c59x-remove-eeprom_reset-for-3c905b.patch
  3c59x: remove EEPROM_RESET for 3c905B

3c59x-add-eeprom_reset-for-3c900-boomerang.patch
  3c59x: Add EEPROM_RESET for 3c900 Boomerang

mips-updates.patch
  MIPS updates

cfq-iosched-kill-show_status-sysfs-entry.patch
  cfq-iosched: kill show_status sysfs entry

buffer-overrun-in-arch-x86_64-sys_ia32csys32_ni_syscall.patch
  Buffer overrun in arch/x86_64/sys_ia32.c:sys32_ni_syscall()

register_disk-hack.patch
  register_disk hack

register_disk-hack-warnings.patch
  register_disk-hack-warnings

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

4level-ia64-support-fix.patch
  4level-ia64-support fix

pml4-ia64-build-fix.patch
  Fix ia64 pml4 build problem

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

4level-architecture-changes-for-s390-fix.patch
  4level-architecture-changes-for-s390 fix

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

uml-pml4-support.patch
  uml: pml4 support

uml-config_highmem-atomicity-fix.patch
  uml: CONFIG_HIGHMEM atomicity fix

bk-acpi.patch

x86-fix-reboot-hang--apic-errors.patch
  x86: fix reboot hang / APIC errors

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

acpi-flush-tlb-when-pagetable-changed.patch
  acpi: flush TLB when pagetable changed

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-driver-core.patch

bk-drm.patch

bk-i2c.patch

bk-ide-dev.patch

bk-input.patch

bk-dtor-input.patch

bk-jfs.patch

bk-libata.patch

bk-mtd.patch

bk-netdev.patch

ixgb-lr-card-support.patch
  ixgb LR card support

bk-ntfs.patch

bk-pci.patch

bk-scsi.patch

bk-serial.patch

bk-usb.patch

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

numa-policies-for-file-mappings-mpol_mf_move.patch
  NUMA policies for file mappings + MPOL_MF_MOVE

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

mempolicy-optimization.patch
  mempolicy optimisation

mm-overcommit-updates.patch
  mm: overcommit updates

kill-off-highmem_start_page.patch
  kill off highmem_start_page

make-sure-ioremap-only-tests-valid-addresses.patch
  make sure ioremap only tests valid addresses

vmlib-wrapped-executable-brk.patch
  VmLib wrapped: executable brk

vmlib-wrapped-mprotect-flags.patch
  VmLib wrapped: mprotect flags

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

arcnet-fixes.patch
  arcnet fixes

x25-when-receiving-a-call-check-listening-sockets-for-matching-call-user-data.patch
  X.25: When receiving a call, check listening sockets for matching call user data.

x25-remove-unused-header-files.patch
  X.25: Remove unused header files

xircom_tulip_cb-build-fix.patch
  xircom_tulip_cb.c build fix

m68k-ethernet-drivers-depend-on-net_ethernet.patch
  M68k Ethernet drivers depend on NET_ETHERNET

m68k-hp-lance-ethernet-depends-on-dio-bus-support.patch
  M68k HP Lance Ethernet depends on DIO bus support

net-socketc__sock_create-cleanup.patch
  net/socket.c::__sock_create() cleanup.

net-netconsole-poll-support-for-3c509.patch
  net: Netconsole poll support for 3c509

avoid-deadlock-in-smc91x-driver.patch
  Avoid deadlock in smc91x driver

ppc32-freescale-book-e-mmu-cleanup.patch
  ppc32: freescale Book-E MMU cleanup

ppc32-refactor-common-book-e-exception-code.patch
  ppc32: refactor common book-e exception code

ppc32-switch-to-kbuild_defconfig.patch
  ppc32: Switch to KBUILD_DEFCONFIG

ppc32-marvell-host-bridge-support-mv64x60.patch
  ppc32: Marvell host bridge support (mv64x60)

ppc32-marvell-host-bridge-support-mv64x60-review-fixes.patch
  ppc32-marvell-host-bridge-support-mv64x60 review fixes

ppc32-support-for-marvell-ev-64260-bp-eval-platform.patch
  ppc32: support for Marvell EV-64260[ab]-BP eval platform

ppc32-support-for-artesyn-katana-cpci-boards.patch
  ppc32: support for Artesyn Katana cPCI boards

ppc32-ppc4xx-pic-rewrite-cleanup.patch
  ppc32: PPC4xx PIC rewrite/cleanup

ppc64-kprobes-implementation.patch
  ppc64: kprobes implementation

ppc64-tweaks-to-cpu-sysfs-information.patch
  ppc64: tweaks to ppc64 cpu sysfs information

ppc64-fix-signal-mask-on-delivery-error.patch
  ppc64: fix signal mask on delivery error

ppc64-reloc_hide.patch

kprobes-wrapper-to-define-jprobeentry.patch
  Kprobes: wrapper to define jprobe.entry

remove-unnecessary-inclusions-of-asm-aouth.patch
  Remove unnecessary inclusions of asm/a.out.h

termio-userspace-access-error-handling.patch
  Termio userspace access error handling

ide_arch_obsolete_init-fix.patch
  IDE_ARCH_OBSOLETE_INIT fix

out-of-line-implementation-of-find_next_bit.patch
  out-of-line implementation of find_next_bit()

gp-rel-data-support.patch
  GP-REL data support

vm-routine-fixes.patch
  VM routine fixes

vm-routine-fixes-CONFIG_SHMEM-fix.patch
  vm-routine-fixes CONFIG_SHMEM fix

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

frv-kill-off-highmem_start_page.patch
  kill off highmem_start_page

frv-first-batch-of-fujitsu-fr-v-arch-include-files.patch
  FRV: First batch of Fujitsu FR-V arch include files

frv-remove-obsolete-hardirq-stuff-from-includes.patch
  frv: emove obsolete hardirq stuff from includes

frv-pci-dma-fixes.patch
  frv: PCI DMA fixes

fix-frv-pci-config-space-write.patch
  frv: Fix PCI config space write

frv-more-fujitsu-fr-v-arch-include-files.patch
  FRV: More Fujitsu FR-V arch include files

convert-frv-to-use-remap_pfn_range.patch
  convert FRV to use remap_pfn_range

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

further-nommu-changes.patch
  Further nommu changes

further-nommu-proc-changes.patch
  Further nommu /proc changes

frv-arch-nommu-changes.patch
  frv: nommu changes

superhyway-bus-support.patch
  SuperHyway bus support

assign-pkmap_base-dynamically.patch
  Assign PKMAP_BASE dynamically

x86-remove-data-header-and-code-overlap-in-boot-setups.patch
  x86: remove data-header and code overlap in boot/setup.S

intel-thermal-monitor-for-x86_64.patch
  Intel thermal monitor for x86_64

x86_64-do_general_protection-retval-check.patch
  x86_64: do_general_protection() retval check

x86_64-add-a-real-pfn_valid.patch
  x86_64: Add a real pfn_valid

x86_64-make-irda-devices-are-not-really-isa-devices-not.patch
  x86_64: Make IRDA devices are not really ISA devices not depend on CONFIG_ISA.

x86_64-fix-bugs-in-the-amd-k8-cmp-support-code.patch
  x86_64: Fix bugs in the AMD K8 CMP support code.

x86_64-reenable-mga-dri-on-x86-64.patch
  x86_64: Reenable MGA DRI on x86-64

x86_64-remove-duplicated-fake_stack_frame-macro.patch
  x86_64: Remove duplicated FAKE_STACK_FRAME macro.

x86_64-remove-bios-reboot-code.patch
  x86_64: Remove BIOS reboot code

x86_64-add-reboot=force.patch
  x86_64: Add reboot=force

x86_64-collected-ioremap-fixes.patch
  x86_64: Collected ioremap fixes

x86_64-handle-nx-correctly-in-pageattr.patch
  x86_64: Handle NX correctly in pageattr

x86_64-split-acpi-boot-table-parsing.patch
  x86_64: Split ACPI boot table parsing

x86_64-add-srat-numa-discovery-to-x86-64.patch
  x86_64: Add SRAT NUMA discovery to x86-64.

x86_64-update-uptime-after-suspend.patch
  x86_64: Update uptime after suspend

x86_64-cleanups-preparing-for-memory-hotplug.patch
  x86_64: Cleanups preparing for memory hotplug

x86_64-allow-a-kernel-debugger-to-hide-single-steps-in.patch
  x86_64: Allow a kernel debugger to hide single steps in more cases.

x86_64-remove-debug-information-for-vsyscalls.patch
  x86_64: Remove debug information for vsyscalls

x86_64-rename-htvalid-to-cmp_legacy.patch
  x86_64: Rename HTVALID to CMP_LEGACY

x86_64-scheduler-support-for-amd-cmp.patch
  x86_64: Scheduler support for AMD CMP

x86_64-add-a-missing-__iomem-pointed-out-by-linus.patch
  x86_64: Add a missing __iomem pointed out by Linus.

x86_64-add-a-missing-newline-in-proc-cpuinfo.patch
  x86_64: Add a missing newline in /proc/cpuinfo

x86_64-add-sysfs-file-to-map-pci-busses-to-cpus-warning-fix.patch
  x86_64-add-sysfs-file-to-map-pci-busses-to-cpus-warning-fix

x86_64-always-print-segfaults-for-init.patch
  x86_64: Always print segfaults for init.

x86_64-export-phys_proc_id.patch
  x86_64: Export phys_proc_id

x86_64-allow-to-configure-more-cpus-and-nodes.patch
  x86_64: Allow to configure more CPUs and nodes.

x86_64-allow-to-configure-more-cpus-and-nodes-fix.patch
  x86_64-allow-to-configure-more-cpus-and-nodes fix

x86_64-fix-a-warning-in-the-cmp-support-code-for.patch
  x86_64: Fix a warning in the CMP support code for !CONFIG_NUMA

x86_64-fix-some-outdated-assumptions-that-cpu-numbers.patch
  x86_64: Fix some outdated assumptions that CPU numbers are equal numbers.

x86_64-fix-em64t-config-description.patch
  x86_64: Fix EM64T config description

x86_64-remove-unneeded-ifdef-in-hardirqh.patch
  x86_64: Remove unneeded ifdef in hardirq.h

x86_64-add-slit-inter-node-distance-information-to.patch
  x86_64: Add SLIT (inter node distance) information to sysfs.

x86_64-add-x86_64-support-for-jack-steiners-slit-sysfs.patch
  x86_64: Add x86_64 support for Jack Steiner's SLIT sysfs patch

x86_64-eliminate-some-useless-printks-in-acpi-numac.patch
  x86_64: Eliminate some useless printks in ACPI numa.c

x86_64-experimental-4gb-dma-zone.patch
  x86_64: EXPERIMENTAL: 4GB DMA zone

swsusp-kconfig-change-in-wording-fwd.patch
  swsusp kconfig: Change in wording

typeofdev-powersaved_state.patch
  typeof(dev->power.saved_state)

media-update-drivers-media-video-arvc.patch
  media: Update drivers/media/video/arv.c

uml-remove-most-devfs_mk_symlink-calls.patch
  uml: remove most devfs_mk_symlink calls

uml-fix-__wrap_free-comment.patch
  uml: fix __wrap_free comment

uml-fix-some-ptrace-functions-returns-values.patch
  uml: fix some ptrace functions returns values

uml-redo-the-signal-delivery-mechanism.patch
  uml: redo the signal delivery mechanism

uml-make-restorer-match-i386.patch
  uml: make restorer match i386

uml-unistdh-cleanup.patch
  uml: unistd.h cleanup

uml-remove-a-quilt-induced-duplicity.patch
  uml: remove a quilt-induced duplicity

uml-fix-sigreturn-to-not-copy_user-under-a-spinlock.patch
  uml: fix sigreturn to not copy_user under a spinlock

uml-close-host-file-descriptors-properly.patch
  uml: close host file descriptors properly

uml-free-host-resources-associated-with-freed-irqs.patch
  uml: free host resources associated with freed IRQs

uml-unregister-signal-handlers-at-reboot.patch
  uml: unregister signal handlers at reboot

hostfs-uml-set-sendfile-to-generic_file_sendfile.patch
  hostfs: uml: set .sendfile to generic_file_sendfile

hostfs-uml-add-some-other-pagecache-methods.patch
  hostfs: uml: add some other pagecache methods

uml-terminal-cleanup.patch
  uml: terminal cleanup

s390-network-driver.patch
  s390: network driver

s390-remove-compat-setup_arg_pages32.patch
  s390: remove compat setup_arg_pages32

enhanced-i-o-accounting-data-patch.patch
  enhanced I/O accounting data patch

enhanced-memory-accounting-data-collection.patch
  enhanced Memory accounting data collection

enhanced-memory-accounting-data-collection-tidy.patch
  enhanced-memory-accounting-data-collection-tidy

wacom-tablet-driver.patch
  wacom tablet driver

force-feedback-support-for-uinput.patch
  Force feedback support for uinput

kmap_atomic-takes-char.patch
  kmap_atomic takes char*

kmap_atomic-takes-char-fix.patch
  kmap_atomic-takes-char-fix

kmap_atomic-fallout.patch
  kmap_atomic fallout

kunmap-fallout-more-fixes.patch
  kunmap-fallout-more-fixes

4-4gb-incorrect-bound-check-in-do_getname.patch
  4/4GB: Incorrect bound check in do_getname()

handle-quoted-module-parameters.patch
  handle quoted module parameters

CONFIG_SOUND_VIA82CXXX_PROCFS.patch
  Add CONFIG_SOUND_VIA82CXXX_PROCFS

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
  Allow admin to enable only some of the Magic-Sysrq functions

gen_init_cpio-symlink-pipe-socket-support.patch
  gen_init_cpio symlink, pipe and socket support

gen_init_cpio-slink_pipe_sock_2.patch
  gen_init_cpio-slink_pipe_sock_2

move-irq_enter-and-irq_exit-to-common-code.patch
  move irq_enter and irq_exit to common code

remove-unused-irq_cpustat-fields.patch
  remove unused irq_cpustat fields

reduce-false-timer_softirq-calls.patch
  reduce false TIMER_SOFTIRQ calls

reduce-false-timer_softirq-calls-tweaks.patch
  reduce-false-timer_softirq-calls-tweaks

hold-bkl-for-shorter-period-in-generic_shutdown_super.patch
  Hold BKL for shorter period in generic_shutdown_super().

cleanups-for-the-ipmi-driver.patch
  Cleanups for the IPMI driver

htree-telldir-fix.patch
  ext3 htree telldir() fix

kill-blkh.patch
  kill blk.h

ext3-cleanup-handling-of-aborted-transactions.patch
  ext3: cleanup handling of aborted transactions.

ext3-handle-attempted-delete-of-bitmap-blocks.patch
  ext3: handle attempted delete of bitmap blocks.

ext3-handle-attempted-double-delete-of-metadata.patch
  ext3: handle attempted double-delete of metadata.

cpumask_t-initializers.patch
  cpumask_t initializers

time-run-too-fast-after-s3.patch
  time runx too fast after S3

fork-total_forks-not-counted-under-tasklist_lock.patch
  fork: total_forks not counted under tasklist_lock

suppress-might_sleep-if-oopsing.patch
  suppress might_sleep() if oopsing

i4l-fix-deadlock-in-capi-code-reenable-smp.patch
  i4l: fix deadlock in CAPI code, reenable SMP

cont_prepare_write-fix.patch
  cont_prepare_write() fix

fix-an-xfs-direct-i-o-deadlock.patch
  Fix an XFS direct I/O deadlock

file-sync-no-i_sem.patch
  Reduce i_sem usage during file sync operations

generic_make_request-stack-savings.patch
  generic_make_request stack savings

sys_stime-needs-a-compat-function.patch
  sys_stime needs a compat function

sys_stime-needs-a-compat-function-fix.patch
  sys_stime-needs-a-compat-function-fix

sys_stime-needs-a-compat-function-fix-fix.patch
  sys_stime-needs-a-compat-function-fix-fix

sync-in-core-time-granuality-with-filesystems.patch
  Sync in core time granuality with filesystems

sync-in-core-time-granuality-with-filesystems-sonypi-fix.patch
  sync-in-core-time-granuality-with-filesystems-sonypi-fix

use-pid_alive-in-proc_pid_status.patch
  use pid_alive in proc_pid_status

fix-parameter-handling-in-ibm_acpic.patch
  Fix Parameter Handling in ibm_acpi.c

remove-ip2-programs.patch
  remove ip2 programs

rcu-eliminate-rcu_ctrlblklock.patch
  rcu: eliminate rcu_ctrlblk.lock

rcu-eliminate-rcu_datalast_qsctr.patch
  rcu: eliminate rcu_data.last_qsctr

smb_file_open-retval-fix.patch
  smb_file_open() retval fix

shmctl-shm_lock-perms.patch
  shmctl SHM_LOCK perms

sys_sched_setaffinity-on-up-should-fail-for-non-zero.patch
  sys_sched_setaffinity() on UP should fail for non-zero CPUs.

fix-occasional-stop_machine-lockup-with-2-cpus.patch
  Fix occasional stop_machine() lockup with > 2 CPUs

Add-PCI-quirks-for-ASUS-M6Ne-notebook.patch
  Add PCI-quirks for ASUS M6Ne notebook

expose-reiserfs_sync_fs.patch
  Expose reiserfs_sync_fs()

fix-reiserfs-quota-debug-messages.patch
  Fix reiserfs quota debug messages

fix-of-quota-deadlock-on-pagelock-quota-core.patch
  Fix of quota deadlock on pagelock: quota core

vfs_quota_off-oops-fix.patch
  vfs_quota_off-oops-fix

quota-umount-race-fix.patch
  quota umount race fix

fix-of-quota-deadlock-on-pagelock-ext2.patch
  Fix of quota deadlock on pagelock: ext2

fix-of-quota-deadlock-on-pagelock-ext2-tweaks.patch
  fix-of-quota-deadlock-on-pagelock-ext2-tweaks

fix-of-quota-deadlock-on-pagelock-ext3.patch
  Fix of quota deadlock on pagelock: ext3

fix-of-quota-deadlock-on-pagelock-ext3-tweaks.patch
  fix-of-quota-deadlock-on-pagelock-ext3-tweaks

fix-of-quota-deadlock-on-pagelock-reiserfs.patch
  Fix of quota deadlock on pagelock: reiserfs

fix-of-quota-deadlock-on-pagelock-reiserfs-fix.patch
  fix-of-quota-deadlock-on-pagelock-reiserfs-fix

allow-disabling-quota-messages-to-console.patch
  Allow disabling quota messages to console

selinux-scalability-add-spin_trylock_irq-and.patch
  SELinux scalability: add spin_trylock_irq and  spin_trylock_irqsave

selinux-scalability-convert-avc-to-rcu.patch
  SELinux scalability: convert AVC to RCU

selinux-atomic_dec_and_test-bug.patch
  SELinux: atomic_dec_and_test() bug

selinux-scalability-avc-statistics-and-tuning.patch
  SELinux scalability: AVC statistics and tuning

oprofile-add-check_user_page_readable.patch
  oprofile: add check_user_page_readable()

oprofile-arch-independent-code-for-stack-trace.patch
  oprofile: arch-independent code for stack trace sampling

oprofile-arch-independent-code-for-stack-trace-rename-timer_init.patch
  oprofile-arch-independent-code-for-stack-trace: rename timer_init

oprofile-i386-support-for-stack-trace-sampling.patch
  oprofile: i386 support for stack trace sampling

oprofile-i386-support-for-stack-trace-sampling-cleanup.patch
  oprofile-i386-support-for-stack-trace-sampling-cleanup

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

oprofile-minor-cleanups.patch
  oprofile: minor cleanups

pcmcia-add-disable_clkrun-option.patch
  pcmcia: Add disable_clkrun option

pcmcia-b17-device-model-integration.patch

pcmcia-b18a-client_t-and-pcmcia_device-integration.patch

pcmcia-b18b-error-on-leftover-devices.patch

pcmcia-b19-netdevice-integration.patch

dvb-documentation-update.patch
  dvb: documentation update

dvb-collateral-frontend-changes.patch
  dvb: collateral frontend changes

dvb-collateral-frontend-changes-kconfig-fix.patch
  dvb-collateral-frontend-changes kconfig fix

saa7146-changes.patch
  dvb: saa7146 changes

dvb-frontend-driver-refactoring.patch
  dvb: frontend driver refactoring

dvb-follow-frontend-changes-in-drivers.patch
  dvb: follow frontend changes in drivers

dvb-cinergy-t2-update.patch
  dvb: Cinergy T2 update

dvb-dibusb-driver-update.patch
  dvb: dibusb driver update

dvb-core-changes.patch
  dvb: core changes

dvb-remove-dead-files.patch
  dvb: remove dead files

dvb-follow-changes-in-dvb-ttpci-and-budget-drivers.patch
  dvb: follow changes in dvb-ttpci and budget drivers

dvb-follow-changes-in-dvb-ttpci-and-budget-drivers-linkage-fix.patch
  dvb-follow-changes-in-dvb-ttpci-and-budget-drivers linkage fix

knfsd-nfsd_translate_wouldblocks.patch
  knfsd: nfsd_translate_wouldblocks

knfsd-svcrpc-auth_null-fixes.patch
  knfsd: svcrpc: auth_null fixes

knfsd-svcrpc-share-code-duplicated-between-auth_unix-and-auth_null.patch
  knfsd: svcrpc: share code duplicated between auth_unix and auth_null

knfsd-nfsd4-fix-open_downgrade-decode-error.patch
  knfsd: nfsd4: fix open_downgrade decode error.

knfsd-rpcsec_gss-comparing-pointer-to-0-instead-of-null.patch
  knfsd: rpcsec_gss: comparing pointer to 0 instead of NULL

knfsd-nfsd4-fix-fileid-in-readdir-responses.patch
  knfsd: nfsd4: fix fileid in readdir responses

knfsd-nfsd4-use-the-fsid-export-option-when-returning-the-fsid-attribute.patch
  knfsd: nfsd4: use the fsid export option when returning the fsid attribute

knfsd-nfsd4-encode_dirent-cleanup.patch
  knfsd: nfsd4 encode_dirent cleanup

knfsd-nfsd4-encode_dirent-superfluous-assignment.patch
  knfsd: nfsd4: encode_dirent: superfluous assignment

knfsd-nfsd4-encode_dirent-superfluous-local-variables.patch
  knfsd: nfsd4: encode_dirent: superfluous local variables

knfsd-nfsd4-encode_dirent-more-readdir-attribute-encoding-to-new-function.patch
  knfsd: nfsd4: encode_dirent: more readdir attribute encoding to new function

knfsd-nfsd4-encode_dirent-simplify-nfs4_encode_dirent_fattr.patch
  knfsd: nfsd4: encode_dirent: simplify nfs4_encode_dirent_fattr

knfsd-nfsd4-encode_dirent-move-rdattr_error-code-to-new-function.patch
  knfsd: nfsd4: encode_dirent: move rdattr_error code to new function

knfsd-nfsd4-encode_dirent-simplify-error-handling.patch
  knfsd: nfsd4: encode_dirent: simplify error handling

knfsd-nfsd4-encode_dirent-simplify-control-flow.patch
  knfsd: nfsd4: encode_dirent: simplify control flow

knfsd-nfsd4-encode_dirent-fix-dropit-return.patch
  knfsd: nfsd4: encode_dirent: fix dropit return

knfsd-nfsd4-encode_dirent-trivial-cleanup.patch
  knfsd: nfsd4: encode_dirent: trivial cleanup

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

kgdb-kill-off-highmem_start_page.patch
  kgdb: kill off highmem_start_page

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

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

sched-no-need-to-recalculate-rq.patch
  sched: no need to recalculate rq

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
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

remove-the-bkl-by-turning-it-into-a-semaphore.patch
  remove the BKL by turning it into a semaphore

oprofile-preempt-warning-fixes.patch
  oprofile preempt warning fixes

smp_processor_id-commentary.patch
  smp_processor_id() commentary

cpu_down-warning-fix.patch
  cpu_down() warning fix

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

kexec-apic-virt-wire-fix.patch
  kexec: apic-virt-wire fix

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

kexec-ppc-support.patch
  kexec: ppc support

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-memory-preserving-reboot-using-kexec-fix.patch
  kdump: Fix for boot problems on SMP

kdump-config_discontigmem-fix.patch
  kdump: CONFIG_DISCONTIGMEM fix

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

x86-rename-apic_mode_exint.patch
  x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  x86: local apic fix

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

reiser4-fix-a-use-after-free-bug-in-reiser4_parse_options.patch
  reiser4: fix a use after free bug in reiser4_parse_options

reiser4-missing-context-creation-is-added.patch
  reiser4: missing context creation is added

reiser4-crypto-update.patch
  reiser4-crypto-update

reiser4-max_cbk_iteration-fix.patch
  reiser4-max_cbk_iteration-fix

reiser4-reduce-stack-usage.patch
  reiser4-reduce-stack-usage

reiser4-fix-deadlock.patch
  reiser4-fix-deadlock

reiser4-dont-use-shrink_dcache_anon.patch
  reiser4-dont-use-shrink_dcache_anon

reiser4-kmap-atomic-fixes.patch
  reiser4 kmap_atomic fixes

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

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

3c59x-support-more-ethtool_ops.patch
  3c59x: support more ethtool_ops

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

new-serial-flow-control.patch
  new serial flow control

mpsc-driver-patch.patch
  serial: MPSC driver

vm-pageout-throttling.patch
  vm: pageout throttling

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-improve-hash-code-in-linearc.patch
  md: improve 'hash' code in linear.c

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again.patch
  make acpi_bus_register_driver() consistent with pci_register_driver()

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

selinux-adds-a-private-inode-operation.patch
  selinux: adds a private inode operation

reiserfs-private-inode-abstracted-to-static-inline.patch
  reiserfs: private inode abstracted to static inline

reiserfs-fixes-to-allow-reiserfs-to-use-selinux-attributes.patch
  reiserfs: fixes to allow reiserfs to use selinux attributes

reiserfs-cleaning-up-const-checks.patch
  reiserfs: cleaning up const checks

fbdev-sis-framebuffer-driver-update-1717.patch
  fbdev: SiS framebuffer driver update 1.7.17

raid6-altivec-support.patch
  raid6: altivec support

remove-export_symbol_novers.patch
  Remove EXPORT_SYMBOL_NOVERS

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

cputime-fix-do_setitimer.patch
  cputime: fix do_setitimer.

cputime-missing-pieces.patch
  cputime: missing pieces.

mm-check_rlimit-oops-on-p-signal.patch
  check_rlimit oops on p->signal

cputime-microsecond-based-cputime-for-s390.patch
  cputime: microsecond based cputime for s390

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

lock-initializer-unifying-batch-2-drivers-serial.patch
  Lock initializer unifying: drivers/serial

lock-initializer-unifying-batch-2-filesystems.patch
  Lock initializer unifying: Filesystems

lock-initializer-unifying-batch-2-video.patch
  Lock initializer unifying: Video

lock-initializer-unifying-batch-2-sound.patch
  Lock initializer unifying: sound

lock-initializer-cleanup-common-headers.patch
  Lock initializer cleanup (common headers)

lock-initializer-cleanup-character-devices.patch
  Lock initializer cleanup (character devices)

lock-initializer-cleanup-core.patch
  Lock initializer cleanup (Core)

documentation-for-ide-and-cdrom-ioctls.patch
  Documentation for IDE and CDROM ioctls

eth1394-module_parm-conversion.patch
  eth1394 MODULE_PARM conversion

isapnp-module_param-conversion.patch
  isapnp module_param conversion

sr-module_param-conversion.patch
  sr module_param conversion

media-video-module_param-conversion.patch
  media/video module_param conversion

btaudio-module_param-conversion.patch
  btaudio module_param conversion

small-drivers-char-rio-cleanups-fwd.patch
  small drivers/char/rio/ cleanups

small-char-generic_serialc-cleanup-fwd.patch
  small char/generic_serial.c cleanup

debug_bugverbose-for-i386-fwd.patch
  DEBUG_BUGVERBOSE for i386

telephony-ixjc-cleanup-fwd.patch
  telephony/ixj.c cleanup

char-cycladesc-remove-unused-code-fwd.patch
  char/cyclades.c: remove unused code

oss-ac97-quirk-facility.patch
  oss: AC97 quirk facility

oss-ac97-quirk-facility-fix.patch
  oss-ac97-quirk-facility fix

ext3-use-generic_open_file-to-fix-possible-preemption-bugs.patch
  ext3: use generic_open_file to fix possible preemption bugs

bttv-i2cc-make-two-functions-static.patch
  bttv-i2c.c: make two functions static

bttv-riscc-make-some-functions-static.patch
  bttv-risc.c: make some functions static

bttv-help-fix.patch
  bttv help fix

zoran_driverc-make-zoran_num_formats-static.patch
  zoran_driver.c: make zoran_num_formats static

media-video-msp3400c-remove-unused-struct-d1.patch
  media/video/msp3400.c: remove unused struct d1

zoran_devicec-make-zr36057_init_vfe-static.patch
  zoran_device.c: make zr36057_init_vfe static

drivers-media-video-the-easy-cleanups.patch
  drivers/media/video: the easy cleanups

small-ftape-cleanups-fwd.patch
  small ftape cleanups

reiser3-cleanups.patch
  reiser3 cleanups

cdromc-make-several-functions-static.patch
  cdrom.c: make several functions static (fwd)

fs-coda-psdevc-shouldnt-include-lph.patch
  fs/coda/psdev.c shouldn't include lp.h

remove-early_param-tests.patch
  remove early_param test code

MODULE_PARM-allmod.patch
  MODULE_PARM conversions

MODULE_PARM-allyes.patch
  MODULE_PARM conversions

fix-typo-in-cdromc.patch
  fix typo in cdrom.c

lockd-fix-two-struct-definitions.patch
  lockd: fix two struct definitions

small-mca-cleanups-fwd.patch
  small MCA cleanups

small-drivers-media-radio-cleanups-fwd.patch
  small drivers/media/radio/ cleanups

make-number-of-ramdisks-kconfigurable.patch
  make number of ramdisks Kconfigurable

make-number-of-ramdisks-kconfigurable-tidy.patch
  make-number-of-ramdisks-kconfigurable-tidy



