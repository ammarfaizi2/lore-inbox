Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTLNSfJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 13:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTLNSfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 13:35:09 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:65417 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262303AbTLNSfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 13:35:03 -0500
Subject: Re: udev for dummies
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Greg KH <greg@kroah.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031212213148.GA24643@kroah.com>
References: <20031211221604.GA2939@werewolf.able.es>
	 <20031212213148.GA24643@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jQyRdoBH20eXxpw56vE3"
Message-Id: <1071427017.17146.2.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Dec 2003 20:36:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jQyRdoBH20eXxpw56vE3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-12-12 at 23:31, Greg KH wrote:
> On Thu, Dec 11, 2003 at 11:16:04PM +0100, J.A. Magallon wrote:
> > Hi all...
> >=20
> > I am starting to use 2.6, and I really would like to use udev.
> > But I can't find a doc about how to move from taditional heavily
> > populated /dev to new method.
> >=20
> > Any pointer ?
>=20
> Did you read the README in udev's package?
>=20
> Anyway, I don't really recommend using udev for management of your /dev
> at this moment in time.  In order to do this we need some more
> intregration of udev into the early boot process.  People are working on
> this, but it will be a bit of time before it works properly, sorry.
>=20

It does work nicely to manage /dev if /dev is well populated as you
would have for a non-devfs system (yes, it does sort of defeat the
point, but the extra functionality of udev like changing the name
of a specific usb device, etc, makes up for the current 'bloat of
this approach).


--=20
Martin Schlemmer

--=-jQyRdoBH20eXxpw56vE3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/3K3JqburzKaJYLYRArygAJ9Erryps8ktgk1Nj1cDYJek05aizQCfS3Ju
4dI4CmqnmORDsLl4sRBICoY=
=v95Y
-----END PGP SIGNATURE-----

--=-jQyRdoBH20eXxpw56vE3--

