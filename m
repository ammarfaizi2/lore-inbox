Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbTL3PyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 10:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbTL3PyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 10:54:05 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:55765 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265815AbTL3PyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 10:54:01 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Tue, 30 Dec 2003 10:53:58 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.0: alsa, esd, mpg123
Message-ID: <20031230155358.GB23963@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

on my debian (unstable) laptop newly running 2.6.0, i've noticed
an irritating tendency for music to not pause, but instead to
try to go too fast, skipping small parts of the song (fractions
of a second).  this results in music with regular beats sounding
erratic.

i'm using gqmpeg -> mpg123-esd -> esd -> oss -> alsa (maestro3).

switching esd to use -tcp instead of -unix seems to alleviate
the trouble a bit.  ogg123 playing through esd doesn't seem to
do it as much either.

has anyone else noted this problem and tuned it away?  thanks.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8Z+WCGPRljI8080RAjHvAJ9oPspSOyEw2iRMyJA3oCAOGSQm5gCfdf0v
vuuWEmhsEd1aF2+ERcN1Hao=
=aeZz
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
