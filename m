Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVCCLbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVCCLbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVCCL33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:29:29 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:21246 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261630AbVCCLYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:24:52 -0500
Subject: Re: RFD: Kernel release numbering
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	 <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org>
	 <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
	 <422674A4.9080209@pobox.com>
	 <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WZziCTS+KIUNWSGHcUZB"
Date: Thu, 03 Mar 2005 13:27:02 +0200
Message-Id: <1109849223.16449.26.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WZziCTS+KIUNWSGHcUZB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-03-02 at 19:37 -0800, Linus Torvalds wrote:
>=20
> On Wed, 2 Mar 2005, Jeff Garzik wrote:
> >=20
> > If we want a calming period, we need to do development like 2.4.x is=20
> > done today.  It's sane, understandable and it works.
>=20
> No. It's insane, and the only reason it works is that 2.4.x is a totally
> different animal. Namely it doesn't have the kind of active development A=
T
> ALL any more. It _only_ has the "even" number kind of things, and quite=20
> frankly, even those are a lot less than 2.6.x has.
>=20
> > 2.6.x-pre: bugfixes and features
> > 2.6.x-rc: bugfixes only
>=20
> And the reason it does _not_ work is that all the people we want testing=20
> sure as _hell_ won't be testing -rc versions.
>=20
> That's the whole point here, at least to me. I want to have people test=20
> things out, but it doesn't matter how many -rc kernels I'd do, it just=20
> won't happen. It's not a "real release".
>=20
> In contrast, making it a real release, and making it clear that it's a=20
> release in its own right, might actually get people to use it.=20
>=20

See, the point that you are missing, is that the lack of testing is not
because of it being a -rc or -shouldworkprettydandy or whatever, but the
_stigma_ attached to 2.6 based -rc releases.  (Same reason why -mm is
not the most popular kernel around for those more conservative users.)

The first few -rc's was tested by the more conservative users, but then
things broken on them, and they went "what the hell?  Is this a -rc?",
and got the currently standard "sorry for your issues, but 2.6 -rc's
*might* be release ready or it might be a accident ready to happen.
Please check LKML for when Linus says to slow down" reply.  And how many
of your more conservative users will start to read LKML for that?

So now you are basically sitting with a situation where -rc's really do
not get the coverage they should, and 'stable' 2.6.x versions are really
not that stable, with lots of excuses being thrown around - its the
distro's job to make a stable kernel - comes to mind.  And you know what
- your conservative users (which this horkage is all about) actually
heard that via a friend/whoever that reads LKML.  The outcome? - many of
them probably do not even test 2.6.x kernels anymore, but wait for the
distro, or try -ac/-ck kernels until they get an issue there (the sound
issue with fedora that was mentioned comes to mind).

So if you ask me, the only visible effect that your new scheme will
have, is that maybe the first few 2.6.odd releases will be tested by
some of the conservative users still testing 'stable' kernel.org
kernels, but then the 'stigma' will just shift, and they will totally
rely on distro kernels or wait for patch sets that are known more stable
(dunno - ck/ac?). And thus making kernel.org kernels even more flaky.

Solution?  I cannot really comment here, as I do not know the effort to
queue and maintain lots of kernel patches for some time.  The -pre/-rc
scheme might work though from a user perspective if you can get the
stigma attached to 2.6 -rc's removed.  But that will take some time ...


--=20
Martin Schlemmer


--=-WZziCTS+KIUNWSGHcUZB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCJvSGqburzKaJYLYRAhIzAJ9nozk9VuJVVcKUtGRGZmiIEWFiPQCfcE71
B0n/Zn3ODr7tVX+CEHXPrms=
=Gx0m
-----END PGP SIGNATURE-----

--=-WZziCTS+KIUNWSGHcUZB--

