Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUCCEOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbUCCEOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:14:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:55009 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262347AbUCCEOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:14:04 -0500
Date: Tue, 2 Mar 2004 20:15:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc1-mm2
Message-Id: <20040302201536.52c4e467.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/

- More VM tweaks and tuneups

- Added a 4k kernel- and irq-stack option for x86

- Largeish NFS client update




Changes since 2.6.4-rc1-mm1:


 linus.patch
 bk-acpi.patch
 bk-alsa.patch
 bk-driver-core.patch
 bk-input.patch
 bk-netdev.patch
 bk-pci.patch
 bk-scsi.patch
 bk-usb.patch

 Latest versions of external bug^Wtrees

-umount-dataloss-fix.patch
-ppc64-iseries-mmu-hashtable-fix.patch
-ppc64-export-numa-symbols.patch
-ppc64-cpu_vm_mask-fix.patch
-doc-index-updates.patch
-poweroff-atomicity-fix.patch
-bio-highmem-fix.patch
-ini9100u-build-fix.patch
-move-scatterwalk-functions-to-own-file.patch
-in-place-encryption-fix.patch
-dm-crypt-cleanups.patch
-dm-crypt-end_io-bv_offset-fix.patch
-proc-thread-visibility-revert.patch
-zr36067-update.patch
-keyspan-c99-fixes.patch
-hisax-c99-fixes.patch
-raid1-bio_put-oops-fix.patch
-README-update.patch
-DCSSBLK-depends-on-s390.patch
-xprt_create_socket-fix.patch
-tty-drivers-devfs-fix.patch
-vt-mode-changes-fix.patch
-sys_alarm-retval-fix.patch
-gcc-35-lec-fix.patch
-ip_rt_init-sizing-fix.patch
-buslogic-sections-fix.patch
-remove-make-dep-references.patch
-use-set_task_cpu-in-kthread_bind.patch
-tcp-oops-fix.patch
-swap-config-clarity.patch
-powernow-k8-fix.patch
-x86_64-update.patch
-libata-fix.patch
-usb-pc-watchdog-implementation.patch
-pdflush-use-kthread.patch
-firmware-pin-module.patch
-firmware-delay-hotplug.patch

 Merged

+fastcall-warning-fixes-2.patch

 Fix up fastcall-warning-fixes.patch

+ppc64-xmon-survival-fix.patch

 ppc64 debugger fix

+put_compat_timespec-prototype-fix.patch

 Fix a warning

+sparc-sys_ioperm-fix.patch

 Fix sparc build breakage

-sched-group-power-warning-fixes.patch

 Folded into sched-group-power.patch

+sched-smt-nice-handling.patch

 Improve the CPU scheduler's balancing of differently-niced tasks between
 siblings.

+nfs-improved-writeback-strategy.patch
+nfs-simplify-config-options.patch
+nfs-fix-msync.patch
+nfs-mount-return-useful-errors.patch
+nfs-misc-minor-fixes.patch
+nfs-lockd-sync-01.patch
+nfs-lockd-sync-02.patch
+nfs-lockd-sync-03.patch
+nfs-lockd-sync-04.patch
+nfs-rpc-remove-redundant-memset.patch
+nfs-tunable-rpc-slot-table.patch
+nfs-short-read-fix.patch

 NFS updates

-sleep_on-needs_lock_kernel.patch

 This broke, and seems to have served its purpose.

-apic-apic-setup-buggy.patch
-mmconfig.patch
-sal-support.patch
-expanded-pci-config-space-core.patch

 Still under development in various other trees.

+mq-update-01.patch

 Small fixes to the posix message queue code

+use-wait_task_inactive-in-kthread_bind.patch

 kthread synchronisation fix

+HPFS10-fix-RC4-rc1.patch

 Another HPFS fixup

+selinux-cleanup-binary-mount-data.patch

 Make SELinux handle binary mount data more nicely.

+udffs-update.patch

 Update to the UDF filesystem

+kbuild-redundant-CFLAGS.patch

 kbuild cleanup

+numa-aware-zonelist-builder.patch

 Optimise the memory zonelists layout for NUMA

+remove-redundant-unplug_timer-deletion.patch

 Kill unneeded del_timer()

+alpha-switch-semaphores.patch

 Reimplement alpha semaphores

+serial_core-build-fix.patch

 Compile fix

+blk-unplug-when-max-request-queued.patch

 auto-unplug a disk queue when it has assembled a full-sized request

+queue_work_on_cpu.patch

 Add queue_work_on_cpu() to the workqueue API.

+sb16-sample-size-fix.patch

 sb16 driver fix

+ext2-ext3-ENOSPC-fix.patch

 Fix bogus ENOSPC in ext3 and ext3 when using the `oldalloc' mount option.

+missing-MODULE_LICENSEs.patch

 Add some GPL tags

+v4l1-compatibility-module-fix.patch

 v4l fix

+i2o-fixes.patch

 i2o driver fixes

+m68k-rename-sys_functions.patch

 m68k sys_* namespace cleanup

+pdc_202xx_old-update.patch
+pdc202xx_new-update.patch
+siimage-update.patch
+ide-cleanups-01.patch
+ide-cleanups-02.patch
+ide-cleanups-03.patch

 IDE updates

+kswapd-avoid-higher-zones-reverse-direction.patch
+kswapd-avoid-higher-zones-reverse-direction-fix.patch
+vm-batch-inactive-scanning.patch
+vm-batch-inactive-scanning-fix.patch
+vm-balance-refill-rate.patch
+shrink-inode-cache-harder.patch

 More memory reclaim work

-ia64-lockmeter-fix.patch
-lockmeter-2.2-cruft.patch

 Folded into lockmeter.patch

+lockmeter-ia64-fix.patch

 Fix lockmeter on ia64

+ia32-4k-stacks.patch
+ia32-4k-stacks-build-fix.patch
+4k-stacks-in-modversions-magic.patch

 4k stacks for x86




All 245 patches:


linus.patch

bk-acpi.patch

bk-alsa.patch

bk-driver-core.patch

bk-input.patch

bk-netdev.patch

bk-pci.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

dma_sync_for_device-cpu.patch
  dma_sync_for_{cpu,device}()

move-dma_consistent_dma_mask.patch
  move consistent_dma_mask to the generic device

move-dma_consistent_dma_mask-x86_64-fix.patch

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

fastcall-warning-fixes.patch
  fastcall / regparm fixes

fastcall-warning-fixes-2.patch
  more fastcall fixes

ppc64-xmon-survival-fix.patch
  ppc64: Make xmon survive exit after soft reset

ppc64-reloc_hide.patch

put_compat_timespec-prototype-fix.patch
  fix put_compat_timespec prototype

compat-signal-noarch-2004-01-29.patch
  Generic 32-bit compat for copy_siginfo_to_user

compat-generic-ipc-emulation.patch
  generic 32 bit emulation for System-V IPC

sparc-sys_ioperm-fix.patch
  sparc: fix sys_ioperm

remove-sys_ioperm-stubs.patch
  Clean up sys_ioperm stubs

readdir-cleanups.patch
  readdir() cleanups

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

support-zillions-of-scsi-disks.patch
  support many SCSI disks

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

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

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

hotplugcpu-generalise-bogolock.patch
  Atomic Hotplug CPU: Generalize Bogolock

hotplugcpu-generalise-bogolock-fix-for-kthread-stop-using-signals.patch

hotplugcpu-use-bogolock-in-modules.patch
  Atomic Hotplug CPU: Use Bogolock in module.c

hotplugcpu-core.patch
  Atomic Hotplug CPU: Hotplug CPU Core

stop_machine-warning-fix.patch

hotplugcpu-core-sparc64-build-fix.patch
  hotplugcpu-core sparc64 build fix

hotplugcpu-core-fix-for-kthread-stop-using-signals.patch

migrate_to_cpu-dependency-fix.patch
  migrate_to_cpu() dependency fix

hotplugcpu-core-drain_local_pages-fix.patch
  split drain_local_pages

hotplugcpu-rcupdate-many-cpus-fix.patch
  CPU hotplug, rcupdate high NR_CPUS fix

nfs-31-attr.patch
  NFSv2/v3/v4: New attribute revalidation code

nfs-reconnect-fix.patch

nfs-mount-fix.patch
  Update to NFS mount....

nfs-d_drop-lowmem.patch
  NFS: handle nfs_fhget() error

nfs-avoid-i_size_write.patch
  NFS: avoid unlocked i_size_write()

nfs_unlink-oops-fix.patch
  nfs: fix "busy inodes after umount"

nfs-remove-XID-spinlock.patch
  nfs: Remove an unnecessary spinlock from XID generation...

nfs-misc-rpc-fixes.patch
  nfs: Misc RPC fixes...

nfs-improved-writeback-strategy.patch
  nfs: improve writeback caching

nfs-simplify-config-options.patch
  nfs: simplify client configuration options.

nfs-fix-msync.patch
  nfs: fix msync()

nfs-mount-return-useful-errors.patch
  nfs: make mount command return more useful errors

nfs-misc-minor-fixes.patch
  nfs: misc minor fixes

nfs-lockd-sync-01.patch
  nfs: sync lockd to 2.4.x

nfs-lockd-sync-02.patch
  nfs: sync lockd to 2.4.x

nfs-lockd-sync-03.patch
  nfs: sync lockd to 2.4.x

nfs-lockd-sync-04.patch
  nfs: sync lockd to 2.4.x

nfs-rpc-remove-redundant-memset.patch
  nfs: remove unnecessary memset() in RPC

nfs-tunable-rpc-slot-table.patch
  nfs: make the RPC slot table size a tunable value.

nfs-short-read-fix.patch
  nfs: fix an NFSv2 read bug

nfs-server-in-root_server_path.patch
  Pull NFS server address out of root_server_path

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

initramfs-search-for-init.patch
  search for /init for initramfs boots

centaur-crypto-core-support.patch
  First steps toward VIA crypto support

adaptive-lazy-readahead.patch
  adaptive lazy readahead

ext3-journalled-quotas.patch
  ext3: Journalled quotas

ext3-journalled-quotas-warning-fix.patch

ext3-journalled-quotas-cleanups.patch

sysfs_remove_dir-race-fix.patch
  sysfs_remove_dir-vs-dcache_readdir race fix

sysfs_remove_subdir-dentry-leak-fix.patch
  Fix dentry refcounting in sysfs_remove_group()

per-node-rss-tracking.patch
  Track per-node RSS for NUMA

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

futex_wait-debug.patch
  futex_wait debug

module_exit-deadlock-fix.patch
  module unload deadlock fix

tulip-printk-cleanup.patch
  tulip printk cleanup

parport-01-move-exports.patch
  parport: move exports

parport-02-use-module_init.patch
  parport: use module_init() for low-level driver init

parport-03-sysctls-use-module_init.patch
  parport: use module_init() for sysctl registration

parport-04-move-option-parsing.patch
  parport: move parport_pc option parsing

parport-irq-warning-fix.patch
  parport warning fixes

parport-05-parport_pc_probe_port-fixes.patch
  parport: sanitize parport_pc_probe_port()

parport-06-refcounting-fixes.patch
  parport: refcounting fixes

parport-07-unregister-fixes.patch
  parport: parport_unregister_port() splitups abd fixes

parport-08-parport_announce-cleanups.patch
  parport: parport_announce_port() cleanup

parport-09-track-used-ports.patch
  parport: parport_pc(): keep track of ports

parport-09-track-used-ports-fix.patch

parport-10-sunbpp-track-ports.patch
  parport: parport_sunbpp(): keep track of ports

parport-11-remove-parport_enumerate.patch
  parport: remove parport_enumerate()

parport-12-driver-list-cleanup.patch
  parport: use list.h for driver list

hitachi-scsi_devinfo-fix.patch
  Add Hitachi 9960 Storage on SCSI devlist as BLIST_SPARSELUN|BLIST_LARGELUN

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

ext3-dirty-debug-patch.patch
  ext3 debug patch

ufs2-01.patch
  read-only support for UFS2

ide-scsi-error-handling-fixes.patch
  ide-scsi error handling fixes

fb_console_init-fix.patch
  fb_console_init fix

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

zwane-is-floppy-maintainer-now.patch
  floppy oops fix(?)

pcmcia-debugging-rework-1.patch
  Overhaul PCMCIA debugging (1)

cs_err-compile-fix.patch
  pcmcia: workaround for gcc-2.95 bug in cs_err()

pcmcia-debugging-rework-2.patch
  Overhaul PCMCIA debugging (2)

distribute-early-allocations-across-nodes.patch
  Manfred's patch to distribute boot allocations across nodes

time-interpolator-fix.patch
  time interpolator fix

kmsg-nonblock.patch
  teach /proc/kmsg about O_NONBLOCK

mixart-build-fix.patch
  CONFIG_SND_MIXART doesn't compile

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

remove-__io_virt_debug.patch
  remove __io_virt_debug

rioctrl-retval-fixes.patch
  char/rio/rioctrl: fix ioctl return values

genrtc-cleanups.patch
  genrtc: cleanups

piix_ide_init-can-be-__init.patch
  piix_ide_init can be __init

fusion-use-min-max.patch
  message/fusion: use kernel min/max

doc2000-warning-fixes.patch
  mtd/doc200x: warning fixes

initrd-kconfig-dependencies.patch
  Fix initrd Kconfig dependencies

queue-congestion-callout.patch
  Add queue congestion callout

queue-congestion-dm-implementation.patch
  Implement queue congestion callout for device mapper

scsi-host-allocation-fix.patch
  SCSI host num allocation improvement

i386-early-memory-cleanup.patch
  i386 very early memory detection cleanup patch

modular-mce-handler.patch
  Allow X86_MCE_NONFATAL to be a module

LOOP_CHANGE_FD.patch
  LOOP_CHANGE_FD ioctl

cs46_xx-c99-fix.patch
  c99 initializers for cs46xx_wrapper

remove-more-KERNEL_SYSCALLS.patch
  further __KERNEL_SYSCALLS__ removal

remove-more-KERNEL_SYSCALLS-build-fix.patch
  build fix for remove-more-KERNEL_SYSCALLS.patch

remove-more-KERNEL_SYSCALLS-build-fix-2.patch
  fix the build for remove-more-KERNEL_SYSCALLS

remove-nlmclnt_grace_wait.patch
  kill a dead function in lockd

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

use-wait_task_inactive-in-kthread_bind.patch
  use wait_task_inactive() in kthread_bind()

HPFS1-hpfs2-RC4-rc1.patch

HPFS2-hpfs_namei-RC4-rc1.patch

HPFS3-hpfs_iget-RC4-rc1.patch

HPFS4-hpfs_lock_iget-RC4-rc1.patch

HPFS5-hpfs_locking-RC4-rc1.patch

HPFS6-hpfs_cleanup-RC4-rc1.patch

HPFS7-hpfs_cleanup2-RC4-rc1.patch

HPFS8-hpfs_race2-RC4-rc1.patch

HPFS9-hpfs_deadlock-RC4-rc1.patch

HPFS10-fix-RC4-rc1.patch

selinux-cleanup-binary-mount-data.patch
  selinux: clean up binary mount data

udffs-update.patch
  UDF filesystem update

kbuild-redundant-CFLAGS.patch
  kbuild: Remove CFLAGS assignment in i386/mach-*/Makefile

numa-aware-zonelist-builder.patch
  NUMA-aware zonelist builder

remove-redundant-unplug_timer-deletion.patch
  Redundant unplug_timer deletion

alpha-switch-semaphores.patch
  Alpha: switch semaphores to PPC scheme

serial_core-build-fix.patch
  serial_core.h needs sched.h

blk-unplug-when-max-request-queued.patch
  block: unplug the queue when a single full-sized request is ready

queue_work_on_cpu.patch
  Add queue_work_on_cpu() workqueue function

sb16-sample-size-fix.patch
  sb16 sample size fix

ext2-ext3-ENOSPC-fix.patch
  ext2/ext3 -ENOSPC bug

missing-MODULE_LICENSEs.patch
  add missing MODULE_LICENSEs

v4l1-compatibility-module-fix.patch
  v4l1 compatibility module fix.

i2o-fixes.patch
  i2o subsystem minor bugfixes

m68k-rename-sys_functions.patch
  m68k: rename sys_* functions

pdc_202xx_old-update.patch
  ide: small update for pdc202xx_old driver

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

instrument-highmem-page-reclaim.patch
  vm: per-zone vmscan instrumentation

blk_congestion_wait-return-remaining.patch
  return remaining jiffies from blk_congestion_wait()

vmscan-remove-priority.patch
  mm/vmscan.c: remove unused priority argument.

kswapd-throttling-fixes.patch
  kswapd throttling fixes

vm-refill_inactive-preserve-referenced.patch
  vmscan: preserve page referenced info in refill_inactive()

shrink_slab-precision-fix.patch
  shrink_slab: math precision fix

try_to_free_pages-shrink_slab-evenness.patch
  vm: shrink slab evenly in try_to_free_pages()

vmscan-total_scanned-fix.patch
  vmscan: fix calculation of number of pages scanned

shrink_slab-for-all-zones-2.patch
  vm: scan slab in response to highmem scanning

zone-balancing-fix-2.patch
  vmscan: zone balancing fix

vmscan-control-by-nr_to_scan-only.patch
  vmscan: drive everything via nr_to_scan

vmscan-balance-zone-scanning-rates.patch
  Balance inter-zone scan rates

vmscan-dont-throttle-if-zero-max_scan.patch
  vmscan: avoid bogus throttling

kswapd-avoid-higher-zones.patch
  kswapd: avoid unnecessary reclaiming from higher zones

kswapd-avoid-higher-zones-reverse-direction.patch
  kswapd: fix lumpy page reclaim

kswapd-avoid-higher-zones-reverse-direction-fix.patch
  fix the kswapd zone scanning algorithm

vmscan-throttle-later.patch
  vmscan: less throttling of page allocators and kswapd

vm-batch-inactive-scanning.patch
  vmscan: batch up inactive list scanning work

vm-batch-inactive-scanning-fix.patch
  fix vm-batch-inactive-scanning.patch

vm-balance-refill-rate.patch
  vm: balance inactive zone refill rates

shrink-inode-cache-harder.patch
  vm: shrink icache harder

slab-no-higher-order.patch
  slab: avoid higher-order allocations

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

4g4g-THREAD_SIZE-fixes.patch

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

O_DIRECT-race-fixes-rollup.patch
  O_DIRECT data exposure fixes

O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
  Fix race between ll_rw_block() and block_write_full_page()

blockdev-direct-io-speedup.patch
  blockdev direct-io speedups

O_DIRECT-vs-buffered-fix.patch
  Fix O_DIRECT-vs-buffered data exposure bug

O_DIRECT-vs-buffered-fix-pdflush-hang-fix.patch
  pdflush hang fix

serialise-writeback-fdatawait.patch
  serialize_writeback_fdatawait patch

dio-aio-fixes.patch
  direct-io AIO fixes

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix



