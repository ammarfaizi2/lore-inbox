Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267589AbUG2QSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267589AbUG2QSD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUG2QR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:17:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41619 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267482AbUG2QQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:16:32 -0400
Subject: Re: [PATCH 20/22] AIO poll
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Avi Kivity <avi@exanet.com>
Cc: jmoyer@redhat.com, suparna@in.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, linux-osdl@osdl.org
In-Reply-To: <41091FAA.6080409@exanet.com>
References: <20040702130030.GA4256@in.ibm.com>
	 <20040702163946.GJ3450@in.ibm.com>
	 <16649.5485.651481.534569@segfault.boston.redhat.com>
	 <41091FAA.6080409@exanet.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Sj2FQwNfcHD+EiPFDYFX"
Organization: Red Hat UK
Message-Id: <1091117766.2792.14.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 18:16:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Sj2FQwNfcHD+EiPFDYFX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-29 at 18:02, Avi Kivity wrote:
> Jeff Moyer wrote:
>=20
> >What are the barriers to getting the AIO poll support into the kernel?  =
I
> >think if we have AIO support at all, it makes sense to add this.
> > =20
> >
> I second the motion. I don't see how one can write a server which uses=20
> both networking and block aio without aio poll.

one could try to use epoll and fix it to be usable for disk io too ;)

--=-Sj2FQwNfcHD+EiPFDYFX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBCSLGxULwo51rQBIRAszxAJ9NmANR1mLCC0xTHRICTqN4yej0dgCeJgZ5
FzQIrGDnWVuFM+Y7XOXn2XA=
=81yu
-----END PGP SIGNATURE-----

--=-Sj2FQwNfcHD+EiPFDYFX--

