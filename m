Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUFEUVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUFEUVm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 16:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUFEUVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 16:21:42 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:11669 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261943AbUFEUVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 16:21:41 -0400
Message-ID: <40C22B4E.5080806@colorfullife.com>
Date: Sat, 05 Jun 2004 22:21:34 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell Leighton <russ@elegant-software.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fw: F_SETSIG broken/changed in 2.6 for UDP and TCP sockets?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Leighton wrote:

>> Thanks to all that helped me troubleshoot.
>>
>> Of the 2 issues I had with FedoraCore2, one problem is solved:
>>
>>    * Multicast issues were solved by using another NIC. It seems that
>>      the driver for the NatSemi DP8381[56] does not receive mutlicast
>>      properly.
>  
>

Odd. I've just tried the driver from 2.6.7-rc2 and multicast receive 
works: the hardware correctly accepts packets for the requested group 
and skips packets for all other groups.
Which app do you use for multicast receive/send? Which nic do you use 
now instead of natsemi?

--
    Manfred
