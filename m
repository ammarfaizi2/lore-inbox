Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbTIIWEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTIIWEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:04:35 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:12464 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264502AbTIIWEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:04:32 -0400
Message-ID: <3F5E4E6E.1070806@wmich.edu>
Date: Tue, 09 Sep 2003 18:04:30 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Markus Plail <linux-kernel@gitteundmarkus.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: atapi write support? No
References: <3F5E2BA4.60704@wmich.edu> <20030909195428.GQ4755@suse.de>	<3F5E338F.2000007@wmich.edu> <87brttemlk.fsf@gitteundmarkus.de>
In-Reply-To: <87brttemlk.fsf@gitteundmarkus.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Plail wrote:
> On Tue, 09 Sep 2003, Ed Sweetman wrote:
> 
> 
>>Jens Axboe wrote: 
>>
>>>On Tue, Sep 09 2003, Ed Sweetman wrote:
>>
>>There is no other information needed.
> 
> 
> There is...

You seemed to get it without any more.

> 
>>By use atapi write support i mean Get it to do anything besides error
>>out reporting that it cant access the drive. If you can query the
>>drive much less actually write anything to it using the ATAPI
>>interface than that's more than i've been able to do.
>>
>>for example   cdrecord dev=ATAPI:1,0,0 checkdisk
> 
> 
> ATAPI: is most likely wrong for what you want to do. It's meant for
> notebooks (PCATA or something).
> If you just want to get rid of ide-scsi, you have to use dev=/dev/hdX in
> cdrecord.

this method states that the method of access is unsupported and 
unintentional.  Which is why i didn't think that it was the right way to 
use cdrecord on atapi devices without ide-scsi.


> regards
> Markus
> 
> PS: A little change in attitude towards people who are willing to help
> you wouldn't be the worst idea. IMHO of course.
> 

If you make what is a general question too specific with details you 
limit your responses if anyone thinks their response is correct for you 
anyway.  I limited my question as much as i wanted to, with the desired 
effect no less.


apparently cdrecord's documention is a little behind it's code. Now 
tracking down why it seems to be botching audio cds for me would require 
a full bugreport style mail now that i know cdrecord is being used in 
the correct manner.

