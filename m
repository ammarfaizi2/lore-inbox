Return-Path: <linux-kernel-owner+w=401wt.eu-S1750696AbXAQVq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbXAQVq5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbXAQVq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:46:57 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:52560 "EHLO
	mailout05.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750696AbXAQVq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:46:57 -0500
Message-ID: <45AE9934.6040009@t-online.de>
Date: Wed, 17 Jan 2007 22:46:28 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
References: <45841710.9040900@t-online.de> <4587F87C.2050100@gmail.com> <45883299.2050209@t-online.de> <45887CD8.5090100@gmail.com> <458AE5FB.7080607@t-online.de> <4591FE96.1080606@gmail.com> <459346C4.1030802@gmail.com> <45941F1E.2080808@t-online.de> <459A482C.6020809@gmail.com> <45A296BC.8020208@t-online.de> <45AE30A8.70802@gmail.com>
In-Reply-To: <45AE30A8.70802@gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3999A88528E2F6466F48C34C"
X-ID: rXaTjUZFgeqelX5E-wQlzXsFmbADc4wInW9JrzJwMVj1KM2GBvXfkI
X-TOI-MSGID: 80f1e399-5b65-48aa-90ec-8ccfe63c0f0e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3999A88528E2F6466F48C34C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

Tejun Heo wrote:
>=20
> Okay, I just tested a number of dvds on x86-64 and x86.  The error
> pattern is really interesting.  It doesn't matter whether you're on
> x86-64 or x86, 2.6.18 or 2.6.20-rc5.  The problem occurs when a dvd
> which doesn't match dvd's region mask is played.
>=20
> MMC command 0xa4 (READ KEY) is the one which always fails.  After the
> failure, the odd goes into strange state and usually won't respond to
> commands.  Interestingly, if you pull the power plug or reset the
> machine while the READ KEY command is in progress and then reconnect it=
,
> you can play the DVD after that.  I've checked this multiple times and
> no, dvdcss key caching isn't the cause, crossed checked it multiple tim=
es.
>=20
> Once you played a dvd this way, the drive seems to remember the dvd and=

> successfully plays it afterwards.  I've checked this multiple times
> using completely separate OS installation (one x86, the other x86-64).
>=20

How comes that there is no such problem if I connect the drive
via an USB SATA adapter?

> This almost looks like new defense method against CSS-workaround.  Can'=
t
> understand why the drive remembers successfully played dvds tho.
>=20

I would have the option to return it (playing no DVDs is surely
a defect), but this would be a shame. It was lightning fast on writing,
a little bit noisy, though, but I was really glad to get rid of that
clumsy parallel cable.

Do you think it would be reasonable to send a bug report to Samsung,
and see what they say? I would need some documentation about these
MMC commands, though. Is this part of some "Red Book" standard, or
so?


Regards

Harri



--------------enig3999A88528E2F6466F48C34C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrpk7UTlbRTxpHjcRAvm/AJ0aOM9SR9Hn7byzAtlZDTmMq+htWgCffL0D
48EN5sNRCUb1FAqnST+96YE=
=w4+R
-----END PGP SIGNATURE-----

--------------enig3999A88528E2F6466F48C34C--
