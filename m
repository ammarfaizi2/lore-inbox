Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUDIDFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 23:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUDIDFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 23:05:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:15342 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262079AbUDIDEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 23:04:51 -0400
Date: Thu, 8 Apr 2004 20:04:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mc3
Message-Id: <20040408200438.00f28506.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc3/

This is the queue of things to go to Linus next week.

- Included Bill's hugetlbpage consolidation work.  People who are working
  on bigpage features should work against these patches.

- Arch updates

- Added the per-address_space disk unplugging code.

- Added the CFQ I/O scheduler





Changes since 2.6.5-mc2:



+wchan-use-ELF-sections-sparc64-fix.patch

 Fix wchan-use-ELF-sections.patch for sparc64

+ppc32-altivec-exception-fix.patch

 ppc32 fix

+ppc64-Fix-G5-build-with-DART-iommu-support.patch
+disable-VT-on-iSeries-by-default.patch
+ppc64-export-itLpNaca-on-iSeries.patch
+PPC64-iSeries-virtual-ethernet-driver.patch
+ppc64-Allow-hugepages-anywhere-in-low-4GB.patch

 ppc64 updates

-mq-03-core-update.patch

 Folded into mq-03-core.patch

+split-netlink_unicast.patch
+mq_notify-via-netlink.patch
+compat_mq.patch
+compat_mq-ppc-fix.patch
+compat_mq-fix.patch

 Message queue notification over netlink

+nfs-32bit-statfs-fix-warning-fix.patch

 Fix nfs-32bit-statfs-fix.patch

+h8300-support-update.patch

 h8/300 update

+posix-timers-thread.patch

 posix timers are per-process, not per-thread

+v850-bitop-volatiles.patch
+v850-dma-mapping-fix.patch

 v850 fixes

+m68knommu-dma-mapping.patch
+m68knommu-kernel_thread-fix.patch
+m68knommu-kconfig-cleanup.patch
+m68knommu-comempci-printk-cleanup.patch
+m68knommu-coherent-dma-allocation.patch
+m68knommu-build-dmac.patch
+cleanup-m68knommu-setupc-printk-and-irqreturn_t.patch
+cleanup-m68knommu-trapsc-printk-and-dump_stack.patch
+platform-additions-in-m68knommu-linker-script.patch
+fix-gcc-cpu-define-for-m68knommu-coldfire.patch
+add-senTec-vendor-support-to-m68knommu-Makefile.patch
+m68knommu-faultc-printk-cleanup.patch
+m68knommu-mm-initc-printk-cleanup.patch
+m68knommu-ColdFire-base-DMA-addresses.patch
+m68knommu-timersc-printk-cleanup.patch
+missing-n-in-timer_tscc.patch

 68k updates

+hugetlb-consolidation.patch

 Consolidate code from the various hugetlb page implementations

+s390-1-12-core-s390.patch
+s390-2-12-common-i-o-layer.patch
+s390-3-12-tape-driver-fixes.patch
+s390-4-12-dasd-driver-fix.patch
+s390-5-12-network-driver-fixes.patch
+s390-6-12-dcss-block-driver-fix.patch
+s390-7-12-zfcp-fixes-without-kfree-hack.patch
+s390-8-12-zfcp-log-messages-part-1.patch
+s390-9-12-zfcp-log-messages-part-2.patch
+s390-10-12-crypto-device-driver-part-1.patch
+s390-11-12-crypto-device-driver-part-2.patch
+s390-12-12-rewritten-qeth-driver.patch

 S/390 update

+queue-congestion-callout.patch
+queue-congestion-dm-implementation.patch

 blk_queue_congested() accuracy

+dm-remove-__dm_request.patch
+per-backing_dev-unplugging.patch
+swap_writepage-BIO_RW_SYNC.patch
+md-unplug-update.patch
+correct-unplugs-on-nr_queued.patch
+correct-unplugs-on-nr_queued-remove-warnings.patch

 Disk unplugging scalability improvements.
 
+cfq-4.patch

 CFQ IO scheduler

+rmap-1-linux-rmaph.patch
+rmap-2-anon-and-swapcache.patch
+rmap-3-arches--mapping_mapped.patch

 Preparatory VM work.





All 263 patches:


x86_64-update.patch
  x86-64 update

kconfig-url-fixes.patch
  Fix URLs in Kconfig files

Lindent-devfs.patch
  feed devfs through Lindent

system_running-fix.patch
  generalise system_running

vt-cleanup.patch
  vt.c cleanup

con_open-speedup.patch
  con_open() speedup/cleanup

remove-down_tty_sem.patch
  remove down_tty_sem()

tty-race-fix-43.patch
  Fix VT open/close race

i4l-kernelcapi-rework.patch
  i4l: kernelcapi receive workqueue and locking rework

wchan-use-ELF-sections.patch
  Fix get_wchan() FIXME wrt. order of functions

wchan-use-ELF-sections-sparc64-fix.patch
  get_wchan() sparc64 fix

ppc32-altivec-exception-fix.patch
  ppc32: Fix thinko in the altivec exception code

ppc64-si_addr-fix.patch
  ppc64: si_addr fix

ppc64-hugepage-fix.patch
  ppc64: Fix bug in hugepage support

ppc64-hugepage-fix-32.patch
  ppc64: hugepage bugfix

ppc64-alloc_consistent-retval-fixes.patch
  ppc64: fix failure return codes from {pci,vio}_alloc_consistent()

ppc64-Fix-G5-build-with-DART-iommu-support.patch
  ppc64: Fix G5 build with DART (iommu) support

disable-VT-on-iSeries-by-default.patch
  disable VT on iSeries by default

ppc64-export-itLpNaca-on-iSeries.patch
  ppc64: export itLpNaca on iSeries

PPC64-iSeries-virtual-ethernet-driver.patch
  PPC64: iSeries virtual ethernet driver

ppc64-Allow-hugepages-anywhere-in-low-4GB.patch
  ppc64: allow hugepages anywhere in low 4GB

ppc4xx-memleak-fix.patch
  ppc44x: fix memory leak

quota-locking-fixes.patch
  Quota locking fixes

inode-cleanup.patch
  fs/inode.c list_head cleanup

initramfs-search-for-init-orig.patch
  search for /init for initramfs boots

knfsd-01-oops-fix.patch
  knfsd: Return -EOPNOTSUPP when unknown mechanism name encountered

knfsd-02-auth-error-return-fix.patch
  knfsd: Minor fix to error return when updating server authentication information

knfsd-03-auth_error-formatting-fix.patch
  knfsd: fix a problem with incorrectly formatted auth_error returns.

knfsd-04-remove-name_lookup_h.patch
  knfsd: Remove name_lookup.h that noone is using anymore.

knfsd-05-mounted_on_fileid-support.patch
  knfsd: Add server-side support for the nfsv4 mounted_on_fileid attribute.

knfsd-06-UTF8-improvements.patch
  knfsd: Improve UTF8 checking.

knfsd-07-auth_gss-export.patch
  knfsd: Export a symbol needed by auth_gss

knfsd-08-gss-integrity.patch
  knfsd: Add data integrity to serve rside gss

md-merging-fix.patch
  md: merge_bvec_fn needs to know about partitions.

mq-01-codemove.patch
  posix message queues: code move

mq-02-syscalls.patch
  posix message queues: syscall stubs

mq-03-core.patch
  posix message queues: implementation

mq-04-linuxext-poll.patch
  posix message queues: linux-specific poll extension

mq-05-linuxext-mount.patch
  posix message queues: made user mountable

mq-update-01.patch
  posix message queue update

mq-security-fix.patch
  security bugfix for mqueue

split-netlink_unicast.patch
  split netlink_unicast

mq_notify-via-netlink.patch
  posix message queues: send notifications via netlink

compat_mq.patch
  compat emulation for posix message queues

compat_mq-ppc-fix.patch
  compat_mq ppc64 fix

compat_mq-fix.patch
  compat_mq fix

ipmi-updates-3.patch
  IPMI driver updates

move-job-control-stuff-tosignal_struct.patch
  move job control fields from task_struct to signal_struct

lower-zone-protection-numa-fix.patch
  Fix page allocator lower zone protection for NUMA

ext3-fsync-speedup.patch
  ext3 fsync() and fdatasync() speedup

ext2-fsync-speedup-2.patch
  speed up ext2 fsync() and fdatasync()

jbd-commit-ordered-fix.patch
  jbd: fix ordered-data writeout logic

jbd-move-locked-buffers.patch
  JBD: ordered-data commit cleanup

jbd-iobuf-error-handling-fix.patch
  jbd: fix I/O error handling

readv-writev-check-fix.patch
  readv/writev range checking fix

kerneldoc-handle-attributes.patch
  Fix scripts/kernel-doc to handle __attribute__

slab-alignment-rework.patch
  slab: updates for per-arch alignments

set-mod-waiter-before-calling-stop_machine.patch
  Set mod->waiter Before Calling stop_machine

procfs-comment-fixes.patch
  fs/proc/proc_tty.c comment fixes

sb_mixer-bounds-checking.patch
  sb_mixer bounds checking

pmdisk-store-handling-fix.patch
  pmdisk: fix strcmp in sysfs store

file-operations-fcntl.patch
  add file_operations.fcntl

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

doc-changes-update.patch
  Update Documentation/Changes

drm-put_user-fixes.patch
  i830 DRM missing put_user

export-complete_all.patch
  export complete_all()

urandom-scalability-fix.patch
  /dev/urandom scalability improvement

cpu5wdt-warning-fix.patch
  cpu5wdt.c warning fix

fget-speedup.patch
  speed up fget() and fget_light()

move-__this_module-to-modpost.patch
  Move __this_module to modpost

modversions-fix.patch
  Fix Modversions Now __this_module Is Created Only in .ko

support-zerobased-floppies.patch
  Support for floppies whose sectors are numbered from zero instead of one

remove-bitmap-length-limits.patch
  Remove bitmap_shift_*() bitmap length limits

huge-sparse-tmpfs-files.patch
  Fix huge sparse tmpfs files

strip-param-quotes.patch
  Strip quotes from kernel parameters

summit-irq-count-override.patch
  summit: per-subarch NR_IRQ_VECTORS

summit-increase-MAX_MP_BUSSES.patch
  summmit: increase MAX_MP_BUSSES

stv0299-unused-var-fix.patch
  stv0299.c unused variable

selinux-fix-struct-type.patch
  selinux: fix struct type

pte_alloc_one-null-pointer-check.patch
  missing NULL pointer check in pte_alloc_one.

kill-MAKEDEV-scripts.patch
  kill spurious MAKDEV scripts

wavfront-warning-fix.patch
  oss/wavfront.c warning fix.

hysnd-MOD_USE_COUNT-fix.patch
  remove bogus MOD_{INC,DEC}_USE_COUNT from hysdn

CONFIG_EMBEDDED-help-fix.patch
  improve CONFIG_EMBEDDED help text

remove-nswap-cnswap.patch
  eliminate nswap and cnswap

no-quota-inode-shrinkage.patch
  shrink inode when quota is disabled

geode-suspend-on-halt.patch
  enable suspend-on-halt for NS Geode

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

rw_swap_page_sync-fix.patch
  rw_swap_page_sync(): place the pages in swapcache

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

arm-stop-using-page-list.patch
  arm: stop using page->list

m68k-stop-using-page-list.patch
  switch the m68k pointer-table code over to page->lru

remove-page-list.patch
  remove page.list

clear_page_dirty_for_io.patch
  fdatasync integrity fix

block_write_full_page-redirty.patch
  don't allow background writes to hide dirty buffers

writeback-search-start.patch
  writeback efficiency and QoS improvements

mpage_writepages-latency-fix.patch
  Add mpage_writepages() scheduling point

mpage-cleanup.patch
  mpage_writepages() cleanup

use-compound-pages-for-hugetlb-only.patch
  use compound pages for hugetlb pages only

fork-vma-order-fix.patch
  fork vma ordering during fork

mremap-copy_one_pte-fix.patch
  mremap: copy_one_pte cleanup

mremap-move_vma-fix.patch
  mremap: move_vma fixes and cleanup

mremap-vma_relink_file-fix.patch
  mremap: vma_relink_file race fix

mremap-check-map_count.patch
  mremap: check map_count

mremap-rmap-comment-fix.patch
  Fix rmap comment

kswapd-remove-pages-scanned.patch
  kswapd: remove pages_scanned local

laptop-mode-3.patch
  laptop mode

laptop-mode-doc-update.patch
  Laptop mode doc updates for XFS, among other things.

laptop-mode-control-script-fix.patch
  Bugfix in the laptop mode control script.

laptop-mode-noflushd-warning.patch
  Subject: [patch 1/1] Add a warning about using laptop-mode with noflushd to laptop-mode doc.

laptop-mode-sync-completion.patch
  Add laptop-mode sync completion function to delete writeback timer.

ext3-commit-default.patch
  Add commit=0 to ext3, meaning "set commit to default".

tunable-pagefault-readaround.patch
  Honour the readahead tunable in filemap_nopage()

filemap_nopage-busywait-fix.patch
  Fix logic in filemap_nopage()

acpi-printk-fix.patch
  acpi printk fix

ia32-4k-stacks.patch
  ia32: 4Kb stacks (and irqstacks) patch

proc-load-average-fix.patch
  procfs LoadAVG/load_avg scaling fix

ppc64-NUMA-fix-for-16MB-LMBs.patch
  ppc64: NUMA fix for 16MB LMBs

sparc64-build-fix.patch
  build fails on sparc64 in hugetlbpage.c

epoll-comment-fixes.patch
  epoll comment fix

stop_machine-barrier-fixes.patch
  add stop_machine barriers

sunrpc-svcsock-drop.patch
  sunrpc: connection dropping tweaks

acl-version-mismatch.patch
  ACL version mismatch error code fix

v4l-cropcap-ioctl-fix.patch
  v4l: cropcap ioctl fix

v4l-v4l1-compat-fix.patch
  v4l: v4l1-compat fix

v4l-tuner-fix.patch
  v4l: tuner fix

v4l-msp3400-update.patch
  v4l: msp3400 update

v4l-pv951-remote-support.patch
  v4l: add support for pv951 remote to ir-kbd-i2c

v4l-saa7134-update.patch
  v4l: saa7134 driver update

v4l-saa7134-update-fix.patch
  v4l-saa7134-update fix

v4l-bttv-update.patch
  v4l: bttv driver update

v4l-doc-update.patch
  v4l: documentation update

v4l-cx88-update.patch
  cx88 update.

drivers-base-platform-tpyo-fix.patch
  drivers/base/platform.c typo fix

nfs-readdirplus-overflow-fix.patch
  Subject: [PATCH] Fix overflow bug in READDIRPLUS...

nfs-32bit-statfs-fix.patch
  Fix 32bit statfs on NFS

nfs-32bit-statfs-fix-warning-fix.patch
  nfs-32bit-statfs-fix warning fix

wavefront_synth-unused-var.patch
  wavefront_synth.c var not used.

tda1004x-unused-var.patch
  tda1004x.c var not used.

pmdisk-needs-asmlinkage.patch
  pmdisk needs asmlinkage

cycx_drv-warning-fix.patch
  cycx_drv.c warning fix.

ibmlana-needs-MCA_LEGACY.patch
  ibmlana needs CONFIG_MCA_LEGACY

rcu_list-documentation.patch
  Improve list.h documentation for _rcu() primitives

list-inline-cleanup.patch
  list.h cleanup

noexec-stack.patch
  Non-Exec stack support

ext3-transaction-batching-fix.patch
  Fix ext3 transaction batching

reiserfs-nesting-02.patch
  reiserfs: support for nested transactions

reiserfs-journal-writer.patch
  reiserfs: cleanups

reiserfs-logging.patch
  reiserfs: logging rework

reiserfs-jh-2.patch
  reiserfs: data=ordered support

reiserfs-end-trans-bkl.patch
  reiserfs: locking fix

reiserfs-prealloc.patch
  reiserfs: preallocation support

reiserfs-tail-jh.patch
  reiserfs: tail repacking fix

reiserfs-writepage-ordered-race.patch
  reiserfs: fix race with writepage

reiserfs-file_write_hole_sd.diff.patch
  reiserfs: sparse file handling fix

reiserfs-laptop-mode.patch
  reiserfs: laptop-mode support

reiserfs-truncate-leak.patch
  reiserfs: truncate leak fix

reiserfs-ordered-lat.patch
  reiserfs: scheduling latency improvements

reiserfs-dirty-warning.patch
  reiserfs: fix dirty-buffer warnings

reiserfs_kfree-warning-fix.patch
  reiserfs_kfree warning fix

reiserfs-writepage-race-fix.patch
  reiserfs writepage race with data=ordered

selinux-ipv6-support.patch
  selinux: add IPv6 support

selinux-remove-duplicate-assignment.patch
  From: James Morris <jmorris@redhat.com>
  Subject: [SELINUX] 2/2 Remove duplicate assignment

lightweight-auditing-framework.patch
  Light-weight Auditing Framework
  Light-weight Auditing Framework update
  lightweight-auditing-framework warning fixes
  Light-weight Auditing Framework receive filter fixes
  lightweight-auditing-framework-receive-filter-fixes compile fix

lightweight-auditing-framework-ipv6-support.patch
  selinux: make IPv6 code work with audit framework

selinux-compute_sid-fixes.patch
  selinux: Audit compute_sid errors

selinux-remove-ratelimit.patch
  selinux: remove ratelimit from avc

mixart-build-fix.patch
  CONFIG_SND_MIXART doesn't compile

unmap_vmas-latency-improvement.patch
  unmap_vmas latency improvement

i386-head_S-cleanups.patch
  more i386 head.S cleanups

intermezzo-leak-fixes.patch
  intermezzo leak fixes

es1688-define-fix.patch
  es1688 Definition redundancy

load_elf_binary-overflow-detection-fix.patch
  binfmt_elf.c fix for 32-bit apps with large bss

stack-reductions-ide-cd.patch
  stack reduction: ide-cd

stack-reductions-ide.patch
  stack reductions: ide

stack-reductions-isdn.patch
  stack reduction: ISDN

use-EFLAGS_defines.patch
  use EFLAGS #defines instead of inline constants

h8300-ptrace-fix.patch
  From: Yoshinori Sato <ysato@users.sourceforge.jp>
  Subject: [PATCH] H8/300 support update (1/3) - ptrace fix

h8300-entry_s-cleanup.patch
  From: Yoshinori Sato <ysato@users.sourceforge.jp>
  Subject: [PATCH] H8/300 support update (2/3) - entry.S cleanup

h8300-others.patch
  From: Yoshinori Sato <ysato@users.sourceforge.jp>
  Subject: [PATCH] H8/300 support update (3/3) - others

h8300-support-update.patch
  From: Yoshinori Sato <ysato@users.sourceforge.jp>
  Subject: [PATCH] H8/300 support update

sh-sci-build-fix.patch
  sh-sci compile error fix patch

posix-timers-thread.patch
  fix posix-timers to have proper per-process scope

v850-bitop-volatiles.patch
  v850: use volatile qualifier on v850 test-n-bitop asm statements

v850-dma-mapping-fix.patch
  v850: make v850 dma-mapping.h header work when !CONFIG_PCI

m68knommu-dma-mapping.patch
  m68knommu: create dma-mapping.h

m68knommu-kernel_thread-fix.patch
  m68knommu: fix kernel_thread()

m68knommu-kconfig-cleanup.patch
  m68knommu: Kconfig cleanup

m68knommu-comempci-printk-cleanup.patch
  m68knommu: comempci.c printk cleanup

m68knommu-coherent-dma-allocation.patch
  m68knommu: coherent dma allocation

m68knommu-build-dmac.patch
  m68knommu: build dma.c

cleanup-m68knommu-setupc-printk-and-irqreturn_t.patch
  m68knommu cleanup setup.c (printk and irqreturn_t)

cleanup-m68knommu-trapsc-printk-and-dump_stack.patch
  m68knommu cleanup traps.c (printk and dump_stack)

platform-additions-in-m68knommu-linker-script.patch
  m68knommu: platform additions in linker script

fix-gcc-cpu-define-for-m68knommu-coldfire.patch
  m68knommu/coldfire: fix gcc cpu define

add-senTec-vendor-support-to-m68knommu-Makefile.patch
  m68knommu: add senTec vendor support to Makefile

m68knommu-faultc-printk-cleanup.patch
  m68knommu: fault.c printk cleanup

m68knommu-mm-initc-printk-cleanup.patch
  m68knommu: mm/init.c printk cleanup

m68knommu-ColdFire-base-DMA-addresses.patch
  m68knommu/ColdFire base DMA addresses

m68knommu-timersc-printk-cleanup.patch
  m68knommu: timers.c printk cleanup

missing-n-in-timer_tscc.patch
  missing n in timer_tsc.c

hugetlb-consolidation.patch
  hugetlb consolidation

s390-1-12-core-s390.patch
  s390: core s390

s390-2-12-common-i-o-layer.patch
  s390: common i/o layer

s390-3-12-tape-driver-fixes.patch
  s390: tape driver fixes

s390-4-12-dasd-driver-fix.patch
  s390: dasd driver fix

s390-5-12-network-driver-fixes.patch
  s390: network driver fixes

s390-6-12-dcss-block-driver-fix.patch
  s390: dcss block driver fix

s390-7-12-zfcp-fixes-without-kfree-hack.patch
  s390: zfcp fixes (without kfree hack)

s390-8-12-zfcp-log-messages-part-1.patch
  s390: zfcp log messages part 1

s390-9-12-zfcp-log-messages-part-2.patch
  s390: zfcp log messages part 2

s390-10-12-crypto-device-driver-part-1.patch
  s390: crypto device driver part 1

s390-11-12-crypto-device-driver-part-2.patch
  s390: crypto device driver part 2

s390-12-12-rewritten-qeth-driver.patch
  s390: rewritten qeth driver

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

swap_writepage-BIO_RW_SYNC.patch
  Use BIO_RW_SYNC in swap write page

md-unplug-update.patch
  unplugging: md update

correct-unplugs-on-nr_queued.patch
  Correct unplugs on nr_queued

correct-unplugs-on-nr_queued-remove-warnings.patch
  correct-unplugs-on-nr_queued-remove-warnings

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

rmap-1-linux-rmaph.patch
  rmap 1 linux/rmap.h

rmap-2-anon-and-swapcache.patch
  rmap 2 anon and swapcache

rmap-3-arches--mapping_mapped.patch
  rmap 3 arches + mapping_mapped

mc.patch
  Add -mcN to EXTRAVERSION



