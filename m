Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbUKRKWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbUKRKWa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbUKRKWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:22:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:41703 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262710AbUKRKPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:15:50 -0500
Date: Thu, 18 Nov 2004 02:15:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc2-mm2
Message-Id: <20041118021538.5764d58c.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/

- Lots of small bugfixes.  Some against patches in -mm, some against Linus's
  tree.

- There's a patch here which should address the oom-killings which a few
  people have reported.



Changes since 2.6.10-rc2-mm1:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-ide-dev.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-libata.patch
 bk-mtd.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-scsi.patch
 bk-watchdog.patch

 Latest versions of various bk trees

-fix-duplicate-config-for-ia64_mca_recovery.patch
-ppc64-iseries-purr-emulation-fix.patch
-parport-module_param-conversion.patch

 Merged

+sched-fix-nr_uninterruptible-handling-bugs.patch

 Fix race in load average calculation

+ppc64-iseries-purr-emulation-fix.patch

 ppc64 fix

+parport_pc-config_pci=n-build-fix.patch

 parport build fix

+m32r-fix-build-error-of.patch

 m32r build fix

-fix-for-mpol-mm-corruption-on-tmpfs.patch

 Split this into three separate patches

+fix-for-mpol-mm-corruption-on-tmpfs.patch

 mempolicy-vs-tmpfs fix

+mempolicy-selects-wrong-policy-fix.patch

 mempolicy logic fix

+kprobes-vm86-interrupt-miss.patch

 kprobes fix for ia32

+fix-ia64-flush_tlb_page-build-error.patch

 build fix

+cdrom-handle-sysctl-without-proc_fs.patch

 cdrom oops fix

+move-hcdp-pcdp-to-early-uart-console-2.patch

 ia64 serial uart work

+gbefb-build-fix.patch

 fbdev driver build fix

+pml4-ia64-build-fix.patch

 4-level-pagetable build fix

+uml-config_highmem-atomicity-fix.patch

 uml fix

+acpi-flush-tlb-when-pagetable-changed.patch

 missing tlb flush

+visor-always-do-generic_startup.patch

 USB driver fix

+mempolicy-optimization.patch

 mempolicy coding tweaks

+kill-off-highmem_start_page.patch

 code cleanup

+make-sure-ioremap-only-tests-valid-addresses.patch

 ia32 ioremap() fix

+hp300-lance-leak-fixes.patch
+hp300-lance-leak-fixes-fix.patch

 lance driver fixes

+net-socketcsys_bind-cleanup.patch
+net-socketc__sock_create-cleanup.patch

 coding cleanups

+make-ibmveth-link-always-up.patch

 Fix this net driver

+tulip-make-tulip_stop_rxtx-wait-for-dma-to-fully-stop.patch

 And this one.

+ppc32-freescale-book-e-mmu-cleanup.patch
+ppc32-refactor-common-book-e-exception-code.patch

 ppc32 updates

+ppc64-move-emulate_step-to-arch-ppc64-lib.patch
+ppc64-make-pci_alloc_consistent-conform-to-api-docs.patch
+ppc64-fix-signal-mask-on-delivery-error.patch

 ppc64 fixes

+frv-kill-off-highmem_start_page.patch
+frv-remove-obsolete-hardirq-stuff-from-includes.patch
+further-nommu-changes.patch
+further-nommu-proc-changes.patch
+frv-arch-nommu-changes.patch

 FRV and nommu updates

+x86-remove-data-header-and-code-overlap-in-boot-setups.patch

 Fix up x86 assembly code section layout

+m32r-kconfigdebug-support.patch
+m32r-fix-a-boot-hang-of-up-kernel.patch
+m32r-make-zimage-a-default-build-target.patch
+m32r-io_xxxxxc-cleanups.patch
+media-update-drivers-media-video-arvc.patch

 m32r updates

+s390-remove-zfcp-hba-api-callbacks.patch

 Remove unpopular hooks from the zfcp driver

+reduce-false-timer_softirq-calls.patch
+reduce-false-timer_softirq-calls-tweaks.patch

 Small timer code speedup

+hold-bkl-for-shorter-period-in-generic_shutdown_super.patch

 Lock contention reduction

+sonypi-return-an-error-from-sonypi_camera_command-if-the-camera-isnt-enabled.patch

 Fix for sonypi driver

+uninline-do_trap-remove-get_cr2.patch

 Code shrinkage

+switch-therm_adt746x-to-new-module_param.patch

 MODULE_PARM conversions

+cleanups-for-the-ipmi-driver.patch

 IPMI driver cleanups

+network-interface-for-ipmi.patch

 Socket interface for talking to the IPMI driver (this may not have a future)

+unlocked-access-to-task-comm.patch

 Use correct locking accessing task_struct.comm

+htree-telldir-fix.patch

 ext3 htree fix

+selinux-atomic_dec_and_test-bug.patch

 Fix the SELinux scalability patches in -mm

+kgdb-kill-off-highmem_start_page.patch

 kgdb fix

-kgdb-ia64-support.patch

 Dropped due to nasty rejects in the uart driver

+reiser4-missing-context-creation-is-added.patch

 reiser4 fix

+vmscan-more-scanning.patch

 I meant to drop this.

+vmscan-ignore-swap-token-when-in-trouble.patch

 page reclaim tweaks

+raid6-altivec-support.patch

 Speed up RAID6 on some ppc/ppc64 machines

+documentation-nohighio.patch

 Documentation update

+cx88-fix-printk-arg-type.patch

 printk warning fix

+small-drivers-char-rio-cleanups-fwd.patch
+small-char-generic_serialc-cleanup-fwd.patch

 Code cleanups

+remove-outdated-oss-changelogs-fwd.patch

 Documentation update

+debug_bugverbose-for-i386-fwd.patch

 Permit the short-form BUG implemenetation on x86

+telephony-ixjc-cleanup-fwd.patch
+char-cycladesc-remove-unused-code-fwd.patch

 Code cleanups

+linux-mounth-add-atomich-and-spinlockh-includes.patch

 Build fix

+oss-ac97-quirk-facility.patch

 Add and use device quirk lists in this OSS driver

+fix-bug-3745-maybe.patch

 Maybe fix problem wherein access to /proc/pid/mem stops working when your
 parent process exits.

+smbfs-bug-3758-broken-symlinks-on-smbfs-with.patch

 smbfs back-compatibility fix



number of patches in -mm: 486
number of changesets in external trees: 529
number of patches in -mm only: 471
total patches: 1000



All 486 patches:


linus.patch

sched-fix-nr_uninterruptible-handling-bugs.patch
  sched: fix ->nr_uninterruptible handling bugs

ppc64-iseries-purr-emulation-fix.patch
  ppc64 iSeries: PURR emulation fix

parport_pc-config_pci=n-build-fix.patch
  parport_pc CONFIG_PCI=n build fix

m32r-fix-build-error-of.patch
  m32r: Fix build error of  arch/m32r/mm/fault.c

fix-for-mpol-mm-corruption-on-tmpfs.patch
  fix for mpol mm corruption on tmpfs

mempolicy-selects-wrong-policy-fix.patch
  mempolicy can select the wrong policy

kprobes-vm86-interrupt-miss.patch
  kprobes: dont steal interrupts from vm86

fix-ia64-flush_tlb_page-build-error.patch
  Fix ia64 flush_tlb_page build error

cdrom-handle-sysctl-without-proc_fs.patch
  cdrom: handle SYSCTL without PROC_FS

early-uart-console-support.patch
  early uart console support

move-hcdp-pcdp-to-early-uart-console-2.patch
  move HCDP/PCDP to early uart console

gbefb-build-fix.patch
  gbefb.c build fix

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

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

acpi-flush-tlb-when-pagetable-changed.patch
  acpi: flush TLB when pagetable changed

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-driver-core.patch

bk-drm.patch

bk-ide-dev.patch

bk-input.patch

bk-dtor-input.patch

bk-libata.patch

bk-mtd.patch

bk-netdev.patch

bk-ntfs.patch

bk-scsi.patch

megaraid-22041-driver.patch
  megaraid 2.20.4.1 Driver

visor-always-do-generic_startup.patch
  visor: Always do generic_startup

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

hp300-lance-leak-fixes.patch
  HP300 LANCE leak fixes

hp300-lance-leak-fixes-fix.patch
  hp300-lance-leak-fixes-fix

net-socketcsys_bind-cleanup.patch
  net/socket.c::sys_bind() cleanup.

net-socketc__sock_create-cleanup.patch
  net/socket.c::__sock_create() cleanup.

make-ibmveth-link-always-up.patch
  make ibmveth link always up

tulip-make-tulip_stop_rxtx-wait-for-dma-to-fully-stop.patch
  tulip: make tulip_stop_rxtx() wait for DMA to fully stop

ppc32-freescale-book-e-mmu-cleanup.patch
  ppc32: freescale Book-E MMU cleanup

ppc32-refactor-common-book-e-exception-code.patch
  ppc32: refactor common book-e exception code

ppc64-iseries-fix-viodasd-remove.patch
  ppc64 iSeries: fix viodasd remove

ppc64-move-emulate_step-to-arch-ppc64-lib.patch
  ppc64: move emulate_step to arch/ppc64/lib

ppc64-make-pci_alloc_consistent-conform-to-api-docs.patch
  ppc64: Make pci_alloc_consistent() conform to API docs

ppc64-fix-signal-mask-on-delivery-error.patch
  ppc64: fix signal mask on delivery error

ppc64-reloc_hide.patch

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

further-nommu-changes.patch
  Further nommu changes

further-nommu-proc-changes.patch
  Further nommu /proc changes

frv-arch-nommu-changes.patch
  frv: nommu changes

superhyway-bus-support.patch
  SuperHyway bus support

x86-remove-data-header-and-code-overlap-in-boot-setups.patch
  x86: remove data-header and code overlap in boot/setup.S

intel-thermal-monitor-for-x86_64.patch
  Intel thermal monitor for x86_64

m32r-kconfigdebug-support.patch
  m32r: Kconfig.debug support

m32r-fix-a-boot-hang-of-up-kernel.patch
  m32r: Fix a boot hang of UP kernel

m32r-make-zimage-a-default-build-target.patch
  m32r: make zImage a default build target

m32r-io_xxxxxc-cleanups.patch
  m32r: io_xxxxx.c cleanups

media-update-drivers-media-video-arvc.patch
  media: Update drivers/media/video/arv.c

s390-remove-zfcp-hba-api-callbacks.patch
  s390: remove zfcp hba api callbacks

s390-network-driver.patch
  s390: network driver

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

allow-nfs-exports-of-efs-filesystems.patch
  allow NFS exports of EFS filesystems

reduce-false-timer_softirq-calls.patch
  reduce false TIMER_SOFTIRQ calls

reduce-false-timer_softirq-calls-tweaks.patch
  reduce-false-timer_softirq-calls-tweaks

hold-bkl-for-shorter-period-in-generic_shutdown_super.patch
  Hold BKL for shorter period in generic_shutdown_super().

sonypi-return-an-error-from-sonypi_camera_command-if-the-camera-isnt-enabled.patch
  sonypi: return an error from sonypi_camera_command() if the camera isn't enabled

uninline-do_trap-remove-get_cr2.patch
  uninline do_trap(), remove get_cr2()

switch-therm_adt746x-to-new-module_param.patch
  Switch therm_adt746x to new module_param

cleanups-for-the-ipmi-driver.patch
  Cleanups for the IPMI driver

network-interface-for-ipmi.patch
  Network interface for IPMI

unlocked-access-to-task-comm.patch
  unlocked access to task->comm

htree-telldir-fix.patch
  ext3 htree telldir() fix

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

oprofile-i386-support-for-stack-trace-sampling-fix.patch
  oprofile-i386-support-for-stack-trace-sampling x86_64 fix

oprofile-i386-support-for-stack-trace-sampling-tidy.patch
  oprofile-i386-support-for-stack-trace-sampling tidy

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

pcmcia-b17-device-model-integration.patch

pcmcia-b18a-client_t-and-pcmcia_device-integration.patch

pcmcia-b18b-error-on-leftover-devices.patch

pcmcia-b19-netdevice-integration.patch

knfsd-nfsd_translate_wouldblocks.patch
  knfsd: nfsd_translate_wouldblocks

knfsd-svcrpc-fqdn-length-fix.patch
  knfsd: svcrpc: fqdn length fix

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

new-serial-flow-control.patch
  new serial flow control

mpsc-driver-patch.patch
  serial: MPSC driver

vm-pageout-throttling.patch
  vm: pageout throttling

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-fix-problem-with-unsigned-variable-going-negative-in-linearc.patch
  md: Fix problem with unsigned variable going "negative" in linear.c

md-improve-hash-code-in-linearc.patch
  md: improve 'hash' code in linear.c

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

fix-for-spurious-interrupts-on-e100-resume-2.patch
  Fix for spurious interrupts on e100 resume 2

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

vmscan-more-scanning.patch
  vmscan: more scanning

vmscan-ignore-swap-token-when-in-trouble.patch
  vmscan: ignore swap token when in trouble

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

raid6-altivec-support.patch
  raid6: altivec support

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

lock-initializer-cleanup-common-headers.patch
  Lock initializer cleanup (common headers)

lock-initializer-cleanup-character-devices.patch
  Lock initializer cleanup (character devices)

lock-initializer-cleanup-core.patch
  Lock initializer cleanup (Core)

documentation-nohighio.patch
  documentation: nohighio

eth1394-module_parm-conversion.patch
  eth1394 MODULE_PARM conversion

tvaudio-and-tvmixer-module_param-conversion.patch
  tvaudio and tvmixer module_param conversion

isapnp-module_param-conversion.patch
  isapnp module_param conversion

sr-module_param-conversion.patch
  sr module_param conversion

media-video-module_param-conversion.patch
  media/video module_param conversion

btaudio-module_param-conversion.patch
  btaudio module_param conversion

cx88-fix-printk-arg-type.patch
  cx88: fix printk arg. type

small-drivers-char-rio-cleanups-fwd.patch
  small drivers/char/rio/ cleanups

small-char-generic_serialc-cleanup-fwd.patch
  small char/generic_serial.c cleanup

remove-outdated-oss-changelogs-fwd.patch
  remove outdated OSS Changelogs

debug_bugverbose-for-i386-fwd.patch
  DEBUG_BUGVERBOSE for i386

telephony-ixjc-cleanup-fwd.patch
  telephony/ixj.c cleanup

char-cycladesc-remove-unused-code-fwd.patch
  char/cyclades.c: remove unused code

linux-mounth-add-atomich-and-spinlockh-includes.patch
  linux/mount.h: add atomic.h and spinlock.h #includes

oss-ac97-quirk-facility.patch
  oss: AC97 quirk facility

fix-bug-3745-maybe.patch
  a

smbfs-bug-3758-broken-symlinks-on-smbfs-with.patch
  smbfs: Bug #3758 - Broken symlinks on smbfs



