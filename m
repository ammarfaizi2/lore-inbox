Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTLUQjv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 11:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTLUQjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 11:39:51 -0500
Received: from mx02.qsc.de ([213.148.130.14]:38529 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S263836AbTLUQjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 11:39:49 -0500
Date: Sun, 21 Dec 2003 17:39:47 +0100
From: Wiktor Wodecki <wodecki@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 Ooops while accessing ejected floppy
Message-ID: <20031221163947.GA897@gmx.de>
Reply-To: Wiktor Wodecki <wodecki@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I forgot to unmount my floppy before ejecting it. No problem here (it is
my fault after all) but the kernel gave me an Ooops.
Nothing bad really happend, and I could continue work. However, I
thought to give a note here.

Dec 21 14:50:38 kakerlak kernel: floppy0: disk absent or changed during
operation
Dec 21 14:50:38 kakerlak kernel: end_request: I/O error, dev fd0, sector
7
Dec 21 14:50:38 kakerlak kernel: lost page write due to I/O error on fd0=20
Dec 21 14:50:38 kakerlak kernel: buffer layer error at fs/buffer.c:2827
Dec 21 14:50:38 kakerlak kernel: Call Trace:
Dec 21 14:50:38 kakerlak kernel: [<c0157412>] drop_buffers+0xc2/0xd0
Dec 21 14:50:38 kakerlak kernel: [<c0157467>]
try_to_free_buffers+0x47/0xd0
Dec 21 14:50:38 kakerlak kernel: [<c015557e>]
block_invalidatepage+0xae/0xe0
Dec 21 14:50:38 kakerlak kernel: [<c01404a7>]
do_invalidatepage+0x27/0x30
Dec 21 14:50:38 kakerlak kernel: [<c014052b>]
truncate_complete_page+0x7b/0x80
Dec 21 14:50:38 kakerlak kernel: [<c01406e0>]
truncate_inode_pages+0xf0/0x290
Dec 21 14:50:38 kakerlak kernel: [<c016aa47>] dispose_list+0x97/0xa0
Dec 21 14:50:38 kakerlak kernel: [<c016abaa>]
invalidate_inodes+0x9a/0xc0
Dec 21 14:50:38 kakerlak kernel: [<c0158949>]
generic_shutdown_super+0x79/0x190
Dec 21 14:50:38 kakerlak kernel: [<c01595ad>] kill_block_super+0x1d/0x50=20
Dec 21 14:50:38 kakerlak kernel: [<c015878e>] deactivate_super+0x5e/0xc0
Dec 21 14:50:38 kakerlak kernel: [<c016dd3f>] sys_umount+0x3f/0x90
Dec 21 14:50:38 kakerlak kernel: [<c016dda7>] sys_oldumount+0x17/0x20
Dec 21 14:50:38 kakerlak kernel: [<c0109387>] syscall_call+0x7/0xb


--=20
Regards,

Wiktor Wodecki

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/5czT6SNaNRgsl4MRAmHSAJ9qZdPSGD5pp+5j8UL31oIsdXWjjgCeKIu6
ubxoxSoqSJCXiBTwhzuE+yg=
=DXZS
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
