Return-Path: <linux-kernel-owner+w=401wt.eu-S1751843AbWLNKTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWLNKTl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWLNKTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:19:41 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:55952 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbWLNKTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:19:40 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: WARNING at fs/inotify.c:181
Date: Thu, 14 Dec 2006 11:21:09 +0100
User-Agent: KMail/1.9.5
Cc: John McCutchan <ttb@tentacle.dhs.org>, Robert Love <rml@novell.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2143717.zDc6n8IvU3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612141121.15864.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2143717.zDc6n8IvU3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Version is 2.6.19-rc6-git. System was more or less idle, just normal deskto=
p=20
stuff (copying single files by scp, writing mail). Don't know what exactly=
=20
was working when this happened, I saw it some minutes later.

BUG: warning at fs/inotify.c:181/set_dentry_child_flags()
 [<c017da03>] set_dentry_child_flags+0xcf/0x11c
 [<c017daa3>] remove_watch_no_event+0x53/0x5f
 [<c017db91>] inotify_remove_watch_locked+0x12/0x3e
 [<c02896d7>] mutex_lock+0x1a/0x29
 [<c017de59>] inotify_rm_wd+0x6d/0x8a
 [<c017e322>] sys_inotify_rm_watch+0x38/0x4f
 [<c0102dcb>] syscall_call+0x7/0xb
 [<c028007b>] xfrm_policy_flush+0x10e/0x180
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Greetings,

Eike

--nextPart2143717.zDc6n8IvU3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFgSWbXKSJPmm5/E4RAgyPAKCQSLKgBJUcF/8akuqPBoxBBPCnWQCdHB+8
ED/wXHPFHayhHNrRFQvYjHM=
=mKsj
-----END PGP SIGNATURE-----

--nextPart2143717.zDc6n8IvU3--
