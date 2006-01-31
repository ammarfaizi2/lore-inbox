Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWAaVU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWAaVU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWAaVU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:20:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26651 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751497AbWAaVU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:20:59 -0500
Date: Tue, 31 Jan 2006 21:59:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Joshua Kugler <joshua.kugler@uaf.edu>
Cc: Sander <sander@humilis.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [OT] 8-port AHCI SATA Controller?
Message-ID: <20060131205954.GJ4215@suse.de>
References: <20060131115343.GA2580@favonius> <20060131185646.GF6178@favonius> <20060131203845.GH4215@suse.de> <200601311148.52955.joshua.kugler@uaf.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601311148.52955.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31 2006, Joshua Kugler wrote:
> On Tuesday 31 January 2006 11:38, Jens Axboe wrote:
> > On Tue, Jan 31 2006, Sander wrote:
> > > > I got the drivers here:
> > > >
> > > > http://www.keffective.com/mvsata/FC3/
> > > >
> > > > The latest was mvSata_Linux_3.6.1.tgz as of 2005-10-13.
> > >
> > > I very, very much prefer in-tree drivers :-)
> >
> > Actually there is a sata_mv driver in the kernel, however it's pretty
> > experimental right now. I'm sure it could use testers :-)
> 
> Interesting.  I understand it going through testing, but why didn't
> they pull in the mvSata driver referenced above?  It was already GPL.
> Or did they pull in that driver and just want testing?

Did you look at the driver? I'm guessing no :-)

Additionally, it didn't interface with libata at all. A native libata
driver is greatly preferred.

-- 
Jens Axboe

