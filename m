Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUCPJ4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 04:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUCPJ4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 04:56:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:17077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263806AbUCPJxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 04:53:32 -0500
Date: Tue, 16 Mar 2004 01:53:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc1-mm1
Message-Id: <20040316015338.39e2c48e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/


- A small update, mainly trying to get things stabilised after some
  problems with the disk unplugging and early x86 boot code.  We may still
  have a problem with the latter.

- A PNP subsystem update




Changes since 2.6.4-mm2:


 bk-alsa.patch
 bk-driver-core.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-netdev.patch
 bk-pci.patch
 bk-usb.patch

 External trees

-tty_io-warning-fix.patch
-compat-generic-ipc-emulation.patch
-piix_ide_init-can-be-__init.patch
-pdc202xx_new-update.patch
-ide-cleanups-01.patch
-ide-cleanups-02.patch
-ide-cleanups-03.patch
-sch_htb-fix.patch

 Merged

 kbuild-fix-early-dependencies.patch

 New version

+ppc32-build-fix.patch

 Fix ppc32 build

+s390-page_state-update.patch

 Fix s390 page_state reporting

-ppc-bootloader-build-fix.patch

 trini said this was wrong.

+ppc64-g5-iommu-fix.patch
+ppc64-massive-of-properties-fix.patch

 ppc64 things

-compat-signal-noarch-sparc64-fix.patch

+per-backing_dev-unplugging-BIO_RW_SYNC-fix.patch
+per-backing_dev-unplugging-fix-42.patch
+md-unplugging-fix.patch
+md-unplugging-fix-fix.patch

 Fixes for the per-address_space queue unplugging code.

+early-x86-cpu-detection-fix.patch

 Fix the early-boot crashes with CONFIG_DEBUG_PAGEALLOC, hopefully stabilise
 things a bit.

+empty_zero_page-cleanup.patch

 Stop abusing the empty_zero_page on ia32

+pnp-01-resource-conflict-cleanup.patch
+pnp-02-update-pc-parport-detection.patch
+pnp-03-fix-device-detection.patch
+pnp-04-remove-__init.patch
+pnp-05-mod-inc-dec-removal.patch
+pnp-06-add-ids.patch
+pnp-07-remove-experimental-status.patch
+pnp-08-mem-config-fix.patch

 PNP subsystem udpate

+congestion_wqh-init.patch

 Initialise the congestion waitqueue_heads at compile time.

+more-raw-devices.patch

 Appease reactionary rescidivists.

+iostats-averaging-fix.patch

 Fix disk I/O statistic arithmetic.

+4k-stacks-always-on.patch

 Permanently enable 4k stacks on ia32 (for increased test coverage)

+4g4g-variable-stack-size.patch

 Fix up the 4g/4g patch for other-than-8k stacks.





All 253 patches:


bk-alsa.patch

bk-driver-core.patch

bk-ieee1394.patch

bk-input.patch

bk-netdev.patch

bk-pci.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

kbuild-fix-early-dependencies.patch
  Fix early parallel make failures

scsi_transport_spi-build-fix.patch
  Fix scsi_transport_spi.c for gcc-2.95.3

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

ppc32-build-fix.patch
  ppc32 compile fix

s390-page_state-update.patch
  s390: update for altered page_state structure

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

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

ppc64-g5-iommu-fix.patch
  g5: Fix iommu vs. pci_device_to_OF_node

ppc64-massive-of-properties-fix.patch
  ppc64: fix for massive OF properties

ppc64-reloc_hide.patch

compat-signal-noarch-2004-01-29.patch
  Generic 32-bit compat for copy_siginfo_to_user
  compat-signal sparc64 fix

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

per-backing_dev-unplugging-BIO_RW_SYNC-fix.patch
  per-backing-dev unplugging: fix BIO_RW_SYNC handling

per-backing_dev-unplugging-block_sync_page-fix.patch

per-backing_dev-unplugging-fix-42.patch
  per-backing dev unplugging oops fix #42

md-unplugging-fix.patch
  fix md for per-address_space unplugging

md-unplugging-fix-fix.patch

swapper_space-unplug_fn.patch

shmem-unplug_fn.patch
  more backing_dev unplug functions

HPFS1-hpfs2-RC4-rc1.patch

HPFS2-hpfs_namei-RC4-rc1.patch

queue_work_on_cpu.patch
  Add queue_work_on_cpu() workqueue function

siimage-update.patch
  ide: update for siimage driver

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

early-x86-cpu-detection-fix.patch
  fix early-x86-cpu-detection

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

empty_zero_page-cleanup.patch
  don't abuse empty_zero_page (x86)

pnp-01-resource-conflict-cleanup.patch
  pnp: Resource Conflict Cleanup

pnp-02-update-pc-parport-detection.patch
  pnp: Update PC Parport Detection Code

pnp-03-fix-device-detection.patch
  pnp: Fix ISAPNP Device Detection Issue

pnp-04-remove-__init.patch
  pnp: remove __init from system.c

pnp-05-mod-inc-dec-removal.patch
  pnp: Remove uneeded MOD_INC/DEC_USE_COUNT

pnp-06-add-ids.patch
  pnp: Add a few serial device ids

pnp-07-remove-experimental-status.patch
  pnp: Remove ISAPNP Experimental Status

pnp-08-mem-config-fix.patch
  pnp: ISAPNP MEM Config Fix

congestion_wqh-init.patch
  blk: statically initialise the congestion waitqueue_heads

more-raw-devices.patch
  make config_max_raw_devices work

iostats-averaging-fix.patch
  iostats averaging fix

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

4k-stacks-always-on.patch
  Permanently enable 4k stacks on ia32

4g4g-variable-stack-size.patch
  Fix 4G/4G w/ 8k+ stacks

ppc-fixes.patch
  make mm4 compile on ppc

ppc-fixes-dependency-fix.patch
  ppc-fixes dependency fix



