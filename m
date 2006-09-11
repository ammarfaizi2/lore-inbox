Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWIKViu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWIKViu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWIKViu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:38:50 -0400
Received: from buick.jordet.net ([193.91.240.190]:38785 "EHLO buick.jordet.net")
	by vger.kernel.org with ESMTP id S964826AbWIKVit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:38:49 -0400
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Stian Jordet <liste@jordet.net>
To: sergio@sergiomb.no-ip.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Drake <dsd@gentoo.org>,
       akpm@osdl.org, torvalds@osdl.org, jeff@garzik.org, greg@kroah.com,
       cw@f00f.org, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       harmon@ksu.edu, len.brown@intel.com, vsu@altlinux.ru
In-Reply-To: <1158009834.3434.4.camel@localhost.portugal>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
	 <1157817836.6877.52.camel@localhost.localdomain>
	 <45033370.8040005@gentoo.org>
	 <1157848272.6877.108.camel@localhost.localdomain>
	 <450436F1.8070203@gentoo.org>
	 <1157906395.23085.18.camel@localhost.localdomain>
	 <4504621E.5090202@gentoo.org>
	 <1157917308.23085.26.camel@localhost.localdomain>
	 <1157916102.21295.9.camel@localhost.localdomain>
	 <1157988809.13889.5.camel@localhost.localdomain>
	 <1158005769.4748.0.camel@localhost.localdomain>
	 <1158009834.3434.4.camel@localhost.portugal>
Content-Type: text/plain; charset=utf-8
Date: Mon, 11 Sep 2006 23:38:18 +0200
Message-Id: <1158010698.23135.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On man, 2006-09-11 at 22:23 +0100, Sergio Monteiro Basto wrote:
> On Mon, 2006-09-11 at 22:16 +0200, Stian Jordet wrote:
> > On man, 2006-09-11 at 16:33 +0100, Sergio Monteiro Basto wrote:
> > > On Sun, 2006-09-10 at 21:21 +0200, Stian Jordet wrote:
> > > > On søn, 2006-09-10 at 20:41 +0100, Alan Cox wrote:
> > > > > Feel free to cc me the lspci data and partial diagnostics and I'll try
> > > > > and help too.
> > > > 
> > > > Attached is lspci -xxx and dmesg from 2.6.18-rc6.
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=2874 has some further
> > > > information about this (stupid) motherboard. Anything else you need?
> > > > 
> > > > If anyone can help me with this, I'll promise to send the hero some
> > > > boxes of Norwegian beer!
> > > > 
> > > > 
> > > Hi, this isn't the case of one USB with IO-APIC-level on legacy
> > > interrupts ? 
> > >  11:       5333       5326   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
> > > 
> > > if it is , was resolved with this [PATCH V3] VIA IRQ quirk behaviour change ? 
> > 
> > I have no idea what you mean here, but it's by no means fixed by that
> > patch, actually it just got worse (usb didn't work, but still got
> > interrupts from eth0 - and it still used irq 11)
> 
> What ?! Aren't we talk about this computer 
> http://lkml.org/lkml/2006/9/6/178
> and this 
> http://lkml.org/lkml/2006/9/7/220
> 
> if you don't get your device quirked we have add your hardware to the
> list ...

That last patch there, made my system work (but that bugzilla bug is
still a problem). So with that last patch, my system works just as good
as it always has, if that's what you're trying to ask :)

-Stian

