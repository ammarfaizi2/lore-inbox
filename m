Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUIMIxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUIMIxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 04:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUIMIxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 04:53:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:53659 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266459AbUIMIv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 04:51:59 -0400
Date: Mon, 13 Sep 2004 01:50:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm5
Message-Id: <20040913015003.5406abae.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at

 http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/

and will later appear at

 ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm5/

Please check kernel.org before using zip.com.au.



- Added the `bk-scsi-target' tree to the -mm lineup.  It is managed by James
  Bottomley 

- Some enhancements to the ext3 block reservation code here.  Please cc
  sct@redhat.com on oops reports ;)

- There's a patch here which will cause warnings if a PCI device driver is
  removed without having called pci_disable_device().  Please try to cc the
  appropriate mailing list or maintainer when reporting any instances.




Changes since 2.6.9-rc1-mm4:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-ia64.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-netdev.patch
 bk-pci.patch
 bk-pnp.patch
 bk-power.patch
 bk-scsi.patch
 bk-scsi-target.patch
 bk-usb.patch
 bk-watchdog.patch

 External trees

-pkt_act-fix.patch -ksysfs-build-fix.patch -ppc-build-fix.patch
-ppc64-allow-sd_nodes_per_domain-to-be-overridden.patch
-ppc64-fix-hang-on-oprofile-shutdown.patch
-ppc64-fix-__rw_yield-prototype.patch
-ppc64-be-resilient-against-sysfs-pci-config-accesses.patch
-ppc64-cut-down-paca-footprint.patch -ppc64-fix-boot-memory-reporting.patch
-ppc64-fix-power5-js20-smp-init.patch
-cleanup-fix-lost-ticks-handling-on-x86-64.patch
-factor-out-common-asm-hardirqh-code.patch
-scsi-qla2xxx-fix-inline-compile-errors.patch
-add-pci_fixup_enable-pass.patch
-cleanup-ptrace-stops-and-remove-notify_parent.patch
-cleanup-ptrace-stops-and-remove-notify_parent-extra.patch
-ptrace-api-preservation.patch
-nix-rusage_group.patch
-i386-syscall-tracing-of-bogus-system-calls.patch
-make-single-step-into-signal-delivery-stop-in-handler.patch
-cdrom-range-fixes.patch
-vsxxxaac-fixups.patch
-disambiguate-espc-clones.patch
-allow-cluster-wide-flock.patch
-allow-cluster-wide-flock-update.patch
-filemap-read-fix.patch
-fix-f_version-optimization-for-get_tgid_list.patch
-kernel-sysfs-events-layer.patch
-centralize-some-nls-helpers.patch
-remove-unused-sysctls-from-kernel-personalityc.patch
-fs-compatc-rwsem-instead-of-bkl-around-ioctl32_hash_table.patch
-small-wait_on_page_writeback_range-optimization.patch
-3w-xxxxc-queue-depth.patch
-md-correct-working_disk-counts-for-raid5-and-raid6.patch
-knfsd-calls-to-break_lease-in-nfsd-should-be-o_nonblocking.patch
-knfsd-return-eacces-instead-of-estale-for-certain-filehandle-lookup-failures.patch
-knfsd-fix-incorrect-indentation-in-fh_verify.patch
-nfsd4-support-acl_support-attribute.patch
-knfsd-trivial-cleanup-of-nfs4statec.patch
-nfsd4-could-leak-a-stateid-in-an-error-path.patch
-nfsd4-postpone-release-of-stateowner-on-close.patch
-nfsd4-store-current-tgid-instead-of-lockowner-hash-in-fl_pid.patch
-knfsd-remove-redundant-initialization-in-nfsd4_lockt.patch
-remove-in-kernel-init_module-cleanup_module-stubs.patch
-remove-ext2_panic.patch
-s390-export-copy_in_user.patch
-s390-minmax-removal-arch-s390-kernel-debugc.patch
-s390-packed-stack-vs-cpu-hotplug.patch
-s390-lcs-multicast-deadlock.patch
-allow-i8042-register-location-override-2.patch
-zlib_inflate-move-zlib_inflatesync-friends.patch
-zlib_inflate-make-zlib_inflate_trees_fixed-generate-the-table.patch
-ppc32-switch-arch-ppc-boot-to-lib-zlib_inflate.patch
-ext3-dreference-of-sb-preceeds-check.patch
-fbdev-speed-up-scrolling-of-tdfxfb.patch
-fbdev-ppc-crash-and-other-fixes-for-rivafb.patch
-fbcon-take-over-console-on-driver-registration.patch
-fbdev-clean-up-framebuffer-initialization.patch
-fbdev-add-module_init-and-fb_get_options-per-driver.patch
-remove-bogus-memset-from-cpqfc-driver.patch
-hpt366-ptr-use-before-null-check.patch
-crypto-teac-xtea_encrypt-should-use-xtea_delta.patch
-aio-dio-oops-fix.patch
-riscom8-build-fix.patch
-use-for_each_cpu-in-oprofile-code.patch
-fix-oprofile-vfree-warning-on-error.patch
-speed-up-oprofile-buffer-drain-code.patch
-speed-up-oprofile-buffer-drain-code-fix.patch
-cdu31a-build-fix.patch
-synclinkc-kernel-janitor-changes.patch
-adfs-add-static.patch
-isofs-add-static.patch
-correct-elf-section-used-for-out-of-line-spinlocks.patch
-tsc-synchronisation-cleanup.patch
-add-static-in-affs.patch
-add-static-in-afs.patch
-add-static-in-befs.patch
-codemercs-io-warrior-support.patch
-fat-use-hlist_head-for-fat_inode_hashtable-1-4.patch
-fat-rewrite-the-cache-for-file-allocation-table-lookup.patch
-fat-cache-lock-from-per-sb-to-per-inode-3-4.patch
-fat-the-inode-hash-from-per-module-to-per-sb-4-4.patch
-uml-avoid-using-elv_queue_empty.patch
-uml-avoid-forcing-use-of-the-no-op-scheduler.patch
-uml-correct-the-failure-path-in-start_io_thread.patch
-fix-address_spacei_mmap-comment.patch
-remove-mod_incdec_use_count-users-that-got-back-in.patch
-dont-mention-mod_incdec_use_count-in-documentation.patch

Merged

+remove-set_fs-from-compat-sched-affinity-syscalls.patch

 Remove the set_fs hack in the compat affinity calls.

+allow-compat-long-sized-bitmasks-in-affinity-code.patch

 compat_sys_sched_getaffity() fix

+fix-schedstats-null-deref-in-sched_exec.patch

 Fix an oops

+rock-fix.patch

 Fix the rock.c driver

-es7000-subarch-update.patch
+2681-es7000-subarch-update.patch

 New es7000 update

+exec-fix-posix-timers-leak-and-pending-signal-loss.patch

 Fix some leaks

+fix-abi-in-set_mempolicy.patch

 Fix up the numa memory policy stuff

+ksysfs-warning-fix.patch
+kobject_uevent-warning-fix.patch
+fix-smm-failures-on-e750x-systems.patch
+vsxxxaac-fixups.patch
+allow-i8042-register-location-override-2.patch
+tmscsim-build-fix.patch

 Various fixes for various people's bk trees

+swsusp-documentation-update.patch
+small-cleanups-for-swsusp.patch
+swsusp-kill-crash-when-too-much-memory-is-free.patch
+swsusp-progress-in-percent.patch
+swsusp-clean-up-reading.patch
+swsusp-another-simplification.patch
+acpi-proc-simplify-error-handling.patch

 swsusp stuff

+ppc64-lparcfg-fixes-for-processor-counts.patch
+ppc64-lparcfg-whitespace-and-wordwrap-cleanup.patch
+ppc64-remove-spinline-config-option.patch
+ppc64-rtas-error-logs-can-appear-twice-in-dmesg.patch
+ppc64-enable-numa-api.patch
+ppc64-give-the-kernel-an-opd-section.patch
+ppc64-use-nm-synthetic-where-available.patch
+ppc64-clean-up-kernel-command-line-code.patch
+ppc64-remove-unused-ppc64_calibrate_delay.patch
+ppc64-remove-eeh-command-line-device-matching-code.patch
+ppc64-use-early_param.patch
+ppc64-restore-smt-enabled=off-kernel-command-line-option.patch
+ppc64-enable-power5-low-power-mode-in-idle-loop.patch
+ppc64-clean-up-idle-loop-code.patch
+ppc64-remove-wno-uninitialized.patch
+ppc64-fix-real-bugs-uncovered-by-wno-uninitialized-removal.patch
+ppc64-fix-spurious-warnings-uncovered-by-wno-uninitialized-removal.patch
+hvc-uninitialised-variable.patch
+ppc64-improved-vsid-allocation-algorithm.patch
+ppc64fix-missing-register-in-altivec-context-switch.patch
+ppc32-remove-wno-uninitialized.patch
+ppc32-pmac-cpufreq-for-ibook-2-600.patch

 ppc[64] updates

-pid_max-fix.patch

 Dropped - wli fixed this by other means.

+lockmeter.patch

 Repaired lockmeter patch

+ext3-reservations-spelling-fixes.patch
+ext3-reservations-renumber-the-ext3-reservations-ioctls.patch
+ext3-reservations-remove-unneeded-declaration.patch
+ext3-reservations-turn-ext3-per-sb-reservations-list-into-an-rbtree.patch
+ext3-reservations-split-the-reserve_window-struct-into-two.patch
+ext3-reservations-smp-protect-the-reservation-during-allocation.patch

 ext3 block reservation enhancements: fix a few things and use an rbtree

+sched-trivial-sched-changes.patch
+sched-add-cpu_down_prepare-notifier.patch
+sched-integrate-cpu-hotplug-and-sched-domains.patch
+sched-arch_destroy_sched_domains-warning-fix.patch
+sched-sched-add-load-balance-flag.patch
+sched-remove-disjoint-numa-domains-setup.patch
+sched-make-domain-setup-overridable.patch
+sched-make-domain-setup-overridable-rename.patch
+sched-ia64-add-disjoint-numa-domain-support.patch
+sched-fix-domain-debug-for-isolcpus.patch
+sched-enable-sd_load_balance.patch
+sched-hotplug-add-a-cpu_down_failed-notifier.patch
+sched-use-cpu_down_failed-notifier.patch
+sched-fixes-for-ia64-domain-setup.patch

 CPU scheduler work.

-journal_clean_checkpoint_list-latency-fix.patch
-filemap_sync-latency-fix.patch
-pty_write-latency-fix.patch

 Dropped these scheduling latency changes - let's see what Ingo's ones look
 like

 propagate-pci_enable_device-errors.patch

+move-syscall-declarations-from-linux-keyh-2.patch
+make-key-management-use-syscalls-not-prctls-build-fix.patch

 Key management code updates

+cachefs-return-the-right-error-upon-invalid-mount.patch
+remove-error-from-linux-cachefsh.patch
+cachefs-warning-fix-2.patch
+cachefs-linkage-fix-2.patch
-cachefs-linkage-fix.patch

 Various updates to cachefs

+cpusets-display-allowed-masks-in-proc-status.patch
+cpusets-simplify-cpus_allowed-setting-in-attach.patch
+cpusets-remove-useless-validation-check.patch
+cpusets-fix-possible-race-in-cpuset_tasks_read.patch
+cpusets-interoperate-with-hotplug-online-maps.patch

 cpusets fixes/updates

+stop-reiser4-from-turning-itself-on-by-default.patch

 reiser4 Kconfig fix

+kallsyms-fix-sparc-gibberish.patch

 Fix endianness in the new kallsyms handling code

+m32r-update-for-profiling.patch
+m32r-update-zone_sizes_init.patch
+m32r-update-to-fix-compile-errors.patch
+m32r-update-uaccessh.patch
+m32r-update-checksum-functions.patch
+m32r-update-cf-pcmcia-drivers.patch
+m32r-update-headers-to-remove-useless-ibcs2-support-code.patch
+atomic_inc_return-for-m32r-re.patch

 m32r updates

-lighten-mmlist_lock.patch

 Dropped - Hugh had second thoughts

+misrouted-irq-recovery-take-2-fix.patch
+misrouted-irq-recovery-docs.patch

 Smarter workarounds for ia32 IRQ routing problems

+cfq-iosched-v2.patch

 Major revamp of the CFQ IO scheduler

+dont-export-blkdev_open-and-def_blk_ops.patch
+remove-dead-code-from-fs-mbcachec.patch
+remove-posix_acl_masq_nfs_mode.patch
+make-kmem_find_general_cachep-static-in-slabc.patch
+dont-export-shmem_file_setup.patch
+remove-pm_find-unexport-pm_send.patch
+remove-dead-code-and-exports-from-signalc.patch
+mark-md_interrupt_thread-static.patch
+unexport-proc_sys_root.patch
+mark-dq_list_lock-static.patch
+unexport-is_subdir-and-shrink_dcache_anon.patch
+unexport-devfs_mk_symlink.patch
+unexport-do_execve-do_select.patch
+unexport-exit_mm.patch
+unexport-files_lock-and-put_filp.patch
+remove-exports-from-audit-code.patch
+unexport-f_delown.patch
+unexport-lookup_create.patch
+remove-wake_up_all_sync.patch
+remove-set_fs_root-set_fs_pwd.patch

 Little fixes/cleanups

+add-prctl-to-modify-current-comm.patch

 Allow current->comm to be modified via prctl()

+md-remove-md_flush_all.patch
+md-make-retry_list-non-global-in-raid1-and-multipath.patch
+md-rationalise-issue_flush-function-in-md-personalities.patch
+md-rationalise-unplug-functions-in-md.patch
+md-make-sure-md-always-uses-rdev_dec_pending-properly.patch
+md-fix-two-little-bugs-in-raid10.patch
+md-modify-locking-when-accessing-subdevices-in-md.patch

 RAID update

+blk-max_sectors-tunables.patch

 Make the per-queue max_sectors tunable for latency purposes

+generic-acl-support-for-permission.patch
+generic-acl-support-for-permission-fix.patch
+generic-acl-support-for-permission-keyfs-fix.patch

 ACL code consolidation

+device-driver-for-the-sgi-system-clock-mmtimer.patch

 New device driver

+rtl8150-fix.patch

 Net driver fix

+close-race-with-preempt-and-modular-pm_idle-callbacks.patch

 Fix a PM idle-handler race

+cacheline-align-pagevec-structure.patch

 Finctune the pagevec size

+hvcs-fix-to-replace-yield-with-tty_wait_until_sent-in.patch

 HVCS driver fix

+fbdev-remove-unnecessary-banshee_wait_idle-from-tdfxfb.patch
+fbdev-fix-logo-drawing-failure-for-vga16fb.patch
+fbdev-initialize-i810fb-after-agpgart.patch
+fbdev-fix-userland-compile-breakage.patch
+fbcon-fix-setup-boot-options-of-fbcon.patch
+fbdev-pass-struct-device-to-class_simple_device_add.patch
+fbdev-add-tile-blitting-support.patch

 fbdev update

+fix-for-spurious-interrupts-on-e100-resume.patch

 e100 PM resume workaround

+r8169-miscalculation-of-available-tx-descriptors.patch
+r8169-hint-for-tx-flow-control.patch
+r8169-tso-support.patch
+r8169-mac-identifier-extracted-from-realteks-driver-v22.patch

 net driver update

+uml-remove-ghash.patch
+uml-eliminate-useless-thread-field.patch
+uml-fix-scheduler-race.patch
+uml-fix-binary-layout-assumption.patch
+uml-disable-pending-signals-across-a-reboot.patch
+uml-refer-to-config_usermode-not-to-config_um.patch
+uml-remove-commented-old-code-in-kconfig.patch
+uml-smp-build-fix.patch
+uml-remove-config_uml_smp.patch

 UML updates

+highmem-flushes.patch

 Missing dcache flushes in the bounce buffering code

+add-support-for-word-length-uart-registers.patch

 Serial driver fix

+compile-fix-3c59x-for-eisa-without-pci.patch

 Net driver build fix

+atomic_inc_return-for-i386.patch
+atomic_inc_return-for-x86_64.patch
+atomic_inc_return-for-arm.patch
+atomic_inc_return-for-arm26.patch
+atomic_inc_return-for-sparc64.patch

 atomic_inc_return() for various architectures

+fix-uninitialized-warnings-in-mempolicyc.patch

 Warning fixes

+online-cpu-with-maxcpus-option-panics.patch

 Fix a crash with maxcpus=

+remove-dead-exports-from-fs-fat.patch
+fat-use-hlist_head-for-fat_inode_hashtable-1-6.patch
+fat-rewrite-the-cache-for-file-allocation-table-lookup.patch
+fat-cache-lock-from-per-sb-to-per-inode-3-6.patch
+fat-the-inode-hash-from-per-module-to-per-sb-4-6.patch
+fat-fix-the-race-bitween-fat_free-and-fat_get_cluster.patch
+fat-remove-debug_pr-6-6.patch

 fatfs update

+small-linux-hardirqh-tweaks.patch

 hardirq.h fixes

+bsd-disklabel-handle-more-than-8-partitions.patch

 Fix BSD disklabels

+asm-softirqh-crept-back-in-h8300-and-sh64.patch

 Remove unneeded files (again)

+mark-amiflop-non-unloadable.patch

 amiflop.c fixlet

+thinkpad-fnfx-key-driver.patch

 Thinkpad function key fixes

+netpoll-endian-fixes.patch

 netpoll fixes on big-endian

+rewrite-alloc_pidmap.patch

 Clean up alloc_pidmap()

+missing-pci_disable_device.patch

 Add a warning to check that drivers have called pci_disable_device() (Uses
 CONFIG_DEBUG_KERNEL, and shouldn't).

+fbdev-radeonfb-remove-bogus-radeonfb_read-write.patch

 radeonfb fix

+add-missing-pci_disable_device-for-pci-based-usb-hcd.patch
+add-missing-pci_disable_device-for-e1000.patch

 Add pci_disable_device() to a couple of drivers

+next_thread-bug-fixes.patch

 Remove some suspect BUG()s from next_thread().



number of patches in -mm: 432
number of changesets in external trees: 554
number of patches in -mm only: 416
total patches: 970




All 432 patches:


linus.patch

remove-set_fs-from-compat-sched-affinity-syscalls.patch
  Remove set_fs() from compat sched affinity syscalls

allow-compat-long-sized-bitmasks-in-affinity-code.patch
  Allow compat long sized bitmasks in affinity code

distinct-tgid-tid-cpu-usage.patch
  distinct tgid/tid CPU usage

fix-schedstats-null-deref-in-sched_exec.patch
  fix schedstats null deref in sched_exec

rock-fix.patch
  rock.c: fix double-kfree()

2681-es7000-subarch-update.patch
  ES7000 subarch update

exec-fix-posix-timers-leak-and-pending-signal-loss.patch
  exec: fix posix-timers leak and pending signal loss

fix-abi-in-set_mempolicy.patch
  Fix ABI in set_mempolicy()

__set_page_dirty_nobuffers-mappings.patch
  __set_page_dirty_nobuffers mappings

sysfs-backing-store-prepare-file_operations.patch
  sysfs backing store - prepare sysfs_file_operations helpers

sysfs-backing-store-prepare-file_operations-fix.patch
  fix oops with firmware loading

sysfs-backing-store-add-sysfs_dirent.patch
  sysfs backing store - add sysfs_direct structure

sysfs-backing-store-use-sysfs_dirent-tree-in-removal.patch
  sysfs backing store: use sysfs_dirent based tree in file removal

sysfs-backing-store-use-sysfs_dirent-tree-in-dir-file_operations.patch
  sysfs backing store: use sysfs_dirent based tree in dir file operations

sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves.patch
  sysfs backing store: stop pinning dentries/inodes for leaf entries

bk-acpi.patch

acpi-compile-fix.patch
  acpi-compile-fix

acpi-x86_64-build-fix.patch
  acpi x86_64 build fix

bk-agpgart.patch

bk-alsa.patch

bk-cpufreq.patch

bk-driver-core.patch

ksysfs-warning-fix.patch
  ksysfs warning fix

kobject_uevent-warning-fix.patch
  kobject_uevent warning fix

bk-ia64.patch

bk-ieee1394.patch

bk-input.patch

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

vsxxxaac-fixups.patch
  vsxxxaa.c fixups

allow-i8042-register-location-override-2.patch
  allow i8042 register location override #2

bk-netdev.patch

bk-pci.patch

bk-pnp.patch

bk-power.patch

bk-scsi.patch

bk-scsi-target.patch

tmscsim-build-fix.patch
  tmscsim-build-fix

bk-usb.patch

bk-watchdog.patch

mm.patch
  add -mmN to EXTRAVERSION

mm-swsusp-make-sure-we-do-not-return-to-userspace-where-image-is-on-disk.patch
  -mm swsusp: make sure we do not return to userspace where image is on disk

mm-swsusp-copy_page-is-harmfull.patch
  -mm swsusp: copy_page is harmfull

swsusp-fix-highmem.patch
  swsusp: fix highmem

swsusp-do-not-disable-platform-swsusp-because-s4bios-is-available.patch
  swsusp: do not disable platform swsusp because S4bios is available

swsusp-fix-default-powerdown-mode.patch
  swsusp: fix default powerdown mode

mark-old-power-managment-as-deprecated-and-clean-it-up.patch
  Mark old power managment as deprecated and clean it up

use-global-system_state-to-avoid-system-state-confusion.patch
  Use global system_state to avoid system-state confusion

swsusp-error-do-not-oops-after-allocation-failure.patch
  swsusp: do not oops after allocation failure

swsusp-documentation-update.patch
  swsusp: Documentation update

small-cleanups-for-swsusp.patch
  Small cleanups for swsusp

swsusp-kill-crash-when-too-much-memory-is-free.patch
  swsusp: kill crash when too much memory is free

swsusp-progress-in-percent.patch
  swsusp: progress in percent

swsusp-clean-up-reading.patch
  swsusp: clean up reading

swsusp-another-simplification.patch
  swsusp: another simplification

acpi-proc-simplify-error-handling.patch
  acpi proc: simplify error handling

pegasus-fixes.patch
  pegasus.c fixes

pointer-dereference-before-null-check-in-acpi-thermal-driver.patch
  Pointer dereference before NULL check in ACPI thermal driver

network-packet-tracer-module-using-kprobes-interface.patch
  Network packet tracer module using kprobes interface.

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

kgdb-is-incompatible-with-kprobes.patch
  kgdb-is-incompatible-with-kprobes

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

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

ppc64-lparcfg-fixes-for-processor-counts.patch
  ppc64: lparcfg fixes for processor counts

ppc64-lparcfg-whitespace-and-wordwrap-cleanup.patch
  ppc64: lparcfg whitespace and wordwrap cleanup.

ppc64-remove-spinline-config-option.patch
  ppc64: remove SPINLINE config option

ppc64-rtas-error-logs-can-appear-twice-in-dmesg.patch
  ppc64: RTAS error logs can appear twice in dmesg

ppc64-enable-numa-api.patch
  ppc64: Enable NUMA API

ppc64-give-the-kernel-an-opd-section.patch
  ppc64: give the kernel an OPD section

ppc64-use-nm-synthetic-where-available.patch
  ppc64: use nm --synthetic where available

ppc64-clean-up-kernel-command-line-code.patch
  ppc64: clean up kernel command line code

ppc64-remove-unused-ppc64_calibrate_delay.patch
  ppc64: remove unused ppc64_calibrate_delay

ppc64-remove-eeh-command-line-device-matching-code.patch
  ppc64: remove EEH command line device matching code

ppc64-use-early_param.patch
  ppc64: use early_param

ppc64-restore-smt-enabled=off-kernel-command-line-option.patch
  ppc64: restore smt-enabled=off kernel command line option

ppc64-enable-power5-low-power-mode-in-idle-loop.patch
  ppc64: enable POWER5 low power mode in idle loop

ppc64-clean-up-idle-loop-code.patch
  ppc64: clean up idle loop code

ppc64-remove-wno-uninitialized.patch
  ppc64: remove -Wno-uninitialized

ppc64-fix-real-bugs-uncovered-by-wno-uninitialized-removal.patch
  ppc64: Fix real bugs uncovered by -Wno-uninitialized removal

ppc64-fix-spurious-warnings-uncovered-by-wno-uninitialized-removal.patch
  ppc64: Fix spurious warnings uncovered by -Wno-uninitialized removal

hvc-uninitialised-variable.patch
  hvc: uninitialised variable

ppc64-improved-vsid-allocation-algorithm.patch
  ppc64: improved VSID allocation algorithm

ppc64fix-missing-register-in-altivec-context-switch.patch
  ppc64: fix missing register in altivec context switch

ppc32-remove-wno-uninitialized.patch
  ppc32: remove -Wno-uninitialized

ppc32-pmac-cpufreq-for-ibook-2-600.patch
  ppc32: pmac cpufreq for ibook 2 600

lazy-tsss-i-o-bitmap-copy-for-x86-64.patch
  lazy TSS's I/O bitmap copy for x86-64

lazy-tsss-i-o-bitmap-copy-for-x86-64-fix.patch
  lazy-tsss-i-o-bitmap-copy-for-x86-64-fix

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix
  lockmeter-build-fix
  lockmeter for x86_64

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

ext3-reservations-spelling-fixes.patch
  ext3 reservations: Spelling fixes

ext3-reservations-renumber-the-ext3-reservations-ioctls.patch
  ext3 reservations: Renumber the ext3 reservations ioctls

ext3-reservations-remove-unneeded-declaration.patch
  ext3 reservations: Remove unneeded declaration.

ext3-reservations-turn-ext3-per-sb-reservations-list-into-an-rbtree.patch
  ext3 reservations: Turn ext3 per-sb reservations list into an rbtree.

ext3-reservations-split-the-reserve_window-struct-into-two.patch
  ext3 reservations: Split the "reserve_window" struct into two

ext3-reservations-smp-protect-the-reservation-during-allocation.patch
  ext3 reservations: SMP-protect the reservation during allocation

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
  perfctr x86 init bug
  perfctr: K8 fix for internal benchmarking code
  perfctr x86 update

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
  perfctr ppc32 update
  perfctr update 4/6: PPC32 cleanups
  perfctr ppc32 buglet fix

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
  perfctr update 6/6: misc minor cleanups
  perfctr update 3/6: __user annotations
  perfctr-cpus_complement-fix
  perfctr cpumask cleanup
  perfctr SMP hang fix

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr update 2/6: Kconfig-related updates

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr update 5/6: reduce stack usage

perfctr-low-level-documentation.patch
  perfctr low-level documentation
  perfctr documentation update

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance 1/3: driver updates
  perfctr inheritance illegal sleep bug

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance 2/3: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance 3/3: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

ext3-online-resize-patch.patch
  ext3: online resizing
  ext3-online-resize-warning-fix

sched-trivial-sched-changes.patch
  sched: trivial sched changes

sched-add-cpu_down_prepare-notifier.patch
  sched: add CPU_DOWN_PREPARE notifier

sched-integrate-cpu-hotplug-and-sched-domains.patch
  sched: integrate cpu hotplug and sched domains

sched-arch_destroy_sched_domains-warning-fix.patch
  sched: arch_destroy_sched_domains warning fix

sched-sched-add-load-balance-flag.patch
  sched: sched add load balance flag

sched-remove-disjoint-numa-domains-setup.patch
  sched: remove disjoint NUMA domains setup

sched-make-domain-setup-overridable.patch
  sched: make domain setup overridable

sched-make-domain-setup-overridable-rename.patch
  sched-make-domain-setup-overridable: rename IDLE

sched-ia64-add-disjoint-numa-domain-support.patch
  sched: IA64 add disjoint NUMA domain support

sched-fix-domain-debug-for-isolcpus.patch
  sched: fix domain debug for isolcpus

sched-enable-sd_load_balance.patch
  sched: enable SD_LOAD_BALANCE

sched-hotplug-add-a-cpu_down_failed-notifier.patch
  sched: hotplug add a CPU_DOWN_FAILED notifier

sched-use-cpu_down_failed-notifier.patch
  sched: use CPU_DOWN_FAILED notifier

sched-fixes-for-ia64-domain-setup.patch
  sched: fixes for ia64 domain setup

nicksched.patch
  nicksched

nicksched-sched_fifo-fix.patch
  nicksched: SCHED_FIFO fix

sched-smtnice-fix.patch
  sched: SMT nice fix

ext3_bread-cleanup.patch
  ext3_bread() cleanup

pcmcia-implement-driver-model-support.patch
  pcmcia: implement driver model support

pcmcia-update-network-drivers.patch
  pcmcia: update network drivers

pcmcia-update-wireless-drivers.patch
  pcmcia: update wireless drivers

pcmcia-fix-eject-lockup.patch
  pcmcia: fix eject lockup

pcmcia-add-hotplug-support.patch
  pcmcia: add *hotplug support

linux-2.6.8.1-49-rpc_workqueue.patch
  nfs: RPC: Convert rpciod into a work queue for greater flexibility

linux-2.6.8.1-50-rpc_queue_lock.patch
  nfs: RPC: Remove the rpc_queue_lock global spinlock

dvdrw-support-for-267-bk13.patch
  DVD+RW support for 2.6.7-bk13

packet-writing-credits.patch
  packet-writing: add credits

cdrw-packet-writing-support-for-267-bk13.patch
  CDRW packet writing support
  packet: remove #warning
  packet writing: door unlocking fix
  pkt_lock_door() warning fix
  Fix race in pktcdvd kernel thread handling
  Fix open/close races in pktcdvd
  packet writing: review fixups
  Remove pkt_dev from struct pktcdvd_device
  packet writing: convert to seq_file

dvd-rw-packet-writing-update.patch
  Packet writing support for DVD-RW and DVD+RW discs.
  Get blockdev size right in pktcdvd after switching discs

packet-writing-docco.patch
  packet writing documentation
  Trivial CDRW packet writing doc update

control-pktcdvd-with-an-auxiliary-character-device.patch
  Control pktcdvd with an auxiliary character device
  Subject: Re: 2.6.8-rc2-mm2
  control-pktcdvd-with-an-auxiliary-character-device-fix

simplified-request-size-handling-in-cdrw-packet-writing.patch
  Simplified request size handling in CDRW packet writing

fix-setting-of-maximum-read-speed-in-cdrw-packet-writing.patch
  Fix setting of maximum read speed in CDRW packet writing

packet-writing-reporting-fix.patch
  Packet writing reporting fixes

speed-up-the-cdrw-packet-writing-driver.patch
  Speed up the cdrw packet writing driver

packet-writing-avoid-bio-hackery.patch
  packet writing: avoid BIO hackery

cdrom-buffer-size-fix.patch
  cdrom: buffer sizing fix

cpufreq-driver-for-nforce2-kernel-267.patch
  cpufreq driver for nForce2

allow-modular-ide-pnp.patch
  allow modular ide-pnp

create-nodemask_t.patch
  Create nodemask_t
  nodemask fix
  nodemask build fix

b44-add-47xx-support.patch
  b44: add 47xx support

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

serial-cs-and-unusable-port-size-ranges.patch
  serial-cs and unusable port size ranges

add-support-for-it8212-ide-controllers.patch
  Add support for IT8212 IDE controllers

i386-hotplug-cpu.patch
  i386 Hotplug CPU

hotplug-cpu-fix-apic-queued-timer-vector-race.patch
  Hotplug cpu: Fix APIC queued timer vector race

hotplug-cpu-move-cpu_online_map-clear-to-__cpu_disable.patch
  Hotplug cpu: Move cpu_online_map clear to __cpu_disable

igxb-speedup.patch
  igxb speedup

serialize-access-to-ide-devices.patch
  serialize access to ide devices

remove-unconditional-pci-acpi-irq-routing.patch
  remove unconditional PCI ACPI IRQ routing

propagate-pci_enable_device-errors.patch
  propagate pci_enable_device() errors

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

add-some-key-management-specific-error-codes.patch
  Add some key management specific error codes

keys-new-error-codes-for-alpha-mips-pa-risc-sparc-sparc64.patch
  keys: new error codes for Alpha, MIPS, PA-RISC, Sparc & Sparc64

implement-in-kernel-keys-keyring-management.patch
  implement in-kernel keys & keyring management
  keys build fix
  keys & keyring management update patch
  implement-in-kernel-keys-keyring-management-update-build-fix
  implement-in-kernel-keys-keyring-management-update-build-fix-2
  key management patch cleanup

make-key-management-code-use-new-the-error-codes.patch
  Make key management code use new the error codes

keys-permission-fix.patch
  keys: permission fix

keys-keyring-management-keyfs-patch.patch
  keys & keyring management: keyfs patch

keyfs-build-fix.patch
  keyfs build fix

implement-in-kernel-keys-keyring-management-afs-workaround.patch
  implement-in-kernel-keys-keyring-management afs workaround

support-supplementary-information-for-request-key.patch
  Support supplementary information for request-key

make-key-management-use-syscalls-not-prctls.patch
  Make key management use syscalls not prctls

move-syscall-declarations-from-linux-keyh-2.patch
  Move syscall declarations from linux/key.h #2

make-key-management-use-syscalls-not-prctls-build-fix.patch
  make-key-management-use-syscalls-not-prctls build fix

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

cachefs-return-the-right-error-upon-invalid-mount.patch
  CacheFS: return the right error upon invalid mount

remove-error-from-linux-cachefsh.patch
  Remove #error from linux/cachefs.h

cachefs-warning-fix-2.patch
  cachefs warning fix 2

cachefs-linkage-fix-2.patch
  cachefs linkage fix

cachefs-build-fix.patch
  cachefs build fix

cachefs-documentation.patch
  CacheFS documentation

add-page-becoming-writable-notification.patch
  Add page becoming writable notification

provide-a-filesystem-specific-syncable-page-bit.patch
  Provide a filesystem-specific sync'able page bit

provide-a-filesystem-specific-syncable-page-bit-fix.patch
  provide-a-filesystem-specific-syncable-page-bit-fix

make-afs-use-cachefs.patch
  Make AFS use CacheFS

ide-probe.patch
  ide probe

268-rc3-jffs2-unable-to-read-filesystems.patch
  jffs2 unable to read filesystems

qlogic-isp2x00-remove-needless-busyloop.patch
  QLogic ISP2x00: remove needless busyloop

jffs2-mount-options-discarded.patch
  JFFS2 mount options discarded

assign_irq_vector-section-fix.patch
  assign_irq_vector __init section fix

find_isa_irq_pin-should-not-be-__init.patch
  find_isa_irq_pin should not be __init

kexec-i8259-shutdowni386.patch
  kexec: i8259-shutdown.i386

kexec-i8259-shutdown-x86_64.patch
  kexec: x86_64 i8259 shutdown

kexec-apic-virtwire-on-shutdowni386patch.patch
  kexec: apic-virtwire-on-shutdown.i386.patch

kexec-apic-virtwire-on-shutdownx86_64.patch
  kexec: apic-virtwire-on-shutdown.x86_64

kexec-ioapic-virtwire-on-shutdowni386.patch
  kexec: ioapic-virtwire-on-shutdown.i386

kexec-ioapic-virtwire-on-shutdownx86_64.patch
  kexec: ioapic-virtwire-on-shutdown.x86_64

kexec-e820-64bit.patch
  kexec: e820-64bit

kexec-kexec-generic.patch
  kexec: kexec-generic

kexec-machine_shutdownx86_64.patch
  kexec: machine_shutdown.x86_64

kexec-kexecx86_64.patch
  kexec: kexec.x86_64

kexec-machine_shutdowni386.patch
  kexec: machine_shutdown.i386

kexec-kexeci386.patch
  kexec: kexec.i386

kexec-use_mm.patch
  kexec: use_mm

kexec-kexecppc.patch
  kexec: kexec.ppc

kexec-ppc-kexec-kconfig-misplacement.patch
  kexec ppc KEXEC Kconfig misplacement

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-dont-export-proc_cpuset_operations.patch
  Cpusets - Dont export proc_cpuset_operations

cpusets-display-allowed-masks-in-proc-status.patch
  cpusets: display allowed masks in proc status

cpusets-simplify-cpus_allowed-setting-in-attach.patch
  cpusets: simplify cpus_allowed setting in attach

cpusets-remove-useless-validation-check.patch
  cpusets: remove useless validation check

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-fix-possible-race-in-cpuset_tasks_read.patch
  cpusets: fix possible race in cpuset_tasks_read()

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

cpusets-interoperate-with-hotplug-online-maps.patch
  cpusets: interoperate with hotplug online maps

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-sb_sync_inodes-cleanup.patch
  reiser4-sb_sync_inodes-cleanup

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-allow-drop_inode-implementation-cleanup.patch
  reiser4-allow-drop_inode-implementation-cleanup

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-truncate_inode_pages_range-cleanup.patch
  reiser4-truncate_inode_pages_range-cleanup

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-rcu-barrier-fix.patch
  reiser4-rcu-barrier fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-inode_lock-cleanup.patch
  reiser4-export-inode_lock-cleanup

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-pagevec-funcs-cleanup.patch
  reiser4-export-pagevec-funcs-cleanup

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-aliased-dir.patch
  reiser4: vfs: handle aliased directories

reiser4-kobject-umount-race.patch
  reiser4: introduce filesystem kobjects

reiser4-kobject-umount-race-cleanup.patch
  reiser4-kobject-umount-race-cleanup

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-unstatic-kswapd.patch
  reiser4: make kswapd() unstatic for debug

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-4kstacks-fix.patch
  resier4-4kstacks-fix

stop-reiser4-from-turning-itself-on-by-default.patch
  Stop reiser4 from turning itself on by default

reiser4-doc.patch
  reiser4: documentation

reiser4-doc-update.patch
  Update Documentation/Changes for reiser4

reiser4-only.patch
  reiser4: main fs

reiser4-debug-build-fix.patch
  reiser4-debug-build-fix

reiser4-prefetch-warning-fix.patch
  reiser4: prefetch warning fix

reiser4-mode-fix.patch
  reiser4: mode type fix

reiser4-get_context_ok-warning-fixes.patch
  reiser4: get_context_ok() warning fixes

reiser4-remove-debug.patch
  resier4: remove debug stuff

reiser4-spinlock-debugging-build-fix-2.patch
  reiser4-spinlock-debugging-build-fix-2

reiser4-sparc64-build-fix.patch
  reiser4 sparc64 build fix

sys_reiser4-sparc64-build-fix.patch
  sys_reiser4 sparc64 build fix

reiser4-printk-warning-fixes.patch
  reiser4 printk warning fixes

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

add-acpi-based-floppy-controller-enumeration-fix.patch
  add-acpi-based-floppy-controller-enumeration fix

update-acpi-floppy-enumeration.patch
  update ACPI floppy enumeration

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

kallsyms-data-size-reduction--lookup-speedup.patch
  kallsyms data size reduction / lookup speedup

inconsistent-kallsyms-fix.patch
  Inconsistent kallsyms fix

kallsyms-correct-type-char-in-proc-kallsyms.patch
  kallsyms: correct type char in /proc/kallsyms

kallsyms-fix-sparc-gibberish.patch
  kallsyms: fix sparc gibberish

tioccons-security.patch
  TIOCCONS security

fix-process-start-times.patch
  Fix reporting of process start times

fix-comment-in-include-linux-nodemaskh.patch
  Fix comment in include/linux/nodemask.h

x86-build-issue-with-software-suspend-code.patch
  Fix x86 build issue with software suspend code

hpt366c-wrong-timings-used-since-268.patch
  hpt366.c: wrong timings

move-waitqueue-functions-to-kernel-waitc.patch
  move waitqueue functions to kernel/wait.c

standardize-bit-waiting-data-type.patch
  standardize bit waiting data type

provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
  provide-a-filesystem-specific-syncable-page-bit-fix-2

consolidate-bit-waiting-code-patterns.patch
  consolidate bit waiting code patterns
  consolidate-bit-waiting-code-patterns-cleanup
  __wait_on_bit-fix

eliminate-bh-waitqueue-hashtable.patch
  eliminate bh waitqueue hashtable

eliminate-bh-waitqueue-hashtable-fix.patch
  wait_on_bit_lock() must test_and_set_bit(), not test_bit()

eliminate-inode-waitqueue-hashtable.patch
  eliminate inode waitqueue hashtable

move-wait-ops-contention-case-completely-out-of-line.patch
  move wait ops' contention case completely out of line

reduce-number-of-parameters-to-__wait_on_bit-and-__wait_on_bit_lock.patch
  reduce number of parameters to __wait_on_bit() and __wait_on_bit_lock()

document-wake_up_bits-requirement-for-preceding-memory-barriers.patch
  document wake_up_bit()'s requirement for preceding memory barriers

3c59x-pm-fix.patch
  3c59x: enable power management unconditionally

serial-mpsc-driver.patch
  Serial MPSC driver

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

searching-for-parameters-in-make-menuconfig.patch
  searching for parameters in 'make menuconfig'

menuconfig-regex-search-dependencies.patch
  menuconfig: regex search + dependencies

add-smc91x-ethernet-for-lpd7a40x.patch
  add SMC91x ethernet for LPD7A40X

m32r-base.patch
  m32r architecture

m32r-update-for-profiling.patch
  m32r: update for profiling

m32r-update-zone_sizes_init.patch
  m32r: update zone_sizes_init()

m32r-update-to-fix-compile-errors.patch
  m32r: update to fix compile errors

m32r-update-uaccessh.patch
  m32r: update uaccess.h

m32r-update-checksum-functions.patch
  m32r: update checksum functions

m32r-update-cf-pcmcia-drivers.patch
  m32r: update CF/PCMCIA drivers

m32r-update-headers-to-remove-useless-ibcs2-support-code.patch
  m32r: update headers to remove useless  iBCS2 support code

atomic_inc_return-for-m32r-re.patch
  atomic_inc_return for m32r

m32r-change-from-export_symbol_novers-to-export_symbol.patch
  m32r: change from EXPORT_SYMBOL_NOVERS to  EXPORT_SYMBOL

m32r-modify-sys_ipc-to-remove-useless-ibcs2-support-code.patch
  m32r: modify sys_ipc() to remove useless  iBCS2 support code

m32r-add-elf-machine-code.patch
  m32r: add ELF machine code

m32r-upgrade-to-2681-kernel.patch
  m32r: upgrade to 2.6.8.1 kernel

m32r-support-a-new-bootloader-m32r-g00ff.patch
  m32r: support a new bootloader "m32r-g00ff"

m32r-modify-io-routines-for-m32700ut-cf-access.patch
  m32r: modify IO routines for m32700ut CF  access

vm-pageout-throttling.patch
  vm: pageout throttling

fix-race-in-sysfs_read_file-and-sysfs_write_file.patch
  Fix race in sysfs_read_file() and sysfs_write_file()

possible-race-in-sysfs_read_file-and-sysfs_write_file-update.patch
  Possible race in sysfs_read_file() and sysfs_write_file()

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

lazy-tsss-i-o-bitmap-copy-for-i386.patch
  lazy TSS's I/O bitmap copy for i386

pnpbios-parser-bugfix.patch
  pnpbios parser bugfix

unreachable-code-in-ext3_direct_io.patch
  unreachable code in ext3_direct_IO()

fix-for-nforce2-secondary-ide-getting-wrong-irq.patch
  Fix for NForce2 secondary IDE getting wrong IRQ

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

shmem-dont-slab_hwcache_align.patch
  shmem: don't SLAB_HWCACHE_ALIGN

shmem-inodes-and-links-need-lowmem.patch
  shmem: inodes and links need lowmem

shmem-no-sbinfo-for-shm-mount.patch
  shmem: no sbinfo for shm mount

shmem-no-sbinfo-for-tmpfs-mount.patch
  shmem: no sbinfo for tmpfs mount?

shmem-avoid-the-shmem_inodes-list.patch
  shmem: avoid the shmem_inodes list

shmem-rework-majmin-and-zero_page.patch
  shmem: rework majmin and ZERO_PAGE

shmem-copyright-file_setup-trivia.patch
  shmem: Copyright file_setup trivia

allocate-correct-amount-of-memory-for-pid-hash.patch
  Allocate correct amount of memory for pid hash

misrouted-irq-recovery-take-2.patch
  Misrouted IRQ recovery, take 2

misrouted-irq-recovery-take-2-cleanup.patch
  misrouted-irq-recovery-take-2 cleanup

misrouted-irq-recovery-take-2-fix.patch
  misrouted-irq-recovery-take-2 fix

misrouted-irq-recovery-docs.patch
  misrouted-irq-recovery documentation

explicity-align-tss-stack.patch
  explicity align tss->stack

check-checksums-for-bnep.patch
  Check checksums for BNEP

remember-to-check-return-value-from-__copy_to_user-in.patch
  __copy_to_user() check in cdrom_read_cdda_old()

cfq-iosched-v2.patch
  CFQ iosched v2

dont-export-blkdev_open-and-def_blk_ops.patch
  don't export blkdev_open and def_blk_ops

remove-dead-code-from-fs-mbcachec.patch
  remove dead code from fs/mbcache.c

remove-posix_acl_masq_nfs_mode.patch
  remove posix_acl_masq_nfs_mode

make-kmem_find_general_cachep-static-in-slabc.patch
  make kmem_find_general_cachep static in slab.c

dont-export-shmem_file_setup.patch
  don't export shmem_file_setup

remove-pm_find-unexport-pm_send.patch
  remove pm_find, unexport pm_send

remove-dead-code-and-exports-from-signalc.patch
  remove dead code and exports from signal.c

mark-md_interrupt_thread-static.patch
  mark md_interrupt_thread static

unexport-proc_sys_root.patch
  unexport proc_sys_root

mark-dq_list_lock-static.patch
  mark dq_list_lock static

unexport-is_subdir-and-shrink_dcache_anon.patch
  unexport is_subdir and shrink_dcache_anon

unexport-devfs_mk_symlink.patch
  unexport devfs_mk_symlink

unexport-do_execve-do_select.patch
  unexport do_execve/do_select

unexport-exit_mm.patch
  unexport exit_mm

unexport-files_lock-and-put_filp.patch
  unexport files_lock and put_filp

remove-exports-from-audit-code.patch
  remove exports from audit code

unexport-f_delown.patch
  unexport f_delown

unexport-lookup_create.patch
  unexport lookup_create

remove-wake_up_all_sync.patch
  remove wake_up_all_sync

remove-set_fs_root-set_fs_pwd.patch
  remove set_fs_root/set_fs_pwd

add-prctl-to-modify-current-comm.patch
  Add prctl to modify current->comm

md-remove-md_flush_all.patch
  md: remove md_flush_all

md-make-retry_list-non-global-in-raid1-and-multipath.patch
  md: make retry_list non-global in raid1 and multipath

md-rationalise-issue_flush-function-in-md-personalities.patch
  md: rationalise issue_flush function in md personalities

md-rationalise-unplug-functions-in-md.patch
  md: rationalise unplug functions in md

md-make-sure-md-always-uses-rdev_dec_pending-properly.patch
  md: make sure md always uses rdev_dec_pending properly

md-fix-two-little-bugs-in-raid10.patch
  md: fix two little bugs in raid10

md-modify-locking-when-accessing-subdevices-in-md.patch
  md: modify locking when accessing subdevices in md

blk-max_sectors-tunables.patch
  blk: max_sectors tunables

generic-acl-support-for-permission.patch
  generic acl support for ->permission

generic-acl-support-for-permission-fix.patch
  generic acl support for ->permission fix

generic-acl-support-for-permission-keyfs-fix.patch
  generic-acl-support-for-permission-keyfs-fix

device-driver-for-the-sgi-system-clock-mmtimer.patch
  device driver for the SGI system clock, mmtimer

rtl8150-fix.patch
  rtl8150 fix

close-race-with-preempt-and-modular-pm_idle-callbacks.patch
  Close race with preempt and modular pm_idle callbacks

cacheline-align-pagevec-structure.patch
  Adjust align pagevec structure

hvcs-fix-to-replace-yield-with-tty_wait_until_sent-in.patch
  HVCS fix to replace yield with tty_wait_until_sent in hvcs_close

fbdev-remove-unnecessary-banshee_wait_idle-from-tdfxfb.patch
  fbdev: remove unnecessary banshee_wait_idle from tdfxfb

fbdev-fix-logo-drawing-failure-for-vga16fb.patch
  fbdev: fix logo drawing failure for vga16fb

fbdev-initialize-i810fb-after-agpgart.patch
  fbdev: Initialize i810fb after agpgart

fbdev-fix-userland-compile-breakage.patch
  fbdev: Fix userland compile breakage

fbcon-fix-setup-boot-options-of-fbcon.patch
  fbcon: Fix setup boot options of fbcon

fbdev-pass-struct-device-to-class_simple_device_add.patch
  fbdev: Pass struct device to class_simple_device_add

fbdev-add-tile-blitting-support.patch
  fbdev: Add Tile Blitting support

fix-for-spurious-interrupts-on-e100-resume.patch
  Fix for spurious interrupts on e100 resume

r8169-miscalculation-of-available-tx-descriptors.patch
  r8169: miscalculation of available Tx descriptors

r8169-hint-for-tx-flow-control.patch
  r8169: hint for Tx flow control

r8169-tso-support.patch
  r8169: TSO support.

r8169-mac-identifier-extracted-from-realteks-driver-v22.patch
  r8169: Mac identifier extracted from Realtek's driver v2.2

uml-remove-ghash.patch
  uml: remove ghash.h

uml-eliminate-useless-thread-field.patch
  uml: eliminate useless thread field

uml-fix-scheduler-race.patch
  uml: fix scheduler race

uml-fix-binary-layout-assumption.patch
  uml: fix binary layout assumption

uml-disable-pending-signals-across-a-reboot.patch
  uml: disable pending signals across a reboot

uml-refer-to-config_usermode-not-to-config_um.patch
  uml: refer to CONFIG_USERMODE, not to CONFIG_UM

uml-remove-commented-old-code-in-kconfig.patch
  uml: remove commented old code in Kconfig

uml-smp-build-fix.patch
  uml: smp build fix

uml-remove-config_uml_smp.patch
  uml: remove CONFIG_UML_SMP

highmem-flushes.patch
  block highmem flushes

add-support-for-word-length-uart-registers.patch
  Add support for word-length UART registers

compile-fix-3c59x-for-eisa-without-pci.patch
  compile fix 3c59x for eisa without pci

atomic_inc_return-for-i386.patch
  atomic_inc_return() for i386

atomic_inc_return-for-x86_64.patch
  atomic_inc_return() for x86_64

atomic_inc_return-for-arm.patch
  atomic_inc_return() for arm

atomic_inc_return-for-arm26.patch
  atomic_inc_return() for arm26

atomic_inc_return-for-sparc64.patch
  atomic_inc_return() for sparc64

show-aggregate-per-process-counters-in-proc-pid-stat-2.patch
  show aggregate per-process counters in /proc/PID/stat 2

fix-uninitialized-warnings-in-mempolicyc.patch
  fix uninitialized warnings in mempolicy.c

online-cpu-with-maxcpus-option-panics.patch
  Online CPU with maxcpus option panics

remove-dead-exports-from-fs-fat.patch
  remove dead exports from fs/fat/

fat-use-hlist_head-for-fat_inode_hashtable-1-6.patch
  FAT: use hlist_head for fat_inode_hashtable

fat-rewrite-the-cache-for-file-allocation-table-lookup.patch
  FAT: rewrite the cache for file allocation table lookup

fat-cache-lock-from-per-sb-to-per-inode-3-6.patch
  FAT: cache lock from per sb to per inode

fat-the-inode-hash-from-per-module-to-per-sb-4-6.patch
  FAT: the inode hash from per module to per sb

fat-fix-the-race-bitween-fat_free-and-fat_get_cluster.patch
  FAT: Fix the race bitween fat_free() and fat_get_cluster()

fat-remove-debug_pr-6-6.patch
  FAT: remove debug_pr()

small-linux-hardirqh-tweaks.patch
  small <linux/hardirq.h> tweaks

bsd-disklabel-handle-more-than-8-partitions.patch
  BSD disklabel: handle more than 8 partitions

asm-softirqh-crept-back-in-h8300-and-sh64.patch
  <asm/softirq.h> crept back in h8300 and sh64

mark-amiflop-non-unloadable.patch
  mark amiflop non-unloadable

thinkpad-fnfx-key-driver.patch
  thinkpad fn+fx key driver

netpoll-endian-fixes.patch
  netpoll endian fixes

rewrite-alloc_pidmap.patch
  pidhashing: rewrite alloc_pidmap()

missing-pci_disable_device.patch
  missing pci_disable_device()

fbdev-radeonfb-remove-bogus-radeonfb_read-write.patch
  fbdev/radeonfb: Remove bogus radeonfb_read/write

add-missing-pci_disable_device-for-pci-based-usb-hcd.patch
  add missing pci_disable_device for PCI-based USB HCD

add-missing-pci_disable_device-for-e1000.patch
  add missing pci_disable_device for e1000

next_thread-bug-fixes.patch
  next_thread() BUG fixes



