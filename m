Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVEFOT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVEFOT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVEFOTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:19:23 -0400
Received: from soundwarez.org ([217.160.171.123]:55500 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261229AbVEFOSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:18:24 -0400
Subject: Re: Empty partition nodes not created (was device node issues with
	recent mm's and udev)
From: Kay Sievers <kay.sievers@vrfy.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, chrisw@osdl.org, aebr@win.tue.nl,
       rddunlap@osdl.org, greg@kroah.com, joecool1029@gmail.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050506020518.0b0afdc3.akpm@osdl.org>
References: <d4757e6005050219514ece0c0a@mail.gmail.com>
	 <20050503031421.GA528@kroah.com>
	 <20050502202620.04467bbd.rddunlap@osdl.org>
	 <20050506080056.GD4604@pclin040.win.tue.nl>
	 <20050506081009.GX23013@shell0.pdx.osdl.net>
	 <20050506084259.GB25418@apps.cwi.nl>
	 <20050506020518.0b0afdc3.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 May 2005 16:18:22 +0200
Message-Id: <1115389102.32065.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-06 at 02:05 -0700, Andrew Morton wrote:
> Andries Brouwer <Andries.Brouwer@cwi.nl> wrote:
> >
> > On Fri, May 06, 2005 at 01:10:09AM -0700, Chris Wright wrote:
> > > * Andries Brouwer (aebr@win.tue.nl) wrote:
> > > > No, there is no problem but an intentional change in behaviour in -mm
> > > > and now also in 2.6.11.8.
> > > 
> > > I think this should be backed out of -stable.
> > 
> > I was surprised to find it in, after I had written
> > 
> > ============
> > Date: Sat, 30 Apr 2005 21:58:07 +0200
> > 
> > For the time being, although I do not object to the patch,
> > obviously, since it is my own, I cannot see any reason to
> > add it to the "fixed" release.
> > ============
> > 
> > but maybe including it was done by mistake?
> > It wasn't mentioned, I think, in the changelog.
> > 
> > There was a report that it fixed an oops,
> > but the report is unconfirmed and ununderstood.
> > 
> > Should it be backed out of 2.6.11.8? Possibly - but if it will be
> > part of 2.6.12 or 2.6.13 then I would be inclined to leave it.
> > 
> > Andrew asks whether it should be removed from -mm.
> 
> It was merged into Linus's tree on March 8th (via bk, thank gawd.  How do
> you find out that sort of info using git?  Generating a full log is
> cheating).

You can get the commit-history for a file out of the web interface.
Here's another example, cause this change is not in the repository: 
  http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=lib/kobject.c

Thanks,
Kay

