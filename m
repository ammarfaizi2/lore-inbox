Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262742AbTCJHnC>; Mon, 10 Mar 2003 02:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262744AbTCJHnC>; Mon, 10 Mar 2003 02:43:02 -0500
Received: from adsl-67-121-154-32.dsl.pltn13.pacbell.net ([67.121.154.32]:2528
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S262742AbTCJHnB>; Mon, 10 Mar 2003 02:43:01 -0500
Date: Sun, 9 Mar 2003 23:53:40 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: psmouse.c: lost syncronization
Message-ID: <20030310075340.GA22851@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've talked about this before, but i have some more details now..

psmouse.c: Lost synchronization, throwing 1 bytes away.

This only happens when an application is monitoring any part of=20
/proc/acpi. It varies between 1 and two bytes.

Why might this be?

-Josh

--=20
New PGP public key: 0x27AFC3EE

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+bESET2bz5yevw+4RAnrgAJ9ki4lmXODYwaY42g/vISuVL4RD2ACfWoFh
eRXnG97tTnhqSwbLkvmw+8U=
=eKBQ
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
