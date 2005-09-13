Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVIMSqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVIMSqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVIMSqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:46:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964973AbVIMSqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:46:15 -0400
Date: Tue, 13 Sep 2005 11:46:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
In-Reply-To: <52d5nc7r5x.fsf@cisco.com>
Message-ID: <Pine.LNX.4.58.0509131144300.3351@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> <52d5nc7r5x.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Roland Dreier wrote:
>
> Sorry for being dense, but can you say what "no more merges" means?

It's not so much a technical thing - I'll happily do git merges that fix 
bugs. But I don't want to merge big stuff (of course, it turns out that 
I'd missed a few before the release, so I did those anyway).

> As a concrete example, suppose I have a git tree with something like
> 
>  drivers/infiniband/hw/mthca/mthca_qp.c    |    2 +-
>  drivers/infiniband/ulp/ipoib/ipoib_main.c |    2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> ie a couple of really small, simple fixes.

I'll happily take them. I'd suggest you include the patches themselves in 
the "please pull.." message, just to make it obvious what's going on, but 
it would be stupid to avoid using technical means to get the patches in. 
So I'll certainly go git merges for these kinds of things.

		Linus
