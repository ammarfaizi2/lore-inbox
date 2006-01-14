Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945928AbWANAom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945928AbWANAom (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945925AbWANAm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:42:27 -0500
Received: from hermes.domdv.de ([193.102.202.1]:29967 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1945922AbWANAmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:42:23 -0500
Message-ID: <43C848C7.1070701@domdv.de>
Date: Sat, 14 Jan 2006 01:41:43 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Sven-Thorsten Dietrich <sven@mvista.com>, thockin@hockin.org,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
References: <1137178855.15108.42.camel@mindpipe><Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz><20060113215609.GA30634@hockin.org><Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz> <1137190698.2536.65.camel@localhost.localdomain> <Pine.LNX.4.62.0601131448150.9821@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0601131448150.9821@qynat.qvtvafvgr.pbz>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Fri, 13 Jan 2006, Sven-Thorsten Dietrich wrote:
> 
>> On Fri, 2006-01-13 at 14:05 -0800, David Lang wrote:
>>
>>> On Fri, 13 Jan 2006 thockin@hockin.org wrote:
>>>
>>>> On Fri, Jan 13, 2006 at 01:18:35PM -0800, David Lang wrote:
>>>>
>>>>> Lee, the last time I saw this discussion I thought it was
>>>>> identified that
>>>>> the multiple cores (or IIRC the multiple chips in a SMP
>>>>> motherboard) would
>>>>> only get out of sync when power management calls were made (hlt or
>>>>> switching the c-state). IIRC the workaround that was posted then
>>>>> was to
>>>>> just disable these in the kernel build.
>>>>
>>>>
>>>> not using 'hlt' when idling means that you spend 10s of Watts more
>>>> power
>>>> on mostly idle systems.
>>>
>>>
>>> true, but for people who need better time accruacy then the other
>>> workaround this may be very acceptable.
>>>
>>
>> 1/4 KW / day for time synchronisation.
>>
>> The power company would love that.
> 
> 
> more precisely 1/4 KW Hour / day
> 
> $0.01 - $0.02/day (I had to lookup the current rates)
> 
> they probably won't notice.
> 

Well, wait until there's AMD based dual core x86_64 laptops out there
(this email being written on a single core x86_64 one). I can already
see the faces of the unhappy future owners being told "use idle=poll"
when on battery and anyway going deaf by fan noise.

(/me ducks and runs)
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
