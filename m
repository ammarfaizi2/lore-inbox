Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUBZW4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbUBZWzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:55:09 -0500
Received: from dp.samba.org ([66.70.73.150]:42703 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261230AbUBZWyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:54:09 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IPMI driver updates, part 4 
In-reply-to: Your message of "Mon, 23 Feb 2004 10:05:48 MDT."
             <403A24DC.7050505@acm.org> 
Date: Fri, 27 Feb 2004 09:36:42 +1100
Message-Id: <20040226225419.198E22C2BC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <403A24DC.7050505@acm.org> you write:
> +#ifdef CONFIG_DEBUG_KERNEL
> +module_param(debug, int, 0);
> +#endif

You don't want to change this at runtime?  0644 might be more
appropriate...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
