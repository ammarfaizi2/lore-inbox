Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVHMWbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVHMWbn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 18:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVHMWbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 18:31:43 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:61703 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S932380AbVHMWbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 18:31:42 -0400
Message-ID: <42FE74CD.4040108@superbug.demon.co.uk>
Date: Sat, 13 Aug 2005 23:31:41 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug in pcmcia-core
References: <42B1FF2A.2080608@superbug.demon.co.uk> <20050711210834.GA4898@neo.rr.com>
In-Reply-To: <20050711210834.GA4898@neo.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:
> On Thu, Jun 16, 2005 at 11:37:30PM +0100, James Courtier-Dutton wrote:
> 
>>Hi,
>>
>>I have tried conacting the mailing list for the PCMCIA subsystem in
>>Linux, but no-one seems to respond.
>>
>>PCMCIA SUBSYSTEM
>>L:      http://lists.infradead.org/mailman/listinfo/linux-pcmcia
>>S:      Unmaintained
>>
>>I am trying to write a Linux ALSA driver for the Creative Audigy 2 NX
>>Notebook PCMCIA card.
>>This is a cardbus card, that uses ioports.
>>When it is inserted into the laptop, the entry appears in "lspci -vv "
>>showing ioports used by the card.
>>As soon as my driver uses "outb()" to anything in the address range
>>shown in "lspci -vv" , the PC hangs.
>>
>>I can only conclude from this that ioport resources are not being
>>allocated correctly to the PCMCIA card.
> 
> 
> It's possible.
> 
> 
>>Can anybody help me track this down. If someone could tell me which
>>PCMCIA and PCI registers should be set for it to work, I could then find
>>out which pcmcia registers have not been set correctly, and fix the bug.
>>
>>It seems that the PCMCIA specification is not open and free, so I cannot
>>refer to it in order to fix this myself.
>>
>>Can anybody help me?
>>
>>James
> 
> 
> Please provide more information.  /proc/ioports, lspci -vv, the ranges
> assigned to your driver, and your driver code if it's available.  I'll try
> to look into the problem.
> 
> Thanks,
> Adam
> 
> 

Please see bug#5057. I have placed all the information there.

http://bugzilla.kernel.org/show_bug.cgi?id=5057

James
