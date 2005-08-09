Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbVHIP63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVHIP63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVHIP63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:58:29 -0400
Received: from lug-owl.de ([195.71.106.12]:15062 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S964836AbVHIP62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:58:28 -0400
Date: Tue, 9 Aug 2005 17:58:27 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] DLM must depend on IPV6 || IPV6=n
Message-ID: <20050809155827.GD17488@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050809155001.GZ4006@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <20050809155001.GZ4006@stusta.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-09 17:50:01 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> This patch fixes the following compile error with CONFIG_DLM=3Dy and=20
> CONFIG_IPV6=3Dm:

[...]

> --- linux-2.6.13-rc3-mm3-modular/drivers/dlm/Kconfig.old	2005-07-30 14:07=
:12.000000000 +0200
> +++ linux-2.6.13-rc3-mm3-modular/drivers/dlm/Kconfig	2005-07-30 14:07:41.=
000000000 +0200
> @@ -3,6 +3,7 @@
> =20
>  config DLM
>  	tristate "Distributed Lock Manager (DLM)"
> +	depends on IPV6 || IPV6=3Dn
>  	select IP_SCTP
>  	help
>  	A general purpose distributed lock manager for kernel or userspace

Why don't you allow modular builds of both? ...or aren't the IPv6
symbols exported?

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

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC+NKjHb1edYOZ4bsRAsNkAJ9PKxGtpORjF9Nat77bWptPm8JLzgCfc+di
ovWulggbRe4rhspF4wK+Uc8=
=QRud
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
