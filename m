Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265391AbUAPPlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbUAPPlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:41:21 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:28322
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265391AbUAPPlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:41:19 -0500
Message-ID: <400805E5.9070808@tmr.com>
Date: Fri, 16 Jan 2004 10:40:21 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
References: <1d6yN-6HH-17@gated-at.bofh.it> <1dasC-5Ww-5@gated-at.bofh.it> <1ejkf-724-13@gated-at.bofh.it> <1elvB-Jt-25@gated-at.bofh.it>
In-Reply-To: <1elvB-Jt-25@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> On Thu, 2004-01-15 at 12:01, Bill Davidsen wrote:

>>"not in a released kernel..." Do I read this right? That you have a fix 
>>for a critical bug and it hasn't been pushed to customers yet?
> 
> 
> No, you don't read this right.  We have a fix for a correctness issue
> that has almost 0% chance of ever triggering in real life, has exactly 0
> bug reports of it ever happening, and which has been integrated into our
> tree.  Obviously, we always push new kernels to all of our customers
> every time we have this situation, or about twice a day...

I actually had in mind a notification so customers would know it was 
there if they actually see a similar problem, and a way to get the fix 
if needed. Since a patch was posted, I assume that's it's not quite as 
unlikely as you seem to imply.

We have two copies of RHEL-3.0 in-house, and I have a budget line item 
to upgrade 38 servers from RH-8.0 this year. Since they are all SMP/SCSI 
I think my concern with this bug, and the bug notification process in 
general is germane. I don't want to apply fixes for problems I don't 
have, but I want to know what fixes are out there so if I have a similar 
problem I can apply the fix(es) which might be related before spending a 
lot of time chasing the problem.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
