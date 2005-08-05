Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVHEPEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVHEPEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbVHEPDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:03:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55200 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263042AbVHEOxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:53:31 -0400
Message-ID: <42F37CC5.6030206@redhat.com>
Date: Fri, 05 Aug 2005 07:50:45 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Kerrisk <mtk-lkml@gmx.net>
CC: David Woodhouse <dwmw2@infradead.org>, jakub@redhat.com,
       linux-kernel@vger.kernel.org, bert.hubert@netherlabs.nl,
       michael.kerrisk@gmx.net, akpm@osdl.org
Subject: Re: pselect() modifying timeout
References: <1118835415.22181.68.camel@hades.cambridge.redhat.com> <31556.1123238544@www44.gmx.net>
In-Reply-To: <31556.1123238544@www44.gmx.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCCCBEDFA665423DE7A8F565F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCCCBEDFA665423DE7A8F565F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michael Kerrisk wrote:
> Please consider making Linux pselect() conform to POSIX on this=20
> point.

There is no question the implementation will conform.  But this not
dependent on changing the syscall interface.  We deliberately decided to
not require the kernel interface to be different from select.  The
userlevel code will take care of the difference.  The kernel code is
good as proposed.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigCCCBEDFA665423DE7A8F565F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFC83zF2ijCOnn/RHQRAq/xAJoCToma5Q++r9SCQ5Rh6yZtmOUHaACdGOob
UG//GprtC81ORWiPEKspc9M=
=3nxM
-----END PGP SIGNATURE-----

--------------enigCCCBEDFA665423DE7A8F565F--
