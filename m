Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUCZF3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbUCZF3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:29:10 -0500
Received: from ns.suse.de ([195.135.220.2]:42157 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263946AbUCZF3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:29:04 -0500
Date: Fri, 26 Mar 2004 02:29:40 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: mingo@elte.hu, jun.nakajima@intel.com, ricklind@us.ibm.com,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org, rusty@rustcorp.com.au, anton@samba.org,
       lse-tech@lists.sourceforge.net, mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040326022940.5a5d46a2.ak@suse.de>
In-Reply-To: <200403251630.16485.habanero@us.ibm.com>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
	<20040325154011.GB30175@wotan.suse.de>
	<20040325215908.GA19313@elte.hu>
	<200403251630.16485.habanero@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 16:30:16 -0600
Andrew Theurer <habanero@us.ibm.com> wrote:


> For Opteron simply placing all cpus in the same sched domain may solve all of 
> this, since we will have balancing frequency of the default scheduler.  Is 
> there any reason this cannot be done for Opteron?

Yes, that makes sense. I will try that

-Andi
