Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUETIpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUETIpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 04:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUETIpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 04:45:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10957 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265006AbUETIpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 04:45:15 -0400
Subject: Re: 2.6 kernel header licensing.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Mariusz Mazur <mmazur@kernel.pl>
In-Reply-To: <200405200056.40444.rob@landley.net>
References: <200405200056.40444.rob@landley.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rJ1wts67p9uMnFH2KklE"
Organization: Red Hat UK
Message-Id: <1085042700.2784.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 20 May 2004 10:45:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rJ1wts67p9uMnFH2KklE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Would anybody on linux-kernel like to venture an opinion about whether th=
e=20
> license on Mariusz's Mazur's kernel headers package could be changed to L=
GPL=20
> instead of GPL? =20

you cannot do that without the (written) permission of all contributors,
which makes that severly impractical.

However, if those headers are strictly datastructures, your library
compiled against those does not contain code from those headers, eg it's
just interface definitions. Eg as long as you don't use inlines or large
#define's that generate code you're basically ok afaics (but IANAL).=20
Now if you want to (re)distribute those headers with your package, the
GPL again applies to the files of course.

--=-rJ1wts67p9uMnFH2KklE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBArHAMxULwo51rQBIRAsgLAJ4gV1saUoxOUD1FVuOn1yEQK3S0NgCfdVkz
ekq73xtzXblLT9P8PPmZW/M=
=7fVl
-----END PGP SIGNATURE-----

--=-rJ1wts67p9uMnFH2KklE--

