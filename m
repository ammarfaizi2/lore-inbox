Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265308AbUEZLTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265308AbUEZLTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265480AbUEZLTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:19:44 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:57455 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265308AbUEZLTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:19:43 -0400
Message-ID: <40B47D4C.6050206@yahoo.com.au>
Date: Wed, 26 May 2004 21:19:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk> <40B467DA.4070600@yahoo.com.au> <20040526101001.GA13426@citd.de> <40B47278.6090309@yahoo.com.au> <20040526105837.GA13810@citd.de>
In-Reply-To: <20040526105837.GA13810@citd.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> On Wed, May 26, 2004 at 08:33:28PM +1000, Nick Piggin wrote:
> 
>>Matthias Schniedermeyer wrote:
>>

>>>In my personal machine i have 3GB of RAM and i regularly create
>>>DVD-ISO-Images (about 2 per day). After creating an image (reading up to
>>>4,4GB and writing up to 4,4GB) the cache is 100% trashed(1). With swap
>>>it would be even more trashed then it is without swap(1).
>>>
>>
>>I don't disagree that you could find a situation where swap
>>is worse than no swap. I don't understand what you mean by
>>trashed and more trashed though :)
> 
> 
> trashed means "everything i need(tm)" is paged out (mozilla/konsole/xine
> ...)
> 
> with swap the data-part of running programs was swapped out, without
> swap only the program-part is thrown out of memory as the data-part
> can't be moved anywhere else.
> 
> I have a 10KPRM SCSI-HDD, i can here what my system is doing. :-)
> 

OK, this is obviously bad. Do you get this behaviour with 2.6.5
or 2.6.6? If so, can you strace the program while it is writing
an ISO? (just send 20 lines or so). Or tell me what program you
use to create them and how to create one?

Thanks
