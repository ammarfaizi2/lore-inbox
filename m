Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbULKQoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbULKQoV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 11:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbULKQoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 11:44:20 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:52153 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261964AbULKQoP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 11:44:15 -0500
Subject: Re: [ANNOUNCE] udev 047 release [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20041208185856.GA26734@kroah.com>
References: <20041208185856.GA26734@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T9DWcalZZWZg67erCVUu"
Date: Sat, 11 Dec 2004 18:44:49 +0200
Message-Id: <1102783489.12795.20.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T9DWcalZZWZg67erCVUu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-12-08 at 10:58 -0800, Greg KH wrote:

> Lots of changes here in this release, see the full changelog below.
> Highlights are:
> 	- massive change with the way udevd can now work.  See
> 	  http://thread.gmane.org/gmane.linux.hotplug.devel/6173 for
> 	  more details on this (Kay's changes are now part of udev
> 	  proper, you don't have to apply anything for this to work,
> 	  just follow the directions in
> 	  http://article.gmane.org/gmane.linux.hotplug.devel/6192
> 	  to enable this mode.)

Any suggestions to determining the version of the installed udev?
This is now during startup, to see if we can make use of using
udevsend as hotplug agent.  If the system was up, udevinfo could
be used, but that is in /usr/bin that might be on a seperate /usr.
I know we might move udevinfo to /bin, but that might be an issue
for some, and adding a -V switch to /sbin/udev might be a better
choice if you do not have have any nit's against it ....


Thanks,

--=20
Martin Schlemmer


--=-T9DWcalZZWZg67erCVUu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBuyQBqburzKaJYLYRApWDAJ4ttxDm+S/SoShzBFzhsxq7v2Z8zwCfcG9O
sWrBFqncUJ+VGrvenrzPB9k=
=DLe4
-----END PGP SIGNATURE-----

--=-T9DWcalZZWZg67erCVUu--

