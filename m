Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVCLS1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVCLS1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 13:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVCLS1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 13:27:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:46295 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbVCLS1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 13:27:12 -0500
Message-ID: <42333474.3070809@osdl.org>
Date: Sat, 12 Mar 2005 10:27:00 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peterc@gelato.unsw.edu.au>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Microstate Accounting for 2.6.11, patch 5/6
References: <16945.6090.637127.541151@berry.gelato.unsw.EDU.AU>
In-Reply-To: <16945.6090.637127.541151@berry.gelato.unsw.EDU.AU>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:
> Microstate accounting: Add the I386 system call.
> 
>  arch/i386/kernel/entry.S  |    2 +-
>  include/asm-i386/unistd.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6-ustate/arch/i386/kernel/entry.S
> ===================================================================
> --- linux-2.6-ustate.orig/arch/i386/kernel/entry.S	2005-03-10 09:16:14.888575341 +1100
> +++ linux-2.6-ustate/arch/i386/kernel/entry.S	2005-03-10 09:16:15.446188457 +1100
> @@ -876,7 +876,7 @@
>  	.long sys_mq_getsetattr
>  	.long sys_ni_syscall		/* reserved for kexec */
>  	.long sys_waitid
> -	.long sys_ni_syscall		/* 285 */ /* available */
> +	.long sys_msa			/* 285 */ /* available */
                                         no longer "available" ?
>  	.long sys_add_key
>  	.long sys_request_key
>  	.long sys_keyctl


-- 
~Randy
