Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVE0RuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVE0RuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 13:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVE0RuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 13:50:01 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:25269 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261949AbVE0RtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 13:49:12 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Fri, 27 May 2005 10:48:58 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: weird X problem - priority inversion?
In-Reply-To: <1117215557.13829.76.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0505271048160.14917@qynat.qvtvafvgr.pbz>
References: <1113428938.16635.13.camel@mindpipe><20050523075508.GC9287@elte.hu><Pine.LNX.4.62.0505230110240.7165@qynat.qvtvafvgr.pbz><1117202510.13829.17.camel@mindpipe><Pine.LNX.4.62.0505271034010.14917@qynat.qvtvafvgr.pbz>
 <1117215557.13829.76.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Lee Revell wrote:

> On Fri, 2005-05-27 at 10:34 -0700, David Lang wrote:
>> On Fri, 27 May 2005, Lee Revell wrote:
>>
>>> On Mon, 2005-05-23 at 01:11 -0700, David Lang wrote:
>>>> remember that the low pri screensaver is just generating the image to be
>>>> displayed, it's the high pri X server that's actually doing the work to
>>>> display it.
>>>
>>> Then there needs to be some mechanism to handle it, either in X or the
>>> kernel.  Other OSes do not require you to turn off the screensaver to
>>> avoid a DoS - they do the obvious thing and run the screensaver at the
>>> lowest priority.
>>>
>>> The problem may be software 3D rendering (I did not have the VIA driver
>>> enabled as I did not realize it was in the kernel yet).   Maybe the X
>>> server should do the work in a low priority thread.  But it sure
>>> shouldn't DoS the system.  Other OSes do not have this problem.
>>
>> Actually they don't (or at least didn't the last time I took windows
>> training), if you have a CPU intensive screen saver on a windows server it
>> will seriously load down the box when it kicks in.
>
> That was a problem in the NT 4.0 days, but not lately.

Ok, it has been a while since I had windows training (and I DON'T miss it ;-)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
