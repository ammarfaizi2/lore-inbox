Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262398AbSIUSye>; Sat, 21 Sep 2002 14:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSIUSye>; Sat, 21 Sep 2002 14:54:34 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:23638 "EHLO
	bird.iucha.org") by vger.kernel.org with ESMTP id <S262398AbSIUSyd>;
	Sat, 21 Sep 2002 14:54:33 -0400
Date: Sat, 21 Sep 2002 13:59:39 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <20020921185939.GA1771@iucha.net>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <20020921161702.GA709@iucha.net> <597384533.1032600316@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <597384533.1032600316@[10.10.2.3]>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2002 at 09:25:18AM -0700, Martin J. Bligh wrote:
> >> > X won't start on 2.5.37, but works with 2.5.36
> >> > The screen goes black as usual, but then nothing else happens.
> >> > ssh'ing in from another machine shows XFree86 using 50% cpu,
> >> > i.e. one of the two cpu's in this machine.
> >>=20
> >> Looks like Linus fixed this already in his BK tree ... want
> >> to grab that and see if it fixes your problem?
> >=20
> > What changeset do you think fixed this?
>=20
> Well, this bit looked hopeful:
>=20
> 23 hours torvalds 1.575 Fix vm86 system call interface to entry.S.=20
> This has been broken since the thread_info support went in (early July),=
=20
> and can cause lockups at X startup etc.=20

X is not locked up, as it eats all the CPU. And 2.5.36 works just fine.

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9jMGaNLPgdTuQ3+QRAsTiAJ9n1zkllylmGbre/qYInLI4K9hcGgCbBY5S
2e5tlSc2+QGuBJ8JNKXUa94=
=FiJs
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
