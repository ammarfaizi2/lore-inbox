Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbRLXSwF>; Mon, 24 Dec 2001 13:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285229AbRLXSvz>; Mon, 24 Dec 2001 13:51:55 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:23307 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285226AbRLXSvn>;
	Mon, 24 Dec 2001 13:51:43 -0500
Date: Mon, 24 Dec 2001 10:47:24 -0800
From: Greg KH <greg@kroah.com>
To: Juergen Sauer <jojo@automatix.de>
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-usb-users] VIA Chipsets + USB + SMP == UGLY TRASH
Message-ID: <20011224104724.B8215@kroah.com>
In-Reply-To: <E16IRTQ-0003oN-00@s.automatix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16IRTQ-0003oN-00@s.automatix.de>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 26 Nov 2001 16:11:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 10:32:49AM +0100, Juergen Sauer wrote:
> Hi!
> Merry X-Mas everywhere !
> 
> So, my USB tryout is over. 
> This is the expierience report:
> You should not try to use VIA Chipsets + SMP + USB, that's
> the worst thinkable idea. It's junk (usb-Part).

Depends on the motherboard.  What one do you have?

> That's why:
> 1. not solved USB Irq errors in APIC mode, causes:
> 	Error -110, device does not accept ID
> 	USB Host is recognized fine, no device is attaced
> 
> This is an error somewhere in the Kernel APIC Irq routing, which may 
> worked around with "append noapic pirq="your irq" but using such a cutdown
> USB System is not a good idea, no relly working bulk-transfers (forget 
> any devices which depend from it: scanners, camera, sound, isdn, 
> harddisks, zip etc.)

I have a SMP motherboard that requires this (noapic setting).  With that
set, everything works fine including bulk transfers and all other USB
devices that I have.

What error messages do you have showing that bulk transfers do not work?

thanks,

greg k-h
