Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTCDWvi>; Tue, 4 Mar 2003 17:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTCDWvh>; Tue, 4 Mar 2003 17:51:37 -0500
Received: from B5460.pppool.de ([213.7.84.96]:26264 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261963AbTCDWvA>; Tue, 4 Mar 2003 17:51:00 -0500
Subject: Kernel bloat 2.4 vs. 2.5
From: Daniel Egger <degger@fhm.edu>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PK67Ftr3WF/sfP7a+ejm"
Organization: 
Message-Id: <1046817738.4754.33.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 04 Mar 2003 23:42:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PK67Ftr3WF/sfP7a+ejm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

I've seen surprisingly few messages about the dramatic size increase
between a simple 2.4 and a 2.5 kernel image.=20

I just decided to check back with the 2.5 series again after my last try
with 2.5.53 (which wouldn't even boot) but had to dramatically cut down
the kernel featurewise to keep it below 1MB because I can't boot it over
tftp otherwise.=20

909824 Feb 14 20:02 vmlinuz-192.168.11.3-2.4.20
954880 Mar  4 17:01 vmlinuz-192.168.11.3-2.5.63

What you see here is a 2.4 kernel with almost everything needed to run
the machine built in and a (rsync'ed) 2.5.63 kernel with everything but
the basic stuff + ipv4 + NIC + NFS (+ other necessary features not
builtable as modules) built as modules.

Are there any patches I've missed to get that down? A slight tad bigger
and I couldn't even work with recent kernels if modules actually
worked... :/

--=20
Servus,
       Daniel

--=-PK67Ftr3WF/sfP7a+ejm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ZSvKchlzsq9KoIYRAqmJAKDTJ8ESI6vuVDYcWUClZtBzREEKwACgwTur
6jZqwKLHHVtttoH/yrufpgA=
=1JZn
-----END PGP SIGNATURE-----

--=-PK67Ftr3WF/sfP7a+ejm--

