Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131612AbRAERWT>; Fri, 5 Jan 2001 12:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131504AbRAERWK>; Fri, 5 Jan 2001 12:22:10 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:35336 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131639AbRAERVy>; Fri, 5 Jan 2001 12:21:54 -0500
Message-Id: <200101051721.f05HLaP21812@pincoya.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
cc: sparclinux@vger.kernel.org
Subject: 2.4.0 on sparc64 build problems
X-Mailer: MH [Version 6.8.4]
Date: Fri, 05 Jan 2001 14:21:35 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun Ultra 1, RH 6.2 + updates (+ local hacks)

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
  [Ad nauseam]

  dbri.c:67: ../../isdn/hisax/foreign.h: No such file or directory
  [More or less the same junk as above]
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
