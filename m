Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265045AbRFZRWM>; Tue, 26 Jun 2001 13:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265046AbRFZRWD>; Tue, 26 Jun 2001 13:22:03 -0400
Received: from mtiwmhc22.worldnet.att.net ([204.127.131.47]:36300 "EHLO
	mtiwmhc22.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S265045AbRFZRV7>; Tue, 26 Jun 2001 13:21:59 -0400
Message-ID: <3B38C4D2.EB2A8944@mycompany.com>
Date: Tue, 26 Jun 2001 13:22:26 -0400
From: myemail@mycompany.com
X-Mailer: Mozilla 4.08 [en] (Win95; U)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AIC7xxx kernel driver; ATTN Mr. Justin T. Gibbs
Content-Type: multipart/mixed; boundary="------------1910BE4E948A7287E297C9EF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1910BE4E948A7287E297C9EF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Trying to use an AIC7890 SCSI controller with kernel 2.4.5 I have
the problem reported into the attached log files.  Same problems with
kernel 2.4.3.  Kernels below 2.4 doesn't even see it.  In MS Windows 95
it works without any problems.  I used 3 variations of SCSI controllers
built upon AIC7890, so I don't think all 3 are bad.  One was made for
Compaq and two for Dell.  The AIC7890 is around since a while so that's
the problem with Linux in corp. computing.  It's great but cannot use
it.
    I Couldn't send this bug report directly to the author of the
driver, Justin T. Gibbs, because there is no e-mail address provided.
    If you need further details please, let me know.  Same if you need a
sample controller for your tests.
    If you fix the problem, please, let me know.  Maybe next time we may
be really able to use your OS.

Thank you very much and my best regards
-- 
Mihai Gata
iscollect@millrose.com
IS Manager @ Mill-Rose Company
Member of The Institute of Electrical and Electronics Engineers
Member of The Association for Computing Machinery
--------------1910BE4E948A7287E297C9EF
Content-Type: text/plain; charset=us-ascii; name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="dmesg"

Linux version 2.4.5-Mihai-1 (root@mr-test-1) (gcc version 2.96 20000731 (Linux-Mandrake 8.0 2.96-0.48mdk)) #4 Sun Jun 17 05:00:08 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01111000)
Kernel command line: 
Initializing CPU#0
Detected 451.030 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 897.84 BogoMIPS
Memory: 61796k/65536k available (1239k kernel code, 3352k reserved, 467k data, 240k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb480, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Disabled enhanced CPU to PCI posting #2
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
Winbond chip at EFER=0x3f0 key=0x87 devid=fc devrev=21 oldid=8c
Winbond chip type 83877TF
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
block: queued sectors max/low 40978kB/13659kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC36400L, ATA DISK drive
hdb: CD-540E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12594960 sectors (6449 MB) w/256KiB Cache, CHS=784/255/63, UDMA(33)
hdb: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x340: 00 40 05 5a be 13
eth0: NE2000 found at 0x340, using IRQ 11.
PPP generic driver version 2.4.1
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 28M
agpgart: Detected Via MVP3 chipset
agpgart: AGP aperture is 64M @ 0xd8000000
[drm] AGP 0.99 on VIA MVP3 @ 0xd8000000 64MB
[drm] Initialized r128 2.1.2 20001215 on minor 63
SCSI subsystem driver Revision: 1.00
PCI: Assigned IRQ 3 for device 00:0b.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

  Vendor: SEAGATE   Model: ST318416N         Rev: 0010
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: YAMAHA    Model: CRW8824S          Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.12
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 31)
SCSI device sda: 35885168 512-byte hdwr sectors (18373 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
Detected scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
(scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
(scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 15)
sr2: scsi-1 drive
Creative EMU10K1 PCI Audio Driver, version 0.7, 04:45:36 Jun 17 2001
PCI: Found IRQ 10 for device 00:09.0
emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0xd800-0xd81f, IRQ 10
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding Swap: 771112k swap-space (priority -1)
MSDOS FS: Using codepage 850
MSDOS FS: IO charset iso8859-1
scsi0: PCI error Interrupt at seqaddr = 0x9
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x9
scsi0: Data Parity Error Detected during address or write data phase
VFS: freeing iocharset=iso8859-1
MSDOS FS: Using codepage 850
MSDOS FS: IO charset iso8859-1
scsi0: PCI error Interrupt at seqaddr = 0x9
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr = 0x9
scsi0: Data Parity Error Detected during address or write data phase
VFS: freeing iocharset=iso8859-1

--------------1910BE4E948A7287E297C9EF
Content-Type: text/plain; charset=us-ascii; name="lspci-vvv"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="lspci-vvv"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: dc000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
	Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
	Subsystem: Creative Labs: Unknown device 8061
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at dc00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 SCSI storage controller: Adaptec AHA-2940U2/W
	Subsystem: Adaptec: Unknown device a180
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (9750ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	BIST result: 00
	Region 0: I/O ports at e000 [disabled] [size=256]
	Region 1: Memory at e3000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at e2000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5446 (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0018
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at dc000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------1910BE4E948A7287E297C9EF
Content-Type: text/plain; charset=us-ascii; name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="messages"

Jun 25 16:03:12 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:12 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:13 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:14 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:14 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:14 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:14 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:14 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:14 mr-test-1 syslogd 1.4-0: restart.
Jun 25 16:03:19 mr-test-1 anacron[902]: Job `cron.daily' terminated
Jun 25 16:05:05 mr-test-1 kernel: read_super_block: can't find a reiserfs filesystem on dev 02:00
Jun 25 16:05:05 mr-test-1 kernel: read_old_super_block: try to find super block in old location
Jun 25 16:05:05 mr-test-1 kernel: read_old_super_block: can't find a reiserfs filesystem on dev 02:00.
Jun 25 16:08:11 mr-test-1 anacron[902]: Job `cron.weekly' started
Jun 25 16:08:11 mr-test-1 anacron[1310]: Updated timestamp for job `cron.weekly' to 2001-06-25
Jun 25 16:10:00 mr-test-1 CROND[5031]: (root) CMD (   /sbin/rmmod -as) 
Jun 25 16:10:29 mr-test-1 anacron[902]: Job `cron.weekly' terminated
Jun 25 16:10:29 mr-test-1 anacron[902]: Normal exit (2 jobs run)
Jun 25 16:11:23 mr-test-1 login(pam_unix)[978]: session opened for user root by LOGIN(uid=0)
Jun 25 16:11:23 mr-test-1  -- root[978]: ROOT LOGIN ON tty4
Jun 25 16:11:55 mr-test-1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Jun 25 16:11:55 mr-test-1 kernel: scsi0: Data Parity Error Detected during address or write data phase

--------------1910BE4E948A7287E297C9EF
Content-Type: text/plain; charset=us-ascii; name="proc-scsi-aic7xxx-0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="proc-scsi-aic7xxx-0"

Adaptec AIC7xxx driver version: 6.1.13
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
Channel A Target 0 Negotiation Settings
	User: 20.000MB/s transfers (20.000MHz, offset 255)
	Goal: 20.000MB/s transfers (20.000MHz, offset 31)
	Curr: 20.000MB/s transfers (20.000MHz, offset 31)
	Channel A Target 0 Lun 0 Settings
		Commands Queued 10303
		Commands Active 0
		Command Openings 64
		Max Tagged Openings 253
		Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
	User: 40.000MB/s transfers (40.000MHz, offset 255)
Channel A Target 2 Negotiation Settings
	User: 40.000MB/s transfers (40.000MHz, offset 255)
Channel A Target 3 Negotiation Settings
	User: 20.000MB/s transfers (20.000MHz, offset 255)
	Goal: 20.000MB/s transfers (20.000MHz, offset 15)
	Curr: 20.000MB/s transfers (20.000MHz, offset 15)
	Channel A Target 3 Lun 0 Settings
		Commands Queued 3
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
	User: 20.000MB/s transfers (20.000MHz, offset 255)
	Goal: 20.000MB/s transfers (20.000MHz, offset 16)
	Curr: 20.000MB/s transfers (20.000MHz, offset 16)
	Channel A Target 4 Lun 0 Settings
		Commands Queued 3
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 5 Negotiation Settings
	User: 20.000MB/s transfers (20.000MHz, offset 255)
	Goal: 20.000MB/s transfers (20.000MHz, offset 15)
	Curr: 20.000MB/s transfers (20.000MHz, offset 15)
	Channel A Target 5 Lun 0 Settings
		Commands Queued 3
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 6 Negotiation Settings
	User: 40.000MB/s transfers (40.000MHz, offset 255)
Channel A Target 7 Negotiation Settings
	User: 40.000MB/s transfers (40.000MHz, offset 255)
Channel A Target 8 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)

--------------1910BE4E948A7287E297C9EF
Content-Type: text/plain; charset=us-ascii; name="proc-scsi-scsi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="proc-scsi-scsi"

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST318416N        Rev: 0010
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW8824S         Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.12
  Type:   CD-ROM                           ANSI SCSI revision: 02

--------------1910BE4E948A7287E297C9EF
Content-Type: text/plain; charset=us-ascii; name="scanpci-v"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="scanpci-v"


pci bus 0x0 cardnum 0x00 function 0x0000: vendor 0x1106 device 0x0598
 VIA  Device unknown
  STATUS    0x8290  COMMAND 0x0006
  CLASS     0x06 0x00 0x00  REVISION 0x04
  HEADER    0x00  LATENCY 0x10

pci bus 0x0 cardnum 0x01 function 0x0000: vendor 0x1106 device 0x8598
 VIA VT 82C598 MVP3 PCI/AGP Bridge
  STATUS    0x2220  COMMAND 0x0007
  CLASS     0x06 0x04 0x00  REVISION 0x00
  HEADER    0x01  LATENCY 0x00
  PRIBUS    0x00  SECBUS 0x01  SUBBUS 0x01  SECLT 0x00
  IOBASE    0xc000  IOLIM 0xcfff  SECSTATUS 0x0000
  NOPREFETCH_MEMBASE 0xe0000000  MEMLIM 0xe1ffffff
  PREFETCH_MEMBASE   0xdc000000  MEMLIM 0xdfffffff
  NO_FAST_B2B NO_SEC_BUS_RST NO_M_ABRT VGA_EN ISA_EN NO_PERR_EN

pci bus 0x0 cardnum 0x07 function 0x0000: vendor 0x1106 device 0x0586
 VIA VT 82C586 MVP3 ISA Bridge
 CardVendor 0x1106 card 0x0000 (VIA, Card unknown)
  STATUS    0x0200  COMMAND 0x008f
  CLASS     0x06 0x01 0x00  REVISION 0x47
  HEADER    0x80  LATENCY 0x00

pci bus 0x0 cardnum 0x07 function 0x0001: vendor 0x1106 device 0x0571
 VIA VT 82C586 MVP3 IDE Bridge
  STATUS    0x0280  COMMAND 0x0007
  CLASS     0x01 0x01 0x8a  REVISION 0x06
  BIST      0x00  HEADER 0x00  LATENCY 0x20  CACHE 0x00
  BASE4     0x0000d001  addr 0x0000d000  I/O
  BYTE_0    0x3a09e20b  BYTE_1  0x00  BYTE_2  0x806c848  BYTE_3  0xffffffff

pci bus 0x0 cardnum 0x07 function 0x0003: vendor 0x1106 device 0x3040
 VIA VT 82C586B MVP3 ACPI Bridge
  STATUS    0x0280  COMMAND 0x0000
  CLASS     0x06 0x00 0x00  REVISION 0x10

pci bus 0x0 cardnum 0x09 function 0x0000: vendor 0x1102 device 0x0002
 Creative Labs  Device unknown
 CardVendor 0x1102 card 0x8061 (Creative Labs, Card unknown)
  STATUS    0x0290  COMMAND 0x0005
  CLASS     0x04 0x01 0x00  REVISION 0x07
  BIST      0x00  HEADER 0x80  LATENCY 0x20  CACHE 0x00
  BASE0     0x0000d801  addr 0x0000d800  I/O
  MAX_LAT   0x14  MIN_GNT 0x02  INT_PIN 0x01  INT_LINE 0x0a

pci bus 0x0 cardnum 0x09 function 0x0001: vendor 0x1102 device 0x7002
 Creative Labs  Device unknown
 CardVendor 0x1102 card 0x0020 (Creative Labs, Card unknown)
  STATUS    0x0290  COMMAND 0x0005
  CLASS     0x09 0x80 0x00  REVISION 0x07
  BIST      0x00  HEADER 0x80  LATENCY 0x20  CACHE 0x00
  BASE0     0x0000dc01  addr 0x0000dc00  I/O

pci bus 0x0 cardnum 0x0b function 0x0000: vendor 0x9005 device 0x0010
 Adaptec  Device unknown
 CardVendor 0x9005 card 0xa180 (Adaptec, Card unknown)
  STATUS    0x0290  COMMAND 0x0006
  CLASS     0x01 0x00 0x00  REVISION 0x00
  BIST      0x80  HEADER 0x00  LATENCY 0x20  CACHE 0x08
  BASE0     0x0000e001  addr 0x0000e000  I/O
  BASE1     0xe3000004  addr 0xe3000000  MEM 64BIT
  BASEROM   0xe2000000  addr 0xe2000000  not-decode-enabled
  MAX_LAT   0x19  MIN_GNT 0x27  INT_PIN 0x01  INT_LINE 0x03
  BYTE_0    0x540  BYTE_1  0x00  BYTE_2  0x806d628  BYTE_3  0xffffffff

pci bus 0x1 cardnum 0x00 function 0x0000: vendor 0x1002 device 0x5446
 ATI Rage 128 RF
 CardVendor 0x1002 card 0x0018 (ATI, Card unknown)
  STATUS    0x02b0  COMMAND 0x0087
  CLASS     0x03 0x00 0x00  REVISION 0x00
  BIST      0x00  HEADER 0x00  LATENCY 0x20  CACHE 0x08
  BASE0     0xdc000008  addr 0xdc000000  MEM PREFETCHABLE
  BASE1     0x0000c001  addr 0x0000c000  I/O
  BASE2     0xe1000000  addr 0xe1000000  MEM
  MAX_LAT   0x00  MIN_GNT 0x08  INT_PIN 0x01  INT_LINE 0xff

--------------1910BE4E948A7287E297C9EF--

