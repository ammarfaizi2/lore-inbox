Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbRCPOv4>; Fri, 16 Mar 2001 09:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130512AbRCPOvq>; Fri, 16 Mar 2001 09:51:46 -0500
Received: from cmailg6.svr.pol.co.uk ([195.92.195.176]:5172 "EHLO
	cmailg6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130497AbRCPOvg>; Fri, 16 Mar 2001 09:51:36 -0500
Date: Fri, 16 Mar 2001 14:53:30 +0000 (GMT)
From: Will Newton <will@misconception.org.uk>
X-X-Sender: <will@dogfox.localdomain>
To: Tim Waugh <twaugh@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA audio and parport in 2.4.2
In-Reply-To: <20010316105310.G1131@redhat.com>
Message-ID: <Pine.LNX.4.33.0103161450000.1403-100000@dogfox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Tim Waugh wrote:

> > I don't know why it prints it twice.
>
> Looks like the module is getting loaded, then unloaded, then loaded
> again.  Perhaps because of module autocleaning?

Could be, but the final lp0 line is only printed once:
lp0: using parport0 (interrupt-driven).

> > I also get spurios interrupts on 7 when the parport is not loaded.
>
> I'm not sure what you mean here.  Can you be more specific?

messages.1:Mar  8 22:49:00 dogfox kernel: spurious 8259A interrupt: IRQ7.


