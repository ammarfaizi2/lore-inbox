Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267413AbTAQHGY>; Fri, 17 Jan 2003 02:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTAQHGX>; Fri, 17 Jan 2003 02:06:23 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:31976 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S267413AbTAQHGW>; Fri, 17 Jan 2003 02:06:22 -0500
Date: Fri, 17 Jan 2003 08:15:16 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.59
Message-Id: <20030117081516.357ee146.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.8claws22 (GTK+ 1.2.10; Linux 2.5.59)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.'Bcc_OALj/7P+h"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.'Bcc_OALj/7P+h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2003 18:28:03 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Updates to sparc, alpha, ppc64, fbdev, XFS, AGP, kbuild, arm...

LT> James Simmons <jsimmons@maxwell.earthlink.net>:
LT>   o [RIVA FBDEV] Driver now uses its own fb_open and fb_release
LT>     function again. It has no ill effects. The drivers uses strickly
LT>     hardware acceleration so we don't need cfb_fillrect and
LT>     cfb_copyarea

Hi James,

The 2.5.59 version of the rivafb driver has some strange effects on my screen.
The leftmost ~5 pixels of each line are displaced to the right side of the screen,
so that the remainder of the screen is shifted ~5 pixels left, i.e. it's like
the screen has been rotated left a bit. 2.5.58 was alright.

If you've got a patch for this issue, I'll test it.

Regards,
-Udo.

--=.'Bcc_OALj/7P+h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+J62GnhRzXSM7nSkRAqCbAJ9iLmILRvYBnfY6PeulAcWpfSICHwCfUDbl
Bgg+/L0g8RVZp418faW0osc=
=goI9
-----END PGP SIGNATURE-----

--=.'Bcc_OALj/7P+h--
