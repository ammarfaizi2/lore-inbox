Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbVHSSaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbVHSSaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 14:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbVHSSaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 14:30:09 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.25]:59464 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S932678AbVHSSaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 14:30:08 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostdt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <1124470574.17311.4.camel@twins>
References: <20050818060126.GA13152@elte.hu>
	 <1124470574.17311.4.camel@twins>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 20:30:05 +0200
Message-Id: <1124476205.17311.8.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 18:56 +0200, Peter Zijlstra wrote:
> Hi Ingo, Paul, others,
> 
> I'm trying to run a user-mode-linux guest under the RT kernel however
> the uml process never gets out of the calibrate delay loop. It seems as
> if the signal never gets through.
> 
one clarification: the guest kernel is a non -rt kernel, a modified
2.6.13-rc6 in my case.

> A non -rt host kernel does work (with a similar .config).
> 
> Could this be related to pauls task list changes?
> 
> Kind regards,
> 
-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

