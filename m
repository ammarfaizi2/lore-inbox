Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272238AbTG3U1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272242AbTG3U1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:27:47 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:25021 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272238AbTG3U1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:27:45 -0400
Date: Wed, 30 Jul 2003 22:27:44 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030730202744.GF1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S0QU+l03nqHlODqK"
Content-Disposition: inline
In-Reply-To: <20030730181006.GB21734@fs.tum.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--S0QU+l03nqHlODqK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-07-30 20:10:06 +0200, Adrian Bunk <bunk@fs.tum.de>
wrote in message <20030730181006.GB21734@fs.tum.de>:
> On Wed, Jul 30, 2003 at 03:56:23PM +0200, Jan-Benedict Glaw wrote:
> >...
> > Please apply. Worst to say, even Debian seems to start using i486+
> > features (ie. libstdc++5 is SIGILLed on Am386 because there's no
> > "lock" insn available)...
>=20
> Shouldn't the 486 emulation in the latest 386 kernel images in Debian
> unstable take care of this?

Specifically patched kernel? Sounds lame to me...

Generic solution would be to have a generic implementation, IMHO.
Up to now, I've nowhere found some hard facts that the new opcodes do
measureable speed up things. Sure, saving some hundreds/thousands/...
CPU cycles is nice - but not, if that's only 0.1% of the whole number of
CPU cycles burned in a run. That doesn't, IMHO, really legitimate do
unsupport the i386.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--S0QU+l03nqHlODqK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KCpAHb1edYOZ4bsRAs61AJ9lNu2Dn/vMClKte3W4ujHq2ARaTwCePkD2
QFGcF9E2miGGpLLHxdQ+zKg=
=CqH/
-----END PGP SIGNATURE-----

--S0QU+l03nqHlODqK--
