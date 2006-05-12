Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWELVsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWELVsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWELVsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:48:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44299 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932171AbWELVsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:48:19 -0400
Date: Fri, 12 May 2006 21:41:27 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 24/35] Add support for Xen event channels.
Message-ID: <20060512214127.GA4189@ucw.cz>
References: <20060509084945.373541000@sous-sol.org> <20060509085157.491027000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085157.491027000@sous-sol.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +++ linus-2.6/drivers/xen/core/evtchn.c
> @@ -0,0 +1,887 @@

msssng wwls?

> +/* NB. Interrupts are disabled on entry. */
> +asmlinkage void evtchn_do_upcall(struct pt_regs *regs)
> +{
> +	unsigned long  l1, l2;
> +	unsigned int   l1i, l2i, port;

Better variable names would be nice.


						Pavel
-- 
Thanks for all the (sleeping) penguins.
