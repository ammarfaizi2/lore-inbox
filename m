Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWJOJ5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWJOJ5g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 05:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWJOJ5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 05:57:36 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:7620 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1750702AbWJOJ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 05:57:35 -0400
Message-ID: <453205E7.3060003@web.de>
Date: Sun, 15 Oct 2006 11:56:55 +0200
From: Jan Kiszka <jan.kiszka@web.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.4.x: i386/x86_64 bitops clobberings
References: <452970AF.8020605@web.de> <20061008224440.GA30172@1wt.eu> <45298184.1050006@web.de> <20061008233617.GA30255@1wt.eu> <4529EBEA.4070602@web.de> <20061014195005.GA2900@1wt.eu>
In-Reply-To: <20061014195005.GA2900@1wt.eu>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3CBA3E9B33E6CA7EFBD1FB9B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3CBA3E9B33E6CA7EFBD1FB9B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Willy Tarreau wrote:
> ...
> I have searched the archives for previous occurrences of this recurring=

> problem, and found another alternative which is said to work on all gcc=

> versions. So here's the patch for both x86 and x86_64. I checked that i=
t
> produces identical code as I obtain with the patch from 2.6. It also
> fixes your testcase for gcc-2.95 to 4.1.1.
>=20
> Could you please give it a try ?

Works fine here as well. Merging it would be welcome.

Thanks a lot,
Jan


--------------enig3CBA3E9B33E6CA7EFBD1FB9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFMgXsniDOoMHTA+kRAqaAAJ9rDtGXUQQpEQeuPQs2gIMubSxMQgCdGV0Q
9DDziIv1E27VllvnQcAbiyM=
=bDQJ
-----END PGP SIGNATURE-----

--------------enig3CBA3E9B33E6CA7EFBD1FB9B--
