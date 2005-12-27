Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVL0W1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVL0W1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 17:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVL0W1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 17:27:07 -0500
Received: from mout0.freenet.de ([194.97.50.131]:47015 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S932377AbVL0W1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 17:27:06 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Alex Davis <alex14641@yahoo.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Tue, 27 Dec 2005 23:26:41 +0100
User-Agent: KMail/1.8.3
References: <20051216052913.GD30754@redhat.com> <20051216061605.46520.qmail@web50211.mail.yahoo.com> <20051227210359.GG20654@vasa.acc.umu.se>
In-Reply-To: <20051227210359.GG20654@vasa.acc.umu.se>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       David Weinehall <tao@acc.umu.se>
MIME-Version: 1.0
Message-Id: <200512272326.41438.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart1482860.F69lHSxeDj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1482860.F69lHSxeDj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 27 December 2005 22:03, David Weinehall wrote:
> On Thu, Dec 15, 2005 at 10:16:05PM -0800, Alex Davis wrote:
> >=20
> >=20
> > --- Dave Jones <davej@redhat.com> wrote:
> >=20
> > > On Thu, Dec 15, 2005 at 09:20:54PM -0800, Alex Davis wrote:
> > >  > The problem is that, with laptops, most of the time you DON'T
> > >  > have a choice: HP and Dell primarily use a Broadcomm integrated
> > >  > wireless card in ther products.  As of yet, there is no open
> > >  > source driver for Broadcomm wireless.
> > >=20
> > > We've already been through all this the previous times this came up.
> > >=20
> > > http://bcm43xx.berlios.de
> > >=20
> > > Whilst it's in early stages, it's making progress.
> > >=20
> > > 		Dave
> > >=20
> > >=20
> > I understand that, and am grateful for the effort, but the point is
> > it's not ready. Are you expecting people to lose an important feature
> > of their laptop until you get the driver ready?=20
>=20
> Yeah, it must be oh so important for the laptop owners with that
> particular chipset to run the -mm experimental kernels instead of, their
> distro kernel or the stable 2.6-kernel series or Linus latest
> installment (or even a git-snapshot or checkout...)

Well, the devicescape port of the bcm43xx driver works
very relieably on my Apple PowerBook with WPA encryption.
(WEP does also work).
I don't think there are lots of issues left for non-AccessPoint
modes. I simply assume you want to run the card in STA mode,
instead of rendering your expensive notebook into an AP. ;)

It's been a long time, since I plugged my ethernet cable into
the notebook the last time... .

=2D-=20
Greetings Michael.

--nextPart1482860.F69lHSxeDj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDsb+hlb09HEdWDKgRAioYAJ0bNKLZwIMYBeKOrj/ynAloRjDi5gCguq1F
mMF2AcFEdJe/tITB3O7NEpE=
=fmdb
-----END PGP SIGNATURE-----

--nextPart1482860.F69lHSxeDj--
