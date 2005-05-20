Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVETOOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVETOOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 10:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVETOOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 10:14:44 -0400
Received: from lug-owl.de ([195.71.106.12]:6031 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261429AbVETOOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 10:14:38 -0400
Date: Fri, 20 May 2005 16:14:35 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
Message-ID: <20050520141434.GZ2417@lug-owl.de>
Mail-Followup-To: "Richard B. Johnson" <linux-os@analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOEfHYdX8LquYLAx"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qOEfHYdX8LquYLAx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-05-20 09:48:35 -0400, Richard B. Johnson <linux-os@analogic.co=
m> wrote:
>     len =3D getpagesize();
>     if((fd =3D open("/dev/mem", O_RDWR)) =3D=3D FAIL)
>         ERRORS("open");
>     if((sp =3D mmap((void *)SCREEN, len, PROT, TYPE, fd, SCREEN))=3D=3DMA=
P_FAILED)
>         ERRORS("mmap");

Maybe you'd better not fiddle with physical memory, but use the device
abstraction that's ment to offer that interface? That is, use a
framebuffer driver and open /dev/fb* .

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

--qOEfHYdX8LquYLAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCjfDKHb1edYOZ4bsRAlzHAJ9p2OgVNJnXxCDFfK3ffdS42NbqewCfdX1M
fei0Z8AG86nB5LqXirF5ccU=
=IN7e
-----END PGP SIGNATURE-----

--qOEfHYdX8LquYLAx--
