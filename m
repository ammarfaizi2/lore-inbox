Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbTHTNCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 09:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbTHTNCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 09:02:23 -0400
Received: from relay.rost.ru ([217.107.128.164]:18102 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261948AbTHTNCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 09:02:17 -0400
Date: Wed, 20 Aug 2003 17:02:11 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] visws: fix uniprocessor compile error
Message-ID: <20030820130211.GG13173@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gvF4niNJ+uBMJnEh
Content-Type: multipart/mixed; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this trivial patch fixes visws UP kernel compile errors.

Please apply.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-mach_apic
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux-2.6.0-test3.vanilla/include/asm-i386=
/mach-visws/mach_apic.h linux-2.6.0-test3/include/asm-i386/mach-visws/mach_=
apic.h
--- linux-2.6.0-test3.vanilla/include/asm-i386/mach-visws/mach_apic.h	Sat A=
ug  9 08:31:17 2003
+++ linux-2.6.0-test3/include/asm-i386/mach-visws/mach_apic.h	Thu Aug 14 21=
:40:41 2003
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H
=20
+#include <mach_apicdef.h>
+
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
=20
 #define no_balance_irq (0)

--AH+kv8CCoFf6qPuz--

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Q3FTby9O0+A2ZecRAhLGAKCb0nL6b4D5cE4+eECptO07GCPq/wCcCpm0
3ALi2RXjbkKSeIRpd1uXs0k=
=ldaC
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
