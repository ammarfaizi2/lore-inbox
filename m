Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933167AbWKMXeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933167AbWKMXeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933168AbWKMXeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:34:05 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:14465 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933167AbWKMXeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:34:03 -0500
Message-ID: <455900EC.4010107@oracle.com>
Date: Mon, 13 Nov 2006 15:34:04 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Greg.Chandler@wellsfargo.com
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 1/1] drivers/block/Kconfig text update.  Try #2
References: <E8C008223DD5F64485DFBDF6D4B7F71D02235904@msgswbmnmsp25.wellsfargo.com>
In-Reply-To: <E8C008223DD5F64485DFBDF6D4B7F71D02235904@msgswbmnmsp25.wellsfargo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg.Chandler@wellsfargo.com wrote:
>  
> Sorry...
> I've attached the new one.

OK, thanks.

>> The second line of the drivers/block/cciss.c file says:
>>
>> " *    Disk Array driver for HP SA 5xxx and 6xxx Controllers"
>>
>> I couldn't find the 6 series anywhere in the menu, and I ended up 
>> finding it in the code...
> 
> Please read/observe Documentation/SubmittingPatches:
> the --- & +++ lines should begin with linux/drivers/... or a/drivers/...
> so that the patch can be applied with "patch -p1".
> 
>> --- drivers/block/Kconfig.old   2006-11-13 14:20:12.000000000 -0800
>> +++ drivers/block/Kconfig       2006-11-13 14:20:32.000000000 -0800
>> @@ -155,10 +155,10 @@
>>           this driver.
>>
>>  config BLK_CPQ_CISS_DA
>> -       tristate "Compaq Smart Array 5xxx support"
>> +       tristate "Compaq Smart Array 5xxx/6xxx support"
>>         depends on PCI
>>         help
>> -         This is the driver for Compaq Smart Array 5xxx controllers.
>> +         This is the driver for Compaq Smart Array 5xxx/6xxx
>> controllers.
> 
> Patch is line-wrapped on the line above.
> 
>>           Everyone using these boards should say Y here.
>>           See <file:Documentation/cciss.txt> for the current list of
>>           boards supported by this driver, and for further information
> 
> ---

-- 
~Randy
