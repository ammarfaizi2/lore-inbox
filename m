Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbTGHNko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267308AbTGHNjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:39:13 -0400
Received: from maile.telia.com ([194.22.190.16]:6864 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id S267336AbTGHNiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:38:00 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Subject: 2.5.74-mm2 sleeping debug
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IWGAiKEuPrhFgEC0lETP"
Organization: LANIL
Message-Id: <1057672135.6856.32.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 08 Jul 2003 15:52:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IWGAiKEuPrhFgEC0lETP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Got a few of these, I think they are from the nvidia module.
I'll get back when I find out howto trigger it.

Debug: sleeping function called from illegal context at
mm/page_alloc.c:545
Call Trace:
 [<c0118b03>] __might_sleep+0x63/0x70
 [<c01345ba>] __alloc_pages+0x2a/0x2d0
 [<c010a891>] do_IRQ+0x111/0x130
 [<c0115b45>] pte_alloc_one+0x15/0x50
 [<c013bd1f>] pte_alloc_map+0x3f/0xe0
 [<c013ccf8>] remap_page_range+0xb8/0x1f0
 [<e4a38172>] nv_kern_mmap+0x2f6/0x330 [nvidia]
 [<c0137c73>] kmem_cache_alloc+0x23/0x60
 [<c013f223>] do_mmap_pgoff+0x3e3/0x600
 [<c010e9a1>] old_mmap+0x101/0x140
 [<c0108f47>] syscall_call+0x7/0xb

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-IWGAiKEuPrhFgEC0lETP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/CsvGyqbmAWw8VdkRArW+AJ9xOOhJACtmHpUMHN+yMJzR9T+6TQCfWI2w
N2XjDU0WaqqEcth49gBqUy8=
=MTCo
-----END PGP SIGNATURE-----

--=-IWGAiKEuPrhFgEC0lETP--

