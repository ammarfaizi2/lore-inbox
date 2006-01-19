Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWASGR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWASGR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWASGR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:17:27 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:35523 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932554AbWASGR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:17:27 -0500
Date: Thu, 19 Jan 2006 17:17:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
 removed from -mm tree
Message-Id: <20060119171708.7f856b42.sfr@canb.auug.org.au>
In-Reply-To: <1137648119.30084.94.camel@localhost.localdomain>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	<1137648119.30084.94.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__19_Jan_2006_17_17_08_+1100_1q=+sW=a5xpamGbz"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__19_Jan_2006_17_17_08_+1100_1q=+sW=a5xpamGbz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Thu, 19 Jan 2006 16:21:59 +1100 David Woodhouse <dwmw2@infradead.org> wr=
ote:
>
> On Wed, 2006-01-18 at 16:52 -0800, akpm@osdl.org wrote:
> > -                       memcpy(&current->saved_sigmask, &sigsaved, size=
of(sigsaved));
> > +                       memcpy(&current->saved_sigmask, &sigsaved,
> > +                                       sizeof(sigsaved));
>=20
> I still object to this.
>=20
> You justified it on the basis that some people have editors which will
> wrap the original version onto a second line and make it look ugly...
> yet your 'fix' is to wrap it onto a second line and make it look ugly
> for _all_ of us, not just for those using crap editors. I really don't
> see the overall benefit.

Documentation/CodingStyle says:

The limit on the length of lines is 80 columns and this is a hard limit.

Statements longer than 80 columns will be broken into sensible chunks.
Descendants are always substantially shorter than the parent and are placed
substantially to the right. The same applies to function headers with a long
argument list. Long strings are as well broken into shorter strings.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__19_Jan_2006_17_17_08_+1100_1q=+sW=a5xpamGbz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDzy7rFdBgD/zoJvwRAqRYAJ9laWQWLKMy7dkPKxYmTbRFyd2rbQCcDz15
kKFW/qbPPThpvVXdzdoCzeI=
=zgUE
-----END PGP SIGNATURE-----

--Signature=_Thu__19_Jan_2006_17_17_08_+1100_1q=+sW=a5xpamGbz--
