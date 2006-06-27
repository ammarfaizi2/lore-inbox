Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWF0P2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWF0P2V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWF0P2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:28:20 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:54723 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161099AbWF0P2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:28:18 -0400
Subject: Re: Areca driver recap + status
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: Andrew Morton <akpm@osdl.org>, rdunlap@xenotime.net, hch@infradead.org,
       erich@areca.com.tw, brong@fastmail.fm, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Robert Mueller <robm@fastmail.fm>
In-Reply-To: <1151367789.2935.23.camel@mentorng.gurulabs.com>
References: <09be01c695b3$2ed8c2c0$c100a8c0@robm>
	 <20060621222826.ff080422.akpm@osdl.org>
	 <1151333338.2673.4.camel@mulgrave.il.steeleye.com>
	 <1151367789.2935.23.camel@mentorng.gurulabs.com>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 10:27:49 -0500
Message-Id: <1151422069.3340.23.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 18:23 -0600, Dax Kelson wrote:
> On Mon, 2006-06-26 at 09:48 -0500, James Bottomley wrote:
> > Not the world perhaps, but I'm unwilling to concede that if a driver
> > author is given a list of major issues and does nothing, then the driver
> > should go in after everyone gets impatient.
> 
> That isn't accurate or fair. Erich has submitted large patches to
> address issues. That hardly qualifies as "does nothing".

Yes, that was unfair, and I apologise for it.  However ...

> > The list of issues is here:
> > 
> > http://marc.theaimsgroup.com/?l=linux-scsi&m=114556263632510
> > 
> > Most of the serious stuff is fixed with the exception of:
> > 
> > - sysfs has more than one value per file
> > - BE platform support
> > - PAE (cast of dma_addr_t to unsigned long) issues.
> > - SYNCHRONIZE_CACHE is ignored.  This is wrong.  The sync cache in the
> > shutdown notifier isn't sufficient.
> > 
> > At least the sysfs files have to be fixed before it goes in ... unless
> > you want to be lynched by Greg?
> 
> Thanks for the new list. Erich has been eager to get work on any
> remaining blockers.

This isn't a new list.  It's extracted from the old list summary of
serious issues which an inspection of the driver reveals to be still
unresolved.  The original list was posted on 20 April

http://marc.theaimsgroup.com/?l=linux-scsi&m=114556263632510

And that one was an redux of a previously posed list that I can't be
bothered to find.

> It would have been nice to have gotten it back on May 19th, they might
> have been resolved by now.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114801926400287&w=2

Well, this is what's adding to the rising frustration ... there's
apparently been another hiatus where I thought someone was working on
the rest of the issues labelled serious and no-one was.

James


