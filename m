Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264441AbVBDTEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbVBDTEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbVBDTEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:04:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:44010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261194AbVBDSeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:34:04 -0500
Date: Fri, 4 Feb 2005 10:33:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc3-mm1
Message-Id: <20050204103350.241a907a.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/


- The bk-usb and bk-pci and bk-driver-core trees have been temporarily
  dropped from -mm, for they are not healthy at present.

- After many months dormancy, the ieee1394 tree is back and is included in
  -mm.  Anyone who has been having firewire problems please test it.



Changes since 2.6.11-rc2-mm2:

 linus.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ide-dev.patch
 bk-ieee1394.patch
 bk-jfs.patch
 bk-kbuild.patch
 bk-kconfig.patch
 bk-libata.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-scsi-rc-fixes.patch
 bk-watchdog.patch

 Latest versions of external trees.

-alpha-nodemask-build-fix.patch
-alpha-pgd_index-warning-fix.patch
-pnp-64bit-warning-fix.patch
-ftape-syntax-error.patch
-kobject-build-fix.patch
-crypto-test-vector-fix.patch
-ptracelast_siginfo-also-needs-tasklist_lock.patch
-random-overflow-fix.patch
-ext2-quota-leak-fix.patch
-irq_affinity-fix-build-when-config_proc_fs=n.patch
-fix-audit-skb-leak-on-congested-netlink-socket.patch
-some-minor-cleanups-for-audit_log_lost-messages.patch
-wait_for_completion-api-extension-addition-fixes.patch
-task_size-is-variable.patch
-rest_init-local-irq-fix.patch
-ppc32-back-out-idle-patch-for-non-powersaving-cpus.patch
-ppc32-updated-pegasos-support.patch
-i810_audio-offset-lvi-from-civ-to-avoid-stalled-start-fix.patch
-bug-in-io_destroy-fs-aioc1248.patch
-tpm_msc-build-fix.patch
-tpm_atmel-build-fix.patch
-driver-model-more-pm_message_t-conversion.patch
-driver-model-more-pci_choose_states-are-needed.patch
-driver-model-fix-u32-vs-pm_message_t-in-oss.patch
-disable-sidewinder-debug-messages.patch
-kbuild-no-redundant-srctree-in-tags-file.patch
-seagate-st3200822as-sata-disk-needs-to-be-in-sil_blacklist-as-well.patch
-prevent-pci_name_bus-buffer-overflows.patch
-typo-in-pci_scan_bus_parented.patch
-maintainers-add-entry-for-qla2xxx-driver.patch
-logitech-cordeless-desktop-keyboard-fails-to-report-class-descriptor.patch
-mm-oom-killer-tunable.patch
-mm-keep-balance-between-different-classzones.patch
-mm-fix-several-oom-killer-bugs.patch
-mm-fix-several-oom-killer-bugs-fix.patch
-mm-convert-memdie-to-an-atomic-thread-bitflag.patch
-make-used_math-smp-safe.patch
-make-used_math-smp-safe-mips-fix.patch
-alloc_zeroed_user_highpage-to-fix-the-clear_user_highpage-issue.patch
-make-slab-use-alloc_pages-directly.patch
-use-datacs-in-smc91x-driver.patch
-remove-bogus-exports-in-ppp.patch
-ppc32-mv64x60-updates.patch
-ppc32-pmac-sleep-support-update.patch
-ppc32-katana-update.patch
-ppc32-ev64260-update.patch
-ppc32-cpci690-update.patch
-ppc32-perfctl-ppc-fix-duplicate-mmcr0-define.patch
-ppc32-stx-gp3-port.patch
-ppc32-fix-via-ide-driver-for-pegasos.patch
-ppc32-opofile-timer-mode-fallback-fix.patch
-ppc32-workaround-for-mpc10x-speculative-pci-read-erratum.patch
-ppc32-add-platform-specific-machine-check-output-handlers.patch
-ppc32-use-platform-device-style-initialization-for-85xx.patch
-add-eugene-surovegin-to-credits.patch
-ppc32-mpc8245-erratum-28-workaround.patch
-add-try_acquire_console_sem.patch
-update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch
-radeonfb-massive-update-of-pm-code.patch
-radeonfb-build-fix.patch
-ppc64-mask-lower-bits-in-tlbie.patch
-ppc64-iseries-buildbreak-fix.patch
-ppc64-p615-iommu-fix.patch
-mips-generic-mips-updates.patch
-mips-irix-5-compat-fixes.patch
-mips-build-script-fixes.patch
-mips-sgi-ip22-updates.patch
-mips-sibyte-updates.patch
-mips-rm200-updates.patch
-mips-sgi-ip27-updates.patch
-mips-dvh-fixes.patch
-mips-tx49-updates.patch
-mips-txx9-serieal-driver-rewrite.patch
-mips-amd-alchemy-update.patch
-mips-ite-8172-updates.patch
-mips-amd-alchemy-i2c-driver.patch
-mips-sgi-ip32-updates.patch
-mips-decstation-updates.patch
-mips-decstation-turbochannel-updates.patch
-mips-jazz-updates.patch
-mips-mips-technologies-board-updates.patch
-mips-cobalt-updates.patch
-mips-vr41xx-updates.patch
-mips-vr4181-updates.patch
-mips-nec-ddb-board-updates.patch
-mips-tx39-series-updates.patch
-mips-galileo-updates.patch
-mips-pmc-sierra-updates.patch
-mips-momentum-updates.patch
-mips-lasat-updates.patch
-superhyway-bus-support.patch
-wacom-tablet-driver.patch
-bug-in-tty_ioc-after-changes-between-269-rc1-bk1-and-269-rc1-bk2.patch
-trivial-fix-for-i386-cross-compile.patch
-devicestxt-update-with-lanana.patch
-cputime-simplifiy-generic-cputime_to_secs-secs_to_cputime.patch
-mpsc-updates.patch
-unexport-register_cpu-and-unregister_cpu.patch
-add-a-usecs_to_jiffies-function.patch
-initramfs-move-inode-hash-table-to-__initdata.patch
-idmouse-min-fix.patch
-assert_spin_locked.patch
-infiniband-use-lanana-assigned-major-in-ib_umad.patch
-audit-handle-loginuid-through-proc.patch
-init_i82365-lockup-fix.patch
-driver-model-type-checking-for-more-drivers.patch
-oprofile-use-profile_pc-in-oprofile_add_sample.patch
-oprofile-support-model-4-p4.patch
-udf-deadlock-fix.patch
-dvb-follow-usb-__le16-changes.patch
-dvb-fix-access-to-freed-memory.patch
-dvb-support-up-to-six-dvb-cards.patch
-dvb-cleanup-firmware-loading-printks.patch
-sched-fix-preemption-race-core-i386.patch
-sched-make-use-of-preempt_schedule_irq-ppc.patch
-sched-make-use-of-preempt_schedule_irq-arm.patch
-fbdev-fix-return-code-of-edid_checksum.patch
-backlight-add-backlight-driver-for-sharp-corgi-pdas.patch
-backlight-add-backlight-driver-for-sharp-corgi-pdas-fix.patch
-ieee1394-adds-a-disable_irm-option-to-ieee1394ko.patch
-kernel-apisgml-references-removed-file-net_initc.patch

 Merged

+fix-an-error-in-proc-slabinfo-print.patch

 /proc/slabinfo glitch

+ibmveth-inlining-failure.patch

 build fix

+fix-devfs-name-for-the-hvcs-driver.patch

 HVCS driver fix

+uml-compile-fixes.patch

 UML compile fixes

+include-jiffies-fix-usecs_to_jiffies-jiffies_to_usecs-math.patch

 Fix the new jiffy conversion functions

+credits-update.patch

 update CREDITS

+nfsd-needs-exportfs.patch

 Kconfig fix

-acpi-kfree-fix.patch

 Dropped

+fix-an-issue-in-acpi-processor-and-container-drivers-related-with-kobject_hotplug.patch

 ACPI fix

+fix-32-bit-calls-to-snd_pcm_channel_info.patch

 Fix pcm drivers on 64-bit machines.

+cpufreq-core-reduce-warning-messages.patch

 cpufreq noisiness

+changes-to-the-i2c-driver-to-support-a-non-blocking-interface.patch
+minor-ipmi-enhancements.patch
+modify-the-i801-i2c-driver-to-use-the-non-blocking-interface.patch
+add-the-ipmi-smbus-driver.patch
+add-the-ipmi-smbus-driver-fix.patch

 IPMI driver stuff

+input-make-mousedevc-report-all-events-to-user-space-immediately.patch
+input-enable-hardware-tapping-for-alps-touchpads.patch
+input-fix-pointer-jumps-to-corner-of-screen-problem-on-alps-glidepoint-touchpads.patch
+input-add-support-for-synaptics-touchpad-scroll-wheels.patch

 input driver updates

+bk-kconfig-acpi-fix.patch

 Fix bug in bk-kconfig.patch

+driver-model-fix-types-in-usb.patch

 usb fix

-fix-smm-failures-on-e750x-systems.patch

 Dropped, not needed

-page_cache_readahead-unneeded-prev_page-assignments.patch
-cleanup-ahead-window-calculation.patch
-blockable_page_cache_readahead-cleanup.patch
-blockable_page_cache_readahead-cleanup-fix.patch

 Dropped the readahead cleanups due to general confusion and uncertainty. 
 They need another iteration.

+kswapd-throttling-fix.patch

 Fix kswapd CPU burn in weird and unexplained circumstances.

+randomisation-global-sysctl.patch
+randomisation-infrastructure.patch
+randomisation-add-pf_randomize.patch
+randomisation-stack-randomisation.patch
+randomisation-mmap-randomisation.patch
+randomisation-enable-by-default.patch
+randomisation-addr_no_randomize-personality.patch
+randomisation-top-of-stack-randomization.patch

 Randomise the mmap layout to confuse bad guys

+move-accounting-function-calls-out-of-critical-vm-code-pathspatch.patch

 Small MM speedup

+invalidate-range-of-pages-after-direct-io-write.patch
+invalidate-range-of-pages-after-direct-io-write-fix.patch

 Small direct-io speedup

+ppc64-correct-return-code-in-syscall-auditing.patch
+ppc64-show-1-for-physical_id-of-non-present-cpus.patch
+ppc64-replace-last-usage-of-vio-dma-mapping-routines.patch
+ppc64-move-systemcfg-out-of-heads.patch
+ppc64-implement-a-vdso-and-use-it-for-signal-trampoline.patch
+ppc64-generic-hotplug-cpu-support.patch

 ppc64 updates

+agpgart-allow-multiple-backends-to-be-initialized-fix.patch

 Fix  agpgart-allow-multiple-backends-to-be-initialized.patch

+speedstep-libc-fix-frequency-multiplier-for-pentium4.patch

 speedstep fix

+x86_64-parse-noexec=.patch

 x86_64 commandline parsing fix

+swsusp-do-not-use-higher-order-memory-allocations-on-suspend.patch

 swsusp fix

-kunmap-fallout-more-fixes.patch

 Dropped.

-jbd-journal-overflow-fix.patch
-jbd-journal-overflow-fix-fixes.patch
+jbd-journal-overflow-fix-2.patch

 New version

+detect-soft-lockups.patch

 Add a kernel debug feature which will generate an all-cpu backtrace when a
 CPU locks up.  Like the NMI watchdog handler, only more generic.

+add-struct-request-end_io-callback.patch
+rework-core-barrier-support.patch
+scsi_io_completion-sense-copy.patch
+blk_execute_rq-oops-on-fast-completion.patch

 block layer fixes

+nls_cp936c-is-not-synchronized-with-ms-translation-table.patch

 NLS fix

+annotate-proc-pid-maps-with--markers.patch

 Make /proc/pid/maps more user-friendly

+serial-add-nec-vr4100-series-serial-support.patch

 serial update

+sys_setpriority-euid-semantics-fix.patch

 Fix setpriority() a bit

+add-tcsbrkp-to-compat_ioctlh.patch

 compat update

+areca-raid-linux-scsi-driver.patch

 New RAID driver (needs lots of work)

+add-local-bio-pool-support-and-modify-dm.patch
+add-local-bio-pool-support-and-modify-dm-uninline-zero_fill_bio.patch

 Code refactoring

+minor-conceptual-fix-for-proc-kcore-header-size.patch

 /prpoc/kcore handling fix

+pcmcia-dc-initialisation-fix.patch

 PCMCIA fix

+floppy-add-sysfs-symlink.patch

 floppy fix

+base-small-introduce-the-config_base_small-flag.patch
+base-small-shrink-major_names-hash.patch
+base-small-shrink-chrdevs-hash.patch
+base-small-shrink-pid-tables.patch
+base-small-shrink-uid-hash.patch
+base-small-shrink-futex-queues.patch
+base-small-shrink-timer-hashes.patch
+base-small-shrink-console-buffer.patch

 Less RAM on tiny embedded systems

+lib-sort-heapsort-implementation-of-sort.patch
+sort-export.patch
+sort-build-fix.patch
+lib-sort-turn-off-self-test.patch
+lib-sort-replace-qsort-in-xfs.patch
+lib-sort-replace-insertion-sort-in-exception-tables.patch
+lib-sort-replace-insertion-sort-in-ia64-exception-tables.patch
+lib-sort-use-generic-sort-on-x86_64.patch

 Futz with all those sorting functions

-random-pt4-move-other-tcp-ip-bits-to-net.patch

 Dropped due to merging catastrophe.

-relayfs-doc.patch
-relayfs-common-files.patch
-relayfs-remove-klog-debugging-channel.patch
-relayfs-locking-lockless-implementation.patch
-relayfs-headers.patch
-relayfs-remove-klog-debugging-channel-headers.patch
-ltt-core-implementation.patch
-ltt-core-headers.patch
-mips-fixed-ltt-build-errors.patch
-ltt-kconfig-fix.patch
-ltt-doesnt-build-on-x86_64.patch
-ltt-kernel-events.patch
-ltt-kernel-events-tidy.patch
-ltt-kernel-events-build-fix.patch
-ltt-fs-events.patch
-ltt-fs-events-tidy.patch
-ltt-ipc-events.patch
-ltt-mm-events.patch
-ltt-net-events.patch
-ltt-architecture-events.patch
-ltt-architecture-events-mips-fix.patch

 Dropped LTT - it's being redone.

-nfsacl-protocol-extension-for-nfsv3.patch

 This moved various sort() functions around.  Not needed any more.

+lib-sort-replace-qsort-in-nfs-acl-code.patch

 Update the nfsacl patches for the sort()-shuffling.

+nfs-acl-build-fix-posix-acl-config-tidy.patch

 build fix

+make-page_owner-handle-non-contiguous-page-ranges.patch

 Fix the page leak detector.

-rlimit_rt_cpu.patch
-rlimit_rt_cpu-fix.patch
-rlimit_rt_cpu-sparc64-fix.patch

 Dropped these - we'll do it a different way.  The LSM module, it appears.

-add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
-add-sysctl-interface-to-sched_domain-parameters.patch

 For some weird reason these patches were triggering an ia64 oops which has
 nothing to do with these patches.

+kexec-kexec-generic-kexec-use-unsigned-bitfield.patch

 kexec fix

+lib-sort-replace-open-coded-opids2-bubblesort-in-cpusets.patch

 More sort() fallout

+fuse-device-functions-fix-race-in-interrupted-request.patch

 FUSE fix

-kernel-configsc-make-a-variable-static.patch
-kernel-kallsymsc-make-some-code-static.patch

 Other changes broke these

+warning-fix-in-drivers-cdrom-mcdc.patch
+wavefront-reduce-stack-usage.patch
+mm-page-writebackc-remove-an-unused-function-2.patch
+generic_serialh-kill-incorrect-gs_debug-reference.patch
+kernel-timerc-make-two-variables-static.patch
+remove-the-unused-oss-maestro_tablesh.patch
+fs-hfs-misc-cleanups.patch
+fs-hpfs-make-some-code-static.patch
+small-partitions-msdos-cleanups.patch
+fs-hfsplus-misc-cleanups.patch
+i386-x86_64-processc-make-hlt_counter-static.patch
+i386-mach-default-topologyc-make-cpu_devices-static.patch
+i386-math-emu-misc-cleanups.patch
+non-pc-parport-config-change.patch
+prism54-misc-cleanups.patch
+scsi-qlogicfcc-some-cleanups.patch
+scsi-qlogicispc-some-cleanups.patch
+scsi-sim710c-make-some-code-static.patch
+savagefbc-make-some-code-static.patch

 Small code tweaks.




number of patches in -mm: 516
number of changesets in external trees: 504
number of patches in -mm only: 498
total patches: 1002




All 516 patches:


linus.patch

fix-an-error-in-proc-slabinfo-print.patch
  fix an error in /proc/slabinfo print

ibmveth-inlining-failure.patch
  ibmveth inlining failure.

fix-devfs-name-for-the-hvcs-driver.patch
  Fix devfs name for the hvcs driver

uml-compile-fixes.patch
  uml: compile fixes

include-jiffies-fix-usecs_to_jiffies-jiffies_to_usecs-math.patch
  include/jiffies: fix usecs_to_jiffies()/jiffies_to_usecs() math

credits-update.patch
  Update Michal Ludvig details

nfsd-needs-exportfs.patch
  nfsd needs exportfs

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

modify-the-i801-i2c-driver-to-use-the-non-blocking-interface.patch
  Modify the i801 I2C driver to use the non-blocking interface.

add-the-ipmi-smbus-driver.patch
  Add the IPMI SMBus driver

add-the-ipmi-smbus-driver-fix.patch
  ipmi-build-fix-42

bk-ide-dev.patch

bk-ieee1394.patch

input-make-mousedevc-report-all-events-to-user-space-immediately.patch
  input: make mousedev.c report all events to user space immediately

input-enable-hardware-tapping-for-alps-touchpads.patch
  input: enable hardware tapping for ALPS touchpads

input-fix-pointer-jumps-to-corner-of-screen-problem-on-alps-glidepoint-touchpads.patch
  input: fix "pointer jumps to corner of screen" problem on ALPS Glidepoint touchpads

input-add-support-for-synaptics-touchpad-scroll-wheels.patch
  input: add support for Synaptics touchpad scroll wheels

bk-jfs.patch

bk-kbuild.patch

bk-kconfig.patch

bk-kconfig-acpi-fix.patch
  bk-kconfig-acpi-fix

bk-libata.patch

bk-netdev.patch

bk-ntfs.patch

bk-scsi-rc-fixes.patch

driver-model-fix-types-in-usb.patch
  driver model: fix types in usb

bk-watchdog.patch

mm.patch
  add -mmN to EXTRAVERSION

vm-pageout-throttling.patch
  vm: pageout throttling

orphaned-pagecache-memleak-fix.patch
  orphaned pagecache memleak fix

swapspace-layout-improvements.patch
  swapspace-layout-improvements

simpler-topdown-mmap-layout-allocator.patch
  simpler topdown mmap layout allocator

vmscan-reclaim-swap_cluster_max-pages-in-a-single-pass.patch
  vmscan: reclaim SWAP_CLUSTER_MAX pages in a single pass

fix-mincore-cornercases-overflow-caused-by-large-len.patch
  Fix mincore cornercases: overflow caused by large "len"

kswapd-throttling-fix.patch
  kswapd throttling fix

task_size-is-variable.patch
  TASK_SIZE is variable.

use-mm_vm_size-in-exit_mmap.patch
  Use MM_VM_SIZE in exit_mmap

randomisation-global-sysctl.patch
  Randomisation: global sysctl

randomisation-infrastructure.patch
  Randomisation: infrastructure

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

ppc64-correct-return-code-in-syscall-auditing.patch
  ppc64: correct return code in syscall auditing

ppc64-show-1-for-physical_id-of-non-present-cpus.patch
  ppc64: show -1 for physical_id of non-present cpus

ppc64-replace-last-usage-of-vio-dma-mapping-routines.patch
  ppc64: replace last usage of vio dma mapping routines

ppc64-move-systemcfg-out-of-heads.patch
  ppc64: Move systemcfg out of head.S

ppc64-implement-a-vdso-and-use-it-for-signal-trampoline.patch
  ppc64: Implement a vDSO and use it for signal trampoline

ppc64-generic-hotplug-cpu-support.patch
  ppc64: generic hotplug cpu support

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

allow-hot-add-enabled-i386-numa-box-to-boot.patch
  Allow hot-add enabled i386 NUMA box to boot

speedstep-libc-fix-frequency-multiplier-for-pentium4.patch
  speedstep-lib.c: fix frequency multiplier for Pentium4 models 0&1

x86_64-parse-noexec=.patch
  x86_64: parse noexec=[on|off]

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

force-feedback-support-for-uinput.patch
  Force feedback support for uinput

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
  Allow admin to enable only some of the Magic-Sysrq functions

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

serialize-access-to-ide-devices.patch
  serialize access to ide devices

add-struct-request-end_io-callback.patch
  Add struct request end_io callback

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

pcmcia-dc-initialisation-fix.patch
  pcmcia: ds.c initialisation fix

floppy-add-sysfs-symlink.patch
  floppy.c: add sysfs symlink

base-small-introduce-the-config_base_small-flag.patch
  base-small: introduce the CONFIG_BASE_SMALL flag

base-small-shrink-major_names-hash.patch
  base-small: shrink major_names hash

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

inotify.patch
  inotify

inotify-fix_find_inode.patch
  inotify: fix find_inode

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

crashdump-elf-format-dump-file-access.patch
  crashdump: elf format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear raw format dump file access

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

raid5-overlapping-read-hack.patch
  raid5 overlapping read hack

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

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

scsi-megaraid_mmc-make-some-code-static.patch
  SCSI megaraid_mm.c: make some code static

update-email-address-of-benjamin-lahaise.patch
  Update email address of Benjamin LaHaise

add-map_populate-sys_remap_file_pages-support-to-xfs.patch
  add MAP_POPULATE/sys_remap_file_pages support to XFS

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

acpi-call-acpi_leave_sleep_state-before-resuming-devices.patch
  acpi: call acpi_leave_sleep_state before resuming devices

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

small-partitions-msdos-cleanups.patch
  small partitions/msdos cleanups

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

scsi-sim710c-make-some-code-static.patch
  SCSI sim710.c: make some code static

savagefbc-make-some-code-static.patch
  savagefb.c: make some code static



