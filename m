Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVADAdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVADAdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVADAaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:30:05 -0500
Received: from jubilee.implode.net ([64.40.108.188]:21378 "EHLO
	jubilee.implode.net") by vger.kernel.org with ESMTP id S262044AbVADA1y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:27:54 -0500
Date: Mon, 3 Jan 2005 16:27:49 -0800
From: John Wong <kernel@implode.net>
To: Joel Cant <lkml@linuxmod.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise IDE DMA issue
Message-ID: <20050104002749.GA10025@gambit.implode.net>
References: <20050102173704.GA14056@gambit.implode.net> <41D9885B.9090304@pobox.com> <20050103215250.GA9409@gambit.implode.net> <41D9C5C2.5010606@linuxmod.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D9C5C2.5010606@linuxmod.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 10:22:58PM +0000, Joel Cant wrote:
> John Wong wrote:
> 
> >Latest 1.009 BIOS flashed last night.  I'll try out some BIOS settings, 
> >but the settings work fine with Windows XP.  That's why I think it could 
> >be something with the driver.  This is with the PDC202XX_NEW on kernel 
> >2.6.10  The DMA timeout happens sporadically, but as of yet, has yet to
> >reoccur.  The change from 1.008 to 1.009 mentions nothing about the
> >Promide IDE.  
> >
> >John
> >
> >On Mon, Jan 03, 2005 at 01:00:59PM -0500, Jeff Garzik wrote:
> > 
> >
> >>John Wong wrote:
> >>   
> >>
> >>>I recently upgraded fron a nVidia nForce2 MCP-T based A7NX-DX
> >>>motherboard to an A8V DX, Via K8T800 Pro.  Now occassionally, I get 
> >>>DMA issues on a drive attached to a Promise 133 TX2 controller (20269).
> >>>     
> >>>
> >>I would try fiddling with BIOS settings, and make sure you have the 
> >>latest BIOS.
> >>
> >>	Jeff
> >>
> >>
> >>
> >>
> >>   
> >>
> Sounds simlar to the problems i'm having with the channels resetting 
> under heavy load, and then fudging DMA, and i'm not the only one havign 
> these issues, seems its a common problem with these cards, not sure if 
> theres been some slight changes in the chip itself or wether there is a 
> fault with the kernel driver, as you say, it seems that the problem does 
> not occour under windows.
> 
> Joel

Before my motherboard upgrade, the Promise 133TX2 used to be a 100TX2.  
I didn't have this problem then, but then, I also had more PCI buses 
then according to the outputs of lspci.

The DMA problem does only appear to happen with me under load as well,
torrenting to one drive, and probably updatedb on another.

John
