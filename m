Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275087AbTHIQbW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275260AbTHIQbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:31:22 -0400
Received: from [66.45.37.187] ([66.45.37.187]:9861 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S275087AbTHIQaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:30:39 -0400
Date: Fri, 8 Aug 2003 14:43:35 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
Subject: Multiple problems with 2.4.21?
Message-ID: <Pine.LNX.4.56.0308081440160.5382@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure exactly what it causing this problem, I am assuming it is
the nvidia module, so I guess I should not even bother emailing this list
because I will be told that it is a binary only module.

Well, I upgraded my machine, and went from a 3DFX Voodoo3 to a GeForce4
Ti4800 8X AGP, and therefore I use the module.

I have never had a problem with <= 2.4.21 without the NVIDIA module
running that I can remember.

I did see some weird stuff about a 'tar' process I had running (a backup),
which would lead me to ask, does or can the nvidia module cause other
processes to die etc?  For instance, my gnome session kept crashing and it
kept logging me back in etc.

I guess I'll try using X without the module and see if I get the problem,
but here is what I get in dmesg at the moment:

Found IRQ 5 for device 03:05.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
03:05.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x9400. Vers LK1.1.16
 00:10:5a:d0:1a:bb, IRQ 5
  product code 5152 rev 00.12 date 12-02-98
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
03:05.0: scatter/gather enabled. h/w checksums enabled
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: Unsupported Intel chipset (device id: 2578), you might want to try agp_try_unsupported=1.
agpgart: no supported devices found.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Found IRQ 7 for device 00:1f.1
PCI: Sharing IRQ 7 with 00:1d.2
PCI: Sharing IRQ 7 with 03:02.0
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20269: IDE controller at PCI slot 03:04.0
PCI: Found IRQ 10 for device 03:04.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9008-0x900f, BIOS settings: hdg:pio, hdh:pio
hda: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
hdc: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive
hde: ST3120023A, ATA DISK drive
blk: queue c039c328, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x8000-0x8007,0x8402 on irq 10
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
hda: attached ide-scsi driver.
hdc: attached ide-scsi driver.
hdd: attached ide-scsi driver.
Partition check:
 hde: hde1 hde2 hde3 hde4
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 03:07.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

blk: queue c284e594, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: MATSHITA  Model: CD-ROM CR-8008    Rev: 8.0e
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue c284e694, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue c284e794, I/O limit 4095Mb (mask 0xffffffff)
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.10
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.10
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1712  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
Attached scsi CD-ROM sr2 at scsi1, channel 0, id 1, lun 0
Attached scsi CD-ROM sr3 at scsi1, channel 0, id 2, lun 0
(scsi0:A:1): 5.000MB/s transfers (5.000MHz, offset 15)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
sr2: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Linux video capture interface: v1.00
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 256k freed
blk: queue c039c328, I/O limit 4095Mb (mask 0xffffffff)
Adding Swap: 2097136k swap-space (priority -1)
Adding Swap: 2097136k swap-space (priority -2)
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 16 19:03:09 PDT 2003
Creative EMU10K1 PCI Audio Driver, version 0.20a, 15:55:30 Aug  5 2003
PCI: Found IRQ 4 for device 03:06.0
emu10k1: EMU10K1 rev 7 model 0x8027 found, IO at 0x9800-0x981f, IRQ 4
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
i2c-core.o: i2c core module
i2c-proc.o version 2.6.1 (20010825)
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-isa.o version 2.6.5 (20020915)
i2c-dev.o: Registered 'ISA main adapter' as minor 0
i2c-core.o: adapter ISA main adapter registered as adapter 0.
i2c-isa.o: ISA bus access for i2c modules initialized.
w83781d.o version 2.6.5 (20020915)
i2c-core.o: driver W83781D sensor driver registered.
i2c-core.o: client [W83627HF chip] registered to adapter [ISA main adapter](pos. 0).
0: NVRM: AGPGART: unable to retrieve symbol table
eth0: no IPv6 routers present
Unable to handle kernel NULL pointer dereference at virtual address 00000002
 printing eip:
c012a45b
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012a45b>]    Tainted: P
EFLAGS: 00010246
eax: c1cd5c80   ebx: c13d2950   ecx: 00000000   edx: 00000002
esi: f678ed24   edi: 00010334   ebp: c0306c40   esp: c2821f30
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c2821000)
Stack: c13d2950 f678ed24 c13d2950 c0131a56 c13d2950 000001d0 000001fb 000001d0
       00000005 00000020 000001d0 00000020 00000006 c0131ca3 00000006 dda9a000
       c0306c40 000001d0 00000006 c0306c40 00000000 c0131d1e 00000020 c0306c40
Call Trace:    [<c0131a56>] [<c0131ca3>] [<c0131d1e>] [<c0131e3c>] [<c0131eb8>]
  [<c0131fe8>] [<c0131f50>] [<c0105000>] [<c01057ae>] [<c0131f50>]

Code: 89 02 c7 43 04 00 00 00 00 c7 03 00 00 00 00 c7 43 08 00 00
 kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00010202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: c125f070
esi: c16d7300   edi: 000108d1   ebp: c0306c40   esp: dda9be78
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 8073, stackpage=dda9b000)
Stack: c16d7330 000001d2 000001fb 000001d2 0000000c 00000020 000001d2 00000020
       00000006 c0131ca3 00000006 de946580 c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 dda9a000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>] [<c012da72>]
  [<c0183752>] [<c0139ae3>] [<c0138f69>] [<c01073df>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00210202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: 00001a7e
esi: c16d7300   edi: 000108eb   ebp: c0306c40   esp: ccafbe0c
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 8115, stackpage=ccafb000)
Stack: f613d780 c281967c 00000200 000001d2 00000020 0000001f 000001d2 00000020
       00000006 c0131ca3 00000006 00200296 c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 ccafa000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>] [<c01286a5>]
  [<c0128817>] [<c02b6072>] [<c0115488>] [<c0129467>] [<c012e41f>] [<c010c8b7>]
  [<c0115310>] [<c01074d0>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00010202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: 00001a7e
esi: c16d7300   edi: 000108ec   ebp: c0306c40   esp: de5a1e1c
ds: 0018   es: 0018   ss: 0018
Process backup (pid: 8068, stackpage=de5a1000)
Stack: c0361100 c2819244 00000200 000001d2 00000020 00000020 000001d2 00000020
       00000006 c0131ca3 00000006 f7b85400 c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 de5a0000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>] [<c0127f55>]
  [<c0128896>] [<c0115488>] [<c01187d0>] [<c0117166>] [<c01182e7>] [<c0143c65>]
  [<c0123196>] [<c0115310>] [<c01074d0>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00010202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: 00001a7e
esi: c16d7300   edi: 000108ec   ebp: c0306c40   esp: ccafbe78
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 8116, stackpage=ccafb000)
Stack: f77922bc c281b970 00000200 000001d2 00000020 00000020 000001d2 00000020
       00000006 c0131ca3 00000006 f48da780 c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 ccafa000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>] [<c012da72>]
  [<c0125343>] [<c0183752>] [<c0139ae3>] [<c0138f69>] [<c01073df>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00013202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: 00001a7d
esi: c16d7300   edi: 000108ea   ebp: c0306c40   esp: f768fe1c
ds: 0018   es: 0018   ss: 0018
Process X (pid: 98, stackpage=f768f000)
Stack: ccb6d000 c281b6e8 00000200 000001d2 00000020 0000001b 000001d2 00000020
       00000006 c0131ca3 00000006 c0285ea4 c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 f768e000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0285ea4>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>]
  [<c01284ee>] [<c0128817>] [<c0115488>] [<c01295a6>] [<c010c892>] [<c0115310>]
  [<c01074d0>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 0: NVRM: AGPGART: unable to retrieve symbol table
kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00210202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: 00001a2b
esi: c16d7300   edi: 000105b2   ebp: c0306c40   esp: f6fb7e1c
ds: 0018   es: 0018   ss: 0018
Process gkrellm (pid: 8513, stackpage=f6fb7000)
Stack: f6ee3080 c281b388 00000200 000001d2 00000020 00000018 000001d2 00000020
       00000006 c0131ca3 00000006 00000000 c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 f6fb6000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>] [<c0127f55>]
  [<c0128896>] [<c0115488>] [<c0115310>] [<c01074d0>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00210202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: 00001a2b
esi: c16d7300   edi: 000105b4   ebp: c0306c40   esp: d943fd14
ds: 0018   es: 0018   ss: 0018
Process gkrellm (pid: 8511, stackpage=d943f000)
Stack: f4c4a100 c281b100 00000200 000001d2 00000020 0000000f 000001d2 00000020
       00000006 c0131ca3 00000006 c0208b6d c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 d943e000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0208b6d>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>]
  [<c01284ee>] [<c0128817>] [<c0115488>] [<c01faa9e>] [<c0203c1d>] [<c0203d8d>]
  [<c0115310>] [<c01074d0>] [<c012bd48>] [<c012b7b6>] [<c012bcf0>] [<c012be82>]
  [<c012bcf0>] [<c01399a3>] [<c0141229>] [<c01073df>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00013202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: 00001a2c
esi: c16d7300   edi: 000105b8   ebp: c0306c40   esp: f7511e1c
ds: 0018   es: 0018   ss: 0018
Process X (pid: 8124, stackpage=f7511000)
Stack: f6fc3000 c2819f58 00000200 000001d2 00000020 00000015 000001d2 00000020
       00000006 c0131ca3 00000006 c0285ea4 c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 f7510000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0285ea4>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>]
  [<c0128c15>] [<c01284ee>] [<c0128817>] [<c02b6072>] [<c0115488>] [<c0129467>]
  [<c010c892>] [<c0115310>] [<c01074d0>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 0: NVRM: AGPGART: unable to retrieve symbol table
kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00013202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: 000019de
esi: c16d7300   edi: 000102b3   ebp: c0306c40   esp: f7115e1c
ds: 0018   es: 0018   ss: 0018
Process X (pid: 8517, stackpage=f7115000)
Stack: f6610000 c2819d3c 00000200 000001d2 00000020 00000010 000001d2 00000020
       00000006 c0131ca3 00000006 c0285ea4 c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 f7114000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0285ea4>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>]
  [<c01284ee>] [<c0128817>] [<c0115488>] [<c0129467>] [<c010c892>] [<c0115310>]
  [<c01074d0>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 0: NVRM: AGPGART: unable to retrieve symbol table
kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00210202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: 000019dc
esi: c16d7300   edi: 000102a0   ebp: c0306c40   esp: e0533e1c
ds: 0018   es: 0018   ss: 0018
Process xchats (pid: 9276, stackpage=e0533000)
Stack: f6558280 c2819898 00000200 000001d2 00000020 00000018 000001d2 00000020
       00000006 c0131ca3 00000006 c0247b00 c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 e0532000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0247b00>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>]
  [<c01284ee>] [<c0128817>] [<c012bda5>] [<c0115488>] [<c012bcf0>] [<c012a003>]
  [<c0128eff>] [<c0115310>] [<c01074d0>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b3d>]    Tainted: P
EFLAGS: 00013202
eax: 00000041   ebx: 00000000   ecx: c16d731c   edx: 000019dd
esi: c16d7300   edi: 000102a2   ebp: c0306c40   esp: f6f7de1c
ds: 0018   es: 0018   ss: 0018
Process X (pid: 8895, stackpage=f6f7d000)
Stack: f77fcc00 c2819610 00000200 000001d2 00000020 00000003 000001d2 00000020
       00000006 c0131ca3 00000006 c0285ea4 c0306c40 000001d2 00000006 c0306c40
       00000000 c0131d1e 00000020 f6f7c000 0000021f c0306c40 c0132ba4 00000000
Call Trace:    [<c0131ca3>] [<c0285ea4>] [<c0131d1e>] [<c0132ba4>] [<c0132e32>]
  [<c0249e90>] [<c01284ee>] [<c0128817>] [<c02b6072>] [<c0115488>] [<c0129467>]
  [<c010c892>] [<c0115310>] [<c01074d0>]

Code: 0f 0b 66 01 eb 93 2c c0 e9 a9 fd ff ff c7 00 00 00 00 00 e8
 0: NVRM: AGPGART: unable to retrieve symbol table

