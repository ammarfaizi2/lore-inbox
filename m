Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVHQKcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVHQKcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 06:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVHQKcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 06:32:06 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:56474 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1751053AbVHQKcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 06:32:05 -0400
Message-ID: <43031223.4020901@bootc.net>
Date: Wed, 17 Aug 2005 11:32:03 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: SiI 3112A + Seagate HDs = still no go? [SOLVED]
References: <12872CA9-F089-4955-8751-8CC4E7B2140A@bootc.net> <42FC166A.3020505@gmail.com> <0FDE8D5B-CFF2-44F9-8C98-9C5EC5CDAE92@bootc.net> <42FC87ED.6030201@gmail.com> <22B1D7C7-7BC8-449C-914C-FCE5226BCAF2@bootc.net> <655E2636-B4D4-42EC-B10C-C8B8EFA09E33@bootc.net> <42FCAD4D.7080707@gmail.com> <74C9A166-2FDC-45F8-BEB1-A574FD9602D4@bootc.net> <42FD493D.8020506@gmail.com> <EB750DA5-854F-4387-A5D7-F646EB8E7AAC@bootc.net> <42FE0ACE.6010506@gmail.com>
In-Reply-To: <42FE0ACE.6010506@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:

> Chris Boot wrote:
>
>> Some interesting developments!
>>
>> I installed a fresh copy of Windows, and all the VIA and nVidia and  
>> so on drivers. At some point during all this (a period of relatively  
>> heavy disk IO), the computer seemed to crash and I rebooted it. It  
>> then worked fine for a while, but during my perfmon testing it 
>> seemed  to do the same thing. This time I left it for a while and it 
>> did  eventually wake up again, so I'm guessing the controller is a 
>> bit  fubared. Perfmon did indeed show several dips down to or very 
>> close  to 0 during the write operation, with peaks up to 48 MB/sec, 
>> which is  pretty respectable. So, time to replace the brand-new 
>> controller I  guess.
>>
>> Now, do you think this is just my one particular controller card and  
>> a simple return would fix the problem, or is it more likely a 
>> problem  with the whole range? It's an Innovision EIO SATA 
>> controller: http:// www.ivmm.com/eio/products/index.htm
>>
>> Would it be a safer bet to go for the Adaptec controller of the same  
>> variety? How reliable are they?
>
>
>  I frankly don't know.  Maybe it's just one faulty controller, 
> connector or whatever.  Maybe the card manufacturer screwed up 
> somewhere.  I mean, the only course I took in electronics is 
> introductory digital circuits which used 74xx chips and push triggered 
> clock on a breadboard.  What would I know about gigahertz signaling 
> error.  :-p
>
>  Though, one thing I can say is majority of 311x controllers don't 
> seem to suffer from this problem.  So, take your pick.
>
Right, I've replaced my previous controller with an Adaptec AHA-1205SA, 
and I'm rebulding 2 RAID-1 arrays at 50MB/sec without a hitch.

Thanks for your help diagnosing my problem, it was much appreciated!

Many thanks,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

