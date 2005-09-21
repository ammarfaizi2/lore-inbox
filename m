Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVIUOJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVIUOJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVIUOJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:09:13 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:29456 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1750963AbVIUOJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:09:12 -0400
Date: Wed, 21 Sep 2005 16:08:57 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: spurious mouse clicks
Message-ID: <20050921140857.GA17224@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <433164F4.40205@concannon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <433164F4.40205@concannon.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2005 at 09:49:40AM -0400, Michael Concannon wrote:
> I thought it was my imagination at first, but now I have some slightly=20
> more convincing evidence of what is going on...
>=20
> With 2.6.13.1 & 2 as I move my mouse around the screen, I get random=20
> clicks on things the mouse passes.  Seems to happen more often with the=
=20
> first move from idle, but in general, it is just totally random...
>=20
> With 2.6.9-11.EL and 2.6.12.6 (stock kernel.org) I do NOT get this.
>=20
> Anyone else seeing this?

 Do you have lines like:

psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throw=
ing 1 bytes away.

 in your dmesg?

--=20
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na =BFycie maj=B1 tu patenty spe=
cjalne.


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDMWl5ThhlKowQALQRAobdAJ9kJPxIlDo0x2hbAQFoztMFq/VSdgCg9tD3
O+X/ZiGoxzZv62VT6w/2ZgI=
=KH+8
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
