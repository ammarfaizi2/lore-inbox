Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261831AbSJZCgO>; Fri, 25 Oct 2002 22:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbSJZCgN>; Fri, 25 Oct 2002 22:36:13 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:56071 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261831AbSJZCgN>; Fri, 25 Oct 2002 22:36:13 -0400
Message-ID: <3DBA0110.9020206@namesys.com>
Date: Sat, 26 Oct 2002 06:42:24 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: landley@trommello.org
CC: linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate
 list 1.6)
References: <200210251557.55202.landley@trommello.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

>Reiser4 is probably in this category as well, since Reiser3 went into
>the 2.4 stable series and Reiser4 claims to be a seperate filesystem
>(like EXT2 and EXT3).  Add in the fact that Hans Reiser still hasn't
>produced a patch yet, and the decision's pretty easy.  (If you disagree,
>yell out now...)
>
We will probably release a "very beta" not intended for inclusion on the 
27th, and ship a patch for inclusion on Halloween before midnight in 
some time zone.  

In the version we will ship on Sunday, reads are only 50% faster than 
ext2/3 for reading the linux kernel source tree.  We have an old kernel 
in which reads are 105% faster when reading one copy of the linux kernel 
tree.  The delay until Halloween is so that we can figure out why reads 
were faster in the old kernel, and hopefully make them 105% faster in 
the newest version of the code.

Not sure you want to ship a 3.0 without it.  It is 50-150% faster than 
V3, which makes it a significant competitive advantage.  I forget how 
much faster writes are, something well over 100% faster, and the newest 
version is faster yet.

How do I put it.  I'm the last straggler coming back from the hunt, and 
I've got what looks like it might be a wooly mammoth on my shoulders, 
and my tribesmen are complaining that I'm late for dinner.  How about 
helping me by cutting down a tree for the roasting spit instead?  Think 
thoughts of the poor hungry Microsoft tribe eating NTFS.

Think thoughts of Microsoft suits going into some corporate board room 
explaining that Windows is worth paying for because of the value add, 
and some guy in sandals in the back suggests that the company could 
replace all its 15k rpm SCSI hard drives with 5400rpm IDE drives, and 
Linux would still be much faster than using NTFS.

Think thoughts of Microsoft's OFS catching up to ext2 at long last 
(surely it will, with all the money they have spent to hire people), and 
then discovering Windows still offers negative value add filesystem 
performance-wise.

Oh, and it has features too, not just performance....

Hans

