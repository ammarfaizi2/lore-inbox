Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTJOQj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTJOQj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:39:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:11422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263590AbTJOQjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:39:08 -0400
Subject: Re: 2.6.0-test7-mm1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20031015013649.4aebc910.akpm@osdl.org>
References: <20031015013649.4aebc910.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1066235943.3866.19.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 Oct 2003 09:39:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile stats posted at: http://developer.osdl.org/cherry/compile/

This is done for all mm releases now.

John

On Wed, 2003-10-15 at 01:36, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test7/2.6.0-test7-mm1
> 
> Nothing major here; mainly small fixes.
> 
> 
>  linus.patch
> 
>  Latest Linus BK
> 
> -selectable-logbuf-size.patch
> -8139too-edimax.patch
> -futex_refs_and_lock_fix.patch
> -futex-locking-fix-fix.patch
> -node-enumeration-cleanup-01.patch
> -node-enumeration-cleanup-02.patch
> -node-enumeration-cleanup-03.patch
> -node-enumeration-cleanup-04.patch
> -node-enumeration-cleanup-05.patch
> -node-enumeration-cleanup-fix-01.patch
> -compat-ioctl-consolidation.patch
> -compat-ioctl-consolidation-job-control-update.patch
> -alsa-gameport-fix.patch
> -sizeof-in-ioctl-fix.patch
> -ax25-timer-cleanup.patch
> -calc_vm_trans-commentary.patch
> -proc-sys-auxv.patch
> -kernel-doc-fixes.patch
> -kill-CONFIG_EISA_ALWAYS.patch
> -ext3-concurrent-alloc-locking-fix.patch
> -dscc4-fixes.patch
> -cpufreq-sysfs-oops-fix.patch
> -move-job-control-fields.patch
> -move-job-control-fields-ia64-fix.patch
> -do_no_page-pte_chain_leak-fix.patch
> -20-odirect_enable.patch
> -21-odirect_cruft.patch
> -22-read_proc.patch
> -23-write_proc.patch
> -24-commit_proc.patch
> -25-odirect.patch
> -athlon-prefetch-handling.patch
> -athlon-prefetch-handling-fix.patch
> 
>  Merged
> 
> +8139too-poll_controller.patch
> 
>  8139too kgb support.
> 
> -io-refcount-debugging.patch
> 
>  Dropped, too noisy.
> 
> +sjcd-usercopy-checks.patch
> 
>  copy_*_user retval checks.
> 
> +might_sleep-vs-jiffies-wrap.patch
> 
>  might_sleep() was broken by the jiffywrap detector.
> 
> +selinux-add-policyvers.patch
> 
>  SELinux things.
> 
> +mandocs-case-fix.patch
> 
>  Kernel doc generation fix
> 
> +pcibios_test_irq-fix.patch
> 
>  Fix an "unhandled interrupt" problem.
> 
> +fixmap-in-proc-pid-maps.patch
> 
>  Make the special ia32 fixmap area appear in /proc/pid/maps
> 
> +ajdtimex-vs-gettimeofday.patch
> 
>  Stop gettimeofday() from going backwards due to adjtimex activity.
> 
> +i82365-sysfs-ordering-fix.patch
> 
>  Fix an oops due to i82365 sysfs handling
> 
> +swapon-handle-no-readpage.patch
> 
>  Don't swapon files which have no readpage a_op.
> 
> +pci_set_power_state-might-sleep.patch
> 
>  Debug check.
> 
> +reiserfs-url-fixes.patch
> 
>  Documentation update.
> 
> +numaq-mpc-warning-fix.patch
> 
>  NUMAQ compile warning fix
> 
> +invalidate_inodes-speedup.patch
> +invalidate_inodes-speedup-fixes.patch
> 
>  Speed up unmount when there are lots of inodes.
> 
> +ide-piix-fallback-fix.patch
> 
>  Fix PIIX fallback-to-PIO code
> 
> +ext3-i_disksize-locking-fix.patch
> 
>  Missed ext3 locking.
> 
> +applicom-fixes.patch
> 
>  Resource handling fixes
> 
> +compat_ioctl-cleanup.patch
> 
>  Consolidate the compat code.
> 
> +acl-signedness-fix.patch
> 
>  Don't do "if (unsigned < 0)"
> 
> +saa7134-build-fix.patch
> 
>  Fix compile for gcc-2.9x
> 
> +ide-write-barrier-support.patch
> 
>  IDE write barriers
> 
> +jbd-barrier-selection.patch
> 
>  Enable the barrier code in ext3.  Use
> 
> 	mount -o barrier=1
> 	mount -o barrier=0
> 	mount -o remount,barrier=1
> 	mount -o remount,barrier=0
> 
> +scale-min_free_kbytes.patch
> 
>  Scale min_free_kbytes according to machine size.
> 
> +sym-2.1.18f.patch
> 
>  Sym driver update.
> 
> +CONFIG_STANDALONE-default-to-n.patch
> 
>  Make CONFIG_STANDALONE default to "n".
> 
> +nosysfs.patch
> 
>  Add "nosysfs" boot parameter to nobble sysfs, and save some RAM.
> 
> -nfs-O_DIRECT-always-enabled.patch
> 
>  Dropped, it was debug.
> 
> +4g4g-athlon-prefetch-handling-fix.patch
> 
>  Fix 4g/4g for athlon prefetch stuff.
> 
> +4g4g-aio-hang-fix.patch
> 
>  Fix AIO for the 4g/4g split.
> 
> +aio-splice-runlist.patch
> 
>  AIO I/O fairness tweak.
> 
> 
> 
> 
> 
> 
> All 150 patches
> 
> 
> linus.patch
> 
> mm.patch
>   add -mmN to EXTRAVERSION
> 
> kgdb-ga.patch
>   kgdb stub for ia32 (George Anzinger's one)
>   kgdbL warning fix
> 
> kgdb-buff-too-big.patch
>   kgdb buffer overflow fix
> 
> kgdb-warning-fix.patch
>   kgdbL warning fix
> 
> kgdb-build-fix.patch
> 
> kgdb-spinlock-fix.patch
> 
> kgdb-fix-debug-info.patch
>   kgdb: CONFIG_DEBUG_INFO fix
> 
> kgdb-cpumask_t.patch
> 
> kgdb-x86_64-fixes.patch
>   x86_64 fixes
> 
> kgdb-over-ethernet.patch
>   kgdb-over-ethernet patch
> 
> kgdb-over-ethernet-fixes.patch
>   kgdb-over-ethernet fixlets
> 
> kgdb-CONFIG_NET_POLL_CONTROLLER.patch
>   kgdb: replace CONFIG_KGDB with CONFIG_NET_RX_POLL in net drivers
> 
> kgdb-handle-stopped-NICs.patch
>   kgdb: handle netif_stopped NICs
> 
> eepro100-poll-controller.patch
> 
> tlan-poll_controller.patch
> 
> tulip-poll_controller.patch
> 
> tg3-poll_controller.patch
>   kgdb: tg3 poll_controller
> 
> 8139too-poll_controller.patch
>   8139too poll controller
> 
> kgdb-eth-smp-fix.patch
>   kgdb-over-ethernet: fix SMP
> 
> kgdb-eth-reattach.patch
> 
> kgdb-skb_reserve-fix.patch
>   kgdb-over-ethernet: skb_reserve() fix
> 
> must-fix.patch
> 
> should-fix.patch
> 
> RD0-initrd-B6.patch
> 
> RD1-cdrom_ioctl-B6.patch
> 
> RD2-ioctl-B6.patch
> 
> RD2-ioctl-B6-fix.patch
>   RD2-ioctl-B6 fixes
> 
> RD3-cdrom_open-B6.patch
> 
> RD4-open-B6.patch
> 
> RD5-cdrom_release-B6.patch
> 
> RD6-release-B6.patch
> 
> RD7-presto_journal_close-B6.patch
> 
> RD8-f_mapping-B6.patch
> 
> RD9-f_mapping2-B6.patch
> 
> RD10-i_sem-B6.patch
> 
> RD11-f_mapping3-B6.patch
> 
> RD12-generic_osync_inode-B6.patch
> 
> RD13-bd_acquire-B6.patch
> 
> RD14-generic_write_checks-B6.patch
> 
> RD15-I_BDEV-B6.patch
> 
> RD16-rest-B6.patch
> 
> serio-01-renaming.patch
>   serio: rename serio_[un]register_slave_port to __serio_[un]register_port
> 
> serio-02-race-fix.patch
>   serio: possible race between port removal and kseriod
> 
> serio-03-blacklist.patch
>   Add black list to handler<->device matching
> 
> serio-04-synaptics-cleanup.patch
>   Synaptics: code cleanup
> 
> serio-05-reconnect-facility.patch
>   serio: reconnect facility
> 
> serio-06-synaptics-use-reconnect.patch
>   Synaptics: use serio_reconnect
> 
> acpi_off-fix.patch
>   fix acpi=off
> 
> cfq-4.patch
>   CFQ io scheduler
>   CFQ fixes
> 
> config_spinline.patch
>   uninline spinlocks for profiling accuracy.
> 
> ppc64-bar-0-fix.patch
>   Allow PCI BARs that start at 0
> 
> ppc64-reloc_hide.patch
> 
> ppc64-semaphore-reimplementation.patch
>   ppc64: use the ia32 semaphore implementation
> 
> ppc64-sym2-fix.patch
>   ppc64 sym2 fix
> 
> sym-do-160.patch
>   make the SYM driver do 160 MB/sec
> 
> input-use-after-free-checks.patch
>   input layer debug checks
> 
> fbdev.patch
>   framebbuffer driver update
> 
> cursor-flashing-fix.patch
>   fbdev: fix cursor letovers
> 
> radeonfb-line_length-fix.patch
>   Radeon framebuffer line length fix
> 
> aic7xxx-parallel-build-fix.patch
>   fix parallel builds for aic7xxx
> 
> ramdisk-cleanup.patch
> 
> intel8x0-cleanup.patch
>   intel8x0 cleanups
> 
> uml-update.patch
>   Update UML to 2.6.0-test5
> 
> pdflush-diag.patch
> 
> kobject-oops-fixes.patch
>   fix oopses is kobject parent is removed before child
> 
> futex-uninlinings.patch
>   futex uninlining
> 
> zap_page_range-debug.patch
>   zap_page_range() debug
> 
> acpi-thinkpad-fix.patch
>   APCI fix for thinkpads
> 
> scsi-handle-zero-length-requests.patch
>   scsi: handle zero-length requests
> 
> call_usermodehelper-retval-fix-3.patch
>   Make call_usermodehelper report exit status
> 
> asus-L5-fix.patch
>   Asus L5 framebuffer fix
> 
> jffs-use-daemonize.patch
> 
> tulip-NAPI-support.patch
>   tulip NAPI support
> 
> tulip-napi-disable.patch
>   tulip NAPI: disable poll in close
> 
> get_user_pages-handle-VM_IO.patch
> 
> ia32-MSI-support.patch
>   Updated ia32 MSI Patches
> 
> ia32-MSI-support-tweaks.patch
> 
> ia32-efi-support.patch
>   EFI support for ia32
> 
> CONFIG_ACPI_EFI-defaults-off.patch
> 
> ia32-efi-support-warning-fixes.patch
> 
> ia32-efi-support-tidy.patch
> 
> ia32-efi-other-arch-fix.patch
>   fix EFI for ppc64, ia64
> 
> support-zillions-of-scsi-disks.patch
>   support many SCSI disks
> 
> dynamic-irq_vector-allocation.patch
>   dynamic irq_vector allocation for ia32
> 
> SGI-IOC4-IDE-chipset-support.patch
>   Add support for SGI's IOC4 chipset
> 
> vma-split-truncate-race-fix.patch
>   fix split_vma vs. invalidate_mmap_range_list race
> 
> vma-split-truncate-race-fix-tweaks.patch
> 
> sparc32-sched_clock.patch
> 
> unmap_vmas-warning-fix.patch
>   Fix unmap_vmas() compile warning
> 
> sjcd-usercopy-checks.patch
>   Add missing sjcd uaccess checks
> 
> might_sleep-vs-jiffies-wrap.patch
>   Fix early __might_sleep() calls
> 
> selinux-add-policyvers.patch
>   SELINUX: add policyvers to selinuxfs
> 
> mandocs-case-fix.patch
>   Correct case sensitivity in make mandocs
> 
> pcibios_test_irq-fix.patch
>   Fix pcibios test IRQ handler return
> 
> fixmap-in-proc-pid-maps.patch
>   report user-readable fixmap area in /proc/PID/maps
> 
> ajdtimex-vs-gettimeofday.patch
>   Time precision, adjtime(x) vs. gettimeofday
> 
> i82365-sysfs-ordering-fix.patch
>   Fix init_i82365 sysfs ordering oops
> 
> swapon-handle-no-readpage.patch
>   Don't swap to files which do not implement readpage
> 
> pci_set_power_state-might-sleep.patch
> 
> reiserfs-url-fixes.patch
>   reiserfs documentation URL fixes
> 
> numaq-mpc-warning-fix.patch
>   silence smp_read_mpc_oem() declared static but never defined warning
> 
> invalidate_inodes-speedup.patch
>   invalidate_inodes speedup
> 
> invalidate_inodes-speedup-fixes.patch
> 
> ide-piix-fallback-fix.patch
>   IDE: PIIX DMA fallback fix
> 
> ext3-i_disksize-locking-fix.patch
>   ext3: i_disksize locking fix
> 
> applicom-fixes.patch
>   applicom: fix LEAK, unwind on errors;
> 
> compat_ioctl-cleanup.patch
>   cleanup of compat_ioctl functions
> 
> acl-signedness-fix.patch
>   ext2/ext3 acl signeness fixes
> 
> saa7134-build-fix.patch
>   saa7134-core.c compile fix for old gcc
> 
> ide-write-barrier-support.patch
>   ide write barrier support
> 
> jbd-barrier-selection.patch
> 
> scale-min_free_kbytes.patch
>   scale the initial value of min_free_kbytes
> 
> sym-2.1.18f.patch
> 
> CONFIG_STANDALONE-default-to-n.patch
>   Make CONFIG_STANDALONE default to N
> 
> nosysfs.patch
> 
> keyboard-repeat-rate-setting-fix.patch
>   keyboard repeat rate setting fix
> 
> list_del-debug.patch
>   list_del debug check
> 
> print-build-options-on-oops.patch
>   print a few config options on oops
> 
> show_task-free-stack-fix.patch
>   show_task() fix and cleanup
> 
> oops-dump-preceding-code.patch
>   i386 oops output: dump preceding code
> 
> lockmeter.patch
> 
> printk-oops-mangle-fix.patch
>   disentangle printk's whilst oopsing on SMP
> 
> 4g-2.6.0-test2-mm2-A5.patch
>   4G/4G split patch
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g/4g usercopy atomicity fix
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g/4g usercopy atomicity fix
>   4G/4G preempt on vstack
>   4G/4G: even number of kmap types
>   4g4g: fix __get_user in slab
>   4g4g: Remove extra .data.idt section definition
>   4g/4g linker error (overlapping sections)
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g4g: show_registers() fix
>   4g/4g usercopy atomicity fix
>   4g4g: debug flags fix
>   4g4g: Fix wrong asm-offsets entry
>   cyclone time fixmap fix
>   4G/4G preempt on vstack
>   4G/4G: even number of kmap types
>   4g4g: fix __get_user in slab
>   4g4g: Remove extra .data.idt section definition
>   4g/4g linker error (overlapping sections)
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g4g: show_registers() fix
>   4g/4g usercopy atomicity fix
>   4g4g: debug flags fix
>   4g4g: Fix wrong asm-offsets entry
>   cyclone time fixmap fix
>   use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
>   4G/4G might_sleep warning fix
>   4g/4g pagetable accounting fix
> 
> 4g4g-athlon-prefetch-handling-fix.patch
> 
> ppc-fixes.patch
>   make mm4 compile on ppc
> 
> aic7xxx_old-oops-fix.patch
> 
> O_DIRECT-race-fixes-rollup.patch
>   DIO fixes forward port and AIO-DIO fix
>   O_DIRECT race fixes comments
>   O_DRIECT race fixes fix fix fix
>   DIO locking rework
> 
> O_DIRECT-race-fixes-rework-XFS-fix.patch
>   O_DIRECT XFS fix
> 
> aio-01-retry.patch
>   AIO: Core retry infrastructure
>   Fix aio process hang on EINVAL
>   AIO: flush workqueues before destroying ioctx'es
>   AIO: hold the context lock across unuse_mm
>   task task_lock in use_mm()
> 
> 4g4g-aio-hang-fix.patch
>   Fix AIO and 4G-4G hang
> 
> aio-refcounting-fix.patch
>   aio ref count in io_submit_one
> 
> aio-retry-elevated-refcount.patch
>   aio: extra ref count during retry
> 
> aio-splice-runlist.patch
>   Splice AIO runlist for fairer handling of multiple io contexts
> 
> aio-02-lockpage_wq.patch
>   AIO: Async page wait
> 
> aio-03-fs_read.patch
>   AIO: Filesystem aio read
> 
> aio-04-buffer_wq.patch
>   AIO: Async buffer wait
>   lock_buffer_wq fix
> 
> aio-05-fs_write.patch
>   AIO: Filesystem aio write
> 
> aio-06-bread_wq.patch
>   AIO: Async block read
> 
> aio-07-ext2getblk_wq.patch
>   AIO: Async get block for ext2
> 
> O_SYNC-speedup-2.patch
>   speed up O_SYNC writes
> 
> O_SYNC-speedup-2-f_mapping-fixes.patch
> 
> aio-09-o_sync.patch
>   aio O_SYNC
>   AIO: fix a BUG
>   Unify o_sync changes for aio and regular writes
>   aio-O_SYNC-fix bits got lost
>   aio: writev nr_segs fix
>   More AIO O_SYNC related fixes
> 
> aio-09-o_sync-f_mapping-fixes.patch
> 
> gang_lookup_next.patch
>   Change the page gang lookup API
> 
> aio-gang_lookup-fix.patch
>   AIO gang lookup fixes
> 
> aio-O_SYNC-short-write-fix.patch
>   Fix for O_SYNC short writes
> 
> aio-12-readahead.patch
>   AIO: readahead fixes
>   aio O_DIRECT no readahead
>   Unified page range readahead for aio and regular reads
> 
> aio-12-readahead-f_mapping-fix.patch
> 
> aio-readahead-speedup.patch
>   Readahead issues and AIO read speedup
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

