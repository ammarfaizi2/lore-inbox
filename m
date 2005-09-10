Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVIJWND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVIJWND (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVIJWND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:13:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932209AbVIJWNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:13:02 -0400
Date: Sat, 10 Sep 2005 15:12:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.13-mm2
Message-Id: <20050910151225.612e3f7b.akpm@osdl.org>
In-Reply-To: <200509102043.25928.dominik.karall@gmx.net>
References: <20050908053042.6e05882f.akpm@osdl.org>
	<200509102043.25928.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall <dominik.karall@gmx.net> wrote:
>
> On Thursday 08 September 2005 14:30, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13
>  >-mm2/
> 
>  I have problems using NFS with 2.6.13-mm2, it failes to start, but works with 
>  2.6.13-ck1 (so pure 2.6.13 should work too, as there are no nfs related 
>  changes in -ck, I think).
>  Following messages appear in /var/log/messages:
> 
>  Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>  rpc.statd[15041]: Version 1.0.7 Starting
>  NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
>  NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
>  NFSD: starting 90-second grace period
>  portmap[15048]: connect from 127.0.0.1 to set(nfs): request from unprivileged 
>  port
>  nfsd[15046]: nfssvc: Permission denied
> 
> 
>  with 2.6.13-ck1:
> 
>  Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>  rpc.statd[16126]: Version 1.0.7 Starting
>  NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
>  NFSD: starting 90-second grace period

OK.  We don't have many nfsd patches at all in 2.6.13-mm2.  But there are
quite a few sunrpc changes.  Plus I have a few random nfs patches which
should be merged up or dropped.

In short: dunno.  Relevant people cc'ed ;)
