Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbUA0Ttt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265595AbUA0Ttt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:49:49 -0500
Received: from 81-178-248-213.dsl.pipex.com ([81.178.248.213]:15123 "EHLO
	gimp.puzlebox") by vger.kernel.org with ESMTP id S265776AbUA0Trg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:47:36 -0500
Subject: Re: (Wrong ID) USB Crontroller
From: Robert Reardon <rreardon@dsl.pipex.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040126233939.GB7535@kroah.com>
References: <1075147348.7156.12.camel@mordor>
	 <20040126233939.GB7535@kroah.com>
Content-Type: text/plain
Message-Id: <1075233053.6778.4.camel@mordor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 19:50:53 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That seems to have fixed part of the problem.

It still wasn't working afterwards though - I couldn't access any
USB devices properly, so I tried booting with noapic and noacpi on -
it seems to have fixed everything, so I'll stick to using them....


Thanks
Rob
---
Robert Reardon
<RReardon@dsl.pipex.com>

On Mon, 2004-01-26 at 23:39, Greg KH wrote:
> On Mon, Jan 26, 2004 at 08:02:28PM +0000, Robert Reardon wrote:
> > Hi all,
> > 
> > I've been trying to get USB working with the 2.6 and keep getting 
> > the attached error messages. The kernel appears (to me at least)
> > to detect the USB controller correctly on boot, but it still doesn't
> > want to work. This is my first post to the list, so please be gentle
> > :-).
> > 
> > The motherboard is a Supermicro 370DDE, currently running
> > kernel-2.6.2-rc1-mm3. I've tried to attached any relevant information
> > but I'm happy to provide more if it's needed.
> > 
> > cat /proc/version reports:
> > 
> > Linux version 2.6.2-rc1-mm3 (root@mordor) (gcc version 3.3.2 20031218
> > (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #2 SMP Sun Jan 25 21:16:13 GMT
> > 2004
> > 
> > Anyone got any ideas?
> 
> Yeah, get rid of your usbmodules binary.  It's not needed and is causing
> the problem.
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

