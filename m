Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270237AbTHBT7k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270239AbTHBT7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:59:40 -0400
Received: from caribou.intercarve.net ([66.111.34.130]:5389 "EHLO
	caribou.intercarve.net") by vger.kernel.org with ESMTP
	id S270237AbTHBT72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:59:28 -0400
Date: Sat, 2 Aug 2003 19:58:40 +0000 (GMT)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: "[list] linux-kernel" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: 2.6.0-test2 panic
Message-ID: <Pine.BSF.4.51.0308021936300.36940@caribou.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1] When I run CPU-heavy applications, the machine panics and reboots.

[2] oggenc, Quake 3, and compiling a kernel all cause my machine to panic.
Nothing is written to the console. Nothing is logged in /var/log/messages
or /var/log/syslog.

[3] n/a

[4] 2.6.0-test2, .config
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_EMBEDDED=y
CONFIG_IOSCHED_AS=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_NET=y
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6_SCTP__=y
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_PRIO=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_VIAPRO=m
CONFIG_SENSORS_VIA686A=m
CONFIG_I2C_SENSOR=m
CONFIG_AGP=m
CONFIG_AGP_VIA=m
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_EXT2_FS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_RAMFS=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_3DFX=m
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SOUND_PRIME=y
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_VIA82CXXX=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_ZLIB_INFLATE=m
CONFIG_X86_BIOS_REBOOT=y

[5] n/a

[6] n/a

[7] Obviously Quake 3 runs under X, but running either oggenc or
recompiling my kernel while not running X, still causes the panic.

[7.1]	ver_linux output:
	Gnu C                  3.3.1
	Gnu make               3.80
	util-linux             2.11z
	mount                  2.11z
	e2fsprogs              1.34
	Linux C Library        2.3.1
	Dynamic linker (ldd)   2.3.1
	Procps                 3.1.11
	Net-tools              1.60
	Console-tools          0.2.3
	Sh-utils               5.0
	Modules Loaded         tdfx binfmt_misc snd_seq_midi snd_seq_oss
	snd_seq_midi_event snd_seq snd_via82xx snd_mpu401_uart nls_cp437 smbfs
	af_packet uhci_hcd ohci_hcd ehci_hcd psmouse mousedev usbcore ide_scsi
	sr_mod cdrom sg scsi_mod 8139too mii crc32 snd_pcm_oss snd_mixer_oss
	snd_ens1371 snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer
	snd_ac97_codec unix


[7.2]	contents of /proc/cpuinfo:
	processor       : 0
	vendor_id       : AuthenticAMD
	cpu family      : 6
	model           : 6
	model name      : AMD Athlon(tm) XP 2100+
	stepping        : 2
	cpu MHz         : 1741.077
	cache size      : 256 KB
	fdiv_bug        : no
	hlt_bug         : no
	f00f_bug        : no
	coma_bug        : no
	fpu             : yes
	fpu_exception   : yes
	cpuid level     : 1
	wp              : yes
	flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
	cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
	bogomips        : 3440.64


[7.3]	contents of /proc/modules:
	tdfx 27112 24 - Live 0xe092a000
	binfmt_misc 5448 1 - Live 0xe08b2000
	snd_seq_midi 3872 0 - Live 0xe08f2000
	snd_seq_oss 24576 0 - Live 0xe0917000
	snd_seq_midi_event 3264 2 snd_seq_midi,snd_seq_oss, Live 0xe08ec000
	snd_seq 38608 5 snd_seq_midi,snd_seq_oss,snd_seq_midi_event, Live
	0xe090c000
	snd_via82xx 10784 0 - Live 0xe08e3000
	snd_mpu401_uart 3520 1 snd_via82xx, Live 0xe0894000
	nls_cp437 4352 8 - Live 0xe08e0000
	smbfs 51192 5 [unsafe], Live 0xe08fe000
	af_packet 12680 0 - Live 0xe08e7000
	uhci_hcd 22608 0 - Live 0xe08b9000
	ohci_hcd 12480 0 - Live 0xe08c7000
	ehci_hcd 17476 0 - Live 0xe08c1000
	psmouse 9800 0 - Live 0xe08b5000
	mousedev 4948 1 - Live 0xe0841000
	usbcore 73436 5 uhci_hcd,ohci_hcd,ehci_hcd, Live 0xe08cd000
	ide_scsi 9664 0 - Live 0xe08ac000
	sr_mod 9316 0 - Live 0xe0890000
	cdrom 28896 1 sr_mod, Live 0xe0896000
	sg 23896 0 - Live 0xe085f000
	scsi_mod 43932 3 ide_scsi,sr_mod,sg, Live 0xe08a0000
	8139too 12992 0 - Live 0xe0867000
	mii 2496 1 8139too, Live 0xe0846000
	crc32 2944 1 8139too, Live 0xe0844000
	snd_pcm_oss 39268 0 - Live 0xe0880000
	snd_mixer_oss 12864 1 snd_pcm_oss, Live 0xe085a000
	snd_ens1371 10468 0 - Live 0xe080b000
	snd_rawmidi 14048 3 snd_seq_midi,snd_mpu401_uart,snd_ens1371, Live
	0xe0855000
	snd_seq_device 3976 4 snd_seq_midi,snd_seq_oss,snd_seq,snd_rawmidi, Live
	0xe083f000
	snd_pcm 62052 3 snd_via82xx,snd_pcm_oss,snd_ens1371, Live 0xe086f000
	snd_page_alloc 4228 2 snd_via82xx,snd_pcm, Live 0xe080f000
	snd_timer 15044 2 snd_seq,snd_pcm, Live 0xe083a000
	snd_ac97_codec 39300 2 snd_via82xx,snd_ens1371, Live 0xe084a000
	unix 17648 178 - Live 0xe0813000

[7.4]	contents of /proc/ioports:
	0000-001f : dma1
	0020-0021 : pic1
	0040-005f : timer
	0060-006f : keyboard
	0080-008f : dma page reg
	00a0-00a1 : pic2
	00c0-00df : dma2
	00f0-00ff : fpu
	0170-0177 : ide1
	01f0-01f7 : ide0
	02f8-02ff : serial
	0376-0376 : ide1
	03c0-03df : vga+
	03f6-03f6 : ide0
	03f8-03ff : serial
	0cf8-0cff : PCI conf1
	b000-bfff : PCI Bus #01
	  bc00-bcff : 3Dfx Interactive, In Voodoo 3
	e400-e4ff : Realtek Semiconducto RTL-8139/8139C/8139C
	  e400-e4ff : 8139too
	e800-e81f : VIA Technologies, In USB
	  e800-e81f : uhci-hcd
	ec00-ec3f : Ensoniq ES1371 [AudioPCI-97]
	  ec00-ec3f : Ensoniq AudioPCI
	fc00-fc0f : VIA Technologies, In VT82C586/B/686A/B PI

	contents of /proc/iomem:
	0000-001f : dma1
	0020-0021 : pic1
	0040-005f : timer
	0060-006f : keyboard
	0080-008f : dma page reg
	00a0-00a1 : pic2
	00c0-00df : dma2
	00f0-00ff : fpu
	0170-0177 : ide1
	01f0-01f7 : ide0
	02f8-02ff : serial
	0376-0376 : ide1
	03c0-03df : vga+
	03f6-03f6 : ide0
	03f8-03ff : serial
	0cf8-0cff : PCI conf1
	b000-bfff : PCI Bus #01
	  bc00-bcff : 3Dfx Interactive, In Voodoo 3
	e400-e4ff : Realtek Semiconducto RTL-8139/8139C/8139C
	  e400-e4ff : 8139too
	e800-e81f : VIA Technologies, In USB
	  e800-e81f : uhci-hcd
	ec00-ec3f : Ensoniq ES1371 [AudioPCI-97]
	  ec00-ec3f : Ensoniq AudioPCI
	fc00-fc0f : VIA Technologies, In VT82C586/B/686A/B PI


[7.5]	output of lspci -vvv
	00:00.0 Host bridge: VIA Technologies, Inc. VT8375 [KM266] Host Bridge
	        Subsystem: VIA Technologies, Inc. VT8375 [KM266] Host Bridge
	        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
	        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort+ >SERR- <PERR-
	        Latency: 8
	        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	        Capabilities: [a0] AGP version 2.0
	                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
	HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
	                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
	Rate=<none>
	        Capabilities: [c0] Power Management version 2
	                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
	PME(D0-,D1-,D2-,D3hot-,D3cold-)
	                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
	(prog-if 00 [Normal decode])
	        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR+ FastB2B-
	        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort+ >SERR- <PERR-
	        Latency: 0
	        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	        I/O behind bridge: 0000b000-0000bfff
	        Memory behind bridge: dbe00000-dfefffff
	        Prefetchable memory behind bridge: d7c00000-dbcfffff
	        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	        Capabilities: [80] Power Management version 2
	                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
	PME(D0-,D1-,D2-,D3hot-,D3cold-)
	                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	00:0b.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
	        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
	<TAbort+ <MAbort+ >SERR- <PERR-
	        Latency: 32 (3000ns min, 32000ns max)
	        Interrupt: pin A routed to IRQ 19
	        Region 0: I/O ports at ec00 [size=64]
	        Capabilities: [dc] Power Management version 1
	                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
	PME(D0+,D1-,D2+,D3hot+,D3cold-)
	                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
	[UHCI])
	        Subsystem: VIA Technologies, Inc. USB
        	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
	        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
	        Latency: 32, cache line size 08
	        Interrupt: pin A routed to IRQ 21
	        Region 4: I/O ports at e800 [size=32]
	        Capabilities: [80] Power Management version 2
	                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
	PME(D0+,D1+,D2+,D3hot+,D3cold+)
	                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if
	20 [EHCI])
	        Subsystem: Giga-byte Technology GA-7VAX Mainboard
	        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
	        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
	        Latency: 32, cache line size 10
	        Interrupt: pin D routed to IRQ 21
	        Region 0: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
	        Capabilities: [80] Power Management version 2
	                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
	PME(D0+,D1+,D2+,D3hot+,D3cold+)
	                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	        Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
        	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping+ SERR- FastB2B-
        	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
        	Latency: 0
	        Capabilities: [c0] Power Management version 2
        	        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
	PME(D0-,D1-,D2-,D3hot-,D3cold-)
        	        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
	Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	        Subsystem: VIA Technologies, Inc. VT8235 Bus Master
	ATA133/100/66/33 IDE
	        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
	        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
	        Latency: 32
	        Interrupt: pin A routed to IRQ 255
	        Region 4: I/O ports at fc00 [size=16]
	        Capabilities: [c0] Power Management version 2
	                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
	PME(D0-,D1-,D2-,D3hot-,D3cold-)
	                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
	RTL-8139/8139C/8139C+ (rev 10)
        	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
        	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
        	Latency: 32 (8000ns min, 16000ns max)
	        Interrupt: pin A routed to IRQ 18
        	Region 0: I/O ports at e400 [size=256]
	        Region 1: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
        	Capabilities: [50] Power Management version 2
	                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
	PME(D0-,D1+,D2+,D3hot+,D3cold+)
	                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
	01) (prog-if 00 [VGA])
	        Subsystem: 3Dfx Interactive, Inc.: Unknown device 1252
	        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-
	        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
	<TAbort- <MAbort- >SERR- <PERR+
	        Interrupt: pin A routed to IRQ 16
	        Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=32M]
	        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=32M]
	        Region 2: I/O ports at bc00 [size=256]
	        Expansion ROM at dfef0000 [disabled] [size=64K]
	        Capabilities: [54] AGP version 1.0
	                Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
	HTrans- 64bit+ FW- AGP3- Rate=x1,x2
	                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
	Rate=<none>
	        Capabilities: [60] Power Management version 1
	                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
	PME(D0-,D1-,D2-,D3hot-,D3cold-)
        	        Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6] contents of /proc/scsi/scsi:
	Attached devices:
	Host: scsi0 Channel: 00 Id: 00 Lun: 00
	  Vendor: PHILIPS  Model: CDRW4012P        Rev: P1.5
	  Type:   CD-ROM                           ANSI SCSI revision: 02



Regards,
Drew Vogel

