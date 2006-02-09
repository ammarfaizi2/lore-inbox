Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWBIUCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWBIUCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWBIUCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:02:52 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11955 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750751AbWBIUCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:02:51 -0500
Subject: Re: preempt-rt, NUMA and strange latency traces
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139484275.5706.19.camel@frecb000686>
References: <1139311689.19708.36.camel@frecb000686>
	 <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
	 <1139395534.21471.13.camel@frecb000686>
	 <1139465045.30058.31.camel@mindpipe> <1139484275.5706.19.camel@frecb000686>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 09 Feb 2006 15:02:44 -0500
Message-Id: <1139515365.30058.91.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 12:24 +0100, Sébastien Dugué wrote:
> On Thu, 2006-02-09 at 01:04 -0500, Lee Revell wrote:
> > On Wed, 2006-02-08 at 11:45 +0100, Sébastien Dugué wrote:
> > > The more I think about it, the more I tend to believe it's hardware 
> > > related. It seems as if the CPU just hangs for ~27 ms before
> > > resuming processing. 
> > 
> > That would be an exceptionally long latency - you would probably notice
> > it if the mouse froze, VOIP dropped out, ping stops, etc for 30ms.
> > 
> 
>   It's a test machine and I use it remotely with console redirected so
> no mouse, no RT applications aside from my silly nanosleep() loop. But 
> I do notice that that test sometimes takes more time (ie when I get 
> those weird latencies). 

Argh.  You would think the vendors would consider a 30ms delay
unacceptable.  This is big enough to show up on an MRTG graph of ping
times ferchrissake.

I guess the assumption is that most hardware will never be used for even
soft RT work...

Lee

