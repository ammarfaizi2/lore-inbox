Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUBOXDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265231AbUBOXDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:03:30 -0500
Received: from nan-smtp-14.noos.net ([212.198.2.122]:4525 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id S265225AbUBOXDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:03:05 -0500
Subject: Re: JFS default behavior
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qfoU1Cqq0T6GaxVEGIEo"
Organization: Adresse personelle
Message-Id: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Mon, 16 Feb 2004 00:03:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qfoU1Cqq0T6GaxVEGIEo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

| Linus Torvalds pointed the way of Tux :

| In short: the kernel talks bytestreams, and that implies that if you=20
| want to talk to the kernel, you HAVE TO USE UTF-8.

In that case :
- should the kernel allow apps to write filenames that are invalid=20
  UTF-8 and will crash UTF-8 apps ?
- should this UTF-8 rule be noted somewhere (in a FAQ/man page/LSB spec/
whatever) so apps authors know they are supposed to read and write UTF-8
filenames and not apply locale rules to kernel objects ?
- what happens to already existing invalid UTF-8 filenames ? Should the
kernel forcibly rewrite them (in 2.7.0...) to remove legacy mess ? What
should happen if someone plug an unconverted FS in such a system
afterwards ?

These are the questions people have been asking.



--=-qfoU1Cqq0T6GaxVEGIEo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAL/qmI2bVKDsp8g0RAtrmAKDoQ9x6J83db/hKs4UDKFBWAHq/LgCgnB4M
nDfNDtVspDJqJMlUChHrCF0=
=8/ps
-----END PGP SIGNATURE-----

--=-qfoU1Cqq0T6GaxVEGIEo--

