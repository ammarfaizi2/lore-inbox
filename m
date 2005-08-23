Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVHWR3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVHWR3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVHWR3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:29:52 -0400
Received: from mail03.solnet.ch ([212.101.4.137]:56818 "EHLO mail03.solnet.ch")
	by vger.kernel.org with ESMTP id S932234AbVHWR3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:29:51 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc6-mm2 - drivers/net/s2io.o failed building
Date: Tue, 23 Aug 2005 19:27:13 +0200
User-Agent: KMail/1.8.2
References: <20050822213021.1beda4d5.akpm@osdl.org>
In-Reply-To: <20050822213021.1beda4d5.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?utf-8?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/iP?=
 =?utf-8?q?Ov8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B2=7C?=
 =?utf-8?q?l6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?utf-8?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?utf-8?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6185817.7YGgg0eZqS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508231927.16462.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6185817.7YGgg0eZqS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2.6.13-rc6-mm2  failed building with this problem (gcc 4.0.1):

  CC [M]  drivers/net/s2io.o
In file included from drivers/net/s2io.c:65:
drivers/net/s2io.h: In function 'readq':
drivers/net/s2io.h:765: error: invalid lvalue in assignment
drivers/net/s2io.h:766: error: invalid lvalue in assignment
make[2]: *** [drivers/net/s2io.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2
=3D=3D> ERROR: Build Failed.  Aborting...

greetings,
Damir

Le Tuesday 23 August 2005 06:30, vous avez =E9crit=A0:
| - Various updates. =A0Nothing terribly noteworthy.
|
| - This kernel still spits a bunch of scheduling-while-atomic warnings
| from the scsi code. =A0Please ignore.

=2D-=20
"Never give in.  Never give in.  Never. Never. Never."
=2D- Winston Churchill

--nextPart6185817.7YGgg0eZqS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDC1x0PABWKV6NProRAjdOAKCIPDIvs3zwnXt7pMaaaPJFuMBRlQCZARDN
3qaHwwsymx6FPNMnnb2qDrc=
=Zlx7
-----END PGP SIGNATURE-----

--nextPart6185817.7YGgg0eZqS--
