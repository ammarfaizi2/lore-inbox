Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272456AbTGZK51 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 06:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272457AbTGZK51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 06:57:27 -0400
Received: from adsl-247-226.38-151.net24.it ([151.38.226.247]:15371 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S272456AbTGZK5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 06:57:14 -0400
Date: Sat, 26 Jul 2003 13:12:21 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 devfs question
Message-ID: <20030726111221.GD9574@renditai.milesteg.arr>
Mail-Followup-To: Wiktor Wodecki <wodecki@gmx.de>,
	rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
References: <20030725110830.GA666@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20030725110830.GA666@gmx.de>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.21
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is a bug with devfs and raid, see:
http://bugzilla.kernel.org/show_bug.cgi?id=3D471

It's sitting there since 2.5.45, but no one seems interested and I=20
don't have the knowledge to fix it by myself (or the time to acquire=20
that knowledge).

Bye.

On Fri, Jul 25, 2003 at 01:08:31PM +0200, Wiktor Wodecki wrote:
> Hello,
>=20
> I'm currently running at 2.6.0-test1-mm2-O8 and I wanted to give devfs a
> shot. I recompiled the kernel with the following settings:
> CONFIG_DEVFS_FS=3Dy
> CONFIG_DEVFS_MOUNT=3Dy
> # CONFIG_DEVFS_DEBUG is not set
>=20
> I'm not sure whether this is a bug in mount/nomount of devfs or if it's
> somewhere my fault/setup (root on raid1, various lvm2 devices on raid1/0
> devices)
>=20
> Any help would be greatly appreciated.

--=20
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/


--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/ImIV2rmHZCWzV+0RAuRRAJ9egdCB4KqOX0Iwz7qhtoKqOAF7ZgCgsH39
Qsgc0BR/HlaE62mEpQxbmo0=
=NnmD
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
