Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268717AbUJKIk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268717AbUJKIk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 04:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUJKIk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 04:40:27 -0400
Received: from 221-169-69-23.adsl.static.seed.net.tw ([221.169.69.23]:49349
	"EHLO cola.voip.idv.tw") by vger.kernel.org with ESMTP
	id S268717AbUJKIkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 04:40:18 -0400
Subject: Re: [PATCH 2.6]  vm-thrashing-control-tuning
From: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
To: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, ak@muc.de, linux-kernel@vger.kernel.org,
       riel@redhat.com
In-Reply-To: <416549CE.2070202@sdl.hitachi.co.jp>
References: <2LXI2-3a5-21@gated-at.bofh.it>
	 <m3ekkd46a8.fsf@averell.firstfloor.org>
	 <4163E2C0.5050109@sdl.hitachi.co.jp>
	 <20041006155000.46c9acdc.akpm@osdl.org>
	 <416549CE.2070202@sdl.hitachi.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jgGB9AteGX4M9KZBXqlh"
Message-Id: <1097483998.16118.14.camel@libra>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 16:39:58 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jgGB9AteGX4M9KZBXqlh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

In  include/linux/sysctl.h  of 2.6.9-rc3-mm3, both VM_HEAP_STACK_GAP and
VM_SWAP_TOKEN_TIMEOUT are 28. Maybe one of them should be 29?

--- include/linux/sysctl.h  (revision 11)
+++ include/linux/sysctl.h  (local)
@@ -168,7 +168,7 @@
 	VM_VFS_CACHE_PRESSURE=3D26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=3D27, /* legacy/compatibility virtual address space
layout */
  	VM_HEAP_STACK_GAP=3D28,	/* int: page gap between heap and stack */
-	VM_SWAP_TOKEN_TIMEOUT=3D28, /* default time for token time out */
+	VM_SWAP_TOKEN_TIMEOUT=3D29, /* default time for token time out */
 };
=20
=20


--=20
Best Regards,
Wen-chien Jesse Sung

--=-jgGB9AteGX4M9KZBXqlh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: 	=?UTF-8?Q?=E9=80=99=E6=98=AF=E6=95=B8=E4=BD=8D=E5=8A=A0=E7=B0=BD?=
	=?UTF-8?Q?=E7=9A=84=E9=83=B5?= =?UTF-8?Q?=E4=BB=B6?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBakbelZ/JOHsLIwgRAqpoAJ9gJsORgLk6qNizX8WdQBAdfG3KfACfYOVL
TgZVZvws13PH/KApRnUenAw=
=EfyN
-----END PGP SIGNATURE-----

--=-jgGB9AteGX4M9KZBXqlh--

