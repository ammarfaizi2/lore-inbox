Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275507AbTHMV04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275509AbTHMV04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:26:56 -0400
Received: from [207.188.30.29] ([207.188.30.29]:28858 "EHLO mpenc1.prognet.com")
	by vger.kernel.org with ESMTP id S275507AbTHMV0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:26:10 -0400
Date: Wed, 13 Aug 2003 14:26:10 -0700
From: Tom Marshall <tommy@home.tig-grr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA (Texas Instruments PCI1410)
Message-ID: <20030813212610.GA12315@home.tig-grr.com>
References: <20030813205037.GA11977@home.tig-grr.com> <20030813221254.H20676@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20030813221254.H20676@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Could you show the kernel messages from boot as well as the above
> messages please?

Here it is.  Below that is a more complete lspci output.

=3D=3D=3D syslog messages =3D=3D=3D

Aug 13 14:18:51 venture syslogd 1.4.1#10: restart.
Aug 13 14:18:51 venture kernel: klogd 1.4.1#10, log source =3D /proc/kmsg s=
tarted.
Aug 13 14:18:51 venture kernel: Inspecting /boot/System.map-2.6.0-test3
Aug 13 14:18:51 venture modprobe: FATAL: Module apm not found.=20
Aug 13 14:18:51 venture kernel: Loaded 19452 symbols from /boot/System.map-=
2.6.0-test3.
Aug 13 14:18:51 venture kernel: Symbols match kernel version 2.6.0.
Aug 13 14:18:51 venture kernel: No module symbols loaded - kernel modules n=
ot enabled.=20
Aug 13 14:18:51 venture kernel: Linux version 2.6.0-test3 (root@venture) (g=
cc version 2.95.4 20011002 (Debian prerelease)) #8 Mon Aug 11 22:55:07 PDT =
2003
Aug 13 14:18:51 venture kernel: Video mode to be used for restore is ffff
Aug 13 14:18:51 venture kernel: BIOS-provided physical RAM map:
Aug 13 14:18:51 venture kernel:  BIOS-e820: 0000000000000000 - 000000000009=
fc00 (usable)
Aug 13 14:18:51 venture kernel:  BIOS-e820: 000000000009fc00 - 00000000000a=
0000 (reserved)
Aug 13 14:18:51 venture kernel:  BIOS-e820: 0000000000100000 - 000000000fed=
c000 (usable)
Aug 13 14:18:51 venture kernel:  BIOS-e820: 000000000fedc000 - 000000001000=
0000 (reserved)
Aug 13 14:18:51 venture kernel:  BIOS-e820: 00000000feda0000 - 00000000fee0=
0000 (reserved)
Aug 13 14:18:51 venture kernel:  BIOS-e820: 00000000ffb80000 - 000000010000=
0000 (reserved)
Aug 13 14:18:51 venture kernel: 254MB LOWMEM available.
Aug 13 14:18:51 venture kernel: On node 0 totalpages: 65244
Aug 13 14:18:51 venture kernel:   DMA zone: 4096 pages, LIFO batch:1
Aug 13 14:18:51 venture kernel:   Normal zone: 61148 pages, LIFO batch:14
Aug 13 14:18:51 venture kernel:   HighMem zone: 0 pages, LIFO batch:1
Aug 13 14:18:51 venture kernel: Dell Latitude with broken BIOS detected. Re=
fusing to enable the local APIC.
Aug 13 14:18:51 venture kernel: ACPI: RSDP (v000 DELL                      =
 ) @ 0x000fde50
Aug 13 14:18:51 venture kernel: ACPI: RSDT (v001 DELL    CPi R   10195.0077=
2) @ 0x000fde64
Aug 13 14:18:51 venture kernel: ACPI: FADT (v001 DELL    CPi R   10195.0077=
2) @ 0x000fde90
Aug 13 14:18:51 venture kernel: ACPI: DSDT (v001 INT430 SYSFexxx 00000.0409=
7) @ 0x00000000
Aug 13 14:18:51 venture kernel: ACPI: BIOS passes blacklist
Aug 13 14:18:51 venture kernel: ACPI: MADT not present
Aug 13 14:18:51 venture kernel: Building zonelist for node : 0
Aug 13 14:18:51 venture kernel: Kernel command line: BOOT_IMAGE=3DLinux-2.6=
 ro root=3D303
Aug 13 14:18:51 venture kernel: Initializing CPU#0
Aug 13 14:18:51 venture kernel: PID hash table entries: 1024 (order 10: 819=
2 bytes)
Aug 13 14:18:51 venture kernel: Detected 797.421 MHz processor.
Aug 13 14:18:51 venture kernel: Console: colour VGA+ 80x25
Aug 13 14:18:51 venture kernel: Calibrating delay loop... 1576.96 BogoMIPS
Aug 13 14:18:51 venture kernel: Memory: 255532k/260976k available (1229k ke=
rnel code, 4696k reserved, 626k data, 96k init, 0k highmem)
Aug 13 14:18:51 venture kernel: Dentry cache hash table entries: 32768 (ord=
er: 5, 131072 bytes)
Aug 13 14:18:51 venture kernel: Inode-cache hash table entries: 16384 (orde=
r: 4, 65536 bytes)
Aug 13 14:18:51 venture kernel: Mount-cache hash table entries: 512 (order:=
 0, 4096 bytes)
Aug 13 14:18:51 venture kernel: -> /dev
Aug 13 14:18:51 venture kernel: -> /dev/console
Aug 13 14:18:51 venture kernel: -> /root
Aug 13 14:18:51 venture kernel: CPU:     After generic identify, caps: 0383=
f9ff 00000000 00000000 00000000
Aug 13 14:18:51 venture kernel: CPU:     After vendor identify, caps: 0383f=
9ff 00000000 00000000 00000000
Aug 13 14:18:51 venture kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 13 14:18:51 venture kernel: CPU: L2 cache: 512K
Aug 13 14:18:51 venture kernel: CPU:     After all inits, caps: 0383f9ff 00=
000000 00000000 00000040
Aug 13 14:18:51 venture kernel: Intel machine check architecture supported.
Aug 13 14:18:51 venture kernel: Intel machine check reporting enabled on CP=
U#0.
Aug 13 14:18:51 venture kernel: CPU: Intel Mobile Intel(R) Pentium(R) III C=
PU - M  1200MHz stepping 04
Aug 13 14:18:51 venture kernel: Enabling fast FPU save and restore... done.
Aug 13 14:18:51 venture kernel: Enabling unmasked SIMD FPU exception suppor=
t... done.
Aug 13 14:18:51 venture kernel: Checking 'hlt' instruction... OK.
Aug 13 14:18:51 venture kernel: POSIX conformance testing by UNIFIX
Aug 13 14:18:51 venture kernel: Initializing RT netlink socket
Aug 13 14:18:51 venture kernel: PCI: PCI BIOS revision 2.10 entry at 0xfc00=
e, last bus=3D2
Aug 13 14:18:51 venture kernel: PCI: Using configuration type 1
Aug 13 14:18:51 venture kernel: mtrr: v2.0 (20020519)
Aug 13 14:18:51 venture kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Aug 13 14:18:51 venture kernel: biovec pool[0]:   1 bvecs: 256 entries (12 =
bytes)
Aug 13 14:18:51 venture kernel: biovec pool[1]:   4 bvecs: 256 entries (48 =
bytes)
Aug 13 14:18:51 venture kernel: biovec pool[2]:  16 bvecs: 256 entries (192=
 bytes)
Aug 13 14:18:51 venture kernel: biovec pool[3]:  64 bvecs: 256 entries (768=
 bytes)
Aug 13 14:18:51 venture kernel: biovec pool[4]: 128 bvecs: 256 entries (153=
6 bytes)
Aug 13 14:18:51 venture kernel: biovec pool[5]: 256 bvecs: 256 entries (307=
2 bytes)
Aug 13 14:18:51 venture kernel: ACPI: Subsystem revision 20030714
Aug 13 14:18:51 venture kernel: ACPI: Interpreter enabled
Aug 13 14:18:51 venture kernel: ACPI: Using PIC for interrupt routing
Aug 13 14:18:51 venture kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 13 14:18:51 venture kernel: PCI: Probing PCI hardware (bus 00)
Aug 13 14:18:51 venture kernel: Transparent bridge - 0000:00:1e.0
Aug 13 14:18:51 venture kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PC=
I0._PRT]
Aug 13 14:18:51 venture kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 =
*11)
Aug 13 14:18:51 venture kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7, =
enabled at IRQ 11)
Aug 13 14:18:51 venture kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 =
*11)
Aug 13 14:18:51 venture kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9=
 10 *11)
Aug 13 14:18:51 venture kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PC=
I0.PCIE._PRT]
Aug 13 14:18:51 venture kernel: ACPI: Power Resource [PADA] (on)
Aug 13 14:18:51 venture kernel: PCI: Using ACPI for IRQ routing
Aug 13 14:18:51 venture kernel: PCI: if you experience problems, try using =
option 'pci=3Dnoacpi' or even 'acpi=3Doff'
Aug 13 14:18:51 venture kernel: pty: 256 Unix98 ptys configured
Aug 13 14:18:51 venture kernel: Journalled Block Device driver loaded
Aug 13 14:18:51 venture kernel: Initializing Cryptographic API
Aug 13 14:18:51 venture kernel: Uniform Multi-Platform E-IDE driver Revisio=
n: 7.00alpha2
Aug 13 14:18:51 venture kernel: ide: Assuming 33MHz system bus speed for PI=
O modes; override with idebus=3Dxx
Aug 13 14:18:51 venture kernel: ICH3M: IDE controller at PCI slot 0000:00:1=
f.1
Aug 13 14:18:51 venture kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> =
0007)
Aug 13 14:18:51 venture kernel: ICH3M: chipset revision 2
Aug 13 14:18:51 venture kernel: ICH3M: not 100%% native mode: will probe ir=
qs later
Aug 13 14:18:51 venture kernel:     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS set=
tings: hda:DMA, hdb:pio
Aug 13 14:18:51 venture kernel:     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS set=
tings: hdc:pio, hdd:pio
Aug 13 14:18:51 venture kernel: hda: FUJITSU MHS2020AT E, ATA DISK drive
Aug 13 14:18:51 venture kernel: Using anticipatory scheduling elevator
Aug 13 14:18:51 venture kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 13 14:18:51 venture kernel: hda: max request size: 1024KiB
Aug 13 14:18:51 venture kernel: hda: 39070080 sectors (20003 MB) w/2048KiB =
Cache, CHS=3D2432/255/63, UDMA(100)
Aug 13 14:18:51 venture kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Aug 13 14:18:51 venture kernel: mice: PS/2 mouse device common for all mice
Aug 13 14:18:51 venture kernel: input: PC Speaker
Aug 13 14:18:51 venture kernel: synaptics reset failed
Aug 13 14:18:51 venture last message repeated 2 times
Aug 13 14:18:51 venture kernel: Synaptics Touchpad, model: 1
Aug 13 14:18:51 venture kernel:  Firware: 5.7
Aug 13 14:18:51 venture kernel:  180 degree mounted touchpad
Aug 13 14:18:51 venture kernel:  Sensor: 27
Aug 13 14:18:51 venture kernel:  new absolute packet format
Aug 13 14:18:51 venture kernel:  Touchpad has extended capability bits
Aug 13 14:18:51 venture kernel:  -> multifinger detection
Aug 13 14:18:51 venture kernel:  -> palm detection
Aug 13 14:18:51 venture kernel: input: Synaptics Synaptics TouchPad on isa0=
060/serio1
Aug 13 14:18:51 venture kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 13 14:18:51 venture kernel: input: AT Set 2 keyboard on isa0060/serio0
Aug 13 14:18:51 venture kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 13 14:18:51 venture kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 13 14:18:51 venture kernel: IP: routing cache hash table of 2048 bucket=
s, 16Kbytes
Aug 13 14:18:51 venture kernel: TCP: Hash tables configured (established 16=
384 bind 16384)
Aug 13 14:18:51 venture kernel: kjournald starting.  Commit interval 5 seco=
nds
Aug 13 14:18:51 venture kernel: EXT3-fs: mounted filesystem with ordered da=
ta mode.
Aug 13 14:18:51 venture kernel: VFS: Mounted root (ext3 filesystem) readonl=
y.
Aug 13 14:18:51 venture kernel: Freeing unused kernel memory: 96k freed
Aug 13 14:18:51 venture kernel: NET4: Unix domain sockets 1.0/SMP for Linux=
 NET4.0.
Aug 13 14:18:51 venture kernel: version 0 swap is no longer supported. Use =
mkswap -v1 /dev/hda5
Aug 13 14:18:51 venture kernel: EXT3 FS on hda3, internal journal
Aug 13 14:18:51 venture kernel: drivers/usb/core/usb.c: registered new driv=
er usbfs
Aug 13 14:18:51 venture kernel: drivers/usb/core/usb.c: registered new driv=
er hub
Aug 13 14:18:51 venture kernel: drivers/usb/core/usb.c: registered new driv=
er hiddev
Aug 13 14:18:51 venture kernel: drivers/usb/core/usb.c: registered new driv=
er hid
Aug 13 14:18:51 venture kernel: drivers/usb/input/hid-core.c: v2.0:USB HID =
core driver
Aug 13 14:18:51 venture kernel: IPv6 v0.8 for NET4.0
Aug 13 14:18:51 venture kernel: IPv6 over IPv4 tunneling driver
Aug 13 14:18:51 venture kernel: 3c59x: Donald Becker and others. www.scyld.=
com/network/vortex.html
Aug 13 14:18:51 venture kernel: 0000:02:00.0: 3Com PCI 3c905C Tornado at 0x=
ec80. Vers LK1.1.19
Aug 13 14:18:51 venture kernel: kjournald starting.  Commit interval 5 seco=
nds
Aug 13 14:18:51 venture kernel: EXT3 FS on hda6, internal journal
Aug 13 14:18:51 venture kernel: EXT3-fs: mounted filesystem with ordered da=
ta mode.
Aug 13 14:18:51 venture kernel: kjournald starting.  Commit interval 5 seco=
nds
Aug 13 14:18:51 venture kernel: EXT3 FS on hda7, internal journal
Aug 13 14:18:51 venture kernel: EXT3-fs: mounted filesystem with ordered da=
ta mode.
Aug 13 14:18:51 venture kernel: version 0 swap is no longer supported. Use =
mkswap -v1 /dev/hda5
Aug 13 14:18:51 venture kernel: drivers/usb/host/uhci-hcd.c: USB Universal =
Host Controller Interface driver v2.1
Aug 13 14:18:51 venture kernel: uhci-hcd 0000:00:1d.0: UHCI Host Controller
Aug 13 14:18:51 venture kernel: PCI: Setting latency timer of device 0000:0=
0:1d.0 to 64
Aug 13 14:18:51 venture kernel: uhci-hcd 0000:00:1d.0: irq 11, io base 0000=
bf80
Aug 13 14:18:51 venture kernel: uhci-hcd 0000:00:1d.0: new USB bus register=
ed, assigned bus number 1
Aug 13 14:18:51 venture kernel: hub 1-0:0: USB hub found
Aug 13 14:18:51 venture kernel: hub 1-0:0: 2 ports detected
Aug 13 14:18:51 venture kernel: Real Time Clock Driver v1.11
Aug 13 14:18:51 venture lpd[279]: restarted
Aug 13 14:18:52 venture kernel: Linux Kernel Card Services 3.1.22
Aug 13 14:18:52 venture kernel:   options:  [pci] [cardbus] [pm]
Aug 13 14:18:52 venture kernel: PCI: Enabling device 0000:02:01.0 (0000 -> =
0002)
Aug 13 14:18:52 venture kernel: Yenta: CardBus bridge found at 0000:02:01.0=
 [1028:00c8]
Aug 13 14:18:52 venture kernel: Yenta IRQ list 04b8, PCI irq11
Aug 13 14:18:52 venture kernel: Socket status: 30000010
Aug 13 14:18:52 venture cardmgr[310]: watching 1 sockets
Aug 13 14:18:52 venture kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 13 14:18:52 venture kernel: cs: IO port probe 0x0800-0x08ff: excluding =
0x800-0x817 0x828-0x837 0x840-0x857 0x860-0x877 0x880-0x88f 0x898-0x89f 0x8=
a8-0x8af 0x8b8-0x8cf 0x8e0-0x8ff
Aug 13 14:18:52 venture kernel: cs: IO port probe 0x0100-0x04ff: excluding =
0x170-0x177 0x370-0x37f 0x3c0-0x3df 0x3f8-0x3ff 0x4d0-0x4d7
Aug 13 14:18:52 venture kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 13 14:18:52 venture cardmgr[311]: starting, version is 3.2.4
Aug 13 14:18:52 venture kernel: cs: memory probe 0xa0000000-0xa0ffffff: cle=
an.
Aug 13 14:18:52 venture cardmgr[311]: socket 0: Anonymous Memory
Aug 13 14:18:52 venture modprobe: FATAL: Module apm not found.=20
Aug 13 14:18:52 venture cardmgr[311]: executing: 'modprobe memory_cs'
Aug 13 14:18:52 venture cardmgr[311]: + FATAL: Module memory_cs not found.
Aug 13 14:18:52 venture cardmgr[311]: modprobe exited with status 1
Aug 13 14:18:52 venture cardmgr[311]: module /lib/modules/2.6.0-test3/pcmci=
a/memory_cs.o not available
Aug 13 14:18:52 venture cardmgr[311]: bind 'memory_cs' to socket 0 failed: =
Invalid argument
Aug 13 14:18:52 venture modprobe: FATAL: Module apm not found.=20
Aug 13 14:18:52 venture cardmgr[311]: socket 0: Anonymous Memory
Aug 13 14:18:53 venture rpc.statd[330]: Version 1.0.3 Starting
Aug 13 14:18:53 venture ntpd[335]: ntpd 4.1.0 Mon Mar 25 23:39:47 UTC 2002 =
(2)
Aug 13 14:18:53 venture ntpd[335]: signal_no_reset: signal 13 had flags 400=
0000
Aug 13 14:18:53 venture ntpd[335]: precision =3D 8 usec
Aug 13 14:18:53 venture ntpd[335]: kernel time discipline status 0040
Aug 13 14:18:53 venture ntpd[335]: getconfig: Couldn't open </etc/ntp.conf>
Aug 13 14:18:53 venture /usr/sbin/cron[340]: (CRON) INFO (pidfile fd =3D 3)
Aug 13 14:18:53 venture /usr/sbin/cron[341]: (CRON) STARTUP (fork ok)
Aug 13 14:18:53 venture /usr/sbin/cron[341]: (CRON) INFO (Running @reboot j=
obs)
Aug 13 14:18:55 venture usb.agent[114]: ... no modules for USB product 0/0/=
206
Aug 13 14:18:56 venture kernel: Linux agpgart interface v0.100 (c) Dave Jon=
es
Aug 13 14:18:58 venture modprobe: FATAL: Module agpgart already in kernel.=
=20

=3D=3D=3D lspci output =3D=3D=3D

00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 04)
00:02.0 VGA compatible controller: Intel Corp. 82830 CGC [Chipset Graphics =
Controller] (rev 04)
00:02.1 Display controller: Intel Corp. 82830 CGC [Chipset Graphics Control=
ler]
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (r=
ev 02)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02)
02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev=
 78)
02:01.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controlle=
r (rev 02)

=3D=3D=3D lspci -vvv output =3D=3D=3D

00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at <unassigned> (32-bit, prefetchable)
	Capabilities: [40] #09 [0105]

00:02.0 VGA compatible controller: Intel Corp. 82830 CGC [Chipset Graphics =
Controller] (rev 04) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: Memory at f4f80000 (32-bit, non-prefetchable) [size=3D512K]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:02.1 Display controller: Intel Corp. 82830 CGC [Chipset Graphics Control=
ler]
	Subsystem: Dell Computer Corporation: Unknown device 00c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0 (2750ns max)
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: Memory at f4f00000 (32-bit, non-prefetchable) [size=3D512K]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog=
-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at bf80 [size=3D32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 0=
0 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D02, subordinate=3D10, sec-latency=3D32
	I/O behind bridge: 0000e000-0000ffff
	Memory behind bridge: f6000000-fdffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a [=
Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at bfa0 [size=3D16]
	Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=3D1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (r=
ev 02)
	Subsystem: Cirrus Logic: Unknown device 5959
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at d800 [size=3D256]
	Region 1: I/O ports at dc80 [size=3D64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00 [Ge=
neric])
	Subsystem: PCTel Inc Dell Inspiron 2100 internal modem
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at d400 [size=3D256]
	Region 1: I/O ports at dc00 [size=3D128]

02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev=
 78)
	Subsystem: Dell Computer Corporation: Unknown device 00c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ec80 [size=3D128]
	Region 1: Memory at fafffc00 (32-bit, non-prefetchable) [size=3D128]
	Expansion ROM at fb000000 [disabled] [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

02:01.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controlle=
r (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 00c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001


--=20
One good reason why computers can do more work than people is that they
never have to stop and answer the phone.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj86rPIACgkQFMm9uvwPXW5pxQCfaV/HcGNTpUpwtgmbK8AzmAf6
nusAn0DRAtXDESxd3xDa0IAqMmZ/mgbC
=bZxl
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
