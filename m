Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVG1Stp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVG1Stp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVG1Sth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:49:37 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:23698 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261493AbVG1Stb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:49:31 -0400
Message-Id: <200507281849.j6SInQZY022446@laptop11.inf.utfsm.cl>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc3 current git 
In-Reply-To: Message from Horst von Brand <vonbrand@inf.utfsm.cl> 
   of "Thu, 28 Jul 2005 13:53:21 -0400." <200507281753.j6SHrLBt025986@laptop11.inf.utfsm.cl> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 28 Jul 2005 14:49:26 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> In arch/i386/kernel/cpu/mtrr/main.c at line 225 it references
> ipi_handler(), a function that is only declared under CONFIG_SMP (from line
> 139 onwards). As a result, the build fails.

Sorry for the noise, a few minutes later the updated git version works.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
