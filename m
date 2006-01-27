Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWA0Qco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWA0Qco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 11:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWA0Qcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 11:32:43 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:21568 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751506AbWA0Qcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 11:32:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=s97+aDpXExLnLEgezb31HPMm2TaKJP7LNLhQBdzTfKhCpJiu6lfRuqE0tYV2AOlfO1jV2lI1a7h2rLHtXzeXw4WFq+AZ8AzJBHD9/DAJzpYNsGcg5+0mWU3SnZQDnz10Jg8TrxXr2X62qVSZBeZ2zmpvQzEhhw+r2ju+FXGYXoA=
Message-ID: <cfb54190601270832x29681873i624818603d5db26e@mail.gmail.com>
Date: Fri, 27 Jan 2006 18:32:40 +0200
From: Hai Zaar <haizaar@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: vesa fb is slow on 2.6.15.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43D9B77E.6080003@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1954_20337433.1138379560679"
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>
	 <43D8E1EE.3040302@gmail.com>
	 <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>
	 <43D94764.3040303@gmail.com>
	 <cfb54190601261610o1479b8fdsbedb0ca96b14b6@mail.gmail.com>
	 <43D9B77E.6080003@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1954_20337433.1138379560679
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> >
> > But anyway, do you have a clue why do I still get this error?
> > PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:40:00.0
> > I've several workstations with _exactly_ the same hardware. I've tried
> > two of them - both give the error with 2.6.15.1 (and no errors with
> > 2.6.11.12).
>
> Can you post the entire dmesg?
>
> Tony
>

Attached.

Thanks.
--
Zaar

------=_Part_1954_20337433.1138379560679
Content-Type: text/x-log; name=dmesg.log; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dmesg.log"

Linux version 2.6.15.1 (root@localhost) (gcc version 3.4.3) #1 SMP PREEMPT =
Fri Jan 27 13:26:34 IST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfff5000 (usable)
 BIOS-e820: 00000000dfff5000 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
2687MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f9bf0
On node 0 totalpages: 917493
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 688117 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v002 COMPAQ                                ) @ 0x000e8e10
ACPI: XSDT (v001 COMPAQ CPQ0063  0x20050602  0x00000000) @ 0xdfff50ec
ACPI: FADT (v003 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0xdfff52ac
ACPI: SSDT (v001 COMPAQ  PROJECT 0x00000001 MSFT 0x0100000e) @ 0xdfff657a
ACPI: MADT (v001 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0xdfff53b8
ACPI: ASF! (v032 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0xdfff543c
ACPI: MCFG (v001 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0xdfff54a6
ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
Built 1 zonelists
Kernel command line: quiet selinux=3D0 vga=3D795 video=3Dvesafb:mtrr:3,ywra=
p
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3601.544 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3624808k/3669972k available (1949k kernel code, 43888k reserved, 58=
8k data, 208k init, 2752468k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok=
.
Calibrating delay using timer specific routine.. 7206.77 BogoMIPS (lpj=3D36=
03389)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000=
659d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 00006=
59d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000659d 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 7199.36 BogoMIPS (lpj=3D35=
99683)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000=
659d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 00006=
59d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000659d 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
Booting processor 2/6 eip 3000
Initializing CPU#2
Calibrating delay using timer specific routine.. 7199.34 BogoMIPS (lpj=3D35=
99673)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000=
659d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 00006=
59d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000659d 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
Booting processor 3/7 eip 3000
Initializing CPU#3
Calibrating delay using timer specific routine.. 7199.38 BogoMIPS (lpj=3D35=
99694)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000=
659d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 00006=
59d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000659d 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
Total of 4 processors activated (28804.87 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 7166k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.20 entry at 0xeb5df, last bus=3D64
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region f800-f87f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region fa00-fa3f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:40:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPA_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPB_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPA1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
pnp: 00:0a: ioport range 0xcb0-0xcbf has been reserved
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x400-0x41f has been reserved
pnp: 00:0b: ioport range 0x420-0x43f has been reserved
pnp: 00:0b: ioport range 0x440-0x45f has been reserved
pnp: 00:0b: ioport range 0x460-0x47f could not be reserved
pnp: 00:0b: ioport range 0x480-0x48f has been reserved
pnp: 00:0b: ioport range 0xf800-0xf81f could not be reserved
pnp: 00:0b: ioport range 0xf820-0xf83f has been reserved
pnp: 00:0b: ioport range 0xf840-0xf85f has been reserved
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: fa100000-fa1fffff
  PREFETCH window: e2000000-e20fffff
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: fa200000-fa2fffff
  PREFETCH window: disabled.
PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:40:00.0
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: f8000000-f9ffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: fa000000-fa0fffff
  PREFETCH window: e2100000-e21fffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:03.0 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1138378882.362:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[pcie00]
Allocate Port Service[pcie01]
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:03.0 to 64
Allocate Port Service[pcie00]
Allocate Port Service[pcie01]
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:04.0 to 64
Allocate Port Service[pcie00]
Allocate Port Service[pcie01]
vesafb: framebuffer at 0xf0000000, mapped to 0xf8880000, using 10240k, tota=
l 131072k
vesafb: mode is 1280x1024x32, linelength=3D5120, pages=3D0
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 177, io mem 0xfa300000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 169, io base 0x00004440
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 185, io base 0x00004460
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 193, io base 0x00004480
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 169, io base 0x000044a0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 4-1: new full speed USB device using uhci_hcd and address 2
hub 4-1:1.0: USB hub found
hub 4-1:1.0: 4 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI No-Shortcut mode
ACPI wakeup devices:=20
PCI0  XPA SLO4  XPB SLO2  HUB COM1 USB1 USB2 USB3 USB4 EUSB  NIC PBTN=20
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 208k freed
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x4810 ctl 0x482A bmdma 0x44F0 irq 193
ata2: SATA max UDMA/133 cmd 0x4818 ctl 0x482E bmdma 0x44F8 irq 193
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 193
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x44e0-0x44e7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x44e8-0x44ef, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Fusion MPT base driver 3.03.04
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.04
usb 4-1.1: new low speed USB device using uhci_hcd and address 3
ata1: dev 0 cfg 49:2f00 82:3069 83:7d01 84:4023 85:3069 86:3401 87:4023 88:=
203f
ata1: dev 0 ATA-7, max UDMA/100, 78165360 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: ST340014AS        Rev: 3.43
  Type:   Direct-Access                      ANSI SCSI revision: 05
input: Microsoft Natural Keyboard Pro as /class/input/input0
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on usb-0000:=
00:1d.2-1.1
input: Microsoft Natural Keyboard Pro as /class/input/input1
input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on usb-0000:00=
:1d.2-1.1
usb 4-1.2: new low speed USB device using uhci_hcd and address 4
Probing IDE interface ide1...
input: Microsoft Microsoft IntelliMouse=AE Explorer as /class/input/input2
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Explorer] o=
n usb-0000:00:1d.2-1.2
usbcore: registered new driver yealink
drivers/usb/input/yealink.c: Yealink phone driver:yld-20050816
hdc: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
hdd: Maxtor 2B020H1, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdd: max request size: 128KiB
hdd: 40020624 sectors (20490 MB) w/2048KiB Cache, CHS=3D39703/16/63, UDMA(1=
00)
hdd: cache flushes not supported
 hdd: hdd1
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 18 (level, low) -> IRQ 193
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities=3D{Initiator}
scsi2 : ioc0: LSI53C1030, FwRev=3D01032500h, Ports=3D1, MaxQ=3D222, IRQ=3D1=
93
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
EXT3 FS on hdd1, internal journal
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver

------=_Part_1954_20337433.1138379560679--
