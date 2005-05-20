Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVETHKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVETHKO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 03:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVETHKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 03:10:14 -0400
Received: from lug-owl.de ([195.71.106.12]:2959 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261370AbVETHKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 03:10:00 -0400
Date: Fri, 20 May 2005 09:09:59 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: zhonglei <zhonglei@RCS-9000.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module mismatch
Message-ID: <20050520070959.GS2417@lug-owl.de>
Mail-Followup-To: zhonglei <zhonglei@RCS-9000.COM>,
	linux-kernel@vger.kernel.org
References: <200505201127.AA8126754@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sBcizk6cgRZY6rnJ"
Content-Disposition: inline
In-Reply-To: <200505201127.AA8126754@RCS-9000.COM>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sBcizk6cgRZY6rnJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-05-20 11:27:14 +0800, zhonglei <zhonglei@RCS-9000.COM> wrote:
> when I use "insmod -f hello.o" in my Embeded linux,the warning appears:
> Warning: Kernel-module version mismatch
>          hello.o was compiled for kernel version 2.4.24-per2
>          while this kernel is version 2.4.25
> Warning: loading hello.o will taint the kernel: forced load
>    see http://www.tux.org/lkml/#export-tainted for information about tain=
ted modules
>=20
> Is there any problem on my using my module function with this warning?

Yes, there is. Your running kernel differs from that one which you
compiled the module sources with. Linux' internal interfaces and data
structures change every now and then, which will result in different
offsets, wrong functions called and the like. You'd *always* compile a
module exactly with the same sources, compiler and .config file to match
the kernel to which you want to load the module.

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

--sBcizk6cgRZY6rnJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCjY1HHb1edYOZ4bsRAnNLAJ0cdl05kXXaw0WpoHH2MycZ/7p9iQCfTh3w
nM3Xb0Q92D2cgKSULjZJFoU=
=R4je
-----END PGP SIGNATURE-----

--sBcizk6cgRZY6rnJ--
