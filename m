Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbUCXH0B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 02:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbUCXH0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 02:26:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:30872 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263039AbUCXHZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 02:25:12 -0500
Date: Tue, 23 Mar 2004 23:25:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc2-mm2
Message-Id: <20040323232511.1346842a.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc2/2.6.5-rc2-mm2/

- Fixed the memory leak which 2.6.5-rc2-mm1 suffered from.

- More writeback changes - correctness and performance fixes.

- Various random fixes




Changes since 2.6.5-rc2-mm1:


 linus.patch
 bk-acpi.patch
 bk-driver-core.patch
 bk-i2c.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-netdev.patch
 bk-scsi.patch
 bk-agpgart.patch
 bk-cpufreq.patch

 External trees (24 hours old - linux.bkbits.net seems to be sick)

+rename-dma_error.patch

 Rename the new dma_error() to dma_mapping_error()

-slab-oops-fix.patch
-parallel-make-fix.patch
-x86_64-tiocgdev-fix.patch
-acpi-gsi-irq-conversions-fix.patch
-pnp-01-resource-conflict-cleanup.patch
-pnp-02-update-pc-parport-detection.patch
-pnp-03-fix-device-detection.patch
-pnp-04-remove-__init.patch
-pnp-05-mod-inc-dec-removal.patch
-pnp-06-add-ids.patch
-pnp-07-remove-experimental-status.patch
-pnp-08-mem-config-fix.patch
-blockdev-open-retval-fix.patch
-sysctl-EFAULT-fixes.patch
-gcc-35-stack-use-fix.patch
-mprotect-retval-fix.patch

 Merged

+ia64-dma_error-fix.patch

 Fix up ia64 for dma_mapping_error()

+ppc64-iseries-virtual-cd-fix.patch
+ppc64-iseries-cleanups.patch
+pmac-zilog-uninitialised-var-fix.patch
+ppc64-d_type-fix.patch
+bmac-boot-messages-fix.patch

 PCP64 updates

+sh-01-defconfigs.patch
+sh-02-sh-sci.patch
+sh-03-dac-oss-driver.patch
+sh-04-dma-mapping-api.patch
+sh-05-hugetlb.patch
+sh-06-framebuffer.patch
+sh-07-fixes.patch

 SuperH updates

+quota-locking-fixes-update.patch

 Update to quota-locking-fixes.patch

+ext3-journalled-quotas.patch

 Reintroduce the patch which adds journalling of ext3 quota files.

-initramfs-search-for-init.patch
-initramfs-search-for-init-zombie-fix.patch
+initramfs-search-for-init-orig.patch

 Go back to the original, simple version of this patch.

+nfs-02-small_rsize-warning-fixes.patch
+nfs-03-small_wsize-warning-fixes.patch

 NFS warning fixes

+SCHED_FIFO-fix.patch

 Fix SCHED_FIFO/SCHED_RR behaviour

-ppc64-sched-domain-support.patch

 This didn't compile.

+lightweight-auditing-framework-receive-filter-fixes.patch
+lightweight-auditing-framework-receive-filter-fixes-fix.patch

 Touchups to the auditing and tracing framework.

+selinux-compute_sid-fixes.patch

 Teach SELinux to utilise the auditing framework.

+per-backing_dev-unplugging-unplug_delay.patch

 Kill some debugging code.

-nmi_watchdog-local-apic-fix.patch
-nmi-1-hz-2.patch

 I think these were causing kgdb to malfunction.

+jbd-move-locked-buffers-leak-fixes.patch

 Fix memory leaks in JBD (ext3)

+ext23-i_flags-fix.patch

 Use the right i_flags in the Orlov allocators

+powernow-k8-update.patch

 Update this driver

+pmdisk-store-handling-fix.patch

 Fix pmdisk sysfs input handling

+file-operations-fcntl.patch
+file-operations-fcntl-tidies.patch

 Add file_operations.fcntl(), because NFS needs to disallow O_DIRECT|O_APPEND.

+O_LARGEFILE-fix.patch

 Separate the kerrel-internal setting of O_LARGEFILE from userspace's
 setting of it.

+jgarzik-warnings.patch

 Fix SATA warnings

+sys_time-subtick-correction-fix.patch

 sys_time accuracy fix.

+bitmap_parse-fix.patch

 Fix bitmap parsing shift direction.

+ver_linux-fix.patch
+codingstyle-fix-for-emacs.patch
+document-unused-i386-pte-bits.patch
+docbook-sgml-quotes-fix.patch
+sgml-close-tags.patch
+sch_ingress-help-fix.patch
+i386-irq-cleanup.patch
+firmware-loader-docs-fix.patch
+kernel-power-config-URL-fix.patch
+trivial-patches-in-maintainers.patch
+genksyms-parser-fix.patch
+CONFIG_X86_GENERIC-help-fix.patch
+credits-update.patch
+device-h-duplicate-include.patch
+unmapped-CPU-node-number-fix.patch
+submitting-trivial-patches.patch
+ne2k-pic-build-fix.patch
+logitech-keyboard-fix.patch
+doc-changes-update.patch

 Trivial patch monkey was here.

+BLKPREP_KILL-fix.patch

 ide-cd fix.

+autofs-dnotify-signal-fix.patch

 autofs-vs-dnotify fix

+bio_pair_end-fix.patch

 BIO partial completion fix

+posix-timers-thread.patch

 Make posix-timers more posix.

+md-merging-fix.patch

 Fix RAID merging problem.

+probe_roms-01-move-stuff.patch
+probe_roms-02-fixes.patch

 Clean up and fix the ia32 early ROM probing code.

+tgafb-build-fix.patch

 Compile fix.

+make-borken-cdroms-writeable.patch

 Make standards-uncompliant writeable CDROMs writeable.

+noexec-stack.patch
+noexec-stack-comments.patch

 Propagate elf PT_GNU_STACK sections into the stack vma.

+hugetlb-stop-using-page-list-sh.patch

 Switch SuperH hugetlbpage code over to using page->lru

+arm-stop-using-page-list.patch
+m68k-stop-using-page-list.patch

 Nail a few more users of page->list

+block_write_full_page-redirty.patch
+writeback-search-start.patch

 writeback fixes and speedups.

+remap-file-pages-prot-ppc64-more.patch

 Complete the implementation of per-per-permissions for remap_file_pages().

+ia32-4k-stacks-remove-44-dependency.patch
+4k-stacks-4g4g-interaction-fix.patch

 Make the 4k stacks code independent of the 4g/4g code.

+4g4g-restore-4k-stacks-stuff.patch

 The 4g/4g patch needs this when the 4k stacks patch is also applied.




All 240 patches:


linus.patch

bk-acpi.patch

bk-driver-core.patch

bk-i2c.patch

bk-ieee1394.patch

bk-input.patch

bk-netdev.patch

bk-scsi.patch

bk-agpgart.patch

bk-cpufreq.patch

mm.patch
  add -mmN to EXTRAVERSION

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

rename-dma_error.patch
  rename dma_error()

vt-cleanup.patch
  vt.c cleanup

con_open-speedup.patch
  con_open() speedup/cleanup

ppc-fixes.patch
  ppc32: fix build with CONFIG_MODVERSIONS

ia64-dma_error-fix.patch
  Subject: Re: 2.6.5-rc2 lots of warnings for dma_error
  Subject: Re: 2.6.5-rc2 lots of warnings for dma_error
  From: Bjorn Helgaas <bjorn.helgaas@hp.com>
  Subject: Re: 2.6.5-rc2 lots of warnings for dma_error
  From: Bjorn Helgaas <bjorn.helgaas@hp.com>
  Subject: Re: 2.6.5-rc2 lots of warnings for dma_error
  From: Bjorn Helgaas <bjorn.helgaas@hp.com>
  Subject: Re: 2.6.5-rc2 lots of warnings for dma_error

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-iseries-virtual-cd-fix.patch
  ppc64: iSeries virtual cd fix

ppc64-iseries-cleanups.patch
  ppc64: iSeries virtual console cleanup (part 1)

pmac-zilog-uninitialised-var-fix.patch
  pmac-zilog uninitialised variable fix

ppc64-d_type-fix.patch
  ppc64: getdents patch for 32 -> 64 converter

bmac-boot-messages-fix.patch
  Cosmetic fix of BMAC boot messages

sh-01-defconfigs.patch
  sh: update defconfigs

sh-02-sh-sci.patch
  sh: port sh-sci driver to the new API

sh-03-dac-oss-driver.patch
  sh: DAC ODD driver

sh-04-dma-mapping-api.patch
  sh: DMA Mapping API

sh-05-hugetlb.patch
  sh: hugetlb support

sh-06-framebuffer.patch
  sh: sh-specific framebuffer updates

sh-07-fixes.patch
  sh: various fixes

ppc64-reloc_hide.patch

quota-locking-fixes.patch
  Quota locking fixes

quota-locking-fixes-update.patch
  quota locking fix - new version

ext3-journalled-quotas.patch
  Journalled quota patch

inode-cleanup.patch
  fs/inode.c list_head cleanup

initramfs-search-for-init-orig.patch
  search for /init for initramfs boots

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

nfs-02-small_rsize-warning-fixes.patch
  Fix nfs-02-small_rsize ppc64 warnings

nfs-03-small_wsize.patch
  Subject: [PATCH] Add asynchronous write support for wsize<PAGE_SIZE

nfs-03-small_wsize-warning-fixes.patch
  Fix ppc64 warnings in nfs-03-small_wsize patch

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

SCHED_FIFO-fix.patch
  Fix posix scheduling violation for !SCHED_OTHER

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

lightweight-auditing-framework.patch
  Light-weight Auditing Framework

lightweight-auditing-framework-update-1.patch
  Light-weight Auditing Framework update

lightweight-auditing-framework-warning-fix.patch
  lightweight-auditing-framework warning fixes

lightweight-auditing-framework-receive-filter-fixes.patch
  Light-weight Auditing Framework receive filter fixes

lightweight-auditing-framework-receive-filter-fixes-fix.patch
  lightweight-auditing-framework-receive-filter-fixes compile fix

selinux-compute_sid-fixes.patch
  selinux: Audit compute_sid errors

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

per-backing_dev-unplugging-unplug_delay.patch
  per address_space unplug: tunesup, kill debug code.

correct-unplugs-on-nr_queued.patch
  Correct unplugs on nr_queued
  correct-unplugs-on-nr_queued fix

siimage-update.patch
  ide: update for siimage driver

ipmi-updates-3.patch
  IPMI driver updates

ipmi-socket-interface.patch
  IPMI: socket interface

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

jbd-move-locked-buffers-leak-fixes.patch

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

set-mod-waiter-before-calling-stop_machine.patch
  Set mod->waiter Before Calling stop_machine

procfs-comment-fixes.patch
  fs/proc/proc_tty.c comment fixes

sysfs-for-framebuffer.patch
  Sysfs calss support for framebuffer

sb_mixer-bounds-checking.patch
  sb_mixer bounds checking

s_id-null-termination.patch
  null-terminate sb->s_id

ext23-i_flags-fix.patch
  ext2&3: use the right i_flags in find_group_orlov()

powernow-k8-update.patch
  powernow-k8 update

pmdisk-store-handling-fix.patch
  pmdisk: fix strcmp in sysfs store

file-operations-fcntl.patch
  add file_operations.fcntl

file-operations-fcntl-tidies.patch
  file-operations-fcnt tidies

O_LARGEFILE-fix.patch
  Hide forced O_LARGEFILE from userspace

jgarzik-warnings.patch

sys_time-subtick-correction-fix.patch
  Fix sys_time() to get subtick correction from the new xtime

bitmap_parse-fix.patch
  Broken bitmap_parse for ncpus > 32

ver_linux-fix.patch
  ver_linux fix

codingstyle-fix-for-emacs.patch
  Update CodingStyle hints for Emacs users.

document-unused-i386-pte-bits.patch
  document unused pte bits on i386

docbook-sgml-quotes-fix.patch
  Consistently use quotes for SGML attributes

sgml-close-tags.patch
  SGML: close tag with ">"

sch_ingress-help-fix.patch
  fix sch_ingress help

i386-irq-cleanup.patch
  i386 irq.c ifdef cleanup

firmware-loader-docs-fix.patch
  Fix firmware loader docs

kernel-power-config-URL-fix.patch
  Fix url in kernel/power/Kconfig

trivial-patches-in-maintainers.patch
  Trivial Patch Monkey should be in MAINTAINERS

genksyms-parser-fix.patch
  Fix genksyms parsing

CONFIG_X86_GENERIC-help-fix.patch
  CONFIG_X86_GENERIC description fixup

credits-update.patch
  updating email info in CREDITS

device-h-duplicate-include.patch
  Kill duplicate #include <linux_ioport.h>

unmapped-CPU-node-number-fix.patch
  Use valid node number when unmapping x86 CPUs

submitting-trivial-patches.patch
  Add CC Trivial Patch Monkey to SubmittingPatches

ne2k-pic-build-fix.patch
  ne2k-pci.c compile fix on ppc[64]

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

doc-changes-update.patch
  Update Documentation/Changes

BLKPREP_KILL-fix.patch
  Fix BLKPREP_KILL

autofs-dnotify-signal-fix.patch
  dnotify + autofs may create signal/restart syscall loop

bio_pair_end-fix.patch
  catch errors when completing bio pairs

posix-timers-thread.patch
  fix posix-timers to have proper per-process scope

md-merging-fix.patch
  md: merge_bvec_fn needs to know about partitions.

probe_roms-01-move-stuff.patch
  i386 probe_roms(): preparation

probe_roms-02-fixes.patch
  i386 probe_roms(): fixes

tgafb-build-fix.patch
  tgafb: missing include

make-borken-cdroms-writeable.patch
  Broken CDROMs default to writeable

noexec-stack.patch
  Non-Exec stack support

noexec-stack-comments.patch

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

hugetlb-stop-using-page-list-sh.patch

pageattr-stop-using-page-list.patch
  stop using page.list in pageattr.c

readahead-stop-using-page-list.patch
  stop using page.list in readahead

compound-pages-stop-using-lru.patch
  stop using page->lru in compound pages

arm-stop-using-page-list.patch
  arm: stop using page->list

m68k-stop-using-page-list.patch
  switch the m68k pointer-table code over to page->lru

remove-page-list.patch
  remove page.list

clear_page_dirty_for_io.patch
  fdatasync integrity fix

block_write_full_page-redirty.patch
  don't permit background writes to hide dirty buffers

writeback-search-start.patch
  writeback efficiency and QoS improvements

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

remap-file-pages-prot-ppc64-more.patch

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

ia32-4k-stacks.patch
  ia32: 4Kb stacks (and irqstacks) patch

ia32-4k-stacks-remove-44-dependency.patch

4k-stacks-4g4g-interaction-fix.patch
  fix interaction between 4k stacks and 4g:4g

ia32-4k-stacks-build-fix.patch
  4k stacks build fix

4k-stacks-in-modversions-magic.patch
  Add 4k stacks to module version magic

4k-stacks-always-on.patch
  Permanently enable 4k stacks on ia32

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

4g4g-restore-4k-stacks-stuff.patch
  4g4g: make it play with 4k stacks

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

4g4g-variable-stack-size.patch
  Fix 4G/4G w/ 8k+ stacks



