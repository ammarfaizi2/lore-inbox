Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVL3EEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVL3EEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 23:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVL3EEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 23:04:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31445 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751004AbVL3EEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 23:04:53 -0500
Message-ID: <43B4B1AF.3020303@redhat.com>
Date: Thu, 29 Dec 2005 20:03:59 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make sysenter support optional
References: <20051228212402.GX3356@waste.org> <a36005b50512281407x74415958tb0fa2b52f4dd7988@mail.gmail.com> <43B30E19.6080207@redhat.com> <20051229195641.GB3356@waste.org> <a36005b50512291901l6a5acb77ha17d3552ea9c9fd9@mail.gmail.com> <43B4A3CA.4060406@redhat.com> <20051230033803.GG3356@waste.org>
In-Reply-To: <20051230033803.GG3356@waste.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9567545C923B1DF8948ACDC9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9567545C923B1DF8948ACDC9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Matt Mackall wrote:
> Ok, let me be explicit: think systems with absolutely no facility for
> recording or displaying a backtrace.

You don't know much about unwinding, do you?  The same information is
needed for C++ exception handling, thread cancellation, etc.  Now go on
and tell me you don't need this either.


> As far as I'm aware, uclibc has no vdso support, so it might as well
> not exist for systems using it.

And I told you that the support which magically makes all this sometimes
work without the unwind info in the vdso will sooner or later break.
Then whatever other libc is out there has to get vdso support to be able
to function correctly.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig9567545C923B1DF8948ACDC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDtLGv2ijCOnn/RHQRAjKqAJoD36yWeSnnupr+XxzgnhicyHQLTwCgr95c
IYEj4VhAJ8aq142frfuhalo=
=DDB7
-----END PGP SIGNATURE-----

--------------enig9567545C923B1DF8948ACDC9--
