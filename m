Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316141AbSEQMng>; Fri, 17 May 2002 08:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316131AbSEQMnf>; Fri, 17 May 2002 08:43:35 -0400
Received: from slip-202-135-75-243.ca.au.prserv.net ([202.135.75.243]:15753
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315981AbSEQMnd>; Fri, 17 May 2002 08:43:33 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: Your message of "Fri, 17 May 2002 12:47:31 +0100."
             <Pine.LNX.4.21.0205171220480.986-100000@localhost.localdomain> 
Date: Fri, 17 May 2002 22:46:18 +1000
Message-Id: <E178h82-0001o6-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.21.0205171220480.986-100000@localhost.localdomain> you w
rite:
> If they do make up the majority of strings, that's partly because
> you don't have Andrew's out_of_line_bug work in your tree, partly
> because your linker isn't combining strings (mine neither, does any?),
> partly because (I suspect) you're overlooking the vast number of BUG
> __FILE__ strings which are just leafnames, to each of which you're
> now proposing to add one or more __FUNCTION__ strings.

I don't care about the size of the kernel, I care about the fact that
the compile is 5x slower than it needs to be because the contents of
every pre-processed file depends on where the kernel tree happens to
be (see http://ccache.samba.org)

And I compile a lot of Linus kernels,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
