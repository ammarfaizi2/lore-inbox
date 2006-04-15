Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWDONeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWDONeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 09:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWDONeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 09:34:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:47004 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030240AbWDONeD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 09:34:03 -0400
Date: Sat, 15 Apr 2006 08:37:52 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Olof Johansson <olof@lixom.net>,
       linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB, V2
Message-ID: <20060415133752.GB7712@us.ibm.com>
References: <20060413020559.GC24769@pb15.lixom.net> <20060413022809.GD24769@pb15.lixom.net> <20060413025233.GE24769@pb15.lixom.net> <20060413064027.GH10412@granada.merseine.nu> <1144925149.4935.14.camel@localhost.localdomain> <20060413160712.GG24769@pb15.lixom.net> <20060413173121.GJ10412@granada.merseine.nu> <1144961564.4935.24.camel@localhost.localdomain> <20060414144830.GQ10412@granada.merseine.nu> <1145048275.4223.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145048275.4223.32.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 06:57:55AM +1000, Benjamin Herrenschmidt wrote:
> 
> > What I had in mind is an interface that given a PCI bridge will tell
> > you what's the most restrictive DMA mask for a device on that bridge,
> > so that you'll know whether you need to enable the IOMMU for that
> > bridge. I'll even settle for a function that tells you what's the most
> > restrictive DMA mask in the system, period. There's nothing inherently
> > arch specific about this.
> >
> > (and as a side note, the IOMMU we are working on on x86-64 is Calgary,
> > which is actually roughly the same chipset used in some PPC
> > machines...)
> 
> Not sure I ever heard about that... What chipsets ?

The pSeries POWER4 based systems (Regatta) had Calgary, and the 
RS/6000 POWER3 based systems (Condor) had Winnipeg (a precursor to
Calgary, with many of the same features).

Thanks,
Jon

> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
