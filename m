Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTAICHA>; Wed, 8 Jan 2003 21:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbTAICHA>; Wed, 8 Jan 2003 21:07:00 -0500
Received: from web11105.mail.yahoo.com ([216.136.131.152]:123 "HELO
	web11105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261354AbTAICG6>; Wed, 8 Jan 2003 21:06:58 -0500
Message-ID: <20030109021540.80049.qmail@web11105.mail.yahoo.com>
Date: Wed, 8 Jan 2003 23:15:40 -0300 (ART)
From: "=?iso-8859-1?q?Rodrigo=20F.=20Baroni?=" <rodrigobaroni@yahoo.com.br>
Reply-To: rodrigobaroni@yahoo.com.br
Subject: kernel compile error
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-326693096-1042078540=:80010"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-326693096-1042078540=:80010
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hello all,


    There is a good time that I have trying to compile
a kernel in a pc 233 mhz (motherboard lmr 591 -
chipset sis, all-on-board), and so the follow error
below happen.


     Does anybody knows what is going on please ?!
(it's a 2.4.18 kernel in a debian 3)




Rodrigo F Baroni
Computer Science Grad Student

_______________________________________________________________________
Busca Yahoo!
O melhor lugar para encontrar tudo o que você procura na Internet
http://br.busca.yahoo.com/
--0-326693096-1042078540=:80010
Content-Type: text/plain; name="kernel_log.txt"
Content-Description: kernel_log.txt
Content-Disposition: inline; filename="kernel_log.txt"

make[2]: Entering directory `/usr/src/kernel-source-2.4.18/kernel'
gcc -D__KERNEL__ -I/usr/src/kernel-source-2.4.18/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pi
pe -mpreferred-stack-boundary=2 -march=i586   -DKBUILD_BASENAME=ksyms  -DEXPORT_SYMTAB -c ksyms.c
In file included from /usr/src/kernel-source-2.4.18/include/linux/modversions.h:64,
                 from /usr/src/kernel-source-2.4.18/include/linux/module.h:21,
                 from ksyms.c:14:
/usr/src/kernel-source-2.4.18/include/linux/modules/dec_and_lock.ver:2: warning: `atomic_dec_and_lock' redefined
/usr/src/kernel-source-2.4.18/include/linux/spinlock.h:48: warning: this is the location of the previous definition
In file included from /usr/src/kernel-source-2.4.18/include/linux/modversions.h:117,
                 from /usr/src/kernel-source-2.4.18/include/linux/module.h:21,
                 from ksyms.c:14:
/usr/src/kernel-source-2.4.18/include/linux/modules/i386_ksyms.ver:84: warning: `cpu_data' redefined
/usr/src/kernel-source-2.4.18/include/asm/processor.h:79: warning: this is the location of the previous definition
/usr/src/kernel-source-2.4.18/include/linux/modules/i386_ksyms.ver:88: warning: `smp_num_cpus' redefined
/usr/src/kernel-source-2.4.18/include/linux/smp.h:80: warning: this is the location of the previous definition
/usr/src/kernel-source-2.4.18/include/linux/modules/i386_ksyms.ver:90: warning: `cpu_online_map' redefined
/usr/src/kernel-source-2.4.18/include/linux/smp.h:88: warning: this is the location of the previous definition
/usr/src/kernel-source-2.4.18/include/linux/modules/i386_ksyms.ver:104: warning: `smp_call_function' redefined
/usr/src/kernel-source-2.4.18/include/linux/smp.h:87: warning: this is the location of the previous definition
In file included from /usr/src/kernel-source-2.4.18/include/linux/modversions.h:144,
                 from /usr/src/kernel-source-2.4.18/include/linux/module.h:21,
                 from ksyms.c:14:
/usr/src/kernel-source-2.4.18/include/linux/modules/ksyms.ver:526: warning: `del_timer_sync' redefined
/usr/src/kernel-source-2.4.18/include/linux/timer.h:30: warning: this is the location of the previous definition
In file included from /usr/src/kernel-source-2.4.18/include/linux/interrupt.h:45,
                 from ksyms.c:21:
/usr/src/kernel-source-2.4.18/include/asm/hardirq.h:37: warning: `synchronize_irq' redefined
/usr/src/kernel-source-2.4.18/include/linux/modules/i386_ksyms.ver:92: warning: this is the location of the previous definition
In file included from ksyms.c:17:
/usr/src/kernel-source-2.4.18/include/linux/kernel_stat.h: In function `kstat_irqs':
/usr/src/kernel-source-2.4.18/include/linux/kernel_stat.h:48: `smp_num_cpus' undeclared (first use in this function)
/usr/src/kernel-source-2.4.18/include/linux/kernel_stat.h:48: (Each undeclared identifier is reported only once
/usr/src/kernel-source-2.4.18/include/linux/kernel_stat.h:48: for each function it appears in.)
make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/kernel-source-2.4.18/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/kernel-source-2.4.18/kernel'
make: *** [_dir_kernel] Error 2
carol:/usr/src/kernel-source-2.4.18# 


--0-326693096-1042078540=:80010--
