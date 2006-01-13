Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423082AbWAMWuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423082AbWAMWuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423086AbWAMWt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:49:59 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:51153 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1423082AbWAMWt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:49:58 -0500
Date: Fri, 13 Jan 2006 14:49:47 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Sven-Thorsten Dietrich <sven@mvista.com>
cc: thockin@hockin.org, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
In-Reply-To: <1137190698.2536.65.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0601131448150.9821@qynat.qvtvafvgr.pbz>
References: <1137178855.15108.42.camel@mindpipe><Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz><20060113215609.GA30634@hockin.org><Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz>
 <1137190698.2536.65.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Sven-Thorsten Dietrich wrote:

> On Fri, 2006-01-13 at 14:05 -0800, David Lang wrote:
>> On Fri, 13 Jan 2006 thockin@hockin.org wrote:
>>
>>> On Fri, Jan 13, 2006 at 01:18:35PM -0800, David Lang wrote:
>>>> Lee, the last time I saw this discussion I thought it was identified that
>>>> the multiple cores (or IIRC the multiple chips in a SMP motherboard) would
>>>> only get out of sync when power management calls were made (hlt or
>>>> switching the c-state). IIRC the workaround that was posted then was to
>>>> just disable these in the kernel build.
>>>
>>> not using 'hlt' when idling means that you spend 10s of Watts more power
>>> on mostly idle systems.
>>
>> true, but for people who need better time accruacy then the other
>> workaround this may be very acceptable.
>>
>
> 1/4 KW / day for time synchronisation.
>
> The power company would love that.

more precisely 1/4 KW Hour / day

$0.01 - $0.02/day (I had to lookup the current rates)

they probably won't notice.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

