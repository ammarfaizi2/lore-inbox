Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWH3JKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWH3JKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 05:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWH3JKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 05:10:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56790 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750748AbWH3JKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 05:10:19 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060828085244.GA13544@flint.arm.linux.org.uk> 
References: <20060828085244.GA13544@flint.arm.linux.org.uk> 
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
       linuxppc-embedded@ozlabs.org, paulkf@microgate.com,
       takata@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 30 Aug 2006 10:09:54 +0100
Message-ID: <20539.1156928994@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> --- a/arch/frv/kernel/setup.c
> +++ b/arch/frv/kernel/setup.c
> @@ -31,7 +31,6 @@
>  #include <linux/serial_reg.h>
>  
>  #include <asm/setup.h>
> -#include <asm/serial.h>
>  #include <asm/irq.h>
>  #include <asm/sections.h>
>  #include <asm/pgalloc.h>

Acked-By: David Howells <dhowells@redhat.com>
