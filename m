Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUAaAja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbUAaAja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:39:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:60357 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264484AbUAaAj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:39:28 -0500
Date: Fri, 30 Jan 2004 16:23:18 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
Message-ID: <20040131002318.GB10465@kroah.com>
References: <10754263101353@kroah.com> <1075426310683@kroah.com> <20040130122658.D12182@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130122658.D12182@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 12:26:58PM +0000, Russell King wrote:
> On Thu, Jan 29, 2004 at 05:31:50PM -0800, Greg KH wrote:
> > ChangeSet 1.1523, 2004/01/29 17:13:13-08:00, kieran@mgpenguin.net
> > 
> > [PATCH] PCI: pci.ids update
> > 
> > - Replaces pci.ids with a snapshot from pciids.sf.net from 14 Jan 2004
> 
> However, it removes some IDs, eg:
> 
> > @@ -5505,11 +5871,6 @@
> >  		14f1 2004  Dynalink 56PMi
> >  	8234  RS8234 ATM SAR Controller [ServiceSAR Plus]
> >  14f2  MOBILITY Electronics
> > -	0120  EV1000 bridge
> > -	0121  EV1000 Parallel port
> > -	0122  EV1000 Serial port
> > -	0123  EV1000 Keyboard controller
> > -	0124  EV1000 Mouse controller
> >  14f3  BROADLOGIC
> >  14f4  TOKYO Electronic Industry CO Ltd
> >  14f5  SOPAC Ltd
> ...
> > @@ -6279,18 +6666,20 @@
> >  	103e  82801BD PRO/100 VM (MOB) Ethernet Controller
> >  	1040  536EP Data Fax Modem
> >  		16be 1040  V.9X DSP Data Fax Modem
> > -	1048  82597EX 10GbE Ethernet Controller
> > -		8086 a01f  PRO/10GbE LR Server Adapter
> > -		8086 a11f  PRO/10GbE LR Server Adapter
> > +	1043  PRO/Wireless LAN 2100 3B Mini PCI Adapter
> >  	1059  82551QM Ethernet Controller
> >  	1130  82815 815 Chipset Host Bridge and Memory Controller Hub

Oops, good catch.  I'll fix that in my next round of PCI patches.

thanks,

greg k-h
