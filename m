Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVI0GJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVI0GJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 02:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVI0GJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 02:09:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:16293 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964818AbVI0GJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 02:09:40 -0400
Date: Tue, 27 Sep 2005 08:09:36 +0200
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, Stian Jordet <liste@jordet.nu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bogus VIA IRQ fixup in drivers/pci/quirks.c
Message-ID: <20050927060936.GA19880@suse.de>
References: <20050926184451.GB11752@suse.de> <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Sep 26, Linus Torvalds wrote:

> 
> 
> On Mon, 26 Sep 2005, Olaf Hering wrote:
> > 
> > Why is the irq changed from 24 to 0, and why does uhci use irq 24
> > anyway? I dont have the /proc/interrupts output from this box, maybe no
> > interrupt is handled for the controller? None of the attached usb
> > devices is recognized with 2.6.13.
> 
> Did that USB controller use to work in older kernels?

quirk_via_irqpic worked the same, so I guess no.
I will let him try older kernels, and your suggested change.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
