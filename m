Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbUK1NqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbUK1NqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 08:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUK1NqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 08:46:14 -0500
Received: from natmwynyy.rzone.de ([81.169.145.169]:22508 "EHLO
	natmwynyy.rzone.de") by vger.kernel.org with ESMTP id S261475AbUK1NqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 08:46:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Sun, 28 Nov 2004 14:40:00 +0100
User-Agent: KMail/1.6.2
Cc: Sam Ravnborg <sam@ravnborg.org>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       dwmw2@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, ak@muc.de
References: <19865.1101395592@redhat.com> <200411280021.51574.arnd@arndb.de> <41A9D1A4.8090805@domdv.de>
In-Reply-To: <41A9D1A4.8090805@domdv.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_wUdqB8w9RAFmrcS";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200411281440.00661.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_wUdqB8w9RAFmrcS
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 28 November 2004 14:24, Andreas Steinmetz wrote:
> > I think we can get rid of this hack when we move to split kernel header=
s.
> > parisc, s390 and mips already have combined headers, and it should not =
be
> > too hard to combine the user ABI headers for sparc, ppc and x86_64 as w=
ell,
> > without having to merge the complete architecture and kernel header tre=
es
> > for them.
> >=20
>=20
> If you can produce merged x86/x86_64 ABI headers this would be a nice=20
> solution.

I can do that (and the same for ppc/ppc64) as soon as we have
a) A patch that first splits out the ABI headers for i386
b) persuaded ak that he will look at what I come up with

	Arnd <><

--Boundary-02=_wUdqB8w9RAFmrcS
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBqdUw5t5GS2LDRf4RAuRmAKCR0GIuuiQV3ZzVW64WuibL8qZfzACfWOct
Ie8lm0wJDhbRmfQVxvKHMzg=
=U15O
-----END PGP SIGNATURE-----

--Boundary-02=_wUdqB8w9RAFmrcS--
