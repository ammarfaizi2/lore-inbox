Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270526AbTGUQqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270543AbTGUQqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:46:32 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:57216 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S270526AbTGUQq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:46:29 -0400
Date: Mon, 21 Jul 2003 13:01:30 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Adaptec i2o and 2.6.0-test1-ac2
Message-ID: <20030721170130.GA736@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Trying to put my fileserver on 2.6.0-test1-ac2 and I get this:


  LD      drivers/message/built-in.o
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


Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/HBxq8+1vMONE2jsRAsjhAJ9dwCUKbrKANkP6xftBRINxWnVbpwCeKIma
7/KLDo+DSb6ncaoCKtQ5kCo=
=HhoW
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
