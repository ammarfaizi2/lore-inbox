Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265639AbUFCQXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbUFCQXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUFCQXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:23:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14770 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265639AbUFCQXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:23:05 -0400
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
	2.6.7-rc2-bk2
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Gerhard Mack <gmack@innerfire.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
In-Reply-To: <Pine.LNX.4.58.0406031031480.14817@innerfire.net>
References: <20040602205025.GA21555@elte.hu>
	 <Pine.LNX.4.58.0406031031480.14817@innerfire.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ggoJnIqgl02oXsC1s9kr"
Organization: Red Hat UK
Message-Id: <1086279741.2709.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Jun 2004 18:22:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ggoJnIqgl02oXsC1s9kr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-06-03 at 16:36, Gerhard Mack wrote:
> >  kernel tried to access NX-protected page - exploit attempt? (uid: 500)
> >  Unable to handle kernel paging request at virtual address f78d0f40
> >   printing eip:
> >  ...
>=20
> Just a small nitpick...
>=20
> Can you please drop the "- exploit attempt" from the error?  Buffer
> overflows aren't always exploits.

buffer overflows that then also execute code are pretty much always
exploits tho ;)


--=-ggoJnIqgl02oXsC1s9kr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAv1A9xULwo51rQBIRAmu5AJ4ly2uV0aXGpPMOlmJskylSCAdklgCeKsLR
IXIgfA99X10YG/HI3zRCTmg=
=474N
-----END PGP SIGNATURE-----

--=-ggoJnIqgl02oXsC1s9kr--

