Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318661AbSICEA3>; Tue, 3 Sep 2002 00:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318691AbSICEA3>; Tue, 3 Sep 2002 00:00:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27911 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318661AbSICEA1>;
	Tue, 3 Sep 2002 00:00:27 -0400
Message-ID: <3D7437AC.74EAE22B@zip.com.au>
Date: Mon, 02 Sep 2002 21:16:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.33-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.33/2.5.33-mm1/


Seven new patches - mostly just code cleanups.

+slablru-speedup.patch

  A patch to improve slablru cpu efficiency.  Ed is
  redoing this.

+oom-fix.patch

  Fix an OOM-killing episode on large highmem machines.

+tlb-cleanup.patch

  Remove debug code from the tlb_gather rework, tidy up a couple of
  things.

+dump-stack.patch

  Arch-independent stack-dumping debug function

+madvise-move.patch

  Move the madvise implementation out of filemap.c into madvise.c

+split-vma.patch

  Rationalise lots of the VMA-manipulation code.

+buffer-ops-move.patch

  Move the buffer_head IO functions out of ll_rw_blk.c, into buffer.c




scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

rmap-locking-move.patch
  move rmap locking inlines into their own header file.

discontig-paddr_to_pfn.patch
  Convert page pointers into pfns for i386 NUMA

discontig-setup_arch.patch
  Rework setup_arch() for i386 NUMA

discontig-mem_init.patch
  Restructure mem_init for i386 NUMA

discontig-i386-numa.patch
  discontigmem support for i386 NUMA

cleanup-mem_map-1.patch
  Clean up lots of open-coded uese of mem_map[].  For ia32 NUMA

zone-pages-reporting.patch
  Fix the boot-time reporting of each zone's available pages

enospc-recovery-fix.patch
  Fix the __block_write_full_page() error path.

fix-faults.patch
  Back out the initial work for atomic copy_*_user()

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

refill-rate.patch
  refill the inactive list more quickly

copy_user_atomic.patch

kmap_atomic_reads.patch
  Use kmap_atomic() for generic_file_read()

kmap_atomic_writes.patch
  Use kmap_atomic() for generic_file_write()

throttling-fix.patch
  Fix throttling of heavy write()rs.

dirty-state-accounting.patch
  Make the global dirty memory accounting more accurate

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

discontig-cleanup-1.patch
  i386 discontigmem coding cleanups

discontig-cleanup-2.patch
  i386 discontigmem cleanups

writeback-thresholds.patch
  Downward adjustments to the default dirtymemory thresholds

buffer-strip.patch
  Limit the consumption of ZONE_NORMAL by buffer_heads

rmap-speedup.patch
  rmap pte_chain space and CPU reductions

wli-highpte.patch
  Resurrect CONFIG_HIGHPTE - ia32 pagetables in highmem

readv-writev.patch
  O_DIRECT support for readv/writev

slablru.patch
  age slab pages on the LRU

slablru-speedup.patch
  slablru optimisations

llzpr.patch
  Reduce scheduling latency across zap_page_range

buffermem.patch
  Resurrect buffermem accounting

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

lpp.patch
  ia32 huge tlb pages

ext3-sb.patch
  u.ext3_sb -> generic_sbp

oom-fix.patch
  Fix an OOM condition on big highmem machines

tlb-cleanup.patch
  Clean up the tlb gather code

dump-stack.patch
  arch-neutral dump_stack() function

madvise-move.patch
  move mdavise implementation into mm/madvise.c

split-vma.patch
  VMA splitting patch

buffer-ops-move.patch
  Move submit_bh() and ll_rw_block() into fs/buffer.c
