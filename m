Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266614AbUF3Lct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266614AbUF3Lct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 07:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUF3Lct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 07:32:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25556 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266614AbUF3Lcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 07:32:47 -0400
Subject: Re: new memory hotremoval patch
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       linux-mm@kvack.org
In-Reply-To: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
References: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0v1/FJWE/MWwdP1vqZG+"
Organization: Red Hat UK
Message-Id: <1088595151.2706.12.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 30 Jun 2004 13:32:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0v1/FJWE/MWwdP1vqZG+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Page "remapping" is a mechanism to free a specified page by copying the
> page content to a newly allocated replacement page and redirecting
> references to the original page to the new page.
> This was designed to reliably free specified pages, unlike the swapout
> code.

are you 100% sure the locking is correct wrt O_DIRECT, AIO or futexes ??


--=-0v1/FJWE/MWwdP1vqZG+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA4qTPxULwo51rQBIRApJqAJ40LzBUizm4uVJAu+Um8as+ZwdLbgCfSvJR
/7dzXywO0tHE+CVP51GwdTg=
=USTE
-----END PGP SIGNATURE-----

--=-0v1/FJWE/MWwdP1vqZG+--

