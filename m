Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281302AbRKET7k>; Mon, 5 Nov 2001 14:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281300AbRKET7W>; Mon, 5 Nov 2001 14:59:22 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:11147 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S281296AbRKET7N>;
	Mon, 5 Nov 2001 14:59:13 -0500
Message-ID: <3BE6EF7D.40103@candelatech.com>
Date: Mon, 05 Nov 2001 12:58:53 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
CC: Manfred Spraul <manfred@colorfullife.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, John Fremlin <john@fremlin.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [POLITICAL] Re: ECS k7s5a audio sound SiS 735 - 7012
In-Reply-To: <20011105175245.X1658-100000@gerard>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Gérard Roudier wrote:

> 
> On Sun, 4 Nov 2001, Manfred Spraul wrote:
> 
> 
>>Jeff Garzik wrote:
>>
>>>Gérard Roudier wrote:
>>>
>>>>different from Tekram adapters. Btw, my Netgear FA311 board is not handled
>>>>by the sis driver of linux-2.2.20 and my little finger tells me that it
>>>>could be so given a few code addition.
>>>>
>>>Unless you have a really strange board I haven't seen, NetGear FA311 are
>>>the natsemi DP83815/6 chips, handling by either "natsemi" or "fa311"
>>>drivers, not "sis900" driver...
>>>
>>>
>>sis900 and natsemi are similar, probably both could be handled with one
>>driver.
>>e.g. freebsd has one driver for natsemi and sis900.
>>
>>But I'm not a big fan of huge drivers that handle multiple 99%
>>compatible controllers and always break for one controller if you try to
>>fix another controller, so I won't try to merge them.
>>
> 
> So you would have preferred, for example, to have dozens of different
> drivers for SYM53C8XX chips and probably as many for Adaptec aic7xxx ones.
> And, probably, one set of different drivers per O/S. And why not one set
> per O/S major version and even per adjacent ones of the same O/S.
> 
> Given all the different brands that use similar or compatibles chips, the
> way you want drivers to be developped and maintained looks just
> unrealistic to me.


Jeff has intimate knowledge of the Tulip driver, one of the more complex
drivers that supports a bazillion different cards.  And also one of the hardest
to get (and keep) working on all of the devices it seems....

I think he has a very valid point....

Ben


> 
>   Gérard.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


