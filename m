Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUEFM4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUEFM4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUEFM4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:56:38 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:11212 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262080AbUEFM4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:56:16 -0400
Date: Thu, 6 May 2004 14:56:15 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: RE : 2.6.6-rc3-mm2 : REGPARAM forced => no external module with some object code only
Message-ID: <20040506125615.GA29503@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <4098D65D.9010107@free.fr> <20040505131809.10bdcae6.akpm@osdl.org> <20040506124454.GA12921@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SoGQxgZEULAMOcJz"
Content-Disposition: inline
In-Reply-To: <20040506124454.GA12921@babylon.d2dc.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SoGQxgZEULAMOcJz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-05-06 08:44:54 -0400, Zephaniah E. Hull <warp@babylon.d2dc.net>
wrote in message <20040506124454.GA12921@babylon.d2dc.net>:
> On Wed, May 05, 2004 at 01:18:09PM -0700, Andrew Morton wrote:
> > Eric Valette <eric.valette@free.fr> wrote:
> > >
> > > The Changelog says nothing really important but forcing REGPARAM is=
=20
> > >  rather important : it breaks any external module using object only c=
ode=20
> > >  that calls a kernel function.
> >=20
> > This is why we should remove the option - to reduce the number of ways =
in
> > which the kernel might have been built.  Yes, there will be a bit of
> > transition pain while these people catch up.

Sorry, missed the previous mail...

Well, practically, reducing options will help compatibility, *but*
personally, I don't see a problem there. Linux only claims limited
source compatibility, so I don't see much of a problem there. If binary
modules fall down to their feet, they need to catch up.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--SoGQxgZEULAMOcJz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAmjXvHb1edYOZ4bsRAunTAKCMgfrBT54D872nRILvWYkUWqM8uACeK/nd
qFAPw4xLL0g0sd7SLlMvU40=
=YZ0o
-----END PGP SIGNATURE-----

--SoGQxgZEULAMOcJz--
