Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVIGPLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVIGPLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVIGPLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:11:09 -0400
Received: from ms-smtp-02-lbl.southeast.rr.com ([24.25.9.101]:58556 "EHLO
	ms-smtp-02-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S932162AbVIGPLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 11:11:07 -0400
Subject: Re: [ck] 2.6.13-ck2
From: Adam Petaccia <adam@tpetaccia.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
In-Reply-To: <200509072041.40153.kernel@kolivas.org>
References: <200509052344.11665.kernel@kolivas.org>
	 <1126031157.8117.5.camel@pimpmobile>
	 <200509072041.40153.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LCMxMBd9HG8RVtsN2oD0"
Date: Wed, 07 Sep 2005 11:10:37 -0400
Message-Id: <1126105837.15208.1.camel@pimpmobile>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LCMxMBd9HG8RVtsN2oD0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-09-07 at 20:41 +1000, Con Kolivas wrote:
> On Wed, 7 Sep 2005 04:25, Adam Petaccia wrote:
> > I think this patch is missing an IFDEF or something (I'm not really a
> > programmer, I just like to pretend).  Anyway, I've tried building -ck2
> > without swap enabled, and it failed.  Just to make sure, I make'd
> > distclean, and I get the following:
> >
> >   LD      .tmp_vmlinux1
> > mm/built-in.o: In function `zone_watermark_ok':
> > mm/page_alloc.c:763: undefined reference to `delay_prefetch'
> > mm/built-in.o: In function `swap_setup':
> > mm/swap.c:485: undefined reference to `prepare_prefetch'
> > make: *** [.tmp_vmlinux1] Error 1
>=20
> Bad layout on my part.
>=20
> Try this patch on top.
>=20
> Cheers,
> Con
Weee, kernel compiles now.  Thanks con.

--=20
Adam Petaccia <adam@tpetaccia.com>

--=-LCMxMBd9HG8RVtsN2oD0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDHwLtBIvjQglsR2ARAlYpAJ4/5X4DqeS4aZZkFp4EW6PmsGeSfgCfboms
RLJYpFE4AEnlF2uXFGdLsIg=
=1dPh
-----END PGP SIGNATURE-----

--=-LCMxMBd9HG8RVtsN2oD0--

