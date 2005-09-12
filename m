Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVILSTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVILSTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVILSTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:19:00 -0400
Received: from mail.dvmed.net ([216.237.124.58]:55455 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750867AbVILSTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:19:00 -0400
Message-ID: <4325C67C.7070809@pobox.com>
Date: Mon, 12 Sep 2005 14:18:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [1/3] Add 4GB DMA32 zone
References: <43246267.mailL4R11PXCB@suse.de>	 <1126520900.30449.48.camel@localhost.localdomain>	 <200509121242.20910.ak@suse.de> <1126524787.30449.56.camel@localhost.localdomain>
In-Reply-To: <1126524787.30449.56.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2005-09-12 at 12:42 +0200, Andi Kleen wrote:
>>Yes I know some soundcards have similar limits, but for all
>>these we still have GFP_DMA and they always have been quite happy
>>with that.
> 
> 
> No current shipping card, also those that need it typically need small
> amounts (they'll live with 8K)


[...just because I love broken hardware, not because I've been following 
this thread...]

RealTek's ALS4000 PCI card is a SoundBlaster ISA clone chip glued onto a 
PCI bus.  Its DMA mask is 24-bit, IIRC.  :)

	Jeff


