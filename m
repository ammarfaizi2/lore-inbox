Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVFRPb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVFRPb0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVFRPb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 11:31:26 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:13405 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S262136AbVFRPbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 11:31:13 -0400
Message-ID: <42B43E3B.4080307@poczta.fm>
Date: Sat, 18 Jun 2005 17:31:07 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, mru@inprovide.com,
       Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <4eUwr-7i7-33@gated-at.bofh.it> <4ffAV-72e-11@gated-at.bofh.it> <4fBrR-7eO-31@gated-at.bofh.it> <4fBUW-7wi-19@gated-at.bofh.it> <4fCe4-7Rm-11@gated-at.bofh.it> <4fCHg-89R-29@gated-at.bofh.it> <4fHxo-3Lo-63@gated-at.bofh.it> <4fNMd-l6-25@gated-at.bofh.it> <E1DjCu5-0001jc-Nl@be1.7eggert.dyndns.org>
In-Reply-To: <E1DjCu5-0001jc-Nl@be1.7eggert.dyndns.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig72946D0BEBFC29B0C5F23F1C"
X-EMID: 50c09138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72946D0BEBFC29B0C5F23F1C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Bodo Eggert napisa=C5=82(a):

>>VFAT uses unicode?  I thought it used the same codepage silyness as FAT=

>>did, since after all ti was just supposed to be a long filename
>>extension to FAT.  Do they use unicode in the long filenames only?
>=20
>=20
> It uses two codepages, one for short names and one for long names.
> The long name charset defaults to iso-8859-1,

Please look below where you have got "t.e.s.t.". That is obviously
UTF-16 (below FFFF) not iso-8859-1.

> and the short one to cp437

Yes.

> 0600  41 74 00 65 00 73 00 74  00 e4 00 0f 00 db f6 00  At.e.s.t ......=
=2E.
> 0610  fc 00 df 00 74 00 65 00  73 00 00 00 74 00 00 00  ....t.e. s...t.=
=2E.
> 0620  54 45 53 54 8e 99 7e 31  20 20 20 20 00 00 d0 58  TEST..~1     ..=
=2EX
> 0630  d1 32 d1 32 00 00 d0 58  d1 32 00 00 00 00 00 00  .2.2...X .2....=
=2E.


Has anybode seen characters above 0xFFFF on the vfat?

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig72946D0BEBFC29B0C5F23F1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCtD4/NdzY8sm9K9wRAvBkAJ0fiV7wHInW2J23P+ofWt7Jygd4VgCePcXS
tii4CV7nFj427ZktlpKRP0U=
=SbYZ
-----END PGP SIGNATURE-----

--------------enig72946D0BEBFC29B0C5F23F1C--
