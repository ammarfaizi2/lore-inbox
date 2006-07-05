Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWGEUuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWGEUuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWGEUuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:50:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60389 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964897AbWGEUuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:50:02 -0400
Date: Wed, 5 Jul 2006 13:46:14 -0700
From: Greg KH <greg@kroah.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-ID: <20060705204614.GA24181@kroah.com>
References: <20060703030355.420c7155.akpm@osdl.org> <200607032250.02054.s0348365@sms.ed.ac.uk> <20060703163121.4ea22076.akpm@osdl.org> <200607040934.14592.s0348365@sms.ed.ac.uk> <20060704014908.9782c85f.akpm@osdl.org> <1152131834.24656.57.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152131834.24656.57.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 01:37:13PM -0700, john stultz wrote:
> On Tue, 2006-07-04 at 01:49 -0700, Andrew Morton wrote:
> > On Tue, 4 Jul 2006 09:34:14 +0100
> > Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > > a tested version...
> > > 
> > > This one worked, thanks. Try the same URL again, I've uploaded two better 
> > > shots 6,7 that capture the first oops. Unfortunately, I have a pair of oopses 
> > > that interchange every couple of boots, so I've included both ;-)
> > 
> > OK, that's more like it.  Thanks again.
> > 
> > http://devzero.co.uk/~alistair/oops-20060703/oops6.jpg
> > http://devzero.co.uk/~alistair/oops-20060703/oops7.jpg
> > 
> > People cc'ed.  Help!
> 
> Hmmm. No clue on this one from just looking at it.
> 
> Greg, do you see anything wrong with the way I'm registering the
> timekeeping .resume hook in kernel/timer.c::timekeeping_init_device()?
> It looks the same as the other users to me.

At first glance, no, it looks sane to me.

Are you sure you aren't registering two things with the same name
somehow?

thanks,

greg k-h
