Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUBEB1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUBEB1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:27:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:27101 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264365AbUBEB04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 20:26:56 -0500
Date: Wed, 4 Feb 2004 17:14:23 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Andre Noll <noll@mathematik.tu-darmstadt.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove USB_SCANNER
Message-ID: <20040205011423.GA6092@kroah.com>
References: <20040126215036.GA6906@kroah.com> <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de> <slrnc1l72v.9m.noll@localhost.mathematik.tu-darmstadt.de> <20040130230633.GZ6577@stop.crashing.org> <20040202214326.GA574@kroah.com> <20040205003136.GQ26093@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205003136.GQ26093@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 01:31:36AM +0100, Adrian Bunk wrote:
> On Mon, Feb 02, 2004 at 01:43:26PM -0800, Greg KH wrote:
> > On Fri, Jan 30, 2004 at 04:06:33PM -0700, Tom Rini wrote:
> > > 
> > > Greg, I think this now makes 2 distinct bugs in the scanner kernel
> > > driver.  Maybe it should be protected with a BROKEN:
> > 
> > Very good idea, I've applied this patch.
> 
> USB_SCANNER is obsolete, and it's now marked as BROKEN.
> 
> I there a good reason to keep it in the kernel?
> 
> If not, please apply the patch below plus do a
>   rm drivers/usb/image/scanner.{c,h}

I've applied this patch, and removed the driver from the kernel.

thanks,

greg k-h
