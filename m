Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVG1Ryf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVG1Ryf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVG1Ry2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:54:28 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52713 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261766AbVG1RxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:53:25 -0400
Message-Id: <200507281753.j6SHrLBt025986@laptop11.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc3 current git
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 28 Jul 2005 13:53:21 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/i386/kernel/cpu/mtrr/main.c at line 225 it references
ipi_handler(), a function that is only declared under CONFIG_SMP (from line
139 onwards). As a result, the build fails.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

