Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265644AbSJXUZ4>; Thu, 24 Oct 2002 16:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265648AbSJXUZz>; Thu, 24 Oct 2002 16:25:55 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:49208 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S265647AbSJXUZv>;
	Thu, 24 Oct 2002 16:25:51 -0400
Date: Thu, 24 Oct 2002 22:31:58 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: sjralston1@netscape.net, Pam.Delaney@lsil.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing include in mptlan.h (2.5.44)
Message-ID: <20021024223158.A18085@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This is needed to make drivers/message/fusion/mptlan.c make it
through 'make dep'.

--- linux-2.5.44-clean/drivers/message/fusion/mptlan.h	2002-10-16 05:27:49.000000000 +0200
+++ linux-2.5.44-allyesconfig/drivers/message/fusion/mptlan.h	2002-10-24 22:27:01.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/miscdevice.h>
 #include <linux/spinlock.h>
+#include <linux/version.h>
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,41)
 #include <linux/tqueue.h>
 #else

Regards,
  Rasmus

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9uFi9lZJASZ6eJs4RAmD9AKCSFTLwTN0iKS5uQLQ52blBbYkqYwCfaybO
eXZoBnUK84NUJGhD0uJDF6Y=
=jYcd
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
