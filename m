Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264752AbUEOWTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264752AbUEOWTG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 18:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264759AbUEOWTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 18:19:05 -0400
Received: from bundy.one-2-one.net ([217.115.142.87]:52362 "EHLO
	bundy.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264752AbUEOWSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 18:18:55 -0400
Envelope-to: linux-kernel@vger.kernel.org
Message-ID: <40A6972D.1090009@icecrash.com>
Date: Sun, 16 May 2004 00:18:21 +0200
From: Sven Wilhelm <wilhelm@icecrash.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040227)
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Problems with radeonfb
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigED9CFBC8281D6DDFAC9B7713"
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED9CFBC8281D6DDFAC9B7713
Content-Type: multipart/mixed;
 boundary="------------090703000208070703090503"

This is a multi-part message in MIME format.
--------------090703000208070703090503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi list,

I have problems with the radeonfb on 2.6.6 and also the older 2.6er 
releases.

the source is a vanilla kernel only patched with the hostap driver for wlan.

distribution: debian sid

the dmesg output:

------------------
Linux version 2.6.6-icecrash-blade (sven@blade) (gcc-Version 3.3.3 
20040125 (prerelease) (Debian)) #1 Sat May 15 22:52:05 CEST 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
  BIOS-e820: 000000003fef0000 - 000000003fefb000 (ACPI data)
  BIOS-e820: 000000003fefb000 - 000000003ff00000 (ACPI NVS)
  BIOS-e820: 000000003ff00000 - 000000003ff80000 (usable)
  BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6390
ACPI: RSDT (v001 PTLTD  Sheeks   0x06040000  LTP 0x00000000) @ 0x3fef6b56
ACPI: FADT (v001 Clevo  845MP    0x06040000 PTL  0x00000050) @ 0x3fefaf2d
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x3fefafa1
ACPI: DSDT (v001 INTEL  845M     0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro root=/dev/hda5 acpi=force 
pmdisk=/dev/hda2
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1800.243 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 905768k/917504k available (2333k kernel code, 10992k reserved, 
834k data, 244k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3563.52 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9c0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: Embedded Controller [EC] (gpe 28)
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, 
System=166.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: CPT CLAA150PA01
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon LW  DDR SGRAM 64 MB
kobject_register failed for radeonfb (-17)
Call Trace:
  [<c0229982>] kobject_register+0x57/0x59
  [<c0279e08>] bus_add_driver+0x4a/0x9d
  [<c027a225>] driver_register+0x2f/0x33
  [<c02332a2>] pci_create_newid_file+0x27/0x29
  [<c02336a8>] pci_register_driver+0x5c/0x84
  [<c0430737>] radeonfb_old_init+0xf/0x1d
  [<c04305bb>] fbmem_init+0x9d/0xe8
  [<c042cb28>] chr_dev_init+0x80/0x9e
  [<c041a78e>] do_initcalls+0x28/0xb4
  [<c012904a>] init_workqueues+0x17/0x31
  [<c01002b4>] init+0x0/0x150
  [<c01002ec>] init+0x38/0x150
  [<c0104258>] kernel_thread_helper+0x0/0xb
  [<c010425d>] kernel_thread_helper+0x5/0xb

Simple Boot Flag at 0x38 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1084657800.854:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, security attributes, realtime, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
Console: switching to colour frame buffer device 175x65
Real Time Clock Driver v1.12
[drm] Initialized radeon 1.9.0 20020828 on minor 0
------------------


i have appended the lspci-output of the graphic card.
for more question feel free to ask.

thanks and greetings

sven


--------------090703000208070703090503
Content-Type: text/plain;
 name="lspci-output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-output"

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

--------------090703000208070703090503--

--------------enigED9CFBC8281D6DDFAC9B7713
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAppcwqgEefU2megoRAiOvAKCbzltMRXD3pQIVVnMjl6pgCNKDZwCeIcBY
zQ3BSCScy1LOmjhbpLjXsRs=
=S8Pv
-----END PGP SIGNATURE-----

--------------enigED9CFBC8281D6DDFAC9B7713--
