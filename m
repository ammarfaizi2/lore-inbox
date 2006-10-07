Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWJGQan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWJGQan (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 12:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWJGQan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 12:30:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8650 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750701AbWJGQam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 12:30:42 -0400
Message-ID: <4527D64A.7060002@redhat.com>
Date: Sat, 07 Oct 2006 09:31:06 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [patch] honour MNT_NOEXEC for access()
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru>	 <1159899820.2891.542.camel@laptopd505.fenrus.org>	 <4522AEA1.5060304@aknet.ru>	 <1159900934.2891.548.camel@laptopd505.fenrus.org>	 <4522B4F9.8000301@aknet.ru>	 <20061003210037.GO20982@devserv.devel.redhat.com>	 <45240640.4070104@aknet.ru>  <45269BEE.7050008@aknet.ru> <1160170464.12835.4.camel@localhost.localdomain> <4526C7F4.6090706@redhat.com> <45278D2A.4020605@aknet.ru>
In-Reply-To: <45278D2A.4020605@aknet.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC3E9219E6CCC75D1A87C598B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC3E9219E6CCC75D1A87C598B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Stas Sergeev wrote:
> Now, as the access(X_OK) is fixed, would it be
> feasible for ld.so to start using it?

Just must be kidding.  No access control can be reliably implemented at
userlevel.  There is no point starting something as stupid as this.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigC3E9219E6CCC75D1A87C598B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFJ9ZK2ijCOnn/RHQRAmuOAJ99mUTPfJnV1avBOXAuE9jUFHtRMQCfQp+H
i36qvTmaE1S2k2ysSH9uBJo=
=0ULK
-----END PGP SIGNATURE-----

--------------enigC3E9219E6CCC75D1A87C598B--
