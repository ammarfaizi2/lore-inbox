Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUCOB25 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 20:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbUCOB25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 20:28:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:55264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262182AbUCOB2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 20:28:05 -0500
Date: Sun, 14 Mar 2004 17:28:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-mm2
Message-Id: <20040314172809.31bd72f7.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm2/


- Added the new per-address_space block unplugging code.  This is designed
  to reduce the locking contention against the global plug list's lock and it
  also allows us to avoid unplugging all the queues in the machine when we
  want just a single queue to kick off its I/O.

- Reiserfs updates: mainly new features.

- Some significant NFS client enhancements: reads smaller than PAGE_SIZE
  are no longer synchronous, support for smaller-than-PAGE_SIZE reads, etc.



Changes since 2.6.4-mm1:


 linus.patch
 bk-driver-core.patch
 bk-i2c.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-netdev.patch
 bk-pci.patch
 bk-pcmcia.patch
 bk-usb.patch

 Latest versions of external trees

-dma_sync_for_device-cpu.patch
-bk-acpi-warning-fix.patch
-x86_64-update.patch
-move-dma_consistent_dma_mask.patch
-move-dma_consistent_dma_mask-x86_64-fix.patch
-move-dma_consistent_dma_mask-sn-fix.patch
-print-kernel-version-in-oops.patch
-ppc64-iseries-virtual-console-fix.patch
-remove-sys_ioperm-stubs.patch
-readdir-cleanups.patch
-sched-stats-64-bit.patch
-nfs-31-attr.patch
-nfs-reconnect-fix.patch
-nfs-mount-fix.patch
-nfs-d_drop-lowmem.patch
-nfs-avoid-i_size_write.patch
-nfs_unlink-oops-fix.patch
-nfs-remove-XID-spinlock.patch
-nfs-misc-rpc-fixes.patch
-nfs-improved-writeback-strategy.patch
-nfs-simplify-config-options.patch
-nfs-fix-msync.patch
-nfs-mount-return-useful-errors.patch
-nfs-misc-minor-fixes.patch
-nfs-lockd-sync-01.patch
-nfs-lockd-sync-02.patch
-nfs-lockd-sync-03.patch
-nfs-lockd-sync-04.patch
-nfs-rpc-remove-redundant-memset.patch
-nfs-tunable-rpc-slot-table.patch
-nfs-short-read-fix.patch
-nfs-server-in-root_server_path.patch
-adaptive-lazy-readahead.patch
-module_exit-deadlock-fix.patch
-ufs2-01.patch
-fb_console_init-fix.patch
-pcmcia-debugging-rework-1.patch
-cs_err-compile-fix.patch
-pcmcia-debugging-rework-2.patch
-distribute-early-allocations-across-nodes.patch
-time-interpolator-fix.patch
-kmsg-nonblock.patch
-remove-__io_virt_debug.patch
-genrtc-cleanups.patch
-i386-early-memory-cleanup.patch
-modular-mce-handler.patch
-remove-more-KERNEL_SYSCALLS.patch
-dm-01-endio-method.patch
-dm-03-list_for_each_entry-audit.patch
-dm-04-default-queue-limits-fix.patch
-dm-05-list-targets-command.patch
-dm-06-stripe-width-fix.patch
-use-wait_task_inactive-in-kthread_bind.patch
-selinux-cleanup-binary-mount-data.patch
-udffs-update.patch
-kbuild-redundant-CFLAGS.patch
-numa-aware-zonelist-builder.patch
-remove-redundant-unplug_timer-deletion.patch
-m68k-rename-sys_functions.patch
-cdromaudio-use-dma.patch
-md-use-schedule_timeout.patch
-md-array-assembly-fix.patch
-md-array-assembly-major-fix.patch
-compiler_h-scope-fixes.patch
-elf-mmap-fix.patch
-kbuild-more-cleaning.patch
-LOOP_CHANGE_FD.patch
-loop-setup-race-fix.patch
-handle-dot-o-paths.patch
-acpi-asmlinkage-fix.patch
-ipc-sem-extra-sem_unlock.patch
-procfs-dangling-subdir-fix.patch
-AMD-768MPX-bootmem-fix.patch
-i810fb-on-x86_64.patch
-ext23-remove-acl-limits.patch
-watchdog-moduleparam-patches.patch
-amd-elan-fix.patch
-fadvise-fixups.patch
-validate_mm-fixes.patch
-3c59x-xcvr-fix.patch
-current_is_keventd-speedup.patch
-root-ramdisk-fix.patch
-cciss-per-device-queues.patch
-blkdev-fix-final-page.patch
-wavfront-needs-syscalls_h.patch
-edd-legacy-parameters-fix.patch
-cciss-section-fix.patch
-pte_chain-nowarns.patch
-macintosh-config-fix.patch
-applicom-warning-fix.patch
-CONFIG_NVRAM-dependencies.patch
-kobject-module-request-64-bit-fix.patch
-instrument-highmem-page-reclaim.patch
-blk_congestion_wait-return-remaining.patch
-blk-congestion-races.patch
-vmscan-remove-priority.patch
-kswapd-throttling-fixes.patch
-vm-refill_inactive-preserve-referenced.patch
-shrink_slab-precision-fix.patch
-try_to_free_pages-shrink_slab-evenness.patch
-vmscan-total_scanned-fix.patch
-shrink_slab-for-all-zones-2.patch
-zone-balancing-fix-2.patch
-vmscan-control-by-nr_to_scan-only.patch
-vmscan-balance-zone-scanning-rates.patch
-vmscan-dont-throttle-if-zero-max_scan.patch
-kswapd-avoid-higher-zones.patch
-kswapd-avoid-higher-zones-reverse-direction.patch
-kswapd-avoid-higher-zones-reverse-direction-fix.patch
-vmscan-throttle-later.patch
-vm-batch-inactive-scanning.patch
-vm-batch-inactive-scanning-fix.patch
-vm-balance-refill-rate.patch
-vm-lrutopage-cleanup.patch
-slab-no-higher-order.patch

 Merged

+kbuild-fix-early-dependencies.patch
+kbuild-fix-early-dependencies-fix.patch

 Parallel build fix

+scsi_transport_spi-build-fix.patch

 Fix for gcc-2.95

+tty_io-warning-fix.patch

 Warning fix

+x86_64-mem_map-shrinkage.patch

 Smaller pageframes on x86_64

+svcauth_gss_accept-warning-fix.patch

 Fix a printk warning for gcc-2.95

+ppc-bootloader-build-fix.patch
+ppc64-irq_stackwarn_reduction.patch
+ppc64-oldumount_fix.patch
+ppc64-remove_Hash.patch
+ppc64-dma-functions.patch
+ppc64-longbusy.patch
+ppc64-veth-use-longbusy.patch
+ppc64-exports.patch
+ppc64-multifunction-fix.patch
+ppc64-eeh_fixes.patch
+ppc64-irq-fixes.patch
+ppc64-vio-dma.patch
+ppc64-iseries-exports.patch
+ppc64-iseries_default.patch
+ppc64-bitops_exports.patch
+ppc64-ide_request_irq.patch
+ppc64-iseries_do_IRQ.patch
+ppc64-remove_pci_dma_exports.patch
+ppc64-rtas_set_power_level.patch
+ppc64-rtas_syscall_fix.patch
+ppc64-add_version_to_oops.patch
+ppc64-procfs-cleanup.patch
+ppc64-xmon_backtrace.patch
+ppc64-hvc-sleep_in_spinlock.patch
+ppc64-defconfig.patch

 PPC64 stuff

+compat-signal-noarch-sparc64-fix.patch

 Fix compat-signal-noarch-2004-01-29.patch for sparc64

+ext3-journalled-quotas-2-exports.patch

 Expert a symbol needed by ext3-journalled-quotas-2.patch

+nfs-01-prepare_nfspage.patch
+nfs-02-small_rsize.patch
+nfs-03-small_wsize.patch
+nfs-04-congestion.patch
+nfs-05-unrace.patch
+nfs-06-rpc_throttle.patch
+nfs-07-rpc_fixes.patch
+nfs-08-short_rw.patch

 NFS update

+sched-remove-unused-local.patch

 Remove dead variable

+ppc64-sched-domain-support.patch

 ppc64 support for the domain-based CPU scheduler

+sched-local-load.patch
+sched-no-cpu-in-rq.patch

 Small cleanups

+lightweight-auditing-framework.patch

 syscall auditing framework (this needs updating but I couldn't be bothered
 re-redoing all the succeeding patches).

+futex_wait-debug-fix.patch

 Fix futex-wait-debug.patch so that it actually does something.

+per-backing_dev-unplugging.patch
+per-backing_dev-unplugging-block_sync_page-fix.patch
+swapper_space-unplug_fn.patch
+shmem-unplug_fn.patch

 Per-address-space block queue unplugging.

+move-job-control-stuff-tosignal_struct-s390-fix.patch
+move-job-control-stuff-tosignal_struct-sx-fix.patch
+move-job-control-stuff-tosignal_struct-sn-fix.patch

 Move job control fields out of task_struct and into signal_struct.

+selinux-conditional-policy-extensions.patch

 SELinux feature work

+devinet-ctl_table-fix.patch

 Doesn't fix an oops - I'll drop this once I work out why we don't need it.

+cm206-check_region-fix.patch
+document-acpi_sleep-option.patch
+document-S3_swsusp-tricks.patch
+sjcd-check_region-fix.patch
+rename-acpi_disable.patch
+filemap-comment-fix.patch
+genhd-comment-fix.patch
+docbook-build-warning.patch
+cdu31c-check_region-fix-2.patch
+move-pcibios-help.patch
+modular-fbdev-fix.patch
+kbuild-modpost-fix.patch

 Minor fixlets.

+fix-kallsyms-in-modules.patch

 Make kallsyms work better when the symbols are in modules.

+ver_linux-binutils-version-fix.patch

 Fix ver_linux's display of the binutils version

+module-aliases-for-char-devices.patch

 More MODULE_ALIASes

+credits-updates.patch

 Update email address

+idr-extra-features.patch

 Extra features in the idr.c code.

+selinux-compute_av-fix.patch

 SELinux fix

+flush_scheduled_work-deadlock-fix.patch
+flush_scheduled_work-recursion-detect.patch

 Permit kevent to call flush_scheduled_work().

+page_referenced-no-mark_page_accessed.patch

 Simplify page_referenced()

+fbdev-char-drawing-enhancement.patch

 fbdev improvement

+sgml-build-fix.patch

 kernel-doc build fix

+reiserfs-direct-tail.patch
+reiserfs-lock-lat.patch
+reiserfs-search-restart.patch
+reiserfs-should-end-jbegin.patch
+reiserfs-write-sched-bug.patch
+reiserfs-aio.patch

 Reiserfs feature work.

+early-x86-cpu-detection.patch

 Detect the x86 cacheline size earlier.

+do_write_mem-retval-check.patch

 Fix return value checking in mem.c

+vsyscall-alignment-fix.patch

 More robust alignment of the vsyscall pages

+smh-do_unmap-comments.patch

 Add a comment explaining why the unchecked do_munmap()s in shm.c are OK.

+shm-do_munmap-check.patch

 Add a check to find out if the above comment is true.

+slab-corruption-detector-fix.patch

 Fix the output of the slab corruption detector.

+kthread-keeps-files-open.patch

 Teach keventd to close /dev/console

+kill-INIT_THREAD_SIZE.patch
+stack-overflow-test-fix.patch
+init-task-alignment-fix.patch

 Fix up some more places where we were assuming 8k stacks on x86

+remap-file-pages-prot-ia64-fix.patch
+remap-file-pages-prot-s390.patch
+remap-file-pages-prot-sparc64.patch

 Implement the new per-page-permissions mode of remap_file_pages() for a few
 architectures.

+slab-alignment-rework.patch
+slab-alignment-rework-merge-fix.patch

 Change slab to utilise the cache line size detection in
 early-x86-cpu-detection.patch, thus saving some memory.






All 243 patches:


linus.patch

bk-driver-core.patch

bk-i2c.patch

bk-ieee1394.patch

bk-input.patch

bk-netdev.patch

bk-pci.patch

bk-pcmcia.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

kbuild-fix-early-dependencies.patch
  Fix early parallel make failures

kbuild-fix-early-dependencies-fix.patch

scsi_transport_spi-build-fix.patch
  Fix scsi_transport_spi.c for gcc-2.95.3

tty_io-warning-fix.patch

x86_64-mem_map-shrinkage.patch
  Save some memory in mem_map on x86-64

svcauth_gss_accept-warning-fix.patch
  svcauth_gss_accept() printk warning fix

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdb-ga-recent-gcc-fix.patch
  kgdb: fix for recent gcc

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

kgdb-THREAD_SIZE-fixes.patch
  THREAD_SIZE fixes for kgdb

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc-bootloader-build-fix.patch
  ppc32: fix bootloader build when DEBUG is defined

ppc64-irq_stackwarn_reduction.patch
  Reduce stack overflow check to 4096 bytes

ppc64-oldumount_fix.patch
  Remove bogus sys_oldumount sign extension code

ppc64-remove_Hash.patch
  Remove some unused ppc64 variables

ppc64-dma-functions.patch
  Make dma API handle PCI and VIO

ppc64-longbusy.patch
  Add hypervisor busy return codes

ppc64-veth-use-longbusy.patch
  Handle longbusy return codes in IBM VETH driver

ppc64-exports.patch
  Add some missing EXPORT_SYMBOLs

ppc64-multifunction-fix.patch
  Fix for hotplug of multifunction cards.

ppc64-eeh_fixes.patch
  Fix multiple EEH-related bugs

ppc64-irq-fixes.patch
  Fix xics IRQ affinity

ppc64-vio-dma.patch
  Add some functions to make vio.h consistant with pci_dma.h and dma_mapping.h

ppc64-iseries-exports.patch
  Move iSeries specific EXPORT_SYMBOLs out of ppc_ksyms.c

ppc64-iseries_default.patch
  update iseries default target

ppc64-bitops_exports.patch
  Export find_next_bit

ppc64-ide_request_irq.patch
  Add slow path lookup in xics_get_irq

ppc64-iseries_do_IRQ.patch
  Dont enable interrupts during interrupt processing on iseries

ppc64-remove_pci_dma_exports.patch
  Remove pci DMA exports

ppc64-rtas_set_power_level.patch
  Added rtas_set_power_level()

ppc64-rtas_syscall_fix.patch
  Fixed NULL ptr deref in RTAS syscall ppc_rtas()

ppc64-add_version_to_oops.patch
  Add kernel version to oops.

ppc64-procfs-cleanup.patch
  Cleanup ppc64 procfs code

ppc64-xmon_backtrace.patch
  Clean up xmon backtrace code.

ppc64-hvc-sleep_in_spinlock.patch
  Fix hvc console sleep in spinlock bug

ppc64-defconfig.patch
  ppc64 defconfig update

ppc64-reloc_hide.patch

compat-signal-noarch-2004-01-29.patch
  Generic 32-bit compat for copy_siginfo_to_user

compat-signal-noarch-sparc64-fix.patch
  compat-signal sparc64 fix

compat-generic-ipc-emulation.patch
  generic 32 bit emulation for System-V IPC

ext3-journalled-quotas-2.patch
  ext3: journalled quota

ext3-journalled-quotas-2-exports.patch
  export needed symbols for new quota code

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

CONFIG_SYSFS.patch
  From: Pat Mochel <mochel@osdl.org>
  Subject: [PATCH] Add CONFIG_SYSFS

CONFIG_SYSFS-boot-from-disk-fix.patch

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

nfs-01-prepare_nfspage.patch
  Subject: [PATCH] Prepare NFS asynchronous read/write structures for 	rsize/wsize < PAGE_SIZE

nfs-02-small_rsize.patch
  Subject: [PATCH] Add asynchronous read support for rsize<PAGE_SIZE

nfs-03-small_wsize.patch
  Subject: [PATCH] Add asynchronous write support for wsize<PAGE_SIZE

nfs-04-congestion.patch
  Subject: [PATCH] Throttle writes when memory pressure forces a flush

nfs-05-unrace.patch
  Subject: [PATCH] Remove a couple of races in RPC layer...

nfs-06-rpc_throttle.patch
  Subject: [PATCH] add fair queueing to the RPC scheduler.

nfs-07-rpc_fixes.patch
  Subject: [PATCH] Close some potential scheduler races in rpciod.

nfs-08-short_rw.patch
  Subject: [PATCH] Add support for short reads/writes (< rsize/wsize)

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

sched-remove-unused-local.patch
  sched: remove unused field

sched-domains-improvements.patch
  sched domains kernbench improvements

sched-clock-fixes.patch
  fix sched_clock()

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask
  p4-clockmod sibling_map fix
  p4-clockmod: handle more than two siblings

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT
  sched: Fix CONFIG_SMT oops on UP
  sched: fix SMT + NUMA bug
  Change arch_init_sched_domains to use cpu_online_map
  Fix build with NR_CPUS > BITS_PER_LONG

sched-domain-tweak.patch
  i386-sched-domain code consolidation

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-domain-debugging.patch
  sched_domain debugging

sched-domain-balancing-improvements.patch
  scheduler domain balancing improvements

sched-group-power.patch
  sched-group-power
  sched-group-power warning fixes

sched-domains-use-cpu_possible_map.patch
  sched_domains: use cpu_possible_map

sched-smt-nice-handling.patch
  sched: SMT niceness handling

sched-smt-nice-optimisation.patch
  sched: SMT-ice optimisation

ppc64-sched-domain-support.patch
  ppc64: sched-domain support

sched-local-load.patch
  sched: add local load metrics

sched-no-cpu-in-rq.patch
  sched: remove cpu field gtom runqueue

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

laptop-mode-2.patch
  laptop-mode for 2.6, version 6
  Documentation/laptop-mode.txt
  laptop-mode documentation updates
  Laptop mode documentation addition
  laptop mode simplification

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

drm-include-fix.patch

process-migration-speedup.patch
  Reduce TLB flushing during process migration

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

initramfs-search-for-init.patch
  search for /init for initramfs boots

sysfs_remove_dir-race-fix.patch
  sysfs_remove_dir-vs-dcache_readdir race fix

sysfs_remove_subdir-dentry-leak-fix.patch
  Fix dentry refcounting in sysfs_remove_group()

lightweight-auditing-framework.patch
  Light-weight Auditing Framework

per-node-rss-tracking.patch
  Track per-node RSS for NUMA

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

futex_wait-debug.patch
  futex_wait debug

futex_wait-debug-fix.patch

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

ide-scsi-error-handling-fixes.patch
  ide-scsi error handling fixes

ide-scsi-error-handling-update.patch
  ide-scsi error handler update

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

mixart-build-fix.patch
  CONFIG_SND_MIXART doesn't compile

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

piix_ide_init-can-be-__init.patch
  piix_ide_init can be __init

mq-01-codemove.patch
  posix message queues: code move

mq-02-syscalls.patch
  posix message queues: syscall stubs

mq-03-core.patch
  posix message queues: implementation

mq-03-core-update.patch
  posix message queues: update to core patch

mq-04-linuxext-poll.patch
  posix message queues: linux-specific poll extension

mq-05-linuxext-mount.patch
  posix message queues: made user mountable

mq-update-01.patch
  posix message queue update

mq-security-fix.patch
  security bugfix for mqueue

queue-congestion-callout.patch
  Add queue congestion callout

queue-congestion-dm-implementation.patch
  Implement queue congestion callout for device mapper

dm-maplock.patch
  devicemapper: use rwlock for map alterations

dm-map-rwlock-ng.patch
  Another DM maplock implementation

dm-remove-__dm_request.patch
  dmL remove __dm_request

per-backing_dev-unplugging.patch
  per-backing dev unplugging

per-backing_dev-unplugging-block_sync_page-fix.patch

swapper_space-unplug_fn.patch

shmem-unplug_fn.patch
  more backing_dev unplug functions

HPFS1-hpfs2-RC4-rc1.patch

HPFS2-hpfs_namei-RC4-rc1.patch

queue_work_on_cpu.patch
  Add queue_work_on_cpu() workqueue function

pdc202xx_new-update.patch
  ide: update for pdc202xx_new driver

siimage-update.patch
  ide: update for siimage driver

ide-cleanups-01.patch
  ide: IDE cleanups

ide-cleanups-02.patch
  ide: IDE cleanups

ide-cleanups-03.patch
  ide: IDE cleanups

sysfs-pin-kobject.patch
  sysfs: pin kobjects to fix use-after-free crashes

ATI-IXP-IDE-support.patch
  ATI IXP IDE support

ipmi-updates-3.patch
  IPMI driver updates

ipmi-socket-interface.patch
  IPMI: socket interface

nmi_watchdog-local-apic-fix.patch
  Fix nmi_watchdog=2 and P4 HT

nmi-1-hz.patch
  set nmi_hz to 1 with nmi_watchdog=2 and SMP

pcmcia-netdev-ordering-fixes.patch
  PCMCIA netdevice ordering issues

3ware-update.patch
  3ware driver update

move-job-control-stuff-tosignal_struct.patch
  moef job control fields from task_struct to signal_struct

move-job-control-stuff-tosignal_struct-s390-fix.patch
  s390 fix for move-job-control-stuff-tosignal_struct.patch

move-job-control-stuff-tosignal_struct-sx-fix.patch

move-job-control-stuff-tosignal_struct-sn-fix.patch
  From: John Hawkes <hawkes@babylon.engr.sgi.com>
  Subject: [PATCH] 2.6.4-mm1 for ia64

module_h-attribute_used-fix.patch
  module.h __attribute_used__ fix

sch_htb-fix.patch
  net: fix sch_htb on 64-bit

selinux-conditional-policy-extensions.patch
  selinux: Conditional policy extension and MLS detection support

devinet-ctl_table-fix.patch
  devinet_ctl_table[] null termination

cm206-check_region-fix.patch
  drivers_cdrom_cm206.c check_region() fix

document-acpi_sleep-option.patch
  ACPI: document acpi_sleep option

document-S3_swsusp-tricks.patch
  Document tricks to get S3_swsusp working

sjcd-check_region-fix.patch
  drivers_cdrom_sjcd.c check_region() fix

rename-acpi_disable.patch
  rename one of the acpi_disable() instances

filemap-comment-fix.patch
  filemap.c comment fix

fix-kallsyms-in-modules.patch
  fix for kallsyms module symbol resolution problem

ver_linux-binutils-version-fix.patch
  Fix scripts/ver_linux

module-aliases-for-char-devices.patch
  chardev module aliases

credits-updates.patch
  minor credits updates

genhd-comment-fix.patch
  Fix comment in drivers/block/genhd.c

docbook-build-warning.patch
  add warning to DocBook/Makefile

cdu31c-check_region-fix-2.patch
  drivers_cdrom_cdu31c.c check_region() fix

move-pcibios-help.patch
  move PCIBIOS access help text

modular-fbdev-fix.patch
  fix modular fb drivers

kbuild-modpost-fix.patch
  kbuild: fix modpost when used with O=

idr-extra-features.patch
  idr.c: extra features enhancements

selinux-compute_av-fix.patch
  selinux: fix compute_av bug

flush_scheduled_work-deadlock-fix.patch
  flush_scheduled_work() deadlock fix

flush_scheduled_work-recursion-detect.patch
  flush_workqueue(): detect excessive nesting

page_referenced-no-mark_page_accessed.patch
  page_referenced() simplification

fbdev-char-drawing-enhancement.patch
  fbdev: character drawing enhancement.

sgml-build-fix.patch
  kernel-doc build fix

reiserfs-direct-tail.patch
  reiserfs: fix null pointer deref

reiserfs-lock-lat.patch
  resierfs: scheduling latency improvements

reiserfs-search-restart.patch
  reiserfs: search_by_key fix

reiserfs-should-end-jbegin.patch
  reiserfs: fix transaction sizes

reiserfs-write-sched-bug.patch
  reiserfs: atomicity fix

reiserfs-aio.patch
  resierfs: AIO support

early-x86-cpu-detection.patch
  Add early CPU detection to i386, export cache_line_size()

do_write_mem-retval-check.patch
  do_write_mem() return value check

vsyscall-alignment-fix.patch
  x86 vsyscall alignment fix

smh-do_unmap-comments.patch
  document unchecked do_munmaps in ipc/shm.c

shm-do_munmap-check.patch

slab-corruption-detector-fix.patch
  slab: fix display of object length in corruption detector

kthread-keeps-files-open.patch
  kthreads hold files open

kill-INIT_THREAD_SIZE.patch
  kill INIT_THREAD_SIZE

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

init-task-alignment-fix.patch
  proper alignment of init task in kernel image

O_DIRECT-race-fixes-rollup.patch
  O_DIRECT data exposure fixes

O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
  Fix race between ll_rw_block() and block_write_full_page()

blockdev-direct-io-speedup.patch
  blockdev direct-io speedups

dio-aio-fixes.patch
  direct-io AIO fixes

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix

aio-direct-io-oops-fix.patch
  AIO/direct-io oops fix

radix-tree-tagging.patch
  radix-tree tags for selective lookup

irq-safe-pagecache-lock.patch
  make the pagecache lock irq-safe.

tag-dirty-pages.patch
  tag dirty pages as such in the radix tree

tag-writeback-pages.patch
  tag writeback pages as such in their radix tree

stop-using-dirty-pages.patch
  stop using the address_space dirty_pages list

stop-using-io-pages.patch
  remove address_space.io_pages

stop-using-locked-pages.patch
  Stop using address_space.locked_pages

stop-using-clean-pages.patch
  stop using address_space.clean_pages

unslabify-pgds-and-pmds.patch
  revert the slabification of i386 pgd's and pmd's

slab-stop-using-page-list.patch
  slab: stop using page.list

page_alloc-stop-using-page-list.patch
  stop using page.list in the page allocator

hugetlb-stop-using-page-list.patch
  stop using page->list in the hugetlbpage implementations

pageattr-stop-using-page-list.patch
  stop using page.list in pageattr.c

readahead-stop-using-page-list.patch
  stop using page.list in readahead

compound-pages-stop-using-lru.patch
  stop using page->lru in compound pages

remove-page-list.patch
  remove page.list

remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch
  per-page protections for remap_file_pages()

remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch
  remap_file_pages page-prot implementation for ia64

remap-file-pages-prot-ia64-fix.patch
  From: John Hawkes <hawkes@babylon.engr.sgi.com>
  Subject: [PATCH] 2.6.4-mm1 for ia64

remap-file-pages-prot-s390.patch
  s390: remap-file-pages-prot support

remap-file-pages-prot-sparc64.patch
  remap-file-pages-prot: sparc64 support

slab-alignment-rework.patch
  slab: updates for per-arch alignments

slab-alignment-rework-merge-fix.patch
  slab-alignment-rework merge fix

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter

lockmeter-ia64-fix.patch
  ia64 CONFIG_LOCKMETER fix

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
  4G/4G might_sleep warning fix
  4g/4g pagetable accounting fix
  Fix 4G/4G and WP test lockup
  4G/4G KERNEL_DS usercopy again
  Fix 4G/4G X11/vm86 oops
  Fix 4G/4G athlon triplefault
  4g4g SEP fix
  Fix 4G/4G split fix for pre-pentiumII machines
  4g/4g PAE ACPI low mappings fix
  zap_low_mappings() cannot be __init
  4g/4g: remove printk at boot
  4g4g: fix handle_BUG()
  4g4g: acpi sleep fixes

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

ia32-4k-stacks.patch
  ia32: 4Kb stacks (and irqstacks) patch

ia32-4k-stacks-build-fix.patch
  4k stacks build fix

4k-stacks-in-modversions-magic.patch
  Add 4k stacks to module version magic

ppc-fixes.patch
  make mm4 compile on ppc

ppc-fixes-dependency-fix.patch
  ppc-fixes dependency fix



