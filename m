Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbVJ1RMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbVJ1RMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 13:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVJ1RMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 13:12:06 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:58848 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1030483AbVJ1RLy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 13:11:54 -0400
Message-ID: <43625D04.9000903@student.ltu.se>
Date: Fri, 28 Oct 2005 19:16:52 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc5] drivers/net/dgrs.c: Fix potential "unused
 variable"-warning.
References: <435FFADA.8030703@student.ltu.se> <43625414.8050906@pobox.com>
In-Reply-To: <43625414.8050906@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Richard Knutsson wrote:
>
>> diff -uNr a/drivers/net/dgrs.c b/drivers/net/dgrs.c
>> --- a/drivers/net/dgrs.c    2005-08-29 01:41:01.000000000 +0200
>> +++ b/drivers/net/dgrs.c    2005-10-26 15:53:43.000000000 +0200
>> @@ -1549,7 +1549,7 @@
>> static int __init dgrs_init_module (void)
>> {
>>     int    i;
>> -    int eisacount = 0, pcicount = 0;
>> +    int    count = 0;
>
>
> no need to initialize the variable

Yeah, you are right. Saw it after I sent the mail and thought it would 
be cluttering the mail-list just to say so.
Thanks for noticing. :)

*Note to 'self:
Check and _recheck_ patch before sending it*
/Richard

PS
Sorry about the bounced mail from torvalds@transmeta.com, did not 
realize it were an old address.
