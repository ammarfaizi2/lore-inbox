Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVCAECV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVCAECV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 23:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVCAECV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 23:02:21 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:52938 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261230AbVCAECE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 23:02:04 -0500
Message-ID: <4223EA33.20406@utah-nac.org>
Date: Mon, 28 Feb 2005 21:06:11 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey <jmerkey@utah-nac.org>
Cc: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 bug
References: <1109487896.8360.16.camel@localhost> <200502271406.30690.kernel-stuff@comcast.net> <1109545130.7940.2.camel@localhost> <4223393D.3040908@utah-nac.org> <1109627454.7940.60.camel@localhost> <4223E9C8.5040604@utah-nac.org>
In-Reply-To: <4223E9C8.5040604@utah-nac.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey wrote:

> Jean-Marc Valin wrote:
>
>> Le lundi 28 février 2005 à 08:31 -0700, jmerkey a écrit :
>>  
>>
>>> I see this problem infrequently on systems that have low memory 
>>> conditions and
>>> with heavy swapping.    I have not seen it on 2.6.9 but I have seen 
>>> it on 2.6.10.   
>>
>>
>> My machine has 1 GB RAM and I wasn't using much of it at that time (2GB
>> free on the swap), so I doubt that's the problem in my case.
>>
>>     Jean-Marc
>>
>>  
>>
> Running the ext2 recover program seems to trigger some good bugs in 
> 2.6.10 with ext3 -- try it.  I was doing this
> to test some disk tools and I managed to cause these errors with 
> forcing ext2 recovery from an ext3 fs (which is
> probably something to be expected.  The recover tools need to get 
> syncrhonized -- have not tried with
> mc yet.)    Doesn't happen every time though.
>
> Jeff
>
>
>

lde also causes some problems as well with ext3.  Just caused one on 
2.6.10.  stale or poisoned
cache blocks perhaps?

Jeff
