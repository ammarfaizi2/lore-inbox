Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUEJUb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUEJUb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUEJUb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:31:58 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58318 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261568AbUEJUbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:31:52 -0400
Message-Id: <200405102031.i4AKVXLg022041@eeyore.valparaiso.cl>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK) 
In-Reply-To: Your message of "Mon, 10 May 2004 15:49:58 -0400."
             <c7om3o$akd$1@gatekeeper.tmr.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 10 May 2004 16:31:33 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> said:

[...]

> I tried 4k stack, I couldn't measure any improvement in anything (as in 
> no visible speedup or saving in memory).

4K stacks lets the kernel create new threads/processes as long as there is
free memory; with 8K stacks it needs two consecutive free page frames in
physical memory, when memory is fragmented (and large) they are hard to
come by...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
