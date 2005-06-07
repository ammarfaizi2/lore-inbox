Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVFGP3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVFGP3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVFGP1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:27:49 -0400
Received: from lug-owl.de ([195.71.106.12]:21964 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261258AbVFGPGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 11:06:40 -0400
Date: Tue, 7 Jun 2005 17:06:39 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: ericvh@gmail.com
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] v9fs: debug and support routines (2.0)
Message-ID: <20050607150638.GD19479@lug-owl.de>
Mail-Followup-To: ericvh@gmail.com, linux-kernel@vger.kernel.org,
	v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
References: <200506071450.j57EoDe1010866@ms-smtp-02-eri0.texas.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hX3v94LCWtOgt2h1"
Content-Disposition: inline
In-Reply-To: <200506071450.j57EoDe1010866@ms-smtp-02-eri0.texas.rr.com>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hX3v94LCWtOgt2h1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-07 09:49:51 -0500, ericvh@gmail.com <ericvh@gmail.com> wrot=
e:
> +++ b/fs/9p/error.h

If you really need to use this struct, ...

> +/* FixMe - reduce to a reasonable size */
> +static struct errormap errmap[] =3D {
> +	{"Operation not permitted", 1},
> +	{"wstat prohibited", 1},
> +	{"No such file or directory", 2},
> +	{"file not found", 2},
> +	{"Interrupted system call", 4},
> +	{"Input/output error", 5},

=2E..then please use the E macros of errno.h and not these numeric
constants. errno values may vary between ports.

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

--hX3v94LCWtOgt2h1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCpbf+Hb1edYOZ4bsRAgrkAJ96RW8AwkEgGuUODycFIgpqkQd83gCdG1uv
FSqDP7HCoeINC50PQO6tslI=
=Clkf
-----END PGP SIGNATURE-----

--hX3v94LCWtOgt2h1--
