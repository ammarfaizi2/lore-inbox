Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTLJTy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbTLJTy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:54:58 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:24992 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263923AbTLJTy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:54:56 -0500
Message-ID: <3FD77A0E.7000909@namesys.com>
Date: Wed, 10 Dec 2003 22:54:54 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vitaly Fertman <vitaly@namesys.com>
CC: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org
Subject: Re: forwarded message from Jan De Luyck
References: <16343.2023.525418.637117@laputa.namesys.com> <200312101604.15299.vitaly@namesys.com>
In-Reply-To: <200312101604.15299.vitaly@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Fertman wrote:

>Hello, 
>
>  
>
>>Hello,
>>
>>Today I discovered this in my syslogs, after something strange
>>happening to XFree86 (hung at startup, then dumped me back to the console)
>>
>>is_leaf: free space seems wrong: level=1, nr_items=41, free_space=65224
>>rdkey vs-5150: search_by_key: invalid format found in block 283191. Fsck?
>>vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find
>>stat data of [11 12795 0x0 SD] is_leaf: free space seems wrong: level=1,
>>nr_items=41, free_space=65224 rdkey vs-5150: search_by_key: invalid format
>>found in block 283191. Fsck? vs-13070: reiserfs_read_locked_inode: i/o
>>failure occurred trying to find stat data of [11 12798 0x0 SD]
>>    
>>
>
>this all about fs corruptions. fsck is needed.
>  
>
is this a failure due to bad sector on the drive?

>  
>
>>I've never seen these before, and I've been digging through my syslogs but
>>am unable to find any other references of this.
>>Does this mean the disk is dying? Or just the filesystem is corrupt?
>>Unfortunately, I'm not able to rebuild the tree at this time because I
>>haven't got a 'rescue' disk with me and the errors are on my root
>>partition...
>>
>>Any other pointers?
>>    
>>
>
>reiserfsck from the 3.6.12-pre1 package is able to recover mounted ro 
>partitions.
>
>--
>Thanks,
>Vitaly Fertman
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans


