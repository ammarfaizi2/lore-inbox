Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVCBRDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVCBRDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVCBRBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:01:50 -0500
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:12212 "EHLO
	imf24aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262360AbVCBQ7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:59:17 -0500
Date: Wed, 2 Mar 2005 10:58:49 -0600
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Subject: Re: compilation problem of modules
Message-Id: <20050302105849.1423f7f7.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <4225EBD4.8090302@osdl.org>
References: <20050302145907.17666.qmail@web53306.mail.yahoo.com>
	<4225EBD4.8090302@osdl.org>
X-Mailer: Sylpheed version 1.9.4 (GTK+ 2.4.14; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__2_Mar_2005_10_58_49_-0600_UgiVMaugjnJFKVJk"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__2_Mar_2005_10_58_49_-0600_UgiVMaugjnJFKVJk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Uttered "Randy.Dunlap" <rddunlap@osdl.org>, spake thus:

> compile/build is wrong.
> a minimum 2.4 kernel build needs at least:
>=20
> gcc -c -D__KERNEL__ -DMODULE -O2 -nostdinc proc.c

Don't forget the kernel headers!

# gcc -c -D__KERNEL__ -DMODULE -O2 -I/usr/src/linux/include -nostdinc proc.c

and, if you have module symbol versioning turned on, you'll need still more!

--Signature=_Wed__2_Mar_2005_10_58_49_-0600_UgiVMaugjnJFKVJk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCJfDN/0ydqkQDlQERAsBZAJ41pHl9ipogZjotNePgCq9GFFX5rQCeMTZ1
2jnibU3pUQhYuMz8mxV80eQ=
=oWYL
-----END PGP SIGNATURE-----

--Signature=_Wed__2_Mar_2005_10_58_49_-0600_UgiVMaugjnJFKVJk--
