Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268254AbUIGSVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268254AbUIGSVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUIGSUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:20:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56297 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268368AbUIGSSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:18:53 -0400
Subject: Re: [PATCH] unexport do_execve/do_select
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1094576549.9599.2.camel@localhost.localdomain>
References: <20040907150028.GA9235@lst.de>
	 <1094576549.9599.2.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a9iQEqvE8ercy9tdgn1L"
Organization: Red Hat UK
Message-Id: <1094581121.2801.19.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 20:18:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a9iQEqvE8ercy9tdgn1L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-07 at 19:02, Alan Cox wrote:
> On Maw, 2004-09-07 at 16:00, Christoph Hellwig wrote:
> > These are basically shared code for native/32bit compat code, but as
> > CONFIG_COMPAT is a bool there's no need to export them.
>=20
> do_select at least used to be used by the xABI compatibility modules, is
> that no longer the case ?

I thought those no longer existed; lots of other stuff is missing for
those as well for sure.

--=-a9iQEqvE8ercy9tdgn1L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPfuBxULwo51rQBIRAjnjAJsHYTHuLbe1X2V9Gm6XTy8d4ZEMmgCgm9GJ
6kyjXAGXzshgIUcw1rRiP/g=
=D1sY
-----END PGP SIGNATURE-----

--=-a9iQEqvE8ercy9tdgn1L--

