Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265242AbUEMXCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbUEMXCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbUEMXCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:02:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:32926 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265242AbUEMXBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:01:52 -0400
Date: Thu, 13 May 2004 15:40:35 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml@lpbproduction.scom.kroah.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040513224035.GB20521@kroah.com>
References: <20040513032736.40651f8e.akpm@osdl.org> <200405130514.44462.lkml@lpbproductions.com> <20040513112447.5b8abca0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513112447.5b8abca0.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 11:24:47AM -0700, Andrew Morton wrote:
> "Matt H." <lkml@lpbproductions.com> wrote:
> >
> > Just attempted to compile 2.6.6-mm2 and got this error
> > 
> >    CC [M]  drivers/usb/core/driverfs.o
> >    CC [M]  drivers/usb/core/hcd-pci.o
> >    LD [M]  drivers/usb/core/usbcore.o
> >    LD      drivers/usb/host/built-in.o
> >    CC [M]  drivers/usb/host/ehci-hcd.o
> >    CC [M]  drivers/usb/host/ohci-hcd.o
> >  In file included from drivers/usb/host/ohci-hcd.c:129:
> >  drivers/usb/host/ohci-hub.c: In function `ohci_rh_resume':
> >  drivers/usb/host/ohci-hub.c:313: error: `hcd' undeclared (first use in this 
> >  function)
> 
> hm, not sure what's happened there...

Oops, didn't check with CONFIG_PM disabled, sorry.

Applied, thanks.

greg k-h
