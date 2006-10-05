Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWJEINI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWJEINI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWJEINI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:13:08 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:30910 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751211AbWJEINE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:13:04 -0400
Date: Thu, 5 Oct 2006 17:12:47 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: Industrial device driver uio/uio_*
Message-ID: <20061005081247.GA8218@localhost.hsdv.com>
References: <1157995334.23085.188.camel@localhost.localdomain> <1159988394.25772.97.camel@localhost.localdomain> <20061004121835.bb155afe.akpm@osdl.org> <1159990345.1386.277.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159990345.1386.277.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 09:32:25PM +0200, Thomas Gleixner wrote:
> On Wed, 2006-10-04 at 12:18 -0700, Andrew Morton wrote:
> > On Wed, 04 Oct 2006 19:59:54 +0100
> > > I would just NAK it but want to be sure the guys saw the list of
> > > problems
> > > 
> > 
> > cc's added.
> > 
> > Thomas has been a bit tied up with timers and interrupts of late.
> 
> Yup. fork(tglx) still returns -ETOOMANYINSTANCES.
> 
> I have no objections, if you pull it from -mm for now. The list of flaws
> is accepted and we'll work on this in foreseeable time, _IF_ there is
> some basic consensus about the idea itself not being fundamentaly wrong.
> 
I've got a few cycles I can throw at this, it's a problem space we
(Renesas) are interested in too..

Alan, is your Sept. 11 list the extent of your issues with the current
code, or was there more that you sent off-list?

I'll toss up a quick git tree for this so we don't lose anything, and
the fixes can trickle in to -mm that way, or it can just be pulled and
added back later.
