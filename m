Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWHIMc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWHIMc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWHIMc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:32:57 -0400
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:25026 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S1750721AbWHIMcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:32:55 -0400
From: Johan Rutgeerts <johan.rutgeerts@mech.kuleuven.be>
To: linux-acpi@vger.kernel.org
Subject: Acpi oops 2.6.17.7 vanilla
Date: Wed, 9 Aug 2006 14:32:57 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6Xd2EiPMsV7mgC5"
Message-Id: <200608091432.58959.johan.rutgeerts@mech.kuleuven.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_6Xd2EiPMsV7mgC5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



Hi,


I frequently get kernel oopses (NULL pointer dereference), which seem acpi 
related.


Attached file contains kern.log info for a non-tainted 2.6.17.7 vanilla 
kernel.



If it is of interest: I have put lots of similar oops reports online, for 
different kernels versions (ubuntu kernels and vanilla), at:
<http://people.mech.kuleuven.be/~jrutgeer/oopses/>.

For the earlier kernels of those, I used to have a lot of "ACPI: read EC, IB 
not empty" messages. These seem gone since I compiled a vanilla 2.6.17.7 
kernel.


I'm testing a 2.6.18-rc4 kernel now. If there is anything else I can do (e.g. 
test older kernels), please let me know.



Greetings,

Johan Rutgeerts


Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm


--Boundary-00=_6Xd2EiPMsV7mgC5
Content-Type: text/plain;
  charset="us-ascii";
  name="oops-2.6.17.7-vanilla-2.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="oops-2.6.17.7-vanilla-2.txt"

 Inspecting /boot/System.map-2.6.17.7
 Loaded 22335 symbols from /boot/System.map-2.6.17.7.
 Symbols match kernel version 2.6.17.
 No module symbols loaded - kernel modules not enabled.=20
 [17179569.184000] Linux version 2.6.17.7 (root@C036) (gcc version 4.0.3 (U=
buntu 4.0.3-1ubuntu5)) #1 SMP Fri Aug 4 15:46:12 CEST 2006
 [17179569.184000] BIOS-provided physical RAM map:
 [17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 [17179569.184000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 [17179569.184000]  BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI da=
ta)
 [17179569.184000]  BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NV=
S)
 [17179569.184000]  BIOS-e820: 000000001ff00000 - 000000001ff80000 (usable)
 [17179569.184000]  BIOS-e820: 000000001ff80000 - 0000000020000000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserve=
d)
 [17179569.184000] 0MB HIGHMEM available.
 [17179569.184000] 511MB LOWMEM available.
 [17179569.184000] On node 0 totalpages: 130944
 [17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
 [17179569.184000]   Normal zone: 126848 pages, LIFO batch:31
 [17179569.184000] DMI 2.3 present.
 [17179569.184000] ACPI: RSDP (v000 DELL                                  )=
 @ 0x000f6740
 [17179569.184000] ACPI: RSDT (v001 DELL     RSDT   0x06040000  LTP 0x00000=
000) @ 0x1fefadcf
 [17179569.184000] ACPI: FADT (v001 INTEL  845M     0x06040000 PTL  0x00000=
04b) @ 0x1fefef8c
 [17179569.184000] ACPI: DSDT (v001 DELL   845M     0x06040000 MSFT 0x01000=
00d) @ 0x00000000
 [17179569.184000] ACPI: PM-Timer IO Port: 0x1008
 [17179569.184000] Allocating PCI resources starting at 30000000 (gap: 2000=
0000:df800000)
 [17179569.184000] Built 1 zonelists
 [17179569.184000] Kernel command line: root=3D/dev/hda1 ro quiet splash
 [17179569.184000] Local APIC disabled by BIOS -- you can enable it with "l=
apic"
 [17179569.184000] mapped APIC to ffffd000 (0140a000)
 [17179569.184000] Enabling fast FPU save and restore... done.
 [17179569.184000] Enabling unmasked SIMD FPU exception support... done.
 [17179569.184000] Initializing CPU#0
 [17179569.184000] PID hash table entries: 2048 (order: 11, 8192 bytes)
 [17179569.184000] Detected 1994.333 MHz processor.
 [17179569.184000] Using pmtmr for high-res timesource
 [17179569.184000] Console: colour VGA+ 80x25
 [17179571.856000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
 [17179571.856000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
 [17179571.872000] Memory: 509124k/523776k available (1729k kernel code, 14=
072k reserved, 903k data, 304k init, 0k highmem)
 [17179571.872000] Checking if this processor honours the WP bit even in su=
pervisor mode... Ok.
 [17179571.952000] Calibrating delay using timer specific routine.. 3993.31=
 BogoMIPS (lpj=3D7986632)
 [17179571.952000] Security Framework v1.0.0 initialized
 [17179571.952000] SELinux:  Disabled at boot.
 [17179571.952000] Mount-cache hash table entries: 512
 [17179571.952000] CPU: After generic identify, caps: bfebf9ff 00000000 000=
00000 00000000 00000400 00000000 00000000
 [17179571.952000] CPU: After vendor identify, caps: bfebf9ff 00000000 0000=
0000 00000000 00000400 00000000 00000000
 [17179571.952000] CPU: Trace cache: 12K uops, L1 D cache: 8K
 [17179571.952000] CPU: L2 cache: 512K
 [17179571.952000] CPU: Hyper-Threading is disabled
 [17179571.952000] CPU: After all inits, caps: bfebf9ff 00000000 00000000 0=
0000080 00000400 00000000 00000000
 [17179571.952000] Checking 'hlt' instruction... OK.
 [17179571.968000] SMP alternatives: switching to UP code
 [17179571.968000] Freeing SMP alternatives: 16k freed
 [17179571.968000] ACPI: setting ELCR to 0200 (from 0c00)
 [17179571.976000] CPU0: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz=
 stepping 07
 [17179571.976000] SMP motherboard not detected.
 [17179571.976000] Local APIC not detected. Using dummy APIC emulation.
 [17179571.976000] Brought up 1 CPUs
 [17179571.976000] migration_cost=3D0
 [17179571.976000] checking if image is initramfs... it is
 [17179572.676000] Freeing initrd memory: 6142k freed
 [17179572.676000] NET: Registered protocol family 16
 [17179572.676000] EISA bus registered
 [17179572.676000] ACPI: bus type pci registered
 [17179572.676000] PCI: PCI BIOS revision 2.10 entry at 0xfd9c5, last bus=
=3D2
 [17179572.676000] Setting up standard PCI resources
 [17179572.684000] ACPI: Subsystem revision 20060127
 [17179572.684000] ACPI: Interpreter enabled
 [17179572.684000] ACPI: Using PIC for interrupt routing
 [17179572.688000] ACPI: PCI Root Bridge [PCI0] (0000:00)
 [17179572.688000] PCI: Probing PCI hardware (bus 00)
 [17179572.688000] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
 [17179572.688000] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
 [17179572.688000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
 [17179572.688000] Boot video device is 0000:01:00.0
 [17179572.688000] PCI: Transparent bridge - 0000:00:1e.0
 [17179572.688000] PCI: Bus #03 (-#06) is hidden behind transparent bridge =
#02 (-#02) (try 'pci=3Dassign-busses')
 [17179572.688000] Please report the result to linux-kernel to fix this per=
manently
 [17179572.688000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 [17179572.692000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
 [17179572.692000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
 [17179572.692000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 1=
2 14 15)
 [17179572.692000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 1=
2 14 15)
 [17179572.692000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 12=
 14 15) *0, disabled.
 [17179572.692000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 1=
2 14 15)
 [17179572.696000] ACPI: Embedded Controller [EC0] (gpe 28) interrupt mode.
 [17179572.700000] Linux Plug and Play Support v0.97 (c) Adam Belay
 [17179572.700000] pnp: PnP ACPI init
 [17179572.704000] pnp: PnP ACPI: found 9 devices
 [17179572.704000] PnPBIOS: Disabled by ACPI PNP
 [17179572.704000] PCI: Using ACPI for IRQ routing
 [17179572.704000] PCI: If a device doesn't work, try "pci=3Drouteirq".  If=
 it helps, post a report
 [17179572.708000] pnp: 00:04: ioport range 0x600-0x60f has been reserved
 [17179572.708000] PCI: Bridge: 0000:00:01.0
 [17179572.708000]   IO window: disabled.
 [17179572.708000]   MEM window: e0000000-e7ffffff
 [17179572.708000]   PREFETCH window: f0000000-f7ffffff
 [17179572.708000] PCI: Bus 3, cardbus bridge: 0000:02:04.0
 [17179572.708000]   IO window: 00003400-000034ff
 [17179572.708000]   IO window: 00003800-000038ff
 [17179572.708000]   PREFETCH window: 30000000-31ffffff
 [17179572.708000]   MEM window: 34000000-35ffffff
 [17179572.708000] PCI: Bridge: 0000:00:1e.0
 [17179572.708000]   IO window: 3000-3fff
 [17179572.708000]   MEM window: e8000000-e80fffff
 [17179572.708000]   PREFETCH window: 30000000-32ffffff
 [17179572.712000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
 [17179572.712000] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
 [17179572.712000] PCI: setting IRQ 10 as level-triggered
 [17179572.712000] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKA] -> GS=
I 10 (level, low) -> IRQ 10
 [17179572.712000] NET: Registered protocol family 2
 [17179572.752000] IP route cache hash table entries: 4096 (order: 2, 16384=
 bytes)
 [17179572.752000] TCP established hash table entries: 16384 (order: 5, 131=
072 bytes)
 [17179572.752000] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
 [17179572.752000] TCP: Hash tables configured (established 16384 bind 8192)
 [17179572.752000] TCP reno registered
 [17179572.752000] audit: initializing netlink socket (disabled)
 [17179572.752000] audit(1155026464.752:1): initialized
 [17179572.752000] VFS: Disk quotas dquot_6.5.1
 [17179572.752000] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
 [17179572.752000] Initializing Cryptographic API
 [17179572.752000] io scheduler noop registered
 [17179572.752000] io scheduler anticipatory registered
 [17179572.752000] io scheduler deadline registered
 [17179572.752000] io scheduler cfq registered (default)
 [17179572.752000] isapnp: Scanning for PnP cards...
 [17179573.108000] isapnp: No Plug & Play device found
 [17179573.140000] Real Time Clock Driver v1.12ac
 [17179573.140000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ=
 sharing enabled
 [17179573.140000] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
 [17179573.140000] ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GS=
I 10 (level, low) -> IRQ 10
 [17179573.140000] ACPI: PCI interrupt for device 0000:00:1f.6 disabled
 [17179573.140000] RAMDISK driver initialized: 16 RAM disks of 65536K size =
1024 blocksize
 [17179573.144000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 [17179573.144000] ide: Assuming 33MHz system bus speed for PIO modes; over=
ride with idebus=3Dxx
 [17179573.144000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60=
,0x64 irq 1,12
 [17179573.152000] serio: i8042 AUX port at 0x60,0x64 irq 12
 [17179573.152000] serio: i8042 KBD port at 0x60,0x64 irq 1
 [17179573.152000] mice: PS/2 mouse device common for all mice
 [17179573.156000] EISA: Probing bus 0 at eisa.0
 [17179573.156000] Cannot allocate resource for EISA slot 1
 [17179573.156000] Cannot allocate resource for EISA slot 2
 [17179573.156000] Cannot allocate resource for EISA slot 3
 [17179573.156000] EISA: Detected 0 cards.
 [17179573.156000] TCP bic registered
 [17179573.156000] NET: Registered protocol family 1
 [17179573.156000] NET: Registered protocol family 8
 [17179573.156000] NET: Registered protocol family 20
 [17179573.156000] Using IPI No-Shortcut mode
 [17179573.156000] ACPI wakeup devices:=20
 [17179573.156000] ELAN USB0 USB1 USB2 MODM=20
 [17179573.156000] ACPI: (supports S0 S1 S3 S4 S5)
 [17179573.156000] Freeing unused kernel memory: 304k freed
 [17179573.192000] input: AT Translated Set 2 keyboard as /class/input/inpu=
t0
 [17179573.224000] vga16fb: initializing
 [17179573.224000] vga16fb: mapped to 0xc00a0000
 [17179573.224000] fb0: VGA16 VGA frame buffer device
 [17179574.688000] ACPI: CPU0 (power states: C1[C1] C2[C2])
 [17179574.688000] ACPI: Processor [CPU0] (supports 8 throttling states)
 [17179575.428000] ICH3M: IDE controller at PCI slot 0000:00:1f.1
 [17179575.428000] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
 [17179575.428000] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
 [17179575.428000] PCI: setting IRQ 11 as level-triggered
 [17179575.428000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GS=
I 11 (level, low) -> IRQ 11
 [17179575.428000] ICH3M: chipset revision 2
 [17179575.428000] ICH3M: not 100%% native mode: will probe irqs later
 [17179575.428000]     ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DM=
A, hdb:pio
 [17179575.428000]     ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DM=
A, hdd:pio
 [17179575.428000] Probing IDE interface ide0...
 [17179575.716000] hda: HITACHI_DK23EA-30, ATA DISK drive
 [17179576.388000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 [17179576.388000] Probing IDE interface ide1...
 [17179577.124000] hdc: MATSHITA CD-RW/DVD-ROM UJDA740, ATAPI CD/DVD-ROM dr=
ive
 [17179577.796000] ide1 at 0x170-0x177,0x376 on irq 15
 [17179577.804000] hda: max request size: 128KiB
 [17179577.816000] hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=3D=
58140/16/63, UDMA(100)
 [17179577.816000] hda: cache flushes supported
 [17179577.816000]  hda: hda1 hda2 hda3
 [17179577.852000] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA=
(33)
 [17179577.852000] Uniform CD-ROM driver Revision: 3.20
 [17179578.128000] usbcore: registered new driver usbfs
 [17179578.128000] usbcore: registered new driver hub
 [17179578.128000] USB Universal Host Controller Interface driver v3.0
 [17179578.128000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GS=
I 10 (level, low) -> IRQ 10
 [17179578.128000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
 [17179578.128000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
 [17179578.128000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned =
bus number 1
 [17179578.128000] uhci_hcd 0000:00:1d.0: irq 10, io base 0x00001800
 [17179578.132000] usb usb1: configuration #1 chosen from 1 choice
 [17179578.132000] hub 1-0:1.0: USB hub found
 [17179578.132000] hub 1-0:1.0: 2 ports detected
 [17179578.236000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
 [17179578.236000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GS=
I 11 (level, low) -> IRQ 11
 [17179578.236000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
 [17179578.236000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
 [17179578.236000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned =
bus number 2
 [17179578.236000] uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001820
 [17179578.236000] usb usb2: configuration #1 chosen from 1 choice
 [17179578.236000] hub 2-0:1.0: USB hub found
 [17179578.236000] hub 2-0:1.0: 2 ports detected
 [17179578.432000] Attempting manual resume
 [17179578.448000] EXT3-fs: INFO: recovery required on readonly filesystem.
 [17179578.448000] EXT3-fs: write access will be enabled during recovery.
 [17179578.580000] usb 2-1: new low speed USB device using uhci_hcd and add=
ress 2
 [17179578.760000] usb 2-1: configuration #1 chosen from 1 choice
 [17179578.772000] usbcore: registered new driver hiddev
 [17179578.800000] input: Microsoft Microsoft IntelliMouse=C2=AE Optical as=
 /class/input/input1
 [17179578.800000] input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliM=
ouse=C2=AE Optical] on usb-0000:00:1d.1-1
 [17179578.800000] usbcore: registered new driver usbhid
 [17179578.800000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
 [17179584.664000] kjournald starting.  Commit interval 5 seconds
 [17179584.664000] EXT3-fs: hda1: orphan cleanup on readonly fs
 [17179584.888000] ext3_orphan_cleanup: deleting unreferenced inode 468905
 [17179584.916000] ext3_orphan_cleanup: deleting unreferenced inode 274502
 [17179584.916000] ext3_orphan_cleanup: deleting unreferenced inode 468906
 [17179584.936000] ext3_orphan_cleanup: deleting unreferenced inode 258253
 [17179584.956000] ext3_orphan_cleanup: deleting unreferenced inode 471076
 [17179584.956000] ext3_orphan_cleanup: deleting unreferenced inode 471075
 [17179584.956000] ext3_orphan_cleanup: deleting unreferenced inode 470955
 [17179584.956000] ext3_orphan_cleanup: deleting unreferenced inode 468626
 [17179584.956000] ext3_orphan_cleanup: deleting unreferenced inode 468598
 [17179584.956000] ext3_orphan_cleanup: deleting unreferenced inode 468597
 [17179584.976000] ext3_orphan_cleanup: deleting unreferenced inode 423295
 [17179584.996000] ext3_orphan_cleanup: deleting unreferenced inode 422927
 [17179585.032000] ext3_orphan_cleanup: deleting unreferenced inode 790299
 [17179585.052000] EXT3-fs: hda1: 13 orphan inodes deleted
 [17179585.052000] EXT3-fs: recovery complete.
 [17179585.088000] EXT3-fs: mounted filesystem with ordered data mode.
 [17179594.760000] ts: Compaq touchscreen protocol output
 [17179596.896000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
 [17179596.904000] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
 [17179597.088000] Linux agpgart interface v0.101 (c) Dave Jones
 [17179597.280000] agpgart: Detected an Intel i845 Chipset.
 [17179597.280000] agpgart: AGP aperture is 64M @ 0xec000000
 [17179597.404000] Floppy drive(s): fd0 is 1.44M
 [17179597.420000] FDC 0 is a National Semiconductor PC87306
 [17179598.272000] parport: PnPBIOS parport detected.
 [17179598.272000] parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP=
,TRISTATE,COMPAT,ECP,DMA]
 [17179598.536000] Synaptics Touchpad, model: 1, fw: 5.9, id: 0x254ab1, cap=
s: 0x804713/0x0
 [17179598.580000] hw_random hardware driver 1.0.0 loaded
 [17179598.596000] input: SynPS/2 Synaptics TouchPad as /class/input/input2
 [17179599.372000] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKA] -> GS=
I 10 (level, low) -> IRQ 10
 [17179599.372000] Yenta: CardBus bridge found at 0000:02:04.0 [1028:00f3]
 [17179599.372000] Yenta O2: res at 0x94/0xD4: 00/c8
 [17179599.372000] Yenta O2: enabling read prefetch/write burst
 [17179599.500000] Yenta: ISA IRQ mask 0x0038, PCI irq 10
 [17179599.500000] Socket status: 30000007
 [17179599.500000] pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
 [17179599.500000] cs: IO port probe 0x3000-0x3fff: clean.
 [17179599.500000] pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0x=
e80fffff
 [17179599.500000] pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x=
32ffffff
 [17179599.536000] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GS=
I 10 (level, low) -> IRQ 10
 [17179599.536000] PCI: Setting latency timer of device 0000:00:1f.5 to 64
 [17179600.104000] intel8x0_measure_ac97_clock: measured 55373 usecs
 [17179600.104000] intel8x0: clocking to 48000
 [17179600.104000] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] -> GS=
I 10 (level, low) -> IRQ 10
 [17179600.104000] 3c59x: Donald Becker and others. www.scyld.com/network/v=
ortex.html
 [17179600.104000] 0000:02:01.0: 3Com PCI 3c905C Tornado at e09c2000.
 [17179600.392000] cs: IO port probe 0x100-0x4ff: excluding 0x4d0-0x4d7
 [17179600.396000] cs: IO port probe 0xc00-0xcf7: clean.
 [17179600.396000] cs: IO port probe 0xa00-0xaff: clean.
 [17179601.540000] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] -> GS=
I 10 (level, low) -> IRQ 10
 [17179601.540000] eth0:  setting full-duplex.
 [17179601.560000] lp0: using parport0 (interrupt-driven).
 [17179601.864000] Adding 128512k swap on /dev/hda2.  Priority:-1 extents:1=
 across:128512k
 [17179601.868000] EXT3-fs warning: maximal mount count reached, running e2=
fsck is recommended
 [17179601.964000] EXT3 FS on hda1, internal journal
 [17179602.528000] md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
 [17179602.528000] md: bitmap version 4.39
 [17179602.664000] NET: Registered protocol family 17
 [17179603.684000] NET: Registered protocol family 10
 [17179603.684000] lo: Disabled Privacy Extensions
 [17179603.684000] IPv6 over IPv4 tunneling driver
 [17179605.680000] device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-=
devel@redhat.com
 [17179607.008000] device-mapper: dm-linear: Device lookup failed
 [17179607.008000] device-mapper: error adding target to table
 [17179607.008000] device-mapper: dm-linear: Device lookup failed
 [17179607.008000] device-mapper: error adding target to table
 [17179607.012000] device-mapper: dm-linear: Device lookup failed
 [17179607.012000] device-mapper: error adding target to table
 [17179607.016000] device-mapper: dm-linear: Device lookup failed
 [17179607.016000] device-mapper: error adding target to table
 [17179607.016000] device-mapper: dm-linear: Device lookup failed
 [17179607.016000] device-mapper: error adding target to table
 [17179607.020000] device-mapper: dm-linear: Device lookup failed
 [17179607.020000] device-mapper: error adding target to table
 [17179607.024000] device-mapper: dm-linear: Device lookup failed
 [17179607.024000] device-mapper: error adding target to table
 [17179607.024000] device-mapper: dm-linear: Device lookup failed
 [17179607.024000] device-mapper: error adding target to table
 [17179607.028000] device-mapper: dm-linear: Device lookup failed
 [17179607.028000] device-mapper: error adding target to table
 [17179607.028000] device-mapper: dm-linear: Device lookup failed
 [17179607.028000] device-mapper: error adding target to table
 [17179607.032000] device-mapper: dm-linear: Device lookup failed
 [17179607.032000] device-mapper: error adding target to table
 [17179607.036000] device-mapper: dm-linear: Device lookup failed
 [17179607.036000] device-mapper: error adding target to table
 [17179608.924000] kjournald starting.  Commit interval 5 seconds
 [17179608.924000] EXT3-fs warning: maximal mount count reached, running e2=
fsck is recommended
 [17179608.924000] EXT3 FS on hda3, internal journal
 [17179608.924000] EXT3-fs: recovery complete.
 [17179608.924000] EXT3-fs: mounted filesystem with ordered data mode.
 [17179614.008000] eth0: no IPv6 routers present
 [17179614.444000] ACPI: AC Adapter [ACAD] (on-line)
 [17179614.508000] ACPI: Battery Slot [BAT1] (battery present)
 [17179614.532000] ACPI: Power Button (FF) [PWRF]
 [17179614.532000] ACPI: Lid Switch [LID]
 [17179614.532000] ACPI: Power Button (CM) [PWRB]
 [17179614.532000] ACPI: Sleep Button (CM) [SLPB]
 [17179614.552000] Using specific hotkey driver
 [17179614.596000] ibm_acpi: ec object not found
 [17179614.636000] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
 [17179614.676000] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post=
: no)
 [17179621.184000] ppdev: user-space parallel port driver
 [17179622.204000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
 [17179622.204000] apm: overridden by ACPI.
 [17179625.952000] Bluetooth: Core ver 2.8
 [17179625.952000] NET: Registered protocol family 31
 [17179625.952000] Bluetooth: HCI device and connection manager initialized
 [17179625.952000] Bluetooth: HCI socket layer initialized
 [17179626.120000] Bluetooth: L2CAP ver 2.8
 [17179626.120000] Bluetooth: L2CAP socket layer initialized
 [17179626.400000] Bluetooth: RFCOMM socket layer initialized
 [17179626.400000] Bluetooth: RFCOMM TTY layer initialized
 [17179626.400000] Bluetooth: RFCOMM ver 1.7
 [17186277.420000] BUG: unable to handle kernel NULL pointer dereference at=
 virtual address 00000002
 [17186277.420000]  printing eip:
 [17186277.420000] c01f156a
 [17186277.420000] *pde =3D 00000000
 [17186277.420000] Oops: 0000 [#1]
 [17186277.420000] SMP=20
 [17186277.420000] Modules linked in: binfmt_misc rfcomm l2cap bluetooth pp=
dev speedstep_ich speedstep_lib cpufreq_userspace cpufreq_stats freq_table =
cpufreq_powersave cpufreq_ondemand cpufreq_conservative video button batter=
y container ac dm_mod ipv6 af_packet md_mod ide_cs lp pcmcia 3c59x snd_inte=
l8x0 snd_ac97_codec snd_ac97_bus yenta_socket rsrc_nonstatic mii pcmcia_cor=
e joydev snd_pcm_oss snd_mixer_oss hw_random snd_pcm snd_timer snd parport_=
pc parport psmouse soundcore snd_page_alloc floppy intel_agp agpgart shpchp=
 pci_hotplug serio_raw tsdev evdev usbhid ext3 jbd mbcache ide_generic uhci=
_hcd usbcore ide_cd cdrom ide_disk piix generic thermal processor fan vga16=
fb cfbcopyarea vgastate cfbimgblt cfbfillrect
 [17186277.420000] CPU:    0
 [17186277.420000] EIP:    0060:[acpi_ex_store+273/519]    Not tainted VLI
 [17186277.420000] EFLAGS: 00210282   (2.6.17.7 #1)=20
 [17186277.420000] EIP is at acpi_ex_store+0x111/0x207
 [17186277.420000] eax: 00000000   ebx: dfe7b8bc   ecx: 00000000   edx: 000=
00000
 [17186277.420000] esi: 00000000   edi: dfe7b754   ebp: 00000014   esp: d9e=
e3e04
 [17186277.420000] ds: 007b   es: 007b   ss: 0068
 [17186277.420000] Process hald (pid: 3808, threadinfo=3Dd9ee2000 task=3Dde=
fd1030)
 [17186277.420000] Stack: dfe7b8bc d87ed5bc 00000000 d87ed400 c01f0eea d87e=
d400 d87ed5bc 00000003=20
 [17186277.420000]        00000000 dfe7b8bc d87ed400 00000000 c75a93a0 0000=
0007 c01e84a8 d9ee3e60=20
 [17186277.420000]        d87ed400 00000000 d87ed5ec c01f61b3 e080bfac 0000=
0000 00200286 c75a9288=20
 [17186277.420000] Call Trace:
 [17186277.420000]  <c01f0eea> acpi_ex_opcode_2A_1T_1R+0x33b/0x368  <c01e84=
a8> acpi_ds_exec_end_op+0xb3/0x363
 [17186277.420000]  <c01f61b3> acpi_ps_parse_loop+0x55f/0x848  <c01f5acb> a=
cpi_ps_parse_aml+0x45/0x1ce
 [17186277.420000]  <c01f68c8> acpi_ps_execute_pass+0x6b/0x7b  <c01f698c> a=
cpi_ps_execute_method+0xb4/0x140
 [17186277.420000]  <c01f3fcd> acpi_ns_evaluate_by_handle+0xd1/0x12a  <c01f=
4137> acpi_ns_evaluate_relative+0xa7/0xc8
 [17186277.420000]  <c01f38cd> acpi_evaluate_object+0x109/0x1b4  <c0170003>=
 __link_path_walk+0x4b2/0xed4
 [17186277.420000]  <e0a5a66b> acpi_battery_read_state+0x94/0x242 [battery]=
  <c0180129> seq_read+0x0/0x2ba
 [17186277.420000]  <c0180190> seq_read+0x67/0x2ba  <c0180129> seq_read+0x0=
/0x2ba
 [17186277.420000]  <c01623fd> vfs_read+0xa2/0x158  <c0162ea0> sys_read+0x4=
1/0x6a
 [17186277.420000]  <c0102ceb> sysenter_past_esp+0x54/0x75=20
 [17186277.420000] Code: 8b 43 18 8b 38 89 e2 89 f0 e8 1d 96 00 00 89 c2 85=
 c0 0f 85 01 01 00 00 31 f6 85 ff 75 0a eb 13 89 f8 e8 b2 97 00 00 46 8b 43=
 10 <0f> b7 40 02 39 c6 72 ed 8b 53 18 8b 04 24 89 02 be 01 00 00 00=20
 [17186277.420000] EIP: [acpi_ex_store+273/519] acpi_ex_store+0x111/0x207 S=
S:ESP 0068:d9ee3e04


--Boundary-00=_6Xd2EiPMsV7mgC5--
