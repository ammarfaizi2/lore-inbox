Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLPMzD>; Sat, 16 Dec 2000 07:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLPMyx>; Sat, 16 Dec 2000 07:54:53 -0500
Received: from [62.81.160.68] ([62.81.160.68]:18658 "EHLO smtp2.alehop.com")
	by vger.kernel.org with ESMTP id <S129340AbQLPMyv> convert rfc822-to-8bit;
	Sat, 16 Dec 2000 07:54:51 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0
From: "Ignacio Monge" <ignaciomonge@navegalia.com>
To: linux-kernel@vger.kernel.org
Subject: Total freeze of the system after random time.
X-Mailer: Pronto v2.2.2 On linux
Date: 16 Dec 2000 13:21:56 CET
Reply-To: "Ignacio Monge" <ignaciomonge@navegalia.com>
Message-Id: <20001216125452Z129340-439+4185@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel Bug: Total freeze of the system after random time.

Description: From 2.4.0test12 (patch 7), 2.4.0-test13pre2 too, my linux system
freeze EVER after a variable time (one hour or two). There is not a backtrace,
or kernel message dump, it only stayed freezed y I must restart the computer.
It happaned when I went back to a window o task, that it had been inactive for
a minutes (may be cache?).
Sorry about my horrible english, and my poor description, I'm not a programmer
o somethig else, I'm a doctor of medicine and I don't know much about kenel
problems report. I hope I can help you.
	Thanks, Ignacio.

Keyword: kernel

Kernel Version: Linux version 2.4.0-test13-pre2 (root@localhost.localdomain)
(gcc version 2.96 20000731 (Red Hat Linux 7.0)) #1 sáb dic 16 06:27:52 CET 2000

Enviroment: 
	* Software: 
		- Linux localhost.localdomain 2.4.0-test13-pre2 #1 sáb dic 16
06:27:52 CET 2000 i686 unknown
		- Kernel modules	 2.3.21
		- Gnu C 		 2.96
		- Gnu Make		 3.79.1
		- Binutils		 2.10.1.0.2
		- Linux C Library	 > libc.2.2
		- Dynamic linker	 ldd (GNU libc) 2.2
		- Procps		 2.0.7
		- Mount 		 2.10m
		- Net-tools		 1.56
		- Console-tools 	 0.3.3
		- Sh-utils		 2.0
		- Modules Loaded	 ppp_deflate ppp_async ppp_generic slhc
parport_pc lp parport nls_iso8859-1 nls_cp437 vfat fat sb sb_lib uart401 sound
unix

	*Processor: 
		- processor	  : 0
		- vendor_id	  : GenuineIntel
		- cpu family	  : 6
		- model 	  : 3
		- model name	  : Pentium II (Klamath)
		- stepping	  : 4
		- cpu MHz	  : 233.869
		- cache size	  : 512 KB
		- fdiv_bug	  : no
		- hlt_bug	  : no
		- f00f_bug	  : no
		- coma_bug	  : no
		- fpu		  : yes
		- fpu_exception   : yes
		- cpuid level	  : 2
		- wp		  : yes
		- flags 	  : fpu vme de pse tsc msr pae mce cx8 sep mtrr
pge mca cmov mmx
		- bogomips	  : 466.94

	* Module information:
		- ppp_deflate		 41344	 0 (autoclean)
		- ppp_async		  6448	 1 (autoclean)	
		- ppp_generic		 12864	 3 (autoclean) [ppp_deflate
ppp_async]
		- slhc			  4800	 0 (autoclean) [ppp_generic]
		- parport_pc		 13648	 1 (autoclean)
		- lp			  5040	 0 (autoclean)
		- parport		 24640	 1 (autoclean) [parport_pc lp]
		- nls_	iso8859-1	    2880   1 (autoclean)
		- nls_cp437		  4400	 1 (autoclean)
		- vfat			 11440	 1 (autoclean)
		- fat			 31360	 0 (autoclean) [vfat]
		- sb			  6368	 0
		- sb_lib		 34096	 0 [sb]
		- uart401		  6320	 0 [sb_lib]
		- sound 		 56992	 0 [sb_lib uart401]
		- unix			 14608	29 (autoclean)

	* Loaded driver and hardware information:
		a) cat /proc/oiproc:
                
		0000-001f : dma1
		0020-003f : pic1
		0040-005f : timer
		0060-006f : keyboard
		0080-008f : dma page reg
		00a0-00bf : pic2
		00c0-00df : dma2
		00f0-00ff : fpu
		0170-0177 : ide1
		01f0-01f7 : ide0
		0213-0213 : isapnp read
		0220-022f : soundblaster
		02f8-02ff : serial(auto)
		0376-0376 : ide1
		0378-037a : parport0
		03c0-03df : vga+
		03f6-03f6 : ide0
		03f8-03ff : serial(auto)
		0a79-0a79 : isapnp write
		0cf8-0cff : PCI conf1
		4000-403f : Intel Corporation 82371AB PIIX4 ACPI
		5000-501f : Intel Corporation 82371AB PIIX4 ACPI
		d000-dfff : PCI Bus #01
		  d000-d0ff : 3Dfx Interactive, Inc. Voodoo Banshee
		e000-e01f : Intel Corporation 82371AB PIIX4 USB
		f000-f00f : Intel Corporation 82371AB PIIX4 IDE

		b) cat /proc/iomem:

		00000000-0009fbff : System RAM
		0009fc00-0009ffff : System RAM
		000a0000-000bffff : Video RAM area
		000c0000-000c7fff : Video ROM
		000f0000-000fffff : System ROM
		00100000-05ffffff : System RAM
		  00100000-00228b5f : Kernel code
		  00228b60-0023b30f : Kernel data
		e0000000-e7ffffff : Intel Corporation 440LX/EX - 82443LX/EX
Host bridge
		e8000000-ebffffff : PCI Bus #01
		  e8000000-e9ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
		ec000000-edffffff : PCI Bus #01
		  ec000000-edffffff : 3Dfx Interactive, Inc. Voodoo Banshee
		ee000000-ee000fff : Brooktree Corporation Bt848 TV with DMA
push
		ffff0000-ffffffff : reserved

	* PCI information: 
		00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX
Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev 03)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e8000000-ebffffff
	Prefetchable memory behind bridge: ec000000-edffffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80
[Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if
00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0b.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA
push (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at ee000000 (32-bit, prefetchable) [size=4K]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev
03) (prog-if 00 [VGA])
	Subsystem: Creative Labs: Unknown device 1018
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at ec000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at d000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [54] AGP version 1.0
		Status: RQ=7 SBA+ 64bit+ FW- Rate=x1
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        
	* SCSI Information:
		a) cat /proc/scsi/ide-scsi/0: SCSI host adapter emulation for
IDE ATAPI devices
		b) cat /proc/scsi/scsi :
					Attached devices: 
					Host: scsi0 Channel: 00 Id: 00 Lun: 00
					  Vendor: ATAPI    Model: CD-ROM
DRIVE-40X Rev: T0FP
					  Type:   CD-ROM		       
   ANSI SCSI revision: 02
					Host: scsi0 Channel: 00 Id: 01 Lun: 00
					  Vendor: PLEXTOR  Model: CD-R	
PX-W8432T Rev: 1.05
					  Type:   CD-ROM		       
   ANSI SCSI revision: 02
		c) cat	/proc/ssi/sg/debug: 
			dev_max(currently)=8 max_active_device=2 (origin 1)
			 scsi_dma_free_sectors=128 sg_pool_secs_aval=320
def_reserved_size=32768
		d) cat /proc/scsi/sg/def_reserved_size: 32768
		e) cat /proc/scsi/sg/device_hdr: host	 chan	 id	 lun   
 type	 bopens  qdepth  busy
		f) cat /proc/scsi/sg/devices:
			0	0	0	0	5	0	5      
0
			0	0	1	0	5	0	5      
0
		g) cat /proc/scsi/sg/device_strs: 
			ATAPI		CD-ROM DRIVE-40X	T0FP
			PLEXTOR 	CD-R   PX-W8432T	1.05
		h) cat /proc/scsi/sg/host_hdr: uid     busy    cpl     scatg  
isa	emul
		i) cat /proc/scsi/sg/hosts: 
			0	0	5	256	0	
		j)  cat /proc/scsi/sg/host_strs: SCSI host adapter emulation
for IDE ATAPI devices
		k) cat /proc/scsi/sg/version: 30117   Version: 3.1.17
(20001002)
                
        
	* Other Information:
        
		-  cat /proc/bus/pci/devices:
	0000	80867180	0	e0000008	00000000       
00000000	00000000 00000000	 00000000	 00000000	
08000000	0000000000000000 00000000	 00000000	 00000000      
 00000000	 
0008	80867181	0	00000000	00000000	00000000       
00000000 00000000	 00000000	 00000000	 00000000	
0000000000000000 00000000	 00000000	 00000000	 00000000        
0038	80867110	0	00000000	00000000	00000000       
00000000 00000000	 00000000	 00000000	 00000000	
0000000000000000 00000000	 00000000	 00000000	 00000000        
0039	80867111	0	00000000	00000000	00000000       
00000000 0000f001	 00000000	 00000000	 00000000	
0000000000000000 00000000	 00000010	 00000000	 00000000        
003a	80867112	a	00000000	00000000	00000000       
00000000 0000e001	 00000000	 00000000	 00000000	
0000000000000000 00000000	 00000020	 00000000	 00000000        
003b	80867113	0	00000000	00000000	00000000       
00000000 00000000	 00000000	 00000000	 00000000	
0000000000000000 00000000	 00000000	 00000000	 00000000        
0058	109e0350	c	ee000008	00000000	00000000       
00000000 00000000	 00000000	 00000000	 00001000	
0000000000000000 00000000	 00000000	 00000000	 00000000        
0100	121a0003	b	e8000000	ec000008	0000d001       
00000000 00000000	 00000000	 00000000	 02000000	
0200000000000100 00000000	 00000000	 00000000	 00010000   
                                
		- cat /proc/bus/isapnp/devices:
		0100	ALS0110@@@1001 
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fff
		0101	ALS0110@H@1001 
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fff
		0102	ALS0110@P@1001 
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fff
		0103	ALS0110@X@1001 
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fff
        
		- cat /proc/slabinfo:
                
			slabinfo - version: 1.1
			kmem_cache	      53     78    100	  2    2    1
			tcp_tw_bucket	       0     40     96	  0    1    1
			tcp_bind_bucket        2    113     32	  1    1    1
			tcp_open_request       0      0     64	  0    0    1
			inet_peer_cache        0      0     64	  0    0    1
			ip_fib_hash	       3    113     32	  1    1    1
			ip_dst_cache	      20     24    160	  1    1    1
			arp_cache	       1     30    128	  1    1    1
			blkdev_requests     1792   2080     96	 45   52    1
			dnotify cache	       0      0     20	  0    0    1
			file lock cache        2     42     92	  1    1    1
			fasync cache	       1    202     16	  1    1    1
			uid_cache	       1    113     32	  1    1    1
			skbuff_head_cache     62     72    160	  3    3    1
			sock		      35     50    800	  7   10    1
			inode_cache	    2762   2763    448	307  307    1
			bdev_cache	      69    118     64	  2    2    1
			sigqueue	       2     29    132	  1    1    1
			kiobuf		       0      0    128	  0    0    1
			dentry_cache	    3548   3570    128	119  119    1
			filp		     605    640     96	 16   16    1
			names_cache	       0      9   4096	  0    9    1
			buffer_head	   11449  11480     96	287  287    1
			mm_struct	      29     60    128	  1    2    1
			vm_area_struct	     935   1121     64	 17   19    1
			fs_cache	      28     59     64	  1    1    1
			files_cache	      28     36    416	  4    4    1
			signal_act	      29     36   1312	 10   12    1
			size-131072(DMA)       0      0 131072	  0    0   32
			size-131072	       0      0 131072	  0    0   32
			size-65536(DMA)        0      0  65536	  0    0   16
			size-65536	       0      0  65536	  0    0   16
			size-32768(DMA)        0      0  32768	  0    0    8
			size-32768	       0      3  32768	  0    3    8
			size-16384(DMA)        0      0  16384	  0    0    4
			size-16384	       0      5  16384	  0    5    4
			size-8192(DMA)	       0      0   8192	  0    0    2
			size-8192	       0      2   8192	  0    2    2
			size-4096(DMA)	       0      0   4096	  0    0    1
			size-4096	       9     38   4096	  9   38    1
			size-2048(DMA)	       0      0   2048	  0    0    1
			size-2048	       5     22   2048	  3   11    1
			size-1024(DMA)	       0      0   1024	  0    0    1
			size-1024	      26     52   1024	  7   13    1
			size-512(DMA)	       0      0    512	  0    0    1
			size-512	      46     64    512	  6    8    1
			size-256(DMA)	       0      0    256	  0    0    1
			size-256	      17     30    256	  2    2    1
			size-128(DMA)	       0      0    128	  0    0    1
			size-128	     461    510    128	 17   17    1
			size-64(DMA)	       0      0     64	  0    0    1
			size-64 	     174    236     64	  3    4    1
			size-32(DMA)	       0      0     32	  0    0    1
			size-32 	     543    565     32	  5    5    1
        
		- cat /proc/mtrr:
			reg00: base=0x00000000 (   0MB), size=	64MB:
write-back, count=1
			reg01: base=0x04000000 (  64MB), size=	32MB:
write-back, count=1




                        
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
