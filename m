Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWJLTNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWJLTNz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWJLTNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:13:55 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:44809 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1750903AbWJLTNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:13:52 -0400
Message-ID: <452E93D7.6020004@tuxrocks.com>
Date: Thu, 12 Oct 2006 14:13:27 -0500
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic in 2.6.19-rc1
References: <452D43B6.8020406@tuxrocks.com> <20061012000643.f875c96e.akpm@osdl.org>
In-Reply-To: <20061012000643.f875c96e.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090808040103080903090909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090808040103080903090909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> On Wed, 11 Oct 2006 14:19:18 -0500
> Frank Sorenson <frank@tuxrocks.com> wrote:
> 
>> I'm getting kernel panics within a few minutes of boot with 2.6.19-rc1 
>> (latest git) on x86_64.  Other than "make oldconfig", it's an identical 
>> configuration to a working kernel on 2.6.18.
>>
>> The panic scrolls off the screen, but I copied down what was on the screen:
> 
> Can you get netconsole going?  Documentation/networking/netconsole.txt.
> It's pretty simple.

Three netconsole dumps attached.  I hope they provide more information. 
  Let me know if there's anything more I can provide.

Thanks,

Frank

--------------090808040103080903090909
Content-Type: text/plain;
 name="netconsole-1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netconsole-1.txt"

[    0.000000] Linux version 2.6.19-rc1-fs2 (sorenson@george.sorensonfamily.com) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #4 SMP PREEMPT Thu Oct 12 12:32:29 CDT 2006
[    0.000000] Command line: ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose nmi_watchdog=1 notsc netconsole=@172.31.0.101/,@64.62.190.123/00:0F:66:99:97:4F
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fed3400 (usable)
[    0.000000]  BIOS-e820: 000000007fed3400 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.4 present.
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000007fed3000
[    0.000000] Bootmem setup node 0 0000000000000000-000000007fed3000
[    0.000000] No mptable found.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   523987
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to physical flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 34048 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 515695
[    0.000000] Kernel command line: ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose nmi_watchdog=1 notsc netconsole=@172.31.0.101/,@64.62.190.123/00:0F:66:99:97:4F
[    0.000000] netconsole: local port 6665
[    0.000000] netconsole: local IP 172.31.0.101
[    0.000000] netconsole: interface eth0
[    0.000000] netconsole: remote port 6666
[    0.000000] netconsole: remote IP 64.62.190.123
[    0.000000] netconsole: remote ethernet address 00:0f:66:99:97:4f
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    9.488654] Console: colour dummy device 80x25
[    9.489709] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    9.490530] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    9.490697] Checking aperture...
[    9.521588] Memory: 2052256k/2095948k available (3202k kernel code, 43304k reserved, 1458k data, 328k init)
[    9.581534] Calibrating delay using timer specific routine.. 4330.56 BogoMIPS (lpj=2165283)
[    9.581592] Security Framework v1.0.0 initialized
[    9.581599] SELinux:  Initializing.
[    9.581626] SELinux:  Starting in permissive mode
[    9.581634] selinux_register_security:  Registering secondary module capability
[    9.581638] Capability LSM initialized as secondary
[    9.581665] Mount-cache hash table entries: 256
[    9.581849] CPU: L1 I cache: 32K, L1 D cache: 32K
[    9.581853] CPU: L2 cache: 4096K
[    9.581856] CPU 0/0 -> Node 0
[    9.581859] using mwait in idle threads.
[    9.581861] CPU: Physical Processor ID: 0
[    9.581863] CPU: Processor Core ID: 0
[    9.581871] CPU0: Thermal monitoring enabled (TM2)
[    9.581885] SMP alternatives: switching to UP code
[    9.582113] ACPI: Core revision 20060707
[    9.601593] enabled ExtINT on CPU#0
[    9.601596] ESR value after enabling vector: 00000000, after 00000040
[    9.601793] ENABLING IO-APIC IRQs
[    9.601997] ..TIMER: vector=0x20 apic1=0 pin1=2 apic2=-1 pin2=-1
[    9.612003] activating NMI Watchdog ... done.
[    9.612012] Using local APIC timer interrupts.
[    9.658207] result 10402970
[    9.658209] Detected 10.402 MHz APIC timer.
[    9.658690] SMP alternatives: switching to SMP code
[    9.658725] Booting processor 1/2 APIC 0x1
[   11.412026] Initializing CPU#1
[   11.412221] masked ExtINT on CPU#1
[   11.471512] Calibrating delay using timer specific routine.. 4326.94 BogoMIPS (lpj=2163473)
[   11.471519] CPU: L1 I cache: 32K, L1 D cache: 32K
[   11.471520] CPU: L2 cache: 4096K
[   11.471523] CPU 1/1 -> Node 0
[   11.471524] CPU: Physical Processor ID: 0
[   11.471526] CPU: Processor Core ID: 1
[   11.471531] CPU1: Thermal monitoring enabled (TM2)
[   11.471996] Intel(R) Core(TM)2 CPU         T7400  @ 2.16GHz stepping 06
[    9.730461] Brought up 2 CPUs
[    9.730523] testing NMI watchdog ... OK.
[    9.740528] Disabling vsyscall due to use of PM timer
[    9.740531] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[    9.740534] time.c: Detected 2163.819 MHz processor.
[   11.552819] migration_cost=23
[    9.810871] checking if image is initramfs... it is
[    9.919706] Freeing initrd memory: 1608k freed
[    9.920517] NET: Registered protocol family 16
[    9.920612] ACPI: bus type pci registered
[    9.924212] PCI: Using MMCONFIG at e0000000
[   11.696179] ACPI: Interpreter enabled
[   11.696184] ACPI: Using IOAPIC for interrupt routing
[   11.696937] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   11.697038] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   11.712486] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
[   11.713372] PCI: Transparent bridge - 0000:00:1e.0
[   11.736597] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 11) *4
[   11.736885] ACPI: PCI Interrupt Link [LNKB] (IRQs *5 7)
[   11.737164] ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
[   11.737450] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 11) *3
[   11.737732] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[   11.738017] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   11.738305] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[   11.738596] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
[   11.741833] Linux Plug and Play Support v0.97 (c) Adam Belay
[   11.741848] pnp: PnP ACPI init
[   11.776951] pnp: PnP ACPI: found 11 devices
[   11.778607] intel_rng: FWH not detected
[   11.778842] SCSI subsystem initialized
[   11.778961] usbcore: registered new interface driver usbfs
[   11.779008] usbcore: registered new interface driver hub
[   11.779059] usbcore: registered new device driver usb
[   11.779093] PCI: Using ACPI for IRQ routing
[   11.779097] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   11.779105] testing the IO APIC.......................
[   11.779113] 
[   11.779308] .................................... done.
[   11.779415] Bluetooth: Core ver 2.10
[   11.779474] NET: Registered protocol family 31
[   11.779478] Bluetooth: HCI device and connection manager initialized
[   11.779482] Bluetooth: HCI socket layer initialized
[   11.779497] PCI-GART: No AMD northbridge found.
[   11.799155] pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
[   11.799160] pnp: 00:02: ioport range 0x1000-0x1005 could not be reserved
[   11.799164] pnp: 00:02: ioport range 0x1008-0x100f could not be reserved
[   11.799172] pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
[   11.799175] pnp: 00:03: ioport range 0x1006-0x1007 has been reserved
[   11.799179] pnp: 00:03: ioport range 0x100a-0x1059 could not be reserved
[   11.799183] pnp: 00:03: ioport range 0x1060-0x107f has been reserved
[   11.799187] pnp: 00:03: ioport range 0x1080-0x10bf has been reserved
[   11.799192] pnp: 00:03: ioport range 0x10c0-0x10df has been reserved
[   11.799203] pnp: 00:08: ioport range 0xc80-0xcff could not be reserved
[   11.799207] pnp: 00:08: ioport range 0x910-0x91f has been reserved
[   11.799211] pnp: 00:08: ioport range 0x920-0x92f has been reserved
[   11.799214] pnp: 00:08: ioport range 0xcb0-0xcbf has been reserved
[   11.799218] pnp: 00:08: ioport range 0x930-0x97f has been reserved
[   11.799587] PCI: Bridge: 0000:00:01.0
[   11.799591]   IO window: e000-efff
[   11.799594]   MEM window: dd000000-dfefffff
[   11.799597]   PREFETCH window: c0000000-cfffffff
[   11.799601] PCI: Bridge: 0000:00:1c.0
[   11.799603]   IO window: disabled.
[   11.799608]   MEM window: disabled.
[   11.799612]   PREFETCH window: disabled.
[   11.799618] PCI: Bridge: 0000:00:1c.1
[   11.799620]   IO window: disabled.
[   11.799625]   MEM window: dcf00000-dcffffff
[   11.799630]   PREFETCH window: d0000000-d00fffff
[   11.799636] PCI: Bridge: 0000:00:1c.3
[   11.799639]   IO window: d000-dfff
[   11.799644]   MEM window: dcc00000-dcefffff
[   11.799649]   PREFETCH window: d0100000-d03fffff
[   11.799655] PCI: Bridge: 0000:00:1e.0
[   11.799657]   IO window: disabled.
[   11.799663]   MEM window: dcb00000-dcbfffff
[   11.799667]   PREFETCH window: disabled.
[   11.799685] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   11.799707] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   11.799734] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
[   11.799761] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   11.799809] NET: Registered protocol family 2
[   11.811369] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   11.811551] TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
[   11.813355] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[   11.814837] TCP: Hash tables configured (established 131072 bind 65536)
[   11.814843] TCP reno registered
[   11.815151] Simple Boot Flag at 0x79 set to 0x1
[   11.816061] audit: initializing netlink socket (disabled)
[   11.816075] audit(1160674615.539:1): initialized
[   11.816171] Total HugeTLB memory allocated, 0
[   11.816311] VFS: Disk quotas dquot_6.5.1
[   11.816334] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   11.816440] fuse init (API version 7.7)
[   11.816532] SELinux:  Registering netfilter hooks
[   11.820391] io scheduler noop registered
[   11.820395] io scheduler anticipatory registered
[   11.820398] io scheduler deadline registered
[   11.820413] io scheduler cfq registered (default)
[   11.822882] assign_interrupt_mode Found MSI capability
[   11.823039] assign_interrupt_mode Found MSI capability
[   11.823247] assign_interrupt_mode Found MSI capability
[   11.823466] assign_interrupt_mode Found MSI capability
[   11.823673] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   11.823741] pciehp: HPC vendor_id 8086 device_id 27d0 ss_vid 0 ss_did 0
[   11.823801] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.0
[   11.823823] pciehp: HPC vendor_id 8086 device_id 27d2 ss_vid 0 ss_did 0
[   11.823865] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.1
[   11.823885] pciehp: HPC vendor_id 8086 device_id 27d6 ss_vid 0 ss_did 0
[   11.823927] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.3
[   11.823940] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[   11.824069] vesafb: framebuffer at 0xc0000000, mapped to 0xffffc20010100000, using 5120k, total 262144k
[   11.824074] vesafb: mode is 1280x1024x16, linelength=2560, pages=1
[   11.824077] vesafb: scrolling: redraw
[   11.824081] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   11.865642] Console: switching to colour frame buffer device 160x64
[   11.903702] fb0: VESA VGA frame buffer device
[   11.904444] ACPI: AC Adapter [AC] (on-line)
[   11.927391] ACPI: Battery Slot [BAT0] (battery present)
[   11.927658] ACPI: Lid Switch [LID]
[   11.928707] ACPI: Power Button (CM) [PBTN]
[   11.928903] ACPI: Sleep Button (CM) [SBTN]
[   11.930163] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   11.930885] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   11.931274] ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
[   11.932183] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
[   11.932809] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
[   11.933473] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   11.933766] ACPI: Processor [CPU0] (supports 8 throttling states)
[   11.934556] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
[   11.935179] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
[   11.935908] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   11.936214] ACPI: Processor [CPU1] (supports 8 throttling states)
[   11.943057] ACPI: Thermal Zone [THM] (48 C)
[   11.947358] Real Time Clock Driver v1.12ac
[   11.947628] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.00 (30-Jul-2006)
[   11.948105] iTCO_wdt: Found a ICH7-M TCO device (Version=2, TCOBASE=0x1060)
[   11.948527] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   11.948815] Linux agpgart interface v0.101 (c) Dave Jones
[   11.949133] agpgart: Detected an Intel 945GM Chipset.
[   11.966140] agpgart: AGP aperture is 256M @ 0x0
[   11.966402] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   11.968577] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
[   11.969137] b44.c:v1.01 (Jun 16, 2006)
[   11.969340] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[   11.973272] eth0: Broadcom 4400 10/100BaseT Ethernet 00:15:c5:4b:5e:8f
[   11.973641] netconsole: device eth0 not up yet, forcing it
[   14.973315] b44: eth0: Link is up at 100 Mbps, full duplex.
[   14.973580] b44: eth0: Flow control is off for TX and off for RX.
[   15.728210] netconsole: network logging started
[   15.728218] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   15.751737] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   15.752630] ide0: I/O resource 0x1F0-0x1F7 not free.
[   15.752632] ide0: ports already in use, skipping probe
[   15.826020] hdc: TSSTcorp DVD+/-RW TS-L632D, ATAPI CD/DVD-ROM drive
[   15.868160] ide1 at 0x170-0x177,0x376 on irq 15
[   15.883856] hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
[   15.896557] Uniform CD-ROM driver Revision: 3.20
[   15.911394] ide-floppy driver 0.99.newide
[   15.924259] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[   15.937334] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
[   15.950250] ata: 0x170 IDE port busy
[   15.950251] ata: conflict with ide1
[   15.976268] ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
[   15.989282] ata2: DUMMY
[   16.002124] scsi0 : ata_piix
[   16.024337] ata1.00: ATA-7, max UDMA/100, 192426570 sectors: LBA48 NCQ (depth 0/32)
[   16.037335] ata1.00: ata1: dev 0 multi count 8
[   16.051567] ata1.00: configured for UDMA/100
[   16.064201] scsi1 : ata_piix
[   16.076758] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS72101 MCZO PQ: 0 ANSI: 5
[   16.089434] SCSI device sda: 192426570 512-byte hdwr sectors (98522 MB)
[   16.102053] sda: Write Protect is off
[   16.114641] SCSI device sda: drive cache: write back
[   16.127263] SCSI device sda: 192426570 512-byte hdwr sectors (98522 MB)
[   16.139848] sda: Write Protect is off
[   17.894523] SCSI device sda: drive cache: write back
[   17.907109]  sda: sda1 sda2
[   16.510669] sd 0:0:0:0: Attached scsi disk sda
[   16.523373] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   16.536074] Initializing USB Mass Storage driver...
[   16.548826] usbcore: registered new interface driver usb-storage
[   16.561590] USB Mass Storage support registered.
[   16.574437] usbcore: registered new interface driver libusual
[   16.587354] usbcore: registered new interface driver hiddev
[   16.600331] usbcore: registered new interface driver usbhid
[   16.612709] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   16.625446] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   16.641730] serio: i8042 KBD port at 0x60,0x64 irq 1
[   16.654559] serio: i8042 AUX port at 0x60,0x64 irq 12
[   16.666860] mice: PS/2 mouse device common for all mice
[   16.679218] md: multipath personality registered for level -4
[   16.691901] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[   16.704684] device-mapper: multipath: version 1.0.5 loaded
[   16.717408] device-mapper: multipath round-robin: version 1.0.0 loaded
[   16.729986] device-mapper: multipath emc: version 0.0.3 loaded
[   16.742630] Bluetooth: Virtual HCI driver ver 1.2
[   16.755053] Bluetooth: Broadcom Blutonium firmware driver ver 1.0
[   16.767732] usbcore: registered new interface driver bcm203x
[   16.780197] Advanced Linux Sound Architecture Driver Version 1.0.13 (Fri Oct 06 18:28:19 2006 UTC).
[   16.793172] input: AT Translated Set 2 keyboard as /class/input/input0
[   18.548651] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
[   18.630723] ALSA device list:
[   18.643346]   #0: HDA Intel at 0xdfffc000 irq 21
[   18.656026] TCP cubic registered
[   18.668392] Initializing XFRM netlink socket
[   18.680672] NET: Registered protocol family 1
[   18.693085] NET: Registered protocol family 17
[   18.705221] Bluetooth: L2CAP ver 2.8
[   18.717364] Bluetooth: L2CAP socket layer initialized
[   18.729323] Bluetooth: SCO (Voice Link) ver 0.5
[   18.740934] Bluetooth: SCO socket layer initialized
[   18.752734] Bluetooth: RFCOMM socket layer initialized
[   18.764469] Bluetooth: RFCOMM TTY layer initialized
[   18.776065] Bluetooth: RFCOMM ver 1.8
[   18.787446] Bluetooth: BNEP (Ethernet Emulation) ver 1.2
[   18.798681] Bluetooth: BNEP filters: protocol multicast
[   18.809850] Bluetooth: HIDP (Human Interface Emulation) ver 1.1
[   18.821006] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   18.832175] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   17.102275] ACPI: (supports S0 S3 S4 S5)
[   17.113790] Freeing unused kernel memory: 328k freed
[   17.125351] Write protecting the kernel read-only data: 677k
[   17.300519] Synaptics Touchpad, model: 1, fw: 6.2, id: 0xfa0b1, caps: 0xa04713/0x200000
[   17.316366] input: SynPS/2 Synaptics TouchPad as /class/input/input1
[   17.610173] kjournald starting.  Commit interval 5 seconds
[   17.621753] EXT3-fs: mounted filesystem with ordered data mode.
[   18.124364] security:  3 users, 6 roles, 1481 types, 152 bools, 1 sens, 256 cats
[   18.135348] security:  58 classes, 43474 rules
[   18.147137] SELinux:  Completing initialization.
[   18.157883] SELinux:  Setting up existing superblocks.
[   18.177811] SELinux: initialized (dev dm-0, type ext3), uses xattr
[   18.354867] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[   18.365986] SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
[   18.376791] SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
[   18.387301] SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
[   18.397592] SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
[   20.150037] SELinux: initialized (dev devpts, type devpts), uses transition SIDs
[   20.160651] SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
[   20.171243] SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
[   20.181992] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[   18.450593] SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
[   18.461477] SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
[   18.472220] SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
[   18.482973] SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
[   20.235807] SELinux: initialized (dev proc, type proc), uses genfs_contexts
[   20.246801] SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
[   20.257576] SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
[   20.268331] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
[   20.280354] audit(1160674623.030:2): policy loaded auid=4294967295
[   19.179079] SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
[   20.889846] warning: process `date' used the removed sysctl system call
[  143.574063] do_IRQ: 0.65 No irq handler for vector
[  160.311799] NMI Watchdog detected LOCKUP on CPU 1
[  160.312107] CPU 1 
[  160.312250] Modules linked in: sunrpc asus_acpi lp parport_pc parport nvram uhci_hcd joydev i2c_i801 ohci1394 ieee1394 ehci_hcd i2c_core
[  160.313252] Pid: 0, comm: swapper Not tainted 2.6.19-rc1-fs2 #4
[  160.313635] RIP: 0010:[<ffffffff81183dbc>]  [<ffffffff81183dbc>] acpi_processor_idle+0x259/0x48d
[  160.314224] RSP: 0018:ffff810037e1be78  EFLAGS: 00000097
[  160.314566] RAX: 00000000009bd686 RBX: 0000000000000001 RCX: 0000000000001008
[  160.315026] RDX: 0000000000001016 RSI: 0000000000000013 RDI: 0000000000000000
[  160.315485] RBP: ffff810037e1bec8 R08: ffff81007db44900 R09: 000000007db44960
[  160.315945] R10: 00007fff89ad2cd0 R11: 0000000000000246 R12: ffff81007db44960
[  160.316403] R13: 00000000009bd686 R14: ffff81007db44800 R15: 0000000000000008
[  160.316864] FS:  0000000000000000(0000) GS:ffff81007debecc0(0000) knlGS:0000000000000000
[  160.317383] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[  160.317755] CR2: 00002b6954757000 CR3: 0000000067fb5000 CR4: 00000000000006e0
[  160.318214] Process swapper (pid: 0, threadinfo ffff810037e1a000, task ffff810037e02100)
[  160.318733] Stack:  0000000000000000 0000000000000001 ffff810037e1beb8 ffffffff8131d205
[  160.319324]  00000000810088ad ffffffff81183b63 0000000000000001 0000000000000100
[  160.319859]  ffffffff8148e300 0000000000000008 ffff810037e1bee8 ffffffff81008caa
[  160.320379] Call Trace:
[  160.320559]  [<ffffffff8131d205>] atomic_notifier_call_chain+0x3e/0x60
[  160.320984]  [<ffffffff81183b63>] acpi_processor_idle+0x0/0x48d
[  160.321367]  [<ffffffff81008caa>] cpu_idle+0x8f/0xc6
[  160.321693]  [<ffffffff81018274>] start_secondary+0x44a/0x45a
[  160.322067] 
[  160.322167] 
[  160.322168] Code: 89 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
Bootdata ok (command line is ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose nmi_watchdog=1 notsc netconsole=@172.31.0.101/,@64.62.190.123/00:0F:66:99:97:4F)

--------------090808040103080903090909
Content-Type: text/plain;
 name="netconsole-2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netconsole-2.txt"

[    0.000000] Linux version 2.6.19-rc1-fs2 (sorenson@george.sorensonfamily.com) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #4 SMP PREEMPT Thu Oct 12 12:32:29 CDT 2006
[    0.000000] Command line: ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose nmi_watchdog=1 notsc netconsole=@172.31.0.101/,@64.62.190.123/00:0F:66:99:97:4F loglevel=7
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fed3400 (usable)
[    0.000000]  BIOS-e820: 000000007fed3400 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.4 present.
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000007fed3000
[    0.000000] Bootmem setup node 0 0000000000000000-000000007fed3000
[    0.000000] No mptable found.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   523987
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to physical flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 34048 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 515695
[    0.000000] Kernel command line: ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose nmi_watchdog=1 notsc netconsole=@172.31.0.101/,@64.62.190.123/00:0F:66:99:97:4F loglevel=7
[    0.000000] netconsole: local port 6665
[    0.000000] netconsole: local IP 172.31.0.101
[    0.000000] netconsole: interface eth0
[    0.000000] netconsole: remote port 6666
[    0.000000] netconsole: remote IP 64.62.190.123
[    0.000000] netconsole: remote ethernet address 00:0f:66:99:97:4f
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   12.560644] Console: colour dummy device 80x25
[   12.561806] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   12.562646] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   12.562799] Checking aperture...
[   12.593693] Memory: 2052256k/2095948k available (3202k kernel code, 43304k reserved, 1458k data, 328k init)
[   12.653524] Calibrating delay using timer specific routine.. 4330.65 BogoMIPS (lpj=2165329)
[   12.653582] Security Framework v1.0.0 initialized
[   12.653589] SELinux:  Initializing.
[   12.653617] SELinux:  Starting in permissive mode
[   12.653625] selinux_register_security:  Registering secondary module capability
[   12.653629] Capability LSM initialized as secondary
[   12.653656] Mount-cache hash table entries: 256
[   12.653839] CPU: L1 I cache: 32K, L1 D cache: 32K
[   12.653843] CPU: L2 cache: 4096K
[   12.653847] CPU 0/0 -> Node 0
[   12.653849] using mwait in idle threads.
[   12.653852] CPU: Physical Processor ID: 0
[   12.653854] CPU: Processor Core ID: 0
[   12.653862] CPU0: Thermal monitoring enabled (TM2)
[   12.653876] SMP alternatives: switching to UP code
[   12.654105] ACPI: Core revision 20060707
[   12.673633] enabled ExtINT on CPU#0
[   12.673637] ESR value after enabling vector: 00000000, after 00000040
[   12.673833] ENABLING IO-APIC IRQs
[   12.674037] ..TIMER: vector=0x20 apic1=0 pin1=2 apic2=-1 pin2=-1
[   12.684601] activating NMI Watchdog ... done.
[   12.684610] Using local APIC timer interrupts.
[   12.730804] result 10403185
[   12.730807] Detected 10.403 MHz APIC timer.
[   12.731683] SMP alternatives: switching to SMP code
[   12.731719] Booting processor 1/2 APIC 0x1
[   14.531592] Initializing CPU#1
[   14.531787] masked ExtINT on CPU#1
[   14.591073] Calibrating delay using timer specific routine.. 4326.94 BogoMIPS (lpj=2163473)
[   14.591080] CPU: L1 I cache: 32K, L1 D cache: 32K
[   14.591082] CPU: L2 cache: 4096K
[   14.591084] CPU 1/1 -> Node 0
[   14.591086] CPU: Physical Processor ID: 0
[   14.591087] CPU: Processor Core ID: 1
[   14.591092] CPU1: Thermal monitoring enabled (TM2)
[   14.591557] Intel(R) Core(TM)2 CPU         T7400  @ 2.16GHz stepping 06
[   12.803450] Brought up 2 CPUs
[   12.803511] testing NMI watchdog ... OK.
[   12.813517] Disabling vsyscall due to use of PM timer
[   12.813520] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[   12.813523] time.c: Detected 2163.864 MHz processor.
[   14.640781] migration_cost=31
[   12.852261] checking if image is initramfs... it is
[   12.960981] Freeing initrd memory: 1608k freed
[   12.961786] NET: Registered protocol family 16
[   12.961881] ACPI: bus type pci registered
[   12.965501] PCI: Using MMCONFIG at e0000000
[   14.783671] ACPI: Interpreter enabled
[   14.783676] ACPI: Using IOAPIC for interrupt routing
[   14.784436] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   14.784537] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   14.799990] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
[   14.800873] PCI: Transparent bridge - 0000:00:1e.0
[   14.824057] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 11) *4
[   14.824345] ACPI: PCI Interrupt Link [LNKB] (IRQs *5 7)
[   14.824625] ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
[   14.824906] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 11) *3
[   14.825191] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[   14.825477] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   14.825765] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[   14.826053] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
[   14.829273] Linux Plug and Play Support v0.97 (c) Adam Belay
[   14.829290] pnp: PnP ACPI init
[   14.864371] pnp: PnP ACPI: found 11 devices
[   14.866021] intel_rng: FWH not detected
[   14.866255] SCSI subsystem initialized
[   14.866374] usbcore: registered new interface driver usbfs
[   14.866420] usbcore: registered new interface driver hub
[   14.866475] usbcore: registered new device driver usb
[   14.866511] PCI: Using ACPI for IRQ routing
[   14.866515] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   14.866522] testing the IO APIC.......................
[   14.866530] 
[   14.866725] .................................... done.
[   14.866827] Bluetooth: Core ver 2.10
[   14.866888] NET: Registered protocol family 31
[   14.866891] Bluetooth: HCI device and connection manager initialized
[   14.866895] Bluetooth: HCI socket layer initialized
[   14.866911] PCI-GART: No AMD northbridge found.
[   14.886534] pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
[   14.886540] pnp: 00:02: ioport range 0x1000-0x1005 could not be reserved
[   14.886544] pnp: 00:02: ioport range 0x1008-0x100f could not be reserved
[   14.886551] pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
[   14.886555] pnp: 00:03: ioport range 0x1006-0x1007 has been reserved
[   14.886559] pnp: 00:03: ioport range 0x100a-0x1059 could not be reserved
[   14.886563] pnp: 00:03: ioport range 0x1060-0x107f has been reserved
[   14.886567] pnp: 00:03: ioport range 0x1080-0x10bf has been reserved
[   14.886571] pnp: 00:03: ioport range 0x10c0-0x10df has been reserved
[   14.886581] pnp: 00:08: ioport range 0xc80-0xcff could not be reserved
[   14.886585] pnp: 00:08: ioport range 0x910-0x91f has been reserved
[   14.886589] pnp: 00:08: ioport range 0x920-0x92f has been reserved
[   14.886592] pnp: 00:08: ioport range 0xcb0-0xcbf has been reserved
[   14.886596] pnp: 00:08: ioport range 0x930-0x97f has been reserved
[   14.886967] PCI: Bridge: 0000:00:01.0
[   14.886970]   IO window: e000-efff
[   14.886974]   MEM window: dd000000-dfefffff
[   14.886977]   PREFETCH window: c0000000-cfffffff
[   14.886980] PCI: Bridge: 0000:00:1c.0
[   14.886982]   IO window: disabled.
[   14.886988]   MEM window: disabled.
[   14.886992]   PREFETCH window: disabled.
[   14.886997] PCI: Bridge: 0000:00:1c.1
[   14.886999]   IO window: disabled.
[   14.887005]   MEM window: dcf00000-dcffffff
[   14.887009]   PREFETCH window: d0000000-d00fffff
[   14.887015] PCI: Bridge: 0000:00:1c.3
[   14.887018]   IO window: d000-dfff
[   14.887024]   MEM window: dcc00000-dcefffff
[   14.887028]   PREFETCH window: d0100000-d03fffff
[   14.887034] PCI: Bridge: 0000:00:1e.0
[   14.887037]   IO window: disabled.
[   14.887042]   MEM window: dcb00000-dcbfffff
[   14.887047]   PREFETCH window: disabled.
[   14.887064] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   14.887087] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   14.887114] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
[   14.887141] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   14.887193] NET: Registered protocol family 2
[   14.897978] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   14.898165] TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
[   14.899969] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[   14.901448] TCP: Hash tables configured (established 131072 bind 65536)
[   14.901454] TCP reno registered
[   14.901761] Simple Boot Flag at 0x79 set to 0x1
[   14.902667] audit: initializing netlink socket (disabled)
[   14.902682] audit(1160676273.507:1): initialized
[   14.902770] Total HugeTLB memory allocated, 0
[   14.902903] VFS: Disk quotas dquot_6.5.1
[   14.902923] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   14.903030] fuse init (API version 7.7)
[   14.903121] SELinux:  Registering netfilter hooks
[   14.907002] io scheduler noop registered
[   14.907006] io scheduler anticipatory registered
[   14.907010] io scheduler deadline registered
[   14.907024] io scheduler cfq registered (default)
[   14.909494] assign_interrupt_mode Found MSI capability
[   14.909654] assign_interrupt_mode Found MSI capability
[   14.909865] assign_interrupt_mode Found MSI capability
[   14.910081] assign_interrupt_mode Found MSI capability
[   14.910289] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   14.910351] pciehp: HPC vendor_id 8086 device_id 27d0 ss_vid 0 ss_did 0
[   14.910410] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.0
[   14.910432] pciehp: HPC vendor_id 8086 device_id 27d2 ss_vid 0 ss_did 0
[   14.910474] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.1
[   14.910494] pciehp: HPC vendor_id 8086 device_id 27d6 ss_vid 0 ss_did 0
[   14.910537] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.3
[   14.910549] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[   14.910679] vesafb: framebuffer at 0xc0000000, mapped to 0xffffc20010100000, using 5120k, total 262144k
[   14.910684] vesafb: mode is 1280x1024x16, linelength=2560, pages=1
[   14.910687] vesafb: scrolling: redraw
[   14.910691] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   14.952124] Console: switching to colour frame buffer device 160x64
[   14.990998] fb0: VESA VGA frame buffer device
[   14.991723] ACPI: AC Adapter [AC] (on-line)
[   15.014657] ACPI: Battery Slot [BAT0] (battery present)
[   15.014929] ACPI: Lid Switch [LID]
[   15.015979] ACPI: Power Button (CM) [PBTN]
[   15.016176] ACPI: Sleep Button (CM) [SBTN]
[   15.017435] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   15.018154] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   15.018537] ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
[   15.019455] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
[   15.020093] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
[   15.020768] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   15.021074] ACPI: Processor [CPU0] (supports 8 throttling states)
[   15.021860] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
[   15.022487] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
[   15.023215] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   15.023517] ACPI: Processor [CPU1] (supports 8 throttling states)
[   15.030329] ACPI: Thermal Zone [THM] (48 C)
[   15.034666] Real Time Clock Driver v1.12ac
[   15.034952] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.00 (30-Jul-2006)
[   15.035402] iTCO_wdt: Found a ICH7-M TCO device (Version=2, TCOBASE=0x1060)
[   15.035817] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   15.036106] Linux agpgart interface v0.101 (c) Dave Jones
[   15.036414] agpgart: Detected an Intel 945GM Chipset.
[   15.053413] agpgart: AGP aperture is 256M @ 0x0
[   15.053660] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   15.055834] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
[   15.056396] b44.c:v1.01 (Jun 16, 2006)
[   15.056587] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[   15.060512] eth0: Broadcom 4400 10/100BaseT Ethernet 00:15:c5:4b:5e:8f
[   15.060896] netconsole: device eth0 not up yet, forcing it
[   18.060898] b44: eth0: Link is up at 100 Mbps, full duplex.
[   18.061163] b44: eth0: Flow control is off for TX and off for RX.
[   18.767306] netconsole: network logging started
[   18.767314] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   18.767317] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   18.768208] ide0: I/O resource 0x1F0-0x1F7 not free.
[   18.768210] ide0: ports already in use, skipping probe
[   18.869412] hdc: TSSTcorp DVD+/-RW TS-L632D, ATAPI CD/DVD-ROM drive
[   18.911524] ide1 at 0x170-0x177,0x376 on irq 15
[   18.925055] hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
[   18.937759] Uniform CD-ROM driver Revision: 3.20
[   18.952716] ide-floppy driver 0.99.newide
[   18.965625] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[   18.978452] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
[   18.991419] ata: 0x170 IDE port busy
[   18.991420] ata: conflict with ide1
[   19.017598] ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
[   19.030743] ata2: DUMMY
[   19.043517] scsi0 : ata_piix
[   19.065641] ata1.00: ATA-7, max UDMA/100, 192426570 sectors: LBA48 NCQ (depth 0/32)
[   19.078542] ata1.00: ata1: dev 0 multi count 8
[   19.091976] ata1.00: configured for UDMA/100
[   19.104354] scsi1 : ata_piix
[   19.116904] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS72101 MCZO PQ: 0 ANSI: 5
[   19.129334] SCSI device sda: 192426570 512-byte hdwr sectors (98522 MB)
[   19.141871] sda: Write Protect is off
[   19.154443] SCSI device sda: drive cache: write back
[   19.167042] SCSI device sda: 192426570 512-byte hdwr sectors (98522 MB)
[   19.179616] sda: Write Protect is off
[   19.192167] SCSI device sda: drive cache: write back
[   19.204671]  sda: sda1 sda2
[   19.234700] sd 0:0:0:0: Attached scsi disk sda
[   19.247478] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   19.260179] Initializing USB Mass Storage driver...
[   19.272915] usbcore: registered new interface driver usb-storage
[   19.285606] USB Mass Storage support registered.
[   19.298627] usbcore: registered new interface driver libusual
[   19.311450] usbcore: registered new interface driver hiddev
[   19.324157] usbcore: registered new interface driver usbhid
[   19.336631] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   19.349114] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   19.364610] serio: i8042 KBD port at 0x60,0x64 irq 1
[   19.377361] serio: i8042 AUX port at 0x60,0x64 irq 12
[   19.389924] mice: PS/2 mouse device common for all mice
[   19.402170] md: multipath personality registered for level -4
[   19.414514] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[   19.427341] device-mapper: multipath: version 1.0.5 loaded
[   19.440046] device-mapper: multipath round-robin: version 1.0.0 loaded
[   19.452486] device-mapper: multipath emc: version 0.0.3 loaded
[   19.464970] Bluetooth: Virtual HCI driver ver 1.2
[   19.477206] Bluetooth: Broadcom Blutonium firmware driver ver 1.0
[   19.489841] usbcore: registered new interface driver bcm203x
[   19.502114] Advanced Linux Sound Architecture Driver Version 1.0.13 (Fri Oct 06 18:28:19 2006 UTC).
[   21.290822] input: AT Translated Set 2 keyboard as /class/input/input0
[   19.528767] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
[   19.606110] ALSA device list:
[   19.618483]   #0: HDA Intel at 0xdfffc000 irq 21
[   19.630931] TCP cubic registered
[   19.642998] Initializing XFRM netlink socket
[   19.655167] NET: Registered protocol family 1
[   19.667486] NET: Registered protocol family 17
[   19.679659] Bluetooth: L2CAP ver 2.8
[   19.691485] Bluetooth: L2CAP socket layer initialized
[   19.703336] Bluetooth: SCO (Voice Link) ver 0.5
[   19.714879] Bluetooth: SCO socket layer initialized
[   19.726697] Bluetooth: RFCOMM socket layer initialized
[   19.738175] Bluetooth: RFCOMM TTY layer initialized
[   19.749474] Bluetooth: RFCOMM ver 1.8
[   19.760685] Bluetooth: BNEP (Ethernet Emulation) ver 1.2
[   19.772064] Bluetooth: BNEP filters: protocol multicast
[   19.783400] Bluetooth: HIDP (Human Interface Emulation) ver 1.1
[   19.794745] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   19.806100] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   19.818331] ACPI: (supports S0 S3 S4 S5)
[   19.830040] Freeing unused kernel memory: 328k freed
[   19.841624] Write protecting the kernel read-only data: 677k
[   20.039164] Synaptics Touchpad, model: 1, fw: 6.2, id: 0xfa0b1, caps: 0xa04713/0x200000
[   20.067762] input: SynPS/2 Synaptics TouchPad as /class/input/input1
[   22.160427] kjournald starting.  Commit interval 5 seconds
[   20.371798] EXT3-fs: mounted filesystem with ordered data mode.
[   20.943800] security:  3 users, 6 roles, 1481 types, 152 bools, 1 sens, 256 cats
[   20.954494] security:  58 classes, 43474 rules
[   20.966313] SELinux:  Completing initialization.
[   20.977080] SELinux:  Setting up existing superblocks.
[   20.997237] SELinux: initialized (dev dm-0, type ext3), uses xattr
[   21.174315] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[   21.185478] SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
[   21.196338] SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
[   21.206783] SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
[   21.217298] SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
[   23.016582] SELinux: initialized (dev devpts, type devpts), uses transition SIDs
[   23.026936] SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
[   21.248678] SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
[   21.259434] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[   21.270040] SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
[   21.281007] SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
[   21.291847] SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
[   21.302763] SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
[   23.102408] SELinux: initialized (dev proc, type proc), uses genfs_contexts
[   23.113149] SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
[   23.124071] SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
[   21.346402] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
[   21.358613] audit(1160676280.545:2): policy loaded auid=4294967295
[   22.019183] SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
[   23.630012] warning: process `date' used the removed sysctl system call
[ 1973.720096] audit(1160678235.563:3): dev=eth0 prom=256 old_prom=0 auid=4294967295
[ 1971.931488] do_IRQ: 0.65 No irq handler for vector
[ 1981.957878] NMI Watchdog detected LOCKUP on CPU 1
[ 1981.957892] CPU 1 
[ 1981.957908] Modules linked in: sunrpc asus_acpi lp parport_pc parport nvram joydev i2c_i801 i2c_core ehci_hcd ohci1394 ieee1394 uhci_hcd
[ 1981.957982] Pid: 0, comm: swapper Not tainted 2.6.19-rc1-fs2 #4
[ 1981.957991] RIP: 0010:[<ffffffff81161348>]  [<ffffffff81161348>] acpi_os_read_port+0x2d/0x48
[ 1981.958013] RSP: 0018:ffff810037e1bdb8  EFLAGS: 00000046
[ 1981.958020] RAX: 0000000000001c03 RBX: 0000000000000003 RCX: 0000000000000010
[ 1981.958030] RDX: 0000000000001004 RSI: ffff810037e1bdf4 RDI: 0000000000001004
[ 1981.958038] RBP: ffff810037e1bdc8 R08: ffff81007db7b960 R09: 000000007db7b900
[ 1981.958049] R10: 00007ffffbd56810 R11: 0000000000000246 R12: 0000000000000000
[ 1981.958057] R13: ffff810037e1be3c R14: 0000000000000000 R15: 0000000000000213
[ 1981.958067] FS:  0000000000000000(0000) GS:ffff81007debecc0(0000) knlGS:0000000000000000
[ 1981.958075] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 1981.958085] CR2: 00002b040cc17000 CR3: 0000000067fa8000 CR4: 00000000000006e0
[ 1981.958094] Process swapper (pid: 0, threadinfo ffff810037e1a000, task ffff810037e02100)
[ 1981.958190]  [<ffffffff8116ed63>] acpi_hw_low_level_read+0x36/0x60


--------------090808040103080903090909
Content-Type: text/plain;
 name="netconsole-3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netconsole-3.txt"

[    0.000000] Linux version 2.6.19-rc1-fs2 (sorenson@george.sorensonfamily.com) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #4 SMP PREEMPT Thu Oct 12 12:32:29 CDT 2006
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fed3400 (usable)
[    0.000000]  BIOS-e820: 000000007fed3400 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   523987
[    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 0000000000100000
[    0.000000] Built 1 zonelists.  Total pages: 515695
[    0.000000] Kernel command line: ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose nmi_watchdog=1 notsc netconsole=@172.31.0.101/,@64.62.190.123/00:0F:66:99:97:4F loglevel=6 3
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   12.763844] Console: colour dummy device 80x25
[   12.764869] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   12.765692] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   12.765859] Checking aperture...
[   12.796709] Memory: 2052256k/2095948k available (3202k kernel code, 43304k reserved, 1458k data, 328k init)
[   12.856726] Calibrating delay using timer specific routine.. 4330.64 BogoMIPS (lpj=2165320)
[   12.856851] Mount-cache hash table entries: 256
[   12.857041] using mwait in idle threads.
[   12.876954] enabled ExtINT on CPU#0
[   12.876958] ESR value after enabling vector: 00000000, after 00000040
[   12.877155] ENABLING IO-APIC IRQs
[   12.934048] result 10402908
[   14.730182] Initializing CPU#1
[   14.730379] masked ExtINT on CPU#1
[   14.789672] Calibrating delay using timer specific routine.. 4326.95 BogoMIPS (lpj=2163476)
[   14.790157] Intel(R) Core(TM)2 CPU         T7400  @ 2.16GHz stepping 06
[   14.839363] migration_cost=31
[   15.022656] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 11) *4
[   15.022947] ACPI: PCI Interrupt Link [LNKB] (IRQs *5 7)
[   15.023228] ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
[   15.023510] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 11) *3
[   15.023799] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[   15.024084] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   15.024371] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[   15.024677] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
[   15.064728] intel_rng: FWH not detected
[   15.064962] SCSI subsystem initialized
[   15.065225] 
[   15.097552] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   15.097735] TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
[   15.099548] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[   15.102254] audit(1160678537.508:1): initialized
[   15.102355] Total HugeTLB memory allocated, 0
[   15.102494] VFS: Disk quotas dquot_6.5.1
[   15.102518] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   15.102623] fuse init (API version 7.7)
[   15.109060] assign_interrupt_mode Found MSI capability
[   15.109218] assign_interrupt_mode Found MSI capability
[   15.109426] assign_interrupt_mode Found MSI capability
[   15.109649] assign_interrupt_mode Found MSI capability
[   15.109981] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.0
[   15.110044] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.1
[   15.110106] pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.3
[   15.152148] Console: switching to colour frame buffer device 160x64
[   15.216724] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
[   15.217357] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
[   15.218528] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
[   15.219152] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
[   15.249464] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
[   18.760068] ide0: I/O resource 0x1F0-0x1F7 not free.
[   18.771524] ide0: ports already in use, skipping probe
[   17.049447] hdc: TSSTcorp DVD+/-RW TS-L632D, ATAPI CD/DVD-ROM drive
[   17.090870] ide1 at 0x170-0x177,0x376 on irq 15
[   17.106756] ide-floppy driver 0.99.newide
[   17.118679] ata: 0x170 IDE port busy
[   17.118680] ata: conflict with ide1
[   17.149371] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS72101 MCZO PQ: 0 ANSI: 5
[   17.160143] SCSI device sda: 192426570 512-byte hdwr sectors (98522 MB)
[   17.171027] sda: Write Protect is off
[   17.182042] SCSI device sda: drive cache: write back
[   17.192902] SCSI device sda: 192426570 512-byte hdwr sectors (98522 MB)
[   17.203609] sda: Write Protect is off
[   18.998025] SCSI device sda: drive cache: write back
[   17.241954] sd 0:0:0:0: Attached scsi disk sda
[   17.252306] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   17.407853] hda_intel: azx_get_response timeout, switching to polling mode...
[   17.425053] Write protecting the kernel read-only data: 677k
[   19.653029] audit(1160678546.743:2): policy loaded auid=4294967295
[   79.097281] audit(1160678605.629:3): dev=eth0 prom=256 old_prom=0 auid=4294967295
[  178.402790] do_IRQ: 0.65 No irq handler for vector
[  183.545101] NMI Watchdog detected LOCKUP on CPU 0
[  183.545121] CPU 0 
[  183.545133] Modules linked in: sunrpc asus_acpi lp parport_pc parport nvram i2c_i801 joydev i2c_core ohci1394 ieee1394 ehci_hcd uhci_hcd
[  183.545202] Pid: 0, comm: swapper Not tainted 2.6.19-rc1-fs2 #4
[  183.545211] RIP: 0010:[<ffffffff81183dbc>]  [<ffffffff81183dbc>] acpi_processor_idle+0x259/0x48d
[  183.545231] RSP: 0018:ffffffff814a1f18  EFLAGS: 00000097
[  183.545238] RAX: 000000000052573a RBX: 0000000000000001 RCX: 0000000000001008
[  183.545247] RDX: 0000000000001016 RSI: 0000000000000013 RDI: 0000000000000000
[  183.545256] RBP: ffffffff814a1f68 R08: ffff81007db44d00 R09: 000000007db44d60
[  183.545265] R10: 0000000000000000 R11: 0000000000000246 R12: ffff81007db44d60
[  183.545273] R13: 000000000052573a R14: ffff81007db44c00 R15: 0000000000000000
[  183.545283] FS:  0000000000000000(0000) GS:ffffffff8148e000(0000) knlGS:0000000000000000
[  183.545292] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[  183.545301] CR2: 00007fffe4584418 CR3: 0000000077d67000 CR4: 00000000000006e0
[  183.545310] Process swapper (pid: 0, threadinfo ffffffff814a0000, task ffffffff813d1420)
[  183.545318] Stack: Bootdata ok (command line is ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose nmi_watchdog=1 notsc netconsole=@172.31.0.101/,@64.62.190.123/00:0F:66:99:97:4F)


--------------090808040103080903090909--
