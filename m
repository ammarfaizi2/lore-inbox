Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272242AbTHIAwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHIAwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:52:07 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:49360 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S272168AbTHIAvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:51:31 -0400
Date: Sat, 9 Aug 2003 02:51:24 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: I2C errors
Message-Id: <20030809025124.7ed1395e.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.iJfA(vcjbpSv5I"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.iJfA(vcjbpSv5I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Greg,

Both under 2.4 and 2.5/2.6 I'm getting occasional I2C errors like these:

i2c-algo-bit.o: bt848 #0 i2c_write: error - bailout.
msp34xx: I/O error #1 (read 0x12/0x18)

They repeat every 5 minutes or so until the video device (bttv) is
reinitialized. 

Any ideas what's going on?

Regards,
-Udo.

--=.iJfA(vcjbpSv5I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE/NEWPnhRzXSM7nSkRAhHoAJ91tTBTDTPjA0nXsCEVyzeFL/TgqACeM5eZ
c65tF36I5SIPOiuz65Vq8Zk=
=ZTRu
-----END PGP SIGNATURE-----

--=.iJfA(vcjbpSv5I--
