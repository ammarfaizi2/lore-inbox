Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130238AbRCGFnF>; Wed, 7 Mar 2001 00:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130224AbRCGFmq>; Wed, 7 Mar 2001 00:42:46 -0500
Received: from smtp4vepub.gte.net ([206.46.170.25]:3165 "EHLO
	smtp4ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S130216AbRCGFmd>; Wed, 7 Mar 2001 00:42:33 -0500
Message-ID: <3AA5CA13.8C19FC7E@neuronet.pitt.edu>
Date: Wed, 07 Mar 2001 00:41:39 -0500
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: LK <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.3 and new aic7xxx
In-Reply-To: <200103061847.f26IlaO06717@aslan.scsiguy.com>
Content-Type: multipart/mixed;
 boundary="------------E718780FC18901B81C168E9D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E718780FC18901B81C168E9D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Justin T. Gibbs" wrote:
> Can you provide me with a dmesg from a boot with aic7xxx=verbose?
> I just tested this on a 3940AUW and the behavior was as expected.
> Perhaps you have a motherboard based controller that has no seeprom?
> I don't know how to detect flipped channels in that configuration
> but I'll see what I can find out.

I've a Super P6SBS motherboard with a builtin dual channel Adaptec 7890
Ultra II scsi controller. I'm attaching the console grab when booting
2.4.3-pre2. The controller BIOS is configured to boot off the disk with
scsi id 0 on channel B.

-- 
     Rafael
--------------E718780FC18901B81C168E9D
Content-Type: text/plain; charset=us-ascii;
 name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log"

                                                                    
Linux version 2.4.3-pre2 (raffo@inca) (gcc version 2.95.2 19991024 (release)) #1 Mon Mar 5 12:54:06 EST 2001
BIOS-provided physical RAM map:                                     
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)            
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)          
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 000000000ff00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000040000 @ 00000000fffc0000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux_243 ro root=803 BOOT_FILE=/boot/vmlinuz_243 1 aic7xxx=verbose console=t8
Initializing CPU#0
Detected 701.600 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1399.19 BogoMIPS
Memory: 255488k/262144k available (1064k kernel code, 6268k reserved, 416k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169725kB/56575kB, 512 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC AC310100B, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19807200 sectors (10141 MB) w/512KiB Cache, CHS=1232/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 > p3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
ahc_pci:0:14:1: Reading SEEPROM...done.
ahc_pci:0:14:1: Low byte termination Enabled
ahc_pci:0:14:1: High byte termination Enabled
ahc_pci:0:14:1: Downloading Sequencer Program... 404 instructions downloaded
ahc_pci:0:14:0: Reading SEEPROM...done.
ahc_pci:0:14:0: Low byte termination Enabled
ahc_pci:0:14:0: High byte termination Enabled
ahc_pci:0:14:0: Downloading Sequencer Program... 404 instructions downloaded
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Wide Channel B, SCSI Id=7, 32/255 SCBs

  Vendor: SEAGATE   Model: ST15150N          Rev: 4611
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 2, lun 0
(scsi0:A:2:1): Sending SDTR period c, offset f
(scsi0:A:2:1): Received SDTR period 19, offset f
        Filtered to period 19, offset f
(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
scsi0: target 2 synchronous at 10.0MHz, offset = 0xf
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4:1): Sending SDTR period c, offset f
(scsi0:A:4:1): Received SDTR period 19, offset f
        Filtered to period 19, offset f
(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
scsi0: target 4 synchronous at 10.0MHz, offset = 0xf
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4:2): Sending SDTR period c, offset f
(scsi0:A:4:2): Received SDTR period 19, offset f
        Filtered to period 19, offset f
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4:3): Sending SDTR period c, offset f
(scsi0:A:4:3): Received SDTR period 19, offset f
        Filtered to period 19, offset f
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4:4): Sending SDTR period c, offset f
(scsi0:A:4:4): Received SDTR period 19, offset f
        Filtered to period 19, offset f
  Vendor: NAKAMICH  Model: MJ-5.16S          Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4:5): Sending SDTR period c, offset f
(scsi0:A:4:5): Received SDTR period 19, offset f
        Filtered to period 19, offset f
  Vendor: TEAC      Model: CD-R56S4          Rev: 1.0P
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:5:1): Sending SDTR period c, offset f
(scsi0:A:5:1): Received SDTR period 19, offset f
        Filtered to period 19, offset f
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
scsi0: target 5 synchronous at 10.0MHz, offset = 0xf
(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
scsi0:0:2:0: Tagged Queuing enabled.  Depth 16
  Vendor: SEAGATE   Model: ST39173LW         Rev: 6246
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi1, channel 0, id 0, lun 0
(scsi1:A:0:1): Sending WDTR 1
(scsi1:A:0:1): Received WDTR 1 filtered to 1
(scsi1:A:0): 6.600MB/s transfers (16bit)
scsi1: target 0 using 16bit transfers
(scsi1:A:0:1): Sending SDTR period 2b, offset 8
(scsi1:A:0:1): Received SDTR period 2b, offset 8
        Filtered to period 2b, offset 8
(scsi1:A:0): 11.626MB/s transfers (5.813MHz, offset 8, 16bit)
scsi1: target 0 synchronous at 5.7MHz, offset = 0x8
  Vendor: COMPAQ    Model: WDE4360W          Rev: 1.52
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi1, channel 0, id 8, lun 0
(scsi1:A:8:1): Sending WDTR 1
(scsi1:A:8:1): Received WDTR 1 filtered to 1
(scsi1:A:8): 6.600MB/s transfers (16bit)
scsi1: target 8 using 16bit transfers
(scsi1:A:8:1): Sending SDTR period 2b, offset 8
(scsi1:A:8:1): Received SDTR period 2d, offset 8
        Filtered to period 2d, offset 8
(scsi1:A:8): 11.110MB/s transfers (5.555MHz, offset 8, 16bit)
scsi1: target 8 synchronous at 5.0MHz, offset = 0x8
(scsi1:A:0): 11.626MB/s transfers (5.813MHz, offset 8, 16bit)
scsi1:0:0:0: Tagged Queuing enabled.  Depth 16
(scsi1:A:8): 11.110MB/s transfers (5.555MHz, offset 8, 16bit)
scsi1:0:8:0: Tagged Queuing enabled.  Depth 16
(scsi0:A:2:0): Sending SDTR period c, offset f
(scsi0:A:2:0): Received SDTR period 19, offset f
        Filtered to period 19, offset f
(scsi0:A:2:0): Sending SDTR period 19, offset f
(scsi0:A:2:0): Received SDTR period 19, offset f
        Filtered to period 19, offset f
SCSI device sda: 8388315 512-byte hdwr sectors (4295 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1
(scsi1:A:0:0): Sending WDTR 1
(scsi1:A:0:0): Received WDTR 1 filtered to 1
(scsi1:A:0): 6.600MB/s transfers (16bit)
scsi1: target 0 using asynchronous transfers
(scsi1:A:0:0): Sending SDTR period 2b, offset 8
(scsi1:A:0:0): Received SDTR period 2b, offset 8
        Filtered to period 2b, offset 8
(scsi1:A:0): 11.626MB/s transfers (5.813MHz, offset 8, 16bit)
scsi1: target 0 synchronous at 5.7MHz, offset = 0x8
SCSI device sdb: 17783240 512-byte hdwr sectors (9105 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 p3 p4
(scsi1:A:8:0): Sending WDTR 1
(scsi1:A:8:0): Received WDTR 1 filtered to 1
(scsi1:A:8): 6.600MB/s transfers (16bit)
scsi1: target 8 using asynchronous transfers
(scsi1:A:8:0): Sending SDTR period 2d, offset 8
(scsi1:A:8:0): Received SDTR period 2d, offset 8
        Filtered to period 2d, offset 8
(scsi1:A:8): 11.110MB/s transfers (5.555MHz, offset 8, 16bit)
scsi1: target 8 synchronous at 5.0MHz, offset = 0x8
SCSI device sdc: 8386000 512-byte hdwr sectors (4294 MB)
 /dev/scsi/host1/bus0/target8/lun0: p1 p2
LVM version 0.9.1_beta2  by Heinz Mauelshagen  (18/01/2001)
lvm -- Driver successfully initialized
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
VFS: Cannot open root device "803" or 08:03
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:03


--------------E718780FC18901B81C168E9D--

