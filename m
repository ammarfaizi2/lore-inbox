Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTBQDPO>; Sun, 16 Feb 2003 22:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbTBQDPO>; Sun, 16 Feb 2003 22:15:14 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:26637 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S266095AbTBQDOu>; Sun, 16 Feb 2003 22:14:50 -0500
Date: Sun, 16 Feb 2003 19:24:41 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Patrick Finnegan <pat@purdueriots.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug: usb-storage module
Message-ID: <20030216192441.A26961@one-eyed-alien.net>
Mail-Followup-To: Patrick Finnegan <pat@purdueriots.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302161815360.23692-200000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0302161815360.23692-200000@ibm-ps850.purdueriots.com>; from pat@purdueriots.com on Sun, Feb 16, 2003 at 08:07:43PM -0500
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hrm... when was the cache probing introduced? I'll bet the device doesn't
like that.

Matt

On Sun, Feb 16, 2003 at 08:07:43PM -0500, Patrick Finnegan wrote:
> [1.] One line summary of the problem:
>   Failure to 'read' from USB Storage Device
>=20
> [2.] Full description of the problem/report:
>   The kernel gives several I/O errors when my (Sony CyberShot DSC-P30) is
> connected to my computer.  This did not happen with earlier kernels,
> including 2.4.x kernels and kernel 2.5.47.
>=20
> [3.] Keywords (i.e., modules, networking, kernel):
>   USB SCSI usb-storage
>=20
> [4.] Kernel version (from /proc/version):
> Linux version 2.5.61 (root@dualie) (gcc version 3.2.3 20030210 (Debian
> prerelease)) #1 SMP Sun Feb 16 11:20:54 EST 2003
>=20
> [5.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/oops-tracing.txt)
>=20
> hub 1-0:0: new USB device on port 2, assigned address 4
> scsi0 : SCSI emulation for USB Mass Storage devices
>   Vendor: Sony      Model: Sony DSC          Rev: 3.22
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> SCSI device sda: 126848 512-byte hdwr sectors (65 MB)
> sda: test WP failed, assume Write Enabled
> sda: asking for cache data failed
> sda: assuming drive cache: write through
> SCSI device (ioctl) reports ILLEGAL REQUEST.
> SCSI device sda: 126848 512-byte hdwr sectors (65 MB)
> sda: test WP failed, assume Write Enabled
> sda: asking for cache data failed
> sda: assuming drive cache: write through
> SCSI device sda: 126848 512-byte hdwr sectors (65 MB)
> sda: test WP failed, assume Write Enabled
> sda: asking for cache data failed
> sda: assuming drive cache: write through
>  /dev/scsi/host0/bus0/target0/lun0:<3>Buffer I/O error on device sd(8,0),
> logical block 0
> Buffer I/O error on device sd(8,0), logical block 0
>  unable to read partition table
>  /dev/scsi/host0/bus0/target0/lun0:<3>Buffer I/O error on device sd(8,0),
> logical block 0
>  unable to read partition table
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 4
>=20
> [7.] Environment
> [7.1.] Software (add the output of the ver_linux script here)
>=20
> Linux dualie 2.5.61 #1 SMP Sun Feb 16 11:20:54 EST 2003 i686 unknown
> unknown GNU/Linux
>=20
> Gnu C                  3.2.3
> Gnu make               3.80
> util-linux             2.11y
> mount                  2.11y
> module-init-tools      0.9.9
> e2fsprogs              1.32
> Linux C Library        2.3.1
> Dynamic linker (ldd)   2.3.1
> Linux C++ Library      ..
> Procps                 3.1.5
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               4.5.7
> Modules Loaded         vfat fat smbfs ntfs usb_storage ohci_hcd usbcore
> sd_mod sr_mod sg reiserfs 8139too crc32 ide_scsi scsi_mod snd_cmipci
> snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi
> snd_seq_device snd soundcore nfs lockd sunrpc mousedev dm_mod ide_floppy
> ide_cd cdrom
>=20
> [7.2.] Processor information (from /proc/cpuinfo):
>=20
> vendor_id	: AuthenticAMD
> cpu family	: 6
> model		: 6
> model name	: AMD Athlon(TM) XP 1700+
> stepping	: 2
> cpu MHz		: 1466.620
> cache size	: 256 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
> bogomips	: 2875.39
>=20
> processor	: 1
> vendor_id	: AuthenticAMD
> cpu family	: 6
> model		: 6
> model name	: AMD Athlon(TM) XP 1700+
> stepping	: 2
> cpu MHz		: 1466.620
> cache size	: 256 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
> bogomips	: 2924.54
>=20
> [7.3.] Module information (from /proc/modules):
>=20
> vfat 9984 0 - Live 0xe0975000
> fat 36128 1 vfat, Live 0xe0a25000
> smbfs 55408 0 - Live 0xe09e4000
> ntfs 90768 1 - Live 0xe09cc000
> usb_storage 21632 0 - Live 0xe0952000
> ohci_hcd 12864 0 - Live 0xe0944000
> usbcore 74932 4 usb_storage,ohci_hcd, Live 0xe0961000
> sd_mod 11360 0 - Live 0xe091c000
> sr_mod 11488 0 - Live 0xe0918000
> sg 32268 0 - Live 0xe0924000
> reiserfs 188784 0 - Live 0xe097e000
> 8139too 14272 1 - Live 0xe0913000
> crc32 3136 1 8139too, Live 0xe08be000
> ide_scsi 10752 0 - Live 0xe08a0000
> scsi_mod 88356 5 usb_storage,sd_mod,sr_mod,sg,ide_scsi, Live 0xe092d000
> snd_cmipci 17112 1 - Live 0xe08a7000
> snd_pcm 63936 1 snd_cmipci, Live 0xe08e4000
> snd_opl3_lib 6656 1 snd_cmipci, Live 0xe08a4000
> snd_timer 12224 2 snd_pcm,snd_opl3_lib, Live 0xe087d000
> snd_hwdep 3904 1 snd_opl3_lib, Live 0xe089e000
> snd_mpu401_uart 3584 1 snd_cmipci, Live 0xe089c000
> snd_rawmidi 14976 1 snd_mpu401_uart, Live 0xe088e000
> snd_seq_device 3844 2 snd_opl3_lib,snd_rawmidi, Live 0xe088c000
> snd 33924 9
> snd_cmipci,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_r=
awmidi,snd_seq_device,
> Live 0xe08da000
> soundcore 4288 1 snd, Live 0xe0889000
> nfs 78188 4 - Live 0xe08f6000
> lockd 51536 2 nfs,[unsafe], Live 0xe08b0000
> sunrpc 99972 4 nfs,lockd,[unsafe], Live 0xe08c0000
> mousedev 5404 1 - Live 0xe0881000
> dm_mod 25604 5 - Live 0xe0894000
> ide_floppy 13952 0 - Live 0xe0884000
> ide_cd 32704 0 - Live 0xe0869000
> cdrom 29408 2 sr_mod,ide_cd, Live 0xe0874000
>=20
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
>=20
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 02f8-02ff : serial
> 0330-0331 : MPU401 UART
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : serial
> 0cf8-0cff : PCI conf1
> a000-afff : PCI Bus #02
>   a400-a4ff : Realtek Semiconducto RTL-8139/8139C/8139C
>     a400-a4ff : 8139too
>   a800-a8ff : C-Media Electronics  CM8738
>     a800-a8ff : CMI8738-MC6
> b800-b80f : Advanced Micro Devic AMD-768 [Opus] IDE
>   b800-b807 : ide0
>   b808-b80f : ide1
> d000-dfff : PCI Bus #01
>   d800-d8ff : ATI Technologies Inc Radeon RV200 QW [Rad
> e800-e803 : Advanced Micro Devic AMD-760 MP [IGD4-2P]
>=20
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-1ffebfff : System RAM
>   00100000-0028e12d : Kernel code
>   0028e12e-002e12c7 : Kernel data
> 1ffec000-1ffeefff : ACPI Tables
> 1ffef000-1fffefff : reserved
> 1ffff000-1fffffff : ACPI Non-volatile Storage
> dd800000-deffffff : PCI Bus #02
>   dd800000-dd8000ff : Realtek Semiconducto RTL-8139/8139C/8139C
>     dd800000-dd8000ff : 8139too
>   de000000-de000fff : Lucent Microelectron USS-312 USB Controll
>     de000000-de000fff : ohci-hcd
> df000000-dfefffff : PCI Bus #01
>   df000000-df00ffff : ATI Technologies Inc Radeon RV200 QW [Rad
> dff00000-ef7fffff : PCI Bus #01
>   e0000000-e7ffffff : ATI Technologies Inc Radeon RV200 QW [Rad
> ef800000-ef800fff : Advanced Micro Devic AMD-760 MP [IGD4-2P]
> f0000000-f7ffffff : Advanced Micro Devic AMD-760 MP [IGD4-2P]
> fec00000-fec00fff : reserved
> fee00000-fee00fff : reserved
> ffff0000-ffffffff : reserved
>=20
>=20
> [7.5.] PCI information ('lspci -vvv' as root)
>=20
> 00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
> System Controller (rev 11)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 32
> 	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
> 	Region 1: Memory at ef800000 (32-bit, prefetchable) [size=3D4K]
> 	Region 2: I/O ports at e800 [disabled] [size=3D4]
> 	Capabilities: [a0] AGP version 2.0
> 		Status: RQ=3D15 SBA+ 64bit- FW+ Rate=3Dx1,x2,x4
> 		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>
>=20
> 00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP
> Bridge (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
> 	I/O behind bridge: 0000d000-0000dfff
> 	Memory behind bridge: df000000-dfefffff
> 	Prefetchable memory behind bridge: dff00000-ef7fffff
> 	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
>=20
> 00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev
> 04)
> 	Subsystem: Asustek Computer, Inc. A7M-D Mainboard
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
>=20
> 00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
> (rev 04) (prog-if 8a [Master SecP PriP])
> 	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Region 4: I/O ports at b800 [size=3D16]
>=20
> 00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
> 	Subsystem: Asustek Computer, Inc. A7M-D Mainboard
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>=20
> 00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev
> 04) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
> 	I/O behind bridge: 0000a000-0000afff
> 	Memory behind bridge: dd800000-deffffff
> 	Prefetchable memory behind bridge: dff00000-dfefffff
> 	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>=20
> 01:05.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW
> [Radeon 7500] (prog-if 00 [VGA])
> 	Subsystem: ATI Technologies Inc Radeon 7500
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (2000ns min), cache line size 08
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
> 	Region 1: I/O ports at d800 [size=3D256]
> 	Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=3D64K]
> 	Expansion ROM at dffe0000 [disabled] [size=3D128K]
> 	Capabilities: [58] AGP version 2.0
> 		Status: RQ=3D47 SBA+ 64bit- FW- Rate=3Dx1,x2,x4
> 		Command: RQ=3D0 SBA+ AGP- 64bit- FW- Rate=3D<none>
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
> 10)
> 	Subsystem: Asustek Computer, Inc. CMI8738 6-channel audio
> controller
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (500ns min, 6000ns max)
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: I/O ports at a800 [size=3D256]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> 02:06.0 USB Controller: Lucent Microelectronics USS-312 USB Controller
> (rev 10) (prog-if 10 [OHCI])
> 	Subsystem: Lucent Microelectronics USS-312 USB Controller
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (750ns min, 21500ns max)
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=3D4K]
>=20
> 02:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
> 	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (8000ns min, 16000ns max)
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: I/O ports at a400 [size=3D256]
> 	Region 1: Memory at dd800000 (32-bit, non-prefetchable) [size=3D256]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>=20
> [7.6.] SCSI information (from /proc/scsi/scsi)
>=20
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: Sony     Model: Sony DSC         Rev: 3.22
>   Type:   Direct-Access                    ANSI SCSI revision: 02
>=20
> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
>=20
> /proc/bus/usb/devices:
>=20
> T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
> B:  Alloc=3D  0/900 us ( 0%), #Int=3D  1, #Iso=3D  0
> D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
> P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.05
> S:  Manufacturer=3DLinux 2.5.61 ohci-hcd
> S:  Product=3DLucent Microelectron USS-312 USB Controll
> S:  SerialNumber=3D02:06.0
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
>=20
> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  M=
xCh=3D 4
> D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
> P:  Vendor=3D058f ProdID=3D9254 Rev=3D 3.14
> S:  Manufacturer=3DALCOR
> S:  Product=3DGeneric USB Hub
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D255ms
>=20
> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D  3 Spd=3D12  M=
xCh=3D 0
> D:  Ver=3D 1.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
> P:  Vendor=3D054c ProdID=3D0010 Rev=3D 3.22
> S:  Manufacturer=3DSony
> S:  Product=3DSony DSC
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  2mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3D08(stor.) Sub=3Dff Prot=3D01 Driver=
=3Dusb-storage
> E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D83(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D255ms
>=20
> [X.] Other notes, patches, fixes, workarounds:
>=20
> .config is attached
>=20
> Pat
> --
> Purdue Universtiy ITAP/RCS
> Information Technology at Purdue
> Research Computing and Storage
> http://www-rcd.cc.purdue.edu

> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=3Dy
> CONFIG_MMU=3Dy
> CONFIG_SWAP=3Dy
> CONFIG_UID16=3Dy
> CONFIG_GENERIC_ISA_DMA=3Dy
>=20
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=3Dy
>=20
> #
> # General setup
> #
> CONFIG_SYSVIPC=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_LOG_BUF_SHIFT=3D15
>=20
> #
> # Loadable module support
> #
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> CONFIG_MODULE_FORCE_UNLOAD=3Dy
> CONFIG_OBSOLETE_MODPARM=3Dy
> # CONFIG_MODVERSIONS is not set
> # CONFIG_KMOD is not set
>=20
> #
> # Processor type and features
> #
> CONFIG_X86_PC=3Dy
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> CONFIG_MK7=3Dy
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> CONFIG_X86_CMPXCHG=3Dy
> CONFIG_X86_XADD=3Dy
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_X86_WP_WORKS_OK=3Dy
> CONFIG_X86_INVLPG=3Dy
> CONFIG_X86_BSWAP=3Dy
> CONFIG_X86_POPAD_OK=3Dy
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_GOOD_APIC=3Dy
> CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
> CONFIG_X86_USE_3DNOW=3Dy
> CONFIG_HUGETLB_PAGE=3Dy
> CONFIG_SMP=3Dy
> CONFIG_PREEMPT=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_NR_CPUS=3D2
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCE_NONFATAL=3Dy
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=3Dm
> CONFIG_X86_CPUID=3Dm
> # CONFIG_EDD is not set
> CONFIG_NOHIGHMEM=3Dy
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=3Dy
> CONFIG_HAVE_DEC_LOCK=3Dy
>=20
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=3Dy
> # CONFIG_SOFTWARE_SUSPEND is not set
>=20
> #
> # ACPI Support
> #
> # CONFIG_ACPI is not set
> CONFIG_APM=3Dm
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> CONFIG_APM_DO_ENABLE=3Dy
> CONFIG_APM_CPU_IDLE=3Dy
> CONFIG_APM_DISPLAY_BLANK=3Dy
> # CONFIG_APM_RTC_IS_GMT is not set
> # CONFIG_APM_ALLOW_INTS is not set
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> # CONFIG_CPU_FREQ is not set
>=20
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=3Dy
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=3Dy
> CONFIG_PCI_BIOS=3Dy
> CONFIG_PCI_DIRECT=3Dy
> # CONFIG_SCx200 is not set
> CONFIG_PCI_LEGACY_PROC=3Dy
> CONFIG_PCI_NAMES=3Dy
> CONFIG_ISA=3Dy
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_HOTPLUG is not set
>=20
> #
> # Executable file formats
> #
> CONFIG_KCORE_ELF=3Dy
> # CONFIG_KCORE_AOUT is not set
> CONFIG_BINFMT_AOUT=3Dm
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_BINFMT_MISC=3Dm
>=20
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
>=20
> #
> # Parallel port support
> #
> CONFIG_PARPORT=3Dm
> CONFIG_PARPORT_PC=3Dm
> CONFIG_PARPORT_PC_CML1=3Dm
> # CONFIG_PARPORT_SERIAL is not set
> CONFIG_PARPORT_PC_FIFO=3Dy
> # CONFIG_PARPORT_PC_SUPERIO is not set
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_PARPORT_1284=3Dy
>=20
> #
> # Plug and Play support
> #
> # CONFIG_PNP is not set
>=20
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=3Dy
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_NBD=3Dm
> CONFIG_BLK_DEV_RAM=3Dm
> CONFIG_BLK_DEV_RAM_SIZE=3D4096
> # CONFIG_LBD is not set
>=20
> #
> # ATA/ATAPI/MFM/RLL device support
> #
> CONFIG_IDE=3Dy
>=20
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=3Dy
>=20
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_BLK_DEV_IDEDISK=3Dy
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECD=3Dm
> CONFIG_BLK_DEV_IDEFLOPPY=3Dm
> CONFIG_BLK_DEV_IDESCSI=3Dm
> # CONFIG_IDE_TASK_IOCTL is not set
>=20
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=3Dy
> # CONFIG_BLK_DEV_GENERIC is not set
> CONFIG_IDEPCI_SHARE_IRQ=3Dy
> CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> # CONFIG_BLK_DEV_IDE_TCQ is not set
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> # CONFIG_IDEDMA_PCI_AUTO is not set
> CONFIG_BLK_DEV_IDEDMA=3Dy
> # CONFIG_IDEDMA_PCI_WIP is not set
> CONFIG_BLK_DEV_ADMA=3Dy
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> CONFIG_BLK_DEV_AMD74XX=3Dy
> CONFIG_BLK_DEV_CMD64X=3Dm
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_BLK_DEV_IDE_MODES=3Dy
>=20
> #
> # SCSI device support
> #
> CONFIG_SCSI=3Dm
>=20
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dm
> CONFIG_CHR_DEV_ST=3Dm
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=3Dm
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_CHR_DEV_SG=3Dm
>=20
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_REPORT_LUNS is not set
> CONFIG_SCSI_CONSTANTS=3Dy
> CONFIG_SCSI_LOGGING=3Dy
>=20
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AACRAID is not set
> CONFIG_SCSI_AIC7XXX=3Dm
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D32
> CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
> # CONFIG_AIC7XXX_PROBE_EISA_VL is not set
> # CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
> CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
> CONFIG_AIC7XXX_DEBUG_MASK=3D0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> CONFIG_SCSI_ADVANSYS=3Dm
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> CONFIG_SCSI_BUSLOGIC=3Dm
> # CONFIG_SCSI_OMIT_FLASHPOINT is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_DMA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> CONFIG_SCSI_PPA=3Dm
> CONFIG_SCSI_IMM=3Dm
> # CONFIG_SCSI_IZIP_EPP16 is not set
> # CONFIG_SCSI_IZIP_SLOW_CTR is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
>=20
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
>=20
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=3Dy
> CONFIG_BLK_DEV_MD=3Dm
> CONFIG_MD_LINEAR=3Dm
> CONFIG_MD_RAID0=3Dm
> CONFIG_MD_RAID1=3Dm
> CONFIG_MD_RAID5=3Dm
> # CONFIG_MD_MULTIPATH is not set
> CONFIG_BLK_DEV_DM=3Dm
>=20
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
>=20
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> # CONFIG_IEEE1394 is not set
>=20
> #
> # I2O device support
> #
> CONFIG_I2O=3Dm
> # CONFIG_I2O_PCI is not set
> # CONFIG_I2O_BLOCK is not set
> # CONFIG_I2O_SCSI is not set
> # CONFIG_I2O_PROC is not set
>=20
> #
> # Networking support
> #
> CONFIG_NET=3Dy
>=20
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_MMAP=3Dy
> CONFIG_NETLINK_DEV=3Dm
> CONFIG_NETFILTER=3Dy
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_FILTER=3Dy
> CONFIG_UNIX=3Dy
> CONFIG_NET_KEY=3Dm
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=3Dm
> CONFIG_NET_IPGRE=3Dm
> # CONFIG_NET_IPGRE_BROADCAST is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> # CONFIG_INET_ECN is not set
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_INET_AH=3Dm
> CONFIG_INET_ESP=3Dm
> # CONFIG_XFRM_USER is not set
>=20
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=3Dy
> CONFIG_IP_NF_FTP=3Dm
> # CONFIG_IP_NF_IRC is not set
> CONFIG_IP_NF_QUEUE=3Dm
> CONFIG_IP_NF_IPTABLES=3Dy
> CONFIG_IP_NF_MATCH_LIMIT=3Dm
> CONFIG_IP_NF_MATCH_MAC=3Dm
> # CONFIG_IP_NF_MATCH_PKTTYPE is not set
> CONFIG_IP_NF_MATCH_MARK=3Dm
> CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
> CONFIG_IP_NF_MATCH_TOS=3Dm
> # CONFIG_IP_NF_MATCH_ECN is not set
> # CONFIG_IP_NF_MATCH_DSCP is not set
> # CONFIG_IP_NF_MATCH_AH_ESP is not set
> # CONFIG_IP_NF_MATCH_LENGTH is not set
> # CONFIG_IP_NF_MATCH_TTL is not set
> # CONFIG_IP_NF_MATCH_TCPMSS is not set
> # CONFIG_IP_NF_MATCH_HELPER is not set
> CONFIG_IP_NF_MATCH_STATE=3Dm
> # CONFIG_IP_NF_MATCH_CONNTRACK is not set
> CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
> CONFIG_IP_NF_MATCH_OWNER=3Dm
> # CONFIG_IP_NF_MATCH_PHYSDEV is not set
> CONFIG_IP_NF_FILTER=3Dy
> CONFIG_IP_NF_TARGET_REJECT=3Dm
> CONFIG_IP_NF_TARGET_MIRROR=3Dm
> CONFIG_IP_NF_NAT=3Dy
> CONFIG_IP_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
> CONFIG_IP_NF_TARGET_REDIRECT=3Dy
> # CONFIG_IP_NF_NAT_LOCAL is not set
> # CONFIG_IP_NF_NAT_SNMP_BASIC is not set
> CONFIG_IP_NF_NAT_FTP=3Dm
> CONFIG_IP_NF_MANGLE=3Dm
> CONFIG_IP_NF_TARGET_TOS=3Dm
> # CONFIG_IP_NF_TARGET_ECN is not set
> # CONFIG_IP_NF_TARGET_DSCP is not set
> CONFIG_IP_NF_TARGET_MARK=3Dm
> CONFIG_IP_NF_TARGET_LOG=3Dm
> # CONFIG_IP_NF_TARGET_ULOG is not set
> # CONFIG_IP_NF_TARGET_TCPMSS is not set
> # CONFIG_IP_NF_ARPTABLES is not set
> CONFIG_IPV6=3Dm
>=20
> #
> # IPv6: Netfilter Configuration
> #
> # CONFIG_IP6_NF_QUEUE is not set
> CONFIG_IP6_NF_IPTABLES=3Dm
> CONFIG_IP6_NF_MATCH_LIMIT=3Dm
> # CONFIG_IP6_NF_MATCH_MAC is not set
> # CONFIG_IP6_NF_MATCH_MULTIPORT is not set
> # CONFIG_IP6_NF_MATCH_OWNER is not set
> CONFIG_IP6_NF_MATCH_MARK=3Dm
> # CONFIG_IP6_NF_MATCH_LENGTH is not set
> # CONFIG_IP6_NF_MATCH_EUI64 is not set
> CONFIG_IP6_NF_FILTER=3Dm
> # CONFIG_IP6_NF_TARGET_LOG is not set
> CONFIG_IP6_NF_MANGLE=3Dm
> CONFIG_IP6_NF_TARGET_MARK=3Dm
>=20
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=3Dm
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_LLC is not set
> CONFIG_DECNET=3Dm
> # CONFIG_DECNET_SIOCGIFCONF is not set
> # CONFIG_DECNET_ROUTER is not set
> CONFIG_BRIDGE=3Dm
> # CONFIG_BRIDGE_NF_EBTABLES is not set
> CONFIG_X25=3Dm
> CONFIG_LAPB=3Dm
> # CONFIG_NET_DIVERT is not set
> CONFIG_ECONET=3Dm
> # CONFIG_ECONET_AUNUDP is not set
> # CONFIG_ECONET_NATIVE is not set
> CONFIG_WAN_ROUTER=3Dm
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
>=20
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
>=20
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=3Dm
> CONFIG_NETDEVICES=3Dy
>=20
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=3Dm
> CONFIG_BONDING=3Dm
> CONFIG_EQUALIZER=3Dm
> CONFIG_TUN=3Dm
> # CONFIG_ETHERTAP is not set
>=20
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=3Dy
> CONFIG_MII=3Dy
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
>=20
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_PCI=3Dy
> CONFIG_PCNET32=3Dm
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_B44 is not set
> # CONFIG_CS89x0 is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_E100 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> CONFIG_8139TOO=3Dm
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_NET_POCKET is not set
>=20
> #
> # Ethernet (1000 Mbit)
> #
> CONFIG_ACENIC=3Dm
> # CONFIG_ACENIC_OMIT_TIGON_I is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> CONFIG_HAMACHI=3Dm
> CONFIG_YELLOWFIN=3Dm
> # CONFIG_R8169 is not set
> CONFIG_SK98LIN=3Dm
> # CONFIG_TIGON3 is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> CONFIG_PPP=3Dm
> CONFIG_PPP_MULTILINK=3Dy
> # CONFIG_PPP_FILTER is not set
> CONFIG_PPP_ASYNC=3Dm
> CONFIG_PPP_SYNC_TTY=3Dm
> CONFIG_PPP_DEFLATE=3Dm
> CONFIG_PPP_BSDCOMP=3Dm
> CONFIG_PPPOE=3Dm
> # CONFIG_SLIP is not set
>=20
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>=20
> #
> # Token Ring devices (depends on LLC=3Dy)
> #
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> CONFIG_SHAPER=3Dm
>=20
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
>=20
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
>=20
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
>=20
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN_BOOL is not set
>=20
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
>=20
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dm
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1600
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D1200
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=3Dm
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=3Dy
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> CONFIG_MOUSE_SERIAL=3Dm
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=3Dy
> CONFIG_INPUT_PCSPKR=3Dm
> CONFIG_INPUT_UINPUT=3Dm
>=20
> #
> # Character devices
> #
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> # CONFIG_SERIAL_NONSTANDARD is not set
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
> # CONFIG_SERIAL_8250_MULTIPORT is not set
> # CONFIG_SERIAL_8250_RSA is not set
>=20
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_UNIX98_PTY_COUNT=3D512
> CONFIG_PRINTER=3Dm
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=3Dm
> # CONFIG_TIPAR is not set
>=20
> #
> # I2C support
> #
> CONFIG_I2C=3Dm
> # CONFIG_I2C_ALGOBIT is not set
> # CONFIG_I2C_ALGOPCF is not set
> CONFIG_I2C_CHARDEV=3Dm
> CONFIG_I2C_PROC=3Dm
>=20
> #
> # I2C Hardware Sensors Mainboard support
> #
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
>=20
> #
> # I2C Hardware Sensors Chip support
> #
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_LM75 is not set
>=20
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> # CONFIG_QIC02_TAPE is not set
>=20
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
>=20
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_INTEL_RNG is not set
> CONFIG_AMD_RNG=3Dm
> CONFIG_NVRAM=3Dm
> CONFIG_RTC=3Dy
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
>=20
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=3Dy
> # CONFIG_AGP3 is not set
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_VIA is not set
> CONFIG_AGP_AMD=3Dy
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_AMD_8151 is not set
> CONFIG_DRM=3Dy
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> CONFIG_DRM_RADEON=3Dm
> # CONFIG_DRM_I810 is not set
> # CONFIG_DRM_I830 is not set
> # CONFIG_DRM_MGA is not set
> # CONFIG_MWAVE is not set
> CONFIG_RAW_DRIVER=3Dm
> # CONFIG_HANGCHECK_TIMER is not set
>=20
> #
> # Multimedia devices
> #
> CONFIG_VIDEO_DEV=3Dm
>=20
> #
> # Video For Linux
> #
> CONFIG_VIDEO_PROC_FS=3Dy
>=20
> #
> # Video Adapters
> #
> # CONFIG_VIDEO_PMS is not set
> # CONFIG_VIDEO_BWQCAM is not set
> # CONFIG_VIDEO_CQCAM is not set
> # CONFIG_VIDEO_W9966 is not set
> CONFIG_VIDEO_CPIA=3Dm
> CONFIG_VIDEO_CPIA_PP=3Dm
> CONFIG_VIDEO_CPIA_USB=3Dm
> # CONFIG_VIDEO_SAA5249 is not set
> # CONFIG_TUNER_3036 is not set
> # CONFIG_VIDEO_STRADIS is not set
> # CONFIG_VIDEO_ZORAN is not set
> # CONFIG_VIDEO_ZR36120 is not set
> # CONFIG_VIDEO_SAA7134 is not set
>=20
> #
> # Radio Adapters
> #
> # CONFIG_RADIO_CADET is not set
> # CONFIG_RADIO_RTRACK is not set
> # CONFIG_RADIO_RTRACK2 is not set
> # CONFIG_RADIO_AZTECH is not set
> # CONFIG_RADIO_GEMTEK is not set
> # CONFIG_RADIO_GEMTEK_PCI is not set
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_MAESTRO is not set
> # CONFIG_RADIO_SF16FMI is not set
> # CONFIG_RADIO_TERRATEC is not set
> # CONFIG_RADIO_TRUST is not set
> # CONFIG_RADIO_TYPHOON is not set
> # CONFIG_RADIO_ZOLTRIX is not set
>=20
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
>=20
> #
> # File systems
> #
> CONFIG_QUOTA=3Dy
> # CONFIG_QFMT_V1 is not set
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=3Dy
> CONFIG_AUTOFS_FS=3Dm
> CONFIG_AUTOFS4_FS=3Dy
> CONFIG_REISERFS_FS=3Dm
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> # CONFIG_ADFS_FS is not set
> CONFIG_AFFS_FS=3Dm
> CONFIG_HFS_FS=3Dm
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> CONFIG_EXT3_FS=3Dy
> CONFIG_EXT3_FS_XATTR=3Dy
> CONFIG_EXT3_FS_POSIX_ACL=3Dy
> CONFIG_JBD=3Dy
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FAT_FS=3Dm
> # CONFIG_MSDOS_FS is not set
> CONFIG_VFAT_FS=3Dm
> # CONFIG_EFS_FS is not set
> CONFIG_CRAMFS=3Dm
> CONFIG_TMPFS=3Dy
> CONFIG_RAMFS=3Dy
> # CONFIG_HUGETLBFS is not set
> CONFIG_ISO9660_FS=3Dy
> CONFIG_JOLIET=3Dy
> # CONFIG_ZISOFS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_MINIX_FS=3Dm
> # CONFIG_VXFS_FS is not set
> CONFIG_NTFS_FS=3Dm
> # CONFIG_NTFS_DEBUG is not set
> CONFIG_NTFS_RW=3Dy
> CONFIG_HPFS_FS=3Dm
> CONFIG_PROC_FS=3Dy
> CONFIG_DEVFS_FS=3Dy
> CONFIG_DEVFS_MOUNT=3Dy
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS=3Dy
> # CONFIG_QNX4FS_FS is not set
> CONFIG_ROMFS_FS=3Dm
> CONFIG_EXT2_FS=3Dy
> CONFIG_EXT2_FS_XATTR=3Dy
> CONFIG_EXT2_FS_POSIX_ACL=3Dy
> CONFIG_SYSV_FS=3Dm
> CONFIG_UDF_FS=3Dm
> CONFIG_UFS_FS=3Dm
> CONFIG_UFS_FS_WRITE=3Dy
> CONFIG_XFS_FS=3Dm
> # CONFIG_XFS_RT is not set
> CONFIG_XFS_QUOTA=3Dy
> CONFIG_XFS_POSIX_ACL=3Dy
>=20
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> # CONFIG_INTERMEZZO_FS is not set
> CONFIG_NFS_FS=3Dm
> CONFIG_NFS_V3=3Dy
> # CONFIG_NFS_V4 is not set
> CONFIG_NFSD=3Dm
> CONFIG_NFSD_V3=3Dy
> # CONFIG_NFSD_V4 is not set
> # CONFIG_NFSD_TCP is not set
> CONFIG_SUNRPC=3Dm
> # CONFIG_SUNRPC_GSS is not set
> CONFIG_LOCKD=3Dm
> CONFIG_LOCKD_V4=3Dy
> CONFIG_EXPORTFS=3Dm
> CONFIG_CIFS=3Dm
> CONFIG_SMB_FS=3Dm
> # CONFIG_SMB_NLS_DEFAULT is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_AFS_FS is not set
> CONFIG_FS_MBCACHE=3Dy
> CONFIG_FS_POSIX_ACL=3Dy
>=20
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=3Dy
> # CONFIG_ACORN_PARTITION is not set
> CONFIG_OSF_PARTITION=3Dy
> CONFIG_AMIGA_PARTITION=3Dy
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=3Dy
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_BSD_DISKLABEL=3Dy
> # CONFIG_MINIX_SUBPARTITION is not set
> CONFIG_SOLARIS_X86_PARTITION=3Dy
> # CONFIG_UNIXWARE_DISKLABEL is not set
> # CONFIG_LDM_PARTITION is not set
> CONFIG_SGI_PARTITION=3Dy
> # CONFIG_ULTRIX_PARTITION is not set
> CONFIG_SUN_PARTITION=3Dy
> # CONFIG_EFI_PARTITION is not set
> CONFIG_SMB_NLS=3Dy
> CONFIG_NLS=3Dy
>=20
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT=3D"cp437"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
>=20
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> CONFIG_VIDEO_SELECT=3Dy
>=20
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=3Dy
>=20
> #
> # Sound
> #
> CONFIG_SOUND=3Dm
>=20
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=3Dm
> CONFIG_SND_SEQUENCER=3Dm
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_OSSEMUL=3Dy
> CONFIG_SND_MIXER_OSS=3Dm
> CONFIG_SND_PCM_OSS=3Dm
> CONFIG_SND_SEQUENCER_OSS=3Dy
> CONFIG_SND_RTCTIMER=3Dm
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
>=20
> #
> # Generic devices
> #
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
>=20
> #
> # ISA devices
> #
> # CONFIG_SND_AD1848 is not set
> # CONFIG_SND_CS4231 is not set
> # CONFIG_SND_CS4232 is not set
> # CONFIG_SND_CS4236 is not set
> # CONFIG_SND_ES1688 is not set
> # CONFIG_SND_ES18XX is not set
> # CONFIG_SND_GUSCLASSIC is not set
> # CONFIG_SND_GUSEXTREME is not set
> # CONFIG_SND_GUSMAX is not set
> # CONFIG_SND_INTERWAVE is not set
> # CONFIG_SND_INTERWAVE_STB is not set
> # CONFIG_SND_OPTI92X_AD1848 is not set
> # CONFIG_SND_OPTI92X_CS4231 is not set
> # CONFIG_SND_OPTI93X is not set
> # CONFIG_SND_SB8 is not set
> # CONFIG_SND_SB16 is not set
> # CONFIG_SND_SBAWE is not set
> # CONFIG_SND_WAVEFRONT is not set
> # CONFIG_SND_CMI8330 is not set
> # CONFIG_SND_OPL3SA2 is not set
> # CONFIG_SND_SGALAXY is not set
>=20
> #
> # PCI devices
> #
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_ALS4000 is not set
> CONFIG_SND_CMIPCI=3Dm
> CONFIG_SND_ENS1370=3Dm
> CONFIG_SND_ENS1371=3Dm
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
>=20
> #
> # ALSA USB devices
> #
> # CONFIG_SND_USB_AUDIO is not set
>=20
> #
> # Open Sound System
> #
> # CONFIG_SOUND_PRIME is not set
>=20
> #
> # USB support
> #
> CONFIG_USB=3Dm
> # CONFIG_USB_DEBUG is not set
>=20
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=3Dy
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
>=20
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=3Dm
> CONFIG_USB_OHCI_HCD=3Dm
> # CONFIG_USB_UHCI_HCD is not set
>=20
> #
> # USB Device Class drivers
> #
> CONFIG_USB_AUDIO=3Dm
> # CONFIG_USB_BLUETOOTH_TTY is not set
> # CONFIG_USB_MIDI is not set
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> CONFIG_USB_STORAGE=3Dm
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_DPCM is not set
> # CONFIG_USB_STORAGE_HP8200e is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
>=20
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=3Dm
> # CONFIG_USB_HIDINPUT is not set
> # CONFIG_USB_HIDDEV is not set
>=20
> #
> # USB HID Boot Protocol drivers
> #
> CONFIG_USB_KBD=3Dm
> CONFIG_USB_MOUSE=3Dm
> # CONFIG_USB_AIPTEK is not set
> CONFIG_USB_WACOM=3Dm
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_XPAD is not set
>=20
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_SCANNER is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_HPUSBSCSI is not set
>=20
> #
> # USB Multimedia devices
> #
> # CONFIG_USB_DABUSB is not set
> # CONFIG_USB_VICAM is not set
> # CONFIG_USB_DSBR is not set
> # CONFIG_USB_IBMCAM is not set
> # CONFIG_USB_KONICAWC is not set
> # CONFIG_USB_OV511 is not set
> # CONFIG_USB_PWC is not set
> # CONFIG_USB_SE401 is not set
> # CONFIG_USB_STV680 is not set
>=20
> #
> # USB Network adaptors
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_CDCETHER is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
>=20
> #
> # USB port drivers
> #
> CONFIG_USB_USS720=3Dm
>=20
> #
> # USB Serial Converter support
> #
> CONFIG_USB_SERIAL=3Dm
> CONFIG_USB_SERIAL_GENERIC=3Dy
> CONFIG_USB_SERIAL_BELKIN=3Dm
> CONFIG_USB_SERIAL_WHITEHEAT=3Dm
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
> CONFIG_USB_SERIAL_EMPEG=3Dm
> CONFIG_USB_SERIAL_FTDI_SIO=3Dm
> CONFIG_USB_SERIAL_VISOR=3Dm
> CONFIG_USB_SERIAL_IPAQ=3Dm
> CONFIG_USB_SERIAL_IR=3Dm
> CONFIG_USB_SERIAL_EDGEPORT=3Dm
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
> # CONFIG_USB_SERIAL_KEYSPAN is not set
> CONFIG_USB_SERIAL_KLSI=3Dm
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> CONFIG_USB_SERIAL_MCT_U232=3Dm
> CONFIG_USB_SERIAL_PL2303=3Dm
> # CONFIG_USB_SERIAL_SAFE is not set
> CONFIG_USB_SERIAL_CYBERJACK=3Dm
> CONFIG_USB_SERIAL_XIRCOM=3Dm
> CONFIG_USB_SERIAL_OMNINET=3Dm
> CONFIG_USB_EZUSB=3Dy
>=20
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_TIGL is not set
> # CONFIG_USB_AUERSWALD is not set
> CONFIG_USB_RIO500=3Dm
> # CONFIG_USB_BRLVGER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_TEST is not set
>=20
> #
> # Bluetooth support
> #
> # CONFIG_BT is not set
>=20
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
>=20
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=3Dy
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=3Dy
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_KALLSYMS is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_FRAME_POINTER is not set
> CONFIG_X86_EXTRA_IRQS=3Dy
> CONFIG_X86_FIND_SMP_CONFIG=3Dy
> CONFIG_X86_MPPARSE=3Dy
>=20
> #
> # Security options
> #
> CONFIG_SECURITY=3Dy
> CONFIG_SECURITY_NETWORK=3Dy
> CONFIG_SECURITY_CAPABILITIES=3Dy
> # CONFIG_SECURITY_ROOTPLUG is not set
>=20
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=3Dy
> CONFIG_CRYPTO_HMAC=3Dy
> CONFIG_CRYPTO_NULL=3Dm
> CONFIG_CRYPTO_MD4=3Dm
> CONFIG_CRYPTO_MD5=3Dm
> CONFIG_CRYPTO_SHA1=3Dm
> CONFIG_CRYPTO_SHA256=3Dy
> # CONFIG_CRYPTO_SHA512 is not set
> CONFIG_CRYPTO_DES=3Dm
> CONFIG_CRYPTO_BLOWFISH=3Dy
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_SERPENT is not set
> # CONFIG_CRYPTO_AES is not set
> CONFIG_CRYPTO_TEST=3Dm
>=20
> #
> # Library routines
> #
> CONFIG_CRC32=3Dm
> CONFIG_ZLIB_INFLATE=3Dm
> CONFIG_ZLIB_DEFLATE=3Dm
> CONFIG_X86_SMP=3Dy
> CONFIG_X86_HT=3Dy
> CONFIG_X86_BIOS_REBOOT=3Dy
> CONFIG_X86_TRAMPOLINE=3Dy


--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

S:  Another stupid question?
G:  There's no such thing as a stupid question, only stupid people.
					-- Stef and Greg
User Friendly, 7/15/1998

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+UFX5IjReC7bSPZARAveGAKDDPh7HrWreQ2OyyAZKkb4KZ03K+QCgkp3k
Fk+6nnUClMz1IGFDYU1g2wc=
=UqF4
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
