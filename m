Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVKPFSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVKPFSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 00:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVKPFSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 00:18:06 -0500
Received: from ozlabs.org ([203.10.76.45]:6329 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932580AbVKPFSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 00:18:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17274.49289.583486.477211@cargo.ozlabs.ibm.com>
Date: Wed, 16 Nov 2005 16:15:53 +1100
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       mnutter@us.ibm.com, Arnd Bergmann <arndb@de.ibm.com>
Subject: Re: [PATCH 1/5] spufs: The SPU file system, base
In-Reply-To: <20051115210408.327453000@localhost>
References: <20051115205347.395355000@localhost>
	<20051115210408.327453000@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> --- linux-2.6.15-rc.orig/arch/ppc/kernel/ppc_ksyms.c
> +++ linux-2.6.15-rc/arch/ppc/kernel/ppc_ksyms.c
> @@ -311,7 +311,6 @@ EXPORT_SYMBOL(__res);
>  
>  EXPORT_SYMBOL(next_mmu_context);
>  EXPORT_SYMBOL(set_context);
> -EXPORT_SYMBOL_GPL(__handle_mm_fault); /* For MOL */

Why?  What have you got against MOL? :)

Paul.
