Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSLJEjo>; Mon, 9 Dec 2002 23:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSLJEjo>; Mon, 9 Dec 2002 23:39:44 -0500
Received: from mx.eunet.at ([193.154.160.152]:15358 "EHLO
	laweleka.austria.eu.net") by vger.kernel.org with ESMTP
	id <S265578AbSLJEjn>; Mon, 9 Dec 2002 23:39:43 -0500
Date: Tue, 10 Dec 2002 05:47:28 +0100 (CET)
From: Clemens Schwaighofer <schwaigl@eunet.at>
X-X-Sender: gullevek@linux.gullevek.intern
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: modules build error with redhat 2.4.18-18.8.0
Message-ID: <Pine.LNX.4.44.0212100537530.20506-100000@linux.gullevek.intern>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I have a rh 8.0 box with updated kernel:
Linux version 2.4.18-18.8.0 (bhcompile@sylvester.devel.redhat.com) (gcc 
version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Wed Nov 13 23:08:45 EST 
2002

in the defaul rh8.0 config from the kernel I turned on IPX: Full Internal 
IPX network and make a make dep && make modules I get this error

...
/usr/src/linux-2.4.18-18.8.0/include/net/sock.h: In function 
`sk_filter_release':
/usr/src/linux-2.4.18-18.8.0/include/net/sock.h:934: warning: implicit 
declaration of function `kfree_R037a0cba'
/usr/src/linux-2.4.18-18.8.0/include/net/sock.h: In function 
`sock_orphan':
/usr/src/linux-2.4.18-18.8.0/include/net/sock.h:1009: 
`do_softirq_Rf0a529b7' undeclared (first use in this function)
/usr/src/linux-2.4.18-18.8.0/include/net/sock.h: In function `sock_graft':
/usr/src/linux-2.4.18-18.8.0/include/net/sock.h:1018: 
`do_softirq_Rf0a529b7' undeclared (first use in this function)
/usr/src/linux-2.4.18-18.8.0/include/net/sock.h: In function 
`sock_recv_timestamp':
/usr/src/linux-2.4.18-18.8.0/include/net/sock.h:1266: warning: implicit 
declaration of function `put_cmsg_Rf39bf4d9'
module.c: In function `cipe_check_kernel':
module.c:73: warning: implicit declaration of function `printk_R1b7d4074'
make[3]: *** [module.o] Error 1
make[3]: Leaving directory 
`/usr/src/linux-2.4.18-18.8.0/drivers/addon/cipe'
make[2]: *** [_modsubdir_cipe] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.18-18.8.0/drivers/addon'
make[1]: *** [_modsubdir_addon] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.18-18.8.0/drivers'
make: *** [_mod_drivers] Error 2

-- 
"Linux wurde erfunden, damit nicht jeder Idiot denkt, er könne einen
Computer bedienen!" - Guestbook Eintrag bei einer Linux Hate Page
mfg, Clemens Schwaighofer              E-Mail: gullevek@gullevek.org
http://www.animeundmanga.at                  http://www.gullevek.org

