Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTEEOlc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbTEEOlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:41:32 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:58005 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262283AbTEEOla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:41:30 -0400
Date: Mon, 05 May 2003 10:52:24 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: 2.5.69: arch/i386/oprofile/init.c build error
To: linux-kernel@vger.kernel.org
Message-id: <20030505145224.GA18993@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=Nq2Wo0NMKNjxTN9z;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

this patch makes arch/i386/oprofile/init.c build.

*** linux-2.5.69/arch/i386/oprofile/init.c	Sun May  4 19:53:32 2003
--- /usr/src/linux-2.5.69/arch/i386/oprofile/init.c	Mon May  5 09:50:26 2003
***************
*** 9,14 ****
--- 9,15 ----
 =20
  #include <linux/oprofile.h>
  #include <linux/init.h>
+ #include <linux/errno.h>
  =20
  /* We support CPUs that have performance counters like the Pentium Pro
   * with the NMI mode driver.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tnqoCGPRljI8080RAse2AJ9ewcPhPzPbsYo//0YL127k74yZeQCeLCM+
K67Rru1qgCT2fUagAI6B3T4=
=nyX4
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
