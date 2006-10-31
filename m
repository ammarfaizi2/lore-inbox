Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030577AbWJaA0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030577AbWJaA0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWJaA0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:26:04 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:12471 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751319AbWJaA0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:26:02 -0500
Subject: Re: AMD X2 unsynced TSC fix?
From: john stultz <johnstul@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: sergio@sergiomb.no-ip.org, Andi Kleen <ak@suse.de>,
       Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, suresh.b.siddha@intel.com
In-Reply-To: <1162253662.27037.90.camel@mindpipe>
References: <1161969308.27225.120.camel@mindpipe>
	 <1162009373.26022.22.camel@localhost.localdomain>
	 <1162177848.2914.13.camel@localhost.portugal>
	 <200610301623.14535.ak@suse.de>
	 <1162253008.2999.9.camel@localhost.portugal>
	 <1162253662.27037.90.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 16:25:47 -0800
Message-Id: <1162254347.28538.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 19:14 -0500, Lee Revell wrote:
> On Tue, 2006-10-31 at 00:03 +0000, Sergio Monteiro Basto wrote:
> > On Mon, 2006-10-30 at 16:23 +0100, Andi Kleen wrote:
> > > Can you give us a full dmesg without noapic or notsc please? 
> > > 
> > 
> > yes , I send an dmesg of 2.6.18-git20, dmesg27
> > and other dmesg of kernel 2.6.18.1, dmesg30
> > To vanilla kernel I just add this patch:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/broken-out/gregkh-pci-pci-via-irq-quirk-behaviour-change.patch
> > 
> > > Adding Suresh to cc too because he spotted a similar problem last
> > >  time. 
> > 
> > Feel free to ask any test, test patches or even access to this machine. 
> 
> Maybe I've been running -rt for too long but I don't see clocksource
> selection - does 2.6.18 not have John Stultz's GTOD rework?

He's booting x86_64. I've not had the time yet to cleanup and push my
x86_64 conversion to CONFIG_GENERIC_TIME. Soon hopefully.

thanks
-john


