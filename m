Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUC2TUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUC2TUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:20:18 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:48910 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S263101AbUC2TUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:20:06 -0500
Date: Mon, 29 Mar 2004 21:15:04 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.4] invalid operand: 0000 / PREEMPT / 0060:[__break_lease+367/599]
Message-ID: <20040329191503.GA1611@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

Machine: Sony Vaio C1-MHP, Transmeta Crusoe
Kernel: 2.6.4 plain
Filesystem: ext3
Crashing process is a "postfix" daemon.

Might be important - Some postfix dirs have a chattr +S

invalid operand: 0000 [#1]
PREEMPT=20
CPU:    0
EIP:    0060:[__break_lease+367/599]    Not tainted
EFLAGS: 00010246
EIP is at __break_lease+0x16f/0x257
eax: 00000000   ebx: ffffffff   ecx: cc74c040   edx: c5796000
esi: c5796000   edi: ceccb780   ebp: 00000000   esp: c5797ef0
ds: 007b   es: 007b   ss: 0068
Process cleanup (pid: 1226, threadinfo=3Dc5796000 task=3Dcc74c040)
Stack: cdba3354 00008001 c5797f80 cdb6eaa0 cdba3382 00000000 00000000 ceccb=
3c0=20
       c0155c74 cdba3354 00008001 00000000 c5797f80 c6665000 00008001 c0155=
f8a=20
       c5797f80 00000004 00008001 00000000 c6665000 00008000 c5796000 c5796=
000=20
Call Trace:
 [may_open+245/351] may_open+0xf5/0x15f
 [open_namei+684/951] open_namei+0x2ac/0x3b7
 [flock_lock_file+324/398] flock_lock_file+0x144/0x18e
 [filp_open+59/92] filp_open+0x3b/0x5c
 [sys_open+55/111] sys_open+0x37/0x6f
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: c6 8d 66 81 85 f6 0f 44 f0 56 8f 54 24 20 50 57 e8 37 f4 ff=20

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAaHW3Uaz2rXW+gJcRAobBAJ0c5Wq2viC09YCgl8ZLmXLXKMDRlwCfbMHs
+6TdSx4gsQgyMx2btQUAqro=
=tVkZ
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
