Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291122AbSBLS0v>; Tue, 12 Feb 2002 13:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291150AbSBLS0l>; Tue, 12 Feb 2002 13:26:41 -0500
Received: from naughty.monkey.org ([204.181.64.8]:45960 "HELO
	naughty.monkey.org") by vger.kernel.org with SMTP
	id <S291122AbSBLS03>; Tue, 12 Feb 2002 13:26:29 -0500
Date: Tue, 12 Feb 2002 13:26:28 -0500 (EST)
From: Chuck Lever <cel@monkey.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Dave Hansen <haveblue@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove BKL from NFS read/write code + SunRPC...
In-Reply-To: <15465.21813.120817.244034@charged.uio.no>
Message-ID: <Pine.BSO.4.33.0202121319010.19594-100000@naughty.monkey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there's also a technical report that describes work we did recently to
improve write performance, which summarizes the web page Trond listed
below.  see

  http://www.citi.umich.edu/techreports/reports/citi-tr-01-12.pdf

we're publishing a revised version in the June 2002 Usenix technical
conference proceedings;  if you intend to cite the paper, we'd prefer that
you cited that one instead.

On Tue, 12 Feb 2002, Trond Myklebust wrote:

> >>>>> " " == Dave Hansen <haveblue@us.ibm.com> writes:
>
>      > Trond Myklebust wrote:
>     >> The following patch strongly reduces BKL contention within the
>     >> NFS read/write code, and within the generic RPC layer.
>
>      > Do you have any benchmarks which showed BKL contention in the
>      > NFS code?
>      >   I'm not trying to criticize, I think the patch is wonderful.
>      >   I want
>      > to have some more numbers to say, "Look!  The BKL _is_ bad!"
>
> See Chuck's paper on
>
>   http://www.citi.umich.edu/projects/nfs-perf/results/cel/write-throughput.html
>
>
> Cheers,
>   Trond
>

	- Chuck Lever
--
corporate:	<cel@netapp.com>
personal:	<chucklever@bigfoot.com>


