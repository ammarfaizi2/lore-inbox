Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263404AbTJKWSk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 18:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTJKWSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 18:18:39 -0400
Received: from viriato1.servicios.retecal.es ([212.89.0.44]:9143 "EHLO
	viriato1.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S263404AbTJKWSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 18:18:37 -0400
Subject: [2.6.0-test7-bk][OOPS] bad: scheduling while atomic!
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rjTe0cn5CdHYM4G/9CgH"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1065908535.1223.8.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 11 Oct 2003 23:42:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rjTe0cn5CdHYM4G/9CgH
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I obtain this when I try to suspend and then wake up the system (with
APM, of course)

bad: scheduling while atomic!
Call Trace:
 [<c0117601>] schedule+0x561/0x580
 [<c0121a90>] __mod_timer+0xd0/0x180
 [<c01225b8>] schedule_timeout+0x58/0xa0
 [<c0122540>] process_timeout+0x0/0x20
 [<c019ee86>] pci_set_power_state+0xc6/0x140
 [<d0861020>] rtl8139_suspend+0x60/0xa0 [8139too]
 [<c01a0da7>] pci_device_suspend+0x27/0x40
 [<c01caee7>] suspend_device+0x67/0xc0
 [<c01caf91>] device_suspend+0x51/0x80
 [<c0113efb>] suspend+0xbb/0x1c0
 [<c0114729>] do_ioctl+0x109/0x180
 [<c015b54f>] sys_ioctl+0xef/0x260
 [<c0109027>] syscall_call+0x7/0xb

--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-rjTe0cn5CdHYM4G/9CgH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/iHk3RGk68b69cdURAloFAJ9nv19stm/p0G/LbHqakBP2GFv/nQCbBxkm
pth1t+mDHCtuMIwXExn9YCs=
=pTy7
-----END PGP SIGNATURE-----

--=-rjTe0cn5CdHYM4G/9CgH--

