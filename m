Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSGTICg>; Sat, 20 Jul 2002 04:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317397AbSGTICf>; Sat, 20 Jul 2002 04:02:35 -0400
Received: from relay1.pair.com ([209.68.1.20]:56070 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S317396AbSGTICe>;
	Sat, 20 Jul 2002 04:02:34 -0400
X-pair-Authenticated: 68.5.32.13
Content-Type: text/plain; charset=US-ASCII
From: Shane Nay <shane@minirl.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Date: Sat, 20 Jul 2002 00:41:05 -0700
X-Mailer: KMail [version 1.3.2]
References: <3D361091.13618.16DC46FB@localhost> <20020718060841.GC12626@kroah.com> <20020718161429.GB15037@kroah.com>
In-Reply-To: <20020718161429.GB15037@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020720080234Z317396-685+14556@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, Greg, you mean generic USB-Device support? instead USB-Host 
support as is in the main tree.

There is some nice work for this in the ARM-Linux kernel specific to 
the Strong-ARM chip, but I was able to adapt it to another ARM chip I 
was working on easily.  (Though not finished yet due to a bug in the 
USB-D controller h/w)  It's got the s/w to act like a ethernet device 
or a pure bit pipe.

Have you looked closely at arch/arm/mach-sa1100/usb* recently?  It's 
not far from being generalized.  The Zaurus I believe already uses 
this work to act like an ethernet USB device, and iPaq folks on 
handhelds.org have been using it for quite some time.

Thanks,
Shane Nay.

(BTW- Great to hear this is on the agenda for the mainline)

On Thursday 18 July 2002 09:14, Greg KH wrote:
> On Wed, Jul 17, 2002 at 11:08:41PM -0700, Greg KH wrote:
> > On Thu, Jul 18, 2002 at 12:49:21AM -0400, Guillaume Boissiere 
wrote:
> > > o USB gadget support         (Stuart Lynne, Greg Kroah-Hartman)
> >
> > Unless I start to get some help with this, or a Zarus or some
> > other USB gadget type device to test with, I don't think this
> > will happen.
>
> Just to be a bit clearer (as it seems some people don't fully
> understand this item), I need people who have Linux running WITHIN
> a USB gadget, like a Zarus.  This does not include the Palm
> devices, which are USB gadgets, but do not run Linux themselves.
>
> thanks,
