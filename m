Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWJEHzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWJEHzK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 03:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWJEHzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 03:55:09 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:17598 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751131AbWJEHzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 03:55:08 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: alsa-devel@alsa-project.org
Subject: 2.6.19-rc1: hda_intel: azx_get_response timeout, switching to polling mode...
Date: Thu, 5 Oct 2006 09:54:57 +0200
User-Agent: KMail/1.9.4
Cc: Linux List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1389044.0cY7vJJixT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610050954.57677.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1389044.0cY7vJJixT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I didn't get above message with 2.6.18. Usign irqpoll above message doesn't=
=20
appear, but I think neither it optimal.

The kernel is patched with reiser4 and acpi_skip_timer_override quirk is=20
deactivated (see last link why).

I tried different combinations (dmesg + .config). Differences are mostly pc=
i=20
mt init, irqpoll, nforce eth napi, pata/ide amd driver

http://www.prakash.gmxhome.de/linux/2.6.19-rc1-1.txt.bz2
http://www.prakash.gmxhome.de/linux/2.6.19-rc1-2.txt.bz2
http://www.prakash.gmxhome.de/linux/2.6.19-rc1-3.txt.bz2
http://www.prakash.gmxhome.de/linux/2.6.19-rc1-4.txt.bz2

cat /proc/interrupts for 2.6.18 resp .19-rc1
http://www.prakash.gmxhome.de/linux/irqs18.txt
http://www.prakash.gmxhome.de/linux/irqs19.txt

lspci can be found here:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115545986619977&w=3D2

Cheers,
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1389044.0cY7vJJixT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJLpRxU2n/+9+t5gRAt6ZAKClXC2qp5ybYfgfv3riLsquOE2PZQCg0Ci2
ZnRWsL1tSH/tr7PTznb9llY=
=UUbQ
-----END PGP SIGNATURE-----

--nextPart1389044.0cY7vJJixT--
