Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275294AbRJJKuB>; Wed, 10 Oct 2001 06:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275301AbRJJKtv>; Wed, 10 Oct 2001 06:49:51 -0400
Received: from fismat1.fcfm.buap.mx ([148.228.125.1]:44718 "EHLO
	fismat1.fcfm.buap.mx") by vger.kernel.org with ESMTP
	id <S275294AbRJJKtm>; Wed, 10 Oct 2001 06:49:42 -0400
Date: Wed, 10 Oct 2001 04:49:34 -0500 (CDT)
From: Luis Montgomery <monty@fismat1.fcfm.buap.mx>
To: linux-kernel@vger.kernel.org
Subject: 2.4.11: scsi problem
Message-ID: <Pine.GSO.4.21.0110100441530.27961-100000@fismat1.fcfm.buap.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I try to compile 2.4.11 and fail:

scsi_debug.c: In function `scsi_debug_biosparam':
scsi_debug.c:665: warning: unused variable `size'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.11/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.11/include/linux/modversions.h   -c -o
cpqfcTSinit.o cpqfcTSinit.c
cpqfcTSinit.c: In function `cpqfcTS_ioctl':
cpqfcTSinit.c:663: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in
this function)
cpqfcTSinit.c:663: (Each undeclared identifier is reported only once
cpqfcTSinit.c:663: for each function it appears in.)
cpqfcTSinit.c:681: `SCSI_IOCTL_FC_TDR' undeclared (first use in this
function)
make[2]: *** [cpqfcTSinit.o] Error 1
make[2]: Saliendo directorio `/usr/src/linux-2.4.11/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Saliendo directorio `/usr/src/linux-2.4.11/drivers'
make: *** [_mod_drivers] Error 2



Luis Montgomery

