Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUD2SGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUD2SGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUD2SGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:06:00 -0400
Received: from mail.fastclick.com ([205.180.85.17]:55235 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S264903AbUD2SFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:05:54 -0400
Message-ID: <409143F6.3050300@fastclick.com>
Date: Thu, 29 Apr 2004 11:05:42 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: brettspamacct@fastclick.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com>	<20040428170106.122fd94e.akpm@osdl.org>	<40904FD8.7020208@fastclick.com> <20040428181319.601decfc.akpm@osdl.org> <40905A5E.5000807@fastclick.com>
In-Reply-To: <40905A5E.5000807@fastclick.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett E. wrote:

> Andrew Morton wrote:
> 
>> "Brett E." <brettspamacct@fastclick.com> wrote:
>>
>>>> I see no swapout from the info which you sent.
>>>
>>>
>>> pgpgout/s gives the total number of blocks paged out to disk per 
>>> second, it peaks at 13,000 and hovers around 3,000 per the attachment.
>>
>>
>>
>> Nope.  pgpgout is simply writes to disk, of all types.
> 
> That is what is confusing me.. From the sar man page:
> 
> pgpgin/s
>     Total number of kilobytes the system paged in from disk per second.
> 
> pgpgout/s
>     Total number of kilobytes the system paged out to disk per second.
> 
> 
Anyone know what I should believe?  Sar's pgpgin/s and pgpgout/s tell me 
  that it is paging in/out from/to disk.  Yet pswpin/s and pswpout/s are 
both 0.  Swapping and paging are the same thing I believe. pgpgin/out 
refer to paging, pswpin/out refer to swapping.  So I for one am confused.

I guess I could dig through the source but I figured someone might have 
encountered this disrepency in the past.


