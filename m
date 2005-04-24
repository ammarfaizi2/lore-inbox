Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVDXPki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVDXPki (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 11:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVDXPki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 11:40:38 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:65416 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262344AbVDXPkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 11:40:32 -0400
Date: Sun, 24 Apr 2005 10:40:22 -0500
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: Ravi Poddar <ravi@dacodecz.homelinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: error reading following proc files ....
Message-Id: <20050424104022.02a75869.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <426BB912.6080801@dacodecz.homelinux.org>
References: <426BB912.6080801@dacodecz.homelinux.org>
X-Mailer: Sylpheed version 1.9.9+svn (GTK+ 2.6.4; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__24_Apr_2005_10_40_22_-0500_gRplUyg7qLxzRwk."
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__24_Apr_2005_10_40_22_-0500_gRplUyg7qLxzRwk.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Uttered Ravi Poddar <ravi@dacodecz.homelinux.org>, spake thus:

> I got following errors while doing
> ravi@dacodecz:~ # cat /proc/sys/fs/binfmt_misc/register
> cat: /proc/sys/fs/binfmt_misc/register: Invalid argument

Try doing a:

$ ls /proc/sys/fs/binfmt_misc/register

and notice there is no read(2) method implemented.

Cheers

--Signature=_Sun__24_Apr_2005_10_40_22_-0500_gRplUyg7qLxzRwk.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCa73q/0ydqkQDlQERAi5AAJ0dPp5iwV35+pLllZS9ttwagJaMIQCgkT0X
CI9Kx1ACpCttUjwOeXZXoDY=
=Whg/
-----END PGP SIGNATURE-----

--Signature=_Sun__24_Apr_2005_10_40_22_-0500_gRplUyg7qLxzRwk.--
