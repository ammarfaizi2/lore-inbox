Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbTJKOmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 10:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTJKOmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 10:42:12 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:38081 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S263308AbTJKOmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 10:42:10 -0400
Subject: [2.6.0-test7-bk][BUG] ext3_free_blocks: bit already cleared for
	block 512
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NpIPsnwS/MT9E+clN/0b"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1065881959.1062.1.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 11 Oct 2003 16:19:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NpIPsnwS/MT9E+clN/0b
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

EXT3-fs error (device hda1): ext3_free_blocks: bit already cleared for
block 512
Remounting filesystem read-only
bad: scheduling while atomic!
Call Trace:
 [<c0117601>] schedule+0x561/0x580
 [<c01d7771>] do_ide_request+0x11/0x20
 [<c01cce5f>] generic_unplug_device+0x5f/0x80
 [<c01ccfae>] blk_run_queues+0x6e/0xc0
 [<c011854e>] io_schedule+0xe/0x20
 [<c014c05b>] __wait_on_buffer+0xbb/0xc0
 [<c0118c60>] autoremove_wake_function+0x0/0x40
 [<c01ce2b5>] submit_bio+0x35/0x80
 [<c0118c60>] autoremove_wake_function+0x0/0x40
 [<c014f35a>] sync_dirty_buffer+0x3a/0xa0
 [<c0185cd3>] ext3_handle_error+0x53/0xa0
 [<c0185d58>] ext3_error+0x38/0x40
 [<c017c217>] ext3_free_blocks+0x3d7/0x480
 [<c0180dfb>] ext3_free_data+0xbb/0x120
 [<c01814f5>] ext3_truncate+0x4b5/0x520
 [<c018bd1c>] journal_stop+0x17c/0x260
 [<c018a9df>] journal_start+0x7f/0xc0
 [<c017ec75>] start_transaction+0x15/0x60
 [<c017edd9>] ext3_delete_inode+0x99/0xe0
 [<c017ed40>] ext3_delete_inode+0x0/0xe0
 [<c01628e1>] generic_delete_inode+0x61/0x100
 [<c0162b18>] iput+0x58/0x80
 [<c015953d>] sys_unlink+0xdd/0x120
 [<c0109027>] syscall_call+0x7/0xb


--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/



--=-NpIPsnwS/MT9E+clN/0b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/iBFmRGk68b69cdURAkigAJ9zJaLhWk3lGoP8Heg25/R4bej8tQCfZNIb
4U4mP+stwbhGcu6YMz0pM80=
=0Jjz
-----END PGP SIGNATURE-----

--=-NpIPsnwS/MT9E+clN/0b--

