Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWHXVPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWHXVPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWHXVPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:15:06 -0400
Received: from alpha.polcom.net ([83.143.162.52]:37868 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1751619AbWHXVPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:15:03 -0400
Date: Thu, 24 Aug 2006 23:14:57 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-kernel@vger.kernel.org, pingved@gmail.com
Subject: Re: [PATCH] boot: small change of halt method
In-Reply-To: <44EE2228.5020807@flower.upol.cz>
Message-ID: <Pine.LNX.4.63.0608242312570.14363@alpha.polcom.net>
References: <20060824184447.GA3346@windows95> <44EDF923.4030607@zytor.com>
 <44EE2228.5020807@flower.upol.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006, Oleg Verych wrote:
> H. Peter Anvin wrote:
>>  Andrew Brukhov wrote:
>> 
>> >  I'm new here.
>> >  After reading boot code i'm immidiatly change this string:
> ...
>> >  + * Small fix of halt method Andrew Brukhov, Aug. 2006 
>> >  */
>> > 
> <http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt>
>
>>
>>      while (1)
>>          asm volatile("hlt");
>>
>>  ... since HLT only pauses until interrupt.
>> 
> Why not to have a reboot here?
> Testing and getting such errors on my laptop, it needs a power cycle.

And what if hlt is buggy? I have at least one pIII tualatin based server 
that has some strange mainboard problem and will work only if nohlt is 
passed to the kernel.


Thanks,

Grzegorz Kulewski

