Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264118AbTKJVfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 16:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbTKJVfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 16:35:42 -0500
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:27812 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S264118AbTKJVfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 16:35:41 -0500
Subject: [2.6.0-test9-mm2] Badness in as_put_request at
	drivers/block/as-iosched.c:1783
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4NadmQbYGTjZvrz/10/2"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1068500134.2060.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 10 Nov 2003 22:35:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4NadmQbYGTjZvrz/10/2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi.

Trying to scan de ide-scsi devices of my system, I get this

arq->state 4
Badness in as_put_request at drivers/block/as-iosched.c:1783
Call Trace:
 [<c01dc908>] as_put_request+0x48/0xa0
 [<c01d47d3>] elv_put_request+0x13/0x20
 [<c01d69f2>] __blk_put_request+0x52/0xa0
 [<c01d6a61>] blk_put_request+0x21/0x40
 [<c01d9d0e>] sg_io+0x2ee/0x440
 [<c01da5c0>] scsi_cmd_ioctl+0x3c0/0x480
 [<c0124b49>] update_process_times+0x29/0x40
 [<c011949c>] schedule+0x31c/0x620
 [<d093bb65>] cdrom_ioctl+0x25/0xd60 [cdrom]
 [<c012eb33>] do_clock_nanosleep+0x1b3/0x300
 [<c0119800>] default_wake_function+0x0/0x20
 [<c01d86fa>] blkdev_ioctl+0x7a/0x383
 [<c01584be>] block_ioctl+0x1e/0x40
 [<c016158f>] sys_ioctl+0xef/0x260
 [<c0257c57>] syscall_call+0x7/0xb
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-4NadmQbYGTjZvrz/10/2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/sASlRGk68b69cdURApBmAJsFUZaInvux59xmnBbff22pZpWxfgCfZQCS
XPI/4/BxVQB+VZpgInFDIco=
=X3I/
-----END PGP SIGNATURE-----

--=-4NadmQbYGTjZvrz/10/2--

