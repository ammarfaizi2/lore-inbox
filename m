Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVEAPHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVEAPHs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 11:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVEAPHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:07:48 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:27910 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S261643AbVEAPHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:07:40 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.12-rc3-mm2 - kswapd0 keeps running
Date: Sun, 1 May 2005 17:07:29 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20050430164303.6538f47c.akpm@osdl.org>
In-Reply-To: <20050430164303.6538f47c.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?utf-8?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/iP?=
 =?utf-8?q?Ov8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B2=7C?=
 =?utf-8?q?l6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?utf-8?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?utf-8?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3013115.EtIp47ILaq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505011707.35461.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3013115.EtIp47ILaq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

i updated from rc2-mm3 to rc3-mm2 and now i observe something strange:=20
the cpu is running all the time at 100% because of the kswapd0 that is=20
running always and not becomming idle.=20

after having the computer running for about one hour, top says this about=20
kswapd0:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  155 root      25   0     0    0    0 R 89.6  0.0  38:56.06 kswapd0

the config file you can find here:=20
http://cvs.archlinux.org/cgi-bin/viewcvs.cgi/kernels/kernel26mm/config?rev=
=3D1.18&cvsroot=3DExtra

regards,

Damir Perisa

=2D-=20
A thing worth doing is worth the trouble of asking somebody else to do it.

--nextPart3013115.EtIp47ILaq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCdPC3PABWKV6NProRAkyeAJ9PNIKqrjr5KfkaswEBXJAEf4i2SgCeJwAQ
2DutoBw6GOelUSFQXz5Z8Cc=
=9lSS
-----END PGP SIGNATURE-----

--nextPart3013115.EtIp47ILaq--
