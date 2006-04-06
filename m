Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWDFIHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWDFIHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 04:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWDFIHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 04:07:53 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:35295 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932152AbWDFIHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 04:07:52 -0400
Date: Thu, 6 Apr 2006 17:08:51 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Hideo AOKI <haoki@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 1/3] mm: An enhancement of OVERCOMMIT_GUESS
Message-Id: <20060406170851.1402c78d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4434C12A.4000108@redhat.com>
References: <4434570F.9030507@redhat.com>
	<20060406094533.b340f633.kamezawa.hiroyu@jp.fujitsu.com>
	<4434C12A.4000108@redhat.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Apr 2006 03:20:10 -0400
Hideo AOKI <haoki@redhat.com> wrote:

> Hi Kamezawa-san,
> 
> Thank you for your comments.
> 
> KAMEZAWA Hiroyuki wrote:
> > Hi, AOKI-san
> I like your idea. But, in the function, I think we need to care
> lowmem_reserve too.
> 
Ah, I see.

> Since __vm_enough_memory() doesn't know zone and cpuset information,
> we have to guess proper value of lowmem_reserve in each zone
> like I did in calculate_totalreserve_pages() in my patch.
> Do you think that we can do this calculation every time?
> 
> If it is good enough, I'll make revised patch.
> 
I just thought to show "how to calculate" in unified way is better.
But if things goes ugly, please ignore my comment.

Do you have a detailed comparison of test result with and without this patch ?
I'm interested in.
I'm sorry if I missed your post of result.


Cheers!
-Kame
