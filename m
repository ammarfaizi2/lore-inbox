Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWCBMHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWCBMHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWCBMHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:07:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8903 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751093AbWCBMHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:07:10 -0500
Subject: Re: [PATCH] pcmcia: add another ide-cs CF card id
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060302114220.GH4329@suse.de>
References: <200603012259.k21MxBXC013582@hera.kernel.org>
	 <44062FF1.4010108@pobox.com> <20060302075004.GA17789@isilmar.linta.de>
	 <4406D44A.4020101@pobox.com>
	 <1141299117.3206.37.camel@laptopd505.fenrus.org>
	 <20060302114220.GH4329@suse.de>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 13:07:05 +0100
Message-Id: <1141301225.3206.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 12:42 +0100, Jens Axboe wrote:
> On Thu, Mar 02 2006, Arjan van de Ven wrote:
> > On Thu, 2006-03-02 at 06:17 -0500, Jeff Garzik wrote:
> > > Dominik Brodowski wrote:
> > > > On Wed, Mar 01, 2006 at 06:36:17PM -0500, Jeff Garzik wrote:
> > > >>Linux Kernel Mailing List wrote:
> > > >>>commit 42935656914b813c99f91cbac421fe677a6f34ab
> > > >>>tree d37a0d20998f4d87a4bd014300f707c3852ef5f9
> > > >>>parent 82d56e6d2e616bee0e712330bad06b634f007a46
> > > >>>author David Brownell <david-b@pacbell.net> Wed, 25 Jan 2006 22:36:32 -0800
> > > >>>committer Dominik Brodowski <linux@dominikbrodowski.net> Wed, 01 Mar 2006 
> > > 
> > > >>Why was this not CC'd to the IDE maintainer, and linux-ide?
> > > 
> > > > For it is trivial, PCMCIA-related and my time is very limited these days.
> > > 
> > > That's pathetic.  You couldn't even CC linux-kernel on your answer.  And 
> > > this is not even the first or second time you've been asked to CC a 
> > > maintainer.
> > 
> > I personally don't consider that maintainers have a right to demand
> > CC's. Sure it's polite and good to CC them, but that's not the same as
> > having the right to demand this.
> 
> How do you expect the patch to be picked up, if you don't cc the
> maintainer? Looking up the maintainer is trivial. We can't always rely
> on akpm forwarding patches, seems a lot saner to put the onus on the
> submitter to make sure it gets to the right place.


ok so this was adding a PCMCIA ID to a PCMCIA IDE driver. The patch was
mailed first to the pcmcia mailing list.

This is one of those drivers that hits multiple maintainers, arguable
Dominik is the primary maintainer of this driver. The patch doesn't do
ANYTHING structural to the driver, all it does it adds a device ID.
there is therefore zero IDE related change in it.

Sure I can it being nice to CC linux-ide ANYWAY, but, to be honest,
while I see that is important for changes to the driver that change the
structure of it and how it interacts with the IDE layer, I fail to see
the hard required reason for that for just adding a *PCMCIA* ID.

I think Jeff is a bit overreacting in this case.


