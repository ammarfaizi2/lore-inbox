Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265873AbTFVUpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 16:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265882AbTFVUpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 16:45:35 -0400
Received: from mail.gmx.de ([213.165.64.20]:49608 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265873AbTFVUpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 16:45:34 -0400
Date: Sun, 22 Jun 2003 22:59:42 +0200
From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Getting very high CPU-load with new acpi
Message-Id: <20030622225942.528a5dc2.hanno@gmx.de>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Zh5OxpGwtn:UC="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Zh5OxpGwtn:UC=
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I own a fujitsu-siemens lifebook C6155.
With several linux-kernels containing the new acpi (2.5.x, 2.4.21+patch,
2.4.21-ac1), I get very high CPU-load every few seconds. It's even
impossible to listen mp3s.
top shows me that it's the process events on 2.5-kernels and keventd on
2.4-kernels. This does not happen with 2.4.21-vanilla (without
acpi-patch, but with acpi enabled and working).
So the bug seems to be in the new acpi-system.

dmesg-output, lspci-output, dsdt and other information is available
through
http://bugzilla.kernel.org/show_bug.cgi?id=3D843

--=20
Hanno B=F6ck - hanno@gmx.de

--=.Zh5OxpGwtn:UC=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9hjBr2QksT29OyARAnwEAKCicUorOHpuidTYOrlBDCR3JR9SggCfWJ4X
cvMG7lOdO4OcxI4hReJyNFk=
=gPzB
-----END PGP SIGNATURE-----

--=.Zh5OxpGwtn:UC=--
