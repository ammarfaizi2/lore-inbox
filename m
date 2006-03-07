Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWCGKVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWCGKVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 05:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWCGKVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 05:21:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751538AbWCGKVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 05:21:16 -0500
Date: Tue, 7 Mar 2006 02:19:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc5-mm3
Message-Id: <20060307021929.754329c9.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/

- A relatively small number of changes, although we're up to 9MB of diff
  in the various git trees.



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

Changes since 2.6.16-rc3-mm2:


 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit-master.patch
 git-blktrace.patch
 git-cfq.patch
 git-cifs.patch
 git-cifs-fixup.patch
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
 git-ocfs2.patch
 git-powerpc.patch
 git-serial.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-misc.patch
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
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees

-git-audit-master-build-fix.patch
-git-infiniband-build-fix.patch
-mmc-au1xmmc-fix-compilation-error-by-using-platform_driver.patch
-mmc-au1xmmc-fix-linking-error-because-mmc_rsp_type-doesnt-exist.patch
-mmc-au1xmmc-fix-a-compilation-warning-status-is-not-used.patch
-natsemi-napi-conversion.patch
-natsemi-rx-lockup-fix.patch
-net-convert-rtnl-to-mutex.patch
-atm-fix-section-mismatch-warnings-in-fore200ec.patch
-add-missing-ifdef-for-via-rng-code.patch
-reiserfs-fix-unaligned-bitmap-usage.patch
-fix-next_timer_interrupt-for-hrtimer.patch

 Merged

+fix-next_timer_interrupt-for-hrtimer.patch
+s390-fix-compile-with-virt_cpu_accounting=n.patch
+add-missing-pm_power_offs.patch
+memory-hotplug-compile-fix.patch
+increase-max-kmalloc-size-for-very-large-systems.patch
+time-add-barrier-after-updating-jiffies_64.patch
+alsa-fix-error-paths-in-snd_ctl_elem_add.patch
+numa_maps-update.patch
+efi-fix-gdt-load.patch
+ramfs-needs-to-update-directory-m-ctime-on-symlink.patch
+smaps-hugepages-fix.patch
+smaps-shared-fix.patch
+windfarm-license-fix.patch
+s390-fix-match-in-ccw-modalias.patch
+s390-multiple-subchannel-sets-support.patch
+udf-fix-uid-gid-options-and-add-uid-gid=ignore-and-forget-options.patch
+fix-usbmixer-double-kfree.patch
+emu10k1_synth-use-after-free.patch
+sound-isa-sb-sb_mixerc-double-kfree.patch
+ad1848-double-free.patch
+opl3_oss-use-after-free.patch
+opl3_seq-use-after-free.patch
+idle-threads-should-have-a-sane-timestamp-value.patch
+__get_unaligned-gcc4-fix.patch
+kdump-x86_64-timer-interrupt-lockup-due-to-pending-interrupt.patch
+x86-fix-i386-nmi_watchdog-that-does-not-trigger-die_nmi.patch
+percpu_counter_sum.patch
+rcu-batch-tuning.patch
+fix-file-counting.patch

 2.6.16 queue (some of these are already merged)

+acpi-signedness-fix-2.patch
+acpi-should-depend-on-not-select-pci.patch

 ACPI fixes

+vx-fix-memory-leak-on-error-path.patch

 ALSA fix

+blk_execute_rq_nowait-speedup.patch

 block performance tweak

+git-cifs-fixup.patch

 Fix reject in git-cifs.patch

+ia64-dont-report-sn2-or-summit-hardware-as-an-error.patch
+sgi-sn-drivers-dont-report-sn2-hardware-as-an-error.patch

 ia64 fixes

+ieee1394-speed-up-of-dma_region_sync_for_cpu.patch

 firewire speedup

+kill-ifdefs-in-mtdcorec.patch

 MTD cleanup

+revert-ipw2200-Fix-WPA-network-selection-problem.patch

 Revert bad patch in ipw2200.  But there's still an AP selection problem in
 there.

+git-net-build-hacks.patch
+git-net-build-hacks-fixes.patch

 Fix git-net.patch

+nfs-make-2-functions-static.patch
+fs-locksc-make-posix_locks_deadlock-static.patch

 NFS cleanups

+nfs-permit-filesystem-to-override-root-dentry-on-mount-update.patch

 Fix nfs-permit-filesystem-to-override-root-dentry-on-mount.patch

+nfs-apply-mount-root-dentry-override-to-filesystems-v9fs-fix-2.patch
+nfs-apply-mount-root-dentry-override-to-filesystems-fix-3.patch

 Fix nfs-apply-mount-root-dentry-override-to-filesystems.patch

+git-scsi-misc-sr_ioctl-missing-memset.patch
+git-scsi-misc-sr_ioctl-missing-memset-2.patch

 Fix git-scsi-misc.patch

+drivers-message-fusion-mptbasec-make-mpt_read_ioc_pg_3-static.patch
+drivers-message-fusion-mptctlc-make-struct-async_queue-static.patch

 Fusion cleanups

-gregkh-usb-usbfs2.patch
-gregkh-usb-usbfs2-vs-nfs-apply-mount-root-dentry-override-to-filesystems.patch

 usbfs2 got dropped

+revert-gregkh-usb-usb-reduce-syslog-clutter.patch

 Drop buggy patch from Greg's tree

+x86_64-mm-fix-orphaned-bits-of-timer-init-messages.patch
+x86_64-mm-cpu-limit.patch
+x86_64-mm-i386-early-alignment.patch

 x86_64 tree updates

+mm-isolate_lru_pages-scan-count-fix.patch
+mm-shrink_inactive_lis-nr_scan-accounting-fix.patch

 vmscan fixes

+enable-mprotect-on-huge-pages-fix.patch

 Fix enable-mprotect-on-huge-pages.patch

+hugepage-move-hugetlb_free_pgd_range-prototype-to-hugetlbh.patch
+hugepage-is_aligned_hugepage_range-cleanup.patch

 More hugetlbpage fixes

+slab-cache_reap-further-reduction-in-interrupt-holdoff.patch
+slab-cache_reap-further-reduction-in-interrupt-holdoff-fix.patch
+slab-make-drain_array-more-universal-by-adding-more-parameters.patch
+slab-remove-drain_array_locked.patch
+slab-fix-drain_array-so-that-it-works-correctly-with-the-shared_array.patch

 slab tweaks

+powerpc-fix-windfarm_pm112-not-starting-all-control-loops.patch
+powerpc-make-pmd_bad-and-pud_bad-checks-non-trivial.patch

 powerpc fixes

-fix-elf-entry-point-i386.patch

 Dropped, wrong.

+i386-cleanup-after-cpu_gdt_descr-conversion-to.patch
+i386-fix-dump_stack.patch
+x86-cpuid4-doesnt-need-cpu-level-5.patch
+x86-cpu-model-calculation-for-family-6-cpu.patch
+x86-deterine-xapic-using-apic-version.patch

 x86 updates

+enable-sci_emulate-to-manually-simulate-physical-hotplug-testing-fix.patch
+drivers-acpi-busc-make-struct-acpi_sci_dir-static.patch

 Fix enable-sci_emulate-to-manually-simulate-physical-hotplug-testing.patch

+s390-increase-spinlock-retry-code-performance.patch

 s390 speedup

+notifier-profileh-forward-decl.patch

 Build fix

+mmc-sdhci-build-fix.patch

 Fix mmc-secure-digital-host-controller-interface-driver.patch

+update-obsolete_oss_driver-schedule-and-dependencies-update.patch

 Fix update-obsolete_oss_driver-schedule-and-dependencies.patch

+kconfig-clarify-memory-debug-options.patch
+v9fs-consolidate-trans_sock-into-trans_fd.patch
+v9fs-rename-tids-to-tags-to-be-consistent-with-plan-9-documentation.patch
+v9fs-print-9p-messages.patch
+smbfs-fix-debug-logging-only-compilation-error.patch
+adjust-dev-kmemmemport-write-handlers.patch
+remove-maintainers-entry-for-rtlinux.patch
+fix-hardcoded-values-in-collie-frontlight.patch
+collie-fix-missing-pcmcia-bits.patch
+tpm-sparc32-build-fix.patch
+ads7846-build-fix.patch

 Misc updates and fixes

+ext3-get-blocks-maping-multiple-blocks-at-a-once-get-block-chain-confliction-fix.patch

 Fix ext3-get-blocks-maping-multiple-blocks-at-a-once.patch

+ext3-cleanups-and-warn_on.patch
+ext3-multi-block-get_block.patch

 Update ext3 patches in -mm.

+time-reduced-ntp-rework-part-2-remove-duplicate.patch

 Fix time-reduced-ntp-rework-part-2-fix-adjtimeadj.patch

+time-i386-conversion-part-3-lock-jiffies_64.patch

 Locking fix

+time-i386-clocksource-drivers-drop-acpi_pm_buggy.patch

 Fix time-i386-clocksource-drivers.patch

+kernel-timec-remove-unused-pps_-variables.patch

 Cleanup

+kprobe-handler-discard-user-space-trap-fix-2.patch

 Fix kprobe-handler-discard-user-space-trap.patch some more

+uevent-redzoning.patch
+early-boot-safety-in-cond_resched.patch
+pipe-refcounting-cleanup.patch

 Various things which might fix or detect a rare memory corruption bug.

-export-file_ra_state_init-again.patch

 Dropped, unneeded.

+for_each_online_pgdat-take2-for_each_bootmem-fix.patch

 Fix for_each_online_pgdat-take2-for_each_bootmem.patch

-rtc-subsystem-library-functions.patch
-rtc-subsystem-arm-cleanup.patch
-rtc-subsystem-class.patch
-rtc-subsystem-class-fix.patch
-rtc-subsystem-class-fix-2.patch
-rtc-subsystem-i2c-cleanup.patch
-rtc-subsystem-sysfs-interface.patch
-rtc-subsystem-proc-interface.patch
-rtc-subsystem-dev-interface.patch
-rtc-subsystem-x1205-driver.patch
-rtc-subsystem-test-device-driver.patch
-rtc-subsystem-ds1672-driver.patch
-rtc-subsystem-pcf8563-driver.patch
-rtc-subsystem-rs5c372-driver.patch
+rtc-subsystem-library-functions-2.patch
+rtc-subsystem-arm-cleanup-2.patch
+rtc-subsystem-arm-integrator-cleanup-2.patch
+rtc-subsystem-class-2.patch
+rtc-subsystem-i2c-cleanup-2.patch
+rtc-subsystem-sysfs-interface-2.patch
+rtc-subsystem-proc-interface-2.patch
+rtc-subsystem-dev-interface-2.patch
+rtc-subsystem-x1205-driver-2.patch
+rtc-subsystem-test-device-driver-2.patch
+rtc-subsystem-ds1672-driver-2.patch
+rtc-subsystem-pcf8563-driver-2.patch
+rtc-subsystem-rs5c372-driver-2.patch
+rtc-subsystem-ep93xx-driver-2.patch
+rtc-subsystem-sa1100-pxa2xx-driver-2.patch

 Updated rtc patch series

+tref-implement-task-references-kill-init_tref.patch
+tref-fix-task_ref-reference-counting.patch
+tref-fix-task_ref-reference-counting-fix.patch
+tref-fix-task_ref-reference-counting-ensure-the-references-is-always-on-the-first-task.patch
+proc-dont-lock-task_structs-indefinitely-kill-init_tref.patch
+proc-dont-lock-task_structs-indefinitely-kill-init_tref-inode.patch
+proc-dont-lock-task_structs-indefinitely-tref-ensure-the-references-is-always-on-the-first-task.patch
+proc-cleanup-proc_fd_access_allowed.patch

 Various updates to the procfs patches in -mm.

+framebuffer-cmap-setting-return-values.patch

 framebuffer fixlet.

+kobject_add_dir.patch
+add-holders-slaves-subdirectory-to-sys-block.patch
+bd_claim_by_kobject.patch
+bd_claim_by_disk.patch
+md-to-use-bd_claim_by_disk.patch
+dm-table-store-md.patch
+dm-table-store-md-fix.patch
+dm-to-use-bd_claim_by_disk.patch
+dm-linear-debug.patch

 devicemapper feature work.

+fold-select_bits_alloc-free-into-caller-code.patch

 select() cleanup.

+typos-grab-bag-of-the-month.patch

 Fix lots of tpyos.



All 1448 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/patch-list


