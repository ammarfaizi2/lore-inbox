Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUJGFjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUJGFjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUJGFjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:39:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:3761 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267285AbUJGFjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:39:37 -0400
Date: Wed, 6 Oct 2004 22:35:52 -0700
From: Paul Jackson <pj@sgi.com>
To: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
Cc: colpatch@us.ibm.com, mbligh@aracnet.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       simon.derr@bull.net, frankeh@watson.ibm.com
Subject: Re: [ckrm-tech] [RFC PATCH] scheduler: Dynamic sched_domains
Message-Id: <20041006223552.43d47135.pj@sgi.com>
In-Reply-To: <NIBBJLJFDHPDIBEEKKLPIEMNCHAA.mef@cs.princeton.edu>
References: <1097110266.4907.187.camel@arrakis>
	<NIBBJLJFDHPDIBEEKKLPIEMNCHAA.mef@cs.princeton.edu>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc wrote:
> > ... thus making supporting interesting NUMA machines
> > and SMT machines easier.
> 
> Would you be so kind and elaborate on the SMT part.

Sure - easy - I mistyped "SMP".  Even on a system as simple as
a dual processor, tightly coupled HPC applications, using one
thread per processor, run much better if indeed they are placed
one thread to a processor, allowing for genuine parallelism.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
