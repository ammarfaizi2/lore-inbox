Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265345AbSKABuB>; Thu, 31 Oct 2002 20:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265374AbSKABuA>; Thu, 31 Oct 2002 20:50:00 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:1298 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S265345AbSKABt4>;
	Thu, 31 Oct 2002 20:49:56 -0500
Message-ID: <3DC1DF02.7060307@namesys.com>
Date: Fri, 01 Nov 2002 04:55:14 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Oleg Drokin <green@namesys.com>, zam@namesys.com,
       umka <umka@thebsh.namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
References: <3DC19F61.5040007@namesys.com> <200210312334.18146.Dieter.Nuetzel@hamburg.de> <3DC1B2FA.8010809@namesys.com> <3DC1D63A.CCAD78EF@digeo.com> <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com>
In-Reply-To: <3DC19F61.5040007@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser wrote:
>  
>
>>Well, if we are only 2.5 times as fast for writes as ext3 after your
>>patch is applied, I'll still feel good.;-)
>>
>>    
>>
>
>whupping ext3's butt on write performance isn't very hard, really ;)
>
>But it should be done based on "feature equivalency".  By default,
>ext3 uses ordered data writes.  Data is written to disk before
>the metadata to which that data refers is committed to journal.
>
>It would be questionable to compare a metadata-only journalling
>approach to ext3 with data=journal or data=ordered.
>
>
>
>  
>
The atomic transactions that reiser4 offers are a much higher level of 
data security than data journaling.  Really, you should read the 17 page 
papers I send you URLs to;-).....
(www.namesys.com/v4/fast_reiser4.html).

-- 
Hans


