Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284958AbRLFDmg>; Wed, 5 Dec 2001 22:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284959AbRLFDm0>; Wed, 5 Dec 2001 22:42:26 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:4362 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284958AbRLFDmR>; Wed, 5 Dec 2001 22:42:17 -0500
Message-ID: <3C0EE8DD.3080108@namesys.com>
Date: Thu, 06 Dec 2001 06:41:17 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't comment on your benchmarks because I was on the way to bed when 
I read this.  I am sure though that you and Stephen are doing your usual 
good programming.

ReiserFS is an Htree by your definition in your paper, yes?

Daniel Phillips wrote:

>
>Curiously, Reiserfs actually depends on the spelling of the filename for a 
>lot of its good performance.  Creating files with names that don't follow a 
>lexigraphically contiguous sequence produces far different results:
>
>   http://people.nl.linux.org/~phillips/htree/indexed.vs.classic.vs.reiser.10x10000.create.random.jpg
>
>So it seems that for realistic cases, ext2+htree outperforms reiserfs quite 
>dramatically.  (Are you reading, Hans?  Fighting words... ;-)
>

Have you ever seen an application that creates millions of files create 
them in random order?  Almost always there is some non-randomness in the 
order, and our newer hash functions are pretty good at preserving it. 
 Applications that create millions of files are usually willing to play 
nice for an order of magnitude performance gain also.....


I have shared your kpresenter troubles:-)....

Hans




