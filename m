Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbTDUP0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbTDUP0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:26:23 -0400
Received: from mail.racinglogistics.com.au ([203.31.48.12]:42504 "EHLO
	mail.netspeed.com.au") by vger.kernel.org with ESMTP
	id S261339AbTDUP0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:26:12 -0400
Date: Mon, 21 Apr 2003 17:44:50 +1000
From: Rob Weir <rweir@ertius.org>
To: linux-kernel@vger.kernel.org
Subject: XFS problem in 2.5.67-mm4
Message-ID: <20030421074450.GA13292@thebox.bloog.ddts.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
"From: Rob Weir <rweir@ertius.org>"
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there,

I just decided to jump into 2.5 with 2.5.67-mm4, and I was mightily
impressed, especially with the interactive 'feel' of it.  Well, mostly,
since something went wrong with XFS on my /home:

Apr 21 03:28:01 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:01 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:01 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:02 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:02 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:02 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:03 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:03 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:03 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:04 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:28:04 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:04 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:05 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:05 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:05 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:06 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:06 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:06 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:07 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:07 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:07 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:08 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:08 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:08 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:09 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:09 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:09 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:10 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:10 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:10 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:11 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:11 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:11 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:13 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:13 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:13 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:14 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:14 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:14 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:31 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:28:31 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:31 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:32 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:32 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:32 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:33 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:33 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:33 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:34 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:34 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:34 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:40 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:40 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:40 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:40 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:40 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:40 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:42 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:42 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:42 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:43 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:43 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:43 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:44 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:44 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:44 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:45 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:45 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:45 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:46 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:46 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:46 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:28:47 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:28:47 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:28:47 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:37 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:37 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:37 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c0121660>]  [<c01bf3c=
0>]  [<c01bf3c0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  =
[<c015f80c>]  [<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:38 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:38 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:38 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:39 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:39 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:39 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:40 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:40 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:40 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01bf3c0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  =
[<c015f80c>]  [<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:43 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:43 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:43 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01ecce6>]  [<c01bf3c=
0>]  [<c01bf3c0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  =
[<c015f80c>]  [<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:44 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:44 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:44 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:45 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:45 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:45 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:46 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:46 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:46 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:51 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:51 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:51 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:52 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:52 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:52 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:30:55 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:30:55 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:30:55 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:31:05 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:31:05 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:31:05 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:32:15 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:32:15 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:32:15 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:32:16 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b =
56 2a 7f=20
Apr 21 03:32:16 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:32:16 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:36:35 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:36:35 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:36:35 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:36:36 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:36:36 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:36:36 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:36:37 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:36:37 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:36:37 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c0109225>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c=
0>]  [<c01bf3c0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  =
[<c015f80c>]  [<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:36:42 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:36:42 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:36:42 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:36:49 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:36:49 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:36:49 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:36:52 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:36:52 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:36:52 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c0129a00>]  [<c01bf3c=
0>]  [<c01bf3c0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  =
[<c015f80c>]  [<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:36:53 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:36:53 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:36:53 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:36:59 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:36:59 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:36:59 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:37:13 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:37:13 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:37:13 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:38:40 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:38:40 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:38:40 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:47:13 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:47:13 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:47:13 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:48:40 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:48:40 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:48:40 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:57:13 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:57:13 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:57:13 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 03:58:40 thebox kernel: 0x0: 0c 96 8e d1 5f 81 0a c4 46 d6 cd 40 32 =
dc d1 52=20
Apr 21 03:58:40 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 03:58:40 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c=
0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  =
[<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>]=20
Apr 21 04:00:09 thebox kernel: 0x0: 00 00 00 00 6c 65 61 73 02 52 65 00 00 =
10 2e 56=20
Apr 21 04:00:09 thebox kernel: Filesystem "ide0(3,10)": XFS internal error =
xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01b=
c657
Apr 21 04:00:09 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c0=
1bc657>]  [<c01ebcc9>]  [<c01bc657>]  [<c01bf742>]  [<c01bf742>]  [<c0204a3=
b>]  [<c01c7729>]  [<c01be7ca>]  [<c0204a3b>]  [<c01f21b6>]  [<c01ff5ef>]  =
[<c01ff6cf>]  [<c015bc2d>]  [<c015c2a7>]  [<c014c933>]  [<c014ce1b>]  [<c01=
092db>]=20
Apr 21 04:00:09 thebox kernel: xfs_force_shutdown(ide0(3,10),0x8) called fr=
om line 1052 of file fs/xfs/xfs_trans.c.  Return address =3D 0xc020392b
Apr 21 04:00:09 thebox kernel: Filesystem "ide0(3,10)": Corruption of in-me=
mory data detected.  Shutting down filesystem: ide0(3,10)
Apr 21 04:00:09 thebox kernel: Please umount the filesystem, and rectify th=
e problem(s)

Followed by a whole lot of userspace errors as things failed to write to
/home.  It is possible I have flakey RAM (I've had some stability
problems, but memtest86 never seems to be able to find it...), but I
thought it's better to let you know than not.  If there's any more
information I can provide, just ask.  Also, I'm on lkml, so no need for
CC's.

--=20
Rob Weir <rweir@ertius.org>                              http://www.ertius.=
org/

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+o6FyvQ+DhR5zt80RAsXEAJ9AiXtZjMtdY29uNogT06BqbIVB6gCZAfXK
xqNwnmEGX4yxzRAQA8NBKi8=
=1Go7
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
