Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263904AbUEMHm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbUEMHm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUEMHm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:42:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47749 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263881AbUEMHm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:42:56 -0400
Subject: Re: [2.6 patch] fix aic7xxx_old.c for !PCI
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040512235555.GF21408@fs.tum.de>
References: <20040512235555.GF21408@fs.tum.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7SNQo3iRIcbNGT+8tjGU"
Organization: Red Hat UK
Message-Id: <1084434113.2781.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 May 2004 09:41:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7SNQo3iRIcbNGT+8tjGU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-05-13 at 01:55, Adrian Bunk wrote:
> I got the following compile error in 2.6.6-mm1 (but it's not specific to=20
> -mm) with CONFIG_PCI=3Dn:

or how about just providing a dummy pci_release_regions() for the !PCI
case ?

--=-7SNQo3iRIcbNGT+8tjGU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQBAoybAxULwo51rQBIRAjHOAJiUaMAFy6/lSgpzUbNrPOdJBGGZAJ9jWTVr
A3qu5QSQ+q33oEZiMBJZgQ==
=uzO8
-----END PGP SIGNATURE-----

--=-7SNQo3iRIcbNGT+8tjGU--

