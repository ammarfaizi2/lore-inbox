Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbUBZC5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbUBZC5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:57:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:24996 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262616AbUBZCzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:55:09 -0500
Date: Wed, 25 Feb 2004 18:55:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3-mm4
Message-Id: <20040225185536.57b56716.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm4/

- Big knfsd update.  Mainly for nfsv4

- DVB udpate

- Various fixes




Changes since 2.6.3-mm3:


 linus.patch
 bk-alsa.patch
 bk-netdev.patch
 bk-input.patch
 bk-pci.patch
 bk-i2c.patch
 bk-driver-core.patch

 External trees, latest versions thereof

-acpi-utils-warning-fix.patch
-acpi-sleep-warning-fix.patch
-ppc64-remove-dump_regs.patch
-ppc64-lmbpatch.patch
-ppc64-flushfix.patch
-ppc64-duplicate_prototype.patch
-ppc64-promfix.patch
-ppc64-log-eeh-errors.patch
-ppc64-log-rtas-error.patch
-ppc64-CROSS32-env-2.6.1.patch
-ppc64-linux-2.5.archhelp.patch
-ppc64-oops-flags.patch
-ppc64-debug-stack-usage.patch
-ppc64-funit-at-a-time.patch
-ppc64-970fx.patch
-ppc64-rtas_token.patch
-ppc64-vio-header.patch
-ppc64-upfix.patch
-ppc64-saved-command-line.patch
-ppc64-cpu-spinup-fixes.patch
-ppc64-smp-message-pass.patch
-ppc64-rtasd_cleanup.patch
-ppc64-stackoverflow.patch
-ppc64-remove-get-user.patch
-ppc64-cpus-in-sysfs.patch
-ppc64-stab-static.patch
-ppc64-stab-optimise.patch
-ppc64-irq_per_cpu.patch
-ppc64-iseries-makefile.patch
-ppc64-get_SP.patch
-ppc64-prom-interrupts.patch
-ppc64-fix-numa-on-non-numa.patch
-ppc64-oops-formatting-cleanups.patch
-ppc64-restore-cpu-names.patch
-serial-02-fixups.patch
-serial-02-fixups-fixes.patch
-serial-03-fixups.patch
-i830-agp-pm-fix.patch
-x86_64-make-xconfig-fix.patch
-add-syscalls_h-shmat-fix.patch
-add-syscalls_h.patch
-dynamic-pty-allocation.patch
-nbd-rmmod-oops-fix.patch
-m68k-391.patch
-m68k-392.patch
-m68k-393.patch
-m68k-394.patch
-m68k-395.patch
-m68k-396.patch
-m68k-397.patch
-m68k-398.patch
-m68k-399.patch
-m68k-400.patch
-m68k-401.patch
-m68k-402.patch
-m68k-403.patch
-m68k-404.patch
-m68k-405.patch
-m68k-406.patch
-m68k-408.patch
-m68k-409.patch
-m68k-411.patch
-m68k-412.patch
-m68k-413.patch
-m68k-414.patch
-m68k-415.patch
-sysctl-nlen-check.patch
-dm-crypt-cryptoloop-docco.patch
-nbd-set_capacity-fix.patch
-nbd-cleanups.patch
-sysv-ipc-cond_syscall-cleanup.patch
-ipmi-warning-fixes.patch
-mtrr-init-section-fixes.patch
-CodingStyle-fixes.patch
-ia32e-GDT-fix.patch
-ext3-schedule-inside-lock-fix.patch
-dgrs-uninitialised-var-fix.patch
-NGROUPS_MAX-sysctl.patch
-ia64-check_pgt_cache-warning-fix.patch
-security-oops-fix.patch
-resource-allocation-reporting-fix.patch
-pci_request_regions-printk-fix.patch
-introduce-bus_bridge_ctl-member.patch
-alder-insert_resource-fix.patch
-alder-io_apic-quirk.patch
-janitor-jffs-checks.patch
-video-use-min-max.patch
-telephony-min-max-fix.patch
-ISDN-v110-fix.patch
-efi-warning-fixes.patch
-remove-x86-THREAD_SIZE-assumptions.patch
-x86-printk-fix.patch
-x86_64-naming-fix.patch
-powernow-frequency-handling-fix.patch
-require-make-3-79-1.patch
-i2c-with-debug-oops-fix.patch

 Merged

+nfsd-NGROUPS-fixes.patch

 Missing nfsd bits from the larger-NGROUPS merge

+dma_sync_for_device-cpu.patch

 Experimental dma mapping API change from davem

-compat-signal-noarch-2004-01-29.patch
-compat-signal-ppc64-2004-01-29.patch
-compat-signal-ia64-2004-01-29.patch
+compat-signal-noarch-2004-01-29.patch

 Rolled up

-compat-generic-ipc-emulation.patch
-compat-generic-ipc-emulation-s390.patch
-compat-generic-ipc-emulation-x86_64.patch
-compat-generic-ipc-emulation-ia64.patch
-add_syscalls-compat-ipc-fix.patch
-compat-ipc-syscalls-fixes.patch
+compat-generic-ipc-emulation.patch

 Rolled up

+kill-old-dead-netdev-apis.patch

 Remvoe old netdev APIs

+gcc-35-pdaudiocf_irq-build-fix.patch

 build fix

-input-2wheel-mouse-fix-fix.patch

 Folded into input-2wheel-mouse-fix.patch

-dmapool-needs-pci.patch

 Dropped.

+bk-driver-core-x86_64-build-fix.patch

 Fix x86_64 build for bk-input-core.patch

+kgdb-ga-recent-gcc-fix.patch

 Fix kgdb for current gcc

+kgdb-THREAD_SIZE-fixes.patch

 Don't assume 8k stacks

-psmouse-drop-timed-out-bytes.patch

 Dropped, was fixed by other means

+move-scatterwalk-functions-to-own-file.patch
+in-place-encryption-fix.patch

 Crypto cleanups and highmem fixes

+knfsd-rpcsec_gss-minimal-support.patch
+knfsd-rpcsec_gss-minimal-support-NGROUPS-fix.patch
+knfsd-rpcsec_gss-minimal-support-NGROUPS-fix-2.patch
+knfsd-gss-api-integrity-checking.patch
+knfsd-IDmap-support.patch
+knfsd-nfs4-pointer-cleanup.patch
+knfsd-nfs4-locking-state-fix.patch
+knfsd-v4-exclusive-open-fix.patch
+knfsd-changeinfo-time-higher-resolution.patch
+knfsd-shareowner-fix.patch
+knfsd-replaying-fixes.patch
+knfsd-setclientid-fix.patch
+knfsd-lockowner-fix.patch
+knfsd-readdir-error-code-fix.patch
+knfsd-nfserr_nofilehandle-fix.patch
+knfsd-lookup_parent-fix.patch
+knfsd-error-code-return-fixes.patch
+knfsd-xdr-error-fix.patch
+knfsd-symlink-fixes.patch
+knfsd-lock-length-fix.patch
+knfsd-rename-error-code-fixes.patch
+knfsd-unlock-on-close-fix.patch
+knfsd-comment-fix.patch
+knfsd-fh_dup2-fix.patch
+knfsd-implement-RELEASE_LOCKOWNER.patch
+knfsd-add-OP_ILLEGAL.patch
+knfsd-OP_CREATE-fix.patch
+knfsd-OP_LOCK-check.patch
+knfsd-OP_OPEN_CONFIRM-fix.patch
+knfsd-open_downgrade-enforcement.patch
+knfsd-readlink-error-return-fix.patch
+knfsd-nfsd4_remove-error-fix.patch
+knfsd-stateid-replay-fixes.patch
+knfsd-attribute-decoding-retval-fix.patch
+knfsd-READ_BUF-cleanup.patch
+knfsd-sunrpc_init-ordering-fixes.patch
+knfsd-readdir-more-than-one-page.patch

 knfsd update

-laptop-mode-2-tweaks.patch
-laptop-mode-simplification.patch

 Folded into laptop-mode-2.patch

+hotplugcpu-core-sparc64-build-fix.patch

 Fix sparc64 build

-vm-dont-rotate-active-list-padding.patch

 Folded into vm-dont-rotate-active-list.patch

-vm-shrink-zone-div-by-0-fix.patch

 Folded into vm-shrink-zone.patch

-dm-01-endio-method.patch
-dm-02-remove-v1-ioctl-interface.patch
-dm-02-compat_ioctl-fix.patch
-dm-03-list_for_each_entry-audit.patch
-dm-04-default-queue-limits-fix.patch
-dm-05-list-targets-command.patch
-dm-06-multipath-target.patch

 The device mapper update is being updated

+s390-syscalls-h-update.patch

 Teach the s390 pathches about syscalls.h

-remove-LDFLAGS_BLOB.patch

 Dropped

+time-interpolator-fix.patch

 Timekeeping accuracy fix

+dvb-01-update-subsystem-docs.patch
+dvb-02-update-saa7146-core.patch
+dvb-03-skystar2-updates.patch
+dvb-04-core-updates.patch
+dvb-05-frontend-updates.patch
+dvb-06-stv0299-frontend-update.patch
+dvb-07-tda1004x-update.patch
+dvb-08-av7110-update.patch
+dvb-09-ttusb-budget-update.patch
+dvb-ttusb-budget-compile-fix.patch

 DVB update

+kmsg-nonblock.patch

 Honour O_NONBLOCK on /proc/kmsg

+n_tty-cleanup.patch

 Code cleanup

+mixart-build-fix.patch

 ALS build fix

+add-a-slab-for-ethernet.patch

 Add a kmalloc slab for 1536-byte skbuffs

+mac-driver-config-update.patch

 Macintosh Kconfig update

+request_firmware-01-class-fixes.patch
+request_firmware-02-more-class-fixes.patch
+request_firmware-03-bitmap.patch
+request_firmware-04-priv-leak-fix.patch
+request_firmware-05-release-race-fixes.patch
+request_firmware-06-cleanups.patch
+request_firmware-07-attribute-fixes.patch

 Firmware loader updates

+early-printk-doc-fix.patch

 Documentation fix

+radeon-config-fix-2.patch

 Compile fix

+remove-tty-CALLOUT-defines.patch

 Clean up dead code

+tdfx-remove-float.patch

 Kill gratuitous floating point

+mtd-locking-fix.patch

 Remember the spin_unlock

+remove-KERNEL_SYSCALLS-stuff.patch

 Clean up __KERNEL_SYSCALLS usage

+msi-kirqd-build-fix.patch

 Compile fix

+afs-c99-fix.patch
+isdn-c99-fixes.patch
+airo-c99-fixes.patch
+wanxl-c99-fixes.patch
+pci200syn-c99-fixes.patch
+irda-usb-c99-fixes.patch
+saa7146_video-c99-fixes.patch
+stv0229-c99-fixes.patch
+alps_tdlb7-c99-fixes.patch
+sp887x-c99-fixes.patch
+budget-av-c99-fixes.patch

 C99 struct initialiser fixups

+saa5246a-rev1-2.6.3.patch

 New teletext decoder driver

+kbuild-add-defconfig-targets-to-make-help.patch

 kbuild featurette

+wanmain-build-fix.patch

 Compile fix

+3c505-build-fix.patch

 Compile fix

+O_DIRECT-vs-buffered-fix-pdflush-hang-fix.patch
+serialise-writeback-fdatawait.patch

 More O_DIRECT-vs-buffered I/O fixups





All 267 patches:


linus.patch

nfsd-NGROUPS-fixes.patch
  knfsd: NGROUPS fixes

bk-alsa.patch

bk-netdev.patch

bk-input.patch

bk-pci.patch

bk-i2c.patch

bk-driver-core.patch

mm.patch
  add -mmN to EXTRAVERSION

dma_sync_for_device-cpu.patch
  dma_sync_for_{cpu,device}()

compat-signal-noarch-2004-01-29.patch
  Generic 32-bit compat for copy_siginfo_to_user

compat-generic-ipc-emulation.patch
  generic 32 bit emulation for System-V IPC

kill-old-dead-netdev-apis.patch
  removal of b0rken netdev API functions

gcc-35-pdaudiocf_irq-build-fix.patch
  Fix pdaudiocf_irq.c for gcc-3.5

m68k-406.patch
  m68k: Amiga Zorro8390 Ethernet new driver model

input-2wheel-mouse-fix.patch
  input: 2-wheel mouse fix

bk-driver-core-x86_64-build-fix.patch
  fix x86_64 build for sys_device_register rename

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

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

kgdb-THREAD_SIZE-fixes.patch
  THREAD_SIZE fixes for kgdb

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-tulip-build-fix.patch
  ppc64: fix de4x5 build

ppc64-reloc_hide.patch

move-scatterwalk-functions-to-own-file.patch
  move scatterwalk functions to own file

in-place-encryption-fix.patch
  fix in-place de/encryption bug with highmem

hfs-rewrite.patch

hfsplus-support.patch

knfsd-rpcsec_gss-minimal-support.patch
  kNFSd: Add minimal server-side support for rpcsec_gss.

knfsd-rpcsec_gss-minimal-support-NGROUPS-fix.patch
  Fix up knfsd-rpcsec_gss-minimal-support-NGROUPS for expanded NGROUPS

knfsd-rpcsec_gss-minimal-support-NGROUPS-fix-2.patch
  more svcauth_gss fixes

knfsd-gss-api-integrity-checking.patch
  kNFSd: gss api changes for integrity checking.

knfsd-IDmap-support.patch
  kNFSd: IDmap support for the NFSv4 server.

knfsd-nfs4-pointer-cleanup.patch
  kNFSd: Nfsdv4 pointer cleanup

knfsd-nfs4-locking-state-fix.patch
  kNFSd: NFSv4 locking state fix

knfsd-v4-exclusive-open-fix.patch
  kNFSd: v4 exclusive open fix.

knfsd-changeinfo-time-higher-resolution.patch
  kNFSd: Use higher-resolution time for the changeinfo, instead of using time and filesize.

knfsd-shareowner-fix.patch
  kNFSd: When looking for a shareowner in the nfsd open, make sure we don't get a lockowner instead.

knfsd-replaying-fixes.patch
  kNFSd: NFSdV4 fixes for replaying open requests.

knfsd-setclientid-fix.patch
  kNFSd: Use only the uid when deciding whether a setclientid is being done with the "same principal".

knfsd-lockowner-fix.patch
  kNFSd: When looking for a shareowner in the nfsd open, make sure we don't get a lockowner instead.

knfsd-readdir-error-code-fix.patch
  kNFSd: readdir error code fix

knfsd-nfserr_nofilehandle-fix.patch
  kNFSd: correctly tests and sets nfserr_nofilehandle for current and save fh.

knfsd-lookup_parent-fix.patch
  kNFSd: Fix for lookup-parent at pseudo root

knfsd-error-code-return-fixes.patch
  kNFSd: Correct error returns.

knfsd-xdr-error-fix.patch
  kNFSd: fixes an xdr error by removing the verifier from error return.

knfsd-symlink-fixes.patch
  kNFSd: correct symlink related error returns.

knfsd-lock-length-fix.patch
  kNFSd: check lock length, return appropriate error

knfsd-rename-error-code-fixes.patch
  kNFSd: correct rename error returns.

knfsd-unlock-on-close-fix.patch
  kNFSd: unlock-on-close fix

knfsd-comment-fix.patch
  kNFSd: Remove a comment that is no longer accurate

knfsd-fh_dup2-fix.patch
  kNFSd: move fh_dup2 and fix it

knfsd-implement-RELEASE_LOCKOWNER.patch
  kNFSd: Implement the nfsv4 RELEASE_LOCKOWNER operation.

knfsd-add-OP_ILLEGAL.patch
  kNFSd: add OP_ILLEGAL, and fix processing of compounds with out of bounds op numbers.

knfsd-OP_CREATE-fix.patch
  kNFSd: fix an error return for OP_CREATE

knfsd-OP_LOCK-check.patch
  kNFSd: Add a check in OP_LOCK for new lockowners to ensure that the open stateid is

knfsd-OP_OPEN_CONFIRM-fix.patch
  kNFSd: Corrects an error return for OP_OPEN_CONFIRM.

knfsd-open_downgrade-enforcement.patch
  kNFSd: Enforce open_downgrade requirement

knfsd-readlink-error-return-fix.patch
  kNFSd: Fix an out-of-spec readlink error return.

knfsd-nfsd4_remove-error-fix.patch
  kNFSd: Fix an out-of-spec error in nfsd4_remove.

knfsd-stateid-replay-fixes.patch
  kNFSd: Miscellaneous fixes to stateid-based replay

knfsd-attribute-decoding-retval-fix.patch
  kNFSd: Fix out-of-spec error return in attribute decoding.

knfsd-READ_BUF-cleanup.patch
  kNFSd: Make the calculation in the first READ_BUF easier to understand.

knfsd-sunrpc_init-ordering-fixes.patch
  kNFSd: make sure sunrpc init routines called before gss init routines.

knfsd-readdir-more-than-one-page.patch
  kNFSd: return more than one page of directory entries.

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

stop_machine-warning-fix.patch

hotplugcpu-core-sparc64-build-fix.patch
  hotplugcpu-core sparc64 build fix

hotplugcpu-core-fix-for-kthread-stop-using-signals.patch

migrate_to_cpu-dependency-fix.patch
  migrate_to_cpu() dependency fix

hotplugcpu-core-drain_local_pages-fix.patch
  split drain_local_pages

hotplugcpu-rcupdate-many-cpus-fix.patch
  CPU hotplug, rcupdate high NR_CPUS fix

nfs-31-attr.patch
  NFSv2/v3/v4: New attribute revalidation code

nfs-reconnect-fix.patch

instrument-highmem-page-reclaim.patch
  vm: per-zone page reclaim instrumentation

blk_congestion_wait-return-remaining.patch
  return remaining jiffies from blk_congestion_wait()

vmscan-remove-priority.patch
  mm/vmscan.c: remove unused priority argument.

kswapd-throttling-fixes.patch
  kswapd throttling fixes

vm-dont-rotate-active-list.patch
  vmscan: avoid rotation of the active list
  vmscan: align scan_page per node

vm-lru-info.patch
  vmscan: make better use of referenced info

vm-shrink-zone.patch
  vmscan: several tuneups

vm-tune-throttle.patch
  vmscan: delay throttling a little

shrink_slab-for-all-zones.patch
  vm: scan slab in response to highmem scanning

zone-balancing-fix.patch
  vmscan: zone balancing fix

zone-balancing-batching.patch
  vmscan: fix inter-zone reclaim balancing
  fix all_zones_ok logic

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

sleep_on-needs_lock_kernel.patch
  sleep_on(): check for lock_kernel

nfs-server-in-root_server_path.patch
  Pull NFS server address out of root_server_path

nfs-d_drop-lowmem.patch
  NFS: handle nfs_fhget() error

initramfs-kinit_command.patch
  initramfs: look for /sbin/init

add-syscalls_h-kinit.patch

centaur-crypto-core-support.patch
  First steps toward VIA crypto support

adaptive-lazy-readahead.patch
  adaptive lazy readahead

nfs-avoid-i_size_write.patch
  NFS: avoid unlocked i_size_write()

ext3-journalled-quotas.patch
  ext3: Journalled quotas

ext3-journalled-quotas-warning-fix.patch

ext3-journalled-quotas-cleanups.patch

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

hitachi-scsi_devinfo-fix.patch
  Add Hitachi 9960 Storage on SCSI devlist as BLIST_SPARSELUN|BLIST_LARGELUN

dm-crypt-cipher-digest.patch
  dm-crypt: add digest-based iv generation mode

superblock-fixes.patch
  super block fixes

zoran-refcounting-fixes.patch
  fix module reference counting in zoran driver

nfs-mount-error-recovery.patch
  nfs mount-time oops fixes

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

ext3-dirty-debug-patch.patch
  ext3 debug patch

ufs2-01.patch
  read-only support for UFS2

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
  s390: zfcp host adapter

s390-syscalls-h-update.patch
  s390 syscalls.h update

s390-dcss-block-driver.patch
  s390: DCSS block device driver.

ide-scsi-error-handling-fixes.patch
  ide-scsi error handling fixes

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

pcmcia-debugging-rework-1.patch
  Overhaul PCMCIA debugging (1)

cs_err-compile-fix.patch
  pcmcia: workaround for gcc-2.95 bug in cs_err()

pcmcia-debugging-rework-2.patch
  Overhaul PCMCIA debugging (2)

distribute-early-allocations-across-nodes.patch
  Manfred's patch to distribute boot allocations across nodes

time-interpolator-fix.patch
  time interpolator fix

dvb-01-update-subsystem-docs.patch
  dvb: Update subsystem docs

dvb-02-update-saa7146-core.patch
  dvb: Update saa7146 driver core

dvb-03-skystar2-updates.patch
  dvb: Minor Skystar2 updates

dvb-04-core-updates.patch
  dvb: core update

dvb-05-frontend-updates.patch
  dvb: Misc frontend updates

dvb-06-stv0299-frontend-update.patch
  dvb: stv0299 DVB frontend update

dvb-07-tda1004x-update.patch
  dvb: tda1004x DVB frontend update

dvb-08-av7110-update.patch
  dvb: av7110 DVB driver update

dvb-09-ttusb-budget-update.patch
  dvb: TTUSB-Budget DVB driver update

dvb-ttusb-budget-compile-fix.patch
  Compilation fix for latest DVB updates

kmsg-nonblock.patch
  teach /proc/kmsg about O_NONBLOCK

n_tty-cleanup.patch
  n_tty.c cleanup

mixart-build-fix.patch
  CONFIG_SND_MIXART doesn't compile

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

mac-driver-config-update.patch
  M68k Macintosh driver config

request_firmware-01-class-fixes.patch
  request_firmware(): misc fixes

request_firmware-02-more-class-fixes.patch
  request_firmware(): more misc fixes

request_firmware-03-bitmap.patch
  request_firmware(): add status bitmap

request_firmware-04-priv-leak-fix.patch
  request_firmware(): fix firmware_priv leak

request_firmware-05-release-race-fixes.patch
  request_firmware():  race fixes

request_firmware-06-cleanups.patch
  request_firmware(): refactor fw_setup_class_device()

request_firmware-07-attribute-fixes.patch
  request_firmware(): fix attribute removal

early-printk-doc-fix.patch
  early printk documentation fix

radeon-config-fix-2.patch
  radeon config fix

remove-tty-CALLOUT-defines.patch
  Remove unused tty CALLOUT defines

tdfx-remove-float.patch
  don't use floating point in tdfxfb

mtd-locking-fix.patch
  mtd locking fix

afs-c99-fix.patch
  C99 patch for fs/afs/inode.c

remove-KERNEL_SYSCALLS-stuff.patch
  Kill bogus __KERNEL_SYSCALLS usage

msi-kirqd-build-fix.patch
  fix MSI-related build breakage

isdn-c99-fixes.patch
  C99 initiailzers for drivers/isdn/i4l/isdn_common.c

airo-c99-fixes.patch
  C99 initializers for drivers/net/wireless/airo.c

wanxl-c99-fixes.patch
  C99 initializers for drivers/net/wan/wanxl.c

pci200syn-c99-fixes.patch
  C99 initializers for drivers/net/wan/pci200syn.c

irda-usb-c99-fixes.patch
  C99 initializers for drivers/net/irda/irda-usb.c

saa7146_video-c99-fixes.patch
  C99 initializers for drivers/media/common/saa7146_video.c

stv0229-c99-fixes.patch
  C99 initializer for drivers/media/dv/frontend/stv0229.c

alps_tdlb7-c99-fixes.patch
  C99 initializers for drivers/media/dvb/frontends/alps_tdlb7.c

sp887x-c99-fixes.patch
  C99 initializers for drivers/media/dvb/frontends/sp887x.c

budget-av-c99-fixes.patch
  C99 initializer for driver/media/dvb/ttpci/budget-av.c

saa5246a-rev1-2.6.3.patch
  V4L: Add new driver for Teletext decoder SAA5246A from Philips

kbuild-add-defconfig-targets-to-make-help.patch
  kbuild: add defconfig targets to make help

wanmain-build-fix.patch
  wanmain.c build fix

3c505-build-fix.patch
  3c505.c needs delay.h

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

O_DIRECT-vs-buffered-fix-pdflush-hang-fix.patch
  pdflush hang fix

serialise-writeback-fdatawait.patch
  serialize_writeback_fdatawait patch

dio-aio-fixes.patch
  direct-io AIO fixes

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix



