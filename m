Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264632AbUDVSzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbUDVSzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUDVSzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:55:49 -0400
Received: from p50859C62.dip.t-dialin.net ([80.133.156.98]:39110 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S264632AbUDVSzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:55:31 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc2-mm1
Date: Thu, 22 Apr 2004 20:55:26 +0200
User-Agent: KMail/1.6.2
References: <20040421014544.37942eb4.akpm@osdl.org>
In-Reply-To: <20040421014544.37942eb4.akpm@osdl.org>
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_gUBiAaiukxjr1gj";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404222055.28928@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_gUBiAaiukxjr1gj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 21. April 2004 10:45 schrieben Sie:
> - Several framebuffer driver fixes.  Please test.

My screen is still a bit garbeld after booting.
Still like http://zodiac.dnsalias.org/images/garbage.jpg

radeonfb, Radeon M9 Mobility on IBM T40p 2373-G1G, ACPI
lspci:
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (=
rev=20
03)
        Subsystem: IBM: Unknown device 0529
        Flags: bus master, fast devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [f104]
        Capabilities: [a0] AGP version 2.0

0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (r=
ev=20
03) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 96
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: c0100000-c01fffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        Expansion ROM at 00003000 [disabled] [size=3D4K]

0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01=
)=20
(prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at 1800 [size=3D32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01=
)=20
(prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1820 [size=3D32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01=
)=20
(prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1840 [size=3D32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controlle=
r=20
(rev 01) (prog-if 20 [EHCI])
        Subsystem: IBM: Unknown device 052e
        Flags: bus master, medium devsel, latency 0, IRQ 10
        Memory at c0000000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog=
=2Dif=20
00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D08, sec-latency=3D=
168
        I/O behind bridge: 00004000-00008fff
        Memory behind bridge: c0200000-cfffffff
        Prefetchable memory behind bridge: e8000000-efffffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev=
=20
01)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage=20
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1860 [size=3D16]
        Memory at 20000000 (32-bit, non-prefetchable) [size=3D1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 01)
        Subsystem: IBM: Unknown device 052d
        Flags: medium devsel, IRQ 10
        I/O ports at 1880 [size=3D32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97=
=20
Audio Controller (rev 01)
        Subsystem: IBM: Unknown device 0537
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1c00
        I/O ports at 18c0 [size=3D64]
        Memory at c0000c00 (32-bit, non-prefetchable) [size=3D512]
        Memory at c0000800 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [50] Power Management version 2

0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev =
01)=20
(prog-if 00 [Generic])
        Subsystem: IBM: Unknown device 0525
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 2400
        I/O ports at 2000 [size=3D128]
        Capabilities: [50] Power Management version 2

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf=
=20
[Radeon Mobility 9000 M9] (rev 02) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 054d
        Flags: bus master, stepping, fast Back2Back, 66MHz, medium devsel,=
=20
latency 66, IRQ 9
        Memory at e0000000 (32-bit, prefetchable)
        I/O ports at 3000 [size=3D256]
        Memory at c0100000 (32-bit, non-prefetchable) [size=3D64K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus=20
Controller (rev 01)
        Subsystem: IBM ThinkPad T30/T40
        Flags: bus master, medium devsel, latency 168, IRQ 9
        Memory at b0000000 (32-bit, non-prefetchable)
        Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D=
176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus=20
Controller (rev 01)
        Subsystem: IBM ThinkPad T30/T40
        Flags: bus master, medium devsel, latency 168, IRQ 10
        Memory at b1000000 (32-bit, non-prefetchable)
        Bus: primary=3D02, secondary=3D07, subordinate=3D0a, sec-latency=3D=
176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001

0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet=20
Controller (Mobile) (rev 03)
        Subsystem: IBM PRO/1000 MT Mobile Connection
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 9
        Memory at c0220000 (32-bit, non-prefetchable)
        Memory at c0200000 (32-bit, non-prefetchable) [size=3D64K]
        I/O ports at 8000 [size=3D64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
=20
Enable-

0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.1=
1ab=20
NIC (rev 01)
        Subsystem: Unknown device 17ab:8310
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at c0210000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 2


root@t40:~# dmesg | grep radeonfb
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D252.00 Mhz, System=
=3D200.00 MHz
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: SXGA+ Single (85MHz)
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB

regards
Alex


=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--Boundary-02=_gUBiAaiukxjr1gj
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAiBUg/aHb+2190pERAtb7AJ9kpmoQ2uU9Jnj927Gb9r3/fmSU0QCdHdon
ZDR8t3ss/7j63/AVkvh2NX4=
=MBdL
-----END PGP SIGNATURE-----

--Boundary-02=_gUBiAaiukxjr1gj--
