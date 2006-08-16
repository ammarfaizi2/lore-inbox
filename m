Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWHPSC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWHPSC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWHPSC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:02:26 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:31637 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751237AbWHPSCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:02:25 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Date: Wed, 16 Aug 2006 20:02:02 +0200
User-Agent: KMail/1.9.4
Cc: Jiri Benc <jbenc@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
References: <20050427124911.6212670f@griffin.suse.cz> <20060816191139.5d13fda8@griffin.suse.cz> <20060816174329.GC17650@ojjektum.uhulinux.hu>
In-Reply-To: <20060816174329.GC17650@ojjektum.uhulinux.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2397831.R6rdy09zWi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608162002.06793.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2397831.R6rdy09zWi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 16 August 2006 19:43 schrieb Pozsar Balazs:
> On Wed, Aug 16, 2006 at 07:11:39PM +0200, Jiri Benc wrote:
> > On Tue, 15 Aug 2006 11:25:52 +0200, Pozsar Balazs wrote:
> > > Recently I had similar problems as you described below, that's how I
> > > found your email. (My exact problem is that there's no link when I pl=
ug
> > > in a cable, reloading the driver a few times usually helps.)
> > > The problem is, that since you made the patch, the uli526x driver has
> > > been split out from the tulip driver.
> > > Do you know anything about the current state of the uli526x driver
> > > regarding the problems you tried patch?
> >
> > I use the card with new (split out) uli526x driver with no problem. Your
> > problems are probably unrelated.
>
> So, just to make it clear: if you boot without cable plugged in, let
> the driver load, and then plug the cable in, do you have link?
> For me, it does not have link until I rmmod the module.

Same here.

> Do you have any idea what the problem could be, or could I send you any
> info that would help debug it?

I actually played a bit with the code and what fails is uli526x_sense_speed=
 =20
in that way that phy_mode & 024 is 0 (and stays 0). But I don't understand=
=20
why...

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2397831.R6rdy09zWi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE412exU2n/+9+t5gRAmcIAJ0SFVyq1JtlNQKk5gv2wp0JjQks5ACgqat+
I9S4ohUO2xMfw+lSCFB6DpM=
=U41t
-----END PGP SIGNATURE-----

--nextPart2397831.R6rdy09zWi--
