Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUADA4j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbUADA4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:56:39 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:63655 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264382AbUADA4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:56:37 -0500
Subject: Re: Technical udev question for Greg
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: walt <wa1ter@myrealbox.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <3FF75D26.5070009@myrealbox.com>
References: <3FF72A4C.2040404@myrealbox.com>
	 <20040103214750.GB11061@kroah.com>  <3FF75D26.5070009@myrealbox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6VDaMKJoELvTsr7fm3u7"
Message-Id: <1073177960.6075.246.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 04 Jan 2004 02:59:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6VDaMKJoELvTsr7fm3u7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-04 at 02:24, walt wrote:

>=20
> > 	rm -rf /dev/*
> > 	rm -f /dev/.udev.tdb
> > 	/etc/init.d/udev start
>=20
> However, after doing the above and recreating a few missing devices
> the behavior of the machine seems back to normal, so clearly I did
> something that mattered.  I don't pretend to understand how or why,
> but thanks.

Forgot to say in other mail to you - I had weird issues with nodes
that was not yet sysfs'ified in the past due to strange permissions
(this is now aside those on ptmx).   Try rc1-mm1 for misc/vc sysfs
support (might be a fluke, but I have not yet had strange going on's
since Greg posted them, so maybe it might be /dev/null, etc that
caused issues for me, that did it for you as well), or if you roll
your own kernels, I will be glad to post you the patches off list if
you cannot find them here.


--=20
Martin Schlemmer

--=-6VDaMKJoELvTsr7fm3u7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/92VoqburzKaJYLYRArjPAKCHF858ScADvvms6FfTlu68/vuh8QCeN/Pt
JpnJbExaJKcvjSpiLzYcej8=
=GP8j
-----END PGP SIGNATURE-----

--=-6VDaMKJoELvTsr7fm3u7--

