Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVBJKjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVBJKjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 05:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVBJKjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 05:39:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:52405 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262069AbVBJKfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 05:35:12 -0500
Date: Thu, 10 Feb 2005 02:35:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc3-mm2
Message-Id: <20050210023508.3583cf87.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm2/


- Added the mlock and !SCHED_OTHER Linux Security Module for the audio guys.
  It seems that nothing else is going to come along and this is completely
  encapsulated.

- Various other stuff.  If anyone has a patch in here which they think
  should be in 2.6.11, please let me know.  I'm intending to merge the
  following into 2.6.11:

	alpha-add-missing-dma_mapping_error.patch
	fix-compat-shmget-overflow.patch
	fix-shmget-for-ppc64-s390-64-sparc64.patch
	binfmt_elf-clearing-bss-may-fail.patch
	qlogic-warning-fixes.patch
	oprofile-exittext-referenced-in-inittext.patch
	force-read-implies-exec-for-all-32bit-processes-in-x86-64.patch
	oprofile-arm-xscale1-pmu-support-fix.patch




Changes since 2.6.11-rc3-mm1:


 linus.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-jfs.patch
 bk-kbuild.patch
 bk-kconfig.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-scsi.patch
 bk-scsi-rc-fixes.patch
 bk-serial.patch
 bk-usb.patch
 bk-watchdog.patch
 bk-xfs.patch

 External bk trees.

-fix-an-error-in-proc-slabinfo-print.patch
-ibmveth-inlining-failure.patch
-fix-devfs-name-for-the-hvcs-driver.patch
-uml-compile-fixes.patch
-include-jiffies-fix-usecs_to_jiffies-jiffies_to_usecs-math.patch
-credits-update.patch
-nfsd-needs-exportfs.patch
-input-make-mousedevc-report-all-events-to-user-space-immediately.patch
-input-enable-hardware-tapping-for-alps-touchpads.patch
-input-fix-pointer-jumps-to-corner-of-screen-problem-on-alps-glidepoint-touchpads.patch
-input-add-support-for-synaptics-touchpad-scroll-wheels.patch
-driver-model-fix-types-in-usb.patch
-kswapd-throttling-fix.patch
-task_size-is-variable.patch
-use-mm_vm_size-in-exit_mmap.patch
-ppc64-correct-return-code-in-syscall-auditing.patch
-ppc64-show-1-for-physical_id-of-non-present-cpus.patch
-ppc64-replace-last-usage-of-vio-dma-mapping-routines.patch
-speedstep-libc-fix-frequency-multiplier-for-pentium4.patch
-x86_64-parse-noexec=.patch
-force-feedback-support-for-uinput.patch
-pcmcia-dc-initialisation-fix.patch
-scsi-megaraid_mmc-make-some-code-static.patch
-add-map_populate-sys_remap_file_pages-support-to-xfs.patch
-acpi-call-acpi_leave_sleep_state-before-resuming-devices.patch
-small-partitions-msdos-cleanups.patch
-scsi-sim710c-make-some-code-static.patch

 Merged

+alpha-add-missing-dma_mapping_error.patch

 Alpha build fix

+fix-compat-shmget-overflow.patch
+fix-shmget-for-ppc64-s390-64-sparc64.patch

 Various compat code sign extension fixes

+binfmt_elf-clearing-bss-may-fail.patch

 Fix the weird elf loading failure

+qlogic-warning-fixes.patch

 smp_processor_id() warnings

+oprofile-exittext-referenced-in-inittext.patch

 oprofile section fix

+force-read-implies-exec-for-all-32bit-processes-in-x86-64.patch

 Partly fix up the x86_64 noexec mapping problem.

+oprofile-arm-xscale1-pmu-support-fix.patch

 oprofile fix

+nfsd--sgi-921857-find-broken-with-nohide-on-nfsv3.patch
+nfsd--exportfs-reduce-stack-usage.patch
+nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
+nfsd--svcrpc-rename-pg_authenticate.patch
+nfsd--svcrpc-move-export-table-checks-to-a-per-program-pg_add_client-method.patch
+nfsd--nfs4-use-new-pg_set_client-method-to-simplify-nfs4-callback-authentication.patch
+nfsd--lockd-dont-try-to-match-callback-requests-against-export-table.patch
+nfsd--nfsd-remove-pg_authenticate-field.patch
+nfsd--global-static-cleanups-for-nfsd.patch
+nfsd--change-nfsd-reply-cache-to-use-listh-lists.patch

 nfsd update

+acpi-fix-containers-notify-handler-to-handle-proper-cases-properly.patch
+acpi_power_off-bug-fix.patch

 ACPI fixes

+update-to-ipmi-driver-to-support-old-dmi-spec.patch
+add-the-ipmi-smbus-driver-fix-fix.patch

 IPMI fixes

+ohci1394-dma_pool_destroy-while-in_atomic-irqs_disabled.patch

 1394 fix

+sbp2-fix-hang-on-unload.patch

 Another 1394 fix

+serio-warning-fix.patch
+twidjoy-build-fix.patch

 input code fixes

+compat-ioctl-for-submiting-urb.patch
+compat-ioctl-for-submiting-urb-fix.patch

 Add compatibility emulation for the USB URB-direct-submission code.

+swapspace-layout-improvements-fix.patch

 Fix swapspace-layout-improvements.patch

+fix-small-vmalloc-per-allocation-limit.patch

 Make monster vmalloc()s work

+randomisation-global-sysctl-fix.patch
 Fix randomisation-global-sysctl.patch

+fix-compilation-of-uml-after-the-stack-randomization-patches.patch

 Fix randomisation-infrastructure.patch

+invalidate-range-of-pages-after-direct-io-write-fix-fix.patch
+write-and-wait-on-range-before-direct-io-read.patch
+only-unmap-what-intersects-a-direct_io-op.patch

 Various optimisations for page unmapping, mainly related to direct-IO.

+net-s2io-replace-schedule_timeout-with-msleep.patch

 cleanup

+ppc-ppc64-abstract-cpu_feature-checks.patch
+ppc32-dont-create-tmp_gas_check.patch
+ppc32-fix-mv64x60-register-relocation-bug-in-bootwrapper.patch

 ppc32 updates

+ppc64-remove-unneeded-includes-from-pseries_nvramc.patch
+ppc64-collect-and-export-low-level-cpu-usage-statistics.patch
+ppc64-defconfig-updates.patch
+ppc64-distribute-export_symbols.patch
+ppc64-disable-hmt-for-rs64-cpus.patch
+use-vmlinux-during-make-install-on-ppc64.patch
+ppc64-functions-to-reserve-performance-monitor-hardware.patch

 ppc64 updates

+mips-add-tanbac-tb0219-base-board-driver.patch

 mips board driver

+refactor-i386-memory-setup.patch
+consolidate-set_max_mapnr_init-implementations.patch
+remove-free_all_bootmem-define.patch

 x86 mm cleanups

+out-of-line-x86-put_user-implementation.patch

 move x86 put_user() out of line.

+x86_64-hugetlb-fix.patch

 hugepage fix

+swsusp-do-not-use-higher-order-memory-allocations-on-suspend-fix.patch
+swsusp-do-not-use-higher-order-memory-allocations-on-suspend-fix-fix.patch

 Fix swsusp-do-not-use-higher-order-memory-allocations-on-suspend.patch

+fix-partial-sysrq-setting.patch

 Fix a -mm-only sysrq patch

+touch_softlockup_watchdog.patch
+fix-softlockup-warning-in-swsuspend-resume.patch

 Enhancements to detect-soft-lockups.patch

+add-struct-request-end_io-callback-fix.patch

 Fix add-struct-request-end_io-callback.patch

+add-compiler-gcc4h.patch

 cleanup

+rt-lsm.patch

 realtime+mlock LSM

+convert-proc-driver-rtc-to-seq_file.patch

 RTC driver /proc seqfile conversion

+drivers-char-lpc-race-fix.patch

 Fix obscure line printer driver race

+clean-up-and-unify-asm-resourceh-files.patch

 Code cleanup

-base-small-shrink-major_names-hash.patch

 This broke stuff

+sort-fix.patch

 Make the new sort function place things in sorted order.

-inotify.patch
-inotify-fix_find_inode.patch

 I think my version is old, and it oopses.

+pcmcia-add-support-ti-pci4510-cardbus-bridge.patch
+pcmcia-update-vrc4171_card.patch

 PCMCIA device updates

+nfsv4-deamon-always-supports-acls.patch

 NFS ACL Kconfig fix

+add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
+add-sysctl-interface-to-sched_domain-parameters.patch

 We found the cause of the weird ia64 oops (extable sorting was wrong), so
 bring these back.

+crashdump-routines-for-copying-dump-pages-fixes.patch
+crashdump-linear-raw-format-dump-file-access-coding-style.patch

 crashdump coding cleanups

+radeonfb-fix-spurious-error-return-in-fbio_radeon_set_mirror.patch
+w100fb-make-blanking-function-interrupt-safe.patch
+kyrofb-copy__user-return-value-checks-added-to-kyro-fb.patch
+skeletonfb-documentation-fixes.patch
+intelfb-add-partial-support-915g-chipset.patch
+sisfb_compat_ioctl-warning-fix.patch
+sis-warning-fix.patch
+tridentfb-warning-fix.patch

 fbdev updates and fixes

-raid5-overlapping-read-hack.patch

 This got fixed for real

+md-fix-multipath-assembly-bug.patch
+md-raid-kconfig-cleanups-remove-experimental-tag-from-raid-6.patch

 MD updates

+device-mapper-store-name-directly-against-device.patch
+device-mapper-record-restore-bio-state.patch
+device-mapper-export-map_info.patch

 DM updates

+update-documentation-filesystems-locking.patch

 Update the VFS locking doc for quotas

+hpet-setup-comment-fix.patch
+fs-ncpfs-ncplib_kernelc-make-a-function-static.patch
+kill-iphase5526.patch
+fs-nfs-make-some-code-static.patch
+i386-x86_64-acpi-sleepc-kill-unused-acpi_save_state_disk.patch
+smpbootc-cleanups.patch
+i386-kernel-i387c-misc-cleanups.patch
+i386-x86_64-i8259c-make-mask_and_ack_8259a-static.patch
+scsi-sym53c416c-make-a-function-static.patch
+scsi-ultrastorc-make-a-variable-static.patch
+tridentfbc-make-some-code-static.patch
+kernel-intermodulec-make-inter_module_get-static.patch

 Various nanofixes



number of patches in -mm: 585
number of changesets in external trees: 634
number of patches in -mm only: 564
total patches: 1198




All 585 patches:



linus.patch

alpha-add-missing-dma_mapping_error.patch
  alpha: add missing dma_mapping_error

fix-compat-shmget-overflow.patch
  Fix compat shmget overflow

fix-shmget-for-ppc64-s390-64-sparc64.patch
  Fix shmget for ppc64, s390-64 & sparc64.

binfmt_elf-clearing-bss-may-fail.patch
  binfmt_elf: clearing bss may fail

qlogic-warning-fixes.patch
  more qlogic smp_processor_id() warning fixes

oprofile-exittext-referenced-in-inittext.patch
  OProfile: exit.text referenced in init.text

force-read-implies-exec-for-all-32bit-processes-in-x86-64.patch
  Force read implies exec for all 32bit processes in x86-64

oprofile-arm-xscale1-pmu-support-fix.patch
  OProfile: ARM/XScale1 PMU support fix

nfsd--sgi-921857-find-broken-with-nohide-on-nfsv3.patch
  SGI 921857: find broken with nohide on NFSv3

nfsd--exportfs-reduce-stack-usage.patch
  nfsd: exportfs: reduce stack usage

nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
  nfsd: svcrpc: add a per-flavor set_client method

nfsd--svcrpc-rename-pg_authenticate.patch
  nfsd: svcrpc: rename pg_authenticate

nfsd--svcrpc-move-export-table-checks-to-a-per-program-pg_add_client-method.patch
  nfsd: svcrpc: move export table checks to a per-program pg_add_client method

nfsd--nfs4-use-new-pg_set_client-method-to-simplify-nfs4-callback-authentication.patch
  nfsd: nfs4: use new pg_set_client method to simplify nfs4 callback authentication

nfsd--lockd-dont-try-to-match-callback-requests-against-export-table.patch
  nfsd: lockd: don't try to match callback requests against export table

nfsd--nfsd-remove-pg_authenticate-field.patch
  nfsd: nfsd: remove pg_authenticate field

nfsd--global-static-cleanups-for-nfsd.patch
  nfsd: global/static cleanups for nfsd

nfsd--change-nfsd-reply-cache-to-use-listh-lists.patch
  nfsd: change nfsd reply cache to use list.h lists

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

ia64-acpi-build-fix.patch
  ia64 acpi build fix

add-try_acquire_console_sem.patch
  Add try_acquire_console_sem

update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch
  update aty128fb sleep/wakeup code for new powermac changes

radeonfb-update.patch
  radeonfb update

radeonfb-build-fix.patch
  radeonfb-build-fix

acpi-sleep-while-atomic-during-s3-resume-from-ram.patch
  acpi: sleep-while-atomic during S3 resume from ram

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

acpi-flush-tlb-when-pagetable-changed.patch
  acpi: flush TLB when pagetable changed

fix-an-issue-in-acpi-processor-and-container-drivers-related-with-kobject_hotplug.patch
  Fix an issue in ACPI processor and container drivers related  with kobject_hotplug()

acpi-fix-containers-notify-handler-to-handle-proper-cases-properly.patch
  acpi: fix container's notify handler to handle proper cases properly

acpi_power_off-bug-fix.patch
  acpi_power_off bug fix

bk-agpgart.patch

bk-alsa.patch

fix-32-bit-calls-to-snd_pcm_channel_info.patch
  Fix 32-bit calls to snd_pcm_channel_info()

bk-arm.patch

bk-cifs.patch

bk-cpufreq.patch

cpufreq-core-reduce-warning-messages.patch
  cpufreq-core: reduce warning messages

bk-drm-via.patch

bk-i2c.patch

changes-to-the-i2c-driver-to-support-a-non-blocking-interface.patch
  Changes to the I2C driver to support a non-blocking interface

minor-ipmi-enhancements.patch
  Minor IPMI enhancements

update-to-ipmi-driver-to-support-old-dmi-spec.patch
  Update to IPMI driver to support old DMI spec

modify-the-i801-i2c-driver-to-use-the-non-blocking-interface.patch
  Modify the i801 I2C driver to use the non-blocking interface.

add-the-ipmi-smbus-driver.patch
  Add the IPMI SMBus driver

add-the-ipmi-smbus-driver-fix.patch
  ipmi-build-fix-42

add-the-ipmi-smbus-driver-fix-fix.patch
  add-the-ipmi-smbus-driver-fix fix

bk-ieee1394.patch

ohci1394-dma_pool_destroy-while-in_atomic-irqs_disabled.patch
  ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
  ohci1394-dma_pool_destroy-while-in_atomic-irqs_disabled-tidy
  ohci1394-dma_pool_destroy-while-in_atomic-irqs_disabled-simplification

sbp2-fix-hang-on-unload.patch
  sbp2: fix hang on unload

bk-input.patch

bk-dtor-input.patch

serio-warning-fix.patch
  serio warning fix

twidjoy-build-fix.patch
  twidjoy-build-fix

bk-jfs.patch

bk-kbuild.patch

bk-kconfig.patch

bk-netdev.patch

bk-ntfs.patch

bk-scsi.patch

bk-scsi-rc-fixes.patch

bk-serial.patch

bk-usb.patch

compat-ioctl-for-submiting-urb.patch
  compat ioctl for submiting URB

compat-ioctl-for-submiting-urb-fix.patch
  compat-ioctl-for-submiting-urb-fix

bk-watchdog.patch

bk-xfs.patch

mm.patch
  add -mmN to EXTRAVERSION

vm-pageout-throttling.patch
  vm: pageout throttling

orphaned-pagecache-memleak-fix.patch
  orphaned pagecache memleak fix

swapspace-layout-improvements.patch
  swapspace-layout-improvements

swapspace-layout-improvements-fix.patch
  /proc/swaps negative Used

simpler-topdown-mmap-layout-allocator.patch
  simpler topdown mmap layout allocator

vmscan-reclaim-swap_cluster_max-pages-in-a-single-pass.patch
  vmscan: reclaim SWAP_CLUSTER_MAX pages in a single pass

fix-mincore-cornercases-overflow-caused-by-large-len.patch
  Fix mincore cornercases: overflow caused by large "len"

fix-small-vmalloc-per-allocation-limit.patch
  Fix small vmalloc per allocation limit

randomisation-global-sysctl.patch
  Randomisation: global sysctl

randomisation-global-sysctl-fix.patch
  randomisation-global-sysctl-fix

randomisation-infrastructure.patch
  Randomisation: infrastructure

fix-compilation-of-uml-after-the-stack-randomization-patches.patch
  Fix compilation of UML after the stack-randomization patches

randomisation-add-pf_randomize.patch
  Randomisation: add PF_RANDOMIZE

randomisation-stack-randomisation.patch
  Randomisation: stack randomisation

randomisation-mmap-randomisation.patch
  Randomisation: mmap randomisation

randomisation-enable-by-default.patch
  Randomisation: enable by default

randomisation-addr_no_randomize-personality.patch
  Randomisation: add ADDR_NO_RANDOMIZE personality

randomisation-top-of-stack-randomization.patch
  Randomisation: top-of-stack randomization

move-accounting-function-calls-out-of-critical-vm-code-pathspatch.patch
  Move accounting function calls out of critical vm code paths

invalidate-range-of-pages-after-direct-io-write.patch
  invalidate range of pages after direct IO write

invalidate-range-of-pages-after-direct-io-write-fix.patch
  invalidate-range-of-pages-after-direct-io-write-fix

invalidate-range-of-pages-after-direct-io-write-fix-fix.patch
  invalidate-range-of-pages-after-direct-io-write-fix-fix

write-and-wait-on-range-before-direct-io-read.patch
  write and wait on range before direct io read

only-unmap-what-intersects-a-direct_io-op.patch
  only unmap what intersects a direct_IO op

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

b44-bounce-buffer-fix.patch
  b44 bounce buffering fix

net-s2io-replace-schedule_timeout-with-msleep.patch
  net/s2io: replace schedule_timeout() with msleep()

ppc-ppc64-abstract-cpu_feature-checks.patch
  PPC/PPC64: Abstract cpu_feature checks.

ppc32-dont-create-tmp_gas_check.patch
  ppc32: Don't create .tmp_gas_check

ppc32-fix-mv64x60-register-relocation-bug-in-bootwrapper.patch
  ppc32: fix mv64x60 register relocation bug in bootwrapper

ppc64-remove-unneeded-includes-from-pseries_nvramc.patch
  remove unneeded includes from pSeries_nvram.c

ppc64-collect-and-export-low-level-cpu-usage-statistics.patch
  ppc64: collect and export low-level cpu usage statistics

ppc64-move-systemcfg-out-of-heads.patch
  ppc64: Move systemcfg out of head.S

ppc64-defconfig-updates.patch
  ppc64: defconfig updates

ppc64-distribute-export_symbols.patch
  ppc64: distribute EXPORT_SYMBOLs

ppc64-implement-a-vdso-and-use-it-for-signal-trampoline.patch
  ppc64: Implement a vDSO and use it for signal trampoline

ppc64-generic-hotplug-cpu-support.patch
  ppc64: generic hotplug cpu support

ppc64-disable-hmt-for-rs64-cpus.patch
  ppc64: disable HMT for RS64 cpus

use-vmlinux-during-make-install-on-ppc64.patch
  ppc64: use vmlinux during make install on ppc64

ppc64-functions-to-reserve-performance-monitor-hardware.patch
  ppc64: functions to reserve performance monitor hardware

ppc64-reloc_hide.patch

agpgart-allow-multiple-backends-to-be-initialized.patch
  agpgart: allow multiple backends to be initialized
  agpgart-allow-multiple-backends-to-be-initialized fix
  agpgart: add bridge assignment missed in agp_allocate_memory
  x86_64 agp failure fix

agpgart-allow-multiple-backends-to-be-initialized-fix.patch
  agpgart-allow-multiple-backends-to-be-initialized-fix

agpgart-add-agp_find_bridge-function.patch
  agpgart: add agp_find_bridge function

agpgart-allow-drivers-to-allocate-memory-local-to.patch
  agpgart: allow drivers to allocate memory local to the bridge

drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
  drm: add support for new multiple agp bridge agpgart api

fb-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
  fb: add support for new multiple agp bridge agpgart api

agpgart-add-bridge-parameter-to-driver-functions.patch
  agpgart: add bridge parameter to driver functions

mips-add-tanbac-tb0219-base-board-driver.patch
  mips: add TANBAC TB0219 base board driver

allow-hot-add-enabled-i386-numa-box-to-boot.patch
  Allow hot-add enabled i386 NUMA box to boot

refactor-i386-memory-setup.patch
  x86: refactor memory setup

consolidate-set_max_mapnr_init-implementations.patch
  x86: consolidate set_max_mapnr_init() implementations

remove-free_all_bootmem-define.patch
  x86: remove-free_all_bootmem() #define

out-of-line-x86-put_user-implementation.patch
  out-of-line x86 "put_user()" implementation

x86_64-hugetlb-fix.patch
  x86_64: hugetlb fix

xen-vmm-4-add-ptep_establish_new-to-make-va-available.patch
  Xen VMM #4: add ptep_establish_new to make va available

xen-vmm-4-return-code-for-arch_free_page.patch
  Xen VMM #4: return code for arch_free_page

xen-vmm-4-return-code-for-arch_free_page-fix.patch
  Get rid of arch_free_page() warning

xen-vmm-4-runtime-disable-of-vt-console.patch
  Xen VMM #4: runtime disable of VT console

xen-vmm-4-has_arch_dev_mem.patch
  Xen VMM #4: HAS_ARCH_DEV_MEM

xen-vmm-4-split-free_irq-into-teardown_irq.patch
  Xen VMM #4: split free_irq into teardown_irq

swsusp-do-not-use-higher-order-memory-allocations-on-suspend.patch
  swsusp: do not use higher order memory allocations on suspend

swsusp-do-not-use-higher-order-memory-allocations-on-suspend-fix.patch
  swsusp-do-not-use-higher-order-memory-allocations-on-suspend fix

swsusp-do-not-use-higher-order-memory-allocations-on-suspend-fix-fix.patch
  swsusp-do-not-use-higher-order-memory-allocations-on-suspend fix fix

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
  Allow admin to enable only some of the Magic-Sysrq functions

fix-partial-sysrq-setting.patch
  Fix partial sysrq setting

sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch
  Sort out PCI_ROM_ADDRESS_ENABLE vs IORESOURCE_ROM_ENABLE

irqpoll.patch
  irqpoll

poll-mini-optimisations.patch
  poll: mini optimisations

mtrr-size-and-base-debug.patch
  mtrr size-and-base debugging

cleanup-vc-array-access.patch
  cleanup vc array access

remove-console_macrosh.patch
  remove console_macros.h

merge-vt_struct-into-vc_data.patch
  merge vt_struct into vc_data

merge-vt_struct-into-vc_data-fix.patch
  merge-vt_struct-into-vc_data fix

jbd-journal-overflow-fix-2.patch
  jbd: journal overflow fix #2

jbd-fix-against-journal-overflow.patch
  JBD: reduce stack and number of journal descriptors

jbd-fix-against-journal-overflow-tidies.patch
  jbd-fix-against-journal-overflow-tidies

jbd-log-space-management-optimization.patch
  JBD: log space management optimization

factor-out-phase-6-of-journal_commit_transaction.patch
  Factor out phase 6 of journal_commit_transaction

ext3-cleanup-1.patch
  ext3 cleanup 1

ext3-free-block-accounting-fix.patch
  ext3: free block accounting fix

ext3_test_root-speedup.patch
  ext3_test_root() speedup

i4l-new-hfc_usb-driver-version.patch
  i4l: new hfc_usb driver version

i4l-hfc-4s-and-hfc-8s-driver.patch
  i4l: HFC-4S and HFC-8S driver

fix-race-between-the-nmi-code-and-the-cmos-clock.patch
  Fix race between the NMI code and the CMOS clock

cant-unmount-bad-inode.patch
  Can't unmount bad inode

iounmap-debugging.patch
  iounmap debugging

fix-put_user-under-mmap_sem-in-sys_get_mempolicy.patch
  fix put_user under mmap_sem in sys_get_mempolicy()

oss-support-for-ac97-low-power-codecs.patch
  OSS Support for AC97 low power codecs

fix-kallsyms-insmod-rmmod-race.patch
  Fix kallsyms/insmod/rmmod race

fix-kallsyms-insmod-rmmod-race-fix.patch
  fix-kallsyms-insmod-rmmod-race fix

fix-kallsyms-insmod-rmmod-race-fix-fix.patch
  fix-kallsyms-insmod-rmmod-race-fix-fix

d_drop-should-use-per-dentry-lock.patch
  d_drop should use per dentry lock

detect-soft-lockups.patch
  detect soft lockups

touch_softlockup_watchdog.patch
  touch_softlockup_watchdog()

fix-softlockup-warning-in-swsuspend-resume.patch
  fix softlockup warning in swsuspend resume

serialize-access-to-ide-devices.patch
  serialize access to ide devices

add-struct-request-end_io-callback.patch
  Add struct request end_io callback

add-struct-request-end_io-callback-fix.patch
  add-struct-request-end_io-callback fix

rework-core-barrier-support.patch
  rework core barrier support

scsi_io_completion-sense-copy.patch
  scsi_io_completion sense copy

blk_execute_rq-oops-on-fast-completion.patch
  blk_execute_rq() oops on fast completion

nls_cp936c-is-not-synchronized-with-ms-translation-table.patch
  nls_cp936.c is not synchronized with M$'s translation table

annotate-proc-pid-maps-with--markers.patch
  annotate /proc/<PID>/maps with [heap]/[stack]/[vdso] markers

serial-add-nec-vr4100-series-serial-support.patch
  serial: add NEC VR4100 series serial support

sys_setpriority-euid-semantics-fix.patch
  sys_setpriority() euid semantics fix

add-tcsbrkp-to-compat_ioctlh.patch
  add TCSBRKP to compat_ioctl.h

areca-raid-linux-scsi-driver.patch
  ARECA RAID Linux scsi driver

add-local-bio-pool-support-and-modify-dm.patch
  add local bio pool support and modify dm

add-local-bio-pool-support-and-modify-dm-uninline-zero_fill_bio.patch
  uninline-zero_fill_bio

minor-conceptual-fix-for-proc-kcore-header-size.patch
  minor conceptual fix for /proc/kcore header size

floppy-add-sysfs-symlink.patch
  floppy.c: add sysfs symlink

add-compiler-gcc4h.patch
  add compiler-gcc4.h

rt-lsm.patch
  RT-LSM

convert-proc-driver-rtc-to-seq_file.patch
  convert /proc/driver/rtc to seq_file.

drivers-char-lpc-race-fix.patch
  drivers/char/lp.c race fix

clean-up-and-unify-asm-resourceh-files.patch
  clean up and unify asm-*/resource.h files

base-small-introduce-the-config_base_small-flag.patch
  base-small: introduce the CONFIG_BASE_SMALL flag

base-small-shrink-chrdevs-hash.patch
  base-small: shrink chrdevs hash

base-small-shrink-pid-tables.patch
  base-small: shrink PID tables

base-small-shrink-uid-hash.patch
  base-small: shrink UID hash

base-small-shrink-futex-queues.patch
  base-small: shrink futex queues

base-small-shrink-timer-hashes.patch
  base-small: shrink timer hashes

base-small-shrink-console-buffer.patch
  base-small: shrink console buffer

lib-sort-heapsort-implementation-of-sort.patch
  lib/sort: Heapsort implementation of sort()

sort-fix.patch
  sort fix

sort-export.patch
  sort export

sort-build-fix.patch
  sort build fix

lib-sort-turn-off-self-test.patch
  lib/sort: turn off self-test

lib-sort-replace-qsort-in-xfs.patch
  lib/sort: Replace qsort in XFS

lib-sort-replace-insertion-sort-in-exception-tables.patch
  lib/sort: Replace insertion sort in exception tables

lib-sort-replace-insertion-sort-in-ia64-exception-tables.patch
  lib/sort: Replace insertion sort in IA64 exception tables

lib-sort-use-generic-sort-on-x86_64.patch
  lib/sort: Use generic sort on x86_64

random-pt2-cleanup-waitqueue-logic-fix-missed-wakeup.patch
  random: cleanup waitqueue logic, fix missed wakeup

random-pt2-kill-pool-clearing.patch
  random: kill pool clearing

random-pt2-combine-legacy-ioctls.patch
  random: combine legacy ioctls

random-pt2-re-init-all-pools-on-zero.patch
  random: re-init all pools on zero

random-pt2-simplify-initialization.patch
  random: simplify initialization

random-pt2-kill-memsets-of-static-data.patch
  random: kill memsets of static data

random-pt2-kill-dead-extract_state-struct.patch
  random: kill dead extract_state struct

random-pt2-kill-22-compat-waitqueue-defs.patch
  random: kill 2.2 compat waitqueue defs

random-pt2-kill-redundant-rotate_left-definitions.patch
  random: kill redundant rotate_left definitions

random-pt2-kill-redundant-rotate_left-definitions-fix.patch
  rol32 thinko

random-pt2-kill-misnamed-log2.patch
  random: kill misnamed log2

random-pt3-more-meaningful-pool-names.patch
  random: More meaningful pool names

random-pt3-static-allocation-of-pools.patch
  random: Static allocation of pools

random-pt3-static-sysctl-bits.patch
  random: Static sysctl bits

random-pt3-catastrophic-reseed-checks.patch
  random: Catastrophic reseed checks

random-pt3-entropy-reservation-accounting.patch
  random: Entropy reservation accounting

random-pt3-reservation-flag-in-pool-struct.patch
  random: Reservation flag in pool struct

random-pt3-reseed-pointer-in-pool-struct.patch
  random: Reseed pointer in pool struct

random-pt3-break-up-extract_user.patch
  random: Break up extract_user

random-pt3-remove-dead-md5-copy.patch
  random: Remove dead MD5 copy

random-pt3-simplify-hash-folding.patch
  random: Simplify hash folding

random-pt3-clean-up-hash-buffering.patch
  random: Clean up hash buffering

random-pt3-remove-entropy-batching.patch
  random: Remove entropy batching

random-pt4-create-new-rol32-ror32-bitops.patch
  random: Create new rol32/ror32 bitops

random-pt4-use-them-throughout-the-tree.patch
  random: Use them throughout the tree

random-pt4-kill-the-sha-variants.patch
  random: Kill the SHA variants

random-pt4-cleanup-sha-interface.patch
  random: Cleanup SHA interface

random-pt4-move-sha-code-to-lib.patch
  random: Move SHA code to lib/

random-pt4-replace-sha-with-faster-version.patch
  random: Replace SHA with faster version

random-pt4-replace-sha-with-faster-version-fix.patch
  random-pt4-replace-sha-with-faster-version-fix

random-pt4-replace-sha-with-faster-version-fix-fix.patch
  SHA1 clarify kerneldoc

random-pt4-replace-sha-with-faster-version-fix-fix-fix.patch
  random-pt4-cleanup-sha-interface fix

random-pt4-update-cryptolib-to-use-sha-fro-lib.patch
  random: Update cryptolib to use SHA fro lib

random-pt4-move-halfmd4-to-lib.patch
  random: Move halfmd4 to lib

random-pt4-kill-duplicate-halfmd4-in-ext3-htree.patch
  random: Kill duplicate halfmd4 in ext3 htree

random-pt4-kill-duplicate-halfmd4-in-ext3-htree-fix.patch
  random-pt4-kill-duplicate-halfmd4-in-ext3-htree-fix

random-pt4-simplify-and-shrink-syncookie-code.patch
  random: Simplify and shrink syncookie code

random-pt4-move-syncookies-to-net.patch
  random: Move syncookies to net/

speedup-proc-pid-maps.patch
  Speed up /proc/pid/maps

speedup-proc-pid-maps-fix.patch
  Speed up /proc/pid/maps fix

speedup-proc-pid-maps-fix-fix.patch
  speedup-proc-pid-maps fix fix

speedup-proc-pid-maps-fix-fix-fix.patch
  speedup /proc/<pid>/maps(4th version)

fix-loss-of-records-on-size-4096-in-proc-pid-maps.patch
  fix loss of records on size > 4096 in proc/<pid>/maps

speedup-proc-pid-maps-fix-fix-fix-fix.patch
  speedup-proc-pid-maps-fix-fix-fix fix

posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic.patch
  posix-timers: tidy up clock interfaces and consolidate dispatch logic

posix-timers-high-resolution-cpu-clocks-for-posix-clock_-syscalls.patch
  posix-timers: high-resolution CPU clocks for POSIX clock_* syscalls

posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic-cleanup.patch
  posix-timers: tidy up clock interfaces and  consolidate dispatch logic cleanup

posix-timers-fix-posix-timers-signals-lock-order.patch
  posix-timers: fix posix-timers signals lock order

posix-timers-cpu-clock-support-for-posix-timers.patch
  posix-timers: CPU clock support for POSIX timers

posix-timers-cpu-clock-support-for-posix-timers-fix.patch
  posix-timers: CPU clock support for POSIX timers (fix)

panic-in-check_process_timers.patch
  PANIC in check_process_timers()

make-itimer_real-per-process.patch
  make ITIMER_REAL per-process

make-itimer_prof-itimer_virtual-per-process.patch
  make ITIMER_PROF, ITIMER_VIRTUAL per-process

make-rlimit_cpu-sigxcpu-per-process.patch
  make RLIMIT_CPU/SIGXCPU per-process

pcmcia-add-support-ti-pci4510-cardbus-bridge.patch
  pcmcia: Add support TI PCI4510 CardBus bridge

pcmcia-update-vrc4171_card.patch
  pcmcia: update vrc4171_card

nfs-fix_vfsflock.patch
  VFS: Fix structure initialization in locks_remove_flock()

nfs-flock.patch
  NFS: Add emulation of BSD flock() in terms of POSIX locks on the server

nfsacl-return-enosys-for-rpc-programs-that-are-unavailable.patch
  nfsacl: return -ENOSYS for RPC programs that are unavailable

nfsacl-add-missing-eopnotsupp-=-nfs3err_notsupp-mapping-in-nfsd.patch
  nfsacl: add missing -EOPNOTSUPP => NFS3ERR_NOTSUPP mapping in nfsd

nfsacl-allow-multiple-programs-to-listen-on-the-same-port.patch
  nfsacl: allow multiple programs to listen on the same port

nfsacl-allow-multiple-programs-to-share-the-same-transport.patch
  nfsacl: allow multiple programs to share the same transport

nfsacl-lazy-rpc-receive-buffer-allocation.patch
  nfsacl: lazy RPC receive buffer allocation

nfsacl-encode-and-decode-arbitrary-xdr-arrays.patch
  nfsacl: encode and decode arbitrary XDR arrays

nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix.patch
  nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix

nfsacl-add-noacl-nfs-mount-option.patch
  nfsacl: add noacl nfs mount option

nfsacl-infrastructure-and-server-side-of-nfsacl.patch
  nfsacl: infrastructure and server side of nfsacl

nfsv4-deamon-always-supports-acls.patch
  NFSv4 deamon always supports acls

lib-sort-replace-qsort-in-nfs-acl-code.patch
  lib/sort: Replace qsort in NFS ACL code

nfsacl-infrastructure-and-server-side-of-nfsacl-fix.patch
  nfsacl-infrastructure-and-server-side-of-nfsacl fix

nfsacl-solaris-nfsacl-workaround.patch
  nfsacl: solaris nfsacl workaround

nfsacl-client-side-of-nfsacl.patch
  nfsacl: client side of nfsacl

nfsacl-client-side-of-nfsacl-fix.patch
  nfsacl: Must not initialize inode->i_op to NULL

nfsacl-acl-umask-handling-workaround-in-nfs-client.patch
  nfsacl: aCL umask handling workaround in nfs client

nfsacl-acl-umask-handling-workaround-in-nfs-client-fix.patch
  ACL umask handling workaround in nfs client fix

nfsacl-cache-acls-on-the-nfs-client-side.patch
  nfsacl: cache acls on the nfs client side

nfs-acl-build-fix-posix-acl-config-tidy.patch
  NFS ACL build fix, POSIX ACL config tidy

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

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

dev-mem-restriction-patch-allow-reads.patch
  dev-mem-restriction-patch: allow reads

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

page-owner-tracking-leak-detector.patch
  Page owner tracking leak detector

make-page_owner-handle-non-contiguous-page-ranges.patch
  make page_owner handle non-contiguous page ranges

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

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

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

allow-modular-ide-pnp.patch
  allow modular ide-pnp

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm

ppc64-fix-cpu-hotplug.patch
  ppc64: fix hotplug cpu

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

x86_64-entry64.patch
  kexec: x86_64: add 64-bit entry

x86-config-kernel-start.patch
  kexec: x86: add CONFIG_PYSICAL_START

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

x86_64-machine_shutdown.patch
  kexec: x86_64: factor out apic shutdown code

x86_64-kexec.patch
  kexec: x86_64 kexec implementation

x86_64-crashkernel.patch
  crashdump: x86_64: crashkernel option

kexec-ppc-support.patch
  kexec: kexec ppc support

x86-crash_shutdown-nmi-shootdown.patch
  crashdump: x86: add NMI handler to capture other CPUs

x86-crash_shutdown-snapshot-registers.patch
  kexec: x86: snapshot registers during crash shutdown

x86-crash_shutdown-apic-shutdown.patch
  kexec: x86 shutdown APICs during crash_shutdown

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-routines-for-copying-dump-pages-fixes.patch
  crashdump-routines-for-copying-dump-pages-fixes

crashdump-elf-format-dump-file-access.patch
  crashdump: elf format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear raw format dump file access

crashdump-linear-raw-format-dump-file-access-coding-style.patch
  crashdump-linear-raw-format-dump-file-access-coding-style

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-move-cpusets-above-embedded.patch
  move CPUSETS above EMBEDDED

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

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

lib-sort-replace-open-coded-opids2-bubblesort-in-cpusets.patch
  lib/sort: Replace open-coded O(pids**2) bubblesort in cpusets

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

reiser4-export-find_get_pages.patch

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

reiser4-recover-read-performance.patch
  reiser4: recover read performance

reiser4-export-find_get_pages_tag.patch
  reiser4-export-find_get_pages_tag

reiser4-add-missing-context.patch

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

generic-serial-cli-conversion.patch
  generic-serial cli() conversion

specialix-io8-cli-conversion.patch
  Specialix/IO8 cli() conversion

sx-cli-conversion.patch
  SX cli() conversion

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again.patch
  make acpi_bus_register_driver() consistent with pci_register_driver()

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()

ipvs-deadlock-fix.patch
  ipvs deadlock fix

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

radeonfb-fix-spurious-error-return-in-fbio_radeon_set_mirror.patch
  radeonfb: Fix spurious error return in FBIO_RADEON_SET_MIRROR

w100fb-make-blanking-function-interrupt-safe.patch
  w100fb: Make blanking function interrupt safe

kyrofb-copy__user-return-value-checks-added-to-kyro-fb.patch
  kyrofb: copy_*_user return value checks added to kyro fb

skeletonfb-documentation-fixes.patch
  skeletonfb: Documentation fixes

intelfb-add-partial-support-915g-chipset.patch
  intelfb: Add partial support 915G chipset

sisfb_compat_ioctl-warning-fix.patch
  fbdev compat_ioctl warning fix

sis-warning-fix.patch
  sis warning fix

tridentfbc-make-some-code-static.patch
  tridentfb.c: make some code static

tridentfb-warning-fix.patch
  tridentfb warning fix

md-fix-multipath-assembly-bug.patch
  md: fix multipath assembly bug

md-raid-kconfig-cleanups-remove-experimental-tag-from-raid-6.patch
  md: RAID Kconfig cleanups, remove experimental tag from RAID-6

device-mapper-store-name-directly-against-device.patch
  device-mapper: Store name directly against device

device-mapper-record-restore-bio-state.patch
  device-mapper: Record & restore bio state.

device-mapper-export-map_info.patch
  device-mapper: Export map_info

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

update-documentation-filesystems-locking.patch
  Update Documentation/filesystems/Locking

post-halloween-doc.patch
  post halloween doc

periodically-scan-redzone-entries-and-slab-control-structures.patch
  periodically scan redzone entries and slab control structures

fuse-maintainers-kconfig-and-makefile-changes.patch
  Subject: [PATCH 1/11] FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  Subject: [PATCH 2/11] FUSE - core

fuse-device-functions.patch
  Subject: [PATCH 3/11] FUSE - device functions

fuse-device-functions-fix-race-in-interrupted-request.patch
  fuse: fix race in interrupted request

fuse-device-functions-fix.patch
  fuse: better error reporting in fuse_fill_super

fuse-fix-llseek-on-device.patch
  FUSE: fix llseek on device

fuse-make-two-functions-static.patch
  fuse: make two functions static

fuse-fix-variable-with-confusing-name.patch
  fuse: fix variable with confusing name

fuse-read-only-operations.patch
  Subject: [PATCH 4/11] FUSE - read-only operations

fuse-read-write-operations.patch
  Subject: [PATCH 5/11] FUSE - read-write operations

fuse-read-write-operations-fix.patch
  fuse: fix hard link operation

fuse-file-operations.patch
  Subject: [PATCH 6/11] FUSE - file operations

fuse-mount-options.patch
  Subject: [PATCH 7/11] FUSE - mount options

fuse-dont-check-against-zero-fsuid.patch
  fuse: don't check against zero fsuid

fuse-remove-mount_max-and-user_allow_other-module-parameters.patch
  fuse: remove mount_max and user_allow_other module parameters

fuse-extended-attribute-operations.patch
  Subject: [PATCH 8/11] FUSE - extended attribute operations

fuse-readpages-operation.patch
  Subject: [PATCH 9/11] FUSE - readpages operation

fuse-nfs-export.patch
  Subject: [PATCH 10/11] FUSE - NFS export

fuse-direct-i-o.patch
  Subject: [PATCH 11/11] FUSE - direct I/O

fuse-transfer-readdir-data-through-device.patch
  fuse: transfer readdir data through device

cryptoapi-prepare-for-processing-multiple-buffers-at.patch
  CryptoAPI: prepare for processing multiple buffers at a time

cryptoapi-update-padlock-to-process-multiple-blocks-at.patch
  CryptoAPI: Update PadLock to process multiple blocks at  once

update-email-address-of-andrea-arcangeli.patch
  update email address of Andrea Arcangeli

compile-error-blackbird_load_firmware.patch
  blackbird_load_firmware compile fix

i386-x86_64-apicc-make-two-functions-static.patch
  i386/x86_64 apic.c: make two functions static

i386-cyrixc-make-a-function-static.patch
  i386 cyrix.c: make a function static

mtrr-some-cleanups.patch
  mtrr: some cleanups

i386-cpu-commonc-some-cleanups.patch
  i386 cpu/common.c: some cleanups

i386-cpuidc-make-two-functions-static.patch
  i386 cpuid.c: make two functions static

i386-efic-make-some-code-static.patch
  i386 efi.c: make some code static

i386-x86_64-io_apicc-misc-cleanups.patch
  i386/x86_64 io_apic.c: misc cleanups

i386-mpparsec-make-mp_processor_info-static.patch
  i386 mpparse.c: make MP_processor_info static

i386-x86_64-msrc-make-two-functions-static.patch
  i386/x86_64 msr.c: make two functions static

3w-abcdh-tw_device_extension-remove-an-unused-filed.patch
  3w-abcd.h: TW_Device_Extension: remove an unused field

hpet-make-some-code-static.patch
  hpet: make some code static

26-patch-i386-trapsc-make-a-function-static.patch
  i386 traps.c: make a function static

i386-semaphorec-make-4-functions-static.patch
  i386 semaphore.c: make 4 functions static

kill-aux_device_present.patch
  kill aux_device_present

i386-setupc-make-4-variables-static.patch
  i386 setup.c: make 4 variables static

mostly-i386-mm-cleanup.patch
  (mostly i386) mm cleanup

update-email-address-of-benjamin-lahaise.patch
  Update email address of Benjamin LaHaise

update-email-address-of-philip-blundell.patch
  Update email address of Philip Blundell

kernel-acctc-make-a-function-static.patch
  kernel/acct.c: make a function static

kernel-auditc-make-some-functions-static.patch
  kernel/audit.c: make some functions static

kernel-capabilityc-make-a-spinlock-static.patch
  kernel/capability.c: make a spinlock static

mm-thrashc-make-a-variable-static.patch
  mm/thrash.c: make a variable static

lib-kernel_lockc-make-kernel_sem-static.patch
  lib/kernel_lock.c: make kernel_sem static

saa7146_vv_ksymsc-remove-two-unused-export_symbol_gpls.patch
  saa7146_vv_ksyms.c: remove two unused EXPORT_SYMBOL_GPL's

fix-placement-of-static-inline-in-nfsdh.patch
  fix placement of static inline in nfsd.h

drivers-block-umemc-make-two-functions-static.patch
  drivers/block/umem.c: make two functions static

drivers-block-xdc-make-a-variable-static.patch
  drivers/block/xd.c: make a variable static

kernel-forkc-make-mm_cachep-static.patch
  kernel/fork.c: make mm_cachep static

kernel-forkc-make-mm_cachep-static-fix.patch
  kernel-forkc-make-mm_cachep-static fix

mm-page-writebackc-remove-an-unused-function.patch
  mm/page-writeback.c: remove an unused function

mm-shmemc-make-a-struct-static.patch
  mm/shmem.c: make a struct static

misc-isapnp-cleanups.patch
  misc ISAPNP cleanups

some-pnp-cleanups.patch
  some PNP cleanups

if-0-cx88_risc_disasm.patch
  #if 0 cx88_risc_disasm

make-loglevels-in-init-mainc-a-little-more-sane.patch
  Make loglevels in init/main.c a little more sane.

isicom-use-null-for-pointer.patch
  sparse: use NULL for pointer

remove-bouncing-email-address-of-hennus-bergman.patch
  remove bouncing email address of Hennus Bergman

cirrusfbc-make-some-code-static.patch
  cirrusfb.c: make some code static

matroxfb_basec-make-some-code-static.patch
  matroxfb_base.c: make some code static

matroxfb_basec-make-some-code-static-fix.patch
  matroxfb_basec-make-some-code-static fix

asiliantfbc-make-some-code-static.patch
  asiliantfb.c: make some code static

i386-apic-kconfig-cleanups.patch
  i386 APIC Kconfig cleanups

security-seclvlc-make-some-code-static.patch
  security/seclvl.c: make some code static

drivers-block-elevatorc-make-two-functions-static.patch
  drivers/block/elevator.c: make two functions static

drivers-block-rdc-make-two-variables-static.patch
  drivers/block/rd.c: make two variables static

loopc-make-two-functions-static.patch
  loop.c: make two functions static

remove-bouncing-email-address-of-thomas-hood.patch
  remove bouncing email address of Thomas Hood

fs-adfs-dir_fc-remove-an-unused-function.patch
  fs/adfs/dir_f.c: remove an unused function

drivers-char-moxac-if-0-an-unused-function.patch
  drivers/char/moxa.c: #if 0 an unused function

fs-lockd-clntprocc-make-2-functions-static.patch
  fs/lockd/clntproc.c: make 2 functions static

oss-sb_cardc-no-need-to-include-mcah.patch
  OSS sb_card.c: no need to include mca.h

ioschedc-use-proper-documentation-path.patch
  *-iosched.c: Use proper documentation path

kernel-resourcec-make-resource_op-static.patch
  kernel/resource.c: make resource_op static

kernel-power-mainc-make-pm_states-static.patch
  kernel/power/main.c: make pm_states static

kernel-sysc-make-some-code-static.patch
  kernel/sys.c: make some code static

scsi-ipsc-make-some-code-static.patch
  SCSI ips.c: make some code static

scsi-psi240ic-make-4-functions-static.patch
  SCSI psi240i.c: make 4 functions static

scsi-src-make-a-struct-static.patch
  SCSI sr.c: make a struct static

small-drivers-video-kyro-cleanups.patch
  small drivers/video/kyro/ cleanups

drivers-video-i810-make-some-code-static.patch
  drivers/video/i810/: make some code static

floppyc-make-some-code-static.patch
  floppy.c: make some code static

drivers-block-nbdc-make-3-functions-static.patch
  drivers/block/nbd.c: make 3 functions static

drivers-block-cpqarrayc-small-cleanups.patch
  drivers/block/cpqarray.c: small cleanups

pcxx-remove-obsolete-driver.patch
  pcxx: Remove obsolete driver

pty-oops-fix.patch
  pty oops fix

mark-the-mcd-cdrom-driver-as-broken.patch
  mark the mcd cdrom driver as BROKEN

warning-fix-in-drivers-cdrom-mcdc.patch
  warning fix in drivers/cdrom/mcd.c

wavefront-reduce-stack-usage.patch
  wavefront: reduce stack usage

mm-page-writebackc-remove-an-unused-function-2.patch
  mm/page-writeback.c: remove an unused function #2

generic_serialh-kill-incorrect-gs_debug-reference.patch
  generic_serial.h: kill incorrect gs_debug reference

kernel-timerc-make-two-variables-static.patch
  kernel/timer.c: make two variables static

remove-the-unused-oss-maestro_tablesh.patch
  remove the unused OSS maestro_tables.h

fs-hfs-misc-cleanups.patch
  fs/hfs/: misc cleanups

fs-hpfs-make-some-code-static.patch
  fs/hpfs/: make some code static

fs-hfsplus-misc-cleanups.patch
  fs/hfsplus/: misc cleanups

i386-x86_64-processc-make-hlt_counter-static.patch
  i386/x86_64 process.c: make hlt_counter static

i386-mach-default-topologyc-make-cpu_devices-static.patch
  i386/mach-default/topology.c: make cpu_devices static

i386-math-emu-misc-cleanups.patch
  i386/math-emu/: misc cleanups

non-pc-parport-config-change.patch
  non-PC parport config change

prism54-misc-cleanups.patch
  prism54: misc cleanups

scsi-qlogicfcc-some-cleanups.patch
  SCSI qlogicfc.c: some cleanups

scsi-qlogicispc-some-cleanups.patch
  SCSI qlogicisp.c: some cleanups

savagefbc-make-some-code-static.patch
  savagefb.c: make some code static

hpet-setup-comment-fix.patch
  hpet setup comment fix

fs-ncpfs-ncplib_kernelc-make-a-function-static.patch
  fs/ncpfs/ncplib_kernel.c: make a function static

kill-iphase5526.patch
  kill IPHASE5526

fs-nfs-make-some-code-static.patch
  fs/nfs/: make some code static

i386-x86_64-acpi-sleepc-kill-unused-acpi_save_state_disk.patch
  i386/x86_64: acpi/sleep.c: kill unused acpi_save_state_disk

smpbootc-cleanups.patch
  smp{,boot}.c cleanups

i386-kernel-i387c-misc-cleanups.patch
  i386/kernel/i387.c: misc cleanups

i386-x86_64-i8259c-make-mask_and_ack_8259a-static.patch
  i386/x86_64 i8259.c: make mask_and_ack_8259A static

scsi-sym53c416c-make-a-function-static.patch
  SCSI sym53c416.c: make a function static

scsi-ultrastorc-make-a-variable-static.patch
  SCSI ultrastor.c: make a variable static

kernel-intermodulec-make-inter_module_get-static.patch
  kernel/intermodule.c: make inter_module_get static



