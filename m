Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030580AbWF0BNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbWF0BNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 21:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbWF0BNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 21:13:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21483
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030580AbWF0BNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 21:13:02 -0400
Date: Mon, 26 Jun 2006 18:12:16 -0700 (PDT)
Message-Id: <20060626.181216.126575476.davem@davemloft.net>
To: vonbrand@inf.utfsm.cl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 du jour on SPARC64: Build failure
From: David Miller <davem@davemloft.net>
In-Reply-To: <200606270041.k5R0fZqd008665@laptop11.inf.utfsm.cl>
References: <200606270041.k5R0fZqd008665@laptop11.inf.utfsm.cl>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst von Brand <vonbrand@inf.utfsm.cl>
Date: Mon, 26 Jun 2006 20:41:35 -0400

>   CC      arch/sparc64/kernel/devices.o
> In file included from include/linux/dma-mapping.h:27,
>                  from include/asm/sbus.h:10,
>                  from include/asm/dma.h:14,
>                  from include/linux/bootmem.h:8,
>                  from arch/sparc64/kernel/devices.c:15:
> include/asm/dma-mapping.h: In function `dma_sync_single_range_for_cpu':
> include/asm/dma-mapping.h:186: warning: implicit declaration of function `dma_sy

Thanks for the report.
