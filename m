Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269445AbUIIKpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269445AbUIIKpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269418AbUIIKpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:45:04 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:41390 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S269442AbUIIKoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:44:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "colin" <colin@realtek.com.tw>
Subject: Re: What File System supports Application XIP
Date: Thu, 9 Sep 2004 12:43:55 +0200
User-Agent: KMail/1.6.2
Cc: <linux-kernel@vger.kernel.org>
References: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw>
In-Reply-To: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_vPDQB9V81j0vZns";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409091243.59637.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_vPDQB9V81j0vZns
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Donnerstag, 9. September 2004 10:55, colin wrote:
> I know that Cramfs has supported Application XIP. Is there any other FS that
> also supports it? Ramdisk? Ramfs? Romfs?

On http://linuxvm.org/Patches/, you can find a file system called xip2fs,
that uses an ext2 read-only fs for XIP. The code there works only if the
backing memory is a zSeries DCSS memory segment, but it should be fairly
easy to port to some other low-level memory provider.

	Arnd <><

--Boundary-02=_vPDQB9V81j0vZns
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBQDPv5t5GS2LDRf4RAnjyAJ4uLJUNO/n1sIW61BNkhQn98jd30ACdFv8a
cKmF03+P8G0C3X3ZjVIgNck=
=/dTH
-----END PGP SIGNATURE-----

--Boundary-02=_vPDQB9V81j0vZns--
