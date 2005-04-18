Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVDRTvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVDRTvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVDRTvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:51:15 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:39643 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262187AbVDRTuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:50:55 -0400
Subject: Re: [PATCH 3/7] procfs privacy: misc. entries
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Dave Jones <davej@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050418190552.GA26322@redhat.com>
References: <1113850012.17341.71.camel@localhost.localdomain>
	 <20050418190552.GA26322@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GuZUekpa/UFf6TUTDfND"
Date: Mon, 18 Apr 2005 21:39:36 +0200
Message-Id: <1113853176.17341.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GuZUekpa/UFf6TUTDfND
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 18-04-2005 a las 15:05 -0400, Dave Jones escribi=F3:
> This is utterly absurd. You can find out anything thats in /proc/cpuinfo
> by calling cpuid instructions yourself.

Right, it doesn't make it worthy enough to represent any risk.

> Please enlighten me as to what security gains we achieve
> by not allowing users to see this ?

It's more obscurity than anything else. At least that's what privacy
means usually. It doesn't assure at all the unavailability of your
information to others, it just tries to hide it from the public eye.

> Restricting lots of the other files are equally absurd.
>=20
> I'd also be very surprised if various random bits of userspace
> broke subtley due to this nonsense.

I agree, as an example, grsecurity allows the configuration of a group
with rights over the restricted entries, that's why I split up the patch
for these entries.

Thanks for the comments.

Cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-GuZUekpa/UFf6TUTDfND
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZAz4DcEopW8rLewRAgN0AKCf7GyqsmRESnM9uclx4uJ4QmUo6wCdESh9
8GJU3P1TsDVsRBTkwnyQx8M=
=ejyB
-----END PGP SIGNATURE-----

--=-GuZUekpa/UFf6TUTDfND--

