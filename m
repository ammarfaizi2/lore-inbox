Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbSIZNkm>; Thu, 26 Sep 2002 09:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSIZNkm>; Thu, 26 Sep 2002 09:40:42 -0400
Received: from B50fa.pppool.de ([213.7.80.250]:58498 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261281AbSIZNkj>; Thu, 26 Sep 2002 09:40:39 -0400
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
From: Daniel Egger <degger@fhm.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200209252325.08391.ryan@completely.kicks-ass.org>
References: <E17uINs-0003bG-00@think.thunk.org>
	<200209252223.13758.ryan@completely.kicks-ass.org>
	<20020926055755.GA5612@think.thunk.org> 
	<200209252325.08391.ryan@completely.kicks-ass.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-fuuuFtzIEE9xrpcD7xQF"
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Sep 2002 13:25:00 +0200
Message-Id: <1033039501.21335.23.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fuuuFtzIEE9xrpcD7xQF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2002-09-26 um 08.25 schrieb Ryan Cumming:

> Before I go again, any suggestions on how to reliably capture these error=
=20
> messages? Because the filesystem goes read-only immediately,=20
> /var/log/messages is hardly useful.

Indeed, but I'd wonder why someone whould start syslogd on a r/o
filesystem, so probably /var/log/messages is not used at this time
anyway. You could set up syslogd to do remote logging to another machine
and fire it up before the troubles to capture anything. But of course
this requires
a) another machine
b) syslog set up on both sides for remote logging
c) a working network

An alternative would be to mount another disk with a different
filesystem (reiserfs/FAT) and log to there.
=20
--=20
Servus,
       Daniel

--=-fuuuFtzIEE9xrpcD7xQF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ku6Mchlzsq9KoIYRAsb7AJ0X6Dc9ae4jSOpO+TcFROGkkLNn5gCfSVNn
fVjobZ7x0HrwFhf1T2aYuKw=
=8ANO
-----END PGP SIGNATURE-----

--=-fuuuFtzIEE9xrpcD7xQF--

