Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSILLgS>; Thu, 12 Sep 2002 07:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSILLgS>; Thu, 12 Sep 2002 07:36:18 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:36875 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S315406AbSILLgR>; Thu, 12 Sep 2002 07:36:17 -0400
Message-ID: <3D807D4E.9040205@namesys.com>
Date: Thu, 12 Sep 2002 15:41:02 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Performance differences in recent kernels
References: <20020912034521.GA5984@rushmore>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:

>>    
>>
>Will there be a choice of mounting reiserfs
>or reiser4?  (like ext2 or ext3), or will there
>be a complete departure?  
>
>  
>

reiser4 is a completely different filesystem type for mount.  It is 
possible someone may sponsor making reiser4 plugins that understand 
reiser3 disk format, but I cannot ask DARPA to pay for that, because 
their mission is research not code maintenance.

ReiserFS will become an old, stable, unchanging except in response to 
VFS changes, filesystem.  This is a good thing.  Users need something 
that just works.  reiser3 is done.   It works.  After 2.4.21 ships it 
will be time to stop disturbing the users with changes to it.

reiser4 on the other hand will be the focal point of efforts to counter 
Microsoft's OFS, and the performance will increase every month or so, 
and new plugins will appear, and you'll have things like inheritance, 
encryption, compression, and eventually key word indexing.... but we'll 
increment the major version number when key word indexing goes in....

The nice thing about reiser4 is that the disk format is so plugin based 
that we can accomodate all future changes by just adding more plugins 
for it to understand.  Hmmm.  Maybe I should not put the 4 in the 
filesystem type name.  I'll have to think about that.

