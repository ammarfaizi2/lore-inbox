Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUBOTXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 14:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUBOTXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 14:23:16 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:45719 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265152AbUBOTXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 14:23:14 -0500
Subject: Re: ICH5 with 2.6.1 very slow
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Kyle <kyle@southa.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <200402152019.34858.bzolnier@elka.pw.edu.pl>
References: <021801c3f3f4$50f66280$353ffea9@kyle>
	 <200402152019.34858.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fMcJHGdSfg9aqANsLRHj"
Message-Id: <1076873030.27648.17.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 21:23:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fMcJHGdSfg9aqANsLRHj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-02-15 at 21:19, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 15 of February 2004 19:48, Kyle wrote:
> > today since one of my mirrored harddisk (/dev/hda) failed, I removed it
> > from md-raid1 and now /dev/hdc becomes /dev/hda
> >
> > hdparm -t /dev/hda gets me ~37MB/s now (before: /dev/hda - 30MB/s,
> > /dev/hdc - 37MB/s)
> >
> > maybe there's problem with /dev/hda so it's relatively slower!
> >
> > However, the result still much slower than kernel 2.4.20 (55MB/s)
>=20
> Please fill bugzilla entry (htp://bugzilla.kernel.org)
> and attach 'dmesg' and 'lspci -vvv -xxx' outputs for 2.4.20 and 2.6.x.
>=20
> It would be also helpful to narrow down the issue to kernel version when
> this slowdown started (2.4.20 -> 2.6.x means too much changes to anybody
> sane to even start thinking about going through all of them).
>=20

Also a hdparm -i /dev/hda might help I guess (as the small default
read-ahead causes this for many users)

--=20
Martin Schlemmer

--=-fMcJHGdSfg9aqANsLRHj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAL8dGqburzKaJYLYRAlD7AJ9f8vIB0KiUtdKfTsSaPpiV18eGFgCePIPL
rWyhsF8OO1cTStv+ikaQKdo=
=2KvZ
-----END PGP SIGNATURE-----

--=-fMcJHGdSfg9aqANsLRHj--

