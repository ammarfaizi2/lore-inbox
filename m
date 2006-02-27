Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWB0Vbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWB0Vbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWB0Vbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:31:47 -0500
Received: from mta3.srv.hcvlny.cv.net ([167.206.4.198]:23783 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750705AbWB0Vbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:31:47 -0500
Date: Mon, 27 Feb 2006 16:31:36 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 5/7]  synchronous block I/O delays
In-reply-to: <p73fym428cf.fsf@verdi.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Message-id: <44036FB8.1090503@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1141026996.5785.38.camel@elinux04.optonline.net>
 <1141028448.5785.64.camel@elinux04.optonline.net>
 <p73fym428cf.fsf@verdi.suse.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Shailabh Nagar <nagar@watson.ibm.com> writes:
>
>  
>
>>delayacct-blkio.patch
>>
>>Record time spent by a task waiting for completion of 
>>userspace initiated synchronous block I/O. This can help
>>determine the right I/O priority for the task.
>>    
>>
>
>I think it's a good idea to have such a statistic by default.
>
>Can you add a counter that is summed up in task_struct and reports
>in /proc/*/stat so that it could be displayed by top? 
>  
>
Sure. That would make delayacct code simpler too since it could just 
read off from task_struct.

>This way it would be useful even with "normal" user space.
>  
>
Yes. Need to resolve the multiple entry point semantic...more in 
separate mail.

--Shailabh

>-Andi
>  
>

