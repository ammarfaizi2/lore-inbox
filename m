Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTJUIWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 04:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbTJUIWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 04:22:30 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:38092 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263017AbTJUIW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 04:22:28 -0400
Date: Tue, 21 Oct 2003 10:22:26 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20031021082225.GA20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031015225055.GS17986@fs.tum.de> <20031015161251.7de440ab.akpm@osdl.org> <20031015232440.GU17986@fs.tum.de> <20031015165205.0cc40606.akpm@osdl.org> <20031018102127.GE12423@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pr5L7F0YSlsy7gwk"
Content-Disposition: inline
In-Reply-To: <20031018102127.GE12423@fs.tum.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pr5L7F0YSlsy7gwk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-10-18 12:21:27 +0200, Adrian Bunk <bunk@fs.tum.de>
wrote in message <20031018102127.GE12423@fs.tum.de>:
> On Wed, Oct 15, 2003 at 04:52:05PM -0700, Andrew Morton wrote:
> > I really doubt it.  Kernel CPU footprint is dominated by dcache misses.=
  If
> > -Os reduces icache footprint it may even be a net win; people tend to
> > benchmark things in tight loops, which favours fast code over small cod=
e.
>=20
> The main effect of -Os compared to -O2 (besides disabling some
> reordering of the code and prefetching) is the disabling of various
> alignments. I doubt that's a win on all CPUs.

I definively *like* to see -Os be configureable by user. It's *big* win
for a lowmem system. There, the actual "running speed" may be limited by
HDD swap speed, and having a smaller kernel means having more pages left
to luserspace...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--pr5L7F0YSlsy7gwk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lOzBHb1edYOZ4bsRAhSVAJ0dvhtjPMIuxzd58bOGur9PYZ43ywCeKTUd
K3C2rUAtqm2U72uYGOc0qr0=
=A/7S
-----END PGP SIGNATURE-----

--pr5L7F0YSlsy7gwk--
