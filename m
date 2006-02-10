Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWBJTIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWBJTIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWBJTIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:08:00 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:27046 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750934AbWBJTH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:07:59 -0500
Subject: Re: preempt-rt, NUMA and strange latency traces
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: john stultz <johnstul@us.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139576865.5706.68.camel@frecb000686>
References: <1139311689.19708.36.camel@frecb000686>
	 <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
	 <1139395534.21471.13.camel@frecb000686>
	 <1139417369.16302.1.camel@leatherman>
	 <1139483492.5706.12.camel@frecb000686>
	 <1139511262.28536.10.camel@cog.beaverton.ibm.com>
	 <1139576865.5706.68.camel@frecb000686>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 10 Feb 2006 14:07:54 -0500
Message-Id: <1139598475.19342.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 14:07 +0100, Sébastien Dugué wrote:
> That's the problem and I'll have to synchronize for a proper window
> for running my tests.
> 
>   Is this SMI thing IBM's eyes only stuff or is it documented
> somewhere?
> 

No, I wish it was just IBM.  Lots of modern systems unfortunately use
SMM (system management mode, which is entered when we get a system
management interrupts) to implement all kinds of PM and BIOS junk and
various value added features.

Most of these systems are laptops and are utterly unusable for low
latency work.  Worse, most of this stuff is considered highly
proprietary by the vendors (probably because it leands to such suckage).

Lee

