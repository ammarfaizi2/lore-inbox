Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUBERvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266530AbUBERvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:51:46 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:35733 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S266527AbUBERvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:51:42 -0500
Subject: Re: [2.6 patch] remove USB_SCANNER
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: Azog <slashmail@arnor.net>, Adrian Bunk <bunk@fs.tum.de>,
       Tom Rini <trini@kernel.crashing.org>,
       Andre Noll <noll@mathematik.tu-darmstadt.de>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040205173032.GI12546@kroah.com>
References: <20040126215036.GA6906@kroah.com>
	 <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de>
	 <slrnc1l72v.9m.noll@localhost.mathematik.tu-darmstadt.de>
	 <20040130230633.GZ6577@stop.crashing.org> <20040202214326.GA574@kroah.com>
	 <20040205003136.GQ26093@fs.tum.de> <20040205011423.GA6092@kroah.com>
	 <1076001658.3225.101.camel@moria.arnor.net>
	 <20040205173032.GI12546@kroah.com>
Content-Type: text/plain
Message-Id: <1076003405.9101.2.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 18:50:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 05.02.2004 kl. 18.30 skrev Greg KH:
> On Thu, Feb 05, 2004 at 09:20:58AM -0800, Azog wrote:
> > 
> > So, what are you all using / recommending for user space configuration
> > and control of a USB scanner under 2.6? 
> 
> xsane should work just fine, using libusb/usbfs.
> 
> As this driver is no longer needed, and the driver is broken and no one
> has stepped up to fix it for over a month now, I'm removing it from the
> kernel tree.


I know it is broken, and obsoleted. But for those of us not using
hotplug scripts, it's quite a pity that you have to manually chmod the
files in /proc/bus/usb to be able to use a device with libusb as a
normal user. Just want to let people having trouble know that.

Best regards,
Stian

