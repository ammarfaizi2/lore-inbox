Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSEVTVI>; Wed, 22 May 2002 15:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSEVTVI>; Wed, 22 May 2002 15:21:08 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:32517 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316684AbSEVTVH>;
	Wed, 22 May 2002 15:21:07 -0400
Date: Wed, 22 May 2002 12:21:01 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?Andr=E9?= Bonin <kernel@bonin.ca>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel?
Message-ID: <20020522192101.GG4802@kroah.com>
In-Reply-To: <20020520223132.GC25541@kroah.com> <008b01c2012d$69db21c0$0601a8c0@CHERLYN>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 24 Apr 2002 17:42:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 09:10:04PM -0400, André Bonin wrote:
> 
> ----- Original Message -----
> From: "Greg KH" <greg@kroah.com>
> To: <linux-usb-devel@lists.sourceforge.net>
> Cc: <linux-kernel@vger.kernel.org>; <Linux-usb-users@lists.sourceforge.net>
> Sent: Monday, May 20, 2002 6:31 PM
> Subject: What to do with all of the USB UHCI drivers in the kernel?
> 
> 
> >
> > Ok, now that 2.5.16 is out, we have a total of 4 different USB UHCI
> > controller drivers in the kernel!  That's about 3 too many for me :)
> >
> > So what to do?  I propose the following:
> >
> >   From now until July 1, I want everyone to test out both the uhci-hcd
> >   and usb-uhci-hcd drivers on just about every piece of hardware they
> >   can find.  This includes SMP, UP, preempt kernels, big and little
> >   endian machines, and loads of different types of USB devices.
> 
> The UHCI driver never recognizes my hardware.  The OHCI driver (in the
> 2.4.18 kernel) does however.  My Asus A7M266-D doesn't have an onboard USB
> but they ship an add-on card with the motherboard (made by Asus).

This is probably because you have an OHCI hardware device, not a UHCI
device.  What does 'lspci -v' say for your machine?

And how does 2.5.17 work for you?

thanks,

greg k-h
