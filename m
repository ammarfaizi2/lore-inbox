Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUFPNBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUFPNBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUFPNBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:01:02 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:3218 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266296AbUFPM7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:59:13 -0400
Date: Wed, 16 Jun 2004 14:59:10 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] atime on devices
Message-ID: <20040616125909.GY20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <riqhdtkke3i.fsf@maggie.uio.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6mNb9iemI/dmi7Z+"
Content-Disposition: inline
In-Reply-To: <riqhdtkke3i.fsf@maggie.uio.no>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6mNb9iemI/dmi7Z+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-06-09 16:20:17 +0200, Sturle Sunde <sturle.sunde@usit.uio.no>
wrote in message <riqhdtkke3i.fsf@maggie.uio.no>:
> Some software use access times on device files to check if there is
> mouse or keyboard activity on the console.  This used to work in old
> kernels, or perhaps it was old hardware, but not any more.  Google
> didn't find any other portable ways of checking for mouse or keyboard
> activity without accessing the X11 display.

open() /dev/input/evdev* and select() on them?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--6mNb9iemI/dmi7Z+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0EQdHb1edYOZ4bsRApiLAKCGmBmdJOuhE25amemWb4rpnGkpZACgk7/G
vbQQcFyasy0xcBGnpF0jqdg=
=yKc5
-----END PGP SIGNATURE-----

--6mNb9iemI/dmi7Z+--
