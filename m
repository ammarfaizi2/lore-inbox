Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136465AbRAHB5m>; Sun, 7 Jan 2001 20:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136503AbRAHB5U>; Sun, 7 Jan 2001 20:57:20 -0500
Received: from atol.icm.edu.pl ([212.87.0.35]:5136 "EHLO atol.icm.edu.pl")
	by vger.kernel.org with ESMTP id <S136419AbRAHB5K>;
	Sun, 7 Jan 2001 20:57:10 -0500
Date: Mon, 8 Jan 2001 02:56:56 +0100
From: Rafal Maszkowski <rzm@icm.edu.pl>
To: lizzi@cnam.fr
Cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.0: not loading fore200e
Message-ID: <20010108025656.A4450@burza.icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pure 2.4.0 on sparc32 with RedHat 6.2:

root@etest:/usr/src/6,0# modprobe fore200e
/lib/modules/2.4.0lt/kernel/drivers/atm/fore200e_sba_fw.o: couldn't find the kernel version the module was compiled for
/lib/modules/2.4.0lt/kernel/drivers/atm/fore200e_sba_fw.o: insmod /lib/modules/2.4.0lt/kernel/drivers/atm/fore200e_sba_fw.o failed
/lib/modules/2.4.0lt/kernel/drivers/atm/fore200e_sba_fw.o: insmod fore200e failed

root@etest:/usr/src/6,255# insmod /lib/modules/2.4.0lt/kernel/drivers/atm/fore200e_sba_fw.o
/lib/modules/2.4.0lt/kernel/drivers/atm/fore200e_sba_fw.o: couldn't find the kernel version the module was compiled for


The other, already known problem is that memory detection is broken. I managed
to start with mem=192mb and use 48 of total 64 MB this way.


Linux version 2.4.0lt (root@etest.icm.edu.pl) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Jan 8 01:31:34 MET 2001

Linux etest.icm.edu.pl 2.4.0lt #1 Mon Jan 8 01:31:34 MET 2001 sparc unknown
Kernel modules         2.4.0
Gnu C                  egcs-2.91.66
Gnu Make               3.78.1
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         openprom

R.
-- 
W iskier krzesaniu ¿ywem/Materia³ to rzecz g³ówna
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
