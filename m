Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293142AbSBWPBM>; Sat, 23 Feb 2002 10:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293143AbSBWPBD>; Sat, 23 Feb 2002 10:01:03 -0500
Received: from [195.63.194.11] ([195.63.194.11]:8467 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293142AbSBWPAt>;
	Sat, 23 Feb 2002 10:00:49 -0500
Message-ID: <3C77AE77.9020300@evision-ventures.com>
Date: Sat, 23 Feb 2002 16:00:07 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Larry McVoy <lm@bitmover.com>, Justin Piszcz <war@starband.net>,
        linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
In-Reply-To: <3C771D29.942A07C2@starband.net>,		<3C771D29.942A07C2@starband.net>; from war@starband.net on Fri, Feb 22, 2002 at 11:40:09PM -0500 <20020222204456.O11156@work.bitmover.com> <3C77270A.1CBA02E8@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Larry McVoy wrote:
> 
>>Try 2.72, it's almost twice as fast as 2.95 for builds.  For BK, at least,
>>we don't see any benefit from the slower compiler, the code runs the same
>>either way.
>>
>>
> 
> Amen.
> 
> I want 2.7.2.3 back, but it was the name:value struct initialiser
> bug which killed that off.  2.91.66 isn't much slower than 2.7.x,
> and it's what I use.
> 
> "almost twice as fast"?  That means that 2.7.2 vs 3.x is getting
> up to a 3x difference.  Does anyone know why?

Yes. Basically the reason is a missconception what the compiler
should try to optimize in GCC.

> 
> [ Of course, if you can wink-in the object file from someone else,
>   it's not a problem.  (tum, tee tum...) ]
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

