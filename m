Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314097AbSDQOpr>; Wed, 17 Apr 2002 10:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314098AbSDQOpr>; Wed, 17 Apr 2002 10:45:47 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:61968 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314097AbSDQOpp>;
	Wed, 17 Apr 2002 10:45:45 -0400
Date: Wed, 17 Apr 2002 06:44:53 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB device support for 2.5.8 (take 2)
Message-ID: <20020417134453.GE32370@kroah.com>
In-Reply-To: <20020417035236.GC29897@kroah.com> <Pine.LNX.4.33.0204162203510.15675-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 20 Mar 2002 11:34:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 10:08:48PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 16 Apr 2002, Greg KH wrote:
> >
> > It's code to be a USB client device, not a USB host device, which is
> > what we currently have.  It is used in embedded devices that run Linux,
> > like the new Sharp device (can't remember the name right now...)
> 
> Ahhh.. A dim light goes on.
> 
> It would have made more sense (I think) to call it "usb/client" instead of
> "usb/device", but maybe that's just because I didn't understand what the
> thing was all about.

We (the linux-usb-devel list) talked about different names for this
stuff, and tried to follow the naming convention used in the USB spec.
However 99% of kernel developers will never read that spec, and 100% of
users never will, and the name "devices" failed to convey any good
meaning to the first person that saw the tree outside of the USB
developers, so changing the name to "client" makes a lot more sense :)

thanks,

greg k-h
