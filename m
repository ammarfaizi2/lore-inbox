Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269116AbUIHLYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269116AbUIHLYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269117AbUIHLYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:24:45 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:11166 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S269116AbUIHLYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:24:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Remove syscall declarations from linux/key.h
Date: Wed, 8 Sep 2004 13:23:40 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Simon Derr <simon.derr@bull.net>,
       linux-kernel@vger.kernel.org
References: <20040908014735.7a2058dc.akpm@osdl.org> <Pine.LNX.4.58.0409071415380.10577@daphne.frec.bull.fr> <1070.1094635831@redhat.com>
In-Reply-To: <1070.1094635831@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_AvuPBQkpw9R0IYC";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409081323.45105.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_AvuPBQkpw9R0IYC
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mittwoch, 8. September 2004 11:30, David Howells wrote:
>=20
> The attached patch removes the syscall declarations from linux/key.h as
> they're not really necessary - only entry.S should be calling them.

Actually, you should put those declarations into include/linux/syscalls.h,
where all other declarations for system calls are located. The macros
should just be left out.

	Arnd <><

--Boundary-02=_AvuPBQkpw9R0IYC
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPuvA5t5GS2LDRf4RAnkhAJ9/I+m1FPw94udF/++R8asmf+xS0wCeMq8f
TeMeg3BFgk2YLnvq3sEho0U=
=t9RL
-----END PGP SIGNATURE-----

--Boundary-02=_AvuPBQkpw9R0IYC--
