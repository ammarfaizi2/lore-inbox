Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWEYTAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWEYTAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWEYTAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:00:54 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:41193 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030349AbWEYTAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:00:54 -0400
Message-ID: <4475FEE5.8070009@pardus.org.tr>
Date: Thu, 25 May 2006 22:00:53 +0300
From: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
User-Agent: Mozilla Thunderbird 1.5.0.2 (X11/20060426)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org> <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org> <4475FD12.2030300@pardus.org.tr> <Pine.LNX.4.61.0605252056440.13379@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605252056440.13379@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote On 25-05-2006 21:59:
>>>> # hostname --fqdn
>>>> shanghai.hopto.org
>>> Ahh. I wonder how portable this is. We could certainly make the kernel
>>> build use "hostname --fqdn" if that works across all versions.
>>>
>>> That code hasn't changed in a looong time, and I suspect that "--fqdn"
>>> didn't exist back when.. 
>> Doesn't work here :
>>
>> cartman@southpark ~ $ hostname --fqdn
>> hostname: invalid option -- -
>> Try `hostname --help' for more information.
>> cartman@southpark ~ $ hostname --version
>> hostname (GNU coreutils) 5.96
> 
> 20:56 shanghai:~ > hostname --version
> net-tools 1.60
> hostname 1.100 (2001-04-14)
> 
> Interesting.

So coreutils & net-tools conflict with each other. How nice :/

/ismail

