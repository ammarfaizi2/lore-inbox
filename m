Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTF2KbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 06:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbTF2KbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 06:31:09 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:49170 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265624AbTF2KbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 06:31:04 -0400
Date: Sun, 29 Jun 2003 12:45:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
Message-ID: <20030629104521.GD29233@lug-owl.de>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	axboe@suse.de, linux-kernel@vger.kernel.org
References: <20030629081447.GC29233@lug-owl.de> <Pine.LNX.4.10.10306290229280.2711-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xzd0sUmZITcBHKTf"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10306290229280.2711-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Xzd0sUmZITcBHKTf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-06-29 02:30:29 -0700, Andre Hedrick <andre@linux-ide.org>
wrote in message <Pine.LNX.4.10.10306290229280.2711-100000@master.linux-ide=
.org>:
>=20
> You missed a point.
>=20
> Defaulting to off means stablity for the masses.
> Enduser enable is for testing to get it correct.
> Regardless, it was my $0.02 for the thread.

No, I didn't. We're in 2.5.x timeline and doing early testing (esp. with
"exotic" or rarely used features) is IMHO best done at early times. THis
is why I did it. For now, I don't exactly care for pure stability _if_ a
user can easily choose really dangerous code, esp. if it's advised as
experimental, but "you should say yes" in it's help text. This is, I
like to compile with many features to see where it breaks.

Not doing this means to walk through a mines field later, at 2.6.x
times. That is playing minesweeper with some poor end user. No good...

MfG, JBG
Btw., that patch got merged to Linus and I'm currently running
2.5.73-bk6 with TF and TCQ enabled (in config, but gets somewhat
disabled because of missing hardware of too many drives per channel) on
a laptop and my (quite a bit loaded) mirror box. No problems /
corruption so far:)

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--Xzd0sUmZITcBHKTf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/sNAHb1edYOZ4bsRAmc4AJ4wnlHK/mEW/hNWf4BB1grfN2Im/wCdFGUm
S1YZERhDflLaY1PGYxcRtJk=
=mE7t
-----END PGP SIGNATURE-----

--Xzd0sUmZITcBHKTf--
