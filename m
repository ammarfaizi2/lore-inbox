Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVKVRLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVKVRLS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVKVRLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:11:18 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:38674 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S965016AbVKVRLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:11:16 -0500
Message-ID: <43835131.5070608@argo.co.il>
Date: Tue, 22 Nov 2005 19:11:13 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com> <43833D61.9050400@argo.co.il> <20051122155143.GA30880@havoc.gtf.org> <43834400.3040506@argo.co.il> <20051122162506.GA32684@havoc.gtf.org> <438349F4.2080405@argo.co.il> <20051122165638.GE32684@havoc.gtf.org>
In-Reply-To: <20051122165638.GE32684@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 17:11:15.0209 (UTC) FILETIME=[BEE2DF90:01C5EF87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>  
>
>>However the situation with video drivers is already bad, and 
>>deteriorating. I had to hunt on the Internet to get my recent (FC4) 
>>distro to support my low-end embedded video (via). In the future it 
>>looks like even that won't work.
>>    
>>
>
>VIA is working with open source community.  They are small enough
>(comparatively) that they need every advantage.  VIA is one of the
>positive examples.
>
>  
>
I'm aware of that. But look at the trouble we have even with the 
cooperative vendors. I'm sure they had a Windows driver from day zero.

>  
>
>>>Dumb with a capital 'D'.
>>>
>>>
>>>      
>>>
>>I hope you have a better solution.
>>    
>>
>
>Almost all of the solutions listed in this thread are better:
>Chinese wall rev-eng,
>
As others pointed out, rev-eng of programmable 3D hardware will be 
difficult. There will be a perpetual (and long) lag between the 
introduction of hardware and Linux support. The effort has to repeat for 
new revisions of the hardware. And a rev-eng driver can still not be 
trusted: who knows whether the register you just wrote into doesn't have 
some subtle side-effect.

> funding, ...
>  
>
I want some too.


I don't think Windows drivers are the best, or even a good solution. But 
that may be the only realistic one. And I believe quite doable.
