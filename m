Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbTFWQxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 12:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbTFWQxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 12:53:03 -0400
Received: from mx5.mail.ru ([194.67.23.25]:53522 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id S266066AbTFWQxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 12:53:00 -0400
Date: Mon, 23 Jun 2003 21:06:14 +0400
From: Nick Kurshev <nickols_k@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [Feature-request] extending of keyboard code table
Message-Id: <20030623210614.0d5e3c36.nickols_k@mail.ru>
Organization: HomePC
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.+FbNO/E,Nopx06"
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.+FbNO/E,Nopx06
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello!

I'm using btc9001ah keyboard and meet the problem
when so-called internet keys can't be emulated by
linux-2.4.21.
I've got this message:
keyboard.c: can't emulate rawmode for keycode 256
keyboard.c: can't emulate rawmode for keycode 257
keyboard.c: can't emulate rawmode for keycode 258
keyboard.c: can't emulate rawmode for keycode 259
keyboard.c: can't emulate rawmode for keycode 260
This lines were produces when I pressed so-called
FreeKey1-FreeKey5 on my keyboard!

It was caused by the fact that drivers/input/keybdev.c
limits x86_keycodes size by 256 elements!
Would it possible to extend this table in 2 times at least?
Thanks!

Best regards! Nick

--=.+FbNO/E,Nopx06
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+9zOIB/1cNcrTvJkRAhGhAKD4VVQoFAW4Wew9YRo9Adr75CXVPQCeI+12
sAOtCqaM2Ry3SwN9FQ9F8Ds=
=flI6
-----END PGP SIGNATURE-----

--=.+FbNO/E,Nopx06--
