Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVLUQoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVLUQoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVLUQoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:44:00 -0500
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:28772 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1751135AbVLUQn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:43:59 -0500
Date: Wed, 21 Dec 2005 10:43:21 -0600
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: vfat question
Message-Id: <20051221104321.1d02ca43.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <43A981FD.5030202@scienion.de>
References: <200512211602.jBLG2QKM003368@laptop11.inf.utfsm.cl>
	<43A981FD.5030202@scienion.de>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.6.10; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__21_Dec_2005_10_43_21_-0600_DEQx+zvzQnbX8OI7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__21_Dec_2005_10_43_21_-0600_DEQx+zvzQnbX8OI7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Uttered Sebastian Kloska <kloska@scienion.de>, spake thus:

Please do not set the reply-to: mail header when sending to a mailing
list.  Thanks.

>  I have to admit I do not even have a clue how to get access to
>  the directory table of a mounted vfat device. The whole idea
>  is for manipulating the ordering of mp3-players which
>  (on some devices) seems to dictate the play order.
>  So if someone could point me to a good documentation
>  I would appreciate it.

Accessing a mounted VFAT for this is probably not a good idea.

However, a userland solution should be possible and much easier than
trying this from the kernel.

Look at the mtools package:

	http://www.gnu.org/software/mtools/mtools.html

where you should find tools that do such access already.  Then, start
hacking the mdir(1) tool, or some such, to sort the VFAT orders
however you like them.

Cheers

--Signature=_Wed__21_Dec_2005_10_43_21_-0600_DEQx+zvzQnbX8OI7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDqYYt/0ydqkQDlQERAmvMAJ93s10vnMWASGfwuH2gtnCuob38YQCbBQtz
rWTdc+T6Afd/uGs08IZrrHk=
=Tp+a
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Dec_2005_10_43_21_-0600_DEQx+zvzQnbX8OI7--
