Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVAESER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVAESER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVAESER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:04:17 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:43755 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262517AbVAESDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:03:40 -0500
Subject: 2.6.10-mm1 panic in sysfs ?
From: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-xWEEGQ92jNBDIX6IYAip"
Organization: 
Message-Id: <1104946602.4000.22.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jan 2005 09:36:42 -0800
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xWEEGQ92jNBDIX6IYAip
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

I get a panic in sysfs_readdir() while booting 2.6.10-mm1
kernel. Known fixes ?

Thanks,
Badari



--=-xWEEGQ92jNBDIX6IYAip
Content-Disposition: attachment; filename=sysfs-panic.out
Content-Type: text/plain; name=sysfs-panic.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

ACPI: Subsystem revision 20041210
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LMXC] (IRQs *9)
ACPI: PCI Interrupt Link [LMXD] (IRQs *9)
ACPI: PCI Interrupt Link [LPET] (IRQs *11)
ACPI: PCI Interrupt Link [LMVI] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [LP1A] (IRQs) *0
ACPI: PCI Interrupt Link [LM1B] (IRQs *11)
ACPI: PCI Interrupt Link [LPUS] (IRQs *15)
ACPI: PCI Root Bridge [PCI2] (00:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Interrupt Link [LPSA] (IRQs *10)
ACPI: PCI Interrupt Link [LPSB] (IRQs *10)
ACPI: PCI Interrupt Link [LP5A] (IRQs) *0
ACPI: PCI Interrupt Link [LM5B] (IRQs *15)
ACPI: PCI Interrupt Link [LP6A] (IRQs) *0
ACPI: PCI Interrupt Link [LM6B] (IRQs *9)
ACPI: PCI Root Bridge [PCI5] (00:05)
PCI: Probing PCI hardware (bus 05)
ACPI: PCI Interrupt Link [LP2A] (IRQs) *0
ACPI: PCI Interrupt Link [LM2B] (IRQs *15)
ACPI: PCI Interrupt Link [LP3A] (IRQs) *0
ACPI: PCI Interrupt Link [LM3B] (IRQs *11)
ACPI: PCI Interrupt Link [LP4A] (IRQs *10)
ACPI: PCI Interrupt Link [LM4B] (IRQs *26)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PnPBIOS: Disabled by ACPI
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:01: ioport range 0x438-0x439 has been reserved
pnp: 00:01: ioport range 0x430-0x437 has been reserved
pnp: 00:0e: ioport range 0x600-0x600 has been reserved
pnp: 00:0e: ioport range 0x900-0x90f has been reserved
pnp: 00:0e: ioport range 0x374-0x375 has been reserved
pnp: 00:0e: ioport range 0x377-0x377 has been reserved
pnp: 00:0e: ioport range 0xf50-0xf58 has been reserved
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS not found.
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
vesafb: probe of vesafb0 failed with error -6
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC0] at I/O 0x3f0-0x3f5 irq 6 dma channel 2
ACPI: [FDC0] doesn't declare FD_DCR; also claiming 0x3f7
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
pcnet32.c:v1.30i 06.28.2004 tsbogend@alpha.franken.de
ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
pcnet32: PCnet/FAST III 79C975 at 0x2200, 00 02 55 fc 48 4b assigned IRQ 16.
eth0: registered as PCnet/FAST III 79C975
pcnet32: 1 cards_found.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 0000:00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0x0708-0x070f, BIOS settings: hdc:pio, hdd:pio
hda: LG CD-ROM CRD-8484B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
PCI: Enabling device 0000:02:01.0 (0156 -> 0157)
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Enabling device 0000:02:01.1 (0156 -> 0157)
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 18 (level, low) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
                                                                 
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
                                                                 
(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM-PSG   Model: ST318451LC    !#  Rev: B833
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM-PSG   Model: ST318451LC    !#  Rev: B833
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM       Model: YGLv3 S2          Rev: 0
  Type:   Processor                          ANSI SCSI revision: 02
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 35548320 512-byte hdwr sectors (18201 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 35548320 512-byte hdwr sectors (18201 MB)
SCSI device sdb: drive cache: write through
 sdb: unknown partition table
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
input: PC Speaker
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
Starting balanced_irq
ACPI wakeup devices:
PCI0
ACPI: (supports S0 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 256k freed
INIT: version 2.85 booting
System Boot Control: Running /etc/init.d/boot
Mounting /proc filesystem                                            done
Mounting sysfs on /sys                                               done
Mounting /dev/pts                                                    done
Mounting shared memory FS on /dev/shmmodules/2.6.10-mm1kexec/modules.done No sucshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking root file system...
fsck 1.34 (25-Jul-2003)not load /lib/modules/2.6.10-mm1kexec/modules.dep: No suc[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/sda3
/dev/sda3: clean, 309188/1933312 files, 2175742/3863632 blocks       done
EXT3 FS on sda3, internal journal
Activating device mapper... 4) is a 16550A
FATAL: Could not lmd: raidstart(pid 1142) used deprecated START_ARRAY ioctl. This will not be supported beyond 2.6                                   done
oad /lib/modules/2.6.10-mm1kexecmd: could not open unknown-block(8,32).
/modules.dep: Nomd: autostart failed!
 such file or dimd: raidstart(pid 1142) used deprecated START_ARRAY ioctl. This
will not be supported beyond 2.6
rectory
device-mapper kernel momd: could not open unknown-block(8,176).
dule not loaded:md: autostart failed!
 can't create /dmd: raidstart(pid 1142) used deprecated START_ARRAY ioctl. This
Initializing Multiple Devices...
considering /dev/md0...
/demd: could not open unknown-block(65,0).
v/md0 is persistmd: autostart failed!
ent, skipping.
modprobe: FATAL: Could not load /lib/modules/2.6.10-mm1kexec/modules.dep: No such file or directory
 
modprobe: FATAL: Could not load /lib/modules/2.6.10-mm1kexec/modules.depmd: Autodetecting RAID arrays.
: No such file omd: autorun ...
r directory
 
md: ... autorun DONE.
/dev/md0: Invalid argument
modprobe: FATAL: Could not load /lib/modules/2.6.10-mm1kexec/modules.dep: No such file or directory
 
modprobe: FATAL: Could not load /lib/modules/2.6.10-mm1kexec/modules.dep: No such file or directory
 
/dev/md1: Invalid argument
modprobe: FATAL: Could not load /lib/modules/2.6.10-mm1kexec/modules.dep: No such file or directory
 
modprobe: FATAL: Could not load /lib/modules/2.6.10-mm1kexec/modules.dep: No such file or directory
 
/dev/md2: Invalid argument
modprobe: FATAL: Could not load /lib/modules/2.6.10-mm1kexec/modules.dep: No such file or directory
 
modprobe: FATAL: Could not load /lib/modules/2.6.10-mm1kexec/modules.dep: No such file or directory
 
/dev/md3: Invalid argument
Scanning for LVM volume groups...
  Reading all physical volumes.  This may take a while...
  No volume groups found
Activating LVM volume groups...
  No volume groups found
                                                                     skipped
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking file systems...
fsck 1.34 (25-Jul-2003)
Checking all file systems.
[/sbin/fsck.ext2 (1) -- /boot] fsck.ext2 -a /dev/sda1
/dev/sda1 was not cleanly unmounted, check forced.
/dev/sda1: 64/52208 files (18.8% non-contiguous), 46757/208812 blocksdone
Setting up                                                           done
Mounting local file systems...
proc on /proc type proc (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/sda1 on /boot type ext2 (rw,acl,user_xattr)
Loading required kernel modules /lib/modules/2.6.10-mm1kexec/modules.done No sucRestore device permissions                                           done
Disk /dev/sdb doesn't contain a valid partition table
Activating remaining swap-devices in /etc/fstab...
Adding 2104504k swap on /dev/sda2.  Priority:42 extents:1xec/modules.done No sucSetting up the CMOS clock                                            done
Setting up timezone data                                             done
Setting scheduling timeslices rted by kernel                         unused
Setting up hostname 'elm3b81'                                        done
Setting up loopback interface     lo
    lo        IP address: 127.0.0.1/8
                                                                     done
Enabling syn flood protection                                        done
Disabling IP forwarding                                              done
                                                                     done
Creating /var/log/boot.msg                                           done
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
System Boot Control: The system has been                             set up
Skipped features:                                  boot.cycle boot.sched
System Boot Control: Running /etc/init.d/boot.local                  done
INIT: Entering runlevel: 1
Boot logging started on /dev/ttyS0(/dev/console) at Wed Jan  5 00:33:53 2005
Master Resource Control: previous runlevel: N, switching to runlevel:1
Hotplug is already active  (disable with  NOHOTPLUG=1 at the boot prodone
coldplug scanning input: ***                                         done
         scanning pci: ****.W*.*..*Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c109c8ef
*pde = 0191c001
Oops: 0000 [#1]
SMP
Modules linked in:
CPU:    2
EIP:    0060:[<c109c8ef>]    Not tainted VLI
EFLAGS: 00010282   (2.6.10-mm1kexec)
EIP is at sysfs_readdir+0xef/0x280
eax: 00000000   ebx: c15e1160   ecx: 0000000c   edx: 00000020
esi: c15e1164   edi: c15dd72d   ebp: c1a7df78   esp: c1a7df3c
ds: 007b   es: 007b   ss: 0068
Process getcfg (pid: 1927, threadinfo=c1a7c000 task=c2ba3040)
Stack: 00000001 00000000 00000017 00000004 c156d62c 0000000c c15dd720 c21bf324
       c156d620 c1071f80 c1a7dfa0 c1c837e0 c131caa0 c1c837e0 c1587428 c1a7df94
       c1071e48 c1a7dfa0 c1071f80 c1a7c000 0804f944 fffffff7 c1a7dfbc c10720aa
Call Trace:
 [<c1004dc6>] show_stack+0xa6/0xb0
 [<c1004f42>] show_registers+0x152/0x1c0
 [<c100514d>] die+0xed/0x180
 [<c1018b6d>] do_page_fault+0x45d/0x6e9
 [<c1004a2b>] error_code+0x2b/0x30
 [<c1071e48>] vfs_readdir+0x98/0xb0
 [<c10720aa>] sys_getdents+0x6a/0xd0
 [<c1003f31>] sysenter_past_esp+0x52/0x75
Code: eb 89 d8 e8 c4 ea ff ff 89 45 dc b9 ff ff ff ff 31 c0 8b 7d dc f2 ae f7 d1 49 89 4d d8 8b 43 20 85 c0 0f 84 37 01 00 00 8b 40 0c <8b> 50 20 0f b7 43 1c 89 54 24 08 c1 e8 0c 89 44 24 0c 8b 4d f0
                                         




--=-xWEEGQ92jNBDIX6IYAip--

