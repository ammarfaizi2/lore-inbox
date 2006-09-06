Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWIFSG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWIFSG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWIFSG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:06:27 -0400
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:53967 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1751266AbWIFSGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:06:25 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: Still broken sata (VIA) on Asus A8V (kernel 2.6.14+) with
	irqbalance
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Heikki Orsila <shd@zakalwe.fi>
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <20060730104814.GB12840@zakalwe.fi>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru>
	 <20060728121210.GA8375@tentacle.sectorb.msk.ru>
	 <20060728200250.GA12840@zakalwe.fi>
	 <1154146089.10955.109.camel@bastov.localdomain>
	 <20060730104814.GB12840@zakalwe.fi>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 19:06:30 +0100
Message-Id: <1157565990.32029.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, a little late, 

Heikki Orsila, can you send dmesg from working kernel
and /proc/interrupts too ?
and if you have a dmesg from a not working kernel can you send too ?

Vladimir B. Savkin , have you try the patch if so , please send the
results 

Thanks,

On Sun, 2006-07-30 at 13:48 +0300, Heikki Orsila wrote:
> On Sat, Jul 29, 2006 at 05:08:09AM +0100, Sergio Monteiro Basto wrote:
> > cat DMESG | grep -i fixup
> > PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 0
> > PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 3
> > PCI: VIA IRQ fixup for 0000:00:10.1, from 11 to 3
> > PCI: VIA IRQ fixup for 0000:00:10.2, from 10 to 3
> > 
> > with IO-APIC working , you could try patches to not "VIA IRQ quirk
> > fixup", but could not be the main problem. 
> > 
> > I have a very experimental patch
> > http://lkml.org/lkml/2006/7/28/99
> > 
> > 
> > Which you can just apply and make bzImage, install and reboot  , don't
> > need to recompile all over again.
> 
> Applied, tried and it worked! I couldn't reproduce the error in 30 
> minutes of stress testing. With a buggy kernel it only took a matter of 
> minutes to reproduce it. Thank you for your effort.
> 
> Heikki Orsila

