Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUEQPky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUEQPky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUEQPky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:40:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36050 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261638AbUEQPkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:40:52 -0400
Subject: Re: 1352 NUL bytes at the end of a page?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Wayne Scott <wscott@bitmover.com>,
       akpm@osdl.org, elenstev@mesatop.com, lm@bitmover.com,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org>
References: <200405162136.24441.elenstev@mesatop.com>
	 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
	 <20040516231120.405a0d14.akpm@osdl.org>
	 <20040517.085640.30175416.wscott@bitmover.com>
	 <20040517151738.GA4730@thunk.org>
	 <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4LWhxcX1iKH+Nnf7jWid"
Organization: Red Hat UK
Message-Id: <1084808421.7410.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 May 2004 17:40:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4LWhxcX1iKH+Nnf7jWid
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


>=20
> Who came up with that braindead idea? Is it some crazed Mach developer=20
> that infiltrated the glibc development=20

afaik it's optional and off by default, for reads it sort of kinda makes
sense but it can't be on by default otherwise a truncate would cause
fscanf() to throw a sigbus, that's not legal posix wise.


--=-4LWhxcX1iKH+Nnf7jWid
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAqNzlxULwo51rQBIRAgPmAKCGx9yH1obhUGM6irZWIqlISlvPCwCfeC2X
6UmL/rWN2kCFGi5jF3ELAa0=
=yS8A
-----END PGP SIGNATURE-----

--=-4LWhxcX1iKH+Nnf7jWid--

