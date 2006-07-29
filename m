Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751992AbWG2BsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbWG2BsH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 21:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbWG2BsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 21:48:06 -0400
Received: from paragon.brong.net ([66.232.154.163]:8681 "EHLO
	paragon.brong.net") by vger.kernel.org with ESMTP id S1751992AbWG2BsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 21:48:05 -0400
Date: Sat, 29 Jul 2006 11:48:01 +1000
From: Bron Gondwana <brong@fastmail.fm>
To: erich <erich@areca.com.tw>
Cc: Greg KH <greg@kroah.com>, Robert Mueller <robm@fastmail.fm>,
       Dax Kelson <dax@gurulabs.com>, Theodore Bullock <tbullock@nortel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Areca arcmsr kernel integration
Message-ID: <20060729014801.GB5487@brong.net>
References: <25E284CCA9C9A14B89515B116139A94D0C6DF1A4@zrtphxm0.corp.nortel.com> <20060728202749.GA23662@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728202749.GA23662@kroah.com>
Organization: brong.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Rob and Dax to CC and erich as primary recipient)

On Fri, Jul 28, 2006 at 01:27:49PM -0700, Greg KH wrote:
> On Fri, Jul 28, 2006 at 02:07:12PM -0400, Theodore Bullock wrote:
> > It would be really nice to see the arcmsr driver integrated into the
> > mainline kernel in the nearish future.
> > 
> > Ideally, the driver would be available before the next major
> > distribution is published so that the hardware can be officially
> > supported by the distribution developers eg. Novell, Red Hat, Canonical
> > ... etc.
> > 
> > After a brief review of upcoming schedules, Fedora Core looks to be
> > updated next in October with the last test release currently scheduled
> > for October. After that it will probably be SuSE.
> > 
> > We have a good number of workstations with this hardware here, but
> > support isn't available from our distribution.
> > 
> > Checking the recent posts it seems that there are two outstanding issues
> > 
> > > - PAE (cast of dma_addr_t to unsigned long) issues. 
> > > - SYNCHRONIZE_CACHE is ignored.  This is wrong.  The sync cache in the
> > 
> > > shutdown notifier isn't sufficient.
> > 
> > That said, we have been using an older version of the driver off the
> > Areca website for some time now with no major issues (other than kernel
> > update problems). 
> > 
> > Is it possible to get the driver integrated and fix these problems
> > after?
> 
> Why not fix them up and submit the corrected driver?  If no one wants to
> put the effort into fixing these issues now, why would they do the work
> later?
> 
> thanks,
> 
> greg k-h

Hi erich and other interested parties,

I agree with Theodore that it would be a great idea to get the arcmsr
driver and I'm sure we'd all be happy to help you with whatever you need
to make this happen.

Is any of the technical hardware documentation available to us so we can
help you with the driver design?  I'm certainly happy to help with
testing and/or documentation, and I have some C programming skills,
though I haven't done any serious kernel programming.

Regards,

Bron.
