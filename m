Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbTL0Aul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 19:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbTL0Aul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 19:50:41 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:21127 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265283AbTL0Auh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 19:50:37 -0500
Subject: Re: 2.6.0 sound output - wierd effects
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <2060000.1072483186@[10.10.2.4]>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s7U8+hI3M/fYxLbysBB1"
Message-Id: <1072486379.12308.33.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 02:53:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s7U8+hI3M/fYxLbysBB1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-27 at 01:59, Martin J. Bligh wrote:

> > If you right click on xmms, and then select options->preferences, on th=
e
> > first page to the bottom there should be output plugin.  If you cannot
> > select alsa, see if there is a xmms-alsa or libxmms-alsa plugin.  Sorry=
,
> > I do not know Debian that well.
>=20
> Thanks, it was on OSS - there's no ALSA selection, nor can I find one.
> There's probably one in unstable somewhere, but ... see below.

Btw, compile xmms yourself - should have alsa then =3D)  Not sure if
it will if you build with apt-get from source, or when they started
to ship the alsa module with xmms source - think it was not so long
ago.  Does with 1.2.8 though:

--
# qpkg -v -f /usr/lib/xmms/Output/libALSA.so
media-sound/xmms-1.2.8-r3 *
--


--=20
Martin Schlemmer

--=-s7U8+hI3M/fYxLbysBB1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7NfrqburzKaJYLYRAt92AJ9f8oDOpDVkNkfqfFWB4VEj5wbUyQCfbDZt
b2e+zYzl8aL6qsUY0cQYqlM=
=56xc
-----END PGP SIGNATURE-----

--=-s7U8+hI3M/fYxLbysBB1--

