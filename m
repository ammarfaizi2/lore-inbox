Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSGASqM>; Mon, 1 Jul 2002 14:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316192AbSGASqL>; Mon, 1 Jul 2002 14:46:11 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:43527 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S316187AbSGASqK>;
	Mon, 1 Jul 2002 14:46:10 -0400
Date: Mon, 1 Jul 2002 04:18:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: alex@PolesApart.wox.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
Message-ID: <20020701021854.GA829@elf.ucw.cz>
References: <E17MUf8-00088K-00@the-village.bc.nu> <3D173578.5080205@PolesApart.wox.org> <20020624.080409.79615643.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020624.080409.79615643.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    Maybe I got it the wrong way, but it seems to me that from your point of 
>    view, as long as proprietary driver is in use, it's not anyone else 
>    problem but to the vendor, even if the bug could happen to be in the 
>    kernel, is that right? If so, everyone else in this list who could try 
>    to fix this (again assuming it could be something related to the kernel 
>    and not to the proprietary driver) necessarily share your oppinion? (I'm 
>    not flaming in here, just trying to get the path).
> 
> This has to do with facts, not opinions.  Since we lack the source to
> their drivers, we have no idea if some bug in their driver is
> scribbling over (ie. corrupting) memory.  It is therefore an unknown
> which makes it a waste of time for us to pursue the bug report.

Actually, then you should taint kernel for starting X, too... Anything
running with root priviledges can scribble over memory.
									Pavel 
PS: Not that I'm advocating nvidia junk, and of course it is way
easier to cause corruption from kernel.
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
