Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293022AbSCAPZX>; Fri, 1 Mar 2002 10:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293086AbSCAPZN>; Fri, 1 Mar 2002 10:25:13 -0500
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:37381 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S293022AbSCAPZD>; Fri, 1 Mar 2002 10:25:03 -0500
Date: Fri, 1 Mar 2002 10:25:02 -0500
From: Gerald Britton <gbritton@alum.mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arnvid Karstad <arnvid@karstad.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.x, ThinkPad T23 and HW?!
Message-ID: <20020301102502.A26473@light-brigade.mit.edu>
In-Reply-To: <20020228233954.7840.qmail@nextgeneration.speedroad.net> <E16gbS1-0001r9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16gbS1-0001r9-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 01, 2002 at 01:03:09AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > actually a prism2 (?) card, are mysteriously detected as an device created 
> > by "Harris Semiconductor" and it won't even try to let me access the card.
> 
> Well guess what - it is
> 
> > think I've tried every driver in the Kernel 2.4.18 now. Altho the kernel 
> > does state that the card in question is supported, it does seem that either 
> > the pci/device-id has changed (or something) so the driver doesn't notice 
> > any cards??? 
> 
> Or IBM did something weird.

The in-kernel driver doesn't support the MiniPCI Prism2.5 wireless cards,
Use the linux-wlan-ng driver from www.linux-wlan.org.

I have almost exactly the same machine and have been running Linux on it for
months.  I've found that it's one of the few laptops on which virtually
everything is supported by linux.  The only thing unsupported is the Lucent
AMR modem. (And I suppose the security chip widgets, but i wouldn't use those
anyway).

				-- Gerald

