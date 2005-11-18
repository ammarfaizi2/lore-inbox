Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbVKRHrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbVKRHrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 02:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVKRHrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 02:47:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932569AbVKRHrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 02:47:17 -0500
Date: Thu, 17 Nov 2005 23:46:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: davem@davemloft.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
Message-Id: <20051117234625.49cc7b89.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511180724060.5435@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171936440.4563@goblin.wat.veritas.com>
	<20051117.155230.25121238.davem@davemloft.net>
	<437D6AD0.5080909@yahoo.com.au>
	<20051117.224516.118147408.davem@davemloft.net>
	<Pine.LNX.4.61.0511180724060.5435@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Thu, 17 Nov 2005, David S. Miller wrote:
>  > From: Nick Piggin <nickpiggin@yahoo.com.au>
>  > Date: Fri, 18 Nov 2005 16:46:56 +1100
>  > 
>  > > I think for 2.6.15, yes. We [read: I :(] was too hasty in removing
>  > > this completely.
> 
>  No, that was not too hasty: we all agreed that the case _ought_ not to
>  arise, and we hadn't worked out the right code to handle it if it did
>  arise.  What was disappointing is that nobody reported the messages
>  while it was in -mm

The window was small - only 1-2 days.  I took a punt on jamming it in early
because we want the patches and everyone in the world seems to be hacking
on core mm.  As it turns out it wasn't a terribly good punt, but we'll get
there.  Well.  You will ;)
