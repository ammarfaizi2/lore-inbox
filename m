Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbRAEFC7>; Fri, 5 Jan 2001 00:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131529AbRAEFCj>; Fri, 5 Jan 2001 00:02:39 -0500
Received: from [216.161.55.93] ([216.161.55.93]:46844 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131375AbRAEFCa>;
	Fri, 5 Jan 2001 00:02:30 -0500
Date: Thu, 4 Jan 2001 21:04:10 -0800
From: Greg KH <greg@wirex.com>
To: Jordan Mendelson <jordy@napster.com>
Cc: jerdfelt@valinux.com, usb@in.tum.de, linux-kernel@vger.kernel.org
Subject: Re: USB problems with 2.4.0: USBDEVFS_BULK failed
Message-ID: <20010104210410.A14563@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Jordan Mendelson <jordy@napster.com>, jerdfelt@valinux.com,
	usb@in.tum.de, linux-kernel@vger.kernel.org
In-Reply-To: <3A5544EF.CF41B6A8@napster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5544EF.CF41B6A8@napster.com>; from jordy@napster.com on Thu, Jan 04, 2001 at 07:52:15PM -0800
X-Operating-System: Linux 2.4.0-prerelease (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 07:52:15PM -0800, Jordan Mendelson wrote:
> 
> Alright, this is driving me nuts. I have a Canon S20 digital camera
> hooked up to a Sony XG series laptop via the USB port and am using s10sh
> to access it. s10sh uses libusb 0.1.1, but I've also tried it using
> libusb 0.1.2 without any luck. libusb uses usbfs to access to the device
> from userspace. 
> 
> The last time it worked was around 2.4.0test10, but might have been
> test9. test12, prerelease and 2.4.0 final all fail.

Could you try to verify exactly which version things died on?  As you
know USB has had a number of changes to the code recently :)

That would help us try to determine what broke.

thanks,

greg k-h


-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
