Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVILWCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVILWCZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVILWCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:02:25 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:36879 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S932283AbVILWCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:02:24 -0400
Message-ID: <4325FAE7.6030501@etpmod.phys.tue.nl>
Date: Tue, 13 Sep 2005 00:02:15 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [1/3] Add 4GB DMA32 zone
References: <43246267.mailL4R11PXCB@suse.de>	 <1126520900.30449.48.camel@localhost.localdomain>	 <200509121242.20910.ak@suse.de> <1126524787.30449.56.camel@localhost.localdomain> <4325C67C.7070809@pobox.com>
In-Reply-To: <4325C67C.7070809@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Alan Cox wrote:
> 
>> On Llu, 2005-09-12 at 12:42 +0200, Andi Kleen wrote:
>>
>>> Yes I know some soundcards have similar limits, but for all
>>> these we still have GFP_DMA and they always have been quite happy
>>> with that.
>>
>>
>>
>> No current shipping card, also those that need it typically need small
>> amounts (they'll live with 8K)
> 
> 
> 
> [...just because I love broken hardware, not because I've been following 
> this thread...]
> 
> RealTek's ALS4000 PCI card is a SoundBlaster ISA clone chip glued onto a 
> PCI bus.  Its DMA mask is 24-bit, IIRC.  :)
> 
>     Jeff
> 
Yep. You're absolutely right about the card. Google doesn't find anyone 
still selling them, though... Apart from ebay ;-)

(Wrote the driver and got rid of the d*mn thing 2 weeks later...)

Cheers,
Bart
