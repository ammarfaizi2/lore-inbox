Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275299AbTHITNu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275360AbTHITNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:13:50 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:32669 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S275299AbTHITN2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:13:28 -0400
Date: Sat, 9 Aug 2003 12:13:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: zippel@linux-m68k.org, vojtech@suse.cz
Subject: 2.6.0-test3 issue
Message-ID: <20030809191326.GC8475@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.  I just tried to compile up 2.6.0-test3 for my x86 box, and I
noticed that the following set of options will no longer work:
CONFIG_EMBEDDED=3Dn
CONFIG_SERIO=3Dm
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy

The problem is that unless I set CONFIG_EMBEDDED, INPUT_KEYBOARD and
KEYBOAD_ATKBD both get set to 'Y', regardless of the other dependancies
(such as SERIO being 'm').

--=20
Tom Rini
http://gate.crashing.org/~trini/

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/NUfWdZngf2G4WwMRAvmTAKCRTOu+pub9C6HysOEaRPn8mpq4yACfV9qW
Bt2D0/YaMm0KyUFnD+I6lzs=
=j4D2
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
