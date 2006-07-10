Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWGJQSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWGJQSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWGJQSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:18:22 -0400
Received: from lug-owl.de ([195.71.106.12]:12485 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S964845AbWGJQSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:18:21 -0400
Date: Mon, 10 Jul 2006 18:18:20 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] -Wshadow: Fix warnings in mconf
Message-ID: <20060710161820.GI22573@lug-owl.de>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	linux-kernel@vger.kernel.org
References: <200607101312.38149.jesper.juhl@gmail.com> <20060710155337.GB9617@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jHP/eq8oeUshSv2p"
Content-Disposition: inline
In-Reply-To: <20060710155337.GB9617@admingilde.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jHP/eq8oeUshSv2p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-10 17:53:37 +0200, Martin Waitz <tali@admingilde.org> wrote:
> On Mon, Jul 10, 2006 at 01:12:37PM +0200, Jesper Juhl wrote:
> > --- linux-2.6.18-rc1-orig/scripts/kconfig/mconf.c	2006-06-18 03:49:35.0=
00000000 +0200
> > +++ linux-2.6.18-rc1/scripts/kconfig/mconf.c	2006-07-09 19:48:05.000000=
000 +0200
> > @@ -276,7 +276,7 @@ static void conf_save(void);
> >  static void show_textbox(const char *title, const char *text, int r, i=
nt c);
> >  static void show_helptext(const char *title, const char *text);
> >  static void show_help(struct menu *menu);
> > -static void show_file(const char *filename, const char *title, int r, =
int c);
> > +static void show_file(const char *fname, const char *title, int r, int=
 c);
> > =20
> >  static void cprint_init(void);
> >  static int cprint1(const char *fmt, ...);
>=20
> perhaps its more clear if you change the global variable instead?
> perhaps to config_filename?

After all, that's just a declaration. I doubt that GCC should warn
here at all...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--jHP/eq8oeUshSv2p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEsn3LHb1edYOZ4bsRAhfxAJoDtpSvFwBW4u5QhUd12A2y3wcSUQCePdSq
NX6tU47e6wJWdtwgJT2l9ks=
=ePbb
-----END PGP SIGNATURE-----

--jHP/eq8oeUshSv2p--
