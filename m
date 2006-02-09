Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422885AbWBILV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422885AbWBILV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 06:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422889AbWBILV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 06:21:28 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39558 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1422885AbWBILV1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 06:21:27 -0500
Subject: Re: preempt-rt, NUMA and strange latency traces
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139465045.30058.31.camel@mindpipe>
References: <1139311689.19708.36.camel@frecb000686>
	 <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
	 <1139395534.21471.13.camel@frecb000686>
	 <1139465045.30058.31.camel@mindpipe>
Date: Thu, 09 Feb 2006 12:24:35 +0100
Message-Id: <1139484275.5706.19.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/02/2006 12:22:28,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/02/2006 12:22:30,
	Serialize complete at 09/02/2006 12:22:30
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 01:04 -0500, Lee Revell wrote:
> On Wed, 2006-02-08 at 11:45 +0100, Sébastien Dugué wrote:
> > The more I think about it, the more I tend to believe it's hardware 
> > related. It seems as if the CPU just hangs for ~27 ms before
> > resuming processing. 
> 
> That would be an exceptionally long latency - you would probably notice
> it if the mouse froze, VOIP dropped out, ping stops, etc for 30ms.
> 

  It's a test machine and I use it remotely with console redirected so
no mouse, no RT applications aside from my silly nanosleep() loop. But 
I do notice that that test sometimes takes more time (ie when I get 
those weird latencies). 


  Sébastien.

