Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269577AbUHZUNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269577AbUHZUNs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269560AbUHZUN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:13:26 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:57567 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S269496AbUHZUEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:04:43 -0400
Date: Thu, 26 Aug 2004 22:04:33 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Mauricio R. Perez - Centro de Computos" 
	<mauricio_perez@pergamino.gov.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel argument list too long
Message-ID: <20040826200433.GS18334@lug-owl.de>
Mail-Followup-To: "Mauricio R. Perez - Centro de Computos" <mauricio_perez@pergamino.gov.ar>,
	linux-kernel@vger.kernel.org
References: <008601c48b84$d7211530$643caf0a@pergamino.gov.ar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WulRBKvtygI9tSt8"
Content-Disposition: inline
In-Reply-To: <008601c48b84$d7211530$643caf0a@pergamino.gov.ar>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WulRBKvtygI9tSt8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-08-26 12:53:33 -0300, Mauricio R. Perez - Centro de Computos <=
mauricio_perez@pergamino.gov.ar>
wrote in message <008601c48b84$d7211530$643caf0a@pergamino.gov.ar>:
> Kernel limitation of argument list it's a problem, not for things I do, e=
lse
> is for things that others do, i "need" to compile aubit4gl, but configure
> gives me Argument List Too long, and I need to have more memory for
> arguments, how can y solve this?
> kernel: 2.6.7
> gcc: 3.3.2

$ vi .../linux-2.6.x/include/linux/binfmts.h +/MAX_ARG_PAGES

However, another fix would be to limit the size of supplied arguments,
possibly by placing the source files not into a deep directory (thus
avoiding long absolute paths) etc.

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

--WulRBKvtygI9tSt8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLkJRHb1edYOZ4bsRAhVvAJ0UatRMjmB5hZikhuXESpQ5iUa8fgCfW929
Er5G1fV1PDKgK54Kmaa1Xxs=
=BADV
-----END PGP SIGNATURE-----

--WulRBKvtygI9tSt8--
