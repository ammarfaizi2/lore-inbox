Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282940AbRK0UpM>; Tue, 27 Nov 2001 15:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282941AbRK0Uov>; Tue, 27 Nov 2001 15:44:51 -0500
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:8690 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S282940AbRK0Uoi>; Tue, 27 Nov 2001 15:44:38 -0500
Posted-Date: Tue, 27 Nov 2001 21:36:11 GMT
Date: Tue, 27 Nov 2001 21:44:29 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200111272044.fARKiTv13653@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre2 does not compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've the following error :

gcc -D__KERNEL__ -I/usr/src/kernel-sources-2.5.1-pre2/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-DMODULE -DMODVERSIONS -include
/usr/src/kernel-sources-2.5.1-pre2/include/linux/modversions.h   -c -o
aha1542.o aha1542.c
aha1542.c: In function `do_aha1542_intr_handle':
aha1542.c:423: `io_request_lock' undeclared (first use in this function)
aha1542.c:423: (Each undeclared identifier is reported only once
aha1542.c:423: for each function it appears in.)
aha1542.c: In function `aha1542_bus_reset':
aha1542.c:1479: `io_request_lock' undeclared (first use in this function)
aha1542.c: In function `aha1542_host_reset':
aha1542.c:1543: `io_request_lock' undeclared (first use in this function)
aha1542.c: At top level:
aha1542.c:114: warning: `setup_str' defined but not used
make[3]: *** [aha1542.o] Erreur 1
make[3]: Leaving directory `/usr/src/kernel-sources-2.5.1-pre2/drivers/scsi'
make[2]: *** [_modsubdir_scsi] Erreur 2
make[2]: Leaving directory `/usr/src/kernel-sources-2.5.1-pre2/drivers'
make[1]: *** [_mod_drivers] Erreur 2
make[1]: Leaving directory `/usr/src/kernel-sources-2.5.1-pre2'
make: *** [stamp-build] Erreur 2

-------
Regards
		Jean-Luc
