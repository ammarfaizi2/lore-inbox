Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEWVK>; Fri, 5 Jan 2001 17:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEWVA>; Fri, 5 Jan 2001 17:21:00 -0500
Received: from foobar.napster.com ([64.124.41.10]:60168 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S129183AbRAEWUn>; Fri, 5 Jan 2001 17:20:43 -0500
Message-ID: <3A5648A8.864875FF@napster.com>
Date: Fri, 05 Jan 2001 14:20:24 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@wirex.com>
CC: jerdfelt@valinux.com, usb@in.tum.de, linux-kernel@vger.kernel.org
Subject: Re: USB problems with 2.4.0: USBDEVFS_BULK failed
In-Reply-To: <3A5544EF.CF41B6A8@napster.com> <20010104210410.A14563@wirex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> On Thu, Jan 04, 2001 at 07:52:15PM -0800, Jordan Mendelson wrote:
> >
> > Alright, this is driving me nuts. I have a Canon S20 digital camera
> > hooked up to a Sony XG series laptop via the USB port and am using s10sh
> > to access it. s10sh uses libusb 0.1.1, but I've also tried it using
> > libusb 0.1.2 without any luck. libusb uses usbfs to access to the device
> > from userspace.
> >
> > The last time it worked was around 2.4.0test10, but might have been
> > test9. test12, prerelease and 2.4.0 final all fail.
> 
> Could you try to verify exactly which version things died on?  As you
> know USB has had a number of changes to the code recently :)
> 
> That would help us try to determine what broke.

I just rebooted a few times... 2.4.0-test10 is the last kernel that it
worked correctly with. 2.4.0-test11 shows the same signs as
2.4.0-test12, prerelease and 2.4.0 proper.


Jordan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
