Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275240AbTHRXMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 19:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275243AbTHRXMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 19:12:06 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:29611 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S275240AbTHRXMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 19:12:02 -0400
Subject: Re: [SOLVED] RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
From: Stian Jordet <liste@jordet.nu>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1061247998.607.2.camel@chevrolet.hybel>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC6D@hdsmsx402.hd.intel.com>
	 <1061234596.594.3.camel@chevrolet.hybel>
	 <1061237161.614.1.camel@chevrolet.hybel>
	 <1061247998.607.2.camel@chevrolet.hybel>
Content-Type: text/plain
Message-Id: <1061248330.607.6.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 01:12:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 19.08.2003 kl. 01.06 skrev Stian Jordet:
> man, 18.08.2003 kl. 22.06 skrev Stian Jordet:
> > man, 18.08.2003 kl. 21.23 skrev Stian Jordet:
> > > man, 18.08.2003 kl. 19.53 skrev Brown, Len: 
> > > > Try booting with pci=noacpi, and if that doesn't work acpi=off
> > > > If either of those work, then file in bugzilla with component=ACPI and
> > > > assign it to len.brown@intel.com
> > > 
> > > It works when booting with noapic, but not with acpi=off nor pci=noapic.
> > > Does that mean I can't blame you for it?
> > 
> > Just to confuse myself (and whoever reading my mails). When I disabled
> > the second onboard ide-port, the kernel booted, but usb didn't work.
> > Absolutely no problem what so ever with -test3.
> 
> I had to enable CONFIG_ACPI_HT=y. But you must have screwed something
> up, since my P3's really, really don't have any Hyper Threading :) ACPI
> was already enabled, and from the help texts, there shouldn't be any
> difference with ACPI_HT then. Nevermind, I'm happy :)

Sorry for spamming, but when I think of it, I don't think acpi is
enabled at all without the CONFIG_ACPI_HT. Because my computer actually
uses to hang when enabling io-apic without acpi support enabled (in
other words, my pc is useless without acpi enabled).

Once again, sorry for flooding.

Best regards,
Stian

