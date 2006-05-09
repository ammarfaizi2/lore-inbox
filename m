Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWEJUAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWEJUAj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWEJUAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:00:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20751 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751504AbWEJUAi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:00:38 -0400
Date: Tue, 9 May 2006 07:16:41 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
Message-ID: <20060509071640.GA4150@ucw.cz>
References: <20060509084945.373541000@sous-sol.org> <20060509085154.802230000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085154.802230000@sous-sol.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- linus-2.6.orig/include/asm-i386/mach-default/mach_system.h
> +++ linus-2.6/include/asm-i386/mach-default/mach_system.h
> @@ -1,6 +1,8 @@
>  #ifndef __ASM_MACH_SYSTEM_H
>  #define __ASM_MACH_SYSTEM_H
>  
> +#define clearsegment(seg)

do {} while (0), please.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
