Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVFMPof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVFMPof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFMPof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:44:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261671AbVFMPoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:44:16 -0400
Message-ID: <42ADA8F5.6050905@redhat.com>
Date: Mon, 13 Jun 2005 08:40:37 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Add pselect, ppoll system calls.
References: <1118444314.4823.81.camel@localhost.localdomain>	 <1118616499.9949.103.camel@localhost.localdomain>	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org> <1118661326.9949.127.camel@localhost.localdomain>
In-Reply-To: <1118661326.9949.127.camel@localhost.localdomain>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE67FFECD36F6D9977DBC19FE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE67FFECD36F6D9977DBC19FE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Alan Cox wrote:
> Right but why can't glibc be fixed to use the longjmp trick internally.=



How, Alan?  Remember, these are not the days of V7.  We have threads.
And we have signal handlers as a process-wide property, shared by all
threads.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigE67FFECD36F6D9977DBC19FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFCraj12ijCOnn/RHQRAuocAJsGsFcGWsYFUoJlfrc9oEcHepPz4ACggNcY
7ADIvFu2zoKq1pFqO+VIdm0=
=GXVq
-----END PGP SIGNATURE-----

--------------enigE67FFECD36F6D9977DBC19FE--
