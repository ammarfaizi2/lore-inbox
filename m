Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267080AbUBFAW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267083AbUBFAW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:22:29 -0500
Received: from lgsx13.lg.ehu.es ([158.227.2.28]:37012 "EHLO lgsx13.lg.ehu.es")
	by vger.kernel.org with ESMTP id S267080AbUBFAW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:22:26 -0500
Message-ID: <4022DE3C.1080905@wanadoo.es>
Date: Fri, 06 Feb 2004 01:22:20 +0100
From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Craig Bradney <cbradney@zip.com.au>
CC: Andrew Morton <akpm@osdl.org>, david+challenge-response@blue-labs.org,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org> <1076026496.16107.23.camel@athlonxp.bradney.info>
In-Reply-To: <1076026496.16107.23.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:

>On Fri, 2004-02-06 at 00:40, Andrew Morton wrote:
>  
>
>>Luis Miguel García <ktech@wanadoo.es> wrote:
>>    
>>
>>>David Ford wrote:
>>>
>>>      
>>>
>>>>I have the same problem.  I "solved" it a while ago by mucking with 
>>>>the AGP stuff.  IIRC, it was turning off AGP fast writes or 8x or 
>>>>something similar in cmos.  Went from incredibly broken to stable 
>>>>instantly.  I'll check my cmos settings in a bit and refresh my memory.
>>>>
>>>>What patches are you using?
>>>>        
>>>>
>>>I'm using nforce2-apic.patch and nforce2-disconnect-quirk.patch that 
>>>Andrew Morton have sent to me. I think they have been included in 
>>>previous mm kernels but now are droped because they caused some 
>>>temperature problems for some people with no nforce motherboards.
>>>      
>>>
>>Yes, the patch which disables "Halt Disconnect and Stop Grant Disconnect"
>>apparently causes the CPU to run hot.
>>
>>    
>>
>>>By the way, is anyone involved in solving the IO-APIC thing in nforce 
>>>motherboards? Anyone trying a different approach? Anyone contacting 
>>>nvidia about this problem?
>>>      
>>>
>>As far as I know, we're dead in the water on these problems.
>>    
>>
>
>
>One day hopefully this will be sorted in the BIOSes and in mainline. I
>keep having to patch for every release (although as thats the only patch
>I have to do I'm sure there are many worse off than me). I use the 3com
>n/w on my A7N8X Deluxe v2 BIOS 1007 so no need for nforcedeth.
>
>Best patches are at:
>http://lkml.org/lkml/2003/12/21/7
>
>Ive applied them to 2.6.0 and 2.6.1 and give no crashes and no heat
>issues.
>
> (XP2600+ runs at 31/32C normal use and 38C compiling with Zalman cooler
>+exhaust fans in box)
>
>Craig
>  
>
you mean 31 - 38 C readed from /proc/acpi/temp[........]????

I'm having readings of 53 in idle and even 64 while compiling!! I have 
no case fan, but I don't think it's so important for this bug difference.

by the way, has anyone tried to contact nvidia with detailed information 
of this bug? Perhaps they can tell us something, not to?

