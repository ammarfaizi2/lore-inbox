Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUJHXyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUJHXyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 19:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUJHXyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 19:54:18 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:63666 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266250AbUJHXyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 19:54:06 -0400
Message-ID: <416727C6.5000000@yahoo.com.au>
Date: Sat, 09 Oct 2004 09:50:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Erich Focht <efocht@hpce.nec.com>
CC: colpatch@us.ibm.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
References: <1097110266.4907.187.camel@arrakis> <41666E90.2000208@yahoo.com.au> <1097261691.5650.23.camel@arrakis> <200410090113.40589.efocht@hpce.nec.com>
In-Reply-To: <200410090113.40589.efocht@hpce.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:

>>I personally like the hierarchical idea.  Machine topologies tend to
>>look tree-like, and every useful sched_domain layout I've ever seen has
>>been tree-like.  I think our interface should match that.
> 
> 
> I like the hierarchical idea, too. The natural way to build it would
> be by starting from the cpus and going up. This tree stands on its
> leafs... and I'm not sure how to express that in a filesystem.
> 

Why would you ever want to play around with the internals of the
thing though? Provided you have a way to create exclusive sets of
CPUs, when would you care about doing more?
