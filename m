Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUFVPUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUFVPUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUFVPTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:19:10 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:37312 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264884AbUFVPMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:12:37 -0400
Date: Tue, 22 Jun 2004 17:12:36 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040622151236.GE20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>
References: <A095D7F069C@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9O7m5yaDlOd0pYEm"
Content-Disposition: inline
In-Reply-To: <A095D7F069C@vcnet.vc.cvut.cz>
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9O7m5yaDlOd0pYEm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-22 16:38:15 +0200, Petr Vandrovec <VANDROVE@vc.cvut.cz>
wrote in message <A095D7F069C@vcnet.vc.cvut.cz>:
> On 22 Jun 04 at 4:06, Andrea Arcangeli wrote:

> FYI, vmware modules broke during your change because 2.4.20-xx kernels fr=
om=20
> RedHat moved page_count() from linux/mm.h to linux/mm_inline.h, and made=
=20
> it unavailable for non-GPL modules. So we had to do
>=20
> #ifndef page_count
> #define page_count(p) (p)->count
> #endif
>=20
> and this #ifndef test was broken by making page_count inline function.

Just merge the vmware modules upstream. Then, such breakage will be
detected early and probably fixed without putting a lot of work into it
(from your point of view).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--9O7m5yaDlOd0pYEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2ExkHb1edYOZ4bsRAsMcAKCJzeNGtcFkq+sv/6oR7QsFFFvfRQCfQp74
j8QtSFfDi9jjy5RQvD5tNP8=
=KiS8
-----END PGP SIGNATURE-----

--9O7m5yaDlOd0pYEm--
