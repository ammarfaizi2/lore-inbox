Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUGIGwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUGIGwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 02:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbUGIGwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 02:52:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:64142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264401AbUGIGvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 02:51:32 -0400
Date: Thu, 8 Jul 2004 23:50:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm7
Message-Id: <20040708235025.5f8436b7.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/


- Added three new bk trees to the -mm lineup:

  bk-dma-declare-coherent-memory.patch
    New DMA mapping function.
  bk-jfs.patch
    JFS filesystem development tree
  bk-mpc52xx.patch
    New ppc32 board support

- Added a big UML update.   Needs work.

- Lots of warning fixes, mainly.



Changes since 2.6.7-mm6:


 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cifs.patch
 bk-dma-declare-coherent-memory.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-jfs.patch
 bk-libata.patch
 bk-mpc52xx.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pcmcia.patch
 bk-pnp.patch
 bk-scsi.patch
 bk-usb.patch

 External bk trees

-usb-locking-fix.patch
-ppc64-eeh-fixes-for-power5-machines-1-2.patch
-ppc64-eeh-fixes-for-power5-machines-2-2.patch
-ppc64-rtas-error-log-locking-fix.patch
-ppc64-gcc-35-fix.patch
-ppc64-gcc-35-fixes-2.patch
-ppc64-splpar-spinlock-optimisation.patch
-ppc32-biarch-gcc-support.patch
-ppc64-remove-MachineCheck_Pseries.patch
-check-for-undefined-symbols.patch
-sparc64-remove-silo-args.patch
-err1-28-rose_route-locking-fix.patch
-err1-62-ax25_ds_idletimer_expiry-locking-fix.patch
-err1-67-lapb_unregister-locking-fix.patch
-err2-15-ax25_rt_add-locking-fix.patch
-port-reboot-workarounds-to-new-dmi-probing.patch
-fix-sparse-warnings-in-fs-udf.patch
-fbcon-mode-switch-hack.patch
-fix-one-sparse-warning-in-net-sun-xprtc.patch
-fix-up-physnode_map.patch
-wavefront_fx-build-fix.patch
-mtrr-initdata-fix.patch
-selinux-build-fix.patch
-selinux-space-saving.patch
-err1-7-err1-8-double-locking-fix-for-radeonfb.patch
-fix-ia64-upf_resources-pcdpc-267-mm5-build.patch
-sparc-32-cpumask-bitop-build-fix.patch
-force-o_largefile-in-sys_swapon-and-sys_swapoff.patch
-gcc-35-fixes.patch
-gcc-35-fixes-2.patch
-__bdevname-leak-fix.patch
-spurious-remap_file_pages-einval.patch
-remove-allowdma0-documentation-fwd.patch
-kyro-warning-fix.patch

 Merged

+jfs_dmap-build-fix.patch
+bfusb-hack.patch

 Fixes for breakage in "external bk trees"

-kgdb-gapatch-fix-for-i386-single-step-into-sysenter.patch
-fix-trap_bad_syscall_exits-on-i386.patch
-add-trap_bad_syscall_exits-config-for-i386.patch
-kgdb-irqaction-use-cpumask.patch
-kgdb-ia64-fix.patch

 Folded into other kgdb patches

+kgdb-ia64-fixes.patch

 kgdb fix

+quota-iflags-locking-fix.patch

 Add i_sem locking around quota's use of inode->i_flags;

+remove-pkt_dev-from-struct-pktcdvd_device.patch
+convert-packet-writing-to-seq_file.patch

 DVD-RW/CD-RW packet writing updates

+allow-modular-ide-pnp.patch

 Permit IDE PNP to be built as a module.

+remove-dead-isdn-pcmcia-code.patch

 Obsolete code removed

+i2c-i2c-devci2c_dev_init-cleanup.patch

 i2c cleanup

+uml-base-patch.patch
+uml-readds-just-for-now-ghashh-for-uml.patch
+uml-avoid-that-gcc-breaks-uml-with-unit-at-a-time-compilation-mode.patch
+uml-fixes-an-host-fd-leak-caused-by-hostfs.patch
+uml-adds-legacy_pty-config-option.patch
+uml-makes-make-help-arch=um-work.patch
+uml-fixes-fixdepc-to-support-arch-um-include-uml-configh.patch
+uml-kill-useless-warnings.patch
+uml-avoids-compile-failure-when-host-misses-tkill.patch
+uml-reduces-code-in-_user-files-by-moving-it-in-_kern-files-if-already-possible.patch
+uml-fixes-raw-and-uses-it-in-check_one_sigio-also-fixes-a-silly-panic-eintr-returned-by-call.patch
+uml-folds-hostaudio_userc-into-hostaudio_kernc.patch
+uml-use-ptrace_scemu-the-so-called-sysemu-to-reduce-syscall-cost.patch
+uml-adds-the-nosysemu-command-line-parameter-to-disable-sysemu.patch
+uml-adds-proc-sysemu-to-toggle-sysemu-usage.patch
+uml-fix-for-sysemu-patches.patch
+uml-handles-correctly-errno-==-eintr-in-lots-of-places.patch
+uml-adds-some-exports.patch
+uml-avoids-a-panic-for-a-legal-situation.patch
+uml-removes-dead-code-in-trap_kernc.patch
+uml-make-malloc-call-vmalloc-if-needed-needed-for-hostfs-on-26-host.patch
+uml-little-kmalloc.patch
+uml-fix-os_process_pc-and-os_process_parent-for-corner-cases.patch

 UML update

+sparse-fix-warnings-in-net-sctp.patch
+fix-warnings-in-net-irda.patch

 sparse warning fixes

+i810_audio-mmio-support.patch
+i810_audio-mmio-support-2.patch

 MMIO support for this sound driver

+fix-warnings-drivers-net-sk98lin-skaddrc.patch

 Warning fixes

+kallsyms-ppc32-fix.patch

 Fix a weird kallsyms problem on ppc32

+fix-drivers-isdn-hisax-avm_pcic-build-warning-when.patch

 Fix warning

+idr-stale-comment.patch

 Remove vestigial code in idr.c

+noexec-kernel-parameters-update.patch

 Documentation

+bio_copy_user-cleanups.patch

 BIO layer cleanups

+cfq-bad-allocation.patch

 Fix CFQ sleep-in-spinlock

+fat-update-document.patch

 Documentation update

+use-null-instead-of-integer-0-in-security-selinux.patch

 sparse stuff

+int-return-to-unsigned-in-smb_proc_readdir_long-in.patch

 smbfs warning fix.

+trivial-scripts_kernel-doc-ignoring-embedded-structs-shouldnt.patch
+trivial-scripts_kernel-doc-missing-bracket.patch
+trivial-little-arch_i386_kernel_timers_timer_nonec-fix.patch
+trivial-rcs___ignore-quilt-backup-files.patch
+trivial-remove-warning-in-ftape.patch
+trivial-arch_i386_kernel_scx200c-kill-duplicate.patch
+trivial-kill-off-config_pci_console.patch

 Patch monkey food.

+idr-comments-updates.patch

 Kerneldocify lib/idr.c

+convert-uses-of-zone_highmem-to-is_highmem.patch

 mm cleanup

+smbfs-compilation-warning-in-267.patch

 Warning fix

+remove-always-false-check-in-mm-slabc.patch

 Remove dead code

+detect-too-early-schedule-attempts.patch

 Catch attempts to call the scheduler before it is ready to go.

+correct-return-type-of-hashfn-in-fs-dquotc.patch

 Warning fix

+schedule-profiling.patch

 Boot with "profile=schedule" and readprofile will tell you about which
 callsites are calling schedule().  (Which seems pretty pointless if they all
 point at __down().  Oh well).

+fix-misplaced-inline-in-include-linux-iso_fsh.patch

 Warning fix

+pagefault-readaround-fix.patch

 Fix pagefault-time readaround.

+add-a-few-might_sleep-checks.patch

 Sprinkle more might_sleep() checks in various places.

+trivial-fix-to-include-scsi-scsi_deviceh.patch

 Warning fix

+ia64-ptrace-fix-fix.patch

 Fix ptrace on ia64

+possible-buglet-in-drivers-input-joystick-tmdcc.patch

 Fix weird code in tmdc_connect().

+alpha-print-the-symbol-name-in-oops.patch

 Add symbolic output to alpha oopses

+port-acpi-sleep-workaround-to-new-dmi-probing.patch
+dmi-isnt-broken-anymore.patch

 dmi_scan.c cleanups

+fix-crc16-misnaming.patch
+crc16-kconfig-touchups.patch
+crc16-renaming-in-ax25-drivers.patch
+crc16-renaming-in-irda-drivers.patch
+crc16-renaming-in-isdn-drivers.patch
+crc16-renaming-in-ppp-driver.patch
+crc16-renaming-in-via-velocity-ethernet-driver.patch

 Rename the crc16 functions.

+sh64-cpumask-cleanup.patch
+sh64-fix-init_taskc-build.patch
+sh64-add-asm-sh64-setuph.patch
+sh64-defconfig-update.patch

 sh64 update

+add-missing-sysfs-support-to-cpia-webcam-video-driver.patch

 Add sysfs support to this driver.

+tmpfs-scheduling-while-atomic-fix.patch

 Fix an atomicity problem in tmpfs.

+ad1889-warning-fix.patch

 Fix audio driver warning

+writepage-fs-corruption-fixes.patch

 Fix rare data-loss bug in mpage_writepages().

+block_write_full_page-comment-fixes.patch

 Fix some comments

+deflate-remove-lazy-allocation.patch

 Remove the lazy context allocation from the deflate code.





All 233 patches


linus.patch

kbuild-improve-kernel-build-with-separated-output.patch
  kbuild: Improve Kernel build with separated output

sysfs-leaves-mount.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-dir.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-file.patch
  sysfs backing store: sysfs_create() changes

sysfs-leaves-bin.patch
  sysfs backing store: bin attribute changes

sysfs-leaves-symlink.patch
  sysfs backing store: sysfs_create_link changes

sysfs-leaves-misc.patch
  sysfs backing store: attribute groups and misc routines

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-arm.patch

bk-cifs.patch

bk-dma-declare-coherent-memory.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-ieee1394.patch

bk-input.patch

bk-jfs.patch

bk-libata.patch

bk-mpc52xx.patch

bk-netdev.patch

bk-ntfs.patch

bk-pcmcia.patch

bk-pnp.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

jfs_dmap-build-fix.patch
  jfs_dmap build fix

bfusb-hack.patch
  bfusb-hack

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
  kgdb: fix for recent gcc
  kgdb warning fixes
  THREAD_SIZE fixes for kgdb
  Fix stack overflow test for non-8k stacks
  kgdb-ga.patch fix for i386 single-step into sysenter
  fix TRAP_BAD_SYSCALL_EXITS on i386
  add TRAP_BAD_SYSCALL_EXITS config for i386

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix

kgdb-ia64-fixes.patch
  kgdb: ia64 fixes

quota-iflags-locking-fix.patch
  quota: inode->i_flags locking fixes

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

radix_tree_tag_set-atomic.patch
  Make radix_tree_tag_set/clear atomic wrt the tag

radix_tree_tag_set-only-needs-read_lock.patch
  radix_tree_tag_set only needs read_lock()

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

mustfix-lists.patch
  mustfix lists

ppc64-out-of-line-some-user-copy-routines.patch
  ppc64: uninline some user copy routines

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation
  ext3 reservations: fix performance regression
  ext3 block reservation patch set -- mount and ioctl feature
  ext3 block reservation patch set -- dynamically increase reservation window
  ext3 reservation ifdef cleanup patch
  ext3 reservation max window size check patch
  ext3 reservation file ioctl fix

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard
  ext3 reservations: bad_inode fix
  ext3 reservation discard race fix

hugetlb_shm_group-sysctl-gid-0-fix.patch
  hugetlb_shm_group sysctl-gid-0-fix

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

ipr-ppc64-depends.patch
  Make ipr.c require ppc

disk-barrier-core.patch
  disk barriers: core
  disk-barrier-core-tweaks

disk-barrier-ide.patch
  disk barriers: IDE
  disk-barrier-ide-symbol-expoprt
  disk-barrier ide warning fix

barrier-update.patch
  barrier update

disk-barrier-scsi.patch
  disk barriers: scsi

disk-barrier-dm.patch
  disk barriers: devicemapper

disk-barrier-md.patch
  disk barriers: MD

reiserfs-v3-barrier-support.patch
  reiserfs v3 barrier support
  reiserfs-v3-barrier-support-tweak

sync_dirty_buffer-retval.patch
  make sync_dirty_buffer() return something useful

ext3-barrier-support.patch
  ext3 barrier support

jbd-barrier-fallback-on-failure.patch
  jbd: barrier fallback on failure

ide-print-failed-opcode.patch
  ide: print failed opcode on IO errors
  From: Jens Axboe <axboe@suse.de>
  Subject: Re: ide errors in 7-rc1-mm1 and later

add-bh_eopnotsupp-for-testing.patch
  add BH_Eopnotsupp for testing async barrier failures

handle-async-barrier-failures.patch
  Handle async barrier failures

enable-suspend-resuming-of-e1000.patch
  Enable suspend/resuming of e1000

tty_io-hangup-locking.patch
  tty_io.c hangup locking

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
  CONFIG_PERFCTR=n build fix
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
  perfctr #if/#ifdef cleanup
  perfctr Dothan support
  perfctr x86_tests build fix

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
  perfctr ppc32 update
  perfctr update 4/6: PPC32 cleanups

perfctr-ppc32-buglet-fix.patch
  perfctr ppc32 buglet fix

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
  perfctr update 6/6: misc minor cleanups
  perfctr update 3/6: __user annotations
  perfctr-cpus_complement-fix
  perfctr cpumask cleanup

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr update 2/6: Kconfig-related updates

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr update 5/6: reduce stack usage

perfctr-low-level-documentation.patch
  perfctr low-level documentation

ext3-online-resize-patch.patch
  ext3: online resizing

ext3-online-resize-warning-fix.patch
  ext3-online-resize-warning-fix

altix-serial-driver-2.patch
  Altix serial driver updates
  altix-serial-driver-fix

sched-clean-init-idle.patch
  sched: cleanup init_idle()

sched-clean-fork.patch
  sched: cleanup, improve sched <=> fork APIs

sched-clean-fork-rename-wake_up_new_process-wake_up_new_task.patch
  sched: rename wake_up_new_process -> wake_up_new_task

sched-misc-cleanups-2.patch
  sched: misc cleanups #2

sched-unlikely-rt_task.patch
  sched: make rt_task unlikely

sched-misc.patch
  sched: sched misc changes

sched-misc-fix-rt.patch
  sched: fix RT scheduling & interactivity estimator

sched-no-balance-clone.patch
  sched: disable balance on clone

sched-remove-balance-clone.patch
  sched: remove balance on clone

sched-fork-hotplug-cleanuppatch.patch
  sched: fork hotplug hanling cleanup

memory-backed-inodes-fix.patch
  memory-backed inodes fix

ext3_bread-cleanup.patch
  ext3_bread() cleanup

flexible-mmap-2.6.7-mm3-A8.patch
  i386 virtual memory layout rework

flexible-mmap-bug-fix.patch
  flexible-mmap BUG fix

flexible-mmap-updatepatch-267-mm5.patch
  flexible-mmap update

driver-model-and-sysfs-support-for-pcmcia-1-3.patch
  driver model and sysfs support for PCMCIA (1/3)

update-drivers-net-pcmcia-2-3.patch
  update drivers/net/pcmcia (2/3)

update-drivers-net-wireless-3-3.patch
  update drivers/net/wireless (3/3)

posix-locking-fix-to-posix_same_owner.patch
  posix locking: Minimal fix to posix_same_owner()

posix-locking-fix-to-locking-code.patch
  posix locking: more locking code fixes

posix-locking-fix-up-nfs4statec.patch
  posix locking: Fix up nfs4state.c

posix-locking-fix-up-lockd.patch
  posix locking: Fix up lockd to make use of the new interface

posix-locking-fl_owner_t-to-pid-mapping.patch
  posix locking: mapping between fl_owner_t and client-side "pid"

ide_tf_pio_out_fixes.patch
  ide: PIO-out fixes for ide-taskfile.c (CONFIG_IDE_TASKFILE_IO=n)

ide_tf_pio_out_prehandler.patch
  ide: PIO-out ->prehandler() fixes (CONFIG_IDE_TASKFILE_IO=y)

ide_tf_pio_out_error.patch
  ide: PIO-out error handling fixes (CONFIG_IDE_TASKFILE_IO=y)

ide_task_in_intr.patch
  ide: remove BUSY check from task_in_intr() (CONFIG_IDE_TASKFILE_IO=n)

ide_pre_task_out_intr.patch
  remove pre_task_out_intr() comment (CONFIG_IDE_TASKFILE_IO=n)

ide_pre_task_mulout_intr.patch
  ide: pre_task_mulout_intr() cleanup (CONFIG_IDE_TASKFILE_IO=n)

ide_tf_no_partial.patch
  ide: no partial completions for PIO (CONFIG_IDE_TASKFILE_IO=y)

ide_non_tf_pio.patch
  ide: merge CONFIG_IDE_TASKFILE_IO=y|n PIO handlers together

ide_no_flagged_pio.patch
  ide: use "normal" handlers for "flagged" taskfiles (ide-taskfile.c)

clean-up-module-install-rules.patch
  kbuild: clean up module install rules

kbuild-sort-modules-for-modpost-and-modinst.patch
  kbuild: sort modules for modpost and modinst

intrinsic-automount-and-mountpoint-degradation-support.patch
  intrinsic automount and mountpoint degradation support

intrinsic-automount-and-mountpoint-degradation-support-fix.patch
  intrinsic-automount-and-mountpoint-degradation-support-fix

kafs-automount-support.patch
  kAFS automount support

kafs-automount-support-build-fix.patch
  kafs-automount-support-build-fix

dvdrw-support-for-267-bk13.patch
  DVD+RW support for 2.6.7-bk13

cdrw-packet-writing-support-for-267-bk13.patch
  CDRW packet writing support

dvd-rw-packet-writing-update.patch
  Packet writing support for DVD-RW and DVD+RW discs.

fix-race-in-pktcdvd-kernel-thread-handling.patch
  Fix race in pktcdvd kernel thread handling

fix-open-close-races-in-pktcdvd.patch
  Fix open/close races in pktcdvd

packet-writing-review-fixups.patch
  packet writing: review fixups

remove-pkt_dev-from-struct-pktcdvd_device.patch
  Remove pkt_dev from struct pktcdvd_device

packet-writing-docco.patch
  packet writing documentation

convert-packet-writing-to-seq_file.patch
  packet writing: convert to seq_file

ia64-audit-support.patch
  IA64 audit support

r8169_napi-help-text-2.patch
  R8169_NAPI help text

no-sysgood-for-ptrace-singlestep.patch
  Don't use SYSGOOD for ptrace singlestep

more-mca_legacy-dependencies.patch
  Fix MCA_LEGACY dependencies

use-llseek-instead-of-f_pos=-for-directory-seeking.patch
  Use llseek instead of f_pos= for directory seeking

err2-6-hashbin_remove_this-locking-fix.patch
  err2-6: hashbin_remove_this() locking fix

dm-use-idr.patch
  devicemapper: use an IDR tree for tracking minors

reduce-tlb-flushing-during-process-migration-3.patch
  Reduce TLB flushing during process migration

fix-compile-errors-with-x86_powernow_k78=y-and-acpi_processor=m.patch
  Fix compile errors with X86_POWERNOW_K{7,8}=y and ACPI_PROCESSOR=m

ipc-1-3-add-refcount-to-ipc_rcu_alloc.patch
  ipc: Add refcount to ipc_rcu_alloc

ipc-2-3-remove-sem_revalidate.patch
  ipc: remove sem_revalidate

ipc-3-3-enforce-semvmx-limit-for-undo.patch
  ipc: enforce SEMVMX limit for undo

cleanup-of-ipc-msgc.patch
  cleanup of ipc/msg.c

sk98lin-procfs-fix.patch
  sk98lin procfs fix

cpufreq-driver-for-nforce2-kernel-267.patch
  cpufreq driver for nForce2

mptbase-warning-fix.patch
  mptbase.c warning fix

allow-modular-ide-pnp.patch
  allow modular ide-pnp

remove-dead-isdn-pcmcia-code.patch
  remove dead isdn pcmcia code

i2c-i2c-devci2c_dev_init-cleanup.patch
  i2c/i2c-dev.c::i2c_dev_init() cleanup.

uml-base-patch.patch
  uml: Uml base patch

uml-readds-just-for-now-ghashh-for-uml.patch
  uml: Readds (just for now) ghash.h for UML

uml-avoid-that-gcc-breaks-uml-with-unit-at-a-time-compilation-mode.patch
  uml: Avoid that gcc breaks UML with "unit at a time" compilation mode.

uml-fixes-an-host-fd-leak-caused-by-hostfs.patch
  uml: Fixes an host fd leak caused by hostfs.

uml-adds-legacy_pty-config-option.patch
  uml: Adds LEGACY_PTY config option

uml-makes-make-help-arch=um-work.patch
  uml: Makes "make help ARCH=um" work.

uml-fixes-fixdepc-to-support-arch-um-include-uml-configh.patch
  uml: Fixes "fixdep.c" to support arch/um/include/uml-config.h.

uml-kill-useless-warnings.patch
  uml: Kill useless warnings

uml-avoids-compile-failure-when-host-misses-tkill.patch
  uml: Avoids compile failure when host misses tkill().

uml-reduces-code-in-_user-files-by-moving-it-in-_kern-files-if-already-possible.patch
  uml: Reduces code in *_user files, by moving it in _kern files if already possible.

uml-fixes-raw-and-uses-it-in-check_one_sigio-also-fixes-a-silly-panic-eintr-returned-by-call.patch
  uml: Fixes raw() and uses it in check_one_sigio; also fixes a silly panic (EINTR returned by call).

uml-folds-hostaudio_userc-into-hostaudio_kernc.patch
  uml: Folds hostaudio_user.c into hostaudio_kern.c.

uml-use-ptrace_scemu-the-so-called-sysemu-to-reduce-syscall-cost.patch
  uml: Use PTRACE_SCEMU (the so-called SYSEMU) to reduce syscall cost.

uml-adds-the-nosysemu-command-line-parameter-to-disable-sysemu.patch
  uml: Adds the "nosysemu" command line parameter to disable SYSEMU

uml-adds-proc-sysemu-to-toggle-sysemu-usage.patch
  uml: Adds /proc/sysemu to toggle SYSEMU usage.

uml-fix-for-sysemu-patches.patch
  uml: Fix for sysemu patches

uml-handles-correctly-errno-==-eintr-in-lots-of-places.patch
  uml: Handles correctly errno == EINTR in lots of places.

uml-adds-some-exports.patch
  uml: Adds some exports

uml-avoids-a-panic-for-a-legal-situation.patch
  uml: Avoids a panic for a legal situation

uml-removes-dead-code-in-trap_kernc.patch
  uml: Removes dead code in trap_kern.c

uml-make-malloc-call-vmalloc-if-needed-needed-for-hostfs-on-26-host.patch
  uml: Make malloc() call vmalloc if needed. Needed for hostfs on 2.6 host.

uml-little-kmalloc.patch
  uml: little-kmalloc

uml-fix-os_process_pc-and-os_process_parent-for-corner-cases.patch
  uml: Fix os_process_pc and os_process_parent for corner cases.

sparse-fix-warnings-in-net-sctp.patch
  sparse: fix warnings in net/sctp/*

fix-warnings-in-net-irda.patch
  sparse: fix warnings in net/irda/*

i810_audio-mmio-support.patch
  i810_audio MMIO support

i810_audio-mmio-support-2.patch
  i810_audio MMIO support #2

fix-warnings-drivers-net-sk98lin-skaddrc.patch
  Fix warnings drivers/net/sk98lin/skaddr.c

kallsyms-ppc32-fix.patch
  kallsyms ppc32 fix

fix-drivers-isdn-hisax-avm_pcic-build-warning-when.patch
  Fix drivers/isdn/hisax/avm_pci.c build warning when !CONFIG_ISAPNP

idr-stale-comment.patch
  idr.c: remove stale comment

noexec-kernel-parameters-update.patch
  update kernel-parameters.txt for the noexec option

bio_copy_user-cleanups.patch
  bio_copy_user() cleanups

cfq-bad-allocation.patch
  cfq: bad allocation

fat-update-document.patch
  FAT: update document

use-null-instead-of-integer-0-in-security-selinux.patch
  Use NULL instead of integer 0 in security/selinux/

int-return-to-unsigned-in-smb_proc_readdir_long-in.patch
  int return to unsigned in smb_proc_readdir_long() in fs/smbfs/proc.c

trivial-scripts_kernel-doc-ignoring-embedded-structs-shouldnt.patch
  trivial: scripts_kernel-doc: ignoring embedded structs shouldn't be

trivial-scripts_kernel-doc-missing-bracket.patch
  trivial: scripts_kernel-doc: missing bracket.

trivial-little-arch_i386_kernel_timers_timer_nonec-fix.patch
  trivial: little arch_i386_kernel_timers_timer_none.c fix

trivial-rcs___ignore-quilt-backup-files.patch
  trivial: RCS___IGNORE quilt backup files

trivial-remove-warning-in-ftape.patch
  trivial: remove warning in ftape

trivial-arch_i386_kernel_scx200c-kill-duplicate.patch
  trivial: arch_i386_kernel_scx200.c: kill duplicate #include

trivial-kill-off-config_pci_console.patch
  trivial: kill off CONFIG_PCI_CONSOLE

idr-comments-updates.patch
  idr comments updates

convert-uses-of-zone_highmem-to-is_highmem.patch
  convert uses of ZONE_HIGHMEM to is_highmem

smbfs-compilation-warning-in-267.patch
  smbfs compilation warning fix

remove-always-false-check-in-mm-slabc.patch
  Remove always false check in mm/slab.c

detect-too-early-schedule-attempts.patch
  detect too early schedule attempts

correct-return-type-of-hashfn-in-fs-dquotc.patch
  Correct return type of hashfn() in fs/dquot.c

schedule-profiling.patch
  schedule() profiling
  From: Arjan van de Ven <arjanv@redhat.com>
  Subject: Re: schedule profileing

fix-misplaced-inline-in-include-linux-iso_fsh.patch
  Fix misplaced 'inline' in include/linux/iso_fs.h

pagefault-readaround-fix.patch
  pagefault readaround fix

add-a-few-might_sleep-checks.patch
  Add a few might_sleep() checks

trivial-fix-to-include-scsi-scsi_deviceh.patch
  warning fix to include/scsi/scsi_device.h

ia64-ptrace-fix-fix.patch
  Make get_user_pages() work again for ia64 gate area

possible-buglet-in-drivers-input-joystick-tmdcc.patch
  Possible buglet in drivers/input/joystick/tmdc.c

alpha-print-the-symbol-name-in-oops.patch
  Alpha: print the symbol name in Oops

port-acpi-sleep-workaround-to-new-dmi-probing.patch
  port ACPI sleep workaround to new DMI probing

dmi-isnt-broken-anymore.patch
  DMI isn't broken anymore

fix-crc16-misnaming.patch
  fix CRC16 misnaming

crc16-kconfig-touchups.patch
  crc16 kconfig touchups

crc16-renaming-in-ax25-drivers.patch
  CRC16 renaming in AX25 drivers

crc16-renaming-in-irda-drivers.patch
  CRC16 renaming in IRDA drivers

crc16-renaming-in-isdn-drivers.patch
  CRC16 renaming in ISDN drivers

crc16-renaming-in-ppp-driver.patch
  CRC16 renaming in PPP driver

crc16-renaming-in-via-velocity-ethernet-driver.patch
  CRC16 renaming in VIA Velocity ethernet driver

sh64-cpumask-cleanup.patch
  sh64: cpumask cleanup.

sh64-fix-init_taskc-build.patch
  sh64: Fix init_task.c build.

sh64-add-asm-sh64-setuph.patch
  sh64: Add asm-sh64/setup.h

sh64-defconfig-update.patch
  sh64: defconfig update.

add-missing-sysfs-support-to-cpia-webcam-video-driver.patch
  add missing sysfs support to CPiA webcam video driver

tmpfs-scheduling-while-atomic-fix.patch
  tmpfs: scheduling-while-atomic fix

ad1889-warning-fix.patch
  ad1889 warning fix

writepage-fs-corruption-fixes.patch
  writepage fs corruption fix

block_write_full_page-comment-fixes.patch
  __block_write_full_page() comment fixups

deflate-remove-lazy-allocation.patch
  deflate: remove lazy allocation



