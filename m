Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVAXKU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVAXKU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 05:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVAXKU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 05:20:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:39552 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261475AbVAXKPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 05:15:47 -0500
Date: Mon, 24 Jan 2005 02:15:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc2-mm1
Message-Id: <20050124021516.5d1ee686.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/


- Lots of updates and fixes all over the place.

- On my test box there is no flashing cursor on the vga console.  Known bug,
  please don't report it.

  Binary searching shows that the bug was introduced by
  cleanup-vc-array-access.patch but that patch is, unfortunately, huge.



Changes since 2.6.11-rc1-mm2:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cifs.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ide-dev.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-scsi-rc-fixes.patch
 bk-usb.patch
 bk-xfs.patch

 Latest versions of various bk trees

-acpi-build-fix-99.patch
-mips-default-mlock-limit-fix.patch
-shared_policy_replace-fix.patch
-generic_file_buffered_write-handle-partial-dio.patch
-cputimeh-seems-to-assume-hz==1000.patch
-ppc32-fix-pmac-kernel-build-with-oprofile.patch
-spinlocking-fixes.patch
-fix-config_agp-depencies.patch
-ioctl-compatibility-for-tiocmiwait-and-tiocgicount.patch
-cls_api-build-fix.patch
-alsa-conversion-to-compat_ioctl-kconfig.patch
-alsa-conversion-to-compat_ioctl-alsa-pcm-api.patch
-alsa-conversion-to-compat_ioctl-alsa-apis.patch
-ac97-audio-support-for-intel-ich7-2611-rc1.patch
-alps-touchpad-detection-fix.patch
-scsi-ncr53c9x-fixes.patch
-uninline-mod_page_state.patch
-fix-audit-control-message-checks.patch
-fix-audit-control-message-checks-tidy.patch
-selinux-add-netlink-message-types-for-the-tc-action-code.patch
-ppc32-update-cpu-state-save-restore.patch
-ppc32-add-missing-prototype.patch
-ppc32-system-platform_device-description-discovery-and-management.patch
-ppc32-infrastructure-changes-to-mpc85xx-sub-arch-from-ocp-to-platform_device.patch
-ppc32-convert-boards-from-using-ocp-to-platform_device.patch
-ppc32-convert-gianfar-ethernet-driver-from-using-an-ocp-to-platform_device.patch
-ppc32-remove-cli-sti-in-arch-ppc-4xx_io-serial_siccc.patch
-ppc32-remove-cli-sti-in-arch-ppc-8xx_io-cs4218_tdmc.patch
-ppc32-remove-cli-sti-in-arch-ppc-8xx_io-fecc.patch
-ppc32-remove-cli-sti-in-arch-ppc-platforms-apus_setupc.patch
-ppc32-remove-cli-sti-in-arch-ppc-platforms-pal4_setupc.patch
-ppc32-remove-cli-sti-in-arch-ppc-syslib-m8xx_setupc.patch
-ppc32-remove-cli-sti-in-arch-ppc-syslib-qspan_pcic.patch
-ppc32-mpc8xx-tlb-miss-vs-tlb-error-fix.patch
-ppc32-update_process_times-simplification.patch
-ppc32-add-defconfigs-for-85xx-boards.patch
-ppc64-remove-config_irq_all_cpus.patch
-ppc64-pci-eeh-documentation.patch
-ppc64-ppc-cleanup-pci-skipping.patch
-ppc64-minimum-hashtable-size.patch
-ppc64-remove-some-unused-iseries-functions.patch
-fix-xenu-kernel-crash-in-dmi_iterate.patch
-x86-use-cpumask_t-instead-of-unsigned-long.patch
-i386-init_intel_cacheinfo-can-be-__init.patch
-arch-i386-kernel-signalc-fix-err-test-twice.patch
-fix-num_online_nodes-warning-on-numa-q.patch
-x86_64-fix-cmp-with-interleaving.patch
-x86_64-fix-flush-race-on-context-switch.patch
-i386-x86-64-fix-smp-nmi-watchdog-race.patch
-x86-64-fix-pud-typo-in-ioremap.patch
-x86-64-fix-do_suspend_lowlevel.patch
-x86-64-clean-up-cpuid-level-detection.patch
-kprobes-x86_64-memory-allocation-changes.patch
-h8-300-defconfig-update.patch
-h8-300-mm-update.patch
-swsusp-remove-on2-algorithm-in-page-relocation.patch
-driver-model-pass-pm_message_t-down-to-pci-drivers.patch
-uml-provide-an-arch-specific-define-for-register-file-size.patch
-uml-provide-some-initcall-definitions-for-userspace-code.patch
-uml-provide-a-release-method-for-the-ubd-driver.patch
-uml-allow-ubd-devices-to-provide-partial-end-blocks.patch
-uml-change-for_each_cpu-to-for_each_online_cpu.patch
-uml-eliminate-unhandled-sigprof-on-halt.patch
-uml-fix-__pud_alloc-definition-to-match-the-declaration.patch
-uml-fix-a-stack-corruption-crash.patch
-uml-define-__have_arch_cmpxchg-on-x86.patch
-file_tableexpand_files-code-cleanup.patch
-file_tableexpand_files-code-cleanup-remove-debug.patch
-minor-ext3-speedup.patch
-move-read-only-and-immutable-checks-into-permission.patch
-factor-out-common-code-around-follow_link-invocation.patch
-radio-typhoon-use-correct-module_param-data-type.patch
-avoid-sparse-warning-due-to-time-interpolator.patch
-allow-all-architectures-to-set-config_debug_preempt.patch
-binfmt_elf-allow-mips-to-overrid-e_flags.patch
-remove-bogus-softirq_pending-usage-in-cris.patch
-switch-frw-to-use-local_soft_irq_pending.patch
-scripts-referencepl-treat-built-ino-as-conglomerate.patch
-vgacon-fixes-to-help-font-restauration-in-x11.patch
-use-official-unicodes-for-dec-vt-characters.patch
-ext3-commit-superblock-before-panicking.patch
-consolidate-arch-specific-resourceh-headers.patch
-use-wno-pointer-sign-for-gcc-40.patch
-fix-init_sighand-warning-on-mips.patch
-add-page_offset-to-mmh.patch
-minor-ipmi-driver-updates.patch
-completion-api-additions.patch
-convert-xfs-to-unlocked_ioctl-and-compat_ioctl.patch
-some-fixes-for-compat-ioctl.patch
-convert-infiniband-mad-driver-to-compat-unlocked_ioctl.patch
-support-compat_ioctl-for-block-devices.patch
-convert-cciss-to-compat_ioctl.patch
-add-compat_ioctl-to-frame-buffer-layer.patch
-convert-sis-fb-driver-to-compat_ioctl.patch
-convert-dv1394-driver-to-compat_ioctl.patch
-convert-video1394-driver-to-compat_ioctl.patch
-convert-amdtp-driver-to-compat_ioctl.patch
-fat-kill-fatfs_symsc.patch
-fat-merge-msdos_fs_isbh-into-msdos_fsh.patch
-fat-is_badchar-is_replacechr-is_skipchar-cleanup.patch
-fat-is_badchar-is_replacechr-is_skipchar-cleanup-cleanup.patch
-fat-return-better-error-codes-from.patch
-fat-manually-inline-shortname_info_to_lcase.patch
-fat-use-vprintk-instead-of-snprintf-with-static.patch
-fat-kill-unnecessary-kmap.patch
-fat-fs-fat-cachec-make-__fat_access-static.patch
-fat-lindent-fs-msdos-nameic.patch
-fat-lindent-fs-vfat-nameic.patch
-fat-lindent-fs-vfat-nameic-fix.patch
-fat-fs-fat-cleanup.patch
-fat-reserved-clusters-cleanup.patch
-fat-show-current-nls-config-even-if-its-default.patch
-lock-initializer-cleanup-ppc.patch
-lock-initializer-cleanup-m32r.patch
-lock-initializer-cleanup-video.patch
-lock-initializer-cleanup-ide.patch
-lock-initializer-cleanup-sound.patch
-lock-initializer-cleanup-sh.patch
-lock-initializer-cleanup-ppc64.patch
-lock-initializer-cleanup-security.patch
-lock-initializer-cleanup-core.patch
-lock-initializer-cleanup-media-drivers.patch
-lock-initializer-cleanup-block-devices.patch
-lock-initializer-cleanup-s390.patch
-lock-initializer-cleanup-usermode.patch
-lock-initializer-cleanup-scsi.patch
-lock-initializer-cleanup-sparc.patch
-lock-initializer-cleanup-v850.patch
-lock-initializer-cleanup-i386.patch
-lock-initializer-cleanup-drm.patch
-lock-initializer-cleanup-firewire.patch
-lock-initializer-cleanup-arm26.patch
-lock-initializer-cleanup-m68k.patch
-lock-initializer-cleanup-network-drivers.patch
-lock-initializer-cleanup-mtd.patch
-lock-initializer-cleanup-x86_64.patch
-lock-initializer-cleanup-filesystems.patch
-lock-initializer-cleanup-ia64.patch
-lock-initializer-cleanup-raid.patch
-lock-initializer-cleanup-isdn.patch
-lock-initializer-cleanup-parisc.patch
-lock-initializer-cleanup-sparc64.patch
-lock-initializer-cleanup-arm.patch
-lock-initializer-cleanup-misc-drivers.patch
-lock-initializer-cleanup-alpha.patch
-lock-initializer-cleanup-character-devices.patch
-lock-initializer-cleanup-drivers-serial.patch
-lock-initializer-cleanup-frv.patch
-typo-in-arch-x86_64-kconfig.patch

 Merged

+dib3000mc-build-fix.patch

 compile fix

+fbdev-screen-corruption-fix.patch

 fbdev screen corruption fix

+mips-fixed-conflicting-types.patch

 MIPS build fix

+bug-in-io_destroy-fs-aioc1248.patch

 AIO fix

+oprofile-falling-back-on-timer-interrupt-mode.patch

 opofile timer-mode fallback fix

+compat-ioctl-security-hook-fixup.patch

 Restore missing security hook

-bk-acpi-revert-20041210.patch

 Hopefully this is no longer needed

+hda_intel-fix.patch

 ALSA build fix

+tpm_msc-build-fix.patch
+tpm_atmel-build-fix.patch

 Fix Greg's stuff

+driver-model-more-pm_message_t-conversion.patch
+driver-model-more-pci_choose_states-are-needed.patch

 power management/driver model updates

+kbuild-no-redundant-srctree-in-tags-file.patch

 `make tags' fix

+mm-oom-killer-tunable.patch
+mm-keep-balance-between-different-classzones.patch
+mm-fix-several-oom-killer-bugs.patch
+mm-convert-memdie-to-an-atomic-thread-bitflag.patch
+make-used_math-smp-safe.patch
+mm-adjust-dirty-threshold-for-lowmem-only-mappings.patch
+mm-truncate-smp-race-fix.patch

 Various page allocator and oom killer fixes/updates

+simpler-topdown-mmap-layout-allocator.patch

 Simplify the virtual address layout logic

+alloc_zeroed_user_highpage-to-fix-the-clear_user_highpage-issue.patch

 Fix clear_user_highpage on architectures with funky caches

+smc91x-power-down-phy-on-suspend.patch
+e100-locking-up-netconsole.patch

 net driver fixes

+ppc32-add-defconfigs-for-85xx-boards-updated.patch

 ppc32 defconfig updates

+ppc32-allow-usage-of-gen550-on-platforms-that-do-not-define.patch
+ppc32-missing-call-to-ioremap-in-pci_iomap.patch
+ppc32-fix-pci2-io-space-mapping-on-cds.patch
+ppc32-add-support-for-pegasos-machines.patch

 ppc32 updates

+ppc64-limit-segment-tables-on-up-kernels.patch
+ppc64-xmon-data-breakpoints-on-partitioned-systems.patch
+ppc64-fix-in_be64-definition.patch
+ppc64-clear-msr_ri-earlier-in-syscall-exit-path.patch
+ppc64-replace-schedule_timeout-in-iseries_pci_reset.patch
+ppc64-replace-schedule_timeout-in-pseries_cpu_die.patch
+ppc64-replace-schedule_timeout-in-__cpu_up.patch
+ppc64-replace-schedule_timeout-in-die.patch
+ppc64-trivial-cleanup-eeh_region.patch
+ppc64-sparse-fixes-for-cpu-feature-constants.patch
+ppc64-use-kref-for-device_node-refcounting.patch
+ppc64-allow-eeh-to-be-disabled.patch
+ppc64-disable-some-boot-wrapper-debug.patch
+ppc64-problem-disabling-sysvipc.patch
+ppc64-enable-virtual-ethernet-and-virtual-scsi.patch

 ppc64 updates

+x86-remove-unused-function.patch

 cleanup

+x86_64-remove-centaur-mtrr-support.patch
+x86_64-remove-duplicated-includes.patch
+x86_64-enlarge-northbridge-numa-scan-mask.patch
+x86_64-remove-earlyprintk-help.patch
+x86_64-speed-up-suspend.patch

 x86_64 update

+h8300-fix-warning.patch
+h8300-makefile-update.patch

 H8/300 updates

+swsusp-comment-fix.patch

 Fix a comment

+kill-softirq_pending-fix.patch

 Remove softirq_pending()

+ext2-ext3-block-allocator-startup-fix.patch

 Fix ext2/ext3 block allocator buglet

+ext3-quota-leak-fix.patch

 Fix error-path quota leak

+ext3-fix-ea-in-inode-default-acl-creation.patch
+ext2-ext3-acls-remove-the-number-of-acl-entries-limit.patch

 EA/ACL fixes

+jbd-journal-overflow-fix.patch
+jbd-journal-overflow-fix-fixes.patch
+jbd-fix-against-journal-overflow.patch
+jbd-fix-against-journal-overflow-tidies.patch
+jbd-log-space-management-optimization.patch

 Various JBD corner-case fixes

+i4l-new-hfc_usb-driver-version.patch
+i4l-hfc-4s-and-hfc-8s-driver.patch

 i4l updates

+i810_audio-offset-lvi-from-civ-to-avoid-stalled-start.patch

 Audio driver fix

+configurable-delay-before-mounting-root-device.patch

 Add `delay=' boot option

+fs-mbcachec-remove-an-unused-wait-queue-variable.patch

 Dead code

+device-mapper-fix-mirror-log-type-module-ref-count.patch
+device-mapper-remove-unused-bs_bio_init.patch
+device-mapper-add-presuspend-hook.patch
+device-mapper-optionally-bypass-a-bdget.patch
+device-mapper-fix-tb-stripe-data-corruption.patch

 DM updates

+arm26-new-maintainer-of-archimedes-floppy-and-hard-disk-drivers.patch

 MAINTAINERS update

+problems-disabling-sysctl.patch

 Add sys32_sysctl stub

+genhd-rename-device_init.patch

 Namespace cleanup

+fix-race-between-the-nmi-code-and-the-cmos-clock.patch

 Fix race between concurrent accesses to the x86 CMOS chip

+infiniband-core-compat_ioctl-conversion-minor-fixes.patch
+infiniband-mthca-more-arbel-mem-free-support.patch
+infiniband-mthca-implement-modifying-port-attributes.patch
+infiniband-core-fix-port-capability-enums-bit-order.patch
+infiniband-mthca-dont-write-ecr-in-msi-x-mode.patch
+infiniband-mthca-pass-full-process_mad-info-to-firmware.patch
+infiniband-mthca-optimize-event-queue-handling.patch
+infiniband-mthca-test-irq-routing-during-initialization.patch
+infiniband-ipoib-remove-uses-of-yield.patch
+infiniband-core-add-issm-userspace-support.patch
+infiniband-mthca-clean-up-ioremap-request_region-usage.patch
+infiniband-mthca-remove-x86-sse-pessimization.patch

 infiniband updates

+random-pt4-create-new-rol32-ror32-bitops.patch
+random-pt4-use-them-throughout-the-tree.patch
+random-pt4-kill-the-sha-variants.patch
+random-pt4-cleanup-sha-interface.patch
+random-pt4-move-sha-code-to-lib.patch
+random-pt4-replace-sha-with-faster-version.patch
+random-pt4-replace-sha-with-faster-version-fix.patch
+random-pt4-update-cryptolib-to-use-sha-fro-lib.patch
+random-pt4-move-halfmd4-to-lib.patch
+random-pt4-kill-duplicate-halfmd4-in-ext3-htree.patch
+random-pt4-kill-duplicate-halfmd4-in-ext3-htree-fix.patch
+random-pt4-simplify-and-shrink-syncookie-code.patch
+random-pt4-move-syncookies-to-net.patch
+random-pt4-move-other-tcp-ip-bits-to-net.patch

 More random driver slash-and-burn

+posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic.patch
+posix-timers-high-resolution-cpu-clocks-for-posix-clock_-syscalls.patch
+posix-timers-fix-posix-timers-signals-lock-order.patch
+posix-timers-cpu-clock-support-for-posix-timers.patch
+make-itimer_real-per-process.patch
+make-itimer_prof-itimer_virtual-per-process.patch
+make-rlimit_cpu-sigxcpu-per-process.patch

 Bunch of timekeeping updates, including per-thread cpu clocks.  Needs a
 patched glibc to test it.

+mips-fixed-ltt-build-errors.patch
+ltt-doesnt-build-on-x86_64.patch

 Fix ltt-induced MIPS build errors

+nfsacl-protocol-extension-for-nfsv3.patch
+nfsacl-return-enosys-for-rpc-programs-that-are-unavailable.patch
+nfsacl-add-missing-eopnotsupp-=-nfs3err_notsupp-mapping-in-nfsd.patch
+nfsacl-allow-multiple-programs-to-listen-on-the-same-port.patch
+nfsacl-allow-multiple-programs-to-share-the-same-transport.patch
+nfsacl-lazy-rpc-receive-buffer-allocation.patch
+nfsacl-encode-and-decode-arbitrary-xdr-arrays.patch
+nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix.patch
+nfsacl-add-noacl-nfs-mount-option.patch
+nfsacl-infrastructure-and-server-side-of-nfsacl.patch
+nfsacl-solaris-nfsacl-workaround.patch
+nfsacl-client-side-of-nfsacl.patch
+nfsacl-acl-umask-handling-workaround-in-nfs-client.patch
+nfsacl-cache-acls-on-the-nfs-client-side.patch

 ACLs for ther NFS client.

-jbd-remove-livelock-avoidance.patch

 Dropped - this optimisation was never right and I lost interest in it.

+sched-account-rt_tasks-as-iso_ticks.patch

 SCHED_ISO fix

+videotext-ioctls-changed-to-use-_io-macros.patch
+video-arv-remove-casts.patch
+video-w9966-remove-casts.patch
+video-zr36120-remove-casts.patch
+v4l-video-buf-update.patch
+v4l2-tuner-api-update.patch
+v4l-tuner-update.patch
+v4l-add-tveeprom-module.patch
+v4l-tvaudio-update.patch
+v4l-bttv-ir-input-driver-update.patch
+v4l-bttv-update.patch
+v4l-saa7134-module.patch

 v4l updates.

+crashdump-reserving-backup-region-for-kexec-based.patch

 crashdump-via-kexec update

+fix-architecture-names-in-hugetlbpagetxt.patch

 Documentation fix

+fuse-fix-llseek-on-device.patch

 FUSE fix

+kernel-configsc-make-a-variable-static.patch
+kernel-forkc-make-mm_cachep-static.patch
+kernel-kallsymsc-make-some-code-static.patch
+mm-page-writebackc-remove-an-unused-function.patch
+mm-shmemc-make-a-struct-static.patch
+make-loglevels-in-init-mainc-a-little-more-sane.patch
+isicom-use-null-for-pointer.patch
+remove-bouncing-email-address-of-hennus-bergman.patch
+cirrusfbc-make-some-code-static.patch
+matroxfb_basec-make-some-code-static.patch
+asiliantfbc-make-some-code-static.patch
+i386-apic-kconfig-cleanups.patch
+security-seclvlc-make-some-code-static.patch
+drivers-block-elevatorc-make-two-functions-static.patch
+drivers-block-rdc-make-two-variables-static.patch
+loopc-make-two-functions-static.patch
+remove-bouncing-email-address-of-thomas-hood.patch
+fs-adfs-dir_fc-remove-an-unused-function.patch
+drivers-char-moxac-if-0-an-unused-function.patch

 Little fixes.



number of patches in -mm: 534
number of changesets in external trees: 386
number of patches in -mm only: 517
total patches: 903




All 534 patches:


linus.patch

dib3000mc-build-fix.patch
  dib3000mc build fix

fbdev-screen-corruption-fix.patch
  fbdev: screen corruption fix

mips-fixed-conflicting-types.patch
  mips: fixed conflicting types

bug-in-io_destroy-fs-aioc1248.patch
  Fix BUG in io_destroy

oprofile-falling-back-on-timer-interrupt-mode.patch
  oprofile: falling back on timer interrupt mode

compat-ioctl-security-hook-fixup.patch
  compat ioctl security hook fixup

ia64-acpi-build-fix.patch
  ia64 acpi build fix

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

bk-acpi.patch

acpi-sleep-while-atomic-during-s3-resume-from-ram.patch
  acpi: sleep-while-atomic during S3 resume from ram

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

acpi-flush-tlb-when-pagetable-changed.patch
  acpi: flush TLB when pagetable changed

acpi-kfree-fix.patch
  a

bk-agpgart.patch

bk-alsa.patch

hda_intel-fix.patch
  hda_intel macro expansion fix

bk-arm.patch

bk-cifs.patch

bk-driver-core.patch

tpm_msc-build-fix.patch
  tpm_msc-build-fix

tpm_atmel-build-fix.patch
  tpm_atmel build fix

driver-model-more-pm_message_t-conversion.patch
  driver model: more pm_message_t conversion

driver-model-more-pci_choose_states-are-needed.patch
  driver model: more pci_choose_state()s are needed

bk-drm.patch

bk-drm-via.patch

bk-i2c.patch

bk-ide-dev.patch

ide-dev-build-fix.patch
  ide-dev-build-fix

bk-input.patch

disable-sidewinder-debug-messages.patch
  Disable Sidewinder debug messages

bk-dtor-input.patch

kbuild-no-redundant-srctree-in-tags-file.patch
  kbuild: no redundant srctree in tags file

seagate-st3200822as-sata-disk-needs-to-be-in-sil_blacklist-as-well.patch
  Seagate ST3200822AS SATA disk needs to be in sil_blacklist as well

bk-netdev.patch

bk-ntfs.patch

prevent-pci_name_bus-buffer-overflows.patch
  prevent pci_name_bus() buffer overflows

maintainers-add-entry-for-qla2xxx-driver.patch
  MAINTAINERS: add entry for qla2xxx driver.

bk-scsi-rc-fixes.patch

bk-usb.patch

bk-xfs.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

mm-oom-killer-tunable.patch
  mm: oom-killer tunable

mm-keep-balance-between-different-classzones.patch
  mm: rework lower-zone protection initialisation

mm-fix-several-oom-killer-bugs.patch
  mm: fix several oom killer bugs

mm-convert-memdie-to-an-atomic-thread-bitflag.patch
  mm: convert memdie to an atomic thread bitflag

make-used_math-smp-safe.patch
  make used_math SMP-safe

mm-adjust-dirty-threshold-for-lowmem-only-mappings.patch
  mm: adjust dirty threshold for lowmem-only mappings

mm-truncate-smp-race-fix.patch
  mm: truncate SMP race fix

vm-pageout-throttling.patch
  vm: pageout throttling

orphaned-pagecache-memleak-fix.patch
  orphaned pagecache memleak fix

swapspace-layout-improvements.patch
  swapspace-layout-improvements

simpler-topdown-mmap-layout-allocator.patch
  simpler topdown mmap layout allocator

alloc_zeroed_user_highpage-to-fix-the-clear_user_highpage-issue.patch
  alloc_zeroed_user_highpage() to fix the clear_user_highpage issue

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

pcnet32-79c976-with-fiber-optic.patch
  pcnet32: 79c976 with fiber optic fix

add-omap-support-to-smc91x-ethernet-driver.patch
  Add OMAP support to smc91x Ethernet driver

b44-bounce-buffer-fix.patch
  b44 bounce buffering fix

netpoll-fix-napi-polling-race-on-smp.patch
  netpoll: fix NAPI polling race on SMP

tun-tan-arp-monitor-support.patch
  tun/tap ARP monitor support

atmel_cs-add-support-lg-lw2100n-wlan-pcmcia-card.patch
  atmel_cs: Add support LG LW2100N WLAN PCMCIA card

smc91x-power-down-phy-on-suspend.patch
  smc91x: power down PHY on suspend

e100-locking-up-netconsole.patch
  e100 locking up netconsole.

ppc32-add-defconfigs-for-85xx-boards-updated.patch
  ppc32: Add defconfigs for 85xx boards -- updated

ppc32-pmac-sleep-support-update.patch
  ppc32: pmac sleep support update

add-try_acquire_console_sem.patch
  Add try_acquire_console_sem

update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch
  update aty128fb sleep/wakeup code for new powermac changes

radeonfb-massive-update-of-pm-code.patch
  radeonfb: massive update of PM code

radeonfb-build-fix.patch
  radeonfb-build-fix

ppc32-allow-usage-of-gen550-on-platforms-that-do-not-define.patch
  ppc32: allow usage of gen550 on platforms that do not define SERIAL_PORT_DFNS

ppc32-missing-call-to-ioremap-in-pci_iomap.patch
  ppc32: missing call to ioremap in pci_iomap()

ppc32-fix-pci2-io-space-mapping-on-cds.patch
  ppc32: fix PCI2 IO space mapping on CDS

ppc32-add-support-for-pegasos-machines.patch
  ppc32: Add support for Pegasos machines

ppc64-limit-segment-tables-on-up-kernels.patch
  ppc64: limit segment tables on UP kernels

ppc64-xmon-data-breakpoints-on-partitioned-systems.patch
  ppc64: xmon data breakpoints on partitioned systems

ppc64-fix-in_be64-definition.patch
  ppc64: fix in_be64 definition

ppc64-clear-msr_ri-earlier-in-syscall-exit-path.patch
  ppc64: clear MSR_RI earlier in syscall exit path

ppc64-replace-schedule_timeout-in-iseries_pci_reset.patch
  ppc64: replace schedule_timeout in iSeries_pci_reset

ppc64-replace-schedule_timeout-in-pseries_cpu_die.patch
  ppc64: replace schedule_timeout in pSeries_cpu_die

ppc64-replace-schedule_timeout-in-__cpu_up.patch
  ppc64: replace schedule_timeout in __cpu_up

ppc64-replace-schedule_timeout-in-die.patch
  ppc64: replace schedule_timeout in die

ppc64-trivial-cleanup-eeh_region.patch
  ppc64: trivial cleanup: EEH_REGION

ppc64-sparse-fixes-for-cpu-feature-constants.patch
  ppc64: sparse fixes for cpu feature constants

ppc64-use-kref-for-device_node-refcounting.patch
  ppc64: use kref for device_node refcounting

ppc64-allow-eeh-to-be-disabled.patch
  ppc64: allow EEH to be disabled

ppc64-disable-some-boot-wrapper-debug.patch
  ppc64: disable some boot wrapper debug

ppc64-problem-disabling-sysvipc.patch
  ppc64: problem disabling SYSVIPC

ppc64-enable-virtual-ethernet-and-virtual-scsi.patch
  ppc64: enable virtual ethernet and virtual scsi

ppc64-reloc_hide.patch

agpgart-allow-multiple-backends-to-be-initialized.patch
  agpgart: allow multiple backends to be initialized
  agpgart-allow-multiple-backends-to-be-initialized fix
  agpgart: add bridge assignment missed in agp_allocate_memory
  x86_64 agp failure fix

agpgart-add-agp_find_bridge-function.patch
  agpgart: add agp_find_bridge function

agpgart-allow-drivers-to-allocate-memory-local-to.patch
  agpgart: allow drivers to allocate memory local to the bridge

drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
  drm: add support for new multiple agp bridge agpgart api

fb-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
  fb: add support for new multiple agp bridge agpgart api

agpgart-add-bridge-parameter-to-driver-functions.patch
  agpgart: add bridge parameter to driver functions

superhyway-bus-support.patch
  SuperHyway bus support

x86-no-interrupts-from-secondary-cpus-until-officially-online.patch
  x86: no interrupts from secondary CPUs until officially online

x86-remove-unused-function.patch
  x86: Remove unused function

x86_64-remove-centaur-mtrr-support.patch
  x86_64: remove centaur mtrr support

x86_64-remove-duplicated-includes.patch
  x86_64: remove duplicated includes

x86_64-enlarge-northbridge-numa-scan-mask.patch
  x86_64: Enlarge northbridge numa scan mask

x86_64-remove-earlyprintk-help.patch
  x86_64: Remove earlyprintk help

x86_64-speed-up-suspend.patch
  x86_64: Speed up suspend

xen-vmm-4-add-ptep_establish_new-to-make-va-available.patch
  Xen VMM #4: add ptep_establish_new to make va available

xen-vmm-4-return-code-for-arch_free_page.patch
  Xen VMM #4: return code for arch_free_page

xen-vmm-4-return-code-for-arch_free_page-fix.patch
  Get rid of arch_free_page() warning

xen-vmm-4-runtime-disable-of-vt-console.patch
  Xen VMM #4: runtime disable of VT console

xen-vmm-4-has_arch_dev_mem.patch
  Xen VMM #4: HAS_ARCH_DEV_MEM

xen-vmm-4-split-free_irq-into-teardown_irq.patch
  Xen VMM #4: split free_irq into teardown_irq

h8300-fix-warning.patch
  h8300: fix warning

h8300-makefile-update.patch
  h8300: makefile update

swsusp-comment-fix.patch
  swsusp: fix buggy comment

wacom-tablet-driver.patch
  wacom tablet driver

force-feedback-support-for-uinput.patch
  Force feedback support for uinput

kmap_atomic-takes-char.patch
  kmap_atomic takes char*

kmap_atomic-takes-char-fix.patch
  kmap_atomic-takes-char-fix

kmap_atomic-fallout.patch
  kmap_atomic fallout

kunmap-fallout-more-fixes.patch
  kunmap-fallout-more-fixes

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
  Allow admin to enable only some of the Magic-Sysrq functions

sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch
  Sort out PCI_ROM_ADDRESS_ENABLE vs IORESOURCE_ROM_ENABLE

irqpoll.patch
  irqpoll

poll-mini-optimisations.patch
  poll: mini optimisations

mtrr-size-and-base-debug.patch
  mtrr size-and-base debugging

cleanup-vc-array-access.patch
  cleanup vc array access

remove-console_macrosh.patch
  remove console_macros.h

merge-vt_struct-into-vc_data.patch
  merge vt_struct into vc_data

kill-softirq_pending.patch
  kill softirq_pending()

kill-softirq_pending-fix.patch
  kill-softirq_pending fix

clean-up-uts_release-usage.patch
  clean up UTS_RELEASE usage

3c59x-ethtool-provide-nic-specific-stats.patch
  3c59x ethtool: provide NIC-specific stats

ext2-ext3-block-allocator-startup-fix.patch
  ext2/ext3: block allocator startup fix

ext3-quota-leak-fix.patch
  ext3: fix error-path quota leak

ext3-ea-no-lock-needed-when-freeing-inode.patch
  ext3/ea: no lock needed when freeing inode

ext3-ea-set-the-ext3_feature_compat_ext_attr-for-in-inode-xattrs.patch
  ext3/ea: set the EXT3_FEATURE_COMPAT_EXT_ATTR for in-inode xattrs

ext3-ea-documentation-fix.patch
  ext3/ea: documentation fix

ext3-ea-fix-i_extra_isize-check.patch
  ext3/ea: ix i_extra_isize check

ext3-ea-disallow-in-inode-attributes-for-reserved-inodes.patch
  ext3/ea: disallow in-inode attributes for reserved inodes

ext3-fix-ea-in-inode-default-acl-creation.patch
  ext3: fix ea-in-inode default ACL creation

ext2-ext3-acls-remove-the-number-of-acl-entries-limit.patch
  ext2/ext3 ACLs: remove the number of acl entries limit

jbd-journal-overflow-fix.patch
  JBD: journal overflow fix

jbd-journal-overflow-fix-fixes.patch
  jbd-journal-overflow-fix-fixes

jbd-fix-against-journal-overflow.patch
  JBD: fix against journal overflow

jbd-fix-against-journal-overflow-tidies.patch
  jbd-fix-against-journal-overflow-tidies

jbd-log-space-management-optimization.patch
  JBD: log space management optimization

i4l-new-hfc_usb-driver-version.patch
  i4l: new hfc_usb driver version

i4l-hfc-4s-and-hfc-8s-driver.patch
  i4l: HFC-4S and HFC-8S driver

i810_audio-offset-lvi-from-civ-to-avoid-stalled-start.patch
  i810_audio: offset LVI from CIV to avoid stalled start

configurable-delay-before-mounting-root-device.patch
  Configurable delay before mounting root device

fs-mbcachec-remove-an-unused-wait-queue-variable.patch
  fs/mbcache.c: Remove an unused wait queue variable

device-mapper-fix-mirror-log-type-module-ref-count.patch
  device-mapper: fix mirror log type module ref count

device-mapper-remove-unused-bs_bio_init.patch
  device-mapper: remove unused bs_bio_init()

device-mapper-add-presuspend-hook.patch
  device-mapper: Add presuspend hook

device-mapper-optionally-bypass-a-bdget.patch
  device-mapper: optionally bypass a bdget

device-mapper-fix-tb-stripe-data-corruption.patch
  device-mapper: fix TB stripe data corruption

arm26-new-maintainer-of-archimedes-floppy-and-hard-disk-drivers.patch
  arm26: new maintainer of Archimedes floppy and hard disk drivers

problems-disabling-sysctl.patch
  Problems disabling SYSCTL

genhd-rename-device_init.patch
  genhd: rename device_init

fix-race-between-the-nmi-code-and-the-cmos-clock.patch
  Fix race between the NMI code and the CMOS clock

infiniband-core-compat_ioctl-conversion-minor-fixes.patch
  InfiniBand/core: compat_ioctl conversion minor fixes

infiniband-mthca-more-arbel-mem-free-support.patch
  InfiniBand/mthca: more Arbel Mem-Free support

infiniband-mthca-implement-modifying-port-attributes.patch
  InfiniBand/mthca: implement modifying port attributes

infiniband-core-fix-port-capability-enums-bit-order.patch
  InfiniBand/core: fix port capability enums bit order

infiniband-mthca-dont-write-ecr-in-msi-x-mode.patch
  InfiniBand/mthca: don't write ECR in MSI-X mode

infiniband-mthca-pass-full-process_mad-info-to-firmware.patch
  InfiniBand/mthca: pass full process_mad info to firmware

infiniband-mthca-optimize-event-queue-handling.patch
  InfiniBand/mthca: optimize event queue handling

infiniband-mthca-test-irq-routing-during-initialization.patch
  InfiniBand/mthca: test IRQ routing during initialization

infiniband-ipoib-remove-uses-of-yield.patch
  InfiniBand/ipoib: remove uses of yield()

infiniband-core-add-issm-userspace-support.patch
  InfiniBand/core: add IsSM userspace support

infiniband-mthca-clean-up-ioremap-request_region-usage.patch
  InfiniBand/mthca: clean up ioremap()/request_region() usage

infiniband-mthca-remove-x86-sse-pessimization.patch
  InfiniBand/mthca: remove x86 SSE pessimization

random-pt2-cleanup-waitqueue-logic-fix-missed-wakeup.patch
  random: cleanup waitqueue logic, fix missed wakeup

random-pt2-kill-pool-clearing.patch
  random: kill pool clearing

random-pt2-combine-legacy-ioctls.patch
  random: combine legacy ioctls

random-pt2-re-init-all-pools-on-zero.patch
  random: re-init all pools on zero

random-pt2-simplify-initialization.patch
  random: simplify initialization

random-pt2-kill-memsets-of-static-data.patch
  random: kill memsets of static data

random-pt2-kill-dead-extract_state-struct.patch
  random: kill dead extract_state struct

random-pt2-kill-22-compat-waitqueue-defs.patch
  random: kill 2.2 compat waitqueue defs

random-pt2-kill-redundant-rotate_left-definitions.patch
  random: kill redundant rotate_left definitions

random-pt2-kill-misnamed-log2.patch
  random: kill misnamed log2

random-pt3-more-meaningful-pool-names.patch
  random: More meaningful pool names

random-pt3-static-allocation-of-pools.patch
  random: Static allocation of pools

random-pt3-static-sysctl-bits.patch
  random: Static sysctl bits

random-pt3-catastrophic-reseed-checks.patch
  random: Catastrophic reseed checks

random-pt3-entropy-reservation-accounting.patch
  random: Entropy reservation accounting

random-pt3-reservation-flag-in-pool-struct.patch
  random: Reservation flag in pool struct

random-pt3-reseed-pointer-in-pool-struct.patch
  random: Reseed pointer in pool struct

random-pt3-break-up-extract_user.patch
  random: Break up extract_user

random-pt3-remove-dead-md5-copy.patch
  random: Remove dead MD5 copy

random-pt3-simplify-hash-folding.patch
  random: Simplify hash folding

random-pt3-clean-up-hash-buffering.patch
  random: Clean up hash buffering

random-pt3-remove-entropy-batching.patch
  random: Remove entropy batching

random-pt4-create-new-rol32-ror32-bitops.patch
  random: Create new rol32/ror32 bitops

random-pt4-use-them-throughout-the-tree.patch
  random: Use them throughout the tree

random-pt4-kill-the-sha-variants.patch
  random: Kill the SHA variants

random-pt4-cleanup-sha-interface.patch
  random: Cleanup SHA interface

random-pt4-move-sha-code-to-lib.patch
  random: Move SHA code to lib/

random-pt4-replace-sha-with-faster-version.patch
  random: Replace SHA with faster version

random-pt4-replace-sha-with-faster-version-fix.patch
  random-pt4-replace-sha-with-faster-version-fix

random-pt4-update-cryptolib-to-use-sha-fro-lib.patch
  random: Update cryptolib to use SHA fro lib

random-pt4-move-halfmd4-to-lib.patch
  random: Move halfmd4 to lib

random-pt4-kill-duplicate-halfmd4-in-ext3-htree.patch
  random: Kill duplicate halfmd4 in ext3 htree

random-pt4-kill-duplicate-halfmd4-in-ext3-htree-fix.patch
  random-pt4-kill-duplicate-halfmd4-in-ext3-htree-fix

random-pt4-simplify-and-shrink-syncookie-code.patch
  random: Simplify and shrink syncookie code

random-pt4-move-syncookies-to-net.patch
  random: Move syncookies to net/

random-pt4-move-other-tcp-ip-bits-to-net.patch
  random: Move other tcp/ip bits to net/

speedup-proc-pid-maps.patch
  Speed up /proc/pid/maps

speedup-proc-pid-maps-fix.patch
  Speed up /proc/pid/maps fix

speedup-proc-pid-maps-fix-fix.patch
  speedup-proc-pid-maps fix fix

speedup-proc-pid-maps-fix-fix-fix.patch
  speedup /proc/<pid>/maps(4th version)

fix-loss-of-records-on-size-4096-in-proc-pid-maps.patch
  fix loss of records on size > 4096 in proc/<pid>/maps

speedup-proc-pid-maps-fix-fix-fix-fix.patch
  speedup-proc-pid-maps-fix-fix-fix fix

inotify.patch
  inotify

posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic.patch
  posix-timers: tidy up clock interfaces and consolidate dispatch logic

posix-timers-high-resolution-cpu-clocks-for-posix-clock_-syscalls.patch
  posix-timers: high-resolution CPU clocks for POSIX clock_* syscalls

posix-timers-fix-posix-timers-signals-lock-order.patch
  posix-timers: fix posix-timers signals lock order

posix-timers-cpu-clock-support-for-posix-timers.patch
  posix-timers: CPU clock support for POSIX timers

make-itimer_real-per-process.patch
  make ITIMER_REAL per-process

make-itimer_prof-itimer_virtual-per-process.patch
  make ITIMER_PROF, ITIMER_VIRTUAL per-process

make-rlimit_cpu-sigxcpu-per-process.patch
  make RLIMIT_CPU/SIGXCPU per-process

relayfs-doc.patch
  relayfs: doc

relayfs-common-files.patch
  relayfs: common files

relayfs-remove-klog-debugging-channel.patch
  relayfs - remove klog debugging channel

relayfs-locking-lockless-implementation.patch
  relayfs: locking/lockless implementation

relayfs-headers.patch
  relayfs: headers

relayfs-remove-klog-debugging-channel-headers.patch
  relayfs - remove klog debugging channel

ltt-core-implementation.patch
  ltt: core implementation

ltt-core-headers.patch
  ltt: core headers

mips-fixed-ltt-build-errors.patch
  mips: fixed LTT build errors

ltt-kconfig-fix.patch
  ltt kconfig fix

ltt-doesnt-build-on-x86_64.patch
  ltt doesn't build on x86_64

ltt-kernel-events.patch
  ltt: kernel/ events

ltt-kernel-events-tidy.patch
  ltt-kernel-events tidy

ltt-kernel-events-build-fix.patch
  ltt-kernel-events-build-fix

ltt-fs-events.patch
  ltt: fs/ events

ltt-fs-events-tidy.patch
  ltt-fs-events tidy

ltt-ipc-events.patch
  ltt: ipc/ events

ltt-mm-events.patch
  ltt: mm/ events

ltt-net-events.patch
  ltt: net/ events

ltt-architecture-events.patch
  ltt: architecture events

pcmcia-tcic-eleminate-deprecated-check_region.patch
  pcmcia: tcic: eleminate deprecated check_region()

pcmcia-i82365-use-config_pnp-instead-of-__isapnp__.patch
  pcmcia: i82365: use CONFIG_PNP instead of __ISAPNP__

pcmcia-i82092-fix-checking-of-return-value-from-request_region.patch
  pcmcia: i82092: fix checking of return value from request_region

pcmcia-socket-acregion-are-unused.patch
  pcmcia: socket->{a,c}region are unused

pcmcia-use-unsigned-long-for-io-port-address.patch
  pcmcia: use unsigned long for IO port address

nfs-fix_vfsflock.patch
  VFS: Fix structure initialization in locks_remove_flock()

nfs-flock.patch
  NFS: Add emulation of BSD flock() in terms of POSIX locks on the server

nfsacl-protocol-extension-for-nfsv3.patch
  NFSACL protocol extension for NFSv3: generalise qsort()

nfsacl-return-enosys-for-rpc-programs-that-are-unavailable.patch
  nfsacl: return -ENOSYS for RPC programs that are unavailable

nfsacl-add-missing-eopnotsupp-=-nfs3err_notsupp-mapping-in-nfsd.patch
  nfsacl: add missing -EOPNOTSUPP => NFS3ERR_NOTSUPP mapping in nfsd

nfsacl-allow-multiple-programs-to-listen-on-the-same-port.patch
  nfsacl: allow multiple programs to listen on the same port

nfsacl-allow-multiple-programs-to-share-the-same-transport.patch
  nfsacl: allow multiple programs to share the same transport

nfsacl-lazy-rpc-receive-buffer-allocation.patch
  nfsacl: lazy RPC receive buffer allocation

nfsacl-encode-and-decode-arbitrary-xdr-arrays.patch
  nfsacl: encode and decode arbitrary XDR arrays

nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix.patch
  nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix

nfsacl-add-noacl-nfs-mount-option.patch
  nfsacl: add noacl nfs mount option

nfsacl-infrastructure-and-server-side-of-nfsacl.patch
  nfsacl: infrastructure and server side of nfsacl

nfsacl-solaris-nfsacl-workaround.patch
  nfsacl: solaris nfsacl workaround

nfsacl-client-side-of-nfsacl.patch
  nfsacl: client side of nfsacl

nfsacl-acl-umask-handling-workaround-in-nfs-client.patch
  nfsacl: aCL umask handling workaround in nfs client

nfsacl-cache-acls-on-the-nfs-client-side.patch
  nfsacl: cache acls on the nfs client side

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
  kgdb-is-incompatible-with-kprobes
  kgdb-ga-build-fix
  kgdb-ga-fixes

kgdb-kill-off-highmem_start_page.patch
  kgdb: kill off highmem_start_page

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

dev-mem-restriction-patch-allow-reads.patch
  dev-mem-restriction-patch: allow reads

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

perfctr-core.patch
  perfctr: core
  perfctr: remove bogus perfctr_sample_thread() calls

perfctr-i386.patch
  perfctr: i386

perfctr-x86-core-updates.patch
  perfctr x86 core updates

perfctr-x86-driver-updates.patch
  perfctr x86 driver updates

perfctr-x86-driver-cleanup.patch
  perfctr: x86 driver cleanup

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86-update-2.patch
  perfctr x86 update 2

perfctr-x86_64.patch
  perfctr: x86_64

perfctr-x86_64-core-updates.patch
  perfctr x86_64 core updates

perfctr-ppc.patch
  perfctr: PowerPC

perfctr-ppc32-driver-update.patch
  perfctr: ppc32 driver update

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

perfctr-ppc32-update.patch
  perfctr ppc32 update

perfctr-ppc32-update-2.patch
  perfctr ppc32 update

perfctr-virtualised-counters.patch
  perfctr: virtualised counters

perfctr-remap_page_range-fix.patch

virtual-perfctr-illegal-sleep.patch
  virtual perfctr illegal sleep

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr: Kconfig-related updates

perfctr-virtual-updates.patch
  perfctr virtual updates

perfctr-virtual-cleanup.patch
  perfctr: virtual cleanup

perfctr-ppc32-preliminary-interrupt-support.patch
  perfctr ppc32 preliminary interrupt support

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr: reduce stack usage

perfctr-interrupt-support-kconfig-fix.patch
  perfctr interrupt_support Kconfig fix

perfctr-low-level-documentation.patch
  perfctr low-level documentation

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance: driver updates

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

perfctr-api-changes-first-step.patch
  perfctr API changes: first step

perfctr-virtual-update.patch
  perfctr virtual update

perfctr-x86-64-ia32-emulation-fix.patch
  perfctr x86-64 ia32 emulation fix

perfctr-sysfs-update-1-4-core.patch
  perfctr sysfs update: core

perfctr-sysfs-update.patch
  Perfctr sysfs update

perfctr-sysfs-update-2-4-x86.patch
  perfctr sysfs update: x86

perfctr-sysfs-update-3-4-x86-64.patch
  perfctr sysfs update: x86-64
  perfctr: syscall numbers in x86-64 ia32-emulation
  perfctr x86_64 native syscall numbers fix

perfctr-sysfs-update-4-4-ppc32.patch
  perfctr sysfs update: ppc32

sched-fix-preemption-race-core-i386.patch
  sched: fix preemption race (Core/i386)

sched-make-use-of-preempt_schedule_irq-ppc.patch
  sched: make use of preempt_schedule_irq() (PPC)

sched-make-use-of-preempt_schedule_irq-arm.patch
  sched: make use of preempt_schedule_irq (ARM)

sched-isochronous-class-for-unprivileged-soft-rt-scheduling.patch
  sched: Isochronous class for unprivileged soft rt scheduling

sched-account-rt_tasks-as-iso_ticks.patch
  sched: account rt_tasks as iso_ticks

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

videotext-ioctls-changed-to-use-_io-macros.patch
  videotext: ioctls changed to use _IO macros

video-arv-remove-casts.patch
  video/arv: remove casts

video-w9966-remove-casts.patch
  video/w9966: remove casts

video-zr36120-remove-casts.patch
  video/zr36120: remove casts

v4l-video-buf-update.patch
  v4l: video-buf update

v4l2-tuner-api-update.patch
  v4l2 tuner api update

v4l-tuner-update.patch
  v4l: tuner update

v4l-add-tveeprom-module.patch
  v4l: add tveeprom module.

v4l-tvaudio-update.patch
  v4l: tvaudio update

v4l-bttv-ir-input-driver-update.patch
  v4l: bttv IR input driver update

v4l-bttv-update.patch
  v4l: bttv update

v4l-saa7134-module.patch
  v4l: saa7134 module

allow-modular-ide-pnp.patch
  allow modular ide-pnp

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm

ppc64-fix-cpu-hotplug.patch
  ppc64: fix hotplug cpu

serialize-access-to-ide-devices.patch
  serialize access to ide devices

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

numa-policies-for-file-mappings-mpol_mf_move-cachefs.patch
  numa-policies-for-file-mappings-mpol_mf_move for cachefs

cachefs-release-search-records-lest-they-return-to-haunt-us.patch
  CacheFS: release search records lest they return to haunt us

fix-64-bit-problems-in-cachefs.patch
  Fix 64-bit problems in cachefs

cachefs-fixed-typos-that-cause-wrong-pointer-to-be-kunmapped.patch
  cachefs: fixed typos that cause wrong pointer to be kunmapped

cachefs-return-the-right-error-upon-invalid-mount.patch
  CacheFS: return the right error upon invalid mount

fix-cachefs-barrier-handling-and-other-kernel-discrepancies.patch
  Fix CacheFS barrier handling and other kernel discrepancies

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

add-page-becoming-writable-notification-fix.patch
  do_wp_page_mk_pte_writable() fix

add-page-becoming-writable-notification-build-fix.patch
  add-page-becoming-writable-notification build fix

provide-a-filesystem-specific-syncable-page-bit.patch
  Provide a filesystem-specific sync'able page bit

provide-a-filesystem-specific-syncable-page-bit-fix.patch
  provide-a-filesystem-specific-syncable-page-bit-fix

provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
  provide-a-filesystem-specific-syncable-page-bit-fix-2

make-afs-use-cachefs.patch
  Make AFS use CacheFS

afs-cachefs-dependency-fix.patch
  afs-cachefs-dependency-fix

split-general-cache-manager-from-cachefs.patch
  Split general cache manager from CacheFS

turn-cachefs-into-a-cache-backend.patch
  Turn CacheFS into a cache backend

rework-the-cachefs-documentation-to-reflect-fs-cache-split.patch
  Rework the CacheFS documentation to reflect FS-Cache split

update-afs-client-to-reflect-cachefs-split.patch
  Update AFS client to reflect CacheFS split

x86-rename-apic_mode_exint.patch
  kexec: x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  kexec: x86: local apic fix

x86_64-e820-64bit.patch
  kexec: x86_64: e820 64bit fix

x86-i8259-shutdown.patch
  kexec: x86: i8259 shutdown: disable interrupts

x86_64-i8259-shutdown.patch
  kexec: x86_64: add i8259 shutdown method

x86-apic-virtwire-on-shutdown.patch
  kexec: x86: resture apic virtual wire mode on shutdown

x86_64-apic-virtwire-on-shutdown.patch
  kexec: x86_64: restore apic virtual wire mode on shutdown

vmlinux-fix-physical-addrs.patch
  kexec: vmlinux: fix physical addresses

x86-vmlinux-fix-physical-addrs.patch
  kexec: x86: vmlinux: fix physical addresses

x86_64-vmlinux-fix-physical-addrs.patch
  kexec: x86_64: vmlinux: fix physical addresses

x86_64-entry64.patch
  kexec: x86_64: add 64-bit entry

x86-config-kernel-start.patch
  kexec: x86: add CONFIG_PYSICAL_START

x86_64-config-kernel-start.patch
  kexec: x86_64: add CONFIG_PHYSICAL_START

kexec-kexec-generic.patch
  kexec: add kexec syscalls

x86-machine_shutdown.patch
  kexec: x86: factor out apic shutdown code

x86-kexec.patch
  kexec: x86 kexec core

x86-crashkernel.patch
  crashdump: x86 crashkernel option

x86_64-machine_shutdown.patch
  kexec: x86_64: factor out apic shutdown code

x86_64-kexec.patch
  kexec: x86_64 kexec implementation

x86_64-crashkernel.patch
  crashdump: x86_64: crashkernel option

kexec-ppc-support.patch
  kexec: kexec ppc support

x86-crash_shutdown-nmi-shootdown.patch
  crashdump: x86: add NMI handler to capture other CPUs

x86-crash_shutdown-snapshot-registers.patch
  kexec: x86: snapshot registers during crash shutdown

x86-crash_shutdown-apic-shutdown.patch
  kexec: x86 shutdown APICs during crash_shutdown

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-elf-format-dump-file-access.patch
  crashdump: elf format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear raw format dump file access

crashdump-reserving-backup-region-for-kexec-based.patch
  crashdump: reserving backup region for kexec based crashdumps.

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-move-cpusets-above-embedded.patch
  move CPUSETS above EMBEDDED

cpusets-fix-cpuset_get_dentry.patch
  cpusets : fix cpuset_get_dentry()

cpusets-fix-race-in-cpuset_add_file.patch
  cpusets: fix race in cpuset_add_file()

cpusets-remove-more-casts.patch
  cpusets: remove more casts

cpusets-make-config_cpusets-the-default-in-sn2_defconfig.patch
  cpusets: make CONFIG_CPUSETS the default in sn2_defconfig

cpusets-document-proc-status-allowed-fields.patch
  cpusets: document proc status allowed fields

cpusets-dont-export-proc_cpuset_operations.patch
  Cpusets - Dont export proc_cpuset_operations

cpusets-display-allowed-masks-in-proc-status.patch
  cpusets: display allowed masks in proc status

cpusets-simplify-cpus_allowed-setting-in-attach.patch
  cpusets: simplify cpus_allowed setting in attach

cpusets-remove-useless-validation-check.patch
  cpusets: remove useless validation check

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

cpusets-interoperate-with-hotplug-online-maps.patch
  cpusets: interoperate with hotplug online maps

cpusets-alternative-fix-for-possible-race-in.patch
  cpusets: alternative fix for possible race in  cpuset_tasks_read()

cpusets-remove-casts.patch
  cpusets: remove void* typecasts

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

reiser4-recover-read-performance.patch
  reiser4: recover read performance

reiser4-export-find_get_pages_tag.patch
  reiser4-export-find_get_pages_tag

reiser4-add-missing-context.patch

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

generic-serial-cli-conversion.patch
  generic-serial cli() conversion

specialix-io8-cli-conversion.patch
  Specialix/IO8 cli() conversion

sx-cli-conversion.patch
  SX cli() conversion

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again.patch
  make acpi_bus_register_driver() consistent with pci_register_driver()

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()
  make cancel_rearming_delayed_workqueue static

ipvs-deadlock-fix.patch
  ipvs deadlock fix

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

radeonfb-set-accelerator-id.patch
  radeonfb: Set accelerator id

vesafb-change-return-error-id.patch
  vesafb: Change return error id

intelfb-workaround-for-830m.patch
  intelfb: Workaround for 830M

fbcon-save-blank-state-last.patch
  fbcon: Save blank state last

backlight-fix-compile-error-if-config_fb-is-unset.patch
  backlight: Fix compile error if CONFIG_FB is unset

matroxfb-fb_matrox_g-kconfig-changes.patch
  matroxfb: FB_MATROX_G Kconfig changes

raid5-overlapping-read-hack.patch
  raid5 overlapping read hack

include-type-information-as-module-info-where-possible.patch
  Include type information as module info where possible

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

post-halloween-doc.patch
  post halloween doc

fix-architecture-names-in-hugetlbpagetxt.patch
  fix architecture names in hugetlbpage.txt

periodically-scan-redzone-entries-and-slab-control-structures.patch
  periodically scan redzone entries and slab control structures

fuse-maintainers-kconfig-and-makefile-changes.patch
  Subject: [PATCH 1/11] FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  Subject: [PATCH 2/11] FUSE - core

fuse-device-functions.patch
  Subject: [PATCH 3/11] FUSE - device functions

fuse-fix-llseek-on-device.patch
  FUSE: fix llseek on device

fuse-make-two-functions-static.patch
  fuse: make two functions static

fuse-fix-variable-with-confusing-name.patch
  fuse: fix variable with confusing name

fuse-read-only-operations.patch
  Subject: [PATCH 4/11] FUSE - read-only operations

fuse-read-write-operations.patch
  Subject: [PATCH 5/11] FUSE - read-write operations

fuse-file-operations.patch
  Subject: [PATCH 6/11] FUSE - file operations

fuse-mount-options.patch
  Subject: [PATCH 7/11] FUSE - mount options

fuse-dont-check-against-zero-fsuid.patch
  fuse: don't check against zero fsuid

fuse-remove-mount_max-and-user_allow_other-module-parameters.patch
  fuse: remove mount_max and user_allow_other module parameters

fuse-extended-attribute-operations.patch
  Subject: [PATCH 8/11] FUSE - extended attribute operations

fuse-readpages-operation.patch
  Subject: [PATCH 9/11] FUSE - readpages operation

fuse-nfs-export.patch
  Subject: [PATCH 10/11] FUSE - NFS export

fuse-direct-i-o.patch
  Subject: [PATCH 11/11] FUSE - direct I/O

fuse-transfer-readdir-data-through-device.patch
  fuse: transfer readdir data through device

ieee1394-adds-a-disable_irm-option-to-ieee1394ko.patch
  ieee1394: add a disable_irm option to ieee1394.ko

cryptoapi-prepare-for-processing-multiple-buffers-at.patch
  CryptoAPI: prepare for processing multiple buffers at a time

cryptoapi-update-padlock-to-process-multiple-blocks-at.patch
  CryptoAPI: Update PadLock to process multiple blocks at  once

update-email-address-of-andrea-arcangeli.patch
  update email address of Andrea Arcangeli

compile-error-blackbird_load_firmware.patch
  blackbird_load_firmware compile fix

i386-x86_64-apicc-make-two-functions-static.patch
  i386/x86_64 apic.c: make two functions static

i386-cyrixc-make-a-function-static.patch
  i386 cyrix.c: make a function static

mtrr-some-cleanups.patch
  mtrr: some cleanups

i386-cpu-commonc-some-cleanups.patch
  i386 cpu/common.c: some cleanups

i386-cpuidc-make-two-functions-static.patch
  i386 cpuid.c: make two functions static

i386-efic-make-some-code-static.patch
  i386 efi.c: make some code static

i386-x86_64-io_apicc-misc-cleanups.patch
  i386/x86_64 io_apic.c: misc cleanups

i386-mpparsec-make-mp_processor_info-static.patch
  i386 mpparse.c: make MP_processor_info static

i386-x86_64-msrc-make-two-functions-static.patch
  i386/x86_64 msr.c: make two functions static

3w-abcdh-tw_device_extension-remove-an-unused-filed.patch
  3w-abcd.h: TW_Device_Extension: remove an unused field

hpet-make-some-code-static.patch
  hpet: make some code static

26-patch-i386-trapsc-make-a-function-static.patch
  i386 traps.c: make a function static

i386-semaphorec-make-4-functions-static.patch
  i386 semaphore.c: make 4 functions static

i386-rebootc-cleanups.patch
  i386: reboot.c cleanups

kill-aux_device_present.patch
  kill aux_device_present

i386-setupc-make-4-variables-static.patch
  i386 setup.c: make 4 variables static

mostly-i386-mm-cleanup.patch
  (mostly i386) mm cleanup

scsi-megaraid_mmc-make-some-code-static.patch
  SCSI megaraid_mm.c: make some code static

update-email-address-of-benjamin-lahaise.patch
  Update email address of Benjamin LaHaise

add-map_populate-sys_remap_file_pages-support-to-xfs.patch
  add MAP_POPULATE/sys_remap_file_pages support to XFS

update-email-address-of-philip-blundell.patch
  Update email address of Philip Blundell

mm-filemapc-make-a-function-static.patch
  mm/filemap.c: make a function static

kernel-acctc-make-a-function-static.patch
  kernel/acct.c: make a function static

kernel-auditc-make-some-functions-static.patch
  kernel/audit.c: make some functions static

kernel-capabilityc-make-a-spinlock-static.patch
  kernel/capability.c: make a spinlock static

mm-thrashc-make-a-variable-static.patch
  mm/thrash.c: make a variable static

lib-kernel_lockc-make-kernel_sem-static.patch
  lib/kernel_lock.c: make kernel_sem static

saa7146_vv_ksymsc-remove-two-unused-export_symbol_gpls.patch
  saa7146_vv_ksyms.c: remove two unused EXPORT_SYMBOL_GPL's

fix-placement-of-static-inline-in-nfsdh.patch
  fix placement of static inline in nfsd.h

drivers-block-umemc-make-two-functions-static.patch
  drivers/block/umem.c: make two functions static

drivers-block-xdc-make-a-variable-static.patch
  drivers/block/xd.c: make a variable static

kernel-configsc-make-a-variable-static.patch
  kernel/configs.c: make a variable static

kernel-forkc-make-mm_cachep-static.patch
  kernel/fork.c: make mm_cachep static

kernel-kallsymsc-make-some-code-static.patch
  kernel/kallsyms.c: make some code static

mm-page-writebackc-remove-an-unused-function.patch
  mm/page-writeback.c: remove an unused function

mm-shmemc-make-a-struct-static.patch
  mm/shmem.c: make a struct static

misc-isapnp-cleanups.patch
  misc ISAPNP cleanups

some-pnp-cleanups.patch
  some PNP cleanups

if-0-cx88_risc_disasm.patch
  #if 0 cx88_risc_disasm

make-loglevels-in-init-mainc-a-little-more-sane.patch
  Make loglevels in init/main.c a little more sane.

isicom-use-null-for-pointer.patch
  sparse: use NULL for pointer

remove-bouncing-email-address-of-hennus-bergman.patch
  remove bouncing email address of Hennus Bergman

cirrusfbc-make-some-code-static.patch
  cirrusfb.c: make some code static

matroxfb_basec-make-some-code-static.patch
  matroxfb_base.c: make some code static

asiliantfbc-make-some-code-static.patch
  asiliantfb.c: make some code static

i386-apic-kconfig-cleanups.patch
  i386 APIC Kconfig cleanups

security-seclvlc-make-some-code-static.patch
  security/seclvl.c: make some code static

drivers-block-elevatorc-make-two-functions-static.patch
  drivers/block/elevator.c: make two functions static

drivers-block-rdc-make-two-variables-static.patch
  drivers/block/rd.c: make two variables static

loopc-make-two-functions-static.patch
  loop.c: make two functions static

remove-bouncing-email-address-of-thomas-hood.patch
  remove bouncing email address of Thomas Hood

fs-adfs-dir_fc-remove-an-unused-function.patch
  fs/adfs/dir_f.c: remove an unused function

drivers-char-moxac-if-0-an-unused-function.patch
  drivers/char/moxa.c: #if 0 an unused function



