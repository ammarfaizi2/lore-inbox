Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945948AbWBDJyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945948AbWBDJyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945994AbWBDJyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:54:16 -0500
Received: from lug-owl.de ([195.71.106.12]:22723 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1945948AbWBDJyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:54:16 -0500
Date: Sat, 4 Feb 2006 10:54:14 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
Message-ID: <20060204095414.GT18336@lug-owl.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Richard Purdie <rpurdie@rpsys.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>
References: <1138714918.6869.139.camel@localhost.localdomain> <Pine.LNX.4.61.0602011707460.22529@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wp5PKWxpqHjYm/ls"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602011707460.22529@yvahk01.tjqt.qr>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wp5PKWxpqHjYm/ls
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-02-01 17:09:06 +0100, Jan Engelhardt <jengelh@linux01.gwdg.de>=
 wrote:
> >Add an LED trigger for IDE disk activity to the IDE subsystem.
>=20
> Since I am not a real user of the led subsystem - what LED should be lit=
=20
> anyway? only the motherboard one does, and it seems to be connected=20
> directly to the IDE chip - I would want this as a compile-time option so =
I=20
> don't pay any extra time for any led stuff.

Well, look at PARISC. These machines do have a HDD LED, but it needs
to be manually driven by the I/O subsystem.

The same would be for PCMCIA-attached ATA drives, where some embedded
stuff has a HDD LED, which is GPIO-connected.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--wp5PKWxpqHjYm/ls
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD5HnGHb1edYOZ4bsRAhj0AJ997SrQhXWlWWmdjm30JoT/B1DcSACdGgUR
/Oh1JuYns3WFwQqYyzz0zKk=
=zpyU
-----END PGP SIGNATURE-----

--wp5PKWxpqHjYm/ls--
