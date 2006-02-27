Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWB0T51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWB0T51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWB0T51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:57:27 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:44717
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932084AbWB0T50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:57:26 -0500
Date: Mon, 27 Feb 2006 11:57:27 -0800
From: Greg KH <gregkh@suse.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227195727.GA10752@suse.de>
References: <20060227190150.GA9121@kroah.com> <200602271952.08949.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602271952.08949.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 07:52:08PM +0000, Alistair John Strachan wrote:
> On Monday 27 February 2006 19:01, Greg KH wrote:
> [snip]
> > +
> > +Interfaces in the testing state can move to the stable state when the
> > +developers feel they are finished.  They can not be removed from the
> > +kernel tree without going through the obsolete state first.
> > +
> > +It's up to the developer to place their interface in the category they
> > +wish for it to start out in.
> > --- /dev/null
> > +++ gregkh-2.6/Documentation/ABI/obsolete/devfs
> > @@ -0,0 +1,13 @@
> > +What:		devfs
> > +Date:		July 2005
> > +Contact:	Greg Kroah-Hartman <gregkh@suse.de>
> [snip]
> 
> July 2005? Either this date is wrong or the document is out of date.

Heh, I wish.  Have you looked at
Documentation/feature-removal-schedule.txt lately?

Yeah, it's sad, but I keep trying...

thanks,

greg k-h
