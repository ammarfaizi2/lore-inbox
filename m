Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWJCPKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWJCPKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWJCPKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:10:19 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41913 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964816AbWJCPKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:10:16 -0400
Message-Id: <200610031510.k93FACHw004955@laptop13.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-2.6.18 (git 95f3ef...) on sparc64 fails to build
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Tue, 03 Oct 2006 11:10:12 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 03 Oct 2006 11:10:12 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      init/main.o
In file included from include/asm/signal.h:11,
                 from include/linux/signal.h:4,
                 from include/linux/sched.h:67,
                 from include/linux/module.h:9,
                 from init/main.c:13:
include/linux/compat.h:231: error: expected ')' before '*' token

The one at "fault" is the first one in:

extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
                               ^^^^^^^^^^^^^
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
