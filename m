Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUF0Gcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUF0Gcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 02:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUF0Gcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 02:32:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:37533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261159AbUF0GcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 02:32:02 -0400
Date: Sat, 26 Jun 2004 23:31:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm3
Message-Id: <20040626233105.0c1375b2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm3/


- Added Adam's PNP bk tree to the "external bk trees"

- random fixes and updates all over the place




Changes since 2.6.7-mm2:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pnp.patch
 bk-scsi.patch
 bk-usb.patch

 External trees

-allow-i386-to-reenable-interrupts-on-lock-contention.patch
-ext3-jbd-needs-to-wait-for-locked-buffers.patch
-Move-saved_command_line-to-init-mainc.patch
-rcu-lock-update-add-per-cpu-batch-counter.patch
-rcu-lock-update-use-a-sequence-lock-for-starting-batches.patch
-rcu-lock-update-code-move-cleanup.patch
-singly-linked-rcu.patch
-rcu-no-arg.patch
-rcu-no-arg-fix.patch
-rcu-no-arg-fastcall-fix.patch
-sch_generic-rcu-fix.patch
-cpumask-1-10-cpu_present_map-real-even-on-non-smp.patch
-cpumask-2-10-bitmap-cleanup-preparation-for-cpumask.patch
-cpumask-3-10-bitmap-inlining-and-optimizations.patch
-cpumask-5-10-rewrite-cpumaskh-single-bitmap-based.patch
-cpumask-5-10-rewrite-cpumaskh-single-bitmap-based-cpu_mask_none-fix.patch
-s390-fix-cpu_online-redefined-warnings.patch
-cpumask-6-10-remove-26-no-longer-used-cpumaskh-files.patch
-cpumask-7-10-remove-obsolete-cpumask-macro-uses-i386-arch.patch
-cpumask-8-10-remove-obsolete-cpumask-macro-uses-other.patch
-x86_64-cpu_online-fix.patch
-ppc64-cpu_online-fix.patch
-cpumask-9-10-remove-no-longer-used-obsolete-macro-emulation.patch
-cpumask-10-10-optimize-various-uses-of-new-cpumasks.patch
-cpumask-11-10-comment-spacing-tweaks.patch
-cleanup-cpumask_t-temporaries.patch
-alpha-cpumask-fix.patch
-irqaction-use-cpumask.patch
-fix-and-reenable-msi-support-on-x86_64.patch
-vmscan-shuffle-things-around.patch
-vmscan-scan-sanity.patch
-vmscan-dont-reclaim-too-many-pages.patch
-vfs-shrinkage-tuning.patch
-ide-stack-reduction.patch
-dnotify-remove-dn_lock.patch
-fancy-wakeups-in-wait-h.patch
-buddy-reordering.patch
-hwcache-align-kmalloc-caches.patch
-reduce-function-inlining-in-slabc.patch
-abs-fix.patch
-abs-fix-fix.patch
-ide-taskfilec-fixups-cleanups.patch
-ide-end-request-fix-for-config_ide_taskfile_io=y-pio-handlers.patch
-ide-pio-in-drive-busy-fix-config_ide_taskfile_io=y.patch
-ide-check-drive-mult_count-in-flagged_taskfile.patch
-ide-last-irq-fix-for-task_mulout_intr-config_ide_taskfile_io=n.patch
-ide-remove-dtf-debugging-printks-from-ide-taskfilec.patch
-ide-add-task_multi_sectors-to-ide-taskfilec.patch
-ide-split-task_sectors-and-task_multi_sectors.patch
-ide-dont-clear-rq-errors-for-req_drive_taskfile-requests.patch
-ide-use-task_buffer_sectors-in-ide-taskfilec.patch
-ide-pio-out-setup-fixes-config_ide_taskfile_io=n.patch
-for-netmos-based-pci-cards-providing-serial-and-parallel-ports.patch
-help-text-for-fb_riva_i2c.patch
-nr_pagecache-can-go-negative.patch
-nr_swap_pages-is-long.patch
-nr_swap_pages-is-long-fixes.patch
-total_swap_pages-is-long.patch
-a2-rewrite-and-26-fixes.patch
-dell-laptop-lockup-fix-for-alsa.patch
-mips-update.patch
-mips-indydog-update.patch
-re-267-mm1-linker-trouble-with-config_fb_riva_i2c=y-and-modular-i2c.patch
-fix-early-cpu-vendor-detection-for-non-intel-cpus.patch
-oprofile-allow-normal-user-to-trigger-sample-dumps.patch
-tiny-update-to-documentation-submittingdrivers-list-xorg.patch
-core-fbcon-fixes.patch
-video-mode-change-notify-fbset.patch
-fix-power3-numa-init.patch
-add-ppc85xx-maintainers-entry.patch
-flexible-mmap-267-mm1-a0.patch
-flexible-mmap-267-mm1-a0-fix.patch
-oprofile-documentation-basic_profilingtxt-updates.patch
-selinux-extend-and-revise-calls-to-secondary-module.patch
-fix-allocate_pgdat-comments.patch
-drivers-media-video-tda9840c-honour-return-code-of.patch
-altix-serial-driver.patch
-altix-serial-driver-fix.patch
-zap_pte_range-speedup.patch
-h8300-delete-obsolute-header.patch
-cirrusfb-it-lives.patch
-update-ikconfig-help-text.patch
-update-ikconfig-generator-script.patch
-hugetlb-use-safe-iterator.patch
-swsusp-minor-docs-updates.patch
-prepare-for-smp-suspend.patch
-swsusp-shuffle-cpuc-to-make-it-usable-for-smp-suspend.patch
-consolidate-in-kernel-configuration.patch
-sparse-trivial-fixes-of-assignment-expression-in-conditional-in-fs.patch
-more-bug-fix-in-mm-hugetlbc-fix-try_to_free_low.patch
-shut-up-kaweth-usb-net-driver.patch
-oom-killer-fix.patch
-sh-sh-3-on-chip-adc-support.patch
-sh-dma-mapping-updates.patch
-sh-dma-driver-updates.patch
-sh-early-printk-cleanup.patch
-sh-fixmap-support.patch
-sh-renesas-hs7751rvoip-board-support.patch
-sh-ide-cleanup.patch
-sh-ptep_get_and_clear-compile-fix.patch
-sh-sh-sci-updates.patch
-sh-solutionengine-7300-board-support.patch
-sh-renesas-rts7751r2d-board-support.patch
-sh-pci-updates.patch
-sh-sh7705-sh7300-subtype-support-st40-updates.patch
-sh-voyagergx-companion-chip-support.patch
-sh-merge.patch
-sh-consolidate-systemh-with-other-renesas-boards.patch
-md-fix-up-handling-for-read-error-in-raid1.patch
-md-xor-template-selection-redo.patch
-kswapd-warning-fix.patch
-balanced_irq-warning-fix.patch
-tr-warning-fixes.patch
-fc-warning-fix.patch
-ip_fw_compat_masq-build-fix.patch
-pkt_sched-warning-fixes.patch
-267-fix-broken-alpha-build-ptracec-error.patch

 Merged

+add-pcdp-console-detection-support.patch
+add-pcdp-console-detection-support-config-fix.patch

 Add support for the EFI/DIG PCDP console discovery table.

+pwc-uncompress-build-fix.patch

 USB driver compile fix

+ppc64-COMMAND_LINE_SIZE-fix.patch
+ppc64-fix-oprofile-on-970.patch
+ppc64-udbg-should-use-snprintf.patch
+ppc64-another-udbg-fix.patch
+ppc64-udbg-fix.patch
+ppc64-remove-a-stale-comment-in-rtasc.patch
+ppc64-fix-usage-of-cpumask_t-on-iseries.patch

 PPC64 updates

+__alloc_bootmem_node-should-not-panic-when-it-fails.patch

 NUMA mm initialisation tweak

+kgdb-irqaction-use-cpumask.patch

 kgdb fix

-sysfs-overflow-debug.patch

 Dropped - the bug is fixed.

+i8042-sparc64-build-fix.patch

 input build fix

+sysfs-fill_read_buffer-fix.patch

 Fix sysfs BUG_ON

+altix-serial-driver-2.patch

 ALTIX serial driver

+fix-module_text_address-store_stackinfo-race-2.patch

 Fix for CONFIG_DEBUG_PAGEALLOC modules race

+reduce-tlb-flushing-during-process-migration-2-fix.patch
+tlb_migrate_flush-docs.patch

 New version of this ia64 speedup patch

+per-node-huge-page-stats-in-sysfs-fix.patch

 hugetlb NUMA instrumentation

+i386-uninline-memmove.patch

 ia32 linkage fix

+selinux-config_security_network-build-fix.patch

 selinux fix

+tidy-identify_cpu-output.patch

 Neaten boot messages

+allow-root-to-choose-vfat-policy-to-utf8.patch

 VFAT fix

+crc-add-common-crc16-module.patch
+crc-add-common-crc16-module-default-y.patch
+crc-use-it-in-async-ppp-driver.patch
+crc-use-it-in-irda-drivers.patch
+crc-use-it-in-isdn-drivers.patch
+crc-use-it-in-ax25-drivers.patch

 Consolidate crc32 code

+direct-i-o-stomp-over-page-mapping-for-hugetlb-page.patch

 hugetlb direct-io fix

+fix-numa-boundaray-between-zone_normal-and-highmem.patch

 NUMA setup fix

+missing-semicolon-in-267-viodasd-driver.patch

 build fix

+267-bk7-ppp_genericc-get_filter-made-conditional.patch

 ifdef away some unused code

+radeonfb-accel-capabilities-resend.patch

 radeonfb hardware acceleration

+sched-cleanup-init_idle.patch
+sched-cleanup-improve-sched-fork-apis.patch
+sched-misc-changes.patch
+sched-disable-balance-on-clone-by-default.patch
+sched-exit-race.patch

 CPU scheduler updates

+mention-in-the-laptop-mode-docs-that-no-kernel-configuration-change-is-needed.patch

 laptop-mode documentation update

+inodes_stat-nr_unused-fix.patch

 inode_stat.nr_unused accounting fix

+memory-backed-inodes-fix.patch

 small writeback speedup

+vc-locking.patch
+vc-locking-tweaks.patch

 virtual console locking fixes

+laptop-mode-control-script-improvements.patch

 laptop mode control script update

+swsusps-meaningfull-assembly-labels.patch

 swsusp.S cleanup

+fix-gfp-zone-modifier-interators.patch

 page allocator fixlet

+fix-char-ipmi-ipmi_si_intfc-warnings.patch

 warning fixes

+ext3_bread-cleanup.patch

 Code cleanup

+remove-include-arch-inith.patch

 remove various asm/init.h files

+anon_vma-list-locking-bug.patch

 MM locking fix

+cpufreq_delayed_get-inline-fix.patch

 cpufreq inlining fix

+lock-ordering-update.patch

 locking documentation update

+ext3-direct-io-credits-overflow-fix.patch

 ext3 direct-io BUGfix

+arm-build-fix.patch

 ARM compile fix

+dont-hold-i_sem-on-swapfiles.patch
+dont-hold-i_sem-on-swapfiles-comment.patch

 Stop holding i_sem on swapfiles.

+setattr-retval-fixes.patch
+reiserfs_setattr-retval-fix.patch
+jfs_setattr-fix.patch
+cifs_setattr-retval-fix.patch
+ncpfs_setattr-retval-fix.patch
+affs_setattr-retval-fix.patch

 Fix lots of filesystem setattr() implementations

+translate-japanese-comments-in-arch-v850.patch

 asciify some v850 comments.




All 198 patches


linus.patch

add-pcdp-console-detection-support.patch
  Add PCDP console detection support

add-pcdp-console-detection-support-config-fix.patch
  add-pcdp-console-detection-support-config-fix

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

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-ieee1394.patch

bk-input.patch

bk-netdev.patch

bk-ntfs.patch

bk-pnp.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

pwc-uncompress-build-fix.patch
  pwc-uncompress-build-fix

ppc64-COMMAND_LINE_SIZE-fix.patch
  ppc64: COMMAND_LINE_SIZE fix

ppc64-fix-oprofile-on-970.patch
  ppc64: fix oprofile on 970

ppc64-udbg-should-use-snprintf.patch
  ppc64: udbg should use snprintf

ppc64-another-udbg-fix.patch
  ppc64: another udbg fix

ppc64-udbg-fix.patch
  ppc64: udbg fix

ppc64-remove-a-stale-comment-in-rtasc.patch
  ppc64: remove a stale comment in rtas.c

ppc64-fix-usage-of-cpumask_t-on-iseries.patch
  ppc64: fix usage of cpumask_t on iSeries

__alloc_bootmem_node-should-not-panic-when-it-fails.patch
  __alloc_bootmem_node should not panic when it fails

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

kgdb-gapatch-fix-for-i386-single-step-into-sysenter.patch
  kgdb-ga.patch fix for i386 single-step into sysenter

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup

kgdb-irqaction-use-cpumask.patch

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

larger-io-bitmap.patch
  larger IO bitmaps

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

ftruncate-vs-block_write_full_page.patch
  ftruncate vs block_write_full_page race fix

ia32-fault-deadlock-fix-2.patch
  ia32: fix deadlocks when oopsing while mmap_sem is held

ppc64-fault-deadlock-fix-2.patch
  ppc64: fix deadlocks when oopsing while mmap_sem is held

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

x86-stack-dump-fixes.patch
  x86 stack dump fixes

enable-suspend-resuming-of-e1000.patch
  Enable suspend/resuming of e1000

tty_io-hangup-locking.patch
  tty_io.c hangup locking

nx-2.6.7-rc2-bk2-AF.patch
  NX (No eXecute) support for x86

nx-update.patch
  nx update

nx-update-2.patch
  nx update 2

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
  CONFIG_PERFCTR=n build fix

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
  perfctr #if/#ifdef cleanup
  perfctr Dothan support

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC

perfctr-ppc32-update.patch
  perfctr ppc32 update

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-cpus_complement-fix.patch
  perfctr-cpus_complement-fix

perfctr-cpumask-cleanup.patch
  perfctr cpumask cleanup

perfctr-misc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

ext3-online-resize-patch.patch
  ext3: online resizing

ext3-online-resize-warning-fix.patch
  ext3-online-resize-warning-fix

dont-writeback-fd-bdev-inodes.patch
  dont-writeback-fd-bdev-inodes

input-psmouse-resync-for-kvm-users.patch
  input: psmouse resync for KVM users

input-psmouse-state-locking.patch
  input: psmouse state locking

input-serio-connect-disconnect-mandatory.patch
  input: serio connect/disconnect mandatory

input-serio-renames-1.patch
  input: serio renames 1

input-serio-renames-1-fix.patch
  input-serio-renames-1-fix

input-serio-renames-2.patch
  input: serio renames 2

input-serio-dynamic-allocation.patch
  input: serio dynamic allocation

input-serio-dynamic-allocation-fix-2.patch
  input-serio-dynamic-allocation-fix-2

input-serio-dynamic-allocation-fix-3.patch
  input-serio-dynamic-allocation-fix-3

input-serio-no-recursion.patch
  input: serio no recursion

input-serio-sysfs-integration.patch
  input: serio sysfs integration

input-serio-allow-rebinding.patch
  input: serio allow rebinding

input-serio-manual-bind.patch
  input: serio manual bind

input-serio_raw-driver.patch
  input: serio_raw driver

i8042-sparc64-build-fix.patch
  i8042 sparc64 build fix

sysfs-fill_read_buffer-fix.patch
  sysfs: fill_read_buffer() fix

fix-smbfs-readdir-oops.patch
  Fix smbfs readdir oops

remove-smbfs-server-rcls-err.patch
  Remove smbfs server->rcls/err

kallsyms-exclude.patch
  kallsyms: exclude kallsyms-generated symbols

kallsyms-verify.patch
  kallsyms: verify that System.map is stable

r8169_napi-help-text.patch
  R8169_NAPI help text

kbuild-distclean-srctree-fix.patch
  kbuild: distclean srctree fix

make-__free_pages_bulk-more-comprehensible.patch
  make __free_pages_bulk more comprehensible

net-at1700c-depends-on-mca_legacy.patch
  net/at1700.c depends on MCA_LEGACY

net-ne2c-needs-mca_legacy.patch
  net/ne2.c needs MCA_LEGACY

cap_dac_override.patch
  CAP_DAC_OVERRIDE fix

altix-serial-driver-2.patch
  Altix serial driver updates
  altix-serial-driver-fix

fix-module_text_address-store_stackinfo-race-2.patch
  Fix race between CONFIG_DEBUG_SLABALLOC and modules

bridge-fix-bpdu-message_age.patch
  Bridge - Fix BPDU message_age

267-mm1-port-acer-laptop-irq-routing-workaround-to-new-dmi-probing.patch
  dmi_scan: port Acer laptop irq routing workaround to new DMI probing

267-mm1-port-pnp-bios-driver-to-new-dmi-probing.patch
  dmi_scan: port PnP BIOS driver to new DMI probing

267-mm1-port-sonypi-driver-to-new-dmi-probing.patch
  dmi_scan: port sonypi driver to new DMI probing

267-mm1-port-piix4-smbus-driver-to-new-dmi-probing.patch
  dmi_scan: port PIIX4 SMBUS driver to new DMI probing

267-mm1-port-powernow-k7-driver-to-new-dmi-probing.patch
  dmi_scan: port powernow-k7 driver to new DMI probing

267-mm1-remove-unused-asus-k7v-rm-dmi-quirk.patch
  dmi_scan: remove unused ASUS K7V-RM DMI quirk

267-mm1-port-apm-bios-driver-to-new-dmi-probing.patch
  dmi_scan: port APM BIOS driver to new DMI probing

hpet-fixes.patch
  hpet fixes

hpet-fixes-fix.patch
  hpet-fixes fix

reduce-tlb-flushing-during-process-migration-2.patch
  Reduce TLB flushing during process migration

reduce-tlb-flushing-during-process-migration-2-fix.patch
  reduce-tlb-flushing-during-process-migration-2-fix

tlb_migrate_flush-docs.patch
  tlb_migrate_flush documentation

per-node-huge-page-stats-in-sysfs.patch
  per node huge page stats in sysfs

per-node-huge-page-stats-in-sysfs-fix.patch
  per-node-huge-page-stats-in-sysfs fix

scsi-printk-fixes.patch
  scsi printk fixes

knfsd-mark-nfs-tcp-server-not-experimental.patch
  knfsd: mark NFS/TCP server not EXPERIMENTAL

knfsd-simplify-nfsd4-name-encoding.patch
  knfsd: simplify nfsd4 name encoding.

knfsd-simplify-nfsd4_release_lockowner.patch
  knfsd: simplify nfsd4_release_lockowner

knfsd-delete-an-obsolete-comment-from-nfsd-rpc-code.patch
  knfsd: delete an obsolete comment from nfsd rpc code

knfsd-reduce-stack-usage-in-nfsd4.patch
  knfsd: reduce stack usage in nfsd4

knfsd-nfsd4-lockowner-fixes.patch
  knfsd: nfsd4 lockowner fixes

knfsd-parse-nsfd4-callback-information.patch
  knfsd: parse nsfd4 callback information

knfsd-improve-cleaning-up-of-nfsd4-requests.patch
  knfsd: improve cleaning up of nfsd4 requests

knfsd-allow-user-to-set-nfsv4-lease-time.patch
  knfsd: allow user to set NFSv4 lease time.

i386-uninline-memmove.patch
  i386: uninline memmove

selinux-config_security_network-build-fix.patch
  SELinux: fix build with CONFIG_SECURITY_NETWORK=n

tidy-identify_cpu-output.patch
  tidy up the identify_cpu() output

allow-root-to-choose-vfat-policy-to-utf8.patch
  Permit root to choose vfat policy to UTF8

crc-add-common-crc16-module.patch
  crc: add common CRC16 module

crc-add-common-crc16-module-default-y.patch
  crc-add-common-crc16-module-default-y

crc-use-it-in-async-ppp-driver.patch
  crc: use it in async PPP driver

crc-use-it-in-irda-drivers.patch
  crc: use it in IRDA drivers

crc-use-it-in-isdn-drivers.patch
  Subject: [PATCH 3/4] 2.6.7-mm2, Use it in ISDN drivers

crc-use-it-in-ax25-drivers.patch
  crc: use it in AX.25 drivers

direct-i-o-stomp-over-page-mapping-for-hugetlb-page.patch
  Fix direct I/O into hugetlb page

fix-numa-boundaray-between-zone_normal-and-highmem.patch
  fix NUMA boundaray between ZONE_NORMAL and HIGHMEM

missing-semicolon-in-267-viodasd-driver.patch
  missing semicolon in 2.6.7 VIODASD driver

267-bk7-ppp_genericc-get_filter-made-conditional.patch
  ppp_generic.c get_filter made conditional

radeonfb-accel-capabilities-resend.patch
  radeonfb accel capabilities (resend)

sched-cleanup-init_idle.patch
  sched: cleanup init_idle

sched-cleanup-improve-sched-fork-apis.patch
  sched: cleanup, improve sched <=> fork APIs

sched-misc-changes.patch
  sched: sched misc changes

sched-disable-balance-on-clone-by-default.patch
  sched: disable balance-on-clone by default

sched-exit-race.patch
  sched: sched exit race

mention-in-the-laptop-mode-docs-that-no-kernel-configuration-change-is-needed.patch
  laptop-mode documentation update

inodes_stat-nr_unused-fix.patch
  inodes_stat.nr_unused fix

memory-backed-inodes-fix.patch
  memory-backed inodes fix

vc-locking.patch
  vc locking

vc-locking-tweaks.patch
  vc-locking.patch tweaks

laptop-mode-control-script-improvements.patch
  Laptop mode control script improvements

swsusps-meaningfull-assembly-labels.patch
  swsusp.S: meaningful assembly labels

fix-gfp-zone-modifier-interators.patch
  fix GFP zone modifier interators

fix-char-ipmi-ipmi_si_intfc-warnings.patch
  drivers/char/ipmi/ipmi_si_intf.c warnings.

ext3_bread-cleanup.patch
  ext3_bread() cleanup

remove-include-arch-inith.patch
  Remove include/asm-*/init.h

anon_vma-list-locking-bug.patch
  anon_vma list locking bug

cpufreq_delayed_get-inline-fix.patch
  cpufreq_delayed_get() inlining fix

lock-ordering-update.patch
  lock-ordering-update

ext3-direct-io-credits-overflow-fix.patch
  ext3: direct-io transaction extending fix

arm-build-fix.patch
  ARM COMMAND_LINE_SIZE build fix

dont-hold-i_sem-on-swapfiles.patch
  Don't hold i_sem on swapfiles

dont-hold-i_sem-on-swapfiles-comment.patch
  dont-hold-i_sem-on-swapfiles-comment

setattr-retval-fixes.patch
  ext2_setattr retval fix

reiserfs_setattr-retval-fix.patch
  reiserfs_setattr retval fix

jfs_setattr-fix.patch
  jfs_setattr() fix

cifs_setattr-retval-fix.patch
  cifs_setattr() retval fix

ncpfs_setattr-retval-fix.patch
  ncpfs_setattr() retval fix

affs_setattr-retval-fix.patch
  affs_setattr() retval fix

translate-japanese-comments-in-arch-v850.patch
  Translate Japanese comments in arch/v850



