Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030676AbWF0HDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030676AbWF0HDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030675AbWF0HDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:03:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4662 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030676AbWF0HDf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:03:35 -0400
Date: Tue, 27 Jun 2006 09:05:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
Message-ID: <20060627070505.GH22071@suse.de>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271428.11654.nigel@suspend2.net> <20060627053623.GG22071@suse.de> <200606271539.29540.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200606271539.29540.nigel@suspend2.net>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2006, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 27 June 2006 15:36, Jens Axboe wrote:
> > On Tue, Jun 27 2006, Nigel Cunningham wrote:
> > > Hi.
> > >
> > > On Tuesday 27 June 2006 07:20, Rafael J. Wysocki wrote:
> > > > On Monday 26 June 2006 18:54, Nigel Cunningham wrote:
> > > > > Add Suspend2 extent support. Extents are used for storing the lists
> > > > > of blocks to which the image will be written, and are stored in the
> > > > > image header for use at resume time.
> > > >
> > > > Could you please put all of the changes in kernel/power/extents.c into
> > > > one patch?  It's quite difficult to review them now, at least for me.
> > >
> > > I spent a long time splitting them up because I was asked in previous
> > > iterations to break them into manageable chunks. How about if I were to
> > > email you the individual files off line, so as to not send the same
> > > amount again?
> >
> > Managable chunks means logical changes go together, one function per
> > diff is really extreme and unreviewable. Support for extents is one
> > logical change, so it's one patch. Unless of course you have to do some
> > preparatory patches, then you'd do those separately.
> >
> > I must admit I thought you were kidding when I read through this extents
> > patch series, having a single patch just adding includes!
> 
> Sorry for fluffing it up. I'm pretty inexperienced, but I'm trying to
> follow CodingStyle and all the other advice. If I'd known I'd
> misunderstood what was wanted, I probably could have submitted this
> months ago. Oh well. Live and learn. What would you have me do at this
> point?

Split up your patches differently, and not in so many steps. Ideally
each step should work and compile, with each introducing some sort of
functionality. Each patch should be reviewable on its own.

-- 
Jens Axboe

