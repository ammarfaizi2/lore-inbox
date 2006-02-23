Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWBWA1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWBWA1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWBWA1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:27:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751582AbWBWA1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:27:42 -0500
Date: Wed, 22 Feb 2006 16:29:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com
Subject: Re: [PATCH] refine for_each_pgdat() [1/4] refine for_each_pgdat
Message-Id: <20060222162951.0e28a9aa.akpm@osdl.org>
In-Reply-To: <43FCFFC0.1050405@jp.fujitsu.com>
References: <20060222200402.e1145286.kamezawa.hiroyu@jp.fujitsu.com>
	<20060222145256.7b84f444.akpm@osdl.org>
	<43FCFFC0.1050405@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> Andrew Morton wrote:
> > It's confusing and asymmetric.  If you have time, it would be nice to later
> > remove for_each_pgdat() and for_each_cpu() from the kernel altogether, use
> > for_each_online_cpu(), for_each_possible_cpu(), for_each_online_node(),
> > for_each_possible_node().
> > 
> Okay, I'll rewrite my patch and post new one which represents what you mention.

Well, only do that if it's appropriate to the context of that patch.

I was more thinking that this renaming would be a separate exercise, to be
done once things in that area calm down a bit.

> BTW, I noticed  refine-for_each_pgdat-remove-pgdat-sorting.patch
> contains bug. (caller of ia64's insert_pgdat() is not removed...)
> 
> so please drop them :(, I'll post new ones to next -mm (with enough test...).

OK..
