Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270153AbTGMHuK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 03:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270154AbTGMHuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 03:50:10 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:44436 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S270153AbTGMHuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 03:50:05 -0400
Date: Sun, 13 Jul 2003 10:04:15 +0200
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with usb-ohci on 2.4.22-preX
Message-ID: <20030713080415.GA7082@puettmann.net>
References: <20030712141431.GA3240@puettmann.net> <20030713042131.GE2695@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713042131.GE2695@kroah.com>
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19bbqB-0001rS-00*5slOWAd5cpQ* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 09:21:31PM -0700, Greg KH wrote:
 > 
> > i try to install linux on my new motherboard EPOX 8RDA3+ 
> > with nvidia nforce2 chipset.
> > 
> > If I try to attached some usb devices ( usb memory stick ) I got this
> > errors ( 2.4.22-pre5 pre2..): 
> 
> Do any other USB devices work?

soory no no other usb device here. I mean that the internal CF/SD/MMC
reader runs with usb-storage too.

> Can you boot with/without acpi (the opposite of whatever you just did.)

I disable ACPI in bios and boot with noacpi I get the message:

spurious 8259A Interrupt 7

But usb storage seems to work ( the usb-storage found the internal
CF/SD/MMC card reader.

But then the System is frozen. No reaktion from system on attaching the
usb stick or making any keypress. SYSREQ does not work. 

Nothing in the logfiles.

> How about booting with noapic?

I have try this but it will not do :

First try :

booting with noapic :

There were much CPU(0) APIC error's so the System was unusable.

APIC error on CPU0: 40(40)


After disable apic in bios and boot with noapic ext3 can not mount my
filesystem and there is an oops. The oops was not logged so I can't make
an backtrace.

So it seems that the usb-storage problem seems an acpi problem but
without acpi the systems is unusable.

I hope this will help you.


            thx for help

                Ruben


-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
