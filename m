Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVEPOEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVEPOEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVEPOEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:04:36 -0400
Received: from iai.speak-friend.de ([62.75.222.128]:64644 "EHLO
	iai.speak-friend.de") by vger.kernel.org with ESMTP id S261659AbVEPOEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:04:15 -0400
From: Christian Parpart <trapni@gentoo.org>
Organization: Gentoo Linux Foundation
To: linux-kernel@vger.kernel.org
Subject: I'm having 4GB RAM, but Linux sees just 3GB???
Date: Mon, 16 May 2005 16:04:09 +0200
User-Agent: KMail/1.8
X-Face: $-3HTEy*5}2A{'R'VPim$,8KKX$l|:P^RhP{;yQ)g;]4isyohrOfk\)=?utf-8?q?Q=2Ep=23F3RWB=7D!m=24zn=0A=097=5CPUKBYRKDFUU=3A=5CZ+U=5Fa-/=5BhI?=
 =?utf-8?q?8DJZ?="WPC2j~}(N."(JB&VNb}kU&`>
 =?utf-8?q?9=3B=5FN=3BfnM=7BD=7B8=2EI+5=0A=09dg=60p=5EQ?=(:yE{eVgArPf190vEkbGis0vx];"
 =?utf-8?q?1O!L=7ByKN4J=5B4=27=7E=7Eh+o+=7D=2EgzkmqNs=60=7D=7C0uq8a=0A=09?=
 =?utf-8?q?=25WQg=3F=3D=25y7X74tMWEkL=5DQQ?=(_Yc"m*aC+HD%!,6/k>L7S%'<}_B2&cI}/W(p+;rJ%2`0A<)
 =?utf-8?q?F=0A=09P7P=2E=60=3Dy=7C=7DU=7E=3F!?=<z?6Bj!TDP-w|q0K<{P)%u~}q3&#|Zh)Fa]!D8t
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3429283.na5uEsPg8r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505161604.10881.trapni@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3429283.na5uEsPg8r
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I was asking this in gentoo-server mailing list before, however, they final=
ly=20
pointed me to this place as it could also be a bug in the kernel.

I'm having a TYAN board with two AMD Opteron 248 and 4x 1GB ECC RAM on it. =
The=20
BIOS reflects what I've plugged in, however, the operating system does not.

my `uname -a` output is:
Linux battousai 2.6.11-gentoo-r8 #1 SMP Sat May 14 02:42:15 CEST 2005 x86_6=
4=20
AMD Opteron(tm) Processor 248 AuthenticAMD GNU/Linux

and my `dmidecode` output is located at [0]. For ANY reason, dmidecode even=
=20
knows about my 4GB RAM, but `free -m` nor `kinfocenter` of KDE claims to se=
e=20
just 3GB.

free -m:
             total       used       free     shared    buffers     cached
Mem:          3015       2993         22          0         15       2638
=2D/+ buffers/cache:        338       2677
Swap:          511          1        510

This is rather sad to see 1GB RAM plugged in for nothing.

Has anyone a hint for my WHY this is happening and HOW I could get rid of i=
t?

Thanks in advance,
Christian Parpart.

[0] http://dev.gentoo.org/~trapni/dmidecode.txt

=2D-=20
Netiquette: http://www.ietf.org/rfc/rfc1855.txt
 15:59:12 up 54 days,  5:05,  0 users,  load average: 0.77, 0.51, 0.41

--nextPart3429283.na5uEsPg8r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCiKhaPpa2GmDVhK0RAn78AJ40KEE0YfKeKZe50DCC1qn/A2mJxACffIoR
HJZ1MJgRQD2+cUZgaYryXVQ=
=6g54
-----END PGP SIGNATURE-----

--nextPart3429283.na5uEsPg8r--
