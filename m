Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTEMFlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTEMFlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:41:32 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:13695 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262941AbTEMFlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:41:17 -0400
Date: Mon, 12 May 2003 22:55:04 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.69-mm4
Message-Id: <20030512225504.4baca409.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 05:53:57.0239 (UTC) FILETIME=[0B13C070:01C31914]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm4/


Lots of small things.



Changes since 2.5.69-mm3:


-netfilter-skbuff-fix.patch
-nfs-writeback-tweak.patch
-rq-dyn-works.patch

 Merged

+SLAB_STORE_USER-larger-objects.patch

 Enable full slab debug for larger slabs.

+remove-verify_write-leftovers.patch

 Cleanup/build fix

+module_arch_cleanup-2.patch

 modules cleanup

+remove-devfs_register.patch

 Remvoe devfs_register()

+pnp-irqreturn-fix.patch

 IRQ fix

+vma-merging-missing-fput.patch

 VMA merging fip leak fix

+cpufreq-commented-out-code-bogon.patch

 cpufreq fix

+small-cleanup-for-__rmqueue.patch

 Cleanups

+cpufreq-oops-fix.patch

 Odd oops fix

+netif_receive_skb-warning-fix.patch

 Nail a warning

+misc.patch

 Little stuff

+large-dma_addr_t-PAE-only.patch

 dma_addr_t need not be 64-bit on CONFIG_HIGHMEM4G

+bump-module-ref-during-init.patch

 Modules race fix

+put_dirty_page-protection-fix.patch

 Stack segment page protection fix

+dcache_lock-vs-tasklist_lock-take-3.patch

 New version of this lock ranking bugfix

+hugetlbpage-extern-fix.patch

 Warning fixes/cleanups

+emergency-sync-printk.patch

 Print messages when emergency sync and emergency remount complete.

+clear-smi-fix.patch

 SMI/APCI fix

+inode-unhashing-fix-2.patch

 Fix an inode lookup race (needs work, probabaly)

+reserve-lustre-EAs.patch

 Reserve the Lustre extended attribute ID's

+setfont-loadkeys-fix.patch

 Propagate console ioctls across all VT's

+sched_best_cpu_fix-4.patch

 Numa scheduler fix fix fix

+spinlock-debugging-improvement.patch

 Enhance uniproc spinlock debugging

-pcmcia-deadlock-fix-2.patch
-pcmcia-fix.patch
+pcmcia-deadlock-fix-3.patch

 Updated

-kexec.patch
+reboot_on_bsp.patch
+apic_shutdown.patch
+i8259-shutdown.patch
+hwfixes-x86kexec.patch

Split up

+v4l-1.patch
+v4l-2.patch
+v4l-3.patch
+v4l-4.patch
+v4l-5.patch
+v4l-6.patch
+v4l-7.patch

 Video-4-Linux update

+checker-1.patch

 Thirteen Stanford checker memleak fixes

+mtrr-not-used-fix.patch

 Prevent bogus mtrr printk




All 135 patches


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

SLAB_STORE_USER-larger-objects.patch
  enable slab debugging for larger objects

remove-verify_write-leftovers.patch
  Remove __verify_write leftovers

ipmi-warning-fixes.patch

irqreturn-uml.patch
  UML updates for the new IRQ API

irqreturn-aic79xx.patch
  Fix aic79xx for new IRQ API

irqreturn-drivers-net.patch

slab-magazine-layer.patch
  magazine layer for slab

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-ioctl-pci-update.patch
  From: Anton Blanchard <anton@samba.org>
  Subject: ppc64 stuff

ppc64-reloc_hide.patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

ppc64-xics-irq-fix.patch
  PPC64 irq return fix

sym-do-160.patch
  make the SYM driver do 160 MB/sec

hrtimers-fix-signone.patch
  hrtimers: fix timer_create(2) && SIGEV_NONE

module_arch_cleanup-2.patch
  module_arch_cleanup()

remove-devfs_register.patch
  remove devfs_register

pnp-irqreturn-fix.patch
  fix pnp_test_handler return

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

irq_cpustat-cleanup.patch
  irq_cpustat cleanup

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

fat-speedup.patch
  fat cluster search speedup

vma-merging-missing-fput.patch
  Subject: [PATCH] Fix for vma merging refcounting bug

cpufreq-commented-out-code-bogon.patch
  Commented out printk causes change in program flow in cpufreq/p4-clockmod.c

small-cleanup-for-__rmqueue.patch
  small cleanup for __rmqueue

cpufreq-oops-fix.patch
  export cpufreq_driver to fix oops in proc interface

netif_receive_skb-warning-fix.patch
  netif_receive_skb() warning fix

misc.patch
  Misc fixes

large-dma_addr_t-PAE-only.patch
  64-bit dma_addr_t is only needed with PAE

irq-check-rate-limit.patch
  IRQs: handle bad return values from handlers

irq_desc-others.patch
  Fix up irq_desc initialisation for non-ia32

ext3-quota-reservation-fix.patch
  Quota write transaction size fix

quota-reference-drop-fix.patch
  dquot_transfer() fix

bump-module-ref-during-init.patch
  Bump module ref during init.

put_dirty_page-protection-fix.patch

dcache_lock-vs-tasklist_lock-take-3.patch
  Fix dcache_lock/tasklist_lock ranking bug

hugetlbpage-extern-fix.patch
  fix hugetlbpage scoping

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

3c59x-irq-fix.patch

VM_RESERVED-check.patch
  VM_RESERVED check

exit_mmap-TASK_SIZE.patch
  exit_mmap() TASK_SIZE fix

semop-race-fix-2.patch
  semop race fix #2

reiserfs_file_write-5.patch

visws-logo-fix.patch
  visws: fix penguin with sgi logo

clustered-io_apic-fix.patch
  Subject: [RFC][PATCH] fix for clusterd io_apics

emergency-sync-printk.patch
  provide user feedback for emergency sync and remount

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

ide_setting_sem-fix.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

nfs-speedup.patch

nfs-oom-fix.patch
  nfs oom fix

sk-allocation.patch
  Subject: Re: nfs oom

nfs-more-oom-fix.patch

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations

linux-isp.patch

isp-update-1.patch

clone-retval-fix.patch
  copy_process return value fix

de_thread-fix.patch
  de_thread memory corruption fix

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

vmalloc-race-fix.patch
  vmalloc race fix

clear-smi-fix.patch
  Subject: [PATCH] linux-2.5.69_clear-smi-fix_A1

inode-unhashing-fix-2.patch
  Don't remove inode from hash until filesystem has deleted it

reserve-lustre-EAs.patch
  Reserve the ext2/ext3 EAs for the Lustre filesystem

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler

as-use-completion.patch
  AS use completion notifier

as-remove-debug-checks.patch
  AS: remove debug checks

as-iosched-dyn.patch
  AS: update to dynamic request allocation API

as-monitor-seek-distance.patch
  AS: monitor seek distance

as-div64-fix.patch
  as: don't do 64-bit divides

as-small-hashes.patch
  AS: smaller hashes

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2

cfq-iosched-dyn.patch
  CFQ: update to rq-dyn API

unmap-page-debugging.patch
  unmap unused pages for debugging

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

sched-2.5.68-B2.patch
  HT scheduler, sched-2.5.68-B2

sched-numa-warning-fix.patch
  scheduler warning fix for NUMA

sched_idle-typo-fix.patch
  fix sched_idle typo

kgdb-ga-idle-fix.patch

acpi-irq-ret-fix.patch
  acpi irq return value fix

sound-irq-hack.patch

oprofile-build-fix.patch
  Fix arch/i386/oprofile/init.c build error

setfont-loadkeys-fix.patch
  fix setfont and loadkeys on tty > 1

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

sched_best_cpu-fix.patch
  sched_best_cpu does not pick best cpu

sched_best_cpu-fix-2.patch
  sched_best_cpu does not pick best cpu (2/2)

generic_hweight64-fix.patch

sched_best_cpu_fix-4.patch
  Even more sched_best_cpu fixes

show_task-free-stack-fix.patch
  show_task() fix and cleanup

spinlock-debugging-improvement.patch
  Make debugging variant of spinlocks a bit more robust

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

htree-nfs-fix-2.patch
  htree nfs fix

htree-leak-fix.patch
  ext3: htree memory leak fix

put_task_struct-debug.patch

ia32-mknod64.patch
  mknod64 for ia32

ext2-64-bit-special-inodes.patch
  ext2: support for 64-bit device nodes

ext3-64-bit-special-inodes.patch
  ext3: support for 64-bit device nodes

64-bit-dev_t-kdev_t.patch
  64-bit dev_t and kdev_t

tty-64-bit-dev_t-warning-fix.patch
  tty layer 64-bit dev_t printk warning fix

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

security-process-attribute-api.patch
  Process Attribute API for Security Modules

thread-info-in-task_struct.patch
  allow thread_info to be allocated as part of task_struct

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-orlov-approx-counter-fix.patch
  Fix orlov allocator boundary case

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3

pcmcia-deadlock-fix-3.patch
  Fix PCMCIA deadlock (rev. 2)

reboot_on_bsp.patch

apic_shutdown.patch

i8259-shutdown.patch

hwfixes-x86kexec.patch

fbdev-updates.patch
  Fbdev update patch

v4l-1.patch
  Subject: [patch] v4l: #1 - video-buf update

v4l-2.patch
  Subject: [patch] v4l: #2 - v4l1-compat update

v4l-3.patch
  Subject: [patch] v4l: #3 - bttv driver update

v4l-4.patch
  Subject: [patch] v4l: #4 - bttv docmentation update

v4l-5.patch
  Subject: [patch] v4l: #5 - i2c module updates.

v4l-6.patch
  Subject: [patch] v4l: #6 - tuner module update

v4l-7.patch
  Subject: [patch] v4l: #7 - saa7134 driver update

checker-1.patch

mtrr-not-used-fix.patch
  kernel prints "mtrr: MTRR 2 not used" twice when exiting X




