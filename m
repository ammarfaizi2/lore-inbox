Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbTLRKlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 05:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTLRKlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 05:41:23 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:33723 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265060AbTLRKlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 05:41:20 -0500
Message-ID: <3FE1844E.9070700@namesys.com>
Date: Thu, 18 Dec 2003 13:41:18 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: jshankar <jshankar@CS.ColoState.EDU>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 file system
References: <3FE23273@webmail.colostate.edu> <20031218083957.GA6438@matchmail.com>
In-Reply-To: <20031218083957.GA6438@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

>On Wed, Dec 17, 2003 at 09:47:59PM -0700, jshankar wrote:
>  
>
>>Hello Hans,
>>
>>    
>>
>>>Filesystems don't usually wait on the IO to complete before submitting
>>>more IO in response to the next write() syscall.  They can do this by
>>>batching a whole bunch of operations into one committed transaction.
>>>
>>>      
>>>
>>Is there a timeout mechanism for batching operations.
>>
At some point due to its age or size you decide the batch needs to commit.

>> What if certain 
>>operation
>>is done after the batch operation is executed. Does it mean that the new 
>>operation has to wait.
>>    
>>
>
>You don't have to wait unless you run out of available non-dirty memory, or
>issue a call to sync to the disks.
>
>
>  
>


-- 
Hans


