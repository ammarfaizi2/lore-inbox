Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVCOIMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVCOIMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 03:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVCOIMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 03:12:48 -0500
Received: from h80ad2575.async.vt.edu ([128.173.37.117]:28688 "EHLO
	h80ad2575.async.vt.edu") by vger.kernel.org with ESMTP
	id S262328AbVCOIMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 03:12:32 -0500
Message-Id: <200503150812.j2F8CABo004744@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Frank Sorenson <frank@tuxrocks.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>, Massimo Dal Zotto <dz@debian.org>
Subject: Re: [PATCH 0/5] I8K driver facelift 
In-Reply-To: Your message of "Sat, 12 Mar 2005 20:41:14 MST."
             <4233B65A.4030302@tuxrocks.com> 
From: Valdis.Kletnieks@vt.edu
References: <200502240110.16521.dtor_core@ameritech.net>
            <4233B65A.4030302@tuxrocks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1110874329_4382P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Mar 2005 03:12:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1110874329_4382P
Content-Type: text/plain; charset=us-ascii

On Sat, 12 Mar 2005 20:41:14 MST, Frank Sorenson said:

> These patches look pretty good.  A few comments (with a patch--tested on
> my Inspiron 9200):

I tested your patch on top of Dmitry's on a Dell Latitude C840, seems to work.

> - - Some of the Dell motherboards provide more than 1 temperature sensor.
> ~ How about a generic i8k_get_temp function, and i8k_get_cpu_temp just
> calls that with sensor 0.
> 
> - - Also, I've added detection of the number of temperature sensors and
> fans at init time.  This way, we aren't hardcoded to 1 sensor and 2
> fans.  I couldn't figure out how to set up the sysfs entries
> dynamically, but that probably should happen too.

According to your patch, the C840 has 2 temp sensors. I'll have to figure
out what the second one is (prob either the GPU or the disk drive?)

--==_Exmh_1110874329_4382P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCNpjZcC3lWbTT17ARAuIIAKDstOxAWnn9T7MVCNRvO0e242ozNQCg0jXW
WFZNzShfeviI7veUgmHykso=
=y4nf
-----END PGP SIGNATURE-----

--==_Exmh_1110874329_4382P--
