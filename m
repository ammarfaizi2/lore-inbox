Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUDKDHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 23:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUDKDHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 23:07:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:26789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262215AbUDKDGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 23:06:05 -0400
Date: Sat, 10 Apr 2004 20:05:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mm4
Message-Id: <20040410200551.31866667.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm4/

- Added the DRM development tree to -mm kernel.  Please Cc
  dri-devel@lists.sourceforge.net on any bug reports.

- Mainly small fixes



Changes since 2.6.5-mm3:


 bk-alsa.patch
 bk-arm.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-i2c.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-libata.patch
 bk-netdev.patch
 bk-pci.patch
 bk-pcmcia.patch
 bk-scsi.patch
 bk-serial.patch
 bk-usb.patch
 bk-agpgart.patch
 bk-cpufreq.patch

 External trees

-sbp2-build-fix.patch
-i2c-ali1563-section-fix.patch
-8250-resource-management-fix.patch

 Merged

+netpoll-early-arp-handling.patch
+netpoll-transmit-busy-bugfix.patch

 netpoll fixes

+kgdb-x86_64-warning-fixes.patch

 Fix a warning in the kgdb-for-x86_64 code

-CONFIG_SYSFS-boot-from-disk-fix.patch

 Folded into CONFIG_SYSFS.patch

-DRM-cvs-update.patch
-drm-include-fix.patch

 Dropped - -m now includes the DRM BK tree

+x86_64-probe_roms-c89.patch

 x86_64 ROM probing fixes/cleanup

+sctp-printk-warnings.patch
+atm-warning-fixes.patch
+firestream-warnings.patch
+cpufreq_userspace-warning.patch

 Fix warnings

+compute-creds-race-fix.patch
+compute-creds-race-fix-fix.patch

 Fix possible race in permission calculation across exec()

+rndis-fix.patch

 USB gadget fix

+sir_dev-warnings.patch
+donauboe-ptr-fix.patch
+strip-warnings.patch
+pc300_drv-warnings.patch
+strip-warnings-2.patch

 More warnings

+sk_mca-multicast-fix.patch

 net driver multicast fix

+kstrdup-and-friends.patch

 Add long-missing string functions

+call_usermodehelper_async.patch

 Fully async call_usermodehelper() workalike.

+get_files_struct.patch

 Code consolidation

+fix-acer-travelmate-360-interrupt-routing.patch

 laptop quirks

+shrink-hash-sizes-on-small-machines-take-2.patch

 More accurate sizing of the VFS caches.





All 538 patches


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

ppc64-move-epow-log-buffer-to-bss.patch
  ppc64: Move EPOW log buffer to BSS

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

more-fixups-for-compat_mq.patch
  More fixups for compat_mq

compat_mq-ppc-fix.patch
  compat_mq ppc64 fix

compat_mq-fix.patch
  compat_mq fix

mq-timespec-checking-fix.patch
  mq: only fail with invalid timespec if mq_timed{send,receive} needs to block

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

msi-ia64.patch
  ia64 MSI support

msi-ia64-x86_64-fix.patch
  msi-ia64 x86_64 fix

ia32-msi-fixup.patch
  Fix MSI os ia32

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

auto-size-dram-on-motorola-5272-coldfire-board.patch
  m68knommu: auto-size DRAM on Motorola/5272 ColdFire board

add-start-code-for-cobra5272-board.patch
  m68knommu: add start code for COBRA5272 board

use-irqreturn_t-in-coldfire-5282-setup-code.patch
  m68knommu: use irqreturn_t in ColdFire 5282 setup code

add-start-code-for-cobra5282-board.patch
  m68knommu: add start code for COBRA5282 board

cleanup-coldfire-5307-ints-code.patch
  m68knommu: cleanup ColdFire/5307 ints code

use-irqreturn_t-in-coldfire-5307-setup-code.patch
  m68knommu: use irqreturn_t in ColdFire 5307 setup code

m68knommu-mm-5307-vectorsc-printk-cleanup.patch
  m68knommu: mm/5307/vectors.c printk cleanup

conditional-romfs-copy-for-5407-cleopatra-board.patch
  m68knommu: conditional ROMfs copy for 5407 CLEOPATRA board

68360-commprocc-printk-cleanup.patch
  m68knommu: 68360 commproc.c printk cleanup

68360-configc-printk-cleanup.patch
  m68knommu: 68360 config.c printk cleanup

68ez328-configc-printk-cleanup.patch
  m68knommu: 68EZ328 config.c printk cleanup

use-irqreturn_t-in-coldfire-5407-setup-code.patch
  68knommu: use irqreturn_t in ColdFire 5407 setup code

use-irqreturn_t-in-motorola-68328-setup-code.patch
  68knommu: use irqreturn_t in Motorola 68328 setup code

cleanup-motorola-68328-ints-code.patch
  68knommu: cleanup Motorola 68328 ints code

cleanup-motorola-68360-ints-code.patch
  68knommu: cleanup Motorola 68360 ints code

mk68knommu-dragonengine-setup-code-printk-cleanup.patch
  68knommu: mk68knommu DragonEngine setup code printk cleanup

cleanup-startup-code-for-68ez328-dragonengine-board.patch
  68knommu: cleanup startup code for 68EZ328 DragonEngine board

68ez328-ucdimm-setup-code-printk-cleanup.patch
  68knommu: 68EZ328/ucdimm setup code printk cleanup

add-support-for-64mhz-clock-for-coldfire-boards.patch
  68knommu: add support for 64MHz clock for ColdFire boards

missing-n-in-timer_tscc.patch
  missing n in timer_tsc.c

hugetlb-consolidation.patch
  hugetlb consolidation

hugetlb-consolidation-highmem-fix.patch
  mc3 hugetlb buildfix

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

rw_swap_page_sync-fixes.patch
  rw_swap_page_sync fixes

rmap-3-arches--mapping_mapped.patch
  rmap 3 arches + mapping_mapped

rename-page_to_nodenum.patch
  rename page_to_nodenum()

alpha-fix-unaligned-stxncpy-again.patch
  alpha: fix unaligned stxncpy again

cyclades-works-on-smp.patch
  cyclades works OK on SMP

dnotify_parent-speedup.patch
  dnotify_parent speedup

floppy_format_265.patch
  Feed floppy.c through Lindent

jbd-do_get_write_access-lock-contention-reduction.patch
  jbd: do_get_write_access lock contention reduction

jbd-b_transaction-zeroing-cleanup.patch
  jbd: b_transaction zeroing cleanup

probe_roms-01-move-stuff.patch
  i386 probe_roms(): preparation

probe_roms-02-fixes.patch
  i386 probe_roms(): fixes

swsusp-update.patch
  swsusp update: supports discontingmem/highmem

swsusp-highmem-fixes.patch
  swsusp update: supports discontingmem/highmem fixes

swsusp-dont-start-stopped-processes.patch
  Swsusp should not wake up stopped processes

mandocs_params-007.patch
  Correct kernel-doc comment with incorrect parameters documented

get_user_pages-shortcut.patch
  get_user_pages shortcut for anonymous pages

isicom-jiffies-fix.patch
  isicom.c: jiffies must be unsigned long

isicom-unused-vars.patch
  isicom.c: unused vars

parport-dependency-fix.patch
  parport dependency fix

dvd-dependency-fix.patch
  DVB dependency fix

isicom-error-path-fix.patch
  isicom error path fix

QD65xx-io-ports-fix.patch
  QD65xx I/O ports fix

parportbook-build-fix.patch
  Fix parportbook build again

saa7134-asus-tv-fm-inputs.patch
  saa7134 - Add two inputs for Asus TV FM

pdaudiocf-build-fix.patch
  pdaudiocf.c needs init.h

dont-offer-gen_rtc-on-ia64.patch
  don't offer GEN_RTC on ia64

remove_concat_FUNCTION_arch.patch
  remove concatenation with __FUNCTION__ arch/*

remove_concat_FUNCTION_drivers.patch
  remove concatenation with __FUNCTION__ drivers/*

remove_concat_FUNCTION_include.patch
  remove concatenation with __FUNCTION__ include/*

remove_concat_FUNCTION_sound.patch
  remove concatenation with __FUNCTION__ sound/*

raid56-masking-fix.patch
  Fix Raid5/6 above 2 Terabytes

ibmasm-dependency-fix.patch
  make ibmasm driver uart support depend on SERIAL_8250

bitop-comment-fix.patch
  fix test_and_change_bit comment

ext2-alternate-sb-mount-fix.patch
  ext2fs sb= mount option fix

ext3-alternate-sb-mount-fix.patch
  ext3fs sb= mount option fix

zoran-overflow-fix.patch
  fix for potential integer overflow in zoran driver

mdacon-warning-fix.patch
  mdacon.c warning fix.

do_fork-error-path-memory-leak.patch
  do_fork() error path memory leak

Fix-More-Problems-Introduced-By-Module-Structure-Added-in-modpostc.patch
  Fix More Problems Introduced By Module Structure Added in modpost.c

Rename-bitmap_clear-to-bitmap_zero-remove-CLEAR_BITMAP.patch
  Rename bitmap_clear to bitmap_zero, remove CLEAR_BITMAP

i2c-dev-warning-fixes.patch
  i2c-dev warning fixes

policydb-printk-warnings.patch
  policydb printk warnings

applicom-warnings.patch
  applicom warnings and usercopy-in-cli fix

tpqic02-warnings.patch
  tpqic02 warnings

acct-oops-fix.patch
  BSD accounting oops fix

framebuffer-bugfix.patch
  framebuffer bugfix

updated-fbmem-patch.patch
  fb_copy_cmap() fix

make-%docs-depend-on-scripts_basic.patch
  Make %docs depend on scripts_basic

kbuild-cleaning-in-three-steps.patch
  kbuild: cleaning in three steps

kbuild-external-module-support.patch
  kbuild: external module support

parport-no-procfs-warning-fix.patch
  parport: no procfs warning fix

CONFIG_SYSFS.patch
  Add CONFIG_SYSFS

jbd-BH_Revoke-cleanup.patch
  JBD: BH_Revoke cleanup

cciss-proc-fix.patch
  cciss: /proc fix

cciss_scsi-warning.patch
  cciss_scsi warning

pmdisk-is-x86-only.patch
  pmdisk is x86 only

mc.patch
  Add -mcN to EXTRAVERSION

bk-alsa.patch

bk-arm.patch

bk-driver-core.patch

bk-drm.patch

bk-i2c.patch

bk-ieee1394.patch

bk-input.patch

bk-libata.patch

bk-netdev.patch

bk-pci.patch

bk-pcmcia.patch

bk-scsi.patch

bk-serial.patch

bk-usb.patch

bk-agpgart.patch

bk-cpufreq.patch

mm.patch
  add -mmN to EXTRAVERSION

r8169-warning-fix.patch
  r8169 warning fix

netpoll-early-arp-handling.patch
  netpoll early ARP handling

netpoll-transmit-busy-bugfix.patch
  netpoll transmit busy bugfix

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

kgdb-x86_64-warning-fixes.patch
  kgdb-x86_64-warning-fixes

wchan-use-ELF-sections-kgdb-fix.patch
  wchan-use-ELF-sections-kgdb-fix

kgdb-THREAD_SIZE-fixes.patch
  THREAD_SIZE fixes for kgdb

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-reloc_hide.patch

ext3-journalled-quotas.patch
  Journalled quota patch

ext3-journalled-quotas-export.patch
  ext3-journalled-quotas export

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

local_bh_enable-warning-fix.patch

nfs-01-prepare_nfspage.patch
  Subject: [PATCH] Prepare NFS asynchronous read/write structures for 	rsize/wsize < PAGE_SIZE

nfs-02-small_rsize.patch
  Subject: [PATCH] Add asynchronous read support for rsize<PAGE_SIZE

nfs-02-small_rsize-warning-fixes.patch
  Fix nfs-02-small_rsize ppc64 warnings

nfs-03-small_wsize.patch
  nfs: Add asynchronous write support for wsize<PAGE_SIZE

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

nfsv4-updates.patch
  nfsv4 updates

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c

sched-run_list-cleanup.patch
  small scheduler cleanup

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

sched-find-busiest-fix.patch
  sched-find-busiest-fix

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

sched-trivial.patch
  sched: trivial fixes, cleanups

sched-misc-fixes.patch
  sched: misc fixes

sched-wakebalance-fixes.patch
  sched: wakeup balancing fixes

sched-imbalance-fix.patch
  sched: fix imbalance calculations

sched-altix-tune1.patch
  sched: altix tuning

sched-fix-activelb.patch
  sched: oops fix

ppc64-sched-domain-support.patch
  ppc64: sched-domain support

sched-domain-setup-lock.patch
  sched: fix setup races

ppc64-sched_domains-fix.patch
  ppc64-sched_domains-fix

sched-domain-setup-lock-ppc64-fix.patch

sched-minor-cleanups.patch
  sched: minor cleanups

sched-inline-removals.patch
  sched: uninlinings

sched-move-cold-task.patch
  sched: move cold task in mysteriouis ways

sched-migrate-shortcut.patch
  sched: add migration shortcut

sched-more-sync-wakeups.patch
  sched: extend sync wakeups

sched-boot-fix.patch
  sched: lock cpu_attach_domain for hotplug

sched-cleanups.patch
  sched: cleanups

sched-damp-passive-balance.patch
  sched: passive balancing damping

sched-cpu-load-cleanup.patch
  sched: cpu load management cleanup

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

siimage-update.patch
  ide: update for siimage driver

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

devinet-ctl_table-fix.patch
  devinet_ctl_table[] null termination

idr-extra-features.patch
  idr.c: extra features enhancements

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

jgarzik-warnings.patch

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

signal-race-fix.patch
  signal handling race fix

signal-race-fix-ia64.patch
  signal-race-fix: ia64

signal-race-fix-s390.patch
  signal-race fixes for s390

signal-race-fix-x86_64.patch
  signal-race-fixes: x86-64 support

signal-race-fixes-ppc.patch
  signal-race fixes for ppc32 and ppc64

warn-on-mdelay-in-irq-handlers.patch
  Warn on mdelay() in irq handlers

stack-reductions-nfsread.patch
  stack reductions: nfs read

stack-reductions-nfsroot.patch
  stack reductions: nfs root

x86_64-probe_roms-c89.patch
  x86_64: probe_roms()

speed-up-sata.patch
  speed up SATA

yenta-TI-irq-routing-fix.patch
  yenta: interrupt routing for TI briges

advansys-fix.patch
  advansys check_region() fix

pnp-updates.patch
  PnP Updates for 2.6.5-rc3-mm4 (testing)

aic7xxx-unload-fix.patch
  aic7xxx: fix oops whe hardware is not present
  aic7xxx-unload-fix-fix

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

nfs-O_DIRECT-fixes.patch
  NFS: O_DIRECT fixes

aic7xxx-swsusp-support.patch
  support swsusp for aic7xxx

reiserfs-commit-default.patch
  Add "commit=0" to reiserfs

xfs-laptop-mode.patch
  Laptop mode support for XFS

xfs-laptop-mode-syncd-synchronization.patch
  Synchronize XFS sync daemon with laptop mode syncs.

vmscan-less-sleepiness.patch
  vmscan: Fix up the determination of when to throttle

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

reslabify-pgds-and-pmds-2.patch

jbd-journal_dirty_metadata-locking-speedup.patch
  jbd: journal_dirty_metadata locking speedup

0-autofs4-2.6.0-signal-20040405.patch
  autofs: dnotify + autofs may create signal/restart syscall loop

1-autofs4-2.6.4-cleanup-20040405.patch
  autofs: printk cleanups

2-autofs4-2.6.4-fill_super-20040405.patch

3-autofs4-2.6.0-bkl-20040405.patch
  autofs: locking rework

4-autofs4-2.6.0-expire-20040405.patch
  autofs: expiry refcount fixes

5-autofs4-2.6.0-readdir-20040405.patch
  autofs: readdir fixes

6-autofs4-2.6.0-may_umount-20040405.patch
  autofs: add ioctl to query unmountability

7-autofs4-2.6.0-extra-20040405.patch
  autofs: readdir futureproofing

cciss-logical-device-queues.patch
  cciss: per logical device queues

numa-api-x86_64.patch
  numa api: -64 support

numa-api-bitmap-fix.patch
  numa api: Bitmap bugfix

numa-api-i386.patch
  numa api: Add i386 support

numa-api-ia64.patch
  numa api: Add IA64 support

numa-api-core.patch
  numa api: Core NUMA API code

numa-api-core-tweaks.patch
  numa-api-core-tweaks

numa-api-core-bitmap_clear-fixes.patch
  numa-api-core bitmap_clear fixes

numa-api-vma-policy-hooks.patch
  numa api: Add VMA hooks for policy

numa-api-vma-policy-hooks-fix.patch
  numa-api-vma-policy-hooks fix

numa-api-shared-memory-support.patch
  numa api: Add shared memory support

numa-api-shared-memory-support-tweaks.patch
  numa-api-shared-memory-support-tweaks

numa-api-statistics.patch
  numa api: Add statistics

numa-api-anon-memory-policy.patch
  numa api: Add policy support to anonymous  memory

sk98lin-buggy-vpd-workaround.patch
  net/sk98lin: correct buggy VPD in ASUS MB
  skvpd-build-fix

kNFSdv4-4-of-10-nfsd4_readdir-fixes.patch
  kNFSdv4: nfsd4_readdir fixes

nfsd4_readdir-build-fix.patch
  nfsd4_readdir build fix

kNFSdv4-5-of-10-Fix-bad-error-returm-from-svcauth_gss_accept.patch
  kNFSdv4: Fix bad error returm from svcauth_gss_accept

kNFSdv4-6-of-10-Keep-state-to-allow-replays-for-close-to-work.patch
  kNFSdv4: Keep state to allow replays for 'close' to work.

nfsd_list_cleanup.patch
  Subject: Re: [PATCH] kNFSdv4 - 6 of 10 - Keep state to allow replays for 'close' to work.

kNFSdv4-7-of-10-Allow-locku-replays-aswell.patch
  kNFSdv4: Allow locku replays aswell

kNFSdv4-8-of-10-Improve-how-locking-copes-with-replays.patch
  kNFSdv4: Improve how locking copes with replays

kNFSdv4-9-of-10-Set-credentials-properly-when-puutrootfh-is-used.patch
  kNFSdv4: Set credentials properly when puutrootfh is used

kNFSdv4-10-of-10-Implement-server-side-reboot-recovery-mostly.patch
  kNFSdv4: Implement server-side reboot recovery (mostly)

Oprofile-ARM-XScale-PMU-driver.patch
  Oprofile: ARM/XScale PMU driver

unplug-can-sleep.patch
  unplug functions can sleep

fix-load_elf_binary-error-path-on-unshare_files-error.patch
  fix load_elf_binary error path on unshare_files error

sctp-printk-warnings.patch
  sctp printk warnings

atm-warning-fixes.patch
  atm warning fixes

firestream-warnings.patch
  firestream warnings

cpufreq_userspace-warning.patch
  cpufreq_userspace warning

compute-creds-race-fix.patch
  compute_creds race

compute-creds-race-fix-fix.patch
  compute-creds-race-fix-fix

rndis-fix.patch
  usb/gadget/rndis.c fix

sir_dev-warnings.patch
  sir_dev.c warnings

donauboe-ptr-fix.patch
  donauboe.c 32-bit pointer fix

strip-warnings.patch
  drivers/net/wireless/strip.c warnings

pc300_drv-warnings.patch
  pc300_drv-warnings

strip-warnings-2.patch
  strip.c warnings

sk_mca-multicast-fix.patch
  sk_mca multicast fix

kstrdup-and-friends.patch
  add string replication functions

call_usermodehelper_async.patch
  Add call_usermodehelper_async

get_files_struct.patch
  get_files_struct cleanup

fix-acer-travelmate-360-interrupt-routing.patch
  fix Acer TravelMate 360 interrupt routing

shrink-hash-sizes-on-small-machines-take-2.patch
  shrink VFS hash sizes on small machines



