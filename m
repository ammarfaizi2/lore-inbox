Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318766AbSHQXBr>; Sat, 17 Aug 2002 19:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSHQXBr>; Sat, 17 Aug 2002 19:01:47 -0400
Received: from wotug.org ([194.106.52.201]:62266 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S318766AbSHQXBq>;
	Sat, 17 Aug 2002 19:01:46 -0400
Date: Sun, 18 Aug 2002 00:03:24 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Dax Kelson <dax@gurulabs.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Does Solaris really scale this well?
In-Reply-To: <20020817182715.GC32427@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0208172358460.3111-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2002, Matti Aarnio wrote:

>On Sat, Aug 17, 2002 at 11:53:16AM -0600, Dax Kelson wrote:
>> From:
>>   http://www.itworld.com/Man/3828/020816mcnealy/
>> 
>> Scott McNealy:
>> 
>> "When you take a 99-way UltraSPARC III machine and add a 100th processor, 
>> you get 94 percent linear scalability. You can't get 94 percent linear 
>> scalability on your first Intel chip. It's very, very hard to do, and they 
>> have not done it."
>
>  Conditionally...  I would like to know the exact architecture,
>and the problem set running in the system to say.
>
>When you have noncc-NUMA, you have a Beowulf-like setup.
>when you have cc-NUMA ("cc" = cache coherent), things get
>truly hairy...

I've seen scientific reports of scalability that good in non-shared memory
computers (mostly in transputer arrays) where (with a scalable algorithm)
unless you got >90% you were doing something wrong.  However, if you insist on
sharing main memory, I still don't believe you can get anywhere near that...
IMO 30% is doing very well once past the first few CPUs.

Regards,

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

