Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVADEnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVADEnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 23:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVADEnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:43:45 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:20680 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262017AbVADEnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:43:43 -0500
Date: Tue, 4 Jan 2005 14:53:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Subject: PPC64 cleanups 0/11
Message-Id: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_14_53_57_+1100_m6Nnq2Vzd17tRKRE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_14_53_57_+1100_m6Nnq2Vzd17tRKRE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

The following series of patches are mainly just cleanups of the ppc64 code
in order to eliminate the naca structure.  In the end, the naca only
exists for legacy iseries kernels.  One of the more intrusive parts of
these patches is the renaming of the fields of the lppaca structure to
eliminate another set of StudyCaps.

These patches (in total) have been built on iSeries, pSeries and pmac and
booted on iSeries and pSeries.

Please apply and send upstream.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__4_Jan_2005_14_53_57_+1100_m6Nnq2Vzd17tRKRE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2hNc4CJfqux9a+8RAingAJ9Bvhec9gpXtNnq6vAFv4X560zRIACcDxZx
sInSCspsY0uNqU4ba8PwYDE=
=c4Pc
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_14_53_57_+1100_m6Nnq2Vzd17tRKRE--
