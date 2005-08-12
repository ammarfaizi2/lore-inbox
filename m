Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVHLUHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVHLUHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 16:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVHLUHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 16:07:52 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:18075 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S1750799AbVHLUHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 16:07:51 -0400
Date: Fri, 12 Aug 2005 13:07:42 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01,
 High Resolution Timers & RCU-tasklist features
In-reply-to: <200508122127.26928.guifo@wanadoo.fr>
To: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Message-id: <Pine.LNX.4.63.0508121303130.9178@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <200508112039.07660.guifo@wanadoo.fr>
 <Pine.LNX.4.58.0508120426070.3233@devserv.devel.redhat.com>
 <200508122127.26928.guifo@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005, Guillaume Foliard wrote:

> On Friday 12 August 2005 14:53, Ingo Molnar wrote:
>> On Thu, 11 Aug 2005, Guillaume Foliard wrote:
>>> Hi,
>>>
>>> Here is the compilation error I had with 0.7.53-02 :
>>
>> thanks - i've uploaded the -53-05 patch which should fix this - does it
>> build/work for you now?
>
> I've tried -53-07. Build is ok. Kernel has booted and is running.
>
> Thank you.
>
> Guillaume
>

I still get a compile error in drivers/ide/ide-taskfile.c because the
conditionals around references to flag are not consistant. The patch
I sent for -53-06 should still work to correct this.

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- Fad: In one era and out the other. --
