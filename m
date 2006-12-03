Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760121AbWLCVyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760121AbWLCVyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760120AbWLCVyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:54:40 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50649 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1760121AbWLCVyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:54:39 -0500
Message-Id: <200612032108.kB3L84uP014176@laptop13.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.19 git 2b5f6dcce...: current_is_keventd() AWOL?
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Sun, 03 Dec 2006 18:08:04 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:46:31 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 03 Dec 2006 18:54:38 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile that kernel on i686 the build fails in
drivers/net/phy/libphy.ko (drivers/net/phy/phy.c, line 590) due to
current_is_keventd() missing.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
