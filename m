Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUGEKc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUGEKc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 06:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUGEKc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 06:32:59 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:19244 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265999AbUGEKcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 06:32:25 -0400
Subject: Re: 2.6.7-mm6
From: Redeeman <lkml@metanurb.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040705023120.34f7772b.akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 05 Jul 2004 12:32:23 +0200
Message-Id: <1089023543.10789.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

does this also include patch for the net problems?

On Mon, 2004-07-05 at 02:31 -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/
> 
> - Added the DVD-RW/CD-RW packet writing patches.  These need more work.
> 
> - The USB update seems deadlocky.  I fixed one bug but it still causes my
>   ia64 test box to lock up on boot.  If it goes bad, please revert
>   usb-locking-fix.patch and then revert bk-usb.patch.  Retest and send a report
>   to linux-kernel and linux-usb-devel@lists.sourceforge.net.
> 
> 
> 
> 
> Changes since 2.6.7-mm5:
> 
> 
>  linus.patch
>  bk-acpi.patch
>  bk-agpgart.patch
>  bk-alsa.patch
>  bk-cpufreq.patch
>  bk-driver-core.patch
>  bk-ieee1394.patch
>  bk-input.patch
>  bk-libata.patch
>  bk-netdev.patch
>  bk-pnp.patch
>  bk-scsi.patch
>  bk-usb.patch
> 
>  External trees
> 
> -alsa-gus-compile-error.patch
> -ppc64-remove-rtas-arguments-from-paca.patch
> -ppc64-paca-cleanup.patch
> -ppc64-janitor-log_rtas_error-call-arguments.patch
> -ppc64-janitor-rtas_call-return-variables.patch
> -ppc32-ocp-for-mp10x.patch
> -ppc32-ppc44x-updates.patch
> -ppc32-ppc4xx-preempt-fixes.patch
> -net-at1700c-depends-on-mca_legacy.patch
> -net-ne2c-needs-mca_legacy.patch
> -next-step-of-smp-support-fix-device-suspending.patch
> -next-step-of-smp-support-fix-device-suspending-warning-fix.patch
> -next-step-of-smp-support-fix-device-suspending-warning-fix-2.patch
> -next-step-of-smp-support-fix-device-suspending-x86_64-fix.patch
> -produce-a-warning-on-unchecked-inode_setattr-use.patch
> -bugfix-for-clock_realtime-absolute-timer.patch
> -pcmcia-net-device-unplugging-ordering-fix.patch
> -remove-upf_resources.patch
> -define-max-kernel-symbol-lenght-and-clean-up.patch
> -fix-sparse-warnings-in-kernel-power.patch
> -fix-sparse-warnings-in.patch
> -convert-private-abs-to-kernels-abs.patch
> -rivafb-fixes.patch
> -mode-switch-in-fbcon_blank.patch
> -another-batch-of-fbcon-fixes.patch
> -pdcp-needs-io_h.patch
> -es7000-subarch-update-for-target_cpus.patch
> -zombie-with-clone_thread.patch
> -asiliantfb-fixes.patch
> -64-bit-bug-in-radix-tree-lookup.patch
> -s390-core-changes.patch
> -s390-comon-i-o-layer.patch
> -s390-dasd-driver-changes.patch
> -s390-sclp-console-driver.patch
> -s390-network-driver-changes.patch
> -s390-zfcp-host-adapter.patch
> -x86_64-edd-build-fix.patch
> -telephony-driver-isapnp-fix.patch
> -1-4-dm-kcopydc-remove-unused-include.patch
> -2-4-dm-kcopydc-make-client_add-return-void.patch
> -3-4-dm-dm-raid1c-enforce-max-of-9-mirrors.patch
> -4-4-dm-dm-raid1c-use-fixed-size-arrays.patch
> -physnode-map-can-go-negative.patch
> -flexible-mmap-bug-fix.patch
> 
>  Merged
> 
> +usb-locking-fix.patch
> 
>  Fix USB deadlock
> 
> +fix-trap_bad_syscall_exits-on-i386.patch
> +add-trap_bad_syscall_exits-config-for-i386.patch
> 
>  kgdb fixlets
> 
> +ppc64-eeh-fixes-for-power5-machines-1-2.patch
> +ppc64-eeh-fixes-for-power5-machines-2-2.patch
> +ppc64-rtas-error-log-locking-fix.patch
> +ppc64-gcc-35-fix.patch
> +ppc64-gcc-35-fixes-2.patch
> +ppc64-splpar-spinlock-optimisation.patch
> +ppc64-out-of-line-some-user-copy-routines.patch
> +ppc32-biarch-gcc-support.patch
> +ppc64-remove-MachineCheck_Pseries.patch
> 
>  ppc32/64 updates
> 
> -pefrctr-x86_tests-build-fix.patch
> -perfctr-ppc32-update.patch
> -perfctr-update-4-6-ppc32-cleanups.patch
> -perfctr-update-6-6-misc-minor-cleanups.patch
> -perfctr-update-3-6-__user-annotations.patch
> -perfctr-cpus_complement-fix.patch
> -perfctr-cpumask-cleanup.patch
> -perfctr-misc.patch
> 
>  Folded into other perfctr patches
> 
> +perfctr-ppc32-buglet-fix.patch
> +perfctr-low-level-documentation.patch
> 
>  perfctr updates
> 
> -reduce-tlb-flushing-during-process-migration-2.patch
> +reduce-tlb-flushing-during-process-migration-3.patch
> 
>  Updated
> 
> +sched-fork-hotplug-cleanuppatch.patch
> 
>  CPU scheduler cleanup
> 
> +flexible-mmap-bug-fix.patch
> +flexible-mmap-updatepatch-267-mm5.patch
> 
>  Fix the ia32 VM layout patch
> 
> +clean-up-module-install-rules.patch
> +kbuild-sort-modules-for-modpost-and-modinst.patch
> 
>  kbuild fixes/cleanups
> 
> +intrinsic-automount-and-mountpoint-degradation-support.patch
> +intrinsic-automount-and-mountpoint-degradation-support-fix.patch
> +kafs-automount-support.patch
> +kafs-automount-support-build-fix.patch
> 
>  Internal automounting for AFS
> 
> +dvdrw-support-for-267-bk13.patch
> +cdrw-packet-writing-support-for-267-bk13.patch
> +dvd-rw-packet-writing-update.patch
> +fix-race-in-pktcdvd-kernel-thread-handling.patch
> +fix-open-close-races-in-pktcdvd.patch
> +packet-writing-review-fixups.patch
> +packet-writing-docco.patch
> 
>  DVD-RW/CD-RW packet writing support
> 
> +ia64-audit-support.patch
> 
>  Support "lightweight syscall auditing" on ia64
> 
> +r8169_napi-help-text-2.patch
> 
>  Kconfig help for the r8169 net driver
> 
> +check-for-undefined-symbols.patch
> 
>  Check for undefined symbols in vmlinux, fail the build if there are any. 
>  Lots of builds failes.
> 
> +sparc64-remove-silo-args.patch
> 
>  Fix sparc64 build
> 
> +no-sysgood-for-ptrace-singlestep.patch
> 
>  Clean up/fix ptrace code
> 
> +more-mca_legacy-dependencies.patch
> 
>  Fix build with CONFIG_MCA_LEGACY=n
> 
> +use-llseek-instead-of-f_pos=-for-directory-seeking.patch
> 
>  Fix an nfsd problem when the client sends an insane directory offset.
> 
> +err1-28-rose_route-locking-fix.patch
> +err1-62-ax25_ds_idletimer_expiry-locking-fix.patch
> +err1-67-lapb_unregister-locking-fix.patch
> +err2-6-hashbin_remove_this-locking-fix.patch
> +err2-15-ax25_rt_add-locking-fix.patch
> 
>  Networking fixes arising from the Stanford locking checker.
> 
> +port-reboot-workarounds-to-new-dmi-probing.patch
> 
>  Use the new DMI API a bit more.
> 
> +dm-use-idr.patch
> 
>  Use an IDR tree in devicemapper
> 
> +fix-sparse-warnings-in-fs-udf.patch
> 
>  sparse fixes
> 
> +fbcon-mode-switch-hack.patch
> 
>  Fix fbcon switching to/from X.
> 
> +fix-one-sparse-warning-in-net-sun-xprtc.patch
> 
>  sparse fixes
> 
> +fix-compile-errors-with-x86_powernow_k78=y-and-acpi_processor=m.patch
> 
>  build fix
> 
> +fix-up-physnode_map.patch
> 
>  ia23 NUMA fix
> 
> +wavefront_fx-build-fix.patch
> 
>  Fix sounds driver build with gcc-3.5.
> 
> +mtrr-initdata-fix.patch
> 
>  MTRR section fix
> 
> +ipc-1-3-add-refcount-to-ipc_rcu_alloc.patch
> +ipc-2-3-remove-sem_revalidate.patch
> +ipc-3-3-enforce-semvmx-limit-for-undo.patch
> +cleanup-of-ipc-msgc.patch
> 
>  Add refcounting to the ipc kernel objects.
> 
> +selinux-build-fix.patch
> 
>  SELinux compile fix with gcc-3.5
> 
> +selinux-space-saving.patch
> 
>  Save a scrap of RAM in SELinux
> 
> +err1-7-err1-8-double-locking-fix-for-radeonfb.patch
> 
>  Moer Stanford checker fixes
> 
> +fix-ia64-upf_resources-pcdpc-267-mm5-build.patch
> 
>  ia64 build fix
> 
> +sparc-32-cpumask-bitop-build-fix.patch
> 
>  sparc32 cpumask fixes
> 
> +force-o_largefile-in-sys_swapon-and-sys_swapoff.patch
> 
>  Use O_LARGEFILE on swapfiles
> 
> +gcc-35-fixes.patch
> +gcc-35-fixes-2.patch
> 
>  More gcc-3.5 fixes
> 
> +__bdevname-leak-fix.patch
> 
>  Fix mudule refcount leak in __bdevname()
> 
> +sk98lin-procfs-fix.patch
> 
>  Fix /proc handling in this driver
> 
> +spurious-remap_file_pages-einval.patch
> 
>  Fix remap_file_pages()
> 
> +cpufreq-driver-for-nforce2-kernel-267.patch
> 
>  cpufreq driver for the nForce2 chipset.
> 
> +remove-allowdma0-documentation-fwd.patch
> 
>  Documentation update
> 
> +mptbase-warning-fix.patch
> +kyro-warning-fix.patch
> 
>  Fix a couple of warnings.
> 
> 
> 
> 
> 
> All 179 patches:
> 
> 
> linus.patch
> 
> kbuild-improve-kernel-build-with-separated-output.patch
>   kbuild: Improve Kernel build with separated output
> 
> sysfs-leaves-mount.patch
>   sysfs backing store: add sysfs_dirent
> 
> sysfs-leaves-dir.patch
>   sysfs backing store: add sysfs_dirent
> 
> sysfs-leaves-file.patch
>   sysfs backing store: sysfs_create() changes
> 
> sysfs-leaves-bin.patch
>   sysfs backing store: bin attribute changes
> 
> sysfs-leaves-symlink.patch
>   sysfs backing store: sysfs_create_link changes
> 
> sysfs-leaves-misc.patch
>   sysfs backing store: attribute groups and misc routines
> 
> bk-acpi.patch
> 
> bk-agpgart.patch
> 
> bk-alsa.patch
> 
> bk-cpufreq.patch
> 
> bk-driver-core.patch
> 
> bk-ieee1394.patch
> 
> bk-input.patch
> 
> bk-libata.patch
> 
> bk-netdev.patch
> 
> bk-pnp.patch
> 
> bk-scsi.patch
> 
> bk-usb.patch
> 
> mm.patch
>   add -mmN to EXTRAVERSION
> 
> usb-locking-fix.patch
>   usb deadlock fix
> 
> kgdb-ga.patch
>   kgdb stub for ia32 (George Anzinger's one)
>   kgdbL warning fix
>   kgdb buffer overflow fix
>   kgdbL warning fix
>   kgdb: CONFIG_DEBUG_INFO fix
>   x86_64 fixes
>   correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
>   kgdb: fix for recent gcc
>   kgdb warning fixes
>   THREAD_SIZE fixes for kgdb
>   Fix stack overflow test for non-8k stacks
> 
> kgdb-gapatch-fix-for-i386-single-step-into-sysenter.patch
>   kgdb-ga.patch fix for i386 single-step into sysenter
> 
> fix-trap_bad_syscall_exits-on-i386.patch
>   fix TRAP_BAD_SYSCALL_EXITS on i386
> 
> add-trap_bad_syscall_exits-config-for-i386.patch
>   add TRAP_BAD_SYSCALL_EXITS config for i386
> 
> kgdboe-netpoll.patch
>   kgdb-over-ethernet via netpoll
>   kgdboe: fix configuration of MAC address
> 
> kgdb-x86_64-support.patch
>   kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
>   kgdb-x86_64-warning-fixes
> 
> kgdb-ia64-support.patch
>   IA64 kgdb support
>   ia64 kgdb repair and cleanup
> 
> kgdb-irqaction-use-cpumask.patch
> 
> kgdb-ia64-fix.patch
>   ia64 kgdb fix
> 
> make-tree_lock-an-rwlock.patch
>   make mapping->tree_lock an rwlock
> 
> radix_tree_tag_set-atomic.patch
>   Make radix_tree_tag_set/clear atomic wrt the tag
> 
> radix_tree_tag_set-only-needs-read_lock.patch
>   radix_tree_tag_set only needs read_lock()
> 
> must-fix.patch
>   must fix lists update
>   must fix list update
>   mustfix update
> 
> must-fix-update-5.patch
>   must-fix update
> 
> mustfix-lists.patch
>   mustfix lists
> 
> ppc64-eeh-fixes-for-power5-machines-1-2.patch
>   ppc64: EEH fixes for POWER5 machines (1/2)
> 
> ppc64-eeh-fixes-for-power5-machines-2-2.patch
>   ppc64: EEH fixes for POWER5 machines (2/2)
> 
> ppc64-rtas-error-log-locking-fix.patch
>   ppc64: RTAS error log locking fix
> 
> ppc64-gcc-35-fix.patch
>   ppc64: gcc 3.5 fixes
> 
> ppc64-gcc-35-fixes-2.patch
>   ppc64: gcc 3.5 fixes #2
> 
> ppc64-splpar-spinlock-optimisation.patch
>   ppc64: SPLPAR spinlock optimisation
> 
> ppc64-out-of-line-some-user-copy-routines.patch
>   ppc64: uninline some user copy routines
> 
> ppc32-biarch-gcc-support.patch
>   ppc32: biarch gcc support
> 
> ppc64-remove-MachineCheck_Pseries.patch
>   ppc64: remove MachineCheck_Pseries
> 
> ppc64-reloc_hide.patch
> 
> invalidate_inodes-speedup.patch
>   invalidate_inodes speedup
>   more invalidate_inodes speedup fixes
> 
> get_user_pages-handle-VM_IO.patch
>   fix get_user_pages() against mappings of /dev/mem
> 
> fa311-mac-address-fix.patch
>   wrong mac address with netgear FA311 ethernet card
> 
> pid_max-fix.patch
>   Bug when setting pid_max > 32k
> 
> jbd-remove-livelock-avoidance.patch
>   JBD: remove livelock avoidance code in journal_dirty_data()
> 
> journal_add_journal_head-debug.patch
>   journal_add_journal_head-debug
> 
> list_del-debug.patch
>   list_del debug check
> 
> oops-dump-preceding-code.patch
>   i386 oops output: dump preceding code
> 
> lockmeter.patch
>   lockmeter
>   ia64 CONFIG_LOCKMETER fix
> 
> unplug-can-sleep.patch
>   unplug functions can sleep
> 
> firestream-warnings.patch
>   firestream warnings
> 
> ext3_rsv_cleanup.patch
>   ext3 block reservation patch set -- ext3 preallocation cleanup
> 
> ext3_rsv_base.patch
>   ext3 block reservation patch set -- ext3 block reservation
>   ext3 reservations: fix performance regression
>   ext3 block reservation patch set -- mount and ioctl feature
>   ext3 block reservation patch set -- dynamically increase reservation window
>   ext3 reservation ifdef cleanup patch
>   ext3 reservation max window size check patch
>   ext3 reservation file ioctl fix
> 
> ext3-reservation-default-on.patch
>   ext3 reservation: default to on
> 
> ext3-lazy-discard-reservation-window-patch.patch
>   ext3 lazy discard reservation window patch
>   ext3 discard reservation in last iput fix patch
>   Fix lazy reservation discard
>   ext3 reservations: bad_inode fix
>   ext3 reservation discard race fix
> 
> hugetlb_shm_group-sysctl-gid-0-fix.patch
>   hugetlb_shm_group sysctl-gid-0-fix
> 
> really-ptrace-single-step-2.patch
>   ptrace single-stepping fix
> 
> ipr-ppc64-depends.patch
>   Make ipr.c require ppc
> 
> disk-barrier-core.patch
>   disk barriers: core
>   disk-barrier-core-tweaks
> 
> disk-barrier-ide.patch
>   disk barriers: IDE
>   disk-barrier-ide-symbol-expoprt
>   disk-barrier ide warning fix
> 
> barrier-update.patch
>   barrier update
> 
> disk-barrier-scsi.patch
>   disk barriers: scsi
> 
> disk-barrier-dm.patch
>   disk barriers: devicemapper
> 
> disk-barrier-md.patch
>   disk barriers: MD
> 
> reiserfs-v3-barrier-support.patch
>   reiserfs v3 barrier support
>   reiserfs-v3-barrier-support-tweak
> 
> sync_dirty_buffer-retval.patch
>   make sync_dirty_buffer() return something useful
> 
> ext3-barrier-support.patch
>   ext3 barrier support
> 
> jbd-barrier-fallback-on-failure.patch
>   jbd: barrier fallback on failure
> 
> ide-print-failed-opcode.patch
>   ide: print failed opcode on IO errors
>   From: Jens Axboe <axboe@suse.de>
>   Subject: Re: ide errors in 7-rc1-mm1 and later
> 
> add-bh_eopnotsupp-for-testing.patch
>   add BH_Eopnotsupp for testing async barrier failures
> 
> handle-async-barrier-failures.patch
>   Handle async barrier failures
> 
> enable-suspend-resuming-of-e1000.patch
>   Enable suspend/resuming of e1000
> 
> tty_io-hangup-locking.patch
>   tty_io.c hangup locking
> 
> perfctr-core.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
>   CONFIG_PERFCTR=n build fix
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc
> 
> perfctr-i386.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
>   perfctr #if/#ifdef cleanup
>   perfctr Dothan support
>   perfctr x86_tests build fix
> 
> perfctr-x86_64.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64
> 
> perfctr-ppc.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
>   perfctr ppc32 update
>   perfctr update 4/6: PPC32 cleanups
> 
> perfctr-ppc32-buglet-fix.patch
>   perfctr ppc32 buglet fix
> 
> perfctr-virtualised-counters.patch
>   From: Mikael Pettersson <mikpe@csd.uu.se>
>   Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
>   perfctr update 6/6: misc minor cleanups
>   perfctr update 3/6: __user annotations
>   perfctr-cpus_complement-fix
>   perfctr cpumask cleanup
> 
> perfctr-ifdef-cleanup.patch
>   perfctr ifdef cleanup
> 
> perfctr-update-2-6-kconfig-related-updates.patch
>   perfctr update 2/6: Kconfig-related updates
> 
> perfctr-update-5-6-reduce-stack-usage.patch
>   perfctr update 5/6: reduce stack usage
> 
> perfctr-low-level-documentation.patch
>   perfctr low-level documentation
> 
> ext3-online-resize-patch.patch
>   ext3: online resizing
> 
> ext3-online-resize-warning-fix.patch
>   ext3-online-resize-warning-fix
> 
> altix-serial-driver-2.patch
>   Altix serial driver updates
>   altix-serial-driver-fix
> 
> sched-clean-init-idle.patch
>   sched: cleanup init_idle()
> 
> sched-clean-fork.patch
>   sched: cleanup, improve sched <=> fork APIs
> 
> sched-clean-fork-rename-wake_up_new_process-wake_up_new_task.patch
>   sched: rename wake_up_new_process -> wake_up_new_task
> 
> sched-misc-cleanups-2.patch
>   sched: misc cleanups #2
> 
> sched-unlikely-rt_task.patch
>   sched: make rt_task unlikely
> 
> sched-misc.patch
>   sched: sched misc changes
> 
> sched-misc-fix-rt.patch
>   sched: fix RT scheduling & interactivity estimator
> 
> sched-no-balance-clone.patch
>   sched: disable balance on clone
> 
> sched-remove-balance-clone.patch
>   sched: remove balance on clone
> 
> sched-fork-hotplug-cleanuppatch.patch
>   sched: fork hotplug hanling cleanup
> 
> memory-backed-inodes-fix.patch
>   memory-backed inodes fix
> 
> ext3_bread-cleanup.patch
>   ext3_bread() cleanup
> 
> flexible-mmap-2.6.7-mm3-A8.patch
>   i386 virtual memory layout rework
> 
> flexible-mmap-bug-fix.patch
>   flexible-mmap BUG fix
> 
> flexible-mmap-updatepatch-267-mm5.patch
>   flexible-mmap update
> 
> driver-model-and-sysfs-support-for-pcmcia-1-3.patch
>   driver model and sysfs support for PCMCIA (1/3)
> 
> update-drivers-net-pcmcia-2-3.patch
>   update drivers/net/pcmcia (2/3)
> 
> update-drivers-net-wireless-3-3.patch
>   update drivers/net/wireless (3/3)
> 
> posix-locking-fix-to-posix_same_owner.patch
>   posix locking: Minimal fix to posix_same_owner()
> 
> posix-locking-fix-to-locking-code.patch
>   posix locking: more locking code fixes
> 
> posix-locking-fix-up-nfs4statec.patch
>   posix locking: Fix up nfs4state.c
> 
> posix-locking-fix-up-lockd.patch
>   posix locking: Fix up lockd to make use of the new interface
> 
> posix-locking-fl_owner_t-to-pid-mapping.patch
>   posix locking: mapping between fl_owner_t and client-side "pid"
> 
> ide_tf_pio_out_fixes.patch
>   ide: PIO-out fixes for ide-taskfile.c (CONFIG_IDE_TASKFILE_IO=n)
> 
> ide_tf_pio_out_prehandler.patch
>   ide: PIO-out ->prehandler() fixes (CONFIG_IDE_TASKFILE_IO=y)
> 
> ide_tf_pio_out_error.patch
>   ide: PIO-out error handling fixes (CONFIG_IDE_TASKFILE_IO=y)
> 
> ide_task_in_intr.patch
>   ide: remove BUSY check from task_in_intr() (CONFIG_IDE_TASKFILE_IO=n)
> 
> ide_pre_task_out_intr.patch
>   remove pre_task_out_intr() comment (CONFIG_IDE_TASKFILE_IO=n)
> 
> ide_pre_task_mulout_intr.patch
>   ide: pre_task_mulout_intr() cleanup (CONFIG_IDE_TASKFILE_IO=n)
> 
> ide_tf_no_partial.patch
>   ide: no partial completions for PIO (CONFIG_IDE_TASKFILE_IO=y)
> 
> ide_non_tf_pio.patch
>   ide: merge CONFIG_IDE_TASKFILE_IO=y|n PIO handlers together
> 
> ide_no_flagged_pio.patch
>   ide: use "normal" handlers for "flagged" taskfiles (ide-taskfile.c)
> 
> clean-up-module-install-rules.patch
>   kbuild: clean up module install rules
> 
> kbuild-sort-modules-for-modpost-and-modinst.patch
>   kbuild: sort modules for modpost and modinst
> 
> intrinsic-automount-and-mountpoint-degradation-support.patch
>   intrinsic automount and mountpoint degradation support
> 
> intrinsic-automount-and-mountpoint-degradation-support-fix.patch
>   intrinsic-automount-and-mountpoint-degradation-support-fix
> 
> kafs-automount-support.patch
>   kAFS automount support
> 
> kafs-automount-support-build-fix.patch
>   kafs-automount-support-build-fix
> 
> dvdrw-support-for-267-bk13.patch
>   DVD+RW support for 2.6.7-bk13
> 
> cdrw-packet-writing-support-for-267-bk13.patch
>   CDRW packet writing support
> 
> dvd-rw-packet-writing-update.patch
>   Packet writing support for DVD-RW and DVD+RW discs.
> 
> fix-race-in-pktcdvd-kernel-thread-handling.patch
>   Fix race in pktcdvd kernel thread handling
> 
> fix-open-close-races-in-pktcdvd.patch
>   Fix open/close races in pktcdvd
> 
> packet-writing-review-fixups.patch
>   packet writing: review fixups
> 
> packet-writing-docco.patch
>   packet writing documentation
> 
> ia64-audit-support.patch
>   IA64 audit support
> 
> r8169_napi-help-text-2.patch
>   R8169_NAPI help text
> 
> check-for-undefined-symbols.patch
>   kbuild: check for undefined symbols in vmlinux
> 
> sparc64-remove-silo-args.patch
>   sparc64: remove silo args
> 
> no-sysgood-for-ptrace-singlestep.patch
>   Don't use SYSGOOD for ptrace singlestep
> 
> more-mca_legacy-dependencies.patch
>   Fix MCA_LEGACY dependencies
> 
> use-llseek-instead-of-f_pos=-for-directory-seeking.patch
>   Use llseek instead of f_pos= for directory seeking
> 
> err1-28-rose_route-locking-fix.patch
>   err1-28: rose_route locking fix
> 
> err1-62-ax25_ds_idletimer_expiry-locking-fix.patch
>   err1-62: ax25_ds_idletimer_expiry() locking fix
> 
> err1-67-lapb_unregister-locking-fix.patch
>   err1-67: lapb_unregister() locking fix
> 
> err2-6-hashbin_remove_this-locking-fix.patch
>   err2-6: hashbin_remove_this() locking fix
> 
> err2-15-ax25_rt_add-locking-fix.patch
>   err2-15: ax25_rt_add() locking fix
> 
> port-reboot-workarounds-to-new-dmi-probing.patch
>   port reboot workarounds to new DMI probing
> 
> dm-use-idr.patch
>   devicemapper: use an IDR tree for tracking minors
> 
> reduce-tlb-flushing-during-process-migration-3.patch
>   Reduce TLB flushing during process migration
> 
> fix-sparse-warnings-in-fs-udf.patch
>   Fix sparse warnings in fs/udf/*
> 
> fbcon-mode-switch-hack.patch
>   fbcom mode switching fix
> 
> fix-one-sparse-warning-in-net-sun-xprtc.patch
>   Fix one sparse warning in net/sun/xprt.c
> 
> fix-compile-errors-with-x86_powernow_k78=y-and-acpi_processor=m.patch
>   Fix compile errors with X86_POWERNOW_K{7,8}=y and ACPI_PROCESSOR=m
> 
> fix-up-physnode_map.patch
>   fix up physnode_map
> 
> wavefront_fx-build-fix.patch
>   wavefront_fx.c build fix
> 
> mtrr-initdata-fix.patch
>   MTRR __initdata fix
> 
> ipc-1-3-add-refcount-to-ipc_rcu_alloc.patch
>   ipc: Add refcount to ipc_rcu_alloc
> 
> ipc-2-3-remove-sem_revalidate.patch
>   ipc: remove sem_revalidate
> 
> ipc-3-3-enforce-semvmx-limit-for-undo.patch
>   ipc: enforce SEMVMX limit for undo
> 
> cleanup-of-ipc-msgc.patch
>   cleanup of ipc/msg.c
> 
> selinux-build-fix.patch
>   selinux build fix
> 
> selinux-space-saving.patch
>   selinux space saving
> 
> err1-7-err1-8-double-locking-fix-for-radeonfb.patch
>   err1-7, err1-8: double locking fix for radeonfb
> 
> fix-ia64-upf_resources-pcdpc-267-mm5-build.patch
>   Fix ia64 UPF_RESOURCES pcdp.c 2.6.7-mm5 build
> 
> sparc-32-cpumask-bitop-build-fix.patch
>   sparc32 cpumask bitop build fix
> 
> force-o_largefile-in-sys_swapon-and-sys_swapoff.patch
>   force O_LARGEFILE in sys_swapon() and sys_swapoff()
> 
> gcc-35-fixes.patch
>   gcc 3.5 fixes
> 
> gcc-35-fixes-2.patch
>   gcc 3.5 fixes #2
> 
> __bdevname-leak-fix.patch
>   __bdevname leak fix
> 
> sk98lin-procfs-fix.patch
>   sk98lin procfs fix
> 
> spurious-remap_file_pages-einval.patch
>   spurious remap_file_pages() -EINVAL
> 
> cpufreq-driver-for-nforce2-kernel-267.patch
>   cpufreq driver for nForce2
> 
> remove-allowdma0-documentation-fwd.patch
>   remove allowdma0 documentation
> 
> mptbase-warning-fix.patch
>   mptbase.c warning fix
> 
> kyro-warning-fix.patch
>   kyrofb warning fix
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

