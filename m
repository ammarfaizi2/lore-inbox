Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTKXOGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 09:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTKXOGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 09:06:31 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:40095 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263496AbTKXOG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 09:06:29 -0500
Date: Mon, 24 Nov 2003 15:06:28 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Force Coredump
Message-ID: <20031124140627.GY1037@lug-owl.de>
Mail-Followup-To: Kernel List <linux-kernel@vger.kernel.org>
References: <001001c3b28d$183400e0$34dfa7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0pIkpSOnWZeoIsda"
Content-Disposition: inline
In-Reply-To: <001001c3b28d$183400e0$34dfa7c8@bsb.virtua.com.br>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0pIkpSOnWZeoIsda
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-11-24 11:15:51 -0200, Breno <brenosp@brasilsec.com.br>
wrote in message <001001c3b28d$183400e0$34dfa7c8@bsb.virtua.com.br>:
> Hi all,
>=20
> I need force a coredump file. So i tryed :
>=20
> int *i =3D 0;
> if(*i)
> exit(1);
>=20
> tryed to kill -11 'pid'
> ...
> but i just received a seg. fault message, and doesn=B4t  create coredump =
file.

That's correct - "kill -l" lists signal no. 11 as SIGSEGV. Most
probably, you'd try SIGABRT which is ment for this purpose. But
remember, you'll need write permissions on the directory as well as a
matching ulimit.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--0pIkpSOnWZeoIsda
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/whBjHb1edYOZ4bsRAoMNAJ9j4sXM8p65TQGct3GDh4pKBWM9bQCbBY31
MOKT3pDL+15+do6BSphcmVE=
=JhiS
-----END PGP SIGNATURE-----

--0pIkpSOnWZeoIsda--
