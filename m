Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290755AbSBTBj3>; Tue, 19 Feb 2002 20:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290746AbSBTBjS>; Tue, 19 Feb 2002 20:39:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23045 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290753AbSBTBjO>; Tue, 19 Feb 2002 20:39:14 -0500
Subject: Re: Info on Intel Plumas E7500 support
To: whampton@staffnet.com (Wade Hampton)
Date: Wed, 20 Feb 2002 01:53:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3C72F651.7544845B@staffnet.com> from "Wade Hampton" at Feb 19, 2002 08:05:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dLws-0002C2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A customer of mine asked if RedHat 6.2 supported
> the new dual xeon e7500 chip set?  After a search
> which resulted in very few hits, I was wondering 
> if any Linux kernel supports this? 

No idea. In general intel chipsets are fairly standards compliant and
forward/backward compatible. That should mean the IDE will either just
work as full UDMA or need a new PCI ident. It might want a new IRQ router
if you use it with stuff like cardbus or hotplug.

> Also anyone know if support for it will be backported
> to the 2.2 series?

Unlikely
