Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267436AbUG2KHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267436AbUG2KHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 06:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUG2KHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 06:07:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5034 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267436AbUG2KFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 06:05:09 -0400
Subject: Re: LSI 53c1030 (Fusion MPT) performance with O_SYNC
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jan Oravec <jan.oravec@6com.sk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040729095648.GA27925@omega.6com.net>
References: <20040729095648.GA27925@omega.6com.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Fof5LG8+0hok4uVO4fOf"
Organization: Red Hat UK
Message-Id: <1091095493.2792.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 12:04:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Fof5LG8+0hok4uVO4fOf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-29 at 11:56, Jan Oravec wrote:

> I've noticed poor performance with MySQL/InnoDB when compared to another
> S2880-based box with IDE disks.

your ide disk probably has write back caching enabled while your
mptfusion doesn't..... if you value data integrity over performance the
mptfusion has a saner default ;)

--=-Fof5LG8+0hok4uVO4fOf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBCMvFxULwo51rQBIRAvpYAJwKpUhc4VsWXFJWLDNRFHawPslFagCfQirS
R2hPGciXab+QA3OMMUk5J+Y=
=f2+X
-----END PGP SIGNATURE-----

--=-Fof5LG8+0hok4uVO4fOf--

