Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbUBEJnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 04:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbUBEJne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 04:43:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:50313 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264546AbUBEJmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 04:42:18 -0500
Date: Thu, 5 Feb 2004 01:44:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.2-mm1 aka "Geriatric Wombat"
Message-Id: <20040205014405.5a2cf529.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-mm1/


- Merged some page reclaim fixes from Nick and Nikita.  These yield some
  performance improvements in low memory and heavy paging situations.

- Various random fixes.



Changes since 2.6.2-rc3-mm1:


 linus.patch
 bk-alsa.patch
 bk-netdev.patch
 bk-input.patch
 bk-acpi.patch
 bk-usb.patch
 bk-pci.patch
 bk-i2c.patch
 bk-driver-core.patch

 External trees

-ppc64-__ste_allocate-cleanup.patch
-ppc64-bar-0-fix.patch
-nuke-noisy-printks.patch
-vt-locking-fixes-2.patch
-lock_cpu_hotplug-fixes.patch
-ia32-MSI-vector-handling-fix.patch
-aha152x-update.patch
-aha152x-update-fix.patch
-kbuild-unmangle-include-options.patch
-sisfb-update.patch
-fix-more-gcc-34-warnings.patch
-gcc-34-string-fixes.patch
-gcc-35-bio_phys_segments.patch
-gcc-35-ident-warnings.patch
-gcc-35-binfmt_elf-warning-fix.patch
-gcc-35-pcm_misc-warnings.patch
-gcc-35-pcm_plugin-warnings.patch
-gcc-35-reiserfs-fixes.patch
-gcc-35-ide-fix.patch
-gcc-35-elevator.patch
-gcc-35-keyboard-fixes.patch
-gcc-35-exit-fix.patch
-gcc-35-parport.patch
-gcc-34-compilation-fixes.patch
-gcc-35-seq_clientmgr.patch
-gcc-35-parport2.patch
-gcc-35-i810_accel.patch
-gcc-35-puts-fix.patch
-gcc-35-filesystems.patch
-gcc-35-zatm-fix.patch
-gcc-35-vxfs-idents.patch
-gcc-35-hfs-fix.patch
-gcc-35-uPD98402.patch
-gcc-35-intermezzo.patch
-gcc-35-iphase.patch
-gcc-35-suni.patch
-gcc-35-fore2000e.patch
-gcc-35-ncpfs.patch
-gcc-35-eni.patch
-gcc-35-idt77105.patch
-gcc-35-he.patch
-gcc-35-atm-common.patch
-gcc-35-it87.patch
-gcc-35-radeon.patch
-gcc-35-sc1200.patch
-gcc-35-raid6x86.patch
-gcc-35-mtd.patch
-gcc-35-dvb.patch
-gcc-35-pcmcia.patch
-gcc-35-video.patch
-gcc-35-pnpbios.patch
-gcc-35-53c700.patch
-gcc-35-advansys.patch
-gcc-35-atp870u.patch
-gcc-35-gdth.patch
-gcc-35-fbcon.patch
-gcc-35-riva-fbdev.patch
-gcc-35-video-cfbimgblt.patch
-gcc-35-video-vgastate.patch
-gcc-35-traps.patch
-gcc-35-x86_64.patch
-bitmap-parsing-printing-v4.patch
-bitmap-parsing-cleanup.patch
-bitmap-avoid-alloca.patch
-janitor-09-i387-usercopy-check.patch
-printk-rate_limit-fixes.patch
-readX_relaxed.patch
-kconfig-use-select-2.patch
-kconfig-remove-enable.patch
-use-attribute-const-everywhere.patch
-edd-disksig.patch
-edd-url-fix.patch
-swsusp-stop-DMA-on-resume.patch
-swsusp-stop-DMA-on-resume-fix.patch
-swsusp-trivial-cleanups.patch
-swsusp-more-cleanups.patch
-swsusp-software_suspend-retval-fix.patch
-swsusp-software_suspend-retval-fix-fix.patch
-vmalloc-address-offset-fix.patch
-hugetlbfs_remove_dirent.patch
-libfs_timestamp_fixes.patch
-hugetlbfs_cleanup.patch
-console_driver-definition-fix.patch
-partition-naming-fix.patch
-ppc32-1000-hz.patch
-fix-blockdev-getro.patch
-support-wider-consoles.patch
-remove-valid_addr_bitmap.patch
-osst-warning-fix.patch
-init-cpu_vm_mask-in-init_mm.patch
-raw-is-obsolete.patch
-ncpfs-stack-usage-fix.patch
-remove_suid-fix.patch
-md-02-preferred_minor-fix.patch
-md-03-debugging-output-cleanup.patch
-md-04-personality-stats-collection.patch
-md-05-device-in-error-printing-fix.patch
-proc-partitions-omit-removable-media.patch
-remove-SIIG-PCI-IDs-from-parport_pc.patch
-remove-memblks.patch
-scsi-tape-fixes.patch
-raid-makefile-cleanup.patch
-fancy-lost-ticks-message.patch
-reserve-NUMA-API-syscall-slots.patch
-posix-timers-fixes.patch
-mount-option-overrun-fix.patch
-futex-redundant-test.patch
-CONFIG_SYSRQ-fixes.patch
-dz-verify_area-removal.patch
-oss-c99-fixes.patch
-console-makefile-cleanup.patch
-oprofile-ringbuffer-wrap-fix.patch
-oprofile-alpha-fix.patch
-copy_namespace-enomem-fix.patch
-vgastate-missing-iounmaps.patch
-vga16fb-missing-iounmap.patch
-d_path-needs-vfsmount_lock.patch
-namei-needs-vfsmount_lock.patch
-try-reiserfs-earlier.patch
-ufs-use-silent.patch
-time-rounding-accuracy.patch
-proc-stat-btime-fix-2.patch
-menuconfig-choice-display-fix.patch
-use-uint32_t-for-crosscompiling.patch
-ac97-remove-fix.patch
-is_subdir-locking-fix.patch
-proc_check_root-locking-fix.patch
-ide-cd-MO-write-protect.patch
-nr_free_pages-is-expensive.patch
-mmap-use-address-hint.patch
-shrink_list-swapcache-check-fix.patch
-as-docco-update.patch
-cscope-use-inverted-index.patch
-Lindent-goodness.patch
-move-cpu_vm_mask.patch
-pci-scan-all-functions.patch
-CDROMREADAUDIO-frames-fix.patch
-unneeded-dentry-assignment.patch
-export-cpu_2_node.patch
-remove-kmalloc_percpu_init.patch
-ppp-allocation-fix.patch
-neofb-warning-fix.patch
-gate_vma-fixes.patch
-istallion-compile-fix.patch
-moxa-serial-compile-fix.patch
-specialix-compile-fix.patch
-hisax-compile-fix.patch
-dvb-compile-fix.patch
-selinux-compile-fix.patch
-coredump-memleak-fix.patch
-x86_64-boot-fix.patch

 Merged

+dmapool-needs-pci.patch

 The dmapool code doesn't build with CONFIG_PCI=n.  But it should.  Needs
 work.

+ppc64-split-hvconsole.patch
+ppc64-hvc-name.patch
+ppc64-iseries-updatepp.patch
+ppc64-HVSC.patch
+ppc64-compile-warnings.patch
+ppc64-of_removal_fix.patch
+ppc64-vio_updates.patch
+ppc64-viomajortype_scsi.patch
+ppc64-iseriespci.patch
+ppc64-use_drivers_Kconfig.patch
+ppc64-numaisbust.patch
+ppc64-smp_processor_id.patch
+ppc64-remove_pvr_from_paca.patch
+ppc64-xmon-cpumask.patch
+ppc64-xmon-sysrq.patch
+ppc64-spinlock-sleep-debugging.patch

 ppc64 updates

-get_user_pages-restore-protections.patch
-get_user_pages-restore-protections-fix.patch
+ptrace-page-permission-fix.patch

 Drop the old code, fix the ptrace-modifies-ptes problem by using the vma's
 flags.

+sched-many-cpus-build-fix.patch

 Scheduler compile fix

+ppc64-cpu_vm_mask-fix.patch

 Might fix a ppc64 bug

+kthread-use-after-free-fix.patch

 Fix kthread-related oops

+module-removal-use-kthread-fixes.patch

 Fix kthread usage in the modules code

+selinux-01-context-mount-support.patch
+selinux-02-nfs-context-mounts.patch
+selinux-03-context-mounts-selinux.patch

 SELinux context mounts

+uml-fixes-2.6.2-rc3-mm1-A2.patch

 UML fixes

-vm-rss-limit-enforcement.patch

 Finally got this working, but it doesn't seem to be effective.

+vm-dont-rotate-active-list.patch
+vm-lru-info.patch
+vm-shrink-zone.patch
+vm-shrink-zone-div-by-0-fix.patch
+vm-tune-throttle.patch
+page_add_rmap-warning.patch

 Page reclaim tuning and fixups

+cpuhotplug-03-core-numa-fix.patch

 Fix the CPU hotplug code for NUMAQ

-sysfs_symlink-needs-i_sem.patch
+page_symlink-needs-i_sem.patch

 Move the i_sem taking from sysfs_symlink into page_symlink.  This is rather
 unnecessary - it's mainly to make the i_size_write() warnings go away.

-generic-dma-pool-1.patch
-generic-dma-pool-2.patch
-generic-dma-pool-3.patch

 Merged into one of Greg's trees

-Lindent-drivers-base-dmapool.patch

 Dropped

+centaur-crypto-core-support.patch

 Start supporting hardware crypto on some VIA CPUs

+xattr-E2BIG-fix.patch

 EA fix

+ad1889-printk-fix.patch

 Warning fix

+enable-largefile-coredumps.patch

 Use O_LARGEFILE for core files

+ext23-xattr-i_blocks-fix.patch

 xattr fix

+cciss-increase-vm-readahead.patch
+cciss-01-pci-bar-fix.patch
+cciss-02-release_io_mem-fix.patch
+cciss-03-SA6i-support.patch
+cciss-04-irq-sharing-fix.patch
+cciss-05-ASIC-bug-workaround.patch
+cciss-06-controller-check-fix.patch
+cciss-07-avoid-reading-pci-config-space.patch
+cciss-08-printk-fix.patch
+cciss-09-proc-cleanup.patch
+cciss-64-bit-divide-fix.patch
+cciss-10-pci_module_init.patch
+cciss-11-rmmod-oops-fix.patch

 CCISS driver update

+janitor-fbcmap-kmalloc-fixes.patch
+janitor-triflex-non-procfs-fix.patch
+janitor-ps2esdi-fix.patch
+janitor-vga16fb-ioremap-fixes.patch

 Janitorial fixlets

+sg-mm-warning-suppression.patch

 Kill a page allocation failure warning coming out of the scsi code.

+altix-remove-alenlist_h.patch
+altix-clean-up-HWGRAPH_DEBUG.patch

 Altix updates

+qla2xxx-fixes.patch

 Some fixes for the new qlogic driver

+4g4g-uml-fix.patch

 Fix UML build problems due to the 4g/4g patch

-O_DIRECT-race-fixes-rollup-use-f_mapping.patch

 Folded into O_DIRECT-race-fixes-rollup.patch

+O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch

 Fix race between ll_rw_block() and block_write_full_page().




All 332 patches:


linus.patch

bk-alsa.patch

bk-netdev.patch

bk-input.patch

bk-acpi.patch

bk-usb.patch

bk-pci.patch

bk-i2c.patch

bk-driver-core.patch

mm.patch
  add -mmN to EXTRAVERSION

speedo-warning-fix.patch
  eepro100.c warning fix

input-2wheel-mouse-fix.patch
  input: 2-wheel mouse fix

acpi-NR_IRQ_VECTORS-build-fix.patch

dmapool-needs-pci.patch
  dmapool needs CONFIG_PCI

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

big-pmac-3.patch

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

psmouse-drop-timed-out-bytes.patch
  psmouse: log and discard timed out bytes

ppc64-split-hvconsole.patch
  ppc64: move hypervisor console code into its own file

ppc64-hvc-name.patch
  ppc64: fix up hvc console dev/devfs name, from Milton Miller

ppc64-iseries-updatepp.patch
  ppc64: Fix up iseries updatepp, from Ben Herrenschmidt

ppc64-HVSC.patch
  ppc64: change HSC -> HVSC

ppc64-compile-warnings.patch
  ppc64: Fix compiler warnings, from Olof Johansson

ppc64-of_removal_fix.patch
  ppc64: Fixes for OF device tree update code, from Nathan Lynch

ppc64-vio_updates.patch
  ppc64: integrate vio.c with 2.6 driver model

ppc64-viomajortype_scsi.patch
  ppc64: Added definition of viomajortype_scsi, from Dave Boutcher

ppc64-iseriespci.patch
  ppc64: Fix pcibios_scan_all_fns on iSeries, from Jake Moilanen

ppc64-use_drivers_Kconfig.patch
  ppc64: use drivers/Kconfig

ppc64-numaisbust.patch
  ppc64: Fix another numa bug

ppc64-smp_processor_id.patch
  ppc64: use smp_processor_id everywhere

ppc64-remove_pvr_from_paca.patch
  ppc64: Remove pvr from the paca

ppc64-xmon-cpumask.patch
  ppc64: cpus_in_xmon needs to be a cpumask_t, from Milton Miller

ppc64-xmon-sysrq.patch
  ppc64: sysrq helpers should have their active character capitalized

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

intel8x0-cleanup.patch
  intel8x0 cleanups

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

ptrace-page-permission-fix.patch
  prevent ptrace from altering page permissions

get_user_pages-handle-VM_IO.patch

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

pnp-8250_pnp-fix.patch
  Fix oops due to 8250_pnp module unload

pnp-resource-flags-reorganisation.patch
  pnp: resource flag reorganisation

pnp-BIOS-workaround.patch
  PNP: work around BIOS device disabling bugs

pnp-avoid-static-allocations.patch
  pnp: avoid static resource allocation requests

pnp-move-ID-declarations.patch
  pnp: move device ID declarations

pnp-file2alias-update.patch
  pnp: file2alias update

pnp-update-matching-code.patch
  pnp: update matching code

pnp-additional-sysfs-info.patch
  pnp: add additional sysfs info

pnp-config-cleanup.patch
  pnp: Kconfig cleanup

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

laptop-mode-doc-update-4.patch
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

kthread_stop-race-fix.patch
  Fix race in kthread_stop

kthread-block-all-signals.patch
  kthread: block all signals

kthread-use-after-free-fix.patch
  kthread use-after-free fix

use-kthread-primitives.patch
  Use kthread primitives

module-removal-use-kthread.patch
  Module removal to use kthread

module-removal-use-kthread-fixes.patch
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

serial-02-fixups.patch
  serial fixups (untested)
  serial-02 fixes
  serial-02 fixes

serial-03-fixups.patch
  more serial driver fixups
  serial-03 fixes
  serial-03 fixes

PP0-full_list-RC1.patch
  parport fixes [1/5]

PP1-parport_locking-RC1.patch
  parport fixes [2/5]

PP2-enumerate1-RC1.patch
  parport fixes [3/5]

PP2-enumerate1-RC1-fix.patch

PP3-parport_gsc-RC1.patch
  parport fixes [4/5]

PP4-bwqcam-RC1.patch
  parport fixes [5/5]

bw-qcam-typo-fix.patch
  bw-qcam typo fix

PP5-daisy-RC1.patch
  parport fixes [2/5]

PI0-schedule_claimed-RC1.patch
  paride cleanups and fixes [1/24]

PI1-expansion-RC1.patch
  paride cleanups and fixes [2/24]

PI2-crapectomy-RC1.patch
  paride cleanups and fixes [3/24]

PI3-ps_ready-RC1.patch
  paride cleanups and fixes [4/24]

PI4-pd_busy-RC1.patch
  paride cleanups and fixes [5/24]

PI5-do_pd_io-RC1.patch
  paride cleanups and fixes [6/24]

PI6-bogus_requests-RC1.patch
  paride cleanups and fixes [7/24]

PI7-claim_reorder-RC1.patch
  paride cleanups and fixes [8/24]

PI8-do_pd_request1-RC1.patch
  paride cleanups and fixes [9/24]

PI9-run_fsm-RC1.patch
  paride cleanups and fixes [10/24]

PI10-action-RC1.patch
  paride cleanups and fixes [2/24]

PI11-disconnect-RC1.patch
  paride cleanups and fixes [12/24]

PI12-unclaim-RC1.patch
  paride cleanups and fixes [13/24]

PI13-run_fsm-loop-RC1.patch
  paride cleanups and fixes [14/24]

PI14-next_request-RC1.patch
  paride cleanups and fixes [15/24]

PI15-do_pd_io-gone-RC1.patch
  paride cleanups and fixes [16/24]

PI16-pd_claimed-RC1.patch
  paride cleanups and fixes [17/24]

PI17-connect-RC1.patch
  paride cleanups and fixes [18/24]

PI18-reorder-RC1.patch
  paride cleanups and fixes [19/24]

PI19-special1-RC1.patch
  paride cleanups and fixes [20/24]

PI20-gendisk_setup-RC1.patch
  paride cleanups and fixes [21/24]

PI21-present-RC1.patch
  paride cleanups and fixes [22/24]

PI22-pd_init_units-RC1.patch
  paride cleanups and fixes [23/24]

PI23-special2-RC1.patch
  paride cleanups and fixes [24/24]

PI24-paride64-RC1.patch
  paride cleanups and fixes [25/24]

IMM0-lindent-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [1/8]

IMM1-references-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [2/8]

IMM2-claim-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [3/8]

IMM3-scsi_module-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [4/8]

IMM4-imm_probe-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [5/8]

IMM5-imm_wakeup-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [6/8]

IMM6-imm_hostdata-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [7/8]

IMM7-imm_attach-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [8/8]

PPA0-ppa_lindent-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [1/9]

PPA1-ppa_references-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [2/9]

PPA2-ppa_claim-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [3/9]

PPA3-ppa_scsi_module-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [4/9]

PPA4-ppa_probe-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [5/9]

PPA5-ppa_wakeup-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [6/9]

PPA6-ppa_hostdata-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [7/9]

PPA7-ppa_attach-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [8/9]

PPA8-ppa_lock_fix-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [9/9]

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

sunrpc-sleep_on-removal.patch
  remove sleep_on from sunrpc

add-config-for-mregparm-3-ng.patch
  Add CONFIG for -mregparm=3

add-config-for-mregparm-3-ng-fixes.patch
  arch/i386/Makefile,scripts/gcc-version.sh,Makefile small fixes

use-funit-at-a-time.patch
  Use -funit-at-a-time on ia32

add-noinline-attribute.patch
  Add noinline attribute

dont-inline-rest_init.patch
  use noinline for rest_init()

kernel_thread_helper-section-fix.patch
  Force kernel_thread_helper() into .text

gcc-35-netlink.patch
  gcc-3.5: netlink

gcc-35-packet.patch
  gcc-3.5: af_packet

gcc-35-tcp_put_port-fix.patch
  gcc-3.5: tcp_put_port() fix

gcc-35-ip6-ndisc-fix.patch
  gcc-3.5: ipv6/ndisc.c fixes

gcc-35-tg3.patch
  gcc-3.5: tg3.c warnings

gcc-35-xfs.patch
  gcc-3.5: XFS fixes

gcc-35-atmtcp.patch
  gcc-3.5: drivers/atm/atmtcp.c

gcc-35-appletalk.patch
  gcc-3.5: appletalk

gcc-35-econet.patch
  gcc-3.5: econet

gcc-35-decnet.patch
  gcc-3.5: decnet

gcc-35-ipx.patch
  gcc-3.5: ipx

gcc-35-irda.patch
  gcc-3.5: irda

gcc-35-bonding.patch
  gcc-3.5: bonding

gcc-35-ax25.patch
  gcc-3.5: ax25

gcc-35-net-key.patch
  gcc-3.5: net/key/af_key.c

gcc-35-netrom.patch
  gcc-3.5: netrom

gcc-35-llc.patch
  gcc-3.5: llc

gcc-35-rose.patch
  gcc-3.5: net/rose

gcc-35-sctp-attribute_packed-fix.patch
  gcc-3.5: sctp

gcc-35-pppoe.patch
  gcc-3.5: pppoe

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

doc-remove-modules-conf-references.patch
  Documentation: remove /etc/modules.conf refs

more-MODULE_ALIASes.patch
  add some more MODULE_ALIASes

bonding-alias-revert-and-docco-fix.patch
  bonding alias revert and documentation fix

simplify-net_ratelimit.patch
  simplify net_ratelimit()

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

pcix-enhanced.patch
  PCI Express Enhanced Config Patch

increase-NGROUPS.patch
  NGROUPS 2.6.2rc2 + fixups
  NGROUPS: remove TASK_SIZE usage

increase-NGROUPS-nfsd-cleanup.patch
  NGROUPS: nfsd cleanup

intermezzo-NGROUPS-is-broken.patch

compat-signal-noarch-2004-01-29.patch

compat-signal-ppc64-2004-01-29.patch

compat-signal-ia64-2004-01-29.patch

i_size_write-check.patch

page_symlink-needs-i_sem.patch
  take i_sem in page_symlink()

bd_set_size-i_size-fix.patch
  bd_set_size i_size handling

nfs-d_drop-lowmem.patch
  NFS: handle nfs_fhget() error

initramfs-kinit_command.patch
  initramfs: look for /sbin/init

access-permissions-fix.patch
  fix access() POSIX compliance

snprintf-commentary.patch
  snprintf() commentary

snprintf-fixes.patch
  snprintf fixes

devfs-race-fix-cleanup.patch
  devfs: race fixes and cleanup

centaur-crypto-core-support.patch
  First steps toward VIA crypto support

xattr-E2BIG-fix.patch
  With size > XATTR_SIZE_MAX, getxattr(2) always returns E2BIG

ad1889-printk-fix.patch
  oss/ad1889: correct printk of dma_addr_t

enable-largefile-coredumps.patch
  Enable coredumps > 2GB

ext23-xattr-i_blocks-fix.patch
  ext2/3: incorrect increment of i_blocks when keeping the same xattr block

cciss-increase-vm-readahead.patch
  Set CCISS driver VM read-ahead to 1024K

cciss-01-pci-bar-fix.patch
  cciss: PCI BAR sizing fix

cciss-02-release_io_mem-fix.patch
  cciss: Fix freeing of incorrect IO memory address

cciss-03-SA6i-support.patch
  cciss: Add support for SA 6i embedded controller

cciss-04-irq-sharing-fix.patch
  cciss: IRQ sharing fix

cciss-05-ASIC-bug-workaround.patch
  cciss: disble prefetching in ASIC

cciss-06-controller-check-fix.patch
  cciss: intialisation oops fix

cciss-07-avoid-reading-pci-config-space.patch
  cciss: avoid reading PCI config space

cciss-08-printk-fix.patch
  cciss: printk format fix

cciss-09-proc-cleanup.patch
  cciss: improve /proc presentation

cciss-64-bit-divide-fix.patch

cciss-10-pci_module_init.patch
  cciss: use pci_module_init()

cciss-11-rmmod-oops-fix.patch
  cciss: rmmod oops fix

janitor-fbcmap-kmalloc-fixes.patch
  janitor: video/fbcmap: kmalloc() audit

janitor-triflex-non-procfs-fix.patch
  janitor: ide/pci/triflex: handle !CONFIG_PROC_FS

janitor-ps2esdi-fix.patch
  janitor: ps2esdi: fix '&' to '&&'

janitor-vga16fb-ioremap-fixes.patch
  janitor: vga16fb.c ioremap() and fb_alloc_cmap() audit

sg-mm-warning-suppression.patch
  Suppress page allocation failures from sg_page_malloc()

altix-remove-alenlist_h.patch
  Altix: remove alenlist.h

altix-clean-up-HWGRAPH_DEBUG.patch
  Altix: cleanup HWGRAPH_DEBUG

qla2xxx-fixes.patch
  Fix many qla2xxx problems

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



