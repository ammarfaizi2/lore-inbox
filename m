Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWB1MZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWB1MZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWB1MZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:25:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750860AbWB1MZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:25:44 -0500
Date: Tue, 28 Feb 2006 04:24:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc5-mm1
Message-Id: <20060228042439.43e6ef41.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/


- A large procfs rework from Eric Biederman.

- The swap prefetching patch is back.



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it's not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.



Changes since 2.6.16-rc4-mm2:

 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-blktrace.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-rc-fixes.patch
 git-sas-jg.patch
 git-sparc64.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-xfs.patch
 git-viro-bird-uml.patch
 git-viro-bird-frv.patch
 git-viro-bird-misc.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees

-scsi-aha152x-fixes.patch
-cache-align-futex-hash-buckets.patch
-m32r-enable-asm-code-optimization.patch
-m32r-fix-and-update-for-gcc-40.patch
-remove-module_parm.patch
-snd-cs4236-tpyo-fix.patch
-alsa-fix-bogus-snd_device_free-in-opl3-ossc.patch
-uml-correct-error-messages-in-cow-driver.patch
-uml-fix-usage-of-kernel_errno-in-place-of-errno.patch
-uml-fix-unused-attribute.patch
-uml-os_connect_socket-error-path-fixup.patch
-uml-better-error-reporting-for-read_output.patch
-uml-tidying-cow-code.patch
-vgacon-no-vertical-resizing-on-ega.patch
-kprobes-causes-nx-protection-fault-on-i686-smp.patch
-powerpc-fix-altivec_unavailable_exception-oopses.patch
-cfi-init-wait-queue-in-chip-struct.patch
-voyager-fix-boot-panic-by-adding-topology-export.patch
-voyager-fix-the-cpu_possible_map-to-make-voyager-boot-again.patch
-page-migration-fix-mpol_interleave-behavior-for-migration-via.patch
-x86-fix-smp-boot-sequence.patch
-x86-fix-smp-boot-sequence-fix.patch
-gbefb-ip32-gbefb-depth-change-fix.patch
-gbefb-set-default-of-fb_gbe_mem-to-4-mb.patch
-au1100fb-replaced-io_remap_page_range-with-io_remap_pfn_range.patch
-asiliantfb-fix-pseudo_palette-setup-in-asiliantfb_setcolreg.patch
-flags-parameter-for-linkat.patch
-flags-parameter-for-linkat-fix.patch
-vmscan-fix-zone_reclaim.patch
-gregkh-driver-sysfs-relay-channel-buffers-as-sysfs-attributes.patch
-gregkh-driver-relay-consolidate-relayfs-core-into-kernel-relay.c.patch
-gregkh-driver-sysfs-update-relay-file-support-for-generic-relay-api.patch
-gregkh-driver-relayfs-remove-relayfs-in-favour-of-config_relay.patch
-gregkh-driver-relay-relay-header-cleanup.patch
-gregkh-driver-sysfs-add-__attr_relay-helper-for-relay-attributes.patch
-add-cpia2-camera-support.patch
-drivers-net-tlanc-ifdef-config_pci-the-pci-specific-code.patch
-git-pcmcia-fixup.patch
-git-scsi-misc-restore-zeroing-of-packet_command-struct-in-sr_ioctlc.patch
-x86_64-mm-no_iommu-removal-in-pci-gartc.patch
-x86_64-mm-fix-user_ptrs_per_pgd.patch
-powerpc-newline-for-isync_on_smp.patch
-powerpc-native-atomic_add_unless.patch
-sem2mutex-nfs-idmapc.patch

 Merged

+move-pci_dev_put-outside-a-spinlock.patch
+x86-microcode-driver-vs-hotplug-cpus.patch
+x86-microcode-driver-vs-hotplug-cpus-fix.patch
+fix-sys_migrate_pages-move-all-pages-when-invoked-from-root.patch
+powerpc-vdso-64bits-gettimeofday-bug.patch
+fuse-fix-bug-in-negative-lookup.patch
+s390-multiple-subchannel-sets-support-fix.patch
+drives-mtd-redbootc-recognise-a-foreign-byte-sex-partition-table.patch
+altix-more-ioc3-cleanups.patch
+video1394-fix-return-e-typo.patch
+tty-buffering-comment-out-debug-code.patch
+remove_from_swap-fix-locking.patch
+nommu-implement-vmalloc_node.patch
+mips-only-include-iomap-on-systems-with-pci.patch
+add-mm-task_size-and-fix-powerpc-vdso.patch

 2.6.16 queue (mostly)

+dont-check-vfree-argument-for-null-in-vx_pcm.patch
+dont-check-vfree-arg-for-null-in-usbaudio.patch
+dont-null-check-vfree-argument-in-pdaudiocf_pcm.patch

 ALSA cleanups

-git-audit-inotify_inode_queue_event-fix.patch
-sem2mutex-audit_netlink_sem.patch

 Dropped due to droppage of git-audit-master.patch

+gregkh-driver-driver-core-add-macros-notice-dev_notice.patch

 driver tree update

+input-pcspkr-device-and-driver-separation.patch
+input-pcspkr-device-and-driver-separation-fix.patch
+input-pcspkr-device-and-driver-separation-fix-2.patch
+input-pcspkr-device-and-driver-separation-fix-3.patch

 PC speaker refactoring

-sata-acpi-build.patch
-sata-acpi-objects-support.patch
-additional-libata-parameters.patch

 Old. Dropped.

+mmc-au1xmmc-fix-compilation-error-by-using-platform_driver.patch
+mmc-au1xmmc-fix-linking-error-because-mmc_rsp_type-doesnt-exist.patch
+mmc-au1xmmc-fix-a-compilation-warning-status-is-not-used.patch

 MMC driver fixes

+ne2000-kconfig-help-entry-improvement.patch
+de620-fix-section-mismatch-warning.patch
+via-velocity-massive-memory-corruption-with-jumbo-frames.patch

 netdev fixes

+git-net-fixup.patch

 Fix reject in git-net.patch

+net-socket-timestamp-32-bit-handler-for-64-bit-kernel-fix.patch

 Nicen net-socket-timestamp-32-bit-handler-for-64-bit-kernel-tidy.patch

+atm-fix-section-mismatch-warnings-in-fore200ec.patch
+wan-fix-section-mismatch-warning-in-sbni.patch

 Net fixlets

+gregkh-pci-acpiphp-fix-bridge-handle.patch

 PCI tree update

+small-whitespace-cleanup-for-qlogic-driver.patch

 qlogic cleanup

+git-scsi-rc-fixes-fixup.patch

 Fix rejects in git-scsi-rc-fixes.patch

+gregkh-usb-usb-reduce-syslog-clutter.patch

 USB tree update

+x86_64-mm-raw1394-compat.patch
+x86_64-mm-prefetch-the-mmap_sem-in-the-fault-path.patch
+x86_64-mm-kernel-at-2mb.patch
+x86_64-mm-empty-pxm.patch
+x86_64-mm-s-overwrite-override--in-arch-x86-64.patch
+x86_64-mm-dmi-year.patch
+x86_64-mm-dmi-early.patch
+x86_64-mm-fixmap-init.patch
+x86_64-mm-head-first.patch
+x86_64-mm-drop-iommu-bus-check.patch
+x86_64-mm-year-check.patch
+x86_64-mm-time-style.patch
+x86_64-mm-reenable-cmos-warning.patch
+x86_64-mm-c3-timer-check-amd.patch

 x86_64 tree updates

+x86_64-mm-dmi-year-fix.patch
+revert-x86_64-mm-dmi-early.patch
+x86_64-mm-c3-timer-check-amd-fix.patch

 Fix it.

+vmscan-use-unsigned-longs-shrink_all_memory-fix.patch

 Update vmscan-use-unsigned-longs.patch

+uninline-sys_mmap-common-code-reduce-binary-size.patch
+vmscan-remove-obsolete-checks-from-shrink_list-and-fix-unlikely-in-refill_inactive-zone.patch
+page-migration-fail-if-page-is-in-a-vma-flagged-vm_locked.patch
+usb-fix-ehci-bios-handshake.patch
+shmem-inline-to-avoid-warning.patch
+readahead-prev_page-can-overrun-the-ahead-window.patch
+readahead-fix-initial-window-size-calculation.patch
+enable-mprotect-on-huge-pages.patch
+hugepage-small-fixes-to-hugepage-clear-copy-path.patch
+hugepage-small-fixes-to-hugepage-clear-copy-path-tidy.patch
+hugepage-serialize-hugepage-allocation-and-instantiation.patch
+hugepage-serialize-hugepage-allocation-and-instantiation-tidy.patch
+hugepage-strict-page-reservation-for-hugepage-inodes.patch
+mm-make-shrink_all_memory-try-harder.patch

 Various mm things.

+mm-implement-swap-prefetching.patch
+mm-implement-swap-prefetching-fix.patch

 Bring back swap-prefetch.

+selinux-fix-hard-link-count-for-selinuxfs-root-directory.patch

 Fix SELinux patches in -mm.

+x86-start-early_printk-at-sensible-screen-row.patch
+x86-early-printk-remove-max_ypos-and-max_xpos-macros.patch
+i386-more-vsyscall-documentation.patch
+fix-implicit-declaration-of-get_apic_id-in-arch-i386-kernel-apicc.patch
+fix-the-imlicit-declaration-of-mtrr_centaur_report_mcr-in-arch-i386-kernel-cpu-centaurc.patch
+fix-the-imlicit-declaration-of-mtrr_centaur_report_mcr-in-arch-i386-kernel-cpu-centaurc-fix.patch

 x86 updates

+x86_64-clean-up-timer-messages.patch

 x86_64 fixlet.

+sem2mutex-blockdev-2-git-blktrace-fix.patch

 Restored.

+cpuset-memory-spread-slab-cache-filesys.patch
+cpuset-memory-spread-slab-cache-format.patch

 Apply cpuset slab spreading to lots of inode caches.

+add-missing-ifdef-for-via-rng-code.patch
+constify-tty-flip-buffer-handling.patch
+let-dac960-supply-entropy-to-random-pool.patch
+drivers-block-nbdc-dont-defer-compile-error-to-runtime.patch
+hysdn-remove-custom-types.patch
+remove-module_parm.patch
+remove-module_parm-fix.patch
+kernel-paramsc-make-param_array-static.patch
+fix-edd-to-properly-ignore-signature-of-non-existing-drives.patch
+fix-defined-but-not-used-warning-in-net-rxrpc-maincrxrpc_initialise.patch
+sysrq-cleanup.patch
+cache-align-futex-hash-buckets.patch
+inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch
+inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix.patch
+ide-fix-section-mismatch-warning.patch
+block-floppy-fix-section-mismatch-warnings.patch
+move-pp_major-from-ppdevh-to-majorh.patch
+pnp-modalias-sysfs-export.patch
+mark-unwind-info-for-signal-trampolines-in-vdsos.patch

 Misc patches.

+copy_process-cleanup-bad_fork_cleanup_signal-update.patch

 Fix copy_process-cleanup-bad_fork_cleanup_signal.patch

-tiny-configurable-support-for-pci-serial-ports.patch

 Dropped.

+kprobe-handler-discard-user-space-trap.patch

 kprobes fix.

+sched-smpnice-fix-average-load-per-run-queue-calculations.patch

 Update sched-implement-smpnice.patch

+oss-sonicvibesc-defines-its-own-hweight32.patch

 Remove private hweight32()

+unify-pfn_to_page-sparc64-pfn_to_page-fix.patch

 Fix unify-pfn_to_page-sparc64-pfn_to_page.patch

+for_each_online_pgdat-take2-define.patch
+for_each_online_pgdat-take2-for_each_bootmem.patch
+for_each_online_pgdat-take2-renaming.patch
+for_each_online_pgdat-take2-remove-sorting-pgdat.patch
+for_each_online_pgdat-take2-remove-pgdat_list.patch

 Clean up iterating over NUMA node memory structures.

+uninline-zone-helpers.patch
+uninline-zone-helpers-fix.patch
+uninline-zone-helpers-prefetch-fix.patch

 Uninline a few things.

+mips-fixed-collision-of-rtc-function-name.patch
+rtc-subsystem-library-functions.patch
+rtc-subsystem-class.patch
+rtc-subsystem-class-fix.patch
+rtc-subsystem-class-fix-2.patch

 Updated rtc subsystem patches

+trivial-cleanup-to-proc_check_chroot.patch
+proc-fix-the-inode-number-on-proc-pid-fd.patch
+proc-remove-useless-bkl-in-proc_pid_readlink.patch
+proc-remove-unnecessary-and-misleading-assignments.patch
+proc-simplify-the-ownership-rules-for-proc.patch
+proc-replace-proc_inodetype-with-proc_inodefd.patch
+proc-remove-bogus-proc_task_permission.patch
+proc-kill-proc_mem_inode_operations.patch
+proc-properly-filter-out-files-that-are-not-visible.patch
+proc-fix-the-link-count-for-proc-pid-task.patch
+proc-move-proc_maps_operations-into-task_mmuc.patch
+dcache-add-helper-d_hash_and_lookup.patch
+proc-rewrite-the-proc-dentry-flush-on-exit.patch
+proc-close-the-race-of-a-process-dying-durning.patch
+proc-refactor-reading-directories-of-tasks.patch
+proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
+tref-implement-task-references.patch
+proc-dont-lock-task_structs-indefinitely.patch
+proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
+proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
+proc-optimize-proc_check_dentry_visible.patch

 procfs rework.

+ide_generic_all_on-warning-fix.patch

 Fix IDE warning

+vgacon-fix-ega-cursor-resize-function.patch

 vgacon fix

+fbdev-framebuffer-driver-for-geode-gx-Kconfig-fix.patch

 Fix fbdev-framebuffer-driver-for-geode-gx.patch

+kgdb-ga-remove-stuff.patch
+kgdb-remove-NO_CPUS.patch
+kgdb-remove-KGDB_TS.patch
+kgdb-remove-STACK_OVERFLOW_TEST.patch
+kgdb-remove-TRAP_BAD_SYSCALL_EXITS.patch
+kgdb-always-KGDB_CONSOLE.patch
+kgdb-remove-CONFIG_KGDB_USER_CONSOLE.patch
+kgdb-serial-cleanup.patch
+kgdb-serial-cleanup-2.patch
+kgdb-serial-cleanup-3.patch
+kgdb-nmi-cleanup.patch
+kgdb-cleanup-version.patch
+kgdb-cleanup-includes.patch
+kgdb-remove-KGDB_SYSRQ.patch
+kgdb-rename-breakpoint.patch
+kgdb-convert-for-cpu-helpers.patch
+kgdb-select-debug_info.patch

 The -mm kgdb stub is rotting a bit.  Before fixing it I need to be able to
 read it.

-kgdboe-netpoll.patch
-kgdb-x86_64-support.patch

 These broke.

+revert-tty-buffering-comment-out-debug-code.patch

 tty debugging patch for -mm.

+vfree-null-check-fixup-for-sb_card.patch
+maestro3-vfree-null-check-fixup.patch
+no-need-to-check-vfree-arg-for-null-in-oss-sequencer.patch
+vfree-does-its-own-null-check-no-need-to-be-explicit-in-oss-msndc.patch
+fix-signed-vs-unsigned-in-nmi-watchdog.patch
+trivial-typos-in-documentation-cputopologytxt.patch

 Little fixes



All 1259 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/patch-list


