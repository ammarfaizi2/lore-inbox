Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVAJLh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVAJLh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVAJLhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:37:51 -0500
Received: from lug-owl.de ([195.71.106.12]:17118 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262211AbVAJLhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:37:38 -0500
Date: Mon, 10 Jan 2005 12:37:36 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:468: parse error
Message-ID: <20050110113736.GE25737@lug-owl.de>
Mail-Followup-To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <1B701004057AF74FAFF851560087B1610646A3@1aurora.enabtech>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <1B701004057AF74FAFF851560087B1610646A3@1aurora.enabtech>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-01-10 16:22:52 +0500, Mudeem Iqbal <mudeem@Quartics.com>
wrote in message <1B701004057AF74FAFF851560087B1610646A3@1aurora.enabtech>:
> LD	init/built-in.o
> LD .tmp_vmlinux1
> mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:6: parse error
> make: ***[.tmp_vmlinux1] Error 1
>=20
> The vmlinux.lds generated is as follows
>=20
> 1) OUPUT_ARH(mips)
> 2) Entry(kernel_entry)
> 3) jiffies =3D jiffies_64;
> 4) SECTION
> 5) {
> 6)	. =3D ;

Should be ". =3D .;" IIRC.

> 7)	/* rea-only */
> 8)	_text =3D .; /* Text and read only data *

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

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB4mkAHb1edYOZ4bsRArh0AJ0a4UvRPe2Yx13W+ex7hWIdKpuIigCfY0Nw
rUoVAu12UHIEsVtK/PSjXZQ=
=h4cV
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
