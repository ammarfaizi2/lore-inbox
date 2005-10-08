Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVJHOaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVJHOaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 10:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVJHOaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 10:30:17 -0400
Received: from lug-owl.de ([195.71.106.12]:33733 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932140AbVJHOaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 10:30:16 -0400
Date: Sat, 8 Oct 2005 16:30:14 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: [2.6] binfmt_elf bug (exposed by klibc).
Message-ID: <20051008143014.GX14750@lug-owl.de>
Mail-Followup-To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
References: <200510071533.j97FX9Wp018589@laptop11.inf.utfsm.cl> <200510072320.18263.pluto@agmk.net> <Pine.LNX.4.61.0510071740040.13291@chaos.analogic.com> <200510080042.58408.pluto@agmk.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c1qHkdEbEbCG94PZ"
Content-Disposition: inline
In-Reply-To: <200510080042.58408.pluto@agmk.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--c1qHkdEbEbCG94PZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-10-08 00:42:58 +0200, Pawe=C5=82 Sikora <pluto@agmk.net> wrote:
> > Did somebody accidentally=20
> > screw up some kernel code between 2.6.13 and 2.6.14?
>=20
> I think kernel elf loader doesn't handle binaries without .bss.
> Earlier binutils (<2.16) emits zero-sized .data/.bss and problem
> wasn't exposed. Modern binutils doesn't emit useless zero-sized
> .data/.bss sections and kernel kills these binaries.

I had this problem at some time, too. This was when I started to redo
the uClibc port to vax-linux, which I started with a hand-crafted
assembly file. It also crashed upon execution, though I was sure the
program was technically okay.

However, I haven't looked up any paper or standard to verify either
position. So I don't know for *sure* if it's legal to omit these
(empty) sections.

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

--c1qHkdEbEbCG94PZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDR9f2Hb1edYOZ4bsRAgwlAJ4zqiFNcUVLDHi2Yh13mpuBlPt9NgCeMIGj
es7JxMNwwx/OtadZbb2u334=
=WVBj
-----END PGP SIGNATURE-----

--c1qHkdEbEbCG94PZ--
