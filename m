Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUAMWwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUAMWt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:49:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45036 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265886AbUAMWep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:34:45 -0500
Date: Tue, 13 Jan 2004 23:34:25 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040113223425.GD20696@devserv.devel.redhat.com>
References: <40033D02.8000207@adaptec.com> <1074031592.4981.1.camel@laptop.fenrus.com> <20040113174422.B16728@animx.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20040113174422.B16728@animx.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2004 at 05:44:22PM -0500, Wakko Warner wrote:
> > > Adaptec has been looking at the MD driver for a foundation for their
> > > Open-Source software RAID stack.
> >=20
> > Hi,
> >=20
> > Is there a (good) reason you didn't use Device Mapper for this? It
> > really sounds like Device Mapper is the way to go to parse and use
> > raid-like formats to the kernel, since it's designed to be independent
> > of on disk formats, unlike MD.
>=20
> As I've understood it, the configuration for DM is userspace and the kern=
el
> can't do any auto detection.  This would be a "put off" for me to use as a
> root filesystem.  Configurations like this (and lvm too last I looked at =
it)
> require an initrd or some other way of setting up the device.  Unfortunat=
ely
> this means that there's configs in 2 locations (one not easily available,=
  if
> using initrd.  easily !=3D mounting via loop!)

the kernel is moving into that direction fast, with initramfs etc etc...
It's not like the userspace autodetector needs configuration (although it
can have it of course)

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFABHJwxULwo51rQBIRAroaAJ4oVZhnlqXQhdPHEFLPjZxo5aCFNQCfYZWR
J+aEG+G9Py0PkQRYZWBn5xo=
=yPN1
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
