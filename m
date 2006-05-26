Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWEZSzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWEZSzy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWEZSzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:55:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24747 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751246AbWEZSzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:55:53 -0400
Message-ID: <44774F0B.8010805@redhat.com>
Date: Fri, 26 May 2006 11:55:07 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       serue@us.ibm.com, sam@vilain.net, clg@fr.ibm.com, dev@sw.ru
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
References: <20060525204534.4068e730.rdunlap@xenotime.net> <m1zmh5b129.fsf@ebiederm.dsl.xmission.com> <20060526144216.GZ13513@lug-owl.de> <Pine.LNX.4.58.0605261025230.9655@shark.he.net> <20060526180131.GA13513@lug-owl.de> <Pine.LNX.4.61.0605261409300.8002@chaos.analogic.com> <447748E4.4050908@redhat.com> <Pine.LNX.4.61.0605261430370.8339@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605261430370.8339@chaos.analogic.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA62C81E2816EFB785926DDFA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA62C81E2816EFB785926DDFA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

linux-os (Dick Johnson) wrote:
> It is written (on so-called compatible machines like my Sun) as:
>=20
> #define MAXHOSTNAMELEN _POSIX_HOST_NAME_MAX
>=20
> Then in limits.h, I see:
>=20
> #define _POSIX_HOST_NAME_MAX 64

That's wrong.  The value must be 255, at least for the current spec.
You really should verify your statements before making them public.  The
POSIX spec is available in HTML for for viewing for free from the
OpenGroup.  What a specific implementation does is not authoritative.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigA62C81E2816EFB785926DDFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEd08L2ijCOnn/RHQRAlToAKDCntfcnUg86CJBuOkPrRVwg+5FgACglS3n
nWoCllTkpRsC392SG8hnoq8=
=IK2j
-----END PGP SIGNATURE-----

--------------enigA62C81E2816EFB785926DDFA--
