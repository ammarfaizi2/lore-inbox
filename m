Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265890AbUGAPLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265890AbUGAPLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUGAPLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:11:38 -0400
Received: from ida.rowland.org ([192.131.102.52]:5636 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265890AbUGAPLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:11:25 -0400
Date: Thu, 1 Jul 2004 11:10:24 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: linux-usb-users@lists.sourceforge.net, janne <sniff@xxx.ath.cx>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-usb-users] linux 2.6.6, bttv and usb2 data corruption &
 lockups & poor performance
In-Reply-To: <200407010904.39925.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0407011107270.1083-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2004, Duncan Sands wrote:

> > Hardware:
> >  Athlon XP 1600+
> >  Epox 8KHA+ VIA KT266A
> >  BT878 TV-card (bttv card=36 tuner=1)
> >  Edimax Via6302 4port PCI Usb2 controller (ehci-hcd)
> >  Lacie P3 250GB Usb2 hard drive (usb-storage, reiserfs)
> 
> I get hard hangs with a Bt878 + disk activity (every time it hangs,
> the disk activity LED is on).  But I don't have usb2.  However I have
> a similar processor, Athlon XP 2100+, and motherboard, VIA KT333.
> I'm also using reiserfs (where an OOPS occurred in your system logs).
> I also have a realtek 8139 ethernet card.  We both have VIA usb 1.1
> controllers.  My hangs happen with both 2.4 and 2.6 kernels.  I only
> get hangs if I'm using the bttv card.

Is it possible that you are exceeding the capacity of your PCI bus?

> Are you sure you plugged your device into a usb 2 port, and not a usb 1.1 port?
> Also, some products claim to be usb 2 devices, when they are in fact only usb 1.1.

Be careful about your use of terms.  Lots of people think USB-2.0 means
the same as high speed and USB-1.1 means full speed.  That's not right;  
it's perfectly legal for a USB-2.0 device to run only at full speed.

Alan Stern

