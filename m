Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVEGXA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVEGXA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 19:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVEGXA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 19:00:56 -0400
Received: from jagor.srce.hr ([161.53.2.130]:43508 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id S262749AbVEGXAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 19:00:51 -0400
Message-ID: <427D489C.8050409@spymac.com>
Date: Sun, 08 May 2005 01:00:44 +0200
From: zhilla <zhilla@spymac.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix for bttv driver (v0.9.15) for Leadtek WinFast VC100
 XP capture cards
References: <200504252007.15329.pete@phraxos.nildram.co.uk> <42752648.5010901@spymac.com>
In-Reply-To: <42752648.5010901@spymac.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.479 (*) DOMAIN_BODY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zhilla wrote:

>> --- bttv-cards.c    2005-04-24 23:39:41.000000000 +0100
>> +++ /usr/src/kernel-source-2.6.11/drivers/media/video/bttv-cards.c    
>> 2005-04-25 19:59:27.000000000 +0100
>> @@ -1939,7 +1939,6 @@
>>          .no_tda9875     = 1,
>>          .no_tda7432     = 1,
>>          .tuner_type     = TUNER_ABSENT,
>> -        .no_video       = 1,
>>      .pll            = PLL_28,
>>  },{
>>      .name           = "Teppro TEV-560/InterVision IV-560",
> works great for me, too. from "non working, not possible to make it 
> work" to "works great" - 1 line of code.
> to developers... make sure it gets to next 2.6.11.x/12 kernel version :)

just a BUMP for this...
remember, this patch is SAFE, TRIVIAL and all it does is make Leadtek 
VC100 capture card from "impossible to make it work" to "works 
flawlessly"...
puhleeease? 2.6.12 at least?
