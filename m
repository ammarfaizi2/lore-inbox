Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWIPGuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWIPGuO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 02:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWIPGuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 02:50:14 -0400
Received: from 1wt.eu ([62.212.114.60]:45074 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964773AbWIPGuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 02:50:13 -0400
Date: Sat, 16 Sep 2006 08:38:08 +0200
From: Willy Tarreau <w@1wt.eu>
To: Tejun Heo <htejun@gmail.com>
Cc: Tom Mortensen <tmmlkml@gmail.com>, linux-kernel@vger.kernel.org,
       jeff@garzik.org
Subject: Re: 2.4.x libata resync
Message-ID: <20060916063808.GK541@1wt.eu>
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com> <20060916053713.GJ541@1wt.eu> <450B9940.5030609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450B9940.5030609@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 03:27:12PM +0900, Tejun Heo wrote:
> Hello,
> 
> Willy Tarreau wrote:
> >On Fri, Sep 15, 2006 at 10:14:07PM -0700, Tom Mortensen wrote:
> >>To Jeff Garzik & others,
> >>I was wondering if there are any plans for another resync of the latest
> >>2.6.x libata changes back into the 2.4.x kernel?
> >
> >When Jeff posted his last version (which got merged), he said that it
> >would be his last work on this backport. I've been regularly checking
> >what has changed in 2.6, because often some bugs are fixed, but I see
> >that the code has considerably evolved since the last resync, and I'm
> >not even sure that those bugfixes are needed for 2.4.
> >
> >A full resync of latest 2.6 would require a considerable effort it seems.
> >Do you encounter any problems right now ? I get very few feedback from
> >SATA users in general.
> 
> I don't think it's gonna happen.  Later libata changes depend on a 
> number of SCSI updates, which in turn are deeply dependent upon new 
> driver model used in 2.6.  So, apart from bug fixes, there won't be 2.4 
> resync.

There are a bunch of small patches in the early 2.6 version which look
like bugfixes, but with non-descriptive comments, so I'm not sure what
they fix. Several of them would apply to 2.4, but I don't want to touch
this area as long as nobody complains about problems.

Regards,
Willy

