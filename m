Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbUABOiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 09:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265603AbUABOiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 09:38:50 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:57316 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265602AbUABOir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 09:38:47 -0500
Subject: 2.6.1-rc1 not unmounting clearly?
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GZERKH9uhAk25qZX0Fxd"
Message-Id: <1073054339.13074.6.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 16:38:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GZERKH9uhAk25qZX0Fxd
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello all,
I yesterday installed my workstation from scratch, downloaded packages
etc. and updated the kernel. And I noticed this after doing "tune2fs -j
/dev/hda10" and rebooting. While the computer booted up there was an
error message like:

/dev/hda10 was not unmounted clearly!
** Note: Journal was removed, mounting ext2 only! **

then I decided to check the error, and booted back to 2.2.20 and did the
tune2fs there and booted straight to 2.6.1-rc1 after that, and then it
seemed to work. Known bug?

Regards,
Markus
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-GZERKH9uhAk25qZX0Fxd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/9YKC3+NhIWS1JHARAhVkAKC5elZRALV5rKV/A6hqtXoo+/fKVQCfVYEu
KZAJXYOOB38cvIEdJJJ3B3w=
=Choa
-----END PGP SIGNATURE-----

--=-GZERKH9uhAk25qZX0Fxd--

