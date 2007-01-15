Return-Path: <linux-kernel-owner+w=401wt.eu-S932482AbXAQPgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbXAQPgv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 10:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbXAQPgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 10:36:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1917 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932482AbXAQPgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 10:36:50 -0500
Date: Mon, 15 Jan 2007 13:03:14 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 16/20] XEN-paravirt: Add the Xen virtual console driver.
Message-ID: <20070115130314.GA4272@ucw.cz>
References: <20070113014539.408244126@goop.org> <20070113014648.767777869@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070113014648.767777869@goop.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This provides a bootstrap and ongoing emergency console which is
> intended to be available from very early during boot and at all times
> thereafter, in contrast with alternatives such as UDP-based syslogd,
> or logging in via ssh. The protocol is based on a simple shared-memory
> ring buffer.
> 
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> 
> ---
>  arch/i386/kernel/early_printk.c    |    2 
>  arch/i386/paravirt-xen/enlighten.c |    3 
>  drivers/Makefile                   |    3 
>  drivers/xen/Makefile               |    1 

You have drivers/xen... so maybe arch/i386/xen is easier to type?
arch/i386/paravirt/xen would make some sense, too, but it looks too
deep to me.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
