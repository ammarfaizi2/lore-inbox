Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269966AbUJHOOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269966AbUJHOOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269987AbUJHOOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:14:00 -0400
Received: from ex-nihilo-llc.com ([206.114.147.90]:35337 "EHLO
	ex-nihilo-llc.com") by vger.kernel.org with ESMTP id S269966AbUJHONy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:13:54 -0400
Subject: Re: Maximum block dev size / filesystem size
From: Aaron Peterson <aaron@alpete.com>
Reply-To: aaron@alpete.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097177960.31547.132.camel@localhost.localdomain>
References: <1097180361.491.25.camel@main>
	 <1097177960.31547.132.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NRBJLMw8Vk/UxQGgKxLl"
Message-Id: <1097244833.491.31.camel@main>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 10:13:53 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NRBJLMw8Vk/UxQGgKxLl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-10-07 at 15:39, Alan Cox wrote:
> On Iau, 2004-10-07 at 21:19, Aaron Peterson wrote:
> > I work for a company with a 15 TB SAN.  All opinions about the
> > disadvantages of creating really large filesystems aside, I'm trying to
> > find out what is the maximum filesystem size we can allocate on our SAN
> > that a linux box (x86) can really use.
>=20
> For 2.4.x 1Tb (2Tb works for some devices but its a bit variable)
>=20
> > What I can't seem to find anywhere is whether the 2 TB block device
> > limit has improved/grown with 2.6 kernels (on x86 hardware).  Perhaps
> > I've looked in the wrong places, but I haven't found anything.
>=20
> 2.6 fixed this problem although it appears not for some specialist
> cases. Last time I checked LVM logical volumes over 2Tb were reported
> problematic.

I've read that the other main difficulty besides block device size
limits is problems with the ext2 management tools themselves.  So, how
would you rate my chances of using a 2.6 kernel with XFS (and xfs
management tools of course) with a 5 TB filesystem?  Probably not a well
tested scenerio to say the least...

Aaron

--=-NRBJLMw8Vk/UxQGgKxLl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (FreeBSD)

iD8DBQBBZqCgeJcyAiXpNL8RAny5AJ972ej3GzHQhbxlbrcda8Ps0HybdwCdEqBN
foeCyR6m0GlrcAsQQynSoy8=
=32Rd
-----END PGP SIGNATURE-----

--=-NRBJLMw8Vk/UxQGgKxLl--

