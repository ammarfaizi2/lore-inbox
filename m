Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263360AbUDMFUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 01:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUDMFUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 01:20:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:4527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263360AbUDMFRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 01:17:33 -0400
Date: Mon, 12 Apr 2004 22:17:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mm5
Message-Id: <20040412221717.782a4b97.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm5/


- More CPU scheduler work.  Hopefully this kernel will now address the
  regressions that a few people have noted on certain workloads.  We appear to
  be getting close.

- Various fixes, cleanups and code shrinkages.





Changes since 2.6.5-mm4:


 bk-alsa.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-i2c.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-netdev.patch
 bk-pci.patch
 bk-usb.patch
 bk-agpgart.patch
 bk-cpufreq.patch

 External trees

-x86_64-update.patch
-kconfig-url-fixes.patch
-Lindent-devfs.patch
-system_running-fix.patch
-vt-cleanup.patch
-con_open-speedup.patch
-remove-down_tty_sem.patch
-tty-race-fix-43.patch
-i4l-kernelcapi-rework.patch
-wchan-use-ELF-sections.patch
-wchan-use-ELF-sections-sparc64-fix.patch
-ppc32-altivec-exception-fix.patch
-ppc64-si_addr-fix.patch
-ppc64-hugepage-fix.patch
-ppc64-hugepage-fix-32.patch
-ppc64-alloc_consistent-retval-fixes.patch
-ppc64-Fix-G5-build-with-DART-iommu-support.patch
-disable-VT-on-iSeries-by-default.patch
-ppc64-export-itLpNaca-on-iSeries.patch
-PPC64-iSeries-virtual-ethernet-driver.patch
-ppc64-Allow-hugepages-anywhere-in-low-4GB.patch
-ppc64-move-epow-log-buffer-to-bss.patch
-ppc4xx-memleak-fix.patch
-quota-locking-fixes.patch
-inode-cleanup.patch
-initramfs-search-for-init-orig.patch
-knfsd-01-oops-fix.patch
-knfsd-02-auth-error-return-fix.patch
-knfsd-03-auth_error-formatting-fix.patch
-knfsd-04-remove-name_lookup_h.patch
-knfsd-05-mounted_on_fileid-support.patch
-knfsd-06-UTF8-improvements.patch
-knfsd-07-auth_gss-export.patch
-knfsd-08-gss-integrity.patch
-md-merging-fix.patch
-mq-01-codemove.patch
-mq-02-syscalls.patch
-mq-03-core.patch
-mq-04-linuxext-poll.patch
-mq-05-linuxext-mount.patch
-mq-update-01.patch
-mq-security-fix.patch
-split-netlink_unicast.patch
-mq_notify-via-netlink.patch
-compat_mq.patch
-more-fixups-for-compat_mq.patch
-compat_mq-ppc-fix.patch
-compat_mq-fix.patch
-mq-timespec-checking-fix.patch
-ipmi-updates-3.patch
-move-job-control-stuff-tosignal_struct.patch
-lower-zone-protection-numa-fix.patch
-ext3-fsync-speedup.patch
-ext2-fsync-speedup-2.patch
-jbd-commit-ordered-fix.patch
-jbd-move-locked-buffers.patch
-jbd-iobuf-error-handling-fix.patch
-readv-writev-check-fix.patch
-kerneldoc-handle-attributes.patch
-slab-alignment-rework.patch
-set-mod-waiter-before-calling-stop_machine.patch
-procfs-comment-fixes.patch
-sb_mixer-bounds-checking.patch
-pmdisk-store-handling-fix.patch
-file-operations-fcntl.patch
-sys_time-subtick-correction-fix.patch
-bitmap_parse-fix.patch
-ver_linux-fix.patch
-codingstyle-fix-for-emacs.patch
-document-unused-i386-pte-bits.patch
-docbook-sgml-quotes-fix.patch
-sgml-close-tags.patch
-sch_ingress-help-fix.patch
-i386-irq-cleanup.patch
-firmware-loader-docs-fix.patch
-trivial-patches-in-maintainers.patch
-genksyms-parser-fix.patch
-CONFIG_X86_GENERIC-help-fix.patch
-credits-update.patch
-device-h-duplicate-include.patch
-unmapped-CPU-node-number-fix.patch
-submitting-trivial-patches.patch
-ne2k-pic-build-fix.patch
-doc-changes-update.patch
-drm-put_user-fixes.patch
-export-complete_all.patch
-urandom-scalability-fix.patch
-cpu5wdt-warning-fix.patch
-fget-speedup.patch
-move-__this_module-to-modpost.patch
-modversions-fix.patch
-support-zerobased-floppies.patch
-remove-bitmap-length-limits.patch
-huge-sparse-tmpfs-files.patch
-strip-param-quotes.patch
-summit-irq-count-override.patch
-summit-increase-MAX_MP_BUSSES.patch
-msi-ia64.patch
-msi-ia64-x86_64-fix.patch
-ia32-msi-fixup.patch
-stv0299-unused-var-fix.patch
-selinux-fix-struct-type.patch
-pte_alloc_one-null-pointer-check.patch
-kill-MAKEDEV-scripts.patch
-wavfront-warning-fix.patch
-hysnd-MOD_USE_COUNT-fix.patch
-CONFIG_EMBEDDED-help-fix.patch
-remove-nswap-cnswap.patch
-no-quota-inode-shrinkage.patch
-geode-suspend-on-halt.patch
-O_DIRECT-race-fixes-rollup.patch
-O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
-blockdev-direct-io-speedup.patch
-dio-aio-fixes.patch
-aio-fallback-bio_count-race-fix-2.patch
-rw_swap_page_sync-fix.patch
-radix-tree-tagging.patch
-irq-safe-pagecache-lock.patch
-tag-dirty-pages.patch
-tag-writeback-pages.patch
-stop-using-dirty-pages.patch
-kupdate-function-fix.patch
-stop-using-io-pages.patch
-stop-using-locked-pages.patch
-stop-using-clean-pages.patch
-unslabify-pgds-and-pmds.patch
-slab-stop-using-page-list.patch
-page_alloc-stop-using-page-list.patch
-hugetlb-stop-using-page-list.patch
-pageattr-stop-using-page-list.patch
-readahead-stop-using-page-list.patch
-compound-pages-stop-using-lru.patch
-arm-stop-using-page-list.patch
-m68k-stop-using-page-list.patch
-remove-page-list.patch
-clear_page_dirty_for_io.patch
-block_write_full_page-redirty.patch
-writeback-search-start.patch
-mpage_writepages-latency-fix.patch
-mpage-cleanup.patch
-use-compound-pages-for-hugetlb-only.patch
-fork-vma-order-fix.patch
-mremap-copy_one_pte-fix.patch
-mremap-move_vma-fix.patch
-mremap-vma_relink_file-fix.patch
-mremap-check-map_count.patch
-mremap-rmap-comment-fix.patch
-kswapd-remove-pages-scanned.patch
-laptop-mode-3.patch
-laptop-mode-doc-update.patch
-laptop-mode-control-script-fix.patch
-laptop-mode-noflushd-warning.patch
-laptop-mode-sync-completion.patch
-ext3-commit-default.patch
-tunable-pagefault-readaround.patch
-filemap_nopage-busywait-fix.patch
-acpi-printk-fix.patch
-ia32-4k-stacks.patch
-proc-load-average-fix.patch
-ppc64-NUMA-fix-for-16MB-LMBs.patch
-sparc64-build-fix.patch
-epoll-comment-fixes.patch
-stop_machine-barrier-fixes.patch
-sunrpc-svcsock-drop.patch
-acl-version-mismatch.patch
-v4l-cropcap-ioctl-fix.patch
-v4l-v4l1-compat-fix.patch
-v4l-tuner-fix.patch
-v4l-msp3400-update.patch
-v4l-pv951-remote-support.patch
-v4l-saa7134-update.patch
-v4l-saa7134-update-fix.patch
-v4l-bttv-update.patch
-v4l-doc-update.patch
-v4l-cx88-update.patch
-drivers-base-platform-tpyo-fix.patch
-nfs-readdirplus-overflow-fix.patch
-nfs-32bit-statfs-fix.patch
-nfs-32bit-statfs-fix-warning-fix.patch
-wavefront_synth-unused-var.patch
-tda1004x-unused-var.patch
-pmdisk-needs-asmlinkage.patch
-cycx_drv-warning-fix.patch
-ibmlana-needs-MCA_LEGACY.patch
-rcu_list-documentation.patch
-list-inline-cleanup.patch
-noexec-stack.patch
-ext3-transaction-batching-fix.patch
-reiserfs-nesting-02.patch
-reiserfs-journal-writer.patch
-reiserfs-logging.patch
-reiserfs-jh-2.patch
-reiserfs-end-trans-bkl.patch
-reiserfs-prealloc.patch
-reiserfs-tail-jh.patch
-reiserfs-writepage-ordered-race.patch
-reiserfs-file_write_hole_sd.diff.patch
-reiserfs-laptop-mode.patch
-reiserfs-truncate-leak.patch
-reiserfs-ordered-lat.patch
-reiserfs-dirty-warning.patch
-reiserfs_kfree-warning-fix.patch
-reiserfs-writepage-race-fix.patch
-selinux-ipv6-support.patch
-selinux-remove-duplicate-assignment.patch
-lightweight-auditing-framework.patch
-lightweight-auditing-framework-ipv6-support.patch
-selinux-compute_sid-fixes.patch
-selinux-remove-ratelimit.patch
-mixart-build-fix.patch
-unmap_vmas-latency-improvement.patch
-i386-head_S-cleanups.patch
-intermezzo-leak-fixes.patch
-es1688-define-fix.patch
-load_elf_binary-overflow-detection-fix.patch
-stack-reductions-ide-cd.patch
-stack-reductions-ide.patch
-stack-reductions-isdn.patch
-use-EFLAGS_defines.patch
-h8300-ptrace-fix.patch
-h8300-entry_s-cleanup.patch
-h8300-others.patch
-h8300-support-update.patch
-sh-sci-build-fix.patch
-posix-timers-thread.patch
-v850-bitop-volatiles.patch
-v850-dma-mapping-fix.patch
-m68knommu-dma-mapping.patch
-m68knommu-kernel_thread-fix.patch
-m68knommu-kconfig-cleanup.patch
-m68knommu-comempci-printk-cleanup.patch
-m68knommu-coherent-dma-allocation.patch
-m68knommu-build-dmac.patch
-cleanup-m68knommu-setupc-printk-and-irqreturn_t.patch
-cleanup-m68knommu-trapsc-printk-and-dump_stack.patch
-platform-additions-in-m68knommu-linker-script.patch
-fix-gcc-cpu-define-for-m68knommu-coldfire.patch
-add-senTec-vendor-support-to-m68knommu-Makefile.patch
-m68knommu-faultc-printk-cleanup.patch
-m68knommu-mm-initc-printk-cleanup.patch
-m68knommu-ColdFire-base-DMA-addresses.patch
-m68knommu-timersc-printk-cleanup.patch
-auto-size-dram-on-motorola-5272-coldfire-board.patch
-add-start-code-for-cobra5272-board.patch
-use-irqreturn_t-in-coldfire-5282-setup-code.patch
-add-start-code-for-cobra5282-board.patch
-cleanup-coldfire-5307-ints-code.patch
-use-irqreturn_t-in-coldfire-5307-setup-code.patch
-m68knommu-mm-5307-vectorsc-printk-cleanup.patch
-conditional-romfs-copy-for-5407-cleopatra-board.patch
-68360-commprocc-printk-cleanup.patch
-68360-configc-printk-cleanup.patch
-68ez328-configc-printk-cleanup.patch
-use-irqreturn_t-in-coldfire-5407-setup-code.patch
-use-irqreturn_t-in-motorola-68328-setup-code.patch
-cleanup-motorola-68328-ints-code.patch
-cleanup-motorola-68360-ints-code.patch
-mk68knommu-dragonengine-setup-code-printk-cleanup.patch
-cleanup-startup-code-for-68ez328-dragonengine-board.patch
-68ez328-ucdimm-setup-code-printk-cleanup.patch
-add-support-for-64mhz-clock-for-coldfire-boards.patch
-missing-n-in-timer_tscc.patch
-hugetlb-consolidation.patch
-hugetlb-consolidation-highmem-fix.patch
-s390-1-12-core-s390.patch
-s390-2-12-common-i-o-layer.patch
-s390-3-12-tape-driver-fixes.patch
-s390-4-12-dasd-driver-fix.patch
-s390-5-12-network-driver-fixes.patch
-s390-6-12-dcss-block-driver-fix.patch
-s390-7-12-zfcp-fixes-without-kfree-hack.patch
-s390-8-12-zfcp-log-messages-part-1.patch
-s390-9-12-zfcp-log-messages-part-2.patch
-s390-10-12-crypto-device-driver-part-1.patch
-s390-11-12-crypto-device-driver-part-2.patch
-s390-12-12-rewritten-qeth-driver.patch
-queue-congestion-callout.patch
-queue-congestion-dm-implementation.patch
-dm-remove-__dm_request.patch
-per-backing_dev-unplugging.patch
-swap_writepage-BIO_RW_SYNC.patch
-md-unplug-update.patch
-correct-unplugs-on-nr_queued.patch
-correct-unplugs-on-nr_queued-remove-warnings.patch
-cfq-4.patch
-rmap-1-linux-rmaph.patch
-rmap-2-anon-and-swapcache.patch
-rw_swap_page_sync-fixes.patch
-rmap-3-arches--mapping_mapped.patch
-rename-page_to_nodenum.patch
-alpha-fix-unaligned-stxncpy-again.patch
-cyclades-works-on-smp.patch
-dnotify_parent-speedup.patch
-floppy_format_265.patch
-jbd-do_get_write_access-lock-contention-reduction.patch
-jbd-b_transaction-zeroing-cleanup.patch
-probe_roms-01-move-stuff.patch
-probe_roms-02-fixes.patch
-swsusp-update.patch
-swsusp-highmem-fixes.patch
-swsusp-dont-start-stopped-processes.patch
-mandocs_params-007.patch
-get_user_pages-shortcut.patch
-isicom-jiffies-fix.patch
-isicom-unused-vars.patch
-parport-dependency-fix.patch
-dvd-dependency-fix.patch
-isicom-error-path-fix.patch
-QD65xx-io-ports-fix.patch
-parportbook-build-fix.patch
-saa7134-asus-tv-fm-inputs.patch
-pdaudiocf-build-fix.patch
-dont-offer-gen_rtc-on-ia64.patch
-remove_concat_FUNCTION_arch.patch
-remove_concat_FUNCTION_drivers.patch
-remove_concat_FUNCTION_include.patch
-remove_concat_FUNCTION_sound.patch
-raid56-masking-fix.patch
-ibmasm-dependency-fix.patch
-bitop-comment-fix.patch
-ext2-alternate-sb-mount-fix.patch
-ext3-alternate-sb-mount-fix.patch
-zoran-overflow-fix.patch
-mdacon-warning-fix.patch
-do_fork-error-path-memory-leak.patch
-Fix-More-Problems-Introduced-By-Module-Structure-Added-in-modpostc.patch
-Rename-bitmap_clear-to-bitmap_zero-remove-CLEAR_BITMAP.patch
-i2c-dev-warning-fixes.patch
-policydb-printk-warnings.patch
-applicom-warnings.patch
-tpqic02-warnings.patch
-acct-oops-fix.patch
-framebuffer-bugfix.patch
-updated-fbmem-patch.patch
-make-%docs-depend-on-scripts_basic.patch
-kbuild-cleaning-in-three-steps.patch
-kbuild-external-module-support.patch
-parport-no-procfs-warning-fix.patch
-CONFIG_SYSFS.patch
-jbd-BH_Revoke-cleanup.patch
-cciss-proc-fix.patch
-cciss_scsi-warning.patch
-pmdisk-is-x86-only.patch
-nfs-01-prepare_nfspage.patch
-nfs-02-small_rsize.patch
-nfs-02-small_rsize-warning-fixes.patch
-nfs-03-small_wsize.patch
-nfs-03-small_wsize-warning-fixes.patch
-nfs-04-congestion.patch
-nfs-05-unrace.patch
-nfs-06-rpc_throttle.patch
-nfs-07-rpc_fixes.patch
-nfs-08-short_rw.patch
-nfsv4-updates.patch
-Oprofile-ARM-XScale-PMU-driver.patch

 Merged

+rmap-4-flush_dcache-revisited.patch
+rmap-5-swap_unplug-page.patch
+rmap-6-nonlinear-truncation.patch

 objrmap preparatory work

+sched-balance-context.patch
+sched-less-idle.patch
+schedstats.patch

 CPU scheduler work

+compute-creds-race-fix-fix-fix.patch

 Fix compute-creds-race-fix.patch

+call_usermodehelper_async-always.patch

 Always use call_usermodehelper_async() for call_usermodehelper(wait=0)

+binfmt_misc-remove-attribute_unused.patch

 Remove inexplicable __attribute__((unused))

+jbd-copyout-fix.patch

 Fix improbable ext3 data corruption.

+ext3-add_nondir-d_instantiate-fix.patch

 Fix error handling in ext3 directory entry instantiation

+vga16fb-mapping-fix.patch

 Fix this driver for ARM (at least)

+rwsem-scale.patch

 Slightly improved scalability of rwsems

+uninline-put_page.patch
+uninline-seqfns.patch
+uninline-copy_user.patch

 Uninline some things

+slab-panic.patch

 Code consolidation

+pty-allocation-first-fit.patch

 Go back to first-fit for the tty minor number allocation.

+tmscsim-ulong-io_port.patch

 Fix a warning

+change-addr-type-to-reduce-casting-in-coldfire-serial-driver.patch
+fixes-to-the-coldfire-serial-driver.patch
+fixes-to-the-68328-dragonball-serial-driver.patch

 m68k updates

+dm-fix-64-32-bit-ioctl-problems.patch
+dm-check-the-uptodate-flag-in-sub-bios.patch
+dm-handle-interrupts-within-suspend.patch
+dm-use-wake_up-rather-than-wake_up_interruptible.patch
+dm-log-an-error-if-the-target-has-unknown-target-type.patch
+dm-correctly-align-the-dm_target_spec-structures.patch
+dm-clarify-a-comment.patch
+dm-retrieve_status-prevent-overrunning-the-ioctl-buffer.patch
+dm-use-an-emit-macro.patch

 devicemapper fixes

+wrong-return-value-in-hfs_fill_super.patch

 Fix handling of mount-time errors in HFS 

+mips-build-fix.patch
+mips-statfs-fix.patch

 MIPS compile fixes

+trivial-pcmcia-rsrc_mgrc-warning-fix.patch

 PCMCIA warning fix

+compile-fix-for-macserial.patch

 macserial compile fix




All 215 patches:


linus.patch

mc.patch
  Add -mcN to EXTRAVERSION

rmap-4-flush_dcache-revisited.patch
  rmap 4 flush_dcache revisited

rmap-5-swap_unplug-page.patch
  rmap 6 swap_unplug page

rmap-6-nonlinear-truncation.patch
  rmap 6 nonlinear truncation

bk-alsa.patch

bk-driver-core.patch

bk-drm.patch

bk-i2c.patch

bk-ieee1394.patch

bk-input.patch

bk-netdev.patch

bk-pci.patch

bk-usb.patch

bk-agpgart.patch

bk-cpufreq.patch

mm.patch
  add -mmN to EXTRAVERSION

r8169-warning-fix.patch
  r8169 warning fix

netpoll-early-arp-handling.patch
  netpoll early ARP handling

netpoll-transmit-busy-bugfix.patch
  netpoll transmit busy bugfix

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdb-ga-recent-gcc-fix.patch
  kgdb: fix for recent gcc

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-configuration-logic-fix.patch
  kgdboe: fix configuration of MAC address

kgdboe-configuration-logic-fix-fix.patch

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

kgdb-x86_64-warning-fixes.patch
  kgdb-x86_64-warning-fixes

wchan-use-ELF-sections-kgdb-fix.patch
  wchan-use-ELF-sections-kgdb-fix

kgdb-THREAD_SIZE-fixes.patch
  THREAD_SIZE fixes for kgdb

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-reloc_hide.patch

ext3-journalled-quotas.patch
  Journalled quota patch

ext3-journalled-quotas-export.patch
  ext3-journalled-quotas export

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

local_bh_enable-warning-fix.patch

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c

sched-run_list-cleanup.patch
  small scheduler cleanup

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

sched-find-busiest-fix.patch
  sched-find-busiest-fix

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask
  p4-clockmod sibling_map fix
  p4-clockmod: handle more than two siblings

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT
  sched: Fix CONFIG_SMT oops on UP
  sched: fix SMT + NUMA bug
  Change arch_init_sched_domains to use cpu_online_map
  Fix build with NR_CPUS > BITS_PER_LONG

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-domain-debugging.patch
  sched_domain debugging

sched-domain-balancing-improvements.patch
  scheduler domain balancing improvements

sched-group-power.patch
  sched-group-power
  sched-group-power warning fixes

sched-domains-use-cpu_possible_map.patch
  sched_domains: use cpu_possible_map

sched-smt-nice-handling.patch
  sched: SMT niceness handling

sched-local-load.patch
  sched: add local load metrics

process-migration-speedup.patch
  Reduce TLB flushing during process migration

sched-trivial.patch
  sched: trivial fixes, cleanups

sched-misc-fixes.patch
  sched: misc fixes

sched-wakebalance-fixes.patch
  sched: wakeup balancing fixes

sched-imbalance-fix.patch
  sched: fix imbalance calculations

sched-altix-tune1.patch
  sched: altix tuning

sched-fix-activelb.patch
  sched: oops fix

ppc64-sched-domain-support.patch
  ppc64: sched-domain support

sched-domain-setup-lock.patch
  sched: fix setup races

ppc64-sched_domains-fix.patch
  ppc64-sched_domains-fix

sched-domain-setup-lock-ppc64-fix.patch

sched-minor-cleanups.patch
  sched: minor cleanups

sched-inline-removals.patch
  sched: uninlinings

sched-move-cold-task.patch
  sched: move cold task in mysteriouis ways

sched-migrate-shortcut.patch
  sched: add migration shortcut

sched-more-sync-wakeups.patch
  sched: extend sync wakeups

sched-boot-fix.patch
  sched: lock cpu_attach_domain for hotplug

sched-cleanups.patch
  sched: cleanups

sched-damp-passive-balance.patch
  sched: passive balancing damping

sched-cpu-load-cleanup.patch
  sched: cpu load management cleanup

sched-balance-context.patch
  sched: balance-on-clone

sched-less-idle.patch
  sched: reduce idle time

schedstats.patch
  sched: scheduler statistics

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

siimage-update.patch
  ide: update for siimage driver

ipmi-socket-interface.patch
  IPMI: socket interface

nmi_watchdog-local-apic-fix.patch
  Fix nmi_watchdog=2 and P4 HT

nmi-1-hz-2.patch
  reduce NMI watchdog call frequency with local APIC.

pcmcia-netdev-ordering-fixes.patch
  PCMCIA netdevice ordering issues

3ware-update.patch
  3ware driver update

devinet-ctl_table-fix.patch
  devinet_ctl_table[] null termination

idr-extra-features.patch
  idr.c: extra features enhancements

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

jgarzik-warnings.patch

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

signal-race-fix.patch
  signal handling race fix

signal-race-fix-ia64.patch
  signal-race-fix: ia64

signal-race-fix-s390.patch
  signal-race fixes for s390

signal-race-fix-x86_64.patch
  signal-race-fixes: x86-64 support

signal-race-fixes-ppc.patch
  signal-race fixes for ppc32 and ppc64

warn-on-mdelay-in-irq-handlers.patch
  Warn on mdelay() in irq handlers

stack-reductions-nfsread.patch
  stack reductions: nfs read

stack-reductions-nfsroot.patch
  stack reductions: nfs root

x86_64-probe_roms-c89.patch
  x86_64: probe_roms()

speed-up-sata.patch
  speed up SATA

yenta-TI-irq-routing-fix.patch
  yenta: interrupt routing for TI briges

advansys-fix.patch
  advansys check_region() fix

pnp-updates.patch
  PnP Updates for 2.6.5-rc3-mm4 (testing)

aic7xxx-unload-fix.patch
  aic7xxx: fix oops whe hardware is not present
  aic7xxx-unload-fix-fix

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

nfs-O_DIRECT-fixes.patch
  NFS: O_DIRECT fixes

aic7xxx-swsusp-support.patch
  support swsusp for aic7xxx

reiserfs-commit-default.patch
  Add "commit=0" to reiserfs

xfs-laptop-mode.patch
  Laptop mode support for XFS

xfs-laptop-mode-syncd-synchronization.patch
  Synchronize XFS sync daemon with laptop mode syncs.

vmscan-less-sleepiness.patch
  vmscan: Fix up the determination of when to throttle

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

reslabify-pgds-and-pmds-2.patch

jbd-journal_dirty_metadata-locking-speedup.patch
  jbd: journal_dirty_metadata locking speedup

0-autofs4-2.6.0-signal-20040405.patch
  autofs: dnotify + autofs may create signal/restart syscall loop

1-autofs4-2.6.4-cleanup-20040405.patch
  autofs: printk cleanups

2-autofs4-2.6.4-fill_super-20040405.patch

3-autofs4-2.6.0-bkl-20040405.patch
  autofs: locking rework

4-autofs4-2.6.0-expire-20040405.patch
  autofs: expiry refcount fixes

5-autofs4-2.6.0-readdir-20040405.patch
  autofs: readdir fixes

6-autofs4-2.6.0-may_umount-20040405.patch
  autofs: add ioctl to query unmountability

7-autofs4-2.6.0-extra-20040405.patch
  autofs: readdir futureproofing

cciss-logical-device-queues.patch
  cciss: per logical device queues

numa-api-x86_64.patch
  numa api: -64 support

numa-api-bitmap-fix.patch
  numa api: Bitmap bugfix

numa-api-i386.patch
  numa api: Add i386 support

numa-api-ia64.patch
  numa api: Add IA64 support

numa-api-core.patch
  numa api: Core NUMA API code

numa-api-core-tweaks.patch
  numa-api-core-tweaks

numa-api-core-bitmap_clear-fixes.patch
  numa-api-core bitmap_clear fixes

numa-api-vma-policy-hooks.patch
  numa api: Add VMA hooks for policy

numa-api-vma-policy-hooks-fix.patch
  numa-api-vma-policy-hooks fix

numa-api-shared-memory-support.patch
  numa api: Add shared memory support

numa-api-shared-memory-support-tweaks.patch
  numa-api-shared-memory-support-tweaks

numa-api-statistics.patch
  numa api: Add statistics

numa-api-anon-memory-policy.patch
  numa api: Add policy support to anonymous  memory

sk98lin-buggy-vpd-workaround.patch
  net/sk98lin: correct buggy VPD in ASUS MB
  skvpd-build-fix

kNFSdv4-4-of-10-nfsd4_readdir-fixes.patch
  kNFSdv4: nfsd4_readdir fixes

nfsd4_readdir-build-fix.patch
  nfsd4_readdir build fix

kNFSdv4-5-of-10-Fix-bad-error-returm-from-svcauth_gss_accept.patch
  kNFSdv4: Fix bad error returm from svcauth_gss_accept

kNFSdv4-6-of-10-Keep-state-to-allow-replays-for-close-to-work.patch
  kNFSdv4: Keep state to allow replays for 'close' to work.

nfsd_list_cleanup.patch
  Subject: Re: [PATCH] kNFSdv4 - 6 of 10 - Keep state to allow replays for 'close' to work.

kNFSdv4-7-of-10-Allow-locku-replays-aswell.patch
  kNFSdv4: Allow locku replays aswell

kNFSdv4-8-of-10-Improve-how-locking-copes-with-replays.patch
  kNFSdv4: Improve how locking copes with replays

kNFSdv4-9-of-10-Set-credentials-properly-when-puutrootfh-is-used.patch
  kNFSdv4: Set credentials properly when puutrootfh is used

kNFSdv4-10-of-10-Implement-server-side-reboot-recovery-mostly.patch
  kNFSdv4: Implement server-side reboot recovery (mostly)

unplug-can-sleep.patch
  unplug functions can sleep

fix-load_elf_binary-error-path-on-unshare_files-error.patch
  fix load_elf_binary error path on unshare_files error

sctp-printk-warnings.patch
  sctp printk warnings

atm-warning-fixes.patch
  atm warning fixes

firestream-warnings.patch
  firestream warnings

cpufreq_userspace-warning.patch
  cpufreq_userspace warning

compute-creds-race-fix.patch
  compute_creds race

compute-creds-race-fix-fix.patch
  compute-creds-race-fix-fix

compute-creds-race-fix-fix-fix.patch
  fix must_not_trace_exec() even more

rndis-fix.patch
  usb/gadget/rndis.c fix

sir_dev-warnings.patch
  sir_dev.c warnings

donauboe-ptr-fix.patch
  donauboe.c 32-bit pointer fix

strip-warnings.patch
  drivers/net/wireless/strip.c warnings

pc300_drv-warnings.patch
  pc300_drv-warnings

strip-warnings-2.patch
  strip.c warnings

sk_mca-multicast-fix.patch
  sk_mca multicast fix

kstrdup-and-friends.patch
  add string replication functions

call_usermodehelper_async.patch
  Add call_usermodehelper_async

call_usermodehelper_async-always.patch
  always use call_usermodehelper_async

get_files_struct.patch
  get_files_struct cleanup

fix-acer-travelmate-360-interrupt-routing.patch
  fix Acer TravelMate 360 interrupt routing

shrink-hash-sizes-on-small-machines-take-2.patch
  shrink VFS hash sizes on small machines

binfmt_misc-remove-attribute_unused.patch
  binfmt_misc: remove attribute(unused)

jbd-copyout-fix.patch
  jbd copyout fix

ext3-add_nondir-d_instantiate-fix.patch
  ext3-add_nondir-d_instantiate-fix

vga16fb-mapping-fix.patch
  fix vga16fb.c frame buffer bad memory mapping

rwsem-scale.patch
  rwsem scalability improvement

uninline-put_page.patch
  uninline put_page()

uninline-seqfns.patch
  uninline seq_puts() and seq_putc()

uninline-copy_user.patch
  uninline copy_to_user() and copy_from_user()

slab-panic.patch
  slab: consolidate panic code

pty-allocation-first-fit.patch

tmscsim-ulong-io_port.patch
  Fix tmscsim on amd64

change-addr-type-to-reduce-casting-in-coldfire-serial-driver.patch
  m68knommu: change addr type to reduce casting in ColdFire serial driver

fixes-to-the-coldfire-serial-driver.patch
  m68knommu: fixes to the ColdFire serial driver

fixes-to-the-68328-dragonball-serial-driver.patch
  m68knommu: fixes to the 68328 DragonBall serial driver

dm-fix-64-32-bit-ioctl-problems.patch
  dm: Fix 64/32 bit ioctl problems.

dm-check-the-uptodate-flag-in-sub-bios.patch
  dm: Check the uptodate flag in sub-bios to see if there was an error.

dm-handle-interrupts-within-suspend.patch
  dm: Handle interrupts within suspend.

dm-use-wake_up-rather-than-wake_up_interruptible.patch
  dm: Use wake_up() rather than wake_up_interruptible()

dm-log-an-error-if-the-target-has-unknown-target-type.patch
  dm: Log an error if the target has unknown target type, or zero length.

dm-correctly-align-the-dm_target_spec-structures.patch
  dm: Correctly align the dm_target_spec structures during retrieve_status().

dm-clarify-a-comment.patch
  dm: fix a comment

dm-retrieve_status-prevent-overrunning-the-ioctl-buffer.patch
  dm: avoid ioctl buffer overrun

dm-use-an-emit-macro.patch
  dm: Use an EMIT macro in the status function.

wrong-return-value-in-hfs_fill_super.patch
  Wrong return value in hfs_fill_super

mips-build-fix.patch
  From: Samium Gromoff <deepfire@sic-elvis.zel.ru>
  Subject: [2.6.5][MIPS] oneliners somehow not made it into mainline [1/3]

mips-statfs-fix.patch
  From: Samium Gromoff <deepfire@sic-elvis.zel.ru>
  Subject: [2.6.5][MIPS] oneliners somehow not made it into mainline [2/3]

trivial-pcmcia-rsrc_mgrc-warning-fix.patch
  pcmcia/rsrc_mgr.c warning fix.

compile-fix-for-macserial.patch
  Compile fix for macserial



