Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWIYQuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWIYQuy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWIYQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:50:53 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47567 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751256AbWIYQuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:50:52 -0400
Message-Id: <200609251650.k8PGodOl005239@laptop13.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.18-git on SPARC64: Section mismatches
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Mon, 25 Sep 2006 12:50:39 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 25 Sep 2006 12:50:39 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following today:

  Building modules, stage 2.
  MODPOST 425 modules
WARNING: arch/sparc64/solaris/solaris.o - Section mismatch: reference to .init.text:init_socksys from .text between 'init_module' (at offset 0x2a14) and 'solaris_register'
WARNING: drivers/net/sunlance.o - Section mismatch: reference to .init.text: from .text between 'sunlance_sbus_probe' (at offset 0x350) and 'lance_set_multicast'
WARNING: sound/sparc/snd-sun-amd7930.o - Section mismatch: reference to .init.text: from .text between 'amd7930_sbus_probe' (at offset 0x4c0) and 'snd_amd7930_capture_prepare'

Dunno how long this has been going on, just spotted it today.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
