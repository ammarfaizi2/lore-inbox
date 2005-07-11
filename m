Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVGKQee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVGKQee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVGKQct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:32:49 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:55816 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S262092AbVGKQaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:30:25 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.13-rc2-mm1 - unknown symbol: is_broadcast_ether_addr
Date: Mon, 11 Jul 2005 18:29:01 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050707040037.04366e4e.akpm@osdl.org>
In-Reply-To: <20050707040037.04366e4e.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?utf-8?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/iP?=
 =?utf-8?q?Ov8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B2=7C?=
 =?utf-8?q?l6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?utf-8?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?utf-8?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1642388.zApOuGohgh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507111829.05204.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1642388.zApOuGohgh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

i get an unknown symbol "is_broadcast_ether_addr" from ipw2200 and=20
ieee80211

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F=20
System.map -b /home/damir/cvsARCH/extra/kernels/kernel26mm/pkg -r=20
2.6.13-rc2-mm1-ARCH; fi
WARNING: /home/damir/cvsARCH/extra/kernels/kernel26mm/pkg/lib/modules/2.6.1=
3-rc2-mm1-ARCH/kernel/drivers/net/wireless/ipw2200.ko=20
needs unknown symbol is_broadcast_ether_addr
WARNING: /home/damir/cvsARCH/extra/kernels/kernel26mm/pkg/lib/modules/2.6.1=
3-rc2-mm1-ARCH/kernel/net/ieee80211/ieee80211.ko=20
needs unknown symbol is_broadcast_ether_addr

lucky me, i don't have this hardware ;-)

greetings,
Damir

Le Thursday 07 July 2005 13:00, Andrew Morton a =E9crit=A0:
| - I seem to have quite a bit of material here which is appropriate to
| =A0 2.6.13:

=2D-=20
"Don't ever follow me, because I am difficult."
    --- Eugene Ormandy

--nextPart1642388.zApOuGohgh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC0p5RPABWKV6NProRAqtNAKDfj6sPqFWr4uCOZCoFjNnuDVVsZACgk7bF
Q4GDnh+AzdNIROYc3TIEXIc=
=ADVE
-----END PGP SIGNATURE-----

--nextPart1642388.zApOuGohgh--
