Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265463AbUEZKdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUEZKdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbUEZKdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:33:42 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:45960 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265468AbUEZKdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:33:32 -0400
Message-ID: <40B47278.6090309@yahoo.com.au>
Date: Wed, 26 May 2004 20:33:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk> <40B467DA.4070600@yahoo.com.au> <20040526101001.GA13426@citd.de>
In-Reply-To: <20040526101001.GA13426@citd.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> On Wed, May 26, 2004 at 07:48:10PM +1000, Nick Piggin wrote:
> 
>>John Bradford wrote:
>>
>>>Quote from Nick Piggin <nickpiggin@yahoo.com.au>:
>>>
>>>
>>>>Even for systems that don't *need* the extra memory space, swap can
>>>>actually provide performance improvements by allowing unused memory
>>>>to be replaced with often-used memory.
>>>
>>>
>>>That's true, but it's not a magical property of swap space - extra physical
>>>RAM would do more or less the same thing.
>>>
>>
>>Well it is a magical property of swap space, because extra RAM
>>doesn't allow you to replace unused memory with often used memory.
>>
>>The theory holds true no matter how much RAM you have. Swap can
>>improve performance. It can be trivially demonstrated.
> 
> 
> The other way around can be "demonstrated" equally trivially.
> 
> In my personal machine i have 3GB of RAM and i regularly create
> DVD-ISO-Images (about 2 per day). After creating an image (reading up to
> 4,4GB and writing up to 4,4GB) the cache is 100% trashed(1). With swap
> it would be even more trashed then it is without swap(1).
> 

I don't disagree that you could find a situation where swap
is worse than no swap. I don't understand what you mean by
trashed and more trashed though :)

Creating your ISOs makes your system swap a lot when swap
is enabled?

> 
> 
> 
> 1: This has "always(tm)" been so since i began burning DVDs 3 years ago.
> Beginning from kernel 2.4.4-2.4.25 and 2.6.4-2.6.6. Currently i use 2.6.5. (This is no typo!)
> 
> I have only tested the "with swap"-case with 2.4.4 as i didn't use swap
> after 2.4.4 trashed so badly with swap enabled. But i don't think that
> things have changed so fundamentaly that the "with swap"-case is
> better(FOR ME!) than the "without swap"-case.
> 

The 2.6 VM has changed pretty fundamentally. It would be good
if you could retest.
