Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVCAFZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVCAFZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 00:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVCAFZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 00:25:38 -0500
Received: from smtp.hickorytech.net ([216.114.192.16]:19614 "EHLO
	avalanche.hickorytech.net") by vger.kernel.org with ESMTP
	id S261240AbVCAFZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 00:25:28 -0500
Message-ID: <4223FCC7.3010005@mnsu.edu>
Date: Mon, 28 Feb 2005 23:25:27 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: jmerkey <jmerkey@utah-nac.org>
Cc: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 bug
References: <1109487896.8360.16.camel@localhost> <200502271406.30690.kernel-stuff@comcast.net> <1109545130.7940.2.camel@localhost> <4223393D.3040908@utah-nac.org> <1109627454.7940.60.camel@localhost> <4223E9C8.5040604@utah-nac.org> <4223EA33.20406@utah-nac.org>
In-Reply-To: <4223EA33.20406@utah-nac.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.6.10 has some bio problems that are fixed in the current 
linux-2.6.11 release candidates.  The bio problems wreaked havoc with 
XFS and there were people reporting EXT3 problems as well with this 
bug.  I'd recommend trying the latest release candidate and see if your 
problem vanishes.

-- 
jeffrey hundstad


jmerkey wrote:

> jmerkey wrote:
>
>> Jean-Marc Valin wrote:
>>
>>> Le lundi 28 février 2005 à 08:31 -0700, jmerkey a écrit :
>>>  
>>>
>>>> I see this problem infrequently on systems that have low memory 
>>>> conditions and
>>>> with heavy swapping.    I have not seen it on 2.6.9 but I have seen 
>>>> it on 2.6.10.   
>>>
>>>
>>>
>>> My machine has 1 GB RAM and I wasn't using much of it at that time (2GB
>>> free on the swap), so I doubt that's the problem in my case.
>>>
>>>     Jean-Marc
>>>
>>>  
>>>
>> Running the ext2 recover program seems to trigger some good bugs in 
>> 2.6.10 with ext3 -- try it.  I was doing this
>> to test some disk tools and I managed to cause these errors with 
>> forcing ext2 recovery from an ext3 fs (which is
>> probably something to be expected.  The recover tools need to get 
>> syncrhonized -- have not tried with
>> mc yet.)    Doesn't happen every time though.
>>
>> Jeff
>>
>>
>>
>
> lde also causes some problems as well with ext3.  Just caused one on 
> 2.6.10.  stale or poisoned
> cache blocks perhaps?
>
> Jeff
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


