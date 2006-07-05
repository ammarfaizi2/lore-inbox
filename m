Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWGEWbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWGEWbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 18:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWGEWbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 18:31:47 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:27140 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S964859AbWGEWbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 18:31:47 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.17-mm6
Date: Wed, 5 Jul 2006 23:32:13 +0100
User-Agent: KMail/1.9.3
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060703030355.420c7155.akpm@osdl.org> <1152131834.24656.57.camel@cog.beaverton.ibm.com> <20060705204614.GA24181@kroah.com>
In-Reply-To: <20060705204614.GA24181@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607052332.13028.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 July 2006 21:46, Greg KH wrote:
> On Wed, Jul 05, 2006 at 01:37:13PM -0700, john stultz wrote:
> > On Tue, 2006-07-04 at 01:49 -0700, Andrew Morton wrote:
> > > On Tue, 4 Jul 2006 09:34:14 +0100
> > >
> > > Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > > > a tested version...
> > > >
> > > > This one worked, thanks. Try the same URL again, I've uploaded two
> > > > better shots 6,7 that capture the first oops. Unfortunately, I have a
> > > > pair of oopses that interchange every couple of boots, so I've
> > > > included both ;-)
> > >
> > > OK, that's more like it.  Thanks again.
> > >
> > > http://devzero.co.uk/~alistair/oops-20060703/oops6.jpg
> > > http://devzero.co.uk/~alistair/oops-20060703/oops7.jpg
> > >
> > > People cc'ed.  Help!
> >
> > Hmmm. No clue on this one from just looking at it.
> >
> > Greg, do you see anything wrong with the way I'm registering the
> > timekeeping .resume hook in kernel/timer.c::timekeeping_init_device()?
> > It looks the same as the other users to me.
>
> At first glance, no, it looks sane to me.
>
> Are you sure you aren't registering two things with the same name
> somehow?

Whatever it is, it doesn't happen every time. Sometimes the kernel boots.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
