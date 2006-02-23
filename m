Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWBWUXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWBWUXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWBWUXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:23:13 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:9879 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S932103AbWBWUXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:23:12 -0500
Date: Thu, 23 Feb 2006 22:23:12 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Oliver Joa <oliver@j-o-a.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: promise sata 300 TX4 and Samsung HD (SP2004C) -> Sector errors
Message-ID: <20060223202312.GT16512@edu.joroinen.fi>
References: <Pine.LNX.4.63.0602221247380.2270@majestix.gallier.de> <Pine.LNX.4.63.0602230924410.4554@majestix.gallier.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0602230924410.4554@majestix.gallier.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 09:26:54AM +0100, Oliver Joa wrote:
> Hi,
> 
> On Wed, 22 Feb 2006, Oliver Joa wrote:
> 
> >Hi,
> >
> >i have a brandnew Promise SATA 300 TX4 Controller and 2 Samsung HD
> >(SP2004C). I am using Linux 2.6.15 and also tried 2.6.15.4 with
> >sata_promise-driver. I get sector-errors:
> 
> [...]
> 
> It seems to be that it is not working. I want to buy a other controller. 
> Which one do you recommend for linux. I would like to have a cheap one 
> with good driver support. Any idea?
> 
> Thanks a lot
> 

When I searched for PCI SATA controllers some time ago, I found out Promise SATA
300 was best supported in Linux. sata_promise driver is marked as "production" 
in the sata status pages.

Most of the other PCI SATA controllers are based on marvell chipset, but the
Linux driver for marvell is still beta :(

I'm successfully using Promise SATA 300 with Seagate drives, no problems so
far. *knocking wood*

-- Pasi
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
