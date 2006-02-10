Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWBJNQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWBJNQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWBJNQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:16:56 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:5547 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932087AbWBJNQz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:16:55 -0500
Subject: Re: preempt-rt, NUMA and strange latency traces
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139515365.30058.91.camel@mindpipe>
References: <1139311689.19708.36.camel@frecb000686>
	 <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
	 <1139395534.21471.13.camel@frecb000686>
	 <1139465045.30058.31.camel@mindpipe> <1139484275.5706.19.camel@frecb000686>
	 <1139515365.30058.91.camel@mindpipe>
Date: Fri, 10 Feb 2006 14:18:54 +0100
Message-Id: <1139577535.5706.81.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/02/2006 14:16:49,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/02/2006 14:17:58,
	Serialize complete at 10/02/2006 14:17:58
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 15:02 -0500, Lee Revell wrote:
> On Thu, 2006-02-09 at 12:24 +0100, Sébastien Dugué wrote:
> > On Thu, 2006-02-09 at 01:04 -0500, Lee Revell wrote:
> > > On Wed, 2006-02-08 at 11:45 +0100, Sébastien Dugué wrote:
> > > > The more I think about it, the more I tend to believe it's hardware 
> > > > related. It seems as if the CPU just hangs for ~27 ms before
> > > > resuming processing. 
> > > 
> > > That would be an exceptionally long latency - you would probably notice
> > > it if the mouse froze, VOIP dropped out, ping stops, etc for 30ms.
> > > 
> > 
> >   It's a test machine and I use it remotely with console redirected so
> > no mouse, no RT applications aside from my silly nanosleep() loop. But 
> > I do notice that that test sometimes takes more time (ie when I get 
> > those weird latencies). 
> 
> Argh.  You would think the vendors would consider a 30ms delay
> unacceptable.  This is big enough to show up on an MRTG graph of ping
> times ferchrissake.
> 
> I guess the assumption is that most hardware will never be used for even
> soft RT work...
> 
> Lee
> 

  That may be but in that case I may be pushing it a bit far testing
that kind of box with realtime stuff.

  As a former hw designer I find it useful to have some hardware 
monitoring capabilities on a system but it should either not be so
intrusive or at least we should be able to disable it.

  Sébastien.



