Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266874AbUG1Lff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266874AbUG1Lff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 07:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUG1Lff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 07:35:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23249 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266874AbUG1Lfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 07:35:33 -0400
Subject: Re: [PATCH] fix zlib debug in ppc boot header
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040728112222.GA7670@suse.de>
References: <20040728112222.GA7670@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qAhk6h5oOqmu39tyaqJ8"
Organization: Red Hat UK
Message-Id: <1091014495.2795.25.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Jul 2004 13:34:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qAhk6h5oOqmu39tyaqJ8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-07-28 at 13:22, Olaf Hering wrote:
> The ppc bootloader code will not compile with zlib debug enabled.
> printf was not defined. Tested with vmlinux.coff
> This patch was sent out earlier. Appearently it is not possible
> to use the generic zlib copy in linux/lib

actually it should be possible. Ok so it needs to be compiled as 32 bit,
but surely just #include-ing the /linux/lib version, or even better, a
few Makefile tricks should allow that, right ?

--=-qAhk6h5oOqmu39tyaqJ8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBB49fxULwo51rQBIRAjBtAJ0Umc6R3r+B+tvx8arx3+Z8E+PtaACffBYb
/CbT/UMc4ArTsWgjlkCR7rk=
=9Q1X
-----END PGP SIGNATURE-----

--=-qAhk6h5oOqmu39tyaqJ8--

