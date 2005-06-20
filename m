Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVFTTnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVFTTnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFTTnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:43:08 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:6413 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261528AbVFTTl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:41:29 -0400
Message-Id: <200506201941.j5KJfJDf004508@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Paradise <paradyse@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       Debian Users List <debian-user@lists.debian.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-mm1 cannot build nvidia driver? 
In-Reply-To: Your message of "Tue, 21 Jun 2005 03:18:11 +0800."
             <f2176eb805062012181fe9707b@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <f2176eb805062004557fc7b9ac@mail.gmail.com> <f2176eb805062005201c96510a@mail.gmail.com> <200506201639.j5KGdoNO016276@turing-police.cc.vt.edu> <f2176eb805062012003b068199@mail.gmail.com> <f2176eb80506201200bb50ef1@mail.gmail.com>
            <f2176eb805062012181fe9707b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119296479_14097P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Jun 2005 15:41:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119296479_14097P
Content-Type: text/plain; charset=us-ascii

On Tue, 21 Jun 2005 03:18:11 +0800, Paradise said:
> Okay, it is fixed by adding back  "!defined(HAVE_COMPAT_IOCTL)", might
> something wrong with debian package

You certainly want to try to upgrade to the 7664 drivers, as there are at least
3 other places that need a similar change (all in nv.c).  What you have now is
at best half-fixed, and the other half is a bug waiting to happen.


--==_Exmh_1119296479_14097P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCtxvfcC3lWbTT17ARAq8IAJ0Ut4hoKJIhJloxAap9A++/H5km7gCg1fDQ
HZA1lbEB60AqxmWr2bijC6M=
=1WUg
-----END PGP SIGNATURE-----

--==_Exmh_1119296479_14097P--
