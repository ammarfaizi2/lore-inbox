Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTIIUTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTIIUTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:19:34 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:18259 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264498AbTIIURk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:17:40 -0400
Message-ID: <3F5E33D2.7070103@rackable.com>
Date: Tue, 09 Sep 2003 13:10:58 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sleeping function called from invalid context
References: <3F5DEBA5.9060607@rackable.com> <20030909194727.GI31897@waste.org>
In-Reply-To: <20030909194727.GI31897@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2003 20:17:39.0397 (UTC) FILETIME=[6AA5C750:01C3770F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>On Tue, Sep 09, 2003 at 08:03:01AM -0700, Samuel Flory wrote:
>  
>
>> I'm seeing this on arjanv's 2.6.0-0.test4.1.33 kernel.
>>    
>>
>
>  
>
>>Debug: sleeping function called from invalid context at 
>>include/asm/uaccess.h:473
>>Call Trace:
>>[<c011b7dd>] __might_sleep+0x5d/0x70
>>[<c010d0ea>] save_v86_state+0x6a/0x200
>>    
>>
>
>It's a warning about the possibility of hitting a very old but rarely
>hit bug, system should work the same as it always has despite the
>warning. I'm working on this, but it's ugly. Hope to post a patch in
>the next week or so.
>
>  
>

  That's good to know.  I was actually running for at least a on an 
older kernel before i noticed in in dmesg.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


