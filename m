Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUL1Dsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUL1Dsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUL1Dsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:48:37 -0500
Received: from adsl-64-109-89-108.dsl.chcgil.ameritech.net ([64.109.89.108]:6065
	"EHLO redscar") by vger.kernel.org with ESMTP id S262045AbUL1Dsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:48:36 -0500
Subject: Re: [PATCH] fix conflicting cpu_idle() declarations
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, wli@holomorphy.com, davem@davemloft.net,
       lethal@linux-sh.org, davidm@hpl.hp.com, schwidefsky@de.ibm.com,
       takata@inux-m32r.org, ak@suse.de, rth@twiddle.net, matthew@wil.cx
In-Reply-To: <41D033FE.7AD17627@tv-sign.ru>
References: <41D033FE.7AD17627@tv-sign.ru>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 21:48:03 -0600
Message-Id: <1104205683.7447.36.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-27 at 19:10 +0300, Oleg Nesterov wrote: 
> cpu_idle() declared/defined in
> 
> init/main.c:				void cpu_idle(void)
> 
> i386/kernel/process.c			void cpu_idle(void)
> i386/kernel/smpboot.c:			int  cpu_idle(void)
> i386/mach-voyager/voyager_smp.c:	int  cpu_idle(void)

Patch looks good. This bit applies and compiles and boots fine on my
voyager.

James


