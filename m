Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318118AbSHGNuj>; Wed, 7 Aug 2002 09:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSHGNuj>; Wed, 7 Aug 2002 09:50:39 -0400
Received: from iris.mc.com ([192.233.16.119]:5100 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S318118AbSHGNui>;
	Wed, 7 Aug 2002 09:50:38 -0400
Message-Id: <200208071354.JAA05835@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc3-ac5 UP compile error 
Date: Wed, 7 Aug 2002 10:00:20 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


when compiling for SMP no problems, but when compiling for UP using same 
.config with only change being UP instead of SMP I get the following error:


686   -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
 -DKBUILD_BASENAME=ksyms  -DEXPORT_SYMTAB -c ksyms.c In file included from
 ksyms.c:18:
/usr/src/linux/include/linux/kernel_stat.h: In function `kstat_irqs':
/usr/src/linux/include/linux/kernel_stat.h:46: `smp_num_cpus' undeclared
 (first use in this function) /usr/src/linux/include/linux/kernel_stat.h:46:
 (Each undeclared identifier is reported only once
 /usr/src/linux/include/linux/kernel_stat.h:46: for each function it appears
 in.) make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2


-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
** If you would like to sponsor me for the       **
** Mass Getaway, a 150 mile bicycle ride to for  **
** MS, contact me to donate by cash or check or  **
** click the link below to donate by credit card **
**************************************************/
https://www.nationalmssociety.org/pledge/pledge.asp?participantid=86736
