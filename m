Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbUBWBV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 20:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbUBWBV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 20:21:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:36486 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261307AbUBWBVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 20:21:17 -0500
Date: Sun, 22 Feb 2004 17:22:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3-mm3
Message-Id: <20040222172200.1d6bdfae.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm2/


- Added Roman's HFS rewrite and HFS+ filesystem implementation

- Device Mapper update.  This adds support for a multipath target and seems
  fairly significant.

- Big s390 update.  This includes rework against net devices, block devices
  and sysfs interfaces.   Please Cc Martin Schwidefsky on review comments ;)

- A fairly large update to the ide-scsi error handling.  If you use
  ide-scsi, please beat on this.

- A patch to the NFS client which teaches NFS to play nicely with the
  VM/VFS writer throttling framework.  Should improve interactivity
  and overall balancing niceness when performing heavy NFS write activity.

- Some VM work against slab shrinking and interzone balancing.  Relevant
  to highmem machines.

- m68k and ppc64 updates




Changes since 2.6.3-mm2:


 linus.patch
 bk-alsa.patch
 bk-netdev.patch
 bk-input.patch
 bk-acpi.patch
 bk-i2c.patch
 bk-driver-core.patch
 bk-scsi.patch

 Latest versions of external trees

-mips-megapatch.patch
-alsa-vx_core-locking-fix.patch

 Merged

+ppc64-remove-dump_regs.patch
+ppc64-lmbpatch.patch
+ppc64-flushfix.patch
+ppc64-duplicate_prototype.patch
+ppc64-promfix.patch
+ppc64-log-eeh-errors.patch
+ppc64-log-rtas-error.patch
+ppc64-CROSS32-env-2.6.1.patch
+ppc64-linux-2.5.archhelp.patch
+ppc64-oops-flags.patch
+ppc64-debug-stack-usage.patch
+ppc64-funit-at-a-time.patch
+ppc64-970fx.patch
+ppc64-rtas_token.patch
+ppc64-vio-header.patch
+ppc64-upfix.patch
+ppc64-saved-command-line.patch
+ppc64-cpu-spinup-fixes.patch
+ppc64-smp-message-pass.patch
+ppc64-rtasd_cleanup.patch
+ppc64-stackoverflow.patch
+ppc64-remove-get-user.patch
+ppc64-cpus-in-sysfs.patch
+ppc64-stab-static.patch
+ppc64-stab-optimise.patch
+ppc64-irq_per_cpu.patch
+ppc64-iseries-makefile.patch
+ppc64-get_SP.patch
+ppc64-prom-interrupts.patch
+ppc64-fix-numa-on-non-numa.patch
+ppc64-oops-formatting-cleanups.patch
+ppc64-restore-cpu-names.patch

 PPC64 fixes/updates

+hfs-rewrite.patch

 Big HFS filesystem rewrite

+hfsplus-support.patch

 HFS+ filesystem

+add-MODULE_VERSION-macro.patch

 Add the MODULE_VERSION macro: expose the version of a module in sysfs.

+rename-MODULE_VERSION.patch

 Fix it.

+serial-02-fixups-fixes.patch

 Touchup for serial-02-fixups.patch

+nfs-reconnect-fix.patch

 Fix an NFS stale handle problem

+instrument-highmem-page-reclaim.patch

 Split /proc/vmstats:pgsteal into pgsteal_hi and pgsteal_lo.  To measure
 highmem reclaim rates and lowmem reclaim rates separately.

+shrink_slab-for-all-zones.patch

 Shrink slab in response to reclaim pressure against any zone.

+zone-balancing-fix.patch
+zone-balancing-batching.patch

 Fix up the inter-zone reclaim balancing

-add-syscalls_h-shmat-fix.patch
-add-syscalls_h.patch
-add-syscalls_h-fixes.patch
-add-syscalls-update.patch
-add-syscalls_h-3.patch
-add-syscalls_h-4.patch
-add-syscalls_h-6.patch
-add-syscalls_h-7.patch
-add-syscalls_h-8.patch
-add-syscalls_h-9.patch
-add-syscalls_h-10.patch
-add_syscalls-compat-ipc-fix.patch
-add-syscalls_h-x86_64-unistd-warning-fix.patch
-add-syscalls_h-kinit.patch

 Folded into add-syscalls_h.patch

+add_syscalls-compat-ipc-fix.patch

 Fix up the generic ipc/compat code

+compat-ipc-syscalls-fixes.patch

 Teach the generic ipc/compat code about syscalls.h

+add-syscalls_h-kinit.patch

 Teach initramfs-kinit_command.patch about syscalls.h

+parport-09-track-used-ports-fix.patch

 Build fix for parport-09-track-used-ports.patch

+m68k-391.patch
+m68k-392.patch
+m68k-393.patch
+m68k-394.patch
+m68k-395.patch
+m68k-396.patch
+m68k-397.patch
+m68k-398.patch
+m68k-399.patch
+m68k-400.patch
+m68k-401.patch
+m68k-402.patch
+m68k-403.patch
+m68k-404.patch
+m68k-405.patch
+m68k-406.patch
+m68k-408.patch
+m68k-409.patch
+m68k-411.patch
+m68k-412.patch
+m68k-413.patch
+m68k-414.patch
+m68k-415.patch

 m68k update

+security-oops-fix.patch

 Fix an oops in the selinux code

+resource-allocation-reporting-fix.patch

 Sanify some error messages

+pci_request_regions-printk-fix.patch

 Ditto

+introduce-bus_bridge_ctl-member.patch

 'This patch introduces the "bridge_ctl" member of pci_bus, which allows
  architectures to tweak the bridge control register (eg, for setting fast
  back to back modes etc) in pcibios_fixup_bus().'

+ufs2-01.patch

 Read-only support for the UFS2 filesystem

+dm-01-endio-method.patch
+dm-02-remove-v1-ioctl-interface.patch
+dm-02-compat_ioctl-fix.patch
+dm-03-list_for_each_entry-audit.patch
+dm-04-default-queue-limits-fix.patch
+dm-05-list-targets-command.patch
+dm-06-multipath-target.patch

 Device Mapper update

+s390-01-general-update.patch
+s390-02-common-io-layer.patch
+s390-03-console-driver.patch
+s390-04-compat_timer_settime.patch
+s390-05-ctc-net-driver.patch
+s390-06-lcs-net-driver.patch
+s390-07-iucv-net-driver.patch
+s390-08-dasd-driver.patch
+s390-09-virtual-timer-interface.patch
+s390-10-zvm-monitor-stream.patch
+s390-11-collaborative-memory-management.patch
+s390-12-cannel-measurement-block-interface.patch
+s390-zfcp-host-adapter.patch
+s390-dcss-block-driver.patch

 s390 updates

+alder-insert_resource-fix.patch
+alder-io_apic-quirk.patch

 Fixes for the Intel Alder motherboard

+janitor-jffs-checks.patch

 Handle ooms.

+video-use-min-max.patch
+telephony-min-max-fix.patch

 nuke some private min()and max() implementations

+ide-scsi-error-handling-fixes.patch

 ide-scsi error handling fixes

+ISDN-v110-fix.patch

 V.110 fix

+fb_console_init-fix.patch

 Prevent fb_console_init from being called twice.

+nfs-write-throttling.patch

 Integrate the NFS client into the VM/VFSwrite throttling framework.

+poll-select-longer-timeouts.patch
+poll-select-range-check-fix.patch
+poll-select-handle-large-timeouts.patch

 poll/select time interval fixes/improvements

+zwane-is-floppy-maintainer-now.patch

 Fix a floppy oops

+ide-io-CONFIG_LBD-fix.patch

 Fix IDE for CONFIG_LBD

+efi-warning-fixes.patch

 Fix some warnings

+remove-x86-THREAD_SIZE-assumptions.patch

 Remove hard-coded assumptions about 8k stacks

+x86-printk-fix.patch

 Fix a printk

+pcmcia-debugging-rework-1.patch
+cs_err-compile-fix.patch
+pcmcia-debugging-rework-2.patch

 Rework the PCMCIA debugging code

+remove-LDFLAGS_BLOB.patch

 hm, this shouldn't be here.

+distribute-early-allocations-across-nodes.patch

 Distribute the early-in-boot memory allocations across nodes on NUMA
 machines.

+x86_64-naming-fix.patch

 Get the naming of the ia32e CPUs right

+powernow-frequency-handling-fix.patch

 Fix powernow-k8 cpufreq driver

+require-make-3-79-1.patch

 Old versions of make are segfaulting.  We require 2.79.1 or later.

+i2c-with-debug-oops-fix.patch

 Fix an oops in the i2s drivers when debug is enabled

+4g4g-THREAD_SIZE-fixes.patch

 Remove a "stack is 8k" assumption from the 4g/4g patch






All 290 patches

linus.patch

bk-alsa.patch

bk-netdev.patch

bk-input.patch

bk-acpi.patch

bk-i2c.patch

bk-driver-core.patch

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

ppc64-remove-dump_regs.patch
  ppc64: remove dump_regs

ppc64-lmbpatch.patch
  [ppc64] cleanup lmb code

ppc64-flushfix.patch
  ppc64: Potentially avoid an atomic operation in switch_mm.

ppc64-duplicate_prototype.patch
  ppc64: Remove duplicate pcibios_scan_all_fns definition

ppc64-promfix.patch
  ppc64: Fix for ppc64 SMT enablement bug provided by Jimi Xenidis and Michael Day

ppc64-log-eeh-errors.patch
  ppc64: add rtas slot-error-detail information

ppc64-log-rtas-error.patch

ppc64-CROSS32-env-2.6.1.patch
  Allow CROSS32_COMPILE to be set via environment variable

ppc64-linux-2.5.archhelp.patch
  ppc64: Add a ppc64 archhelp.

ppc64-oops-flags.patch
  ppc64: print useful flags in oops, like x86

ppc64-debug-stack-usage.patch
  ppc64: Add DEBUG_STACK_USAGE

ppc64-funit-at-a-time.patch
  ppc64: Add -funit-at-a-time

ppc64-970fx.patch
  Add 970FX entry into the cputable.

ppc64-rtas_token.patch
  ppc64: Fix for valid nvram rtas tokens.

ppc64-vio-header.patch
  fix naming collision with asm-ppc64/vio.h

ppc64-upfix.patch
  ppc64: fix warning and compile error without CONFIG_SMP

ppc64-saved-command-line.patch
  ppc64: fix cmd_line bugs

ppc64-cpu-spinup-fixes.patch
  ppc64 cpu spinup fixes

ppc64-smp-message-pass.patch
  ppc64: remove useless smp_message_pass args

ppc64-rtasd_cleanup.patch
  ppc64: This cleans up the rtasd logic, and also makes it hotplug CPU safe.

ppc64-stackoverflow.patch
  ppc64: Add stack overflow debugging

ppc64-remove-get-user.patch
  ppc64: remove get_users in backtrace code

ppc64-cpus-in-sysfs.patch
  Add cpus and NUMA memory nodes to sysfs. Also add cpu physical id.

ppc64-stab-static.patch
  ppc64: Make a number of segment table functions static.

ppc64-stab-optimise.patch
  ppc64: Clean up per cpu usage in segment table code.

ppc64-irq_per_cpu.patch
  ppc64: PER_CPU irq optimisations

ppc64-iseries-makefile.patch
  ppc64: don't link some non iSeries stuff

ppc64-get_SP.patch
  ppc64: Fix __get_SP()

ppc64-prom-interrupts.patch
  ppc64: set err to -ENODEV when a new node doesn't have "interrupt" property.

ppc64-fix-numa-on-non-numa.patch
  fix for NUMA kernel on non NUMA machine

ppc64-oops-formatting-cleanups.patch
  trivial oops formatting cleanups

ppc64-restore-cpu-names.patch
  ppc64: restore cpu names

ppc64-tulip-build-fix.patch
  ppc64: fix de4x5 build

ppc64-reloc_hide.patch

hfs-rewrite.patch

hfsplus-support.patch

add-MODULE_VERSION-macro.patch
  Add a MODULE_VERSION macro

rename-MODULE_VERSION.patch
  rename other MODULE_VERSION users

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

serial-02-fixups-fixes.patch

serial-03-fixups.patch
  more serial driver fixups
  serial-03 fixes
  serial-03 fixes

nfs-31-attr.patch
  NFSv2/v3/v4: New attribute revalidation code

nfs-reconnect-fix.patch

instrument-highmem-page-reclaim.patch
  vm: separate instrumentation for highmem and lowmem page stealing

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

shrink_slab-for-all-zones.patch
  vm: scan slab in response to highmem scanning

zone-balancing-fix.patch
  vmscan: zone balancing fix

zone-balancing-batching.patch
  vmscan: fix inter-zone reclaim balancing

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

add-syscalls_h-shmat-fix.patch
  fix shmat

add-syscalls_h.patch
  add syscalls.h

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

add_syscalls-compat-ipc-fix.patch
  fix compat-ipc code for syscalls.h

compat-ipc-syscalls-fixes.patch
  common ipc compat syscalls fixes

nfs-d_drop-lowmem.patch
  NFS: handle nfs_fhget() error

initramfs-kinit_command.patch
  initramfs: look for /sbin/init

add-syscalls_h-kinit.patch

centaur-crypto-core-support.patch
  First steps toward VIA crypto support

adaptive-lazy-readahead.patch
  adaptive lazy readahead

stop_machine-warning-fix.patch

nfs-avoid-i_size_write.patch
  NFS: avoid unlocked i_size_write()

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

parport-09-track-used-ports-fix.patch

parport-10-sunbpp-track-ports.patch
  parport: parport_sunbpp(): keep track of ports

parport-11-remove-parport_enumerate.patch
  parport: remove parport_enumerate()

parport-12-driver-list-cleanup.patch
  parport: use list.h for driver list

m68k-391.patch
  m68k: offsets.h generation

m68k-392.patch
  m68k: mm init warning

m68k-393.patch
  m68k: Sun-3 console fix

m68k-394.patch
  m68k: Sun-3 LANCE Ethernet

m68k-395.patch
  m68k: Sun-3 missing sbus_readl()

m68k-396.patch
  m68k: Atari name clashes

m68k-397.patch
  m68k: M68k MCA cleanup

m68k-398.patch
  m68k: Atari Pamsnet warning

m68k-399.patch
  m68k: M68k uses drivers/Kconfig

m68k-400.patch
  m68k: Amifb modedb bug

m68k-401.patch
  m68k: M68k configuration

m68k-402.patch
  m68k: arch/m68k/mm/Makefile cleanup

m68k-403.patch
  m68k: Amiga A2065 Ethernet new driver model

m68k-404.patch
  m68k: Amiga Ariadne Ethernet new driver model

m68k-405.patch
  m68k: Amiga Hydra Ethernet new driver model

m68k-406.patch
  m68k: Amiga Zorro8390 Ethernet new driver model

m68k-408.patch
  m68k: M68k module loader

m68k-409.patch
  m68k: M68k call trace output

m68k-411.patch
  m68k: M68k cmpxchg

m68k-412.patch
  m68k: M68k FPU emu broken link

m68k-413.patch
  m68k: Mac IOP spelling

m68k-414.patch
  m68k: Dummy dma mapping

m68k-415.patch
  m68k: M68k core spelling

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

security-oops-fix.patch
  security oops fix

resource-allocation-reporting-fix.patch
  Report meaningful error for failed resource allocation

pci_request_regions-printk-fix.patch
  Don't report pci_request_regions() failure twice

introduce-bus_bridge_ctl-member.patch
  Introduce bus->bridge_ctl member

ufs2-01.patch
  read-only support for UFS2

dm-01-endio-method.patch
  dm: endio method

dm-02-remove-v1-ioctl-interface.patch
  dm: remove v1 ioctl interface

dm-02-compat_ioctl-fix.patch
  fix compat ioctls for DM V1 ioctl removal

dm-03-list_for_each_entry-audit.patch
  dm: list_for_each_entry audit

dm-04-default-queue-limits-fix.patch
  dm: default queue limits

dm-05-list-targets-command.patch
  dm: list targets cmd

dm-06-multipath-target.patch
  dm: multipath target

s390-01-general-update.patch
  s390: general update.

s390-02-common-io-layer.patch
  s390: common i/o layer.

s390-03-console-driver.patch
  s390: console driver.

s390-04-compat_timer_settime.patch
  s390: compat_timer_settime.

s390-05-ctc-net-driver.patch
  s390: CTC network driver.

s390-06-lcs-net-driver.patch
  s390: LCS network driver.

s390-07-iucv-net-driver.patch
  s390: IUCV network driver.

s390-08-dasd-driver.patch
  s390: DASD device driver.

s390-09-virtual-timer-interface.patch
  s390: virtual timer interface.

s390-10-zvm-monitor-stream.patch
  s390: z/VM monitor stream.

s390-11-collaborative-memory-management.patch
  s390: collaborative memory management.

s390-12-cannel-measurement-block-interface.patch
  s390: channel measurement block interface.

s390-zfcp-host-adapter.patch
  From: Martin Schwidefsky <schwidefsky@de.ibm.com>
  Subject: [PATCH] s390 (13/14): zfcp host adapter.

s390-dcss-block-driver.patch
  From: Martin Schwidefsky <schwidefsky@de.ibm.com>
  Subject: [PATCH] s390 (14/14): DCSS block device driver.

alder-insert_resource-fix.patch
  Make insert_resource work for alder IOAPIC resources

alder-io_apic-quirk.patch
  add the Intel Alder IO-APIC PCI device to quirks

janitor-jffs-checks.patch
  From: "Randy.Dunlap" <rddunlap@osdl.org>
  Subject: [janitor] JFFS checks

video-use-min-max.patch
  janitor: media: use kernel min/max

telephony-min-max-fix.patch
  telephony: use kernel min/max

ide-scsi-error-handling-fixes.patch
  ide-scsi error handling fixes

ISDN-v110-fix.patch
  Fix ISDN v.110.

fb_console_init-fix.patch
  fb_console_init fix

nfs-write-throttling.patch
  Add write throttling to NFS client

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

zwane-is-floppy-maintainer-now.patch
  floppy oops fix(?)

ide-io-CONFIG_LBD-fix.patch
  ide-io.c: CONFIG_LBD fix

efi-warning-fixes.patch
  Fix fs/partitions/efi.cprintk warnings

remove-x86-THREAD_SIZE-assumptions.patch
  x86: remove THREAD_SIZE assumption cleanups

x86-printk-fix.patch
  cosmetic printk fix

pcmcia-debugging-rework-1.patch
  Overhaul PCMCIA debugging (1)

cs_err-compile-fix.patch
  pcmcia: workaround for gcc-2.95 bug in cs_err()

pcmcia-debugging-rework-2.patch
  Overhaul PCMCIA debugging (2)

remove-LDFLAGS_BLOB.patch
  Remove LDFLAGS_BLOB

distribute-early-allocations-across-nodes.patch
  Manfred's patch to distribute boot allocations across nodes

x86_64-naming-fix.patch
  better menu label/help for intel x86-64

powernow-frequency-handling-fix.patch
  powernow-k8 frequency handling fix

require-make-3-79-1.patch
  Require GNU Make version 3.79.1 or later

i2c-with-debug-oops-fix.patch
  Another oops in i2c-core with debug

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

4g4g-THREAD_SIZE-fixes.patch

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



