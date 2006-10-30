Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbWJ3PXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbWJ3PXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbWJ3PXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:23:33 -0500
Received: from cantor.suse.de ([195.135.220.2]:62902 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030482AbWJ3PXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:23:32 -0500
From: Andi Kleen <ak@suse.de>
To: sergio@sergiomb.no-ip.org
Subject: Re: AMD X2 unsynced TSC fix?
Date: Mon, 30 Oct 2006 16:23:14 +0100
User-Agent: KMail/1.9.5
Cc: Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, suresh.b.siddha@intel.com
References: <1161969308.27225.120.camel@mindpipe> <1162009373.26022.22.camel@localhost.localdomain> <1162177848.2914.13.camel@localhost.portugal>
In-Reply-To: <1162177848.2914.13.camel@localhost.portugal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610301623.14535.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 October 2006 04:10, Sergio Monteiro Basto wrote:
> On Sat, 2006-10-28 at 05:22 +0100, Sergio Monteiro Basto wrote:
> > On Fri, 2006-10-27 at 21:06 -0700, Andi Kleen wrote:
> > > > So far, has I can understand. Seems to me that my computer which have a
> > > > Pentium D (Dual Core) on VIA chipset, also have unsynchronized TSC and
> > > > with the patch of hrtimers on
> > > 
> > > Intel systems (except for some large highend systems) have synchronized TSCs. 
> > > Only exception so far seems to be a few systems that are 
> > > overclocked/overvolted and running outside their specification. 
> > > When you do that you'e on your own and we're not interested in a bug
> > > report.
> > 
> > and my computer :) 
> > http://www.asrock.com/product/775Dual-880Pro.htm
> > http://www.asrock.com/support/CPU_Support/show.asp?Model=775Dual-880Pro
> > Monday I will checkout if my computer is under specs. 
> > Seems that I like buy computers with many problems on Linux and fix :)
> 
> I bought this computer, on computers shop that have the best credits in
> Portugal. And I don't change anything.


Can you give us a full dmesg without noapic or notsc please? 

Adding Suresh to cc too because he spotted a similar problem last time.

-Andi
