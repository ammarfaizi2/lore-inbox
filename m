Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbUJXJjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbUJXJjS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUJXJjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:39:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:9938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261403AbUJXJjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:39:15 -0400
Date: Sun, 24 Oct 2004 02:37:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: dvhltc@us.ibm.com, linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       mbligh@aracnet.com, ricklind@us.ibm.com
Subject: Re: [patch] scheduler: active_load_balance fixes
Message-Id: <20041024023709.2e99cb6d.akpm@osdl.org>
In-Reply-To: <4179EC91.2070100@cyberone.com.au>
References: <1098488173.2854.13.camel@farah.beaverton.ibm.com>
	<4179EC91.2070100@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> 
> Darren Hart wrote:
> 
> >The following patch against the latest mm fixes several problems with
> >active_load_balance().
> >
> >
> 
> This seems much better. Andrew can you put this into -mm please.
> 

Whenever we touch the load balancing we get sad little reports about
performance regressions two months later.  How do we gain confidence in
this change?
