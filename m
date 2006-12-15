Return-Path: <linux-kernel-owner+w=401wt.eu-S1750949AbWLOG7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWLOG7T (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 01:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWLOG7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 01:59:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38451 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbWLOG7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 01:59:17 -0500
Date: Thu, 14 Dec 2006 22:59:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc1-mm1
Message-Id: <20061214225913.3338f677.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Temporarily at

	http://userweb.kernel.org/~akpm/2.6.20-rc1-mm1/

Will appear later at

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/



- Added the avr32 devel tree as git-avr32.patch (Haavard Skinnemoen)

- Don't enable locking API self-tests on powerpc - it explodes in a
  spectacular fashion.




Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git-fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git tag v2.6.16-rc2-mm1
  git-checkout -b local-v2.6.16-rc2-mm1 v2.6.16-rc2-mm1

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it is not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.

- When reporting bugs in this kernel via email, please also rewrite the
  email Subject: in some manner to reflect the nature of the bug.  Some
  developers filter by Subject: when looking for messages to read.

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.



Changes since 2.6.19-mm1:

 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-avr32.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-gfs2-nmw.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mmc.patch
 git-mmc-fixup.patch
 git-mtd.patch
 git-ubi.patch
 git-netdev-all.patch
 git-ioat.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-chelsio.patch
 git-selinux.patch
 git-pciseg.patch
 git-s390.patch
 git-sh.patch
 git-sas.patch
 git-sparc64.patch
 git-qla3xxx.patch
 git-wireless.patch
 git-gccbug.patch

 git trees.

-x86-smp-export-smp_num_siblings-for-oprofile.patch
-tty-export-get_current_tty.patch
-ieee80211softmac-fix-errors-related-to-the-work_struct-changes.patch
-kvm-add-missing-include.patch
-kvm-put-kvm-in-a-new-virtualization-menu.patch
-kvm-clean-up-amd-svm-debug-registers-load-and-unload.patch
-kvm-replace-__x86_64__-with-config_x86_64.patch
-fix-more-workqueue-build-breakage-tps65010.patch
-another-build-fix-header-rearrangements-osk.patch
-uml-fix-net_kern-workqueue-abuse.patch
-isdn-gigaset-fix-possible-missing-wakeup.patch
-i2o_exec_exit-and-i2o_driver_exit-should-not-be-__exit.patch
-cpufreq-fix-bug-in-duplicate-freq-elimination-code-in-acpi-cpufreq.patch
-gregkh-driver-modules-state.patch
-gregkh-driver-driver-core-delete-virtual-directory-on-class_unregister.patch
-gregkh-driver-debugfs-inotify-create-mkdir-support.patch
-gregkh-driver-debugfs-coding-style-fixes.patch
-gregkh-driver-debugfs-file-directory-creation-error-handling.patch
-gregkh-driver-debugfs-more-file-directory-creation-error-handling.patch
-gregkh-driver-debugfs-file-directory-removal-fix.patch
-gregkh-driver-driver-core-platform_driver_probe-can-save-codespace-save-codespace.patch
-gregkh-driver-driver-core-make-platform_device_add_data-accept-a-const-pointer.patch
-gregkh-driver-driver-core-deprecate-pm_legacy-default-it-to-n.patch
-drm-fix-return-value-check.patch
-drm-handle-pci_enable_device-failure.patch
-jdelvare-i2c-i2c-documentation-typos.patch
-jdelvare-i2c-i2c-update-i2c-id-list.patch
-jdelvare-i2c-i2c-delete-ite-bus-driver.patch
-jdelvare-i2c-i2c-pnx-new-driver.patch
-jdelvare-i2c-i2c-ibm_iic-add_request_release_mem_region.patch
-jdelvare-i2c-i2c-nforce2-cleanup.patch
-jdelvare-i2c-i2c-lockdep-handle-recursive-locking.patch
-jdelvare-i2c-i2c-at91-new-bus-driver.patch
-jdelvare-i2c-i2c-dev-make-I2C_FUNCS-ioctl-faster.patch
-jdelvare-i2c-i2c-remove-extraneous-whitespace.patch
-jdelvare-i2c-i2c-core-use-__ATTR.patch
-jdelvare-i2c-i2c-i801-documentation-update.patch
-jdelvare-i2c-i2c-fix-broken-ds1337-initialization.patch
-jdelvare-i2c-i2c-versatile-new-arm-bus-driver.patch
-jdelvare-i2c-i2c-discard-del-bus-wrappers.patch
-jdelvare-i2c-i2c-i801-enable-PEC-on-ICH6.patch
-jdelvare-i2c-i2c-dev-fix-return-value-check.patch
-jdelvare-i2c-i2c-dev-merge-kfree.patch
-jdelvare-i2c-i2c-omap-prescaler-formula.patch
-jdelvare-hwmon-hwmon-f71805f-add-fanctl-1-prepare.patch
-jdelvare-hwmon-hwmon-f71805f-add-fanctl-2-manual-mode.patch
-jdelvare-hwmon-hwmon-f71805f-add-fanctl-3-pwm-freq.patch
-jdelvare-hwmon-hwmon-f71805f-add-fanctl-4-pwm-mode.patch
-jdelvare-hwmon-hwmon-f71805f-add-fanctl-5-speed-mode.patch
-jdelvare-hwmon-hwmon-f71805f-add-fanctl-6-documentation.patch
-jdelvare-hwmon-hwmon-pc87360-set-vrm-using-hwmon-vid-routine.patch
-jdelvare-hwmon-hwmon-hdaps-dmi-detection-data-to-data-section.patch
-jdelvare-hwmon-hwmon-hdaps-BIOS-note.patch
-jdelvare-hwmon-hwmon-it87-drop-smbus-interface-support.patch
-jdelvare-hwmon-hwmon-pc87427-new-driver.patch
-jdelvare-hwmon-hwmon-f71805f-add-f71872f-support.patch
-jdelvare-hwmon-hwmon-f71805f-always-create-all-fans.patch
-jdelvare-hwmon-hwmon-f71805f-fix-address-decoding.patch
-jdelvare-hwmon-hwmon-rudolf-marek-changed-email-address.patch
-jdelvare-hwmon-hwmon-w83793-new-driver.patch
-jdelvare-hwmon-hwmon-w83793-documentation.patch
-jdelvare-hwmon-hwmon-ams-new-driver.patch
-jdelvare-hwmon-hwmon-ams-maintainers.patch
-kconfig-new-function-bool-conf_get_changedvoid.patch
-kconfig-make-sym_change_count-static-let-it-be-altered-by-2-functions-only.patch
-kconfig-add-void-conf_set_changed_callbackvoid-fnvoid-use-it-in-qconfcc.patch
-kconfig-set-gconfs-save-widgets-sensitivity-according-to-configs-changed-state.patch
-ata_piix-ide-mode-sata-patch-for-intel-ich9.patch
-pata_it8213-add-new-driver-for-the-it8213-card.patch
-mmc-fix-prev-state-2-=-task_running-problem-on-sd-mmc-card-removal.patch
-git-mtd-build-fix.patch
-zd1211rw-call-ieee80211_rx-in-tasklet.patch
-ieee80211softmac-fix-mutex_lock-at-exit-of-ieee80211_softmac_get_genie.patch
-x86_64-make-the-numa-hash-function-nodemap-allocation.patch
-x86_64-make-the-numa-hash-function-nodemap-allocation-fix.patch
-cleanup-slab-headers--api-to-allow-easy-addition-of-new-slab.patch
-more-slabh-cleanups.patch
-cpuset-rework-cpuset_zone_allowed-api.patch
-slab-use-a-multiply-instead-of-a-divide-in-obj_to_index.patch
-slab-use-a-multiply-instead-of-a-divide-in-obj_to_index-tweaks.patch
-pm-fix-freezing-of-stopped-tasks.patch
-pm-fix-smp-races-in-the-freezer.patch
-touch_atime-cleanup.patch
-relative-atime.patch
-ocfs2-relative-atime-support.patch
-ocfs2-relative-atime-support-tweaks.patch
-optimize-o_direct-on-block-device-v3.patch
-optimize-o_direct-on-block-device-v3-tweak.patch
-debug-add-sysrq_always_enabled-boot-option.patch
-lockdep-filter-off-by-default.patch
-lockdep-improve-verbose-messages.patch
-lockdep-improve-lockdep_reset.patch
-lockdep-clean-up-very_verbose-define.patch
-lockdep-use-chain-hash-on-config_debug_lockdep-too.patch
-lockdep-print-irq-trace-info-on-asserts.patch
-lockdep-fix-possible-races-while-disabling-lock-debugging.patch
-lockdep-fix-possible-races-while-disabling-lock-debugging-fix.patch
-use-activate_mm-in-fs-aiocuse_mm.patch
-fix-numerous-kcalloc-calls-convert-to-kzalloc.patch
-tty-remove-useless-memory-barrier.patch
-config_computone-should-depend-on-isaeisapci.patch
-appldata_mem-dependes-on-vm-counters.patch
-uml-problems-with-linux-ioh.patch
-missing-includes-in-hilkbd.patch
-hci-endianness-annotations.patch
-lockd-endianness-annotations-rebased.patch
-rtc-fix-error-case.patch
-rtc-driver-init-adjustment.patch
-tty_ioc-balance-tty_ldisc_ref.patch
-knfsd-nfsd4-remove-a-dprink-from-nfsd4_lock.patch
-knfsd-svcrpc-fix-gss-krb5i-memory-leak.patch
-knfsd-nfsd4-clarify-units-of-compound_slack_space.patch
-knfsd-nfsd-make-exp_rootfh-handle-exp_parent-errors.patch
-knfsd-nfsd-simplify-exp_pseudoroot.patch
-knfsd-nfsd4-handling-more-nfsd_cross_mnt-errors-in-nfsd4-readdir.patch
-knfsd-nfsd-dont-drop-silently-on-upcall-deferral.patch
-knfsd-svcrpc-remove-another-silent-drop-from-deferral-code.patch
-knfsd-nfsd4-pass-saved-and-current-fh-together-into-nfsd4-operations.patch
-knfsd-nfsd4-remove-spurious-replay_owner-check.patch
-knfsd-nfsd4-move-replay_owner-to-cstate.patch
-knfsd-nfsd4-dont-inline-nfsd4-compound-op-functions.patch
-knfsd-nfsd4-make-verify-and-nverify-wrappers.patch
-knfsd-nfsd4-reorganize-compound-ops.patch
-knfsd-nfsd4-simplify-migration-op-check.patch
-knfsd-nfsd4-simplify-filehandle-check.patch
-knfsd-dont-ignore-kstrdup-failure-in-rpc-caches.patch
-knfsd-fix-up-some-bit-rot-in-exp_export.patch
-ide-hpt3xxn-clocking-fixes.patch
-ide-fix-hpt37x-timing-tables.patch
-ide-optimize-hpt37x-timing-tables.patch
-ide-fix-hpt3xx-hotswap-support.patch
-ide-fix-the-case-of-multiple-hpt3xx-chips-present.patch
-ide-hpt3xx-fix-pci-clock-detection.patch
-ide-hpt3xx-fix-pci-clock-detection-fix-2.patch
-getting-rid-of-all-casts-of-kalloc-calls.patch

 Merged into mainline or a subsystem tree.

+infiniband-work-around-gcc-bug-on-sparc64.patch
+kvm-add-valid_vcpu-helper.patch
+kvm-amd-svm-handle-msr_star-in-32-bit-mode.patch
+kvm-amd-svm-save-and-restore-the-floating-point-unit.patch
+config_vm_event_counter-comment-decrustify.patch
+conditionally-check-expected_preempt_count-in-__resched_legal.patch
+fix-for-shmem_truncate_range-bug_on.patch
+rtc-warning-fix.patch
+slab-fix-kmem_ptr_validate-prototype.patch
+fix-kernel-doc-warnings-in-2620-rc1.patch
+make-kernel-printkcignore_loglevel_setup-static.patch
+fs-sysv-proper-prototypes-for-2-functions.patch
+fix-swapped-parameters-in-mm-vmscanc.patch
+add-cscope-generated-files-to-gitignore.patch
+sched-remove-__cpuinitdata-anotation-to-cpu_isolated_map.patch
+fix-vm_events_fold_cpu-build-breakage.patch
+fix-vm_events_fold_cpu-build-breakage-fix.patch
+build-compileh-earlier.patch
+workstruct-add-assign_bits-to-give-an-atomic-bitops-safe-assignment.patch
+workstruct-use-bitops-safe-direct-assignment.patch
+connector-some-fixes-for-ia64-unaligned-access-errors.patch

 2.6.20 queue

-revert-generic_file_buffered_write-handle-zero-length-iovec-segments.patch
-revert-generic_file_buffered_write-deadlock-on-vectored-write.patch
-generic_file_buffered_write-cleanup.patch
-mm-only-mm-debug-write-deadlocks.patch
-mm-fix-pagecache-write-deadlocks.patch
-mm-fix-pagecache-write-deadlocks-comment.patch
-mm-fix-pagecache-write-deadlocks-xip.patch
-mm-fix-pagecache-write-deadlocks-mm-pagecache-write-deadlocks-efault-fix.patch
-mm-fix-pagecache-write-deadlocks-zerolength-fix.patch
-mm-fix-pagecache-write-deadlocks-stale-holes-fix.patch
-fs-prepare_write-fixes.patch
-fs-prepare_write-fixes-fuse-fix.patch
-fs-prepare_write-fixes-jffs-fix.patch
-fs-prepare_write-fixes-fat-fix.patch
-fs-fix-cont-vs-deadlock-patches.patch

 Dropped (again).

+git-acpi-cpufreq-fixup.patch

 Fix git-acpi.patch

+acpi-make-code-static.patch
+acpi-dock-send-a-uevent-to-indicate-a-device-change.patch
+asus_acpi-add-support-for-asus-z81sp.patch

 ACPI things

-git-alsa-fixup.patch

 Unneeded

+git-alsa-more-borkage.patch

 ALSA fix

+agp-fix-detection-of-aperture-size-versus-gtt-size-on-g965.patch

 AGP fix

+arm-systemh-build-fix.patch

 Fix ARM build

-git-cpufreq-prep.patch
-git-cpufreq-fixup.patch

 Unneeded

+gregkh-driver-uio-documentation.patch
+gregkh-driver-uio-irq.patch

 driver tree updates

+kobject-kobject_uevent-returns-manageable-value.patch
+proper-prototype-for-drivers-base-initcdriver_init.patch
+kref-refcnt-and-false-positives.patch

 driver core fixes and updates

+kthread-api-conversion-for-dvb_frontend-and-av7110.patch
+usbvision-possible-cleanups.patch

 DVB things

+infiniband-fix-for-gregkh-depredations.patch

 Disable some new infiniband drivers due to their not knowing about
 gregkh-driver-network-device.patch.

-git-input-vs-git-alsa.patch

 Renamed.

-git-libata-all-fixup.patch

 Unneeded

+sata_nv-fix-kfree-ordering-in-remove.patch
+libata-dont-initialize-sg-in-ata_exec_internal-if-dma_none-take-2.patch
+pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks-ide-fix.patch

 sata/pata things

+driver-for-silan-sc92031-netdev-fix-more.patch

 Fix driver-for-silan-sc92031-netdev.patch some more.

+remove-the-broken-skmc-driver.patch

 Remove net driver

-spidernet-rx-locking.patch
-spidernet-refactor-rx-refill.patch
+spidernet-remove-rxramfull-tasklet.patch
+spidernet-cleanup-un-needed-api.patch
-spidernet-merge-error-branches.patch
-spidernet-turn-rx-irq-back-on.patch

 spidernet update

+ep93xx-some-minor-cleanups-to-the-ep93xx-eth-driver.patch
+problem-phy-probe-not-working-properly-for-ibm_emac-ppc4xx.patch

 netdev fixes

+pci-disable-multithreaded-probing.patch

 Disable multithreaded-probing.  I have enough problems.

-kbuild-make-fusion-mpt-selectable-from-device-drivers.patch

 Dropped.

+funsoft-is-bust-on-sparc.patch

 Disable funsoft on sparc due to dud patch in the USB queue.

+input-usb-supporting-more-keys-from-the-hut-consumer-page.patch
+usblp-add-serial-number-to-device-id.patch

 USB things.

-x86_64-mm-i386-add-idle-notifier.patch
+x86_64-mm-defconfig-update.patch
+x86_64-mm-i386-defconfig-update.patch
+x86_64-mm-copy-user-nocache.patch
+x86_64-mm-amd-tsc-sync.patch
+x86_64-mm-make-the-numa-hash-function-nodemap-allocation.patch
+x86_64-mm-fix-aout-warning.patch

 x86_64 tree updates

+revert-x86_64-mm-copy-user-nocache.patch

 Toss out old patch from x86_64 tree

+add-memcpy_uncached_read.patch
+add-memcpy_uncached_read-fix.patch
+add-memcpy_uncached_read-tidy.patch
+ib-ipath-use-memcpy_uncached_read-in-rdma-interrupt.patch

 Add in the updated version

+get-rid-of-arch_have_xtime_lock.patch
+x86_64-improved-iommu-documentation.patch
+x86_64-do-not-always-end-the-stack-trace-with-ulong_max.patch
+arch-i386-kernel-e820c-should-include-asm-setuph.patch

 x86 updates

+lumpy-reclaim-v2.patch
+lumpy-reclaim-v2-page_to_pfn-fix.patch
+lumpy-reclaim-v2-tidy.patch

 Teach page reclaim to perform a short physical scan to try to generate free
 higher-order pages.  Needs work.

+nfs-fix-nr_file_dirty-underflow.patch
+nfs-fix-nr_file_dirty-underflow-tidy.patch

 Fix invlaidate_inode_pages2() again.

+alpha-increase-percpu_enough_room.patch

 Alpha fix

+vmscanc-account-for-memory-already-freed-in-seeking-to.patch

 swsusp fix

+m32r-build-fix-for-processors-without-isa_dsp_level2.patch
+m32r-fix-do_page_fault-and-update_mmu_cache.patch
+m32r-update-defconfig-files-for-v2619.patch
+m32r-fix-kernel-entry-address-of-vmlinux.patch
+m32r-cosmetic-updates-and-trivial-fixes.patch

 m32r udpate

+m68k-work-around-binutils-tokenizer-change.patch
+m68k-trivial-build-fixes.patch

 m68k update

+ecryptfs-public-key-transport-mechanism-fix.patch

 Fix ecryptfs-public-key-transport-mechanism.patch

+vt-refactor-console-sak-processing.patch
+sysctl_ms_jiffies-fix-oldlen-semantics.patch
+remove-include-linux-byteorder-pdp_endianh.patch
+9p-use-kthread_stop-instead-of-sending-a-sigkill.patch
+count_vm_events-warning-fix.patch
+parse-boot-parameter-error.patch
+toshiba-tc86c001-ide-driver-take-2.patch
+char-tty-delete-wake_up_interruptible-after-tty_wakeup.patch
+edac-fix-in-e752x-mc-driver.patch
+edac-add-memory-scrubbing-controls-api-to-core.patch
+edac-add-fully-buffered-dimm-apis-to-core.patch
+disable-init-initramfsc-updated.patch
+disable-init-initramfsc-architectures.patch
+usr-gen_init_cpioc-support-for-hard-links.patch
+ioc3-ioc4-pci-mem-space-resources.patch
+char-isicom-remove-tty_hangwakeup-bottomhalves.patch
+procfs-fix-race-between-proc_readdir-and-remove_proc_entry.patch
+procfs-fix-race-between-proc_readdir-and-remove_proc_entry-fix.patch

 Misc.

+tty-make-__proc_set_tty-static.patch
+tty-clarify-disassociate_ctty.patch
+tty-fix-the-locking-for-signal-session-in-disassociate_ctty.patch
+signal-use-kill_pgrp-not-kill_pg-in-the-sunos-compatibility-code.patch
+signal-rewrite-kill_something_info-so-it-uses-newer-helpers.patch
+pid-make-session_of_pgrp-use-struct-pid-instead-of-pid_t.patch
+pid-use-struct-pid-for-talking-about-process-groups-in-exitc.patch
+pid-replace-is_orphaned_pgrp-with-is_current_pgrp_orphaned.patch
+tty-update-the-tty-layer-to-work-with-struct-pid.patch
+pid-replace-do-while_each_task_pid-with-do-while_each_pid_task.patch
+pid-remove-now-unused-do_each_task_pid-and-while_each_task_pid.patch
+pid-remove-the-now-unused-kill_pg-kill_pg_info-and-__kill_pg_info.patch

 rework tty pid handling.

+gtod-uninline-jiffiesh.patch
+gtod-fix-multiple-conversion-bugs-in-msecs_to_jiffies.patch
+gtod-fix-timeout-overflow.patch
+gtod-persistent-clock-support-core.patch
+gtod-persistent-clock-support-i386.patch
+dynticks-uninline-irq_enter.patch
+dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie.patch
+hrtimers-namespace-and-enum-cleanup.patch
+hrtimers-clean-up-locking.patch
+hrtimers-add-state-tracking.patch
+hrtimers-clean-up-callback-tracking.patch
+hrtimers-move-and-add-documentation.patch
+acpi-include-fix.patch
+acpi-keep-track-of-timer-broadcast.patch
+acpi-add-state-propagation-for-dynamic-broadcasting.patch
+acpi-cleanups-allow-early-access-to-pmtimer.patch
+i386-apic-clean-up-the-apic-code.patch
+clockevents-core.patch
+clockevents-i386-drivers.patch
+clockevents-i386-hpet-driver.patch
+i386-apic-rework-and-fix-local-apic-calibration.patch
+high-res-timers-core.patch
+high-res-timers-core-do-itimer-rearming-in-process-context.patch
+high-res-timers-allow-tsc-clocksource-if-pmtimer-present.patch
+dynticks-core.patch
+dynticks-add-nohz-stats-to-proc-stat.patch
+dynticks-i386-support-idle-handler-callbacks.patch
+dynticks-i386-prepare-nmi-watchdog.patch
+high-res-timers-dynticks-i386-support-enable-in-kconfig.patch
+debugging-feature-add-proc-timer_stat.patch
+debugging-feature-proc-timer_list.patch

 Refreshed, refactored dynticks/hrtimer queue.

+hpet-avoid-warning-message-livelock.patch

 hpet fix

+drivers-isdn-pcbit-proper-prototypes.patch

 isdn cleanup

+knfsd-sunrpc-update-internal-api-separate-pmap-register-and-temp-sockets.patch
+knfsd-sunrpc-allow-creating-an-rpc-service-without-registering-with-portmapper.patch
+knfsd-sunrpc-cache-remote-peers-address-in-svc_sock.patch
+knfsd-sunrpc-use-sockaddr_storage-to-store-address-in-svc_deferred_req.patch
+knfsd-sunrpc-add-a-function-to-format-the-address-in-an-svc_rqst-for-printing.patch

 A partial nfsd update.  Eight patches were dropped due to bustage.

+reiser4-fix-write_extent-1.patch

 Part of reiser4-fix-write_extent.patch

+fbdev-driver-for-s3-trio-virge.patch
+remove-broken-video-drivers-v4.patch
+tgafb-switch-to-framebuffer_alloc.patch
+tgafb-fix-copying-overlapping-areas.patch
+tgafb-support-the-directcolor-visual.patch
+tgafb-fix-the-mode-register-setting.patch
+tgafb-module-support-fixes.patch
+tgafb-sync-on-green-support-fixes.patch
+tgafb-fix-the-pci-id-table.patch

 fbdev updates

-md-change-lifetime-rules-for-md-devices.patch
-md-close-a-race-between-destroying-and-recreating-an-md-device.patch
-md-allow-mddevs-to-live-a-bit-longer-to-avoid-a-loop-with-udev.patch

 Dropped.

+slim-debug-output-slm_set_taskperm-remove-horrible-error-handling-code.patch

 Fix slim-debug-output.patch




All 693 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/patch-list


