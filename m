Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbUAFBx5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUAFBx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:53:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62596 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S263221AbUAFBxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:53:55 -0500
Date: Mon, 05 Jan 2004 20:53:23 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch
To: akpm@zip.com.au, Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1073354003.4101.11.camel@idefix.homelinux.org>
Organization: =?ISO-8859-1?Q?Universit=C3=A9_de?= Sherbrooke
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: multipart/signed; boundary="=-WqYxv/igqdW0IcmY+5HY";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WqYxv/igqdW0IcmY+5HY
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I've just tried 2.6.1-rc1-mm2 and noticed that I can no longer get the
battery status through ACPI (/proc/acpi/battery/BAT0/state reports only
zeros). While my dsdt may be a bit buggy, it worked fine with 2.6.1-rc1,
so there seems to be a regression somewhere. I haven't tried earlier -mm
patches though.

I'm running Fedora Core 1 on Dell Latitute D600 (Pentium M 1.6, 1 GB
RAM). I can do more testing if that's useful.

	Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-WqYxv/igqdW0IcmY+5HY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/+hUSdXwABdFiRMQRAnTSAJ9m0fpiiFLWR6959mSnqanEG4dl7wCgna8a
aSmppAZaA4LS500VIHKIVxs=
=R5x6
-----END PGP SIGNATURE-----

--=-WqYxv/igqdW0IcmY+5HY--

