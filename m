Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVAER3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVAER3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVAER3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:29:06 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:54199 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262509AbVAER1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:27:40 -0500
Message-ID: <41DC2386.9010701@namesys.com>
Date: Wed, 05 Jan 2005 09:27:34 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       vs <vs@thebsh.namesys.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>
Subject: Re: 2.6.10-mm1
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org>
In-Reply-To: <20050103114854.GA18408@infradead.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>> reiser4-export-inode_lock.patch
>>    
>>
>
>Han,s how'as the work progressing on removing these and other fishy
>core changes?
>  
>
Vladimir is writing code to reduce the number of patches needed.  This 
code is causing bugs that have not yet been fixed.  His email is not 
working today, hopefully it will work tomorrow.  This is the russian 
holiday season....

>  
>
>> reiser4-unstatic-kswapd.patch
>>    
>>
>
>Andrew, could you please finally drop this one?  It's not needed for
>reiser4 operation at all just for some of their stranger debugging
>features.
>  
>
I'll let vs comment.

>  
>
>> 
>> reiser4-include-reiser4.patch
>>    
>>
>
>What about moving fs/Kconfig.reiser4 to fs/reiser4/Kconfig?  This is
>the logical place for it and makes dropping in a new version of the fs
>easier.
>  
>
Ok.

>  
>
>> reiser4-only.patch
>>    
>>
>
>Documentation shouldn't be in fs/FOO/doc but Documentation/filesystems/.
>  
>
Ok.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
What are the other ones you object to?
