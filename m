Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271274AbTGWUDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271275AbTGWUDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:03:14 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:52380 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S271274AbTGWUC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:02:58 -0400
Date: Wed, 23 Jul 2003 16:18:01 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1-ac3 still broken on Adaptec I2O
Message-ID: <20030723201801.GB32585@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  CHK     include/linux/compile.h
  LD      drivers/scsi/scsi_mod.o
  CC      drivers/scsi/dpt_i2o.o
drivers/scsi/dpt_i2o.c:32:2: #error Please convert me to
Documentation/DMA-mapping.txt
drivers/scsi/dpt_i2o.c: In function `adpt_install_hba':
drivers/scsi/dpt_i2o.c:977: warning: passing arg 2 of `request_irq' from
incompatible pointer type
drivers/scsi/dpt_i2o.c: In function `adpt_scsi_to_i2o':
drivers/scsi/dpt_i2o.c:2118: error: structure has no member named
`address'
drivers/scsi/dpt_i2o.c: At top level:
drivers/scsi/dpt_i2o.c:165: warning: `dptids' defined but not used
make[2]: *** [drivers/scsi/dpt_i2o.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Hu158+1vMONE2jsRAi0tAKDnKpHb9Xqbn9+YX44K60S0AiqlwACgonkF
WBdgKbR/fQkU0Ckk9NqliX8=
=RV4q
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
