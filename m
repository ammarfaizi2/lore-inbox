Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWGZArf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWGZArf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWGZArf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:47:35 -0400
Received: from 63-162-81-169.lisco.net ([63.162.81.169]:48560 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1030297AbWGZAre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:47:34 -0400
Message-ID: <44C6BBA5.3050704@slaphack.com>
Date: Tue, 25 Jul 2006 19:47:33 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060708)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Mike Benoit <ipso@snappymail.ca>,
       Matthias Andree <matthias.andree@gmx.de>,
       Hans Reiser <reiser@namesys.com>, lkml@lpbproductions.com,
       Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607242151.k6OLpDZu009297@laptop13.inf.utfsm.cl> <44C6B784.5050507@slaphack.com> <Pine.LNX.4.63.0607251732001.9159@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0607251732001.9159@qynat.qvtvafvgr.pbz>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enigB330AB0C700B0888B0BC2F22"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB330AB0C700B0888B0BC2F22
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

David Lang wrote:
> On Tue, 25 Jul 2006, David Masover wrote:
>=20
>> Horst H. von Brand wrote:
>>
>>> 18GiB =3D 18 million KiB, you do have a point there. But 40 million
>>> files on
>>> that, with some space to spare, just doesn't add up.
>=20
> if you have 18 million KiB and each file is a single block (512 Bytes =3D=

> 0.5 Kib) then assuming zero overhead you could fit 18 Million KiB / 0.5=

> KiB =3D 36 Million files on the drive.
>=20
> thus being scheptical about 40 million files on a 18G drive.
>=20
> this is only possible if you are abel to have multiple files per 512
> byte block.

I believe Reiser4 does this.  Does ext3?  I know I heard somewhere in
this thread that you can't set the blocksize lower than 1k...


--------------enigB330AB0C700B0888B0BC2F22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRMa7pXgHNmZLgCUhAQoFSw//RjP2QZv13yH8jJ66biGd0FE/HkezJTGV
iXIk87bzPPPVjBrr5d3qrOERpnH90+J0lBZK1KGA4Kka14dy4WAchzNofszik/cC
y5F/blSlf9fFWX4tnM/gab+AuUM0eE4LxYuU7l6gacDA+LvwUgm350ONULUl6Bs+
KO2t5h3jHzQ8PiVesv8ZI9DQoM7AGi7MmTnm4oHNehDZhxjn0p7X8AIfIjteZXYP
pCJE8NuRncK2psH+bigHbjWtkg+OAraSzlIDJWNq8wK26GYFG1mb/cgAGk0K/HLA
p3qQkRQJhpdPGC/fowqIdKHe06cx1sDNicqMwA9o5FCGaxOZqT1uoJGOf6rOuMIA
0RhF5h/2JR+aiZNRw5Ipv/ec0Cm8Uyq3cAmksD6LJqlpYyYQ2D69QYAfovpgLsz9
9I7zGISViDmDz/SbsJDdFrUsv3pRyM9j89SlGrMEYlyGZa25ITf9FJkwH9H2Ji2G
y60CPlZzECUFsOg5VdtKEAZeoc/NfGMtxFch4PLjdNPkknsDc31tV6jphhSsJKk1
WhBQZ1VVfEAu1V3F/Thd3gddlG3tBxwlPgtRyfAcUapjOOhIAvHEQnwWXeu92BAJ
iqZnhWm3itKDPzcZJnC6hC+3lZmHo/TRqIZIbU1RkqW0gFI9ChtoLhvx75BuQC4t
aXWxVDwIrUQ=
=esNy
-----END PGP SIGNATURE-----

--------------enigB330AB0C700B0888B0BC2F22--
