Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbUL3QgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbUL3QgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 11:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUL3QgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 11:36:24 -0500
Received: from lug-owl.de ([195.71.106.12]:35243 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261652AbUL3QgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 11:36:18 -0500
Date: Thu, 30 Dec 2004 17:36:17 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dave Dillow <dave@thedillows.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.10 1/22] xfrm: Add direction information to xfrm_state
Message-ID: <20041230163617.GB2460@lug-owl.de>
Mail-Followup-To: Dave Dillow <dave@thedillows.org>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20041230035000.01@ori.thedillows.org> <20041230035000.10@ori.thedillows.org> <20041230094839.GX2460@lug-owl.de> <1104423409.23254.9.camel@dillow.idleaire.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Wo9T3dGHPT+4OQz"
Content-Disposition: inline
In-Reply-To: <1104423409.23254.9.camel@dillow.idleaire.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5Wo9T3dGHPT+4OQz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-12-30 11:16:49 -0500, Dave Dillow <dave@thedillows.org>
wrote in message <1104423409.23254.9.camel@dillow.idleaire.com>:
> On Thu, 2004-12-30 at 04:48, Jan-Benedict Glaw wrote:
> > On Thu, 2004-12-30 03:48:34 -0500, David Dillow <dave@thedillows.org>
> > wrote in message <20041230035000.10@ori.thedillows.org>:
> > > +enum {
> > > +	XFRM_STATE_DIR_UNKNOWN,
> > > +	XFRM_STATE_DIR_IN,
> > > +	XFRM_STATE_DIR_OUT,
> > > +};
> >=20
> > Any specific reason to first define such a nice enum and then using int
> > in the struct?
>=20
> Just following the current style in net/xfrm.h, see xfrm_state.km.state
> and XFRM_STATE_*.

Hmmm... Maybe I'd prepare patches then :)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--5Wo9T3dGHPT+4OQz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB1C6BHb1edYOZ4bsRAraeAJ4kdi0KY9MbAavAWo1ZpQ8F7bnn3wCbBvjS
UD3Tby1J+v8hAYqL5uWkgrE=
=Vrl2
-----END PGP SIGNATURE-----

--5Wo9T3dGHPT+4OQz--
