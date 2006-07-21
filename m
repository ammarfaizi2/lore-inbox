Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWGUIWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWGUIWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 04:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWGUIWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 04:22:24 -0400
Received: from etna.obsidian.co.za ([196.36.119.67]:44459 "EHLO
	etna.obsidianonline.net") by vger.kernel.org with ESMTP
	id S1161014AbWGUIWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 04:22:24 -0400
Message-ID: <44C08E97.4000909@rootcore.co.za>
Date: Fri, 21 Jul 2006 10:21:43 +0200
From: Charles Majola <chmj@rootcore.co.za>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Michael Lothian <mike@fireburn.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Status of the T-Mobile 3G PCMCIA Card
References: <fc94aae90607201140m6d50b8d0qa547a93e14babb66@mail.gmail.com> <1153427335.2772.4.camel@aeonflux.holtmann.net>
In-Reply-To: <1153427335.2772.4.camel@aeonflux.holtmann.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Few problems..

chmj@buildd:~/projects/kernel$ cg-clone 
http://git.holtmann.org/nozomi.git nozomi
defaulting to local storage area
Fetching head...
cg-fetch: unable to get the HEAD branch
cg-clone: fetch failed
chmj@buildd:~/projects/kernel$ git clone 
http://git.holtmann.org/nozomi.git nozomi
defaulting to local storage area
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?


--
chmj
"Wot? me worry?"

Marcel Holtmann wrote:
> Hi Michael,
>
>   
>> I've recently subscribed to T-Mobile's 3G service for my laptop. I
>> found v little info on the card but heard a few success stories with
>> the Vodafone card with Linux.
>>
>> Upon getting the card I've not realised my mistake and it appears that
>> it isn't as simple as I'd hoped.
>>
>> Has anyone had any success with this card at all?
>>
>> The lspci out put is:
>>
>> 04:00.2 Network controller: Option N.V. Qualcomm MSM6275 UMTS chip
>>         Flags: medium devsel, IRQ 17
>>         Memory at 52040000 (32-bit, non-prefetchable) [disabled] [size=2K]
>> 04:00.2 0280: 1931:000c
>>
>> pccard: CardBus card inserted into slot 0 is what dmesg says
>>
>> And nothing appears under lsusb
>>
>> I'd be grateful for any help anyone can offer because if I can't get
>> it to work I'll need to return it within the "cooling down" period
>> which is the next few days and be locked into an 18 month contract
>>     
>
> they provided a driver for it and I am working on cleaning it up and
> getting it merged mainline, but this hasn't been finished now. However I
> am using this card for quite some time now with Linux. You can download
> my current driver version with this command:
>
> 	cg-clone http://git.holtmann.org/nozomi.git
>
> I broke the latest revision with a change that produces a NULL pointer
> dereference and haven't had the time to fix it. Will take a look at it
> once I am back from the OLS.
>
> Regards
>
> Marcel
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   

