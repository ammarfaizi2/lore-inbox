Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbTIDP0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265092AbTIDP0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:26:13 -0400
Received: from [24.241.190.29] ([24.241.190.29]:23477 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S265090AbTIDP0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:26:01 -0400
Date: Thu, 4 Sep 2003 11:25:55 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nmi errors?
Message-ID: <20030904152555.GH7353@rdlg.net>
Mail-Followup-To: Martin Schlemmer <azarah@gentoo.org>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030903212038.GQ7353@rdlg.net> <Pine.LNX.4.53.0309031724470.362@chaos> <20030903213417.GT7353@rdlg.net> <1062688292.16818.148.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z3PcgjD2qOzdkXVS"
Content-Disposition: inline
In-Reply-To: <1062688292.16818.148.camel@workshop.saharacpt.lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z3PcgjD2qOzdkXVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I ran some tests Richard gave me which said it wasn't bad ram but a bad
motherboard.  I just upgraded to 2.4.22-bk10 and it ran MUCH better,
able to use all 16Gigs happily for quite some time until a couple of the
processes started finishing then it gave the NMI's en mass, guess it
couldn't shove them off to the log server in time.

I'll try the below just to make sure but this is getting odd.


Thus spake Martin Schlemmer (azarah@gentoo.org):

> On Wed, 2003-09-03 at 23:34, Robert L. Harris wrote:
> > We ran "memtest" on the machine over the weekend and it completed 3
> > times without any problems.  Know a better or different test?
> >=20
>=20
> You might try to enable all the tests, addresses and set the
> cache to be always on in memtest.  Typical keys pressed is:
>=20
>   c - 1 - 2 - 2 - 3 - 3 - 3
>=20
> Another is goldmemory, which is fairly the same in default setup
> as memtest with above config, but shareware, not gpl.
>=20
> >=20
> > Thus spake Richard B. Johnson (root@chaos.analogic.com):
> >=20
> > > On Wed, 3 Sep 2003, Robert L. Harris wrote:
> > >=20
> > > >
> > > >
> > > > Can anyone tell me what this is?
> > > >
> > > > 16:00:09 mailserver kernel: Uhhuh. NMI received for unknown reason =
31.
> > > > 16:00:09 mailserver kernel: Dazed and confused, but trying to conti=
nue
> > > > 16:00:09 mailserver kernel: Do you have a strange power saving mode=
 enabled?
> > > > 16:00:34 mailserver kernel: Uhhuh. NMI received for unknown reason =
21.
> > > > 16:00:34 mailserver kernel: Dazed and confused, but trying to conti=
nue
> > > >
> > > > A coworker put a script on a server which loads up quite afew arrays
> > > > with pre-set values and then compares the values against arrays.  A=
s soon as he
> > > > kicked off the script I got alot of these in my log files.  Not muc=
h longer and the
> > > > machine crashed hard.
> > > >
> > >=20
> > > Possible bad RAM.
> > >=20
> > > Cheers,
> > > Dick Johnson
> > > Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
> > >             Note 96.31% of all statistics are fiction.
> > >=20
> >=20
> > :wq!
> > -----------------------------------------------------------------------=
----
> > Robert L. Harris                     | GPG Key ID: E344DA3B
> >                                          @ x-hkp://pgp.mit.edu
> > DISCLAIMER:
> >       These are MY OPINIONS ALONE.  I speak for no-one else.
> >=20
> > Life is not a destination, it's a journey.
> >   Microsoft produces 15 car pileups on the highway.
> >     Don't stop traffic to stand and gawk at the tragedy.
> --=20
> Martin Schlemmer
>=20

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--z3PcgjD2qOzdkXVS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/V1mD8+1vMONE2jsRArAuAJ9AqfadCgQZVCqk+4djWUQ6M7WZ1ACg2gFH
4xWirErt+xG0k7vekujKlqI=
=/d47
-----END PGP SIGNATURE-----

--z3PcgjD2qOzdkXVS--
