Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVAMIhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVAMIhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVAMIhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:37:40 -0500
Received: from faye.voxel.net ([69.9.164.210]:52110 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S261298AbVAMIha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:37:30 -0500
Subject: 2.6.10-as1
From: Andres Salomon <dilinger@voxel.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MN5Zr+/dZiAIX4Bl8NSn"
Date: Thu, 13 Jan 2005 03:37:28 -0500
Message-Id: <1105605448.7316.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MN5Zr+/dZiAIX4Bl8NSn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm announcing a new kernel tree; -as.  The goal of this tree is to form
a stable base for vendors/distributors to use for their kernels.  In
order to do this, I intend to include only security fixes and obvious
bugfixes, from various sources.  I do not intend to include driver
updates, large subsystem fixes, cleanups, and so on.  Basically, this is
what I'd want 2.6.10.1 to contain.

This first release should have been done last week, but the various
security advisories kept me pretty busy.  It includes various iptables
and nfs fixes, the various security fixes announced over the past two
weeks (including the latest, CAN-2005-0001), and misc. others.  My hope
is that people find this useful, so less work is duplicated by
distribution packagers.  Debian kernels are basically a combination of
this tree, as well as debian-specific patches and more experimental
stuff.

The kernel patches can be grabbed from here:
http://www.acm.rpi.edu/~dilinger/patches/2.6.10/as1/

02e412361955fa80c0ea3a5a59a37c36  ChangeLog
0a75d0e8922491fb2540b3c6178dfd58  linux-2.6.10-as1.tar.gz
540effd229ea72dad4bd274bba40fb94  patch-2.6.10-as1.gz

patch-2.6.10-as1.gz is a patch against vanilla 2.6.10.
linux-2.6.10-as1.tar.gz are the patches, individually broken out.
Patches pulled from bitkeeper include their comment headers.

As mentioned, this should've been released last week; as such, it's
about a week behind bitkeeper.  I shall go through the remaining 600 or
so changesets within the next few days, and release -as2.
=20

--=20
Andres Salomon <dilinger@voxel.net>

--=-MN5Zr+/dZiAIX4Bl8NSn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB5jNI78o9R9NraMQRAk81AKDEaSIK6f4xZNiDOsJ/5zGo4Ln4LACgxsn6
MM83q4A6FOEQLFzpjaqHrNI=
=QD6t
-----END PGP SIGNATURE-----

--=-MN5Zr+/dZiAIX4Bl8NSn--

