Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265872AbUFISCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUFISCf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUFISCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:02:35 -0400
Received: from noc.safeweb.be ([82.138.76.65]:7131 "EHLO safeweb.be")
	by vger.kernel.org with ESMTP id S265872AbUFISCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:02:30 -0400
Subject: RE: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
From: Evaldo Gardenali <evaldo@gardenali.biz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.56.0406091911340.26677@jjulnx.backbone.dif.dk>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAWUyJbbFwtUuY/ZGbgGI8TwEAAAAA@casabyte.com>
	 <Pine.LNX.4.56.0406091911340.26677@jjulnx.backbone.dif.dk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0LoS7T0r0pgEPR7MR913"
Message-Id: <1086804146.2047.29.camel@server1.aguabranca.com.br>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 15:02:26 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0LoS7T0r0pgEPR7MR913
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi there :)

Jesper Juhl wrote:
> On Tue, 8 Jun 2004, Robert White wrote:
>=20
> > I would think that having an easy call to disable the NX modification w=
ould be both
> > safe and effective.  That is, adding a syscall (or whatever) that would=
 let you mark
> > your heap and/or stack executable while leaving the new default as NX, =
is "just as
> > safe" as flagging the executable in the first place.
> >
>=20
> Just having the abillity to turn protection off opens the door. If it is

indeed!

> possible to turn it off then a way will be found to do it - either via
> buggy kernel code or otherwhise. Only safe approach is to have it
> enabled by default and not be able to turn it off IMHO.

if there's a way to turn it off, there's certainly a hole waiting for
trouble.

This reminds me of the "Safe Level" of NetBSD. want to run X? downgrade
your Safe Level (0 by default, can run anything)
http://netbsd.gw.com/cgi-bin/man-cgi/man?options+4+NetBSD-current --
look for "options INSECURE"
I know there may be some flaws on that concept, but it looks interesting
:)

Evaldo


--=-0LoS7T0r0pgEPR7MR913
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
	assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAx1Cy5121Y+8pAbIRAkN/AJ9+L8nKvJwsadURmhs2nOjiL1hw7gCeJg/f
G4dssn04CG+Dc6H43aUmeY0=
=pqdu
-----END PGP SIGNATURE-----

--=-0LoS7T0r0pgEPR7MR913--

