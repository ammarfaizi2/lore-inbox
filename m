Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWHUIBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWHUIBV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWHUIBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:01:21 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:16006 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030305AbWHUIBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:01:20 -0400
Message-ID: <44E9678A.7050704@aitel.hist.no>
Date: Mon, 21 Aug 2006 09:58:02 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       David Schwartz <davids@webmaster.com>, alan@lxorguk.ukuu.org.uk,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: GPL Violation?
References: <1155919950.30279.8.camel@localhost.localdomain> <MDEHLPKNGKAHNMBLJOLKEEBCNOAB.davids@webmaster.com> <20060819113052.GC3190@aitel.hist.no> <200608192220.42456.chase.venters@clientec.com>
In-Reply-To: <200608192220.42456.chase.venters@clientec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:
> On Saturday 19 August 2006 06:30, Helge Hafting wrote:
>   
>> Now, if someone actually distributes a closed-source module that
>> circumvents EXPORT_SYMBOL_GPL, or relies on an accompagnying
>> open source patch that removes the mechanism, this happens:
>>
>> 1. By doing this, they clearly showed that their module is outside the
>>    gray area of "allowed binary-only modules". They definitively
>>    made a "derived work" and distributed it.
>>
>> 2. Anybody who received this module may now invoke the GPL
>>    (and the force of law, if necessary) to extract the
>>    module source code from the maker.  And then this source
>>    can be freely redistributed to all interested.
>>     
>
> Actually, you can't just force the vendor to open up all of their source code.
Not all their source of course, just the source for the derived work.
I.e. we'll get their driver, but not anything else they might have.
>  
> The GPL isn't a contract - it's a license. If a vendor makes a derived work 
> from the Linux kernel and does not GPL-license said derived work, they are 
> indeed violating copyright as the license the GPL provides no longer supports 
> their ability to redistribute.
>
> However, the court decides what happens to the vendor. The court might force 
> the vendor to open up their code, but to my knowledge this would be breaking 
> brand new ground. I think it is more likely that the plaintiff could be 
> awarded monetary damages and the defendant enjoined from further 
> redistribution.
>   
Yes the GPL is a licence. By using the code, they have accepted
the licence.  If I use a copy of windows, I'll be forced to pay.
The reason courts usually award monetary damages is that
money is what almost everybody wants.  Commercial software,
books, CDs, DVSs are all traded for money, so copying one
means you must pay the copyright holder's loss.

The GPL should work exactly the same way: You distribute
software derived from GPL software, you pay the usual price.
But the usual price for GPLed software is not money,
the usual price is the derived source.

That is what IBM pays when porting linux to their processors,
that is what various hardware vendors pay when they make an
open driver based on small changes to existing drivers.
And that is how I believe a vendor should be forced to pay,
should he have the nerve to distribute a driver that blatantly
works around the EXPORT_SYMBOL_GPL mechanism.
> The charge is not "violating the GPL" (since the GPL is not a contract) -- 
> it's distributing copyrighted materials without a license. See Eben Moglen's 
> discussion on this subject for more details.
>   
Interesting text.  Seems the FSF takes a 'nicer' approach, and that
works well enough.  Still, if someone tries to be difficult, I hope
they'll be forced to pay the usual price - which isn't money.
It'd be hard to set a price anyway, given that GPL software
isn't usually sold.  The price of having a professional programmer
developing the same driver perhaps?


Helge Hafting
