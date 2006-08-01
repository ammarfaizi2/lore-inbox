Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWHAQOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWHAQOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWHAQOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:14:22 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:23485 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1750797AbWHAQOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:14:22 -0400
Message-ID: <44CF7DDB.3070705@oracle.com>
Date: Tue, 01 Aug 2006 09:14:19 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>,
       mason@suse.com
Subject: Re: [PATCH] [AIO] remove unused aio_run_iocbs()
References: <20060731221229.18058.82700.sendpatchset@tetsuo.zabbo.net> <20060801072731.GA20484@in.ibm.com>
In-Reply-To: <20060801072731.GA20484@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Chris Mason's aio pipe patches used these to reduce the large
> number of context switches he was observing when running pipetest.
> Of course aio pipe support hasn't been merged into mainline so far, and hence
> you could argue that we put these back in if/when we hit that problem.

Yeah, and that's trivial.

> But why
> not just put in a comment there for now to ease the confusion ... generally
> I'd rather go a little slow in removing apparently unused code at this
> point when we are churning things up again.

The only thing slower than not removing it after *years* of not being
used would be to never remove it :)

So I don't see any value in keeping it, but I won't make a fight of it
either.

- z
