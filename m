Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSLPW4R>; Mon, 16 Dec 2002 17:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSLPW4R>; Mon, 16 Dec 2002 17:56:17 -0500
Received: from dp.samba.org ([66.70.73.150]:13222 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262207AbSLPW4Q>;
	Mon, 16 Dec 2002 17:56:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [2.5.51] Failure to mount ext3 root when ext2 compiled in 
In-reply-to: Your message of "Thu, 12 Dec 2002 20:09:52 -0800."
             <3DF95D90.DEE68C66@digeo.com> 
Date: Tue, 17 Dec 2002 08:42:35 +1100
Message-Id: <20021216230413.DAB262C0B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DF95D90.DEE68C66@digeo.com> you write:
> Rebuilding the kernel, even if you "didn't change anything" makes
> it go away.
> 
> I assume that in your case a `make clean' will not fix it.   You
> lucky duck.   Can you stick a printk right at the end of
> ext3_fill_super()?

You have cursed me.  Now it works.  Looks like a build problem?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
