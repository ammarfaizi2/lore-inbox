Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVBFTNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVBFTNS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVBFTNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:13:07 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:9048 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261283AbVBFTFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:05:18 -0500
Date: Sun, 06 Feb 2005 12:05:17 -0700
From: Jeremy Nickurak <atrus@rifetech.com>
Subject: Logitech MX-Series "Cruise Control" buttons
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <20050206190517.GA8046@agaeris.rifetech.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=ew6BAiZeqk4r7MaW;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I recently posted an update to http://bugme.osdl.org/show_bug.cgi?id=3D1786=
 that shows the bug escalating on newer hardware, such that there is no use=
r-accessable workaround.

It seem that where an MX-series mouse's cruise-control buttons are concerne=
d, the mouse (by default) produces two events for each button press: The bu=
tton itself, as well as a scroll event simulating a keyboard-style press-de=
lay-repeat cycle on the scroll wheel axis/buttons.

Utilities such as logitech_applet (unmaintained afaict) seem to be able to =
change some settings. For example, on my MX1000 mouse it's able to disable =
the cruise-control scroll button simulation, which would allow me to use th=
e buttons as ordinary mouse buttons. What I'd love to do is to be able to d=
isable the button's native function and use *only* the cruise-control funct=
ion, as the mouse was intended.

If such a hardware reconfiguration is not possible, perhaps it would be eas=
ier to leave the mouse in the default configuration, but filter one event o=
r the other before it reaches userspace? Or is it more natural to filter ou=
t the mouse's scroll-simulation, and do a mapping & key-repeat simulation i=
n userspace somewhere?

Please CC me in replies.

--=20
Jeremy Nickurak -=3D Email: atrus@lkml.spam.rifetech.com =3D-
Remember, when you buy major label CD's, you're paying
companies to sue families and independant music. Learn
more now at downhillbattle.org.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCBmpttjFmtbiy5uYRAi7XAJ9RzdhawP3MHx2dHy2d/P+VJT/4kgCeNhea
NIwCtcWxHy5vuUcBAwchh2s=
=6Baz
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
