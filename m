Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129436AbQK3NJY>; Thu, 30 Nov 2000 08:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129555AbQK3NJP>; Thu, 30 Nov 2000 08:09:15 -0500
Received: from pop.gmx.net ([194.221.183.20]:44822 "HELO mail.gmx.net")
        by vger.kernel.org with SMTP id <S129436AbQK3NJA>;
        Thu, 30 Nov 2000 08:09:00 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Thu, 30 Nov 2000 13:36:32 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12-pre3: kernel: APIC error on CPU0: 08(00)  /Gigabyte GA-586DX  SMP_BOARD
MIME-Version: 1.0
Message-Id: <00113013363200.03911@nmb>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

following errors come when running 2.4.0-test12-pre3 on my Gigabyte GA-586DX  
SMP_BOARD. Theses errors also appear with 2.4.0-test11 ind prior.
Running with 2.2.16 / 2.2.17 no such errors appear:

Nov 30 11:33:46 nmb kernel: APIC error on CPU0: 08(00)
Nov 30 11:34:09 nmb kernel: APIC error on CPU0: 02(00)
Nov 30 11:34:16 nmb kernel: APIC error on CPU0: 08(00)
Nov 30 11:34:21 nmb kernel: APIC error on CPU0: 02(00)
Nov 30 11:34:30 nmb kernel: APIC error on CPU0: 01(00)
Nov 30 11:34:36 nmb kernel: APIC error on CPU0: 02(00)
Nov 30 11:34:30 nmb kernel: APIC error on CPU0: 01(00)
Nov 30 11:34:31 nmb kernel: APIC error on CPU0: 02(00)
Nov 30 11:36:05 nmb kernel: APIC error on CPU0: 04(00)

hope this will be helpful for you....

kind regards

Norbert


================ cat boot.msg ====================================
Inspecting /boot/System.map-2.2.16-NB
Loaded 7901 symbols from /boot/System.map-2.2.16-NB.
Symbols match kernel version 2.2.16.
Loaded 7 symbols from 1 module.
klogd 1.3-3, log source = ksyslog started.
<4>Linux version 2.2.16-NB (root@nmb) (gcc version 2.95.2 19991024 (release)) 
#1 SMP Sun Nov 26 20:36:48 CET 2000
<4>Intel MultiProcessor Specification v1.1
<4>    Virtual Wire compatibility mode.
<4>OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
<4>Processor #0 Pentium(tm) APIC version 17
<4>Processor #1 Pentium(tm) APIC version 17
<4>I/O APIC #2 Version 17 at 0xFEC00000.
<4>Processors: 2
<4>mapped APIC to ffffe000 (fee00000)
<4>mapped IOAPIC to ffffd000 (fec00000)
<4>Detected 200457 kHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 399.77 BogoMIPS
<4>Memory: 127616k/131072k available (1312k kernel code, 424k reserved, 1644k 
data, 76k init, 0k bigmem)
<4>Dentry hash table entries: 16384 (order 5, 128k)
<4>Buffer cache hash table entries: 131072 (order 7, 512k)
<4>Page cache hash table entries: 32768 (order 5, 128k)
<5>VFS: Diskquotas version dquot_6.4.0 initialized
<6>Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
<6>Checking 'hlt' instruction... OK.
<6>Intel Pentium with F0 0F bug - workaround enabled.
<4>POSIX conformance testing by UNIFIX
<4>per-CPU timeslice cutoff: 1.56 usecs.
<4>CPU0: Intel Pentium MMX stepping 03
<4>calibrating APIC timer ... 
<4>..... CPU clock speed is 200.4646 MHz.
<4>..... system bus clock speed is 66.8214 MHz.
<4>Booting processor 1 eip 2000
<4>Calibrating delay loop... 400.59 BogoMIPS
<4>OK.
<4>CPU1: Intel Pentium MMX stepping 03
<6>Total of 2 processors activated (800.36 BogoMIPS).
<4>enabling symmetric IO mode... ...done.
<4>ENABLING IO-APIC IRQs
<4>init IO_APIC IRQs
<4> IO-APIC (apicid-pin) 2-0, 2-20, 2-21, 2-22, 2-23 not connected.
<4>number of MP IRQ sources: 21.
<4>number of IO-APIC #2 registers: 24.
<4>testing the IO APIC.......................
<4>
<4>IO APIC #2......
<4>.... register #00: 02000000
<4>.......    : physical APIC id: 02
<4>.... register #01: 00170011
<4>.......     : max redirection entries: 0017
<4>.......     : IO APIC version: 0011
<4>.... register #02: 00000000
<4>.......     : arbitration: 00
<4>.... IRQ redirection table:
<4> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<4> 00 000 00  1    0    0   0   0    0    0    00
<4> 01 000 00  0    0    0   0   0    1    1    59
<4> 02 0FF 0F  0    0    0   0   0    1    1    51
<4> 03 000 00  0    0    0   0   0    1    1    61
<4> 04 000 00  0    0    0   0   0    1    1    69
<4> 05 000 00  0    0    0   0   0    1    1    71
<4> 06 000 00  0    0    0   0   0    1    1    79
<4> 07 000 00  0    0    0   0   0    1    1    81
<4> 08 000 00  0    0    0   0   0    1    1    89
<4> 09 000 00  0    0    0   0   0    1    1    91
<4> 0a 000 00  0    0    0   0   0    1    1    99
<4> 0b 000 00  0    0    0   0   0    1    1    A1
<4> 0c 000 00  0    0    0   0   0    1    1    A9
<4> 0d 000 00  1    0    0   0   0    0    0    00
<4> 0e 000 00  0    0    0   0   0    1    1    B1
<4> 0f 000 00  0    0    0   0   0    1    1    B9
<4> 10 0FF 0F  1    1    0   1   0    1    1    C1
<4> 11 0FF 0F  1    1    0   1   0    1    1    C9
<4> 12 0FF 0F  1    1    0   1   0    1    1    D1
<4> 13 0FF 0F  1    1    0   1   0    1    1    D9
<4> 14 000 00  1    0    0   0   0    0    0    00
<4> 15 000 00  1    0    0   0   0    0    0    00
<4> 16 000 00  1    0    0   0   0    0    0    00
<4> 17 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 2
<7>IRQ1 -> 1
<7>IRQ3 -> 3
<7>IRQ4 -> 4
<7>IRQ5 -> 5
<7>IRQ6 -> 6
<7>IRQ7 -> 7
<7>IRQ8 -> 8
<7>IRQ9 -> 9
<7>IRQ10 -> 10
<7>IRQ11 -> 11
<7>IRQ12 -> 12
<7>IRQ13 -> 13
<7>IRQ14 -> 14
<7>IRQ15 -> 15
<7>IRQ16 -> 16
<7>IRQ17 -> 17
<7>IRQ18 -> 18
<7>IRQ19 -> 19
<4>.................................... done.
<4>checking TSC synchronization across CPUs: passed.
<4>PCI: PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=0
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<4>PCI->APIC IRQ transform: (B0,I8,P0) -> 16
<4>PCI->APIC IRQ transform: (B0,I9,P0) -> 17
<4>PCI->APIC IRQ transform: (B0,I9,P0) -> 17
<4>PCI->APIC IRQ transform: (B0,I10,P0) -> 18
<4>PCI->APIC IRQ transform: (B0,I12,P0) -> 19
<6>Linux NET4.0 for Linux 2.2
<6>Based upon Swansea University Computer Society NET3.039
<6>NET4: Unix domain sockets 1.0 for Linux NET4.0.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>TCP: Hash tables configured (ehash 131072 bhash 65536)
<4>Initializing RT netlink socket
<4>Starting kswapd v 1.5 
<6>Detected PS/2 Mouse Port.
<4>pty: 256 Unix98 ptys configured
<6>Real Time Clock Driver v1.09
<4>RAM disk driver initialized:  16 RAM disks of 64000K size
<6>Uniform Multi-Platform E-IDE driver Revision: 6.30
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>PIIX3: IDE controller on PCI bus 00 dev 39
<4>PIIX3: chipset revision 0
<4>PIIX3: not 100%% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
<4>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
<4>hda: IBM-DTTA-351680, ATA DISK drive
<4>hdc: ATAPI 44X CDROM, ATAPI CDROM drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<6>hda: IBM-DTTA-351680, 16124MB w/462kB Cache, CHS=2055/255/63, (U)DMA
<4>hdc: ATAPI 48X CD-ROM drive, 128kB Cache, (U)DMA
<6>Uniform CD-ROM driver Revision: 3.11
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>(scsi0) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 0/12/0
<6>(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
<6>(scsi0) Downloading sequencer code... 422 instructions downloaded
<4>scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
<4>       <Adaptec AIC-7880 Ultra SCSI host adapter>
<4>scsi : 1 host.
<6>(scsi0:0:1:0) Synchronous at 10.0 Mbyte/sec, offset 15.
<4>  Vendor: SEAGATE   Model: ST15150N          Rev: 0022
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
<6>(scsi0:0:2:0) Synchronous at 10.0 Mbyte/sec, offset 15.
<4>  Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>Detected scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
<6>(scsi0:0:3:0) Synchronous at 10.0 Mbyte/sec, offset 15.
<4>  Vendor: TEAC      Model: CD-R55S           Rev: 1.0L
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>Detected scsi CD-ROM sr1 at scsi0, channel 0, id 3, lun 0
<6>(scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 15.
<4>  Vendor: IBM       Model: DCAS-34330        Rev: S65A
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>Detected scsi disk sdb at scsi0, channel 0, id 4, lun 0
<6>(scsi0:0:5:0) Synchronous at 10.0 Mbyte/sec, offset 15.
<4>  Vendor: QUANTUM   Model: FIREBALL_TM3200S  Rev: 300X
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>Detected scsi disk sdc at scsi0, channel 0, id 5, lun 0
<4>  Vendor: IOMEGA    Model: ZIP 100           Rev: E.03
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>Detected scsi removable disk sdd at scsi0, channel 0, id 6, lun 0
<4>scsi : detected 6 SCSI generics 2 SCSI cdroms 4 SCSI disks total.
<4>sr0: scsi3-mmc drive: 0x/0x caddy
<4>SCSI device sda: hdwr sector= 512 bytes. Sectors= 8388315 [4095 MB] [4.1 
GB]
<4>SCSI device sdb: hdwr sector= 512 bytes. Sectors= 8467200 [4134 MB] [4.1 
GB]
<4>SCSI device sdc: hdwr sector= 512 bytes. Sectors= 6281856 [3067 MB] [3.1 
GB]
<4>sdd : READ CAPACITY failed.
<4>sdd : status = 1, message = 00, host = 0, driver = 28 
<4>sdd : extended sense code = 2 
<4>sdd : block size assumed to be 512 bytes, disk size 1GB.  
<4>Partition check:
<4> sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 >
<4> sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 >
<4> sdc: sdc1 sdc2 sdc3 < sdc5 >
<4> sdd:scsidisk I/O error: dev 08:30, sector 0
<4> unable to read partition table
<4> hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
<4>VFS: Mounted root (ext2 filesystem) readonly.
<4>Freeing unused kernel memory: 76k freed
<6>Adding Swap: 112416k swap-space (priority -1)
<6>Adding Swap: 136544k swap-space (priority -2)
<6>Adding Swap: 136512k swap-space (priority -3)
<6>Serial driver version 4.27 with no serial options enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.
==================== end boot.msg ===============================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
