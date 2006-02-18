Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWBRB05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWBRB05 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWBRB05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:26:57 -0500
Received: from jabberpl.org ([217.17.46.202]:16294 "EHLO jabberpl.org")
	by vger.kernel.org with ESMTP id S1751837AbWBRB04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:26:56 -0500
From: Rafal Zawadzki <bluszcz@jabberpl.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: no support for agp on via pt880ultra  (2.6.15)
Date: Sat, 18 Feb 2006 02:26:11 +0100
User-Agent: KMail/1.9.1
X-Face: (4ywIpji3LW}Et>S\SjcL'?dEJa__j,KMS)\^jroV=oZ;#eKATD[@=?utf-8?q?Of=7Cco=2EOO3m=27Hhe=3ALl=0A=09RJI=5Ez?=)CQF).HimJB~p6wxF~/OXY3E?HZR[~'Zc0G&x5#era.=8V}^nd*'Mp0f',=?utf-8?q?QxwtY=7EW=0A=09ZL=23m=5BB=5E8e=5Ej=7Cn=5EM8Cy/qPJdF8H=3AWXqyd?=
 =?utf-8?q?/1S?=>gr{.n_7>QXb:i@aO`NPp_Cbk+Sa{l\eE"
 =?utf-8?q?=5D=0A=092*1n=3FK=25xM=2EF-ysnv*R=3Be0?="lZn9g;w?>8Jg]8XEHkO5iMs#[*SUGWb#'4^7lL^c5)
 =?utf-8?q?Xw+FO=5F=0A=09?=@FIuJ\zCW3=$VpM|9k2Nx2Jh
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2593242.YudDVbT69G";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602180226.16554.bluszcz@jabberpl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2593242.YudDVbT69G
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

there is no support for the agp on VIA PT880 Ultra (motherboard asus p5vd1-=
x)

Linux version 2.6.15 (root@akira) (gcc version 4.0.2 20050808 (prerelease)=
=20
(Ubuntu 4.0.1-4ubuntu9)) #2 SMP Fri Feb 17 22:10:12 CET 2006

lspci -vvvv:

0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0308
	Subsystem: Asustek Computer, Inc.: Unknown device 8199
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort+ >SERR- <PERR-
	Latency: 8, Cache Line Size: 0x08 (32 bytes)
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
	Capabilities: [80] AGP version 3.5
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D2 SBA+ ITACoh- GART64- HTrans- 64bit=
=2D FW+=20
AGP3+ Rate=3Dx4,x8
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=3D<no=
ne>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1308
	Subsystem: Asustek Computer, Inc.: Unknown device 8199
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)

0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2308
	Subsystem: Asustek Computer, Inc.: Unknown device 8199
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)

0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3208
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 0

0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4308
	Subsystem: Asustek Computer, Inc.: Unknown device 8199
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)

0000:00:00.5 PIC: VIA Technologies, Inc.: Unknown device 5308 (prog-if 20=20
[IO(X)-APIC])
	Subsystem: Asustek Computer, Inc.: Unknown device 8199
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
=20
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)

0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7308
	Subsystem: Asustek Computer, Inc.: Unknown device 8199
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if =
00=20
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff500000-ff5fffff
	Prefetchable memory behind bridge: bff00000-dfefffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:0d.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet=20
Controller (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ee
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ff6e0000 (32-bit, non-prefetchable) [size=3D128K]
	Region 2: I/O ports at ec00 [size=3D64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=3D0 OST=3D0
		Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, DC=3Dsimple, D=
MMRBC=3D2,=20
DMOST=3D0, DMCRS=3D1, RSCEM-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-
		Address: 0000000000000000  Data: 0000

0000:00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID=20
Controller (rev 80) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Asustek Computer, Inc.: Unknown device 80e9
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin B routed to IRQ 16
	Region 0: I/O ports at e880 [size=3D8]
	Region 1: I/O ports at e800 [size=3D4]
	Region 2: I/O ports at e480 [size=3D8]
	Region 3: I/O ports at e400 [size=3D4]
	Region 4: I/O ports at e080 [size=3D16]
	Region 5: I/O ports at d800 [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:0f.1 IDE interface: VIA Technologies, Inc.=20
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8=
a=20
[Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 80e9
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at fc00 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
=20
Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 17
	Region 4: I/O ports at e000 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
=20
Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 17
	Region 4: I/O ports at dc00 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
=20
Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at d480 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=
=20
Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at d400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-=
if=20
20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin C routed to IRQ 17
	Region 0: Memory at ff6dfc00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800=20
South]
	Subsystem: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+=20
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.=20
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: Asustek Computer, Inc.: Unknown device 810d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at d000 [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon=
=20
9200 PRO] (rev 01) (prog-if 00 [VGA])
	Subsystem: Giga-byte Technology: Unknown device 4054
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: I/O ports at c800 [size=3D256]
	Region 2: Memory at ff5f0000 (32-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at ff5c0000 [disabled] [size=3D128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=3D256 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bi=
t- FW+=20
AGP3+ Rate=3Dx4,x8
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP- GART64- 64bit- FW- Rate=3D<no=
ne>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:01:00.1 Display controller: ATI Technologies Inc: Unknown device 5940=
=20
(rev 01)
	Subsystem: Giga-byte Technology: Unknown device 4055
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Region 0: Memory at c8000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: Memory at ff5e0000 (32-bit, non-prefetchable) [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

cheers,

=2D-=20
 __     __   Rafa=C5=82 Zawadzki [jid/mail: bluszcz@jabberpl.org, skype: bl=
vszcz]
|  |--.|  |.--.--.-----.-----.----.-----. [www: http://bluszcz.jabberpl.org]
|  _  ||  ||  |  |__ --|-- __|  __|-- __| [ http://pyrss.jabberstudio.org/ ]
|_____||__||_____|_____|_____|____|_____|                 =E3=81=A4=E3=81=
=9F=20

--nextPart2593242.YudDVbT69G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD9ne44Kwse0chYmcRArPrAJ9/7UxJ9PHGSSi3sHsAPF3NC+Sg2gCfTRgd
IO7V7B6qqEq5sW3U/4BLvo0=
=0fDF
-----END PGP SIGNATURE-----

--nextPart2593242.YudDVbT69G--
