Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVHBNCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVHBNCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 09:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVHBNCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 09:02:08 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:12204 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261513AbVHBNBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 09:01:21 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: [PATCH] no-idle-hz aka dynamic ticks
Date: Tue, 2 Aug 2005 23:00:53 +1000
User-Agent: KMail/1.8.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       tuukka.tikkanen@elektrobit.com
References: <200508022225.31429.kernel@kolivas.org> <42EF6DF7.6030100@punnoor.de>
In-Reply-To: <42EF6DF7.6030100@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508022300.54043.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005 22:58, Prakash Punnoor wrote:
> Con Kolivas schrieb:
> > As promised, here is an updated patch for the newly released 2.6.13-rc5.
> > Boots and runs fine on P4HT (SMP+SMT kernel) built with gcc 4.0.1.
>
> Doesn't compile for me w/ gcc 3.4.4:
>
>
>   CC      arch/i386/kernel/irq.o
> In file included from include/linux/dyn-tick.h:64,
>                  from arch/i386/kernel/irq.c:21:
> include/asm/dyn-tick.h: In function `reprogram_apic_timer':
> include/asm/dyn-tick.h:48: warning: implicit declaration of function
> `apic_write_around'
> include/asm/dyn-tick.h:48: error: `APIC_TMICT' undeclared (first use in
> this function)
> include/asm/dyn-tick.h:48: error: (Each undeclared identifier is reported
> only once
> include/asm/dyn-tick.h:48: error: for each function it appears in.)
> make[1]: *** [arch/i386/kernel/irq.o] Error 1

Please send me a .config

Cheers,
Con
