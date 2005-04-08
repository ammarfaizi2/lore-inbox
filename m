Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVDHKSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVDHKSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVDHKSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:18:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:46314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262782AbVDHKIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:08:52 -0400
Date: Fri, 8 Apr 2005 03:08:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc2-mm2
Message-Id: <20050408030835.4941cd98.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm2/


- Although small, bk-audit.patch was causing conflits with a couple of
  other projects.  Dropped for now.

- Greg is not using bk now, so bk-pci.patch, bk-i2c.patch,
  bk-driver-core.patch and bk-usb.patch have been replaced with gregkh-*.patch
  in -mm.

- Largeish x86_64 update

- CPU scheduler updates

- The bk-acpi patch here causes my ia64 test box to hang during boot



Changes since 2.6.12-rc2-mm1:


 bk-acpi.patch
 bk-agpgart.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-cryptodev.patch
 gregkh-driver.patch
 bk-drm.patch
 bk-drm-via.patch
 bk-ia64.patch
 bk-input.patch
 bk-jfs.patch
 bk-kbuild.patch
 bk-kconfig.patch
 bk-mtd.patch
 bk-netdev.patch
 bk-nfs.patch
 bk-ntfs.patch
 gregkh-pci.patch
 bk-scsi.patch
 gregkh-usb.patch
 bk-watchdog.patch

 Latest versions of subsystem trees

-fix-typo-in-scdrv_init.patch
-export-platform_add_devices.patch
-pci-pci-transparent-bridge-handling-improvements-pci-core.patch
-usb_cdc-build-fix.patch
-usb-resume-fixes.patch
-usb-suspend-updates-interface-suspend.patch
-hcd-suspend-uses-pm_message_t.patch
-usb-support-for-new-ipod-mini-and-possibly-others.patch

 Merged

+fix-acl-oops.patch

 ACL fix

+sysenter-irq-atomicity-fix.patch
+sysenter-irq-atomicity-fix-fix.patch

 Fix sysenter stack stomping.  Not the final version of this.

+fix-get_compat_sigevent.patch

 compat fix

+fix-bug-4395-modprobe-bttv-freezes-the-computer.patch

 bttv fix

+selinux-fix-bug-in-netlink-message-type-detection.patch

 SELinux fix

+r128_statec-break-missing-in-switch-statement.patch

 DRM fix

+no-acpi-build-fix.patch
+drivers-firmware-pcdpc-build-fix.patch

 ACPI fixes

+add-cxt48-to-modem-black-list-in-ac97.patch

 Sound driver fix

+bk-driver-core-usb-klist_node_attached-fix.patch

 Fix to gregkh-driver.patch

+remove-redundancy-from-i2c-corec.patch

 gregkh-i2c.patch fix

+bk-kbuild-cvs-fixes.patch
+biarch-compiler-support-for-i386.patch

 bk-kbuild fixes

+usb-storage-debugc-missing-include.patch

 usb fix

-add-a-clear_pages-function-to-clear-pages-of-higher.patch

 Dropped - didn't seem to gain much.

+freepgt2-free_pgtables-from-first_user_address.patch
+freepgt2-sys_mincore-ignore-first_user_pgd_nr.patch
+freepgt2-arm-first_user_address-page_size.patch
+freepgt2-arm26-first_user_address-page_size.patch
+freepgt2-arch-first_user_address-0.patch
+freepgt2-remove-first_user_address-hack.patch

 Core mm cleanups

+sparsemem-fix-minor-defaults-issue-in-mm-kconfig.patch

 sparsemem Kconfig changes

+chelsio-build-fix.patch

 net driver build fix

+fix-linux-atalkh-header.patch
+dont-call-kmem_cache_create-with-a-spinlock-held.patch
+fix-dst_destroy-race.patch
+irda_device-oops-fix.patch

 net fixes

+selinux-add-support-for-netlink_kobject_uevent.patch

 SELinux feature work

-ppc32-fix-errata-for-some-g3-cpus.patch

 This seemed to be buggy.

+ppc32-fix-agp-and-sleep-again.patch
+ppc32-fix-pte_update-for-64-bit-ptes.patch
+ppc32-make-usage-of-config_pte_64bit-config_phys_64bit.patch
+ppc32-allow-adjust-of-pfn-offset-in-pte.patch
+ppc32-support-36-bit-physical-addressing-on-e500.patch
+ppc32-fix-errata-for-some-g3-cpus.patch
+ppc32-fix-mpc8xx-watchdog.patch

 ppc32 updates

+ppc64-fix-export-of-wrong-symbol.patch
+ppc64-kconfig-memory-models.patch
+ppc64-improve-mapping-of-vdso.patch
+ppc64-detect-altivec-via-firmware-on-unknown-cpus.patch
+ppc64-remove-bogus-f50-hack-in-promc.patch

 ppc64 updates

+mips-remove-include-linux-audith-two.patch

 MIPS fix

-sched-x86-sched_clock-to-use-tsc-on-config_hpet-or-config_numa-systems.patch

 Broken.

+irq-and-pci_ids-patch-for-intel-esb2.patch
+piix-ide-pata-patch-for-intel-esb2.patch
+intel8x0-ac97-audio-patch-for-intel-esb2.patch
+ata_piix-ide-mode-sata-patch-for-intel-esb2.patch
+ahci-ahci-mode-sata-patch-for-intel-esb2.patch
+i2c-i801-i2c-patch-for-intel-esb2.patch

 Intel ESB2 updates

+x86_64-disable-interrupts-during-smp-bogomips-checking.patch
+x86_64-genapic-update.patch
+x86_64-make-irda-devices-are-not-really-isa-devices-not.patch
+x86_64-from-i386-originally-from-linus.patch
+x86_64-some-fixes-for-single-step-handling.patch
+x86_64-handle-programs-that-set-tf-in-user-space-using.patch
+x86_64-use-a-common-function-to-find-code-segment-bases.patch
+x86_64-use-a-common-function-to-find-code-segment-bases-fix.patch
+x86_64-dump-stack-and-prevent-recursion-on-early-fault.patch
+x86_64-fix-interaction-of-single-stepping-with-debuggers.patch
+x86_64-minor-microoptimization-in-syscall-entry-slow-path.patch
+x86_64-call-do_notify_resume-unconditionally-in-entrys.patch
+x86_64-regularize-exception-stack-handling.patch
+x86_64-fix-a-small-missing-schedule-race.patch
+x86_64-remove-unused-macro-in-preempt-support.patch
+x86_64-support-constantly-ticking-tscs.patch
+x86_64-make-kernel-math-errors-a-die-now.patch
+x86_64-dont-assume-future-amd-cpus-have-k8-compatible.patch
+x86_64-correct-wrong-comment-in-localh.patch
+x86_64-use-the-extended-rip-msr-for-machine-check.patch
+x86_64-remove-excessive-stack-allocation-in-mce-code.patch
+x86_64-always-use-cpuid-80000008-to-figure-out-mtrr.patch
+x86_64-port-over-e820-gap-detection-from-i386.patch
+x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture.patch
+x86_64-keep-only-a-single-debug-notifier-chain.patch
+x86_64-remove-duplicated-syscall-entry.patch
+x86_64-adds-support-for-intel-dual-core-detection-and-displaying.patch
+x86_64-final-support-for-amd-dual-core.patch
+x86_64-final-support-for-amd-dual-core-fix.patch
+x86_64-rewrite-exception-stack-backtracing.patch
+x86_64-add-acpi_skip_timer_override-option.patch
+x86_64-rename-the-extended-cpuid-level-field.patch
+x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state.patch
+x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state-fix.patch

 x86_64 update

-x86-x86_64-intel-dual-core-detection.patch
-x86_64-genapic-update.patch

 Drop these - I think Andi has implemented this by other means.

+power-videotxt-update-documentation-with-more-systems.patch
+fix-u32-vs-pm_message_t-in-drivers.patch
+fix-u32-vs-pm_message_t-in-driver-video.patch
+fix-u32-vs-pm_message_t-in-rest-of-the-tree.patch

 Power management updates

+kernel-softlockup-fix-usage-of-msleep_interruptible.patch

 Clean up detect-soft-lockups.patch

+possible-use-after-free-of-bio.patch

 block layer fix

-some-changes-and-extensions-to-the-kernel-documentation.patch

 Dropped - it's now in docbook-*.patch

+opl3sa2-module_parm_desc.patch

 module parameter fix

+con_consdev-bit-not-set-correctly-on-last-console.patch

 console handling fix

+update-maintainer-for-dev-random.patch

 random driver maintainer update

+add-dontdiff-file.patch

 Add a standard dontdiff file.

+ib-mthca-add-support-for-new-mt25204-hca-fix.patch

 Fix ib-mthca-add-support-for-new-mt25204-hca.patch

+ext3-remove-unnecessary-race-then-retry-in-ext3_get_block.patch
+ext3-remove-unnecessary-race-then-retry-in-ext3_get_block-leak-fix.patch

 Remove some unneeded ext3 logic

+nfsd-clear-signals-before-exiting-the-nfsd-thread.patch
+nfsd4-callback-create-rpc-client-returns.patch
+nfsd4-fix-struct-file-leak.patch
+nfsd4-find_delegation_file.patch
+nfsd4-nfs4_check_delegmode.patch
+nfsd4-dont-reopen-for-delegated-client.patch
+nfsd4-add-open-state-code-for-claim_delegate_cur.patch
+nfsd4-support-claim_delegate_cur.patch
+nfsd4-fix-fh_expire_type.patch
+nfsd4-block-metadata-ops-during-grace-period.patch
+nfsd4-slabify-nfs4_files.patch
+nfsd4-slabify-stateids.patch
+nfsd4-slabify-delegations.patch
+nfsd4-remove-debugging-counters.patch
+nfsd4-rename-nfs4_file-fields.patch
+nfsd4-reference-count-struct-nfs4_file.patch

 nfs server udpates

-sched-remove-unnecessary-sched-domains.patch
-sched-improve-pinned-task-handling-again.patch
+sched-null-domains.patch
+sched-remove-degenerate-domains.patch
+sched-multilevel-sbe-sbf.patch
+sched-rcu-domains.patch
+sched-consolidate-sbe-sbf.patch
+sched-consolidate-sbe-sbf-fix.patch

 CPU scheduler updates

+serial-mri-mri-pcids1-dual-port-serial-card.patch

 Additional serial driver support

+md-close-a-small-race-in-md-thread-deregistration.patch
+md-remove-a-number-of-misleading-calls-to-md_bug.patch

 RAID update

+docbook-changes-and-extensions-to-the-kernel-documentation.patch
+docbook-fix-void-xml-tag.patch
+docbook-fix-some-descriptions.patch
+docbook-use-informalexample-for-examples.patch
+docbook-remove-obsolete-templates.patch
+docbook-use-xmlto-to-process-the-docbook-files.patch

 kerneldoc fixes

+sound-oss-cleanups-fix.patch

 Fix sound-oss-cleanups.patch for gcc4.



number of patches in -mm: 746
number of changesets in external trees: 643
number of patches in -mm only: 724
total patches: 1367




All 746 patches:


fix-acl-oops.patch
  Fix acl Oops

sysenter-irq-atomicity-fix.patch
  sysenter IRQ atomicity fix

sysenter-irq-atomicity-fix-fix.patch
  sysenter-irq-atomicity-fix-fix

fix-get_compat_sigevent.patch
  : Fix get_compat_sigevent()

fix-bug-4395-modprobe-bttv-freezes-the-computer.patch
  fix Bug 4395: modprobe bttv freezes the computer

selinux-fix-bug-in-netlink-message-type-detection.patch
  SELinux: fix bug in Netlink message type detection

r128_statec-break-missing-in-switch-statement.patch
  r128_state.c: break missing in switch statement

bk-acpi.patch

bk-acpi-alpha-build-fix.patch
  bk-acpi alpha build fix

acpi-toshiba-failure-handling.patch
  acpi: Toshiba failure handling

acpi-video-pointer-size-fix.patch
  acpi video pointer size fix

no-acpi-build-fix.patch
  CONFIG_ACPI=n build fix

drivers-firmware-pcdpc-build-fix.patch
  drivers/firmware/pcdp.c build fix

bk-agpgart.patch

agp-fix-for-xen-vmm.patch
  AGP fix for Xen VMM

fix-agp-code-to-work-again-with-non-pci-agp-bridges.patch
  fix AGP code to work again with non-PCI AGP bridges

include-linux-soundcardh-endianness-fix.patch
  include/linux/soundcard.h: endianness fix

add-cxt48-to-modem-black-list-in-ac97.patch
  Add CXT48 to modem black list in ac97

bk-cifs.patch

bk-cpufreq.patch

add-suspend-method-to-cpufreq-core.patch
  Add suspend method to cpufreq core

add-suspend-method-to-cpufreq-core-warning-fix.patch
  add-suspend-method-to-cpufreq-core-warning-fix

powernow-k7recalibrate-cpu_khz.patch
  powernowk7: recalibrate cpu_khz

cpufreq-timers-recalibrate_cpu_khz.patch
  cpufreq timers: recalibrate cpu_khz

bk-cryptodev.patch

gregkh-driver.patch

bk-driver-core-usb-klist_node_attached-fix.patch
  usb: klist_node_attached() fix

fix-ver_linux-script-for-no-udev-utils.patch
  Fix ver_linux script for no udev utils.

bk-drm.patch

bk-drm-via.patch

gregkh-i2c.patch

remove-redundancy-from-i2c-corec.patch
  Remove redundancy from i2c-core.c

bk-ia64.patch

bk-driver-core-sn2-build-fix.patch
  bk-driver-core sn build fix

quiet-ide-cd-warning.patch
  quiet ide-cd warning

bk-input.patch

alps-printk-tidy.patch
  alps-printk-tidy

serio-resume-fix.patch
  serio resume fix

alps-resume-fix.patch
  ALPS resume fix

serport-oops-fix.patch
  serport oops fix

serio-id-attributes.patch
  serio 'id' attributes

bk-jfs.patch

bk-kbuild.patch

bk-kbuild-cvs-fixes.patch
  bk-kbuild cvs fixes

biarch-compiler-support-for-i386.patch
  biarch compiler support for i386

use-cross_compileinstallkernel-in-arch-boot-installsh.patch
  use ${CROSS_COMPILE}installkernel in arch/*/boot/install.sh

bk-kconfig.patch

kconfig-i18n-support.patch
  Kconfig i18n support

libata-flush-comreset-set-and-clear.patch
  libata: flush COMRESET set and clear

bk-mtd.patch

bk-netdev.patch

tulip-fix-for-64-bit-mips.patch
  tulip: fix for 64-bit mips

pcnet_csc-irq-handler-optimization.patch
  pcnet_cs.c: IRQ handler optimization

bk-nfs.patch

bk-ntfs.patch

gregkh-pci.patch

pci_module_init-pci_register_driver.patch
  pci_module_init -> pci_register_driver

pci-pci-transparent-bridge-handling-improvements-yenta_socket.patch
  PCI-PCI transparent bridge handling improvements (yenta_socket)

acpi-bridge-hotadd-acpi-based-root-bridge-hot-add.patch
  acpi bridge hotadd: ACPI based root bridge hot-add

acpi-bridge-hotadd-fix-pci_enable_device-for-p2p-bridges.patch
  acpi bridge hotadd: Fix pci_enable_device() for p2p bridges

acpi-bridge-hotadd-make-pcibios_fixup_bus-hot-plug-safe.patch
  acpi bridge hotadd: Make pcibios_fixup_bus() hot-plug safe

acpi-bridge-hotadd-prevent-duplicate-bus-numbers-when-scanning-pci-bridge.patch
  acpi bridge hotadd: Prevent duplicate bus numbers when scanning PCI bridge

acpi-bridge-hotadd-take-the-pci-lock-when-modifying-pci-bus-or-device-lists.patch
  acpi bridge hotadd: Take the PCI lock when modifying pci bus or device lists

acpi-bridge-hotadd-link-newly-created-pci-child-bus-to-its-parent-on-creation.patch
  acpi bridge hotadd: Link newly created pci child bus to its parent on creation

acpi-bridge-hotadd-make-the-pci-remove-routines-safe-for-failed-hot-plug.patch
  acpi bridge hotadd: Make the PCI remove routines safe for failed hot-plug

acpi-bridge-hotadd-remove-hot-plugged-devices-that-could-not-be-allocated-resources.patch
  acpi bridge hotadd: Remove hot-plugged devices that could not be allocated resources

acpi-bridge-hotadd-read-bridge-resources-when-fixing-up-the-bus.patch
  acpi bridge hotadd: Read bridge resources when fixing up the bus

acpi-bridge-hotadd-allow-acpi-add-and-start-operations-to-be-done-independently.patch
  acpi bridge hotadd: Allow ACPI .add and .start operations to be done independently

acpi-bridge-hotadd-export-the-interface-to-get-pci-id-for-an-acpi-handle.patch
  acpi bridge hotadd: Export the interface to get PCI id for an ACPI handle

bk-scsi.patch

megaraid_sas-announcing-new-module-for.patch
  megaraid_sas: new module for LSI Logic's SAS based MegaRAID controllers

add-scsi-changer-driver.patch
  add scsi changer driver

scsi-ch-build-fix.patch
  scsi ch.c build fix

gregkh-usb.patch

usb-wacom-tablet-driver.patch
  usb wacom tablet driver

add-new-wacom-device-to-usb-hid-core-list.patch
  add new wacom device to usb hid-core list

zd1201-build-fix.patch
  zd1201 build fix

pm-support-for-zd1201.patch
  PM support for zd1201

bug-fix-in-usbdevfs.patch
  bug fix in usbdevfs

usb-turn-a-user-mode-driver-error-into-a-hard-error.patch
  usb: turn a user mode driver error into a hard error

usb-storage-debugc-missing-include.patch
  usb/storage/debug.c: missing include

bk-watchdog.patch

mm.patch
  add -mmN to EXTRAVERSION

swapspace-layout-improvements.patch
  swapspace-layout-improvements
  /proc/swaps negative Used

vmscan-notice-slab-shrinking.patch
  vmscan: notice slab shrinking

madvise-do-not-split-the-maps.patch
  madvise: do not split the maps

madvise-merge-the-maps.patch
  madvise: merge the maps

freepgt-free_pgtables-use-vma-list.patch
  freepgt: free_pgtables use vma list

freepgt-remove-mm_vm_sizemm.patch
  freepgt: remove MM_VM_SIZE(mm)

freepgt-hugetlb_free_pgd_range.patch
  freepgt: hugetlb_free_pgd_range

freepgt-hugetlb_free_pgd_range-fix-aio-panic-fix.patch
  ppc64-fix-aio-panic-caused-by-is_hugepage_only_range-ia64-fix

freepgt-remove-arch-pgd_addr_end.patch
  freepgt: remove arch pgd_addr_end

freepgt-mpnt-to-vma-cleanup.patch
  freepgt: mpnt to vma cleanup

freepgt-hugetlb-area-is-clean.patch
  freepgt: hugetlb area is clean

freepgt2-free_pgtables-from-first_user_address.patch
  freepgt2: free_pgtables from FIRST_USER_ADDRESS

freepgt2-sys_mincore-ignore-first_user_pgd_nr.patch
  freepgt2: sys_mincore ignore FIRST_USER_PGD_NR

freepgt2-arm-first_user_address-page_size.patch
  freepgt2: arm FIRST_USER_ADDRESS PAGE_SIZE

freepgt2-arm26-first_user_address-page_size.patch
  freepgt2: arm26 FIRST_USER_ADDRESS PAGE_SIZE

freepgt2-arch-first_user_address-0.patch
  freepgt2: arch FIRST_USER_ADDRESS 0

freepgt2-remove-first_user_address-hack.patch
  freepgt2: remove FIRST_USER_ADDRESS hack

remove-non-discontig-use-of-pgdat-node_mem_map.patch
  remove non-DISCONTIG use of pgdat->node_mem_map

resubmit-sparsemem-base-early_pfn_to_nid-works-before-sparse-is-initialized.patch
  sparsemem base: early_pfn_to_nid() (works before sparse is initialized)

resubmit-sparsemem-base-simple-numa-remap-space-allocator.patch
  sparsemem base: simple NUMA remap space allocator

resubmit-sparsemem-base-reorganize-page-flags-bit-operations.patch
  sparsemem base: reorganize page->flags bit operations

resubmit-sparsemem-base-teach-discontig-about-sparse-ranges.patch
  sparsemem base: teach discontig about sparse ranges

create-mm-kconfig-for-arch-independent-memory-options.patch
  create mm/Kconfig for arch-independent memory options

make-each-arch-use-mm-kconfig.patch
  make each arch use mm/Kconfig

update-all-defconfigs-for-arch_discontigmem_enable.patch
  update all defconfigs for ARCH_DISCONTIGMEM_ENABLE

introduce-new-kconfig-option-for-numa-or-discontig.patch
  Introduce new Kconfig option for NUMA or DISCONTIG

sparsemem-fix-minor-defaults-issue-in-mm-kconfig.patch
  sparsemem: fix minor "defaults" issue in mm/Kconfig

filemap_getpage-can-block-when-map_nonblock-specified.patch
  filemap_getpage can block when MAP_NONBLOCK specified

add-kmalloc_node-inline-cleanup.patch
  add kmalloc_node, inline cleanup

oom-killer-disable-for-iscsi-lvm2-multipath-userland-critical-sections.patch
  oom-killer disable for iscsi/lvm2/multipath userland critical sections

vmscan-pageout-remove-unneeded-test.patch
  vmscan: pageout(): remove unneeded test

end_buffer_write_sync-avoid-pointless-assignments.patch
  end_buffer_write_sync() avoid pointless assignments

meminfo-add-cached-underflow-check.patch
  meminfo: add Cached underflow check

eni155p-error-handling-fix.patch
  ENI155P error handling fix

a-new-10gb-ethernet-driver-by-chelsio-communications.patch
  A new 10GB Ethernet Driver by Chelsio Communications

chelsio-build-fix.patch
  chelsio build fix

dm9000-network-driver.patch
  DM9000 network driver

fix-linux-atalkh-header.patch
  Fix linux/atalk.h header

dont-call-kmem_cache_create-with-a-spinlock-held.patch
  net: don't call kmem_cache_create with a spinlock held

fix-dst_destroy-race.patch
  Fix dst_destroy() race

irda_device-oops-fix.patch
  irda_device() oops fix

selinux-add-support-for-netlink_kobject_uevent.patch
  SELinux: add support for NETLINK_KOBJECT_UEVENT

ppc32-fix-bogosity-in-process-freezing-code.patch
  ppc32: fix bogosity in process-freezing code

ppc32-ppc4xx_pic-add-acknowledge-when-enabling-level-sensitive-irq.patch
  ppc32: ppc4xx_pic - add acknowledge when enabling level-sensitive IRQ

ppc32-improve-timebase-sync-for-smp.patch
  ppc32: improve timebase sync for SMP

ppc32-oops-on-kernel-altivec-assist-exceptions.patch
  ppc32: oops on kernel altivec assist exceptions

ppc32-fix-single-stepping-of-emulated-instructions.patch
  ppc32: fix single-stepping of emulated instructions

ppc32-fix-cpufreq-problems.patch
  ppc32: Fix cpufreq problems

ppc32-fix-agp-and-sleep-again.patch
  ppc32: Fix AGP and sleep again

ppc32-fix-pte_update-for-64-bit-ptes.patch
  ppc32: Fix pte_update for 64-bit PTEs

ppc32-make-usage-of-config_pte_64bit-config_phys_64bit.patch
  ppc32: make usage of CONFIG_PTE_64BIT & CONFIG_PHYS_64BIT consistent

ppc32-allow-adjust-of-pfn-offset-in-pte.patch
  ppc32: Allow adjust of pfn offset in pte

ppc32-support-36-bit-physical-addressing-on-e500.patch
  ppc32: Support 36-bit physical addressing on e500

ppc32-fix-errata-for-some-g3-cpus.patch
  ppc32: Fix errata for some G3 CPUs

ppc32-fix-mpc8xx-watchdog.patch
  ppc32: Fix mpc8xx watchdog

ppc64-fix-semantics-of-__ioremap.patch
  ppc64: Fix semantics of __ioremap

ppc64-fix-export-of-wrong-symbol.patch
  ppc64: fix export of wrong symbol

ppc64-kconfig-memory-models.patch
  ppc64: Kconfig memory models

ppc64-improve-mapping-of-vdso.patch
  ppc64: Improve mapping of vDSO

ppc64-detect-altivec-via-firmware-on-unknown-cpus.patch
  ppc64: Detect altivec via firmware on unknown CPUs

ppc64-remove-bogus-f50-hack-in-promc.patch
  ppc64: remove bogus f50 hack in prom.c

mips-remove-obsolete-vr41xx-rtc-function.patch
  mips: remove obsolete VR41xx RTC function  from vr41xx.h

mips-update-vr41xx-cpu-pci-bridge.patch
  mips: update VR41xx CPU-PCI bridge  support

mips-remove-include-linux-audith-two.patch
  mips: remove #include <linux/audit.h> two times

fix-i386-memcpy.patch
  fix i386 memcpy

i386-x86_64-segment-register-access-update.patch
  i386/x86_64 segment register access update

rfc-check-nmi-watchdog-is-broken.patch
  check nmi watchdog is broken

irq-and-pci_ids-patch-for-intel-esb2.patch
  irq and pci_ids: patch for Intel ESB2

piix-ide-pata-patch-for-intel-esb2.patch
  piix: IDE PATA patch for Intel ESB2

intel8x0-ac97-audio-patch-for-intel-esb2.patch
  intel8x0: AC'97 audio patch for Intel ESB2

ata_piix-ide-mode-sata-patch-for-intel-esb2.patch
  ata_piix: IDE mode SATA patch for Intel ESB2

ahci-ahci-mode-sata-patch-for-intel-esb2.patch
  ahci: AHCI mode SATA patch for Intel ESB2

i2c-i801-i2c-patch-for-intel-esb2.patch
  i2c-i801: I2C patch for Intel ESB2

x86_64-disable-interrupts-during-smp-bogomips-checking.patch
  x86_64: disable interrupts during SMP bogomips checking

x86_64-genapic-update.patch
  x86_64 genapic update

x86_64-show_stack-touch_nmi_watchdog.patch
  x86_64 show_stack(): call touch_nmi_watchdog

x86_64-use-a-vma-for-the-32bit-vsyscall.patch
  x86_64: Use a VMA for the 32bit vsyscall

x86_64-make-irda-devices-are-not-really-isa-devices-not.patch
  x86_64: Make IRDA devices are not really ISA devices not depend on CONFIG_ISA

x86_64-from-i386-originally-from-linus.patch
  x86_64: clean up ptrace single-stepping

x86_64-some-fixes-for-single-step-handling.patch
  x86_64: Some fixes for single step handling

x86_64-handle-programs-that-set-tf-in-user-space-using.patch
  x86_64: Handle programs that set TF in user space using popf while single stepping

x86_64-use-a-common-function-to-find-code-segment-bases.patch
  x86_64: Use a common function to find code segment bases

x86_64-use-a-common-function-to-find-code-segment-bases-fix.patch
  x86_64-use-a-common-function-to-find-code-segment-bases fix

x86_64-dump-stack-and-prevent-recursion-on-early-fault.patch
  x86_64: Dump stack and prevent recursion on early fault

x86_64-fix-interaction-of-single-stepping-with-debuggers.patch
  x86_64: Fix interaction of single stepping with debuggers

x86_64-minor-microoptimization-in-syscall-entry-slow-path.patch
  x86_64: Minor microoptimization in syscall entry slow path

x86_64-call-do_notify_resume-unconditionally-in-entrys.patch
  x86_64: Call do_notify_resume unconditionally in entry.S

x86_64-regularize-exception-stack-handling.patch
  x86_64: Regularize exception stack handling

x86_64-fix-a-small-missing-schedule-race.patch
  x86_64: Fix a small missing schedule race

x86_64-remove-unused-macro-in-preempt-support.patch
  x86_64: Remove unused macro in preempt support

x86_64-support-constantly-ticking-tscs.patch
  x86_64: Support constantly ticking TSCs

x86_64-make-kernel-math-errors-a-die-now.patch
  x86_64: Make kernel math errors a die() now

x86_64-dont-assume-future-amd-cpus-have-k8-compatible.patch
  x86_64: Don't assume future AMD CPUs have K8 compatible performance counters

x86_64-correct-wrong-comment-in-localh.patch
  x86_64: Correct wrong comment in local.h

x86_64-use-the-extended-rip-msr-for-machine-check.patch
  x86_64: Use the extended RIP MSR for machine check reporting if available.

x86_64-remove-excessive-stack-allocation-in-mce-code.patch
  x86_64: Remove excessive stack allocation in MCE code with large NR_CPUS

x86_64-always-use-cpuid-80000008-to-figure-out-mtrr.patch
  x86_64: Always use CPUID 80000008 to figure out MTRR address space size

x86_64-port-over-e820-gap-detection-from-i386.patch
  x86_64: Port over e820 gap detection from i386

x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture.patch
  x86_64: Use the e820 hole to map the IOMMU/AGP aperture

x86_64-keep-only-a-single-debug-notifier-chain.patch
  x86_64: Keep only a single debug notifier chain

x86_64-remove-duplicated-syscall-entry.patch
  x86_64: Remove duplicated syscall entry.

x86_64-adds-support-for-intel-dual-core-detection-and-displaying.patch
  x86_64: add support for Intel dual-core detection and displaying

x86_64-final-support-for-amd-dual-core.patch
  x86_64: Final support for AMD dual core

x86_64-final-support-for-amd-dual-core-fix.patch
  x86_64-final-support-for-amd-dual-core-fix

x86_64-rewrite-exception-stack-backtracing.patch
  x86_64: Rewrite exception stack backtracing

x86_64-add-acpi_skip_timer_override-option.patch
  x86_64: Add acpi_skip_timer_override option

x86_64-rename-the-extended-cpuid-level-field.patch
  x86_64: Rename the extended cpuid level field

x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state.patch
  x86_64: Switch SMP bootup over to new CPU hotplug state machine

x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state-fix.patch
  x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state fix

x86-cacheline-alignment-for-cpu-maps.patch
  x86: cacheline alignment for cpu maps

ia64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  ia64: reduce cacheline bouncing in cpu_idle_wait

pm_message_t-more-fixes-in-common-and-i386.patch
  pm_message_t: more fixes in common and i386

fix-u32-vs-pm_message_t-in-drivers-char.patch
  Fix u32 vs. pm_message_t in drivers/char

u32-vs-pm_message_t-fixes-for-drivers-net.patch
  u32 vs. pm_message_t fixes for drivers/net

fix-u32-vs-pm_message_t-in-pcmcia.patch
  fix u32 vs. pm_message_t in pcmcia

fix-u32-vs-pm_message_t-in-drivers-media.patch
  fix u32 vs. pm_message_t in drivers/media

fix-u32-vs-pm_message_t-in-drivers-message.patch
  fix u32 vs. pm_message_t in drivers/message

fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi.patch
  fix u32 vs. pm_message_t in drivers/mmc,mtd,scsi

fix-pm_message_t-vs-u32-in-alsa.patch
  fix pm_message_t vs. u32 in alsa

fix-u32-vs-pm_message_t-in-x86-64.patch
  Fix u32 vs. pm_message_t in x86-64

fix-u32-vs-pm_message_t-in-drivers-macintosh.patch
  fix u32 vs. pm_message_t in drivers/macintosh

fix-u32-vs-pm_message_t-in-pci-pcie.patch
  fix u32 vs. pm_message_t in PCI, PCIE

u32-vs-pm_message_t-in-ppc-and-radeon.patch
  u32 vs. pm_message_t in ppc and radeon

power-videotxt-update-documentation-with-more-systems.patch
  power/video.txt: update documentation with more systems

fix-u32-vs-pm_message_t-in-drivers.patch
  fix u32 vs. pm_message_t in drivers/

fix-u32-vs-pm_message_t-in-driver-video.patch
  fix u32 vs. pm_message_t in driver/video

fix-u32-vs-pm_message_t-in-rest-of-the-tree.patch
  fix u32 vs. pm_message_t in rest of the tree

uml-fix-compilation-for-__choose_mode-addition.patch
  uml: fix compilation for __CHOOSE_MODE addition

mtrr-size-and-base-debug.patch
  mtrr size-and-base debugging

iounmap-debugging.patch
  iounmap debugging

detect-soft-lockups.patch
  detect soft lockups

detect-soft-lockups-from-touch_nmi_watchdog.patch
  detect-soft-lockups: call from touch_nmi_watchdog

kernel-softlockup-fix-usage-of-msleep_interruptible.patch
  kernel/softlockup: fix usage of msleep_interruptible()

areca-raid-linux-scsi-driver.patch
  ARECA RAID Linux scsi driver

rt-lsm.patch
  RT-LSM

tty-output-lossage-fix.patch
  tty output lossage fix

possible-use-after-free-of-bio.patch
  possible use-after-free of bio

nice-and-rt-prio-rlimits.patch
  nice and rt-prio rlimits

relayfs.patch
  relayfs

relayfs-properly-handle-oversized-events.patch
  relayfs: properly handle oversized events

relayfs-backing_dev-fix.patch
  relayfs-backing_dev-fix

cfq-iosched-update-to-time-sliced-design.patch
  cfq-iosched: update to time sliced design

cfq-iosched-update-to-time-sliced-design-export-task_nice.patch
  cfq-iosched-update-to-time-sliced-design-export-task_nice

cfq-iosched-update-to-time-sliced-design-fix.patch
  cfq-iosched-update-to-time-sliced-design fix

cfq-iosched-update-to-time-sliced-design-fix-fix.patch
  cfq-iosched-update-to-time-sliced-design-fix-fix

cfq-iosched-update-to-time-sliced-design-use-bio_data_dir.patch
  cfq-iosched-update-to-time-sliced-design: use bio_data_dir()

cfq-ioschedc-fix-soft-hang-with-non-fs-requests.patch
  cfq-iosched.c: fix soft hang with non-fs requests

keys-discard-key-spinlock-and-use-rcu-for-key-payload.patch
  keys: Discard key spinlock and use RCU for key payload

keys-discard-key-spinlock-and-use-rcu-for-key-payload-try-4.patch
  keys: Discard key spinlock and use RCU for key payload - try #4

keys-pass-session-keyring-to-call_usermodehelper.patch
  Keys: Pass session keyring to call_usermodehelper()

keys-pass-session-keyring-to-call_usermodehelper-fix.patch
  keys-pass-session-keyring-to-call_usermodehelper fix

keys-use-rcu-to-manage-session-keyring-pointer.patch
  Keys: Use RCU to manage session keyring pointer

keys-make-request-key-create-an-authorisation-key.patch
  Keys: Make request-key create an authorisation key

keys-make-request-key-create-an-authorisation-key-fix.patch
  Keys: Make request-key create an authorisation key (fix)

binfmt_elf-bss-padding-fix.patch
  binfmt_elf bss padding fix

timers-fixes-improvements.patch
  timers fixes/improvements

timers-fixes-improvements-smp_processor_id-fix.patch
  timers-fixes-improvements-smp_processor_id-fix

timers-fixes-improvements-fix.patch
  timers fixes/improvements fix

enable-sig_ign-on-blocked-signals.patch
  Enable SIG_IGN on blocked signals

async-io-using-rt-signals.patch
  AYSNC IO using singals other than SIGIO

kernel-paramc-dont-use-max-when-num-is-null-in.patch
  kernel/param.c: don't use .max when .num is NULL in param_array_set()

fix-module_param_string-calls.patch
  fix module_param_string() calls

use-cheaper-elv_queue_empty-when-unplug-a-device.patch
  use cheaper elv_queue_empty when unplug a device

fixup-newly-added-jsm-driver.patch
  fix up newly added jsm driver

ext2-corruption-regression-between-269-and-2610.patch
  ext2 corruption - regression between 2.6.9 and 2.6.10

quota-fix-possible-oops-on-quotaoff.patch
  quota: fix possible oops on quotaoff

quota-possible-bug-in-quota-format-v2-support.patch
  quota: possible bug in quota format v2 support

kill-ifndef-have_arch_get_signal_to_deliver-in-signalc.patch
  kill #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER in signal.c

officially-deprecate-register_ioctl32_conversion.patch
  officially deprecate register_ioctl32_conversion

undo-do_readv_writev-behavior-change.patch
  undo do_readv_writev() behavior change

kprobes-incorrect-handling-of-probes-on-ret-lret-instruction.patch
  Kprobes: Incorrect handling of probes on ret/lret instruction

sysfs-for-ipmi-for-new-mm-kernels.patch
  sysfs for IPMI

remove-all-kernel-bugs.patch
  remove all kernel BUGs

exterminate-page_bug.patch
  Exterminate PAGE_BUG

clean-up-kernel-messages.patch
  clean up kernel messages

move-sa_xxx-defines-to-linux-signalh.patch
  move SA_xxx defines to linux/signal.h

procfs-fix-hardlink-counts.patch
  procfs: Fix hardlink counts

procfs-fix-hardlink-counts-for-proc-pid-task.patch
  procfs: Fix hardlink counts for /proc/<PID>/task

show-thread_info-flags-in-proc-pid-status.patch
  Show thread_info->flags in /proc/PID/status

direct-io-async-short-read-fix.patch
  Direct IO async short read fix

set-ms_active-bit-before-calling-fill_super.patch
  Set MS_ACTIVE bit before calling ->fill_super functions

kernel-rcupdatec-make-the-exports-export_symbol_gpl.patch
  kernel/rcupdate.c: make the exports EXPORT_SYMBOL_GPL

add-deprecated_for_modules.patch
  Add deprecated_for_modules

add-deprecated_for_modules-fix.patch
  deprecate-synchronize_kernel-gpl-replacement fix

deprecate-synchronize_kernel-gpl-replacement.patch
  Deprecate synchronize_kernel, GPL replacement

deprecate-synchronize_kernel-gpl-replacement-fix.patch
  deprecate-synchronize_kernel-gpl-replacement-fix

change-synchronize_kernel-to-_rcu-and-_sched.patch
  Change synchronize_kernel to _rcu and _sched

update-rcu-documentation.patch
  Update RCU documentation

fix-comment-in-listh-that-refers-to-nonexistent-api.patch
  Fix comment in list.h that refers to nonexistent API

pnpbios-eliminate-bad-section-references.patch
  pnpbios: eliminate bad section references

hd-eliminate-bad-section-references.patch
  hd: eliminate bad section references

efi-eliminate-bad-section-references.patch
  efi: eliminate bad section references

create-a-kstrdup-library-function.patch
  create a kstrdup library function

create-a-kstrdup-library-function-fixes.patch
  create-a-kstrdup-library-function-fixes

add-big-endian-variants-of-ioread-iowrite.patch
  add Big Endian variants of ioread/iowrite

opl3sa2-module_parm_desc.patch
  opl3sa2: MODULE_PARM_DESC

con_consdev-bit-not-set-correctly-on-last-console.patch
  CON_CONSDEV bit not set correctly on last console

update-maintainer-for-dev-random.patch
  update maintainer for /dev/random

add-dontdiff-file.patch
  Add dontdiff file

inotify-022-for-2612-rc1-mm4.patch
  inotify 0.22 for 2.6.12-rc1-mm4

ipoib-set-skb-macraw-on-receive.patch
  IPoIB: set skb->mac.raw on receive

ipoib-fix-static-rate-calculation.patch
  IPoIB: fix static rate calculation

ipoib-convert-to-debugfs.patch
  IPoIB: convert to debugfs

ipoib-document-conversion-to.patch
  IPoIB: document conversion to debugfs

ib-keep-mad-work-completion-valid.patch
  IB: Keep MAD work completion valid

ib-remove-unneeded-includes.patch
  IB: remove unneeded includes

ib-fix-fmr-pool-crash.patch
  IB: Fix FMR pool crash

ib-trivial-fmr-printk-cleanup.patch
  IB: Trivial FMR printk cleanup

ib-fix-user-mad-registrations-with-class-0.patch
  IB: Fix user MAD registrations with class 0

ib-remove-incorrect-comments.patch
  IB: Remove incorrect comments

ib-mthca-map-mpt-mtt-context-in-mem-free-mode.patch
  IB/mthca: map MPT/MTT context in mem-free mode

ib-mthca-fill-in-more-device-query-fields.patch
  IB/mthca: fill in more device query fields

ib-mthca-fix-calculation-of-rdb-shift.patch
  IB/mthca: fix calculation of RDB shift

ib-mthca-fix-posting-sends-with-immediate-data.patch
  IB/mthca: fix posting sends with immediate data

ib-mthca-allow-unaligned-memory-regions.patch
  IB/mthca: allow unaligned memory regions

ib-mthca-allocate-correct-number-of-doorbell-pages.patch
  IB/mthca: allocate correct number of doorbell pages

ib-mthca-clean-up-mthca_dereg_mr.patch
  IB/mthca: clean up mthca_dereg_mr()

ib-mthca-fix-mr-allocation-error-path.patch
  IB/mthca: fix MR allocation error path

ib-mthca-release-mutex-on-doorbell-alloc-error-path.patch
  IB/mthca: release mutex on doorbell alloc error path

ib-mthca-print-assigned-irq-when-interrupt-test-fails.patch
  IB/mthca: print assigned IRQ when interrupt test fails

ib-mthca-only-free-doorbell-records-in-mem-free-mode.patch
  IB/mthca: only free doorbell records in mem-free mode

ib-mthca-fix-format-of-cq-number-for-cq-events.patch
  IB/mthca: fix format of CQ number for CQ events

ib-mthca-implement-rdma-atomic-operations-for-mem-free-mode.patch
  IB/mthca: implement RDMA/atomic operations for mem-free mode

ib-mthca-fix-mtt-allocation-in-mem-free-mode.patch
  IB/mthca: fix MTT allocation in mem-free mode

ib-mthca-fill-in-opcode-field-for-send-completions.patch
  IB/mthca: fill in opcode field for send completions

ib-mthca-allow-address-handle-creation-in-interrupt-context.patch
  IB/mthca: allow address handle creation in interrupt context

ib-mthca-encapsulate-mtt-buddy-allocator.patch
  IB/mthca: encapsulate MTT buddy allocator

ib-mthca-add-sync_tpt-firmware-command.patch
  IB/mthca: add SYNC_TPT firmware command

ib-mthca-add-mthca_write64_raw-for-writing-to-mtt-table-directly.patch
  IB/mthca: add mthca_write64_raw() for writing to MTT table directly

ib-mthca-add-mthca_table_find-function.patch
  IB/mthca: add mthca_table_find() function

ib-mthca-split-mr-key-munging-routines.patch
  IB/mthca: split MR key munging routines

ib-mthca-add-fast-memory-region-implementation.patch
  IB/mthca: add fast memory region implementation

ib-mthca-tweaks-to-mthca_cmdc.patch
  IB/mthca: tweaks to mthca_cmd.c

ib-mthca-encapsulate-mem-free-check-into-mthca_is_memfree.patch
  IB/mthca: encapsulate mem-free check into mthca_is_memfree()

ib-mthca-map-context-for-rdma-responder-in-mem-free-mode.patch
  IB/mthca: map context for RDMA responder in mem-free mode

ib-mthca-update-receive-queue-initialization-for-new-hcas.patch
  IB/mthca: update receive queue initialization for new HCAs

ib-mthca-add-support-for-new-mt25204-hca.patch
  IB/mthca: add support for new MT25204 HCA

ib-mthca-add-support-for-new-mt25204-hca-fix.patch
  drivers/infiniband/hw/mthca/mthca_main.c: remove an  unused label

jbd-dirty-buffer-leak-fix.patch
  jbd dirty buffer leak fix

ext3-remove-unnecessary-race-then-retry-in-ext3_get_block.patch
  ext3: remove unnecessary race then retry in ext3_get_block

ext3-remove-unnecessary-race-then-retry-in-ext3_get_block-leak-fix.patch
  ext3-remove-unnecessary-race-then-retry-in-ext3_get_block-leak-fix

pcmcia-hotplug-event-for-pcmcia-devices.patch
  pcmcia: hotplug event for PCMCIA devices

pcmcia-hotplug-event-for-pcmcia-socket-devices.patch
  pcmcia: hotplug event for PCMCIA socket devices

pcmcia-device-and-driver-matching.patch
  pcmcia: device and driver matching

pcmcia-check-for-invalid-crc32-hashes-in-id_tables.patch
  pcmcia: check for invalid crc32 hashes in id_tables

pcmcia-match-for-fake-cis.patch
  pcmcia: match for fake CIS

pcmcia-export-cis-in-sysfs.patch
  pcmcia: export CIS in sysfs

pcmcia-cis-overrid-via-sysfs.patch
  pcmcia: CIS overrid via sysfs

pcmcia-match-anonymous-cards.patch
  pcmcia: match "anonymous" cards

pcmcia-allow-function-id-based-match.patch
  pcmcia: allow function-ID based match

pcmcia-file2alias.patch
  pcmcia: file2alias

pcmcia-request-cis-via-firmware-interface.patch
  pcmcia: request CIS via firmware interface

pcmcia-cleanups.patch
  pcmcia: cleanups

pcmcia-rescan-bus-always-upon-echoing-into-setup_done.patch
  pcmcia: rescan bus always upon echoing into setup_done

pcmcia-id_table-for-serial_cs.patch
  pcmcia: id_table for serial_cs

pcmcia-id_table-for-3c574_cs.patch
  pcmcia: id_table for 3c574_cs

pcmcia-id_table-for-3c589_cs.patch
  pcmcia: id_table for 3c589_cs

pcmcia-id_table-for-aha152x.patch
  pcmcia: id_table for aha152x

pcmcia-id_table-for-airo_cs.patch
  pcmcia: id_table for airo_cs

pcmcia-id_table-for-axnet_cs.patch
  pcmcia: id_table for axnet_cs

pcmcia-id_table-for-fdomain_stub.patch
  pcmcia: id_table for fdomain_stub

pcmcia-id_table-for-fmvj18x_cs.patch
  pcmcia: id_table for fmvj18x_cs

pcmcia-id_table-for-ibmtr_cs.patch
  pcmcia: id_table for ibmtr_cs

pcmcia-id_table-for-netwave_cs.patch
  pcmcia: id_table for netwave_cs

pcmcia-id_table-for-nmclan_cs.patch
  pcmcia: id_table for nmclan_cs

pcmcia-id_table-for-teles_cs.patch
  pcmcia: id_table for teles_cs

pcmcia-id_table-for-ray_cs.patch
  pcmcia: id_table for ray_cs

pcmcia-id_table-for-wavelan_cs.patch
  pcmcia: id_table for wavelan_cs

pcmcia-id_table-for-sym53c500_csc.patch
  pcmcia: id_table for sym53c500_cs.c

pcmcia-id_table-for-qlogic_stubc.patch
  pcmcia: id_table for qlogic_stub.c

pcmcia-id_table-for-smc91c92_csc.patch
  pcmcia: id_table for smc91c92_cs.c

pcmcia-id_table-for-orinoco_cs.patch
  pcmcia: id_table for orinoco_cs

pcmcia-id_table-for-xirc2ps_csc.patch
  pcmcia: id_table for xirc2ps_cs.c

pcmcia-id_table-for-ide_csc.patch
  pcmcia: id_table for ide_cs.c

pcmcia-id_table-for-parport_csc.patch
  pcmcia: id_table for parport_cs.c

pcmcia-id_table-for-pcnet_csc.patch
  pcmcia: id_table for pcnet_cs.c

pcmcia-id_table-for-pcmciamtdc.patch
  pcmcia: id_table for pcmciamtd.c

pcmcia-id_table-for-vxpocketc.patch
  pcmcia: id_table for vxpocket.c

pcmcia-id_table-for-atmel_csc.patch
  pcmcia: id_table for atmel_cs.c

pcmcia-id_table-for-avma1_csc.patch
  pcmcia: id_table for avma1_cs.c

pcmcia-id_table-for-avm_csc.patch
  pcmcia: id_table for avm_cs.c

pcmcia-id_table-for-bluecard_csc.patch
  pcmcia: id_table for bluecard_cs.c

pcmcia-id_table-for-bt3c_csc.patch
  pcmcia: id_table for bt3c_cs.c

pcmcia-id_table-for-btuart_csc.patch
  pcmcia: id_table for btuart_cs.c

pcmcia-id_table-for-com20020_csc.patch
  pcmcia: id_table for com20020_cs.c

pcmcia-id_table-for-dtl1_csc.patch
  pcmcia: id_table for dtl1_cs.c

pcmcia-id_table-for-elsa_csc.patch
  pcmcia: id_table for elsa_cs.c

pcmcia-id_table-for-ixj_pcmciac.patch
  pcmcia: id_table for ixj_pcmcia.c

pcmcia-id_table-for-nsp_csc.patch
  pcmcia: id_table for nsp_cs.c

pcmcia-id_table-for-sedlbauer_csc.patch
  pcmcia: id_table for sedlbauer_cs.c

pcmcia-id_table-for-wl3501_csc.patch
  pcmcia: id_table for wl3501_cs.c

pcmcia-id_table-for-pdaudiocfc.patch
  pcmcia: id_table for pdaudiocf.c

pcmcia-id_table-for-synclink_csc.patch
  pcmcia: id_table for synclink_cs.c

pcmcia-add-some-documentation.patch
  pcmcia: add some Documentation

pcmcia-update-resource-database-adjust-routines-to-use-unsigned-long-values.patch
  pcmcia: update resource database adjust routines to use unsigned long values

pcmcia-mark-parent-bridge-windows-as-resources-available-for-pcmcia-devices.patch
  pcmcia: mark parent bridge windows as resources available for PCMCIA devices

pcmcia-add-a-config-option-for-the-pcmica-ioctl.patch
  pcmcia: add a config option for the PCMICA ioctl

pcmcia-move-pcmcia-ioctl-to-a-separate-file.patch
  pcmcia: move PCMCIA ioctl to a separate file

pcmcia-clean-up-cs-ds-callback.patch
  pcmcia: clean up cs ds callback

pcmcia-clean-up-cs-ds-callback-fix.patch
  pcmcia-clean-up-cs-ds-callback-fix

pcmcia-make-pcmcia-status-a-bitfield.patch
  pcmcia: make PCMCIA status a bitfield

pcmcia-merge-struct-pcmcia_bus_socket-into-struct-pcmcia_socket.patch
  pcmcia: merge struct pcmcia_bus_socket into struct pcmcia_socket

pcmcia-remove-unneeded-includes-in-dsc.patch
  pcmcia: remove unneeded includes in ds.c

pcmcia-rename-some-functions.patch
  pcmcia: rename some functions

pcmcia-move-pcmcia-resource-handling-out-of-csc.patch
  pcmcia: move pcmcia resource handling out of cs.c

pcmcia-csc-cleanup.patch
  pcmcia: cs.c cleanup

pcmcia-dsc-cleanup.patch
  pcmcia: ds.c cleanup

pcmcia-release_class.patch
  pcmcia: release_class

pcmcia-use-request_region-in-i82365.patch
  pcmcia: use request_region in i82365

pcmcia-synclink_cs-irq_info2_info-is-gone.patch
  pcmcia: synclink_cs IRQ_INFO2_INFO is gone

pcmcia-mod_devicetableh-fix-for-different-sizes-in-kernel-and-userspace.patch
  pcmcia: mod_devicetable.h fix for different sizes in kernel- and userspace

pcmcia-select-crc32-in-kconfig-for-pcmcia.patch
  pcmcia: select crc32 in Kconfig for PCMCIA

pcmcia-resource-handling-fixes.patch
  pcmcia: resource handling fixes

nfsd-clear-signals-before-exiting-the-nfsd-thread.patch
  nfsd: clear signals before exiting the nfsd() thread

nfsd4-callback-create-rpc-client-returns.patch
  nfsd4: callback create rpc client returns

nfsd4-fix-struct-file-leak.patch
  nfsd4: fix struct file leak

nfsd4-find_delegation_file.patch
  nfsd4: find_delegation_file()

nfsd4-nfs4_check_delegmode.patch
  nfsd4: nfs4_check_delegmode

nfsd4-dont-reopen-for-delegated-client.patch
  nfsd4: don't reopen for delegated client

nfsd4-add-open-state-code-for-claim_delegate_cur.patch
  nfsd4: add open state code for CLAIM_DELEGATE_CUR

nfsd4-support-claim_delegate_cur.patch
  nfsd4: support CLAIM_DELEGATE_CUR

nfsd4-fix-fh_expire_type.patch
  nfsd4: fix fh_expire_type

nfsd4-block-metadata-ops-during-grace-period.patch
  nfsd4: block metadata ops during grace period

nfsd4-slabify-nfs4_files.patch
  nfsd4: slabify nfs4_files

nfsd4-slabify-stateids.patch
  nfsd4: slabify stateids

nfsd4-slabify-delegations.patch
  nfsd4: slabify delegations

nfsd4-remove-debugging-counters.patch
  nfsd4: remove debugging counters

nfsd4-rename-nfs4_file-fields.patch
  nfsd4: rename nfs4_file fields

nfsd4-reference-count-struct-nfs4_file.patch
  nfsd4: reference count struct nfs4_file

nfsacl-solaris-nfsacl-workaround.patch
  nfsacl: Solaris nfsacl workaround

nfs-client-latencies.patch
  NFS client latency fixes

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
  kgdb: kill off highmem_start_page
  kgdb documentation fix

kgdb-x86-config_debug_info-fix.patch
  kgdb CONFIG_DEBUG_INFO fix

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

kgdb-x86_64-config_debug_info-fix.patch
  kgdb CONFIG_DEBUG_INFO fix

rock-lindent.patch
  rock: lindent it

rock-manual-tidies.patch
  rock: manual tidies

rock-remove-CHECK_SP.patch
  rock: remove CHECK_SP

rock-remove-CONTINUE_DECLS.patch
  rock: remove CONTINUE_DECLS

rock-remove-CHECK_CE.patch
  rock: remove CHECK_CE

rock-remove-SETUP_ROCK_RIDGE.patch
  rock: remove SETUP_ROCK_RIDGE

rock-remove-MAYBE_CONTINUE.patch
  rock: remove MAYBE_CONTINUE

rock-comment-tidies.patch
  rock: comment tidies

rock-lindent-rock-h.patch
  rock: lindent rock.h

isofs-remove-debug-stuff.patch
  isofs: remove debug stuff

rock-handle-corrupted-directories.patch
  rock.c: handle corrupted directories

rock-rename-union-members.patch
  rock: rename union members

rock-handle-directory-overflows.patch
  rock: handle directory overflows

rock-handle-directory-overflows-fix.patch
  rock-handle-directory-overflows-fix

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

page-owner-tracking-leak-detector.patch
  Page owner tracking leak detector

make-page_owner-handle-non-contiguous-page-ranges.patch
  make page_owner handle non-contiguous page ranges

add-gfp_mask-to-page-owner.patch
  add gfp_mask to page owner

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

periodically-scan-redzone-entries-and-slab-control-structures.patch
  periodically scan redzone entries and slab control structures

slab-leak-detector.patch
  slab leak detector

slab-leak-detector-warning-fixes.patch
  slab leak detector warning fixes

irqpoll.patch
  irqpoll

releasing-resources-with-children.patch
  Releasing resources with children

perfctr-core.patch
  perfctr: core
  perfctr: remove bogus perfctr_sample_thread() calls

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

perfctr-sysfs-update-1-4-core.patch
  perfctr sysfs update: core

perfctr-sysfs-update.patch
  Perfctr sysfs update

perfctr-sysfs-update-2-4-x86.patch
  perfctr sysfs update: x86

perfctr-sysfs-update-3-4-x86-64.patch
  perfctr sysfs update: x86-64
  perfctr: syscall numbers in x86-64 ia32-emulation
  perfctr x86_64 native syscall numbers fix

perfctr-sysfs-update-4-4-ppc32.patch
  perfctr sysfs update: ppc32

perfctr-2710-api-update-1-4-common.patch
  perfctr-2.7.10 API update 1/4: common

perfctr-2710-api-update-2-4-i386.patch
  perfctr-2.7.10 API update 2/4: i386

perfctr-2710-api-update-3-4-x86_64.patch
  perfctr-2.7.10 API update 3/4: x86_64

perfctr-2710-api-update-4-4-ppc32.patch
  perfctr-2.7.10 API update 4/4: ppc32

perfctr-api-update-1-9-physical-indexing-x86.patch
  perfctr API update 1/9: physical indexing, x86

perfctr-api-update-2-9-physical-indexing-ppc32.patch
  perfctr API update 2/9: physical indexing, ppc32

perfctr-api-update-3-9-cpu_control_header-x86.patch
  perfctr API update 3/9: cpu_control_header, x86

perfctr-api-update-4-9-cpu_control_header-ppc32.patch
  perfctr API update 4/9: cpu_control_header, ppc32

perfctr-api-update-5-9-cpu_control_header-common.patch
  perfctr API update 5/9: cpu_control_header, common

perfctr-api-update-6-9-cpu_control-access-common.patch
  perfctr API update 6/9: cpu_control access, common

perfctr-api-update-7-9-cpu_control-access-x86.patch
  perfctr API update 7/9: cpu_control access, x86

perfctr-api-update-8-9-cpu_control-access-ppc32.patch
  perfctr API update 8/9: cpu_control access, ppc32

perfctr-api-update-9-9-domain-based-read-write-syscalls.patch
  perfctr API update 9/9: domain-based read/write syscalls

perfctr-ia32-syscalls-on-x86-64-fix.patch
  perfctr ia32 syscalls on x86-64 fix

perfctr-cleanups-1-3-common.patch
  perfctr cleanups: common

perfctr-cleanups-2-3-ppc32.patch
  perfctr cleanups: ppc32

perfctr-cleanups-3-3-x86.patch
  perfctr cleanups: x86

perfctr-x86-fix-and-cleanups.patch
  perfctr: x86 fix and cleanups

perfctr-ppc32-fix-and-cleanups.patch
  perfctr: ppc32 fix and cleanups

perfctr-64-bit-values-in-register-descriptors.patch
  perfctr: 64-bit values in register descriptors

perfctr-64-bit-values-in-register-descriptors-fix.patch
  perfctr-64-bit-values-in-register-descriptors fix

perfctr-mapped-state-cleanup-x86.patch
  perfctr: mapped state cleanup: x86

perfctr-mapped-state-cleanup-ppc32.patch
  perfctr: mapped state cleanup: ppc32

perfctr-mapped-state-cleanup-common.patch
  perfctr: mapped state cleanup: common

perfctr-ppc64-arch-hooks.patch
  perfctr: ppc64 arch hooks

perfctr-common-updates-for-ppc64.patch
  perfctr: common updates for ppc64

perfctr-ppc64-driver-core.patch
  perfctr: ppc64 driver core

sched2-cleanup-wake_idle.patch
  sched: cleanup wake_idle

sched2-improve-load-balancing-pinned-tasks.patch
  sched: improve load balancing pinned tasks

sched2-reduce-active-load-balancing.patch
  sched: reduce active load balancing

sched2-fix-smt-scheduling-problems.patch
  sched: fix SMT scheduling problems

sched2-add-debugging.patch
  sched: add debugging

sched2-less-aggressive-idle-balancing.patch
  sched: less aggressive idle balancing

sched2-balance-timers.patch
  sched: balance timers

sched2-tweak-affine-wakeups.patch
  sched: tweak affine wakeups

sched2-no-aggressive-idle-balancing.patch
  sched: no aggressive idle balancing

sched2-balance-on-fork.patch
  sched: balance on fork

sched2-schedstats-update-for-balance-on-fork.patch
  sched: schedstats update for balance on fork

sched2-sched-tuning.patch
  sched: sched tuning

sched2-sched-tuning-fix.patch
  sched2-sched-tuning-fix

sched2-sched-domain-sysctl.patch
  sched: sched domain sysctl

sched-uninline-task_timeslice.patch
  sched: uninline task_timeslice

sched-cleanup-context-switch-locking.patch
  sched: cleanup context switch locking

sched-null-domains.patch
  sched: null domains

sched-remove-degenerate-domains.patch
  sched: remove degenerate domains

sched-multilevel-sbe-sbf.patch
  sched: multilevel sbe sbf

sched-rcu-domains.patch
  sched: RCU domains

sched-consolidate-sbe-sbf.patch
  sched: consolidate sbe sbf

sched-consolidate-sbe-sbf-fix.patch
  sched-consolidate-sbe-sbf fix

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug

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

add-page-becoming-writable-notification-build-fix.patch
  add-page-becoming-writable-notification build fix

make-page-becoming-writable-notification-a-vma-op-only.patch
  Make page-becoming-writable notification a VMA-op only

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

make-page-becoming-writable-notification-a-vma-op-only-kafs-fix.patch
  Make page-becoming-writable notification a VMA-op only (kafs fix)

fscache-menuconfig-help-fix-documentation-path.patch
  fscache-menuconfig-help-fix-documentation-pathc

x86-rename-apic_mode_exint.patch
  kexec: x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  kexec: x86: local apic fix

x86_64-e820-64bit.patch
  kexec: x86_64: e820 64bit fix

x86-i8259-shutdown.patch
  kexec: x86: i8259 shutdown: disable interrupts

x86_64-i8259-shutdown.patch
  kexec: x86_64: add i8259 shutdown method

x86-apic-virtwire-on-shutdown.patch
  kexec: x86: resture apic virtual wire mode on shutdown

x86_64-apic-virtwire-on-shutdown.patch
  kexec: x86_64: restore apic virtual wire mode on shutdown

vmlinux-fix-physical-addrs.patch
  kexec: vmlinux: fix physical addresses

x86-vmlinux-fix-physical-addrs.patch
  kexec: x86: vmlinux: fix physical addresses

x86_64-vmlinux-fix-physical-addrs.patch
  kexec: x86_64: vmlinux: fix physical addresses

x86-config-kernel-start.patch
  kexec: x86: add CONFIG_PYSICAL_START

kexec-reserve-bootmem-fix-for-booting-nondefault-location-kernel.patch
  kexec: reserve Bootmem fix for booting nondefault location kernel

x86_64-config-kernel-start.patch
  kexec: x86_64: add CONFIG_PHYSICAL_START

kexec-kexec-generic.patch
  kexec: add kexec syscalls

kexec-kexec-generic-kexec-use-unsigned-bitfield.patch
  kexec: use unsigned bitfield

x86-machine_shutdown.patch
  kexec: x86: factor out apic shutdown code

x86-kexec.patch
  kexec: x86 kexec core

x86-crashkernel.patch
  crashdump: x86 crashkernel option

x86-crashkernel-fix.patch
  kexec: fix for broken kexec on panic

x86_64-machine_shutdown.patch
  kexec: x86_64: factor out apic shutdown code

x86_64-kexec.patch
  kexec: x86_64 kexec implementation

x86_64-crashkernel.patch
  crashdump: x86_64: crashkernel option

kexec-ppc-support.patch
  kexec: kexec ppc support

kexec-ppc-fix-noret_type.patch
  kexec: ppc: fix NORET_TYPE

x86-crash_shutdown-nmi-shootdown.patch
  crashdump: x86: add NMI handler to capture other CPUs

x86-crash_shutdown-snapshot-registers.patch
  kexec: x86: snapshot registers during crash shutdown

x86-crash_shutdown-apic-shutdown.patch
  kexec: x86 shutdown APICs during crash_shutdown

kdump-export-crash-notes-section-address-through.patch
  Kdump: Export crash notes section address through sysfs

kdump-export-crash-notes-section-address-through-x86_64-fix.patch
  kdump-export-crash-notes-section-address-through x86_64 fix

kdump-nmi-handler-segment-selector-stack.patch
  kdump: NMI handler segment selector, stack pointer fix

kdump-documentation-for-kdump.patch
  kdump: Documentation for Kdump

kdump-retrieve-saved-max-pfn.patch
  kdump: Retrieve saved max pfn

kdump-kconfig-for-kdump.patch
  kdump: Kconfig

kdump-routines-for-copying-dump-pages.patch
  kdump: Routines for copying dump pages

kdump-retrieve-elfcorehdr-address-from-command.patch
  Retrieve elfcorehdr address from command line

kdump-access-dump-file-in-elf-format.patch
  kdump: Access dump file in elf format (/proc/vmcore)

kdump-parse-elf32-headers-and-export-through.patch
  kdump: Parse elf32 headers and export through /proc/vmcore

kdump-accessing-dump-file-in-linear-raw-format.patch
  kdump: Accessing dump file in linear raw format (/dev/oldmem)

kdump-cleanups-for-dump-file-access-in-linear.patch
  kdump: cleanups for dump file access in linear raw format

kdump-sysrq-trigger-mechanism-for-kexec-based-crashdumps.patch
  kdump: sysrq trigger mechanism for kexec based crashdumps

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

reiser4-rcu-barrier-license-fix.patch
  reiser4-rcu-barrier-license-fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

reiser4-kconfig-help-cleanup.patch
  reiser4 Kconfig help cleanup

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

serial-mri-mri-pcids1-dual-port-serial-card.patch
  serial: MRi MRI-PCIDS1 dual port serial card

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

md-close-a-small-race-in-md-thread-deregistration.patch
  md: close a small race in md thread deregistration

md-remove-a-number-of-misleading-calls-to-md_bug.patch
  md: remove a number of misleading calls to MD_BUG

md-merge-md_enter_safemode-into-md_check_recovery.patch
  md: merge md_enter_safemode into md_check_recovery

md-improve-locking-on-safemode-and-move-superblock-writes.patch
  md: improve locking on 'safemode' and move superblock writes

md-improve-the-interface-to-sync_request.patch
  md: improve the interface to sync_request

md-optimised-resync-using-bitmap-based-intent-logging.patch
  md: optimised resync using Bitmap based intent logging

md-optimised-resync-using-bitmap-based-intent-logging-mempool-fix.patch
  md-optimised-resync-using-bitmap-based-intent-logging-mempool-fix

md-a-couple-of-tidyups-relating-to-the-bitmap-file.patch
  md: a couple of tidyups relating to the bitmap file.

md-call-bitmap_daemon_work-regularly.patch
  md: call bitmap_daemon_work regularly

md-print-correct-pid-for-newly-created-bitmap-writeback-daemon.patch
  md: print correct pid for newly created bitmap-writeback-daemon.

md-minor-code-rearrangement-in-bitmap_init_from_disk.patch
  md: minor code rearrangement in bitmap_init_from_disk

md-make-sure-md-bitmap-is-cleared-on-a-clean-start.patch
  md: make sure md bitmap is cleared on a clean start.

md-printk-fix.patch
  md printk fix

md-improve-debug-printing-of-bitmap-superblock.patch
  md: improve debug-printing of bitmap superblock.

md-check-return-value-of-write_page-rather-than-ignore-it.patch
  md: check return value of write_page, rather than ignore it

md-enable-the-bitmap-write-back-daemon-and-wait-for-it.patch
  md: enable the bitmap write-back daemon and wait for it.

md-dont-skip-bitmap-pages-due-to-lack-of-bit-that-we-just-cleared.patch
  md: don't skip bitmap pages due to lack of bit that we just cleared.

md-optimised-resync-using-bitmap-based-intent-logging-fix.patch
  md-optimised-resync-using-bitmap-based-intent-logging fix

md-raid1-support-for-bitmap-intent-logging.patch
  md: raid1 support for bitmap intent logging

md-fix-bug-when-raid1-attempts-a-partial-reconstruct.patch
  md: fix bug when raid1 attempts a partial reconstruct.

md-raid1-support-for-bitmap-intent-logging-fix.patch
  md: initialise sync_blocks in raid1 resync

md-optimise-reconstruction-when-re-adding-a-recently-failed-drive.patch
  md: optimise reconstruction when re-adding a recently failed drive.

md-fix-deadlock-due-to-md-thread-processing-delayed-requests.patch
  md: fix deadlock due to md thread processing delayed requests.

md-allow-md-intent-bitmap-to-be-stored-near-the-superblock.patch
  md: allow md intent bitmap to be stored near the superblock.

md-allow-md-to-update-multiple-superblocks-in-parallel.patch
  md: allow md to update multiple superblocks in parallel.

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

docbook-changes-and-extensions-to-the-kernel-documentation.patch
  DocBook: changes and extensions to the kernel documentation

docbook-fix-void-xml-tag.patch
  DocBook: fix <void/> xml tag

docbook-fix-some-descriptions.patch
  DocBook: fix some descriptions

docbook-use-informalexample-for-examples.patch
  DocBook: use <informalexample> for examples

docbook-remove-obsolete-templates.patch
  DocBook: remove obsolete templates

docbook-use-xmlto-to-process-the-docbook-files.patch
  DocBook: Use xmlto to process the DocBook files.

post-halloween-doc.patch
  post halloween doc

fuse-maintainers-kconfig-and-makefile-changes.patch
  FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  FUSE - core

fuse-device-functions.patch
  FUSE - device functions

fuse-device-functions-abi-version-change.patch
  FUSE: ABI version change

fuse-device-functions-comments-and-documentation.patch
  FUSE: comments and documentation

fuse-device-functions-cleanup.patch
  FUSE: trivial cleanups

fuse-read-only-operations.patch
  FUSE - read-only operations

fuse-read-only-operations-add-offset-to-fuse_dirent.patch
  FUSE: add offset to fuse_dirent

fuse-read-only-operations-readdir-fixes.patch
  FUSE: readdir fixes

fuse-read-write-operations.patch
  FUSE - read-write operations

fuse-file-operations.patch
  FUSE - file operations

fuse-mount-options.patch
  FUSE - mount options

fuse-mount-options-fix.patch
  fuse: fix busy inodes after unmount

fuse-mount-options-comments-and-documentation.patch
  FUSE: comments and documentation

fuse-mount-options-fix-cleanup.patch
  FUSE: trivial cleanups

fuse-mount-options-fix-fix.patch
  FUSE: fix locking for background list

fuse-extended-attribute-operations.patch
  FUSE - extended attribute operations

fuse-add-padding.patch
  FUSE: add padding

fuse-readpages-operation.patch
  FUSE - readpages operation

fuse-nfs-export.patch
  FUSE - NFS export

fuse-direct-i-o.patch
  FUSE - direct I/O

fuse-direct-i-o-fix-warning-on-x86_64.patch
  FUSE: fix warning on x86_64

fuse-transfer-readdir-data-through-device.patch
  fuse: transfer readdir data through device

fuse-add-fsync-operation-for-directories.patch
  FUSE: add fsync operation for directories

drivers-isdn-divert-isdn_divertc-make-5-functions-static.patch
  drivers/isdn/divert/isdn_divert.c: make 5 functions static

drivers-isdn-capi-make-some-code-static.patch
  drivers/isdn/capi/: make some code static

drivers-scsi-pas16c-make-code-static.patch
  drivers/scsi/pas16.c: make code static

i386-x86_64-early_printkc-make-early_serial_base-static.patch
  i386/x86_64 early_printk.c: make early_serial_base static

kernel-exitc-make-exit_mm-static.patch
  kernel/exit.c: make exit_mm static

cyrix-eliminate-bad-section-references.patch
  cyrix: eliminate bad section references

drivers-media-video-tvaudioc-make-some-variables-static.patch
  drivers/media/video/tvaudio.c: make some variables static

drivers-isdn-sc-possible-cleanups.patch
  drivers/isdn/sc/: possible cleanups

drivers-isdn-pcbit-possible-cleanups.patch
  drivers/isdn/pcbit/: possible cleanups

drivers-isdn-i4l-possible-cleanups.patch
  drivers/isdn/i4l/: possible cleanups

unexport-mca_find_device_by_slot.patch
  unexport mca_find_device_by_slot

drivers-isdn-hardware-avm-misc-cleanups.patch
  drivers/isdn/hardware/avm/: misc cleanups

drivers-isdn-act2000-capic-if-0-an-unused-function.patch
  drivers/isdn/act2000/capi.c: #if 0 an unused function

tpm-fix-gcc-printk-warnings.patch
  tpm: fix gcc printk warnings

x86-64-add-memcpy-memset-prototypes.patch
  x86-64: add memcpy/memset prototypes

au1100fb-convert-to-c99-inits.patch
  au1100fb: convert to C99 inits.

reiserfs-use-null-instead-of-0.patch
  reiserfs: use NULL instead of 0

comments-on-locking-of-task-comm.patch
  comments on locking of task->comm

riottyc-cleanups-and-warning-fix.patch
  riotty.c cleanups and warning fix

fixup-a-comment-still-refering-to-verify_area.patch
  fix up a comment still refering to verify_area

char-ds1620-use-msleep-instead-of-schedule_timeout.patch
  char/ds1620: use msleep() instead of schedule_timeout()

char-tty_io-replace-schedule_timeout-with-msleep_interruptible.patch
  char/tty_io: replace schedule_timeout() with msleep_interruptible()

kernel-timer-fix-msleep_interruptible-comment.patch
  kernel/timer: fix msleep_interruptible() comment

ixj-compile-warning-cleanup.patch
  ixj* - compile warning cleanup

spelling-cleanups-in-shrinker-code.patch
  Spelling cleanups in shrinker code

init-do_mounts_initrdc-fix-sparse-warning.patch
  init/do_mounts_initrd.c: fix sparse warning

arch-i386-kernel-trapsc-fix-sparse-warnings.patch
  arch/i386/kernel/traps.c: fix sparse warnings

arch-i386-kernel-apmc-fix-sparse-warnings.patch
  arch/i386/kernel/apm.c: fix sparse warnings

arch-i386-mm-faultc-fix-sparse-warnings.patch
  arch/i386/mm/fault.c: fix sparse warnings

arch-i386-crypto-aesc-fix-sparse-warnings.patch
  arch/i386/crypto/aes.c: fix sparse warnings

codingstyle-trivial-whitespace-fixups.patch
  CodingStyle: trivial whitespace fixups

small-partitions-msdos-cleanups.patch
  small partitions/msdos cleanups

remove-redundant-null-check-before-before-kfree-in.patch
  remove redundant NULL check before before kfree() in  kernel/sysctl.c

update-ross-biro-bouncing-email-address.patch
  update Ross Biro bouncing email address

get-rid-of-redundant-null-checks-before-kfree-in-arch-i386.patch
  get rid of redundant NULL checks before kfree() in arch/i386/

remove-redundant-null-checks-before-kfree-in-sound-and.patch
  remove redundant NULL checks before kfree() in sound/ and avoid casting pointers about to be kfree()'ed

x86-geode-support-fixes.patch
  x86: geode support fixes

drivers-scsi-initioc-cleanups.patch
  drivers/scsi/initio.c: cleanups

dont-do-pointless-null-checks-and-casts-before-kfree.patch
  selinux: kfree cleanup

drivers-char-isicomc-section-fixes.patch
  drivers/char/isicom.c: section fixes

sound-oss-cleanups.patch
  sound/oss/: cleanups

sound-oss-cleanups-fix.patch
  nm256 oss build failure

sound-oss-rme96xxc-remove-kernel-22-ifs.patch
  sound/oss/rme96xx.c: remove kernel 2.2 #if's

drivers-char-mwave-tp3780ic-remove-kernel-22-ifs.patch
  drivers/char/mwave/tp3780i.c: remove kernel 2.2 #if's

drivers-net-skfp-cleanups.patch
  drivers/net/skfp/: cleanups

net-atm-resourcesc-remove-__free_atm_dev.patch
  Subject: [2.6 patch] net/atm/resources.c: remove __free_atm_dev

fix-ncr53c9xc-compile-warning.patch
  fix NCR53C9x.c compile warning

mm-mmapnommuc-several-unexports.patch
  mm/{mmap,nommu}.c: several unexports

unexport-hugetlb_total_pages.patch
  unexport hugetlb_total_pages

unexport-clear_page_dirty_for_io.patch
  unexport clear_page_dirty_for_io

mm-filemapc-make-sync_page_range_nolock-static.patch
  mm/filemap.c: make sync_page_range_nolock static

mm-filemapc-make-generic_file_direct_io-static.patch
  mm/filemap.c: make generic_file_direct_IO static

remove-exports-for-oem-modules.patch
  remove exports for oem modules

mm-page_allocc-unexport-nr_swap_pages.patch
  unexport nr_swap_pages

unexport-console_unblank.patch
  unexport console_unblank

mm-swapc-unexport-vm_acct_memory.patch
  mm/swap.c: unexport vm_acct_memory

mm-swapfilec-unexport-total_swap_pages.patch
  mm/swapfile.c: unexport total_swap_pages

mm-swap_statec-unexport-swapper_space.patch
  mm/swap_state.c: unexport swapper_space

unexport-slab_reclaim_pages.patch
  unexport slab_reclaim_pages

unexport-idle_cpu.patch
  unexport idle_cpu



