Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVETHij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVETHij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 03:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVETHij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 03:38:39 -0400
Received: from iai.speak-friend.de ([62.75.222.128]:1926 "EHLO
	iai.speak-friend.de") by vger.kernel.org with ESMTP id S261375AbVETHiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 03:38:23 -0400
From: Christian Parpart <trapni@gentoo.org>
Organization: Gentoo Linux Foundation
To: linux-kernel@vger.kernel.org
Subject: snd-intel8x0 buggy on Nvidia CK804, TYAN, AMD Opteron board?
Date: Fri, 20 May 2005 09:38:15 +0200
User-Agent: KMail/1.8
X-Face: $-3HTEy*5}2A{'R'VPim$,8KKX$l|:P^RhP{;yQ)g;]4isyohrOfk\)=?utf-8?q?Q=2Ep=23F3RWB=7D!m=24zn=0A=097=5CPUKBYRKDFUU=3A=5CZ+U=5Fa-/=5BhI?=
 =?utf-8?q?8DJZ?="WPC2j~}(N."(JB&VNb}kU&`>
 =?utf-8?q?9=3B=5FN=3BfnM=7BD=7B8=2EI+5=0A=09dg=60p=5EQ?=(:yE{eVgArPf190vEkbGis0vx];"
 =?utf-8?q?1O!L=7ByKN4J=5B4=27=7E=7Eh+o+=7D=2EgzkmqNs=60=7D=7C0uq8a=0A=09?=
 =?utf-8?q?=25WQg=3F=3D=25y7X74tMWEkL=5DQQ?=(_Yc"m*aC+HD%!,6/k>L7S%'<}_B2&cI}/W(p+;rJ%2`0A<)
 =?utf-8?q?F=0A=09P7P=2E=60=3Dy=7C=7DU=7E=3F!?=<z?6Bj!TDP-w|q0K<{P)%u~}q3&#|Zh)Fa]!D8t
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2879329.FWWTUfbeKH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505200938.17065.trapni@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2879329.FWWTUfbeKH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

well, I'm just trying to listen to my music, however, it's either a no-go=20
(using ALSA-OSS emulation) or just a plain pain to listen to (via ALSA=20
directly).

In first case, I just hear nothing. A `dd if=3D/dev/urandom of=3D/dev/dsp` =
stops=20
at a certain byte and in my headset I hear a very high beep tone.

in second case, the music seems very deformed and the output is very buggy =
at=20
all (meaning, that it played just for a few minutes).
deformed means, that the foreground singer has been somewhat in the very=20
background and it overall has been very unfunny to listen to.

I was trying different players and versions anyway.

So, is this supposed to be a bug in the kernel sound driver for my certain=
=20
hardware?

nforce4 TYAN dual-opteron board (the whole system 64bit compiled, kernel:=20
2.6.11-r8)

battousai ~ # lspci | grep -i audio
0000:00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Au=
dio=20
Controller (rev a2)

Regards,
Christian Parpart.

=2D-=20
Netiquette: http://www.ietf.org/rfc/rfc1855.txt
 09:33:41 up 57 days, 22:40,  0 users,  load average: 0.01, 0.02, 0.00

--nextPart2879329.FWWTUfbeKH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCjZPpPpa2GmDVhK0RAgpQAJ9YNvmtA3sthcV+yJe5OhpjfyzJqACdHeUj
DuXabFS9Bt17aQMdJioHLD0=
=EyHJ
-----END PGP SIGNATURE-----

--nextPart2879329.FWWTUfbeKH--
