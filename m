Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271840AbTGXXlU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271841AbTGXXlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:41:20 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:40598 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S271840AbTGXXlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:41:14 -0400
Subject: Re: [2.6.0-test1] ACPI slowdown
From: "Bryan D. Stine" <admin@kentonet.net>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030724234114.GB434@elf.ucw.cz>
References: <878yqpptez.fsf@deneb.enyo.de> <bfn3rj$lql$1@gatekeeper.tmr.com>
	 <1059002183.1484.18.camel@gaia>  <20030724234114.GB434@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3MUG2gI+AN5/uNwO2MZy"
Organization: KentoNET Communications
Message-Id: <1059090871.12101.0.camel@gaia>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 24 Jul 2003 19:54:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3MUG2gI+AN5/uNwO2MZy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thanks for that. Good to know I can control the termal limits now.

On Thu, 2003-07-24 at 19:41, Pavel Machek wrote:
> Hi!
>=20
> > I had that problem with my old Athlon TBird. Changing config to make
> > thermal a module and not loading it solved my problem. I don't know how
> > to change the thermal limits from within the system using ACPI.
>=20
> echo "83:83:55:70:0" > /proc/acpi/thermal_zone/THRM/trip_points
>=20
> 								Pavel

--=-3MUG2gI+AN5/uNwO2MZy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/IHG24Cdq/Vbot6MRAkQUAJ0e+wzC01tTHDkgIl9WVQtAylguhgCgoRYF
yf9OuGlvvmpzZb4iPRGSEoc=
=HGHc
-----END PGP SIGNATURE-----

--=-3MUG2gI+AN5/uNwO2MZy--

