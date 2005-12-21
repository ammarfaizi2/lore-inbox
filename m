Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVLUAA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVLUAA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 19:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVLUAA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 19:00:28 -0500
Received: from mx.pathscale.com ([64.160.42.68]:446 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932225AbVLUAA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 19:00:27 -0500
Subject: Re: [PATCH 08/13]  [RFC] ipath core last bit
From: Robert Walsh <rjwalsh@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051217123856.d16529a5.akpm@osdl.org>
References: <200512161548.3fqe3fMerrheBMdX@cisco.com>
	 <200512161548.y9KRuNtfMzpZjwni@cisco.com>
	 <20051217123856.d16529a5.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/zwJby5IkCVp2IPs6xnB"
Date: Tue, 20 Dec 2005 16:00:16 -0800
Message-Id: <1135123216.13875.5.camel@hematite.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/zwJby5IkCVp2IPs6xnB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-12-17 at 12:38 -0800, Andrew Morton wrote:
> Roland Dreier <rolandd@cisco.com> wrote:
> >
> > +EXPORT_SYMBOL(ipath_kset_linkstate);
> > +EXPORT_SYMBOL(ipath_kset_mtu);
> > +EXPORT_SYMBOL(ipath_layer_close);
> > +EXPORT_SYMBOL(ipath_layer_get_bcast);
> > +EXPORT_SYMBOL(ipath_layer_get_cr_errpkey);
> > +EXPORT_SYMBOL(ipath_layer_get_deviceid);
> > +EXPORT_SYMBOL(ipath_layer_get_flags);
> > +EXPORT_SYMBOL(ipath_layer_get_guid);
> > +EXPORT_SYMBOL(ipath_layer_get_ibmtu);
> > etc
>=20
> EXPORT_SMBOL_GPL?

Hmm, well, nothing else in the infiniband directory uses this, probably
because of the dual GPL/BSD license that all files in there have.  For
consistency, I'll leave it as EXPORT_SYMBOL, but I don't have any real
problems with it either way.

Regards,
 Robert.

--=20
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043

--=-/zwJby5IkCVp2IPs6xnB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iQEVAwUAQ6ibEPzvnpzTd9fxAQIVFQf/byTjgq6aS2ABWDOHPX9Z/NnuNg4sP0bn
4j/S4lBy/Csj3DYfdXezf+wI2zxwQmNaENbKxLzLlrY+dnH96IXqJTVXaGhj0ks5
CvwW+6PiRNDJi2gwq9OhSBfVDW50i0cZ8gemgOOnCWzPSydU9PD2cLDBcTsmIdBM
UfCPe3iXHWGcgTLdn0gDjihH84YxTLi+M0oocfGq/pX1fmCr4cucjJD4KV81mJan
D71h+wauR/ksUkhafJP0K5a3B0Hf96isAZoZpa/Wdb+hH4UK5pTZyDBgZsOSgXHv
5/sLHVX8qphMC4j6NIH+J2JBp+tUQ+7Mz2MfVv/dLJLydiJ3bZZKtA==
=UO+G
-----END PGP SIGNATURE-----

--=-/zwJby5IkCVp2IPs6xnB--

