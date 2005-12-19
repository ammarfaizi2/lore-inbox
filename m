Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbVLSHUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbVLSHUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 02:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVLSHUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 02:20:04 -0500
Received: from lug-owl.de ([195.71.106.12]:56812 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030281AbVLSHUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 02:20:03 -0500
Date: Mon, 19 Dec 2005 08:19:59 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Linda Walsh <lkml@tlinx.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as non-root
Message-ID: <20051219071959.GJ13985@lug-owl.de>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linda Walsh <lkml@tlinx.org>
References: <43A5F058.1060102@tlinx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HpDjbfe7vL9q4QWh"
Content-Disposition: inline
In-Reply-To: <43A5F058.1060102@tlinx.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HpDjbfe7vL9q4QWh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-12-18 15:27:20 -0800, Linda Walsh <lkml@tlinx.org> wrote:
> Unpacked 2.6.13.3 and made it read-only.

> I noted new targets:
>    binrpm-pkg [& rpm-pkg], and
>    tarbz2-pkg [& targz-pkg, & tar-pkg].
>=20
> Both seem to fail either for reasons that appear to be related to
> not honoring the "O=3D" param, or attempting to actually install into
> the root of my build-machine.

I've not really used out-of-tree building for Linux, so the tar*
targets are probably not really tested with that regard. Though I'll
check that and see if it works (of if a patch is needed.)

The RPM targets have to be tested by somebody else :)

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

--HpDjbfe7vL9q4QWh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDpl8fHb1edYOZ4bsRAlSWAJ9aBcoT122sKRvysur/b2kjJK+i4QCfWh3I
iS2gUZVrDFeTIbarAfnqaow=
=GkXH
-----END PGP SIGNATURE-----

--HpDjbfe7vL9q4QWh--
