Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTIAWlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTIAWlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:41:50 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:23942 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S263322AbTIAWlb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:41:31 -0400
Date: Mon, 1 Sep 2003 18:41:29 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: buffer layer error at fs/buffer.c:431
Message-ID: <20030901224129.GA12834@washoe.rutgers.edu>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Kernel People,

Installed fresh kernel 2.6.0-test4-bk3 and have got problem after about
2 hours of work

Sep  1 16:47:14 localhost kernel: buffer layer error at fs/buffer.c:431
Sep  1 16:47:14 localhost kernel: Call Trace:
Sep  1 16:47:14 localhost kernel:  [__find_get_block_slow+148/304] __find_g=
et_block_slow+0x94/0x130
Sep  1 16:47:14 localhost kernel:  [__mark_inode_dirty+231/240] __mark_inod=
e_dirty+0xe7/0xf0
Sep  1 16:47:14 localhost kernel:  [__find_get_block+145/240] __find_get_bl=
ock+0x91/0xf0
Sep  1 16:47:14 localhost kernel:  [ext3_clear_blocks+248/352] ext3_clear_b=
locks+0xf8/0x160
Sep  1 16:47:14 localhost kernel:  [ext3_free_data+152/336] ext3_free_data+=
0x98/0x150
Sep  1 16:47:14 localhost kernel:  [ext3_free_branches+230/624] ext3_free_b=
ranches+0xe6/0x270
Sep  1 16:47:14 localhost kernel:  [ext3_truncate+1294/1552] ext3_truncate+=
0x50e/0x610
Sep  1 16:47:14 localhost kernel:  [vmtruncate+166/336] vmtruncate+0xa6/0x1=
50
Sep  1 16:47:14 localhost kernel:  [inode_setattr+358/400] inode_setattr+0x=
166/0x190
Sep  1 16:47:14 localhost kernel:  [ext3_setattr+120/384] ext3_setattr+0x78=
/0x180
Sep  1 16:47:14 localhost kernel:  [notify_change+334/400] notify_change+0x=
14e/0x190
Sep  1 16:47:14 localhost kernel:  [do_truncate+75/112] do_truncate+0x4b/0x=
70
Sep  1 16:47:14 localhost kernel:  [dput+48/528] dput+0x30/0x210
Sep  1 16:47:14 localhost kernel:  [permission+44/80] permission+0x2c/0x50
Sep  1 16:47:14 localhost kernel:  [may_open+368/464] may_open+0x170/0x1d0
Sep  1 16:47:14 localhost kernel:  [open_namei+168/1024] open_namei+0xa8/0x=
400
Sep  1 16:47:14 localhost kernel:  [filp_open+62/112] filp_open+0x3e/0x70
Sep  1 16:47:14 localhost kernel:  [sys_open+91/144] sys_open+0x5b/0x90
Sep  1 16:47:14 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  1 16:47:14 localhost kernel:=20
Sep  1 16:47:14 localhost kernel: block=3D827392, b_blocknr=3D4294967295


Details of kernel configuration and dmesg is at
http://www.onerussian.com/Linux/bug.buffer/

Thank you!

                                  .-.
=3D------------------------------   /v\  ----------------------------=3D
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/U8sZjRFFY3XAJMgRAl6DAJwIzH3GFG0fq4sxuW4lz2ng3yw+CwCggODb
XiGSANdU68OYu4u3+ez5VbE=
=jhJt
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
