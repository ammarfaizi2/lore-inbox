Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVFQKxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVFQKxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 06:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVFQKxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 06:53:48 -0400
Received: from osten.wh.uni-dortmund.de ([129.217.129.130]:57755 "EHLO
	osten.wh.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261942AbVFQKtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 06:49:51 -0400
Message-ID: <42B2AACC.7070908@web.de>
Date: Fri, 17 Jun 2005 12:49:48 +0200
From: Alexander Fieroch <fieroch@web.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:  
 nobody cared!"
References: <d6gf8j$jnb$1@sea.gmane.org>	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>	 <58cb370e05061401041a67cfa7@mail.gmail.com> <42B091EE.4020802@web.de>	 <20050615143039.24132251.akpm@osdl.org> <1118960606.24646.58.camel@localhost.localdomain>
In-Reply-To: <1118960606.24646.58.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------070202080300090808000609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070202080300090808000609
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> The -ac tree, Fedora and various other systems support IT8212, the Linus
> kernel does not. 

I've tested linux 2.6.11-ac7 with IT8212 compiled into the kernel. I can
see my devices and mount them, but the kernel hangs for a while when I
access hdb and the errors this thread is about appear too.
The complete syslog is attached.

> Please direct any queries with regards to that to the
> IDE maintainers as I've given up submitting IDE fixes to the base
> kernel.

I don't know who the IDE maintainers are, but they are reading this list
too, aren't they?

Regards,
Alexander

--------------070202080300090808000609
Content-Type: text/plain;
 name="syslog2611ac7"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="syslog2611ac7"

Jun 17 12:07:49 orclex syslog-ng[4092]: syslog-ng version 1.6.7 starting
Jun 17 12:07:49 orclex syslog-ng[4092]: Changing permissions on special file /dev/xconsole
Jun 17 12:07:49 orclex syslog-ng[4092]: Cannot open file /dev/xconsole for writing (No such file or directory)
Jun 17 12:07:49 orclex kernel: 3ffb0000 - 000000003ffbe000 (ACPI data)
Jun 17 12:07:49 orclex kernel: BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
Jun 17 12:07:49 orclex kernel: BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
Jun 17 12:07:49 orclex kernel: BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Jun 17 12:07:49 orclex kernel: ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fb070
Jun 17 12:07:49 orclex kernel: ACPI: XSDT (v001 A M I  OEMXSDT  0x03000521 MSFT 0x00000097) @ 0x000000003ffb0100
Jun 17 12:07:49 orclex kernel: ACPI: FADT (v003 A M I  OEMFACP  0x03000521 MSFT 0x00000097) @ 0x000000003ffb0290
Jun 17 12:07:49 orclex kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x03000521 MSFT 0x00000097) @ 0x000000003ffb0390
Jun 17 12:07:49 orclex kernel: ACPI: OEMB (v001 A M I  AMI_OEM  0x03000521 MSFT 0x00000097) @ 0x000000003ffbe040
Jun 17 12:07:49 orclex kernel: ACPI: MCFG (v001 A M I  OEMMCFG  0x03000521 MSFT 0x00000097) @ 0x000000003ffb6c60
Jun 17 12:07:49 orclex kernel: ACPI: DSDT (v001  A0086 A0086003 0x00000003 INTL 0x02002026) @ 0x0000000000000000
Jun 17 12:07:49 orclex kernel: On node 0 totalpages: 262064
Jun 17 12:07:49 orclex kernel: DMA zone: 4096 pages, LIFO batch:1
Jun 17 12:07:49 orclex kernel: Normal zone: 257968 pages, LIFO batch:16
Jun 17 12:07:49 orclex kernel: HighMem zone: 0 pages, LIFO batch:1
Jun 17 12:07:49 orclex kernel: ACPI: Local APIC address 0xfee00000
Jun 17 12:07:49 orclex kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Jun 17 12:07:49 orclex kernel: Processor #0 15:4 APIC version 16
Jun 17 12:07:49 orclex kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Jun 17 12:07:49 orclex kernel: Processor #1 15:4 APIC version 16
Jun 17 12:07:49 orclex kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jun 17 12:07:49 orclex kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Jun 17 12:07:49 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jun 17 12:07:49 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jun 17 12:07:49 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jun 17 12:07:49 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jun 17 12:07:49 orclex kernel: ACPI: IRQ0 used by override.
Jun 17 12:07:49 orclex kernel: ACPI: IRQ2 used by override.
Jun 17 12:07:49 orclex kernel: ACPI: IRQ9 used by override.
Jun 17 12:07:49 orclex kernel: Setting APIC routing to flat
Jun 17 12:07:49 orclex kernel: Using ACPI (MADT) for SMP configuration information
Jun 17 12:07:49 orclex kernel: Built 1 zonelists
Jun 17 12:07:49 orclex kernel: Kernel command line: root=/dev/sda3 vga=792  console=tty0
Jun 17 12:07:49 orclex kernel: Initializing CPU#0
Jun 17 12:07:49 orclex kernel: PID hash table entries: 4096 (order: 12, 131072 bytes)
Jun 17 12:07:49 orclex kernel: time.c: Using 1.193182 MHz PIT timer.
Jun 17 12:07:49 orclex kernel: time.c: Detected 3010.773 MHz processor.
Jun 17 12:07:49 orclex kernel: Console: colour dummy device 80x25
Jun 17 12:07:49 orclex kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jun 17 12:07:49 orclex kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jun 17 12:07:49 orclex kernel: Memory: 1024004k/1048256k available (3238k kernel code, 23560k reserved, 1684k data, 224k init)
Jun 17 12:07:49 orclex kernel: Calibrating delay loop... 5931.00 BogoMIPS (lpj=2965504)
Jun 17 12:07:49 orclex kernel: Security Framework v1.0.0 initialized
Jun 17 12:07:49 orclex kernel: Capability LSM initialized
Jun 17 12:07:49 orclex kernel: Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
Jun 17 12:07:49 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun 17 12:07:49 orclex kernel: CPU: L2 cache: 2048K
Jun 17 12:07:49 orclex kernel: using mwait in idle threads.
Jun 17 12:07:49 orclex kernel: CPU: Physical Processor ID: 0
Jun 17 12:07:49 orclex kernel: CPU0: Thermal monitoring enabled (TM1)
Jun 17 12:07:49 orclex kernel: Using IO APIC NMI watchdog
Jun 17 12:07:49 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun 17 12:07:49 orclex kernel: CPU: L2 cache: 2048K
Jun 17 12:07:49 orclex kernel: CPU: Physical Processor ID: 0
Jun 17 12:07:49 orclex kernel: CPU0:               Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Jun 17 12:07:49 orclex kernel: per-CPU timeslice cutoff: 621.48 usecs.
Jun 17 12:07:49 orclex kernel: task migration cache decay timeout: 1 msecs.
Jun 17 12:07:49 orclex kernel: Booting processor 1/1 rip 6000 rsp ffff81003ff47f58
Jun 17 12:07:49 orclex kernel: Initializing CPU#1
Jun 17 12:07:49 orclex kernel: Calibrating delay loop... 6012.92 BogoMIPS (lpj=3006464)
Jun 17 12:07:49 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun 17 12:07:49 orclex kernel: CPU: L2 cache: 2048K
Jun 17 12:07:49 orclex kernel: CPU: Physical Processor ID: 0
Jun 17 12:07:49 orclex kernel: CPU1: Thermal monitoring enabled (TM1)
Jun 17 12:07:49 orclex kernel: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Jun 17 12:07:49 orclex kernel: Total of 2 processors activated (11943.93 BogoMIPS).
Jun 17 12:07:49 orclex kernel: activating NMI Watchdog ... done.
Jun 17 12:07:49 orclex kernel: testing NMI watchdog ... CPU#1: NMI appears to be stuck (0)!
Jun 17 12:07:49 orclex kernel: Using local APIC timer interrupts.
Jun 17 12:07:49 orclex kernel: Detected 12.544 MHz APIC timer.
Jun 17 12:07:49 orclex kernel: checking TSC synchronization across 2 CPUs: passed.
Jun 17 12:07:49 orclex kernel: time.c: Using PIT/TSC based timekeeping.
Jun 17 12:07:49 orclex kernel: Brought up 2 CPUs
Jun 17 12:07:49 orclex kernel: CPU0 attaching sched-domain:
Jun 17 12:07:49 orclex kernel: domain 0: span 03
Jun 17 12:07:49 orclex kernel: groups: 01 02
Jun 17 12:07:49 orclex kernel: domain 1: span 03
Jun 17 12:07:49 orclex kernel: groups: 03
Jun 17 12:07:49 orclex kernel: CPU1 attaching sched-domain:
Jun 17 12:07:49 orclex kernel: domain 0: span 03
Jun 17 12:07:49 orclex kernel: groups: 02 01
Jun 17 12:07:49 orclex kernel: domain 1: span 03
Jun 17 12:07:49 orclex kernel: groups: 03
Jun 17 12:07:49 orclex kernel: NET: Registered protocol family 16
Jun 17 12:07:49 orclex kernel: PCI: Using configuration type 1
Jun 17 12:07:49 orclex kernel: PCI: Using MMCONFIG at e0000000
Jun 17 12:07:49 orclex kernel: mtrr: v2.0 (20020519)
Jun 17 12:07:49 orclex kernel: ACPI: Subsystem revision 20050211
Jun 17 12:07:49 orclex kernel: ACPI: Interpreter enabled
Jun 17 12:07:49 orclex udev[4104]: creating device node '/dev/vcs1'
Jun 17 12:07:49 orclex kernel: ACPI: Using IOAPIC for interrupt routing
Jun 17 12:07:49 orclex kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jun 17 12:07:49 orclex kernel: PCI: Probing PCI hardware (bus 00)
Jun 17 12:07:49 orclex kernel: PCI: Transparent bridge - 0000:00:1e.0
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 *15)
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 *14 15)
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jun 17 12:07:49 orclex kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jun 17 12:07:49 orclex kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jun 17 12:07:49 orclex kernel: pnp: PnP ACPI init
Jun 17 12:07:49 orclex kernel: pnp: PnP ACPI: found 19 devices
Jun 17 12:07:49 orclex kernel: SCSI subsystem initialized
Jun 17 12:07:49 orclex kernel: usbcore: registered new driver usbfs
Jun 17 12:07:49 orclex kernel: usbcore: registered new driver hub
Jun 17 12:07:49 orclex kernel: PCI: Using ACPI for IRQ routing
Jun 17 12:07:49 orclex kernel: ** PCI interrupts are no longer routed automatically.  If this
Jun 17 12:07:49 orclex kernel: ** causes a device to stop working, it is probably because the
Jun 17 12:07:49 orclex kernel: ** driver failed to call pci_enable_device().  As a temporary
Jun 17 12:07:49 orclex kernel: ** workaround, the "pci=routeirq" argument restores the old
Jun 17 12:07:49 orclex kernel: ** behavior.  If this argument makes the device work again,
Jun 17 12:07:49 orclex kernel: ** please email the output of "lspci" to bjorn.helgaas@hp.com
Jun 17 12:07:49 orclex kernel: ** so I can fix the driver.
Jun 17 12:07:49 orclex kernel: TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
Jun 17 12:07:49 orclex kernel: pnp: 00:07: ioport range 0x290-0x297 has been reserved
Jun 17 12:07:49 orclex kernel: pnp: 00:09: ioport range 0x3f6-0x3f6 has been reserved
Jun 17 12:07:49 orclex kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Jun 17 12:07:49 orclex kernel: IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Jun 17 12:07:49 orclex udev[4107]: creating device node '/dev/vcsa1'
Jun 17 12:07:49 orclex kernel: NTFS driver 2.1.22 [Flags: R/O].
Jun 17 12:07:49 orclex kernel: Initializing Cryptographic API
Jun 17 12:07:49 orclex kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20010100000, using 6144k, total 131072k
Jun 17 12:07:49 orclex kernel: vesafb: mode is 1024x768x32, linelength=4096, pages=1
Jun 17 12:07:49 orclex kernel: vesafb: scrolling: redraw
Jun 17 12:07:49 orclex kernel: vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Jun 17 12:07:49 orclex kernel: Console: switching to colour frame buffer device 128x48
Jun 17 12:07:49 orclex kernel: fb0: VESA VGA frame buffer device
Jun 17 12:07:49 orclex kernel: vga16fb: initializing
Jun 17 12:07:49 orclex kernel: vga16fb: mapped to 0xffff8100000a0000
Jun 17 12:07:49 orclex kernel: fb1: VGA16 VGA frame buffer device
Jun 17 12:07:49 orclex kernel: ACPI: Power Button (FF) [PWRF]
Jun 17 12:07:49 orclex kernel: ACPI: Processor [CPU1] (supports 8 throttling states)
Jun 17 12:07:49 orclex kernel: Real Time Clock Driver v1.12
Jun 17 12:07:49 orclex kernel: Linux agpgart interface v0.100 (c) Dave Jones
Jun 17 12:07:49 orclex kernel: [drm] Initialized drm 1.0.0 20040925
Jun 17 12:07:49 orclex kernel: Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Jun 17 12:07:49 orclex kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 17 12:07:49 orclex kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 17 12:07:49 orclex kernel: io scheduler noop registered
Jun 17 12:07:49 orclex kernel: io scheduler anticipatory registered
Jun 17 12:07:49 orclex kernel: io scheduler deadline registered
Jun 17 12:07:49 orclex kernel: io scheduler cfq registered
Jun 17 12:07:49 orclex kernel: Floppy drive(s): fd0 is 1.44M
Jun 17 12:07:49 orclex kernel: FDC 0 is a post-1991 82077
Jun 17 12:07:49 orclex kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Jun 17 12:07:49 orclex kernel: loop: loaded (max 8 devices)
Jun 17 12:07:49 orclex kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun 17 12:07:49 orclex kernel: eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
Jun 17 12:07:49 orclex kernel: PrefPort:A  RlmtMode:Check Link State
Jun 17 12:07:49 orclex kernel: PPP generic driver version 2.4.2
Jun 17 12:07:49 orclex kernel: PPP Deflate Compression module registered
Jun 17 12:07:49 orclex kernel: NET: Registered protocol family 24
Jun 17 12:07:49 orclex kernel: dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
Jun 17 12:07:49 orclex kernel: Linux video capture interface: v1.00
Jun 17 12:07:49 orclex kernel: bttv: driver version 0.9.15 loaded
Jun 17 12:07:49 orclex kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Jun 17 12:07:49 orclex kernel: bttv: Bt8xx card found (0).
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, low) -> IRQ 17
Jun 17 12:07:49 orclex kernel: bttv0: Bt878 (rev 2) at 0000:01:09.0, irq: 17, latency: 64, mmio: 0xd7ffe000
Jun 17 12:07:49 orclex udev[4119]: removing device node '/dev/vcs1'
Jun 17 12:07:49 orclex kernel: bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
Jun 17 12:07:49 orclex kernel: bttv0: using: Hauppauge (bt878) [card=10,autodetected]
Jun 17 12:07:49 orclex kernel: bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
Jun 17 12:07:49 orclex kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
Jun 17 12:07:49 orclex kernel: tveeprom: Hauppauge: model = 61334, rev = B   , serial# = 3026517
Jun 17 12:07:49 orclex kernel: tveeprom: tuner = Philips FM1216 (idx = 21, type = 5)
Jun 17 12:07:49 orclex kernel: tveeprom: tuner fmt = PAL(B/G) (eeprom = 0x04, v4l2 = 0x00000007)
Jun 17 12:07:49 orclex kernel: tveeprom: audio_processor = MSP3415 (type = 6)
Jun 17 12:07:49 orclex kernel: bttv0: using tuner=5
Jun 17 12:07:49 orclex kernel: bttv0: registered device video0
Jun 17 12:07:49 orclex kernel: bttv0: registered device vbi0
Jun 17 12:07:49 orclex kernel: bttv0: registered device radio0
Jun 17 12:07:49 orclex kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Jun 17 12:07:49 orclex kernel: msp34xx: init: chip=MSP3410D-B4 +nicam +simple mode=simple
Jun 17 12:07:49 orclex kernel: msp3410: daemon started
Jun 17 12:07:49 orclex kernel: tvaudio: TV audio decoder + audio/video mux driver
Jun 17 12:07:49 orclex kernel: tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
Jun 17 12:07:49 orclex kernel: SAA5246A (or compatible) Teletext decoder driver version 1.8
Jun 17 12:07:49 orclex kernel: SAA5249 driver (SAA5249 interface) for VideoText version 1.8
Jun 17 12:07:49 orclex kernel: tuner: chip found at addr 0xc2 i2c-bus bt878 #0 [sw]
Jun 17 12:07:49 orclex kernel: tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by bt878 #0 [sw]
Jun 17 12:07:49 orclex kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun 17 12:07:49 orclex kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 17 12:07:49 orclex kernel: ICH6: IDE controller at PCI slot 0000:00:1f.1
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
Jun 17 12:07:49 orclex kernel: ICH6: chipset revision 3
Jun 17 12:07:49 orclex kernel: ICH6: 100% native mode on irq 18
Jun 17 12:07:49 orclex kernel: ide0: BM-DMA at 0x5800-0x5807, BIOS settings: hda:DMA, hdb:DMA
Jun 17 12:07:49 orclex kernel: ide1: BM-DMA at 0x5808-0x580f, BIOS settings: hdc:pio, hdd:pio
Jun 17 12:07:49 orclex kernel: Probing IDE interface ide0...
Jun 17 12:07:49 orclex kernel: hda: IC35L060AVV207-0, ATA DISK drive
Jun 17 12:07:49 orclex kernel: hdb: SONY CD-RW CRX210E1, ATAPI CD/DVD-ROM drive
Jun 17 12:07:49 orclex kernel: ide0 at 0x7000-0x7007,0x6802 on irq 18
Jun 17 12:07:49 orclex kernel: Probing IDE interface ide1...
Jun 17 12:07:49 orclex kernel: IT8212: IDE controller at PCI slot 0000:01:04.0
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:01:04.0[A] -> GSI 23 (level, low) -> IRQ 23
Jun 17 12:07:49 orclex kernel: IT8212: chipset revision 19
Jun 17 12:07:49 orclex udev[4125]: removing device node '/dev/vcsa1'
Jun 17 12:07:49 orclex kernel: it821x: controller in pass through mode.
Jun 17 12:07:49 orclex kernel: IT8212: 100% native mode on irq 23
Jun 17 12:07:49 orclex kernel: Losing some ticks... checking if CPU frequency changed.
Jun 17 12:07:49 orclex kernel: ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:pio, hdf:pio
Jun 17 12:07:49 orclex kernel: ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:pio, hdh:pio
Jun 17 12:07:49 orclex kernel: Probing IDE interface ide2...
Jun 17 12:07:49 orclex kernel: hdf: Pioneer DVD-ROM ATAPIModel DVD-104S 012, ATAPI CD/DVD-ROM drive
Jun 17 12:07:49 orclex kernel: ide2 at 0xb000-0xb007,0xa802 on irq 23
Jun 17 12:07:49 orclex kernel: Probing IDE interface ide3...
Jun 17 12:07:49 orclex kernel: Probing IDE interface ide1...
Jun 17 12:07:49 orclex kernel: Probing IDE interface ide3...
Jun 17 12:07:49 orclex kernel: hda: max request size: 1024KiB
Jun 17 12:07:49 orclex kernel: hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
Jun 17 12:07:49 orclex kernel: hda: cache flushes supported
Jun 17 12:07:49 orclex kernel: hda: hda1 hda2
Jun 17 12:07:49 orclex kernel: hdb: packet command error: status=0xd0 { Busy }
Jun 17 12:07:49 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:07:49 orclex kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Jun 17 12:07:49 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:07:49 orclex kernel: hdb: drive not ready for command
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex udev[4137]: creating device node '/dev/vcsa1'
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:07:49 orclex kernel: 
Jun 17 12:07:49 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:07:49 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:07:49 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:07:49 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:07:49 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:07:49 orclex kernel: handlers:
Jun 17 12:07:49 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:07:49 orclex kernel: Disabling IRQ #18
Jun 17 12:07:49 orclex kernel: ide-cd: cmd 0x5a timed out
Jun 17 12:07:49 orclex kernel: hdb: irq timeout: status=0xd0 { Busy }
Jun 17 12:07:49 orclex udev[4140]: creating device node '/dev/vcs1'
Jun 17 12:07:49 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:07:49 orclex kernel: hdb: DMA disabled
Jun 17 12:07:49 orclex kernel: hdb: ATAPI reset complete
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:07:49 orclex kernel: 
Jun 17 12:07:49 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:07:49 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:07:49 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:07:49 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:07:49 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:07:49 orclex kernel: handlers:
Jun 17 12:07:49 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:07:49 orclex kernel: Disabling IRQ #18
Jun 17 12:07:49 orclex kernel: ide-cd: cmd 0x5a timed out
Jun 17 12:07:49 orclex kernel: hdb: irq timeout: status=0xd0 { Busy }
Jun 17 12:07:49 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:07:49 orclex kernel: hdb: ATAPI reset complete
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:07:49 orclex kernel: 
Jun 17 12:07:49 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:07:49 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:07:49 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:07:49 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:07:49 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:07:49 orclex kernel: handlers:
Jun 17 12:07:49 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:07:49 orclex kernel: Disabling IRQ #18
Jun 17 12:07:49 orclex kernel: ide-cd: cmd 0x5a timed out
Jun 17 12:07:49 orclex kernel: hdb: lost interrupt
Jun 17 12:07:49 orclex kernel: Uniform CD-ROM driver Revision: 3.20
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:49 orclex kernel: hdf: ATAPI DVD-ROM drive, 512kB Cache
Jun 17 12:07:49 orclex kernel: GDT-HA: Storage RAID Controller Driver. Version: 3.04 
Jun 17 12:07:49 orclex kernel: GDT-HA: Found 0 PCI Storage RAID Controllers
Jun 17 12:07:49 orclex kernel: libata version 1.10 loaded.
Jun 17 12:07:49 orclex kernel: ahci version 1.00
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
Jun 17 12:07:49 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:07:49 orclex kernel: 
Jun 17 12:07:49 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:07:49 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:07:49 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:07:49 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:07:49 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:07:49 orclex kernel: handlers:
Jun 17 12:07:49 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:07:49 orclex kernel: Disabling IRQ #18
Jun 17 12:07:49 orclex kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Jun 17 12:07:49 orclex kernel: ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
Jun 17 12:07:49 orclex kernel: ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part 
Jun 17 12:07:49 orclex kernel: ata1: SATA max UDMA/133 cmd 0xFFFFC20000026D00 ctl 0x0 bmdma 0x0 irq 19
Jun 17 12:07:49 orclex kernel: ata2: SATA max UDMA/133 cmd 0xFFFFC20000026D80 ctl 0x0 bmdma 0x0 irq 19
Jun 17 12:07:49 orclex kernel: ata3: SATA max UDMA/133 cmd 0xFFFFC20000026E00 ctl 0x0 bmdma 0x0 irq 19
Jun 17 12:07:49 orclex kernel: ata4: SATA max UDMA/133 cmd 0xFFFFC20000026E80 ctl 0x0 bmdma 0x0 irq 19
Jun 17 12:07:49 orclex kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
Jun 17 12:07:49 orclex kernel: ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
Jun 17 12:07:49 orclex kernel: ata1: dev 0 configured for UDMA/133
Jun 17 12:07:49 orclex kernel: scsi0 : ahci
Jun 17 12:07:49 orclex kernel: ata2: no device found (phy stat 00000000)
Jun 17 12:07:49 orclex kernel: scsi1 : ahci
Jun 17 12:07:49 orclex kernel: ata3: no device found (phy stat 00000000)
Jun 17 12:07:49 orclex kernel: scsi2 : ahci
Jun 17 12:07:49 orclex kernel: ata4: no device found (phy stat 00000000)
Jun 17 12:07:49 orclex kernel: scsi3 : ahci
Jun 17 12:07:49 orclex kernel: Vendor: ATA       Model: ST3250823AS       Rev: 3.02
Jun 17 12:07:49 orclex kernel: Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 17 12:07:49 orclex kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Jun 17 12:07:49 orclex kernel: SCSI device sda: drive cache: write back
Jun 17 12:07:49 orclex kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Jun 17 12:07:49 orclex kernel: SCSI device sda: drive cache: write back
Jun 17 12:07:49 orclex kernel: sda: sda1 sda2 < sda5 > sda3
Jun 17 12:07:49 orclex kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jun 17 12:07:49 orclex kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Jun 17 12:07:49 orclex kernel: ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 21
Jun 17 12:07:49 orclex kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[cfefb800-cfefbfff]  Max Packet=[4096]
Jun 17 12:07:49 orclex kernel: ieee1394: raw1394: /dev/raw1394 device initialized
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
Jun 17 12:07:49 orclex kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
Jun 17 12:07:49 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Jun 17 12:07:49 orclex kernel: ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xcfdff800
Jun 17 12:07:49 orclex kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Jun 17 12:07:49 orclex kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Jun 17 12:07:49 orclex kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Jun 17 12:07:49 orclex kernel: hub 1-0:1.0: USB hub found
Jun 17 12:07:49 orclex kernel: hub 1-0:1.0: 8 ports detected
Jun 17 12:07:49 orclex kernel: ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Jun 17 12:07:49 orclex kernel: USB Universal Host Controller Interface driver v2.2
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
Jun 17 12:07:49 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.0: irq 23, io base 0x4400
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Jun 17 12:07:49 orclex kernel: hub 2-0:1.0: USB hub found
Jun 17 12:07:49 orclex kernel: hub 2-0:1.0: 2 ports detected
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
Jun 17 12:07:49 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0x4800
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Jun 17 12:07:49 orclex kernel: hub 3-0:1.0: USB hub found
Jun 17 12:07:49 orclex kernel: hub 3-0:1.0: 2 ports detected
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
Jun 17 12:07:49 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0x5000
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Jun 17 12:07:49 orclex kernel: hub 4-0:1.0: USB hub found
Jun 17 12:07:49 orclex kernel: hub 4-0:1.0: 2 ports detected
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.3: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
Jun 17 12:07:49 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.3: irq 16, io base 0x5400
Jun 17 12:07:49 orclex kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Jun 17 12:07:49 orclex kernel: hub 5-0:1.0: USB hub found
Jun 17 12:07:49 orclex kernel: hub 5-0:1.0: 2 ports detected
Jun 17 12:07:49 orclex kernel: Initializing USB Mass Storage driver...
Jun 17 12:07:49 orclex kernel: usb 2-1: new low speed USB device using uhci_hcd and address 2
Jun 17 12:07:49 orclex kernel: usbcore: registered new driver usb-storage
Jun 17 12:07:49 orclex kernel: USB Mass Storage support registered.
Jun 17 12:07:49 orclex kernel: usb 3-1: new low speed USB device using uhci_hcd and address 2
Jun 17 12:07:49 orclex kernel: usbcore: registered new driver hiddev
Jun 17 12:07:49 orclex kernel: input: USB HID v1.00 Joystick [Microsoft Microsoft SideWinder game controller] on usb-0000:00:1d.0-1
Jun 17 12:07:49 orclex kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800007ef52b]
Jun 17 12:07:49 orclex kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse Optical®] on usb-0000:00:1d.1-1
Jun 17 12:07:49 orclex kernel: usbcore: registered new driver usbhid
Jun 17 12:07:49 orclex kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jun 17 12:07:49 orclex kernel: mice: PS/2 mouse device common for all mice
Jun 17 12:07:49 orclex kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jun 17 12:07:49 orclex kernel: input: PC Speaker
Jun 17 12:07:49 orclex kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Jun 17 12:07:49 orclex kernel: GACT probability on
Jun 17 12:07:49 orclex kernel: Mirror/redirect action on
Jun 17 12:07:49 orclex kernel: u32 classifier
Jun 17 12:07:49 orclex kernel: Perfomance counters on
Jun 17 12:07:49 orclex kernel: input device check on 
Jun 17 12:07:49 orclex kernel: Actions configured 
Jun 17 12:07:49 orclex kernel: NET: Registered protocol family 2
Jun 17 12:07:49 orclex kernel: IP: routing cache hash table of 4096 buckets, 64Kbytes
Jun 17 12:07:49 orclex kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jun 17 12:07:49 orclex kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jun 17 12:07:49 orclex kernel: TCP: Hash tables configured (established 262144 bind 65536)
Jun 17 12:07:49 orclex kernel: IPv4 over IPv4 tunneling driver
Jun 17 12:07:49 orclex kernel: ip_conntrack version 2.1 (4094 buckets, 32752 max) - 304 bytes per conntrack
Jun 17 12:07:49 orclex kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jun 17 12:07:49 orclex kernel: ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Jun 17 12:07:49 orclex kernel: Initializing IPsec netlink socket
Jun 17 12:07:49 orclex kernel: NET: Registered protocol family 1
Jun 17 12:07:49 orclex kernel: NET: Registered protocol family 17
Jun 17 12:07:49 orclex kernel: NET: Registered protocol family 15
Jun 17 12:07:49 orclex kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Jun 17 12:07:49 orclex kernel: EXT3-fs: write access will be enabled during recovery.
Jun 17 12:07:49 orclex kernel: kjournald starting.  Commit interval 5 seconds
Jun 17 12:07:49 orclex kernel: EXT3-fs: recovery complete.
Jun 17 12:07:49 orclex kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun 17 12:07:49 orclex kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jun 17 12:07:49 orclex kernel: Freeing unused kernel memory: 224k freed
Jun 17 12:07:49 orclex kernel: Adding 2658716k swap on /dev/sda5.  Priority:-1 extents:1
Jun 17 12:07:49 orclex kernel: EXT3 FS on sda3, internal journal
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 21 (level, low) -> IRQ 21
Jun 17 12:07:49 orclex kernel: hda: dma_timer_expiry: dma status == 0x24
Jun 17 12:07:49 orclex kernel: hda: DMA interrupt recovery
Jun 17 12:07:49 orclex kernel: hda: lost interrupt
Jun 17 12:07:49 orclex kernel: kjournald starting.  Commit interval 5 seconds
Jun 17 12:07:49 orclex kernel: EXT3 FS on sda1, internal journal
Jun 17 12:07:49 orclex kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun 17 12:07:49 orclex kernel: ACPI: PCI interrupt 0000:01:09.1[A] -> GSI 17 (level, low) -> IRQ 17
Jun 17 12:07:49 orclex kernel: parport: PnPBIOS parport detected.
Jun 17 12:07:49 orclex kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
Jun 17 12:07:49 orclex kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Jun 17 12:07:49 orclex kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 17 12:07:49 orclex kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 17 12:07:49 orclex kernel: eth0: network connection up using port A
Jun 17 12:07:49 orclex kernel: speed:           100
Jun 17 12:07:49 orclex kernel: autonegotiation: yes
Jun 17 12:07:49 orclex kernel: duplex mode:     full
Jun 17 12:07:49 orclex kernel: flowctrl:        none
Jun 17 12:07:49 orclex kernel: irq moderation:  disabled
Jun 17 12:07:49 orclex kernel: scatter-gather:  enabled
Jun 17 12:07:50 orclex cpufreqd: libsys_init() - no batteries found, not a laptop?
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:52 orclex kernel: hdb: packet command error: status=0xd0 { Busy }
Jun 17 12:07:52 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:07:52 orclex kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Jun 17 12:07:52 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:07:52 orclex kernel: hdb: drive not ready for command
Jun 17 12:07:53 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:07:53 orclex kernel: 
Jun 17 12:07:53 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:07:53 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:07:53 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:07:53 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:07:53 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:07:53 orclex kernel: handlers:
Jun 17 12:07:53 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:07:53 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:07:53 orclex kernel: Disabling IRQ #18
Jun 17 12:07:57 orclex kernel: hdb: status timeout: status=0xd0 { Busy }
Jun 17 12:07:57 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:07:57 orclex kernel: hdb: drive not ready for command
Jun 17 12:07:57 orclex kernel: hdb: ATAPI reset complete
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:07:57 orclex kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Jun 17 12:07:57 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:07:57 orclex kernel: hdb: drive not ready for command
Jun 17 12:07:57 orclex kernel: cdrom: This disc doesn't have any tracks I recognize!
Jun 17 12:07:57 orclex kernel: lp0: using parport0 (interrupt-driven).
Jun 17 12:07:57 orclex udev[4280]: creating device node '/dev/lp0'
Jun 17 12:07:58 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:07:58 orclex kernel: 
Jun 17 12:07:58 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:07:58 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:07:58 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:07:58 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:07:58 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:07:58 orclex kernel: handlers:
Jun 17 12:07:58 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:07:58 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:07:58 orclex kernel: Disabling IRQ #18
Jun 17 12:07:58 orclex /usr/sbin/gpm[4244]: Detected EXPS/2 protocol mouse.
Jun 17 12:08:57 orclex kernel: hdb: irq timeout: status=0xd0 { Busy }
Jun 17 12:08:57 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:08:57 orclex kernel: hdb: ATAPI reset complete
Jun 17 12:08:57 orclex kernel: hdb: packet command error: status=0xd0 { Busy }
Jun 17 12:08:57 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Jun 17 12:08:58 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:08:58 orclex kernel: hdb: drive not ready for command
Jun 17 12:08:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:08:58 orclex kernel: scsi: unknown opcode 0x85
Jun 17 12:08:58 orclex lpd[4318]: restarted
Jun 17 12:08:58 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:08:58 orclex kernel: 
Jun 17 12:08:58 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:08:58 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:08:58 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:08:58 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:08:58 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:08:58 orclex kernel: handlers:
Jun 17 12:08:58 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:08:58 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:08:58 orclex kernel: Disabling IRQ #18
Jun 17 12:08:58 orclex nmbd[4328]: [2005/06/17 12:08:58, 0, pid=4328] nmbd/asyncdns.c:start_async_dns(149)
Jun 17 12:08:58 orclex nmbd[4328]:   started asyncdns process 4329
Jun 17 12:09:00 orclex Xprt_64: No matching visual for __GLcontextMode with visual class = 0 (32775), nplanes = 8
Jun 17 12:09:01 orclex rpc.statd[4455]: Version 1.0.7 Starting
Jun 17 12:09:01 orclex rpc.statd[4455]: statd running as root. chown /var/lib/nfs/sm to choose different user
Jun 17 12:09:01 orclex anacron[4461]: Anacron 2.3 started on 2005-06-17
Jun 17 12:09:01 orclex anacron[4461]: Normal exit (0 jobs run)
Jun 17 12:09:01 orclex /usr/sbin/cron[4466]: (CRON) INFO (pidfile fd = 3)
Jun 17 12:09:01 orclex /usr/sbin/cron[4467]: (CRON) STARTUP (fork ok)
Jun 17 12:09:01 orclex /usr/sbin/cron[4467]: (CRON) INFO (Running @reboot jobs)
Jun 17 12:09:03 orclex udev[4489]: creating device node '/dev/vcsa2'
Jun 17 12:09:03 orclex udev[4491]: creating device node '/dev/vcs3'
Jun 17 12:09:03 orclex udev[4493]: creating device node '/dev/vcsa3'
Jun 17 12:09:03 orclex udev[4495]: creating device node '/dev/vcs4'
Jun 17 12:09:03 orclex udev[4497]: creating device node '/dev/vcsa4'
Jun 17 12:09:03 orclex udev[4487]: creating device node '/dev/vcs2'
Jun 17 12:09:03 orclex udev[4532]: creating device node '/dev/vcsa7'
Jun 17 12:09:03 orclex udev[4531]: creating device node '/dev/vcs7'
Jun 17 12:09:03 orclex udev[4552]: removing device node '/dev/vcs4'
Jun 17 12:09:03 orclex udev[4553]: removing device node '/dev/vcsa2'
Jun 17 12:09:03 orclex udev[4556]: removing device node '/dev/vcs3'
Jun 17 12:09:03 orclex udev[4557]: removing device node '/dev/vcsa4'
Jun 17 12:09:03 orclex udev[4499]: creating device node '/dev/vcs5'
Jun 17 12:09:03 orclex udev[4501]: creating device node '/dev/vcsa5'
Jun 17 12:09:03 orclex udev[4506]: creating device node '/dev/vcs6'
Jun 17 12:09:03 orclex udev[4530]: creating device node '/dev/vcsa6'
Jun 17 12:09:04 orclex kernel: nvidia: module license 'NVIDIA' taints kernel.
Jun 17 12:09:04 orclex kernel: ACPI: PCI interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun 17 12:09:04 orclex kernel: PCI: Setting latency timer of device 0000:04:00.0 to 64
Jun 17 12:09:04 orclex kernel: NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7174  Tue Mar 22 06:45:40 PST 2005
Jun 17 12:09:25 orclex gdm[4485]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jun 17 12:09:49 orclex gdm[4611]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jun 17 12:09:58 orclex kernel: hdb: irq timeout: status=0xd0 { Busy }
Jun 17 12:09:58 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:09:58 orclex kernel: hdb: ATAPI reset complete
Jun 17 12:09:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:09:58 orclex hddtemp[4309]: /dev/hda: IC35L060AVV207-0: 36 C
Jun 17 12:09:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:09:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:09:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:09:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:09:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:09:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:09:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:09:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:09:58 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:09:58 orclex udev[4715]: removing device node '/dev/vcs6'
Jun 17 12:09:58 orclex udev[4717]: removing device node '/dev/vcsa5'
Jun 17 12:09:58 orclex udev[4720]: removing device node '/dev/vcsa3'
Jun 17 12:09:58 orclex udev[4726]: removing device node '/dev/vcsa7'
Jun 17 12:09:58 orclex udev[4744]: creating device node '/dev/vcs3'
Jun 17 12:09:58 orclex udev[4756]: removing device node '/dev/vcsa6'
Jun 17 12:09:58 orclex udev[4757]: removing device node '/dev/vcs2'
Jun 17 12:09:58 orclex udev[4772]: creating device node '/dev/vcsa2'
Jun 17 12:09:58 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:09:58 orclex kernel: 
Jun 17 12:09:58 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:09:58 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:09:58 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> 
Jun 17 12:09:58 orclex kernel: handlers:
Jun 17 12:09:58 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:09:58 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:09:58 orclex kernel: Disabling IRQ #18
Jun 17 12:09:58 orclex udev[4773]: creating device node '/dev/vcs4'
Jun 17 12:09:58 orclex udev[4788]: removing device node '/dev/vcs5'
Jun 17 12:09:58 orclex udev[4796]: creating device node '/dev/vcs6'
Jun 17 12:09:58 orclex udev[4807]: creating device node '/dev/vcs2'
Jun 17 12:09:58 orclex udev[4790]: creating device node '/dev/vcsa5'
Jun 17 12:09:58 orclex udev[4828]: creating device node '/dev/vcsa7'
Jun 17 12:09:58 orclex udev[4795]: removing device node '/dev/vcs7'
Jun 17 12:09:59 orclex udev[4816]: creating device node '/dev/vcsa3'
Jun 17 12:09:59 orclex udev[4850]: creating device node '/dev/vcs5'
Jun 17 12:09:59 orclex udev[4819]: creating device node '/dev/vcsa4'
Jun 17 12:09:59 orclex udev[4827]: creating device node '/dev/vcsa6'
Jun 17 12:09:59 orclex udev[4881]: creating device node '/dev/nvidia0'
Jun 17 12:09:59 orclex udev[4880]: creating device node '/dev/nvidiactl'
Jun 17 12:09:59 orclex udev[4889]: removing device node '/dev/vcsa7'
Jun 17 12:09:59 orclex udev[4890]: creating device node '/dev/vcs7'
Jun 17 12:10:00 orclex udev[4922]: removing device node '/dev/vcs7'
Jun 17 12:10:00 orclex udev[4929]: creating device node '/dev/vcsa7'
Jun 17 12:10:00 orclex udev[4937]: creating device node '/dev/vcs7'
Jun 17 12:10:00 orclex udev[4944]: removing device node '/dev/vcsa7'
Jun 17 12:10:00 orclex udev[4955]: removing device node '/dev/vcs7'
Jun 17 12:10:00 orclex udev[4957]: creating device node '/dev/vcsa7'
Jun 17 12:10:00 orclex udev[4966]: creating device node '/dev/vcs7'
Jun 17 12:10:18 orclex (alex-5133): starting (version 2.8.1), pid 5133 user 'alex'
Jun 17 12:10:18 orclex (alex-5133): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Jun 17 12:10:18 orclex (alex-5133): Resolved address "xml:readwrite:/home/alex/.gconf" to a writable configuration source at position 1
Jun 17 12:10:18 orclex (alex-5133): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 2
Jun 17 12:11:00 orclex kernel: hdb: lost interrupt
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:11:01 orclex udev[5231]: removing device node '/dev/vcs7'
Jun 17 12:11:01 orclex udev[5240]: removing device node '/dev/vcsa7'
Jun 17 12:11:01 orclex udev[5242]: creating device node '/dev/vcs7'
Jun 17 12:11:01 orclex udev[5255]: removing device node '/dev/vcs7'
Jun 17 12:11:01 orclex udev[5263]: creating device node '/dev/vcsa7'
Jun 17 12:11:01 orclex udev[5272]: creating device node '/dev/vcs7'
Jun 17 12:11:01 orclex udev[5274]: removing device node '/dev/vcsa7'
Jun 17 12:11:01 orclex udev[5287]: creating device node '/dev/vcsa7'
Jun 17 12:11:01 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:11:01 orclex kernel: 
Jun 17 12:11:01 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:11:01 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:11:01 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010d296>{system_call+126} 
Jun 17 12:11:01 orclex kernel: 
Jun 17 12:11:01 orclex kernel: handlers:
Jun 17 12:11:01 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:11:01 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:11:01 orclex kernel: Disabling IRQ #18
Jun 17 12:12:02 orclex kernel: hdb: lost interrupt
Jun 17 12:12:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:12:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:12:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:12:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:12:02 orclex kernel: hdb: packet command error: status=0xd0 { Busy }
Jun 17 12:12:02 orclex kernel: ide: failed opcode was: unknown
Jun 17 12:12:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:12:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:12:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:12:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:12:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:12:02 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:12:04 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:12:04 orclex kernel: 
Jun 17 12:12:04 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:12:04 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:12:04 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:12:04 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:12:04 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:12:04 orclex kernel: handlers:
Jun 17 12:12:04 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:12:04 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:12:04 orclex kernel: Disabling IRQ #18
Jun 17 12:13:04 orclex kernel: hdb: lost interrupt
Jun 17 12:13:04 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:13:04 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:13:04 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:13:04 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:13:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:13:05 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:13:05 orclex kernel: cdrom: This disc doesn't have any tracks I recognize!
Jun 17 12:13:06 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:13:06 orclex kernel: 
Jun 17 12:13:06 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:13:06 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:13:06 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:13:06 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:13:06 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:13:06 orclex kernel: handlers:
Jun 17 12:13:06 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:13:06 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:13:06 orclex kernel: Disabling IRQ #18
Jun 17 12:14:05 orclex kernel: ide-cd: cmd 0x28 timed out
Jun 17 12:14:05 orclex kernel: hdb: lost interrupt
Jun 17 12:14:05 orclex kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Jun 17 12:14:06 orclex kernel: ISO 9660 Extensions: RRIP_1991A
Jun 17 12:14:07 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:14:07 orclex kernel: 
Jun 17 12:14:07 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:14:07 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:14:07 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:14:07 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:14:07 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:14:07 orclex kernel: handlers:
Jun 17 12:14:07 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:14:07 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:14:07 orclex kernel: Disabling IRQ #18
Jun 17 12:15:08 orclex kernel: hdb: lost interrupt
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: VFS: busy inodes on changed media.
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:08 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:15:09 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:15:09 orclex kernel: 
Jun 17 12:15:09 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:15:09 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:15:09 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:15:09 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:15:09 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:15:09 orclex kernel: handlers:
Jun 17 12:15:09 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:15:09 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:15:09 orclex kernel: Disabling IRQ #18
Jun 17 12:16:10 orclex kernel: hdb: lost interrupt
Jun 17 12:16:10 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:16:10 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:16:10 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:16:10 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:16:10 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:16:10 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:16:10 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:16:10 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:16:10 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:16:10 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:16:11 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:16:11 orclex kernel: 
Jun 17 12:16:11 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:16:11 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:16:11 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:16:11 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:16:11 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:16:11 orclex kernel: handlers:
Jun 17 12:16:11 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:16:11 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:16:11 orclex kernel: Disabling IRQ #18
Jun 17 12:17:01 orclex /USR/SBIN/CRON[5461]: (root) CMD (   run-parts --report /etc/cron.hourly)
Jun 17 12:17:12 orclex kernel: hdb: lost interrupt
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:12 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jun 17 12:17:13 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
Jun 17 12:17:13 orclex kernel: 
Jun 17 12:17:13 orclex kernel: Call Trace:<IRQ> <ffffffff801502bf>{__report_bad_irq+48} <ffffffff801503b8>{note_interrupt+144} 
Jun 17 12:17:13 orclex kernel: <ffffffff8014fbe1>{__do_IRQ+263} <ffffffff80110105>{do_IRQ+71} 
Jun 17 12:17:13 orclex kernel: <ffffffff8010d83d>{ret_from_intr+0}  <EOI> <ffffffff8010b588>{mwait_idle+94} 
Jun 17 12:17:13 orclex kernel: <ffffffff8010b50c>{cpu_idle+57} <ffffffff8065886d>{start_kernel+425} 
Jun 17 12:17:13 orclex kernel: <ffffffff80658258>{x86_64_start_kernel+364} 
Jun 17 12:17:13 orclex kernel: handlers:
Jun 17 12:17:13 orclex kernel: [<ffffffff80303695>] (ide_intr+0x0/0x195)
Jun 17 12:17:13 orclex kernel: [<ffffffff80350202>] (usb_hcd_irq+0x0/0x68)
Jun 17 12:17:13 orclex kernel: Disabling IRQ #18

--------------070202080300090808000609--
