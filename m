Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVIARlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVIARlT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVIARlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:41:19 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:26386 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S1030259AbVIARlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:41:18 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>
Subject: 2.6.13-mm1 - drivers/isdn/i4l/isdn_tty broken
Date: Thu, 1 Sep 2005 19:41:02 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050901035542.1c621af6.akpm@osdl.org>
In-Reply-To: <20050901035542.1c621af6.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?utf-8?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/iP?=
 =?utf-8?q?Ov8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B2=7C?=
 =?utf-8?q?l6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?utf-8?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?utf-8?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2055638.gt8plE22OP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509011941.07104.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2055638.gt8plE22OP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi Andrew,
hi Alan,

updating the kernel26mm package for archlinux to 2.6.13-mm1 i found the isd=
n-tty to be broken:

  CC [M]  drivers/isdn/i4l/isdn_tty.o
drivers/isdn/i4l/isdn_tty.c: In function 'isdn_tty_try_read':
drivers/isdn/i4l/isdn_tty.c:71: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:86: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:86: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:88: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:89: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:90: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:90: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:90: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:90: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:91: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:96: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c:97: error: 'struct tty_struct' has no member na=
med 'flip'
drivers/isdn/i4l/isdn_tty.c: In function 'isdn_tty_readmodem':
drivers/isdn/i4l/isdn_tty.c:134: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c:137: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c:138: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c:141: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c:141: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c:141: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c:141: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c:142: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c:143: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c:144: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c:146: error: 'struct tty_struct' has no member n=
amed 'flip'
drivers/isdn/i4l/isdn_tty.c: In function 'isdn_tty_at_cout':
drivers/isdn/i4l/isdn_tty.c:2372: error: 'struct tty_struct' has no member =
named 'flip'
drivers/isdn/i4l/isdn_tty.c:2403: error: 'struct tty_struct' has no member =
named 'flip'
drivers/isdn/i4l/isdn_tty.c:2418: error: 'struct tty_struct' has no member =
named 'flip'
make[3]: *** [drivers/isdn/i4l/isdn_tty.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2

greetings,
Damir

Le Thursday 01 September 2005 12:55, Andrew Morton a =E9crit=A0:
| ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.
|6.13-mm1/
|
| - Included Alan's big tty layer buffering rewrite. =A0This breaks the
| build on lots of more obscure character device drivers. =A0Patches
| welcome (please cc Alan).

=2D-=20
  Gentlemen, I want you to know that I am not always right, but I am
  never wrong. -Samuel Goldwyn

--nextPart2055638.gt8plE22OP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDFz0zPABWKV6NProRAmrxAKCj4tn1uZqkHWUNIZH2RGzmWG5L5wCfXAtk
+dL94m9ETDakHGKhhESn/A4=
=Jv7S
-----END PGP SIGNATURE-----

--nextPart2055638.gt8plE22OP--
