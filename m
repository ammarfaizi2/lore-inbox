Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUIGGIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUIGGIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 02:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUIGGIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 02:08:52 -0400
Received: from ns2.rdsct.ro ([212.93.137.18]:25047 "EHLO rdsct.ro")
	by vger.kernel.org with ESMTP id S267602AbUIGGIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 02:08:10 -0400
Message-ID: <000401c494a2$a0680180$0302a8c0@me>
From: "Adrian" <ccsfn.noc@rdsct.ro>
To: <linux-kernel@vger.kernel.org>
References: <16A54BF5D6E14E4D916CE26C9AD305751202C8@pdsmsx402.ccr.corp.intel.com>
Subject: Re: kernel 2.6.8.1 - irq7: nobody cared!
Date: Tue, 7 Sep 2004 09:19:26 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# cat /proc/acpi/processor/CPU0/power
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000]
usage[00609480]
   *C2:                  promotion[--] demotion[C1] latency[090]
usage[03053026]
    C3:                  <not supported>


boot messages are:
(yep i run eth1 in promisc mode. i have a traffic analyser running there.
and yes. it seems acpi is irq7)

Linux version 2.6.8.1 (root@mylinux) (gcc version 3.3.3 20040412 (Red Hat
Linux 3.3.3-7)) #3 Wed Aug 18 10:26:05 EEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 VIA694                                    ) @ 0x000f7730
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: ro root=/dev/hda2 vga=ext
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 700.024 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 252872k/262080k available (3742k kernel code, 8468k reserved, 1382k
data, 296k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1384.44 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: After vendor identify, caps:  0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps:        0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 699.0892 MHz.
..... host bus clock speed is 199.0969 MHz.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb220, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ7 SCI: Level Trigger.
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 12 (level, low) -> IRQ 12
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1094543854.964:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NTFS driver 2.1.15 [Flags: R/O].
udf: registering filesystem
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec
(nowayout= 0)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 16M @ 0xd0000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60
seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
nbd: registered device at major 43
Ethernet Channel Bonding Driver: v2.6.0 (January 14, 2004)
bonding: Warning: either miimon or arp_interval and arp_ip_target module
parameters must be specified, otherwise bonding will not detect link
failures! see bonding.txt for details.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: RealTek RTL8139 at 0xd082a000, 00:50:bf:5a:52:1a, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 (level, low) -> IRQ 11
eth1: RealTek RTL8139 at 0xd082c000, 00:50:bf:5a:4f:8e, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139C'
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD200EB-00BHF0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(66)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 276
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2c /dev entries driver
EISA: Probing bus 0 at eisa0
cmpci: version $Revision: 6.82 $ time 15:30:59 Aug 17 2004
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 11 (level, low) -> IRQ 11
cmpci:
cmpci: found CM8738 adapter at io 0xe400 irq 11
cmpci: chip version = 037
mpu401: I/O port 0 already in use

YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft
1993-1996
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44
2004 UTC).
can't register device seq
ALSA device list:
  No soundcards found.
NET: Registered protocol family 26
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_time loading
netfilter PSD loaded - (c) astaro AG
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
Ebtables v2.0 registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 296k freed
EXT3 FS on hda2, internal journal
Adding 506008k swap on /dev/hda5.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
eth1: link up, 100Mbps, half-duplex, lpa 0x40A1
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 5 (level, low) -> IRQ 5
bttv0: Bt848 (rev 18) at 0000:00:10.0, irq: 5, latency: 32, mmio: 0xd4002000
bttv0: using: MIRO PCTV [card=1,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00ff07ff [init]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: miro: id=1 tuner=0 radio=no stereo=no
bttv0: using tuner=0
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54
(PV951),ta8874z
tuner: chip found at addr 0xc0 i2c-bus bt848 #0 [sw]
tuner: type set to 0 (Temic PAL (4002 FH5)) by bt848 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
eth1: Promiscuous mode enabled.
device eth1 entered promiscuous mode




Adrian



P.S.
on i side note, i think i solved the problems i had with bttv by upgrading
xawtv.
i had xawtv 3.93 and i upgraded to 3.94 and those pesky messages dont appear
anymore.

with 3.93 i kept getting these messages:
Sep  3 08:44:47 mylinux kernel: bttv0: SCERR @ 0e36501c,bits: HSYNC OFLOW
FBUS SCERR*
Sep  3 08:44:47 mylinux kernel: bttv0: SCERR @ 0e36501c,bits: HSYNC OFLOW
SCERR*
Sep  3 08:44:47 mylinux last message repeated 5 times
Sep  3 08:44:47 mylinux kernel: bttv0: SCERR @ 0e36501c,bits: HSYNC OFLOW
FBUS SCERR*
Sep  3 08:44:47 mylinux kernel: bttv0: SCERR @ 0e36501c,bits: HSYNC OFLOW
SCERR*
Sep  3 08:44:48 mylinux last message repeated 6 times
Sep  3 08:44:48 mylinux kernel: bttv0: SCERR @ 0e36501c,bits: HSYNC OFLOW
FBUS SCERR*
Sep  3 08:44:48 mylinux kernel: bttv0: SCERR @ 0e36501c,bits: HSYNC OFLOW
SCERR*
Sep  3 08:44:52 mylinux last message repeated 114 times
Sep  3 08:44:52 mylinux kernel: bttv0: SCERR @ 0e36501c,bits: HSYNC OFLOW
FBUS SCERR*
Sep  3 08:44:52 mylinux kernel: bttv0: SCERR @ 0e36501c,bits: HSYNC OFLOW
FBUS SCERR*
Sep  3 08:44:52 mylinux kernel: bttv0: SCERR @ 0e36501c,bits: HSYNC OFLOW
SCERR*
Sep  3 08:44:57 mylinux last message repeated 122 times

tuner is an old miro video pc tv with driver loaded as:
modprobe tvmixer
modprobe bttv i2c_debug=1 card=1 radio=0 tuner=0


Sep  7 07:58:17 mylinux kernel: bttv: driver version 0.9.15 loaded
Sep  7 07:58:17 mylinux kernel: bttv: using 8 buffers with 2080k (520 pages)
each for capture
Sep  7 07:58:17 mylinux kernel: bttv: Bt8xx card found (0).
Sep  7 07:58:17 mylinux kernel: ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 5
(level, low) -> IRQ 5
Sep  7 07:58:17 mylinux kernel: bttv0: Bt848 (rev 18) at 0000:00:10.0, irq:
5, latency: 32, mmio: 0xd4002000
Sep  7 07:58:17 mylinux kernel: bttv0: using: MIRO PCTV [card=1,insmod
option]
Sep  7 07:58:17 mylinux kernel: bttv0: gpio: en=00000000, out=00000000
in=00ff07ff [init]
Sep  7 07:58:17 mylinux kernel: bttv0: i2c: checking for MSP34xx @ 0x80...
not found
Sep  7 07:58:17 mylinux kernel: bttv0: miro: id=1 tuner=0 radio=no stereo=no
Sep  7 07:58:17 mylinux kernel: bttv0: using tuner=0
Sep  7 07:58:17 mylinux kernel: bttv0: i2c: checking for MSP34xx @ 0x80...
not found
Sep  7 07:58:17 mylinux kernel: bttv0: i2c: checking for TDA9875 @ 0xb0...
not found
Sep  7 07:58:17 mylinux kernel: bttv0: i2c: checking for TDA7432 @ 0x8a...
not found
Sep  7 07:58:17 mylinux kernel: tvaudio: TV audio decoder + audio/video mux
driver
Sep  7 07:58:17 mylinux kernel: tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54
(PV951),ta8874z
Sep  7 07:58:17 mylinux kernel: tuner: chip found at addr 0xc0 i2c-bus bt848
#0 [sw]
Sep  7 07:58:17 mylinux kernel: tuner: type set to 0 (Temic PAL (4002 FH5))
by bt848 #0 [sw]
Sep  7 07:58:17 mylinux kernel: bttv0: registered device video0
Sep  7 07:58:17 mylinux kernel: bttv0: registered device vbi0


----- Original Message ----- 
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Adrian" <ccsfn.noc@rdsct.ro>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Tuesday, September 07, 2004 8:39 AM
Subject: RE: kernel 2.6.8.1 - irq7: nobody cared!


> Hi,
> Sounds like ACPI bug. Could you send me the output of 'cat
> /proc/acpi/processor/CPU0/power'? IS your acpi interrupt 7?
>
> Thanks,
> Shaohua
>
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> >owner@vger.kernel.org] On Behalf Of Adrian
> >Sent: Tuesday, September 07, 2004 1:23 PM
> >To: linux-kernel@vger.kernel.org
> >Subject: kernel 2.6.8.1 - irq7: nobody cared!
> >
> >whats happening here ? i get these message about once or twice a week.
> >
> >Sep  7 07:13:00 mylinux kernel: irq 7: nobody cared!
> >Sep  7 07:13:00 mylinux kernel:  [<c010644a>]
> __report_bad_irq+0x2a/0x90
> >Sep  7 07:13:00 mylinux kernel:  [<c010653c>] note_interrupt+0x6c/0xa0
> >Sep  7 07:13:00 mylinux kernel:  [<c0106820>] do_IRQ+0x130/0x160
> >Sep  7 07:13:00 mylinux kernel:  [<c0104aec>]
> common_interrupt+0x18/0x20
> >Sep  7 07:13:00 mylinux kernel:  [<c01227b0>] __do_softirq+0x30/0x80
> >Sep  7 07:13:00 mylinux kernel:  [<c0122826>] do_softirq+0x26/0x30
> >Sep  7 07:13:00 mylinux kernel:  [<c01067fd>] do_IRQ+0x10d/0x160
> >Sep  7 07:13:00 mylinux kernel:  [<c0104aec>]
> common_interrupt+0x18/0x20
> >Sep  7 07:13:00 mylinux kernel:  [<c02a3827>]
> >acpi_processor_idle+0xd2/0x1c4
> >Sep  7 07:13:00 mylinux kernel:  [<c01020bc>] cpu_idle+0x2c/0x40
> >Sep  7 07:13:00 mylinux kernel:  [<c0604767>] start_kernel+0x167/0x190
> >Sep  7 07:13:00 mylinux kernel:  [<c0604380>]
> unknown_bootoption+0x0/0x160
> >Sep  7 07:13:00 mylinux kernel: handlers:
> >Sep  7 07:13:00 mylinux kernel: [<c0288acc>] (acpi_irq+0x0/0x16)
> >Sep  7 07:13:00 mylinux kernel: Disabling IRQ #7
> >
> >
> >
> >kernel is 2.6.8.1 from kernel.org, monolithic except for the bttv
> modules,
> >recompiled for my system. distribution is fedora core 2 with all yum
> >updates
> >applied.
> >
> >/proc/cpuinfo
> >processor       : 0
> >vendor_id       : AuthenticAMD
> >cpu family      : 6
> >model           : 3
> >model name      : AMD Duron(tm) Processor
> >stepping        : 1
> >cpu MHz         : 700.024
> >cache size      : 64 KB
> >fdiv_bug        : no
> >hlt_bug         : no
> >f00f_bug        : no
> >coma_bug        : no
> >fpu             : yes
> >fpu_exception   : yes
> >cpuid level     : 1
> >wp              : yes
> >flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca
> >cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
> >bogomips        : 1384.44
> >
> >
> >lspci
> >00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
> (rev
> >03)
> >00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133
> AGP]
> >00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
> South]
> >(rev 22)
> >00:07.1 IDE interface: VIA Technologies, Inc.
> >VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10)
> >00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> (rev 30)
> >00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> >RTL-8139/8139C/8139C+ (rev 10)
> >00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> >RTL-8139/8139C/8139C+ (rev 10)
> >00:10.0 Multimedia video controller: Brooktree Corporation Bt848 Video
> >Capture (rev 12)
> >00:11.0 Multimedia audio controller: C-Media Electronics Inc CM8738
> (rev 10)
> >01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
> P/M
> >AGP 2x (rev 64)
> >
> >
> >i also have an issue with the tv tuner driver going beserk sometimes,
> ill
> >post that as another thread.
> >
> >Adrian.
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


