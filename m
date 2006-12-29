Return-Path: <linux-kernel-owner+w=401wt.eu-S1755014AbWL2BgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbWL2BgJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 20:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbWL2BgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 20:36:09 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48264 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755014AbWL2BgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 20:36:08 -0500
Message-Id: <200612290136.kBT1a2sO006708@laptop13.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc2: known unfixed regressions 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Thu, 28 Dec 2006 23:39:09 BST." <20061228223909.GK20714@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Thu, 28 Dec 2006 22:36:02 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:35:17 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 28 Dec 2006 22:36:06 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> This email lists some known regressions in 2.6.20-rc2 compared to 2.6.19.

Add that on SPARC64 boot fails due to missing /dev/root. Vanilla 2.6.19 and
2.6.19.1 work fine, before 2.6.20-rc1 it broke. I checked the initrds for
both versions, the only difference "diff -Nur" finds between the unpacked
initrds are the modules themselves (obviously).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
