Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266105AbUGJEbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbUGJEbt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 00:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUGJEbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 00:31:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:27592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266105AbUGJEbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 00:31:47 -0400
Date: Fri, 9 Jul 2004 21:30:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-Id: <20040709213037.7fb1ac8f.akpm@osdl.org>
In-Reply-To: <20040710010738.GX20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random>
	<20040708212923.406135f0.akpm@osdl.org>
	<20040709044205.GF20947@dualathlon.random>
	<20040708215645.16d0f227.akpm@osdl.org>
	<20040710001600.GT20947@dualathlon.random>
	<20040710010738.GX20947@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Sat, Jul 10, 2004 at 02:16:00AM +0200, Andrea Arcangeli wrote:
> > I hope this time I'm done with it.
> 
> I'm not after more thinking it seems the below is not a bug.

Yes, I was scratching my head.  If that code was wrong, fsx-linux on
1k-blocksize ext2-nobh with memory pressure wouldn't last long.

> I'm lost since I can't find bugs anymore in this function but I need to
> find something.

What is the failure scenario?

