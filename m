Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbUCUJzn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 04:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUCUJzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 04:55:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:34012 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263623AbUCUJyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 04:54:11 -0500
Date: Sun, 21 Mar 2004 01:54:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc2-mm1
Message-Id: <20040321015412.491cd2cd.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc2/2.6.5-rc2-mm1/

- Dave Jones's agpgart and cpufreq trees will henceforth be included in -mm
  kernels.

- Various speedups, cleanups and fixes to the writeback, ext2 and ext3 code.

- The usual bunch of random fixes




Changes since 2.6.5-rc1-mm2:


 linus.patch
 bk-acpi.patch
 bk-driver-core.patch
 bk-i2c.patch
 bk-ieee1394.patch
 bk-netdev.patch
 bk-scsi.patch
 bk-agpgart.patch
 bk-cpufreq.patch

 External trees

-scsi_transport_spi-build-fix.patch
-sysfs_remove_dir-race-fix.patch
-sysfs_remove_subdir-dentry-leak-fix.patch
-HPFS1-hpfs2-RC4-rc1.patch
-HPFS2-hpfs_namei-RC4-rc1.patch
-sysfs-pin-kobject.patch
-init-task-alignment-fix.patch
-empty_zero_page-cleanup.patch
-therm_adt7467-update.patch
-config-x86_64-lib64-fix.patch
-config-dont-rename-target-dir.patch
-config-disable-debug-printks.patch
-config-persistent-qconf-config.patch
-config-choice-fix.patch
-serial_8250_pnp_init.patch
-mm_slab_init.patch
-doc_var_updates.patch
-char_ip2_double_op.patch
-fs_proc_minmax.patch
-reiserfs_minmax.patch
-sound_oss_minmax.patch
-zlib_deflate_minmax.patch
-BSD-accounting-HZ-leak-fix.patch
-memcmp-uninlining-fix.patch
-edd-01-move-to-include-linux.patch
-edd-02-move-to-drivers-firmware.patch
-edd-03-split-assembly-code.patch

 Merged

+agp-build-fix.patch

 Fix duplicate symbols

+kgdboe-configuration-logic-fix.patch
+kgdboe-configuration-logic-fix-fix.patch

 kgdb-over-ethernet fixes

+vt-cleanup.patch

 Tidy some coding in vt.c

+con_open-speedup.patch

 Clean up and speed up con_open()

+slab-oops-fix.patch

 Fix a slab oops with CPU hotplug

+parallel-make-fix.patch

 kbuild fix
 
-compat-signal-noarch-2004-01-29.patch

 Nobody can agree over this.

+acpi-gsi-irq-conversions-fix.patch

 MP table parsing cleanup

+inode-cleanup.patch

 Tidy up fs/inode.c a little.

+sched-run_list-cleanup.patch

 CPU scheduler cleanup

-sched-remove-unused-local.patch
-sched-domains-improvements.patch
-sched-clock-fixes.patch

 Folded into sched-domains.patch

-sched-domain-tweak.patch

 Folded into sched-domains-i386-ht.patch

-sched-smt-nice-optimisation.patch

 Folded into sched-smt-nice-handling.patch

-sched-no-cpu-in-rq.patch

 Folded into sched-local-load.patch

+initramfs-search-for-init.patch

 New version of this patch

+initramfs-search-for-init-zombie-fix.patch

 Fix zombie threads in the above.

+lightweight-auditing-framework-warning-fix.patch

 Fix warnings in lightweight-auditing-framework.patch

-futex_wait-debug.patch
-futex_wait-debug-fix.patch

 These broke, and the problem which they were designed to trap seems to have
 vanished.

-dm-maplock.patch
-dm-map-rwlock-ng.patch

 Folded into queue-congestion-dm-implementation.patch

-per-backing_dev-unplugging-dm-fix.patch
-per-backing_dev-unplugging-BIO_RW_SYNC-fix.patch
-per-backing_dev-unplugging-block_sync_page-fix.patch
-per-backing_dev-unplugging-fix-42.patch
-md-unplugging-fix.patch
-md-unplugging-fix-fix.patch
-swapper_space-unplug_fn.patch
-shmem-unplug_fn.patch
-per-backing_dev-unplugging-dm-md-rethink.patch

 Folded into per-backing_dev-unplugging.patch

-queue_work_on_cpu.patch

 Dropped - no longer needed.

-nmi-1-hz.patch
+nmi-1-hz-2.patch

 New version.

-move-job-control-stuff-tosignal_struct-s390-fix.patch
-move-job-control-stuff-tosignal_struct-sx-fix.patch
-move-job-control-stuff-tosignal_struct-sn-fix.patch
-move-job-control-stuff-tosignal_struct-sparc64-fix.patch

 Folded into move-job-control-stuff-tosignal_struct.patch

+move-job-control-stuff-tosignal_struct-ebtables-fix.patch

 Fix it yet again.

+ext3-fsync-speedup.patch

 Make ext3 file-overwrite fsyncs() faster.

+ext2-fsync-speedup-2.patch

 Make ext2 file-overwrite fsyncs() faster.

+proc_misc-compiler-workaround.patch

 Fix gcc-2.9x internal compiler errors.

+cpu_khz-adjustment-fix.patch

 Timekeeping fix

+jbd-commit-ordered-fix.patch

 Small JBD fix

+jbd-move-locked-buffers.patch

 JBD simplification and speedup.

+jbd-remove-livelock-avoidance.patch

 Remove ancient icky code which the above makes unnecessary.

+jbd-iobuf-error-handling-fix.patch

 Fix JBD I/O error handling.

+readv-writev-check-fix.patch

 Fix readv/writev arg checking.

+kerneldoc-handle-attributes.patch

 kerneldoc fixlet.

+fbcon-font-cloning-fix.patch

 fbcon feature work.

+kconfig-tpyo-fix.patch

 Fix Kconfig help.

+blockdev-open-retval-fix.patch

 Fix error code on attempt to open non-existent blockdev.

+set-mod-waiter-before-calling-stop_machine.patch

 Module system fix.

+sysctl-EFAULT-fixes.patch

 Check uaccess return codes.

+gcc-35-stack-use-fix.patch

 Avoid deep stack usage.

+mprotect-retval-fix.patch

 Standard-compliant mprotect() return values.

+procfs-comment-fixes.patch

 Fix some buggy comments.

+sysfs-for-framebuffer.patch

 Teach the fbdev code to put things in sysfs.

+sb_mixer-bounds-checking.patch

 sb_mixer.c range checks.

+s_id-null-termination.patch

 s/strncpy/strlcpy/

-aio-direct-io-oops-fix.patch

 Folded into aio-fallback-bio_count-race-fix-2.patch

+inode-dirtying-timestamp-fix.patch

 Put the time-of-first-dirtying of files into the inode, not the
 address_space.

-tag-writeback-pages-fix.patch
-tag-writeback-pages-missing-filesystems.patch

 Folded into tag-writeback-pages.patch

+kupdate-function-fix.patch

 Fix the periodic writeback function.

-stop-using-locked-pages-fix.patch
-stop-using-locked-pages-fix-2.patch

 Folded into stop-using-locked-pages.patch

+mpage_writepages-latency-fix.patch

 Add a low-latency scheduling point.

-remap-file-pages-prot-ia64-fix.patch

 Folded into remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch

+remap-file-pages-prot-ppc64.patch

 ppc64 support for per-page permissions in remap_file_pages()

-lockmeter-ia64-fix.patch

 Folded into lockmeter.patch

-ppc-fixes-dependency-fix.patch

 Folded into ppc-fixes.patch






All 188 patches


linus.patch

bk-acpi.patch

bk-driver-core.patch

bk-i2c.patch

bk-ieee1394.patch

bk-netdev.patch

bk-scsi.patch

bk-agpgart.patch

bk-cpufreq.patch

mm.patch
  add -mmN to EXTRAVERSION

agp-build-fix.patch
  Fix agp linkage error

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

kgdboe-configuration-logic-fix.patch
  kgdboe: fix configuration of MAC address

kgdboe-configuration-logic-fix-fix.patch

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

kgdb-THREAD_SIZE-fixes.patch
  THREAD_SIZE fixes for kgdb

vt-cleanup.patch
  vt.c cleanup

con_open-speedup.patch
  con_open() speedup/cleanup

slab-oops-fix.patch
  start_cpu_timer() cannot be __init

ppc-fixes.patch
  ppc32: fix build with CONFIG_MODVERSIONS

parallel-make-fix.patch
  kbuild ordering fix

x86_64-tiocgdev-fix.patch
  x86_64 tiocgdev fix

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-reloc_hide.patch

acpi-gsi-irq-conversions-fix.patch
  acpi: clean up ACPI GSI/IRQ conversions (i386 part)

quota-locking-fixes.patch
  Quota locking fixes

inode-cleanup.patch
  fs/inode.c list_head cleanup

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

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

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

sched-run_list-cleanup.patch
  small scheduler cleanup

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

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

ppc64-sched-domain-support.patch
  ppc64: sched-domain support

sched-local-load.patch
  sched: add local load metrics

process-migration-speedup.patch
  Reduce TLB flushing during process migration

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

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

initramfs-search-for-init.patch
  search for /init for initramfs boots

initramfs-search-for-init-zombie-fix.patch
  initramfs-kinit_command zombie fix

lightweight-auditing-framework.patch
  Light-weight Auditing Framework

lightweight-auditing-framework-update-1.patch
  Light-weight Auditing Framework update

lightweight-auditing-framework-warning-fix.patch
  lightweight-auditing-framework warning fixes

per-node-rss-tracking.patch
  Track per-node RSS for NUMA

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

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
  devicemapper: use rwlock for map alterations
  Another DM maplock implementation

dm-remove-__dm_request.patch
  dmL remove __dm_request
  per-backing dev unplugging

per-backing_dev-unplugging.patch
  per-backing dev unplugging
  dm plug buglet
  per-backing-dev unplugging: fix BIO_RW_SYNC handling
  per-backing dev unplugging oops fix #42
  fix md for per-address_space unplugging
  more backing_dev unplug functions
  plugged bit

correct-unplugs-on-nr_queued.patch
  Correct unplugs on nr_queued
  correct-unplugs-on-nr_queued fix

siimage-update.patch
  ide: update for siimage driver

ipmi-updates-3.patch
  IPMI driver updates

ipmi-socket-interface.patch
  IPMI: socket interface

nmi_watchdog-local-apic-fix.patch
  Fix nmi_watchdog=2 and P4 HT

nmi-1-hz-2.patch
  reduce NMI watchdog call frequency with local APIC.

pcmcia-netdev-ordering-fixes.patch
  PCMCIA netdevice ordering issues

3ware-update.patch
  3ware driver update

move-job-control-stuff-tosignal_struct.patch
  moef job control fields from task_struct to signal_struct
  s390 fix for move-job-control-stuff-tosignal_struct.patch
  From: John Hawkes <hawkes@babylon.engr.sgi.com>
  Subject: [PATCH] 2.6.4-mm1 for ia64
  move-job-control-stuff-tosignal_struct-sparc64-fix

move-job-control-stuff-tosignal_struct-ebtables-fix.patch
  move-job-control-stuff-tosignal_struct-ebtables-fix

devinet-ctl_table-fix.patch
  devinet_ctl_table[] null termination

idr-extra-features.patch
  idr.c: extra features enhancements

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

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

lower-zone-protection-numa-fix.patch
  Fix page allocator lower zone protection for NUMA

lower-zone-protection-numa-fix-tickle.patch

ext3-fsync-speedup.patch
  ext3 fsync() and fdatasync() speedup

ext2-fsync-speedup-2.patch
  speed up ext2 fsync() and fdatasync()

proc_misc-compiler-workaround.patch
  Work around compiler error in proc_misc.c

cpu_khz-adjustment-fix.patch
  Adjust cpu_khz when the CPU frequency changes

jbd-commit-ordered-fix.patch
  jbd: fix ordered-data writeout logic

jbd-move-locked-buffers.patch
  JBD: ordered-data commit cleanup

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

jbd-iobuf-error-handling-fix.patch
  jbd: fix I/O error handling

readv-writev-check-fix.patch
  readv/writev range checking fix

kerneldoc-handle-attributes.patch
  Fix scripts/kernel-doc to handle __attribute__

fbcon-font-cloning-fix.patch
  fbcon font cloning fix

kconfig-tpyo-fix.patch
  i386 Kconfig typo fix

slab-alignment-rework.patch
  slab: updates for per-arch alignments
  slab-alignment-rework merge fix

blockdev-open-retval-fix.patch
  Fix error value for opening block devices

set-mod-waiter-before-calling-stop_machine.patch
  Set mod->waiter Before Calling stop_machine

sysctl-EFAULT-fixes.patch
  Add missing uacccess checks for sysctl.c

gcc-35-stack-use-fix.patch
  make inflate use less stack space with gcc3.5

mprotect-retval-fix.patch
  mprotect return value fix

procfs-comment-fixes.patch
  fs/proc/proc_tty.c comment fixes

sysfs-for-framebuffer.patch
  Sysfs calss support for framebuffer

sb_mixer-bounds-checking.patch
  sb_mixer bounds checking

s_id-null-termination.patch
  null-terminate sb->s_id

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
  AIO/direct-io oops fix

inode-dirtying-timestamp-fix.patch
  inode dirtying timestamp fix

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

kupdate-function-fix.patch
  fix the kupdate function

stop-using-io-pages.patch
  remove address_space.io_pages

stop-using-locked-pages.patch
  Stop using address_space.locked_pages
  stop-using-locked-pages fix
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

mpage_writepages-latency-fix.patch
  Add mpage_writepages() scheduling point

remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch
  per-page protections for remap_file_pages()

remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch
  remap_file_pages page-prot implementation for ia64
  From: John Hawkes <hawkes@babylon.engr.sgi.com>
  Subject: [PATCH] 2.6.4-mm1 for ia64

remap-file-pages-prot-s390.patch
  s390: remap-file-pages-prot support

remap-file-pages-prot-sparc64.patch
  remap-file-pages-prot: sparc64 support

remap-file-pages-prot-ppc64.patch
  remap-file-pages-page-prot ppc64 support

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
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



