Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbVI0VxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbVI0VxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbVI0VxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:53:18 -0400
Received: from [87.248.7.17] ([87.248.7.17]:16134 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965175AbVI0VxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:53:17 -0400
Message-ID: <1127857959.4339bf2705c0a@webmail.jordet.nu>
Date: Tue, 27 Sep 2005 23:52:39 +0200
From: Stian Jordet <liste@jordet.nu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olaf Hering <olh@suse.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bogus VIA IRQ fixup in drivers/pci/quirks.c
References: <20050926184451.GB11752@suse.de> <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org> <1127831274.433956ea35992@webmail.jordet.nu> <Pine.LNX.4.58.0509270734340.3308@g5.osdl.org> <1127855989.4339b77537987@webmail.jordet.nu> <Pine.LNX.4.58.0509271432490.3308@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509271432490.3308@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 217.8.143.72
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sitat Linus Torvalds <torvalds@osdl.org>:

>
>
> On Tue, 27 Sep 2005, Stian Jordet wrote:
> >
> > No dice. My irq's beyond 15 are changed. What used to be 19 became 17, 18
> became
> > 16, 17 became 18 and 16 became 19. The others are normal, and while looking
> at
> > dmesg, the fixup is still happening. While it boots, and at first glance
> seems
> > to work, it hangs hard when I try to use usb. At least the bluetooth
> dongle,
> > haven't tried with anything else, but I suppose that'd do the same.
>
Sorry! I was looking at the wrong dmesg. *stupid*. Really sorry about that. It
still hangs hard when I try to use usb, but I'll double check that it worked
before the patch before I complain more :P

Once again, sorry. And thank you :)

-Stian




