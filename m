Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315473AbSEBXJc>; Thu, 2 May 2002 19:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315474AbSEBXJb>; Thu, 2 May 2002 19:09:31 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:3013 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315473AbSEBXJ3>;
	Thu, 2 May 2002 19:09:29 -0400
To: rwhron@earthlink.net
cc: linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: O(1) scheduler gives big boost to tbench 192 
In-Reply-To: Your message of Thu, 02 May 2002 17:36:56 EDT.
             <20020502173656.A26986@rushmore> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2344.1020384545.1@us.ibm.com>
Date: Thu, 02 May 2002 17:09:05 -0700
Message-Id: <E173QdG-0000bs-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020502173656.A26986@rushmore>, > : rwhron@earthlink.net writes:
> On an OSDL 4 way x86 box the O(1) scheduler effect 
> becomes obvious as the run queue gets large.  
> 
> 2.4.19-pre7-ac2 and 2.4.19-pre7-jam6 have the O(1) scheduler.  
> 
> At 192 processes, O(1) shows about 340% improvement in throughput.
> The dyn-sched in -aa appears to be somewhat improved over the
> standard scheduler.
> 
> Numbers are in MB/second.
> 

If you are bored, you might compare this to the MQ scheduler
at http://prdownloads.sourceforge.net/lse/2.4.14.mq-sched

Also, I think rml did a backport of the 2.5.X version of O(1);
I'm not sure if htat is in -ac or -jam as yet.

Rumor is that on some workloads MQ it outperforms O(1), but it
may be that the latest (post K3?) O(1) is catching up?

gerrit
