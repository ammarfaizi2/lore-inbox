Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263827AbUFXGSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUFXGSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 02:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUFXGSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 02:18:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1995 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263827AbUFXGSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 02:18:33 -0400
Subject: Re: 32-bit dma allocations on 64-bit platforms
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, discuss@x86-64.org, tiwai@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <m38yee6j7s.fsf@averell.firstfloor.org>
References: <2akPm-16l-65@gated-at.bofh.it>
	 <m38yee6j7s.fsf@averell.firstfloor.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-llpTTVzuNiRpLeS5TyTt"
Organization: Red Hat UK
Message-Id: <1088057885.2806.16.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 24 Jun 2004 08:18:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-llpTTVzuNiRpLeS5TyTt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-06-23 at 23:46, Andi Kleen wrote:

> The VM should be able to handle this, but it may still require
> some tuning. It would need some generic changes, but not too bad.
> Still would need a decision on how big GFP_BIGDMA should be.=20
> I suspect 4GB would be too big again.

What is the problem again, can't the driver us the dynamic pci mapping
API which does allow more memory to be mapped even on crippled machines
without iommu ?
And isn't this a problem that will vanish since PCI Express and PCI X
both *require* support for 64 bit addressing, so all higher speed cards
are going to be ok in principle ?


--=-llpTTVzuNiRpLeS5TyTt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2nIdxULwo51rQBIRAn4nAKCbKW5ADlObwIS/TRXH5zkg70QoQwCgofEv
j9DNUvQK7/BusFVzkhTcs2E=
=GuCI
-----END PGP SIGNATURE-----

--=-llpTTVzuNiRpLeS5TyTt--

