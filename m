Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263476AbSIUQME>; Sat, 21 Sep 2002 12:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbSIUQME>; Sat, 21 Sep 2002 12:12:04 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:9801 "EHLO bird.iucha.org")
	by vger.kernel.org with ESMTP id <S263476AbSIUQMD>;
	Sat, 21 Sep 2002 12:12:03 -0400
Date: Sat, 21 Sep 2002 11:17:02 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <20020921161702.GA709@iucha.net>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <20020921121041.C20153@hh.idb.hist.no> <591884585.1032594816@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <591884585.1032594816@[10.10.2.3]>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2002 at 07:53:37AM -0700, Martin J. Bligh wrote:
> > X won't start on 2.5.37, but works with 2.5.36
> > The screen goes black as usual, but then nothing else happens.
> > ssh'ing in from another machine shows XFree86 using 50% cpu,
> > i.e. one of the two cpu's in this machine.
>=20
> Looks like Linus fixed this already in his BK tree ... want
> to grab that and see if it fixes your problem?

What changeset do you think fixed this?

Anyway, I grabbed ftp://nl.linux.org/pub/linux/bk2patch/tagged-to-head.v2.5=
=20
and patched it in. Same result X eating 99% cpu time.

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9jJt9NLPgdTuQ3+QRAkLkAJwK47mEfXv0TUfL+WtZYjK3arWl6gCfYCV5
8MTiU1YXlNHF0T4SGY2Luv8=
=NT9P
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
