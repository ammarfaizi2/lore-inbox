Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUCREPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 23:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbUCREPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 23:15:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:25255 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262322AbUCREOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 23:14:48 -0500
Date: Wed, 17 Mar 2004 20:14:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc1-mm2
Message-Id: <20040317201454.5b2e8a3c.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm2/

- Dropped the early-x86-cpu-detection patches, as these appear to be the
  source of recent early-crash problems.

- Several fixes against the new writeback code.

- Several fixes against the new block unplugging code.




Changes since 2.6.5-rc1-mm1:


 linus.patch
 bk-acpi.patch
 bk-alsa.patch
 bk-ieee1394.patch
 bk-netdev.patch
 bk-pci.patch
 bk-scsi.patch

 Latest versions of various trees

-kbuild-fix-early-dependencies.patch
-x86_64-mem_map-shrinkage.patch
-svcauth_gss_accept-warning-fix.patch
-ppc32-build-fix.patch
-s390-page_state-update.patch
-ppc64-irq_stackwarn_reduction.patch
-ppc64-oldumount_fix.patch
-ppc64-remove_Hash.patch
-ppc64-dma-functions.patch
-ppc64-longbusy.patch
-ppc64-veth-use-longbusy.patch
-ppc64-exports.patch
-ppc64-multifunction-fix.patch
-ppc64-eeh_fixes.patch
-ppc64-irq-fixes.patch
-ppc64-vio-dma.patch
-ppc64-iseries-exports.patch
-ppc64-iseries_default.patch
-ppc64-bitops_exports.patch
-ppc64-ide_request_irq.patch
-ppc64-iseries_do_IRQ.patch
-ppc64-remove_pci_dma_exports.patch
-ppc64-rtas_set_power_level.patch
-ppc64-rtas_syscall_fix.patch
-ppc64-add_version_to_oops.patch
-ppc64-procfs-cleanup.patch
-ppc64-xmon_backtrace.patch
-ppc64-hvc-sleep_in_spinlock.patch
-ppc64-defconfig.patch
-ppc64-g5-iommu-fix.patch
-ppc64-massive-of-properties-fix.patch
-ext3-journalled-quotas-2.patch
-ext3-journalled-quotas-2-exports.patch
-ide-scsi-error-handling-fixes.patch
-ide-scsi-error-handling-update.patch
-ATI-IXP-IDE-support.patch
-selinux-conditional-policy-extensions.patch
-cm206-check_region-fix.patch
-document-acpi_sleep-option.patch
-document-S3_swsusp-tricks.patch
-sjcd-check_region-fix.patch
-rename-acpi_disable.patch
-filemap-comment-fix.patch
-fix-kallsyms-in-modules.patch
-ver_linux-binutils-version-fix.patch
-module-aliases-for-char-devices.patch
-credits-updates.patch
-genhd-comment-fix.patch
-docbook-build-warning.patch
-cdu31c-check_region-fix-2.patch
-move-pcibios-help.patch
-modular-fbdev-fix.patch
-kbuild-modpost-fix.patch
-selinux-compute_av-fix.patch
-flush_scheduled_work-deadlock-fix.patch
-flush_scheduled_work-recursion-detect.patch
-page_referenced-no-mark_page_accessed.patch
-fbdev-char-drawing-enhancement.patch
-sgml-build-fix.patch
-reiserfs-direct-tail.patch
-reiserfs-lock-lat.patch
-reiserfs-search-restart.patch
-reiserfs-should-end-jbegin.patch
-reiserfs-write-sched-bug.patch
-reiserfs-aio.patch
-early-x86-cpu-detection.patch
-early-x86-cpu-detection-fix.patch
-do_write_mem-retval-check.patch
-vsyscall-alignment-fix.patch
-smh-do_unmap-comments.patch
-slab-corruption-detector-fix.patch
-kthread-keeps-files-open.patch
-kill-INIT_THREAD_SIZE.patch
-congestion_wqh-init.patch
-more-raw-devices.patch
-iostats-averaging-fix.patch

 Merged

+quota-locking-fixes.patch

 Quota-related locking fixes in the core kernel

+lightweight-auditing-framework-update-1.patch

 Fixes to lightweight-auditing-framework.patch

+per-backing_dev-unplugging-dm-fix.patch
+per-backing_dev-unplugging-dm-md-rethink.patch
+correct-unplugs-on-nr_queued.patch

 Various fixes against the block unplugging rework patches.

-module_h-attribute_used-fix.patch

 Dropped, no longer needed.

+move-job-control-stuff-tosignal_struct-sparc64-fix.patch

 Fix the signal rework for sparc64

-early-x86-cpu-detection.patch
-early-x86-cpu-detection-fix.patch
-early-x86-cpu-detection-fix-2.patch

 Dropped, crashy.

+therm_adt7467-update.patch

 Fan driver update

+config-x86_64-lib64-fix.patch
+config-dont-rename-target-dir.patch
+config-disable-debug-printks.patch
+config-persistent-qconf-config.patch
+config-choice-fix.patch

 Various fixes to the config system

+serial_8250_pnp_init.patch
+mm_slab_init.patch
+doc_var_updates.patch
+char_ip2_double_op.patch
+fs_proc_minmax.patch
+reiserfs_minmax.patch
+sound_oss_minmax.patch
+zlib_deflate_minmax.patch

 Janitorial patches

+lower-zone-protection-numa-fix.patch
+lower-zone-protection-numa-fix-tickle.patch

 Fix up the page allocator's `incremental min' so it doesn't gobble huge
 amounts of memory on NUMA machines when falling back across nodes.

+BSD-accounting-HZ-leak-fix.patch

 Don't leak HZ to userspace

+memcmp-uninlining-fix.patch

 Module linkage fix

+edd-01-move-to-include-linux.patch
+edd-02-move-to-drivers-firmware.patch
+edd-03-split-assembly-code.patch

 Move the EDD code around so other architectures can use it.

+tag-writeback-pages-fix.patch
+tag-writeback-pages-missing-filesystems.patch
+stop-using-locked-pages-fix.patch
+stop-using-locked-pages-fix-2.patch
+clear_page_dirty_for_io.patch

 Fixes to the writeback rework.

-slab-alignment-rework-merge-fix.patch

 Folded into slab-alignment-rework.patch





All 207 patches:


linus.patch

bk-acpi.patch

bk-alsa.patch

bk-ieee1394.patch

bk-netdev.patch

bk-pci.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

scsi_transport_spi-build-fix.patch
  Fix scsi_transport_spi.c for gcc-2.95.3

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

ppc64-reloc_hide.patch

compat-signal-noarch-2004-01-29.patch
  Generic 32-bit compat for copy_siginfo_to_user
  compat-signal sparc64 fix

quota-locking-fixes.patch
  Quota locking fixes

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

lightweight-auditing-framework-update-1.patch
  Light-weight Auditing Framework update

per-node-rss-tracking.patch
  Track per-node RSS for NUMA

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

futex_wait-debug.patch
  futex_wait debug

futex_wait-debug-fix.patch

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

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

per-backing_dev-unplugging-dm-fix.patch
  dm plug buglet

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

per-backing_dev-unplugging-dm-md-rethink.patch
  plugged bit

correct-unplugs-on-nr_queued.patch
  Correct unplugs on nr_queued

HPFS1-hpfs2-RC4-rc1.patch

HPFS2-hpfs_namei-RC4-rc1.patch

queue_work_on_cpu.patch
  Add queue_work_on_cpu() workqueue function

siimage-update.patch
  ide: update for siimage driver

sysfs-pin-kobject.patch
  sysfs: pin kobjects to fix use-after-free crashes

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

move-job-control-stuff-tosignal_struct-sparc64-fix.patch
  move-job-control-stuff-tosignal_struct-sparc64-fix

devinet-ctl_table-fix.patch
  devinet_ctl_table[] null termination

idr-extra-features.patch
  idr.c: extra features enhancements

shm-do_munmap-check.patch

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

therm_adt7467-update.patch
  therm_adt7467 update

config-x86_64-lib64-fix.patch
  kconfig: fix xconfig on /lib64 properly

config-dont-rename-target-dir.patch
  kconfig: don't rename target dir when saving config

config-disable-debug-printks.patch
  config: disable debug prints

config-persistent-qconf-config.patch
  config: persistent qconf configuration

config-choice-fix.patch
  config: choice fix

serial_8250_pnp_init.patch
  8250_pnp: probe and remove can be __devinit/__devexit

mm_slab_init.patch
  slab: start_cpu_timer() can be __init

doc_var_updates.patch
  doc. updates/typos

char_ip2_double_op.patch
  ip2: fix double operator

fs_proc_minmax.patch
  procfs: use kernel min/max

reiserfs_minmax.patch
  reiserfs: use kernel min/max

sound_oss_minmax.patch
  sound: use kernel min/max

zlib_deflate_minmax.patch
  zlib: use kernel min/max

lower-zone-protection-numa-fix.patch
  Fix page allocator lower zone protection for NUMA

lower-zone-protection-numa-fix-tickle.patch

BSD-accounting-HZ-leak-fix.patch
  fix HZ leaking to userspace in BSD accounting

memcmp-uninlining-fix.patch
  Fix uninlined memcmp on i386

edd-01-move-to-include-linux.patch
  EDD: move code from i386-specific locations to generic

edd-02-move-to-drivers-firmware.patch
  EDD: move code from i386-specific locations to generic

edd-03-split-assembly-code.patch
  EDD: split assembly code

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

tag-writeback-pages-fix.patch

tag-writeback-pages-missing-filesystems.patch

stop-using-dirty-pages.patch
  stop using the address_space dirty_pages list

stop-using-io-pages.patch
  remove address_space.io_pages

stop-using-locked-pages.patch
  Stop using address_space.locked_pages

stop-using-locked-pages-fix.patch
  stop-using-locked-pages fix

stop-using-locked-pages-fix-2.patch
  wait_on_page_writeback_range fix

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

clear_page_dirty_for_io.patch
  fdatasync integrity fix

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



