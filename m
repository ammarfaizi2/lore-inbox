Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281506AbRKUNlC>; Wed, 21 Nov 2001 08:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281381AbRKUNkw>; Wed, 21 Nov 2001 08:40:52 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:62983 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S281050AbRKUNkn>; Wed, 21 Nov 2001 08:40:43 -0500
Message-ID: <3BFBAE86.70100@namesys.com>
Date: Wed, 21 Nov 2001 16:39:18 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christian =?ISO-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
CC: Eric M <ground12@jippii.fi>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
In-Reply-To: <6893478.1006329318464.JavaMail.ground12@jippii.fi> <E166Tv4-0001Y9-00@mrvdom00.schlund.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:

>>FAT: bogus logical sector size 0
>>
>
>It is not a problem at all.
>
>It happens if you compile fat in the Kernel and not as module. In this case 
>the fat-driver seems to check every partition for a fat-filesystem. When it 
>fails it gives you this message. 
>
>So you can 
>1. ignore these messages or
>2. compile fat as a module.
>
>greetings
>
>Christian
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
It is a user interface error by the FAT coder, a serious one actually, 
because it affects partitions that are not FAT.  Would be nice if it got 
fixed.

Hans


