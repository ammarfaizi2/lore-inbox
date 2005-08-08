Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVHHRwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVHHRwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVHHRwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:52:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932159AbVHHRwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:52:42 -0400
Date: Mon, 8 Aug 2005 10:51:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] add MODULE_ALIAS for x86_64 aes
Message-Id: <20050808105109.5e3168fc.akpm@osdl.org>
In-Reply-To: <20050808173336.GA11503@suse.de>
References: <20050808173336.GA11503@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
> 
> modprobe aes does not work on x86_64. i386 has a similar line,
> this could be the right fix. Would be nice to have in 2.6.13 final.
> 

What do you mean by "this could be the right fix"?  Did it work?

> 
> Index: linux-2.6.13-rc6-aes/arch/x86_64/crypto/aes.c
> ===================================================================
> --- linux-2.6.13-rc6-aes.orig/arch/x86_64/crypto/aes.c
> +++ linux-2.6.13-rc6-aes/arch/x86_64/crypto/aes.c
> @@ -322,3 +322,4 @@ module_exit(aes_fini);
>  
>  MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("aes");
