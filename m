Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267109AbUBFAim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267110AbUBFAim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:38:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:9407 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267109AbUBFAii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:38:38 -0500
X-Authenticated: #4512188
Message-ID: <4022E209.3040909@gmx.de>
Date: Fri, 06 Feb 2004 01:38:33 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
CC: Craig Bradney <cbradney@zip.com.au>, Andrew Morton <akpm@osdl.org>,
       david+challenge-response@blue-labs.org,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org> <1076026496.16107.23.camel@athlonxp.bradney.info> <4022DE3C.1080905@wanadoo.es>
In-Reply-To: <4022DE3C.1080905@wanadoo.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Miguel García wrote:
> Craig Bradney wrote:
> 
>>
>>
>>
>> One day hopefully this will be sorted in the BIOSes and in mainline. I
>> keep having to patch for every release (although as thats the only patch
>> I have to do I'm sure there are many worse off than me). I use the 3com
>> n/w on my A7N8X Deluxe v2 BIOS 1007 so no need for nforcedeth.
>>
>> Best patches are at:
>> http://lkml.org/lkml/2003/12/21/7
>>
>> Ive applied them to 2.6.0 and 2.6.1 and give no crashes and no heat
>> issues.

Unfortunately that patch doesn't work for me. Still locks if I try APIC 
+CPU DIsc.

>>
>> (XP2600+ runs at 31/32C normal use and 38C compiling with Zalman cooler
>> +exhaust fans in box)
>>
>> Craig
>>  
>>
> you mean 31 - 38 C readed from /proc/acpi/temp[........]????
> 
> I'm having readings of 53 in idle and even 64 while compiling!! I have 
> no case fan, but I don't think it's so important for this bug difference.

The problem is, you cannot trust those infos esp not across board 
manufacturers. In case of Abit nearly every bios shows different values...

I have an Athon XP running at 2.1Gz with 1.65vcore. Idle: 50°C (with CPU 
Disc usually about 44-40°C) and under load about 54°C. I am usign a more 
or less self-made watercooling.


Prakash
