Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUFSW4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUFSW4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 18:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUFSW4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 18:56:34 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:42373 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264750AbUFSW4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 18:56:31 -0400
Date: Sun, 20 Jun 2004 00:56:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040619225630.GE20632@lug-owl.de>
Mail-Followup-To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1087675920.9831.941.camel@cube>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9OqnULxbSMQfV0WE"
Content-Disposition: inline
In-Reply-To: <1087675920.9831.941.camel@cube>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9OqnULxbSMQfV0WE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-19 16:12:00 -0400, Albert Cahalan <albert@users.sf.net>
wrote in message <1087675920.9831.941.camel@cube>:
> David Woodhouse writes:
> > Please don't do that -- it makes printing UTF-8 impossible.
> > While I'd not argue that now is the time to start outputting
> > UTF-8 all over the place, I wouldn't accept that it's a good
> > time to _prevent_ it either, as your patch would do.
> >
> > If you want to post-process printk output, don't do it in the kernel.=
=20
>=20
> It is dangerous to let the 0x9b character go out
> to a serial console. It means the same as ESC [ does
> when you have a normal 8-bit terminal.

Get real: either you *want* to get those codes interpreted (think about
full-blown ncurses apps being run over serial link), or you *don't* (think
about simply recording serial console's output). You just have to choose
the correct application for your task.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--9OqnULxbSMQfV0WE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1MSeHb1edYOZ4bsRAnSTAJ43s9Q2uMyT/m9ExtgjXrHtOHQCeQCfX8c9
5xCesIVdCcdC8gYalwOoki0=
=J5NN
-----END PGP SIGNATURE-----

--9OqnULxbSMQfV0WE--
