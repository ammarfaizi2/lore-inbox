Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267443AbUIJARK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267443AbUIJARK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUIJAN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:13:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:37000 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267989AbUIJALK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:11:10 -0400
Date: Thu, 9 Sep 2004 17:14:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
Message-Id: <20040909171450.6546ee7a.akpm@osdl.org>
In-Reply-To: <4140EE3E.5040602@bigpond.net.au>
References: <413FA9AE.90304@bigpond.net.au>
	<20040909010610.28ca50e1.akpm@osdl.org>
	<4140EE3E.5040602@bigpond.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> > 
> > Please try earlier snapshots, see if you can ascertain which one introduced
> > the bug.
> 
> OK.

Thanks.

> PS I read the groups_search() source and couldn't spot anything.

Yes, the bug is elsewhere - it looks like something we did screwed up (or
exposed a prior screwup in) the refcounting of the groups structure.
