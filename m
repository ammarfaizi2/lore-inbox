Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSFIXv2>; Sun, 9 Jun 2002 19:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSFIXv1>; Sun, 9 Jun 2002 19:51:27 -0400
Received: from ua83d37hel.dial.kolumbus.fi ([62.248.234.83]:31309 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S315374AbSFIXvZ>; Sun, 9 Jun 2002 19:51:25 -0400
Subject: [Fwd: Promise driver (pdc202xx)]
From: Jussi Laako <jussi.laako@kolumbus.fi>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-SHNqj7tasd+WCQINQj1G"
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Jun 2002 02:51:20 +0300
Message-Id: <1023666681.1163.4.camel@vaarlahti>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SHNqj7tasd+WCQINQj1G
Content-Type: multipart/mixed; boundary="=-HChGMwmeI0oGv1WwIvH0"


--=-HChGMwmeI0oGv1WwIvH0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm forwarding my mail to lkml also.

As addition to the information, mobo is ASUS A7M266 and Promise BIOS
version is 2.20.0.12.


	- Jussi Laako

--=20
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
GPG key fingerprint: 0D10 D6D5 9F14 1A88 BA7F  7F17 ED92 8E98 EB43 8990
Available at PGP keyservers

--=-HChGMwmeI0oGv1WwIvH0
Content-Disposition: inline
Content-Description: Forwarded message - Promise driver (pdc202xx)
Content-Type: message/rfc822

Subject: Promise driver (pdc202xx)
From: Jussi Laako <jussi.laako@kolumbus.fi>
To: andre@linux-ide.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pDDWSAWf97glCr3CNaV9"
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Jun 2002 09:42:12 +0300
Message-Id: <1023259333.7220.16.camel@vaarlahti>
Mime-Version: 1.0


--=-pDDWSAWf97glCr3CNaV9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

Is it normal to have pdc202xx driver to enable only UDMA33 on Ultra133
TX2 (PDC20269)? Disk is new 60GB Seagate Barracuda. U133TX2's BIOS says
it has enabled UDMA5.

Driver is: ide-2.4.19-p7.all.convert.10.patch.bz2

Here's some info from dmesg:

PDC20269: chipset revision 2
PDC20269: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0x5800-0x5807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x5808-0x580f, BIOS settings: hdg:pio, hdh:pio

hde: ST360021A, ATA DISK drive

hde: host protected area =3D> 1
hde: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=3D116301/16/63,
UDMA(33)


/proc/pci/ide/pdc202xx says only (nothing else):

                                PDC20269 TX2 Chipset.

And from "lspci -vvvxxx":

00:0c.0 Unknown mass storage controller: Promise Technology, Inc.:
Unknown device 4d69 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 7000 [size=3D8]
        Region 1: I/O ports at 6800 [size=3D4]
        Region 2: I/O ports at 6400 [size=3D8]
        Region 3: I/O ports at 6000 [size=3D4]
        Region 4: I/O ports at 5800 [size=3D16]
        Region 5: Memory at e6000000 (32-bit, non-prefetchable)
[size=3D16K]
        Expansion ROM at <unassigned> [disabled] [size=3D16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 5a 10 69 4d 07 00 30 04 02 85 80 01 08 20 00 00
10: 01 70 00 00 01 68 00 00 01 64 00 00 01 60 00 00
20: 01 58 00 00 00 00 00 e6 00 00 00 00 5a 10 68 4d
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 04 12
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 21 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



Best regards,

	- Jussi Laako	(IRC: SonarNerd)

--=20
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
GPG key fingerprint: 0D10 D6D5 9F14 1A88 BA7F  7F17 ED92 8E98 EB43 8990
Available at PGP keyservers

--=-pDDWSAWf97glCr3CNaV9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8/bLES3txJU4L5RQRApboAKC4HLnZYjYLIe+7BO8ojHitX/wIGgCgmtjH
9Zm3coS25QL76O3wOaLE6B4=3D
=3DV1fv
-----END PGP SIGNATURE-----

--=-pDDWSAWf97glCr3CNaV9--


--=-HChGMwmeI0oGv1WwIvH0--

--=-SHNqj7tasd+WCQINQj1G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9A+n4S3txJU4L5RQRAhVBAJ9CF1IfVGJNu4P5m9SN/ICkdXphXACeLTgp
/D2erZqhVyFwSBlxbpdyaLs=
=6G+W
-----END PGP SIGNATURE-----

--=-SHNqj7tasd+WCQINQj1G--

