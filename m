Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262846AbSJAVOF>; Tue, 1 Oct 2002 17:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262848AbSJAVOE>; Tue, 1 Oct 2002 17:14:04 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:16143 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262846AbSJAVOD>; Tue, 1 Oct 2002 17:14:03 -0400
Message-ID: <3D9A115D.8040003@namesys.com>
Date: Wed, 02 Oct 2002 01:19:25 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, god@thebsh.namesys.com
Subject: Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
References: <20021001195914.GC6318@stingr.net> <20021001204330.GO3000@clusterfs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>  
>
> It looks like
>reiserfs is nearly CPU-bound by the tests, so it is unlikely that they
>can run much faster.  
>
Um, usually being CPU bound is easier to fix.  We have probably not CPU 
profiled this code path, and after Halloween we probably should (but for 
reiser4, since reiser3 is soon to be obsoleted).  It is being IO bound 
that is usually hard to fix, though since I haven't read the htree code 
I trust you that it is different in this case....

>In theory, ext3+htree run at the CPU time if we
>fixed the allocation and/or seeking issues.
>
>Cheers, Andreas
>--
>Andreas Dilger
>http://www-mddsp.enel.ucalgary.ca/People/adilger/
>http://sourceforge.net/projects/ext2resize/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



