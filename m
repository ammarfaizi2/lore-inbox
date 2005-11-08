Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVKHIO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVKHIO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 03:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKHIO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 03:14:29 -0500
Received: from indigo.cs.bgu.ac.il ([132.72.42.23]:24808 "EHLO
	indigo.cs.bgu.ac.il") by vger.kernel.org with ESMTP
	id S1751203AbVKHIO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 03:14:28 -0500
Subject: Re: [ACPI] ACPI and PRREMPT bug
From: Nir Tzachar <tzachar@cs.bgu.ac.il>
Reply-To: tzachar@cs.bgu.ac.il
To: Chris Wright <chrisw@osdl.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <20051107231524.GW7991@shell0.pdx.osdl.net>
References: <971FCB6690CD0E4898387DBF7552B90E0356B628@orsmsx403.amr.corp.int el.com>
	 <20051107231524.GW7991@shell0.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YrnbwH0Id88eYmHVP81+"
Organization: bgu
Date: Tue, 08 Nov 2005 10:17:22 +0200
Message-Id: <1131437843.8476.2.camel@nexus.cs.bgu.ac.il>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YrnbwH0Id88eYmHVP81+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

>   Booting with
> acpi_serialize (which sets that flag to true) does seem to fix the
> problem. =20

this partially solves the problem. im still getting this:

Nov  8 10:08:15 lapnir osl-0965 [3164] os_wait_semaphore     : Failed to
acquire semaphore[c193c820|1|0], AE_TIME
Nov  8 10:08:17 lapnir osl-0965 [4647] os_wait_semaphore     : Failed to
acquire semaphore[c193c820|1|0], AE_TIME

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Nir Tzachar.

--=-YrnbwH0Id88eYmHVP81+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDcF8SIHR+zI+Dam4RAo27AJ9goDwh1vn9t/l/dvoACJi5A/r7/gCgrzQ5
2WPhTcZwmyiwOebwHsIxuBM=
=iyVs
-----END PGP SIGNATURE-----

--=-YrnbwH0Id88eYmHVP81+--

