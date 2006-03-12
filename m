Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWCLLM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWCLLM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 06:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWCLLMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 06:12:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30413 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932150AbWCLLMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 06:12:54 -0500
Date: Sun, 12 Mar 2006 03:10:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc6-mm1
Message-Id: <20060312031036.3a382581.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/


- Added git-wireless.patch to the -mm lineup.  John Linville it looking
  after this tree.  It's presently empty - I guess he recently merged into
  git-netdev-all.

- I renamed `linus.patch' to `origin.patch'.  It's derived from the git
  branch name.  (origin.patch is Linus's current diff relative to the
  most-recently-released kernel).  origin.patch is empty too.

- Added git-scsi-target.patch to the -mm lineup (James Bottomley).  Turn
  your Linux box into scsi peripheral!

- New slab debugging infrastructure - define CONFIG_DEBUG_SLAB_LEAK and
  /proc/slab_allocators appears (Al Viro).

- The NFS tree is a bit sick - you may see the `busy inodes - self destruct
  in five seconds" message when performing NFS unmounts.  It seems relatively
  harmless.

- Big updates in the networking development tree (git-net.patch).  They seem
  to be due to:

  Author: Catherine Zhang <cxzhang@watson.ibm.com>
  Date:   Fri Mar 10 00:34:15 2006 -0800

    [SECURITY]: TCP/UDP getpeersec
    
    This patch implements an application of the LSM-IPSec networking
    controls whereby an application can determine the label of the
    security association its TCP or UDP sockets are currently connected to
    via getsockopt and the auxiliary data mechanism of recvmsg.

  Which I am sure is very good.




Changes since 2.6.16-rc5-mm3:


 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-arm.patch
 git-audit-master.patch
 git-blktrace.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
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
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
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
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch 

 git trees

-powerpc-restore-eeh_add_device_late-prototype.patch
-serial-core-work-around-sub-driver-bugs.patch
-i386-port-ati-timer-fix-from-x86_64-to-i386-ii.patch
-i386-port-ati-timer-fix-from-x86_64-to-i386-ii-fixes.patch
-cramfs-mounts-provide-corrupted-content-since-2615.patch
-i4l-add-new-pci-ids-for-hfc-s-pci.patch
-i4l-fix-refcounting-problem-with-ttyix-devices.patch
-i4l-fix-compatiblity-issue-with-big-endian-systems.patch
-x86-fix-potential-jiffies-overflow-in-timer_resume.patch
-fix-next_timer_interrupt-for-hrtimer.patch
-s390-fix-compile-with-virt_cpu_accounting=n.patch
-add-missing-pm_power_offs.patch
-memory-hotplug-compile-fix.patch
-increase-max-kmalloc-size-for-very-large-systems.patch
-time-add-barrier-after-updating-jiffies_64.patch
-alsa-fix-error-paths-in-snd_ctl_elem_add.patch
-numa_maps-update.patch
-efi-fix-gdt-load.patch
-ramfs-needs-to-update-directory-m-ctime-on-symlink.patch
-smaps-hugepages-fix.patch
-smaps-shared-fix.patch
-windfarm-license-fix.patch
-s390-fix-match-in-ccw-modalias.patch
-s390-multiple-subchannel-sets-support.patch
-udf-fix-uid-gid-options-and-add-uid-gid=ignore-and-forget-options.patch
-fix-usbmixer-double-kfree.patch
-emu10k1_synth-use-after-free.patch
-sound-isa-sb-sb_mixerc-double-kfree.patch
-ad1848-double-free.patch
-opl3_oss-use-after-free.patch
-opl3_seq-use-after-free.patch
-idle-threads-should-have-a-sane-timestamp-value.patch
-__get_unaligned-gcc4-fix.patch
-kdump-x86_64-timer-interrupt-lockup-due-to-pending-interrupt.patch
-x86-fix-i386-nmi_watchdog-that-does-not-trigger-die_nmi.patch
-percpu_counter_sum.patch
-rcu-batch-tuning.patch
-fix-file-counting.patch
-vx-fix-memory-leak-on-error-path.patch
-dont-check-vfree-argument-for-null-in-vx_pcm.patch
-dont-check-vfree-arg-for-null-in-usbaudio.patch
-dont-null-check-vfree-argument-in-pdaudiocf_pcm.patch
-git-audit-fixes.patch
-sem2mutex-audit_netlink_sem.patch
-simplify-audit_free-locking.patch
-git-cifs-fixup.patch
-ia64-dont-report-sn2-or-summit-hardware-as-an-error.patch
-sgi-sn-drivers-dont-report-sn2-hardware-as-an-error.patch
-drivers-scsi-libata-scsic-make-some-functions-static.patch
-tulip-natsemi-dp83840a-phy-fix.patch
-8139cp-register-interrupt-handler-when-net-device-is-registered.patch
-3c509-bus-registration-fix.patch
-ne2000-kconfig-help-entry-improvement.patch
-de620-fix-section-mismatch-warning.patch
-git-net-build-hacks.patch
-git-net-build-hacks-fixes.patch
-git-net-vs-remove-module_parm.patch
-sem2mutex-drivers-net-irda.patch
-sem2mutex-net.patch
-sem2mutex-sungem.patch
-sem2mutex-cassini.patch
-sem2mutex-net-2.patch
-happtmeal-add-pci-probing.patch
-suni-cast-arg-properly-in-sonet_setframing.patch
-net-tipc-possible-cleanups.patch
-dev_put-dev_hold-cleanup.patch
-wan-fix-section-mismatch-warning-in-sbni.patch
-powerpc-fix-pud_error-message.patch
-git-scsi-misc-sr_ioctl-missing-memset.patch
-git-scsi-misc-sr_ioctl-missing-memset-2.patch
-scsi-cd-varirec-gigarec-and-powerrec-as-user.patch
-gregkh-usb-usb-initdata-fixes.patch
-x86_64-mm-c3-timer-check-amd.patch
-x86_64-mm-blk-bounce.patch
-x86_64-mm-i386-early-alignment.patch
-x86_64-mm-blk-bounce-ia64-fix.patch
-x86_64-mm-dmi-year-fix.patch
-x86_64-mm-c3-timer-check-amd-fix.patch
-slab-node-rotor-for-freeing-alien-caches-and-remote-per-cpu-pages.patch
-slab-node-rotor-for-freeing-alien-caches-and-remote-per-cpu-pages-fix.patch
-powerpc-fix-windfarm_pm112-not-starting-all-control-loops.patch
-x86-cpu-model-calculation-for-family-6-cpu.patch
-s390-increase-spinlock-retry-code-performance.patch
-jffs2-fix-size_t-on-64bit-architectures.patch

 Merged.

+mtd_dataflash-fix-block-vs-page-erase.patch

 Current 2.6.16 queue

-git-acpi-up-fix-2.patch

 Folded into git-acpi-up-fix.patch

+acpi-ec-acpi-ecdt-uid-hack.patch
+acpi-thermal-driver-leaks-in-failure-path.patch
+acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces.patch
+drivers-acpi-videoc-fix-a-null-pointer-dereference.patch

 ACPI fixes.

+sony_apci-resume.patch

 Add simple resume support to 2.6-sony_acpi4.patch.  Doesn't work because
 ACPI doesn't call the resume handlers.

+sound-core-fix-3-off-by-one-errors.patch
+sound-pci-rme9652-hdspmc-fix-off-by-one-errors.patch
+msi-k8t-neo2-fir-onboardsound-and-additional-soundcard.patch

 ALSA fixes

+block-layer-increase-size-of-disk-stat.patch

 Avoid disk-stat overflows.

+gregkh-driver-kobject-add-error-notify.patch
+gregkh-driver-kobject-kobject.h-fix-a-typo.patch
+gregkh-driver-sysfs-fix-problem-with-duplicate-sysfs-directories-and-files.patch

 Driver tree updates

-topologyc-tweaks.patch
-cpuc-section-fixes.patch

 Dropped - this was hard.

+spi-update-to-pxa2xx-spi-driver.patch

 SPI driver update.

+drivers-ieee1394-ohci1394c-function-calls-without-effect.patch

 Firewire fixlet

-input-pcspkr-device-and-driver-separation-fix.patch
-input-pcspkr-device-and-driver-separation-fix-2.patch
-input-pcspkr-device-and-driver-separation-fix-3.patch

 Folded into input-pcspkr-device-and-driver-separation.patch

+drivers-input-serio-serioc-fix-a-memory-leak.patch
+drivers-input-gameport-gameportc-fix-a-memory-leak.patch

 Input layer fixes.

+ahci-fix-null-pointer-dereference-detected-by-coverity.patch

 libata fix

+dead-code-in-mtd-maps-pcic.patch
+add-chip-used-in-collie-to-jedec_probe.patch

 MTD fixes

+git-netdev-all-ipw2200-warning-fix.patch

 Fix warning in git-netdev-all.patch

+drivers-net-ns83820c-add-paramter-to-disable-auto-tidy-2.patch
+drivers-net-ns83820c-add-paramter-to-disable-auto-tidy-fix.patch

 Update drivers-net-ns83820c-add-paramter-to-disable-auto.patch

+tulip-natsemi-dp83840a-phy-fix.patch

 Tulip fix

-3c509-use-proper-suspend-resume-api-fix.patch

 Folded into 3c509-use-proper-suspend-resume-api.patch

-pm-suspend-eisa-and-mca-devices.patch
-pm-suspend-eisa-and-mca-devices-fix.patch

 Dropped - didn't work.

+drivers-net-wireless-ipw2200c-make-ipw_qos_current_mode-static.patch
+fix-spidernet-build-issue.patch
+drivers-net-wireless-ipw2200c-fix-an-array-overun.patch

 netdev fixes

+git-net-arm-build-fix.patch
+git-net-export-security_sid_to_context.patch
+git-net-ebtables-fix.patch
+git-net-br_netfilter-warning-fixes.patch

 git-net fixes

-net-allow-32-bit-socket-ioctl-in-64-bit-kernel-tidy.patch
-net-socket-timestamp-32-bit-handler-for-64-bit-kernel-tidy.patch
-net-socket-timestamp-32-bit-handler-for-64-bit-kernel-fix.patch
-x25-ioctl-conversion-32-bit-user-to-64-bit-kernel-tidy.patch
-x25-ioctl-conversion-32-bit-user-to-64-bit-kernel-tidy-fix.patch
-x25-allow-itu-t-dte-facilities-for-x25-tidy.patch

 Folded into other patches

+net-decnet-dn_routec-fix-inconsequent-null-checking.patch

 decnet fixlet.

+nfs-fix-a-busy-inodes-issue.patch

 Try to avoid use-after-free in git-nfs.patch

+git-nfs-oops-workaround.patch

 That didn't work.  Leak it instead.

-nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
-nfs-permit-filesystem-to-override-root-dentry-on-mount-update.patch
-nfs-apply-mount-root-dentry-override-to-filesystems.patch
-nfs-apply-mount-root-dentry-override-to-filesystems-v9fs-fix.patch
-nfs-abstract-out-namespace-initialisation.patch
-nfs-add-dentry-materialisation-op.patch
-nfs-unify-nfs-superblocks-per-protocol-per-server.patch
-nfs-unify-nfs-superblocks-per-protocol-per-server-fix.patch
-nfs-apply-mount-root-dentry-override-to-filesystems-v9fs-fix-2.patch
-nfs-apply-mount-root-dentry-override-to-filesystems-fix-3.patch
+nfs-permit-filesystem-to-override-root-dentry-on-mount-6.patch
+9p-fix-error-handling-on-superblock-alloc-failure.patch
+nfs-abstract-out-namespace-initialisation-6.patch
+nfs-add-dentry-materialisation-op-6.patch
+nfs-unify-nfs-superblocks-per-protocol-per-server-6.patch

 Updated NFS superblock sharing patches

+optimise-d_find_alias.patch
+optimise-d_find_alias-fix.patch

 VFS speedup.

+gregkh-pci-pci-cpqphp_ctrl.c-board_replaced-remove-dead-code.patch
+gregkh-pci-pci-the-scheduled-removal-of-pci_legacy_proc.patch
+gregkh-pci-pci-provide-a-boot-parameter-to-disable-msi.patch
+gregkh-pci-pci-fix-pci_request_region-arg.patch

 PCI tree updates

+fix-pcmcia_device_remove-oops.patch

 Fix git-pcmcia.patch

+drivers-scsi-ncr_d700c-fix-a-null-dereference.patch
+scsi-dmx3191dc-fix-a-null-pointer-dereference.patch
+drivers-scsi-ibmmcac-fix-a-null-pointer-dereference.patch
+scsi-megaraid-megaraid_mmc-fix-a-null-pointer-dereference.patch
+drivers-scsi-sim710c-fix-a-null-pointer-dereference.patch

 scsi fixes

-gregkh-usb-usb-reduce-syslog-clutter.patch
-revert-gregkh-usb-usb-reduce-syslog-clutter.patch
+gregkh-usb-usb-ub-01-remove-first_open.patch
+gregkh-usb-usb-ub-02-remove-diag.patch
+gregkh-usb-usb-ub-03-drop-stall-clearing.patch
+gregkh-usb-usb-usbcore-don-t-assume-a-usb-configuration-includes-any-interfaces.patch
+gregkh-usb-usb-usbcore-usb_set_configuration-oops.patch
+gregkh-usb-usb-initdata-fixes.patch

 USB tree updates

+drivers-usb-media-vicamc-fix-a-null-pointer-dereference.patch
+usbcore-fix-check_ctrlrecip-to-allow-control-transfers-in-state-address.patch

 USB fixes

+hostap_apchostap_add_sta-inconsequent-null-checking.patch

 Wireless fix

+x86_64-mm-reorder-one-field-of-the-pda-to-reduce-padding.patch
+x86_64-mm-noexec32-default.patch
+x86_64-mm-timer-broadcast-amd.patch
+x86_64-mm-memmap-alloc.patch
+x86_64-mm-lost-ticks-dump-rip.patch
+x86_64-mm-use-cpumask-bitops-for-cpu_vm_mask.patch
+x86_64-mm-kexec-interrupt-ack.patch
+x86_64-mm-free_bootmem_node-needs-__pa-in-allocate_aperture.patch
+x86_64-mm-lagrange-feature.patch

 x86_64 updates

+x86_64-mm-timer-broadcast-amd-fix.patch
+x86_64-mm-timer-broadcast-amd-fix-2.patch

 Fix it.

+vmscan-scan_control-cleanup-speedup.patch

 Speed up vmscan-scan_control-cleanup.patch

+convert-hugetlbfs_counter-to-atomic.patch
+optimize-follow_hugetlb_page.patch
+page-migration-documentation-update.patch
+drain_node_pages-interrupt-latency-reduction--optimization.patch
+drain_node_pages-interrupt-latency-reduction-optimization-update.patch
+slab-leaks.patch
+slab-leaks3-locking-fix.patch
+slab-leaks3-default-y.patch

 mm updates

+i386-spinlocks-disable-interrupts-only-if-we-enabled.patch
+x86-some-fixups-for-the-x86_numaq-dependencies.patch
+x86-make-_syscallx-macros-compile-in-pic-mode.patch

 x86 updates

+efi-fixes.patch

 Fix the EFI/DMI patches in -mm.

+make-the-oss-sound_via82cxxx-option-available-again.patch

 Update update-obsolete_oss_driver-schedule-and-dependencies.patch

-let-dac960-supply-entropy-to-random-pool.patch

 Was fixed differently.

+v9fs-print-9p-messages-fix.patch
+v9fs-print-9p-messages-fix-2.patch
+fs-9p-make-2-functions-static.patch
+v9fs-print-9p-messages-fix-3.patch

 Fix v9fs-print-9p-messages.patch

+irq-uninline-migration-functions.patch
+irq-prevent-enabling-of-previously-disabled-interrupt.patch
+pollrdhup-epollrdhup-handling-for-half-closed-devices.patch
+add-a-proper-prototype-for-setup_arch.patch
+refactor-capable-to-one-implementation-add-__capable-helper.patch
+make-cap_ptrace-enforce-ptrace_tracme-checks.patch
+fix-messages-in-fs-minix.patch
+freeze_bdev-cleanup.patch
+move-cond_resched-after-iput-in-sync_sb_inodes.patch
+reduce-sched-latency-in-shrink_dcache_sb.patch
+kallsyms-handle-malloc-failure.patch
+per-cpufy-net-proto-structures-add-percpu_counter_modbh.patch
+per-cpufy-net-proto-structures-add-percpu_counter_modbh-tidy.patch
+percpu-counters-add-percpu_counter_exceeds.patch
+percpu-counters-add-percpu_counter_exceeds-tidy.patch
+per-cpufy-net-proto-structures-protomemory_allocated.patch
+per-cpufy-net-proto-structures-protomemory_allocated-use-percpu_counter_exceeds.patch
+per-cpufy-net-proto-structures-sockets_allocated.patch
+per-cpufy-net-proto-structures-protoinuse.patch
+per-cpufy-net-proto-structures-protoinuse-fix.patch
+ext3-fix-debug-logging-only-compilation-error.patch
+find_task_by_pid-needs-tasklist_lock.patch
+i2o-memory-leak-in-i2o_exec_lct_modified.patch
+blk_dev_initrd-do-not-require-blk_dev_ram=y.patch
+reiserfs-xattr_aclcreiserfs_get_acl-make-size-an-int.patch
+drivers-char-watchdog-pcwd_usbc-fix-a-null-pointer-dereference.patch
+md-bitmapcbitmap_mask_state-fix-inconsequent-null-checking.patch
+net-sunrpc-clntc-fix-a-null-pointer-dereference.patch
+rename-setuid-dumpable-sysctl.patch
+drivers-char-ipmi-ipmi_msghandlerc-fix-a-memory-leak.patch
+removal-of-long-incorrect-address-for-jamie-lokier.patch
+remove-dead-address-from-maintainers-list.patch

 Misc random general patches.

+remove-redundant-check-from-autofs4_put_super.patch
+autofs4-follow_link-missing-funtionality.patch

 Update autofs4 patches in -mm.

+map-multiple-blocks-for-mpage_readpages-use-buffer_mapped.patch

 Simplify map-multiple-blocks-for-mpage_readpages.patch

+ext3-add-o-bh-option.patch
+ext3-nobh-writeback-support-for-filesystems-blocksize.patch

 Updates to the ext3 no-buffer-head option.

+kprobe-handler-discard-user-space-trap-fix-3.patch

 Fix kprobe-handler-discard-user-space-trap.patch some more.

+dead-code-in-drivers-isdn-avm-avmcardh.patch

 Cleanup

-edac-kconfig-dependency-changes-fix.patch

 Dropped (I think)

+knfsd-change-the-store-of-auth_domains-to-not-be-a-cache.patch
+knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix.patch
+knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-2.patch
+knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-3.patch
+knfsd-change-the-store-of-auth_domains-to-not-be-a-cache-fix-3-fix.patch
+knfsd-break-the-hard-linkage-from-svc_expkey-to-svc_export.patch
+knfsd-get-rid-of-inplace-sunrpc-caches.patch
+knfsd-create-cache_lookup-function-instead-of-using-a-macro-to-declare-one.patch
+knfsd-convert-ip_map-cache-to-use-the-new-lookup-routine.patch
+knfsd-use-new-cache_lookup-for-svc_export.patch
+knfsd-use-new-cache_lookup-for-svc_expkey-cache.patch
+knfsd-use-new-sunrpc-cache-for-rsi-cache.patch
+knfsd-use-new-cache-code-for-rsc-cache.patch
+knfsd-use-new-cache-code-for-name-id-lookup-caches.patch
+knfsd-an-assortment-of-little-fixes-to-the-sunrpc-cache-code.patch
+knfsd-remove-definecachelookup.patch
+knfsd-unexport-cache_fresh-and-fix-a-small-race.patch
+knfsd-convert-sunrpc_cache-to-use-krefs.patch
+knfsd-convert-sunrpc_cache-to-use-krefs-fix.patch

 knfsd update

+small-schedule-optimization.patch

 schedule() tweak.

-uevent-redzoning.patch
-early-boot-safety-in-cond_resched.patch
-pipe-refcounting-cleanup.patch

 This was pretty specific debug stuff.

+sched2-sched-domain-sysctl-tidy.patch

 Clean up sched2-sched-domain-sysctl.patch

-unify-pfn_to_page-sparc64-pfn_to_page.patch
-unify-pfn_to_page-sparc64-pfn_to_page-fix.patch

 No longer needed

+notifier-chain-update-die_chain-changes-fix.patch

 Fix notifier-chain-update-die_chain-changes.patch

-fork-allow-init-to-become-a-session-leader.patch
+pids-kill-pidtype_tgid.patch
+resurrect-__put_task_struct.patch
+task-rcu-protect-task-usage.patch
+task-make-task-list-manipulations-rcu-safe.patch
+make-setsid-more-robust.patch
+proc-refactor-reading-directories-of-tasks-dont-assume-pid_aliveinit_task-==-false.patch
+proc-remove-tasklist_lock-from-proc_pid_readdir.patch
+proc-remove-tasklist_lock-from-proc_pid_lookup-and.patch
+#
+pidhash-refactor-the-pid-hash-table.patch
+pidhash-refactor-the-pid-hash-table-fixes.patch
-tref-implement-task-references.patch
-tref-implement-task-references-kill-init_tref.patch
-tref-fix-task_ref-reference-counting.patch
-tref-fix-task_ref-reference-counting-fix.patch
-tref-fix-task_ref-reference-counting-ensure-the-references-is-always-on-the-first-task.patch
+proc-dont-lock-task_structs-indefinitely-always-drop-the-reference-count-in-tid_fd_revalidate.patch
+proc-use-struct-pid-not-struct-task_ref.patch
+proc-remove-tasklist_lock-from-proc_task_readdir.patch

 Many updates to the proc/pid/task changes in -mm.

+rivafb-remove-null-check.patch
+nvidiafb-remove-null-check.patch
+nvidiafb-remove-null-check-2.patch
+i810fb-remove-null-check.patch
+savagefb-remove-null-check.patch
+atyfb-remove-dead-code.patch
+imsttfb-remove-dead-code.patch
+nvidiafb-add-id-for-quadro-nvs280.patch
+newportcon-sparse-fix-warnings-in-newport-driver-about.patch

 fbdev updates

-kobject_add_dir.patch
-add-holders-slaves-subdirectory-to-sys-block.patch
-bd_claim_by_kobject.patch
-bd_claim_by_disk.patch
-md-to-use-bd_claim_by_disk.patch
-dm-table-store-md.patch
-dm-table-store-md-fix.patch
-dm-to-use-bd_claim_by_disk.patch
-dm-linear-debug.patch

 Dropped.

+x86-e820-debugging.patch

 Debug the e820 code.



All 1487 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/patch-list


