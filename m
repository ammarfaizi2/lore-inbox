Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbREYN6x>; Fri, 25 May 2001 09:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263749AbREYN6e>; Fri, 25 May 2001 09:58:34 -0400
Received: from zeus.kernel.org ([209.10.41.242]:23680 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263748AbREYN63>;
	Fri, 25 May 2001 09:58:29 -0400
Date: Fri, 25 May 2001 17:21:30 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] arch/i386/kernel/bluesmoke.c: missing __init
Message-ID: <20010525172130.A2465@orbita1.ru>
Reply-To: pazke@orbita1.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
User-Agent: Mutt/1.0.1i
X-Uptime: 5:16pm  up  1:40,  1 user,  load average: 0.00, 0.00, 0.03
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

this micropatch adds missing __init for winchip_mcheck_init() function.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-bluesmoke
Content-Transfer-Encoding: quoted-printable

diff -ur -X /usr/dontdiff /linux.vanilla/arch/i386/kernel/bluesmoke.c linux=
/arch/i386/kernel/bluesmoke.c
--- /linux.vanilla/arch/i386/kernel/bluesmoke.c	Mon May 21 23:49:24 2001
+++ linux/arch/i386/kernel/bluesmoke.c	Fri May 25 22:58:31 2001
@@ -185,7 +185,7 @@
  *	Set up machine check reporting on the Winchip C6 series
  */
 =20
-static void winchip_mcheck_init(struct cpuinfo_x86 *c)
+static void __init winchip_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 lo, hi;
 	/* Not supported on C3 */

--fUYQa+Pmc3FrFX/N--

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7DlxaBm4rlNOo3YgRAiW9AJ9k+pxfrU1bbWxewxv3DB3f5UArEQCfUsop
NRjqcPETWxrWuK4B+l4AWZA=
=13+Y
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
