Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVA2BOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVA2BOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 20:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVA2BOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 20:14:24 -0500
Received: from ernie.virtualdave.com ([198.216.116.246]:19979 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S262831AbVA2BOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 20:14:17 -0500
Date: Fri, 28 Jan 2005 19:13:59 -0600 (CST)
From: David Sims <dpsims@virtualdave.com>
To: Paulo Marques <pmarques@grupopie.com>
cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: I need a hardware wizard... I have been beating my head on the
 wall..
In-Reply-To: <41FAA5F7.4000202@grupopie.com>
Message-ID: <Pine.LNX.4.21.0501281912460.2599-100000@ernie.virtualdave.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paulo!

  Your patch generated the following:

Jan 28 19:11:51 linux kernel: vsc_sata int status: 00000083
Jan 28 19:11:51 linux last message repeated 19 times
Jan 28 19:11:51 linux kernel: irq 7: nobody cared!
Jan 28 19:11:51 linux kernel:  [<c0128972>] __report_bad_irq+0x22/0x90
Jan 28 19:11:51 linux kernel:  [<c0128a68>] note_interrupt+0x58/0x90
Jan 28 19:11:51 linux kernel:  [<c01285f8>] __do_IRQ+0xd8/0xe0
.
.
.
.


Thanks for helping me... I hope this is useful info....

Dave Sims
************************************************************************
On Fri, 28 Jan 2005, Paulo Marques wrote:

> David Sims wrote:
> > On Thu, 27 Jan 2005, Jeff Garzik wrote:
> >>David Sims wrote:
> >>
> >>>[...]
> >>>  You can insert the module in a running kernel and after barking as
> >>>follows (once for each disk attached) it runs just fine.
> >>
> >>Basically nobody has ever had hardware to test sata_vsc with that 
> >>hardware.  We should probably remove the PCI ID until an engineer can 
> >>fix it...
> > 
> > Hi again,
> > 
> >   I am willing to make this hardware available to any engineer that wants
> > to help me solve this problem.... and I will do whatever I can to make it
> > an easy job... Please help me...
> 
> Well, I don't consider myself a hardware wizard, but at least I'm an 
> engineer, so I decided to give it a go :)
> 
> It seems that the driver is not acknowledging the interrupt from the 
> controller. It would be nice to know what kind of interrupt is 
> triggering this.
> 
> Could you run the attached patch and show the output from dmesg?
> 
> -- 
> Paulo Marques - www.grupopie.com
> 
> All that is necessary for the triumph of evil is that good men do nothing.
> Edmund Burke (1729 - 1797)
> 

