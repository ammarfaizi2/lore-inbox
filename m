Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTIIUKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTIIUKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:10:10 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:59084 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264466AbTIIUJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:09:53 -0400
Message-ID: <3F5E338F.2000007@wmich.edu>
Date: Tue, 09 Sep 2003 16:09:51 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: atapi write support? No
References: <3F5E2BA4.60704@wmich.edu> <20030909195428.GQ4755@suse.de>
In-Reply-To: <20030909195428.GQ4755@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Sep 09 2003, Ed Sweetman wrote:
> 
>>Is anyone able to actually use the atapi write support present in the 
>>later cdrecord releases?  2.6 can't seem to work with it at all.  Is 
> 
> 
> Based on the clues you pass above, noone can help you. What are you
> trying to do and how? What kernel version? What cdrecord version?

There is no other information needed. By use atapi write support i mean 
Get it to do anything besides error out reporting that it cant access 
the drive. If you can query the drive much less actually write anything 
to it using the ATAPI interface than that's more than i've been able to do.

for example   cdrecord dev=ATAPI:1,0,0 checkdisk

1,0,0 should conform to secondary channel master as this is how devfs 
sets the cdr up too.

kernel version, if you look above it's 2.6, but for the sake of 
comparison, test4 or test5 with or without mm patches.

cdrecord version: atapi support was introduced with 2.0 but again, for 
the sake of comparison, anything after a13.



> 
>>this due to the kernel being broken or cdrecord not being up to date 
>>with 2.6 semantics?
> 
> 
> I'll polish my crystal ball and let you know!
> 


