Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSHJTUc>; Sat, 10 Aug 2002 15:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSHJTUc>; Sat, 10 Aug 2002 15:20:32 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:32263 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S317264AbSHJTUb>; Sat, 10 Aug 2002 15:20:31 -0400
Message-ID: <3D556821.3080807@namesys.com>
Date: Sat, 10 Aug 2002 23:23:13 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Oleg Drokin <green@namesys.com>, lkml <linux-kernel@vger.kernel.org>,
       reiserfs-dev@namesys.com, "Gryaznova E." <grev@namesys.botik.ru>
Subject: Re: [patch 7/12] use atomic kmaps in generic_file_write
References: <3D5464E8.28CA1AF4@zip.com.au> <20020810170756.A975@namesys.com> <3D5566DB.22EB0BA4@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Oleg Drokin wrote:
>  
>
>>Hello!
>>
>>On Fri, Aug 09, 2002 at 05:57:12PM -0700, Andrew Morton wrote:
>>
>>    
>>
>>>I made a bit of a mess of reiserfs.  It works OK, but I suspect it's
>>>performing unnecessary kmaps.
>>>      
>>>
>>We have reviewed the fs/reiserfs/inode.c change you proposed and we think
>>that patch below should be applied instead of it.
>>    
>>
>
>OK, thanks - shall do.
>
>  
>
>>Unfortunatelly we were not able to test it as 2.5.30 + your patches
>>locks up even before it have a chance to go to login prompt (and to even
>>touch reiserfs code, since I was booting off ext2 partition).
>>    
>>
>
>That's strange - that code has been under test by myself and
>several others for a week or two.
>
>  
>
Elena, can you test it and see if you have trouble also?

-- 
Hans



