Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030566AbWBHGPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030566AbWBHGPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbWBHGPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:15:36 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60894 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030553AbWBHGPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:15:35 -0500
Date: Wed, 8 Feb 2006 06:15:31 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] unify pfn_to_page take 2 [13/25] m68k funcs
Message-ID: <20060208061531.GE27946@ftp.linux.org.uk>
References: <43E98AC2.4090005@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E98AC2.4090005@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 03:08:02PM +0900, KAMEZAWA Hiroyuki wrote:
> m68k seems not to keep 'memmap + pfn == page_to_pfn(pfn)'
> because kaddr is remapped.
> 
> Use its own pfn_to_page() funcs.
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Index: test-layout-free-zone/arch/m68k/Kconfig
> ===================================================================
> --- test-layout-free-zone.orig/arch/m68k/Kconfig
> +++ test-layout-free-zone/arch/m68k/Kconfig
> @@ -26,6 +26,10 @@ config ARCH_MAY_HAVE_PC_FDC
>  	depends on Q40 || (BROKEN && SUN3X)
>  	default y
> 
> +config ARHC_HAS_PFN_TO_PAGE

tpyo?
