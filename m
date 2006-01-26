Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWAZBsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWAZBsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 20:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWAZBsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 20:48:09 -0500
Received: from hs-grafik.net ([80.237.205.72]:44561 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1751289AbWAZBsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 20:48:08 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm3
Date: Thu, 26 Jan 2006 02:48:01 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200601251448.20664@zodiac.zodiac.dnsalias.org> <20060125092117.03c69174.akpm@osdl.org>
In-Reply-To: <20060125092117.03c69174.akpm@osdl.org>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4910180.jeASFZtD0X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601260248.01357@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4910180.jeASFZtD0X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 25. Januar 2006 18:21 schrieb Andrew Morton:
> Strange.   It might be worth checking 2.6.16-rc1-git4.

Hmm. I need reiser4. I'll have to see how I get that into git-4. ok

> If the CPU load is high (ie: 100%) during the delay, and it's mostly syst=
em
> time then yes, a kernel profile would be interesting.
> Documentation/basic_profiling.txt has details.

No, Cpu is at 600Mhz (Centrino, would increase to 1600 if load demands), an=
d=20
running at ~10%.

The delays must have an other reason. It makes no difference at all if i hi=
t=20
skip-over on something like=20
i *=3D 1;
or=20
doSomePrettyHeavyThing();
which imo prooves that there is no cpu-performance bottleneck.

regards
Alex

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart4910180.jeASFZtD0X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD2CpR/aHb+2190pERAlk7AJ9pSB+FQSQ81nTbp1oRImLZ6VeVLACfS2m1
r/E/h7TbOgjN1pfFh3nhI2E=
=bZAH
-----END PGP SIGNATURE-----

--nextPart4910180.jeASFZtD0X--
