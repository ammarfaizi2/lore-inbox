Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRCaCvF>; Fri, 30 Mar 2001 21:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132005AbRCaCu4>; Fri, 30 Mar 2001 21:50:56 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:9476 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131986AbRCaCuo>; Fri, 30 Mar 2001 21:50:44 -0500
Message-Id: <200103310250.f2V2o1fw001120@pincoya.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
cc: sparclinux@vger.kernel.org
Subject: 2.4.3 CVS 20010330: No floppy
X-Mailer: MH [Version 6.8.4]
Date: Fri, 30 Mar 2001 22:50:00 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostlt RH 6.2 on sparc64. 2.2.18 works fine. A strace(1) of a failed
mdir(1) ends:

open("/dev/fd0", O_RDONLY|O_LARGEFILE)  = 3
SYS_63()                                = 0
flock(3, LOCK_SH|LOCK_NB)               = 0
ioctl(3, FDGETPRM, 0xefffde98)          = -1 ENODEV (No such device)
close(3)                                = 0
write(2, "init: set default params\n", 25init: set default params
) = 25
write(2, "Cannot initialize \'A:\'\n", 23Cannot initialize 'A:'
) = 23
exit(1)                                 = ?
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
