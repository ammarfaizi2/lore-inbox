Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTJIM3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTJIM3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:29:54 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:49896 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S262092AbTJIM3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:29:52 -0400
Subject: [2.6.0-test7-bk] undefined reference to `NEW_TO_OLD_GID'
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tfKnlsI2fvQkNdxDhVLT"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1065702589.2234.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 14:29:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tfKnlsI2fvQkNdxDhVLT
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi.

I obtain this building the current test7-bk

 LD      .tmp_vmlinux1
fs/built-in.o(.text+0x29144): En la funci=F3n `fill_psinfo':
: undefined reference to `NEW_TO_OLD_UID'
fs/built-in.o(.text+0x29153): En la funci=F3n `fill_psinfo':
: undefined reference to `NEW_TO_OLD_GID'
ipc/built-in.o(.text+0x433): En la funci=F3n `ipc64_perm_to_ipc_perm':
: undefined reference to `NEW_TO_OLD_UID'
ipc/built-in.o(.text+0x43f): En la funci=F3n `ipc64_perm_to_ipc_perm':
: undefined reference to `NEW_TO_OLD_GID'
ipc/built-in.o(.text+0x44b): En la funci=F3n `ipc64_perm_to_ipc_perm':
: undefined reference to `NEW_TO_OLD_UID'
ipc/built-in.o(.text+0x457): En la funci=F3n `ipc64_perm_to_ipc_perm':
: undefined reference to `NEW_TO_OLD_GID'
make: *** [.tmp_vmlinux1] Error 1


The warnings:

  CC      fs/binfmt_elf.o
fs/binfmt_elf.c: En la funci=F3n `fill_psinfo':
fs/binfmt_elf.c:1123: aviso: implicit declaration of function
`NEW_TO_OLD_UID'
fs/binfmt_elf.c:1124: aviso: implicit declaration of function
`NEW_TO_OLD_GID'

 CC      ipc/util.o
ipc/util.c: En la funci=F3n `ipc64_perm_to_ipc_perm':
ipc/util.c:424: aviso: implicit declaration of function `NEW_TO_OLD_UID'
ipc/util.c:425: aviso: implicit declaration of function `NEW_TO_OLD_GID'


--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/



--=-tfKnlsI2fvQkNdxDhVLT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/hVS8RGk68b69cdURAnAHAJ0XwEm42YFN2ty/mrMkQm17jRqwFQCeNrq0
tBZNWn0lELjQOx2XI7dJ5H4=
=wpnw
-----END PGP SIGNATURE-----

--=-tfKnlsI2fvQkNdxDhVLT--

