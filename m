Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbUDPUDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUDPUDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:03:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63117 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263605AbUDPUDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:03:05 -0400
Subject: Re: How to make stack executable on demand?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040416170915.GA20260@lucon.org>
References: <20040416170915.GA20260@lucon.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BGwW+d37bUBnoXrSlyQm"
Organization: Red Hat UK
Message-Id: <1082145778.9600.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 16 Apr 2004 22:02:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BGwW+d37bUBnoXrSlyQm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

>  But it will either fail if
> kernel is set with non-executable stack,

eh no. mprotect with prot_exec is still supposed to work. The stacks
still have MAY_EXEC attribute, just not the actual EXEC attribute

--=-BGwW+d37bUBnoXrSlyQm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAgDvyxULwo51rQBIRAvitAJwISfVxBO02twtlzlkYyAWfLq3IBACeIpsp
wC4RnfkZ1w5ThqBQMTKDUyA=
=svk/
-----END PGP SIGNATURE-----

--=-BGwW+d37bUBnoXrSlyQm--

