Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTEST3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbTEST3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:29:24 -0400
Received: from cpt-dial-196-30-180-143.mweb.co.za ([196.30.180.143]:54912 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262657AbTEST3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:29:17 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Arjan van de Ven <arjanv@redhat.com>
Cc: David Ford <david+cert@blue-labs.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030519183424.E7061@devserv.devel.redhat.com>
References: <1053289316.10127.41.camel@nosferatu.lan>
	 <20030518204956.GB8978@holomorphy.com>
	 <1053292339.10127.45.camel@nosferatu.lan>
	 <20030519063813.A30004@infradead.org>
	 <1053341023.9152.64.camel@workshop.saharact.lan>
	 <20030519124539.B8868@infradead.org> <3EC91B6D.9070308@blue-labs.org>
	 <1053367592.1424.8.camel@laptop.fenrus.com>
	 <3EC9212C.4070303@blue-labs.org>
	 <20030519183424.E7061@devserv.devel.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0wjeQheEehGB105OkkOu"
Organization: 
Message-Id: <1053373410.7862.60.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 19 May 2003 21:43:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0wjeQheEehGB105OkkOu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-19 at 20:34, Arjan van de Ven wrote:

> > I don't use RH, and I'm not in a mood to switch to RH just because
> > RH has an LK headers maintainer.
>=20
> It;s not about using RH. At all. You obviously didn't read
> my mail. First you say "nobody is doing the work" to which I respond
> "I am, and you even don't have to use RH to benifit from it".=20
>=20

Much appreciated for the work already done.

> > AFAIK, you don't have a package that contains all the -current- headers=
=20
> > for all the current versions of all these various projects applied to=20
> > the kernel headers and then sanitized.
>=20
> You really don't get it.=20
> If a userspace app needs something REALLY special from headers, it
> should bloody well come with that header.=20
>=20
> >  I want to use my hardware that=20
> > is supported by version X of the package's software but the headers onl=
y=20
> > have version M supported.  Wireless extensions for example.
>=20
> Ok to take your example: the wireless extension using apps
> should include THEIR header for the extensions THEIR released userland
> is for, unless they want to use the sanitized headers (which should have
> latest). The kernel<->userspace ABI is stable, and compatible between
> kernel versions.=20
>=20

Another question that comes up ... with the many API changes from 2.4
to 2.5 ... how many issues is there with new sys calls missing, etc
(sorry, only got home now.).

>=20
> > The question is how to make these headers.  Nobody wants to say how and=
=20
> > when someone needs an answer, even a distro maintainer, the answer is a=
=20
> > flippant "don't use kernel headers / use your vendor".  I haven't seen=20
> > otherwise
>=20
> I tried several times to tell you, you just don't want to hear the answer
> it seems.

I think on the one hand the question is also ... how far will a
developer of one distro go to help another.  I cannot say that I
have had much success in the past to get a response from one of the
'big guys' to help me/us (the 'small guys') =3D)

Might it be a good thing to start an official project for this ?


Thanks,

--=20

Martin Schlemmer




--=-0wjeQheEehGB105OkkOu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+yTPiqburzKaJYLYRAv9GAKCTchl588gPQlJcPxJBxtkplzI3KQCeJb8i
qtFzVaWUiQxznrZ2TAaIY+8=
=pk+n
-----END PGP SIGNATURE-----

--=-0wjeQheEehGB105OkkOu--

