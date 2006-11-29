Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967407AbWK2RNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967407AbWK2RNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 12:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967483AbWK2RNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 12:13:45 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:711 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S967407AbWK2RNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 12:13:44 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Bart Trojanowski <bart@jukie.net>
Subject: Re: 2.6.18.3 SMP PREEMPT crashes (x86-64)
Date: Wed, 29 Nov 2006 18:12:04 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061129170253.GH2418@jukie.net>
In-Reply-To: <20061129170253.GH2418@jukie.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2153864.bl9TFLtLK6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611291812.08408.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2153864.bl9TFLtLK6
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 29 November 2006 18:02 schrieb Bart Trojanowski:
> Hi all,
>
> I've been getting spurious hangs in 2.6.18 lately... first I thought it
> was hardware but tried different replacement parts and memtest. Nothing
> showed any problems.
>
> I finally hooked up a serial console to the box and I see the following.
> I include the initial dmesg output to show what's in the machine.
>
>  - Nforce4 based Shuttle XPC (PCIe, forcedeth, etc)

> [    0.000000] Nvidia board detected. Ignoring ACPI timer override.

Does your bios have the option to enable the hpet? (Maybe after a bios=20
update?)

If not:

Try booting with noapic, compile latest git kernel and buut it (w/o noapic)=
=2E=20
Above message should now not appear, if I am not mistaken. Otherwise you ha=
ve=20
to hack the kernel to not ignoge the timer override..


But I could be mistaken...
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2153864.bl9TFLtLK6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFbb9oxU2n/+9+t5gRAkuBAKCdhdF23kRPC4lwXm1sd4DUvCWuIACdEDcI
N6pHgYQAS6NQliEsB7o5RPE=
=0Ja7
-----END PGP SIGNATURE-----

--nextPart2153864.bl9TFLtLK6--
