Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWATXPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWATXPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWATXPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:15:52 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:22651 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751185AbWATXPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:15:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=lkqdFbtVf/QKPAVkaeVKhDxDk9j0sBINTdWaxg2GIVBbwE4uXFGa9u+Ey5ZBcmC+uM7eGBM9BXn0vvuB/e/0lh/rfU/+fJc0f4qXT+RXF1z9sM7ANy0zBK30mwXy0r+Ah/1/4NnzaUmDeCnOhzt4aECA5FBbKw4rTy8yhbKe7pU=
Message-ID: <6e6e20a10601201515k73fe1f03r7ce8b32c6dd5f66a@mail.gmail.com>
Date: Sat, 21 Jan 2006 00:15:50 +0100
From: =?ISO-8859-1?Q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 3COM 3C940, does not work anymore after upgrade to 2.6.15
In-Reply-To: <6e6e20a10601170038l2a1641edjdc8466093eec423a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13873_19628187.1137798950216"
References: <6e6e20a10601160751v362d2312v6c99fa8db64ce7e1@mail.gmail.com>
	 <20060116100156.0a273b54@dxpl.pdx.osdl.net>
	 <6e6e20a10601170038l2a1641edjdc8466093eec423a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_13873_19628187.1137798950216
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 1/17/06, Bj=F6rn Nilsson <bni.swe@gmail.com> wrote:
> On 1/16/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> > On Mon, 16 Jan 2006 16:51:22 +0100
> > Bj=F6rn Nilsson <bni.swe@gmail.com> wrote:
> >
> > > Hi,
> > >
> > > I have a problem with the network card attached to my motherboard
> > > after doing an upgrade of the kernel from 2.6.11 to 2.6.15.
> > >
> > > The Motherboard is an ASUS P4P800, and the network card is 3COM 3C940
> > > and is afaik a variant of SysKonnect SK-98xx.
> > >
> > > It worked with 2.6.15 until I shut the system down and started it up
> > > again for the first time with 2.6.15 running, and now the card does
> > > not work anymore. The driver is loaded, and it detects that the cable
> > > is plugged in and the interface is brought up (so says dmesg). The
> > > green led on the card is now turned off, it used to be on before.
> > >
> > > I have tried to reinstall the system from scratch (Using Debian 3.1
> > > installer cd), and to my astonishment the card is not working like it
> > > used to.
> > >
> > > It seems like 2.6.15 set the card in some state so it does not work
> > > anymore. Is this even possible? I have tried power cycling, even
> > > disconnected the power coord from the computer.
> > >
> > > When i used 2.6.11 I was using the sk98lin driver, when upgrading it
> > > is possible the newer skge driver was used, however I am not sure.
> > >
> > > Debian installer 3.1 uses 2.6.8 kernel with sk98lin driver.
> > >
> > > I have found others with the same/similar problem:
> > > http://bugs.gentoo.org/show_bug.cgi?id=3D100258
> > > http://marc.theaimsgroup.com/?l=3Dlinux-netdev&m=3D112268414417743&w=
=3D2
> > >
> > > But for me the card does not work even with 2.6.15. I dont have
> > > Wind*ws to test with, so I cant test the solution in one of the above
> > > emails.
> > >
> > > If the driver in 2.6.15 breaks cards of this type it is qiute a
> > > serious bug I think. Anyone have any suggestions as to how I can try
> > > to fix this? Reset the card in some way maybe?
> > >
> > > Please CC me.
> > >
> > > Regards
> > > /Bj=F6rn
> >
> > Pleas send me some more info.
> > * console output (dmesg)
> > * lspci -v
> > * which modules are loaded (lsmod)
> >
> >
> > --
> > Stephen Hemminger <shemminger@osdl.org>
> > OSDL http://developer.osdl.org/~shemminger
> >
>
> I am currently travelling and dont have access to the machine right
> now, but I will post this info later in the week or this weekend.
>

Hi,

After bying a new ethernet card and using that as my internet-facing
interface, and setting my onboard SK-98xx to face my local lan, the
SK-98xx interface works again.

Im now using 2.6.15

However when running the Debian installer  with the included 2.6.8
kernel the interface does not seem to work. It seems I am in the same
situation as the user in my previous link, the card doesnt work with
older kernels anymore.

Including the requested info as attachments.

Regards
/Bj=F6rn

------=_Part_13873_19628187.1137798950216
Content-Type: text/plain; name=dmesg; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg"

Linux version 2.6.15-1-686-smp (Debian 2.6.15-3) (horms@verge.net.au) (gcc version 4.0.3 20060115 (prerelease) (Debian 4.0.2-7)) #1 SMP Wed Jan 18 15:26:19 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 261936
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32560 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9fb0
ACPI: RSDT (v001 A M I  OEMRSDT  0x04000322 MSFT 0x00000097) @ 0x3ff30000
ACPI: FADT (v002 A M I  OEMFACP  0x04000322 MSFT 0x00000097) @ 0x3ff30200
ACPI: MADT (v001 A M I  OEMAPIC  0x04000322 MSFT 0x00000097) @ 0x3ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x04000322 MSFT 0x00000097) @ 0x3ff40040
ACPI: DSDT (v001  P4P81 P4P81053 0x00000053 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb80000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2399.404 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1030896k/1047744k available (1490k kernel code, 16188k reserved, 536k data, 176k init, 130240k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4800.99 BogoMIPS (lpj=2400498)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4797.07 BogoMIPS (lpj=2398539)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Total of 2 processors activated (9598.07 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 4405k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:08: ioport range 0x680-0x6ff has been reserved
pnp: 00:08: ioport range 0x290-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fe800000-fe8fffff
  PREFETCH window: b7f00000-d7efffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fe900000-feafffff
  PREFETCH window: d7f00000-f7efffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
audit: initializing netlink socket (disabled)
audit(1137798193.477:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
0000:00:1d.7 EHCI: early BIOS handoff failed (BIOS bug ?)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:04: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:05: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI Shortcut mode
Freeing unused kernel memory: 176k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 169, io base 0x0000ef00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 177, io base 0x0000ef20
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 185, io base 0x0000ef40
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 169, io base 0x0000ef80
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 193, io mem 0xfebffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 201
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
skge 1.3 addr 0xfeafc000 irq 201 chip Yukon rev 1
skge eth0: addr 00:0c:6e:50:8c:1a
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 201
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:0a.0: 3Com PCI 3c905C Tornado at f8832c00. Vers LK1.1.19
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 193
eth2: Identified chip type is 'RTL8169s/8110s'.
eth2: RTL8169 at 0xf884c800, 00:13:46:39:dc:dd, IRQ 193
hda: ST340014A, ATA DISK drive
usb 1-1: device not accepting address 2, error -71
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
usb 5-3: new high speed USB device using ehci_hcd and address 4
hub 5-3:1.0: USB hub found
hub 5-3:1.0: 4 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 4
hdc: PHILIPS DVD+/-RW DVD8631, ATAPI CD/DVD-ROM drive
usb 1-2: new low speed USB device using uhci_hcd and address 5
usbcore: registered new driver hiddev
input: Razer Razer Diamonback Optical Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Razer Razer Diamonback Optical Mouse] on usb-0000:00:1d.0-1
input: Tangtop Generic USBPS2 as /class/input/input1
input: USB HID v1.00 Keyboard [Tangtop Generic USBPS2] on usb-0000:00:1d.0-2
input: Tangtop Generic USBPS2 as /class/input/input2
input: USB HID v1.00 Mouse [Tangtop Generic USBPS2] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: replayed 1 transactions in 0 seconds
ReiserFS: hda1: Using r5 hash to sort names
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Linux agpgart interface v0.101 (c) Dave Jones
Floppy drive(s): fd0 is 1.44M
hw_random hardware driver 1.0.0 loaded
FDC 0 is a post-1991 82077
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1f.5 to 64
Real Time Clock Driver v1.12
input: PC Speaker as /class/input/input3
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 51021 usecs
intel8x0: clocking to 48000
mice: PS/2 mouse device common for all mice
Adding 1389580k swap on /dev/hda9.  Priority:-1 extents:1 across:1389580k
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
ReiserFS: hda8: found reiserfs format "3.6" with standard journal
ReiserFS: hda8: using ordered data mode
ReiserFS: hda8: journal params: device hda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda8: checking transaction log (hda8)
ReiserFS: hda8: Using r5 hash to sort names
ReiserFS: hda8: warning: Created .reiserfs_priv on hda8 - reserved for xattr storage.
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
skge eth0: enabling interface
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 201
r8169: eth2: link up
skge eth0: Link is up at 100 Mbps, full duplex, flow control tx and rx
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8185 buckets, 65480 max) - 232 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
eth2: no IPv6 routers present
eth0: no IPv6 routers present
eth1: no IPv6 routers present
[drm] Initialized drm 1.0.0 20040925
PCI: Enabling device 0000:02:09.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 21 (level, low) -> IRQ 217
[drm] Initialized radeon 1.19.0 20050911 on minor 0: 
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[drm] Initialized radeon 1.19.0 20050911 on minor 1: 
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode


------=_Part_13873_19628187.1137798950216
Content-Type: text/plain; name=lsmod; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lsmod"

Module                  Size  Used by
radeon                 97216  1 
drm                    66164  2 radeon
ipt_MASQUERADE          3648  1 
iptable_nat             7268  1 
ip_nat                 18124  2 ipt_MASQUERADE,iptable_nat
ipt_state               1952  34 
iptable_filter          2944  1 
ip_tables              18976  4 ipt_MASQUERADE,iptable_nat,ipt_state,iptable_filter
ip_conntrack_ftp        7856  0 
ip_conntrack           51064  5 ipt_MASQUERADE,iptable_nat,ip_nat,ipt_state,ip_conntrack_ftp
nfnetlink               6296  2 ip_nat,ip_conntrack
ipv6                  233024  12 
sk98lin               142816  0 
joydev                  9088  0 
evdev                   9056  0 
mousedev               11012  1 
pcspkr                  2148  0 
rtc                    12532  0 
psmouse                32772  0 
serio_raw               6980  0 
snd_intel8x0           30332  0 
i2c_i801                8204  0 
intel_agp              21052  1 
snd_ac97_codec         82912  1 snd_intel8x0
snd_ac97_bus            2272  1 snd_ac97_codec
hw_random               5268  0 
floppy                 56036  0 
agpgart                32076  2 drm,intel_agp
i2c_core               19840  1 i2c_i801
shpchp                 40576  0 
pci_hotplug            25628  1 shpchp
snd_pcm                80356  2 snd_intel8x0,snd_ac97_codec
snd_timer              22692  1 snd_pcm
snd                    50852  4 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               9440  1 snd
snd_page_alloc         10184  2 snd_intel8x0,snd_pcm
parport_pc             32932  0 
parport                32840  1 parport_pc
reiserfs              226992  5 
ide_cd                 37252  0 
cdrom                  33632  1 ide_cd
ide_disk               16032  7 
ide_generic             1344  0 [permanent]
usbhid                 33152  0 
piix                    9540  0 [permanent]
r8169                  26664  0 
3c59x                  40872  0 
mii                     5280  1 3c59x
skge                   34768  0 
ehci_hcd               30120  0 
generic                 4516  0 [permanent]
ide_core              115664  5 ide_cd,ide_disk,ide_generic,piix,generic
uhci_hcd               29360  0 
usbcore               116196  4 usbhid,ehci_hcd,uhci_hcd
thermal                13736  0 
processor              23912  1 thermal
fan                     4804  0 

------=_Part_13873_19628187.1137798950216
Content-Type: text/plain; name=lspci; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci"

0000:00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Flags: bus master, fast devsel, latency 0
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe800000-fe8fffff
	Prefetchable memory behind bridge: b7f00000-d7efffff

0000:00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at ef00 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Flags: bus master, medium devsel, latency 0, IRQ 177
	I/O ports at ef20 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Flags: bus master, medium devsel, latency 0, IRQ 185
	I/O ports at ef40 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at ef80 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Flags: bus master, medium devsel, latency 0, IRQ 193
	Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe900000-feafffff
	Prefetchable memory behind bridge: d7f00000-f7efffff

0000:00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
	Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Flags: bus master, medium devsel, latency 0, IRQ 185
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at fc00 [size=16]
	Memory at 50000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Flags: medium devsel, IRQ 11
	I/O ports at 0400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Flags: bus master, medium devsel, latency 0, IRQ 209
	I/O ports at e800 [size=256]
	I/O ports at ee80 [size=64]
	Memory at febff800 (32-bit, non-prefetchable) [size=512]
	Memory at febff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc. ASUS Radeon 9200 SE / TD / 128M
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 169
	Memory at c8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at c000 [size=256]
	Memory at fe8f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at fe8c0000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
	Subsystem: ASUSTeK Computer Inc.: Unknown device c007
	Flags: bus master, 66MHz, medium devsel, latency 64
	Memory at c0000000 (32-bit, prefetchable) [size=128M]
	Memory at fe8e0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:02:05.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
	Subsystem: ASUSTeK Computer Inc. P4P800/K8V Deluxe motherboard
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 201
	Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
	I/O ports at d800 [size=256]
	Capabilities: <available only to root>

0000:02:09.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01) (prog-if 00 [VGA])
	Subsystem: Hightech Information System Ltd. Excalibur Radeon 9200
	Flags: medium devsel, IRQ 217
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at d000 [size=256]
	Memory at fead0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d7f00000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:09.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] (Secondary) (rev 01)
	Subsystem: Hightech Information System Ltd. Excalibur Radeon 9200
	Flags: bus master, medium devsel, latency 64
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Memory at feae0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:02:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Flags: bus master, medium devsel, latency 64, IRQ 201
	I/O ports at dc00 [size=128]
	Memory at feafbc00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at d7f20000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:0b.0 Ethernet controller: D-Link System Inc DGE-528T Gigabit Ethernet Adapter (rev 10)
	Subsystem: D-Link System Inc DGE-528T Gigabit Ethernet Adapter
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 193
	I/O ports at de00 [size=256]
	Memory at feafb800 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at d7f40000 [disabled] [size=128K]
	Capabilities: <available only to root>


------=_Part_13873_19628187.1137798950216--
