Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTKROtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 09:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTKROtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 09:49:25 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:3221 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262792AbTKROtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 09:49:23 -0500
Date: Tue, 18 Nov 2003 15:49:21 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: michael@lug-owl.de, mw@microdata-pos.de
Subject: Re: Announce: ndiswrapper
Message-ID: <20031118144921.GE1037@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, michael@lug-owl.de,
	mw@microdata-pos.de
References: <3FBA25CD.5020708@pobox.com> <Pine.LNX.4.44.0311181510290.29639-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311181510290.29639-100000@gaia.cela.pl>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-11-18 15:14:01 +0100, Maciej Zenczykowski <maze@cela.pl>
wrote in message <Pine.LNX.4.44.0311181510290.29639-100000@gaia.cela.pl>:
> > Pontus Fuchs wrote:

> Speaking of io-trace has anyone actually done this?  I'm working on a=20

It's actually not all that simple. Some CPUs do have direct inb/outb
instructions that are not syscalls. So you either have to single-step
all the program and look at it's execution path, or you'd run it as a
notmal user and handle the privilege penetration then luser starts
inb'ing:) A coworker of me has done that with a DOS driver, doing such
IO tracing for the dosemu it was running it.

Maybe he cares to explain it in detail...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ujFxHb1edYOZ4bsRAkXzAJ9i1bk1FyQM4G/h6mlGhzzlOSzJWQCgjuFi
W96WPO+XNizdhU2GhBi6kWE=
=CfTc
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
