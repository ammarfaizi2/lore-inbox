Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWJWDSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWJWDSk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWJWDSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:18:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:49590 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751306AbWJWDSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:18:39 -0400
Date: Sun, 22 Oct 2006 20:18:24 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, nickpiggin@yahoo.com.au, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061022201824.267525c9.pj@sgi.com>
In-Reply-To: <20061020210422.GA29870@in.ibm.com>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<20061020210422.GA29870@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> IMO this patch addresses just one of the requirements for partitionable
> sched domains

Correct - this particular patch was just addressing one of these.

Nick raised the reasonable concern that this patch was adding something
to cpusets that was not especially related to cpusets.

So I will not be sending this patch to Andrew for *-mm.

There are further opportunities for improvements in some of this code,
which my colleague Christoph Lameter may be taking an interest in.
Ideally kernel-user API's for isolating and partitioning sched domains
would arise from that work, though I don't know if we can wait that
long.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
