Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVDAClo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVDAClo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 21:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVDAClo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 21:41:44 -0500
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:33016 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262353AbVDACll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 21:41:41 -0500
Date: Thu, 31 Mar 2005 20:41:35 -0600
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Subject: Re: connector.c
Message-Id: <20050331204135.30270c78.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <20050331173026.3de81a05.akpm@osdl.org>
References: <20050331173026.3de81a05.akpm@osdl.org>
X-Mailer: Sylpheed version 1.9.7+svn (GTK+ 2.6.4; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__31_Mar_2005_20_41_35_-0600_/7lnhR5p8dszPb8W"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__31_Mar_2005_20_41_35_-0600_/7lnhR5p8dszPb8W
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Uttered Andrew Morton <akpm@osdl.org>, spake thus:

> > 	if (uskb) {
> > 		netlink_unicast(dev->nls, uskb, 0, 0);
> > 	}
>=20
> Unneeded {}

Speaking strictly as a language lawyer, they are not needed.

However, for maintainability (and best practices) they are essential.
They make the scope of the test explicit and ensure that a one-line-
change really doesn't affect more lines that needed.  Think context
diffs here.

Cheers!

--Signature=_Thu__31_Mar_2005_20_41_35_-0600_/7lnhR5p8dszPb8W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCTLTk/0ydqkQDlQERAodbAKCsrOz9i13WCMlYu+G78hTFagZ7bACfUqvw
khJ2wA4F4aiqQnukIvE2lDw=
=/uO2
-----END PGP SIGNATURE-----

--Signature=_Thu__31_Mar_2005_20_41_35_-0600_/7lnhR5p8dszPb8W--
