Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUHLSwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUHLSwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268659AbUHLSvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:51:36 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:19282 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263770AbUHLStW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:49:22 -0400
Message-ID: <9dda3492040812114929cf8dcc@mail.gmail.com>
Date: Thu, 12 Aug 2004 14:49:17 -0400
From: Paul Blazejowski <diffie@gmail.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.8-rc4-mm1
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_356_8138486.1092336557374"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_356_8138486.1092336557374
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Folks,

I managed to caputre the serial console output of the boot process
with the error. Below is the full log.

And here is the lspci output:

00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
00:05.0 Multimedia audio controller: nVidia Corporation nForce
MultiMedia audio [Via VT82C686B] (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97
Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire
(IEEE 1394) Controller (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:09.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
01:0b.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet
Controller (rev 02)
01:0c.0 RAID bus controller: Integrated Technology Express, Inc.
IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be
IT8212, embedded seems (rev 10)
03:00.0 VGA compatible controller: ATI Technologies Inc RV350 AR [Radeon 9600]
03:00.1 Display controller: ATI Technologies Inc RV350 AR [Radeon
9600] (Secondary)

Thanks,

Paul
-- 
FreeBSD the Power to Serve!

------=_Part_356_8138486.1092336557374
Content-Type: text/plain; name="2.6.8-rc4-mm1.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="2.6.8-rc4-mm1.txt"

LILO 22.5.9 boot:=20
Loading Slackware...............................
BIOS data check successful
Linux version 2.6.8-rc4-mm1 (root@blaze) (gcc version 3.3.4) #1 Tue Aug 10 =
14:30:45 EDT 2004

BIOS-provided physical RAM map:

 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)

 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)

 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)

 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)

 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)

 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)

 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)

 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)

127MB HIGHMEM available.

896MB LOWMEM available.

found SMP MP-table at 000f5240

DMI 2.3 present.

ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6bb0

ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000

ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040

ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff7680

ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000

ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)

Processor #0 6:10 APIC version 16

ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])

ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])

IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23

ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)

ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)

Enabling APIC mode:  Flat.  Using 1 I/O APICs

Using ACPI (MADT) for SMP configuration information

Built 1 zonelists

Initializing CPU#0

Kernel command line: auto BOOT_IMAGE=3DSlackware ro root=3D801 console=3Dtt=
yS0,57600n8 console=3Dtty0 rootflags=3Dquota

CPU 0 irqstacks, hard=3Dc042c000 soft=3Dc042b000

PID hash table entries: 4096 (order 12: 32768 bytes)

Detected 2205.102 MHz processor.

Using tsc for high-res timesource

Console: colour VGA+ 80x25

Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

Memory: 1035168k/1048512k available (2214k kernel code, 12692k reserved, 81=
8k data, 184k init, 131008k highmem)

Checking if this processor honours the WP bit even in supervisor mode... Ok=
.

Calibrating delay loop... 4358.14 BogoMIPS (lpj=3D2179072)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)

CPU: L2 Cache: 512K (64 bytes/line)

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU: AMD Athlon(tm) XP 3200+ stepping 00

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

ENABLING IO-APIC IRQs

..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1

..MP-BIOS bug: 8254 timer not connected to IO-APIC

...trying to set up timer (IRQ0) through the 8259A ...  failed.

...trying to set up timer as Virtual Wire IRQ... failed.

...trying to set up timer as ExtINT IRQ... works.

checking if image is initramfs...it isn't (ungzip failed); looks like an in=
itrd

Freeing initrd memory: 56k freed

NET: Registered protocol family 16

PCI: PCI BIOS revision 2.10 entry at 0xfabc0, last bus=3D3

PCI: Using configuration type 1

mtrr: v2.0 (20020519)

ACPI: Subsystem revision 20040715

ACPI: Interpreter enabled

ACPI: Using IOAPIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (00:00)

PCI: Probing PCI hardware (bus 00)

PCI: nForce2 C1 Halt Disconnect fixup

ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.

ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 11 12 14 15) *9

ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.

ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.

ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 11 12 14 15) *9

ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.

ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.

ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.

ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.

ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.

ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.

ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.

ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.

ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.

SCSI subsystem initialized

PCI: Using ACPI for IRQ routing

** PCI interrupts are no longer routed automatically.  If this

** causes a device to stop working, it is probably because the

** driver failed to call pci_enable_device().  As a temporary

** workaround, the "pci=3Drouteirq" argument restores the old

** behavior.  If this argument makes the device work again,

** please email the output of "lspci" to bjorn.helgaas@hp.com

** so I can fix the driver.

vesafb: probe of vesafb0 failed with error -6

Machine check exception polling timer started.

highmem bounce pool size: 64 pages

Total HugeTLB memory allocated, 0

VFS: Disk quotas dquot_6.5.1

Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)

SGI XFS with ACLs, realtime, large block numbers, no debug enabled

SGI XFS Quota Management subsystem

Initializing Cryptographic API

ACPI: Power Button (FF) [PWRF]

ACPI: Processor [CPU0] (supports C1)

serio: i8042 AUX port at 0x60,0x64 irq 12

serio: i8042 KBD port at 0x60,0x64 irq 1

Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled

ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A

ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx

NFORCE2: IDE controller at PCI slot 0000:00:09.0

NFORCE2: chipset revision 162

NFORCE2: not 100% native mode: will probe irqs later

NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.

NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller

    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA

    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA

Probing IDE interface ide0...

hda: WDC WD300BB-00AUA1, ATA DISK drive

Using anticipatory io scheduler

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

Probing IDE interface ide1...

hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive

ide1 at 0x170-0x177,0x376 on irq 15

Probing IDE interface ide2...

ide2: Wait for ready failed before probe !

Probing IDE interface ide3...

ide3: Wait for ready failed before probe !

Probing IDE interface ide4...

ide4: Wait for ready failed before probe !

Probing IDE interface ide5...

ide5: Wait for ready failed before probe !

hda: max request size: 128KiB

hda: Host Protected Area detected.

=09current capacity is 58631231 sectors (30019 MB)

=09native  capacity is 58633344 sectors (30020 MB)

hda: 58631231 sectors (30019 MB) w/2048KiB Cache, CHS=3D58165/16/63, UDMA(1=
00)

hda: cache flushes not supported

 hda: hda1

ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17

ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 17

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36

        <Adaptec 2940 Ultra2 SCSI adapter>

        aic7890/91: Ultra2 Wide Channel A, SCSI Id=3D7, 32/253 SCBs


(scsi0:A:3): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)

  Vendor: PLEXTOR   Model: CD-ROM PX-40TW    Rev: 1.05

  Type:   CD-ROM                             ANSI SCSI revision: 02

(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)

  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06

  Type:   CD-ROM                             ANSI SCSI revision: 02

(scsi0:A:6): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)

  Vendor: IBM       Model: DDYS-T36950N      Rev: S80D

  Type:   Direct-Access                      ANSI SCSI revision: 03

scsi0:A:6:0: Tagged Queuing enabled.  Depth 32

Found Controller: IT8212 UDMA/ATA133 RAID Controller

FindDevices: device 0 is IDE

Channel[0] BM-DMA at 0x9800-0x9807

Channel[1] BM-DMA at 0x9808-0x980F

scsi1 : ITE RAIDExpress133

  Vendor: ITE       Model: IT8212F           Rev: 1.45

  Type:   Direct-Access                      ANSI SCSI revision: 00

SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)

SCSI device sda: drive cache: write back

 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >

Attached scsi disk sda at scsi0, channel 0, id 6, lun 0

SCSI device sdb: 468883200 512-byte hdwr sectors (240068 MB)

sdb: asking for cache data failed

sdb: assuming drive cache: write through

 sdb:<3>irq 17: nobody cared!

 [<c01084ca>] __report_bad_irq+0x2a/0x90

 [<c01085bc>] note_interrupt+0x6c/0xa0

 [<c01088e2>] do_IRQ+0x172/0x1a0

 [<c0106a64>] common_interrupt+0x18/0x20

 [<c0104053>] default_idle+0x23/0x30

 [<c01040bc>] cpu_idle+0x2c/0x40

 [<c03f87a8>] start_kernel+0x178/0x1c0

 [<c03f83b0>] unknown_bootoption+0x0/0x160

handlers:

[<c02ac050>] (ahc_linux_isr+0x0/0x290)

Disabling IRQ #17

AtapiStartIo: already have a request!

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiStartIo: already have a request!

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiStartIo: already have a request!

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiStartIo: already have a request!

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiStartIo: already have a request!

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

SCSI error : <1 0 0 0> return code =3D 0x6000000

end_request: I/O error, dev sdb, sector 0

Buffer I/O error on device sdb, logical block 0

AtapiStartIo: already have a request!

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiStartIo: already have a request!

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiStartIo: already have a request!

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiStartIo: already have a request!

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiStartIo: already have a request!

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

AtapiResetController enter

IT8212ResetAdapter: reset channel 0

IT8212ResetAdapter Success!

AtapiResetController exit

SCSI error : <1 0 0 0> return code =3D 0x6000000

end_request: I/O error, dev sdb, sector 0

Buffer I/O error on device sdb, logical block 0

 unable to read partition table

Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0

mice: PS/2 mouse device common for all mice

input: AT Translated Set 2 keyboard on isa0060/serio0

input: PS/2 Generic Mouse on isa0060/serio1

device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com

NET: Registered protocol family 2

IP: routing cache hash table of 8192 buckets, 64Kbytes

TCP: Hash tables configured (established 262144 bind 65536)

NET: Registered protocol family 1

NET: Registered protocol family 17

scsi0:0:6:0: Attempting to queue an ABORT message

CDB: 0x28 0x0 0x4 0x3e 0x2e 0xce 0x0 0x0 0x8 0x0

scsi0:0:6:0: Command already completed

aic7xxx_abort returns 0x2002

scsi0:0:6:0: Attempting to queue an ABORT message

CDB: 0x0 0x0 0x0 0x0 0x0 0x0

scsi0:0:6:0: Command already completed

aic7xxx_abort returns 0x2002

scsi0:0:6:0: Attempting to queue a TARGET RESET message

CDB: 0x28 0x0 0x4 0x3e 0x2e 0xce 0x0 0x0 0x8 0x0

scsi0:0:6:0: Command not found

aic7xxx_dev_reset returns 0x2002

scsi0:0:6:0: Attempting to queue an ABORT message

CDB: 0x0 0x0 0x0 0x0 0x0 0x0

scsi0:0:6:0: Command already completed

aic7xxx_abort returns 0x2002

scsi0:0:6:0: Attempting to queue an ABORT message

CDB: 0x0 0x0 0x0 0x0 0x0 0x0

scsi0: At time of recovery, card was paused

>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<

scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x171

Card was paused

ACCUM =3D 0xa0, SINDEX =3D 0x61, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISIGI[0xb6] ERROR[0x0] SCSIBUSL[0xc0] LASTPHASE[0xa0]=20

SCSISEQ[0x12] SBLKCTL[0xa] SCSIRATE[0x0] SEQCTL[0x10]=20

SEQ_FLAGS[0x40] SSTAT0[0x2] SSTAT1[0x3] SSTAT2[0x0]=20

SSTAT3[0x0] SIMODE0[0x8] SIMODE1[0xac] SXFRCTL0[0x88]=20

DFCNTRL[0x0] DFSTATUS[0x89]=20

STACK: 0xe4 0x0 0x166 0x17c

SCB count =3D 4

Kernel NEXTQSCB =3D 3

Card NEXTQSCB =3D 3

QINFIFO entries:=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20=
 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info:=20

  0 SCB_CONTROL[0x60] SCB_SCSIID[0x67] SCB_LUN[0x0] SCB_TAG[0x2]=20

  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0x0xff] SCB_TAG=
[0xff]=20

 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 16 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 17 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 18 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 19 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 20 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 21 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 22 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 23 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 24 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 25 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 26 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 27 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 28 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 29 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 30 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

 31 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20

Pending list:=20

  2 SCB_CONTROL[0x60] SCB_SCSIID[0x67] SCB_LUN[0x0]=20

Kernel Free SCB list: 1 0=20

DevQ(0:3:0): 0 waiting

DevQ(0:4:0): 0 waiting

DevQ(0:6:0): 0 waiting


<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>

scsi0:0:6:0: Device is active, asserting ATN

Recovery code sleeping

Recovery code awake

Timer Expired

aic7xxx_abort returns 0x2003

scsi: Device offlined - not ready after error recovery: host 0 channel 0 id=
 6 lun 0

SCSI error : <0 0 6 0> return code =3D 0x6000000

end_request: I/O error, dev sda, sector 71184078

ACPI: (supports S0 S3 S4 S5)

ACPI wakeup devices:=20

HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1=20

BIOS EDD facility v0.16 2004-Jun-25, 3 devices found

RAMDISK: Couldn't find valid RAM disk image starting at 0.

VFS: Cannot open root device "801" or unknown-block(8,1)

Please append a correct "root=3D" boot option

Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8=
,1)
------=_Part_356_8138486.1092336557374--
