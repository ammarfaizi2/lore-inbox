Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbTLKLsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 06:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbTLKLsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 06:48:09 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:25479
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264896AbTLKLrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 06:47:51 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com, kernel@kolivas.org
In-Reply-To: <200312111655.25456.ross@datscreative.com.au>
References: <200312072312.01013.ross@datscreative.com.au>
	 <200312101543.39597.ross@datscreative.com.au>
	 <Pine.LNX.4.55.0312101653490.31543@jurand.ds.pg.gda.pl>
	 <200312111655.25456.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MGYUhWJsNYXHzW1q+zya"
Message-Id: <1071143274.2272.4.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 12:47:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MGYUhWJsNYXHzW1q+zya
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-12-11 at 07:55, Ross Dickson wrote:
> albatron:/usr/src/mptable-2.0.15a # ./mptable -verbose
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>=20
> MPTable, version 2.0.15 Linux
>=20
>  looking for EBDA pointer @ 0x040e, found, searching EBDA @ 0x0009fc00
>  searching CMOS 'top of mem' @ 0x0009f800 (638K)
>  searching default 'top of mem' @ 0x0009fc00 (639K)
>  searching BIOS @ 0x000f0000
>=20
>  MP FPS found in BIOS @ physical addr: 0x000f50b0
>=20
> -------------------------------------------------------------------------=
------
>=20
> MP Floating Pointer Structure:
>=20
>   location:                     BIOS
>   physical address:             0x000f50b0
>   signature:                    '_MP_'
>   length:                       16 bytes
>   version:                      1.1
>   checksum:                     0x00
>   mode:                         Virtual Wire
>=20
> -------------------------------------------------------------------------=
------
>=20
> MP Config Table Header:
>=20
>   physical address:             0x0xf0c00
>   signature:                    '$ml$'
>   base table length:            0
>   version:                      1.6
>   checksum:                     0x00
>   OEM ID:                       '=C4
>                                   =B8=A7'
> =B0=F6Product ID:                   '(
> m'P
>   OEM table pointer:            0x12d90e22
>   OEM table size:               7964
>   entry count:                  7964
>   local APIC address:           0x1f1c1f1c
>   extended table length:        65284
>   extended table checksum:      255
>=20
> -------------------------------------------------------------------------=
------
>=20
> MP Config Base Table Entries:
>=20
> --
> MPTABLE HOSED! record type =3D 55
> albatron:/usr/src/mptable-2.0.15a #
>=20

> Perhaps someone else could get mptable to run on their machine and send y=
ou
> the result.

mptable dosn't seem to accept it's own options, anyways, heres the
output.

mptable -extra -verbose -pirq
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
=20
MPTable, version 2.0.15 Linux
=20
 looking for EBDA pointer @ 0x040e, found, searching EBDA @ 0x0009fc00
 searching CMOS 'top of mem' @ 0x0009f800 (638K)
 searching default 'top of mem' @ 0x0009fc00 (639K)
 searching BIOS @ 0x000f0000
=20
 MP FPS found in BIOS @ physical addr: 0x000f5ce0
=20
---------------------------------------------------------------------------=
----
=20
MP Floating Pointer Structure:
=20
  location:                     BIOS
  physical address:             0x000f5ce0
  signature:                    '_MP_'
  length:                       16 bytes
  version:                      1.1
  checksum:                     0x00
  mode:                         Virtual Wire
=20
---------------------------------------------------------------------------=
----
=20
MP Config Table Header:
=20
  physical address:             0x0xf0c00
  signature:                    ''
  base table length:            1280
  version:                      1.7
  checksum:                     0x00
  OEM ID:                       ''
  Product ID:                   ''
  OEM table pointer:            0x0000ffff
  OEM table size:               0
  entry count:                  65535
  local APIC address:           0x000000c4
  extended table length:        1
  extended table checksum:      0
=20
---------------------------------------------------------------------------=
----
=20
MP Config Base Table Entries:
=20
--
Processors:     APIC ID Version State           Family  Model   Step    Fla=
gs
                 0       0x 7    BSP, usable     15      15      15      0x=
1a00c035
                 0       0x 0    AP, unusable    0       0       10      0x=
78ffff0a
--
MPTABLE HOSED! record type =3D 15

I couldn't find the source so i used a old RedHat rpm...
(Asus A7N8X-X bios 1007)
=20
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-MGYUhWJsNYXHzW1q+zya
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/2Flq7F3Euyc51N8RAgn3AKCsJWnd9Yugwy1hyaxjILfeLQ2F3ACeNuj6
5cr1dQ08CJKRPMUVt3u0We8=
=gDpH
-----END PGP SIGNATURE-----

--=-MGYUhWJsNYXHzW1q+zya--

