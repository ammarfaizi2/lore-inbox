Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUCDRG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUCDRG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:06:57 -0500
Received: from wblv-248-49.telkomadsl.co.za ([165.165.248.49]:6017 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262019AbUCDRGy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:06:54 -0500
Subject: Re: udev versus parallel-port Zip drive
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: Martin Schlemmer <azarah@gentoo.org>
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <40465460.1050600@myrealbox.com>
References: <40465460.1050600@myrealbox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-q3OfXnlfS55n+lTA5Cob"
Message-Id: <1078420098.3614.4.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 19:08:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q3OfXnlfS55n+lTA5Cob
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-03-03 at 23:55, walt wrote:
> I've been fiddling with Zip-drive support -- both USB and
> parallel-port.
>=20
> When I compile everything as modules I find that the
> parallel-port driver for Zip drives (ppa) does not load
> automatically.  To make the parallel Zip drive work I
> need to do a 'modprobe ppa' manually, after which everything
> works as expected.
>=20
> I can only imagine the complexity involved in figuring out
> what is attached to the parallel port at boot-time -- there
> must be thousands of possibilities to sort through.
>=20
> My question, I suppose, is:  what are the chances that a
> parallel-port device can be automatically detected by udev
> and the appropriate module loaded?  Is this a pipe-dream?
> Or maybe it should already work and I'm just omitting some
> important steps?
>=20

You can have a look at sys-apps/discover or sys-apps/kudzu
for this.


Regards,

--=20

Martin Schlemmer




--=-q3OfXnlfS55n+lTA5Cob
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAR2KCqburzKaJYLYRArYVAJsGhlrs8PVsT1OZKOdjBmZ76GyFawCbBoWm
WeDacjFNYENUjMwG00ty4d0=
=aVHX
-----END PGP SIGNATURE-----

--=-q3OfXnlfS55n+lTA5Cob--

