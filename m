Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTLaIrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 03:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTLaIrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 03:47:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:15754 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262386AbTLaIrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 03:47:02 -0500
Date: Wed, 31 Dec 2003 00:47:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-rc1-mm1
Message-Id: <20031231004725.535a89e4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-rc1/2.6.0-rc1-mm1/


A few small additions, but mainly a resync with mainline.




Changes since 2.6.0-mm2:


-2.6.0-netdrvr-exp3.patch
-2.6.0-netdrvr-exp3-fix.patch
-Space_c-warning-fix.patch
-via-rhine-netpoll-support.patch
+2.6.0-bk2-netdrvr-exp1.patch

 new experimental net driver tree

+net-jiffy-normalisation-fix.patch

 net/ timebase reowrk, in here for some testing.

-kgdb-buff-too-big.patch
-kgdb-warning-fix.patch
-kgdb-build-fix.patch
-kgdb-spinlock-fix.patch
-kgdb-fix-debug-info.patch
-kgdb-cpumask_t.patch
-kgdb-x86_64-fixes.patch

 Folded into kgdb-ga.patch

-unshare_files.patch
-use-unshare_files.patch
-add-steal_locks.patch
-use-steal_locks.patch
-env-signedness-fixes.patch
-suid-leak-fix.patch
-proc-tty-driver-permission-fix.patch
-serio-01-renaming.patch
-serio-02-race-fix.patch
-serio-03-blacklist.patch
-serio-04-synaptics-cleanup.patch
-serio-05-reconnect-facility.patch
-serio-06-synaptics-use-reconnect.patch
-synaptics-powerpro-fix.patch
-input-unregister-on-fail-fix.patch
-serio-pm-fix.patch
-atkbd-24-compatibility.patch
-input-01-atkbd_softrepeat-fix.patch
-input-02-add-psmouse_proto.patch
-input-03-resume-methods.patch
-input-04-atkbd-reconnect-method.patch
-input-05-psmouse-fixes.patch
-input-06-serio_unregister_port_delayed.patch
-input-07-remove-synaptics-config-option.patch
-input-08-synaptics-protocol-discovery.patch
-futex-uninlinings.patch
-call_usermodehelper-retval-fix-4.patch
-ia32-MSI-support.patch
-ia32-efi-support.patch
-SGI-IOC4-IDE-chipset-support.patch
-i82365-sysfs-ordering-fix.patch
-ia64-ia32-missing-compat-syscalls.patch
-compat-layer-fixes.patch
-compat-ioctl-for-i2c.patch
-fix-sqrt.patch
-scale-min_free_kbytes.patch
-cdrom-allocation-try-harder.patch
-sym-2.1.18f.patch
-name_to_dev_t-__init.patch
-early-serial-registration-fix.patch
-ext3-latency-fix.patch
-cmpci-set_fs-fix.patch
-dentry-bloat-fix-2.patch
-nls-config-fixes.patch
-proc_pid_lookup-vs-exit-race-fix.patch
-gcc-Os-if-embedded.patch
-vm86-sysenter-fix.patch
-refill_counter-overflow-fix.patch
-verbose-timesource.patch
-cdc-acm-softirq-rx.patch
-proc-pid-maps-output-fix.patch
-sis900-pm-support.patch
-8139too-locking-fix.patch
-ia32-wp-test-cleanup.patch
-powermate-payload-size-fix.patch
-more-than-256-cpus.patch
-ZONE_SHIFT-from-NODES_SHIFT.patch
-memmove-speedup.patch
-pipe-readv-writev.patch
-lockless-semop.patch
-percpu_counter-use-alloc_percpu.patch
-i450nx-scanning-fix.patch
-find_busiest_queue-commentary.patch
-SOUND_CMPCI-config-typo-fix.patch
-eicon-linkage-fix.patch
-kobject-docco-additions.patch
 radeon-line-length-fix.patch
-proc-interrupts-use-seq-file.patch
-proc-interrupts-use-seq_file-2.patch
-ide-tape-update.patch
-intel-440gx-ids-fix.patch
-centrino-1ghz-support.patch
-document-elevator-equals.patch
-cpio-offset-fix.patch
-watchdog-retval-fix.patch
-document-lib-parser.patch
-cpumask-header-reorg.patch
-cpumask-format-consolidation.patch
-init-remove-CLONE_FILES.patch
-usb-msgsize-fix.patch
-pagefault-accounting-fix.patch
-pagefault-accounting-fix-fix.patch
-pagefault_accounting-fix-fix-fix-fix.patch
-proc_kill_inodes-oops-fix.patch
-proc_bus_pci_lseek-remove-lock_kernel.patch
-pagemap-include-recursion-fix.patch
-dm-bounce-buffer-fix.patch
-ia64-piix5-fix.patch
-ide-dma-disabled-fix.patch
-ext3-external-journal-bd_claim.patch
-x86_64-statfs64-fix-2.patch
-x86_64-aout-support.patch
-remove-mm-swap_address.patch
-sis-assignment-fix.patch
-sync_dquots-oops-fix.patch
-ext3-quota-deadlock-fix.patch
-buslogic-update.patch
-binfmt_elf-help-update.patch
-md-1-limit_max_sectors.patch
-md-2-set-ra_pages.patch
-do_gettimeofday-tick_usec-fix.patch
-dm-1-fix-block-device-resizing.patch
-dm-2-remove-dynamic-table-resizing.patch
-dm-3-v4-ioctl-default.patch
-dm-4-set-io-restriction-defaults.patch
-dm-5-sleep-in-spinlock-fix.patch
-fix-ELF-exec-with-huge-bss.patch
-direct-io-memleak-fix.patch
-jbd-b_committed_data-locking-fix.patch
-dvb-i2c-timeout-fix.patch
-compat_timespec-cleanup.patch
-MAINTAINERS-mailing-list-fixes.patch
-list_empty_careful-docco.patch
-compound-pages-dirty-page-fix.patch
-non-fg-console-unimap-fixes.patch
-jiffies-comment-fix.patch
-slab-reclaim-accounting-fix.patch
-struct_cpy-warning-fix.patch
-more-MODULE_ALIASes.patch
-nr-slab-accounting-fix.patch
-moto-ppc32-booting-fix.patch
-ppc-netboot-build-fixes.patch
-ppc-ksyms-build-fix.patch
-ppc-mkprep-solaris-fix.patch
-isdn-spinlock-init.patch
-nbd-userspace-build-fix.patch
-dac960-separate-queues.patch
-modpost-fix.patch
-ia32-jiffy-wrap-fixes.patch
-mm_core_waiters-synchronisation.patch
-rename-legacy_bus-to-platform_bus.patch
-ioctl-userspace-warnings-fix.patch
-tcrypt-cleanup-1.patch
-tcrypt-cleanup-2.patch
-tcrypt-module-unload-fix.patch
-w83627hf.patch
-get_user_pages-lockup-fix.patch
-sn2-maintainers-update.patch
-ide-capability-elevation-fix.patch
-ide-mmio-fix.patch
-scc-warning-fix.patch
-cycx-warning-fix.patch
-via-audio-fixes.patch
-locking-doc-update.patch
-name_to_dev_t-fix.patch
-ext3-enospc-accounting-fix.patch
-dvb-01-remove-firmware.patch
-dvb-02-update-saa7146-capture-core.patch
-dvb-03-bt8xx-driver.patch
-dvb-04-skystar2-update.patch
-dvb-05-core-update.patch
-dvb-06-frontend-update.patch
-dvb-07-av7110-update.patch
-dvb-08-av7110-firmware-loading.patch
-dvb-09-ttusb-dec-update.patch
-dvb-10-cleanup.patch
-dvb-11-firmware_class-update.patch
-dvb-12-documentation.patch
-selinux-separate-output-dir-fix.patch
-selinux-ioctl-check-fix.patch
-selinux-nameidata-oops-fix.patch
-selinux-signal-state-inheritance-control.patch
-isdn-compile-fix.patch
-ia32-GENERIC_ARCH-NUMA-build-fix.patch
-summit-ebda-parsing-fix.patch
-README-typo-fix.patch
-fatfs-log-storm-fix.patch
-gconfig-warning-fix.patch
-via-tsc-fix.patch
-fix-es7000-compile.patch
-fix-sx-stupidity.patch
-pcmcia-maintainers.patch
-yenta-printk-levels.patch
-pcnet_cs-fixes.patch
-pcmcia-16bit-interrupt-selection-fix.patch
-pcmcia-stack-reduction.patch
-i82365-pci-cruft-removal.patch
-proc-pid-maps-gate_map.patch
-buffer_error-suppression.patch
-main_c-cleanups.patch
-fat-01-relax-validity-tests.patch
-fat-02-utf8-tailing-dots-fix.patch
-fat-03-readv-writev-support.patch
-fat-04-printk-fix.patch
-fat-05-msdos_fs-h-cleanup.patch
-fat-06-fix-prev_free.patch
-fat-07-cluster-count-check.patch
-fat-08-misc-cleanups.patch
-fat-09-fat_striptail_len-retval-fix.patch
-fat-10-panic-removal.patch
-non-terminating-inflate-fix.patch
-non-terminating-inflate-fix-fix.patch
-execve-memleak-fix.patch
-h8300-bitops-update.patch
-document-speedstep-zero-page-usage.patch
-fbdev-printk-level-fix.patch
-ppdev-module-alias.patch
-floppy-typo-fixes.patch
-__BVEC_START-fix.patch
-kunmap_atomic-check-resched.patch
-free_pgt_generic1.patch
-SubmittingDrivers-update.patch
-mtd-build-fix.patch
-ali-ircc-update.patch
-remove-iso9660-size-check.patch
-raid1-resync-qlogic-crash-workaround.patch
-pci-clear-IORESOURCE_UNSET.patch
-log_buf_len_setup-irq-fix.patch
-shrink_slab-seeks-fix.patch
-ieee1394-update.patch
-kbuild-doc-typo-fix.patch
-CONFIG_GAMEPORT-documentation.patch
-reiserfs-silent-mode-fix.patch
-reiserfs-commit_max_age-mount-option.patch
-reiserfs_rename-ctime-update.patch
-documentation-ref-fixes.patch
-non-ia32-make-rpm-fix.patch
-sched-statfix-2.6.0-A3.patch
-x86_64-01.patch
-x86_64-02.patch
-x86_64-03.patch
-x86_64-04.patch
-x86_64-05.patch
-x86_64-06.patch
-x86_64-07.patch
-x86_64-08.patch
-x86_64-09.patch
-readahead-multiple-fixes.patch
-readahead-simplification.patch

 Merged

+psmouse-parameter-parsing-fix.patch

 psmouse parameter parsing fix

-sn2-console-driver-fix.patch
+sn-console-update.patch
+sn-serial-medusa-fix.patch

 Updated SN2 console fixes

-aic7xxx-aic79xx-update.patch

 Generated lots of rejects against jejb's recent update.

-pcibios_test_irq-fix.patch

 Dropped - was fixed differently.

-loop-remove-blkdev-special-case.patch
-loop-bio-handling-fix.patch
-loop-init-fix.patch
+loop-bio-index-fix.patch
+loop-bio-clone.patch
+loop-recycle.patch

 New set of loop fixes.

+timer_pm-wraparound-fixes.patch

 ACPI PM timer fixes

+percpu-gcc-34-warning-fix.patch

 Fix warnings with gcc-3.4

-atapi-mo-support-timeout-fix.patch

 This wasn't right.

+cdrom_open-fix.patch

 Fix CDROM opening problem.

+remove-CardServices-from-axnet_cs.patch

 A couple of CardServices stragglers

+CardServices-compatibility-layer.patch

 A little compatibility library for unconverted out-of-tree pcmcia drivers. 
 This is still under deliberation.

+vc-init-race-fix.patch

 Virtual console initialisation race fix

+trident-cleanup-B1-2.6.0.patch

 Trident fbdev driver cleanups and fixes

+kill_fasync-speedup.patch

 SMP speedup in kill_fasync()

+decrypt-CONFIG_PDC202XX_FORCE-help.patch

 Kconfig help improvements

+make-for_each_cpu-iterator-more-friendly.patch
+use-for_each_cpu-in-right-places.patch

 for_each_cpu() fixups

+fa311-mac-address-fix.patch

 Net driver fix

+kernel-locking-doc-end-tags-fix.patch

 Documentation fix

-lockmeter-sparc64-fix.patch
-lockmeter-sparc64-fix-fix.patch
-lockmeter-preemption-fixes.patch
-lockmeter-ia64-config-fix.patch
-lockmeter-does-not-require-CONFIG_X86_TSC.patch

 Folded into lockmeter.patch




All 186 patches:


mm.patch
  add -mmN to EXTRAVERSION

2.6.0-bk2-netdrvr-exp1.patch

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

RD1-cdrom_ioctl-B6.patch

RD2-ioctl-B6.patch

RD2-ioctl-B6-fix.patch
  RD2-ioctl-B6 fixes

RD3-cdrom_open-B6.patch

RD4-open-B6.patch

RD5-cdrom_release-B6.patch

RD6-release-B6.patch

RD7-presto_journal_close-B6.patch

RD8-f_mapping-B6.patch

RD9-f_mapping2-B6.patch

RD10-i_sem-B6.patch

RD11-f_mapping3-B6.patch

RD12-generic_osync_inode-B6.patch

RD13-bd_acquire-B6.patch

RD14-generic_write_checks-B6.patch

RD15-I_BDEV-B6.patch

cramfs-use-pagecache.patch
  cramfs: use pagecache better

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

net-jiffy-normalisation-fix.patch
  NET: Normalize jiffies reported to userspace, in neighbor management code

input-mousedev-remove-jitter.patch
  Input: smooth out mouse jitter

input-mousedev-ps2-emulation-fix.patch
  mousedev PS/@ emulation fix

psmouse-parameter-parsing-fix.patch
  PS2 mouse parameter parsing fix

input-use-after-free-checks.patch
  input layer debug checks

cpu_sibling_map-fix.patch
  cpu_sibling_map fix

acpi-20031203.patch

acpi-20031203-fix.patch

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-sched_clock-fix.patch
  implement sched_clock properly

ppc64-use-statfs64.patch
  use compat_statfs64 on ppc64

ppc64-compat_clock.patch
  ppc64: use compat clock syscalls

ppc64-numa-sign-extension-fix.patch
  ppc64: fix sign extension bug in NUMA code

ppc64-IRQ_INPROGRESS-fix.patch
  ppc64: revert IRQ_INPROGRESS change

sn-console-update.patch
  ia64 sn console fixes

sn-serial-medusa-fix.patch
  ia64 sn2 "medusa" serial console fix

qla1280-update.patch
  qla1280 update

sym-speed-fix.patch
  sym2 Ultra-160 fix

aic7xxx_old-proc-oops-fix.patch
  aic7x_old /proc oops fix

aic7xxx_old-oops-fix.patch

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

asus-L5-fix.patch
  Asus L5 framebuffer fix

jffs-use-daemonize.patch

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

loop-fix-hardsect.patch
  loop: fix hard sector size

loop-module-alias.patch
  loop needs MODULE_ALIAS_BLOCK

loop-bio-index-fix.patch
  loop bio indexing fix

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-bio-clone.patch
  loop bio clone optimisation

loop-recycle.patch
  loop bio recycling optimisation

acpi-pm-timer.patch
  ACPI PM Timer

acpi-pm-timer-fixes-2.patch
  ACPI PM timer fixes

timer_pm-verbose-timesource-fix.patch
  Subject: [PATCH] linux-2.6.0-test9-mm3_verbose-timesource-acpi-pm_A0

timer_pm-wraparound-fixes.patch
  timer_pm wraparound fixes

as-regression-fix.patch
  Fix IO scheduler regression

as-request-poisoning.patch
  AS: request poisoning

as-request-poisoning-fix.patch
  AS: request poisining fix

as-fix-all-known-bugs.patch
  AS fixes

as-new-process-estimation.patch
  AS: new process estimation

as-cooperative-thinktime.patch
  AS: thinktime improvement

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

radeon-line-length-fix.patch
  radeonfb fix

pnp-fix-1.patch
  PnP Fixes #1

pnp-fix-2.patch
  PnP Fixes #2

pnp-fix-3.patch
  PnP Fixes #3

alpha-stack-dump.patch

sysfs_remove_dir-vs-dcache_readdir-race-fix.patch
  sysfs_remove_dir Vs dcache_readdir race fix

page-alloc-failure-dump_stack.patch

invalidate_mmap_range-non-gpl-export.patch
  mark invalidate_mmap_range() as EXPORT_SYMBOL

alsa-sleep-in-spinlock-fix.patch
  ALSA sleep in spinlock fix

sym2-speed-selection-fix.patch
  Speed selection fix for sym53c8xx

ppc-export-consistent_sync_page.patch
  PPC32: Export consistent_sync_page.

ppc-use-EXPORT_SYMBOL_NOVERS.patch
  PPC32: Change all EXPORT_SYMBOL_NOVERS to EXPORT_SYMBOL in ppc_ksyms.c

ppc-CONFIG_PPC_STD_MMU-fix.patch
  PPC32: Select arch/ppc/kernel/head.S on CONFIG_PPC_STD_MMU.

ppc-IBM-MPC-header-cleanups.patch
  PPC32: Minor cleanups to IBM4xx and MPC82xx headers.

xfs-update-01.patch
  XFS update

jfs-nfs-le-fix.patch
  JFS fix for NFS on little-endian systems

percpu-gcc-34-warning-fix.patch
  fix gcc-3.4 warning in percpu code

atapi-mo-support.patch
  ATAPI MO drive support

mt-ranier-support.patch
  mt rainier support

atapi-mo-support-update.patch
  ATAPI MO support update

cdrom_open-fix.patch
  cdrom_open fix

alsa-gus-scheduling-in-interrupt-fix.patch
  alsa gus max schedule-in-irq-fix

ppp_async-locking-fix.patch
  Make ppp_async callable from hard interrupt

make-try_to_free_pages-walk-zonelist.patch
  make try_to_free_pages walk zonelist

make-try_to_free_pages-walk-zonelist-fix.patch
  zone scanning fix

remove-CardServices-from-pcmcia-net-drivers.patch
  CardServices() removal from pcmcia net drivers

remove-CardServices-from-ide-cs.patch
  From: Arjan van de Ven <arjanv@redhat.com>
  Subject: Re: [PATCH 1/10] CardServices() removal from pcmcia net drivers

remove-CardServices-from-drivers-net-wireless.patch
  remove CardServices() from drivers/net/wireless

remove-CardServices-from-drivers-serial.patch
  Remvoe CardServices() from drivers/serial

remove-CardServices-from-drivers-serial-fix.patch
  serial_cs CardServices removal fix

remove-CardServices-from-axnet_cs.patch
  remvoe CardServices from axnet_cs

remove-CardServices-final.patch
  final CardServices() removal patches

CardServices-compatibility-layer.patch
  CardServices compatibility layer

const-fixes.patch
  const vs. __attribute__((const)) confusion

s390-const-fixes.patch
  s390 const fixes

sysfs-oops-fix.patch
  fix sysfs oops

sysfs-add-simple-class-device-support.patch
  sysfs: add "simple" class device support

sysfs-remove-tty-class-device-logic.patch
  sysfs: remove tty class device logic

sysfs-add-mem-device-support.patch
  sysfs: add mem class

sysfs-add-misc-class.patch
  sysfs: add misc class

sysfs-add-vc-class.patch
  sysfs: add vc class

vc-init-race-fix.patch
  virtual consle initialisation race fix

sysfs-add-video-class.patch
  sysfs: add video class

pnp-bios-fix.patch
  From: Adam Belay <ambx1@neo.rr.com>
  Subject: Re: Fw: [Bugme-new] [Bug 1738] New: Oops when reading /proc/bus/pnp/devices or /proc/bus/pnp/escd (on final kernel!)

tridentfb-non-flatpanel-fix.patch
  fix for tridentfb.c usage on CRTs.

CONFIG_EPOLL-file_struct-members.patch
  CONFIG_EPOLL=n space reduction

epoll-oneshot-support.patch
  One-shot support for epoll

trident-cleanup-B1-2.6.0.patch

kill_fasync-speedup.patch
  kill_fasync speedup

o21-sched.patch
  O21 for interactivity 2.6.0

sched-clock-2.6.0-A1.patch
  Relax synchronization of sched_clock()

sched_clock-2.6.0-A1-deadlock-fix.patch
  ia32 sched_clock() deadlock fix

sched-can-migrate-2.6.0-A2.patch
  can_migrate_task cleanup

sched-cleanup-2.6.0-A2.patch
  CPU scheduler cleanup

sched-style-2.6.0-A5.patch
  sched.c style cleanups

decrypt-CONFIG_PDC202XX_FORCE-help.patch
  Change cryptic description and help for CONFIG_PDC202XX_FORCE

ide-tape-rq-special.patch

ide-siimage-seagate.patch

ide-siimage-stack-fix.patch

ide-siimage-sil3114.patch

ide-cmd640-pci1.patch

ide-pdc_old-pio-fix.patch

ide-pdc_old-udma66-fix.patch

ide-pdc_old-66mhz_clock-fix.patch

nforce2-disconnect-quirk.patch

nforce2-apic.patch

ide-recovery-time.patch

ide-pdc_new-proc.patch

make-for_each_cpu-iterator-more-friendly.patch
  Make for_each_cpu() Iterator More Friendly

use-for_each_cpu-in-right-places.patch
  Use for_each_cpu() Where It's Meant To Be

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

kernel-locking-doc-end-tags-fix.patch
  Missing end tags in kernel-locking kerneldoc

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

printk-oops-mangle-fix.patch
  disentangle printk's whilst oopsing on SMP

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

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

ppc-fixes.patch
  make mm4 compile on ppc

O_DIRECT-race-fixes-rollup.patch
  DIO fixes forward port and AIO-DIO fix
  O_DIRECT race fixes comments
  O_DRIECT race fixes fix fix fix
  DIO locking rework
  O_DIRECT XFS fix

dio-aio-fixes.patch
  direct-io AIO fixes

dio-aio-fixes-fixes.patch
  dio-aio fix fix

aio-sysctl-parms.patch
  aio sysctl parms

aio-01-retry.patch
  AIO: Core retry infrastructure
  Fix aio process hang on EINVAL
  AIO: flush workqueues before destroying ioctx'es
  AIO: hold the context lock across unuse_mm
  task task_lock in use_mm()

4g4g-aio-hang-fix.patch
  Fix AIO and 4G-4G hang

aio-retry-elevated-refcount.patch
  aio: extra ref count during retry

aio-splice-runlist.patch
  Splice AIO runlist for fairer handling of multiple io contexts

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait
  lock_buffer_wq fix

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-06-bread_wq.patch
  AIO: Async block read

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

O_SYNC-speedup-2.patch
  speed up O_SYNC writes

O_SYNC-speedup-2-f_mapping-fixes.patch

aio-09-o_sync.patch
  aio O_SYNC
  AIO: fix a BUG
  Unify o_sync changes for aio and regular writes
  aio-O_SYNC-fix bits got lost
  aio: writev nr_segs fix
  More AIO O_SYNC related fixes

aio-09-o_sync-f_mapping-fixes.patch

gang_lookup_next.patch
  Change the page gang lookup API

aio-gang_lookup-fix.patch
  AIO gang lookup fixes

aio-O_SYNC-short-write-fix.patch
  Fix for O_SYNC short writes

aio-12-readahead.patch
  AIO: readahead fixes
  aio O_DIRECT no readahead
  Unified page range readahead for aio and regular reads

aio-12-readahead-f_mapping-fix.patch

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup



