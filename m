Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbUAEIVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 03:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbUAEIVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 03:21:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:59577 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265049AbUAEIU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 03:20:56 -0500
Date: Mon, 5 Jan 2004 00:20:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.1-rc1-mm2
Message-Id: <20040105002056.43f423b1.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1-rc1/2.6.1-rc1-mm2


Many new fixes, all over the place.


Changes since 2.6.1-rc1-mm1:

-2.6.0-bk2-netdrvr-exp1.patch
+2.6.0-rc1-netdrvr-exp1.patch

 Updated experimental net driver patch

+msi-build-fix.patch

 Compile fixes

+x86_64-memset-fix.patch

 x86_64 fix

+input-01-i8042-suspend.patch
+input-02-i8042-option-parsing.patch
+input-03-psmouse-option-parsing.patch
+input-04-atkbd-option-parsing.patch
+input-05-missing-module-licenses.patch
+input-06-Kconfig-Synaptics-help.patch
+input-07-sis-aux-port.patch
+input-11-98busmouse-compile-fix.patch
+input-12-mouse-drivers-use-module_param.patch
+input-13-tsdev-use-module_param.patch

 Input driver updates

-ppc64-sched_clock-fix.patch
-ppc64-use-statfs64.patch
-ppc64-compat_clock.patch
-ppc64-numa-sign-extension-fix.patch
+ppc64-syscall6-macro.patch
+ppc64-sched_clock-2.patch
+ppc64-32bit-compat-update.patch
+ppc64-OF-device-tree-update.patch
+ppc64-numa-sign-extension-fix-2.patch

 ppc64 update.  This is broken and will be redone.

-pnp-fix-1.patch

 This keeps crashing people's computers.

-page-alloc-failure-dump_stack.patch

 The printk ratelimiting patch does this now.

+nr_requests-oops-fix.patch

 Fix oops writing to /sys/block/md0/nr_requests

+netfilter_bridge-compile-fix.patch

 Build fix

+aacraid-warning-fix.patch

 Warning fix

-sysfs-add-vc-class.patch

 Drop this for now - it triggers a weird tty/vt oops for some people.

-trident-cleanup-B1-2.6.0.patch

 This has been split up

+for_each_cpu-oprofile-fix.patch
+for_each_cpu-oprofile-fix-2.patch

 Fix build errors arising from use-for_each_cpu-in-right-places.patch

+rcupdate-c99-initialisers.patch

 Use c99 iniialisers.

+68k-339.patch
+68k-340.patch
+68k-341.patch
+68k-342.patch
+68k-343.patch
+68k-344.patch
+68k-345.patch
+68k-346.patch
+68k-347.patch
+68k-348.patch
+68k-349.patch
+68k-350.patch
+68k-351.patch
+68k-352.patch
+68k-353.patch
+68k-354.patch
+68k-355.patch
+68k-359.patch
+68k-360.patch
+68k-361.patch
+68k-364.patch
+68k-365.patch
+68k-366.patch
+68k-367.patch
+68k-368.patch
+68k-369.patch
+68k-374.patch
+68k-375.patch
+68k-377.patch
+68k-378.patch
+68k-379.patch
+68k-380.patch
+68k-381.patch
+68k-382.patch
+68k-383.patch
+68k-384.patch
+68k-385.patch
+68k-386.patch
+68k-387.patch
+68k-390.patch

 Most of the m68k update.  Also some non-m68k things which I haven't looked
 at yet.

+printk_ratelimit.patch
+printk_ratelimit-fix.patch

 Infrastructure for limiting printk frequency.  Use it in the page allocator.

+freevxfs-MODULE_ALIAS.patch

 vxfs fixlet.

+trident-cleanup-indentation-D1-2.6.0.patch
+trident-sound-driver-fixes.patch
+trident-cleanup-2.patch

 Reworked trident driver cleanups and fixes.

+compound-page-page_count-fix.patch

 Fix page_count() for compound pages.

+inia100-fix.patch

 SCSI driver fix

+MAINTAINERS-lanana-update.patch

 MAINTAINERS update

+devfs-joystick-fix.patch

 Fix devfs registration

+s3-sleep-remove-debug-code.patch

 Cleanup

+swsusp-doc-updates.patch

 Documentation

+watchdog-updates.patch

 Lots of little watchdog driver changes

+ext2_new_inode-cleanup.patch
+ext2-s_next_generation-fix.patch
+ext3-s_next_generation-fix.patch

 Locking and initialisation fixes for ext2/3 inode generation counters.

+cpufreq-memleak-fix.patch

 fix a memory leak

+alt-arrow-console-switch-fix.patch

 Fix rotation through virtual terminals with arrow keys

+ia32-remove-SIMNOW.patch

 Remove some gunk.

+softcursor-fix.patch

 Fix softcursor.

+ext2-debug-build-fix.patch

 Fix compilation when EXT2_DEBUG is turned on.

+efi-inline-fixes.patch

 Fix strange inlinings.

+do_timer_gettime-cleanup.patch

 Uninline do_timer_gettime(), give it static scope.

+set_cpus_allowed-locking-fix.patch
+set_cpus_allowed-locking-fix-fix.patch

 Fix locking in set_cpus_allowed()

+rmmod-race-fix.patch

 Module fix

+remove-hpet-intel-check.patch

 Generalise the HPET code

+devfs-d_revalidate-oops-fix.patch

 devfs fix

+laptop-mode-2.patch

 The `laptop mode' patch.  I haven't really looked at this yet.

+e1000-1019-fix.patch

 Unbreak the e1000 driver

+ali-m1533-hang-fix.patch

 Fix hangs with this sound driver.

+alpha-relocation-fix.patch

 Module fix for Alpha CPUs

-dio-aio-fixes-fixes.patch

 Folded into dio-aio-fixes.patch

+aio-fallback-bio_count-race-fix-2.patch

 AIO/direct-io fixes




All 253 patches


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

2.6.0-rc1-netdrvr-exp1.patch

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

msi-build-fix.patch
  MSI build fixes

radeon-line-length-fix.patch
  radeonfb fix

sysfs-oops-fix.patch
  fix sysfs oops

x86_64-memset-fix.patch
  Fix memset on x86-64

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

ppc64-syscall6-macro.patch
  add syscall6 macro to ppc64

ppc64-sched_clock-2.patch
  ppc64: add sched_clock

ppc64-32bit-compat-update.patch
  ppc64: 32bit compat update

ppc64-OF-device-tree-update.patch
  ppc64: Change to new OF device tree API

ppc64-numa-sign-extension-fix-2.patch
  ppc64: fix sign extension in numa code

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

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

pnp-fix-2.patch
  PnP Fixes #2

pnp-fix-3.patch
  PnP Fixes #3

alpha-stack-dump.patch

sysfs_remove_dir-vs-dcache_readdir-race-fix.patch
  sysfs_remove_dir Vs dcache_readdir race fix

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

nr_requests-oops-fix.patch
  Fix oops when modifying /sys/block/dm-0/queue/nr_requests

netfilter_bridge-compile-fix.patch

aacraid-warning-fix.patch
  aacraid warning fix

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

sysfs-add-simple-class-device-support.patch
  sysfs: add "simple" class device support

sysfs-remove-tty-class-device-logic.patch
  sysfs: remove tty class device logic

sysfs-add-mem-device-support.patch
  sysfs: add mem class

sysfs-add-misc-class.patch
  sysfs: add misc class

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
  do not wrongly override mp_ExtINT IRQ

ide-recovery-time.patch

ide-pdc_new-proc.patch

make-for_each_cpu-iterator-more-friendly.patch
  Make for_each_cpu() Iterator More Friendly

use-for_each_cpu-in-right-places.patch
  Use for_each_cpu() Where It's Meant To Be

for_each_cpu-oprofile-fix.patch
  for_each_cpu oprofile fix

for_each_cpu-oprofile-fix-2.patch

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

68k-359.patch
  Mac ESP SCSI setup

68k-360.patch
  Mac SCSI

68k-361.patch
  Macfb setup

68k-364.patch
  Mac ADB

68k-365.patch
  ncr53c7xx SCSI

68k-366.patch
  BVME6000 SCSI

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

68k-378.patch
  Amiga NCR53c710 SCSI

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

68k-384.patch
  NCR53C9x SCSI inline

68k-385.patch
  Cirrusfb extern inline

68k-386.patch
  Genrtc warning

68k-387.patch
  M68k Documentation

68k-390.patch
  Amiga Buddha/CatWeasel IDE

amd-k8-fixes.patch
  AGP Fixes for K8 for 2.6.1rc1

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

inia100-fix.patch
  fix inia100 driver

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

ext2_new_inode-cleanup.patch
  ext2_new_inode nanocleanup

ext2-s_next_generation-fix.patch
  ext2: s_next_generation locking

ext3-s_next_generation-fix.patch
  ext3: s_next_generation fixes

cpufreq-memleak-fix.patch
  cpufreq: powernow-k8 memory leak fix

alt-arrow-console-switch-fix.patch
  Fix Alt-arrow console switch droppage

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

set_cpus_allowed-locking-fix-fix.patch
  fix set_cpus_allowed locking even more

rmmod-race-fix.patch
  module removal race fix

remove-hpet-intel-check.patch
  Remove Intel check in i386 HPET code

devfs-d_revalidate-oops-fix.patch
  devfs d_revalidate race/oops fix

laptop-mode-2.patch
  laptop-mode for 2.6, version 6

e1000-1019-fix.patch
  e1000: device 1019 fix

ali-m1533-hang-fix.patch
  ALI M1533 audio hang fix

alpha-relocation-fix.patch
  Handle R_ALPHA_REFLONG relocation on Alpha

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
  dio-aio fix fix

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix

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


