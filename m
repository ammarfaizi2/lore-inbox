Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268147AbTBSI5n>; Wed, 19 Feb 2003 03:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268159AbTBSI5n>; Wed, 19 Feb 2003 03:57:43 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:12296 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S268147AbTBSI5l>;
	Wed, 19 Feb 2003 03:57:41 -0500
Date: Wed, 19 Feb 2003 10:07:43 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] morse code panics for 2.5.62
Message-ID: <20030219090743.GK351@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030218135038.GA1048@louise.pinerecords.com> <20030218141757.GV351@lug-owl.de> <b2tl9c$48c$1@main.gmane.org> <20030218171247.GA351@lug-owl.de> <20030218224946.GB1048@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LHVJ3yhMbk/VQvI5"
Content-Disposition: inline
In-Reply-To: <20030218224946.GB1048@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LHVJ3yhMbk/VQvI5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-02-18 23:49:46 +0100, Tomas Szepe <szepe@pinerecords.com>
wrote in message <20030218224946.GB1048@louise.pinerecords.com>:
> > [jbglaw@lug-owl.de]
> >=20
> > Then, you can have
> > const char morses[] =3D {
> > 	MORSE2('A', '.', '-'),
> > 	MORSE4('B', '-', '.', '.', '.'),
> > 	MORSE4('C', '-', '.', '-', '.'),
> > 	MORSE3('D', '-', '.', '.'),
> > 	MORSE1('E', '.'),
> > 	MORSE4('F', '.', '.', '-', '.')
> > 	...
> > };
> >=20
> > That's going to take exactly the same memory in the compiled vmlinux
> > image, *and* it's really readable:-) Of course, gcc will optimize any
> > added "bloat" away...
>=20
> Looks good to me, can you send an updated patch?

Okay, I'll first have to import your original patch:-) and have a real
look at it (how does it exactly store the data...). Then, I'll do an
undated patch. Please give me an hour ot two...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--LHVJ3yhMbk/VQvI5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+U0lfHb1edYOZ4bsRAhtBAJ9Y5yxkSGgkpC/kO+vw5FaNuDpoqwCfdW3F
TrSGP4F2NXm/X7cJhTUMFHg=
=cP+m
-----END PGP SIGNATURE-----

--LHVJ3yhMbk/VQvI5--
