Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262917AbUJ0WgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbUJ0WgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUJ0Wc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:32:59 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:55942 "EHLO
	ash.lnxi.com") by vger.kernel.org with ESMTP id S262934AbUJ0Wbl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:31:41 -0400
Subject: Re: [PATCH] Remove some divide instructions
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org,
       george@mvista.com
In-Reply-To: <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
References: <417FC982.7070602@vmware.com>
	 <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1UesQYTiCs2WS/M8ydsw"
Organization: Linux Networx
Date: Wed, 27 Oct 2004 16:08:49 -0600
Message-Id: <1098914929.1432.29.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1UesQYTiCs2WS/M8ydsw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-10-27 at 09:28 -0700, Linus Torvalds wrote:

> It's very easy to test for powers of two: !((x) & ((x)-1)) does it for=20
> everything but zero, and zero in this case is an error anyway.

Of course 0 is not a power of two - nor a power of any other number
(although n**(-oo) where |n|>1 and n**(oo) where |n|<1 are close).

8)

--=20
Thayne Harbaugh
Linux Networx

--=-1UesQYTiCs2WS/M8ydsw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBgBxxsYFQl3A+qS0RAmmDAKC16NdsJ3rUXxQLYrG8gUrt+LNmQACguLU4
6eswKSqMfDYKAP4GLJPxNrI=
=dSqx
-----END PGP SIGNATURE-----

--=-1UesQYTiCs2WS/M8ydsw--

