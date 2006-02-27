Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWB0UFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWB0UFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWB0UFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:05:08 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:16396 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932212AbWB0UFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:05:07 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Date: Mon, 27 Feb 2006 20:05:17 +0000
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
References: <20060227190150.GA9121@kroah.com> <200602271952.08949.s0348365@sms.ed.ac.uk> <20060227195727.GA10752@suse.de>
In-Reply-To: <20060227195727.GA10752@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602272005.17470.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 19:57, Greg KH wrote:
> On Mon, Feb 27, 2006 at 07:52:08PM +0000, Alistair John Strachan wrote:
> > On Monday 27 February 2006 19:01, Greg KH wrote:
> > [snip]
> >
> > > +
> > > +Interfaces in the testing state can move to the stable state when the
> > > +developers feel they are finished.  They can not be removed from the
> > > +kernel tree without going through the obsolete state first.
> > > +
> > > +It's up to the developer to place their interface in the category they
> > > +wish for it to start out in.
> > > --- /dev/null
> > > +++ gregkh-2.6/Documentation/ABI/obsolete/devfs
> > > @@ -0,0 +1,13 @@
> > > +What:		devfs
> > > +Date:		July 2005
> > > +Contact:	Greg Kroah-Hartman <gregkh@suse.de>
> >
> > [snip]
> >
> > July 2005? Either this date is wrong or the document is out of date.
>
> Heh, I wish.  Have you looked at
> Documentation/feature-removal-schedule.txt lately?

If you're going by the time (OBSOLETE) was added to the kernel help message, 
this predates July 2005. If we're going by "no earlier than when 
feature-removal-schedule was introduced", then I guess this is correct.

But even now, devfs is still in the kernel.

Thanks for the answer anyway, I guess this is a non-issue (who will try to use 
code that can't be selected via config?).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
