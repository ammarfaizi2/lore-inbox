Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030622AbVIBBF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030622AbVIBBF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030623AbVIBBF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:05:57 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:30728 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S1030622AbVIBBF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:05:57 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.13-mm1 - drivers/serial/jsm/jsm_tty broken too
Date: Fri, 2 Sep 2005 03:05:42 +0200
User-Agent: KMail/1.8.2
References: <20050901035542.1c621af6.akpm@osdl.org> <200509011941.07104.damir.perisa@solnet.ch>
In-Reply-To: <200509011941.07104.damir.perisa@solnet.ch>
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
  boundary="nextPart2778784.vLgtkrm9QS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509020305.45894.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2778784.vLgtkrm9QS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

i disabled the isdn subsystem temporarely and tried to recompile=20
finding out that jsm-tty is affected too:

 CC [M]  drivers/serial/jsm/jsm_tty.o
drivers/serial/jsm/jsm_tty.c: In function 'jsm_input':
drivers/serial/jsm/jsm_tty.c:592: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:619: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:620: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:623: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:624: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:667: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:668: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:669: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:670: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:671: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:672: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:674: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:677: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:677: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:677: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:677: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:680: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:681: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:682: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:691: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:692: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:693: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:694: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:695: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:696: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:698: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:701: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:701: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:701: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:701: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:742: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:742: error: 'struct tty_struct' has no member =
named 'flip'
make[3]: *** [drivers/serial/jsm/jsm_tty.o] Error 1
make[2]: *** [drivers/serial/jsm] Error 2
make[1]: *** [drivers/serial] Error 2
make: *** [drivers] Error 2

hope that this tty breaks will be fixed in mm2

greetings,
Damir

=2D-=20
It would save me a lot of time if you just gave up and went mad now.

--nextPart2778784.vLgtkrm9QS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDF6VpPABWKV6NProRAhv6AJ9X3v1StppaC3rPhmSu4TU42+toIQCfTRVM
nAr/gnTAFFst4z1nlm54Z1s=
=CNKn
-----END PGP SIGNATURE-----

--nextPart2778784.vLgtkrm9QS--
