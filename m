Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUDNNpC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbUDNNpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:45:02 -0400
Received: from ns.suse.de ([195.135.220.2]:15298 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264215AbUDNNpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:45:00 -0400
Date: Wed, 14 Apr 2004 15:44:56 +0200
From: Andi Kleen <ak@suse.de>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au, mjbligh@us.ibm.com,
       ricklind@us.ibm.com, akpm@osdl.org
Subject: Re: 2.6.5-rc3-mm4 x86_64 sched domains patch
Message-Id: <20040414154456.78893f3f.ak@suse.de>
In-Reply-To: <1081466480.10774.0.camel@farah>
References: <1081466480.10774.0.camel@farah>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Apr 2004 16:22:09 -0700
Darren Hart <dvhltc@us.ibm.com> wrote:


> 
> This patch is intended as a quick fix for the x86_64 problem, and

Ingo's latest tweaks seemed to already cure STREAM, but some more
tuning is probably a good idea agreed.

> doesn't solve the problem of how to build generic sched domain
> topologies.  We can certainly conceive of various topologies for x86
> systems, so even arch specific topologies may not be sufficient.  Would
> sub-arch (ie NUMAQ) be the right way to handle different topologies, or
> will we be able to autodiscover the appropriate topology?  I will be
> looking into this more, but thought some might benefit from an immediate
> x86_64 fix.  I am very interested in hearing your ideas on this.


The patch doesn't apply against 2.6.5-mm5 anymore. Can you generate a new patch? 
I will test it then.

Also it will need merging with the patch that adds SMT support for IA32e machines
on x86-64.

-Andi
