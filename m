Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSKABYR>; Thu, 31 Oct 2002 20:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265552AbSKABXu>; Thu, 31 Oct 2002 20:23:50 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:28430 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265261AbSKABWN>; Thu, 31 Oct 2002 20:22:13 -0500
Message-ID: <3DC1D885.6030902@namesys.com>
Date: Fri, 01 Nov 2002 04:27:33 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Reiserfs-List@namesys.com,
       Oleg Drokin <green@namesys.com>, zam@namesys.com,
       umka <umka@thebsh.namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
References: <3DC19F61.5040007@namesys.com> <200210312334.18146.Dieter.Nuetzel@hamburg.de> <3DC1B2FA.8010809@namesys.com> <3DC1D63A.CCAD78EF@digeo.com>
In-Reply-To: <3DC19F61.5040007@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser wrote:
>  
>
>>Green and Zam and Umka, on Monday please start work on seriously
>>analyzing how the block allocation differs between the new and the old
>>kernel, now that you can finally reproduce the benchmark on the old kernel.
>>    
>>
>
>I just sent the Orlov allocator patch to Linus.  It will double or
>triple ext2 performance in that test, so please make sure you compare
>against the latest.  There's a copy at
>http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.45/shpte-stuff/broken-out/orlov-allocator.patch
>
>We can expect similar gains for ext3, when that's done.
>
>(The 2x-3x is on an 8meg filesystem.  Larger filesystems should
>gain more)
>
>
>  
>
Well, if we are only 2.5 times as fast for writes as ext3 after your 
patch is applied, I'll still feel good.;-)  

Better benchmarks will be conducted during the next 3 months, the ones 
we have are still a bit raw....

-- 
Hans


