Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWAUN1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWAUN1l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 08:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWAUN1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 08:27:41 -0500
Received: from mail.tmr.com ([64.65.253.246]:38356 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932187AbWAUN1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 08:27:40 -0500
Message-ID: <43D23895.7080801@tmr.com>
Date: Sat, 21 Jan 2006 08:35:17 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Willy Tarreau <willy@w.ods.org>, Rumi Szabolcs <rumi_ml@rtfm.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernel uptime counter problem
References: <20060119110834.bb048266.rumi_ml@rtfm.hu> <7c3341450601190129r64a97880q22d576734214b6ac@mail.gmail.com> <20060119201857.GQ7142@w.ods.org> <200601192022.42087.nick@linicks.net> <Pine.LNX.4.61.0601201513360.22940@yvahk01.tjqt.qr> <43D0FF40.9060305@tmr.com> <Pine.LNX.4.61.0601201731130.10065@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601201731130.10065@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>>Or use some dedicated programs, IIRC there is a "uprecords" program
>>>(http://podgorny.cz/moin/Uptimed). Does require no reboot and should work
>>>right away.
>>>      
>>>
>>I never understood uptime anyway, the boot time, to the second, is available in
>>/proc/stat (btime), and it isn't that hard to turn it into whatever format you
>>find human readable. I have a perl script which presents uptime as fractional
>>days, days, hours, min, sec, and/or boot time. Took me about two minutes to
>>write.
>>    
>>
>
>uptime or uptimed/uprecords? (That's two different things.)
>The "uptime" commands is the same as "w | head -n1" (which reads 
>/proc/uptime) and therefore suffers from jiffies wrap.
>

I understand why it has this limitation, the question is why it was 
written to have it, when correct function is easily possible. I 
understand extra effort to get it right, but not to get it wrong...

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

