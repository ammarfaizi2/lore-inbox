Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261564AbSIZVmb>; Thu, 26 Sep 2002 17:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261565AbSIZVmb>; Thu, 26 Sep 2002 17:42:31 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:6148 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S261564AbSIZVmb>;
	Thu, 26 Sep 2002 17:42:31 -0400
Message-ID: <3D938084.6040105@namesys.com>
Date: Fri, 27 Sep 2002 01:47:48 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.38 - Config.in: Second extended fs rename / move
 Ext3 to a wiser place
References: <200209261944.23447.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:

>
>I also thought about splitting the "Journal Filesystems" into an extra menu 
>option just to clear up the whole menu a bit since we have: ReiserFS, Ext3, 
>XFS, JFS, JFFS and JFFSv2. I cooked up a patch which does it, also attached!
>
>  
>

I don't think it is very significant that ReiserFS version 3 is a 
journaling file system in the long term (though it did matter a lot in 
2.4), and Reiser4 is arguably not a journaling file system, but rather a 
wandering log filesystem, so I think that such a categorization is not a 
good one.  

I think that journaling is only a transitory differentiator, and only a 
differentiator vs. ext2.  It would make more sense to call ext2 "Ext2 
(obsolete, requires long waits for fsck after crashes )", and then users 
can decide for themselves who obsoleted it first.;-)

Hans

