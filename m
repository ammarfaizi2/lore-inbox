Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312358AbSDNQHk>; Sun, 14 Apr 2002 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312361AbSDNQHj>; Sun, 14 Apr 2002 12:07:39 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:8202 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312358AbSDNQHj>;
	Sun, 14 Apr 2002 12:07:39 -0400
Date: Sun, 14 Apr 2002 08:07:19 -0700
From: Greg KH <greg@kroah.com>
To: Ian Molton <spyro@armlinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG*
Message-ID: <20020414150719.GA17826@kroah.com>
In-Reply-To: <20020414004022.6450f038.spyro@armlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 17 Mar 2002 12:39:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 12:40:22AM +0100, Ian Molton wrote:
> Hi
> 
> I'm not familiar with the USB code, but I've been hitting a BUG() with my
> new OHCI card (sorry, it was cheap :(   )
> 
> the BUG() is at line 464 in usb-ohci.h, which seems to be a linked-list
> traversal failing to find an entry.

So your "Subject:" is wrong?  Which driver are you having problems with?
usb-ohci.c or usb-uhci.c?

What platform are you running this on, x86?
What devices do you have plugged in?
What were you doing when the BUG() call happened?
Are there any kernel log entries before the BUG()?
What is your .config?
What is the output of /proc/bus/usb/devices with your USB device plugged
in?

thanks,

greg k-h
