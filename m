Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266869AbUBEVPu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266868AbUBEVPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:15:49 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:25751 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S266867AbUBEVPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:15:40 -0500
Subject: Re: [2.6 patch] remove USB_SCANNER
From: Stian Jordet <liste@jordet.nu>
To: Leopold Gouverneur <gvlp@pi.be>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040205202417.GA3183@gouv>
References: <20040126215036.GA6906@kroah.com>
	 <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de>
	 <slrnc1l72v.9m.noll@localhost.mathematik.tu-darmstadt.de>
	 <20040130230633.GZ6577@stop.crashing.org> <20040202214326.GA574@kroah.com>
	 <20040205003136.GQ26093@fs.tum.de> <20040205011423.GA6092@kroah.com>
	 <1076001658.3225.101.camel@moria.arnor.net>
	 <20040205173032.GI12546@kroah.com>  <20040205202417.GA3183@gouv>
Content-Type: text/plain
Message-Id: <1076015729.662.2.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 22:15:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 05.02.2004 kl. 21.24 skrev Leopold Gouverneur:
> On Thu, Feb 05, 2004 at 09:30:32AM -0800, Greg KH wrote:
> > On Thu, Feb 05, 2004 at 09:20:58AM -0800, Azog wrote:
> > > 
> > > So, what are you all using / recommending for user space configuration
> > > and control of a USB scanner under 2.6? 
> > 
> > xsane should work just fine, using libusb/usbfs.
> > 
> not for me :-( it works fine with the "broken" kernel module)
> sane-find-scanner find it:
> found USB scanner (vendor=0x04b8 [EPSON],
> product=0x011b [EPSON Scanner]) at libusb:001:002
> but scaniimage -L don't.
> With the kernel module loaded i get:
> device `epkowa:/dev/usb/scanner0' is a Epson GT-9300 flatbed scanner

You seem to be using the epkowa backend, which don't support libusb...
My guess, atleast...

Best regards,
Stian

