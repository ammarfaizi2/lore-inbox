Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUFBRxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUFBRxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUFBRwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:52:04 -0400
Received: from mail.timesys.com ([65.117.135.102]:30773 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S263777AbUFBRvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:51:39 -0400
Message-ID: <40BE1399.2080908@timesys.com>
Date: Wed, 02 Jun 2004 13:51:21 -0400
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: benh@kernel.crashing.org
Subject: Re: [PATCH] OProfile driver in 2.6
References: <hhwu2qs4eq.fsf@alsvidh.mathematik.uni-muenchen.de> <20040602155056.GG15195@smtp.west.cox.net> <20040602183720.GC385@zaniah>
In-Reply-To: <20040602183720.GC385@zaniah>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2004 17:39:12.0437 (UTC) FILETIME=[845A0E50:01C448C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Elie wrote:

>On Wed, 02 Jun 2004 at 08:50 +0000, Tom Rini wrote:
>
>  
>
>>On Wed, Jun 02, 2004 at 11:19:41AM +0200, Jens Schmalzing wrote:
>>
>>    
>>
>>>Hi,
>>>
>>>I noticed that the driver for the OProfile profiling system, which
>>>existed in the linuxppc-2.5-benh tree, is disabled in the mainline,
>>>even though the driver still exists.  Is there a reason for this?  The
>>>attached patch re-enables the driver.
>>>      
>>>
>>Because it has never been picked up, aside from when Ben took it into
>>his tree (assuming this is the patch Anton wrote a while back, and not
>>a re-write Ben did).  BTW, this is missing a hunk I think, unless the
>>arch/ppc/kernel/time.c changes have already made it in.
>>    
>>
>
>Right there is a missing call to profile_hook(regs); in ppc_do_profile()
>  
>
The patch I've been using for ppc oprofile is archived here.
http://www.cs.helsinki.fi/linux/linux-kernel/2003-09/1228.html

I've always wondered why it never got picked up.

Greg Weeks
