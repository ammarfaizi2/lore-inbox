Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUF0Xha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUF0Xha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 19:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUF0Xha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 19:37:30 -0400
Received: from dhcp160179209.columbus.rr.com ([24.160.179.209]:54278 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S264538AbUF0Xh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 19:37:28 -0400
Date: Sun, 27 Jun 2004 18:51:04 -0400
From: Joseph Fannin <jhf@rivenstone.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm3
Message-ID: <20040627225104.GA623@samarkand.rivenstone.net>
References: <20040626233105.0c1375b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <20040626233105.0c1375b2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 26, 2004 at 11:31:05PM -0700, Andrew Morton wrote:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7=
-mm3/
>=20
> +ppc64-COMMAND_LINE_SIZE-fix.patch

    The same fix is needed for ppc32 as well.  I've attached a patch.

Signed-off-by: Joseph Fannin <jhf@rivenstone.net>
--=20
Joseph Fannin
jhf@rivenstone.net

--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ppc-COMMAND_LINE_SIZE-fix.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.6.7-mm3/include/asm-ppc/machdep.h linux-2.6.7-mm3_patched=
/include/asm-ppc/machdep.h
--- linux-2.6.7-mm3/include/asm-ppc/machdep.h	2004-06-27 09:57:56.000000000=
 -0400
+++ linux-2.6.7-mm3_patched/include/asm-ppc/machdep.h	2004-06-27 12:25:54.7=
21616752 -0400
@@ -5,6 +5,8 @@
 #include <linux/config.h>
 #include <linux/init.h>
=20
+#include <asm/setup.h>
+
 #ifdef CONFIG_APUS
 #include <asm-m68k/machdep.h>
 #endif

--tMbDGjvJuJijemkf--
