Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288780AbSAVRig>; Tue, 22 Jan 2002 12:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289161AbSAVRi0>; Tue, 22 Jan 2002 12:38:26 -0500
Received: from tabaluga.ipe.uni-stuttgart.de ([129.69.22.180]:30607 "EHLO
	tabaluga.ipe.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S288780AbSAVRiR>; Tue, 22 Jan 2002 12:38:17 -0500
From: Nils Rennebarth <nils@ipe.uni-stuttgart.de>
Date: Tue, 22 Jan 2002 18:38:15 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17: Hang after IDE detection
Message-ID: <20020122173815.GH900@ipe.uni-stuttgart.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201221421050.20914-100000@aither.zcu.cz> <Pine.GSO.4.21.0201221547420.18952-100000@skiathos.physics.auth.gr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uu2n37VG4rOBDVuR"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0201221547420.18952-100000@skiathos.physics.auth.gr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2002 at 05:18:27PM +0200, Liakakis Kostas wrote:
> I recently got an older k6-2/333 with a SiS chipset and tried to install
> linux on it.
>=20
> Every recent distro I tryed with a 2.4.x kernel would hang after detecting
> the SiS5513 controller.

> SIS5513: chipset revision 208
> SIS5513: not 100% native mode: will probe irqs later
> SIS5597
>     ide0: BM-DMA at 0x4000-0x4007, BIOS settings hda:pio, hdb:pio
>     ide1: BM-DMA at 0x4008-0x400f, BIOS settings hdc:pio, hdb:pio
for me the hang happens here. Other symptoms are about the same.

> hda: ST34321A, ATA DISK drive
> hdc: CD-540E, ATAPI CD/DVD-DROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on ira 15
> <hang>
all recent (>=3D16) and a 2.4.6 pre7 kernel hang. 2.2.19 is no problem.

Nils

--
                                     ______
                                    (Muuuhh)
Global Village Sau  =3D=3D>        ^..^ |/=AF=AF=AF=AF=AF
(Kann Fremdsprache) =3D=3D>        (oo)

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8TaOHqgAZ+sZlgs4RAixeAJ4opIQgxNp+PQOA60EwT9wNKPQ2cACbBEey
9NvbtjRFHX9GJa3LcmmV+nI=
=CXi8
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--
