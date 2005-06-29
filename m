Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVF2BuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVF2BuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVF2BoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:44:15 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:46553 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S262283AbVF2Big (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:38:36 -0400
Subject: Re: [openib-general] Re: [PATCH 05/16] IB uverbs: core
	implementation
From: Tom Duffy <tduffy@sun.com>
To: Greg KH <greg@kroah.com>
Cc: Roland Dreier <rolandd@cisco.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20050629002709.GB17805@kroah.com>
References: <2005628163.lUk0bfpO8VsSXUh5@cisco.com>
	 <2005628163.jfSiMqRcI78iLMJP@cisco.com>  <20050629002709.GB17805@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wqoaIbzmOCtf5B64eUBk"
Date: Tue, 28 Jun 2005 18:38:15 -0700
Message-Id: <1120009095.31370.30.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wqoaIbzmOCtf5B64eUBk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-28 at 17:27 -0700, Greg KH wrote:
> Ok, I've complained about this before, but due to the fact that you are
> calling EXPORT_SYMBOL_GPL() only functions in this code, the ability for
> it for someone to use the BSD license on it in the future, is pretty
> much impossible, right?

No, only to call these functions from BSD-only (or other licensed)
modules.

> Wasn't the openib group going to drop this horrible license, or are they
> still insisting on porting this to other operating systems?

I don't think we need to drop this license.  What is the harm?

At some point, Sun may want OpenSolaris to use OpenIB.  Or what if the
Darwin folks decide to create a port?

Don't worry: the OpenIB Windows work is done in a completely different
repository with a completely different code base because Microsoft was
scared of code that ever *was* GPL, even if a BSD-only fork was created.

The bylaws of OpenIB.org require that all code hosted and developed
under our auspices be (at least) BSD.  I don't want it to happen, but if
the code in Linux chooses one license (GPL) and not both, then we won't
be able to accept patches back that come in through the mainline kernel.

-tduffy

--=-wqoaIbzmOCtf5B64eUBk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCwfuHdY502zjzwbwRAv+oAJ9O1It8f1K+2B+d/OWXto+6s3dhZQCffmmd
FxWQ+VS8UMJxtcazWAUYick=
=tDIF
-----END PGP SIGNATURE-----

--=-wqoaIbzmOCtf5B64eUBk--
