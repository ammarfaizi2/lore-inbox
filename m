Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWHBRpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWHBRpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWHBRpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:45:47 -0400
Received: from charlieb.ott.istop.com ([66.11.174.133]:12975 "HELO
	charlieb.ott.istop.com") by vger.kernel.org with SMTP
	id S932112AbWHBRpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:45:46 -0400
Date: Wed, 2 Aug 2006 13:45:44 -0400 (EDT)
From: Charlie Brady <charlieb@budge.apana.org.au>
X-X-Sender: charlieb@e-smith.charlieb.ott.istop.com
To: Auke Kok <auke-jan.h.kok@intel.com>
cc: Charlie Brady <charlieb@budge.apana.org.au>,
       NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       molle.bestefich@gmail.com
Subject: Re: [bug] e100: checksum mismatch on 82551ER rev10
In-Reply-To: <44D0D7CA.2060001@intel.com>
Message-ID: <Pine.LNX.4.61.0608021338490.809@e-smith.charlieb.ott.istop.com>
References: <Pine.LNX.4.61.0607311653360.24450@e-smith.charlieb.ott.istop.com>
 <44D0D7CA.2060001@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Aug 2006, Auke Kok wrote:

> [cc-ing netdev]
> [adding original thread authors back, please do not strip CC]

[There were no Cc's visible in the lkml archive I used as source of my 
quotes.]

> Charlie Brady wrote:
>> 
>> Let's assume that these things are all true, and the NIC currently does 
>> not work perfectly, just imperfectly, but acceptably. With the recent 
>> driver change, it now does not work at all. That's surely a bug in the 
>> driver.
>
> There is no logic in that sentence at all. You're saying that the driver is 
> broken because it doesn't fix an error in the EEPROM?

I am not asking the driver to fix errors in the EEPROM. I'm asking it to 
send and receive packets, as it has done in the past.

> We're trying extremely hard to fix real errors here (especially when we find 
> that hardware resellers send out hardware with EEPROM problems) ...

I do not expect the kernel to perform QA tests on my hardware, just work.

> and you are 
> asking for a workaround that will (likely) introduce random errors and 
> failure into your kernel. I do not want to accept responsability for 
> that ...

You publish your code under the GPL. You explicitly disclaim any warranty.

> If you want to edit your own kernel then I am fine with it.

I suspect that if all/many T23 laptops perform as mine does then some 
major vendors will also edit their kernels. I'm sure they would rather not 
do that.

> If you want to recalculate the checksum yourself and put it in the 
> EEPROM then I am also fine with that.

Can you provide a reference as to how I might do that?

> As long as you never ask for support for that NIC. But we can't support 
> an option that allows all users to willingly enable a piece of 
> non-properly-working hardware. Because that is what it is: Not properly 
> configured hardware.

Which it may be. But it doesn't work at all with the new kernel, where it 
has in the past.

> The bottom line is that your problem is that a specific hardware vendor 
> is/was selling badly configured hardware, and you buy it from them, even 
> after it's End Of Lifed for that vendor. Even though that vendor did buy the 
> units properly configured and had all the tools needed to configure them 
> properly.

I don't think either of us knows that.

> I can maybe fix your problem by seeing if we can get you an eeprom 
> update...

That'd be great. Thanks!

Regards

---
Charlie
