Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266203AbUAGKYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUAGKX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:23:59 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:19592 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S266203AbUAGKXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:23:54 -0500
Date: Wed, 7 Jan 2004 11:23:52 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: scheduling problems in X with 2.6.0
Message-ID: <20040107102352.GA2954@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Ever since I moved to 2.6.0, I have been experiencing something I'd
like to call scheduling problems while working in X. I have tried
using preemptive mode, and turning it off, but the symptoms are the
same:

whenever there is continuous disk access (e.g. tar, rsync, dd),
X will not respond for a couple of seconds every couple of seconds.
With that I mean that the mouse will freeze as well as all screen
output, and then resume after a couple of seconds.

I wonder if I am the only one with that problem. The machine in
question is a dual AMD 2400+ with 2Gb of RAM and a Maxtor DiamondMax
drive spinning at 7200 RPM. The drive is configured as follows
(hdparm):

 multcount    =3D 16 (on)
 IO_support   =3D  1 (32-bit)
 unmaskirq    =3D  0 (off)
 using_dma    =3D  1 (on)
 keepsettings =3D  0 (off)
 readonly     =3D  0 (off)
 readahead    =3D 256 (on)
 geometry     =3D 16383/255/63, sectors =3D 241254720, start =3D 0
 Model=3DIC35L120AVV207-0, FwRev=3DV24OA63A, SerialNo=3DVNVD06G4C1NXZL
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D52
 BuffType=3DDualPortCache, BuffSize=3D1821kB, MaxMultSect=3D16, MultSect=3D=
16
 CurCHS=3D65535/1/63, CurSects=3D4128705, LBA=3Dyes, LBAsects=3D241254720
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4=20
 DMA modes:  mdma0 mdma1 mdma2=20
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5=20
 AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:=20

I would appreciate any pointers to the source of the problem, or
general hints!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"never try to explain computers to a layman.
 it's easier to explain sex to a virgin."
                                                    -- robert heinlein
=20
(note, however, that virgins tend to know a lot about computers.)

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+944IgvIgzMMSnURAvYwAJ9/U45rL3rm/G7CJUP/2/HG7TLueACfe9Bc
7eQHTZmUNPl7eVaa+CZ3SPo=
=fJYP
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
