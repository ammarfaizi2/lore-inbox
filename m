Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313927AbSDSFhh>; Fri, 19 Apr 2002 01:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314179AbSDSFhg>; Fri, 19 Apr 2002 01:37:36 -0400
Received: from smtp2.san.rr.com ([24.25.195.39]:50866 "EHLO smtp2.san.rr.com")
	by vger.kernel.org with ESMTP id <S313927AbSDSFhf>;
	Fri, 19 Apr 2002 01:37:35 -0400
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8
	(take 2)
From: George J Karabin <gkarabin@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Brownell <david-b@pacbell.net>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020417181722.GB1162@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-3) 
Date: 18 Apr 2002 22:37:37 -0700
Message-Id: <1019194658.1734.12.camel@pane.chasm.dyndns.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Confusing as it may be to non-USB developers, how about using the USB
spec terms "host" (for the PC) and "local host" (for the USB
gadget/client/device/etc...)? I haven't seen those specific terms
suggested yet after quickly searching through the archive.

For shorthand, you might use "h" and "lh" suffixes, i.e., "usbh" for
host code, and "usblh" for local host code. Or something else if that
seems too terse.

One well placed Readme file ought to make the distinction pretty clear
to most end users, and USB developers shouldn't find it a problem at
all.

- George

On Wed, 2002-04-17 at 11:17, Greg KH wrote:
> On Wed, Apr 17, 2002 at 10:57:21AM -0700, Linus Torvalds wrote:
> > 
> > What were the other suggestions?
> 
> "client" was my original choice, which was changed to "device" after a
> bit of discussion.  There were no other suggestions.
> 
> greg k-h
> 
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel


