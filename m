Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUAJRxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUAJRxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:53:36 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:18887 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S265288AbUAJRxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:53:32 -0500
Subject: Re: 2.4.24 eth0: TX underrun, threshold adjusted.
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Gabor Z. Papp" <gzp@papp.hu>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       Scott Feldman <scott.feldman@intel.com>
In-Reply-To: <x6oetb66uu@gzp>
References: <x665fkb59o@gzp> <1073746559.752.44.camel@tux.rsn.bth.se>
	 <x6oetb66uu@gzp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7vAel1dddsNhYUsPYas6"
Message-Id: <1073757207.752.50.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 18:53:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7vAel1dddsNhYUsPYas6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-10 at 18:39, Gabor Z. Papp wrote:

> | I think you ran the eepro100 driver in 2.4.23 and now in 2.4.24 you are
> | using the e100 driver, am I correct?
>=20
> No, you aren't.

Ok, this time I actually looked at the sources instead of using my
memory which evidently, isn't that good.

You are right, it's the eepro100 driver that prints the messages. But I
was correct that it's the e100 driver that decreases it again :)

Sorry for the confusion.

> | This isn't really an error, it's an indicator that the pci-bus doesn't
> | really keep up, then the NIC has to increase the threshold (it tries to
> | start sending the packet out before it's fully transferred from main
> | memory to the NIC, it hopes the rest of the packet will have been
>=20
> Funny because I have changed the mobo/cpu/ram from P3 to P4. Maybe
> its related to that change?

Most probably.

Scott, disregard most of what I wrote :)
But I still don't really see why the e100 driver decreases the threshold
all the time...

--=20
/Martin

--=-7vAel1dddsNhYUsPYas6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAADwWWm2vlfa207ERAoMBAJ0U1ZFPhXygmeCypVHLb4Yd+8MVcQCgiUYD
m3xPhFaaJi3kfAzxXCka4xg=
=uHCy
-----END PGP SIGNATURE-----

--=-7vAel1dddsNhYUsPYas6--
