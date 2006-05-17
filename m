Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWEQSrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWEQSrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWEQSrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:47:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:981 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750926AbWEQSrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:47:13 -0400
Date: Wed, 17 May 2006 20:47:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: Joerg Pommnitz <pommnitz@yahoo.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wiretapping Linux?
In-Reply-To: <446B3082.1000200@argo.co.il>
Message-ID: <Pine.LNX.4.61.0605172045390.5095@yvahk01.tjqt.qr>
References: <20060517132503.79272.qmail@web51410.mail.yahoo.com>
 <446B3082.1000200@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > A pci device can read system RAM and other memory-mapped PCI devices
>> > (such as display framebuffers) using DMA. In addition, a pci (but not
>> > pci-express) device can snoop on pci bus traffic to other devices.
>> > Typically, however, hard drive controllers will be integrated into the
>> > chipset so the data is not on the bus.
>> 
>> Thanks for providing this information. This makes the binary firmware
>> required for peripherals even more interesting for security conscious
>> people.
>
> Note that some machines have IOMMUs so it may be possible to prevent a device
> from reading main memory, perhaps at a performance cost.
>
> My AMD machine disables the IOMMU on startup.
>
> If you don't trust your hardware there are only two solutions: keep it off the
> net or keep it off.

It gets even more complex with remote management solutions, ranging from 
simple PCI boards that can reset the machine to fully-integrated [like 
Sun's RSC] processors that can poke anything.


Jan Engelhardt
-- 
