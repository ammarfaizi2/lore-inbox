Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281371AbRKEWFR>; Mon, 5 Nov 2001 17:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281381AbRKEWFH>; Mon, 5 Nov 2001 17:05:07 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:29446 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S281371AbRKEWEv>;
	Mon, 5 Nov 2001 17:04:51 -0500
Date: Mon, 5 Nov 2001 15:04:41 -0800
From: Greg KH <greg@kroah.com>
To: Tim Jansen <tim@tjansen.de>
Cc: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-ID: <20011105150441.D4735@kroah.com>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011105111239.3403b162.rusty@rustcorp.com.au> <p05100316b80c6f3df6f3@[207.213.214.37]> <160qaQ-2523rUC@fmrl04.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160qaQ-2523rUC@fmrl04.sul.t-online.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 08 Oct 2001 20:04:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 09:46:19PM +0100, Tim Jansen wrote:
> On Monday 05 November 2001 17:49, Jonathan Lundell wrote:
> > I think of the tagged list of n-tuples as a kind of ASCII
> > representation of a simple struct. One could of course create a
> > general ASCII representation of a C struct, and no doubt it's been
> > done innumerable times, but I don't think that helps in this
> > application.
> 
> But how can you represent references with those lists? Try to model the 
> content of /proc/bus/usb/devices with them.

The contents of /proc/bus/usb is the usbdevfs file system.  It does not
fit into the current /proc model, or discussion.

It's only mounted at that location, for lack of a better place :)

And no, "usbdevfs" has _nothing_ to do with "devfs", it was a bad name
choice, in hindsight.

thanks,

greg k-h
