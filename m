Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSKIRHZ>; Sat, 9 Nov 2002 12:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSKIRHZ>; Sat, 9 Nov 2002 12:07:25 -0500
Received: from vmail.mclink.it ([195.110.128.11]:9485 "EHLO vmail.mclink.it")
	by vger.kernel.org with ESMTP id <S261337AbSKIRHO>;
	Sat, 9 Nov 2002 12:07:14 -0500
Message-ID: <3DCD5073.7050201@arpacoop.it>
Date: Sat, 09 Nov 2002 19:14:11 +0100
From: Carlo Scarfoglio <scarfoglio@arpacoop.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021108
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PDC20276 driver not working in kernel 2.5.46
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to say that the two disks connected to my Asus A7V board with 
integrated Promise 20276 controller are not detected on boot (the driver 
is loaded and says everything is OK) and are not usable with kernel 
2.5.46. Kernel 2.5.34 works. SuSE 8.0 pretty standard.
See the two boot.msg below for more info.

TIA
	Carlo Scarfoglio



This is kernel 2.5.34 boot.msg
Inspecting /boot/System.map
Symbol table has incorrect version number.

Cannot find map file.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
0:58:29 CEST 2002
<4>Video mode to be used for restore is ffff
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
<4> BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
<4> BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
<4> BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>511MB LOWMEM available.
<4>On node 0 totalpages: 131068
<4>  DMA zone: 4096 pages
<4>  Normal zone: 126972 pages
<4>  HighMem zone: 0 pages
<6>ACPI: RSDP (v000 ASUS                       ) @ 0x000f5e30
<6>ACPI: RSDT (v001 ASUS   A7V333   16944.11825) @ 0x1fffc000
<6>ACPI: FADT (v001 ASUS   A7V333   16944.11825) @ 0x1fffc0b2
<6>ACPI: BOOT (v001 ASUS   A7V333   16944.11825) @ 0x1fffc030
<6>ACPI: MADT (v001 ASUS   A7V333   16944.11825) @ 0x1fffc058
<6>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
<4>Processor #0 6:6 APIC version 16
<6>ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
<6>ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
<6>IOAPIC[0]: Assigned apic_id 2
<4>IOAPIC[0]: apic_id 2, version 2, address 0xfec00000, IRQ 0-23
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] 
trigger[0x1])
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] 
trigger[0x3])
<6>Using ACPI (MADT) for SMP configuration information
<4>Kernel command line: auto BOOT_IMAGE=linux2534 ro root=301
<6>Initializing CPU#0
<4>Detected 1532.808 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 3014.65 BogoMIPS
<4>Memory: 515204k/524272k available (2173k kernel code, 8672k reserved, 
755k data, 296k init, 0k highmem)
<6>Security Scaffold v1.0.0 initialized
<4>Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<7>CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 256K (64 bytes/line)
<7>CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<6>Machine check exception polling timer started.
<7>CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
<7>CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
<4>CPU: AMD Athlon(TM) XP 1800+ stepping 02
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>ENABLING IO-APIC IRQs
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 
2-23 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=0
<7>number of MP IRQ sources: 16.
<7>number of IO-APIC #2 registers: 24.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.... register #01: 00178002
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 1
<7>.......     : IO APIC version: 0002
<4> WARNING: unexpected IO-APIC, please mail
<4>          to linux-smp@vger.kernel.org
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 001 01  0    0    0   0   0    1    1    39
<7> 02 001 01  0    0    0   0   0    1    1    31
<7> 03 001 01  0    0    0   0   0    1    1    41
<7> 04 001 01  0    0    0   0   0    1    1    49
<7> 05 001 01  0    0    0   0   0    1    1    51
<7> 06 001 01  0    0    0   0   0    1    1    59
<7> 07 001 01  0    0    0   0   0    1    1    61
<7> 08 001 01  0    0    0   0   0    1    1    69
<7> 09 001 01  1    1    0   1   0    1    1    71
<7> 0a 001 01  0    0    0   0   0    1    1    79
<7> 0b 001 01  0    0    0   0   0    1    1    81
<7> 0c 001 01  0    0    0   0   0    1    1    89
<7> 0d 001 01  0    0    0   0   0    1    1    91
<7> 0e 001 01  0    0    0   0   0    1    1    99
<7> 0f 001 01  0    0    0   0   0    1    1    A1
<7> 10 000 00  1    0    0   0   0    0    0    00
<7> 11 000 00  1    0    0   0   0    0    0    00
<7> 12 000 00  1    0    0   0   0    0    0    00
<7> 13 000 00  1    0    0   0   0    0    0    00
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<6>.................................... done.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 1532.0661 MHz.
<4>..... host bus clock speed is 266.0549 MHz.
<4>cpu: 0, clocks: 266549, slice: 133274
<4>CPU0<T0:266544,T1:133264,D:6,S:133274,C:266549>
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>PCI: PCI BIOS revision 2.10 entry at 0xf1aa0, last bus=1
<6>PCI: Using configuration type 1
<6>ACPI: Subsystem revision 20020829
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: System [ACPI] (supports S0 S1 S4 S5)
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14, enabled 
at IRQ 9)
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
<6>usb.c: registered new driver usbfs
<6>usb.c: registered new driver hub
<7>IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17)
<7>00:00:05[A] -> 2-17 -> vector 0xa9 -> IRQ 17
<7>IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18)
<7>00:00:05[B] -> 2-18 -> vector 0xb1 -> IRQ 18
<7>IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19)
<7>00:00:06[A] -> 2-19 -> vector 0xb9 -> IRQ 19
<7>Pin 2-17 already programmed
<7>Pin 2-19 already programmed
<7>IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16)
<7>00:00:0c[B] -> 2-16 -> vector 0xc1 -> IRQ 16
<7>Pin 2-17 already programmed
<7>Pin 2-18 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-17 already programmed
<7>Pin 2-18 already programmed
<7>Pin 2-19 already programmed
<7>Pin 2-17 already programmed
<7>Pin 2-18 already programmed
<7>Pin 2-19 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-18 already programmed
<7>Pin 2-19 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-17 already programmed
<7>Pin 2-19 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-17 already programmed
<7>Pin 2-18 already programmed
<7>IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21)
<7>00:00:11[D] -> 2-21 -> vector 0xc9 -> IRQ 21
<7>Pin 2-19 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-17 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-17 already programmed
<4>PCI: No IRQ known for interrupt pin A of device 00:11.1<6>PCI: Using 
ACPI for IRQ routing
<6>PCI: if you experience problems, try using option 'pci=noacpi'
<6>SBF: Simple Boot Flag extension found and enabled.
<6>SBF: Setting boot flags 0x1
<6>apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
<5>apm: overridden by ACPI.
<4>Starting kswapd
<4>BIO: pool of 256 setup, 14Kb (56 bytes/bio)
<4>biovec: init pool 0, 1 entries, 12 bytes
<4>biovec: init pool 1, 4 entries, 48 bytes
<4>biovec: init pool 2, 16 entries, 192 bytes
<4>biovec: init pool 3, 64 entries, 768 bytes
<4>biovec: init pool 4, 128 entries, 1536 bytes
<4>biovec: init pool 5, 256 entries, 3072 bytes
<5>aio_setup: sizeof(struct page) = 40
<6>NTFS driver 2.1.0 [Flags: R/O].
<6>Capability LSM initialized
<6>PCI: Via IRQ fixup for 00:11.2, from 9 to 5
<6>PCI: Via IRQ fixup for 00:11.3, from 9 to 5
<6>Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
<4>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<6>parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
<6>parport0: irq 7 detected
<7>parport0: cpp_mux: aa55f00f52ad51(86)
<7>parport0: cpp_daisy: aa5500ff(38)
<7>parport0: assign_addrs: aa5500ff(38)
<7>parport0: cpp_mux: aa55f00f52ad51(86)
<7>parport0: cpp_daisy: aa5500ff(30)
<7>parport0: assign_addrs: aa5500ff(30)
<6>i2c-core.o: i2c core module version 2.6.4 (20020719)
<6>i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
<7>i2c-core.o: driver i2c-dev dummy driver registered.
<6>i2c-algo-bit.o: i2c bit algorithm module version 2.6.4 (20020719)
<6>i2c-proc.o version 2.6.4 (20020719)
<4>pty: 256 Unix98 ptys configured
<6>lp0: using parport0 (polling).
<6>Real Time Clock Driver v1.11
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 439M
<6>agpgart: Detected Via Apollo Pro KT266 chipset
<6>agpgart: AGP aperture is 128M @ 0xe0000000
<6>[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 128MB
<6>[drm] Initialized mga 3.0.2 20010321 on minor 0
<4>block: 256 slots per queue, batch=32
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>loop: loaded (max 8 devices)
<6>PPP generic driver version 2.4.2
<6>PPP Deflate Compression module registered
<6>PPP BSD Compression module registered
<6>8139too Fast Ethernet driver 0.9.26
<6>eth0: RealTek RTL8139 Fast Ethernet at 0xe082f000, 00:10:a7:14:6f:68, 
IRQ 17
<7>eth0:  Identified 8139 chip type 'RTL-8139C'
<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
<4>PDC20276: IDE controller on PCI bus 00 dev 30
<4>PDC20276: chipset revision 1
<4>PDC20276: not 100%% native mode: will probe irqs later
<4>    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
<4>    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
<4>VP_IDE: IDE controller on PCI bus 00 dev 89
<4>PCI: No IRQ known for interrupt pin A of device 00:11.1VP_IDE: 
chipset revision 6
<4>VP_IDE: not 100%% native mode: will probe irqs later
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
<6>VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
<4>    ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
<4>hda: IC35L040AVVA07-0, ATA DISK drive
<4>blk: queue c0464884, I/O limit 4095Mb (mask 0xffffffff)
<4>hdc: IBM-DHEA-38451, ATA DISK drive
<4>blk: queue c0464c48, I/O limit 4095Mb (mask 0xffffffff)
<4>hde: IBM-DPTA-372050, ATA DISK drive
<4>blk: queue c046500c, I/O limit 4095Mb (mask 0xffffffff)
<4>hdh: IBM-DTLA-307045, ATA DISK drive
<4>blk: queue c046554c, I/O limit 4095Mb (mask 0xffffffff)
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide2 at 0xd400-0xd407,0xd002 on irq 19
<4>ide3 at 0xb800-0xb807,0xb402 on irq 19
<4>hdh: host protected area => 1
<6>hdh: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, 
UDMA(100)
<6> hdh: hdh1 hdh2
<4>hde: host protected area => 1
<6>hde: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=39770/16/63, 
UDMA(66)
<6> hde: hde1 hde2
<6>hdc: 16514064 sectors (8455 MB) w/472KiB Cache, CHS=16383/16/63, UDMA(33)
<6> hdc: hdc1 < >
<4>hda: host protected area => 1
<6>hda: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=5005/255/63, 
UDMA(100)
<6> hda: hda1 hda2 hda3
<6>SCSI subsystem driver Revision: 1.00
<4>ahc_pci:0:13:0: Host Adapter Bios disabled.  Using default SCSI 
device parameters
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
<4>        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
<4>        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
<4>
<4>(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
<5>  Vendor: SCSI-CD   Model: ReWritable-2x2x6  Rev: 2.00
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
<5>  Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
<4>Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
<4>Attached scsi CD-ROM sr1 at scsi0, channel 0, id 3, lun 0
<4>sr0: scsi3-mmc drive: 2x/6x writer cd/rw xa/form2 cdda tray
<6>Uniform CD-ROM driver Revision: 3.12
<4>sr1: scsi3-mmc drive: 2x/6x xa/form2 cdda tray
<6>uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
<6>hcd-pci.c: uhci-hcd @ 00:11.2, VIA Technologies, Inc. USB
<6>hcd-pci.c: irq 21, io base 00009400
<6>hcd.c: new USB bus registered, assigned bus number 1
<6>hub.c: USB hub found at 0
<6>hub.c: 2 ports detected
<6>hcd-pci.c: uhci-hcd @ 00:11.3, VIA Technologies, Inc. USB (#2)
<6>hcd-pci.c: irq 21, io base 00009000
<6>hcd.c: new USB bus registered, assigned bus number 2
<6>hub.c: USB hub found at 0
<6>hub.c: 2 ports detected
<6>usb.c: registered new driver usblp
<6>usblp.c: v0.12: USB Printer Device Class driver
<6>Initializing USB Mass Storage driver...
<6>usb.c: registered new driver usb-storage
<6>USB Mass Storage support registered.
<6>usb.c: registered new driver hiddev
<6>usb.c: registered new driver hid
<6>hid-core.c: v2.0:USB HID core driver
<7>register interface 'mouse' with class 'input
<6>mice: PS/2 mouse device common for all mice
<7>register interface 'event' with class 'input
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>input: AT Set 2 Extended keyboard on isa0060/serio0
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>Advanced Linux Sound Architecture Driver Version 0.9.0rc2 (Wed Jun 19 
08:56:25 2002 UTC).
<3>request_module[snd-card-0]: not ready
<3>request_module[snd-card-1]: not ready
<3>request_module[snd-card-2]: not ready
<3>request_module[snd-card-3]: not ready
<3>request_module[snd-card-4]: not ready
<3>request_module[snd-card-5]: not ready
<3>request_module[snd-card-6]: not ready
<3>request_module[snd-card-7]: not ready
<6>ALSA device list:
<6>  #0: C-Media PCI CMI8738-MC6 (model 55) at 0xd800, irq 17
<6>  #1: Ensoniq AudioPCI ES1371 at 0xa000, irq 18
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<6>TCP: Hash tables configured (established 32768 bind 32768)
<4>ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per 
conntrack
<4>ip_tables: (C) 2000-2002 Netfilter core team
<4>arp_tables: (C) 2002 David S. Miller
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<3>request_module[nls_iso8859-1]: not ready
<4>Unable to load NLS charset iso8859-1
<4>found reiserfs format "3.6" with standard journal
<6>hub.c: new USB device 00:11.2-2, assigned address 2
<6>input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse ® with 
IntelliEye] on usb-00:11.2-2
<4>Reiserfs journal params: device ide0(3,1), size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
<4>reiserfs: checking transaction log (ide0(3,1)) for (ide0(3,1))
<4>Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<4>Freeing unused kernel memory: 296k freed
<6>Adding 1052248k swap on /dev/hda2.  Priority:42 extents:1
<4>found reiserfs format "3.6" with standard journal
<4>Reiserfs journal params: device ide0(3,3), size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
<4>reiserfs: checking transaction log (ide0(3,3)) for (ide0(3,3))
<4>Using r5 hash to sort names
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.


Kernel 2.5.46 boot.msg
Inspecting /boot/System.map
Symbol table has incorrect version number.

Cannot find map file.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
RQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<6>.................................... done.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 1532.0661 MHz.
<4>..... host bus clock speed is 266.0549 MHz.
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>mtrr: v2.0 (20020519)
<6>Linux Plug and Play Support v0.9 (c) Adam Belay
<6>PCI: PCI BIOS revision 2.10 entry at 0xf1aa0, last bus=1
<6>PCI: Using configuration type 1
<7>Registering system device cpu0
<7>adding 'CPU 0' to cpu class interfaces
<4>BIO: pool of 256 setup, 15Kb (60 bytes/bio)
<4>biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
<4>biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
<4>biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
<4>biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
<4>biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
<4>biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
<6>ACPI: Subsystem revision 20021101
<4>    ACPI-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14, enabled 
at IRQ 9)
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
<4>block request queues:
<4> 128 requests per read queue
<4> 128 requests per write queue
<4> 8 requests per batch
<4> enter congestion at 31
<4> exit congestion at 33
<6>PnPBIOS: Found PnP BIOS installation structure at 0xc00f9c60
<6>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9c90, dseg 0xf0000
<6>pnp: 00:11: ioport range 0x290-0x297 has been reserved
<6>pnp: 00:11: ioport range 0x3f0-0x3f1 has been reserved
<6>pnp: 00:11: ioport range 0xe400-0xe47f has been reserved
<6>pnp: 00:11: ioport range 0xec00-0xec3f has been reserved
<6>PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>drivers/usb/core/usb.c: registered new driver usbfs
<6>drivers/usb/core/usb.c: registered new driver hub
<7>IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17)
<7>00:00:05[A] -> 2-17 -> IRQ 17
<7>IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18)
<7>00:00:05[B] -> 2-18 -> IRQ 18
<7>IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19)
<7>00:00:06[A] -> 2-19 -> IRQ 19
<7>Pin 2-17 already programmed
<7>Pin 2-19 already programmed
<7>IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16)
<7>00:00:0c[B] -> 2-16 -> IRQ 16
<7>Pin 2-17 already programmed
<7>Pin 2-18 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-17 already programmed
<7>Pin 2-18 already programmed
<7>Pin 2-19 already programmed
<7>Pin 2-17 already programmed
<7>Pin 2-18 already programmed
<7>Pin 2-19 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-18 already programmed
<7>Pin 2-19 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-17 already programmed
<7>Pin 2-19 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-17 already programmed
<7>Pin 2-18 already programmed
<7>IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21)
<7>00:00:11[D] -> 2-21 -> IRQ 21
<7>Pin 2-19 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-17 already programmed
<7>Pin 2-16 already programmed
<7>Pin 2-17 already programmed
<4>ACPI: No IRQ known for interrupt pin A of device 00:11.1<6>PCI: Using 
ACPI for IRQ routing
<6>PCI: if you experience problems, try using option 'pci=noacpi' or 
even 'acpi=off'
<7>Registering system device pic0
<7>Registering system device rtc0
<6>SBF: Simple Boot Flag extension found and enabled.
<6>SBF: Setting boot flags 0x1
<6>apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
<5>apm: overridden by ACPI.
<6>slab: reap timer started for cpu 0
<4>Starting kswapd
<5>aio_setup: sizeof(struct page) = 40
<6>[dff8e040] eventpoll: driver installed.
<6>Capability LSM initialized
<6>Initializing Cryptographic API
<4>
<4>testing md5
<4>test 1:
<4>d41d8cd98f00b204e9800998ecf8427e
<4>pass
<4>test 2:
<4>0cc175b9c0f1b6a831c399e269772661
<4>pass
<4>test 3:
<4>900150983cd24fb0d6963f7d28e17f72
<4>pass
<4>test 4:
<4>f96b697d7cb7938d525a2f31aaf161d0
<4>pass
<4>test 5:
<4>c3fcd3d76192e4007dfb496cca67e13b
<4>pass
<4>test 6:
<4>d174ab98d277d9f5a5611c2c9f419d9f
<4>pass
<4>test 7:
<4>57edf4a22be3c955ac49da2e2107b67a
<4>pass
<4>
<4>testing md5 across pages
<4>c3fcd3d76192e4007dfb496cca67e13b
<4>pass
<4>
<4>testing hmac_md5
<4>test 1:
<4>9294727a3638bb1c13f48ef8158bfc9d
<4>pass
<4>test 2:
<4>750c783e6ab0b503eaa86e310a5db738
<4>pass
<4>test 3:
<4>56be34521d144c88dbb8c733f0e8b3f6
<4>pass
<4>test 4:
<4>697eaf0aca3a3aea3a75164746ffaa79
<4>pass
<4>test 5:
<4>56461ef2342edc00f9bab995690efd4c
<4>pass
<4>test 6:
<4>6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd
<4>pass
<4>test 7:
<4>6f630fad67cda0ee1fb1f562db3aa53e
<4>pass
<4>
<4>testing hmac_md5 across pages
<4>750c783e6ab0b503eaa86e310a5db738
<4>pass
<4>
<4>testing sha1
<4>test 1:
<4>a9993e364706816aba3e25717850c26c9cd0d89d
<4>pass
<4>test 2:
<4>84983e441c3bd26ebaae4aa1f95129e5e54670f1
<4>pass
<4>
<4>testing sha1 across pages
<4>84983e441c3bd26ebaae4aa1f95129e5e54670f1
<4>pass
<4>
<4>testing hmac_sha1
<4>test 1:
<4>b617318655057264e28bc0b6fb378c8ef146be00
<4>pass
<4>test 2:
<4>effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
<4>pass
<4>test 3:
<4>125d7342b9ac11cd91a39af48aa17b4f63f175d3
<4>pass
<4>test 4:
<4>4c9007f4026250c6bc8414f9bf50c86c2d7235da
<4>pass
<4>test 5:
<4>4c1a03424b55e07fe7f27be1d58bb9324a9a5a04
<4>pass
<4>test 6:
<4>aa4ae5e15272d00e95705637ce8a3b55ed402112
<4>pass
<4>test 7:
<4>e8e99d0f45237d786d6bbaa7965c7808bbff1a91
<4>pass
<4>
<4>testing hmac_sha1 across pages
<4>effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
<4>pass
<4>
<4>testing des encryption
<4>test 1:
<4>c95744256a5ed31d
<4>pass
<4>test 2:
<4>f79c892a338f4a8b
<4>pass
<4>test 3:
<4>690f5b0d9a26939b
<4>pass
<4>test 4:
<4>c95744256a5ed31df79c892a338f4a8bb49926f71fe1d490
<4>pass
<4>test 5:
<4>setkey() failed flags=100100
<4>c95744256a5ed31d
<4>pass
<4>
<4>testing des ecb encryption across pages
<4>0123456789abcdef
<4>page 1
<4>c95744256a5ed31d
<4>pass
<4>page 2
<4>f79c892a338f4a8b
<4>pass
<4>
<4>testing des ecb encryption chunking scenario A
<4>page 1
<4>c95744256a5ed31df79c892a338f
<4>pass
<4>page 2
<4>4a8bb49926f71fe1d490
<4>pass
<4>page 3
<4>f79c892a338f4a8b
<4>pass
<4>
<4>testing des ecb encryption chunking scenario B
<4>page 1
<4>c957
<4>pass
<4>page 2
<4>44
<4>pass
<4>page 3
<4>256a5e
<4>pass
<4>page 4
<4>d31df79c892a338f4a8bb49926f71fe1d490
<4>pass
<4>
<4>testing des ecb encryption chunking scenario C
<4>page 1
<4>c957
<4>pass
<4>page 2
<4>4425
<4>pass
<4>page 3
<4>6a5e
<4>pass
<4>page 4
<4>d31d
<4>pass
<4>page 5
<4>f79c892a338f4a8b
<4>pass
<4>
<4>testing des ecb encryption chunking scenario D (atomic)
<4>c95744256a5ed31d
<4>pass
<4>
<4>testing des decryption
<4>test 1:
<4>0123456789abcde7
<4>pass
<4>test 2:
<4>01a1d6d039776742
<4>pass
<4>
<4>testing des ecb decryption across pages
<4>page 1
<4>0123456789abcde7
<4>pass
<4>page 2
<4>2233445566778899
<4>pass
<4>
<4>testing des ecb decryption chunking scenario E
<4>page 1
<4>012345
<4>pass
<4>page 2
<4>6789abcde7a3997bcaaf69a0
<4>pass
<4>page 3
<4>f5
<4>pass
<4>
<4>testing des cbc encryption (atomic)
<4>test 1:
<4>ccd173ffab2039f4acd8aefddfd8a1eb468e91157888ba68
<4>pass
<4>test 2:
<4>e5c7cdde872bf27c
<4>pass
<4>test 3:
<4>43e934008c389c0f
<4>pass
<4>test 4:
<4>683788499a7c05f6
<4>pass
<4>
<4>testing des cbc encryption chunking scenario F
<4>page 1
<4>ccd173ffab2039f4acd8aefddf
<4>pass
<4>page 2
<4>d8a1eb468e91157888ba68
<4>pass
<4>
<4>testing des cbc decryption
<4>test 1:
<4>e5c7cdde872bf27c
<4>4e6f772069732074
<4>pass
<4>test 2:
<4>43e934008c389c0f
<4>68652074696d6520
<4>pass
<4>test 3:
<4>683788499a7c05f6
<4>666f7220616c6c20
<4>pass
<4>
<4>testing des cbc decryption chunking scenario G
<4>page 1
<4>666f7220
<4>pass
<4>page 2
<4>616c6c20
<4>pass
<4>
<4>testing des3 ede encryption
<4>test 1:
<4>18d748e563620572
<4>pass
<4>test 2:
<4>c07d2a0fa566fa30
<4>pass
<4>test 3:
<4>e1ef62c332fe825b
<4>pass
<4>
<4>testing des3 ede decryption
<4>test 1:
<4>736f6d6564617461
<4>pass
<4>test 2:
<4>7371756967676c65
<4>pass
<4>test 3:
<4>0000000000000000
<4>pass
<4>
<4>testing md4
<4>test 1:
<4>31d6cfe0d16ae931b73c59d7e0c089c0
<4>pass
<4>test 2:
<4>bde52cb31de33e46245e05fbdbd6fb24
<4>pass
<4>test 3:
<4>a448017aaf21d8525fc10ae87aa6729d
<4>pass
<4>test 4:
<4>d9130a8164549fe818874806e1c7014b
<4>pass
<4>test 5:
<4>d79e1c308aa5bbcdeea8ed63df412da9
<4>pass
<4>test 6:
<4>043f8582f241db351ce627e153e7f0e4
<4>pass
<4>test 7:
<4>e33b4ddc9c38f2199c3e7b164fcc0536
<4>pass
<6>PCI: Via IRQ fixup for 00:11.2, from 9 to 5
<6>PCI: Via IRQ fixup for 00:11.3, from 9 to 5
<6>Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
<4>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<4>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<6>parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
<6>parport0: irq 7 detected
<7>parport0: cpp_mux: aa55f00f52ad51(86)
<7>parport0: cpp_daisy: aa5500ff(38)
<7>parport0: assign_addrs: aa5500ff(38)
<7>parport0: cpp_mux: aa55f00f52ad51(86)
<7>parport0: cpp_daisy: aa5500ff(38)
<7>parport0: assign_addrs: aa5500ff(30)
<6>i2c-core.o: i2c core module version 2.6.4 (20020719)
<6>i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
<6>i2c-algo-bit.o: i2c bit algorithm module version 2.6.4 (20020719)
<6>i2c-proc.o version 2.6.4 (20020719)
<4>pty: 256 Unix98 ptys configured
<6>lp0: using parport0 (polling).
<6>Real Time Clock Driver v1.11
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 439M
<6>agpgart: Detected Via Apollo Pro KT266 chipset
<6>agpgart: AGP aperture is 128M @ 0xe0000000
<6>[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe0000000 128MB
<6>[drm] Initialized mga 3.0.2 20010321 on minor 0
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>loop: loaded (max 8 devices)
<6>PPP generic driver version 2.4.2
<6>PPP Deflate Compression module registered
<6>PPP BSD Compression module registered
<6>8139too Fast Ethernet driver 0.9.26
<6>eth0: RealTek RTL8139 Fast Ethernet at 0xe0806000, 00:10:a7:14:6f:68, 
IRQ 17
<7>eth0:  Identified 8139 chip type 'RTL-8139C'
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
<6>PDC20276: IDE controller at PCI slot 00:06.0
<6>PDC20276: chipset revision 1
<6>PDC20276: not 100%% native mode: will probe irqs later
<6>PDC20276: neither IDE port enabled (BIOS)
<6>VP_IDE: IDE controller at PCI slot 00:11.1
<4>ACPI: No IRQ known for interrupt pin A of device 00:11.1<6>VP_IDE: 
chipset revision 6
<6>VP_IDE: not 100%% native mode: will probe irqs later
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
<6>VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
<4>    ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
<4>hda: IC35L040AVVA07-0, ATA DISK drive
<4>hda: DMA disabled
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>hdc: IBM-DHEA-38451, ATA DISK drive
<4>hdc: DMA disabled
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>hda: host protected area => 1
<6>hda: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=5005/255/63, 
UDMA(100)
<6> hda: hda1 hda2 hda3
<6>hdc: 16514064 sectors (8455 MB) w/472KiB Cache, CHS=16383/16/63, UDMA(33)
<6> hdc: hdc1 < >
<6>SCSI subsystem driver Revision: 1.00
<4>ahc_pci:0:13:0: Host Adapter Bios disabled.  Using default SCSI 
device parameters
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
<4>        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
<4>        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
<4>
<4>(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
<5>  Vendor: SCSI-CD   Model: ReWritable-2x2x6  Rev: 2.00
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
<5>  Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
<4>sr0: scsi3-mmc drive: 2x/6x writer cd/rw xa/form2 cdda tray
<6>Uniform CD-ROM driver Revision: 3.12
<4>Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
<4>sr1: scsi3-mmc drive: 2x/6x cd/rw xa/form2 cdda tray
<4>Attached scsi CD-ROM sr1 at scsi0, channel 0, id 3, lun 0
<6>drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.0
<6>drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:11.2, VIA Technologies, 
Inc. USB
<6>drivers/usb/core/hcd-pci.c: irq 21, io base 00009400
<6>drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
<6>drivers/usb/core/hub.c: USB hub found at 0
<6>drivers/usb/core/hub.c: 2 ports detected
<6>drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:11.3, VIA Technologies, 
Inc. USB (#2)
<6>drivers/usb/core/hcd-pci.c: irq 21, io base 00009000
<6>drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 2
<6>drivers/usb/core/hub.c: USB hub found at 0
<6>drivers/usb/core/hub.c: 2 ports detected
<6>drivers/usb/core/usb.c: registered new driver usblp
<6>drivers/usb/class/usblp.c: v0.12: USB Printer Device Class driver
<6>Initializing USB Mass Storage driver...
<6>drivers/usb/core/usb.c: registered new driver usb-storage
<6>USB Mass Storage support registered.
<6>drivers/usb/core/usb.c: registered new driver hiddev
<6>drivers/usb/core/usb.c: registered new driver hid
<6>drivers/usb/input/hid-core.c: v2.0:USB HID core driver
<7>register interface 'mouse' with class 'input
<6>mice: PS/2 mouse device common for all mice
<7>register interface 'event' with class 'input
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>input: AT Set 2 keyboard on isa0060/serio0
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>i2c-core.o: i2c core module version 2.6.4 (20020719)
<6>i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
<6>i2c-proc.o version 2.6.4 (20020719)
<6>Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Tue Oct 29 
09:19:27 2002 UTC).
<3>request_module[snd-card-0]: not ready
<3>request_module[snd-card-1]: not ready
<3>request_module[snd-card-2]: not ready
<3>request_module[snd-card-3]: not ready
<3>request_module[snd-card-4]: not ready
<3>request_module[snd-card-5]: not ready
<3>request_module[snd-card-6]: not ready
<3>request_module[snd-card-7]: not ready
<6>ALSA device list:
<6>  #0: C-Media PCI CMI8738-MC6 (model 55) at 0xd800, irq 17
<6>  #1: Ensoniq AudioPCI ES1371 at 0xa000, irq 18
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<6>TCP: Hash tables configured (established 32768 bind 32768)
<4>ip_conntrack version 2.1 (4095 buckets, 32760 max) - 296 bytes per 
conntrack
<4>ip_tables: (C) 2000-2002 Netfilter core team
<4>arp_tables: (C) 2002 David S. Miller
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>found reiserfs format "3.6" with standard journal
<6>drivers/usb/core/hub.c: new USB device 00:11.2-2, assigned address 2
<6>input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse ® with 
IntelliEye] on usb-00:11.2-2
<4>Reiserfs journal params: device ide0(3,1), size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
<4>reiserfs: checking transaction log (ide0(3,1)) for (ide0(3,1))
<4>Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<6>Freeing unused kernel memory: 312k freed
<6>Adding 1052248k swap on /dev/hda2.  Priority:42 extents:1
<4>found reiserfs format "3.6" with standard journal
<4>Reiserfs journal params: device ide0(3,3), size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
<4>reiserfs: checking transaction log (ide0(3,3)) for (ide0(3,3))
<4>Using r5 hash to sort names
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

