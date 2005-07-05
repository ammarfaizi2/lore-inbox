Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVGENPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVGENPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 09:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVGENPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:15:10 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:29151 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261851AbVGENIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 09:08:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: rt-preempt build failure
Date: Tue, 5 Jul 2005 23:08:41 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3224419.NvEyMSL3dk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507052308.43970.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3224419.NvEyMSL3dk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ingo

This config on i386:
http://ck.kolivas.org/crap/rt-config

realtime-preempt-2.6.12-final-V0.7.50-51
fails to build with these errors:

kernel/rt.c: In function `__down_mutex':
kernel/rt.c:1264: error: `ti' undeclared (first use in this function)
kernel/rt.c:1264: error: (Each undeclared identifier is reported only once
kernel/rt.c:1264: error: for each function it appears in.)
kernel/rt.c:1264: error: `task' undeclared (first use in this function)
kernel/rt.c:1264: error: `old_owner' undeclared (first use in this function)
kernel/rt.c:1264: error: too many arguments to function `____down_mutex'
kernel/rt.c: In function `__down':
kernel/rt.c:1269: error: `ti' undeclared (first use in this function)
kernel/rt.c:1269: error: `task' undeclared (first use in this function)
kernel/rt.c:1269: error: `old_owner' undeclared (first use in this function)
kernel/rt.c:1269: error: too many arguments to function `____down'

Cheers,
Con

--nextPart3224419.NvEyMSL3dk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCyoZbZUg7+tp6mRURAlNoAJwLtl5FhQrj0EoqxBg6oEna/Sd/ZQCfd/6g
71LnaJ0xdjLJ3LFHoVcNNCs=
=MSLr
-----END PGP SIGNATURE-----

--nextPart3224419.NvEyMSL3dk--
