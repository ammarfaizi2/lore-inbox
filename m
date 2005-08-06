Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263157AbVHFCtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbVHFCtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 22:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbVHFCrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 22:47:52 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:53221 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263157AbVHFCrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 22:47:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-ck5
Date: Sat, 6 Aug 2005 12:47:42 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
X-Length: 1967
Content-Type: multipart/signed;
  boundary="nextPart2885353.uccQbEKtDJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508061247.44391.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2885353.uccQbEKtDJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.12 (This includes all patches in 2.6.12.4):
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck5/patch-2.6.12-ck5.bz2
or for server version:
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck5/patch-2.6.12-ck5-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.12-ck4:
=2Dschedbatch2.8.diff
+schedbatch2.9.diff
A rare stall on hyperthreading was addressed and now batch tasks suspend=20
properly.

=2Dschediso2.12.diff
SCHED_ISO was dropped entirely. It broke in ck4, and there is now a decent=
=20
defacto standard for unprivileged realtime in mainline kernel with realtime=
=20
RLIMITS so I'm supporting the use of that instead.

=2Disobatch_ionice2.diff
+batch_ionice.diff
Remove check for SCHED_ISO

=2DHZ-864.diff
It seems there were far more areas of the kernel not ready for this Hz valu=
e=20
than I could have anticipated much to my dismay even though all code should=
=20
be written in a HZ neutral fashion. Return normal -ck to HZ=3D1000 and chan=
ge=20
ck-server to HZ=3D100.

=2Dpatch-2.6.12.3
+patch-2.6.12.4.bz2
Latest stable series

=2D2612ck4-version.diff
+2612ck5-version.diff
Version update.


Cheers,
Con

--nextPart2885353.uccQbEKtDJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC9CTQZUg7+tp6mRURAk1SAJwOKWKDnOeFowimzxHEn1j8WfRhAwCcCWSW
l0rxeMxuoq5oBj4UdLQNpkg=
=LTLW
-----END PGP SIGNATURE-----

--nextPart2885353.uccQbEKtDJ--
