Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVC2Qi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVC2Qi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVC2Qi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:38:26 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50132 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261205AbVC2QiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:38:21 -0500
Message-Id: <200503291638.j2TGcJhY023869@laptop11.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc1 from bk today: Build failure on i386
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 29 Mar 2005 12:38:19 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 29 Mar 2005 12:38:19 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting:

  CC [M]  net/sched/cls_u32.o
  net/sched/cls_u32.c: In function `u32_dump':
  net/sched/cls_u32.c:778: error: structure has no member named `action'
  net/sched/cls_u32.c:778: error: structure has no member named `action'
  make[2]: *** [net/sched/cls_u32.o] Error 1
  make[1]: *** [net/sched] Error 2

The patch including the reference to action there is quite recent: 25
March, by hadi@cyberus.ca and signed off by David Miller. There are other
files mangled in similar ways in the same changeset.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
