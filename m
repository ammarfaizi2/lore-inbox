Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVGSOiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVGSOiB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 10:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVGSOiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 10:38:01 -0400
Received: from lug-owl.de ([195.71.106.12]:28288 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261856AbVGSOhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 10:37:32 -0400
Date: Tue, 19 Jul 2005 16:37:31 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: function to zero out module ref count so module can be unloaded in 2.6 kernel?
Message-ID: <20050719143731.GD20065@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <5f83f60f05071907313ad3b186@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <5f83f60f05071907313ad3b186@mail.gmail.com>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-07-19 20:01:10 +0530, Vivek Dasgupta <vivek.dasgupta@gmail.com=
> wrote:
> In 2.4 kernel one could check MOD_IN_USE and repeatedly call
> MOD_DEC_USE_COUNT until the ref count drops to zero.
>=20
> Is there a function in 2.6 kernel that would zero out the ref count so
> that module can be unloaded ?

*plonk*

Have you ever thought about a non-zero usage count? Maybe there actually
*are* still some users so unloading the module may crash the entire
system?! So don't kick-out your security gear, but dig out the real bugs
which seem to manifest in execssive users at your side...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
fuer einen Freien Staat voll Freier Buerger" | im Internet! |   im Irak!   =
O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC3RArHb1edYOZ4bsRAksxAJ9pCbFR2kCERmCNblwCjfmfaZuEtQCePWQp
OduAo4Z0AAcsRDYF5oh22hM=
=3GPe
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
