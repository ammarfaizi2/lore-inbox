Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUFOUSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUFOUSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUFOUSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:18:07 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:5606 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265909AbUFOUQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:16:08 -0400
Date: Tue, 15 Jun 2004 22:16:07 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Switching off PS/2 keyboard
Message-ID: <20040615201607.GS20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <E1BaDva-0001Y8-LK@beton.cybernet.src> <20040615132849.A5968@beton.cybernet.src> <20040615150522.GA5602@ucw.cz> <20040615171653.D6843@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOyqOxHQInpDuxI3"
Content-Disposition: inline
In-Reply-To: <20040615171653.D6843@beton.cybernet.src>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOyqOxHQInpDuxI3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-15 17:16:53 +0000, Karel Kulhav=FD <clock@twibright.com>
wrote in message <20040615171653.D6843@beton.cybernet.src>:
> On Tue, Jun 15, 2004 at 05:05:22PM +0200, Vojtech Pavlik wrote:
> > On Tue, Jun 15, 2004 at 01:28:49PM +0000, Karel Kulhav=FD wrote:
> > > Is it possible to switch off PS/2 keyboard support in 2.4.25 make men=
uconfig?
> > > I have searched through the make menuconfig and didn't find anything =
looking
> > > like that.
> >=20
> > It is only possible in 2.6.
>=20
> Is it possible to switch off AT keyboard in 2.4?

No. At least, not really. Of course, you'd f*ck up the interrupt handler
to not really handle the interrupt or to not deliver the fetched data...

> Is it possible to switch off AT keyboard in 2.6?

Easily, if you enable CONFIG_EMBEDDED. Just look into the Kconfig files
to see the dependancies.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--BOyqOxHQInpDuxI3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAz1kHHb1edYOZ4bsRAtyhAJ9hxiAoqx/305wpql7PiwH30ev5GACcDYQG
75a1rBGcJEH6VPaoPHZGnAQ=
=UVyO
-----END PGP SIGNATURE-----

--BOyqOxHQInpDuxI3--
