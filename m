Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268632AbUHLRaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268632AbUHLRaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268628AbUHLRan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:30:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:7906 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268626AbUHLRak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:30:40 -0400
Date: Thu, 12 Aug 2004 10:29:55 -0700
From: Greg KH <greg@kroah.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040812172955.GE596@kroah.com>
References: <20040806211413.77833.qmail@web14926.mail.yahoo.com> <200408111004.02995.jbarnes@engr.sgi.com> <20040811172800.GB14979@kroah.com> <200408111102.10689.jbarnes@engr.sgi.com> <20040811181236.GD14979@kroah.com> <20040812012843.GA2122@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812012843.GA2122@dmt.cyclades>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 10:28:43PM -0300, Marcelo Tosatti wrote:
> > > > > Jon, this works on my machine too.  Greg, if it looks ok can you pull it
> > > > > in? And can you add:
> > > > >
> > > > >  * (C) Copyright 2004 Silicon Graphics, Inc.
> > > > >  *       Jesse Barnes <jbarnes@sgi.com>
> > > > >
> > > > > to pci-sysfs.c if you do?
> > > >
> > > > Care to send me a new patch?  Oh, and that copyright line needs to look
> > > > like:
> > > > * Copyright (c) 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
> > > >
> > > > to make it legal, or so my lawyers say :)
> > > 
> > > But I'm not the copyright holder, Silicon Graphics is, I just wanted people to 
> > > know who to harass if something breaks :).
> > 
> > That's fine.  It's the "Copyright (c) 2004" order and exact "(c)" that
> > really matters, from what I have been told to do.
> 
> Greg,
> 
> That made me curious, what is the rationale behind 
> 
> (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com> 
> 
> works and the previous suggested
> 
> (C) Copyright 2004 Silicon Graphics, Inc. 
> 	Jesse Barnes <jbarnes@sgi.com> 
> 
> doesnt? 
> 
> I know its a bit offtopic, but still, if you know the reason, would be
> great to hear :) Bet others will also like to hear that. 

Ok, this is as per some copyright lawyers who know US Copyright law, and
how to defend it in court.  To make it legally binding in the US, so you
can file for a copyright in the proper government agencies (which is
necessary if you want to be able defend your copyright in court in an
easier manner, it's not necessary but it sure helps.) you need the
phrase to look like:
	Copyright (c) <DATE> <COMPANY_NAME>

Note that this is different from the above description of putting a
"(C)" and then the word "Copyright".

Now I have no idea if this is the same for all countries, I only know
what I was told to do.

Hope this helps, and I really don't want to start a big "copyright"
thread, as I'm not a lawyer, I only have to deal with them on a constant
basis :)

thanks,

greg k-h
