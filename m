Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVCXThE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVCXThE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVCXThE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:37:04 -0500
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:54770 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261708AbVCXTg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:36:56 -0500
Date: Thu, 24 Mar 2005 13:36:28 -0600
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
Message-Id: <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
	<Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost>
	<200503231740.09572.maillist@zuco.org>
	<Pine.LNX.4.61.0503231829570.1481@yvahk01.tjqt.qr>
	<20050323174925.GA3272@zero>
	<Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
X-Mailer: Sylpheed version 1.9.6+svn (GTK+ 2.4.14; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__24_Mar_2005_13_36_28_-0600_bTsZiT/H=K9QD76t"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__24_Mar_2005_13_36_28_-0600_bTsZiT/H=K9QD76t
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Uttered Geert Uytterhoeven <geert@linux-m68k.org>, spake thus:

> > There's probably a number of apps that skip the first two dirents, inst=
ead
> > of checking for the dot dirs.
>=20
> Yep, check `-noleaf' in find(1)

Then it is broken in several ways. =20

First, file systems are not required to implement ".." (only "." is
magical, ".." is a courtesy). =20

Second, skipping the first two entries carries an implied assumtion
about the file name sorting order that is not portable in a
non-US-ASCII world.

Cheers

--Signature=_Thu__24_Mar_2005_13_36_28_-0600_bTsZiT/H=K9QD76t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCQxa//0ydqkQDlQERAg0ZAJ4uZgK1JXiROzKsXfgd+sCYbqvjdQCg28aU
l9Q0PSRz0+8koNpEnmM4p8U=
=5FyD
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Mar_2005_13_36_28_-0600_bTsZiT/H=K9QD76t--
