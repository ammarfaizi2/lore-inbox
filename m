Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbTGETXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbTGETQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:16:27 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:10132 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266436AbTGETOh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:14:37 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.21-bk1] arch/i386/kernel/dmi_scan.c compile warning fix
Date: Sat, 5 Jul 2003 20:11:51 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307052011.51869.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

fixes "Warning: unused variable `data'"
compiletime warning.

- --- arch/i386/kernel/dmi_scan.c.orig    2003-07-05 19:09:43.000000000 +0200
+++ arch/i386/kernel/dmi_scan.c 2003-07-05 20:09:09.000000000 +0200
@@ -941,8 +941,6 @@
 
 static void __init dmi_decode(struct dmi_header *dm)
 {
- -       u8 *data = (u8 *)dm;
- -
        switch(dm->type)
        {
                case  0:

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 20:09:15 up  1:12,  3 users,  load average: 1.03, 1.14, 1.16

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BxTnoxoigfggmSgRAknWAJwKwF95RPkrYHVQnc3m4CQfEhufogCcCznd
hzXhsGYcyzQXwXML/a77a4w=
=6cUu
-----END PGP SIGNATURE-----


