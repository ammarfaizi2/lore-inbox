Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUAPHBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 02:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265278AbUAPHBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 02:01:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:24199 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265291AbUAPG7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 01:59:40 -0500
Date: Thu, 15 Jan 2004 22:59:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.1-mm4
Message-Id: <20040115225948.6b994a48.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/


- There's a patch here which changes the ia32 CPU type selection.  Make
  sure you go in there and select the right CPU type(s), else the kernel
  won't compile.   We might need to set a default here.

- Kernel NFS server update

- MD update

- V4L update

- A string of fixes against the parport, paride and associated drivers

- Update to the latest UML

- Patches to support gcc-3.4 on ia32.  There is more to do here - more
  warnings need to be fixed and the exception tables need to be sorted.  I
  didn't add the `-Winline' patch because it's way too noisy at present.




Changes since 2.6.1-mm3:


 linus.patch

 Latest Linus tree

-scsi-rename-TIMEOUT.patch
-qla1280-update-2.patch
-qla1280-build-fix.patch
-sym-speed-fix.patch
-sym2-speed-selection-fix.patch
-aacraid-warning-fix.patch
-68k-359.patch
-68k-360.patch
-68k-365.patch
-68k-366.patch
-68k-378.patch
-68k-384.patch
-inia100-fix.patch
-mremap-dosemu-fix.patch
-symbios-build-fix.patch

 Merged

-aic7xxx_old-proc-oops-fix.patch
-aic7xxx_old-oops-fix.patch

 These broke.

+qla2xxx-build-fix.patch

 Fix the new qlogic driver for older gcc's

-2.6.1-bk1-netdev4.patch
+netdev.patch

 Recentish jgarzik tree

-keyboard-scancode-fix.patch
+keyboard-scancode-fixes.patch
+input-use-after-free-checks.patch
-input-print-screen-emulation-fix.patch
-input-use-after-free-checks.patch
+psmouse-timeout-parity-fixes.patch

 More keyboard/mouse fixes

+acpi-frees-irq0.patch

 ACPI fix.

-loop-bio-index-fix.patch
-loop-bio-clone.patch
-loop-recycle.patch
+loop-bio-handling-fix.patch
+loop-init-fix.patch

 Go back to the loop patches which work.

+alsa-pnp-fix.patch

 Fix PNP+ALSA combination

-sysfs_remove_dir-vs-dcache_readdir-race-fix.patch

 This seems to be causing oopses

-sysfs-add-simple-class-device-support.patch
-sysfs-remove-tty-class-device-logic.patch
-sysfs-add-mem-device-support.patch
-sysfs-add-misc-class.patch
-vc-init-race-fix.patch
-sysfs-add-video-class.patch
-sysfs-add-oss-class.patch
-sysfs-add-alsa-class.patch
-sysfs-add-input-class-support.patch
+sysfs-class-01-simple.patch
+sysfs-class-02-input.patch
+sysfs-class-03-lp.patch
+sysfs-class-04-mem.patch
+sysfs-class-05-misc.patch
+sysfs-class-06-raw.patch
+sysfs-class-07-oss-sound.patch
+sysfs-class-08-alsa-sound.patch
+sysfs-class-09-cleanup-tty.patch
+sysfs-class-10-vc.patch

 New sysfs simple-class support

+sched-clock-fixes.patch
+sched-build-fix.patch
+p4-clockmod-sibling-map-fix.patch
+sched-sync-rt-wakeup-fix.patch

 CPU scheduler-related fixups

+eicon-buffer-allocation-fixes.patch

 ISDN driver fix

-libata-update.patch
+2.6.1-bk2-libata1.patch

 New libata update patch

+limit-hash-table-size-2.patch

 Allow larger dentry+inode hashtable sizes on monster 64-bit boxen

+readahead-revert-lazy-readahead.patch

 Revert a bit more of the recent readahead rework -it wasn't nice to NFS.

+better-i386-cpu-selection.patch

 Finer-grained ia32 CPU type selection

+serial-02-fixups-fix.patch
+serial-02-fixes-fix-2.patch
+serial-03-fixups-fix.patch
+serial-03-fixups-fix-2.patch

 Fix compile breakages

-increase-MAX_MP_BUSSES.patch

 This is still under discussion

+remove-null-initialisers.patch

 Small bss savings

+nuke-noisy-printks.patch

 Less bootup messages

+ppc-cond_syscall-fix.patch

 ppc32 build fix

+PP0-full_list-RC1.patch
+PP1-parport_locking-RC1.patch
+PP2-enumerate1-RC1.patch
+PP2-enumerate1-RC1-fix.patch
+PP3-parport_gsc-RC1.patch
+PP4-bwqcam-RC1.patch
+PP5-daisy-RC1.patch
+PI0-schedule_claimed-RC1.patch
+PI1-expansion-RC1.patch
+PI2-crapectomy-RC1.patch
+PI3-ps_ready-RC1.patch
+PI4-pd_busy-RC1.patch
+PI5-do_pd_io-RC1.patch
+PI6-bogus_requests-RC1.patch
+PI7-claim_reorder-RC1.patch
+PI8-do_pd_request1-RC1.patch
+PI9-run_fsm-RC1.patch
+PI10-action-RC1.patch
+PI11-disconnect-RC1.patch
+PI12-unclaim-RC1.patch
+PI13-run_fsm-loop-RC1.patch
+PI14-next_request-RC1.patch
+PI15-do_pd_io-gone-RC1.patch
+PI16-pd_claimed-RC1.patch
+PI17-connect-RC1.patch
+PI18-reorder-RC1.patch
+PI19-special1-RC1.patch
+PI20-gendisk_setup-RC1.patch
+PI21-present-RC1.patch
+PI22-pd_init_units-RC1.patch
+PI23-special2-RC1.patch
+PI24-paride64-RC1.patch
+IMM0-lindent-RC1.patch
+IMM1-references-RC1.patch
+IMM2-claim-RC1.patch
+IMM3-scsi_module-RC1.patch
+IMM4-imm_probe-RC1.patch
+IMM5-imm_wakeup-RC1.patch
+IMM6-imm_hostdata-RC1.patch
+IMM7-imm_attach-RC1.patch
+PPA0-ppa_lindent-RC1.patch
+PPA1-ppa_references-RC1.patch
+PPA2-ppa_claim-RC1.patch
+PPA3-ppa_scsi_module-RC1.patch
+PPA4-ppa_probe-RC1.patch
+PPA5-ppa_wakeup-RC1.patch
+PPA6-ppa_hostdata-RC1.patch
+PPA7-ppa_attach-RC1.patch
+PPA8-ppa_lock_fix-RC1.patch

 parport/paride cleanups/fixes

+document-efi-zero-page-usage.patch

 Documentation

+v4l-01-videodev-update.patch
+v4l-02-v4l2-update.patch
+v4l-03-video-buf-update.patch
+v4l-04-bttv-driver-update.patch
+v4l-05-infrared-remote-support.patch
+v4l-06-misc-i2c-fixes.patch
+v4l-07-tuner-update.patch
+v4l-08-bttv-IR-input-support.patch
+v4l-09-saa7134-update.patch
+v4l-10-conexant-2388x-driver.patch

 V4L update

+request-origination-determination-fix.patch

 Sanify the way in which we determine where a disk request came from

+ppc-module-skip-debug-sections.patch

 ppc module loading fix/speedup

+MAINTAINERS-oprofile-update.patch

 MAINTAINERS update

+md-01-set_disk_faulty-return-code-fix.patch
+md-02-rebuild-needs-yield.patch
+md-03-resync-interrupt-fix.patch
+md-04-typo-fix.patch
+md-05-recovery-fix.patch
+md-06-do_md_run-fix.patch
+md-07-superblock-writing-fixes.patch
+md-08-remove-disks-array.patch
+md-09-discard-mddev_map-array.patch
+md-10-use-bd_disk-private_data.patch

 MD update

+nfsd-01-stale-filehandles-fixes.patch
+nfsd-02-failed-lookup-status-fix.patch
+nfsd-03-follow_up-fix.patch
+nfsd-04-add-dnotify-events.patch
+nfsd-05-SUN-NFSv2-hack.patch
+nfsd-06-SVCFH_fmt-is-extern.patch

 kNFSD update

+ghash.patch
+tty_io-uml-fix.patch
+uml-update.patch

 UML update

+proc_dma_open-simplification.patch

 Code simplification

+rq_for_each_bio-fix.patch

 Avoid possible problems with macro expansion

+remove-afs-strdup.patch

 Remove dead code

+uninline-bitmap-functions.patch
+sock_put-inline-fix.patch
+add-noinline-attribute.patch
+use-funit-at-a-time.patch
+add-config-for-mregparm-3.patch
+add-config-for-mregparm-3-make-EXPERIMENTAL.patch
+add-module-magic-for-mregparm3.patch
+#add-W-inline.patch
+fix-x86_64-gcc-34-warnings.patch
+fix-more-gcc-34-warnings.patch
+gcc-34-string-fixes.patch

 Patches to take advantage of gcc-3.4 features, and fixups for gcc-3.4.




All 620 patches:

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

qla2xxx-build-fix.patch
  fix qla2xxx build for older gcc's

sh-merge.patch
  SH Merge

sh-kyrofb-support.patch
  kyrofb support

alsa-101.patch
  ALSA 1.0.1

alsa-cmipci-joystick-fix.patch

netdev.patch

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

kgdb-x86_64-support.patch
  kgdb for x86_64 2.6 kernels

kgdb-x86_64-build-fix.patch
  fix x86_64 build with CONFIG_KGDB=n

radeon-line-length-fix.patch
  radeonfb line length fix

loop-fix-hardsect.patch
  loop: fix hard sector size

loop-fd-leak-fix.patch
  loop: fix file refcount leak

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

modular-ide-is-broken.patch
  document in must-fix that modular IDE is

RD1-open-mm.patch

RD2-release-mm.patch

RD3-presto_journal_close-mm.patch

RD4-f_mapping-mm.patch

RD5-f_mapping2-mm.patch

RD6-i_sem-mm.patch

RD7-f_mapping3-mm.patch

RD8-generic_osync_inode-mm.patch

RD9-bd_acquire-mm.patch

RD10-generic_write_checks-mm.patch

RD11-I_BDEV-mm.patch

cramfs-use-pagecache.patch
  cramfs: use pagecache better

raw-driver-refcounting-fix.patch
  raw.c refcounting fix

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

net-jiffy-normalisation-fix.patch
  NET: Normalize jiffies reported to userspace, in neighbor management code

input-mousedev-remove-jitter.patch
  Input: smooth out mouse jitter

input-mousedev-ps2-emulation-fix.patch
  mousedev PS/@ emulation fix

input-01-i8042-suspend.patch
  input: i8042 suspend

input-02-i8042-option-parsing.patch
  input: i8042 option parsing

input-03-psmouse-option-parsing.patch
  input: psmouse option parsing

input-04-atkbd-option-parsing.patch
  input: atkbd option parsing

input-05-missing-module-licenses.patch
  input: missing module licenses

input-06-Kconfig-Synaptics-help.patch
  Kconfig Synaptics help

input-07-sis-aux-port.patch
  input: SiS AUX port

input-11-98busmouse-compile-fix.patch
  Fix compile error in 98busmouse.c module

input-12-mouse-drivers-use-module_param.patch
  Convert mouse drivers to use module_param

input-13-tsdev-use-module_param.patch
  Convert tsdev to use module_param

keyboard-scancode-fixes.patch
  keyboard scancode fixes

input-use-after-free-checks.patch
  input layer debug checks

synaptics-rate-switching.patch
  Synaptics rate switching

psmouse-drop-timed-out-bytes.patch
  psmouse: log and discard timed out bytes

psmouse-timeout-parity-fixes.patch
  input: psmouse timeout&parity fixes

cpu_sibling_map-fix.patch
  cpu_sibling_map fix

acpi-20031203.patch

acpi-20031203-fix.patch

acpi-frees-irq0.patch
  acpi frees free irq0

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-WARN_ON.patch
  [ppc64] clean up WARN_ON backtrace

ppc64-IRQ_INPROGRESS.patch
  [ppc64] revert IRQ_INPROGRESS change

ppc64-zImage_default.patch
  [ppc64] Build the zImage by default

ppc64-biarch.patch
  [ppc64] add automatic check for biarch compilers

ppc64-PT_FPSCR_fix.patch
  [ppc64] ptrace.h PT_FPSCR fixup, from Will Schmidt

ppc64-writelogbuffer.patch
  [ppc64] HvCall_writeLogBuffer called with too large of a buffer

ppc64-phandle.patch
  [ppc64]  support for ibm,phandle OF property, from Dave Engebretsen:

ppc64-of_traversal_api.patch
  [ppc64] New Open Firmware device tree API, from Nathan Lynch

ppc64-of_traversal_api_2.patch
  [PPC64] Change to new OF device tree API, from Nathan Lynch

ppc64-vty_node.patch
  [ppc64] vty updates, from Hollis Blanchard

ppc64-hvc_console.patch
  [ppc64] hvc_console can only handle vty nodes compatible with "hvterm1", from Hollis Blanchard

ppc64-device_is_compatible.patch
  [ppc64] use device_is_compatible() instead of manual strcmp, from Hollis Blanchard

ppc64-smp_call_function.patch
  [ppc64] Make IPI receivers survive a late arrival after the sender has given up waiting, from Olof Johansson

ppc64-device_tree_updates.patch
  [ppc64] support for runtime updates of /proc/device-tree, from Nathan Lynch

ppc64-device_tree_updates_2.patch
  [ppc64] base support for dynamic update of OF device, tree from Nathan Lynch

ppc64-trivial.patch
  [ppc64] various trivial patches

ppc64-device_tree_updates_3.patch
  [ppc64] Open Firmware device tree manipulation support, from Nathan Lynch

ppc64-ioremap_rework.patch
  [ppc64] Mem-map I/O changes, from Mike Wolf

ppc64-rtas_flash.patch
  [ppc64] extended flash changes, from Mike Wolf

ppc64-cputable.patch
  [ppc64] cputable update, from Dave Engebretsen

ppc64-cputable_2.patch
  [ppc64] cputable cleanup, from Dave Engebretsen:

ppc64-remove_MAX_PROCESSORS.patch
  [ppc64] iSeries fixups, from Stephen Rothwel

ppc64-rtas_functions.patch
  [ppc64] Add some rtas calls, from John Rose

ppc64-rtas_rename.patch
  [ppc64] rename the rtas event classes to avoid namespace collisions, from John Rose

ppc64-stupidnumabug.patch
  [ppc64] fix sign extension bug in NUMA code

ppc64-devinit_fixes.patch
  [ppc64] Add exports and change some __init to __devinit for dynamic OF and pci hotplug, from John Rose and Linda Xie

ppc64-syscall6.patch
  [ppc64] Add _syscall6, from Olaf Hering

ppc64-sched_clock.patch
  [ppc64] fix sched_clock, from Paul Mackerras:

ppc64-compat_update.patch
  [ppc64] compat layer update, from Paul Mackerras, Olaf Hering and myself

ppc64-sys_rtas.patch
  [ppc64] add rtas syscall, from John Rose

ppc64-sharedproc.patch
  [ppc64] shared processor support, from Dave Engebretsen

ppc64-logical_cpu.patch
  [ppc46] SMT processor support and logical cpu numbering, from Dave Engebretsen

ppc64-UP_cleanup.patch
  [ppc64] UP compile fixes, from Paul Mackerras

ppc64-add_vmx.patch
  [ppc64] Add VMX registers to sigcontext, from Steve Munroe

ppc64-missing_sync.patch
  [ppc64] one instruction fix for synchronization bug found during cpu DLPAR development, from Joel Schopp

ppc64-nvram_rewrite.patch
  [ppc64] NVRAM error logging/buffering patch, from Jake Moilanen

ppc64-iseries_support.patch
  [ppc64] preliminary iseries support, from Paul Mackerras

ppc64-hcall_constants.patch
  [ppc64] Add additional hypervisor call constants, from Dave Boutcher

ppc64-iseries_cleanup.patch
  [ppc64] iSeries fixes, from Stephen Rothwell

ppc64-device_tree_updates_fix.patch
  [ppc64] fix a couple small OF device tree bugs which were overlooked, from Joel Schopp

ppc64-iseries_cleanup_2.patch
  [ppc64] Tidy up various bits of the iSeries code. No significant code changes, from Stephen Rothwell

ppc64-remove-veth-proc.patch
  [ppc64] Small cleanups to iSeries virtual ethernet driver, from Dave Gibson

ppc64-add_hcall.patch
  [ppc64] add hcall interface

ppc64-addvio.patch
  [ppc64] VIO support, from Dave Boutcher, Hollis Blanchard and Santiago Leon

ppc64-iseries_pci.patch
  [ppc64] Get native PCI going on iSeries, from Paul Mackerras

ppc64-lparcfg.patch
  [ppc64] add/forward port of lparcfg, from Will Schmidt

ppc64-surveillance.patch
  [ppc64] Update the surveillance boot parameter to allow all valid settings of the surveillance timeout, from Nathan Fontenot

ppc64-power4fix.patch
  [ppc64] fix POWER3 boot

ppc64-vmxsupport.patch
  [ppc64] VMX (Altivec) support & signal32 rework, from Ben Herrenschmidt

ppc64-hash_page_race.patch
  [ppc64] Fix {pte,pmd}_free vs. hash_page race by relaying actual deallocation with RCU, from Ben Herrenschmidt

ppc64-hash_page_rewrite.patch
  [ppc64] __hash_page rewrite, from Ben Herrenschmidt

ppc64-mf_proc_cleanup.patch
  [ppc64] Tidy up the mf_proc code, from Stephen Rothwell

ppc64-prom_panic.patch
  [ppc64] prom_panic(), from Todd Inglett

ppc64-iseries_pci_2.patch
  [ppc64] Check range of PCI memory and I/O accesses on iSeries, from Stephen Rothwell

ppc64-iseries_fixes.patch
  [ppc64] Fix a compile error and a warning in the iSeries code, from Stephen Rothwell

ppc64-viopath_fix.patch
  [ppc64] Use an atomic_t instead of a volatile unsigned long, from Stephen Rothwell

ppc64-makefile_fixes.patch
  [ppc64] Makefile fixes

ppc64-vmlinux_lds.patch
  [ppc64] vmlinux.lds fixes, from Alan Modra

ppc64-setup_cpu.patch
  [ppc64] setup_cpu must be called on boot cpu

ppc64-epoll.patch
  [ppc64] correct epoll syscall names

ppc64-compat_stat.patch
  [ppc64] cp_compat_stat should copy nanosecond fields

ppc64-xmon_fixes.patch
  [ppc64] xmon breakpoint and single step on LPAR fixes from John Rose

ppc64-rtas_delay.patch
  [ppc64] Fixed rtas_extended_busy_delay_time() to calculate correct value, from John Rose

ppc64-bss_clear.patch
  [ppc64] early BSS clear, from Ben Herrenschmidt

ppc64-vio-fixup.patch
  [ppc64] vio fixup

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ramdisk-leak-fix.patch
  fix memory leak in ram disk

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

loop-module-alias.patch
  loop needs MODULE_ALIAS_BLOCK

loop-remove-blkdev-special-case.patch

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-bio-handling-fix.patch
  loop: BIO handling fix

loop-init-fix.patch
  loop.c doesn't fail init gracefully

acpi-pm-timer-3.patch
  ACPI PM timer version 3

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

as-tuning.patch
  AS tuning

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

pnp-fix-2.patch
  PnP Fixes #2

pnp-fix-3.patch
  PnP Fixes #3

alsa-pnp-fix.patch
  ALSA pnp fix

alpha-stack-dump.patch

invalidate_mmap_range-non-gpl-export.patch
  mark invalidate_mmap_range() as EXPORT_SYMBOL

ppc-export-consistent_sync_page.patch
  PPC32: Export consistent_sync_page.

ppc-use-EXPORT_SYMBOL_NOVERS.patch
  PPC32: Change all EXPORT_SYMBOL_NOVERS to EXPORT_SYMBOL in ppc_ksyms.c

ppc-CONFIG_PPC_STD_MMU-fix.patch
  PPC32: Select arch/ppc/kernel/head.S on CONFIG_PPC_STD_MMU.

ppc-IBM-MPC-header-cleanups.patch
  PPC32: Minor cleanups to IBM4xx and MPC82xx headers.

percpu-gcc-34-warning-fix.patch
  fix gcc-3.4 warning in percpu code

nr_requests-oops-fix.patch
  Fix oops when modifying /sys/block/dm-0/queue/nr_requests

netfilter_bridge-compile-fix.patch

atapi-mo-support.patch
  ATAPI MO drive support

mt-ranier-support.patch
  mt rainier support

atapi-mo-support-update.patch
  ATAPI MO support update
  cdrom_open fix

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

sysfs-class-01-simple.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add class_simple support [01/10]

sysfs-class-02-input.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for input devices [02/10]

sysfs-class-03-lp.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add class support for lp devices [03/10]

sysfs-class-04-mem.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for mem devices [04/10]

sysfs-class-05-misc.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for misc devices [05/10]

sysfs-class-06-raw.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for raw devices [06/10]

sysfs-class-07-oss-sound.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for OSS sound devices [07/10]

sysfs-class-08-alsa-sound.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for ALSA sound devices [08/10]

sysfs-class-09-cleanup-tty.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] clean up sysfs class support for tty devices [09/10]

sysfs-class-10-vc.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for vc devices [10/10]

tridentfb-non-flatpanel-fix.patch
  fix for tridentfb.c usage on CRTs.

CONFIG_EPOLL-file_struct-members.patch
  CONFIG_EPOLL=n space reduction

epoll-oneshot-support.patch
  One-shot support for epoll

kill_fasync-speedup.patch
  kill_fasync speedup

o21-sched.patch
  O21 for interactivity 2.6.0

sched-clock-2.6.0-A1.patch
  Relax synchronization of sched_clock()

sched-can-migrate-2.6.0-A2.patch
  can_migrate_task cleanup

sched-cleanup-2.6.0-A2.patch
  CPU scheduler cleanup

sched-style-2.6.0-A5.patch
  sched.c style cleanups

make-for_each_cpu-iterator-more-friendly.patch
  Make for_each_cpu() Iterator More Friendly

make-for_each_cpu-iterator-more-friendly-fix.patch
  Fix alpha build failure

make-for_each_cpu-iterator-more-friendly-fix-fix.patch

use-for_each_cpu-in-right-places.patch
  Use for_each_cpu() Where It's Meant To Be

for_each_cpu-oprofile-fix.patch
  for_each_cpu oprofile fix

for_each_cpu-oprofile-fix-2.patch

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

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT

acpi-numa-printk-level-fixes.patch
  ACPI NUMA quiet printk and cleanup

sched-sync-rt-wakeup-fix.patch
  sched: fix sync wakeups of RT tasks

decrypt-CONFIG_PDC202XX_FORCE-help.patch
  Change cryptic description and help for CONFIG_PDC202XX_FORCE

ide-siimage-seagate.patch

ide-siimage-stack-fix.patch

ide-siimage-sil3114.patch

ide-pdc_old-pio-fix.patch

ide-pdc_old-udma66-fix.patch

ide-pdc_old-66mhz_clock-fix.patch

ide-pdc_new-proc.patch

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

kernel-locking-doc-end-tags-fix.patch
  Missing end tags in kernel-locking kerneldoc

rcupdate-c99-initialisers.patch
  C99 change to rcupdate.h

68k-339.patch
  M68k floppy selection

68k-340.patch
  M68k head console

68k-341.patch
  M68k head unused

68k-342.patch
  M68k head comments

68k-343.patch
  M68k head pic

68k-344.patch
  M68k head white space

68k-345.patch
  M68k cache mode

68k-346.patch
  M68k RMW accesses

68k-347.patch
  Atari Hades PCI C99

68k-348.patch
  Amiga sound C99

68k-349.patch
  BVME6000 RTC C99

68k-350.patch
  M68k symbol exports

68k-351.patch
  M68k math emu C99

68k-352.patch
  MVME16x RTC C99

68k-353.patch
  Q40 interrupts C99

68k-354.patch
  Sun-3 ID PROM C99

68k-355.patch
  Mac ADB IOP fix

68k-361.patch
  Macfb setup

68k-364.patch
  Mac ADB

68k-367.patch
  Amiga Gayle IDE cleanup

68k-368.patch
  Amiga Gayle E-Matrix 530 IDE

68k-369.patch
  Zorro sysfs/driver model

68k-374.patch
  Amiga debug fix

68k-375.patch
  Mac II VIA

68k-377.patch
  M68k asm/system.h

68k-379.patch
  Amiga core C99

68k-380.patch
  M68k has no VGA/MDA

68k-381.patch
  M68k thread

68k-382.patch
  M68k thread_info

68k-383.patch
  M68k extern inline

68k-385.patch
  Cirrusfb extern inline

68k-386.patch
  Genrtc warning

68k-387.patch
  M68k Documentation

68k-390.patch
  Amiga Buddha/CatWeasel IDE

printk_ratelimit.patch
  generalise net_ratelimit (printk_ratelimit)

printk_ratelimit-fix.patch
  parintk_ratelimit fix

freevxfs-MODULE_ALIAS.patch
  MODULE_ALIAS for freevxfs

trident-cleanup-indentation-D1-2.6.0.patch
  reindent trident OSS sound driver

trident-sound-driver-fixes.patch
  trident OSS sound driver fixes

trident-cleanup-2.patch
  trident: use pr_debug instead of home-brewed TRDBG

compound-page-page_count-fix.patch
  fix page counting for compound pages

MAINTAINERS-lanana-update.patch
  MAINTAINERS update

devfs-joystick-fix.patch
  fix devfs names for joystick

s3-sleep-remove-debug-code.patch
  s3 sleep: Kill obsolete debugging code

swsusp-doc-updates.patch
  swsusp/sleep documentation update

watchdog-updates.patch
  Watchdog patches

watchdog-updates-2.patch
  Watchdog patches (part 2)

ext2_new_inode-cleanup.patch
  ext2_new_inode nanocleanup

ext2-s_next_generation-fix.patch
  ext2: s_next_generation locking

ext3-s_next_generation-fix.patch
  ext3: s_next_generation fixes

alt-arrow-console-switch-fix.patch
  Fix Alt-arrow console switch droppage

alt-arrow-console-switch-fix-2.patch
  Alt-arrow console switch #2

ia32-remove-SIMNOW.patch
  Remove x86_64 leftover SIMNOW code

softcursor-fix.patch
  Fix softcursor

ext2-debug-build-fix.patch
  ext2: fix build when EXT2_DEBUG is set

efi-inline-fixes.patch
  Fix weird placement of inline

do_timer_gettime-cleanup.patch
  do_timer_gettime() cleanup

set_cpus_allowed-locking-fix.patch
  set_cpus_allowed locking
  fix set_cpus_allowed locking even more

rmmod-race-fix.patch
  module removal race fix

remove-hpet-intel-check.patch
  Remove Intel check in i386 HPET code

devfs-d_revalidate-oops-fix.patch
  devfs d_revalidate race/oops fix

laptop-mode-2.patch
  laptop-mode for 2.6, version 6

laptop-mode-doc-update.patch
  Documentation/laptop-mode.txt

laptop-mode-2-doc-updates.patch
  laptop-mode documentation updates

ali-m1533-hang-fix.patch
  ALI M1533 audio hang fix

start_this_handle-retval-fix.patch
  jbd: start_this_handle() return value fix

remove-eicon-isdn-driver.patch
  remove old Eicon isdn driver

eicon-memory-access-size-fix.patch
  Eicon isdn driver hardware access fix

eicon-buffer-allocation-fixes.patch
  Eicon isdn driver alloc buffer size fix

do_no_page-leak-fix.patch
  do_no_page leak fix

vt-locking-fixes-2.patch
  VT locking patch #2

pid_max-fix.patch
  Bug when setting pid_max > 32k

allow-SGI-IOC4-chipset-support.patch
  allow SGI IOC4 chipset support

oss-dmabuf-deadlock-fix.patch
  OSS dmabuf deadlock fix

workqueue-cleanup.patch
  Remove redundant code in workqueue.c

2.6.1-bk2-libata1.patch

tridentfb-documentation-fix.patch
  tridentfb documentation fix

proc_pid_lookup-speedup.patch
  Optimize proc_pid_lookup

bio_endio-clarifications.patch
  clarify meaning of bio fields in the end_io function

rtc-leak-fixes.patch
  2.6.1 RTC leaks.

simplify-node-zone-fields-3.patch
  Simplify node/zone field in page->flags

radeonfb-pdi-id-addition.patch
  Identify RADEON Yd in radeonfb

mpt-fusion-update.patch
  MPT Fusion driver 3.00.00 update

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

sis-DRM-floating-point-removal.patch
  Remove float from sis DRM

drm-include-fix.patch

raid6-20040107.patch
  RAID-6

raid6-readahead-fix.patch
  RAID-6 readahead fix

kthread-primitive.patch
  kthread primitive

use-kthread-primitives.patch
  Use kthread primitives

alpha-module-relocation-overflow-fix.patch
  Relocation overflow with modules on Alpha

ppc32-of-bootwrapper-support.patch
  ppc32: OF bootwrapper support

lsi-megaraid-pci-id.patch
  LSI Logic MegaRAID3 PCI ID

ide-pci-modules-fix.patch
  fix issues with loading PCI IDE drivers as modules

use-diff-dash-p.patch
  Fix Documentation/SubmittingPatches to use -p

use-kconfig-range-for-NR_CPUS.patch
  Kconfig: use range for NR_CPUS

sysfs-pin-kobject.patch
  sysfs: pin kobjects to fix use-after-free crashes

bio-documentation-update.patch
  bio documentation update

limit-hash-table-sizes.patch
  Subject: Limit hash table size

limit-hash-table-size-2.patch
  hash table size limiting: huge 64-bit fixes

add-SIOCSIFNAME-compat-ioctl.patch
  Add SIOCSIFNAME compat ioctl

disable-G400-DRM-on-x86_64.patch
  Disable G400 DRM driver on x86-64

x86_64-merge.patch
  x86-64 merge for 2.6.1

init-zone-priorities.patch
  vmscan: initialize zone->{prev,temp}_priority

readahead-partial-backout.patch
  radahead part-backout

readahead-revert-lazy-readahead.patch
  readaheadL revert lazy readahead

menuconfig-exit-code-fix.patch
  kconfig: fix menuconfig exit code

slab-poison-hex-dumping.patch
  slab: hexdump for check_poison

p4-clockmod-cpu-detection-fix.patch
  fix up CPU detection in p4-clockmod

suspend-resume-for-PIT.patch
  suspend/resume support for PIT

truncated-module-check-2.patch
  check for truncated modules

alpha-prefetch_spinlock-fix.patch
  Alpha: make prefetch_spinlock() a no-op on UP

proc-pid-maps-gate-fixes.patch
  Fix statically declare FIXMAPs

tmpfs-readdir-atime-fix.patch
  tmpfs readdir does not update dir atime

blockdev-bd_private.patch
  Add bdev private field

ext3-journal-mode-fix.patch

pentium-m-support.patch
  add Pentium M and Pentium-4 M options

old-gcc-supports-k6.patch
  gcc 2.95 supports -march=k6 (no need for check_gcc)

amd-elan-is-a-different-subarch.patch
  AMD Elan is a different subarch

better-i386-cpu-selection.patch
  better i386 CPU selection

efi-conditional-cleanup.patch
  Arrange for EFI-related code to be compiled away

gcc-3_4-needs-attribute_used.patch
  make gcc 3.4 compilation work

serial-01-fixups.patch
  Serial fixups (mostly tested)

serial-02-fixups.patch
  serial fixups (untested)

serial-02-fixups-fix.patch
  serial-02 fixes

serial-02-fixes-fix-2.patch
  serial-02 fixes

serial-03-fixups.patch
  more serial driver fixups

serial-03-fixups-fix.patch
  serial-03 fixes

serial-03-fixups-fix-2.patch
  serial-03 fixes

BUG-to-BUG_ON.patch
  if ... BUG() -> BUG_ON()

sysrq_key_table_key2index-fix.patch
  sysrq_key_table_key2index() fixlets

set_scheduler-fix.patch
  setscheduler fix

usr-isapnp-modem-support.patch
  isapnp modem addition

ia32-MSI-vector-handling-fix.patch
  ia32 MSI vector handling fix

load_elf_interp-error-case-fix.patch
  fix error case in binfmt_elf.c:load_elf_interp

remove-null-initialisers.patch
  remove null-ilizers

nuke-noisy-printks.patch
  quiet down SMP boot messages

ppc-cond_syscall-fix.patch
  ppc cond_syscall fix

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

selinux-01-resource-limit-control.patch
  selinux: Add resource limit control

selinux-02-netif-controls.patch
  selinux: add netif controls

selinux-03-node-controls.patch
  selinux: Add node controls

selinux-04-node_bind-control.patch
  selinux: Add node_bind control

selinux-05-socket_has_perm-cleanup.patch
  selinux: socket_has_perm cleanup

selinux-06-SO_PEERSEC-getpeersec.patch
  selinux: Add SO_PEERSEC socket option and getpeersec LSM hook.

selinux-07-add-dname-to-audit-output.patch
  selinux: Add dname to audit output when a path cannot be generated.

selinux-makefile-cleanup.patch
  selinux: Makefile cleanup

selinux-improve-skb-audit-logging.patch
  selinux: improve skb audit logging

selinux-SEND_MSG-RECV_MSG-controls.patch
  Add SEND_MSG and RECV_MSG controls

nfs-fix-bogus-setattr-calls.patch
  NFS: fix bogus setattr calls

nfs-optimise-COMMIT-calls.patch
  nfs: Optimize away unnecessary NFSv3 COMMIT calls.

nfs-open-intent-fix.patch
  nfs: Fix an open intent bug

nfs-readonly-mounts-fix.patch
  nfs: Fix readonly mounts

nfs-client-deadlock-fix.patch
  nfs: Fix a possible client deadlock

nfs-rpc-debug-oops-fix.patch
  nfs: Fix an Oops in the RPC debug code...

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

m68knommu-module-support.patch
  allow for building module support for m68knommu architecture

m68knommu-module-support-2.patch
  add module support for m68knommu architecture

m68knommu-sched_clock.patch
  sched_clock() for m68knommu architectures

m68knommu-include-fix.patch
  m68knommu include fix

m68knommu-cpustats-fix.patch
  fix cpu stats in m68knommu entry.S

m68knommu-types-cleanup.patch
  use m68k/types.h for m68knommu

m68knommu-find_extend_vma.patch
  implement find_extend_vma() for nommu

s390-01-base.patch
  s390: general update

s390-02-common-io-layer.patch
  s390: common i/o layer

s390-03-console-driver.patch
  s390: console driver.

s390-04-dasd-driver.patch
  s390: dasd driver

s390-05-tape-driver.patch
  s390: tape driver.

s390-06-network-drivers.patch
  s390: network drivers

s390-07-zfcp-host-adapter.patch
  s390: zfcp host adapter

s390-07-zfcp-host-adapter-update.patch
  zfcp host adapter patch cleanup

s390-08-new-3270-driver.patch
  s390: new 3270 driver.

s390-09-32-bit-emulation-fixes.patch
  s390: 32 bit emulation fixes.

s390-10-32-bit-ioctl-emulation-fixes.patch
  s390: 32 bit ioctl emulation fixes.

s390-11-tlb-flush-optimisation.patch
  s390: tlb flush optimization.

s390-12-dirty-referenced-bits.patch
  s390: physical dirty/referenced bits.

s390-13-tlb-flush-race-fix.patch
  s390: tlb flush race.

s390-14-rmap-optimisation.patch
  s390: rmap optimization.

s390-14-rmap-optimisation-2.patch
  rmap page refcounting simplification

s390-15-superfluous-flush_tlb_range-calls.patch
  s390: superflous flush_tlb_range calls.

s390-16-follow_page-lockup-fix.patch
  s390: endless loop in follow_page.

const-fixes.patch
  const vs. __attribute__((const)) confusion

sn01.patch
  sn: Some hwgraph code clean up

sn03.patch
  sn: copyright update

sn05.patch
  sn: namespace cleanup: ioerror_dump->sn_ioerror_dump

sn06.patch
  sn: kill big endian stuff

sn07.patch
  sn: kill $Id$

sn08.patch
  sn: remove unused enum

sn09.patch
  From: Pat Gefre <pfg@sgi.com>
  Subject: Re: [PATCH] Updating our sn code in 2.6] - Patch 009

sn10.patch
  sn: Kill nag.h

sn11.patch
  sn: Kill the arcs/*.h files

sn12.patch
  sn: Delete invent.h

sn13.patch
  sn: General code clean up of sn/io/io.c

sn14.patch
  sn: machvec/pci.c clean up

sn15.patch
  sn: General clean up of xbow.c

sn16.patch
  sn: Remove the bridge and xbridge code - everything not PIC

sn17.patch
  sn: Fix the last patch - missed an IS_PIC_SOFT and needed the CG definition

sn18.patch
  sn: Fix the last patch - missed an IS_PIC_SOFT and needed the CG definition

sn19.patch
  sn: New code for Opus and CGbrick

sn20.patch
  sn: klgraph.c clean up

sn21.patch
  sn: More klgraph.c clean up

sn22.patch
  sn: General module.c clean up

sn23.patch
  sn: shubio.c cleanup

sn24.patch
  sn: General xtalk.c clean up

sn25.patch
  sn: irq clean up and update

sn26.patch
  sn: code pruning - a couple of adds due to the clean up

sn27.patch
  sn: Fix a couple of compiler warnings

sn28.patch
  sn: hcl.c clean up for init failures and OOM

sn29.patch
  sn: Some small bte code clean ups

sn30.patch
  sn: Moved code out of pciio and into its own file - snia_if.c and renamed the functions

sn31.patch
  sn: A few small clean ups

sn32.patch
  sn: Some more minor clean up

sn33.patch
  sn: Remove __ASSEMBLY__ tags from shubio.h

sn34.patch
  sn: Small check for invalid node in shub ioctl function

sn35.patch
  sn: More code clean up - this time ioconfig_bus.c

sn36.patch
  sn: Code changes for interrupt redirect

sn37.patch
  sn: Forget to check in the _reg file

sn38.patch
  sn: Merged 2 files into another (sgi_io_sim and irix_io_init into sgi_io_init)

sn39.patch
  sn: Support for the LCD

sn40.patch
  sn: Missed an include file in the last patch

sn41.patch
  sn: One less panic

sn42.patch
  sn: SAL interface clean up

sn43.patch
  sn: Fixes for shuberror.c

sn44.patch
  sn: Need a bigger max compact node value

sn45.patch
  sn: Use numionodes

sn46.patch
  sn: Change the definition and usage of iio_itte - make it an array

sn47.patch
  sn: Debug clean up in pcibr_dvr.c

sn48.patch
  sn: New pci provider interfaces

sn49.patch
  sn: Fix IIO_ITTE_DISABLE() args

sn50.patch
  sn: Added a missed opus mod and oom mod

sn51.patch
  sn: Added cbrick_type_get_nasid() function

sn52.patch
  sn: Clean up the bit twiddle macros in pcibr_config.c

sn53.patch
  sn: Fixed an oom in pci_bus_cvlink.c

sn54.patch
  sn: Remove the pcibr_wrap... functions

sn55.patch
  sn: printk cleanup

sn56.patch
  sn: pci dma cleanup

sn57.patch
  sn: Make pcibr debug variables static

sn58.patch
  sn: Include file clean up in pcibr_hints.c

sn59.patch
  sn: Added call to pcireg_intr_status_get

sn60.patch
  sn: More code clean up = mostly pcibr_slot.c

sn61.patch
  sn: pcibr_rrb.c cleanup

sn62.patch
  sn: Minor code clean up of pcibr_error.c

sn63.patch
  sn: sn_pci_fixup() clean up or is it fix up ???

sn65.patch
  sn: Remove irix_io_init - replace with sgi_master_io_infr_init

sn66.patch
  sn: Don't call init_hcl from the fixup code

sn67.patch
  sn: Error devenable not used - delete defs

sn68.patch
  sn: Delete unused code in pcibr_slot.c

sn69.patch
  sn: Delete unused pciio.c code (???_host???_[sg]et)

sn70.patch
  sn: Minor clean up for ml_iograph.c

sn71.patch
  sn: Simulator check in pci_bus_cvlink.c

sn73.patch
  sn: Mostly printk clean up and remove some dead code

sn74.patch
  sn: A little re-formatting

sn75.patch
  sn: cleanups and error checking

document-efi-zero-page-usage.patch
  Document EFI zero-page usage

v4l-01-videodev-update.patch
  [v4l] videodev update

v4l-02-v4l2-update.patch
  [v4l] v4l2 update

v4l-03-video-buf-update.patch
  [v4l] video-buf update

v4l-04-bttv-driver-update.patch
  [v4l] bttv driver update

v4l-05-infrared-remote-support.patch
  [v4l] add infrared remote support

v4l-06-misc-i2c-fixes.patch
  [v4l] misc i2c fixes

v4l-07-tuner-update.patch
  [v4l] tuner update

v4l-08-bttv-IR-input-support.patch
  [v4l] add bttv IR input support.

v4l-09-saa7134-update.patch
  [v4l] saa7134 driver update

v4l-10-conexant-2388x-driver.patch
  [v4l] add conexant 2388x driver.

request-origination-determination-fix.patch
  Use request_list as indicator that req originated from ll_rw_blk

ppc-module-skip-debug-sections.patch
  modules: skip debug sections

MAINTAINERS-oprofile-update.patch
  update OProfile maintainer

md-01-set_disk_faulty-return-code-fix.patch
  md: fix return code in set_disk_faulty()

md-02-rebuild-needs-yield.patch
  md: Don't allow raid5 rebuild to swamp raid5 stripe cache

md-03-resync-interrupt-fix.patch
  md: Make sure an interrupted resync doesn't seem to have completed.

md-04-typo-fix.patch
  md: Fix typo in comment

md-05-recovery-fix.patch
  md: Make sure md recovery happens appropriately.

md-06-do_md_run-fix.patch
  md: Don't do_md_stop and array when do_md_run fails.

md-07-superblock-writing-fixes.patch
  md: Small fixes for timely writing of md superblocks.

md-08-remove-disks-array.patch
  md: Remove the 'disks' array from md which holds the gendisk structures.

md-09-discard-mddev_map-array.patch
  md: Discard the mddev_map array.

md-10-use-bd_disk-private_data.patch
  md: Use bd_disk->private data instead of bd_inode->u.generic_ip

nfsd-01-stale-filehandles-fixes.patch
  kNFSd: Fix problem with stale filehandles.

nfsd-02-failed-lookup-status-fix.patch
  kNFSd: Convert error status for failed lookup("..") properly.

nfsd-03-follow_up-fix.patch
  kNFSd: Fix incorrect call for follow_up

nfsd-04-add-dnotify-events.patch
  kNFSd: Make sure dnotify events happen for NFS read and write.

nfsd-05-SUN-NFSv2-hack.patch
  kNFSd: Honour SUN NFSv2 hack for "set times to server time.

nfsd-06-SVCFH_fmt-is-extern.patch
  kNFSd: Move SVCFH_fmt from being 'inline' to being 'extern'.

ghash.patch
  ghash.h from 2.4

tty_io-uml-fix.patch
  uml: make tty_init callable from UML functions

uml-update.patch
  UML update

proc_dma_open-simplification.patch
  cleanup single_open usage in dma.c

rq_for_each_bio-fix.patch
  rq_for_each_bio fix

remove-afs-strdup.patch
  remove spurious strdup

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

uninline-bitmap-functions.patch
  uninline bitmap functions

sock_put-inline-fix.patch

add-noinline-attribute.patch
  Add noinline attribute

use-funit-at-a-time.patch
  Use -funit-at-a-time when possible

add-config-for-mregparm-3.patch
  Add CONFIG for -mregparm=3

add-config-for-mregparm-3-make-EXPERIMENTAL.patch

add-module-magic-for-mregparm3.patch
  Add -mregparm info to module versioning

fix-x86_64-gcc-34-warnings.patch
  Fix gcc 3.4 warnings in x86-64

fix-more-gcc-34-warnings.patch
  Fix more gcc 3.4 warnings

gcc-34-string-fixes.patch
  string fixes for gcc 3.4

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

4g4g-acpi-low-mappings-fix.patch
  4g/4g PAE ACPI low mappings fix

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
  dio-aio fix fix

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix

aio-sysctl-parms.patch
  aio sysctl parms



