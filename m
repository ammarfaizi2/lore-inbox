Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWGEUhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWGEUhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWGEUhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:37:19 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:45279 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964828AbWGEUhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:37:18 -0400
Subject: Re: 2.6.17-mm6
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <20060704014908.9782c85f.akpm@osdl.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	 <200607032250.02054.s0348365@sms.ed.ac.uk>
	 <20060703163121.4ea22076.akpm@osdl.org>
	 <200607040934.14592.s0348365@sms.ed.ac.uk>
	 <20060704014908.9782c85f.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 13:37:13 -0700
Message-Id: <1152131834.24656.57.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 01:49 -0700, Andrew Morton wrote:
> On Tue, 4 Jul 2006 09:34:14 +0100
> Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > a tested version...
> > 
> > This one worked, thanks. Try the same URL again, I've uploaded two better 
> > shots 6,7 that capture the first oops. Unfortunately, I have a pair of oopses 
> > that interchange every couple of boots, so I've included both ;-)
> 
> OK, that's more like it.  Thanks again.
> 
> http://devzero.co.uk/~alistair/oops-20060703/oops6.jpg
> http://devzero.co.uk/~alistair/oops-20060703/oops7.jpg
> 
> People cc'ed.  Help!

Hmmm. No clue on this one from just looking at it.

Greg, do you see anything wrong with the way I'm registering the
timekeeping .resume hook in kernel/timer.c::timekeeping_init_device()?
It looks the same as the other users to me.

I'll look over the config and see if anything sticks out.

thanks
-john








