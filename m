Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbTDHEDK (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 00:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263929AbTDHEDI (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 00:03:08 -0400
Received: from cpt-dial-196-30-179-42.mweb.co.za ([196.30.179.42]:1665 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263928AbTDHEDG (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 00:03:06 -0400
Subject: Re: [PATCH-2.5] Fix w83781d sensor to use Milli-Volt for in_* in
	sysfs
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com
In-Reply-To: <20030407215443.GA4386@kroah.com>
References: <1049750163.4174.35.camel@nosferatu.lan>
	 <20030407215443.GA4386@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Sk8B9ptkazBI0R/Pbf4Q"
Organization: 
Message-Id: <1049775078.23992.2.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 08 Apr 2003 06:11:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Sk8B9ptkazBI0R/Pbf4Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-04-07 at 23:54, Greg KH wrote:
> On Mon, Apr 07, 2003 at 11:16:03PM +0200, Martin Schlemmer wrote:
> > --- drivers/i2c/chips/w83781d.c.orig	2003-04-07 22:53:37.000000000 +020=
0
> > +++ drivers/i2c/chips/w83781d.c	2003-04-07 22:53:34.000000000 +0200
> > @@ -364,7 +364,7 @@
> >  	 \
> >  	w83781d_update_client(client); \
> >  	 \
> > -	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
> > +	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
>=20
> Hm, this patch looks backwards, is it?
>=20
> Also, just as a side note, can you make your patches so that they can be
> applied with "patch -p1" instead of "patch -p0" which your current ones
> are?  My tools treat -p1 patches much better :)
>=20

Yes, sorry, that is reverse.  I have to go to work in a bit, so if you
need me to resend tonight, just ask.


--=20

Martin Schlemmer



--=-Sk8B9ptkazBI0R/Pbf4Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+kkvlqburzKaJYLYRAl7AAJ9dDs80zAcnNwAQeWqQiC5rWeIQjQCfR3EE
G9BmDCWy+V47kR8WsGQwwNw=
=L5yh
-----END PGP SIGNATURE-----

--=-Sk8B9ptkazBI0R/Pbf4Q--

