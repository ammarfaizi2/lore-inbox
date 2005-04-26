Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVDZRjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVDZRjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVDZRgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:36:50 -0400
Received: from mail.dif.dk ([193.138.115.101]:46525 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261712AbVDZRfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:35:10 -0400
Date: Tue, 26 Apr 2005 19:38:26 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: David Addison <addy@quadrics.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
In-Reply-To: <1114536511.5410.14.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0504261934220.2071@dragon.hyggekrogen.localhost>
References: <426E62ED.5090803@quadrics.com> 
 <Pine.LNX.4.62.0504261829110.2071@dragon.hyggekrogen.localhost> 
 <1114535584.5410.2.camel@mindpipe>  <Pine.LNX.4.62.0504261918210.2071@dragon.hyggekrogen.localhost>
 <1114536511.5410.14.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Lee Revell wrote:

> On Tue, 2005-04-26 at 19:20 +0200, Jesper Juhl wrote:
> > I don't know what you do, but when I'm grep'ing the tree for some function 
> > I'm often looking for its return type, having that on the same line as the 
> > function name lets me grep for the function name and the grep output will 
> > contain the return type and function name nicely on the same line.
> > 
> 
> I do a lot of looking at large hunks of code I'm not familiar with and
> trying to figure out how it works.  It's quite handy to grep for
> foo_func to see all usages, then ^foo_func to see the function.

Have you ever looked at what "make tags" gives you?
Run  make tags  in the kernel source dir, then open up a source file in 
vim, place the cursor over some struct name or function name and press 
CTRL+] and you'll be taken to the definition, you can drill down several 
levels like that, and if you want to go back up one level to where you 
were you simply press CTRL+t  very useful when navigating the source.

-- 
Jesper


