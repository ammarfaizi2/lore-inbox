Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWDOU3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWDOU3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 16:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWDOU3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 16:29:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:48566 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751268AbWDOU3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 16:29:22 -0400
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to
	1GB, V2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Mason <jdmason@us.ibm.com>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Olof Johansson <olof@lixom.net>,
       linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060415133752.GB7712@us.ibm.com>
References: <20060413020559.GC24769@pb15.lixom.net>
	 <20060413022809.GD24769@pb15.lixom.net>
	 <20060413025233.GE24769@pb15.lixom.net>
	 <20060413064027.GH10412@granada.merseine.nu>
	 <1144925149.4935.14.camel@localhost.localdomain>
	 <20060413160712.GG24769@pb15.lixom.net>
	 <20060413173121.GJ10412@granada.merseine.nu>
	 <1144961564.4935.24.camel@localhost.localdomain>
	 <20060414144830.GQ10412@granada.merseine.nu>
	 <1145048275.4223.32.camel@localhost.localdomain>
	 <20060415133752.GB7712@us.ibm.com>
Content-Type: text/plain
Date: Sun, 16 Apr 2006 06:28:55 +1000
Message-Id: <1145132935.4233.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-15 at 08:37 -0500, Jon Mason wrote:
> On Sat, Apr 15, 2006 at 06:57:55AM +1000, Benjamin Herrenschmidt wrote:
> > 
> > > What I had in mind is an interface that given a PCI bridge will tell
> > > you what's the most restrictive DMA mask for a device on that bridge,
> > > so that you'll know whether you need to enable the IOMMU for that
> > > bridge. I'll even settle for a function that tells you what's the most
> > > restrictive DMA mask in the system, period. There's nothing inherently
> > > arch specific about this.
> > >
> > > (and as a side note, the IOMMU we are working on on x86-64 is Calgary,
> > > which is actually roughly the same chipset used in some PPC
> > > machines...)
> > 
> > Not sure I ever heard about that... What chipsets ?
> 
> The pSeries POWER4 based systems (Regatta) had Calgary, and the 
> RS/6000 POWER3 based systems (Condor) had Winnipeg (a precursor to
> Calgary, with many of the same features).

Ah ok, I'm not familiar with the IBM chipset names

Ben.


