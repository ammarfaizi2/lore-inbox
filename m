Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292803AbSBVQg0>; Fri, 22 Feb 2002 11:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292655AbSBVQgQ>; Fri, 22 Feb 2002 11:36:16 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63058 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S292803AbSBVQgG>; Fri, 22 Feb 2002 11:36:06 -0500
Date: Fri, 22 Feb 2002 11:36:00 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: S W <egberts@yahoo.com>, Andrew Hatfield <lkml@secureone.com.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>, techsupport@itexinc.com
Subject: Re: Dlink DSL PCI Card
Message-ID: <20020222113600.F14673@redhat.com>
In-Reply-To: <20020220185044.31163.qmail@web10502.mail.yahoo.com> <E16dcnl-0004Wd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16dcnl-0004Wd-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 20, 2002 at 07:53:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 07:53:17PM +0000, Alan Cox wrote:
> > that have microcodes loaded to them NOR require
> > proprietary microcodes accessed to memory by DMA.  In
> > other word, don't buy winmodem nor DSL PCI adapters,
> > until those chipset manufacturers publish those
> > datasheets.
> 
> The same reasoning goes for another reason. Some of the newest DSL PCI cards are
> in many respects winmodems at multimegabit speed levels, burning huge chunks
> of CPU on a pentium III processor even.

I did some digging on the chipset used by the dlink card, and its made by the 
folks at http://www.itexinc.com/ .  They claim Linux support, but only in the 
form of an infrequently updated binary only module that is only available 
through OEMs.  Unfortunately, they're uncooperative in providing documentation 
for writing an open source driver.  It would be Really Nice if the guidelines 
on the use of the Linux trademark prevented claims of Linux support without 
driver source (ie, forcing binary only module drivers to be marketed as 
"partial Linux support through kernel specific binary modules").

		-ben
