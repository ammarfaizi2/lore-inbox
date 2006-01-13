Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161537AbWAMKW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161537AbWAMKW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161538AbWAMKW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:22:57 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:2795 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161537AbWAMKW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:22:56 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] sched - interactivity updates
Date: Fri, 13 Jan 2006 21:22:37 +1100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
X-Length: 1225
Content-Type: multipart/signed;
  boundary="nextPart7389272.111nWTJqXd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601132122.39758.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7389272.111nWTJqXd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Changes to the kernel over the last few versions have exposed some weakness=
es=20
and quirks in the interactivity estimator. The following 5 patches are aime=
d=20
at addressing these issues. Each changes one unique aspect of the=20
interactivity estimator thus allowing easy comparison if desired.

=46or those who wish to try them I've placed a simple rolled up patch for=20
download to apply to 2.6.15 here:

http://ck.kolivas.org/patches/interactivity/2.6.15-O22int.patch

The separate patches are in that directory as well and will follow this ema=
il.

Andrew please apply the following 5 patches to -mm for testing.

Cheers,
Con

--nextPart7389272.111nWTJqXd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDx39vZUg7+tp6mRURAm9bAJ9rvxiIt8Ur6gCge3jj1BRdhym4qACcCNFR
jhN77O8zuiodshmvLC6RKbE=
=6ovd
-----END PGP SIGNATURE-----

--nextPart7389272.111nWTJqXd--
