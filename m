Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbTCESRI>; Wed, 5 Mar 2003 13:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTCESRI>; Wed, 5 Mar 2003 13:17:08 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:47347 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267364AbTCESRG>; Wed, 5 Mar 2003 13:17:06 -0500
Subject: RE: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       kai.bankett@ontika.net, mingo@redhat.com,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
In-Reply-To: <E88224AA79D2744187E7854CA8D9131DA8B7E0@fmsmsx407.fm.intel.com>
References: <E88224AA79D2744187E7854CA8D9131DA8B7E0@fmsmsx407.fm.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qt1yLcvLzkFbRRJFeKoY"
Organization: 
Message-Id: <1046888812.1539.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 Mar 2003 19:26:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qt1yLcvLzkFbRRJFeKoY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-03-05 at 05:21, Kamble, Nitin A wrote:
> There are few issues we found with the user level daemon approach.
>  =20
>    Static binding compatibility: With the user level daemon, users can
> not =20
> use the /proc/irq/i/smp_affinity interface for the static binding of
> interrupts.

no they can just write/change the config file, with a gui if needed

>=20
>   There is some information which is only available in the kernel today,

there's also some information only available to userspace today that the
userspace daemon can and does use.

> Also the future implementation might need more kernel data. This is
> important for interfaces such as NAPI, where interrupts handling changes
> on the fly.

ehm. almost. but napi isn't it ....

and the userspace side can easily have a system vendor provided file
that represents all kinds of very specific system info about the numa
structure..... working with every kernel out there.


--=-qt1yLcvLzkFbRRJFeKoY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ZkFsxULwo51rQBIRAvmnAJ91kXexX3irCPCHl37KLhRU1ieT2wCgka62
nx2Qz5D2Ugw17CLpHOGbv+A=
=cfau
-----END PGP SIGNATURE-----

--=-qt1yLcvLzkFbRRJFeKoY--
