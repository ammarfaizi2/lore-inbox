Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273921AbRIXOLi>; Mon, 24 Sep 2001 10:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273922AbRIXOL2>; Mon, 24 Sep 2001 10:11:28 -0400
Received: from [195.66.192.167] ([195.66.192.167]:37137 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S273921AbRIXOLQ>; Mon, 24 Sep 2001 10:11:16 -0400
Date: Mon, 24 Sep 2001 17:05:39 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <12730310183.20010924170539@port.imtp.ilyichevsk.odessa.ua>
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux VM design
In-Reply-To: <Pine.LNX.4.33L.0109241027070.19147-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109241027070.19147-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rik,
Monday, September 24, 2001, 4:29:46 PM, you wrote:

>> Since we reached some kind of stability with 2.4, maybe
>> Andrea, Rik and whoever else is considering himself VM geek
>> would tell us not-so-clever lkml readers how VM works and put it in
>> vm-2.4andrea, vm-2.4rik or whatever in Doc/vm/*,
>> I will be unbelievably happy. Matt Dillon's post belongs there too.

RvR> http://linux-mm.org/

I was there today. Good. Can this stuff be placed as
Doc/mv/vm2.4rik
to prevent it from being outdated in 2-3 months?
Linus?

Also I'd like to be enlightened why this:

>Virtual Memory Management Policy
>--------------------------------
>The basic principle of the Linux VM system is page aging. We've seen
>that refill_inactive_scan() is invoked periodically to try to
>deactivate pages, and that it ages pages down as it does so,
>deactivating them when their age reaches 0. We've also seen that
>swap_out() will age referenced page frames up while scanning process
>memory maps. This is the fundamental mechanism for VM resource
>balancing in Linux: pages are aged down at a more-or-less steady rate,
>and deactivated when they become sufficiently old; but processes can
>keep pages "young" by referencing them frequently.

is better than plain simple LRU?

We definitely need VM FAQ to have these questions answered once per VM
design, not once per week :-)

RvR> The only thing missing is an explanation of Andrea's
RvR> VM, but knowing Andrea's enthusiasm at documentation
RvR> I wouldn't really count on that any time soon ;)

:-)

-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


