Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTIGAD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 20:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTIGAD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 20:03:27 -0400
Received: from smtp1.libero.it ([193.70.192.51]:213 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S261464AbTIGAD0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 20:03:26 -0400
From: chimicus <chimicus75@libero.it>
To: linux-kernel@vger.kernel.org
Subject: compilation error in 2.4.23-pre3
Date: Sun, 7 Sep 2003 02:05:57 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309070206.10477.chimicus75@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi, 
i failed compiling 2.4.23-pre3 because of this error:
...
In file included from via82cxxx.c:39:
../ide-timing.h: In function `ide_find_best_mode':
../ide-timing.h:124: `XFER_UDMA_133' undeclared (first use in this function)
../ide-timing.h:124: (Each undeclared identifier is reported only once
../ide-timing.h:124: for each function it appears in.)
via82cxxx.c: In function `via_get_info':
via82cxxx.c:250: duplicate case value
via82cxxx.c:246: previously used here
via82cxxx.c: In function `via82cxxx_ide_dma_check':
via82cxxx.c:407: `XFER_UDMA_133' undeclared (first use in this function)
make[4]: *** [via82cxxx.o] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.22/drivers/ide/pci'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.22/drivers/ide/pci'
make[2]: *** [_subdir_pci] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.22/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.22/drivers'
make: *** [_dir_drivers] Error 2
...
I think it's not difficult to correct but i'm not a C programmer :-(
- -- 
trattiamo gli italiani come persone e non come italiani

Emiliano Testa
ICQ #:64933789
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/WnZwQ324q/o2n0ERAu8wAJ4t99aCzpRC/IgWx3DJjb1IPHPmfACfR8tm
pjVSxR1kd2qeK10i5hOLTH8=
=6X0b
-----END PGP SIGNATURE-----

