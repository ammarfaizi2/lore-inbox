Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265187AbUFHMhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265187AbUFHMhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 08:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbUFHMhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 08:37:38 -0400
Received: from [196.25.168.8] ([196.25.168.8]:61925 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S265187AbUFHMhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 08:37:35 -0400
Date: Tue, 8 Jun 2004 14:36:56 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: linux-kernel@vger.kernel.org
Subject: SMBFS crash
Message-ID: <20040608123656.GG14247@lbsd.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8sQsHfNlXZNubEnG"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8sQsHfNlXZNubEnG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Guys,

I get the following error trying to access a mounted smb filesystem.
100% reproducable on my sytem.

Please let me know if you require anymore info.


Regards
Nigel Kukard


smb_lookup: find //.Trash-nkukard failed, error=-5
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
CPU:    0
EIP:    0060:[<00000000>]    Tainted: P
EFLAGS: 00210246   (2.6.6)
EIP is at 0x0
eax: c4b94e80   ebx: c9d71b90   ecx: c016e430   edx: d00e3fa0
esi: 00000000   edi: c4b94e80   ebp: c93f0cf8   esp: d00e3f18
ds: 007b   es: 007b   ss: 0068
Process nautilus (pid: 4131, threadinfo=d00e2000 task=defa5670)
Stack: e0ac90b2 d00e3f40 c0dccebc 00000000 c101b160 c0d8b000 c0d81c54
c0dcce18
       c016e430 d00e3fa0 00000000 00462953 00000000 00000000 00000000
c0d8b000
       00000002 00000000 00000000 00000001 00000004 ffffffe0 e0ad1d80
c4b94e80
Call Trace:
 [<e0ac90b2>] smb_readdir+0x162/0x4e0 [smbfs]
 [<c016e430>] filldir64+0x0/0xf0
 [<c016e1ab>] vfs_readdir+0x8b/0xa0
 [<c016e430>] filldir64+0x0/0xf0
 [<c016e585>] sys_getdents64+0x65/0xa1
 [<c0105f57>] syscall_call+0x7/0xb

Code:  Bad EIP value.


--8sQsHfNlXZNubEnG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAxbLoKoUGSidwLE4RArUiAKCFDP831/2Drq9kEk0ABUgPqEzGgwCgilHG
dqvLDie0y1J1yfD6U6GgLY4=
=5J58
-----END PGP SIGNATURE-----

--8sQsHfNlXZNubEnG--
