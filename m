Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSHSFNo>; Mon, 19 Aug 2002 01:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318135AbSHSFNo>; Mon, 19 Aug 2002 01:13:44 -0400
Received: from angband.namesys.com ([212.16.7.85]:6016 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318122AbSHSFNn>; Mon, 19 Aug 2002 01:13:43 -0400
Date: Mon, 19 Aug 2002 09:17:42 +0400
From: Oleg Drokin <green@namesys.com>
To: rwhron@earthlink.net
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] big reiserfs regression in 2.4.20-pre2
Message-ID: <20020819091742.A1815@namesys.com>
References: <20020817100507.GA10770@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020817100507.GA10770@rushmore>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Aug 17, 2002 at 06:05:07AM -0400, rwhron@earthlink.net wrote:

> >   Is regression going away if you pass this mount option to reiserfs:
> >      -o alloc=preallocmin=4:preallocsize=9
> Yes.  

Great, I just found that we forgot to enable preallocation with new block
allocator by default. This is easily fixable of course.

Thanks for the info.

Bye,
    Oleg 
