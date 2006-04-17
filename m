Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWDQQtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWDQQtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWDQQtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:49:12 -0400
Received: from earth.cora.nwra.com ([65.125.157.180]:56726 "EHLO
	earth.cora.nwra.com") by vger.kernel.org with ESMTP
	id S1751040AbWDQQtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:49:10 -0400
Message-ID: <4443C6FA.8020105@cora.nwra.com>
Date: Mon, 17 Apr 2006 10:48:58 -0600
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       "''Linux Kernel Mailing List ' '" <linux-kernel@vger.kernel.org>
Subject: Re: Problems (lockup/hang) with PCI-X slot on X5DPL motherboard
References: <e1pab8$22t$1@sea.gmane.org> <4807377b0604161104p5d6e32d9wbbb0184fc7a1b1a1@mail.gmail.com>
In-Reply-To: <4807377b0604161104p5d6e32d9wbbb0184fc7a1b1a1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Brandeburg wrote:
> 
> On these supermicro systems often they have jumpers to control the slots,
> are they set correctly?  Make sure that if your e1000 and slot six are
> sharing a bus, that neither of them is running at faster than PCI-X 100 MHz
> (check in ethtool -d ethX for e1000)
> 

Is there a way to find out bus speed for other slots/cards?

> so do the other slots work okay with your MV card?  The supermicro systems
> had tons and tons of ACPI table problems, so you may want to look closely at
> your dmesg and / or try acpi=off kernel boot line.
> 

In general, yes, though I just had a lockup with this new MV card in my 
test system.  Otherwise, my X5DPL-TGM with on MV card in slot 4 and one 
Intel GigE in slot 5 has been quite stable.

> If you think you're having a network problem posting to
> netdev@vger.kernel.org would be good.

I think it's only related to device/bus issues, not in general.


Thanks a lot for the reply.  I'll be trying to turn down the bus speed 
in the BIOS to see if that help.

-- 
Orion Poplawski
System Administrator                   303-415-9701 x222
Colorado Research Associates/NWRA      FAX: 303-415-9702
3380 Mitchell Lane, Boulder CO 80301   http://www.co-ra.com
