Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTFDFaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTFDFaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:30:15 -0400
Received: from [217.7.64.198] ([217.7.64.198]:37354 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id S262874AbTFDF3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:29:49 -0400
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc7 failed boot without Local APIC support
Date: Wed, 4 Jun 2003 07:43:14 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ybY3+LN8iKqsFbd"
Message-Id: <200306040743.14456.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ybY3+LN8iKqsFbd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Moin.

The only patch applied is acpi-20030512.
2.4.21-rc2 works without problems.
Booting _with_ local APIC enabled works fine, but alsa on VT8233 AC97 does =
not work.
Booting _without_ local APIC:

Linux version 2.4.21-rc7 (root@dev.net4u.de) (gcc version 3.2.2) #6 Wed Jun=
 4 06:51:53 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 KM266                      ) @ 0x000f8090
ACPI: RSDT (v001 KM266  AWRDACPI 16944.11825) @ 0x1fff3000
ACPI: FADT (v001 KM266  AWRDACPI 16944.11825) @ 0x1fff3040
ACPI: MADT (v001 KM266  AWRDACPI 16944.11825) @ 0x1fff6dc0
ACPI: DSDT (v001 KM266  AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Kernel command line: root=3D/dev/hda3 video=3Daty128fb:1280x1024-16 console=
=3DttyS0,38400n8
Initializing CPU#0
Detected 1539.876 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3073.63 BogoMIPS
Memory: 515260k/524224k available (1933k kernel code, 8576k reserved, 628k =
data, 104k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030509
PCI: PCI BIOS revision 2.10 entry at 0xfb6e0, last bus=3D1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23, disabled)
ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23, disabled)
ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
ACPI: PCI Interrupt Link [ALKD] (IRQs 21, disabled)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
EFS: 1.0a - http://aeschi.ch.eu.org/efs/
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
ACPI: Thermal Zone [THRM] (57 C)
aty128fb: Rage128 BIOS located at segment C00C0000
aty128fb: Rage128 Pro PF (AGP) [chip rev 0x1] 32M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 160x64
fb0: ATY Rage128 frame buffer device on PCI
aty128fb: Rage128 MTRR set to ON
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xd000. Vers LK1.1.16
 00:60:97:b8:2e:56, IRQ 5
  product code 4848 rev 00.0 date 03-23-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: Dropping NETIF_F_SG since no checksum feature.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Unsupported Via chipset (device id: 3116), you might want to try a=
gp_try_unsupported=3D1.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized r128 2.2.0 20010917 on minor 1
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:pio
hda: ST320423A, ATA DISK drive
blk: queue c03c5ea0, I/O limit 4095Mb (mask 0xffffffff)
hdc: LTN483L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area =3D> 1
hda: 40011300 sectors (20486 MB) w/512KiB Cache, CHS=3D2490/255/63, UDMA(66)
hdc: attached ide-cdrom driver.
hdc: ATAPI 48X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x9
ACCUM =3D 0x0, SINDEX =3D 0x3, DINDEX =3D 0xe4, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x0
SCSISEQ =3D 0x12, SBLKCTL =3D 0x6
 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89
LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x80
SSTAT0 =3D 0x0, SSTAT1 =3D 0x8
SCSIPHASE =3D 0x0
STACK =3D=3D 0x3, 0x108, 0x160, 0x0
SCB count =3D 4
Kernel NEXTQSCB =3D 2
Card NEXTQSCB =3D 2
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 =
20 21 22 23 24 25 26 27 28 29 30 31
Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0xff) 1(c 0x0, s 0xff, l 255, t=
 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c =
0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff=
, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t =
0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c=
 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0=
xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 25=
5, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xff, l 255, t 0xff=
) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 255, t 0xff) 20(c 0x=
0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0xff) 22(c 0x0, s 0xff=
, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(c 0x0, s 0xff, l 255, =
t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, s 0xff, l 255, t 0xff) 2=
7(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff, l 255, t 0xff) 29(c 0x0, =
s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255, t 0xff) 31(c 0x0, s 0xff, l=
 255, t 0xff)
Pending list:=20
Kernel Free SCB list: 3 1 0=20
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x168
ACCUM =3D 0xa0, SINDEX =3D 0x61, DINDEX =3D 0xe4, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x0
SCSISEQ =3D 0x12, SBLKCTL =3D 0x6
 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89
LASTPHASE =3D 0xa0, SCSISIGI =3D 0xb6, SXFRCTL0 =3D 0x88
SSTAT0 =3D 0x2, SSTAT1 =3D 0x1
SCSIPHASE =3D 0x4
STACK =3D=3D 0x175, 0x160, 0x0, 0xe7
SCB count =3D 4
Kernel NEXTQSCB =3D 3
Card NEXTQSCB =3D 3
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20=
 21 22 23 24 25 26 27 28 29 30 31
Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0x2) 1(c 0x0, s 0xff, l 255, t =
0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0=
x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff,=
 l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0=
xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c =
0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0x=
ff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255=
, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xff, l 255, t 0xff)=
 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 255, t 0xff) 20(c 0x0=
, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0xff) 22(c 0x0, s 0xff,=
 l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(c 0x0, s 0xff, l 255, t=
 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, s 0xff, l 255, t 0xff) 27=
(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff, l 255, t 0xff) 29(c 0x0, s=
 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255, t 0xff) 31(c 0x0, s 0xff, l =
255, t 0xff)
Pending list: 2(c 0x40, s 0x7, l 0)
Kernel Free SCB list: 1 0
Untagged Q(0): 2
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi0:0:0:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
scsi0:0:0:0: Attempting to queue an ABORT message
ahc_intr: HOST_MSG_LOOP bad phase 0x0
scsi0: Dumping Card State while idle, at SEQADDR 0x19d
ACCUM =3D 0xa0, SINDEX =3D 0x0, DINDEX =3D 0xe4, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x0
SCSISEQ =3D 0x12, SBLKCTL =3D 0x6
 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89
LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x80
SSTAT0 =3D 0x0, SSTAT1 =3D 0x0
SCSIPHASE =3D 0x0
STACK =3D=3D 0x160, 0x0, 0xe6, 0xb
SCB count =3D 4
Kernel NEXTQSCB =3D 2
Card NEXTQSCB =3D 3
QINFIFO entries: 3
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 =
20 21 22 23 24 25 26 27 28 29 30 31
Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0xff) 1(c 0x0, s 0xff, l 255, t=
 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c =
0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff=
, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t =
0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c=
 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0=
xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 25=
5, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xff, l 255, t 0xff=
) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 255, t 0xff) 20(c 0x=
0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0xff) 22(c 0x0, s 0xff=
, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(c 0x0, s 0xff, l 255, =
t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, s 0xff, l 255, t 0xff) 2=
7(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff, l 255, t 0xff) 29(c 0x0, =
s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255, t 0xff) 31(c 0x0, s 0xff, l=
 255, t 0xff)
Pending list: 3(c 0x50, s 0x7, l 0)
Kernel Free SCB list: 1 0
Untagged Q(0): 3
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi: device set offline - not ready or command retry failed after bus rese=
t: host 0 channel 0 id 0 lun 0
scsi0:0:1:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
ACCUM =3D 0x0, SINDEX =3D 0x2, DINDEX =3D 0xe4, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x0
SCSISEQ =3D 0x12, SBLKCTL =3D 0x6
 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89
LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x80
SSTAT0 =3D 0x0, SSTAT1 =3D 0x8
SCSIPHASE =3D 0x0
STACK =3D=3D 0x3, 0x108, 0x160, 0xe6
SCB count =3D 4
Kernel NEXTQSCB =3D 3
Card NEXTQSCB =3D 3
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 =
20 21 22 23 24 25 26 27 28 29 30 31
Sequencer SCB Info: 0(c 0x40, s 0x17, l 0, t 0xff) 1(c 0x0, s 0xff, l 255, =
t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c=
 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xf=
f, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t=
 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(=
c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s =
0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 2=
55, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xff, l 255, t 0xf=
f) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 255, t 0xff) 20(c 0=
x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0xff) 22(c 0x0, s 0xf=
f, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(c 0x0, s 0xff, l 255,=
 t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, s 0xff, l 255, t 0xff) =
27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff, l 255, t 0xff) 29(c 0x0,=
 s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255, t 0xff) 31(c 0x0, s 0xff, =
l 255, t 0xff)
Pending list:
Kernel Free SCB list: 2 1 0
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
scsi0:0:1:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:1:0: Attempting to queue an ABORT message
scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x168
ACCUM =3D 0xa0, SINDEX =3D 0x61, DINDEX =3D 0xe4, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x0
SCSISEQ =3D 0x12, SBLKCTL =3D 0x6
 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89
LASTPHASE =3D 0xa0, SCSISIGI =3D 0xb6, SXFRCTL0 =3D 0x88
SSTAT0 =3D 0x2, SSTAT1 =3D 0x1
SCSIPHASE =3D 0x4
STACK =3D=3D 0x175, 0x160, 0xe6, 0xe7
SCB count =3D 4
Kernel NEXTQSCB =3D 2
Card NEXTQSCB =3D 2
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20=
 21 22 23 24 25 26 27 28 29 30 31
Sequencer SCB Info: 0(c 0x40, s 0x17, l 0, t 0x3) 1(c 0x0, s 0xff, l 255, t=
 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c =
0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff=
, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t =
0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c=
 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0=
xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 25=
5, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xff, l 255, t 0xff=
) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 255, t 0xff) 20(c 0x=
0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0xff) 22(c 0x0, s 0xff=
, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(c 0x0, s 0xff, l 255, =
t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, s 0xff, l 255, t 0xff) 2=
7(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff, l 255, t 0xff) 29(c 0x0, =
s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255, t 0xff) 31(c 0x0, s 0xff, l=
 255, t 0xff)
Pending list: 3(c 0x40, s 0x17, l 0)
Kernel Free SCB list: 1 0
Untagged Q(1): 3
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
scsi0:0:1:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
aic7xxx_abort returns 0x2002
scsi0:0:1:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
[...........]

dev:~ # lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8375 [KM266] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:08.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
00:0a.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Ma=
ster IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Aud=
io Controller (rev 40)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP=
 4x TMDS



=46ailed config attached.
<Earny>

--Boundary-00=_ybY3+LN8iKqsFbd
Content-Type: text/plain;
  charset="us-ascii";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=".config"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_ONLYDISK=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=y
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_TC35815 is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=y
CONFIG_DRM_R128=y
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_EFS_FS=y
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_INTEL is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

#
# Library routines
#
CONFIG_ZLIB_INFLATE=y
# CONFIG_ZLIB_DEFLATE is not set

--Boundary-00=_ybY3+LN8iKqsFbd--

