Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275306AbRJARJb>; Mon, 1 Oct 2001 13:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275294AbRJARJL>; Mon, 1 Oct 2001 13:09:11 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:29097 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S275296AbRJARJE>; Mon, 1 Oct 2001 13:09:04 -0400
Date: Mon, 1 Oct 2001 13:09:34 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110011709.f91H9Yq31791@devserv.devel.redhat.com>
To: aneesh.kumar@digital.com, linux-kernel@vger.kernel.org
Subject: Re: /proc/slabinfo doesn't give details of what it is showing.
In-Reply-To: <mailman.1001919360.11119.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1001919360.11119.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>       len += sprintf(page+len, "slabinfo - version: 1.1"
> #if STATS
>                                 " (statistics)"
> #endif
> #ifdef CONFIG_SMP
>                                 " (SMP)"
> #endif
>                                 "\n");
>         len += sprintf(page+len,
> "(cache-name)-----(num-active-objs)--(total-objs)--(obj-size)--(num-active-slabs)--(total-slabs)--(num-pages-per-slab)\n");

0. This is an incompatible change that is going to break userland.
1. Learn to use diff -u.
2. Headers are customarily separated by spaces, not dashes.

-- Pete
