Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUENRjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUENRjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUENRjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:39:42 -0400
Received: from [80.72.36.106] ([80.72.36.106]:14259 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261931AbUENRjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:39:41 -0400
Date: Fri, 14 May 2004 19:39:36 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IRQ and PCI and (2.6.6-bk1 + some bk trees from -mm1)
In-Reply-To: <1084511147.12353.247.camel@dhcppc4>
Message-ID: <Pine.LNX.4.58.0405141937060.28636@alpha.polcom.net>
References: <A6974D8E5F98D511BB910002A50A6647615FB528@hdsmsx403.hd.intel.com>
 <1084511147.12353.247.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, seems that 2.6.6-mm2 works ok for me (first kernel from 2.6.2 that 
is not broken on my system).

THANKS!!!


Grzegorz Kulewski



On Fri, 14 May 2004, Len Brown wrote:

> 
> > On Thu, 13 May 2004, Grzegorz Kulewski wrote:
> > 
> > > First I cannot boot without acpi_irq_balance.
> 
> 
> >  polb01 ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7  10 11 12 14
> > 15) *9
> 
> Please let me know if this patch does not address the problem:
> 
> http://lkml.org/lkml/2004/5/11/175
> 
> Note that it is included in 2.6.6-mm2
> 
> thanks,
> -Len
> 
> 
> 
