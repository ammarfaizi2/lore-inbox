Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293181AbSCFEU5>; Tue, 5 Mar 2002 23:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSCFEUg>; Tue, 5 Mar 2002 23:20:36 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:19099 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S293181AbSCFEU1>;
	Tue, 5 Mar 2002 23:20:27 -0500
Message-ID: <3C859909.30602@candelatech.com>
Date: Tue, 05 Mar 2002 21:20:25 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: a faster way to gettimeofday?
In-Reply-To: <Pine.LNX.4.44.0203051955090.1475-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Davide Libenzi wrote:

> On Tue, 5 Mar 2002, Ben Greear wrote:
> 
> 
>>I have a program that I very often need to calculate the current
>>time, with milisecond accuracy.  I've been using gettimeofday(),
>>but gprof shows it's taking a significant (10% or so) amount of
>>time.  Is there a faster (and perhaps less portable?) way to get
>>the time information on x86?  My program runs as root, so should
>>have any permissions it needs to use some backdoor hack if that
>>helps!
>>
> 
> If you're on x86 you can use collect rdtsc samples and convert them to ms.
> You'll get even more then ms accuracy.


Can I do this from user space?  If so, any examples or docs
you can point me to?

Also, I'm looking primarily for a speed increase, not an accuracy
increase.

Thanks for the response!

Ben


> 
> 
> 
> 
> - Davide
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


