Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbTDVJ7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 05:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbTDVJ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 05:59:10 -0400
Received: from NeverAgain.DE ([217.69.76.1]:56776 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S263038AbTDVJ7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 05:59:09 -0400
Date: Tue, 22 Apr 2003 12:10:09 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG 2.4.21-rc1 and prior] Kernel Panic with vga=791 as bootparam and 1G of ram
Message-ID: <20030422101009.GA1085@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

after putting another 512mb ram-stick into this machine (It has got 1G of r=
am
in total now), the VESA framebuffer of 2.4.21-pre7 and 2.4.21-pre7 has stop=
ped
to work. I am not sure whether this problem exists also in prior versions s=
ince
i did not test it. However, "has stopped to work" means that as soon as I g=
ive
"vga=3D791" as boot-param, nearly immediately after pressing the enter-key =
at
grub-prompt, when the kernel should switch into FB-mode, the LEDs on my
keyboard start to blink and it looks as if the machine hangs completely.

With only 512 megabytes of ram, this problem never appeared.

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+pRUBHPo+jNcUXjARAk7sAKCuw54kBwN2PxqU4FLLoGEIUZK5+gCfeiI+
2hba2XjMrbteedZtcN0mwo0=
=25WQ
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
