Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136779AbREAXtN>; Tue, 1 May 2001 19:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136777AbREAXtD>; Tue, 1 May 2001 19:49:03 -0400
Received: from cs.columbia.edu ([128.59.16.20]:4748 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S136781AbREAXsz>;
	Tue, 1 May 2001 19:48:55 -0400
Date: Tue, 1 May 2001 16:48:53 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <15086.48447.264388.289216@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0105011644280.15751-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Trond Myklebust wrote:

>      > I'll give your patch a spin tomorrow, after I catch some
>      > zzz's. :-)
> 
> Right you are.

And indeed, the tcp-hang patch fixed the problem! Thanks a lot!

> FYI I've now put up those patches of which I am aware against 2.2.19
> on
> 
>   http://www.fys.uio.no/~trondmy/src/2.2.19
> 
> I'll try to keep that area updated with a brief explanation for each
> patch...

That's where I tried looking first, two days ago, but couldn't find 
anything, and I must have overlooked the patch you sent to the list.

Thanks for crediting me, btw. :-) Just one little nit: the readdir() 
problem appears only when using glibc-2.0, glibc-2.1 seems to be fine.

Thanks again to everybody,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

