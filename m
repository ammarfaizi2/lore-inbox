Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTJRU2l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJRU2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:28:41 -0400
Received: from neveragain.de ([217.69.76.1]:56983 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S261782AbTJRU2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:28:39 -0400
Date: Sat, 18 Oct 2003 22:28:20 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PARTIAL success with ACPI S3 suspend to ram on Acer TravelMate 800LCi
Message-ID: <20031018202820.GA9737@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Pavel, hello Patrick, hi folks,

The saga ([0] and [1]) continues, here are the latest facts about ACPI S3
suspend to ram mode with the Acer TravelMate 800LCi notebook.

With Linux 2.6.0-test8, there is some kind of partial success: After doing
"echo -n mem > /sys/power/state" the box suspends and after pressing a key
on the keyboard the box resumes. The box reacts to input afterwards, for
example one can do "reboot" as root and even pressing the power key does
what it is supposed to do. Unfortunately there is one big disadvantage:
The panel of the notebook stays completely black. I tried booting with
"acpi_sleep=3Ds3_{mode,boot}" but in both cases, the box apparently hangs
while trying to resume (no [blind] keyboard input possible, pressing the
power button has no effect)

Any ideas where the problem might be and if so how to fix it?

[0] http://lkml.org/lkml/2003/8/18/44
[1] http://lkml.org/lkml/2003/9/20/34

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/kaJkHPo+jNcUXjARAimIAJ4i6mPEtMbww+ZTdgQMJ0wbyNbjEgCghTU3
sJHtC32AbXfyIG8mezPZa7c=
=dhEv
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
