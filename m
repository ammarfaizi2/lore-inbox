Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265590AbUF2JGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUF2JGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 05:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUF2JGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 05:06:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:19904 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265655AbUF2JFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 05:05:15 -0400
Date: Tue, 29 Jun 2004 02:04:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm4
Message-Id: <20040629020417.70717ffe.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm4/

- Merged support for the 64-bit SuperH architecture

- Various fixes and updates



Changes since 2.6.7-mm3:


 linus.patch
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

 External bk trees.

 bk-acpi is in the doghouse due to being generally sick lately

 bk-arm's server isn't talking

-add-pcdp-console-detection-support.patch
-add-pcdp-console-detection-support-config-fix.patch
-ppc64-COMMAND_LINE_SIZE-fix.patch
-ppc64-fix-oprofile-on-970.patch
-ppc64-udbg-should-use-snprintf.patch
-ppc64-another-udbg-fix.patch
-ppc64-udbg-fix.patch
-ppc64-remove-a-stale-comment-in-rtasc.patch
-__alloc_bootmem_node-should-not-panic-when-it-fails.patch
-ppc64-fix-usage-of-cpumask_t-on-iseries.patch
-larger-io-bitmap.patch
-ia32-fault-deadlock-fix-2.patch
-x86-stack-dump-fixes.patch
-nx-2.6.7-rc2-bk2-AF.patch
-nx-update.patch
-nx-update-2.patch
-sysfs-fill_read_buffer-fix.patch
-fix-smbfs-readdir-oops.patch
-remove-smbfs-server-rcls-err.patch
-kallsyms-exclude.patch
-kallsyms-verify.patch
 r8169_napi-help-text.patch
-kbuild-distclean-srctree-fix.patch
-make-__free_pages_bulk-more-comprehensible.patch
-cap_dac_override.patch
-fix-module_text_address-store_stackinfo-race-2.patch
-267-mm1-port-acer-laptop-irq-routing-workaround-to-new-dmi-probing.patch
-267-mm1-port-pnp-bios-driver-to-new-dmi-probing.patch
-267-mm1-port-sonypi-driver-to-new-dmi-probing.patch
-267-mm1-port-piix4-smbus-driver-to-new-dmi-probing.patch
-267-mm1-port-powernow-k7-driver-to-new-dmi-probing.patch
-267-mm1-remove-unused-asus-k7v-rm-dmi-quirk.patch
-267-mm1-port-apm-bios-driver-to-new-dmi-probing.patch
-hpet-fixes.patch
-hpet-fixes-fix.patch
-per-node-huge-page-stats-in-sysfs.patch
-per-node-huge-page-stats-in-sysfs-fix.patch
-scsi-printk-fixes.patch
-knfsd-mark-nfs-tcp-server-not-experimental.patch
-knfsd-simplify-nfsd4-name-encoding.patch
-knfsd-simplify-nfsd4_release_lockowner.patch
-knfsd-delete-an-obsolete-comment-from-nfsd-rpc-code.patch
-knfsd-reduce-stack-usage-in-nfsd4.patch
-knfsd-nfsd4-lockowner-fixes.patch
-knfsd-parse-nsfd4-callback-information.patch
-knfsd-improve-cleaning-up-of-nfsd4-requests.patch
-knfsd-allow-user-to-set-nfsv4-lease-time.patch
-i386-uninline-memmove.patch
-selinux-config_security_network-build-fix.patch
-tidy-identify_cpu-output.patch
-allow-root-to-choose-vfat-policy-to-utf8.patch
-crc-add-common-crc16-module.patch
-crc-add-common-crc16-module-default-y.patch
-crc-use-it-in-async-ppp-driver.patch
-crc-use-it-in-irda-drivers.patch
-crc-use-it-in-isdn-drivers.patch
-crc-use-it-in-ax25-drivers.patch
-direct-i-o-stomp-over-page-mapping-for-hugetlb-page.patch
-fix-numa-boundaray-between-zone_normal-and-highmem.patch
-missing-semicolon-in-267-viodasd-driver.patch
-267-bk7-ppp_genericc-get_filter-made-conditional.patch
-radeonfb-accel-capabilities-resend.patch
-mention-in-the-laptop-mode-docs-that-no-kernel-configuration-change-is-needed.patch
-inodes_stat-nr_unused-fix.patch
-vc-locking.patch
-vc-locking-tweaks.patch
-laptop-mode-control-script-improvements.patch
-swsusps-meaningfull-assembly-labels.patch
-fix-gfp-zone-modifier-interators.patch
-fix-char-ipmi-ipmi_si_intfc-warnings.patch
-remove-include-arch-inith.patch
-anon_vma-list-locking-bug.patch
-cpufreq_delayed_get-inline-fix.patch
-lock-ordering-update.patch
-ext3-direct-io-credits-overflow-fix.patch
-arm-build-fix.patch
-dont-hold-i_sem-on-swapfiles.patch
-dont-hold-i_sem-on-swapfiles-comment.patch
-setattr-retval-fixes.patch
-reiserfs_setattr-retval-fix.patch
-jfs_setattr-fix.patch
-cifs_setattr-retval-fix.patch
-ncpfs_setattr-retval-fix.patch
-affs_setattr-retval-fix.patch

 Merged

+x86_64-setup-section-alignment-fix.patch

 Fix alignment of .init.setup section (fixes the kernel boot parameter woes)

+alsa-gus-compile-error.patch

 ALSA build fix

+kgdb-ia64-fix.patch

 Make kgd-for-ia64 work again

-ftruncate-vs-block_write_full_page.patch

 Dropped.  We really should do this, but I don't think this was right.

-dont-writeback-fd-bdev-inodes.patch

 Dropped, not needed.

+binary-translator-fs-passing.patch

 Tidy up and fix the passing of fd's in the recent binfmt_misc enhancement.

+kill-mm_structused_hugetlb.patch

 Remove unneeded mm_struct field

+provide-console_device.patch
+provide-console_device-comment.patch
+provide-console_suspend-and-console_resume.patch

 Infrastructure for accessing console layer internals

+flexible-mmap-2.6.7-mm3-A8.patch

 Bring back the x86 userspace layout enhancements.

+next-step-of-smp-support-fix-device-suspending.patch
+next-step-of-smp-support-fix-device-suspending-warning-fix.patch
+next-step-of-smp-support-fix-device-suspending-warning-fix-2.patch
+next-step-of-smp-support-fix-device-suspending-x86_64-fix.patch

 swsusp SMP preparation

+v267-indydogc-patch-20040627.patch

 Watchdog update

-input-psmouse-resync-for-kvm-users.patch
-input-psmouse-state-locking.patch
-input-serio-connect-disconnect-mandatory.patch
-input-serio-renames-1.patch
-input-serio-renames-1-fix.patch
-input-serio-renames-2.patch
-input-serio-dynamic-allocation.patch
-input-serio-dynamic-allocation-fix-2.patch
-input-serio-dynamic-allocation-fix-3.patch
-input-serio-no-recursion.patch
-input-serio-sysfs-integration.patch
-input-serio-allow-rebinding.patch
-input-serio-manual-bind.patch
-input-serio_raw-driver.patch
-i8042-sparc64-build-fix.patch
+input-psmouse-state-locking.patch
+input-serio-connect-disconnect-mandatory.patch
+input-serio-renames-1.patch
+input-serio-renames-2.patch
+input-serio-dynamic-allocation.patch
+input-serio-avoid-recursion.patch
+input-serio-sysfs-intergration.patch
+input-serio-rebind.patch
+input-9-19-serio-manual-bind.patch
+input-serio_raw-driver.patch
+input-add-platform_device_register_simple.patch
+input-convert-i8042-into-a-platform-device.patch
+input-more-platform-device-conversions.patch
+input-bind-serio-ports-and-their-parents.patch
+input-synaptics-passthrough-handling.patch
+input-add-bus-default-driver-attributes.patch
+input-serio-use-bus-default-driver-device-attributes.patch
+input-add-driver_find.patch
+input-serio-use-driver_find.patch

 New set of input patches

+fbcon-display-artifacts-fix.patch

 Fix messed up fbcon display

+fix-to-microcode-driver-for-the-old-cpus.patch

 microcode driver update

+produce-a-warning-on-unchecked-inode_setattr-use.patch

 Add a new __must_check directive.  Us ethis in a function declaration and
 the compiler will warn if anyone calls that function and ignores the return
 value.  Requires gcc-3.4.  Use it for inode_setattr().

+credits-update.patch

 Update ./CREDITS

+pcdp-console-detection-support-fixes.patch

 Update the PCDP console detection code

+ppc64-vio-infrastructure-modifications.patch
+ppc64-iseries_veth-integration.patch
+ppc64-viodasd-integration.patch
+ppc64-viocd-integration.patch
+ppc64-viotape-integration.patch

 ppc64 stuff

+hpet-fixes-3.patch

 HPET driver fixes

+sh64-merge.patch

 64-bit SuperH architecture merge

+cirrusfb-minor-fixes.patch

 Fixes for the newly resurrected Cirrus fbdev driver

+signed-bug-in-drivers-video-console-fbconc-con2fb_map.patch

 Chars aren't always signed

+edd-store-mbr_signature-on-first-16-int13-devices.patch

 EDD driver update

+combined-patch-for-remaining-trivial-sparse.patch

 sparse fixes

+dma_get_required_mask.patch

 dma_get_required_mask(): allow drivers to work out what sort of DMA
 descriptor they should be implementing.

+add-m68k-support-to-checkstack.patch

 68k support for `make checkstack'

+small-fixes-to-checkstack.patch

 checkstack fixes

+add-linux-compilerh-to-linux-fdh.patch

 Build fix

+fix-page-count-discrepancy-for-zero-page.patch

 The zero page is reserved.

+driver-model-and-sysfs-support-for-pcmcia-1-3.patch
+update-drivers-net-pcmcia-2-3.patch
+update-drivers-net-wireless-3-3.patch

 PCMCIA sysfs support

+alpha-build-fix.patch

 Fix the build on alpha

+bugfix-for-clock_realtime-absolute-timer.patch

 Fix posix timers in the presence of sys_stime().




All 156 patches:


linus.patch

x86_64-setup-section-alignment-fix.patch
  x86_64 .init.setup alignment fix

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

alsa-gus-compile-error.patch
  fix ALSA gus compile error

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

kgdb-ia64-fix.patch
  ia64 kgdb fix

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

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

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

enable-suspend-resuming-of-e1000.patch
  Enable suspend/resuming of e1000

tty_io-hangup-locking.patch
  tty_io.c hangup locking

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

r8169_napi-help-text.patch
  R8169_NAPI help text

net-at1700c-depends-on-mca_legacy.patch
  net/at1700.c depends on MCA_LEGACY

net-ne2c-needs-mca_legacy.patch
  net/ne2.c needs MCA_LEGACY

altix-serial-driver-2.patch
  Altix serial driver updates
  altix-serial-driver-fix

bridge-fix-bpdu-message_age.patch
  Bridge - Fix BPDU message_age

reduce-tlb-flushing-during-process-migration-2.patch
  Reduce TLB flushing during process migration

reduce-tlb-flushing-during-process-migration-2-fix.patch
  reduce-tlb-flushing-during-process-migration-2-fix

tlb_migrate_flush-docs.patch
  tlb_migrate_flush documentation

binary-translator-fs-passing.patch
  binfmt misc fd passing via ELF aux vector

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

memory-backed-inodes-fix.patch
  memory-backed inodes fix

ext3_bread-cleanup.patch
  ext3_bread() cleanup

translate-japanese-comments-in-arch-v850.patch
  Translate Japanese comments in arch/v850

kill-mm_structused_hugetlb.patch
  kill mm_struct.used_hugetlb

provide-console_device.patch
  Provide console_device()

provide-console_device-comment.patch
  provide-console_device-comment

provide-console_suspend-and-console_resume.patch
  Provide console_suspend() and console_resume()

flexible-mmap-2.6.7-mm3-A8.patch
  i386 virtual memory layout rework

next-step-of-smp-support-fix-device-suspending.patch
  swsusp: preparation for smp support & fix device suspending

next-step-of-smp-support-fix-device-suspending-warning-fix.patch
  next-step-of-smp-support-fix-device-suspending warning fix

next-step-of-smp-support-fix-device-suspending-warning-fix-2.patch
  next-step-of-smp-support-fix-device-suspending warning fix 2

next-step-of-smp-support-fix-device-suspending-x86_64-fix.patch
  next-step-of-smp-support-fix-device-suspending x86_64 fix

v267-indydogc-patch-20040627.patch
  indydog.c-patch-20040627

input-psmouse-state-locking.patch
  input: psmouse state locking

input-serio-connect-disconnect-mandatory.patch
  input: serio connect/disconnect mandatory

input-serio-renames-1.patch
  input: serio renames 1

input-serio-renames-2.patch
  input: serio renames 2

input-serio-dynamic-allocation.patch
  input: serio dynamic allocation

input-serio-avoid-recursion.patch
  input: serio avoid recursion

input-serio-sysfs-intergration.patch
  input: serio sysfs intergration

input-serio-rebind.patch
  input: serio rebind

input-9-19-serio-manual-bind.patch
  input: serio manual bind

input-serio_raw-driver.patch
  input: serio_raw driver

input-add-platform_device_register_simple.patch
  input: add platform_device_register_simple

input-convert-i8042-into-a-platform-device.patch
  input: convert i8042 into a platform device

input-more-platform-device-conversions.patch
  input: more platform device conversions

input-bind-serio-ports-and-their-parents.patch
  input: bind serio ports and their parents

input-synaptics-passthrough-handling.patch
  input: synaptics passthrough handling

input-add-bus-default-driver-attributes.patch
  input: add bus' default driver attributes

input-serio-use-bus-default-driver-device-attributes.patch
  input: serio use bus' default driver/device attributes

input-add-driver_find.patch
  input: add driver_find

input-serio-use-driver_find.patch
  input: serio use driver_find

fbcon-display-artifacts-fix.patch
  fbcon: fix display artifacts

fix-to-microcode-driver-for-the-old-cpus.patch
  fix to microcode driver for the old CPUs.

produce-a-warning-on-unchecked-inode_setattr-use.patch
  produce a warning on unchecked inode_setattr use

credits-update.patch
  CREDITS update

pcdp-console-detection-support-fixes.patch
  PCDP console detection support fixes

ppc64-vio-infrastructure-modifications.patch
  ppc64: vio infrastructure modifications

ppc64-iseries_veth-integration.patch
  ppc64: iseries_veth integration

ppc64-viodasd-integration.patch
  ppc64: viodasd integration

ppc64-viocd-integration.patch
  ppc64: viocd integration

ppc64-viotape-integration.patch
  ppc64: viotape integration

hpet-fixes-3.patch
  hpet fixes

sh64-merge.patch
  sh64 support

cirrusfb-minor-fixes.patch
  cirrusfb: minor fixes

signed-bug-in-drivers-video-console-fbconc-con2fb_map.patch
  signed bug in drivers/video/console/fbcon.c con2fb_map[]

edd-store-mbr_signature-on-first-16-int13-devices.patch
  EDD: store mbr_signature on first 16 int13 devices

combined-patch-for-remaining-trivial-sparse.patch
  Combined patch for remaining trivial sparse warnings in allnoconfig build

dma_get_required_mask.patch
  dma_get_required_mask()

add-m68k-support-to-checkstack.patch
  Add m68k support to checkstack

small-fixes-to-checkstack.patch
  From: Jorn Engel <joern@wohnheim.fh-wedel.de>
  Subject: [PATCH] small fixes to checkstack

add-linux-compilerh-to-linux-fdh.patch
  Add <linux/compiler.h> to <linux/fd.h>

fix-page-count-discrepancy-for-zero-page.patch
  fix page->count discrepancy for zero page

driver-model-and-sysfs-support-for-pcmcia-1-3.patch
  driver model and sysfs support for PCMCIA (1/3)

update-drivers-net-pcmcia-2-3.patch
  update drivers/net/pcmcia (2/3)

update-drivers-net-wireless-3-3.patch
  update drivers/net/wireless (3/3)

alpha-build-fix.patch
  Fix Alpha compilation

bugfix-for-clock_realtime-absolute-timer.patch
  Bugfix for CLOCK_REALTIME absolute timer



