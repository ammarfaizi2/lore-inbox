Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263180AbUJ2Jw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbUJ2Jw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbUJ2Jw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:52:29 -0400
Received: from lug-owl.de ([195.71.106.12]:18591 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S263180AbUJ2JwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:52:15 -0400
Date: Fri, 29 Oct 2004 11:52:14 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: Re: i386: use generic support for offsets.h
Message-ID: <20041029095214.GM11105@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028190221.GD9004@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ll0BBk1HBk/f94B0"
Content-Disposition: inline
In-Reply-To: <20041028190221.GD9004@mars.ravnborg.org>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ll0BBk1HBk/f94B0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-10-28 21:02:21 +0200, Sam Ravnborg <sam@ravnborg.org>
wrote in message <20041028190221.GD9004@mars.ravnborg.org>:
> diff -Nru a/include/asm-i386/offsets.c b/include/asm-i386/offsets.c
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/include/asm-i386/offsets.c	2004-10-28 20:47:38 +02:00
> @@ -0,0 +1,66 @@

To be honest, I don't really like to have .c files in the include
pathes... However, I don't know about a better idea (except maybe to
place this into ./linux/arch/$(ARCH)/lib/)...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Ll0BBk1HBk/f94B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBghLOHb1edYOZ4bsRApG6AJsH6jv0QUxRnrhuBhZtZeRpcPfPSwCfevBp
eY+hct9FVgHBcjXtd3pPxjQ=
=MjcJ
-----END PGP SIGNATURE-----

--Ll0BBk1HBk/f94B0--
