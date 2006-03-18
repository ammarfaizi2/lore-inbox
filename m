Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWCRPnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWCRPnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWCRPnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:43:21 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:50300 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1750893AbWCRPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:43:20 -0500
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=zA2nAZC8nRDnJh+CoS+OyZ8a+m2J8lCL0Vq8pnnmjYFi+R2YI8/rOY4ZpGKKfHSXMh59JMXXArDU8oOZDwOGAs1OI9Dwc/pMq6p52kzGypEhRVvpQy+nuKifyArRkRAQ;
X-IronPort-AV: i="4.03,106,1141624800"; 
   d="scan'208"; a="396635476:sNHT39985836"
Date: Sat, 18 Mar 2006 09:43:20 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, matthew.e.tolentino@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Message-ID: <20060318154319.GB29862@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <20060104221627.GA26064@lists.us.dell.com> <20060106172140.GB19605@lists.us.dell.com> <20060106223932.GB9230@lists.us.dell.com> <20060317155445.602f07b9.akpm@osdl.org> <20060318145621.GA29862@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318145621.GA29862@humbolt.us.dell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 08:56:21AM -0600, Matt Domsch wrote:
> On Fri, Mar 17, 2006 at 03:54:45PM -0800, Andrew Morton wrote:
> > It could be that Andi's changes break the ia64 dmi impementation - I don't
> > know.  I guess it's OK if ia64 is not doing a scan "early".
> 
> It's not done "early", because at this point it's only needed for
> drivers.  On i386 it's done "early" to catch some chipsets
> (coincidentally, Dell).
> 
> > The above might not compile, but I'll make sure that it does so before
> > releasing next -mm.
> > 
> > So.  Bottom line: please test the ia64 dmi patches in next -mm, send any
> > needed fixups, thanks.
> 
> 
> Built 2.6.16-rc6-mm2 on ia64 Itanium2 (Dell PowerEdge 7250, aka Intel
> Tiger4).  Compiled clean, loaded clean, works as expected.  Thanks!

Built 2.6.16-rc6-mm2 on x86_64 Dell PowerEdge 2800.  Compiled clean,
loaded clean, works as expected.  Thanks!

-Matt

--
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
