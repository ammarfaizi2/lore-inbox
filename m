Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275124AbTHLJCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 05:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275126AbTHLJCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 05:02:03 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:37815 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S275124AbTHLJCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 05:02:00 -0400
Date: Tue, 12 Aug 2003 11:01:57 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>, Robert Love <rml@tech9.net>,
       CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
In-Reply-To: <20030812053826.GA1488@kroah.com>
Message-ID: <Pine.LNX.4.51.0308121100200.17669@dns.toxicfilms.tv>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost>
 <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
 <20030812053826.GA1488@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
> > 	{
> > 		.vendor		= PCI_VENDOR_ID_BROADCOM,
> > 		.device		= PCI_DEVICE_ID_TIGON3_5700,
> > 		.subvendor	= PCI_ANY_ID,
> > 		.subdevice	= PCI_ANY_ID,
> > 		.class		= 0,
> > 		.class_mask	= 0,
> > 		.driver_data	= 0,
> > 	},
>
> I sure would.  Oh, you can drop the .class, .class_mask, and
> .driver_data lines, and then it even looks cleaner.
Just a quick question. if we drop these, will they _always_
be initialised 0 ? I have made a test to see, and it seemed as though,
but I would like to be 100% sure.

Regards,
Maciej

