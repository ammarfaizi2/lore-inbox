Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWAFVuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWAFVuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWAFVuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:50:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57493 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751488AbWAFVuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:50:20 -0500
Message-ID: <43BEE5F8.5040109@redhat.com>
Date: Fri, 06 Jan 2006 13:49:44 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH 3/3] updated *at function patch
References: <5s5sB-p4-181@gated-at.bofh.it> <E1EuzOT-0000jw-1g@be1.lrz>
In-Reply-To: <E1EuzOT-0000jw-1g@be1.lrz>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2657D9B41484B82B72BD8816"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2657D9B41484B82B72BD8816
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Bodo Eggert wrote:
>> +#define __NR_fchownat                259
>> +__SYSCALL(__NR_fchownat, sys_fchownat)
>=20
> s/fchown/chown/ ?

No, fchownat is the name commonly used.  I don't like it much either but
it's the name commonly used (i.e., what is used in Solaris).

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig2657D9B41484B82B72BD8816
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDvuX42ijCOnn/RHQRAmZ2AKDCCRGiEsnLrb7aRkSrf8kik9bIYACfTmAN
GLH3ILceAd3ArrDhjoKpq4g=
=0Q3v
-----END PGP SIGNATURE-----

--------------enig2657D9B41484B82B72BD8816--
