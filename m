Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSFTRn1>; Thu, 20 Jun 2002 13:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSFTRn0>; Thu, 20 Jun 2002 13:43:26 -0400
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:52484 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S315287AbSFTRn0>; Thu, 20 Jun 2002 13:43:26 -0400
Message-Id: <200206201743.g5KHhPu31957@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, pashley@storm.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: McVoy's Clusters (was Re: latest linus-2.5 BK broken)
Date: Thu, 20 Jun 2002 12:43:37 -0500
X-Mailer: KMail [version 1.3.2]
References: <200206201723.MAA04517@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200206201723.MAA04517@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 June 2002 12:23 pm, Jesse Pollard wrote:
<snip>
> You don't use compute servers much? The problems we are currently running
> require the cluster (IBM SP) to have 100% uptime for a single job. that
> job may run for several days. If a detected problem is reported (not yet
> catastrophic) it is desired/demanded to checkpoint the users process.
>
> Currently, we can't - but should be able to by this fall.
>
> Having the users job checkpoint midway in it's computations will allow us
> to remove a node from active service, substitute a different node, and
> resume the users process without losing many hours of computation (we have
> a maximum of 300 nodes for computation, another 30 for I/O and front end).

Have you tried Condor?  Condor is a "high throughput computing" package, 
specifically targetted at such applications, with the ability to checkpoint & 
migrate jobs, etc.  Condor is free as in beer, but currently not as in speech 
(sorry), and is developed by the University of Wisconsin.  
http://www.condorproject.org is the URL to learn more.  Version 6.4.0 is in 
the process of being released and should be available within the next couple 
of days.

Condor runs on Linux (x86 & Alpha), Solaris, IRIX, HPUX, Digital Unix, and 
NT, although the NT usually lags the Unix releases.

-Nick
Academic Staff at UW on the Condor Team
