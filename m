Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268789AbTBZPxk>; Wed, 26 Feb 2003 10:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268791AbTBZPxk>; Wed, 26 Feb 2003 10:53:40 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1744 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268789AbTBZPxO>;
	Wed, 26 Feb 2003 10:53:14 -0500
Subject: Re: 2.5.62-mjb3 (scalability / NUMA patchset)
From: Mark Haverkamp <markh@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <3090000.1046274931@[10.10.2.4]>
References: <6490000.1045713212@[10.10.2.4]>
	 <16170000.1046110132@[10.10.2.4]>
	 <1046273777.1913.6.camel@markh1.pdx.osdl.net>
	 <3090000.1046274931@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1046275419.1926.11.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Feb 2003 08:03:39 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 07:55, Martin J. Bligh wrote:
> >> The patchset contains mainly scalability and NUMA stuff, and anything 
> >> else that stops things from irritating me. It's meant to be pretty
> >> stable,  not so much a testing ground for new stuff.
> >> 
> >> I'd be very interested in feedback from anyone willing to test on any 
> >> platform, however large or small.
> >> 
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.62/patch-2.5.62-
> >> mjb 3.bz2
> >> 
> > 
> > Martin,
> > 
> > I have been seeing system hangs on my 16 processor numaq while running
> > contest.  The system will hang within a few seconds to half an hour. 
> > Unfortunately there is no stack trace or any other indication on the
> > system console.  I have been running your 2.5.62-mjb2 without problems
> > previously.  Any ideas what I can do to narrow this down?
> 
> Humpf. Can you try backing out this patch (it caused me similar problems on
> 59, but seemed fine in 62). I suspect it's just changing timing enough that
> we hit some other bug ... 

OK, I'll try this.


> if you could, would be nice to try the ALT+SYSRQ
> stuff, or turn on NMI watchdogs and get a backtrace ... I've  not been able
> to reproduce this on recent kernels.

I'll try these first and see what happens.

Mark.


-- 
Mark Haverkamp <markh@osdl.org>

