Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbSIWTcJ>; Mon, 23 Sep 2002 15:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSIWTaj>; Mon, 23 Sep 2002 15:30:39 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261331AbSIWSli>;
	Mon, 23 Sep 2002 14:41:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: trond.myklebust@fys.uio.no, Andrew Morton <akpm@digeo.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Mon, 23 Sep 2002 19:16:59 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
       Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D811363.70ABB50C@digeo.com> <3D811A6C.C73FEC37@digeo.com> <15759.17258.990642.379366@charged.uio.no>
In-Reply-To: <15759.17258.990642.379366@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17tWpR-0003au-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 September 2002 18:38, Trond Myklebust wrote:
> >>>>> " " == Andrew Morton <akpm@digeo.com> writes:
> 
>      > Look, idunnoigiveup.  Like scsi and USB, NFS is a black hole
>      > where akpms fear to tread.  I think I'll sulk until someone
>      > explains why this work has to be performed in the context of a
>      > process which cannot do it.
> 
> I'd be happy to move that work out of the RPC callbacks if you could
> point out which other processes actually can do it.
> 
> The main problem is that the VFS/MM has no way of relabelling pages as
> being invalid or no longer up to date: I once proposed simply clearing
> PG_uptodate on those pages which cannot be cleared by
> invalidate_inode_pages(), but this was not to Linus' taste.

Could you please provide a subject line for that original discussion?

-- 
Daniel
