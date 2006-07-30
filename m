Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWG3KsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWG3KsT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWG3KsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:48:19 -0400
Received: from zakalwe.fi ([80.83.5.154]:5578 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S932254AbWG3KsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:48:18 -0400
Date: Sun, 30 Jul 2006 13:48:14 +0300
From: Heikki Orsila <shd@zakalwe.fi>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>, linux-kernel@vger.kernel.org
Subject: Re: Still broken sata (VIA) on Asus A8V (kernel 2.6.14+) with irqbalance
Message-ID: <20060730104814.GB12840@zakalwe.fi>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <20060728121210.GA8375@tentacle.sectorb.msk.ru> <20060728200250.GA12840@zakalwe.fi> <1154146089.10955.109.camel@bastov.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1154146089.10955.109.camel@bastov.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 05:08:09AM +0100, Sergio Monteiro Basto wrote:
> cat DMESG | grep -i fixup
> PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 0
> PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 3
> PCI: VIA IRQ fixup for 0000:00:10.1, from 11 to 3
> PCI: VIA IRQ fixup for 0000:00:10.2, from 10 to 3
> 
> with IO-APIC working , you could try patches to not "VIA IRQ quirk
> fixup", but could not be the main problem. 
> 
> I have a very experimental patch
> http://lkml.org/lkml/2006/7/28/99
> 
> 
> Which you can just apply and make bzImage, install and reboot  , don't
> need to recompile all over again.

Applied, tried and it worked! I couldn't reproduce the error in 30 
minutes of stress testing. With a buggy kernel it only took a matter of 
minutes to reproduce it. Thank you for your effort.

Heikki Orsila
