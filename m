Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbUBIJim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 04:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUBIJim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 04:38:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:63443 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264449AbUBIJiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 04:38:04 -0500
Date: Mon, 9 Feb 2004 01:40:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.3-rc1-mm1
Message-Id: <20040209014035.251b26d1.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc1/2.6.3-rc1-mm1/


- NFSD update

- MD update

- Added Randy's include/linux/syscalls.h work, to address a pet peeve.

- Various fixes

- Added early printk for ia32.  It simply does #include "x86_64's version".

- I'll probably drop the CPU hotplug patches next time.  They've been
  tested and they now appear to be obsolete.

- Unless suddenly persuaded otherwise I shall also drop the enhanced ia32
  CPU-type selection patches (retaining pentium-M support).  Sorry Adrian,
  but they do not seem to have sufficient value, given the general
  intrusiveness and patch footprint.




Changes since 2.6.2-mm1:


 linus.patch
 bk-netdev.patch
 bk-input.patch
 bk-usb.patch
 bk-pci.patch
 bk-i2c.patch
 bk-driver-core.patch
 bk-scsi.patch
 bk-arm.patch

 External trees

-acpi-NR_IRQ_VECTORS-build-fix.patch
-ppc64-split-hvconsole.patch
-ppc64-hvc-name.patch
-ppc64-iseries-updatepp.patch
-ppc64-HVSC.patch
-ppc64-compile-warnings.patch
-ppc64-of_removal_fix.patch
-ppc64-vio_updates.patch
-ppc64-viomajortype_scsi.patch
-ppc64-iseriespci.patch
-ppc64-use_drivers_Kconfig.patch
-ppc64-numaisbust.patch
-ppc64-smp_processor_id.patch
-ppc64-remove_pvr_from_paca.patch
-ppc64-xmon-cpumask.patch
-ppc64-xmon-sysrq.patch
-intel8x0-cleanup.patch
-pnp-8250_pnp-fix.patch
-pnp-resource-flags-reorganisation.patch
-pnp-BIOS-workaround.patch
-pnp-avoid-static-allocations.patch
-pnp-move-ID-declarations.patch
-pnp-file2alias-update.patch
-pnp-update-matching-code.patch
-pnp-additional-sysfs-info.patch
-pnp-config-cleanup.patch
-PP0-full_list-RC1.patch
-PP1-parport_locking-RC1.patch
-PP2-enumerate1-RC1.patch
-PP2-enumerate1-RC1-fix.patch
-PP3-parport_gsc-RC1.patch
-PP4-bwqcam-RC1.patch
-bw-qcam-typo-fix.patch
-PP5-daisy-RC1.patch
-PI0-schedule_claimed-RC1.patch
-PI1-expansion-RC1.patch
-PI2-crapectomy-RC1.patch
-PI3-ps_ready-RC1.patch
-PI4-pd_busy-RC1.patch
-PI5-do_pd_io-RC1.patch
-PI6-bogus_requests-RC1.patch
-PI7-claim_reorder-RC1.patch
-PI8-do_pd_request1-RC1.patch
-PI9-run_fsm-RC1.patch
-PI10-action-RC1.patch
-PI11-disconnect-RC1.patch
-PI12-unclaim-RC1.patch
-PI13-run_fsm-loop-RC1.patch
-PI14-next_request-RC1.patch
-PI15-do_pd_io-gone-RC1.patch
-PI16-pd_claimed-RC1.patch
-PI17-connect-RC1.patch
-PI18-reorder-RC1.patch
-PI19-special1-RC1.patch
-PI20-gendisk_setup-RC1.patch
-PI21-present-RC1.patch
-PI22-pd_init_units-RC1.patch
-PI23-special2-RC1.patch
-PI24-paride64-RC1.patch
-IMM0-lindent-RC1.patch
-IMM1-references-RC1.patch
-IMM2-claim-RC1.patch
-IMM3-scsi_module-RC1.patch
-IMM4-imm_probe-RC1.patch
-IMM5-imm_wakeup-RC1.patch
-IMM6-imm_hostdata-RC1.patch
-IMM7-imm_attach-RC1.patch
-PPA0-ppa_lindent-RC1.patch
-PPA1-ppa_references-RC1.patch
-PPA2-ppa_claim-RC1.patch
-PPA3-ppa_scsi_module-RC1.patch
-PPA4-ppa_probe-RC1.patch
-PPA5-ppa_wakeup-RC1.patch
-PPA6-ppa_hostdata-RC1.patch
-PPA7-ppa_attach-RC1.patch
-PPA8-ppa_lock_fix-RC1.patch
-sunrpc-sleep_on-removal.patch
-kernel_thread_helper-section-fix.patch
-gcc-35-netlink.patch
-gcc-35-packet.patch
-gcc-35-tcp_put_port-fix.patch
-gcc-35-ip6-ndisc-fix.patch
-gcc-35-tg3.patch
-gcc-35-atmtcp.patch
-gcc-35-appletalk.patch
-gcc-35-econet.patch
-gcc-35-decnet.patch
-gcc-35-ipx.patch
-gcc-35-irda.patch
-gcc-35-ax25.patch
-gcc-35-net-key.patch
-gcc-35-netrom.patch
-gcc-35-llc.patch
-gcc-35-rose.patch
-gcc-35-sctp-attribute_packed-fix.patch
-gcc-35-pppoe.patch
-simplify-net_ratelimit.patch
-snprintf-commentary.patch
-xattr-E2BIG-fix.patch
-ad1889-printk-fix.patch
-ext23-xattr-i_blocks-fix.patch
-cciss-increase-vm-readahead.patch
-cciss-01-pci-bar-fix.patch
-cciss-02-release_io_mem-fix.patch
-cciss-03-SA6i-support.patch
-cciss-04-irq-sharing-fix.patch
-cciss-05-ASIC-bug-workaround.patch
-cciss-06-controller-check-fix.patch
-cciss-07-avoid-reading-pci-config-space.patch
-cciss-08-printk-fix.patch
-cciss-09-proc-cleanup.patch
-cciss-64-bit-divide-fix.patch
-cciss-10-pci_module_init.patch
-cciss-11-rmmod-oops-fix.patch
-janitor-fbcmap-kmalloc-fixes.patch
-janitor-triflex-non-procfs-fix.patch
-janitor-ps2esdi-fix.patch
-janitor-vga16fb-ioremap-fixes.patch
-sg-mm-warning-suppression.patch
-altix-remove-alenlist_h.patch
-altix-clean-up-HWGRAPH_DEBUG.patch
-qla2xxx-fixes.patch

 Merged

+input-2wheel-mouse-fix-fix.patch

 Warning fix

+tulip-warning-fix.patch

 Warning fix

-big-pmac-3.patch

 This broke due to partial merges.  Dropped.

+remove-duplicated-hppa-sysctls.patch

 Fix probable merge problem

+xattr-error-checking-fix.patch

 Fix getxattr(size=0) handling

+acpi-cpu_has_cpufreq-fix.patch

 Fix acpi thinko

+ide-cd-use-sector_t.patch

 Use sector_t in ide-cd.

+ppc64-prom-warnings.patch

 Warning fixes

+sched-find_busiest_group-arith-fix.patch

 Fix math in the scheduler patches

-laptop-mode-doc-update-4.patch

 Folded into laptop-mode-2.patch

-kthread_stop-race-fix.patch
-kthread-block-all-signals.patch
-kthread-use-after-free-fix.patch

 Folded into kthread-primitive.patch

-module-removal-use-kthread-fixes.patch

 Folded into module-removal-use-kthread.patch

+devfs-do_mount-fix.patch

 Fix devfs to make it work correctly with selinux enhancements

+selinux-enforce-node-fix.patch

 Fix selinux additions

-add-config-for-mregparm-3-ng-fixes.patch

 Folded into add-config-for-mregparm-3-ng.patch

+cpuhotplug-03-core-workqueue-fix.patch

 Fix the resierfs-unmount-oops

-pcix-enhanced.patch

 This needs more work.

+increase-NGROUPS-cleanup-and-fix.patch

 More work agaist the NGROUPS expansion

-i_size_write-check.patch

 This was the patch which checks for i_sem being held during i_size_write().
 It has done its job.

-page_symlink-needs-i_sem.patch

 This was only really needed to shut the debug patch up.

+adaptive-lazy-readahead.patch

 This should get database-style workload throughput back up to 2.6.0 levels.

+mips-new-serial-drivers.patch

 New MIPS serial drivers

+add-syscalls_h.patch
+add-syscalls_h-fixes.patch
+add-syscalls-update.patch
+add-syscalls_h-3.patch

 Add include/linux/syscalls.h, kill millions of private syscall
 declarations.  Needs a little more work yet.

+ifdef-cleanups.patch

 Do `#ifdef CONFIG_FOO', not `#if CONFIG_FOO'

+nfsd-01-schedule-in-spinlock-fix.patch
+nfsd-02-ip_map_init-kmalloc-check.patch
+nfsd-03-sunrpc-cache-init-fixes.patch
+nfsd-04-convert-proc-to-seq_file.patch
+nfsd-05-no-procfs-build-fix.patch

 NFSD update

+md-01-START_ARRAY-is-deprecated.patch
+md-02-split-end_request-handlers.patch
+md-03-discard-r1_bio-cmd-field.patch
+md-04-r1_bio-cleanup.patch
+md-05-avoid-bio-allocation.patch
+md-06-raid1-limit-bio-sizes.patch
+md-07-allow-partitioning.patch

 MD update

+nfs-avoid-i_size_write.patch

 We cannot take i_sem in some of NFS's i_size_write() calls.  Just do the
 64-bit assignment and hope for the best :(

+ia32-pfn_to_nid-fix.patch

 Fix pfn_valid() on numaq

+ia32-numa-pcs-dont-work.patch

 Disable numa-on-pc-subarch

+swap-extent-fix.patch

 Fix oops due to swap extent list construction bug.

+nforce-irq-setup-fix.patch

 Fix IRQ setup for nforce chipsets

+8259-timer-ack-fix.patch

 Fix ia32 timer acknowledgement for some broken setups

+mce-printk-level-fixes.patch

 Decrease the facility level of some MCE printks

+mce-preempt-fixes.patch

 Fix a small race in the MCE code, clean stuff up.

+bitmap_snprintf-bitmap_scnprintf.patch

 Create bitmap_scnprintf(), with scnprintf() return code semantics.

+oss-cruft-removal.patch
+stallion-decruftery.patch
+adfs-2.2-cruft.patch
+lockmeter-2.2-cruft.patch

 Remove old kernel back-compat things.

+highmem-equals-user-friendliness.patch

 Enhance and document the `highmem=' ia32 kernel boot option.  This also
 gives us highmem emulation on <= 896M boxes.

+external-kbuild-doc.patch

 Add some documentation for building out-of-tree modules.

+early_printk.patch
+early_printk-use-include.patch
+early_printk-tweaks.patch

 Early printk for ia32

+panic-later-if-too-many-boot-params.patch

 Deferred panic infrastructure, and one use thereof.





All 250 patches:


linus.patch

bk-netdev.patch

bk-input.patch

bk-usb.patch

bk-pci.patch

bk-i2c.patch

bk-driver-core.patch

bk-scsi.patch

bk-arm.patch

mm.patch
  add -mmN to EXTRAVERSION

speedo-warning-fix.patch
  eepro100.c warning fix

input-2wheel-mouse-fix.patch
  input: 2-wheel mouse fix

input-2wheel-mouse-fix-fix.patch
  From: Adrian Bunk <bunk@fs.tum.de>
  Subject: [patch] 2.6.2-mm1: fix warning introduced by input-2wheel-mouse-fix

dmapool-needs-pci.patch
  dmapool needs CONFIG_PCI

tulip-warning-fix.patch

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes

kgdb-doc-fix.patch
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

remove-duplicated-hppa-sysctls.patch
  Remove duplicated HPPA bits in kernel/sysctl.c

xattr-error-checking-fix.patch
  getxattr error checking fix

acpi-cpu_has_cpufreq-fix.patch
  acpi puc-has_cpufreq() fix

ide-cd-use-sector_t.patch
  ide-cd: incorrect use of sector_div

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

psmouse-drop-timed-out-bytes.patch
  psmouse: log and discard timed out bytes

ppc64-prom-warnings.patch
  ppc64: Fix prom.c warnings

ppc64-spinlock-sleep-debugging.patch
  ppc64: spinlock sleep debugging

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ramdisk-cleanup.patch

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

ptrace-page-permission-fix.patch
  prevent ptrace from altering page permissions

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

loop-remove-blkdev-special-case.patch

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-bio-handling-fix.patch
  loop: BIO handling fix

loop-init-fix.patch
  loop.c doesn't fail init gracefully

loop-remove-redundant-assignment.patch
  loop: remove redundant initialisation

acpi-pm-timer-3.patch
  ACPI PM timer version 3

acpi-pm-timer-kill-printks.patch

use-TSC-for-delay_pmtmr-2.patch
  Use TSC for delay_pmtmr()

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support

sched-clock-fixes.patch
  fix sched_clock()

sched-build-fix.patch
  sched: fix for NR_CPUS > BITS_PER_LONG

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask

p4-clockmod-sibling-map-fix.patch
  p4-clockmod sibling_map fix

p4-clockmod-more-than-two-siblings.patch
  p4-clockmod: handle more than two siblings

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT

sched-find_busiest_group-fix.patch
  sched: Fix CONFIG_SMT oops on UP

sched-domain-tweak.patch
  i386-sched-domain code consolidation

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-arch_init_sched_domains-fix.patch
  Change arch_init_sched_domains to use cpu_online_map

sched-many-cpus-build-fix.patch
  Fix build with NR_CPUS > BITS_PER_LONG

sched-find_busiest_group-clarification.patch
  sched: clarify find_busiest_group

sched-find_busiest_group-arith-fix.patch
  sched: find_busiest_group arithmetic fix

sched-remove-noisy-printks.patch

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-domain-debugging.patch
  sched_domain debugging

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

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

drm-include-fix.patch

kthread-primitive.patch
  kthread primitive
  Fix race in kthread_stop
  kthread: block all signals
  kthread use-after-free fix

use-kthread-primitives.patch
  Use kthread primitives

module-removal-use-kthread.patch
  Module removal to use kthread
  kthread oops fixes

kthread-affinity-fix.patch
  Affinity of kthread fix

call_usermodehelper-affinity-fix.patch
  Affinity of call_usermode_helper fix

limit-hash-table-sizes.patch
  Limit hash table size

slab-poison-hex-dumping.patch
  slab: hexdump for check_poison

pentium-m-support.patch
  add Pentium M and Pentium-4 M options

old-gcc-supports-k6.patch
  gcc 2.95 supports -march=k6 (no need for check_gcc)

amd-elan-is-a-different-subarch.patch
  AMD Elan is a different subarch

better-i386-cpu-selection.patch
  better i386 CPU selection

cpu-options-default-to-y.patch
  cpu options default to "yes"

i386-default-to-n.patch

selinux-01-context-mount-support.patch
  SELinux: context mount support - LSM/FS

selinux-02-nfs-context-mounts.patch
  SELinux: context mount support - NFS

selinux-03-context-mounts-selinux.patch
  SELinux: context mount support - SELinux changes.

devfs-do_mount-fix.patch
  devfs do_mount fix

selinux-enforce-node-fix.patch
  selinux: Allow non-root processes to read selinuxfs enforce node

serial-02-fixups.patch
  serial fixups (untested)
  serial-02 fixes
  serial-02 fixes

serial-03-fixups.patch
  more serial driver fixups
  serial-03 fixes
  serial-03 fixes

nfs-01-rpc_pipe_timeout.patch
  NFSv4/RPCSEC_GSS: userland upcall timeouts

nfs-02-auth_gss.patch
  RPCSEC_GSS: More fixes to the upcall mechanism.

nfs-03-pipe_close.patch
  RPCSEC_GSS: detect daemon death

nfs-04-fix_nfs4client.patch
  NFSv4: oops fix

nfs-05-fix_idmap.patch
  NFSv4: client name fixes

nfs-06-fix_idmap2.patch
  NFSv4: Bugfixes and cleanups client name to uid mapper.

nfs-07-gss_krb5.patch
  RPCSEC_GSS: Make it safe to share crypto tfms among multiple threads.

nfs-08-gss_missingkfree.patch
  RPCSEC_GSS: Oops. Major memory leak here.

nfs-09-memleaks.patch
  RPCSEC_GSS: Fix two more memory leaks found by the stanford checker.

nfs-10-refleaks.patch
  RPCSEC_GSS: Fix yet more memory leaks.

nfs-11-krb5_cleanup.patch
  RPCSEC_GSS: krb5 cleanups

nfs-12-gss_nokmalloc.patch
  RPCSEC_GSS: memory allocation fixes

nfs-13-krb5_integ.patch
  RPCSEC_GSS: Client-side only support for rpcsec_gss integrity protection.

nfs-14-clnt_seqno_to_req.patch
  RPCSEC_GSS: gss sequence number history fixes

nfs-15-encode_pages_tail.patch
  XDR: page encoding fix

nfs-16-rpc_clones.patch
  RPC: transport sharing

nfs-17-rpc_clone2.patch
  NFSv4/RPCSEC_GSS: use RPC cloning

nfs-18-renew_xdr.patch
  NFSv4: make RENEW a standalone RPC call

nfs-19-renewd.patch
  NFSv4: make lease renewal daemon per-server

nfs-20-fsinfo_xdr.patch
  NFSv4: Split the code for retrieving static server information out of the GETATTR compound.

nfs-21-setclientid_xdr.patch
  NFSv4: Make SETCLIENTID and SETCLIENTID_CONFIRM standalone operations

nfs-22-errno.patch
  NFSv4: errno fixes

nfs-23-open_reclaim.patch
  NFSv4: Preparation for the server reboot recovery code.

nfs-24-state_recovery.patch
  NFSv4: Basic code for recovering file OPEN state after a server reboot.

nfs-25-soft.patch
  RPC/NFSv4: Allow lease RENEW calls to be soft

nfs-26-sock_disconnect.patch
  RPC: TCP timeout fixes

nfs-27-atomic_open.patch
  NFSv4: Atomic open()

nfs-28-open_owner.patch
  NFSv4: Share open_owner structs

nfs-29-fix_idmap3.patch
  NFSv4: fix multi-partition mount oops

nfs_idmap-warning-fix.patch

nfs-30-lock.patch
  NFSv4: Add support for POSIX file locking.

nfs-old-gcc-fix.patch
  NFS: fix for older gcc's

nfs-31-attr.patch
  NFSv2/v3/v4: New attribute revalidation code

reserve-NUMA-API-syscall-slots.patch
  Reserve system calls for NUMA API

ghash.patch
  ghash.h from 2.4

tty_io-uml-fix.patch
  uml: make tty_init callable from UML functions

uml-update.patch
  UML update

uml-fixes-2.6.2-rc3-mm1-A2.patch
  uml-fixes-2.6.2-rc3-mm1-A2

blk_congestion_wait-return-remaining.patch
  return remaining jiffies from blk_congestion_wait()

vmscan-remove-priority.patch
  mm/vmscan.c: remove unused priority argument.

kswapd-throttling-fixes.patch
  kswapd throttling fixes

vm-dont-rotate-active-list.patch
  vmscan: avoid rotation of the active list

vm-lru-info.patch
  vmscan: make better use of referenced info

vm-shrink-zone.patch
  vmscan: several tuneups

vm-shrink-zone-div-by-0-fix.patch

vm-tune-throttle.patch
  vmscan: delay throttling a little

page_add_rmap-warning.patch

add-config-for-mregparm-3-ng.patch
  Add CONFIG for -mregparm=3
  arch/i386/Makefile,scripts/gcc-version.sh,Makefile small fixes

use-funit-at-a-time.patch
  Use -funit-at-a-time on ia32

add-noinline-attribute.patch
  Add noinline attribute

dont-inline-rest_init.patch
  use noinline for rest_init()

gcc-35-xfs.patch
  gcc-3.5: XFS fixes

gcc-35-bonding.patch
  gcc-3.5: bonding

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

doc-remove-modules-conf-references.patch
  Documentation: remove /etc/modules.conf refs

more-MODULE_ALIASes.patch
  add some more MODULE_ALIASes

bonding-alias-revert-and-docco-fix.patch
  bonding alias revert and documentation fix

remove-kstat-cpu-notifiers.patch
  Remove kstat cpu notifiers

workqueue-cleanup-2.patch
  Minor workqueue.c cleanup

remove-more-cpu-notifiers.patch
  Remove More Unneccessary CPU Notifiers

use-CPU_UP_PREPARE-properly.patch
  Use CPU_UP_PREPARE properly

cpuhotplug-01-cpu_active_map.patch
  CPU Hotplug: add cpu_active_map

cpuhotplug-02-drain_local_pages.patch
  CPU Hotplug: drain downed CPU's local pages

cpuhotplug-03-core.patch
  CPU Hotplug: The Core

cpuhotplug-03-core-workqueue-fix.patch

cpuhotplug-03-core-numa-fix.patch
  cpu hotplug: compile fix

cpuhotplug-up-fixes.patch
  cpuhotplug: UP build fixes

set_cpus_allowed-fix.patch
  cpumask fix

cpuhotplug-04-x86-support.patch
  CPU Hotplug: i386 support

cpuhotplug-x86-up-fixes.patch
  cpuhotplug: x86 UP build fixes

sleep_on-needs_lock_kernel.patch
  sleep_on(): check for lock_kernel

i830-agp-pm-fix.patch
  Intel i830 AGP fix

x86_64-make-xconfig-fix.patch
  Fix make xconfig on /lib64 systems

usb-sddr09-documentation.patch
  add comments to sddr09.c

pcnet32-locking-fix.patch
  pcmet32 locking fixes

nfs-server-in-root_server_path.patch
  Pull NFS server address out of root_server_path

increase-NGROUPS.patch
  NGROUPS 2.6.2rc2 + fixups
  NGROUPS: remove TASK_SIZE usage
  NGROUPS: generalise condition for freeing sub-pages

increase-NGROUPS-nfsd-cleanup.patch
  NGROUPS: nfsd cleanup

increase-NGROUPS-cleanup-and-fix.patch
  NGROUPS: cleanup and fix

intermezzo-NGROUPS-is-broken.patch

compat-signal-noarch-2004-01-29.patch

compat-signal-ppc64-2004-01-29.patch

compat-signal-ia64-2004-01-29.patch

bd_set_size-i_size-fix.patch
  bd_set_size i_size handling

nfs-d_drop-lowmem.patch
  NFS: handle nfs_fhget() error

initramfs-kinit_command.patch
  initramfs: look for /sbin/init

access-permissions-fix.patch
  fix access() POSIX compliance

snprintf-fixes.patch
  snprintf fixes

devfs-race-fix-cleanup.patch
  devfs: race fixes and cleanup

centaur-crypto-core-support.patch
  First steps toward VIA crypto support

enable-largefile-coredumps.patch
  Enable coredumps > 2GB

adaptive-lazy-readahead.patch
  adaptive lazy readahead

mips-new-serial-drivers.patch
  MIPS: New 2.6 serial drivers

add-syscalls_h.patch
  add syscalls.h

add-syscalls_h-fixes.patch

add-syscalls-update.patch
  syscalls.h update1

add-syscalls_h-3.patch
  more syscalls.h stuff

ifdef-cleanups.patch
  #if versus #ifdef cleanup

nfsd-01-schedule-in-spinlock-fix.patch
  kNFSd: Fix possible scheduling_while_atomic in cache.c

nfsd-02-ip_map_init-kmalloc-check.patch
  kNFSd: ip_map_init does a kmalloc which isn't checked...

nfsd-03-sunrpc-cache-init-fixes.patch
  kNFSd: Allow sunrpc/svc cache init function to modify the "key"

nfsd-04-convert-proc-to-seq_file.patch
  kNFSd: convert NFS /proc interfaces to seq_file

nfsd-05-no-procfs-build-fix.patch
  kNFSd:fix build problems in nfs w/o proc_fs on 2.6.0-test5

md-01-START_ARRAY-is-deprecated.patch
  md: Print "deprecated" warning when START_ARRAY is used.

md-02-split-end_request-handlers.patch
  md: Split read and write end_request handlers

md-03-discard-r1_bio-cmd-field.patch
  md: Discard the cmd field from r1_bio structure

md-04-r1_bio-cleanup.patch
  md: Remove some un-needed fields from r1bio_s

md-05-avoid-bio-allocation.patch
  md: Avoid unnecessary bio allocation during raid1 resync

md-06-raid1-limit-bio-sizes.patch
  From: NeilBrown <neilb@cse.unsw.edu.au>
  Subject: [PATCH] md - 6 of 7 - Dynamically limit size of bio requests used for raid1 resync

md-07-allow-partitioning.patch
  From: NeilBrown <neilb@cse.unsw.edu.au>
  Subject: [PATCH] md - 7 of 7 - Allow partitioning of MD devices.

nfs-avoid-i_size_write.patch
  NFS: avoid unlocked i_size_write()

ia32-pfn_to_nid-fix.patch
  ia32: pfn_to_nid fix

ia32-numa-pcs-dont-work.patch
  ia32: disallow NUMA on PC subarch

swap-extent-fix.patch
  swap extent merging fix

nforce-irq-setup-fix.patch
  nforce IRQ setup fix

8259-timer-ack-fix.patch
  8259 timer ack fix

mce-printk-level-fixes.patch
  Fix printk level on non fatal MCEs

mce-preempt-fixes.patch
  MCE fixes and cleanups

bitmap_snprintf-bitmap_scnprintf.patch
  Rename bitmap_snprintf() and cpumask_snprintf() to *_scnprintf()

oss-cruft-removal.patch
  OSS: remove #ifdef's for kernel 2.0

highmem-equals-user-friendliness.patch
  Add user friendliness to highmem= option

stallion-decruftery.patch
  remove kernel 2.2 #ifdef's from {i,}stallion.h

external-kbuild-doc.patch
  kbuild documentation fix

adfs-2.2-cruft.patch
  adfs: remove a kernel 2.2 #ifdef

early_printk.patch
  ia32 early printk

early_printk-use-include.patch
  generate ia32 early_printk via inclusion

early_printk-tweaks.patch
  early printk tweaks

panic-later-if-too-many-boot-params.patch
  defer panic for too many items in boot parameter line

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

show_task-fix.patch
  show_task() is not SMP safe

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

zap_low_mappings-fix.patch
  zap_low_mappings() cannot be __init

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

4g4g-uml-fix.patch
  4g4g: UML fix

ppc-fixes.patch
  make mm4 compile on ppc

O_DIRECT-race-fixes-rollup.patch
  O_DIRECT data exposure fixes

O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
  Fix race between ll_rw_block() and block_write_full_page()

dio-aio-fixes.patch
  direct-io AIO fixes

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix

aio-sysctl-parms.patch
  aio sysctl parms



