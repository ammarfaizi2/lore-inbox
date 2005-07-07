Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVGGMzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVGGMzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVGGMzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:55:24 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:4065 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261417AbVGGMxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:53:37 -0400
Date: Thu, 7 Jul 2005 22:53:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: avi@argo.co.il, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Hugepage COW
Message-Id: <20050707225325.082ced8f.sfr@canb.auug.org.au>
In-Reply-To: <20050707092425.GA10044@localhost.localdomain>
References: <20050707055554.GC11246@localhost.localdomain>
	<1120718967.2989.7.camel@blast.q>
	<20050707092425.GA10044@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__7_Jul_2005_22_53_25_+1000_xWcCEcc37x+HWdrA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__7_Jul_2005_22_53_25_+1000_xWcCEcc37x+HWdrA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Jul 2005 19:24:25 +1000 David Gibson <david@gibson.dropbear.id.au=
> wrote:
>
> That's not necessarily possible.  On some archs - ppc64 for one -
> the mmu has to be set up for hugepages on a granularity greater than
> the hugepage size.  So you can just arbitrarily substitute normal
                             ^^^
presumably you meant "cannot"

> pages for hugepages.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__7_Jul_2005_22_53_25_+1000_xWcCEcc37x+HWdrA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCzSXMFdBgD/zoJvwRAiQMAJ9JTW/CILYiQII/TdbsId9pMntOeQCeL9Kd
2wU8RDiNtzbcp5FBa7KcUZs=
=jQID
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Jul_2005_22_53_25_+1000_xWcCEcc37x+HWdrA--
