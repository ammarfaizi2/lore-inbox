Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUDGFSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 01:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264018AbUDGFSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 01:18:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:23021 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263183AbUDGFRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 01:17:55 -0400
Date: Tue, 6 Apr 2004 22:17:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mc2
Message-Id: <20040406221744.2bd7c7e4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc2/

This tree is the accumulation of things which will be sent to Linus next
week.




Changes since 2.6.5-mc1:


+ppc64-hugepage-fix.patch
+ppc64-hugepage-fix-32.patch
+ppc64-alloc_consistent-retval-fixes.patch
+ppc4xx-memleak-fix.patch

 PPC64 fixes

+use-compound-pages-for-hugetlb-only.patch

 Don't use the compound page logic for higher-order allocations unless the
 caller explicitly requested it.

+laptop-mode-noflushd-warning.patch

 Documentation update

+v4l-cropcap-ioctl-fix.patch
+v4l-v4l1-compat-fix.patch
+v4l-tuner-fix.patch
+v4l-msp3400-update.patch
+v4l-pv951-remote-support.patch
+v4l-saa7134-update.patch
+v4l-saa7134-update-fix.patch
+v4l-bttv-update.patch
+v4l-doc-update.patch
+v4l-cx88-update.patch

 Video drivers udpate

+drivers-base-platform-tpyo-fix.patch

 Fix a typo

+nfs-readdirplus-overflow-fix.patch

 Fix NFS crash

+nfs-32bit-statfs-fix.patch

 Fix statfs() for weird NFS servers

+wavefront_synth-unused-var.patch
+tda1004x-unused-var.patch
+pmdisk-needs-asmlinkage.patch
+cycx_drv-warning-fix.patch
+ibmlana-needs-MCA_LEGACY.patch
+rcu_list-documentation.patch
+list-inline-cleanup.patch

 Various little things

+noexec-stack.patch

 Propagate PT_GNU_STACK

+ext3-transaction-batching-fix.patch

 ext3 sync operation speedup

+reiserfs-nesting-02.patch
+reiserfs-journal-writer.patch
+reiserfs-logging.patch
+reiserfs-jh-2.patch
+reiserfs-end-trans-bkl.patch
+reiserfs-prealloc.patch
+reiserfs-tail-jh.patch
+reiserfs-writepage-ordered-race.patch
+reiserfs-file_write_hole_sd.diff.patch
+reiserfs-laptop-mode.patch
+reiserfs-truncate-leak.patch
+reiserfs-ordered-lat.patch
+reiserfs-dirty-warning.patch
+reiserfs_kfree-warning-fix.patch
+reiserfs-writepage-race-fix.patch

 reiserfs update

+selinux-ipv6-support.patch
+selinux-remove-duplicate-assignment.patch

 selinux support for ipv6

+lightweight-auditing-framework.patch
+lightweight-auditing-framework-ipv6-support.patch
+selinux-compute_sid-fixes.patch
+selinux-remove-ratelimit.patch

 Auditing/syscall tracing framework

+mixart-build-fix.patch

 Compile fix

+unmap_vmas-latency-improvement.patch

 Explicit scheduling points for !CONFIG_PREEMPT

+i386-head_S-cleanups.patch
+intermezzo-leak-fixes.patch
+es1688-define-fix.patch

 Cleanups, fixes

+split-netlink_unicast.patch

 Preparation for message-queue signalling over netlink

+load_elf_binary-overflow-detection-fix.patch

 ELF loader check.

+stack-reductions-ide-cd.patch
+stack-reductions-ide.patch
+stack-reductions-isdn.patch

 Stack space savings

+use-EFLAGS_defines.patch

 Cleanup

+h8300-ptrace-fix.patch
+h8300-entry_s-cleanup.patch
+h8300-others.patch
+sh-sci-build-fix.patch

 h/8300 update




All 207 patches:


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

ppc64-si_addr-fix.patch
  ppc64: si_addr fix

ppc64-hugepage-fix.patch
  ppc64: Fix bug in hugepage support

ppc64-hugepage-fix-32.patch
  ppc64: hugepage bugfix

ppc64-alloc_consistent-retval-fixes.patch
  ppc64: fix failure return codes from {pci,vio}_alloc_consistent()

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

split-netlink_unicast.patch
  split netlink_unicast

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

sh-sci-build-fix.patch
  sh-sci compile error fix patch

mc.patch
  Add -mcN to EXTRAVERSION



