Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVALOt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVALOt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 09:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVALOt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 09:49:56 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:28310 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261202AbVALOtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 09:49:53 -0500
Message-ID: <41E53918.1090703@tiscali.de>
Date: Wed, 12 Jan 2005 15:50:00 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: comment/whitespace updates
References: <20050112132005.GA1553@elf.ucw.cz>
In-Reply-To: <20050112132005.GA1553@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>This cleans few comments/formatting. Please apply,
>
>Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
>								Pavel
>
>--- clean/arch/i386/kernel/acpi/wakeup.S	2004-12-25 13:34:57.000000000 +0100
>+++ linux/arch/i386/kernel/acpi/wakeup.S	2004-12-25 15:51:04.000000000 +0100
>@@ -278,7 +294,7 @@
> 	movl %edi, saved_context_edi
> 	pushfl ; popl saved_context_eflags
> 
>-	movl $ret_point,saved_eip
>+	movl $ret_point, saved_eip
> 	ret
> 
> 
>@@ -295,7 +311,7 @@
> 	call	save_registers
> 	pushl	$3
> 	call	acpi_enter_sleep_state
>-	addl	$4,%esp
>+	addl	$4, %esp
> 	ret
> 	.p2align 4,,7
> ret_point:
>--- clean/drivers/acpi/events/evgpeblk.c	2004-12-25 13:34:58.000000000 +0100
>+++ linux/drivers/acpi/events/evgpeblk.c	2004-12-25 15:51:15.000000000 +0100
>@@ -925,7 +925,7 @@
> 
> 	/*
> 	 * Runtime option: Should Wake GPEs be enabled at runtime?  The default
>-	 * is No,they should only be enabled just as the machine goes to sleep.
>+	 * is No, they should only be enabled just as the machine goes to sleep.
> 	 */
> 	if (acpi_gbl_leave_wake_gpes_disabled) {
> 		/*
>--- clean/include/linux/page-flags.h	2005-01-12 11:07:40.000000000 +0100
>+++ linux/include/linux/page-flags.h	2005-01-12 11:25:19.000000000 +0100
>@@ -74,7 +74,7 @@
> #define PG_swapcache		16	/* Swap page: swp_entry_t in private */
> #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
> #define PG_reclaim		18	/* To be reclaimed asap */
>-#define PG_nosave_free		19	/* Free, should not be written */
>+#define PG_nosave_free		19	/* Page is free, and should not be written by swsusp */
> 
> 
> /*
>
>  
>
Very useful. :-)
Why do you send such a nonsense to mailinglist? It's poor.

Matthias-Christian Ott
