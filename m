Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUGTI7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUGTI7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 04:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbUGTI7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 04:59:31 -0400
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:18375 "EHLO
	fbihome.de") by vger.kernel.org with ESMTP id S265768AbUGTI7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 04:59:05 -0400
From: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
To: Jesus Delgado <jdelgado@gmail.com>
Subject: Re: Broken driver via-rhine.c in kernel 2.6.8-rc1
Date: Tue, 20 Jul 2004 10:58:05 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <57861437040712220518dee67d@mail.gmail.com>
In-Reply-To: <57861437040712220518dee67d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_d6N/Am863hsT/RX"
Message-Id: <200407201058.11252.vergata@stud.fbi.fh-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_d6N/Am863hsT/RX
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi To all,

Also problem with Via-rhine but not like the problem explained here.
It's an verry strange problem.
Running with 2.6.(0-7)-vanilla and compiled via-rhien as internal driver or=
 as=20
external module shows the same error, the server frezzes and won't respond =
on=20
any request only way to get it work again is to reboot. The only thing I kn=
ow=20
is when sending and recieving constanly data e.g. reading mail with IMAP or=
=20
doing ftp transfere chrashes the system without any Log entry. For the reas=
on=20
that this is a server hostet by an ISP i can't see any console output (if=20
any). So the ony thing that work for me is to build 2.4(x) with one single=
=20
module from VIA directly RHINE-FET.o whith this driver the NIC is initialis=
ed=20
correctly and the server works reliable. Testet Time (Max Uptime) was 120=20
Days. with the via-rhine in 2.6 and 2.4 the server chrashes every 1 - 5 day=
s.=20


lspci=20
0000:00:00.0 Host bridge: VIA Technologies, Inc. P4M266 Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
=20
Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
=20
Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc.=20
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]=
=20
(rev 74)
0000:01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8=20
KM266/KL266]

Attatched Output of kernel.log=20

CU Sergio

On Tuesday 13 July 2004 07:05, Jesus Delgado wrote:
>  hi:
>
> The problems with driver via-rhine.c version v1.10-LK1.1.20-2.6
> May-23-2004:via-rhine: probe of 0000:00:12.0 failed with error -5
> Invalid MAC address for card #0
>
> kernel 2.6.7 and kernel 2.6.7-mm7  working good via-rhine.c
>
> The version via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004: working good:
>
> via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
> PCI: Found IRQ 9 for device 0000:00:12.0
> PCI: Sharing IRQ 9 with 0000:00:0c.0
> PCI: Sharing IRQ 9 with 0000:00:10.0
> PCI: Sharing IRQ 9 with 0000:00:11.1
> PCI: Sharing IRQ 9 with 0000:01:00.0
> divert: allocating divert_blk for eth0
> eth0: VIA Rhine II (VT8235) at 0xd0002c00, 00:03:25:0d:9e:58, IRQ 9.
> eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 41e=
1.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D --=20
Microsoft is to operating systems & security ....
             .... what McDonalds is to gourmet cooking

PGP-Key http://vergata.it/GPG/F17FDB2F.asc
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA/N6hVP5w5vF/2y8RAoTcAJ0aQ9+JsGr6CJE43bXX+GTyjQXkvQCfT+jI
HTekN4AG3s2N2njLqgplrw0=3D
=3DHPni
=2D----END PGP SIGNATURE-----

--Boundary-00=_d6N/Am863hsT/RX
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="kernel.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kernel.log"

kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
kernel: Inspecting /boot/System.map-2.6.7
kernel: Loaded 18743 symbols from /boot/System.map-2.6.7.
kernel: Symbols match kernel version 2.6.7.
kernel: No module symbols loaded - kernel modules not enabled.
kernel: Linux version 2.6.7 (root@rescue) (gcc version 3.3.4 (Debian)) #1 Sat Jul 3 23:15:30 CEST 2004
kernel: BIOS-provided physical RAM map:
kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
kernel:  BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
kernel:  BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
kernel:  BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
kernel: 247MB LOWMEM available.
kernel: On node 0 totalpages: 63472
kernel:   DMA zone: 4096 pages, LIFO batch:1
kernel:   Normal zone: 59376 pages, LIFO batch:14
kernel:   HighMem zone: 0 pages, LIFO batch:1
kernel: DMI 2.2 present.
kernel: ACPI: RSDP (v000 VIAP4M
kernel: ACPI: RSDT (v001 VIAP4M AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0f7f3000
kernel: ACPI: FADT (v001 VIAP4M AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0f7f3040
kernel: ACPI: DSDT (v001 VIAP4M AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
kernel: ACPI: PM-Timer IO Port: 0x408
kernel: Built 1 zonelists
kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=303
kernel: No local APIC present or hardware disabled
kernel: Initializing CPU#0
kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
kernel: Detected 2003.763 MHz processor.
kernel: Using pmtmr for high-res timesource
kernel: Console: colour VGA+ 80x25
kernel: Memory: 248520k/253888k available (1569k kernel code, 4640k reserved, 516k data, 348k init, 0k highmem)
kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
kernel: Calibrating delay loop... 3964.92 BogoMIPS
kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
kernel: CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
kernel: CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
kernel: CPU: L2 cache: 128K
kernel: CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
kernel: Intel machine check architecture supported.
kernel: Intel machine check reporting enabled on CPU#0.
kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
kernel: CPU: Intel(R) Celeron(R) CPU 2.00GHz stepping 07
kernel: Enabling fast FPU save and restore... done.
kernel: Enabling unmasked SIMD FPU exception support... done.
kernel: Checking 'hlt' instruction... OK.
kernel: NET: Registered protocol family 16
kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb350, last bus=1
kernel: PCI: Using configuration type 1
kernel: mtrr: v2.0 (20020519)
kernel: ACPI: Subsystem revision 20040326
kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
kernel: Parsing all Control Methods:........................................................................................................
kernel: Table [DSDT](id F004) - 471 Objects with 45 Devices 104 Methods 31 Regions
kernel: ACPI Namespace successfully loaded at root c03795bc
kernel: ACPI: IRQ9 SCI: Level Trigger.
kernel: evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
kernel: evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000000420 on int 9
kernel: evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 6 Runtime GPEs in this block
kernel: Completing Region/Field/Buffer/Package initialization:...........................................................................
kernel: Initialized 31/31 Regions 6/6 Fields 19/19 Buffers 19/19 Packages (480 nodes)
kernel: Executing all Device _STA and_INI methods:...............................................
kernel: 47 Devices found containing: 47 _STA, 1 _INI methods
kernel: ACPI: Interpreter enabled
kernel: ACPI: Using PIC for interrupt routing
kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
kernel: PCI: Probing PCI hardware (bus 00)
kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 12 14 *15)
kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 15
kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
kernel: PCI: Using ACPI for IRQ routing
kernel: Initializing Cryptographic API
kernel: PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 15
kernel: PCI: Via IRQ fixup for 0000:00:10.1, from 255 to 11
kernel: ACPI: Power Button (FF) [PWRF]
kernel: ACPI: Sleep Button (CM) [SLPB]
kernel: ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
kernel: Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
kernel: loop: loaded (max 8 devices)
kernel: via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
kernel: eth0: VIA VT6102 Rhine-II at 0xec001000, 00:40:63:c4:26:5e, IRQ 15.
kernel: eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e1.
kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
kernel: VP_IDE: chipset revision 6
kernel: VP_IDE: not 100%% native mode: will probe irqs later
kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
kernel:     ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
kernel: hda: HDS722540VLAT20, ATA DISK drive
kernel: Using anticipatory io scheduler
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: hda: max request size: 1024KiB
kernel: hda: 80418240 sectors (41174 MB) w/1794KiB Cache, CHS=16383/255/63, UDMA(100)
kernel:  hda: hda1 hda2 hda3
kernel: mice: PS/2 mouse device common for all mice
kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
kernel: i2c /dev entries driver
kernel: NET: Registered protocol family 2
kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
kernel: TCP: Hash tables configured (established 16384 bind 32768)
kernel: NET: Registered protocol family 1
kernel: NET: Registered protocol family 17
kernel: ACPI: (supports S0 S1 S4 S5)
kernel: kjournald starting.  Commit interval 5 seconds
kernel: EXT3-fs: mounted filesystem with ordered data mode.
kernel: VFS: Mounted root (ext3 filesystem) readonly.
kernel: Freeing unused kernel memory: 348k freed
kernel: Adding 265064k swap on /dev/hda2.  Priority:42 extents:1
kernel: EXT3 FS on hda3, internal journal
kernel: kjournald starting.  Commit interval 5 seconds
kernel: EXT3 FS on hda1, internal journal
kernel: EXT3-fs: mounted filesystem with ordered data mode.
kernel: eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.

--Boundary-00=_d6N/Am863hsT/RX--
