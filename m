Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272396AbTGaGWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272402AbTGaGWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:22:55 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:29145 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272396AbTGaGWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:22:54 -0400
Date: Thu, 31 Jul 2003 08:22:52 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731062252.GM1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JrJW0wW5qTeyr+Y"
Content-Disposition: inline
In-Reply-To: <20030731002230.GE22991@fs.tum.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JrJW0wW5qTeyr+Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-31 02:22:31 +0200, Adrian Bunk <bunk@fs.tum.de>
wrote in message <20030731002230.GE22991@fs.tum.de>:
> On Wed, Jul 30, 2003 at 10:33:18PM +0200, Jan-Benedict Glaw wrote:
> >...
> > That sounds a tad inelegant to me. Really, I'd prefer to see libstdc++
> > be compiled for i386 ...
> >=20
> > ...and IFF those new opcodes bring _that_ much performance, then we
> > should think about another Debian distribution for i686-linux. Up to
> > now, I was really proud of having _one_ distribution that's basically
> > capable of running on all and any machines I own...
>=20
> The 486 emlation patch for 386 is the way to still allow 386's to run=20
> Debian.

Okay, I'll have a look at it. Where's the 2.6.x version?

> To compile libstdc++ for 486 wasn't a performance question - a
> libstdc++.so.5 compiled for 386 would have meant that C++ binaries
> compiled on Debian wouldn't run on other Linux distributions and vice
> versa [1] (it's a bug in libstdc++ that will AFAIR be fixed in gcc 3.4).

I've got no idea when this version will come up. What's the (Debian)
timeline for a gcc-3.4 based libstdc++ then? I've already tried
gcc-snapshot's libstdc++, but that's libstdc++6, which won't link with
todays applications...

Well, it's not only that. Seen the thread named like "Time loss on
i486"? That'll be some fun, too:)

Itching my head, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--7JrJW0wW5qTeyr+Y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KLW8Hb1edYOZ4bsRAudzAJ43QZd2E9WkmjU1q7czgaKsol5NRgCeIS/f
XLCyewf2awh7gLFFp0Tq2PY=
=8XrL
-----END PGP SIGNATURE-----

--7JrJW0wW5qTeyr+Y--
