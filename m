Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267764AbUBTJpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 04:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbUBTJpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 04:45:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:53124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267764AbUBTJoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 04:44:23 -0500
Date: Fri, 20 Feb 2004 01:44:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3-mm2
Message-Id: <20040220014437.0bf6d47f.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm2/

- More parport fixes/cleanups from Al Viro

- Various patches were folded together to make them a bit more logical. 
  -mm has less than 200 patches for the first time in a long time.  Things
  are actually slowing down.

- Added an absolutely gargantuan MIPS update.

- More CPU scheduler changes.

- 2.6.3-mm2 builds and runs on x86 and ia64, and compiles on x86_64 and ppc64.




Changes since 2.6.3-mm1:


 linus.patch
 bk-netdev.patch
 bk-input.patch
 bk-acpi.patch
 bk-pci.patch
 bk-i2c.patch
 bk-driver-core.patch
 bk-ieee1394.patch
 bk-scsi.patch

 External trees

-i4l.patch
-i4l-st5481-old-gcc-fix.patch
-i4l-sc-adapter-fix.patch
-i4l-fixups.patch
-gcc-35-hysdn.patch
-i4l-hisax-deadlock-fix.patch
-i4l-hisax-deadlock-fix-gcc-35-fix.patch
-ppp-active-passive-filter-fix.patch
-speedo-warning-fix.patch
-tulip-warning-fix.patch
-r8169-rx-wrap-fix.patch
-early_printk.patch
-early_printk-tweaks.patch
-ppc64-prom-warnings.patch
-ppc64-saved-command-line-length-fix.patch
-ppc64-debugger-warning-fixes.patch
-ppc64-iseries-irq-fix.patch
-ramdisk-cleanup.patch
-slab-print-name.patch
-ptrace-page-permission-fix.patch
-loop-remove-blkdev-special-case.patch
-loop-highmem.patch
-loop-bio-handling-fix.patch
-loop-init-fix.patch
-loop-remove-redundant-assignment.patch
-acpi-pm-timer-3.patch
-acpi-pm-timer-kill-printks.patch
-use-TSC-for-delay_pmtmr-2.patch
-kthread-primitive.patch
-use-kthread-primitives.patch
-module-removal-use-kthread.patch
-kthread-affinity-fix.patch
-kthread-affinity-fix-fix.patch
-call_usermodehelper-affinity-fix.patch
-call_usermodehelper-affinity-fix-fix.patch
-kthread-handle-non-booting-CPUs.patch
-kthread-stop-using-signals.patch
-remove-kstat-cpu-notifiers.patch
-workqueue-cleanup-2.patch
-remove-more-cpu-notifiers.patch
-use-CPU_UP_PREPARE-properly.patch
-limit-hash-table-sizes-boot-options.patch
-limit-hash-table-sizes-boot-options-warning-fix.patch
-limit-hash-table-sizes-boot-options-restore-defaults.patch
-limit-hash-table-size-docco.patch
-slab-poison-hex-dumping.patch
-pentium-m-support.patch
-pentium-m-support-fixes.patch
-old-gcc-supports-k6.patch
-amd-elan-is-a-different-subarch.patch
-page_add_rmap-warning.patch
-add-config-for-mregparm-3-ng.patch
-use-funit-at-a-time.patch
-add-noinline-attribute.patch
-dont-inline-rest_init.patch
-gcc-35-bonding.patch
-doc-remove-modules-conf-references.patch
-more-MODULE_ALIASes.patch
-bonding-alias-revert-and-docco-fix.patch
-usb-sddr09-documentation.patch
-pcnet32-locking-fix.patch
-increase-NGROUPS.patch
-increase-NGROUPS-nfsd-cleanup.patch
-increase-NGROUPS-cleanup-and-fix.patch
-intermezzo-NGROUPS-is-broken.patch
-bd_set_size-i_size-fix.patch
-access-permissions-fix.patch
-snprintf-fixes.patch
-devfs-race-fix-cleanup.patch
-enable-largefile-coredumps.patch
-mips-new-serial-drivers.patch
-ifdef-cleanups.patch
-nfsd-01-schedule-in-spinlock-fix.patch
-nfsd-02-sunrpc-cache-init-fixes.patch
-nfsd-03-ip_map_init-kmalloc-check.patch
-nfsd-04-convert-proc-to-seq_file.patch
-nfsd-05-no-procfs-build-fix.patch
-md-01-START_ARRAY-is-deprecated.patch
-md-02-split-end_request-handlers.patch
-md-03-discard-r1_bio-cmd-field.patch
-md-04-r1_bio-cleanup.patch
-md-05-avoid-bio-allocation.patch
-md-06-raid1-limit-bio-sizes.patch
-md-07-allow-partitioning.patch
-dm-01-export-dm_vcalloc.patch
-dm-02-move-to_bytes-to_sectors.patch
-dm-03-remove-dm_deferred_io.patch
-dm-04-maintain-bio-ordering.patch
-dm-05-alloc_dev-error-cleanup.patch
-dm-07-dm_table_create-GFP-fix.patch
-dm-08-zero-size-target-fix.patch
-dm-09-dec_pending-locking-cleanup.patch
-dm-10-drop-BIO_SEG_VALID.patch
-ia32-discontig-pfn_valid-fix.patch
-ia32-pfn_to_nid-fix.patch
-ia32-numa-pcs-dont-work.patch
-8259-timer-ack-fix.patch
-mce-printk-level-fixes.patch
-mce-preempt-fixes.patch
-bitmap_snprintf-bitmap_scnprintf.patch
-oss-cruft-removal.patch
-stallion-decruftery.patch
-external-kbuild-doc.patch
-adfs-2.2-cruft.patch
-panic-later-if-too-many-boot-params.patch
-altix-irq-accounting-speedup.patch
-altix-simulator-fix.patch
-cpufreq_scale-fix-cleanup.patch
-cross-compilation-fixes.patch
-proc-thread-visibility-fix.patch
-console-race-fix.patch
-nfsd-needs-loff_t.patch
-show_free_areas-online-cpus.patch
-nbd-proc-partitions-fix.patch
-use-THREAD_SIZE.patch
-3c59x-enable_wol.patch
-oprofile-nmi_timer_int-fix.patch
-oprofile-arm-support.patch
-oprofile-pentium-m-support.patch
-increase-max_anon.patch
-release_region-race-fix.patch
-debugging-modules.patch
-sn-setup-cleanup.patch
-jfs-01-sane-filename-handling.patch
-jfs-02-sane-filename-handling.patch
-module-headers-cleanup.patch
-add-clock_was_set.patch
-altix-header-cleanups.patch
-epoll_ctl-race-fix.patch
-slab-printk-suppression.patch
-do_swap_page-retval-fix.patch
-ide-tape-remove-onstream-support.patch
-ide-tape-warning-fixes.patch
-remove-bootmem-warnings.patch
-dm-crypt.patch
-dm-crypt-remove-bogus-BUG_ON.patch
-make-rpm-fix.patch
-menuconfig-ncurses-check-fix.patch
-tlb-flushing-speedup.patch
-sf16fmr2.patch
-CONFIG_IRQBALANCE.patch
-smp_boot_cpus-BUG-removal.patch
-CodingStyle-update.patch
-smbfs-loop-support.patch
-cygwin-cpio-fix.patch
-print-build-options-on-oops.patch
-show_task-free-stack-fix.patch
-show_task-fix.patch
-aio-sysctl-parms.patch

 Merged

+mips-megapatch.patch

 Monster MIPS update

+acpi-utils-warning-fix.patch

 acpi/utils.c warning fix

+acpi-sleep-warning-fix.patch

 drivers/acpi/sleep/proc.c warnings

+ppc64-tulip-build-fix.patch

 ppc64: fix de4x5 build

-sched-build-fix.patch
-p4-clockmod-sibling-map-fix.patch
-p4-clockmod-more-than-two-siblings.patch
-sched-find_busiest_group-fix.patch
-sched-arch_init_sched_domains-fix.patch
-sched-many-cpus-build-fix.patch
-sched-find_busiest_group-clarification.patch
-sched-find_busiest_group-arith-fix.patch
-sched-remove-noisy-printks.patch
-sched-smt-numa-fix.patch

 These were all folded into other scheduler patches

+sched-group-power.patch

 sched-group-power

+sched-group-power-warning-fixes.patch

 sched-group-power warning fixes

+sched-domains-use-cpu_possible_map.patch

 sched_domains: use cpu_possible_map

+hotplugcpu-generalise-bogolock-fix-for-kthread-stop-using-signals.patch
+hotplugcpu-core-fix-for-kthread-stop-using-signals.patch

 CPU hotplug fixes

-compat-ipc-consolidation.patch
-compat-ipc-consolidation-fix.patch

 Dropped (a new version was applied)

+compat-generic-ipc-emulation.patch

 generic 32 bit emulation for System-V IPC

+compat-generic-ipc-emulation-s390.patch

 use generic IPC emulation on s390

+compat-generic-ipc-emulation-x86_64.patch

 use generic IPC emulation on x86_64

+compat-generic-ipc-emulation-ia64.patch

 common ipc compat syscalls: ia64

+add-syscalls_h-shmat-fix.patch

 fix shmat

+add_syscalls-compat-ipc-fix.patch

 fix compat-ipc code for syscalls.h

+add-syscalls_h-x86_64-unistd-warning-fix.patch

 syscalls.h: x86_64 warning fix

+add-syscalls_h-kinit.patch

-nfs-mount-oops-fix.patch

 Dropped, was inadequate.

+cursor-fix.patch

 Fix rivafb build.

+nbd-rmmod-oops-fix.patch

 NBD rmmod oops fix

+tulip-printk-cleanup.patch

 tulip printk cleanup

+parport-01-move-exports.patch

 parport: move exports

+parport-02-use-module_init.patch

 parport: use module_init() for low-level driver init

+parport-03-sysctls-use-module_init.patch

 parport: use module_init() for sysctl registration

+parport-04-move-option-parsing.patch

 parport: move parport_pc option parsing

+parport-irq-warning-fix.patch

 parport warning fixes

+parport-05-parport_pc_probe_port-fixes.patch

 parport: sanitize parport_pc_probe_port()

+parport-06-refcounting-fixes.patch

 parport: refcounting fixes

+parport-07-unregister-fixes.patch

 parport: parport_unregister_port() splitups abd fixes

+parport-08-parport_announce-cleanups.patch

 parport: parport_announce_port() cleanup

+parport-09-track-used-ports.patch

 parport: parport_pc(): keep track of ports

+parport-10-sunbpp-track-ports.patch

 parport: parport_sunbpp(): keep track of ports

+parport-11-remove-parport_enumerate.patch

 parport: remove parport_enumerate()

+parport-12-driver-list-cleanup.patch

 parport: use list.h for driver list

+sysctl-nlen-check.patch

 add range checking to sys_sysctl()

+dm-crypt-cryptoloop-docco.patch

 Kconfig help: dm-crypto && cryptoloop

+nbd-set_capacity-fix.patch

 nbd: fix set_capacity call

+nbd-cleanups.patch

 nbd: remove PARANOIA and other cleanups

+sysv-ipc-cond_syscall-cleanup.patch

 cleanup condsyscall for sysv ipc

+hitachi-scsi_devinfo-fix.patch

 Add Hitachi 9960 Storage on SCSI devlist as BLIST_SPARSELUN|BLIST_LARGELUN

+ipmi-warning-fixes.patch

 IPMI warning fixes

+mtrr-init-section-fixes.patch

 mtrr: init section usage

+dm-crypt-cipher-digest.patch

 dm-crypt: add digest-based iv generation mode

+superblock-fixes.patch

 super block fixes

+CodingStyle-fixes.patch

 Fixes to CodingStyle

+ia32e-GDT-fix.patch

 Another x86-64 fix for problems from the recent merge

+zoran-refcounting-fixes.patch

 fix module reference counting in zoran driver

+ext3-schedule-inside-lock-fix.patch

 ext3: fix scheduling-in-spinlock bug

+dgrs-uninitialised-var-fix.patch

 dgrs: fix use of uninitialised local variable

+nfs-mount-error-recovery.patch

 nfs mount-time oops fixes

+selinux-inode-race-trap.patch

 Try to diagnose Bug 2153

+ext3-dirty-debug-patch.patch

 ext3 debug patch

+NGROUPS_MAX-sysctl.patch

 Report NGROUPS_MAX via a sysctl (read-only)

+ia64-check_pgt_cache-warning-fix.patch

 ia64: fix sched.c compile warning

-zap_low_mappings-fix.patch
-4g4g-kill-noisy-printk.patch

 Folded into the main 4g/4g patch




All 183 patches:


linus.patch

mips-megapatch.patch
  MIPS mega-patch

bk-netdev.patch

bk-input.patch

bk-acpi.patch

bk-pci.patch

bk-i2c.patch

bk-driver-core.patch

bk-ieee1394.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

input-2wheel-mouse-fix.patch
  input: 2-wheel mouse fix

input-2wheel-mouse-fix-fix.patch
  From: Adrian Bunk <bunk@fs.tum.de>
  Subject: [patch] 2.6.2-mm1: fix warning introduced by input-2wheel-mouse-fix

dmapool-needs-pci.patch
  dmapool needs CONFIG_PCI

acpi-utils-warning-fix.patch
  acpi/utils.c warning fix

acpi-sleep-warning-fix.patch
  drivers/acpi/sleep/proc.c warnings

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

psmouse-drop-timed-out-bytes.patch
  psmouse: log and discard timed out bytes

ppc64-tulip-build-fix.patch
  ppc64: fix de4x5 build

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

support-zillions-of-scsi-disks.patch
  support many SCSI disks

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

CONFIG_SYSFS.patch
  From: Pat Mochel <mochel@osdl.org>
  Subject: [PATCH] Add CONFIG_SYSFS

CONFIG_SYSFS-boot-from-disk-fix.patch

slab-leak-detector.patch
  slab leak detector

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

sched-clock-fixes.patch
  fix sched_clock()

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

sched-domain-tweak.patch
  i386-sched-domain code consolidation

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

sched-group-power-warning-fixes.patch
  sched-group-power warning fixes

sched-domains-use-cpu_possible_map.patch
  sched_domains: use cpu_possible_map

ppc64-cpu_vm_mask-fix.patch
  ppc64: cpu_vm_mask fix

ide-siimage-seagate.patch

ide-ali-UDMA6-support.patch
  IDE: Add support of UDMA6 on ALi rev > 0xc4

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

laptop-mode-2.patch
  laptop-mode for 2.6, version 6
  Documentation/laptop-mode.txt
  laptop-mode documentation updates
  Laptop mode documentation addition

laptop-mode-2-tweaks.patch

laptop-mode-simplification.patch
  laptop mode simplification

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

drm-include-fix.patch

process-migration-speedup.patch
  Reduce TLB flushing during process migration

hotplugcpu-generalise-bogolock.patch
  Atomic Hotplug CPU: Generalize Bogolock

hotplugcpu-generalise-bogolock-fix-for-kthread-stop-using-signals.patch

hotplugcpu-use-bogolock-in-modules.patch
  Atomic Hotplug CPU: Use Bogolock in module.c

hotplugcpu-core.patch
  Atomic Hotplug CPU: Hotplug CPU Core

hotplugcpu-core-fix-for-kthread-stop-using-signals.patch

migrate_to_cpu-dependency-fix.patch
  migrate_to_cpu() dependency fix

hotplugcpu-core-drain_local_pages-fix.patch
  split drain_local_pages

hotplugcpu-rcupdate-many-cpus-fix.patch
  CPU hotplug, rcupdate high NR_CPUS fix

serial-02-fixups.patch
  serial fixups (untested)
  serial-02 fixes
  serial-02 fixes

serial-03-fixups.patch
  more serial driver fixups
  serial-03 fixes
  serial-03 fixes

nfs-31-attr.patch
  NFSv2/v3/v4: New attribute revalidation code

blk_congestion_wait-return-remaining.patch
  return remaining jiffies from blk_congestion_wait()

vmscan-remove-priority.patch
  mm/vmscan.c: remove unused priority argument.

kswapd-throttling-fixes.patch
  kswapd throttling fixes

vm-dont-rotate-active-list.patch
  vmscan: avoid rotation of the active list

vm-dont-rotate-active-list-padding.patch
  vmscan: align scan_page per node

vm-lru-info.patch
  vmscan: make better use of referenced info

vm-shrink-zone.patch
  vmscan: several tuneups

vm-shrink-zone-div-by-0-fix.patch

vm-tune-throttle.patch
  vmscan: delay throttling a little

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

sleep_on-needs_lock_kernel.patch
  sleep_on(): check for lock_kernel

i830-agp-pm-fix.patch
  Intel i830 AGP fix

x86_64-make-xconfig-fix.patch
  Fix make xconfig on /lib64 systems

nfs-server-in-root_server_path.patch
  Pull NFS server address out of root_server_path

compat-signal-noarch-2004-01-29.patch
  Generic 32-bit compat for copy_siginfo_to_user

compat-signal-ppc64-2004-01-29.patch

compat-signal-ia64-2004-01-29.patch

compat-generic-ipc-emulation.patch
  generic 32 bit emulation for System-V IPC

compat-generic-ipc-emulation-s390.patch
  use generic IPC emulation on s390

compat-generic-ipc-emulation-x86_64.patch
  use generic IPC emulation on x86_64

compat-generic-ipc-emulation-ia64.patch
  common ipc compat syscalls: ia64

nfs-d_drop-lowmem.patch
  NFS: handle nfs_fhget() error

initramfs-kinit_command.patch
  initramfs: look for /sbin/init

centaur-crypto-core-support.patch
  First steps toward VIA crypto support

adaptive-lazy-readahead.patch
  adaptive lazy readahead

add-syscalls_h-shmat-fix.patch
  fix shmat

add-syscalls_h.patch
  add syscalls.h

add-syscalls_h-fixes.patch

add-syscalls-update.patch
  syscalls.h update1

add-syscalls_h-3.patch
  more syscalls.h stuff

add-syscalls_h-4.patch
  syscalls.h fixes

add-syscalls_h-6.patch
  syscalls.h (updates # 6)

add-syscalls_h-7.patch
  syscalls update ver. 7

add-syscalls_h-8.patch
  syscalls update #8

add-syscalls_h-9.patch
  syscalls.h update #9 (open/close)

add-syscalls_h-10.patch
  syscalls.h #10

add_syscalls-compat-ipc-fix.patch
  fix compat-ipc code for syscalls.h

add-syscalls_h-x86_64-unistd-warning-fix.patch
  syscalls.h: x86_64 warning fix

add-syscalls_h-kinit.patch

stop_machine-warning-fix.patch

nfs-avoid-i_size_write.patch
  NFS: avoid unlocked i_size_write()

alsa-vx_core-locking-fix.patch
  alsa/vx_core locking fix

ext3-journalled-quotas.patch
  ext3: Journalled quotas

ext3-journalled-quotas-warning-fix.patch

ext3-journalled-quotas-cleanups.patch

dynamic-pty-allocation.patch
  dynamic pty allocation

sysfs_remove_dir-race-fix.patch
  sysfs_remove_dir-vs-dcache_readdir race fix

sysfs_remove_subdir-dentry-leak-fix.patch
  Fix dentry refcounting in sysfs_remove_group()

fbdev-cursor-1.patch
  fbdev cursor part 1.

cursor-fix.patch
  cursor fix.

expanded-pci-config-space.patch
  Expanded PCI config space

per-node-rss-tracking.patch
  Track per-node RSS for NUMA

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

futex_wait-debug.patch
  futex_wait debug

module_exit-deadlock-fix.patch
  module unload deadlock fix

nbd-rmmod-oops-fix.patch
  NBD rmmod oops fix

tulip-printk-cleanup.patch
  tulip printk cleanup

parport-01-move-exports.patch
  parport: move exports

parport-02-use-module_init.patch
  parport: use module_init() for low-level driver init

parport-03-sysctls-use-module_init.patch
  parport: use module_init() for sysctl registration

parport-04-move-option-parsing.patch
  parport: move parport_pc option parsing

parport-irq-warning-fix.patch
  parport warning fixes

parport-05-parport_pc_probe_port-fixes.patch
  parport: sanitize parport_pc_probe_port()

parport-06-refcounting-fixes.patch
  parport: refcounting fixes

parport-07-unregister-fixes.patch
  parport: parport_unregister_port() splitups abd fixes

parport-08-parport_announce-cleanups.patch
  parport: parport_announce_port() cleanup

parport-09-track-used-ports.patch
  parport: parport_pc(): keep track of ports

parport-10-sunbpp-track-ports.patch
  parport: parport_sunbpp(): keep track of ports

parport-11-remove-parport_enumerate.patch
  parport: remove parport_enumerate()

parport-12-driver-list-cleanup.patch
  parport: use list.h for driver list

sysctl-nlen-check.patch
  add range checking to sys_sysctl()

dm-crypt-cryptoloop-docco.patch
  Kconfig help: dm-crypto && cryptoloop

nbd-set_capacity-fix.patch
  nbd: fix set_capacity call

nbd-cleanups.patch
  nbd: remove PARANOIA and other cleanups

sysv-ipc-cond_syscall-cleanup.patch
  cleanup condsyscall for sysv ipc

hitachi-scsi_devinfo-fix.patch
  Add Hitachi 9960 Storage on SCSI devlist as BLIST_SPARSELUN|BLIST_LARGELUN

ipmi-warning-fixes.patch
  IPMI warning fixes

mtrr-init-section-fixes.patch
  mtrr: init section usage

dm-crypt-cipher-digest.patch
  dm-crypt: add digest-based iv generation mode

superblock-fixes.patch
  super block fixes

CodingStyle-fixes.patch
  Fixes to CodingStyle

ia32e-GDT-fix.patch
  Another x86-64 fix for problems from the recent merge

zoran-refcounting-fixes.patch
  fix module reference counting in zoran driver

ext3-schedule-inside-lock-fix.patch
  ext3: fix scheduling-in-spinlock bug

dgrs-uninitialised-var-fix.patch
  dgrs: fix use of uninitialised local variable

nfs-mount-error-recovery.patch
  nfs mount-time oops fixes

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

ext3-dirty-debug-patch.patch
  ext3 debug patch

NGROUPS_MAX-sysctl.patch
  Report NGROUPS_MAX via a sysctl (read-only)

ia64-check_pgt_cache-warning-fix.patch
  ia64: fix sched.c compile warning

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

ia64-lockmeter-fix.patch

lockmeter-2.2-cruft.patch
  lockmeter.h: remove kernel 2.2 #ifdef (i386 + alpha)

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
  4G/4G might_sleep warning fix
  4g/4g pagetable accounting fix
  Fix 4G/4G and WP test lockup
  4G/4G KERNEL_DS usercopy again
  Fix 4G/4G X11/vm86 oops
  Fix 4G/4G athlon triplefault
  4g4g SEP fix
  Fix 4G/4G split fix for pre-pentiumII machines
  4g/4g PAE ACPI low mappings fix
  zap_low_mappings() cannot be __init
  4g/4g: remove printk at boot

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

ppc-fixes.patch
  make mm4 compile on ppc

O_DIRECT-race-fixes-rollup.patch
  O_DIRECT data exposure fixes

O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
  Fix race between ll_rw_block() and block_write_full_page()

blockdev-direct-io-speedup.patch
  blockdev direct-io speedups

O_DIRECT-vs-buffered-fix.patch
  Fix O_DIRECT-vs-buffered data exposure bug

dio-aio-fixes.patch
  direct-io AIO fixes

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix



