Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVBQV7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVBQV7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 16:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVBQV7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 16:59:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:20404 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261202AbVBQV7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 16:59:15 -0500
Message-ID: <421512C8.9010304@sgi.com>
Date: Thu, 17 Feb 2005 15:55:20 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix : ioc4 serial driver support
References: <20050103140938.GA20070@infradead.org> <20050207162525.GA15926@infradead.org> <4208EE3A.6010500@sgi.com> <200502101109.43455.jbarnes@engr.sgi.com> <20050210191525.GA11284@infradead.org> <420BCD23.9080808@sgi.com>
In-Reply-To: <420BCD23.9080808@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Since there don't seem to be any more suggestions, can you take this - or at least queue it up ???

This is a resend:

I updated again with more __iomem tags.

ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support

Signed-off-by: Patrick Gefre <pfg@sgi.com>




> 
> Christoph Hellwig wrote:
> 
>> On Thu, Feb 10, 2005 at 11:09:43AM -0800, Jesse Barnes wrote:
>>
>>> On Tuesday, February 8, 2005 8:52 am, Patrick Gefre wrote:
>>>
>>>> I've update the patch with changes from the comments below.
>>>>
>>>> ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support
>>>>
>>>> Christoph Hellwig wrote:
>>>>
>>>>> On Mon, Feb 07, 2005 at 09:58:33AM -0600, Patrick Gefre wrote:
>>>>>
>>>>>> Latest version with review mods:
>>>>>> ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support
>>>>>
>>>>>
>>>>> - still not __iomem annotations.
>>>>
>>>>
>>>> I *think* I have this right ??
>>>
>>>
>>> Here's the output from 'make C=1' with your driver patched in (you if 
>>> you want
>>> to run it yourself, just copy tomahawk.engr:~jbarnes/bin/sparse to 
>>> somewhere
>>> in your path and run 'make C=1').  I think most of these warning 
>>> would be
>>> fixed up if the structure fields referring to registers were declared as
>>> __iomem, but I haven't looked carefully.
>>
>>
>>
>> Actually the pointers to the struct need to be declared __iomem.  
> 
> 
