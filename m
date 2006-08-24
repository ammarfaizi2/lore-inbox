Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWHXVEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWHXVEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWHXVEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:04:04 -0400
Received: from main.gmane.org ([80.91.229.2]:45760 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422659AbWHXVEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:04:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] boot: small change of halt method
Date: Fri, 25 Aug 2006 00:03:20 +0200
Organization: Palacky University in Olomouc, experimental physics dep.
Message-ID: <44EE2228.5020807@flower.upol.cz>
References: <20060824184447.GA3346@windows95> <44EDF923.4030607@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: linux-kernel@vger.kernel.org, pingved@gmail.com
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <44EDF923.4030607@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Andrew Brukhov wrote:
> 
>> I'm new here.
>> After reading boot code i'm immidiatly change this string:
...
>> + * Small fix of halt method Andrew Brukhov, Aug. 2006                 */
>>  
<http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt>

> 
>     while (1)
>         asm volatile("hlt");
> 
> ... since HLT only pauses until interrupt.
> 
Why not to have a reboot here?
Testing and getting such errors on my laptop, it needs a power cycle.

-- 
-o--=O`C  /. .\  (yep) (+)                                    /o-o\
  #oo'L O      o         |                                     *.
<___=E M    ^--         |  (you're barking up the wrong tree) =--'

