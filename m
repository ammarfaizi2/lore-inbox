Return-Path: <linux-kernel-owner+w=401wt.eu-S1753460AbWLOVh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbWLOVh2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbWLOVh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:37:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461AbWLOVhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:37:24 -0500
Date: Fri, 15 Dec 2006 16:37:15 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18.5 usb/sysfs bug.
Message-ID: <20061215213715.GB15792@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061215175027.GA17987@redhat.com> <20061215175344.GA15871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215175344.GA15871@kroah.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 09:53:44AM -0800, Greg Kroah-Hartman wrote:
 > On Fri, Dec 15, 2006 at 12:50:27PM -0500, Dave Jones wrote:
 > > Happens during every boot, though bootup continues afterwards.
 > 
 > Can you enable CONFIG_USB_DEBUG and send the log info that happens right
 > before this oops?

Gah, and here it is, actually attached this time.

		Dave

Linux version 2.6.18-1.2864.fc6 (brewbuilder@hs20-bc2-4.build.redhat.com) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Fri Dec 15 13:14:58 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fe91400 (usable)
 BIOS-e820: 000000003fe91400 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 261777
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32401 pages, LIFO batch:7
DMI 2.4 present.
Using APIC driver default
ACPI: RSDP (v000 DELL                                  ) @ 0x000fc370
ACPI: RSDT (v001 DELL    M07     0x27d60317 ASL  0x00000061) @ 0x3fe91a11
ACPI: FADT (v001 DELL    M07     0x27d60317 ASL  0x00000061) @ 0x3fe92800
ACPI: MADT (v001 DELL    M07     0x27d60317 ASL  0x00000047) @ 0x3fe93000
ACPI: ASF! (v016 DELL    M07     0x27d60317 ASL  0x00000061) @ 0x3fe92c00
ACPI: MCFG (v016 DELL    M07     0x27d60317 ASL  0x00000061) @ 0x3fe92fc0
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x3fe91a8c
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 INTL 0x20050624) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:14 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Detected 2161.304 MHz processor.
Built 1 zonelists.  Total pages: 261777
Kernel command line: ro root=/dev/VolGroup00/LogVol00 profile=1 vga=791
kernel profiling enabled (shift: 1)
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c07b1000 soft=c0791000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1026368k/1047108k available (2147k kernel code, 19968k reserved, 870k data, 240k init, 129604k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4325.48 BogoMIPS (lpj=2162744)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfe9f3ff 00100000 00000000 00000940 0000c1a9 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
CPU0: Intel Genuine Intel(R) CPU           T2600  @ 2.16GHz stepping 08
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c07b2000 soft=c0792000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4321.95 BogoMIPS (lpj=2160979)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9f3ff 00100000 00000000 00000940 0000c1a9 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Genuine Intel(R) CPU           T2600  @ 2.16GHz stepping 08
Total of 2 processors activated (8647.44 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: 
CPU#0 had -991587 usecs TSC skew, fixed it up.
CPU#1 had 991587 usecs TSC skew, fixed it up.
Brought up 2 CPUs
sizeof(vma)=84 bytes
sizeof(page)=32 bytes
sizeof(inode)=424 bytes
sizeof(dentry)=148 bytes
sizeof(ext3inode)=600 bytes
sizeof(buffer_head)=52 bytes
sizeof(skbuff)=172 bytes
sizeof(task_struct)=1392 bytes
migration_cost=46
checking if image is initramfs... it is
Freeing initrd memory: 2268k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *3
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 11) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PXP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x1000-0x1005 could not be reserved
pnp: 00:02: ioport range 0x1008-0x100f could not be reserved
pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
pnp: 00:03: ioport range 0x1006-0x1007 has been reserved
pnp: 00:03: ioport range 0x100a-0x1059 could not be reserved
pnp: 00:03: ioport range 0x1060-0x107f has been reserved
pnp: 00:03: ioport range 0x1080-0x10bf has been reserved
pnp: 00:03: ioport range 0x10c0-0x10df has been reserved
pnp: 00:08: ioport range 0xc80-0xcff has been reserved
pnp: 00:08: ioport range 0x910-0x91f has been reserved
pnp: 00:08: ioport range 0x920-0x92f has been reserved
pnp: 00:08: ioport range 0xcbc-0xcbf has been reserved
pnp: 00:08: ioport range 0x940-0x97f has been reserved
pnp: 00:0c: ioport range 0xcb0-0xcbb has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: dd000000-dfefffff
  PREFETCH window: c0000000-cfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: dcf00000-dcffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: disabled.
  MEM window: dce00000-dcefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
  IO window: e000-efff
  MEM window: dcc00000-dcdfffff
  PREFETCH window: d0000000-d01fffff
PCI: Bus 4, cardbus bridge: 0000:03:01.0
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 52000000-53ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: dcb00000-dcbfffff
  PREFETCH window: 50000000-51ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:03:01.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 193
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1166200018.908:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 248CC16DDFEF77DD
  - key was been created 6299 seconds in future
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:1d.0: uhci_check_and_reset_hc: legsup = 0x2f00
pci 0000:00:1d.0: Performing full reset
pci 0000:00:1d.1: uhci_check_and_reset_hc: legsup = 0x2000
pci 0000:00:1d.1: Performing full reset
pci 0000:00:1d.2: uhci_check_and_reset_hc: legsup = 0x2000
pci 0000:00:1d.2: Performing full reset
pci 0000:00:1d.3: uhci_check_and_reset_hc: legsup = 0x2000
pci 0000:00:1d.3: Performing full reset
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 3072k, total 262144k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (45 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: AGP aperture is 256M @ 0x0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: HL-DT-STCD-RW/DVD-ROM GCC-4244N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ide-floppy driver 0.99.newide
Yenta: CardBus bridge found at 0000:03:01.0 [1028:01c8]
Yenta O2: res at 0x94/0xD4: 00/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x04b8, PCI irq 193
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#03) from #04 to #07
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: clean.
pcmcia: parent PCI bridge Memory window: 0xdcb00000 - 0xdcbfffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
input: AT Translated Set 2 keyboard as /class/input/input0
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
Freeing unused kernel memory: 240k freed
Write protecting the kernel read-only data: 391k
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
uhci_hcd 0000:00:1d.0: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.0: Performing full reset
uhci_hcd 0000:00:1d.0: irq 58, io base 0x0000bf80
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-1.2864.fc6 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: uevent
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: trying to enable port power on non-switchable hub
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
uhci_hcd 0000:00:1d.0: port 2 portsc 0093,00
hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 21 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
drivers/usb/core/inode.c: creating file '002'
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
uhci_hcd 0000:00:1d.1: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.1: Performing full reset
uhci_hcd 0000:00:1d.1: irq 66, io base 0x0000bf60
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-1.2864.fc6 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: uevent
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: trying to enable port power on non-switchable hub
input: PS/2 Mouse as /class/input/input1
input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
drivers/usb/core/inode.c: creating file '001'
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 22 (level, low) -> IRQ 74
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
drivers/usb/core/inode.c: creating file '003'
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
uhci_hcd 0000:00:1d.2: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.2: Performing full reset
uhci_hcd 0000:00:1d.2: irq 74, io base 0x0000bf40
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.18-1.2864.fc6 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb usb3: uevent
usb usb3: configuration #1 chosen from 1 choice
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: uevent
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: trying to enable port power on non-switchable hub
usb 1-2: new full speed USB device using uhci_hcd and address 2
drivers/usb/core/inode.c: creating file '001'
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 82
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
drivers/usb/core/inode.c: creating file '004'
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: detected 2 ports
uhci_hcd 0000:00:1d.3: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.3: Performing full reset
uhci_hcd 0000:00:1d.3: irq 82, io base 0x0000bf20
usb usb4: default language 0x0409
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.18-1.2864.fc6 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.3
usb usb4: uevent
usb usb4: configuration #1 chosen from 1 choice
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: uevent
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
hub 4-0:1.0: trying to enable port power on non-switchable hub
drivers/usb/core/inode.c: creating file '001'
usb 1-2: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-2: uevent
usb 1-2: configuration #1 chosen from 1 choice
usb 1-2: adding 1-2:1.0 (config #1, interface 0)
usb 1-2:1.0: uevent
hub 1-2:1.0: usb_probe_interface
hub 1-2:1.0: usb_probe_interface - got id
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
hub 1-2:1.0: compound device; port removable status: FFFR
hub 1-2:1.0: individual port power switching
hub 1-2:1.0: individual port over-current protection
hub 1-2:1.0: power on to power good time: 100ms
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
hub 1-2:1.0: local power source is good
hub 1-2:1.0: enabling power on all ports
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
drivers/usb/core/inode.c: creating file '005'
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: reset hcs_params 0x104208 dbg=1 cc=4 pcc=2 ordered !ppc ports=8
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
ehci_hcd 0000:00:1d.7: irq 58, io mem 0xffa80000
ehci_hcd 0000:00:1d.7: reset command 000002 (park)=0 ithresh=0 period=1024 Reset HALT
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: default language 0x0409
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: EHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.18-1.2864.fc6 ehci_hcd
usb usb5: SerialNumber: 0000:00:1d.7
usb usb5: uevent
usb usb5: configuration #1 chosen from 1 choice
usb usb5: adding 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: uevent
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
drivers/usb/core/inode.c: creating file '002'
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004
uhci_hcd 0000:00:1d.0: port 2 portsc 008a,00
hub 1-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
usb 1-2: USB disconnect, address 2
usb 1-2: usb_disable_device nuking all URBs
uhci_hcd 0000:00:1d.0: shutdown urb f7ed7540 pipe 40408280 ep1in-intr
usb 1-2: unregistering interface 1-2:1.0
 usbdev1.2_ep81: ep_device_release called for usbdev1.2_ep81
usb 1-2:1.0: uevent
usb 1-2: unregistering device
 usbdev1.2_ep00: ep_device_release called for usbdev1.2_ep00
usb 1-2: uevent
hub 5-0:1.0: standalone hub
hub 5-0:1.0: no power switching (usb 1.0)
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: Single TT
hub 5-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 5-0:1.0: power on to power good time: 20ms
hub 5-0:1.0: local power source is good
hub 5-0:1.0: trying to enable port power on non-switchable hub
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0002
uhci_hcd 0000:00:1d.1: port 1 portsc 008a,00
hub 2-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
drivers/usb/core/inode.c: creating file '001'
SCSI subsystem initialized
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 177
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
hub 5-0:1.0: state 7 ports 8 chg 0000 evt 0000
ehci_hcd 0000:00:1d.7: GetStatus port 2 status 001803 POWER sig=j CSC CONNECT
hub 5-0:1.0: port 2, status 0501, change 0001, 480 Mb/s
ata: 0x170 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
scsi0 : ata_piix
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:1d.7: port 2 high speed
ehci_hcd 0000:00:1d.7: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
ata1.00: ATA-7, max UDMA/100, 156301488 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 8
ata1.00: configured for UDMA/100
  Vendor: ATA       Model: FUJITSU MHV2080B  Rev: 0085
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda:<6>usb 5-2: new high speed USB device using ehci_hcd and address 2
 sda1 sda2 sda3 sda4 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
ehci_hcd 0000:00:1d.7: port 2 high speed
ehci_hcd 0000:00:1d.7: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 5-2: uevent
usb 5-2: configuration #1 chosen from 1 choice
usb 5-2: adding 5-2:1.0 (config #1, interface 0)
usb 5-2:1.0: uevent
hub 5-2:1.0: usb_probe_interface
hub 5-2:1.0: usb_probe_interface - got id
hub 5-2:1.0: USB hub found
hub 5-2:1.0: 4 ports detected
hub 5-2:1.0: compound device; port removable status: FFFR
hub 5-2:1.0: individual port power switching
hub 5-2:1.0: individual port over-current protection
hub 5-2:1.0: TT per port
hub 5-2:1.0: TT requires at most 8 FS bit times (666 ns)
hub 5-2:1.0: power on to power good time: 100ms
hub 5-2:1.0: local power source is good
hub 5-2:1.0: enabling power on all ports
usb 5-2: link qh256-0001/f7e82100 start 255 [1/0 us]
drivers/usb/core/inode.c: creating file '002'
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001803 POWER sig=j CSC CONNECT
hub 5-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
hub 5-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
usb usb3: suspend_rh (auto-stop)
ehci_hcd 0000:00:1d.7: port 3 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003801 POWER OWNER sig=j CONNECT
hub 5-0:1.0: state 7 ports 8 chg 0000 evt 0000
hub 5-2:1.0: state 7 ports 4 chg 0000 evt 0000
hub 5-2:1.0: port 3, status 0101, change 0001, 12 Mb/s
ehci_hcd 0000:00:1d.7: fatal command 010031 (park)=0 ithresh=1 Async Periodic period=1024 RUN
ehci_hcd 0000:00:1d.7: fatal status c000 Async Periodic
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usb usb4: suspend_rh (auto-stop)
hub 5-2:1.0: debounce: port 3: total 100ms stable 100ms status 0x101
hub 5-2:1.0: port 3 not reset yet, waiting 10ms
usb 5-2.3: new full speed USB device using ehci_hcd and address 4
hub 5-2:1.0: port 3 not reset yet, waiting 10ms
usb usb1: suspend_rh (auto-stop)
usb 5-2.3: skipped 1 descriptor after interface
usb 5-2.3: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 5-2.3: uevent
usb 5-2.3: configuration #1 chosen from 1 choice
usb 5-2.3: adding 5-2.3:1.0 (config #1, interface 0)
usb 5-2.3:1.0: uevent
usb 5-2.3: adding 5-2.3:1.1 (config #1, interface 1)
usb 5-2.3:1.1: uevent
usb 5-2.3: adding 5-2.3:1.2 (config #1, interface 2)
usb 5-2.3:1.2: uevent
drivers/usb/core/inode.c: creating file '004'
hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0002
uhci_hcd 0000:00:1d.1: port 1 portsc 0093,00
hub 2-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 2-1: new full speed USB device using uhci_hcd and address 2
audit(1166200024.130:2): enforcing=1 old_enforcing=0 auid=4294967295
usb 2-1: ep0 maxpacket = 8
usb 2-1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1: uevent
usb 2-1: configuration #1 chosen from 1 choice
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: uevent
hub 2-1:1.0: usb_probe_interface
hub 2-1:1.0: usb_probe_interface - got id
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 3 ports detected
hub 2-1:1.0: compound device; port removable status: RFR
hub 2-1:1.0: individual port power switching
hub 2-1:1.0: individual port over-current protection
hub 2-1:1.0: power on to power good time: 100ms
hub 2-1:1.0: hub controller current requirement: 100mA
hub 2-1:1.0: 100mA bus power budget for each child
hub 2-1:1.0: enabling power on all ports
security:  3 users, 6 roles, 1580 types, 170 bools, 1 sens, 1024 cats
security:  59 classes, 49346 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
drivers/usb/core/inode.c: creating file '002'
hub 2-1:1.0: state 7 ports 3 chg 0000 evt 0000
hub 2-1:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 2-1:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1166200024.601:3): policy loaded auid=4294967295
usb 2-1.1: new full speed USB device using uhci_hcd and address 3
usb 2-1.1: ep0 maxpacket = 8
usb 2-1.1: default language 0x0409
usb 2-1.1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1.1: Product: Biometric Coprocessor
usb 2-1.1: Manufacturer: STMicroelectronics
usb 2-1.1: uevent
usb 2-1.1: configuration #1 chosen from 1 choice
usb 2-1.1: adding 2-1.1:1.0 (config #1, interface 0)
usb 2-1.1:1.0: uevent
drivers/usb/core/inode.c: creating file '003'
hub 2-1:1.0: 300mA power budget left
hub 2-1:1.0: port 2, status 0101, change 0001, 12 Mb/s
hub 2-1:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
usb 2-1.2: new full speed USB device using uhci_hcd and address 4
usb 2-1.2: skipped 1 descriptor after endpoint
usb 2-1.2: default language 0x0409
usb 2-1.2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1.2: Product: O2Micro CCID SC Reader
usb 2-1.2: Manufacturer: O2
usb 2-1.2: uevent
usb 2-1.2: configuration #1 chosen from 1 choice
usb 2-1.2: adding 2-1.2:1.0 (config #1, interface 0)
usb 2-1.2:1.0: uevent
drivers/usb/core/inode.c: creating file '004'
hub 2-1:1.0: 300mA power budget left
hub 2-1:1.0: state 7 ports 3 chg 0000 evt 0004
usb 2-1.2:1.0: uevent
usb 2-1.2: uevent
usb 2-1.1:1.0: uevent
usb 2-1.1: uevent
usb 2-1:1.0: uevent
usb 2-1: uevent
usb 5-2.3:1.2: uevent
usb 5-2.3:1.1: uevent
usb 5-2.3:1.0: uevent
usb 5-2.3: uevent
usb 5-2:1.0: uevent
usb 5-2: uevent
usb 5-0:1.0: uevent
usb usb5: uevent
usb 4-0:1.0: uevent
usb usb4: uevent
usb 3-0:1.0: uevent
usb usb3: uevent
usb 2-0:1.0: uevent
usb usb2: uevent
usb 1-0:1.0: uevent
usb usb1: uevent
input: PC Speaker as /class/input/input3
tg3.c:v3.65 (August 07, 2006)
ACPI: PCI Interrupt 0000:09:00.0[A] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:09:00.0 to 64
eth0: Tigon3 [partno(BCM5752KFBG) rev 6002 PHY(5752)] (PCI Express) 10/100/1000BaseT Ethernet 00:15:c5:08:29:47
eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 177
Bluetooth: Core ver 2.10
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:03:01.4[A] -> GSI 19 (level, low) -> IRQ 193
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[193]  MMIO=[dcbff000-dcbff7ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
Floppy drive(s): fd0 is 1.44M
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
sd 0:0:0:0: Attached scsi generic sg0 type 0
Bluetooth: HCI USB driver ver 2.9
hci_usb 5-2.3:1.0: usb_probe_interface
hci_usb 5-2.3:1.0: usb_probe_interface - got id
 usbdev5.4_ep03: ep_device_release called for usbdev5.4_ep03
 usbdev5.4_ep83: ep_device_release called for usbdev5.4_ep83
hci_usb 5-2.3:1.2: usb_probe_interface
hci_usb 5-2.3:1.2: usb_probe_interface - got id
usbcore: registered new driver hci_usb
intel_rng: FWH not detected
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[324fc0001e146921]
floppy0: no floppy controllers found
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
lp: driver loaded but no devices found
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: ACPI Dock Station Driver 
ibm_acpi: ec object not found
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: multipath: version 1.0.4 loaded
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda3, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:2031608k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8180 buckets, 65440 max) - 228 bytes per conntrack
process `sysctl' is using deprecated sysctl (syscall) net.ipv6.neigh.lo.base_reachable_time; Use net.ipv6.neigh.lo.base_reachable_time_ms instead.
PM: Writing back config space on device 0000:09:00.0 at offset 1 (was 100506, writing 100106)
ADDRCONF(NETDEV_UP): eth0: link is not ready
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
audit(1166218060.464:4): avc:  denied  { search } for  pid=2678 comm="pcscd" name="usbdev2.4_ep03" dev=sysfs ino=1384 scontext=system_u:system_r:pcscd_t:s0 tcontext=system_u:object_r:sysfs_t:s0 tclass=dir
BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000b
 printing eip:
c04a5f42
*pde = 00000000
Oops: 0000 [#1]
SMP 
last sysfs file: /devices/pci0000:00/0000:00:00.0/irq
Modules linked in: hidp l2cap sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink iptable_filter ip_tables ip6t_REJECT xt_tcpudp ip6table_filter ip6_tables x_tables ipv6 cpufreq_ondemand dm_multipath video sbs i2c_ec dock button battery asus_acpi ac parport_pc lp parport snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer ide_cd snd soundcore hci_usb joydev sg snd_page_alloc ohci1394 cdrom ieee1394 bluetooth i2c_i801 tg3 serio_raw i2c_core pcspkr dm_snapshot dm_zero dm_mirror dm_mod ata_piix libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
CPU:    1
EIP:    0060:[<c04a5f42>]    Not tainted VLI
EFLAGS: 00010286   (2.6.18-1.2864.fc6 #1) 
EIP is at sysfs_hash_and_remove+0x18/0xfd
eax: fffffff3   ebx: c069cf0c   ecx: c0683b9c   edx: fffffff3
esi: fffffff3   edi: fffffff3   ebp: f7063414   esp: f6d28e68
ds: 007b   es: 007b   ss: 0068
Process pcscd (pid: 2678, ti=f6d28000 task=f7dbe1f0 task.ti=f6d28000)
Stack: c0634109 fffffff3 f7063414 c069cf0c fffffff3 fffffff3 f7063414 c04a7f69 
       c069cf00 f70632b0 c04a7fb8 f7063208 f70473a0 f7063208 c055572f f70632b0 
       c05513ff f7063208 f7000640 00000001 f703f788 c055142e f6d28ed4 c058800c 
Call Trace:
 [<c04a7f69>] remove_files+0x15/0x1e
 [<c04a7fb8>] sysfs_remove_group+0x46/0x5c
 [<c055572f>] device_pm_remove+0x2b/0x62
 [<c05513ff>] device_del+0x11a/0x141
 [<c055142e>] device_unregister+0x8/0x10
 [<c058800c>] usb_remove_ep_files+0x5b/0x7b
 [<c0587b82>] usb_remove_sysfs_intf_files+0x1d/0x54
 [<c0585b5c>] usb_set_interface+0x135/0x1bf
 [<c0586047>] usb_unbind_interface+0x4a/0x6a
 [<c0552a38>] __device_release_driver+0x60/0x78
 [<c0552c85>] device_release_driver+0x2b/0x3a
 [<c057e4f5>] usb_driver_release_interface+0x3b/0x63
 [<c058833d>] releaseintf+0x4b/0x5b
 [<c058ab8d>] usbdev_release+0x67/0x9e
 [<c0470402>] __fput+0xba/0x188
 [<c046dc61>] filp_close+0x52/0x59
 [<c0404013>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb
Leftover inexact backtrace:
 =======================
Code: 8b 40 20 8b 40 30 c3 8b 40 14 8b 00 c3 8b 40 14 8b 00 c3 55 57 56 53 83 ec 0c 85 c0 89 44 24 04 89 14 24 0f 84 df 00 00 00 89 c2 <8b> 40 18 85 c0 0f 84 d2 00 00 00 8b 52 60 83 e8 80 89 54 24 08 
EIP: [<c04a5f42>] sysfs_hash_and_remove+0x18/0xfd SS:ESP 0068:f6d28e68
 <5>audit(1166218064.000:5): avc:  denied  { search } for  pid=2477 comm="irqbalance" name="net" dev=proc ino=-268435432 scontext=system_u:system_r:irqbalance_t:s0 tcontext=system_u:object_r:proc_net_t:s0 tclass=dir
PM: Writing back config space on device 0000:09:00.0 at offset 1 (was 100506, writing 100106)
ADDRCONF(NETDEV_UP): eth0: link is not ready
-- 
http://www.codemonkey.org.uk
