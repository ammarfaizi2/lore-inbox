Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbTLMNzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 08:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTLMNzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 08:55:00 -0500
Received: from mail.epost.de ([193.28.100.187]:28803 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id S264931AbTLMNyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 08:54:50 -0500
From: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
To: linux-kernel@vger.kernel.org
Subject: Re: r8169 GigE driver problem, locks up 2.4.23 NFS subsystem
Date: Sat, 13 Dec 2003 14:54:45 +0100
User-Agent: KMail/1.5.3
References: <20031213140106.A24017@electric-eye.fr.zoreil.com>
In-Reply-To: <20031213140106.A24017@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Message-Id: <200312131440.28071.Marcus.Blomenkamp@epost.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lox2/Ib3a/kg885"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_lox2/Ib3a/kg885
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Samstag, 13. Dezember 2003 14:01 schrieb Francois Romieu:
> A few questions:
> - the client behaves correctly with a 8139, be it with 2.4.23-pre9 or
>   2.6.0-test11 ?

I just swapped the cards from 8139 to 8169 and recompiled drivers. Never had 
any problem with the old one.

> - could you be more specific wrt "special realtek supplied version" ?

Have a look at 
http://www.realtek.com.tw/downloads/downloads1-3.aspx?lineid=1&famid=4&series=2003072&Software=True
This driver claims to be of revision 1.6 while vanilla ships with 1.2, so i 
gave it a try.

regards, Marcus



--Boundary-00=_lox2/Ib3a/kg885
Content-Type: application/x-gzip;
  name="problem-ethereal-udp-fail.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="problem-ethereal-udp-fail.gz"

H4sICAzu2j8AA3Byb2JsZW0tZXRoZXJlYWwtdWRwLWZhaWwA7d1ZbBRUGIbhM7Zi0aamatwXwB03
QHCLS13qCi2FgqgonXZm2gIqaQCVmIg3ioiCglGjQEGNhhATTTQaE4NypVGj4oJovHFD3OJypXGZ
7x+V4HL+xBuTP++TTARhBubivDk6X+GtjU+u2SnVpz/8+mtKheo/N3215ayhlzSl8dVv65FeOGLI
U4OpofP1j+c0pNaUzlz3Qktqad7t9g2PFfaqPn5ZWJfGpZHTjl4/r1B7iaqhs4oDc6+tVMqzh8wq
z55dHtCPFPTaxbamNL36M/SovWrtV7DXbktJr/306XpdvX4aV3310zZuXT/v5oV6hX9/7Q2NtR9f
9kmq17P1a7V1NKWp1WdM/af3ceG6F+19LNzhfYxdvHH9/O3vo27MuLGF0XWjTzqlbvSpY3bpv+a4
Yqk0UF8cmFNMqbH2js7ubEpzqz937j+9o8rv7+iwHd7RpI33rJ+//R15v0r1vTXae/ss7fH3d6/f
w0k9TemcumSPv77TurHftJ+7sqV5Q/8f7zQB+Fc6UdOqJ2rbzskefz1RO3/wTXv3xy3NqxZwogAg
BpW/5JX/mJbm1SdSfgCIQeW/xSl/caBa/i8pPwDEoPIvd8rf9WxL8+AjlB8AYlD513nlTy3Na67a
/hnhoUcNa7iv/f/+nQMA/huV/8f8ZmKibSb6uPMDPp2ovUrZu9RE20zcwIkCgBhU/uFe+bWZGEP5
ASAGlf80p/y2mfiC8gNADCr/+U75bTPxMOUHgBhU/k6v/NpMXMlmAgBiUPnXlrKbiQ7bTPRy5wd8
OlFP5O9SHbaZuJ4TBQAxqPzPeeXXZmI05QeAGFT+TU75bTOxjfIDQAwq/4dO+W0z8RDlB4AYVP5t
Xvm1mZjOZgIAYlD5jy1nNxOTbDNR4c4P+HSizihn71KTbDNxHScKAGJQ+S/2yq/NxCjKDwAxqPwV
p/y2mfic8gNADCr/HKf8tplYS/kBIAaV/yav/NpMXMFmAgBiUPmfz28mJttmosydH/DpRL2fv0tN
ts3EfE4UAMSg8m/1yq/NxAmUHwBiUPl/cMpvm4mtlB8AYlD5C5V8+W0zsYbyA0AMKv/uXvm1mbic
zQQAxKDyT69kNxOdtpkocecHfDpRs/N3qU7bTMzjRAFADCr/Aq/82kwcT/kBIAaV/1an/LaZ+Izy
A0AMKv8qp/y2mRik/AAQg8q/ziu/NhOXsZkAgBjsayPzm4kptpno4c4P+HSifsrfpabYZmIuJwoA
YlD59+51yq/NxHGUHwBiUPkPc8pvm4lPKT8AxKDyH++U3zYTqyk/AMSg8t/dm/3kbKp9ctZN+QGf
TtTwRdkTNcNO1GWcKMCnE3X2oux/ncywz6JncqIAIAaVf4JXfn0WfSjlB4AYVP5pTvnts+gPKD8A
xKDyl53y22fR91B+AIhB5R/wyq+v32/j6/cBIAaVv35JdjPRZZuJadz5AZ9O1IFLsnepLttM9HOi
ACAGlf8Ir/zaTIyg/AAQg8p/slN+20y8T/kBIAb7Chmn/LaZWEH5ASAGlb/dK782ExPYTABADCr/
5qXZzUTRNhOXcucHfDpR3y3N3qWKtpno40QBQAwq/y9e+bWZGE75ASAGlb95Wb78tpnYQvkBIAaV
/xin/LaZWE75ASAGlf9Ur/zaTIxnMwEAMaj8ry3Pbia6bTMxlTs/4NOJ2ro8e5fqts1ELycKAGJQ
+X/wyq/NxDDKDwAx2GZiRb78tpl4j/IDQAz2p4o65bfNxN2UHwBiUPlHeuXXZuISNhMAEIPK//y9
2c1Ej20mpnDnB3z2J7fcm71L9dhmosKJAoAYVP5PvPJrM3EI5QeAGFT+hvvy5bfNxGbKDwAxqPz7
OOW3zcRdlB8AYlD5R3nl12biYjYTABCDyv/yA9nNRMk2E53c+QGfTtRHD2TvUiXbTJQ5UQAQg8r/
tVd+bSYOpvwAEIPKv+eD+fLbZuJdyg8AMaj8hzjlt83EMsoPADGo/Cd75ddm4iI2EwAQg8q/6MHs
ZqJsm4nJ3PkBn07Uq/m7VNk2EyVOFADEoPK/55Vfm4mDKD8AxGB/H59TfttMvEP5ASAGlf9np/y2
mVhK+QEgBpV/6Eqn/NpMXMhmAgBiUPmLK7ObiYptJiZx5wd8OlFz8nepim0mejhRABCDyn+jV35t
Jg6k/AAQg8p/q1N+20y8TfkBIAaVf4VTfttM3En5ASAGlX+tV35tJi5gMwEAMaj83+Y3E722mejg
zg/4dKLqVmXvUr22mejmRAFADCp/k1d+bSYOoPwAEIPKv79TfttMvEX5ASAGlf9Ip/y2mbiD8gNA
DPZ3c3jl12bifDYTABCDyn/bquxmos82ExO58wM+naj783epPttMFDlRABCDyv+oV35tJvan/AAQ
g8r/jFN+20xsovwAEIPK/4pTfttMLKH8ABCD/X18Xvm1mWhlMwEAMaj8Y1dnNxP9tplo584P+HSi
Wldn71L9tpno4kQBQAwqf4dXfm0m9qP8ABCDyt/llN82E29SfgCIQeW/2im/bSZup/wAEIPKv8Ar
vzYT57GZAIAYVP5N+c3ETNtMtHHnB3w6UZ/m71IzbTMxgxMFADGo/N975ddmYl/KDwAxqPyNg/ny
22biDcoPADGo/Ps55bfNxGLKDwAxqPx9g9lPzmbZJ2cTKD/g21w9Ubse3pRGVr+txw4nakgqNKQh
9alQ+77OVO1ZOll65uPVZ55e/b4etZ9Te/6fz9yp9n07iX++RvOuo060f7M4vZTSsNbxrbt9veWs
/hGNuRvdzfZ/cQucawCI4TcktT9E1nkCAA==

--Boundary-00=_lox2/Ib3a/kg885
Content-Type: text/plain;
  charset="iso-8859-1";
  name="problem-lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="problem-lspci"

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: d7000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at b400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown device 8169 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd.: Unknown device 8169
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at d6800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia video controller: Zoran Corporation ZR36120 (rev 03)
	Subsystem: Unknown device 93c2:2000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 4000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=4K]

00:0c.0 Network controller: Techsan Electronics Co Ltd: Unknown device 2103 (rev 01)
	Subsystem: Techsan Electronics Co Ltd: Unknown device 2103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d5800000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at a400 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-if 00 [VGA])
	Subsystem: Unknown device 174b:7112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d7fe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--Boundary-00=_lox2/Ib3a/kg885
Content-Type: text/plain;
  charset="iso-8859-1";
  name="problem-dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="problem-dmesg"

Linux version 2.4.23-pre9 (root@zwiebel) (gcc version 2.95.4 20011002 (Debian prerelease)) #6 Sam Dez 13 09:43:15 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ffd000 (usable)
 BIOS-e820: 0000000017ffd000 - 0000000017fff000 (ACPI data)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 98301
zone(0): 4096 pages.
zone(1): 94205 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f7f80
ACPI: RSDT (v001 ASUS   P2B      0x42302e31 MSFT 0x31313031) @ 0x17ffd000
ACPI: FADT (v001 ASUS   P2B      0x42302e31 MSFT 0x31313031) @ 0x17ffd080
ACPI: BOOT (v001 ASUS   P2B      0x42302e31 MSFT 0x31313031) @ 0x17ffd040
ACPI: DSDT (v001   ASUS P2B      0x00001000 MSFT 0x01000001) @ 0x00000000
Kernel command line: auto BOOT_IMAGE=Linux-2.4 ro root=301
Initializing CPU#0
Detected 467.734 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 933.88 BogoMIPS
Memory: 385696k/393204k available (1824k kernel code, 7120k reserved, 696k data, 96k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2)
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-algo-bit.o: i2c bit algorithm module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-piix4.o version 2.7.0 (20021208)
i2c-piix4.o: Found PIIX4 device
dmi_scan.o version 2.7.0 (20021208)
dmi_scan.o: SM BIOS found
i2c-piix4.o: SMBus detected and initialized
radeonfb: ref_clk=2700, ref_div=60, xclk=15000 from BIOS
radeonfb: detected DFP panel size from BIOS: 1024x768
Console: switching to colour frame buffer device 128x48
radeonfb: ATI Radeon VE QY DDR SGRAM 32 MB
radeonfb: DVI port DFP monitor connected
radeonfb: CRT port no monitor connected
pty: 256 Unix98 ptys configured
w83781d.o version 2.7.0 (20021208)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] AGP 0.99 Aperture @ 0xe4000000 64MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 92041U4, ATA DISK drive
hdb: LITEON DVD-ROM LTD163D, ATAPI CD/DVD-ROM drive
blk: queue c03bbb20, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 40020624 sectors (20491 MB) w/512KiB Cache, CHS=2491/255/63, UDMA(33)
hdb: attached ide-cdrom driver.
hdb: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
host/uhci.c: USB UHCI at I/O 0xb400, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Linux video capture interface: v1.00
mice: PS/2 mouse device common for all mice
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 96k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
Real Time Clock Driver v1.10e
r8169 Gigabit Ethernet driver 1.2 loaded
r8169: PCI device 00:0a.0: unknown chip version, assuming RTL-8169
r8169: PCI device 00:0a.0: TxConfig = 0x4000000
eth0: Identified chip type is 'RTL-8169'.
eth0: RealTek RTL8169 Gigabit Ethernet at 0xda83a000, 00:08:54:d0:e4:70, IRQ 5
eth0: Auto-negotiation Enabled.
eth0: 100Mbps Full-duplex operation.
8139too Fast Ethernet driver 0.9.26
skystar2.c: FlexCopII(rev.130) chip found
DVB: registering new adapter (Technisat SkyStar2 driver).
DVB: registering frontend 0:0 (Zarlink MT312)...
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
nfs: server kartoffel not responding, still trying
nfs: server kartoffel not responding, still trying
nfs: server kartoffel OK
nfs: server kartoffel not responding, still trying
nfs: server kartoffel not responding, still trying
nfs: server kartoffel OK

--Boundary-00=_lox2/Ib3a/kg885--

