Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262978AbRE1Fsj>; Mon, 28 May 2001 01:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262983AbRE1FsV>; Mon, 28 May 2001 01:48:21 -0400
Received: from nic.lth.se ([130.235.20.3]:7382 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S262978AbRE1FsC>;
	Mon, 28 May 2001 01:48:02 -0400
Date: Mon, 28 May 2001 07:47:59 +0200
From: Jakob Borg <jakob@borg.pp.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5: USB audio crash again; now with info
Message-ID: <20010528074759.A720@borg.pp.se>
In-Reply-To: <20010528074654.A625@borg.pp.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20010528074654.A625@borg.pp.se>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux narayan 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 28, 2001 at 07:46:54AM +0200, Jakob Borg wrote:
> system is a dual P2 400, details to be found in the attached dmesg and
> .config. 

Hrm. Attached here; sorry.

//jb

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

May 28 07:13:01 narayan kernel: klogd 1.4.1#2, log source = /proc/kmsg started.
May 28 07:13:01 narayan kernel: Inspecting /boot/System.map-2.4.5
May 28 07:13:01 narayan kernel: Loaded 18580 symbols from /boot/System.map-2.4.5.
May 28 07:13:01 narayan kernel: Symbols match kernel version 2.4.5.
May 28 07:13:01 narayan kernel: No module symbols loaded.
May 28 07:13:01 narayan kernel: ce.
May 28 07:13:01 narayan kernel: hm, page 000f6000 reserved twice.
May 28 07:13:01 narayan kernel: hm, page 000f7000 reserved twice.
May 28 07:13:01 narayan kernel: On node 0 totalpages: 131069
May 28 07:13:01 narayan kernel: zone(0): 4096 pages.
May 28 07:13:01 narayan kernel: zone(1): 126973 pages.
May 28 07:13:01 narayan kernel: zone(2): 0 pages.
May 28 07:13:01 narayan kernel: Intel MultiProcessor Specification v1.4
May 28 07:13:01 narayan kernel:     Virtual Wire compatibility mode.
May 28 07:13:01 narayan kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
May 28 07:13:01 narayan kernel: Processor #1 Pentium(tm) Pro APIC version 17
May 28 07:13:01 narayan kernel:     Floating point unit present.
May 28 07:13:01 narayan kernel:     Machine Exception supported.
May 28 07:13:01 narayan kernel:     64 bit compare & exchange supported.
May 28 07:13:01 narayan kernel:     Internal APIC present.
May 28 07:13:01 narayan kernel:     SEP present.
May 28 07:13:01 narayan kernel:     MTRR  present.
May 28 07:13:01 narayan kernel:     PGE  present.
May 28 07:13:01 narayan kernel:     MCA  present.
May 28 07:13:01 narayan kernel:     CMOV  present.
May 28 07:13:01 narayan kernel:     PAT  present.
May 28 07:13:01 narayan kernel:     PSE  present.
May 28 07:13:01 narayan kernel:     MMX  present.
May 28 07:13:01 narayan kernel:     FXSR  present.
May 28 07:13:01 narayan kernel:     Bootup CPU
May 28 07:13:01 narayan kernel: Processor #0 Pentium(tm) Pro APIC version 17
May 28 07:13:01 narayan kernel:     Floating point unit present.
May 28 07:13:01 narayan kernel:     Machine Exception supported.
May 28 07:13:01 narayan kernel:     64 bit compare & exchange supported.
May 28 07:13:01 narayan kernel:     Internal APIC present.
May 28 07:13:01 narayan kernel:     SEP present.
May 28 07:13:01 narayan kernel:     MTRR  present.
May 28 07:13:01 narayan kernel:     PGE  present.
May 28 07:13:01 narayan kernel:     MCA  present.
May 28 07:13:01 narayan kernel:     CMOV  present.
May 28 07:13:01 narayan kernel:     PAT  present.
May 28 07:13:01 narayan kernel:     PSE  present.
May 28 07:13:01 narayan kernel:     MMX  present.
May 28 07:13:01 narayan kernel:     FXSR  present.
May 28 07:13:01 narayan kernel: Bus #0 is PCI   
May 28 07:13:01 narayan kernel: Bus #1 is PCI   
May 28 07:13:01 narayan kernel: Bus #2 is ISA   
May 28 07:13:01 narayan kernel: I/O APIC #2 Version 17 at 0xFEC00000.
May 28 07:13:01 narayan kernel: Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 2, APIC INT 05
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
May 28 07:13:01 narayan kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
May 28 07:13:01 narayan kernel: Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
May 28 07:13:01 narayan kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 13, APIC ID 2, APIC INT 13
May 28 07:13:01 narayan kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 2, APIC INT 12
May 28 07:13:01 narayan kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 2c, APIC ID 2, APIC INT 11
May 28 07:13:01 narayan kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 2, APIC INT 10
May 28 07:13:01 narayan kernel: Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
May 28 07:13:01 narayan kernel: Lint: type 1, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
May 28 07:13:01 narayan kernel: Processors: 2
May 28 07:13:01 narayan kernel: mapped APIC to ffffe000 (fee00000)
May 28 07:13:01 narayan kernel: mapped IOAPIC to ffffd000 (fec00000)
May 28 07:13:01 narayan kernel: Kernel command line: auto BOOT_IMAGE=test ro root=301 panic=5
May 28 07:13:01 narayan kernel: Initializing CPU#0
May 28 07:13:01 narayan kernel: Detected 400.917 MHz processor.
May 28 07:13:01 narayan kernel: Console: colour VGA+ 80x25
May 28 07:13:01 narayan kernel: Calibrating delay loop... 799.53 BogoMIPS
May 28 07:13:01 narayan kernel: Memory: 512428k/524276k available (1583k kernel code, 11460k reserved, 606k data, 208k init, 0k highmem)
May 28 07:13:01 narayan kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
May 28 07:13:01 narayan kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
May 28 07:13:01 narayan kernel: Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
May 28 07:13:01 narayan kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
May 28 07:13:01 narayan kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 28 07:13:01 narayan kernel: CPU: L2 cache: 512K
May 28 07:13:01 narayan kernel: Intel machine check architecture supported.
May 28 07:13:01 narayan kernel: Intel machine check reporting enabled on CPU#0.
May 28 07:13:01 narayan kernel: Enabling fast FPU save and restore... done.
May 28 07:13:01 narayan kernel: Checking 'hlt' instruction... OK.
May 28 07:13:01 narayan kernel: POSIX conformance testing by UNIFIX
May 28 07:13:01 narayan kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
May 28 07:13:01 narayan kernel: mtrr: detected mtrr type: Intel
May 28 07:13:01 narayan kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 28 07:13:01 narayan kernel: CPU: L2 cache: 512K
May 28 07:13:01 narayan kernel: Intel machine check reporting enabled on CPU#0.
May 28 07:13:01 narayan kernel: CPU0: Intel Pentium II (Deschutes) stepping 03
May 28 07:13:01 narayan kernel: per-CPU timeslice cutoff: 1464.26 usecs.
May 28 07:13:01 narayan kernel: Getting VERSION: 40011
May 28 07:13:01 narayan kernel: Getting VERSION: 40011
May 28 07:13:01 narayan kernel: Getting ID: 1000000
May 28 07:13:01 narayan kernel: Getting ID: e000000
May 28 07:13:01 narayan kernel: Getting LVT0: 8700
May 28 07:13:01 narayan kernel: Getting LVT1: 400
May 28 07:13:01 narayan kernel: enabled ExtINT on CPU#0
May 28 07:13:01 narayan kernel: ESR value before enabling vector: 00000000
May 28 07:13:01 narayan kernel: ESR value after enabling vector: 00000000
May 28 07:13:01 narayan kernel: CPU present map: 3
May 28 07:13:01 narayan kernel: Booting processor 1/0 eip 2000
May 28 07:13:01 narayan kernel: Setting warm reset code and vector.
May 28 07:13:01 narayan kernel: 1.
May 28 07:13:01 narayan kernel: 2.
May 28 07:13:01 narayan kernel: 3.
May 28 07:13:01 narayan kernel: Asserting INIT.
May 28 07:13:01 narayan kernel: Waiting for send to finish...
May 28 07:13:01 narayan kernel: +Deasserting INIT.
May 28 07:13:01 narayan kernel: Waiting for send to finish...
May 28 07:13:01 narayan kernel: +#startup loops: 2.
May 28 07:13:01 narayan kernel: Sending STARTUP #1.
May 28 07:13:01 narayan kernel: After apic_write.
May 28 07:13:01 narayan kernel: Initializing CPU#1
May 28 07:13:01 narayan kernel: CPU#1 (phys ID: 0) waiting for CALLOUT
May 28 07:13:01 narayan kernel: Startup point 1.
May 28 07:13:01 narayan kernel: Waiting for send to finish...
May 28 07:13:01 narayan kernel: +Sending STARTUP #2.
May 28 07:13:01 narayan kernel: After apic_write.
May 28 07:13:01 narayan kernel: Startup point 1.
May 28 07:13:01 narayan kernel: Waiting for send to finish...
May 28 07:13:01 narayan kernel: +After Startup.
May 28 07:13:01 narayan kernel: Before Callout 1.
May 28 07:13:01 narayan kernel: After Callout 1.
May 28 07:13:01 narayan kernel: CALLIN, before setup_local_APIC().
May 28 07:13:01 narayan kernel: masked ExtINT on CPU#1
May 28 07:13:01 narayan kernel: ESR value before enabling vector: 00000000
May 28 07:13:01 narayan kernel: ESR value after enabling vector: 00000000
May 28 07:13:01 narayan kernel: Calibrating delay loop... 801.17 BogoMIPS
May 28 07:13:01 narayan kernel: Stack at about dfff3fbc
May 28 07:13:01 narayan kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 28 07:13:01 narayan kernel: CPU: L2 cache: 512K
May 28 07:13:01 narayan kernel: Intel machine check reporting enabled on CPU#1.
May 28 07:13:01 narayan kernel: OK.
May 28 07:13:01 narayan kernel: CPU1: Intel Pentium II (Deschutes) stepping 03
May 28 07:13:01 narayan kernel: CPU has booted.
May 28 07:13:01 narayan kernel: Before bogomips.
May 28 07:13:01 narayan kernel: Total of 2 processors activated (1600.71 BogoMIPS).
May 28 07:13:01 narayan kernel: Before bogocount - setting activated=1.
May 28 07:13:01 narayan kernel: Boot done.
May 28 07:13:01 narayan kernel: ENABLING IO-APIC IRQs
May 28 07:13:01 narayan kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
May 28 07:13:01 narayan kernel: Synchronizing Arb IDs.
May 28 07:13:01 narayan kernel: ..TIMER: vector=49 pin1=2 pin2=0
May 28 07:13:01 narayan kernel: testing the IO APIC.......................
May 28 07:13:01 narayan kernel: 
May 28 07:13:01 narayan kernel: .................................... done.
May 28 07:13:01 narayan kernel: calibrating APIC timer ...
May 28 07:13:01 narayan kernel: ..... CPU clock speed is 400.9099 MHz.
May 28 07:13:01 narayan kernel: ..... host bus clock speed is 100.2270 MHz.
May 28 07:13:01 narayan kernel: cpu: 0, clocks: 1002270, slice: 334090
May 28 07:13:01 narayan kernel: CPU0<T0:1002256,T1:668160,D:6,S:334090,C:1002270>
May 28 07:13:01 narayan kernel: cpu: 1, clocks: 1002270, slice: 334090
May 28 07:13:01 narayan kernel: CPU1<T0:1002256,T1:334064,D:12,S:334090,C:1002270>
May 28 07:13:01 narayan kernel: checking TSC synchronization across CPUs: passed.
May 28 07:13:01 narayan kernel: Setting commenced=1, go go go
May 28 07:13:01 narayan kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
May 28 07:13:01 narayan kernel: PCI: Using configuration type 1
May 28 07:13:01 narayan kernel: PCI: Probing PCI hardware
May 28 07:13:01 narayan kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
May 28 07:13:01 narayan kernel: PCI->APIC IRQ transform: (B0,I4,P3) -> 19
May 28 07:13:01 narayan kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 18
May 28 07:13:01 narayan kernel: PCI->APIC IRQ transform: (B0,I11,P0) -> 17
May 28 07:13:01 narayan kernel: PCI->APIC IRQ transform: (B0,I12,P0) -> 16
May 28 07:13:01 narayan kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
May 28 07:13:01 narayan kernel: Limiting direct PCI/PCI transfers.
May 28 07:13:01 narayan kernel: isapnp: Scanning for PnP cards...
May 28 07:13:01 narayan kernel: isapnp: SB audio device quirk - increasing port range
May 28 07:13:01 narayan kernel: isapnp: AWE32 quirk - adding two ports
May 28 07:13:01 narayan kernel: isapnp: Card 'Creative SB AWE64  PnP'
May 28 07:13:01 narayan kernel: isapnp: 1 Plug & Play card detected total
May 28 07:13:01 narayan kernel: Linux NET4.0 for Linux 2.4
May 28 07:13:01 narayan kernel: Based upon Swansea University Computer Society NET3.039
May 28 07:13:01 narayan kernel: Initializing RT netlink socket
May 28 07:13:01 narayan kernel: Starting kswapd v1.8
May 28 07:13:01 narayan kernel: VFS: Diskquotas version dquot_6.4.0 initialized
May 28 07:13:01 narayan kernel: parport0: PC-style at 0x378 [PCSPP,TRISTATE]
May 28 07:13:01 narayan kernel: pty: 256 Unix98 ptys configured
May 28 07:13:01 narayan kernel: lp0: using parport0 (polling).
May 28 07:13:01 narayan kernel: Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
May 28 07:13:01 narayan kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
May 28 07:13:01 narayan kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
May 28 07:13:01 narayan kernel: block: queued sectors max/low 340517kB/209445kB, 1024 slots per queue
May 28 07:13:01 narayan kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
May 28 07:13:01 narayan kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 28 07:13:01 narayan kernel: PIIX4: IDE controller on PCI bus 00 dev 21
May 28 07:13:01 narayan kernel: PIIX4: chipset revision 1
May 28 07:13:01 narayan kernel: PIIX4: not 100%% native mode: will probe irqs later
May 28 07:13:01 narayan kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
May 28 07:13:01 narayan kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
May 28 07:13:01 narayan kernel: hda: ST320430A, ATA DISK drive
May 28 07:13:01 narayan kernel: hdb: ST38641A, ATA DISK drive
May 28 07:13:01 narayan kernel: hdc: SONY CDU4811, ATAPI CD/DVD-ROM drive
May 28 07:13:01 narayan kernel: hdd: Maxtor 86480D6, ATA DISK drive
May 28 07:13:01 narayan kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 28 07:13:01 narayan kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 28 07:13:01 narayan kernel: hda: 40079088 sectors (20520 MB) w/512KiB Cache, CHS=2494/255/63, UDMA(33)
May 28 07:13:01 narayan kernel: hdb: 16809660 sectors (8607 MB) w/128KiB Cache, CHS=1046/255/63, UDMA(33)
May 28 07:13:01 narayan kernel: hdd: 12658776 sectors (6481 MB) w/256KiB Cache, CHS=13395/15/63, UDMA(33)
May 28 07:13:01 narayan kernel: hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
May 28 07:13:01 narayan kernel: Uniform CD-ROM driver Revision: 3.12
May 28 07:13:01 narayan kernel: Partition check:
May 28 07:13:01 narayan kernel:  hda: hda1 hda2 < hda5 hda6 hda7 > hda3
May 28 07:13:01 narayan kernel:  hdb: hdb1
May 28 07:13:01 narayan kernel:  hdd: hdd1
May 28 07:13:01 narayan kernel: Floppy drive(s): fd0 is 1.44M
May 28 07:13:01 narayan kernel: FDC 0 is a post-1991 82077
May 28 07:13:01 narayan kernel: loop: loaded (max 8 devices)
May 28 07:13:01 narayan kernel: 3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
May 28 07:13:01 narayan kernel: See Documentation/networking/vortex.txt
May 28 07:13:01 narayan kernel: eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0xb800,  00:01:02:a2:a8:70, IRQ 17
May 28 07:13:01 narayan kernel:   product code 4347 rev 00.12 date 06-24-00
May 28 07:13:01 narayan kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
May 28 07:13:01 narayan kernel:   MII transceiver found at address 24, status 786d.
May 28 07:13:01 narayan kernel:   Enabling bus-master transmits and whole-frame receives.
May 28 07:13:01 narayan kernel: eth0: scatter/gather enabled. h/w checksums enabled
May 28 07:13:01 narayan kernel: eth1: 3Com PCI 3c905B Cyclone 100baseTx at 0xb400,  00:01:02:a2:a8:2e, IRQ 16
May 28 07:13:01 narayan kernel:   product code 4347 rev 00.12 date 06-24-00
May 28 07:13:01 narayan kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
May 28 07:13:01 narayan kernel:   MII transceiver found at address 24, status 7849.
May 28 07:13:01 narayan kernel:   Enabling bus-master transmits and whole-frame receives.
May 28 07:13:01 narayan kernel: eth1: scatter/gather enabled. h/w checksums enabled
May 28 07:13:01 narayan kernel: SCSI subsystem driver Revision: 1.00
May 28 07:13:01 narayan kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
May 28 07:13:01 narayan kernel:         <Adaptec 2940 Ultra SCSI adapter>
May 28 07:13:01 narayan kernel:         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs
May 28 07:13:01 narayan kernel: 
May 28 07:13:01 narayan kernel:   Vendor: EXABYTE   Model: IBM-8505          Rev: 808A
May 28 07:13:01 narayan kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
May 28 07:13:01 narayan kernel:   Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.07
May 28 07:13:01 narayan kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
May 28 07:13:01 narayan kernel: Detected scsi tape st0 at scsi0, channel 0, id 1, lun 0
May 28 07:13:01 narayan kernel: st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
May 28 07:13:01 narayan kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
May 28 07:13:01 narayan kernel: (scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 8)
May 28 07:13:01 narayan kernel: sr0: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
May 28 07:13:01 narayan kernel: Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
May 28 07:13:01 narayan kernel: sb: Creative SB AWE64  PnP detected
May 28 07:13:01 narayan kernel: sb: ISAPnP reports 'Creative SB AWE64  PnP' at i/o 0x220, irq 5, dma 1, 5
May 28 07:13:01 narayan kernel: sb: 1 Soundblaster PnP card(s) found.
May 28 07:13:01 narayan kernel: Linux PCMCIA Card Services 3.1.22
May 28 07:13:01 narayan kernel:   options:  [pci] [cardbus] [pm]
May 28 07:13:01 narayan kernel: usb.c: registered new driver usbdevfs
May 28 07:13:01 narayan kernel: usb.c: registered new driver hub
May 28 07:13:01 narayan kernel: usb-uhci.c: $Revision: 1.259 $ time 07:08:42 May 28 2001
May 28 07:13:01 narayan kernel: usb-uhci.c: High bandwidth mode enabled
May 28 07:13:01 narayan kernel: usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 19
May 28 07:13:01 narayan kernel: usb-uhci.c: Detected 2 ports
May 28 07:13:01 narayan kernel: usb.c: new USB bus registered, assigned bus number 1
May 28 07:13:01 narayan kernel: hub.c: USB hub found
May 28 07:13:01 narayan kernel: hub.c: 2 ports detected
May 28 07:13:01 narayan kernel: usb-uhci.c: v1.251 Georg Acher, Deti Fliegl, Thomas Sailer, Roman Weissgaerber
May 28 07:13:01 narayan kernel: usb-uhci.c: USB Universal Host Controller Interface driver
May 28 07:13:01 narayan kernel: usb.c: registered new driver audio
May 28 07:13:01 narayan kernel: audio.c: v1.0.0 Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Sailer (sailer@ife.ee.ethz.ch)
May 28 07:13:01 narayan kernel: audio.c: USB Audio Class driver
May 28 07:13:01 narayan kernel: NET4: Linux TCP/IP 1.0 for NET4.0
May 28 07:13:01 narayan kernel: IP Protocols: ICMP, UDP, TCP
May 28 07:13:01 narayan kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
May 28 07:13:01 narayan kernel: TCP: Hash tables configured (established 32768 bind 32768)
May 28 07:13:01 narayan kernel: ip_conntrack (4095 buckets, 32760 max)
May 28 07:13:01 narayan kernel: ip_tables: (c)2000 Netfilter core team
May 28 07:13:01 narayan kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
May 28 07:13:01 narayan kernel: ACPI: Core Subsystem version [20010208]
May 28 07:13:01 narayan kernel: ACPI: Using ACPI idle
May 28 07:13:01 narayan kernel: ACPI: If experiencing system slowness, try adding "acpi=no-idle" to cmdline
May 28 07:13:01 narayan kernel: ACPI: System firmware supports: S0 S1 S5
May 28 07:13:01 narayan kernel: hub.c: USB new device connect on bus1/1, assigned device number 2
May 28 07:13:01 narayan kernel: ds: no socket drivers loaded!
May 28 07:13:01 narayan kernel: VFS: Mounted root (ext2 filesystem) readonly.
May 28 07:13:01 narayan kernel: Freeing unused kernel memory: 208k freed
May 28 07:13:01 narayan kernel: usbaudio: device 2 audiocontrol interface 1 has 1 input and 0 output AudioStreaming interfaces
May 28 07:13:01 narayan kernel: usbaudio: device 2 interface 2 altsetting 1: format 0x00000010 sratelo 44100 sratehi 44100 attributes 0x00
May 28 07:13:01 narayan kernel: usbaudio: device 2 interface 2 altsetting 2: format 0x00000010 sratelo 22050 sratehi 22050 attributes 0x00
May 28 07:13:01 narayan kernel: usbaudio: device 2 interface 2 altsetting 3: format 0x00000010 sratelo 11025 sratehi 11025 attributes 0x00
May 28 07:13:01 narayan kernel: usbaudio: device 2 interface 2 altsetting 4: format 0x00000010 sratelo 8000 sratehi 8000 attributes 0x00
May 28 07:13:01 narayan kernel: usbaudio: constructing mixer for Terminal 3 type 0x0101
May 28 07:13:01 narayan kernel: usbaudio: workaround for broken Philips Camera Microphone descriptor enabled
May 28 07:13:01 narayan kernel: hub.c: USB new device connect on bus1/2, assigned device number 3
May 28 07:13:01 narayan kernel: usbaudio: device 3 audiocontrol interface 0 has 1 input and 1 output AudioStreaming interfaces
May 28 07:13:01 narayan kernel: usbaudio: device 3 interface 2 altsetting 1: format 0x80000010 sratelo 32000 sratehi 48000 attributes 0x01
May 28 07:13:01 narayan kernel: usbaudio: device 3 interface 1 altsetting 1: format 0x80000010 sratelo 32000 sratehi 48000 attributes 0x01
May 28 07:13:01 narayan kernel: usbaudio: constructing mixer for Terminal 2 type 0x0301
May 28 07:13:01 narayan kernel: usbaudio: no mixer controls found for Terminal 2
May 28 07:13:01 narayan kernel: usbaudio: constructing mixer for Terminal 5 type 0x0101
May 28 07:13:01 narayan kernel: Adding Swap: 524280k swap-space (priority -1)
May 28 07:13:01 narayan kernel: eth0: using NWAY device table, not 8
May 28 07:13:01 narayan kernel: eth1: using NWAY device table, not 8

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_EISA=y
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
# CONFIG_IP_NF_MATCH_TCPMSS is not set
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
CONFIG_ETHERTAP=y
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=y
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_PCMCIA_PCNET=y
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
# CONFIG_PCMCIA_XIRTULIP is not set
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=y
# CONFIG_PCMCIA_NETWAVE is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_AIRONET4500_CS is not set
CONFIG_PCMCIA_NETCARD=y

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_MGA=m

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=y
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=y
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y

#
# USB Controllers
#
CONFIG_USB_UHCI=y
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=y
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#

#
#   Input core support is needed for USB HID
#

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_NET1080 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB misc drivers
#
# CONFIG_USB_RIO500 is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

--Nq2Wo0NMKNjxTN9z--
