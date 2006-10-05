Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWJEHiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWJEHiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 03:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWJEHiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 03:38:20 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:22994 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750709AbWJEHiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 03:38:20 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: mingo@redhat.com, manfred@colorfullife.com
Subject: 2.6.19-rc1: forcedeth, nobody cared
Date: Thu, 5 Oct 2006 09:38:10 +0200
User-Agent: KMail/1.9.4
Cc: Linux List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1531830.mpXJ4OxlZf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610050938.10997.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1531830.mpXJ4OxlZf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

subjects say it all. Without irqpoll my nic doesn't work anymore. I added I=
ngo=20
to cc, as my IRQs look different, so it may be a prob of APIC routing or th=
e=20
like.

The kernel is patched with reiser4 and acpi_skip_timer_override quirk is=20
deactivated (see last link why).

I tried different combinations (dmesg + .config). Differences are mostly pc=
i=20
mt init, irqpoll, nforce eth napi, pata/ide amd driver. Last is current=20
(working, but with irqpoll)

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

--nextPart1531830.mpXJ4OxlZf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJLZixU2n/+9+t5gRAv/+AJ9xSsk78/tOxfI7tkVd0blcf3DtcACdFOlj
ir/e0yfrb6djrOOZsFHwOB4=
=Mlu9
-----END PGP SIGNATURE-----

--nextPart1531830.mpXJ4OxlZf--
