Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWDVBLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWDVBLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 21:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWDVBLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 21:11:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750828AbWDVBLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 21:11:40 -0400
Date: Fri, 21 Apr 2006 18:10:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: dwmw2@infradead.org, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrink rbtree
Message-Id: <20060421181035.75a05429.akpm@osdl.org>
In-Reply-To: <20060421180915.1f2d61a4.akpm@osdl.org>
References: <1145623663.11909.139.camel@pmac.infradead.org>
	<20060421180915.1f2d61a4.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> -#define HRTIMER_INACTIVE	((void *)1UL)
>  +#define HRTIMER_INACTIVE	((void *)-2)

I don't think that's going to work either.   Let me try -4..
