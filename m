Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316620AbSFATjX>; Sat, 1 Jun 2002 15:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSFATjW>; Sat, 1 Jun 2002 15:39:22 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:654 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S316620AbSFATjV>;
	Sat, 1 Jun 2002 15:39:21 -0400
Subject: Re: nfs problem 2.4.19-pre9
From: Kenneth Johansson <ken@canit.se>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <shs8z5yrf2v.fsf@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Jun 2002 21:39:21 +0200
Message-Id: <1022960361.1185.46.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-06-01 at 21:09, Trond Myklebust wrote:
> >>>>> " " == Kenneth Johansson <ken@canit.se> writes:
> 
>      > I have had a problem for some time that processes get stuck in
>      > D state and I now have a way to get this to happen at will.
> 
>      > One way to do this is to copy a file from one nfs mounted
>      > directory to another. It dose not happen on the same mount and
>      > not when copying from nfs to a local disk. To make this even
>      > more complex it works with cp and mv but not in mc(midnight
>      > commander F6 ).
> 
> Sounds like a network driver problem or something like that. UDP
> appears to trigger these lockups a lot more easily than does TCP.
> 
> Try testing with a different brand of networking card...
> 

I have three cards but they are all the same :(
3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30).

Also Why only this nfs mount. I can still telnet to other computers and
use nfs on another mount point so it's not like I lose the network.





