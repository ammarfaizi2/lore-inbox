Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVCKURj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVCKURj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVCKUQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:16:47 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:23440 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261799AbVCKUIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:08:30 -0500
Message-ID: <4231FBFD.7000103@tmr.com>
Date: Fri, 11 Mar 2005 15:13:49 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
       Russell King <rmk+serial@arm.linux.org.uk>
Subject: Re: Problem with PPPD on dialup with 2.6.11-bk1 and later; 2.6.11
   is OK
References: <200503091914.24612.elenstev@mesatop.com><200503091914.24612.elenstev@mesatop.com> <20050310132114.5eda19d7@dxpl.pdx.osdl.net>
In-Reply-To: <20050310132114.5eda19d7@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
>>Stephen Hemminger also wrote: (Someting's busted with serial in 2.6.11 latest)
>>
>>>Some checkin since 2.6.11 has caused the serial driver to
>>>drop characters.  Console output is chopped and messages are garbled.
>>>Even the shell prompt gets truncated.
> 
> 
>>Searching lkml archive, I found:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=111031501416334&w=2
>>
>>I also found that reverting that patch made the problem go away for 2.6.11-bk1.
> 
> 
> 
> Yes, this patch is the problem. A fix showed up today.
> Current kernels work fine, thanks.

Could someone who has the patch broken out send it to -stable? Serial 
not working is a non-trivial issue given the number of people who use 
dialup either full time or as a fallback connection.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
