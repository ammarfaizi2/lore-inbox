Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268715AbTBZL2T>; Wed, 26 Feb 2003 06:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268716AbTBZL2T>; Wed, 26 Feb 2003 06:28:19 -0500
Received: from barclay.balt.net ([195.14.162.78]:51315 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id <S268715AbTBZL2N>;
	Wed, 26 Feb 2003 06:28:13 -0500
Date: Wed, 26 Feb 2003 13:37:18 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: lkml <linux-kernel@vger.kernel.org>
Subject: kernel Ooops (2.5.63 bk latest)
Message-ID: <20030226113718.GA3568@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

$ mount
/dev/ide/host0/bus0/target0/lun0/part5 on / type ext3
(rw,errors=remount-ro)
proc on /proc type proc (rw)
/dev/ide/host0/bus0/target0/lun0/part11 on /tmp type ext3 (rw)
/dev/ide/host0/bus0/target0/lun0/part6 on /boot type ext3 (rw)
/dev/ide/host0/bus0/target0/lun0/part8 on /usr type ext3 (rw)
/dev/ide/host0/bus0/target0/lun0/part9 on /home type ext3 (rw)
/dev/ide/host0/bus0/target0/lun0/part10 on /var type ext3 (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
automount(pid4452) on /mnt type autofs
(rw,fd=5,pgrp=4452,minproto=2,maxproto=4)
//192.168.2.123/exchange on /mnt/exchange type smbfs (rw)
//192.168.2.123/install on /mnt/install type smbfs (rw)

XMMS is stuck in D state. 
/mnt/exchange and /mnt/install are mounted of windows 2k server.

the decoded oops and dmesg are attached below.


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=feb26-dmesg

Linux version 2.5.63 (root@swoop) (gcc version 3.2.3 20030221 (Debian prerelease)) #1 Wed Feb 26 10:41:33 EET 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffd0000 (usable)
 BIOS-e820: 000000000ffd0000 - 000000000fff0c00 (reserved)
 BIOS-e820: 000000000fff0c00 - 000000000fffc000 (ACPI NVS)
 BIOS-e820: 000000000fffc000 - 0000000010000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65488
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61392 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 COMPAQ                     ) @ 0x000f9970
ACPI: RSDT (v001 COMPAQ CPQ004A  08721.00544) @ 0x0fff0c84
ACPI: FADT (v002 COMPAQ CPQ004A  00000.00002) @ 0x0fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 00000.04097) @ 0x0fff65d4
ACPI: SSDT (v001 COMPAQ   CPQMag 00000.04097) @ 0x0fff66e2
ACPI: DSDT (v001 COMPAQ  EVON800 00001.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: root=/dev/hda5 ro
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1694.400 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3342.33 BogoMIPS
Memory: 256152k/261952k available (1620k kernel code, 5088k reserved, 567k data, 112k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Machine check exception polling timer started.
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.70GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030122
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: Power Resource [C141] (off)
ACPI: Power Resource [C155] (off)
ACPI: Power Resource [C159] (off)
ACPI: Power Resource [C15D] (off)
ACPI: Power Resource [C166] (on)
ACPI: Power Resource [C0CF] (on)
ACPI: Power Resource [C1D5] (off)
ACPI: Power Resource [C1D6] (off)
ACPI: Power Resource [C1D7] (off)
ACPI: Power Resource [C1D8] (off)
Linux Plug and Play Support v0.95 (c) Adam Belay
pnp: Enabling Plug and Play Card Services.
PnPBIOS: Found PnP BIOS installation structure at 0xc00f3d30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x3d5e, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: IRQ 0 for device 02:0e.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 02:0e.1
PCI: Sharing IRQ 10 with 02:08.0
PCI: Sharing IRQ 10 with 02:0e.0
PCI: Sharing IRQ 10 with 02:0e.2
PCI: Cannot allocate resource region 0 of device 02:0e.2
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: AC Adapter [C11B] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [C000] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [TZ1] (55 C)
ACPI: Thermal Zone [TZ2] (48 C)
ACPI: Thermal Zone [TZ3] (16 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Intel(R) PRO/100 Network Driver - version 2.1.29-k4
Copyright (c) 2002 Intel Corporation

PCI: Found IRQ 10 for device 02:08.0
PCI: Sharing IRQ 10 with 02:0e.0
PCI: Sharing IRQ 10 with 02:0e.1
PCI: Sharing IRQ 10 with 02:0e.2
e100: selftest OK.
Freeing alive device c133a000, eth%d
e100: eth0: Intel(R) PRO/100 VE Network Connection
  Hardware receive checksums enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Assigned IRQ 11 for device 00:1f.1
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS05-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/7898KiB Cache, CHS=77520/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 < p5 p6 p7 p8 p9 p10 p11 > p2
PCI: Found IRQ 11 for device 02:06.0
Yenta IRQ list 00d8, PCI irq11
Socket status: 30000006
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
input: PS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 112k freed
Adding 997880k swap on /dev/ide/host0/bus0/target0/lun0/part7.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
PCI: Found IRQ 5 for device 00:1f.5
PCI: Sharing IRQ 5 with 02:04.0
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/2 at I/O 0x3e8 (irq = 4) is a NS16550A
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,11), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
PCI: Found IRQ 10 for device 02:0e.2
PCI: Sharing IRQ 10 with 02:08.0
PCI: Sharing IRQ 10 with 02:0e.0
PCI: Sharing IRQ 10 with 02:0e.1
ehci-hcd 02:0e.2: NEC Corporation USB 2.0
ehci-hcd 02:0e.2: irq 10, pci mem d0893400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ehci-hcd 02:0e.2: new USB bus registered, assigned bus number 1
PCI: 02:0e.2 PCI cache line size set incorrectly (32 bytes) by BIOS/FW, correcting to 128
ehci-hcd 02:0e.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jan-22
hub 1-0:0: USB hub found
hub 1-0:0: 5 ports detected
PCI: Found IRQ 10 for device 02:0e.0
PCI: Sharing IRQ 10 with 02:08.0
PCI: Sharing IRQ 10 with 02:0e.1
PCI: Sharing IRQ 10 with 02:0e.2
ohci-hcd 02:0e.0: NEC Corporation USB
ohci-hcd 02:0e.0: irq 10, pci mem d08a8000
ohci-hcd 02:0e.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 3 ports detected
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 2-0:0: new USB device on port 2, assigned address 2
PCI: Found IRQ 10 for device 02:0e.1
PCI: Sharing IRQ 10 with 02:08.0
PCI: Sharing IRQ 10 with 02:0e.0
PCI: Sharing IRQ 10 with 02:0e.2
ohci-hcd 02:0e.1: NEC Corporation USB (#2)
ohci-hcd 02:0e.1: irq 10, pci mem d08c0000
ohci-hcd 02:0e.1: new USB bus registered, assigned bus number 3
drivers/usb/input/hid-core.c: ctrl urb status -32 received
drivers/usb/input/hid-core.c: ctrl urb status -75 received
input: USB HID v1.10 Mouse [Combo Mouse Combo Mouse] on usb-02:0e.0-2
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
e100: eth0 NIC Link is Up 100 Mbps Full duplex
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -32
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Module smbfs cannot be unloaded due to unsafe usage in include/linux/module.h:463
drivers/usb/host/ohci-q.c: 02:0e.0 bad entry fffffff0
------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:266!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c015ca22>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c46be080   ecx: c12f3278   edx: c46be09c
esi: c541b780   edi: 00000002   ebp: c46be080   esp: c4bcfeb8
ds: 007b   es: 007b   ss: 0068
Process xmms (pid: 5060, threadinfo=c4bce000 task=c4efe680)
Stack: c46be080 d09385d6 c46be080 c541b780 00000002 00000004 c541b780 c10afac8 
       d0937875 c46be080 c541b780 00000002 00000001 00000000 00000002 00000004 
       000f4240 0009f699 c56ddea4 00000000 c4645000 cee54180 dda6e025 0009f699 
Call Trace: [<d09385d6>]  [<d0937875>]  [<c0157cdc>]  [<c0157fed>]  [<c015819a>]  [<c0157fed>]  [<c01572ab>]  [<c015742d>]  [<c010921b>] 
Code: 0f 0b 0a 01 96 68 2a c0 ff 42 e4 83 4b 04 08 b8 01 00 00 00 
 

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="feb26-ksymoops.decoded"

ksymoops 2.4.8 on i686 2.5.63.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.63/ (default)
     -m /boot/System.map-2.5.63 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 VE Network Connection
e100: eth0 NIC Link is Up 100 Mbps Full duplex
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
kernel BUG at include/linux/dcache.h:266!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c015ca22>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c46be080   ecx: c12f3278   edx: c46be09c
esi: c541b780   edi: 00000002   ebp: c46be080   esp: c4bcfeb8
ds: 007b   es: 007b   ss: 0068
Stack: c46be080 d09385d6 c46be080 c541b780 00000002 00000004 c541b780 c10afac8 
       d0937875 c46be080 c541b780 00000002 00000001 00000000 00000002 00000004 
       000f4240 0009f699 c56ddea4 00000000 c4645000 cee54180 dda6e025 0009f699 
Call Trace: [<d09385d6>]  [<d0937875>]  [<c0157cdc>]  [<c0157fed>]  [<c015819a>]  [<c0157fed>]  [<c01572ab>]  [<c015742d>]  [<c010921b>] 
Code: 0f 0b 0a 01 96 68 2a c0 ff 42 e4 83 4b 04 08 b8 01 00 00 00 


>>EIP; c015ca22 <d_validate+72/88>   <=====

>>ebx; c46be080 <__crc_idetape+35901e/39ec93>
>>ecx; c12f3278 <__crc_skb_copy_bits+7e49c/1b217e>
>>edx; c46be09c <__crc_idetape+35903a/39ec93>
>>esi; c541b780 <__crc_interface_register+260d17/2e585b>
>>ebp; c46be080 <__crc_idetape+35901e/39ec93>
>>esp; c4bcfeb8 <__crc_set_transfer+4cc1c3/5513a8>

Trace; d09385d6 <__crc_aio_put_req+3c7837/5223ba>
Trace; d0937875 <__crc_aio_put_req+3c6ad6/5223ba>
Trace; c0157cdc <vfs_readdir+7c/7e>
Trace; c0157fed <filldir64+0/115>
Trace; c015819a <sys_getdents64+98/d9>
Trace; c0157fed <filldir64+0/115>
Trace; c01572ab <do_fcntl+b1/180>
Trace; c015742d <sys_fcntl64+57/95>
Trace; c010921b <syscall_call+7/b>

Code;  c015ca22 <d_validate+72/88>
00000000 <_EIP>:
Code;  c015ca22 <d_validate+72/88>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015ca24 <d_validate+74/88>
   2:   0a 01                     or     (%ecx),%al
Code;  c015ca26 <d_validate+76/88>
   4:   96                        xchg   %eax,%esi
Code;  c015ca27 <d_validate+77/88>
   5:   68 2a c0 ff 42            push   $0x42ffc02a
Code;  c015ca2c <d_validate+7c/88>
   a:   e4 83                     in     $0x83,%al
Code;  c015ca2e <d_validate+7e/88>
   c:   4b                        dec    %ebx
Code;  c015ca2f <d_validate+7f/88>
   d:   04 08                     add    $0x8,%al
Code;  c015ca31 <d_validate+81/88>
   f:   b8 01 00 00 00            mov    $0x1,%eax


1 warning and 1 error issued.  Results may not be reliable.

--45Z9DzgjV8m4Oswq--
