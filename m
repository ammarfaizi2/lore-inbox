Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752220AbWCCJ1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbWCCJ1L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbWCCJ1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:27:11 -0500
Received: from lug-owl.de ([195.71.106.12]:3268 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1752220AbWCCJ1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:27:10 -0500
Date: Fri, 3 Mar 2006 10:27:07 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060303092706.GJ19232@lug-owl.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20060301175852.GA4708@stusta.de> <E1FEcfG-000486-00@gondolin.me.apana.org.au> <20060302173840.GB9295@stusta.de> <20060302195106.GC19232@lug-owl.de> <20060302203922.GE9295@stusta.de> <20060302205105.GF19232@lug-owl.de> <20060302212805.GG9295@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxmMT58/z/5uKrU0"
Content-Disposition: inline
In-Reply-To: <20060302212805.GG9295@stusta.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxmMT58/z/5uKrU0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-02 22:28:05 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Mar 02, 2006 at 09:51:06PM +0100, Jan-Benedict Glaw wrote:
> > You may want to have a chance to load modules from an initrd with is
> > on a 2nd floppy.
>=20
> In these cases, CONFIG_UNIX shouldn't make the difference between the=20
> kernel fitting on the first floppy and the kernel not fitting on the=20
> first floppy.

Heh. By Linus' Law, kernel footprint grows. To get a nice useable
floppy disk, you may need to do *quite* some jumps to make it fit.

In the worst case I had, I even started to throw out some of the
device ID tables (unneeded entries), killed printk() by defining a
no-op for it etc. to save some *bytes*. Yes, it's a nice dance:-)

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

--mxmMT58/z/5uKrU0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFECAvqHb1edYOZ4bsRAmqlAJ0apQK8i8I/Jpyh1TbwJqw0Ar5IRQCeNFPp
IhZ40fHsxzYC3jaHzUbqBPg=
=+TUO
-----END PGP SIGNATURE-----

--mxmMT58/z/5uKrU0--
