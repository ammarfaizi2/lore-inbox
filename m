Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbTFYSIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTFYSIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:08:12 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:23822 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264912AbTFYSIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:08:04 -0400
Date: Wed, 25 Jun 2003 20:22:12 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: SOLVED - Testing IDE-TCQ and Taskfile - doesn't work nicely:)
Message-ID: <20030625182210.GI29233@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20030624224021.GJ6353@lug-owl.de> <Pine.SOL.4.30.0306250107180.17106-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306250107180.17106-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-06-25 01:08:13 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiew=
icz@elka.pw.edu.pl>
wrote in message <Pine.SOL.4.30.0306250107180.17106-100000@mion.elka.pw.edu=
.pl>:
> On Wed, 25 Jun 2003, Jan-Benedict Glaw wrote:
> > On Tue, 2003-06-24 15:44:36 +0200, Bartlomiej Zolnierkiewicz <B.Zolnier=
kiewicz@elka.pw.edu.pl>
> > wrote in message <Pine.SOL.4.30.0306241543050.23584-100000@mion.elka.pw=
.edu.pl>:
> >
> > > Corrected patch below...
> >
> > Taking this 2nd IDE patch, my boot-up looks as shown below. I still have
>=20
> Thanks for testing, it looks okay now.
>=20
> > to test the taskfile thing again, but I cannot find my girlfriends
> > digital camera right now:)

Found the cam, downloaded any old pics, recompiled with taskfile I/O and
- nothing. 2.5.73 + your second IDE patch do work flawlessly on my old
box. The "clack     clack    clack" went away is if had never been
there...

So - thanks a lot for looking at my problem. Please feed your patch to
Linus as it seems to actually solve (at least my) problems.

However, allow me to ask why this occured never bevore (for other
people)? Do they all have only one drive? Does nobody use TCQ? Nobody
with old hardware (though, your patch hasn't touched the core PIIX
parts...)?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++ehRHb1edYOZ4bsRAs1KAJ9f3MaKtt2J8FoYfezw+MINeCLWuQCfQUfo
yn20ZbiNP1YkHND13HQhPW0=
=CZm4
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--
