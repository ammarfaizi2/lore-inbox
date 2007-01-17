Return-Path: <linux-kernel-owner+w=401wt.eu-S1751073AbXAQVvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXAQVvj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbXAQVvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:51:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:40145 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbXAQVvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:51:38 -0500
Date: Wed, 17 Jan 2007 13:50:54 -0800
From: Greg KH <greg@kroah.com>
To: taps@go2.pl, Bernhard Kaindl <bk@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.19.1 - Please report the result to linux-kernel to fix this permanently
Message-ID: <20070117215054.GA10340@kroah.com>
References: <4bedf1a2.66c6cf88.45ae491d.26f3c@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bedf1a2.66c6cf88.45ae491d.26f3c@o2.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 05:04:45PM +0100, =?UTF-8?Q? taps ?= wrote:
> Hello,
> 
> I got this text when I boot my linux :
> 
> --cut--
> 
> PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
> PCI quirk: region 1180-11bf claimed by ICH4 GPIO
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> PCI: Transparent bridge - 0000:00:1e.0
> PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
> Please report the result to linux-kernel to fix this permanently
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs *6)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 11) *10
> 
> --cut--
> 
> Kernel 2.6.19.1 without any patch.
> Debian 4.0 Etch.
> Everything works on laptop Toshiba satellite pro L10
> Do you need any more information ?

Bernhard, is there any way we can stop printing out this message?  It
really doesn't seem to be necessary.

thanks,

greg k-h
