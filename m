Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271885AbTGYBMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 21:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271886AbTGYBMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 21:12:42 -0400
Received: from quechua.inka.de ([193.197.184.2]:61131 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S271885AbTGYBMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 21:12:39 -0400
From: Bernd Eckenfels <ecki-lkm@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: why the current kernel config menu layout is a mess
In-Reply-To: <Pine.LNX.4.53.0307242020140.23200@localhost.localdomain>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19frN3-00025I-00@calista.inka.de>
Date: Fri, 25 Jul 2003 03:27:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0307242020140.23200@localhost.localdomain> you wrote:
>  the suboption "Support for paging of anonymous memory".
>  might this not go under "Processor type and features",
>  where there are other memory-related options?

well, i think it is architecture independend

> "Power management options"

>    in addition, though, i'm not sure "CPU frequency scaling"
>  belongs here.  it might just as well fit under "Processor type
>  and features", although that may be nit-picking.

Power Management and System Configuration

could be a better heading

> "Bus options (PCI, PCMCIA, EIAS, MCA, ISA)
> 
>    if this is for busses, why aren't the other busses here as
>  well?  shouldn't USB be here as well?

I think this is concernd with mainboard's main bus only (i2c is an aux
mainboard bus and usb, firewire are device busses)

> "Character devices" (jumping ahead just a bit)
> "Block devices"
> "Multiple devices (RAID and LVM)"

Well, if we go along the line of using unix naming, then MD can be moved ot
block devices, not to filesystems.

> "Fusion MPT"
> 
>    hard to believe this deserves its own top-level entry,
>  but i could be wrong.

yes, very strange.

> "IEEE 1394"
>    it's a bus, right?  move it there.

i would suggest to have the section separated into system internal stuff
(cpu, mainboard bus, management bus, memory, apci, ..) and external
interfaces (usb, firewire, legacy/serial/, legacy/parallel, legacy/ps2,
...)

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
