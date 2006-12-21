Return-Path: <linux-kernel-owner+w=401wt.eu-S1423022AbWLUVju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423022AbWLUVju (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbWLUVju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:39:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:29309 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423022AbWLUVjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:39:49 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,200,1165219200"; 
   d="scan'208"; a="29686737:sNHT20311821"
Subject: Re: 2.6.19-rt14 e1000 shutdown problem
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       suresh.b.siddha@intel.com
In-Reply-To: <20061221201351.GA11625@elte.hu>
References: <1166547279.28359.23.camel@localhost.localdomain>
	 <20061221201351.GA11625@elte.hu>
Content-Type: text/plain
Organization: Intel
Date: Thu, 21 Dec 2006 12:49:30 -0800
Message-Id: <1166734170.28359.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2006-12-21 at 21:13 +0100, Ingo Molnar wrote:
> * Tim Chen <tim.c.chen@linux.intel.com> wrote:
> 
> > Ingo,
> > 
> > While trying out the 2.6.19.1-rt14 kernel with a x86_64 system with 
> > Clovertown processor, it hung when it was shutting down e1000 ethernet 
> > interface running the command:
> > 
> > /sbin/ip link set dev eth0 down
> 
> does the patch below solve it for you?
> 
> 	Ingo
> 

Yes, the patch took care of the problem.  Thanks.

Tim
