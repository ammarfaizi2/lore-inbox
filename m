Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUBERb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUBERb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:31:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:30668 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266496AbUBERbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:31:53 -0500
Date: Thu, 5 Feb 2004 09:30:32 -0800
From: Greg KH <greg@kroah.com>
To: Azog <slashmail@arnor.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, Tom Rini <trini@kernel.crashing.org>,
       Andre Noll <noll@mathematik.tu-darmstadt.de>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove USB_SCANNER
Message-ID: <20040205173032.GI12546@kroah.com>
References: <20040126215036.GA6906@kroah.com> <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de> <slrnc1l72v.9m.noll@localhost.mathematik.tu-darmstadt.de> <20040130230633.GZ6577@stop.crashing.org> <20040202214326.GA574@kroah.com> <20040205003136.GQ26093@fs.tum.de> <20040205011423.GA6092@kroah.com> <1076001658.3225.101.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076001658.3225.101.camel@moria.arnor.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 09:20:58AM -0800, Azog wrote:
> 
> So, what are you all using / recommending for user space configuration
> and control of a USB scanner under 2.6? 

xsane should work just fine, using libusb/usbfs.

As this driver is no longer needed, and the driver is broken and no one
has stepped up to fix it for over a month now, I'm removing it from the
kernel tree.

thanks,

greg k-h
