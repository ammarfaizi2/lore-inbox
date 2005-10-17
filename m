Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbVJQPVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbVJQPVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVJQPVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:21:39 -0400
Received: from mail03.solnet.ch ([212.101.4.137]:39144 "EHLO mail03.solnet.ch")
	by vger.kernel.org with ESMTP id S1751390AbVJQPVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:21:38 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Subject: 2.6.14-rc4-mm1 - drivers/serial/jsm/jsm_tty.c: no member named 'flip'
Date: Mon, 17 Oct 2005 17:21:23 +0200
User-Agent: KMail/1.8.3
References: <20051016154108.25735ee3.akpm@osdl.org> <200510171229.57785.damir.perisa@solnet.ch> <4353BB87.1030006@us.ibm.com>
In-Reply-To: <4353BB87.1030006@us.ibm.com>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5790934.kWy4eXfSq9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510171721.26588.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5790934.kWy4eXfSq9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Monday 17 October 2005 16:56, vous avez =E9crit=A0:
 | =A0Please give details of the distro and the compiler version that you
 | used. =A0Are you building the driver as a module?

i'm package maintainer of kernel26mm in archlinux (i686).
the compiler is gcc 4.0.2 with some bugs fixed it had (from=20
4.0.3-snapshot).

yes, jsm-tty is built as module, as can be seen from output i posted.
the only difference from 2.6.14-rc4-mm1 and the one i compile is the=20
applied cleanup patch=20

	2614-rc4-mm-sparse-fixes.patch=20

that was announced on the mailinglist just after the rc4-mm1 release.

if you need the config, it can be found here:

http://cvs.archlinux.org/cgi-bin/viewcvs.cgi/kernels/kernel26mm/?cvsroot=3D=
Extra&only_with_tag=3DHEAD

i'm willing to apply any patches that would make kernel26mm again compile=20
all ttys successfully (the last one that did is 2.6.15-rc5-mm1).

thanx + greetings,
Damir

=2D-=20
I think it's a new feature.  Don't tell anyone it was an accident.  :-)
         -- Larry Wall on s/foo/bar/eieio in=20
<10911@jpl-devvax.JPL.NASA.GOV>

--nextPart5790934.kWy4eXfSq9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDU8F2PABWKV6NProRApaoAKCpPsnEGIOboBKjZBkFLdrw65Jc6gCfQcZ2
NV5ClcGdS4NV3GzMhFgYmLU=
=LUMY
-----END PGP SIGNATURE-----

--nextPart5790934.kWy4eXfSq9--
