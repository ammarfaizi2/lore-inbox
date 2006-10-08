Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWJHXt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWJHXt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWJHXt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:49:58 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51166 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932123AbWJHXt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:49:57 -0400
Message-Id: <200610082031.k98KV99S008302@laptop13.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SPARC64 2.6.19-rc1 (git cb1055...) non-SMP build failure
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Sun, 08 Oct 2006 16:31:09 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 08 Oct 2006 19:49:55 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting:

  CC      arch/sparc64/kernel/time.o
arch/sparc64/kernel/time.c: In function 'timer_interrupt':
arch/sparc64/kernel/time.c:463: error: too many arguments to function 'profile_tick'
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
