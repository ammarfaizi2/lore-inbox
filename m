Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSIEQVT>; Thu, 5 Sep 2002 12:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSIEQVT>; Thu, 5 Sep 2002 12:21:19 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:12561 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317852AbSIEQVS>;
	Thu, 5 Sep 2002 12:21:18 -0400
Date: Thu, 5 Sep 2002 09:23:48 -0700
From: Greg KH <greg@kroah.com>
To: Martyn Ranyard <ranyardm@lineone.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rio Riot 20Gb HDD USB MP3 Player
Message-ID: <20020905162348.GA12763@kroah.com>
References: <5.1.0.14.2.20020905160748.02f07030@pop.lineone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020905160748.02f07030@pop.lineone.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 04:13:28PM +0100, Martyn Ranyard wrote:
> 
> Hi all,
> 
>   This is my first posting to this list, and I am not subscribed (so 
> please cc me in on any replies to this thread -thanks), however I do follow 
> the kernel traffic weekly mail.
> 
>   I have recently acquired a Rio Riot 20Gb HDD USB MP3 Player, and I have 
> had no luck finding a device driver so far, but I am willing to help with 
> testing and possibly a bit of development (I am more accustomed to writing 
> in Borland/FreePascal than c however).  Does anyone know of a driver 
> project, or shall I start one off?  Is this better done in user-space?

Did you look at the list of supported Linux USB devices linked off of
www.linux-usb.org?  And the linux-usb-devel mailing list is probably the
better place for this kind of discussion.

If your device looks like a USB Mass storage device, then a kernel
driver modification might be needed.  Otherwise you are probably better
off using usbfs/libusb to talk to the device from userspace, which is
what the other USB Rio devices do.

Good luck,

greg k-h
