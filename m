Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWFUXoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWFUXoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWFUXoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:44:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38628 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932108AbWFUXoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:44:21 -0400
Date: Wed, 21 Jun 2006 16:44:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1 : two PF flags with the same value
Message-Id: <20060621164414.45f758ef.akpm@osdl.org>
In-Reply-To: <4499D8C4.5040304@bigpond.net.au>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<4499D8C4.5040304@bigpond.net.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:39:48 +1000
Peter Williams <pwil3058@bigpond.net.au> wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/
> 
> Doing my quick review of changes to bits of code that overlap where I 
> wish to work I've noticed that PF_SPREAD_SLAB and PF_MUTEX_TESTER have 
> the same value.
> 
> define PF_SPREAD_SLAB	0x02000000	/* Spread some slab caches over cpuset */
> #define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
> #define PF_MUTEX_TESTER	0x02000000	/* Thread belongs to the rt mutex 
> tester */

ahem.   Will fix, thanks.
