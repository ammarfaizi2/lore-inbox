Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWDBT5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWDBT5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 15:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWDBT5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 15:57:39 -0400
Received: from nijmegen.renzel.net ([195.243.213.130]:46822 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S932399AbWDBT5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 15:57:38 -0400
From: Mws <mws@twisted-brains.org>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.16 oops
Date: Sun, 2 Apr 2006 21:57:51 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1325772.UYl0WdUrAV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604022157.57291.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1325772.UYl0WdUrAV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi all,
maybe it is of interest?

i got this oops while doing nothing at all, the system was running, opened =
xorg x11 and kde 3.5.2
just in screensaver mode.

regards=20
marcel


Mar 31 21:55:47 [kernel] Unable to handle kernel paging request at virtual =
address 000c40d4
Mar 31 21:55:47 [kernel]  printing eip:
Mar 31 21:55:47 [kernel] b04abd5b
Mar 31 21:55:47 [kernel] *pde =3D 45766067
Mar 31 21:55:47 [kernel] *pte =3D 00000000
Mar 31 21:55:47 [kernel] Modules linked in:
Mar 31 21:55:47 [kernel] EIP:    0060:[<b04abd5b>]    Not tainted VLI
Mar 31 21:55:47 [kernel] EFLAGS: 00213096   (2.6.16MWS #1)
Mar 31 21:55:47 [kernel]  <3>Debug: sleeping function called from invalid c=
ontext at include/linux/rwsem.h:43
Mar 31 21:55:47 [kernel] in_atomic():0, irqs_disabled():1
Mar 31 21:55:47 [kernel]  [<b011b87e>] __might_sleep+0x8b/0x93
Mar 31 21:55:47 [kernel]  [<b011fab5>] exit_mm+0x2a/0x13f
Mar 31 21:55:47 [kernel]  [<b012022d>] do_exit+0x160/0x336
Mar 31 21:55:47 [kernel]  [<b010397d>] do_trap+0x0/0xc1
Mar 31 21:55:47 [kernel]  [<b0113b8f>] do_page_fault+0x3a4/0x4ea
Mar 31 21:55:47 [kernel]  [<b01137eb>] do_page_fault+0x0/0x4ea
Mar 31 21:55:47 [kernel]  [<b01032b3>] error_code+0x4f/0x54
Mar 31 21:55:47 [kernel]  [<b04abd5b>] _spin_lock_irqsave+0x9/0x26
Mar 31 21:55:47 [kernel]  [<b012e1da>] remove_wait_queue+0xf/0x34
Mar 31 21:55:47 [kernel]  [<b0161263>] poll_freewait+0x1e/0x3c
Mar 31 21:55:47 [kernel]  [<b01616b2>] do_select+0x2cd/0x2d8
Mar 31 21:55:47 [kernel]  [<b0161281>] __pollwait+0x0/0x9b
Mar 31 21:55:47 [kernel]  [<b01618d6>] core_sys_select+0x201/0x300
Mar 31 21:55:47 [kernel]  [<b0107764>] restore_i387_fxsave+0x77/0x82
Mar 31 21:55:47 [kernel]  [<b0161a72>] sys_select+0x9d/0x161
Mar 31 21:55:47 [kernel]  [<b0101d8f>] sys_sigreturn+0xb5/0xdc
Mar 31 21:55:47 [kernel]  [<b01026bb>] sysenter_past_esp+0x54/0x75
Mar 31 21:55:47 [kernel] Unabl=FF=FF=FF=FF=FF=FF
Mar 31 21:55:47 [kernel]  printing eip:
Mar 31 21:55:47 [kernel] 30394953
Mar 31 21:55:47 [kernel] *pde =3D 00000000
Mar 31 21:55:47 [kernel] Modules linked in:
Mar 31 21:55:47 [kernel] EIP:    0060:[<30394953>]    Not tainted VLI
Mar 31 21:55:47 [kernel] EFLAGS: 00213016   (2.6.16MWS #1)
Mar 31 21:55:47 [kernel]  <1>Fixing recursive fault but reboot is needed!
Mar 31 21:55:48 [kernel] Unable to handle kernel NULL pointer dereference a=
t virtual address 00000000
Mar 31 21:55:48 [kernel]  printing eip:
Mar 31 21:55:48 [kernel] 00000000
Mar 31 21:55:48 [kernel] *pde =3D 00000000
Mar 31 21:55:48 [kernel] Modules linked in:
Mar 31 21:55:48 [kernel] EIP:    0060:[<00000000>]    Not tainted VLI
Mar 31 21:55:48 [kernel] EFLAGS: 00210083   (2.6.16MWS #1)
Mar 31 21:55:48 [kernel]  <3>Debug: sleeping function called from invalid c=
ontext at include/linux/rwsem.h:43
Mar 31 21:55:48 [kernel] in_atomic():0, irqs_disabled():1
Mar 31 21:55:48 [kernel]  [<b011b87e>] __might_sleep+0x8b/0x93
Mar 31 21:55:48 [kernel]  [<b011fab5>] exit_mm+0x2a/0x13f
Mar 31 21:55:48 [kernel]  [<b012022d>] do_exit+0x160/0x336
Mar 31 21:55:48 [kernel]  [<b010397d>] do_trap+0x0/0xc1
Mar 31 21:55:48 [kernel]  [<b0113b8f>] do_page_fault+0x3a4/0x4ea
Mar 31 21:55:48 [kernel]  [<b01137eb>] do_page_fault+0x0/0x4ea
Mar 31 21:55:48 [kernel]  [<b01032b3>] error_code+0x4f/0x54
Mar 31 21:55:48 [kernel]  [<b0119920>] __wake_up_common+0x2f/0x4b
Mar 31 21:55:48 [kernel]  [<b0119963>] __wake_up+0x27/0x3b
Mar 31 21:55:48 [kernel]  [<b0438756>] sock_def_readable+0x33/0x5e
Mar 31 21:55:48 [kernel]  [<b0491a95>] unix_stream_sendmsg+0x25f/0x32a
Mar 31 21:55:48 [kernel]  [<b0435ea2>] do_sock_write+0x8b/0x93
Mar 31 21:55:48 [kernel]  [<b0435fd7>] sock_aio_write+0x56/0x64
Mar 31 21:55:48 [kernel]  [<b0118dc0>] load_balance_newidle+0x2f/0xbe
Mar 31 21:55:48 [kernel]  [<b01385fc>] find_get_page+0x1a/0x3b
Mar 31 21:55:48 [kernel]  [<b01517f6>] do_sync_write+0xc0/0xf3
Mar 31 21:55:48 [kernel]  [<b012e2e6>] autoremove_wake_function+0x0/0x3a
Mar 31 21:55:48 [kernel]  [<b01518bb>] vfs_write+0x92/0x11b
Mar 31 21:55:48 [kernel]  [<b01519e2>] sys_write+0x3b/0x63
Mar 31 21:55:48 [kernel]  [<b01026bb>] sysenter_past_esp+0x54/0x75
Mar 31 21:55:57 [kernel] BUG: soft lockup detected on CPU#0!
Mar 31 21:55:57 [kernel] Pid: 6694, comm:                xinit
Mar 31 21:55:57 [kernel] EIP: 0060:[<b04abd6e>] CPU: 0
Mar 31 21:55:57 [kernel] EIP is at _spin_lock_irqsave+0x1c/0x26
Mar 31 21:55:57 [kernel]  EFLAGS: 00200286    Not tainted  (2.6.16MWS #1)
Mar 31 21:55:57 [kernel] EAX: f7caf298 EBX: f7caf298 ECX: 00000000 EDX: 002=
00246
Mar 31 21:55:57 [kernel] ESI: 00000000 EDI: 00000000 EBP: f4cadbd4 DS: 007b=
 ES: 007b
Mar 31 21:55:57 [kernel] CR0: 8005003b CR2: ffffffd5 CR3: 47cce000 CR4: 000=
006d0
Mar 31 21:55:57 [kernel]  [<b0119953>] __wake_up+0x17/0x3b
Mar 31 21:55:57 [kernel]  [<b04386ba>] sock_def_wakeup+0x30/0x3b
Mar 31 21:55:57 [kernel]  [<b04903c1>] unix_release_sock+0x103/0x1e6
Mar 31 21:55:57 [kernel]  [<b04906ef>] unix_release+0x1c/0x1f
Mar 31 21:55:57 [kernel]  [<b04358c9>] sock_release+0x14/0x8d
Mar 31 21:55:57 [kernel]  [<b0436314>] sock_close+0x2e/0x33
Mar 31 21:55:57 [kernel]  [<b01523e5>] __fput+0xa8/0x156
Mar 31 21:55:57 [kernel]  [<b0151034>] filp_close+0x4c/0x55
Mar 31 21:55:57 [kernel]  [<b011f8b9>] close_files+0x4b/0x5b
Mar 31 21:55:57 [kernel]  [<b011f903>] put_files_struct+0x14/0x3c
Mar 31 21:55:57 [kernel]  [<b0120262>] do_exit+0x195/0x336
Mar 31 21:55:57 [kernel]  [<b010397d>] do_trap+0x0/0xc1
Mar 31 21:55:57 [kernel]  [<b0113b8f>] do_page_fault+0x3a4/0x4ea
Mar 31 21:55:57 [kernel]  [<b01137eb>] do_page_fault+0x0/0x4ea
Mar 31 21:55:57 [kernel]  [<b01032b3>] error_code+0x4f/0x54
Mar 31 21:55:57 [kernel]  [<b0119920>] __wake_up_common+0x2f/0x4b
Mar 31 21:55:57 [kernel]  [<b0119963>] __wake_up+0x27/0x3b
Mar 31 21:55:57 [kernel]  [<b0438756>] sock_def_readable+0x33/0x5e
Mar 31 21:55:57 [kernel]  [<b0435ea2>] do_sock_write+0x8b/0x93
Mar 31 21:55:57 [kernel]  [<b0435fd7>] sock_aio_write+0x56/0x64
Mar 31 21:55:57 [kernel]  [<b0118dc0>] load_balance_newidle+0x2f/0xbe
Mar 31 21:55:57 [kernel]  [<b01385fc>] find_get_page+0x1a/0x3b
Mar 31 21:55:57 [kernel]  [<b01517f6>] do_sync_write+0xc0/0xf3
Mar 31 21:55:57 [kernel]  [<b012e2e6>] autoremove_wake_function+0x0/0x3a
Mar 31 21:55:57 [kernel]  [<b01518bb>] vfs_write+0x92/0x11b
Mar 31 21:55:57 [kernel]  [<b01519e2>] sys_write+0x3b/0x63
Mar 31 21:55:57 [kernel]  [<b01026bb>] sysenter_past_esp+0x54/0x75


--nextPart1325772.UYl0WdUrAV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMCzFPpA+SyJsko8RAvExAKDfXCz8UhwZniDvl76K8dItxxB19QCgpb8y
GIDmtOmXpDXmJOnHDK4NIow=
=wBkR
-----END PGP SIGNATURE-----

--nextPart1325772.UYl0WdUrAV--
