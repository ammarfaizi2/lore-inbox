Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131484AbRAERQ3>; Fri, 5 Jan 2001 12:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131560AbRAERQT>; Fri, 5 Jan 2001 12:16:19 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:34056 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131484AbRAERQB>; Fri, 5 Jan 2001 12:16:01 -0500
Message-Id: <200101051715.f05HFKP21377@pincoya.inf.utfsm.cl>
To: Alan.Cox@linux.org, sparclinux@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: 2.4.0-ac1 on sparc64: Build problems
X-Mailer: MH [Version 6.8.4]
Date: Fri, 05 Jan 2001 14:15:20 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun Ultra1, RH 6.2 + updates (+ local hacks).

Building vmlinux:

In arch/sparc64/kernel:

  sys_sparc32.c: In function `sys32_quotactl':
  sys_sparc32.c:907: storage size of `d' isn't known
  sys_sparc32.c:907: warning: unused variable `d'


Building modules:

In drivers/sbus/audio:

  amd7930.c:113: ../../isdn/hisax/foreign.h: No such file or directory
  amd7930.c:1159: warning: function declaration isn't a prototype
  amd7930.c: In function `amd7930_dxmit':
  amd7930.c:1266: warning: assignment from incompatible pointer type
  amd7930.c: In function `amd7930_drecv':
  amd7930.c:1312: warning: assignment from incompatible pointer type
  amd7930.c: At top level:
  amd7930.c:1486: variable `amd7930_foreign_interface' has initializer but incomplete type
  amd7930.c:1487: warning: excess elements in struct initializer after `amd7930_foreign_interface'
  [ad nauseam]

  dbri.c:67: ../../isdn/hisax/foreign.h: No such file or directory
  [Similar junk follows]

Build hasn't finished yet, but seems to be going fine after this.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
