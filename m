Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268838AbUJKLtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268838AbUJKLtG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUJKLtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:49:04 -0400
Received: from lugor.de ([217.160.170.124]:29582 "EHLO solar.linuxob.de")
	by vger.kernel.org with ESMTP id S268828AbUJKLsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:48:50 -0400
From: Christian Hesse <mail@earthworm.de>
To: linux-kernel@vger.kernel.org
Subject: Software Suspend with ck
Date: Mon, 11 Oct 2004 13:48:37 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2332779.HFp27JkuSv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410111348.45497.mail@earthworm.de>
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.12; VDF 6.27.0.86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2332779.HFp27JkuSv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello!

Con Kolivas repoted this to work for him, but he also told me he's=20
clutching at straws since his swsusp knowledge is small and =20
Pavel Machek explained freeing memory is basically vm code he only
calls. So I post this here everybody can read it.

Trying to suspend an ck-kernel results in the system hanging while freeing=
=20
memory. This behavior is caused by Staircase scheduler. Sane 2.6.9-rc{3,4}=
=20
works fine.

Any chance to get it working? Let me know if you need more inforamtion.=20

=2D-=20
Christian Hesse

geek by nature
linux by choice

--nextPart2332779.HFp27JkuSv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBanMdlZfG2c8gdSURAqLMAKDwqGq89KFRM7IiNKCgT8oZ0AYgmACdHraQ
kkEb9XVW2QX++oNV+wwxx88=
=exnk
-----END PGP SIGNATURE-----

--nextPart2332779.HFp27JkuSv--
