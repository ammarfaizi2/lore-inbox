Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030523AbVKWX6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbVKWX6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030545AbVKWX5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:57:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:19374 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030522AbVKWX5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:57:37 -0500
Date: Thu, 24 Nov 2005 00:57:28 +0100
From: Andi Kleen <ak@suse.de>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, kaos@sgi.com
Subject: Re: [Lse-tech] [PATCH 4/7]: changes notifier head of diechains and add notify_chain_unregister
Message-ID: <20051123235728.GB31722@brahms.suse.de>
References: <1132789192.9460.20.camel@linuxchandra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132789192.9460.20.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Index: l2615-rc1-notifiers/include/asm-x86_64/kdebug.h
> ===================================================================
> --- l2615-rc1-notifiers.orig/include/asm-x86_64/kdebug.h
> +++ l2615-rc1-notifiers/include/asm-x86_64/kdebug.h
> @@ -5,21 +5,20 @@
>  
>  struct pt_regs;
>  
> -struct die_args { 
> +struct die_args {

etc. lots more occurrences.

Can you please repost the patch without arbitary white space changes
everywhere?  They make it hard to review what you actually changed.

-Andi
