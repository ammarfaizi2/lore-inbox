Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbWJaAOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbWJaAOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030569AbWJaAOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:14:12 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12214 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030561AbWJaAOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:14:10 -0500
Subject: Re: AMD X2 unsynced TSC fix?
From: Lee Revell <rlrevell@joe-job.com>
To: sergio@sergiomb.no-ip.org
Cc: Andi Kleen <ak@suse.de>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, suresh.b.siddha@intel.com
In-Reply-To: <1162253008.2999.9.camel@localhost.portugal>
References: <1161969308.27225.120.camel@mindpipe>
	 <1162009373.26022.22.camel@localhost.localdomain>
	 <1162177848.2914.13.camel@localhost.portugal>
	 <200610301623.14535.ak@suse.de>
	 <1162253008.2999.9.camel@localhost.portugal>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 19:14:21 -0500
Message-Id: <1162253662.27037.90.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 00:03 +0000, Sergio Monteiro Basto wrote:
> On Mon, 2006-10-30 at 16:23 +0100, Andi Kleen wrote:
> > Can you give us a full dmesg without noapic or notsc please? 
> > 
> 
> yes , I send an dmesg of 2.6.18-git20, dmesg27
> and other dmesg of kernel 2.6.18.1, dmesg30
> To vanilla kernel I just add this patch:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/broken-out/gregkh-pci-pci-via-irq-quirk-behaviour-change.patch
> 
> > Adding Suresh to cc too because he spotted a similar problem last
> >  time. 
> 
> Feel free to ask any test, test patches or even access to this machine. 

Maybe I've been running -rt for too long but I don't see clocksource
selection - does 2.6.18 not have John Stultz's GTOD rework?

How can it know not to use TSC on machines where it's unstable?

Lee

