Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937165AbWLEAph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937165AbWLEAph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 19:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937212AbWLEAph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 19:45:37 -0500
Received: from ns1.suse.de ([195.135.220.2]:46615 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937165AbWLEAph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 19:45:37 -0500
Date: Mon, 4 Dec 2006 16:45:21 -0800
From: Greg KH <gregkh@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Lu, Yinghai" <yinghai.lu@amd.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Stefan Reinauer <stepan@coresystems.de>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/2] x86_64: earlyprintk usb debug device support.
Message-ID: <20061205004521.GA26035@suse.de>
References: <5986589C150B2F49A46483AC44C7BCA4907280@ssvlexmb2.amd.com> <20061204203308.GA30307@suse.de> <m1bqmj8i8z.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1bqmj8i8z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 02:26:52PM -0700, Eric W. Biederman wrote:
> Greg KH <gregkh@suse.de> writes:
> 
> > On Mon, Dec 04, 2006 at 12:18:30PM -0800, Lu, Yinghai wrote:
> >> -----Original Message-----
> >> From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
> >> 
> >> >arch/x86_64/kernel/early_printk.c |  574
> >> +++++++++++++++++++++++++++++++++++++
> >> > drivers/usb/host/ehci.h           |    8 +
> >> > include/asm-x86_64/fixmap.h       |    1 
> >> 
> >> Can you separate usbdebug handle out from early_printk? 
> >
> > Yeah, at least tear it out of x86-64, so those of us stuck on different
> > platforms can use this :)
> >
> > Other than that minor issue, this looks great.  I don't have a x86-64
> > box set up here at the moment, so I can't test it, but it looks
> > acceptable at first glance.
> 
> Makes sense.  I'm curious now what architecture do you have?

i386

My main development box these days is a mac mini due to it's great form
factor and ability to suspend to ram easily.  Unfortunately they don't
come with a working 64bit processor just yet.

> Anyway next time I touch this the project will be how to integrate
> this into the kernel cleanly.  This round was to figure out how
> to get some working code.
> 
> If someone beats me to the punch on generalizing this code I won't
> mind.
> 
> The first pass was a success.  And the performance is reasonable
> assuming you don't plug the end you are watching into a usb1 only
> port.
> 
> Given that I didn't really know anything about usb a week ago I think
> I did pretty well :)

Yes, you certainly did, no complaint from me at all about that :)

thanks,

greg k-h
