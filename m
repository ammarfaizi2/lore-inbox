Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265404AbTL2UiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbTL2Uf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:35:28 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:21922 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S265391AbTL2UfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:35:00 -0500
Subject: Re: CD burn buffer underruns on 2.6
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Claas Langbehn <claas@rootdir.de>
Cc: craig duncan <duncan@nycap.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031229172226.GA2741@rootdir.de>
References: <16366.60194.935861.592797@nycap.rr.com>
	 <20031229172226.GA2741@rootdir.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ih2FBQsa/uCbnkLX2Ivd"
Message-Id: <1072730096.14764.5.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Dec 2003 21:34:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ih2FBQsa/uCbnkLX2Ivd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-29 at 18:22, Claas Langbehn wrote:
> Hello,
>=20
>=20
> ide-scsi is deprecated and should not be used
> any longer. Instead you should use the ide=20
> device directly. F.ex.
>=20
> cdrecord dev=3Ddev/hdc ...
>=20
> But as far as i know, cdrdao does not support
> this yet :(

Some time ago I compiled cdrdao 1.1.7 with support for this (iirc I
copied libscg from cdrecord)
I use it all the time with 2.6, works like a charm at 32x.

If you are brave enough you can use it (never trust binaries offered by
strange people :) especially don't run them as root. (I never burn cd's
as root, works just fine as a normal user as long as you have
write-permission for the blockdevice, but you loose the
realtime-priority of the process when running as non-root which might
matter if you have a slow or highly loaded system while burning)

wget gandalf.hjorten.nu/cdrdao

--=20
/Martin

--=-Ih2FBQsa/uCbnkLX2Ivd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/8I/vWm2vlfa207ERAhRrAJ9tqPUfIhjAQIDkvc5zPVzmMvSgDgCgorXH
cIc/UonnuI/FUTRPMP2ecmI=
=SPB9
-----END PGP SIGNATURE-----

--=-Ih2FBQsa/uCbnkLX2Ivd--
